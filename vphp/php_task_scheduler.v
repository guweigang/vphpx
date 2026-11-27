module vphp

import time
import vphp.zend

const task_read = i32(1)
const task_write = i32(2)
const recursive_task_wait = 'A running task cannot be waited on recursively'
const max_task_timeout = i64(2147483647)

// The caller keeps PHP-owned state alive so Zend can trace the Fiber,
// callbacks, streams, results, and exceptions.
pub struct PhpScheduledTask {
	state  PhpArray
	native PhpTaskHandle
}

pub enum PhpTaskStatus {
	pending
	fulfilled
	rejected
}

pub fn PhpScheduledTask.new(state PhpArray) PhpScheduledTask {
	// Queue entries must share the caller's zval. Cloning an owned PhpArray
	// creates another zval, so subsequent array writes separate its state.
	return PhpScheduledTask{ state: state.borrowed() }
}

pub fn (task PhpScheduledTask) initialize(callback PhpCallable, params PhpArray) {
	task.state.set_callable('callback', callback)
	// Keep string keys for Fiber::start() to bind as PHP named arguments.
	task.state.set('args', params)
}

// Observes thread completion while leaving its result and lifetime with the owner.
pub fn PhpScheduledTask.from_native(state PhpArray, native PhpTaskHandle) PhpScheduledTask {
	return PhpScheduledTask{
		state:  state.borrowed()
		native: native
	}
}

pub fn (task PhpScheduledTask) is_pending() bool {
	if task.native.is_valid() {
		return !task.native.is_complete()
	}
	return !task.state.bool_at('done', false) && (task.state.has('callback')
		|| task.state.has('fiber'))
}

// Reads the current state without starting or resuming a task.
pub fn (task PhpScheduledTask) status() PhpTaskStatus {
	if task.is_pending() {
		return .pending
	}
	return if task.state.has('failure') { .rejected } else { .fulfilled }
}

fn (task PhpScheduledTask) key() usize {
	return usize(task.state.to_zval().raw_ptr())
}

@[params]
pub struct PhpTaskWaitOptions {
pub:
	owner PhpValue = PhpValue.invalid()
}

@[params]
pub struct PhpTaskSelectOptions {
pub:
	owner      PhpValue = PhpValue.invalid()
	timeout_ms i64      = -1
}

// Drives a standalone task or parks the current managed Fiber in its group.
// Pass the PHP owner if the task's state lives inside a PHP object.
pub fn (task PhpScheduledTask) wait_until_complete(options PhpTaskWaitOptions) ! {
	wait_for_php_tasks([task], options)!
}

// Reports whether this task settled before the cooperative wait expired.
// Read the result separately so a successful null remains distinct from timeout.
pub fn (task PhpScheduledTask) wait_until_complete_within(timeout_ms i64, options PhpTaskWaitOptions) !bool {
	return wait_for_all_php_tasks([task], owner: options.owner, timeout_ms: timeout_ms)
}

// Joins the whole batch before the caller waits so peers can do each other's I/O.
pub fn wait_for_php_tasks(tasks []PhpScheduledTask, options PhpTaskWaitOptions) ! {
	wait_for_task_selection(tasks, options.owner, false, 0)!
}

// Returns false when the batch is still pending at the deadline. An immediate
// check observes the existing state without starting any queued tasks.
pub fn wait_for_all_php_tasks(tasks []PhpScheduledTask, options PhpTaskSelectOptions) !bool {
	deadline := checked_task_wait_deadline(options.timeout_ms)!
	if options.timeout_ms != 0 && tasks.any(it.is_pending()) {
		wait_for_task_selection(tasks, options.owner, false, deadline)!
	}
	return !tasks.any(it.is_pending())
}

// Returns the position of a settled task or -1 when the wait times out.
// A zero timeout only checks for a task that has already settled.
pub fn wait_for_any_php_task(tasks []PhpScheduledTask, options PhpTaskSelectOptions) !int {
	if tasks.len == 0 {
		return error('Waiting for any task requires a nonempty batch')
	}
	deadline := checked_task_wait_deadline(options.timeout_ms)!
	if index := settled_task_index(tasks) {
		return index
	}
	if options.timeout_ms == 0 {
		return -1
	}
	wait_for_task_selection(tasks, options.owner, true, deadline)!
	return settled_task_index(tasks) or {
		if task_deadline_reached(deadline) {
			return -1
		}
		error('No task completed')
	}
}

