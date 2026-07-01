import rt

struct Class_WC_Admin_Status {
	rt.PhpObjectBase
pub mut:
		db_log_list_table rt.PhpVal = rt.new_null()
}

fn Class_WC_Admin_Status.output()  {
	rt.include_file(@DIR + '/views/html-admin-page-status.php', '2')
}

fn Class_WC_Admin_Status.status_report()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Plugin_Updates')]))))) {
		rt.include_file(@DIR + '/plugin-updates/class-wc-plugin-updates.php', '2')
	}
	rt.include_file(@DIR + '/views/html-admin-page-status-report.php', '2')
}

fn Class_WC_Admin_Status.status_tools()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_REST_System_Status_Tools_Controller')]))))) {
		rt.call_function('wp_die', [rt.new_string('Cannot load the REST API to access WC_REST_System_Status_Tools_Controller.')])
	}
	mut var_tools := Class_WC_Admin_Status.get_tools()
	mut var_tool_requires_refresh := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_GET').array_get('action'))) && !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('_wpnonce'))) && rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('_wpnonce')]), rt.new_string('debug_action')])))) {
		mut var_tools_controller := create_wc_rest_system_status_tools_controller()
		mut var_action := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('action')])])
		if rt.is_true(rt.new_bool(var_tools.dup().array_isset(var_action.dup()))) {
			mut var_response := var_tools_controller.execute_tool(var_action.dup())
			mut var_tool := var_tools.array_get(var_action)
			var_tool_requires_refresh = if !(var_tool.array_get('requires_refresh')).is_null() { var_tool.array_get('requires_refresh') } else { rt.new_bool(false) }
			var_tool = rt.create_array([rt.ArrayItem{ key: 'id', val: var_action }, rt.ArrayItem{ key: 'name', val: var_tool.array_get('name') }, rt.ArrayItem{ key: 'action', val: var_tool.array_get('button') }, rt.ArrayItem{ key: 'description', val: var_tool.array_get('desc') }, rt.ArrayItem{ key: 'disabled', val: if !(var_tool.array_get('disabled')).is_null() { var_tool.array_get('disabled') } else { rt.new_bool(false) } }])
			var_tool = rt.call_function('array_merge', [var_tool.dup(), var_response.dup()])
			rt.call_function('do_action', [rt.new_string('woocommerce_system_status_tool_executed'), var_tool.dup()])
		} else {
			var_response = rt.create_array([rt.ArrayItem{ key: 'success', val: false }, rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('Tool does not exist.'), rt.new_string('woocommerce')]) }])
		}
		if rt.is_true(var_response.array_get('success')) {
			print('<div class="updated inline"><p>' + (rt.call_function('esc_html', [var_response.array_get('message')])).str() + '</p></div>')
		} else {
			print('<div class="error inline"><p>' + (rt.call_function('esc_html', [var_response.array_get('message')])).str() + '</p></div>')
		}
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('settings-updated')) {
		print('<div class="updated inline"><p>' + (rt.call_function('esc_html__', [rt.new_string('Your changes have been saved.'), rt.new_string('woocommerce')])).str() + '</p></div>')
	}
	if rt.is_true(var_tool_requires_refresh) {
		var_tools = Class_WC_Admin_Status.get_tools()
	}
	rt.include_file(@DIR + '/views/html-admin-page-status-tools.php', '2')
}

fn Class_WC_Admin_Status.get_tools() rt.PhpVal {
	mut var_tools_controller := create_wc_rest_system_status_tools_controller()
	return var_tools_controller.get_tools()
}

fn Class_WC_Admin_Status.status_logs()  {
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController.class()]), 'render', []rt.PhpVal{})
}

fn Class_WC_Admin_Status.status_logs_file()  {
	mut var_logs := Class_WC_Admin_Status.scan_log_files()
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('log_file'))) && var_logs.array_isset(rt.call_function('sanitize_title', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('log_file')])])) {
		mut var_viewed_log := var_logs.array_get(rt.call_function('sanitize_title', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('log_file')])]))
		// unsupported statement: Stmt_Nop
	} else if !(!rt.is_true(var_logs)) {
		var_viewed_log = rt.call_function('current', [var_logs.dup()])
	}
	mut var_handle := if !(!rt.is_true(var_viewed_log)) { Class_WC_Admin_Status.get_log_file_handle(var_viewed_log.dup()) } else { rt.new_string('') }
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('handle'))) {
		Class_WC_Admin_Status.remove_log()
	}
	rt.include_file(@DIR + '/views/html-admin-page-status-logs.php', '2')
}

