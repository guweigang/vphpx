import rt

fn is_woocommerce() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('is_woocommerce'),
		rt.new_bool(is_shop() || rt.is_true(is_product_taxonomy()) || rt.is_true(is_product()))])
}

fn is_shop() bool {
	return rt.is_true(rt.call_function('is_post_type_archive', [rt.new_string('product')]))
		|| rt.is_true(rt.call_function('is_page', [rt.call_function('wc_get_page_id', [rt.new_string('shop')])]))
}

fn is_product_taxonomy() rt.PhpVal {
	return rt.call_function('is_tax', [
		rt.call_function('get_object_taxonomies', [rt.new_string('product')]),
	])
}

fn is_product_category(term string) rt.PhpVal {
	mut var_term := term
	return rt.call_function('is_tax', [rt.new_string('product_cat'),
		rt.new_string(term)])
}

fn is_product_tag(term string) rt.PhpVal {
	mut var_term := term
	return rt.call_function('is_tax', [rt.new_string('product_tag'),
		rt.new_string(term)])
}

fn is_product() rt.PhpVal {
	return rt.call_function('is_singular', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'product' }]),
	])
}

fn is_cart() bool {
	mut iife_temp_0 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_0 := iife_temp_0.is_defined(rt.new_string('WOOCOMMERCE_CART'))
	mut iife_temp_1 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_1 := iife_temp_1.is_cart_page()
	return
		rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_is_cart'), rt.new_bool(false)]))
		|| rt.is_true(iife_result_0) || rt.is_true(iife_result_1)
}

fn is_checkout() bool {
	mut iife_temp_2 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_2 := iife_temp_2.is_defined(rt.new_string('WOOCOMMERCE_CHECKOUT'))
	mut iife_temp_3 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_3 := iife_temp_3.is_checkout_page()
	return
		rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_is_checkout'), rt.new_bool(false)]))
		|| rt.is_true(iife_result_2) || rt.is_true(iife_result_3)
}

fn is_checkout_pay_page(use_query_params bool) bool {
	mut var_use_query_params := use_query_params
	mut var_wp := rt.new_null()
	if !(!rt.is_true(rt.get_property(var_wp, 'query_vars').array_get(rt.new_string('order-pay'))))
		&& is_checkout() {
		return true
	}
	if var_use_query_params {
		return (rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('pay_for_order')))).to_bool()
	}
	return false
}

fn is_wc_endpoint_url(endpoint bool) bool {
	mut var_endpoint := endpoint
	mut var_wp := rt.new_null()
	mut var_wc_endpoints := rt.new_null()
	mut var_endpoint_var := rt.new_null()
	mut var_value := rt.new_null()
	mut var_key := rt.new_null()
	var_wc_endpoints = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'query'), 'get_query_vars', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(endpoint))))) {
		if !(var_wc_endpoints.array_isset(rt.new_bool(endpoint))) {
			return false
		} else {
			var_endpoint_var = var_wc_endpoints.array_get(rt.new_bool(endpoint))
		}
		return (rt.new_bool(rt.get_property(var_wp, 'query_vars').array_isset(var_endpoint_var))).to_bool()
	} else {
		mut iter_1 := var_wc_endpoints.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value_shadow := item_1.val
			mut var_key_shadow := item_1.key
			if rt.get_property(var_wp, 'query_vars').array_isset(var_key_shadow) {
				return true
			}
		}
		return false
	}
	return false
}

fn is_account_page() bool {
	mut var_page_id := rt.new_null()
	var_page_id = rt.call_function('wc_get_page_id', [rt.new_string('myaccount')])
	return
		(rt.is_true(var_page_id) && rt.is_true(rt.call_function('is_page', [var_page_id.clone()])))
		|| wc_post_content_has_shortcode('woocommerce_my_account')
		|| rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_is_account_page'), rt.new_bool(false)]))
}

fn is_view_order_page() bool {
	mut var_wp := rt.new_null()
	mut var_page_id := rt.new_null()
	var_page_id = rt.call_function('wc_get_page_id', [rt.new_string('myaccount')])
	return rt.is_true(var_page_id) && rt.is_true(rt.call_function('is_page', [var_page_id.clone()]))
		&& rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('view-order'))
}

fn is_edit_account_page() bool {
	mut var_wp := rt.new_null()
	mut var_page_id := rt.new_null()
	var_page_id = rt.call_function('wc_get_page_id', [rt.new_string('myaccount')])
	return rt.is_true(var_page_id) && rt.is_true(rt.call_function('is_page', [var_page_id.clone()]))
		&& rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('edit-account'))
}

fn is_order_received_page() rt.PhpVal {
	mut var_wp := rt.new_null()
	mut var_page_id := rt.new_null()
	var_page_id = rt.call_function('wc_get_page_id', [rt.new_string('checkout')])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_is_order_received_page'),
		rt.new_bool(rt.is_true(var_page_id)
			&& rt.is_true(rt.call_function('is_page', [var_page_id.clone()]))
			&& rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('order-received'))),
	])
}

