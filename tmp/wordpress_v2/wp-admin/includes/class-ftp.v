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

fn (mut this Class_ftp_base) construct(port_mode bool, verb bool, le bool) {
	this.LocalEcho = rt.new_bool(le)
	this.Verbose = verb
	this._lastaction = rt.new_null()
	this._error_array = rt.new_array()
	this._eol_code = rt.create_array([rt.ArrayItem{ key: global_const_ftp_os_unix, val: '\n' }, rt.ArrayItem{ key: global_const_ftp_os_mac, val: '\r' }, rt.ArrayItem{ key: global_const_ftp_os_windows, val: '\r\n' }])
	this.AuthorizedTransferMode = rt.create_array([rt.ArrayItem{ key: none, val: rt.get_constant('FTP_AUTOASCII') }, rt.ArrayItem{ key: none, val: rt.get_constant('FTP_ASCII') }, rt.ArrayItem{ key: none, val: rt.get_constant('FTP_BINARY') }])
	this.OS_FullName = rt.create_array([rt.ArrayItem{ key: global_const_ftp_os_unix, val: 'UNIX' }, rt.ArrayItem{ key: global_const_ftp_os_windows, val: 'WINDOWS' }, rt.ArrayItem{ key: global_const_ftp_os_mac, val: 'MACOS' }])
	this.AutoAsciiExt = rt.create_array([rt.ArrayItem{ key: none, val: 'ASP' }, rt.ArrayItem{ key: none, val: 'BAT' }, rt.ArrayItem{ key: none, val: 'C' }, rt.ArrayItem{ key: none, val: 'CPP' }, rt.ArrayItem{ key: none, val: 'CSS' }, rt.ArrayItem{ key: none, val: 'CSV' }, rt.ArrayItem{ key: none, val: 'JS' }, rt.ArrayItem{ key: none, val: 'H' }, rt.ArrayItem{ key: none, val: 'HTM' }, rt.ArrayItem{ key: none, val: 'HTML' }, rt.ArrayItem{ key: none, val: 'SHTML' }, rt.ArrayItem{ key: none, val: 'INI' }, rt.ArrayItem{ key: none, val: 'LOG' }, rt.ArrayItem{ key: none, val: 'PHP3' }, rt.ArrayItem{ key: none, val: 'PHTML' }, rt.ArrayItem{ key: none, val: 'PL' }, rt.ArrayItem{ key: none, val: 'PERL' }, rt.ArrayItem{ key: none, val: 'SH' }, rt.ArrayItem{ key: none, val: 'SQL' }, rt.ArrayItem{ key: none, val: 'TXT' }])
	this._port_available = rt.equal(rt.new_bool(port_mode), rt.new_bool(true))
	this.sendmsg('Staring FTP client class' + if this._port_available { '' } else { ' without PORT mode support' }, false)
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
	this.passive(rt.new_bool(!(this._port_available)))
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

fn (mut this Class_ftp_base) ftp_base(port_mode bool) {
	this.construct(port_mode, false, false)
}

fn (mut this Class_ftp_base) parselisting(var_line rt.PhpVal) rt.PhpVal {
	mut var_l2 := []rt.PhpVal{}
	mut var_is_windows := rt.equal(this.OS_remote, rt.new_string(global_const_ftp_os_windows))
	if rt.is_true(var_is_windows) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/([0-9]{2})-([0-9]{2})-([0-9]{2}) +([0-9]{2}):([0-9]{2})(AM|PM) +([0-9]+|<DIR>) +(.+)/'), var_line.clone(), var_lucifer.clone()])) {
		mut var_b := rt.new_array()
		if rt.is_true(rt.less(var_lucifer.array_get(rt.new_int(3)), rt.new_int(70))) {
			var_lucifer.array_get(rt.new_int(3)) = rt.add(var_lucifer.array_get(rt.new_int(3)), rt.new_int(2000))
		} else {
			var_lucifer.array_get(rt.new_int(3)) = rt.add(var_lucifer.array_get(rt.new_int(3)), rt.new_int(1900))
		}
		var_b['isdir'] = rt.equal(var_lucifer.array_get(rt.new_int(7)), rt.new_string('<DIR>'))
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
		var_b['time'] = rt.call_function('mktime', [rt.add(var_lucifer.array_get(rt.new_int(4)), if rt.is_true(rt.equal(rt.call_function('strcasecmp', [var_lucifer.array_get(rt.new_int(6)), rt.new_string('PM')]), rt.new_int(0))) { 12 } else { 0 }), var_lucifer.array_get(rt.new_int(5)), rt.new_int(0), var_lucifer.array_get(rt.new_int(1)), var_lucifer.array_get(rt.new_int(2)), var_lucifer.array_get(rt.new_int(3))])
		var_b['am/pm'] = var_lucifer.array_get(rt.new_int(6))
		var_b['name'] = var_lucifer.array_get(rt.new_int(8))
	} else {
		mut var_lucifer := rt.call_function('preg_split', [rt.new_string('/[ ]/'), var_line.clone(), rt.new_int(9), rt.get_constant('PREG_SPLIT_NO_EMPTY')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_is_windows)))) && rt.is_true(var_lucifer) {
			mut var_lcount := rt.new_int(var_lucifer.clone().array_count())
			if rt.is_true(rt.less(var_lcount, rt.new_int(8))) {
				return rt.new_string('')
			}
			var_b = rt.new_array()
			var_b['isdir'] = rt.identical(var_lucifer.array_get(rt.new_int(0)).array_get(rt.new_int(0)), rt.new_string('d'))
			var_b['islink'] = rt.identical(var_lucifer.array_get(rt.new_int(0)).array_get(rt.new_int(0)), rt.new_string('l'))
			if rt.is_true(var_b['isdir']) {
				var_b['type'] = rt.new_string('d')
			} else if rt.is_true(var_b['islink']) {
				var_b['type'] = rt.new_string('l')
			} else {
				var_b['type'] = rt.new_string('f')
			}
			var_b['perms'] = var_lucifer.array_get(rt.new_int(0))
			var_b['number'] = var_lucifer.array_get(rt.new_int(1))
			var_b['owner'] = var_lucifer.array_get(rt.new_int(2))
			var_b['group'] = var_lucifer.array_get(rt.new_int(3))
			var_b['size'] = var_lucifer.array_get(rt.new_int(4))
			if rt.is_true(rt.equal(var_lcount, rt.new_int(8))) {
				rt.call_function('sscanf', [var_lucifer.array_get(rt.new_int(5)), rt.new_string('%d-%d-%d'), var_b['year'], var_b['month'], var_b['day']])
				rt.call_function('sscanf', [var_lucifer.array_get(rt.new_int(6)), rt.new_string('%d:%d'), var_b['hour'], var_b['minute']])
				var_b['time'] = rt.call_function('mktime', [var_b['hour'], var_b['minute'], rt.new_int(0), var_b['month'], var_b['day'], var_b['year']])
				var_b['name'] = var_lucifer.array_get(rt.new_int(7))
			} else {
				var_b['month'] = var_lucifer.array_get(rt.new_int(5))
				var_b['day'] = var_lucifer.array_get(rt.new_int(6))
				if rt.is_true(rt.call_function('preg_match', [rt.new_string('/([0-9]{2}):([0-9]{2})/'), var_lucifer.array_get(rt.new_int(7)), rt.create_array_from_list(var_l2)])) {
					var_b['year'] = rt.call_function('gmdate', [rt.new_string('Y')])
					var_b['hour'] = var_l2.array_get(rt.new_int(1))
					var_b['minute'] = var_l2.array_get(rt.new_int(2))
				} else {
					var_b['year'] = var_lucifer.array_get(rt.new_int(7))
					var_b['hour'] = rt.new_int(0)
					var_b['minute'] = rt.new_int(0)
				}
				var_b['time'] = rt.call_function('strtotime', [rt.call_function('sprintf', [rt.new_string('%d %s %d %02d:%02d'), var_b['day'], var_b['month'], var_b['year'], var_b['hour'], var_b['minute']])])
				var_b['name'] = var_lucifer.array_get(rt.new_int(8))
			}
		}
	}
	return var_b.clone()
}

