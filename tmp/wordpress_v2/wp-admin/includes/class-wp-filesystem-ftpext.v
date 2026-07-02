import rt

struct Class_WP_Filesystem_FTPext {
	rt.PhpObjectBase
pub mut:
	link rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Filesystem_FTPext) construct(opt string) {
	this.dispatch_set_prop('method', rt.new_string('ftpext'))
	this.dispatch_set_prop('errors', create_wp_error())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('extension_loaded', [
		rt.new_string('ftp'),
	])))))
	{
		rt.call_method(rt.get_property(rt.new_object('WP_Filesystem_FTPext', [
			'WP_Filesystem_Base',
		], &this), 'errors'), 'add', [rt.new_string('no_ftp_ext'),
			rt.call_function('__', [
				rt.new_string('The ftp PHP extension is not available'),
			])])
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('FS_TIMEOUT'),
	])))))
	{
		rt.call_function('define', [rt.new_string('FS_TIMEOUT'),
			rt.mul(rt.new_int(4), rt.get_constant('MINUTE_IN_SECONDS'))])
	}
	if !rt.is_true(rt.new_string(opt).array_get(rt.new_string('port'))) {
		rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this),
			'options').array_set('port', 21)
	} else {
		rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this),
			'options').array_set('port', rt.new_string(opt).array_get(rt.new_string('port')))
	}
	if !rt.is_true(rt.new_string(opt).array_get(rt.new_string('hostname'))) {
		rt.call_method(rt.get_property(rt.new_object('WP_Filesystem_FTPext', [
			'WP_Filesystem_Base',
		], &this), 'errors'), 'add', [rt.new_string('empty_hostname'),
			rt.call_function('__', [rt.new_string('FTP hostname is required')])])
	} else {
		rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this),
			'options').array_set('hostname',
			rt.new_string(opt).array_get(rt.new_string('hostname')))
	}
	if !rt.is_true(rt.new_string(opt).array_get(rt.new_string('username'))) {
		rt.call_method(rt.get_property(rt.new_object('WP_Filesystem_FTPext', [
			'WP_Filesystem_Base',
		], &this), 'errors'), 'add', [rt.new_string('empty_username'),
			rt.call_function('__', [rt.new_string('FTP username is required')])])
	} else {
		rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this),
			'options').array_set('username',
			rt.new_string(opt).array_get(rt.new_string('username')))
	}
	if !rt.is_true(rt.new_string(opt).array_get(rt.new_string('password'))) {
		rt.call_method(rt.get_property(rt.new_object('WP_Filesystem_FTPext', [
			'WP_Filesystem_Base',
		], &this), 'errors'), 'add', [rt.new_string('empty_password'),
			rt.call_function('__', [rt.new_string('FTP password is required')])])
	} else {
		rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this),
			'options').array_set('password',
			rt.new_string(opt).array_get(rt.new_string('password')))
	}
	rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this), 'options').array_set('ssl',
		false)
	if rt.new_string(opt).array_isset(rt.new_string('connection_type'))
		&& rt.is_true(rt.identical(rt.new_string('ftps'), rt.new_string(opt).array_get(rt.new_string('connection_type')))) {
		rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this),
			'options').array_set('ssl', true)
	}
}

