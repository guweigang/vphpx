import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController {
	rt.PhpObjectBase
pub mut:
	route_namespace rt.PhpVal = rt.new_string('wc-admin')
	rest_base       rt.PhpVal = rt.new_string('settings/payments')
	payments        rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) get_rest_api_namespace() string {
	return 'wc-admin-settings-payments'
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) register_routes(override bool) {
	mut var_request := rt.new_null()
	mut var_value := rt.new_null()
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('set_country'))
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_request := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return this.check_location_arg(var_value.clone(), mut
			rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace,
		rt.new_string('/' + (this.rest_base).str() + '/country'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Internal_Admin_Settings_WP_REST_Server.editable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_1_fn) },
				rt.ArrayItem{ key: 'validation_callback', val: 'rest_validate_request_arg' },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_2_fn) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'location', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The ISO3166 alpha-2 country code to save for the current user.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' },
						rt.ArrayItem{ key: 'required', val: true },
						rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_3_fn) },
					]) },
				]) },
			]) },
		]),
		rt.new_bool(override)])
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('get_providers'))
	}
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_request := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return this.check_location_arg(var_value.clone(), mut
			rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.get_schema_for_get_payment_providers()
	}
	rt.call_function('register_rest_route', [this.route_namespace,
		rt.new_string('/' + (this.rest_base).str() + '/providers'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Internal_Admin_Settings_WP_REST_Server.creatable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_4_fn) },
				rt.ArrayItem{ key: 'validation_callback', val: 'rest_validate_request_arg' },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_5_fn) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'location', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string("ISO3166 alpha-2 country code. Defaults to WooCommerce's base location country."),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_6_fn) },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.new_closure(closure_7_fn) },
		]),
		rt.new_bool(override)])
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('update_providers_order'))
	}
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_providers_order_map_arg(var_value.clone())
	}
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.sanitize_providers_order_arg(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_value))
	}
	rt.call_function('register_rest_route', [this.route_namespace,
		rt.new_string('/' + (this.rest_base).str() + '/providers/order'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Internal_Admin_Settings_WP_REST_Server.editable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_8_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_9_fn) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'order_map', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('A map of provider ID to integer values representing the sort order.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'object' },
						rt.ArrayItem{ key: 'required', val: true },
						rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_10_fn) },
						rt.ArrayItem{ key: 'sanitize_callback', val: rt.new_closure(closure_11_fn) },
					]) },
				]) },
			]) },
		]),
		rt.new_bool(override)])
	closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('attach_payment_extension_suggestion'))
	}
	closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace,
		rt.new_string('/' + (this.rest_base).str() + '/suggestion/(?P<id>[\\w\\d\\-]+)/attach'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Internal_Admin_Settings_WP_REST_Server.editable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_12_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_13_fn) },
			]) },
		]),
		rt.new_bool(override)])
	closure_14_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('hide_payment_extension_suggestion'))
	}
	closure_15_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace,
		rt.new_string('/' + (this.rest_base).str() + '/suggestion/(?P<id>[\\w\\d\\-]+)/hide'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Internal_Admin_Settings_WP_REST_Server.editable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_14_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_15_fn) },
			]) },
		]),
		rt.new_bool(override)])
	closure_16_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(),
			rt.new_string('dismiss_payment_extension_suggestion_incentive'))
	}
	closure_17_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace,
		rt.new_string('/' +
			(this.rest_base).str() + '/suggestion/(?P<suggestion_id>[\\w\\d\\-]+)/incentive/(?P<incentive_id>[\\w\\d\\-]+)/dismiss'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Internal_Admin_Settings_WP_REST_Server.editable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_16_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_17_fn) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The context ID for which to dismiss the incentive. If not provided, will dismiss the incentive for all contexts.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' },
					]) },
					rt.ArrayItem{ key: 'do_not_track', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('If true, the incentive dismissal will be ignored by tracking.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'boolean' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'default', val: false },
						rt.ArrayItem{ key: 'sanitize_callback', val: 'rest_sanitize_boolean' },
					]) },
				]) },
			]) },
		]),
		rt.new_bool(override)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) init(mut var_payments Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments) {
	this.payments = var_payments
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) get_providers(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_provider := rt.new_null()
	mut var_location := var_request.get_param(rt.new_string('location'))
	if !rt.is_true(var_location) {
		var_location = rt.call_method(this.payments, 'get_country', []rt.PhpVal{})
	}
	mut var_providers := rt.call_method(this.payments, 'get_payment_providers', [
		var_location.clone(),
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
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_payment_providers_error'), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: 500 },
		])))
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
	mut var_suggestions := this.get_extension_suggestions(var_location.str())
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
	if rt.instance_of(var_e_2, 'Exception') {
		var_e = var_e_2.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_payment_providers_error'), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: 500 },
		])))
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
	closure_18_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_provider := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.type_offline_pm(),
			var_provider.array_get(rt.new_string('_type')))
	}
	closure_19_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_provider := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.type_offline_pm(),
			var_provider.array_get(rt.new_string('_type')))
	}
	mut var_offline_payment_providers := rt.call_function('array_values', [
		rt.call_function('array_filter', [var_providers.clone(),
			rt.new_closure(closure_18_fn)]),
	])
	closure_20_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_provider := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.type_offline_pm(),
			var_provider.array_get(rt.new_string('_type')))))
	}
	closure_21_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_provider := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.type_offline_pm(),
			var_provider.array_get(rt.new_string('_type')))))
	}
	var_providers = rt.call_function('array_values', [
		rt.call_function('array_filter', [var_providers.clone(),
			rt.new_closure(closure_20_fn)]),
	])
	mut var_response := rt.create_array([
		rt.ArrayItem{ key: 'providers', val: var_providers },
		rt.ArrayItem{ key: 'offline_payment_methods', val: var_offline_payment_providers },
		rt.ArrayItem{ key: 'suggestions', val: var_suggestions },
		rt.ArrayItem{ key: 'suggestion_categories', val: rt.call_method(this.payments,
			'get_payment_extension_suggestion_categories', []rt.PhpVal{}) },
	])
	return rt.call_function('rest_ensure_response', [
		this.prepare_payment_providers_response(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_response)),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) set_country(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_location := var_request.get_param(rt.new_string('location'))
	mut var_result := rt.call_method(this.payments, 'set_country', [
		var_location.clone()])
	return rt.call_function('rest_ensure_response', [
		rt.create_array([rt.ArrayItem{ key: 'success', val: var_result }]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) update_providers_order(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_order_map := var_request.get_param(rt.new_string('order_map'))
	mut var_result := rt.call_method(this.payments, 'update_payment_providers_order_map', [
		var_order_map.clone(),
	])
	return rt.call_function('rest_ensure_response', [
		rt.create_array([rt.ArrayItem{ key: 'success', val: var_result }]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) attach_payment_extension_suggestion(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_suggestion_id := var_request.get_param(rt.new_string('id'))
	mut var_result := rt.call_method(this.payments, 'attach_payment_extension_suggestion', [
		var_suggestion_id.clone(),
	])
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
	if rt.instance_of(var_e_3, 'Exception') {
		mut var_e := var_e_3.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_payment_extension_suggestion_error'), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: 400 },
		])))
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
	return rt.call_function('rest_ensure_response', [
		rt.create_array([rt.ArrayItem{ key: 'success', val: var_result }]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) hide_payment_extension_suggestion(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_suggestion_id := var_request.get_param(rt.new_string('id'))
	mut var_result := rt.call_method(this.payments, 'hide_payment_extension_suggestion', [
		var_suggestion_id.clone(),
	])
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
	if rt.instance_of(var_e_4, 'Exception') {
		mut var_e := var_e_4.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_payment_extension_suggestion_error'), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: 400 },
		])))
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
	return rt.call_function('rest_ensure_response', [
		rt.create_array([rt.ArrayItem{ key: 'success', val: var_result }]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) dismiss_payment_extension_suggestion_incentive(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_suggestion_id := var_request.get_param(rt.new_string('suggestion_id'))
	mut var_incentive_id := var_request.get_param(rt.new_string('incentive_id'))
	mut var_context := if !(var_request.get_param(rt.new_string('context'))).is_null() {
		var_request.get_param(rt.new_string('context'))
	} else {
		rt.new_string('all')
	}
	mut var_do_not_track := if !(var_request.get_param(rt.new_string('do_not_track'))).is_null() {
		var_request.get_param(rt.new_string('do_not_track'))
	} else {
		rt.new_bool(false)
	}
	mut var_result := rt.call_method(this.payments, 'dismiss_extension_suggestion_incentive', [
		var_suggestion_id.clone(),
		var_incentive_id.clone(),
		var_context.clone(),
		var_do_not_track.clone(),
	])
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
	if rt.instance_of(var_e_5, 'Exception') {
		mut var_e := var_e_5.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_payment_extension_suggestion_incentive_error'), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: 400 },
		])))
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
	return rt.call_function('rest_ensure_response', [
		rt.create_array([rt.ArrayItem{ key: 'success', val: var_result }]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) get_extension_suggestions(location string) rt.PhpVal {
	mut location_mutated := location
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('install_plugins'),
	])))))
	{
		return rt.new_array()
	}
	mut var_suggestions := rt.call_method(this.payments, 'get_payment_extension_suggestions', [
		rt.new_string(location_mutated).clone(),
	])
	return if !(var_suggestions.array_get(rt.new_string('other'))).is_null() {
		var_suggestions.array_get(rt.new_string('other'))
	} else {
		rt.new_array()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) check_permissions(mut var_request Class_WP_REST_Request) bool {
	mut var_context := rt.new_string('read')
	if rt.is_true(rt.identical(rt.new_string('POST'), var_request.get_method())) {
		var_context = rt.new_string('edit')
	} else if rt.is_true(rt.identical(rt.new_string('DELETE'), var_request.get_method())) {
		var_context = rt.new_string('delete')
	}
	if rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [
		rt.new_string('payment_gateways'),
		var_context.clone(),
	]))
	{
		return true
	}
	mut var_error_information := this.get_authentication_error_by_method(var_request.get_method())
	if rt.is_true(rt.new_bool(var_error_information.clone().is_null())) {
		return false
	}
	return (create_wp_error(var_error_information.array_get(rt.new_string('code')),
		var_error_information.array_get(rt.new_string('message')), rt.create_array([
		rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
			[]rt.PhpVal{}) },
	]))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) check_location_arg(var_value rt.PhpVal, mut var_request Class_WP_REST_Request) bool {
	mut var_value_mutated := var_value
	if !(var_value_mutated.clone().is_string()) {
		return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('esc_html__', [
			rt.new_string('The location argument must be a string.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
	}
	mut var_attributes := var_request.get_attributes()
	mut var_args :=
		var_attributes.array_get(rt.new_string('args')).array_get(rt.new_string('location'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
		rt.new_string('/^' + (var_args.array_get(rt.new_string('pattern'))).str() + '$/'),
		var_value_mutated.clone(),
	])))))
	{
		return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('esc_html__', [
			rt.new_string('The location argument must be a valid ISO3166 alpha-2 country code.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) check_providers_order_map_arg(var_value rt.PhpVal) bool {
	mut var_value_mutated := var_value
	if !(var_value_mutated.clone().is_array()) {
		return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('esc_html__', [
			rt.new_string('The ordering argument must be an object.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
	}
	mut iter_1 := var_value_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_order := item_1.val
		mut var_provider_id := item_1.key
		if !(var_provider_id.clone().is_string()) || !(var_order.clone().is_long()
			|| var_order.clone().is_double()) {
			return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('esc_html__', [
				rt.new_string('The ordering argument must be an object with provider IDs as keys and numeric values as values.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.sanitize_provider_id(var_provider_id.str()),
			var_provider_id))))
		{
			return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('esc_html__', [
				rt.new_string('The provider ID must be a string with only ASCII letters, digits, underscores, and dashes.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
		}
		if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('filter_var', [
			var_order.clone(),
			rt.get_constant('FILTER_VALIDATE_INT'),
		])))
		{
			return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('esc_html__', [
				rt.new_string('The order value must be an integer.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
		}
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) sanitize_providers_order_arg(mut var_value Class_Automattic_WooCommerce_Internal_Admin_Settings_array) rt.PhpVal {
	mut var_value_mutated := var_value
	mut iter_2 := var_value_mutated.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_order := item_2.val
		mut var_provider_id := item_2.key
		mut var_id := rt.new_string(this.sanitize_provider_id(var_provider_id.str()))
		var_value_mutated.array_set(var_id, var_order.clone().to_i64())
	}
	return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{},
		var_value_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) sanitize_provider_id(provider_id string) string {
	mut provider_id_mutated := provider_id
	provider_id_mutated = (rt.call_function('wp_strip_all_tags', [
		rt.new_string(provider_id_mutated).clone()])).str()
	provider_id_mutated = (rt.call_function('remove_accents', [
		rt.new_string(provider_id_mutated).clone()])).str()
	provider_id_mutated = (rt.call_function('preg_replace', [
		rt.new_string('|%([a-fA-F0-9][a-fA-F0-9])|'),
		rt.new_string(''),
		rt.new_string(provider_id_mutated).clone(),
	])).str()
	provider_id_mutated = (rt.call_function('preg_replace', [
		rt.new_string('/&.+?;/'), rt.new_string(''), rt.new_string(provider_id_mutated).clone()])).str()
	provider_id_mutated = (rt.call_function('preg_replace', [
		rt.new_string('|[^a-z0-9_\\-]|i'),
		rt.new_string(''),
		rt.new_string(provider_id_mutated).clone(),
	])).str()
	return provider_id_mutated
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) prepare_payment_providers_response(mut var_response Class_Automattic_WooCommerce_Internal_Admin_Settings_array) rt.PhpVal {
	mut var_response_mutated := var_response
	var_response_mutated = this.prepare_payment_providers_response_recursive(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array',
		[]string{}, var_response_mutated), mut
		rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](this.get_schema_for_get_payment_providers()))
	var_response_mutated.array_set('providers',
		this.add_provider_links(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_response_mutated.array_get(rt.new_string('providers')))))
	var_response_mutated.array_set('suggestions',
		this.add_suggestion_links(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_response_mutated.array_get(rt.new_string('suggestions')))))
	return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{},
		var_response_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) prepare_payment_providers_response_recursive(var_response_item rt.PhpVal, mut var_schema Class_Automattic_WooCommerce_Internal_Admin_Settings_array) rt.PhpVal {
	mut var_item := rt.new_null()
	mut var_schema_mutated := var_schema
	if rt.is_true(rt.new_bool(var_response_item.clone().is_null())) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_schema_mutated.array_isset(rt.new_string('properties')))))))
		|| !(var_schema_mutated.array_get(rt.new_string('properties')).is_array()) {
		if rt.is_true(rt.new_bool(var_response_item.clone().is_array())) {
			mut iife_temp_21 := Class_Automattic_WooCommerce_Internal_Utilities_ArrayUtil{}
			mut iife_result_21 :=
				iife_temp_21.filter_null_values_recursive(var_response_item.clone())
			return iife_result_21
		}
		return var_response_item.clone()
	}
	mut var_prepared_response := rt.new_array()
	mut iter_3 := var_schema_mutated.array_get(rt.new_string('properties')).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_property_schema := item_3.val
		mut var_key := item_3.key
		if var_response_item.clone().is_array()
			&& rt.is_true(rt.new_bool(var_response_item.clone().array_isset(var_key.clone()))) {
			if var_property_schema.clone().is_array()
				&& rt.is_true(rt.new_bool(var_property_schema.clone().array_isset(rt.new_string('properties')))) {
				var_prepared_response.array_set(var_key, this.prepare_payment_providers_response_recursive(var_response_item.array_get(var_key), mut
					rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_property_schema)))
			} else if var_property_schema.clone().is_array()
				&& rt.is_true(rt.new_bool(var_property_schema.clone().array_isset(rt.new_string('items')))) {
				closure_23_fn := fn [var_property_schema] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
					mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
					return this.prepare_payment_providers_response_recursive(var_item.clone(), mut
						rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_property_schema.array_get(rt.new_string('items'))))
				}
				closure_24_fn := fn [var_property_schema] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
					mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
					return this.prepare_payment_providers_response_recursive(var_item.clone(), mut
						rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_property_schema.array_get(rt.new_string('items'))))
				}
				var_prepared_response.array_set(var_key, rt.call_function('array_map', [
					rt.new_closure(closure_23_fn),
					var_response_item.array_get(var_key),
				]))
			} else {
				var_prepared_response.array_set(var_key, var_response_item.array_get(var_key))
			}
		}
	}
	var_prepared_response = rt.call_function('array_merge', [
		rt.call_function('array_fill_keys', [
			rt.func_array_keys(var_schema_mutated.array_get(rt.new_string('properties'))),
			rt.new_null(),
		]),
		var_prepared_response.clone(),
	])
	mut iife_temp_24 := Class_Automattic_WooCommerce_Internal_Utilities_ArrayUtil{}
	mut iife_result_24 := iife_temp_24.filter_null_values_recursive(var_prepared_response.clone())
	return iife_result_24
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) add_provider_links(mut var_providers Class_Automattic_WooCommerce_Internal_Admin_Settings_array) rt.PhpVal {
	mut var_providers_mutated := var_providers
	mut iter_4 := var_providers_mutated.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_provider := item_4.val
		mut var_key := item_4.key
		if !rt.is_true(var_provider.array_get(rt.new_string('_links'))) {
			var_providers_mutated.array_get_mut(var_key).array_set('_links', rt.new_array())
		}
		if !(!rt.is_true(var_provider.array_get(rt.new_string('_type'))))
			&& rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.type_suggestion(), var_provider.array_get(rt.new_string('_type'))))
			&& !(!rt.is_true(var_provider.array_get(rt.new_string('_suggestion_id')))) {
			var_providers_mutated.array_get_mut(var_key).array_get_mut('_links').array_set('attach', rt.create_array([
				rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
					rt.call_function('sprintf', [
						rt.new_string('/%s/%s/suggestion/%s/attach'),
						this.route_namespace,
						this.rest_base,
						var_provider.array_get(rt.new_string('_suggestion_id')),
					]),
				]) },
			]))
			var_providers_mutated.array_get_mut(var_key).array_get_mut('_links').array_set('hide', rt.create_array([
				rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
					rt.call_function('sprintf', [
						rt.new_string('/%s/%s/suggestion/%s/hide'),
						this.route_namespace,
						this.rest_base,
						var_provider.array_get(rt.new_string('_suggestion_id')),
					]),
				]) },
			]))
		}
		if !(!rt.is_true(var_provider.array_get(rt.new_string('_incentive'))))
			&& !(!rt.is_true(var_provider.array_get(rt.new_string('_suggestion_id')))) {
			if !rt.is_true(var_provider.array_get(rt.new_string('_incentive')).array_get(rt.new_string('_links'))) {
				var_providers_mutated.array_get_mut(var_key).array_get_mut('_incentive').array_set('_links',
					rt.new_array())
			}
			var_providers_mutated.array_get_mut(var_key).array_get_mut('_incentive').array_get_mut('_links').array_set('dismiss', rt.create_array([
				rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
					rt.call_function('sprintf', [
						rt.new_string('/%s/%s/suggestion/%s/incentive/%s/dismiss'),
						this.route_namespace,
						this.rest_base,
						var_provider.array_get(rt.new_string('_suggestion_id')),
						var_provider.array_get(rt.new_string('_incentive')).array_get(rt.new_string('id')),
					]),
				]) },
			]))
		}
	}
	return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{},
		var_providers_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) add_suggestion_links(mut var_suggestions Class_Automattic_WooCommerce_Internal_Admin_Settings_array) rt.PhpVal {
	mut var_suggestions_mutated := var_suggestions
	mut iter_5 := var_suggestions_mutated.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_suggestion := item_5.val
		mut var_key := item_5.key
		if !rt.is_true(var_suggestion.array_get(rt.new_string('id'))) {
			continue
		}
		if !rt.is_true(var_suggestion.array_get(rt.new_string('_links'))) {
			var_suggestions_mutated.array_get_mut(var_key).array_set('_links', rt.new_array())
		}
		var_suggestions_mutated.array_get_mut(var_key).array_get_mut('_links').array_set('attach', rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_function('sprintf', [
					rt.new_string('/%s/%s/suggestion/%s/attach'),
					this.route_namespace,
					this.rest_base,
					var_suggestion.array_get(rt.new_string('id')),
				]),
			]) },
		]))
		var_suggestions_mutated.array_get_mut(var_key).array_get_mut('_links').array_set('hide', rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('/%s/%s/suggestion/%s/hide'),
					this.route_namespace, this.rest_base, var_suggestion.array_get(rt.new_string('id'))]),
			]) },
		]))
	}
	return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{},
		var_suggestions_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) get_schema_for_get_payment_providers() rt.PhpVal {
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{
			key: 'title'
			val: 'WooCommerce Settings Payments providers for the given location.'
		},
		rt.ArrayItem{ key: 'type', val: 'object' },
	])
	var_schema.array_set('properties', rt.create_array([
		rt.ArrayItem{ key: 'providers', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
				rt.new_string('The ordered providers list. This includes registered payment gateways, suggestions, and offline payment methods group entry. The individual offline payment methods are separate.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'items', val: this.get_schema_for_payment_provider() },
		]) },
		rt.ArrayItem{ key: 'offline_payment_methods', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
				rt.new_string('The ordered offline payment methods providers list.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'items', val: this.get_schema_for_payment_provider() },
		]) },
		rt.ArrayItem{ key: 'suggestions', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
				rt.new_string('The list of suggestions, excluding the ones part of the providers list.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'items', val: this.get_schema_for_suggestion() },
		]) },
		rt.ArrayItem{ key: 'suggestion_categories', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
				rt.new_string('The suggestion categories.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('A suggestion category.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The unique identifier for the category.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: '_priority', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'integer' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The priority of the category.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'title', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The title of the category.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'description', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The description of the category.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
				]) },
			]) },
		]) },
	]))
	return var_schema.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) get_schema_for_payment_provider() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
			rt.new_string('A payment provider in the context of the main Payments Settings page list.'),
			rt.new_string('woocommerce'),
		]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('The unique identifier for the provider.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: '_order', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('The sort order of the provider.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: '_type', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('The type of payment provider. Use this to differentiate between the various items in the list and determine their intended use.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'title', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('The title of the provider.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'description', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('The description of the provider.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('Supported features for this provider.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'plugin', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('The corresponding plugin details of the provider.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: '_type', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'enum', val: rt.create_array([
							rt.ArrayItem{
								key: none
								val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_type_wporg()
							},
							rt.ArrayItem{
								key: none
								val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_type_mu_plugin()
							},
							rt.ArrayItem{
								key: none
								val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_type_theme()
							},
							rt.ArrayItem{
								key: none
								val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_type_unknown()
							},
						]) },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The type of the containing entity. Generally this is a regular plugin but it can also be a non-standard entity like a theme or a must-user plugin.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'slug', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The slug of the containing entity.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'file', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The plugin main file. This is a relative path to the plugins directory.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'status', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'enum', val: rt.create_array([
							rt.ArrayItem{
								key: none
								val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_not_installed()
							},
							rt.ArrayItem{
								key: none
								val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_installed()
							},
							rt.ArrayItem{
								key: none
								val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_active()
							},
						]) },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The status of the containing entity.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'image', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('The URL of the provider image.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'icon', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('The URL of the provider icon (square aspect ratio - 72px by 72px).'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'links', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('Links for the provider.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'properties', val: rt.create_array([
						rt.ArrayItem{ key: '_type', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
								rt.new_string('The type of the link.'),
								rt.new_string('woocommerce'),
							]) },
							rt.ArrayItem{ key: 'context', val: rt.create_array([
								rt.ArrayItem{ key: none, val: 'view' },
								rt.ArrayItem{ key: none, val: 'edit' },
							]) },
							rt.ArrayItem{ key: 'readonly', val: true },
						]) },
						rt.ArrayItem{ key: 'url', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
								rt.new_string('The URL of the link.'),
								rt.new_string('woocommerce'),
							]) },
							rt.ArrayItem{ key: 'context', val: rt.create_array([
								rt.ArrayItem{ key: none, val: 'view' },
								rt.ArrayItem{ key: none, val: 'edit' },
							]) },
							rt.ArrayItem{ key: 'readonly', val: true },
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'state', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string("The general state of the provider with regards to it's payments processing."),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'enabled', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'boolean' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('Whether the provider is enabled for use on checkout.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'account_connected', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'boolean' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('Whether the provider has a payments processing account connected.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'needs_setup', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'boolean' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('Whether the provider needs setup.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'test_mode', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'boolean' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('Whether the provider is in test mode for payments processing.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'dev_mode', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'boolean' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('Whether the provider is in dev mode. Having this true usually leads to forcing test payments. '),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'management', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('The management details of the provider.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: '_links', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'object' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
						rt.ArrayItem{ key: 'properties', val: rt.create_array([
							rt.ArrayItem{ key: 'settings', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'object' },
								rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
									rt.new_string('The link to the settings page for the payment gateway.'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
								rt.ArrayItem{ key: 'readonly', val: true },
								rt.ArrayItem{ key: 'properties', val: rt.create_array([
									rt.ArrayItem{ key: 'href', val: rt.create_array([
										rt.ArrayItem{ key: 'type', val: 'string' },
										rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
											rt.new_string('The URL to the settings page for the payment gateway.'),
											rt.new_string('woocommerce'),
										]) },
										rt.ArrayItem{ key: 'context', val: rt.create_array([
											rt.ArrayItem{ key: none, val: 'view' },
											rt.ArrayItem{ key: none, val: 'edit' },
										]) },
										rt.ArrayItem{ key: 'readonly', val: true },
									]) },
								]) },
							]) },
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'onboarding', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('Onboarding-related details for the provider.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The type of onboarding process the provider supports.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'object' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The state of the onboarding process.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
					]) },
					rt.ArrayItem{ key: 'messages', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'object' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('Various messages to possibly show the user.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
						rt.ArrayItem{ key: 'additionalProperties', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
								rt.new_string('Message to show the user.'),
								rt.new_string('woocommerce'),
							]) },
							rt.ArrayItem{ key: 'readonly', val: true },
						]) },
					]) },
					rt.ArrayItem{ key: 'steps', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'array' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The onboarding steps in case this provider supports native in-context onboarding.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: '_links', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'object' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
						rt.ArrayItem{ key: 'properties', val: rt.create_array([
							rt.ArrayItem{ key: 'preload', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'object' },
								rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
									rt.new_string('The onboarding preload link for the payment gateway.'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
								rt.ArrayItem{ key: 'readonly', val: true },
								rt.ArrayItem{ key: 'properties', val: rt.create_array([
									rt.ArrayItem{ key: 'href', val: rt.create_array([
										rt.ArrayItem{ key: 'type', val: 'string' },
										rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
											rt.new_string('The URL to do onboarding preload for the payment gateway.'),
											rt.new_string('woocommerce'),
										]) },
										rt.ArrayItem{ key: 'context', val: rt.create_array([
											rt.ArrayItem{ key: none, val: 'view' },
											rt.ArrayItem{ key: none, val: 'edit' },
										]) },
										rt.ArrayItem{ key: 'readonly', val: true },
									]) },
								]) },
							]) },
							rt.ArrayItem{ key: 'onboard', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'object' },
								rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
									rt.new_string('The start/continue onboarding link for the payment gateway.'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
								rt.ArrayItem{ key: 'readonly', val: true },
								rt.ArrayItem{ key: 'properties', val: rt.create_array([
									rt.ArrayItem{ key: 'href', val: rt.create_array([
										rt.ArrayItem{ key: 'type', val: 'string' },
										rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
											rt.new_string('The URL to start/continue onboarding for the payment gateway.'),
											rt.new_string('woocommerce'),
										]) },
										rt.ArrayItem{ key: 'context', val: rt.create_array([
											rt.ArrayItem{ key: none, val: 'view' },
											rt.ArrayItem{ key: none, val: 'edit' },
										]) },
										rt.ArrayItem{ key: 'readonly', val: true },
									]) },
								]) },
							]) },
							rt.ArrayItem{ key: 'disable_test_account', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'object' },
								rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
									rt.new_string('The link to disable the test account for the payment gateway.'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
								rt.ArrayItem{ key: 'readonly', val: true },
								rt.ArrayItem{ key: 'properties', val: rt.create_array([
									rt.ArrayItem{ key: 'href', val: rt.create_array([
										rt.ArrayItem{ key: 'type', val: 'string' },
										rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
											rt.new_string('The URL to POST to disable the test account for the payment gateway.'),
											rt.new_string('woocommerce'),
										]) },
										rt.ArrayItem{ key: 'context', val: rt.create_array([
											rt.ArrayItem{ key: none, val: 'view' },
											rt.ArrayItem{ key: none, val: 'edit' },
										]) },
										rt.ArrayItem{ key: 'readonly', val: true },
									]) },
								]) },
							]) },
							rt.ArrayItem{ key: 'reset', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'object' },
								rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
									rt.new_string('The link to reset the provider state/account and restart the onboarding.'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
								rt.ArrayItem{ key: 'readonly', val: true },
								rt.ArrayItem{ key: 'properties', val: rt.create_array([
									rt.ArrayItem{ key: 'href', val: rt.create_array([
										rt.ArrayItem{ key: 'type', val: 'string' },
										rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
											rt.new_string('The URL to POST to for resetting the provider onboarding.'),
											rt.new_string('woocommerce'),
										]) },
										rt.ArrayItem{ key: 'context', val: rt.create_array([
											rt.ArrayItem{ key: none, val: 'view' },
											rt.ArrayItem{ key: none, val: 'edit' },
										]) },
										rt.ArrayItem{ key: 'readonly', val: true },
									]) },
								]) },
							]) },
						]) },
					]) },
					rt.ArrayItem{ key: 'recommended_payment_methods', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'array' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The list of recommended payment methods details for the payment gateway.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
						rt.ArrayItem{ key: 'items', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'object' },
							rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
								rt.new_string('The details for a recommended payment method.'),
								rt.new_string('woocommerce'),
							]) },
							rt.ArrayItem{ key: 'context', val: rt.create_array([
								rt.ArrayItem{ key: none, val: 'view' },
								rt.ArrayItem{ key: none, val: 'edit' },
							]) },
							rt.ArrayItem{ key: 'readonly', val: true },
							rt.ArrayItem{ key: 'properties', val: rt.create_array([
								rt.ArrayItem{ key: 'id', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'string' },
									rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
										rt.new_string('The unique identifier for the payment method.'),
										rt.new_string('woocommerce'),
									]) },
									rt.ArrayItem{ key: 'context', val: rt.create_array([
										rt.ArrayItem{ key: none, val: 'view' },
										rt.ArrayItem{ key: none, val: 'edit' },
									]) },
									rt.ArrayItem{ key: 'readonly', val: true },
								]) },
								rt.ArrayItem{ key: '_order', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'integer' },
									rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
										rt.new_string('The sort order of the payment method.'),
										rt.new_string('woocommerce'),
									]) },
									rt.ArrayItem{ key: 'context', val: rt.create_array([
										rt.ArrayItem{ key: none, val: 'view' },
										rt.ArrayItem{ key: none, val: 'edit' },
									]) },
									rt.ArrayItem{ key: 'readonly', val: true },
								]) },
								rt.ArrayItem{ key: 'enabled', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'boolean' },
									rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
										rt.new_string('Whether the payment method should be recommended as enabled or not.'),
										rt.new_string('woocommerce'),
									]) },
									rt.ArrayItem{ key: 'context', val: rt.create_array([
										rt.ArrayItem{ key: none, val: 'view' },
										rt.ArrayItem{ key: none, val: 'edit' },
									]) },
									rt.ArrayItem{ key: 'readonly', val: true },
								]) },
								rt.ArrayItem{ key: 'required', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'boolean' },
									rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
										rt.new_string('Whether the payment method should be required (and force-enabled) or not.'),
										rt.new_string('woocommerce'),
									]) },
									rt.ArrayItem{ key: 'context', val: rt.create_array([
										rt.ArrayItem{ key: none, val: 'view' },
										rt.ArrayItem{ key: none, val: 'edit' },
									]) },
									rt.ArrayItem{ key: 'readonly', val: true },
								]) },
								rt.ArrayItem{ key: 'title', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'string' },
									rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
										rt.new_string('The title of the payment method. Does not include HTML tags.'),
										rt.new_string('woocommerce'),
									]) },
									rt.ArrayItem{ key: 'context', val: rt.create_array([
										rt.ArrayItem{ key: none, val: 'view' },
										rt.ArrayItem{ key: none, val: 'edit' },
									]) },
									rt.ArrayItem{ key: 'readonly', val: true },
								]) },
								rt.ArrayItem{ key: 'description', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'string' },
									rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
										rt.new_string('The description of the payment method. It can contain basic HTML.'),
										rt.new_string('woocommerce'),
									]) },
									rt.ArrayItem{ key: 'context', val: rt.create_array([
										rt.ArrayItem{ key: none, val: 'view' },
										rt.ArrayItem{ key: none, val: 'edit' },
									]) },
									rt.ArrayItem{ key: 'readonly', val: true },
								]) },
								rt.ArrayItem{ key: 'icon', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'string' },
									rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
										rt.new_string('The URL of the payment method icon or a base64-encoded SVG image.'),
										rt.new_string('woocommerce'),
									]) },
									rt.ArrayItem{ key: 'context', val: rt.create_array([
										rt.ArrayItem{ key: none, val: 'view' },
										rt.ArrayItem{ key: none, val: 'edit' },
									]) },
									rt.ArrayItem{ key: 'readonly', val: true },
								]) },
								rt.ArrayItem{ key: 'notice', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'object' },
									rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
										rt.new_string('An optional notice to display for this payment method (e.g., verification requirements).'),
										rt.new_string('woocommerce'),
									]) },
									rt.ArrayItem{ key: 'context', val: rt.create_array([
										rt.ArrayItem{ key: none, val: 'view' },
										rt.ArrayItem{ key: none, val: 'edit' },
									]) },
									rt.ArrayItem{ key: 'readonly', val: true },
									rt.ArrayItem{ key: 'properties', val: rt.create_array([
										rt.ArrayItem{ key: 'badge', val: rt.create_array([
											rt.ArrayItem{ key: 'type', val: 'string' },
											rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
												rt.new_string('Short text for a badge/chip displayed next to the payment method title.'),
												rt.new_string('woocommerce'),
											]) },
											rt.ArrayItem{ key: 'context', val: rt.create_array([
												rt.ArrayItem{ key: none, val: 'view' },
												rt.ArrayItem{ key: none, val: 'edit' },
											]) },
											rt.ArrayItem{ key: 'readonly', val: true },
										]) },
										rt.ArrayItem{ key: 'message', val: rt.create_array([
											rt.ArrayItem{ key: 'type', val: 'string' },
											rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
												rt.new_string('Warning message displayed when the payment method is enabled. Plain text only.'),
												rt.new_string('woocommerce'),
											]) },
											rt.ArrayItem{ key: 'context', val: rt.create_array([
												rt.ArrayItem{ key: none, val: 'view' },
												rt.ArrayItem{ key: none, val: 'edit' },
											]) },
											rt.ArrayItem{ key: 'readonly', val: true },
										]) },
										rt.ArrayItem{ key: 'link_text', val: rt.create_array([
											rt.ArrayItem{ key: 'type', val: 'string' },
											rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
												rt.new_string('Text for the call-to-action link in the notice.'),
												rt.new_string('woocommerce'),
											]) },
											rt.ArrayItem{ key: 'context', val: rt.create_array([
												rt.ArrayItem{ key: none, val: 'view' },
												rt.ArrayItem{ key: none, val: 'edit' },
											]) },
											rt.ArrayItem{ key: 'readonly', val: true },
										]) },
										rt.ArrayItem{ key: 'link_url', val: rt.create_array([
											rt.ArrayItem{ key: 'type', val: 'string' },
											rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
												rt.new_string('URL for the call-to-action link in the notice.'),
												rt.new_string('woocommerce'),
											]) },
											rt.ArrayItem{ key: 'context', val: rt.create_array([
												rt.ArrayItem{ key: none, val: 'view' },
												rt.ArrayItem{ key: none, val: 'edit' },
											]) },
											rt.ArrayItem{ key: 'readonly', val: true },
										]) },
									]) },
								]) },
							]) },
						]) },
					]) },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'object' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('Various contextual data for the onboarding process to use.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'tags', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('The tags associated with the provider.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'uniqueItems', val: true },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
						rt.new_string('Tag associated with the provider.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'readonly', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: '_suggestion_id', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('The suggestion ID matching this provider.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: '_incentive', val: this.get_schema_for_incentive() },
			rt.ArrayItem{ key: '_links', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'attach', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'object' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The link to mark the suggestion as attached. This should be called when an extension is installed.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
						rt.ArrayItem{ key: 'properties', val: rt.create_array([
							rt.ArrayItem{ key: 'href', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'string' },
								rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
									rt.new_string('The URL to attach the suggestion.'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
								rt.ArrayItem{ key: 'readonly', val: true },
							]) },
						]) },
					]) },
					rt.ArrayItem{ key: 'hide', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'object' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The link to hide the suggestion.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
						rt.ArrayItem{ key: 'properties', val: rt.create_array([
							rt.ArrayItem{ key: 'href', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'string' },
								rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
									rt.new_string('The URL to hide the suggestion.'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
								rt.ArrayItem{ key: 'readonly', val: true },
							]) },
						]) },
					]) },
				]) },
			]) },
		]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) get_schema_for_suggestion() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
			rt.new_string('A suggestion with full details.'),
			rt.new_string('woocommerce'),
		]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
		]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('The unique identifier for the suggestion.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: '_priority', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('The priority of the suggestion.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: '_type', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('The type of the suggestion.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'title', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('The title of the suggestion.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'description', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('The description of the suggestion.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'plugin', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: '_type', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'enum', val: rt.create_array([
							rt.ArrayItem{
								key: none
								val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_type_wporg()
							},
						]) },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The type of the plugin.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'slug', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The slug of the plugin.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'status', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'enum', val: rt.create_array([
							rt.ArrayItem{
								key: none
								val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_not_installed()
							},
							rt.ArrayItem{
								key: none
								val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_installed()
							},
							rt.ArrayItem{
								key: none
								val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_active()
							},
						]) },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The status of the plugin.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'image', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('The URL of the image.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'icon', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('The URL of the icon (square aspect ratio).'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'links', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'properties', val: rt.create_array([
						rt.ArrayItem{ key: '_type', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
								rt.new_string('The type of the link.'),
								rt.new_string('woocommerce'),
							]) },
							rt.ArrayItem{ key: 'context', val: rt.create_array([
								rt.ArrayItem{ key: none, val: 'view' },
								rt.ArrayItem{ key: none, val: 'edit' },
							]) },
							rt.ArrayItem{ key: 'readonly', val: true },
						]) },
						rt.ArrayItem{ key: 'url', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
								rt.new_string('The URL of the link.'),
								rt.new_string('woocommerce'),
							]) },
							rt.ArrayItem{ key: 'context', val: rt.create_array([
								rt.ArrayItem{ key: none, val: 'view' },
								rt.ArrayItem{ key: none, val: 'edit' },
							]) },
							rt.ArrayItem{ key: 'readonly', val: true },
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: '_incentive', val: this.get_schema_for_incentive() },
			rt.ArrayItem{ key: 'tags', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('The tags associated with the suggestion.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'uniqueItems', val: true },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
						rt.new_string('The tags associated with the suggestion.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'readonly', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'category', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('The category of the suggestion.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: '_links', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'attach', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'object' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The link to mark the suggestion as attached. This should be called when an extension is installed.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
						rt.ArrayItem{ key: 'properties', val: rt.create_array([
							rt.ArrayItem{ key: 'href', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'string' },
								rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
									rt.new_string('The URL to attach the suggestion.'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
								rt.ArrayItem{ key: 'readonly', val: true },
							]) },
						]) },
					]) },
					rt.ArrayItem{ key: 'hide', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'object' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The link to hide the suggestion.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
						rt.ArrayItem{ key: 'properties', val: rt.create_array([
							rt.ArrayItem{ key: 'href', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'string' },
								rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
									rt.new_string('The URL to hide the suggestion.'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
								rt.ArrayItem{ key: 'readonly', val: true },
							]) },
						]) },
					]) },
				]) },
			]) },
		]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController) get_schema_for_incentive() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
			rt.new_string('The active incentive for the provider.'),
			rt.new_string('woocommerce'),
		]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
		]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('The incentive unique ID. This ID needs to be used for incentive dismissals.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'promo_id', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('The incentive promo ID. This ID need to be fed into the onboarding flow.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'title', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('The incentive title. It can contain stylistic HTML.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'description', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('The incentive description. It can contain stylistic HTML.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'short_description', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('The short description of the incentive. It can contain stylistic HTML.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'cta_label', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('The call to action label for the incentive.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'tc_url', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('The URL to the terms and conditions for the incentive.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'badge', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('The badge label for the incentive.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: '_dismissals', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
					rt.new_string('The dismissals list for the incentive. Each dismissal entry includes a context and a timestamp. The `all` entry means the incentive was dismissed for all contexts.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'uniqueItems', val: true },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'properties', val: rt.create_array([
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
								rt.new_string('Context ID in which the incentive was dismissed.'),
								rt.new_string('woocommerce'),
							]) },
							rt.ArrayItem{ key: 'readonly', val: true },
						]) },
						rt.ArrayItem{ key: 'timestamp', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'integer' },
							rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
								rt.new_string('Unix timestamp representing when the incentive was dismissed.'),
								rt.new_string('woocommerce'),
							]) },
							rt.ArrayItem{ key: 'readonly', val: true },
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: '_links', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'dismiss', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'object' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The link to dismiss the incentive.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
						rt.ArrayItem{ key: 'properties', val: rt.create_array([
							rt.ArrayItem{ key: 'href', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'string' },
								rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
									rt.new_string('The URL to dismiss the incentive.'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
								rt.ArrayItem{ key: 'readonly', val: true },
							]) },
						]) },
					]) },
					rt.ArrayItem{ key: 'onboard', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'object' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The start/continue onboarding link for the payment gateway.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
						rt.ArrayItem{ key: 'properties', val: rt.create_array([
							rt.ArrayItem{ key: 'href', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'string' },
								rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
									rt.new_string('The URL to start/continue onboarding for the payment gateway.'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
								rt.ArrayItem{ key: 'readonly', val: true },
							]) },
						]) },
					]) },
				]) },
			]) },
		]) }])
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

