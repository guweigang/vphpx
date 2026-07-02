import rt

struct Class_WP_Filesystem_SSH2 {
	rt.PhpObjectBase
pub mut:
	link      rt.PhpVal = rt.new_bool(false)
	sftp_link rt.PhpVal = rt.new_null()
	keys      bool
}

fn (mut this Class_WP_Filesystem_SSH2) construct(opt string) {
	this.dispatch_set_prop('method', rt.new_string('ssh2'))
	this.dispatch_set_prop('errors', create_wp_error())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('extension_loaded', [
		rt.new_string('ssh2'),
	])))))
	{
		rt.call_method(rt.get_property(rt.new_object('WP_Filesystem_SSH2', [
			'WP_Filesystem_Base',
		], &this), 'errors'), 'add', [rt.new_string('no_ssh2_ext'),
			rt.call_function('__', [
				rt.new_string('The ssh2 PHP extension is not available'),
			])])
		return
	}
	if !rt.is_true(rt.new_string(opt).array_get(rt.new_string('port'))) {
		rt.get_property(rt.new_object('WP_Filesystem_SSH2', ['WP_Filesystem_Base'], &this),
			'options').array_set('port', 22)
	} else {
		rt.get_property(rt.new_object('WP_Filesystem_SSH2', ['WP_Filesystem_Base'], &this),
			'options').array_set('port', rt.new_string(opt).array_get(rt.new_string('port')))
	}
	if !rt.is_true(rt.new_string(opt).array_get(rt.new_string('hostname'))) {
		rt.call_method(rt.get_property(rt.new_object('WP_Filesystem_SSH2', [
			'WP_Filesystem_Base',
		], &this), 'errors'), 'add', [rt.new_string('empty_hostname'),
			rt.call_function('__', [rt.new_string('SSH2 hostname is required')])])
	} else {
		rt.get_property(rt.new_object('WP_Filesystem_SSH2', ['WP_Filesystem_Base'], &this),
			'options').array_set('hostname',
			rt.new_string(opt).array_get(rt.new_string('hostname')))
	}
	if !(!rt.is_true(rt.new_string(opt).array_get(rt.new_string('public_key'))))
		&& !(!rt.is_true(rt.new_string(opt).array_get(rt.new_string('private_key')))) {
		rt.get_property(rt.new_object('WP_Filesystem_SSH2', ['WP_Filesystem_Base'], &this),
			'options').array_set('public_key',
			rt.new_string(opt).array_get(rt.new_string('public_key')))
		rt.get_property(rt.new_object('WP_Filesystem_SSH2', ['WP_Filesystem_Base'], &this),
			'options').array_set('private_key',
			rt.new_string(opt).array_get(rt.new_string('private_key')))
		rt.get_property(rt.new_object('WP_Filesystem_SSH2', ['WP_Filesystem_Base'], &this),
			'options').array_set('hostkey', rt.create_array([
			rt.ArrayItem{ key: 'hostkey', val: 'ssh-rsa,ssh-ed25519' },
		]))
		this.keys = true
	} else if !rt.is_true(rt.new_string(opt).array_get(rt.new_string('username'))) {
		rt.call_method(rt.get_property(rt.new_object('WP_Filesystem_SSH2', [
			'WP_Filesystem_Base',
		], &this), 'errors'), 'add', [rt.new_string('empty_username'),
			rt.call_function('__', [rt.new_string('SSH2 username is required')])])
	}
	if !(!rt.is_true(rt.new_string(opt).array_get(rt.new_string('username')))) {
		rt.get_property(rt.new_object('WP_Filesystem_SSH2', ['WP_Filesystem_Base'], &this),
			'options').array_set('username',
			rt.new_string(opt).array_get(rt.new_string('username')))
	}
	if !rt.is_true(rt.new_string(opt).array_get(rt.new_string('password'))) {
		if !(this.keys) {
			rt.call_method(rt.get_property(rt.new_object('WP_Filesystem_SSH2', [
				'WP_Filesystem_Base',
			], &this), 'errors'), 'add', [rt.new_string('empty_password'),
				rt.call_function('__', [rt.new_string('SSH2 password is required')])])
		} else {
			rt.get_property(rt.new_object('WP_Filesystem_SSH2', ['WP_Filesystem_Base'], &this),
				'options').array_set('password', rt.new_null())
		}
	} else {
		rt.get_property(rt.new_object('WP_Filesystem_SSH2', ['WP_Filesystem_Base'], &this),
			'options').array_set('password',
			rt.new_string(opt).array_get(rt.new_string('password')))
	}
}

