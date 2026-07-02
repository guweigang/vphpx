import rt

pub fn Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController.status_template_map() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderStatus.completed(), val: rt.create_array([rt.ArrayItem{ key: 'class', val: 'WC_Email_Customer_Completed_Order' }, rt.ArrayItem{ key: 'id', val: 'customer_completed_order' }]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderStatus.failed(), val: rt.create_array([rt.ArrayItem{ key: 'class', val: 'WC_Email_Customer_Failed_Order' }, rt.ArrayItem{ key: 'id', val: 'customer_failed_order' }]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold(), val: rt.create_array([rt.ArrayItem{ key: 'class', val: 'WC_Email_Customer_On_Hold_Order' }, rt.ArrayItem{ key: 'id', val: 'customer_on_hold_order' }]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderStatus.processing(), val: rt.create_array([rt.ArrayItem{ key: 'class', val: 'WC_Email_Customer_Processing_Order' }, rt.ArrayItem{ key: 'id', val: 'customer_processing_order' }]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderStatus.refunded(), val: rt.create_array([rt.ArrayItem{ key: 'class', val: 'WC_Email_Customer_Refunded_Order' }, rt.ArrayItem{ key: 'id', val: 'customer_refunded_order' }]) }])
}
struct Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) get_rest_api_namespace() string {
	return 'order-actions'
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) register_routes() {
	mut var_request := rt.new_null()
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request), 'get_email_templates')
		}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
		}
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Orders_OrderActionsRestController', ['Automattic_WooCommerce_Internal_RestApiControllerBase'], &this), 'route_namespace'), rt.new_string('/orders/(?P<id>[\\d]+)/actions/email_templates'), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier of the order.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_1_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_2_fn) }, rt.ArrayItem{ key: 'args', val: rt.new_array() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Orders_OrderActionsRestController', ['Automattic_WooCommerce_Internal_RestApiControllerBase'], &this) }, rt.ArrayItem{ key: none, val: 'get_schema_for_email_templates' }]) }])])
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request), 'send_email')
		}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
		}
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Orders_OrderActionsRestController', ['Automattic_WooCommerce_Internal_RestApiControllerBase'], &this), 'route_namespace'), rt.new_string('/orders/(?P<id>[\\d]+)/actions/send_email'), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier of the order.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_3_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_4_fn) }, rt.ArrayItem{ key: 'args', val: this.get_args_for_order_actions('send_email', Class_WP_REST_Server.creatable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Orders_OrderActionsRestController', ['Automattic_WooCommerce_Internal_RestApiControllerBase'], &this) }, rt.ArrayItem{ key: none, val: 'get_schema_for_order_actions' }]) }])])
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request), 'send_order_details')
		}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
		}
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Orders_OrderActionsRestController', ['Automattic_WooCommerce_Internal_RestApiControllerBase'], &this), 'route_namespace'), rt.new_string('/orders/(?P<id>[\\d]+)/actions/send_order_details'), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier of the order.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_5_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_6_fn) }, rt.ArrayItem{ key: 'args', val: this.get_args_for_order_actions('send_order_details', Class_WP_REST_Server.creatable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Orders_OrderActionsRestController', ['Automattic_WooCommerce_Internal_RestApiControllerBase'], &this) }, rt.ArrayItem{ key: none, val: 'get_schema_for_order_actions' }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) validate_order_id(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_order_id := var_request.get_param(rt.new_string('id'))
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_not_found'), rt.call_function('__', [rt.new_string('Order not found'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	return var_order_id.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) run(mut var_request Class_WP_REST_Request, method_name string) rt.PhpVal {
	mut var_order_id := this.validate_order_id(mut var_request)
	if rt.is_true(rt.call_function('is_wp_error', [var_order_id.clone()])) {
		return var_order_id.clone()
	}
	return this.Class_Automattic_WooCommerce_Internal_RestApiControllerBase.run(rt.new_object('WP_REST_Request', []string{}, var_request), rt.new_string(method_name))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) check_permissions(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_order_id := this.validate_order_id(mut var_request)
	if rt.is_true(rt.call_function('is_wp_error', [var_order_id.clone()])) {
		return var_order_id.clone()
	}
	return this.check_permission(rt.new_object('WP_REST_Request', []string{}, var_request), rt.new_string('read_shop_order'), var_order_id.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) get_args_for_order_actions(action_slug string) rt.PhpVal {
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'email', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Email address to send the order details to.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'email' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }, rt.ArrayItem{ key: 'force_email_update', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether to update the billing email of the order, even if it already has one.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'sanitize_callback', val: 'rest_sanitize_boolean' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }])
	if rt.is_true(rt.identical(rt.new_string('send_email'), rt.new_string(action_slug))) {
		var_args.array_set('template_id', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The email template to use. If omitted, the best template is auto-selected based on order status.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: this.get_template_id_enum() }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	}
	return var_args.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) get_schema_for_email_templates() rt.PhpVal {
	mut var_schema := rt.create_array([rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Email Template'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('A unique ID string for the email template.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: this.get_template_id_enum() }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'embed' }]) }]) }, rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The display name of the email template.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }]) }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('A description of the purpose of the email template.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }]) }]) }]) }])
	return var_schema.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) get_schema_for_order_actions() rt.PhpVal {
	mut var_schema := rt.create_array([rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Order Actions'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'message', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('A message indicating that the action completed successfully.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }])
	return var_schema.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) get_template_id_enum() rt.PhpVal {
	mut var_enum := rt.new_array()
	if rt.is_true(rt.new_bool(rt.get_property(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'mailer', []rt.PhpVal{}), 'emails').is_array())) {
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_template := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_template, 'WC_Email')))))) || !rt.is_true(rt.get_property(var_template, 'id')) {
			return rt.new_null()
		}
		return rt.get_property(var_template, 'id')
		}
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_template := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_template, 'WC_Email')))))) || !rt.is_true(rt.get_property(var_template, 'id')) {
			return rt.new_null()
		}
		return rt.get_property(var_template, 'id')
		}
	var_enum = rt.call_function('array_map', [rt.new_closure(closure_7_fn), rt.get_property(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'mailer', []rt.PhpVal{}), 'emails'), rt.new_array()])
	}
	return rt.call_function('array_filter', [var_enum.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) get_available_email_templates(mut var_order Class_WC_Order) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_all_email_templates := rt.get_property(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'mailer', []rt.PhpVal{}), 'emails')
	mut var_order_status := rt.call_method(var_order_mutated, 'get_status', [rt.new_string('edit')])
	mut var_unavailable_statuses := rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.auto_draft() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.draft() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.new() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.trash() }])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order_mutated, 'get_billing_email', []rt.PhpVal{}))))) || rt.is_true(rt.call_function('in_array', [var_order_status.clone(), var_unavailable_statuses.clone(), rt.new_bool(true)])) {
		return rt.new_array()
	}
	mut var_valid_template_classes := rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Email_Customer_Invoice' }])
	if this.order_is_partially_refunded(mut var_order_mutated) {
		var_valid_template_classes.array_push('WC_Email_Customer_Refunded_Order')
	}
	if Class_Automattic_WooCommerce_Internal_Orders_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController.status_template_map().array_isset(var_order_status) {
		var_valid_template_classes.array_push(Class_Automattic_WooCommerce_Internal_Orders_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController.status_template_map().array_get(var_order_status).array_get(rt.new_string('class')))
	}
	var_valid_template_classes = rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_order_actions_email_valid_template_classes'), var_valid_template_classes.clone(), var_order_mutated])
	var_valid_template_classes = rt.call_function('array_filter', [rt.call_function('array_unique', [var_valid_template_classes.clone()]), rt.new_string('is_string')])
	mut var_valid_templates := rt.call_function('array_fill_keys', [var_valid_template_classes.clone(), rt.new_string('')])
	return rt.call_function('array_intersect_key', [var_all_email_templates.clone(), var_valid_templates.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) get_email_template_by_id(template_id string, mut var_available_templates Class_Automattic_WooCommerce_Internal_Orders_?array) rt.PhpVal {
	mut var_template := rt.new_null()
	mut template_id_mutated := template_id
	mut var_available_templates_mutated := var_available_templates
	if rt.is_true(rt.new_bool(var_available_templates_mutated.is_null())) {
	var_available_templates_mutated = rt.get_property(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'mailer', []rt.PhpVal{}), 'emails')
	}
	closure_9_fn := fn [var_template_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_template := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(rt.get_property(var_template, 'id'), rt.new_string(template_id_mutated))
		}
	mut var_matching_templates := rt.call_function('array_filter', [var_available_templates_mutated, rt.new_closure(closure_9_fn)])
	if !rt.is_true(var_matching_templates) {
		return rt.new_null()
	}
	return rt.call_function('reset', [var_matching_templates.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) select_default_template(mut var_order Class_WC_Order, mut var_available_templates Class_Automattic_WooCommerce_Internal_Orders_array) rt.PhpVal {
	mut var_t := rt.new_null()
	mut var_order_mutated := var_order
	mut var_available_templates_mutated := var_available_templates
	if !rt.is_true(var_available_templates_mutated) {
		return rt.new_null()
	}
	mut var_default_preferred_ids := this.get_default_preferred_template_ids(mut var_order_mutated)
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_t := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.get_property(var_t, 'id')
		}
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_t := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.get_property(var_t, 'id')
		}
	mut var_preferred_template_ids := rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_order_actions_email_preferred_template_ids'), var_default_preferred_ids.clone(), var_order_mutated, rt.call_function('array_map', [rt.new_closure(closure_10_fn), var_available_templates_mutated])])
	if !(var_preferred_template_ids.clone().is_array()) {
	var_preferred_template_ids = var_default_preferred_ids.clone()
	}
	var_preferred_template_ids = rt.call_function('array_filter', [rt.call_function('array_unique', [var_preferred_template_ids.clone()]), rt.new_string('is_string')])
	mut iter_1 := var_preferred_template_ids.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_candidate_id := item_1.val
		mut var_template := this.get_email_template_by_id((var_candidate_id).str(), mut var_available_templates_mutated)
		if rt.is_true(var_template) {
			return var_template.clone()
		}
	}
	mut var_first := rt.call_function('reset', [var_available_templates_mutated])
	return if rt.is_true(var_first) { var_first } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) get_default_preferred_template_ids(mut var_order Class_WC_Order) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_status := rt.call_method(var_order_mutated, 'get_status', [rt.new_string('edit')])
	mut var_preferred_template_ids := rt.new_array()
	if Class_Automattic_WooCommerce_Internal_Orders_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController.status_template_map().array_isset(var_status) {
		var_preferred_template_ids.array_push(Class_Automattic_WooCommerce_Internal_Orders_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController.status_template_map().array_get(var_status).array_get(rt.new_string('id')))
	}
	var_preferred_template_ids.array_push('customer_invoice')
	return var_preferred_template_ids.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) get_email_templates(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_a := rt.new_null()
	mut var_b := rt.new_null()
	mut var_order := rt.call_function('wc_get_order', [var_request.get_param(rt.new_string('id'))])
	mut var_available_templates := this.get_available_email_templates(mut rt.cast_object_ptr[Class_WC_Order](var_order))
	mut var_templates := rt.new_array()
	mut iter_2 := var_available_templates.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_template := item_2.val
		var_templates.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: rt.get_property(var_template, 'id') }, rt.ArrayItem{ key: 'title', val: rt.call_method(var_template, 'get_title', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'description', val: rt.call_method(var_template, 'get_description', []rt.PhpVal{}) }]))
	}
	closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_a := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_b := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return rt.call_function('strcmp', [var_a.array_get(rt.new_string('id')), var_b.array_get(rt.new_string('id'))])
		}
	rt.call_function('usort', [var_templates.clone(), rt.new_closure(closure_12_fn)])
	mut var_schema := this.get_schema_for_email_templates()
	mut var_context := if !(var_request.get_param(rt.new_string('context'))).is_null() { var_request.get_param(rt.new_string('context')) } else { rt.new_string('view') }
	closure_13_fn := fn [var_schema, var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_template := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('rest_filter_response_by_context', [var_template.clone(), var_schema.clone(), var_context.clone()])
		}
	closure_14_fn := fn [var_schema, var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_template := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('rest_filter_response_by_context', [var_template.clone(), var_schema.clone(), var_context.clone()])
		}
	mut var_filtered_response := rt.call_function('array_map', [rt.new_closure(closure_13_fn), var_templates.clone()])
	return var_filtered_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) send_email(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_order := rt.call_function('wc_get_order', [var_request.get_param(rt.new_string('id'))])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order')))))) {
		return create_wp_error(rt.new_string('woocommerce_rest_not_found'), rt.call_function('__', [rt.new_string('Order not found.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_email := var_request.get_param(rt.new_string('email'))
	mut var_force := rt.call_function('wp_validate_boolean', [var_request.get_param(rt.new_string('force_email_update'))])
	mut var_template_id := var_request.get_param(rt.new_string('template_id'))
	mut var_messages := rt.new_array()
	if rt.is_true(var_email) {
		mut var_message := rt.new_string(this.maybe_update_billing_email(mut rt.cast_object_ptr[Class_WC_Order](var_order), (var_email).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Orders_?bool](var_force)))
		if rt.is_true(rt.call_function('is_wp_error', [var_message.clone()])) {
			return var_message.clone()
		}
		var_messages.array_push(var_message.clone())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [rt.call_method(var_order, 'get_billing_email', []rt.PhpVal{})]))))) {
		return create_wp_error(rt.new_string('woocommerce_rest_missing_email'), rt.call_function('__', [rt.new_string('Order does not have an email address.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_available_templates := this.get_available_email_templates(mut rt.cast_object_ptr[Class_WC_Order](var_order))
	if !rt.is_true(var_template_id) {
		mut var_template := this.select_default_template(mut rt.cast_object_ptr[Class_WC_Order](var_order), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Orders_array](var_available_templates))
		if rt.is_true(rt.new_bool(var_template.clone().is_null())) {
			return create_wp_error(rt.new_string('woocommerce_rest_no_email_template'), rt.call_function('__', [rt.new_string('No email template is available for this order.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		}
	var_template_id = rt.get_property(var_template, 'id')
	} else {
		var_template = this.get_email_template_by_id((var_template_id).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Orders_?array](var_available_templates))
		if rt.is_true(rt.new_bool(var_template.clone().is_null())) {
			return create_wp_error(rt.new_string('woocommerce_rest_invalid_email_template'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s is not a valid template for this order.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_template_id.clone()])]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		}
	}
	mut switch_val_1 := var_template_id
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('customer_completed_order'))) {
		rt.call_function('do_action', [rt.new_string('woocommerce_order_status_completed_notification'), rt.call_method(var_order, 'get_id', []rt.PhpVal{}), var_order.clone()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('customer_failed_order'))) {
		rt.call_function('do_action', [rt.new_string('woocommerce_order_status_failed_notification'), rt.call_method(var_order, 'get_id', []rt.PhpVal{}), var_order.clone()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('customer_on_hold_order'))) {
		rt.call_function('do_action', [rt.new_string('woocommerce_order_status_pending_to_on-hold_notification'), rt.call_method(var_order, 'get_id', []rt.PhpVal{}), var_order.clone()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('customer_processing_order'))) {
		rt.call_function('do_action', [rt.new_string('woocommerce_order_status_pending_to_processing_notification'), rt.call_method(var_order, 'get_id', []rt.PhpVal{}), var_order.clone()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('customer_refunded_order'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('customer_pos_refunded_order'))) {
		if this.order_is_partially_refunded(mut rt.cast_object_ptr[Class_WC_Order](var_order)) {
			rt.call_function('do_action', [rt.new_string('woocommerce_order_partially_refunded_notification'), rt.call_method(var_order, 'get_id', []rt.PhpVal{})])
		} else {
			rt.call_function('do_action', [rt.new_string('woocommerce_order_fully_refunded_notification'), rt.call_method(var_order, 'get_id', []rt.PhpVal{})])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('customer_invoice'))) {
		return this.send_order_details(mut var_request)
	} else {
		rt.call_function('do_action', [rt.new_string('woocommerce_rest_order_actions_email_send'), rt.call_method(var_order, 'get_id', []rt.PhpVal{}), var_template_id.clone()])
	}
	mut var_user_agent := rt.call_function('esc_html', [var_request.get_header(rt.new_string('User-Agent'))])
	var_messages.array_push(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Email template "%1$s" sent to %2$s.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.call_method(var_template, 'get_title', []rt.PhpVal{})]), rt.call_function('esc_html', [rt.call_method(var_order, 'get_billing_email', []rt.PhpVal{})])]))
	var_messages = rt.call_function('array_filter', [var_messages.clone()])
	mut iter_3 := var_messages.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_message_shadow := item_3.val
		rt.call_method(var_order, 'add_order_note', [var_message_shadow.clone(), rt.new_int(0), rt.new_bool(true), rt.create_array([rt.ArrayItem{ key: 'user_agent', val: if rt.is_true(var_user_agent) { var_user_agent } else { rt.new_string('REST API') } }, rt.ArrayItem{ key: 'note_group', val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.email_notification() }])])
	}
	return rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('implode', [rt.new_string(' '), var_messages.clone()]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) send_order_details(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_order := rt.call_function('wc_get_order', [var_request.get_param(rt.new_string('id'))])
	mut var_email := var_request.get_param(rt.new_string('email'))
	mut var_force := rt.call_function('wp_validate_boolean', [var_request.get_param(rt.new_string('force_email_update'))])
	mut var_messages := rt.new_array()
	if rt.is_true(var_email) {
		mut var_message := rt.new_string(this.maybe_update_billing_email(mut rt.cast_object_ptr[Class_WC_Order](var_order), (var_email).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Orders_?bool](var_force)))
		if rt.is_true(rt.call_function('is_wp_error', [var_message.clone()])) {
			return var_message.clone()
		}
		var_messages.array_push(var_message.clone())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [rt.call_method(var_order, 'get_billing_email', []rt.PhpVal{})]))))) {
		return create_wp_error(rt.new_string('woocommerce_rest_missing_email'), rt.call_function('__', [rt.new_string('Order does not have an email address.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_before_resend_order_emails'), var_order.clone(), rt.new_string('customer_invoice')])
	rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})
	rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping', []rt.PhpVal{})
	rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'mailer', []rt.PhpVal{}), 'customer_invoice', [var_order.clone()])
	mut var_user_agent := rt.call_function('esc_html', [var_request.get_header(rt.new_string('User-Agent'))])
	var_messages.array_push(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Order details sent to %s.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.call_method(var_order, 'get_billing_email', []rt.PhpVal{})])]))
	var_messages = rt.call_function('array_filter', [var_messages.clone()])
	mut iter_4 := var_messages.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_message_shadow := item_4.val
		rt.call_method(var_order, 'add_order_note', [var_message_shadow.clone(), rt.new_int(0), rt.new_bool(true), rt.create_array([rt.ArrayItem{ key: 'user_agent', val: if rt.is_true(var_user_agent) { var_user_agent } else { rt.new_string('REST API') } }, rt.ArrayItem{ key: 'note_title', val: rt.call_function('__', [rt.new_string('Order confirmation email'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'note_group', val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.email_notification() }])])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_after_resend_order_email'), var_order.clone(), rt.new_string('customer_invoice')])
	return rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('implode', [rt.new_string(' '), var_messages.clone()]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) maybe_update_billing_email(mut var_order Class_WC_Order, email string, mut var_force Class_Automattic_WooCommerce_Internal_Orders_?bool) string {
	mut var_order_mutated := var_order
	mut email_mutated := email
	mut var_force_mutated := var_force
	mut var_existing_email := rt.call_method(var_order_mutated, 'get_billing_email', [rt.new_string('edit')])
	if rt.is_true(rt.identical(var_existing_email, rt.new_string(email_mutated))) {
		return ''
	}
	if rt.is_true(var_existing_email) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), var_force_mutated)))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_order_billing_email_exists'), rt.call_function('__', [rt.new_string('Order already has a billing email.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).str()
	}
	rt.call_method(var_order_mutated, 'set_billing_email', [rt.new_string(email_mutated).clone()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_order_mutated, 'save', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'WC_Data_Exception') {
		mut var_e := var_e_1.clone()
		return (create_wp_error(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}))).str()
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Billing email updated to %s.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.new_string(email_mutated).clone()])])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) order_is_partially_refunded(mut var_order Class_WC_Order) bool {
	mut var_order_mutated := var_order
	mut var_remaining_amount := rt.call_method(var_order_mutated, 'get_remaining_refund_amount', []rt.PhpVal{})
	mut var_remaining_items := rt.call_method(var_order_mutated, 'get_remaining_refund_items', []rt.PhpVal{})
	mut var_refunds := rt.call_method(var_order_mutated, 'get_refunds', []rt.PhpVal{})
	mut var_last_refund := rt.call_function('reset', [var_refunds.clone()])
	mut var_partially_refunded := rt.call_function('apply_filters', [rt.new_string('woocommerce_order_is_partially_refunded'), rt.new_bool(var_refunds.clone().array_count() > 0 && rt.is_true(rt.greater(var_remaining_amount, rt.new_int(0))) || (rt.is_true(rt.call_method(var_order_mutated, 'has_free_item', []rt.PhpVal{})) && rt.is_true(rt.greater(var_remaining_items, rt.new_int(0))))), rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}), if rt.is_true(var_last_refund) { rt.call_method(var_last_refund, 'get_id', []rt.PhpVal{}) } else { rt.new_int(0) }])
	return (var_partially_refunded).to_bool()
}

