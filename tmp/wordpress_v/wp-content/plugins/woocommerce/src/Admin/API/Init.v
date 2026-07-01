import rt

struct Class_Automattic_WooCommerce_Admin_API_Init {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Admin_API_Init.instance() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), // unsupported expression: Expr_StaticPropertyFetch)) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Init) construct()  {
	rt.call_function('add_filter', [rt.new_string('woocommerce_data_stores'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_data_stores' }])])
	rt.call_function('add_action', [rt.new_string('rest_api_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Init', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'rest_api_init' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_rest_prepare_shop_order_object'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_currency_symbol_to_order_response' }])])
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/class-wc-admin-upload-downloadable-product.php', '2')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Init) rest_api_init()  {
	if rt.is_true(rt.call_function('wc_rest_should_load_namespace', [rt.new_string('wc-admin')])) {
		this.rest_api_init_wc_admin()
	}
	mut var_rest_api_util := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Utilities_RestApiUtil.class()])
	rt.call_method(var_rest_api_util, 'lazy_load_namespace', [rt.new_string('wc-analytics'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Init', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'rest_api_init_wc_analytics' }])])
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}; return temp.is_enabled(arg_0) }(rt.new_string('launch-your-store'))) {
		mut var_controller := rt.new_string(rt.new_string('Automattic\\WooCommerce\\Admin\\API\\LaunchYourStore'))
		this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":71,"name":"controller"}', rt.create_object_dynamically(var_controller, []rt.PhpVal{}))
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Init', []string{}, &this), '{"nodeType":"Expr_Variable","line":72,"name":"controller"}'), 'register_routes', []rt.PhpVal{})
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Init) rest_api_init_wc_admin()  {
	mut var_controllers := rt.create_array([rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Notice' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Features' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Experiments' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Marketing' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\MarketingOverview' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\MarketingRecommendations' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\MarketingChannels' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\MarketingCampaigns' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\MarketingCampaignTypes' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Options' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Settings' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\PaymentGatewaySuggestions' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Themes' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Plugins' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\OnboardingFreeExtensions' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\OnboardingProductTypes' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\OnboardingProfile' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\OnboardingTasks' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\OnboardingThemes' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\OnboardingPlugins' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\OnboardingProducts' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\MobileAppMagicLink' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\ShippingPartnerSuggestions' }])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_admin_rest_controllers')]))))) {
		var_controllers = rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_rest_controllers'), var_controllers.dup()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_controllers.dup().is_array()))))) {
			return rt.new_null()
		}
	}
	var_controllers = rt.call_function('array_values', [rt.call_function('array_unique', [var_controllers.dup()])])
	{
		mut iter_1 := var_controllers.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_controller := item_1.val
			if rt.is_true(rt.new_bool(var_controller.dup().is_string())) {
				this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":129,"name":"controller"}', rt.create_object_dynamically(var_controller, []rt.PhpVal{}))
				rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Init', []string{}, &this), '{"nodeType":"Expr_Variable","line":130,"name":"controller"}'), 'register_routes', []rt.PhpVal{})
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Init) rest_api_init_wc_analytics()  {
	mut var_controllers := rt.create_array([rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Notes' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\NoteActions' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Coupons' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Data' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\DataCountries' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\DataDownloadIPs' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Orders' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Products' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\ProductAttributes' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\ProductAttributeTerms' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\ProductCategories' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\ProductVariations' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\ProductReviews' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\ProductsLowInStock' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\SettingOptions' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Taxes' }])
	mut var_analytics_controllers := rt.new_array()
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}; return temp.is_enabled(arg_0) }(rt.new_string('analytics'))) {
		var_analytics_controllers = rt.create_array([rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Customers' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Leaderboards' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Controller' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Import\\Controller' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Export\\Controller' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Products\\Controller' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Variations\\Controller' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Products\\Stats\\Controller' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Variations\\Stats\\Controller' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Revenue\\Stats\\Controller' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Orders\\Controller' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Orders\\Stats\\Controller' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Categories\\Controller' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Taxes\\Controller' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Taxes\\Stats\\Controller' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Coupons\\Controller' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Coupons\\Stats\\Controller' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Stock\\Controller' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Stock\\Stats\\Controller' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Downloads\\Controller' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Downloads\\Stats\\Controller' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Customers\\Controller' }, rt.ArrayItem{ key: none, val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Customers\\Stats\\Controller' }])
		if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}; return temp.is_enabled(arg_0) }(rt.new_string('analytics-scheduled-import'))) {
			var_analytics_controllers.array_push('Automattic\\WooCommerce\\Admin\\API\\AnalyticsImports')
		}
		var_analytics_controllers.array_push('Automattic\\WooCommerce\\Admin\\API\\Reports\\PerformanceIndicators\\Controller')
	}
	var_controllers = rt.call_function('array_merge', [var_analytics_controllers.dup(), var_controllers.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_admin_rest_controllers')]))))) {
		var_controllers = rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_rest_controllers'), var_controllers.dup()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_controllers.dup().is_array()))))) {
			return rt.new_null()
		}
	}
	var_controllers = rt.call_function('array_values', [rt.call_function('array_unique', [var_controllers.dup()])])
	{
		mut iter_1 := var_controllers.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_controller := item_1.val
			if rt.is_true(rt.new_bool(var_controller.dup().is_string())) {
				this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":218,"name":"controller"}', rt.create_object_dynamically(var_controller, []rt.PhpVal{}))
				rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Init', []string{}, &this), '{"nodeType":"Expr_Variable","line":219,"name":"controller"}'), 'register_routes', []rt.PhpVal{})
			}
		}
	}
}

