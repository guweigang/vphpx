import rt

struct Class_WP_Filesystem_Direct {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Filesystem_Direct) construct(var_arg rt.PhpVal)  {
	this.dispatch_set_prop('method', rt.new_string('direct'))
	this.dispatch_set_prop('errors', create_wp_error())
}

fn (mut this Class_WP_Filesystem_Direct) get_contents(var_file rt.PhpVal) rt.PhpVal {
	mut var_file_mutated := var_file
	return rt.call_function('file_get_contents', [var_file_mutated.dup()])
}

fn (mut this Class_WP_Filesystem_Direct) get_contents_array(var_file rt.PhpVal) rt.PhpVal {
	mut var_file_mutated := var_file
	return rt.call_function('file', [var_file_mutated.dup()])
}

fn (mut this Class_WP_Filesystem_Direct) put_contents(var_file rt.PhpVal, var_contents rt.PhpVal, mode bool) bool {
	mut var_file_mutated := var_file
	mut mode_mutated := mode
	mut var_fp := rt.call_function('fopen', [var_file_mutated.dup(), rt.new_string('wb')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_fp)))) {
		return false
	}
	rt.call_function('mbstring_binary_safe_encoding', []rt.PhpVal{})
	mut var_data_length := rt.new_int(rt.new_int(var_contents.dup().to_string().len))
	mut var_bytes_written := rt.call_function('fwrite', [var_fp.dup(), var_contents.dup()])
	rt.call_function('reset_mbstring_encoding', []rt.PhpVal{})
	rt.call_function('fclose', [var_fp.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return false
	}
	this.chmod(var_file_mutated.dup(), mode_mutated, false)
	return true
}

fn (mut this Class_WP_Filesystem_Direct) cwd() rt.PhpVal {
	return rt.call_function('getcwd', []rt.PhpVal{})
}

fn (mut this Class_WP_Filesystem_Direct) chdir(var_dir rt.PhpVal) rt.PhpVal {
	mut var_dir_mutated := var_dir
	return rt.call_function('chdir', [var_dir_mutated.dup()])
}

fn (mut this Class_WP_Filesystem_Direct) chgrp(var_file rt.PhpVal, var_group rt.PhpVal, recursive bool) bool {
	mut var_file_mutated := var_file
	if rt.is_true(rt.new_bool(!(rt.is_true(this.exists(var_file_mutated.dup()))))) {
		return false
	}
	if !(var_recursive) {
		return (rt.call_function('chgrp', [var_file_mutated.dup(), var_group.dup()])).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_dir(var_file_mutated.dup()))))) {
		return (rt.call_function('chgrp', [var_file_mutated.dup(), var_group.dup()])).to_bool()
	}
	var_file_mutated = rt.call_function('trailingslashit', [var_file_mutated.dup()])
	mut var_filelist := this.dirlist(var_file_mutated.dup(), false, false)
	{
		mut iter_1 := var_filelist.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_filename := item_1.val
			this.chgrp(rt.new_string((var_file_mutated).str() + (var_filename).str()), var_group.dup(), recursive)
		}
	}
	return true
}

fn (mut this Class_WP_Filesystem_Direct) chmod(var_file rt.PhpVal, mode bool, recursive bool) bool {
	mut var_file_mutated := var_file
	mut mode_mutated := mode
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(mode_mutated))))) {
		if rt.is_true(this.is_file(var_file_mutated.dup())) {
			mode_mutated = (rt.get_constant('FS_CHMOD_FILE')).to_bool()
		} else if rt.is_true(this.is_dir(var_file_mutated.dup())) {
			mode_mutated = (rt.get_constant('FS_CHMOD_DIR')).to_bool()
		} else {
			return false
		}
	}
	if rt.is_true(rt.new_bool(!(var_recursive) || rt.is_true(rt.new_bool(!(rt.is_true(this.is_dir(var_file_mutated.dup()))))))) {
		mut var_current_mode := rt.new_int(rt.bitwise_and(rt.call_function('fileperms', [var_file_mutated.dup()]), rt.new_int(511)) | 420)
		rt.call_function('clearstatcache', [rt.new_bool(true), var_file_mutated.dup()])
		if rt.is_true(rt.identical(var_current_mode, rt.new_bool(mode_mutated))) {
			return true
		}
		return (rt.call_function('chmod', [var_file_mutated.dup(), rt.new_bool(mode_mutated).dup()])).to_bool()
	}
	var_file_mutated = rt.call_function('trailingslashit', [var_file_mutated.dup()])
	mut var_filelist := this.dirlist(var_file_mutated.dup(), false, false)
	{
		mut iter_1 := rt.cast_array(var_filelist).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_filemeta := item_1.val
			mut var_filename := item_1.key
			this.chmod(rt.new_string((var_file_mutated).str() + (var_filename).str()), mode_mutated, recursive)
		}
	}
	return true
}

