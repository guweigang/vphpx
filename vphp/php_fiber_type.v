module vphp

// PhpFiber preserves the identity and state of a native PHP Fiber.
pub struct PhpFiber {
	PhpObject
}

pub fn PhpFiber.from_zval(z ZVal) ?PhpFiber {
	if !z.is_object() || !z.is_instance_of('Fiber') {
		return none
	}
	return PhpFiber{ PhpObject: PhpObject.borrowed(z) }
}

pub fn PhpFiber.must_from_zval(z ZVal) !PhpFiber {
	return PhpFiber.from_zval(z) or { error('zval is not a PHP Fiber') }
}

// new creates a request-scoped Fiber without running its callback.
pub fn PhpFiber.new(callback PhpCallable) !PhpFiber {
	mut object := PhpClass.named('Fiber').construct(callback)!
	mut value := object.take_value()
	return PhpFiber.must_from_zval(value.move_to_request_scope().to_zval())
}

// current returns the active PHP Fiber, or none on the main stack.
pub fn PhpFiber.current() ?PhpFiber {
	mut value := PhpClass.named('Fiber').call_static('getCurrent')
	if !value.is_object() {
		value.release()
		return none
	}
	return PhpFiber.from_zval(value.move_to_request_scope().to_zval())
}

// current_id is an opaque execution-context key, with zero for the main stack.
// The key is valid for the lifetime of its context.
pub fn PhpFiber.current_id() usize {
	return current_fiber_id()
}

pub fn (f PhpFiber) to_borrowed() PhpFiber {
	return PhpFiber{ PhpObject: f.PhpObject.to_borrowed() }
}

pub fn (f PhpFiber) borrowed() PhpFiber {
	return f.to_borrowed()
}

pub fn (f PhpFiber) to_request_owned() PhpFiber {
	return PhpFiber{ PhpObject: f.PhpObject.to_request_owned() }
}

pub fn (f PhpFiber) owned() PhpFiber {
	return f.to_request_owned()
}

pub fn (f PhpFiber) to_persistent_owned() PhpFiber {
	return PhpFiber{ PhpObject: f.PhpObject.to_persistent_owned() }
}

pub fn (f PhpFiber) retain() PhpFiber {
	return f.to_persistent_owned()
}

// Fiber operations return request-owned values. A native PHP exception stays
// pending for the caller to propagate across the VPHP boundary.
pub fn (f PhpFiber) start(args ...PhpArgInput) !PhpValue {
	return fiber_result(f.call_method('start', ...args), 'start')
}

pub fn (f PhpFiber) start_args(args PhpArray) !PhpValue {
	return fiber_result(f.call_method_args('start', args), 'start')
}

pub fn (f PhpFiber) resume(value PhpArgInput) !PhpValue {
	return fiber_result(f.call_method('resume', value), 'resume')
}

pub fn (f PhpFiber) throw_into(exception PhpThrowable) !PhpValue {
	return fiber_result(f.call_method('throw', exception), 'throw')
}

pub fn (f PhpFiber) get_return() !PhpValue {
	return fiber_result(f.call_method('getReturn'), 'getReturn')
}

pub fn PhpFiber.suspend(value PhpArgInput) !PhpValue {
	return fiber_result(PhpClass.named('Fiber').call_static('suspend', value), 'suspend')
}

pub fn (f PhpFiber) is_started() !bool {
	return f.fiber_state('isStarted')
}

pub fn (f PhpFiber) is_running() !bool {
	return f.fiber_state('isRunning')
}

pub fn (f PhpFiber) is_suspended() !bool {
	return f.fiber_state('isSuspended')
}

pub fn (f PhpFiber) is_terminated() !bool {
	return f.fiber_state('isTerminated')
}

fn (f PhpFiber) fiber_state(method string) !bool {
	mut result := fiber_result(f.call_method(method), method)!
	defer {
		result.release()
	}
	return result.to_bool()
}

fn fiber_result(value PhpValue, method string) !PhpValue {
	if has_exception() || !value.is_valid() || value.is_undef() {
		mut discarded := value
		discarded.release()
		return error('PHP Fiber::${method}() failed')
	}
	return value
}
