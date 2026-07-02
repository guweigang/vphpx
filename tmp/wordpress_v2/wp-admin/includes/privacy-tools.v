import rt

fn _wp_privacy_resend_request(var_request_id_arg rt.PhpVal) bool {
	mut var_request_id := var_request_id_arg
	mut var_request := rt.new_null()
	mut var_result := rt.new_null()
	var_request_id = rt.call_function('absint', [var_request_id.clone()])
	var_request = rt.call_function('get_post', [var_request_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_request))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('user_request'), rt.get_property(var_request, 'post_type'))))) {
		return (create_wp_error(rt.new_string('privacy_request_error'), rt.call_function('__', [
			rt.new_string('Invalid personal data request.'),
		]))).to_bool()
	}
	var_result = rt.call_function('wp_send_user_request', [var_request_id.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		return var_result.to_bool()
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return (create_wp_error(rt.new_string('privacy_request_error'), rt.call_function('__', [
			rt.new_string('Unable to initiate confirmation for personal data request.'),
		]))).to_bool()
	}
	return true
}

fn _wp_privacy_completed_request(var_request_id_arg rt.PhpVal) rt.PhpVal {
	mut var_request_id := var_request_id_arg
	mut var_request := rt.new_null()
	mut var_result := rt.new_null()
	var_request_id = rt.call_function('absint', [var_request_id.clone()])
	var_request = rt.call_function('wp_get_user_request', [var_request_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_request)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('privacy_request_error'), rt.call_function('__', [
			rt.new_string('Invalid personal data request.'),
		])))
	}
	rt.call_function('update_post_meta', [var_request_id.clone(),
		rt.new_string('_wp_user_request_completed_timestamp'),
		rt.call_function('time', []rt.PhpVal{})])
	var_result = rt.call_function('wp_update_post', [
		rt.create_array([rt.ArrayItem{ key: 'ID', val: var_request_id },
			rt.ArrayItem{ key: 'post_status', val: 'request-completed' }]),
	])
	return var_result.clone()
}

fn _wp_personal_data_handle_actions() {
	mut var_request_id := rt.new_null()
	mut var_result := false
	mut var_action := rt.new_null()
	mut var_action_type := rt.new_null()
	mut var_username_or_email_address := rt.new_null()
	mut var_email_address := rt.new_null()
	mut var_status := rt.new_null()
	mut var_user := rt.new_null()
	mut var_message := rt.new_null()
	if rt.get_superglobal('_POST').array_isset(rt.new_string('privacy_action_email_retry')) {
		rt.call_function('check_admin_referer', [rt.new_string('bulk-privacy_requests')])
		var_request_id = rt.call_function('absint', [
			rt.call_function('current', [
				rt.func_array_keys(rt.cast_array(rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(rt.new_string('privacy_action_email_retry')),
				]))),
			]),
		])
		var_result = _wp_privacy_resend_request(var_request_id.clone())
		if rt.is_true(rt.call_function('is_wp_error', [rt.new_bool(var_result).clone()])) {
			rt.call_function('add_settings_error', [
				rt.new_string('privacy_action_email_retry'),
				rt.new_string('privacy_action_email_retry'),
				rt.call_method(rt.new_bool(var_result), 'get_error_message', []rt.PhpVal{}),
				rt.new_string('error'),
			])
		} else {
			rt.call_function('add_settings_error', [
				rt.new_string('privacy_action_email_retry'),
				rt.new_string('privacy_action_email_retry'),
				rt.call_function('__', [
					rt.new_string('Confirmation request sent again successfully.'),
				]),
				rt.new_string('success'),
			])
		}
	} else if rt.get_superglobal('_POST').array_isset(rt.new_string('action')) {
		var_action = if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('action')))) { rt.call_function('sanitize_key', [
				rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('action'))]),
			]) } else { rt.new_string('') }
		mut switch_val_1 := var_action
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('add_export_personal_data_request')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('add_remove_personal_data_request'))) {
			rt.call_function('check_admin_referer', [
				rt.new_string('personal-data-request'),
			])
			if !(rt.get_superglobal('_POST').array_isset(rt.new_string('type_of_action'))
				&& rt.get_superglobal('_POST').array_isset(rt.new_string('username_or_email_for_privacy_request'))) {
				rt.call_function('add_settings_error', [rt.new_string('action_type'),
					rt.new_string('action_type'),
					rt.call_function('__', [
						rt.new_string('Invalid personal data action.'),
					]),
					rt.new_string('error')])
			}
			var_action_type = rt.call_function('sanitize_text_field', [
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(rt.new_string('type_of_action')),
				]),
			])
			var_username_or_email_address = rt.call_function('sanitize_text_field', [
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(rt.new_string('username_or_email_for_privacy_request')),
				]),
			])
			var_email_address = rt.new_string('')
			var_status = rt.new_string('pending')
			if !(rt.get_superglobal('_POST').array_isset(rt.new_string('send_confirmation_email'))) {
				var_status = rt.new_string('confirmed')
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
				var_action_type.clone(),
				rt.call_function('_wp_privacy_action_request_types', []rt.PhpVal{}),
				rt.new_bool(true),
			])))))
			{
				rt.call_function('add_settings_error', [rt.new_string('action_type'),
					rt.new_string('action_type'),
					rt.call_function('__', [
						rt.new_string('Invalid personal data action.'),
					]),
					rt.new_string('error')])
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [
				var_username_or_email_address.clone(),
			])))))
			{
				var_user = rt.call_function('get_user_by', [rt.new_string('login'),
					var_username_or_email_address.clone()])
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_user,
					'WP_User'))))))
				{
					rt.call_function('add_settings_error', [
						rt.new_string('username_or_email_for_privacy_request'),
						rt.new_string('username_or_email_for_privacy_request'),
						rt.call_function('__', [
							rt.new_string('Unable to add this request. A valid email address or username must be supplied.'),
						]),
						rt.new_string('error'),
					])
				} else {
					var_email_address = rt.get_property(var_user, 'user_email')
				}
			} else {
				var_email_address = var_username_or_email_address.clone()
			}
			if !rt.is_true(var_email_address) {
			}
			var_request_id = rt.call_function('wp_create_user_request', [
				var_email_address.clone(), var_action_type.clone(),
				rt.new_array(), var_status.clone()])
			var_message = rt.new_string('')
			if rt.is_true(rt.call_function('is_wp_error', [var_request_id.clone()])) {
				var_message = rt.call_method(var_request_id, 'get_error_message', []rt.PhpVal{})
			} else if rt.is_true(rt.new_bool(!(rt.is_true(var_request_id)))) {
				var_message = rt.call_function('__', [
					rt.new_string('Unable to initiate confirmation request.'),
				])
			}
			if rt.is_true(var_message) {
				rt.call_function('add_settings_error', [
					rt.new_string('username_or_email_for_privacy_request'),
					rt.new_string('username_or_email_for_privacy_request'),
					var_message.clone(),
					rt.new_string('error'),
				])
			}
			if rt.is_true(rt.identical(rt.new_string('pending'), var_status)) {
				rt.call_function('wp_send_user_request', [var_request_id.clone()])
				var_message = rt.call_function('__', [
					rt.new_string('Confirmation request initiated successfully.'),
				])
			} else if rt.is_true(rt.identical(rt.new_string('confirmed'), var_status)) {
				var_message = rt.call_function('__', [
					rt.new_string('Request added successfully.'),
				])
			}
			if rt.is_true(var_message) {
				rt.call_function('add_settings_error', [
					rt.new_string('username_or_email_for_privacy_request'),
					rt.new_string('username_or_email_for_privacy_request'),
					var_message.clone(),
					rt.new_string('success'),
				])
			}
		}
	}
}

