import rt

struct Class_WP_Upgrader {
	rt.PhpObjectBase
pub mut:
		strings rt.PhpVal = rt.new_array()
		skin rt.PhpVal = rt.new_null()
		result rt.PhpVal = rt.new_array()
		update_count rt.PhpVal = rt.new_int(0)
		update_current rt.PhpVal = rt.new_int(0)
		temp_backups rt.PhpVal = rt.new_array()
		temp_restores rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Upgrader) construct(var_skin rt.PhpVal)  {
	if rt.is_true(rt.identical(rt.new_null(), var_skin)) {
		this.skin = create_wp_upgrader_skin()
	} else {
		this.skin = var_skin.dup()
	}
}

fn (mut this Class_WP_Upgrader) init()  {
	rt.call_method(this.skin, 'set_upgrader', [rt.new_object('WP_Upgrader', []string{}, &this)])
	this.generic_strings()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))))) {
		this.schedule_temp_backup_cleanup()
	}
}

fn (mut this Class_WP_Upgrader) schedule_temp_backup_cleanup()  {
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('wp_next_scheduled', [rt.new_string('wp_delete_temp_updater_backups')]))) {
		rt.call_function('wp_schedule_event', [rt.call_function('time', []rt.PhpVal{}), rt.new_string('weekly'), rt.new_string('wp_delete_temp_updater_backups')])
	}
}

