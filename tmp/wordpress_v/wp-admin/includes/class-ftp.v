import rt

const global_const_ftp_os_unix = 'u'
const global_const_ftp_os_windows = 'w'
const global_const_ftp_os_mac = 'm'
struct Class_ftp_base {
	rt.PhpObjectBase
pub mut:
		LocalEcho rt.PhpVal = rt.new_null()
		Verbose bool
		OS_local string
		OS_remote string
		_lastaction rt.PhpVal = rt.new_null()
		_errors rt.PhpVal = rt.new_null()
		_type rt.PhpVal = rt.new_null()
		_umask rt.PhpVal = rt.new_null()
		_timeout rt.PhpVal = rt.new_null()
		_passive rt.PhpVal = rt.new_null()
		_host rt.PhpVal = rt.new_null()
		_fullhost rt.PhpVal = rt.new_null()
		_port rt.PhpVal = rt.new_null()
		_datahost rt.PhpVal = rt.new_null()
		_dataport rt.PhpVal = rt.new_null()
		_ftp_control_sock rt.PhpVal = rt.new_null()
		_ftp_data_sock rt.PhpVal = rt.new_null()
		_ftp_temp_sock rt.PhpVal = rt.new_null()
		_ftp_buff_size i64
		_login rt.PhpVal = rt.new_null()
		_password rt.PhpVal = rt.new_null()
		_connected bool
		_ready bool
		_code i64
		_message string
		_can_restore bool
		_port_available bool
		_curtype rt.PhpVal = rt.new_null()
		_features rt.PhpVal = rt.new_null()
		_error_array rt.PhpVal = rt.new_null()
		AuthorizedTransferMode rt.PhpVal = rt.new_null()
		OS_FullName rt.PhpVal = rt.new_null()
		_eol_code rt.PhpVal = rt.new_null()
		AutoAsciiExt rt.PhpVal = rt.new_null()
}

fn (mut this Class_ftp_base) construct(port_mode bool, verb bool, le bool)  {
	this.LocalEcho = rt.new_bool(le).dup()
	this.Verbose = verb
	this._lastaction = rt.new_null()
	this._error_array = rt.new_array()
	this._eol_code = rt.create_array([rt.ArrayItem{ key: global_const_ftp_os_unix, val: '\n' }, rt.ArrayItem{ key: global_const_ftp_os_mac, val: '\r' }, rt.ArrayItem{ key: global_const_ftp_os_windows, val: '\r\n' }])
	this.AuthorizedTransferMode = rt.create_array([rt.ArrayItem{ key: none, val: rt.get_constant('FTP_AUTOASCII') }, rt.ArrayItem{ key: none, val: rt.get_constant('FTP_ASCII') }, rt.ArrayItem{ key: none, val: rt.get_constant('FTP_BINARY') }])
	this.OS_FullName = rt.create_array([rt.ArrayItem{ key: global_const_ftp_os_unix, val: 'UNIX' }, rt.ArrayItem{ key: global_const_ftp_os_windows, val: 'WINDOWS' }, rt.ArrayItem{ key: global_const_ftp_os_mac, val: 'MACOS' }])
	this.AutoAsciiExt = rt.create_array([rt.ArrayItem{ key: none, val: 'ASP' }, rt.ArrayItem{ key: none, val: 'BAT' }, rt.ArrayItem{ key: none, val: 'C' }, rt.ArrayItem{ key: none, val: 'CPP' }, rt.ArrayItem{ key: none, val: 'CSS' }, rt.ArrayItem{ key: none, val: 'CSV' }, rt.ArrayItem{ key: none, val: 'JS' }, rt.ArrayItem{ key: none, val: 'H' }, rt.ArrayItem{ key: none, val: 'HTM' }, rt.ArrayItem{ key: none, val: 'HTML' }, rt.ArrayItem{ key: none, val: 'SHTML' }, rt.ArrayItem{ key: none, val: 'INI' }, rt.ArrayItem{ key: none, val: 'LOG' }, rt.ArrayItem{ key: none, val: 'PHP3' }, rt.ArrayItem{ key: none, val: 'PHTML' }, rt.ArrayItem{ key: none, val: 'PL' }, rt.ArrayItem{ key: none, val: 'PERL' }, rt.ArrayItem{ key: none, val: 'SH' }, rt.ArrayItem{ key: none, val: 'SQL' }, rt.ArrayItem{ key: none, val: 'TXT' }])
	this._port_available = rt.equal(rt.new_bool(port_mode), rt.new_bool(true))
	this.sendmsg('Staring FTP client class' + if rt.is_true(this._port_available) { '' } else { ' without PORT mode support' }, false)
	this._connected = false
	this._ready = false
	this._can_restore = false
	this._code = 0
	this._message = ''
	this._ftp_buff_size = 4096
	this._curtype = rt.new_null()
	this.setumask(18)
	this.settype(rt.get_constant('FTP_AUTOASCII'))
	this.settimeout(30)
	this.passive(rt.new_bool(!(rt.is_true(this._port_available))))
	this._login = rt.new_string('anonymous')
	this._password = rt.new_string('anon@ftp.com')
	this._features = rt.new_array()
	this.OS_local = global_const_ftp_os_unix
	this.OS_remote = global_const_ftp_os_unix
	if rt.is_true(rt.identical(rt.new_string(rt.call_function('substr', [rt.get_constant('PHP_OS'), rt.new_int(0), rt.new_int(3)]).to_string().to_upper()), rt.new_string('WIN'))) {
		this.OS_local = global_const_ftp_os_windows
	} else if rt.is_true(rt.identical(rt.new_string(rt.call_function('substr', [rt.get_constant('PHP_OS'), rt.new_int(0), rt.new_int(3)]).to_string().to_upper()), rt.new_string('MAC'))) {
		this.OS_local = global_const_ftp_os_mac
	}
}

