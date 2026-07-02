import rt

struct Class_WC_Log_Handler_File {
	rt.PhpObjectBase
pub mut:
	handles        rt.PhpVal = rt.new_array()
	log_size_limit rt.PhpVal = rt.new_null()
	cached_logs    rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Log_Handler_File) construct(var_log_size_limit rt.PhpVal) {
	mut var_log_size_limit_mutated := var_log_size_limit
	if rt.is_true(rt.identical(rt.new_null(), var_log_size_limit_mutated)) {
		var_log_size_limit_mutated = rt.new_int(5 * 1024 * 1024)
	}
	this.log_size_limit = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_log_file_size_limit'),
		var_log_size_limit_mutated.clone(),
	])
	rt.call_function('add_action', [rt.new_string('plugins_loaded'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Log_Handler_File', [
				'WC_Log_Handler',
			], &this) },
			rt.ArrayItem{ key: none, val: 'write_cached_logs' },
		])])
}

fn (mut this Class_WC_Log_Handler_File) magic_destruct() {
	mut iter_1 := this.handles.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_handle := item_1.val
		if rt.is_true(rt.call_function('is_resource', [var_handle.clone()])) {
			rt.call_function('fclose', [var_handle.clone()])
		}
	}
}

fn (mut this Class_WC_Log_Handler_File) handle(var_timestamp rt.PhpVal, var_level rt.PhpVal, var_message rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_message_mutated := var_message
	if var_context.array_isset(rt.new_string('source'))
		&& rt.is_true(var_context.array_get(rt.new_string('source'))) {
		mut var_handle := var_context.array_get(rt.new_string('source'))
	} else {
		var_handle = rt.new_string('log')
	}
	mut var_entry := Class_WC_Log_Handler_File.format_entry(var_timestamp.clone(),
		var_level.clone(), var_message_mutated.clone(), var_context.clone())
	return rt.new_bool(this.add(var_entry.clone(), var_handle.clone()))
}

fn Class_WC_Log_Handler_File.format_entry(var_timestamp rt.PhpVal, var_level rt.PhpVal, var_message rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_message_mutated := var_message
	if var_context.array_isset(rt.new_string('_legacy'))
		&& rt.is_true(rt.identical(rt.new_bool(true), var_context.array_get(rt.new_string('_legacy')))) {
		if var_context.array_isset(rt.new_string('source'))
			&& rt.is_true(var_context.array_get(rt.new_string('source'))) {
			mut var_handle := var_context.array_get(rt.new_string('source'))
		} else {
			var_handle = rt.new_string('log')
		}
		var_message_mutated = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_logger_add_message'),
			var_message_mutated.clone(),
			var_handle.clone(),
		])
		mut var_time := rt.call_function('date_i18n', [rt.new_string('m-d-Y @ H:i:s')])
		mut var_entry := rt.new_string('${var_time.to_string()} - ${var_message.to_string()}')
	} else {
		var_entry = this.Class_WC_Log_Handler.format_entry(var_timestamp.clone(),
			var_level.clone(), var_message_mutated.clone(), var_context.clone())
	}
	return var_entry.clone()
}

fn (mut this Class_WC_Log_Handler_File) open(var_handle rt.PhpVal, mode string) bool {
	mut var_handle_mutated := var_handle
	if this.is_open(var_handle_mutated.clone()) {
		return true
	}
	mut var_file := Class_WC_Log_Handler_File.get_log_file_path(var_handle_mutated.clone())
	if rt.is_true(var_file) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
			var_file.clone(),
		])))))
		{
			mut var_temphandle := rt.call_function('fopen', [
				var_file.clone(), rt.new_string('w+')])
			if rt.is_true(rt.call_function('is_resource', [var_temphandle.clone()])) {
				rt.call_function('fclose', [var_temphandle.clone()])
				mut iife_temp_0 := Class_Automattic_Jetpack_Constants{}
				mut iife_result_0 := iife_temp_0.is_defined(rt.new_string('FS_CHMOD_FILE'))
				if rt.is_true(iife_result_0) {
					rt.call_function('chmod', [var_file.clone(),
						rt.get_constant('FS_CHMOD_FILE')])
				}
			}
		}
		mut var_resource := rt.call_function('fopen', [var_file.clone(),
			rt.new_string(mode)])
		if rt.is_true(var_resource) {
			this.handles.array_set(var_handle_mutated, var_resource.clone())
			return true
		}
	}
	return false
}

