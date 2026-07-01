import rt

struct Class_WooCommerce {
	rt.PhpObjectBase
pub mut:
		version rt.PhpVal = rt.new_string('10.8.1')
		db_version rt.PhpVal = rt.new_string('920')
		_instance rt.PhpVal = rt.new_null()
		session rt.PhpVal = rt.new_null()
		query rt.PhpVal = rt.new_null()
		api rt.PhpVal = rt.new_null()
		product_factory rt.PhpVal = rt.new_null()
		countries rt.PhpVal = rt.new_null()
		integrations rt.PhpVal = rt.new_null()
		cart rt.PhpVal = rt.new_null()
		customer rt.PhpVal = rt.new_null()
		order_factory rt.PhpVal = rt.new_null()
		structured_data rt.PhpVal = rt.new_null()
		deprecated_hook_handlers rt.PhpVal = rt.new_array()
}

fn Class_WooCommerce.instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.is_null())) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_WooCommerce) magic_clone()  {
	rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Cloning is forbidden.'), rt.new_string('woocommerce')]), rt.new_string('2.1')])
}

fn (mut this Class_WooCommerce) magic_wakeup()  {
	rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Unserializing instances of this class is forbidden.'), rt.new_string('woocommerce')]), rt.new_string('2.1')])
}

fn (mut this Class_WooCommerce) magic_get(var_key rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('api'), var_key)) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(this.api.is_null())) && rt.is_true(rt.new_bool(!(rt.is_true(this.legacy_rest_api_is_available())))))) {
			this.api = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Utilities_LegacyRestApiStub.class()])
		}
		return this.api
	}
	if rt.is_true(rt.call_function('in_array', [var_key.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'payment_gateways' }, rt.ArrayItem{ key: none, val: 'shipping' }, rt.ArrayItem{ key: none, val: 'mailer' }, rt.ArrayItem{ key: none, val: 'checkout' }]), rt.new_bool(true)])) {
		return rt.call_method(rt.new_object('WooCommerce', []string{}, &this), var_key, []rt.PhpVal{})
	}
	return rt.new_null()
}

fn (mut this Class_WooCommerce) magic_set(key string, var_value rt.PhpVal)  {
	if rt.is_true(rt.identical(rt.new_string('api'), rt.new_string(key))) {
		this.api = var_value.dup()
	} else if rt.is_true(rt.call_function('property_exists', [rt.new_object('WooCommerce', []string{}, &this), rt.new_string(key)])) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception('Cannot access private property ' + @STRUCT + '::$' + (rt.call_function('esc_html', [rt.new_string(key)])).str())))
	} else {
		this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":234,"name":"key"}', var_value.dup())
	}
}

fn (mut this Class_WooCommerce) legacy_rest_api_is_available() rt.PhpVal {
	return rt.call_function('class_exists', [rt.new_string('WC_Legacy_REST_API_Plugin'), rt.new_bool(false)])
}

fn (mut this Class_WooCommerce) stable_version() string {
	return (rt.call_function('explode', [rt.new_string('-'), this.version, rt.new_int(2)]).array_get(0)).str()
}

fn (mut this Class_WooCommerce) construct()  {
	this.define_constants()
	this.define_tables()
	this.includes()
	this.init_hooks()
}

fn (mut this Class_WooCommerce) on_plugins_loaded()  {
	rt.call_function('do_action', [rt.new_string('woocommerce_loaded')])
}

fn (mut this Class_WooCommerce) init_jetpack_connection_config()  {
	mut var_config := create_automattic_jetpack_config()
	var_config.ensure(rt.new_string('connection'), rt.create_array([rt.ArrayItem{ key: 'slug', val: 'woocommerce' }, rt.ArrayItem{ key: 'name', val: 'WooCommerce' }]))
}