fn (mut this Class_WP_Filesystem_Direct) chown(var_file rt.PhpVal, var_owner rt.PhpVal, recursive bool) bool {
	mut var_file_mutated := var_file
	if rt.is_true(rt.new_bool(!(rt.is_true(this.exists(var_file_mutated.dup()))))) {
		return false
	}
	if !(var_recursive) {
		return (rt.call_function('chown', [var_file_mutated.dup(), var_owner.dup()])).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_dir(var_file_mutated.dup()))))) {
		return (rt.call_function('chown', [var_file_mutated.dup(), var_owner.dup()])).to_bool()
	}
	mut var_filelist := this.dirlist(var_file_mutated.dup(), false, false)
	{
		mut iter_1 := var_filelist.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_filename := item_1.val
			this.chown(rt.new_string((var_file_mutated).str() + '/' + (var_filename).str()), var_owner.dup(), recursive)
		}
	}
	return true
}

fn (mut this Class_WP_Filesystem_Direct) owner(var_file rt.PhpVal) bool {
	mut var_file_mutated := var_file
	mut var_owneruid := rt.call_function('fileowner', [var_file_mutated.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_owneruid)))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('posix_getpwuid')]))))) {
		return (var_owneruid).to_bool()
	}
	mut var_ownerarray := rt.call_function('posix_getpwuid', [var_owneruid.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_ownerarray)))) {
		return false
	}
	return (var_ownerarray.array_get('name')).to_bool()
}

fn (mut this Class_WP_Filesystem_Direct) getchmod(var_file rt.PhpVal) string {
	mut var_file_mutated := var_file
	mut var_perms := rt.call_function('fileperms', [var_file_mutated.dup()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_perms)) {
		return '0'
	}
	return (rt.call_function('substr', [rt.call_function('decoct', [var_perms.dup()]), // unsupported expression: Expr_UnaryMinus])).str()
}

fn (mut this Class_WP_Filesystem_Direct) group(var_file rt.PhpVal) bool {
	mut var_file_mutated := var_file
	mut var_gid := rt.call_function('filegroup', [var_file_mutated.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_gid)))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('posix_getgrgid')]))))) {
		return (var_gid).to_bool()
	}
	mut var_grouparray := rt.call_function('posix_getgrgid', [var_gid.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_grouparray)))) {
		return false
	}
	return (var_grouparray.array_get('name')).to_bool()
}

fn (mut this Class_WP_Filesystem_Direct) copy(var_source rt.PhpVal, var_destination rt.PhpVal, overwrite bool, mode bool) bool {
	mut mode_mutated := mode
	if rt.is_true(rt.new_bool(!(var_overwrite) && rt.is_true(this.exists(var_destination.dup())))) {
		return false
	}
	mut var_rtval := rt.call_function('copy', [var_source.dup(), var_destination.dup()])
	if rt.is_true(rt.new_bool(mode_mutated)) {
		this.chmod(var_destination.dup(), mode_mutated, false)
	}
	return (var_rtval).to_bool()
}

