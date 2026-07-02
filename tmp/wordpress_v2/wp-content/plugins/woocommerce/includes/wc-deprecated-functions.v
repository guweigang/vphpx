import rt

fn wc_do_deprecated_action(var_tag rt.PhpVal, var_args rt.PhpVal, var_version rt.PhpVal, var_replacement rt.PhpVal, var_message rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_action', [
		var_tag.clone()])))))
	{
		return
	}
	wc_deprecated_hook(var_tag.clone(), var_version.clone(), var_replacement.clone(),
		var_message.clone())
	rt.call_function('do_action_ref_array', [var_tag.clone(),
		var_args.clone()])
}

fn wc_deprecated_function(var_function rt.PhpVal, version string, var_replacement rt.PhpVal) {
	mut var_version := version
	mut var_log_string := ''
	if rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{}))
		|| rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_rest_api_request', []rt.PhpVal{})) {
		rt.call_function('do_action', [rt.new_string('deprecated_function_run'),
			var_function.clone(), var_replacement.clone(), rt.new_string(version)])
		var_log_string = 'The ${var_function.to_string()} function is deprecated since version ${var_version}.'
		var_log_string = var_log_string +
			if rt.is_true(var_replacement) { ' Replace with ${var_replacement.to_string()}.' } else { '' }
		rt.call_function('error_log', [rt.new_string(var_log_string.str()).clone()])
	} else {
		rt.call_function('_deprecated_function', [var_function.clone(),
			rt.new_string(version), var_replacement.clone()])
	}
}

fn wc_deprecated_hook(var_hook rt.PhpVal, var_version rt.PhpVal, var_replacement rt.PhpVal, var_message_arg rt.PhpVal) {
	mut var_message := var_message_arg
	mut var_log_string := ''
	if rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{}))
		|| rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_rest_api_request', []rt.PhpVal{})) {
		rt.call_function('do_action', [rt.new_string('deprecated_hook_run'),
			var_hook.clone(), var_replacement.clone(), var_version.clone(),
			var_message.clone()])
		var_message = rt.new_string((if !rt.is_true(var_message) {
			''
		} else {
			' ' + var_message.str()
		}).str())
		var_log_string = '${var_hook.to_string()} is deprecated since version ${var_version.to_string()}'
		var_log_string = var_log_string +
			if rt.is_true(var_replacement) { '! Use ${var_replacement.to_string()} instead.' } else { ' with no alternative available.' }
		rt.call_function('error_log', [
			rt.new_string(var_log_string + var_message.str()),
		])
	} else {
		rt.call_function('_deprecated_hook', [var_hook.clone(),
			var_version.clone(), var_replacement.clone(), var_message.clone()])
	}
}

fn wc_caught_exception(var_exception_object rt.PhpVal, function string, var_args rt.PhpVal) {
	mut var_function := function
	mut var_message := rt.new_null()
	var_message = rt.call_method(var_exception_object, 'getMessage', []rt.PhpVal{})
	var_message = rt.concat(var_message, rt.new_string('. Args: ' +
		(println(var_args.clone().to_string())).str() + '.'))
	rt.call_function('do_action', [rt.new_string('woocommerce_caught_exception'),
		var_exception_object.clone(), rt.new_string(function),
		var_args.clone()])
	rt.call_function('error_log', [
		rt.new_string('Exception caught in ${var_function}. ${var_message.to_string()}.'),
	])
}

fn wc_doing_it_wrong(function string, message string, version string) {
	mut var_function := function
	mut var_message := message
	mut var_version := version
	message = message + ' Backtrace: ' +
		(rt.call_function('wp_debug_backtrace_summary', []rt.PhpVal{})).str()
	if rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{}))
		|| rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_rest_api_request', []rt.PhpVal{})) {
		rt.call_function('do_action', [rt.new_string('doing_it_wrong_run'),
			rt.new_string(function), rt.new_string(message), rt.new_string(version)])
		rt.call_function('error_log', [
			rt.new_string('${var_function} was called incorrectly. ${var_message}. This message was added in version ${var_version}.'),
		])
	} else {
		rt.call_function('_doing_it_wrong', [rt.new_string(function),
			rt.new_string(message), rt.new_string(version)])
	}
}

fn wc_deprecated_argument(var_argument rt.PhpVal, var_version rt.PhpVal, var_message rt.PhpVal) {
	if rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{}))
		|| rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_rest_api_request', []rt.PhpVal{})) {
		rt.call_function('do_action', [rt.new_string('deprecated_argument_run'),
			var_argument.clone(), var_message.clone(), var_version.clone()])
		rt.call_function('error_log', [
			rt.new_string('The ${var_argument.to_string()} argument is deprecated since version ${var_version.to_string()}. ${var_message.to_string()}'),
		])
	} else {
		rt.call_function('_deprecated_argument', [var_argument.clone(),
			var_version.clone(), var_message.clone()])
	}
}

fn woocommerce_show_messages() {
	wc_deprecated_function(rt.new_string('woocommerce_show_messages'), '2.1',
		rt.new_string('wc_print_notices'))
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
	mut var_option := option
	mut var_page_title := page_title
	mut var_page_content := page_content
	mut var_post_parent := post_parent
	wc_deprecated_function(rt.new_string('woocommerce_create_page'), '2.1',
		rt.new_string('wc_create_page'))
	return rt.call_function('wc_create_page', [var_slug.clone(),
		rt.new_string(option), rt.new_string(page_title), rt.new_string(page_content),
		rt.new_int(post_parent)])
}

