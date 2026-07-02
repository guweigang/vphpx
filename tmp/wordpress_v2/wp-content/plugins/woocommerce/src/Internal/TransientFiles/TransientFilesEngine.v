import rt

pub fn Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine.cleanup_action_name() string {
	return 'woocommerce_expired_transient_files_cleanup'
}

pub fn Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine.cleanup_action_group() string {
	return 'wc_batch_processes'
}

struct Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine {
	rt.PhpObjectBase
pub mut:
	legacy_proxy rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine) register() {
	rt.call_function('add_action', [
		Class_Automattic_WooCommerce_Internal_TransientFiles_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine.cleanup_action_name(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine', [
				'RegisterHooksInterface',
			], &this) },
			rt.ArrayItem{ key: none, val: 'handle_expired_files_cleanup_action' },
		]),
	])
	rt.call_function('add_filter', [rt.new_string('woocommerce_debug_tools'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine', [
				'RegisterHooksInterface',
			], &this) },
			rt.ArrayItem{ key: none, val: 'add_debug_tools_entries' },
		]),
		rt.new_int(999), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine', [
				'RegisterHooksInterface',
			], &this) },
			rt.ArrayItem{ key: none, val: 'add_endpoint' },
		]),
		rt.new_int(0)])
	rt.call_function('add_filter', [rt.new_string('query_vars'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine', [
				'RegisterHooksInterface',
			], &this) },
			rt.ArrayItem{ key: none, val: 'handle_query_vars' },
		]),
		rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('parse_request'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine', [
				'RegisterHooksInterface',
			], &this) },
			rt.ArrayItem{ key: none, val: 'handle_parse_request' },
		]),
		rt.new_int(0)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine) init(mut var_legacy_proxy Class_Automattic_WooCommerce_Proxies_LegacyProxy) {
	mut var_legacy_proxy_mutated := var_legacy_proxy
	this.legacy_proxy = var_legacy_proxy_mutated
}

