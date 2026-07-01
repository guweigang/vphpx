import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsUpdate.identifier() string {
	return 'agentic-checkout-sessions-update'
}
pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsUpdate.schema_type() rt.PhpVal {
	return Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema.identifier()
}
struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsUpdate {
	rt.PhpObjectBase
pub mut:
		cart_controller rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsUpdate) construct(var_schema_controller rt.PhpVal, var_schema rt.PhpVal)  {
	this.Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute.construct(var_schema_controller.dup(), var_schema.dup())
	this.dispatch_set_prop('order_controller', create_automattic_woocommerce_storeapi_utilities_ordercontroller())
	this.cart_controller = create_automattic_woocommerce_storeapi_utilities_cartcontroller()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsUpdate) get_path() rt.PhpVal {
	return Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsUpdate.get_path_regex()
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsUpdate.get_path_regex() string {
	return '/checkout_sessions/(?P<checkout_session_id>[a-zA-Z0-9._-]+)'
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsUpdate) get_args() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'checkout_session_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The checkout session ID (Cart-Token JWT).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsUpdate', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this) }, rt.ArrayItem{ key: none, val: 'get_response' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsUpdate', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this) }, rt.ArrayItem{ key: none, val: 'is_authorized' }]) }, rt.ArrayItem{ key: 'args', val: this.get_update_params() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsUpdate', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this), 'schema') }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsUpdate) get_update_params() rt.PhpVal {
	mut var_params := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils{}; return temp.get_shared_params() }()
	var_params.array_set('fulfillment_option_id', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Selected fulfillment option ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]))
	return var_params.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsUpdate) is_authorized(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_REST_Request) bool {
	mut var_auth_check := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils{}; return temp.validate_jetpack_request() }()
	if rt.is_true(rt.call_function('is_wp_error', [var_auth_check.dup()])) {
		return (var_auth_check).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.has_cart_token(mut var_request))))) {
		return (create_automattic_woocommerce_storeapi_routes_v1_agentic_wp_error(rt.new_string('woocommerce_rest_invalid_checkout_session'), rt.call_function('__', [rt.new_string('Invalid or expired checkout session ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsUpdate) has_cart_token(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_REST_Request) rt.PhpVal {
	mut var_session_id := var_request.get_param(rt.new_string('checkout_session_id'))
	if rt.is_true(rt.new_bool(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsUpdate', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this), 'has_cart_token').is_null())) {
		this.dispatch_set_prop('has_cart_token', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils{}; return temp.validate_cart_token(arg_0) }(var_session_id.dup()))
	}
	if rt.is_true(rt.identical(rt.new_bool(true), rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsUpdate', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this), 'has_cart_token'))) {
		var_request.set_header(rt.new_string('Cart-Token'), var_session_id.dup())
		rt.get_superglobal('_SERVER').array_set('HTTP_CART_TOKEN', var_session_id.dup())
	}
	return rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsUpdate', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this), 'has_cart_token')
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsUpdate) get_route_post_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_REST_Request) rt.PhpVal {
	mut var_cart := rt.call_method(this.cart_controller, 'get_cart_instance', []rt.PhpVal{})
	mut var_checkout_session := create_automattic_woocommerce_storeapi_routes_v1_agentic_agenticcheckoutsession(var_cart.dup())
	mut var_current_status := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils{}; return temp.calculate_status(arg_0) }(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession', []string{}, var_checkout_session))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_current_status.dup(), Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_CheckoutSessionStatus.allowed_statuses_for_update(), rt.new_bool(true)]))))) {
		mut var_allowed_statuses := rt.call_function('implode', [rt.new_string(', '), Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_CheckoutSessionStatus.allowed_statuses_for_update()])
		mut var_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Checkout session cannot be updated. Current status: %1$s. Allowed statuses: %2$s'), rt.new_string('woocommerce')]), var_current_status.dup(), var_allowed_statuses.dup()])
		return rt.call_method(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error{}; return temp.invalid_request(arg_0, arg_1) }(Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorCode.invalid(), var_message.dup()), 'to_rest_response', []rt.PhpVal{})
	}
	mut var_items := var_request.get_param(rt.new_string('items'))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_method(this.cart_controller, 'empty_cart', []rt.PhpVal{})
		mut var_error := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils{}; return temp.add_items_to_cart(arg_0, arg_1, arg_2) }(var_items.dup(), this.cart_controller, var_checkout_session.get_messages())
		if rt.is_true(rt.new_bool(rt.instance_of(var_error, 'Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error'))) {
			return rt.call_method(var_error, 'to_rest_response', []rt.PhpVal{})
		}
	}
	mut var_buyer := var_request.get_param(rt.new_string('buyer'))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils{}; return temp.set_buyer_data(arg_0, arg_1) }(var_buyer.dup(), rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'))
	}
	mut var_address := var_request.get_param(rt.new_string('fulfillment_address'))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils{}; return temp.set_fulfillment_address(arg_0, arg_1) }(var_address.dup(), rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'))
	}
	mut var_fulfillment_option_id := var_request.get_param(rt.new_string('fulfillment_option_id'))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_option_id := rt.call_function('wc_clean', [// unsupported expression: Expr_Cast_String])
		mut var_packages := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping', []rt.PhpVal{}), 'get_packages', []rt.PhpVal{})
		{
			mut iter_1 := var_packages.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_package := item_1.val
				{
					mut iter_2 := rt.cast_array(if !(var_package.array_get('rates')).is_null() { var_package.array_get('rates') } else { rt.new_array() }).iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_rate := item_2.val
						if rt.is_true(rt.identical(rt.call_method(var_rate, 'get_id', []rt.PhpVal{}), var_option_id)) {
							rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_SessionKey.chosen_shipping_methods(), rt.create_array([rt.ArrayItem{ key: none, val: var_option_id }])])
							break
						}
					}
				}
			}
		}
	}
	rt.call_method(this.cart_controller, 'calculate_totals', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Exception') {
		mut var_e := var_e_1.dup()
		var_message = rt.call_function('wp_specialchars_decode', [rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.get_constant('ENT_QUOTES')])
		return rt.call_method(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error{}; return temp.processing_error(arg_0, arg_1) }(rt.new_string('totals_calculation_error'), var_message.dup()), 'to_rest_response', []rt.PhpVal{})
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	mut var_response := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsUpdate', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this), 'schema'), 'get_item_response', [var_checkout_session])
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils{}; return temp.add_protocol_headers(arg_0, arg_1) }(rt.call_function('rest_ensure_response', [var_response.dup()]), rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_REST_Request', []string{}, var_request))
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_CartController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_agentic_checkoutsessionsupdate(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsUpdate {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsUpdate{
		PhpObjectBase: rt.PhpObjectBase{}
		cart_controller: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_abstractcartroute() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute{
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

fn create_automattic_woocommerce_storeapi_utilities_cartcontroller() &Class_Automattic_WooCommerce_StoreApi_Utilities_CartController {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_CartController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_agenticcheckoututils() &Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_agentic_wp_error() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_Error{
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

fn create_automattic_woocommerce_storeapi_routes_v1_agentic_agenticcheckoutsession() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_agentic_error() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsUpdate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_path' {
			return this.get_path()
		}
		'get_path_regex' {
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsUpdate.get_path_regex())
		}
		'get_args' {
			return this.get_args()
		}
		'get_update_params' {
			return this.get_update_params()
		}
		'is_authorized' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_authorized(mut dispatch_arg_0))
		}
		'has_cart_token' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.has_cart_token(mut dispatch_arg_0)
		}
		'get_route_post_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_route_post_response(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsUpdate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cart_controller' { return this.cart_controller }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsUpdate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cart_controller' { this.cart_controller = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_storeapi_routes_v1_agentic_checkoutsessionsupdate_php() {
	// unsupported statement: Stmt_Declare
}
