import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController {
	rt.PhpObjectBase
pub mut:
		route_namespace rt.PhpVal = rt.new_string('wc-admin')
		rest_base rt.PhpVal = rt.new_string('settings/payments')
		payments rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) get_rest_api_namespace() string {
	return 'wc-admin-settings-payments'
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) register_routes(override bool)  {
	mut var_request := rt.new_null()
	mut var_value := rt.new_null()
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('set_country'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_request := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return this.check_location_arg(var_value.dup(), mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace, '/' + (this.rest_base).str() + '/country', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_1_fn) }, rt.ArrayItem{ key: 'validation_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_2_fn) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'location', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('The ISO3166 alpha-2 country code to save for the current user.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_3_fn) }]) }]) }]) }]), rt.new_bool(override)])
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('get_providers'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_request := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return this.check_location_arg(var_value.dup(), mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	return this.get_schema_for_get_payment_providers()
	}
	rt.call_function('register_rest_route', [this.route_namespace, '/' + (this.rest_base).str() + '/providers', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_4_fn) }, rt.ArrayItem{ key: 'validation_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_5_fn) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'location', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('ISO3166 alpha-2 country code. Defaults to WooCommerce\'s base location country.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_6_fn) }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.new_closure(closure_7_fn) }]), rt.new_bool(override)])
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('update_providers_order'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_providers_order_map_arg(var_value.dup())
	}
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.sanitize_providers_order_arg(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_value))
	}
	rt.call_function('register_rest_route', [this.route_namespace, '/' + (this.rest_base).str() + '/providers/order', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_8_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_9_fn) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'order_map', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('A map of provider ID to integer values representing the sort order.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_10_fn) }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.new_closure(closure_11_fn) }]) }]) }]) }]), rt.new_bool(override)])
	closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('attach_payment_extension_suggestion'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace, '/' + (this.rest_base).str() + '/suggestion/(?P<id>[\\w\\d\\-]+)/attach', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_12_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_13_fn) }]) }]), rt.new_bool(override)])
	closure_15_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_14_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('hide_payment_extension_suggestion'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace, '/' + (this.rest_base).str() + '/suggestion/(?P<id>[\\w\\d\\-]+)/hide', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_14_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_15_fn) }]) }]), rt.new_bool(override)])
	closure_17_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_16_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('dismiss_payment_extension_suggestion_incentive'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace, '/' + (this.rest_base).str() + '/suggestion/(?P<suggestion_id>[\\w\\d\\-]+)/incentive/(?P<incentive_id>[\\w\\d\\-]+)/dismiss', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_16_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_17_fn) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('The context ID for which to dismiss the incentive. If not provided, will dismiss the incentive for all contexts.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' }]) }, rt.ArrayItem{ key: 'do_not_track', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('If true, the incentive dismissal will be ignored by tracking.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'sanitize_callback', val: 'rest_sanitize_boolean' }]) }]) }]) }]), rt.new_bool(override)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) init(mut var_payments Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments)  {
	this.payments = var_payments.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) get_providers(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_provider := rt.new_null()
	mut var_location := var_request.get_param(rt.new_string('location'))
	if !rt.is_true(var_location) {
		var_location = rt.call_method(this.payments, 'get_country', []rt.PhpVal{})
	}
	mut var_providers := rt.call_method(this.payments, 'get_payment_providers', [var_location.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		return create_wp_error(rt.new_string('woocommerce_rest_payment_providers_error'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	mut var_suggestions := this.get_extension_suggestions((var_location).str())
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.dup()
		return create_wp_error(rt.new_string('woocommerce_rest_payment_providers_error'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	closure_19_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_18_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_provider := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.type_offline_pm(), var_provider.array_get('_type'))
	}
	mut var_provider := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.type_offline_pm(), var_provider.array_get('_type'))
	}
	mut var_offline_payment_providers := rt.call_function('array_values', [rt.call_function('array_filter', [var_providers.dup(), rt.new_closure(closure_18_fn)])])
	closure_21_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_20_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_provider := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return // unsupported expression: Expr_BinaryOp_NotIdentical
	}
	mut var_provider := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return // unsupported expression: Expr_BinaryOp_NotIdentical
	}
	var_providers = rt.call_function('array_values', [rt.call_function('array_filter', [var_providers.dup(), rt.new_closure(closure_20_fn)])])
	mut var_response := rt.create_array([rt.ArrayItem{ key: 'providers', val: var_providers }, rt.ArrayItem{ key: 'offline_payment_methods', val: var_offline_payment_providers }, rt.ArrayItem{ key: 'suggestions', val: var_suggestions }, rt.ArrayItem{ key: 'suggestion_categories', val: rt.call_method(this.payments, 'get_payment_extension_suggestion_categories', []rt.PhpVal{}) }])
	return rt.call_function('rest_ensure_response', [this.prepare_payment_providers_response(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_response))])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) set_country(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_location := var_request.get_param(rt.new_string('location'))
	mut var_result := rt.call_method(this.payments, 'set_country', [var_location.dup()])
	return rt.call_function('rest_ensure_response', [rt.create_array([rt.ArrayItem{ key: 'success', val: var_result }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) update_providers_order(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_order_map := var_request.get_param(rt.new_string('order_map'))
	mut var_result := rt.call_method(this.payments, 'update_payment_providers_order_map', [var_order_map.dup()])
	return rt.call_function('rest_ensure_response', [rt.create_array([rt.ArrayItem{ key: 'success', val: var_result }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) attach_payment_extension_suggestion(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_suggestion_id := var_request.get_param(rt.new_string('id'))
	mut var_result := rt.call_method(this.payments, 'attach_payment_extension_suggestion', [var_suggestion_id.dup()])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Exception') {
		mut var_e := var_e_3.dup()
		return create_wp_error(rt.new_string('woocommerce_rest_payment_extension_suggestion_error'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	return rt.call_function('rest_ensure_response', [rt.create_array([rt.ArrayItem{ key: 'success', val: var_result }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) hide_payment_extension_suggestion(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_suggestion_id := var_request.get_param(rt.new_string('id'))
	mut var_result := rt.call_method(this.payments, 'hide_payment_extension_suggestion', [var_suggestion_id.dup()])
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	unsafe { goto end_label_4 }

catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'Exception') {
		mut var_e := var_e_4.dup()
		return create_wp_error(rt.new_string('woocommerce_rest_payment_extension_suggestion_error'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		unsafe { goto end_label_4 }
	}
	else {
		rt.throw_exception(var_e_4)
		unsafe { goto end_label_4 }
	}

end_label_4:
	return rt.call_function('rest_ensure_response', [rt.create_array([rt.ArrayItem{ key: 'success', val: var_result }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) dismiss_payment_extension_suggestion_incentive(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_suggestion_id := var_request.get_param(rt.new_string('suggestion_id'))
	mut var_incentive_id := var_request.get_param(rt.new_string('incentive_id'))
	mut var_context := if !(var_request.get_param(rt.new_string('context'))).is_null() { var_request.get_param(rt.new_string('context')) } else { rt.new_string('all') }
	mut var_do_not_track := if !(var_request.get_param(rt.new_string('do_not_track'))).is_null() { var_request.get_param(rt.new_string('do_not_track')) } else { rt.new_bool(false) }
	mut var_result := rt.call_method(this.payments, 'dismiss_extension_suggestion_incentive', [var_suggestion_id.dup(), var_incentive_id.dup(), var_context.dup(), var_do_not_track.dup()])
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	unsafe { goto end_label_5 }

catch_label_5:
	mut var_e_5 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_5, 'Exception') {
		mut var_e := var_e_5.dup()
		return create_wp_error(rt.new_string('woocommerce_rest_payment_extension_suggestion_incentive_error'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		unsafe { goto end_label_5 }
	}
	else {
		rt.throw_exception(var_e_5)
		unsafe { goto end_label_5 }
	}

end_label_5:
	return rt.call_function('rest_ensure_response', [rt.create_array([rt.ArrayItem{ key: 'success', val: var_result }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) get_extension_suggestions(location string) rt.PhpVal {
	mut location_mutated := location
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_plugins')]))))) {
		return rt.new_array()
	}
	mut var_suggestions := rt.call_method(this.payments, 'get_payment_extension_suggestions', [rt.new_string(location_mutated).dup()])
	return if !(var_suggestions.array_get('other')).is_null() { var_suggestions.array_get('other') } else { rt.new_array() }
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) check_permissions(mut var_request Class_WP_REST_Request) bool {
	mut var_context := rt.new_string(rt.new_string('read'))
	if rt.is_true(rt.identical(rt.new_string('POST'), var_request.get_method())) {
		var_context = rt.new_string(rt.new_string('edit'))
	} else if rt.is_true(rt.identical(rt.new_string('DELETE'), var_request.get_method())) {
		var_context = rt.new_string(rt.new_string('delete'))
	}
	if rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [rt.new_string('payment_gateways'), var_context.dup()])) {
		return true
	}
	mut var_error_information := this.get_authentication_error_by_method(var_request.get_method())
	if rt.is_true(rt.new_bool(var_error_information.dup().is_null())) {
		return false
	}
	return (create_wp_error(var_error_information.array_get('code'), var_error_information.array_get('message'), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) check_location_arg(var_value rt.PhpVal, mut var_request Class_WP_REST_Request) bool {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_string()))))) {
		return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('esc_html__', [rt.new_string('The location argument must be a string.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
	}
	mut var_attributes := var_request.get_attributes()
	mut var_args := var_attributes.array_get('args').array_get('location')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', ['/^' + (var_args.array_get('pattern')).str() + '$/', var_value_mutated.dup()]))))) {
		return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('esc_html__', [rt.new_string('The location argument must be a valid ISO3166 alpha-2 country code.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) check_providers_order_map_arg(var_value rt.PhpVal) bool {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_array()))))) {
		return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('esc_html__', [rt.new_string('The ordering argument must be an object.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
	}
	{
		mut iter_1 := var_value_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_order := item_1.val
			mut var_provider_id := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_provider_id.dup().is_string()))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_order.dup().is_long() || var_order.dup().is_double()))))))) {
				return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('esc_html__', [rt.new_string('The ordering argument must be an object with provider IDs as keys and numeric values as values.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
			}
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('esc_html__', [rt.new_string('The provider ID must be a string with only ASCII letters, digits, underscores, and dashes.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
			}
			if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('filter_var', [var_order.dup(), rt.get_constant('FILTER_VALIDATE_INT')]))) {
				return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('esc_html__', [rt.new_string('The order value must be an integer.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
			}
		}
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) sanitize_providers_order_arg(mut var_value Class_Automattic_WooCommerce_Internal_Admin_Settings_array) rt.PhpVal {
	mut var_value_mutated := var_value
	{
		mut iter_1 := var_value_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_order := item_1.val
			mut var_provider_id := item_1.key
			mut var_id := rt.new_string(this.sanitize_provider_id((var_provider_id).str()))
			var_value_mutated.array_set(var_id, var_order.dup().to_i64())
		}
	}
	return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_value_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) sanitize_provider_id(provider_id string) string {
	mut provider_id_mutated := provider_id
	provider_id_mutated = (rt.call_function('wp_strip_all_tags', [rt.new_string(provider_id_mutated).dup()])).str()
	provider_id_mutated = (rt.call_function('remove_accents', [rt.new_string(provider_id_mutated).dup()])).str()
	provider_id_mutated = (rt.call_function('preg_replace', [rt.new_string('|%([a-fA-F0-9][a-fA-F0-9])|'), rt.new_string(''), rt.new_string(provider_id_mutated).dup()])).str()
	provider_id_mutated = (rt.call_function('preg_replace', [rt.new_string('/&.+?;/'), rt.new_string(''), rt.new_string(provider_id_mutated).dup()])).str()
	provider_id_mutated = (rt.call_function('preg_replace', [rt.new_string('|[^a-z0-9_\\-]|i'), rt.new_string(''), rt.new_string(provider_id_mutated).dup()])).str()
	return provider_id_mutated
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) prepare_payment_providers_response(mut var_response Class_Automattic_WooCommerce_Internal_Admin_Settings_array) rt.PhpVal {
	mut var_response_mutated := var_response
	var_response_mutated = this.prepare_payment_providers_response_recursive(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_response_mutated), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](this.get_schema_for_get_payment_providers()))
	var_response_mutated.array_set('providers', this.add_provider_links(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_response_mutated.array_get('providers'))))
	var_response_mutated.array_set('suggestions', this.add_suggestion_links(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_response_mutated.array_get('suggestions'))))
	return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_response_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) prepare_payment_providers_response_recursive(var_response_item rt.PhpVal, mut var_schema Class_Automattic_WooCommerce_Internal_Admin_Settings_array) rt.PhpVal {
	mut var_item := rt.new_null()
	mut var_schema_mutated := var_schema
	if rt.is_true(rt.new_bool(var_response_item.dup().is_null())) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_schema_mutated.dup().array_isset(rt.new_string('properties'))))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_schema_mutated.array_get('properties').is_array()))))))) {
		if rt.is_true(rt.new_bool(var_response_item.dup().is_array())) {
			return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Utilities_ArrayUtil{}; return temp.filter_null_values_recursive(arg_0) }(var_response_item.dup())
		}
		return var_response_item.dup()
	}
	mut var_prepared_response := rt.new_array()
	{
		mut iter_1 := var_schema_mutated.array_get('properties').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_property_schema := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_response_item.dup().is_array())) && rt.is_true(rt.new_bool(var_response_item.dup().array_isset(var_key.dup()))))) {
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_property_schema.dup().is_array())) && rt.is_true(rt.new_bool(var_property_schema.dup().array_isset(rt.new_string('properties')))))) {
					var_prepared_response.array_set(var_key, this.prepare_payment_providers_response_recursive(var_response_item.array_get(var_key), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_property_schema)))
				} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_property_schema.dup().is_array())) && rt.is_true(rt.new_bool(var_property_schema.dup().array_isset(rt.new_string('items')))))) {
					closure_23_fn := fn [var_property_schema] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_22_fn := fn [var_property_schema] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return 
	}
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return 
	}
					var_prepared_response.array_set(var_key, rt.call_function('array_map', [rt.new_closure(closure_22_fn), .array_get()]))
				} else {
					var_prepared_response.array_set(var_key, .array_get())
				}
			}
		}
	}
	var_prepared_response = rt.call_function('array_merge', [rt.call_function('array_fill_keys', [, ]), var_prepared_response.dup()])
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Utilities_ArrayUtil{}; return temp.filter_null_values_recursive(arg_0) }(var_prepared_response.dup())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) add_provider_links(mut var_providers Class_Automattic_WooCommerce_Internal_Admin_Settings_array) rt.PhpVal {
	mut var_providers_mutated := var_providers
	{
		mut iter_1 := var_providers_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_provider := item_1.val
			mut var_key := item_1.key
			if !rt.is_true() {
			}
			if rt.is_true() {
			}
			if !(!rt.is_true()) && !(!rt.is_true()) {
			}
		}
	}
	return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, )
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) add_suggestion_links(mut var_suggestions Class_Automattic_WooCommerce_Internal_Admin_Settings_array) rt.PhpVal {
	mut var_suggestions_mutated := var_suggestions
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) get_schema_for_get_payment_providers() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) get_schema_for_payment_provider() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) get_schema_for_suggestion() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) get_schema_for_incentive() rt.PhpVal {
}