fn (mut this Class_WP_Filesystem_FTPext) connect() bool {
	if rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this), 'options').array_isset(rt.new_string('ssl'))
		&& rt.is_true(rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this), 'options').array_get(rt.new_string('ssl')))
		&& rt.is_true(rt.call_function('function_exists', [rt.new_string('ftp_ssl_connect')])) {
		this.link = rt.call_function('ftp_ssl_connect', [
			rt.get_property(rt.new_object('WP_Filesystem_FTPext', [
				'WP_Filesystem_Base',
			], &this), 'options').array_get(rt.new_string('hostname')),
			rt.get_property(rt.new_object('WP_Filesystem_FTPext', [
				'WP_Filesystem_Base',
			], &this), 'options').array_get(rt.new_string('port')),
			rt.get_constant('FS_CONNECT_TIMEOUT'),
		])
	} else {
		this.link = rt.call_function('ftp_connect', [
			rt.get_property(rt.new_object('WP_Filesystem_FTPext', [
				'WP_Filesystem_Base',
			], &this), 'options').array_get(rt.new_string('hostname')),
			rt.get_property(rt.new_object('WP_Filesystem_FTPext', [
				'WP_Filesystem_Base',
			], &this), 'options').array_get(rt.new_string('port')),
			rt.get_constant('FS_CONNECT_TIMEOUT'),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.link)))) {
		rt.call_method(rt.get_property(rt.new_object('WP_Filesystem_FTPext', [
			'WP_Filesystem_Base',
		], &this), 'errors'), 'add', [rt.new_string('connect'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Failed to connect to FTP Server %s'),
				]),
				rt.new_string(
					(rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this), 'options').array_get(rt.new_string('hostname'))).str() +
					':' +(rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this), 'options').array_get(rt.new_string('port'))).str()),
			])])
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('ftp_login', [this.link,
		rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this),
			'options').array_get(rt.new_string('username')),
		rt.get_property(rt.new_object('WP_Filesystem_FTPext', ['WP_Filesystem_Base'], &this),
			'options').array_get(rt.new_string('password'))])))))
	{
		rt.call_method(rt.get_property(rt.new_object('WP_Filesystem_FTPext', [
			'WP_Filesystem_Base',
		], &this), 'errors'), 'add', [rt.new_string('auth'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Username/Password incorrect for %s'),
				]),
				rt.get_property(rt.new_object('WP_Filesystem_FTPext', [
					'WP_Filesystem_Base',
				], &this), 'options').array_get(rt.new_string('username')),
			])])
		return false
	}
	rt.call_function('ftp_pasv', [this.link, rt.new_bool(true)])
	if rt.is_true(rt.less(rt.call_function('ftp_get_option', [this.link,
		rt.get_constant('FTP_TIMEOUT_SEC')]), rt.get_constant('FS_TIMEOUT')))
	{
		rt.call_function('ftp_set_option', [this.link, rt.get_constant('FTP_TIMEOUT_SEC'),
			rt.get_constant('FS_TIMEOUT')])
	}
	return true
}

fn (mut this Class_WP_Filesystem_FTPext) get_contents(var_file rt.PhpVal) bool {
	mut var_tempfile := rt.call_function('wp_tempnam', [var_file.clone()])
	mut var_temphandle := rt.call_function('fopen', [var_tempfile.clone(),
		rt.new_string('w+')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_temphandle)))) {
		rt.call_function('unlink', [var_tempfile.clone()])
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('ftp_fget', [this.link, var_temphandle.clone(),
		var_file.clone(), rt.get_constant('FTP_BINARY')])))))
	{
		rt.call_function('fclose', [var_temphandle.clone()])
		rt.call_function('unlink', [var_tempfile.clone()])
		return false
	}
	rt.call_function('fseek', [var_temphandle.clone(), rt.new_int(0)])
	mut var_contents := rt.new_string('')
	for rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('feof', [
		var_temphandle.clone()]))))) {
		var_contents = rt.concat(var_contents, rt.call_function('fread', [
			var_temphandle.clone(), rt.mul(rt.new_int(8), rt.get_constant('KB_IN_BYTES'))]))
	}
	rt.call_function('fclose', [var_temphandle.clone()])
	rt.call_function('unlink', [var_tempfile.clone()])
	return var_contents.to_bool()
}

fn (mut this Class_WP_Filesystem_FTPext) get_contents_array(var_file rt.PhpVal) rt.PhpVal {
	return rt.call_function('explode', [rt.new_string('\n'),
		rt.new_bool(this.get_contents(var_file.clone()))])
}

fn (mut this Class_WP_Filesystem_FTPext) put_contents(var_file rt.PhpVal, var_contents rt.PhpVal, mode bool) rt.PhpVal {
	mut var_contents_mutated := var_contents
	mut mode_mutated := mode
	mut var_tempfile := rt.call_function('wp_tempnam', [var_file.clone()])
	mut var_temphandle := rt.call_function('fopen', [var_tempfile.clone(),
		rt.new_string('wb+')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_temphandle)))) {
		rt.call_function('unlink', [var_tempfile.clone()])
		return rt.new_bool(false)
	}
	rt.call_function('mbstring_binary_safe_encoding', []rt.PhpVal{})
	mut var_data_length := rt.new_int(var_contents_mutated.clone().to_string().len)
	mut var_bytes_written := rt.call_function('fwrite', [var_temphandle.clone(),
		var_contents_mutated.clone()])
	rt.call_function('reset_mbstring_encoding', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_data_length, var_bytes_written)))) {
		rt.call_function('fclose', [var_temphandle.clone()])
		rt.call_function('unlink', [var_tempfile.clone()])
		return rt.new_bool(false)
	}
	rt.call_function('fseek', [var_temphandle.clone(), rt.new_int(0)])
	mut var_ret := rt.call_function('ftp_fput', [this.link, var_file.clone(),
		var_temphandle.clone(), rt.get_constant('FTP_BINARY')])
	rt.call_function('fclose', [var_temphandle.clone()])
	rt.call_function('unlink', [var_tempfile.clone()])
	this.chmod(var_file.clone(), mode_mutated, false)
	return var_ret.clone()
}

