import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController {
	rt.PhpObjectBase
pub mut:
		file_controller rt.PhpVal = rt.new_null()
		settings rt.PhpVal = rt.new_null()
		list_table rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) init(mut var_file_controller Class_Automattic_WooCommerce_Internal_Admin_Logging_FileController, mut var_settings Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings)  {
	this.file_controller = var_file_controller.dup()
	this.settings = var_settings.dup()
	this.init_hooks()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) init_hooks()  {
	rt.call_function('add_action', [rt.new_string('load-woocommerce_page_wc-status'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Logging_PageController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'maybe_do_logs_tab_action' }]), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('wc_logs_load_tab'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Logging_PageController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'setup_screen_options' }])])
	rt.call_function('add_action', [rt.new_string('wc_logs_load_tab'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Logging_PageController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_list_table_bulk_actions' }])])
	rt.call_function('add_action', [rt.new_string('wc_logs_load_tab'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Logging_PageController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'notices' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) maybe_do_logs_tab_action()  {
	mut var_is_logs_tab := rt.identical(rt.new_string('logs'), rt.call_function('filter_input', [rt.get_constant('INPUT_GET'), rt.new_string('tab')]))
	if rt.is_true(var_is_logs_tab) {
		mut var_params := this.get_query_params(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_array](rt.create_array([rt.ArrayItem{ key: none, val: 'view' }])))
		rt.call_function('do_action', [rt.new_string('wc_logs_load_tab'), var_params.array_get('view')])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) notices()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.settings, 'logging_is_enabled', []rt.PhpVal{}))))) {
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('wp_kses_post', [rt.call_function('__', [rt.new_string('Logging is disabled. It can be enabled in <a href="%s">Logs Settings</a>.'), rt.new_string('woocommerce')])]), rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.new_string('view'), rt.new_string('settings'), this.get_logs_tab_url()])])])
	// unsupported statement: Stmt_InlineHTML
	return rt.new_null()
	}
		rt.call_function('add_action', [rt.new_string('admin_notices'), rt.new_closure(closure_1_fn)])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) get_logs_tab_url() string {
	return (rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'page', val: 'wc-status' }, rt.ArrayItem{ key: 'tab', val: 'logs' }]), rt.call_function('admin_url', [rt.new_string('admin.php')])])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) render()  {
	mut var_handler := rt.call_method(this.settings, 'get_default_handler', []rt.PhpVal{})
	mut var_params := this.get_query_params(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_array](rt.create_array([rt.ArrayItem{ key: none, val: 'view' }])))
	this.render_section_nav()
	if rt.is_true(rt.identical(rt.new_string('settings'), var_params.array_get('view'))) {
		rt.call_method(this.settings, 'render_form', []rt.PhpVal{})
		return rt.new_null()
	}
	mut switch_val_1 := var_handler
	if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2.class())) {
		this.render_filev2()
		return rt.new_null()
	} else if rt.is_true(rt.equal(switch_val_1, Class_WC_Log_Handler_DB.class())) {
		fn () rt.PhpVal { mut temp := Class_WC_Admin_Status{}; return temp.status_logs_db() }()
		return rt.new_null()
	} else if rt.is_true(rt.equal(switch_val_1, Class_WC_Log_Handler_File.class())) {
		fn () rt.PhpVal { mut temp := Class_WC_Admin_Status{}; return temp.status_logs_file() }()
		return rt.new_null()
	}
	rt.call_function('do_action', [rt.new_string('wc_logs_render_page'), var_handler.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) render_section_nav()  {
	mut var_params := this.get_query_params(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_array](rt.create_array([rt.ArrayItem{ key: none, val: 'view' }])))
	mut var_browse_url := rt.new_string(this.get_logs_tab_url())
	mut var_settings_url := rt.call_function('add_query_arg', [rt.new_string('view'), rt.new_string('settings'), this.get_logs_tab_url()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.new_string('<a href="%1$s"%2$s>%3$s</a>'), rt.call_function('esc_url', [var_browse_url.dup()]), if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.new_string(' class="current"') } else { rt.new_string('') }, rt.call_function('esc_html__', [rt.new_string('Browse'), rt.new_string('woocommerce')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.new_string('<a href="%1$s"%2$s>%3$s</a>'), rt.call_function('esc_url', [var_settings_url.dup()]), if rt.is_true(rt.identical(rt.new_string('settings'), var_params.array_get('view'))) { rt.new_string(' class="current"') } else { rt.new_string('') }, rt.call_function('esc_html__', [rt.new_string('Settings'), rt.new_string('woocommerce')])])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) render_filev2()  {
	mut var_params := this.get_query_params(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_array](rt.create_array([rt.ArrayItem{ key: none, val: 'view' }])))
	mut switch_val_2 := var_params.array_get('view')
	if true {
		this.render_list_files_view()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('search_results'))) {
		this.render_search_results_view()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('single_file'))) {
		this.render_single_file_view()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) render_list_files_view()  {
	mut var_params := this.get_query_params(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_array](rt.create_array([rt.ArrayItem{ key: none, val: 'order' }, rt.ArrayItem{ key: none, val: 'orderby' }, rt.ArrayItem{ key: none, val: 'source' }, rt.ArrayItem{ key: none, val: 'view' }])))
	mut var_defaults := this.get_query_param_defaults()
	mut var_list_table := this.get_list_table((var_params.array_get('view')).str())
	rt.call_method(var_list_table, 'prepare_items', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Browse log files'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	this.render_search_field()
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_params.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_key.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_value.dup()]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_list_table, 'display', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) render_single_file_view()  {
	mut var_params := this.get_query_params(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_array](rt.create_array([rt.ArrayItem{ key: none, val: 'file_id' }, rt.ArrayItem{ key: none, val: 'view' }])))
	mut var_file := rt.call_method(this.file_controller, 'get_file_by_id', [var_params.array_get('file_id')])
	if rt.is_true(rt.call_function('is_wp_error', [var_file.dup()])) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('wpautop', [rt.call_method(var_file, 'get_error_message', []rt.PhpVal{})])]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.new_string('<p><a href="%1$s">%2$s</a></p>'), rt.call_function('esc_url', [this.get_logs_tab_url()]), rt.call_function('esc_html__', [rt.new_string('Return to the file list.'), rt.new_string('woocommerce')])])
		// unsupported statement: Stmt_InlineHTML
		return rt.new_null()
	}
	mut var_rotations := rt.call_method(this.file_controller, 'get_file_rotations', [rt.call_method(var_file, 'get_file_id', []rt.PhpVal{})])
	mut var_rotation_url_base := rt.call_function('add_query_arg', [rt.new_string('view'), rt.new_string('single_file'), this.get_logs_tab_url()])
	mut var_download_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'action', val: 'export' }, rt.ArrayItem{ key: 'file_id', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_file, 'get_file_id', []rt.PhpVal{}) }]) }]), rt.call_function('wp_nonce_url', [this.get_logs_tab_url(), rt.new_string('bulk-log-files')])])
	mut var_delete_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'action', val: 'delete' }, rt.ArrayItem{ key: 'file_id', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_file, 'get_file_id', []rt.PhpVal{}) }]) }]), rt.call_function('wp_nonce_url', [this.get_logs_tab_url(), rt.new_string('bulk-log-files')])])
	mut var_delete_confirmation_js := rt.call_function('sprintf', [rt.new_string('return window.confirm( \'%s\' )'), rt.call_function('esc_js', [rt.call_function('__', [rt.new_string('Delete this log file permanently?'), rt.new_string('woocommerce')])])])
	mut var_stream := rt.call_method(var_file, 'get_stream', []rt.PhpVal{})
	mut var_line_number := rt.new_int(rt.new_int(1))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('Viewing log file %s'), rt.new_string('woocommerce')]), rt.call_function('sprintf', [rt.new_string('<span class="file-id">%s</span>'), rt.call_function('esc_html', [rt.call_method(var_file, 'get_file_id', []rt.PhpVal{})])])])
	// unsupported statement: Stmt_InlineHTML
	if var_rotations.dup().array_count() > 1 {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('File rotations:'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		if var_rotations.array_isset(rt.new_string('current')) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [rt.new_string('<li><a href="%1$s" class="button button-small button-%2$s">%3$s</a></li>'), rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.new_string('file_id'), rt.call_method(, 'get_file_id', []rt.PhpVal{}), var_rotation_url_base.dup()])]), if rt.is_true(rt.identical(rt.call_method(, 'get_file_id', []rt.PhpVal{}), rt.call_method(, 'get_file_id', []rt.PhpVal{}))) { rt.new_string('primary') } else { rt.new_string('secondary') }, rt.call_function('esc_html__', [rt.new_string('Current'), rt.new_string('woocommerce')])])
			var_rotations.array_unset(rt.new_string('current'))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		{
			mut iter_1 := var_rotations.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_rotation := item_1.val
				// unsupported statement: Stmt_InlineHTML
			}
		}
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) render_search_results_view()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) get_query_param_defaults() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) get_query_params(mut var_param_keys Class_Automattic_WooCommerce_Internal_Admin_Logging_array) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) get_list_table(view string) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) setup_screen_options(view string)  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) handle_list_table_bulk_actions(view string)  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) format_line(line string, line_number i64) string {
	mut line_mutated := line
	mut line_number_mutated := line_number
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController) render_search_field()  {
}

struct Class_WC_Admin_Status {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_logging_pagecontroller() &Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController{
		PhpObjectBase: rt.PhpObjectBase{}
		file_controller: rt.new_null()
		settings: rt.new_null()
		list_table: rt.new_null()
	}
	return obj
}

fn create_wc_admin_status() &Class_WC_Admin_Status {
	mut obj := &Class_WC_Admin_Status{
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




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_logging_pagecontroller_php() {
	// unsupported statement: Stmt_Declare
	// unsupported statement: Stmt_GroupUse
	// unsupported statement: Stmt_GroupUse
}
