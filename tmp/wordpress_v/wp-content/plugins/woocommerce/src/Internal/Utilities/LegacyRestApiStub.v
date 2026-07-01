import rt

struct Class_Automattic_WooCommerce_Internal_Utilities_LegacyRestApiStub {
	rt.PhpObjectBase
pub mut:
	rest_api_util rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_LegacyRestApiStub) register() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'add_rewrite_rules_for_legacy_rest_api_stub' }]),
		rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('query_vars'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'add_query_vars_for_legacy_rest_api_stub' }]),
		rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('parse_request'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'parse_legacy_rest_api_request' }]),
		rt.new_int(0)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_LegacyRestApiStub) init(mut var_rest_api_util Class_Automattic_WooCommerce_Utilities_RestApiUtil) {
	this.rest_api_util = var_rest_api_util.dup()
}

fn Class_Automattic_WooCommerce_Internal_Utilities_LegacyRestApiStub.add_rewrite_rules_for_legacy_rest_api_stub() {
	rt.call_function('add_rewrite_rule', [rt.new_string('^wc-api/v([1-3]{1})/?$'),
		rt.new_string('index.php?wc-api-version=$matches[1]&wc-api-route=/'),
		rt.new_string('top')])
	rt.call_function('add_rewrite_rule', [rt.new_string('^wc-api/v([1-3]{1})(.*)?'),
		rt.new_string('index.php?wc-api-version=$matches[1]&wc-api-route=$matches[2]'),
		rt.new_string('top')])
	rt.call_function('add_rewrite_endpoint', [rt.new_string('wc-api'),
		rt.get_constant('EP_ALL')])
}

fn Class_Automattic_WooCommerce_Internal_Utilities_LegacyRestApiStub.add_query_vars_for_legacy_rest_api_stub(var_vars rt.PhpVal) rt.PhpVal {
	mut var_vars_mutated := var_vars
	var_vars_mutated.array_push('wc-api-version')
	var_vars_mutated.array_push('wc-api-route')
	var_vars_mutated.array_push('wc-api')
	return var_vars_mutated.dup()
}

fn Class_Automattic_WooCommerce_Internal_Utilities_LegacyRestApiStub.parse_legacy_rest_api_request() {
	mut var_wp := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Legacy_REST_API_Plugin'),
	]))
	{
		return rt.new_null()
	}
	Class_Automattic_WooCommerce_Internal_Utilities_LegacyRestApiStub.maybe_process_wc_api_query_var()
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get('wc-api-version'))) {
		rt.get_property(var_wp, 'query_vars').array_set('wc-api-version',
			rt.get_superglobal('_GET').array_get('wc-api-version'))
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get('wc-api-route'))) {
		rt.get_property(var_wp, 'query_vars').array_set('wc-api-route',
			rt.get_superglobal('_GET').array_get('wc-api-route'))
	}
	if !(!rt.is_true(rt.get_property(var_wp, 'query_vars').array_get('wc-api-version')))
		&& !(!rt.is_true(rt.get_property(var_wp, 'query_vars').array_get('wc-api-route'))) {
		rt.call_function('header', [
			rt.call_function('sprintf', [rt.new_string('Content-Type: %s; charset=%s'),
				if rt.get_superglobal('_GET').array_isset(rt.new_string('_jsonp')) {
					rt.new_string('application/javascript')
				} else {
					rt.new_string('application/json')
				}, rt.call_function('get_option', [rt.new_string('blog_charset')])]),
		])
		rt.call_function('status_header', [rt.new_int(404)])
		rt.echo_val(rt.call_function('wp_json_encode', [
			rt.create_array([
				rt.ArrayItem{ key: 'errors', val: rt.create_array([
					rt.ArrayItem{ key: 'code', val: 'woocommerce_api_disabled' },
					rt.ArrayItem{
						key: 'message'
						val: 'The WooCommerce API is disabled on this site'
					},
				]) },
			]),
		]))
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_Nop
}

fn Class_Automattic_WooCommerce_Internal_Utilities_LegacyRestApiStub.maybe_process_wc_api_query_var() {
	mut var_wp := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get('wc-api'))) {
		rt.get_property(var_wp, 'query_vars').array_set('wc-api', rt.call_function('sanitize_key', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('wc-api')]),
		]))
	}
	if !(!rt.is_true(rt.get_property(var_wp, 'query_vars').array_get('wc-api'))) {
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.call_function('wc_nocache_headers', []rt.PhpVal{})
		mut var_api_request := rt.new_string(rt.new_string(rt.call_function('wc_clean', [
			rt.get_property(var_wp, 'query_vars').array_get('wc-api'),
		]).to_string().to_lower()))
		rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})
		rt.call_function('do_action', [rt.new_string('woocommerce_api_request'),
			var_api_request.dup()])
		rt.call_function('status_header', [if rt.is_true(rt.call_function('has_action', [
			'woocommerce_api_' + var_api_request.str(),
		]))
		{ rt.new_int(200) } else { rt.new_int(400) }])
		rt.call_function('do_action', ['woocommerce_api_' + var_api_request.str()])
		rt.call_function('ob_end_clean', []rt.PhpVal{})
		// unsupported expression: Expr_Exit
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_LegacyRestApiStub) get_endpoint_data(var_endpoint rt.PhpVal, var_params rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_doing_it_wrong', [rt.new_string('get_endpoint_data'),
		rt.new_string("'WC()->api->get_endpoint_data' is deprecated, please use the following instead: wc_get_container()->get(Automattic\\WooCommerce\\Utilities\\RestApiUtil::class)->get_endpoint_data"),
		rt.new_string('9.1.0')])
	return rt.call_method(this.rest_api_util, 'get_endpoint_data', [
		var_endpoint.dup(), var_params.dup()])
}

fn create_automattic_woocommerce_internal_utilities_legacyrestapistub() &Class_Automattic_WooCommerce_Internal_Utilities_LegacyRestApiStub {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_LegacyRestApiStub{
		PhpObjectBase: rt.PhpObjectBase{}
		rest_api_util: rt.new_null()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_LegacyRestApiStub) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			this.register()
			return rt.new_null()
		}
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_RestApiUtil](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'add_rewrite_rules_for_legacy_rest_api_stub' {
			Class_Automattic_WooCommerce_Internal_Utilities_LegacyRestApiStub.add_rewrite_rules_for_legacy_rest_api_stub()
			return rt.new_null()
		}
		'add_query_vars_for_legacy_rest_api_stub' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Utilities_LegacyRestApiStub.add_query_vars_for_legacy_rest_api_stub(dispatch_arg_0)
		}
		'parse_legacy_rest_api_request' {
			Class_Automattic_WooCommerce_Internal_Utilities_LegacyRestApiStub.parse_legacy_rest_api_request()
			return rt.new_null()
		}
		'maybe_process_wc_api_query_var' {
			Class_Automattic_WooCommerce_Internal_Utilities_LegacyRestApiStub.maybe_process_wc_api_query_var()
			return rt.new_null()
		}
		'get_endpoint_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_endpoint_data(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_LegacyRestApiStub) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_api_util' { return this.rest_api_util }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_LegacyRestApiStub) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_api_util' {
			this.rest_api_util = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_src_internal_utilities_legacyrestapistub_php() {
}
