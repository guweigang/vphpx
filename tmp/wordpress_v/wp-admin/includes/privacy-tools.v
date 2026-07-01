import rt

fn _wp_privacy_resend_request(var_request_id rt.PhpVal) bool {
	var_request_id = rt.call_function('absint', [var_request_id.dup()])
	mut var_request := rt.call_function('get_post', [var_request_id.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_request)))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return (create_wp_error(rt.new_string('privacy_request_error'), rt.call_function('__', [rt.new_string('Invalid personal data request.')]))).to_bool()
	}
	mut var_result := rt.call_function('wp_send_user_request', [var_request_id.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
		return (var_result).to_bool()
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return (create_wp_error(rt.new_string('privacy_request_error'), rt.call_function('__', [rt.new_string('Unable to initiate confirmation for personal data request.')]))).to_bool()
	}
	return true
}

fn _wp_privacy_completed_request(var_request_id rt.PhpVal) rt.PhpVal {
	var_request_id = rt.call_function('absint', [var_request_id.dup()])
	mut var_request := rt.call_function('wp_get_user_request', [var_request_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_request)))) {
		return create_wp_error(rt.new_string('privacy_request_error'), rt.call_function('__', [rt.new_string('Invalid personal data request.')]))
	}
	rt.call_function('update_post_meta', [var_request_id.dup(), rt.new_string('_wp_user_request_completed_timestamp'), rt.call_function('time', []rt.PhpVal{})])
	mut var_result := rt.call_function('wp_update_post', [rt.create_array([rt.ArrayItem{ key: 'ID', val: var_request_id }, rt.ArrayItem{ key: 'post_status', val: 'request-completed' }])])
	return var_result.dup()
}

