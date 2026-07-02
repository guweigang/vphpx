import rt

struct Class_WC_Admin_Webhooks {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Admin_Webhooks) construct() {
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Webhooks', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'actions' },
		])])
	rt.call_function('add_action', [rt.new_string('woocommerce_settings_page_init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Webhooks', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'screen_option' },
		])])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_save_settings_advanced_webhooks'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Webhooks', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'allow_save_settings' },
		]),
	])
}

fn (mut this Class_WC_Admin_Webhooks) allow_save_settings(var_allow rt.PhpVal) bool {
	if !(rt.get_superglobal('_GET').array_isset(rt.new_string('edit-webhook'))) {
		return false
	}
	return var_allow.to_bool()
}

fn (mut this Class_WC_Admin_Webhooks) is_webhook_settings_page() bool {
	return rt.is_true(rt.call_function('is_wc_admin_settings_page', []rt.PhpVal{}))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('tab'))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('section'))
		&& rt.is_true(rt.identical(rt.new_string('advanced'), rt.get_superglobal('_GET').array_get(rt.new_string('tab'))))
		&& rt.is_true(rt.identical(rt.new_string('webhooks'), rt.get_superglobal('_GET').array_get(rt.new_string('section'))))
}

fn (mut this Class_WC_Admin_Webhooks) save() {
	rt.call_function('check_admin_referer', [rt.new_string('woocommerce-settings')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_woocommerce'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('esc_html__', [
				rt.new_string('You do not have permission to update Webhooks'),
				rt.new_string('woocommerce'),
			]),
		])
	}
	mut var_errors := []rt.PhpVal{}
	mut var_webhook_id := if rt.get_superglobal('_POST').array_isset(rt.new_string('webhook_id')) { rt.call_function('absint', [
			rt.get_superglobal('_POST').array_get(rt.new_string('webhook_id')),
		]) } else { rt.new_int(0) }
	mut var_webhook := create_wc_webhook(var_webhook_id.clone())
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('webhook_name')))) {
		mut var_name := rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_POST').array_get(rt.new_string('webhook_name'))]),
		])
	} else {
		var_name = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Webhook created on %s'),
				rt.new_string('woocommerce')]),
			rt.call_method(create_datetime(rt.new_string('now')), 'format', [
				rt.call_function('_x', [rt.new_string('M d, Y @ h:i A'),
					rt.new_string('Webhook created on date parsed by DateTime::format'),
					rt.new_string('woocommerce')])]),
		])
	}
	var_webhook.set_name(var_name.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_webhook.get_user_id())))) {
		var_webhook.set_user_id(rt.call_function('get_current_user_id', []rt.PhpVal{}))
	}
	var_webhook.set_status(if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('webhook_status')))) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('webhook_status')),
			]),
		]) } else { rt.new_string('disabled') })
	mut var_delivery_url := if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('webhook_delivery_url')))) { rt.call_function('esc_url_raw', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('webhook_delivery_url')),
			]),
		]) } else { rt.new_string('') }
	if rt.is_true(rt.call_function('wc_is_valid_url', [var_delivery_url.clone()])) {
		var_webhook.set_delivery_url(var_delivery_url.clone())
	}
	mut var_secret := if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('webhook_secret')))) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('webhook_secret')),
			]),
		]) } else { rt.call_function('wp_generate_password', [
			rt.new_int(50), rt.new_bool(true), rt.new_bool(true)]) }
	var_webhook.set_secret(var_secret.clone())
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('webhook_topic')))) {
		mut var_resource := rt.new_string('')
		mut var_event := rt.new_string('')
		mut switch_val_1 := rt.get_superglobal('_POST').array_get(rt.new_string('webhook_topic'))
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('action'))) {
			var_resource = rt.new_string('action')
			var_event = if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('webhook_action_event')))) { rt.call_function('sanitize_text_field', [
					rt.call_function('wp_unslash', [
						rt.get_superglobal('_POST').array_get(rt.new_string('webhook_action_event')),
					]),
				]) } else { rt.new_string('') }
		} else {
			mut list_tmp_1 := rt.call_function('explode', [rt.new_string('.'),
				rt.call_function('sanitize_text_field', [
					rt.call_function('wp_unslash', [
						rt.get_superglobal('_POST').array_get(rt.new_string('webhook_topic')),
					]),
				])])
			var_resource = list_tmp_1.array_get(0)
			var_event = list_tmp_1.array_get(1)
		}
		mut var_topic := rt.new_string(var_resource.str() + '.' + var_event.str())
		if rt.is_true(rt.call_function('wc_is_webhook_valid_topic', [
			var_topic.clone()]))
		{
			var_webhook.set_topic(var_topic.clone())
		} else {
			var_errors << rt.call_function('__', [
				rt.new_string('Webhook topic unknown. Please select a valid topic.'),
				rt.new_string('woocommerce'),
			])
		}
	}
	mut var_rest_api_versions := rt.call_function('wc_get_webhook_rest_api_versions', []rt.PhpVal{})
	var_webhook.set_api_version(if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('webhook_api_version')))) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('webhook_api_version')),
			]),
		]) } else { rt.call_function('end', [var_rest_api_versions.clone()]) })
	var_webhook.save()
	rt.call_function('do_action', [rt.new_string('woocommerce_webhook_options_save'),
		var_webhook.get_id()])
	if rt.is_true(var_errors) {
		rt.call_function('wp_safe_redirect', [
			rt.call_function('admin_url', [
				rt.new_string(
					'admin.php?page=wc-settings&tab=advanced&section=webhooks&edit-webhook=' +
					(var_webhook.get_id()).str() + '&error=' +(rt.call_function('rawurlencode', [rt.call_function('implode', [rt.new_string('|'), rt.create_array_from_list(var_errors)])])).str()),
			]),
		])
		exit(0)
	} else if rt.get_superglobal('_POST').array_isset(rt.new_string('webhook_status'))
		&& rt.is_true(rt.identical(rt.new_string('active'), rt.get_superglobal('_POST').array_get(rt.new_string('webhook_status'))))
		&& rt.is_true(var_webhook.get_pending_delivery()) {
		mut var_result := var_webhook.deliver_ping()
		if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
			rt.call_function('wp_safe_redirect', [
				rt.call_function('admin_url', [
					rt.new_string(
						'admin.php?page=wc-settings&tab=advanced&section=webhooks&edit-webhook=' +
						(var_webhook.get_id()).str() + '&error=' +(rt.call_function('rawurlencode', [rt.call_method(var_result, 'get_error_message', []rt.PhpVal{})])).str()),
				]),
			])
			exit(0)
		}
	}
	rt.call_function('wp_safe_redirect', [
		rt.call_function('admin_url', [
			rt.new_string(
				'admin.php?page=wc-settings&tab=advanced&section=webhooks&edit-webhook=' +
				(var_webhook.get_id()).str() + '&updated=1'),
		]),
	])
	exit(0)
}

