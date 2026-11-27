module taskx

import vphp

@[vphp.PhpExportClass(name: 'VSlim\\Task')]
@[heap]
pub struct VSlimTask {}

@[vphp.PhpExportClass(name: 'VSlim\\TaskCancelledException')]
@[vphp.PhpExtends(name: 'RuntimeException')]
@[heap]
pub struct VSlimTaskCancelledException {}

@[vphp.PhpExportClass(name: 'VSlim\\TaskTimeoutException')]
@[vphp.PhpExtends(name: 'RuntimeException')]
@[heap]
pub struct VSlimTaskTimeoutException {}

@[vphp.PhpExportEnum(name: 'VSlim\\TaskStatus')]
@[vphp.PhpUnitEnum]
pub enum VSlimTaskStatus {
	pending   @[vphp.PhpEnumCaseName(name: 'Pending')]
	fulfilled @[vphp.PhpEnumCaseName(name: 'Fulfilled')]
	rejected  @[vphp.PhpEnumCaseName(name: 'Rejected')]
}

@[vphp.PhpExportClass(name: 'VSlim\\TaskHandle')]
@[heap]
pub struct VSlimTaskHandle {
mut:
	async_ref vphp.PhpTaskHandle = vphp.PhpTaskHandle.null() @[vphp.PhpIgnoreField]
}

fn (handle &VSlimTaskHandle) php_task() !vphp.PhpScheduledTask {
	state := vphp.owned_object_php_state(handle) or { return error('Task handle needs a PHP owner') }
	return vphp.PhpScheduledTask.new(state)
}

fn (handle &VSlimTaskHandle) completion_task() !vphp.PhpScheduledTask {
	if handle.async_ref.is_valid() {
		state := vphp.owned_object_php_state(handle) or { return error('Task handle needs a PHP owner') }
		return vphp.PhpScheduledTask.from_native(state, handle.async_ref)
	}
	return handle.php_task()
}

@[vphp.PhpExportMethod(name: '')]
pub fn VSlimTask.list() []string {
	return vphp.PhpTask.names()
}

@[vphp.PhpExportMethod(name: '')]
@[vphp.PhpReturnType(php_type: 'VSlim\\TaskHandle')]
pub fn VSlimTask.spawn(target vphp.PhpValue, params vphp.PhpArray) !vphp.PhpValue {
	mut handle := &VSlimTaskHandle{}
	mut object := vphp.bind_owned_object_value[VSlimTaskHandle](handle)
	defer {
		object.release()
	}
	if target.is_string() {
		native := vphp.PhpTask.named(target.to_string())
		if native.exists() || !target.is_callable() {
			handle.async_ref = native.spawn(params.items())!
			return object.move_to_request_scope()
		}
	}
	mut callback := target.as_callable() or {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'task target must be a callable or registered task name', 0)
		return error('Invalid task target')
	}
	defer {
		callback.release()
	}
	handle.php_task()!.initialize(callback, params)
	return object.move_to_request_scope()
}

@[vphp.PhpExportMethod(name: 'waitAll')]
@[vphp.PhpReturnType(php_type: '?array')]
@[vphp.PhpArgName(v_name: 'timeout_ms', php_name: 'timeoutMs')]
@[vphp.PhpArgDefault(v_name: 'timeout_ms', default_value: '-1')]
pub fn VSlimTask.wait_all(tasks vphp.PhpArray, timeout_ms i64) !vphp.PhpValue {
	return wait_task_batch(tasks, timeout_ms, false)
}

@[vphp.PhpExportMethod(name: 'waitAllSettled')]
@[vphp.PhpReturnType(php_type: '?array')]
@[vphp.PhpArgName(v_name: 'timeout_ms', php_name: 'timeoutMs')]
@[vphp.PhpArgDefault(v_name: 'timeout_ms', default_value: '-1')]
pub fn VSlimTask.wait_all_settled(tasks vphp.PhpArray, timeout_ms i64) !vphp.PhpValue {
	return wait_task_batch(tasks, timeout_ms, true)
}

