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

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) register_routes()  {
	mut var_request := rt.new_null()
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request), 'get_email_templates')
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Orders_OrderActionsRestController', ['Automattic_WooCommerce_Internal_RestApiControllerBase'], &this), 'route_namespace'), rt.new_string('/orders/(?P<id>[\\d]+)/actions/email_templates'), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier of the order.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_1_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_2_fn) }, rt.ArrayItem{ key: 'args', val: rt.new_array() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Orders_OrderActionsRestController', ['Automattic_WooCommerce_Internal_RestApiControllerBase'], &this) }, rt.ArrayItem{ key: none, val: 'get_schema_for_email_templates' }]) }])])
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request), 'send_email')
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Orders_OrderActionsRestController', ['Automattic_WooCommerce_Internal_RestApiControllerBase'], &this), 'route_namespace'), rt.new_string('/orders/(?P<id>[\\d]+)/actions/send_email'), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier of the order.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_3_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_4_fn) }, rt.ArrayItem{ key: 'args', val: this.get_args_for_order_actions('send_email', Class_WP_REST_Server.creatable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Orders_OrderActionsRestController', ['Automattic_WooCommerce_Internal_RestApiControllerBase'], &this) }, rt.ArrayItem{ key: none, val: 'get_schema_for_order_actions' }]) }])])
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request), 'send_order_details')
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Orders_OrderActionsRestController', ['Automattic_WooCommerce_Internal_RestApiControllerBase'], &this), 'route_namespace'), rt.new_string('/orders/(?P<id>[\\d]+)/actions/send_order_details'), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier of the order.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_5_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_6_fn) }, rt.ArrayItem{ key: 'args', val: this.get_args_for_order_actions('send_order_details', Class_WP_REST_Server.creatable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Orders_OrderActionsRestController', ['Automattic_WooCommerce_Internal_RestApiControllerBase'], &this) }, rt.ArrayItem{ key: none, val: 'get_schema_for_order_actions' }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) validate_order_id(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_order_id := var_request.get_param(rt.new_string('id'))
	mut var_order := rt.call_function('wc_get_order', [var_order_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return create_wp_error(rt.new_string('woocommerce_rest_not_found'), rt.call_function('__', [rt.new_string('Order not found'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	return var_order_id.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) run(mut var_request Class_WP_REST_Request, method_name string) rt.PhpVal {
	mut var_order_id := this.validate_order_id(mut var_request)
	if rt.is_true(rt.call_function('is_wp_error', [var_order_id.dup()])) {
		return var_order_id.dup()
	}
	return this.Class_Automattic_WooCommerce_Internal_RestApiControllerBase.run(rt.new_object('WP_REST_Request', []string{}, var_request), rt.new_string(method_name))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) check_permissions(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_order_id := this.validate_order_id(mut var_request)
	if rt.is_true(rt.call_function('is_wp_error', [var_order_id.dup()])) {
		return var_order_id.dup()
	}
	return this.check_permission(rt.new_object('WP_REST_Request', []string{}, var_request), rt.new_string('read_shop_order'), var_order_id.dup())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) get_args_for_order_actions(action_slug string) rt.PhpVal {
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'email', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Email address to send the order details to.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'email' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }, rt.ArrayItem{ key: 'force_email_update', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether to update the billing email of the order, even if it already has one.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'sanitize_callback', val: 'rest_sanitize_boolean' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }])
	if rt.is_true(rt.identical(rt.new_string('send_email'), rt.new_string(action_slug))) {
		var_args.array_set('template_id', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The email template to use. If omitted, the best template is auto-selected based on order status.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: this.get_template_id_enum() }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	}
	return var_args.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) get_schema_for_email_templates() rt.PhpVal {
	mut var_schema := rt.create_array([rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Email Template'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('A unique ID string for the email template.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: this.get_template_id_enum() }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'embed' }]) }]) }, rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The display name of the email template.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }]) }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('A description of the purpose of the email template.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }]) }]) }]) }])
	return var_schema.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) get_schema_for_order_actions() rt.PhpVal {
	mut var_schema := rt.create_array([rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Order Actions'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'message', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('A message indicating that the action completed successfully.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }])
	return var_schema.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) get_template_id_enum() rt.PhpVal {
	mut var_enum := rt.new_array()
	if rt.is_true(rt.new_bool(rt.get_property(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'mailer', []rt.PhpVal{}), 'emails').is_array())) {
		closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_template := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_template, 'WC_Email')))))) || !rt.is_true(rt.get_property(var_template, 'id')))) {
		return rt.new_null()
	}
	return rt.get_property(var_template, 'id')
	}
	mut var_template := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_template, 'WC_Email')))))) || !rt.is_true(rt.get_property(var_template, 'id')))) {
		return rt.new_null()
	}
	return rt.get_property(var_template, 'id')
	}
		var_enum = rt.call_function('array_map', [rt.new_closure(closure_7_fn), rt.get_property(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'mailer', []rt.PhpVal{}), 'emails'), rt.new_array()])
	}
	return rt.call_function('array_filter', [var_enum.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) get_available_email_templates(mut var_order Class_WC_Order) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_all_email_templates := rt.get_property(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'mailer', []rt.PhpVal{}), 'emails')
	mut var_order_status := rt.call_method(var_order_mutated, 'get_status', [rt.new_string('edit')])
	mut var_unavailable_statuses := rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.auto_draft() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.draft() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.new() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.trash() }])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order_mutated, 'get_billing_email', []rt.PhpVal{}))))) || rt.is_true(rt.call_function('in_array', [var_order_status.dup(), var_unavailable_statuses.dup(), rt.new_bool(true)])))) {
		return rt.new_array()
	}
	mut var_valid_template_classes := rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Email_Customer_Invoice' }])
	if this.order_is_partially_refunded(mut var_order_mutated) {
		var_valid_template_classes.array_push('WC_Email_Customer_Refunded_Order')
	}
	if Class_Automattic_WooCommerce_Internal_Orders_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController.status_template_map().array_isset(var_order_status) {
		var_valid_template_classes.array_push(Class_Automattic_WooCommerce_Internal_Orders_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController.status_template_map().array_get(var_order_status).array_get('class'))
	}
	var_valid_template_classes = rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_order_actions_email_valid_template_classes'), var_valid_template_classes.dup(), var_order_mutated.dup()])
	var_valid_template_classes = rt.call_function('array_filter', [rt.call_function('array_unique', [var_valid_template_classes.dup()]), rt.new_string('is_string')])
	mut var_valid_templates := rt.call_function('array_fill_keys', [var_valid_template_classes.dup(), rt.new_string('')])
	return rt.call_function('array_intersect_key', [var_all_email_templates.dup(), var_valid_templates.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) get_email_template_by_id(template_id string, mut var_available_templates Class_Automattic_WooCommerce_Internal_Orders_?array) rt.PhpVal {
	mut var_template := rt.new_null()
	mut template_id_mutated := template_id
	mut var_available_templates_mutated := var_available_templates
	if rt.is_true(rt.new_bool(var_available_templates_mutated.dup().is_null())) {
		var_available_templates_mutated = rt.get_property(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'mailer', []rt.PhpVal{}), 'emails')
	}
	closure_9_fn := fn [var_template_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_template := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.identical(rt.get_property(var_template, 'id'), rt.new_string(template_id_mutated))
	}
	mut var_matching_templates := rt.call_function('array_filter', [var_available_templates_mutated.dup(), rt.new_closure(closure_9_fn)])
	if !rt.is_true(var_matching_templates) {
		return rt.new_null()
	}
	return rt.call_function('reset', [var_matching_templates.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) select_default_template(mut var_order Class_WC_Order, mut var_available_templates Class_Automattic_WooCommerce_Internal_Orders_array) rt.PhpVal {
	mut var_t := rt.new_null()
	mut var_order_mutated := var_order
	mut var_available_templates_mutated := var_available_templates
	if !rt.is_true(var_available_templates_mutated) {
		return rt.new_null()
	}
	mut var_default_preferred_ids := this.get_default_preferred_template_ids(mut var_order_mutated)
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_t := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.get_property(var_t, 'id')
	}
	mut var_t := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.get_property(var_t, 'id')
	}
	mut var_preferred_template_ids := rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_order_actions_email_preferred_template_ids'), var_default_preferred_ids.dup(), var_order_mutated.dup(), rt.call_function('array_map', [rt.new_closure(closure_10_fn), var_available_templates_mutated.dup()])])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_preferred_template_ids.dup().is_array()))))) {
		var_preferred_template_ids = var_default_preferred_ids.dup()
	}
	var_preferred_template_ids = rt.call_function('array_filter', [rt.call_function('array_unique', [var_preferred_template_ids.dup()]), rt.new_string('is_string')])
	{
		mut iter_1 := var_preferred_template_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_candidate_id := item_1.val
			mut var_template := this.get_email_template_by_id((var_candidate_id).str(), mut var_available_templates_mutated)
			if rt.is_true(var_template) {
				return var_template.dup()
			}
		}
	}
	mut var_first := rt.call_function('reset', [var_available_templates_mutated.dup()])
	return if rt.is_true(var_first) { var_first } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) get_default_preferred_template_ids(mut var_order Class_WC_Order) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_status := rt.call_method(var_order_mutated, 'get_status', [rt.new_string('edit')])
	mut var_preferred_template_ids := rt.new_array()
	if Class_Automattic_WooCommerce_Internal_Orders_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController.status_template_map().array_isset(var_status) {
		var_preferred_template_ids.array_push(Class_Automattic_WooCommerce_Internal_Orders_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController.status_template_map().array_get(var_status).array_get('id'))
	}
	var_preferred_template_ids.array_push('customer_invoice')
	return var_preferred_template_ids.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) get_email_templates(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_a := rt.new_null()
	mut var_b := rt.new_null()
	mut var_order := rt.call_function('wc_get_order', [var_request.get_param(rt.new_string('id'))])
	mut var_available_templates := this.get_available_email_templates(mut rt.cast_object_ptr[Class_WC_Order](var_order))
	mut var_templates := rt.new_array()
	{
		mut iter_1 := var_available_templates.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_template := item_1.val
			var_templates.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: rt.get_property(var_template, 'id') }, rt.ArrayItem{ key: 'title', val: rt.call_method(var_template, 'get_title', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'description', val: rt.call_method(var_template, 'get_description', []rt.PhpVal{}) }]))
		}
	}
	closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_a := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_b := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return rt.call_function('strcmp', [var_a.array_get('id'), var_b.array_get('id')])
	}
	rt.call_function('usort', [var_templates.dup(), rt.new_closure(closure_12_fn)])
	mut var_schema := this.get_schema_for_email_templates()
	mut var_context := if !(var_request.get_param(rt.new_string('context'))).is_null() { var_request.get_param(rt.new_string('context')) } else { rt.new_string('view') }
	closure_14_fn := fn [var_schema, var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_13_fn := fn [var_schema, var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_template := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_function('rest_filter_response_by_context', [var_template.dup(), var_schema.dup(), var_context.dup()])
	}
	mut var_template := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_function('rest_filter_response_by_context', [var_template.dup(), var_schema.dup(), var_context.dup()])
	}
	mut var_filtered_response := rt.call_function('array_map', [rt.new_closure(closure_13_fn), var_templates.dup()])
	return var_filtered_response.dup()
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
		if rt.is_true(rt.call_function('is_wp_error', [var_message.dup()])) {
			return var_message.dup()
		}
		var_messages.array_push(var_message.dup())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [rt.call_method(var_order, 'get_billing_email', []rt.PhpVal{})]))))) {
		return create_wp_error(rt.new_string('woocommerce_rest_missing_email'), rt.call_function('__', [rt.new_string('Order does not have an email address.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_available_templates := this.get_available_email_templates(mut rt.cast_object_ptr[Class_WC_Order](var_order))
	if !rt.is_true(var_template_id) {
		mut var_template := this.select_default_template(mut rt.cast_object_ptr[Class_WC_Order](var_order), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Orders_array](var_available_templates))
		if rt.is_true(rt.new_bool(var_template.dup().is_null())) {
			return create_wp_error(rt.new_string('woocommerce_rest_no_email_template'), rt.call_function('__', [rt.new_string('No email template is available for this order.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		}
		var_template_id = rt.get_property(var_template, 'id')
	} else {
		var_template = this.get_email_template_by_id((var_template_id).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Orders_?array](var_available_templates))
		if rt.is_true(rt.new_bool(var_template.dup().is_null())) {
			return create_wp_error(, , )
		}
	}
	mut switch_val_1 := var_template_id
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('customer_completed_order'))) {
		rt.call_function('do_action', [, , .dup()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('customer_failed_order'))) {
		
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	} else if rt.is_true(rt.equal(switch_val_1, )) || rt.is_true(rt.equal(switch_val_1, )) {
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	} else {
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) send_order_details(mut var_request Class_WP_REST_Request) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) maybe_update_billing_email(mut var_order Class_WC_Order, email string, mut var_force Class_Automattic_WooCommerce_Internal_Orders_?bool) string {
	mut var_order_mutated := var_order
	mut email_mutated := email
	mut var_force_mutated := var_force
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController) order_is_partially_refunded(mut var_order Class_WC_Order) bool {
	mut var_order_mutated := var_order
}

struct Class_Automattic_WooCommerce_Internal_RestApiControllerBase {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_orders_orderactionsrestcontroller() &Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController {
	mut obj := &Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapicontrollerbase() &Class_Automattic_WooCommerce_Internal_RestApiControllerBase {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApiControllerBase{
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




pub fn init_wp_content_plugins_woocommerce_src_internal_orders_orderactionsrestcontroller_php() {
	// unsupported statement: Stmt_Declare
}
