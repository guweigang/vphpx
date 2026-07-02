import rt

struct Class_WpOrg_Requests_Utility_FilteredIterator {
	rt.PhpObjectBase
pub mut:
	callback rt.PhpVal = rt.new_null()
}

fn (mut this Class_WpOrg_Requests_Utility_FilteredIterator) construct(var_data rt.PhpVal, var_callback rt.PhpVal) {
	mut iife_temp_0 := Class_WpOrg_Requests_Utility_InputValidator{}
	mut iife_result_0 := iife_temp_0.is_iterable(var_data.clone())
	if rt.is_true(rt.identical(rt.new_bool(var_data.clone().is_object()), rt.new_bool(true)))
		|| rt.is_true(rt.identical(iife_result_0, rt.new_bool(false))) {
		mut iife_temp_1 := Class_WpOrg_Requests_Exception_InvalidArgument{}
		mut iife_result_1 := iife_temp_1.create(rt.new_int(1), rt.new_string('$data'),
			rt.new_string('iterable'), rt.call_function('gettype', [
			var_data.clone()]))
		rt.throw_exception(iife_result_1)
	}
	this.Class_ArrayIterator.construct(var_data.clone())
	if rt.is_true(rt.call_function('is_callable', [var_callback.clone()])) {
		this.callback = var_callback.clone()
	}
}

fn (mut this Class_WpOrg_Requests_Utility_FilteredIterator) magic_unserialize(var_data rt.PhpVal) {
}

fn (mut this Class_WpOrg_Requests_Utility_FilteredIterator) magic_wakeup() {
	this.callback = rt.new_null()
}

fn (mut this Class_WpOrg_Requests_Utility_FilteredIterator) current() rt.PhpVal {
	mut var_value := this.Class_ArrayIterator.current()
	if rt.is_true(rt.call_function('is_callable', [this.callback])) {
		var_value = rt.call_function('call_user_func', [this.callback, var_value.clone()])
	}
	return var_value.clone()
}

fn (mut this Class_WpOrg_Requests_Utility_FilteredIterator) unserialize(var_data rt.PhpVal) {
}

struct Class_ArrayIterator {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Utility_InputValidator {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Exception_InvalidArgument {
	rt.PhpObjectBase
}

fn create_wporg_requests_utility_filterediterator(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_WpOrg_Requests_Utility_FilteredIterator {
	mut obj := &Class_WpOrg_Requests_Utility_FilteredIterator{
		PhpObjectBase: rt.PhpObjectBase{}
		callback:      rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_arrayiterator(_args ...rt.PhpVal) &Class_ArrayIterator {
	mut obj := &Class_ArrayIterator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_utility_inputvalidator(_args ...rt.PhpVal) &Class_WpOrg_Requests_Utility_InputValidator {
	mut obj := &Class_WpOrg_Requests_Utility_InputValidator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_exception_invalidargument(_args ...rt.PhpVal) &Class_WpOrg_Requests_Exception_InvalidArgument {
	mut obj := &Class_WpOrg_Requests_Exception_InvalidArgument{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WpOrg_Requests_Utility_FilteredIterator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'__unserialize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.magic_unserialize(dispatch_arg_0)
			return rt.new_null()
		}
		'__wakeup' {
			this.magic_wakeup()
			return rt.new_null()
		}
		'current' {
			return this.current()
		}
		'unserialize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.unserialize(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WpOrg_Requests_Utility_FilteredIterator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'callback' { return this.callback }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WpOrg_Requests_Utility_FilteredIterator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'callback' {
			this.callback = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_ArrayIterator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ArrayIterator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ArrayIterator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WpOrg_Requests_Utility_InputValidator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Utility_InputValidator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Utility_InputValidator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WpOrg_Requests_Exception_InvalidArgument) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Exception_InvalidArgument) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Exception_InvalidArgument) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
