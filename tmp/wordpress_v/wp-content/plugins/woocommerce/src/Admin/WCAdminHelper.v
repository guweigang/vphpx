import rt

pub fn Class_Automattic_WooCommerce_Admin_WCAdminHelper.wc_admin_timestamp_option() string {
	return 'woocommerce_admin_install_timestamp'
}
pub fn Class_Automattic_WooCommerce_Admin_WCAdminHelper.wc_admin_store_age_ranges() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'week-1', val: rt.create_array([rt.ArrayItem{ key: 'start', val: 0 }, rt.ArrayItem{ key: 'end', val: rt.get_constant('WEEK_IN_SECONDS') }]) }, rt.ArrayItem{ key: 'week-1-4', val: rt.create_array([rt.ArrayItem{ key: 'start', val: rt.get_constant('WEEK_IN_SECONDS') }, rt.ArrayItem{ key: 'end', val: rt.mul(rt.get_constant('WEEK_IN_SECONDS'), rt.new_int(4)) }]) }, rt.ArrayItem{ key: 'month-1-3', val: rt.create_array([rt.ArrayItem{ key: 'start', val: rt.get_constant('MONTH_IN_SECONDS') }, rt.ArrayItem{ key: 'end', val: rt.mul(rt.get_constant('MONTH_IN_SECONDS'), rt.new_int(3)) }]) }, rt.ArrayItem{ key: 'month-3-6', val: rt.create_array([rt.ArrayItem{ key: 'start', val: rt.mul(rt.get_constant('MONTH_IN_SECONDS'), rt.new_int(3)) }, rt.ArrayItem{ key: 'end', val: rt.mul(rt.get_constant('MONTH_IN_SECONDS'), rt.new_int(6)) }]) }, rt.ArrayItem{ key: 'month-6+', val: rt.create_array([rt.ArrayItem{ key: 'start', val: rt.mul(rt.get_constant('MONTH_IN_SECONDS'), rt.new_int(6)) }]) }])
}
struct Class_Automattic_WooCommerce_Admin_WCAdminHelper {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Admin_WCAdminHelper.get_wcadmin_active_for_in_seconds() rt.PhpVal {
	mut var_install_timestamp := rt.call_function('get_option', [Class_Automattic_WooCommerce_Admin_Automattic_WooCommerce_Admin_WCAdminHelper.wc_admin_timestamp_option()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_install_timestamp.dup().is_long() || var_install_timestamp.dup().is_double()))))) {
		var_install_timestamp = rt.call_function('time', []rt.PhpVal{})
		rt.call_function('update_option', [Class_Automattic_WooCommerce_Admin_Automattic_WooCommerce_Admin_WCAdminHelper.wc_admin_timestamp_option(), var_install_timestamp.dup()])
	}
	return rt.sub(rt.call_function('time', []rt.PhpVal{}), var_install_timestamp)
}

fn Class_Automattic_WooCommerce_Admin_WCAdminHelper.is_wc_admin_active_for(var_seconds rt.PhpVal) rt.PhpVal {
	mut var_wc_admin_active_for := Class_Automattic_WooCommerce_Admin_WCAdminHelper.get_wcadmin_active_for_in_seconds()
	return rt.greater_equal(var_wc_admin_active_for, var_seconds)
}

fn Class_Automattic_WooCommerce_Admin_WCAdminHelper.is_wc_admin_active_in_date_range(var_range rt.PhpVal, var_custom_start rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(Class_Automattic_WooCommerce_Admin_Automattic_WooCommerce_Admin_WCAdminHelper.wc_admin_store_age_ranges().array_isset(var_range.dup())))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Admin_InvalidArgumentException', []string{}, create_automattic_woocommerce_admin_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('"%s" range is not supported, use one of: %s'), var_range.dup(), rt.call_function('implode', [rt.new_string(', '), rt.func_array_keys(Class_Automattic_WooCommerce_Admin_Automattic_WooCommerce_Admin_WCAdminHelper.wc_admin_store_age_ranges())])]))))
	}
	mut var_wc_admin_active_for := Class_Automattic_WooCommerce_Admin_WCAdminHelper.get_wcadmin_active_for_in_seconds()
	mut var_range_data := Class_Automattic_WooCommerce_Admin_Automattic_WooCommerce_Admin_WCAdminHelper.wc_admin_store_age_ranges().array_get(var_range)
	mut var_start := if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_custom_start } else { var_range_data.array_get('start') }
	if rt.is_true(rt.new_bool(rt.is_true(var_range_data) && rt.is_true(rt.greater_equal(var_wc_admin_active_for, var_start)))) {
		return (if var_range_data.array_isset(rt.new_string('end')) { rt.less(var_wc_admin_active_for, var_range_data.array_get('end')) } else { rt.new_bool(true) }).to_bool()
	}
	return false
}