fn (mut this Class_WP_Upgrader) generic_strings()  {
	this.strings.array_set('bad_request', rt.call_function('__', [rt.new_string('Invalid data provided.')]))
	this.strings.array_set('fs_unavailable', rt.call_function('__', [rt.new_string('Could not access filesystem.')]))
	this.strings.array_set('fs_error', rt.call_function('__', [rt.new_string('Filesystem error.')]))
	this.strings.array_set('fs_no_root_dir', rt.call_function('__', [rt.new_string('Unable to locate WordPress root directory.')]))
	this.strings.array_set('fs_no_content_dir', rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unable to locate WordPress content directory (%s).')]), rt.new_string('wp-content')]))
	this.strings.array_set('fs_no_plugins_dir', rt.call_function('__', [rt.new_string('Unable to locate WordPress plugin directory.')]))
	this.strings.array_set('fs_no_themes_dir', rt.call_function('__', [rt.new_string('Unable to locate WordPress theme directory.')]))
	this.strings.array_set('fs_no_folder', rt.call_function('__', [rt.new_string('Unable to locate needed folder (%s).')]))
	this.strings.array_set('no_package', rt.call_function('__', [rt.new_string('Package not available.')]))
	this.strings.array_set('download_failed', rt.call_function('__', [rt.new_string('Download failed.')]))
	this.strings.array_set('installing_package', rt.call_function('__', [rt.new_string('Installing the latest version&#8230;')]))
	this.strings.array_set('no_files', rt.call_function('__', [rt.new_string('The package contains no files.')]))
	this.strings.array_set('folder_exists', rt.call_function('__', [rt.new_string('Destination folder already exists.')]))
	this.strings.array_set('mkdir_failed', rt.call_function('__', [rt.new_string('Could not create directory.')]))
	this.strings.array_set('incompatible_archive', rt.call_function('__', [rt.new_string('The package could not be installed.')]))
	this.strings.array_set('files_not_writable', rt.call_function('__', [rt.new_string('The update cannot be installed because some files could not be copied. This is usually due to inconsistent file permissions.')]))
	this.strings.array_set('dir_not_readable', rt.call_function('__', [rt.new_string('A directory could not be read.')]))
	this.strings.array_set('maintenance_start', rt.call_function('__', [rt.new_string('Enabling Maintenance mode&#8230;')]))
	this.strings.array_set('maintenance_end', rt.call_function('__', [rt.new_string('Disabling Maintenance mode&#8230;')]))
	this.strings.array_set('temp_backup_mkdir_failed', rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Could not create the %s directory.')]), rt.new_string('upgrade-temp-backup')]))
	this.strings.array_set('temp_backup_move_failed', rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Could not move the old version to the %s directory.')]), rt.new_string('upgrade-temp-backup')]))
	this.strings.array_set('temp_backup_restore_failed', rt.call_function('__', [rt.new_string('Could not restore the original version of %s.')]))
	this.strings.array_set('temp_backup_delete_failed', rt.call_function('__', [rt.new_string('Could not delete the temporary backup directory for %s.')]))
}

fn (mut this Class_WP_Upgrader) fs_connect(var_directories rt.PhpVal, allow_relaxed_file_ownership bool) bool {
	mut var_wp_filesystem := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_credentials := rt.call_method(this.skin, 'request_filesystem_credentials', [rt.new_bool(false), var_directories.array_get(0), rt.new_bool(allow_relaxed_file_ownership)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_credentials)) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('WP_Filesystem', [var_credentials.dup(), var_directories.array_get(0), rt.new_bool(allow_relaxed_file_ownership)]))))) {
		mut var_error := rt.new_bool(rt.new_bool(true))
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_wp_filesystem.dup().is_object())) && rt.is_true(rt.call_method(rt.get_property(var_wp_filesystem, 'errors'), 'has_errors', []rt.PhpVal{})))) {
			var_error = rt.get_property(var_wp_filesystem, 'errors')
		}
		rt.call_method(this.skin, 'request_filesystem_credentials', [var_error.dup(), var_directories.array_get(0), rt.new_bool(allow_relaxed_file_ownership)])
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_wp_filesystem.dup().is_object()))))) {
		return (create_wp_error(rt.new_string('fs_unavailable'), this.strings.array_get('fs_unavailable'))).to_bool()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [rt.get_property(var_wp_filesystem, 'errors')])) && rt.is_true(rt.call_method(rt.get_property(var_wp_filesystem, 'errors'), 'has_errors', []rt.PhpVal{})))) {
		return (create_wp_error(rt.new_string('fs_error'), this.strings.array_get('fs_error'), rt.get_property(var_wp_filesystem, 'errors'))).to_bool()
	}
	{
		mut iter_1 := rt.cast_array(var_directories).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_dir := item_1.val
			mut switch_val_1 := var_dir
			if rt.is_true(rt.equal(switch_val_1, rt.get_constant('ABSPATH'))) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'abspath', []rt.PhpVal{}))))) {
					return (create_wp_error(rt.new_string('fs_no_root_dir'), this.strings.array_get('fs_no_root_dir'))).to_bool()
				}
			} else if rt.is_true(rt.equal(switch_val_1, rt.get_constant('WP_CONTENT_DIR'))) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'wp_content_dir', []rt.PhpVal{}))))) {
					return (create_wp_error(rt.new_string('fs_no_content_dir'), this.strings.array_get('fs_no_content_dir'))).to_bool()
				}
			} else if rt.is_true(rt.equal(switch_val_1, rt.get_constant('WP_PLUGIN_DIR'))) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'wp_plugins_dir', []rt.PhpVal{}))))) {
					return (create_wp_error(rt.new_string('fs_no_plugins_dir'), this.strings.array_get('fs_no_plugins_dir'))).to_bool()
				}
			} else if rt.is_true(rt.equal(switch_val_1, rt.call_function('get_theme_root', []rt.PhpVal{}))) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'wp_themes_dir', []rt.PhpVal{}))))) {
					return (create_wp_error(rt.new_string('fs_no_themes_dir'), this.strings.array_get('fs_no_themes_dir'))).to_bool()
				}
			} else {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'find_folder', [var_dir.dup()]))))) {
					return (create_wp_error(rt.new_string('fs_no_folder'), rt.call_function('sprintf', [this.strings.array_get('fs_no_folder'), rt.call_function('esc_html', [rt.call_function('basename', [var_dir.dup()])])]))).to_bool()
				}
			}
		}
	}
	return true
}