fn (mut this Class_ftp_base) sendmsg(message string, crlf bool) bool {
	if this.Verbose {
		print(message + (if var_crlf { rt.get_constant('CRLF') } else { rt.new_string('') }).str())
		rt.call_function('flush', []rt.PhpVal{})
	}
	return true
}

fn (mut this Class_ftp_base) settype(var_mode rt.PhpVal) bool {
	mut var_mode_mutated := var_mode
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_mode_mutated.clone(), this.AuthorizedTransferMode]))))) {
		this.sendmsg('Wrong type', false)
		return false
	}
	this._type = var_mode_mutated.clone()
	this.sendmsg('Transfer type: ' + if rt.is_true(rt.equal(this._type, rt.get_constant('FTP_BINARY'))) { 'binary' } else { if rt.is_true(rt.equal(this._type, rt.get_constant('FTP_ASCII'))) { 'ASCII' } else { 'auto ASCII' } }, false)
	return true
}

fn (mut this Class_ftp_base) _settype(var_mode rt.PhpVal) bool {
	mut var_mode_mutated := var_mode
	if this._ready {
		if rt.is_true(rt.equal(var_mode_mutated, rt.get_constant('FTP_BINARY'))) {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(this._curtype, rt.get_constant('FTP_BINARY'))))) {
				if rt.is_true(rt.new_bool(!(rt.is_true(this._exec(rt.new_string('TYPE I'), rt.new_string('SetType')))))) {
					return false
				}
				this._curtype = rt.get_constant('FTP_BINARY')
			}
		} else if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(this._curtype, rt.get_constant('FTP_ASCII'))))) {
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
	if rt.is_true(rt.new_bool(var_pasv.clone().is_null())) {
		this._passive = rt.new_bool(!(rt.is_true(this._passive)))
	} else {
		this._passive = var_pasv.clone()
	}
	if !(this._port_available) && rt.is_true(rt.new_bool(!(rt.is_true(this._passive)))) {
		this.sendmsg('Only passive connections available!', false)
		this._passive = rt.new_bool(true)
		return false
	}
	this.sendmsg('Passive mode ' + if rt.is_true(this._passive) { 'on' } else { 'off' }, false)
	return true
}

fn (mut this Class_ftp_base) setserver(var_host rt.PhpVal, port i64, reconnect bool) bool {
	if !(rt.new_int(port).is_long()) {
		this.dispatch_set_prop('verbose', rt.new_bool(true))
		this.sendmsg('Incorrect port syntax', false)
		return false
	} else {
		mut var_ip := rt.call_function('gethostbyname', [var_host.clone()])
		mut var_dns := rt.call_function('gethostbyaddr', [var_host.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_ip)))) {
		var_ip = var_host
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_dns)))) {
		var_dns = var_host
		}
		mut var_ipaslong := rt.call_function('ip2long', [var_ip.clone()])
		if rt.is_true(rt.equal(var_ipaslong, rt.new_bool(false))) || rt.is_true(rt.identical(var_ipaslong, -1)) {
			this.sendmsg('Wrong host name/address "' + (var_host).str() + '"', false)
			return false
		}
		this._host = var_ip.clone()
		this._fullhost = var_dns.clone()
		this._port = rt.new_int(port)
		this._dataport = port - 1
	}
	this.sendmsg('Host "' + (this._fullhost).str() + '(' + (this._host).str() + '):' + (this._port).str() + '"', false)
	if var_reconnect {
		if this._connected {
			this.sendmsg('Reconnecting', false)
			if !(this.quit((rt.get_constant('FTP_FORCE')).to_bool())) {
				return false
			}
			if !(this.connect(rt.new_null())) {
				return false
			}
		}
	}
	return true
}

fn (mut this Class_ftp_base) setumask(umask i64) bool {
	this._umask = rt.new_int(umask)
	rt.call_function('umask', [this._umask])
	this.sendmsg('UMASK 0' + (rt.call_function('decoct', [this._umask])).str(), false)
	return true
}

fn (mut this Class_ftp_base) settimeout(timeout i64) bool {
	this._timeout = rt.new_int(timeout)
	this.sendmsg('Timeout ' + (this._timeout).str(), false)
	if this._connected {
		if rt.is_true(rt.new_bool(!(rt.is_true(this._settimeout(this._ftp_control_sock))))) {
			return false
		}
	}
	return true
}