fn wait_for_task_selection(tasks []PhpScheduledTask, owner PhpValue, first bool, deadline u64) ! {
	group_ptr := zend.task_current_group()
	if group_ptr == unsafe { nil } {
		drive_php_tasks(tasks, first, deadline)!
		return
	}
	mut group := unsafe { &PhpTaskGroup(group_ptr) }
	group.join(tasks, owner)!
	if first || deadline > 0 {
		group.stop_after_roots = true
	}
	if first || tasks.any(it.is_pending()) {
		park_for_completion(tasks, owner, first, deadline)!
	}
}

fn checked_task_wait_deadline(milliseconds i64) !u64 {
	if milliseconds < -1 || milliseconds > max_task_timeout {
		return error('A task wait timeout must be -1 or between 0 and ${max_task_timeout} milliseconds')
	}
	return u64(task_stream_deadline(milliseconds))
}

fn task_deadline_reached(deadline u64) bool {
	return deadline > 0 && deadline <= time.sys_mono_now()
}

fn settled_task_index(tasks []PhpScheduledTask) ?int {
	for index, task in tasks {
		if !task.is_pending() {
			return index
		}
	}
	return none
}

struct TaskDependencies {
	tasks    []PhpScheduledTask
	deadline u64
}

@[export: 'vphp_release_task_dependencies']
fn release_task_dependencies(raw voidptr) {
	dependencies := unsafe { &TaskDependencies(raw) }
	unsafe {
		dependencies.tasks.free()
		free(dependencies)
	}
}

fn park_for_completion(tasks []PhpScheduledTask, owner PhpValue, first bool, deadline u64) ! {
	// The PHP wait state traces the owner. The opaque resource keeps V's
	// dependency list alive so paused Fibers can rejoin a later group.
	mut dependencies := unsafe { &TaskDependencies(malloc_uncollectable(int(sizeof(TaskDependencies)))) }
	unsafe {
		*dependencies = TaskDependencies{
			tasks:    tasks.clone()
			deadline: deadline
		}
	}
	mut token := ZVal.new_request()
	defer {
		// A retained resource must not keep borrowed state pointers usable
		// after this waiter releases its PHP owner.
		zend.task_close_dependency(token.raw_ptr())
		token.release()
	}
	token.make_resource(dependencies, 'vphp_task_dependency')
	mut wait := PhpArray.new()
	defer {
		wait.release()
	}
	wait.set_zval('dependencies', token)
	if owner.is_valid() {
		wait.set_value('owner', owner)
	}
	if first {
		resume_on_dependency(wait, -1)!
		return
	}
	for index, task in tasks {
		if task.is_pending() {
			if task_deadline_reached(deadline) {
				return
			}
			resume_on_dependency(wait, index)!
		}
	}
}

fn resume_on_dependency(wait PhpArray, index int) ! {
	wait.int('dependency_index', index)
	if !suspend_task_wait(wait)! {
		return error(recursive_task_wait)
	}
}

pub fn (task PhpScheduledTask) result() PhpValue {
	if failure := task.state.find('failure') {
		mut value := failure.owned()
		mut raw := value.take_zval()
		PhpException.raise_object(mut raw)
		return PhpValue.invalid()
	}
	if result := task.state.find('result') {
		return result.owned()
	}
	return PhpValue.null()
}

// Returns a request-owned Throwable for a failed or cancelled task.
// Inspecting it leaves PHP's pending exception untouched.
pub fn (task PhpScheduledTask) failure() ?PhpThrowable {
	failure := task.state.find('failure')?
	reason := PhpThrowable.from_zval(failure.to_zval())?
	return reason.owned()
}

// Cancels a queued task before it starts or requests delivery to its Fiber
// when the scheduler next advances it. The original Throwable is kept in Zend.
pub fn (task PhpScheduledTask) cancel(reason PhpThrowable) bool {
	if !task.is_pending() || task.state.has('cancellation') {
		return false
	}
	if task.state.has('fiber') {
		task.state.set_zval('cancellation', reason.to_zval())
	} else {
		task.state.set_zval('failure', reason.to_zval())
		task.finish()
	}
	return true
}

