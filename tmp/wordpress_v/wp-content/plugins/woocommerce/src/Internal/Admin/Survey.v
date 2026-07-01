import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Survey.survey_url() string {
	return 'https://automattic.survey.fm'
}
struct Class_Automattic_WooCommerce_Internal_Admin_Survey {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_Survey.get_url(var_path rt.PhpVal, var_query rt.PhpVal) rt.PhpVal {
	mut var_url := rt.new_string(rt.concat(Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_Survey.survey_url(), var_path))
	mut var_query_args := rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_survey_query'), var_query.dup()])
	if !(!rt.is_true(var_query_args)) {
		mut var_query_string := rt.call_function('http_build_query', [var_query_args.dup()])
		var_url = rt.new_string((var_url).str() + '?' + (var_query_string).str())
	}
	return var_url.dup()
}

fn create_automattic_woocommerce_internal_admin_survey() &Class_Automattic_WooCommerce_Internal_Admin_Survey {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Survey{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Survey) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_Survey.get_url(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Survey) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Survey) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_survey_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