fn woocommerce_readfile_chunked(var_file rt.PhpVal, retbytes bool) rt.PhpVal {
	mut var_retbytes := retbytes
	wc_deprecated_function(rt.new_string('woocommerce_readfile_chunked'), '2.1',
		rt.new_string('WC_Download_Handler::readfile_chunked()'))
	mut iife_temp_0 := Class_WC_Download_Handler{}
	mut iife_result_0 := iife_temp_0.readfile_chunked(var_file.clone())
	return iife_result_0
}

fn woocommerce_format_total(var_number rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '2.1', rt.new_string('wc_format_decimal()'))
	return rt.call_function('wc_format_decimal', [var_number.clone(),
		rt.call_function('wc_get_price_decimals', []rt.PhpVal{}),
		rt.new_bool(false)])
}

fn woocommerce_get_formatted_product_name(var_product rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '2.1',
		rt.new_string('WC_Product::get_formatted_name()'))
	return rt.call_method(var_product, 'get_formatted_name', []rt.PhpVal{})
}

fn woocommerce_legacy_paypal_ipn() {
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('paypalListener'))))
		&& rt.is_true(rt.identical(rt.new_string('paypal_standard_IPN'), rt.get_superglobal('_GET').array_get(rt.new_string('paypalListener')))) {
		rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})
		rt.call_function('do_action', [
			rt.new_string('woocommerce_api_wc_gateway_paypal'),
		])
	}
}

fn get_product(the_product bool, var_args rt.PhpVal) rt.PhpVal {
	mut var_the_product := the_product
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_get_product'))
	return rt.call_function('wc_get_product', [rt.new_bool(the_product),
		var_args.clone()])
}

fn woocommerce_protected_product_add_to_cart(var_passed rt.PhpVal, var_product_id rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0',
		rt.new_string('wc_protected_product_add_to_cart'))
	return rt.call_function('wc_protected_product_add_to_cart', [
		var_passed.clone(), var_product_id.clone()])
}

fn woocommerce_empty_cart() {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_empty_cart'))
	rt.call_function('wc_empty_cart', []rt.PhpVal{})
}

fn woocommerce_load_persistent_cart(var_user_login rt.PhpVal, user i64) {
	mut var_user := user
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_load_persistent_cart'))
	wc_load_persistent_cart(var_user_login.clone(), rt.new_int(user))
}

fn woocommerce_add_to_cart_message(var_product_id rt.PhpVal) {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_add_to_cart_message'))
	rt.call_function('wc_add_to_cart_message', [var_product_id.clone()])
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
	rt.call_function('wc_cart_totals_coupon_html', [var_coupon.clone()])
}

fn woocommerce_cart_totals_order_total_html() {
	wc_deprecated_function(rt.new_string(@FN), '3.0',
		rt.new_string('wc_cart_totals_order_total_html'))
	rt.call_function('wc_cart_totals_order_total_html', []rt.PhpVal{})
}

fn woocommerce_cart_totals_fee_html(var_fee rt.PhpVal) {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_cart_totals_fee_html'))
	rt.call_function('wc_cart_totals_fee_html', [var_fee.clone()])
}

fn woocommerce_cart_totals_shipping_method_label(var_method rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0',
		rt.new_string('wc_cart_totals_shipping_method_label'))
	return rt.call_function('wc_cart_totals_shipping_method_label', [
		var_method.clone()])
}

fn woocommerce_get_template_part(var_slug rt.PhpVal, name string) {
	mut var_name := name
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_get_template_part'))
	rt.call_function('wc_get_template_part', [var_slug.clone(),
		rt.new_string(name)])
}

fn woocommerce_get_template(var_template_name rt.PhpVal, var_args rt.PhpVal, template_path string, default_path string) {
	mut var_template_path := template_path
	mut var_default_path := default_path
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_get_template'))
	rt.call_function('wc_get_template', [var_template_name.clone(),
		var_args.clone(), rt.new_string(template_path), rt.new_string(default_path)])
}

fn woocommerce_locate_template(var_template_name rt.PhpVal, template_path string, default_path string) rt.PhpVal {
	mut var_template_path := template_path
	mut var_default_path := default_path
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_locate_template'))
	return rt.call_function('wc_locate_template', [var_template_name.clone(),
		rt.new_string(template_path), rt.new_string(default_path)])
}

fn woocommerce_mail(var_to rt.PhpVal, var_subject rt.PhpVal, var_message rt.PhpVal, headers string, attachments string) {
	mut var_headers := headers
	mut var_attachments := attachments
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_mail'))
	rt.call_function('wc_mail', [var_to.clone(), var_subject.clone(),
		var_message.clone(), rt.new_string(headers), rt.new_string(attachments)])
}

fn woocommerce_disable_admin_bar(var_show_admin_bar rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_disable_admin_bar'))
	return rt.call_function('wc_disable_admin_bar', [var_show_admin_bar.clone()])
}

fn woocommerce_create_new_customer(var_email rt.PhpVal, username string, password string) rt.PhpVal {
	mut var_username := username
	mut var_password := password
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_create_new_customer'))
	return rt.call_function('wc_create_new_customer', [var_email.clone(),
		rt.new_string(username), rt.new_string(password)])
}

fn woocommerce_set_customer_auth_cookie(var_customer_id rt.PhpVal) {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_set_customer_auth_cookie'))
	rt.call_function('wc_set_customer_auth_cookie', [var_customer_id.clone()])
}

fn woocommerce_update_new_customer_past_orders(var_customer_id rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0',
		rt.new_string('wc_update_new_customer_past_orders'))
	return rt.call_function('wc_update_new_customer_past_orders', [
		var_customer_id.clone()])
}

fn woocommerce_paying_customer(var_order_id rt.PhpVal) {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_paying_customer'))
	rt.call_function('wc_paying_customer', [var_order_id.clone()])
}

