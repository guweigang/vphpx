import rt

fn is_woocommerce() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('is_woocommerce'), rt.new_bool(rt.is_true(rt.new_bool(is_shop() || rt.is_true(is_product_taxonomy()))) || rt.is_true(is_product()))])
}

fn is_shop() bool {
	return rt.is_true(rt.call_function('is_post_type_archive', [rt.new_string('product')])) || rt.is_true(rt.call_function('is_page', [rt.call_function('wc_get_page_id', [rt.new_string('shop')])]))
}

fn is_product_taxonomy() rt.PhpVal {
	return rt.call_function('is_tax', [rt.call_function('get_object_taxonomies', [rt.new_string('product')])])
}

fn is_product_category(term string) rt.PhpVal {
	return rt.call_function('is_tax', [rt.new_string('product_cat'), rt.new_string(term)])
}

fn is_product_tag(term string) rt.PhpVal {
	return rt.call_function('is_tax', [rt.new_string('product_tag'), rt.new_string(term)])
}

fn is_product() rt.PhpVal {
	return rt.call_function('is_singular', [rt.create_array([rt.ArrayItem{ key: none, val: 'product' }])])
}

fn is_cart() bool {
	return rt.is_true(rt.new_bool(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_is_cart'), rt.new_bool(false)])) || rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_defined(arg_0) }(rt.new_string('WOOCOMMERCE_CART'))))) || rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}; return temp.is_cart_page() }())
}

fn is_checkout() bool {
	return rt.is_true(rt.new_bool(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_is_checkout'), rt.new_bool(false)])) || rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_defined(arg_0) }(rt.new_string('WOOCOMMERCE_CHECKOUT'))))) || rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}; return temp.is_checkout_page() }())
}

fn is_checkout_pay_page(use_query_params bool) bool {
	mut var_wp := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_property(var_wp, 'query_vars').array_get('order-pay'))) && is_checkout())) {
		return true
	}
	if var_use_query_params {
		return (rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('pay_for_order')))).to_bool()
		// unsupported statement: Stmt_Nop
	}
	return false
}

fn is_wc_endpoint_url(endpoint bool) bool {
	mut var_wp := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_wc_endpoints := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'), 'get_query_vars', []rt.PhpVal{})
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if !(var_wc_endpoints.array_isset(rt.new_bool(endpoint))) {
			return false
		} else {
			mut var_endpoint_var := var_wc_endpoints.array_get(endpoint)
		}
		return (rt.new_bool(rt.get_property(var_wp, 'query_vars').array_isset(var_endpoint_var))).to_bool()
	} else {
		{
			mut iter_1 := var_wc_endpoints.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_key := item_1.key
				if rt.get_property(var_wp, 'query_vars').array_isset(var_key) {
					return true
				}
			}
		}
		return false
	}
	return false
}

fn is_account_page() bool {
	mut var_page_id := rt.call_function('wc_get_page_id', [rt.new_string('myaccount')])
	return rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_page_id) && rt.is_true(rt.call_function('is_page', [var_page_id.dup()])))) || wc_post_content_has_shortcode('woocommerce_my_account'))) || rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_is_account_page'), rt.new_bool(false)]))
}

fn is_view_order_page() bool {
	mut var_wp := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_page_id := rt.call_function('wc_get_page_id', [rt.new_string('myaccount')])
	return rt.is_true(rt.new_bool(rt.is_true(var_page_id) && rt.is_true(rt.call_function('is_page', [var_page_id.dup()])))) && rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('view-order'))
}

fn is_edit_account_page() bool {
	mut var_wp := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_page_id := rt.call_function('wc_get_page_id', [rt.new_string('myaccount')])
	return rt.is_true(rt.new_bool(rt.is_true(var_page_id) && rt.is_true(rt.call_function('is_page', [var_page_id.dup()])))) && rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('edit-account'))
}

fn is_order_received_page() rt.PhpVal {
	mut var_wp := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_page_id := rt.call_function('wc_get_page_id', [rt.new_string('checkout')])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_is_order_received_page'), rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_page_id) && rt.is_true(rt.call_function('is_page', [var_page_id.dup()])))) && rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('order-received')))])
}

fn is_payment_methods_page() bool {
	mut var_wp := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_page_id := rt.call_function('wc_get_page_id', [rt.new_string('myaccount')])
	return rt.is_true(rt.new_bool(rt.is_true(var_page_id) && rt.is_true(rt.call_function('is_page', [var_page_id.dup()])))) && rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('payment-methods'))
}

fn is_add_payment_method_page() bool {
	mut var_wp := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_page_id := rt.call_function('wc_get_page_id', [rt.new_string('myaccount')])
	return rt.is_true(rt.new_bool(rt.is_true(var_page_id) && rt.is_true(rt.call_function('is_page', [var_page_id.dup()])))) && rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('payment-methods')) || rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('add-payment-method'))
}

fn is_lost_password_page() bool {
	mut var_wp := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_page_id := rt.call_function('wc_get_page_id', [rt.new_string('myaccount')])
	return rt.is_true(rt.new_bool(rt.is_true(var_page_id) && rt.is_true(rt.call_function('is_page', [var_page_id.dup()])))) && rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('lost-password'))
}