fn Class_WC_Admin_Webhooks.bulk_delete(var_webhooks rt.PhpVal) {
	mut iter_1 := var_webhooks.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_webhook_id := item_1.val
		mut var_webhook := create_wc_webhook(rt.new_int(var_webhook_id.to_i64()))
		var_webhook.delete(rt.new_bool(true))
	}
	mut var_qty := rt.new_int(var_webhooks.clone().array_count())
	mut var_status := rt.new_string((if rt.get_superglobal('_GET').array_isset(rt.new_string('status')) {
		'&status=' +(rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('status'))])])).str()
	} else {
		''
	}).str())
	rt.call_function('wp_safe_redirect', [
		rt.call_function('admin_url', [
			rt.new_string('admin.php?page=wc-settings&tab=advanced&section=webhooks' +
				var_status.str() + '&deleted=' + var_qty.str()),
		]),
	])
	exit(0)
}

fn (mut this Class_WC_Admin_Webhooks) delete() {
	rt.call_function('check_admin_referer', [rt.new_string('delete-webhook')])
	if rt.get_superglobal('_GET').array_isset(rt.new_string('delete')) {
		mut var_webhook_id := rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('delete')),
		])
		if rt.is_true(var_webhook_id) {
			Class_WC_Admin_Webhooks.bulk_delete(rt.create_array([
				rt.ArrayItem{ key: none, val: var_webhook_id },
			]))
		}
	}
}

