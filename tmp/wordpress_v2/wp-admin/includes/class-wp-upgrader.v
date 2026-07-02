import rt

struct Class_WP_Upgrader {
	rt.PhpObjectBase
pub mut:
	strings        rt.PhpVal = rt.new_array()
	skin           rt.PhpVal = rt.new_null()
	result         rt.PhpVal = rt.new_array()
	update_count   rt.PhpVal = rt.new_int(0)
	update_current rt.PhpVal = rt.new_int(0)
	temp_backups   rt.PhpVal = rt.new_array()
	temp_restores  rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Upgrader) construct(var_skin rt.PhpVal) {
	if rt.is_true(rt.identical(rt.new_null(), var_skin)) {
		this.skin = create_wp_upgrader_skin()
	} else {
		this.skin = var_skin.clone()
	}
}

fn (mut this Class_WP_Upgrader) init() {
	rt.call_method(this.skin, 'set_upgrader', [
		rt.new_object('WP_Upgrader', []string{}, &this),
	])
	this.generic_strings()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))))) {
		this.schedule_temp_backup_cleanup()
	}
}

fn (mut this Class_WP_Upgrader) schedule_temp_backup_cleanup() {
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('wp_next_scheduled', [
		rt.new_string('wp_delete_temp_updater_backups'),
	])))
	{
		rt.call_function('wp_schedule_event', [rt.call_function('time', []rt.PhpVal{}),
			rt.new_string('weekly'), rt.new_string('wp_delete_temp_updater_backups')])
	}
}

fn (mut this Class_WP_Upgrader) generic_strings() {
	this.strings.array_set('bad_request', rt.call_function('__', [
		rt.new_string('Invalid data provided.'),
	]))
	this.strings.array_set('fs_unavailable', rt.call_function('__', [
		rt.new_string('Could not access filesystem.'),
	]))
	this.strings.array_set('fs_error', rt.call_function('__', [
		rt.new_string('Filesystem error.'),
	]))
	this.strings.array_set('fs_no_root_dir', rt.call_function('__', [
		rt.new_string('Unable to locate WordPress root directory.'),
	]))
	this.strings.array_set('fs_no_content_dir', rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('Unable to locate WordPress content directory (%s).'),
		]),
		rt.new_string('wp-content'),
	]))
	this.strings.array_set('fs_no_plugins_dir', rt.call_function('__', [
		rt.new_string('Unable to locate WordPress plugin directory.'),
	]))
	this.strings.array_set('fs_no_themes_dir', rt.call_function('__', [
		rt.new_string('Unable to locate WordPress theme directory.'),
	]))
	this.strings.array_set('fs_no_folder', rt.call_function('__', [
		rt.new_string('Unable to locate needed folder (%s).'),
	]))
	this.strings.array_set('no_package', rt.call_function('__', [
		rt.new_string('Package not available.'),
	]))
	this.strings.array_set('download_failed', rt.call_function('__', [
		rt.new_string('Download failed.'),
	]))
	this.strings.array_set('installing_package', rt.call_function('__', [
		rt.new_string('Installing the latest version&#8230;'),
	]))
	this.strings.array_set('no_files', rt.call_function('__', [
		rt.new_string('The package contains no files.'),
	]))
	this.strings.array_set('folder_exists', rt.call_function('__', [
		rt.new_string('Destination folder already exists.'),
	]))
	this.strings.array_set('mkdir_failed', rt.call_function('__', [
		rt.new_string('Could not create directory.'),
	]))
	this.strings.array_set('incompatible_archive', rt.call_function('__', [
		rt.new_string('The package could not be installed.'),
	]))
	this.strings.array_set('files_not_writable', rt.call_function('__', [
		rt.new_string('The update cannot be installed because some files could not be copied. This is usually due to inconsistent file permissions.'),
	]))
	this.strings.array_set('dir_not_readable', rt.call_function('__', [
		rt.new_string('A directory could not be read.'),
	]))
	this.strings.array_set('maintenance_start', rt.call_function('__', [
		rt.new_string('Enabling Maintenance mode&#8230;'),
	]))
	this.strings.array_set('maintenance_end', rt.call_function('__', [
		rt.new_string('Disabling Maintenance mode&#8230;'),
	]))
	this.strings.array_set('temp_backup_mkdir_failed', rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Could not create the %s directory.')]),
		rt.new_string('upgrade-temp-backup'),
	]))
	this.strings.array_set('temp_backup_move_failed', rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('Could not move the old version to the %s directory.'),
		]),
		rt.new_string('upgrade-temp-backup'),
	]))
	this.strings.array_set('temp_backup_restore_failed', rt.call_function('__', [
		rt.new_string('Could not restore the original version of %s.'),
	]))
	this.strings.array_set('temp_backup_delete_failed', rt.call_function('__', [
		rt.new_string('Could not delete the temporary backup directory for %s.'),
	]))
}