fn create_automattic_woocommerce_internal_admin_settings_paymentsrestcontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController{
		PhpObjectBase:   rt.PhpObjectBase{}
		route_namespace: rt.new_string('wc-admin')
		rest_base:       rt.new_string('settings/payments')
		payments:        rt.new_null()
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

fn create_automattic_woocommerce_internal_utilities_arrayutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Utilities_ArrayUtil {
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_providers' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_providers(mut dispatch_arg_0)
		}
		'set_country' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.set_country(mut dispatch_arg_0)
		}
		'update_providers_order' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.update_providers_order(mut dispatch_arg_0)
		}
		'attach_payment_extension_suggestion' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.attach_payment_extension_suggestion(mut dispatch_arg_0)
		}
		'hide_payment_extension_suggestion' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.hide_payment_extension_suggestion(mut dispatch_arg_0)
		}
		'dismiss_payment_extension_suggestion_incentive' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.dismiss_payment_extension_suggestion_incentive(mut dispatch_arg_0)
		}
		'get_extension_suggestions' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_extension_suggestions(dispatch_arg_0)
		}
		'check_permissions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.check_permissions(mut dispatch_arg_0))
		}
		'check_location_arg' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.check_location_arg(dispatch_arg_0, mut dispatch_arg_1))
		}
		'check_providers_order_map_arg' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_providers_order_map_arg(dispatch_arg_0))
		}
		'sanitize_providers_order_arg' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.sanitize_providers_order_arg(mut dispatch_arg_0)
		}
		'sanitize_provider_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.sanitize_provider_id(dispatch_arg_0))
		}
		'prepare_payment_providers_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.prepare_payment_providers_response(mut dispatch_arg_0)
		}
		'prepare_payment_providers_response_recursive' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.prepare_payment_providers_response_recursive(dispatch_arg_0, mut
				dispatch_arg_1)
		}
		'add_provider_links' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.add_provider_links(mut dispatch_arg_0)
		}
		'add_suggestion_links' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
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
		else {
			return none
		}
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
		'route_namespace' {
			this.route_namespace = val
			return true
		}
		'rest_base' {
			this.rest_base = val
			return true
		}
		'payments' {
			this.payments = val
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

fn main() {
	defer {
		rt.shutdown()
	}
}