fn _wp_personal_data_handle_actions() {
	if rt.get_superglobal('_POST').array_isset(rt.new_string('privacy_action_email_retry')) {
		rt.call_function('check_admin_referer', [rt.new_string('bulk-privacy_requests')])
		mut var_request_id := rt.call_function('absint', [rt.call_function('current', [rt.func_array_keys(rt.cast_array(rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('privacy_action_email_retry')])))])])
		mut var_result := _wp_privacy_resend_request(var_request_id.dup())
		if rt.is_true(rt.call_function('is_wp_error', [rt.new_bool(var_result).dup()])) {
			rt.call_function('add_settings_error', [rt.new_string('privacy_action_email_retry'), rt.new_string('privacy_action_email_retry'), rt.call_method(rt.new_bool(var_result), 'get_error_message', []rt.PhpVal{}), rt.new_string('error')])
		} else {
			rt.call_function('add_settings_error', [rt.new_string('privacy_action_email_retry'), rt.new_string('privacy_action_email_retry'), rt.call_function('__', [rt.new_string('Confirmation request sent again successfully.')]), rt.new_string('success')])
		}
	} else if rt.get_superglobal('_POST').array_isset(rt.new_string('action')) {
		mut var_action := if !(!rt.is_true(rt.get_superglobal('_POST').array_get('action'))) { rt.call_function('sanitize_key', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('action')])]) } else { rt.new_string('') }
		mut switch_val_1 := var_action
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('add_export_personal_data_request'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('add_remove_personal_data_request'))) {
			rt.call_function('check_admin_referer', [rt.new_string('personal-data-request')])
			if !(rt.get_superglobal('_POST').array_isset(rt.new_string('type_of_action')) && rt.get_superglobal('_POST').array_isset(rt.new_string('username_or_email_for_privacy_request'))) {
				rt.call_function('add_settings_error', [rt.new_string('action_type'), rt.new_string('action_type'), rt.call_function('__', [rt.new_string('Invalid personal data action.')]), rt.new_string('error')])
			}
			mut var_action_type := rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('type_of_action')])])
			mut var_username_or_email_address := rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('username_or_email_for_privacy_request')])])
			mut var_email_address := rt.new_string(rt.new_string(''))
			mut var_status := rt.new_string(rt.new_string('pending'))
			if !(rt.get_superglobal('_POST').array_isset(rt.new_string('send_confirmation_email'))) {
				var_status = rt.new_string(rt.new_string('confirmed'))
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_action_type.dup(), rt.call_function('_wp_privacy_action_request_types', []rt.PhpVal{}), rt.new_bool(true)]))))) {
				rt.call_function('add_settings_error', [rt.new_string('action_type'), rt.new_string('action_type'), rt.call_function('__', [rt.new_string('Invalid personal data action.')]), rt.new_string('error')])
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [var_username_or_email_address.dup()]))))) {
				mut var_user := rt.call_function('get_user_by', [rt.new_string('login'), var_username_or_email_address.dup()])
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_user, 'WP_User')))))) {
					rt.call_function('add_settings_error', [rt.new_string('username_or_email_for_privacy_request'), rt.new_string('username_or_email_for_privacy_request'), rt.call_function('__', [rt.new_string('Unable to add this request. A valid email address or username must be supplied.')]), rt.new_string('error')])
				} else {
					var_email_address = rt.get_property(var_user, 'user_email')
				}
			} else {
				var_email_address = var_username_or_email_address.dup()
			}
			if !rt.is_true(var_email_address) {
				break
			}
			var_request_id = rt.call_function('wp_create_user_request', [var_email_address.dup(), var_action_type.dup(), rt.new_array(), var_status.dup()])
			mut var_message := rt.new_string(rt.new_string(''))
			if rt.is_true(rt.call_function('is_wp_error', [var_request_id.dup()])) {
				var_message = rt.call_method(var_request_id, 'get_error_message', []rt.PhpVal{})
			} else if rt.is_true(rt.new_bool(!(rt.is_true(var_request_id)))) {
				var_message = rt.call_function('__', [rt.new_string('Unable to initiate confirmation request.')])
			}
			if rt.is_true(var_message) {
				rt.call_function('add_settings_error', [rt.new_string('username_or_email_for_privacy_request'), rt.new_string('username_or_email_for_privacy_request'), var_message.dup(), rt.new_string('error')])
				break
			}
			if rt.is_true(rt.identical(rt.new_string('pending'), var_status)) {
				rt.call_function('wp_send_user_request', [var_request_id.dup()])
				var_message = rt.call_function('__', [rt.new_string('Confirmation request initiated successfully.')])
			} else if rt.is_true(rt.identical(rt.new_string('confirmed'), var_status)) {
				var_message = rt.call_function('__', [rt.new_string('Request added successfully.')])
			}
			if rt.is_true(var_message) {
				rt.call_function('add_settings_error', [rt.new_string('username_or_email_for_privacy_request'), rt.new_string('username_or_email_for_privacy_request'), var_message.dup(), rt.new_string('success')])
				break
			}
		}
	}
}

fn _wp_personal_data_cleanup_requests() {
	mut var_expires := // unsupported expression: Expr_Cast_Int
	mut var_requests_query := create_wp_query(rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'user_request' }, rt.ArrayItem{ key: 'posts_per_page', val: // unsupported expression: Expr_UnaryMinus }, rt.ArrayItem{ key: 'post_status', val: 'request-pending' }, rt.ArrayItem{ key: 'fields', val: 'ids' }, rt.ArrayItem{ key: 'date_query', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'column', val: 'post_modified_gmt' }, rt.ArrayItem{ key: 'before', val: (var_expires).str() + ' seconds ago' }]) }]) }]))
	mut var_request_ids := rt.get_property(var_requests_query, 'posts')
	{
		mut iter_1 := var_request_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_request_id := item_1.val
			rt.call_function('wp_update_post', [rt.create_array([rt.ArrayItem{ key: 'ID', val: var_request_id }, rt.ArrayItem{ key: 'post_status', val: 'request-failed' }, rt.ArrayItem{ key: 'post_password', val: '' }])])
		}
	}
}

