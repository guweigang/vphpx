import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController {
	rt.PhpObjectBase
pub mut:
		route_namespace rt.PhpVal = rt.new_string('wc-admin')
		rest_base rt.PhpVal = rt.new_string('settings/payments/woopayments')
		payments rt.PhpVal = rt.new_null()
		woopayments rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) get_rest_api_namespace() string {
	return 'wc-admin-settings-payments-woopayments'
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) register_routes(override bool)  {
	mut var_request := rt.new_null()
	mut var_value := rt.new_null()
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('get_onboarding_details'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_request := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return this.check_location_arg(var_value.dup(), mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	return this.get_schema_for_get_onboarding_details()
	}
	rt.call_function('register_rest_route', [this.route_namespace, '/' + (this.rest_base).str() + '/onboarding', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_1_fn) }, rt.ArrayItem{ key: 'validation_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_2_fn) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'location', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('ISO3166 alpha-2 country code. Defaults to the stored providers business location country code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_3_fn) }]) }, rt.ArrayItem{ key: 'source', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('The upmost entry point from where the merchant entered the onboarding flow.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.new_closure(closure_4_fn) }]), rt.new_bool(override)])
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('handle_onboarding_step_start'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_request := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return this.check_location_arg(var_value.dup(), mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace, '/' + (this.rest_base).str() + '/onboarding/step/(?P<step>[a-zA-Z0-9_-]+)/start', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_5_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_6_fn) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'location', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('ISO3166 alpha-2 country code. Defaults to the stored providers business location country code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_7_fn) }]) }, rt.ArrayItem{ key: 'source', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('The upmost entry point from where the merchant entered the onboarding flow.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }]) }]) }]) }]), rt.new_bool(override)])
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('handle_onboarding_step_save'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_request := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return this.check_location_arg(var_value.dup(), mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace, '/' + (this.rest_base).str() + '/onboarding/step/(?P<step>[a-zA-Z0-9_-]+)/save', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_8_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_9_fn) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'location', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('ISO3166 alpha-2 country code. Defaults to the stored providers business location country code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_10_fn) }]) }, rt.ArrayItem{ key: 'source', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('The upmost entry point from where the merchant entered the onboarding flow.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }]) }]) }]) }]), rt.new_bool(override)])
	closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('handle_onboarding_step_check'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_request := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return this.check_location_arg(var_value.dup(), mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace, '/' + (this.rest_base).str() + '/onboarding/step/(?P<step>[a-zA-Z0-9_-]+)/check', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_11_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_12_fn) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'location', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('ISO3166 alpha-2 country code. Defaults to the stored providers business location country code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_13_fn) }]) }]) }]) }]), rt.new_bool(override)])
	closure_16_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_15_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_14_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('handle_onboarding_step_finish'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_request := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return this.check_location_arg(var_value.dup(), mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace, '/' + (this.rest_base).str() + '/onboarding/step/(?P<step>[a-zA-Z0-9_-]+)/finish', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_14_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_15_fn) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'location', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('ISO3166 alpha-2 country code. Defaults to the stored providers business location country code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_16_fn) }]) }, rt.ArrayItem{ key: 'source', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('The upmost entry point from where the merchant entered the onboarding flow.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }]) }]) }]) }]), rt.new_bool(override)])
	closure_19_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_18_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_17_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('handle_onboarding_step_clean'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_request := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return this.check_location_arg(var_value.dup(), mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace, '/' + (this.rest_base).str() + '/onboarding/step/(?P<step>[a-zA-Z0-9_-]+)/clean', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_17_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_18_fn) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'location', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('ISO3166 alpha-2 country code. Defaults to the stored providers business location country code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_19_fn) }]) }]) }]) }]), rt.new_bool(override)])
	closure_22_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_21_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_20_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('handle_onboarding_test_account_init'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_request := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return this.check_location_arg(var_value.dup(), mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace, '/' + (this.rest_base).str() + '/onboarding/step/' + (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account()).str() + '/init', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_20_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_21_fn) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'location', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('ISO3166 alpha-2 country code. Defaults to the stored providers business location country code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_22_fn) }]) }, rt.ArrayItem{ key: 'source', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('The upmost entry point from where the merchant entered the onboarding flow.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }]) }]) }]) }]), rt.new_bool(override)])
	closure_25_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_24_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_23_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('handle_onboarding_test_account_reset'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_request := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return this.check_location_arg(var_value.dup(), mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace, '/' + (this.rest_base).str() + '/onboarding/step/' + (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account()).str() + '/reset', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_23_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_24_fn) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'location', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('ISO3166 alpha-2 country code. Defaults to the stored providers business location country code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_25_fn) }]) }, rt.ArrayItem{ key: 'source', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('The upmost entry point from where the merchant entered the onboarding flow.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }]) }]) }]) }]), rt.new_bool(override)])
	closure_28_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_27_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_26_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('handle_onboarding_business_verification_kyc_session_init'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_request := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return this.check_location_arg(var_value.dup(), mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace, '/' + (this.rest_base).str() + '/onboarding/step/' + (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification()).str() + '/kyc_session', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_26_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_27_fn) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'location', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('ISO3166 alpha-2 country code. Defaults to the stored providers business location country code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_28_fn) }]) }, rt.ArrayItem{ key: 'source', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('The upmost entry point from where the merchant entered the onboarding flow.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }]) }]) }]) }]), rt.new_bool(override)])
	closure_31_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_30_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_29_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('handle_onboarding_business_verification_kyc_session_finish'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_request := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return this.check_location_arg(var_value.dup(), mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace, '/' + (this.rest_base).str() + '/onboarding/step/' + (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification()).str() + '/kyc_session/finish', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_29_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_30_fn) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'location', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('ISO3166 alpha-2 country code. Defaults to the stored providers business location country code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_31_fn) }]) }, rt.ArrayItem{ key: 'source', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('The upmost entry point from where the merchant entered the onboarding flow.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }]) }]) }]) }]), rt.new_bool(override)])
	closure_34_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_33_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_32_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('handle_test_account_disable'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_request := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return this.check_location_arg(var_value.dup(), mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace, '/' + (this.rest_base).str() + '/onboarding/step/' + (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification()).str() + '/test_account/disable', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_32_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_33_fn) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'location', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('ISO3166 alpha-2 country code. Defaults to the stored providers business location country code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_34_fn) }]) }, rt.ArrayItem{ key: 'from', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('Where from in the onboarding flow this request was triggered.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }]) }, rt.ArrayItem{ key: 'source', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('The upmost entry point from where the merchant entered the onboarding flow.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }]) }]) }]) }]), rt.new_bool(override)])
	closure_37_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_36_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_35_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('handle_onboarding_preload'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_request := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return this.check_location_arg(var_value.dup(), mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace, '/' + (this.rest_base).str() + '/onboarding/preload', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_35_fn) }, rt.ArrayItem{ key: 'validation_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_36_fn) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'location', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('ISO3166 alpha-2 country code. Defaults to the stored providers business location country code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_37_fn) }]) }]) }]) }]), rt.new_bool(override)])
	closure_40_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_39_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_38_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('reset_onboarding'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_request := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return this.check_location_arg(var_value.dup(), mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace, '/' + (this.rest_base).str() + '/onboarding/reset', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_38_fn) }, rt.ArrayItem{ key: 'validation_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_39_fn) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'location', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('ISO3166 alpha-2 country code. Defaults to the stored providers business location country code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_40_fn) }]) }, rt.ArrayItem{ key: 'from', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('Where from in the onboarding flow this request was triggered.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }]) }, rt.ArrayItem{ key: 'source', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('The upmost entry point from where the merchant entered the onboarding flow.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }]) }]) }]) }]), rt.new_bool(override)])
	closure_42_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_41_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('get_woopay_eligibility'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace, '/' + (this.rest_base).str() + '/woopay-eligibility', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_41_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_42_fn) }]) }]), rt.new_bool(override)])
	closure_45_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_44_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_43_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.run(var_request.dup(), rt.new_string('handle_test_account_disable'))
	}
	mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_request := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return this.check_location_arg(var_value.dup(), mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace, '/' + (this.rest_base).str() + '/onboarding/test_account/disable', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_43_fn) }, rt.ArrayItem{ key: 'validation_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_44_fn) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'location', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('ISO3166 alpha-2 country code. Defaults to the stored providers business location country code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'pattern', val: '[a-zA-Z]{2}' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_45_fn) }]) }, rt.ArrayItem{ key: 'from', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('Where from in the onboarding flow this request was triggered.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }]) }, rt.ArrayItem{ key: 'source', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('The upmost entry point from where the merchant entered the onboarding flow.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }]) }]) }]) }]), rt.new_bool(override)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) get_rest_url_path(relative_path string) string {
	mut var_path := rt.new_string('/' + this.route_namespace.to_string().trim_space() + '/' + this.rest_base.to_string().trim_space())
	if !(relative_path == '') {
		// unsupported expression: Expr_AssignOp_Concat
	}
	return (var_path).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) init(mut var_payments Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments, mut var_woopayments Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService)  {
	this.payments = var_payments.dup()
	this.woopayments = var_woopayments.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) get_onboarding_details(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_location := var_request.get_param(rt.new_string('location'))
	if !rt.is_true(var_location) {
		var_location = rt.call_method(this.payments, 'get_country', []rt.PhpVal{})
	}
	mut var_source := var_request.get_param(rt.new_string('source'))
	mut var_onboarding_details := rt.call_method(this.woopayments, 'get_onboarding_details', [var_location.dup(), this.get_rest_url_path('onboarding'), var_source.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException') {
		mut var_e := var_e_1.dup()
		return create_wp_error(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) }]))
		unsafe { goto end_label_1 }
	}
	else if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		return create_wp_error(rt.new_string('woocommerce_rest_woopayments_onboarding_error'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: Class_WP_Http.internal_server_error() }]))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.call_function('rest_ensure_response', [this.prepare_onboarding_details_response(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](var_onboarding_details))])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) handle_onboarding_step_start(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_step_id := if !(var_request.get_param(rt.new_string('step'))).is_null() { var_request.get_param(rt.new_string('step')) } else { rt.new_string('') }
	mut var_location := var_request.get_param(rt.new_string('location'))
	if !rt.is_true(var_location) {
		var_location = rt.call_method(this.payments, 'get_country', []rt.PhpVal{})
	}
	mut var_source := var_request.get_param(rt.new_string('source'))
	mut var_previous_status := rt.call_method(this.woopayments, 'get_onboarding_step_status', [var_step_id.dup(), var_location.dup()])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	rt.call_method(this.woopayments, 'mark_onboarding_step_started', [var_step_id.dup(), var_location.dup(), rt.new_bool(false), var_source.dup()])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_response := rt.create_array([rt.ArrayItem{ key: 'success', val: true }, rt.ArrayItem{ key: 'previous_status', val: var_previous_status }, rt.ArrayItem{ key: 'current_status', val: rt.call_method(this.woopayments, 'get_onboarding_step_status', [var_step_id.dup(), var_location.dup()]) }])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException') {
		mut var_e := var_e_2.dup()
		return create_wp_error(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) }]))
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return rt.call_function('rest_ensure_response', [var_response.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) handle_onboarding_step_save(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_step_id := if !(var_request.get_param(rt.new_string('step'))).is_null() { var_request.get_param(rt.new_string('step')) } else { rt.new_string('') }
	mut var_location := var_request.get_param(rt.new_string('location'))
	if !rt.is_true(var_location) {
		var_location = rt.call_method(this.payments, 'get_country', []rt.PhpVal{})
	}
	mut var_source := var_request.get_param(rt.new_string('source'))
	rt.call_method(this.woopayments, 'onboarding_step_save', [var_step_id.dup(), var_location.dup(), var_request.get_params()])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	rt.call_method(this.woopayments, 'mark_onboarding_step_started', [var_step_id.dup(), var_location.dup(), rt.new_bool(false), var_source.dup()])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException') {
		mut var_e := var_e_3.dup()
		return create_wp_error(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) }]))
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	return rt.call_function('rest_ensure_response', [rt.create_array([rt.ArrayItem{ key: 'success', val: true }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) handle_onboarding_step_check(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_step_id := if !(var_request.get_param(rt.new_string('step'))).is_null() { var_request.get_param(rt.new_string('step')) } else { rt.new_string('') }
	mut var_location := var_request.get_param(rt.new_string('location'))
	if !rt.is_true(var_location) {
		var_location = rt.call_method(this.payments, 'get_country', []rt.PhpVal{})
	}
	mut var_result := rt.call_method(this.woopayments, 'onboarding_step_check', [var_step_id.dup(), var_location.dup()])
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	unsafe { goto end_label_4 }

catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException') {
		mut var_e := var_e_4.dup()
		return create_wp_error(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) }]))
		unsafe { goto end_label_4 }
	}
	else {
		rt.throw_exception(var_e_4)
		unsafe { goto end_label_4 }
	}