fn is_wc_admin_settings_page() bool {
	return rt.is_true(rt.new_bool(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('page')) && rt.is_true(rt.identical(rt.new_string('wc-settings'), rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('page')]))))) && rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))
}

fn is_ajax() rt.PhpVal {
	return if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_doing_ajax')])) { rt.call_function('wp_doing_ajax', []rt.PhpVal{}) } else { fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_defined(arg_0) }(rt.new_string('DOING_AJAX')) }
}

fn is_store_notice_showing() rt.PhpVal {
	return // unsupported expression: Expr_BinaryOp_NotIdentical
}

fn is_filtered() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_is_filtered'), rt.new_bool(fn () rt.PhpVal { mut temp := Class_WC_Query{}; return temp.get_layered_nav_chosen_attributes() }().array_count() > 0 || rt.get_superglobal('_GET').array_isset(rt.new_string('max_price')) || rt.get_superglobal('_GET').array_isset(rt.new_string('min_price')) || rt.get_superglobal('_GET').array_isset(rt.new_string('rating_filter')))])
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn taxonomy_is_product_attribute(var_name rt.PhpVal) bool {
	mut var_wc_product_attributes := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.is_true(rt.call_function('taxonomy_exists', [var_name.dup()])) && rt.is_true(rt.new_bool(rt.cast_array(var_wc_product_attributes).array_isset(var_name.dup())))
}

fn meta_is_product_attribute(var_name rt.PhpVal, var_value rt.PhpVal, var_product_id rt.PhpVal) bool {
	mut var_product := rt.call_function('wc_get_product', [var_product_id.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(var_product) && rt.is_true(rt.call_function('method_exists', [var_product.dup(), rt.new_string('get_variation_attributes')])))) {
		mut var_variation_attributes := rt.call_method(var_product, 'get_variation_attributes', []rt.PhpVal{})
		mut var_attributes := rt.call_method(var_product, 'get_attributes', []rt.PhpVal{})
		return rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [var_name.dup(), rt.func_array_keys(var_attributes.dup()), rt.new_bool(true)])) && var_variation_attributes.array_isset(var_attributes.array_get(var_name).array_get('name')))) && rt.is_true(rt.call_function('in_array', [var_value.dup(), var_variation_attributes.array_get(var_attributes.array_get(var_name).array_get('name')), rt.new_bool(true)]))
	} else {
		return false
	}
	return false
}

fn wc_tax_enabled() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('wc_tax_enabled'), rt.identical(rt.call_function('get_option', [rt.new_string('woocommerce_calc_taxes')]), rt.new_string('yes'))])
}

fn wc_shipping_enabled() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('wc_shipping_enabled'), // unsupported expression: Expr_BinaryOp_NotIdentical])
}

fn wc_prices_include_tax() bool {
	return rt.is_true(wc_tax_enabled()) && rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_prices_include_tax'), rt.identical(rt.call_function('get_option', [rt.new_string('woocommerce_prices_include_tax')]), rt.new_string('yes'))]))
}

fn wc_is_valid_url(var_url rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('filter_var', [var_url.dup(), rt.get_constant('FILTER_VALIDATE_URL')]))))) {
		return false
	}
	return true
}

fn wc_site_is_https() rt.PhpVal {
	return // unsupported expression: Expr_BinaryOp_NotIdentical
}

fn wc_checkout_is_https() bool {
	return rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(wc_site_is_https()) || rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_force_ssl_checkout')]))))) || rt.is_true(rt.call_function('class_exists', [rt.new_string('WordPressHTTPS')])))) || rt.is_true(rt.call_function('strstr', [rt.call_function('wc_get_page_permalink', [rt.new_string('checkout')]), rt.new_string('https:')]))
}

fn wc_post_content_has_shortcode(tag string) bool {
	mut var_post := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_singular', []rt.PhpVal{})) && rt.is_true(rt.call_function('is_a', [var_post.dup(), rt.new_string('WP_Post')])))) && rt.is_true(rt.call_function('has_shortcode', [rt.get_property(var_post, 'post_content'), rt.new_string(tag)]))
}

fn wc_reviews_enabled() rt.PhpVal {
	return rt.identical(rt.new_string('yes'), rt.call_function('get_option', []))
}

fn wc_review_ratings_enabled() bool {
	return 
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

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_cartcheckoututils() &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_query() &Class_WC_Query {
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




pub fn init_wp_content_plugins_woocommerce_includes_wc_conditional_functions_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('is_shop')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('is_product_taxonomy')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('is_product_category')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('is_product_tag')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('is_product')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('is_cart')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('is_checkout')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('is_checkout_pay_page')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('is_wc_endpoint_url')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('is_account_page')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('is_view_order_page')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('is_edit_account_page')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('is_order_received_page')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('is_payment_methods_page')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('is_add_payment_method_page')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('is_lost_password_page')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('is_wc_admin_settings_page')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('is_ajax')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('is_store_notice_showing')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('is_filtered')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('taxonomy_is_product_attribute')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('meta_is_product_attribute')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_tax_enabled')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_shipping_enabled')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_prices_include_tax')]))))) {
	}
}
