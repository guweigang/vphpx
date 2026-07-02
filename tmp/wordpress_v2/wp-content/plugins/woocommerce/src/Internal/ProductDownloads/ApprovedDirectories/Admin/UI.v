import rt

struct Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_UI {
	rt.PhpObjectBase
pub mut:
	register rt.PhpVal = rt.new_null()
	table    rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_UI) init(mut var_register Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register) {
	mut var_register_mutated := var_register
	this.register = var_register_mutated
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_UI) init_hooks() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
	mut iife_result_0 := iife_temp_0.is_site_administrator()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		return
	}
	rt.call_function('add_filter', [rt.new_string('woocommerce_get_sections_products'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_UI',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_section' },
		])])
	rt.call_function('add_action', [rt.new_string('load-woocommerce_page_wc-settings'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_UI',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'setup' },
		])])
	rt.call_function('add_action', [rt.new_string('woocommerce_settings_products'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_UI',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'render' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_UI) add_section(mut var_sections Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_array) rt.PhpVal {
	mut var_sections_mutated := var_sections
	var_sections_mutated.array_set('download_urls', rt.call_function('__', [
		rt.new_string('Approved download directories'),
		rt.new_string('woocommerce'),
	]))
	return rt.new_object('Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_array',
		[]string{}, var_sections_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_UI) setup() {
	if !(this.is_download_urls_screen()) {
		return
	}
	this.table =
		create_automattic_woocommerce_internal_productdownloads_approveddirectories_admin_table()
	this.admin_notices()
	this.handle_search()
	this.process_actions()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_UI) render() {
	if rt.is_true(rt.identical(rt.new_null(), this.table)) || !(this.is_download_urls_screen()) {
		return
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('action'))
		&& rt.is_true(rt.identical(rt.new_string('edit'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('action'))))
		&& rt.get_superglobal('_REQUEST').array_isset(rt.new_string('url')) {
		this.edit_screen(rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('url'))).to_i64()))
		return
	}
	rt.call_method(this.table, 'prepare_items', []rt.PhpVal{})
	rt.call_function('wp_nonce_field', [rt.new_string('modify_approved_directories'),
		rt.new_string('check')])
	this.display_title()
	rt.call_method(this.table, 'render_views', []rt.PhpVal{})
	rt.call_method(this.table, 'search_box', [
		rt.call_function('_x', [rt.new_string('Search'), rt.new_string('Approved Directory URLs'),
			rt.new_string('woocommerce')]),
		rt.new_string('download_url_search'),
	])
	rt.call_method(this.table, 'display', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_UI) is_download_urls_screen() bool {
	return rt.get_superglobal('_GET').array_isset(rt.new_string('tab'))
		&& rt.is_true(rt.identical(rt.new_string('products'), rt.get_superglobal('_GET').array_get(rt.new_string('tab'))))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('section'))
		&& rt.is_true(rt.identical(rt.new_string('download_urls'), rt.get_superglobal('_GET').array_get(rt.new_string('section'))))
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_UI) process_actions() {
	mut var_ids := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('url')) { rt.call_function('array_map', [
			rt.new_string('absint'),
			rt.cast_array(rt.get_superglobal('_REQUEST').array_get(rt.new_string('url'))),
		]) } else { rt.new_array() }
	if !rt.is_true(var_ids)
		|| !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('action'))) {
		return
	}
	this.security_check()
	mut var_action := rt.call_function('sanitize_text_field', [
		rt.call_function('wp_unslash',
			[rt.get_superglobal('_REQUEST').array_get(rt.new_string('action'))]),
	])
	mut switch_val_1 := var_action
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit'))) {
		this.process_edits((rt.call_function('current', [var_ids.clone()])).to_i64())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('enable')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('disable'))) {
		this.process_bulk_actions(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_array](var_ids),
			var_action.str())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('enable-all')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('disable-all'))) {
		this.process_all_actions(var_action.str())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('turn-on')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('turn-off'))) {
		this.process_on_off(var_action.str())
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_UI) handle_search() {
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('s')))
		|| rt.is_true(rt.identical(rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_GET').array_get(rt.new_string('s'))).is_null() { rt.get_superglobal('_GET').array_get(rt.new_string('s')) } else { rt.new_string('') }])]), rt.get_superglobal('_POST').array_get(rt.new_string('s')))) {
		return
	}
	rt.call_function('wp_safe_redirect', [
		rt.call_function('add_query_arg', [
			rt.create_array([
				rt.ArrayItem{ key: 'paged', val: rt.call_function('absint', [if !(rt.get_superglobal('_GET').array_get(rt.new_string('paged'))).is_null() {
					rt.get_superglobal('_GET').array_get(rt.new_string('paged'))
				} else {
					rt.new_int(1)
				}]) },
				rt.ArrayItem{
					key: 's'
					val: rt.call_function('sanitize_text_field', [
						rt.call_function('wp_unslash',
							[rt.get_superglobal('_POST').array_get(rt.new_string('s'))])])
				},
			]),
			rt.call_method(this.table, 'get_base_url', []rt.PhpVal{}),
		]),
	])
	exit(0)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_UI) process_edits(url_id i64) {
	mut var_url := rt.call_function('esc_url_raw', [
		rt.call_function('wp_unslash', [if !(rt.get_superglobal('_POST').array_get(rt.new_string('approved_directory_url'))).is_null() {
			rt.get_superglobal('_POST').array_get(rt.new_string('approved_directory_url'))
		} else {
			rt.new_string('')
		}]),
	])
	mut var_enabled := rt.new_bool((rt.call_function('sanitize_text_field', [
		rt.call_function('wp_unslash', [if !(rt.get_superglobal('_POST').array_get(rt.new_string('approved_directory_enabled'))).is_null() {
			rt.get_superglobal('_POST').array_get(rt.new_string('approved_directory_enabled'))
		} else {
			rt.new_string('')
		}]),
	])).to_bool())
	if !rt.is_true(var_url) {
		return
	}
	mut var_redirect_url := rt.call_function('add_query_arg', [
		rt.new_string('id'), rt.new_int(url_id),
		rt.call_method(this.table, 'get_action_url', [
			rt.new_string('edit'),
			rt.new_int(url_id),
		])])
	mut var_upserted := if 0 == url_id { rt.call_method(this.register, 'add_approved_directory', [
			var_url.clone(),
			var_enabled.clone(),
		]) } else { rt.call_method(this.register, 'update_approved_directory', [
			rt.new_int(url_id),
			var_url.clone(),
			var_enabled.clone(),
		]) }
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.new_bool(var_upserted.clone().is_long())) {
		var_redirect_url = rt.call_function('add_query_arg', [
			rt.new_string('url'), var_upserted.clone(), var_redirect_url.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_redirect_url = rt.call_function('add_query_arg', [rt.new_string('edit-status'),
		rt.new_string((if 0 == url_id { 'added' } else { 'updated' }).str()),
		var_redirect_url.clone()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		var_redirect_url = rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'edit-status', val: 'failure' },
				rt.ArrayItem{ key: 'submitted-url', val: var_url }]),
			var_redirect_url.clone(),
		])
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	rt.call_function('wp_safe_redirect', [var_redirect_url.clone()])
	exit(0)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_UI) process_bulk_actions(mut var_ids Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_array, action string) {
	mut var_ids_mutated := var_ids
	mut action_mutated := action
	mut var_deletes := rt.new_int(0)
	mut var_enabled := rt.new_int(0)
	mut var_disabled := rt.new_int(0)
	mut var_register := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register.class(),
	])
	mut iter_1 := var_ids_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_id := item_1.val
		if rt.is_true(rt.identical(rt.new_string('delete'), rt.new_string(action_mutated)))
			&& rt.is_true(rt.call_method(var_register, 'delete_by_id', [var_id.clone()])) {
			rt.post_inc(var_deletes)
		} else if rt.is_true(rt.identical(rt.new_string('enable'), rt.new_string(action_mutated)))
			&& rt.is_true(rt.call_method(var_register, 'enable_by_id', [var_id.clone()])) {
			rt.post_inc(var_enabled)
		} else if rt.is_true(rt.identical(rt.new_string('disable'), rt.new_string(action_mutated)))
			&& rt.is_true(rt.call_method(var_register, 'disable_by_id', [var_id.clone()])) {
			rt.post_inc(var_disabled)
		}
	}
	mut var_fails := rt.sub(rt.sub(rt.sub(rt.new_int(var_ids_mutated.array_count()), var_deletes),
		var_enabled), var_disabled)
	mut var_redirect := rt.call_method(this.table, 'get_base_url', []rt.PhpVal{})
	if rt.is_true(var_deletes) {
		var_redirect = rt.call_function('add_query_arg', [rt.new_string('deleted-ids'),
			var_deletes.clone(), var_redirect.clone()])
	} else if rt.is_true(var_enabled) {
		var_redirect = rt.call_function('add_query_arg', [rt.new_string('enabled-ids'),
			var_enabled.clone(), var_redirect.clone()])
	} else if rt.is_true(var_disabled) {
		var_redirect = rt.call_function('add_query_arg', [rt.new_string('disabled-ids'),
			var_disabled.clone(), var_redirect.clone()])
	}
	if rt.is_true(var_fails) {
		var_redirect = rt.call_function('add_query_arg', [rt.new_string('bulk-fails'),
			var_fails.clone(), var_redirect.clone()])
	}
	rt.call_function('wp_safe_redirect', [var_redirect.clone()])
	exit(0)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_UI) process_all_actions(action string) {
	mut action_mutated := action
	mut var_register := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register.class(),
	])
	mut var_redirect := rt.call_method(this.table, 'get_base_url', []rt.PhpVal{})
	mut switch_val_2 := rt.new_string(action_mutated)
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('enable-all'))) {
		var_redirect = rt.call_function('add_query_arg', [rt.new_string('enabled-all'),
			rt.new_int((rt.call_method(var_register, 'enable_all', []rt.PhpVal{})).to_i64()),
			var_redirect.clone()])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('disable-all'))) {
		var_redirect = rt.call_function('add_query_arg', [rt.new_string('disabled-all'),
			rt.new_int((rt.call_method(var_register, 'disable_all', []rt.PhpVal{})).to_i64()),
			var_redirect.clone()])
	}
	rt.call_function('wp_safe_redirect', [var_redirect.clone()])
	exit(0)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_UI) process_on_off(action string) {
	mut action_mutated := action
	mut switch_val_3 := rt.new_string(action_mutated)
	if rt.is_true(rt.equal(switch_val_3, rt.new_string('turn-on'))) {
		rt.call_method(this.register, 'set_mode', [
			Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register.mode_enabled(),
		])
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('turn-off'))) {
		rt.call_method(this.register, 'set_mode', [
			Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register.mode_disabled(),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_UI) display_title() {
	mut var_turn_on_off := rt.new_string((if rt.is_true(rt.identical(rt.call_method(this.register,
		'get_mode', []rt.PhpVal{}),
		Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register.mode_enabled()))
	{
		'<a href="' +
			(rt.call_function('esc_url', [rt.call_method(this.table, 'get_action_url', [rt.new_string('turn-off'), rt.new_int(0)])])).str() +
			'" class="page-title-action">' +
			(rt.call_function('esc_html_x', [rt.new_string('Stop Enforcing Rules'), rt.new_string('Approved product download directories'), rt.new_string('woocommerce')])).str() +
			'</a>'
	} else {
		'<a href="' +
			(rt.call_function('esc_url', [rt.call_method(this.table, 'get_action_url', [rt.new_string('turn-on'), rt.new_int(0)])])).str() +
			'" class="page-title-action">' +
			(rt.call_function('esc_html_x', [rt.new_string('Start Enforcing Rules'), rt.new_string('Approved product download directories'), rt.new_string('woocommerce')])).str() +
			'</a>'
	}).str())
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Approved Download Directories'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_method(this.table, 'get_action_url', [rt.new_string('edit'),
			rt.new_int(0)]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add New'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_turn_on_off)
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_UI) edit_screen(url_id i64) {
	this.security_check()
	mut var_existing := rt.call_method(this.register, 'get_by_id', [
		rt.new_int(url_id)])
	if rt.is_true(rt.new_bool(0 != url_id)) && rt.is_true(rt.new_bool(!(rt.is_true(var_existing)))) {
		mut iife_temp_1 := Class_WC_Admin_Settings{}
		mut iife_result_1 := iife_temp_1.add_error(rt.call_function('_x', [
			rt.new_string('The provided ID was invalid.'),
			rt.new_string('Approved product download directories'),
			rt.new_string('woocommerce'),
		]))
		mut iife_temp_2 := Class_WC_Admin_Settings{}
		mut iife_result_2 := iife_temp_2.show_messages()
		return
	}
	mut var_title := if rt.is_true(var_existing) { rt.call_function('__', [
			rt.new_string('Edit Approved Directory'),
			rt.new_string('woocommerce'),
		]) } else { rt.call_function('__', [rt.new_string('Add New Approved Directory'),
			rt.new_string('woocommerce')]) }
	mut var_submitted := rt.call_function('sanitize_text_field', [
		rt.call_function('wp_unslash', [if !(rt.get_superglobal('_GET').array_get(rt.new_string('submitted-url'))).is_null() {
			rt.get_superglobal('_GET').array_get(rt.new_string('submitted-url'))
		} else {
			rt.new_string('')
		}]),
	])
	mut var_existing_url := if rt.is_true(var_existing) {
		rt.call_method(var_existing, 'get_url', []rt.PhpVal{})
	} else {
		rt.new_string('')
	}
	mut var_enabled := if rt.is_true(var_existing) {
		rt.call_method(var_existing, 'is_enabled', []rt.PhpVal{})
	} else {
		rt.new_bool(true)
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_existing) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_method(this.table, 'get_action_url', [rt.new_string('edit'),
				rt.new_int(0)]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Add New'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_method(this.table, 'get_base_url', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Cancel'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('Directory URL'),
		rt.new_string('Approved product download directories'),
		rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [if !rt.is_true(var_submitted) {
		var_existing_url
	} else {
		var_submitted
	}]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('Enabled'),
		rt.new_string('Approved product download directories'),
		rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_bool(true), var_enabled.clone()])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_UI) admin_notices() {
	mut var_successfully_deleted := rt.new_int(if rt.get_superglobal('_GET').array_isset(rt.new_string('deleted-ids')) {
		rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('deleted-ids'))).to_i64())
	} else {
		0
	})
	mut var_successfully_enabled := rt.new_int(if rt.get_superglobal('_GET').array_isset(rt.new_string('enabled-ids')) {
		rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('enabled-ids'))).to_i64())
	} else {
		0
	})
	mut var_successfully_disabled := rt.new_int(if rt.get_superglobal('_GET').array_isset(rt.new_string('disabled-ids')) {
		rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('disabled-ids'))).to_i64())
	} else {
		0
	})
	mut var_failed_updates := rt.new_int(if rt.get_superglobal('_GET').array_isset(rt.new_string('bulk-fails')) {
		rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('bulk-fails'))).to_i64())
	} else {
		0
	})
	mut var_edit_status := rt.call_function('sanitize_text_field', [
		rt.call_function('wp_unslash', [if !(rt.get_superglobal('_GET').array_get(rt.new_string('edit-status'))).is_null() {
			rt.get_superglobal('_GET').array_get(rt.new_string('edit-status'))
		} else {
			rt.new_string('')
		}]),
	])
	mut var_edit_url := rt.call_function('esc_attr', [
		rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [if !(rt.get_superglobal('_GET').array_get(rt.new_string('submitted-url'))).is_null() {
				rt.get_superglobal('_GET').array_get(rt.new_string('submitted-url'))
			} else {
				rt.new_string('')
			}]),
		]),
	])
	if rt.is_true(var_successfully_deleted) {
		mut iife_temp_3 := Class_WC_Admin_Settings{}
		mut iife_result_3 := iife_temp_3.add_message(rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%d approved directory URL deleted.'),
				rt.new_string('%d approved directory URLs deleted.'),
				var_successfully_deleted.clone(), rt.new_string('woocommerce')]),
			var_successfully_deleted.clone(),
		]))
	} else if rt.is_true(var_successfully_enabled) {
		mut iife_temp_4 := Class_WC_Admin_Settings{}
		mut iife_result_4 := iife_temp_4.add_message(rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%d approved directory URL enabled.'),
				rt.new_string('%d approved directory URLs enabled.'),
				var_successfully_enabled.clone(), rt.new_string('woocommerce')]),
			var_successfully_enabled.clone(),
		]))
	} else if rt.is_true(var_successfully_disabled) {
		mut iife_temp_5 := Class_WC_Admin_Settings{}
		mut iife_result_5 := iife_temp_5.add_message(rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%d approved directory URL disabled.'),
				rt.new_string('%d approved directory URLs disabled.'),
				var_successfully_disabled.clone(), rt.new_string('woocommerce')]),
			var_successfully_disabled.clone(),
		]))
	}
	if rt.is_true(var_failed_updates) {
		mut iife_temp_6 := Class_WC_Admin_Settings{}
		mut iife_result_6 := iife_temp_6.add_error(rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%d URL could not be updated.'),
				rt.new_string('%d URLs could not be updated.'),
				var_failed_updates.clone(), rt.new_string('woocommerce')]),
			var_failed_updates.clone(),
		]))
	}
	if rt.is_true(rt.identical(rt.new_string('added'), var_edit_status)) {
		mut iife_temp_7 := Class_WC_Admin_Settings{}
		mut iife_result_7 := iife_temp_7.add_message(rt.call_function('__', [
			rt.new_string('URL was successfully added.'),
			rt.new_string('woocommerce'),
		]))
	}
	if rt.is_true(rt.identical(rt.new_string('updated'), var_edit_status)) {
		mut iife_temp_8 := Class_WC_Admin_Settings{}
		mut iife_result_8 := iife_temp_8.add_message(rt.call_function('__', [
			rt.new_string('URL was successfully updated.'),
			rt.new_string('woocommerce'),
		]))
	}
	if rt.is_true(rt.identical(rt.new_string('failure'), var_edit_status))
		&& !(!rt.is_true(var_edit_url)) {
		mut iife_temp_9 := Class_WC_Admin_Settings{}
		mut iife_result_9 := iife_temp_9.add_error(rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('"%s" could not be saved. Please review, ensure it is a valid URL and try again.'),
				rt.new_string('woocommerce'),
			]),
			var_edit_url.clone(),
		]))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_UI) security_check() {
	mut iife_temp_10 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
	mut iife_result_10 := iife_temp_10.is_site_administrator()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_10))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('check'))).is_null() { rt.get_superglobal('_REQUEST').array_get(rt.new_string('check')) } else { rt.new_string('') }])]), rt.new_string('modify_approved_directories')]))))) {
		rt.call_function('wp_die', [
			rt.call_function('esc_html__', [
				rt.new_string('You do not have permission to modify the list of approved directories for product downloads.'),
				rt.new_string('woocommerce'),
			]),
		])
	}
}