fn (mut this Class_WP_Filesystem_SSH2) connect() bool {
	if !(this.keys) {
		this.link = rt.call_function('ssh2_connect', [
			rt.get_property(rt.new_object('WP_Filesystem_SSH2', ['WP_Filesystem_Base'], &this),
				'options').array_get(rt.new_string('hostname')),
			rt.get_property(rt.new_object('WP_Filesystem_SSH2', ['WP_Filesystem_Base'], &this),
				'options').array_get(rt.new_string('port')),
		])
	} else {
		this.link = rt.call_function('ssh2_connect', [
			rt.get_property(rt.new_object('WP_Filesystem_SSH2', ['WP_Filesystem_Base'], &this),
				'options').array_get(rt.new_string('hostname')),
			rt.get_property(rt.new_object('WP_Filesystem_SSH2', ['WP_Filesystem_Base'], &this),
				'options').array_get(rt.new_string('port')),
			rt.get_property(rt.new_object('WP_Filesystem_SSH2', ['WP_Filesystem_Base'], &this),
				'options').array_get(rt.new_string('hostkey')),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.link)))) {
		rt.call_method(rt.get_property(rt.new_object('WP_Filesystem_SSH2', [
			'WP_Filesystem_Base',
		], &this), 'errors'), 'add', [rt.new_string('connect'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Failed to connect to SSH2 Server %s'),
				]),
				rt.new_string(
					(rt.get_property(rt.new_object('WP_Filesystem_SSH2', ['WP_Filesystem_Base'], &this), 'options').array_get(rt.new_string('hostname'))).str() +
					':' +(rt.get_property(rt.new_object('WP_Filesystem_SSH2', ['WP_Filesystem_Base'], &this), 'options').array_get(rt.new_string('port'))).str()),
			])])
		return false
	}
	if !(this.keys) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('ssh2_auth_password', [
			this.link,
			rt.get_property(rt.new_object('WP_Filesystem_SSH2', ['WP_Filesystem_Base'], &this),
				'options').array_get(rt.new_string('username')),
			rt.get_property(rt.new_object('WP_Filesystem_SSH2', ['WP_Filesystem_Base'], &this),
				'options').array_get(rt.new_string('password')),
		])))))
		{
			rt.call_method(rt.get_property(rt.new_object('WP_Filesystem_SSH2', [
				'WP_Filesystem_Base',
			], &this), 'errors'), 'add', [rt.new_string('auth'),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Username/Password incorrect for %s'),
					]),
					rt.get_property(rt.new_object('WP_Filesystem_SSH2', [
						'WP_Filesystem_Base',
					], &this), 'options').array_get(rt.new_string('username')),
				])])
			return false
		}
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('ssh2_auth_pubkey_file', [
			this.link,
			rt.get_property(rt.new_object('WP_Filesystem_SSH2', ['WP_Filesystem_Base'], &this),
				'options').array_get(rt.new_string('username')),
			rt.get_property(rt.new_object('WP_Filesystem_SSH2', ['WP_Filesystem_Base'], &this),
				'options').array_get(rt.new_string('public_key')),
			rt.get_property(rt.new_object('WP_Filesystem_SSH2', ['WP_Filesystem_Base'], &this),
				'options').array_get(rt.new_string('private_key')),
			rt.get_property(rt.new_object('WP_Filesystem_SSH2', ['WP_Filesystem_Base'], &this),
				'options').array_get(rt.new_string('password')),
		])))))
		{
			rt.call_method(rt.get_property(rt.new_object('WP_Filesystem_SSH2', [
				'WP_Filesystem_Base',
			], &this), 'errors'), 'add', [rt.new_string('auth'),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Public and Private keys incorrect for %s'),
					]),
					rt.get_property(rt.new_object('WP_Filesystem_SSH2', [
						'WP_Filesystem_Base',
					], &this), 'options').array_get(rt.new_string('username')),
				])])
			return false
		}
	}
	this.sftp_link = rt.call_function('ssh2_sftp', [this.link])
	if rt.is_true(rt.new_bool(!(rt.is_true(this.sftp_link)))) {
		rt.call_method(rt.get_property(rt.new_object('WP_Filesystem_SSH2', [
			'WP_Filesystem_Base',
		], &this), 'errors'), 'add', [rt.new_string('connect'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Failed to initialize a SFTP subsystem session with the SSH2 Server %s'),
				]),
				rt.new_string(
					(rt.get_property(rt.new_object('WP_Filesystem_SSH2', ['WP_Filesystem_Base'], &this), 'options').array_get(rt.new_string('hostname'))).str() +
					':' +(rt.get_property(rt.new_object('WP_Filesystem_SSH2', ['WP_Filesystem_Base'], &this), 'options').array_get(rt.new_string('port'))).str()),
			])])
		return false
	}
	return true
}