fn (mut this Class_WC_Admin_Webhooks) actions() {
	if this.is_webhook_settings_page() {
		if rt.get_superglobal('_POST').array_isset(rt.new_string('save'))
			&& rt.get_superglobal('_POST').array_isset(rt.new_string('webhook_id')) {
			this.save()
		}
		if rt.get_superglobal('_GET').array_isset(rt.new_string('delete')) {
			this.delete()
		}
	}
}

fn Class_WC_Admin_Webhooks.page_output() {
	mut var_GLOBALS := rt.new_null()
	var_GLOBALS.array_set('hide_save_button', true)
	if rt.get_superglobal('_GET').array_isset(rt.new_string('edit-webhook')) {
		mut var_webhook_id := rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('edit-webhook')),
		])
		mut var_webhook := create_wc_webhook(var_webhook_id.clone())
		rt.include_file(@DIR + '/settings/views/html-webhooks-edit.php', '1')
		return
	}
	Class_WC_Admin_Webhooks.table_list_output()
}

fn Class_WC_Admin_Webhooks.notices() {
	if rt.get_superglobal('_GET').array_isset(rt.new_string('deleted')) {
		mut var_deleted := rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('deleted')),
		])
		mut iife_temp_0 := Class_WC_Admin_Settings{}
		mut iife_result_0 := iife_temp_0.add_message(rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%d webhook permanently deleted.'),
				rt.new_string('%d webhooks permanently deleted.'),
				var_deleted.clone(), rt.new_string('woocommerce')]),
			var_deleted.clone(),
		]))
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('updated')) {
		mut iife_temp_1 := Class_WC_Admin_Settings{}
		mut iife_result_1 := iife_temp_1.add_message(rt.call_function('__', [
			rt.new_string('Webhook updated successfully.'),
			rt.new_string('woocommerce'),
		]))
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('created')) {
		mut iife_temp_2 := Class_WC_Admin_Settings{}
		mut iife_result_2 := iife_temp_2.add_message(rt.call_function('__', [
			rt.new_string('Webhook created successfully.'),
			rt.new_string('woocommerce'),
		]))
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('error')) {
		mut iter_2 := rt.call_function('explode', [rt.new_string('|'),
			rt.call_function('sanitize_text_field', [
				rt.call_function('wp_unslash',
					[rt.get_superglobal('_GET').array_get(rt.new_string('error'))]),
			])]).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_message := item_2.val
			mut iife_temp_3 := Class_WC_Admin_Settings{}
			mut iife_result_3 :=
				iife_temp_3.add_error(rt.new_string((var_message.clone().to_string().trim_space()).str()))
		}
	}
}

fn (mut this Class_WC_Admin_Webhooks) screen_option() {
	mut var_webhooks_table_list := rt.get_superglobal('webhooks_table_list')
	if !(rt.get_superglobal('_GET').array_isset(rt.new_string('edit-webhook')))
		&& this.is_webhook_settings_page() {
		var_webhooks_table_list = create_wc_admin_webhooks_table_list()
		rt.call_function('add_screen_option', [rt.new_string('per_page'),
			rt.create_array([rt.ArrayItem{ key: 'default', val: 10 },
				rt.ArrayItem{ key: 'option', val: 'woocommerce_webhooks_per_page' }])])
	}
}

