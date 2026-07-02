import rt

struct Class_Core_Upgrader {
	rt.PhpObjectBase
}

fn (mut this Class_Core_Upgrader) upgrade_strings() {
	rt.get_property(rt.new_object('Core_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('up_to_date', rt.call_function('__', [
		rt.new_string('WordPress is at the latest version.'),
	]))
	rt.get_property(rt.new_object('Core_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('locked', rt.call_function('__', [
		rt.new_string('Another update is currently in progress.'),
	]))
	rt.get_property(rt.new_object('Core_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('no_package', rt.call_function('__', [
		rt.new_string('Update package not available.'),
	]))
	rt.get_property(rt.new_object('Core_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('downloading_package', rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Downloading update from %s&#8230;')]),
		rt.new_string('<span class="code pre">%s</span>'),
	]))
	rt.get_property(rt.new_object('Core_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('unpack_package', rt.call_function('__', [
		rt.new_string('Unpacking the update&#8230;'),
	]))
	rt.get_property(rt.new_object('Core_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('copy_failed', rt.call_function('__', [
		rt.new_string('Could not copy files.'),
	]))
	rt.get_property(rt.new_object('Core_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('copy_failed_space', rt.call_function('__', [
		rt.new_string('Could not copy files. You may have run out of disk space.'),
	]))
	rt.get_property(rt.new_object('Core_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('start_rollback', rt.call_function('__', [
		rt.new_string('Attempting to restore the previous version.'),
	]))
	rt.get_property(rt.new_object('Core_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('rollback_was_required', rt.call_function('__', [
		rt.new_string('Due to an error during updating, WordPress has been restored to your previous version.'),
	]))
}

