import rt

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_PrepareUrl {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_PrepareUrl) transform(var_value rt.PhpVal, mut var_arguments Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_?stdClass, var_default_value rt.PhpVal) string {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.dup().is_string()))))) {
		return (var_default_value).str()
	}
	mut var_url_parts := rt.call_function('wp_parse_url', [rt.new_string(var_value.dup().to_string().trim_right(' \t\n\r'))])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_url_parts)))) {
		return (var_default_value).str()
	}
	if !(var_url_parts.array_isset(rt.new_string('host'))) {
		return (var_default_value).str()
	}
	if var_url_parts.array_isset(rt.new_string('path')) {
		return (var_url_parts.array_get('host')).str() + (var_url_parts.array_get('path')).str()
	}
	return (var_url_parts.array_get('host')).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_PrepareUrl) validate(mut var_arguments Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_?stdClass) bool {
	return true
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_transformers_prepareurl() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_PrepareUrl {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_PrepareUrl{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_PrepareUrl) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'transform' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_?stdClass](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.transform(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2))
		}
		'validate' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_?stdClass](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.validate(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_PrepareUrl) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_PrepareUrl) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_remotespecs_ruleprocessors_transformers_prepareurl_php() {
}
