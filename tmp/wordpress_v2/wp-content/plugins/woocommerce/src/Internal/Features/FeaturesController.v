import rt

pub fn Class_Automattic_WooCommerce_Internal_Features_FeaturesController.feature_enabled_changed_action() string {
	return 'woocommerce_feature_enabled_changed'
}
pub fn Class_Automattic_WooCommerce_Internal_Features_FeaturesController.plugins_compatible_by_default_option() string {
	return 'woocommerce_plugins_are_compatible_with_features_by_default'
}
struct Class_Automattic_WooCommerce_Internal_Features_FeaturesController {
	rt.PhpObjectBase
pub mut:
		features rt.PhpVal = rt.new_array()
		compatibility_info_by_plugin rt.PhpVal = rt.new_array()
		compatibility_info_by_feature rt.PhpVal = rt.new_array()
		pending_declarations rt.PhpVal = rt.new_array()
		proxy rt.PhpVal = rt.new_null()
		plugin_util rt.PhpVal = rt.new_null()
		force_allow_enabling_features bool
		force_allow_enabling_plugins bool
		plugins_excluded_from_compatibility_ui rt.PhpVal = rt.new_null()
		registered_additional_features_via_action bool
		registered_additional_features_via_class_calls bool
		lazy bool
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) construct() {
	if !(this.registered_additional_features_via_action) {
		if rt.is_true(rt.call_function('did_action', [rt.new_string('before_woocommerce_init')])) {
			this.register_additional_features()
		} else {
			rt.call_function('add_filter', [rt.new_string('before_woocommerce_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Features_FeaturesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_additional_features' }]), rt.new_int(-9999), rt.new_int(0)])
		}
	}
	if rt.is_true(rt.call_function('did_action', [rt.new_string('init')])) {
		this.start_listening_for_option_changes()
	} else {
		rt.call_function('add_filter', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Features_FeaturesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'start_listening_for_option_changes' }]), rt.new_int(10), rt.new_int(0)])
	}
	rt.call_function('add_filter', [rt.new_string('woocommerce_get_sections_advanced'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Features_FeaturesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_features_section' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_get_settings_advanced'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Features_FeaturesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_feature_settings' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('deactivated_plugin'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Features_FeaturesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_plugin_deactivation' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('all_plugins'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Features_FeaturesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'filter_plugins_list' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('admin_notices'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Features_FeaturesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'display_notices_in_plugins_page' }]), rt.new_int(10), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('load-plugins.php'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Features_FeaturesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'maybe_invalidate_cached_plugin_data' }])])
	rt.call_function('add_action', [rt.new_string('after_plugin_row'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Features_FeaturesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_plugin_list_rows' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('current_screen'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Features_FeaturesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'enqueue_script_to_fix_plugin_list_html' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('views_plugins'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Features_FeaturesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_plugins_page_views_list' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_admin_shared_settings'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Features_FeaturesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'set_change_feature_enable_nonce' }]), rt.new_int(20), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('admin_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Features_FeaturesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'change_feature_enable_from_query_params' }]), rt.new_int(20), rt.new_int(0)])
	rt.call_function('add_action', [Class_Automattic_WooCommerce_Internal_Features_Automattic_WooCommerce_Internal_Features_FeaturesController.feature_enabled_changed_action(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Features_FeaturesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'display_email_improvements_feedback_notice' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) add_feature_definition(var_slug rt.PhpVal, var_name rt.PhpVal, mut var_args Class_Automattic_WooCommerce_Internal_Features_array) {
	mut var_args_mutated := var_args
	mut var_defaults := rt.create_array([rt.ArrayItem{ key: 'disable_ui', val: false }, rt.ArrayItem{ key: 'enabled_by_default', val: false }, rt.ArrayItem{ key: 'is_experimental', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: false }, rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'order', val: 10 }, rt.ArrayItem{ key: 'learn_more_url', val: '' }])
	if !rt.is_true(var_args_mutated.array_get(rt.new_string('default_plugin_compatibility'))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.new_string('Assuming positive compatibility by default will be deprecated in the future. Please set \'default_plugin_compatibility\' for feature "%s".'), rt.call_function('esc_html', [var_slug.clone()])]), rt.new_string('10.3.0')])
	}
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated, var_defaults.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_args_mutated.array_get(rt.new_string('default_plugin_compatibility')), Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.valid_registration_values(), rt.new_bool(true)]))))) {
		var_args_mutated.array_set('default_plugin_compatibility', if rt.is_true(rt.call_function('wc_string_to_bool', [var_args_mutated.array_get(rt.new_string('default_plugin_compatibility'))])) { Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() } else { Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.incompatible() })
	}
	if !(!rt.is_true(var_args_mutated.array_get(rt.new_string('is_legacy')))) {
		var_args_mutated.array_set('skip_compatibility_checks', true)
	}
	this.features.array_set(var_slug, var_args_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) get_feature_definitions() rt.PhpVal {
	if !rt.is_true(this.features) {
		this.init_feature_definitions()
	}
	if !(this.registered_additional_features_via_class_calls) {
		this.registered_additional_features_via_class_calls = true
		mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
		rt.call_method(rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.class()]), 'add_feature_definition', [rt.new_object('Automattic_WooCommerce_Internal_Features_FeaturesController', []string{}, &this)])
		rt.call_method(rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController.class()]), 'add_feature_definition', [rt.new_object('Automattic_WooCommerce_Internal_Features_FeaturesController', []string{}, &this)])
		this.init_compatibility_info_by_feature()
	}
	return this.features
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) init_feature_definitions() {
	mut iife_temp_0 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_0 := iife_temp_0.is_true(rt.new_string('WOOCOMMERCE_ENABLE_ALPHA_FEATURE_TESTING'))
	mut var_alpha_feature_testing_is_enabled := iife_result_0
	mut iife_temp_1 := Class_WC_Site_Tracking{}
	mut iife_result_1 := iife_temp_1.is_tracking_enabled()
	mut var_tracking_enabled := iife_result_1
	closure_3_fn := fn [var_tracking_enabled] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
		}
	closure_4_fn := fn [var_tracking_enabled] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_tracking_enabled)))) {
			return
		}
		return
		}
	mut var_legacy_features := rt.create_array([rt.ArrayItem{ key: 'analytics', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Analytics'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Enable WooCommerce Analytics'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'option_key', val: Class_Automattic_WooCommerce_Internal_Admin_Analytics.toggle_option_name() }, rt.ArrayItem{ key: 'is_experimental', val: false }, rt.ArrayItem{ key: 'enabled_by_default', val: true }, rt.ArrayItem{ key: 'disable_ui', val: false }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }]) }, rt.ArrayItem{ key: 'product_block_editor', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('New product editor'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Try the new product editor (Beta)'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'is_experimental', val: true }, rt.ArrayItem{ key: 'disable_ui', val: false }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }]) }, rt.ArrayItem{ key: 'cart_checkout_blocks', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Cart & Checkout Blocks'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Optimize for faster checkout'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'is_experimental', val: false }, rt.ArrayItem{ key: 'disable_ui', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }]) }, rt.ArrayItem{ key: 'rate_limit_checkout', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Rate limit Checkout'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Enables rate limiting for Checkout place order and Store API /checkout endpoint. To further control this, refer to <a href="%s" target="_blank">rate limiting documentation</a>.'), rt.new_string('woocommerce')]), rt.new_string('https://developer.woocommerce.com/docs/apis/store-api/rate-limiting/')]) }, rt.ArrayItem{ key: 'is_experimental', val: false }, rt.ArrayItem{ key: 'disable_ui', val: false }, rt.ArrayItem{ key: 'enabled_by_default', val: false }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }]) }, rt.ArrayItem{ key: 'marketplace', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Marketplace'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('New, faster way to find extensions and themes for your WooCommerce store'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'is_experimental', val: false }, rt.ArrayItem{ key: 'enabled_by_default', val: true }, rt.ArrayItem{ key: 'disable_ui', val: true }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'deprecated_since', val: '10.5.0' }, rt.ArrayItem{ key: 'deprecated_value', val: true }]) }, rt.ArrayItem{ key: 'order_attribution', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Order Attribution'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Enable this feature to track and credit channels and campaigns that contribute to orders on your site'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'enabled_by_default', val: true }, rt.ArrayItem{ key: 'disable_ui', val: false }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'is_experimental', val: false }]) }, rt.ArrayItem{ key: 'site_visibility_badge', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Site visibility badge'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Enable the site visibility badge in the WordPress admin bar'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'enabled_by_default', val: true }, rt.ArrayItem{ key: 'disable_ui', val: false }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'is_experimental', val: false }, rt.ArrayItem{ key: 'disabled', val: false }]) }, rt.ArrayItem{ key: 'hpos_fts_indexes', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('HPOS Full text search indexes'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Create and use full text search indexes for orders. This feature only works with high-performance order storage.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'is_experimental', val: true }, rt.ArrayItem{ key: 'enabled_by_default', val: false }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'option_key', val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.hpos_fts_index_option() }]) }, rt.ArrayItem{ key: 'hpos_datastore_caching', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('HPOS Data Caching'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Enable order data caching in the datastore. This feature only works with high-performance order storage and is recommended for stores using object caching.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'is_experimental', val: false }, rt.ArrayItem{ key: 'enabled_by_default', val: false }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'disable_ui', val: false }, rt.ArrayItem{ key: 'option_key', val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.hpos_datastore_caching_enabled_option() }]) }, rt.ArrayItem{ key: 'remote_logging', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Remote Logging'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Allow WooCommerce to send error logs and non-sensitive diagnostic data to help improve WooCommerce. This feature requires %1$susage tracking%2$s to be enabled.'), rt.new_string('woocommerce')]), rt.new_string('<a href="' + (rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=advanced&section=woocommerce_com')])).str() + '">'), rt.new_string('</a>')]) }, rt.ArrayItem{ key: 'enabled_by_default', val: true }, rt.ArrayItem{ key: 'disable_ui', val: false }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'is_experimental', val: false }, rt.ArrayItem{ key: 'setting', val: rt.create_array([rt.ArrayItem{ key: 'disabled', val: rt.new_closure(closure_3_fn) }, rt.ArrayItem{ key: 'desc_tip', val: rt.new_closure(closure_4_fn) }]) }]) }, rt.ArrayItem{ key: 'deferred_transactional_emails', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Deferred emails'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Send transactional emails asynchronously via Action Scheduler instead of during the current request.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'enabled_by_default', val: false }, rt.ArrayItem{ key: 'is_experimental', val: false }]) }, rt.ArrayItem{ key: 'customer_review_request', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Customer review request (beta)'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Send customers a transactional email after order completion inviting them to review the products they bought, and host the per-order Review Order landing page.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'enabled_by_default', val: false }, rt.ArrayItem{ key: 'is_experimental', val: false }]) }, rt.ArrayItem{ key: 'email_improvements', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Email improvements'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Enable modern email design for transactional emails'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'is_experimental', val: false }]) }, rt.ArrayItem{ key: 'blueprint', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Blueprint (beta)'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Enable blueprint to import and export settings in bulk'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'enabled_by_default', val: true }, rt.ArrayItem{ key: 'disable_ui', val: false }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'is_experimental', val: false }]) }, rt.ArrayItem{ key: 'block_email_editor', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Block Email Editor (alpha)'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Enable the block-based email editor for transactional emails.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'learn_more_url', val: 'https://github.com/woocommerce/woocommerce/discussions/52897#discussioncomment-11630256' }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'enabled_by_default', val: false }]) }, rt.ArrayItem{ key: 'point_of_sale', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Point of Sale'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Enable Point of Sale functionality in the WooCommerce mobile apps.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'enabled_by_default', val: true }, rt.ArrayItem{ key: 'disable_ui', val: false }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'is_experimental', val: true }]) }, rt.ArrayItem{ key: 'fulfillments', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Order Fulfillments'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Enable the Order Fulfillments feature to manage order fulfillment and shipping.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'enabled_by_default', val: false }, rt.ArrayItem{ key: 'disable_ui', val: true }, rt.ArrayItem{ key: 'is_experimental', val: false }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }]) }, rt.ArrayItem{ key: 'mcp_integration', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('WooCommerce MCP'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: this.get_mcp_integration_description() }, rt.ArrayItem{ key: 'enabled_by_default', val: false }, rt.ArrayItem{ key: 'disable_ui', val: false }, rt.ArrayItem{ key: 'is_experimental', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'is_legacy', val: false }]) }, rt.ArrayItem{ key: 'destroy-empty-sessions', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Clear Customer Sessions When Empty'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('[Performance] Removes session cookies for non-logged in customers when session data is empty, improving page caching performance. May cause compatibility issues with extensions that depend on the session cookie without using session data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'enabled_by_default', val: false }, rt.ArrayItem{ key: 'is_experimental', val: true }, rt.ArrayItem{ key: 'disable_ui', val: false }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }]) }, rt.ArrayItem{ key: 'agentic_checkout', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Agentic Checkout API'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Enable the Agentic Checkout API for AI-powered checkout experiences (e.g., ChatGPT). This adds REST API endpoints that allow AI agents to create and manage checkout sessions.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'enabled_by_default', val: false }, rt.ArrayItem{ key: 'is_experimental', val: true }, rt.ArrayItem{ key: 'disable_ui', val: true }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }]) }, rt.ArrayItem{ key: 'dual_code_graphql_api', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Dual Code & GraphQL API'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Experimental code-first API for WooCommerce with automatic GraphQL endpoint generation. Requires PHP 8.1 or later.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'enabled_by_default', val: false }, rt.ArrayItem{ key: 'is_experimental', val: true }, rt.ArrayItem{ key: 'disable_ui', val: true }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications.feature_name(), val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Push Notifications'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Enable push notifications for the WooCommerce mobile apps to receive order notifications and store updates.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'enabled_by_default', val: false }, rt.ArrayItem{ key: 'is_experimental', val: true }, rt.ArrayItem{ key: 'disable_ui', val: true }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: false }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }]) }, rt.ArrayItem{ key: 'rest_api_caching', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('REST API Caching'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Enable backend caching and cache control headers for REST API responses via the <code>RestApiCache</code> trait. ⚙️ %1$sConfiguration%2$s'), rt.new_string('woocommerce')]), rt.new_string('<a href="' + (rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=advanced&section=rest_api_caching')])).str() + '">'), rt.new_string('</a>')]) }, rt.ArrayItem{ key: 'enabled_by_default', val: false }, rt.ArrayItem{ key: 'is_experimental', val: true }, rt.ArrayItem{ key: 'disable_ui', val: false }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Internal_Caches_ProductCacheController.feature_name(), val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Cache Product Objects'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('[Performance] Speeds up your store by caching product objects during each request, preventing duplicate product loads. Can improve page load times on product-heavy pages.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'enabled_by_default', val: false }, rt.ArrayItem{ key: 'is_experimental', val: true }, rt.ArrayItem{ key: 'disable_ui', val: false }]) }])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_tracking_enabled)))) {
		var_legacy_features.array_get_mut('remote_logging').array_get_mut('setting').array_set('value', 'no')
	}
	mut iter_1 := var_legacy_features.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_definition := item_1.val
		mut var_slug := item_1.key
		this.add_feature_definition(var_slug.clone(), var_definition.array_get(rt.new_string('name')), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Features_array](var_definition))
	}
	this.init_compatibility_info_by_feature()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) init_compatibility_info_by_feature() {
	mut iter_2 := rt.func_array_keys(this.features).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_feature_id := item_2.val
		if !(this.compatibility_info_by_feature.array_isset(var_feature_id)) {
			this.compatibility_info_by_feature.array_set(var_feature_id, rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible(), val: rt.new_array() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.incompatible(), val: rt.new_array() }]))
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) get_mcp_integration_description() string {
	mut var_base_description := rt.call_function('__', [rt.new_string('Enable WooCommerce MCP (Model Context Protocol) for AI-powered store operations. AI-generated results and actions can be unpredictable - please review before executing in your store.'), rt.new_string('woocommerce')])
	mut var_permalink_structure := rt.call_function('get_option', [rt.new_string('permalink_structure')])
	if !rt.is_true(var_permalink_structure) {
		mut var_permalinks_url := rt.call_function('admin_url', [rt.new_string('options-permalink.php')])
		mut var_permalink_warning := rt.call_function('sprintf', [rt.new_string('<br><br><strong>%s:</strong> %s <a href="%s">%s</a>'), rt.call_function('__', [rt.new_string('Configuration Required'), rt.new_string('woocommerce')]), rt.call_function('__', [rt.new_string('WordPress permalinks must be set to anything other than "Plain" for MCP to work.'), rt.new_string('woocommerce')]), var_permalinks_url.clone(), rt.call_function('__', [rt.new_string('Configure Permalinks'), rt.new_string('woocommerce')])])
		mut var_documentation_link := rt.call_function('sprintf', [rt.new_string(' <a href="%s" target="_blank">%s</a>'), rt.new_string('https://github.com/woocommerce/woocommerce/blob/trunk/docs/features/mcp/README.md'), rt.call_function('__', [rt.new_string('Learn more'), rt.new_string('woocommerce')])])
		return (var_base_description).str() + (var_permalink_warning).str() + (var_documentation_link).str()
	}
	var_documentation_link = rt.call_function('sprintf', [rt.new_string(' <a href="%s" target="_blank">%s</a>'), rt.new_string('https://github.com/woocommerce/woocommerce/blob/trunk/docs/features/mcp/README.md'), rt.call_function('__', [rt.new_string('Learn more'), rt.new_string('woocommerce')])])
	return (var_base_description).str() + (var_documentation_link).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) register_additional_features() {
	if this.registered_additional_features_via_action {
		return
	}
	if !rt.is_true(this.features) {
		this.init_feature_definitions()
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_register_feature_definitions'), rt.new_object('Automattic_WooCommerce_Internal_Features_FeaturesController', []string{}, &this)])
	this.init_compatibility_info_by_feature()
	this.registered_additional_features_via_action = true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) init(mut var_proxy Class_Automattic_WooCommerce_Proxies_LegacyProxy, mut var_plugin_util Class_Automattic_WooCommerce_Utilities_PluginUtil) {
	this.proxy = var_proxy
	this.plugin_util = var_plugin_util
	this.plugins_excluded_from_compatibility_ui = var_plugin_util.get_plugins_excluded_from_compatibility_ui()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) get_features(include_experimental bool, include_enabled_info bool) rt.PhpVal {
	mut var_features := this.get_feature_definitions()
	if !(var_include_experimental) {
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_feature := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!(rt.is_true(var_feature.array_get(rt.new_string('is_experimental')))))
		}
	var_features = rt.call_function('array_filter', [var_features.clone(), rt.new_closure(closure_5_fn)])
	}
	if var_include_enabled_info {
		mut iter_3 := rt.func_array_keys(var_features.clone()).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_feature_id := item_3.val
			mut var_is_enabled := rt.new_bool(false)
			if !(!rt.is_true(var_features.array_get(var_feature_id).array_get(rt.new_string('deprecated_since')))) {
			var_is_enabled = rt.new_bool((if !(var_features.array_get(var_feature_id).array_get(rt.new_string('deprecated_value'))).is_null() { var_features.array_get(var_feature_id).array_get(rt.new_string('deprecated_value')) } else { rt.new_bool(false) }).to_bool())
			} else {
			var_is_enabled = rt.new_bool(this.feature_is_enabled((var_feature_id).str()))
			}
			var_features.array_get_mut(var_feature_id).array_set('is_enabled', var_is_enabled.clone())
		}
	}
	if var_features.array_isset(rt.new_string('product_block_editor')) && !(this.feature_is_enabled('product_block_editor')) {
		var_features.array_get_mut('product_block_editor').array_set('disable_ui', true)
	}
	return var_features.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) get_default_plugin_compatibility(feature_id string) string {
	mut feature_id_mutated := feature_id
	mut var_feature := this.get_feature_definition(feature_id_mutated)
	if rt.is_true(rt.identical(rt.new_null(), var_feature)) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Features_InvalidArgumentException', []string{}, create_automattic_woocommerce_internal_features_invalidargumentexception(rt.call_function('esc_html', [rt.new_string("The WooCommerce feature '${var_feature_id.to_string()}' doesn't exist")]))))
	}
	mut var_default_plugin_compatibility := if !(var_feature.array_get(rt.new_string('default_plugin_compatibility'))).is_null() { var_feature.array_get(rt.new_string('default_plugin_compatibility')) } else { Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }
	mut var_incompatible_by_default := rt.new_bool((rt.call_function('apply_filters', [rt.new_string('woocommerce_plugins_are_incompatible_with_feature_by_default'), rt.identical(Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.incompatible(), var_default_plugin_compatibility), rt.new_string(feature_id_mutated).clone()])).to_bool())
	return (if rt.is_true(var_incompatible_by_default) { Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.incompatible() } else { Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) get_feature_definition(feature_id string) rt.PhpVal {
	mut feature_id_mutated := feature_id
	return if !(this.get_feature_definitions().array_get(rt.new_string(feature_id_mutated))).is_null() { this.get_feature_definitions().array_get(rt.new_string(feature_id_mutated)) } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) feature_is_enabled(feature_id string) bool {
	mut feature_id_mutated := feature_id
	mut var_feature := this.get_feature_definition(feature_id_mutated)
	if rt.is_true(rt.identical(rt.new_null(), var_feature)) {
		return false
	}
	if !(!rt.is_true(var_feature.array_get(rt.new_string('deprecated_since')))) {
		return (if !(var_feature.array_get(rt.new_string('deprecated_value'))).is_null() { var_feature.array_get(rt.new_string('deprecated_value')) } else { rt.new_bool(false) }).to_bool()
	}
	if this.is_preview_email_improvements_enabled(feature_id_mutated) {
		return true
	}
	mut var_default_value := rt.new_string((if this.feature_is_enabled_by_default(feature_id_mutated) { 'yes' } else { 'no' }).str())
	mut var_value := rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string(this.feature_enable_option_name(feature_id_mutated)), var_default_value.clone()]))
	return (var_value).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) feature_is_enabled_by_default(feature_id string) bool {
	mut feature_id_mutated := feature_id
	mut var_features := this.get_feature_definitions()
	return !(!rt.is_true(var_features.array_get(rt.new_string(feature_id_mutated)).array_get(rt.new_string('enabled_by_default'))))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) change_feature_enable(feature_id string, enable bool) bool {
	mut feature_id_mutated := feature_id
	if !(this.feature_exists(feature_id_mutated)) {
		return false
	}
	return (rt.call_function('update_option', [rt.new_string(this.feature_enable_option_name(feature_id_mutated)), rt.new_string((if var_enable { 'yes' } else { 'no' }).str()), rt.new_string('on')])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) declare_compatibility(feature_id string, plugin_file string, positive_compatibility bool) bool {
	mut feature_id_mutated := feature_id
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.proxy, 'call_function', [rt.new_string('doing_action'), rt.new_string('before_woocommerce_init')]))))) {
		mut var_class_and_method := rt.new_string((rt.call_method(create_automattic_woocommerce_internal_features_reflectionclass(rt.new_object('Automattic_WooCommerce_Internal_Features_FeaturesController', []string{}, &this)), 'getShortName', []rt.PhpVal{})).str() + '::' + @FN)
		rt.call_method(this.proxy, 'call_function', [rt.new_string('wc_doing_it_wrong'), var_class_and_method.clone(), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s should be called inside the %2$s action.'), rt.new_string('woocommerce')]), var_class_and_method.clone(), rt.new_string('before_woocommerce_init')]), rt.new_string('7.0')])
		return false
	}
	if !(this.feature_exists(feature_id_mutated)) {
		return false
	}
	if this.lazy {
		this.pending_declarations.array_push(rt.create_array([rt.ArrayItem{ key: none, val: feature_id_mutated }, rt.ArrayItem{ key: none, val: plugin_file }, rt.ArrayItem{ key: none, val: positive_compatibility }]))
		return true
	}
	return this.register_compatibility_internal(feature_id_mutated, plugin_file, positive_compatibility)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) register_compatibility_internal(feature_id string, plugin_file string, positive_compatibility bool) bool {
	mut feature_id_mutated := feature_id
	if !(this.feature_exists(feature_id_mutated)) {
		return false
	}
	mut var_plugin_id := rt.call_method(this.plugin_util, 'get_wp_plugin_id', [rt.new_string(plugin_file)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_plugin_id)))) {
		mut var_logger := rt.call_method(this.proxy, 'call_function', [rt.new_string('wc_get_logger')])
		rt.call_method(var_logger, 'error', [rt.new_string("FeaturesController: Invalid plugin file '${var_plugin_file}' for feature '${var_feature_id.to_string()}'.")])
		return false
	}
	mut iife_temp_5 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_5 := iife_temp_5.ensure_key_is_array(this.compatibility_info_by_plugin, var_plugin_id.clone())
	mut var_key := if var_positive_compatibility { Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() } else { Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.incompatible() }
	mut var_opposite_key := if var_positive_compatibility { Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.incompatible() } else { Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }
	mut iife_temp_6 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_6 := iife_temp_6.ensure_key_is_array(this.compatibility_info_by_plugin.array_get(var_plugin_id), var_key.clone())
	mut iife_temp_7 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_7 := iife_temp_7.ensure_key_is_array(this.compatibility_info_by_plugin.array_get(var_plugin_id), var_opposite_key.clone())
	if rt.is_true(rt.call_function('in_array', [rt.new_string(feature_id_mutated).clone(), this.compatibility_info_by_plugin.array_get(var_plugin_id).array_get(var_opposite_key), rt.new_bool(true)])) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Features_Exception', []string{}, create_automattic_woocommerce_internal_features_exception(rt.call_function('esc_html', [rt.new_string("Plugin ${var_plugin_id.to_string()} is trying to declare itself as ${var_key.to_string()} with the '${var_feature_id.to_string()}' feature, but it already declared itself as ${var_opposite_key.to_string()}")]))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(feature_id_mutated).clone(), this.compatibility_info_by_plugin.array_get(var_plugin_id).array_get(var_key), rt.new_bool(true)]))))) {
		this.compatibility_info_by_plugin.array_get_mut(var_plugin_id).array_get_mut(var_key).array_push(feature_id_mutated)
	}
	var_key = if var_positive_compatibility { Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() } else { Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.incompatible() }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_plugin_id.clone(), this.compatibility_info_by_feature.array_get(rt.new_string(feature_id_mutated)).array_get(var_key), rt.new_bool(true)]))))) {
		this.compatibility_info_by_feature.array_get_mut(feature_id_mutated).array_get_mut(var_key).array_push(var_plugin_id.clone())
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) process_pending_declarations() {
	mut var_feature_id := rt.new_null()
	mut var_plugin_file := ''
	mut var_positive_compatibility := false
	if !rt.is_true(this.pending_declarations) {
		return
	}
	mut iter_4 := this.pending_declarations.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_declaration := item_4.val
		mut list_tmp_1 := var_declaration
		var_feature_id = (list_tmp_1).array_get(0)
		var_plugin_file = (list_tmp_1).array_get(1)
		var_positive_compatibility = (list_tmp_1).array_get(2)
		this.register_compatibility_internal((var_feature_id).str(), var_plugin_file, var_positive_compatibility)
	}
	this.pending_declarations = rt.new_array()
	this.lazy = false
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) feature_exists(feature_id string) bool {
	mut feature_id_mutated := feature_id
	mut var_features := this.get_feature_definitions()
	return (rt.new_bool(var_features.array_isset(rt.new_string(feature_id_mutated)))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) get_compatible_features_for_plugin(plugin_name string, enabled_features_only bool, resolve_uncertain bool) rt.PhpVal {
	this.process_pending_declarations()
	this.verify_did_woocommerce_init(mut @FN)
	mut var_features := this.get_feature_definitions()
	if var_enabled_features_only {
	var_features = rt.call_function('array_filter', [var_features.clone(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Features_FeaturesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'feature_is_enabled' }]), rt.get_constant('ARRAY_FILTER_USE_KEY')])
	}
	if !(this.compatibility_info_by_plugin.array_isset(rt.new_string(plugin_name))) {
		return rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible(), val: rt.new_array() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.incompatible(), val: rt.new_array() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.uncertain(), val: rt.func_array_keys(var_features.clone()) }])
	}
	mut var_info := this.compatibility_info_by_plugin.array_get(rt.new_string(plugin_name))
	var_info.array_set(Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible(), rt.call_function('array_values', [rt.call_function('array_intersect', [rt.func_array_keys(var_features.clone()), var_info.array_get(Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible())])]))
	var_info.array_set(Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.incompatible(), rt.call_function('array_values', [rt.call_function('array_intersect', [rt.func_array_keys(var_features.clone()), var_info.array_get(Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.incompatible())])]))
	var_info.array_set(Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.uncertain(), rt.call_function('array_values', [rt.call_function('array_diff', [rt.func_array_keys(var_features.clone()), var_info.array_get(Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible()), var_info.array_get(Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.incompatible())])]))
	if var_resolve_uncertain {
		mut iter_5 := var_info.array_get(Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.uncertain()).iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_feature_id := item_5.val
			mut var_key := rt.new_string(this.get_default_plugin_compatibility((var_feature_id).str()))
			var_info.array_get_mut(var_key).array_push(var_feature_id.clone())
		}
		var_info.array_set(Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.uncertain(), rt.new_array())
	}
	return var_info.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) get_compatible_plugins_for_feature(feature_id string, active_only bool, resolve_uncertain bool) rt.PhpVal {
	mut feature_id_mutated := feature_id
	this.process_pending_declarations()
	this.verify_did_woocommerce_init(mut @FN)
	mut var_woo_aware_plugins := rt.call_method(this.plugin_util, 'get_woocommerce_aware_plugins', [rt.new_bool(active_only)])
	if !(this.feature_exists(feature_id_mutated)) {
		return rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible(), val: rt.new_array() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.incompatible(), val: rt.new_array() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.uncertain(), val: var_woo_aware_plugins }])
	}
	mut var_info := this.compatibility_info_by_feature.array_get(rt.new_string(feature_id_mutated))
	mut iife_temp_8 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_8 := iife_temp_8.ensure_key_is_array(var_info.clone(), Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.uncertain())
	mut var_uncertain_plugins := rt.call_function('array_values', [rt.call_function('array_diff', [var_woo_aware_plugins.clone(), var_info.array_get(Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible()), var_info.array_get(Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.incompatible())])])
	mut var_key := if var_resolve_uncertain { this.get_default_plugin_compatibility(feature_id_mutated) } else { Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.uncertain() }
	var_info.array_set(var_key, rt.call_function('array_merge', [var_info.array_get(var_key), var_uncertain_plugins.clone()]))
	return var_info.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) verify_did_woocommerce_init(mut var_function_name Class_Automattic_WooCommerce_Internal_Features_?string) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.proxy, 'call_function', [rt.new_string('did_action'), rt.new_string('woocommerce_init')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.proxy, 'call_function', [rt.new_string('doing_action'), rt.new_string('woocommerce_init')]))))) {
		if !(var_function_name.is_null()) {
			mut var_class_and_method := rt.new_string((rt.call_method(create_automattic_woocommerce_internal_features_reflectionclass(rt.new_object('Automattic_WooCommerce_Internal_Features_FeaturesController', []string{}, &this)), 'getShortName', []rt.PhpVal{})).str() + '::' + (var_function_name).str())
			rt.call_method(this.proxy, 'call_function', [rt.new_string('wc_doing_it_wrong'), var_class_and_method.clone(), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s should not be called before the %2$s action.'), rt.new_string('woocommerce')]), var_class_and_method.clone(), rt.new_string('woocommerce_init')]), rt.new_string('7.0')])
		}
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) feature_enable_option_name(feature_id string) string {
	mut feature_id_mutated := feature_id
	mut var_features := this.get_feature_definitions()
	if !(!rt.is_true(var_features.array_get(rt.new_string(feature_id_mutated)).array_get(rt.new_string('option_key')))) {
		return (var_features.array_get(rt.new_string(feature_id_mutated)).array_get(rt.new_string('option_key'))).str()
	}
	return "woocommerce_feature_${var_feature_id.to_string()}_enabled"
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) should_skip_compatibility_checks(feature_id string) bool {
	mut feature_id_mutated := feature_id
	mut var_features := this.get_feature_definitions()
	return !(!rt.is_true(var_features.array_get(rt.new_string(feature_id_mutated)).array_get(rt.new_string('skip_compatibility_checks'))))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) allow_enabling_features_with_incompatible_plugins() {
	this.force_allow_enabling_features = true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) allow_activating_plugins_with_incompatible_features() {
	this.force_allow_enabling_plugins = true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) start_listening_for_option_changes() {
	rt.call_function('add_filter', [rt.new_string('updated_option'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Features_FeaturesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'process_updated_option' }]), rt.new_int(999), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('added_option'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Features_FeaturesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'process_added_option' }]), rt.new_int(999), rt.new_int(3)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) process_added_option(option string, var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.process_updated_option(option, rt.new_bool(false), var_value_mutated.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) process_updated_option(option string, var_old_value rt.PhpVal, var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	mut var_matches := rt.new_array()
	mut var_is_default_key := rt.call_function('preg_match', [rt.new_string('/^woocommerce_feature_([a-zA-Z0-9_]+)_enabled$/'), rt.new_string(option), var_matches.clone()])
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_feature := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
		}
	mut var_features_with_custom_keys := rt.call_function('array_filter', [this.get_feature_definitions(), rt.new_closure(closure_10_fn)])
	mut var_custom_keys := rt.call_function('wp_list_pluck', [var_features_with_custom_keys.clone(), rt.new_string('option_key')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_default_key)))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(option), var_custom_keys.clone(), rt.new_bool(true)]))))) {
		return
	}
	if rt.is_true(rt.identical(var_value_mutated, var_old_value)) {
		return
	}
	mut var_feature_id := rt.new_string('')
	if rt.is_true(var_is_default_key) {
	var_feature_id = var_matches.array_get(rt.new_int(1))
	} else if rt.is_true(rt.call_function('in_array', [rt.new_string(option), var_custom_keys.clone(), rt.new_bool(true)])) {
	var_feature_id = rt.call_function('array_search', [rt.new_string(option), var_custom_keys.clone(), rt.new_bool(true)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_feature_id)))) {
		return
	}
	mut iife_temp_10 := Class_WC_Tracks{}
	mut iife_result_10 := iife_temp_10.record_event(Class_Automattic_WooCommerce_Internal_Features_Automattic_WooCommerce_Internal_Features_FeaturesController.feature_enabled_changed_action(), rt.create_array([rt.ArrayItem{ key: 'feature_id', val: var_feature_id }, rt.ArrayItem{ key: 'enabled', val: var_value_mutated }]))
	rt.call_function('do_action', [Class_Automattic_WooCommerce_Internal_Features_Automattic_WooCommerce_Internal_Features_FeaturesController.feature_enabled_changed_action(), var_feature_id.clone(), rt.identical(rt.new_string('yes'), var_value_mutated)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) add_features_section(var_sections rt.PhpVal) rt.PhpVal {
	mut var_sections_mutated := var_sections
	if !(var_sections_mutated.array_isset(rt.new_string('features'))) {
		var_sections_mutated.array_set('features', rt.call_function('__', [rt.new_string('Features'), rt.new_string('woocommerce')]))
	}
	return var_sections_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) add_feature_settings(var_settings rt.PhpVal, var_current_section rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('features'), var_current_section)))) {
		return var_settings_mutated.clone()
	}
	mut var_feature_settings := rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Features'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'title' }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Start using new features that are being progressively rolled out to improve the store management experience.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'features_options' }]) }])
	mut var_features := this.get_features(true, false)
	mut var_feature_ids := rt.func_array_keys(var_features.clone())
	closure_12_fn := fn [var_features] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_feature_id_a := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_feature_id_b := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return rt.new_null()
		}
	rt.call_function('usort', [var_feature_ids.clone(), rt.new_closure(closure_12_fn)])
	closure_13_fn := fn [var_features] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_feature_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return if !(var_features.array_get(var_feature_id).array_get(rt.new_string('is_experimental'))).is_null() { var_features.array_get(var_feature_id).array_get(rt.new_string('is_experimental')) } else { rt.new_bool(false) }
		}
	mut var_experimental_feature_ids := rt.call_function('array_filter', [var_feature_ids.clone(), rt.new_closure(closure_13_fn)])
	mut var_mature_feature_ids := rt.call_function('array_diff', [var_feature_ids.clone(), var_experimental_feature_ids.clone()])
	var_feature_ids = rt.call_function('array_merge', [var_mature_feature_ids.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'mature_features_end' }]), var_experimental_feature_ids.clone()])
	mut iter_6 := var_feature_ids.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_id := item_6.val
		if rt.is_true(rt.identical(rt.new_string('mature_features_end'), var_id)) {
			var_feature_settings = rt.call_function('apply_filters', [rt.new_string('woocommerce_settings_features'), var_feature_settings.clone()])
			if !(!rt.is_true(var_experimental_feature_ids)) {
				var_feature_settings.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: 'sectionend' }, rt.ArrayItem{ key: 'id', val: 'features_options' }]))
				var_feature_settings.array_push(rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Experimental features'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'title' }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('These features are either experimental or incomplete, enable them at your own risk!'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'experimental_features_options' }]))
			}
			continue
		}
		if rt.is_true(rt.identical(rt.new_string('new_navigation'), var_id)) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string(this.feature_enable_option_name((var_id).str())), rt.new_string('no')]))))) {
			continue
		}
		if var_features.array_get(var_id).array_isset(rt.new_string('disable_ui')) && rt.is_true(var_features.array_get(var_id).array_get(rt.new_string('disable_ui'))) {
			continue
		}
		var_feature_settings.array_push(this.get_setting_for_feature((var_id).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Features_array](var_features.array_get(var_id))))
		mut var_additional_settings := if !(var_features.array_get(var_id).array_get(rt.new_string('additional_settings'))).is_null() { var_features.array_get(var_id).array_get(rt.new_string('additional_settings')) } else { rt.new_array() }
		if var_additional_settings.clone().array_count() > 0 {
		var_feature_settings = rt.call_function('array_merge', [var_feature_settings.clone(), var_additional_settings.clone()])
		}
	}
	var_feature_settings.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: 'sectionend' }, rt.ArrayItem{ key: 'id', val: if !rt.is_true(var_experimental_feature_ids) { 'features_options' } else { 'experimental_features_options' } }]))
	if this.verify_did_woocommerce_init(rt.new_null()) {
	closure_14_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_feature_setting := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iter_7 := var_feature_setting.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_value := item_7.val
			mut var_prop := item_7.key
			if rt.is_true(rt.call_function('is_callable', [var_value.clone()])) {
				var_feature_setting.array_set(var_prop, rt.call_function('call_user_func', [var_value.clone()]))
			}
		}
		return var_feature_setting.clone()
		}
	closure_15_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_feature_setting := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iter_8 := var_feature_setting.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_value := item_8.val
			mut var_prop := item_8.key
			if rt.is_true(rt.call_function('is_callable', [var_value.clone()])) {
				var_feature_setting.array_set(var_prop, rt.call_function('call_user_func', [var_value.clone()]))
			}
		}
		return var_feature_setting.clone()
		}
	var_feature_settings = rt.call_function('array_map', [rt.new_closure(closure_14_fn), var_feature_settings.clone()])
	}
	return var_feature_settings.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) get_setting_for_feature(feature_id string, mut var_feature Class_Automattic_WooCommerce_Internal_Features_array) rt.PhpVal {
	mut feature_id_mutated := feature_id
	mut var_feature_mutated := var_feature
	mut var_description := if !(var_feature_mutated.array_get(rt.new_string('description'))).is_null() { var_feature_mutated.array_get(rt.new_string('description')) } else { rt.new_string('') }
	mut var_disabled := rt.new_bool(false)
	mut var_desc_tip := rt.new_string('')
	mut var_tooltip := if !(var_feature_mutated.array_get(rt.new_string('tooltip'))).is_null() { var_feature_mutated.array_get(rt.new_string('tooltip')) } else { rt.new_string('') }
	mut var_type := if !(var_feature_mutated.array_get(rt.new_string('type'))).is_null() { var_feature_mutated.array_get(rt.new_string('type')) } else { rt.new_string('checkbox') }
	mut var_setting_definition := if !(var_feature_mutated.array_get(rt.new_string('setting'))).is_null() { var_feature_mutated.array_get(rt.new_string('setting')) } else { rt.new_array() }
	mut var_admin_features_disabled := rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_disabled'), rt.new_bool(false)])
	if rt.is_true(rt.identical(rt.new_string('analytics'), rt.new_string(feature_id_mutated))) || rt.is_true(rt.identical(rt.new_string('new_navigation'), rt.new_string(feature_id_mutated))) && rt.is_true(var_admin_features_disabled) {
	var_disabled = rt.new_bool(true)
	var_desc_tip = rt.call_function('__', [rt.new_string('WooCommerce Admin has been disabled'), rt.new_string('woocommerce')])
	} else if rt.is_true(rt.identical(rt.new_string('new_navigation'), rt.new_string(feature_id_mutated))) {
		mut var_update_text := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s This navigation will soon become unavailable while we make necessary improvements.\n\t\t\t\t\t\t\t\t\tIf you turn it off now, you will not be able to turn it back on.'), rt.new_string('woocommerce')]), rt.new_string('<br/>')])
		mut var_needs_update := rt.call_function('version_compare', [rt.call_function('get_bloginfo', [rt.new_string('version')]), rt.new_string('5.6'), rt.new_string('<')])
		if rt.is_true(var_needs_update) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')])) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_php')])) {
		var_update_text = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s %2$sUpdate WordPress to enable the new navigation%3$s'), rt.new_string('woocommerce')]), rt.new_string('<br/>'), rt.new_string('<a href="' + (rt.call_function('self_admin_url', [rt.new_string('update-core.php')])).str() + '" target="_blank">'), rt.new_string('</a>')])
		var_disabled = rt.new_bool(true)
		}
		if !(!rt.is_true(var_update_text)) {
			var_description = rt.concat(var_description, var_update_text)
		}
	}
	if !(this.should_skip_compatibility_checks(feature_id_mutated)) && rt.is_true(rt.new_bool(!(rt.is_true(var_disabled)))) && this.verify_did_woocommerce_init(rt.new_null()) {
	mut var_plugin_info_for_feature := this.get_compatible_plugins_for_feature(feature_id_mutated, true, false)
	var_desc_tip = rt.call_method(this.plugin_util, 'generate_incompatible_plugin_feature_warning', [rt.new_string(feature_id_mutated).clone(), var_plugin_info_for_feature.clone()])
	}
	var_desc_tip = rt.call_function('apply_filters', [rt.new_string('woocommerce_feature_description_tip'), var_desc_tip.clone(), rt.new_string(feature_id_mutated).clone(), var_disabled.clone()])
	mut var_feature_setting_defaults := rt.create_array([rt.ArrayItem{ key: 'title', val: var_feature_mutated.array_get(rt.new_string('name')) }, rt.ArrayItem{ key: 'desc', val: var_description }, rt.ArrayItem{ key: 'type', val: var_type }, rt.ArrayItem{ key: 'id', val: this.feature_enable_option_name(feature_id_mutated) }, rt.ArrayItem{ key: 'disabled', val: rt.is_true(var_disabled) && !(this.force_allow_enabling_features) }, rt.ArrayItem{ key: 'desc_tip', val: var_desc_tip }, rt.ArrayItem{ key: 'tooltip', val: var_tooltip }, rt.ArrayItem{ key: 'default', val: if this.feature_is_enabled_by_default(feature_id_mutated) { 'yes' } else { 'no' } }])
	mut var_feature_setting := rt.call_function('wp_parse_args', [var_setting_definition.clone(), var_feature_setting_defaults.clone()])
	if !(!rt.is_true(var_feature_mutated.array_get(rt.new_string('learn_more_url')))) {
		var_feature_setting.array_get(rt.new_string('desc')) = rt.concat(var_feature_setting.array_get(rt.new_string('desc')), rt.call_function('sprintf', [rt.new_string('<span class="learn-more-link"><a href="%s" target="_blank">%s</a></span>'), rt.call_function('esc_attr', [var_feature_mutated.array_get(rt.new_string('learn_more_url'))]), rt.call_function('esc_html__', [rt.new_string('Learn more'), rt.new_string('woocommerce')])]))
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_feature_setting'), var_feature_setting.clone(), rt.new_string(feature_id_mutated).clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) handle_plugin_deactivation(var_plugin_name rt.PhpVal) {
	this.compatibility_info_by_plugin.array_unset(var_plugin_name)
	mut iter_9 := rt.func_array_keys(this.compatibility_info_by_feature).iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_feature := item_9.val
		mut var_compatibles := this.compatibility_info_by_feature.array_get(var_feature).array_get(Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible())
		this.compatibility_info_by_feature.array_get_mut(var_feature).array_set(Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible(), rt.call_function('array_diff', [var_compatibles.clone(), rt.create_array([rt.ArrayItem{ key: none, val: var_plugin_name }])]))
		mut var_incompatibles := this.compatibility_info_by_feature.array_get(var_feature).array_get(Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.incompatible())
		this.compatibility_info_by_feature.array_get_mut(var_feature).array_set(Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.incompatible(), rt.call_function('array_diff', [var_incompatibles.clone(), rt.create_array([rt.ArrayItem{ key: none, val: var_plugin_name }])]))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) filter_plugins_list(var_plugin_list rt.PhpVal) rt.PhpVal {
	mut var_plugin_list_mutated := var_plugin_list
	if !(this.verify_did_woocommerce_init(rt.new_null())) {
		return var_plugin_list_mutated.clone()
	}
	mut iife_temp_15 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_15 := iife_temp_15.get_value_or_default(rt.get_superglobal('_GET').clone(), rt.new_string('plugin_status'))
	if (rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('get_current_screen')]))))) || (rt.is_true(rt.call_function('get_current_screen', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('plugins'), rt.get_property(rt.call_function('get_current_screen', []rt.PhpVal{}), 'id'))))))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('incompatible_with_feature'), iife_result_15)))) {
		return var_plugin_list_mutated.clone()
	}
	mut var_feature_id := if !(rt.get_superglobal('_GET').array_get(rt.new_string('feature_id'))).is_null() { rt.get_superglobal('_GET').array_get(rt.new_string('feature_id')) } else { rt.new_string('all') }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('all'), var_feature_id)))) && !(this.feature_exists((var_feature_id).str())) {
		return var_plugin_list_mutated.clone()
	}
	return this.get_incompatible_plugins(var_feature_id.clone(), var_plugin_list_mutated.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) get_incompatible_plugins(var_feature_id rt.PhpVal, var_plugin_list rt.PhpVal) rt.PhpVal {
	mut var_id := rt.new_null()
	mut var_feature_id_mutated := var_feature_id
	mut var_plugin_list_mutated := var_plugin_list
	mut var_incompatibles := rt.new_array()
	var_plugin_list_mutated = rt.call_function('array_diff_key', [var_plugin_list_mutated.clone(), rt.call_function('array_flip', [this.plugins_excluded_from_compatibility_ui])])
	mut var_feature_ids := if rt.is_true(rt.identical(rt.new_string('all'), var_feature_id_mutated)) { rt.func_array_keys(this.get_feature_definitions()) } else { rt.create_array([rt.ArrayItem{ key: none, val: var_feature_id_mutated }]) }
	mut var_only_enabled_features := rt.identical(rt.new_string('all'), var_feature_id_mutated)
	mut iter_10 := rt.func_array_keys(var_plugin_list_mutated.clone()).iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_plugin_name := item_10.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.plugin_util, 'is_woocommerce_aware_plugin', [var_plugin_name.clone()]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.proxy, 'call_function', [rt.new_string('is_plugin_active'), var_plugin_name.clone()]))))) {
			continue
		}
		mut var_compatibility_info := this.get_compatible_features_for_plugin((var_plugin_name).str(), false, false)
		mut iter_11 := var_feature_ids.iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var_feature_id_shadow := item_11.val
			closure_17_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.new_bool(this.feature_is_enabled((var_id).str()) && !(this.should_skip_compatibility_checks((var_id).str())))
				}
			closure_18_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.new_bool(!(this.should_skip_compatibility_checks((var_id).str())))
				}
			mut var_features_considered_incompatible := rt.call_function('array_filter', [rt.call_method(this.plugin_util, 'get_items_considered_incompatible', [var_feature_id_shadow.clone(), var_compatibility_info.clone()]), if rt.is_true(var_only_enabled_features) { rt.new_closure(closure_17_fn) } else { rt.new_closure(closure_18_fn) }])
			if rt.is_true(rt.call_function('in_array', [var_feature_id_shadow.clone(), var_features_considered_incompatible.clone(), rt.new_bool(true)])) {
				var_incompatibles.array_push(var_plugin_name.clone())
			}
		}
	}
	return rt.call_function('array_intersect_key', [var_plugin_list_mutated.clone(), rt.call_function('array_flip', [var_incompatibles.clone()])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) display_notices_in_plugins_page() {
	if !(this.verify_did_woocommerce_init(rt.new_null())) {
		return
	}
	mut var_feature_filter_description_shown := rt.new_bool(this.maybe_display_current_feature_filter_description())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_feature_filter_description_shown)))) {
		this.maybe_display_feature_incompatibility_warning()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) maybe_display_feature_incompatibility_warning() {
	mut var_id := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('activate_plugins')]))))) {
		return
	}
	mut var_incompatible_plugins := rt.new_bool(false)
	mut var_relevant_plugins := rt.call_function('array_diff', [rt.call_method(this.plugin_util, 'get_woocommerce_aware_plugins', [rt.new_bool(true)]), this.plugins_excluded_from_compatibility_ui])
	mut iter_12 := var_relevant_plugins.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_plugin := item_12.val
		mut var_compatibility_info := this.get_compatible_features_for_plugin((var_plugin).str(), true, false)
		closure_19_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_bool(!(this.should_skip_compatibility_checks((var_id).str())))
			}
		mut var_incompatibles := rt.call_function('array_filter', [var_compatibility_info.array_get(Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.incompatible()), rt.new_closure(closure_19_fn)])
		if !(!rt.is_true(var_incompatibles)) {
			var_incompatible_plugins = rt.new_bool(true)
			break
		}
		closure_20_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_bool(!(this.should_skip_compatibility_checks((var_id).str())))
			}
		mut var_uncertains := rt.call_function('array_filter', [var_compatibility_info.array_get(Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.uncertain()), rt.new_closure(closure_20_fn)])
		mut iter_13 := var_uncertains.iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_feature_id := item_13.val
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible(), this.get_default_plugin_compatibility((var_feature_id).str()))))) {
				var_incompatible_plugins = rt.new_bool(true)
				break
			}
		}
		if rt.is_true(var_incompatible_plugins) {
			break
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_incompatible_plugins)))) {
		return
	}
	mut var_message := rt.call_function('str_replace', [rt.new_string('<a>'), rt.new_string('<a href="' + (rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'plugin_status', val: 'incompatible_with_feature' }]), rt.call_function('admin_url', [rt.new_string('plugins.php')])])])).str() + '">'), rt.call_function('__', [rt.new_string('WooCommerce has detected that some of your active plugins are incompatible with currently enabled WooCommerce features. Please <a>review the details</a>.'), rt.new_string('woocommerce')])])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_message)
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) maybe_display_current_feature_filter_description() bool {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('plugins'), rt.get_property(rt.call_function('get_current_screen', []rt.PhpVal{}), 'id'))))) {
		return false
	}
	mut var_plugin_status := if !(rt.get_superglobal('_GET').array_get(rt.new_string('plugin_status'))).is_null() { rt.get_superglobal('_GET').array_get(rt.new_string('plugin_status')) } else { rt.new_string('') }
	mut var_feature_id := if !(rt.get_superglobal('_GET').array_get(rt.new_string('feature_id'))).is_null() { rt.get_superglobal('_GET').array_get(rt.new_string('feature_id')) } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('incompatible_with_feature'), var_plugin_status)))) {
		return false
	}
	var_feature_id = if rt.is_true(rt.identical(rt.new_string(''), var_feature_id)) { rt.new_string('all') } else { var_feature_id }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('all'), var_feature_id)))) && !(this.feature_exists((var_feature_id).str())) {
		return false
	}
	mut var_features := this.get_feature_definitions()
	mut var_plugins_page_url := rt.call_function('admin_url', [rt.new_string('plugins.php')])
	mut var_features_page_url := rt.new_string(this.get_features_page_url())
	mut var_message := if rt.is_true(rt.identical(rt.new_string('all'), var_feature_id)) { rt.call_function('__', [rt.new_string('You are viewing active plugins that are incompatible with currently enabled WooCommerce features.'), rt.new_string('woocommerce')]) } else { rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You are viewing the active plugins that are incompatible with the \'%s\' feature.'), rt.new_string('woocommerce')]), var_features.array_get(var_feature_id).array_get(rt.new_string('name'))]) }
	var_message = rt.concat(var_message, rt.new_string('<br />'))
	var_message = rt.concat(var_message, rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<a href=\'%1$s\'>View all plugins</a> - <a href=\'%2$s\'>Manage WooCommerce features</a>'), rt.new_string('woocommerce')]), var_plugins_page_url.clone(), var_features_page_url.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_message)
	// unsupported statement: Stmt_InlineHTML
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) maybe_invalidate_cached_plugin_data() {
	if rt.is_true(rt.identical(if !(rt.get_superglobal('_GET').array_get(rt.new_string('plugin_status'))).is_null() { rt.get_superglobal('_GET').array_get(rt.new_string('plugin_status')) } else { rt.new_string('') }, rt.new_string('incompatible_with_feature'))) {
		rt.call_function('wp_cache_delete', [rt.new_string('plugins'), rt.new_string('plugins')])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) handle_plugin_list_rows(var_plugin_file rt.PhpVal, var_plugin_data rt.PhpVal) {
	mut var_wp_list_table := rt.new_null()
	if rt.is_true(rt.call_function('in_array', [var_plugin_file.clone(), this.plugins_excluded_from_compatibility_ui, rt.new_bool(true)])) {
		return
	}
	mut iife_temp_20 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_20 := iife_temp_20.get_value_or_default(rt.get_superglobal('_GET').clone(), rt.new_string('plugin_status'))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('incompatible_with_feature'), iife_result_20)))) {
		return
	}
	if var_wp_list_table.clone().is_null() || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.plugin_util, 'is_woocommerce_aware_plugin', [var_plugin_data.clone()]))))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.proxy, 'call_function', [rt.new_string('is_plugin_active'), var_plugin_file.clone()]))))) {
		return
	}
	mut var_features := this.get_feature_definitions()
	mut var_feature_compatibility_info := this.get_compatible_features_for_plugin((var_plugin_file).str(), true, true)
	mut var_incompatible_features := var_feature_compatibility_info.array_get(Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.incompatible())
	closure_22_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_feature_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
		}
	closure_23_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_feature_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
		}
	var_incompatible_features = rt.call_function('array_values', [rt.call_function('array_filter', [var_incompatible_features.clone(), rt.new_closure(closure_22_fn)])])
	mut var_incompatible_features_count := rt.new_int(var_incompatible_features.clone().array_count())
	if rt.is_true(rt.greater(var_incompatible_features_count, rt.new_int(0))) {
		mut var_columns_count := rt.call_method(var_wp_list_table, 'get_column_count', []rt.PhpVal{})
		mut var_is_active := rt.new_bool(true)
		mut var_is_active_class := rt.new_string((if rt.is_true(var_is_active) { 'active' } else { 'inactive' }).str())
		mut var_is_active_td_style := rt.new_string((if rt.is_true(var_is_active) { ' style=\'border-left: 4px solid #72aee6;\'' } else { '' }).str())
		if rt.is_true(rt.identical(rt.new_int(1), var_incompatible_features_count)) {
		mut var_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('⚠ This plugin is incompatible with the enabled WooCommerce feature \'%s\', it shouldn\'t be activated.'), rt.new_string('woocommerce')]), var_features.array_get(var_incompatible_features.array_get(rt.new_int(0))).array_get(rt.new_string('name'))])
		} else if rt.is_true(rt.identical(rt.new_int(2), var_incompatible_features_count)) {
		var_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('⚠ This plugin is incompatible with the enabled WooCommerce features \'%1$s\' and \'%2$s\', it shouldn\'t be activated.'), rt.new_string('woocommerce')]), var_features.array_get(var_incompatible_features.array_get(rt.new_int(0))).array_get(rt.new_string('name')), var_features.array_get(var_incompatible_features.array_get(rt.new_int(1))).array_get(rt.new_string('name'))])
		} else {
		var_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('⚠ This plugin is incompatible with the enabled WooCommerce features \'%1$s\', \'%2$s\' and %3$d more, it shouldn\'t be activated.'), rt.new_string('woocommerce')]), var_features.array_get(var_incompatible_features.array_get(rt.new_int(0))).array_get(rt.new_string('name')), var_features.array_get(var_incompatible_features.array_get(rt.new_int(1))).array_get(rt.new_string('name')), rt.sub(var_incompatible_features_count, rt.new_int(2))])
		}
		mut var_features_page_url := rt.new_string(this.get_features_page_url())
		mut var_manage_features_message := rt.call_function('__', [rt.new_string('Manage WooCommerce features'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_is_active_class)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_plugin_file)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_columns_count)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_is_active_td_style)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_message)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_features_page_url)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_manage_features_message)
		// unsupported statement: Stmt_InlineHTML
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) get_features_page_url() string {
	return (rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=advanced&section=features')])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) enqueue_script_to_fix_plugin_list_html(var_current_screen rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('plugins'), rt.get_property(var_current_screen, 'id'))))) {
		return
	}
	mut var_handle := rt.new_string('wc-features-fix-plugin-list-html')
	rt.call_function('wp_register_script', [var_handle.clone(), rt.new_string(''), rt.new_array(), rt.get_constant('WC_VERSION'), rt.create_array([rt.ArrayItem{ key: 'in_footer', val: true }])])
	rt.call_function('wp_enqueue_script', [var_handle.clone()])
	rt.call_function('wp_add_inline_script', [var_handle.clone(), rt.new_string('\n            const warningRows = document.querySelectorAll(\'tr[data-plugin-row-type="feature-incomp-warn"]\');\n            for(const warningRow of warningRows) {\n                const pluginName = warningRow.getAttribute(\'data-plugin\');\n                const pluginInfoRow = document.querySelector(\'tr.active[data-plugin="\' + pluginName + \'"]:not(.plugin-update-tr), tr.inactive[data-plugin="\' + pluginName + \'"]:not(.plugin-update-tr)\');\n                if(!pluginInfoRow) {\n                    continue;\n                }\n                if(pluginInfoRow.classList.contains(\'update\')) {\n                    warningRow.classList.remove(\'plugin-update-tr\');\n                    warningRow.querySelector(\'.notice\').style.margin = \'5px 10px 15px 30px\';\n                }\n                else {\n                    pluginInfoRow.classList.add(\'update\');\n                }\n            }\n            ')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) handle_plugins_page_views_list(var_views rt.PhpVal) rt.PhpVal {
	mut iife_temp_23 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_23 := iife_temp_23.get_value_or_default(rt.get_superglobal('_GET').clone(), rt.new_string('plugin_status'))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('incompatible_with_feature'), iife_result_23)))) {
		return var_views.clone()
	}
	mut var_feature_id := if !(rt.get_superglobal('_GET').array_get(rt.new_string('feature_id'))).is_null() { rt.get_superglobal('_GET').array_get(rt.new_string('feature_id')) } else { rt.new_string('all') }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('all'), var_feature_id)))) && !(this.feature_exists((var_feature_id).str())) {
		return var_views.clone()
	}
	mut var_all_items := rt.call_function('get_plugins', []rt.PhpVal{})
	mut var_features := this.get_feature_definitions()
	mut var_incompatible_plugins_count := rt.new_int(this.filter_plugins_list(var_all_items.clone()).array_count())
	mut var_incompatible_text := if rt.is_true(rt.identical(rt.new_string('all'), var_feature_id)) { rt.call_function('__', [rt.new_string('Incompatible with WooCommerce features'), rt.new_string('woocommerce')]) } else { rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Incompatible with \'%s\''), rt.new_string('woocommerce')]), var_features.array_get(var_feature_id).array_get(rt.new_string('name'))]) }
	mut var_incompatible_link := rt.new_string("<a href='plugins.php?plugin_status=incompatible_with_feature&feature_id=${var_feature_id.to_string()}' class='current' aria-current='page'>${var_incompatible_text.to_string()} <span class='count'>(${var_incompatible_plugins_count.to_string()})</span></a>")
	mut var_all_plugins_count := rt.new_int(var_all_items.clone().array_count())
	mut var_all_text := rt.call_function('__', [rt.new_string('All'), rt.new_string('woocommerce')])
	mut var_all_link := rt.new_string("<a href='plugins.php?plugin_status=all'>${var_all_text.to_string()} <span class='count'>(${var_all_plugins_count.to_string()})</span></a>")
	return rt.create_array([rt.ArrayItem{ key: 'all', val: var_all_link }, rt.ArrayItem{ key: 'incompatible_with_feature', val: var_incompatible_link }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) set_change_feature_enable_nonce(var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	var_settings_mutated.array_set('_feature_nonce', rt.call_function('wp_create_nonce', [rt.new_string('change_feature_enable')]))
	return var_settings_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) change_feature_enable_from_query_params() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
		return
	}
	mut var_is_feature_nonce_invalid := rt.new_bool(!(rt.get_superglobal('_GET').array_isset(rt.new_string('_feature_nonce'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('_feature_nonce'))])]), rt.new_string('change_feature_enable')]))))))
	mut var_query_params_to_remove := rt.create_array([rt.ArrayItem{ key: none, val: '_feature_nonce' }])
	mut iter_14 := rt.func_array_keys(this.get_feature_definitions()).iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_feature_id := item_14.val
		if rt.get_superglobal('_GET').array_isset(var_feature_id) && rt.get_superglobal('_GET').array_get(var_feature_id).is_long() || rt.get_superglobal('_GET').array_get(var_feature_id).is_double() {
			mut var_value := rt.call_function('absint', [rt.get_superglobal('_GET').array_get(var_feature_id)])
			if rt.is_true(var_is_feature_nonce_invalid) {
				rt.call_function('wp_die', [rt.call_function('esc_html__', [rt.new_string('Action failed. Please refresh the page and retry.'), rt.new_string('woocommerce')])])
				return
			}
			if rt.is_true(rt.identical(rt.new_int(1), var_value)) {
				this.change_feature_enable((var_feature_id).str(), true)
			} else if rt.is_true(rt.identical(rt.new_int(0), var_value)) {
				this.change_feature_enable((var_feature_id).str(), false)
			}
			var_query_params_to_remove.array_push(var_feature_id.clone())
		}
	}
	if var_query_params_to_remove.clone().array_count() > 1 && rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_URI')) {
		rt.call_function('wp_safe_redirect', [rt.call_function('remove_query_arg', [var_query_params_to_remove.clone(), rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))])])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) display_email_improvements_feedback_notice(var_feature_id rt.PhpVal, var_is_enabled rt.PhpVal) {
	mut var_feature_id_mutated := var_feature_id
	mut var_is_enabled_mutated := var_is_enabled
	if rt.is_true(rt.identical(rt.new_string('email_improvements'), var_feature_id_mutated)) && rt.is_true(rt.new_bool(!(rt.is_true(var_is_enabled_mutated)))) {
		rt.call_function('set_transient', [rt.new_string('wc_settings_email_improvements_reverted'), rt.new_string('yes'), rt.new_int(15)])
		closure_25_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			print('<div id="wc_settings_features_email_feedback_slotfill"></div>')
			return rt.new_null()
			}
		rt.call_function('add_action', [rt.new_string('admin_notices'), rt.new_closure(closure_25_fn)])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) is_preview_email_improvements_enabled(feature_id string) bool {
	mut feature_id_mutated := feature_id
	if rt.is_true(rt.new_bool('email_improvements' != feature_id_mutated)) {
		return false
	}
	mut var_is_email_preview := rt.call_function('apply_filters', [rt.new_string('woocommerce_is_email_preview'), rt.new_bool(false)])
	if rt.is_true(var_is_email_preview) {
		return (rt.identical(rt.call_function('get_transient', [Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview.transient_preview_email_improvements()]), rt.new_string('yes'))).to_bool()
	}
	return false
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_WC_Site_Tracking {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Features_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Features_ReflectionClass {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Features_Exception {
	rt.PhpObjectBase
}

struct Class_WC_Tracks {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_features_featurescontroller() &Class_Automattic_WooCommerce_Internal_Features_FeaturesController {
	mut obj := &Class_Automattic_WooCommerce_Internal_Features_FeaturesController{
		PhpObjectBase: rt.PhpObjectBase{}
		features: rt.new_array()
		compatibility_info_by_plugin: rt.new_array()
		compatibility_info_by_feature: rt.new_array()
		pending_declarations: rt.new_array()
		proxy: rt.new_null()
		plugin_util: rt.new_null()
		force_allow_enabling_features: false
		force_allow_enabling_plugins: false
		plugins_excluded_from_compatibility_ui: rt.new_null()
		registered_additional_features_via_action: false
		registered_additional_features_via_class_calls: false
		lazy: false
	}
	obj.construct()
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_site_tracking(_args ...rt.PhpVal) &Class_WC_Site_Tracking {
	mut obj := &Class_WC_Site_Tracking{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_features_invalidargumentexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Features_InvalidArgumentException {
	mut obj := &Class_Automattic_WooCommerce_Internal_Features_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_features_reflectionclass(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Features_ReflectionClass {
	mut obj := &Class_Automattic_WooCommerce_Internal_Features_ReflectionClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_arrayutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ArrayUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_features_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Features_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_Features_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tracks(_args ...rt.PhpVal) &Class_WC_Tracks {
	mut obj := &Class_WC_Tracks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'add_feature_definition' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Features_array](if args.len > 2 { args[2] } else { rt.new_null() })
			this.add_feature_definition(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'get_feature_definitions' {
			return this.get_feature_definitions()
		}
		'init_feature_definitions' {
			this.init_feature_definitions()
			return rt.new_null()
		}
		'init_compatibility_info_by_feature' {
			this.init_compatibility_info_by_feature()
			return rt.new_null()
		}
		'get_mcp_integration_description' {
			return rt.new_string(this.get_mcp_integration_description())
		}
		'register_additional_features' {
			this.register_additional_features()
			return rt.new_null()
		}
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Proxies_LegacyProxy](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_PluginUtil](if args.len > 1 { args[1] } else { rt.new_null() })
			this.init(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_features' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_features(dispatch_arg_0, dispatch_arg_1)
		}
		'get_default_plugin_compatibility' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_default_plugin_compatibility(dispatch_arg_0))
		}
		'get_feature_definition' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_feature_definition(dispatch_arg_0)
		}
		'feature_is_enabled' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.feature_is_enabled(dispatch_arg_0))
		}
		'feature_is_enabled_by_default' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.feature_is_enabled_by_default(dispatch_arg_0))
		}
		'change_feature_enable' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.change_feature_enable(dispatch_arg_0, dispatch_arg_1))
		}
		'declare_compatibility' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.declare_compatibility(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'register_compatibility_internal' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.register_compatibility_internal(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'process_pending_declarations' {
			this.process_pending_declarations()
			return rt.new_null()
		}
		'feature_exists' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.feature_exists(dispatch_arg_0))
		}
		'get_compatible_features_for_plugin' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.get_compatible_features_for_plugin(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_compatible_plugins_for_feature' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.get_compatible_plugins_for_feature(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'verify_did_woocommerce_init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Features_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.verify_did_woocommerce_init(mut dispatch_arg_0))
		}
		'feature_enable_option_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.feature_enable_option_name(dispatch_arg_0))
		}
		'should_skip_compatibility_checks' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.should_skip_compatibility_checks(dispatch_arg_0))
		}
		'allow_enabling_features_with_incompatible_plugins' {
			this.allow_enabling_features_with_incompatible_plugins()
			return rt.new_null()
		}
		'allow_activating_plugins_with_incompatible_features' {
			this.allow_activating_plugins_with_incompatible_features()
			return rt.new_null()
		}
		'start_listening_for_option_changes' {
			this.start_listening_for_option_changes()
			return rt.new_null()
		}
		'process_added_option' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.process_added_option(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'process_updated_option' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.process_updated_option(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'add_features_section' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_features_section(dispatch_arg_0)
		}
		'add_feature_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_feature_settings(dispatch_arg_0, dispatch_arg_1)
		}
		'get_setting_for_feature' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Features_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.get_setting_for_feature(dispatch_arg_0, mut dispatch_arg_1)
		}
		'handle_plugin_deactivation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handle_plugin_deactivation(dispatch_arg_0)
			return rt.new_null()
		}
		'filter_plugins_list' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_plugins_list(dispatch_arg_0)
		}
		'get_incompatible_plugins' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_incompatible_plugins(dispatch_arg_0, dispatch_arg_1)
		}
		'display_notices_in_plugins_page' {
			this.display_notices_in_plugins_page()
			return rt.new_null()
		}
		'maybe_display_feature_incompatibility_warning' {
			this.maybe_display_feature_incompatibility_warning()
			return rt.new_null()
		}
		'maybe_display_current_feature_filter_description' {
			return rt.new_bool(this.maybe_display_current_feature_filter_description())
		}
		'maybe_invalidate_cached_plugin_data' {
			this.maybe_invalidate_cached_plugin_data()
			return rt.new_null()
		}
		'handle_plugin_list_rows' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.handle_plugin_list_rows(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_features_page_url' {
			return rt.new_string(this.get_features_page_url())
		}
		'enqueue_script_to_fix_plugin_list_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.enqueue_script_to_fix_plugin_list_html(dispatch_arg_0)
			return rt.new_null()
		}
		'handle_plugins_page_views_list' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.handle_plugins_page_views_list(dispatch_arg_0)
		}
		'set_change_feature_enable_nonce' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.set_change_feature_enable_nonce(dispatch_arg_0)
		}
		'change_feature_enable_from_query_params' {
			this.change_feature_enable_from_query_params()
			return rt.new_null()
		}
		'display_email_improvements_feedback_notice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.display_email_improvements_feedback_notice(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'is_preview_email_improvements_enabled' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_preview_email_improvements_enabled(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Features_FeaturesController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'features' { return this.features }
		'compatibility_info_by_plugin' { return this.compatibility_info_by_plugin }
		'compatibility_info_by_feature' { return this.compatibility_info_by_feature }
		'pending_declarations' { return this.pending_declarations }
		'proxy' { return this.proxy }
		'plugin_util' { return this.plugin_util }
		'force_allow_enabling_features' { return rt.new_bool(this.force_allow_enabling_features) }
		'force_allow_enabling_plugins' { return rt.new_bool(this.force_allow_enabling_plugins) }
		'plugins_excluded_from_compatibility_ui' { return this.plugins_excluded_from_compatibility_ui }
		'registered_additional_features_via_action' { return rt.new_bool(this.registered_additional_features_via_action) }
		'registered_additional_features_via_class_calls' { return rt.new_bool(this.registered_additional_features_via_class_calls) }
		'lazy' { return rt.new_bool(this.lazy) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'features' { this.features = val; return true }
		'compatibility_info_by_plugin' { this.compatibility_info_by_plugin = val; return true }
		'compatibility_info_by_feature' { this.compatibility_info_by_feature = val; return true }
		'pending_declarations' { this.pending_declarations = val; return true }
		'proxy' { this.proxy = val; return true }
		'plugin_util' { this.plugin_util = val; return true }
		'force_allow_enabling_features' { this.force_allow_enabling_features = (val).to_bool(); return true }
		'force_allow_enabling_plugins' { this.force_allow_enabling_plugins = (val).to_bool(); return true }
		'plugins_excluded_from_compatibility_ui' { this.plugins_excluded_from_compatibility_ui = val; return true }
		'registered_additional_features_via_action' { this.registered_additional_features_via_action = (val).to_bool(); return true }
		'registered_additional_features_via_class_calls' { this.registered_additional_features_via_class_calls = (val).to_bool(); return true }
		'lazy' { this.lazy = (val).to_bool(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Site_Tracking) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Site_Tracking) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Site_Tracking) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Features_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Features_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Features_ReflectionClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Features_ReflectionClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ReflectionClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Features_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Features_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Tracks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tracks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tracks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
