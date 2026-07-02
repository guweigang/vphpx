import rt

struct Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyClient {
	rt.PhpObjectBase
pub mut:
	credentials rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyClient) construct(mut var_credentials Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array) {
	mut var_credentials_mutated := var_credentials
	this.credentials = var_credentials_mutated
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyClient) rest_request(path string, mut var_query_params Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array, method string, mut var_body Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array) rt.PhpVal {
	mut var_credentials := this.get_credentials()
	if rt.is_true(rt.call_function('is_wp_error', [var_credentials.clone()])) {
		return var_credentials.clone()
	}
	mut var_rest_endpoint := rt.new_string(this.build_rest_url((var_credentials.array_get(rt.new_string('domain'))).str(),
		path, mut var_query_params))
	mut var_request_args := this.build_request_args((var_credentials.array_get(rt.new_string('access_token'))).str(),
		method, mut var_body)
	mut var_response := rt.call_function('wp_remote_request', [
		var_rest_endpoint.clone(), var_request_args.clone()])
	return this.process_response(var_response.clone(), path)
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyClient) graphql_request(query string, mut var_variables Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array) rt.PhpVal {
	mut var_credentials := this.get_credentials()
	if rt.is_true(rt.call_function('is_wp_error', [var_credentials.clone()])) {
		return var_credentials.clone()
	}
	mut var_graphql_endpoint :=
		rt.new_string(this.build_graphql_url((var_credentials.array_get(rt.new_string('domain'))).str()))
	mut var_request_args := this.build_graphql_request_args((var_credentials.array_get(rt.new_string('access_token'))).str(),
		query, mut var_variables)
	mut var_response := rt.call_function('wp_remote_request', [
		var_graphql_endpoint.clone(), var_request_args.clone()])
	return this.process_graphql_response(var_response.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyClient) get_credentials() rt.PhpVal {
	if !rt.is_true(this.credentials.array_get(rt.new_string('shop_url')))
		|| !rt.is_true(this.credentials.array_get(rt.new_string('access_token'))) {
		return create_automattic_woocommerce_internal_cli_migrator_platforms_shopify_wp_error(rt.new_string('api_error'),
			rt.new_string('Shopify API credentials (shop_url, access_token) are not configured. Please run: wp wc migrate setup'))
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'domain', val: this.credentials.array_get(rt.new_string('shop_url')) },
		rt.ArrayItem{
			key: 'access_token'
			val: this.credentials.array_get(rt.new_string('access_token'))
		},
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyClient) build_rest_url(domain string, path string, mut var_query_params Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array) string {
	mut domain_mutated := domain
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
		rt.new_string('~^https?://~i'),
		rt.new_string(domain_mutated).clone(),
	])))))
	{
		domain_mutated = 'https://' + domain_mutated
	}
	mut var_shop_url := rt.call_function('untrailingslashit', [
		rt.new_string(domain_mutated).clone()])
	mut var_api_version := rt.new_string('2025-04')
	mut var_rest_endpoint :=
		rt.new_string('${var_shop_url.to_string()}/admin/api/${var_api_version.to_string()}${var_path}')
	if !(!rt.is_true(var_query_params)) {
		var_rest_endpoint = rt.call_function('add_query_arg',
			[var_query_params, var_rest_endpoint.clone()])
	}
	return var_rest_endpoint.str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyClient) build_request_args(access_token string, method string, mut var_body Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array) rt.PhpVal {
	mut var_request_args := rt.create_array([rt.ArrayItem{ key: 'method', val: method },
		rt.ArrayItem{ key: 'headers', val: rt.create_array([
			rt.ArrayItem{ key: 'Content-Type', val: 'application/json' },
			rt.ArrayItem{ key: 'X-Shopify-Access-Token', val: access_token },
		]) }, rt.ArrayItem{ key: 'timeout', val: 60 }])
	if !(!rt.is_true(var_body))
		&& rt.is_true(rt.identical(rt.new_string('POST'), rt.new_string(method)))
		|| rt.is_true(rt.identical(rt.new_string('PUT'), rt.new_string(method))) {
		var_request_args.array_set('body', rt.call_function('wp_json_encode', [
			var_body,
		]))
	}
	return var_request_args.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyClient) process_response(var_response rt.PhpVal, path string) rt.PhpVal {
	mut var_response_mutated := var_response
	if rt.is_true(rt.call_function('is_wp_error', [var_response_mutated.clone()])) {
		return rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_WP_Error',
			[]string{}, create_automattic_woocommerce_internal_cli_migrator_platforms_shopify_wp_error(rt.new_string('api_error'),
			'REST request failed: ' +
			(rt.call_method(var_response_mutated, 'get_error_message', []rt.PhpVal{})).str()))
	}
	mut var_response_code := rt.call_function('wp_remote_retrieve_response_code', [
		var_response_mutated.clone(),
	])
	mut var_response_body := rt.call_function('wp_remote_retrieve_body', [
		var_response_mutated.clone()])
	if rt.is_true(rt.greater_equal(var_response_code, rt.new_int(300))) {
		mut var_error_details := rt.call_function('json_decode', [
			var_response_body.clone()])
		mut var_error_message := if !(rt.get_property(var_error_details, 'errors')).is_null() { rt.call_function('wp_json_encode', [
				rt.get_property(var_error_details, 'errors'),
			]) } else { var_response_body }
		return rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_WP_Error',
			[]string{}, create_automattic_woocommerce_internal_cli_migrator_platforms_shopify_wp_error(rt.new_string('api_error'),
			'REST request to ${var_path} failed with status code ${var_response_code.to_string()}: ' +
			var_error_message.str()))
	}
	mut var_data := rt.call_function('json_decode', [var_response_body.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('json_last_error',
		[]rt.PhpVal{}), rt.get_constant('JSON_ERROR_NONE')))))
	{
		return rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_WP_Error',
			[]string{}, create_automattic_woocommerce_internal_cli_migrator_platforms_shopify_wp_error(rt.new_string('api_error'),
			'Failed to decode REST JSON response: ' +
			(rt.call_function('json_last_error_msg', []rt.PhpVal{})).str()))
	}
	return var_data.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyClient) build_graphql_url(domain string) string {
	mut domain_mutated := domain
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
		rt.new_string('~^https?://~i'),
		rt.new_string(domain_mutated).clone(),
	])))))
	{
		domain_mutated = 'https://' + domain_mutated
	}
	mut var_shop_url := rt.call_function('untrailingslashit', [
		rt.new_string(domain_mutated).clone()])
	mut var_api_version := rt.new_string('2025-04')
	return '${var_shop_url.to_string()}/admin/api/${var_api_version.to_string()}/graphql.json'
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyClient) build_graphql_request_args(access_token string, query string, mut var_variables Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array) rt.PhpVal {
	mut var_request_body := rt.call_function('compact', [rt.new_string('query'),
		rt.new_string('variables')])
	return rt.create_array([rt.ArrayItem{ key: 'method', val: 'POST' },
		rt.ArrayItem{ key: 'headers', val: rt.create_array([
			rt.ArrayItem{ key: 'Content-Type', val: 'application/json' },
			rt.ArrayItem{ key: 'X-Shopify-Access-Token', val: access_token },
		]) }, rt.ArrayItem{ key: 'body', val: rt.call_function('wp_json_encode', [
			var_request_body.clone(),
		]) }, rt.ArrayItem{ key: 'timeout', val: 60 }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyClient) process_graphql_response(var_response rt.PhpVal) rt.PhpVal {
	mut var_response_mutated := var_response
	if rt.is_true(rt.call_function('is_wp_error', [var_response_mutated.clone()])) {
		return rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_WP_Error',
			[]string{}, create_automattic_woocommerce_internal_cli_migrator_platforms_shopify_wp_error(rt.new_string('api_error'),
			'GraphQL request failed: ' +
			(rt.call_method(var_response_mutated, 'get_error_message', []rt.PhpVal{})).str()))
	}
	mut var_response_code := rt.call_function('wp_remote_retrieve_response_code', [
		var_response_mutated.clone(),
	])
	mut var_response_body := rt.call_function('wp_remote_retrieve_body', [
		var_response_mutated.clone()])
	if rt.is_true(rt.greater_equal(var_response_code, rt.new_int(300))) {
		mut var_error_details := rt.call_function('json_decode', [
			var_response_body.clone()])
		mut var_error_message := if !(rt.get_property(var_error_details, 'errors')).is_null() { rt.call_function('wp_json_encode', [
				rt.get_property(var_error_details, 'errors'),
			]) } else { var_response_body }
		return rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_WP_Error',
			[]string{}, create_automattic_woocommerce_internal_cli_migrator_platforms_shopify_wp_error(rt.new_string('api_error'),
			'GraphQL request failed with status code ${var_response_code.to_string()}: ' +
			var_error_message.str()))
	}
	mut var_data := rt.call_function('json_decode', [var_response_body.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('json_last_error',
		[]rt.PhpVal{}), rt.get_constant('JSON_ERROR_NONE')))))
	{
		return rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_WP_Error',
			[]string{}, create_automattic_woocommerce_internal_cli_migrator_platforms_shopify_wp_error(rt.new_string('api_error'),
			'Failed to decode GraphQL JSON response: ' +
			(rt.call_function('json_last_error_msg', []rt.PhpVal{})).str()))
	}
	if !(!rt.is_true(rt.get_property(var_data, 'errors'))) {
		return rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_WP_Error',
			[]string{}, create_automattic_woocommerce_internal_cli_migrator_platforms_shopify_wp_error(rt.new_string('graphql_error'),
			'GraphQL API returned errors: ' +
			(rt.call_function('wp_json_encode', [rt.get_property(var_data, 'errors')])).str()))
	}
	if !rt.is_true(rt.get_property(var_data, 'data')) {
		return rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_WP_Error',
			[]string{}, create_automattic_woocommerce_internal_cli_migrator_platforms_shopify_wp_error(rt.new_string('api_error'),
			rt.new_string('GraphQL response missing "data" field.')))
	}
	return rt.get_property(var_data, 'data')
}

struct Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_cli_migrator_platforms_shopify_shopifyclient(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyClient {
	mut obj := &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyClient{
		PhpObjectBase: rt.PhpObjectBase{}
		credentials:   rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_internal_cli_migrator_platforms_shopify_wp_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyClient) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'rest_request' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array](if args.len > 3 {
				args[3]
			} else {
				rt.new_null()
			})
			return this.rest_request(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, mut
				dispatch_arg_3)
		}
		'graphql_request' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.graphql_request(dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_credentials' {
			return this.get_credentials()
		}
		'build_rest_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.build_rest_url(dispatch_arg_0, dispatch_arg_1, mut
				dispatch_arg_2))
		}
		'build_request_args' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return this.build_request_args(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'process_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.process_response(dispatch_arg_0, dispatch_arg_1)
		}
		'build_graphql_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.build_graphql_url(dispatch_arg_0))
		}
		'build_graphql_request_args' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return this.build_graphql_request_args(dispatch_arg_0, dispatch_arg_1, mut
				dispatch_arg_2)
		}
		'process_graphql_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.process_graphql_response(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyClient) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'credentials' { return this.credentials }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyClient) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'credentials' {
			this.credentials = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
