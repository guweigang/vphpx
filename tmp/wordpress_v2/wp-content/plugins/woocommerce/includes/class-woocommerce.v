import rt

struct Class_WooCommerce {
	rt.PhpObjectBase
pub mut:
	version                  rt.PhpVal = rt.new_string('10.8.1')
	db_version               rt.PhpVal = rt.new_string('920')
	session                  rt.PhpVal = rt.new_null()
	query                    rt.PhpVal = rt.new_null()
	api                      rt.PhpVal = rt.new_null()
	product_factory          rt.PhpVal = rt.new_null()
	countries                rt.PhpVal = rt.new_null()
	integrations             rt.PhpVal = rt.new_null()
	cart                     rt.PhpVal = rt.new_null()
	customer                 rt.PhpVal = rt.new_null()
	order_factory            rt.PhpVal = rt.new_null()
	structured_data          rt.PhpVal = rt.new_null()
	deprecated_hook_handlers rt.PhpVal = rt.new_array()
}

fn init_static_woocommerce() {
	rt.init_static_prop('WooCommerce', '_instance', rt.new_null())
}

fn Class_WooCommerce.instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.get_static_prop('WooCommerce', '_instance').is_null())) {
		rt.set_static_prop('WooCommerce', '_instance', rt.new_object('WooCommerce', []string{},
			create_woocommerce()))
	}
	return rt.get_static_prop('WooCommerce', '_instance')
}

fn (mut this Class_WooCommerce) magic_clone() {
	rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN),
		rt.call_function('__', [rt.new_string('Cloning is forbidden.'),
			rt.new_string('woocommerce')]),
		rt.new_string('2.1')])
}

fn (mut this Class_WooCommerce) magic_wakeup() {
	rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN),
		rt.call_function('__', [
			rt.new_string('Unserializing instances of this class is forbidden.'),
			rt.new_string('woocommerce'),
		]),
		rt.new_string('2.1')])
}

fn (mut this Class_WooCommerce) magic_get(var_key rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('api'), var_key)) {
		if this.api.is_null()
			&& rt.is_true(rt.new_bool(!(rt.is_true(this.legacy_rest_api_is_available())))) {
			this.api = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
				Class_Automattic_WooCommerce_Internal_Utilities_LegacyRestApiStub.class(),
			])
		}
		return this.api
	}
	if rt.is_true(rt.call_function('in_array', [var_key.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'payment_gateways' },
			rt.ArrayItem{ key: none, val: 'shipping' }, rt.ArrayItem{ key: none, val: 'mailer' },
			rt.ArrayItem{ key: none, val: 'checkout' }]),
		rt.new_bool(true)]))
	{
		return rt.call_method(rt.new_object('WooCommerce', []string{}, &this), var_key,
			[]rt.PhpVal{})
	}
	return rt.new_null()
}

fn (mut this Class_WooCommerce) magic_set(key string, var_value rt.PhpVal) {
	if rt.is_true(rt.identical(rt.new_string('api'), rt.new_string(key))) {
		this.api = var_value.clone()
	} else if rt.is_true(rt.call_function('property_exists', [
		rt.new_object('WooCommerce', []string{}, &this),
		rt.new_string(key),
	]))
	{
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(
			'Cannot access private property ' + @STRUCT + '::$' +
			(rt.call_function('esc_html', [rt.new_string(key)])).str())))
	} else {
		this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":234,"name":"key"}',
			var_value.clone())
	}
}

fn (mut this Class_WooCommerce) legacy_rest_api_is_available() rt.PhpVal {
	return rt.call_function('class_exists', [rt.new_string('WC_Legacy_REST_API_Plugin'),
		rt.new_bool(false)])
}

fn (mut this Class_WooCommerce) stable_version() string {
	return (rt.call_function('explode', [rt.new_string('-'), this.version, rt.new_int(2)]).array_get(rt.new_int(0))).str()
}

fn (mut this Class_WooCommerce) construct() {
	this.define_constants()
	this.define_tables()
	this.includes()
	this.init_hooks()
}

fn (mut this Class_WooCommerce) on_plugins_loaded() {
	rt.call_function('do_action', [rt.new_string('woocommerce_loaded')])
}

fn (mut this Class_WooCommerce) init_jetpack_connection_config() {
	mut var_config := create_automattic_jetpack_config()
	var_config.ensure(rt.new_string('connection'), rt.create_array([
		rt.ArrayItem{ key: 'slug', val: 'woocommerce' },
		rt.ArrayItem{ key: 'name', val: 'WooCommerce' },
	]))
}

fn (mut this Class_WooCommerce) init_hooks() {
	rt.call_function('register_activation_hook', [rt.get_constant('WC_PLUGIN_FILE'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Install' },
			rt.ArrayItem{ key: none, val: 'install' }])])
	rt.call_function('register_shutdown_function', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'log_errors' },
		]),
	])
	rt.call_function('add_action', [rt.new_string('plugins_loaded'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'on_plugins_loaded' },
		]),
		rt.new_int(-1)])
	rt.call_function('add_action', [rt.new_string('plugins_loaded'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'init_customizer' },
		])])
	rt.call_function('add_action', [rt.new_string('plugins_loaded'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'init_jetpack_connection_config' },
		]),
		rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('admin_notices'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'build_dependencies_notice' },
		])])
	rt.call_function('add_action', [rt.new_string('after_setup_theme'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'setup_environment' },
		])])
	rt.call_function('add_action', [rt.new_string('after_setup_theme'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'include_template_functions' },
		]),
		rt.new_int(11)])
	rt.call_function('add_action', [rt.new_string('load-post.php'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'includes' },
		])])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'init' },
		]),
		rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'maybe_init_order_reviews' },
		]),
		rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Shortcodes' },
			rt.ArrayItem{ key: none, val: 'init' }])])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Emails' },
			rt.ArrayItem{ key: none, val: 'init_transactional_emails' }])])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_image_sizes' },
		])])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'load_rest_api' },
		])])
	if (this.is_request(rt.new_string('admin')) || (this.is_rest_api_request()
		&& !(this.is_store_api_request())))
		|| (rt.is_true(rt.call_function('defined', [rt.new_string('WP_CLI')]))
		&& rt.is_true(rt.get_constant('WP_CLI'))) {
		rt.call_function('add_action', [rt.new_string('init'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Site_Tracking' },
				rt.ArrayItem{ key: none, val: 'init' }])])
	}
	rt.call_function('add_action', [rt.new_string('switch_blog'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'wpdb_table_fix' },
		]),
		rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('activated_plugin'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'activated_plugin' },
		])])
	rt.call_function('add_action', [rt.new_string('deactivated_plugin'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'deactivated_plugin' },
		])])
	rt.call_function('add_action', [rt.new_string('woocommerce_installed'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_woocommerce_inbox_variant' },
		])])
	rt.call_function('add_action', [rt.new_string('woocommerce_updated'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_woocommerce_inbox_variant' },
		])])
	rt.call_function('add_action', [rt.new_string('rest_api_init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'register_wp_admin_settings' },
		])])
	rt.call_function('add_action', [rt.new_string('woocommerce_installed'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_woocommerce_remote_variant' },
		])])
	rt.call_function('add_action', [rt.new_string('woocommerce_updated'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_woocommerce_remote_variant' },
		])])
	rt.call_function('add_action', [rt.new_string('woocommerce_newly_installed'),
		rt.new_string('wc_set_hooked_blocks_version'), rt.new_int(10)])
	rt.call_function('add_action', [
		rt.new_string('update_option_woocommerce_allow_tracking'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'get_tracking_history' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_action', [
		rt.new_string('update_option_woocommerce_allow_tracking'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'handle_tracking_setting_change' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_action', [
		rt.new_string('action_scheduler_ensure_recurring_actions'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'register_recurring_actions' },
		]),
	])
	rt.call_function('add_action', [rt.new_string('action_scheduler_init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_recurring_action_wrappers' },
		])])
	rt.call_function('add_filter', [rt.new_string('robots_txt'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'robots_txt' },
		])])
	rt.call_function('add_filter', [rt.new_string('wp_plugin_dependencies_slug'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'convert_woocommerce_slug' },
		])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_register_log_handlers'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'register_remote_log_handler' },
		])])
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_DownloadPermissionsAdjuster.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_AssignDefaultCategory.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_ProductImage_MatchImageBySKU.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_RestockRefundedItemsAdjuster.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_Caches_ProductCacheController.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_Settings_OptionSanitizer.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_Features_FeaturesController.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_Utilities_WebhookUtil.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_Admin_Marketplace.class(),
	])
	rt.call_method(var_container, 'get', [Class_TimeUtil.class()])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonAdminBarBadge.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonCacheInvalidator.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonRequestHandler.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Caches_OrderCountCacheService.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_Email_DeferredEmailQueue.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_AddressProvider_AddressProviderController.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRegistry.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_Caches_TaxRateVersionStringInvalidator.class(),
	])
	mut iife_temp_0 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_0 := iife_temp_0.is_true(rt.new_string('WOOCOMMERCE_BIS_ALPHA_ENABLED'))
	if rt.is_true(iife_result_0) {
		rt.call_method(var_container, 'get', [
			Class_Automattic_WooCommerce_Internal_StockNotifications_StockNotifications.class(),
		])
	}
	rt.call_method(rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_Utilities_PluginInstaller.class(),
	]), 'register', []rt.PhpVal{})
	rt.call_method(rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine.class(),
	]), 'register', []rt.PhpVal{})
	rt.call_method(rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionController.class(),
	]), 'register', []rt.PhpVal{})
	rt.call_method(rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionBlocksController.class(),
	]), 'register', []rt.PhpVal{})
	rt.call_method(rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController.class(),
	]), 'register', []rt.PhpVal{})
	rt.call_method(rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsController.class(),
	]), 'register', []rt.PhpVal{})
	rt.call_method(rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsController.class(),
	]), 'register', []rt.PhpVal{})
	rt.call_method(rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_Utilities_LegacyRestApiStub.class(),
	]), 'register', []rt.PhpVal{})
	rt.call_method(rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_Email_EmailStyleSync.class(),
	]), 'register', []rt.PhpVal{})
	rt.call_method(rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsController.class(),
	]), 'register', []rt.PhpVal{})
	rt.call_method(rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticController.class(),
	]), 'register', []rt.PhpVal{})
	rt.call_method(rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_ProductFeed_ProductFeed.class(),
	]), 'register', []rt.PhpVal{})
	rt.call_method(rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications.class(),
	]), 'register', []rt.PhpVal{})
	rt.call_method(rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleEmailHandler.class(),
	]), 'register', []rt.PhpVal{})
	rt.call_method(rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingRestController.class(),
	]), 'register', []rt.PhpVal{})
	rt.call_method(rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_Orders_OrderActionsRestController.class(),
	]), 'register', []rt.PhpVal{})
	rt.call_method(rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_Orders_OrderStatusRestController.class(),
	]), 'register', []rt.PhpVal{})
	rt.call_method(rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsRestController.class(),
	]), 'register', []rt.PhpVal{})
	rt.call_method(rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController.class(),
	]), 'register', []rt.PhpVal{})
	rt.call_method(rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreviewRestController.class(),
	]), 'register', []rt.PhpVal{})
	rt.call_method(rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_Admin_Emails_EmailListingRestController.class(),
	]), 'register', []rt.PhpVal{})
	rt.call_method(rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_ProductFilters_MainQueryController.class(),
	]), 'register', []rt.PhpVal{})
	rt.call_method(rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_ProductFilters_CacheController.class(),
	]), 'register', []rt.PhpVal{})
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Api_Main{}
	mut iife_result_1 := iife_temp_1.register()
	mut iife_temp_2 := Class_WC_Admin_Reports{}
	mut iife_result_2 := iife_temp_2.register_orders_hook_handlers()
}

