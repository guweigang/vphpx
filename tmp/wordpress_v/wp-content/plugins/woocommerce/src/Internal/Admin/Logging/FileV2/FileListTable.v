import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileListTable.per_page_user_option_key() string {
	return 'woocommerce_logging_file_list_per_page'
}

struct Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileListTable {
	rt.PhpObjectBase
pub mut:
	file_controller rt.PhpVal = rt.new_null()
	page_controller rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileListTable) construct(mut var_file_controller Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController, mut var_page_controller Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) {
	this.file_controller = var_file_controller.dup()
	this.page_controller = var_page_controller.dup()
	this.Class_WP_List_Table.construct(rt.create_array([
		rt.ArrayItem{ key: 'singular', val: 'log-file' },
		rt.ArrayItem{ key: 'plural', val: 'log-files' },
		rt.ArrayItem{ key: 'ajax', val: false },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileListTable) no_items() {
	rt.call_function('esc_html_e', [rt.new_string('No log files found.'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileListTable) get_bulk_actions() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'export', val: rt.call_function('esc_html__', [
			rt.new_string('Download'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'delete', val: rt.call_function('esc_html__', [
			rt.new_string('Delete permanently'),
			rt.new_string('woocommerce'),
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileListTable) get_sources_list() rt.PhpVal {
	mut var_sources := rt.call_method(this.file_controller, 'get_file_sources', []rt.PhpVal{})
	if rt.is_true(rt.call_function('is_wp_error', [var_sources.dup()])) {
		return rt.new_array()
	}
	rt.call_function('sort', [var_sources.dup()])
	return var_sources.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileListTable) extra_tablenav(var_which rt.PhpVal) {
	mut var_all_sources := this.get_sources_list()
	mut var_current_source := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File{}
		return temp.sanitize_source(arg_0)
	}(rt.call_function('wp_unslash', [if !(rt.get_superglobal('_GET').array_get('source')).is_null() {
		rt.get_superglobal('_GET').array_get('source')
	} else {
		rt.new_string('')
	}]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_string('top'), var_which)) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Filter by log source'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('selected', [var_current_source.dup(),
			rt.new_string('')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('All sources'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		{
			mut iter_1 := var_all_sources.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_source := item_1.val
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('selected', [var_current_source.dup(),
					var_source.dup()])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_source.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [var_source.dup()]))
				// unsupported statement: Stmt_InlineHTML
			}
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('submit_button', [
			rt.call_function('__', [rt.new_string('Filter'), rt.new_string('woocommerce')]),
			rt.new_string(''),
			rt.new_string('filter_action'),
			rt.new_bool(false),
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'logs-filter-submit' }]),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileListTable) prepare_column_headers() {
	this.dispatch_set_prop('_column_headers', rt.create_array([
		rt.ArrayItem{ key: none, val: this.get_columns() },
		rt.ArrayItem{ key: none, val: rt.call_function('get_hidden_columns', [
			rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileListTable', [
				'WP_List_Table',
			], &this), 'screen'),
		]) },
		rt.ArrayItem{ key: none, val: this.get_sortable_columns() },
		rt.ArrayItem{ key: none, val: this.get_primary_column() },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileListTable) prepare_items() {
	mut var_per_page := this.get_items_per_page(Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileListTable.per_page_user_option_key(),
		rt.new_int(this.get_per_page_default()))
	mut var_defaults := rt.create_array([
		rt.ArrayItem{ key: 'per_page', val: var_per_page },
		rt.ArrayItem{ key: 'offset', val: rt.mul(rt.sub(this.get_pagenum(), rt.new_int(1)),
			var_per_page) },
	])
	mut var_file_args := rt.call_function('wp_parse_args', [
		rt.call_method(this.page_controller, 'get_query_params', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'order' },
				rt.ArrayItem{ key: none, val: 'orderby' }, rt.ArrayItem{ key: none, val: 'source' }]),
		]),
		var_defaults.dup(),
	])
	mut var_total_items := rt.call_method(this.file_controller, 'get_files', [
		var_file_args.dup(), rt.new_bool(true)])
	if rt.is_true(rt.call_function('is_wp_error', [var_total_items.dup()])) {
		rt.call_function('printf', [
			rt.new_string('<div class="notice notice-warning"><p>%s</p></div>'),
			rt.call_function('esc_html', [
				rt.call_method(var_total_items, 'get_error_message', []rt.PhpVal{}),
			]),
		])
		return rt.new_null()
	}
	mut var_total_pages := rt.call_function('ceil', [
		rt.div(var_total_items, var_per_page),
	])
	mut var_items := rt.call_method(this.file_controller, 'get_files', [
		var_file_args.dup()])
	this.dispatch_set_prop('items', var_items.dup())
	this.set_pagination_args(rt.create_array([
		rt.ArrayItem{ key: 'per_page', val: var_per_page },
		rt.ArrayItem{ key: 'total_items', val: var_total_items },
		rt.ArrayItem{ key: 'total_pages', val: var_total_pages },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileListTable) get_columns() rt.PhpVal {
	mut var_columns := rt.create_array([
		rt.ArrayItem{ key: 'cb', val: '<input type="checkbox" />' },
		rt.ArrayItem{ key: 'source', val: rt.call_function('esc_html__', [
			rt.new_string('Source'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'created', val: rt.call_function('esc_html__', [
			rt.new_string('Date created'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'modified', val: rt.call_function('esc_html__', [
			rt.new_string('Date modified'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'size', val: rt.call_function('esc_html__', [
			rt.new_string('File size'),
			rt.new_string('woocommerce'),
		]) },
	])
	return var_columns.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileListTable) get_sortable_columns() rt.PhpVal {
	mut var_sortable := rt.create_array([
		rt.ArrayItem{ key: 'source', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'source' },
		]) },
		rt.ArrayItem{ key: 'created', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'created' },
		]) },
		rt.ArrayItem{ key: 'modified', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'modified' },
			rt.ArrayItem{ key: none, val: true },
		]) },
		rt.ArrayItem{ key: 'size', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'size' },
		]) },
	])
	return var_sortable.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileListTable) column_cb(var_item rt.PhpVal) string {
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_item, 'get_file_id', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_item, 'get_file_id', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_item, 'get_file_id', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('esc_html__', [
			rt.new_string('Select the %1$s log file for %2$s'),
			rt.new_string('woocommerce'),
		]),
		rt.call_function('esc_html', [
			rt.call_function('gmdate', [
				rt.call_function('get_option', [rt.new_string('date_format')]),
				rt.call_method(var_item, 'get_created_timestamp', []rt.PhpVal{}),
			]),
		]),
		rt.call_function('esc_html', [
			rt.call_method(var_item, 'get_source', []rt.PhpVal{}),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	return (rt.call_function('ob_get_clean', []rt.PhpVal{})).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileListTable) column_source(var_item rt.PhpVal) string {
	mut var_log_file := rt.call_method(var_item, 'get_file_id', []rt.PhpVal{})
	mut var_single_file_url := rt.call_function('add_query_arg', [
		rt.create_array([rt.ArrayItem{ key: 'view', val: 'single_file' },
			rt.ArrayItem{ key: 'file_id', val: var_log_file }]),
		rt.call_method(this.page_controller, 'get_logs_tab_url', []rt.PhpVal{}),
	])
	mut var_rotation := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.call_method(var_item, 'get_rotation',
		[]rt.PhpVal{}).is_null())))))
	{
		var_rotation = rt.call_function('sprintf', [
			rt.new_string(' &ndash; <span class="post-state">%d</span>'),
			rt.call_method(var_item, 'get_rotation', []rt.PhpVal{}),
		])
	}
	return (rt.call_function('sprintf', [
		rt.new_string('<a class="row-title" href="%1$s">%2$s</a>%3$s'),
		rt.call_function('esc_url', [var_single_file_url.dup()]),
		rt.call_function('esc_html', [rt.call_method(var_item, 'get_source', []rt.PhpVal{})]),
		var_rotation.dup(),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileListTable) column_created(var_item rt.PhpVal) string {
	mut var_timestamp := rt.call_method(var_item, 'get_created_timestamp', []rt.PhpVal{})
	return (rt.call_function('gmdate', [rt.new_string('Y-m-d'),
		var_timestamp.dup()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileListTable) column_modified(var_item rt.PhpVal) string {
	mut var_timestamp := rt.call_method(var_item, 'get_modified_timestamp', []rt.PhpVal{})
	return (rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'),
		var_timestamp.dup()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileListTable) column_size(var_item rt.PhpVal) string {
	mut var_size := rt.call_method(var_item, 'get_file_size', []rt.PhpVal{})
	return (rt.call_function('size_format', [var_size.dup()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileListTable) get_per_page_default() i64 {
	return (Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_{
		nodeType: 'Expr_PropertyFetch'
		line:     332
		var:      {
			'nodeType': 'Expr_Variable'
			'line':     332
			'name':     'this'
		}
		name:     'file_controller'
	}.defaults_get_files().array_get('per_page')).to_i64()
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_logging_filev2_filelisttable(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileListTable {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileListTable{
		PhpObjectBase:   rt.PhpObjectBase{}
		file_controller: rt.new_null()
		page_controller: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_wp_list_table() &Class_WP_List_Table {
	mut obj := &Class_WP_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_logging_filev2_file() &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileListTable) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'no_items' {
			this.no_items()
			return rt.new_null()
		}
		'get_bulk_actions' {
			return this.get_bulk_actions()
		}
		'get_sources_list' {
			return this.get_sources_list()
		}
		'extra_tablenav' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.extra_tablenav(dispatch_arg_0)
			return rt.new_null()
		}
		'prepare_column_headers' {
			this.prepare_column_headers()
			return rt.new_null()
		}
		'prepare_items' {
			this.prepare_items()
			return rt.new_null()
		}
		'get_columns' {
			return this.get_columns()
		}
		'get_sortable_columns' {
			return this.get_sortable_columns()
		}
		'column_cb' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.column_cb(dispatch_arg_0))
		}
		'column_source' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.column_source(dispatch_arg_0))
		}
		'column_created' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.column_created(dispatch_arg_0))
		}
		'column_modified' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.column_modified(dispatch_arg_0))
		}
		'column_size' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.column_size(dispatch_arg_0))
		}
		'get_per_page_default' {
			return rt.new_int(this.get_per_page_default())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileListTable) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'file_controller' { return this.file_controller }
		'page_controller' { return this.page_controller }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileListTable) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'file_controller' {
			this.file_controller = val
			return true
		}
		'page_controller' {
			this.page_controller = val
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_admin_logging_filev2_filelisttable_php() {
	// unsupported statement: Stmt_Declare
}