fn (mut this Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine) get_transient_files_directory() string {
	mut var_upload_dir_info := rt.call_method(this.legacy_proxy, 'call_function', [
		rt.new_string('wp_upload_dir'),
	])
	mut var_default_transient_files_directory := rt.new_string(
		(rt.call_function('untrailingslashit', [var_upload_dir_info.array_get(rt.new_string('basedir'))])).str() +
		'/woocommerce_transient_files')
	mut var_transient_files_directory := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_transient_files_directory'),
		var_default_transient_files_directory.clone(),
	])
	mut var_realpathed_transient_files_directory := rt.call_method(this.legacy_proxy,
		'call_function', [rt.new_string('realpath'), var_transient_files_directory.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_realpathed_transient_files_directory)) {
		if rt.is_true(rt.identical(var_transient_files_directory,
			var_default_transient_files_directory))
		{
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.legacy_proxy,
				'call_function', [rt.new_string('wp_mkdir_p'),
				var_transient_files_directory.clone()])))))
			{
				rt.throw_exception(rt.new_object('Exception', []string{},
					create_exception(rt.new_string("Can't create directory: ${var_transient_files_directory.to_string()}"))))
			}
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
			rt.call_function('WP_Filesystem', []rt.PhpVal{})
			mut var_wp_filesystem := rt.call_method(this.legacy_proxy, 'get_global', [
				rt.new_string('wp_filesystem'),
			])
			rt.call_method(var_wp_filesystem, 'put_contents', [
				rt.new_string(var_transient_files_directory.str() + '/.htaccess'),
				rt.new_string('deny from all'),
			])
			rt.call_method(var_wp_filesystem, 'put_contents', [
				rt.new_string(var_transient_files_directory.str() + '/index.html'),
				rt.new_string(''),
			])
			var_realpathed_transient_files_directory = rt.call_method(this.legacy_proxy,
				'call_function', [rt.new_string('realpath'), var_transient_files_directory.clone()])
		} else {
			rt.throw_exception(rt.new_object('Exception', []string{},
				create_exception(rt.new_string("The base transient files directory doesn't exist: ${var_transient_files_directory.to_string()}"))))
		}
	}
	return (rt.call_function('untrailingslashit',
		[var_realpathed_transient_files_directory.clone()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine) create_transient_file(file_contents string, var_expiration_date rt.PhpVal) string {
	mut var_expiration_date_mutated := var_expiration_date
	if rt.is_true(rt.new_bool(var_expiration_date_mutated.clone().is_long()
		|| var_expiration_date_mutated.clone().is_double()))
	{
		var_expiration_date_mutated = rt.call_function('gmdate', [
			rt.new_string('Y-m-d'), var_expiration_date_mutated.clone()])
		mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_TimeUtil{}
		mut iife_result_0 := iife_temp_0.is_valid_date(var_expiration_date_mutated.clone(),
			rt.new_string('Y-m-d'))
	} else if !(var_expiration_date_mutated.clone().is_string())
		|| rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		var_expiration_date_mutated = if rt.is_true(rt.call_function('is_scalar', [
			var_expiration_date_mutated.clone(),
		]))
		{ var_expiration_date_mutated } else { rt.call_function('gettype', [
				var_expiration_date_mutated.clone()]) }
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{},
			create_invalidargumentexception(rt.new_string('${var_expiration_date.to_string()} is not a valid date, expected format: YYYY-MM-DD'))))
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_TimeUtil{}
	mut iife_result_1 := iife_temp_1.get_utc_date_time_zone()
	mut iife_temp_2 := Class_DateTime{}
	mut iife_result_2 := iife_temp_2.createfromformat(rt.new_string('Y-m-d'),
		var_expiration_date_mutated.clone(), iife_result_1)
	mut var_expiration_date_object := iife_result_2
	mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_TimeUtil{}
	mut iife_result_3 := iife_temp_3.get_utc_date_time_zone()
	mut var_today_date_object := create_datetime(rt.call_method(this.legacy_proxy, 'call_function', [
		rt.new_string('gmdate'),
		rt.new_string('Y-m-d'),
	]), iife_result_3)
	if rt.is_true(rt.less(var_expiration_date_object, var_today_date_object)) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{},
			create_invalidargumentexception(rt.new_string('The supplied expiration date, ${var_expiration_date.to_string()}, is in the past'))))
	}
	mut var_filename := rt.call_function('bin2hex', [
		rt.call_method(this.legacy_proxy, 'call_function', [
			rt.new_string('random_bytes'),
			rt.new_int(16),
		]),
	])
	mut var_transient_files_directory := rt.new_string(this.get_transient_files_directory())
	var_transient_files_directory = rt.concat(var_transient_files_directory, rt.new_string('/' +
		(rt.call_method(var_expiration_date_object, 'format', [rt.new_string('Y-m-d')])).str()))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.legacy_proxy, 'call_function', [
		rt.new_string('is_dir'),
		var_transient_files_directory.clone(),
	])))))
	{
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.legacy_proxy, 'call_function', [
			rt.new_string('wp_mkdir_p'),
			var_transient_files_directory.clone(),
		])))))
		{
			rt.throw_exception(rt.new_object('Exception', []string{},
				create_exception(rt.new_string("Can't create directory: ${var_transient_files_directory.to_string()}"))))
		}
	}
	mut var_filepath :=
		rt.new_string(var_transient_files_directory.str() + '/' + var_filename.str())
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
	rt.call_function('WP_Filesystem', []rt.PhpVal{})
	mut var_wp_filesystem := rt.call_method(this.legacy_proxy, 'get_global', [
		rt.new_string('wp_filesystem'),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_method(var_wp_filesystem,
		'put_contents', [var_filepath.clone(), rt.new_string(file_contents)])))
	{
		rt.throw_exception(rt.new_object('Exception', []string{},
			create_exception(rt.new_string("Can't create file: ${var_filepath.to_string()}"))))
	}
	return (rt.call_function('sprintf', [rt.new_string('%03x%01x%02x%s'),
		rt.call_method(var_expiration_date_object, 'format', [
			rt.new_string('Y')]),
		rt.call_method(var_expiration_date_object, 'format', [
			rt.new_string('m')]),
		rt.call_method(var_expiration_date_object, 'format', [
			rt.new_string('d')]),
		var_filename.clone()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine) get_transient_file_path(filename string) string {
	mut filename_mutated := filename
	mut var_expiration_date :=
		Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine.get_expiration_date(filename_mutated)
	if rt.is_true(rt.new_bool(var_expiration_date.clone().is_null())) {
		return (rt.new_null()).str()
	}
	mut var_file_path := rt.new_string(this.get_transient_files_directory() + '/' +
		var_expiration_date.str() + '/' +
		(rt.call_function('substr', [rt.new_string(filename_mutated).clone(), rt.new_int(6)])).str())
	return (if rt.is_true(rt.call_function('is_file', [var_file_path.clone()])) {
		var_file_path
	} else {
		rt.new_null()
	}).str()
}

fn Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine.get_expiration_date(filename string) string {
	mut filename_mutated := filename
	if filename_mutated.len < 7
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('ctype_xdigit', [rt.new_string(filename_mutated).clone()]))))) {
		return (rt.new_null()).str()
	}
	mut var_expiration_date := rt.call_function('sprintf', [
		rt.new_string('%04d-%02d-%02d'),
		rt.call_function('hexdec', [
			rt.call_function('substr', [rt.new_string(filename_mutated).clone(),
				rt.new_int(0), rt.new_int(3)]),
		]),
		rt.call_function('hexdec', [
			rt.call_function('substr', [rt.new_string(filename_mutated).clone(),
				rt.new_int(3), rt.new_int(1)]),
		]),
		rt.call_function('hexdec', [
			rt.call_function('substr', [rt.new_string(filename_mutated).clone(),
				rt.new_int(4), rt.new_int(2)]),
		]),
	])
	mut iife_temp_4 := Class_Automattic_WooCommerce_Utilities_TimeUtil{}
	mut iife_result_4 := iife_temp_4.is_valid_date(var_expiration_date.clone(),
		rt.new_string('Y-m-d'))
	return (if rt.is_true(iife_result_4) {
		var_expiration_date
	} else {
		rt.new_null()
	}).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine) get_public_url(filename string) rt.PhpVal {
	mut filename_mutated := filename
	return rt.call_method(this.legacy_proxy, 'call_function', [
		rt.new_string('get_site_url'),
		rt.new_null(),
		rt.new_string('/wc/file/transient/' + filename_mutated),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine) file_has_expired(file_path string) bool {
	mut file_path_mutated := file_path
	mut var_dirname := rt.call_function('dirname', [rt.new_string(file_path_mutated).clone()])
	mut var_expiration_date := rt.call_function('basename', [
		var_dirname.clone()])
	mut iife_temp_5 := Class_Automattic_WooCommerce_Utilities_TimeUtil{}
	mut iife_result_5 := iife_temp_5.get_utc_date_time_zone()
	mut var_expiration_date_object := create_datetime(var_expiration_date.clone(), iife_result_5)
	mut iife_temp_6 := Class_Automattic_WooCommerce_Utilities_TimeUtil{}
	mut iife_result_6 := iife_temp_6.get_utc_date_time_zone()
	mut var_today_date_object := create_datetime(rt.call_method(this.legacy_proxy, 'call_function', [
		rt.new_string('gmdate'),
		rt.new_string('Y-m-d'),
	]), iife_result_6)
	return (rt.less(var_expiration_date_object, var_today_date_object)).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine) delete_transient_file(filename string) bool {
	mut filename_mutated := filename
	mut var_file_path := rt.new_string(this.get_transient_file_path(filename_mutated))
	if rt.is_true(rt.new_bool(var_file_path.clone().is_null())) {
		return false
	}
	mut var_dirname := rt.call_function('dirname', [var_file_path.clone()])
	rt.call_function('wp_delete_file', [var_file_path.clone()])
	this.delete_directory_if_not_empty(var_dirname.str())
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine) delete_expired_files(limit i64) rt.PhpVal {
	mut var_name := rt.new_null()
	mut var_expiration_date_gmt := rt.call_method(this.legacy_proxy, 'call_function', [
		rt.new_string('gmdate'),
		rt.new_string('Y-m-d'),
	])
	mut var_base_dir := rt.new_string(this.get_transient_files_directory())
	mut var_subdirs := rt.call_function('glob', [
		rt.new_string(var_base_dir.str() + '/[2-9][0-9][0-9][0-9]-[01][0-9]-[0-3][0-9]'),
		rt.get_constant('GLOB_ONLYDIR'),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_subdirs)) {
		rt.throw_exception(rt.new_object('Exception', []string{},
			create_exception(rt.new_string('Error when getting the list of subdirectories of ${var_base_dir.to_string()}'))))
	}
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_name := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('substr', [var_name.clone(),
			rt.new_int(var_name.clone().to_string().len - 10),
			rt.new_int(10)])
	}
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_name := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('substr', [var_name.clone(),
			rt.new_int(var_name.clone().to_string().len - 10),
			rt.new_int(10)])
	}
	var_subdirs = rt.call_function('array_map', [rt.new_closure(closure_8_fn),
		var_subdirs.clone()])
	closure_10_fn := fn [var_expiration_date_gmt] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_name := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.less(var_name, var_expiration_date_gmt)
	}
	mut var_expired_subdirs := rt.call_function('array_filter', [
		var_subdirs.clone(), rt.new_closure(closure_10_fn)])
	rt.call_function('asort', [var_subdirs.clone()])
	mut var_remaining_limit := rt.new_int(limit)
	mut var_limit_reached := rt.new_bool(false)
	mut iter_1 := var_expired_subdirs.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_subdir := item_1.val
		mut var_full_dir_path := rt.new_string(var_base_dir.str() + '/' + var_subdir.str())
		mut var_files_to_delete := rt.call_function('glob', [
			rt.new_string(var_full_dir_path.str() + '/*'),
		])
		if rt.is_true(rt.greater(rt.new_int(var_files_to_delete.clone().array_count()),
			var_remaining_limit))
		{
			var_limit_reached = rt.new_bool(true)
			var_files_to_delete = rt.call_function('array_slice', [
				var_files_to_delete.clone(), rt.new_int(0), var_remaining_limit.clone()])
		}
		rt.call_function('array_map', [rt.new_string('wp_delete_file'),
			var_files_to_delete.clone()])
		var_remaining_limit = rt.sub(var_remaining_limit,
			rt.new_int(var_files_to_delete.clone().array_count()))
		this.delete_directory_if_not_empty(var_full_dir_path.str())
		if rt.is_true(var_limit_reached) {
			break
		}
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'deleted_count', val: rt.sub(rt.new_int(limit), var_remaining_limit) },
		rt.ArrayItem{ key: 'files_remain', val: var_limit_reached },
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine) expired_files_cleanup_is_scheduled() bool {
	return (rt.call_function('as_has_scheduled_action', [
		Class_Automattic_WooCommerce_Internal_TransientFiles_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine.cleanup_action_name(),
		rt.new_array(),
		Class_Automattic_WooCommerce_Internal_TransientFiles_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine.cleanup_action_group(),
	])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine) schedule_expired_files_cleanup() {
	this.unschedule_expired_files_cleanup()
	rt.call_function('as_schedule_single_action', [
		rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int(1)),
		Class_Automattic_WooCommerce_Internal_TransientFiles_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine.cleanup_action_name(),
		rt.new_array(),
		Class_Automattic_WooCommerce_Internal_TransientFiles_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine.cleanup_action_group(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine) unschedule_expired_files_cleanup() {
	if this.expired_files_cleanup_is_scheduled() {
		rt.call_function('as_unschedule_action', [
			Class_Automattic_WooCommerce_Internal_TransientFiles_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine.cleanup_action_name(),
			rt.new_array(),
			Class_Automattic_WooCommerce_Internal_TransientFiles_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine.cleanup_action_group(),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine) handle_expired_files_cleanup_action() {
	mut var_new_interval := rt.new_null()
	mut var_result := this.delete_expired_files(0)
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.greater(var_result.array_get(rt.new_string('deleted_count')), rt.new_int(0))) {
		var_new_interval = rt.new_int(1)
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto finally_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()

	finally_label_1:
	if rt.is_true(rt.new_bool(var_new_interval.clone().is_null())) {
		var_new_interval = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_delete_expired_transient_files_interval'),
			rt.get_constant('DAY_IN_SECONDS'),
		])
	}
	mut var_next_time := rt.add(rt.call_method(this.legacy_proxy, 'call_function', [
		rt.new_string('time'),
	]), var_new_interval)
	rt.call_method(this.legacy_proxy, 'call_function', [
		rt.new_string('as_schedule_single_action'),
		var_next_time.clone(),
		Class_Automattic_WooCommerce_Internal_TransientFiles_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine.cleanup_action_name(),
		rt.new_array(),
		Class_Automattic_WooCommerce_Internal_TransientFiles_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine.cleanup_action_group(),
	])
	if rt.has_exception() { return }

	end_label_1:
}

fn (mut this Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine) add_debug_tools_entries(mut var_tools_array Class_Automattic_WooCommerce_Internal_TransientFiles_array) rt.PhpVal {
	mut var_tools_array_mutated := var_tools_array
	mut var_cleanup_is_scheduled := rt.new_bool(this.expired_files_cleanup_is_scheduled())
	var_tools_array_mutated.array_set('schedule_expired_transient_files_cleanup', rt.create_array([
		rt.ArrayItem{
			key: 'name'
			val: if rt.is_true(var_cleanup_is_scheduled) { rt.call_function('__', [
					rt.new_string('Re-schedule expired transient files cleanup'),
					rt.new_string('woocommerce'),
				]) } else { rt.call_function('__', [
					rt.new_string('Schedule expired transient files cleanup'),
					rt.new_string('woocommerce'),
				]) }
		},
		rt.ArrayItem{
			key: 'desc'
			val: if rt.is_true(var_cleanup_is_scheduled) { rt.call_function('__', [
					rt.new_string('Remove the currently scheduled action to delete expired transient files, then schedule it again for running immediately. Subsequent actions will run once every 24h.'),
					rt.new_string('woocommerce'),
				]) } else { rt.call_function('__', [
					rt.new_string('Schedule the action to delete expired transient files for running immediately. Subsequent actions will run once every 24h.'),
					rt.new_string('woocommerce'),
				]) }
		},
		rt.ArrayItem{
			key: 'button'
			val: if rt.is_true(var_cleanup_is_scheduled) { rt.call_function('__', [
					rt.new_string('Re-schedule'),
					rt.new_string('woocommerce'),
				]) } else { rt.call_function('__', [
					rt.new_string('Schedule'),
					rt.new_string('woocommerce'),
				]) }
		},
		rt.ArrayItem{ key: 'requires_refresh', val: true },
		rt.ArrayItem{ key: 'callback', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine', [
				'RegisterHooksInterface',
			], &this) },
			rt.ArrayItem{ key: none, val: 'schedule_expired_files_cleanup' },
		]) },
	]))
	if rt.is_true(var_cleanup_is_scheduled) {
		var_tools_array_mutated.array_set('unschedule_expired_transient_files_cleanup', rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Un-schedule expired transient files cleanup'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string("Remove the currently scheduled action to delete expired transient files. Expired files won't be automatically deleted until the 'Schedule expired transient files cleanup' tool is run again."),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
				rt.new_string('Un-schedule'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'requires_refresh', val: true },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine', [
					'RegisterHooksInterface',
				], &this) },
				rt.ArrayItem{ key: none, val: 'unschedule_expired_files_cleanup' },
			]) },
		]))
	}
	return rt.new_object('Automattic_WooCommerce_Internal_TransientFiles_array', []string{},
		var_tools_array_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine) delete_directory_if_not_empty(directory string) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(create_automattic_woocommerce_internal_transientfiles_filesystemiterator(rt.new_string(directory)),
		'valid', []rt.PhpVal{})))))
	{
		rt.call_function('rmdir', [rt.new_string(directory)])
	}
}