fn (mut this Class_ftp_base) connect(var_server rt.PhpVal) bool {
	if !(!rt.is_true(var_server)) {
		if !(this.setserver(var_server.clone(), 0, false)) {
			return false
		}
	}
	if this._ready {
		return true
	}
	this.sendmsg('Local OS : ' + (this.OS_FullName.array_get(rt.new_string(this.OS_local))).str(), false)
	if rt.is_true(rt.new_bool(!(rt.is_true(this._ftp_control_sock = this._connect(this._host, this._port))))) {
		this.sendmsg('Error : Cannot connect to remote host "' + (this._fullhost).str() + ' :' + (this._port).str() + '"', false)
		return false
	}
	this.sendmsg('Connected to remote host "' + (this._fullhost).str() + ':' + (this._port).str() + '". Waiting for greeting.', false)
	for {
		if rt.is_true(rt.new_bool(!(rt.is_true(this._readmsg())))) {
			return false
		}
		if !(this._checkcode()) {
			return false
		}
		this._lastaction = rt.call_function('time', []rt.PhpVal{})
		if !(this._code < 200) {
			break
		}
	}
	this._ready = true
	mut var_syst := this.systype()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_syst)))) {
		this.sendmsg('Cannot detect remote OS', false)
	} else {
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('/win|dos|novell/i'), var_syst.array_get(rt.new_int(0))])) {
			this.OS_remote = global_const_ftp_os_windows
		} else if rt.is_true(rt.call_function('preg_match', [rt.new_string('/os/i'), var_syst.array_get(rt.new_int(0))])) {
			this.OS_remote = global_const_ftp_os_mac
		} else if rt.is_true(rt.call_function('preg_match', [rt.new_string('/(li|u)nix/i'), var_syst.array_get(rt.new_int(0))])) {
			this.OS_remote = global_const_ftp_os_unix
		} else {
			this.OS_remote = global_const_ftp_os_mac
		}
		this.sendmsg('Remote OS: ' + (this.OS_FullName.array_get(rt.new_string(this.OS_remote))).str(), false)
	}
	if !(this.features()) {
		this.sendmsg('Cannot get features list. All supported - disabled', false)
	} else {
		this.sendmsg('Supported features: ' + (rt.call_function('implode', [rt.new_string(', '), rt.func_array_keys(this._features)])).str(), false)
	}
	return true
}

fn (mut this Class_ftp_base) quit(force bool) bool {
	if this._ready {
		if rt.is_true(rt.new_bool(!(rt.is_true(this._exec(rt.new_string('QUIT')))))) && !(var_force) {
			return false
		}
		if !(this._checkcode()) && !(var_force) {
			return false
		}
		this._ready = false
		this.sendmsg('Session finished', false)
	}
	this._quit()
	return true
}

fn (mut this Class_ftp_base) login(var_user rt.PhpVal, var_pass rt.PhpVal) bool {
	if !(var_user.clone().is_null()) {
		this._login = var_user.clone()
	} else {
		this._login = rt.new_string('anonymous')
	}
	if !(var_pass.clone().is_null()) {
		this._password = var_pass.clone()
	} else {
		this._password = rt.new_string('anon@anon.com')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this._exec(rt.new_string('USER ' + (this._login).str()), rt.new_string('login')))))) {
		return false
	}
	if !(this._checkcode()) {
		return false
	}
	if rt.is_true(rt.new_bool(this._code != 230)) {
		if rt.is_true(rt.new_bool(!(rt.is_true(this._exec(rt.new_string((if this._code == 331 { 'PASS ' } else { 'ACCT ' } + (this._password).str()).str()), rt.new_string('login')))))) {
			return false
		}
		if !(this._checkcode()) {
			return false
		}
	}
	this.sendmsg('Authentication succeeded', false)
	if !rt.is_true(this._features) {
		if !(this.features()) {
			this.sendmsg('Cannot get features list. All supported - disabled', false)
		} else {
			this.sendmsg('Supported features: ' + (rt.call_function('implode', [rt.new_string(', '), rt.func_array_keys(this._features)])).str(), false)
		}
	}
	return true
}

fn (mut this Class_ftp_base) pwd() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this._exec(rt.new_string('PWD'), rt.new_string('pwd')))))) {
		return false
	}
	if !(this._checkcode()) {
		return false
	}
	return (rt.call_function('preg_replace', [rt.new_string('/^[0-9]{3} "(.+)".*$/s'), rt.new_string('\\1'), rt.new_string(this._message)])).to_bool()
}

fn (mut this Class_ftp_base) cdup() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this._exec(rt.new_string('CDUP'), rt.new_string('cdup')))))) {
		return false
	}
	if !(this._checkcode()) {
		return false
	}
	return true
}

fn (mut this Class_ftp_base) chdir(var_pathname rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this._exec(rt.new_string('CWD ' + (var_pathname).str()), rt.new_string('chdir')))))) {
		return false
	}
	if !(this._checkcode()) {
		return false
	}
	return true
}

fn (mut this Class_ftp_base) rmdir(var_pathname rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this._exec(rt.new_string('RMD ' + (var_pathname).str()), rt.new_string('rmdir')))))) {
		return false
	}
	if !(this._checkcode()) {
		return false
	}
	return true
}

fn (mut this Class_ftp_base) mkdir(var_pathname rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this._exec(rt.new_string('MKD ' + (var_pathname).str()), rt.new_string('mkdir')))))) {
		return false
	}
	if !(this._checkcode()) {
		return false
	}
	return true
}

fn (mut this Class_ftp_base) rename(var_from rt.PhpVal, var_to rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this._exec(rt.new_string('RNFR ' + (var_from).str()), rt.new_string('rename')))))) {
		return false
	}
	if !(this._checkcode()) {
		return false
	}
	if this._code == 350 {
		if rt.is_true(rt.new_bool(!(rt.is_true(this._exec(rt.new_string('RNTO ' + (var_to).str()), rt.new_string('rename')))))) {
			return false
		}
		if !(this._checkcode()) {
			return false
		}
	} else {
		return false
	}
	return true
}

fn (mut this Class_ftp_base) filesize(var_pathname rt.PhpVal) bool {
	if !(this._features.array_isset(rt.new_string('SIZE'))) {
		this.pusherror(rt.new_string('filesize'), rt.new_string('not supported by server'), false)
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this._exec(rt.new_string('SIZE ' + (var_pathname).str()), rt.new_string('filesize')))))) {
		return false
	}
	if !(this._checkcode()) {
		return false
	}
	return (rt.call_function('preg_replace', [rt.new_string('/^[0-9]{3} ([0-9]+).*$/s'), rt.new_string('\\1'), rt.new_string(this._message)])).to_bool()
}

fn (mut this Class_ftp_base) abort() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this._exec(rt.new_string('ABOR'), rt.new_string('abort')))))) {
		return false
	}
	if !(this._checkcode()) {
		if rt.is_true(rt.new_bool(this._code != 426)) {
			return false
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(this._readmsg(rt.new_string('abort')))))) {
			return false
		}
		if !(this._checkcode()) {
			return false
		}
	}
	return true
}

fn (mut this Class_ftp_base) mdtm(var_pathname rt.PhpVal) bool {
	if !(this._features.array_isset(rt.new_string('MDTM'))) {
		this.pusherror(rt.new_string('mdtm'), rt.new_string('not supported by server'), false)
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this._exec(rt.new_string('MDTM ' + (var_pathname).str()), rt.new_string('mdtm')))))) {
		return false
	}
	if !(this._checkcode()) {
		return false
	}
	mut var_mdtm := rt.call_function('preg_replace', [rt.new_string('/^[0-9]{3} ([0-9]+).*$/s'), rt.new_string('\\1'), rt.new_string(this._message)])
	mut var_date := rt.call_function('sscanf', [var_mdtm.clone(), rt.new_string('%4d%2d%2d%2d%2d%2d')])
	mut var_timestamp := rt.call_function('mktime', [var_date.array_get(rt.new_int(3)), var_date.array_get(rt.new_int(4)), var_date.array_get(rt.new_int(5)), var_date.array_get(rt.new_int(1)), var_date.array_get(rt.new_int(2)), var_date.array_get(rt.new_int(0))])
	return (var_timestamp).to_bool()
}

