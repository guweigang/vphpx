module taskx

import vphp

@[vphp.PhpExportEnum(name: 'VSlim\\TaskChannelStatus')]
@[vphp.PhpUnitEnum]
pub enum VSlimTaskChannelStatus {
	ready     @[vphp.PhpEnumCaseName(name: 'Ready')]
	closed    @[vphp.PhpEnumCaseName(name: 'Closed')]
	timed_out @[vphp.PhpEnumCaseName(name: 'TimedOut')]
}

@[vphp.PhpExportClass(name: 'VSlim\\TaskChannel')]
@[vphp.PhpFinalClass]
@[vphp.PhpImplements(names: 'IteratorAggregate')]
@[heap]
pub struct VSlimTaskChannel {}

@[vphp.PhpExportMethod(name: '__construct')]
@[vphp.PhpMethodVisibility(visibility: .private)]
fn (handle &VSlimTaskChannel) construct() {}

@[vphp.PhpExportMethod(name: '')]
@[vphp.PhpReturnType(php_type: 'VSlim\\TaskChannel')]
pub fn VSlimTask.channel(capacity i64) !vphp.PhpValue {
	mut channel := vphp.PhpTaskChannel.new(capacity)!
	defer {
		channel.release()
	}
	handle := &VSlimTaskChannel{}
	mut object := vphp.bind_owned_object_value[VSlimTaskChannel](handle)
	defer {
		object.release()
	}
	state := vphp.owned_object_php_state(handle) or { return error('Task channel needs a PHP owner') }
	state.set_value('channel', channel.to_value())
	return object.move_to_request_scope()
}

fn (handle &VSlimTaskChannel) php_channel() !vphp.PhpTaskChannel {
	state := vphp.owned_object_php_state(handle) or { return error('Task channel needs a PHP owner') }
	value := state.find('channel') or { return error('Create a channel with Task::channel()') }
	return vphp.PhpTaskChannel.from_value(value) or { error('Invalid task channel') }
}

@[vphp.PhpExportMethod(name: '')]
@[vphp.PhpArgName(v_name: 'timeout_ms', php_name: 'timeoutMs')]
@[vphp.PhpArgDefault(v_name: 'timeout_ms', default_value: '-1')]
pub fn (handle &VSlimTaskChannel) send(value vphp.PhpValue, timeout_ms i64) !VSlimTaskChannelStatus {
	channel := handle.php_channel()!
	status := channel.send(value, timeout_ms) or { return task_wait_error(err) }
	return task_channel_status(status)
}

@[vphp.PhpExportMethod(name: '')]
@[vphp.PhpArgName(v_name: 'timeout_ms', php_name: 'timeoutMs')]
@[vphp.PhpArgDefault(v_name: 'timeout_ms', default_value: '-1')]
pub fn (handle &VSlimTaskChannel) receive(timeout_ms i64) !vphp.PhpArray {
	channel := handle.php_channel()!
	received := channel.receive(timeout_ms) or { return task_wait_error(err) }
	mut value := received.value
	defer {
		value.release()
	}
	mut status := vphp.PhpValue.from_v(task_channel_status(received.status))!
	defer {
		status.release()
	}
	result := vphp.PhpArray.new()
	result.set_value('status', status)
	if received.status == .ready {
		result.set_value('value', value)
	}
	return result
}

@[vphp.PhpExportMethod(name: '')]
@[vphp.PhpReturnType(php_type: 'bool')]
pub fn (handle &VSlimTaskChannel) close() !bool {
	return handle.php_channel()!.close()
}

@[vphp.PhpExportMethod(name: 'getIterator')]
pub fn (handle &VSlimTaskChannel) get_iterator() !vphp.PhpIterator {
	channel := handle.php_channel()!
	generator := vphp.PhpGenerator.from_producer(vphp.PhpGeneratorProducer{
		capture: channel.to_value()
		resume:  receive_channel_message
	})!
	return generator.PhpIterator
}

fn receive_channel_message(input vphp.PhpGeneratorInput) !vphp.PhpGeneratorStep {
	if raised := input.exception {
		return vphp.PhpGeneratorStep.throw_exception(raised)
	}
	channel := vphp.PhpTaskChannel.from_value(input.capture) or { return error('Invalid task channel') }
	received := channel.receive(-1) or { return task_wait_error(err) }
	if received.status == .closed {
		return vphp.PhpGeneratorStep.finish(vphp.PhpValue.null())
	}
	mut message := received.value
	return vphp.PhpGeneratorStep.yield_value(message.move_to_request_scope())
}

fn task_channel_status(status vphp.PhpTaskChannelStatus) VSlimTaskChannelStatus {
	return match status {
		.ready { .ready }
		.closed { .closed }
		.timed_out { .timed_out }
	}
}
