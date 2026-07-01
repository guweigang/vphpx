import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessions.identifier() string {
	return 'agentic-checkout-sessions'
}

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessions.schema_type() rt.PhpVal {
	return Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema.identifier()
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessions {
	rt.PhpObjectBase
pub mut:
	cart_controller rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessions) construct(var_schema_controller rt.PhpVal, var_schema rt.PhpVal) {
	this.Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute.construct(var_schema_controller.dup(),
		var_schema.dup())
	this.dispatch_set_prop('order_controller',
		create_automattic_woocommerce_storeapi_utilities_ordercontroller())
	this.cart_controller = create_automattic_woocommerce_storeapi_utilities_cartcontroller()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessions) get_path() rt.PhpVal {
	return rt.new_string(this.get_path_regex())
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessions.get_path_regex() string {
	return '/checkout_sessions'
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessions) get_args() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{
				key: 'methods'
				val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_REST_Server.creatable()
			},
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessions', [
					'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_response' },
			]) },
			rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessions', [
					'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
				], &this) },
				rt.ArrayItem{ key: none, val: 'is_authorized' },
			]) },
			rt.ArrayItem{ key: 'args', val: this.get_create_params() },
		]) },
		rt.ArrayItem{ key: 'schema', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessions', [
				'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
			], &this), 'schema') },
			rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessions) get_create_params() rt.PhpVal {
	mut var_params := fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils{}
		return temp.get_shared_params()
	}()
	var_params.array_set('items', rt.call_function('array_merge', [
		var_params.array_get('items'),
		rt.create_array([
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'minItems', val: 1 },
		])]))
	return var_params.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessions) is_authorized() rt.PhpVal {
	return fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils{}
		return temp.validate_jetpack_request()
	}()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessions) requires_nonce(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_REST_Request) bool {
	return false
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessions) get_route_post_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_REST_Request) rt.PhpVal {
	mut var_checkout_session := create_automattic_woocommerce_storeapi_routes_v1_agentic_agenticcheckoutsession(rt.call_method(this.cart_controller,
		'get_cart_instance', []rt.PhpVal{}))
	rt.call_method(this.cart_controller, 'empty_cart', []rt.PhpVal{})
	mut var_items := var_request.get_param(rt.new_string('items'))
	mut var_error := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils{}
		return temp.add_items_to_cart(arg_0, arg_1, arg_2)
	}(var_items.dup(), this.cart_controller, var_checkout_session.get_messages())
	if rt.is_true(rt.new_bool(rt.instance_of(var_error,
		'Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error')))
	{
		return rt.call_method(var_error, 'to_rest_response', []rt.PhpVal{})
	}
	mut var_buyer := var_request.get_param(rt.new_string('buyer'))
	if rt.is_true(var_buyer) {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils{}
			return temp.set_buyer_data(arg_0, arg_1)
		}(var_buyer.dup(), rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'))
	}
	mut var_address := var_request.get_param(rt.new_string('fulfillment_address'))
	if rt.is_true(var_address) {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils{}
			return temp.set_fulfillment_address(arg_0, arg_1)
		}(var_address.dup(), rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'))
	} else {
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils{}
			return temp.clear_fulfillment_address(arg_0)
		}(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'))
	}
	rt.call_method(this.cart_controller, 'calculate_totals', []rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Exception') {
		mut var_e := var_e_1.dup()
		mut var_message := rt.call_function('wp_specialchars_decode', [
			rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
			rt.get_constant('ENT_QUOTES'),
		])
		return rt.call_method(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error{}
			return temp.processing_error(arg_0, arg_1)
		}(rt.new_string('totals_calculation_error'), var_message.dup()), 'to_rest_response',
			[]rt.PhpVal{})
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	mut var_response := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessions', [
		'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
	], &this), 'schema'), 'get_item_response', [var_checkout_session])
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils{}
		return temp.add_protocol_headers(arg_0, arg_1)
	}(rt.call_function('rest_ensure_response', [var_response.dup()]), rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_REST_Request',
		[]string{}, var_request))
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

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_agentic_checkoutsessions(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessions {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessions{
		PhpObjectBase:   rt.PhpObjectBase{}
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessions.get_path_regex())
		}
		'get_args' {
			return this.get_args()
		}
		'get_create_params' {
			return this.get_create_params()
		}
		'is_authorized' {
			return this.is_authorized()
		}
		'requires_nonce' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.requires_nonce(mut dispatch_arg_0))
		}
		'get_route_post_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_route_post_response(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cart_controller' { return this.cart_controller }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cart_controller' {
			this.cart_controller = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

pub fn init_wp_content_plugins_woocommerce_src_storeapi_routes_v1_agentic_checkoutsessions_php() {
	// unsupported statement: Stmt_Declare
}
