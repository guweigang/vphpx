import rt

struct Class_ActionScheduler_Abstract_ListTable {
	rt.PhpObjectBase
pub mut:
	table_name     rt.PhpVal = rt.new_null()
	package        rt.PhpVal = rt.new_null()
	items_per_page rt.PhpVal = rt.new_int(10)
	search_by      rt.PhpVal = rt.new_array()
	columns        rt.PhpVal = rt.new_array()
	row_actions    rt.PhpVal = rt.new_array()
	ID             rt.PhpVal = rt.new_string('ID')
	sort_by        rt.PhpVal = rt.new_array()
	filter_by      rt.PhpVal = rt.new_array()
	status_counts  rt.PhpVal = rt.new_array()
	admin_notices  rt.PhpVal = rt.new_array()
	table_header   rt.PhpVal = rt.new_null()
	bulk_actions   rt.PhpVal = rt.new_array()
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) translate(var_text rt.PhpVal, context string) rt.PhpVal {
	return var_text.clone()
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_bulk_actions() rt.PhpVal {
	mut var_actions := rt.new_array()
	mut iter_1 := this.bulk_actions.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_label := item_1.val
		mut var_action := item_1.key
		if !(rt.call_function('is_callable', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_Abstract_ListTable', [
					'WP_List_Table',
				], &this) },
				rt.ArrayItem{ key: none, val: 'bulk_' + var_action.str() },
			]),
		])) {
			rt.throw_exception(rt.new_object('RuntimeException', []string{},
				create_runtimeexception(rt.new_string('The bulk action ${var_action.to_string()} does not have a callback method'))))
		}
		var_actions.array_set(var_action, var_label.clone())
	}
	return var_actions.clone()
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) process_bulk_action() {
	mut var_wpdb := rt.new_null()
	mut var_action := this.current_action()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_action)))) {
		return
	}
	rt.call_function('check_admin_referer', [
		rt.new_string('bulk-' +(rt.get_property(rt.new_object('ActionScheduler_Abstract_ListTable', ['WP_List_Table'], &this), '_args').array_get(rt.new_string('plural'))).str()),
	])
	mut var_method := rt.new_string('bulk_' + var_action.str())
	if rt.is_true(rt.new_bool(this.bulk_actions.array_isset(var_action.clone())))
		&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
		key: none
		val: rt.new_object('ActionScheduler_Abstract_ListTable', ['WP_List_Table'], &this)
	}, rt.ArrayItem{ key: none, val: var_method }])])
		&& !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('ID'))))
		&& rt.get_superglobal('_GET').array_get(rt.new_string('ID')).is_array() {
		mut var_ids_sql := rt.new_string('(' +
			(rt.call_function('implode', [rt.new_string(','), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(rt.get_superglobal('_GET').array_get(rt.new_string('ID')).array_count()), rt.new_string('%s')])])).str() +
			')')
		mut var_id := rt.call_function('array_map', [rt.new_string('absint'),
			rt.get_superglobal('_GET').array_get(rt.new_string('ID'))])
		rt.call_method(rt.new_object('ActionScheduler_Abstract_ListTable', [
			'WP_List_Table',
		], &this), var_method, [var_id.clone(),
			rt.call_method(var_wpdb, 'prepare', [var_ids_sql.clone(),
				var_id.clone()])])
	}
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_URI')) {
		rt.call_function('wp_safe_redirect', [
			rt.call_function('remove_query_arg', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: '_wp_http_referer' },
					rt.ArrayItem{ key: none, val: '_wpnonce' },
					rt.ArrayItem{ key: none, val: 'ID' },
					rt.ArrayItem{ key: none, val: 'action' },
					rt.ArrayItem{ key: none, val: 'action2' },
				]),
				rt.call_function('esc_url_raw', [
					rt.call_function('wp_unslash', [
						rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
					]),
				]),
			]),
		])
		exit(0)
	}
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) bulk_delete(mut var_ids Class_array, var_ids_sql rt.PhpVal) {
	mut var_ids_sql_mutated := var_ids_sql
	mut iife_temp_0 := Class_ActionScheduler{}
	mut iife_result_0 := iife_temp_0.store()
	mut var_store := iife_result_0
	mut iter_2 := var_ids.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_action_id := item_2.val
		rt.call_method(var_store, 'delete', [var_action_id.clone()])
	}
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) prepare_column_headers() {
	this.dispatch_set_prop('_column_headers', rt.create_array([
		rt.ArrayItem{ key: none, val: this.get_columns() },
		rt.ArrayItem{ key: none, val: rt.call_function('get_hidden_columns', [
			rt.get_property(rt.new_object('ActionScheduler_Abstract_ListTable', [
				'WP_List_Table',
			], &this), 'screen'),
		]) },
		rt.ArrayItem{ key: none, val: this.get_sortable_columns() },
	]))
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_sortable_columns() rt.PhpVal {
	mut var_sort_by := rt.new_array()
	mut iter_3 := this.sort_by.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_column := item_3.val
		var_sort_by.array_set(var_column, rt.create_array([
			rt.ArrayItem{ key: none, val: var_column },
			rt.ArrayItem{ key: none, val: true },
		]))
	}
	return var_sort_by.clone()
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_columns() rt.PhpVal {
	mut var_columns := rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: 'cb', val: '<input type="checkbox" />' }]),
		this.columns,
	])
	return var_columns.clone()
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_items_query_limit() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_per_page := this.get_items_per_page(rt.new_string(this.get_per_page_option_name()),
		this.items_per_page)
	return rt.call_method(var_wpdb, 'prepare', [rt.new_string('LIMIT %d'),
		var_per_page.clone()])
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_items_offset() rt.PhpVal {
	mut var_per_page := this.get_items_per_page(rt.new_string(this.get_per_page_option_name()),
		this.items_per_page)
	mut var_current_page := this.get_pagenum()
	if rt.is_true(rt.less(rt.new_int(1), var_current_page)) {
		mut var_offset := rt.mul(var_per_page, rt.sub(var_current_page, rt.new_int(1)))
	} else {
		var_offset = rt.new_int(0)
	}
	return var_offset.clone()
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_items_query_offset() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	return rt.call_method(var_wpdb, 'prepare', [rt.new_string('OFFSET %d'),
		this.get_items_offset()])
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_items_query_order() string {
	if !rt.is_true(this.sort_by) {
		return ''
	}
	mut var_orderby := rt.call_function('esc_sql', [this.get_request_orderby()])
	mut var_order := rt.call_function('esc_sql', [this.get_request_order()])
	return 'ORDER BY ${var_orderby.to_string()} ${var_order.to_string()}'
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_request_query_args_to_persist() rt.PhpVal {
	return rt.call_function('array_merge', [this.sort_by,
		rt.create_array([rt.ArrayItem{ key: none, val: 'page' },
			rt.ArrayItem{ key: none, val: 'status' }, rt.ArrayItem{ key: none, val: 'tab' }])])
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_request_orderby() rt.PhpVal {
	mut var_valid_sortable_columns := rt.call_function('array_values', [this.sort_by])
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('orderby'))))
		&& rt.is_true(rt.call_function('in_array', [rt.get_superglobal('_GET').array_get(rt.new_string('orderby')), var_valid_sortable_columns.clone(), rt.new_bool(true)])) {
		mut var_orderby := rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_GET').array_get(rt.new_string('orderby'))]),
		])
	} else {
		var_orderby = var_valid_sortable_columns.array_get(rt.new_int(0))
	}
	return var_orderby.clone()
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_request_order() rt.PhpVal {
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('order'))))
		&& rt.is_true(rt.identical(rt.new_string('desc'), rt.new_string(rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('order'))])]).to_string().to_lower()))) {
		mut var_order := rt.new_string('DESC')
	} else {
		var_order = rt.new_string('ASC')
	}
	return var_order.clone()
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_request_status() rt.PhpVal {
	mut var_status := if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('status')))) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('status'))]),
		]) } else { rt.new_string('') }
	return var_status.clone()
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_request_search_query() rt.PhpVal {
	mut var_search_query := if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('s')))) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('s'))]),
		]) } else { rt.new_string('') }
	return var_search_query.clone()
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_table_columns() rt.PhpVal {
	mut var_columns := rt.func_array_keys(this.columns)
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [this.ID, var_columns.clone(),
		rt.new_bool(true)])))))
	{
		var_columns.array_push(this.ID)
	}
	return var_columns.clone()
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_items_query_search() string {
	mut var_wpdb := rt.new_null()
	if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('s')))
		|| !rt.is_true(this.search_by) {
		return ''
	}
	mut var_search_string := rt.call_function('sanitize_text_field', [
		rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('s'))]),
	])
	mut var_filter := rt.new_array()
	mut iter_4 := this.search_by.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_column := item_4.val
		mut var_wild := rt.new_string('%')
		mut var_sql_like := rt.new_string(var_wild.str() +
			(rt.call_method(var_wpdb, 'esc_like', [var_search_string.clone()])).str() +
			var_wild.str())
		var_filter << rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('`' + var_column.str() + '` LIKE %s'),
			var_sql_like.clone(),
		])
	}
	return (rt.call_function('implode', [rt.new_string(' OR '),
		rt.create_array_from_list(var_filter)])).str()
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_items_query_filters() string {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(this.filter_by))))
		|| !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('filter_by')))
		|| !(rt.get_superglobal('_GET').array_get(rt.new_string('filter_by')).is_array()) {
		return ''
	}
	mut var_filter := rt.new_array()
	mut iter_5 := this.filter_by.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_options := item_5.val
		mut var_column := item_5.key
		if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('filter_by')).array_get(var_column))
			|| !rt.is_true(var_options.array_get(rt.get_superglobal('_GET').array_get(rt.new_string('filter_by')).array_get(var_column))) {
			continue
		}
		var_filter << rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('`${var_column.to_string()}` = %s'),
			rt.call_function('sanitize_text_field', [
				rt.call_function('wp_unslash',
					[rt.get_superglobal('_GET').array_get(rt.new_string('filter_by')).array_get(var_column)]),
			]),
		])
	}
	return (rt.call_function('implode', [rt.new_string(' AND '),
		rt.create_array_from_list(var_filter)])).str()
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) prepare_items() {
	mut var_wpdb := rt.new_null()
	this.process_bulk_action()
	this.process_row_actions()
	if !(!(rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wp_http_referer')))
		&& !(!rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')))))) {
		rt.call_function('wp_safe_redirect', [
			rt.call_function('remove_query_arg', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: '_wp_http_referer' },
					rt.ArrayItem{ key: none, val: '_wpnonce' },
				]),
				rt.call_function('esc_url_raw', [
					rt.call_function('wp_unslash', [
						rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
					]),
				]),
			]),
		])
		exit(0)
	}
	this.prepare_column_headers()
	mut var_limit := this.get_items_query_limit()
	mut var_offset := this.get_items_query_offset()
	mut var_order := rt.new_string(this.get_items_query_order())
	mut var_where := rt.call_function('array_filter', [
		rt.create_array([rt.ArrayItem{ key: none, val: this.get_items_query_search() },
			rt.ArrayItem{ key: none, val: this.get_items_query_filters() }]),
	])
	mut var_columns := rt.new_string('`' +
		(rt.call_function('implode', [rt.new_string('`, `'), this.get_table_columns()])).str() + '`')
	if !(!rt.is_true(var_where)) {
		var_where = rt.new_string(
			'WHERE (' + (rt.call_function('implode', [rt.new_string(') AND ('), var_where.clone()])).str() +
			')')
	} else {
		var_where = rt.new_string('')
	}
	mut var_sql := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT '),
		var_columns), rt.new_string(' FROM ')), this.table_name), rt.new_string(' ')), var_where),
		rt.new_string(' ')), var_order), rt.new_string(' ')), var_limit), rt.new_string(' ')),
		var_offset)).str())
	this.set_items(mut rt.cast_object_ptr[Class_array](rt.call_method(var_wpdb, 'get_results', [
		var_sql.clone(),
		rt.get_constant('ARRAY_A'),
	])))
	mut var_query_count := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT COUNT('),
		this.ID), rt.new_string(') FROM ')), this.table_name), rt.new_string(' ')), var_where)).str())
	mut var_total_items := rt.call_method(var_wpdb, 'get_var', [
		var_query_count.clone()])
	mut var_per_page := this.get_items_per_page(rt.new_string(this.get_per_page_option_name()),
		this.items_per_page)
	this.set_pagination_args(rt.create_array([
		rt.ArrayItem{ key: 'total_items', val: var_total_items },
		rt.ArrayItem{ key: 'per_page', val: var_per_page },
		rt.ArrayItem{ key: 'total_pages', val: rt.call_function('ceil', [
			rt.div(var_total_items, var_per_page),
		]) },
	]))
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) extra_tablenav(var_which rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.filter_by))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('top'), var_which)))) {
		return
	}
	print('<div class="alignleft actions">')
	mut iter_6 := this.filter_by.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_options := item_6.val
		mut var_id := item_6.key
		mut var_default := if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('filter_by')).array_get(var_id))) { rt.call_function('sanitize_text_field', [
				rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('filter_by')).array_get(var_id)]),
			]) } else { rt.new_string('') }
		if !rt.is_true(var_options.array_get(var_default)) {
			var_default = rt.new_string('')
		}
		print('<select name="filter_by[' + (rt.call_function('esc_attr', [var_id.clone()])).str() +
			']" class="first" id="filter-by-' +
			(rt.call_function('esc_attr', [var_id.clone()])).str() + '">')
		mut iter_7 := var_options.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_label := item_7.val
			mut var_value := item_7.key
			print('<option value="' + (rt.call_function('esc_attr', [var_value.clone()])).str() +
				'" ' +
				(rt.call_function('esc_html', [rt.new_string((if rt.is_true(rt.identical(var_value, var_default)) { 'selected' } else { '' }).str())])).str() +
				'>' + (rt.call_function('esc_html', [var_label.clone()])).str() + '</option>')
		}
		print('</select>')
	}
	rt.call_function('submit_button', [
		rt.call_function('esc_html__', [rt.new_string('Filter'),
			rt.new_string('woocommerce')]),
		rt.new_string(''),
		rt.new_string('filter_action'),
		rt.new_bool(false),
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'post-query-submit' }]),
	])
	print('</div>')
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) set_items(mut var_items Class_array) {
	this.dispatch_set_prop('items', rt.new_array())
	mut iter_8 := var_items.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_item := item_8.val
		rt.get_property(rt.new_object('ActionScheduler_Abstract_ListTable', [
			'WP_List_Table',
		], &this), 'items').array_set(var_item.array_get(this.ID), rt.call_function('array_map', [
			rt.new_string('maybe_unserialize'),
			var_item.clone(),
		]))
	}
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) column_cb(var_row rt.PhpVal) string {
	return '<input name="ID[]" type="checkbox" value="' +
		(rt.call_function('esc_attr', [var_row.array_get(this.ID)])).str() + '" />'
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) maybe_render_actions(var_row rt.PhpVal, var_column_name rt.PhpVal) rt.PhpVal {
	if !rt.is_true(this.row_actions.array_get(var_column_name)) {
		return rt.new_null()
	}
	mut var_row_id := var_row.array_get(this.ID)
	mut var_actions := rt.new_string('<div class="row-actions">')
	mut var_action_count := rt.new_int(0)
	mut iter_9 := this.row_actions.array_get(var_column_name).iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_action := item_9.val
		mut var_action_key := item_9.key
		rt.post_inc(var_action_count)
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('method_exists', [
			rt.new_object('ActionScheduler_Abstract_ListTable', ['WP_List_Table'], &this),
			rt.new_string('row_action_' + var_action_key.str()),
		])))))
		{
			continue
		}
		mut var_action_link := if !(!rt.is_true(var_action.array_get(rt.new_string('link')))) { var_action.array_get(rt.new_string('link')) } else { rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'row_action', val: var_action_key },
					rt.ArrayItem{ key: 'row_id', val: var_row_id },
					rt.ArrayItem{ key: 'nonce', val: rt.call_function('wp_create_nonce', [
						rt.new_string(var_action_key.str() + '::' + var_row_id.str()),
					]) }]),
			]) }
		mut var_span_class := if !(!rt.is_true(var_action.array_get(rt.new_string('class')))) {
			var_action.array_get(rt.new_string('class'))
		} else {
			var_action_key
		}
		mut var_separator := rt.new_string((if rt.is_true(rt.less(var_action_count,
			rt.new_int(this.row_actions.array_get(var_column_name).array_count())))
		{
			' | '
		} else {
			''
		}).str())
		var_actions = rt.concat(var_actions, rt.call_function('sprintf', [
			rt.new_string('<span class="%s">'),
			rt.call_function('esc_attr', [var_span_class.clone()]),
		]))
		var_actions = rt.concat(var_actions, rt.call_function('sprintf', [
			rt.new_string('<a href="%1$s" title="%2$s">%3$s</a>'),
			rt.call_function('esc_url', [var_action_link.clone()]),
			rt.call_function('esc_attr', [var_action.array_get(rt.new_string('desc'))]),
			rt.call_function('esc_html', [var_action.array_get(rt.new_string('name'))]),
		]))
		var_actions = rt.concat(var_actions, rt.call_function('sprintf', [
			rt.new_string('%s</span>'),
			var_separator.clone(),
		]))
	}
	var_actions = rt.concat(var_actions, rt.new_string('</div>'))
	return var_actions.clone()
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) process_row_actions() {
	mut var_parameters := ['row_action', 'row_id', 'nonce']
	for var_parameter in var_parameters {
		if !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string(parameter))) {
			return
		}
	}
	mut var_action := rt.call_function('sanitize_text_field', [
		rt.call_function('wp_unslash',
			[rt.get_superglobal('_REQUEST').array_get(rt.new_string('row_action'))]),
	])
	mut var_row_id := rt.call_function('sanitize_text_field', [
		rt.call_function('wp_unslash',
			[rt.get_superglobal('_REQUEST').array_get(rt.new_string('row_id'))]),
	])
	mut var_nonce := rt.call_function('sanitize_text_field', [
		rt.call_function('wp_unslash',
			[rt.get_superglobal('_REQUEST').array_get(rt.new_string('nonce'))]),
	])
	mut var_method := rt.new_string('row_action_' + var_action.str())
	if rt.is_true(rt.call_function('wp_verify_nonce', [var_nonce.clone(), rt.new_string(var_action.str() + '::' + var_row_id.str())]))
		&& rt.is_true(rt.call_function('method_exists', [rt.new_object('ActionScheduler_Abstract_ListTable', ['WP_List_Table'], &this), var_method.clone()])) {
		rt.call_method(rt.new_object('ActionScheduler_Abstract_ListTable', [
			'WP_List_Table',
		], &this), var_method, [
			rt.call_function('sanitize_text_field', [
				rt.call_function('wp_unslash', [var_row_id.clone()]),
			]),
		])
	}
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_URI')) {
		rt.call_function('wp_safe_redirect', [
			rt.call_function('remove_query_arg', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: 'row_id' },
					rt.ArrayItem{ key: none, val: 'row_action' },
					rt.ArrayItem{ key: none, val: 'nonce' },
				]),
				rt.call_function('esc_url_raw', [
					rt.call_function('wp_unslash', [
						rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
					]),
				]),
			]),
		])
		exit(0)
	}
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) column_default(var_item rt.PhpVal, var_column_name rt.PhpVal) rt.PhpVal {
	mut var_column_html := rt.call_function('esc_html', [var_item.array_get(var_column_name)])
	var_column_html = rt.concat(var_column_html, this.maybe_render_actions(var_item.clone(),
		var_column_name.clone()))
	return var_column_html.clone()
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) display_header() {
	print('<h1 class="wp-heading-inline">' +
		(rt.call_function('esc_attr', [this.table_header])).str() + '</h1>')
	if rt.is_true(this.get_request_search_query()) {
		print('<span class="subtitle">' +
			(rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Search results for "%s"'), rt.new_string('woocommerce')]), this.get_request_search_query()])])).str() +
			'</span>')
	}
	print('<hr class="wp-header-end">')
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) display_admin_notices() {
	mut iter_10 := this.admin_notices.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_notice := item_10.val
		print('<div id="message" class="' +
			(rt.call_function('esc_attr', [var_notice.array_get(rt.new_string('class'))])).str() +
			'">')
		print('\t<p>' +
			(rt.call_function('wp_kses_post', [var_notice.array_get(rt.new_string('message'))])).str() +
			'</p>')
		print('</div>')
	}
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) display_filter_by_status() {
	mut var_status_list_items := rt.new_array()
	mut var_request_status := this.get_request_status()
	if !(this.status_counts.array_isset(rt.new_string('all'))) {
		mut var_all_count := rt.call_function('array_sum', [this.status_counts])
		if this.status_counts.array_isset(rt.new_string('past-due')) {
			var_all_count = rt.sub(var_all_count,
				this.status_counts.array_get(rt.new_string('past-due')))
		}
		this.status_counts = rt.add(rt.create_array([
			rt.ArrayItem{ key: 'all', val: var_all_count },
		]), this.status_counts)
	}
	mut iife_temp_1 := Class_ActionScheduler_Store{}
	mut iife_result_1 := iife_temp_1.instance()
	mut var_status_labels := rt.call_method(iife_result_1, 'get_status_labels', []rt.PhpVal{})
	var_status_labels.array_set('all', rt.call_function('esc_html_x', [
		rt.new_string('All'),
		rt.new_string('status labels'),
		rt.new_string('woocommerce'),
	]))
	var_status_labels.array_set('past-due', rt.call_function('esc_html_x', [
		rt.new_string('Past-due'),
		rt.new_string('status labels'),
		rt.new_string('woocommerce'),
	]))
	mut iter_11 := this.status_counts.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_count := item_11.val
		mut var_status_slug := item_11.key
		if rt.is_true(rt.identical(rt.new_int(0), var_count)) {
			continue
		}
		if rt.is_true(rt.identical(var_status_slug, var_request_status))
			|| (!rt.is_true(var_request_status)
			&& rt.is_true(rt.identical(rt.new_string('all'), var_status_slug))) {
			mut var_status_list_item :=
				rt.new_string('<li class="%1$s"><a href="%2$s" class="current">%3$s</a> (%4$d)</li>')
		} else {
			var_status_list_item =
				rt.new_string('<li class="%1$s"><a href="%2$s">%3$s</a> (%4$d)</li>')
		}
		mut var_status_name := if var_status_labels.array_isset(var_status_slug) { var_status_labels.array_get(var_status_slug) } else { rt.call_function('ucfirst', [
				var_status_slug.clone(),
			]) }
		mut var_status_filter_url := if rt.is_true(rt.identical(rt.new_string('all'), var_status_slug)) { rt.call_function('remove_query_arg', [
				rt.new_string('status'),
			]) } else { rt.call_function('add_query_arg', [rt.new_string('status'),
				var_status_slug.clone()]) }
		var_status_filter_url = rt.call_function('remove_query_arg', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'paged' },
				rt.ArrayItem{ key: none, val: 's' }]),
			var_status_filter_url.clone(),
		])
		var_status_list_items << rt.call_function('sprintf', [
			var_status_list_item.clone(), rt.call_function('esc_attr', [
				var_status_slug.clone()]),
			rt.call_function('esc_url', [var_status_filter_url.clone()]),
			rt.call_function('esc_html', [var_status_name.clone()]),
			rt.call_function('absint', [var_count.clone()])])
	}
	if rt.is_true(var_status_list_items) {
		print('<ul class="subsubsub">')
		rt.echo_val(rt.call_function('implode', [rt.new_string(' | \n'),
			rt.create_array_from_list(var_status_list_items)]))
		print('</ul>')
	}
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) display_table() {
	print('<form id="' +
		(rt.call_function('esc_attr', [rt.get_property(rt.new_object('ActionScheduler_Abstract_ListTable', ['WP_List_Table'], &this), '_args').array_get(rt.new_string('plural'))])).str() +
		'-filter" method="get">')
	mut iter_12 := this.get_request_query_args_to_persist().iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_arg := item_12.val
		mut var_arg_value := if rt.get_superglobal('_GET').array_isset(var_arg) { rt.call_function('sanitize_text_field', [
				rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(var_arg)]),
			]) } else { rt.new_string('') }
		if rt.is_true(rt.new_bool(!(rt.is_true(var_arg_value)))) {
			continue
		}
		print('<input type="hidden" name="' +
			(rt.call_function('esc_attr', [var_arg.clone()])).str() + '" value="' +
			(rt.call_function('esc_attr', [var_arg_value.clone()])).str() + '" />')
	}
	if !(!rt.is_true(this.search_by)) {
		rt.echo_val(this.search_box(this.get_search_box_button_text(), rt.new_string('plugin')))
	}
	this.Class_WP_List_Table.display()
	print('</form>')
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) process_actions() {
	this.process_bulk_action()
	this.process_row_actions()
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wp_http_referer'))))
		&& !(!rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')))) {
		rt.call_function('wp_safe_redirect', [
			rt.call_function('remove_query_arg', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: '_wp_http_referer' },
					rt.ArrayItem{ key: none, val: '_wpnonce' },
				]),
				rt.call_function('esc_url_raw', [
					rt.call_function('wp_unslash', [
						rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
					]),
				]),
			]),
		])
		exit(0)
	}
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) display_page() {
	this.prepare_items()
	print('<div class="wrap">')
	this.display_header()
	this.display_admin_notices()
	this.display_filter_by_status()
	this.display_table()
	print('</div>')
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_search_box_placeholder() rt.PhpVal {
	return rt.call_function('esc_html__', [rt.new_string('Search'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_per_page_option_name() string {
	return (this.package).str() + '_items_per_page'
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

struct Class_RuntimeException {
	rt.PhpObjectBase
}

struct Class_ActionScheduler {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_Store {
	rt.PhpObjectBase
}

fn create_actionscheduler_abstract_listtable(_args ...rt.PhpVal) &Class_ActionScheduler_Abstract_ListTable {
	mut obj := &Class_ActionScheduler_Abstract_ListTable{
		PhpObjectBase:  rt.PhpObjectBase{}
		table_name:     rt.new_null()
		package:        rt.new_null()
		items_per_page: rt.new_int(10)
		search_by:      rt.new_array()
		columns:        rt.new_array()
		row_actions:    rt.new_array()
		ID:             rt.new_string('ID')
		sort_by:        rt.new_array()
		filter_by:      rt.new_array()
		status_counts:  rt.new_array()
		admin_notices:  rt.new_array()
		table_header:   rt.new_null()
		bulk_actions:   rt.new_array()
	}
	return obj
}

fn create_wp_list_table(_args ...rt.PhpVal) &Class_WP_List_Table {
	mut obj := &Class_WP_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_runtimeexception(_args ...rt.PhpVal) &Class_RuntimeException {
	mut obj := &Class_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler(_args ...rt.PhpVal) &Class_ActionScheduler {
	mut obj := &Class_ActionScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_store(_args ...rt.PhpVal) &Class_ActionScheduler_Store {
	mut obj := &Class_ActionScheduler_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'translate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.translate(dispatch_arg_0, dispatch_arg_1)
		}
		'get_bulk_actions' {
			return this.get_bulk_actions()
		}
		'process_bulk_action' {
			this.process_bulk_action()
			return rt.new_null()
		}
		'bulk_delete' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.bulk_delete(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'prepare_column_headers' {
			this.prepare_column_headers()
			return rt.new_null()
		}
		'get_sortable_columns' {
			return this.get_sortable_columns()
		}
		'get_columns' {
			return this.get_columns()
		}
		'get_items_query_limit' {
			return this.get_items_query_limit()
		}
		'get_items_offset' {
			return this.get_items_offset()
		}
		'get_items_query_offset' {
			return this.get_items_query_offset()
		}
		'get_items_query_order' {
			return rt.new_string(this.get_items_query_order())
		}
		'get_request_query_args_to_persist' {
			return this.get_request_query_args_to_persist()
		}
		'get_request_orderby' {
			return this.get_request_orderby()
		}
		'get_request_order' {
			return this.get_request_order()
		}
		'get_request_status' {
			return this.get_request_status()
		}
		'get_request_search_query' {
			return this.get_request_search_query()
		}
		'get_table_columns' {
			return this.get_table_columns()
		}
		'get_items_query_search' {
			return rt.new_string(this.get_items_query_search())
		}
		'get_items_query_filters' {
			return rt.new_string(this.get_items_query_filters())
		}
		'prepare_items' {
			this.prepare_items()
			return rt.new_null()
		}
		'extra_tablenav' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.extra_tablenav(dispatch_arg_0)
			return rt.new_null()
		}
		'set_items' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.set_items(mut dispatch_arg_0)
			return rt.new_null()
		}
		'column_cb' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.column_cb(dispatch_arg_0))
		}
		'maybe_render_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.maybe_render_actions(dispatch_arg_0, dispatch_arg_1)
		}
		'process_row_actions' {
			this.process_row_actions()
			return rt.new_null()
		}
		'column_default' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.column_default(dispatch_arg_0, dispatch_arg_1)
		}
		'display_header' {
			this.display_header()
			return rt.new_null()
		}
		'display_admin_notices' {
			this.display_admin_notices()
			return rt.new_null()
		}
		'display_filter_by_status' {
			this.display_filter_by_status()
			return rt.new_null()
		}
		'display_table' {
			this.display_table()
			return rt.new_null()
		}
		'process_actions' {
			this.process_actions()
			return rt.new_null()
		}
		'display_page' {
			this.display_page()
			return rt.new_null()
		}
		'get_search_box_placeholder' {
			return this.get_search_box_placeholder()
		}
		'get_per_page_option_name' {
			return rt.new_string(this.get_per_page_option_name())
		}
		else {
			return none
		}
	}
}

fn (this &Class_ActionScheduler_Abstract_ListTable) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'table_name' { return this.table_name }
		'package' { return this.package }
		'items_per_page' { return this.items_per_page }
		'search_by' { return this.search_by }
		'columns' { return this.columns }
		'row_actions' { return this.row_actions }
		'ID' { return this.ID }
		'sort_by' { return this.sort_by }
		'filter_by' { return this.filter_by }
		'status_counts' { return this.status_counts }
		'admin_notices' { return this.admin_notices }
		'table_header' { return this.table_header }
		'bulk_actions' { return this.bulk_actions }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'table_name' {
			this.table_name = val
			return true
		}
		'package' {
			this.package = val
			return true
		}
		'items_per_page' {
			this.items_per_page = val
			return true
		}
		'search_by' {
			this.search_by = val
			return true
		}
		'columns' {
			this.columns = val
			return true
		}
		'row_actions' {
			this.row_actions = val
			return true
		}
		'ID' {
			this.ID = val
			return true
		}
		'sort_by' {
			this.sort_by = val
			return true
		}
		'filter_by' {
			this.filter_by = val
			return true
		}
		'status_counts' {
			this.status_counts = val
			return true
		}
		'admin_notices' {
			this.admin_notices = val
			return true
		}
		'table_header' {
			this.table_header = val
			return true
		}
		'bulk_actions' {
			this.bulk_actions = val
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

fn (mut this Class_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ActionScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ActionScheduler_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WP_List_Table'),
	])))))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-list-table.php', '4')
	}
}