fn (mut this Class_WP_Filesystem_SSH2) sftp_path(var_path rt.PhpVal) string {
	mut var_path_mutated := var_path
	if rt.is_true(rt.identical(rt.new_string('/'), var_path_mutated)) {
		var_path_mutated = rt.new_string('/./')
	}
	return 'ssh2.sftp://' +
		(this.sftp_link).str() + '/' + var_path_mutated.clone().to_string().trim_left(' \t\n\r')
}

fn (mut this Class_WP_Filesystem_SSH2) run_command(var_command rt.PhpVal, returnbool bool) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.link)))) {
		return false
	}
	mut var_stream := rt.call_function('ssh2_exec', [this.link, var_command.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_stream)))) {
		rt.call_method(rt.get_property(rt.new_object('WP_Filesystem_SSH2', [
			'WP_Filesystem_Base',
		], &this), 'errors'), 'add', [rt.new_string('command'),
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Unable to perform command: %s')]),
				var_command.clone(),
			])])
	} else {
		rt.call_function('stream_set_blocking', [var_stream.clone(),
			rt.new_bool(true)])
		rt.call_function('stream_set_timeout', [var_stream.clone(),
			rt.get_constant('FS_TIMEOUT')])
		mut var_data := rt.call_function('stream_get_contents', [
			var_stream.clone()])
		rt.call_function('fclose', [var_stream.clone()])
		if var_returnbool {
			return if rt.is_true(rt.identical(rt.new_bool(false), var_data)) {
				false
			} else {
				rt.new_bool('' != var_data.clone().to_string().trim_space())
			}
		} else {
			return var_data.to_bool()
		}
	}
	return false
}

fn (mut this Class_WP_Filesystem_SSH2) get_contents(var_file rt.PhpVal) rt.PhpVal {
	return rt.call_function('file_get_contents', [
		rt.new_string(this.sftp_path(var_file.clone())),
	])
}

fn (mut this Class_WP_Filesystem_SSH2) get_contents_array(var_file rt.PhpVal) rt.PhpVal {
	return rt.call_function('file', [rt.new_string(this.sftp_path(var_file.clone()))])
}