fn Class_WC_Admin_Status.status_logs_db()  {
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('flush-logs')) {
		Class_WC_Admin_Status.flush_db_logs()
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('action')) && rt.get_superglobal('_REQUEST').array_isset(rt.new_string('log')) {
		Class_WC_Admin_Status.log_table_bulk_actions()
	}
	mut var_log_table_list := Class_WC_Admin_Status.get_db_log_list_table()
	rt.call_method(var_log_table_list, 'prepare_items', []rt.PhpVal{})
	rt.include_file(@DIR + '/views/html-admin-page-status-logs-db.php', '2')
}

fn Class_WC_Admin_Status.get_file_version(var_file rt.PhpVal) string {
	mut var_match := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_file.dup()]))))) {
		return ''
	}
	mut var_fp := rt.call_function('fopen', [var_file.dup(), rt.new_string('r')])
	mut var_file_data := rt.call_function('fread', [var_fp.dup(), rt.new_int(8192)])
	rt.call_function('fclose', [var_fp.dup()])
	var_file_data = rt.call_function('str_replace', [rt.new_string('\r'), rt.new_string('\n'), var_file_data.dup()])
	mut var_version := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('preg_match', ['/^[ \\t\\/*#@]*' + (rt.call_function('preg_quote', [rt.new_string('@version'), rt.new_string('/')])).str() + '(.*)$/mi', var_file_data.dup(), var_match.dup()])) && rt.is_true(var_match.array_get(1)))) {
		var_version = rt.call_function('_cleanup_header_comment', [var_match.array_get(1)])
	}
	return (var_version).str()
}

fn Class_WC_Admin_Status.get_log_file_handle(var_filename rt.PhpVal) rt.PhpVal {
	return rt.call_function('substr', [var_filename.dup(), rt.new_int(0), if var_filename.dup().to_string().len > 48 { var_filename.dup().to_string().len - 48 } else { var_filename.dup().to_string().len - 4 }])
}

fn Class_WC_Admin_Status.scan_template_files(var_template_path rt.PhpVal) rt.PhpVal {
	mut var_files := if rt.is_true(rt.new_bool(var_template_path.dup().is_string())) { rt.call_function('scandir', [var_template_path.dup()]) } else { rt.new_array() }
	mut var_result := rt.new_array()
	if !(!rt.is_true(var_files)) {
		{
			mut iter_1 := var_files.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_key := item_1.key
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_value.dup(), rt.create_array([rt.ArrayItem{ key: none, val: '.' }, rt.ArrayItem{ key: none, val: '..' }]), rt.new_bool(true)]))))) {
					if rt.is_true(rt.call_function('is_dir', [(var_template_path).str() + (rt.get_constant('DIRECTORY_SEPARATOR')).str() + (var_value).str()])) {
						mut var_sub_files := Class_WC_Admin_Status.scan_template_files(rt.new_string((var_template_path).str() + (rt.get_constant('DIRECTORY_SEPARATOR')).str() + (var_value).str()))
						{
							mut iter_2 := var_sub_files.iterator()
							for {
								item_2 := iter_2.next() or { break }
								mut var_sub_file := item_2.val
								var_result << (var_value).str() + (rt.get_constant('DIRECTORY_SEPARATOR')).str() + (var_sub_file).str()
							}
						}
					} else {
						var_result << var_value.dup()
					}
				}
			}
		}
	}
	return var_result.dup()
}

fn Class_WC_Admin_Status.scan_log_files() rt.PhpVal {
	return fn () rt.PhpVal { mut temp := Class_WC_Log_Handler_File{}; return temp.get_log_files() }()
}