fn (mut this Class_WP_Filesystem_Direct) move(var_source rt.PhpVal, var_destination rt.PhpVal, overwrite bool) bool {
	if rt.is_true(rt.new_bool(!(var_overwrite) && rt.is_true(this.exists(var_destination.dup())))) {
		return false
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_overwrite && rt.is_true(this.exists(var_destination.dup())))) && !(this.delete(var_destination.dup(), true, false)))) {
		return false
	}
	if rt.is_true(rt.call_function('rename', [var_source.dup(), var_destination.dup()])) {
		return true
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(this.is_file(var_source.dup())) && this.copy(var_source.dup(), var_destination.dup(), overwrite, false))) && rt.is_true(this.exists(var_destination.dup())))) {
		this.delete(var_source.dup(), false, false)
		return true
	} else {
		return false
	}
	return false
}

fn (mut this Class_WP_Filesystem_Direct) delete(var_file rt.PhpVal, recursive bool, type bool) bool {
	mut var_file_mutated := var_file
	if !rt.is_true(var_file_mutated) {
		return false
	}
	var_file_mutated = rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('/'), var_file_mutated.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('f'), rt.new_bool(type))) || rt.is_true(this.is_file(var_file_mutated.dup())))) {
		return (rt.call_function('unlink', [var_file_mutated.dup()])).to_bool()
	}
	if rt.is_true(rt.new_bool(!(var_recursive) && rt.is_true(this.is_dir(var_file_mutated.dup())))) {
		return (rt.call_function('rmdir', [var_file_mutated.dup()])).to_bool()
	}
	var_file_mutated = rt.call_function('trailingslashit', [var_file_mutated.dup()])
	mut var_filelist := this.dirlist(var_file_mutated.dup(), true, false)
	mut var_retval := rt.new_bool(rt.new_bool(true))
	if rt.is_true(rt.new_bool(var_filelist.dup().is_array())) {
		{
			mut iter_1 := var_filelist.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_fileinfo := item_1.val
				mut var_filename := item_1.key
				if !(this.delete(rt.new_string((var_file_mutated).str() + (var_filename).str()), recursive, (var_fileinfo.array_get('type')).to_bool())) {
					var_retval = rt.new_bool(rt.new_bool(false))
				}
			}
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('file_exists', [var_file_mutated.dup()])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('rmdir', [var_file_mutated.dup()]))))))) {
		var_retval = rt.new_bool(rt.new_bool(false))
	}
	return (var_retval).to_bool()
}

fn (mut this Class_WP_Filesystem_Direct) exists(var_path rt.PhpVal) rt.PhpVal {
	mut var_path_mutated := var_path
	return rt.call_function('file_exists', [var_path_mutated.dup()])
}

fn (mut this Class_WP_Filesystem_Direct) is_file(var_file rt.PhpVal) rt.PhpVal {
	mut var_file_mutated := var_file
	return rt.call_function('is_file', [var_file_mutated.dup()])
}

fn (mut this Class_WP_Filesystem_Direct) is_dir(var_path rt.PhpVal) rt.PhpVal {
	mut var_path_mutated := var_path
	return rt.call_function('is_dir', [var_path_mutated.dup()])
}

fn (mut this Class_WP_Filesystem_Direct) is_readable(var_file rt.PhpVal) rt.PhpVal {
	mut var_file_mutated := var_file
	return rt.call_function('is_readable', [var_file_mutated.dup()])
}

fn (mut this Class_WP_Filesystem_Direct) is_writable(var_path rt.PhpVal) rt.PhpVal {
	mut var_path_mutated := var_path
	return rt.call_function('is_writable', [var_path_mutated.dup()])
}

fn (mut this Class_WP_Filesystem_Direct) atime(var_file rt.PhpVal) rt.PhpVal {
	mut var_file_mutated := var_file
	return rt.call_function('fileatime', [var_file_mutated.dup()])
}

fn (mut this Class_WP_Filesystem_Direct) mtime(var_file rt.PhpVal) rt.PhpVal {
	mut var_file_mutated := var_file
	return rt.call_function('filemtime', [var_file_mutated.dup()])
}

