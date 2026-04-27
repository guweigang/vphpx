module main

import time
import vphp

struct VSlimReservedJob {
	id           i64
	queue        string
	job_class    string
	payload_json string
	attempts     int
	max_attempts int
}

fn job_params_box(params []string) vphp.RequestOwnedZBox {
	return database_string_params_box(params)
}

fn job_exec_params(mut db &VSlimDatabaseManager, statement string, params []string) bool {
	mut box := job_params_box(params)
	defer {
		box.release()
	}
	mut result := db.execute_params(statement, box.borrowed())
	defer {
		result.release()
	}
	return db.last_error_message() == ''
}

fn job_query_one_params(mut db &VSlimDatabaseManager, statement string, params []string) vphp.RequestOwnedZBox {
	mut box := job_params_box(params)
	defer {
		box.release()
	}
	return db.query_one_params(statement, box.borrowed())
}

fn job_now_worker_id() string {
	return 'vslim-' + time.now().unix_milli().str()
}

fn job_reserved_from_row(row vphp.ZVal) ?VSlimReservedJob {
	if !row.is_valid() || row.is_null() || row.is_undef() {
		return none
	}
	id := i64(zval_int_key(row, 'id', 0))
	job_class := zval_string_key(row, 'job_class', '')
	if id <= 0 || job_class == '' {
		return none
	}
	return VSlimReservedJob{
		id: id
		queue: zval_string_key(row, 'queue', 'default')
		job_class: job_class
		payload_json: zval_raw_string_key(row, 'payload_json', '{}')
		attempts: zval_int_key(row, 'attempts', 0)
		max_attempts: zval_int_key(row, 'max_attempts', 1)
	}
}

fn job_dispatcher_manager_or_throw(dispatcher &VSlimJobDispatcher) ?&VSlimDatabaseManager {
	if dispatcher.manager_ref == unsafe { nil } {
		vphp.PhpException.raise_class('RuntimeException', 'job dispatcher database manager is not configured',
			0)
		return none
	}
	return dispatcher.manager_ref
}

fn job_worker_manager_or_throw(worker &VSlimJobWorker) ?&VSlimDatabaseManager {
	if worker.manager_ref == unsafe { nil } {
		vphp.PhpException.raise_class('RuntimeException', 'job worker database manager is not configured',
			0)
		return none
	}
	return worker.manager_ref
}

@[php_method]
pub fn (mut dispatcher VSlimJobDispatcher) construct() &VSlimJobDispatcher {
	return &dispatcher
}

@[php_method: 'setManager']
pub fn (mut dispatcher VSlimJobDispatcher) set_manager(manager &VSlimDatabaseManager) &VSlimJobDispatcher {
	dispatcher.manager_ref = manager
	return &dispatcher
}

@[php_method]
pub fn (dispatcher &VSlimJobDispatcher) manager() &VSlimDatabaseManager {
	return dispatcher.manager_ref
}

@[php_method]
@[php_arg_name: 'job_class=jobClass,delay_seconds=delaySeconds,max_attempts=maxAttempts']
pub fn (mut dispatcher VSlimJobDispatcher) dispatch(job_class string, payload vphp.RequestBorrowedZBox, queue string, delay_seconds int, max_attempts int) i64 {
	clean_class := job_class.trim_space()
	if clean_class == '' {
		vphp.PhpException.raise_class('InvalidArgumentException', 'job class must not be empty', 0)
		return 0
	}
	if !vphp.PhpClass.named(clean_class).exists() {
		vphp.PhpException.raise_class('InvalidArgumentException', 'job class does not exist: ${clean_class}',
			0)
		return 0
	}
	mut db := job_dispatcher_manager_or_throw(dispatcher) or { return 0 }
	clean_queue := if queue.trim_space() == '' { 'default' } else { queue.trim_space() }
	attempt_limit := if max_attempts <= 0 { 3 } else { max_attempts }
	delay := if delay_seconds < 0 { 0 } else { delay_seconds }
	payload_json := vphp.PhpJson.encode(payload.to_zval())
	stored_payload := if payload_json == '' { 'null' } else { payload_json }
	ok := job_exec_params(mut db, 'INSERT INTO vslim_jobs (queue, job_class, payload_json, status, attempts, max_attempts, available_at, created_at, updated_at) VALUES (?, ?, ?, \'pending\', 0, ?, DATE_ADD(NOW(), INTERVAL ? SECOND), NOW(), NOW())',
		[clean_queue, clean_class, stored_payload, attempt_limit.str(), delay.str()])
	if !ok {
		return 0
	}
	return db.last_insert_id_value()
}