fn (mut this Class_Core_Upgrader) upgrade(var_current rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_wp_filesystem := rt.new_null()
	mut var_wp_version := rt.new_null()
	mut var_GLOBALS := rt.new_null()
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/version.php', '3')
	mut var_start_time := rt.call_function('time', []rt.PhpVal{})
	mut var_defaults := {
		'pre_check_md5':                true
		'attempt_rollback':             false
		'do_rollback':                  false
		'allow_relaxed_file_ownership': false
	}
	mut var_parsed_args := rt.call_function('wp_parse_args', [
		var_args.clone(), rt.create_array_from_native_map(var_defaults)])
	this.init()
	this.upgrade_strings()
	if !(!(rt.get_property(var_current, 'response')).is_null())
		|| rt.is_true(rt.identical(rt.new_string('latest'), rt.get_property(var_current, 'response'))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('up_to_date'), rt.get_property(rt.new_object('Core_Upgrader', [
			'WP_Upgrader',
		], &this), 'strings').array_get(rt.new_string('up_to_date'))))
	}
	mut var_res := this.fs_connect(rt.create_array([
		rt.ArrayItem{ key: none, val: rt.get_constant('ABSPATH') },
		rt.ArrayItem{ key: none, val: rt.get_constant('WP_CONTENT_DIR') },
	]), var_parsed_args.array_get(rt.new_string('allow_relaxed_file_ownership')))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_res))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_res.clone()])) {
		return var_res.clone()
	}
	mut var_wp_dir := rt.call_function('trailingslashit', [
		rt.call_method(var_wp_filesystem, 'abspath', []rt.PhpVal{}),
	])
	mut var_partial := rt.new_bool(true)
	if rt.is_true(var_parsed_args.array_get(rt.new_string('do_rollback'))) {
		var_partial = rt.new_bool(false)
	} else if rt.is_true(var_parsed_args.array_get(rt.new_string('pre_check_md5')))
		&& !(this.check_files()) {
		var_partial = rt.new_bool(false)
	}
	if rt.is_true(var_parsed_args.array_get(rt.new_string('do_rollback')))
		&& rt.is_true(rt.get_property(rt.get_property(var_current, 'packages'), 'rollback')) {
		mut var_to_download := rt.new_string('rollback')
	} else if rt.is_true(rt.get_property(rt.get_property(var_current, 'packages'), 'partial'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('reinstall'), rt.get_property(var_current, 'response')))))
		&& rt.is_true(rt.identical(var_wp_version, rt.get_property(var_current, 'partial_version')))
		&& rt.is_true(var_partial) {
		var_to_download = rt.new_string('partial')
	} else if rt.is_true(rt.get_property(rt.get_property(var_current, 'packages'), 'new_bundled'))
		&& rt.is_true(rt.call_function('version_compare', [var_wp_version.clone(), rt.get_property(var_current, 'new_bundled'), rt.new_string('<')]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('CORE_UPGRADE_SKIP_NEW_BUNDLED')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('CORE_UPGRADE_SKIP_NEW_BUNDLED'))))) {
		var_to_download = rt.new_string('new_bundled')
	} else if rt.is_true(rt.get_property(rt.get_property(var_current, 'packages'), 'no_content')) {
		var_to_download = rt.new_string('no_content')
	} else {
		var_to_download = rt.new_string('full')
	}
	mut iife_temp_0 := Class_WP_Upgrader{}
	mut iife_result_0 := iife_temp_0.create_lock(rt.new_string('core_updater'), rt.mul(rt.new_int(15),
		rt.get_constant('MINUTE_IN_SECONDS')))
	mut var_lock := iife_result_0
	if rt.is_true(rt.new_bool(!(rt.is_true(var_lock)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('locked'), rt.get_property(rt.new_object('Core_Upgrader', [
			'WP_Upgrader',
		], &this), 'strings').array_get(rt.new_string('locked'))))
	}
	mut var_download := this.download_package(rt.get_property(rt.get_property(var_current,
		'packages'), '{"nodeType":"Expr_Variable","line":128,"name":"to_download"}'),
		rt.new_bool(false))
	if rt.is_true(rt.call_function('is_wp_error', [var_download.clone()]))
		&& rt.is_true(rt.call_method(var_download, 'get_error_data', [rt.new_string('softfail-filename')])) {
		rt.call_function('apply_filters', [rt.new_string('update_feedback'),
			rt.call_method(var_download, 'get_error_message', []rt.PhpVal{})])
		rt.call_function('wp_version_check', [
			rt.create_array([
				rt.ArrayItem{ key: 'signature_failure_code', val: rt.call_method(var_download,
					'get_error_code', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'signature_failure_data', val: rt.call_method(var_download,
					'get_error_data', []rt.PhpVal{}) },
			]),
		])
		var_download = rt.call_method(var_download, 'get_error_data', [
			rt.new_string('softfail-filename'),
		])
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_download.clone()])) {
		mut iife_temp_1 := Class_WP_Upgrader{}
		mut iife_result_1 := iife_temp_1.release_lock(rt.new_string('core_updater'))
		return var_download.clone()
	}
	mut var_working_dir := this.unpack_package(var_download.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_working_dir.clone()])) {
		mut iife_temp_2 := Class_WP_Upgrader{}
		mut iife_result_2 := iife_temp_2.release_lock(rt.new_string('core_updater'))
		return var_working_dir.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'copy', [
		rt.new_string(var_working_dir.str() + '/wordpress/wp-admin/includes/update-core.php'),
		rt.new_string(var_wp_dir.str() + 'wp-admin/includes/update-core.php'),
		rt.new_bool(true),
	])))))
	{
		rt.call_method(var_wp_filesystem, 'delete', [var_working_dir.clone(),
			rt.new_bool(true)])
		mut iife_temp_3 := Class_WP_Upgrader{}
		mut iife_result_3 := iife_temp_3.release_lock(rt.new_string('core_updater'))
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('copy_failed_for_update_core_file'), rt.call_function('__', [
			rt.new_string('The update cannot be installed because some files could not be copied. This is usually due to inconsistent file permissions.'),
		]), rt.new_string('wp-admin/includes/update-core.php')))
	}
	rt.call_method(var_wp_filesystem, 'chmod', [
		rt.new_string(var_wp_dir.str() + 'wp-admin/includes/update-core.php'),
		rt.get_constant('FS_CHMOD_FILE'),
	])
	rt.call_function('wp_opcache_invalidate', [
		rt.new_string((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/update-core.php'),
	])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/update-core.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('update_core'),
	])))))
	{
		mut iife_temp_4 := Class_WP_Upgrader{}
		mut iife_result_4 := iife_temp_4.release_lock(rt.new_string('core_updater'))
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('copy_failed_space'), rt.get_property(rt.new_object('Core_Upgrader', [
			'WP_Upgrader',
		], &this), 'strings').array_get(rt.new_string('copy_failed_space'))))
	}
	mut var_result := rt.call_function('update_core', [var_working_dir.clone(),
		var_wp_dir.clone()])
	if rt.is_true(var_parsed_args.array_get(rt.new_string('attempt_rollback')))
		&& rt.is_true(rt.get_property(rt.get_property(var_current, 'packages'), 'rollback'))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_parsed_args.array_get(rt.new_string('do_rollback')))))) {
		mut var_try_rollback := rt.new_bool(false)
		if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
			mut var_error_code := rt.call_method(var_result, 'get_error_code', []rt.PhpVal{})
			if rt.is_true(rt.call_function('str_contains', [var_error_code.clone(),
				rt.new_string('do_rollback')]))
			{
				var_try_rollback = rt.new_bool(true)
			} else if rt.is_true(rt.call_function('str_contains', [
				var_error_code.clone(), rt.new_string('__copy_dir')]))
			{
				var_try_rollback = rt.new_bool(true)
			} else if rt.is_true(rt.identical(rt.new_string('disk_full'), var_error_code)) {
				var_try_rollback = rt.new_bool(true)
			}
		}
		if rt.is_true(var_try_rollback) {
			rt.call_function('apply_filters', [rt.new_string('update_feedback'),
				var_result.clone()])
			rt.call_function('apply_filters', [rt.new_string('update_feedback'),
				rt.get_property(rt.new_object('Core_Upgrader', ['WP_Upgrader'], &this), 'strings').array_get(rt.new_string('start_rollback'))])
			mut var_rollback_result := this.upgrade(var_current.clone(), rt.call_function('array_merge', [
				var_parsed_args.clone(),
				rt.create_array([rt.ArrayItem{ key: 'do_rollback', val: true }]),
			]))
			mut var_original_result := var_result.clone()
			var_result = create_wp_error(rt.new_string('rollback_was_required'), rt.get_property(rt.new_object('Core_Upgrader', [
				'WP_Upgrader',
			], &this), 'strings').array_get(rt.new_string('rollback_was_required')), rt.array_to_object(rt.create_array([
				rt.ArrayItem{ key: 'update', val: var_original_result },
				rt.ArrayItem{ key: 'rollback', val: var_rollback_result },
			])))
		}
	}
	rt.call_function('do_action', [rt.new_string('upgrader_process_complete'),
		rt.new_object('Core_Upgrader', ['WP_Upgrader'], &this),
		rt.create_array([rt.ArrayItem{ key: 'action', val: 'update' },
			rt.ArrayItem{ key: 'type', val: 'core' }])])
	rt.call_function('delete_site_transient', [rt.new_string('update_core')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_parsed_args.array_get(rt.new_string('do_rollback')))))) {
		mut var_stats := {
			'update_type':      rt.get_property(var_current, 'response')
			'success':          rt.new_bool(true)
			'fs_method':        rt.get_property(var_wp_filesystem, 'method')
			'fs_method_forced': rt.new_bool(
				rt.is_true(rt.call_function('defined', [rt.new_string('FS_METHOD')]))
				|| rt.is_true(rt.call_function('has_filter', [rt.new_string('filesystem_method')])))
			'fs_method_direct': if !(!rt.is_true(var_GLOBALS.array_get(rt.new_string('_wp_filesystem_direct_method')))) {
				var_GLOBALS.array_get(rt.new_string('_wp_filesystem_direct_method'))
			} else {
				rt.new_string('')
			}
			'time_taken':       rt.call_function('time', []rt.PhpVal{}) - var_start_time
			'reported':         var_wp_version
			'attempted':        rt.get_property(var_current, 'version')
		}
		if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
			var_stats['success'] = rt.new_bool(false)
			if !(!rt.is_true(var_try_rollback)) {
				var_stats['error_code'] = rt.call_method(var_original_result, 'get_error_code',
					[]rt.PhpVal{})
				var_stats['error_data'] = rt.call_method(var_original_result, 'get_error_data',
					[]rt.PhpVal{})
				var_stats['rollback'] = rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
					var_rollback_result.clone(),
				]))))
				if rt.is_true(rt.call_function('is_wp_error', [
					var_rollback_result.clone()]))
				{
					var_stats['rollback_code'] = rt.call_method(var_rollback_result,
						'get_error_code', []rt.PhpVal{})
					var_stats['rollback_data'] = rt.call_method(var_rollback_result,
						'get_error_data', []rt.PhpVal{})
				}
			} else {
				var_stats['error_code'] = rt.call_method(var_result, 'get_error_code',
					[]rt.PhpVal{})
				var_stats['error_data'] = rt.call_method(var_result, 'get_error_data',
					[]rt.PhpVal{})
			}
		}
		rt.call_function('wp_version_check', [rt.create_array_from_native_map(var_stats)])
	}
	mut iife_temp_5 := Class_WP_Upgrader{}
	mut iife_result_5 := iife_temp_5.release_lock(rt.new_string('core_updater'))
	return var_result.clone()
}