end_label_4:
	mut var_response := rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'success', val: true }]), var_result.dup()])
	return rt.call_function('rest_ensure_response', [var_response.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) handle_onboarding_step_finish(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_step_id := if !(var_request.get_param(rt.new_string('step'))).is_null() { var_request.get_param(rt.new_string('step')) } else { rt.new_string('') }
	mut var_location := var_request.get_param(rt.new_string('location'))
	if !rt.is_true(var_location) {
		var_location = rt.call_method(this.payments, 'get_country', []rt.PhpVal{})
	}
	mut var_source := var_request.get_param(rt.new_string('source'))
	mut var_previous_status := rt.call_method(this.woopayments, 'get_onboarding_step_status', [var_step_id.dup(), var_location.dup()])
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	rt.call_method(this.woopayments, 'mark_onboarding_step_completed', [var_step_id.dup(), var_location.dup(), rt.new_bool(false), var_source.dup()])
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	mut var_response := rt.create_array([rt.ArrayItem{ key: 'success', val: true }, rt.ArrayItem{ key: 'previous_status', val: var_previous_status }, rt.ArrayItem{ key: 'current_status', val: rt.call_method(this.woopayments, 'get_onboarding_step_status', [var_step_id.dup(), var_location.dup()]) }])
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	unsafe { goto end_label_5 }

catch_label_5:
	mut var_e_5 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_5, 'Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException') {
		mut var_e := var_e_5.dup()
		return create_wp_error(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) }]))
		unsafe { goto end_label_5 }
	}
	else {
		rt.throw_exception(var_e_5)
		unsafe { goto end_label_5 }
	}

