import rt

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_DotNotation {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_DotNotation) transform(var_value rt.PhpVal, mut var_arguments Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_?stdclass, var_default_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(var_value_mutated.dup().is_object())) {
		var_value_mutated = rt.call_function('json_decode', [rt.call_function('wp_json_encode', [var_value_mutated.dup()]), rt.new_bool(true)])
	}
	return this.get(var_value_mutated.dup(), rt.get_property(var_arguments, 'path'), var_default_value.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_DotNotation) get(var_array_to_search rt.PhpVal, var_path rt.PhpVal, var_default_value rt.PhpVal) rt.PhpVal {
	mut var_array_to_search_mutated := var_array_to_search
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_array_to_search_mutated.dup().is_array()))))) {
		return var_default_value.dup()
	}
	if var_array_to_search_mutated.array_isset(var_path) {
		return var_array_to_search_mutated.array_get(var_path)
	}
	{
		mut iter_1 := rt.call_function('explode', [rt.new_string('.'), var_path.dup()]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_segment := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_array_to_search_mutated.dup().is_array()))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_array_to_search_mutated.dup().array_isset(var_segment.dup())))))))) {
				return var_default_value.dup()
			}
			var_array_to_search_mutated = var_array_to_search_mutated.array_get(var_segment)
		}
	}
	return var_array_to_search_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_DotNotation) validate(mut var_arguments Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_?stdClass) bool {
	if !(!(rt.get_property(var_arguments, 'path')).is_null()) {
		return false
	}
	return true
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_transformers_dotnotation() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_DotNotation {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_DotNotation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_DotNotation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'transform' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_?stdclass](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.transform(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'validate' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_?stdClass](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.validate(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_DotNotation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_DotNotation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_remotespecs_ruleprocessors_transformers_dotnotation_php() {
}