fn (mut this Class_WP_Filesystem_FTPext) cwd() rt.PhpVal {
	mut var_cwd := rt.call_function('ftp_pwd', [this.link])
	if rt.is_true(var_cwd) {
		var_cwd = rt.call_function('trailingslashit', [var_cwd.clone()])
	}
	return var_cwd.clone()
}

fn (mut this Class_WP_Filesystem_FTPext) chdir(var_dir rt.PhpVal) rt.PhpVal {
	mut var_dir_mutated := var_dir
	return rt.call_function('ftp_chdir', [this.link, var_dir_mutated.clone()])
}

fn (mut this Class_WP_Filesystem_FTPext) chmod(var_file rt.PhpVal, mode bool, recursive bool) bool {
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
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('ftp_chmod'),
	])))))
	{
		return (rt.call_function('ftp_site', [this.link,
			rt.call_function('sprintf', [rt.new_string('CHMOD %o %s'),
				rt.new_bool(mode_mutated).clone(), var_file.clone()])])).to_bool()
	}
	return (rt.call_function('ftp_chmod', [this.link, rt.new_bool(mode_mutated).clone(),
		var_file.clone()])).to_bool()
}

fn (mut this Class_WP_Filesystem_FTPext) owner(var_file rt.PhpVal) rt.PhpVal {
	mut var_dir := this.dirlist(var_file.str(), false, false)
	return if !(var_dir.array_get(var_file).array_get(rt.new_string('owner'))).is_null() {
		var_dir.array_get(var_file).array_get(rt.new_string('owner'))
	} else {
		rt.new_string('')
	}
}

fn (mut this Class_WP_Filesystem_FTPext) getchmod(var_file rt.PhpVal) rt.PhpVal {
	mut var_dir := this.dirlist(var_file.str(), false, false)
	return if !(var_dir.array_get(var_file).array_get(rt.new_string('permsn'))).is_null() {
		var_dir.array_get(var_file).array_get(rt.new_string('permsn'))
	} else {
		rt.new_string('')
	}
}

fn (mut this Class_WP_Filesystem_FTPext) group(var_file rt.PhpVal) rt.PhpVal {
	mut var_dir := this.dirlist(var_file.str(), false, false)
	return if !(var_dir.array_get(var_file).array_get(rt.new_string('group'))).is_null() {
		var_dir.array_get(var_file).array_get(rt.new_string('group'))
	} else {
		rt.new_string('')
	}
}

fn (mut this Class_WP_Filesystem_FTPext) copy(var_source rt.PhpVal, var_destination rt.PhpVal, overwrite bool, mode bool) bool {
	mut mode_mutated := mode
	if !var_overwrite && this.exists(var_destination.clone()) {
		return false
	}
	mut var_content := rt.new_bool(this.get_contents(var_source.clone()))
	if rt.is_true(rt.identical(rt.new_bool(false), var_content)) {
		return false
	}
	return (this.put_contents(var_destination.clone(), var_content.clone(), mode_mutated)).to_bool()
}

fn (mut this Class_WP_Filesystem_FTPext) move(var_source rt.PhpVal, var_destination rt.PhpVal, overwrite bool) rt.PhpVal {
	return rt.call_function('ftp_rename', [this.link, var_source.clone(),
		var_destination.clone()])
}

fn (mut this Class_WP_Filesystem_FTPext) delete(var_file rt.PhpVal, recursive bool, type bool) bool {
	if !rt.is_true(var_file) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('f'), rt.new_bool(type)))
		|| this.is_file(var_file.clone()) {
		return (rt.call_function('ftp_delete', [this.link, var_file.clone()])).to_bool()
	}
	if !var_recursive {
		return (rt.call_function('ftp_rmdir', [this.link, var_file.clone()])).to_bool()
	}
	mut var_filelist := this.dirlist((rt.call_function('trailingslashit', [
		var_file.clone()])).str(), false, false)
	if !(!rt.is_true(var_filelist)) {
		mut iter_2 := var_filelist.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_delete_file := item_2.val
			this.delete(rt.new_string(
				(rt.call_function('trailingslashit', [var_file.clone()])).str() +
				(var_delete_file.array_get(rt.new_string('name'))).str()), recursive,
				(var_delete_file.array_get(rt.new_string('type'))).to_bool())
		}
	}
	return (rt.call_function('ftp_rmdir', [this.link, var_file.clone()])).to_bool()
}