fn woocommerce_customer_bought_product(var_customer_email rt.PhpVal, var_user_id rt.PhpVal, var_product_id rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_customer_bought_product'))
	return rt.call_function('wc_customer_bought_product', [var_customer_email.clone(),
		var_user_id.clone(), var_product_id.clone()])
}

fn woocommerce_customer_has_capability(var_allcaps rt.PhpVal, var_caps rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_customer_has_capability'))
	return rt.call_function('wc_customer_has_capability', [var_allcaps.clone(),
		var_caps.clone(), var_args.clone()])
}

fn woocommerce_sanitize_taxonomy_name(var_taxonomy rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_sanitize_taxonomy_name'))
	return rt.call_function('wc_sanitize_taxonomy_name', [var_taxonomy.clone()])
}

fn woocommerce_get_filename_from_url(var_file_url rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_get_filename_from_url'))
	return rt.call_function('wc_get_filename_from_url', [var_file_url.clone()])
}

fn woocommerce_get_dimension(var_dim rt.PhpVal, var_to_unit rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_get_dimension'))
	return rt.call_function('wc_get_dimension', [var_dim.clone(),
		var_to_unit.clone()])
}

fn woocommerce_get_weight(var_weight rt.PhpVal, var_to_unit rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_get_weight'))
	return rt.call_function('wc_get_weight', [var_weight.clone(),
		var_to_unit.clone()])
}

fn woocommerce_trim_zeros(var_price rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_trim_zeros'))
	return rt.call_function('wc_trim_zeros', [var_price.clone()])
}

fn woocommerce_round_tax_total(var_tax rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_round_tax_total'))
	return rt.call_function('wc_round_tax_total', [var_tax.clone()])
}

fn woocommerce_format_decimal(var_number rt.PhpVal, dp bool, trim_zeros bool) rt.PhpVal {
	mut var_dp := dp
	mut var_trim_zeros := trim_zeros
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_format_decimal'))
	return rt.call_function('wc_format_decimal', [var_number.clone(),
		rt.new_bool(dp), rt.new_bool(trim_zeros)])
}

fn woocommerce_clean(var_var rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_clean'))
	return rt.call_function('wc_clean', [var_var.clone()])
}

fn woocommerce_array_overlay(var_a1 rt.PhpVal, var_a2 rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_array_overlay'))
	return rt.call_function('wc_array_overlay', [var_a1.clone(),
		var_a2.clone()])
}

fn woocommerce_price(var_price rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_price'))
	return rt.call_function('wc_price', [var_price.clone(), var_args.clone()])
}

fn woocommerce_let_to_num(var_size rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_let_to_num'))
	return rt.call_function('wc_let_to_num', [var_size.clone()])
}

fn woocommerce_date_format() rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_date_format'))
	return rt.call_function('wc_date_format', []rt.PhpVal{})
}

fn woocommerce_time_format() rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_time_format'))
	return rt.call_function('wc_time_format', []rt.PhpVal{})
}

fn woocommerce_timezone_string() rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_timezone_string'))
	return rt.call_function('wc_timezone_string', []rt.PhpVal{})
}

fn woocommerce_rgb_from_hex(var_color rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_rgb_from_hex'))
	return rt.call_function('wc_rgb_from_hex', [var_color.clone()])
}

fn woocommerce_hex_darker(var_color rt.PhpVal, factor i64) rt.PhpVal {
	mut var_factor := factor
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_hex_darker'))
	return rt.call_function('wc_hex_darker', [var_color.clone(),
		rt.new_int(factor)])
}

fn woocommerce_hex_lighter(var_color rt.PhpVal, factor i64) rt.PhpVal {
	mut var_factor := factor
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_hex_lighter'))
	return rt.call_function('wc_hex_lighter', [var_color.clone(),
		rt.new_int(factor)])
}

fn woocommerce_light_or_dark(var_color rt.PhpVal, dark string, light string) rt.PhpVal {
	mut var_dark := dark
	mut var_light := light
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_light_or_dark'))
	return rt.call_function('wc_light_or_dark', [var_color.clone(),
		rt.new_string(dark), rt.new_string(light)])
}

fn woocommerce_format_hex(var_hex rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_format_hex'))
	return rt.call_function('wc_format_hex', [var_hex.clone()])
}

fn woocommerce_get_order_id_by_order_key(var_order_key rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_get_order_id_by_order_key'))
	return rt.call_function('wc_get_order_id_by_order_key', [
		var_order_key.clone()])
}

fn woocommerce_downloadable_file_permission(var_download_id rt.PhpVal, var_product_id rt.PhpVal, var_order rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0',
		rt.new_string('wc_downloadable_file_permission'))
	return rt.call_function('wc_downloadable_file_permission', [
		var_download_id.clone(), var_product_id.clone(), var_order.clone()])
}

fn woocommerce_downloadable_product_permissions(var_order_id rt.PhpVal) {
	wc_deprecated_function(rt.new_string(@FN), '3.0',
		rt.new_string('wc_downloadable_product_permissions'))
	rt.call_function('wc_downloadable_product_permissions', [
		var_order_id.clone()])
}

fn woocommerce_add_order_item(var_order_id rt.PhpVal, var_item rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_add_order_item'))
	return rt.call_function('wc_add_order_item', [var_order_id.clone(),
		var_item.clone()])
}

fn woocommerce_delete_order_item(var_item_id rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_delete_order_item'))
	return rt.call_function('wc_delete_order_item', [var_item_id.clone()])
}