fn Class_WC_Admin_Status.get_latest_theme_version(var_theme rt.PhpVal) rt.PhpVal {
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/theme.php', '2')
	mut var_api := rt.call_function('themes_api', [rt.new_string('theme_information'), rt.create_array([rt.ArrayItem{ key: 'slug', val: rt.call_method(var_theme, 'get_stylesheet', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'fields', val: rt.create_array([rt.ArrayItem{ key: 'sections', val: false }, rt.ArrayItem{ key: 'tags', val: false }]) }])])
	mut var_update_theme_version := rt.new_int(rt.new_int(0))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_api.dup().is_object())) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_api.dup()]))))))) && !(rt.get_property(var_api, 'version')).is_null())) {
		var_update_theme_version = rt.get_property(var_api, 'version')
	} else if rt.is_true(rt.call_function('strstr', [rt.get_property(var_theme, '{"nodeType":"Scalar_String","line":271,"value":"Author URI"}'), rt.new_string('woothemes')])) {
		mut var_theme_dir := rt.call_function('substr', [rt.new_string(rt.call_function('str_replace', [rt.new_string(' '), rt.new_string(''), rt.get_property(var_theme, 'Name')]).to_string().to_lower()), rt.new_int(0), rt.new_int(45)])
		mut var_theme_version_data := rt.call_function('get_transient', [(var_theme_dir).str() + '_version_data'])
		if rt.is_true(rt.identical(rt.new_bool(false), var_theme_version_data)) {
			mut var_theme_changelog := rt.call_function('wp_safe_remote_get', ['http://dzv365zjfbd8v.cloudfront.net/changelogs/' + (var_theme_dir).str() + '/changelog.txt'])
			mut var_cl_lines := rt.call_function('explode', [rt.new_string('\n'), rt.call_function('wp_remote_retrieve_body', [var_theme_changelog.dup()])])
			if !(!rt.is_true(var_cl_lines)) {
				{
					mut iter_1 := var_cl_lines.iterator()
					for {
						item_1 := iter_1.next() or { break }
						mut var_cl_line := item_1.val
						mut var_line_num := item_1.key
						if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[0-9]/'), var_cl_line.dup()])) {
							mut var_theme_date := rt.call_function('str_replace', [rt.new_string('.'), rt.new_string('-'), rt.new_string(rt.call_function('substr', [var_cl_line.dup(), rt.new_int(0), rt.call_function('strpos', [var_cl_line.dup(), rt.new_string('-')])]).to_string().trim_space())])
							mut var_theme_version := rt.call_function('preg_replace', [rt.new_string('~[^0-9,.]~'), rt.new_string(''), rt.call_function('stristr', [var_cl_line.dup(), rt.new_string('version')])])
							mut var_theme_update := rt.new_string(rt.new_string(rt.call_function('str_replace', [rt.new_string('*'), rt.new_string(''), var_cl_lines.array_get(rt.add(var_line_num, rt.new_int(1)))]).to_string().trim_space()))
							var_theme_version_data = rt.create_array([rt.ArrayItem{ key: 'date', val: var_theme_date }, rt.ArrayItem{ key: 'version', val: var_theme_version }, rt.ArrayItem{ key: 'update', val: var_theme_update }, rt.ArrayItem{ key: 'changelog', val: var_theme_changelog }])
							rt.call_function('set_transient', [(var_theme_dir).str() + '_version_data', var_theme_version_data.dup(), rt.get_constant('DAY_IN_SECONDS')])
							break
						}
					}
				}
			}
		}
		if !(!rt.is_true(var_theme_version_data.array_get('version'))) {
			var_update_theme_version = var_theme_version_data.array_get('version')
		}
	}
	return var_update_theme_version.dup()
}

fn Class_WC_Admin_Status.remove_log()  {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('_wpnonce')) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('_wpnonce')]), rt.new_string('remove_log')]))))))) {
		rt.call_function('wp_die', [rt.call_function('esc_html__', [rt.new_string('Action failed. Please refresh the page and retry.'), rt.new_string('woocommerce')])])
	}
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('handle'))) {
		mut var_log_handler := create_wc_log_handler_file()
		var_log_handler.remove(rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('handle')]))
		// unsupported statement: Stmt_Nop
	}
	rt.call_function('wp_safe_redirect', [rt.call_function('esc_url_raw', [rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-status&tab=logs')])])])
	// unsupported expression: Expr_Exit
}

fn Class_WC_Admin_Status.get_db_log_list_table() rt.PhpVal {
	if rt.is_true(rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.is_null())) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn Class_WC_Admin_Status.flush_db_logs()  {
	rt.call_function('check_admin_referer', [rt.new_string('bulk-logs')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
		rt.call_function('wp_die', [rt.call_function('esc_html__', [rt.new_string('You do not have permission to manage log entries.'), rt.new_string('woocommerce')])])
	}
	fn () rt.PhpVal { mut temp := Class_WC_Log_Handler_DB{}; return temp.flush() }()
	mut var_sendback := rt.call_function('wp_sanitize_redirect', [rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-status&tab=logs')])])
	rt.call_function('wp_safe_redirect', [var_sendback.dup()])
	// unsupported expression: Expr_Exit
}

fn Class_WC_Admin_Status.log_table_bulk_actions()  {
	rt.call_function('check_admin_referer', [rt.new_string('bulk-logs')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
		rt.call_function('wp_die', [rt.call_function('esc_html__', [rt.new_string('You do not have permission to manage log entries.'), rt.new_string('woocommerce')])])
	}
	mut var_log_ids := rt.cast_array(rt.call_function('filter_input', [rt.get_constant('INPUT_GET'), rt.new_string('log'), rt.get_constant('FILTER_CALLBACK'), rt.create_array([rt.ArrayItem{ key: 'options', val: 'absint' }])]))
	mut var_action := rt.call_method(Class_WC_Admin_Status.get_db_log_list_table(), 'current_action', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_string('delete'), var_action)) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Log_Handler_DB{}; return temp.delete(arg_0) }(var_log_ids.dup())
		mut var_sendback := rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: 'action' }, rt.ArrayItem{ key: none, val: 'action2' }, rt.ArrayItem{ key: none, val: 'log' }, rt.ArrayItem{ key: none, val: '_wpnonce' }, rt.ArrayItem{ key: none, val: '_wp_http_referer' }]), rt.call_function('wp_get_referer', []rt.PhpVal{})])
		rt.call_function('wp_safe_redirect', [var_sendback.dup()])
		// unsupported expression: Expr_Exit
	}
}

