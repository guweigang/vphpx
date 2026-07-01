import rt

pub fn Class_WC_WCCOM_Site.auth_error_filter_name() string {
	return 'wccom_auth_error'
}
struct Class_WC_WCCOM_Site {
	rt.PhpObjectBase
}

fn Class_WC_WCCOM_Site.load()  {
	Class_WC_WCCOM_Site.includes()
	rt.call_function('add_action', [rt.new_string('woocommerce_wccom_install_products'), rt.create_array([rt.ArrayItem{ key: none, val: 'WC_WCCOM_Site_Installer' }, rt.ArrayItem{ key: none, val: 'install' }])])
	rt.call_function('add_filter', [rt.new_string('determine_current_user'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'authenticate_wccom' }]), rt.new_int(14)])
	rt.call_function('add_action', [rt.new_string('woocommerce_rest_api_get_rest_namespaces'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'register_rest_namespace' }])])
}

fn Class_WC_WCCOM_Site.includes()  {
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/helper/class-wc-helper.php', '4')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wccom-site/class-wc-wccom-site-installer.php', '4')
}

fn Class_WC_WCCOM_Site.authenticate_wccom(var_user_id rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_user_id)) || rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_WCCOM_Site.is_request_to_wccom_site_rest_api())))))) {
		return (var_user_id).to_bool()
	}
	mut var_auth_header := rt.new_string(rt.new_string(Class_WC_WCCOM_Site.get_authorization_header().to_string().trim_space()))
	if rt.is_true(rt.identical(rt.call_function('stripos', [var_auth_header.dup(), rt.new_string('Bearer ')]), rt.new_int(0))) {
		mut var_access_token := rt.new_string(rt.new_string(rt.call_function('substr', [var_auth_header.dup(), rt.new_int(7)]).to_string().trim_space()))
	} else if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_GET').array_get('token'))) && rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_get('token').is_string())))) {
		var_access_token = rt.new_string(rt.new_string(rt.get_superglobal('_GET').array_get('token').to_string().trim_space()))
		// unsupported statement: Stmt_Nop
	} else {
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	return (create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.no_access_token())).to_bool()
	}
		rt.call_function('add_filter', [Class_WC_WCCOM_Site.auth_error_filter_name(), rt.new_closure(closure_1_fn)])
		return false
	}
	if !(!rt.is_true(rt.get_superglobal('_SERVER').array_get('HTTP_X_WOO_SIGNATURE'))) {
		mut var_signature := rt.new_string(rt.new_string(rt.get_superglobal('_SERVER').array_get('HTTP_X_WOO_SIGNATURE').to_string().trim_space()))
		// unsupported statement: Stmt_Nop
	} else if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_GET').array_get('signature'))) && rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_get('signature').is_string())))) {
		var_signature = rt.new_string(rt.new_string(rt.get_superglobal('_GET').array_get('signature').to_string().trim_space()))
		// unsupported statement: Stmt_Nop
	} else {
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	return (create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.no_signature())).to_bool()
	}
		rt.call_function('add_filter', [Class_WC_WCCOM_Site.auth_error_filter_name(), rt.new_closure(closure_2_fn)])
		return false
	}
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/helper/class-wc-helper-options.php', '4')
	mut var_site_auth := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper_Options{}; return temp.get(arg_0) }(rt.new_string('auth'))
	if !rt.is_true(var_site_auth.array_get('access_token')) {
		closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	return (create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.site_not_connected())).to_bool()
	}
		rt.call_function('add_filter', [Class_WC_WCCOM_Site.auth_error_filter_name(), rt.new_closure(closure_3_fn)])
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('hash_equals', [var_access_token.dup(), var_site_auth.array_get('access_token')]))))) {
		closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	return (create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.invalid_token())).to_bool()
	}
		rt.call_function('add_filter', [Class_WC_WCCOM_Site.auth_error_filter_name(), rt.new_closure(closure_4_fn)])
		return false
	}
	mut var_body := fn () rt.PhpVal { mut temp := Class_WP_REST_Server{}; return temp.get_raw_data() }()
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_WCCOM_Site.verify_wccom_request(var_body.dup(), var_signature.dup(), var_site_auth.array_get('access_token_secret')))))) {
		closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	return (create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.request_verification_failed())).to_bool()
	}
		rt.call_function('add_filter', [Class_WC_WCCOM_Site.auth_error_filter_name(), rt.new_closure(closure_5_fn)])
		return false
	}
	mut var_user := rt.call_function('get_user_by', [rt.new_string('id'), var_site_auth.array_get('user_id')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	return (create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.user_not_found())).to_bool()
	}
		rt.call_function('add_filter', [Class_WC_WCCOM_Site.auth_error_filter_name(), rt.new_closure(closure_6_fn)])
		return false
	}
	return (var_user).to_bool()
}

fn Class_WC_WCCOM_Site.get_authorization_header() string {
	if !(!rt.is_true(rt.get_superglobal('_SERVER').array_get('HTTP_AUTHORIZATION'))) {
		return (rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('HTTP_AUTHORIZATION')])).str()
		// unsupported statement: Stmt_Nop
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('getallheaders')])) {
		mut var_headers := rt.call_function('getallheaders', []rt.PhpVal{})
		{
			mut iter_1 := var_headers.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_key := item_1.key
				if rt.is_true(rt.identical(rt.new_string('authorization'), rt.new_string(var_key.dup().to_string().to_lower()))) {
					return (var_value).str()
				}
			}
		}
	}
	return ''
}