fn (mut this Class_ftp_base) systype() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this._exec(rt.new_string('SYST'), rt.new_string('systype')))))) {
		return rt.new_bool(false)
	}
	if !(this._checkcode()) {
		return rt.new_bool(false)
	}
	mut var_DATA := rt.call_function('explode', [rt.new_string(' '), rt.new_string(this._message)])
	return rt.create_array([rt.ArrayItem{ key: none, val: var_DATA.array_get(rt.new_int(1)) }, rt.ArrayItem{ key: none, val: var_DATA.array_get(rt.new_int(3)) }])
}

fn (mut this Class_ftp_base) delete(var_pathname rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this._exec(rt.new_string('DELE ' + (var_pathname).str()), rt.new_string('delete')))))) {
		return false
	}
	if !(this._checkcode()) {
		return false
	}
	return true
}

fn (mut this Class_ftp_base) site(var_command rt.PhpVal, fnction string) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this._exec(rt.new_string('SITE ' + (var_command).str()), rt.new_string(fnction)))))) {
		return false
	}
	if !(this._checkcode()) {
		return false
	}
	return true
}

fn (mut this Class_ftp_base) chmod(var_pathname rt.PhpVal, var_mode rt.PhpVal) bool {
	mut var_mode_mutated := var_mode
	if !(this.site(rt.call_function('sprintf', [rt.new_string('CHMOD %o %s'), var_mode_mutated.clone(), var_pathname.clone()]), 'chmod')) {
		return false
	}
	return true
}

fn (mut this Class_ftp_base) restore(var_from rt.PhpVal) bool {
	if !(this._features.array_isset(rt.new_string('REST'))) {
		this.pusherror(rt.new_string('restore'), rt.new_string('not supported by server'), false)
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(this._curtype, rt.get_constant('FTP_BINARY'))))) {
		this.pusherror(rt.new_string('restore'), rt.new_string('cannot restore in ASCII mode'), false)
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this._exec(rt.new_string('REST ' + (var_from).str()), rt.new_string('restore')))))) {
		return false
	}
	if !(this._checkcode()) {
		return false
	}
	return true
}

fn (mut this Class_ftp_base) features() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this._exec(rt.new_string('FEAT'), rt.new_string('features')))))) {
		return false
	}
	if !(this._checkcode()) {
		return false
	}
	mut var_f := rt.call_function('preg_split', [rt.new_string('/[' + (rt.get_constant('CRLF')).str() + ']+/'), rt.call_function('preg_replace', [rt.new_string('/[0-9]{3}[ -].*[' + (rt.get_constant('CRLF')).str() + ']+/'), rt.new_string(''), rt.new_string(this._message)]), rt.new_int(-1), rt.get_constant('PREG_SPLIT_NO_EMPTY')])
	this._features = rt.new_array()
	mut iter_1 := var_f.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_v := item_1.val
		mut var_k := item_1.key
		var_v = rt.call_function('explode', [rt.new_string(' '), rt.new_string(var_v.clone().to_string().trim_space())])
		this._features.array_set(rt.call_function('array_shift', [var_v.clone()]), var_v.clone())
	}
	return true
}

fn (mut this Class_ftp_base) rawlist(pathname string, arg string) rt.PhpVal {
	return this._list(if var_arg.len > 0 && var_arg != '0' { ' ' + arg } else { '' } + if var_pathname.len > 0 && var_pathname != '0' { ' ' + pathname } else { '' }, 'LIST', 'rawlist')
}

fn (mut this Class_ftp_base) nlist(pathname string, arg string) rt.PhpVal {
	return this._list(if var_arg.len > 0 && var_arg != '0' { ' ' + arg } else { '' } + if var_pathname.len > 0 && var_pathname != '0' { ' ' + pathname } else { '' }, 'NLST', 'nlist')
}

fn (mut this Class_ftp_base) is_exists(var_pathname rt.PhpVal) rt.PhpVal {
	return this.file_exists(var_pathname.clone())
}

fn (mut this Class_ftp_base) file_exists(var_pathname rt.PhpVal) rt.PhpVal {
	mut var_exists := rt.new_bool(true)
	if rt.is_true(rt.new_bool(!(rt.is_true(this._exec(rt.new_string('RNFR ' + (var_pathname).str()), rt.new_string('rename')))))) {
	var_exists = rt.new_bool(false)
	} else {
		if !(this._checkcode()) {
		var_exists = rt.new_bool(false)
		}
		this.abort()
	}
	if rt.is_true(var_exists) {
		this.sendmsg('Remote file ' + (var_pathname).str() + ' exists', false)
	} else {
		this.sendmsg('Remote file ' + (var_pathname).str() + ' does not exist', false)
	}
	return var_exists.clone()
}

fn (mut this Class_ftp_base) fget(var_fp rt.PhpVal, var_remotefile rt.PhpVal, rest i64) rt.PhpVal {
	mut var_fp_mutated := var_fp
	mut var_remotefile_mutated := var_remotefile
	if this._can_restore && rt.is_true(rt.new_bool(rest != 0)) {
		rt.call_function('fseek', [var_fp_mutated.clone(), rt.new_int(rest)])
	}
	mut var_pi := rt.call_function('pathinfo', [var_remotefile_mutated.clone()])
	if rt.is_true(rt.equal(this._type, rt.get_constant('FTP_ASCII'))) || (rt.is_true(rt.equal(this._type, rt.get_constant('FTP_AUTOASCII'))) && rt.is_true(rt.call_function('in_array', [rt.new_string(var_pi.array_get(rt.new_string('extension')).to_string().to_upper()), this.AutoAsciiExt]))) {
	mut var_mode := rt.get_constant('FTP_ASCII')
	} else {
	var_mode = rt.get_constant('FTP_BINARY')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this._data_prepare(var_mode.clone()))))) {
		return rt.new_bool(false)
	}
	if this._can_restore && rt.is_true(rt.new_bool(rest != 0)) {
		this.restore(rt.new_int(rest))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this._exec(rt.new_string('RETR ' + (var_remotefile_mutated).str()), rt.new_string('get')))))) {
		this._data_close()
		return rt.new_bool(false)
	}
	if !(this._checkcode()) {
		this._data_close()
		return rt.new_bool(false)
	}
	mut var_out := this._data_read(var_mode.clone(), var_fp_mutated.clone())
	this._data_close()
	if rt.is_true(rt.new_bool(!(rt.is_true(this._readmsg())))) {
		return rt.new_bool(false)
	}
	if !(this._checkcode()) {
		return rt.new_bool(false)
	}
	return var_out.clone()
}

