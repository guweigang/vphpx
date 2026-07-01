import rt

struct Class_WC_Queue {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_null()
		default_cass rt.PhpVal = rt.new_string('WC_Action_Queue')
}

fn Class_WC_Queue.instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.is_null())) {
		mut var_class := Class_WC_Queue.get_class()
		// unsupported assign target: Expr_StaticPropertyFetch
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn Class_WC_Queue.get_class() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('plugins_loaded')]))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('This function should not be called before plugins_loaded.'), rt.new_string('woocommerce')]), rt.new_string('3.5.0')])
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_queue_class'), // unsupported expression: Expr_StaticPropertyFetch])
}

fn Class_WC_Queue.validate_instance(var_instance rt.PhpVal) rt.PhpVal {
	mut var_instance_mutated := var_instance
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(rt.instance_of(var_instance_mutated, 'WC_Queue_Interface')))) {
		mut var_default_class := // unsupported expression: Expr_StaticPropertyFetch
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The class attached to the "woocommerce_queue_class" does not implement the WC_Queue_Interface interface. The default %s class will be used instead.'), rt.new_string('woocommerce')]), var_default_class.dup()]), rt.new_string('3.5.0')])
		var_instance_mutated = rt.create_object_dynamically(var_default_class, []rt.PhpVal{})
	}
	return var_instance_mutated.dup()
}

fn create_wc_queue() &Class_WC_Queue {
	mut obj := &Class_WC_Queue{
		PhpObjectBase: rt.PhpObjectBase{}
		instance: rt.new_null()
		default_cass: rt.new_string('WC_Action_Queue')
	}
	return obj
}

fn (mut this Class_WC_Queue) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'instance' {
			return Class_WC_Queue.instance()
		}
		'get_class' {
			return Class_WC_Queue.get_class()
		}
		'validate_instance' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Queue.validate_instance(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_Queue) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		'default_cass' { return this.default_cass }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Queue) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
		'default_cass' { this.default_cass = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn init_registry() {
	rt.register_class_factory('WC_Queue', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_queue()
		return rt.new_object('WC_Queue', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_queue_class_wc_queue_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
}