fn is_payment_methods_page() bool {
	mut var_wp := rt.new_null()
	mut var_page_id := rt.new_null()
	var_page_id = rt.call_function('wc_get_page_id', [rt.new_string('myaccount')])
	return rt.is_true(var_page_id) && rt.is_true(rt.call_function('is_page', [var_page_id.clone()]))
		&& rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('payment-methods'))
}

fn is_add_payment_method_page() bool {
	mut var_wp := rt.new_null()
	mut var_page_id := rt.new_null()
	var_page_id = rt.call_function('wc_get_page_id', [rt.new_string('myaccount')])
	return rt.is_true(var_page_id) && rt.is_true(rt.call_function('is_page', [var_page_id.clone()]))
		&& rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('payment-methods'))
		|| rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('add-payment-method'))
}

fn is_lost_password_page() bool {
	mut var_wp := rt.new_null()
	mut var_page_id := rt.new_null()
	var_page_id = rt.call_function('wc_get_page_id', [rt.new_string('myaccount')])
	return rt.is_true(var_page_id) && rt.is_true(rt.call_function('is_page', [var_page_id.clone()]))
		&& rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('lost-password'))
}

fn is_wc_admin_settings_page() bool {
	return rt.get_superglobal('_REQUEST').array_isset(rt.new_string('page'))
		&& rt.is_true(rt.identical(rt.new_string('wc-settings'), rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('page'))])))
		&& rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))
}

fn is_ajax() rt.PhpVal {
	mut iife_temp_4 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_4 := iife_temp_4.is_defined(rt.new_string('DOING_AJAX'))
	return if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_doing_ajax'),
	]))
	{ rt.call_function('wp_doing_ajax', []rt.PhpVal{}) } else { iife_result_4 }
}

fn is_store_notice_showing() bool {
	return rt.new_bool(!rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [
		rt.new_string('woocommerce_demo_store'),
		rt.new_string('no'),
	]))))
}

fn is_filtered() rt.PhpVal {
	mut iife_temp_5 := Class_WC_Query{}
	mut iife_result_5 := iife_temp_5.get_layered_nav_chosen_attributes()
	mut iife_temp_6 := Class_WC_Query{}
	mut iife_result_6 := iife_temp_6.get_layered_nav_chosen_attributes()
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_is_filtered'),
		rt.new_bool(iife_result_5.array_count() > 0
			|| rt.get_superglobal('_GET').array_isset(rt.new_string('max_price'))
			|| rt.get_superglobal('_GET').array_isset(rt.new_string('min_price'))
			|| rt.get_superglobal('_GET').array_isset(rt.new_string('rating_filter')))])
	return rt.new_null()
}

fn taxonomy_is_product_attribute(var_name rt.PhpVal) bool {
	mut var_wc_product_attributes := rt.new_null()
	return rt.is_true(rt.call_function('taxonomy_exists', [var_name.clone()]))
		&& rt.is_true(rt.new_bool(rt.cast_array(var_wc_product_attributes).array_isset(var_name.clone())))
}

fn meta_is_product_attribute(var_name rt.PhpVal, var_value rt.PhpVal, var_product_id rt.PhpVal) bool {
	mut var_product := rt.new_null()
	mut var_variation_attributes := rt.new_null()
	mut var_attributes := rt.new_null()
	var_product = rt.call_function('wc_get_product', [var_product_id.clone()])
	if rt.is_true(var_product)
		&& rt.is_true(rt.call_function('method_exists', [var_product.clone(), rt.new_string('get_variation_attributes')])) {
		var_variation_attributes = rt.call_method(var_product, 'get_variation_attributes',
			[]rt.PhpVal{})
		var_attributes = rt.call_method(var_product, 'get_attributes', []rt.PhpVal{})
		return
			rt.is_true(rt.call_function('in_array', [var_name.clone(), rt.func_array_keys(var_attributes.clone()), rt.new_bool(true)]))
			&& var_variation_attributes.array_isset(var_attributes.array_get(var_name).array_get(rt.new_string('name')))
			&& rt.is_true(rt.call_function('in_array', [var_value.clone(), var_variation_attributes.array_get(var_attributes.array_get(var_name).array_get(rt.new_string('name'))), rt.new_bool(true)]))
	} else {
		return false
	}
	return false
}

fn wc_tax_enabled() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('wc_tax_enabled'),
		rt.identical(rt.call_function('get_option', [
			rt.new_string('woocommerce_calc_taxes'),
		]), rt.new_string('yes'))])
}

fn wc_shipping_enabled() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('wc_shipping_enabled'),
		rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_option', [
			rt.new_string('woocommerce_ship_to_countries'),
		]), rt.new_string('disabled'))))])
}

fn wc_prices_include_tax() bool {
	return rt.is_true(wc_tax_enabled())
		&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_prices_include_tax'), rt.identical(rt.call_function('get_option', [rt.new_string('woocommerce_prices_include_tax')]), rt.new_string('yes'))]))
}