fn _wp_personal_data_cleanup_requests() {
	mut var_expires := rt.new_null()
	mut var_requests_query := rt.new_null()
	mut var_request_ids := rt.new_null()
	mut var_request_id := rt.new_null()
	var_expires = rt.new_int((rt.call_function('apply_filters', [
		rt.new_string('user_request_key_expiration'),
		rt.get_constant('DAY_IN_SECONDS'),
	])).to_i64())
	var_requests_query = create_wp_query(rt.create_array([
		rt.ArrayItem{ key: 'post_type', val: 'user_request' },
		rt.ArrayItem{ key: 'posts_per_page', val: -1 },
		rt.ArrayItem{ key: 'post_status', val: 'request-pending' },
		rt.ArrayItem{ key: 'fields', val: 'ids' },
		rt.ArrayItem{ key: 'date_query', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'column', val: 'post_modified_gmt' },
				rt.ArrayItem{ key: 'before', val: var_expires.str() + ' seconds ago' },
			]) },
		]) },
	]))
	var_request_ids = rt.get_property(var_requests_query, 'posts')
	mut iter_1 := var_request_ids.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_request_id_shadow := item_1.val
		rt.call_function('wp_update_post', [
			rt.create_array([rt.ArrayItem{ key: 'ID', val: var_request_id_shadow },
				rt.ArrayItem{ key: 'post_status', val: 'request-failed' },
				rt.ArrayItem{ key: 'post_password', val: '' }]),
		])
	}
}