fn (task PhpScheduledTask) finish() {
	task.state.bool('done', true)
	task.state.remove('callback')
	task.state.remove('args')
	task.state.remove('wait')
	task.state.remove('cancellation')
	task.state.remove('fiber')
}

fn (task PhpScheduledTask) fail(err IError) {
	if !PhpException.has_current() {
		PhpException.raise_class('LogicException', err.msg(), 0)
	}
	if mut failure := PhpException.take_current() {
		task.state.set_zval('failure', failure.to_zval())
		failure.release()
	}
	task.finish()
}

@[params]
struct TaskResumeOptions {
	failure ?PhpThrowable
}

fn (task PhpScheduledTask) step(readiness bool, options TaskResumeOptions) ! {
	mut yielded := PhpValue.invalid()
	defer {
		yielded.release()
	}
	mut fiber := PhpFiber{}
	if raw := task.state.find('fiber') {
		fiber = PhpFiber.must_from_zval(raw.to_zval())!
		task.state.remove('wait')
		previous := zend.task_enter_fiber(raw.to_zval().raw_ptr())
		defer {
			zend.task_restore_fiber(previous)
		}
		yielded = if failure := options.failure {
			fiber.throw_into(failure)!
		} else {
			task.resume(fiber, readiness)!
		}
	} else {
		target := task.state.find('callback') or { return error('Missing task callback') }
		params := task.state.find('args') or { return error('Missing task parameters') }
		callback := target.require_callable()!
		args := params.require_array()!
		mut object := PhpClass.named('Fiber').construct(callback)!
		task.state.set('fiber', object)
		object.release()
		raw := task.state.find('fiber') or { return error('Missing task Fiber') }
		fiber = PhpFiber.must_from_zval(raw.to_zval())!
		previous := zend.task_enter_fiber(raw.to_zval().raw_ptr())
		defer {
			zend.task_restore_fiber(previous)
		}
		yielded = fiber.start_args(args)!
		task.state.remove('callback')
		task.state.remove('args')
	}
	if fiber.is_terminated()! {
		mut result := fiber.get_return()!
		task.state.set_value('result', result)
		result.release()
		task.finish()
		return
	}
	mut wait := yielded.as_array() or { return error('A scheduled task must suspend through the task API') }
	defer {
		wait.release()
	}
	if timer := wait.find('timer') {
		deadline := if timer.is_long() { timer.to_i64() } else { 0 }
		if deadline <= 0
			|| u64(deadline) > time.sys_mono_now() + u64(max_task_timeout) * 1000000 {
			return error('Invalid task timer deadline')
		}
	} else if read_set := wait.find('read_set') {
		write_set := wait.find('write_set') or { return error('Missing task write streams') }
		if !read_set.is_array() || !write_set.is_array() {
			return error('Task stream sets must be arrays')
		}
	} else if channel := wait.find('channel') {
		if PhpWeakReference.from_zval(channel.to_zval()) == none {
			return error('Invalid task channel')
		}
	} else if !wait.has('stream') && task_dependencies(wait) == none {
		return error('A scheduled task must suspend through the task API')
	}
	task.state.set('wait', wait)
}

fn (task PhpScheduledTask) deliver_wait_failure(mut failure PhpThrowable) {
	defer {
		failure.release()
	}
	task.step(false, failure: failure) or { task.fail(err) }
}

fn (task PhpScheduledTask) resume(fiber PhpFiber, readiness bool) !PhpValue {
	if cancellation := task.state.find('cancellation') {
		mut owned := cancellation.owned()
		defer {
			owned.release()
		}
		task.state.remove('cancellation')
		reason := PhpThrowable.must_from_zval(owned.to_zval())!
		return fiber.throw_into(reason)
	}
	mut signal := PhpBool.of(readiness)
	defer {
		signal.release()
	}
	return fiber.resume(signal)
}

struct TaskStreamWatch {
	fd       usize
	interest i32
	buffered bool
}