fn (mut this Class_WooCommerce) add_woocommerce_inbox_variant() {
	mut var_config_name := rt.new_string('woocommerce_inbox_variant_assignment')
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('get_option', [
		var_config_name.clone(),
		rt.new_bool(false),
	])))
	{
		rt.call_function('update_option', [var_config_name.clone(),
			rt.call_function('wp_rand', [rt.new_int(1), rt.new_int(12)])])
	}
}

fn (mut this Class_WooCommerce) add_woocommerce_remote_variant() {
	mut var_config_name := rt.new_string('woocommerce_remote_variant_assignment')
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('get_option', [
		var_config_name.clone(),
		rt.new_bool(false),
	])))
	{
		rt.call_function('update_option', [var_config_name.clone(),
			rt.call_function('wp_rand', [rt.new_int(1), rt.new_int(120)])])
	}
}

fn (mut this Class_WooCommerce) log_errors() {
	mut var_error := rt.call_function('error_get_last', []rt.PhpVal{})
	if rt.is_true(var_error)
		&& rt.is_true(rt.call_function('in_array', [var_error.array_get(rt.new_string('type')), rt.create_array([rt.ArrayItem{
		key: none
		val: rt.get_constant('E_ERROR')
	}, rt.ArrayItem{ key: none, val: rt.get_constant('E_PARSE') }, rt.ArrayItem{
		key: none
		val: rt.get_constant('E_COMPILE_ERROR')
	}, rt.ArrayItem{ key: none, val: rt.get_constant('E_USER_ERROR') }, rt.ArrayItem{
		key: none
		val: rt.get_constant('E_RECOVERABLE_ERROR')
	}]), rt.new_bool(true)])) {
		mut var_error_copy := var_error.clone()
		mut var_message := var_error_copy.array_get(rt.new_string('message'))
		var_error_copy.array_unset(rt.new_string('message'))
		mut var_context := {
			'source':         rt.new_string('fatal-errors')
			'error':          var_error_copy
			'remote-logging': rt.new_bool(true)
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [
			var_message.clone(),
			rt.new_string('Stack trace:'),
		])))))
		{
			mut var_segments := rt.call_function('explode', [
				rt.new_string('Stack trace:'),
				var_message.clone(),
			])
			var_message = rt.call_function('str_replace', [rt.get_constant('PHP_EOL'),
				rt.new_string(' '),
				rt.new_string(var_segments.array_get(rt.new_int(0)).to_string().trim_space())])
			mut var_backtrace := rt.call_function('array_map', [
				rt.new_string('trim'),
				rt.call_function('explode', [
					rt.get_constant('PHP_EOL'),
					var_segments.array_get(rt.new_int(1)),
				])])
			var_context['backtrace'] = var_backtrace.clone()
		} else {
			var_context['backtrace'] = rt.new_bool(true)
		}
		mut var_logger := rt.call_function('wc_get_logger', []rt.PhpVal{})
		rt.call_method(var_logger, 'critical', [var_message.clone(),
			rt.create_array_from_native_map(var_context)])
		rt.call_function('do_action', [rt.new_string('woocommerce_shutdown_error'),
			var_error.clone()])
	}
}

fn (mut this Class_WooCommerce) define_constants() {
	this.define(rt.new_string('WC_ABSPATH'), rt.new_string(
		(rt.call_function('dirname', [rt.get_constant('WC_PLUGIN_FILE')])).str() + '/'))
	this.define(rt.new_string('WC_PLUGIN_BASENAME'), rt.call_function('plugin_basename', [
		rt.get_constant('WC_PLUGIN_FILE'),
	]))
	this.define(rt.new_string('WC_VERSION'), this.version)
	this.define(rt.new_string('WOOCOMMERCE_VERSION'), this.version)
	this.define(rt.new_string('WC_ROUNDING_PRECISION'), rt.new_int(6))
	this.define(rt.new_string('WC_DISCOUNT_ROUNDING_MODE'), rt.new_int(2))
	this.define(rt.new_string('WC_TAX_ROUNDING_MODE'), rt.new_int(if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_prices_include_tax'),
		rt.new_string('no'),
	])))
	{ 2 } else { 1 }))
	this.define(rt.new_string('WC_DELIMITER'), rt.new_string('|'))
	this.define(rt.new_string('WC_SESSION_CACHE_GROUP'), rt.new_string('wc_session_id'))
	this.define(rt.new_string('WC_TEMPLATE_DEBUG_MODE'), rt.new_bool(false))
	if rt.is_true(rt.call_function('defined', [rt.new_string('WC_LOG_DIR')])) {
		this.define(rt.new_string('WC_LOG_DIR_CUSTOM'), rt.new_bool(true))
	} else {
		mut iife_temp_3 := Class_LoggingUtil{}
		mut iife_result_3 := iife_temp_3.get_log_directory(rt.new_bool(false))
		this.define(rt.new_string('WC_LOG_DIR'), iife_result_3)
	}
	this.define(rt.new_string('WC_NOTICE_MIN_PHP_VERSION'), rt.new_string('7.2'))
	this.define(rt.new_string('WC_NOTICE_MIN_WP_VERSION'), rt.new_string('5.2'))
	this.define(rt.new_string('WC_PHP_MIN_REQUIREMENTS_NOTICE'), rt.new_string(
		'wp_php_min_requirements_' +(rt.get_constant('WC_NOTICE_MIN_PHP_VERSION')).str() + '_' +
		(rt.get_constant('WC_NOTICE_MIN_WP_VERSION')).str()))
	this.define(rt.new_string('WC_SSR_PLUGIN_UPDATE_RELEASE_VERSION_TYPE'), rt.new_string('none'))
}

fn (mut this Class_WooCommerce) define_tables() {
	mut var_wpdb := rt.new_null()
	mut var_tables := {
		'payment_tokenmeta':      'woocommerce_payment_tokenmeta'
		'order_itemmeta':         'woocommerce_order_itemmeta'
		'wc_product_meta_lookup': 'wc_product_meta_lookup'
		'wc_tax_rate_classes':    'wc_tax_rate_classes'
		'wc_reserved_stock':      'wc_reserved_stock'
	}
	for var_name, var_table in var_tables {
		rt.set_property(var_wpdb, '{"nodeType":"Expr_Variable","line":569,"name":"name"}',

			(rt.get_property(var_wpdb, 'prefix')).str() + table)
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			rt.new_string(table),
			rt.get_property(var_wpdb, 'tables'),
			rt.new_bool(true),
		])))))
		{
			rt.get_property(var_wpdb, 'tables').array_push(table)
		}
	}
}

fn (mut this Class_WooCommerce) define(var_name rt.PhpVal, var_value rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		var_name.clone()])))))
	{
		rt.call_function('define', [var_name.clone(), var_value.clone()])
	}
}

fn (mut this Class_WooCommerce) is_rest_api_request() bool {
	if !rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))) {
		return false
	}
	mut var_rest_prefix := rt.call_function('trailingslashit', [
		rt.call_function('rest_get_url_prefix', []rt.PhpVal{}),
	])
	mut var_is_rest_api_request := rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [
		rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
		var_rest_prefix.clone(),
	]))))
	return (rt.call_function('apply_filters', [
		rt.new_string('woocommerce_is_rest_api_request'),
		var_is_rest_api_request.clone(),
	])).to_bool()
}

