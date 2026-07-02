import rt

struct Class_WP_Privacy_Requests_Table {
	rt.PhpObjectBase
pub mut:
	request_type rt.PhpVal = rt.new_string('INVALID')
	post_type    rt.PhpVal = rt.new_string('INVALID')
}

fn (mut this Class_WP_Privacy_Requests_Table) get_columns() rt.PhpVal {
	mut var_columns := {
		'cb':                rt.new_string('<input type="checkbox" />')
		'email':             rt.call_function('__', [rt.new_string('Requester')])
		'status':            rt.call_function('__', [rt.new_string('Status')])
		'created_timestamp': rt.call_function('__', [rt.new_string('Requested')])
		'next_steps':        rt.call_function('__', [rt.new_string('Next steps')])
	}
	return var_columns.clone()
}

fn (mut this Class_WP_Privacy_Requests_Table) get_admin_url() rt.PhpVal {
	mut var_pagenow := rt.call_function('str_replace', [rt.new_string('_'),
		rt.new_string('-'), this.request_type])
	if rt.is_true(rt.identical(rt.new_string('remove-personal-data'), var_pagenow)) {
		var_pagenow = rt.new_string('erase-personal-data')
	}
	return rt.call_function('admin_url', [rt.new_string(var_pagenow.str() + '.php')])
}

fn (mut this Class_WP_Privacy_Requests_Table) get_sortable_columns() rt.PhpVal {
	mut var_desc_first :=
		rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('orderby')))
	return rt.create_array([rt.ArrayItem{ key: 'email', val: 'requester' },
		rt.ArrayItem{ key: 'created_timestamp', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'requested' },
			rt.ArrayItem{ key: none, val: var_desc_first },
		]) }])
}

fn (mut this Class_WP_Privacy_Requests_Table) get_default_primary_column_name() string {
	return 'email'
}

fn (mut this Class_WP_Privacy_Requests_Table) get_request_counts() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_cache_key := rt.new_string((this.post_type).str() + '-' + (this.request_type).str())
	mut var_counts := rt.call_function('wp_cache_get', [var_cache_key.clone(),
		rt.new_string('counts')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_counts)))) {
		return var_counts.clone()
	}
	mut var_results := rt.cast_array(rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT post_status, COUNT( * ) AS num_posts\n\t\t\t\tFROM '), rt.get_property(var_wpdb,
				'posts')),
				rt.new_string('\n\t\t\t\tWHERE post_type = %s\n\t\t\t\tAND post_name = %s\n\t\t\t\tGROUP BY post_status')),
			this.post_type,
			this.request_type,
		]),
		rt.get_constant('ARRAY_A'),
	]))
	var_counts = rt.call_function('array_fill_keys', [
		rt.call_function('get_post_stati', []rt.PhpVal{}),
		rt.new_int(0),
	])
	mut iter_1 := var_results.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_row := item_1.val
		var_counts.array_set(var_row.array_get(rt.new_string('post_status')),
			var_row.array_get(rt.new_string('num_posts')))
	}
	var_counts = rt.array_to_object(var_counts)
	rt.call_function('wp_cache_set', [var_cache_key.clone(), var_counts.clone(),
		rt.new_string('counts')])
	return var_counts.clone()
}