@[php_method]
pub fn (mut worker VSlimJobWorker) construct() &VSlimJobWorker {
	worker.worker_id = job_now_worker_id()
	return &worker
}

@[php_method: 'setManager']
pub fn (mut worker VSlimJobWorker) set_manager(manager &VSlimDatabaseManager) &VSlimJobWorker {
	worker.manager_ref = manager
	return &worker
}

@[php_method: 'setWorkerId']
@[php_arg_name: 'worker_id=workerId']
pub fn (mut worker VSlimJobWorker) set_worker_id(worker_id string) &VSlimJobWorker {
	clean := worker_id.trim_space()
	worker.worker_id = if clean == '' { job_now_worker_id() } else { clean }
	return &worker
}

@[php_method: 'workerId']
pub fn (worker &VSlimJobWorker) worker_id_value() string {
	return worker.worker_id
}

@[php_method: 'setRetryDelaySeconds']
pub fn (mut worker VSlimJobWorker) set_retry_delay_seconds(seconds int) &VSlimJobWorker {
	worker.retry_delay_seconds = if seconds < 0 { 0 } else { seconds }
	return &worker
}

@[php_method: 'setReserveTimeoutSeconds']
pub fn (mut worker VSlimJobWorker) set_reserve_timeout_seconds(seconds int) &VSlimJobWorker {
	worker.reserve_timeout_secs = if seconds <= 0 { 300 } else { seconds }
	return &worker
}

fn (mut worker VSlimJobWorker) release_stale_reserved(queue string) {
	mut db := job_worker_manager_or_throw(worker) or { return }
	clean_queue := if queue.trim_space() == '' { 'default' } else { queue.trim_space() }
	_ = job_exec_params(mut db, 'UPDATE vslim_jobs SET status = \'pending\', reserved_at = NULL, reserved_by = NULL, updated_at = NOW() WHERE queue = ? AND status = \'reserved\' AND reserved_at IS NOT NULL AND reserved_at < DATE_SUB(NOW(), INTERVAL ? SECOND)',
		[clean_queue, worker.reserve_timeout_secs.str()])
}

fn (mut worker VSlimJobWorker) reserve(queue string) ?VSlimReservedJob {
	mut db := job_worker_manager_or_throw(worker) or { return none }
	clean_queue := if queue.trim_space() == '' { 'default' } else { queue.trim_space() }
	worker.release_stale_reserved(clean_queue)
	mut row_box := job_query_one_params(mut db, 'SELECT id, queue, job_class, payload_json, attempts, max_attempts FROM vslim_jobs WHERE queue = ? AND status = \'pending\' AND available_at <= NOW() ORDER BY available_at ASC, id ASC LIMIT 1',
		[clean_queue])
	defer {
		row_box.release()
	}
	job := job_reserved_from_row(row_box.to_zval()) or { return none }
	ok := job_exec_params(mut db, 'UPDATE vslim_jobs SET status = \'reserved\', attempts = attempts + 1, reserved_at = NOW(), reserved_by = ?, updated_at = NOW() WHERE id = ? AND status = \'pending\' AND available_at <= NOW()',
		[worker.worker_id, job.id.str()])
	if !ok || db.affected_rows_value() == 0 {
		return none
	}
	return VSlimReservedJob{
		...job
		attempts: job.attempts + 1
	}
}

