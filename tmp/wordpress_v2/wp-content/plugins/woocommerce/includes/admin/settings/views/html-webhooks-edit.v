import rt

struct Class_DateTime {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Webhooks {
	rt.PhpObjectBase
}

fn create_datetime(_args ...rt.PhpVal) &Class_DateTime {
	mut obj := &Class_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_webhooks(_args ...rt.PhpVal) &Class_WC_Admin_Webhooks {
	mut obj := &Class_WC_Admin_Webhooks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Admin_Webhooks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Webhooks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Webhooks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_webhook := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_webhook, 'get_id', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Webhook data'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Name'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Friendly name for identifying this webhook, defaults to Webhook created on %s.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_method(create_datetime(rt.new_string('now')), 'format', [
				rt.call_function('_x', [rt.new_string('M d, Y @ h:i A'),
					rt.new_string('Webhook created on date parsed by DateTime::format'),
					rt.new_string('woocommerce')]),
			]),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_webhook, 'get_name', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Status'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('__', [
			rt.new_string('The options are &quot;Active&quot; (delivers payload), &quot;Paused&quot; (does not deliver), or &quot;Disabled&quot; (does not deliver due delivery failures).'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	mut var_statuses := rt.call_function('wc_get_webhook_statuses', []rt.PhpVal{})
	mut var_current_status := rt.call_method(var_webhook, 'get_status', []rt.PhpVal{})
	mut iter_1 := var_statuses.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_status_name := item_1.val
		mut var_status_slug := item_1.key
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_status_slug.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('selected', [var_current_status.clone(),
			var_status_slug.clone(), rt.new_bool(true)])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_status_name.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Topic'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('__', [rt.new_string('Select when the webhook will fire.'),
			rt.new_string('woocommerce')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_0 := Class_WC_Admin_Webhooks{}
	mut iife_result_0 := iife_temp_0.get_topic_data(var_webhook.clone())
	mut var_topic_data := iife_result_0
	mut var_topics := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_webhook_topics'),
		rt.create_array([
			rt.ArrayItem{ key: '', val: rt.call_function('__', [
				rt.new_string('Select an option&hellip;'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'coupon.created', val: rt.call_function('__', [
				rt.new_string('Coupon created'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'coupon.updated', val: rt.call_function('__', [
				rt.new_string('Coupon updated'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'coupon.deleted', val: rt.call_function('__', [
				rt.new_string('Coupon deleted'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'coupon.restored', val: rt.call_function('__', [
				rt.new_string('Coupon restored'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'customer.created', val: rt.call_function('__', [
				rt.new_string('Customer created'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'customer.updated', val: rt.call_function('__', [
				rt.new_string('Customer updated'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'customer.deleted', val: rt.call_function('__', [
				rt.new_string('Customer deleted'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'order.created', val: rt.call_function('__', [
				rt.new_string('Order created'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'order.updated', val: rt.call_function('__', [
				rt.new_string('Order updated'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'order.deleted', val: rt.call_function('__', [
				rt.new_string('Order deleted'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'order.restored', val: rt.call_function('__', [
				rt.new_string('Order restored'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'product.created', val: rt.call_function('__', [
				rt.new_string('Product created'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'product.updated', val: rt.call_function('__', [
				rt.new_string('Product updated'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'product.deleted', val: rt.call_function('__', [
				rt.new_string('Product deleted'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'product.restored', val: rt.call_function('__', [
				rt.new_string('Product restored'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'product.published', val: rt.call_function('__', [
				rt.new_string('Product published'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'action', val: rt.call_function('__', [
				rt.new_string('Action'),
				rt.new_string('woocommerce'),
			]) },
		]),
	])
	mut iter_2 := var_topics.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_topic_name := item_2.val
		mut var_topic_slug := item_2.key
		mut var_selected :=
			rt.is_true(rt.identical(var_topic_slug, var_topic_data.array_get(rt.new_string('topic'))))
			|| rt.is_true(rt.identical(var_topic_slug, (var_topic_data.array_get(rt.new_string('resource'))).str() + '.' + (var_topic_data.array_get(rt.new_string('event'))).str()))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_topic_slug.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('selected', [rt.new_bool(var_selected).clone(),
			rt.new_bool(true), rt.new_bool(true)])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_topic_name.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Action event'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('__', [
			rt.new_string('Enter the action that will trigger this webhook.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_topic_data.array_get(rt.new_string('event'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Delivery URL'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('__', [
			rt.new_string('URL where the webhook payload is delivered.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_webhook, 'get_delivery_url', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Secret'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('__', [
			rt.new_string('The secret key is used to generate a hash of the delivered webhook and provided in the request headers.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_webhook, 'get_secret', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('API Version'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('__', [
			rt.new_string('REST API version used in the webhook deliveries.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	mut iter_3 := rt.call_function('array_reverse', [
		rt.call_function('wc_get_webhook_rest_api_versions', []rt.PhpVal{}),
	]).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_version := item_3.val
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_version.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('selected', [var_version.clone(),
			rt.call_method(var_webhook, 'get_api_version', []rt.PhpVal{}),
			rt.new_bool(true)])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('WP REST API Integration v%d'),
					rt.new_string('woocommerce')]),
				rt.call_function('str_replace', [rt.new_string('wp_api_v'),
					rt.new_string(''), var_version.clone()]),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_legacy_api_option_name := if rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'legacy_rest_api_is_available', []rt.PhpVal{})) { rt.call_function('__', [
			rt.new_string('Legacy API v3 (deprecated)'),
			rt.new_string('woocommerce'),
		]) } else { rt.call_function('__', [
			rt.new_string('Legacy API v3 (⚠️ NOT AVAILABLE)'),
			rt.new_string('woocommerce'),
		]) }
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [rt.new_string('legacy_v3'),
		rt.call_method(var_webhook, 'get_api_version', []rt.PhpVal{}),
		rt.new_bool(true)])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_legacy_api_option_name.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_webhook_options'),
		var_webhook.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Webhook actions'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(var_webhook, 'get_date_created', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('0000-00-00 00:00:00'), rt.call_method(rt.call_method(var_webhook, 'get_date_created', []rt.PhpVal{}), 'date', [rt.new_string('Y-m-d H:i:s')]))))) {
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(rt.call_method(var_webhook, 'get_date_modified', []rt.PhpVal{}).is_null())) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Created at'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				rt.call_function('date_i18n', [
					rt.call_function('__', [
						rt.new_string('M j, Y @ G:i'),
						rt.new_string('woocommerce'),
					]),
					rt.call_function('strtotime', [
						rt.call_method(rt.call_method(var_webhook, 'get_date_created',
							[]rt.PhpVal{}), 'date', [rt.new_string('Y-m-d H:i:s')]),
					]),
				]),
			]))
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Created at'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				rt.call_function('date_i18n', [
					rt.call_function('__', [
						rt.new_string('M j, Y @ G:i'),
						rt.new_string('woocommerce'),
					]),
					rt.call_function('strtotime', [
						rt.call_method(rt.call_method(var_webhook, 'get_date_created',
							[]rt.PhpVal{}), 'date', [rt.new_string('Y-m-d H:i:s')]),
					]),
				]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Updated at'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				rt.call_function('date_i18n', [
					rt.call_function('__', [
						rt.new_string('M j, Y @ G:i'),
						rt.new_string('woocommerce'),
					]),
					rt.call_function('strtotime', [
						rt.call_method(rt.call_method(var_webhook, 'get_date_modified',
							[]rt.PhpVal{}), 'date', [rt.new_string('Y-m-d H:i:s')]),
					]),
				]),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Save webhook'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(var_webhook, 'get_id', []rt.PhpVal{})) {
		mut var_delete_url := rt.call_function('wp_nonce_url', [
			rt.call_function('add_query_arg', [
				rt.create_array([
					rt.ArrayItem{ key: 'delete', val: rt.call_method(var_webhook, 'get_id',
						[]rt.PhpVal{}) },
				]),
				rt.call_function('admin_url', [
					rt.new_string('admin.php?page=wc-settings&tab=advanced&section=webhooks'),
				]),
			]),
			rt.new_string('delete-webhook'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_delete_url.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Delete permanently'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
