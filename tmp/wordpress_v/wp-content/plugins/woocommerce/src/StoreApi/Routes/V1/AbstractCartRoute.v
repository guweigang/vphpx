import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute.schema_type() string {
	return 'cart'
}
struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute {
	rt.PhpObjectBase
pub mut:
		schema rt.PhpVal = rt.new_null()
		cart_schema rt.PhpVal = rt.new_null()
		cart_item_schema rt.PhpVal = rt.new_null()
		cart_controller rt.PhpVal = rt.new_null()
		order_controller rt.PhpVal = rt.new_null()
		additional_fields_controller rt.PhpVal = rt.new_null()
		has_cart_token rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute) construct(mut var_schema_controller Class_Automattic_WooCommerce_StoreApi_SchemaController, mut var_schema Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema)  {
	this.Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute.construct(rt.new_object('Automattic_WooCommerce_StoreApi_SchemaController', []string{}, var_schema_controller), rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema', []string{}, var_schema))
	this.cart_schema = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute'], &this), 'schema_controller'), 'get', [Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema.identifier()])
	this.cart_item_schema = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute'], &this), 'schema_controller'), 'get', [Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartItemSchema.identifier()])
	this.cart_controller = create_automattic_woocommerce_storeapi_utilities_cartcontroller()
	this.additional_fields_controller = rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Package{}; return temp.container() }(), 'get', [Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.class()])
	this.order_controller = create_automattic_woocommerce_storeapi_utilities_ordercontroller()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute) is_update_request(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	return rt.call_function('in_array', [var_request.get_method(), rt.create_array([rt.ArrayItem{ key: none, val: 'POST' }, rt.ArrayItem{ key: none, val: 'PUT' }, rt.ArrayItem{ key: none, val: 'PATCH' }, rt.ArrayItem{ key: none, val: 'DELETE' }]), rt.new_bool(true)])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute) get_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	this.load_cart_session(mut var_request)
	mut var_response := rt.new_null()
	mut var_nonce_check := if this.requires_nonce(mut var_request) { this.check_nonce(mut var_request) } else { rt.new_null() }
	if rt.is_true(rt.call_function('is_wp_error', [var_nonce_check.dup()])) {
		var_response = var_nonce_check.dup()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_response)))) {
		var_response = this.get_response_by_request_method(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request', []string{}, var_request))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Automattic_WooCommerce_StoreApi_Exceptions_RouteException') {
			mut var_error := var_e_1.dup()
			var_response = this.get_route_error_response(rt.call_method(var_error, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_error, 'getMessage', []rt.PhpVal{}), (rt.call_method(var_error, 'getCode', []rt.PhpVal{})).to_i64(), rt.call_method(var_error, 'getAdditionalData', []rt.PhpVal{}))
			unsafe { goto end_label_1 }
		}
		else if rt.instance_of(var_e_1, 'Automattic_WooCommerce_StoreApi_Routes_V1_Exception') {
			mut var_error := var_e_1.dup()
			var_response = this.get_route_error_response(rt.new_string('woocommerce_rest_unknown_server_error'), rt.call_method(var_error, 'getMessage', []rt.PhpVal{}), 500, rt.new_null())
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
	}
	if rt.is_true(this.is_update_request(mut var_request)) {
		this.cart_updated(mut var_request)
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) {
		var_response = this.error_to_response(var_response.dup())
	}
	return this.add_response_headers(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Response](rt.call_function('rest_ensure_response', [var_response.dup()])))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute) add_response_headers(mut var_response Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Response) rt.PhpVal {
	mut var_response_mutated := var_response
	mut var_nonce := rt.call_function('wp_create_nonce', [rt.new_string('wc_store_api')])
	rt.call_method(var_response_mutated, 'header', [rt.new_string('Nonce'), var_nonce.dup()])
	rt.call_method(var_response_mutated, 'header', [rt.new_string('Nonce-Timestamp'), rt.call_function('time', []rt.PhpVal{})])
	rt.call_method(var_response_mutated, 'header', [rt.new_string('User-ID'), rt.call_function('get_current_user_id', []rt.PhpVal{})])
	rt.call_method(var_response_mutated, 'header', [rt.new_string('Cart-Token'), this.get_cart_token()])
	rt.call_method(var_response_mutated, 'header', [rt.new_string('Cart-Hash'), rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_cart_hash', []rt.PhpVal{})])
	rt.call_method(var_response_mutated, 'header', [rt.new_string('Cache-Control'), rt.new_string('no-store')])
	return rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Response', []string{}, var_response_mutated)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute) load_cart_session(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request)  {
	if rt.is_true(this.has_cart_token(mut var_request)) {
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	return Class_Automattic_WooCommerce_StoreApi_SessionHandler.class()
	}
		rt.call_function('add_filter', [rt.new_string('woocommerce_session_handler'), rt.new_closure(closure_1_fn)])
	}
	rt.call_method(this.cart_controller, 'load_cart', []rt.PhpVal{})
	rt.call_method(this.cart_controller, 'normalize_cart', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute) get_cart_token() rt.PhpVal {
	rt.call_method(this.cart_controller, 'load_cart', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'session'))))) {
		return rt.new_null()
	}
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils{}; return temp.get_cart_token(arg_0) }(// unsupported expression: Expr_Cast_String)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute) has_cart_token(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	if rt.is_true(rt.new_bool(this.has_cart_token.is_null())) {
		this.has_cart_token = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils{}; return temp.validate_cart_token(arg_0) }(if !(var_request.get_header(rt.new_string('Cart-Token'))).is_null() { var_request.get_header(rt.new_string('Cart-Token')) } else { rt.new_string('') })
	}
	return this.has_cart_token
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute) requires_nonce(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) bool {
	return rt.is_true(this.is_update_request(mut var_request)) && rt.is_true(rt.new_bool(!(rt.is_true(this.has_cart_token(mut var_request)))))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute) cart_updated(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request)  {
	mut var_draft_order := this.get_draft_order()
	if rt.is_true(var_draft_order) {
		rt.call_method(this.order_controller, 'update_order_from_cart', [var_draft_order.dup(), rt.new_bool(false)])
		rt.call_function('wc_do_deprecated_action', [rt.new_string('woocommerce_blocks_cart_update_order_from_request'), rt.create_array([rt.ArrayItem{ key: none, val: var_draft_order }, rt.ArrayItem{ key: none, val: var_request }]), rt.new_string('7.2.0'), rt.new_string('woocommerce_store_api_cart_update_order_from_request'), rt.new_string('This action was deprecated in WooCommerce Blocks version 7.2.0. Please use woocommerce_store_api_cart_update_order_from_request instead.')])
		rt.call_function('do_action', [rt.new_string('woocommerce_store_api_cart_update_order_from_request'), var_draft_order.dup(), var_request])
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute) check_nonce(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) bool {
	mut var_nonce := rt.new_null()
	if rt.is_true(var_request.get_header(rt.new_string('Nonce'))) {
		var_nonce = var_request.get_header(rt.new_string('Nonce'))
	}
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_store_api_disable_nonce_check'), rt.new_bool(false)])) {
		return true
	}
	if rt.is_true(rt.identical(rt.new_null(), var_nonce)) {
		return (this.get_route_error_response(rt.new_string('woocommerce_rest_missing_nonce'), rt.call_function('__', [rt.new_string('Missing the Nonce header. This endpoint requires a valid nonce.'), rt.new_string('woocommerce')]), 401, rt.new_null())).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [var_nonce.dup(), rt.new_string('wc_store_api')]))))) {
		return (this.get_route_error_response(rt.new_string('woocommerce_rest_invalid_nonce'), rt.call_function('__', [rt.new_string('Nonce is invalid.'), rt.new_string('woocommerce')]), 403, rt.new_null())).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute) get_route_error_response(var_error_code rt.PhpVal, var_error_message rt.PhpVal, http_status_code i64, var_additional_data rt.PhpVal) rt.PhpVal {
	mut var_additional_data_mutated := var_additional_data
	var_additional_data_mutated.array_set('status', http_status_code)
	if 409 == http_status_code {
		var_additional_data_mutated.array_set('cart', rt.call_method(this.cart_schema, 'get_item_response', [rt.call_method(this.cart_controller, 'get_cart_for_response', []rt.PhpVal{})]))
	}
	return create_automattic_woocommerce_storeapi_routes_v1_wp_error(var_error_code.dup(), var_error_message.dup(), var_additional_data_mutated.dup())
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_CartController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Package {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_abstractcartroute(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute{
		PhpObjectBase: rt.PhpObjectBase{}
		schema: rt.new_null()
		cart_schema: rt.new_null()
		cart_item_schema: rt.new_null()
		cart_controller: rt.new_null()
		order_controller: rt.new_null()
		additional_fields_controller: rt.new_null()
		has_cart_token: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_abstractroute() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_cartcontroller() &Class_Automattic_WooCommerce_StoreApi_Utilities_CartController {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_CartController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_package() &Class_Automattic_WooCommerce_Blocks_Package {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Package{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_ordercontroller() &Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_carttokenutils() &Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_wp_error() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_SchemaController](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'is_update_request' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.is_update_request(mut dispatch_arg_0)
		}
		'get_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_response(mut dispatch_arg_0)
		}
		'add_response_headers' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Response](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.add_response_headers(mut dispatch_arg_0)
		}
		'load_cart_session' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			this.load_cart_session(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_cart_token' {
			return this.get_cart_token()
		}
		'has_cart_token' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.has_cart_token(mut dispatch_arg_0)
		}
		'requires_nonce' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.requires_nonce(mut dispatch_arg_0))
		}
		'cart_updated' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			this.cart_updated(mut dispatch_arg_0)
			return rt.new_null()
		}
		'check_nonce' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.check_nonce(mut dispatch_arg_0))
		}
		'get_route_error_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.get_route_error_response(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'schema' { return this.schema }
		'cart_schema' { return this.cart_schema }
		'cart_item_schema' { return this.cart_item_schema }
		'cart_controller' { return this.cart_controller }
		'order_controller' { return this.order_controller }
		'additional_fields_controller' { return this.additional_fields_controller }
		'has_cart_token' { return this.has_cart_token }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'schema' { this.schema = val; return true }
		'cart_schema' { this.cart_schema = val; return true }
		'cart_item_schema' { this.cart_item_schema = val; return true }
		'cart_controller' { this.cart_controller = val; return true }
		'order_controller' { this.order_controller = val; return true }
		'additional_fields_controller' { this.additional_fields_controller = val; return true }
		'has_cart_token' { this.has_cart_token = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Package) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_storeapi_routes_v1_abstractcartroute_php() {
	// unsupported statement: Stmt_Declare
}