fn (mut this Class_WP_Filesystem_SSH2) put_contents(var_file rt.PhpVal, var_contents rt.PhpVal, mode bool) bool {
	mut mode_mutated := mode
	mut var_ret := rt.call_function('file_put_contents', [
		rt.new_string(this.sftp_path(var_file.clone())),
		var_contents.clone(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(var_contents.clone().to_string().len),
		var_ret))))
	{
		return false
	}
	this.chmod(var_file.clone(), mode_mutated, false)
	return true
}

fn (mut this Class_WP_Filesystem_SSH2) cwd() rt.PhpVal {
	mut var_cwd := rt.call_function('ssh2_sftp_realpath', [this.sftp_link, rt.new_string('.')])
	if rt.is_true(var_cwd) {
		var_cwd = rt.call_function('trailingslashit', [
			rt.new_string(var_cwd.clone().to_string().trim_space()),
		])
	}
	return var_cwd.clone()
}

fn (mut this Class_WP_Filesystem_SSH2) chdir(var_dir rt.PhpVal) rt.PhpVal {
	mut var_dir_mutated := var_dir
	return rt.new_bool(this.run_command(rt.new_string('cd ' + var_dir_mutated.str()), true))
}

fn (mut this Class_WP_Filesystem_SSH2) chgrp(var_file rt.PhpVal, var_group rt.PhpVal, recursive bool) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.exists(var_file.clone()))))) {
		return false
	}
	if !var_recursive || rt.is_true(rt.new_bool(!(rt.is_true(this.is_dir(var_file.clone()))))) {
		return this.run_command(rt.call_function('sprintf', [
			rt.new_string('chgrp %s %s'),
			rt.call_function('escapeshellarg', [var_group.clone()]),
			rt.call_function('escapeshellarg', [var_file.clone()]),
		]), true)
	}
	return this.run_command(rt.call_function('sprintf', [rt.new_string('chgrp -R %s %s'),
		rt.call_function('escapeshellarg', [var_group.clone()]),
		rt.call_function('escapeshellarg', [var_file.clone()])]), true)
}

fn (mut this Class_WP_Filesystem_SSH2) chmod(var_file rt.PhpVal, mode bool, recursive bool) bool {
	mut mode_mutated := mode
	if rt.is_true(rt.new_bool(!(rt.is_true(this.exists(var_file.clone()))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(mode_mutated))))) {
		if rt.is_true(this.is_file(var_file.clone())) {
			mode_mutated = (rt.get_constant('FS_CHMOD_FILE')).to_bool()
		} else if rt.is_true(this.is_dir(var_file.clone())) {
			mode_mutated = (rt.get_constant('FS_CHMOD_DIR')).to_bool()
		} else {
			return false
		}
	}
	if !var_recursive || rt.is_true(rt.new_bool(!(rt.is_true(this.is_dir(var_file.clone()))))) {
		return this.run_command(rt.call_function('sprintf', [
			rt.new_string('chmod %o %s'),
			rt.new_bool(mode_mutated).clone(),
			rt.call_function('escapeshellarg', [var_file.clone()]),
		]), true)
	}
	return this.run_command(rt.call_function('sprintf', [rt.new_string('chmod -R %o %s'),
		rt.new_bool(mode_mutated).clone(), rt.call_function('escapeshellarg', [
			var_file.clone()])]),
		true)
}

fn (mut this Class_WP_Filesystem_SSH2) chown(var_file rt.PhpVal, var_owner rt.PhpVal, recursive bool) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.exists(var_file.clone()))))) {
		return false
	}
	if !var_recursive || rt.is_true(rt.new_bool(!(rt.is_true(this.is_dir(var_file.clone()))))) {
		return this.run_command(rt.call_function('sprintf', [
			rt.new_string('chown %s %s'),
			rt.call_function('escapeshellarg', [var_owner.clone()]),
			rt.call_function('escapeshellarg', [var_file.clone()]),
		]), true)
	}
	return this.run_command(rt.call_function('sprintf', [rt.new_string('chown -R %s %s'),
		rt.call_function('escapeshellarg', [var_owner.clone()]),
		rt.call_function('escapeshellarg', [var_file.clone()])]), true)
}