fn task_stream_watch(raw ZVal, interest i32) !TaskStreamWatch {
	mut fd := usize(0)
	mut buffered := false
	if !zend.task_stream_descriptor(raw.raw_ptr(), &fd, &buffered) {
		return error('A task stream must be open and have a pollable descriptor')
	}
	return TaskStreamWatch{
		fd:       fd
		interest: interest
		buffered: interest == task_read && buffered
	}
}

fn task_stream_watches(readable PhpArray, writable PhpArray) ![]TaskStreamWatch {
	mut watches := []TaskStreamWatch{cap: readable.count() + writable.count()}
	read_values := readable.items()
	write_values := writable.items()
	for stream in read_values {
		watches << task_stream_watch(stream, task_read)!
	}
	for stream in write_values {
		watches << task_stream_watch(stream, task_write)!
	}
	// A later userland stream cast can close a stream that was already cast.
	if read_values.any(!zend.task_stream_is_open(it.raw_ptr()))
		|| write_values.any(!zend.task_stream_is_open(it.raw_ptr())) {
		return error('A task stream closed while preparing the wait')
	}
	return watches
}

struct TaskStreamPoll {
mut:
	fds       []usize
	interests []i32
	positions map[usize]int
	buffered  bool
}

fn (mut poll TaskStreamPoll) add(watches []TaskStreamWatch) {
	for watch in watches {
		if watch.buffered {
			poll.buffered = true
			continue
		}
		if index := poll.positions[watch.fd] {
			poll.interests[index] |= watch.interest
		} else {
			poll.positions[watch.fd] = poll.fds.len
			poll.fds << watch.fd
			poll.interests << watch.interest
		}
	}
}

fn (poll &TaskStreamPoll) wait(timeout int) ![]i32 {
	mut ready := []i32{len: poll.fds.len}
	if poll.fds.len == 0 {
		return ready
	}
	if zend.task_poll_wait(poll.fds, poll.interests, mut ready, if poll.buffered {
		0
	} else {
		timeout
	}) < 0 {
		return error('Unable to poll task streams')
	}
	return ready
}

fn (poll &TaskStreamPoll) ready(watch TaskStreamWatch, flags []i32) bool {
	index := poll.positions[watch.fd] or { return watch.buffered }
	return watch.buffered || (flags[index] & watch.interest) != 0
}

struct TaskWait {
	task            PhpScheduledTask
	streams         []TaskStreamWatch
	deadline        u64
	valid           bool
	scheduler_timer bool
}

fn (wait TaskWait) ready_now() !bool {
	if wait.streams.any(it.buffered) {
		return true
	}
	mut poll := TaskStreamPoll{}
	poll.add(wait.streams)
	flags := poll.wait(0)!
	return wait.streams.any(poll.ready(it, flags))
}

fn (wait TaskWait) expired() bool {
	return task_deadline_reached(wait.deadline)
}

fn (task PhpScheduledTask) scheduled_wait() ?TaskWait {
	if task.native.is_valid() {
		if !task.is_pending() {
			return none
		}
		return TaskWait{
			task:     task
			deadline: time.sys_mono_now() + u64(time.millisecond)
			valid:    true
		}
	}
	wait := task.state.find('wait')?.as_array()?
	if timer := wait.find('timer') {
		return TaskWait{
			task:     task
			deadline: u64(timer.to_i64())
			valid:    true
		}
	}
	if dependencies := task_dependencies(wait) {
		if dependencies.deadline == 0 {
			return none
		}
		// The timer wakes the poll loop. Dependency resolution resumes the Fiber.
		return TaskWait{
			task:            task
			deadline:        dependencies.deadline
			valid:           true
			scheduler_timer: true
		}
	}
	deadline := wait_deadline(wait)
	if wait.has('channel') {
		return TaskWait{ task: task, deadline: deadline, valid: true, scheduler_timer: true }
	}
	streams := wait_stream_watches(wait) or {
		return TaskWait{ task: task, deadline: deadline }
	}
	return TaskWait{
		task:     task
		streams:  streams
		deadline: deadline
		valid:    true
	}
}

fn wait_deadline(wait PhpArray) u64 {
	return u64((wait.find('deadline') or { PhpValue.invalid() }).to_i64())
}