fn wp_privacy_generate_personal_data_export_group_html(var_group_data rt.PhpVal, group_id string, groups_count i64) rt.PhpVal {
	mut var_group_id_attr := rt.call_function('sanitize_title_with_dashes', [(var_group_data.array_get('group_label')).str() + '-' + group_id])
	mut var_group_html := rt.new_string('<h2 id="' + (rt.call_function('esc_attr', [var_group_id_attr.dup()])).str() + '">')
	// unsupported expression: Expr_AssignOp_Concat
	mut var_items_count := rt.cast_array(var_group_data.array_get('items')).array_count()
	if var_items_count > 1 {
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	if !(!rt.is_true(var_group_data.array_get('group_description'))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	{
		mut iter_1 := rt.cast_array(var_group_data.array_get('items')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_group_item_data := item_1.val
			mut var_group_item_id := item_1.key
			// unsupported expression: Expr_AssignOp_Concat
			// unsupported expression: Expr_AssignOp_Concat
			{
				mut iter_2 := rt.cast_array(var_group_item_data).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_group_item_datum := item_2.val
					mut var_value := var_group_item_datum.array_get('value')
					if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_value.dup(), rt.new_string(' ')]))))) && rt.is_true(rt.new_bool(rt.is_true(rt.call_function('str_starts_with', [var_value.dup(), rt.new_string('http://')])) || rt.is_true(rt.call_function('str_starts_with', [var_value.dup(), rt.new_string('https://')])))))) {
						var_value = rt.new_string('<a href="' + (rt.call_function('esc_url', [var_value.dup()])).str() + '">' + (rt.call_function('esc_html', [var_value.dup()])).str() + '</a>')
					}
					// unsupported expression: Expr_AssignOp_Concat
					// unsupported expression: Expr_AssignOp_Concat
					// unsupported expression: Expr_AssignOp_Concat
					// unsupported expression: Expr_AssignOp_Concat
				}
			}
			// unsupported expression: Expr_AssignOp_Concat
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	if groups_count > 1 {
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	return var_group_html.dup()
}

fn wp_privacy_generate_personal_data_export_file(var_request_id rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('ZipArchive')]))))) {
		rt.call_function('wp_send_json_error', [rt.call_function('__', [rt.new_string('Unable to generate personal data export file. ZipArchive not available.')])])
	}
	mut var_request := rt.call_function('wp_get_user_request', [var_request_id.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_request)))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.call_function('wp_send_json_error', [rt.call_function('__', [rt.new_string('Invalid request ID when generating personal data export file.')])])
	}
	mut var_email_address := rt.get_property(var_request, 'email')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [var_email_address.dup()]))))) {
		rt.call_function('wp_send_json_error', [rt.call_function('__', [rt.new_string('Invalid email address when generating personal data export file.')])])
	}
	mut var_exports_dir := rt.call_function('wp_privacy_exports_dir', []rt.PhpVal{})
	mut var_exports_url := rt.call_function('wp_privacy_exports_url', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_mkdir_p', [var_exports_dir.dup()]))))) {
		rt.call_function('wp_send_json_error', [rt.call_function('__', [rt.new_string('Unable to create personal data export folder.')])])
	}
	mut var_index_pathname := rt.new_string((var_exports_dir).str() + 'index.php')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_index_pathname.dup()]))))) {
		mut var_file := rt.call_function('fopen', [var_index_pathname.dup(), rt.new_string('w')])
		if rt.is_true(rt.identical(rt.new_bool(false), var_file)) {
			rt.call_function('wp_send_json_error', [rt.call_function('__', [rt.new_string('Unable to protect personal data export folder from browsing.')])])
		}
		rt.call_function('fwrite', [var_file.dup(), rt.new_string('<?php\n// Silence is golden.\n')])
		rt.call_function('fclose', [var_file.dup()])
	}
	mut var_obscura := rt.call_function('wp_generate_password', [rt.new_int(32), rt.new_bool(false), rt.new_bool(false)])
	mut var_file_basename := rt.new_string('wp-personal-data-file-' + (var_obscura).str())
	mut var_html_report_filename := rt.call_function('wp_unique_filename', [var_exports_dir.dup(), (var_file_basename).str() + '.html'])
	mut var_html_report_pathname := rt.call_function('wp_normalize_path', [rt.concat(, )])
	mut var_json_report_filename := rt.new_string(().str() + )
	mut var_json_report_pathname := 
	
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_query() &Class_WP_Query {
	mut obj := &Class_WP_Query{
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




pub fn init_wp_admin_includes_privacy_tools_php() {
}