fn (mut this Class_WP_Filesystem_FTPext) exists(var_path rt.PhpVal) bool {
	mut var_path_mutated := var_path
	if rt.is_true(rt.identical(rt.new_string(''), var_path_mutated)) {
		return false
	}
	mut var_list := rt.call_function('ftp_nlist', [this.link, var_path_mutated.clone()])
	if !rt.is_true(var_list) && this.is_dir(var_path_mutated.clone()) {
		return true
	}
	return !(!rt.is_true(var_list))
	return false
}

fn (mut this Class_WP_Filesystem_FTPext) is_file(var_file rt.PhpVal) bool {
	return this.exists(var_file.clone()) && !(this.is_dir(var_file.clone()))
}

fn (mut this Class_WP_Filesystem_FTPext) is_dir(var_path rt.PhpVal) bool {
	mut var_path_mutated := var_path
	mut var_cwd := this.cwd()
	mut var_result := rt.call_function('ftp_chdir', [this.link,
		rt.call_function('trailingslashit', [var_path_mutated.clone()])])
	if (rt.is_true(var_result) && rt.is_true(rt.identical(var_path_mutated, this.cwd())))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.cwd(), var_cwd)))) {
		rt.call_function('ftp_chdir', [this.link, var_cwd.clone()])
		return true
	}
	return false
}

fn (mut this Class_WP_Filesystem_FTPext) is_readable(var_file rt.PhpVal) bool {
	return true
}

fn (mut this Class_WP_Filesystem_FTPext) is_writable(var_path rt.PhpVal) bool {
	mut var_path_mutated := var_path
	return true
}

fn (mut this Class_WP_Filesystem_FTPext) atime(var_file rt.PhpVal) bool {
	return false
}

fn (mut this Class_WP_Filesystem_FTPext) mtime(var_file rt.PhpVal) rt.PhpVal {
	return rt.call_function('ftp_mdtm', [this.link, var_file.clone()])
}

fn (mut this Class_WP_Filesystem_FTPext) size(var_file rt.PhpVal) rt.PhpVal {
	mut var_size := rt.call_function('ftp_size', [this.link, var_file.clone()])
	return if rt.is_true(rt.greater(var_size, -1)) { var_size } else { rt.new_bool(false) }
}

fn (mut this Class_WP_Filesystem_FTPext) touch(var_file rt.PhpVal, time i64, atime i64) bool {
	return false
}

fn (mut this Class_WP_Filesystem_FTPext) mkdir(var_path rt.PhpVal, chmod bool, chown bool, chgrp bool) bool {
	mut var_path_mutated := var_path
	var_path_mutated = rt.call_function('untrailingslashit', [
		var_path_mutated.clone()])
	if !rt.is_true(var_path_mutated) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('ftp_mkdir',
		[this.link, var_path_mutated.clone()])))))
	{
		return false
	}
	this.chmod(var_path_mutated.clone(), chmod, false)
	return true
}

fn (mut this Class_WP_Filesystem_FTPext) rmdir(var_path rt.PhpVal, recursive bool) rt.PhpVal {
	mut var_path_mutated := var_path
	return rt.new_bool(this.delete(var_path_mutated.clone(), recursive, false))
}

