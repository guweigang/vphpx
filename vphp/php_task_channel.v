module vphp

import vphp.zend

pub enum PhpTaskChannelStatus {
	ready
	closed
	timed_out
}

pub struct PhpTaskChannelReceive {
pub:
	status PhpTaskChannelStatus
	// Owned on success. Invalid for a timeout or a closed and drained channel.
	value PhpValue = PhpValue.invalid()
}

// A request-local FIFO shared by managed PHP Fibers. Zend owns the queue and
// its contents, including any cycles through the PHP objects being sent.
pub struct PhpTaskChannel {
mut:
	state PhpObject
}

pub fn PhpTaskChannel.new(capacity i64) !PhpTaskChannel {
	if capacity < 1 || capacity > max_i32 {
		PhpException.raise_class('ValueError', 'Task channel capacity must be between 1 and 2147483647', 0)
		return error('Invalid task channel capacity')
	}
	mut queue := PhpClass.named('SplQueue').construct()!
	mut size := PhpInt.of(capacity)
	mut closed := PhpBool.of(false)
	defer {
		queue.release()
		size.release()
		closed.release()
	}
	state := PhpClass.named('stdClass').construct()!
	state.set_prop('queue', queue.to_zval())
	state.set_prop('capacity', size.to_zval())
	state.set_prop('closed', closed.to_zval())
	return PhpTaskChannel{ state: state }
}

// Borrows a channel from the PHP-owned state of its wrapper or parked Fiber.
pub fn PhpTaskChannel.from_value(value PhpValue) ?PhpTaskChannel {
	state := value.borrowed().as_object()?
	if state.class_name() != 'stdClass' {
		return none
	}
	channel := PhpTaskChannel{ state: state }
	capacity := channel.capacity()
	if capacity < 1 || capacity > max_i32 || channel.queue() == none {
		return none
	}
	return channel
}

pub fn (channel PhpTaskChannel) to_value() PhpValue {
	return PhpValue.from_zval(channel.state.to_zval())
}

pub fn (mut channel PhpTaskChannel) release() {
	channel.state.release()
}

fn (channel PhpTaskChannel) queue() ?PhpObject {
	queue := PhpObject.from_zval(channel.state.prop_borrowed('queue'))?
	if queue.class_name() != 'SplQueue' {
		return none
	}
	return queue
}

fn (channel PhpTaskChannel) capacity() i64 {
	value := PhpValue.from_zval(channel.state.prop_borrowed('capacity'))
	return if value.is_long() { value.to_i64() } else { 0 }
}

pub fn (channel PhpTaskChannel) is_closed() bool {
	return PhpValue.from_zval(channel.state.prop_borrowed('closed')).to_bool()
}

// Closing rejects new sends and lets receivers drain messages already queued.
pub fn (channel PhpTaskChannel) close() bool {
	if channel.is_closed() {
		return false
	}
	mut closed := PhpBool.of(true)
	defer {
		closed.release()
	}
	channel.state.set_prop('closed', closed.to_zval())
	return true
}

pub fn (channel PhpTaskChannel) send(value PhpValue, timeout_ms i64) !PhpTaskChannelStatus {
	deadline := checked_task_wait_deadline(timeout_ms)!
	queue := channel.queue() or { return error('Missing task channel queue') }
	// PHP call arguments passed by value already pin the payload on the Fiber
	// stack. Copy only when a V caller explicitly supplies a reference cell.
	mut message := if reference := PhpReference.from_zval(value.to_zval()) {
		reference.deref().owned()
	} else {
		value.borrowed()
	}
	defer {
		message.release()
	}
	for {
		if channel.is_closed() {
			return .closed
		}
		if task_channel_count(queue)! < channel.capacity() {
			mut result := queue.call_method('enqueue', message)
			defer {
				result.release()
			}
			if !result.is_valid() || has_exception() {
				return error('Could not enqueue task channel message')
			}
			return .ready
		}
		if timeout_ms == 0 || task_deadline_reached(deadline) {
			return .timed_out
		}
		if !channel.park(true, deadline)! {
			return .timed_out
		}
	}
	return .timed_out
}

pub fn (channel PhpTaskChannel) receive(timeout_ms i64) !PhpTaskChannelReceive {
	deadline := checked_task_wait_deadline(timeout_ms)!
	queue := channel.queue() or { return error('Missing task channel queue') }
	for {
		if task_channel_count(queue)! > 0 {
			mut result := queue.call_method('dequeue')
			if !result.is_valid() || has_exception() {
				result.release()
				return error('Could not dequeue task channel message')
			}
			return PhpTaskChannelReceive{ status: .ready, value: result }
		}
		if channel.is_closed() {
			return PhpTaskChannelReceive{ status: .closed }
		}
		if timeout_ms == 0 || task_deadline_reached(deadline) {
			break
		}
		if !channel.park(false, deadline)! {
			break
		}
	}
	return PhpTaskChannelReceive{ status: .timed_out }
}

fn (channel PhpTaskChannel) park(sending bool, deadline u64) !bool {
	if !zend.task_can_suspend() {
		return error('A blocking task channel operation requires a scheduled PHP Fiber')
	}
	mut wait := PhpArray.new()
	defer {
		wait.release()
	}
	// The calling Fiber already keeps its channel alive. A strong reference
	// here would root the queue through the suspended native wait frame.
	reference := PhpWeakReference.create(channel.state)!
	wait.set_zval('channel', reference.to_zval())
	wait.bool('sending', sending)
	if deadline > 0 {
		wait.int('deadline', i64(deadline))
	}
	return suspend_task_wait(wait)
}

fn channel_wait_ready(value PhpValue, sending bool) !bool {
	reference := PhpWeakReference.must_from_zval(value.to_zval())!
	mut state := reference.get() or { return error('Task channel no longer exists') }
	defer {
		state.release()
	}
	channel := PhpTaskChannel.from_value(PhpValue.from_zval(state.to_zval())) or {
		return error('Invalid task channel')
	}
	return channel.can_resume(sending)
}

fn (channel PhpTaskChannel) can_resume(sending bool) !bool {
	if channel.is_closed() {
		return true
	}
	queue := channel.queue() or { return error('Missing task channel queue') }
	count := task_channel_count(queue)!
	return if sending { count < channel.capacity() } else { count > 0 }
}

fn task_channel_count(queue PhpObject) !i64 {
	mut result := queue.method[PhpInt]('count')!
	defer {
		result.release()
	}
	return result.value()
}