fn (mut this Class_ftp_base) ftp_base(port_mode bool)  {
	this.construct(port_mode, false, false)
}

fn (mut this Class_ftp_base) parselisting(var_line rt.PhpVal) rt.PhpVal {
	mut var_l2 := []rt.PhpVal{}
	mut var_is_windows := rt.equal(this.OS_remote, rt.new_string(global_const_ftp_os_windows))
	if rt.is_true(rt.new_bool(rt.is_true(var_is_windows) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/([0-9]{2})-([0-9]{2})-([0-9]{2}) +([0-9]{2}):([0-9]{2})(AM|PM) +([0-9]+|<DIR>) +(.+)/'), var_line.dup(), var_lucifer.dup()])))) {
		mut var_b := rt.new_array()
		if rt.is_true(rt.less(var_lucifer.array_get(3), rt.new_int(70))) {
			// unsupported expression: Expr_AssignOp_Plus
		} else {
			// unsupported expression: Expr_AssignOp_Plus
		}
		var_b['isdir'] = rt.equal(var_lucifer.array_get(7), rt.new_string('<DIR>'))
		if rt.is_true(var_b.array_get('isdir')) {
			var_b['type'] = rt.new_string('d')
		} else {
			var_b['type'] = rt.new_string('f')
		}
		var_b['size'] = var_lucifer.array_get(7)
		var_b['month'] = var_lucifer.array_get(1)
		var_b['day'] = var_lucifer.array_get(2)
		var_b['year'] = var_lucifer.array_get(3)
		var_b['hour'] = var_lucifer.array_get(4)
		var_b['minute'] = var_lucifer.array_get(5)
		var_b['time'] = rt.call_function('mktime', [rt.add(var_lucifer.array_get(4), if rt.is_true(rt.equal(rt.call_function('strcasecmp', [var_lucifer.array_get(6), rt.new_string('PM')]), rt.new_int(0))) { rt.new_int(12) } else { rt.new_int(0) }), var_lucifer.array_get(5), rt.new_int(0), var_lucifer.array_get(1), var_lucifer.array_get(2), var_lucifer.array_get(3)])
		var_b['am/pm'] = var_lucifer.array_get(6)
		var_b['name'] = var_lucifer.array_get(8)
	} else {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_is_windows)))) && rt.is_true(mut var_lucifer := rt.call_function('preg_split', [rt.new_string('/[ ]/'), var_line.dup(), rt.new_int(9), rt.get_constant('PREG_SPLIT_NO_EMPTY')])))) {
			mut var_lcount := rt.new_int(rt.new_int(var_lucifer.dup().array_count()))
			if rt.is_true(rt.less(var_lcount, rt.new_int(8))) {
				return rt.new_string('')
			}
			var_b = rt.new_array()
			var_b['isdir'] = rt.identical(var_lucifer.array_get(0).array_get(0), rt.new_string('d'))
			var_b['islink'] = rt.identical(var_lucifer.array_get(0).array_get(0), rt.new_string('l'))
			if rt.is_true(var_b.array_get('isdir')) {
				var_b['type'] = rt.new_string('d')
			} else if rt.is_true(var_b.array_get('islink')) {
				var_b['type'] = rt.new_string('l')
			} else {
				var_b['type'] = rt.new_string('f')
			}
			var_b['perms'] = var_lucifer.array_get(0)
			var_b['number'] = var_lucifer.array_get(1)
			var_b['owner'] = var_lucifer.array_get(2)
			var_b['group'] = var_lucifer.array_get(3)
			var_b['size'] = var_lucifer.array_get(4)
			if rt.is_true(rt.equal(var_lcount, rt.new_int(8))) {
				rt.call_function('sscanf', [var_lucifer.array_get(5), rt.new_string('%d-%d-%d'), var_b.array_get('year'), var_b.array_get('month'), var_b.array_get('day')])
				rt.call_function('sscanf', [var_lucifer.array_get(6), rt.new_string('%d:%d'), var_b.array_get('hour'), var_b.array_get('minute')])
				var_b['time'] = rt.call_function('mktime', [var_b.array_get('hour'), var_b.array_get('minute'), rt.new_int(0), var_b.array_get('month'), var_b.array_get('day'), var_b.array_get('year')])
				var_b['name'] = var_lucifer.array_get(7)
			} else {
				var_b['month'] = var_lucifer.array_get(5)
				var_b['day'] = var_lucifer.array_get(6)
				if rt.is_true(rt.call_function('preg_match', [rt.new_string('/([0-9]{2}):([0-9]{2})/'), var_lucifer.array_get(7), var_l2.dup()])) {
					var_b['year'] = rt.call_function('gmdate', [rt.new_string('Y')])
					var_b['hour'] = var_l2.array_get(1)
					var_b['minute'] = var_l2.array_get(2)
				} else {
					var_b['year'] = var_lucifer.array_get(7)
					var_b['hour'] = rt.new_int(0)
					var_b['minute'] = rt.new_int(0)
				}
				var_b['time'] = rt.call_function('strtotime', [rt.call_function('sprintf', [rt.new_string('%d %s %d %02d:%02d'), var_b.array_get('day'), var_b.array_get('month'), var_b.array_get('year'), var_b.array_get('hour'), var_b.array_get('minute')])])
				var_b['name'] = var_lucifer.array_get(8)
			}
		}
	}
	return var_b.dup()
}