fn (mut this Class_WP_Filesystem_FTPext) parselisting(var_line rt.PhpVal) rt.PhpVal {
	mut var_l2 := []rt.PhpVal{}
	mut var_is_windows := rt.new_null()
	if rt.is_true(rt.new_bool(var_is_windows.clone().is_null())) {
		var_is_windows = rt.new_bool(!rt.is_true(rt.identical(rt.call_function('stripos', [
			rt.call_function('ftp_systype', [this.link]),
			rt.new_string('win'),
		]), rt.new_bool(false))))
	}
	if rt.is_true(var_is_windows)
		&& rt.is_true(rt.call_function('preg_match', [rt.new_string('/([0-9]{2})-([0-9]{2})-([0-9]{2}) +([0-9]{2}):([0-9]{2})(AM|PM) +([0-9]+|<DIR>) +(.+)/'), var_line.clone(), var_lucifer.clone()])) {
		mut var_b := map[string]rt.PhpVal{}
		if rt.is_true(rt.less(var_lucifer.array_get(rt.new_int(3)), rt.new_int(70))) {
			var_lucifer.array_get(rt.new_int(3)) = rt.add(var_lucifer.array_get(rt.new_int(3)),
				rt.new_int(2000))
		} else {
			var_lucifer.array_get(rt.new_int(3)) = rt.add(var_lucifer.array_get(rt.new_int(3)),
				rt.new_int(1900))
		}
		var_b['isdir'] = rt.identical(rt.new_string('<DIR>'), var_lucifer.array_get(rt.new_int(7)))
		if rt.is_true(var_b['isdir']) {
			var_b['type'] = rt.new_string('d')
		} else {
			var_b['type'] = rt.new_string('f')
		}
		var_b['size'] = var_lucifer.array_get(rt.new_int(7))
		var_b['month'] = var_lucifer.array_get(rt.new_int(1))
		var_b['day'] = var_lucifer.array_get(rt.new_int(2))
		var_b['year'] = var_lucifer.array_get(rt.new_int(3))
		var_b['hour'] = var_lucifer.array_get(rt.new_int(4))
		var_b['minute'] = var_lucifer.array_get(rt.new_int(5))
		var_b['time'] = rt.call_function('mktime', [
			rt.add(var_lucifer.array_get(rt.new_int(4)), if rt.is_true(rt.identical(rt.call_function('strcasecmp', [
				var_lucifer.array_get(rt.new_int(6)),
				rt.new_string('PM'),
			]), rt.new_int(0)))
			{ 12 } else { 0 }),
			var_lucifer.array_get(rt.new_int(5)),
			rt.new_int(0),
			var_lucifer.array_get(rt.new_int(1)),
			var_lucifer.array_get(rt.new_int(2)),
			var_lucifer.array_get(rt.new_int(3)),
		])
		var_b['am/pm'] = var_lucifer.array_get(rt.new_int(6))
		var_b['name'] = var_lucifer.array_get(rt.new_int(8))
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_is_windows)))) {
		mut var_lucifer := rt.call_function('preg_split', [rt.new_string('/[ ]/'),
			var_line.clone(), rt.new_int(9), rt.get_constant('PREG_SPLIT_NO_EMPTY')])
		if rt.is_true(var_lucifer) {
			mut var_lcount := rt.new_int(var_lucifer.clone().array_count())
			if rt.is_true(rt.less(var_lcount, rt.new_int(8))) {
				return rt.new_string('')
			}
			var_b = map[string]rt.PhpVal{}
			var_b['isdir'] = rt.identical(rt.new_string('d'),
				var_lucifer.array_get(rt.new_int(0)).array_get(rt.new_int(0)))
			var_b['islink'] = rt.identical(rt.new_string('l'),
				var_lucifer.array_get(rt.new_int(0)).array_get(rt.new_int(0)))
			if rt.is_true(var_b['isdir']) {
				var_b['type'] = rt.new_string('d')
			} else if rt.is_true(var_b['islink']) {
				var_b['type'] = rt.new_string('l')
			} else {
				var_b['type'] = rt.new_string('f')
			}
			var_b['perms'] = var_lucifer.array_get(rt.new_int(0))
			var_b['permsn'] = this.getnumchmodfromh(var_b['perms'])
			var_b['number'] = var_lucifer.array_get(rt.new_int(1))
			var_b['owner'] = var_lucifer.array_get(rt.new_int(2))
			var_b['group'] = var_lucifer.array_get(rt.new_int(3))
			var_b['size'] = var_lucifer.array_get(rt.new_int(4))
			if rt.is_true(rt.identical(rt.new_int(8), var_lcount)) {
				rt.call_function('sscanf', [var_lucifer.array_get(rt.new_int(5)),
					rt.new_string('%d-%d-%d'), var_b['year'], var_b['month'], var_b['day']])
				rt.call_function('sscanf', [var_lucifer.array_get(rt.new_int(6)),
					rt.new_string('%d:%d'), var_b['hour'], var_b['minute']])
				var_b['time'] = rt.call_function('mktime', [var_b['hour'], var_b['minute'],
					rt.new_int(0), var_b['month'], var_b['day'], var_b['year']])
				var_b['name'] = var_lucifer.array_get(rt.new_int(7))
			} else {
				var_b['month'] = var_lucifer.array_get(rt.new_int(5))
				var_b['day'] = var_lucifer.array_get(rt.new_int(6))
				if rt.is_true(rt.call_function('preg_match', [
					rt.new_string('/([0-9]{2}):([0-9]{2})/'),
					var_lucifer.array_get(rt.new_int(7)),
					rt.create_array_from_list(var_l2),
				]))
				{
					var_b['year'] = rt.call_function('gmdate', [
						rt.new_string('Y')])
					var_b['hour'] = var_l2.array_get(rt.new_int(1))
					var_b['minute'] = var_l2.array_get(rt.new_int(2))
				} else {
					var_b['year'] = var_lucifer.array_get(rt.new_int(7))
					var_b['hour'] = rt.new_int(0)
					var_b['minute'] = rt.new_int(0)
				}
				var_b['time'] = rt.call_function('strtotime', [
					rt.call_function('sprintf', [rt.new_string('%d %s %d %02d:%02d'), var_b['day'],
						var_b['month'], var_b['year'], var_b['hour'], var_b['minute']]),
				])
				var_b['name'] = var_lucifer.array_get(rt.new_int(8))
			}
		}
	}
	if var_b.array_isset(rt.new_string('islink')) && rt.is_true(var_b['islink']) {
		var_b['name'] = rt.call_function('preg_replace', [
			rt.new_string('/(\\s*->\\s*.*)$/'),
			rt.new_string(''),
			var_b['name'],
		])
	}
	return var_b.clone()
}

