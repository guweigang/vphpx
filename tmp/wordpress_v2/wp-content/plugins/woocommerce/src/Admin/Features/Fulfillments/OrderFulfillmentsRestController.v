import rt

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v3')
	rest_base rt.PhpVal = rt.new_string('/orders/(?P<order_id>[\\d]+)/fulfillments')
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_rest_api_namespace() string {
	return 'order_fulfillments'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) register_routes() {
	mut var_request := rt.new_null()
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('get_fulfillments'))
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permission_for_fulfillments(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('create_fulfillment'))
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permission_for_fulfillments(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController', [
			'Automattic_WooCommerce_Internal_RestApiControllerBase',
		], &this), 'route_namespace'),
		this.rest_base,
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_1_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_2_fn) },
				rt.ArrayItem{ key: 'args', val: this.get_args_for_get_fulfillments() },
				rt.ArrayItem{ key: 'schema', val: this.get_schema_for_get_fulfillments() },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_3_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_4_fn) },
				rt.ArrayItem{ key: 'args', val: this.get_args_for_create_fulfillment() },
				rt.ArrayItem{ key: 'schema', val: this.get_schema_for_create_fulfillment() },
			]) },
		]),
	])
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('get_fulfillment'))
	}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permission_for_fulfillments(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('update_fulfillment'))
	}
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permission_for_fulfillments(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('delete_fulfillment'))
	}
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permission_for_fulfillments(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController', [
			'Automattic_WooCommerce_Internal_RestApiControllerBase',
		], &this), 'route_namespace'),
		rt.new_string((this.rest_base).str() + '/(?P<fulfillment_id>[\\d]+)'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_5_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_6_fn) },
				rt.ArrayItem{ key: 'args', val: this.get_args_for_get_fulfillment() },
				rt.ArrayItem{ key: 'schema', val: this.get_schema_for_get_fulfillment() },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() },
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_7_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_8_fn) },
				rt.ArrayItem{ key: 'args', val: this.get_args_for_update_fulfillment() },
				rt.ArrayItem{ key: 'schema', val: this.get_schema_for_update_fulfillment() },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() },
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_9_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_10_fn) },
				rt.ArrayItem{ key: 'args', val: this.get_args_for_delete_fulfillment() },
				rt.ArrayItem{ key: 'schema', val: this.get_schema_for_delete_fulfillment() },
			]) },
		]),
	])
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('get_fulfillment_meta'))
	}
	closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permission_for_fulfillments(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('update_fulfillment_meta'))
	}
	closure_14_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permission_for_fulfillments(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	closure_15_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('delete_fulfillment_meta'))
	}
	closure_16_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permission_for_fulfillments(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController', [
			'Automattic_WooCommerce_Internal_RestApiControllerBase',
		], &this), 'route_namespace'),
		rt.new_string((this.rest_base).str() + '/(?P<fulfillment_id>[\\d]+)/metadata'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_11_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_12_fn) },
				rt.ArrayItem{ key: 'args', val: this.get_args_for_get_fulfillment_meta() },
				rt.ArrayItem{ key: 'schema', val: this.get_schema_for_get_fulfillment_meta() },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() },
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_13_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_14_fn) },
				rt.ArrayItem{ key: 'args', val: this.get_args_for_update_fulfillment_meta() },
				rt.ArrayItem{ key: 'schema', val: this.get_schema_for_update_fulfillment_meta() },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() },
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_15_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_16_fn) },
				rt.ArrayItem{ key: 'args', val: this.get_args_for_delete_fulfillment_meta() },
				rt.ArrayItem{ key: 'schema', val: this.get_schema_for_delete_fulfillment_meta() },
			]) },
		]),
	])
	closure_17_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('get_tracking_number_details'))
	}
	closure_18_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permission_for_fulfillments(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController', [
			'Automattic_WooCommerce_Internal_RestApiControllerBase',
		], &this), 'route_namespace'),
		rt.new_string((this.rest_base).str() + '/lookup'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_17_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_18_fn) },
				rt.ArrayItem{ key: 'args', val: this.get_args_for_get_tracking_number_details() },
				rt.ArrayItem{ key: 'schema', val: this.get_schema_for_get_tracking_number_details() },
			]) },
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) check_permission_for_fulfillments(mut var_request Class_WP_REST_Request) bool {
	mut var_order := rt.new_null()
	if rt.is_true(var_request.has_param(rt.new_string('order_id'))) {
		mut var_order_id := rt.new_int((var_request.get_param(rt.new_string('order_id'))).to_i64())
		var_order = rt.call_function('wc_get_order', [var_order_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
			return (create_automattic_woocommerce_admin_features_fulfillments_wp_error(rt.new_string('woocommerce_rest_order_invalid_id'), rt.call_function('esc_html__', [
				rt.new_string('Invalid order ID.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([
				rt.ArrayItem{ key: 'status', val: rt.call_function('esc_attr', [
					Class_WP_Http.not_found(),
				]) },
			]))).to_bool()
		}
	}
	if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_woocommerce'),
	]))
	{
		return true
	}
	if rt.is_true(rt.greater(rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.new_int(0)))
		&& rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.call_method(var_order, 'get_customer_id', []rt.PhpVal{})))
		&& rt.is_true(rt.identical(Class_WP_REST_Server.readable(), var_request.get_method())) {
		return true
	}
	mut var_error_information := this.get_authentication_error_by_method(var_request.get_method())
	if rt.is_true(rt.new_bool(var_error_information.clone().is_null())) {
		return false
	}
	return (create_automattic_woocommerce_admin_features_fulfillments_wp_error(var_error_information.array_get(rt.new_string('code')),
		var_error_information.array_get(rt.new_string('message')), rt.create_array([
		rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
			[]rt.PhpVal{}) },
	]))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_fulfillments(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_order_id := rt.new_int((var_request.get_param(rt.new_string('order_id'))).to_i64())
	mut var_fulfillments := rt.new_array()
	mut iife_temp_18 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store{}
	mut iife_result_18 := iife_temp_18.load(rt.new_string('order-fulfillment'))
	mut var_datastore := iife_result_18
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_fulfillments = rt.call_method(var_datastore, 'read_fulfillments', [
		Class_WC_Order.class(),
		rt.new_string('${var_order_id.to_string()}'),
	])
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
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Admin_Features_Fulfillments_Throwable') {
		mut var_e := var_e_1.clone()
		return this.prepare_error_response(rt.call_method(var_e, 'getCode', []rt.PhpVal{}), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}), Class_WP_Http.bad_request())
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
	closure_20_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_fulfillment := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return var_fulfillment.get_raw_data()
	}
	closure_21_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_fulfillment := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return var_fulfillment.get_raw_data()
	}
	return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(rt.call_function('array_map', [
		rt.new_closure(closure_20_fn),
		var_fulfillments.clone(),
	]), Class_WP_Http.ok()))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) create_fulfillment(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_order_id := rt.new_int((var_request.get_param(rt.new_string('order_id'))).to_i64())
	mut var_notify_customer :=
		rt.new_bool((var_request.get_param(rt.new_string('notify_customer'))).to_bool())
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		mut iife_temp_21 :=
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}
		mut iife_result_21 := iife_temp_21.track_fulfillment_validation_error(rt.new_string('create'),
			rt.new_string('woocommerce_rest_order_invalid_id'),
			rt.new_string(this.check_request_source(mut var_request)))
		return this.prepare_error_response(rt.new_string('woocommerce_rest_order_invalid_id'), rt.call_function('esc_html__', [
			rt.new_string('Invalid order ID.'),
			rt.new_string('woocommerce'),
		]), Class_WP_Http.not_found())
	}
	mut var_fulfillment := create_automattic_woocommerce_admin_features_fulfillments_fulfillment()
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	var_fulfillment.set_props(var_request.get_json_params())
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	var_fulfillment.set_meta_data(var_request.get_json_params().array_get(rt.new_string('meta_data')))
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	var_fulfillment.set_entity_type(Class_WC_Order.class())
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	var_fulfillment.set_entity_id(rt.new_string('${var_order_id.to_string()}'))
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	var_fulfillment.save()
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	mut iife_temp_22 :=
		Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}
	mut iife_result_22 := iife_temp_22.track_fulfillment_creation(rt.new_string(this.check_request_source(mut var_request)), rt.new_string((if rt.is_true(var_fulfillment.get_is_fulfilled()) {
		'fulfilled'
	} else {
		'draft'
	}).str()), rt.new_string((if rt.is_true(rt.identical(var_fulfillment.get_item_count(), rt.new_int((rt.call_method(var_order,
		'get_item_count', []rt.PhpVal{})).to_i64())))
	{
		'full'
	} else {
		'partial'
	}).str()), var_fulfillment.get_item_count(), rt.new_int((rt.call_method(var_order,
		'get_item_count', []rt.PhpVal{})).to_i64()), var_notify_customer.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	this.maybe_track_tracking_added(mut var_fulfillment, mut var_request, rt.new_null())
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if rt.is_true(var_fulfillment.get_is_fulfilled()) && rt.is_true(var_notify_customer) {
		rt.call_function('do_action', [
			rt.new_string('woocommerce_fulfillment_created_notification'),
			var_order_id.clone(),
			var_fulfillment,
			rt.call_function('wc_get_order', [var_order_id.clone()]),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		mut iife_temp_23 :=
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}
		mut iife_result_23 := iife_temp_23.track_fulfillment_notification_sent(rt.new_string('fulfillment_created'),
			var_fulfillment.get_id(), var_order_id.clone())
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2,
		'Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException')
	{
		mut var_ex := var_e_2.clone()
		mut iife_temp_24 :=
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}
		mut iife_result_24 := iife_temp_24.track_fulfillment_validation_error(rt.new_string('create'), rt.call_method(var_ex,
			'getErrorCode', []rt.PhpVal{}),
			rt.new_string(this.check_request_source(mut var_request)))
		return this.prepare_error_response(rt.call_method(var_ex, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_ex,
			'getMessage', []rt.PhpVal{}), Class_WP_Http.bad_request())
		unsafe {
			goto end_label_2
		}
	} else if rt.instance_of(var_e_2,
		'Automattic_WooCommerce_Admin_Features_Fulfillments_Exception')
	{
		mut var_e := var_e_2.clone()
		mut iife_temp_25 :=
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}
		mut iife_result_25 := iife_temp_25.track_fulfillment_validation_error(rt.new_string('create'), rt.new_string((rt.call_method(var_e,
			'getCode', []rt.PhpVal{})).str()),
			rt.new_string(this.check_request_source(mut var_request)))
		return this.prepare_error_response(rt.call_method(var_e, 'getCode', []rt.PhpVal{}), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}), Class_WP_Http.bad_request())
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
	}

	end_label_2:
	return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(var_fulfillment.get_raw_data(),
		Class_WP_Http.created()))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_fulfillment(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_order_id := rt.new_int((var_request.get_param(rt.new_string('order_id'))).to_i64())
	mut var_fulfillment_id :=
		rt.new_int((var_request.get_param(rt.new_string('fulfillment_id'))).to_i64())
	mut var_fulfillment :=
		create_automattic_woocommerce_admin_features_fulfillments_fulfillment(var_fulfillment_id.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	this.validate_fulfillment(mut var_fulfillment, var_fulfillment_id.to_i64(),
		var_order_id.to_i64())
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	if rt.is_true(var_fulfillment.get_date_deleted()) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_Exception',
			[]string{}, create_automattic_woocommerce_admin_features_fulfillments_exception(rt.call_function('esc_html__', [
			rt.new_string('Fulfillment not found.'),
			rt.new_string('woocommerce'),
		]), Class_WP_Http.not_found())))
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	unsafe {
		goto end_label_3
	}
	catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Automattic_WooCommerce_Admin_Features_Fulfillments_Throwable') {
		mut var_e := var_e_3.clone()
		return this.prepare_error_response(rt.call_method(var_e, 'getCode', []rt.PhpVal{}), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}), Class_WP_Http.bad_request())
		unsafe {
			goto end_label_3
		}
	} else {
		rt.throw_exception(var_e_3)
		unsafe {
			goto end_label_3
		}
	}

	end_label_3:
	return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(var_fulfillment.get_raw_data(),
		Class_WP_Http.ok()))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) update_fulfillment(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_order_id := rt.new_int((var_request.get_param(rt.new_string('order_id'))).to_i64())
	mut var_fulfillment_id :=
		rt.new_int((var_request.get_param(rt.new_string('fulfillment_id'))).to_i64())
	mut var_notify_customer :=
		rt.new_bool((var_request.get_param(rt.new_string('notify_customer'))).to_bool())
	mut var_customer_note_raw := var_request.get_param(rt.new_string('customer_note'))
	mut var_customer_note := if var_customer_note_raw.clone().is_string() {
		var_customer_note_raw
	} else {
		rt.new_string('')
	}
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		mut iife_temp_26 :=
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}
		mut iife_result_26 := iife_temp_26.track_fulfillment_validation_error(rt.new_string('update'),
			rt.new_string('woocommerce_rest_order_invalid_id'),
			rt.new_string(this.check_request_source(mut var_request)))
		return this.prepare_error_response(rt.new_string('woocommerce_rest_order_invalid_id'), rt.call_function('esc_html__', [
			rt.new_string('Invalid order ID.'),
			rt.new_string('woocommerce'),
		]), Class_WP_Http.not_found())
	}
	mut var_fulfillment :=
		create_automattic_woocommerce_admin_features_fulfillments_fulfillment(var_fulfillment_id.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_4
		}
	}
	mut var_previous_state := var_fulfillment.get_is_fulfilled()
	if rt.has_exception() {
		unsafe {
			goto catch_label_4
		}
	}
	mut var_previous_status := if !(var_fulfillment.get_status()).is_null() {
		var_fulfillment.get_status()
	} else {
		rt.new_string('unfulfilled')
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_4
		}
	}
	this.validate_fulfillment(mut var_fulfillment, var_fulfillment_id.to_i64(),
		var_order_id.to_i64())
	if rt.has_exception() {
		unsafe {
			goto catch_label_4
		}
	}
	var_fulfillment.set_props(var_request.get_json_params())
	if rt.has_exception() {
		unsafe {
			goto catch_label_4
		}
	}
	mut var_next_state := var_fulfillment.get_is_fulfilled()
	if rt.has_exception() {
		unsafe {
			goto catch_label_4
		}
	}
	if var_request.get_json_params().array_isset(rt.new_string('meta_data')) {
		mut var_meta_data := var_request.get_json_params().array_get(rt.new_string('meta_data'))
		if rt.has_exception() {
			unsafe {
				goto catch_label_4
			}
		}
		mut iife_temp_27 := Class_Automattic_WooCommerce_Utilities_MetaDataUtil{}
		mut iife_result_27 := iife_temp_27.normalize(var_meta_data.clone(), rt.new_int(0))
		mut iife_temp_28 := Class_Automattic_WooCommerce_Utilities_MetaDataUtil{}
		mut iife_result_28 := iife_temp_28.normalize(var_meta_data.clone(), rt.new_int(0))
		mut var_normalized_keys := if var_meta_data.clone().is_array() { rt.call_function('array_column', [
				iife_result_27,
				rt.new_string('key'),
			]) } else { rt.new_array() }
		if rt.has_exception() {
			unsafe {
				goto catch_label_4
			}
		}
		mut iife_temp_29 := Class_Automattic_WooCommerce_Utilities_MetaDataUtil{}
		mut iife_result_29 := iife_temp_29.update(var_meta_data.clone(), rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment',
			[]string{}, var_fulfillment), rt.new_int(0))
		if rt.has_exception() {
			unsafe {
				goto catch_label_4
			}
		}
		if !rt.is_true(var_meta_data) || !(!rt.is_true(var_normalized_keys)) {
			mut var_existing_meta_data := var_fulfillment.get_meta_data()
			if rt.has_exception() {
				unsafe {
					goto catch_label_4
				}
			}
			mut iter_1 := var_existing_meta_data.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_meta := item_1.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
					rt.get_property(var_meta, 'key'),
					var_normalized_keys.clone(),
					rt.new_bool(true),
				])))))
				{
					var_fulfillment.delete_meta_data(rt.get_property(var_meta, 'key'))
					if rt.has_exception() {
						unsafe {
							goto catch_label_4
						}
					}
				}
				if rt.has_exception() {
					unsafe {
						goto catch_label_4
					}
				}
			}
			if rt.has_exception() {
				unsafe {
					goto catch_label_4
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_4
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_4
		}
	}
	mut var_changed_fields := var_fulfillment.get_changes()
	if rt.has_exception() {
		unsafe {
			goto catch_label_4
		}
	}
	var_fulfillment.save()
	if rt.has_exception() {
		unsafe {
			goto catch_label_4
		}
	}
	mut iife_temp_30 :=
		Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}
	mut iife_result_30 := iife_temp_30.track_fulfillment_update(rt.new_string(this.check_request_source(mut var_request)),
		var_fulfillment.get_id(), var_previous_status.clone(), var_changed_fields.clone(),
		var_notify_customer.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_4
		}
	}
	this.maybe_track_tracking_added(mut var_fulfillment, mut var_request, mut
		rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array](var_changed_fields))
	if rt.has_exception() {
		unsafe {
			goto catch_label_4
		}
	}
	if rt.is_true(var_notify_customer) {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_previous_state)))) && rt.is_true(var_next_state) {
			rt.call_function('do_action', [
				rt.new_string('woocommerce_fulfillment_created_notification'),
				var_order_id.clone(),
				var_fulfillment,
				rt.call_function('wc_get_order', [var_order_id.clone()]),
			])
			if rt.has_exception() {
				unsafe {
					goto catch_label_4
				}
			}
			mut iife_temp_31 :=
				Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}
			mut iife_result_31 := iife_temp_31.track_fulfillment_notification_sent(rt.new_string('fulfillment_created'),
				var_fulfillment.get_id(), var_order_id.clone())
			if rt.has_exception() {
				unsafe {
					goto catch_label_4
				}
			}
		} else if rt.is_true(var_next_state) {
			rt.call_function('do_action', [
				rt.new_string('woocommerce_fulfillment_updated_notification'),
				var_order_id.clone(),
				var_fulfillment,
				var_order.clone(),
				var_customer_note.clone(),
			])
			if rt.has_exception() {
				unsafe {
					goto catch_label_4
				}
			}
			mut iife_temp_32 :=
				Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}
			mut iife_result_32 := iife_temp_32.track_fulfillment_notification_sent(rt.new_string('fulfillment_updated'),
				var_fulfillment.get_id(), var_order_id.clone())
			if rt.has_exception() {
				unsafe {
					goto catch_label_4
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_4
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_4
		}
	}
	unsafe {
		goto end_label_4
	}
	catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4,
		'Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException')
	{
		mut var_ex := var_e_4.clone()
		mut iife_temp_33 :=
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}
		mut iife_result_33 := iife_temp_33.track_fulfillment_validation_error(rt.new_string('update'), rt.call_method(var_ex,
			'getErrorCode', []rt.PhpVal{}),
			rt.new_string(this.check_request_source(mut var_request)))
		return this.prepare_error_response(rt.call_method(var_ex, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_ex,
			'getMessage', []rt.PhpVal{}), Class_WP_Http.bad_request())
		unsafe {
			goto end_label_4
		}
	} else if rt.instance_of(var_e_4,
		'Automattic_WooCommerce_Admin_Features_Fulfillments_Exception')
	{
		mut var_e := var_e_4.clone()
		mut iife_temp_34 :=
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}
		mut iife_result_34 := iife_temp_34.track_fulfillment_validation_error(rt.new_string('update'), rt.new_string((rt.call_method(var_e,
			'getCode', []rt.PhpVal{})).str()),
			rt.new_string(this.check_request_source(mut var_request)))
		return this.prepare_error_response(rt.call_method(var_e, 'getCode', []rt.PhpVal{}), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}), Class_WP_Http.bad_request())
		unsafe {
			goto end_label_4
		}
	} else {
		rt.throw_exception(var_e_4)
		unsafe {
			goto end_label_4
		}
	}

	end_label_4:
	return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(var_fulfillment.get_raw_data(),
		Class_WP_Http.ok()))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) delete_fulfillment(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_order_id := rt.new_int((var_request.get_param(rt.new_string('order_id'))).to_i64())
	mut var_fulfillment_id :=
		rt.new_int((var_request.get_param(rt.new_string('fulfillment_id'))).to_i64())
	mut var_notify_customer :=
		rt.new_bool((var_request.get_param(rt.new_string('notify_customer'))).to_bool())
	mut var_fulfillment :=
		create_automattic_woocommerce_admin_features_fulfillments_fulfillment(var_fulfillment_id.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_5
		}
	}
	this.validate_fulfillment(mut var_fulfillment, var_fulfillment_id.to_i64(),
		var_order_id.to_i64())
	if rt.has_exception() {
		unsafe {
			goto catch_label_5
		}
	}
	mut var_status := if !(var_fulfillment.get_status()).is_null() {
		var_fulfillment.get_status()
	} else {
		rt.new_string('unfulfilled')
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_5
		}
	}
	var_fulfillment.delete()
	if rt.has_exception() {
		unsafe {
			goto catch_label_5
		}
	}
	mut iife_temp_35 :=
		Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}
	mut iife_result_35 := iife_temp_35.track_fulfillment_deletion(rt.new_string(this.check_request_source(mut var_request)),
		var_fulfillment_id.clone(), var_status.clone(), var_notify_customer.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_5
		}
	}
	unsafe {
		goto end_label_5
	}
	catch_label_5:
	mut var_e_5 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_5,
		'Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException')
	{
		mut var_ex := var_e_5.clone()
		mut iife_temp_36 :=
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}
		mut iife_result_36 := iife_temp_36.track_fulfillment_validation_error(rt.new_string('delete'), rt.call_method(var_ex,
			'getErrorCode', []rt.PhpVal{}),
			rt.new_string(this.check_request_source(mut var_request)))
		return this.prepare_error_response(rt.call_method(var_ex, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_ex,
			'getMessage', []rt.PhpVal{}), Class_WP_Http.bad_request())
		unsafe {
			goto end_label_5
		}
	} else if rt.instance_of(var_e_5,
		'Automattic_WooCommerce_Admin_Features_Fulfillments_Exception')
	{
		mut var_e := var_e_5.clone()
		mut iife_temp_37 :=
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}
		mut iife_result_37 := iife_temp_37.track_fulfillment_validation_error(rt.new_string('delete'), rt.new_string((rt.call_method(var_e,
			'getCode', []rt.PhpVal{})).str()),
			rt.new_string(this.check_request_source(mut var_request)))
		return this.prepare_error_response(rt.call_method(var_e, 'getCode', []rt.PhpVal{}), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}), Class_WP_Http.bad_request())
		unsafe {
			goto end_label_5
		}
	} else {
		rt.throw_exception(var_e_5)
		unsafe {
			goto end_label_5
		}
	}

	end_label_5:
	if rt.is_true(var_fulfillment.get_is_fulfilled()) && rt.is_true(var_notify_customer) {
		rt.call_function('do_action', [
			rt.new_string('woocommerce_fulfillment_deleted_notification'),
			var_order_id.clone(),
			var_fulfillment,
			rt.call_function('wc_get_order', [var_order_id.clone()]),
		])
		mut iife_temp_38 :=
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}
		mut iife_result_38 := iife_temp_38.track_fulfillment_notification_sent(rt.new_string('fulfillment_deleted'),
			var_fulfillment_id.clone(), var_order_id.clone())
	}
	return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(rt.create_array([
		rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
			rt.new_string('Fulfillment deleted successfully.'),
			rt.new_string('woocommerce'),
		]) },
	]), Class_WP_Http.ok()))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_fulfillment_meta(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_order_id := rt.new_int((var_request.get_param(rt.new_string('order_id'))).to_i64())
	mut var_fulfillment_id :=
		rt.new_int((var_request.get_param(rt.new_string('fulfillment_id'))).to_i64())
	mut var_fulfillment :=
		create_automattic_woocommerce_admin_features_fulfillments_fulfillment(var_fulfillment_id.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_6
		}
	}
	this.validate_fulfillment(mut var_fulfillment, var_fulfillment_id.to_i64(),
		var_order_id.to_i64())
	if rt.has_exception() {
		unsafe {
			goto catch_label_6
		}
	}
	unsafe {
		goto end_label_6
	}
	catch_label_6:
	mut var_e_6 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_6, 'Automattic_WooCommerce_Admin_Features_Fulfillments_Throwable') {
		mut var_e := var_e_6.clone()
		return this.prepare_error_response(rt.call_method(var_e, 'getCode', []rt.PhpVal{}), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}), Class_WP_Http.bad_request())
		unsafe {
			goto end_label_6
		}
	} else {
		rt.throw_exception(var_e_6)
		unsafe {
			goto end_label_6
		}
	}

	end_label_6:
	return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(var_fulfillment.get_raw_meta_data(),
		Class_WP_Http.ok()))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) update_fulfillment_meta(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_order_id := rt.new_int((var_request.get_param(rt.new_string('order_id'))).to_i64())
	mut var_fulfillment_id :=
		rt.new_int((var_request.get_param(rt.new_string('fulfillment_id'))).to_i64())
	mut var_fulfillment :=
		create_automattic_woocommerce_admin_features_fulfillments_fulfillment(var_fulfillment_id.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_7
		}
	}
	this.validate_fulfillment(mut var_fulfillment, var_fulfillment_id.to_i64(),
		var_order_id.to_i64())
	if rt.has_exception() {
		unsafe {
			goto catch_label_7
		}
	}
	mut var_meta_data := var_request.get_json_params().array_get(rt.new_string('meta_data'))
	if rt.has_exception() {
		unsafe {
			goto catch_label_7
		}
	}
	mut iife_temp_39 := Class_Automattic_WooCommerce_Utilities_MetaDataUtil{}
	mut iife_result_39 := iife_temp_39.normalize(var_meta_data.clone(), rt.new_int(0))
	mut iife_temp_40 := Class_Automattic_WooCommerce_Utilities_MetaDataUtil{}
	mut iife_result_40 := iife_temp_40.normalize(var_meta_data.clone(), rt.new_int(0))
	mut var_normalized_keys := if var_meta_data.clone().is_array() { rt.call_function('array_column', [
			iife_result_39,
			rt.new_string('key'),
		]) } else { rt.new_array() }
	if rt.has_exception() {
		unsafe {
			goto catch_label_7
		}
	}
	mut iife_temp_41 := Class_Automattic_WooCommerce_Utilities_MetaDataUtil{}
	mut iife_result_41 := iife_temp_41.update(var_meta_data.clone(), rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment',
		[]string{}, var_fulfillment), rt.new_int(0))
	if rt.has_exception() {
		unsafe {
			goto catch_label_7
		}
	}
	if !rt.is_true(var_meta_data) || !(!rt.is_true(var_normalized_keys)) {
		mut var_existing_meta_data := var_fulfillment.get_meta_data()
		if rt.has_exception() {
			unsafe {
				goto catch_label_7
			}
		}
		mut iter_2 := var_existing_meta_data.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_meta := item_2.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
				rt.get_property(var_meta, 'key'),
				var_normalized_keys.clone(),
				rt.new_bool(true),
			])))))
			{
				var_fulfillment.delete_meta_data(rt.get_property(var_meta, 'key'))
				if rt.has_exception() {
					unsafe {
						goto catch_label_7
					}
				}
			}
			if rt.has_exception() {
				unsafe {
					goto catch_label_7
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_7
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_7
		}
	}
	var_fulfillment.save()
	if rt.has_exception() {
		unsafe {
			goto catch_label_7
		}
	}
	unsafe {
		goto end_label_7
	}
	catch_label_7:
	mut var_e_7 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_7,
		'Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException')
	{
		mut var_ex := var_e_7.clone()
		return this.prepare_error_response(rt.call_method(var_ex, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_ex,
			'getMessage', []rt.PhpVal{}), Class_WP_Http.bad_request())
		unsafe {
			goto end_label_7
		}
	} else if rt.instance_of(var_e_7,
		'Automattic_WooCommerce_Admin_Features_Fulfillments_Throwable')
	{
		mut var_e := var_e_7.clone()
		return this.prepare_error_response(rt.call_method(var_e, 'getCode', []rt.PhpVal{}), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}), Class_WP_Http.bad_request())
		unsafe {
			goto end_label_7
		}
	} else {
		rt.throw_exception(var_e_7)
		unsafe {
			goto end_label_7
		}
	}

	end_label_7:
	return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(var_fulfillment.get_raw_meta_data(),
		Class_WP_Http.ok()))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) delete_fulfillment_meta(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_order_id := rt.new_int((var_request.get_param(rt.new_string('order_id'))).to_i64())
	mut var_fulfillment_id :=
		rt.new_int((var_request.get_param(rt.new_string('fulfillment_id'))).to_i64())
	mut var_fulfillment :=
		create_automattic_woocommerce_admin_features_fulfillments_fulfillment(var_fulfillment_id.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_8
		}
	}
	this.validate_fulfillment(mut var_fulfillment, var_fulfillment_id.to_i64(),
		var_order_id.to_i64())
	if rt.has_exception() {
		unsafe {
			goto catch_label_8
		}
	}
	mut var_meta_key := rt.call_function('sanitize_text_field', [
		rt.call_function('wp_unslash', [
			rt.new_string((var_request.get_param(rt.new_string('meta_key'))).str()),
		]),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_8
		}
	}
	var_fulfillment.delete_meta_data(var_meta_key.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_8
		}
	}
	var_fulfillment.save()
	if rt.has_exception() {
		unsafe {
			goto catch_label_8
		}
	}
	unsafe {
		goto end_label_8
	}
	catch_label_8:
	mut var_e_8 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_8,
		'Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException')
	{
		mut var_ex := var_e_8.clone()
		return this.prepare_error_response(rt.call_method(var_ex, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_ex,
			'getMessage', []rt.PhpVal{}), Class_WP_Http.bad_request())
		unsafe {
			goto end_label_8
		}
	} else if rt.instance_of(var_e_8,
		'Automattic_WooCommerce_Admin_Features_Fulfillments_Throwable')
	{
		mut var_e := var_e_8.clone()
		return this.prepare_error_response(rt.call_method(var_e, 'getCode', []rt.PhpVal{}), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}), Class_WP_Http.bad_request())
		unsafe {
			goto end_label_8
		}
	} else {
		rt.throw_exception(var_e_8)
		unsafe {
			goto end_label_8
		}
	}

	end_label_8:
	return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(var_fulfillment.get_raw_meta_data(),
		Class_WP_Http.ok()))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_tracking_number_details(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_order_id := rt.new_int((var_request.get_param(rt.new_string('order_id'))).to_i64())
	mut var_tracking_number := rt.call_function('sanitize_text_field', [
		var_request.get_param(rt.new_string('tracking_number')),
	])
	if !rt.is_true(var_tracking_number) {
		return this.prepare_error_response(rt.new_string('woocommerce_rest_tracking_number_missing'), rt.call_function('__', [
			rt.new_string('Tracking number is required.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: Class_WP_Http.bad_request() },
		]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_id)))) {
		return this.prepare_error_response(rt.new_string('woocommerce_rest_order_id_missing'), rt.call_function('__', [
			rt.new_string('Order ID is required.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: Class_WP_Http.bad_request() },
		]))
	}
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order')))))) {
		return this.prepare_error_response(rt.new_string('woocommerce_rest_order_invalid_id'), rt.call_function('__', [
			rt.new_string('Invalid order ID.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: Class_WP_Http.not_found() },
		]))
	}
	mut var_tracking_number_parse_result := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_fulfillment_parse_tracking_number'),
		var_tracking_number.clone(),
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'),
			'get_base_country', []rt.PhpVal{}),
		rt.call_method(var_order, 'get_shipping_country', []rt.PhpVal{}),
	])
	return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(var_tracking_number_parse_result.clone(),
		Class_WP_Http.ok()))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_args_for_get_fulfillments() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'order_id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Unique identifier for the order.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_schema_for_get_fulfillments() rt.PhpVal {
	mut var_schema := this.get_base_schema()
	var_schema.array_set('title', rt.call_function('__', [
		rt.new_string('Get fulfillments response.'),
		rt.new_string('woocommerce'),
	]))
	var_schema.array_set('type', 'array')
	var_schema.array_set('items', rt.create_array([
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: this.get_read_schema_for_fulfillment() },
	]))
	return var_schema.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_args_for_create_fulfillment() rt.PhpVal {
	return this.get_write_args_for_fulfillment(true)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_schema_for_create_fulfillment() rt.PhpVal {
	mut var_schema := this.get_base_schema()
	var_schema.array_set('title', rt.call_function('__', [
		rt.new_string('Create fulfillment response.'),
		rt.new_string('woocommerce'),
	]))
	var_schema.array_set('properties', this.get_read_schema_for_fulfillment())
	return var_schema.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_args_for_get_fulfillment() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'order_id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Unique identifier for the order.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'required', val: true },
		]) },
		rt.ArrayItem{ key: 'fulfillment_id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Unique identifier for the fulfillment.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'required', val: true },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_schema_for_get_fulfillment() rt.PhpVal {
	mut var_schema := this.get_base_schema()
	var_schema.array_set('title', rt.call_function('__', [
		rt.new_string('Get fulfillment response.'),
		rt.new_string('woocommerce'),
	]))
	var_schema.array_set('properties', this.get_read_schema_for_fulfillment())
	return var_schema.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_args_for_update_fulfillment() rt.PhpVal {
	return this.get_write_args_for_fulfillment(false)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_schema_for_update_fulfillment() rt.PhpVal {
	mut var_schema := this.get_base_schema()
	var_schema.array_set('title', rt.call_function('__', [
		rt.new_string('Update fulfillment response.'),
		rt.new_string('woocommerce'),
	]))
	var_schema.array_set('type', 'object')
	var_schema.array_set('properties', this.get_read_schema_for_fulfillment())
	return var_schema.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_args_for_delete_fulfillment() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'order_id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Unique identifier for the order.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
		]) },
		rt.ArrayItem{ key: 'fulfillment_id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Unique identifier for the fulfillment.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
		]) },
		rt.ArrayItem{ key: 'notify_customer', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Whether to notify the customer about the fulfillment update.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'boolean' },
			rt.ArrayItem{ key: 'default', val: false },
			rt.ArrayItem{ key: 'required', val: false },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_schema_for_delete_fulfillment() rt.PhpVal {
	mut var_schema := this.get_base_schema()
	var_schema.array_set('title', rt.call_function('__', [
		rt.new_string('Delete fulfillment response.'),
		rt.new_string('woocommerce'),
	]))
	var_schema.array_set('properties', rt.create_array([
		rt.ArrayItem{ key: 'message', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The response message.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'required', val: true },
		]) },
	]))
	return var_schema.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_args_for_get_fulfillment_meta() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'order_id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Unique identifier for the order.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
		]) },
		rt.ArrayItem{ key: 'fulfillment_id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Unique identifier for the fulfillment.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_schema_for_get_fulfillment_meta() rt.PhpVal {
	mut var_schema := this.get_base_schema()
	var_schema.array_set('title', rt.call_function('__', [
		rt.new_string('Get fulfillment meta data response.'),
		rt.new_string('woocommerce'),
	]))
	var_schema.array_set('type', 'array')
	var_schema.array_set('items', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('The meta data object.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: this.get_schema_for_meta_data() },
	]))
	return var_schema.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_args_for_update_fulfillment_meta() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'order_id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Unique identifier for the order.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
		]) },
		rt.ArrayItem{ key: 'fulfillment_id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Unique identifier for the fulfillment.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
		]) },
		rt.ArrayItem{ key: 'meta_data', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The meta data array.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The meta data object.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: this.get_schema_for_meta_data() },
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_schema_for_update_fulfillment_meta() rt.PhpVal {
	mut var_schema := this.get_base_schema()
	var_schema.array_set('title', rt.call_function('__', [
		rt.new_string('Update fulfillment meta data response.'),
		rt.new_string('woocommerce'),
	]))
	var_schema.array_set('type', 'array')
	var_schema.array_set('items', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('The meta data object.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: this.get_schema_for_meta_data() },
	]))
	return var_schema.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_args_for_delete_fulfillment_meta() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'order_id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Unique identifier for the order.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
		]) },
		rt.ArrayItem{ key: 'fulfillment_id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Unique identifier for the fulfillment.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
		]) },
		rt.ArrayItem{ key: 'meta_key', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The meta key to delete.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'required', val: true },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_schema_for_delete_fulfillment_meta() rt.PhpVal {
	mut var_schema := this.get_base_schema()
	var_schema.array_set('title', rt.call_function('__', [
		rt.new_string('Delete fulfillment meta data response.'),
		rt.new_string('woocommerce'),
	]))
	var_schema.array_set('type', 'array')
	var_schema.array_set('items', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('The meta data object.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: this.get_schema_for_meta_data() },
	]))
	return var_schema.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_args_for_get_tracking_number_details() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'order_id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Unique identifier for the order.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
		]) },
		rt.ArrayItem{ key: 'tracking_number', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The tracking number to look up.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_schema_for_get_tracking_number_details() rt.PhpVal {
	mut var_schema := this.get_base_schema()
	var_schema.array_set('title', rt.call_function('__', [
		rt.new_string('The tracking number details response.'),
		rt.new_string('woocommerce'),
	]))
	var_schema.array_set('properties', rt.create_array([
		rt.ArrayItem{ key: 'tracking_number', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The tracking number.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'required', val: true },
		]) },
		rt.ArrayItem{ key: 'shipping_provider', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The shipping provider.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'required', val: true },
		]) },
		rt.ArrayItem{ key: 'tracking_url', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The tracking URL.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'required', val: true },
		]) },
		rt.ArrayItem{ key: 'possibilities', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Ambiguous shipping providers list.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'required', val: false },
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
			]) },
		]) },
	]))
	return var_schema.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_read_schema_for_fulfillment() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Unique identifier for the fulfillment.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'entity_type', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The type of entity for which the fulfillment is created.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
		]) },
		rt.ArrayItem{ key: 'entity_id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Unique identifier for the entity.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
		]) },
		rt.ArrayItem{ key: 'status', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The status of the fulfillment.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'default', val: 'unfulfilled' },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
		]) },
		rt.ArrayItem{ key: 'is_fulfilled', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Whether the fulfillment is fulfilled.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'boolean' },
			rt.ArrayItem{ key: 'default', val: false },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
		]) },
		rt.ArrayItem{ key: 'date_updated', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The date the fulfillment was last updated.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'required', val: true },
		]) },
		rt.ArrayItem{ key: 'date_deleted', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The date the fulfillment was deleted.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'anyOf', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'null' },
				]) },
			]) },
			rt.ArrayItem{ key: 'default', val: rt.new_null() },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'required', val: true },
		]) },
		rt.ArrayItem{ key: 'meta_data', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Meta data for the fulfillment.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'items', val: this.get_schema_for_meta_data() },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_write_args_for_fulfillment(is_create bool) rt.PhpVal {
	return rt.call_function('array_merge', [if !var_is_create { rt.create_array([
			rt.ArrayItem{ key: 'fulfillment_id', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Unique identifier for the fulfillment.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
		]) } else { rt.new_array() },
		rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The status of the fulfillment.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'default', val: 'unfulfilled' },
				rt.ArrayItem{ key: 'required', val: false },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'is_fulfilled', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Whether the fulfillment is fulfilled.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'boolean' },
				rt.ArrayItem{ key: 'default', val: false },
				rt.ArrayItem{ key: 'required', val: false },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'meta_data', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Meta data for the fulfillment.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'required', val: true },
				rt.ArrayItem{ key: 'schema', val: this.get_schema_for_meta_data() },
			]) },
			rt.ArrayItem{ key: 'notify_customer', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Whether to notify the customer about the fulfillment update.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'boolean' },
				rt.ArrayItem{ key: 'default', val: false },
				rt.ArrayItem{ key: 'required', val: false },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
		]),
		if !var_is_create { rt.create_array([
				rt.ArrayItem{ key: 'customer_note', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('A note from the merchant to include in the customer notification email. Basic HTML (links, bold, italic) is preserved; scripts and unsafe markup are stripped.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
					rt.ArrayItem{ key: 'required', val: false },
					rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_kses_post' },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'edit' },
					]) },
				]) },
			]) } else { rt.new_array() }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_schema_for_meta_data() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The unique identifier for the meta data. Set `0` for new records.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'key', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The key of the meta data.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'required', val: true },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'value', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The value of the meta data.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'required', val: true },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
		]) }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
		]) }, rt.ArrayItem{ key: 'readonly', val: true }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) prepare_error_response(var_code rt.PhpVal, var_message rt.PhpVal, var_status rt.PhpVal) rt.PhpVal {
	mut var_status_mutated := var_status
	return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(rt.create_array([
		rt.ArrayItem{ key: 'code', val: var_code },
		rt.ArrayItem{ key: 'message', val: var_message },
		rt.ArrayItem{ key: 'data', val: rt.create_array([
			rt.ArrayItem{ key: 'status', val: var_status_mutated },
		]) },
	]), var_status_mutated.clone()))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) validate_fulfillment(mut var_fulfillment Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment, fulfillment_id i64, order_id i64) {
	mut var_fulfillment_mutated := var_fulfillment
	mut fulfillment_id_mutated := fulfillment_id
	mut order_id_mutated := order_id
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_fulfillment_mutated.get_id(), rt.new_int(fulfillment_id_mutated)))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_fulfillment_mutated.get_entity_type(), Class_WC_Order.class()))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_fulfillment_mutated.get_entity_id(), rt.new_string('${var_order_id.to_string()}'))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_Exception',
			[]string{}, create_automattic_woocommerce_admin_features_fulfillments_exception(rt.call_function('esc_html__', [
			rt.new_string('Invalid fulfillment ID.'),
			rt.new_string('woocommerce'),
		]))))
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) check_request_source(mut var_request Class_WP_REST_Request) string {
	if rt.is_true(var_request.get_header(rt.new_string('X-WC-Fulfillments-UI'))) {
		return 'fulfillments_modal'
	}
	return 'api'
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) maybe_track_tracking_added(mut var_fulfillment Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment, mut var_request Class_WP_REST_Request, mut var_changes Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array) {
	mut var_fulfillment_mutated := var_fulfillment
	mut var_tracking_number := var_fulfillment_mutated.get_tracking_number()
	if !rt.is_true(var_tracking_number) {
		return
	}
	if !(!rt.is_true(var_changes)) {
		mut var_meta_changes := if !(var_changes.array_get(rt.new_string('meta_data'))).is_null() {
			var_changes.array_get(rt.new_string('meta_data'))
		} else {
			rt.new_array()
		}
		mut var_tracking_changed := rt.new_bool(
			rt.is_true(rt.new_bool(var_meta_changes.clone().array_isset(rt.new_string('_tracking_number'))))
			|| rt.is_true(rt.new_bool(var_meta_changes.clone().array_isset(rt.new_string('_shipment_provider'))))
			|| rt.is_true(rt.new_bool(var_meta_changes.clone().array_isset(rt.new_string('_tracking_url')))))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_tracking_changed)))) {
			return
		}
	}
	mut var_source := rt.new_string(this.check_request_source(mut var_request))
	mut var_shipping_option := var_fulfillment_mutated.get_meta(rt.new_string('_shipping_option'),
		rt.new_bool(true))
	var_shipping_option = if !(!rt.is_true(var_shipping_option)) {
		var_shipping_option
	} else {
		rt.new_string('')
	}
	mut var_shipment_provider := if !(var_fulfillment_mutated.get_shipment_provider()).is_null() {
		var_fulfillment_mutated.get_shipment_provider()
	} else {
		rt.new_string('')
	}
	mut var_is_custom := rt.identical(rt.new_string('other'), var_shipment_provider)
	mut iife_temp_42 :=
		Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}
	mut iife_result_42 := iife_temp_42.determine_tracking_entry_method(var_source.clone(),
		var_shipping_option.clone())
	mut var_entry_method := iife_result_42
	mut iife_temp_43 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
	mut iife_result_43 := iife_temp_43.resolve_provider_name(rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment',
		[]string{}, var_fulfillment_mutated))
	mut var_resolved_provider := iife_result_43
	mut iife_temp_44 :=
		Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}
	mut iife_result_44 := iife_temp_44.track_fulfillment_tracking_added(var_fulfillment_mutated.get_id(),
		var_entry_method.clone(), var_resolved_provider.clone(), var_is_custom.clone())
}