fn (mut this Class_WP_Upgrader) fs_connect(var_directories rt.PhpVal, allow_relaxed_file_ownership bool) bool {
	mut var_wp_filesystem := rt.new_null()
	mut var_credentials := rt.call_method(this.skin, 'request_filesystem_credentials', [
		rt.new_bool(false),
		var_directories.array_get(rt.new_int(0)),
		rt.new_bool(allow_relaxed_file_ownership),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_credentials)) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('WP_Filesystem', [
		var_credentials.clone(), var_directories.array_get(rt.new_int(0)),
		rt.new_bool(allow_relaxed_file_ownership)])))))
	{
		mut var_error := rt.new_bool(true)
		if var_wp_filesystem.clone().is_object()
			&& rt.is_true(rt.call_method(rt.get_property(var_wp_filesystem, 'errors'), 'has_errors', []rt.PhpVal{})) {
			var_error = rt.get_property(var_wp_filesystem, 'errors')
		}
		rt.call_method(this.skin, 'request_filesystem_credentials', [
			var_error.clone(), var_directories.array_get(rt.new_int(0)),
			rt.new_bool(allow_relaxed_file_ownership)])
		return false
	}
	if !(var_wp_filesystem.clone().is_object()) {
		return (create_wp_error(rt.new_string('fs_unavailable'),
			this.strings.array_get(rt.new_string('fs_unavailable')))).to_bool()
	}
	if rt.is_true(rt.call_function('is_wp_error', [rt.get_property(var_wp_filesystem, 'errors')]))
		&& rt.is_true(rt.call_method(rt.get_property(var_wp_filesystem, 'errors'), 'has_errors', []rt.PhpVal{})) {
		return (create_wp_error(rt.new_string('fs_error'),
			this.strings.array_get(rt.new_string('fs_error')), rt.get_property(var_wp_filesystem,
			'errors'))).to_bool()
	}
	mut iter_1 := rt.cast_array(var_directories).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_dir := item_1.val
		mut switch_val_1 := var_dir
		if rt.is_true(rt.equal(switch_val_1, rt.get_constant('ABSPATH'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'abspath',
				[]rt.PhpVal{})))))
			{
				return (create_wp_error(rt.new_string('fs_no_root_dir'),
					this.strings.array_get(rt.new_string('fs_no_root_dir')))).to_bool()
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.get_constant('WP_CONTENT_DIR'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem,
				'wp_content_dir', []rt.PhpVal{})))))
			{
				return (create_wp_error(rt.new_string('fs_no_content_dir'),
					this.strings.array_get(rt.new_string('fs_no_content_dir')))).to_bool()
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.get_constant('WP_PLUGIN_DIR'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem,
				'wp_plugins_dir', []rt.PhpVal{})))))
			{
				return (create_wp_error(rt.new_string('fs_no_plugins_dir'),
					this.strings.array_get(rt.new_string('fs_no_plugins_dir')))).to_bool()
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.call_function('get_theme_root',
			[]rt.PhpVal{})))
		{
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem,
				'wp_themes_dir', []rt.PhpVal{})))))
			{
				return (create_wp_error(rt.new_string('fs_no_themes_dir'),
					this.strings.array_get(rt.new_string('fs_no_themes_dir')))).to_bool()
			}
		} else {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'find_folder', [
				var_dir.clone(),
			])))))
			{
				return (create_wp_error(rt.new_string('fs_no_folder'), rt.call_function('sprintf', [
					this.strings.array_get(rt.new_string('fs_no_folder')),
					rt.call_function('esc_html', [
						rt.call_function('basename', [var_dir.clone()]),
					]),
				]))).to_bool()
			}
		}
	}
	return true
}

fn (mut this Class_WP_Upgrader) download_package(var_package rt.PhpVal, check_signatures bool, var_hook_extra rt.PhpVal) rt.PhpVal {
	mut var_reply := rt.call_function('apply_filters', [
		rt.new_string('upgrader_pre_download'),
		rt.new_bool(false),
		var_package.clone(),
		rt.new_object('WP_Upgrader', []string{}, &this),
		var_hook_extra.clone(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_reply)))) {
		return var_reply.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('!^(http|https|ftp)://!i'), var_package.clone()])))))
		&& rt.is_true(rt.call_function('file_exists', [var_package.clone()])) {
		return var_package.clone()
	}
	if !rt.is_true(var_package) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('no_package'),
			this.strings.array_get(rt.new_string('no_package'))))
	}
	rt.call_method(this.skin, 'feedback', [rt.new_string('downloading_package'),
		var_package.clone()])
	mut var_download_file := rt.call_function('download_url', [
		var_package.clone(), rt.new_int(300), rt.new_bool(check_signatures)])
	if rt.is_true(rt.call_function('is_wp_error', [var_download_file.clone()]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_download_file, 'get_error_data', [rt.new_string('softfail-filename')]))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('download_failed'),
			this.strings.array_get(rt.new_string('download_failed')), rt.call_method(var_download_file,
			'get_error_message', []rt.PhpVal{})))
	}
	return var_download_file.clone()
}

fn (mut this Class_WP_Upgrader) unpack_package(var_package rt.PhpVal, delete_package bool) rt.PhpVal {
	mut var_wp_filesystem := rt.new_null()
	mut delete_package_mutated := delete_package
	rt.call_method(this.skin, 'feedback', [rt.new_string('unpack_package')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'wp_content_dir',
		[]rt.PhpVal{})))))
	{
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('fs_no_content_dir'),
			this.strings.array_get(rt.new_string('fs_no_content_dir'))))
	}
	mut var_upgrade_folder := rt.new_string(
		(rt.call_method(var_wp_filesystem, 'wp_content_dir', []rt.PhpVal{})).str() + 'upgrade/')
	mut var_upgrade_files := rt.call_method(var_wp_filesystem, 'dirlist', [
		var_upgrade_folder.clone()])
	if !(!rt.is_true(var_upgrade_files)) {
		mut iter_2 := var_upgrade_files.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_file := item_2.val
			rt.call_method(var_wp_filesystem, 'delete', [
				rt.new_string(var_upgrade_folder.str() +
					(var_file.array_get(rt.new_string('name'))).str()),
				rt.new_bool(true),
			])
		}
	}
	mut var_working_dir :=
		rt.new_string(var_upgrade_folder.str() +(rt.call_function('basename', [rt.call_function('basename', [var_package.clone(), rt.new_string('.tmp')]), rt.new_string('.zip')])).str())
	if rt.is_true(rt.call_method(var_wp_filesystem, 'is_dir', [
		var_working_dir.clone()]))
	{
		rt.call_method(var_wp_filesystem, 'delete', [var_working_dir.clone(),
			rt.new_bool(true)])
	}
	mut var_result := rt.call_function('unzip_file', [var_package.clone(),
		var_working_dir.clone()])
	if rt.is_true(rt.new_bool(delete_package_mutated)) {
		rt.call_function('unlink', [var_package.clone()])
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		rt.call_method(var_wp_filesystem, 'delete', [var_working_dir.clone(),
			rt.new_bool(true)])
		if rt.is_true(rt.identical(rt.new_string('incompatible_archive'), rt.call_method(var_result,
			'get_error_code', []rt.PhpVal{})))
		{
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('incompatible_archive'),
				this.strings.array_get(rt.new_string('incompatible_archive')), rt.call_method(var_result,
				'get_error_data', []rt.PhpVal{})))
		}
		return var_result.clone()
	}
	return var_working_dir.clone()
}