fn wait_stream_watches(wait PhpArray) ![]TaskStreamWatch {
	if read_set := wait.find('read_set') {
		return task_stream_watches(read_set.require_array()!, wait.value('write_set')!.require_array()!)
	}
	stream := wait.value('stream')!
	interest := if wait.bool_at('write', false) { task_write } else { task_read }
	return [task_stream_watch(stream.to_zval(), interest)!]
}

fn task_dependencies(wait PhpArray) ?&TaskDependencies {
	token := wait.find('dependencies')?
	dependencies := zend.task_dependency_ptr(token.to_zval().raw_ptr())
	if dependencies == unsafe { nil } {
		return none
	}
	return unsafe { &TaskDependencies(dependencies) }
}

fn dependency_targets(wait PhpArray, dependencies &TaskDependencies) []PhpScheduledTask {
	index := wait.int_at('dependency_index', -1)
	if index >= 0 && index < dependencies.tasks.len {
		return dependencies.tasks[index..index + 1]
	}
	return dependencies.tasks
}

// None keeps the Fiber parked. False resumes it with a rejected wait.
fn dependency_ready(task PhpScheduledTask, targets []PhpScheduledTask, deadline u64, members map[usize]PhpScheduledTask) ?bool {
	if settled_task_index(targets) != none || task_deadline_reached(deadline) {
		return true
	}
	if deadline > 0 {
		return none
	}
	// A dependency can still finish if any path leads to runnable work.
	// Reject only when every alternative leads back into blocked tasks.
	mut seen := map[usize]bool{}
	seen[task.key()] = true
	mut pending := targets.clone()
	for pending.len > 0 {
		next := pending.pop()
		key := next.key()
		if key in seen {
			continue
		}
		seen[key] = true
		peer := members[key] or { continue }
		if !peer.is_pending() {
			return none
		}
		wait_value := peer.state.find('wait') or { return none }
		wait := wait_value.as_array() or { return none }
		dependencies := task_dependencies(wait) or { return none }
		if dependencies.deadline > 0 {
			return none
		}
		pending << dependency_targets(wait, dependencies)
	}
	return false
}

@[heap]
struct PhpTaskGroup {
	pins     PhpArray
	roots    []PhpScheduledTask
	first    bool
	deadline u64
mut:
	pending          []PhpScheduledTask
	members          map[usize]PhpScheduledTask
	started          int
	stop_after_roots bool
}

fn (mut group PhpTaskGroup) join(tasks []PhpScheduledTask, owner PhpValue) ! {
	mut joined := []PhpScheduledTask{}
	mut candidates := tasks.clone()
	mut seen := map[usize]bool{}
	mut waits := []PhpValue{}
	for index := 0; index < candidates.len; index++ {
		task := candidates[index]
		key := task.key()
		if key in group.members || key in seen || !task.is_pending() {
			continue
		}
		if task.state.bool_at('driving', false) {
			return error(recursive_task_wait)
		}
		seen[key] = true
		joined << task
		if value := task.state.find('wait') {
			wait := value.as_array() or { continue }
			if dependencies := task_dependencies(wait) {
				candidates << dependencies.tasks
				waits << value
			}
		}
	}
	if joined.len > 0 && owner.is_valid() {
		group.pins.push_value(owner)
	}
	for wait in waits {
		group.pins.push_value(wait)
	}
	for task in joined {
		group.pending << task
		group.members[task.key()] = task
		task.state.bool('driving', true)
	}
}

fn (group &PhpTaskGroup) stop_requested() bool {
	if task_deadline_reached(group.deadline) {
		return true
	}
	if group.first {
		return settled_task_index(group.roots) != none
	}
	if group.stop_after_roots {
		return !group.roots.any(it.is_pending())
	}
	return false
}

fn (mut group PhpTaskGroup) start_ready_tasks() {
	for group.started < group.pending.len && !group.stop_requested() {
		task := group.pending[group.started]
		group.started++
		if task.is_pending() && !task.native.is_valid() && !task.state.has('wait') {
			task.step(false) or { task.fail(err) }
		}
	}
}

fn (group &PhpTaskGroup) advance_cancellations() bool {
	mut progressed := false
	for index in 0 .. group.started {
		task := group.pending[index]
		if task.state.has('cancellation') {
			task.step(false) or { task.fail(err) }
			progressed = true
			if group.stop_requested() {
				break
			}
		}
	}
	return progressed
}