fn (mut this Class_WooCommerce) init_hooks()  {
	rt.call_function('register_activation_hook', [rt.get_constant('WC_PLUGIN_FILE'), rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Install' }, rt.ArrayItem{ key: none, val: 'install' }])])
	rt.call_function('register_shutdown_function', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'log_errors' }])])
	rt.call_function('add_action', [rt.new_string('plugins_loaded'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'on_plugins_loaded' }]), // unsupported expression: Expr_UnaryMinus])
	rt.call_function('add_action', [rt.new_string('plugins_loaded'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'init_customizer' }])])
	rt.call_function('add_action', [rt.new_string('plugins_loaded'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'init_jetpack_connection_config' }]), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('admin_notices'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'build_dependencies_notice' }])])
	rt.call_function('add_action', [rt.new_string('after_setup_theme'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'setup_environment' }])])
	rt.call_function('add_action', [rt.new_string('after_setup_theme'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'include_template_functions' }]), rt.new_int(11)])
	rt.call_function('add_action', [rt.new_string('load-post.php'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'includes' }])])
	rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'init' }]), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'maybe_init_order_reviews' }]), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Shortcodes' }, rt.ArrayItem{ key: none, val: 'init' }])])
	rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Emails' }, rt.ArrayItem{ key: none, val: 'init_transactional_emails' }])])
	rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_image_sizes' }])])
	rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'load_rest_api' }])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(this.is_request(rt.new_string('admin'))) || this.is_rest_api_request() && !(this.is_store_api_request()))) || rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('WP_CLI')])) && rt.is_true(rt.get_constant('WP_CLI')))))) {
		rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Site_Tracking' }, rt.ArrayItem{ key: none, val: 'init' }])])
	}
	rt.call_function('add_action', [rt.new_string('switch_blog'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'wpdb_table_fix' }]), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('activated_plugin'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'activated_plugin' }])])
	rt.call_function('add_action', [rt.new_string('deactivated_plugin'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'deactivated_plugin' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_installed'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_woocommerce_inbox_variant' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_updated'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_woocommerce_inbox_variant' }])])
	rt.call_function('add_action', [rt.new_string('rest_api_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_wp_admin_settings' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_installed'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_woocommerce_remote_variant' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_updated'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_woocommerce_remote_variant' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_newly_installed'), rt.new_string('wc_set_hooked_blocks_version'), rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('update_option_woocommerce_allow_tracking'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_tracking_history' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('update_option_woocommerce_allow_tracking'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_tracking_setting_change' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('action_scheduler_ensure_recurring_actions'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_recurring_actions' }])])
	rt.call_function('add_action', [rt.new_string('action_scheduler_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_recurring_action_wrappers' }])])
	rt.call_function('add_filter', [rt.new_string('robots_txt'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'robots_txt' }])])
	rt.call_function('add_filter', [rt.new_string('wp_plugin_dependencies_slug'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'convert_woocommerce_slug' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_register_log_handlers'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WooCommerce', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_remote_log_handler' }])])
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register.class()])
	rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_DownloadPermissionsAdjuster.class()])
	rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_AssignDefaultCategory.class()])
	rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator.class()])
	rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.class()])
	rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_ProductImage_MatchImageBySKU.class()])
	rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_RestockRefundedItemsAdjuster.class()])
	rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.class()])
	rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_Caches_ProductCacheController.class()])
	rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_Settings_OptionSanitizer.class()])
	rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController.class()])
	rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_Features_FeaturesController.class()])
	rt.call_method(, 'get', [])
	
}

fn (mut this Class_WooCommerce) add_woocommerce_inbox_variant()  {
}

fn (mut this Class_WooCommerce) add_woocommerce_remote_variant()  {
}

fn (mut this Class_WooCommerce) log_errors()  {
}

fn (mut this Class_WooCommerce) define_constants()  {
}

fn (mut this Class_WooCommerce) define_tables()  {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WooCommerce) define(var_name rt.PhpVal, var_value rt.PhpVal)  {
}

fn (mut this Class_WooCommerce) is_rest_api_request() bool {
}

fn (mut this Class_WooCommerce) is_store_api_request() bool {
}

fn (mut this Class_WooCommerce) load_rest_api()  {
}

fn (mut this Class_WooCommerce) is_request(var_type rt.PhpVal)  {
}

fn (mut this Class_WooCommerce) includes()  {
}

fn (mut this Class_WooCommerce) theme_support_includes()  {
}

fn (mut this Class_WooCommerce) frontend_includes()  {
}

fn (mut this Class_WooCommerce) include_template_functions()  {
}

fn (mut this Class_WooCommerce) init()  {
}

fn (mut this Class_WooCommerce) maybe_init_order_reviews()  {
}

fn (mut this Class_WooCommerce) load_plugin_textdomain()  {
}

fn (mut this Class_WooCommerce) setup_environment()  {
}

fn (mut this Class_WooCommerce) add_thumbnail_support()  {
}

fn (mut this Class_WooCommerce) add_image_sizes()  {
}

fn (mut this Class_WooCommerce) plugin_url() rt.PhpVal {
}

fn (mut this Class_WooCommerce) plugin_path() rt.PhpVal {
}

fn (mut this Class_WooCommerce) template_path() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_WooCommerce) ajax_url() rt.PhpVal {
}

fn (mut this Class_WooCommerce) api_request_url(var_request rt.PhpVal, var_ssl rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_WooCommerce) load_webhooks()  {
}

fn (mut this Class_WooCommerce) initialize_cart()  {
}

fn (mut this Class_WooCommerce) initialize_session()  {
}

fn (mut this Class_WooCommerce) robots_txt(var_output rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WooCommerce) wpdb_table_fix()  {
}

fn (mut this Class_WooCommerce) activated_plugin(var_filename rt.PhpVal)  {
}

fn (mut this Class_WooCommerce) deactivated_plugin(var_filename rt.PhpVal)  {
}

fn (mut this Class_WooCommerce) queue() rt.PhpVal {
}

fn (mut this Class_WooCommerce) checkout() rt.PhpVal {
}