struct Class_Automattic_WooCommerce_Internal_RestApiControllerBase {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Utilities_ArrayUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_settings_paymentsrestcontroller() &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController{
		PhpObjectBase: rt.PhpObjectBase{}
		route_namespace: rt.new_string('wc-admin')
		rest_base: rt.new_string('settings/payments')
		payments: rt.new_null()
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

fn create_automattic_woocommerce_internal_utilities_arrayutil() &Class_Automattic_WooCommerce_Internal_Utilities_ArrayUtil {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_ArrayUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_rest_api_namespace' {
			return rt.new_string(this.get_rest_api_namespace())
		}
		'register_routes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.register_routes(dispatch_arg_0)
			return rt.new_null()
		}
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments](if args.len > 0 { args[0] } else { rt.new_null() })
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_providers' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_providers(mut dispatch_arg_0)
		}
		'set_country' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.set_country(mut dispatch_arg_0)
		}
		'update_providers_order' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.update_providers_order(mut dispatch_arg_0)
		}
		'attach_payment_extension_suggestion' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.attach_payment_extension_suggestion(mut dispatch_arg_0)
		}
		'hide_payment_extension_suggestion' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.hide_payment_extension_suggestion(mut dispatch_arg_0)
		}
		'dismiss_payment_extension_suggestion_incentive' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.dismiss_payment_extension_suggestion_incentive(mut dispatch_arg_0)
		}
		'get_extension_suggestions' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_extension_suggestions(dispatch_arg_0)
		}
		'check_permissions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.check_permissions(mut dispatch_arg_0))
		}
		'check_location_arg' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(this.check_location_arg(dispatch_arg_0, mut dispatch_arg_1))
		}
		'check_providers_order_map_arg' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_providers_order_map_arg(dispatch_arg_0))
		}
		'sanitize_providers_order_arg' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.sanitize_providers_order_arg(mut dispatch_arg_0)
		}
		'sanitize_provider_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.sanitize_provider_id(dispatch_arg_0))
		}
		'prepare_payment_providers_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.prepare_payment_providers_response(mut dispatch_arg_0)
		}
		'prepare_payment_providers_response_recursive' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.prepare_payment_providers_response_recursive(dispatch_arg_0, mut dispatch_arg_1)
		}
		'add_provider_links' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.add_provider_links(mut dispatch_arg_0)
		}
		'add_suggestion_links' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.add_suggestion_links(mut dispatch_arg_0)
		}
		'get_schema_for_get_payment_providers' {
			return this.get_schema_for_get_payment_providers()
		}
		'get_schema_for_payment_provider' {
			return this.get_schema_for_payment_provider()
		}
		'get_schema_for_suggestion' {
			return this.get_schema_for_suggestion()
		}
		'get_schema_for_incentive' {
			return this.get_schema_for_incentive()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'route_namespace' { return this.route_namespace }
		'rest_base' { return this.rest_base }
		'payments' { return this.payments }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'route_namespace' { this.route_namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		'payments' { this.payments = val; return true }
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


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_ArrayUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_ArrayUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_ArrayUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_settings_paymentsrestcontroller_php() {
	// unsupported statement: Stmt_Declare
}