fn (mut this Class_WC_Log_Handler_File) is_open(var_handle rt.PhpVal) bool {
	mut var_handle_mutated := var_handle
	return rt.is_true(rt.new_bool(this.handles.array_isset(var_handle_mutated.clone())))
		&& rt.is_true(rt.call_function('is_resource', [this.handles.array_get(var_handle_mutated)]))
}

fn (mut this Class_WC_Log_Handler_File) close(var_handle rt.PhpVal) rt.PhpVal {
	mut var_handle_mutated := var_handle
	mut var_result := rt.new_bool(false)
	if this.is_open(var_handle_mutated.clone()) {
		var_result = rt.call_function('fclose', [this.handles.array_get(var_handle_mutated)])
		this.handles.array_unset(var_handle_mutated)
	}
	return var_result.clone()
}

fn (mut this Class_WC_Log_Handler_File) add(var_entry rt.PhpVal, var_handle rt.PhpVal) bool {
	mut var_entry_mutated := var_entry
	mut var_handle_mutated := var_handle
	mut var_result := rt.new_bool(false)
	if this.should_rotate(var_handle_mutated.clone()) {
		this.log_rotate(var_handle_mutated.clone())
	}
	if this.open(var_handle_mutated.clone(), '')
		&& rt.is_true(rt.call_function('is_resource', [this.handles.array_get(var_handle_mutated)])) {
		var_result = rt.call_function('fwrite', [this.handles.array_get(var_handle_mutated),
			rt.new_string(var_entry_mutated.str() + (rt.get_constant('PHP_EOL')).str())])
	} else {
		this.cache_log(var_entry_mutated.clone(), var_handle_mutated.clone())
	}
	return rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_result)))
}

fn (mut this Class_WC_Log_Handler_File) clear(var_handle rt.PhpVal) rt.PhpVal {
	mut var_handle_mutated := var_handle
	mut var_result := rt.new_bool(false)
	this.close(var_handle_mutated.clone())
	if this.open(var_handle_mutated.clone(), 'w')
		&& rt.is_true(rt.call_function('is_resource', [this.handles.array_get(var_handle_mutated)])) {
		var_result = rt.new_bool(true)
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_log_clear'),
		var_handle_mutated.clone()])
	return var_result.clone()
}

fn (mut this Class_WC_Log_Handler_File) remove(var_handle rt.PhpVal) rt.PhpVal {
	mut var_handle_mutated := var_handle
	mut var_removed := rt.new_bool(false)
	mut var_logs := this.get_log_files()
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_LoggingUtil{}
	mut iife_result_1 := iife_temp_1.get_log_directory()
	mut var_log_directory := iife_result_1
	var_handle_mutated = rt.call_function('sanitize_title', [
		var_handle_mutated.clone()])
	if var_logs.array_isset(var_handle_mutated)
		&& rt.is_true(var_logs.array_get(var_handle_mutated)) {
		mut var_file := rt.call_function('realpath', [
			rt.new_string(
				(rt.call_function('trailingslashit', [var_log_directory.clone()])).str() +
				(var_logs.array_get(var_handle_mutated)).str()),
		])
		if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('stripos', [var_file.clone(), rt.call_function('realpath', [rt.call_function('trailingslashit', [var_log_directory.clone()])])])))
			&& rt.is_true(rt.call_function('is_file', [var_file.clone()]))
			&& rt.is_true(rt.call_function('is_writable', [var_file.clone()])) {
			this.close(var_file.clone())
			var_removed = rt.call_function('unlink', [var_file.clone()])
		}
		rt.call_function('do_action', [rt.new_string('woocommerce_log_remove'),
			var_handle_mutated.clone(), var_removed.clone()])
	}
	return var_removed.clone()
}

fn (mut this Class_WC_Log_Handler_File) should_rotate(var_handle rt.PhpVal) bool {
	mut var_handle_mutated := var_handle
	mut var_file := Class_WC_Log_Handler_File.get_log_file_path(var_handle_mutated.clone())
	if rt.is_true(var_file) {
		if this.is_open(var_handle_mutated.clone()) {
			mut var_file_stat := rt.call_function('fstat', [
				this.handles.array_get(var_handle_mutated),
			])
			return (rt.greater(var_file_stat.array_get(rt.new_string('size')), this.log_size_limit)).to_bool()
		} else if rt.is_true(rt.call_function('file_exists', [
			var_file.clone()]))
		{
			return (rt.greater(rt.call_function('filesize', [
				var_file.clone()]), this.log_size_limit)).to_bool()
		} else {
			return false
		}
	} else {
		return false
	}
	return false
}