fn (mut this Class_ftp_base) sendmsg(message string, crlf bool) bool {
	if rt.is_true(this.Verbose) {
		print(message + (if var_crlf { rt.get_constant('CRLF') } else { rt.new_string('') }).str())
		rt.call_function('flush', []rt.PhpVal{})
	}
	return true
}

fn (mut this Class_ftp_base) settype(var_mode rt.PhpVal) bool {
	mut var_mode_mutated := var_mode
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_mode_mutated.dup(), this.AuthorizedTransferMode]))))) {
		this.sendmsg('Wrong type', false)
		return false
	}
	this._type = var_mode_mutated.dup()
	this.sendmsg('Transfer type: ' + if rt.is_true(rt.equal(this._type, rt.get_constant('FTP_BINARY'))) { 'binary' } else { if rt.is_true(rt.equal(this._type, rt.get_constant('FTP_ASCII'))) { 'ASCII' } else { 'auto ASCII' } }, false)
	return true
}

fn (mut this Class_ftp_base) _settype(var_mode rt.PhpVal) bool {
	mut var_mode_mutated := var_mode
	if rt.is_true(this._ready) {
		if rt.is_true(rt.equal(var_mode_mutated, rt.get_constant('FTP_BINARY'))) {
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
				if rt.is_true(rt.new_bool(!(rt.is_true(this._exec(rt.new_string('TYPE I'), rt.new_string('SetType')))))) {
					return false
				}
				this._curtype = rt.get_constant('FTP_BINARY')
			}
		} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
			if rt.is_true(rt.new_bool(!(rt.is_true(this._exec(rt.new_string('TYPE A'), rt.new_string('SetType')))))) {
				return false
			}
			this._curtype = rt.get_constant('FTP_ASCII')
		}
	} else {
		return false
	}
	return true
}