fn (mut this Class_WooCommerce) is_store_api_request() bool {
	if !rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))) {
		return false
	}
	return rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [
		rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
		rt.new_string(
			(rt.call_function('trailingslashit', [rt.call_function('rest_get_url_prefix', []rt.PhpVal{})])).str() +
			'wc/store/'),
	]))))
}

fn (mut this Class_WooCommerce) load_rest_api() {
	mut iife_temp_4 := Class_Automattic_WooCommerce_RestApi_Server{}
	mut iife_result_4 := iife_temp_4.instance()
	rt.call_method(iife_result_4, 'init', []rt.PhpVal{})
}

fn (mut this Class_WooCommerce) is_request(var_type rt.PhpVal) bool {
	mut switch_val_1 := var_type
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('admin'))) {
		return (rt.call_function('is_admin', []rt.PhpVal{})).to_bool()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('ajax'))) {
		return (rt.call_function('defined', [rt.new_string('DOING_AJAX')])).to_bool()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('cron'))) {
		return (rt.call_function('defined', [rt.new_string('DOING_CRON')])).to_bool()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('frontend'))) {
		return rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})))))
			|| rt.is_true(rt.call_function('defined', [rt.new_string('DOING_AJAX')]))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('DOING_CRON')])))))
			&& !(this.is_rest_api_request())
	} else {
		return false
	}
	return false
}

fn (mut this Class_WooCommerce) includes() {
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-autoloader.php', '2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/interfaces/class-wc-abstract-order-data-store-interface.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/interfaces/class-wc-coupon-data-store-interface.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/interfaces/class-wc-customer-data-store-interface.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/interfaces/class-wc-customer-download-data-store-interface.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/interfaces/class-wc-customer-download-log-data-store-interface.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/interfaces/class-wc-object-data-store-interface.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/interfaces/class-wc-order-data-store-interface.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/interfaces/class-wc-order-item-data-store-interface.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/interfaces/class-wc-order-item-product-data-store-interface.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/interfaces/class-wc-order-item-type-data-store-interface.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/interfaces/class-wc-order-refund-data-store-interface.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/interfaces/class-wc-payment-token-data-store-interface.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/interfaces/class-wc-product-data-store-interface.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/interfaces/class-wc-product-variable-data-store-interface.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/interfaces/class-wc-shipping-zone-data-store-interface.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/interfaces/class-wc-logger-interface.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/interfaces/class-wc-log-handler-interface.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/interfaces/class-wc-webhooks-data-store-interface.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/interfaces/class-wc-queue-interface.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/traits/trait-wc-item-totals.php', '2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/abstracts/abstract-wc-address-provider.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/abstracts/abstract-wc-data.php', '2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/abstracts/abstract-wc-object-query.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/abstracts/abstract-wc-payment-token.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/abstracts/abstract-wc-product.php', '2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/abstracts/abstract-wc-order.php', '2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/abstracts/abstract-wc-settings-api.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/abstracts/abstract-wc-shipping-method.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/abstracts/abstract-wc-payment-gateway.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/abstracts/abstract-wc-integration.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/abstracts/abstract-wc-log-handler.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/abstracts/abstract-wc-deprecated-hooks.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/abstracts/abstract-wc-session.php', '2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/abstracts/abstract-wc-privacy.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wc-core-functions.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-datetime.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-post-types.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-install.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-geolocation.php',
		'2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-download-handler.php',
		'2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-comments.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-post-data.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-ajax.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-emails.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-data-exception.php',
		'2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-query.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-meta-data.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-order-factory.php',
		'2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-order-query.php',
		'2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-product-factory.php',
		'2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-product-query.php',
		'2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-payment-tokens.php',
		'2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-shipping-zone.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/gateways/class-wc-payment-gateway-cc.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/gateways/class-wc-payment-gateway-echeck.php',
		'2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-countries.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-integrations.php',
		'2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-cache-helper.php',
		'2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-https.php', '2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-deprecated-action-hooks.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-deprecated-filter-hooks.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-background-emailer.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-discounts.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-cart-totals.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/customizer/class-wc-shop-customizer.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-regenerate-images.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-privacy.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-structured-data.php',
		'2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-shortcodes.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-logger.php', '2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/queue/class-wc-action-queue.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/queue/class-wc-queue.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/marketplace-suggestions/class-wc-marketplace-updater.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/class-wc-admin-marketplace-promotions.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/blocks/class-wc-blocks-utils.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-data-store.php', '2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/data-stores/class-wc-data-store-wp.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/data-stores/class-wc-coupon-data-store-cpt.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/data-stores/class-wc-product-data-store-cpt.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/data-stores/class-wc-product-grouped-data-store-cpt.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/data-stores/class-wc-product-variable-data-store-cpt.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/data-stores/class-wc-product-variation-data-store-cpt.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/data-stores/abstract-wc-order-item-type-data-store.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/data-stores/class-wc-order-item-data-store.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/data-stores/class-wc-order-item-coupon-data-store.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/data-stores/class-wc-order-item-fee-data-store.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/data-stores/class-wc-order-item-product-data-store.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/data-stores/class-wc-order-item-shipping-data-store.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/data-stores/class-wc-order-item-tax-data-store.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/data-stores/class-wc-payment-token-data-store.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/data-stores/class-wc-customer-data-store.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/data-stores/class-wc-customer-data-store-session.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/data-stores/class-wc-customer-download-data-store.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/data-stores/class-wc-customer-download-log-data-store.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/data-stores/class-wc-shipping-zone-data-store.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/data-stores/abstract-wc-order-data-store-cpt.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/data-stores/class-wc-order-data-store-cpt.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/data-stores/class-wc-order-refund-data-store-cpt.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/data-stores/class-wc-webhook-data-store.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-rest-authentication.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-rest-exception.php',
		'2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-auth.php', '2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-register-wp-admin-settings.php',
		'2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/tracks/class-wc-tracks.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/tracks/class-wc-tracks-event.php', '2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/tracks/class-wc-tracks-client.php', '2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/tracks/class-wc-tracks-footer-pixel.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/tracks/class-wc-site-tracking.php', '2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/wccom-site/class-wc-wccom-site.php', '2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/product-usage/class-wc-product-usage.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'packages/action-scheduler/action-scheduler.php',
		'2')
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_CLI')]))
		&& rt.is_true(rt.get_constant('WP_CLI')) {
		rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-cli.php', '2')
	}
	if this.is_request(rt.new_string('admin')) {
		rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/class-wc-admin.php',
			'2')
		rt.include_file(
			(rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/woocommerce-legacy-reports.php',
			'2')
	}
	mut var_in_post_editor := rt.new_bool(
		rt.is_true(rt.call_function('doing_action', [rt.new_string('load-post.php')]))
		|| rt.is_true(rt.call_function('doing_action', [rt.new_string('load-post-new.php')])))
	if this.is_request(rt.new_string('frontend')) || this.is_rest_api_request()
		|| rt.is_true(var_in_post_editor) {
		this.frontend_includes()
	}
	this.theme_support_includes()
	this.query = create_wc_query()
}

fn (mut this Class_WooCommerce) theme_support_includes() {
	if rt.is_true(rt.call_function('wc_is_wp_default_theme_active', []rt.PhpVal{})) {
		mut switch_val_2 := rt.call_function('get_template', []rt.PhpVal{})
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('twentyten'))) {
			rt.include_file(
				(rt.get_constant('WC_ABSPATH')).str() + 'includes/theme-support/class-wc-twenty-ten.php',
				'2')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('twentyeleven'))) {
			rt.include_file(
				(rt.get_constant('WC_ABSPATH')).str() + 'includes/theme-support/class-wc-twenty-eleven.php',
				'2')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('twentytwelve'))) {
			rt.include_file(
				(rt.get_constant('WC_ABSPATH')).str() + 'includes/theme-support/class-wc-twenty-twelve.php',
				'2')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('twentythirteen'))) {
			rt.include_file(
				(rt.get_constant('WC_ABSPATH')).str() + 'includes/theme-support/class-wc-twenty-thirteen.php',
				'2')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('twentyfourteen'))) {
			rt.include_file(
				(rt.get_constant('WC_ABSPATH')).str() + 'includes/theme-support/class-wc-twenty-fourteen.php',
				'2')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('twentyfifteen'))) {
			rt.include_file(
				(rt.get_constant('WC_ABSPATH')).str() + 'includes/theme-support/class-wc-twenty-fifteen.php',
				'2')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('twentysixteen'))) {
			rt.include_file(
				(rt.get_constant('WC_ABSPATH')).str() + 'includes/theme-support/class-wc-twenty-sixteen.php',
				'2')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('twentyseventeen'))) {
			rt.include_file(
				(rt.get_constant('WC_ABSPATH')).str() + 'includes/theme-support/class-wc-twenty-seventeen.php',
				'2')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('twentynineteen'))) {
			rt.include_file(
				(rt.get_constant('WC_ABSPATH')).str() + 'includes/theme-support/class-wc-twenty-nineteen.php',
				'2')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('twentytwenty'))) {
			rt.include_file(
				(rt.get_constant('WC_ABSPATH')).str() + 'includes/theme-support/class-wc-twenty-twenty.php',
				'2')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('twentytwentyone'))) {
			rt.include_file(
				(rt.get_constant('WC_ABSPATH')).str() + 'includes/theme-support/class-wc-twenty-twenty-one.php',
				'2')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('twentytwentytwo'))) {
			rt.include_file(
				(rt.get_constant('WC_ABSPATH')).str() + 'includes/theme-support/class-wc-twenty-twenty-two.php',
				'2')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('twentytwentythree'))) {
			rt.include_file(
				(rt.get_constant('WC_ABSPATH')).str() + 'includes/theme-support/class-wc-twenty-twenty-three.php',
				'2')
		}
	}
}

