import rt

struct Class_WP_Filesystem_FTPext {
	rt.PhpObjectBase
pub mut:
		link rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Filesystem_FTPext) construct(opt string)  {
	this.dispatch_set_prop('method', rt.new_string('ftpext'))
	this.dispatch_set_prop('errors', create_wp_error())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('extension_loaded', [rt.new_string('ftp')]))))) {
		rt.call_method(rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this), 'errors'), 'add', [rt.new_string('no_ftp_ext'), rt.call_function('__', [rt.new_string('The ftp PHP extension is not available')])])
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('FS_TIMEOUT')]))))) {
		rt.call_function('define', [rt.new_string('FS_TIMEOUT'), rt.mul(rt.new_int(4), rt.get_constant('MINUTE_IN_SECONDS'))])
	}
	if !rt.is_true(rt.new_string(opt).array_get('port')) {
		rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this), 'options').array_set('port', 21)
	} else {
		rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this), 'options').array_set('port', rt.new_string(opt).array_get('port'))
	}
	if !rt.is_true(rt.new_string(opt).array_get('hostname')) {
		rt.call_method(rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this), 'errors'), 'add', [rt.new_string('empty_hostname'), rt.call_function('__', [rt.new_string('FTP hostname is required')])])
	} else {
		rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this), 'options').array_set('hostname', rt.new_string(opt).array_get('hostname'))
	}
	if !rt.is_true(rt.new_string(opt).array_get('username')) {
		rt.call_method(rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this), 'errors'), 'add', [rt.new_string('empty_username'), rt.call_function('__', [rt.new_string('FTP username is required')])])
	} else {
		rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this), 'options').array_set('username', rt.new_string(opt).array_get('username'))
	}
	if !rt.is_true(rt.new_string(opt).array_get('password')) {
		rt.call_method(rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this), 'errors'), 'add', [rt.new_string('empty_password'), rt.call_function('__', [rt.new_string('FTP password is required')])])
	} else {
		rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this), 'options').array_set('password', rt.new_string(opt).array_get('password'))
	}
	rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this), 'options').array_set('ssl', false)
	if rt.is_true(rt.new_bool(rt.new_string(opt).array_isset(rt.new_string('connection_type')) && rt.is_true(rt.identical(rt.new_string('ftps'), rt.new_string(opt).array_get('connection_type'))))) {
		rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this), 'options').array_set('ssl', true)
	}
}

fn (mut this Class_WP_Filesystem_FTPext) connect() bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this), 'options').array_isset(rt.new_string('ssl')) && rt.is_true(rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this), 'options').array_get('ssl')))) && rt.is_true(rt.call_function('function_exists', [rt.new_string('ftp_ssl_connect')])))) {
		this.link = rt.call_function('ftp_ssl_connect', [rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this), 'options').array_get('hostname'), rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this), 'options').array_get('port'), rt.get_constant('FS_CONNECT_TIMEOUT')])
	} else {
		this.link = rt.call_function('ftp_connect', [rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this), 'options').array_get('hostname'), rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this), 'options').array_get('port'), rt.get_constant('FS_CONNECT_TIMEOUT')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.link)))) {
		rt.call_method(rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this), 'errors'), 'add', [rt.new_string('connect'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Failed to connect to FTP Server %s')]), (rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this), 'options').array_get('hostname')).str() + ':' + (rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this), 'options').array_get('port')).str()])])
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('ftp_login', [this.link, rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this), 'options').array_get('username'), rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this), 'options').array_get('password')]))))) {
		rt.call_method(rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this), 'errors'), 'add', [rt.new_string('auth'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Username/Password incorrect for %s')]), rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this), 'options').array_get('username')])])
		return false
	}
	rt.call_function('ftp_pasv', [this.link, rt.new_bool(true)])
	if rt.is_true(rt.less(rt.call_function('ftp_get_option', [this.link, rt.get_constant('FTP_TIMEOUT_SEC')]), rt.get_constant('FS_TIMEOUT'))) {
		rt.call_function('ftp_set_option', [this.link, rt.get_constant('FTP_TIMEOUT_SEC'), rt.get_constant('FS_TIMEOUT')])
	}
	return true
}

