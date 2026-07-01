import rt

struct Class_WC_Helper {
	rt.PhpObjectBase
}

fn create_wc_helper() &Class_WC_Helper {
	mut obj := &Class_WC_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_helper_views_html_main_php() {
	mut var_subscriptions := rt.new_null()
	mut var_no_subscriptions := rt.new_null()
	// unsupported statement: Stmt_Nop
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_view_filename(arg_0) }(rt.new_string('html-section-nav.php'))).to_string(), '3')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('WooCommerce Extensions'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_view_filename(arg_0) }(rt.new_string('html-section-notices.php'))).to_string(), '3')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Subscriptions'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_view_filename(arg_0) }(rt.new_string('html-section-account.php'))).to_string(), '3')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('wp_kses', [rt.call_function('__', [rt.new_string('Below is a list of extensions available on your WooCommerce.com account. To receive extension updates please make sure the extension is installed, and its subscription activated and connected to your WooCommerce.com account. Extensions can be activated from the <a href="%s">Plugins</a> screen.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'a', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.new_array() }]) }])]), rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('plugins.php')])])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Sort by:'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_filters := rt.func_array_keys(fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_filters() }())
	mut var_last_filter := rt.call_function('array_pop', [var_filters.dup()])
	mut var_current_filter := fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_current_filter() }()
	mut var_counts := fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_filters_counts() }()
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_filters() }().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_label := item_1.val
			mut var_key := item_1.key
			if !rt.is_true(var_counts.array_get(var_key)) {
				continue
			}
			mut var_url := rt.call_function('admin_url', ['admin.php?page=wc-addons&section=helper&filter=' + (var_key).str()])
			mut var_class_html := if rt.is_true(rt.identical(var_current_filter, var_key)) { 'class="current"' } else { '' }
			// unsupported statement: Stmt_InlineHTML
			// unsupported statement: Stmt_Nop
			// unsupported statement: Stmt_InlineHTML
			print(var_class_html)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [var_url.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_label.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('absint', [var_counts.array_get(var_key)]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_subscriptions)) {
		// unsupported statement: Stmt_InlineHTML
		{
			mut iter_1 := var_subscriptions.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_subscription := item_1.val
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_url', [fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.add_utm_params_to_url_for_subscription_link(arg_0, arg_1) }(var_subscription.array_get('product_url'), rt.new_string('product-name'))]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [var_subscription.array_get('product_name')]))
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(var_subscription.array_get('lifetime')) {
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('esc_html_e', [rt.new_string('Lifetime Subscription'), rt.new_string('woocommerce')])
					// unsupported statement: Stmt_InlineHTML
				} else if rt.is_true(var_subscription.array_get('expired')) {
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('esc_html_e', [rt.new_string('Expired :('), rt.new_string('woocommerce')])
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_html', [rt.call_function('date_i18n', [rt.new_string('F jS, Y'), var_subscription.array_get('expires')])]))
					// unsupported statement: Stmt_InlineHTML
				} else if rt.is_true(var_subscription.array_get('autorenew')) {
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('esc_html_e', [rt.new_string('Auto renews on:'), rt.new_string('woocommerce')])
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_html', [rt.call_function('date_i18n', [rt.new_string('F jS, Y'), var_subscription.array_get('expires')])]))
					// unsupported statement: Stmt_InlineHTML
				} else if rt.is_true(var_subscription.array_get('expiring')) {
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('esc_html_e', [rt.new_string('Expiring soon!'), rt.new_string('woocommerce')])
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_html', [rt.call_function('date_i18n', [rt.new_string('F jS, Y'), var_subscription.array_get('expires')])]))
					// unsupported statement: Stmt_InlineHTML
				} else {
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('esc_html_e', [rt.new_string('Expires on:'), rt.new_string('woocommerce')])
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_html', [rt.call_function('date_i18n', [rt.new_string('F jS, Y'), var_subscription.array_get('expires')])]))
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_subscription.array_get('active'))))) && rt.is_true(var_subscription.array_get('maxed')))) {
					rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('Subscription: Not available - %1$d of %2$d already in use'), rt.new_string('woocommerce')]), rt.call_function('absint', [var_subscription.array_get('sites_active')]), rt.call_function('absint', [var_subscription.array_get('sites_max')])])
				} else if rt.is_true(rt.greater(var_subscription.array_get('sites_max'), rt.new_int(0))) {
					rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('Subscription: Using %1$d of %2$d sites available'), rt.new_string('woocommerce')]), rt.call_function('absint', [var_subscription.array_get('sites_active')]), rt.call_function('absint', [var_subscription.array_get('sites_max')])])
				} else {
					rt.call_function('esc_html_e', [rt.new_string('Subscription: Unlimited'), rt.new_string('woocommerce')])
				}
				if !(!rt.is_true(var_subscription.array_get('is_shared'))) && !(!rt.is_true(var_subscription.array_get('owner_email'))) {
					rt.call_function('printf', ['</br>' + (rt.call_function('esc_html__', [rt.new_string('Shared by %s'), rt.new_string('woocommerce')])).str(), rt.call_function('esc_html', [var_subscription.array_get('owner_email')])])
				} else if var_subscription.array_isset(rt.new_string('master_user_email')) {
					rt.call_function('printf', ['</br>' + (rt.call_function('esc_html__', [rt.new_string('Shared by %s'), rt.new_string('woocommerce')])).str(), rt.call_function('esc_html', [var_subscription.array_get('master_user_email')])])
				}
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_subscription.array_get('active'))))) && rt.is_true(var_subscription.array_get('maxed')))) {
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('esc_html_e', [rt.new_string('Upgrade'), rt.new_string('woocommerce')])
					// unsupported statement: Stmt_InlineHTML
				} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_subscription.array_get('local').array_get('installed'))))) && rt.is_true(rt.new_bool(!(rt.is_true(var_subscription.array_get('expired'))))))) {
					// unsupported statement: Stmt_InlineHTML
					print(if !rt.is_true(var_subscription.array_get('download_primary')) { 'button-secondary' } else { '' })
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_url', [var_subscription.array_get('download_url')]))
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('esc_html_e', [rt.new_string('Download'), rt.new_string('woocommerce')])
					// unsupported statement: Stmt_InlineHTML
				} else if rt.is_true(var_subscription.array_get('active')) {
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_url', [var_subscription.array_get('deactivate_url')]))
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('esc_html_e', [rt.new_string('Active'), rt.new_string('woocommerce')])
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('esc_html_e', [rt.new_string('Active'), rt.new_string('woocommerce')])
					// unsupported statement: Stmt_InlineHTML
				} else if rt.is_true(rt.new_bool(!(rt.is_true(var_subscription.array_get('expired'))))) {
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_url', [var_subscription.array_get('activate_url')]))
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('esc_html_e', [rt.new_string('Inactive'), rt.new_string('woocommerce')])
					// unsupported statement: Stmt_InlineHTML
					
				} else {
				}
				// unsupported statement: Stmt_InlineHTML
			}
		}
	} else {
	}
	// unsupported statement: Stmt_InlineHTML
}