fn Class_Core_Upgrader.should_update_to_version(var_offered_ver rt.PhpVal) bool {
	mut var_wp_version := rt.new_null()
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/version.php', '3')
	mut var_current_branch := rt.call_function('implode', [rt.new_string('.'),
		rt.call_function('array_slice', [
			rt.call_function('preg_split', [rt.new_string('/[.-]/'),
				var_wp_version.clone()]),
			rt.new_int(0),
			rt.new_int(2),
		])])
	mut var_new_branch := rt.call_function('implode', [rt.new_string('.'),
		rt.call_function('array_slice', [
			rt.call_function('preg_split', [rt.new_string('/[.-]/'),
				var_offered_ver.clone()]),
			rt.new_int(0),
			rt.new_int(2),
		])])
	mut var_current_is_development_version := rt.new_bool((rt.call_function('strpos', [
		var_wp_version.clone(),
		rt.new_string('-'),
	])).to_bool())
	mut var_upgrade_dev := rt.identical(rt.call_function('get_site_option', [
		rt.new_string('auto_update_core_dev'),
		rt.new_string('enabled'),
	]), rt.new_string('enabled'))
	mut var_upgrade_minor := rt.identical(rt.call_function('get_site_option', [
		rt.new_string('auto_update_core_minor'),
		rt.new_string('enabled'),
	]), rt.new_string('enabled'))
	mut var_upgrade_major := rt.identical(rt.call_function('get_site_option', [
		rt.new_string('auto_update_core_major'),
		rt.new_string('unset'),
	]), rt.new_string('enabled'))
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_AUTO_UPDATE_CORE')])) {
		if rt.is_true(rt.identical(rt.new_bool(false), rt.get_constant('WP_AUTO_UPDATE_CORE'))) {
			var_upgrade_dev = rt.new_bool(false)
			var_upgrade_minor = rt.new_bool(false)
			var_upgrade_major = rt.new_bool(false)
		} else if
			rt.is_true(rt.identical(rt.new_bool(true), rt.get_constant('WP_AUTO_UPDATE_CORE')))
			|| rt.is_true(rt.call_function('in_array', [rt.get_constant('WP_AUTO_UPDATE_CORE'), rt.create_array([rt.ArrayItem{
			key: none
			val: 'beta'
		}, rt.ArrayItem{ key: none, val: 'rc' }, rt.ArrayItem{ key: none, val: 'development' }, rt.ArrayItem{
			key: none
			val: 'branch-development'
		}]), rt.new_bool(true)])) {
			var_upgrade_dev = rt.new_bool(true)
			var_upgrade_minor = rt.new_bool(true)
			var_upgrade_major = rt.new_bool(true)
		} else if rt.is_true(rt.identical(rt.new_string('minor'),
			rt.get_constant('WP_AUTO_UPDATE_CORE')))
		{
			var_upgrade_dev = rt.new_bool(false)
			var_upgrade_minor = rt.new_bool(true)
			var_upgrade_major = rt.new_bool(false)
		}
	}
	if rt.is_true(rt.identical(var_offered_ver, var_wp_version)) {
		return false
	}
	if rt.is_true(rt.call_function('version_compare', [var_wp_version.clone(),
		var_offered_ver.clone(), rt.new_string('>')]))
	{
		return false
	}
	mut var_failure_data := rt.call_function('get_site_option', [
		rt.new_string('auto_core_update_failed'),
	])
	if rt.is_true(var_failure_data) {
		if !(!rt.is_true(var_failure_data.array_get(rt.new_string('critical')))) {
			return false
		}
		if rt.is_true(rt.identical(var_wp_version, var_failure_data.array_get(rt.new_string('current'))))
			&& rt.is_true(rt.call_function('str_contains', [var_offered_ver.clone(), rt.new_string('.1.next.minor')])) {
			return false
		}
		if !rt.is_true(var_failure_data.array_get(rt.new_string('retry')))
			&& rt.is_true(rt.identical(var_wp_version, var_failure_data.array_get(rt.new_string('current'))))
			&& rt.is_true(rt.identical(var_offered_ver, var_failure_data.array_get(rt.new_string('attempted')))) {
			return false
		}
	}
	if rt.is_true(var_current_is_development_version) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('allow_dev_auto_core_updates'),
			var_upgrade_dev.clone(),
		])))))
		{
			return false
		}
	}
	if rt.is_true(rt.identical(var_current_branch, var_new_branch)) {
		return (rt.call_function('apply_filters', [
			rt.new_string('allow_minor_auto_core_updates'),
			var_upgrade_minor.clone(),
		])).to_bool()
	}
	if rt.is_true(rt.call_function('version_compare', [var_new_branch.clone(),
		var_current_branch.clone(), rt.new_string('>')]))
	{
		return (rt.call_function('apply_filters', [
			rt.new_string('allow_major_auto_core_updates'),
			var_upgrade_major.clone(),
		])).to_bool()
	}
	return false
}

