import rt

struct Class_ftp_pure {
	rt.PhpObjectBase
}

fn (mut this Class_ftp_pure) construct(verb bool, le bool) {
	this.Class_ftp_base.construct(rt.new_bool(false), rt.new_bool(verb), rt.new_bool(le))
}

fn (mut this Class_ftp_pure) _settimeout(var_sock rt.PhpVal) bool {
	mut var_sock_mutated := var_sock
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('stream_set_timeout', [
		var_sock_mutated.clone(),
		rt.get_property(rt.new_object('ftp_pure', ['ftp_base'], &this), '_timeout'),
	])))))
	{
		this.pusherror(rt.new_string('_settimeout'), rt.new_string('socket set send timeout'))
		this._quit(false)
		return false
	}
	return true
}

fn (mut this Class_ftp_pure) _connect(var_host rt.PhpVal, var_port rt.PhpVal) bool {
	mut var_errno := rt.new_null()
	mut var_errstr := rt.new_null()
	this.sendmsg(rt.new_string('Creating socket'))
	mut var_sock := rt.call_function('fsockopen', [var_host.clone(),
		var_port.clone(), var_errno.clone(), var_errstr.clone(),
		rt.get_property(rt.new_object('ftp_pure', ['ftp_base'], &this), '_timeout')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_sock)))) {
		this.pusherror(rt.new_string('_connect'), rt.new_string('socket connect failed'), rt.new_string(
			var_errstr.str() + ' (' + var_errno.str() + ')'))
		return false
	}
	this.dispatch_set_prop('_connected', rt.new_bool(true))
	return var_sock.to_bool()
}

fn (mut this Class_ftp_pure) _readmsg(fnction string) bool {
	mut var_regs := []rt.PhpVal{}
	if !(rt.get_property(rt.new_object('ftp_pure', ['ftp_base'], &this), '_connected')) {
		this.pusherror(rt.new_string(fnction), rt.new_string('Connect first'))
		return false
	}
	mut var_result := rt.new_bool(true)
	this.dispatch_set_prop('_message', rt.new_string(''))
	this.dispatch_set_prop('_code', rt.new_int(0))
	mut var_go := rt.new_bool(true)
	for {
		mut var_tmp := rt.call_function('fgets', [
			rt.get_property(rt.new_object('ftp_pure', ['ftp_base'], &this), '_ftp_control_sock'),
			rt.new_int(512),
		])
		if rt.is_true(rt.identical(var_tmp, rt.new_bool(false))) {
			var_result = rt.new_bool(false)
			var_go = var_result
			this.pusherror(rt.new_string(fnction), rt.new_string('Read failed'))
		} else {
			rt.get_property(rt.new_object('ftp_pure', ['ftp_base'], &this), '_message') = rt.concat(rt.get_property(rt.new_object('ftp_pure', [
				'ftp_base',
			], &this), '_message'), var_tmp)
			if rt.is_true(rt.call_function('preg_match', [
				rt.new_string('/^([0-9]{3})(-(.*[' +
					(rt.get_constant('CRLF')).str() + ']{1,2})+\\1)? [^' + (rt.get_constant('CRLF')).str() + ']+[' + (rt.get_constant('CRLF')).str() + ']{1,2}$/'),
				rt.get_property(rt.new_object('ftp_pure', ['ftp_base'], &this), '_message'),
				rt.create_array_from_list(var_regs),
			]))
			{
				var_go = rt.new_bool(false)
			}
		}
		if !(rt.is_true(var_go)) {
			break
		}
	}
	if rt.is_true(rt.get_property(rt.new_object('ftp_pure', ['ftp_base'], &this), 'LocalEcho')) {
		print('GET < ' +
			rt.get_property(rt.new_object('ftp_pure', ['ftp_base'], &this), '_message').trim_right(' \t\n\r') +
			(rt.get_constant('CRLF')).str())
	}
	this.dispatch_set_prop('_code', rt.new_int((var_regs.array_get(rt.new_int(1))).to_i64()))
	return var_result.to_bool()
}

