import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController {
	rt.PhpObjectBase
pub mut:
		file_controller rt.PhpVal = rt.new_null()
		settings rt.PhpVal = rt.new_null()
		list_table rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) init(mut var_file_controller Class_Automattic_WooCommerce_Internal_Admin_Logging_FileController, mut var_settings Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings) {
	this.file_controller = var_file_controller
	this.settings = var_settings
	this.init_hooks()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) init_hooks() {
	rt.call_function('add_action', [rt.new_string('load-woocommerce_page_wc-status'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Logging_PageController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'maybe_do_logs_tab_action' }]), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('wc_logs_load_tab'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Logging_PageController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'setup_screen_options' }])])
	rt.call_function('add_action', [rt.new_string('wc_logs_load_tab'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Logging_PageController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_list_table_bulk_actions' }])])
	rt.call_function('add_action', [rt.new_string('wc_logs_load_tab'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Logging_PageController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'notices' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) maybe_do_logs_tab_action() {
	mut var_is_logs_tab := rt.identical(rt.new_string('logs'), rt.call_function('filter_input', [rt.get_constant('INPUT_GET'), rt.new_string('tab')]))
	if rt.is_true(var_is_logs_tab) {
		mut var_params := this.get_query_params(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_array](rt.create_array([rt.ArrayItem{ key: none, val: 'view' }])))
		rt.call_function('do_action', [rt.new_string('wc_logs_load_tab'), var_params.array_get(rt.new_string('view'))])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) notices() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.settings, 'logging_is_enabled', []rt.PhpVal{}))))) {
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [rt.call_function('wp_kses_post', [rt.call_function('__', [rt.new_string('Logging is disabled. It can be enabled in <a href="%s">Logs Settings</a>.'), rt.new_string('woocommerce')])]), rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.new_string('view'), rt.new_string('settings'), rt.new_string(this.get_logs_tab_url())])])])
			// unsupported statement: Stmt_InlineHTML
			return rt.new_null()
			}
		rt.call_function('add_action', [rt.new_string('admin_notices'), rt.new_closure(closure_1_fn)])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) get_logs_tab_url() string {
	return (rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'page', val: 'wc-status' }, rt.ArrayItem{ key: 'tab', val: 'logs' }]), rt.call_function('admin_url', [rt.new_string('admin.php')])])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) render() {
	mut var_handler := rt.call_method(this.settings, 'get_default_handler', []rt.PhpVal{})
	mut var_params := this.get_query_params(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_array](rt.create_array([rt.ArrayItem{ key: none, val: 'view' }])))
	this.render_section_nav()
	if rt.is_true(rt.identical(rt.new_string('settings'), var_params.array_get(rt.new_string('view')))) {
		rt.call_method(this.settings, 'render_form', []rt.PhpVal{})
		return
	}
	mut switch_val_1 := var_handler
	if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2.class())) {
		this.render_filev2()
		return
	} else if rt.is_true(rt.equal(switch_val_1, Class_WC_Log_Handler_DB.class())) {
		mut iife_temp_1 := Class_WC_Admin_Status{}
		mut iife_result_1 := iife_temp_1.status_logs_db()
		return
	} else if rt.is_true(rt.equal(switch_val_1, Class_WC_Log_Handler_File.class())) {
		mut iife_temp_2 := Class_WC_Admin_Status{}
		mut iife_result_2 := iife_temp_2.status_logs_file()
		return
	}
	rt.call_function('do_action', [rt.new_string('wc_logs_render_page'), var_handler.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) render_section_nav() {
	mut var_params := this.get_query_params(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_array](rt.create_array([rt.ArrayItem{ key: none, val: 'view' }])))
	mut var_browse_url := rt.new_string(this.get_logs_tab_url())
	mut var_settings_url := rt.call_function('add_query_arg', [rt.new_string('view'), rt.new_string('settings'), rt.new_string(this.get_logs_tab_url())])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.new_string('<a href="%1$s"%2$s>%3$s</a>'), rt.call_function('esc_url', [var_browse_url.clone()]), rt.new_string((if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('settings'), var_params.array_get(rt.new_string('view')))))) { ' class="current"' } else { '' }).str()), rt.call_function('esc_html__', [rt.new_string('Browse'), rt.new_string('woocommerce')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.new_string('<a href="%1$s"%2$s>%3$s</a>'), rt.call_function('esc_url', [var_settings_url.clone()]), rt.new_string((if rt.is_true(rt.identical(rt.new_string('settings'), var_params.array_get(rt.new_string('view')))) { ' class="current"' } else { '' }).str()), rt.call_function('esc_html__', [rt.new_string('Settings'), rt.new_string('woocommerce')])])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) render_filev2() {
	mut var_params := this.get_query_params(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_array](rt.create_array([rt.ArrayItem{ key: none, val: 'view' }])))
	mut switch_val_2 := var_params.array_get(rt.new_string('view'))
	if true {
		this.render_list_files_view()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('search_results'))) {
		this.render_search_results_view()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('single_file'))) {
		this.render_single_file_view()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) render_list_files_view() {
	mut var_params := this.get_query_params(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_array](rt.create_array([rt.ArrayItem{ key: none, val: 'order' }, rt.ArrayItem{ key: none, val: 'orderby' }, rt.ArrayItem{ key: none, val: 'source' }, rt.ArrayItem{ key: none, val: 'view' }])))
	mut var_defaults := this.get_query_param_defaults()
	mut var_list_table := this.get_list_table((var_params.array_get(rt.new_string('view'))).str())
	rt.call_method(var_list_table, 'prepare_items', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Browse log files'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	this.render_search_field()
	// unsupported statement: Stmt_InlineHTML
	mut iter_1 := var_params.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_key := item_1.key
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_value, var_defaults.array_get(var_key))))) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_key.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.clone()]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_list_table, 'display', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) render_single_file_view() {
	mut var_params := this.get_query_params(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_array](rt.create_array([rt.ArrayItem{ key: none, val: 'file_id' }, rt.ArrayItem{ key: none, val: 'view' }])))
	mut var_file := rt.call_method(this.file_controller, 'get_file_by_id', [var_params.array_get(rt.new_string('file_id'))])
	if rt.is_true(rt.call_function('is_wp_error', [var_file.clone()])) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('wpautop', [rt.call_method(var_file, 'get_error_message', []rt.PhpVal{})])]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.new_string('<p><a href="%1$s">%2$s</a></p>'), rt.call_function('esc_url', [rt.new_string(this.get_logs_tab_url())]), rt.call_function('esc_html__', [rt.new_string('Return to the file list.'), rt.new_string('woocommerce')])])
		// unsupported statement: Stmt_InlineHTML
		return
	}
	mut var_rotations := rt.call_method(this.file_controller, 'get_file_rotations', [rt.call_method(var_file, 'get_file_id', []rt.PhpVal{})])
	mut var_rotation_url_base := rt.call_function('add_query_arg', [rt.new_string('view'), rt.new_string('single_file'), rt.new_string(this.get_logs_tab_url())])
	mut var_download_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'action', val: 'export' }, rt.ArrayItem{ key: 'file_id', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_file, 'get_file_id', []rt.PhpVal{}) }]) }]), rt.call_function('wp_nonce_url', [rt.new_string(this.get_logs_tab_url()), rt.new_string('bulk-log-files')])])
	mut var_delete_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'action', val: 'delete' }, rt.ArrayItem{ key: 'file_id', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_file, 'get_file_id', []rt.PhpVal{}) }]) }]), rt.call_function('wp_nonce_url', [rt.new_string(this.get_logs_tab_url()), rt.new_string('bulk-log-files')])])
	mut var_delete_confirmation_js := rt.call_function('sprintf', [rt.new_string('return window.confirm( \'%s\' )'), rt.call_function('esc_js', [rt.call_function('__', [rt.new_string('Delete this log file permanently?'), rt.new_string('woocommerce')])])])
	mut var_stream := rt.call_method(var_file, 'get_stream', []rt.PhpVal{})
	mut var_line_number := rt.new_int(1)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('Viewing log file %s'), rt.new_string('woocommerce')]), rt.call_function('sprintf', [rt.new_string('<span class="file-id">%s</span>'), rt.call_function('esc_html', [rt.call_method(var_file, 'get_file_id', []rt.PhpVal{})])])])
	// unsupported statement: Stmt_InlineHTML
	if var_rotations.clone().array_count() > 1 {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('File rotations:'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		if var_rotations.array_isset(rt.new_string('current')) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [rt.new_string('<li><a href="%1$s" class="button button-small button-%2$s">%3$s</a></li>'), rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.new_string('file_id'), rt.call_method(var_rotations.array_get(rt.new_string('current')), 'get_file_id', []rt.PhpVal{}), var_rotation_url_base.clone()])]), rt.new_string((if rt.is_true(rt.identical(rt.call_method(var_file, 'get_file_id', []rt.PhpVal{}), rt.call_method(var_rotations.array_get(rt.new_string('current')), 'get_file_id', []rt.PhpVal{}))) { 'primary' } else { 'secondary' }).str()), rt.call_function('esc_html__', [rt.new_string('Current'), rt.new_string('woocommerce')])])
			var_rotations.array_unset(rt.new_string('current'))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		mut iter_2 := var_rotations.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_rotation := item_2.val
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [rt.new_string('<li><a href="%1$s" class="button button-small button-%2$s">%3$s</a></li>'), rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.new_string('file_id'), rt.call_method(var_rotation, 'get_file_id', []rt.PhpVal{}), var_rotation_url_base.clone()])]), rt.new_string((if rt.is_true(rt.identical(rt.call_method(var_file, 'get_file_id', []rt.PhpVal{}), rt.call_method(var_rotation, 'get_file_id', []rt.PhpVal{}))) { 'primary' } else { 'secondary' }).str()), rt.call_function('absint', [rt.call_method(var_rotation, 'get_rotation', []rt.PhpVal{})])])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.new_string('<a href="%1$s" class="button button-secondary">%2$s</a>'), rt.call_function('esc_url', [var_download_url.clone()]), rt.call_function('esc_html__', [rt.new_string('Download'), rt.new_string('woocommerce')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.new_string('<a href="%1$s" class="button button-secondary" onclick="%2$s">%3$s</a>'), rt.call_function('esc_url', [var_delete_url.clone()]), rt.call_function('esc_attr', [var_delete_confirmation_js.clone()]), rt.call_function('esc_html__', [rt.new_string('Delete permanently'), rt.new_string('woocommerce')])])
	// unsupported statement: Stmt_InlineHTML
	for rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('feof', [var_stream.clone()]))))) {
		// unsupported statement: Stmt_InlineHTML
		mut var_line := rt.call_function('fgets', [var_stream.clone()])
		if rt.is_true(rt.new_bool(var_line.clone().is_string())) {
			print(this.format_line((var_line).str(), (var_line_number).to_i64()))
			rt.pre_inc(var_line_number)
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) render_search_results_view() {
	mut var_params := this.get_query_params(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_array](rt.create_array([rt.ArrayItem{ key: none, val: 'view' }])))
	mut var_list_table := this.get_list_table((var_params.array_get(rt.new_string('view'))).str())
	rt.call_method(var_list_table, 'prepare_items', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Search results'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	this.render_search_field()
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_list_table, 'display', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) get_query_param_defaults() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'file_id', val: '' }, rt.ArrayItem{ key: 'order', val: Class_Automattic_WooCommerce_Internal_Admin_Logging_{"nodeType":"Expr_PropertyFetch","line":446,"var":{"nodeType":"Expr_Variable","line":446,"name":"this"},"name":"file_controller"}.defaults_get_files().array_get(rt.new_string('order')) }, rt.ArrayItem{ key: 'orderby', val: Class_Automattic_WooCommerce_Internal_Admin_Logging_{"nodeType":"Expr_PropertyFetch","line":447,"var":{"nodeType":"Expr_Variable","line":447,"name":"this"},"name":"file_controller"}.defaults_get_files().array_get(rt.new_string('orderby')) }, rt.ArrayItem{ key: 'search', val: '' }, rt.ArrayItem{ key: 'source', val: Class_Automattic_WooCommerce_Internal_Admin_Logging_{"nodeType":"Expr_PropertyFetch","line":449,"var":{"nodeType":"Expr_Variable","line":449,"name":"this"},"name":"file_controller"}.defaults_get_files().array_get(rt.new_string('source')) }, rt.ArrayItem{ key: 'view', val: 'list_files' }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) get_query_params(mut var_param_keys Class_Automattic_WooCommerce_Internal_Admin_Logging_array) rt.PhpVal {
	mut var_defaults := this.get_query_param_defaults()
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_file_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('sanitize_file_name', [rt.call_function('wp_unslash', [var_file_id.clone()])])
		}
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_search := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('esc_html', [rt.call_function('wp_unslash', [var_search.clone()])])
		}
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_source := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_6 := Class_Automattic_WooCommerce_Internal_Admin_Logging_File{}
		mut iife_result_6 := iife_temp_6.sanitize_source(rt.call_function('wp_unslash', [var_source.clone()]))
		return iife_result_6
		}
	mut var_params := rt.call_function('filter_input_array', [rt.get_constant('INPUT_GET'), rt.create_array([rt.ArrayItem{ key: 'file_id', val: rt.create_array([rt.ArrayItem{ key: 'filter', val: rt.get_constant('FILTER_CALLBACK') }, rt.ArrayItem{ key: 'options', val: rt.new_closure(closure_4_fn) }]) }, rt.ArrayItem{ key: 'order', val: rt.create_array([rt.ArrayItem{ key: 'filter', val: rt.get_constant('FILTER_VALIDATE_REGEXP') }, rt.ArrayItem{ key: 'options', val: rt.create_array([rt.ArrayItem{ key: 'regexp', val: '/^(asc|desc)$/i' }, rt.ArrayItem{ key: 'default', val: var_defaults.array_get(rt.new_string('order')) }]) }]) }, rt.ArrayItem{ key: 'orderby', val: rt.create_array([rt.ArrayItem{ key: 'filter', val: rt.get_constant('FILTER_VALIDATE_REGEXP') }, rt.ArrayItem{ key: 'options', val: rt.create_array([rt.ArrayItem{ key: 'regexp', val: '/^(created|modified|source|size)$/' }, rt.ArrayItem{ key: 'default', val: var_defaults.array_get(rt.new_string('orderby')) }]) }]) }, rt.ArrayItem{ key: 'search', val: rt.create_array([rt.ArrayItem{ key: 'filter', val: rt.get_constant('FILTER_CALLBACK') }, rt.ArrayItem{ key: 'options', val: rt.new_closure(closure_5_fn) }]) }, rt.ArrayItem{ key: 'source', val: rt.create_array([rt.ArrayItem{ key: 'filter', val: rt.get_constant('FILTER_CALLBACK') }, rt.ArrayItem{ key: 'options', val: rt.new_closure(closure_7_fn) }]) }, rt.ArrayItem{ key: 'view', val: rt.create_array([rt.ArrayItem{ key: 'filter', val: rt.get_constant('FILTER_VALIDATE_REGEXP') }, rt.ArrayItem{ key: 'options', val: rt.create_array([rt.ArrayItem{ key: 'regexp', val: '/^(list_files|single_file|search_results|settings)$/' }, rt.ArrayItem{ key: 'default', val: var_defaults.array_get(rt.new_string('view')) }]) }]) }]), rt.new_bool(false)])
	var_params = rt.call_function('wp_parse_args', [var_params.clone(), var_defaults.clone()])
	if var_param_keys.array_count() > 0 {
	var_params = rt.call_function('array_intersect_key', [var_params.clone(), rt.call_function('array_flip', [var_param_keys])])
	}
	return var_params.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) get_list_table(view string) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.instance_of(this.list_table, 'WP_List_Table'))) {
		return this.list_table
	}
	mut switch_val_3 := rt.new_string(view)
	if rt.is_true(rt.equal(switch_val_3, rt.new_string('list_files'))) {
		this.list_table = create_automattic_woocommerce_internal_admin_logging_filelisttable(this.file_controller, rt.new_object('Automattic_WooCommerce_Internal_Admin_Logging_PageController', []string{}, &this))
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('search_results'))) {
		this.list_table = create_automattic_woocommerce_internal_admin_logging_searchlisttable(this.file_controller, rt.new_object('Automattic_WooCommerce_Internal_Admin_Logging_PageController', []string{}, &this))
	}
	return this.list_table
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) setup_screen_options(view string) {
	mut var_handler := rt.call_method(this.settings, 'get_default_handler', []rt.PhpVal{})
	mut var_list_table := rt.new_null()
	mut switch_val_4 := var_handler
	if rt.is_true(rt.equal(switch_val_4, Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2.class())) {
		if rt.is_true(rt.call_function('in_array', [rt.new_string(view), rt.create_array([rt.ArrayItem{ key: none, val: 'list_files' }, rt.ArrayItem{ key: none, val: 'search_results' }]), rt.new_bool(true)])) {
		var_list_table = this.get_list_table(view)
		}
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('WC_Log_Handler_DB'))) {
	mut iife_temp_7 := Class_WC_Admin_Status{}
	mut iife_result_7 := iife_temp_7.get_db_log_list_table()
	var_list_table = iife_result_7
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_list_table, 'WP_List_Table'))) {
		rt.call_method(var_list_table, 'prepare_column_headers', []rt.PhpVal{})
		rt.call_function('add_screen_option', [rt.new_string('per_page'), rt.create_array([rt.ArrayItem{ key: 'default', val: rt.call_method(var_list_table, 'get_per_page_default', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'option', val: Class_Automattic_WooCommerce_Internal_Admin_Logging_{"nodeType":"Expr_Variable","line":573,"name":"list_table"}.per_page_user_option_key() }])])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) handle_list_table_bulk_actions(view string) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2.class(), rt.call_method(this.settings, 'get_default_handler', []rt.PhpVal{}))))) {
		return
	}
	mut var_params := this.get_query_params(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_array](rt.create_array([rt.ArrayItem{ key: none, val: 'file_id' }])))
	if rt.is_true(rt.new_bool('list_files' != view)) {
		return
	}
	mut var_action := rt.call_method(this.get_list_table(view), 'current_action', []rt.PhpVal{})
	mut var_request_uri := if rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_URI')) { rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))]) } else { this.get_logs_tab_url() }
	if rt.is_true(var_action) {
		rt.call_function('check_admin_referer', [rt.new_string('bulk-log-files')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
			rt.call_function('wp_die', [rt.call_function('esc_html__', [rt.new_string('You do not have permission to manage log files.'), rt.new_string('woocommerce')])])
		}
		mut var_sendback := rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: 'deleted' }]), rt.call_function('wp_get_referer', []rt.PhpVal{})])
		mut var_file_ids := var_params.array_get(rt.new_string('file_id'))
		if !(var_file_ids.clone().is_array()) || var_file_ids.clone().array_count() < 1 {
			rt.call_function('wp_safe_redirect', [var_sendback.clone()])
			exit(0)
		}
		mut switch_val_5 := var_action
		if rt.is_true(rt.equal(switch_val_5, rt.new_string('export'))) {
			if 1 == var_file_ids.clone().array_count() {
			mut var_export_error := rt.call_method(this.file_controller, 'export_single_file', [rt.call_function('reset', [var_file_ids.clone()])])
			} else {
			var_export_error = rt.call_method(this.file_controller, 'export_multiple_files', [var_file_ids.clone()])
			}
			if rt.is_true(rt.call_function('is_wp_error', [var_export_error.clone()])) {
				rt.call_function('wp_die', [rt.call_function('wp_kses_post', [rt.call_method(var_export_error, 'get_error_message', []rt.PhpVal{})])])
			}
		} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('delete'))) {
		mut var_deleted := rt.call_method(this.file_controller, 'delete_files', [var_file_ids.clone()])
		var_sendback = rt.call_function('add_query_arg', [rt.new_string('deleted'), var_deleted.clone(), var_sendback.clone()])
		var_sendback = rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'file_id' }]), var_sendback.clone()])
		}
		var_sendback = rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: 'action' }, rt.ArrayItem{ key: none, val: 'action2' }]), var_sendback.clone()])
		rt.call_function('wp_safe_redirect', [var_sendback.clone()])
		exit(0)
	} else if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wp_http_referer')))) {
		mut var_removable_args := rt.create_array([rt.ArrayItem{ key: none, val: '_wp_http_referer' }, rt.ArrayItem{ key: none, val: '_wpnonce' }, rt.ArrayItem{ key: none, val: 'action' }, rt.ArrayItem{ key: none, val: 'action2' }, rt.ArrayItem{ key: none, val: 'filter_action' }])
		rt.call_function('wp_safe_redirect', [rt.call_function('remove_query_arg', [var_removable_args.clone(), var_request_uri.clone()])])
		exit(0)
	}
	var_deleted = rt.call_function('filter_input', [rt.get_constant('INPUT_GET'), rt.new_string('deleted'), rt.get_constant('FILTER_VALIDATE_INT')])
	if rt.is_true(rt.new_bool(var_deleted.clone().is_long() || var_deleted.clone().is_double())) {
		closure_9_fn := fn [var_deleted] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [rt.call_function('esc_html', [rt.call_function('_n', [rt.new_string('%s log file deleted.'), rt.new_string('%s log files deleted.'), var_deleted.clone(), rt.new_string('woocommerce')])]), rt.call_function('esc_html', [rt.call_function('number_format_i18n', [var_deleted.clone()])])])
			// unsupported statement: Stmt_InlineHTML
			return rt.new_null()
			}
		rt.call_function('add_action', [rt.new_string('admin_notices'), rt.new_closure(closure_9_fn)])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) format_line(line string, line_number i64) string {
	mut line_mutated := line
	mut line_number_mutated := line_number
	mut var_classes := rt.create_array([rt.ArrayItem{ key: none, val: 'line' }])
	line_mutated = (rt.call_function('esc_html', [rt.new_string(line_mutated).clone()])).str()
	if line_mutated == '' {
	line_mutated = '&nbsp;'
	}
	mut var_segments := rt.call_function('explode', [rt.new_string(' '), rt.new_string(line_mutated).clone(), rt.new_int(3)])
	mut var_has_timestamp := rt.new_bool(false)
	mut var_has_level := rt.new_bool(false)
	if var_segments.array_isset(rt.new_int(0)) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strtotime', [var_segments.array_get(rt.new_int(0))]))))) {
		var_classes.array_push('log-entry')
		var_segments.array_set(0, rt.call_function('sprintf', [rt.new_string('<span class="log-timestamp">%s</span>'), var_segments.array_get(rt.new_int(0))]))
	var_has_timestamp = rt.new_bool(true)
	}
	mut iife_temp_9 := Class_WC_Log_Levels{}
	mut iife_result_9 := iife_temp_9.is_valid_level(rt.new_string((var_segments.array_get(rt.new_int(1)).to_string().to_lower()).str()))
	if var_segments.array_isset(rt.new_int(1)) && rt.is_true(iife_result_9) {
		mut iife_temp_10 := Class_WC_Log_Levels{}
		mut iife_result_10 := iife_temp_10.get_level_label(rt.new_string((var_segments.array_get(rt.new_int(1)).to_string().to_lower()).str()))
		mut iife_temp_11 := Class_WC_Log_Levels{}
		mut iife_result_11 := iife_temp_11.get_level_label(rt.new_string((var_segments.array_get(rt.new_int(1)).to_string().to_lower()).str()))
		var_segments.array_set(1, rt.call_function('sprintf', [rt.new_string('<span class="%1$s">%2$s</span>'), rt.call_function('esc_attr', [rt.new_string('log-level log-level--' + var_segments.array_get(rt.new_int(1)).to_string().to_lower())]), rt.call_function('esc_html', [iife_result_10])]))
	var_has_level = rt.new_bool(true)
	}
	if var_segments.array_isset(rt.new_int(2)) && rt.is_true(var_has_timestamp) && rt.is_true(var_has_level) {
		mut var_message_chunks := rt.call_function('explode', [rt.new_string('CONTEXT:'), var_segments.array_get(rt.new_int(2)), rt.new_int(2)])
		if var_message_chunks.array_isset(rt.new_int(1)) {
			mut var_maybe_json := rt.call_function('html_entity_decode', [rt.call_function('addslashes', [rt.new_string(var_message_chunks.array_get(rt.new_int(1)).to_string().trim_space())])])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			mut var_context := rt.call_function('json_decode', [var_maybe_json.clone(), rt.new_bool(false), rt.new_int(512), rt.get_constant('JSON_THROW_ON_ERROR')])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			var_context = rt.call_function('wp_json_encode', [var_context.clone(), rt.bitwise_or(rt.get_constant('JSON_PRETTY_PRINT'), rt.get_constant('JSON_UNESCAPED_UNICODE'))])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			var_message_chunks.array_set(1, rt.call_function('sprintf', [rt.new_string('<details><summary>%1$s</summary>%2$s</details>'), rt.call_function('esc_html__', [rt.new_string('Additional context'), rt.new_string('woocommerce')]), rt.call_function('stripslashes', [var_context.clone()])]))
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			var_segments.array_set(2, rt.call_function('implode', [rt.new_string(' '), var_message_chunks.clone()]))
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			var_classes.array_push('has-context')
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			unsafe { goto end_label_1 }

catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_Admin_Logging_JsonException') {
				mut var_exception := var_e_1.clone()
				unsafe { goto end_label_1 }
			}
			else {
				rt.throw_exception(var_e_1)
				unsafe { goto end_label_1 }
			}

end_label_1:
		}
	}
	if var_segments.clone().array_count() > 1 {
	line_mutated = (rt.call_function('implode', [rt.new_string(' '), var_segments.clone()])).str()
	}
	var_classes = rt.call_function('implode', [rt.new_string(' '), var_classes.clone()])
	return (rt.call_function('sprintf', [rt.new_string('<span id="L%1$d" class="%2$s">%3$s%4$s</span>'), rt.call_function('absint', [rt.new_int(line_number_mutated).clone()]), rt.call_function('esc_attr', [var_classes.clone()]), rt.call_function('sprintf', [rt.new_string('<a href="#L%1$d" class="line-anchor"></a>'), rt.call_function('absint', [rt.new_int(line_number_mutated).clone()])]), rt.call_function('sprintf', [rt.new_string('<span class="line-content">%s</span>'), rt.call_function('wp_kses_post', [rt.new_string(line_mutated).clone()])])])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) render_search_field() {
	mut var_params := this.get_query_params(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_array](rt.create_array([rt.ArrayItem{ key: none, val: 'date_end' }, rt.ArrayItem{ key: none, val: 'date_filter' }, rt.ArrayItem{ key: none, val: 'date_start' }, rt.ArrayItem{ key: none, val: 'search' }, rt.ArrayItem{ key: none, val: 'source' }])))
	mut var_defaults := this.get_query_param_defaults()
	mut var_file_count := rt.call_method(this.file_controller, 'get_files', [var_params.clone(), rt.new_bool(true)])
	if rt.is_true(rt.greater(var_file_count, rt.new_int(0))) {
		// unsupported statement: Stmt_InlineHTML
		mut iter_3 := var_params.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_value := item_3.val
			mut var_key := item_3.key
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_value, var_defaults.array_get(var_key))))) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_key.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_value.clone()]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Search within these files'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_params.array_get(rt.new_string('search'))]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('submit_button', [rt.call_function('__', [rt.new_string('Search'), rt.new_string('woocommerce')]), rt.new_string('secondary'), rt.new_null(), rt.new_bool(false)])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.greater_equal(var_file_count, Class_Automattic_WooCommerce_Internal_Admin_Logging_{"nodeType":"Expr_PropertyFetch","line":804,"var":{"nodeType":"Expr_Variable","line":804,"name":"this"},"name":"file_controller"}.search_max_files())) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('⚠️ Only %s files can be searched at one time. Try filtering the file list before searching.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.call_function('number_format_i18n', [Class_Automattic_WooCommerce_Internal_Admin_Logging_{"nodeType":"Expr_PropertyFetch","line":813,"var":{"nodeType":"Expr_Variable","line":813,"name":"this"},"name":"file_controller"}.search_max_files()])])])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
}