fn (mut this Class_WP_Privacy_Requests_Table) get_views() rt.PhpVal {
	mut var_current_status := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('filter-status')) { rt.call_function('sanitize_text_field', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('filter-status')),
		]) } else { rt.new_string('') }
	mut var_statuses := rt.call_function('_wp_privacy_statuses', []rt.PhpVal{})
	mut var_views := rt.new_array()
	mut var_counts := this.get_request_counts()
	mut var_total_requests := rt.call_function('absint', [
		rt.call_function('array_sum', [rt.cast_array(var_counts)]),
	])
	mut var_admin_url := this.get_admin_url()
	mut var_status_label := rt.call_function('sprintf', [
		rt.call_function('_nx', [rt.new_string('All <span class="count">(%s)</span>'),
			rt.new_string('All <span class="count">(%s)</span>'),
			var_total_requests.clone(), rt.new_string('requests')]),
		rt.call_function('number_format_i18n', [var_total_requests.clone()]),
	])
	var_views.array_set('all', rt.create_array([
		rt.ArrayItem{ key: 'url', val: rt.call_function('esc_url', [
			var_admin_url.clone()]) },
		rt.ArrayItem{ key: 'label', val: var_status_label },
		rt.ArrayItem{ key: 'current', val: rt.new_bool(!rt.is_true(var_current_status)) },
	]))
	mut iter_2 := var_statuses.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_label := item_2.val
		mut var_status := item_2.key
		mut var_post_status := rt.call_function('get_post_status_object', [
			var_status.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post_status)))) {
			continue
		}
		mut var_total_status_requests := rt.call_function('absint', [
			rt.get_property(var_counts, '{"nodeType":"Expr_Variable","line":184,"name":"status"}'),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_total_status_requests)))) {
			continue
		}
		var_status_label = rt.call_function('sprintf', [
			rt.call_function('translate_nooped_plural', [
				rt.get_property(var_post_status, 'label_count'),
				var_total_status_requests.clone(),
			]),
			rt.call_function('number_format_i18n', [
				var_total_status_requests.clone(),
			]),
		])
		mut var_status_link := rt.call_function('add_query_arg', [
			rt.new_string('filter-status'),
			var_status.clone(),
			var_admin_url.clone(),
		])
		var_views.array_set(var_status, rt.create_array([
			rt.ArrayItem{ key: 'url', val: rt.call_function('esc_url', [
				var_status_link.clone()]) },
			rt.ArrayItem{ key: 'label', val: var_status_label },
			rt.ArrayItem{ key: 'current', val: rt.identical(var_status, var_current_status) },
		]))
	}
	return this.get_views_links(var_views.clone())
}

fn (mut this Class_WP_Privacy_Requests_Table) get_bulk_actions() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'resend', val: rt.call_function('__', [
			rt.new_string('Resend confirmation requests'),
		]) },
		rt.ArrayItem{ key: 'complete', val: rt.call_function('__', [
			rt.new_string('Mark requests as completed'),
		]) },
		rt.ArrayItem{ key: 'delete', val: rt.call_function('__', [
			rt.new_string('Delete requests'),
		]) },
	])
}

