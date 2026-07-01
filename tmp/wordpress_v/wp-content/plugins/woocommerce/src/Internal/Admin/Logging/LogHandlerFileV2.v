import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2 {
	rt.PhpObjectBase
pub mut:
		file_controller rt.PhpVal = rt.new_null()
		settings rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2) construct()  {
	this.file_controller = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_Logging_FileController.class()])
	this.settings = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings.class()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2) handle(var_timestamp rt.PhpVal, var_level rt.PhpVal, var_message rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_context_mutated := var_context
	var_context_mutated = rt.cast_array(var_context_mutated)
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_context_mutated.array_isset(rt.new_string('source')) && rt.is_true(rt.new_bool(var_context_mutated.array_get('source').is_string())))) && var_context_mutated.array_get('source').to_string().len >= 3)) {
		mut var_source := rt.call_function('sanitize_title', [rt.new_string(var_context_mutated.array_get('source').to_string().trim_space())])
	} else {
		var_source = rt.new_string(this.determine_source())
	}
	mut var_entry := Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2.format_entry(var_timestamp.dup(), var_level.dup(), var_message.dup(), var_context_mutated.dup())
	mut var_written := rt.call_method(this.file_controller, 'write_to_file', [var_source.dup(), var_entry.dup(), var_timestamp.dup()])
	if rt.is_true(var_written) {
		rt.call_method(this.file_controller, 'invalidate_cache', []rt.PhpVal{})
	}
	return var_written.dup()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2.format_entry(var_timestamp rt.PhpVal, var_level rt.PhpVal, var_message rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_context_mutated := var_context
	mut var_time_string := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2{}; return temp.format_time(arg_0) }(var_timestamp.dup())
	mut var_level_string := rt.new_string(rt.new_string(var_level.dup().to_string().to_upper()))
	if rt.is_true(rt.new_bool(var_context_mutated.array_isset(rt.new_string('backtrace')) && rt.is_true(rt.identical(rt.new_bool(true), rt.call_function('filter_var', [var_context_mutated.array_get('backtrace'), rt.get_constant('FILTER_VALIDATE_BOOLEAN')]))))) {
		var_context_mutated.array_set('backtrace', fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2{}; return temp.get_backtrace() }())
	}
	mut var_context_for_entry := var_context_mutated.dup()
	var_context_for_entry.array_unset(rt.new_string('source'))
	if !(!rt.is_true(var_context_for_entry)) {
		mut var_formatted_context := rt.call_function('wp_json_encode', [var_context_for_entry.dup(), rt.get_constant('JSON_UNESCAPED_UNICODE')])
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_entry := rt.new_string(rt.new_string("${var_time_string.to_string()} ${var_level_string.to_string()} ${var_message.to_string()}"))
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_format_log_entry'), var_entry.dup(), rt.create_array([rt.ArrayItem{ key: 'timestamp', val: var_timestamp }, rt.ArrayItem{ key: 'level', val: var_level }, rt.ArrayItem{ key: 'message', val: var_message }, rt.ArrayItem{ key: 'context', val: var_context_mutated }])])
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2) determine_source() string {
	mut var_source_roots := rt.create_array([rt.ArrayItem{ key: 'mu-plugin', val: rt.call_function('trailingslashit', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WPMU_PLUGIN_DIR'))]) }, rt.ArrayItem{ key: 'plugin', val: rt.call_function('trailingslashit', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WP_PLUGIN_DIR'))]) }, rt.ArrayItem{ key: 'theme', val: rt.call_function('trailingslashit', [rt.call_function('get_theme_root', []rt.PhpVal{})]) }])
	mut var_source := rt.new_string(rt.new_string(''))
	mut var_backtrace := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2{}; return temp.get_backtrace() }()
	{
		mut iter_1 := var_backtrace.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_frame := item_1.val
			if !(var_frame.array_isset(rt.new_string('file'))) {
				continue
			}
			{
				mut iter_2 := var_source_roots.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_path := item_2.val
					mut var_type := item_2.key
					if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_frame.array_get('file'), var_path.dup()]))) {
						mut var_relative_path := rt.new_string(rt.new_string(rt.call_function('substr', [var_frame.array_get('file'), rt.new_int(var_path.dup().to_string().len)]).to_string().trim_space()))
						if rt.is_true(rt.identical(rt.new_string('mu-plugin'), var_type)) {
							mut var_info := rt.call_function('pathinfo', [var_relative_path.dup()])
							if rt.is_true(rt.identical(rt.new_string('.'), var_info.array_get('dirname'))) {
								var_source = rt.new_string("${var_type.to_string()}-" + (var_info.array_get('filename')).str())
							} else {
								var_source = rt.new_string("${var_type.to_string()}-" + (var_info.array_get('dirname')).str())
							}
							break
						}
						mut var_segments := rt.call_function('explode', [rt.get_constant('DIRECTORY_SEPARATOR'), var_relative_path.dup()])
						if rt.is_true(rt.new_bool(var_segments.dup().is_array())) {
							var_source = rt.new_string("${var_type.to_string()}-" + (rt.call_function('reset', [var_segments.dup()])).str())
						}
						break
					}
				}
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_source)))) {
		var_source = rt.new_string(rt.new_string('log'))
	}
	return (rt.call_function('sanitize_title', [var_source.dup()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2) clear(source string, quiet bool) i64 {
	mut var_file := rt.new_null()
	mut source_mutated := source
	source_mutated = (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Logging_File{}; return temp.sanitize_source(arg_0) }(rt.new_string(source_mutated))).str()
	mut var_files := rt.call_method(this.file_controller, 'get_files', [rt.create_array([rt.ArrayItem{ key: 'source', val: source_mutated }])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_files.dup()])) || var_files.dup().array_count() < 1)) {
		return 0
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_file := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_method(var_file, 'get_file_id', []rt.PhpVal{})
	}
	mut var_file := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_method(var_file, 'get_file_id', []rt.PhpVal{})
	}
	mut var_file_ids := rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_files.dup()])
	mut var_deleted := rt.call_method(this.file_controller, 'delete_files', [var_file_ids.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_deleted, rt.new_int(0))) && !(var_quiet))) {
		this.handle(rt.call_function('time', []rt.PhpVal{}), rt.new_string('info'), rt.call_function('sprintf', [rt.call_function('esc_html', [rt.call_function('_n', [rt.new_string('%1$s log file from source %2$s was deleted.'), rt.new_string('%1$s log files from source %2$s were deleted.'), var_deleted.dup(), rt.new_string('woocommerce')])]), rt.call_function('number_format_i18n', [var_deleted.dup()]), rt.call_function('sprintf', [rt.new_string('<code>%s</code>'), rt.call_function('esc_html', [rt.new_string(source_mutated).dup()])])]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc_logger' }, rt.ArrayItem{ key: 'backtrace', val: true }]))
	}
	return (var_deleted).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2) delete_logs_before_timestamp(timestamp i64) i64 {
	mut var_file := rt.new_null()
	if !(var_timestamp != 0) {
		return 0
	}
	mut var_files := rt.call_method(this.file_controller, 'get_files', [rt.create_array([rt.ArrayItem{ key: 'date_filter', val: 'created' }, rt.ArrayItem{ key: 'date_start', val: 1 }, rt.ArrayItem{ key: 'date_end', val: timestamp }])])
	if rt.is_true(rt.call_function('is_wp_error', [var_files.dup()])) {
		return 0
	}
	closure_3_fn := fn [var_timestamp] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_file := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_delete := rt.call_function('apply_filters', [rt.new_string('woocommerce_logger_delete_expired_file'), rt.new_bool(true), var_file.dup(), rt.new_int(timestamp)])
	return rt.is_true(var_delete.dup())
	}
	var_files = rt.call_function('array_filter', [var_files.dup(), rt.new_closure(closure_3_fn)])
	if var_files.dup().array_count() < 1 {
		return 0
	}
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_file := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_method(var_file, 'get_file_id', []rt.PhpVal{})
	}
	mut var_file := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_method(var_file, 'get_file_id', []rt.PhpVal{})
	}
	mut var_file_ids := rt.call_function('array_map', [rt.new_closure(closure_4_fn), var_files.dup()])
	mut var_deleted := rt.call_method(this.file_controller, 'delete_files', [var_file_ids.dup()])
	mut var_retention_days := rt.call_method(this.settings, 'get_retention_period', []rt.PhpVal{})
	if rt.is_true(rt.greater(var_deleted, rt.new_int(0))) {
		this.handle(rt.call_function('time', []rt.PhpVal{}), rt.new_string('info'), rt.call_function('sprintf', [rt.call_function('esc_html', [rt.call_function('_n', [rt.new_string('%s expired log file was deleted.'), rt.new_string('%s expired log files were deleted.'), var_deleted.dup(), rt.new_string('woocommerce')])]), rt.call_function('number_format_i18n', [var_deleted.dup()])]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc_logger' }]))
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

fn create_wc_log_handler() &Class_WC_Log_Handler {
	mut obj := &Class_WC_Log_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_logging_file() &Class_Automattic_WooCommerce_Internal_Admin_Logging_File {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_logging_loghandlerfilev2_php() {
	// unsupported statement: Stmt_GroupUse
}