fn (mut this Class_WP_Upgrader) flatten_dirlist(var_nested_files rt.PhpVal, path string) rt.PhpVal {
	mut var_files := rt.new_array()
	mut iter_3 := var_nested_files.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_details := item_3.val
		mut var_name := item_3.key
		var_files.array_set(path + var_name.str(), var_details.clone())
		if !(!rt.is_true(var_details.array_get(rt.new_string('files')))) {
			mut var_children := this.flatten_dirlist(var_details.array_get(rt.new_string('files')),

				path + var_name.str() + '/')
			var_files = rt.add(var_files, var_children)
		}
	}
	return var_files.clone()
}

fn (mut this Class_WP_Upgrader) clear_destination(var_remote_destination rt.PhpVal) bool {
	mut var_wp_filesystem := rt.new_null()
	mut var_remote_destination_mutated := var_remote_destination
	mut var_files := rt.call_method(var_wp_filesystem, 'dirlist', [
		var_remote_destination_mutated.clone(), rt.new_bool(true),
		rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_files)) {
		return true
	}
	var_files = this.flatten_dirlist(var_files.clone(), '')
	mut var_unwritable_files := rt.new_array()
	mut iter_4 := var_files.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_file_details := item_4.val
		mut var_filename := item_4.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'is_writable', [
			rt.new_string(var_remote_destination_mutated.str() + var_filename.str()),
		])))))
		{
			rt.call_method(var_wp_filesystem, 'chmod', [
				rt.new_string(var_remote_destination_mutated.str() + var_filename.str()),
				if rt.is_true(rt.identical(rt.new_string('d'),
					var_file_details.array_get(rt.new_string('type'))))
				{
					rt.get_constant('FS_CHMOD_DIR')
				} else {
					rt.get_constant('FS_CHMOD_FILE')
				},
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'is_writable', [
				rt.new_string(var_remote_destination_mutated.str() + var_filename.str()),
			])))))
			{
				var_unwritable_files << var_filename.clone()
			}
		}
	}
	if !(!rt.is_true(var_unwritable_files)) {
		return (create_wp_error(rt.new_string('files_not_writable'),
			this.strings.array_get(rt.new_string('files_not_writable')), rt.call_function('implode', [
			rt.new_string(', '),
			rt.create_array_from_list(var_unwritable_files),
		]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'delete', [
		var_remote_destination_mutated.clone(),
		rt.new_bool(true),
	])))))
	{
		return (create_wp_error(rt.new_string('remove_old_failed'),
			this.strings.array_get(rt.new_string('remove_old_failed')))).to_bool()
	}
	return true
}