struct Class_Automattic_WooCommerce_Internal_RestApiControllerBase {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_orders_orderactionsrestcontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController {
	mut obj := &Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapicontrollerbase(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApiControllerBase {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApiControllerBase{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_rest_api_namespace' {
			return rt.new_string(this.get_rest_api_namespace())
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'validate_order_id' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.validate_order_id(mut dispatch_arg_0)
		}
		'run' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.run(mut dispatch_arg_0, dispatch_arg_1)
		}
		'check_permissions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.check_permissions(mut dispatch_arg_0)
		}
		'get_args_for_order_actions' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_args_for_order_actions(dispatch_arg_0)
		}
		'get_schema_for_email_templates' {
			return this.get_schema_for_email_templates()
		}
		'get_schema_for_order_actions' {
			return this.get_schema_for_order_actions()
		}
		'get_template_id_enum' {
			return this.get_template_id_enum()
		}
		'get_available_email_templates' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_available_email_templates(mut dispatch_arg_0)
		}
		'get_email_template_by_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Orders_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.get_email_template_by_id(dispatch_arg_0, mut dispatch_arg_1)
		}
		'select_default_template' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Orders_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.select_default_template(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_default_preferred_template_ids' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_default_preferred_template_ids(mut dispatch_arg_0)
		}
		'get_email_templates' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_email_templates(mut dispatch_arg_0)
		}
		'send_email' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.send_email(mut dispatch_arg_0)
		}
		'send_order_details' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.send_order_details(mut dispatch_arg_0)
		}
		'maybe_update_billing_email' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Orders_?bool](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_string(this.maybe_update_billing_email(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2))
		}
		'order_is_partially_refunded' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.order_is_partially_refunded(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
