import rt

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller {
	rt.PhpObjectBase
pub mut:
		rest_base rt.PhpVal = rt.new_string('fulfillments')
		item_schema rt.PhpVal = rt.new_null()
		order_fulfillments_controller rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller) init(mut var_item_schema Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_FulfillmentSchema, mut var_order_fulfillments_controller Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController)  {
	this.item_schema = var_item_schema.dup()
	this.order_fulfillments_controller = var_order_fulfillments_controller.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this), 'namespace'), this.rest_base, rt.create_array([rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'get_fulfillments' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'check_permission_for_fulfillments' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'order_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the order.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'required', val: true }]) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'create_fulfillment' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'check_permission_for_fulfillments' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()) }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this), 'namespace'), (this.rest_base).str() + '/(?P<fulfillment_id>[\\d]+)', rt.create_array([rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'fulfillment_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the fulfillment.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'required', val: true }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'get_fulfillment' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'check_permission_for_fulfillments' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'update_fulfillment' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'check_permission_for_fulfillments' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'delete_fulfillment' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'check_permission_for_fulfillments' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'notify_customer', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether to notify the customer about the fulfillment update.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'required', val: false }]) }]) }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this), 'namespace'), (this.rest_base).str() + '/providers', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'get_providers' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'check_permission_for_providers' }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'get_schema_for_providers' }]) }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller) get_fulfillments(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_order_id := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_id)))) {
		return this.prepare_error_response(rt.new_string('woocommerce_rest_order_id_required'), rt.call_function('__', [rt.new_string('The order ID is required.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('esc_attr', [Class_WP_Http.bad_request()]) }]))
	}
	mut var_order := rt.call_function('wc_get_order', [var_order_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return this.prepare_error_response(rt.new_string('woocommerce_rest_order_invalid_id'), rt.call_function('__', [rt.new_string('Invalid order ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('esc_attr', [Class_WP_Http.not_found()]) }]))
	}
	var_request.set_param(rt.new_string('order_id'), var_order_id.dup())
	return rt.call_method(this.order_fulfillments_controller, 'get_fulfillments', [var_request])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller) create_fulfillment(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_params := var_request.get_json_params()
	mut var_entity_id := if !(var_params.array_get('entity_id')).is_null() { var_params.array_get('entity_id') } else { rt.new_null() }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_entity_id)))) {
		return this.prepare_error_response(rt.new_string('woocommerce_rest_entity_id_required'), rt.call_function('__', [rt.new_string('The entity ID is required.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('esc_attr', [Class_WP_Http.bad_request()]) }]))
	}
	mut var_order := rt.call_function('wc_get_order', [// unsupported expression: Expr_Cast_Int])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return this.prepare_error_response(rt.new_string('woocommerce_rest_order_invalid_id'), rt.call_function('__', [rt.new_string('Invalid order ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('esc_attr', [Class_WP_Http.not_found()]) }]))
	}
	var_request.set_param(rt.new_string('order_id'), var_entity_id.dup())
	return rt.call_method(this.order_fulfillments_controller, 'create_fulfillment', [var_request])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller) get_fulfillment(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_fulfillment_id := // unsupported expression: Expr_Cast_Int
	mut var_fulfillment := create_automattic_woocommerce_admin_features_fulfillments_fulfillment(var_fulfillment_id.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_fulfillment.get_id())))) {
		return this.prepare_error_response(rt.new_string('woocommerce_rest_fulfillment_invalid_id'), rt.call_function('__', [rt.new_string('Invalid fulfillment ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('esc_attr', [Class_WP_Http.not_found()]) }]))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return this.prepare_error_response(rt.new_string('woocommerce_rest_invalid_entity_type'), rt.call_function('__', [rt.new_string('The entity type must be "order".'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('esc_attr', [Class_WP_Http.bad_request()]) }]))
	}
	mut var_order_id := // unsupported expression: Expr_Cast_Int
	var_request.set_param(rt.new_string('order_id'), var_order_id.dup())
	return rt.call_method(this.order_fulfillments_controller, 'get_fulfillment', [var_request])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller) update_fulfillment(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_fulfillment_id := // unsupported expression: Expr_Cast_Int
	mut var_fulfillment := create_automattic_woocommerce_admin_features_fulfillments_fulfillment(var_fulfillment_id.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_fulfillment.get_id())))) {
		return this.prepare_error_response(rt.new_string('woocommerce_rest_fulfillment_invalid_id'), rt.call_function('__', [rt.new_string('Invalid fulfillment ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('esc_attr', [Class_WP_Http.not_found()]) }]))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return this.prepare_error_response(rt.new_string('woocommerce_rest_invalid_entity_type'), rt.call_function('__', [rt.new_string('The entity type must be "order".'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('esc_attr', [Class_WP_Http.bad_request()]) }]))
	}
	mut var_order_id := // unsupported expression: Expr_Cast_Int
	var_request.set_param(rt.new_string('order_id'), var_order_id.dup())
	return rt.call_method(this.order_fulfillments_controller, 'update_fulfillment', [var_request])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller) delete_fulfillment(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_fulfillment_id := // unsupported expression: Expr_Cast_Int
	mut var_fulfillment := create_automattic_woocommerce_admin_features_fulfillments_fulfillment(var_fulfillment_id.dup())
	mut var_order_id := // unsupported expression: Expr_Cast_Int
	var_request.set_param(rt.new_string('order_id'), var_order_id.dup())
	return rt.call_method(this.order_fulfillments_controller, 'delete_fulfillment', [var_request])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller) check_permission_for_fulfillments(mut var_request Class_WP_REST_Request) bool {
	mut var_order := rt.new_null()
	if rt.is_true(var_request.has_param(rt.new_string('order_id'))) {
		mut var_order_id := // unsupported expression: Expr_Cast_Int
		var_order = rt.call_function('wc_get_order', [var_order_id.dup()])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) && rt.is_true(var_request.has_param(rt.new_string('fulfillment_id'))))) {
		mut var_fulfillment_id := // unsupported expression: Expr_Cast_Int
		if rt.is_true(var_fulfillment_id) {
			mut var_fulfillment := create_automattic_woocommerce_admin_features_fulfillments_fulfillment(var_fulfillment_id.dup())
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			var_order_id = // unsupported expression: Expr_Cast_Int
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			var_order = rt.call_function('wc_get_order', [var_order_id.dup()])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			unsafe { goto end_label_1 }

catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException') {
				mut var_ex := var_e_1.dup()
				return (create_wp_error(rt.call_method(var_ex, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_ex, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('esc_attr', [Class_WP_Http.bad_request()]) }]))).to_bool()
				unsafe { goto end_label_1 }
			}
			else if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Throwable') {
				mut var_e := var_e_1.dup()
				return (create_wp_error(rt.new_string('woocommerce_rest_fulfillment_invalid_id'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('esc_attr', [Class_WP_Http.bad_request()]) }]))).to_bool()
				unsafe { goto end_label_1 }
			}
			else {
				rt.throw_exception(var_e_1)
				unsafe { goto end_label_1 }
			}

end_label_1:
		}
	}
	mut var_body_params := var_request.get_json_params()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) && var_body_params.array_isset(rt.new_string('entity_id')))) && var_body_params.array_isset(rt.new_string('entity_type')))) {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			return (create_wp_error(rt.new_string('woocommerce_rest_invalid_entity_type'), rt.call_function('esc_html__', [rt.new_string('The entity type must be "order".'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('esc_attr', [Class_WP_Http.bad_request()]) }]))).to_bool()
		}
		var_order_id = // unsupported expression: Expr_Cast_Int
		var_order = rt.call_function('wc_get_order', [var_order_id.dup()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_order_id_required'), rt.call_function('esc_html__', [rt.new_string('The order ID is required.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('esc_attr', [Class_WP_Http.bad_request()]) }]))).to_bool()
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')])) {
		return true
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.greater(rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.new_int(0))) && rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.call_method(var_order, 'get_customer_id', []rt.PhpVal{}))))) && rt.is_true(rt.identical(Class_WP_REST_Server.readable(), var_request.get_method())))) {
		return true
	}
	mut var_error_information := this.get_authentication_error_by_method(var_request.get_method())
	if rt.is_true(rt.identical(rt.new_bool(false), var_error_information)) {
		return false
	}
	return (var_error_information).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller) get_schema() rt.PhpVal {
	return rt.call_method(this.item_schema, 'get_item_schema', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller) get_item_response(var_item rt.PhpVal, mut var_request Class_WP_REST_Request) rt.PhpVal {
	return rt.call_method(this.item_schema, 'get_item_response', [var_item.dup(), var_request, this.get_fields_for_response(rt.new_object('WP_REST_Request', []string{}, var_request))])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller) prepare_error_response(var_code rt.PhpVal, var_message rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	return create_wp_rest_response(rt.create_array([rt.ArrayItem{ key: 'code', val: var_code }, rt.ArrayItem{ key: 'message', val: var_message }, rt.ArrayItem{ key: 'data', val: var_data }]), if !(var_data.array_get('status')).is_null() { var_data.array_get('status') } else { Class_WP_Http.bad_request() })
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller) get_providers(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_providers := rt.new_array()
	{
		mut iter_1 := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}; return temp.get_shipping_providers() }().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_provider := item_1.val
			var_providers.array_set(rt.call_method(var_provider, 'get_key', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_method(var_provider, 'get_name', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'icon', val: rt.call_method(var_provider, 'get_icon', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'value', val: rt.call_method(var_provider, 'get_key', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'url', val: if !(rt.call_method(var_provider, 'get_tracking_url', [rt.new_string('__PLACEHOLDER__')])).is_null() { rt.call_method(var_provider, 'get_tracking_url', [rt.new_string('__PLACEHOLDER__')]) } else { rt.new_string('') } }]))
		}
	}
	var_providers = rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_prepare_fulfillments_providers'), var_providers.dup(), var_request])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_providers.dup().is_array()))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string('woocommerce_rest_prepare_fulfillments_providers'), rt.call_function('esc_html__', [rt.new_string('The filter must return an array of providers.'), rt.new_string('woocommerce')]), rt.new_string('10.5.0')])
		var_providers = rt.new_array()
	} else {
		var_providers = this.validate_providers_structure(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_array](var_providers))
	}
	return create_wp_rest_response(var_providers.dup(), Class_WP_Http.ok())
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller) validate_providers_structure(mut var_providers Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_array) rt.PhpVal {
	mut var_providers_mutated := var_providers
	mut var_required_keys := rt.create_array([rt.ArrayItem{ key: none, val: 'label' }, rt.ArrayItem{ key: none, val: 'icon' }, rt.ArrayItem{ key: none, val: 'value' }, rt.ArrayItem{ key: none, val: 'url' }])
	mut var_valid_providers := rt.new_array()
	mut var_has_invalid := rt.new_bool(rt.new_bool(false))
	{
		mut iter_1 := var_providers_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_provider := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_provider.dup().is_array()))))) {
				var_has_invalid = rt.new_bool(rt.new_bool(true))
				continue
			}
			mut var_missing_keys := rt.call_function('array_diff', [var_required_keys.dup(), rt.func_array_keys(var_provider.dup())])
			if !(!rt.is_true(var_missing_keys)) {
				var_has_invalid = rt.new_bool(rt.new_bool(true))
				continue
			}
			var_valid_providers.array_set(var_key, var_provider.dup())
		}
	}
	if rt.is_true(var_has_invalid) {
		rt.call_function('_doing_it_wrong', [rt.new_string('woocommerce_rest_prepare_fulfillments_providers'), rt.call_function('esc_html__', [rt.new_string('Some providers were removed because they are missing required keys (label, icon, value, url).'), rt.new_string('woocommerce')]), rt.new_string('10.5.0')])
	}
	return var_valid_providers.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller) check_permission_for_providers(mut var_request Class_WP_REST_Request) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
		return (this.get_authentication_error_by_method(.get_method())).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller) get_schema_for_providers() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }])
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_fulfillments_controller() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		rest_base: rt.new_string('fulfillments')
		item_schema: rt.new_null()
		order_fulfillments_controller: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_abstractcontroller() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillment() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment{
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

fn create_wp_rest_response() &Class_WP_REST_Response {
	mut obj := &Class_WP_REST_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_fulfillments_automattic_woocommerce_admin_features_fulfillments_fulfillmentutils() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_FulfillmentSchema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController](if args.len > 1 { args[1] } else { rt.new_null() })
			this.init(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_fulfillments' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_fulfillments(mut dispatch_arg_0)
		}
		'create_fulfillment' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.create_fulfillment(mut dispatch_arg_0)
		}
		'get_fulfillment' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_fulfillment(mut dispatch_arg_0)
		}
		'update_fulfillment' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.update_fulfillment(mut dispatch_arg_0)
		}
		'delete_fulfillment' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.delete_fulfillment(mut dispatch_arg_0)
		}
		'check_permission_for_fulfillments' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.check_permission_for_fulfillments(mut dispatch_arg_0))
		}
		'get_schema' {
			return this.get_schema()
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.get_item_response(dispatch_arg_0, mut dispatch_arg_1)
		}
		'prepare_error_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.prepare_error_response(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_providers' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_providers(mut dispatch_arg_0)
		}
		'validate_providers_structure' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.validate_providers_structure(mut dispatch_arg_0)
		}
		'check_permission_for_providers' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.check_permission_for_providers(mut dispatch_arg_0))
		}
		'get_schema_for_providers' {
			return this.get_schema_for_providers()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		'item_schema' { return this.item_schema }
		'order_fulfillments_controller' { return this.order_fulfillments_controller }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_base' { this.rest_base = val; return true }
		'item_schema' { this.item_schema = val; return true }
		'order_fulfillments_controller' { this.order_fulfillments_controller = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_restapi_routes_v4_fulfillments_controller_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