fn (mut this Class_WC_Log_Handler_File) log_rotate(var_handle rt.PhpVal) {
	mut var_handle_mutated := var_handle
	mut var_i := rt.new_int(8)
	for {
		if !(rt.is_true(rt.greater_equal(var_i, rt.new_int(0)))) { break
		 }
		this.increment_log_infix(var_handle_mutated.clone(), var_i.clone())
		rt.post_dec(var_i)
	}
	this.increment_log_infix(var_handle_mutated.clone(), rt.new_null())
}

fn (mut this Class_WC_Log_Handler_File) increment_log_infix(var_handle rt.PhpVal, var_number rt.PhpVal) bool {
	mut var_handle_mutated := var_handle
	if rt.is_true(rt.identical(rt.new_null(), var_number)) {
		mut var_suffix := rt.new_string('')
		mut var_next_suffix := rt.new_string('.0')
	} else {
		var_suffix = rt.new_string('.' + var_number.str())
		var_next_suffix = rt.new_string('.' + (rt.add(var_number, rt.new_int(1))).str())
	}
	mut var_rename_from :=
		Class_WC_Log_Handler_File.get_log_file_path(rt.new_string('${var_handle.to_string()}${var_suffix.to_string()}'))
	mut var_rename_to :=
		Class_WC_Log_Handler_File.get_log_file_path(rt.new_string('${var_handle.to_string()}${var_next_suffix.to_string()}'))
	if this.is_open(var_rename_from.clone()) {
		this.close(var_rename_from.clone())
	}
	if rt.is_true(rt.call_function('is_writable', [var_rename_from.clone()])) {
		return (rt.call_function('rename', [var_rename_from.clone(),
			var_rename_to.clone()])).to_bool()
	} else {
		return false
	}
	return false
}

fn Class_WC_Log_Handler_File.get_log_file_path(var_handle rt.PhpVal) rt.PhpVal {
	mut var_handle_mutated := var_handle
	mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_LoggingUtil{}
	mut iife_result_2 := iife_temp_2.get_log_directory()
	mut var_log_directory := iife_result_2
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_hash')])) {
		return rt.new_string(
			(rt.call_function('trailingslashit', [var_log_directory.clone()])).str() +
			(Class_WC_Log_Handler_File.get_log_file_name(var_handle_mutated.clone())).str())
	} else {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('__', [
				rt.new_string('This method should not be called before plugins_loaded.'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('3.0')])
		return rt.new_bool(false)
	}
	return rt.new_null()
}

fn Class_WC_Log_Handler_File.get_log_file_name(var_handle rt.PhpVal) bool {
	mut var_handle_mutated := var_handle
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_hash')])) {
		mut var_date_suffix := rt.call_function('date', [rt.new_string('Y-m-d'),
			rt.call_function('time', []rt.PhpVal{})])
		mut var_hash_suffix := rt.call_function('wp_hash', [var_handle_mutated.clone()])
		return (rt.call_function('sanitize_file_name', [
			rt.new_string(
				(rt.call_function('implode', [rt.new_string('-'), rt.create_array([rt.ArrayItem{
				key: none
				val: var_handle_mutated
			}, rt.ArrayItem{ key: none, val: var_date_suffix }, rt.ArrayItem{
				key: none
				val: var_hash_suffix
			}])])).str() +
				'.log'),
		])).to_bool()
	} else {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('__', [
				rt.new_string('This method should not be called before plugins_loaded.'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('3.3')])
		return false
	}
	return false
}

fn (mut this Class_WC_Log_Handler_File) cache_log(var_entry rt.PhpVal, var_handle rt.PhpVal) {
	mut var_entry_mutated := var_entry
	mut var_handle_mutated := var_handle
	this.cached_logs.array_push(rt.create_array([
		rt.ArrayItem{ key: 'entry', val: var_entry_mutated },
		rt.ArrayItem{ key: 'handle', val: var_handle_mutated },
	]))
}

fn (mut this Class_WC_Log_Handler_File) write_cached_logs() {
	mut iter_2 := this.cached_logs.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_log := item_2.val
		this.add(var_log.array_get(rt.new_string('entry')),
			var_log.array_get(rt.new_string('handle')))
	}
}

