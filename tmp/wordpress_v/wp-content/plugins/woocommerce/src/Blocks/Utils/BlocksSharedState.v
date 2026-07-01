import rt

struct Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState {
	rt.PhpObjectBase
pub mut:
		consent_statement rt.PhpVal = rt.new_string('I acknowledge that using private APIs means my theme or plugin will inevitably break in the next version of WooCommerce')
		settings_namespace rt.PhpVal = rt.new_string('woocommerce')
		core_config_registered rt.PhpVal = rt.new_bool(false)
		blocks_shared_cart_state rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState.prevent_cache()  {
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_WC_Cache_Helper{}; return temp.set_nocache_constants() }()
	rt.call_function('nocache_headers', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState.check_consent(consent_statement string) bool {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.new_string('This method cannot be called without consenting the API may change.'))))
	}
	return true
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState.load_store_config(consent_statement string)  {
	Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState.check_consent(consent_statement)
	if rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		return rt.new_null()
	}
	// unsupported assign target: Expr_StaticPropertyFetch
	rt.call_function('wp_interactivity_config', [// unsupported expression: Expr_StaticPropertyFetch, Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState.get_currency_data()])
	rt.call_function('wp_interactivity_config', [// unsupported expression: Expr_StaticPropertyFetch, Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState.get_locale_data()])
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState.load_cart_state(consent_statement string)  {
	Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState.check_consent(consent_statement)
	if rt.is_true(rt.identical(rt.new_null(), // unsupported expression: Expr_StaticPropertyFetch)) {
		mut var_cart_exists := rt.new_bool(!(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart')).is_null())
		mut var_cart_has_contents := rt.new_bool(rt.new_bool(rt.is_true(var_cart_exists) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'is_empty', []rt.PhpVal{})))))))
		if rt.is_true(var_cart_exists) {
			mut var_cart_response := rt.call_method(rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Package{}; return temp.container() }(), 'get', [Class_Automattic_WooCommerce_Blocks_Domain_Services_Hydration.class()]), 'get_rest_api_response_data', [rt.new_string('/wc/store/v1/cart')])
			// unsupported assign target: Expr_StaticPropertyFetch
		} else {
			// unsupported assign target: Expr_StaticPropertyFetch
		}
		if rt.is_true(var_cart_has_contents) {
			Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState.prevent_cache()
		}
		rt.call_function('wp_interactivity_config', [// unsupported expression: Expr_StaticPropertyFetch, rt.create_array([rt.ArrayItem{ key: 'nonOptimisticProperties', val: Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState.get_non_optimistic_properties() }])])
		rt.call_function('wp_interactivity_state', [// unsupported expression: Expr_StaticPropertyFetch, rt.create_array([rt.ArrayItem{ key: 'cart', val: // unsupported expression: Expr_StaticPropertyFetch }, rt.ArrayItem{ key: 'noticeId', val: '' }, rt.ArrayItem{ key: 'restUrl', val: rt.call_function('get_rest_url', []rt.PhpVal{}) }])])
	}
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState.get_currency_data() rt.PhpVal {
	mut var_currency := rt.call_function('get_woocommerce_currency', []rt.PhpVal{})
	return rt.create_array([rt.ArrayItem{ key: 'currency', val: rt.create_array([rt.ArrayItem{ key: 'code', val: var_currency }, rt.ArrayItem{ key: 'precision', val: rt.call_function('wc_get_price_decimals', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'symbol', val: rt.call_function('html_entity_decode', [rt.call_function('get_woocommerce_currency_symbol', [var_currency.dup()])]) }, rt.ArrayItem{ key: 'symbolPosition', val: rt.call_function('get_option', [rt.new_string('woocommerce_currency_pos')]) }, rt.ArrayItem{ key: 'decimalSeparator', val: rt.call_function('wc_get_price_decimal_separator', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'thousandSeparator', val: rt.call_function('wc_get_price_thousand_separator', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'priceFormat', val: rt.call_function('html_entity_decode', [rt.call_function('get_woocommerce_price_format', []rt.PhpVal{})]) }]) }])
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState.get_locale_data() rt.PhpVal {
	mut var_wp_locale := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.create_array([rt.ArrayItem{ key: 'locale', val: rt.create_array([rt.ArrayItem{ key: 'siteLocale', val: rt.call_function('get_locale', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'userLocale', val: rt.call_function('get_user_locale', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'weekdaysShort', val: rt.call_function('array_values', [rt.get_property(var_wp_locale, 'weekday_abbrev')]) }]) }])
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState.get_non_optimistic_properties() rt.PhpVal {
	mut var_properties := rt.new_array()
	if rt.is_true(rt.call_function('has_filter', [rt.new_string('woocommerce_cart_contents_count')])) {
		var_properties.array_push('cart.items_count')
	}
	return var_properties.dup()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState.load_placeholder_image(consent_statement string)  {
	Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState.check_consent(consent_statement)
	rt.call_function('wp_interactivity_config', [// unsupported expression: Expr_StaticPropertyFetch, rt.create_array([rt.ArrayItem{ key: 'placeholderImgSrc', val: rt.call_function('wc_placeholder_img_src', []rt.PhpVal{}) }])])
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState.get_cart_error_notices(consent_statement string) rt.PhpVal {
	Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState.check_consent(consent_statement)
	if rt.is_true(rt.identical(rt.new_null(), // unsupported expression: Expr_StaticPropertyFetch)) {
		Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState.load_cart_state(consent_statement)
	}
	mut var_errors := if !(// unsupported expression: Expr_StaticPropertyFetch.array_get('errors')).is_null() { // unsupported expression: Expr_StaticPropertyFetch.array_get('errors') } else { rt.new_array() }
	mut var_notices := rt.new_array()
	{
		mut iter_1 := var_errors.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_error := item_1.val
			var_notices.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_function('wp_unique_id', [rt.new_string('store-notice-')]) }, rt.ArrayItem{ key: 'notice', val: if !(var_error.array_get('message')).is_null() { var_error.array_get('message') } else { rt.new_string('') } }, rt.ArrayItem{ key: 'type', val: 'error' }, rt.ArrayItem{ key: 'dismissible', val: true }]))
		}
	}
	return var_notices.dup()
}

struct Class_Automattic_WooCommerce_Blocks_Utils_WC_Cache_Helper {
	rt.PhpObjectBase
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Package {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_utils_blockssharedstate() &Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState{
		PhpObjectBase: rt.PhpObjectBase{}
		consent_statement: rt.new_string('I acknowledge that using private APIs means my theme or plugin will inevitably break in the next version of WooCommerce')
		settings_namespace: rt.new_string('woocommerce')
		core_config_registered: rt.new_bool(false)
		blocks_shared_cart_state: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_wc_cache_helper() &Class_Automattic_WooCommerce_Blocks_Utils_WC_Cache_Helper {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_invalidargumentexception() &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
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

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'prevent_cache' {
			Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState.prevent_cache()
			return rt.new_null()
		}
		'check_consent' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState.check_consent(dispatch_arg_0))
		}
		'load_store_config' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState.load_store_config(dispatch_arg_0)
			return rt.new_null()
		}
		'load_cart_state' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState.load_cart_state(dispatch_arg_0)
			return rt.new_null()
		}
		'get_currency_data' {
			return Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState.get_currency_data()
		}
		'get_locale_data' {
			return Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState.get_locale_data()
		}
		'get_non_optimistic_properties' {
			return Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState.get_non_optimistic_properties()
		}
		'load_placeholder_image' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState.load_placeholder_image(dispatch_arg_0)
			return rt.new_null()
		}
		'get_cart_error_notices' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState.get_cart_error_notices(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'consent_statement' { return this.consent_statement }
		'settings_namespace' { return this.settings_namespace }
		'core_config_registered' { return this.core_config_registered }
		'blocks_shared_cart_state' { return this.blocks_shared_cart_state }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'consent_statement' { this.consent_statement = val; return true }
		'settings_namespace' { this.settings_namespace = val; return true }
		'core_config_registered' { this.core_config_registered = val; return true }
		'blocks_shared_cart_state' { this.blocks_shared_cart_state = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_blocks_utils_blockssharedstate_php() {
	// unsupported statement: Stmt_Declare
}