fn (mut this Class_ftp_pure) _exec(var_cmd rt.PhpVal, fnction string) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.new_object('ftp_pure', [
		'ftp_base',
	], &this), '_ready')))))
	{
		this.pusherror(rt.new_string(fnction), rt.new_string('Connect first'))
		return false
	}
	if rt.is_true(rt.get_property(rt.new_object('ftp_pure', ['ftp_base'], &this), 'LocalEcho')) {
		print('PUT > ')
		rt.echo_val(var_cmd)
		rt.echo_val(rt.get_constant('CRLF'))
	}
	mut var_status := rt.call_function('fputs', [
		rt.get_property(rt.new_object('ftp_pure', ['ftp_base'], &this), '_ftp_control_sock'),
		rt.new_string(var_cmd.str() + (rt.get_constant('CRLF')).str()),
	])
	if rt.is_true(rt.identical(var_status, rt.new_bool(false))) {
		this.pusherror(rt.new_string(fnction), rt.new_string('socket write failed'))
		return false
	}
	this.dispatch_set_prop('_lastaction', rt.call_function('time', []rt.PhpVal{}))
	if !(this._readmsg(fnction)) {
		return false
	}
	return true
}

fn (mut this Class_ftp_pure) _data_prepare(var_mode rt.PhpVal) bool {
	mut var_errno := rt.new_null()
	mut var_errstr := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(this._settype(var_mode.clone()))))) {
		return false
	}
	if rt.is_true(rt.get_property(rt.new_object('ftp_pure', ['ftp_base'], &this), '_passive')) {
		if !(this._exec(rt.new_string('PASV'), 'pasv')) {
			this._data_close()
			return false
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(this._checkcode())))) {
			this._data_close()
			return false
		}
		mut var_ip_port := rt.call_function('explode', [rt.new_string(','),
			rt.call_function('preg_replace', [
				rt.new_string('/^.+ \\(?([0-9]{1,3},[0-9]{1,3},[0-9]{1,3},[0-9]{1,3},[0-9]+,[0-9]+)\\)?.*$/s'),
				rt.new_string('\\1'),
				rt.get_property(rt.new_object('ftp_pure', ['ftp_base'], &this), '_message'),
			])])
		this.dispatch_set_prop('_datahost', (var_ip_port.array_get(rt.new_int(0))).str() + '.' +
			(var_ip_port.array_get(rt.new_int(1))).str() + '.' +
			(var_ip_port.array_get(rt.new_int(2))).str() + '.' +
			(var_ip_port.array_get(rt.new_int(3))).str())
		this.dispatch_set_prop('_dataport',
			rt.new_int((var_ip_port.array_get(rt.new_int(4))).to_i64()) << 8 +
			rt.new_int((var_ip_port.array_get(rt.new_int(5))).to_i64()))
		this.sendmsg(rt.new_string('Connecting to ' +
			(rt.get_property(rt.new_object('ftp_pure', ['ftp_base'], &this), '_datahost')).str() +
			':' +
			(rt.get_property(rt.new_object('ftp_pure', ['ftp_base'], &this), '_dataport')).str()))
		this.dispatch_set_prop('_ftp_data_sock', rt.call_function('fsockopen', [
			rt.get_property(rt.new_object('ftp_pure', ['ftp_base'], &this), '_datahost'),
			rt.get_property(rt.new_object('ftp_pure', ['ftp_base'], &this), '_dataport'),
			var_errno.clone(),
			var_errstr.clone(),
			rt.get_property(rt.new_object('ftp_pure', ['ftp_base'], &this), '_timeout'),
		]))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.new_object('ftp_pure', [
			'ftp_base',
		], &this), '_ftp_data_sock')))))
		{
			this.pusherror(rt.new_string('_data_prepare'), rt.new_string('fsockopen fails'), rt.new_string(
				var_errstr.str() + ' (' + var_errno.str() + ')'))
			this._data_close()
			return false
		} else {
			rt.get_property(rt.new_object('ftp_pure', ['ftp_base'], &this), '_ftp_data_sock')
		}
	} else {
		this.sendmsg(rt.new_string('Only passive connections available!'))
		return false
	}
	return true
}

