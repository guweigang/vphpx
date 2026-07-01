import rt

struct Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry {
	rt.PhpObjectBase
pub mut:
		data rt.PhpVal = rt.new_array()
		preloaded_api_requests rt.PhpVal = rt.new_array()
		lazy_data rt.PhpVal = rt.new_array()
		handle rt.PhpVal = rt.new_string('wc-settings')
		api rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) construct(mut var_asset_api Class_Automattic_WooCommerce_Blocks_Assets_Api)  {
	this.api = var_asset_api.dup()
	this.init()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) init()  {
	rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_data_script' }])])
	rt.call_function('add_action', [if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) { rt.new_string('admin_print_footer_scripts') } else { rt.new_string('wp_print_footer_scripts') }, rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'enqueue_asset_data' }]), rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) get_core_data() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'adminUrl', val: rt.call_function('admin_url', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'countries', val: rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_countries', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'currency', val: this.get_currency_data() }, rt.ArrayItem{ key: 'currentUserId', val: rt.call_function('get_current_user_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'currentUserIsAdmin', val: rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]) }, rt.ArrayItem{ key: 'currentThemeIsFSETheme', val: rt.call_function('wp_is_block_theme', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'dateFormat', val: rt.call_function('wc_date_format', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'homeUrl', val: rt.call_function('esc_url', [rt.call_function('home_url', [rt.new_string('/')])]) }, rt.ArrayItem{ key: 'locale', val: this.get_locale_data() }, rt.ArrayItem{ key: 'isRemoteLoggingEnabled', val: rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger.class()]), 'is_remote_logging_allowed', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'dashboardUrl', val: rt.call_function('wc_get_account_endpoint_url', [rt.new_string('dashboard')]) }, rt.ArrayItem{ key: 'orderStatuses', val: this.get_order_statuses() }, rt.ArrayItem{ key: 'placeholderImgSrc', val: rt.call_function('wc_placeholder_img_src', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'productsSettings', val: this.get_products_settings() }, rt.ArrayItem{ key: 'siteTitle', val: rt.call_function('wp_specialchars_decode', [rt.call_function('get_bloginfo', [rt.new_string('name')]), rt.get_constant('ENT_QUOTES')]) }, rt.ArrayItem{ key: 'storePages', val: this.get_store_pages() }, rt.ArrayItem{ key: 'wcAssetUrl', val: rt.call_function('plugins_url', [rt.new_string('assets/'), rt.get_constant('WC_PLUGIN_FILE')]) }, rt.ArrayItem{ key: 'wcVersion', val: if rt.is_true(rt.call_function('defined', [rt.new_string('WC_VERSION')])) { rt.get_constant('WC_VERSION') } else { rt.new_string('') } }, rt.ArrayItem{ key: 'wpLoginUrl', val: rt.call_function('wp_login_url', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'wpVersion', val: rt.call_function('get_bloginfo', [rt.new_string('version')]) }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) get_currency_data() rt.PhpVal {
	mut var_currency := rt.call_function('get_woocommerce_currency', []rt.PhpVal{})
	return rt.create_array([rt.ArrayItem{ key: 'code', val: var_currency }, rt.ArrayItem{ key: 'precision', val: rt.call_function('wc_get_price_decimals', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'symbol', val: rt.call_function('html_entity_decode', [rt.call_function('get_woocommerce_currency_symbol', [var_currency.dup()])]) }, rt.ArrayItem{ key: 'symbolPosition', val: rt.call_function('get_option', [rt.new_string('woocommerce_currency_pos')]) }, rt.ArrayItem{ key: 'decimalSeparator', val: rt.call_function('wc_get_price_decimal_separator', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'thousandSeparator', val: rt.call_function('wc_get_price_thousand_separator', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'priceFormat', val: rt.call_function('html_entity_decode', [rt.call_function('get_woocommerce_price_format', []rt.PhpVal{})]) }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) get_locale_data() rt.PhpVal {
	mut var_wp_locale := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.create_array([rt.ArrayItem{ key: 'siteLocale', val: rt.call_function('get_locale', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'userLocale', val: rt.call_function('get_user_locale', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'weekdaysShort', val: rt.call_function('array_values', [rt.get_property(var_wp_locale, 'weekday_abbrev')]) }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) get_store_pages() rt.PhpVal {
	mut var_store_pages := rt.create_array([rt.ArrayItem{ key: 'myaccount', val: rt.call_function('wc_get_page_id', [rt.new_string('myaccount')]) }, rt.ArrayItem{ key: 'shop', val: rt.call_function('wc_get_page_id', [rt.new_string('shop')]) }, rt.ArrayItem{ key: 'cart', val: rt.call_function('wc_get_page_id', [rt.new_string('cart')]) }, rt.ArrayItem{ key: 'checkout', val: rt.call_function('wc_get_page_id', [rt.new_string('checkout')]) }, rt.ArrayItem{ key: 'privacy', val: rt.call_function('wc_privacy_policy_page_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'terms', val: rt.call_function('wc_terms_and_conditions_page_id', []rt.PhpVal{}) }])
	rt.call_function('_prime_post_caches', [rt.call_function('array_values', [var_store_pages.dup()]), rt.new_bool(false), rt.new_bool(false)])
	return rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'format_page_resource' }]), var_store_pages.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) get_products_settings() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'cartRedirectAfterAdd', val: rt.identical(rt.call_function('get_option', [rt.new_string('woocommerce_cart_redirect_after_add')]), rt.new_string('yes')) }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) format_page_resource(var_page rt.PhpVal) rt.PhpVal {
	mut var_page_mutated := var_page
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_page_mutated.dup().is_long() || var_page_mutated.dup().is_double())) && rt.is_true(rt.greater(var_page_mutated, rt.new_int(0))))) {
		var_page_mutated = rt.call_function('get_post', [var_page_mutated.dup()])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_page_mutated.dup(), rt.new_string('\\WP_Post')]))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.create_array([rt.ArrayItem{ key: 'id', val: 0 }, rt.ArrayItem{ key: 'title', val: '' }, rt.ArrayItem{ key: 'permalink', val: false }])
	}
	return rt.create_array([rt.ArrayItem{ key: 'id', val: rt.get_property(var_page_mutated, 'ID') }, rt.ArrayItem{ key: 'title', val: rt.get_property(var_page_mutated, 'post_title') }, rt.ArrayItem{ key: 'permalink', val: rt.call_function('get_permalink', [rt.get_property(var_page_mutated, 'ID')]) }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) get_order_statuses() rt.PhpVal {
	mut var_formatted_statuses := rt.new_array()
	{
		mut iter_1 := rt.call_function('wc_get_order_statuses', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			mut var_formatted_key := rt.call_function('preg_replace', [rt.new_string('/^wc-/'), rt.new_string(''), var_key.dup()])
			var_formatted_statuses.array_set(var_formatted_key, var_value.dup())
		}
	}
	return var_formatted_statuses.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) initialize_core_data()  {
	mut var_settings := rt.call_function('apply_filters', [rt.new_string('woocommerce_shared_settings'), this.data])
	if rt.is_true(rt.call_function('has_filter', [rt.new_string('woocommerce_shared_settings')])) {
		mut var_error_handle := rt.new_string(rt.new_string('deprecated-shared-settings-error'))
		mut var_error_message := rt.new_string(rt.new_string('`woocommerce_shared_settings` filter in Blocks is deprecated. See https://github.com/woocommerce/woocommerce-gutenberg-products-block/blob/trunk/docs/contributors/block-assets.md'))
		rt.call_function('wp_register_script', [var_error_handle.dup(), rt.new_string('')])
		rt.call_function('wp_enqueue_script', [var_error_handle.dup()])
		rt.call_function('wp_add_inline_script', [var_error_handle.dup(), rt.call_function('sprintf', [rt.new_string('console.warn( "%s" );'), var_error_message.dup()])])
	}
	mut var_core_data := this.get_core_data()
	var_core_data.array_set('experimentalWcRestApiV4', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}; return temp.is_enabled(arg_0) }(rt.new_string('rest-api-v4')))
	this.data = rt.call_function('array_replace_recursive', [var_settings.dup(), var_core_data.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) execute_lazy_data()  {
	{
		mut iter_1 := this.lazy_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_callback := item_1.val
			mut var_key := item_1.key
			this.data.array_set(var_key, rt.call_callable(var_callback, []rt.PhpVal{}))
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) get() rt.PhpVal {
	return this.data
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) exists(var_key rt.PhpVal) bool {
	return this.data.array_isset(var_key.dup())
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) add(var_key rt.PhpVal, var_data rt.PhpVal, check_key_exists bool)  {
	mut var_data_mutated := var_data
	if var_check_key_exists {
		rt.call_function('wc_deprecated_argument', [rt.new_string('Automattic\\WooCommerce\\Blocks\\Assets\\AssetDataRegistry::add()'), rt.new_string('8.9'), rt.new_string('The $check_key_exists parameter is no longer used: all duplicate data will be ignored if the key exists by default')])
	}
	this.add_data(var_key.dup(), var_data_mutated.dup())
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) hydrate_api_request(var_path rt.PhpVal)  {
	if !(this.preloaded_api_requests.array_isset(var_path)) {
		this.preloaded_api_requests.array_set(var_path, rt.call_method(rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Package{}; return temp.container() }(), 'get', [Class_Automattic_WooCommerce_Blocks_Domain_Services_Hydration.class()]), 'get_rest_api_response_data', [var_path.dup()]))
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) hydrate_data_from_api_request(var_key rt.PhpVal, var_path rt.PhpVal, check_key_exists bool)  {
	closure_1_fn := fn [var_path] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	if this.preloaded_api_requests.array_isset(var_path) && this.preloaded_api_requests.array_get(var_path).array_isset(rt.new_string('body')) {
		return this.preloaded_api_requests.array_get(var_path).array_get('body')
	}
	mut var_response := rt.call_method(rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Package{}; return temp.container() }(), 'get', [Class_Automattic_WooCommerce_Blocks_Domain_Services_Hydration.class()]), 'get_rest_api_response_data', [var_path.dup()])
	return if !(var_response.array_get('body')).is_null() { var_response.array_get('body') } else { rt.new_string('') }
	}
	this.add(var_key.dup(), rt.new_closure(closure_1_fn), check_key_exists)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) register_page_id(var_page_id rt.PhpVal)  {
	mut var_permalink := if rt.is_true(var_page_id) { rt.call_function('get_permalink', [var_page_id.dup()]) } else { rt.new_bool(false) }
	if rt.is_true(var_permalink) {
		this.data.array_set('page-' + (var_page_id).str(), var_permalink.dup())
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) register_data_script()  {
	rt.call_method(this.api, 'register_script', [this.handle, rt.new_string('assets/client/blocks/wc-settings.js'), rt.create_array([rt.ArrayItem{ key: none, val: 'wp-api-fetch' }]), rt.new_bool(true)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) enqueue_asset_data()  {
	if rt.is_true(rt.call_function('wp_script_is', [this.handle, rt.new_string('enqueued')])) {
		this.initialize_core_data()
		this.execute_lazy_data()
		mut var_data := rt.call_function('rawurlencode', [rt.call_function('wp_json_encode', [this.data])])
		mut var_wc_settings_script := rt.new_string('var wcSettings = JSON.parse( decodeURIComponent( \'' + (rt.call_function('esc_js', [var_data.dup()])).str() + '\' ) );')
		mut var_preloaded_api_requests_script := rt.new_string(rt.new_string(''))
		if this.preloaded_api_requests.array_count() > 0 {
			mut var_preloaded_api_requests := rt.call_function('rawurlencode', [rt.call_function('wp_json_encode', [this.preloaded_api_requests])])
			var_preloaded_api_requests_script = rt.new_string('wp.apiFetch.use( wp.apiFetch.createPreloadingMiddleware( JSON.parse( decodeURIComponent( \'' + (rt.call_function('esc_js', [var_preloaded_api_requests.dup()])).str() + '\' ) ) ) );')
		}
		rt.call_function('wp_add_inline_script', [this.handle, rt.concat(var_wc_settings_script, var_preloaded_api_requests_script), rt.new_string('before')])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) add_data(var_key rt.PhpVal, var_data rt.PhpVal)  {
	mut var_data_mutated := var_data
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_key.dup().is_string()))))) {
		rt.call_function('trigger_error', [rt.call_function('esc_html__', [rt.new_string('Key for the data being registered must be a string'), rt.new_string('woocommerce')]), rt.get_constant('E_USER_WARNING')])
		return rt.new_null()
	}
	if this.exists(var_key.dup()) {
		return rt.new_null()
	}
	if this.data.array_isset(var_key) {
		rt.call_function('trigger_error', [rt.call_function('esc_html__', [rt.new_string('Overriding existing data with an already registered key is not allowed'), rt.new_string('woocommerce')]), rt.get_constant('E_USER_WARNING')])
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('is_callable', [var_data_mutated.dup()])) {
		this.lazy_data.array_set(var_key, var_data_mutated.dup())
		return rt.new_null()
	}
	this.data.array_set(var_key, var_data_mutated.dup())
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) debug() bool {
	return rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG')])) && rt.is_true(rt.get_constant('WP_DEBUG'))
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Package {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_assets_assetdataregistry(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry{
		PhpObjectBase: rt.PhpObjectBase{}
		data: rt.new_array()
		preloaded_api_requests: rt.new_array()
		lazy_data: rt.new_array()
		handle: rt.new_string('wc-settings')
		api: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_admin_features_features() &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_package() &Class_Automattic_WooCommerce_Blocks_Package {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Package{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Assets_Api](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'get_core_data' {
			return this.get_core_data()
		}
		'get_currency_data' {
			return this.get_currency_data()
		}
		'get_locale_data' {
			return this.get_locale_data()
		}
		'get_store_pages' {
			return this.get_store_pages()
		}
		'get_products_settings' {
			return this.get_products_settings()
		}
		'format_page_resource' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.format_page_resource(dispatch_arg_0)
		}
		'get_order_statuses' {
			return this.get_order_statuses()
		}
		'initialize_core_data' {
			this.initialize_core_data()
			return rt.new_null()
		}
		'execute_lazy_data' {
			this.execute_lazy_data()
			return rt.new_null()
		}
		'get' {
			return this.get()
		}
		'exists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.exists(dispatch_arg_0))
		}
		'add' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.add(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'hydrate_api_request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.hydrate_api_request(dispatch_arg_0)
			return rt.new_null()
		}
		'hydrate_data_from_api_request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.hydrate_data_from_api_request(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'register_page_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.register_page_id(dispatch_arg_0)
			return rt.new_null()
		}
		'register_data_script' {
			this.register_data_script()
			return rt.new_null()
		}
		'enqueue_asset_data' {
			this.enqueue_asset_data()
			return rt.new_null()
		}
		'add_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.add_data(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'debug' {
			return rt.new_bool(this.debug())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'data' { return this.data }
		'preloaded_api_requests' { return this.preloaded_api_requests }
		'lazy_data' { return this.lazy_data }
		'handle' { return this.handle }
		'api' { return this.api }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'data' { this.data = val; return true }
		'preloaded_api_requests' { this.preloaded_api_requests = val; return true }
		'lazy_data' { this.lazy_data = val; return true }
		'handle' { this.handle = val; return true }
		'api' { this.api = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Package) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_blocks_assets_assetdataregistry_php() {
}
