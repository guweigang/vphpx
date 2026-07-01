import rt

struct Class_ActionScheduler_Abstract_ListTable {
	rt.PhpObjectBase
pub mut:
		table_name rt.PhpVal = rt.new_null()
		package rt.PhpVal = rt.new_null()
		items_per_page rt.PhpVal = rt.new_int(10)
		search_by rt.PhpVal = rt.new_array()
		columns rt.PhpVal = rt.new_array()
		row_actions rt.PhpVal = rt.new_array()
		ID rt.PhpVal = rt.new_string('ID')
		sort_by rt.PhpVal = rt.new_array()
		filter_by rt.PhpVal = rt.new_array()
		status_counts rt.PhpVal = rt.new_array()
		admin_notices rt.PhpVal = rt.new_array()
		table_header rt.PhpVal = rt.new_null()
		bulk_actions rt.PhpVal = rt.new_array()
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) translate(var_text rt.PhpVal, context string) rt.PhpVal {
	return var_text.dup()
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_bulk_actions() rt.PhpVal {
	mut var_actions := rt.new_array()
	{
		mut iter_1 := this.bulk_actions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_label := item_1.val
			mut var_action := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_Abstract_ListTable', ['WP_List_Table'], &this) }, rt.ArrayItem{ key: none, val: 'bulk_' + (var_action).str() }])]))))) {
				rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception(rt.new_string("The bulk action ${var_action.to_string()} does not have a callback method"))))
			}
			var_actions.array_set(var_action, var_label.dup())
		}
	}
	return var_actions.dup()
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) process_bulk_action()  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_action := this.current_action()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_action)))) {
		return rt.new_null()
	}
	rt.call_function('check_admin_referer', ['bulk-' + (rt.get_property(rt.new_object('ActionScheduler_Abstract_ListTable', ['WP_List_Table'], &this), '_args').array_get('plural')).str()])
	mut var_method := rt.new_string('bulk_' + (var_action).str())
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(this.bulk_actions.array_isset(var_action.dup()))) && rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_Abstract_ListTable', ['WP_List_Table'], &this) }, rt.ArrayItem{ key: none, val: var_method }])])))) && !(!rt.is_true(rt.get_superglobal('_GET').array_get('ID'))))) && rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_get('ID').is_array())))) {
		mut var_ids_sql := rt.new_string('(' + (rt.call_function('implode', [rt.new_string(','), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(rt.get_superglobal('_GET').array_get('ID').array_count()), rt.new_string('%s')])])).str() + ')')
		mut var_id := rt.call_function('array_map', [rt.new_string('absint'), rt.get_superglobal('_GET').array_get('ID')])
		rt.call_method(rt.new_object('ActionScheduler_Abstract_ListTable', ['WP_List_Table'], &this), var_method, [var_id.dup(), rt.call_method(var_wpdb, 'prepare', [var_ids_sql.dup(), var_id.dup()])])
		// unsupported statement: Stmt_Nop
	}
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_URI')) {
		rt.call_function('wp_safe_redirect', [rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: '_wp_http_referer' }, rt.ArrayItem{ key: none, val: '_wpnonce' }, rt.ArrayItem{ key: none, val: 'ID' }, rt.ArrayItem{ key: none, val: 'action' }, rt.ArrayItem{ key: none, val: 'action2' }]), rt.call_function('esc_url_raw', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('REQUEST_URI')])])])])
		// unsupported expression: Expr_Exit
	}
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) bulk_delete(mut var_ids Class_array, var_ids_sql rt.PhpVal)  {
	mut var_ids_sql_mutated := var_ids_sql
	mut var_store := fn () rt.PhpVal { mut temp := Class_ActionScheduler{}; return temp.store() }()
	{
		mut iter_1 := var_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_action_id := item_1.val
			rt.call_method(var_store, 'delete', [var_action_id.dup()])
		}
	}
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) prepare_column_headers()  {
	this.dispatch_set_prop('_column_headers', rt.create_array([rt.ArrayItem{ key: none, val: this.get_columns() }, rt.ArrayItem{ key: none, val: rt.call_function('get_hidden_columns', [rt.get_property(rt.new_object('ActionScheduler_Abstract_ListTable', ['WP_List_Table'], &this), 'screen')]) }, rt.ArrayItem{ key: none, val: this.get_sortable_columns() }]))
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_sortable_columns() rt.PhpVal {
	mut var_sort_by := rt.new_array()
	{
		mut iter_1 := this.sort_by.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_column := item_1.val
			var_sort_by.array_set(var_column, rt.create_array([rt.ArrayItem{ key: none, val: var_column }, rt.ArrayItem{ key: none, val: true }]))
		}
	}
	return var_sort_by.dup()
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_columns() rt.PhpVal {
	mut var_columns := rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'cb', val: '<input type="checkbox" />' }]), this.columns])
	return var_columns.dup()
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_items_query_limit() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_per_page := this.get_items_per_page(rt.new_string(this.get_per_page_option_name()), this.items_per_page)
	return rt.call_method(var_wpdb, 'prepare', [rt.new_string('LIMIT %d'), var_per_page.dup()])
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_items_offset() rt.PhpVal {
	mut var_per_page := this.get_items_per_page(rt.new_string(this.get_per_page_option_name()), this.items_per_page)
	mut var_current_page := this.get_pagenum()
	if rt.is_true(rt.less(rt.new_int(1), var_current_page)) {
		mut var_offset := rt.mul(var_per_page, rt.sub(var_current_page, rt.new_int(1)))
	} else {
		var_offset = rt.new_int(rt.new_int(0))
	}
	return var_offset.dup()
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_items_query_offset() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wpdb, 'prepare', [rt.new_string('OFFSET %d'), this.get_items_offset()])
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_items_query_order() string {
	if !rt.is_true(this.sort_by) {
		return ''
	}
	mut var_orderby := rt.call_function('esc_sql', [this.get_request_orderby()])
	mut var_order := rt.call_function('esc_sql', [this.get_request_order()])
	return "ORDER BY ${var_orderby.to_string()} ${var_order.to_string()}"
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_request_query_args_to_persist() rt.PhpVal {
	return rt.call_function('array_merge', [this.sort_by, rt.create_array([rt.ArrayItem{ key: none, val: 'page' }, rt.ArrayItem{ key: none, val: 'status' }, rt.ArrayItem{ key: none, val: 'tab' }])])
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_request_orderby() rt.PhpVal {
	mut var_valid_sortable_columns := rt.call_function('array_values', [this.sort_by])
	if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_GET').array_get('orderby'))) && rt.is_true(rt.call_function('in_array', [rt.get_superglobal('_GET').array_get('orderby'), var_valid_sortable_columns.dup(), rt.new_bool(true)])))) {
		mut var_orderby := rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('orderby')])])
		// unsupported statement: Stmt_Nop
	} else {
		var_orderby = var_valid_sortable_columns.array_get(0)
	}
	return var_orderby.dup()
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_request_order() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_GET').array_get('order'))) && rt.is_true(rt.identical(rt.new_string('desc'), rt.new_string(rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('order')])]).to_string().to_lower()))))) {
		mut var_order := rt.new_string(rt.new_string('DESC'))
	} else {
		var_order = rt.new_string(rt.new_string('ASC'))
	}
	return var_order.dup()
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_request_status() rt.PhpVal {
	mut var_status := if !(!rt.is_true(rt.get_superglobal('_GET').array_get('status'))) { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('status')])]) } else { rt.new_string('') }
	return var_status.dup()
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_request_search_query() rt.PhpVal {
	mut var_search_query := if !(!rt.is_true(rt.get_superglobal('_GET').array_get('s'))) { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('s')])]) } else { rt.new_string('') }
	return var_search_query.dup()
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_table_columns() rt.PhpVal {
	mut var_columns := rt.func_array_keys(this.columns)
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [this.ID, var_columns.dup(), rt.new_bool(true)]))))) {
		var_columns.array_push(this.ID)
	}
	return var_columns.dup()
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_items_query_search() string {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if !rt.is_true(rt.get_superglobal('_GET').array_get('s')) || !rt.is_true(this.search_by) {
		return ''
	}
	mut var_search_string := rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('s')])])
	mut var_filter := rt.new_array()
	{
		mut iter_1 := this.search_by.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_column := item_1.val
			mut var_wild := rt.new_string(rt.new_string('%'))
			mut var_sql_like := rt.new_string((var_wild).str() + (rt.call_method(var_wpdb, 'esc_like', [var_search_string.dup()])).str() + (var_wild).str())
			var_filter << rt.call_method(var_wpdb, 'prepare', ['`' + (var_column).str() + '` LIKE %s', var_sql_like.dup()])
			// unsupported statement: Stmt_Nop
		}
	}
	return (rt.call_function('implode', [rt.new_string(' OR '), var_filter.dup()])).str()
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_items_query_filters() string {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(this.filter_by)))) || !rt.is_true(rt.get_superglobal('_GET').array_get('filter_by')))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_get('filter_by').is_array()))))))) {
		return ''
	}
	mut var_filter := rt.new_array()
	{
		mut iter_1 := this.filter_by.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_options := item_1.val
			mut var_column := item_1.key
			if !rt.is_true(rt.get_superglobal('_GET').array_get('filter_by').array_get(var_column)) || !rt.is_true(var_options.array_get(rt.get_superglobal('_GET').array_get('filter_by').array_get(var_column))) {
				continue
			}
			var_filter << rt.call_method(var_wpdb, 'prepare', [rt.new_string("`${var_column.to_string()}` = %s"), rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('filter_by').array_get(var_column)])])])
			// unsupported statement: Stmt_Nop
		}
	}
	return (rt.call_function('implode', [rt.new_string(' AND '), var_filter.dup()])).str()
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) prepare_items()  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	this.process_bulk_action()
	this.process_row_actions()
	if !(!(rt.is_true(rt.get_superglobal('_REQUEST').array_get('_wp_http_referer')) && !(!rt.is_true(rt.get_superglobal('_SERVER').array_get('REQUEST_URI'))))) {
		rt.call_function('wp_safe_redirect', [rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: '_wp_http_referer' }, rt.ArrayItem{ key: none, val: '_wpnonce' }]), rt.call_function('esc_url_raw', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('REQUEST_URI')])])])])
		// unsupported expression: Expr_Exit
	}
	this.prepare_column_headers()
	mut var_limit := this.get_items_query_limit()
	mut var_offset := this.get_items_query_offset()
	mut var_order := rt.new_string(this.get_items_query_order())
	mut var_where := rt.call_function('array_filter', [rt.create_array([rt.ArrayItem{ key: none, val: this.get_items_query_search() }, rt.ArrayItem{ key: none, val: this.get_items_query_filters() }])])
	mut var_columns := rt.new_string('`' + (rt.call_function('implode', [rt.new_string('`, `'), this.get_table_columns()])).str() + '`')
	if !(!rt.is_true(var_where)) {
		var_where = rt.new_string('WHERE (' + (rt.call_function('implode', [rt.new_string(') AND ('), var_where.dup()])).str() + ')')
	} else {
		var_where = rt.new_string(rt.new_string(''))
	}
	mut var_sql := rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT '), var_columns), rt.new_string(' FROM ')), this.table_name), rt.new_string(' ')), var_where), rt.new_string(' ')), var_order), rt.new_string(' ')), var_limit), rt.new_string(' ')), var_offset))
	this.set_items(mut rt.cast_object_ptr[Class_array](rt.call_method(var_wpdb, 'get_results', [var_sql.dup(), rt.get_constant('ARRAY_A')])))
	mut var_query_count := rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT COUNT('), this.ID), rt.new_string(') FROM ')), this.table_name), rt.new_string(' ')), var_where))
	mut var_total_items := rt.call_method(var_wpdb, 'get_var', [var_query_count.dup()])
	mut var_per_page := this.get_items_per_page(rt.new_string(this.get_per_page_option_name()), this.items_per_page)
	this.set_pagination_args(rt.create_array([rt.ArrayItem{ key: 'total_items', val: var_total_items }, rt.ArrayItem{ key: 'per_page', val: var_per_page }, rt.ArrayItem{ key: 'total_pages', val: rt.call_function('ceil', [rt.div(, )]) }]))
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) extra_tablenav(var_which rt.PhpVal)  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(this.filter_by)))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	print('<div class="alignleft actions">')
	{
		mut iter_1 := this.filter_by.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_options := item_1.val
			mut var_id := item_1.key
			
		}
	}
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) set_items(mut var_items Class_array)  {
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) column_cb(var_row rt.PhpVal) string {
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) maybe_render_actions(var_row rt.PhpVal, var_column_name rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) process_row_actions()  {
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) column_default(var_item rt.PhpVal, var_column_name rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) display_header()  {
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) display_admin_notices()  {
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) display_filter_by_status()  {
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) display_table()  {
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) process_actions()  {
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) display_page()  {
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_search_box_placeholder() rt.PhpVal {
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) get_per_page_option_name() string {
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

fn create_actionscheduler_abstract_listtable() &Class_ActionScheduler_Abstract_ListTable {
	mut obj := &Class_ActionScheduler_Abstract_ListTable{
		PhpObjectBase: rt.PhpObjectBase{}
		table_name: rt.new_null()
		package: rt.new_null()
		items_per_page: rt.new_int(10)
		search_by: rt.new_array()
		columns: rt.new_array()
		row_actions: rt.new_array()
		ID: rt.new_string('ID')
		sort_by: rt.new_array()
		filter_by: rt.new_array()
		status_counts: rt.new_array()
		admin_notices: rt.new_array()
		table_header: rt.new_null()
		bulk_actions: rt.new_array()
	}
	return obj
}

fn create_wp_list_table() &Class_WP_List_Table {
	mut obj := &Class_WP_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_runtimeexception() &Class_RuntimeException {
	mut obj := &Class_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler() &Class_ActionScheduler {
	mut obj := &Class_ActionScheduler{
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
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
		else { return none }
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
		'table_name' { this.table_name = val; return true }
		'package' { this.package = val; return true }
		'items_per_page' { this.items_per_page = val; return true }
		'search_by' { this.search_by = val; return true }
		'columns' { this.columns = val; return true }
		'row_actions' { this.row_actions = val; return true }
		'ID' { this.ID = val; return true }
		'sort_by' { this.sort_by = val; return true }
		'filter_by' { this.filter_by = val; return true }
		'status_counts' { this.status_counts = val; return true }
		'admin_notices' { this.admin_notices = val; return true }
		'table_header' { this.table_header = val; return true }
		'bulk_actions' { this.bulk_actions = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_abstracts_actionscheduler_abstract_listtable_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WP_List_Table')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-list-table.php', '4')
	}
}
