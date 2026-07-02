import rt

struct Class_WP_Filesystem_ftpsockets {
	rt.PhpObjectBase
pub mut:
	ftp rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Filesystem_ftpsockets) construct(opt string) {
	this.dispatch_set_prop('method', rt.new_string('ftpsockets'))
	this.dispatch_set_prop('errors', create_wp_error())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-ftp.php', '4')))))
	{
		return
	}
	this.ftp = create_ftp()
	if !rt.is_true(rt.new_string(opt).array_get(rt.new_string('port'))) {
		rt.get_property(rt.new_object('WP_Filesystem_ftpsockets', [
			'WP_Filesystem_Base',
		], &this), 'options').array_set('port', 21)
	} else {
		rt.get_property(rt.new_object('WP_Filesystem_ftpsockets', [
			'WP_Filesystem_Base',
		], &this), 'options').array_set('port',
			rt.new_int((rt.new_string(opt).array_get(rt.new_string('port'))).to_i64()))
	}
	if !rt.is_true(rt.new_string(opt).array_get(rt.new_string('hostname'))) {
		rt.call_method(rt.get_property(rt.new_object('WP_Filesystem_ftpsockets', [
			'WP_Filesystem_Base',
		], &this), 'errors'), 'add', [rt.new_string('empty_hostname'),
			rt.call_function('__', [rt.new_string('FTP hostname is required')])])
	} else {
		rt.get_property(rt.new_object('WP_Filesystem_ftpsockets', [
			'WP_Filesystem_Base',
		], &this), 'options').array_set('hostname',
			rt.new_string(opt).array_get(rt.new_string('hostname')))
	}
	if !rt.is_true(rt.new_string(opt).array_get(rt.new_string('username'))) {
		rt.call_method(rt.get_property(rt.new_object('WP_Filesystem_ftpsockets', [
			'WP_Filesystem_Base',
		], &this), 'errors'), 'add', [rt.new_string('empty_username'),
			rt.call_function('__', [rt.new_string('FTP username is required')])])
	} else {
		rt.get_property(rt.new_object('WP_Filesystem_ftpsockets', [
			'WP_Filesystem_Base',
		], &this), 'options').array_set('username',
			rt.new_string(opt).array_get(rt.new_string('username')))
	}
	if !rt.is_true(rt.new_string(opt).array_get(rt.new_string('password'))) {
		rt.call_method(rt.get_property(rt.new_object('WP_Filesystem_ftpsockets', [
			'WP_Filesystem_Base',
		], &this), 'errors'), 'add', [rt.new_string('empty_password'),
			rt.call_function('__', [rt.new_string('FTP password is required')])])
	} else {
		rt.get_property(rt.new_object('WP_Filesystem_ftpsockets', [
			'WP_Filesystem_Base',
		], &this), 'options').array_set('password',
			rt.new_string(opt).array_get(rt.new_string('password')))
	}
}