fn wp_privacy_generate_personal_data_export_group_html(var_group_data rt.PhpVal, group_id string, groups_count i64) rt.PhpVal {
	mut var_group_id := group_id
	mut var_groups_count := groups_count
	mut var_group_id_attr := rt.new_null()
	mut var_group_html := rt.new_null()
	mut var_items_count := i64(0)
	mut var_group_item_data := rt.new_null()
	mut var_group_item_id := rt.new_null()
	mut var_group_item_datum := map[string]rt.PhpVal{}
	mut var_value := rt.new_null()
	var_group_id_attr = rt.call_function('sanitize_title_with_dashes', [
		rt.new_string(
			(var_group_data.array_get(rt.new_string('group_label'))).str() + '-' + group_id),
	])
	var_group_html = rt.new_string('<h2 id="' +
		(rt.call_function('esc_attr', [var_group_id_attr.clone()])).str() + '">')
	var_group_html = rt.concat(var_group_html, rt.call_function('esc_html', [
		var_group_data.array_get(rt.new_string('group_label')),
	]))
	var_items_count = rt.cast_array(var_group_data.array_get(rt.new_string('items'))).array_count()
	if var_items_count > 1 {
		var_group_html = rt.concat(var_group_html, rt.call_function('sprintf', [
			rt.new_string(' <span class="count">(%d)</span>'),
			rt.new_int(var_items_count).clone(),
		]))
	}
	var_group_html = rt.concat(var_group_html, rt.new_string('</h2>'))
	if !(!rt.is_true(var_group_data.array_get(rt.new_string('group_description')))) {
		var_group_html = rt.concat(var_group_html, rt.new_string('<p>' +
			(rt.call_function('esc_html', [var_group_data.array_get(rt.new_string('group_description'))])).str() +
			'</p>'))
	}
	var_group_html = rt.concat(var_group_html, rt.new_string('<div>'))
	mut iter_2 := rt.cast_array(var_group_data.array_get(rt.new_string('items'))).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_group_item_data_shadow := item_2.val
		mut var_group_item_id_shadow := item_2.key
		var_group_html = rt.concat(var_group_html, rt.new_string('<table>'))
		var_group_html = rt.concat(var_group_html, rt.new_string('<tbody>'))
		mut iter_3 := rt.cast_array(var_group_item_data_shadow).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_group_item_datum_shadow := item_3.val
			var_value = var_group_item_datum_shadow['value']
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_value.clone(), rt.new_string(' ')])))))
				&& rt.is_true(rt.call_function('str_starts_with', [var_value.clone(), rt.new_string('http://')]))
				|| rt.is_true(rt.call_function('str_starts_with', [var_value.clone(), rt.new_string('https://')])) {
				var_value = rt.new_string('<a href="' +
					(rt.call_function('esc_url', [var_value.clone()])).str() + '">' +
					(rt.call_function('esc_html', [var_value.clone()])).str() + '</a>')
			}
			var_group_html = rt.concat(var_group_html, rt.new_string('<tr>'))
			var_group_html = rt.concat(var_group_html, rt.new_string('<th>' +
				(rt.call_function('esc_html', [var_group_item_datum_shadow['name']])).str() +
				'</th>'))
			var_group_html = rt.concat(var_group_html, rt.new_string('<td>' +
				(rt.call_function('wp_kses', [var_value.clone(), rt.new_string('personal_data_export')])).str() +
				'</td>'))
			var_group_html = rt.concat(var_group_html, rt.new_string('</tr>'))
		}
		var_group_html = rt.concat(var_group_html, rt.new_string('</tbody>'))
		var_group_html = rt.concat(var_group_html, rt.new_string('</table>'))
	}
	if groups_count > 1 {
		var_group_html = rt.concat(var_group_html, rt.new_string('<div class="return-to-top">'))
		var_group_html = rt.concat(var_group_html, rt.new_string(
			'<a href="#top"><span aria-hidden="true">&uarr; </span> ' +
			(rt.call_function('esc_html__', [rt.new_string('Go to top')])).str() + '</a>'))
		var_group_html = rt.concat(var_group_html, rt.new_string('</div>'))
	}
	var_group_html = rt.concat(var_group_html, rt.new_string('</div>'))
	return var_group_html.clone()
}