fn Class_WC_Admin_Webhooks.table_list_output() {
	mut var_webhooks_table_list := rt.new_null()
	print('<h2 class="wc-table-list-header">' +
		(rt.call_function('esc_html__', [rt.new_string('Webhooks'), rt.new_string('woocommerce')])).str() +
		' <a href="' +
		(rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=advanced&section=webhooks&edit-webhook=0')])])).str() +
		'" class="page-title-action">' +
		(rt.call_function('esc_html__', [rt.new_string('Add webhook'), rt.new_string('woocommerce')])).str() +
		'</a></h2>')
	mut iife_temp_4 := Class_WC_Data_Store{}
	mut iife_result_4 := iife_temp_4.load(rt.new_string('webhook'))
	mut var_data_store := iife_result_4
	mut var_num_webhooks := rt.call_method(var_data_store, 'get_count_webhooks_by_status',
		[]rt.PhpVal{})
	mut var_count := rt.call_function('array_sum', [var_num_webhooks.clone()])
	if rt.is_true(rt.greater(var_count, rt.new_int(0))) {
		var_webhooks_table_list.process_bulk_action()
		var_webhooks_table_list.prepare_items()
		print('<input type="hidden" name="page" value="wc-settings" />')
		print('<input type="hidden" name="tab" value="advanced" />')
		print('<input type="hidden" name="section" value="webhooks" />')
		Class_WC_Admin_Webhooks.maybe_display_legacy_rest_api_warning()
		var_webhooks_table_list.views()
		var_webhooks_table_list.search_box(rt.call_function('__', [
			rt.new_string('Search webhooks'),
			rt.new_string('woocommerce'),
		]), rt.new_string('webhook'))
		var_webhooks_table_list.display()
	} else {
		print('<div class="woocommerce-BlankState woocommerce-BlankState--webhooks">')
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Webhooks are event notifications sent to URLs of your choice. They can be used to integrate with third-party services which support them.'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('admin_url', [
				rt.new_string('admin.php?page=wc-settings&tab=advanced&section=webhooks&edit-webhook=0'),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Create a new webhook'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
}

fn Class_WC_Admin_Webhooks.maybe_display_legacy_rest_api_warning() {
	mut var_webhooks_table_list := rt.new_null()
	if rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
		'legacy_rest_api_is_available', []rt.PhpVal{}))
	{
		return
	}
	mut var_legacy_api_webhooks_count := var_webhooks_table_list.get_legacy_api_webhooks_count()
	if rt.is_true(rt.identical(rt.new_int(0), var_legacy_api_webhooks_count)) {
		return
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [
		rt.new_string('Incompatible webhooks warning'),
		rt.new_string('woocommerce'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_data', [
		rt.call_function('sprintf', [
			rt.call_function('_n', [
				rt.new_string("There's %d webhook that is configured to be delivered using the Legacy REST API, which has been removed from WooCommerce. This webhook will fail to be sent."),
				rt.new_string('There are %d webhooks that are configured to be delivered using the Legacy REST API, which has been removed from WooCommerce. These webhooks will fail to be sent.'),
				var_legacy_api_webhooks_count.clone(),
				rt.new_string('woocommerce'),
			]),
			var_legacy_api_webhooks_count.clone(),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses', [
		rt.call_function('sprintf', [
			rt.call_function('_n', [
				rt.new_string('This webhook has the ⚠️ symbol in front of its name in the list below. Please either edit the webhook to use a different delivery format, or install and activate <a href="%s" target="_blank">the WooCommerce Legacy REST API extension</a>.'),
				rt.new_string('These webhooks have the ⚠️ symbol in front of their names in the list below. Please either edit the webhooks to use a different delivery format, or install and activate <a href="%s" target="_blank">the WooCommerce Legacy REST API extension</a>.'),
				var_legacy_api_webhooks_count.clone(),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('https://wordpress.org/plugins/woocommerce-legacy-rest-api/'),
		]),
		rt.create_array([
			rt.ArrayItem{ key: 'a', val: rt.create_array([
				rt.ArrayItem{ key: 'href', val: []rt.PhpVal{} },
				rt.ArrayItem{ key: 'target', val: []rt.PhpVal{} },
			]) },
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_data', [
		rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string("<a href='%s'>More information</a>"),
				rt.new_string('woocommerce')]),
			rt.new_string('https://developer.woocommerce.com/2023/10/03/the-legacy-rest-api-will-move-to-a-dedicated-extension-in-woocommerce-9-0/'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
}

fn Class_WC_Admin_Webhooks.logs_output(webhook string) {
	mut webhook_mutated := webhook
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Admin_Webhooks::logs_output'),
		rt.new_string('3.3'),
	])
}

fn Class_WC_Admin_Webhooks.get_topic_data(var_webhook rt.PhpVal) rt.PhpVal {
	mut var_webhook_mutated := var_webhook
	mut var_topic := var_webhook_mutated.get_topic()
	mut var_event := rt.new_string('')
	mut var_resource := rt.new_string('')
	if rt.is_true(var_topic) {
		mut list_tmp_2 := rt.call_function('explode', [rt.new_string('.'),
			var_topic.clone()])
		var_resource = list_tmp_2.array_get(0)
		var_event = list_tmp_2.array_get(1)
		if rt.is_true(rt.identical(rt.new_string('action'), var_resource)) {
			var_topic = rt.new_string('action')
		} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_resource.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'coupon' },
				rt.ArrayItem{ key: none, val: 'customer' }, rt.ArrayItem{ key: none, val: 'order' },
				rt.ArrayItem{ key: none, val: 'product' }]),
			rt.new_bool(true),
		])))))
		{
			var_topic = rt.new_string('custom')
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'topic', val: var_topic },
		rt.ArrayItem{ key: 'event', val: var_event }, rt.ArrayItem{
			key: 'resource'
			val: var_resource
		}])
}