fn (mut this Class_WP_Filesystem_FTPext) get_contents(var_file rt.PhpVal) bool {
	mut var_tempfile := rt.call_function('wp_tempnam', [var_file.dup()])
	mut var_temphandle := rt.call_function('fopen', [var_tempfile.dup(), rt.new_string('w+')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_temphandle)))) {
		rt.call_function('unlink', [var_tempfile.dup()])
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('ftp_fget', [this.link, var_temphandle.dup(), var_file.dup(), rt.get_constant('FTP_BINARY')]))))) {
		rt.call_function('fclose', [var_temphandle.dup()])
		rt.call_function('unlink', [var_tempfile.dup()])
		return false
	}
	rt.call_function('fseek', [var_temphandle.dup(), rt.new_int(0)])
	mut var_contents := rt.new_string(rt.new_string(''))
	for rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('feof', [var_temphandle.dup()]))))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	rt.call_function('fclose', [var_temphandle.dup()])
	rt.call_function('unlink', [var_tempfile.dup()])
	return (var_contents).to_bool()
}

fn (mut this Class_WP_Filesystem_FTPext) get_contents_array(var_file rt.PhpVal) rt.PhpVal {
	return rt.call_function('explode', [rt.new_string('\n'), this.get_contents(var_file.dup())])
}

fn (mut this Class_WP_Filesystem_FTPext) put_contents(var_file rt.PhpVal, var_contents rt.PhpVal, mode bool) rt.PhpVal {
	mut var_contents_mutated := var_contents
	mut mode_mutated := mode
	mut var_tempfile := rt.call_function('wp_tempnam', [var_file.dup()])
	mut var_temphandle := rt.call_function('fopen', [var_tempfile.dup(), rt.new_string('wb+')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_temphandle)))) {
		rt.call_function('unlink', [var_tempfile.dup()])
		return rt.new_bool(false)
	}
	rt.call_function('mbstring_binary_safe_encoding', []rt.PhpVal{})
	mut var_data_length := rt.new_int(rt.new_int(var_contents_mutated.dup().to_string().len))
	mut var_bytes_written := rt.call_function('fwrite', [var_temphandle.dup(), var_contents_mutated.dup()])
	rt.call_function('reset_mbstring_encoding', []rt.PhpVal{})
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_function('fclose', [var_temphandle.dup()])
		rt.call_function('unlink', [var_tempfile.dup()])
		return rt.new_bool(false)
	}
	rt.call_function('fseek', [var_temphandle.dup(), rt.new_int(0)])
	mut var_ret := rt.call_function('ftp_fput', [this.link, var_file.dup(), var_temphandle.dup(), rt.get_constant('FTP_BINARY')])
	rt.call_function('fclose', [var_temphandle.dup()])
	rt.call_function('unlink', [var_tempfile.dup()])
	this.chmod(var_file.dup(), mode_mutated, false)
	return var_ret.dup()
}

fn (mut this Class_WP_Filesystem_FTPext) cwd() rt.PhpVal {
	mut var_cwd := rt.call_function('ftp_pwd', [this.link])
	if rt.is_true(var_cwd) {
		var_cwd = rt.call_function('trailingslashit', [var_cwd.dup()])
	}
	return var_cwd.dup()
}

fn (mut this Class_WP_Filesystem_FTPext) chdir(var_dir rt.PhpVal) rt.PhpVal {
	mut var_dir_mutated := var_dir
	return rt.call_function('ftp_chdir', [this.link, var_dir_mutated.dup()])
}