fn wp_privacy_generate_personal_data_export_file(var_request_id rt.PhpVal) {
	mut var_request := rt.new_null()
	mut var_email_address := rt.new_null()
	mut var_exports_dir := rt.new_null()
	mut var_exports_url := rt.new_null()
	mut var_index_pathname := rt.new_null()
	mut var_file := rt.new_null()
	mut var_obscura := rt.new_null()
	mut var_file_basename := rt.new_null()
	mut var_html_report_filename := rt.new_null()
	mut var_html_report_pathname := rt.new_null()
	mut var_json_report_filename := rt.new_null()
	mut var_json_report_pathname := rt.new_null()
	mut var_title := rt.new_null()
	mut var_about_group := map[string]rt.PhpVal{}
	mut var_groups := rt.new_null()
	mut var_groups_count := i64(0)
	mut var_groups_json := rt.new_null()
	mut var_error_message := rt.new_null()
	mut var_group_data := map[string]rt.PhpVal{}
	mut var_group_id := rt.new_null()
	mut var_group_label := rt.new_null()
	mut var_group_id_attr := rt.new_null()
	mut var_group_items_count := i64(0)
	mut var_error := rt.new_null()
	mut var_archive_filename := rt.new_null()
	mut var_archive_pathname := rt.new_null()
	mut var_archive_url := rt.new_null()
	mut var_zip := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ZipArchive'),
	])))))
	{
		rt.call_function('wp_send_json_error', [
			rt.call_function('__', [
				rt.new_string('Unable to generate personal data export file. ZipArchive not available.'),
			]),
		])
	}
	var_request = rt.call_function('wp_get_user_request', [var_request_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_request))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('export_personal_data'), rt.get_property(var_request, 'action_name'))))) {
		rt.call_function('wp_send_json_error', [
			rt.call_function('__', [
				rt.new_string('Invalid request ID when generating personal data export file.'),
			]),
		])
	}
	var_email_address = rt.get_property(var_request, 'email')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [
		var_email_address.clone()])))))
	{
		rt.call_function('wp_send_json_error', [
			rt.call_function('__', [
				rt.new_string('Invalid email address when generating personal data export file.'),
			]),
		])
	}
	var_exports_dir = rt.call_function('wp_privacy_exports_dir', []rt.PhpVal{})
	var_exports_url = rt.call_function('wp_privacy_exports_url', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_mkdir_p', [
		var_exports_dir.clone()])))))
	{
		rt.call_function('wp_send_json_error', [
			rt.call_function('__', [
				rt.new_string('Unable to create personal data export folder.'),
			]),
		])
	}
	var_index_pathname = rt.new_string(var_exports_dir.str() + 'index.php')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		var_index_pathname.clone()])))))
	{
		var_file = rt.call_function('fopen', [var_index_pathname.clone(),
			rt.new_string('w')])
		if rt.is_true(rt.identical(rt.new_bool(false), var_file)) {
			rt.call_function('wp_send_json_error', [
				rt.call_function('__', [
					rt.new_string('Unable to protect personal data export folder from browsing.'),
				]),
			])
		}
		rt.call_function('fwrite',
			[var_file.clone(), rt.new_string('<?php\n// Silence is golden.\n')])
		rt.call_function('fclose', [var_file.clone()])
	}
	var_obscura = rt.call_function('wp_generate_password', [rt.new_int(32),
		rt.new_bool(false), rt.new_bool(false)])
	var_file_basename = rt.new_string('wp-personal-data-file-' + var_obscura.str())
	var_html_report_filename = rt.call_function('wp_unique_filename', [
		var_exports_dir.clone(), rt.new_string(var_file_basename.str() + '.html')])
	var_html_report_pathname = rt.call_function('wp_normalize_path', [
		rt.new_string(var_exports_dir.str() + var_html_report_filename.str()),
	])
	var_json_report_filename = rt.new_string(var_file_basename.str() + '.json')
	var_json_report_pathname = rt.call_function('wp_normalize_path', [
		rt.new_string(var_exports_dir.str() + var_json_report_filename.str()),
	])
	var_title = rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Personal Data Export for %s')]),
		var_email_address.clone(),
	])
	var_about_group = {
		'group_label':       rt.call_function('_x', [rt.new_string('About'),
			rt.new_string('personal data group label')])
		'group_description': rt.call_function('_x', [
			rt.new_string('Overview of export report.'),
			rt.new_string('personal data group description'),
		])
		'items':             {
			'about-1': map[string]rt.PhpVal{}
		}
	}
	var_groups = rt.call_function('get_post_meta', [var_request_id.clone(),
		rt.new_string('_export_data_grouped'), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(var_groups.clone().is_array())) {
		var_groups = rt.call_function('array_merge', [
			rt.create_array([rt.ArrayItem{ key: 'about', val: var_about_group }]),
			var_groups.clone(),
		])
		var_groups_count = var_groups.clone().array_count()
	} else {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_groups)))) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('The %s post meta must be an array.'),
					]),
					rt.new_string('<code>_export_data_grouped</code>'),
				]),
				rt.new_string('5.8.0')])
		}
		var_groups = rt.new_null()
		var_groups_count = 0
	}
	var_groups_json = rt.call_function('wp_json_encode', [var_groups.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_groups_json)) {
		var_error_message = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Unable to encode the personal data for export. Error: %s'),
			]),
			rt.call_function('json_last_error_msg', []rt.PhpVal{}),
		])
		rt.call_function('wp_send_json_error', [var_error_message.clone()])
	}
	var_file = rt.call_function('fopen', [var_json_report_pathname.clone(),
		rt.new_string('w')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_file)) {
		rt.call_function('wp_send_json_error', [
			rt.call_function('__', [
				rt.new_string('Unable to open personal data export file (JSON report) for writing.'),
			]),
		])
	}
	rt.call_function('fwrite', [var_file.clone(), rt.new_string('{')])
	rt.call_function('fwrite', [var_file.clone(), rt.new_string('"' + var_title.str() + '":')])
	rt.call_function('fwrite', [var_file.clone(), var_groups_json.clone()])
	rt.call_function('fwrite', [var_file.clone(), rt.new_string('}')])
	rt.call_function('fclose', [var_file.clone()])
	var_file = rt.call_function('fopen', [var_html_report_pathname.clone(),
		rt.new_string('w')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_file)) {
		rt.call_function('wp_send_json_error', [
			rt.call_function('__', [
				rt.new_string('Unable to open personal data export (HTML report) for writing.'),
			]),
		])
	}
	rt.call_function('fwrite', [var_file.clone(), rt.new_string('<!DOCTYPE html>\n')])
	rt.call_function('fwrite', [var_file.clone(), rt.new_string('<html>\n')])
	rt.call_function('fwrite', [var_file.clone(), rt.new_string('<head>\n')])
	rt.call_function('fwrite', [var_file.clone(),
		rt.new_string("<meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />\n")])
	rt.call_function('fwrite', [var_file.clone(), rt.new_string('<style>')])
	rt.call_function('fwrite', [var_file.clone(),
		rt.new_string('body { color: black; font-family: Arial, sans-serif; font-size: 11pt; margin: 15px auto; width: 860px; }')])
	rt.call_function('fwrite', [var_file.clone(),
		rt.new_string('table { background: #f0f0f0; border: 1px solid #ddd; margin-bottom: 20px; width: 100%; }')])
	rt.call_function('fwrite', [var_file.clone(),
		rt.new_string('th { padding: 5px; text-align: left; width: 20%; }')])
	rt.call_function('fwrite', [var_file.clone(), rt.new_string('td { padding: 5px; }')])
	rt.call_function('fwrite', [var_file.clone(),
		rt.new_string('tr:nth-child(odd) { background-color: #fafafa; }')])
	rt.call_function('fwrite',
		[var_file.clone(), rt.new_string('.return-to-top { text-align: right; }')])
	rt.call_function('fwrite', [var_file.clone(), rt.new_string('</style>')])
	rt.call_function('fwrite', [var_file.clone(), rt.new_string('<title>')])
	rt.call_function('fwrite', [var_file.clone(), rt.call_function('esc_html', [
		var_title.clone(),
	])])
	rt.call_function('fwrite', [var_file.clone(), rt.new_string('</title>')])
	rt.call_function('fwrite', [var_file.clone(), rt.new_string('</head>\n')])
	rt.call_function('fwrite', [var_file.clone(), rt.new_string('<body>\n')])
	rt.call_function('fwrite', [var_file.clone(),
		rt.new_string('<h1 id="top">' +
			(rt.call_function('esc_html__', [rt.new_string('Personal Data Export')])).str() +
			'</h1>')])
	if var_groups_count > 1 {
		rt.call_function('fwrite',
			[var_file.clone(), rt.new_string('<div id="table_of_contents">')])
		rt.call_function('fwrite', [var_file.clone(),
			rt.new_string('<h2>' +
				(rt.call_function('esc_html__', [rt.new_string('Table of Contents')])).str() +
				'</h2>')])
		rt.call_function('fwrite', [var_file.clone(), rt.new_string('<ul>')])
		mut iter_4 := rt.cast_array(var_groups).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_group_data_shadow := item_4.val
			mut var_group_id_shadow := item_4.key
			var_group_label = rt.call_function('esc_html', [var_group_data_shadow['group_label']])
			var_group_id_attr = rt.call_function('sanitize_title_with_dashes', [
				rt.new_string(
					(var_group_data_shadow['group_label']).str() + '-' + var_group_id_shadow.str()),
			])
			var_group_items_count = rt.cast_array(var_group_data_shadow['items']).array_count()
			if var_group_items_count > 1 {
				var_group_label = rt.concat(var_group_label, rt.call_function('sprintf', [
					rt.new_string(' <span class="count">(%d)</span>'),
					rt.new_int(var_group_items_count).clone(),
				]))
			}
			rt.call_function('fwrite', [var_file.clone(), rt.new_string('<li>')])
			rt.call_function('fwrite', [var_file.clone(),
				rt.new_string('<a href="#' +
					(rt.call_function('esc_attr', [var_group_id_attr.clone()])).str() + '">' +
					var_group_label.str() + '</a>')])
			rt.call_function('fwrite', [var_file.clone(), rt.new_string('</li>')])
		}
		rt.call_function('fwrite', [var_file.clone(), rt.new_string('</ul>')])
		rt.call_function('fwrite', [var_file.clone(), rt.new_string('</div>')])
	}
	mut iter_5 := rt.cast_array(var_groups).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_group_data_shadow := item_5.val
		mut var_group_id_shadow := item_5.key
		rt.call_function('fwrite', [var_file.clone(),
			wp_privacy_generate_personal_data_export_group_html(var_group_data_shadow.clone(),
				var_group_id_shadow.clone(), var_groups_count)])
	}
	rt.call_function('fwrite', [var_file.clone(), rt.new_string('</body>\n')])
	rt.call_function('fwrite', [var_file.clone(), rt.new_string('</html>\n')])
	rt.call_function('fclose', [var_file.clone()])
	var_error = rt.new_bool(false)
	var_archive_filename = rt.call_function('get_post_meta', [
		var_request_id.clone(), rt.new_string('_export_file_name'),
		rt.new_bool(true)])
	var_archive_pathname = rt.call_function('get_post_meta', [
		var_request_id.clone(), rt.new_string('_export_file_path'),
		rt.new_bool(true)])
	if !(!rt.is_true(var_archive_filename)) {
		var_archive_pathname = rt.new_string(var_exports_dir.str() + var_archive_filename.str())
	} else if !(!rt.is_true(var_archive_pathname)) {
		var_archive_filename = rt.call_function('basename', [
			var_archive_pathname.clone()])
		rt.call_function('update_post_meta', [var_request_id.clone(),
			rt.new_string('_export_file_name'), var_archive_filename.clone()])
		rt.call_function('delete_post_meta', [var_request_id.clone(),
			rt.new_string('_export_file_url')])
		rt.call_function('delete_post_meta', [var_request_id.clone(),
			rt.new_string('_export_file_path')])
	} else {
		var_archive_filename = rt.new_string(var_file_basename.str() + '.zip')
		var_archive_pathname = rt.new_string(var_exports_dir.str() + var_archive_filename.str())
		rt.call_function('update_post_meta', [var_request_id.clone(),
			rt.new_string('_export_file_name'), var_archive_filename.clone()])
	}
	var_archive_url = rt.new_string(var_exports_url.str() + var_archive_filename.str())
	if !(!rt.is_true(var_archive_pathname))
		&& rt.is_true(rt.call_function('file_exists', [var_archive_pathname.clone()])) {
		rt.call_function('wp_delete_file', [var_archive_pathname.clone()])
	}
	var_zip = create_ziparchive()
	if rt.is_true(rt.identical(rt.new_bool(true), var_zip.open(var_archive_pathname.clone(),
		Class_ZipArchive.create())))
	{
		if rt.is_true(rt.new_bool(!(rt.is_true(var_zip.addfile(var_json_report_pathname.clone(),
			rt.new_string('export.json'))))))
		{
			var_error = rt.call_function('__', [
				rt.new_string('Unable to archive the personal data export file (JSON format).'),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_zip.addfile(var_html_report_pathname.clone(),
			rt.new_string('index.html'))))))
		{
			var_error = rt.call_function('__', [
				rt.new_string('Unable to archive the personal data export file (HTML format).'),
			])
		}
		var_zip.close()
		if rt.is_true(rt.new_bool(!(rt.is_true(var_error)))) {
			rt.call_function('do_action', [
				rt.new_string('wp_privacy_personal_data_export_file_created'),
				var_archive_pathname.clone(),
				var_archive_url.clone(),
				var_html_report_pathname.clone(),
				var_request_id.clone(),
				var_json_report_pathname.clone(),
			])
		}
	} else {
		var_error = rt.call_function('__', [
			rt.new_string('Unable to open personal data export file (archive) for writing.'),
		])
	}
	rt.call_function('unlink', [var_json_report_pathname.clone()])
	rt.call_function('unlink', [var_html_report_pathname.clone()])
	if rt.is_true(var_error) {
		rt.call_function('wp_send_json_error', [var_error.clone()])
	}
}