fn (mut this Class_ftp_base) get(var_remotefile rt.PhpVal, var_localfile rt.PhpVal, rest i64) rt.PhpVal {
	mut var_remotefile_mutated := var_remotefile
	mut var_localfile_mutated := var_localfile
	if rt.is_true(rt.new_bool(var_localfile_mutated.clone().is_null())) {
	var_localfile_mutated = var_remotefile_mutated.clone()
	}
	if rt.is_true(rt.call_function('file_exists', [var_localfile_mutated.clone()])) {
		this.sendmsg('Warning : local file will be overwritten', false)
	}
	mut var_fp := rt.call_function('fopen', [var_localfile_mutated.clone(), rt.new_string('w')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_fp)))) {
		this.pusherror(rt.new_string('get'), rt.new_string('cannot open local file'), 'Cannot create "' + (var_localfile_mutated).str() + '"')
		return rt.new_bool(false)
	}
	if this._can_restore && rt.is_true(rt.new_bool(rest != 0)) {
		rt.call_function('fseek', [var_fp.clone(), rt.new_int(rest)])
	}
	mut var_pi := rt.call_function('pathinfo', [var_remotefile_mutated.clone()])
	if rt.is_true(rt.equal(this._type, rt.get_constant('FTP_ASCII'))) || (rt.is_true(rt.equal(this._type, rt.get_constant('FTP_AUTOASCII'))) && rt.is_true(rt.call_function('in_array', [rt.new_string(var_pi.array_get(rt.new_string('extension')).to_string().to_upper()), this.AutoAsciiExt]))) {
	mut var_mode := rt.get_constant('FTP_ASCII')
	} else {
	var_mode = rt.get_constant('FTP_BINARY')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this._data_prepare(var_mode.clone()))))) {
		rt.call_function('fclose', [var_fp.clone()])
		return rt.new_bool(false)
	}
	if this._can_restore && rt.is_true(rt.new_bool(rest != 0)) {
		this.restore(rt.new_int(rest))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this._exec(rt.new_string('RETR ' + (var_remotefile_mutated).str()), rt.new_string('get')))))) {
		this._data_close()
		rt.call_function('fclose', [var_fp.clone()])
		return rt.new_bool(false)
	}
	if !(this._checkcode()) {
		this._data_close()
		rt.call_function('fclose', [var_fp.clone()])
		return rt.new_bool(false)
	}
	mut var_out := this._data_read(var_mode.clone(), var_fp.clone())
	rt.call_function('fclose', [var_fp.clone()])
	this._data_close()
	if rt.is_true(rt.new_bool(!(rt.is_true(this._readmsg())))) {
		return rt.new_bool(false)
	}
	if !(this._checkcode()) {
		return rt.new_bool(false)
	}
	return var_out.clone()
}

fn (mut this Class_ftp_base) fput(var_remotefile rt.PhpVal, var_fp rt.PhpVal, rest i64) bool {
	mut var_remotefile_mutated := var_remotefile
	mut var_fp_mutated := var_fp
	if this._can_restore && rt.is_true(rt.new_bool(rest != 0)) {
		rt.call_function('fseek', [var_fp_mutated.clone(), rt.new_int(rest)])
	}
	mut var_pi := rt.call_function('pathinfo', [var_remotefile_mutated.clone()])
	if rt.is_true(rt.equal(this._type, rt.get_constant('FTP_ASCII'))) || (rt.is_true(rt.equal(this._type, rt.get_constant('FTP_AUTOASCII'))) && rt.is_true(rt.call_function('in_array', [rt.new_string(var_pi.array_get(rt.new_string('extension')).to_string().to_upper()), this.AutoAsciiExt]))) {
	mut var_mode := rt.get_constant('FTP_ASCII')
	} else {
	var_mode = rt.get_constant('FTP_BINARY')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this._data_prepare(var_mode.clone()))))) {
		return false
	}
	if this._can_restore && rt.is_true(rt.new_bool(rest != 0)) {
		this.restore(rt.new_int(rest))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this._exec(rt.new_string('STOR ' + (var_remotefile_mutated).str()), rt.new_string('put')))))) {
		this._data_close()
		return false
	}
	if !(this._checkcode()) {
		this._data_close()
		return false
	}
	mut var_ret := this._data_write(var_mode.clone(), var_fp_mutated.clone())
	this._data_close()
	if rt.is_true(rt.new_bool(!(rt.is_true(this._readmsg())))) {
		return false
	}
	if !(this._checkcode()) {
		return false
	}
	return (var_ret).to_bool()
}

fn (mut this Class_ftp_base) put(var_localfile rt.PhpVal, var_remotefile rt.PhpVal, rest i64) bool {
	mut var_localfile_mutated := var_localfile
	mut var_remotefile_mutated := var_remotefile
	if rt.is_true(rt.new_bool(var_remotefile_mutated.clone().is_null())) {
	var_remotefile_mutated = var_localfile_mutated.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_localfile_mutated.clone()]))))) {
		this.pusherror(rt.new_string('put'), rt.new_string('cannot open local file'), 'No such file or directory "' + (var_localfile_mutated).str() + '"')
		return false
	}
	mut var_fp := rt.call_function('fopen', [var_localfile_mutated.clone(), rt.new_string('r')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_fp)))) {
		this.pusherror(rt.new_string('put'), rt.new_string('cannot open local file'), 'Cannot read file "' + (var_localfile_mutated).str() + '"')
		return false
	}
	if this._can_restore && rt.is_true(rt.new_bool(rest != 0)) {
		rt.call_function('fseek', [var_fp.clone(), rt.new_int(rest)])
	}
	mut var_pi := rt.call_function('pathinfo', [var_localfile_mutated.clone()])
	if rt.is_true(rt.equal(this._type, rt.get_constant('FTP_ASCII'))) || (rt.is_true(rt.equal(this._type, rt.get_constant('FTP_AUTOASCII'))) && rt.is_true(rt.call_function('in_array', [rt.new_string(var_pi.array_get(rt.new_string('extension')).to_string().to_upper()), this.AutoAsciiExt]))) {
	mut var_mode := rt.get_constant('FTP_ASCII')
	} else {
	var_mode = rt.get_constant('FTP_BINARY')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this._data_prepare(var_mode.clone()))))) {
		rt.call_function('fclose', [var_fp.clone()])
		return false
	}
	if this._can_restore && rt.is_true(rt.new_bool(rest != 0)) {
		this.restore(rt.new_int(rest))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this._exec(rt.new_string('STOR ' + (var_remotefile_mutated).str()), rt.new_string('put')))))) {
		this._data_close()
		rt.call_function('fclose', [var_fp.clone()])
		return false
	}
	if !(this._checkcode()) {
		this._data_close()
		rt.call_function('fclose', [var_fp.clone()])
		return false
	}
	mut var_ret := this._data_write(var_mode.clone(), var_fp.clone())
	rt.call_function('fclose', [var_fp.clone()])
	this._data_close()
	if rt.is_true(rt.new_bool(!(rt.is_true(this._readmsg())))) {
		return false
	}
	if !(this._checkcode()) {
		return false
	}
	return (var_ret).to_bool()
}