fn (mut group PhpTaskGroup) advance_dependencies() bool {
	mut progressed := false
	for index in 0 .. group.started {
		task := group.pending[index]
		wait_value := task.state.find('wait') or { continue }
		wait := wait_value.as_array() or { continue }
		dependencies := task_dependencies(wait) or { continue }
		ready := dependency_ready(task, dependency_targets(wait, dependencies), dependencies.deadline,
			group.members) or {
			continue
		}
		task.step(ready) or { task.fail(err) }
		progressed = true
		if group.stop_requested() {
			break
		}
	}
	return progressed
}

fn (group &PhpTaskGroup) advance_channels() bool {
	mut progressed := false
	for index in 0 .. group.started {
		task := group.pending[index]
		value := task.state.find('wait') or { continue }
		wait := value.as_array() or { continue }
		channel := wait.find('channel') or { continue }
		ready := channel_wait_ready(channel, wait.bool_at('sending', false)) or {
			task.fail(err)
			progressed = true
			if group.stop_requested() {
				break
			}
			continue
		}
		if ready || task_deadline_reached(wait_deadline(wait)) {
			task.step(ready) or { task.fail(err) }
			progressed = true
			if group.stop_requested() {
				break
			}
		}
	}
	return progressed
}

fn (group &PhpTaskGroup) fail_blocked_channel() bool {
	for index in 0 .. group.started {
		task := group.pending[index]
		value := task.state.find('wait') or { continue }
		wait := value.as_array() or { continue }
		if wait.has('channel') {
			PhpException.raise_class('LogicException', 'Task channel cannot make progress', 0)
			if mut failure := PhpException.take_current() {
				task.deliver_wait_failure(mut failure)
			}
			return true
		}
	}
	return false
}

// Drives a group in the calling PHP request, including I/O waits and tasks
// joined by its Fibers. Each callback's result or exception stays on its task.
pub fn run_php_tasks(tasks []PhpScheduledTask) ! {
	drive_php_tasks(tasks, false, 0)!
}

fn drive_php_tasks(tasks []PhpScheduledTask, first bool, deadline u64) ! {
	mut pins := PhpArray.new()
	defer {
		pins.release()
	}
	mut group := &PhpTaskGroup{
		pins:             pins.borrowed()
		roots:            tasks
		first:            first
		deadline:         deadline
		pending:          []PhpScheduledTask{cap: tasks.len}
		stop_after_roots: deadline > 0
	}
	group.join(tasks, PhpValue.invalid())!
	previous := zend.task_swap_group(group)
	defer {
		zend.task_swap_group(previous)
		for task in group.pending {
			task.state.remove('driving')
		}
	}
	scheduling: for !group.stop_requested() {
		group.start_ready_tasks()
		if group.stop_requested() {
			break
		}
		if group.advance_cancellations() || group.advance_dependencies() {
			continue
		}
		channel_progress := group.advance_channels()
		if group.stop_requested() {
			break
		}
		mut waits := []TaskWait{}
		mut poll := TaskStreamPoll{}
		mut earliest := group.deadline
		mut immediate := channel_progress
		for task in group.pending {
			wait := task.scheduled_wait() or { continue }
			if mut failure := PhpException.take_current() {
				task.deliver_wait_failure(mut failure)
				// The resumed task may change streams or add work.
				continue scheduling
			}
			waits << wait
			if !wait.valid {
				immediate = true
				continue
			}
			if wait.deadline > 0 && (earliest == 0 || wait.deadline < earliest) {
				earliest = wait.deadline
			}
			poll.add(wait.streams)
		}
		if waits.len == 0 {
			if channel_progress || group.advance_dependencies() {
				continue
			}
			break
		}
		if !immediate && poll.fds.len == 0 && earliest == 0 && group.fail_blocked_channel() {
			continue
		}
		timeout := if immediate || poll.buffered { 0 } else { task_poll_timeout(earliest) }
		flags := if poll.fds.len > 0 {
			poll.wait(timeout) or {
				for wait in waits {
					if wait.streams.len > 0 {
						wait.task.fail(error('Unable to poll task streams'))
					}
				}
				continue
			}
		} else {
			if timeout > 0 {
				time.sleep(time.Duration(timeout) * time.millisecond)
			}
			[]i32{}
		}
		if group.stop_requested() {
			break
		}
		mut advanced_fiber := false
		for original in waits {
			mut wait := original
			if wait.task.native.is_valid() || wait.scheduler_timer {
				continue
			}
			mut is_ready := wait.valid && wait.streams.any(poll.ready(it, flags))
			if advanced_fiber && wait.streams.len > 0 && wait.valid && (is_ready || wait.expired()) {
				// A resumed Fiber may have consumed the data or closed the stream.
				wait = wait.task.scheduled_wait() or { continue }
				if mut failure := PhpException.take_current() {
					wait.task.deliver_wait_failure(mut failure)
					continue scheduling
				}
				is_ready = if wait.valid {
					wait.ready_now() or {
						wait.task.fail(err)
						continue
					}
				} else {
					false
				}
			}
			if is_ready || !wait.valid || wait.expired() {
				advanced_fiber = true
				wait.task.step(is_ready) or { wait.task.fail(err) }
				if group.stop_requested() {
					break scheduling
				}
			}
		}
	}
}