fn (mut this Class_ftp_base) passive(var_pasv rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(var_pasv.dup().is_null())) {
		this._passive = rt.new_bool(!(rt.is_true()))
	} else {
		this._passive = .dup()
	}
	if rt.is_true(rt.new_bool(rt.is_true() && rt.is_true())) {
		
	}
	
}

fn (mut this Class_ftp_base) setserver(var_host rt.PhpVal, port i64, reconnect bool) bool {
}

fn (mut this Class_ftp_base) setumask(umask i64) bool {
}

fn (mut this Class_ftp_base) settimeout(timeout i64) bool {
}

fn (mut this Class_ftp_base) connect(var_server rt.PhpVal) bool {
}

fn (mut this Class_ftp_base) quit(force bool) bool {
}

fn (mut this Class_ftp_base) login(var_user rt.PhpVal, var_pass rt.PhpVal) bool {
}

fn (mut this Class_ftp_base) pwd() bool {
}

fn (mut this Class_ftp_base) cdup() bool {
}

fn (mut this Class_ftp_base) chdir(var_pathname rt.PhpVal) bool {
}

fn (mut this Class_ftp_base) rmdir(var_pathname rt.PhpVal) bool {
}

fn (mut this Class_ftp_base) mkdir(var_pathname rt.PhpVal) bool {
}

fn (mut this Class_ftp_base) rename(var_from rt.PhpVal, var_to rt.PhpVal) bool {
}

fn (mut this Class_ftp_base) filesize(var_pathname rt.PhpVal) bool {
}

fn (mut this Class_ftp_base) abort() bool {
}

fn (mut this Class_ftp_base) mdtm(var_pathname rt.PhpVal) bool {
}

fn (mut this Class_ftp_base) systype() rt.PhpVal {
}

fn (mut this Class_ftp_base) delete(var_pathname rt.PhpVal) bool {
}

fn (mut this Class_ftp_base) site(var_command rt.PhpVal, fnction string) bool {
}

fn (mut this Class_ftp_base) chmod(var_pathname rt.PhpVal, var_mode rt.PhpVal) bool {
	mut var_mode_mutated := var_mode
}

fn (mut this Class_ftp_base) restore(var_from rt.PhpVal) bool {
}

fn (mut this Class_ftp_base) features() bool {
}

fn (mut this Class_ftp_base) rawlist(pathname string, arg string) rt.PhpVal {
}

fn (mut this Class_ftp_base) nlist(pathname string, arg string) rt.PhpVal {
}

fn (mut this Class_ftp_base) is_exists(var_pathname rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_ftp_base) file_exists(var_pathname rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_ftp_base) fget(var_fp rt.PhpVal, var_remotefile rt.PhpVal, rest i64) rt.PhpVal {
	mut var_fp_mutated := var_fp
	mut var_remotefile_mutated := var_remotefile
}