struct Class_Automattic_WooCommerce_Internal_RestApiControllerBase {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_MetaDataUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_fulfillments_orderfulfillmentsrestcontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v3')
		rest_base:     rt.new_string('/orders/(?P<order_id>[\\d]+)/fulfillments')
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapicontrollerbase(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApiControllerBase {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApiControllerBase{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_wp_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_wc_data_store(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_response(_args ...rt.PhpVal) &Class_WP_REST_Response {
	mut obj := &Class_WP_REST_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentstracker(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillment(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Exception {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_metadatautil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_MetaDataUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_MetaDataUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_rest_api_namespace' {
			return rt.new_string(this.get_rest_api_namespace())
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'check_permission_for_fulfillments' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.check_permission_for_fulfillments(mut dispatch_arg_0))
		}
		'get_fulfillments' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_fulfillments(mut dispatch_arg_0)
		}
		'create_fulfillment' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.create_fulfillment(mut dispatch_arg_0)
		}
		'get_fulfillment' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_fulfillment(mut dispatch_arg_0)
		}
		'update_fulfillment' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.update_fulfillment(mut dispatch_arg_0)
		}
		'delete_fulfillment' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.delete_fulfillment(mut dispatch_arg_0)
		}
		'get_fulfillment_meta' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_fulfillment_meta(mut dispatch_arg_0)
		}
		'update_fulfillment_meta' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.update_fulfillment_meta(mut dispatch_arg_0)
		}
		'delete_fulfillment_meta' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.delete_fulfillment_meta(mut dispatch_arg_0)
		}
		'get_tracking_number_details' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_tracking_number_details(mut dispatch_arg_0)
		}
		'get_args_for_get_fulfillments' {
			return this.get_args_for_get_fulfillments()
		}
		'get_schema_for_get_fulfillments' {
			return this.get_schema_for_get_fulfillments()
		}
		'get_args_for_create_fulfillment' {
			return this.get_args_for_create_fulfillment()
		}
		'get_schema_for_create_fulfillment' {
			return this.get_schema_for_create_fulfillment()
		}
		'get_args_for_get_fulfillment' {
			return this.get_args_for_get_fulfillment()
		}
		'get_schema_for_get_fulfillment' {
			return this.get_schema_for_get_fulfillment()
		}
		'get_args_for_update_fulfillment' {
			return this.get_args_for_update_fulfillment()
		}
		'get_schema_for_update_fulfillment' {
			return this.get_schema_for_update_fulfillment()
		}
		'get_args_for_delete_fulfillment' {
			return this.get_args_for_delete_fulfillment()
		}
		'get_schema_for_delete_fulfillment' {
			return this.get_schema_for_delete_fulfillment()
		}
		'get_args_for_get_fulfillment_meta' {
			return this.get_args_for_get_fulfillment_meta()
		}
		'get_schema_for_get_fulfillment_meta' {
			return this.get_schema_for_get_fulfillment_meta()
		}
		'get_args_for_update_fulfillment_meta' {
			return this.get_args_for_update_fulfillment_meta()
		}
		'get_schema_for_update_fulfillment_meta' {
			return this.get_schema_for_update_fulfillment_meta()
		}
		'get_args_for_delete_fulfillment_meta' {
			return this.get_args_for_delete_fulfillment_meta()
		}
		'get_schema_for_delete_fulfillment_meta' {
			return this.get_schema_for_delete_fulfillment_meta()
		}
		'get_args_for_get_tracking_number_details' {
			return this.get_args_for_get_tracking_number_details()
		}
		'get_schema_for_get_tracking_number_details' {
			return this.get_schema_for_get_tracking_number_details()
		}
		'get_read_schema_for_fulfillment' {
			return this.get_read_schema_for_fulfillment()
		}
		'get_write_args_for_fulfillment' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_write_args_for_fulfillment(dispatch_arg_0)
		}
		'get_schema_for_meta_data' {
			return this.get_schema_for_meta_data()
		}
		'prepare_error_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.prepare_error_response(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'validate_fulfillment' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			this.validate_fulfillment(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'check_request_source' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.check_request_source(mut dispatch_arg_0))
		}
		'maybe_track_tracking_added' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			this.maybe_track_tracking_added(mut dispatch_arg_0, mut dispatch_arg_1, mut
				dispatch_arg_2)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		'rest_base' {
			this.rest_base = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApiControllerBase) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApiControllerBase) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApiControllerBase) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_MetaDataUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_MetaDataUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_MetaDataUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
