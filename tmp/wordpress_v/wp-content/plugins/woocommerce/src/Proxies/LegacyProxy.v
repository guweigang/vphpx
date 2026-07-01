import rt

struct Class_Automattic_WooCommerce_Proxies_LegacyProxy {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Proxies_LegacyProxy) get_instance_of(class_name string, var_args rt.PhpVal) rt.PhpVal {
	if rt.is_true(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_StringUtil{}; return temp.starts_with(arg_0, arg_1) }(rt.new_string(class_name), rt.new_string('Automattic\\WooCommerce\\'))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Proxies_Exception', []string{}, create_automattic_woocommerce_proxies_exception('The LegacyProxy class is not intended for getting instances of classes whose namespace starts with \'Automattic\\WooCommerce\', please use ' + '\'init\' method injection or \'wc_get_container()->get()\' for that.')))
	}
	mut var_method := rt.new_string('get_instance_of_' + class_name.to_lower())
	if rt.is_true(rt.call_function('method_exists', [rt.new_string(@STRUCT), var_method.dup()])) {
		return rt.call_method(rt.new_object('Automattic_WooCommerce_Proxies_LegacyProxy', []string{}, &this), var_method, [var_args.dup()])
	}
	if rt.is_true(rt.call_function('method_exists', [rt.new_string(class_name), rt.new_string('instance')])) {
		return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Proxies_{"nodeType":"Expr_Variable","line":54,"name":"class_name"}{}; return temp.instance(arg_0) }(var_args.dup())
	}
	if rt.is_true(rt.call_function('method_exists', [rt.new_string(class_name), rt.new_string('load')])) {
		return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Proxies_{"nodeType":"Expr_Variable","line":59,"name":"class_name"}{}; return temp.load(arg_0) }(var_args.dup())
	}
	return rt.create_object_dynamically(class_name, [var_args.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Proxies_LegacyProxy) get_instance_of_wc_queue_interface() rt.PhpVal {
	return fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Proxies_WC_Queue{}; return temp.instance() }()
}

fn (mut this Class_Automattic_WooCommerce_Proxies_LegacyProxy) call_function(var_function_name rt.PhpVal, var_parameters rt.PhpVal) rt.PhpVal {
	return rt.call_function('call_user_func_array', [var_function_name.dup(), var_parameters.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Proxies_LegacyProxy) call_static(var_class_name rt.PhpVal, var_method_name rt.PhpVal, var_parameters rt.PhpVal) rt.PhpVal {
	return rt.call_function('call_user_func_array', [rt.new_string("${var_class_name.to_string()}::${var_method_name.to_string()}"), var_parameters.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Proxies_LegacyProxy) get_global(global_name string) rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	return var_GLOBALS.array_get(global_name)
}

fn (mut this Class_Automattic_WooCommerce_Proxies_LegacyProxy) exit(status string)  {
	// unsupported expression: Expr_Exit
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

fn create_automattic_woocommerce_proxies_legacyproxy() &Class_Automattic_WooCommerce_Proxies_LegacyProxy {
	mut obj := &Class_Automattic_WooCommerce_Proxies_LegacyProxy{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_stringutil() &Class_Automattic_WooCommerce_Utilities_StringUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_StringUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_proxies_exception() &Class_Automattic_WooCommerce_Proxies_Exception {
	mut obj := &Class_Automattic_WooCommerce_Proxies_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_proxies_{"nodetype":"expr_variable","line":54,"name":"class_name"}() &Class_Automattic_WooCommerce_Proxies_{"nodeType":"Expr_Variable","line":54,"name":"class_name"} {
	mut obj := &Class_Automattic_WooCommerce_Proxies_{"nodeType":"Expr_Variable","line":54,"name":"class_name"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_proxies_{"nodetype":"expr_variable","line":59,"name":"class_name"}() &Class_Automattic_WooCommerce_Proxies_{"nodeType":"Expr_Variable","line":59,"name":"class_name"} {
	mut obj := &Class_Automattic_WooCommerce_Proxies_{"nodeType":"Expr_Variable","line":59,"name":"class_name"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_proxies_wc_queue() &Class_Automattic_WooCommerce_Proxies_WC_Queue {
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



pub fn init_wp_content_plugins_woocommerce_src_proxies_legacyproxy_php() {
}