fn (mut this Class_WP_Filesystem_SSH2) owner(var_file rt.PhpVal) bool {
	mut var_owneruid := rt.call_function('fileowner', [
		rt.new_string(this.sftp_path(var_file.clone())),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_owneruid)))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('posix_getpwuid'),
	])))))
	{
		return var_owneruid.to_bool()
	}
	mut var_ownerarray := rt.call_function('posix_getpwuid', [
		var_owneruid.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_ownerarray)))) {
		return false
	}
	return (var_ownerarray.array_get(rt.new_string('name'))).to_bool()
}

fn (mut this Class_WP_Filesystem_SSH2) getchmod(var_file rt.PhpVal) rt.PhpVal {
	return rt.call_function('substr', [
		rt.call_function('decoct', [
			rt.call_function('fileperms', [
				rt.new_string(this.sftp_path(var_file.clone())),
			]),
		]),
		rt.new_int(-3),
	])
}

fn (mut this Class_WP_Filesystem_SSH2) group(var_file rt.PhpVal) bool {
	mut var_gid := rt.call_function('filegroup', [
		rt.new_string(this.sftp_path(var_file.clone())),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_gid)))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('posix_getgrgid'),
	])))))
	{
		return var_gid.to_bool()
	}
	mut var_grouparray := rt.call_function('posix_getgrgid', [
		var_gid.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_grouparray)))) {
		return false
	}
	return (var_grouparray.array_get(rt.new_string('name'))).to_bool()
}

fn (mut this Class_WP_Filesystem_SSH2) copy(var_source rt.PhpVal, var_destination rt.PhpVal, overwrite bool, mode bool) bool {
	mut mode_mutated := mode
	if !var_overwrite && rt.is_true(this.exists(var_destination.clone())) {
		return false
	}
	mut var_content := this.get_contents(var_source.clone())
	if rt.is_true(rt.identical(rt.new_bool(false), var_content)) {
		return false
	}
	return this.put_contents(var_destination.clone(), var_content.clone(), mode_mutated)
}

fn (mut this Class_WP_Filesystem_SSH2) move(var_source rt.PhpVal, var_destination rt.PhpVal, overwrite bool) bool {
	if rt.is_true(this.exists(var_destination.clone())) {
		if var_overwrite {
			this.delete(var_destination.clone(), false, 'f')
		} else {
			return false
		}
	}
	return (rt.call_function('ssh2_sftp_rename', [this.sftp_link, var_source.clone(),
		var_destination.clone()])).to_bool()
}

fn (mut this Class_WP_Filesystem_SSH2) delete(var_file rt.PhpVal, recursive bool, type bool) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('f'), rt.new_bool(type)))
		|| rt.is_true(this.is_file(var_file.clone())) {
		return rt.call_function('ssh2_sftp_unlink', [this.sftp_link, var_file.clone()])
	}
	if !var_recursive {
		return rt.call_function('ssh2_sftp_rmdir', [this.sftp_link, var_file.clone()])
	}
	mut var_filelist := this.dirlist(var_file.clone(), false, false)
	if rt.is_true(rt.new_bool(var_filelist.clone().is_array())) {
		mut iter_1 := var_filelist.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_fileinfo := item_1.val
			mut var_filename := item_1.key
			this.delete(rt.new_string(var_file.str() + '/' + var_filename.str()), recursive,
				(var_fileinfo.array_get(rt.new_string('type'))).to_bool())
		}
	}
	return rt.call_function('ssh2_sftp_rmdir', [this.sftp_link, var_file.clone()])
}

fn (mut this Class_WP_Filesystem_SSH2) exists(var_path rt.PhpVal) rt.PhpVal {
	mut var_path_mutated := var_path
	return rt.call_function('file_exists', [
		rt.new_string(this.sftp_path(var_path_mutated.clone())),
	])
}