fn wait_task_batch(tasks vphp.PhpArray, timeout_ms i64, settlements bool) !vphp.PhpValue {
	operation := if settlements { 'waitAllSettled' } else { 'waitAll' }
	mut handles := []&VSlimTaskHandle{cap: tasks.count()}
	mut queued := []vphp.PhpScheduledTask{}
	mut owners := vphp.PhpArray.new()
	defer {
		owners.release()
	}
	for value in tasks.value_items() {
		owner := task_handle_value(value)
		handle := task_handle(owner, operation)!
		handles << handle
		// An indefinite waitAll resolves native handles in input order after driving PHP tasks.
		queued << if !settlements && timeout_ms == -1 {
			handle.php_task()!
		} else {
			handle.completion_task()!
		}
		owners.push_value(owner)
	}
	mut snapshot := owners.take_value()
	owner := snapshot.move_to_request_scope()
	complete := vphp.wait_for_all_php_tasks(queued,
		owner:      owner
		timeout_ms: timeout_ms
	) or { return task_wait_error(err) }
	if !complete {
		mut result := vphp.PhpValue.null()
		return result.move_to_request_scope()
	}
	mut results := vphp.PhpArray.new()
	defer {
		results.release()
	}
	for handle in handles {
		mut receiver := handle
		mut result := if settlements { receiver.settlement()! } else { receiver.resolve()! }
		results.push_value(result)
		result.release()
	}
	mut result := results.take_value()
	return result.move_to_request_scope()
}

@[vphp.PhpExportMethod(name: 'waitAny')]
@[vphp.PhpReturnType(php_type: '?VSlim\\TaskHandle')]
@[vphp.PhpArgName(v_name: 'timeout_ms', php_name: 'timeoutMs')]
@[vphp.PhpArgDefault(v_name: 'timeout_ms', default_value: '-1')]
pub fn VSlimTask.wait_any(tasks vphp.PhpArray, timeout_ms i64) !vphp.PhpValue {
	values := tasks.value_items()
	if values.len == 0 {
		vphp.PhpException.raise_class('ValueError', 'waitAny expects at least one TaskHandle', 0)
		return error('Empty task batch')
	}
	mut queued := []vphp.PhpScheduledTask{cap: values.len}
	mut owners := vphp.PhpArray.new()
	defer {
		owners.release()
	}
	for value in values {
		owner := task_handle_value(value)
		handle := task_handle(owner, 'waitAny')!
		owners.push_value(owner)
		queued << handle.completion_task()!
	}
	mut snapshot := owners.take_value()
	owner := snapshot.move_to_request_scope()
	index := vphp.wait_for_any_php_task(queued,
		owner:      owner
		timeout_ms: timeout_ms
	) or { return task_wait_error(err) }
	if index < 0 {
		mut result := vphp.PhpValue.null()
		return result.move_to_request_scope()
	}
	mut result := owner.require_array()!.index_value(index).owned()
	return result.move_to_request_scope()
}

fn task_handle_value(value vphp.PhpValue) vphp.PhpValue {
	if reference := vphp.PhpReference.from_zval(value.to_zval()) {
		return reference.deref()
	}
	return value
}

fn task_handle(value vphp.PhpValue, operation string) !&VSlimTaskHandle {
	if !value.is_instance_of('VSlim\\TaskHandle') {
		vphp.PhpException.raise_class('TypeError', '${operation} expects TaskHandle instances', 0)
		return error('Invalid task handle')
	}
	return value.to_v_object[VSlimTaskHandle]() or { error('Task handle has no V binding') }
}

@[vphp.PhpExportMethod(name: 'awaitReadable')]
@[vphp.PhpReturnType(php_type: 'bool')]
@[vphp.PhpArgName(v_name: 'timeout_ms', php_name: 'timeoutMs')]
@[vphp.PhpArgDefault(v_name: 'timeout_ms', default_value: '-1')]
pub fn VSlimTask.await_readable(stream vphp.PhpResource, timeout_ms i64) !bool {
	return vphp.wait_php_stream(stream, false, timeout_ms)
}

@[vphp.PhpExportMethod(name: 'awaitWritable')]
@[vphp.PhpReturnType(php_type: 'bool')]
@[vphp.PhpArgName(v_name: 'timeout_ms', php_name: 'timeoutMs')]
@[vphp.PhpArgDefault(v_name: 'timeout_ms', default_value: '-1')]
pub fn VSlimTask.await_writable(stream vphp.PhpResource, timeout_ms i64) !bool {
	return vphp.wait_php_stream(stream, true, timeout_ms)
}