fn Class_Automattic_WooCommerce_Admin_WCAdminHelper.is_site_fresh() bool {
	mut var_fresh_site := rt.call_function('get_option', [rt.new_string('fresh_site')])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return false
	}
	mut var_current_userdata := rt.call_function('get_userdata', [rt.call_function('get_current_user_id', []rt.PhpVal{})])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_current_userdata)))) {
		return false
	}
	mut var_date := create_automattic_woocommerce_admin_datetime(rt.get_property(var_current_userdata, 'user_registered'))
	mut var_month_ago := create_automattic_woocommerce_admin_datetime(rt.new_string('-1 month'))
	return (rt.greater(var_date, var_month_ago)).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_WCAdminHelper.is_current_page_store_page() bool {
	mut var_wp := rt.new_null()
	mut var_store_pages := rt.create_array([rt.ArrayItem{ key: 'shop', val: rt.call_function('wc_get_page_id', [rt.new_string('shop')]) }, rt.ArrayItem{ key: 'cart', val: rt.call_function('wc_get_page_id', [rt.new_string('cart')]) }, rt.ArrayItem{ key: 'checkout', val: rt.call_function('wc_get_page_id', [rt.new_string('checkout')]) }, rt.ArrayItem{ key: 'terms', val: rt.call_function('wc_terms_and_conditions_page_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'coming_soon', val: rt.call_function('wc_get_page_id', [rt.new_string('coming_soon')]) }])
	var_store_pages = rt.call_function('apply_filters', [rt.new_string('woocommerce_store_pages'), var_store_pages.dup()])
	{
		mut iter_1 := var_store_pages.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_page_id := item_1.val
			mut var_page_slug := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_page_id, rt.new_int(0))) && rt.is_true(rt.call_function('is_page', [var_page_id.dup()])))) {
				return true
			}
		}
	}
	if rt.is_true(rt.call_function('is_post_type_archive', [rt.new_string('product')])) {
		return true
	}
	if rt.is_true(rt.call_function('is_singular', [rt.new_string('product')])) {
		return true
	}
	if rt.is_true(rt.call_function('is_product_taxonomy', []rt.PhpVal{})) {
		return true
	}
	// unsupported statement: Stmt_Global
	mut var_url := Class_Automattic_WooCommerce_Admin_WCAdminHelper.get_url_from_wp(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_WP](var_wp))
	mut var_is_store_page := rt.call_function('apply_filters', [rt.new_string('woocommerce_is_extension_store_page'), rt.new_bool(false), var_url.dup()])
	return (rt.call_function('filter_var', [var_is_store_page.dup(), rt.get_constant('FILTER_VALIDATE_BOOL')])).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_WCAdminHelper.is_store_page(url string) rt.PhpVal {
	mut url_mutated := url
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('9.8.0'), rt.new_string('is_current_page_store_page')])
	return Class_Automattic_WooCommerce_Admin_WCAdminHelper.is_current_page_store_page()
}

fn Class_Automattic_WooCommerce_Admin_WCAdminHelper.get_normalized_url_path(var_url rt.PhpVal) rt.PhpVal {
	mut var_url_mutated := var_url
	mut var_query := rt.call_function('wp_parse_url', [var_url_mutated.dup(), rt.get_constant('PHP_URL_QUERY')])
	mut var_path := rt.new_string((rt.call_function('wp_parse_url', [var_url_mutated.dup(), rt.get_constant('PHP_URL_PATH')])).str() + if rt.is_true(var_query) { '?' + (var_query).str() } else { '' })
	mut var_home_path := if !(rt.call_function('wp_parse_url', [rt.call_function('site_url', []rt.PhpVal{}), rt.get_constant('PHP_URL_PATH')])).is_null() { rt.call_function('wp_parse_url', [rt.call_function('site_url', []rt.PhpVal{}), rt.get_constant('PHP_URL_PATH')]) } else { rt.new_string('') }
	mut var_normalized_path := rt.new_string(rt.new_string(rt.call_function('substr', [var_path.dup(), rt.new_int(var_home_path.dup().to_string().len)]).to_string().trim_space()))
	return var_normalized_path.dup()
}

fn Class_Automattic_WooCommerce_Admin_WCAdminHelper.get_url_from_wp(mut var_wp Class_Automattic_WooCommerce_Admin_WP) rt.PhpVal {
	if !rt.is_true(rt.get_property(var_wp, 'query_vars')) || !rt.is_true(rt.get_property(var_wp, 'request')) {
		var_wp.parse_request()
	}
	return rt.call_function('home_url', [rt.call_function('add_query_arg', [rt.get_property(var_wp, 'query_vars'), rt.get_property(var_wp, 'request')])])
}

struct Class_Automattic_WooCommerce_Admin_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_DateTime {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_wcadminhelper() &Class_Automattic_WooCommerce_Admin_WCAdminHelper {
	mut obj := &Class_Automattic_WooCommerce_Admin_WCAdminHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_invalidargumentexception() &Class_Automattic_WooCommerce_Admin_InvalidArgumentException {
	mut obj := &Class_Automattic_WooCommerce_Admin_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_datetime() &Class_Automattic_WooCommerce_Admin_DateTime {
	mut obj := &Class_Automattic_WooCommerce_Admin_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_WCAdminHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_wcadmin_active_for_in_seconds' {
			return Class_Automattic_WooCommerce_Admin_WCAdminHelper.get_wcadmin_active_for_in_seconds()
		}
		'is_wc_admin_active_for' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_WCAdminHelper.is_wc_admin_active_for(dispatch_arg_0)
		}
		'is_wc_admin_active_in_date_range' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_WCAdminHelper.is_wc_admin_active_in_date_range(dispatch_arg_0, dispatch_arg_1))
		}
		'is_site_fresh' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_WCAdminHelper.is_site_fresh())
		}
		'is_current_page_store_page' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_WCAdminHelper.is_current_page_store_page())
		}
		'is_store_page' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Admin_WCAdminHelper.is_store_page(dispatch_arg_0)
		}
		'get_normalized_url_path' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_WCAdminHelper.get_normalized_url_path(dispatch_arg_0)
		}
		'get_url_from_wp' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_WP](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Admin_WCAdminHelper.get_url_from_wp(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_WCAdminHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_WCAdminHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_wcadminhelper_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