fn (mut this Class_WP_Privacy_Requests_Table) process_bulk_action() {
	mut var_action := this.current_action()
	mut var_request_ids := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('request_id')) { rt.call_function('wp_parse_id_list', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('request_id'))]),
		]) } else { rt.new_array() }
	if !rt.is_true(var_request_ids) {
		return
	}
	mut var_count := rt.new_int(0)
	mut var_failures := rt.new_int(0)
	rt.call_function('check_admin_referer', [rt.new_string('bulk-privacy_requests')])
	mut switch_val_1 := var_action
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('resend'))) {
		mut iter_3 := var_request_ids.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_request_id := item_3.val
			mut var_resend := rt.call_function('_wp_privacy_resend_request', [
				var_request_id.clone()])
			if rt.is_true(var_resend)
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_resend.clone()]))))) {
				rt.pre_inc(var_count)
			} else {
				rt.pre_inc(var_failures)
			}
		}
		if rt.is_true(var_failures) {
			rt.call_function('add_settings_error', [rt.new_string('bulk_action'),
				rt.new_string('bulk_action'),
				rt.call_function('sprintf', [
					rt.call_function('_n', [
						rt.new_string('%d confirmation request failed to resend.'),
						rt.new_string('%d confirmation requests failed to resend.'),
						var_failures.clone(),
					]),
					var_failures.clone(),
				]),
				rt.new_string('error')])
		}
		if rt.is_true(var_count) {
			rt.call_function('add_settings_error', [rt.new_string('bulk_action'),
				rt.new_string('bulk_action'),
				rt.call_function('sprintf', [
					rt.call_function('_n', [
						rt.new_string('%d confirmation request re-sent successfully.'),
						rt.new_string('%d confirmation requests re-sent successfully.'),
						var_count.clone(),
					]),
					var_count.clone(),
				]),
				rt.new_string('success')])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('complete'))) {
		mut iter_4 := var_request_ids.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_request_id := item_4.val
			mut var_result := rt.call_function('_wp_privacy_completed_request', [
				var_request_id.clone(),
			])
			if rt.is_true(var_result)
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_result.clone()]))))) {
				rt.pre_inc(var_count)
			}
		}
		rt.call_function('add_settings_error', [rt.new_string('bulk_action'),
			rt.new_string('bulk_action'),
			rt.call_function('sprintf', [
				rt.call_function('_n', [rt.new_string('%d request marked as complete.'),
					rt.new_string('%d requests marked as complete.'),
					var_count.clone()]),
				var_count.clone(),
			]),
			rt.new_string('success')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete'))) {
		mut iter_5 := var_request_ids.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_request_id := item_5.val
			if rt.is_true(rt.call_function('wp_delete_post', [
				var_request_id.clone(), rt.new_bool(true)]))
			{
				rt.pre_inc(var_count)
			} else {
				rt.pre_inc(var_failures)
			}
		}
		if rt.is_true(var_failures) {
			rt.call_function('add_settings_error', [rt.new_string('bulk_action'),
				rt.new_string('bulk_action'),
				rt.call_function('sprintf', [
					rt.call_function('_n', [
						rt.new_string('%d request failed to delete.'),
						rt.new_string('%d requests failed to delete.'),
						var_failures.clone(),
					]),
					var_failures.clone(),
				]),
				rt.new_string('error')])
		}
		if rt.is_true(var_count) {
			rt.call_function('add_settings_error', [rt.new_string('bulk_action'),
				rt.new_string('bulk_action'),
				rt.call_function('sprintf', [
					rt.call_function('_n', [
						rt.new_string('%d request deleted successfully.'),
						rt.new_string('%d requests deleted successfully.'),
						var_count.clone(),
					]),
					var_count.clone(),
				]),
				rt.new_string('success')])
		}
	}
}

fn (mut this Class_WP_Privacy_Requests_Table) prepare_items() {
	this.dispatch_set_prop('items', rt.new_array())
	mut var_posts_per_page := this.get_items_per_page(rt.new_string(
		(this.request_type).str() + '_requests_per_page'))
	mut var_args := {
		'post_type':      this.post_type
		'post_name__in':  map[string]rt.PhpVal{}
		'posts_per_page': var_posts_per_page
		'offset':         if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('paged')) { rt.mul(rt.call_function('max', [
				rt.new_int(0),
				rt.sub(rt.call_function('absint', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('paged'))]), rt.new_int(1)),
			]), var_posts_per_page) } else { rt.new_int(0) }
		'post_status':    rt.new_string('any')
		's':              if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('s')) { rt.call_function('sanitize_text_field', [
				rt.get_superglobal('_REQUEST').array_get(rt.new_string('s')),
			]) } else { rt.new_string('') }
	}
	mut var_orderby_mapping := rt.create_array([
		rt.ArrayItem{ key: 'requester', val: 'post_title' },
		rt.ArrayItem{ key: 'requested', val: 'post_date' },
	])
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('orderby'))
		&& var_orderby_mapping.array_isset(rt.get_superglobal('_REQUEST').array_get(rt.new_string('orderby'))) {
		var_args['orderby'] =
			var_orderby_mapping.array_get(rt.get_superglobal('_REQUEST').array_get(rt.new_string('orderby')))
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('order'))
		&& rt.is_true(rt.call_function('in_array', [rt.new_string(rt.get_superglobal('_REQUEST').array_get(rt.new_string('order')).to_string().to_upper()), rt.create_array([rt.ArrayItem{
		key: none
		val: 'ASC'
	}, rt.ArrayItem{ key: none, val: 'DESC' }]), rt.new_bool(true)])) {
		var_args['order'] =
			rt.new_string(rt.get_superglobal('_REQUEST').array_get(rt.new_string('order')).to_string().to_upper())
	}
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('filter-status')))) {
		mut var_filter_status := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('filter-status')) { rt.call_function('sanitize_text_field', [
				rt.get_superglobal('_REQUEST').array_get(rt.new_string('filter-status')),
			]) } else { rt.new_string('') }
		var_args['post_status'] = var_filter_status.clone()
	}
	mut var_requests_query := create_wp_query(var_args.clone())
	mut var_requests := rt.get_property(var_requests_query, 'posts')
	mut iter_6 := var_requests.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_request := item_6.val
		rt.get_property(rt.new_object('WP_Privacy_Requests_Table', ['WP_List_Table'], &this),
			'items').array_push(rt.call_function('wp_get_user_request', [
			rt.get_property(var_request, 'ID'),
		]))
	}
	this.dispatch_set_prop('items', rt.call_function('array_filter', [
		rt.get_property(rt.new_object('WP_Privacy_Requests_Table', ['WP_List_Table'], &this),
			'items'),
	]))
	this.set_pagination_args(rt.create_array([
		rt.ArrayItem{ key: 'total_items', val: rt.get_property(var_requests_query, 'found_posts') },
		rt.ArrayItem{ key: 'per_page', val: var_posts_per_page },
	]))
}

