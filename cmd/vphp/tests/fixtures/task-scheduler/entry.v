module main

import os
import time
import vphp

const ext_config = vphp.ExtensionConfig{ name: 'task_scheduler_probe' }

@[vphp.PhpExportTask(name: 'TaskProbeNativeGate')]
struct TaskProbeNativeGate {
	path string
}

fn (task TaskProbeNativeGate) run() vphp.TaskResult {
	deadline := time.sys_mono_now() + u64(3000 * time.millisecond)
	for time.sys_mono_now() < deadline {
		if os.is_file(task.path) {
			os.write_file(task.path + '.done', 'finished') or { return ['write failed'] }
			return ['native', 'done']
		}
		time.sleep(time.millisecond)
	}
	return ['timed out']
}

@[vphp.PhpExportClass(name: 'VPHP\\TaskProbe\\StubProperty')]
@[heap]
pub struct StubProperty {
mut:
	callable vphp.PhpCallable
}

@[vphp.PhpExportFunction(name: 'VPHP\\TaskProbe\\waitPair')]
pub fn wait_pair(first vphp.PhpCallable, second vphp.PhpCallable) !vphp.PhpArray {
	mut first_state := vphp.PhpArray.new()
	mut second_state := vphp.PhpArray.new()
	mut args := vphp.PhpArray.new()
	defer {
		args.release()
		second_state.release()
		first_state.release()
	}
	a := vphp.PhpScheduledTask.new(first_state)
	b := vphp.PhpScheduledTask.new(second_state)
	a.initialize(first, args)
	b.initialize(second, args)
	vphp.run_php_tasks([a, b])!
	// Requeueing completed tasks must keep their results without invoking them again.
	vphp.run_php_tasks([b, a, b])!
	mut results := vphp.PhpArray.new()
	for task in [a, b] {
		mut value := task.result()
		if vphp.has_exception() {
			value.release()
			results.release()
			return error('Scheduled task failed')
		}
		results.push_value(value)
		value.release()
	}
	mut result := results.take_value()
	return result.move_to_request_scope().require_array()
}

@[vphp.PhpExportFunction(name: 'VPHP\\TaskProbe\\awaitStream')]
pub fn await_stream(stream vphp.PhpResource, write bool, timeout_ms i64) !bool {
	return vphp.wait_php_stream(stream, write, timeout_ms)
}

@[vphp.PhpExportFunction(name: 'VPHP\\TaskProbe\\sleepWithValue')]
pub fn sleep_with_value(value vphp.PhpValue) !vphp.PhpValue {
	vphp.sleep_php_task(3000)!
	return value
}

@[vphp.PhpExportFunction(name: 'VPHP\\TaskProbe\\aggregateIterator')]
pub fn aggregate_iterator(value vphp.PhpIteratorAggregate) !vphp.PhpIterator {
	return value.get_iterator()
}

@[vphp.PhpExportFunction(name: 'VPHP\\TaskProbe\\aggregateIdentity')]
pub fn aggregate_identity() fn (vphp.PhpIteratorAggregate) vphp.PhpIteratorAggregate {
	return fn (value vphp.PhpIteratorAggregate) vphp.PhpIteratorAggregate {
		return value
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\TaskProbe\\streamGenerator')]
pub fn stream_generator(stream vphp.PhpResource, timeout_ms i64) !vphp.PhpGenerator {
	return vphp.PhpGenerator.from_stream_resource(stream, wait_timeout_ms: timeout_ms)
}

@[vphp.PhpExportFunction(name: 'VPHP\\TaskProbe\\waitWithArgs')]
pub fn wait_with_args(callback vphp.PhpCallable, args vphp.PhpArray) !vphp.PhpValue {
	mut state := vphp.PhpArray.new()
	defer {
		state.release()
	}
	task := vphp.PhpScheduledTask.new(state)
	task.initialize(callback, args)
	task.wait_until_complete()!
	return task.result()
}

@[vphp.PhpExportFunction(name: 'VPHP\\TaskProbe\\cancelQueued')]
pub fn cancel_queued(callback vphp.PhpCallable, reason vphp.PhpThrowable) ! {
	mut state := vphp.PhpArray.new()
	mut args := vphp.PhpArray.new()
	defer {
		args.release()
		state.release()
	}
	task := vphp.PhpScheduledTask.new(state)
	task.initialize(callback, args)
	if !task.cancel(reason) || task.cancel(reason) {
		return error('Invalid cancellation state')
	}
	task.wait_until_complete()!
	mut result := task.result()
	result.release()
}

@[vphp.PhpExportFunction(name: 'VPHP\\TaskProbe\\sleep')]
@[vphp.PhpReturnType(php_type: 'void')]
pub fn sleep_task(milliseconds i64) ! {
	vphp.sleep_php_task(milliseconds)!
}

@[vphp.PhpExportFunction(name: 'VPHP\\TaskProbe\\runCleanup')]
pub fn run_cleanup(action vphp.PhpCallable, cleanup vphp.PhpCallable) {
	mut result := action.invoke()
	result.release()
	vphp.PhpException.with_preserved_pending(fn [cleanup] () {
		mut cleaned := cleanup.invoke()
		cleaned.release()
	})
}