fn Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine.add_endpoint() {
	rt.call_function('add_rewrite_rule', [rt.new_string('^wc/file/transient/?$'),
		rt.new_string('index.php?wc-transient-file-name='), rt.new_string('top')])
	rt.call_function('add_rewrite_rule', [rt.new_string('^wc/file/transient/(.+)$'),
		rt.new_string('index.php?wc-transient-file-name=$matches[1]'),
		rt.new_string('top')])
	rt.call_function('add_rewrite_endpoint', [rt.new_string('wc/file/transient'),
		rt.get_constant('EP_ALL')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine) handle_query_vars(var_vars rt.PhpVal) rt.PhpVal {
	mut var_vars_mutated := var_vars
	var_vars_mutated.array_push('wc-transient-file-name')
	return var_vars_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine) handle_parse_request() {
	mut var_wp := rt.new_null()
	mut var_query_arg := rt.call_function('wp_unslash', [if !(rt.get_superglobal('_GET').array_get(rt.new_string('wc-transient-file-name'))).is_null() {
		rt.get_superglobal('_GET').array_get(rt.new_string('wc-transient-file-name'))
	} else {
		rt.new_null()
	}])
	if !(var_query_arg.clone().is_null()) {
		rt.get_property(var_wp, 'query_vars').array_set('wc-transient-file-name',
			var_query_arg.clone())
	}
	if rt.is_true(rt.new_bool(if !(rt.get_property(var_wp, 'query_vars').array_get(rt.new_string('wc-transient-file-name'))).is_null() {
		rt.get_property(var_wp, 'query_vars').array_get(rt.new_string('wc-transient-file-name'))
	} else {
		rt.new_null()
	}.is_null()))
	{
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('GET'), if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_METHOD'))).is_null() {
		rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_METHOD'))
	} else {
		rt.new_null()
	}))))
	{
		rt.call_function('status_header', [rt.new_int(405)])
		exit(0)
	}
	this.serve_file_contents((rt.get_property(var_wp, 'query_vars').array_get(rt.new_string('wc-transient-file-name'))).str())
}