@[vphp.PhpExportMethod(name: 'waitStreams')]
@[vphp.PhpArgName(v_name: 'timeout_ms', php_name: 'timeoutMs')]
@[vphp.PhpArgDefaults(defaults: 'read=[],write=[],timeout_ms=-1')]
pub fn VSlimTask.wait_streams(read vphp.PhpArray, write vphp.PhpArray, timeout_ms i64) !vphp.PhpArray {
	return vphp.wait_php_streams(read, write, timeout_ms)
}

@[vphp.PhpExportMethod(name: 'accept')]
@[vphp.PhpArgName(v_name: 'timeout_ms', php_name: 'timeoutMs')]
@[vphp.PhpArgDefault(v_name: 'timeout_ms', default_value: '-1')]
pub fn VSlimTask.accept(listener vphp.PhpResource, timeout_ms i64) !vphp.PhpValue {
	mut stream := listener.accept_stream(timeout_ms)!
	mut result := vphp.PhpValue.adopt_zval(stream.take_zval())
	return result.move_to_request_scope()
}

@[vphp.PhpExportMethod(name: 'connect')]
@[vphp.PhpArgName(v_name: 'timeout_ms', php_name: 'timeoutMs')]
@[vphp.PhpArgDefaults(defaults: 'timeout_ms=-1,context=null')]
pub fn VSlimTask.connect(address string, timeout_ms i64, context vphp.PhpValue) !vphp.PhpValue {
	mut stream := vphp.PhpResource.connect_stream(address,
		timeout_ms: timeout_ms
		context:    (task_socket_context(context)!).as_resource()
	)!
	mut result := vphp.PhpValue.adopt_zval(stream.take_zval())
	return result.move_to_request_scope()
}

@[vphp.PhpExportMethod(name: 'listen')]
@[vphp.PhpArgDefault(v_name: 'context', default_value: 'null')]
pub fn VSlimTask.listen(address string, context vphp.PhpValue) !vphp.PhpValue {
	mut stream := vphp.PhpResource.listen_stream(address, (task_socket_context(context)!).as_resource())!
	mut result := vphp.PhpValue.adopt_zval(stream.take_zval())
	return result.move_to_request_scope()
}

fn task_socket_context(context vphp.PhpValue) !vphp.PhpValue {
	if !context.is_resource() && !context.is_null() {
		vphp.PhpException.raise_class('TypeError', 'Socket context must be a PHP stream context or null', 0)
		return error('Invalid PHP stream context')
	}
	return context
}

@[vphp.PhpExportMethod(name: 'copyStream')]
@[vphp.PhpReturnType(php_type: 'int')]
@[vphp.PhpArgName(v_name: 'timeout_ms', php_name: 'timeoutMs')]
@[vphp.PhpArgDefaults(defaults: 'length=-1,timeout_ms=-1')]
pub fn VSlimTask.copy_stream(source vphp.PhpResource, destination vphp.PhpResource, length i64, timeout_ms i64) !i64 {
	return source.copy_to(destination, length, timeout_ms)
}

@[vphp.PhpExportMethod(name: 'readExactly')]
@[vphp.PhpReturnType(php_type: 'string')]
@[vphp.PhpArgName(v_name: 'timeout_ms', php_name: 'timeoutMs')]
@[vphp.PhpArgDefault(v_name: 'timeout_ms', default_value: '-1')]
pub fn VSlimTask.read_exactly(stream vphp.PhpResource, length i64, timeout_ms i64) !string {
	return stream.read_exactly(length, timeout_ms: timeout_ms)
}

@[vphp.PhpExportMethod(name: 'readLine')]
@[vphp.PhpReturnType(php_type: 'string')]
@[vphp.PhpArgNames(names: 'max_bytes=maxBytes,timeout_ms=timeoutMs')]
@[vphp.PhpArgDefault(v_name: 'timeout_ms', default_value: '-1')]
pub fn VSlimTask.read_line(stream vphp.PhpResource, max_bytes i64, timeout_ms i64) !string {
	if max_bytes <= 0 || max_bytes >= max_i32 {
		return error('PHP stream line limit must be between 1 and ${max_i32 - 1} bytes')
	}
	return stream.read_complete_line(int(max_bytes), timeout_ms: timeout_ms)
}

@[vphp.PhpExportMethod(name: 'writeAll')]
@[vphp.PhpReturnType(php_type: 'int')]
@[vphp.PhpArgName(v_name: 'timeout_ms', php_name: 'timeoutMs')]
@[vphp.PhpArgDefault(v_name: 'timeout_ms', default_value: '-1')]
pub fn VSlimTask.write_all(stream vphp.PhpResource, data string, timeout_ms i64) !i64 {
	return stream.write_all(data, timeout_ms)
}

