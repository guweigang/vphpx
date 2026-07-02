import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_SearchListTable.per_page_user_option_key() string {
	return 'woocommerce_logging_search_results_per_page'
}

struct Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_SearchListTable {
	rt.PhpObjectBase
pub mut:
	file_controller rt.PhpVal = rt.new_null()
	page_controller rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_SearchListTable) construct(mut var_file_controller Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController, mut var_page_controller Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) {
	this.file_controller = var_file_controller
	this.page_controller = var_page_controller
	this.Class_WP_List_Table.construct(rt.create_array([
		rt.ArrayItem{ key: 'singular', val: 'wc-logs-search-result' },
		rt.ArrayItem{ key: 'plural', val: 'wc-logs-search-results' },
		rt.ArrayItem{ key: 'ajax', val: false },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_SearchListTable) no_items() {
	rt.call_function('esc_html_e', [rt.new_string('No search results.'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_SearchListTable) prepare_column_headers() {
	this.dispatch_set_prop('_column_headers', rt.create_array([
		rt.ArrayItem{ key: none, val: this.get_columns() },
		rt.ArrayItem{ key: none, val: rt.new_array() },
		rt.ArrayItem{ key: none, val: rt.new_array() },
		rt.ArrayItem{ key: none, val: this.get_primary_column() },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_SearchListTable) prepare_items() {
	mut var_per_page := this.get_items_per_page(Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_SearchListTable.per_page_user_option_key(),
		rt.new_int(this.get_per_page_default()))
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'per_page', val: var_per_page },
		rt.ArrayItem{ key: 'offset', val: rt.mul(rt.sub(this.get_pagenum(), rt.new_int(1)),
			var_per_page) }])
	mut var_file_args := rt.call_method(this.page_controller, 'get_query_params', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'date_end' },
			rt.ArrayItem{ key: none, val: 'date_filter' }, rt.ArrayItem{
				key: none
				val: 'date_start'
			}, rt.ArrayItem{ key: none, val: 'order' }, rt.ArrayItem{ key: none, val: 'orderby' },
			rt.ArrayItem{ key: none, val: 'search' }, rt.ArrayItem{ key: none, val: 'source' }]),
	])
	mut var_search := var_file_args.array_get(rt.new_string('search'))
	var_file_args.array_unset(rt.new_string('search'))
	mut var_total_items := rt.call_method(this.file_controller, 'search_within_files', [
		var_search.clone(),
		var_args.clone(),
		var_file_args.clone(),
		rt.new_bool(true),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_total_items.clone()])) {
		rt.call_function('printf', [
			rt.new_string('<div class="notice notice-warning"><p>%s</p></div>'),
			rt.call_function('esc_html', [
				rt.call_method(var_total_items, 'get_error_message', []rt.PhpVal{}),
			]),
		])
		return
	}
	if rt.is_true(rt.greater_equal(var_total_items, Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_{
		nodeType: 'Expr_PropertyFetch'
		line:     109
		var:      {
			'nodeType': 'Expr_Variable'
			'line':     109
			'name':     'this'
		}
		name:     'file_controller'
	}.search_max_results()))
	{
		rt.call_function('printf', [
			rt.new_string('<div class="notice notice-info"><p>%s</p></div>'),
			rt.call_function('sprintf', [
				rt.call_function('esc_html__', [
					rt.new_string('The number of search results has reached the limit of %s. Try refining your search.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_html', [
					rt.call_function('number_format_i18n', [Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_{
						nodeType: 'Expr_PropertyFetch'
						line:     115
						var:      {
							'nodeType': 'Expr_Variable'
							'line':     115
							'name':     'this'
						}
						name:     'file_controller'
					}.search_max_results()]),
				]),
			]),
		])
	}
	mut var_total_pages := rt.call_function('ceil', [
		rt.div(var_total_items, var_per_page),
	])
	mut var_results := rt.call_method(this.file_controller, 'search_within_files', [
		var_search.clone(),
		var_args.clone(),
		var_file_args.clone(),
	])
	this.dispatch_set_prop('items', var_results.clone())
	this.set_pagination_args(rt.create_array([
		rt.ArrayItem{ key: 'per_page', val: var_per_page },
		rt.ArrayItem{ key: 'total_items', val: var_total_items },
		rt.ArrayItem{ key: 'total_pages', val: var_total_pages },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_SearchListTable) get_columns() rt.PhpVal {
	mut var_columns := rt.create_array([
		rt.ArrayItem{ key: 'file_id', val: rt.call_function('esc_html__', [
			rt.new_string('File'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'line_number', val: rt.call_function('esc_html__', [
			rt.new_string('Line #'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'line', val: rt.call_function('esc_html__', [
			rt.new_string('Matched Line'),
			rt.new_string('woocommerce'),
		]) },
	])
	return var_columns.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_SearchListTable) column_file_id(mut var_item Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array) string {
	mut var_file_id := rt.call_function('preg_replace', [
		rt.new_string('/\\.([0-9])+\\-/'),
		rt.new_string('.\\1<wbr>-'),
		var_item.array_get(rt.new_string('file_id')),
	])
	return (rt.call_function('wp_kses', [var_file_id.clone(),
		rt.create_array([rt.ArrayItem{ key: 'wbr', val: rt.new_array() }])])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_SearchListTable) column_line_number(mut var_item Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array) string {
	mut var_match_url := rt.call_function('add_query_arg', [
		rt.create_array([rt.ArrayItem{ key: 'view', val: 'single_file' },
			rt.ArrayItem{ key: 'file_id', val: var_item.array_get(rt.new_string('file_id')) }]),
		rt.new_string(
			(rt.call_method(this.page_controller, 'get_logs_tab_url', []rt.PhpVal{})).str() + '#L' +
			(rt.call_function('absint', [var_item.array_get(rt.new_string('line_number'))])).str()),
	])
	return (rt.call_function('sprintf', [rt.new_string('<a href="%1$s">%2$s</a>'),
		rt.call_function('esc_url', [var_match_url.clone()]),
		rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('Line %s'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('number_format_i18n', [
				rt.call_function('absint', [var_item.array_get(rt.new_string('line_number'))]),
			]),
		])])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_SearchListTable) column_line(mut var_item Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array) string {
	mut var_matches := rt.new_null()
	mut var_params := rt.call_method(this.page_controller, 'get_query_params', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'search' }]),
	])
	mut var_line := var_item.array_get(rt.new_string('line'))
	mut var_pattern := rt.call_function('preg_quote', [
		var_params.array_get(rt.new_string('search')),
		rt.new_string('/'),
	])
	rt.call_function('preg_match_all', [rt.new_string('/${var_pattern.to_string()}/i'),
		var_line.clone(), var_matches.clone(), rt.get_constant('PREG_OFFSET_CAPTURE')])
	if var_matches.array_get(rt.new_int(0)).is_array()
		&& var_matches.array_get(rt.new_int(0)).array_count() >= 1 {
		mut var_length_change := rt.new_int(0)
		mut iter_1 := var_matches.array_get(rt.new_int(0)).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_match := item_1.val
			mut var_replace := rt.new_string('<span class="search-match">' +
				(var_match.array_get(rt.new_int(0))).str() + '</span>')
			mut var_offset := rt.add(var_match.array_get(rt.new_int(1)), var_length_change)
			mut var_orig_length := rt.new_int(var_match.array_get(rt.new_int(0)).to_string().len)
			mut var_replace_length := rt.new_int(var_replace.clone().to_string().len)
			var_line = rt.call_function('substr_replace', [var_line.clone(),
				var_replace.clone(), var_offset.clone(), var_orig_length.clone()])
			var_length_change = rt.add(var_length_change, rt.sub(var_replace_length,
				var_orig_length))
		}
	}
	return (rt.call_function('wp_kses_post', [var_line.clone()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_SearchListTable) get_per_page_default() i64 {
	return (Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_{
		nodeType: 'Expr_PropertyFetch'
		line:     227
		var:      {
			'nodeType': 'Expr_Variable'
			'line':     227
			'name':     'this'
		}
		name:     'file_controller'
	}.defaults_search_within_files().array_get(rt.new_string('per_page'))).to_i64()
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_logging_filev2_searchlisttable(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_SearchListTable {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_SearchListTable{
		PhpObjectBase:   rt.PhpObjectBase{}
		file_controller: rt.new_null()
		page_controller: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_wp_list_table(_args ...rt.PhpVal) &Class_WP_List_Table {
	mut obj := &Class_WP_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_SearchListTable) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'column_file_id' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.column_file_id(mut dispatch_arg_0))
		}
		'column_line_number' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.column_line_number(mut dispatch_arg_0))
		}
		'column_line' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.column_line(mut dispatch_arg_0))
		}
		'get_per_page_default' {
			return rt.new_int(this.get_per_page_default())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_SearchListTable) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'file_controller' { return this.file_controller }
		'page_controller' { return this.page_controller }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_SearchListTable) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