fn (mut this Class_WP_Upgrader) install_package(var_args rt.PhpVal) rt.PhpVal {
	mut var_wp_filesystem := rt.new_null()
	mut var_wp_theme_directories := rt.new_null()
	mut var_args_mutated := var_args
	mut var_defaults := {
		'source':                      rt.new_string('')
		'destination':                 rt.new_string('')
		'clear_destination':           rt.new_bool(false)
		'clear_working':               rt.new_bool(false)
		'abort_if_destination_exists': rt.new_bool(true)
		'hook_extra':                  rt.new_array()
	}
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.clone(),
		rt.create_array_from_native_map(var_defaults)])
	mut var_source := var_args_mutated.array_get(rt.new_string('source'))
	mut var_destination := var_args_mutated.array_get(rt.new_string('destination'))
	mut var_clear_destination := var_args_mutated.array_get(rt.new_string('clear_destination'))
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('set_time_limit')])) {
		rt.call_function('set_time_limit', [rt.new_int(300)])
	}
	if !(var_source.clone().is_string()) || rt.is_true(rt.identical(rt.new_string(''), var_source))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(var_source.clone().to_string().trim_space()), var_source))))
		|| !(var_destination.clone().is_string())
		|| rt.is_true(rt.identical(rt.new_string(''), var_destination))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(var_destination.clone().to_string().trim_space()), var_destination)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('bad_request'),
			this.strings.array_get(rt.new_string('bad_request'))))
	}
	rt.call_method(this.skin, 'feedback', [rt.new_string('installing_package')])
	mut var_res := rt.call_function('apply_filters', [
		rt.new_string('upgrader_pre_install'),
		rt.new_bool(true),
		var_args_mutated.array_get(rt.new_string('hook_extra')),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_res.clone()])) {
		return var_res.clone()
	}
	mut var_remote_source := var_args_mutated.array_get(rt.new_string('source'))
	mut var_local_destination := var_destination.clone()
	mut var_dirlist := rt.call_method(var_wp_filesystem, 'dirlist', [
		var_remote_source.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_dirlist)) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('source_read_failed'),
			this.strings.array_get(rt.new_string('fs_error')),
			this.strings.array_get(rt.new_string('dir_not_readable'))))
	}
	mut var_source_files := rt.func_array_keys(var_dirlist.clone())
	mut var_remote_destination := rt.call_method(var_wp_filesystem, 'find_folder', [
		var_local_destination.clone(),
	])
	if 1 == var_source_files.clone().array_count()
		&& rt.is_true(rt.call_method(var_wp_filesystem, 'is_dir', [rt.new_string((rt.call_function('trailingslashit', [var_args_mutated.array_get(rt.new_string('source'))])).str() + (var_source_files.array_get(rt.new_int(0))).str() + '/')])) {
		var_source = rt.new_string(
			(rt.call_function('trailingslashit', [var_args_mutated.array_get(rt.new_string('source'))])).str() +
			(rt.call_function('trailingslashit', [var_source_files.array_get(rt.new_int(0))])).str())
	} else if 0 == var_source_files.clone().array_count() {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('incompatible_archive_empty'),
			this.strings.array_get(rt.new_string('incompatible_archive')),
			this.strings.array_get(rt.new_string('no_files'))))
	} else {
		var_source = rt.call_function('trailingslashit', [
			var_args_mutated.array_get(rt.new_string('source')),
		])
	}
	var_source = rt.call_function('apply_filters', [
		rt.new_string('upgrader_source_selection'),
		var_source.clone(),
		var_remote_source.clone(),
		rt.new_object('WP_Upgrader', []string{}, &this),
		var_args_mutated.array_get(rt.new_string('hook_extra')),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_source.clone()])) {
		return var_source.clone()
	}
	if !(!rt.is_true(var_args_mutated.array_get(rt.new_string('hook_extra')).array_get(rt.new_string('temp_backup')))) {
		mut var_temp_backup :=
			rt.new_bool(this.move_to_temp_backup_dir(var_args_mutated.array_get(rt.new_string('hook_extra')).array_get(rt.new_string('temp_backup'))))
		if rt.is_true(rt.call_function('is_wp_error', [var_temp_backup.clone()])) {
			return var_temp_backup.clone()
		}
		this.temp_backups.array_push(var_args_mutated.array_get(rt.new_string('hook_extra')).array_get(rt.new_string('temp_backup')))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_source, var_remote_source)))) {
		var_dirlist = rt.call_method(var_wp_filesystem, 'dirlist', [
			var_source.clone()])
		if rt.is_true(rt.identical(rt.new_bool(false), var_dirlist)) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('new_source_read_failed'),
				this.strings.array_get(rt.new_string('fs_error')),
				this.strings.array_get(rt.new_string('dir_not_readable'))))
		}
		var_source_files = rt.func_array_keys(var_dirlist.clone())
	}
	mut var_protected_directories := rt.create_array([
		rt.ArrayItem{ key: none, val: rt.get_constant('ABSPATH') },
		rt.ArrayItem{ key: none, val: rt.get_constant('WP_CONTENT_DIR') },
		rt.ArrayItem{ key: none, val: rt.get_constant('WP_PLUGIN_DIR') },
		rt.ArrayItem{ key: none, val: (rt.get_constant('WP_CONTENT_DIR')).str() + '/themes' },
	])
	if rt.is_true(rt.new_bool(var_wp_theme_directories.clone().is_array())) {
		var_protected_directories = rt.call_function('array_merge', [
			var_protected_directories.clone(), var_wp_theme_directories.clone()])
	}
	if rt.is_true(rt.call_function('in_array', [var_destination.clone(),
		var_protected_directories.clone(), rt.new_bool(true)]))
	{
		var_remote_destination = rt.new_string(
			(rt.call_function('trailingslashit', [var_remote_destination.clone()])).str() +(rt.call_function('trailingslashit', [rt.call_function('basename', [var_source.clone()])])).str())
		var_destination = rt.new_string(
			(rt.call_function('trailingslashit', [var_destination.clone()])).str() +(rt.call_function('trailingslashit', [rt.call_function('basename', [var_source.clone()])])).str())
	}
	if rt.is_true(var_clear_destination) {
		rt.call_method(this.skin, 'feedback', [rt.new_string('remove_old')])
		mut var_removed := rt.new_bool(this.clear_destination(var_remote_destination.clone()))
		var_removed = rt.call_function('apply_filters', [
			rt.new_string('upgrader_clear_destination'),
			var_removed.clone(),
			var_local_destination.clone(),
			var_remote_destination.clone(),
			var_args_mutated.array_get(rt.new_string('hook_extra')),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_removed.clone()])) {
			return var_removed.clone()
		}
	} else if rt.is_true(var_args_mutated.array_get(rt.new_string('abort_if_destination_exists')))
		&& rt.is_true(rt.call_method(var_wp_filesystem, 'exists', [var_remote_destination.clone()])) {
		mut var__files := rt.call_method(var_wp_filesystem, 'dirlist', [
			var_remote_destination.clone()])
		if !(!rt.is_true(var__files)) {
			rt.call_method(var_wp_filesystem, 'delete', [var_remote_source.clone(),
				rt.new_bool(true)])
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('folder_exists'),
				this.strings.array_get(rt.new_string('folder_exists')),
				var_remote_destination.clone()))
		}
	}
	if rt.is_true(var_args_mutated.array_get(rt.new_string('clear_working')))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'exists', [var_remote_destination.clone()])))))
		|| !rt.is_true(rt.call_method(var_wp_filesystem, 'dirlist', [var_remote_destination.clone()])) {
		mut var_result := rt.call_function('move_dir', [var_source.clone(),
			var_remote_destination.clone(), rt.new_bool(true)])
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'exists', [
			var_remote_destination.clone(),
		])))))
		{
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'mkdir', [
				var_remote_destination.clone(),
				rt.get_constant('FS_CHMOD_DIR'),
			])))))
			{
				return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('mkdir_failed_destination'),
					this.strings.array_get(rt.new_string('mkdir_failed')),
					var_remote_destination.clone()))
			}
		}
		var_result = rt.call_function('copy_dir', [var_source.clone(),
			var_remote_destination.clone()])
	}
	if rt.is_true(var_args_mutated.array_get(rt.new_string('clear_working'))) {
		rt.call_method(var_wp_filesystem, 'delete', [var_remote_source.clone(),
			rt.new_bool(true)])
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		return var_result.clone()
	}
	mut var_destination_name := rt.call_function('basename', [
		rt.call_function('str_replace', [var_local_destination.clone(),
			rt.new_string(''), var_destination.clone()]),
	])
	if rt.is_true(rt.identical(rt.new_string('.'), var_destination_name)) {
		var_destination_name = rt.new_string('')
	}
	this.result = rt.call_function('compact', [rt.new_string('source'),
		rt.new_string('source_files'), rt.new_string('destination'),
		rt.new_string('destination_name'), rt.new_string('local_destination'),
		rt.new_string('remote_destination'), rt.new_string('clear_destination')])
	var_res = rt.call_function('apply_filters', [rt.new_string('upgrader_post_install'),
		rt.new_bool(true), var_args_mutated.array_get(rt.new_string('hook_extra')), this.result])
	if rt.is_true(rt.call_function('is_wp_error', [var_res.clone()])) {
		this.result = var_res.clone()
		return var_res.clone()
	}
	return this.result
}