fn (mut this Class_ftp_base) mput(local string, var_remote rt.PhpVal, continious bool) bool {
	mut local_mutated := local
	mut var_remote_mutated := var_remote
	local_mutated = (rt.call_function('realpath', [rt.new_string(local_mutated).clone()])).str()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [rt.new_string(local_mutated).clone()]))))) {
		this.pusherror(rt.new_string('mput'), rt.new_string('cannot open local folder'), 'Cannot stat folder "' + local_mutated + '"')
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [rt.new_string(local_mutated).clone()]))))) {
		return this.put(rt.new_string(local_mutated), var_remote_mutated.clone(), 0)
	}
	if !rt.is_true(var_remote_mutated) {
	var_remote_mutated = rt.new_string('.')
	} else if rt.is_true(rt.new_bool(!(rt.is_true(this.file_exists(var_remote_mutated.clone()))))) && !(this.mkdir(var_remote_mutated.clone())) {
		return false
	}
	mut var_handle := rt.call_function('opendir', [rt.new_string(local_mutated).clone()])
	if rt.is_true(var_handle) {
		mut var_list := rt.new_array()
		mut var_file := rt.call_function('readdir', [var_handle.clone()])
		for rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_file)))) {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_file, rt.new_string('.'))))) && rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_file, rt.new_string('..'))))) {
				var_list.array_push(var_file.clone())
			}
		}
		rt.call_function('closedir', [var_handle.clone()])
	} else {
		this.pusherror(rt.new_string('mput'), rt.new_string('cannot open local folder'), 'Cannot read folder "' + local_mutated + '"')
		return false
	}
	if !rt.is_true(var_list) {
		return true
	}
	mut var_ret := rt.new_bool(true)
	mut iter_2 := var_list.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_el := item_2.val
		if rt.is_true(rt.call_function('is_dir', [rt.new_string(local_mutated + '/' + (var_el).str())])) {
		mut var_t := rt.new_bool(this.mput(local_mutated + '/' + (var_el).str(), rt.new_string((var_remote_mutated).str() + '/' + (var_el).str()), false))
		} else {
		var_t = rt.new_bool(this.put(rt.new_string(local_mutated + '/' + (var_el).str()), rt.new_string((var_remote_mutated).str() + '/' + (var_el).str()), 0))
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_t)))) {
			var_ret = rt.new_bool(false)
			if !(var_continious) {
				break
			}
		}
	}
	return (var_ret).to_bool()
}

fn (mut this Class_ftp_base) mget(var_remote rt.PhpVal, local string, continious bool) bool {
	mut var_remote_mutated := var_remote
	mut local_mutated := local
	mut var_list := this.rawlist((var_remote_mutated).str(), '-lA')
	if rt.is_true(rt.identical(var_list, rt.new_bool(false))) {
		this.pusherror(rt.new_string('mget'), rt.new_string('cannot read remote folder list'), 'Cannot read remote folder "' + (var_remote_mutated).str() + '" contents')
		return false
	}
	if !rt.is_true(var_list) {
		return true
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [rt.new_string(local_mutated).clone()]))))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('mkdir', [rt.new_string(local_mutated).clone()]))))) {
			this.pusherror(rt.new_string('mget'), rt.new_string('cannot create local folder'), 'Cannot create folder "' + local_mutated + '"')
			return false
		}
	}
	mut iter_3 := var_list.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_v := item_3.val
		mut var_k := item_3.key
		var_list.array_set(var_k, this.parselisting(var_v.clone()))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_list.array_get(var_k))))) || rt.is_true(rt.equal(var_list.array_get(var_k).array_get(rt.new_string('name')), rt.new_string('.'))) || rt.is_true(rt.equal(var_list.array_get(var_k).array_get(rt.new_string('name')), rt.new_string('..'))) {
			var_list.array_unset(var_k)
		}
	}
	mut var_ret := rt.new_bool(true)
	mut iter_4 := var_list.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_el := item_4.val
		if rt.is_true(rt.equal(var_el.array_get(rt.new_string('type')), rt.new_string('d'))) {
			if !(this.mget(rt.new_string((var_remote_mutated).str() + '/' + (var_el.array_get(rt.new_string('name'))).str()), local_mutated + '/' + (var_el.array_get(rt.new_string('name'))).str(), continious)) {
				this.pusherror(rt.new_string('mget'), rt.new_string('cannot copy folder'), 'Cannot copy remote folder "' + (var_remote_mutated).str() + '/' + (var_el.array_get(rt.new_string('name'))).str() + '" to local "' + local_mutated + '/' + (var_el.array_get(rt.new_string('name'))).str() + '"')
				var_ret = rt.new_bool(false)
				if !(var_continious) {
					break
				}
			}
		} else {
			if rt.is_true(rt.new_bool(!(rt.is_true(this.get(rt.new_string((var_remote_mutated).str() + '/' + (var_el.array_get(rt.new_string('name'))).str()), rt.new_string(local_mutated + '/' + (var_el.array_get(rt.new_string('name'))).str()), 0))))) {
				this.pusherror(rt.new_string('mget'), rt.new_string('cannot copy file'), 'Cannot copy remote file "' + (var_remote_mutated).str() + '/' + (var_el.array_get(rt.new_string('name'))).str() + '" to local "' + local_mutated + '/' + (var_el.array_get(rt.new_string('name'))).str() + '"')
				var_ret = rt.new_bool(false)
				if !(var_continious) {
					break
				}
			}
		}
		rt.call_function('chmod', [rt.new_string(local_mutated + '/' + (var_el.array_get(rt.new_string('name'))).str()), var_el.array_get(rt.new_string('perms'))])
		mut var_t := rt.call_function('strtotime', [var_el.array_get(rt.new_string('date'))])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_t, -1)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_t, rt.new_bool(false))))) {
			rt.call_function('touch', [rt.new_string(local_mutated + '/' + (var_el.array_get(rt.new_string('name'))).str()), var_t.clone()])
		}
	}
	return (var_ret).to_bool()
}

