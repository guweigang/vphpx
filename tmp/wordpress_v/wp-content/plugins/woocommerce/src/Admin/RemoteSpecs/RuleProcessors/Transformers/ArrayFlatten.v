import rt

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_ArrayFlatten {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_ArrayFlatten) transform(var_value rt.PhpVal, mut var_arguments Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_?stdClass, var_default_value rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.dup().is_array()))))) {
		return var_default_value.dup()
	}
	mut var_return := rt.new_array()
	closure_1_fn := fn [mut var_return] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	var_return.array_push(var_item.dup())
	return rt.new_null()
	}
	rt.call_function('array_walk_recursive', [var_value.dup(), rt.new_closure(closure_1_fn)])
	return var_return.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_ArrayFlatten) validate(mut var_arguments Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_?stdClass) bool {
	return true
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_transformers_arrayflatten() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_ArrayFlatten {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_ArrayFlatten{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_ArrayFlatten) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'transform' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_?stdClass](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.transform(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'validate' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_?stdClass](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.validate(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_ArrayFlatten) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_ArrayFlatten) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_remotespecs_ruleprocessors_transformers_arrayflatten_php() {
}
