import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2 {
	rt.PhpObjectBase
pub mut:
		file_controller rt.PhpVal = rt.new_null()
		settings rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2) construct() {
	this.file_controller = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_Logging_FileController.class()])
	this.settings = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings.class()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2) handle(var_timestamp rt.PhpVal, var_level rt.PhpVal, var_message rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_context_mutated := var_context
	var_context_mutated = rt.cast_array(var_context_mutated)
	if var_context_mutated.array_isset(rt.new_string('source')) && var_context_mutated.array_get(rt.new_string('source')).is_string() && var_context_mutated.array_get(rt.new_string('source')).to_string().len >= 3 {
	mut var_source := rt.call_function('sanitize_title', [rt.new_string(var_context_mutated.array_get(rt.new_string('source')).to_string().trim_space())])
	} else {
	var_source = rt.new_string(this.determine_source())
	}
	mut var_entry := Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2.format_entry(var_timestamp.clone(), var_level.clone(), var_message.clone(), var_context_mutated.clone())
	mut var_written := rt.call_method(this.file_controller, 'write_to_file', [var_source.clone(), var_entry.clone(), var_timestamp.clone()])
	if rt.is_true(var_written) {
		rt.call_method(this.file_controller, 'invalidate_cache', []rt.PhpVal{})
	}
	return var_written.clone()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2.format_entry(var_timestamp rt.PhpVal, var_level rt.PhpVal, var_message rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_context_mutated := var_context
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2{}
	mut iife_result_0 := iife_temp_0.format_time(var_timestamp.clone())
	mut var_time_string := iife_result_0
	mut var_level_string := rt.new_string(var_level.clone().to_string().to_upper())
	if var_context_mutated.array_isset(rt.new_string('backtrace')) && rt.is_true(rt.identical(rt.new_bool(true), rt.call_function('filter_var', [var_context_mutated.array_get(rt.new_string('backtrace')), rt.get_constant('FILTER_VALIDATE_BOOLEAN')]))) {
		mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2{}
		mut iife_result_1 := iife_temp_1.get_backtrace()
		var_context_mutated.array_set('backtrace', iife_result_1)
	}
	mut var_context_for_entry := var_context_mutated.clone()
	var_context_for_entry.array_unset(rt.new_string('source'))
	if !(!rt.is_true(var_context_for_entry)) {
		mut var_formatted_context := rt.call_function('wp_json_encode', [var_context_for_entry.clone(), rt.get_constant('JSON_UNESCAPED_UNICODE')])
		var_message = rt.concat(var_message, rt.call_function('stripslashes', [rt.new_string(" CONTEXT: ${var_formatted_context.to_string()}")]))
	}
	mut var_entry := rt.new_string("${var_time_string.to_string()} ${var_level_string.to_string()} ${var_message.to_string()}")
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_format_log_entry'), var_entry.clone(), rt.create_array([rt.ArrayItem{ key: 'timestamp', val: var_timestamp }, rt.ArrayItem{ key: 'level', val: var_level }, rt.ArrayItem{ key: 'message', val: var_message }, rt.ArrayItem{ key: 'context', val: var_context_mutated }])])
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2) determine_source() string {
	mut iife_temp_2 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_2 := iife_temp_2.get_constant(rt.new_string('WPMU_PLUGIN_DIR'))
	mut iife_temp_3 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_3 := iife_temp_3.get_constant(rt.new_string('WPMU_PLUGIN_DIR'))
	mut iife_temp_4 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_4 := iife_temp_4.get_constant(rt.new_string('WP_PLUGIN_DIR'))
	mut iife_temp_5 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_5 := iife_temp_5.get_constant(rt.new_string('WP_PLUGIN_DIR'))
	mut var_source_roots := rt.create_array([rt.ArrayItem{ key: 'mu-plugin', val: rt.call_function('trailingslashit', [iife_result_2]) }, rt.ArrayItem{ key: 'plugin', val: rt.call_function('trailingslashit', [iife_result_4]) }, rt.ArrayItem{ key: 'theme', val: rt.call_function('trailingslashit', [rt.call_function('get_theme_root', []rt.PhpVal{})]) }])
	mut var_source := rt.new_string('')
	mut iife_temp_6 := Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2{}
	mut iife_result_6 := iife_temp_6.get_backtrace()
	mut var_backtrace := iife_result_6
	mut iter_1 := var_backtrace.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_frame := item_1.val
		if !(var_frame.array_isset(rt.new_string('file'))) {
			continue
		}
		mut iter_2 := var_source_roots.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_path := item_2.val
			mut var_type := item_2.key
			if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_frame.array_get(rt.new_string('file')), var_path.clone()]))) {
				mut var_relative_path := rt.new_string(rt.call_function('substr', [var_frame.array_get(rt.new_string('file')), rt.new_int(var_path.clone().to_string().len)]).to_string().trim_space())
				if rt.is_true(rt.identical(rt.new_string('mu-plugin'), var_type)) {
					mut var_info := rt.call_function('pathinfo', [var_relative_path.clone()])
					if rt.is_true(rt.identical(rt.new_string('.'), var_info.array_get(rt.new_string('dirname')))) {
					var_source = rt.new_string("${var_type.to_string()}-" + (var_info.array_get(rt.new_string('filename'))).str())
					} else {
					var_source = rt.new_string("${var_type.to_string()}-" + (var_info.array_get(rt.new_string('dirname'))).str())
					}
					break
				}
				mut var_segments := rt.call_function('explode', [rt.get_constant('DIRECTORY_SEPARATOR'), var_relative_path.clone()])
				if rt.is_true(rt.new_bool(var_segments.clone().is_array())) {
				var_source = rt.new_string("${var_type.to_string()}-" + (rt.call_function('reset', [var_segments.clone()])).str())
				}
				break
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_source)))) {
	var_source = rt.new_string('log')
	}
	return (rt.call_function('sanitize_title', [var_source.clone()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2) clear(source string, quiet bool) i64 {
	mut var_file := rt.new_null()
	mut source_mutated := source
	mut iife_temp_7 := Class_Automattic_WooCommerce_Internal_Admin_Logging_File{}
	mut iife_result_7 := iife_temp_7.sanitize_source(rt.new_string(source_mutated))
	source_mutated = (iife_result_7).str()
	mut var_files := rt.call_method(this.file_controller, 'get_files', [rt.create_array([rt.ArrayItem{ key: 'source', val: source_mutated }])])
	if rt.is_true(rt.call_function('is_wp_error', [var_files.clone()])) || var_files.clone().array_count() < 1 {
		return 0
	}
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_file := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_file, 'get_file_id', []rt.PhpVal{})
		}
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_file := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_file, 'get_file_id', []rt.PhpVal{})
		}
	mut var_file_ids := rt.call_function('array_map', [rt.new_closure(closure_9_fn), var_files.clone()])
	mut var_deleted := rt.call_method(this.file_controller, 'delete_files', [var_file_ids.clone()])
	if rt.is_true(rt.greater(var_deleted, rt.new_int(0))) && !(var_quiet) {
		this.handle(rt.call_function('time', []rt.PhpVal{}), rt.new_string('info'), rt.call_function('sprintf', [rt.call_function('esc_html', [rt.call_function('_n', [rt.new_string('%1$s log file from source %2$s was deleted.'), rt.new_string('%1$s log files from source %2$s were deleted.'), var_deleted.clone(), rt.new_string('woocommerce')])]), rt.call_function('number_format_i18n', [var_deleted.clone()]), rt.call_function('sprintf', [rt.new_string('<code>%s</code>'), rt.call_function('esc_html', [rt.new_string(source_mutated).clone()])])]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc_logger' }, rt.ArrayItem{ key: 'backtrace', val: true }]))
	}
	return (var_deleted).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2) delete_logs_before_timestamp(timestamp i64) i64 {
	mut var_file := rt.new_null()
	if !(var_timestamp != 0) {
		return 0
	}
	mut var_files := rt.call_method(this.file_controller, 'get_files', [rt.create_array([rt.ArrayItem{ key: 'date_filter', val: 'created' }, rt.ArrayItem{ key: 'date_start', val: 1 }, rt.ArrayItem{ key: 'date_end', val: timestamp }])])
	if rt.is_true(rt.call_function('is_wp_error', [var_files.clone()])) {
		return 0
	}
	closure_11_fn := fn [var_timestamp] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_file := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_delete := rt.call_function('apply_filters', [rt.new_string('woocommerce_logger_delete_expired_file'), rt.new_bool(true), var_file.clone(), rt.new_int(timestamp)])
		return rt.is_true(var_delete.clone())
		}
	var_files = rt.call_function('array_filter', [var_files.clone(), rt.new_closure(closure_11_fn)])
	if var_files.clone().array_count() < 1 {
		return 0
	}
	closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_file := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_file, 'get_file_id', []rt.PhpVal{})
		}
	closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_file := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_file, 'get_file_id', []rt.PhpVal{})
		}
	mut var_file_ids := rt.call_function('array_map', [rt.new_closure(closure_12_fn), var_files.clone()])
	mut var_deleted := rt.call_method(this.file_controller, 'delete_files', [var_file_ids.clone()])
	mut var_retention_days := rt.call_method(this.settings, 'get_retention_period', []rt.PhpVal{})
	if rt.is_true(rt.greater(var_deleted, rt.new_int(0))) {
		this.handle(rt.call_function('time', []rt.PhpVal{}), rt.new_string('info'), rt.call_function('sprintf', [rt.call_function('esc_html', [rt.call_function('_n', [rt.new_string('%s expired log file was deleted.'), rt.new_string('%s expired log files were deleted.'), var_deleted.clone(), rt.new_string('woocommerce')])]), rt.call_function('number_format_i18n', [var_deleted.clone()])]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc_logger' }]))
	}
	return (var_deleted).to_i64()
}

struct Class_WC_Log_Handler {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Logging_File {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_logging_loghandlerfilev2() &Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2 {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2{
		PhpObjectBase: rt.PhpObjectBase{}
		file_controller: rt.new_null()
		settings: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wc_log_handler(_args ...rt.PhpVal) &Class_WC_Log_Handler {
	mut obj := &Class_WC_Log_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'handle' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.handle(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'format_entry' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2.format_entry(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'determine_source' {
			return rt.new_string(this.determine_source())
		}
		'clear' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_int(this.clear(dispatch_arg_0, dispatch_arg_1))
		}
		'delete_logs_before_timestamp' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_int(this.delete_logs_before_timestamp(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'file_controller' { return this.file_controller }
		'settings' { return this.settings }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'file_controller' { this.file_controller = val; return true }
		'settings' { this.settings = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Log_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Log_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Log_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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



fn main() {
	defer {
		rt.shutdown()
	}

	// unsupported statement: Stmt_GroupUse
}