fn (mut this Class_WooCommerce) frontend_includes() {
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wc-cart-functions.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wc-notice-functions.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wc-template-hooks.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-template-loader.php',
		'2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-frontend-scripts.php',
		'2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-form-handler.php',
		'2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-cart.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-tax.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-shipping-zones.php',
		'2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-customer.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-embed.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-session-handler.php',
		'2')
}

fn (mut this Class_WooCommerce) include_template_functions() {
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wc-template-functions.php',
		'2')
}

fn (mut this Class_WooCommerce) init() {
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_Features_FeaturesController.class(),
	]), 'register_additional_features', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('before_woocommerce_init')])
	this.load_plugin_textdomain()
	this.product_factory = create_wc_product_factory()
	this.order_factory = create_wc_order_factory()
	this.countries = create_wc_countries()
	this.integrations = create_wc_integrations()
	this.structured_data = create_wc_structured_data()
	this.deprecated_hook_handlers.array_set('actions', create_wc_deprecated_action_hooks())
	this.deprecated_hook_handlers.array_set('filters', create_wc_deprecated_filter_hooks())
	if this.is_request(rt.new_string('frontend')) {
		rt.call_function('wc_load_cart', []rt.PhpVal{})
	}
	this.load_webhooks()
	rt.call_function('do_action', [rt.new_string('woocommerce_init')])
}

fn (mut this Class_WooCommerce) maybe_init_order_reviews() {
	mut iife_temp_5 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_5 := iife_temp_5.feature_is_enabled(rt.new_string('customer_review_request'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_5)))) {
		return
	}
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_OrderReviews_Scheduler.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.class(),
	])
}

fn (mut this Class_WooCommerce) load_plugin_textdomain() {
	mut var_locale := rt.call_function('apply_filters', [rt.new_string('plugin_locale'),
		rt.call_function('determine_locale', []rt.PhpVal{}), rt.new_string('woocommerce')])
	mut var_custom_translation_path := rt.new_string(
		(rt.get_constant('WP_LANG_DIR')).str() + '/woocommerce/woocommerce-' + var_locale.str() +
		'.mo')
	mut var_plugin_translation_path := rt.new_string(
		(rt.get_constant('WP_LANG_DIR')).str() + '/plugins/woocommerce-' + var_locale.str() + '.mo')
	if rt.is_true(rt.call_function('is_readable', [var_custom_translation_path.clone()])) {
		rt.call_function('unload_textdomain', [rt.new_string('woocommerce')])
		rt.call_function('load_textdomain', [rt.new_string('woocommerce'),
			var_custom_translation_path.clone()])
		rt.call_function('load_textdomain', [rt.new_string('woocommerce'),
			var_plugin_translation_path.clone()])
	}
}

fn (mut this Class_WooCommerce) setup_environment() {
	this.define(rt.new_string('WC_TEMPLATE_PATH'), this.template_path())
	this.add_thumbnail_support()
}

fn (mut this Class_WooCommerce) add_thumbnail_support() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('post-thumbnails'),
	])))))
	{
		rt.call_function('add_theme_support', [rt.new_string('post-thumbnails')])
	}
	rt.call_function('add_post_type_support', [rt.new_string('product'),
		rt.new_string('thumbnail')])
}

fn (mut this Class_WooCommerce) add_image_sizes() {
	mut var_thumbnail := rt.call_function('wc_get_image_size', [
		rt.new_string('thumbnail'),
	])
	mut var_single := rt.call_function('wc_get_image_size', [
		rt.new_string('single')])
	mut var_gallery_thumbnail := rt.call_function('wc_get_image_size', [
		rt.new_string('gallery_thumbnail'),
	])
	rt.call_function('add_image_size', [rt.new_string('woocommerce_thumbnail'),
		var_thumbnail.array_get(rt.new_string('width')), var_thumbnail.array_get(rt.new_string('height')),
		var_thumbnail.array_get(rt.new_string('crop'))])
	rt.call_function('add_image_size', [rt.new_string('woocommerce_single'),
		var_single.array_get(rt.new_string('width')), var_single.array_get(rt.new_string('height')),
		var_single.array_get(rt.new_string('crop'))])
	rt.call_function('add_image_size', [rt.new_string('woocommerce_gallery_thumbnail'),
		var_gallery_thumbnail.array_get(rt.new_string('width')),
		var_gallery_thumbnail.array_get(rt.new_string('height')),
		var_gallery_thumbnail.array_get(rt.new_string('crop'))])
}

fn (mut this Class_WooCommerce) plugin_url() rt.PhpVal {
	return rt.call_function('untrailingslashit', [
		rt.call_function('plugins_url', [rt.new_string('/'), rt.get_constant('WC_PLUGIN_FILE')]),
	])
}

fn (mut this Class_WooCommerce) plugin_path() rt.PhpVal {
	return rt.call_function('untrailingslashit', [
		rt.call_function('plugin_dir_path', [rt.get_constant('WC_PLUGIN_FILE')]),
	])
}

fn (mut this Class_WooCommerce) template_path() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_template_path'),
		rt.new_string('woocommerce/')])
	return rt.new_null()
}

fn (mut this Class_WooCommerce) ajax_url() rt.PhpVal {
	return rt.call_function('admin_url', [rt.new_string('admin-ajax.php'),
		rt.new_string('relative')])
}

fn (mut this Class_WooCommerce) api_request_url(var_request rt.PhpVal, var_ssl rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(var_ssl.clone().is_null())) {
		mut var_scheme := rt.call_function('wp_parse_url', [
			rt.call_function('home_url', []rt.PhpVal{}),
			rt.get_constant('PHP_URL_SCHEME'),
		])
	} else if rt.is_true(var_ssl) {
		var_scheme = rt.new_string('https')
	} else {
		var_scheme = rt.new_string('http')
	}
	if rt.is_true(rt.call_function('strstr', [
		rt.call_function('get_option', [rt.new_string('permalink_structure')]),
		rt.new_string('/index.php/'),
	]))
	{
		mut var_api_request_url := rt.call_function('trailingslashit', [
			rt.call_function('home_url', [
				rt.new_string('/index.php/wc-api/' + var_request.str()),
				var_scheme.clone(),
			]),
		])
	} else if rt.is_true(rt.call_function('get_option', [
		rt.new_string('permalink_structure'),
	]))
	{
		var_api_request_url = rt.call_function('trailingslashit', [
			rt.call_function('home_url', [
				rt.new_string('/wc-api/' + var_request.str()),
				var_scheme.clone(),
			]),
		])
	} else {
		var_api_request_url = rt.call_function('add_query_arg', [
			rt.new_string('wc-api'), var_request.clone(),
			rt.call_function('trailingslashit', [
				rt.call_function('home_url', [rt.new_string(''),
					var_scheme.clone()]),
			])])
	}
	return rt.call_function('esc_url_raw', [
		rt.call_function('apply_filters', [rt.new_string('woocommerce_api_request_url'),
			var_api_request_url.clone(), var_request.clone(),
			var_ssl.clone()]),
	])
	return rt.new_null()
}

fn (mut this Class_WooCommerce) load_webhooks() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_blog_installed', []rt.PhpVal{}))))) {
		return
	}
	mut var_limit := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_load_webhooks_limit'),
		rt.new_null(),
	])
	rt.call_function('wc_load_webhooks', [rt.new_string('active'),
		var_limit.clone()])
}

fn (mut this Class_WooCommerce) initialize_cart() {
	if this.customer.is_null()
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(this.customer, 'WC_Customer')))))) {
		this.customer = create_wc_customer(rt.call_function('get_current_user_id', []rt.PhpVal{}),
			rt.new_bool(true))
		rt.call_function('add_action', [rt.new_string('shutdown'),
			rt.create_array([rt.ArrayItem{ key: none, val: this.customer },
				rt.ArrayItem{ key: none, val: 'save' }]),
			rt.new_int(10)])
	}
	if this.cart.is_null()
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(this.cart, 'WC_Cart')))))) {
		this.cart = create_wc_cart()
	}
}

fn (mut this Class_WooCommerce) initialize_session() {
	mut var_session_class := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_session_handler'),
		rt.new_string('WC_Session_Handler'),
	])
	if this.session.is_null()
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(this.session, '{"nodeType":"Expr_Variable","line":1188,"name":"session_class"}')))))) {
		this.session = rt.create_object_dynamically(var_session_class, []rt.PhpVal{})
		rt.call_method(this.session, 'init', []rt.PhpVal{})
	}
}