fn (mut this Class_WP_Upgrader) run(var_options rt.PhpVal) bool {
	mut var_options_mutated := var_options
	mut var_defaults := {
		'package':                     rt.new_string('')
		'destination':                 rt.new_string('')
		'clear_destination':           rt.new_bool(false)
		'clear_working':               rt.new_bool(true)
		'abort_if_destination_exists': rt.new_bool(true)
		'is_multi':                    rt.new_bool(false)
		'hook_extra':                  rt.new_array()
	}
	var_options_mutated = rt.call_function('wp_parse_args', [
		var_options_mutated.clone(), rt.create_array_from_native_map(var_defaults)])
	var_options_mutated = rt.call_function('apply_filters', [
		rt.new_string('upgrader_package_options'),
		var_options_mutated.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_options_mutated.array_get(rt.new_string('is_multi')))))) {
		rt.call_method(this.skin, 'header', []rt.PhpVal{})
	}
	mut var_res := rt.new_bool(this.fs_connect(rt.create_array([
		rt.ArrayItem{ key: none, val: rt.get_constant('WP_CONTENT_DIR') },
		rt.ArrayItem{ key: none, val: var_options_mutated.array_get(rt.new_string('destination')) },
	]), false))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_res)))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_options_mutated.array_get(rt.new_string('is_multi')))))) {
			rt.call_method(this.skin, 'footer', []rt.PhpVal{})
		}
		return false
	}
	rt.call_method(this.skin, 'before', []rt.PhpVal{})
	if rt.is_true(rt.call_function('is_wp_error', [var_res.clone()])) {
		rt.call_method(this.skin, 'error', [var_res.clone()])
		rt.call_method(this.skin, 'after', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(var_options_mutated.array_get(rt.new_string('is_multi')))))) {
			rt.call_method(this.skin, 'footer', []rt.PhpVal{})
		}
		return var_res.to_bool()
	}
	mut var_download := this.download_package(var_options_mutated.array_get(rt.new_string('package')),
		false, var_options_mutated.array_get(rt.new_string('hook_extra')))
	if rt.is_true(rt.call_function('is_wp_error', [var_download.clone()]))
		&& rt.is_true(rt.call_method(var_download, 'get_error_data', [rt.new_string('softfail-filename')])) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('signature_verification_no_signature'), rt.call_method(var_download, 'get_error_code', []rt.PhpVal{})))))
			|| rt.is_true(rt.get_constant('WP_DEBUG')) {
			rt.call_method(this.skin, 'feedback', [
				rt.call_method(var_download, 'get_error_message', []rt.PhpVal{}),
			])
			rt.call_function('wp_version_check', [
				rt.create_array([
					rt.ArrayItem{ key: 'signature_failure_code', val: rt.call_method(var_download,
						'get_error_code', []rt.PhpVal{}) },
					rt.ArrayItem{ key: 'signature_failure_data', val: rt.call_method(var_download,
						'get_error_data', []rt.PhpVal{}) },
				]),
			])
		}
		var_download = rt.call_method(var_download, 'get_error_data', [
			rt.new_string('softfail-filename'),
		])
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_download.clone()])) {
		rt.call_method(this.skin, 'error', [var_download.clone()])
		rt.call_method(this.skin, 'after', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(var_options_mutated.array_get(rt.new_string('is_multi')))))) {
			rt.call_method(this.skin, 'footer', []rt.PhpVal{})
		}
		return var_download.to_bool()
	}
	mut var_delete_package := rt.new_bool(!rt.is_true(rt.identical(var_download,
		var_options_mutated.array_get(rt.new_string('package')))))
	mut var_working_dir := this.unpack_package(var_download.clone(), var_delete_package.to_bool())
	if rt.is_true(rt.call_function('is_wp_error', [var_working_dir.clone()])) {
		rt.call_method(this.skin, 'error', [var_working_dir.clone()])
		rt.call_method(this.skin, 'after', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(var_options_mutated.array_get(rt.new_string('is_multi')))))) {
			rt.call_method(this.skin, 'footer', []rt.PhpVal{})
		}
		return var_working_dir.to_bool()
	}
	mut var_result := this.install_package(rt.create_array([
		rt.ArrayItem{ key: 'source', val: var_working_dir },
		rt.ArrayItem{
			key: 'destination'
			val: var_options_mutated.array_get(rt.new_string('destination'))
		},
		rt.ArrayItem{
			key: 'clear_destination'
			val: var_options_mutated.array_get(rt.new_string('clear_destination'))
		},
		rt.ArrayItem{
			key: 'abort_if_destination_exists'
			val: var_options_mutated.array_get(rt.new_string('abort_if_destination_exists'))
		},
		rt.ArrayItem{
			key: 'clear_working'
			val: var_options_mutated.array_get(rt.new_string('clear_working'))
		},
		rt.ArrayItem{
			key: 'hook_extra'
			val: var_options_mutated.array_get(rt.new_string('hook_extra'))
		},
	]))
	var_result = rt.call_function('apply_filters', [
		rt.new_string('upgrader_install_package_result'),
		var_result.clone(),
		var_options_mutated.array_get(rt.new_string('hook_extra')),
	])
	rt.call_method(this.skin, 'set_result', [var_result.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		if !(!rt.is_true(var_options_mutated.array_get(rt.new_string('hook_extra')).array_get(rt.new_string('temp_backup')))) {
			this.temp_restores.array_push(var_options_mutated.array_get(rt.new_string('hook_extra')).array_get(rt.new_string('temp_backup')))
			rt.call_function('add_action', [rt.new_string('shutdown'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_Upgrader', []string{}, &this) },
					rt.ArrayItem{ key: none, val: 'restore_temp_backup' },
				]),
				rt.new_int(10), rt.new_int(0)])
		}
		rt.call_method(this.skin, 'error', [var_result.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('method_exists', [this.skin, rt.new_string('hide_process_failed')])))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.skin, 'hide_process_failed', [var_result.clone()]))))) {
			rt.call_method(this.skin, 'feedback', [rt.new_string('process_failed')])
		}
	} else {
		rt.call_method(this.skin, 'feedback', [rt.new_string('process_success')])
	}
	rt.call_method(this.skin, 'after', []rt.PhpVal{})
	if !(!rt.is_true(var_options_mutated.array_get(rt.new_string('hook_extra')).array_get(rt.new_string('temp_backup')))) {
		rt.call_function('add_action', [rt.new_string('shutdown'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_Upgrader', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'delete_temp_backup' },
			]),
			rt.new_int(100), rt.new_int(0)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_options_mutated.array_get(rt.new_string('is_multi')))))) {
		rt.call_function('do_action', [rt.new_string('upgrader_process_complete'),
			rt.new_object('WP_Upgrader', []string{}, &this), var_options_mutated.array_get(rt.new_string('hook_extra'))])
		rt.call_method(this.skin, 'footer', []rt.PhpVal{})
	}
	return var_result.to_bool()
}