fn (mut this Class_WP_Filesystem_Direct) size(var_file rt.PhpVal) rt.PhpVal {
	mut var_file_mutated := var_file
	return rt.call_function('filesize', [var_file_mutated.dup()])
}

fn (mut this Class_WP_Filesystem_Direct) touch(var_file rt.PhpVal, time i64, atime i64) rt.PhpVal {
	mut var_file_mutated := var_file
	mut time_mutated := time
	mut atime_mutated := atime
	if 0 == time_mutated {
		time_mutated = (rt.call_function('time', []rt.PhpVal{})).to_i64()
	}
	if 0 == atime_mutated {
		atime_mutated = (rt.call_function('time', []rt.PhpVal{})).to_i64()
	}
	return rt.call_function('touch', [var_file_mutated.dup(), rt.new_int(time_mutated).dup(), rt.new_int(atime_mutated).dup()])
}

fn (mut this Class_WP_Filesystem_Direct) mkdir(var_path rt.PhpVal, chmod bool, chown bool, chgrp bool) bool {
	mut var_path_mutated := var_path
	mut chmod_mutated := chmod
	var_path_mutated = rt.call_function('untrailingslashit', [var_path_mutated.dup()])
	if !rt.is_true(var_path_mutated) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(chmod_mutated))))) {
		chmod_mutated = (rt.get_constant('FS_CHMOD_DIR')).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('mkdir', [var_path_mutated.dup()]))))) {
		return false
	}
	this.chmod(var_path_mutated.dup(), chmod_mutated, false)
	if var_chown {
		this.chown(var_path_mutated.dup(), rt.new_bool(chown), false)
	}
	if var_chgrp {
		this.chgrp(.dup(), rt.new_bool(), false)
	}
	return true
}

fn (mut this Class_WP_Filesystem_Direct) rmdir(var_path rt.PhpVal, recursive bool) rt.PhpVal {
	mut var_path_mutated := var_path
	return rt.new_bool()
}

fn (mut this Class_WP_Filesystem_Direct) dirlist(var_path rt.PhpVal, include_hidden bool, recursive bool) rt.PhpVal {
	mut var_path_mutated := var_path
}

struct Class_WP_Filesystem_Base {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_filesystem_direct(arg_0 rt.PhpVal) &Class_WP_Filesystem_Direct {
	mut obj := &Class_WP_Filesystem_Direct{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_filesystem_base() &Class_WP_Filesystem_Base {
	mut obj := &Class_WP_Filesystem_Base{
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

fn (mut this Class_WP_Filesystem_Direct) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_contents' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_contents(dispatch_arg_0)
		}
		'get_contents_array' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_contents_array(dispatch_arg_0)
		}
		'put_contents' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.put_contents(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'cwd' {
			return this.cwd()
		}
		'chdir' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.chdir(dispatch_arg_0)
		}
		'chgrp' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.chgrp(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'chmod' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.chmod(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'chown' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.chown(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'owner' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.owner(dispatch_arg_0))
		}
		'getchmod' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.getchmod(dispatch_arg_0))
		}
		'group' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.group(dispatch_arg_0))
		}
		'copy' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.copy(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'move' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.move(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.delete(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'exists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.exists(dispatch_arg_0)
		}
		'is_file' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_file(dispatch_arg_0)
		}
		'is_dir' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_dir(dispatch_arg_0)
		}
		'is_readable' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_readable(dispatch_arg_0)
		}
		'is_writable' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_writable(dispatch_arg_0)
		}
		'atime' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.atime(dispatch_arg_0)
		}
		'mtime' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.mtime(dispatch_arg_0)
		}
		'size' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.size(dispatch_arg_0)
		}
		'touch' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return this.touch(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'mkdir' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.mkdir(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'rmdir' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.rmdir(dispatch_arg_0, dispatch_arg_1)
		}
		'dirlist' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.dirlist(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_WP_Filesystem_Direct) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Filesystem_Direct) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Filesystem_Base) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Filesystem_Base) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Filesystem_Base) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_admin_includes_class_wp_filesystem_direct_php() {
}
