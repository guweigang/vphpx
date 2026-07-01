import rt

fn wc_do_deprecated_action(var_tag rt.PhpVal, var_args rt.PhpVal, var_version rt.PhpVal, var_replacement rt.PhpVal, var_message rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_action', [var_tag.dup()]))))) {
		return rt.new_null()
	}
	wc_deprecated_hook(var_tag.dup(), var_version.dup(), var_replacement.dup(), var_message.dup())
	rt.call_function('do_action_ref_array', [var_tag.dup(), var_args.dup()])
}

fn wc_deprecated_function(var_function rt.PhpVal, version string, var_replacement rt.PhpVal) {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{})) || rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_rest_api_request', []rt.PhpVal{})))) {
		rt.call_function('do_action', [rt.new_string('deprecated_function_run'), var_function.dup(), var_replacement.dup(), rt.new_string(version)])
		mut var_log_string := "The ${var_function.to_string()} function is deprecated since version ${var_version}."
		// unsupported expression: Expr_AssignOp_Concat
		rt.call_function('error_log', [rt.new_string(var_log_string).dup()])
	} else {
		rt.call_function('_deprecated_function', [var_function.dup(), rt.new_string(version), var_replacement.dup()])
	}
	// unsupported statement: Stmt_Nop
}

fn wc_deprecated_hook(var_hook rt.PhpVal, var_version rt.PhpVal, var_replacement rt.PhpVal, var_message rt.PhpVal) {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{})) || rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_rest_api_request', []rt.PhpVal{})))) {
		rt.call_function('do_action', [rt.new_string('deprecated_hook_run'), var_hook.dup(), var_replacement.dup(), var_version.dup(), var_message.dup()])
		var_message = rt.new_string(if !rt.is_true(var_message) { rt.new_string('') } else { ' ' + (var_message).str() })
		mut var_log_string := "${var_hook.to_string()} is deprecated since version ${var_version.to_string()}"
		// unsupported expression: Expr_AssignOp_Concat
		rt.call_function('error_log', [var_log_string + (var_message).str()])
	} else {
		rt.call_function('_deprecated_hook', [var_hook.dup(), var_version.dup(), var_replacement.dup(), var_message.dup()])
	}
	// unsupported statement: Stmt_Nop
}

fn wc_caught_exception(var_exception_object rt.PhpVal, function string, var_args rt.PhpVal) {
	mut var_message := rt.call_method(var_exception_object, 'getMessage', []rt.PhpVal{})
	// unsupported expression: Expr_AssignOp_Concat
	rt.call_function('do_action', [rt.new_string('woocommerce_caught_exception'), var_exception_object.dup(), rt.new_string(function), var_args.dup()])
	rt.call_function('error_log', [rt.new_string("Exception caught in ${var_function}. ${var_message.to_string()}.")])
	// unsupported statement: Stmt_Nop
}

fn wc_doing_it_wrong(function string, message string, version string) {
	// unsupported expression: Expr_AssignOp_Concat
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{})) || rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_rest_api_request', []rt.PhpVal{})))) {
		rt.call_function('do_action', [rt.new_string('doing_it_wrong_run'), rt.new_string(function), rt.new_string(message), rt.new_string(version)])
		rt.call_function('error_log', [rt.new_string("${var_function} was called incorrectly. ${var_message}. This message was added in version ${var_version}.")])
	} else {
		rt.call_function('_doing_it_wrong', [rt.new_string(function), rt.new_string(message), rt.new_string(version)])
	}
	// unsupported statement: Stmt_Nop
}

fn wc_deprecated_argument(var_argument rt.PhpVal, var_version rt.PhpVal, var_message rt.PhpVal) {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{})) || rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_rest_api_request', []rt.PhpVal{})))) {
		rt.call_function('do_action', [rt.new_string('deprecated_argument_run'), var_argument.dup(), var_message.dup(), var_version.dup()])
		rt.call_function('error_log', [rt.new_string("The ${var_argument.to_string()} argument is deprecated since version ${var_version.to_string()}. ${var_message.to_string()}")])
	} else {
		rt.call_function('_deprecated_argument', [var_argument.dup(), var_version.dup(), var_message.dup()])
	}
}

fn woocommerce_show_messages() {
	wc_deprecated_function(rt.new_string('woocommerce_show_messages'), '2.1', rt.new_string('wc_print_notices'))
	rt.call_function('wc_print_notices', []rt.PhpVal{})
}

fn woocommerce_weekend_area_js() {
	wc_deprecated_function(rt.new_string('woocommerce_weekend_area_js'), '2.1', rt.new_null())
}

fn woocommerce_tooltip_js() {
	wc_deprecated_function(rt.new_string('woocommerce_tooltip_js'), '2.1', rt.new_null())
}