struct Class_Automattic_WooCommerce_Internal_Utilities_Users {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Settings {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_productdownloads_approveddirectories_admin_ui(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_UI {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_UI{
		PhpObjectBase: rt.PhpObjectBase{}
		register:      rt.new_null()
		table:         rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_users(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Utilities_Users {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_Users{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_productdownloads_approveddirectories_admin_table(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table{
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

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_UI) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'init_hooks' {
			this.init_hooks()
			return rt.new_null()
		}
		'add_section' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.add_section(mut dispatch_arg_0)
		}
		'setup' {
			this.setup()
			return rt.new_null()
		}
		'render' {
			this.render()
			return rt.new_null()
		}
		'is_download_urls_screen' {
			return rt.new_bool(this.is_download_urls_screen())
		}
		'process_actions' {
			this.process_actions()
			return rt.new_null()
		}
		'handle_search' {
			this.handle_search()
			return rt.new_null()
		}
		'process_edits' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.process_edits(dispatch_arg_0)
			return rt.new_null()
		}
		'process_bulk_actions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.process_bulk_actions(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'process_all_actions' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.process_all_actions(dispatch_arg_0)
			return rt.new_null()
		}
		'process_on_off' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.process_on_off(dispatch_arg_0)
			return rt.new_null()
		}
		'display_title' {
			this.display_title()
			return rt.new_null()
		}
		'edit_screen' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.edit_screen(dispatch_arg_0)
			return rt.new_null()
		}
		'admin_notices' {
			this.admin_notices()
			return rt.new_null()
		}
		'security_check' {
			this.security_check()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_UI) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'register' { return this.register }
		'table' { return this.table }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_UI) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'register' {
			this.register = val
			return true
		}
		'table' {
			this.table = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