fn Class_Automattic_WooCommerce_Admin_API_Init.add_data_stores(var_data_stores rt.PhpVal) rt.PhpVal {
	return rt.call_function('array_merge', [var_data_stores.dup(), rt.create_array([rt.ArrayItem{ key: 'report-revenue-stats', val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Orders\\Stats\\DataStore' }, rt.ArrayItem{ key: 'report-orders', val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Orders\\DataStore' }, rt.ArrayItem{ key: 'report-orders-stats', val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Orders\\Stats\\DataStore' }, rt.ArrayItem{ key: 'report-products', val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Products\\DataStore' }, rt.ArrayItem{ key: 'report-variations', val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Variations\\DataStore' }, rt.ArrayItem{ key: 'report-products-stats', val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Products\\Stats\\DataStore' }, rt.ArrayItem{ key: 'report-variations-stats', val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Variations\\Stats\\DataStore' }, rt.ArrayItem{ key: 'report-categories', val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Categories\\DataStore' }, rt.ArrayItem{ key: 'report-taxes', val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Taxes\\DataStore' }, rt.ArrayItem{ key: 'report-taxes-stats', val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Taxes\\Stats\\DataStore' }, rt.ArrayItem{ key: 'report-coupons', val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Coupons\\DataStore' }, rt.ArrayItem{ key: 'report-coupons-stats', val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Coupons\\Stats\\DataStore' }, rt.ArrayItem{ key: 'report-downloads', val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Downloads\\DataStore' }, rt.ArrayItem{ key: 'report-downloads-stats', val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Downloads\\Stats\\DataStore' }, rt.ArrayItem{ key: 'admin-note', val: 'Automattic\\WooCommerce\\Admin\\Notes\\DataStore' }, rt.ArrayItem{ key: 'report-customers', val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Customers\\DataStore' }, rt.ArrayItem{ key: 'report-customers-stats', val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Customers\\Stats\\DataStore' }, rt.ArrayItem{ key: 'report-stock-stats', val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Stock\\Stats\\DataStore' }])])
}

fn Class_Automattic_WooCommerce_Admin_API_Init.add_currency_symbol_to_order_response(var_response rt.PhpVal) rt.PhpVal {
	mut var_response_data := rt.call_method(var_response, 'get_data', []rt.PhpVal{})
	mut var_currency_code := var_response_data.array_get('currency')
	mut var_currency_symbol := rt.call_function('get_woocommerce_currency_symbol', [var_currency_code.dup()])
	var_response_data.array_set('currency_symbol', rt.call_function('html_entity_decode', [var_currency_symbol.dup()]))
	rt.call_method(var_response, 'set_data', [var_response_data.dup()])
	return var_response.dup()
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_init() &Class_Automattic_WooCommerce_Admin_API_Init {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Init{
		PhpObjectBase: rt.PhpObjectBase{}
		instance: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_features_features() &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Init) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'instance' {
			return Class_Automattic_WooCommerce_Admin_API_Init.instance()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'rest_api_init' {
			this.rest_api_init()
			return rt.new_null()
		}
		'rest_api_init_wc_admin' {
			this.rest_api_init_wc_admin()
			return rt.new_null()
		}
		'rest_api_init_wc_analytics' {
			this.rest_api_init_wc_analytics()
			return rt.new_null()
		}
		'add_data_stores' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Init.add_data_stores(dispatch_arg_0)
		}
		'add_currency_symbol_to_order_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Init.add_currency_symbol_to_order_response(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Init) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Init) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
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


fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Admin_API_Init', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_api_init()
		return rt.new_object('Automattic_WooCommerce_Admin_API_Init', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Features_Features', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_features_features()
		return rt.new_object('Automattic_WooCommerce_Admin_Features_Features', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_admin_api_init_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