fn (mut this Class_WP_Upgrader) download_package(var_package rt.PhpVal, check_signatures bool, var_hook_extra rt.PhpVal) rt.PhpVal {
	mut var_reply := rt.call_function('apply_filters', [rt.new_string('upgrader_pre_download'), rt.new_bool(false), var_package.dup(), rt.new_object('WP_Upgrader', []string{}, &this), var_hook_extra.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_reply.dup()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('!^(http|https|ftp)://!i'), var_package.dup()]))))) && rt.is_true(rt.call_function('file_exists', [var_package.dup()])))) {
		return var_package.dup()
		// unsupported statement: Stmt_Nop
	}
	if !rt.is_true(var_package) {
		return create_wp_error(rt.new_string('no_package'), this.strings.array_get('no_package'))
	}
	rt.call_method(this.skin, 'feedback', [rt.new_string('downloading_package'), var_package.dup()])
	mut var_download_file := rt.call_function('download_url', [var_package.dup(), rt.new_int(300), rt.new_bool(check_signatures)])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_download_file.dup()])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_download_file, 'get_error_data', [rt.new_string('softfail-filename')]))))))) {
		return create_wp_error(rt.new_string('download_failed'), this.strings.array_get('download_failed'), rt.call_method(var_download_file, 'get_error_message', []rt.PhpVal{}))
	}
	return var_download_file.dup()
}

fn (mut this Class_WP_Upgrader) unpack_package(var_package rt.PhpVal, delete_package bool) rt.PhpVal {
	mut var_wp_filesystem := rt.new_null()
	mut delete_package_mutated := delete_package
	// unsupported statement: Stmt_Global
	rt.call_method(this.skin, 'feedback', [rt.new_string('unpack_package')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'wp_content_dir', []rt.PhpVal{}))))) {
		return create_wp_error(rt.new_string('fs_no_content_dir'), this.strings.array_get('fs_no_content_dir'))
	}
	mut var_upgrade_folder := rt.new_string((rt.call_method(var_wp_filesystem, 'wp_content_dir', []rt.PhpVal{})).str() + 'upgrade/')
	mut var_upgrade_files := rt.call_method(var_wp_filesystem, 'dirlist', [var_upgrade_folder.dup()])
	if !(!rt.is_true(var_upgrade_files)) {
		{
			mut iter_1 := var_upgrade_files.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_file := item_1.val
				rt.call_method(var_wp_filesystem, 'delete', [rt.concat(var_upgrade_folder, var_file.array_get('name')), rt.new_bool(true)])
			}
		}
	}
	mut var_working_dir := rt.new_string(rt.concat(var_upgrade_folder, rt.call_function('basename', [rt.call_function('basename', [var_package.dup(), rt.new_string('.tmp')]), rt.new_string('.zip')])))
	if rt.is_true(rt.call_method(var_wp_filesystem, 'is_dir', [var_working_dir.dup()])) {
		rt.call_method(var_wp_filesystem, 'delete', [var_working_dir.dup(), rt.new_bool(true)])
	}
	mut var_result := rt.call_function('unzip_file', [var_package.dup(), var_working_dir.dup()])
	if rt.is_true(rt.new_bool(delete_package_mutated)) {
		rt.call_function('unlink', [var_package.dup()])
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
		rt.call_method(var_wp_filesystem, 'delete', [var_working_dir.dup(), rt.new_bool(true)])
		if rt.is_true(rt.identical(rt.new_string('incompatible_archive'), rt.call_method(var_result, 'get_error_code', []rt.PhpVal{}))) {
			return create_wp_error(rt.new_string('incompatible_archive'), this.strings.array_get('incompatible_archive'), rt.call_method(var_result, 'get_error_data', []rt.PhpVal{}))
		}
		return var_result.dup()
	}
	return var_working_dir.dup()
}

fn (mut this Class_WP_Upgrader) flatten_dirlist(var_nested_files rt.PhpVal, path string) rt.PhpVal {
	mut var_files := rt.new_array()
	{
		mut iter_1 := var_nested_files.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_details := item_1.val
			mut var_name := item_1.key
			var_files.array_set(path + (var_name).str(), var_details.dup())
			if !(!rt.is_true(var_details.array_get('files'))) {
				mut var_children := this.flatten_dirlist(var_details.array_get('files'), path + (var_name).str() + '/')
				var_files = rt.add(var_files, var_children)
			}
		}
	}
	return var_files.dup()
}

