import rt

struct Class_ftp_sockets {
	rt.PhpObjectBase
}

fn (mut this Class_ftp_sockets) construct(verb bool, le bool)  {
	this.Class_ftp_base.construct(rt.new_bool(true), rt.new_bool(verb), rt.new_bool(le))
}

fn (mut this Class_ftp_sockets) _settimeout(var_sock rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('socket_set_option', [var_sock.dup(), rt.get_constant('SOL_SOCKET'), rt.get_constant('SO_RCVTIMEO'), rt.create_array([rt.ArrayItem{ key: 'sec', val: rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_timeout') }, rt.ArrayItem{ key: 'usec', val: 0 }])]))))) {
		this.pusherror(rt.new_string('_connect'), rt.new_string('socket set receive timeout'), rt.call_function('socket_strerror', [rt.call_function('socket_last_error', [var_sock.dup()])]))
		rt.call_function('socket_close', [var_sock.dup()])
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('socket_set_option', [var_sock.dup(), rt.get_constant('SOL_SOCKET'), rt.get_constant('SO_SNDTIMEO'), rt.create_array([rt.ArrayItem{ key: 'sec', val: rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_timeout') }, rt.ArrayItem{ key: 'usec', val: 0 }])]))))) {
		this.pusherror(rt.new_string('_connect'), rt.new_string('socket set send timeout'), rt.call_function('socket_strerror', [rt.call_function('socket_last_error', [var_sock.dup()])]))
		rt.call_function('socket_close', [var_sock.dup()])
		return false
	}
	return true
}

fn (mut this Class_ftp_sockets) _connect(var_host rt.PhpVal, var_port rt.PhpVal) bool {
	this.sendmsg(rt.new_string('Creating socket'))
	if rt.is_true(rt.new_bool(!(rt.is_true(mut var_sock := rt.call_function('socket_create', [rt.get_constant('AF_INET'), rt.get_constant('SOCK_STREAM'), rt.get_constant('SOL_TCP')]))))) {
		this.pusherror(rt.new_string('_connect'), rt.new_string('socket create failed'), rt.call_function('socket_strerror', [rt.call_function('socket_last_error', [var_sock.dup()])]))
		return false
	}
	if !(this._settimeout(var_sock.dup())) {
		return false
	}
	this.sendmsg(rt.new_string('Connecting to "' + (var_host).str() + ':' + (var_port).str() + '"'))
	if rt.is_true(rt.new_bool(!(rt.is_true(mut var_res := rt.call_function('socket_connect', [var_sock.dup(), var_host.dup(), var_port.dup()]))))) {
		this.pusherror(rt.new_string('_connect'), rt.new_string('socket connect failed'), rt.call_function('socket_strerror', [rt.call_function('socket_last_error', [var_sock.dup()])]))
		rt.call_function('socket_close', [var_sock.dup()])
		return false
	}
	this.dispatch_set_prop('_connected', rt.new_bool(true))
	return (var_sock).to_bool()
}

fn (mut this Class_ftp_sockets) _readmsg(fnction string) bool {
	mut var_regs := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_connected'))))) {
		this.pusherror(rt.new_string(fnction), rt.new_string('Connect first'))
		return false
	}
	mut var_result := rt.new_bool(rt.new_bool(true))
	this.dispatch_set_prop('_message', rt.new_string(''))
	this.dispatch_set_prop('_code', rt.new_int(0))
	mut var_go := rt.new_bool(rt.new_bool(true))
	for {
		mut var_tmp := rt.call_function('socket_read', [rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_ftp_control_sock'), rt.new_int(4096), rt.get_constant('PHP_BINARY_READ')])
		if rt.is_true(rt.identical(var_tmp, rt.new_bool(false))) {
			var_go = var_result = rt.new_bool(rt.new_bool(false))
			this.pusherror(rt.new_string(fnction), rt.new_string('Read failed'), rt.call_function('socket_strerror', [rt.call_function('socket_last_error', [rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_ftp_control_sock')])]))
		} else {
			// unsupported expression: Expr_AssignOp_Concat
			var_go = rt.new_bool(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', ['/^([0-9]{3})(-.+\\1)? [^' + (rt.get_constant('CRLF')).str() + ']+' + (rt.get_constant('CRLF')).str() + '$/Us', rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_message'), var_regs.dup()])))))
		}
		if !(rt.is_true(var_go)) {
			break
		}
	}
	if rt.is_true(rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), 'LocalEcho')) {
		print('GET < ' + rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_message').trim_right(' \t\n\r') + (rt.get_constant('CRLF')).str())
	}
	this.dispatch_set_prop('_code', // unsupported expression: Expr_Cast_Int)
	return (var_result).to_bool()
}

fn (mut this Class_ftp_sockets) _exec(var_cmd rt.PhpVal, fnction string) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_ready'))))) {
		this.pusherror(rt.new_string(fnction), rt.new_string('Connect first'))
		return false
	}
	if rt.is_true(rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), 'LocalEcho')) {
		print('PUT > ')
		rt.echo_val(var_cmd)
		rt.echo_val(rt.get_constant('CRLF'))
	}
	mut var_status := rt.call_function('socket_write', [rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_ftp_control_sock'), rt.concat(var_cmd, rt.get_constant('CRLF'))])
	if rt.is_true(rt.identical(var_status, rt.new_bool(false))) {
		this.pusherror(rt.new_string(fnction), rt.new_string('socket write failed'), rt.call_function('socket_strerror', [rt.call_function('socket_last_error', [rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), 'stream')])]))
		return false
	}
	this.dispatch_set_prop('_lastaction', rt.call_function('time', []rt.PhpVal{}))
	if !(this._readmsg(fnction)) {
		return false
	}
	return true
}

fn (mut this Class_ftp_sockets) _data_prepare(var_mode rt.PhpVal) bool {
	mut var_addr := rt.new_null()
	mut var_port := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(this._settype(var_mode.dup()))))) {
		return false
	}
	this.sendmsg(rt.new_string('Creating data socket'))
	this.dispatch_set_prop('_ftp_data_sock', rt.call_function('socket_create', [rt.get_constant('AF_INET'), rt.get_constant('SOCK_STREAM'), rt.get_constant('SOL_TCP')]))
	if rt.is_true(rt.less(rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_ftp_data_sock'), rt.new_int(0))) {
		this.pusherror(rt.new_string('_data_prepare'), rt.new_string('socket create failed'), rt.call_function('socket_strerror', [rt.call_function('socket_last_error', [rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_ftp_data_sock')])]))
		return false
	}
	if !(this._settimeout(rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_ftp_data_sock'))) {
		this._data_close()
		return false
	}
	if rt.is_true(rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_passive')) {
		if !(this._exec(rt.new_string('PASV'), 'pasv')) {
			this._data_close()
			return false
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(this._checkcode())))) {
			this._data_close()
			return false
		}
		mut var_ip_port := rt.call_function('explode', [rt.new_string(','), rt.call_function('preg_replace', [rt.new_string('/^.+ \\(?([0-9]{1,3},[0-9]{1,3},[0-9]{1,3},[0-9]{1,3},[0-9]+,[0-9]+)\\)?.*$/s'), rt.new_string('\\1'), rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_message')])])
		this.dispatch_set_prop('_datahost', (var_ip_port.array_get(0)).str() + '.' + (var_ip_port.array_get(1)).str() + '.' + (var_ip_port.array_get(2)).str() + '.' + (var_ip_port.array_get(3)).str())
		this.dispatch_set_prop('_dataport', rt.add(rt.shift_left(// unsupported expression: Expr_Cast_Int, rt.new_int(8)), // unsupported expression: Expr_Cast_Int))
		this.sendmsg(rt.new_string('Connecting to ' + (rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_datahost')).str() + ':' + (rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_dataport')).str()))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('socket_connect', [rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_ftp_data_sock'), rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_datahost'), rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_dataport')]))))) {
			this.pusherror(rt.new_string('_data_prepare'), rt.new_string('socket_connect'), rt.call_function('socket_strerror', [rt.call_function('socket_last_error', [rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_ftp_data_sock')])]))
			this._data_close()
			return false
		} else {
			this.dispatch_set_prop('_ftp_temp_sock', rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_ftp_data_sock'))
		}
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('socket_getsockname', [rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_ftp_control_sock'), var_addr.dup(), var_port.dup()]))))) {
			this.pusherror(rt.new_string('_data_prepare'), rt.new_string('cannot get control socket information'), rt.call_function('socket_strerror', [rt.call_function('socket_last_error', [rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_ftp_control_sock')])]))
			this._data_close()
			return false
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('socket_bind', [rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_ftp_data_sock'), var_addr.dup()]))))) {
			this.pusherror(rt.new_string('_data_prepare'), rt.new_string('cannot bind data socket'), rt.call_function('socket_strerror', [rt.call_function('socket_last_error', [rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_ftp_data_sock')])]))
			this._data_close()
			return false
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('socket_listen', [rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_ftp_data_sock')]))))) {
			this.pusherror(rt.new_string('_data_prepare'), rt.new_string('cannot listen data socket'), rt.call_function('socket_strerror', [rt.call_function('socket_last_error', [rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_ftp_data_sock')])]))
			this._data_close()
			return false
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('socket_getsockname', [rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_ftp_data_sock'), rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_datahost'), rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_dataport')]))))) {
			this.pusherror(rt.new_string('_data_prepare'), rt.new_string('cannot get data socket information'), rt.call_function('socket_strerror', [rt.call_function('socket_last_error', [rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_ftp_data_sock')])]))
			this._data_close()
			return false
		}
		if !(this._exec(rt.new_string('PORT ' + (rt.call_function('str_replace', [rt.new_string('.'), rt.new_string(','), (rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_datahost')).str() + '.' + rt.shift_right(rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_dataport'), rt.new_int(8)).str() + '.' + rt.bitwise_and(rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_dataport'), rt.new_int(255)).str()])).str()), '_port')) {
			this._data_close()
			return false
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(this._checkcode())))) {
			this._data_close()
			return false
		}
	}
	return true
}

fn (mut this Class_ftp_sockets) _data_read(var_mode rt.PhpVal, var_fp rt.PhpVal) bool {
	mut var_NewLine := rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_eol_code').array_get(rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), 'OS_local'))
	if rt.is_true(rt.call_function('is_resource', [var_fp.dup()])) {
		mut var_out := rt.new_int(rt.new_int(0))
	} else {
		var_out = rt.new_string(rt.new_string(''))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_passive'))))) {
		this.sendmsg(rt.new_string('Connecting to ' + (rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_datahost')).str() + ':' + (rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_dataport')).str()))
		this.dispatch_set_prop('_ftp_temp_sock', rt.call_function('socket_accept', [rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_ftp_data_sock')]))
		if rt.is_true(rt.identical(rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_ftp_temp_sock'), rt.new_bool(false))) {
			this.pusherror(rt.new_string('_data_read'), rt.new_string('socket_accept'), rt.call_function('socket_strerror', [rt.call_function('socket_last_error', [rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_ftp_temp_sock')])]))
			this._data_close()
			return false
		}
	}
	for rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if rt.is_true(rt.identical(var_block, rt.new_string(''))) {
			break
		}
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
			mut var_block := rt.call_function('preg_replace', [rt.new_string('/\r\n|\r|\n/'), rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_eol_code').array_get(rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), 'OS_local')), var_block.dup()])
		}
		if rt.is_true(rt.call_function('is_resource', [var_fp.dup()])) {
			// unsupported expression: Expr_AssignOp_Plus
		} else {
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	return (var_out).to_bool()
}

fn (mut this Class_ftp_sockets) _data_write(var_mode rt.PhpVal, var_fp rt.PhpVal) bool {
	mut var_NewLine := rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_eol_code').array_get(rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), 'OS_local'))
	if rt.is_true(rt.call_function('is_resource', [var_fp.dup()])) {
		mut var_out := rt.new_int(rt.new_int(0))
	} else {
		var_out = rt.new_string(rt.new_string(''))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.new_object('ftp_sockets', ['ftp_base'], &this), '_passive'))))) {
		this.sendmsg(rt.new_string( + ().str()))
		this.dispatch_set_prop('_ftp_temp_sock', )
		if rt.is_true() {
		}
	}
	if rt.is_true(rt.call_function('is_resource', [.dup()])) {
		for rt.is_true() {
		}
	} else if !() {
	}
	return 
}

fn (mut this Class_ftp_sockets) _data_write_block(var_mode rt.PhpVal, var_block rt.PhpVal) bool {
	mut var_block_mutated := var_block
}

fn (mut this Class_ftp_sockets) _data_close() bool {
}

fn (mut this Class_ftp_sockets) _quit()  {
}

struct Class_ftp_base {
	rt.PhpObjectBase
}

fn create_ftp_sockets(verb bool, le bool) &Class_ftp_sockets {
	mut obj := &Class_ftp_sockets{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(verb, le)
	return obj
}

fn create_ftp_base() &Class_ftp_base {
	mut obj := &Class_ftp_base{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ftp_sockets) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'_settimeout' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this._settimeout(dispatch_arg_0))
		}
		'_connect' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this._connect(dispatch_arg_0, dispatch_arg_1))
		}
		'_readmsg' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this._readmsg(dispatch_arg_0))
		}
		'_exec' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this._exec(dispatch_arg_0, dispatch_arg_1))
		}
		'_data_prepare' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this._data_prepare(dispatch_arg_0))
		}
		'_data_read' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this._data_read(dispatch_arg_0, dispatch_arg_1))
		}
		'_data_write' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this._data_write(dispatch_arg_0, dispatch_arg_1))
		}
		'_data_write_block' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this._data_write_block(dispatch_arg_0, dispatch_arg_1))
		}
		'_data_close' {
			return rt.new_bool(this._data_close())
		}
		'_quit' {
			this._quit()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_ftp_sockets) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ftp_sockets) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ftp_base) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ftp_base) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ftp_base) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_admin_includes_class_ftp_sockets_php() {
}
