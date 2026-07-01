import rt
import crypto.md5

pub fn Class_WC_Admin_Log_Table_List.per_page_user_option_key() string {
	return 'woocommerce_status_log_items_per_page'
}
pub fn Class_WC_Admin_Log_Table_List.source_cache_option_key() string {
	return 'woocommerce_status_log_db_sources'
}
pub fn Class_WC_Admin_Log_Table_List.item_count_cache_threshold() i64 {
	return 100000
}
struct Class_WC_Admin_Log_Table_List {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Admin_Log_Table_List) construct()  {
	this.Class_WP_List_Table.construct(rt.create_array([rt.ArrayItem{ key: 'singular', val: 'log' }, rt.ArrayItem{ key: 'plural', val: 'logs' }, rt.ArrayItem{ key: 'ajax', val: false }]))
}

fn (mut this Class_WC_Admin_Log_Table_List) level_dropdown()  {
	mut var_labels := fn () rt.PhpVal { mut temp := Class_WC_Log_Levels{}; return temp.get_all_level_labels() }()
	closure_1_fn := fn [var_labels] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_carry := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_item := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	var_carry.array_push(rt.create_array([rt.ArrayItem{ key: 'value', val: var_item }, rt.ArrayItem{ key: 'label', val: var_labels.array_get(var_item) }]))
	return var_carry.dup()
	}
	mut var_levels := rt.call_function('array_reduce', [rt.func_array_keys(var_labels.dup()), rt.new_closure(closure_1_fn), rt.new_array()])
	mut var_selected_level := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('level')) { rt.get_superglobal('_REQUEST').array_get('level') } else { rt.new_string('') }
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Filter by level'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_selected_level.dup(), rt.new_string('')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('All levels'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_levels.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_l := item_1.val
			rt.call_function('printf', [rt.new_string('<option%1$s value="%2$s">%3$s</option>'), rt.call_function('selected', [var_selected_level.dup(), var_l.array_get('value'), rt.new_bool(false)]), rt.call_function('esc_attr', [var_l.array_get('value')]), rt.call_function('esc_html', [var_l.array_get('label')])])
		}
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Log_Table_List) display_rows()  {
	{
		mut iter_1 := rt.get_property(rt.new_object('WC_Admin_Log_Table_List', ['WP_List_Table'], &this), 'items').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_log := item_1.val
			this.single_row(var_log.dup())
			if !(!rt.is_true(var_log.array_get('context'))) {
				this.context_row(var_log.dup())
			}
		}
	}
}