fn (mut this Class_WP_Filesystem_ftpsockets) connect() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.ftp)))) {
		return false
	}
	rt.call_method(this.ftp, 'SetTimeout', [rt.get_constant('FS_CONNECT_TIMEOUT')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.ftp, 'SetServer', [
		rt.get_property(rt.new_object('WP_Filesystem_ftpsockets', [
			'WP_Filesystem_Base',
		], &this), 'options').array_get(rt.new_string('hostname')),
		rt.get_property(rt.new_object('WP_Filesystem_ftpsockets', [
			'WP_Filesystem_Base',
		], &this), 'options').array_get(rt.new_string('port')),
	])))))
	{
		rt.call_method(rt.get_property(rt.new_object('WP_Filesystem_ftpsockets', [
			'WP_Filesystem_Base',
		], &this), 'errors'), 'add', [rt.new_string('connect'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Failed to connect to FTP Server %s'),
				]),
				rt.new_string(
					(rt.get_property(rt.new_object('WP_Filesystem_ftpsockets', ['WP_Filesystem_Base'], &this), 'options').array_get(rt.new_string('hostname'))).str() +
					':' +(rt.get_property(rt.new_object('WP_Filesystem_ftpsockets', ['WP_Filesystem_Base'], &this), 'options').array_get(rt.new_string('port'))).str()),
			])])
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.ftp, 'connect', []rt.PhpVal{}))))) {
		rt.call_method(rt.get_property(rt.new_object('WP_Filesystem_ftpsockets', [
			'WP_Filesystem_Base',
		], &this), 'errors'), 'add', [rt.new_string('connect'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Failed to connect to FTP Server %s'),
				]),
				rt.new_string(
					(rt.get_property(rt.new_object('WP_Filesystem_ftpsockets', ['WP_Filesystem_Base'], &this), 'options').array_get(rt.new_string('hostname'))).str() +
					':' +(rt.get_property(rt.new_object('WP_Filesystem_ftpsockets', ['WP_Filesystem_Base'], &this), 'options').array_get(rt.new_string('port'))).str()),
			])])
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.ftp, 'login', [
		rt.get_property(rt.new_object('WP_Filesystem_ftpsockets', [
			'WP_Filesystem_Base',
		], &this), 'options').array_get(rt.new_string('username')),
		rt.get_property(rt.new_object('WP_Filesystem_ftpsockets', [
			'WP_Filesystem_Base',
		], &this), 'options').array_get(rt.new_string('password')),
	])))))
	{
		rt.call_method(rt.get_property(rt.new_object('WP_Filesystem_ftpsockets', [
			'WP_Filesystem_Base',
		], &this), 'errors'), 'add', [rt.new_string('auth'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Username/Password incorrect for %s'),
				]),
				rt.get_property(rt.new_object('WP_Filesystem_ftpsockets', [
					'WP_Filesystem_Base',
				], &this), 'options').array_get(rt.new_string('username')),
			])])
		return false
	}
	rt.call_method(this.ftp, 'SetType', [rt.get_constant('FTP_BINARY')])
	rt.call_method(this.ftp, 'Passive', [rt.new_bool(true)])
	rt.call_method(this.ftp, 'SetTimeout', [rt.get_constant('FS_TIMEOUT')])
	return true
}

fn (mut this Class_WP_Filesystem_ftpsockets) get_contents(var_file rt.PhpVal) rt.PhpVal {
	if !(this.exists(var_file.clone())) {
		return rt.new_bool(false)
	}
	mut var_tempfile := rt.call_function('wp_tempnam', [var_file.clone()])
	mut var_temphandle := rt.call_function('fopen', [var_tempfile.clone(),
		rt.new_string('w+')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_temphandle)))) {
		rt.call_function('unlink', [var_tempfile.clone()])
		return rt.new_bool(false)
	}
	rt.call_function('mbstring_binary_safe_encoding', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.ftp, 'fget', [
		var_temphandle.clone(), var_file.clone()])))))
	{
		rt.call_function('fclose', [var_temphandle.clone()])
		rt.call_function('unlink', [var_tempfile.clone()])
		rt.call_function('reset_mbstring_encoding', []rt.PhpVal{})
		return rt.new_string('')
	}
	rt.call_function('reset_mbstring_encoding', []rt.PhpVal{})
	rt.call_function('fseek', [var_temphandle.clone(), rt.new_int(0)])
	mut var_contents := rt.new_string('')
	for rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('feof', [
		var_temphandle.clone()]))))) {
		var_contents = rt.concat(var_contents, rt.call_function('fread', [
			var_temphandle.clone(), rt.mul(rt.new_int(8), rt.get_constant('KB_IN_BYTES'))]))
	}
	rt.call_function('fclose', [var_temphandle.clone()])
	rt.call_function('unlink', [var_tempfile.clone()])
	return var_contents.clone()
}

fn (mut this Class_WP_Filesystem_ftpsockets) get_contents_array(var_file rt.PhpVal) rt.PhpVal {
	return rt.call_function('explode', [rt.new_string('\n'), this.get_contents(var_file.clone())])
}