fn (mut this Class_ftp_base) get(var_remotefile rt.PhpVal, var_localfile rt.PhpVal, rest i64) rt.PhpVal {
	mut var_remotefile_mutated := var_remotefile
	mut var_localfile_mutated := var_localfile
}

fn (mut this Class_ftp_base) fput(var_remotefile rt.PhpVal, var_fp rt.PhpVal, rest i64) bool {
	mut var_remotefile_mutated := var_remotefile
	mut var_fp_mutated := var_fp
}

fn (mut this Class_ftp_base) put(var_localfile rt.PhpVal, var_remotefile rt.PhpVal, rest i64) bool {
	mut var_localfile_mutated := var_localfile
	mut var_remotefile_mutated := var_remotefile
}

fn (mut this Class_ftp_base) mput(local string, var_remote rt.PhpVal, continious bool) bool {
	mut local_mutated := local
	mut var_remote_mutated := var_remote
}

fn (mut this Class_ftp_base) mget(var_remote rt.PhpVal, local string, continious bool) bool {
	mut var_remote_mutated := var_remote
	mut local_mutated := local
}

fn (mut this Class_ftp_base) mdel(var_remote rt.PhpVal, continious bool) bool {
	mut var_remote_mutated := var_remote
}

fn (mut this Class_ftp_base) mmkdir(var_dir rt.PhpVal, mode i64) bool {
	mut mode_mutated := mode
}

fn (mut this Class_ftp_base) glob(var_pattern rt.PhpVal, var_handle rt.PhpVal) rt.PhpVal {
	mut var_pattern_mutated := var_pattern
	mut var_handle_mutated := var_handle
}

fn (mut this Class_ftp_base) glob_pattern_match(var_pattern rt.PhpVal, var_subject rt.PhpVal) bool {
	mut var_pattern_mutated := var_pattern
}

fn (mut this Class_ftp_base) glob_regexp(var_pattern rt.PhpVal, var_subject rt.PhpVal) rt.PhpVal {
	mut var_pattern_mutated := var_pattern
}

fn (mut this Class_ftp_base) dirlist(var_remote rt.PhpVal) rt.PhpVal {
	mut var_remote_mutated := var_remote
}

fn (mut this Class_ftp_base) _checkcode() bool {
}

fn (mut this Class_ftp_base) _list(arg string, cmd string, fnction string) rt.PhpVal {
}

fn (mut this Class_ftp_base) pusherror(var_fctname rt.PhpVal, var_msg rt.PhpVal, desc bool) rt.PhpVal {
}

fn (mut this Class_ftp_base) poperror() bool {
	return false
}

fn create_ftp_base(port_mode bool, verb bool, le bool) &Class_ftp_base {
	mut obj := &Class_ftp_base{
		PhpObjectBase: rt.PhpObjectBase{}
		LocalEcho: rt.new_null()
		Verbose: false
		OS_local: ''
		OS_remote: ''
		_lastaction: rt.new_null()
		_errors: rt.new_null()
		_type: rt.new_null()
		_umask: rt.new_null()
		_timeout: rt.new_null()
		_passive: rt.new_null()
		_host: rt.new_null()
		_fullhost: rt.new_null()
		_port: rt.new_null()
		_datahost: rt.new_null()
		_dataport: rt.new_null()
		_ftp_control_sock: rt.new_null()
		_ftp_data_sock: rt.new_null()
		_ftp_temp_sock: rt.new_null()
		_ftp_buff_size: i64(0)
		_login: rt.new_null()
		_password: rt.new_null()
		_connected: false
		_ready: false
		_code: i64(0)
		_message: ''
		_can_restore: false
		_port_available: false
		_curtype: rt.new_null()
		_features: rt.new_null()
		_error_array: rt.new_null()
		AuthorizedTransferMode: rt.new_null()
		OS_FullName: rt.new_null()
		_eol_code: rt.new_null()
		AutoAsciiExt: rt.new_null()
	}
	obj.construct(port_mode, verb, le)
	return obj
}