fn woocommerce_update_order_item_meta(var_item_id rt.PhpVal, var_meta_key rt.PhpVal, var_meta_value rt.PhpVal, prev_value string) rt.PhpVal {
	mut var_prev_value := prev_value
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_update_order_item_meta'))
	return rt.call_function('wc_update_order_item_meta', [var_item_id.clone(),
		var_meta_key.clone(), var_meta_value.clone(), rt.new_string(prev_value)])
}

fn woocommerce_add_order_item_meta(var_item_id rt.PhpVal, var_meta_key rt.PhpVal, var_meta_value rt.PhpVal, unique bool) rt.PhpVal {
	mut var_unique := unique
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_add_order_item_meta'))
	return rt.call_function('wc_add_order_item_meta', [var_item_id.clone(),
		var_meta_key.clone(), var_meta_value.clone(), rt.new_bool(unique)])
}

fn woocommerce_delete_order_item_meta(var_item_id rt.PhpVal, var_meta_key rt.PhpVal, meta_value string, delete_all bool) rt.PhpVal {
	mut var_meta_value := meta_value
	mut var_delete_all := delete_all
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_delete_order_item_meta'))
	return rt.call_function('wc_delete_order_item_meta', [var_item_id.clone(),
		var_meta_key.clone(), rt.new_string(meta_value), rt.new_bool(delete_all)])
}

fn woocommerce_get_order_item_meta(var_item_id rt.PhpVal, var_key rt.PhpVal, single bool) rt.PhpVal {
	mut var_single := single
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_get_order_item_meta'))
	return rt.call_function('wc_get_order_item_meta', [var_item_id.clone(),
		var_key.clone(), rt.new_bool(single)])
}

fn woocommerce_cancel_unpaid_orders() {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_cancel_unpaid_orders'))
	rt.call_function('wc_cancel_unpaid_orders', []rt.PhpVal{})
}

fn woocommerce_processing_order_count() rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_processing_order_count'))
	return rt.call_function('wc_processing_order_count', []rt.PhpVal{})
}

fn woocommerce_get_page_id(var_page rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_get_page_id'))
	return rt.call_function('wc_get_page_id', [var_page.clone()])
}

fn woocommerce_get_endpoint_url(var_endpoint rt.PhpVal, value string, permalink string) rt.PhpVal {
	mut var_value := value
	mut var_permalink := permalink
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_get_endpoint_url'))
	return rt.call_function('wc_get_endpoint_url', [var_endpoint.clone(),
		rt.new_string(value), rt.new_string(permalink)])
}

fn woocommerce_lostpassword_url(var_url rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_lostpassword_url'))
	return rt.call_function('wc_lostpassword_url', [var_url.clone()])
}

fn woocommerce_customer_edit_account_url() rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_customer_edit_account_url'))
	return rt.call_function('wc_customer_edit_account_url', []rt.PhpVal{})
}

fn woocommerce_nav_menu_items(var_items rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_nav_menu_items'))
	return rt.call_function('wc_nav_menu_items', [var_items.clone()])
}

fn woocommerce_nav_menu_item_classes(var_menu_items rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_nav_menu_item_classes'))
	return rt.call_function('wc_nav_menu_item_classes', [var_menu_items.clone()])
}

fn woocommerce_list_pages(var_pages rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_list_pages'))
	return rt.call_function('wc_list_pages', [var_pages.clone()])
}

fn woocommerce_product_dropdown_categories(var_args rt.PhpVal, deprecated_hierarchical i64, deprecated_show_uncategorized i64, deprecated_orderby string) rt.PhpVal {
	mut var_deprecated_hierarchical := deprecated_hierarchical
	mut var_deprecated_show_uncategorized := deprecated_show_uncategorized
	mut var_deprecated_orderby := deprecated_orderby
	wc_deprecated_function(rt.new_string(@FN), '3.0',
		rt.new_string('wc_product_dropdown_categories'))
	return rt.call_function('wc_product_dropdown_categories', [
		var_args.clone(), rt.new_int(deprecated_hierarchical),
		rt.new_int(deprecated_show_uncategorized), rt.new_string(deprecated_orderby)])
}

fn woocommerce_walk_category_dropdown_tree(a1 string, a2 string, a3 string) rt.PhpVal {
	mut var_a1 := a1
	mut var_a2 := a2
	mut var_a3 := a3
	wc_deprecated_function(rt.new_string(@FN), '3.0',
		rt.new_string('wc_walk_category_dropdown_tree'))
	return rt.call_function('wc_walk_category_dropdown_tree', [
		rt.new_string(a1), rt.new_string(a2), rt.new_string(a3)])
}

fn woocommerce_taxonomy_metadata_wpdbfix() {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_null())
}

fn wc_taxonomy_metadata_wpdbfix() {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_null())
}

fn woocommerce_order_terms(var_the_term rt.PhpVal, var_next_id rt.PhpVal, var_taxonomy rt.PhpVal, index i64, var_terms rt.PhpVal) rt.PhpVal {
	mut var_index := index
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_reorder_terms'))
	return rt.call_function('wc_reorder_terms', [var_the_term.clone(),
		var_next_id.clone(), var_taxonomy.clone(), rt.new_int(index),
		var_terms.clone()])
}

fn woocommerce_set_term_order(var_term_id rt.PhpVal, var_index rt.PhpVal, var_taxonomy rt.PhpVal, recursive bool) rt.PhpVal {
	mut var_recursive := recursive
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_set_term_order'))
	return rt.call_function('wc_set_term_order', [var_term_id.clone(),
		var_index.clone(), var_taxonomy.clone(), rt.new_bool(recursive)])
}

fn woocommerce_terms_clauses(var_clauses rt.PhpVal, var_taxonomies rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_terms_clauses'))
	return rt.call_function('wc_terms_clauses', [var_clauses.clone(),
		var_taxonomies.clone(), var_args.clone()])
}