fn (mut this Class_WP_Filesystem_ftpsockets) put_contents(var_file rt.PhpVal, var_contents rt.PhpVal, mode bool) rt.PhpVal {
	mut var_contents_mutated := var_contents
	mut mode_mutated := mode
	mut var_tempfile := rt.call_function('wp_tempnam', [var_file.clone()])
	mut var_temphandle := rt.call_function('fopen', [var_tempfile.clone(),
		rt.new_string('w+')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_temphandle)))) {
		rt.call_function('unlink', [var_tempfile.clone()])
		return rt.new_bool(false)
	}
	rt.call_function('mbstring_binary_safe_encoding', []rt.PhpVal{})
	mut var_bytes_written := rt.call_function('fwrite', [var_temphandle.clone(),
		var_contents_mutated.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_bytes_written))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(var_contents_mutated.clone().to_string().len), var_bytes_written)))) {
		rt.call_function('fclose', [var_temphandle.clone()])
		rt.call_function('unlink', [var_tempfile.clone()])
		rt.call_function('reset_mbstring_encoding', []rt.PhpVal{})
		return rt.new_bool(false)
	}
	rt.call_function('fseek', [var_temphandle.clone(), rt.new_int(0)])
	mut var_ret := rt.call_method(this.ftp, 'fput', [var_file.clone(),
		var_temphandle.clone()])
	rt.call_function('reset_mbstring_encoding', []rt.PhpVal{})
	rt.call_function('fclose', [var_temphandle.clone()])
	rt.call_function('unlink', [var_tempfile.clone()])
	this.chmod(var_file.clone(), mode_mutated, false)
	return var_ret.clone()
}

fn (mut this Class_WP_Filesystem_ftpsockets) cwd() rt.PhpVal {
	mut var_cwd := rt.call_method(this.ftp, 'pwd', []rt.PhpVal{})
	if rt.is_true(var_cwd) {
		var_cwd = rt.call_function('trailingslashit', [var_cwd.clone()])
	}
	return var_cwd.clone()
}

fn (mut this Class_WP_Filesystem_ftpsockets) chdir(var_dir rt.PhpVal) rt.PhpVal {
	mut var_dir_mutated := var_dir
	return rt.call_method(this.ftp, 'chdir', [var_dir_mutated.clone()])
}

fn (mut this Class_WP_Filesystem_ftpsockets) chmod(var_file rt.PhpVal, mode bool, recursive bool) bool {
	mut mode_mutated := mode
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(mode_mutated))))) {
		if this.is_file(var_file.clone()) {
			mode_mutated = (rt.get_constant('FS_CHMOD_FILE')).to_bool()
		} else if this.is_dir(var_file.clone()) {
			mode_mutated = (rt.get_constant('FS_CHMOD_DIR')).to_bool()
		} else {
			return false
		}
	}
	if var_recursive && this.is_dir(var_file.clone()) {
		mut var_filelist := this.dirlist(var_file.str(), false, false)
		mut iter_1 := rt.cast_array(var_filelist).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_filemeta := item_1.val
			mut var_filename := item_1.key
			this.chmod(rt.new_string(var_file.str() + '/' + var_filename.str()), mode_mutated,
				recursive)
		}
	}
	return (rt.call_method(this.ftp, 'chmod', [var_file.clone(),
		rt.new_bool(mode_mutated).clone()])).to_bool()
}

fn (mut this Class_WP_Filesystem_ftpsockets) owner(var_file rt.PhpVal) rt.PhpVal {
	mut var_dir := this.dirlist(var_file.str(), false, false)
	return if !(var_dir.array_get(var_file).array_get(rt.new_string('owner'))).is_null() {
		var_dir.array_get(var_file).array_get(rt.new_string('owner'))
	} else {
		rt.new_string('')
	}
}

fn (mut this Class_WP_Filesystem_ftpsockets) getchmod(var_file rt.PhpVal) rt.PhpVal {
	mut var_dir := this.dirlist(var_file.str(), false, false)
	return if !(var_dir.array_get(var_file).array_get(rt.new_string('permsn'))).is_null() {
		var_dir.array_get(var_file).array_get(rt.new_string('permsn'))
	} else {
		rt.new_string('')
	}
}

fn (mut this Class_WP_Filesystem_ftpsockets) group(var_file rt.PhpVal) rt.PhpVal {
	mut var_dir := this.dirlist(var_file.str(), false, false)
	return if !(var_dir.array_get(var_file).array_get(rt.new_string('group'))).is_null() {
		var_dir.array_get(var_file).array_get(rt.new_string('group'))
	} else {
		rt.new_string('')
	}
}

