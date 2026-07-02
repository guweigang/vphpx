import rt

struct Class_WC_Helper {
	rt.PhpObjectBase
}

fn create_wc_helper(_args ...rt.PhpVal) &Class_WC_Helper {
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

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_subscriptions := rt.new_null()
	mut var_no_subscriptions := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_0 := Class_WC_Helper{}
	mut iife_result_0 := iife_temp_0.get_view_filename(rt.new_string('html-section-nav.php'))
	rt.include_file(iife_result_0.to_string(), '3')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('WooCommerce Extensions'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_1 := Class_WC_Helper{}
	mut iife_result_1 := iife_temp_1.get_view_filename(rt.new_string('html-section-notices.php'))
	rt.include_file(iife_result_1.to_string(), '3')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Subscriptions'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_2 := Class_WC_Helper{}
	mut iife_result_2 := iife_temp_2.get_view_filename(rt.new_string('html-section-account.php'))
	rt.include_file(iife_result_2.to_string(), '3')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('wp_kses', [
			rt.call_function('__', [
				rt.new_string('Below is a list of extensions available on your WooCommerce.com account. To receive extension updates please make sure the extension is installed, and its subscription activated and connected to your WooCommerce.com account. Extensions can be activated from the <a href="%s">Plugins</a> screen.'),
				rt.new_string('woocommerce'),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'a', val: rt.create_array([
					rt.ArrayItem{ key: 'href', val: rt.new_array() },
				]) },
			]),
		]),
		rt.call_function('esc_url', [
			rt.call_function('admin_url', [
				rt.new_string('plugins.php'),
			]),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Sort by:'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_3 := Class_WC_Helper{}
	mut iife_result_3 := iife_temp_3.get_filters()
	mut var_filters := rt.func_array_keys(iife_result_3)
	mut var_last_filter := rt.call_function('array_pop', [var_filters.clone()])
	mut iife_temp_4 := Class_WC_Helper{}
	mut iife_result_4 := iife_temp_4.get_current_filter()
	mut var_current_filter := iife_result_4
	mut iife_temp_5 := Class_WC_Helper{}
	mut iife_result_5 := iife_temp_5.get_filters_counts()
	mut var_counts := iife_result_5
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_6 := Class_WC_Helper{}
	mut iife_result_6 := iife_temp_6.get_filters()
	mut iter_1 := iife_result_6.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_label := item_1.val
		mut var_key := item_1.key
		if !rt.is_true(var_counts.array_get(var_key)) {
			continue
		}
		mut var_url := rt.call_function('admin_url', [
			rt.new_string('admin.php?page=wc-addons&section=helper&filter=' + var_key.str()),
		])
		mut var_class_html := if rt.is_true(rt.identical(var_current_filter, var_key)) {
			'class="current"'
		} else {
			''
		}
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_InlineHTML
		print(var_class_html)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_url.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_label.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('absint', [var_counts.array_get(var_key)]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_subscriptions)) {
		// unsupported statement: Stmt_InlineHTML
		mut iter_2 := var_subscriptions.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_subscription := item_2.val
			// unsupported statement: Stmt_InlineHTML
			mut iife_temp_7 := Class_WC_Helper{}
			mut iife_result_7 := iife_temp_7.add_utm_params_to_url_for_subscription_link(var_subscription.array_get(rt.new_string('product_url')),
				rt.new_string('product-name'))
			mut iife_temp_8 := Class_WC_Helper{}
			mut iife_result_8 := iife_temp_8.add_utm_params_to_url_for_subscription_link(var_subscription.array_get(rt.new_string('product_url')),
				rt.new_string('product-name'))
			rt.echo_val(rt.call_function('esc_url', [iife_result_7]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				var_subscription.array_get(rt.new_string('product_name')),
			]))
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(var_subscription.array_get(rt.new_string('lifetime'))) {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [rt.new_string('Lifetime Subscription'),
					rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(var_subscription.array_get(rt.new_string('expired'))) {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [rt.new_string('Expired :('),
					rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [
					rt.call_function('date_i18n', [rt.new_string('F jS, Y'),
						var_subscription.array_get(rt.new_string('expires'))]),
				]))
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(var_subscription.array_get(rt.new_string('autorenew'))) {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [rt.new_string('Auto renews on:'),
					rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [
					rt.call_function('date_i18n', [rt.new_string('F jS, Y'),
						var_subscription.array_get(rt.new_string('expires'))]),
				]))
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(var_subscription.array_get(rt.new_string('expiring'))) {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [rt.new_string('Expiring soon!'),
					rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [
					rt.call_function('date_i18n', [rt.new_string('F jS, Y'),
						var_subscription.array_get(rt.new_string('expires'))]),
				]))
				// unsupported statement: Stmt_InlineHTML
			} else {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [rt.new_string('Expires on:'),
					rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [
					rt.call_function('date_i18n', [rt.new_string('F jS, Y'),
						var_subscription.array_get(rt.new_string('expires'))]),
				]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.new_bool(!(rt.is_true(var_subscription.array_get(rt.new_string('active'))))))
				&& rt.is_true(var_subscription.array_get(rt.new_string('maxed'))) {
				rt.call_function('printf', [
					rt.call_function('esc_html__', [
						rt.new_string('Subscription: Not available - %1$d of %2$d already in use'),
						rt.new_string('woocommerce'),
					]),
					rt.call_function('absint', [
						var_subscription.array_get(rt.new_string('sites_active')),
					]),
					rt.call_function('absint', [
						var_subscription.array_get(rt.new_string('sites_max')),
					]),
				])
			} else if rt.is_true(rt.greater(var_subscription.array_get(rt.new_string('sites_max')),
				rt.new_int(0)))
			{
				rt.call_function('printf', [
					rt.call_function('esc_html__', [
						rt.new_string('Subscription: Using %1$d of %2$d sites available'),
						rt.new_string('woocommerce'),
					]),
					rt.call_function('absint', [
						var_subscription.array_get(rt.new_string('sites_active')),
					]),
					rt.call_function('absint', [
						var_subscription.array_get(rt.new_string('sites_max')),
					]),
				])
			} else {
				rt.call_function('esc_html_e', [rt.new_string('Subscription: Unlimited'),
					rt.new_string('woocommerce')])
			}
			if !(!rt.is_true(var_subscription.array_get(rt.new_string('is_shared'))))
				&& !(!rt.is_true(var_subscription.array_get(rt.new_string('owner_email')))) {
				rt.call_function('printf', [
					rt.new_string('</br>' +(rt.call_function('esc_html__', [rt.new_string('Shared by %s'), rt.new_string('woocommerce')])).str()),
					rt.call_function('esc_html', [
						var_subscription.array_get(rt.new_string('owner_email')),
					]),
				])
			} else if var_subscription.array_isset(rt.new_string('master_user_email')) {
				rt.call_function('printf', [
					rt.new_string('</br>' +(rt.call_function('esc_html__', [rt.new_string('Shared by %s'), rt.new_string('woocommerce')])).str()),
					rt.call_function('esc_html', [
						var_subscription.array_get(rt.new_string('master_user_email')),
					]),
				])
			}
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.new_bool(!(rt.is_true(var_subscription.array_get(rt.new_string('active'))))))
				&& rt.is_true(var_subscription.array_get(rt.new_string('maxed'))) {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [rt.new_string('Upgrade'),
					rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
			} else if
				rt.is_true(rt.new_bool(!(rt.is_true(var_subscription.array_get(rt.new_string('local')).array_get(rt.new_string('installed'))))))
				&& rt.is_true(rt.new_bool(!(rt.is_true(var_subscription.array_get(rt.new_string('expired')))))) {
				// unsupported statement: Stmt_InlineHTML
				print(if !rt.is_true(var_subscription.array_get(rt.new_string('download_primary'))) {
					'button-secondary'
				} else {
					''
				})
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_url', [
					var_subscription.array_get(rt.new_string('download_url')),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [rt.new_string('Download'),
					rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(var_subscription.array_get(rt.new_string('active'))) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_url', [
					var_subscription.array_get(rt.new_string('deactivate_url')),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [rt.new_string('Active'),
					rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [rt.new_string('Active'),
					rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(rt.new_bool(!(rt.is_true(var_subscription.array_get(rt.new_string('expired')))))) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_url', [
					var_subscription.array_get(rt.new_string('activate_url')),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [rt.new_string('Inactive'),
					rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [rt.new_string('Inactive'),
					rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
			} else {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [rt.new_string('Inactive'),
					rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [rt.new_string('Inactive'),
					rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			mut iter_3 := var_subscription.array_get(rt.new_string('actions')).iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_subscription_action := item_3.val
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('sanitize_html_class', [
					var_subscription_action.array_get(rt.new_string('status')),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('sanitize_html_class', [
					var_subscription_action.array_get(rt.new_string('icon')),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('wp_kses_post', [
					var_subscription_action.array_get(rt.new_string('message')),
				]))
				// unsupported statement: Stmt_InlineHTML
				if !(!rt.is_true(var_subscription_action.array_get(rt.new_string('button_label'))))
					&& !(!rt.is_true(var_subscription_action.array_get(rt.new_string('button_url')))) {
					// unsupported statement: Stmt_InlineHTML
					print(if !rt.is_true(var_subscription_action.array_get(rt.new_string('primary'))) {
						'button-secondary'
					} else {
						''
					})
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_url', [
						var_subscription_action.array_get(rt.new_string('button_url')),
					]))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_html', [
						var_subscription_action.array_get(rt.new_string('button_label')),
					]))
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Could not find any subscriptions on your WooCommerce.com account'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_no_subscriptions)) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Installed Extensions without a Subscription'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_InlineHTML
		mut iter_4 := var_no_subscriptions.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_data := item_4.val
			mut var_filename := item_4.key
			// unsupported statement: Stmt_InlineHTML
			mut iife_temp_9 := Class_WC_Helper{}
			mut iife_result_9 := iife_temp_9.add_utm_params_to_url_for_subscription_link(var_data.array_get(rt.new_string('_product_url')),
				rt.new_string('product-name'))
			mut iife_temp_10 := Class_WC_Helper{}
			mut iife_result_10 := iife_temp_10.add_utm_params_to_url_for_subscription_link(var_data.array_get(rt.new_string('_product_url')),
				rt.new_string('product-name'))
			rt.echo_val(rt.call_function('esc_url', [iife_result_9]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				var_data.array_get(rt.new_string('Name')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Inactive'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Inactive'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			mut iter_5 := var_data.array_get(rt.new_string('_actions')).iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_subscription_action := item_5.val
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('sanitize_html_class', [
					var_subscription_action.array_get(rt.new_string('status')),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('sanitize_html_class', [
					var_subscription_action.array_get(rt.new_string('icon')),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('wp_kses', [
					var_subscription_action.array_get(rt.new_string('message')),
					rt.create_array([
						rt.ArrayItem{ key: 'a', val: rt.create_array([
							rt.ArrayItem{ key: 'href', val: rt.new_array() },
							rt.ArrayItem{ key: 'title', val: rt.new_array() },
						]) },
						rt.ArrayItem{ key: 'br', val: rt.new_array() },
						rt.ArrayItem{ key: 'em', val: rt.new_array() },
						rt.ArrayItem{ key: 'strong', val: rt.new_array() },
					]),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_url', [
					var_subscription_action.array_get(rt.new_string('button_url')),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [
					var_subscription_action.array_get(rt.new_string('button_label')),
				]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
