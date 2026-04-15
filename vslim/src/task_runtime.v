module main

import vphp

struct VSlimTaskRequestArgs {
mut:
	boxes []vphp.RequestOwnedZBox
	args  []vphp.ZVal
}

fn build_task_request_args(params []vphp.PersistentOwnedZBox) VSlimTaskRequestArgs {
	mut out := VSlimTaskRequestArgs{
		boxes: []vphp.RequestOwnedZBox{cap: params.len}
		args:  []vphp.ZVal{cap: params.len}
	}
	for param in params {
		mut temp := param.clone_request_owned()
		out.args << temp.to_zval()
		out.boxes << temp
	}
	return out
}

fn (mut args VSlimTaskRequestArgs) release() {
	for mut box in args.boxes {
		box.release()
	}
}

fn task_params_to_persistent(params []vphp.ZVal) []vphp.PersistentOwnedZBox {
	mut out := []vphp.PersistentOwnedZBox{cap: params.len}
	for param in params {
		out << vphp.PersistentOwnedZBox.from_mixed_zval(param)
	}
	return out
}

fn task_cache_result(mut handle VSlimTaskHandle, result vphp.RequestOwnedZBox) {
	if handle.result_box.is_valid() {
		mut old := handle.result_box
		old.release()
	}
	handle.result_box = if result.is_valid() {
		vphp.PersistentOwnedZBox.from_mixed_zval(result.to_zval())
	} else {
		vphp.PersistentOwnedZBox.new_null()
	}
	handle.resolved = true
}

fn task_wait_callable(mut handle VSlimTaskHandle) vphp.RequestOwnedZBox {
	mut args := build_task_request_args(handle.params)
	defer {
		args.release()
	}
	mut result := handle.callable.call_request_owned(args.args)
	defer {
		result.release()
	}
	task_cache_result(mut handle, result)
	return handle.result_box.clone_request_owned()
}

fn task_wait_native(mut handle VSlimTaskHandle) vphp.RequestOwnedZBox {
	mut result := vphp.task_wait_box(handle.async_ref)
	defer {
		result.release()
	}
	task_cache_result(mut handle, result)
	vphp.task_release_handle(handle.async_ref)
	handle.async_ref = unsafe { nil }
	return handle.result_box.clone_request_owned()
}

@[php_method]
pub fn VSlimTask.list() []string {
	return vphp.task_names()
}

@[php_method]
pub fn VSlimTask.spawn(target vphp.RequestBorrowedZBox, params []vphp.ZVal) &VSlimTaskHandle {
	if !target.is_valid() || target.is_null() || target.is_undef() {
		vphp.throw_exception_class('InvalidArgumentException', 'task target must be a callable or registered task name',
			0)
		return &VSlimTaskHandle{}
	}

	mut handle := &VSlimTaskHandle{}
	if target.is_string() {
		task_name := target.to_string()
		if vphp.task_exists(task_name) || !target.is_callable() {
			async_ref := vphp.task_spawn_handle(task_name, params) or {
				vphp.throw_exception(err.msg(), 0)
				return &VSlimTaskHandle{}
			}
			handle.async_ref = async_ref
			return handle
		}
	}

	if target.is_callable() {
		// Request-scoped callable tasks keep a retained callable + detached
		// parameter copies on the handle. The handle itself still only lives for
		// the current request; "persistent" here means explicit ownership by the
		// handle, not a cross-request execution contract.
		handle.callable = vphp.PersistentOwnedZBox.from_callable_zval(target.to_zval())
		handle.params = task_params_to_persistent(params)
		return handle
	}

	vphp.throw_exception_class('InvalidArgumentException', 'task target must be a callable or registered task name',
		0)
	return &VSlimTaskHandle{}
}

@[php_method]
pub fn (mut handle VSlimTaskHandle) wait() vphp.RequestOwnedZBox {
	if handle.resolved {
		return handle.result_box.clone_request_owned()
	}
	if handle.async_ref != unsafe { nil } {
		return task_wait_native(mut handle)
	}
	if handle.callable.is_valid() && handle.callable.is_callable() {
		return task_wait_callable(mut handle)
	}
	return vphp.RequestOwnedZBox.new_null()
}

pub fn (mut handle VSlimTaskHandle) cleanup() {
	if handle.async_ref != unsafe { nil } {
		vphp.task_release_handle(handle.async_ref)
		handle.async_ref = unsafe { nil }
	}
}