fn (mut this Class_ftp_base) mdel(var_remote rt.PhpVal, continious bool) bool {
	mut var_remote_mutated := var_remote
	mut var_list := this.rawlist((var_remote_mutated).str(), '-la')
	if rt.is_true(rt.identical(var_list, rt.new_bool(false))) {
		this.pusherror(rt.new_string('mdel'), rt.new_string('cannot read remote folder list'), 'Cannot read remote folder "' + (var_remote_mutated).str() + '" contents')
		return false
	}
	mut iter_5 := var_list.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_v := item_5.val
		mut var_k := item_5.key
		var_list.array_set(var_k, this.parselisting(var_v.clone()))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_list.array_get(var_k))))) || rt.is_true(rt.equal(var_list.array_get(var_k).array_get(rt.new_string('name')), rt.new_string('.'))) || rt.is_true(rt.equal(var_list.array_get(var_k).array_get(rt.new_string('name')), rt.new_string('..'))) {
			var_list.array_unset(var_k)
		}
	}
	mut var_ret := rt.new_bool(true)
	mut iter_6 := var_list.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_el := item_6.val
		if !rt.is_true(var_el) {
			continue
		}
		if rt.is_true(rt.equal(var_el.array_get(rt.new_string('type')), rt.new_string('d'))) {
			if !(this.mdel(rt.new_string((var_remote_mutated).str() + '/' + (var_el.array_get(rt.new_string('name'))).str()), continious)) {
				var_ret = rt.new_bool(false)
				if !(var_continious) {
					break
				}
			}
		} else {
			if !(this.delete(rt.new_string((var_remote_mutated).str() + '/' + (var_el.array_get(rt.new_string('name'))).str()))) {
				this.pusherror(rt.new_string('mdel'), rt.new_string('cannot delete file'), 'Cannot delete remote file "' + (var_remote_mutated).str() + '/' + (var_el.array_get(rt.new_string('name'))).str() + '"')
				var_ret = rt.new_bool(false)
				if !(var_continious) {
					break
				}
			}
		}
	}
	if !(this.rmdir(var_remote_mutated.clone())) {
		this.pusherror(rt.new_string('mdel'), rt.new_string('cannot delete folder'), 'Cannot delete remote folder "' + (var_remote_mutated).str() + '/' + (var_el.array_get(rt.new_string('name'))).str() + '"')
	var_ret = rt.new_bool(false)
	}
	return (var_ret).to_bool()
}

fn (mut this Class_ftp_base) mmkdir(var_dir rt.PhpVal, mode i64) bool {
	mut mode_mutated := mode
	if !rt.is_true(var_dir) {
		return false
	}
	if rt.is_true(this.is_exists(var_dir.clone())) || rt.is_true(rt.equal(var_dir, rt.new_string('/'))) {
		return true
	}
	if !(this.mmkdir(rt.call_function('dirname', [var_dir.clone()]), mode_mutated)) {
		return false
	}
	mut var_r := rt.new_bool(this.mkdir(var_dir.clone(), rt.new_int(mode_mutated)))
	this.chmod(var_dir.clone(), rt.new_int(mode_mutated))
	return (var_r).to_bool()
}

fn (mut this Class_ftp_base) glob(var_pattern rt.PhpVal, var_handle rt.PhpVal) rt.PhpVal {
	mut var_pattern_mutated := var_pattern
	mut var_handle_mutated := var_handle
	mut var_output := rt.new_null()
	mut var_path := var_output
	if rt.is_true(rt.equal(rt.get_constant('PHP_OS'), rt.new_string('WIN32'))) {
	mut var_slash := rt.new_string('\\')
	} else {
	var_slash = rt.new_string('/')
	}
	mut var_lastpos := rt.call_function('strrpos', [var_pattern_mutated.clone(), var_slash.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.identical(var_lastpos, rt.new_bool(false)))))) {
	var_path = rt.call_function('substr', [var_pattern_mutated.clone(), rt.new_int(0), rt.sub(rt.sub(rt.new_int(0), var_lastpos), rt.new_int(1))])
	var_pattern_mutated = rt.call_function('substr', [var_pattern_mutated.clone(), var_lastpos.clone()])
	} else {
	var_path = rt.call_function('getcwd', []rt.PhpVal{})
	}
	if var_handle_mutated.clone().is_array() && !(!rt.is_true(var_handle_mutated)) {
		mut iter_7 := var_handle_mutated.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_dir := item_7.val
			if this.glob_pattern_match(var_pattern_mutated.clone(), var_dir.clone()) {
				var_output.array_push(var_dir.clone())
			}
		}
	} else {
		var_handle_mutated = rt.call_function('opendir', [var_path.clone()])
		if rt.is_true(rt.identical(var_handle_mutated, rt.new_bool(false))) {
			return rt.new_bool(false)
		}
		mut var_dir := rt.call_function('readdir', [var_handle_mutated.clone()])
		for rt.is_true(var_dir) {
			if this.glob_pattern_match(var_pattern_mutated.clone(), var_dir.clone()) {
				var_output.array_push(var_dir.clone())
			}
		}
		rt.call_function('closedir', [var_handle_mutated.clone()])
	}
	if rt.is_true(rt.new_bool(var_output.clone().is_array())) {
		return var_output.clone()
	}
	return rt.new_bool(false)
}

fn (mut this Class_ftp_base) glob_pattern_match(var_pattern rt.PhpVal, var_subject rt.PhpVal) bool {
	mut var_pattern_mutated := var_pattern
	mut var_out := rt.new_null()
	mut var_chunks := rt.call_function('explode', [rt.new_string(';'), var_pattern_mutated.clone()])
	mut iter_8 := var_chunks.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_pattern_shadow := item_8.val
		mut var_escape := ['$', '^', '.', '{', '}', '(', ')', '[', ']', '|']
		for rt.is_true(rt.call_function('str_contains', [var_pattern_shadow.clone(), rt.new_string('**')])) {
		var_pattern_shadow = rt.call_function('str_replace', [rt.new_string('**'), rt.new_string('*'), var_pattern_shadow.clone()])
		}
		for var_probe in var_escape {
		var_pattern_shadow = rt.call_function('str_replace', [rt.new_string(probe), rt.new_string("\\${var_probe}"), var_pattern_shadow.clone()])
		}
		var_pattern_shadow = rt.call_function('str_replace', [rt.new_string('?*'), rt.new_string('*'), rt.call_function('str_replace', [rt.new_string('*?'), rt.new_string('*'), rt.call_function('str_replace', [rt.new_string('*'), rt.new_string('.*'), rt.call_function('str_replace', [rt.new_string('?'), rt.new_string('.{1,1}'), var_pattern_shadow.clone()])])])])
		var_out.array_push(var_pattern_shadow.clone())
	}
	if var_out.clone().array_count() == 1 {
		return (this.glob_regexp(rt.new_string((rt.concat(rt.concat(rt.new_string('^'), var_out.array_get(rt.new_int(0))), rt.new_string('$'))).str()), var_subject.clone())).to_bool()
	} else {
		mut iter_9 := var_out.iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_tester := item_9.val
			if rt.is_true(this.my_regexp(rt.new_string((rt.concat(rt.concat(rt.new_string('^'), var_tester), rt.new_string('$'))).str()), var_subject.clone())) {
				return true
			}
		}
	}
	return false
}