fn _woocommerce_term_recount(var_terms rt.PhpVal, var_taxonomy rt.PhpVal, var_callback rt.PhpVal, var_terms_are_term_taxonomy_ids rt.PhpVal) {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('_wc_term_recount'))
	rt.call_function('_wc_term_recount', [var_terms.clone(), var_taxonomy.clone(),
		var_callback.clone(), var_terms_are_term_taxonomy_ids.clone()])
}

fn woocommerce_recount_after_stock_change(var_product_id rt.PhpVal) {
	wc_deprecated_function(rt.new_string(@FN), '3.0',
		rt.new_string('wc_recount_after_stock_change'))
	rt.call_function('wc_recount_after_stock_change', [var_product_id.clone()])
}

fn woocommerce_change_term_counts(var_terms rt.PhpVal, var_taxonomies rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_change_term_counts'))
	return rt.call_function('wc_change_term_counts', [var_terms.clone(),
		var_taxonomies.clone()])
}

fn woocommerce_get_product_ids_on_sale() rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_get_product_ids_on_sale'))
	return rt.call_function('wc_get_product_ids_on_sale', []rt.PhpVal{})
}

fn woocommerce_get_featured_product_ids() rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_get_featured_product_ids'))
	return rt.call_function('wc_get_featured_product_ids', []rt.PhpVal{})
}

fn woocommerce_get_product_terms(var_object_id rt.PhpVal, var_taxonomy rt.PhpVal, fields string) rt.PhpVal {
	mut var_fields := fields
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_get_product_terms'))
	return rt.call_function('wc_get_product_terms', [var_object_id.clone(),
		var_taxonomy.clone(), rt.create_array([rt.ArrayItem{ key: 'fields', val: fields }])])
}

fn woocommerce_product_post_type_link(var_permalink rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_product_post_type_link'))
	return rt.call_function('wc_product_post_type_link', [var_permalink.clone(),
		var_post.clone()])
}

fn woocommerce_placeholder_img_src() rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_placeholder_img_src'))
	return rt.call_function('wc_placeholder_img_src', []rt.PhpVal{})
}

fn woocommerce_placeholder_img(size string) rt.PhpVal {
	mut var_size := size
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_placeholder_img'))
	return rt.call_function('wc_placeholder_img', [rt.new_string(size)])
}

fn woocommerce_get_formatted_variation(variation string, flat bool) rt.PhpVal {
	mut var_variation := variation
	mut var_flat := flat
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_get_formatted_variation'))
	return rt.call_function('wc_get_formatted_variation', [rt.new_string(variation),
		rt.new_bool(flat)])
}

fn woocommerce_scheduled_sales() {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_scheduled_sales'))
	rt.call_function('wc_scheduled_sales', []rt.PhpVal{})
}

fn woocommerce_get_attachment_image_attributes(var_attr rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0',
		rt.new_string('wc_get_attachment_image_attributes'))
	return rt.call_function('wc_get_attachment_image_attributes', [
		var_attr.clone()])
}

fn woocommerce_prepare_attachment_for_js(var_response rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_prepare_attachment_for_js'))
	return rt.call_function('wc_prepare_attachment_for_js', [
		var_response.clone()])
}

fn woocommerce_track_product_view() {
	wc_deprecated_function(rt.new_string(@FN), '3.0', rt.new_string('wc_track_product_view'))
	rt.call_function('wc_track_product_view', []rt.PhpVal{})
}

fn woocommerce_compile_less_styles() {
	wc_deprecated_function(rt.new_string('woocommerce_compile_less_styles'), '2.3', rt.new_null())
}

fn woocommerce_calc_shipping_backwards_compatibility(var_value rt.PhpVal) string {
	mut iife_temp_1 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_1 := iife_temp_1.is_defined(rt.new_string('WC_UPDATING'))
	if rt.is_true(iife_result_1) {
		return var_value.str()
	}
	return if rt.is_true(rt.identical(rt.new_string('disabled'), rt.call_function('get_option', [
		rt.new_string('woocommerce_ship_to_countries'),
	])))
	{ 'no' } else { 'yes' }
}

fn woocommerce_get_product_schema() string {
	mut var_product := rt.new_null()
	mut var_schema := ''
	wc_deprecated_function(rt.new_string('woocommerce_get_product_schema'), '3.0', rt.new_null())
	var_schema = 'Product'
	if rt.is_true(rt.call_method(var_product, 'is_downloadable', []rt.PhpVal{})) {
		mut switch_val_1 := rt.get_property(var_product, 'download_type')
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('application'))) {
			var_schema = 'SoftwareApplication'
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('music'))) {
			var_schema = 'MusicAlbum'
		} else {
			var_schema = 'Product'
		}
	}
	return 'http://schema.org/' + var_schema
}