@[vphp.PhpExportMethod(name: '')]
@[vphp.PhpReturnType(php_type: 'void')]
pub fn VSlimTask.sleep(milliseconds i64) ! {
	vphp.sleep_php_task(milliseconds)!
}

fn task_wait_error(err IError) IError {
	if !vphp.has_exception() {
		vphp.PhpException.raise_class('LogicException', err.msg(), 0)
	}
	return err
}

@[vphp.PhpExportMethod(name: '')]
pub fn (handle &VSlimTaskHandle) status() !VSlimTaskStatus {
	return match handle.completion_task()!.status() {
		.pending { .pending }
		.fulfilled { .fulfilled }
		.rejected { .rejected }
	}
}

@[vphp.PhpExportMethod(name: '')]
@[vphp.PhpReturnType(php_type: '?array')]
pub fn (mut handle VSlimTaskHandle) outcome() !vphp.PhpValue {
	mut result := if handle.completion_task()!.is_pending() {
		vphp.PhpValue.null()
	} else {
		handle.settlement()!
	}
	return result.move_to_request_scope()
}

@[vphp.PhpExportMethod(name: '')]
@[vphp.PhpArgName(v_name: 'timeout_ms', php_name: 'timeoutMs')]
@[vphp.PhpArgDefault(v_name: 'timeout_ms', default_value: '-1')]
pub fn (mut handle VSlimTaskHandle) wait(timeout_ms i64) !vphp.PhpValue {
	task := if timeout_ms == -1 { handle.php_task()! } else { handle.completion_task()! }
	mut owner := vphp.bind_borrowed_object_value[VSlimTaskHandle](handle)
	defer {
		owner.release()
	}
	complete := task.wait_until_complete_within(timeout_ms, owner: owner) or {
		return task_wait_error(err)
	}
	if !complete {
		message := 'Task did not complete within ${timeout_ms} milliseconds'
		vphp.PhpException.raise_class('VSlim\\TaskTimeoutException', message, 0)
		return error(message)
	}
	mut result := handle.resolve()!
	return result.move_to_request_scope()
}

@[vphp.PhpExportMethod(name: '')]
@[vphp.PhpArgDefault(v_name: 'reason', default_value: 'null')]
@[vphp.PhpReturnType(php_type: 'bool')]
pub fn (handle &VSlimTaskHandle) cancel(reason ?vphp.PhpThrowable) !bool {
	task := handle.php_task()!
	if !task.is_pending() {
		return false
	}
	if failure := reason {
		return task.cancel(failure)
	}
	mut message := vphp.PhpString.of('Task was cancelled')
	defer {
		message.release()
	}
	mut exception := vphp.PhpClass.named('VSlim\\TaskCancelledException').construct(message)!
	defer {
		exception.release()
	}
	return task.cancel(vphp.PhpThrowable.must_from_zval(exception.to_zval())!)
}

fn (mut handle VSlimTaskHandle) resolve() !vphp.PhpValue {
	state := vphp.owned_object_php_state(handle) or { return error('Task handle needs a PHP owner') }
	native := handle.async_ref.is_valid()
	mut result := if native {
		if cached := state.find('result') {
			return cached.owned()
		}
		handle.async_ref.await_value()!
	} else {
		vphp.PhpScheduledTask.new(state).result()
	}
	if vphp.has_exception() {
		result.release()
		return error('Task failed')
	}
	if native {
		state.set_value('result', result)
	}
	return result
}

fn (mut handle VSlimTaskHandle) settlement() !vphp.PhpValue {
	mut entry := vphp.PhpArray.new()
	defer {
		entry.release()
	}
	if mut reason := handle.php_task()!.failure() {
		defer {
			reason.release()
		}
		entry.string('status', 'rejected')
		entry.set_zval('reason', reason.to_zval())
	} else {
		mut value := handle.resolve()!
		defer {
			value.release()
		}
		entry.string('status', 'fulfilled')
		entry.set_value('value', value)
	}
	return entry.take_value()
}

pub fn (mut handle VSlimTaskHandle) cleanup() {
	if handle.async_ref.is_valid() {
		handle.async_ref.release()
		handle.async_ref = vphp.PhpTaskHandle.null()
	}
}
