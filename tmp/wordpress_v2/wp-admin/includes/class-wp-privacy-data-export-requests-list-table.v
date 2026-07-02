import rt

struct Class_WP_Privacy_Data_Export_Requests_List_Table {
	rt.PhpObjectBase
pub mut:
	request_type rt.PhpVal = rt.new_string('export_personal_data')
	post_type    rt.PhpVal = rt.new_string('user_request')
}

fn (mut this Class_WP_Privacy_Data_Export_Requests_List_Table) column_email(var_item rt.PhpVal) rt.PhpVal {
	mut var_row_actions := map[string]rt.PhpVal{}
	mut var_exporters := rt.call_function('apply_filters', [
		rt.new_string('wp_privacy_personal_data_exporters'),
		rt.new_array(),
	])
	mut var_exporters_count := rt.new_int(var_exporters.clone().array_count())
	mut var_status := rt.get_property(var_item, 'status')
	mut var_request_id := rt.get_property(var_item, 'ID')
	mut var_nonce := rt.call_function('wp_create_nonce', [
		rt.new_string('wp-privacy-export-personal-data-' + var_request_id.str()),
	])
	mut var_download_data_markup := rt.new_string('<span class="export-personal-data" ' +
		'data-exporters-count="' +
		(rt.call_function('esc_attr', [var_exporters_count.clone()])).str() + '" ' +
		'data-request-id="' + (rt.call_function('esc_attr', [var_request_id.clone()])).str() +
		'" ' + 'data-nonce="' + (rt.call_function('esc_attr', [var_nonce.clone()])).str() + '">')
	var_download_data_markup = rt.concat(var_download_data_markup, rt.new_string(
		'<span class="export-personal-data-idle"><button type="button" class="button-link export-personal-data-handle">' +
		(rt.call_function('__', [rt.new_string('Download personal data')])).str() +
		'</button></span>' + '<span class="export-personal-data-processing hidden">' +
		(rt.call_function('__', [rt.new_string('Downloading data...')])).str() +
		' <span class="export-progress"></span></span>' +
		'<span class="export-personal-data-success hidden"><button type="button" class="button-link export-personal-data-handle">' +
		(rt.call_function('__', [rt.new_string('Download personal data again')])).str() +
		'</button></span>' + '<span class="export-personal-data-failed hidden">' +
		(rt.call_function('__', [rt.new_string('Download failed.')])).str() +
		' <button type="button" class="button-link export-personal-data-handle">' +
		(rt.call_function('__', [rt.new_string('Retry')])).str() + '</button></span>'))
	var_download_data_markup = rt.concat(var_download_data_markup, rt.new_string('</span>'))
	var_row_actions['download-data'] = var_download_data_markup.clone()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('request-completed'),
		var_status))))
	{
		mut var_complete_request_markup := rt.new_string('<span>')
		var_complete_request_markup = rt.concat(var_complete_request_markup, rt.call_function('sprintf', [
			rt.new_string('<a href="%s" class="complete-request" aria-label="%s">%s</a>'),
			rt.call_function('esc_url', [
				rt.call_function('wp_nonce_url', [
					rt.call_function('add_query_arg', [
						rt.create_array([rt.ArrayItem{ key: 'action', val: 'complete' },
							rt.ArrayItem{ key: 'request_id', val: rt.create_array([
								rt.ArrayItem{ key: none, val: var_request_id },
							]) }]),
						rt.call_function('admin_url', [rt.new_string('export-personal-data.php')]),
					]),
					rt.new_string('bulk-privacy_requests'),
				]),
			]),
			rt.call_function('esc_attr', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Mark export request for &#8220;%s&#8221; as completed.'),
					]),
					rt.get_property(var_item, 'email'),
				]),
			]),
			rt.call_function('__', [
				rt.new_string('Complete request'),
			]),
		]))
		var_complete_request_markup = rt.concat(var_complete_request_markup,
			rt.new_string('</span>'))
	}
	if !(!rt.is_true(var_complete_request_markup)) {
		var_row_actions['complete-request'] = var_complete_request_markup.clone()
	}
	return rt.call_function('sprintf', [rt.new_string('<a href="%1$s">%2$s</a> %3$s'),
		rt.call_function('esc_url', [
			rt.new_string('mailto:' + (rt.get_property(var_item, 'email')).str()),
		]),
		rt.get_property(var_item, 'email'), this.row_actions(var_row_actions.clone())])
}