fn (mut this Class_WP_Upgrader) clear_destination(var_remote_destination rt.PhpVal) bool {
	mut var_wp_filesystem := rt.new_null()
	mut var_remote_destination_mutated := var_remote_destination
	// unsupported statement: Stmt_Global
	mut var_files := rt.call_method(var_wp_filesystem, 'dirlist', [var_remote_destination_mutated.dup(), rt.new_bool(true), rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_files)) {
		return true
	}
	var_files = this.flatten_dirlist(var_files.dup(), '')
	mut var_unwritable_files := rt.new_array()
	{
		mut iter_1 := var_files.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_file_details := item_1.val
			mut var_filename := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'is_writable', [rt.concat(var_remote_destination_mutated, var_filename)]))))) {
				rt.call_method(var_wp_filesystem, 'chmod', [rt.concat(var_remote_destination_mutated, var_filename), if rt.is_true(rt.identical(rt.new_string('d'), .array_get())) { rt.get_constant('FS_CHMOD_DIR') } else { rt.get_constant('FS_CHMOD_FILE') }])
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'is_writable', [rt.concat(, )]))))) {
					var_unwritable_files << var_filename.dup()
				}
			}
		}
	}
	if !(!rt.is_true(var_unwritable_files)) {
		return (create_wp_error(rt.new_string('files_not_writable'), .array_get(), rt.call_function('implode', [, .dup()]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(, 'delete', [.dup(), ]))))) {
		return (create_wp_error(, )).to_bool()
	}
	return true
}

fn (mut this Class_WP_Upgrader) install_package(var_args rt.PhpVal) rt.PhpVal {
	mut var_wp_filesystem := rt.new_null()
	mut var_wp_theme_directories := rt.new_null()
	mut var_args_mutated := var_args
	// unsupported statement: Stmt_Global
}

fn (mut this Class_WP_Upgrader) run(var_options rt.PhpVal) bool {
	mut var_options_mutated := var_options
}

fn (mut this Class_WP_Upgrader) maintenance_mode(enable bool)  {
	mut var_wp_filesystem := rt.new_null()
}

fn Class_WP_Upgrader.create_lock(var_lock_name rt.PhpVal, var_release_timeout rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_release_timeout_mutated := var_release_timeout
}

fn Class_WP_Upgrader.release_lock(var_lock_name rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_Upgrader) move_to_temp_backup_dir(var_args rt.PhpVal) bool {
	mut var_wp_filesystem := rt.new_null()
	mut var_args_mutated := var_args
}

fn (mut this Class_WP_Upgrader) restore_temp_backup(mut var_temp_backups Class_array) rt.PhpVal {
	mut var_wp_filesystem := rt.new_null()
	mut var_temp_backups_mutated := var_temp_backups
}

fn (mut this Class_WP_Upgrader) delete_temp_backup(mut var_temp_backups Class_array) rt.PhpVal {
	mut var_wp_filesystem := rt.new_null()
	mut var_temp_backups_mutated := var_temp_backups
}

struct Class_WP_Upgrader_Skin {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_upgrader(arg_0 rt.PhpVal) &Class_WP_Upgrader {
	mut obj := &Class_WP_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
		strings: rt.new_array()
		skin: rt.new_null()
		result: rt.new_array()
		update_count: rt.new_int(0)
		update_current: rt.new_int(0)
		temp_backups: rt.new_array()
		temp_restores: rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_upgrader_skin() &Class_WP_Upgrader_Skin {
	mut obj := &Class_WP_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.restore_temp_backup(mut dispatch_arg_0)
		}
		'delete_temp_backup' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.delete_temp_backup(mut dispatch_arg_0)
		}
		else { return none }
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
		'strings' { this.strings = val; return true }
		'skin' { this.skin = val; return true }
		'result' { this.result = val; return true }
		'update_count' { this.update_count = val; return true }
		'update_current' { this.update_current = val; return true }
		'temp_backups' { this.temp_backups = val; return true }
		'temp_restores' { this.temp_restores = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_admin_includes_class_wp_upgrader_php() {
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-upgrader-skin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-plugin-upgrader-skin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-theme-upgrader-skin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-bulk-upgrader-skin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-bulk-plugin-upgrader-skin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-bulk-theme-upgrader-skin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-plugin-installer-skin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-theme-installer-skin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-language-pack-upgrader-skin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-automatic-upgrader-skin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-ajax-upgrader-skin.php', '4')
}