fn (mut this Class_WP_Filesystem_ftpsockets) copy(var_source rt.PhpVal, var_destination rt.PhpVal, overwrite bool, mode bool) bool {
	mut mode_mutated := mode
	if !var_overwrite && this.exists(var_destination.clone()) {
		return false
	}
	mut var_content := this.get_contents(var_source.clone())
	if rt.is_true(rt.identical(rt.new_bool(false), var_content)) {
		return false
	}
	return (this.put_contents(var_destination.clone(), var_content.clone(), mode_mutated)).to_bool()
}

fn (mut this Class_WP_Filesystem_ftpsockets) move(var_source rt.PhpVal, var_destination rt.PhpVal, overwrite bool) rt.PhpVal {
	return rt.call_method(this.ftp, 'rename', [var_source.clone(),
		var_destination.clone()])
}

fn (mut this Class_WP_Filesystem_ftpsockets) delete(var_file rt.PhpVal, recursive bool, type bool) bool {
	if !rt.is_true(var_file) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('f'), rt.new_bool(type)))
		|| this.is_file(var_file.clone()) {
		return (rt.call_method(this.ftp, 'delete', [var_file.clone()])).to_bool()
	}
	if !var_recursive {
		return (rt.call_method(this.ftp, 'rmdir', [var_file.clone()])).to_bool()
	}
	return (rt.call_method(this.ftp, 'mdel', [var_file.clone()])).to_bool()
}

fn (mut this Class_WP_Filesystem_ftpsockets) exists(var_path rt.PhpVal) bool {
	mut var_path_mutated := var_path
	if rt.is_true(rt.identical(rt.new_string(''), var_path_mutated)) {
		return false
	}
	mut var_list := rt.call_method(this.ftp, 'nlist', [var_path_mutated.clone()])
	if !rt.is_true(var_list) && this.is_dir(var_path_mutated.clone()) {
		return true
	}
	return !(!rt.is_true(var_list))
	return false
}

fn (mut this Class_WP_Filesystem_ftpsockets) is_file(var_file rt.PhpVal) bool {
	if this.is_dir(var_file.clone()) {
		return false
	}
	if this.exists(var_file.clone()) {
		return true
	}
	return false
}

fn (mut this Class_WP_Filesystem_ftpsockets) is_dir(var_path rt.PhpVal) bool {
	mut var_path_mutated := var_path
	mut var_cwd := this.cwd()
	if rt.is_true(this.chdir(var_path_mutated.clone())) {
		this.chdir(var_cwd.clone())
		return true
	}
	return false
}

fn (mut this Class_WP_Filesystem_ftpsockets) is_readable(var_file rt.PhpVal) bool {
	return true
}

fn (mut this Class_WP_Filesystem_ftpsockets) is_writable(var_path rt.PhpVal) bool {
	mut var_path_mutated := var_path
	return true
}

fn (mut this Class_WP_Filesystem_ftpsockets) atime(var_file rt.PhpVal) bool {
	return false
}

fn (mut this Class_WP_Filesystem_ftpsockets) mtime(var_file rt.PhpVal) rt.PhpVal {
	return rt.call_method(this.ftp, 'mdtm', [var_file.clone()])
}

fn (mut this Class_WP_Filesystem_ftpsockets) size(var_file rt.PhpVal) rt.PhpVal {
	return rt.call_method(this.ftp, 'filesize', [var_file.clone()])
}

fn (mut this Class_WP_Filesystem_ftpsockets) touch(var_file rt.PhpVal, time i64, atime i64) bool {
	return false
}

fn (mut this Class_WP_Filesystem_ftpsockets) mkdir(var_path rt.PhpVal, chmod bool, chown bool, chgrp bool) bool {
	mut var_path_mutated := var_path
	mut chmod_mutated := chmod
	var_path_mutated = rt.call_function('untrailingslashit', [
		var_path_mutated.clone()])
	if !rt.is_true(var_path_mutated) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.ftp, 'mkdir', [
		var_path_mutated.clone()])))))
	{
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(chmod_mutated))))) {
		chmod_mutated = (rt.get_constant('FS_CHMOD_DIR')).to_bool()
	}
	this.chmod(var_path_mutated.clone(), chmod_mutated, false)
	return true
}

fn (mut this Class_WP_Filesystem_ftpsockets) rmdir(var_path rt.PhpVal, recursive bool) rt.PhpVal {
	mut var_path_mutated := var_path
	return rt.new_bool(this.delete(var_path_mutated.clone(), recursive, false))
}

