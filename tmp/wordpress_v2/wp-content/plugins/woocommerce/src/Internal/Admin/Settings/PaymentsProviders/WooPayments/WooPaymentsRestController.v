import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController {
	rt.PhpObjectBase
pub mut:
	route_namespace rt.PhpVal = rt.new_string('wc-admin')
	rest_base       rt.PhpVal = rt.new_string('settings/payments/woopayments')
	payments        rt.PhpVal = rt.new_null()
	woopayments     rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) get_rest_api_namespace() string {
	return 'wc-admin-settings-payments-woopayments'
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) register_routes(override bool) {
	mut var_request := rt.new_null()
	mut var_value := rt.new_null()
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('get_onboarding_details'))
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
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.get_schema_for_get_onboarding_details()
	}
	rt.call_function('register_rest_route', [this.route_namespace,
		rt.new_string('/' + (this.rest_base).str() + '/onboarding'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_1_fn) },
				rt.ArrayItem{ key: 'validation_callback', val: 'rest_validate_request_arg' },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_2_fn) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'location', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('ISO3166 alpha-2 country code. Defaults to the stored providers business location country code.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_3_fn) },
					]) },
					rt.ArrayItem{ key: 'source', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The upmost entry point from where the merchant entered the onboarding flow.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.new_closure(closure_4_fn) },
		]),
		rt.new_bool(override)])
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('handle_onboarding_step_start'))
	}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_request := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return this.check_location_arg(var_value.clone(), mut
			rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace,
		rt.new_string('/' +
			(this.rest_base).str() + '/onboarding/step/(?P<step>[a-zA-Z0-9_-]+)/start'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_5_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_6_fn) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'location', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('ISO3166 alpha-2 country code. Defaults to the stored providers business location country code.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_7_fn) },
					]) },
					rt.ArrayItem{ key: 'source', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The upmost entry point from where the merchant entered the onboarding flow.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
					]) },
				]) },
			]) },
		]),
		rt.new_bool(override)])
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('handle_onboarding_step_save'))
	}
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_request := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return this.check_location_arg(var_value.clone(), mut
			rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace,
		rt.new_string('/' +
			(this.rest_base).str() + '/onboarding/step/(?P<step>[a-zA-Z0-9_-]+)/save'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_8_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_9_fn) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'location', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('ISO3166 alpha-2 country code. Defaults to the stored providers business location country code.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_10_fn) },
					]) },
					rt.ArrayItem{ key: 'source', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The upmost entry point from where the merchant entered the onboarding flow.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
					]) },
				]) },
			]) },
		]),
		rt.new_bool(override)])
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('handle_onboarding_step_check'))
	}
	closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_request := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return this.check_location_arg(var_value.clone(), mut
			rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace,
		rt.new_string('/' +
			(this.rest_base).str() + '/onboarding/step/(?P<step>[a-zA-Z0-9_-]+)/check'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_11_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_12_fn) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'location', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('ISO3166 alpha-2 country code. Defaults to the stored providers business location country code.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_13_fn) },
					]) },
				]) },
			]) },
		]),
		rt.new_bool(override)])
	closure_14_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('handle_onboarding_step_finish'))
	}
	closure_15_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	closure_16_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_request := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return this.check_location_arg(var_value.clone(), mut
			rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace,
		rt.new_string('/' +
			(this.rest_base).str() + '/onboarding/step/(?P<step>[a-zA-Z0-9_-]+)/finish'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_14_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_15_fn) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'location', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('ISO3166 alpha-2 country code. Defaults to the stored providers business location country code.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_16_fn) },
					]) },
					rt.ArrayItem{ key: 'source', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The upmost entry point from where the merchant entered the onboarding flow.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
					]) },
				]) },
			]) },
		]),
		rt.new_bool(override)])
	closure_17_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('handle_onboarding_step_clean'))
	}
	closure_18_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	closure_19_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_request := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return this.check_location_arg(var_value.clone(), mut
			rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace,
		rt.new_string('/' +
			(this.rest_base).str() + '/onboarding/step/(?P<step>[a-zA-Z0-9_-]+)/clean'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_17_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_18_fn) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'location', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('ISO3166 alpha-2 country code. Defaults to the stored providers business location country code.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_19_fn) },
					]) },
				]) },
			]) },
		]),
		rt.new_bool(override)])
	closure_20_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('handle_onboarding_test_account_init'))
	}
	closure_21_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	closure_22_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_request := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return this.check_location_arg(var_value.clone(), mut
			rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace,
		rt.new_string('/' +
			(this.rest_base).str() + '/onboarding/step/' + (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account()).str() + '/init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_20_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_21_fn) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'location', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('ISO3166 alpha-2 country code. Defaults to the stored providers business location country code.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_22_fn) },
					]) },
					rt.ArrayItem{ key: 'source', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The upmost entry point from where the merchant entered the onboarding flow.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
					]) },
				]) },
			]) },
		]),
		rt.new_bool(override)])
	closure_23_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('handle_onboarding_test_account_reset'))
	}
	closure_24_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	closure_25_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_request := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return this.check_location_arg(var_value.clone(), mut
			rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace,
		rt.new_string('/' +
			(this.rest_base).str() + '/onboarding/step/' + (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account()).str() + '/reset'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_23_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_24_fn) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'location', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('ISO3166 alpha-2 country code. Defaults to the stored providers business location country code.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_25_fn) },
					]) },
					rt.ArrayItem{ key: 'source', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The upmost entry point from where the merchant entered the onboarding flow.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
					]) },
				]) },
			]) },
		]),
		rt.new_bool(override)])
	closure_26_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(),
			rt.new_string('handle_onboarding_business_verification_kyc_session_init'))
	}
	closure_27_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	closure_28_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_request := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return this.check_location_arg(var_value.clone(), mut
			rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace,
		rt.new_string('/' +
			(this.rest_base).str() + '/onboarding/step/' + (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification()).str() + '/kyc_session'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_26_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_27_fn) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'location', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('ISO3166 alpha-2 country code. Defaults to the stored providers business location country code.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_28_fn) },
					]) },
					rt.ArrayItem{ key: 'source', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The upmost entry point from where the merchant entered the onboarding flow.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
					]) },
				]) },
			]) },
		]),
		rt.new_bool(override)])
	closure_29_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(),
			rt.new_string('handle_onboarding_business_verification_kyc_session_finish'))
	}
	closure_30_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	closure_31_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_request := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return this.check_location_arg(var_value.clone(), mut
			rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace,
		rt.new_string('/' +
			(this.rest_base).str() + '/onboarding/step/' + (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification()).str() + '/kyc_session/finish'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_29_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_30_fn) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'location', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('ISO3166 alpha-2 country code. Defaults to the stored providers business location country code.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_31_fn) },
					]) },
					rt.ArrayItem{ key: 'source', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The upmost entry point from where the merchant entered the onboarding flow.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
					]) },
				]) },
			]) },
		]),
		rt.new_bool(override)])
	closure_32_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('handle_test_account_disable'))
	}
	closure_33_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	closure_34_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_request := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return this.check_location_arg(var_value.clone(), mut
			rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace,
		rt.new_string('/' +
			(this.rest_base).str() + '/onboarding/step/' + (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification()).str() + '/test_account/disable'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_32_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_33_fn) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'location', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('ISO3166 alpha-2 country code. Defaults to the stored providers business location country code.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_34_fn) },
					]) },
					rt.ArrayItem{ key: 'from', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('Where from in the onboarding flow this request was triggered.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
					]) },
					rt.ArrayItem{ key: 'source', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The upmost entry point from where the merchant entered the onboarding flow.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
					]) },
				]) },
			]) },
		]),
		rt.new_bool(override)])
	closure_35_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('handle_onboarding_preload'))
	}
	closure_36_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	closure_37_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_request := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return this.check_location_arg(var_value.clone(), mut
			rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace,
		rt.new_string('/' + (this.rest_base).str() + '/onboarding/preload'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_35_fn) },
				rt.ArrayItem{ key: 'validation_callback', val: 'rest_validate_request_arg' },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_36_fn) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'location', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('ISO3166 alpha-2 country code. Defaults to the stored providers business location country code.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_37_fn) },
					]) },
				]) },
			]) },
		]),
		rt.new_bool(override)])
	closure_38_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('reset_onboarding'))
	}
	closure_39_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	closure_40_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_request := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return this.check_location_arg(var_value.clone(), mut
			rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace,
		rt.new_string('/' + (this.rest_base).str() + '/onboarding/reset'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_38_fn) },
				rt.ArrayItem{ key: 'validation_callback', val: 'rest_validate_request_arg' },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_39_fn) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'location', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('ISO3166 alpha-2 country code. Defaults to the stored providers business location country code.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_40_fn) },
					]) },
					rt.ArrayItem{ key: 'from', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('Where from in the onboarding flow this request was triggered.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
					]) },
					rt.ArrayItem{ key: 'source', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The upmost entry point from where the merchant entered the onboarding flow.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
					]) },
				]) },
			]) },
		]),
		rt.new_bool(override)])
	closure_41_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('get_woopay_eligibility'))
	}
	closure_42_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace,
		rt.new_string('/' + (this.rest_base).str() + '/woopay-eligibility'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_41_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_42_fn) },
			]) },
		]),
		rt.new_bool(override)])
	closure_43_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('handle_test_account_disable'))
	}
	closure_44_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	closure_45_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_request := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return this.check_location_arg(var_value.clone(), mut
			rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace,
		rt.new_string('/' + (this.rest_base).str() + '/onboarding/test_account/disable'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_43_fn) },
				rt.ArrayItem{ key: 'validation_callback', val: 'rest_validate_request_arg' },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_44_fn) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'location', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('ISO3166 alpha-2 country code. Defaults to the stored providers business location country code.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_45_fn) },
					]) },
					rt.ArrayItem{ key: 'from', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('Where from in the onboarding flow this request was triggered.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
					]) },
					rt.ArrayItem{ key: 'source', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The upmost entry point from where the merchant entered the onboarding flow.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
					]) },
				]) },
			]) },
		]),
		rt.new_bool(override)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) get_rest_url_path(relative_path string) string {
	mut var_path := rt.new_string('/' + this.route_namespace.to_string().trim_space() + '/' +
		this.rest_base.to_string().trim_space())
	if !(relative_path == '') {
		var_path = rt.concat(var_path, rt.new_string('/' + relative_path.trim_left(' \t\n\r')))
	}
	return var_path.str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) init(mut var_payments Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments, mut var_woopayments Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) {
	this.payments = var_payments
	this.woopayments = var_woopayments
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) get_onboarding_details(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_location := var_request.get_param(rt.new_string('location'))
	if !rt.is_true(var_location) {
		var_location = rt.call_method(this.payments, 'get_country', []rt.PhpVal{})
	}
	mut var_source := var_request.get_param(rt.new_string('source'))
	mut var_onboarding_details := rt.call_method(this.woopayments, 'get_onboarding_details', [
		var_location.clone(),
		rt.new_string(this.get_rest_url_path('onboarding')),
		var_source.clone(),
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
	if rt.instance_of(var_e_1,
		'Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException')
	{
		mut var_e := var_e_1.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e,
			'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) },
		])))
		unsafe {
			goto end_label_1
		}
	} else if rt.instance_of(var_e_1, 'Exception') {
		var_e = var_e_1.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_woopayments_onboarding_error'), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: Class_WP_Http.internal_server_error() },
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
	return rt.call_function('rest_ensure_response', [
		this.prepare_onboarding_details_response(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](var_onboarding_details)),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) handle_onboarding_step_start(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_step_id := if !(var_request.get_param(rt.new_string('step'))).is_null() {
		var_request.get_param(rt.new_string('step'))
	} else {
		rt.new_string('')
	}
	mut var_location := var_request.get_param(rt.new_string('location'))
	if !rt.is_true(var_location) {
		var_location = rt.call_method(this.payments, 'get_country', []rt.PhpVal{})
	}
	mut var_source := var_request.get_param(rt.new_string('source'))
	mut var_previous_status := rt.call_method(this.woopayments, 'get_onboarding_step_status', [
		var_step_id.clone(),
		var_location.clone(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	rt.call_method(this.woopayments, 'mark_onboarding_step_started', [
		var_step_id.clone(), var_location.clone(), rt.new_bool(false),
		var_source.clone()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	mut var_response := rt.create_array([rt.ArrayItem{ key: 'success', val: true },
		rt.ArrayItem{ key: 'previous_status', val: var_previous_status },
		rt.ArrayItem{ key: 'current_status', val: rt.call_method(this.woopayments,
			'get_onboarding_step_status', [var_step_id.clone(),
			var_location.clone()]) }])
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
		mut var_e := var_e_2.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e,
			'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) },
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
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) handle_onboarding_step_save(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_step_id := if !(var_request.get_param(rt.new_string('step'))).is_null() {
		var_request.get_param(rt.new_string('step'))
	} else {
		rt.new_string('')
	}
	mut var_location := var_request.get_param(rt.new_string('location'))
	if !rt.is_true(var_location) {
		var_location = rt.call_method(this.payments, 'get_country', []rt.PhpVal{})
	}
	mut var_source := var_request.get_param(rt.new_string('source'))
	rt.call_method(this.woopayments, 'onboarding_step_save', [
		var_step_id.clone(), var_location.clone(), var_request.get_params()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	rt.call_method(this.woopayments, 'mark_onboarding_step_started', [
		var_step_id.clone(), var_location.clone(), rt.new_bool(false),
		var_source.clone()])
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
	if rt.instance_of(var_e_3,
		'Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException')
	{
		mut var_e := var_e_3.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e,
			'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) },
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
		rt.create_array([rt.ArrayItem{ key: 'success', val: true }]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) handle_onboarding_step_check(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_step_id := if !(var_request.get_param(rt.new_string('step'))).is_null() {
		var_request.get_param(rt.new_string('step'))
	} else {
		rt.new_string('')
	}
	mut var_location := var_request.get_param(rt.new_string('location'))
	if !rt.is_true(var_location) {
		var_location = rt.call_method(this.payments, 'get_country', []rt.PhpVal{})
	}
	mut var_result := rt.call_method(this.woopayments, 'onboarding_step_check', [
		var_step_id.clone(),
		var_location.clone(),
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
	if rt.instance_of(var_e_4,
		'Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException')
	{
		mut var_e := var_e_4.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e,
			'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) },
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
	mut var_response := rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: 'success', val: true }]),
		var_result.clone(),
	])
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) handle_onboarding_step_finish(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_step_id := if !(var_request.get_param(rt.new_string('step'))).is_null() {
		var_request.get_param(rt.new_string('step'))
	} else {
		rt.new_string('')
	}
	mut var_location := var_request.get_param(rt.new_string('location'))
	if !rt.is_true(var_location) {
		var_location = rt.call_method(this.payments, 'get_country', []rt.PhpVal{})
	}
	mut var_source := var_request.get_param(rt.new_string('source'))
	mut var_previous_status := rt.call_method(this.woopayments, 'get_onboarding_step_status', [
		var_step_id.clone(),
		var_location.clone(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_5
		}
	}
	rt.call_method(this.woopayments, 'mark_onboarding_step_completed', [
		var_step_id.clone(), var_location.clone(), rt.new_bool(false),
		var_source.clone()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_5
		}
	}
	mut var_response := rt.create_array([rt.ArrayItem{ key: 'success', val: true },
		rt.ArrayItem{ key: 'previous_status', val: var_previous_status },
		rt.ArrayItem{ key: 'current_status', val: rt.call_method(this.woopayments,
			'get_onboarding_step_status', [var_step_id.clone(),
			var_location.clone()]) }])
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
		mut var_e := var_e_5.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e,
			'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) },
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
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) handle_onboarding_step_clean(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_step_id := if !(var_request.get_param(rt.new_string('step'))).is_null() {
		var_request.get_param(rt.new_string('step'))
	} else {
		rt.new_string('')
	}
	mut var_location := var_request.get_param(rt.new_string('location'))
	if !rt.is_true(var_location) {
		var_location = rt.call_method(this.payments, 'get_country', []rt.PhpVal{})
	}
	mut var_previous_status := rt.call_method(this.woopayments, 'get_onboarding_step_status', [
		var_step_id.clone(),
		var_location.clone(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_6
		}
	}
	rt.call_method(this.woopayments, 'clean_onboarding_step_progress', [
		var_step_id.clone(), var_location.clone()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_6
		}
	}
	mut var_response := rt.create_array([rt.ArrayItem{ key: 'success', val: true },
		rt.ArrayItem{ key: 'previous_status', val: var_previous_status },
		rt.ArrayItem{ key: 'current_status', val: rt.call_method(this.woopayments,
			'get_onboarding_step_status', [var_step_id.clone(),
			var_location.clone()]) }])
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
	if rt.instance_of(var_e_6,
		'Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException')
	{
		mut var_e := var_e_6.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e,
			'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) },
		])))
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
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) handle_onboarding_test_account_init(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_location := var_request.get_param(rt.new_string('location'))
	if !rt.is_true(var_location) {
		var_location = rt.call_method(this.payments, 'get_country', []rt.PhpVal{})
	}
	mut var_source := var_request.get_param(rt.new_string('source'))
	rt.call_method(this.woopayments, 'mark_onboarding_step_started', [
		Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account(),
		var_location.clone(),
		rt.new_bool(false),
		var_source.clone(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_7
		}
	}
	mut var_result := rt.call_method(this.woopayments, 'onboarding_test_account_init', [
		var_location.clone(),
		var_source.clone(),
	])
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
		mut var_e := var_e_7.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e,
			'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) },
		])))
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
	return rt.call_function('rest_ensure_response', [
		rt.call_function('array_merge', [
			rt.create_array([rt.ArrayItem{ key: 'success', val: true }]),
			var_result.clone(),
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) handle_onboarding_test_account_reset(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_location := var_request.get_param(rt.new_string('location'))
	if !rt.is_true(var_location) {
		var_location = rt.call_method(this.payments, 'get_country', []rt.PhpVal{})
	}
	mut var_source := var_request.get_param(rt.new_string('source'))
	var_request.set_param(rt.new_string('location'), var_location.clone())
	var_request.set_param(rt.new_string('from'),
		Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account())
	var_request.set_param(rt.new_string('source'), var_source.clone())
	return this.reset_onboarding(mut var_request)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) handle_onboarding_business_verification_kyc_session_init(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_self_assessment := if !(!rt.is_true(var_request.get_param(rt.new_string('self_assessment')))) { rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [
				var_request.get_param(rt.new_string('self_assessment')),
			]),
		]) } else { rt.new_array() }
	mut var_location := var_request.get_param(rt.new_string('location'))
	if !rt.is_true(var_location) {
		var_location = rt.call_method(this.payments, 'get_country', []rt.PhpVal{})
	}
	mut var_source := var_request.get_param(rt.new_string('source'))
	mut var_account_session := rt.call_method(this.woopayments, 'get_onboarding_kyc_session', [
		var_location.clone(),
		var_self_assessment.clone(),
		var_source.clone(),
	])
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
		mut var_e := var_e_8.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e,
			'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) },
		])))
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
	return rt.call_function('rest_ensure_response', [
		rt.create_array([rt.ArrayItem{ key: 'success', val: true },
			rt.ArrayItem{ key: 'session', val: var_account_session }]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) handle_onboarding_business_verification_kyc_session_finish(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_location := var_request.get_param(rt.new_string('location'))
	if !rt.is_true(var_location) {
		var_location = rt.call_method(this.payments, 'get_country', []rt.PhpVal{})
	}
	mut var_source := var_request.get_param(rt.new_string('source'))
	mut var_response := rt.call_method(this.woopayments, 'finish_onboarding_kyc_session', [
		var_location.clone(),
		var_source.clone(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_9
		}
	}
	unsafe {
		goto end_label_9
	}
	catch_label_9:
	mut var_e_9 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_9,
		'Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException')
	{
		mut var_e := var_e_9.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e,
			'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) },
		])))
		unsafe {
			goto end_label_9
		}
	} else {
		rt.throw_exception(var_e_9)
		unsafe {
			goto end_label_9
		}
	}

	end_label_9:
	if !(var_response.array_isset(rt.new_string('success'))) {
		var_response.array_set('success', true)
	}
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) handle_onboarding_preload(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_location := var_request.get_param(rt.new_string('location'))
	if !rt.is_true(var_location) {
		var_location = rt.call_method(this.payments, 'get_country', []rt.PhpVal{})
	}
	mut var_response := rt.call_method(this.woopayments, 'onboarding_preload', [
		var_location.clone(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_10
		}
	}
	unsafe {
		goto end_label_10
	}
	catch_label_10:
	mut var_e_10 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_10,
		'Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException')
	{
		mut var_e := var_e_10.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e,
			'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) },
		])))
		unsafe {
			goto end_label_10
		}
	} else {
		rt.throw_exception(var_e_10)
		unsafe {
			goto end_label_10
		}
	}

	end_label_10:
	if !(var_response.array_isset(rt.new_string('success'))) {
		var_response.array_set('success', true)
	}
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) reset_onboarding(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_location := var_request.get_param(rt.new_string('location'))
	if !rt.is_true(var_location) {
		var_location = rt.call_method(this.payments, 'get_country', []rt.PhpVal{})
	}
	rt.call_method(this.woopayments, 'reset_onboarding', [var_location.clone(), if !(var_request.get_param(rt.new_string('from'))).is_null() {
		var_request.get_param(rt.new_string('from'))
	} else {
		rt.new_string('')
	}, if !(var_request.get_param(rt.new_string('source'))).is_null() {
		var_request.get_param(rt.new_string('source'))
	} else {
		rt.new_string('')
	}])
	if rt.has_exception() {
		unsafe {
			goto catch_label_11
		}
	}
	unsafe {
		goto end_label_11
	}
	catch_label_11:
	mut var_e_11 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_11,
		'Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException')
	{
		mut var_e := var_e_11.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e,
			'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) },
		])))
		unsafe {
			goto end_label_11
		}
	} else {
		rt.throw_exception(var_e_11)
		unsafe {
			goto end_label_11
		}
	}

	end_label_11:
	return rt.call_function('rest_ensure_response', [
		rt.create_array([rt.ArrayItem{ key: 'success', val: true }]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) handle_test_account_disable(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_location := var_request.get_param(rt.new_string('location'))
	if !rt.is_true(var_location) {
		var_location = rt.call_method(this.payments, 'get_country', []rt.PhpVal{})
	}
	rt.call_method(this.woopayments, 'disable_test_account', [
		var_location.clone(), if !(var_request.get_param(rt.new_string('from'))).is_null() {
			var_request.get_param(rt.new_string('from'))
		} else {
			rt.new_string('')
		}, if !(var_request.get_param(rt.new_string('source'))).is_null() {
			var_request.get_param(rt.new_string('source'))
		} else {
			rt.new_string('')
		}])
	if rt.has_exception() {
		unsafe {
			goto catch_label_12
		}
	}
	unsafe {
		goto end_label_12
	}
	catch_label_12:
	mut var_e_12 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_12,
		'Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException')
	{
		mut var_e := var_e_12.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e,
			'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) },
		])))
		unsafe {
			goto end_label_12
		}
	} else {
		rt.throw_exception(var_e_12)
		unsafe {
			goto end_label_12
		}
	}

	end_label_12:
	return rt.call_function('rest_ensure_response', [
		rt.create_array([rt.ArrayItem{ key: 'success', val: true }]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) get_woopay_eligibility() rt.PhpVal {
	mut var_location := rt.call_method(this.payments, 'get_country', []rt.PhpVal{})
	mut var_woopay_eligible_countries := rt.create_array([
		rt.ArrayItem{ key: none, val: 'US' },
	])
	mut var_is_eligible := rt.call_function('in_array', [var_location.clone(),
		var_woopay_eligible_countries.clone(), rt.new_bool(true)])
	return rt.call_function('rest_ensure_response', [
		rt.create_array([rt.ArrayItem{ key: 'is_eligible', val: var_is_eligible }]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) check_permissions(mut var_request Class_WP_REST_Request) bool {
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) check_location_arg(var_value rt.PhpVal, mut var_request Class_WP_REST_Request) bool {
	if !(var_value.clone().is_string()) {
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
		var_value.clone(),
	])))))
	{
		return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('esc_html__', [
			rt.new_string('The location argument must be a valid ISO3166 alpha-2 country code.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) prepare_onboarding_details_response(mut var_response Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array) rt.PhpVal {
	mut var_response_mutated := var_response
	return this.prepare_onboarding_details_response_recursive(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array',
		[]string{}, var_response_mutated), mut
		rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](this.get_schema_for_get_onboarding_details()))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) prepare_onboarding_details_response_recursive(var_response_item rt.PhpVal, mut var_schema Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array) rt.PhpVal {
	mut var_item := rt.new_null()
	mut var_schema_mutated := var_schema
	if rt.is_true(rt.new_bool(var_response_item.clone().is_null())) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_schema_mutated.array_isset(rt.new_string('properties')))))))
		|| !(var_schema_mutated.array_get(rt.new_string('properties')).is_array()) {
		if rt.is_true(rt.new_bool(var_response_item.clone().is_array())) {
			mut iife_temp_45 := Class_Automattic_WooCommerce_Internal_Utilities_ArrayUtil{}
			mut iife_result_45 :=
				iife_temp_45.filter_null_values_recursive(var_response_item.clone())
			return iife_result_45
		}
		return var_response_item.clone()
	}
	mut var_prepared_response := rt.new_array()
	mut iter_1 := var_schema_mutated.array_get(rt.new_string('properties')).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_property_schema := item_1.val
		mut var_key := item_1.key
		if var_response_item.clone().is_array()
			&& rt.is_true(rt.new_bool(var_response_item.clone().array_isset(var_key.clone()))) {
			if var_property_schema.clone().is_array()
				&& rt.is_true(rt.new_bool(var_property_schema.clone().array_isset(rt.new_string('properties')))) {
				var_prepared_response.array_set(var_key, this.prepare_onboarding_details_response_recursive(var_response_item.array_get(var_key), mut
					rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](var_property_schema)))
			} else if var_property_schema.clone().is_array()
				&& rt.is_true(rt.new_bool(var_property_schema.clone().array_isset(rt.new_string('items')))) {
				closure_47_fn := fn [var_property_schema] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
					mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
					return this.prepare_onboarding_details_response_recursive(var_item.clone(), mut
						rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](var_property_schema.array_get(rt.new_string('items'))))
				}
				closure_48_fn := fn [var_property_schema] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
					mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
					return this.prepare_onboarding_details_response_recursive(var_item.clone(), mut
						rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](var_property_schema.array_get(rt.new_string('items'))))
				}
				var_prepared_response.array_set(var_key, rt.call_function('array_map', [
					rt.new_closure(closure_47_fn),
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
	mut iife_temp_48 := Class_Automattic_WooCommerce_Internal_Utilities_ArrayUtil{}
	mut iife_result_48 := iife_temp_48.filter_null_values_recursive(var_prepared_response.clone())
	return iife_result_48
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) get_schema_for_get_onboarding_details() rt.PhpVal {
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{
			key: 'title'
			val: 'WooCommerce Settings Payments WooPayments onboarding details for the given location.'
		},
		rt.ArrayItem{ key: 'type', val: 'object' },
	])
	var_schema.array_set('properties', rt.create_array([
		rt.ArrayItem{ key: 'state', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
				rt.new_string('The general state of the onboarding process.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'properties', val: rt.create_array([
				rt.ArrayItem{ key: 'supported', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
						rt.new_string('Whether onboarding is supported.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'view' },
						rt.ArrayItem{ key: none, val: 'edit' },
					]) },
					rt.ArrayItem{ key: 'readonly', val: true },
				]) },
				rt.ArrayItem{ key: 'started', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
						rt.new_string('Whether the onboarding process is started.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'view' },
						rt.ArrayItem{ key: none, val: 'edit' },
					]) },
					rt.ArrayItem{ key: 'readonly', val: true },
				]) },
				rt.ArrayItem{ key: 'completed', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
						rt.new_string('Whether the onboarding process is completed.'),
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
						rt.new_string('Whether the onboarding process is in test mode.'),
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
						rt.new_string('Whether WooPayments is in dev mode.'),
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
				rt.new_string('The onboarding steps.'),
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
					rt.ArrayItem{ key: 'id', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The unique identifier for the step.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'path', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The relative path of the step to use for frontend navigation.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'required_steps', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'array' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The steps that are required to be completed before this step.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
						rt.ArrayItem{ key: 'items', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'string' },
						]) },
					]) },
					rt.ArrayItem{ key: 'status', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The current status of the step.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
						rt.ArrayItem{ key: 'enum', val: rt.create_array([
							rt.ArrayItem{
								key: none
								val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_not_started()
							},
							rt.ArrayItem{
								key: none
								val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_started()
							},
							rt.ArrayItem{
								key: none
								val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_completed()
							},
						]) },
					]) },
					rt.ArrayItem{ key: 'errors', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'array' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('Errors list for the step.'),
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
								rt.ArrayItem{ key: 'code', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'string' },
									rt.ArrayItem{ key: 'readonly', val: true },
								]) },
								rt.ArrayItem{ key: 'message', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'string' },
									rt.ArrayItem{ key: 'readonly', val: true },
								]) },
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'object' },
									rt.ArrayItem{ key: 'readonly', val: true },
								]) },
							]) },
						]) },
					]) },
					rt.ArrayItem{ key: 'actions', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'object' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('The available actions for the step.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
						rt.ArrayItem{ key: 'properties', val: rt.create_array([
							rt.ArrayItem{ key: 'start', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'object' },
								rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
									rt.new_string('Action to signal the step start.'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{
									key: 'properties'
									val: this.get_schema_properties_for_onboarding_step_action()
								},
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
								rt.ArrayItem{ key: 'readonly', val: true },
							]) },
							rt.ArrayItem{ key: 'save', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'object' },
								rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
									rt.new_string('Action to save step information in the database.'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{
									key: 'properties'
									val: this.get_schema_properties_for_onboarding_step_action()
								},
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
								rt.ArrayItem{ key: 'readonly', val: true },
							]) },
							rt.ArrayItem{ key: 'check', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'object' },
								rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
									rt.new_string('Action to check the step status.'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{
									key: 'properties'
									val: this.get_schema_properties_for_onboarding_step_action()
								},
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
								rt.ArrayItem{ key: 'readonly', val: true },
							]) },
							rt.ArrayItem{ key: 'finish', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'object' },
								rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
									rt.new_string('Action to signal the step completion.'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{
									key: 'properties'
									val: this.get_schema_properties_for_onboarding_step_action()
								},
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
								rt.ArrayItem{ key: 'readonly', val: true },
							]) },
							rt.ArrayItem{ key: 'clean', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'object' },
								rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
									rt.new_string('Action to clean the step progress.'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{
									key: 'properties'
									val: this.get_schema_properties_for_onboarding_step_action()
								},
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
								rt.ArrayItem{ key: 'readonly', val: true },
							]) },
							rt.ArrayItem{ key: 'auth', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'object' },
								rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
									rt.new_string('Action to authorize the WPCOM connection.'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{
									key: 'properties'
									val: this.get_schema_properties_for_onboarding_step_action()
								},
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
								rt.ArrayItem{ key: 'readonly', val: true },
							]) },
							rt.ArrayItem{ key: 'init', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'object' },
								rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
									rt.new_string('Action to initialize a test account.'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{
									key: 'properties'
									val: this.get_schema_properties_for_onboarding_step_action()
								},
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
								rt.ArrayItem{ key: 'readonly', val: true },
							]) },
							rt.ArrayItem{ key: 'kyc_session', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'object' },
								rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
									rt.new_string('Action to create or resume an embedded KYC session.'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{
									key: 'properties'
									val: this.get_schema_properties_for_onboarding_step_action()
								},
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
								rt.ArrayItem{ key: 'readonly', val: true },
							]) },
							rt.ArrayItem{ key: 'kyc_session_finish', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'object' },
								rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
									rt.new_string('Action to finish an embedded KYC session.'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{
									key: 'properties'
									val: this.get_schema_properties_for_onboarding_step_action()
								},
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
								rt.ArrayItem{ key: 'readonly', val: true },
							]) },
							rt.ArrayItem{ key: 'kyc_fallback', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'object' },
								rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
									rt.new_string('Action to use as a fallback when dealing with errors with the embedded KYC.'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{
									key: 'properties'
									val: this.get_schema_properties_for_onboarding_step_action()
								},
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
								rt.ArrayItem{ key: 'readonly', val: true },
							]) },
							rt.ArrayItem{ key: 'reset', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'object' },
								rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
									rt.new_string('Action to reset the onboarding process, either partially, for a certain step, or fully.'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{
									key: 'properties'
									val: this.get_schema_properties_for_onboarding_step_action()
								},
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
								rt.ArrayItem{ key: 'readonly', val: true },
							]) },
							rt.ArrayItem{ key: 'test_account_disable', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'object' },
								rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
									rt.new_string('Action to disable the test account currently in use'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{
									key: 'properties'
									val: this.get_schema_properties_for_onboarding_step_action()
								},
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
								rt.ArrayItem{ key: 'readonly', val: true },
							]) },
						]) },
					]) },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'object' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
							rt.new_string('Various contextual data for the step to use.'),
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
	]))
	return var_schema.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) get_schema_properties_for_onboarding_step_action() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'type', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
				rt.new_string('The action type to determine how to use the URL.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'enum', val: rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.action_type_rest()
				},
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.action_type_redirect()
				},
			]) },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'href', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
				rt.new_string('The URL to use for the action.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
	])
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