fn (mut this Class_WP_Upgrader) maintenance_mode(enable bool) {
	mut var_wp_filesystem := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wp_filesystem)))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
			rt.new_string('WP_Filesystem'),
		])))))
		{
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
		}
		rt.call_function('ob_start', []rt.PhpVal{})
		mut var_credentials := rt.call_function('request_filesystem_credentials', [
			rt.new_string(''),
		])
		rt.call_function('ob_end_clean', []rt.PhpVal{})
		if rt.is_true(rt.identical(rt.new_bool(false), var_credentials))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('WP_Filesystem', [var_credentials.clone()]))))) {
			rt.call_function('wp_trigger_error', [rt.new_string(@FN),
				rt.call_function('__', [rt.new_string('Could not access filesystem.')])])
			return
		}
	}
	mut var_file := rt.new_string(
		(rt.call_method(var_wp_filesystem, 'abspath', []rt.PhpVal{})).str() + '.maintenance')
	if var_enable {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_doing_cron', []rt.PhpVal{}))))) {
			rt.call_method(this.skin, 'feedback', [rt.new_string('maintenance_start')])
		}
		mut var_maintenance_string := rt.new_string('<?php $upgrading = ' +
			(rt.call_function('time', []rt.PhpVal{})).str() + '; ?>')
		rt.call_method(var_wp_filesystem, 'delete', [var_file.clone()])
		rt.call_method(var_wp_filesystem, 'put_contents', [var_file.clone(),
			var_maintenance_string.clone(), rt.get_constant('FS_CHMOD_FILE')])
	} else if rt.is_true(rt.call_method(var_wp_filesystem, 'exists', [
		var_file.clone()]))
	{
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_doing_cron', []rt.PhpVal{}))))) {
			rt.call_method(this.skin, 'feedback', [rt.new_string('maintenance_end')])
		}
		rt.call_method(var_wp_filesystem, 'delete', [var_file.clone()])
	}
}

fn Class_WP_Upgrader.create_lock(var_lock_name rt.PhpVal, var_release_timeout rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_release_timeout_mutated := var_release_timeout
	if rt.is_true(rt.new_bool(!(rt.is_true(var_release_timeout_mutated)))) {
		var_release_timeout_mutated = rt.get_constant('HOUR_IN_SECONDS')
	}
	mut var_lock_option := rt.new_string(var_lock_name.str() + '.lock')
	mut var_lock_result := rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('INSERT IGNORE INTO `'), rt.get_property(var_wpdb,
				'options')),
				rt.new_string("` ( `option_name`, `option_value`, `autoload` ) VALUES (%s, %s, 'off') /* LOCK */")),
			var_lock_option.clone(),
			rt.call_function('time', []rt.PhpVal{}),
		]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_lock_result)))) {
		var_lock_result = rt.call_function('get_option', [var_lock_option.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_lock_result)))) {
			return false
		}
		if rt.is_true(rt.greater(var_lock_result, rt.sub(rt.call_function('time', []rt.PhpVal{}),
			var_release_timeout_mutated)))
		{
			return false
		}
		Class_WP_Upgrader.release_lock(var_lock_name.clone())
		return (Class_WP_Upgrader.create_lock(var_lock_name.clone(),
			var_release_timeout_mutated.clone())).to_bool()
	}
	rt.call_function('update_option', [var_lock_option.clone(),
		rt.call_function('time', []rt.PhpVal{}), rt.new_bool(false)])
	return true
}