fn Class_WC_Admin_Status.output_tables_info()  {
	mut var_missing_tables := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Install{}; return temp.verify_base_tables(arg_0) }(rt.new_bool(false))
	if 0 == var_missing_tables.dup().array_count() {
		return rt.new_null()
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val()
}

fn Class_WC_Admin_Status.output_plugins_info(var_plugins rt.PhpVal, var_untested_plugins rt.PhpVal)  {
}

struct Class_WC_REST_System_Status_Tools_Controller {
	rt.PhpObjectBase
}

struct Class_WC_Log_Handler_File {
	rt.PhpObjectBase
}

struct Class_WC_Log_Handler_DB {
	rt.PhpObjectBase
}

struct Class_WC_Install {
	rt.PhpObjectBase
}

fn create_wc_admin_status() &Class_WC_Admin_Status {
	mut obj := &Class_WC_Admin_Status{
		PhpObjectBase: rt.PhpObjectBase{}
		db_log_list_table: rt.new_null()
	}
	return obj
}

fn create_wc_rest_system_status_tools_controller() &Class_WC_REST_System_Status_Tools_Controller {
	mut obj := &Class_WC_REST_System_Status_Tools_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_log_handler_file() &Class_WC_Log_Handler_File {
	mut obj := &Class_WC_Log_Handler_File{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_log_handler_db() &Class_WC_Log_Handler_DB {
	mut obj := &Class_WC_Log_Handler_DB{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_install() &Class_WC_Install {
	mut obj := &Class_WC_Install{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_Status) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'output' {
			Class_WC_Admin_Status.output()
			return rt.new_null()
		}
		'status_report' {
			Class_WC_Admin_Status.status_report()
			return rt.new_null()
		}
		'status_tools' {
			Class_WC_Admin_Status.status_tools()
			return rt.new_null()
		}
		'get_tools' {
			return Class_WC_Admin_Status.get_tools()
		}
		'status_logs' {
			Class_WC_Admin_Status.status_logs()
			return rt.new_null()
		}
		'status_logs_file' {
			Class_WC_Admin_Status.status_logs_file()
			return rt.new_null()
		}
		'status_logs_db' {
			Class_WC_Admin_Status.status_logs_db()
			return rt.new_null()
		}
		'get_file_version' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WC_Admin_Status.get_file_version(dispatch_arg_0))
		}
		'get_log_file_handle' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Admin_Status.get_log_file_handle(dispatch_arg_0)
		}
		'scan_template_files' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Admin_Status.scan_template_files(dispatch_arg_0)
		}
		'scan_log_files' {
			return Class_WC_Admin_Status.scan_log_files()
		}
		'get_latest_theme_version' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Admin_Status.get_latest_theme_version(dispatch_arg_0)
		}
		'remove_log' {
			Class_WC_Admin_Status.remove_log()
			return rt.new_null()
		}
		'get_db_log_list_table' {
			return Class_WC_Admin_Status.get_db_log_list_table()
		}
		'flush_db_logs' {
			Class_WC_Admin_Status.flush_db_logs()
			return rt.new_null()
		}
		'log_table_bulk_actions' {
			Class_WC_Admin_Status.log_table_bulk_actions()
			return rt.new_null()
		}
		'output_tables_info' {
			Class_WC_Admin_Status.output_tables_info()
			return rt.new_null()
		}
		'output_plugins_info' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Admin_Status.output_plugins_info(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Admin_Status) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'db_log_list_table' { return this.db_log_list_table }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Admin_Status) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'db_log_list_table' { this.db_log_list_table = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_System_Status_Tools_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_System_Status_Tools_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_System_Status_Tools_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Log_Handler_File) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Log_Handler_File) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Log_Handler_File) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Log_Handler_DB) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Log_Handler_DB) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Log_Handler_DB) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Install) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Install) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Install) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_class_wc_admin_status_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