fn (mut this Class_WP_Filesystem_SSH2) is_file(var_file rt.PhpVal) rt.PhpVal {
	return rt.call_function('is_file', [rt.new_string(this.sftp_path(var_file.clone()))])
}

fn (mut this Class_WP_Filesystem_SSH2) is_dir(var_path rt.PhpVal) rt.PhpVal {
	mut var_path_mutated := var_path
	return rt.call_function('is_dir', [
		rt.new_string(this.sftp_path(var_path_mutated.clone())),
	])
}

fn (mut this Class_WP_Filesystem_SSH2) is_readable(var_file rt.PhpVal) rt.PhpVal {
	return rt.call_function('is_readable', [
		rt.new_string(this.sftp_path(var_file.clone())),
	])
}

fn (mut this Class_WP_Filesystem_SSH2) is_writable(var_path rt.PhpVal) bool {
	mut var_path_mutated := var_path
	return true
}

fn (mut this Class_WP_Filesystem_SSH2) atime(var_file rt.PhpVal) rt.PhpVal {
	return rt.call_function('fileatime', [
		rt.new_string(this.sftp_path(var_file.clone())),
	])
}

fn (mut this Class_WP_Filesystem_SSH2) mtime(var_file rt.PhpVal) rt.PhpVal {
	return rt.call_function('filemtime', [
		rt.new_string(this.sftp_path(var_file.clone())),
	])
}

fn (mut this Class_WP_Filesystem_SSH2) size(var_file rt.PhpVal) rt.PhpVal {
	return rt.call_function('filesize', [rt.new_string(this.sftp_path(var_file.clone()))])
}

fn (mut this Class_WP_Filesystem_SSH2) touch(var_file rt.PhpVal, time i64, atime i64) bool {
	return false
}

fn (mut this Class_WP_Filesystem_SSH2) mkdir(var_path rt.PhpVal, chmod bool, chown bool, chgrp bool) bool {
	mut var_path_mutated := var_path
	mut chmod_mutated := chmod
	var_path_mutated = rt.call_function('untrailingslashit', [
		var_path_mutated.clone()])
	if !rt.is_true(var_path_mutated) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(chmod_mutated))))) {
		chmod_mutated = (rt.get_constant('FS_CHMOD_DIR')).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('ssh2_sftp_mkdir', [
		this.sftp_link,
		var_path_mutated.clone(),
		rt.new_bool(chmod_mutated).clone(),
		rt.new_bool(true),
	])))))
	{
		return false
	}
	rt.call_function('ssh2_sftp_chmod', [this.sftp_link, var_path_mutated.clone(),
		rt.new_bool(chmod_mutated).clone()])
	if var_chown {
		this.chown(var_path_mutated.clone(), rt.new_bool(chown), false)
	}
	if var_chgrp {
		this.chgrp(var_path_mutated.clone(), rt.new_bool(chgrp), false)
	}
	return true
}

fn (mut this Class_WP_Filesystem_SSH2) rmdir(var_path rt.PhpVal, recursive bool) rt.PhpVal {
	mut var_path_mutated := var_path
	return this.delete(var_path_mutated.clone(), recursive, false)
}