fn _wc_save_product_price(var_product_id_arg rt.PhpVal, var_regular_price_arg rt.PhpVal, sale_price string, date_from string, date_to string) {
	mut var_sale_price := sale_price
	mut var_date_from := date_from
	mut var_date_to := date_to
	mut var_product_id := var_product_id_arg
	mut var_regular_price := var_regular_price_arg
	wc_doing_it_wrong('_wc_save_product_price()',
		'This function is not for developer use and is deprecated.', '3.0')
	var_product_id = rt.call_function('absint', [var_product_id.clone()])
	var_regular_price = rt.call_function('wc_format_decimal', [
		var_regular_price.clone()])
	var_sale_price = (if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(var_sale_price.str()))) { rt.new_string('') } else { rt.call_function('wc_format_decimal', [
			rt.new_string(var_sale_price.str()),
		]) }).str()
	var_date_from = (rt.call_function('wc_clean', [rt.new_string(var_date_from.str())])).str()
	var_date_to = (rt.call_function('wc_clean', [rt.new_string(var_date_to.str())])).str()
	rt.call_function('update_post_meta', [var_product_id.clone(),
		rt.new_string('_regular_price'), var_regular_price.clone()])
	rt.call_function('update_post_meta', [var_product_id.clone(),
		rt.new_string('_sale_price'), rt.new_string(var_sale_price.str())])
	rt.call_function('update_post_meta', [var_product_id.clone(),
		rt.new_string('_sale_price_dates_from'), if var_date_from.len > 0 && var_date_from != '0' { rt.call_function('strtotime', [
				rt.new_string(var_date_from.str()),
			]) } else { rt.new_string('') }])
	rt.call_function('update_post_meta', [var_product_id.clone(),
		rt.new_string('_sale_price_dates_to'), if var_date_to.len > 0 && var_date_to != '0' { rt.call_function('strtotime', [
				rt.new_string(var_date_to.str()),
			]) } else { rt.new_string('') }])
	if var_date_to.len > 0 && var_date_to != '0' && !(var_date_from.len > 0 && var_date_from != '0') {
		var_date_from = (rt.call_function('strtotime', [rt.new_string('NOW'),
			rt.call_function('current_time', [rt.new_string('timestamp')])])).str()
		rt.call_function('update_post_meta', [var_product_id.clone(),
			rt.new_string('_sale_price_dates_from'), rt.new_string(var_date_from.str())])
	}
	if rt.is_true(rt.new_bool('' != var_sale_price))
		&& rt.is_true(rt.identical(rt.new_string(''), rt.new_string(var_date_to.str())))
		&& rt.is_true(rt.identical(rt.new_string(''), rt.new_string(var_date_from.str()))) {
		rt.call_function('update_post_meta', [var_product_id.clone(),
			rt.new_string('_price'), rt.new_string(var_sale_price.str())])
	} else {
		rt.call_function('update_post_meta', [var_product_id.clone(),
			rt.new_string('_price'), var_regular_price.clone()])
	}
	if rt.is_true(rt.new_bool('' != var_sale_price)) && var_date_from.len > 0
		&& var_date_from != '0'
		&& rt.is_true(rt.less(rt.call_function('strtotime', [rt.new_string(var_date_from.str())]), rt.call_function('strtotime', [rt.new_string('NOW'), rt.call_function('current_time', [rt.new_string('timestamp')])]))) {
		rt.call_function('update_post_meta', [var_product_id.clone(),
			rt.new_string('_price'), rt.new_string(var_sale_price.str())])
	}
	if var_date_to.len > 0 && var_date_to != '0'
		&& rt.is_true(rt.less(rt.call_function('strtotime', [rt.new_string(var_date_to.str())]), rt.call_function('strtotime', [rt.new_string('NOW'), rt.call_function('current_time', [rt.new_string('timestamp')])]))) {
		rt.call_function('update_post_meta', [var_product_id.clone(),
			rt.new_string('_price'), var_regular_price.clone()])
		rt.call_function('update_post_meta', [var_product_id.clone(),
			rt.new_string('_sale_price_dates_from'), rt.new_string('')])
		rt.call_function('update_post_meta', [var_product_id.clone(),
			rt.new_string('_sale_price_dates_to'), rt.new_string('')])
	}
}

fn wc_get_customer_avatar_url(var_email rt.PhpVal) rt.PhpVal {
	wc_deprecated_function(rt.new_string('wc_get_customer_avatar_url()'), '3.1',
		rt.new_string('get_avatar_url()'))
	return rt.call_function('get_avatar_url', [var_email.clone()])
}

fn wc_get_core_supported_themes() rt.PhpVal {
	wc_deprecated_function(rt.new_string('wc_get_core_supported_themes()'), '3.3', rt.new_null())
	return rt.create_array([rt.ArrayItem{ key: none, val: 'twentyseventeen' },
		rt.ArrayItem{ key: none, val: 'twentysixteen' }, rt.ArrayItem{
			key: none
			val: 'twentyfifteen'
		}, rt.ArrayItem{ key: none, val: 'twentyfourteen' }, rt.ArrayItem{
			key: none
			val: 'twentythirteen'
		}, rt.ArrayItem{ key: none, val: 'twentyeleven' }, rt.ArrayItem{
			key: none
			val: 'twentytwelve'
		}, rt.ArrayItem{ key: none, val: 'twentyten' }])
}

fn wc_get_min_max_price_meta_query(var_args rt.PhpVal) rt.PhpVal {
	mut var_current_min_price := rt.new_null()
	mut var_current_max_price := rt.new_null()
	wc_deprecated_function(rt.new_string('wc_get_min_max_price_meta_query()'), '3.6', rt.new_null())
	var_current_min_price = if var_args.array_isset(rt.new_string('min_price')) {
		rt.new_float(var_args.array_get(rt.new_string('min_price')).to_f64())
	} else {
		rt.new_int(0)
	}
	var_current_max_price = if var_args.array_isset(rt.new_string('max_price')) {
		rt.new_float(var_args.array_get(rt.new_string('max_price')).to_f64())
	} else {
		rt.get_constant('PHP_INT_MAX')
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_min_max_price_meta_query'),
		rt.create_array([rt.ArrayItem{ key: 'key', val: '_price' },
			rt.ArrayItem{ key: 'value', val: rt.create_array([
				rt.ArrayItem{ key: none, val: var_current_min_price },
				rt.ArrayItem{ key: none, val: var_current_max_price },
			]) }, rt.ArrayItem{ key: 'compare', val: 'BETWEEN' },
			rt.ArrayItem{ key: 'type', val: 'DECIMAL(10,' +
				(rt.call_function('wc_get_price_decimals', []rt.PhpVal{})).str() + ')' }]),
		var_args.clone(),
	])
}