fn (mut this Class_Core_Upgrader) check_files() bool {
	mut var_wp_version := rt.new_null()
	mut var_wp_local_package := rt.new_null()
	mut var_checksums := rt.call_function('get_core_checksums', [
		var_wp_version.clone(), if !var_wp_local_package.is_null() {
			var_wp_local_package
		} else {
			rt.new_string('en_US')
		}])
	if !(var_checksums.clone().is_array()) {
		return false
	}
	mut iter_1 := var_checksums.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_checksum := item_1.val
		mut var_file := item_1.key
		if rt.is_true(rt.call_function('str_starts_with', [var_file.clone(),
			rt.new_string('wp-content')]))
		{
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('ABSPATH')).str() + var_file.str())])))))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('md5_file', [rt.new_string((rt.get_constant('ABSPATH')).str() + var_file.str())]), var_checksum)))) {
			return false
		}
	}
	return true
}

struct Class_WP_Upgrader {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_core_upgrader(_args ...rt.PhpVal) &Class_Core_Upgrader {
	mut obj := &Class_Core_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_upgrader(_args ...rt.PhpVal) &Class_WP_Upgrader {
	mut obj := &Class_WP_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Core_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'upgrade_strings' {
			this.upgrade_strings()
			return rt.new_null()
		}
		'upgrade' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.upgrade(dispatch_arg_0, dispatch_arg_1)
		}
		'should_update_to_version' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Core_Upgrader.should_update_to_version(dispatch_arg_0))
		}
		'check_files' {
			return rt.new_bool(this.check_files())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Core_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Core_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