fn (mut this Class_WP_Filesystem_SSH2) dirlist(var_path rt.PhpVal, include_hidden bool, recursive bool) rt.PhpVal {
	mut var_path_mutated := var_path
	if rt.is_true(this.is_file(var_path_mutated.clone())) {
		mut var_limit_file := rt.call_function('basename', [var_path_mutated.clone()])
		var_path_mutated = rt.call_function('dirname', [var_path_mutated.clone()])
	} else {
		var_limit_file = rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_dir(var_path_mutated.clone())))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(this.is_readable(var_path_mutated.clone()))))) {
		return rt.new_bool(false)
	}
	mut var_ret := rt.new_array()
	mut var_dir := rt.call_function('dir', [
		rt.new_string(this.sftp_path(var_path_mutated.clone())),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_dir)))) {
		return rt.new_bool(false)
	}
	var_path_mutated = rt.call_function('trailingslashit', [var_path_mutated.clone()])
	mut var_entry := rt.call_method(var_dir, 'read', []rt.PhpVal{})
	for rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_entry)))) {
		mut var_struc := rt.new_array()
		var_struc['name'] = var_entry.clone()
		if rt.is_true(rt.identical(rt.new_string('.'), var_struc['name']))
			|| rt.is_true(rt.identical(rt.new_string('..'), var_struc['name'])) {
			continue
		}
		if !var_include_hidden
			&& rt.is_true(rt.identical(rt.new_string('.'), var_struc['name'].array_get(rt.new_int(0)))) {
			continue
		}
		if rt.is_true(var_limit_file)
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_struc['name'], var_limit_file)))) {
			continue
		}
		var_struc['perms'] = this.gethchmod(rt.new_string(var_path_mutated.str() + var_entry.str()))
		var_struc['permsn'] = this.getnumchmodfromh(var_struc['perms'])
		var_struc['number'] = rt.new_bool(false)
		var_struc['owner'] = this.owner(rt.new_string(var_path_mutated.str() + var_entry.str()))
		var_struc['group'] = this.group(rt.new_string(var_path_mutated.str() + var_entry.str()))
		var_struc['size'] = this.size(rt.new_string(var_path_mutated.str() + var_entry.str()))
		var_struc['lastmodunix'] =
			this.mtime(rt.new_string(var_path_mutated.str() + var_entry.str()))
		var_struc['lastmod'] = rt.call_function('gmdate',
			[rt.new_string('M j'), var_struc['lastmodunix']])
		var_struc['time'] = rt.call_function('gmdate',
			[rt.new_string('h:i:s'), var_struc['lastmodunix']])
		var_struc['type'] = if rt.is_true(this.is_dir(rt.new_string(var_path_mutated.str() +
			var_entry.str())))
		{
			'd'
		} else {
			'f'
		}
		if rt.is_true(rt.identical(rt.new_string('d'), var_struc['type'])) {
			if var_recursive {
				var_struc['files'] = this.dirlist(rt.new_string(var_path_mutated.str() +
					(var_struc['name']).str()), include_hidden, recursive)
			} else {
				var_struc['files'] = rt.new_array()
			}
		}
		var_ret.array_set(var_struc['name'], var_struc.clone())
	}
	rt.call_method(var_dir, 'close', []rt.PhpVal{})
	var_dir = rt.new_null()
	return var_ret.clone()
}

struct Class_WP_Filesystem_Base {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_filesystem_ssh2(opt string) &Class_WP_Filesystem_SSH2 {
	mut obj := &Class_WP_Filesystem_SSH2{
		PhpObjectBase: rt.PhpObjectBase{}
		link:          rt.new_bool(false)
		sftp_link:     rt.new_null()
		keys:          false
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

fn (mut this Class_WP_Filesystem_SSH2) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'connect' {
			return rt.new_bool(this.connect())
		}
		'sftp_path' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.sftp_path(dispatch_arg_0))
		}
		'run_command' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.run_command(dispatch_arg_0, dispatch_arg_1))
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
			return this.getchmod(dispatch_arg_0)
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
			return rt.new_bool(this.copy(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3))
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
			return this.delete(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
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
			return rt.new_bool(this.is_writable(dispatch_arg_0))
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
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.dirlist(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Filesystem_SSH2) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'link' { return this.link }
		'sftp_link' { return this.sftp_link }
		'keys' { return rt.new_bool(this.keys) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Filesystem_SSH2) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'link' {
			this.link = val
			return true
		}
		'sftp_link' {
			this.sftp_link = val
			return true
		}
		'keys' {
			this.keys = val.to_bool()
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
