import rt

struct Class_Automattic_WooCommerce_Internal_MCP_Transport_WooCommerceRestTransport {
	rt.PhpObjectBase
pub mut:
		current_mcp_permissions rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_MCP_Transport_WooCommerceRestTransport) construct(mut var_context Class_WP_MCP_Transport_Infrastructure_McpTransportContext)  {
	this.Class_WP_MCP_Transport_HttpTransport.construct(rt.new_object('WP_MCP_Transport_Infrastructure_McpTransportContext', []string{}, var_context))
	rt.call_function('add_filter', [rt.new_string('woocommerce_check_rest_ability_permissions_for_method'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_MCP_Transport_WooCommerceRestTransport', ['WP_MCP_Transport_HttpTransport'], &this) }, rt.ArrayItem{ key: none, val: 'check_ability_permission' }]), rt.new_int(10), rt.new_int(3)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_MCP_Transport_WooCommerceRestTransport) check_permission(var_request rt.PhpVal) rt.PhpVal {
	return rt.new_bool(this.validate_request(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request)))
}

fn (mut this Class_Automattic_WooCommerce_Internal_MCP_Transport_WooCommerceRestTransport) validate_request(mut var_request Class_WP_REST_Request) bool {
	mut var_consumer_key := rt.new_null()
	mut var_consumer_secret := rt.new_null()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_mcp_allow_insecure_transport'), rt.new_bool(false), var_request]))))))) {
		return (create_wp_error(rt.new_string('insecure_transport'), rt.call_function('__', [rt.new_string('HTTPS is required for MCP requests.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 403 }]))).to_bool()
	}
	mut var_api_key := var_request.get_header(rt.new_string('X-MCP-API-Key'))
	if !rt.is_true(var_api_key) {
		return (create_wp_error(rt.new_string('missing_api_key'), rt.call_function('__', [rt.new_string('X-MCP-API-Key header required. Format: consumer_key:consumer_secret'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 401 }]))).to_bool()
	}
	if rt.is_true(rt.identical(rt.call_function('strpos', [var_api_key.dup(), rt.new_string(':')]), rt.new_bool(false))) {
		return (create_wp_error(rt.new_string('invalid_api_key'), rt.call_function('__', [rt.new_string('X-MCP-API-Key must be in format consumer_key:consumer_secret'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 401 }]))).to_bool()
	}
	// unsupported assign target: Expr_List
	mut var_result := this.authenticate(var_consumer_key.dup(), var_consumer_secret.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
		return (var_result).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_MCP_Transport_WooCommerceRestTransport) authenticate(var_consumer_key rt.PhpVal, var_consumer_secret rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_hashed_consumer_key := rt.call_function('wc_api_hash', [rt.new_string(// unsupported expression: Expr_Cast_String.to_string().trim_space())])
	mut var_user_data := rt.call_method(var_wpdb, 'get_row', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT key_id, user_id, permissions, consumer_key, consumer_secret, nonces\n\t\t\t\tFROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_api_keys\n\t\t\t\tWHERE consumer_key = %s')), var_hashed_consumer_key.dup()])])
	if !rt.is_true(var_user_data) {
		return create_wp_error(rt.new_string('authentication_failed'), rt.call_function('__', [rt.new_string('Authentication failed.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 401 }]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('hash_equals', [rt.get_property(var_user_data, 'consumer_secret'), rt.new_string(// unsupported expression: Expr_Cast_String.to_string().trim_space())]))))) {
		return create_wp_error(rt.new_string('authentication_failed'), rt.call_function('__', [rt.new_string('Authentication failed.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 401 }]))
	}
	// unsupported assign target: Expr_StaticPropertyFetch
	mut var_user := rt.call_function('get_user_by', [rt.new_string('id'), // unsupported expression: Expr_Cast_Int])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return create_wp_error(rt.new_string('mcp_user_not_found'), rt.call_function('__', [rt.new_string('The user associated with this API key no longer exists.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 401 }]))
	}
	rt.call_function('wp_set_current_user', [rt.get_property(var_user, 'ID')])
	return rt.get_property(var_user, 'ID')
}

fn Class_Automattic_WooCommerce_Internal_MCP_Transport_WooCommerceRestTransport.get_current_user_permissions() string {
	return (// unsupported expression: Expr_StaticPropertyFetch).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_MCP_Transport_WooCommerceRestTransport) check_ability_permission(var_allowed rt.PhpVal, var_method rt.PhpVal, var_controller rt.PhpVal) rt.PhpVal {
	mut var_permissions := Class_Automattic_WooCommerce_Internal_MCP_Transport_WooCommerceRestTransport.get_current_user_permissions()
	if rt.is_true(rt.identical(rt.new_null(), var_permissions)) {
		return var_allowed.dup()
	}
	mut switch_val_1 := var_method
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('HEAD'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('GET'))) {
		return rt.new_bool(rt.is_true(rt.identical(rt.new_string('read'), var_permissions)) || rt.is_true(rt.identical(rt.new_string('read_write'), var_permissions)))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('POST'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('PUT'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('PATCH'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('DELETE'))) {
		return rt.new_bool(rt.is_true(rt.identical(rt.new_string('write'), var_permissions)) || rt.is_true(rt.identical(rt.new_string('read_write'), var_permissions)))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('OPTIONS'))) {
		return rt.new_bool(true)
	} else {
		return rt.new_bool(false)
	}
	return rt.new_null()
}

struct Class_WP_MCP_Transport_HttpTransport {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_mcp_transport_woocommerceresttransport(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_MCP_Transport_WooCommerceRestTransport {
	mut obj := &Class_Automattic_WooCommerce_Internal_MCP_Transport_WooCommerceRestTransport{
		PhpObjectBase: rt.PhpObjectBase{}
		current_mcp_permissions: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_mcp_transport_httptransport() &Class_WP_MCP_Transport_HttpTransport {
	mut obj := &Class_WP_MCP_Transport_HttpTransport{
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

fn (mut this Class_Automattic_WooCommerce_Internal_MCP_Transport_WooCommerceRestTransport) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_MCP_Transport_Infrastructure_McpTransportContext](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'check_permission' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.check_permission(dispatch_arg_0)
		}
		'validate_request' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.validate_request(mut dispatch_arg_0))
		}
		'authenticate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.authenticate(dispatch_arg_0, dispatch_arg_1)
		}
		'get_current_user_permissions' {
			return rt.new_string(Class_Automattic_WooCommerce_Internal_MCP_Transport_WooCommerceRestTransport.get_current_user_permissions())
		}
		'check_ability_permission' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.check_ability_permission(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_MCP_Transport_WooCommerceRestTransport) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'current_mcp_permissions' { return this.current_mcp_permissions }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_MCP_Transport_WooCommerceRestTransport) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'current_mcp_permissions' { this.current_mcp_permissions = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_MCP_Transport_HttpTransport) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_MCP_Transport_HttpTransport) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_MCP_Transport_HttpTransport) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_mcp_transport_woocommerceresttransport_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