fn wc_taxonomy_metadata_update_content_for_split_terms(var_old_term_id rt.PhpVal, var_new_term_id rt.PhpVal, var_term_taxonomy_id rt.PhpVal, var_taxonomy rt.PhpVal) {
	wc_deprecated_function(rt.new_string('wc_taxonomy_metadata_update_content_for_split_terms'),
		'3.6', rt.new_null())
}

fn update_woocommerce_term_meta(var_term_id rt.PhpVal, var_meta_key rt.PhpVal, var_meta_value rt.PhpVal, prev_value string) rt.PhpVal {
	mut var_prev_value := prev_value
	wc_deprecated_function(rt.new_string('update_woocommerce_term_meta'), '3.6',
		rt.new_string('update_term_meta'))
	return if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('update_term_meta'),
	]))
	{ rt.call_function('update_term_meta', [var_term_id.clone(),
			var_meta_key.clone(), var_meta_value.clone(), rt.new_string(prev_value)]) } else { rt.call_function('update_metadata', [
			rt.new_string('woocommerce_term'),
			var_term_id.clone(),
			var_meta_key.clone(),
			var_meta_value.clone(),
			rt.new_string(prev_value),
		]) }
}

fn add_woocommerce_term_meta(var_term_id rt.PhpVal, var_meta_key rt.PhpVal, var_meta_value rt.PhpVal, unique bool) rt.PhpVal {
	mut var_unique := unique
	wc_deprecated_function(rt.new_string('add_woocommerce_term_meta'), '3.6',
		rt.new_string('add_term_meta'))
	return if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('add_term_meta'),
	]))
	{ rt.call_function('add_term_meta', [var_term_id.clone(),
			var_meta_key.clone(), var_meta_value.clone(), rt.new_bool(unique)]) } else { rt.call_function('add_metadata', [
			rt.new_string('woocommerce_term'),
			var_term_id.clone(),
			var_meta_key.clone(),
			var_meta_value.clone(),
			rt.new_bool(unique),
		]) }
}

fn delete_woocommerce_term_meta(var_term_id rt.PhpVal, var_meta_key rt.PhpVal, meta_value string, deprecated bool) rt.PhpVal {
	mut var_meta_value := meta_value
	mut var_deprecated := deprecated
	wc_deprecated_function(rt.new_string('delete_woocommerce_term_meta'), '3.6',
		rt.new_string('delete_term_meta'))
	return if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('delete_term_meta'),
	]))
	{ rt.call_function('delete_term_meta', [var_term_id.clone(),
			var_meta_key.clone(), rt.new_string(meta_value)]) } else { rt.call_function('delete_metadata', [
			rt.new_string('woocommerce_term'),
			var_term_id.clone(),
			var_meta_key.clone(),
			rt.new_string(meta_value),
		]) }
}

fn get_woocommerce_term_meta(var_term_id rt.PhpVal, var_key rt.PhpVal, single bool) rt.PhpVal {
	mut var_single := single
	wc_deprecated_function(rt.new_string('get_woocommerce_term_meta'), '3.6',
		rt.new_string('get_term_meta'))
	return if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('get_term_meta'),
	]))
	{ rt.call_function('get_term_meta', [var_term_id.clone(),
			var_key.clone(), rt.new_bool(single)]) } else { rt.call_function('get_metadata', [
			rt.new_string('woocommerce_term'),
			var_term_id.clone(),
			var_key.clone(),
			rt.new_bool(single),
		]) }
}

fn wc_register_default_log_handler(var_handlers rt.PhpVal) rt.PhpVal {
	mut var_default_handler := rt.new_null()
	wc_deprecated_function(rt.new_string('wc_register_default_log_handler'), '8.6.0', rt.new_null())
	var_default_handler = rt.call_method(rt.call_method(rt.call_function('wc_get_container',
		[]rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings.class(),
	]), 'get_default_handler', []rt.PhpVal{})
	var_handlers.clone().array_push(rt.create_object_dynamically(var_default_handler, []rt.PhpVal{}))
	return var_handlers.clone()
}

fn wc_get_log_file_path(var_handle rt.PhpVal) string {
	mut var_directory := rt.new_null()
	mut var_file_id := rt.new_null()
	mut var_hash := rt.new_null()
	wc_deprecated_function(rt.new_string('wc_get_log_file_path'), '8.6.0', rt.new_null())
	mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_LoggingUtil{}
	mut iife_result_2 := iife_temp_2.get_log_directory()
	var_directory = iife_result_2
	mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_LoggingUtil{}
	mut iife_result_3 := iife_temp_3.generate_log_file_id(var_handle.clone(), rt.new_null(), rt.call_function('time',
		[]rt.PhpVal{}))
	var_file_id = iife_result_3
	mut iife_temp_4 := Class_Automattic_WooCommerce_Utilities_LoggingUtil{}
	mut iife_result_4 := iife_temp_4.generate_log_file_hash(var_file_id.clone())
	var_hash = iife_result_4
	return '${var_directory.to_string()}${var_file_id.to_string()}-${var_hash.to_string()}.log'
}