fn (mut this Class_WP_Filesystem_FTPext) chmod(var_file rt.PhpVal, mode bool, recursive bool) bool {
	mut mode_mutated := mode
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(mode_mutated))))) {
		if this.is_file(var_file.dup()) {
			mode_mutated = (rt.get_constant('FS_CHMOD_FILE')).to_bool()
		} else if this.is_dir(var_file.dup()) {
			mode_mutated = (rt.get_constant('FS_CHMOD_DIR')).to_bool()
		} else {
			return false
		}
	}
	if var_recursive && this.is_dir(var_file.dup()) {
		mut var_filelist := this.dirlist((var_file).str(), false, false)
		{
			mut iter_1 := rt.cast_array(var_filelist).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_filemeta := item_1.val
				mut var_filename := item_1.key
				this.chmod(rt.new_string((var_file).str() + '/' + (var_filename).str()), mode_mutated, recursive)
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('ftp_chmod')]))))) {
		return (// unsupported expression: Expr_Cast_Bool).to_bool()
	}
	return (// unsupported expression: Expr_Cast_Bool).to_bool()
}

fn (mut this Class_WP_Filesystem_FTPext) owner(var_file rt.PhpVal) rt.PhpVal {
	mut var_dir := this.dirlist((var_file).str(), false, false)
	return if !(var_dir.array_get(var_file).array_get('owner')).is_null() { var_dir.array_get(var_file).array_get('owner') } else { rt.new_string('') }
}

fn (mut this Class_WP_Filesystem_FTPext) getchmod(var_file rt.PhpVal) rt.PhpVal {
	mut var_dir := this.dirlist((var_file).str(), false, false)
	return if !(var_dir.array_get(var_file).array_get('permsn')).is_null() { var_dir.array_get(var_file).array_get('permsn') } else { rt.new_string('') }
}

fn (mut this Class_WP_Filesystem_FTPext) group(var_file rt.PhpVal) rt.PhpVal {
	mut var_dir := this.dirlist((var_file).str(), false, false)
	return if !(var_dir.array_get(var_file).array_get('group')).is_null() { var_dir.array_get(var_file).array_get('group') } else { rt.new_string('') }
}

fn (mut this Class_WP_Filesystem_FTPext) copy(var_source rt.PhpVal, var_destination rt.PhpVal, overwrite bool, mode bool) bool {
	mut mode_mutated := mode
	if !(var_overwrite) && this.exists(var_destination.dup()) {
		return false
	}
	mut var_content := rt.new_bool(this.get_contents(var_source.dup()))
	if rt.is_true(rt.identical(rt.new_bool(false), var_content)) {
		return false
	}
	return (this.put_contents(var_destination.dup(), var_content.dup(), mode_mutated)).to_bool()
}

fn (mut this Class_WP_Filesystem_FTPext) move(var_source rt.PhpVal, var_destination rt.PhpVal, overwrite bool) rt.PhpVal {
	return rt.call_function('ftp_rename', [this.link, var_source.dup(), var_destination.dup()])
}

fn (mut this Class_WP_Filesystem_FTPext) delete(var_file rt.PhpVal, recursive bool, type bool) bool {
	if !rt.is_true(var_file) {
		return false
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('f'), rt.new_bool(type))) || this.is_file(var_file.dup()))) {
		return (rt.call_function('ftp_delete', [this.link, var_file.dup()])).to_bool()
	}
	if !(var_recursive) {
		return (rt.call_function('ftp_rmdir', [this.link, var_file.dup()])).to_bool()
	}
	mut var_filelist := this.dirlist((rt.call_function('trailingslashit', [var_file.dup()])).str(), false, false)
	if !(!rt.is_true(var_filelist)) {
		{
			mut iter_1 := var_filelist.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_delete_file := item_1.val
				this.delete(rt.new_string((rt.call_function('trailingslashit', [var_file.dup()])).str() + (var_delete_file.array_get('name')).str()), recursive, (var_delete_file.array_get('type')).to_bool())
			}
		}
	}
	return (rt.call_function('ftp_rmdir', [this.link, var_file.dup()])).to_bool()
}

fn (mut this Class_WP_Filesystem_FTPext) exists(var_path rt.PhpVal) bool {
	mut var_path_mutated := var_path
	if rt.is_true(rt.identical(rt.new_string(''), var_path_mutated)) {
		return false
	}
	mut var_list := rt.call_function('ftp_nlist', [this.link, var_path_mutated.dup()])
	if !rt.is_true(var_list) && this.is_dir(var_path_mutated.dup()) {
		return true
		// unsupported statement: Stmt_Nop
	}
	return !(!rt.is_true(var_list))
	// unsupported statement: Stmt_Nop
	return false
}