fn wc_is_valid_url(var_url rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_url.clone(), rt.new_string('http://')])))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_url.clone(), rt.new_string('https://')]))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('filter_var', [
		var_url.clone(), rt.get_constant('FILTER_VALIDATE_URL')])))))
	{
		return false
	}
	return true
}

fn wc_site_is_https() bool {
	return rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strstr', [
		rt.call_function('get_option', [rt.new_string('home')]),
		rt.new_string('https:'),
	]))))
}

fn wc_checkout_is_https() bool {
	return wc_site_is_https()
		|| rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_force_ssl_checkout')])))
		|| rt.is_true(rt.call_function('class_exists', [rt.new_string('WordPressHTTPS')]))
		|| rt.is_true(rt.call_function('strstr', [rt.call_function('wc_get_page_permalink', [rt.new_string('checkout')]), rt.new_string('https:')]))
}

fn wc_post_content_has_shortcode(tag string) bool {
	mut var_tag := tag
	mut var_post := rt.new_null()
	return rt.is_true(rt.call_function('is_singular', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('is_a', [var_post.clone(), rt.new_string('WP_Post')]))
		&& rt.is_true(rt.call_function('has_shortcode', [rt.get_property(var_post, 'post_content'), rt.new_string(tag)]))
}

fn wc_reviews_enabled() rt.PhpVal {
	return rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_enable_reviews'),
	]))
}

fn wc_review_ratings_enabled() bool {
	return rt.is_true(wc_reviews_enabled())
		&& rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_enable_review_rating')])))
}

fn wc_review_ratings_required() rt.PhpVal {
	return rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_review_rating_required'),
	]))
}

fn wc_is_file_valid_csv(var_file rt.PhpVal, check_path bool) bool {
	mut var_check_path := check_path
	mut var_check_import_file_path := rt.new_null()
	mut var_valid_filetypes := rt.new_null()
	mut var_filetype := rt.new_null()
	var_check_import_file_path = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_csv_importer_check_import_file_path'),
		rt.new_bool(true),
		var_file.clone(),
	])
	if var_check_path && rt.is_true(var_check_import_file_path)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [var_file.clone(), rt.new_string('file://')]))))) {
		return false
	}
	var_valid_filetypes = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_csv_import_valid_filetypes'),
		rt.create_array([rt.ArrayItem{ key: 'csv', val: 'text/csv' },
			rt.ArrayItem{ key: 'txt', val: 'text/plain' }]),
	])
	var_filetype = rt.call_function('wp_check_filetype', [var_file.clone(),
		var_valid_filetypes.clone()])
	if rt.is_true(rt.call_function('in_array', [var_filetype.array_get(rt.new_string('type')),
		var_valid_filetypes.clone(), rt.new_bool(true)]))
	{
		return true
	}
	return false
}

fn wc_current_theme_is_fse_theme() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@FN),
		rt.new_string('9.9.0'), rt.new_string('wp_is_block_theme')])
	return rt.call_function('wp_is_block_theme', []rt.PhpVal{})
}

fn wc_current_theme_supports_woocommerce_or_fse() bool {
	return
		rt.is_true((rt.call_function('current_theme_supports', [rt.new_string('woocommerce')])).to_bool())
		|| rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))
}

fn wc_wp_theme_get_element_class_name(var_element rt.PhpVal) string {
	if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_theme_get_element_class_name')])) {
		return (rt.call_function('wp_theme_get_element_class_name', [
			var_element.clone()])).str()
	}
	return ''
}

fn wc_block_theme_has_styles_for_element(var_element rt.PhpVal) bool {
	mut var_global_styles := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})))))
		|| rt.is_true(rt.identical(rt.new_string(wc_wp_theme_get_element_class_name(var_element.clone())), rt.new_string(''))) {
		return false
	}
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_get_global_styles'),
	]))
	{
		var_global_styles = rt.call_function('wp_get_global_styles', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(var_global_styles.clone().array_isset(rt.new_string('elements'))))
			&& rt.is_true(rt.new_bool(var_global_styles.array_get(rt.new_string('elements')).array_isset(var_element.clone()))) {
			return var_global_styles.array_get(rt.new_string('elements')).array_get(var_element).is_array()
		}
	}
	return false
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	rt.PhpObjectBase
}

struct Class_WC_Query {
	rt.PhpObjectBase
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_cartcheckoututils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{
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

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('is_shop'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('is_product_taxonomy'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('is_product_category'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('is_product_tag'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('is_product'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('is_cart'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('is_checkout'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('is_checkout_pay_page'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('is_wc_endpoint_url'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('is_account_page'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('is_view_order_page'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('is_edit_account_page'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('is_order_received_page'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('is_payment_methods_page'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('is_add_payment_method_page'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('is_lost_password_page'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('is_wc_admin_settings_page'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('is_ajax'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('is_store_notice_showing'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('is_filtered'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('taxonomy_is_product_attribute'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('meta_is_product_attribute'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wc_tax_enabled'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wc_shipping_enabled'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wc_prices_include_tax'),
	])))))
	{
	}
}
