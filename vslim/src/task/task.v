module task

import vphp

@[php_class: 'VSlim\\Task']
@[heap]
pub struct VSlimTask {}

@[php_class: 'VSlim\\TaskHandle']
@[heap]
pub struct VSlimTaskHandle {
mut:
	async_ref vphp.PhpTaskHandle = vphp.PhpTaskHandle.null() @[php_ignore]
	// Task handles are request-scoped PHP objects, but the callable / params /
	// cached result must outlive the spawn() stack frame and survive until a
	// later wait() or object cleanup(). We therefore retain them with
	// explicit handle ownership and release them from
	// cleanup()/generic_free_raw(), rather than borrowing transient request zvals.
	callable   vphp.PhpCallable = vphp.PhpCallable.invalid()
	params     []vphp.PhpValue
	resolved   bool
	result_box vphp.PhpValue = vphp.PhpValue.invalid() @[php_ignore]
}

fn task_params_to_persistent(params vphp.PhpArray) []vphp.PhpValue {
	mut out := []vphp.PhpValue{cap: params.count()}
	for param in params.value_items() {
		out << param.retain()
	}
	return out
}

fn (mut handle VSlimTaskHandle) cache_value(result vphp.PhpValue) {
	if handle.result_box.is_valid() {
		mut old := handle.result_box
		old.release()
	}
	handle.result_box = if result.is_valid() {
		result.retain()
	} else {
		vphp.PhpValue.null().retain()
	}
	handle.resolved = true
}

fn task_arg_inputs(params []vphp.PhpValue) []vphp.PhpArgInput {
	mut out := []vphp.PhpArgInput{cap: params.len}
	for param in params {
		out << param
	}
	return out
}

fn (mut handle VSlimTaskHandle) wait_callable() vphp.PhpValue {
	args := task_arg_inputs(handle.params)
	mut result := handle.callable.invoke(...args)
	defer {
		result.release()
	}
	handle.cache_value(result)
	return handle.result_box.owned()
}

fn (mut handle VSlimTaskHandle) wait_native() vphp.PhpValue {
	mut result := handle.async_ref.wait_value()
	defer {
		result.release()
	}
	handle.cache_value(result)
	handle.async_ref.release()
	handle.async_ref = vphp.PhpTaskHandle.null()
	return handle.result_box.owned()
}

@[php_method]
pub fn VSlimTask.list() []string {
	return vphp.PhpTask.names()
}

@[php_method]
pub fn VSlimTask.spawn(target vphp.PhpValue, params vphp.PhpArray) &VSlimTaskHandle {
	if !target.is_valid() || target.is_null() || target.is_undef() {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'task target must be a callable or registered task name', 0)
		return &VSlimTaskHandle{}
	}

	mut handle := &VSlimTaskHandle{}
	if target.is_string() {
		task_name := target.to_string()
		native_task := vphp.PhpTask.named(task_name)
		if native_task.exists() || !target.is_callable() {
			async_ref := native_task.spawn(params.items()) or {
				vphp.PhpException.raise(err.msg(), 0)
				return &VSlimTaskHandle{}
			}
			handle.async_ref = async_ref
			return handle
		}
	}

	if callable := target.as_callable() {
		// Request-scoped callable tasks keep a retained callable + detached
		// parameter copies on the handle. The handle itself still only lives for
		// the current request; "persistent" here means explicit ownership by the
		// handle, not a cross-request execution contract.
		handle.callable = callable.retain()
		handle.params = task_params_to_persistent(params)
		return handle
	}

	vphp.PhpException.raise_class('InvalidArgumentException',
		'task target must be a callable or registered task name', 0)
	return &VSlimTaskHandle{}
}

@[php_method]
pub fn (mut handle VSlimTaskHandle) wait() vphp.PhpValue {
	if handle.resolved {
		return handle.result_box.to_request_owned()
	}
	if handle.async_ref.is_valid() {
		return handle.wait_native()
	}
	if handle.callable.is_valid() && handle.callable.is_callable() {
		return handle.wait_callable()
	}
	return vphp.PhpValue.null()
}

pub fn (mut handle VSlimTaskHandle) cleanup() {
	if handle.async_ref.is_valid() {
		handle.async_ref.release()
		handle.async_ref = vphp.PhpTaskHandle.null()
	}
}