fn create_automattic_woocommerce_internal_admin_settings_paymentsproviders_woopayments_woopaymentsrestcontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController{
		PhpObjectBase:   rt.PhpObjectBase{}
		route_namespace: rt.new_string('wc-admin')
		rest_base:       rt.new_string('settings/payments/woopayments')
		payments:        rt.new_null()
		woopayments:     rt.new_null()
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_rest_api_namespace' {
			return rt.new_string(this.get_rest_api_namespace())
		}
		'register_routes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.register_routes(dispatch_arg_0)
			return rt.new_null()
		}
		'get_rest_url_path' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_rest_url_path(dispatch_arg_0))
		}
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_onboarding_details' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_onboarding_details(mut dispatch_arg_0)
		}
		'handle_onboarding_step_start' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.handle_onboarding_step_start(mut dispatch_arg_0)
		}
		'handle_onboarding_step_save' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.handle_onboarding_step_save(mut dispatch_arg_0)
		}
		'handle_onboarding_step_check' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.handle_onboarding_step_check(mut dispatch_arg_0)
		}
		'handle_onboarding_step_finish' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.handle_onboarding_step_finish(mut dispatch_arg_0)
		}
		'handle_onboarding_step_clean' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.handle_onboarding_step_clean(mut dispatch_arg_0)
		}
		'handle_onboarding_test_account_init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.handle_onboarding_test_account_init(mut dispatch_arg_0)
		}
		'handle_onboarding_test_account_reset' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.handle_onboarding_test_account_reset(mut dispatch_arg_0)
		}
		'handle_onboarding_business_verification_kyc_session_init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.handle_onboarding_business_verification_kyc_session_init(mut dispatch_arg_0)
		}
		'handle_onboarding_business_verification_kyc_session_finish' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.handle_onboarding_business_verification_kyc_session_finish(mut dispatch_arg_0)
		}
		'handle_onboarding_preload' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.handle_onboarding_preload(mut dispatch_arg_0)
		}
		'reset_onboarding' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.reset_onboarding(mut dispatch_arg_0)
		}
		'handle_test_account_disable' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.handle_test_account_disable(mut dispatch_arg_0)
		}
		'get_woopay_eligibility' {
			return this.get_woopay_eligibility()
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
		'prepare_onboarding_details_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.prepare_onboarding_details_response(mut dispatch_arg_0)
		}
		'prepare_onboarding_details_response_recursive' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.prepare_onboarding_details_response_recursive(dispatch_arg_0, mut
				dispatch_arg_1)
		}
		'get_schema_for_get_onboarding_details' {
			return this.get_schema_for_get_onboarding_details()
		}
		'get_schema_properties_for_onboarding_step_action' {
			return this.get_schema_properties_for_onboarding_step_action()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'route_namespace' { return this.route_namespace }
		'rest_base' { return this.rest_base }
		'payments' { return this.payments }
		'woopayments' { return this.woopayments }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
		'woopayments' {
			this.woopayments = val
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