fn (mut this Class_ftp_base) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'ftp_base' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.ftp_base(dispatch_arg_0)
			return rt.new_null()
		}
		'parselisting' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parselisting(dispatch_arg_0)
		}
		'SendMSG' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.sendmsg(dispatch_arg_0, dispatch_arg_1))
		}
		'SetType' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.settype(dispatch_arg_0))
		}
		'_settype' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this._settype(dispatch_arg_0))
		}
		'Passive' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.passive(dispatch_arg_0))
		}
		'SetServer' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.setserver(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'SetUmask' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.setumask(dispatch_arg_0))
		}
		'SetTimeout' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.settimeout(dispatch_arg_0))
		}
		'connect' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.connect(dispatch_arg_0))
		}
		'quit' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.quit(dispatch_arg_0))
		}
		'login' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.login(dispatch_arg_0, dispatch_arg_1))
		}
		'pwd' {
			return rt.new_bool(this.pwd())
		}
		'cdup' {
			return rt.new_bool(this.cdup())
		}
		'chdir' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.chdir(dispatch_arg_0))
		}
		'rmdir' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.rmdir(dispatch_arg_0))
		}
		'mkdir' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.mkdir(dispatch_arg_0))
		}
		'rename' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.rename(dispatch_arg_0, dispatch_arg_1))
		}
		'filesize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.filesize(dispatch_arg_0))
		}
		'abort' {
			return rt.new_bool(this.abort())
		}
		'mdtm' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.mdtm(dispatch_arg_0))
		}
		'systype' {
			return this.systype()
		}
		'delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.delete(dispatch_arg_0))
		}
		'site' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.site(dispatch_arg_0, dispatch_arg_1))
		}
		'chmod' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.chmod(dispatch_arg_0, dispatch_arg_1))
		}
		'restore' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.restore(dispatch_arg_0))
		}
		'features' {
			return rt.new_bool(this.features())
		}
		'rawlist' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.rawlist(dispatch_arg_0, dispatch_arg_1)
		}
		'nlist' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.nlist(dispatch_arg_0, dispatch_arg_1)
		}
		'is_exists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_exists(dispatch_arg_0)
		}
		'file_exists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.file_exists(dispatch_arg_0)
		}
		'fget' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return this.fget(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return this.get(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'fput' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.fput(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'put' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.put(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'mput' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.mput(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'mget' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.mget(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'mdel' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.mdel(dispatch_arg_0, dispatch_arg_1))
		}
		'mmkdir' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.mmkdir(dispatch_arg_0, dispatch_arg_1))
		}
		'glob' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.glob(dispatch_arg_0, dispatch_arg_1)
		}
		'glob_pattern_match' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.glob_pattern_match(dispatch_arg_0, dispatch_arg_1))
		}
		'glob_regexp' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.glob_regexp(dispatch_arg_0, dispatch_arg_1)
		}
		'dirlist' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.dirlist(dispatch_arg_0)
		}
		'_checkCode' {
			return rt.new_bool(this._checkcode())
		}
		'_list' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this._list(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'PushError' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.pusherror(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'PopError' {
			return rt.new_bool(this.poperror())
		}
		else { return none }
	}
}

