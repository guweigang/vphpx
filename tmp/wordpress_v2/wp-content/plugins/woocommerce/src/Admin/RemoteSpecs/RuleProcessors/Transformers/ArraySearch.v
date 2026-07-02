import rt

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_ArraySearch {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_ArraySearch) transform(var_value rt.PhpVal, mut var_arguments Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_?stdClass, var_default_value rt.PhpVal) rt.PhpVal {
	if !(var_value.clone().is_array()) {
		return var_default_value.clone()
	}
	mut var_key := rt.call_function('array_search', [rt.get_property(var_arguments, 'value'), var_value.clone(), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_key)))) {
		return var_value.array_get(var_key)
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_ArraySearch) validate(mut var_arguments Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_?stdClass) bool {
	if !(!(rt.get_property(var_arguments, 'value')).is_null()) {
		return false
	}
	return true
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_transformers_arraysearch(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_ArraySearch {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_ArraySearch{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_ArraySearch) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_ArraySearch) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_ArraySearch) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
