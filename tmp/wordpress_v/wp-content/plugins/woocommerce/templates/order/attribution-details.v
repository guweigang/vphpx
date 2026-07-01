import rt

struct Class_WC_Marketplace_Suggestions {
	rt.PhpObjectBase
}

fn create_wc_marketplace_suggestions() &Class_WC_Marketplace_Suggestions {
	mut obj := &Class_WC_Marketplace_Suggestions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Marketplace_Suggestions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Marketplace_Suggestions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Marketplace_Suggestions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_templates_order_attribution_details_php() {
	mut var_meta := map[string]rt.PhpVal{}
	mut var_has_more_details := rt.new_null()
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(var_meta.dup().array_isset(rt.new_string('origin')))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Origin'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(var_meta.dup().array_isset(rt.new_string('origin')))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_meta.array_get('origin')]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_has_more_details) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Show details'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Hide details'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(var_meta.dup().array_isset(rt.new_string('source_type')))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Source type'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_meta.array_get('source_type')]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(var_meta.dup().array_isset(rt.new_string('utm_campaign')))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Campaign'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_meta.array_get('utm_campaign')]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(var_meta.dup().array_isset(rt.new_string('utm_source')))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Source'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_meta.array_get('utm_source')]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(var_meta.dup().array_isset(rt.new_string('utm_medium')))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Medium'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_meta.array_get('utm_medium')]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(var_meta.dup().array_isset(rt.new_string('utm_source_platform')))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Source platform'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_meta.array_get('utm_source_platform')]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(var_meta.dup().array_isset(rt.new_string('utm_creative_format')))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Creative format'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_meta.array_get('utm_creative_format')]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(var_meta.dup().array_isset(rt.new_string('utm_marketing_tactic')))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Marketing tactic'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_meta.array_get('utm_marketing_tactic')]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(var_meta.dup().array_isset(rt.new_string('utm_content')))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Content'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_meta.array_get('utm_content')]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(var_meta.dup().array_isset(rt.new_string('utm_term')))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Term'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_meta.array_get('utm_term')]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(var_meta.dup().array_isset(rt.new_string('utm_id')))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('ID'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_meta.array_get('utm_id')]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(var_meta.dup().array_isset(rt.new_string('device_type')))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Device type'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_meta.array_get('device_type')]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(var_meta.dup().array_isset(rt.new_string('session_pages')))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Session page views'), rt.new_string('woocommerce')])
		rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('wc_help_tip', [rt.call_function('__', [rt.new_string('The number of unique pages viewed by the customer prior to this order.'), rt.new_string('woocommerce')])])]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_meta.array_get('session_pages')]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Marketplace_Suggestions')])) && rt.is_true(fn () rt.PhpVal { mut temp := Class_WC_Marketplace_Suggestions{}; return temp.allow_suggestions() }()))) {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
