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

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) register_routes()  {
	mut var_request := rt.new_null()
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('get_fulfillments'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permission_for_fulfillments(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('create_fulfillment'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permission_for_fulfillments(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController', ['Automattic_WooCommerce_Internal_RestApiControllerBase'], &this), 'route_namespace'), this.rest_base, rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_1_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_2_fn) }, rt.ArrayItem{ key: 'args', val: this.get_args_for_get_fulfillments() }, rt.ArrayItem{ key: 'schema', val: this.get_schema_for_get_fulfillments() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_3_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_4_fn) }, rt.ArrayItem{ key: 'args', val: this.get_args_for_create_fulfillment() }, rt.ArrayItem{ key: 'schema', val: this.get_schema_for_create_fulfillment() }]) }])])
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('get_fulfillment'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permission_for_fulfillments(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('update_fulfillment'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permission_for_fulfillments(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('delete_fulfillment'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permission_for_fulfillments(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController', ['Automattic_WooCommerce_Internal_RestApiControllerBase'], &this), 'route_namespace'), (this.rest_base).str() + '/(?P<fulfillment_id>[\\d]+)', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_5_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_6_fn) }, rt.ArrayItem{ key: 'args', val: this.get_args_for_get_fulfillment() }, rt.ArrayItem{ key: 'schema', val: this.get_schema_for_get_fulfillment() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_7_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_8_fn) }, rt.ArrayItem{ key: 'args', val: this.get_args_for_update_fulfillment() }, rt.ArrayItem{ key: 'schema', val: this.get_schema_for_update_fulfillment() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_9_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_10_fn) }, rt.ArrayItem{ key: 'args', val: this.get_args_for_delete_fulfillment() }, rt.ArrayItem{ key: 'schema', val: this.get_schema_for_delete_fulfillment() }]) }])])
	closure_16_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_15_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_14_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('get_fulfillment_meta'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permission_for_fulfillments(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('update_fulfillment_meta'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permission_for_fulfillments(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('delete_fulfillment_meta'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permission_for_fulfillments(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController', ['Automattic_WooCommerce_Internal_RestApiControllerBase'], &this), 'route_namespace'), (this.rest_base).str() + '/(?P<fulfillment_id>[\\d]+)/metadata', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_11_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_12_fn) }, rt.ArrayItem{ key: 'args', val: this.get_args_for_get_fulfillment_meta() }, rt.ArrayItem{ key: 'schema', val: this.get_schema_for_get_fulfillment_meta() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_13_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_14_fn) }, rt.ArrayItem{ key: 'args', val: this.get_args_for_update_fulfillment_meta() }, rt.ArrayItem{ key: 'schema', val: this.get_schema_for_update_fulfillment_meta() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_15_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_16_fn) }, rt.ArrayItem{ key: 'args', val: this.get_args_for_delete_fulfillment_meta() }, rt.ArrayItem{ key: 'schema', val: this.get_schema_for_delete_fulfillment_meta() }]) }])])
	closure_18_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_17_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('get_tracking_number_details'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permission_for_fulfillments(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController', ['Automattic_WooCommerce_Internal_RestApiControllerBase'], &this), 'route_namespace'), (this.rest_base).str() + '/lookup', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_17_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_18_fn) }, rt.ArrayItem{ key: 'args', val: this.get_args_for_get_tracking_number_details() }, rt.ArrayItem{ key: 'schema', val: this.get_schema_for_get_tracking_number_details() }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) check_permission_for_fulfillments(mut var_request Class_WP_REST_Request) bool {
	mut var_order := rt.new_null()
	if rt.is_true(var_request.has_param(rt.new_string('order_id'))) {
		mut var_order_id := // unsupported expression: Expr_Cast_Int
		var_order = rt.call_function('wc_get_order', [var_order_id.dup()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
			return (create_automattic_woocommerce_admin_features_fulfillments_wp_error(rt.new_string('woocommerce_rest_order_invalid_id'), rt.call_function('esc_html__', [rt.new_string('Invalid order ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('esc_attr', [Class_WP_Http.not_found()]) }]))).to_bool()
		}
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')])) {
		return true
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.greater(rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.new_int(0))) && rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.call_method(var_order, 'get_customer_id', []rt.PhpVal{}))))) && rt.is_true(rt.identical(Class_WP_REST_Server.readable(), var_request.get_method())))) {
		return true
	}
	mut var_error_information := this.get_authentication_error_by_method(var_request.get_method())
	if rt.is_true(rt.new_bool(var_error_information.dup().is_null())) {
		return false
	}
	return (create_automattic_woocommerce_admin_features_fulfillments_wp_error(var_error_information.array_get('code'), var_error_information.array_get('message'), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_fulfillments(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_order_id := // unsupported expression: Expr_Cast_Int
	mut var_fulfillments := rt.new_array()
	mut var_datastore := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('order-fulfillment'))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_fulfillments = rt.call_method(var_datastore, 'read_fulfillments', [Class_WC_Order.class(), rt.new_string("${var_order_id.to_string()}")])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Admin_Features_Fulfillments_Throwable') {
		mut var_e := var_e_1.dup()
		return this.prepare_error_response(rt.call_method(var_e, 'getCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), Class_WP_Http.bad_request())
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	closure_20_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_19_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_fulfillment := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return var_fulfillment.get_raw_data()
	}
	mut var_fulfillment := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return var_fulfillment.get_raw_data()
	}
	return create_wp_rest_response(rt.call_function('array_map', [rt.new_closure(closure_19_fn), var_fulfillments.dup()]), Class_WP_Http.ok())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) create_fulfillment(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_order_id := // unsupported expression: Expr_Cast_Int
	mut var_notify_customer := // unsupported expression: Expr_Cast_Bool
	mut var_order := rt.call_function('wc_get_order', [var_order_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}; return temp.track_fulfillment_validation_error(arg_0, arg_1, arg_2) }(rt.new_string('create'), rt.new_string('woocommerce_rest_order_invalid_id'), rt.new_string(this.check_request_source(mut var_request)))
		return this.prepare_error_response(rt.new_string('woocommerce_rest_order_invalid_id'), rt.call_function('esc_html__', [rt.new_string('Invalid order ID.'), rt.new_string('woocommerce')]), Class_WP_Http.not_found())
	}
	mut var_fulfillment := create_automattic_woocommerce_admin_features_fulfillments_fulfillment()
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	var_fulfillment.set_props(var_request.get_json_params())
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	var_fulfillment.set_meta_data(var_request.get_json_params().array_get('meta_data'))
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	var_fulfillment.set_entity_type(Class_WC_Order.class())
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	var_fulfillment.set_entity_id(rt.new_string("${var_order_id.to_string()}"))
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	var_fulfillment.save()
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal, arg_5 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}; return temp.track_fulfillment_creation(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5) }(rt.new_string(this.check_request_source(mut var_request)), rt.new_string(if rt.is_true(var_fulfillment.get_is_fulfilled()) { 'fulfilled' } else { 'draft' }), rt.new_string(if rt.is_true(rt.identical(var_fulfillment.get_item_count(), // unsupported expression: Expr_Cast_Int)) { 'full' } else { 'partial' }), var_fulfillment.get_item_count(), // unsupported expression: Expr_Cast_Int, var_notify_customer.dup())
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	this.maybe_track_tracking_added(mut var_fulfillment, mut var_request, rt.new_null())
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.new_bool(rt.is_true(var_fulfillment.get_is_fulfilled()) && rt.is_true(var_notify_customer))) {
		rt.call_function('do_action', [rt.new_string('woocommerce_fulfillment_created_notification'), var_order_id.dup(), var_fulfillment, rt.call_function('wc_get_order', [var_order_id.dup()])])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}; return temp.track_fulfillment_notification_sent(arg_0, arg_1, arg_2) }(rt.new_string('fulfillment_created'), var_fulfillment.get_id(), var_order_id.dup())
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException') {
		mut var_ex := var_e_2.dup()
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}; return temp.track_fulfillment_validation_error(arg_0, arg_1, arg_2) }(rt.new_string('create'), rt.call_method(var_ex, 'getErrorCode', []rt.PhpVal{}), rt.new_string(this.check_request_source(mut var_request)))
		return this.prepare_error_response(rt.call_method(var_ex, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_ex, 'getMessage', []rt.PhpVal{}), Class_WP_Http.bad_request())
		unsafe { goto end_label_2 }
	}
	else if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Admin_Features_Fulfillments_Exception') {
		mut var_e := var_e_2.dup()
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}; return temp.track_fulfillment_validation_error(arg_0, arg_1, arg_2) }(rt.new_string('create'), // unsupported expression: Expr_Cast_String, rt.new_string(this.check_request_source(mut var_request)))
		return this.prepare_error_response(rt.call_method(var_e, 'getCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), Class_WP_Http.bad_request())
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return create_wp_rest_response(var_fulfillment.get_raw_data(), Class_WP_Http.created())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_fulfillment(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_order_id := // unsupported expression: Expr_Cast_Int
	mut var_fulfillment_id := // unsupported expression: Expr_Cast_Int
	mut var_fulfillment := create_automattic_woocommerce_admin_features_fulfillments_fulfillment(var_fulfillment_id.dup())
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	this.validate_fulfillment(mut var_fulfillment, (var_fulfillment_id).to_i64(), (var_order_id).to_i64())
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	if rt.is_true(var_fulfillment.get_date_deleted()) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_Exception', []string{}, create_automattic_woocommerce_admin_features_fulfillments_exception(rt.call_function('esc_html__', [rt.new_string('Fulfillment not found.'), rt.new_string('woocommerce')]), Class_WP_Http.not_found())))
		if rt.has_exception() { unsafe { goto catch_label_3 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Automattic_WooCommerce_Admin_Features_Fulfillments_Throwable') {
		mut var_e := var_e_3.dup()
		return this.prepare_error_response(rt.call_method(var_e, 'getCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), Class_WP_Http.bad_request())
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	return create_wp_rest_response(var_fulfillment.get_raw_data(), Class_WP_Http.ok())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) update_fulfillment(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_order_id := // unsupported expression: Expr_Cast_Int
	mut var_fulfillment_id := // unsupported expression: Expr_Cast_Int
	mut var_notify_customer := // unsupported expression: Expr_Cast_Bool
	mut var_customer_note_raw := var_request.get_param(rt.new_string('customer_note'))
	mut var_customer_note := if rt.is_true(rt.new_bool(var_customer_note_raw.dup().is_string())) { var_customer_note_raw } else { rt.new_string('') }
	mut var_order := rt.call_function('wc_get_order', [var_order_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}; return temp.track_fulfillment_validation_error(arg_0, arg_1, arg_2) }(rt.new_string('update'), rt.new_string('woocommerce_rest_order_invalid_id'), rt.new_string(this.check_request_source(mut var_request)))
		return this.prepare_error_response(rt.new_string('woocommerce_rest_order_invalid_id'), rt.call_function('esc_html__', [rt.new_string('Invalid order ID.'), rt.new_string('woocommerce')]), Class_WP_Http.not_found())
	}
	mut var_fulfillment := create_automattic_woocommerce_admin_features_fulfillments_fulfillment(var_fulfillment_id.dup())
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	mut var_previous_state := var_fulfillment.get_is_fulfilled()
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	mut var_previous_status := if !(var_fulfillment.get_status()).is_null() { var_fulfillment.get_status() } else { rt.new_string('unfulfilled') }
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	this.validate_fulfillment(mut var_fulfillment, (var_fulfillment_id).to_i64(), (var_order_id).to_i64())
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	var_fulfillment.set_props(var_request.get_json_params())
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	mut var_next_state := var_fulfillment.get_is_fulfilled()
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	if var_request.get_json_params().array_isset(rt.new_string('meta_data')) {
		mut var_meta_data := var_request.get_json_params().array_get('meta_data')
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		mut var_normalized_keys := if rt.is_true(rt.new_bool(var_meta_data.dup().is_array())) { rt.call_function('array_column', [fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_MetaDataUtil{}; return temp.normalize(arg_0, arg_1) }(var_meta_data.dup(), rt.new_int(0)), rt.new_string('key')]) } else { rt.new_array() }
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_MetaDataUtil{}; return temp.update(arg_0, arg_1, arg_2) }(var_meta_data.dup(), rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment', []string{}, var_fulfillment), rt.new_int(0))
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		if !rt.is_true(var_meta_data) || !(!rt.is_true(var_normalized_keys)) {
			mut var_existing_meta_data := var_fulfillment.get_meta_data()
			if rt.has_exception() { unsafe { goto catch_label_4 } }
			{
				mut iter_1 := var_existing_meta_data.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_meta := item_1.val
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_meta, 'key'), var_normalized_keys.dup(), rt.new_bool(true)]))))) {
						var_fulfillment.delete_meta_data(rt.get_property(var_meta, 'key'))
						if rt.has_exception() { unsafe { goto catch_label_4 } }
					}
					if rt.has_exception() { unsafe { goto catch_label_4 } }
				}
			}
			if rt.has_exception() { unsafe { goto catch_label_4 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_4 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	mut var_changed_fields := var_fulfillment.get_changes()
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	var_fulfillment.save()
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}; return temp.track_fulfillment_update(arg_0, arg_1, arg_2, arg_3, arg_4) }(rt.new_string(this.check_request_source(mut var_request)), var_fulfillment.get_id(), var_previous_status.dup(), var_changed_fields.dup(), var_notify_customer.dup())
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	this.maybe_track_tracking_added(mut var_fulfillment, mut var_request, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array](var_changed_fields))
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	if rt.is_true(var_notify_customer) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_previous_state)))) && rt.is_true(var_next_state))) {
			rt.call_function('do_action', [rt.new_string('woocommerce_fulfillment_created_notification'), var_order_id.dup(), var_fulfillment, rt.call_function('wc_get_order', [var_order_id.dup()])])
			if rt.has_exception() { unsafe { goto catch_label_4 } }
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}; return temp.track_fulfillment_notification_sent(arg_0, arg_1, arg_2) }(rt.new_string('fulfillment_created'), var_fulfillment.get_id(), var_order_id.dup())
			if rt.has_exception() { unsafe { goto catch_label_4 } }
		} else if rt.is_true(var_next_state) {
			rt.call_function('do_action', [rt.new_string('woocommerce_fulfillment_updated_notification'), var_order_id.dup(), var_fulfillment, var_order.dup(), var_customer_note.dup()])
			if rt.has_exception() { unsafe { goto catch_label_4 } }
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}; return temp.track_fulfillment_notification_sent(arg_0, arg_1, arg_2) }(rt.new_string('fulfillment_updated'), var_fulfillment.get_id(), var_order_id.dup())
			if rt.has_exception() { unsafe { goto catch_label_4 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_4 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	unsafe { goto end_label_4 }

catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException') {
		mut var_ex := var_e_4.dup()
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}; return temp.track_fulfillment_validation_error(arg_0, arg_1, arg_2) }(rt.new_string('update'), rt.call_method(var_ex, 'getErrorCode', []rt.PhpVal{}), rt.new_string(this.check_request_source(mut var_request)))
		return this.prepare_error_response(rt.call_method(var_ex, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_ex, 'getMessage', []rt.PhpVal{}), Class_WP_Http.bad_request())
		unsafe { goto end_label_4 }
	}
	else if rt.instance_of(var_e_4, 'Automattic_WooCommerce_Admin_Features_Fulfillments_Exception') {
		mut var_e := var_e_4.dup()
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}; return temp.track_fulfillment_validation_error(arg_0, arg_1, arg_2) }(rt.new_string('update'), // unsupported expression: Expr_Cast_String, rt.new_string(this.check_request_source(mut var_request)))
		return this.prepare_error_response(rt.call_method(var_e, 'getCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), Class_WP_Http.bad_request())
		unsafe { goto end_label_4 }
	}
	else {
		rt.throw_exception(var_e_4)
		unsafe { goto end_label_4 }
	}

end_label_4:
	return create_wp_rest_response(var_fulfillment.get_raw_data(), Class_WP_Http.ok())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) delete_fulfillment(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_order_id := // unsupported expression: Expr_Cast_Int
	mut var_fulfillment_id := 
	
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_fulfillment_meta(mut var_request Class_WP_REST_Request) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) update_fulfillment_meta(mut var_request Class_WP_REST_Request) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) delete_fulfillment_meta(mut var_request Class_WP_REST_Request) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_tracking_number_details(mut var_request Class_WP_REST_Request) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_args_for_get_fulfillments() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_schema_for_get_fulfillments() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_args_for_create_fulfillment() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_schema_for_create_fulfillment() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_args_for_get_fulfillment() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_schema_for_get_fulfillment() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_args_for_update_fulfillment() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_schema_for_update_fulfillment() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_args_for_delete_fulfillment() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_schema_for_delete_fulfillment() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_args_for_get_fulfillment_meta() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_schema_for_get_fulfillment_meta() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_args_for_update_fulfillment_meta() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_schema_for_update_fulfillment_meta() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_args_for_delete_fulfillment_meta() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_schema_for_delete_fulfillment_meta() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_args_for_get_tracking_number_details() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_schema_for_get_tracking_number_details() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_read_schema_for_fulfillment() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_write_args_for_fulfillment(is_create bool) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) get_schema_for_meta_data() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) prepare_error_response(var_code rt.PhpVal, var_message rt.PhpVal, var_status rt.PhpVal) rt.PhpVal {
	mut var_status_mutated := var_status
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) validate_fulfillment(mut var_fulfillment Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment, fulfillment_id i64, order_id i64)  {
	mut var_fulfillment_mutated := var_fulfillment
	mut fulfillment_id_mutated := fulfillment_id
	mut order_id_mutated := order_id
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) check_request_source(mut var_request Class_WP_REST_Request) string {
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController) maybe_track_tracking_added(mut var_fulfillment Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment, mut var_request Class_WP_REST_Request, mut var_changes Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array)  {
	mut var_fulfillment_mutated := var_fulfillment
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

fn create_automattic_woocommerce_admin_features_fulfillments_orderfulfillmentsrestcontroller() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_OrderFulfillmentsRestController{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v3')
		rest_base: rt.new_string('/orders/(?P<order_id>[\\d]+)/fulfillments')
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapicontrollerbase() &Class_Automattic_WooCommerce_Internal_RestApiControllerBase {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApiControllerBase{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_wp_error() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_wc_data_store() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store{
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

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentstracker() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{
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

fn create_automattic_woocommerce_admin_features_fulfillments_exception() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Exception {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_metadatautil() &Class_Automattic_WooCommerce_Utilities_MetaDataUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_MetaDataUtil{
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.check_permission_for_fulfillments(mut dispatch_arg_0))
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
		'get_fulfillment_meta' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_fulfillment_meta(mut dispatch_arg_0)
		}
		'update_fulfillment_meta' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.update_fulfillment_meta(mut dispatch_arg_0)
		}
		'delete_fulfillment_meta' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.delete_fulfillment_meta(mut dispatch_arg_0)
		}
		'get_tracking_number_details' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			this.validate_fulfillment(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'check_request_source' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.check_request_source(mut dispatch_arg_0))
		}
		'maybe_track_tracking_added' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array](if args.len > 2 { args[2] } else { rt.new_null() })
			this.maybe_track_tracking_added(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		else { return none }
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
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_content_plugins_woocommerce_src_admin_features_fulfillments_orderfulfillmentsrestcontroller_php() {
	// unsupported statement: Stmt_Declare
}
