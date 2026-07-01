import rt

struct Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_null()
		facade_over_classname rt.PhpVal = rt.new_string('')
		deprecated_in_version rt.PhpVal = rt.new_string('')
		logged_messages rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade) construct()  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.instance = rt.create_object_dynamically(// unsupported expression: Expr_StaticPropertyFetch, []rt.PhpVal{})
	}
}

fn Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade.log_deprecation(var_function rt.PhpVal)  {
	mut var_message := rt.call_function('sprintf', [rt.new_string('%1$s is deprecated since version %2$s! Use %3$s instead.'), (Class_Automattic_WooCommerce_Admin_static.class()).str() + '::' + (var_function).str(), // unsupported expression: Expr_StaticPropertyFetch, (// unsupported expression: Expr_StaticPropertyFetch).str() + '::' + (var_function).str()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_message = rt.new_string(rt.concat(var_message, rt.call_function('sprintf', [rt.new_string(' Use %s instead.'), (// unsupported expression: Expr_StaticPropertyFetch).str() + '::' + (var_function).str()])))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_message.dup(), // unsupported expression: Expr_StaticPropertyFetch, rt.new_bool(true)]))))) {
		rt.call_function('error_log', [var_message.dup()])
		// unsupported expression: Expr_StaticPropertyFetch.array_push(var_message.dup())
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade) magic_call(var_name rt.PhpVal, var_arguments rt.PhpVal) rt.PhpVal {
	Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade.log_deprecation(var_name.dup())
	if !(!(this.instance).is_null()) {
		return rt.new_null()
	}
	return rt.call_function('call_user_func_array', [rt.create_array([rt.ArrayItem{ key: none, val: this.instance }, rt.ArrayItem{ key: none, val: var_name }]), var_arguments.dup()])
}

fn Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade.magic_callstatic(var_name rt.PhpVal, var_arguments rt.PhpVal) rt.PhpVal {
	Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade.log_deprecation(var_name.dup())
	if rt.is_true(rt.identical(rt.new_string(''), // unsupported expression: Expr_StaticPropertyFetch)) {
		return rt.new_null()
	}
	return rt.call_function('call_user_func_array', [rt.create_array([rt.ArrayItem{ key: none, val: // unsupported expression: Expr_StaticPropertyFetch }, rt.ArrayItem{ key: none, val: var_name }]), var_arguments.dup()])
}

fn create_automattic_woocommerce_admin_deprecatedclassfacade() &Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade {
	mut obj := &Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade{
		PhpObjectBase: rt.PhpObjectBase{}
		instance: rt.new_null()
		facade_over_classname: rt.new_string('')
		deprecated_in_version: rt.new_string('')
		logged_messages: rt.new_array()
	}
	obj.construct()
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'log_deprecation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade.log_deprecation(dispatch_arg_0)
			return rt.new_null()
		}
		'__call' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.magic_call(dispatch_arg_0, dispatch_arg_1)
		}
		'__callStatic' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade.magic_callstatic(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		'facade_over_classname' { return this.facade_over_classname }
		'deprecated_in_version' { return this.deprecated_in_version }
		'logged_messages' { return this.logged_messages }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
		'facade_over_classname' { this.facade_over_classname = val; return true }
		'deprecated_in_version' { this.deprecated_in_version = val; return true }
		'logged_messages' { this.logged_messages = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Admin_DeprecatedClassFacade', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_deprecatedclassfacade()
		return rt.new_object('Automattic_WooCommerce_Admin_DeprecatedClassFacade', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_admin_deprecatedclassfacade_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