fn (mut this Class_WP_Filesystem_FTPext) is_file(var_file rt.PhpVal) bool {
	return this.exists(var_file.dup()) && !(this.is_dir(var_file.dup()))
}

fn (mut this Class_WP_Filesystem_FTPext) is_dir(var_path rt.PhpVal) bool {
	mut var_path_mutated := var_path
	mut var_cwd := this.cwd()
	mut var_result := rt.call_function('ftp_chdir', [this.link, rt.call_function('trailingslashit', [.dup()])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_result) && rt.is_true(rt.identical(, )))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.call_function('ftp_chdir', [, .dup()])
		return true
	}
	return false
}

fn (mut this Class_WP_Filesystem_FTPext) is_readable(var_file rt.PhpVal) bool {
	return 
}

fn (mut this Class_WP_Filesystem_FTPext) is_writable(var_path rt.PhpVal) bool {
	mut var_path_mutated := var_path
}

fn (mut this Class_WP_Filesystem_FTPext) atime(var_file rt.PhpVal) bool {
}

fn (mut this Class_WP_Filesystem_FTPext) mtime(var_file rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_Filesystem_FTPext) size(var_file rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_Filesystem_FTPext) touch(var_file rt.PhpVal, time i64, atime i64) bool {
}

fn (mut this Class_WP_Filesystem_FTPext) mkdir(var_path rt.PhpVal, chmod bool, chown bool, chgrp bool) bool {
	mut var_path_mutated := var_path
}

fn (mut this Class_WP_Filesystem_FTPext) rmdir(var_path rt.PhpVal, recursive bool) rt.PhpVal {
	mut var_path_mutated := var_path
}

fn (mut this Class_WP_Filesystem_FTPext) parselisting(var_line rt.PhpVal) rt.PhpVal {
	mut var_l2 := []rt.PhpVal{}
}

fn (mut this Class_WP_Filesystem_FTPext) dirlist(path string, include_hidden bool, recursive bool) rt.PhpVal {
	mut path_mutated := path
}

fn (mut this Class_WP_Filesystem_FTPext) magic_destruct()  {
}

struct Class_WP_Filesystem_Base {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_filesystem_ftpext(opt string) &Class_WP_Filesystem_FTPext {
	mut obj := &Class_WP_Filesystem_FTPext{
		PhpObjectBase: rt.PhpObjectBase{}
		link: rt.new_null()
	}
	obj.construct(opt)
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

fn (mut this Class_WP_Filesystem_FTPext) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'connect' {
			return rt.new_bool(this.connect())
		}
		'get_contents' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_contents(dispatch_arg_0))
		}
		'get_contents_array' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_contents_array(dispatch_arg_0)
		}
		'put_contents' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.put_contents(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'cwd' {
			return this.cwd()
		}
		'chdir' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.chdir(dispatch_arg_0)
		}
		'chmod' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.chmod(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'owner' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.owner(dispatch_arg_0)
		}
		'getchmod' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.getchmod(dispatch_arg_0)
		}
		'group' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.group(dispatch_arg_0)
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
			return this.move(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.delete(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'exists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.exists(dispatch_arg_0))
		}
		'is_file' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_file(dispatch_arg_0))
		}
		'is_dir' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_dir(dispatch_arg_0))
		}
		'is_readable' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_readable(dispatch_arg_0))
		}
		'is_writable' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_writable(dispatch_arg_0))
		}
		'atime' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.atime(dispatch_arg_0))
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
			return rt.new_bool(this.touch(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
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
		'parselisting' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parselisting(dispatch_arg_0)
		}
		'dirlist' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.dirlist(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'__destruct' {
			this.magic_destruct()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP_Filesystem_FTPext) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'link' { return this.link }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Filesystem_FTPext) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'link' { this.link = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_admin_includes_class_wp_filesystem_ftpext_php() {
}