fn (mut this Class_WooCommerce) robots_txt(var_output rt.PhpVal) rt.PhpVal {
	mut var_site_url := rt.call_function('wp_parse_url', [
		rt.call_function('site_url', []rt.PhpVal{}),
	])
	mut var_path := if !(!rt.is_true(var_site_url.array_get(rt.new_string('path')))) {
		var_site_url.array_get(rt.new_string('path'))
	} else {
		rt.new_string('')
	}
	mut var_lines := rt.call_function('preg_split', [rt.new_string('/\\r\\n|\\r|\\n/'),
		var_output.clone()])
	mut var_agent_index := rt.call_function('array_search', [
		rt.new_string('User-agent: *'),
		var_lines.clone(),
		rt.new_bool(true),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_agent_index)))) {
		mut var_above := rt.call_function('array_slice', [var_lines.clone(),
			rt.new_int(0), rt.add(var_agent_index, rt.new_int(1))])
		mut var_below := rt.call_function('array_slice', [var_lines.clone(),
			rt.add(var_agent_index, rt.new_int(1))])
	} else {
		var_above = var_lines.clone()
		var_below = rt.new_array()
		var_above.array_push('')
		var_above.array_push('User-agent: *')
	}
	var_above.array_push('Disallow: ${var_path.to_string()}/wp-content/uploads/wc-logs/')
	var_above.array_push('Disallow: ${var_path.to_string()}/wp-content/uploads/woocommerce_transient_files/')
	var_above.array_push('Disallow: ${var_path.to_string()}/wp-content/uploads/woocommerce_uploads/')
	var_above.array_push('Disallow: /*?add-to-cart=')
	var_above.array_push('Disallow: /*?*add-to-cart=')
	var_lines = rt.call_function('array_merge', [var_above.clone(),
		var_below.clone()])
	return rt.call_function('implode', [rt.get_constant('PHP_EOL'),
		var_lines.clone()])
}

fn (mut this Class_WooCommerce) wpdb_table_fix() {
	this.define_tables()
}

fn (mut this Class_WooCommerce) activated_plugin(var_filename rt.PhpVal) {
	rt.include_file(@DIR + '/admin/helper/class-wc-helper.php', '2')
	if rt.is_true(rt.identical(rt.new_string('/woocommerce.php'), rt.call_function('substr', [
		var_filename.clone(),
		rt.new_int(-16),
	])))
	{
		rt.call_function('set_transient', [rt.new_string('woocommerce_activated_plugin'),
			var_filename.clone()])
	}
	mut iife_temp_6 := Class_WC_Helper{}
	mut iife_result_6 := iife_temp_6.activated_plugin(var_filename.clone())
}

fn (mut this Class_WooCommerce) deactivated_plugin(var_filename rt.PhpVal) {
	rt.include_file(@DIR + '/admin/helper/class-wc-helper.php', '2')
	mut iife_temp_7 := Class_WC_Helper{}
	mut iife_result_7 := iife_temp_7.deactivated_plugin(var_filename.clone())
}

fn (mut this Class_WooCommerce) queue() rt.PhpVal {
	mut iife_temp_8 := Class_WC_Queue{}
	mut iife_result_8 := iife_temp_8.instance()
	return iife_result_8
}

fn (mut this Class_WooCommerce) checkout() rt.PhpVal {
	mut iife_temp_9 := Class_WC_Checkout{}
	mut iife_result_9 := iife_temp_9.instance()
	return iife_result_9
}

fn (mut this Class_WooCommerce) payment_gateways() rt.PhpVal {
	mut iife_temp_10 := Class_WC_Payment_Gateways{}
	mut iife_result_10 := iife_temp_10.instance()
	return iife_result_10
}

fn (mut this Class_WooCommerce) shipping() rt.PhpVal {
	mut iife_temp_11 := Class_WC_Shipping{}
	mut iife_result_11 := iife_temp_11.instance()
	return iife_result_11
}

fn (mut this Class_WooCommerce) mailer() rt.PhpVal {
	mut iife_temp_12 := Class_WC_Emails{}
	mut iife_result_12 := iife_temp_12.instance()
	return iife_result_12
}

fn (mut this Class_WooCommerce) build_dependencies_satisfied() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
			'/assets/css/admin.css'),
	])))))
	{
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
			'/assets/js/admin/woocommerce_admin.min.js'),
	])))))
	{
		return false
	}
	return true
}

fn (mut this Class_WooCommerce) build_dependencies_notice() {
	if this.build_dependencies_satisfied() {
		return
	}
	mut var_message_one := rt.call_function('__', [
		rt.new_string("You have installed a development version of WooCommerce which requires files to be built and minified. From the plugin directory, run <code>pnpm install</code> and then <code>pnpm --filter='@woocommerce/plugin-woocommerce' build</code> to build and minify assets."),
		rt.new_string('woocommerce'),
	])
	mut var_message_two := rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('Or you can download a pre-built version of the plugin from the <a href="%1$s">WordPress.org repository</a> or by visiting <a href="%2$s">the releases page in the GitHub repository</a>.'),
			rt.new_string('woocommerce'),
		]),
		rt.new_string('https://wordpress.org/plugins/woocommerce/'),
		rt.new_string('https://github.com/woocommerce/woocommerce/releases'),
	])
	rt.call_function('printf', [rt.new_string('<div class="error"><p>%s %s</p></div>'),
		var_message_one.clone(), var_message_two.clone()])
}

fn (mut this Class_WooCommerce) is_wc_admin_active() rt.PhpVal {
	return rt.call_function('function_exists', [rt.new_string('wc_admin_url')])
}

fn (mut this Class_WooCommerce) call_function(var_function_name rt.PhpVal, var_parameters rt.PhpVal) rt.PhpVal {
	return rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [Class_Automattic_WooCommerce_Proxies_LegacyProxy.class()]), 'call_function', [
		var_function_name.clone(),
		var_parameters.clone(),
	])
}

fn (mut this Class_WooCommerce) call_static(var_class_name rt.PhpVal, var_method_name rt.PhpVal, var_parameters rt.PhpVal) rt.PhpVal {
	return rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [Class_Automattic_WooCommerce_Proxies_LegacyProxy.class()]), 'call_static', [
		var_class_name.clone(),
		var_method_name.clone(),
		var_parameters.clone(),
	])
}

fn (mut this Class_WooCommerce) get_instance_of(class_name string, var_args rt.PhpVal) rt.PhpVal {
	return rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [Class_Automattic_WooCommerce_Proxies_LegacyProxy.class()]), 'get_instance_of', [
		rt.new_string(class_name),
		var_args.clone(),
	])
}

fn (mut this Class_WooCommerce) get_global(global_name string) rt.PhpVal {
	return rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [Class_Automattic_WooCommerce_Proxies_LegacyProxy.class()]), 'get_global', [
		rt.new_string(global_name),
	])
}

fn (mut this Class_WooCommerce) register_wp_admin_settings() {
	mut iife_temp_13 := Class_WC_Admin_Settings{}
	mut iife_result_13 := iife_temp_13.get_settings_pages()
	mut var_pages := iife_result_13
	mut iter_1 := var_pages.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_page := item_1.val
		create_wc_register_wp_admin_settings(var_page.clone(), rt.new_string('page'))
	}
	mut iife_temp_14 := Class_WC_Emails{}
	mut iife_result_14 := iife_temp_14.instance()
	mut var_emails := iife_result_14
	mut iter_2 := rt.call_method(var_emails, 'get_emails', []rt.PhpVal{}).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_email := item_2.val
		create_wc_register_wp_admin_settings(var_email.clone(), rt.new_string('email'))
	}
}

fn (mut this Class_WooCommerce) convert_woocommerce_slug(var_slug rt.PhpVal) rt.PhpVal {
	mut var_slug_mutated := var_slug
	if rt.is_true(rt.identical(rt.new_string('woocommerce'), var_slug_mutated)) {
		var_slug_mutated = rt.call_function('dirname', [
			rt.get_constant('WC_PLUGIN_BASENAME'),
		])
	}
	return var_slug_mutated.clone()
}

fn (mut this Class_WooCommerce) register_remote_log_handler(var_handlers rt.PhpVal) rt.PhpVal {
	mut var_handlers_mutated := var_handlers
	var_handlers_mutated.array_push(rt.call_method(rt.call_function('wc_get_container',
		[]rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger.class(),
	]))
	return var_handlers_mutated.clone()
}

fn (mut this Class_WooCommerce) get_tracking_history(var_old_value rt.PhpVal, var_value rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [rt.new_string('woocommerce_allow_tracking_first_optin')])))))
		&& rt.is_true(rt.identical(rt.new_string('yes'), var_value)) {
		rt.call_function('update_option', [
			rt.new_string('woocommerce_allow_tracking_first_optin'),
			rt.call_function('time', []rt.PhpVal{}),
		])
	}
	rt.call_function('update_option', [
		rt.new_string('woocommerce_allow_tracking_last_modified'),
		rt.call_function('time', []rt.PhpVal{}),
	])
}

fn (mut this Class_WooCommerce) add_recurring_action_wrappers() {
	rt.call_function('add_action', [
		rt.new_string('woocommerce_tracker_send_event_wrapper'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_woocommerce_tracker_send_event_wrapper' },
		]),
	])
	rt.call_function('add_action', [rt.new_string('wc_admin_daily_wrapper'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_wc_admin_daily_wrapper' },
		])])
	rt.call_function('add_action', [
		rt.new_string('generate_category_lookup_table_wrapper'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_generate_category_lookup_table_wrapper' },
		]),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_cleanup_rate_limits_wrapper'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_woocommerce_cleanup_rate_limits_wrapper' },
		]),
	])
}

fn (mut this Class_WooCommerce) unschedule_unwrapped_actions() {
	rt.call_function('as_unschedule_all_actions', [
		rt.new_string('woocommerce_tracker_send_event'),
	])
	rt.call_function('as_unschedule_all_actions', [rt.new_string('wc_admin_daily')])
	rt.call_function('as_unschedule_all_actions', [
		rt.new_string('generate_category_lookup_table'),
	])
	rt.call_function('as_unschedule_all_actions', [
		rt.new_string('woocommerce_cleanup_rate_limits'),
	])
}