fn Class_WC_WCCOM_Site.is_request_to_wccom_site_rest_api() rt.PhpVal {
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('rest_route')) {
		mut var_route := rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('rest_route')])
		mut var_rest_prefix := rt.new_string(rt.new_string(''))
	} else {
		var_route = rt.call_function('wp_unslash', [rt.call_function('add_query_arg', [rt.new_array()])])
		var_rest_prefix = rt.call_function('trailingslashit', [rt.call_function('rest_get_url_prefix', []rt.PhpVal{})])
	}
	return // unsupported expression: Expr_BinaryOp_NotIdentical
}

fn Class_WC_WCCOM_Site.verify_wccom_request(var_body rt.PhpVal, var_signature rt.PhpVal, var_access_token_secret rt.PhpVal) rt.PhpVal {
	mut var_body_mutated := var_body
	mut var_signature_mutated := var_signature
	mut var_data := { 'host': rt.get_superglobal('_SERVER').array_get('HTTP_HOST'), 'request_uri': rt.call_function('urldecode', [rt.call_function('remove_query_arg', [map[string]rt.PhpVal{}, rt.get_superglobal('_SERVER').array_get('REQUEST_URI')])]), 'method': rt.new_string(rt.get_superglobal('_SERVER').array_get('REQUEST_METHOD').to_string().to_upper()) }
	if !(!rt.is_true(var_body_mutated)) {
		var_data['body'] = var_body_mutated.dup()
	}
	mut var_expected_signature := rt.call_function('hash_hmac', [rt.new_string('sha256'), rt.call_function('wp_json_encode', [var_data.dup()]), var_access_token_secret.dup()])
	return rt.call_function('hash_equals', [var_expected_signature.dup(), var_signature_mutated.dup()])
}

fn Class_WC_WCCOM_Site.register_rest_namespace(var_namespaces rt.PhpVal) rt.PhpVal {
	mut var_namespaces_mutated := var_namespaces
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wccom-site/rest-api/class-wc-rest-wccom-site-installer-error-codes.php', '4')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wccom-site/rest-api/class-wc-rest-wccom-site-installer-error.php', '4')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wccom-site/rest-api/endpoints/abstract-wc-rest-wccom-site-controller.php', '4')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wccom-site/rest-api/endpoints/class-wc-rest-wccom-site-installer-controller.php', '4')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wccom-site/rest-api/endpoints/class-wc-rest-wccom-site-ssr-controller.php', '4')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wccom-site/rest-api/endpoints/class-wc-rest-wccom-site-status-controller.php', '4')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wccom-site/rest-api/endpoints/class-wc-rest-wccom-site-connection-controller.php', '4')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wccom-site/installation/class-wc-wccom-site-installation-state.php', '4')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wccom-site/installation/class-wc-wccom-site-installation-state-storage.php', '4')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wccom-site/installation/class-wc-wccom-site-installation-manager.php', '4')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wccom-site/installation/installation-steps/interface-installaton-step.php', '4')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wccom-site/installation/installation-steps/class-wc-wccom-site-installation-step-get-product-info.php', '4')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wccom-site/installation/installation-steps/class-wc-wccom-site-installation-step-download-product.php', '4')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wccom-site/installation/installation-steps/class-wc-wccom-site-installation-step-unpack-product.php', '4')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wccom-site/installation/installation-steps/class-wc-wccom-site-installation-step-move-product.php', '4')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wccom-site/installation/installation-steps/class-wc-wccom-site-installation-step-activate-product.php', '4')
	var_namespaces_mutated.array_set('wccom-site/v2', rt.create_array([rt.ArrayItem{ key: 'installer', val: 'WC_REST_WCCOM_Site_Installer_Controller' }, rt.ArrayItem{ key: 'ssr', val: 'WC_REST_WCCOM_Site_SSR_Controller' }, rt.ArrayItem{ key: 'status', val: 'WC_REST_WCCOM_Site_Status_Controller' }, rt.ArrayItem{ key: 'connection', val: 'WC_REST_WCCOM_Site_Connection_Controller' }]))
	return var_namespaces_mutated.dup()
}

struct Class_WC_REST_WCCOM_Site_Installer_Error {
	rt.PhpObjectBase
}

struct Class_WC_Helper_Options {
	rt.PhpObjectBase
}

struct Class_WP_REST_Server {
	rt.PhpObjectBase
}

fn create_wc_wccom_site() &Class_WC_WCCOM_Site {
	mut obj := &Class_WC_WCCOM_Site{
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

fn create_wc_helper_options() &Class_WC_Helper_Options {
	mut obj := &Class_WC_Helper_Options{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_server() &Class_WP_REST_Server {
	mut obj := &Class_WP_REST_Server{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_WCCOM_Site) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'load' {
			Class_WC_WCCOM_Site.load()
			return rt.new_null()
		}
		'includes' {
			Class_WC_WCCOM_Site.includes()
			return rt.new_null()
		}
		'authenticate_wccom' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WC_WCCOM_Site.authenticate_wccom(dispatch_arg_0))
		}
		'get_authorization_header' {
			return rt.new_string(Class_WC_WCCOM_Site.get_authorization_header())
		}
		'is_request_to_wccom_site_rest_api' {
			return Class_WC_WCCOM_Site.is_request_to_wccom_site_rest_api()
		}
		'verify_wccom_request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WC_WCCOM_Site.verify_wccom_request(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'register_rest_namespace' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_WCCOM_Site.register_rest_namespace(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_WCCOM_Site) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_WCCOM_Site) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Helper_Options) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper_Options) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_Options) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Server) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Server) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Server) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_wccom_site_class_wc_wccom_site_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	Class_WC_WCCOM_Site.load()
}