fn (mut this Class_WP_Filesystem_FTPext) dirlist(path string, include_hidden bool, recursive bool) rt.PhpVal {
	mut path_mutated := path
	if this.is_file(rt.new_string(path_mutated)) {
		mut var_limit_file := rt.call_function('basename', [rt.new_string(path_mutated).clone()])
		path_mutated = (rt.call_function('dirname', [rt.new_string(path_mutated).clone()])).str() +
			'/'
	} else {
		var_limit_file = rt.new_bool(false)
	}
	mut var_pwd := rt.call_function('ftp_pwd', [this.link])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('ftp_chdir',
		[this.link, rt.new_string(path_mutated).clone()])))))
	{
		return rt.new_bool(false)
	}
	mut var_list := rt.call_function('ftp_rawlist', [this.link, rt.new_string('-a'),
		rt.new_bool(false)])
	rt.call_function('ftp_chdir', [this.link, var_pwd.clone()])
	if !rt.is_true(var_list) {
		return rt.new_bool(false)
	}
	mut var_dirlist := map[string]rt.PhpVal{}
	mut iter_3 := var_list.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_v := item_3.val
		mut var_k := item_3.key
		mut var_entry := this.parselisting(var_v.clone())
		if !rt.is_true(var_entry) {
			continue
		}
		if rt.is_true(rt.identical(rt.new_string('.'), var_entry.array_get(rt.new_string('name'))))
			|| rt.is_true(rt.identical(rt.new_string('..'), var_entry.array_get(rt.new_string('name')))) {
			continue
		}
		if !var_include_hidden
			&& rt.is_true(rt.identical(rt.new_string('.'), var_entry.array_get(rt.new_string('name')).array_get(rt.new_int(0)))) {
			continue
		}
		if rt.is_true(var_limit_file)
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_entry.array_get(rt.new_string('name')), var_limit_file)))) {
			continue
		}
		var_dirlist.array_set(var_entry.array_get(rt.new_string('name')), var_entry.clone())
	}
	path_mutated =
		(rt.call_function('trailingslashit', [rt.new_string(path_mutated).clone()])).str()
	mut var_ret := map[string]rt.PhpVal{}
	mut iter_4 := rt.cast_array(var_dirlist).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_struc := item_4.val
		if rt.is_true(rt.identical(rt.new_string('d'), var_struc.array_get(rt.new_string('type')))) {
			if var_recursive {
				var_struc.array_set('files', this.dirlist(path_mutated +
					(var_struc.array_get(rt.new_string('name'))).str(), include_hidden, recursive))
			} else {
				var_struc.array_set('files', map[string]rt.PhpVal{})
			}
		}
		var_ret.array_set(var_struc.array_get(rt.new_string('name')), var_struc.clone())
	}
	return var_ret.clone()
}

fn (mut this Class_WP_Filesystem_FTPext) magic_destruct() {
	if rt.is_true(this.link) {
		rt.call_function('ftp_close', [this.link])
	}
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
		link:          rt.new_null()
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
		else {
			return none
		}
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
		'link' {
			this.link = val
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

fn main() {
	defer {
		rt.shutdown()
	}
}