fn wp_privacy_send_personal_data_export_email(var_request_id rt.PhpVal) bool {
	mut var_request := rt.new_null()
	mut var_switched_locale := rt.new_null()
	mut var_expiration := rt.new_null()
	mut var_expiration_date := rt.new_null()
	mut var_exports_url := rt.new_null()
	mut var_export_file_name := rt.new_null()
	mut var_export_file_url := rt.new_null()
	mut var_site_name := rt.new_null()
	mut var_site_url := rt.new_null()
	mut var_request_email := rt.new_null()
	mut var_email_data := map[string]rt.PhpVal{}
	mut var_subject := rt.new_null()
	mut var_email_text := rt.new_null()
	mut var_content := rt.new_null()
	mut var_headers := rt.new_null()
	mut var_mail_success := rt.new_null()
	var_request = rt.call_function('wp_get_user_request', [var_request_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_request))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('export_personal_data'), rt.get_property(var_request, 'action_name'))))) {
		return (create_wp_error(rt.new_string('invalid_request'), rt.call_function('__', [
			rt.new_string('Invalid request ID when sending personal data export email.'),
		]))).to_bool()
	}
	if !(!rt.is_true(rt.get_property(var_request, 'user_id'))) {
		var_switched_locale = rt.call_function('switch_to_user_locale', [
			rt.get_property(var_request, 'user_id'),
		])
	} else {
		var_switched_locale = rt.call_function('switch_to_locale', [
			rt.call_function('get_locale', []rt.PhpVal{}),
		])
	}
	var_expiration = rt.call_function('apply_filters', [
		rt.new_string('wp_privacy_export_expiration'),
		rt.mul(rt.new_int(3), rt.get_constant('DAY_IN_SECONDS')),
	])
	var_expiration_date = rt.call_function('date_i18n', [
		rt.call_function('get_option', [rt.new_string('date_format')]),
		rt.add(rt.call_function('time', []rt.PhpVal{}), var_expiration),
	])
	var_exports_url = rt.call_function('wp_privacy_exports_url', []rt.PhpVal{})
	var_export_file_name = rt.call_function('get_post_meta', [
		var_request_id.clone(), rt.new_string('_export_file_name'),
		rt.new_bool(true)])
	var_export_file_url = rt.new_string(var_exports_url.str() + var_export_file_name.str())
	var_site_name = rt.call_function('wp_specialchars_decode', [
		rt.call_function('get_option', [rt.new_string('blogname')]),
		rt.get_constant('ENT_QUOTES'),
	])
	var_site_url = rt.call_function('home_url', []rt.PhpVal{})
	var_request_email = rt.call_function('apply_filters', [
		rt.new_string('wp_privacy_personal_data_email_to'),
		rt.get_property(var_request, 'email'),
		var_request.clone(),
	])
	var_email_data = {
		'request':           var_request
		'expiration':        var_expiration
		'expiration_date':   var_expiration_date
		'message_recipient': var_request_email
		'export_file_url':   var_export_file_url
		'sitename':          var_site_name
		'siteurl':           var_site_url
	}
	var_subject = rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('[%s] Personal Data Export')]),
		var_site_name.clone(),
	])
	var_subject = rt.call_function('apply_filters', [
		rt.new_string('wp_privacy_personal_data_email_subject'),
		var_subject.clone(),
		var_site_name.clone(),
		rt.create_array_from_native_map(var_email_data),
	])
	var_email_text = rt.call_function('__', [
		rt.new_string('Howdy,\n\nYour request for an export of personal data has been completed. You may\ndownload your personal data by clicking on the link below. For privacy\nand security, we will automatically delete the file on ###EXPIRATION###,\nso please download it before then.\n\n###LINK###\n\nRegards,\nAll at ###SITENAME###\n###SITEURL###'),
	])
	var_content = rt.call_function('apply_filters', [
		rt.new_string('wp_privacy_personal_data_email_content'),
		var_email_text.clone(),
		var_request_id.clone(),
		rt.create_array_from_native_map(var_email_data),
	])
	var_content = rt.call_function('str_replace', [rt.new_string('###EXPIRATION###'),
		var_expiration_date.clone(), var_content.clone()])
	var_content = rt.call_function('str_replace', [rt.new_string('###LINK###'),
		rt.call_function('sanitize_url', [var_export_file_url.clone()]),
		var_content.clone()])
	var_content = rt.call_function('str_replace', [rt.new_string('###EMAIL###'),
		var_request_email.clone(), var_content.clone()])
	var_content = rt.call_function('str_replace', [rt.new_string('###SITENAME###'),
		var_site_name.clone(), var_content.clone()])
	var_content = rt.call_function('str_replace', [rt.new_string('###SITEURL###'),
		rt.call_function('sanitize_url', [var_site_url.clone()]),
		var_content.clone()])
	var_headers = rt.new_string('')
	var_headers = rt.call_function('apply_filters', [
		rt.new_string('wp_privacy_personal_data_email_headers'),
		var_headers.clone(),
		var_subject.clone(),
		var_content.clone(),
		var_request_id.clone(),
		rt.create_array_from_native_map(var_email_data),
	])
	var_mail_success = rt.call_function('wp_mail', [var_request_email.clone(),
		var_subject.clone(), var_content.clone(), var_headers.clone()])
	if rt.is_true(var_switched_locale) {
		rt.call_function('restore_previous_locale', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_mail_success)))) {
		return (create_wp_error(rt.new_string('privacy_email_error'), rt.call_function('__', [
			rt.new_string('Unable to send personal data export email.'),
		]))).to_bool()
	}
	return true
}

