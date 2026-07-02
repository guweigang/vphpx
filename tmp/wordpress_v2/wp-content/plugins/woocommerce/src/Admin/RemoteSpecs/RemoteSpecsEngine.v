import rt

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine.log_errors(var_errors rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), rt.call_function('defined', [rt.new_string('WP_ENVIRONMENT_TYPE')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.call_function('constant', [rt.new_string('WP_ENVIRONMENT_TYPE')]), rt.create_array([rt.ArrayItem{
		key: none
		val: 'development'
	}, rt.ArrayItem{ key: none, val: 'local' }]), rt.new_bool(true)]))))) {
		return
	}
	mut var_logger := rt.call_function('wc_get_logger', []rt.PhpVal{})
	mut var_error_messages := rt.new_array()
	mut iter_1 := var_errors.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_error := item_1.val
		if !var_error.is_null()
			&& rt.is_true(rt.call_function('method_exists', [var_error.clone(), rt.new_string('getMessage')])) {
			var_error_messages.array_push(rt.call_method(var_error, 'getMessage', []rt.PhpVal{}))
		}
	}
	rt.call_method(var_logger, 'error', [rt.new_string('Error while evaluating specs'),
		rt.create_array([rt.ArrayItem{ key: 'source', val: 'remotespecsengine-errors' },
			rt.ArrayItem{
				key: 'class'
				val: Class_Automattic_WooCommerce_Admin_RemoteSpecs_static.class()
			}, rt.ArrayItem{ key: 'errors', val: var_error_messages }])])
}

fn create_automattic_woocommerce_admin_remotespecs_remotespecsengine(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'log_errors' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine.log_errors(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