end_label_5:
	return rt.call_function('rest_ensure_response', [var_response.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) handle_onboarding_step_clean(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_step_id := if !(var_request.get_param(rt.new_string('step'))).is_null() { var_request.get_param(rt.new_string('step')) } else { rt.new_string('') }
	mut var_location := var_request.get_param(rt.new_string('location'))
	if !rt.is_true(var_location) {
		var_location = rt.call_method(this.payments, 'get_country', []rt.PhpVal{})
	}
	mut var_previous_status := rt.call_method(this.woopayments, 'get_onboarding_step_status', [var_step_id.dup(), var_location.dup()])
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	rt.call_method(this.woopayments, 'clean_onboarding_step_progress', [var_step_id.dup(), var_location.dup()])
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	mut var_response := rt.create_array([rt.ArrayItem{ key: 'success', val: true }, rt.ArrayItem{ key: 'previous_status', val: var_previous_status }, rt.ArrayItem{ key: 'current_status', val: rt.call_method(this.woopayments, 'get_onboarding_step_status', [var_step_id.dup(), var_location.dup()]) }])
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	unsafe { goto end_label_6 }

catch_label_6:
	mut var_e_6 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_6, 'Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException') {
		mut var_e := var_e_6.dup()
		return create_wp_error(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) }]))
		unsafe { goto end_label_6 }
	}
	else {
		rt.throw_exception(var_e_6)
		unsafe { goto end_label_6 }
	}