fn (mut this Class_ftp_pure) _data_read(var_mode rt.PhpVal, var_fp rt.PhpVal) bool {
	if rt.is_true(rt.call_function('is_resource', [var_fp.clone()])) {
		mut var_out := rt.new_int(0)
	} else {
		var_out = rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.new_object('ftp_pure', [
		'ftp_base',
	], &this), '_passive')))))
	{
		this.sendmsg(rt.new_string('Only passive connections available!'))
		return false
	}
	for rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('feof', [
		rt.get_property(rt.new_object('ftp_pure', ['ftp_base'], &this), '_ftp_data_sock'),
	]))))) {
		mut var_block := rt.call_function('fread', [
			rt.get_property(rt.new_object('ftp_pure', ['ftp_base'], &this), '_ftp_data_sock'),
			rt.get_property(rt.new_object('ftp_pure', ['ftp_base'], &this), '_ftp_buff_size'),
		])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_mode, rt.get_constant('FTP_BINARY'))))) {
			var_block = rt.call_function('preg_replace', [rt.new_string('/\r\n|\r|\n/'),
				rt.get_property(rt.new_object('ftp_pure', ['ftp_base'], &this), '_eol_code').array_get(rt.get_property(rt.new_object('ftp_pure', [
					'ftp_base'], &this), 'OS_local')),
				var_block.clone()])
		}
		if rt.is_true(rt.call_function('is_resource', [var_fp.clone()])) {
			var_out = rt.add(var_out, rt.call_function('fwrite', [
				var_fp.clone(), var_block.clone(), rt.new_int(var_block.clone().to_string().len)]))
		} else {
			var_out = rt.concat(var_out, var_block)
		}
	}
	return var_out.to_bool()
}

fn (mut this Class_ftp_pure) _data_write(var_mode rt.PhpVal, var_fp rt.PhpVal) bool {
	if rt.is_true(rt.call_function('is_resource', [var_fp.clone()])) {
		mut var_out := rt.new_int(0)
	} else {
		var_out = rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.new_object('ftp_pure', [
		'ftp_base',
	], &this), '_passive')))))
	{
		this.sendmsg(rt.new_string('Only passive connections available!'))
		return false
	}
	if rt.is_true(rt.call_function('is_resource', [var_fp.clone()])) {
		for rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('feof', [
			var_fp.clone()]))))) {
			mut var_block := rt.call_function('fread', [var_fp.clone(),
				rt.get_property(rt.new_object('ftp_pure', ['ftp_base'], &this), '_ftp_buff_size')])
			if !(this._data_write_block(var_mode.clone(), var_block.clone())) {
				return false
			}
		}
	} else if !(this._data_write_block(var_mode.clone(), var_fp.clone())) {
		return false
	}
	return true
}

fn (mut this Class_ftp_pure) _data_write_block(var_mode rt.PhpVal, var_block rt.PhpVal) bool {
	mut var_block_mutated := var_block
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_mode, rt.get_constant('FTP_BINARY'))))) {
		var_block_mutated = rt.call_function('preg_replace', [
			rt.new_string('/\r\n|\r|\n/'),
			rt.get_property(rt.new_object('ftp_pure', ['ftp_base'], &this), '_eol_code').array_get(rt.get_property(rt.new_object('ftp_pure', [
				'ftp_base'], &this), 'OS_remote')),
			var_block_mutated.clone(),
		])
	}
	for {
		mut var_t := rt.call_function('fwrite', [
			rt.get_property(rt.new_object('ftp_pure', ['ftp_base'], &this), '_ftp_data_sock'),
			var_block_mutated.clone(),
		])
		if rt.is_true(rt.identical(var_t, rt.new_bool(false))) {
			this.pusherror(rt.new_string('_data_write'), rt.new_string("Can't write to socket"))
			return false
		}
		var_block_mutated = rt.call_function('substr', [var_block_mutated.clone(),
			var_t.clone()])
		if !(!(!rt.is_true(var_block_mutated))) {
			break
		}
	}
	return true
}

fn (mut this Class_ftp_pure) _data_close() bool {
	rt.call_function('fclose', [
		rt.get_property(rt.new_object('ftp_pure', ['ftp_base'], &this), '_ftp_data_sock'),
	])
	this.sendmsg(rt.new_string('Disconnected data from remote host'))
	return true
}

fn (mut this Class_ftp_pure) _quit(force bool) {
	if rt.get_property(rt.new_object('ftp_pure', ['ftp_base'], &this), '_connected') || var_force {
		rt.call_function('fclose', [
			rt.get_property(rt.new_object('ftp_pure', ['ftp_base'], &this), '_ftp_control_sock'),
		])
		this.dispatch_set_prop('_connected', rt.new_bool(false))
		this.sendmsg(rt.new_string('Socket closed'))
	}
}

struct Class_ftp_base {
	rt.PhpObjectBase
}

fn create_ftp_pure(verb bool, le bool) &Class_ftp_pure {
	mut obj := &Class_ftp_pure{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(verb, le)
	return obj
}

fn create_ftp_base(_args ...rt.PhpVal) &Class_ftp_base {
	mut obj := &Class_ftp_base{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ftp_pure) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this._quit(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_ftp_pure) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ftp_pure) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