fn woocommerce_datepicker_js() {
	wc_deprecated_function(rt.new_string('woocommerce_datepicker_js'), '2.1', rt.new_null())
}

fn woocommerce_admin_scripts() {
	wc_deprecated_function(rt.new_string('woocommerce_admin_scripts'), '2.1', rt.new_null())
}

fn woocommerce_create_page(var_slug rt.PhpVal, option string, page_title string, page_content string, post_parent i64) rt.PhpVal {
	wc_deprecated_function(rt.new_string('woocommerce_create_page'), '2.1', rt.new_string('wc_create_page'))
	return rt.call_function('wc_create_page', [var_slug.dup(), rt.new_string(option), rt.new_string(page_title), rt.new_string(page_content), rt.new_int(post_parent)])
}

fn woocommerce_readfile_chunked(var_file rt.PhpVal, retbytes bool) rt.PhpVal {
	wc_deprecated_function(rt.new_string('woocommerce_readfile_chunked'), '2.1', rt.new_string('WC_Download_Handler::readfile_chunked()'))
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Download_Handler{}; return temp.readfile_chunked(arg_0) }(var_file.dup())
}

fn woocommerce_format_total(var_number rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '2.1', rt.new_string('wc_format_decimal()'))
	return rt.call_function('wc_format_decimal', [var_number.dup(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{}), rt.new_bool(false)])
}

fn woocommerce_get_formatted_product_name(var_product rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '2.1', rt.new_string('WC_Product::get_formatted_name()'))
	return rt.call_method(var_product, 'get_formatted_name', []rt.PhpVal{})
}

fn woocommerce_legacy_paypal_ipn() {
	if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_GET').array_get('paypalListener'))) && rt.is_true(rt.identical(rt.new_string('paypal_standard_IPN'), rt.get_superglobal('_GET').array_get('paypalListener'))))) {
		rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})
		rt.call_function('do_action', [rt.new_string('woocommerce_api_wc_gateway_paypal')])
	}
}

fn get_product(the_product bool, var_args rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_get_product'))
	return rt.call_function('wc_get_product', [rt.new_bool(the_product), var_args.dup()])
}

fn woocommerce_protected_product_add_to_cart(var_passed rt.PhpVal, var_product_id rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_protected_product_add_to_cart'))
	return rt.call_function('wc_protected_product_add_to_cart', [var_passed.dup(), var_product_id.dup()])
}

fn woocommerce_empty_cart() {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_empty_cart'))
	rt.call_function('wc_empty_cart', []rt.PhpVal{})
}

fn woocommerce_load_persistent_cart(var_user_login rt.PhpVal, user i64) {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_load_persistent_cart'))
	wc_load_persistent_cart(var_user_login.dup(), rt.new_int(user))
}

fn woocommerce_add_to_cart_message(var_product_id rt.PhpVal) {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_add_to_cart_message'))
	rt.call_function('wc_add_to_cart_message', [var_product_id.dup()])
}

fn woocommerce_clear_cart_after_payment() {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_clear_cart_after_payment'))
	rt.call_function('wc_clear_cart_after_payment', []rt.PhpVal{})
}

fn woocommerce_cart_totals_subtotal_html() {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_cart_totals_subtotal_html'))
	rt.call_function('wc_cart_totals_subtotal_html', []rt.PhpVal{})
}

fn woocommerce_cart_totals_shipping_html() {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_cart_totals_shipping_html'))
	rt.call_function('wc_cart_totals_shipping_html', []rt.PhpVal{})
}

fn woocommerce_cart_totals_coupon_html(var_coupon rt.PhpVal) {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_cart_totals_coupon_html'))
	rt.call_function('wc_cart_totals_coupon_html', [var_coupon.dup()])
}

fn woocommerce_cart_totals_order_total_html() {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_cart_totals_order_total_html'))
	rt.call_function('wc_cart_totals_order_total_html', []rt.PhpVal{})
}

fn woocommerce_cart_totals_fee_html(var_fee rt.PhpVal) {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_cart_totals_fee_html'))
	rt.call_function('wc_cart_totals_fee_html', [.dup()])
}

fn woocommerce_cart_totals_shipping_method_label(var_method rt.PhpVal) rt.PhpVal {
}

struct Class_WC_Download_Handler {
	rt.PhpObjectBase
}

fn create_wc_download_handler() &Class_WC_Download_Handler {
	mut obj := &Class_WC_Download_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Download_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Download_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Download_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('WC_Download_Handler', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_download_handler()
		return rt.new_object('WC_Download_Handler', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_wc_deprecated_functions_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('woocommerce_legacy_paypal_ipn')])
}