end_label_6:
	return rt.call_function('rest_ensure_response', [var_response.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) handle_onboarding_test_account_init(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_location := var_request.get_param(rt.new_string('location'))
	if !rt.is_true(var_location) {
		var_location = rt.call_method(this.payments, 'get_country', []rt.PhpVal{})
	}
	mut var_source := var_request.get_param(rt.new_string('source'))
	rt.call_method(this.woopayments, 'mark_onboarding_step_started', [Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account(), var_location.dup(), rt.new_bool(false), var_source.dup()])
	if rt.has_exception() { unsafe { goto catch_label_7 } }
	mut var_result := rt.call_method(this.woopayments, 'onboarding_test_account_init', [var_location.dup(), var_source.dup()])
	if rt.has_exception() { unsafe { goto catch_label_7 } }
	unsafe { goto end_label_7 }

catch_label_7:
	mut var_e_7 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_7, 'Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException') {
		mut var_e := var_e_7.dup()
		return create_wp_error(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) }]))
		unsafe { goto end_label_7 }
	}
	else {
		rt.throw_exception(var_e_7)
		unsafe { goto end_label_7 }
	}

end_label_7:
	return rt.call_function('rest_ensure_response', [rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'success', val: true }]), var_result.dup()])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) handle_onboarding_test_account_reset(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_location := var_request.get_param(rt.new_string('location'))
	if !rt.is_true(var_location) {
		var_location = rt.call_method(, 'get_country', []rt.PhpVal{})
	}
	mut var_source := .get_param(rt.new_string())
	.set_param(rt.new_string(), .dup())
	
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) handle_onboarding_business_verification_kyc_session_init(mut var_request Class_WP_REST_Request) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) handle_onboarding_business_verification_kyc_session_finish(mut var_request Class_WP_REST_Request) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) handle_onboarding_preload(mut var_request Class_WP_REST_Request) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) reset_onboarding(mut var_request Class_WP_REST_Request) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) handle_test_account_disable(mut var_request Class_WP_REST_Request) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) get_woopay_eligibility() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) check_permissions(mut var_request Class_WP_REST_Request) bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) check_location_arg(var_value rt.PhpVal, mut var_request Class_WP_REST_Request) bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) prepare_onboarding_details_response(mut var_response Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array) rt.PhpVal {
	mut var_response_mutated := var_response
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) prepare_onboarding_details_response_recursive(var_response_item rt.PhpVal, mut var_schema Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array) rt.PhpVal {
	mut var_item := rt.new_null()
	mut var_schema_mutated := var_schema
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) get_schema_for_get_onboarding_details() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController) get_schema_properties_for_onboarding_step_action() rt.PhpVal {
}