fn (mut this Class_WP_Privacy_Data_Export_Requests_List_Table) column_next_steps(var_item rt.PhpVal) {
	mut var_status := rt.get_property(var_item, 'status')
	mut switch_val_1 := var_status
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('request-pending'))) {
		rt.call_function('esc_html_e', [rt.new_string('Waiting for confirmation')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('request-confirmed'))) {
		mut var_exporters := rt.call_function('apply_filters', [
			rt.new_string('wp_privacy_personal_data_exporters'),
			rt.new_array(),
		])
		mut var_exporters_count := rt.new_int(var_exporters.clone().array_count())
		mut var_request_id := rt.get_property(var_item, 'ID')
		mut var_nonce := rt.call_function('wp_create_nonce', [
			rt.new_string('wp-privacy-export-personal-data-' + var_request_id.str()),
		])
		print('<div class="export-personal-data" ' + 'data-send-as-email="1" ' +
			'data-exporters-count="' +
			(rt.call_function('esc_attr', [var_exporters_count.clone()])).str() + '" ' +
			'data-request-id="' + (rt.call_function('esc_attr', [var_request_id.clone()])).str() +
			'" ' + 'data-nonce="' + (rt.call_function('esc_attr', [var_nonce.clone()])).str() + '">')
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Send export link')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Sending email...')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Email sent.')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Email could not be sent.')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Retry')])
		// unsupported statement: Stmt_InlineHTML
		print('</div>')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('request-failed'))) {
		print('<button type="submit" class="button-link" name="privacy_action_email_retry[' +
			(rt.get_property(var_item, 'ID')).str() + ']" id="privacy_action_email_retry[' +
			(rt.get_property(var_item, 'ID')).str() + ']">' +
			(rt.call_function('__', [rt.new_string('Retry')])).str() + '</button>')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('request-completed'))) {
		print('<a href="' +
			(rt.call_function('esc_url', [rt.call_function('wp_nonce_url', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{
			key: 'action'
			val: 'delete'
		}, rt.ArrayItem{ key: 'request_id', val: rt.create_array([rt.ArrayItem{
			key: none
			val: rt.get_property(var_item, 'ID')
		}]) }]), rt.call_function('admin_url', [rt.new_string('export-personal-data.php')])]), rt.new_string('bulk-privacy_requests')])])).str() +
			'">' + (rt.call_function('esc_html__', [rt.new_string('Remove request')])).str() +
			'</a>')
	}
}

struct Class_WP_Privacy_Requests_Table {
	rt.PhpObjectBase
}

fn create_wp_privacy_data_export_requests_list_table(_args ...rt.PhpVal) &Class_WP_Privacy_Data_Export_Requests_List_Table {
	mut obj := &Class_WP_Privacy_Data_Export_Requests_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
		request_type:  rt.new_string('export_personal_data')
		post_type:     rt.new_string('user_request')
	}
	return obj
}

fn create_wp_privacy_requests_table(_args ...rt.PhpVal) &Class_WP_Privacy_Requests_Table {
	mut obj := &Class_WP_Privacy_Requests_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Privacy_Data_Export_Requests_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'column_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.column_email(dispatch_arg_0)
		}
		'column_next_steps' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_next_steps(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Privacy_Data_Export_Requests_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'request_type' { return this.request_type }
		'post_type' { return this.post_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Privacy_Data_Export_Requests_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'request_type' {
			this.request_type = val
			return true
		}
		'post_type' {
			this.post_type = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Privacy_Requests_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Privacy_Requests_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Privacy_Requests_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WP_Privacy_Requests_Table'),
	])))))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-privacy-requests-table.php',
			'4')
	}
}
