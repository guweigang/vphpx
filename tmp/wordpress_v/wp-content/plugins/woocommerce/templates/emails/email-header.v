import rt

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_featuresutil() &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
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




pub fn init_wp_content_plugins_woocommerce_templates_emails_email_header_php() {
	mut var_email_heading := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
	mut var_email_improvements_enabled := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('email_improvements'))
	mut var_store_name := if !(var_store_name).is_null() { var_store_name } else { rt.call_function('get_bloginfo', [rt.new_string('name'), rt.new_string('display')]) }
	mut var_header_image_url := rt.call_function('apply_filters', [rt.new_string('woocommerce_email_header_image_url'), rt.call_function('home_url', []rt.PhpVal{})])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('language_attributes', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo', [rt.new_string('charset')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_store_name.dup()]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { 'rightmargin' } else { 'leftmargin' })
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { 'rtl' } else { 'ltr' })
	// unsupported statement: Stmt_InlineHTML
	mut var_img := rt.call_function('get_option', [rt.new_string('woocommerce_email_header_image')])
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_is_email_preview'), rt.new_bool(false)])) {
		mut var_img_transient := rt.call_function('get_transient', [rt.new_string('woocommerce_email_header_image')])
		var_img = if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_img_transient } else { var_img }
	}
	if rt.is_true(var_email_improvements_enabled) {
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_img) {
			mut var_image_html := rt.new_string('<img src="' + (rt.call_function('esc_url', [var_img.dup()])).str() + '" alt="' + (rt.call_function('esc_attr', [var_store_name.dup()])).str() + '" />')
			if rt.is_true(var_header_image_url) {
				print('<p style="margin-top:0;"><a href="' + (rt.call_function('esc_url', [var_header_image_url.dup()])).str() + '" style="display: inline-block; text-decoration: none;" target="_blank">' + (var_image_html).str() + '</a></p>')
			} else {
				print('<p style="margin-top:0;">' + (var_image_html).str() + '</p>')
			}
		} else if rt.is_true(var_header_image_url) {
			print('<p class="email-logo-text"><a href="' + (rt.call_function('esc_url', [var_header_image_url.dup()])).str() + '" style="color: inherit; text-decoration: none;" target="_blank">' + (rt.call_function('esc_html', [var_store_name.dup()])).str() + '</a></p>')
		} else {
			print('<p class="email-logo-text">' + (rt.call_function('esc_html', [var_store_name.dup()])).str() + '</p>')
		}
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_img) {
			var_image_html = rt.new_string('<img src="' + (rt.call_function('esc_url', [var_img.dup()])).str() + '" alt="' + (rt.call_function('esc_attr', [var_store_name.dup()])).str() + '" />')
			if rt.is_true(var_header_image_url) {
				print('<p style="margin-top:0;"><a href="' + (rt.call_function('esc_url', [var_header_image_url.dup()])).str() + '" style="display: inline-block; text-decoration: none;" target="_blank">' + (var_image_html).str() + '</a></p>')
			} else {
				print('<p style="margin-top:0;">' + (var_image_html).str() + '</p>')
			}
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_email_heading.dup()]))
	// unsupported statement: Stmt_InlineHTML
}