fn (this &Class_ftp_base) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'LocalEcho' { return this.LocalEcho }
		'Verbose' { return rt.new_bool(this.Verbose) }
		'OS_local' { return rt.new_string(this.OS_local) }
		'OS_remote' { return rt.new_string(this.OS_remote) }
		'_lastaction' { return this._lastaction }
		'_errors' { return this._errors }
		'_type' { return this._type }
		'_umask' { return this._umask }
		'_timeout' { return this._timeout }
		'_passive' { return this._passive }
		'_host' { return this._host }
		'_fullhost' { return this._fullhost }
		'_port' { return this._port }
		'_datahost' { return this._datahost }
		'_dataport' { return this._dataport }
		'_ftp_control_sock' { return this._ftp_control_sock }
		'_ftp_data_sock' { return this._ftp_data_sock }
		'_ftp_temp_sock' { return this._ftp_temp_sock }
		'_ftp_buff_size' { return rt.new_int(this._ftp_buff_size) }
		'_login' { return this._login }
		'_password' { return this._password }
		'_connected' { return rt.new_bool(this._connected) }
		'_ready' { return rt.new_bool(this._ready) }
		'_code' { return rt.new_int(this._code) }
		'_message' { return rt.new_string(this._message) }
		'_can_restore' { return rt.new_bool(this._can_restore) }
		'_port_available' { return rt.new_bool(this._port_available) }
		'_curtype' { return this._curtype }
		'_features' { return this._features }
		'_error_array' { return this._error_array }
		'AuthorizedTransferMode' { return this.AuthorizedTransferMode }
		'OS_FullName' { return this.OS_FullName }
		'_eol_code' { return this._eol_code }
		'AutoAsciiExt' { return this.AutoAsciiExt }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ftp_base) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'LocalEcho' { this.LocalEcho = val; return true }
		'Verbose' { this.Verbose = (val).to_bool(); return true }
		'OS_local' { this.OS_local = (val).str(); return true }
		'OS_remote' { this.OS_remote = (val).str(); return true }
		'_lastaction' { this._lastaction = val; return true }
		'_errors' { this._errors = val; return true }
		'_type' { this._type = val; return true }
		'_umask' { this._umask = val; return true }
		'_timeout' { this._timeout = val; return true }
		'_passive' { this._passive = val; return true }
		'_host' { this._host = val; return true }
		'_fullhost' { this._fullhost = val; return true }
		'_port' { this._port = val; return true }
		'_datahost' { this._datahost = val; return true }
		'_dataport' { this._dataport = val; return true }
		'_ftp_control_sock' { this._ftp_control_sock = val; return true }
		'_ftp_data_sock' { this._ftp_data_sock = val; return true }
		'_ftp_temp_sock' { this._ftp_temp_sock = val; return true }
		'_ftp_buff_size' { this._ftp_buff_size = (val).to_i64(); return true }
		'_login' { this._login = val; return true }
		'_password' { this._password = val; return true }
		'_connected' { this._connected = (val).to_bool(); return true }
		'_ready' { this._ready = (val).to_bool(); return true }
		'_code' { this._code = (val).to_i64(); return true }
		'_message' { this._message = (val).str(); return true }
		'_can_restore' { this._can_restore = (val).to_bool(); return true }
		'_port_available' { this._port_available = (val).to_bool(); return true }
		'_curtype' { this._curtype = val; return true }
		'_features' { this._features = val; return true }
		'_error_array' { this._error_array = val; return true }
		'AuthorizedTransferMode' { this.AuthorizedTransferMode = val; return true }
		'OS_FullName' { this.OS_FullName = val; return true }
		'_eol_code' { this._eol_code = val; return true }
		'AutoAsciiExt' { this.AutoAsciiExt = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_admin_includes_class_ftp_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('CRLF')]))))) {
		rt.call_function('define', [rt.new_string('CRLF'), rt.new_string('\r\n')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('FTP_AUTOASCII')]))))) {
		rt.call_function('define', [rt.new_string('FTP_AUTOASCII'), // unsupported expression: Expr_UnaryMinus])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('FTP_BINARY')]))))) {
		rt.call_function('define', [rt.new_string('FTP_BINARY'), rt.new_int(1)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('FTP_ASCII')]))))) {
		rt.call_function('define', [rt.new_string('FTP_ASCII'), rt.new_int(0)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('FTP_FORCE')]))))) {
		rt.call_function('define', [rt.new_string('FTP_FORCE'), rt.new_bool(true)])
	}
}
