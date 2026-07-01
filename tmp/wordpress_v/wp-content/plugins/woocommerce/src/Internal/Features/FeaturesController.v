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

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) construct()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.registered_additional_features_via_action)))) {
		if rt.is_true(rt.call_function('did_action', [rt.new_string('before_woocommerce_init')])) {
			this.register_additional_features()
		} else {
			rt.call_function('add_filter', [rt.new_string('before_woocommerce_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Features_FeaturesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_additional_features' }]), // unsupported expression: Expr_UnaryMinus, rt.new_int(0)])
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

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) add_feature_definition(var_slug rt.PhpVal, var_name rt.PhpVal, mut var_args Class_Automattic_WooCommerce_Internal_Features_array)  {
	mut var_args_mutated := var_args
	mut var_defaults := rt.create_array([rt.ArrayItem{ key: 'disable_ui', val: false }, rt.ArrayItem{ key: 'enabled_by_default', val: false }, rt.ArrayItem{ key: 'is_experimental', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: false }, rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'order', val: 10 }, rt.ArrayItem{ key: 'learn_more_url', val: '' }])
	if !rt.is_true(var_args_mutated.array_get('default_plugin_compatibility')) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.new_string('Assuming positive compatibility by default will be deprecated in the future. Please set \'default_plugin_compatibility\' for feature "%s".'), rt.call_function('esc_html', [var_slug.dup()])]), rt.new_string('10.3.0')])
	}
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.dup(), var_defaults.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_args_mutated.array_get('default_plugin_compatibility'), Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.valid_registration_values(), rt.new_bool(true)]))))) {
		var_args_mutated.array_set('default_plugin_compatibility', if rt.is_true(rt.call_function('wc_string_to_bool', [var_args_mutated.array_get('default_plugin_compatibility')])) { Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() } else { Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.incompatible() })
	}
	if !(!rt.is_true(var_args_mutated.array_get('is_legacy'))) {
		var_args_mutated.array_set('skip_compatibility_checks', true)
	}
	this.features.array_set(var_slug, var_args_mutated.dup())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) get_feature_definitions() rt.PhpVal {
	if !rt.is_true(this.features) {
		this.init_feature_definitions()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.registered_additional_features_via_class_calls)))) {
		this.registered_additional_features_via_class_calls = true
		mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
		rt.call_method(rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.class()]), 'add_feature_definition', [rt.new_object('Automattic_WooCommerce_Internal_Features_FeaturesController', []string{}, &this)])
		rt.call_method(rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController.class()]), 'add_feature_definition', [rt.new_object('Automattic_WooCommerce_Internal_Features_FeaturesController', []string{}, &this)])
		this.init_compatibility_info_by_feature()
	}
	return this.features
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) init_feature_definitions()  {
	mut var_alpha_feature_testing_is_enabled := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_true(arg_0) }(rt.new_string('WOOCOMMERCE_ENABLE_ALPHA_FEATURE_TESTING'))
	mut var_tracking_enabled := fn () rt.PhpVal { mut temp := Class_WC_Site_Tracking{}; return temp.is_tracking_enabled() }()
	closure_2_fn := fn [var_tracking_enabled] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn [var_tracking_enabled] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	return rt.new_bool(!(rt.is_true(var_tracking_enabled)))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_tracking_enabled)))) {
		return rt.call_function('__', [rt.new_string('⚠ Usage tracking must be enabled to use remote logging.'), rt.new_string('woocommerce')])
	}
	return rt.new_string('')
	}
	mut var_legacy_features := rt.create_array([rt.ArrayItem{ key: 'analytics', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Analytics'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Enable WooCommerce Analytics'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'option_key', val: Class_Automattic_WooCommerce_Internal_Admin_Analytics.toggle_option_name() }, rt.ArrayItem{ key: 'is_experimental', val: false }, rt.ArrayItem{ key: 'enabled_by_default', val: true }, rt.ArrayItem{ key: 'disable_ui', val: false }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }]) }, rt.ArrayItem{ key: 'product_block_editor', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('New product editor'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Try the new product editor (Beta)'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'is_experimental', val: true }, rt.ArrayItem{ key: 'disable_ui', val: false }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }]) }, rt.ArrayItem{ key: 'cart_checkout_blocks', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Cart & Checkout Blocks'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Optimize for faster checkout'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'is_experimental', val: false }, rt.ArrayItem{ key: 'disable_ui', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }]) }, rt.ArrayItem{ key: 'rate_limit_checkout', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Rate limit Checkout'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Enables rate limiting for Checkout place order and Store API /checkout endpoint. To further control this, refer to <a href="%s" target="_blank">rate limiting documentation</a>.'), rt.new_string('woocommerce')]), rt.new_string('https://developer.woocommerce.com/docs/apis/store-api/rate-limiting/')]) }, rt.ArrayItem{ key: 'is_experimental', val: false }, rt.ArrayItem{ key: 'disable_ui', val: false }, rt.ArrayItem{ key: 'enabled_by_default', val: false }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }]) }, rt.ArrayItem{ key: 'marketplace', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Marketplace'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('New, faster way to find extensions and themes for your WooCommerce store'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'is_experimental', val: false }, rt.ArrayItem{ key: 'enabled_by_default', val: true }, rt.ArrayItem{ key: 'disable_ui', val: true }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'deprecated_since', val: '10.5.0' }, rt.ArrayItem{ key: 'deprecated_value', val: true }]) }, rt.ArrayItem{ key: 'order_attribution', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Order Attribution'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Enable this feature to track and credit channels and campaigns that contribute to orders on your site'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'enabled_by_default', val: true }, rt.ArrayItem{ key: 'disable_ui', val: false }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'is_experimental', val: false }]) }, rt.ArrayItem{ key: 'site_visibility_badge', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Site visibility badge'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Enable the site visibility badge in the WordPress admin bar'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'enabled_by_default', val: true }, rt.ArrayItem{ key: 'disable_ui', val: false }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'is_experimental', val: false }, rt.ArrayItem{ key: 'disabled', val: false }]) }, rt.ArrayItem{ key: 'hpos_fts_indexes', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('HPOS Full text search indexes'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Create and use full text search indexes for orders. This feature only works with high-performance order storage.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'is_experimental', val: true }, rt.ArrayItem{ key: 'enabled_by_default', val: false }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'option_key', val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.hpos_fts_index_option() }]) }, rt.ArrayItem{ key: 'hpos_datastore_caching', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('HPOS Data Caching'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Enable order data caching in the datastore. This feature only works with high-performance order storage and is recommended for stores using object caching.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'is_experimental', val: false }, rt.ArrayItem{ key: 'enabled_by_default', val: false }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'disable_ui', val: false }, rt.ArrayItem{ key: 'option_key', val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.hpos_datastore_caching_enabled_option() }]) }, rt.ArrayItem{ key: 'remote_logging', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Remote Logging'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Allow WooCommerce to send error logs and non-sensitive diagnostic data to help improve WooCommerce. This feature requires %1$susage tracking%2$s to be enabled.'), rt.new_string('woocommerce')]), '<a href="' + (rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=advanced&section=woocommerce_com')])).str() + '">', rt.new_string('</a>')]) }, rt.ArrayItem{ key: 'enabled_by_default', val: true }, rt.ArrayItem{ key: 'disable_ui', val: false }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'is_experimental', val: false }, rt.ArrayItem{ key: 'setting', val: rt.create_array([rt.ArrayItem{ key: 'disabled', val: rt.new_closure(closure_1_fn) }, rt.ArrayItem{ key: 'desc_tip', val: rt.new_closure(closure_2_fn) }]) }]) }, rt.ArrayItem{ key: 'deferred_transactional_emails', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Deferred emails'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Send transactional emails asynchronously via Action Scheduler instead of during the current request.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'enabled_by_default', val: false }, rt.ArrayItem{ key: 'is_experimental', val: false }]) }, rt.ArrayItem{ key: 'customer_review_request', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Customer review request (beta)'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Send customers a transactional email after order completion inviting them to review the products they bought, and host the per-order Review Order landing page.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'enabled_by_default', val: false }, rt.ArrayItem{ key: 'is_experimental', val: false }]) }, rt.ArrayItem{ key: 'email_improvements', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Email improvements'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Enable modern email design for transactional emails'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'is_experimental', val: false }]) }, rt.ArrayItem{ key: 'blueprint', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Blueprint (beta)'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Enable blueprint to import and export settings in bulk'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'enabled_by_default', val: true }, rt.ArrayItem{ key: 'disable_ui', val: false }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'is_experimental', val: false }]) }, rt.ArrayItem{ key: 'block_email_editor', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Block Email Editor (alpha)'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Enable the block-based email editor for transactional emails.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'learn_more_url', val: 'https://github.com/woocommerce/woocommerce/discussions/52897#discussioncomment-11630256' }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'enabled_by_default', val: false }]) }, rt.ArrayItem{ key: 'point_of_sale', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Point of Sale'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Enable Point of Sale functionality in the WooCommerce mobile apps.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'enabled_by_default', val: true }, rt.ArrayItem{ key: 'disable_ui', val: false }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'is_experimental', val: true }]) }, rt.ArrayItem{ key: 'fulfillments', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Order Fulfillments'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Enable the Order Fulfillments feature to manage order fulfillment and shipping.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'enabled_by_default', val: false }, rt.ArrayItem{ key: 'disable_ui', val: true }, rt.ArrayItem{ key: 'is_experimental', val: false }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }]) }, rt.ArrayItem{ key: 'mcp_integration', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('WooCommerce MCP'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: this.get_mcp_integration_description() }, rt.ArrayItem{ key: 'enabled_by_default', val: false }, rt.ArrayItem{ key: 'disable_ui', val: false }, rt.ArrayItem{ key: 'is_experimental', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'is_legacy', val: false }]) }, rt.ArrayItem{ key: 'destroy-empty-sessions', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Clear Customer Sessions When Empty'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('[Performance] Removes session cookies for non-logged in customers when session data is empty, improving page caching performance. May cause compatibility issues with extensions that depend on the session cookie without using session data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'enabled_by_default', val: false }, rt.ArrayItem{ key: 'is_experimental', val: true }, rt.ArrayItem{ key: 'disable_ui', val: false }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }]) }, rt.ArrayItem{ key: 'agentic_checkout', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Agentic Checkout API'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Enable the Agentic Checkout API for AI-powered checkout experiences (e.g., ChatGPT). This adds REST API endpoints that allow AI agents to create and manage checkout sessions.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'enabled_by_default', val: false }, rt.ArrayItem{ key: 'is_experimental', val: true }, rt.ArrayItem{ key: 'disable_ui', val: true }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }]) }, rt.ArrayItem{ key: 'dual_code_graphql_api', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Dual Code & GraphQL API'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Experimental code-first API for WooCommerce with automatic GraphQL endpoint generation. Requires PHP 8.1 or later.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'enabled_by_default', val: false }, rt.ArrayItem{ key: 'is_experimental', val: true }, rt.ArrayItem{ key: 'disable_ui', val: true }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications.feature_name(), val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Push Notifications'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Enable push notifications for the WooCommerce mobile apps to receive order notifications and store updates.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'enabled_by_default', val: false }, rt.ArrayItem{ key: 'is_experimental', val: true }, rt.ArrayItem{ key: 'disable_ui', val: true }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: false }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }]) }, rt.ArrayItem{ key: 'rest_api_caching', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('REST API Caching'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Enable backend caching and cache control headers for REST API responses via the <code>RestApiCache</code> trait. ⚙️ %1$sConfiguration%2$s'), rt.new_string('woocommerce')]), '<a href="' + (rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=advanced&section=rest_api_caching')])).str() + '">', rt.new_string('</a>')]) }, rt.ArrayItem{ key: 'enabled_by_default', val: false }, rt.ArrayItem{ key: 'is_experimental', val: true }, rt.ArrayItem{ key: 'disable_ui', val: false }, rt.ArrayItem{ key: 'skip_compatibility_checks', val: true }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Internal_Caches_ProductCacheController.feature_name(), val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Cache Product Objects'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('[Performance] Speeds up your store by caching product objects during each request, preventing duplicate product loads. Can improve page load times on product-heavy pages.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }, rt.ArrayItem{ key: 'enabled_by_default', val: false }, rt.ArrayItem{ key: 'is_experimental', val: true }, rt.ArrayItem{ key: 'disable_ui', val: false }]) }])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_tracking_enabled)))) {
		var_legacy_features.array_get_mut('remote_logging').array_get_mut('setting').array_set('value', 'no')
	}
	{
		mut iter_1 := var_legacy_features.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_definition := item_1.val
			mut var_slug := item_1.key
			this.add_feature_definition(var_slug.dup(), var_definition.array_get('name'), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Features_array](var_definition))
		}
	}
	this.init_compatibility_info_by_feature()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) init_compatibility_info_by_feature()  {
	{
		mut iter_1 := rt.func_array_keys(this.features).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_feature_id := item_1.val
			if !(this.compatibility_info_by_feature.array_isset(var_feature_id)) {
				this.compatibility_info_by_feature.array_set(var_feature_id, rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible(), val: rt.new_array() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.incompatible(), val: rt.new_array() }]))
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) get_mcp_integration_description() string {
	mut var_base_description := rt.call_function('__', [rt.new_string('Enable WooCommerce MCP (Model Context Protocol) for AI-powered store operations. AI-generated results and actions can be unpredictable - please review before executing in your store.'), rt.new_string('woocommerce')])
	mut var_permalink_structure := rt.call_function('get_option', [rt.new_string('permalink_structure')])
	if !rt.is_true(var_permalink_structure) {
		mut var_permalinks_url := rt.call_function('admin_url', [rt.new_string('options-permalink.php')])
		mut var_permalink_warning := rt.call_function('sprintf', [rt.new_string('<br><br><strong>%s:</strong> %s <a href="%s">%s</a>'), rt.call_function('__', [rt.new_string('Configuration Required'), rt.new_string('woocommerce')]), rt.call_function('__', [rt.new_string('WordPress permalinks must be set to anything other than "Plain" for MCP to work.'), rt.new_string('woocommerce')]), var_permalinks_url.dup(), rt.call_function('__', [rt.new_string('Configure Permalinks'), rt.new_string('woocommerce')])])
		mut var_documentation_link := rt.call_function('sprintf', [rt.new_string(' <a href="%s" target="_blank">%s</a>'), rt.new_string('https://github.com/woocommerce/woocommerce/blob/trunk/docs/features/mcp/README.md'), rt.call_function('__', [rt.new_string('Learn more'), rt.new_string('woocommerce')])])
		return (var_base_description).str() + (var_permalink_warning).str() + (var_documentation_link).str()
	}
	var_documentation_link = rt.call_function('sprintf', [rt.new_string(' <a href="%s" target="_blank">%s</a>'), rt.new_string('https://github.com/woocommerce/woocommerce/blob/trunk/docs/features/mcp/README.md'), rt.call_function('__', [rt.new_string('Learn more'), rt.new_string('woocommerce')])])
	return (var_base_description).str() + (var_documentation_link).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) register_additional_features()  {
	if rt.is_true(this.registered_additional_features_via_action) {
		return rt.new_null()
	}
	if !rt.is_true(this.features) {
		this.init_feature_definitions()
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_register_feature_definitions'), rt.new_object('Automattic_WooCommerce_Internal_Features_FeaturesController', []string{}, &this)])
	this.init_compatibility_info_by_feature()
	this.registered_additional_features_via_action = true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) init(mut var_proxy Class_Automattic_WooCommerce_Proxies_LegacyProxy, mut var_plugin_util Class_Automattic_WooCommerce_Utilities_PluginUtil)  {
	this.proxy = var_proxy.dup()
	this.plugin_util = var_plugin_util.dup()
	this.plugins_excluded_from_compatibility_ui = var_plugin_util.get_plugins_excluded_from_compatibility_ui()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) get_features(include_experimental bool, include_enabled_info bool) rt.PhpVal {
	mut var_features := this.get_feature_definitions()
	if !(var_include_experimental) {
		closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_feature := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(!(rt.is_true(var_feature.array_get('is_experimental'))))
	}
		var_features = rt.call_function('array_filter', [var_features.dup(), rt.new_closure(closure_3_fn)])
	}
	if var_include_enabled_info {
		{
			mut iter_1 := rt.func_array_keys(var_features.dup()).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_feature_id := item_1.val
				mut var_is_enabled := rt.new_bool(rt.new_bool(false))
				if !(!rt.is_true(var_features.array_get(var_feature_id).array_get('deprecated_since'))) {
					var_is_enabled = // unsupported expression: Expr_Cast_Bool
				} else {
					var_is_enabled = rt.new_bool(this.feature_is_enabled((var_feature_id).str()))
				}
				var_features.array_get_mut(var_feature_id).array_set('is_enabled', var_is_enabled.dup())
			}
		}
	}
	if var_features.array_isset(rt.new_string('product_block_editor')) && !(this.feature_is_enabled('product_block_editor')) {
		var_features.array_get_mut('product_block_editor').array_set('disable_ui', true)
	}
	return var_features.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) get_default_plugin_compatibility(feature_id string) string {
	mut feature_id_mutated := feature_id
	mut var_feature := this.get_feature_definition(feature_id_mutated)
	if rt.is_true(rt.identical(rt.new_null(), var_feature)) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Features_InvalidArgumentException', []string{}, create_automattic_woocommerce_internal_features_invalidargumentexception(rt.call_function('esc_html', [rt.new_string("The WooCommerce feature '${var_feature_id.to_string()}' doesn't exist")]))))
	}
	mut var_default_plugin_compatibility := if !(var_feature.array_get('default_plugin_compatibility')).is_null() { var_feature.array_get('default_plugin_compatibility') } else { Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }
	mut var_incompatible_by_default := // unsupported expression: Expr_Cast_Bool
	return (if rt.is_true(var_incompatible_by_default) { Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.incompatible() } else { Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() }).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) get_feature_definition(feature_id string) rt.PhpVal {
	mut feature_id_mutated := feature_id
	return if !(this.get_feature_definitions().array_get(feature_id_mutated)).is_null() { this.get_feature_definitions().array_get(feature_id_mutated) } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) feature_is_enabled(feature_id string) bool {
	mut feature_id_mutated := feature_id
	mut var_feature := this.get_feature_definition(feature_id_mutated)
	if rt.is_true(rt.identical(rt.new_null(), var_feature)) {
		return false
	}
	if !(!rt.is_true(var_feature.array_get('deprecated_since'))) {
		return (// unsupported expression: Expr_Cast_Bool).to_bool()
	}
	if this.is_preview_email_improvements_enabled(feature_id_mutated) {
		return true
	}
	mut var_default_value := rt.new_string(if this.feature_is_enabled_by_default(feature_id_mutated) { rt.new_string('yes') } else { rt.new_string('no') })
	mut var_value := rt.identical(rt.new_string('yes'), rt.call_function('get_option', [this.feature_enable_option_name(), var_default_value.dup()]))
	return (var_value).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) feature_is_enabled_by_default(feature_id string) bool {
	mut feature_id_mutated := feature_id
	mut var_features := this.get_feature_definitions()
	return !(!rt.is_true())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) change_feature_enable(feature_id string, enable bool) bool {
	mut feature_id_mutated := feature_id
	if !() {
	}
	return ().to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) declare_compatibility(feature_id string, plugin_file string, positive_compatibility bool) bool {
	mut feature_id_mutated := feature_id
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) register_compatibility_internal(feature_id string, plugin_file string, positive_compatibility bool) bool {
	mut feature_id_mutated := feature_id
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) process_pending_declarations()  {
	mut var_feature_id := rt.new_null()
	mut var_plugin_file := ''
	mut var_positive_compatibility := false
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) feature_exists(feature_id string) bool {
	mut feature_id_mutated := feature_id
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) get_compatible_features_for_plugin(plugin_name string, enabled_features_only bool, resolve_uncertain bool) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) get_compatible_plugins_for_feature(feature_id string, active_only bool, resolve_uncertain bool) rt.PhpVal {
	mut feature_id_mutated := feature_id
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) verify_did_woocommerce_init(mut var_function_name Class_Automattic_WooCommerce_Internal_Features_?string) bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) feature_enable_option_name(feature_id string) string {
	mut feature_id_mutated := feature_id
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) should_skip_compatibility_checks(feature_id string) bool {
	mut feature_id_mutated := feature_id
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) allow_enabling_features_with_incompatible_plugins()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) allow_activating_plugins_with_incompatible_features()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) start_listening_for_option_changes()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) process_added_option(option string, var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) process_updated_option(option string, var_old_value rt.PhpVal, var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) add_features_section(var_sections rt.PhpVal) rt.PhpVal {
	mut var_sections_mutated := var_sections
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) add_feature_settings(var_settings rt.PhpVal, var_current_section rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) get_setting_for_feature(feature_id string, mut var_feature Class_Automattic_WooCommerce_Internal_Features_array) rt.PhpVal {
	mut feature_id_mutated := feature_id
	mut var_feature_mutated := var_feature
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) handle_plugin_deactivation(var_plugin_name rt.PhpVal)  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) filter_plugins_list(var_plugin_list rt.PhpVal) rt.PhpVal {
	mut var_plugin_list_mutated := var_plugin_list
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) get_incompatible_plugins(var_feature_id rt.PhpVal, var_plugin_list rt.PhpVal) rt.PhpVal {
	mut var_id := rt.new_null()
	mut var_feature_id_mutated := var_feature_id
	mut var_plugin_list_mutated := var_plugin_list
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) display_notices_in_plugins_page()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) maybe_display_feature_incompatibility_warning()  {
	mut var_id := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) maybe_display_current_feature_filter_description() bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) maybe_invalidate_cached_plugin_data()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) handle_plugin_list_rows(var_plugin_file rt.PhpVal, var_plugin_data rt.PhpVal)  {
	mut var_wp_list_table := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) get_features_page_url() string {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) enqueue_script_to_fix_plugin_list_html(var_current_screen rt.PhpVal)  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) handle_plugins_page_views_list(var_views rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) set_change_feature_enable_nonce(var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) change_feature_enable_from_query_params()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) display_email_improvements_feedback_notice(var_feature_id rt.PhpVal, var_is_enabled rt.PhpVal)  {
	mut var_feature_id_mutated := var_feature_id
	mut var_is_enabled_mutated := var_is_enabled
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_FeaturesController) is_preview_email_improvements_enabled(feature_id string) bool {
	mut feature_id_mutated := feature_id
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

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_site_tracking() &Class_WC_Site_Tracking {
	mut obj := &Class_WC_Site_Tracking{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_features_invalidargumentexception() &Class_Automattic_WooCommerce_Internal_Features_InvalidArgumentException {
	mut obj := &Class_Automattic_WooCommerce_Internal_Features_InvalidArgumentException{
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




pub fn init_wp_content_plugins_woocommerce_src_internal_features_featurescontroller_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