struct Class_Automattic_WooCommerce_Internal_RestApiControllerBase {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_settings_paymentsproviders_woopayments_woopaymentsrestcontroller() &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController{
		PhpObjectBase: rt.PhpObjectBase{}
		route_namespace: rt.new_string('wc-admin')
		rest_base: rt.new_string('settings/payments/woopayments')
		payments: rt.new_null()
		woopayments: rt.new_null()
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService](if args.len > 1 { args[1] } else { rt.new_null() })
			this.init(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_onboarding_details' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_onboarding_details(mut dispatch_arg_0)
		}
		'handle_onboarding_step_start' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.handle_onboarding_step_start(mut dispatch_arg_0)
		}
		'handle_onboarding_step_save' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.handle_onboarding_step_save(mut dispatch_arg_0)
		}
		'handle_onboarding_step_check' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.handle_onboarding_step_check(mut dispatch_arg_0)
		}
		'handle_onboarding_step_finish' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.handle_onboarding_step_finish(mut dispatch_arg_0)
		}
		'handle_onboarding_step_clean' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.handle_onboarding_step_clean(mut dispatch_arg_0)
		}
		'handle_onboarding_test_account_init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.handle_onboarding_test_account_init(mut dispatch_arg_0)
		}
		'handle_onboarding_test_account_reset' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.handle_onboarding_test_account_reset(mut dispatch_arg_0)
		}
		'handle_onboarding_business_verification_kyc_session_init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.handle_onboarding_business_verification_kyc_session_init(mut dispatch_arg_0)
		}
		'handle_onboarding_business_verification_kyc_session_finish' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.handle_onboarding_business_verification_kyc_session_finish(mut dispatch_arg_0)
		}
		'handle_onboarding_preload' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.handle_onboarding_preload(mut dispatch_arg_0)
		}
		'reset_onboarding' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.reset_onboarding(mut dispatch_arg_0)
		}
		'handle_test_account_disable' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.handle_test_account_disable(mut dispatch_arg_0)
		}
		'get_woopay_eligibility' {
			return this.get_woopay_eligibility()
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
		'prepare_onboarding_details_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.prepare_onboarding_details_response(mut dispatch_arg_0)
		}
		'prepare_onboarding_details_response_recursive' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.prepare_onboarding_details_response_recursive(dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_schema_for_get_onboarding_details' {
			return this.get_schema_for_get_onboarding_details()
		}
		'get_schema_properties_for_onboarding_step_action' {
			return this.get_schema_properties_for_onboarding_step_action()
		}
		else { return none }
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
		'route_namespace' { this.route_namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		'payments' { this.payments = val; return true }
		'woopayments' { this.woopayments = val; return true }
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




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_settings_paymentsproviders_woopayments_woopaymentsrestcontroller_php() {
	// unsupported statement: Stmt_Declare
}