fn (mut this Class_WC_Admin_Log_Table_List) context_row(var_log rt.PhpVal)  {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_log.array_get('log_id')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_column_count()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Additional context'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_log.array_get('context')]))
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Log_Table_List) get_columns() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'cb', val: '<input type="checkbox" />' }, rt.ArrayItem{ key: 'timestamp', val: rt.call_function('__', [rt.new_string('Timestamp'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'level', val: rt.call_function('__', [rt.new_string('Level'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('Message'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'source', val: rt.call_function('__', [rt.new_string('Source'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'context', val: rt.call_function('__', [rt.new_string('Context'), rt.new_string('woocommerce')]) }])
}

fn (mut this Class_WC_Admin_Log_Table_List) column_cb(var_log rt.PhpVal) rt.PhpVal {
	return rt.call_function('sprintf', [rt.new_string('<input type="checkbox" name="log[]" value="%1$s" />'), rt.call_function('esc_attr', [var_log.array_get('log_id')])])
}

fn (mut this Class_WC_Admin_Log_Table_List) column_timestamp(var_log rt.PhpVal) rt.PhpVal {
	return rt.call_function('esc_html', [rt.call_function('mysql2date', [rt.new_string('Y-m-d H:i:s'), var_log.array_get('timestamp')])])
}

fn (mut this Class_WC_Admin_Log_Table_List) column_level(var_log rt.PhpVal) string {
	mut var_level_key := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Log_Levels{}; return temp.get_severity_level(arg_0) }(var_log.array_get('level'))
	mut var_levels := fn () rt.PhpVal { mut temp := Class_WC_Log_Levels{}; return temp.get_all_level_labels() }()
	if !(var_levels.array_isset(var_level_key)) {
		return ''
	}
	mut var_level := var_levels.array_get(var_level_key)
	mut var_level_class := rt.call_function('sanitize_html_class', ['log-level--' + (var_level_key).str()])
	return '<span class="log-level ' + (var_level_class).str() + '">' + (rt.call_function('esc_html', [var_level.dup()])).str() + '</span>'
}

fn (mut this Class_WC_Admin_Log_Table_List) column_message(var_log rt.PhpVal) rt.PhpVal {
	return rt.call_function('sprintf', [rt.new_string('<pre>%s</pre>'), rt.call_function('esc_html', [var_log.array_get('message')])])
}

fn (mut this Class_WC_Admin_Log_Table_List) column_source(var_log rt.PhpVal) rt.PhpVal {
	return rt.call_function('esc_html', [var_log.array_get('source')])
}

fn (mut this Class_WC_Admin_Log_Table_List) column_context(var_log rt.PhpVal) rt.PhpVal {
	mut var_content := rt.new_string(rt.new_string(''))
	if !(!rt.is_true(var_log.array_get('context'))) {
		rt.call_function('ob_start', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_log.array_get('log_id')]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Show context'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Hide context'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Show context'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		var_content = rt.call_function('ob_get_clean', []rt.PhpVal{})
	}
	return var_content.dup()
}

fn (mut this Class_WC_Admin_Log_Table_List) get_bulk_actions() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'delete', val: rt.call_function('__', [rt.new_string('Delete'), rt.new_string('woocommerce')]) }])
}

fn (mut this Class_WC_Admin_Log_Table_List) extra_tablenav(var_which rt.PhpVal)  {
	if rt.is_true(rt.identical(rt.new_string('top'), var_which)) {
		print('<div class="alignleft actions">')
		this.level_dropdown()
		this.source_dropdown()
		rt.call_function('submit_button', [rt.call_function('__', [rt.new_string('Filter'), rt.new_string('woocommerce')]), rt.new_string(''), rt.new_string('filter-action'), rt.new_bool(false)])
		print('</div>')
	}
}

fn (mut this Class_WC_Admin_Log_Table_List) get_sortable_columns() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'timestamp', val: rt.create_array([rt.ArrayItem{ key: none, val: 'timestamp' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: 'level', val: rt.create_array([rt.ArrayItem{ key: none, val: 'level' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: 'source', val: rt.create_array([rt.ArrayItem{ key: none, val: 'source' }, rt.ArrayItem{ key: none, val: true }]) }])
}

fn (mut this Class_WC_Admin_Log_Table_List) source_dropdown()  {
	mut var_sources := this.get_sources()
	if !(!rt.is_true(var_sources)) {
		mut var_selected_source := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('source')) { rt.get_superglobal('_REQUEST').array_get('source') } else { rt.new_string('') }
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Filter by source'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('selected', [var_selected_source.dup(), rt.new_string('')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('All sources'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		{
			mut iter_1 := var_sources.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_s := item_1.val
				rt.call_function('printf', [rt.new_string('<option%1$s value="%2$s">%3$s</option>'), rt.call_function('selected', [var_selected_source.dup(), var_s.dup(), rt.new_bool(false)]), rt.call_function('esc_attr', [var_s.dup()]), rt.call_function('esc_html', [var_s.dup()])])
			}
		}
		// unsupported statement: Stmt_InlineHTML
	}
}

fn (mut this Class_WC_Admin_Log_Table_List) get_sources() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_sources := rt.call_function('get_option', [Class_WC_Admin_Log_Table_List.source_cache_option_key(), rt.new_null()])
	if rt.is_true(rt.new_bool(var_sources.dup().is_array())) {
		return var_sources.dup()
	}
	mut var_sql := rt.new_string(rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT DISTINCT source\n\t\t\tFROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_log\n\t\t\tWHERE source != \'\'\n\t\t\tORDER BY source ASC\n\t\t')))
	var_sources = rt.call_method(var_wpdb, 'get_col', [var_sql.dup()])
	rt.call_function('update_option', [Class_WC_Admin_Log_Table_List.source_cache_option_key(), var_sources.dup()])
	return var_sources.dup()
}