fn (mut this Class_WP_Filesystem_ftpsockets) dirlist(path string, include_hidden bool, recursive bool) rt.PhpVal {
	mut path_mutated := path
	if this.is_file(rt.new_string(path_mutated)) {
		mut var_limit_file := rt.call_function('basename', [rt.new_string(path_mutated).clone()])
		path_mutated = (rt.call_function('dirname', [rt.new_string(path_mutated).clone()])).str() +
			'/'
	} else {
		var_limit_file = rt.new_bool(false)
	}
	rt.call_function('mbstring_binary_safe_encoding', []rt.PhpVal{})
	mut var_list := rt.call_method(this.ftp, 'dirlist', [rt.new_string(path_mutated).clone()])
	if !rt.is_true(var_list) && !(this.exists(rt.new_string(path_mutated))) {
		rt.call_function('reset_mbstring_encoding', []rt.PhpVal{})
		return rt.new_bool(false)
	}
	path_mutated =
		(rt.call_function('trailingslashit', [rt.new_string(path_mutated).clone()])).str()
	mut var_ret := rt.new_array()
	mut iter_2 := var_list.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_struc := item_2.val
		if rt.is_true(rt.identical(rt.new_string('.'), var_struc.array_get(rt.new_string('name'))))
			|| rt.is_true(rt.identical(rt.new_string('..'), var_struc.array_get(rt.new_string('name')))) {
			continue
		}
		if !var_include_hidden
			&& rt.is_true(rt.identical(rt.new_string('.'), var_struc.array_get(rt.new_string('name')).array_get(rt.new_int(0)))) {
			continue
		}
		if rt.is_true(var_limit_file)
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_struc.array_get(rt.new_string('name')), var_limit_file)))) {
			continue
		}
		if rt.is_true(rt.identical(rt.new_string('d'), var_struc.array_get(rt.new_string('type')))) {
			if var_recursive {
				var_struc.array_set('files', this.dirlist(path_mutated +
					(var_struc.array_get(rt.new_string('name'))).str(), include_hidden, recursive))
			} else {
				var_struc.array_set('files', rt.new_array())
			}
		}
		if rt.is_true(var_struc.array_get(rt.new_string('islink'))) {
			var_struc.array_set('name', rt.call_function('preg_replace', [
				rt.new_string('/(\\s*->\\s*.*)$/'),
				rt.new_string(''),
				var_struc.array_get(rt.new_string('name')),
			]))
		}
		var_struc.array_set('permsn',
			this.getnumchmodfromh(var_struc.array_get(rt.new_string('perms'))))
		var_ret.array_set(var_struc.array_get(rt.new_string('name')), var_struc.clone())
	}
	rt.call_function('reset_mbstring_encoding', []rt.PhpVal{})
	return var_ret.clone()
}

fn (mut this Class_WP_Filesystem_ftpsockets) magic_destruct() {
	rt.call_method(this.ftp, 'quit', []rt.PhpVal{})
}

struct Class_WP_Filesystem_Base {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_ftp {
	rt.PhpObjectBase
}

fn create_wp_filesystem_ftpsockets(opt string) &Class_WP_Filesystem_ftpsockets {
	mut obj := &Class_WP_Filesystem_ftpsockets{
		PhpObjectBase: rt.PhpObjectBase{}
		ftp:           rt.new_null()
	}
	obj.construct(opt)
	return obj
}

fn create_wp_filesystem_base(_args ...rt.PhpVal) &Class_WP_Filesystem_Base {
	mut obj := &Class_WP_Filesystem_Base{
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

fn create_ftp(_args ...rt.PhpVal) &Class_ftp {
	mut obj := &Class_ftp{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Filesystem_ftpsockets) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
			return rt.new_bool(this.copy(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3))
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
			return rt.new_bool(this.mkdir(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3))
		}
		'rmdir' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.rmdir(dispatch_arg_0, dispatch_arg_1)
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
		else {
			return none
		}
	}
}

fn (this &Class_WP_Filesystem_ftpsockets) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'ftp' { return this.ftp }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Filesystem_ftpsockets) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'ftp' {
			this.ftp = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_ftp) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ftp) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ftp) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