fn Class_WP_Upgrader.release_lock(var_lock_name rt.PhpVal) rt.PhpVal {
	return rt.call_function('delete_option', [
		rt.new_string(var_lock_name.str() + '.lock'),
	])
}

fn (mut this Class_WP_Upgrader) move_to_temp_backup_dir(var_args rt.PhpVal) bool {
	mut var_wp_filesystem := rt.new_null()
	mut var_args_mutated := var_args
	if !rt.is_true(var_args_mutated.array_get(rt.new_string('slug')))
		|| !rt.is_true(var_args_mutated.array_get(rt.new_string('src')))
		|| !rt.is_true(var_args_mutated.array_get(rt.new_string('dir'))) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('.'),
		var_args_mutated.array_get(rt.new_string('slug'))))
	{
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'wp_content_dir',
		[]rt.PhpVal{})))))
	{
		return (create_wp_error(rt.new_string('fs_no_content_dir'),
			this.strings.array_get(rt.new_string('fs_no_content_dir')))).to_bool()
	}
	mut var_dest_dir := rt.new_string(
		(rt.call_method(var_wp_filesystem, 'wp_content_dir', []rt.PhpVal{})).str() +
		'upgrade-temp-backup/')
	mut var_sub_dir := rt.new_string(var_dest_dir.str() +
		(var_args_mutated.array_get(rt.new_string('dir'))).str() + '/')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'is_dir', [
		var_sub_dir.clone(),
	])))))
	{
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'is_dir', [
			var_dest_dir.clone(),
		])))))
		{
			rt.call_method(var_wp_filesystem, 'mkdir', [var_dest_dir.clone(),
				rt.get_constant('FS_CHMOD_DIR')])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'mkdir', [
			var_sub_dir.clone(),
			rt.get_constant('FS_CHMOD_DIR'),
		])))))
		{
			return (create_wp_error(rt.new_string('fs_temp_backup_mkdir'),
				this.strings.array_get(rt.new_string('temp_backup_mkdir_failed')))).to_bool()
		}
	}
	mut var_src_dir := rt.call_method(var_wp_filesystem, 'find_folder', [
		var_args_mutated.array_get(rt.new_string('src')),
	])
	mut var_src := rt.new_string(
		(rt.call_function('trailingslashit', [var_src_dir.clone()])).str() +
		(var_args_mutated.array_get(rt.new_string('slug'))).str())
	mut var_dest := rt.new_string(var_dest_dir.str() +
		(rt.call_function('trailingslashit', [var_args_mutated.array_get(rt.new_string('dir'))])).str() +
		(var_args_mutated.array_get(rt.new_string('slug'))).str())
	if rt.is_true(rt.call_method(var_wp_filesystem, 'is_dir', [
		var_dest.clone()]))
	{
		rt.call_method(var_wp_filesystem, 'delete', [var_dest.clone(),
			rt.new_bool(true)])
	}
	mut var_result := rt.call_function('move_dir', [var_src.clone(),
		var_dest.clone(), rt.new_bool(true)])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		return (create_wp_error(rt.new_string('fs_temp_backup_move'),
			this.strings.array_get(rt.new_string('temp_backup_move_failed')))).to_bool()
	}
	return true
}

fn (mut this Class_WP_Upgrader) restore_temp_backup(mut var_temp_backups Class_array) rt.PhpVal {
	mut var_wp_filesystem := rt.new_null()
	mut var_temp_backups_mutated := var_temp_backups
	mut var_errors := create_wp_error()
	if !rt.is_true(var_temp_backups_mutated) {
		var_temp_backups_mutated = this.temp_restores
	}
	mut iter_5 := var_temp_backups_mutated.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_args := item_5.val
		if !rt.is_true(var_args.array_get(rt.new_string('slug')))
			|| !rt.is_true(var_args.array_get(rt.new_string('src')))
			|| !rt.is_true(var_args.array_get(rt.new_string('dir'))) {
			return rt.new_bool(false)
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'wp_content_dir',
			[]rt.PhpVal{})))))
		{
			var_errors.add(rt.new_string('fs_no_content_dir'),
				this.strings.array_get(rt.new_string('fs_no_content_dir')))
			return rt.new_object('WP_Error', []string{}, var_errors)
		}
		mut var_src := rt.new_string(
			(rt.call_method(var_wp_filesystem, 'wp_content_dir', []rt.PhpVal{})).str() +
			'upgrade-temp-backup/' +(var_args.array_get(rt.new_string('dir'))).str() + '/' +
			(var_args.array_get(rt.new_string('slug'))).str())
		mut var_dest_dir := rt.call_method(var_wp_filesystem, 'find_folder', [
			var_args.array_get(rt.new_string('src')),
		])
		mut var_dest := rt.new_string(
			(rt.call_function('trailingslashit', [var_dest_dir.clone()])).str() +
			(var_args.array_get(rt.new_string('slug'))).str())
		if rt.is_true(rt.call_method(var_wp_filesystem, 'is_dir', [
			var_src.clone()]))
		{
			if rt.is_true(rt.call_method(var_wp_filesystem, 'is_dir', [var_dest.clone()]))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'delete', [var_dest.clone(), rt.new_bool(true)]))))) {
				var_errors.add(rt.new_string('fs_temp_backup_delete'), rt.call_function('sprintf', [
					this.strings.array_get(rt.new_string('temp_backup_restore_failed')),
					var_args.array_get(rt.new_string('slug')),
				]))
				continue
			}
			mut var_result := rt.call_function('move_dir', [var_src.clone(),
				var_dest.clone(), rt.new_bool(true)])
			if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
				var_errors.add(rt.new_string('fs_temp_backup_delete'), rt.call_function('sprintf', [
					this.strings.array_get(rt.new_string('temp_backup_restore_failed')),
					var_args.array_get(rt.new_string('slug')),
				]))
				continue
			}
		}
	}
	return if rt.is_true(var_errors.has_errors()) { var_errors } else { rt.new_bool(true) }
}

