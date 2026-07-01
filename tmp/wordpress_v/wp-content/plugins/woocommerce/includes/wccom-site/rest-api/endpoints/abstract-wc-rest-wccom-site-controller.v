import rt

struct Class_WC_REST_WCCOM_Site_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wccom-site/v3')
}

fn (mut this Class_WC_REST_WCCOM_Site_Controller) user_has_permission(var_user rt.PhpVal) bool {
	return false
}

fn (mut this Class_WC_REST_WCCOM_Site_Controller) check_permission() bool {
	mut var_current_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(var_current_user) || rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_current_user, 'WP_User'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_current_user, 'exists', []rt.PhpVal{}))))))))) {
		mut var_error := rt.call_function('apply_filters', [Class_WC_WCCOM_Site.auth_error_filter_name(), create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.not_authenticated())])
		return (create_wp_error(rt.call_method(var_error, 'get_error_code', []rt.PhpVal{}), rt.call_method(var_error, 'get_error_message', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_method(var_error, 'get_http_code', []rt.PhpVal{}) }]))).to_bool()
	}
	if !(this.user_has_permission(var_current_user.dup())) {
		var_error = create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.no_permission())
		return (create_wp_error(rt.call_method(var_error, 'get_error_code', []rt.PhpVal{}), rt.call_method(var_error, 'get_error_message', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_method(var_error, 'get_http_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_WCCOM_Site_Controller) get_response(mut var_data Class_array, status i64) rt.PhpVal {
	mut var_response := rt.call_function('rest_ensure_response', [var_data])
	rt.call_method(var_response, 'set_status', [rt.new_int(status)])
	return var_response.dup()
}

struct Class_WC_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WC_REST_WCCOM_Site_Installer_Error {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_rest_wccom_site_controller() &Class_WC_REST_WCCOM_Site_Controller {
	mut obj := &Class_WC_REST_WCCOM_Site_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wccom-site/v3')
	}
	return obj
}

fn create_wc_rest_controller() &Class_WC_REST_Controller {
	mut obj := &Class_WC_REST_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_rest_wccom_site_installer_error() &Class_WC_REST_WCCOM_Site_Installer_Error {
	mut obj := &Class_WC_REST_WCCOM_Site_Installer_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_WCCOM_Site_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'user_has_permission' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.user_has_permission(dispatch_arg_0))
		}
		'check_permission' {
			return rt.new_bool(this.check_permission())
		}
		'get_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.get_response(mut dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_WCCOM_Site_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_WCCOM_Site_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_REST_WCCOM_Site_Installer_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_WCCOM_Site_Installer_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_WCCOM_Site_Installer_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_wccom_site_rest_api_endpoints_abstract_wc_rest_wccom_site_controller_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
