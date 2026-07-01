import rt

struct Class_Automattic_WooCommerce_Admin_API_OnboardingProfile {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc-admin')
		rest_base rt.PhpVal = rt.new_string('onboarding/profile')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingProfile) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingProfile', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingProfile', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingProfile', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingProfile', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingProfile', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingProfile', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/experimental_get_email_prefill', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingProfile', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_email_prefill' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingProfile', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingProfile', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/progress', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingProfile', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_profile_progress' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingProfile', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/progress/core-profiler/complete', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingProfile', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'core_profiler_step_complete' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingProfile', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'step', val: rt.create_array([rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The Core Profiler step to mark as complete.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'intro-opt-in' }, rt.ArrayItem{ key: none, val: 'skip-guided-setup' }, rt.ArrayItem{ key: none, val: 'user-profile' }, rt.ArrayItem{ key: none, val: 'business-info' }, rt.ArrayItem{ key: none, val: 'plugins' }, rt.ArrayItem{ key: none, val: 'intro-builder' }, rt.ArrayItem{ key: none, val: 'skip-guided-setup' }]) }]) }]) }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/update-store-currency-and-measurement-units', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: 'POST' }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingProfile', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_store_currency_and_measurement_units' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingProfile', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'country_code', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Country code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: true }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingProfile', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingProfile) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [rt.new_string('settings'), rt.new_string('read')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot list resources.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingProfile) update_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [rt.new_string('settings'), rt.new_string('edit')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot edit this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingProfile) get_items(var_request rt.PhpVal) rt.PhpVal {
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/helper/class-wc-helper-options.php', '2')
	mut var_onboarding_data := rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.data_option(), rt.new_array()])
	var_onboarding_data.array_set('industry', if var_onboarding_data.array_isset(rt.new_string('industry')) { this.filter_industries(var_onboarding_data.array_get('industry')) } else { rt.new_null() })
	mut var_item_schema := this.get_item_schema()
	mut var_items := rt.new_array()
	{
		mut iter_1 := var_item_schema.array_get('properties').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_property_schema := item_1.val
			mut var_key := item_1.key
			var_items.array_set(var_key, if var_onboarding_data.array_isset(var_key) { var_onboarding_data.array_get(var_key) } else { rt.new_null() })
		}
	}
	mut var_wccom_auth := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_WC_Helper_Options{}; return temp.get(arg_0) }(rt.new_string('auth'))
	var_items.array_set('wccom_connected', if !rt.is_true(var_wccom_auth.array_get('access_token')) { false } else { true })
	mut var_item := this.prepare_item_for_response(var_items.dup(), var_request.dup())
	mut var_data := this.prepare_response_for_collection(var_item.dup())
	return rt.call_function('rest_ensure_response', [var_data.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingProfile) filter_industries(var_industries rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_onboarding_industries'), var_industries.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingProfile) update_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_params := rt.call_method(var_request, 'get_json_params', []rt.PhpVal{})
	mut var_query_args := this.prepare_objects_query(var_params.dup())
	mut var_onboarding_data := rt.cast_array(rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.data_option(), rt.new_array()]))
	mut var_profile_data := rt.call_function('array_merge', [var_onboarding_data.dup(), var_query_args.dup()])
	rt.call_function('update_option', [Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.data_option(), var_profile_data.dup()])
	rt.call_function('do_action', [rt.new_string('woocommerce_onboarding_profile_data_updated'), var_onboarding_data.dup(), var_query_args.dup()])
	mut var_result := rt.create_array([rt.ArrayItem{ key: 'status', val: 'success' }, rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('Onboarding profile data has been updated.'), rt.new_string('woocommerce')]) }])
	mut var_response := this.prepare_item_for_response(var_result.dup(), var_request.dup())
	mut var_data := this.prepare_response_for_collection(var_response.dup())
	return rt.call_function('rest_ensure_response', [var_data.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingProfile) get_email_prefill(var_request rt.PhpVal) rt.PhpVal {
	mut var_result := rt.create_array([rt.ArrayItem{ key: 'email', val: '' }])
	if rt.is_true(rt.call_function('class_exists', [Class_Automattic_Jetpack_Connection_Manager.class()])) {
		mut var_jetpack_connection_manager := create_automattic_jetpack_connection_manager()
		if rt.is_true(var_jetpack_connection_manager.is_active()) {
			mut var_jetpack_user := var_jetpack_connection_manager.get_connected_user_data()
			var_result.array_set('email', var_jetpack_user.array_get('email'))
		}
	}
	if !rt.is_true(var_result.array_get('email')) {
		var_result.array_set('email', rt.call_function('get_option', [rt.new_string('admin_email')]))
	}
	return rt.call_function('rest_ensure_response', [var_result.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingProfile) core_profiler_step_complete(var_request rt.PhpVal) rt.PhpVal {
	mut var_json := rt.call_method(var_request, 'get_json_params', []rt.PhpVal{})
	mut var_step := var_json.array_get('step')
	mut var_onboarding_progress := rt.cast_array(rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.progress_option(), rt.new_array()]))
	if !(var_onboarding_progress.array_isset(rt.new_string('core_profiler_completed_steps'))) {
		var_onboarding_progress.array_set('core_profiler_completed_steps', rt.new_array())
	}
	var_onboarding_progress.array_get_mut('core_profiler_completed_steps').array_set(var_step, rt.create_array([rt.ArrayItem{ key: 'completed_at', val: rt.call_function('gmdate', [rt.new_string('Y-m-d\\TH:i:s\\Z')]) }]))
	rt.call_function('update_option', [Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.progress_option(), var_onboarding_progress.dup()])
	rt.call_function('do_action', [rt.new_string('woocommerce_core_profiler_step_complete'), var_step.dup()])
	mut var_response_data := rt.create_array([rt.ArrayItem{ key: 'results', val: var_onboarding_progress }, rt.ArrayItem{ key: 'status', val: 'success' }])
	mut var_response := rt.call_function('rest_ensure_response', [var_response_data.dup()])
	return var_response.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingProfile) get_profile_progress(var_request rt.PhpVal) rt.PhpVal {
	mut var_onboarding_progress := rt.cast_array(rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.progress_option(), rt.new_array()]))
	return rt.call_function('rest_ensure_response', [var_onboarding_progress.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingProfile) update_store_currency_and_measurement_units(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_country_code := var_request.get_param(rt.new_string('country_code'))
	mut var_locale_info := rt.include_file((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() + '/i18n/locale-info.php', '1')
	if !rt.is_true(var_country_code) || !(var_locale_info.array_isset(var_country_code)) {
		return create_wp_error(rt.new_string('woocommerce_rest_invalid_country_code'), rt.call_function('__', [rt.new_string('Invalid country code.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_country_info := var_locale_info.array_get(var_country_code)
	mut var_currency_settings := rt.create_array([rt.ArrayItem{ key: 'woocommerce_currency', val: var_country_info.array_get('currency_code') }, rt.ArrayItem{ key: 'woocommerce_currency_pos', val: var_country_info.array_get('currency_pos') }, rt.ArrayItem{ key: 'woocommerce_price_thousand_sep', val: var_country_info.array_get('thousand_sep') }, rt.ArrayItem{ key: 'woocommerce_price_decimal_sep', val: var_country_info.array_get('decimal_sep') }, rt.ArrayItem{ key: 'woocommerce_price_num_decimals', val: var_country_info.array_get('num_decimals') }, rt.ArrayItem{ key: 'woocommerce_weight_unit', val: var_country_info.array_get('weight_unit') }, rt.ArrayItem{ key: 'woocommerce_dimension_unit', val: var_country_info.array_get('dimension_unit') }])
	{
		mut iter_1 := var_currency_settings.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			rt.call_function('update_option', [var_key.dup(), var_value.dup()])
		}
	}
	return create_wp_rest_response(rt.new_array(), rt.new_int(204))
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingProfile) prepare_objects_query(var_params rt.PhpVal) rt.PhpVal {
	mut var_params_mutated := var_params
	mut var_args := rt.new_array()
	mut var_properties := Class_Automattic_WooCommerce_Admin_API_OnboardingProfile.get_profile_properties()
	{
		mut iter_1 := var_properties.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_property := item_1.val
			mut var_key := item_1.key
			if var_params_mutated.array_isset(var_key) {
				var_args.array_set(var_key, var_params_mutated.array_get(var_key))
			}
		}
	}
	var_args = rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_onboarding_profile_object_query'), var_args.dup(), var_params_mutated.dup()])
	return var_args.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingProfile) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	mut var_data := this.add_additional_fields_to_object(var_item_mutated.dup(), var_request.dup())
	var_data = this.filter_response_by_context(var_data.dup(), rt.new_string('view'))
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_onboarding_prepare_profile'), var_response.dup(), var_item_mutated.dup(), var_request.dup()])
}

fn Class_Automattic_WooCommerce_Admin_API_OnboardingProfile.get_profile_properties() rt.PhpVal {
	mut var_properties := rt.create_array([rt.ArrayItem{ key: 'completed', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether or not the profile was completed.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }, rt.ArrayItem{ key: 'skipped', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether or not the profile was skipped.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }, rt.ArrayItem{ key: 'industry', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Industry.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'nullable', val: true }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }, rt.ArrayItem{ key: 'business_extensions', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Extra business extensions to install.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_slug_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }, rt.ArrayItem{ key: 'is_agree_marketing', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether or not this store agreed to receiving marketing contents from WooCommerce.com.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }, rt.ArrayItem{ key: 'store_email', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Store email address.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'nullable', val: true }, rt.ArrayItem{ key: 'validate_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'rest_validate_marketing_email' }]) }]) }, rt.ArrayItem{ key: 'is_store_country_set', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether or not this store country is set via onboarding profiler.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }, rt.ArrayItem{ key: 'is_plugins_page_skipped', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether or not plugins step in core profiler was skipped.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }, rt.ArrayItem{ key: 'business_choice', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Business choice.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'nullable', val: true }]) }, rt.ArrayItem{ key: 'selling_online_answer', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Selling online answer.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'nullable', val: true }]) }, rt.ArrayItem{ key: 'selling_platforms', val: rt.create_array([rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'array' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Selling platforms.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'nullable', val: true }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'null' }]) }]) }]) }])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_onboarding_profile_properties'), var_properties.dup()])
}

fn Class_Automattic_WooCommerce_Admin_API_OnboardingProfile.rest_validate_marketing_email(var_value rt.PhpVal, var_request rt.PhpVal, var_param rt.PhpVal) bool {
	mut var_is_agree_marketing := rt.call_method(var_request, 'get_param', [rt.new_string('is_agree_marketing')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_is_agree_marketing) || !(!rt.is_true(var_value)))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [var_value.dup()]))))))) {
		return (create_wp_error(rt.new_string('rest_invalid_email'), rt.call_function('__', [rt.new_string('Invalid email address'), rt.new_string('woocommerce')]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingProfile) get_item_schema() rt.PhpVal {
	mut var_properties := Class_Automattic_WooCommerce_Admin_API_OnboardingProfile.get_profile_properties()
	{
		mut iter_1 := var_properties.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_property := item_1.val
			mut var_key := item_1.key
			var_properties.array_get(var_key).array_unset(rt.new_string('default'))
			var_properties.array_get(var_key).array_unset(rt.new_string('items'))
			var_properties.array_get(var_key).array_unset(rt.new_string('validate_callback'))
			var_properties.array_get(var_key).array_unset(rt.new_string('sanitize_callback'))
		}
	}
	mut var_schema := rt.create_array([rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' }, rt.ArrayItem{ key: 'title', val: 'onboarding_profile' }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: var_properties }])
	return this.add_additional_fields_schema(var_schema.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingProfile) get_collection_params() rt.PhpVal {
	mut var_params := Class_Automattic_WooCommerce_Admin_API_OnboardingProfile.get_profile_properties()
	{
		mut iter_1 := var_params.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_param := item_1.val
			mut var_key := item_1.key
			var_params.array_get(var_key).array_unset(rt.new_string('context'))
			var_params.array_get(var_key).array_unset(rt.new_string('readonly'))
		}
	}
	var_params.array_set('context', this.get_context_param(rt.create_array([rt.ArrayItem{ key: , val:  }])))
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_onboarding_profile_collection_params'), var_params.dup()])
}

struct Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_WC_Helper_Options {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Connection_Manager {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_onboardingprofile() &Class_Automattic_WooCommerce_Admin_API_OnboardingProfile {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_OnboardingProfile{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc-admin')
		rest_base: rt.new_string('onboarding/profile')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_rest_data_controller() &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller{
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

fn create_automattic_woocommerce_admin_api_wc_helper_options() &Class_Automattic_WooCommerce_Admin_API_WC_Helper_Options {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_Helper_Options{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_connection_manager() &Class_Automattic_Jetpack_Connection_Manager {
	mut obj := &Class_Automattic_Jetpack_Connection_Manager{
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingProfile) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'update_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.update_items_permissions_check(dispatch_arg_0))
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'filter_industries' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_industries(dispatch_arg_0)
		}
		'update_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_items(dispatch_arg_0)
		}
		'get_email_prefill' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_email_prefill(dispatch_arg_0)
		}
		'core_profiler_step_complete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.core_profiler_step_complete(dispatch_arg_0)
		}
		'get_profile_progress' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_profile_progress(dispatch_arg_0)
		}
		'update_store_currency_and_measurement_units' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.update_store_currency_and_measurement_units(mut dispatch_arg_0)
		}
		'prepare_objects_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_objects_query(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_profile_properties' {
			return Class_Automattic_WooCommerce_Admin_API_OnboardingProfile.get_profile_properties()
		}
		'rest_validate_marketing_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_API_OnboardingProfile.rest_validate_marketing_email(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_OnboardingProfile) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingProfile) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_Helper_Options) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WC_Helper_Options) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_Helper_Options) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_Jetpack_Connection_Manager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Connection_Manager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Connection_Manager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_admin_api_onboardingprofile_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