fn (mut this Class_WP_Privacy_Requests_Table) column_cb(var_item rt.PhpVal) rt.PhpVal {
	return rt.call_function('sprintf', [
		rt.new_string(
			'<input type="checkbox" name="request_id[]" id="requester_%1$s" value="%1$s" />' +
			'<label for="requester_%1$s"><span class="screen-reader-text">%2$s</span></label><span class="spinner"></span>'),
		rt.call_function('esc_attr', [rt.get_property(var_item, 'ID')]),
		rt.call_function('sprintf', [rt.call_function('__', [
			rt.new_string('Select %s')]),
			rt.get_property(var_item, 'email')]),
	])
}

fn (mut this Class_WP_Privacy_Requests_Table) column_status(var_item rt.PhpVal) string {
	mut var_status := rt.call_function('get_post_status', [
		rt.get_property(var_item, 'ID'),
	])
	mut var_status_object := rt.call_function('get_post_status_object', [
		var_status.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_status_object))))
		|| !rt.is_true(rt.get_property(var_status_object, 'label')) {
		return '-'
	}
	mut var_timestamp := rt.new_bool(false)
	mut switch_val_2 := var_status
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('request-confirmed'))) {
		var_timestamp = rt.get_property(var_item, 'confirmed_timestamp')
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('request-completed'))) {
		var_timestamp = rt.get_property(var_item, 'completed_timestamp')
	}
	print('<span class="status-label status-' +
		(rt.call_function('esc_attr', [var_status.clone()])).str() + '">')
	rt.echo_val(rt.call_function('esc_html', [
		rt.get_property(var_status_object, 'label'),
	]))
	if rt.is_true(var_timestamp) {
		print('<span class="status-date">' + this.get_timestamp_as_date(var_timestamp.clone()) +
			'</span>')
	}
	print('</span>')
	return ''
}

fn (mut this Class_WP_Privacy_Requests_Table) get_timestamp_as_date(var_timestamp rt.PhpVal) string {
	mut var_timestamp_mutated := var_timestamp
	if !rt.is_true(var_timestamp_mutated) {
		return ''
	}
	mut var_time_diff := rt.sub(rt.call_function('time', []rt.PhpVal{}), var_timestamp_mutated)
	if rt.is_true(rt.greater_equal(var_time_diff, rt.new_int(0)))
		&& rt.is_true(rt.less(var_time_diff, rt.get_constant('DAY_IN_SECONDS'))) {
		return (rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s ago')]),
			rt.call_function('human_time_diff', [var_timestamp_mutated.clone()]),
		])).str()
	}
	return (rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('%1$s at %2$s')]),
		rt.call_function('date_i18n', [rt.call_function('__', [
			rt.new_string('Y/m/d')]),
			var_timestamp_mutated.clone()]),
		rt.call_function('date_i18n', [rt.call_function('__', [
			rt.new_string('g:i a')]),
			var_timestamp_mutated.clone()]),
	])).str()
}