fn (mut this Class_WP_Upgrader) delete_temp_backup(mut var_temp_backups Class_array) rt.PhpVal {
	mut var_wp_filesystem := rt.new_null()
	mut var_temp_backups_mutated := var_temp_backups
	mut var_errors := create_wp_error()
	if !rt.is_true(var_temp_backups_mutated) {
		var_temp_backups_mutated = this.temp_backups
	}
	mut iter_6 := var_temp_backups_mutated.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_args := item_6.val
		if !rt.is_true(var_args.array_get(rt.new_string('slug')))
			|| !rt.is_true(var_args.array_get(rt.new_string('dir'))) {
			return rt.new_bool(false)
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'wp_content_dir',
			[]rt.PhpVal{})))))
		{
			var_errors.add(rt.new_string('fs_no_content_dir'),
				this.strings.array_get(rt.new_string('fs_no_content_dir')))
			return rt.new_object('WP_Error', []string{}, var_errors)
		}
		mut var_temp_backup_dir := rt.new_string(
			(rt.call_method(var_wp_filesystem, 'wp_content_dir', []rt.PhpVal{})).str() +
			rt.concat(rt.concat(rt.concat(rt.new_string('upgrade-temp-backup/'), var_args.array_get(rt.new_string('dir'))), rt.new_string('/')), var_args.array_get(rt.new_string('slug'))))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'delete', [
			var_temp_backup_dir.clone(),
			rt.new_bool(true),
		])))))
		{
			var_errors.add(rt.new_string('temp_backup_delete_failed'), rt.call_function('sprintf', [
				this.strings.array_get(rt.new_string('temp_backup_delete_failed')),
				var_args.array_get(rt.new_string('slug')),
			]))
			continue
		}
	}
	return if rt.is_true(var_errors.has_errors()) { var_errors } else { rt.new_bool(true) }
}

struct Class_WP_Upgrader_Skin {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_upgrader(arg_0 rt.PhpVal) &Class_WP_Upgrader {
	mut obj := &Class_WP_Upgrader{
		PhpObjectBase:  rt.PhpObjectBase{}
		strings:        rt.new_array()
		skin:           rt.new_null()
		result:         rt.new_array()
		update_count:   rt.new_int(0)
		update_current: rt.new_int(0)
		temp_backups:   rt.new_array()
		temp_restores:  rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_upgrader_skin(_args ...rt.PhpVal) &Class_WP_Upgrader_Skin {
	mut obj := &Class_WP_Upgrader_Skin{
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

fn (mut this Class_WP_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'schedule_temp_backup_cleanup' {
			this.schedule_temp_backup_cleanup()
			return rt.new_null()
		}
		'generic_strings' {
			this.generic_strings()
			return rt.new_null()
		}
		'fs_connect' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.fs_connect(dispatch_arg_0, dispatch_arg_1))
		}
		'download_package' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.download_package(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'unpack_package' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.unpack_package(dispatch_arg_0, dispatch_arg_1)
		}
		'flatten_dirlist' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.flatten_dirlist(dispatch_arg_0, dispatch_arg_1)
		}
		'clear_destination' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.clear_destination(dispatch_arg_0))
		}
		'install_package' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.install_package(dispatch_arg_0)
		}
		'run' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.run(dispatch_arg_0))
		}
		'maintenance_mode' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.maintenance_mode(dispatch_arg_0)
			return rt.new_null()
		}
		'create_lock' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Upgrader.create_lock(dispatch_arg_0, dispatch_arg_1))
		}
		'release_lock' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Upgrader.release_lock(dispatch_arg_0)
		}
		'move_to_temp_backup_dir' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.move_to_temp_backup_dir(dispatch_arg_0))
		}
		'restore_temp_backup' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.restore_temp_backup(mut dispatch_arg_0)
		}
		'delete_temp_backup' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.delete_temp_backup(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'strings' { return this.strings }
		'skin' { return this.skin }
		'result' { return this.result }
		'update_count' { return this.update_count }
		'update_current' { return this.update_current }
		'temp_backups' { return this.temp_backups }
		'temp_restores' { return this.temp_restores }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'strings' {
			this.strings = val
			return true
		}
		'skin' {
			this.skin = val
			return true
		}
		'result' {
			this.result = val
			return true
		}
		'update_count' {
			this.update_count = val
			return true
		}
		'update_current' {
			this.update_current = val
			return true
		}
		'temp_backups' {
			this.temp_backups = val
			return true
		}
		'temp_restores' {
			this.temp_restores = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-upgrader-skin.php', '4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-plugin-upgrader-skin.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-theme-upgrader-skin.php', '4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-bulk-upgrader-skin.php', '4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-bulk-plugin-upgrader-skin.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-bulk-theme-upgrader-skin.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-plugin-installer-skin.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-theme-installer-skin.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-language-pack-upgrader-skin.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-automatic-upgrader-skin.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-ajax-upgrader-skin.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-plugin-upgrader.php', '4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-theme-upgrader.php', '4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-language-pack-upgrader.php',
		'4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-core-upgrader.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-file-upload-upgrader.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-automatic-updater.php',
		'4')
}