struct Class_WC_Admin_Status {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Logging_File {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Logging_FileListTable {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Logging_SearchListTable {
	rt.PhpObjectBase
}

struct Class_WC_Log_Levels {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_logging_pagecontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController{
		PhpObjectBase: rt.PhpObjectBase{}
		file_controller: rt.new_null()
		settings: rt.new_null()
		list_table: rt.new_null()
	}
	return obj
}

fn create_wc_admin_status(_args ...rt.PhpVal) &Class_WC_Admin_Status {
	mut obj := &Class_WC_Admin_Status{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_logging_file(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Logging_File {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Logging_File{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_logging_filelisttable(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileListTable {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileListTable{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_logging_searchlisttable(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Logging_SearchListTable {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Logging_SearchListTable{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_log_levels(_args ...rt.PhpVal) &Class_WC_Log_Levels {
	mut obj := &Class_WC_Log_Levels{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_FileController](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings](if args.len > 1 { args[1] } else { rt.new_null() })
			this.init(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'init_hooks' {
			this.init_hooks()
			return rt.new_null()
		}
		'maybe_do_logs_tab_action' {
			this.maybe_do_logs_tab_action()
			return rt.new_null()
		}
		'notices' {
			this.notices()
			return rt.new_null()
		}
		'get_logs_tab_url' {
			return rt.new_string(this.get_logs_tab_url())
		}
		'render' {
			this.render()
			return rt.new_null()
		}
		'render_section_nav' {
			this.render_section_nav()
			return rt.new_null()
		}
		'render_filev2' {
			this.render_filev2()
			return rt.new_null()
		}
		'render_list_files_view' {
			this.render_list_files_view()
			return rt.new_null()
		}
		'render_single_file_view' {
			this.render_single_file_view()
			return rt.new_null()
		}
		'render_search_results_view' {
			this.render_search_results_view()
			return rt.new_null()
		}
		'get_query_param_defaults' {
			return this.get_query_param_defaults()
		}
		'get_query_params' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_query_params(mut dispatch_arg_0)
		}
		'get_list_table' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_list_table(dispatch_arg_0)
		}
		'setup_screen_options' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.setup_screen_options(dispatch_arg_0)
			return rt.new_null()
		}
		'handle_list_table_bulk_actions' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.handle_list_table_bulk_actions(dispatch_arg_0)
			return rt.new_null()
		}
		'format_line' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_string(this.format_line(dispatch_arg_0, dispatch_arg_1))
		}
		'render_search_field' {
			this.render_search_field()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'file_controller' { return this.file_controller }
		'settings' { return this.settings }
		'list_table' { return this.list_table }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'file_controller' { this.file_controller = val; return true }
		'settings' { this.settings = val; return true }
		'list_table' { this.list_table = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Admin_Status) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Status) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Status) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_File) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Logging_File) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_File) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileListTable) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileListTable) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileListTable) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_SearchListTable) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Logging_SearchListTable) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_SearchListTable) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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



fn main() {
	defer {
		rt.shutdown()
	}

	// unsupported statement: Stmt_GroupUse
	// unsupported statement: Stmt_GroupUse
}