fn (mut this Class_WooCommerce) add_woocommerce_tracker_send_event_wrapper() {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), rt.call_function('wc_string_to_bool', [
		rt.call_function('get_option', [rt.new_string('woocommerce_allow_tracking'),
			rt.new_string('no')]),
	])))))
	{
		return
	}
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-tracker.php', '2')
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.call_function('class_exists', [Class_WC_Tracker.class()])) {
		mut iife_temp_15 := Class_WC_Tracker{}
		mut iife_result_15 := iife_temp_15.init()
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
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
	if rt.instance_of(var_e_1, 'Throwable') {
		mut var_e := var_e_1.clone()
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [
			rt.new_string('Error initializing WC_Tracker: ' +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			rt.create_array([
				rt.ArrayItem{ key: 'source', val: 'woocommerce-scheduled-actions' },
			]),
		])
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
	rt.call_function('do_action', [rt.new_string('woocommerce_tracker_send_event')])
}

fn (mut this Class_WooCommerce) add_wc_admin_daily_wrapper() {
	if rt.is_true(rt.call_function('class_exists', [
		Class_Automattic_WooCommerce_Internal_Admin_Events.class(),
	]))
	{
		mut iife_temp_16 := Class_Automattic_WooCommerce_Internal_Admin_Events{}
		mut iife_result_16 := iife_temp_16.instance()
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
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
	if rt.instance_of(var_e_2, 'Throwable') {
		mut var_e := var_e_2.clone()
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [
			rt.new_string('Error initializing wc_admin_daily: ' +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			rt.create_array([
				rt.ArrayItem{ key: 'source', val: 'woocommerce-scheduled-actions' },
			]),
		])
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
	rt.call_function('do_action', [rt.new_string('wc_admin_daily')])
}

fn (mut this Class_WooCommerce) add_generate_category_lookup_table_wrapper() {
	if rt.is_true(rt.call_function('class_exists', [
		Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup.class(),
	]))
	{
		mut iife_temp_17 := Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup{}
		mut iife_result_17 := iife_temp_17.instance()
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
	}
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
	if rt.instance_of(var_e_3, 'Throwable') {
		mut var_e := var_e_3.clone()
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [
			rt.new_string('Error in category lookup wrapper: ' +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			rt.create_array([
				rt.ArrayItem{ key: 'source', val: 'woocommerce-scheduled-actions' },
			]),
		])
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
	rt.call_function('do_action', [rt.new_string('generate_category_lookup_table')])
}

fn (mut this Class_WooCommerce) add_woocommerce_cleanup_rate_limits_wrapper() {
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-rate-limiter.php',
		'2')
	if rt.has_exception() {
		unsafe {
			goto catch_label_4
		}
	}
	if rt.is_true(rt.call_function('class_exists', [Class_WC_Rate_Limiter.class()])) {
		mut iife_temp_18 := Class_WC_Rate_Limiter{}
		mut iife_result_18 := iife_temp_18.init()
		if rt.has_exception() {
			unsafe {
				goto catch_label_4
			}
		}
	}
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
	if rt.instance_of(var_e_4, 'Throwable') {
		mut var_e := var_e_4.clone()
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [
			rt.new_string('Error in rate limiter cleanup wrapper: ' +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			rt.create_array([
				rt.ArrayItem{ key: 'source', val: 'woocommerce-scheduled-actions' },
			]),
		])
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
	rt.call_function('do_action', [rt.new_string('woocommerce_cleanup_rate_limits')])
}

fn (mut this Class_WooCommerce) register_recurring_actions() {
	this.unschedule_unwrapped_actions()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('as_schedule_recurring_action')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('as_schedule_single_action')]))))) {
		return
	}
	mut var_gmt_offset := rt.call_function('get_option', [rt.new_string('gmt_offset')])
	mut var_offset_hours := rt.new_string((
		if rt.is_true(rt.greater(var_gmt_offset, rt.new_int(0))) { '-' } else { '+' } +
		(rt.call_function('absint', [var_gmt_offset.clone()])).str() + ' hours').str())
	mut var_scheduled_sales_time := rt.call_function('strtotime', [
		rt.new_string('00:00 tomorrow ' + var_offset_hours.str()),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_scheduled_sales_time)) {
		var_scheduled_sales_time = rt.call_function('strtotime', [
			rt.new_string('00:00 tomorrow'),
		])
	}
	rt.call_function('as_schedule_recurring_action', [var_scheduled_sales_time.clone(),
		rt.get_constant('DAY_IN_SECONDS'), rt.new_string('woocommerce_scheduled_sales'),
		rt.new_array(), rt.new_string('woocommerce'), rt.new_bool(true)])
	mut var_held_duration := rt.call_function('get_option', [
		rt.new_string('woocommerce_hold_stock_minutes'),
		rt.new_string('60'),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_held_duration)))) {
		mut var_cancel_unpaid_interval := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_cancel_unpaid_orders_interval_minutes'),
			rt.call_function('absint', [var_held_duration.clone()]),
		])
		rt.call_function('as_schedule_single_action', [
			rt.add(rt.call_function('time', []rt.PhpVal{}), rt.mul(rt.call_function('absint', [
				var_cancel_unpaid_interval.clone(),
			]), rt.new_int(60))),
			rt.new_string('woocommerce_cancel_unpaid_orders'),
			rt.new_array(),
			rt.new_string('woocommerce'),
			rt.new_bool(true),
		])
	}
	mut var_tomorrow_3am := rt.call_function('strtotime', [
		rt.new_string('tomorrow 03:00 am ' + var_offset_hours.str()),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_tomorrow_3am)) {
		var_tomorrow_3am = rt.call_function('strtotime', [
			rt.new_string('tomorrow 03:00 am'),
		])
	}
	mut var_tomorrow_6am := rt.call_function('strtotime', [
		rt.new_string('tomorrow 06:00 am ' + var_offset_hours.str()),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_tomorrow_6am)) {
		var_tomorrow_6am = rt.call_function('strtotime', [
			rt.new_string('tomorrow 06:00 am'),
		])
	}
	rt.call_function('as_schedule_recurring_action', [
		rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int(10)),
		rt.get_constant('DAY_IN_SECONDS'),
		rt.new_string('woocommerce_cleanup_personal_data'),
		rt.new_array(),
		rt.new_string('woocommerce'),
		rt.new_bool(true),
	])
	rt.call_function('as_schedule_recurring_action', [var_tomorrow_3am.clone(),
		rt.get_constant('DAY_IN_SECONDS'), rt.new_string('woocommerce_cleanup_logs'),
		rt.new_array(), rt.new_string('woocommerce'), rt.new_bool(true)])
	mut var_next_run_timestamp := rt.call_function('as_next_scheduled_action', [
		rt.new_string('woocommerce_cleanup_sessions'),
		rt.new_array(),
		rt.new_string('woocommerce'),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_next_run_timestamp, var_tomorrow_6am)))) {
		rt.call_function('as_unschedule_all_actions', [
			rt.new_string('woocommerce_cleanup_sessions'),
		])
		rt.call_function('as_schedule_recurring_action', [var_tomorrow_6am.clone(),
			rt.mul(rt.new_int(12), rt.get_constant('HOUR_IN_SECONDS')),
			rt.new_string('woocommerce_cleanup_sessions'), rt.new_array(),
			rt.new_string('woocommerce'), rt.new_bool(true)])
	}
	rt.call_function('as_schedule_recurring_action', [var_tomorrow_6am.clone(),
		rt.mul(rt.new_int(15), rt.get_constant('DAY_IN_SECONDS')),
		rt.new_string('woocommerce_geoip_updater'), rt.new_array(),
		rt.new_string('woocommerce'), rt.new_bool(true)])
	this.schedule_tracking_action()
	rt.call_function('as_schedule_recurring_action', [var_tomorrow_3am.clone(),
		rt.get_constant('DAY_IN_SECONDS'), rt.new_string('woocommerce_cleanup_rate_limits_wrapper'),
		rt.new_array(), rt.new_string('woocommerce'), rt.new_bool(true)])
	rt.call_function('as_schedule_recurring_action', [var_tomorrow_3am.clone(),
		rt.get_constant('DAY_IN_SECONDS'), rt.new_string('wc_admin_daily_wrapper'),
		rt.new_array(), rt.new_string('woocommerce'), rt.new_bool(true)])
	rt.call_function('as_schedule_single_action', [
		rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int(10)),
		rt.new_string('generate_category_lookup_table_wrapper'),
		rt.new_array(),
		rt.new_string('woocommerce'),
		rt.new_bool(true),
	])
}

fn (mut this Class_WooCommerce) handle_tracking_setting_change(var_old_value rt.PhpVal, var_value rt.PhpVal) {
	if rt.is_true(rt.identical(var_old_value, var_value)) {
		return
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('wc_string_to_bool', [
		var_value.clone(),
	])))
	{
		rt.call_function('as_unschedule_all_actions', [
			rt.new_string('woocommerce_tracker_send_event_wrapper'),
			rt.new_array(),
			rt.new_string('woocommerce'),
		])
	} else {
		this.schedule_tracking_action()
	}
}

fn (mut this Class_WooCommerce) schedule_tracking_action() {
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('wc_string_to_bool', [
		rt.call_function('get_option', [rt.new_string('woocommerce_allow_tracking'),
			rt.new_string('no')]),
	])))
	{
		return
	}
	mut var_tracker_recurrence := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_tracker_event_recurrence'),
		rt.new_string('daily'),
	])
	mut var_core_internals := rt.call_function('wp_get_schedules', []rt.PhpVal{})
	rt.call_function('as_schedule_recurring_action', [
		rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int(10)),
		var_core_internals.array_get(var_tracker_recurrence).array_get(rt.new_string('interval')),
		rt.new_string('woocommerce_tracker_send_event_wrapper'),
		rt.new_array(),
		rt.new_string('woocommerce'),
		rt.new_bool(true),
	])
}