fn (mut this Class_ftp_base) glob_regexp(var_pattern rt.PhpVal, var_subject rt.PhpVal) rt.PhpVal {
	mut var_pattern_mutated := var_pattern
	mut var_sensitive := rt.new_bool(!rt.is_true(rt.equal(rt.get_constant('PHP_OS'), rt.new_string('WIN32'))))
	return if rt.is_true(var_sensitive) { rt.call_function('preg_match', [rt.new_string('/' + (rt.call_function('preg_quote', [var_pattern_mutated.clone(), rt.new_string('/')])).str() + '/'), var_subject.clone()]) } else { rt.call_function('preg_match', [rt.new_string('/' + (rt.call_function('preg_quote', [var_pattern_mutated.clone(), rt.new_string('/')])).str() + '/i'), var_subject.clone()]) }
}

fn (mut this Class_ftp_base) dirlist(var_remote rt.PhpVal) rt.PhpVal {
	mut var_remote_mutated := var_remote
	mut var_list := this.rawlist((var_remote_mutated).str(), '-la')
	if rt.is_true(rt.identical(var_list, rt.new_bool(false))) {
		this.pusherror(rt.new_string('dirlist'), rt.new_string('cannot read remote folder list'), 'Cannot read remote folder "' + (var_remote_mutated).str() + '" contents')
		return rt.new_bool(false)
	}
	mut var_dirlist := rt.new_array()
	mut iter_10 := var_list.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_v := item_10.val
		mut var_k := item_10.key
		mut var_entry := this.parselisting(var_v.clone())
		if !rt.is_true(var_entry) {
			continue
		}
		if rt.is_true(rt.equal(var_entry.array_get(rt.new_string('name')), rt.new_string('.'))) || rt.is_true(rt.equal(var_entry.array_get(rt.new_string('name')), rt.new_string('..'))) {
			continue
		}
		var_dirlist.array_set(var_entry.array_get(rt.new_string('name')), var_entry.clone())
	}
	return var_dirlist.clone()
}

fn (mut this Class_ftp_base) _checkcode() bool {
	return this._code < 400 && this._code > 0
}

fn (mut this Class_ftp_base) _list(arg string, cmd string, fnction string) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this._data_prepare())))) {
		return rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this._exec(rt.new_string(cmd + arg), rt.new_string(fnction)))))) {
		this._data_close()
		return rt.new_bool(false)
	}
	if !(this._checkcode()) {
		this._data_close()
		return rt.new_bool(false)
	}
	mut var_out := rt.new_string('')
	if this._code < 200 {
		var_out = this._data_read()
		this._data_close()
		if rt.is_true(rt.new_bool(!(rt.is_true(this._readmsg())))) {
			return rt.new_bool(false)
		}
		if !(this._checkcode()) {
			return rt.new_bool(false)
		}
		if rt.is_true(rt.identical(var_out, rt.new_bool(false))) {
			return rt.new_bool(false)
		}
	var_out = rt.call_function('preg_split', [rt.new_string('/[' + (rt.get_constant('CRLF')).str() + ']+/'), var_out.clone(), rt.new_int(-1), rt.get_constant('PREG_SPLIT_NO_EMPTY')])
	}
	return var_out.clone()
}

fn (mut this Class_ftp_base) pusherror(var_fctname rt.PhpVal, var_msg rt.PhpVal, desc bool) rt.PhpVal {
	mut var_error := rt.new_array()
	var_error['time'] = rt.call_function('time', []rt.PhpVal{})
	var_error['fctname'] = var_fctname.clone()
	var_error['msg'] = var_msg.clone()
	var_error['desc'] = rt.new_bool(desc)
	if var_desc {
	mut var_tmp := rt.new_string(' (' + desc.str() + ')')
	} else {
	var_tmp = rt.new_string('')
	}
	this.sendmsg((var_fctname).str() + ': ' + (var_msg).str() + (var_tmp).str(), false)
	return this._error_array.array_push(rt.create_array_from_native_map(var_error))
}

fn (mut this Class_ftp_base) poperror() bool {
	if rt.is_true(rt.new_int(this._error_array.array_count())) {
		return (rt.call_function('array_pop', [this._error_array])).to_bool()
	} else {
		return false
	}
	return false
}

struct Class_ftp {
	rt.PhpObjectBase
}

struct Class_ftp {
	rt.PhpObjectBase
}

struct Class_ftp_sockets {
	rt.PhpObjectBase
}

struct Class_ftp_pure {
	rt.PhpObjectBase
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

fn create_ftp(_args ...rt.PhpVal) &Class_ftp {
	mut obj := &Class_ftp{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_ftp_sockets(_args ...rt.PhpVal) &Class_ftp_sockets {
	mut obj := &Class_ftp_sockets{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_ftp_pure(_args ...rt.PhpVal) &Class_ftp_pure {
	mut obj := &Class_ftp_pure{
		PhpObjectBase: rt.PhpObjectBase{}
	}
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


fn (mut this Class_ftp) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ftp) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ftp) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ftp_sockets) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ftp_sockets) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ftp_sockets) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ftp_pure) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ftp_pure) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ftp_pure) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('CRLF')]))))) {
		rt.call_function('define', [rt.new_string('CRLF'), rt.new_string('\r\n')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('FTP_AUTOASCII')]))))) {
		rt.call_function('define', [rt.new_string('FTP_AUTOASCII'), rt.new_int(-1)])
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
	mut var_mod_sockets := rt.call_function('extension_loaded', [rt.new_string('sockets')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_mod_sockets)))) && rt.is_true(rt.call_function('function_exists', [rt.new_string('dl')])) && rt.call_function('is_callable', [rt.new_string('dl')]) {
		mut var_prefix := if rt.is_true(rt.equal(rt.get_constant('PHP_SHLIB_SUFFIX'), rt.new_string('dll'))) { 'php_' } else { '' }
		rt.call_function('dl', [rt.new_string(var_prefix + 'sockets.' + (rt.get_constant('PHP_SHLIB_SUFFIX')).str())])
	var_mod_sockets = rt.call_function('extension_loaded', [rt.new_string('sockets')])
	}
	rt.include_file(@DIR + '/class-ftp-' + if rt.is_true(var_mod_sockets) { 'sockets' } else { 'pure' } + '.php', '4')
	if rt.is_true(var_mod_sockets) {
	} else {
	}
}