// Parks the current task until a monotonic deadline. Zero yields to its peers.
pub fn sleep_php_task(milliseconds i64) ! {
	if !zend.task_can_suspend() {
		return error('Waiting on a task timer requires a scheduled task')
	}
	if milliseconds < 0 || milliseconds > max_task_timeout {
		return error('A task delay must be between 0 and 2147483647 milliseconds')
	}
	mut wait := PhpArray.new()
	defer {
		wait.release()
	}
	wait.int('timer', i64(time.sys_mono_now()) + milliseconds * 1000000)
	suspend_task_wait(wait)!
}

// Suspends a PHP Fiber until a stream is ready, is closed, or times out.
pub fn suspend_php_task_stream(stream PhpResource, write bool, milliseconds i64) !bool {
	if !zend.task_can_suspend() {
		return error('Waiting on a task stream requires a scheduled task')
	}
	validate_task_stream_timeout(milliseconds)!
	return suspend_php_task_stream_until(stream, write, task_stream_deadline(milliseconds))
}

// wait_php_stream waits cooperatively in a scheduled task. A finite timeout
// also permits polling from the PHP main stack, including a zero-time probe.
pub fn wait_php_stream(stream PhpResource, write bool, milliseconds i64) !bool {
	return wait_php_stream_until(stream, write, checked_task_stream_deadline(milliseconds)!)
}

// Waits for any of the requested read or write events and returns both ready
// sets with their original PHP array keys. Timeout returns two empty sets.
pub fn wait_php_streams(readable PhpArray, writable PhpArray, milliseconds i64) !PhpArray {
	if readable.count() == 0 && writable.count() == 0 {
		validate_task_stream_timeout(milliseconds)!
		return empty_task_stream_result()
	}
	deadline := checked_task_stream_deadline(milliseconds)!
	mut read_set := snapshot_task_streams(readable)!
	defer {
		read_set.release()
	}
	mut write_set := snapshot_task_streams(writable)!
	defer {
		write_set.release()
	}
	scheduled := zend.task_can_suspend()
	for {
		watches := task_stream_watches(read_set, write_set)!
		mut poll := TaskStreamPoll{}
		poll.add(watches)
		flags := poll.wait(if scheduled { 0 } else { task_poll_timeout(u64(deadline)) })!
		readiness := watches.map(poll.ready(it, flags))
		if readiness.any(it) {
			read_count := read_set.count()
			mut ready_read := select_task_streams(read_set, readiness[..read_count])
			defer {
				ready_read.release()
			}
			mut ready_write := select_task_streams(write_set, readiness[read_count..])
			defer {
				ready_write.release()
			}
			return task_stream_result(ready_read, ready_write)
		}
		if task_deadline_reached(u64(deadline)) {
			break
		}
		if scheduled {
			mut wait := PhpArray.new()
			defer {
				wait.release()
			}
			wait.set('read_set', read_set)
			wait.set('write_set', write_set)
			if deadline > 0 {
				wait.int('deadline', deadline)
			}
			if !suspend_task_wait(wait)! {
				if task_deadline_reached(u64(deadline)) {
					break
				}
				return error('A task stream closed or became unpollable while waiting')
			}
		}
	}
	return empty_task_stream_result()
}