fn (mut worker VSlimJobWorker) complete(job VSlimReservedJob) bool {
	mut db := job_worker_manager_or_throw(worker) or { return false }
	return job_exec_params(mut db, 'UPDATE vslim_jobs SET status = \'completed\', completed_at = NOW(), reserved_at = NULL, reserved_by = NULL, last_error = NULL, updated_at = NOW() WHERE id = ?',
		[job.id.str()])
}

fn (mut worker VSlimJobWorker) fail_or_release(job VSlimReservedJob, message string) bool {
	mut db := job_worker_manager_or_throw(worker) or { return false }
	error_message := if message.trim_space() == '' { 'job failed' } else { message.trim_space() }
	if job.attempts >= job.max_attempts {
		ok := job_exec_params(mut db, 'UPDATE vslim_jobs SET status = \'failed\', failed_at = NOW(), reserved_at = NULL, reserved_by = NULL, last_error = ?, updated_at = NOW() WHERE id = ?',
			[error_message, job.id.str()])
		_ = job_exec_params(mut db, 'INSERT INTO vslim_failed_jobs (job_id, queue, job_class, payload_json, attempts, error_message, error_trace, failed_at, created_at) VALUES (?, ?, ?, ?, ?, ?, NULL, NOW(), NOW())',
			[job.id.str(), job.queue, job.job_class, job.payload_json, job.attempts.str(), error_message])
		return ok
	}
	return job_exec_params(mut db, 'UPDATE vslim_jobs SET status = \'pending\', reserved_at = NULL, reserved_by = NULL, available_at = DATE_ADD(NOW(), INTERVAL ? SECOND), last_error = ?, updated_at = NOW() WHERE id = ?',
		[worker.retry_delay_seconds.str(), error_message, job.id.str()])
}

fn (mut worker VSlimJobWorker) perform(job VSlimReservedJob) bool {
	if !vphp.PhpClass.named(job.job_class).exists() {
		return worker.fail_or_release(job, 'job class does not exist: ${job.job_class}')
	}
	mut instance := vphp.PhpClass.named(job.job_class).construct([])
	if !instance.is_valid() || !instance.is_object() {
		return worker.fail_or_release(job, 'job class could not be instantiated: ${job.job_class}')
	}
	if !instance.method_exists('handle') {
		return worker.fail_or_release(job, 'job class must define handle(array payload): ${job.job_class}')
	}
	payload := vphp.PhpJson.decode_assoc(job.payload_json)
	if !payload.is_valid() || vphp.PhpJson.last_error_code() != 0 {
		return worker.fail_or_release(job, 'job payload is not valid JSON: ${vphp.PhpJson.last_error_message()}')
	}
	// The job table stores pure JSON data. We decode it only for this request
	// and pass the transient value directly into userland; no request zval is
	// retained across requests or worker iterations.
	mut result := vphp.PhpObject.borrowed(instance).method_request_owned_box('handle', [payload])
	defer {
		result.release()
	}
	if vphp.PhpException.has_current() {
		message := vphp.PhpException.current_message()
		vphp.PhpException.clear()
		return worker.fail_or_release(job, if message == '' { 'job handle threw an exception' } else { message })
	}
	return worker.complete(job)
}

@[php_method: 'runOnce']
pub fn (mut worker VSlimJobWorker) run_once(queue string) int {
	job := worker.reserve(queue) or { return 0 }
	return if worker.perform(job) { 1 } else { 0 }
}

@[php_method]
@[php_arg_name: 'max_jobs=maxJobs,sleep_ms=sleepMs,stop_when_empty=stopWhenEmpty']
pub fn (mut worker VSlimJobWorker) run(queue string, max_jobs int, sleep_ms int, stop_when_empty bool) int {
	mut processed := 0
	delay := if sleep_ms < 0 { 0 } else { sleep_ms }
	for {
		if max_jobs > 0 && processed >= max_jobs {
			break
		}
		ran := worker.run_once(queue)
		if ran > 0 {
			processed += ran
			continue
		}
		if stop_when_empty {
			break
		}
		if delay > 0 {
			time.sleep(delay * time.millisecond)
		}
	}
	return processed
}