fn (mut this Class_WooCommerce) init_customizer() {
	mut var_pagenow := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('customize.php'), var_pagenow))
		|| rt.get_superglobal('_REQUEST').array_isset(rt.new_string('customize_theme'))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))))) {
		create_wc_shop_customizer()
	}
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
	message string
	code    i64
	file    string
	line    i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_Automattic_Jetpack_Config {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Api_Main {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Reports {
	rt.PhpObjectBase
}

struct Class_LoggingUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_RestApi_Server {
	rt.PhpObjectBase
}

struct Class_WC_Query {
	rt.PhpObjectBase
}

struct Class_WC_Product_Factory {
	rt.PhpObjectBase
}

struct Class_WC_Order_Factory {
	rt.PhpObjectBase
}

struct Class_WC_Countries {
	rt.PhpObjectBase
}

struct Class_WC_Integrations {
	rt.PhpObjectBase
}

struct Class_WC_Structured_Data {
	rt.PhpObjectBase
}

struct Class_WC_Deprecated_Action_Hooks {
	rt.PhpObjectBase
}

struct Class_WC_Deprecated_Filter_Hooks {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

struct Class_WC_Customer {
	rt.PhpObjectBase
}

struct Class_WC_Cart {
	rt.PhpObjectBase
}

struct Class_WC_Helper {
	rt.PhpObjectBase
}

struct Class_WC_Queue {
	rt.PhpObjectBase
}

struct Class_WC_Checkout {
	rt.PhpObjectBase
}

struct Class_WC_Payment_Gateways {
	rt.PhpObjectBase
}

struct Class_WC_Shipping {
	rt.PhpObjectBase
}

struct Class_WC_Emails {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Settings {
	rt.PhpObjectBase
}

struct Class_WC_Register_WP_Admin_Settings {
	rt.PhpObjectBase
}

struct Class_WC_Tracker {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Events {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup {
	rt.PhpObjectBase
}

struct Class_WC_Rate_Limiter {
	rt.PhpObjectBase
}

struct Class_WC_Shop_Customizer {
	rt.PhpObjectBase
}

fn create_woocommerce() &Class_WooCommerce {
	mut obj := &Class_WooCommerce{
		PhpObjectBase:            rt.PhpObjectBase{}
		version:                  rt.new_string('10.8.1')
		db_version:               rt.new_string('920')
		session:                  rt.new_null()
		query:                    rt.new_null()
		api:                      rt.new_null()
		product_factory:          rt.new_null()
		countries:                rt.new_null()
		integrations:             rt.new_null()
		cart:                     rt.new_null()
		customer:                 rt.new_null()
		order_factory:            rt.new_null()
		structured_data:          rt.new_null()
		deprecated_hook_handlers: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_jetpack_config(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Config {
	mut obj := &Class_Automattic_Jetpack_Config{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_api_main(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Api_Main {
	mut obj := &Class_Automattic_WooCommerce_Internal_Api_Main{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_reports(_args ...rt.PhpVal) &Class_WC_Admin_Reports {
	mut obj := &Class_WC_Admin_Reports{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_loggingutil(_args ...rt.PhpVal) &Class_LoggingUtil {
	mut obj := &Class_LoggingUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_restapi_server(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_RestApi_Server {
	mut obj := &Class_Automattic_WooCommerce_RestApi_Server{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_query(_args ...rt.PhpVal) &Class_WC_Query {
	mut obj := &Class_WC_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product_factory(_args ...rt.PhpVal) &Class_WC_Product_Factory {
	mut obj := &Class_WC_Product_Factory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_factory(_args ...rt.PhpVal) &Class_WC_Order_Factory {
	mut obj := &Class_WC_Order_Factory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_countries(_args ...rt.PhpVal) &Class_WC_Countries {
	mut obj := &Class_WC_Countries{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_integrations(_args ...rt.PhpVal) &Class_WC_Integrations {
	mut obj := &Class_WC_Integrations{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_structured_data(_args ...rt.PhpVal) &Class_WC_Structured_Data {
	mut obj := &Class_WC_Structured_Data{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_deprecated_action_hooks(_args ...rt.PhpVal) &Class_WC_Deprecated_Action_Hooks {
	mut obj := &Class_WC_Deprecated_Action_Hooks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_deprecated_filter_hooks(_args ...rt.PhpVal) &Class_WC_Deprecated_Filter_Hooks {
	mut obj := &Class_WC_Deprecated_Filter_Hooks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_customer(_args ...rt.PhpVal) &Class_WC_Customer {
	mut obj := &Class_WC_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cart(_args ...rt.PhpVal) &Class_WC_Cart {
	mut obj := &Class_WC_Cart{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper(_args ...rt.PhpVal) &Class_WC_Helper {
	mut obj := &Class_WC_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_queue(_args ...rt.PhpVal) &Class_WC_Queue {
	mut obj := &Class_WC_Queue{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_checkout(_args ...rt.PhpVal) &Class_WC_Checkout {
	mut obj := &Class_WC_Checkout{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_payment_gateways(_args ...rt.PhpVal) &Class_WC_Payment_Gateways {
	mut obj := &Class_WC_Payment_Gateways{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shipping(_args ...rt.PhpVal) &Class_WC_Shipping {
	mut obj := &Class_WC_Shipping{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_emails(_args ...rt.PhpVal) &Class_WC_Emails {
	mut obj := &Class_WC_Emails{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_settings(_args ...rt.PhpVal) &Class_WC_Admin_Settings {
	mut obj := &Class_WC_Admin_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_register_wp_admin_settings(_args ...rt.PhpVal) &Class_WC_Register_WP_Admin_Settings {
	mut obj := &Class_WC_Register_WP_Admin_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tracker(_args ...rt.PhpVal) &Class_WC_Tracker {
	mut obj := &Class_WC_Tracker{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_events(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Events {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Events{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_categorylookup(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_rate_limiter(_args ...rt.PhpVal) &Class_WC_Rate_Limiter {
	mut obj := &Class_WC_Rate_Limiter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shop_customizer(_args ...rt.PhpVal) &Class_WC_Shop_Customizer {
	mut obj := &Class_WC_Shop_Customizer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WooCommerce) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'instance' {
			return Class_WooCommerce.instance()
		}
		'__clone' {
			this.magic_clone()
			return rt.new_null()
		}
		'__wakeup' {
			this.magic_wakeup()
			return rt.new_null()
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_get(dispatch_arg_0)
		}
		'__set' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.magic_set(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'legacy_rest_api_is_available' {
			return this.legacy_rest_api_is_available()
		}
		'stable_version' {
			return rt.new_string(this.stable_version())
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'on_plugins_loaded' {
			this.on_plugins_loaded()
			return rt.new_null()
		}
		'init_jetpack_connection_config' {
			this.init_jetpack_connection_config()
			return rt.new_null()
		}
		'init_hooks' {
			this.init_hooks()
			return rt.new_null()
		}
		'add_woocommerce_inbox_variant' {
			this.add_woocommerce_inbox_variant()
			return rt.new_null()
		}
		'add_woocommerce_remote_variant' {
			this.add_woocommerce_remote_variant()
			return rt.new_null()
		}
		'log_errors' {
			this.log_errors()
			return rt.new_null()
		}
		'define_constants' {
			this.define_constants()
			return rt.new_null()
		}
		'define_tables' {
			this.define_tables()
			return rt.new_null()
		}
		'define' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.define(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'is_rest_api_request' {
			return rt.new_bool(this.is_rest_api_request())
		}
		'is_store_api_request' {
			return rt.new_bool(this.is_store_api_request())
		}
		'load_rest_api' {
			this.load_rest_api()
			return rt.new_null()
		}
		'is_request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_request(dispatch_arg_0))
		}
		'includes' {
			this.includes()
			return rt.new_null()
		}
		'theme_support_includes' {
			this.theme_support_includes()
			return rt.new_null()
		}
		'frontend_includes' {
			this.frontend_includes()
			return rt.new_null()
		}
		'include_template_functions' {
			this.include_template_functions()
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'maybe_init_order_reviews' {
			this.maybe_init_order_reviews()
			return rt.new_null()
		}
		'load_plugin_textdomain' {
			this.load_plugin_textdomain()
			return rt.new_null()
		}
		'setup_environment' {
			this.setup_environment()
			return rt.new_null()
		}
		'add_thumbnail_support' {
			this.add_thumbnail_support()
			return rt.new_null()
		}
		'add_image_sizes' {
			this.add_image_sizes()
			return rt.new_null()
		}
		'plugin_url' {
			return this.plugin_url()
		}
		'plugin_path' {
			return this.plugin_path()
		}
		'template_path' {
			return this.template_path()
		}
		'ajax_url' {
			return this.ajax_url()
		}
		'api_request_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.api_request_url(dispatch_arg_0, dispatch_arg_1)
		}
		'load_webhooks' {
			this.load_webhooks()
			return rt.new_null()
		}
		'initialize_cart' {
			this.initialize_cart()
			return rt.new_null()
		}
		'initialize_session' {
			this.initialize_session()
			return rt.new_null()
		}
		'robots_txt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.robots_txt(dispatch_arg_0)
		}
		'wpdb_table_fix' {
			this.wpdb_table_fix()
			return rt.new_null()
		}
		'activated_plugin' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.activated_plugin(dispatch_arg_0)
			return rt.new_null()
		}
		'deactivated_plugin' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.deactivated_plugin(dispatch_arg_0)
			return rt.new_null()
		}
		'queue' {
			return this.queue()
		}
		'checkout' {
			return this.checkout()
		}
		'payment_gateways' {
			return this.payment_gateways()
		}
		'shipping' {
			return this.shipping()
		}
		'mailer' {
			return this.mailer()
		}
		'build_dependencies_satisfied' {
			return rt.new_bool(this.build_dependencies_satisfied())
		}
		'build_dependencies_notice' {
			this.build_dependencies_notice()
			return rt.new_null()
		}
		'is_wc_admin_active' {
			return this.is_wc_admin_active()
		}
		'call_function' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.call_function(dispatch_arg_0, dispatch_arg_1)
		}
		'call_static' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.call_static(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_instance_of' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_instance_of(dispatch_arg_0, dispatch_arg_1)
		}
		'get_global' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_global(dispatch_arg_0)
		}
		'register_wp_admin_settings' {
			this.register_wp_admin_settings()
			return rt.new_null()
		}
		'convert_woocommerce_slug' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.convert_woocommerce_slug(dispatch_arg_0)
		}
		'register_remote_log_handler' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.register_remote_log_handler(dispatch_arg_0)
		}
		'get_tracking_history' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.get_tracking_history(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'add_recurring_action_wrappers' {
			this.add_recurring_action_wrappers()
			return rt.new_null()
		}
		'unschedule_unwrapped_actions' {
			this.unschedule_unwrapped_actions()
			return rt.new_null()
		}
		'add_woocommerce_tracker_send_event_wrapper' {
			this.add_woocommerce_tracker_send_event_wrapper()
			return rt.new_null()
		}
		'add_wc_admin_daily_wrapper' {
			this.add_wc_admin_daily_wrapper()
			return rt.new_null()
		}
		'add_generate_category_lookup_table_wrapper' {
			this.add_generate_category_lookup_table_wrapper()
			return rt.new_null()
		}
		'add_woocommerce_cleanup_rate_limits_wrapper' {
			this.add_woocommerce_cleanup_rate_limits_wrapper()
			return rt.new_null()
		}
		'register_recurring_actions' {
			this.register_recurring_actions()
			return rt.new_null()
		}
		'handle_tracking_setting_change' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.handle_tracking_setting_change(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'schedule_tracking_action' {
			this.schedule_tracking_action()
			return rt.new_null()
		}
		'init_customizer' {
			this.init_customizer()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WooCommerce) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'version' { return this.version }
		'db_version' { return this.db_version }
		'session' { return this.session }
		'query' { return this.query }
		'api' { return this.api }
		'product_factory' { return this.product_factory }
		'countries' { return this.countries }
		'integrations' { return this.integrations }
		'cart' { return this.cart }
		'customer' { return this.customer }
		'order_factory' { return this.order_factory }
		'structured_data' { return this.structured_data }
		'deprecated_hook_handlers' { return this.deprecated_hook_handlers }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WooCommerce) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'version' {
			this.version = val
			return true
		}
		'db_version' {
			this.db_version = val
			return true
		}
		'session' {
			this.session = val
			return true
		}
		'query' {
			this.query = val
			return true
		}
		'api' {
			this.api = val
			return true
		}
		'product_factory' {
			this.product_factory = val
			return true
		}
		'countries' {
			this.countries = val
			return true
		}
		'integrations' {
			this.integrations = val
			return true
		}
		'cart' {
			this.cart = val
			return true
		}
		'customer' {
			this.customer = val
			return true
		}
		'order_factory' {
			this.order_factory = val
			return true
		}
		'structured_data' {
			this.structured_data = val
			return true
		}
		'deprecated_hook_handlers' {
			this.deprecated_hook_handlers = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_Jetpack_Config) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Config) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Config) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Main) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Api_Main) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Main) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Admin_Reports) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Reports) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Reports) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_LoggingUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_LoggingUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_LoggingUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_RestApi_Server) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_RestApi_Server) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_RestApi_Server) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Product_Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Order_Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Countries) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Countries) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Countries) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Integrations) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Integrations) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Integrations) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Structured_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Structured_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Structured_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Deprecated_Action_Hooks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Deprecated_Action_Hooks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Deprecated_Action_Hooks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Deprecated_Filter_Hooks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Deprecated_Filter_Hooks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Deprecated_Filter_Hooks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Customer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Customer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Customer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Cart) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cart) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cart) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Queue) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Queue) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Queue) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Checkout) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Checkout) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Checkout) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Payment_Gateways) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Payment_Gateways) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Payment_Gateways) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Shipping) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shipping) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Emails) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Emails) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Emails) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Admin_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Register_WP_Admin_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Register_WP_Admin_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Register_WP_Admin_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Tracker) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tracker) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tracker) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Events) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Events) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Events) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Rate_Limiter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Rate_Limiter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Rate_Limiter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Shop_Customizer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shop_Customizer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shop_Customizer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('WooCommerce', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_woocommerce()
		return rt.new_object('WooCommerce', []string{}, obj)
	})
	rt.register_class_factory('Exception', fn (args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		obj := create_exception(c_arg_0)
		return rt.new_object('Exception', []string{}, obj)
	})
	rt.register_class_factory('Automattic_Jetpack_Config', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_jetpack_config()
		return rt.new_object('Automattic_Jetpack_Config', []string{}, obj)
	})
	rt.register_class_factory('Automattic_Jetpack_Constants', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_jetpack_constants()
		return rt.new_object('Automattic_Jetpack_Constants', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_Api_Main', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_api_main()
		return rt.new_object('Automattic_WooCommerce_Internal_Api_Main', []string{}, obj)
	})
	rt.register_class_factory('WC_Admin_Reports', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_admin_reports()
		return rt.new_object('WC_Admin_Reports', []string{}, obj)
	})
	rt.register_class_factory('LoggingUtil', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_loggingutil()
		return rt.new_object('LoggingUtil', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_RestApi_Server', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_restapi_server()
		return rt.new_object('Automattic_WooCommerce_RestApi_Server', []string{}, obj)
	})
	rt.register_class_factory('WC_Query', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_query()
		return rt.new_object('WC_Query', []string{}, obj)
	})
	rt.register_class_factory('WC_Product_Factory', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_product_factory()
		return rt.new_object('WC_Product_Factory', []string{}, obj)
	})
	rt.register_class_factory('WC_Order_Factory', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_order_factory()
		return rt.new_object('WC_Order_Factory', []string{}, obj)
	})
	rt.register_class_factory('WC_Countries', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_countries()
		return rt.new_object('WC_Countries', []string{}, obj)
	})
	rt.register_class_factory('WC_Integrations', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_integrations()
		return rt.new_object('WC_Integrations', []string{}, obj)
	})
	rt.register_class_factory('WC_Structured_Data', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_structured_data()
		return rt.new_object('WC_Structured_Data', []string{}, obj)
	})
	rt.register_class_factory('WC_Deprecated_Action_Hooks', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_deprecated_action_hooks()
		return rt.new_object('WC_Deprecated_Action_Hooks', []string{}, obj)
	})
	rt.register_class_factory('WC_Deprecated_Filter_Hooks', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_deprecated_filter_hooks()
		return rt.new_object('WC_Deprecated_Filter_Hooks', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Utilities_FeaturesUtil', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_utilities_featuresutil()
		return rt.new_object('Automattic_WooCommerce_Utilities_FeaturesUtil', []string{}, obj)
	})
	rt.register_class_factory('WC_Customer', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_customer()
		return rt.new_object('WC_Customer', []string{}, obj)
	})
	rt.register_class_factory('WC_Cart', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_cart()
		return rt.new_object('WC_Cart', []string{}, obj)
	})
	rt.register_class_factory('WC_Helper', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_helper()
		return rt.new_object('WC_Helper', []string{}, obj)
	})
	rt.register_class_factory('WC_Queue', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_queue()
		return rt.new_object('WC_Queue', []string{}, obj)
	})
	rt.register_class_factory('WC_Checkout', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_checkout()
		return rt.new_object('WC_Checkout', []string{}, obj)
	})
	rt.register_class_factory('WC_Payment_Gateways', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_payment_gateways()
		return rt.new_object('WC_Payment_Gateways', []string{}, obj)
	})
	rt.register_class_factory('WC_Shipping', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_shipping()
		return rt.new_object('WC_Shipping', []string{}, obj)
	})
	rt.register_class_factory('WC_Emails', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_emails()
		return rt.new_object('WC_Emails', []string{}, obj)
	})
	rt.register_class_factory('WC_Admin_Settings', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_admin_settings()
		return rt.new_object('WC_Admin_Settings', []string{}, obj)
	})
	rt.register_class_factory('WC_Register_WP_Admin_Settings', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_register_wp_admin_settings()
		return rt.new_object('WC_Register_WP_Admin_Settings', []string{}, obj)
	})
	rt.register_class_factory('WC_Tracker', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_tracker()
		return rt.new_object('WC_Tracker', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_Admin_Events', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_admin_events()
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_Events', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_Admin_CategoryLookup', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_admin_categorylookup()
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_CategoryLookup', []string{},
			obj)
	})
	rt.register_class_factory('WC_Rate_Limiter', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_rate_limiter()
		return rt.new_object('WC_Rate_Limiter', []string{}, obj)
	})
	rt.register_class_factory('WC_Shop_Customizer', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_shop_customizer()
		return rt.new_object('WC_Shop_Customizer', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	// unsupported statement: Stmt_GroupUse
}