fn (mut this Class_WooCommerce) payment_gateways() rt.PhpVal {
}

fn (mut this Class_WooCommerce) shipping() rt.PhpVal {
}

fn (mut this Class_WooCommerce) mailer() rt.PhpVal {
}

fn (mut this Class_WooCommerce) build_dependencies_satisfied() bool {
}

fn (mut this Class_WooCommerce) build_dependencies_notice()  {
}

fn (mut this Class_WooCommerce) is_wc_admin_active() rt.PhpVal {
}

fn (mut this Class_WooCommerce) call_function(var_function_name rt.PhpVal, var_parameters rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WooCommerce) call_static(var_class_name rt.PhpVal, var_method_name rt.PhpVal, var_parameters rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WooCommerce) get_instance_of(class_name string, var_args rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WooCommerce) get_global(global_name string) rt.PhpVal {
}

fn (mut this Class_WooCommerce) register_wp_admin_settings()  {
}

fn (mut this Class_WooCommerce) convert_woocommerce_slug(var_slug rt.PhpVal) rt.PhpVal {
	mut var_slug_mutated := var_slug
}

fn (mut this Class_WooCommerce) register_remote_log_handler(var_handlers rt.PhpVal) rt.PhpVal {
	mut var_handlers_mutated := var_handlers
}

fn (mut this Class_WooCommerce) get_tracking_history(var_old_value rt.PhpVal, var_value rt.PhpVal)  {
}

fn (mut this Class_WooCommerce) add_recurring_action_wrappers()  {
}

fn (mut this Class_WooCommerce) unschedule_unwrapped_actions()  {
}

fn (mut this Class_WooCommerce) add_woocommerce_tracker_send_event_wrapper()  {
}

fn (mut this Class_WooCommerce) add_wc_admin_daily_wrapper()  {
}

fn (mut this Class_WooCommerce) add_generate_category_lookup_table_wrapper()  {
}

fn (mut this Class_WooCommerce) add_woocommerce_cleanup_rate_limits_wrapper()  {
}

fn (mut this Class_WooCommerce) register_recurring_actions()  {
}

fn (mut this Class_WooCommerce) handle_tracking_setting_change(var_old_value rt.PhpVal, var_value rt.PhpVal)  {
}

fn (mut this Class_WooCommerce) schedule_tracking_action()  {
}

fn (mut this Class_WooCommerce) init_customizer()  {
	mut var_pagenow := rt.new_null()
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
		message string
		code i64
		file string
		line i64
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

fn create_woocommerce() &Class_WooCommerce {
	mut obj := &Class_WooCommerce{
		PhpObjectBase: rt.PhpObjectBase{}
		version: rt.new_string('10.8.1')
		db_version: rt.new_string('920')
		_instance: rt.new_null()
		session: rt.new_null()
		query: rt.new_null()
		api: rt.new_null()
		product_factory: rt.new_null()
		countries: rt.new_null()
		integrations: rt.new_null()
		cart: rt.new_null()
		customer: rt.new_null()
		order_factory: rt.new_null()
		structured_data: rt.new_null()
		deprecated_hook_handlers: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message: ''
		code: i64(0)
		file: ''
		line: i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_jetpack_config() &Class_Automattic_Jetpack_Config {
	mut obj := &Class_Automattic_Jetpack_Config{
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
			this.is_request(dispatch_arg_0)
			return rt.new_null()
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
		else { return none }
	}
}

fn (this &Class_WooCommerce) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'version' { return this.version }
		'db_version' { return this.db_version }
		'_instance' { return this._instance }
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
		'version' { this.version = val; return true }
		'db_version' { this.db_version = val; return true }
		'_instance' { this._instance = val; return true }
		'session' { this.session = val; return true }
		'query' { this.query = val; return true }
		'api' { this.api = val; return true }
		'product_factory' { this.product_factory = val; return true }
		'countries' { this.countries = val; return true }
		'integrations' { this.integrations = val; return true }
		'cart' { this.cart = val; return true }
		'customer' { this.customer = val; return true }
		'order_factory' { this.order_factory = val; return true }
		'structured_data' { this.structured_data = val; return true }
		'deprecated_hook_handlers' { this.deprecated_hook_handlers = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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
		else { return none }
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
		'message' { this.message = (val).str(); return true }
		'code' { this.code = (val).to_i64(); return true }
		'file' { this.file = (val).str(); return true }
		'line' { this.line = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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


fn init_registry() {
	rt.register_class_factory('WooCommerce', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_woocommerce()
		return rt.new_object('WooCommerce', []string{}, obj)
	})
	rt.register_class_factory('Exception', fn(args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		obj := create_exception(c_arg_0)
		return rt.new_object('Exception', []string{}, obj)
	})
	rt.register_class_factory('Automattic_Jetpack_Config', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_jetpack_config()
		return rt.new_object('Automattic_Jetpack_Config', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_class_woocommerce_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_GroupUse
}