fn wc_get_log_file_name(var_handle rt.PhpVal) string {
	mut var_file_id := rt.new_null()
	mut var_hash := rt.new_null()
	wc_deprecated_function(rt.new_string('wc_get_log_file_name'), '8.6.0', rt.new_null())
	mut iife_temp_5 := Class_Automattic_WooCommerce_Utilities_LoggingUtil{}
	mut iife_result_5 := iife_temp_5.generate_log_file_id(var_handle.clone(), rt.new_null(), rt.call_function('time',
		[]rt.PhpVal{}))
	var_file_id = iife_result_5
	mut iife_temp_6 := Class_Automattic_WooCommerce_Utilities_LoggingUtil{}
	mut iife_result_6 := iife_temp_6.generate_log_file_hash(var_file_id.clone())
	var_hash = iife_result_6
	return '${var_file_id.to_string()}-${var_hash.to_string()}'
}

fn wc_load_persistent_cart(var_user_login rt.PhpVal, var_user rt.PhpVal) {
	mut var_saved_cart := rt.new_null()
	mut var_cart := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_persistent_cart_enabled'), rt.new_bool(true)]))))) {
		return
	}
	var_saved_cart = rt.call_function('get_user_meta', [rt.get_property(var_user, 'ID'),
		rt.new_string('_woocommerce_persistent_cart_' +
			(rt.call_function('get_current_blog_id', []rt.PhpVal{})).str()),
		rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_saved_cart)))) {
		return
	}
	var_cart = rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'),
		'cart')
	if !rt.is_true(var_cart) || !(var_cart.clone().is_array())
		|| 0 == var_cart.clone().array_count() {
		rt.set_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'cart',
			var_saved_cart.array_get(rt.new_string('cart')))
	}
}

fn woocommerce_product_subcategories(var_args_arg rt.PhpVal) bool {
	mut var_args := var_args_arg
	mut var_wp_query := rt.new_null()
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_display_type := rt.new_null()
	var_defaults = {
		'before':        rt.new_string('')
		'after':         rt.new_string('')
		'force_display': rt.new_bool(false)
	}
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array_from_native_map(var_defaults)])
	if rt.is_true(var_args.array_get(rt.new_string('force_display'))) {
		rt.call_function('woocommerce_output_product_categories', [
			rt.create_array([
				rt.ArrayItem{ key: 'before', val: var_args.array_get(rt.new_string('before')) },
				rt.ArrayItem{ key: 'after', val: var_args.array_get(rt.new_string('after')) },
				rt.ArrayItem{
					key: 'parent_id'
					val: if rt.is_true(rt.call_function('is_product_category', []rt.PhpVal{})) {
						rt.call_function('get_queried_object_id', []rt.PhpVal{})
					} else {
						rt.new_int(0)
					}
				},
			]),
		])
		return true
	} else {
		var_display_type = rt.call_function('woocommerce_get_loop_display_mode', []rt.PhpVal{})
		if rt.is_true(rt.identical(rt.new_string('subcategories'), var_display_type)) {
			if rt.is_true(rt.call_method(var_wp_query, 'is_main_query', []rt.PhpVal{})) {
				rt.set_property(var_wp_query, 'post_count', rt.new_int(0))
				rt.set_property(var_wp_query, 'max_num_pages', rt.new_int(0))
			}
		}
		return rt.is_true(rt.identical(rt.new_string('subcategories'), var_display_type))
			|| rt.is_true(rt.identical(rt.new_string('both'), var_display_type))
	}
	return false
}

fn wc_products_rss_feed() {
	wc_deprecated_function(rt.new_string('wc_products_rss_feed'), '2.6', rt.new_null())
}

fn woocommerce_reset_loop() {
	rt.call_function('wc_reset_loop', []rt.PhpVal{})
}

fn woocommerce_product_reviews_tab() {
	wc_deprecated_function(rt.new_string('woocommerce_product_reviews_tab'), '2.4', rt.new_null())
}

fn get_woocommerce_api_url(var_path rt.PhpVal) rt.PhpVal {
	mut var_url := rt.new_null()
	var_url = rt.call_function('get_home_url', [rt.new_null(),
		rt.new_string('wc-api/v3/'),
		rt.new_string((if rt.is_true(rt.call_function('is_ssl',
			[]rt.PhpVal{}))
		{
			'https'
		} else {
			'http'
		}).str())])
	if !(!rt.is_true(var_path)) && var_path.clone().is_string() {
		var_url = rt.concat(var_url,
			rt.new_string(var_path.clone().to_string().trim_left(' \t\n\r')))
	}
	return var_url.clone()
}

struct Class_WC_Download_Handler {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_LoggingUtil {
	rt.PhpObjectBase
}

fn create_wc_download_handler(_args ...rt.PhpVal) &Class_WC_Download_Handler {
	mut obj := &Class_WC_Download_Handler{
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

fn create_automattic_woocommerce_utilities_loggingutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_LoggingUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_LoggingUtil{
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

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_LoggingUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_LoggingUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_LoggingUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('WC_Download_Handler', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_download_handler()
		return rt.new_object('WC_Download_Handler', []string{}, obj)
	})
	rt.register_class_factory('Automattic_Jetpack_Constants', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_jetpack_constants()
		return rt.new_object('Automattic_Jetpack_Constants', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Utilities_LoggingUtil', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_utilities_loggingutil()
		return rt.new_object('Automattic_WooCommerce_Utilities_LoggingUtil', []string{}, obj)
	})
}

fn init() {
	init_registry()
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
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('woocommerce_legacy_paypal_ipn')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('woocommerce_rgb_from_hex'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('woocommerce_hex_darker'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('woocommerce_hex_lighter'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('woocommerce_light_or_dark'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('woocommerce_format_hex'),
	])))))
	{
	}
	rt.call_function('add_filter', [
		rt.new_string('pre_option_woocommerce_calc_shipping'),
		rt.new_string('woocommerce_calc_shipping_backwards_compatibility'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('woocommerce_product_subcategories'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('woocommerce_reset_loop'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('woocommerce_product_reviews_tab'),
	])))))
	{
	}
}