fn Class_WC_Log_Handler_File.delete_logs_before_timestamp(timestamp i64) {
	if !(var_timestamp != 0) {
		return
	}
	mut var_log_files := Class_WC_Log_Handler_File.get_log_files()
	mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_LoggingUtil{}
	mut iife_result_3 := iife_temp_3.get_log_directory()
	mut var_log_directory := iife_result_3
	mut iter_3 := var_log_files.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_log_file := item_3.val
		mut var_last_modified := rt.call_function('filemtime', [
			rt.new_string(
				(rt.call_function('trailingslashit', [var_log_directory.clone()])).str() +
				var_log_file.str()),
		])
		if rt.is_true(rt.less(var_last_modified, rt.new_int(timestamp))) {
			rt.call_function('unlink', [
				rt.new_string(
					(rt.call_function('trailingslashit', [var_log_directory.clone()])).str() +
					var_log_file.str()),
			])
		}
	}
}

fn Class_WC_Log_Handler_File.get_log_files() rt.PhpVal {
	mut iife_temp_4 := Class_Automattic_WooCommerce_Utilities_LoggingUtil{}
	mut iife_result_4 := iife_temp_4.get_log_directory()
	mut var_log_directory := iife_result_4
	mut var_files := rt.call_function('scandir', [var_log_directory.clone()])
	mut var_result := rt.new_array()
	if !(!rt.is_true(var_files)) {
		mut iter_4 := var_files.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_value := item_4.val
			mut var_key := item_4.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
				var_value.clone(),
				rt.create_array([rt.ArrayItem{ key: none, val: '.' },
					rt.ArrayItem{ key: none, val: '..' }]),
				rt.new_bool(true),
			])))))
			{
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [var_value.clone()])))))
					&& rt.is_true(rt.call_function('strstr', [var_value.clone(), rt.new_string('.log')])) {
					var_result.array_set(rt.call_function('sanitize_title', [
						var_value.clone()]), var_value.clone())
				}
			}
		}
	}
	return var_result.clone()
}

struct Class_WC_Log_Handler {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_LoggingUtil {
	rt.PhpObjectBase
}

fn create_wc_log_handler_file(arg_0 rt.PhpVal) &Class_WC_Log_Handler_File {
	mut obj := &Class_WC_Log_Handler_File{
		PhpObjectBase:  rt.PhpObjectBase{}
		handles:        rt.new_array()
		log_size_limit: rt.new_null()
		cached_logs:    rt.new_array()
	}
	obj.construct(arg_0)
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

fn create_automattic_woocommerce_utilities_loggingutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_LoggingUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_LoggingUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Log_Handler_File) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'__destruct' {
			this.magic_destruct()
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
			return Class_WC_Log_Handler_File.format_entry(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3)
		}
		'open' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.open(dispatch_arg_0, dispatch_arg_1))
		}
		'is_open' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_open(dispatch_arg_0))
		}
		'close' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.close(dispatch_arg_0)
		}
		'add' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.add(dispatch_arg_0, dispatch_arg_1))
		}
		'clear' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.clear(dispatch_arg_0)
		}
		'remove' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.remove(dispatch_arg_0)
		}
		'should_rotate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.should_rotate(dispatch_arg_0))
		}
		'log_rotate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.log_rotate(dispatch_arg_0)
			return rt.new_null()
		}
		'increment_log_infix' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.increment_log_infix(dispatch_arg_0, dispatch_arg_1))
		}
		'get_log_file_path' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Log_Handler_File.get_log_file_path(dispatch_arg_0)
		}
		'get_log_file_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Log_Handler_File.get_log_file_name(dispatch_arg_0))
		}
		'cache_log' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.cache_log(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'write_cached_logs' {
			this.write_cached_logs()
			return rt.new_null()
		}
		'delete_logs_before_timestamp' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			Class_WC_Log_Handler_File.delete_logs_before_timestamp(dispatch_arg_0)
			return rt.new_null()
		}
		'get_log_files' {
			return Class_WC_Log_Handler_File.get_log_files()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Log_Handler_File) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'handles' { return this.handles }
		'log_size_limit' { return this.log_size_limit }
		'cached_logs' { return this.cached_logs }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Log_Handler_File) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'handles' {
			this.handles = val
			return true
		}
		'log_size_limit' {
			this.log_size_limit = val
			return true
		}
		'cached_logs' {
			this.cached_logs = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_Automattic_WooCommerce_Utilities_LoggingUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_LoggingUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_LoggingUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