fn Class_WC_Admin_Webhooks.get_logs_navigation(var_total rt.PhpVal, var_webhook rt.PhpVal) {
	mut var_webhook_mutated := var_webhook
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Admin_Webhooks::get_logs_navigation'),
		rt.new_string('3.3'),
	])
}

struct Class_WC_Webhook {
	rt.PhpObjectBase
}

struct Class_DateTime {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Settings {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Webhooks_Table_List {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_wc_admin_webhooks() &Class_WC_Admin_Webhooks {
	mut obj := &Class_WC_Admin_Webhooks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wc_webhook(_args ...rt.PhpVal) &Class_WC_Webhook {
	mut obj := &Class_WC_Webhook{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetime(_args ...rt.PhpVal) &Class_DateTime {
	mut obj := &Class_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_settings(_args ...rt.PhpVal) &Class_WC_Admin_Settings {
	mut obj := &Class_WC_Admin_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_webhooks_table_list(_args ...rt.PhpVal) &Class_WC_Admin_Webhooks_Table_List {
	mut obj := &Class_WC_Admin_Webhooks_Table_List{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store(_args ...rt.PhpVal) &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_Webhooks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'allow_save_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.allow_save_settings(dispatch_arg_0))
		}
		'is_webhook_settings_page' {
			return rt.new_bool(this.is_webhook_settings_page())
		}
		'save' {
			this.save()
			return rt.new_null()
		}
		'bulk_delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Admin_Webhooks.bulk_delete(dispatch_arg_0)
			return rt.new_null()
		}
		'delete' {
			this.delete()
			return rt.new_null()
		}
		'actions' {
			this.actions()
			return rt.new_null()
		}
		'page_output' {
			Class_WC_Admin_Webhooks.page_output()
			return rt.new_null()
		}
		'notices' {
			Class_WC_Admin_Webhooks.notices()
			return rt.new_null()
		}
		'screen_option' {
			this.screen_option()
			return rt.new_null()
		}
		'table_list_output' {
			Class_WC_Admin_Webhooks.table_list_output()
			return rt.new_null()
		}
		'maybe_display_legacy_rest_api_warning' {
			Class_WC_Admin_Webhooks.maybe_display_legacy_rest_api_warning()
			return rt.new_null()
		}
		'logs_output' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			Class_WC_Admin_Webhooks.logs_output(dispatch_arg_0)
			return rt.new_null()
		}
		'get_topic_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Admin_Webhooks.get_topic_data(dispatch_arg_0)
		}
		'get_logs_navigation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Admin_Webhooks.get_logs_navigation(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Admin_Webhooks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Webhooks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Webhook) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Webhook) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Webhook) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn (mut this Class_WC_Admin_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Admin_Webhooks_Table_List) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Webhooks_Table_List) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Webhooks_Table_List) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	create_wc_admin_webhooks()
}