fn (mut this Class_WP_Privacy_Requests_Table) column_default(var_item rt.PhpVal, var_column_name rt.PhpVal) {
	rt.call_function('do_action', [
		rt.concat(rt.concat(rt.new_string('manage_'), rt.get_property(rt.get_property(rt.new_object('WP_Privacy_Requests_Table', [
			'WP_List_Table',
		], &this), 'screen'), 'id')), rt.new_string('_custom_column')),
		var_column_name.clone(),
		var_item.clone(),
	])
}

fn (mut this Class_WP_Privacy_Requests_Table) column_created_timestamp(var_item rt.PhpVal) rt.PhpVal {
	return rt.new_string(this.get_timestamp_as_date(rt.get_property(var_item, 'created_timestamp')))
}

fn (mut this Class_WP_Privacy_Requests_Table) column_email(var_item rt.PhpVal) rt.PhpVal {
	return rt.call_function('sprintf', [rt.new_string('<a href="%1$s">%2$s</a> %3$s'),
		rt.call_function('esc_url', [
			rt.new_string('mailto:' + (rt.get_property(var_item, 'email')).str()),
		]),
		rt.get_property(var_item, 'email'), this.row_actions(rt.new_array())])
}

fn (mut this Class_WP_Privacy_Requests_Table) column_next_steps(var_item rt.PhpVal) {
}

fn (mut this Class_WP_Privacy_Requests_Table) single_row(var_item rt.PhpVal) {
	mut var_status := rt.get_property(var_item, 'status')
	print('<tr id="request-' +
		(rt.call_function('esc_attr', [rt.get_property(var_item, 'ID')])).str() +
		'" class="status-' + (rt.call_function('esc_attr', [var_status.clone()])).str() + '">')
	this.single_row_columns(var_item.clone())
	print('</tr>')
}

fn (mut this Class_WP_Privacy_Requests_Table) embed_scripts() {
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_wp_privacy_requests_table(_args ...rt.PhpVal) &Class_WP_Privacy_Requests_Table {
	mut obj := &Class_WP_Privacy_Requests_Table{
		PhpObjectBase: rt.PhpObjectBase{}
		request_type:  rt.new_string('INVALID')
		post_type:     rt.new_string('INVALID')
	}
	return obj
}

fn create_wp_list_table(_args ...rt.PhpVal) &Class_WP_List_Table {
	mut obj := &Class_WP_List_Table{
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

fn (mut this Class_WP_Privacy_Requests_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_columns' {
			return this.get_columns()
		}
		'get_admin_url' {
			return this.get_admin_url()
		}
		'get_sortable_columns' {
			return this.get_sortable_columns()
		}
		'get_default_primary_column_name' {
			return rt.new_string(this.get_default_primary_column_name())
		}
		'get_request_counts' {
			return this.get_request_counts()
		}
		'get_views' {
			return this.get_views()
		}
		'get_bulk_actions' {
			return this.get_bulk_actions()
		}
		'process_bulk_action' {
			this.process_bulk_action()
			return rt.new_null()
		}
		'prepare_items' {
			this.prepare_items()
			return rt.new_null()
		}
		'column_cb' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.column_cb(dispatch_arg_0)
		}
		'column_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.column_status(dispatch_arg_0))
		}
		'get_timestamp_as_date' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_timestamp_as_date(dispatch_arg_0))
		}
		'column_default' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.column_default(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'column_created_timestamp' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.column_created_timestamp(dispatch_arg_0)
		}
		'column_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.column_email(dispatch_arg_0)
		}
		'column_next_steps' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_next_steps(dispatch_arg_0)
			return rt.new_null()
		}
		'single_row' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.single_row(dispatch_arg_0)
			return rt.new_null()
		}
		'embed_scripts' {
			this.embed_scripts()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Privacy_Requests_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'request_type' { return this.request_type }
		'post_type' { return this.post_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Privacy_Requests_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