fn snapshot_task_streams(input PhpArray) !PhpArray {
	mut keys := input.key_array()
	defer {
		keys.release()
	}
	mut snapshot := PhpArray.new()
	for index, value in input.items() {
		stream := if value.type_id() == .reference { value.reference_value() } else { value }
		if !zend.task_stream_is_open(stream.raw_ptr()) {
			snapshot.release()
			return error('Task stream sets must contain open PHP streams')
		}
		put_task_stream(snapshot, keys.get_index(index), stream)
	}
	return snapshot
}

fn select_task_streams(input PhpArray, ready []bool) PhpArray {
	mut keys := input.key_array()
	defer {
		keys.release()
	}
	result := PhpArray.new()
	for index, value in input.items() {
		if ready[index] {
			put_task_stream(result, keys.get_index(index), value)
		}
	}
	return result
}

fn put_task_stream(target PhpArray, key ZVal, stream ZVal) {
	if key.is_long() {
		target.index_zval(key.to_i64(), stream)
	} else {
		target.set_zval(key.to_string(), stream)
	}
}

fn task_stream_result(readable PhpArray, writable PhpArray) PhpArray {
	result := PhpArray.new()
	result.set('readable', readable)
	result.set('writable', writable)
	return result
}

fn empty_task_stream_result() PhpArray {
	mut empty := PhpArray.new()
	defer {
		empty.release()
	}
	return task_stream_result(empty, empty)
}

fn checked_task_stream_deadline(milliseconds i64) !i64 {
	validate_task_stream_timeout(milliseconds)!
	if !zend.task_can_suspend() && (milliseconds < 0 || current_fiber_id() != 0) {
		return error('Waiting on a task stream requires a scheduled task or a finite timeout on the PHP main stack')
	}
	return task_stream_deadline(milliseconds)
}

fn wait_php_stream_until(stream PhpResource, write bool, deadline i64) !bool {
	if zend.task_can_suspend() {
		return suspend_php_task_stream_until(stream, write, deadline)
	}
	mut fd := usize(0)
	mut buffered := false
	if !zend.task_stream_descriptor(stream.to_zval().raw_ptr(), &fd, &buffered) {
		return error('A PHP stream must have a pollable descriptor')
	}
	if !write && buffered {
		return true
	}
	interest := if write { task_write } else { task_read }
	for {
		if zend.task_poll_ready_for(fd, interest, task_poll_timeout(u64(deadline)))! {
			return true
		}
		// An interrupted poll can return early.
		if time.sys_mono_now() >= u64(deadline) {
			return false
		}
	}
}

fn validate_task_stream_timeout(milliseconds i64) ! {
	if milliseconds < -1 || milliseconds > max_task_timeout {
		return error('A task stream timeout must be -1 or between 0 and 2147483647 milliseconds')
	}
}

fn task_stream_deadline(milliseconds i64) i64 {
	return if milliseconds < 0 { i64(0) } else { i64(time.sys_mono_now()) + milliseconds * 1000000 }
}

fn task_poll_timeout(deadline u64) int {
	if deadline == 0 {
		return -1
	}
	now := time.sys_mono_now()
	return if deadline <= now { 0 } else { int((deadline - now + 999999) / 1000000) }
}

fn suspend_php_task_stream_until(stream PhpResource, write bool, deadline i64) !bool {
	mut fd := usize(0)
	mut buffered := false
	if !zend.task_stream_descriptor(stream.to_zval().raw_ptr(), &fd, &buffered) {
		return error('A task stream must have a pollable descriptor')
	}
	mut wait := PhpArray.new()
	defer {
		wait.release()
	}
	wait.set('stream', stream)
	wait.bool('write', write)
	if deadline > 0 {
		wait.int('deadline', deadline)
	}
	return suspend_task_wait(wait)
}

fn suspend_task_wait(wait PhpArray) !bool {
	mut resumed := PhpFiber.suspend(wait)!
	defer {
		resumed.release()
	}
	return resumed.to_bool()
}
