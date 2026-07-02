import rt

struct Class_Automattic_WooCommerce_Proxies_LegacyProxy {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Proxies_LegacyProxy) get_instance_of(class_name string, var_args rt.PhpVal) rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_StringUtil{}
	mut iife_result_0 := iife_temp_0.starts_with(rt.new_string(class_name), rt.new_string('Automattic\\WooCommerce\\'))
	if rt.is_true(iife_result_0) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Proxies_Exception', []string{}, create_automattic_woocommerce_proxies_exception('The LegacyProxy class is not intended for getting instances of classes whose namespace starts with \'Automattic\\WooCommerce\', please use ' + '\'init\' method injection or \'wc_get_container()->get()\' for that.')))
	}
	mut var_method := rt.new_string('get_instance_of_' + class_name.to_lower())
	if rt.is_true(rt.call_function('method_exists', [rt.new_string(@STRUCT), var_method.clone()])) {
		return rt.call_method(rt.new_object('Automattic_WooCommerce_Proxies_LegacyProxy', []string{}, &this), var_method, [var_args.clone()])
	}
	if rt.is_true(rt.call_function('method_exists', [rt.new_string(class_name), rt.new_string('instance')])) {
		mut iife_temp_1 := Class_Automattic_WooCommerce_Proxies_{"nodeType":"Expr_Variable","line":54,"name":"class_name"}{}
		mut iife_result_1 := iife_temp_1.instance(var_args.clone())
		return iife_result_1
	}
	if rt.is_true(rt.call_function('method_exists', [rt.new_string(class_name), rt.new_string('load')])) {
		mut iife_temp_2 := Class_Automattic_WooCommerce_Proxies_{"nodeType":"Expr_Variable","line":59,"name":"class_name"}{}
		mut iife_result_2 := iife_temp_2.load(var_args.clone())
		return iife_result_2
	}
	return rt.new_object('', []string{}, rt.create_object_dynamically(class_name, [var_args.clone()]))
}

fn (mut this Class_Automattic_WooCommerce_Proxies_LegacyProxy) get_instance_of_wc_queue_interface() rt.PhpVal {
	mut iife_temp_3 := Class_Automattic_WooCommerce_Proxies_WC_Queue{}
	mut iife_result_3 := iife_temp_3.instance()
	return iife_result_3
}

fn (mut this Class_Automattic_WooCommerce_Proxies_LegacyProxy) call_function(var_function_name rt.PhpVal, var_parameters rt.PhpVal) rt.PhpVal {
	return rt.call_function('call_user_func_array', [var_function_name.clone(), var_parameters.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Proxies_LegacyProxy) call_static(var_class_name rt.PhpVal, var_method_name rt.PhpVal, var_parameters rt.PhpVal) rt.PhpVal {
	return rt.call_function('call_user_func_array', [rt.new_string("${var_class_name.to_string()}::${var_method_name.to_string()}"), var_parameters.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Proxies_LegacyProxy) get_global(global_name string) rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	return var_GLOBALS.array_get(rt.new_string(global_name))
}

fn (mut this Class_Automattic_WooCommerce_Proxies_LegacyProxy) exit(status string) {
	fn () { print((rt.new_string(status)).str()); exit(0) }()
}

struct Class_Automattic_WooCommerce_Utilities_StringUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Proxies_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Proxies_{"nodeType":"Expr_Variable","line":54,"name":"class_name"} {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Proxies_{"nodeType":"Expr_Variable","line":59,"name":"class_name"} {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Proxies_WC_Queue {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_proxies_legacyproxy(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Proxies_LegacyProxy {
	mut obj := &Class_Automattic_WooCommerce_Proxies_LegacyProxy{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_stringutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_StringUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_StringUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_proxies_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Proxies_Exception {
	mut obj := &Class_Automattic_WooCommerce_Proxies_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_proxies_{"nodetype":"expr_variable","line":54,"name":"class_name"}(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Proxies_{"nodeType":"Expr_Variable","line":54,"name":"class_name"} {
	mut obj := &Class_Automattic_WooCommerce_Proxies_{"nodeType":"Expr_Variable","line":54,"name":"class_name"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_proxies_{"nodetype":"expr_variable","line":59,"name":"class_name"}(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Proxies_{"nodeType":"Expr_Variable","line":59,"name":"class_name"} {
	mut obj := &Class_Automattic_WooCommerce_Proxies_{"nodeType":"Expr_Variable","line":59,"name":"class_name"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_proxies_wc_queue(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Proxies_WC_Queue {
	mut obj := &Class_Automattic_WooCommerce_Proxies_WC_Queue{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Proxies_LegacyProxy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance_of' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_instance_of(dispatch_arg_0, dispatch_arg_1)
		}
		'get_instance_of_wc_queue_interface' {
			return this.get_instance_of_wc_queue_interface()
		}
		'call_function' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.call_function(dispatch_arg_0, dispatch_arg_1)
		}
		'call_static' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.call_static(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_global' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_global(dispatch_arg_0)
		}
		'exit' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.exit(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Proxies_LegacyProxy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Proxies_LegacyProxy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Proxies_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Proxies_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Proxies_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Proxies_{"nodeType":"Expr_Variable","line":54,"name":"class_name"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Proxies_{"nodeType":"Expr_Variable","line":54,"name":"class_name"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Proxies_{"nodeType":"Expr_Variable","line":54,"name":"class_name"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Proxies_{"nodeType":"Expr_Variable","line":59,"name":"class_name"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Proxies_{"nodeType":"Expr_Variable","line":59,"name":"class_name"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Proxies_{"nodeType":"Expr_Variable","line":59,"name":"class_name"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Proxies_WC_Queue) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Proxies_WC_Queue) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Proxies_WC_Queue) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Proxies_LegacyProxy', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_proxies_legacyproxy()
		return rt.new_object('Automattic_WooCommerce_Proxies_LegacyProxy', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Utilities_StringUtil', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_utilities_stringutil()
		return rt.new_object('Automattic_WooCommerce_Utilities_StringUtil', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Proxies_Exception', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_proxies_exception()
		return rt.new_object('Automattic_WooCommerce_Proxies_Exception', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Proxies_{"nodeType":"Expr_Variable","line":54,"name":"class_name"}', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_proxies_{"nodetype":"expr_variable","line":54,"name":"class_name"}()
		return rt.new_object('Automattic_WooCommerce_Proxies_{"nodeType":"Expr_Variable","line":54,"name":"class_name"}', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Proxies_{"nodeType":"Expr_Variable","line":59,"name":"class_name"}', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_proxies_{"nodetype":"expr_variable","line":59,"name":"class_name"}()
		return rt.new_object('Automattic_WooCommerce_Proxies_{"nodeType":"Expr_Variable","line":59,"name":"class_name"}', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Proxies_WC_Queue', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_proxies_wc_queue()
		return rt.new_object('Automattic_WooCommerce_Proxies_WC_Queue', []string{}, obj)
	})
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

}