fn (mut this Class_WC_Admin_Log_Table_List) prepare_items()  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	this.prepare_column_headers()
	mut var_per_page := this.get_items_per_page(rt.new_string(Class_WC_Admin_Log_Table_List.per_page_user_option_key()), rt.new_int(this.get_per_page_default()))
	mut var_where := rt.new_string(this.get_items_query_where())
	mut var_order := this.get_items_query_order()
	mut var_limit := this.get_items_query_limit()
	mut var_offset := this.get_items_query_offset()
	mut var_query_items := rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT log_id, timestamp, level, message, source, context\n\t\t\tFROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_log\n\t\t\t')), var_where), rt.new_string(' ')), var_order), rt.new_string(' ')), var_limit), rt.new_string(' ')), var_offset), rt.new_string('\n\t\t')))
	this.dispatch_set_prop('items', rt.call_method(var_wpdb, 'get_results', [var_query_items.dup(), rt.get_constant('ARRAY_A')]))
	mut var_total_items := this.get_total_items_count()
	this.set_pagination_args(rt.create_array([rt.ArrayItem{ key: 'total_items', val: var_total_items }, rt.ArrayItem{ key: 'per_page', val: var_per_page }, rt.ArrayItem{ key: 'total_pages', val: rt.call_function('ceil', [rt.div(var_total_items, var_per_page)]) }]))
}

fn (mut this Class_WC_Admin_Log_Table_List) get_total_items_count() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_where := rt.new_string(this.get_items_query_where())
	mut var_version := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.get_transient_version(arg_0) }(rt.new_string('logs-db'))
	mut var_transient_key := rt.new_string('wc-log-total-items-count-' + md5.hexhash(.dup().to_string()))
	mut var_transient := rt.call_function('get_transient', [.dup()])
	if rt.is_true(rt.new_bool(rt.is_true() && rt.is_true())) {
		return 
	}
	
}

fn (mut this Class_WC_Admin_Log_Table_List) get_items_query_limit() rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_Admin_Log_Table_List) get_items_query_offset() rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_Admin_Log_Table_List) get_items_query_order() rt.PhpVal {
}

fn (mut this Class_WC_Admin_Log_Table_List) get_items_query_where() string {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_Admin_Log_Table_List) prepare_column_headers()  {
}

fn (mut this Class_WC_Admin_Log_Table_List) get_per_page_default() i64 {
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

struct Class_WC_Log_Levels {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

fn create_wc_admin_log_table_list() &Class_WC_Admin_Log_Table_List {
	mut obj := &Class_WC_Admin_Log_Table_List{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wp_list_table() &Class_WP_List_Table {
	mut obj := &Class_WP_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_log_levels() &Class_WC_Log_Levels {
	mut obj := &Class_WC_Log_Levels{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cache_helper() &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_Log_Table_List) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'level_dropdown' {
			this.level_dropdown()
			return rt.new_null()
		}
		'display_rows' {
			this.display_rows()
			return rt.new_null()
		}
		'context_row' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.context_row(dispatch_arg_0)
			return rt.new_null()
		}
		'get_columns' {
			return this.get_columns()
		}
		'column_cb' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.column_cb(dispatch_arg_0)
		}
		'column_timestamp' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.column_timestamp(dispatch_arg_0)
		}
		'column_level' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.column_level(dispatch_arg_0))
		}
		'column_message' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.column_message(dispatch_arg_0)
		}
		'column_source' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.column_source(dispatch_arg_0)
		}
		'column_context' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.column_context(dispatch_arg_0)
		}
		'get_bulk_actions' {
			return this.get_bulk_actions()
		}
		'extra_tablenav' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.extra_tablenav(dispatch_arg_0)
			return rt.new_null()
		}
		'get_sortable_columns' {
			return this.get_sortable_columns()
		}
		'source_dropdown' {
			this.source_dropdown()
			return rt.new_null()
		}
		'get_sources' {
			return this.get_sources()
		}
		'prepare_items' {
			this.prepare_items()
			return rt.new_null()
		}
		'get_total_items_count' {
			return this.get_total_items_count()
		}
		'get_items_query_limit' {
			return this.get_items_query_limit()
		}
		'get_items_query_offset' {
			return this.get_items_query_offset()
		}
		'get_items_query_order' {
			return this.get_items_query_order()
		}
		'get_items_query_where' {
			return rt.new_string(this.get_items_query_where())
		}
		'prepare_column_headers' {
			this.prepare_column_headers()
			return rt.new_null()
		}
		'get_per_page_default' {
			return rt.new_int(this.get_per_page_default())
		}
		else { return none }
	}
}

fn (this &Class_WC_Admin_Log_Table_List) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Log_Table_List) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_WC_Log_Levels) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Log_Levels) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Log_Levels) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_class_wc_admin_log_table_list_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WP_List_Table')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-list-table.php', '4')
	}
}