fn wp_privacy_process_personal_data_export_page(var_response rt.PhpVal, var_exporter_index rt.PhpVal, var_email_address rt.PhpVal, var_page rt.PhpVal, var_request_id rt.PhpVal, var_send_as_email rt.PhpVal, var_exporter_key rt.PhpVal) rt.PhpVal {
	mut var_request := rt.new_null()
	mut var_export_data := rt.new_null()
	mut var_accumulated_data := rt.new_null()
	mut var_exporters := rt.new_null()
	mut var_is_last_exporter := false
	mut var_exporter_done := rt.new_null()
	mut var_groups := rt.new_null()
	mut var_export_datum := map[string]rt.PhpVal{}
	mut var_group_id := rt.new_null()
	mut var_group_label := rt.new_null()
	mut var_group_description := rt.new_null()
	mut var_item_id := rt.new_null()
	mut var_old_item_data := rt.new_null()
	mut var_merged_item_data := rt.new_null()
	mut var_mail_success := false
	mut var_exports_url := rt.new_null()
	mut var_export_file_name := rt.new_null()
	mut var_export_file_url := rt.new_null()
	if !(rt.create_array_from_native_map(var_response).is_array()) {
		return var_response.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_response).array_isset(rt.new_string('done'))))))) {
		return var_response.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_response).array_isset(rt.new_string('data'))))))) {
		return var_response.clone()
	}
	if !(var_response.array_get(rt.new_string('data')).is_array()) {
		return var_response.clone()
	}
	var_request = rt.call_function('wp_get_user_request', [var_request_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_request))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('export_personal_data'), rt.get_property(var_request, 'action_name'))))) {
		rt.call_function('wp_send_json_error', [
			rt.call_function('__', [
				rt.new_string('Invalid request ID when merging personal data to export.'),
			]),
		])
	}
	var_export_data = rt.new_array()
	if rt.is_true(rt.identical(rt.new_int(1), var_exporter_index))
		&& rt.is_true(rt.identical(rt.new_int(1), var_page)) {
		rt.call_function('update_post_meta', [var_request_id.clone(),
			rt.new_string('_export_data_raw'), var_export_data.clone()])
	} else {
		var_accumulated_data = rt.call_function('get_post_meta', [
			var_request_id.clone(), rt.new_string('_export_data_raw'),
			rt.new_bool(true)])
		if rt.is_true(var_accumulated_data) {
			var_export_data = var_accumulated_data.clone()
		}
	}
	var_export_data = rt.call_function('array_merge', [var_export_data.clone(),
		var_response.array_get(rt.new_string('data'))])
	rt.call_function('update_post_meta', [var_request_id.clone(),
		rt.new_string('_export_data_raw'), var_export_data.clone()])
	var_exporters = rt.call_function('apply_filters', [
		rt.new_string('wp_privacy_personal_data_exporters'),
		rt.new_array(),
	])
	var_is_last_exporter = (rt.identical(rt.new_int(var_exporters.clone().array_count()),
		var_exporter_index)).to_bool()
	var_exporter_done = var_response.array_get(rt.new_string('done'))
	if !var_is_last_exporter || rt.is_true(rt.new_bool(!(rt.is_true(var_exporter_done)))) {
		return var_response.clone()
	}
	var_groups = rt.new_array()
	mut iter_6 := rt.cast_array(var_export_data).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_export_datum_shadow := item_6.val
		var_group_id = var_export_datum_shadow['group_id']
		var_group_label = var_export_datum_shadow['group_label']
		var_group_description = rt.new_string('')
		if !(!rt.is_true(var_export_datum_shadow['group_description'])) {
			var_group_description = var_export_datum_shadow['group_description']
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_groups.clone().array_isset(var_group_id.clone())))))) {
			var_groups.array_set(var_group_id, rt.create_array([
				rt.ArrayItem{ key: 'group_label', val: var_group_label },
				rt.ArrayItem{ key: 'group_description', val: var_group_description },
				rt.ArrayItem{ key: 'items', val: rt.new_array() },
			]))
		}
		var_item_id = var_export_datum_shadow['item_id']
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_groups.array_get(var_group_id).array_get(rt.new_string('items')).array_isset(var_item_id.clone())))))) {
			var_groups.array_get_mut(var_group_id).array_get_mut('items').array_set(var_item_id,
				rt.new_array())
		}
		var_old_item_data =
			var_groups.array_get(var_group_id).array_get(rt.new_string('items')).array_get(var_item_id)
		var_merged_item_data = rt.call_function('array_merge', [var_export_datum_shadow['data'],
			var_old_item_data.clone()])
		var_groups.array_get_mut(var_group_id).array_get_mut('items').array_set(var_item_id,
			var_merged_item_data.clone())
	}
	rt.call_function('delete_post_meta', [var_request_id.clone(),
		rt.new_string('_export_data_raw')])
	rt.call_function('update_post_meta', [var_request_id.clone(),
		rt.new_string('_export_data_grouped'), var_groups.clone()])
	rt.call_function('do_action', [rt.new_string('wp_privacy_personal_data_export_file'),
		var_request_id.clone()])
	rt.call_function('delete_post_meta', [var_request_id.clone(),
		rt.new_string('_export_data_grouped')])
	if rt.is_true(var_send_as_email) {
		var_mail_success = wp_privacy_send_personal_data_export_email(var_request_id.clone())
		if rt.is_true(rt.call_function('is_wp_error', [rt.new_bool(var_mail_success).clone()])) {
			rt.call_function('wp_send_json_error', [
				rt.call_method(rt.new_bool(var_mail_success), 'get_error_message', []rt.PhpVal{}),
			])
		}
		_wp_privacy_completed_request(var_request_id.clone())
	} else {
		var_exports_url = rt.call_function('wp_privacy_exports_url', []rt.PhpVal{})
		var_export_file_name = rt.call_function('get_post_meta', [
			var_request_id.clone(), rt.new_string('_export_file_name'),
			rt.new_bool(true)])
		var_export_file_url = rt.new_string(var_exports_url.str() + var_export_file_name.str())
		if !(!rt.is_true(var_export_file_url)) {
			var_response['url'] = var_export_file_url.clone()
		}
	}
	return var_response.clone()
}