fn (mut this Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine) serve_file_contents(file_name string) {
	mut var_legacy_proxy := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [Class_Automattic_WooCommerce_Proxies_LegacyProxy.class()])
	mut var_file_path := rt.new_string(this.get_transient_file_path(file_name))
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if rt.is_true(rt.new_bool(var_file_path.clone().is_null())) {
		rt.call_method(var_legacy_proxy, 'call_function', [
			rt.new_string('status_header'),
			rt.new_int(404),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		rt.call_method(var_legacy_proxy, 'exit', []rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if this.file_has_expired(var_file_path.str()) {
		rt.call_method(var_legacy_proxy, 'call_function', [
			rt.new_string('status_header'),
			rt.new_int(404),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		rt.call_method(var_legacy_proxy, 'exit', []rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	mut var_file_length := rt.call_function('filesize', [var_file_path.clone()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_file_length)) {
		rt.throw_exception(rt.new_object('Exception', []string{},
			create_exception(rt.new_string("Can't retrieve file size: ${var_file_path.to_string()}"))))
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	mut var_file_handle := rt.call_function('fopen', [var_file_path.clone(),
		rt.new_string('r')])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_ex := var_e_2.clone()
		mut var_error_message := rt.new_string((rt.concat(rt.concat(rt.concat(rt.new_string('Error serving transient file '),
			rt.new_string(file_name)), rt.new_string(': ')), rt.call_method(var_ex, 'getMessage',
			[]rt.PhpVal{}))).str())
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [
			var_error_message.clone(),
		])
		rt.call_method(var_legacy_proxy, 'call_function', [
			rt.new_string('status_header'),
			rt.new_int(500),
		])
		rt.call_method(var_legacy_proxy, 'exit', []rt.PhpVal{})
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
	}

	end_label_2:
	rt.call_method(var_legacy_proxy, 'call_function', [rt.new_string('status_header'),
		rt.new_int(200)])
	rt.call_method(var_legacy_proxy, 'call_function', [rt.new_string('header'),
		rt.new_string('Content-Type: text/html')])
	rt.call_method(var_legacy_proxy, 'call_function', [rt.new_string('header'),
		rt.new_string('Content-Length: ${var_file_length.to_string()}')])
	for rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('feof', [
		var_file_handle.clone()]))))) {
		rt.echo_val(rt.call_function('fread', [var_file_handle.clone(),
			rt.new_int(1024)]))
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_transient_file_contents_served'),
		rt.new_string(file_name),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	unsafe {
		goto finally_label_3
	}
	catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Exception') {
		mut var_e := var_e_3.clone()
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [
			rt.concat(rt.concat(rt.concat(rt.new_string('Error serving transient file '),
				rt.new_string(file_name)), rt.new_string(': ')), rt.call_method(var_e,
				'getMessage', []rt.PhpVal{})),
		])
		unsafe {
			goto finally_label_3
		}
	} else {
		rt.throw_exception(var_e_3)
		unsafe {
			goto finally_label_3
		}
	}

	finally_label_3:
	rt.call_function('fclose', [var_file_handle.clone()])
	rt.call_method(var_legacy_proxy, 'exit', []rt.PhpVal{})
	if rt.has_exception() { return }

	end_label_3:
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
	message string
	code    i64
	file    string
	line    i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_Automattic_WooCommerce_Utilities_TimeUtil {
	rt.PhpObjectBase
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_DateTime {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_TransientFiles_FilesystemIterator {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_transientfiles_transientfilesengine(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine {
	mut obj := &Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine{
		PhpObjectBase: rt.PhpObjectBase{}
		legacy_proxy:  rt.new_null()
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_utilities_timeutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_TimeUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_TimeUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_invalidargumentexception(_args ...rt.PhpVal) &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetime(_args ...rt.PhpVal) &Class_DateTime {
	mut obj := &Class_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_transientfiles_filesystemiterator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_TransientFiles_FilesystemIterator {
	mut obj := &Class_Automattic_WooCommerce_Internal_TransientFiles_FilesystemIterator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			this.register()
			return rt.new_null()
		}
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Proxies_LegacyProxy](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_transient_files_directory' {
			return rt.new_string(this.get_transient_files_directory())
		}
		'create_transient_file' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.create_transient_file(dispatch_arg_0, dispatch_arg_1))
		}
		'get_transient_file_path' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_transient_file_path(dispatch_arg_0))
		}
		'get_expiration_date' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine.get_expiration_date(dispatch_arg_0))
		}
		'get_public_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_public_url(dispatch_arg_0)
		}
		'file_has_expired' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.file_has_expired(dispatch_arg_0))
		}
		'delete_transient_file' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.delete_transient_file(dispatch_arg_0))
		}
		'delete_expired_files' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.delete_expired_files(dispatch_arg_0)
		}
		'expired_files_cleanup_is_scheduled' {
			return rt.new_bool(this.expired_files_cleanup_is_scheduled())
		}
		'schedule_expired_files_cleanup' {
			this.schedule_expired_files_cleanup()
			return rt.new_null()
		}
		'unschedule_expired_files_cleanup' {
			this.unschedule_expired_files_cleanup()
			return rt.new_null()
		}
		'handle_expired_files_cleanup_action' {
			this.handle_expired_files_cleanup_action()
			return rt.new_null()
		}
		'add_debug_tools_entries' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_TransientFiles_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.add_debug_tools_entries(mut dispatch_arg_0)
		}
		'delete_directory_if_not_empty' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.delete_directory_if_not_empty(dispatch_arg_0)
			return rt.new_null()
		}
		'add_endpoint' {
			Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine.add_endpoint()
			return rt.new_null()
		}
		'handle_query_vars' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.handle_query_vars(dispatch_arg_0)
		}
		'handle_parse_request' {
			this.handle_parse_request()
			return rt.new_null()
		}
		'serve_file_contents' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.serve_file_contents(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'legacy_proxy' { return this.legacy_proxy }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'legacy_proxy' {
			this.legacy_proxy = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Utilities_TimeUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_TimeUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_TimeUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_TransientFiles_FilesystemIterator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_TransientFiles_FilesystemIterator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_TransientFiles_FilesystemIterator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