fn wp_privacy_process_personal_data_erasure_page(var_response rt.PhpVal, var_eraser_index rt.PhpVal, var_email_address rt.PhpVal, var_page rt.PhpVal, var_request_id rt.PhpVal) rt.PhpVal {
	mut var_request := rt.new_null()
	mut var_erasers := rt.new_null()
	mut var_is_last_eraser := false
	mut var_eraser_done := rt.new_null()
	if !(rt.create_array_from_native_map(var_response).is_array()) {
		return var_response.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_response).array_isset(rt.new_string('done'))))))) {
		return var_response.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_response).array_isset(rt.new_string('items_removed'))))))) {
		return var_response.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_response).array_isset(rt.new_string('items_retained'))))))) {
		return var_response.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_response).array_isset(rt.new_string('messages'))))))) {
		return var_response.clone()
	}
	var_request = rt.call_function('wp_get_user_request', [var_request_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_request))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('remove_personal_data'), rt.get_property(var_request, 'action_name'))))) {
		rt.call_function('wp_send_json_error', [
			rt.call_function('__', [
				rt.new_string('Invalid request ID when processing personal data to erase.'),
			]),
		])
	}
	var_erasers = rt.call_function('apply_filters', [
		rt.new_string('wp_privacy_personal_data_erasers'),
		rt.new_array(),
	])
	var_is_last_eraser = (rt.identical(rt.new_int(var_erasers.clone().array_count()),
		var_eraser_index)).to_bool()
	var_eraser_done = var_response.array_get(rt.new_string('done'))
	if !var_is_last_eraser || rt.is_true(rt.new_bool(!(rt.is_true(var_eraser_done)))) {
		return var_response.clone()
	}
	_wp_privacy_completed_request(var_request_id.clone())
	rt.call_function('do_action', [rt.new_string('wp_privacy_personal_data_erased'),
		var_request_id.clone()])
	return var_response.clone()
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

struct Class_ZipArchive {
	rt.PhpObjectBase
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_ziparchive(_args ...rt.PhpVal) &Class_ZipArchive {
	mut obj := &Class_ZipArchive{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ZipArchive) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ZipArchive) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ZipArchive) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
