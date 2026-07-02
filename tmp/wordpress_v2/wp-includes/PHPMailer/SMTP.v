import rt
import crypto.md5

pub fn Class_PHPMailer_PHPMailer_SMTP.version() string {
	return '7.0.2'
}

pub fn Class_PHPMailer_PHPMailer_SMTP.le() string {
	return '\r\n'
}

pub fn Class_PHPMailer_PHPMailer_SMTP.default_port() i64 {
	return 25
}

pub fn Class_PHPMailer_PHPMailer_SMTP.default_secure_port() i64 {
	return 465
}

pub fn Class_PHPMailer_PHPMailer_SMTP.max_line_length() i64 {
	return 998
}

pub fn Class_PHPMailer_PHPMailer_SMTP.max_reply_length() i64 {
	return 512
}

pub fn Class_PHPMailer_PHPMailer_SMTP.debug_off() i64 {
	return 0
}

pub fn Class_PHPMailer_PHPMailer_SMTP.debug_client() i64 {
	return 1
}

pub fn Class_PHPMailer_PHPMailer_SMTP.debug_server() i64 {
	return 2
}

pub fn Class_PHPMailer_PHPMailer_SMTP.debug_connection() i64 {
	return 3
}

pub fn Class_PHPMailer_PHPMailer_SMTP.debug_lowlevel() i64 {
	return 4
}

struct Class_PHPMailer_PHPMailer_SMTP {
	rt.PhpObjectBase
pub mut:
	do_debug                     rt.PhpVal = rt.new_null()
	Debugoutput                  rt.PhpVal = rt.new_string('echo')
	do_verp                      rt.PhpVal = rt.new_bool(false)
	do_smtputf8                  rt.PhpVal = rt.new_bool(false)
	Timeout                      rt.PhpVal = rt.new_int(300)
	Timelimit                    rt.PhpVal = rt.new_int(300)
	smtp_transaction_id_patterns rt.PhpVal = rt.new_array()
	last_smtp_transaction_id     rt.PhpVal = rt.new_null()
	smtp_conn                    rt.PhpVal = rt.new_null()
	error                        rt.PhpVal = rt.new_array()
	helo_rply                    rt.PhpVal = rt.new_null()
	server_caps                  rt.PhpVal = rt.new_null()
	last_reply                   rt.PhpVal = rt.new_string('')
}

fn init_static_phpmailer_phpmailer_smtp() {
	rt.init_static_prop('PHPMailer_PHPMailer_SMTP', 'xclient_allowed_attributes', rt.create_array([
		rt.ArrayItem{ key: none, val: 'NAME' },
		rt.ArrayItem{ key: none, val: 'ADDR' },
		rt.ArrayItem{ key: none, val: 'PORT' },
		rt.ArrayItem{ key: none, val: 'PROTO' },
		rt.ArrayItem{ key: none, val: 'HELO' },
		rt.ArrayItem{ key: none, val: 'LOGIN' },
		rt.ArrayItem{ key: none, val: 'DESTADDR' },
		rt.ArrayItem{ key: none, val: 'DESTPORT' },
	]))
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) edebug(var_str rt.PhpVal, level i64) {
	mut var_str_mutated := var_str
	if rt.is_true(rt.greater(rt.new_int(level), this.do_debug)) {
		return
	}
	if rt.is_true(rt.new_bool(rt.instance_of(this.Debugoutput,
		'PHPMailer_PHPMailer_Psr_Log_LoggerInterface')))
	{
		rt.call_method(this.Debugoutput, 'debug', [
			rt.new_string(var_str_mutated.clone().to_string().trim_right(' \t\n\r')),
		])
		return
	}
	if rt.call_function('is_callable', [this.Debugoutput])
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [this.Debugoutput, rt.create_array([rt.ArrayItem{
		key: none
		val: 'error_log'
	}, rt.ArrayItem{ key: none, val: 'html' }, rt.ArrayItem{ key: none, val: 'echo' }])]))))) {
		rt.call_function('call_user_func', [this.Debugoutput, var_str_mutated.clone(),
			rt.new_int(level)])
		return
	}
	mut switch_val_1 := this.Debugoutput
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('error_log'))) {
		rt.call_function('error_log', [var_str_mutated.clone()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('html'))) {
		rt.echo_val(rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s')]))
		print(' ')
		rt.echo_val(rt.call_function('htmlentities', [
			rt.call_function('preg_replace', [rt.new_string('/[\\r\\n]+/'),
				rt.new_string(''), var_str_mutated.clone()]),
			rt.get_constant('ENT_QUOTES'),
			rt.new_string('UTF-8'),
		]))
		print('<br>\n')
	} else {
		var_str_mutated = rt.call_function('preg_replace', [
			rt.new_string('/\\r\\n|\\r/m'),
			rt.new_string('\n'),
			var_str_mutated.clone(),
		])
		rt.echo_val(rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s')]))
		print('\t')
		print(rt.call_function('str_replace', [rt.new_string('\n'),
			rt.new_string('\n                   \t                  '),
			rt.new_string(var_str_mutated.clone().to_string().trim_space())]).to_string().trim_space())
		print('\n')
	}
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) connect(var_host rt.PhpVal, var_port rt.PhpVal, timeout i64, var_options rt.PhpVal) bool {
	mut var_port_mutated := var_port
	this.seterror(rt.new_string(''), '', '', '')
	if this.connected() {
		this.seterror(rt.new_string('Already connected to a server'), '', '', '')
		return false
	}
	if !rt.is_true(var_port_mutated) {
		var_port_mutated = Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.default_port()
	}
	this.edebug(rt.new_string(
		'Connection: opening to ${var_host.to_string()}:${var_port.to_string()}, timeout=${var_timeout.str()}, options=' +(if var_options.clone().array_count() > 0 { rt.call_function('var_export', [var_options.clone(), rt.new_bool(true)]) } else { rt.new_string('array()') }).str()),
		(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_connection()).to_i64())
	this.smtp_conn = this.getsmtpconnection(var_host.clone(), var_port_mutated.clone(), timeout,
		var_options.clone())
	if rt.is_true(rt.identical(this.smtp_conn, rt.new_bool(false))) {
		return false
	}
	this.edebug(rt.new_string('Connection: opened'),
		(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_connection()).to_i64())
	this.last_reply = this.get_lines()
	this.edebug(rt.new_string('SERVER -> CLIENT: ' + (this.last_reply).str()),
		(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_server()).to_i64())
	mut var_responseCode := rt.new_int((rt.call_function('substr', [this.last_reply, rt.new_int(0),
		rt.new_int(3)])).to_i64())
	if rt.is_true(rt.identical(var_responseCode, rt.new_int(220))) {
		return true
	}
	if rt.is_true(rt.identical(var_responseCode, rt.new_int(554))) {
		this.quit(false)
	}
	this.edebug(rt.new_string('Connection: closing due to error'),
		(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_connection()).to_i64())
	this.close()
	return false
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) getsmtpconnection(var_host rt.PhpVal, var_port rt.PhpVal, timeout i64, var_options rt.PhpVal) bool {
	mut var_port_mutated := var_port
	mut var_streamok := rt.new_null()
	if rt.is_true(rt.identical(rt.new_null(), var_streamok)) {
		var_streamok = rt.call_function('function_exists', [
			rt.new_string('stream_socket_client'),
		])
	}
	mut var_errno := rt.new_int(0)
	mut var_errstr := rt.new_string('')
	if rt.is_true(var_streamok) {
		mut var_socket_context := rt.call_function('stream_context_create', [
			var_options.clone()])
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			rt.call_function('call_user_func_array', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('PHPMailer_PHPMailer_SMTP',
						[]string{}, &this) },
					rt.ArrayItem{ key: none, val: 'errorHandler' },
				]),
				rt.call_function('func_get_args', []rt.PhpVal{}),
			])
			return rt.new_null()
		}
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			rt.call_function('call_user_func_array', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('PHPMailer_PHPMailer_SMTP',
						[]string{}, &this) },
					rt.ArrayItem{ key: none, val: 'errorHandler' },
				]),
				rt.call_function('func_get_args', []rt.PhpVal{}),
			])
			return rt.new_null()
		}
		rt.call_function('set_error_handler', [rt.new_closure(closure_1_fn)])
		mut var_connection := rt.call_function('stream_socket_client', [
			rt.new_string(var_host.str() + ':' + var_port_mutated.str()),
			var_errno.clone(),
			var_errstr.clone(),
			rt.new_int(timeout),
			rt.get_constant('STREAM_CLIENT_CONNECT'),
			var_socket_context.clone(),
		])
	} else {
		this.edebug(rt.new_string('Connection: stream_socket_client not available, falling back to fsockopen'),
			(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_connection()).to_i64())
		closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			rt.call_function('call_user_func_array', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('PHPMailer_PHPMailer_SMTP',
						[]string{}, &this) },
					rt.ArrayItem{ key: none, val: 'errorHandler' },
				]),
				rt.call_function('func_get_args', []rt.PhpVal{}),
			])
			return rt.new_null()
		}
		closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			rt.call_function('call_user_func_array', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('PHPMailer_PHPMailer_SMTP',
						[]string{}, &this) },
					rt.ArrayItem{ key: none, val: 'errorHandler' },
				]),
				rt.call_function('func_get_args', []rt.PhpVal{}),
			])
			return rt.new_null()
		}
		rt.call_function('set_error_handler', [rt.new_closure(closure_3_fn)])
		var_connection = rt.call_function('fsockopen', [var_host.clone(),
			var_port_mutated.clone(), var_errno.clone(), var_errstr.clone(),
			rt.new_int(timeout)])
	}
	rt.call_function('restore_error_handler', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [
		var_connection.clone()])))))
	{
		this.seterror(rt.new_string('Failed to connect to server'), '', var_errno.str(),
			var_errstr.str())
		this.edebug(rt.new_string('SMTP ERROR: ' +
			(this.error.array_get(rt.new_string('error'))).str() + ': ${var_errstr.to_string()} (${var_errno.to_string()})'),
			(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_client()).to_i64())
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
		rt.get_constant('PHP_OS'),
		rt.new_string('WIN'),
	]), rt.new_int(0)))))
	{
		mut var_max := rt.new_int((rt.call_function('ini_get', [
			rt.new_string('max_execution_time'),
		])).to_i64())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_max))))
			&& rt.is_true(rt.greater(rt.new_int(timeout), var_max))
			&& rt.is_true(rt.identical(rt.call_function('strpos', [rt.call_function('ini_get', [rt.new_string('disable_functions')]), rt.new_string('set_time_limit')]), rt.new_bool(false))) {
			rt.call_function('set_time_limit', [rt.new_int(timeout)])
		}
		rt.call_function('stream_set_timeout', [var_connection.clone(),
			rt.new_int(timeout), rt.new_int(0)])
	}
	return var_connection.to_bool()
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) starttls() bool {
	if !(this.sendcommand(rt.new_string('STARTTLS'), rt.new_string('STARTTLS'), rt.new_int(220))) {
		return false
	}
	mut var_crypto_method := rt.get_constant('STREAM_CRYPTO_METHOD_TLS_CLIENT')
	if rt.is_true(rt.call_function('defined', [
		rt.new_string('STREAM_CRYPTO_METHOD_TLSv1_2_CLIENT'),
	]))
	{
		rt.new_null()
		rt.new_null()
	}
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		rt.call_function('call_user_func_array', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('PHPMailer_PHPMailer_SMTP', []string{},
					&this) },
				rt.ArrayItem{ key: none, val: 'errorHandler' },
			]),
			rt.call_function('func_get_args', []rt.PhpVal{}),
		])
		return rt.new_null()
	}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		rt.call_function('call_user_func_array', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('PHPMailer_PHPMailer_SMTP', []string{},
					&this) },
				rt.ArrayItem{ key: none, val: 'errorHandler' },
			]),
			rt.call_function('func_get_args', []rt.PhpVal{}),
		])
		return rt.new_null()
	}
	rt.call_function('set_error_handler', [rt.new_closure(closure_5_fn)])
	mut var_crypto_ok := rt.call_function('stream_socket_enable_crypto', [this.smtp_conn,
		rt.new_bool(true), var_crypto_method.clone()])
	rt.call_function('restore_error_handler', []rt.PhpVal{})
	return var_crypto_ok.to_bool()
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) authenticate(var_username rt.PhpVal, var_password rt.PhpVal, var_authtype rt.PhpVal, var_OAuth rt.PhpVal) bool {
	mut var_authtype_mutated := var_authtype
	if rt.is_true(rt.new_bool(!(rt.is_true(this.server_caps)))) {
		this.seterror(rt.new_string('Authentication is not allowed before HELO/EHLO'), '', '', '')
		return false
	}
	if rt.is_true(rt.new_bool(this.server_caps.array_isset(rt.new_string('EHLO')))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.server_caps.array_isset(rt.new_string('AUTH'))))))) {
			this.seterror(rt.new_string('Authentication is not allowed at this stage'), '', '', '')
			return false
		}
		this.edebug(rt.new_string('Auth method requested: ' +(if rt.is_true(var_authtype_mutated) { var_authtype_mutated } else { rt.new_string('UNSPECIFIED') }).str()),
			(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_lowlevel()).to_i64())
		this.edebug(rt.new_string('Auth methods available on the server: ' +(rt.call_function('implode', [rt.new_string(','), this.server_caps.array_get(rt.new_string('AUTH'))])).str()),
			(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_lowlevel()).to_i64())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_authtype_mutated))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_authtype_mutated.clone(), this.server_caps.array_get(rt.new_string('AUTH')), rt.new_bool(true)]))))) {
			this.edebug(rt.new_string('Requested auth method not available: ' +
				var_authtype_mutated.str()),
				(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_lowlevel()).to_i64())
			var_authtype_mutated = rt.new_null()
		}
		if !rt.is_true(var_authtype_mutated) {
			mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'CRAM-MD5' },
				rt.ArrayItem{ key: none, val: 'LOGIN' }, rt.ArrayItem{ key: none, val: 'PLAIN' },
				rt.ArrayItem{ key: none, val: 'XOAUTH2' }]).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_method := item_1.val
				if rt.is_true(rt.call_function('in_array', [var_method.clone(),
					this.server_caps.array_get(rt.new_string('AUTH')),
					rt.new_bool(true)]))
				{
					var_authtype_mutated = var_method
					break
				}
			}
			if !rt.is_true(var_authtype_mutated) {
				this.seterror(rt.new_string('No supported authentication methods found'), '', '',
					'')
				return false
			}
			this.edebug(rt.new_string('Auth method selected: ' + var_authtype_mutated.str()),
				(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_lowlevel()).to_i64())
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_authtype_mutated.clone(), this.server_caps.array_get(rt.new_string('AUTH')),
			rt.new_bool(true)])))))
		{
			this.seterror(rt.new_string("The requested authentication method \"${var_authtype.to_string()}\" is not supported by the server"),
				'', '', '')
			return false
		}
	} else if !rt.is_true(var_authtype_mutated) {
		var_authtype_mutated = rt.new_string('LOGIN')
	}
	mut switch_val_2 := var_authtype_mutated
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('PLAIN'))) {
		if !(this.sendcommand(rt.new_string('AUTH'), rt.new_string('AUTH PLAIN'), rt.new_int(334))) {
			return false
		}
		if !(this.sendcommand(rt.new_string('User & Password'), rt.call_function('base64_encode', [
			rt.new_string('' + var_username.str() + '' + var_password.str()),
		]), rt.new_int(235))) {
			return false
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('LOGIN'))) {
		if !(this.sendcommand(rt.new_string('AUTH'), rt.new_string('AUTH LOGIN'), rt.new_int(334))) {
			return false
		}
		if !(this.sendcommand(rt.new_string('Username'), rt.call_function('base64_encode', [
			var_username.clone(),
		]), rt.new_int(334))) {
			return false
		}
		if !(this.sendcommand(rt.new_string('Password'), rt.call_function('base64_encode', [
			var_password.clone(),
		]), rt.new_int(235))) {
			return false
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('CRAM-MD5'))) {
		if !(this.sendcommand(rt.new_string('AUTH CRAM-MD5'), rt.new_string('AUTH CRAM-MD5'),
			rt.new_int(334))) {
			return false
		}
		mut var_challenge := rt.call_function('base64_decode', [
			rt.call_function('substr', [this.last_reply, rt.new_int(4)]),
		])
		mut var_response := rt.new_string(var_username.str() + ' ' +
			this.hmac(var_challenge.clone(), var_password.clone()))
		return this.sendcommand(rt.new_string('Username'), rt.call_function('base64_encode', [
			var_response.clone(),
		]), rt.new_int(235))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('XOAUTH2'))) {
		if rt.is_true(rt.identical(rt.new_null(), var_OAuth)) {
			return false
		}
		mut var_oauth := rt.call_method(var_OAuth, 'getOauth64', []rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		unsafe {
			goto end_label_1
		}
		catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'PHPMailer_PHPMailer_Exception') {
			mut var_e := var_e_1.clone()
			rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(rt.new_string('SMTP authentication error'),
				rt.new_int(0), var_e.clone())))
			unsafe {
				goto end_label_1
			}
		} else {
			rt.throw_exception(var_e_1)
			unsafe {
				goto end_label_1
			}
		}

		end_label_1:
		if rt.is_true(rt.identical(var_oauth, rt.new_string(''))) {
			if !(this.sendcommand(rt.new_string('AUTH'), rt.new_string('AUTH XOAUTH2 ='),
				rt.new_int(235))) {
				return false
			}
		} else if var_oauth.clone().to_string().len <= 497 {
			if !(this.sendcommand(rt.new_string('AUTH'), rt.new_string('AUTH XOAUTH2 ' +
				var_oauth.str()), rt.new_int(235))) {
				return false
			}
		} else {
			if !(this.sendcommand(rt.new_string('AUTH'), rt.new_string('AUTH XOAUTH2'),
				rt.new_int(334))) {
				return false
			}
			if !(this.sendcommand(rt.new_string('OAuth TOKEN'), var_oauth.clone(), rt.create_array([
				rt.ArrayItem{ key: none, val: 235 },
				rt.ArrayItem{ key: none, val: 334 },
			]))) {
				return false
			}
			if rt.is_true(rt.identical(rt.call_function('substr', [this.last_reply, rt.new_int(0), rt.new_int(3)]), rt.new_string('334')))
				&& this.sendcommand(rt.new_string('AUTH End'), rt.new_string(''), rt.new_int(235)) {
				return false
			}
		}
	} else {
		this.seterror(rt.new_string("Authentication method \"${var_authtype.to_string()}\" is not supported"),
			'', '', '')
		return false
	}
	return true
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) hmac(var_data rt.PhpVal, var_key rt.PhpVal) string {
	mut var_data_mutated := var_data
	mut var_key_mutated := var_key
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('hash_hmac')])) {
		return (rt.call_function('hash_hmac', [rt.new_string('md5'),
			var_data_mutated.clone(), var_key_mutated.clone()])).str()
	}
	mut var_bytelen := rt.new_int(64)
	if rt.is_true(rt.greater(rt.new_int(var_key_mutated.clone().to_string().len), var_bytelen)) {
		var_key_mutated = rt.call_function('pack', [rt.new_string('H*'),
			rt.new_string(md5.hexhash(var_key_mutated.clone().to_string()))])
	}
	var_key_mutated = rt.call_function('str_pad', [var_key_mutated.clone(),
		var_bytelen.clone(), rt.call_function('chr', [rt.new_int(0)])])
	mut var_ipad := rt.call_function('str_pad', [rt.new_string(''),
		var_bytelen.clone(), rt.call_function('chr', [rt.new_int(54)])])
	mut var_opad := rt.call_function('str_pad', [rt.new_string(''),
		var_bytelen.clone(), rt.call_function('chr', [rt.new_int(92)])])
	mut var_k_ipad := rt.new_int(rt.bitwise_xor(var_key_mutated, var_ipad))
	mut var_k_opad := rt.new_int(rt.bitwise_xor(var_key_mutated, var_opad))
	return md5.hexhash(var_k_opad.str() +
		(rt.call_function('pack', [rt.new_string('H*'), rt.new_string(md5.hexhash(var_k_ipad.str() +
		var_data_mutated.str()))])).str())
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) connected() bool {
	if rt.is_true(rt.call_function('is_resource', [this.smtp_conn])) {
		mut var_sock_status := rt.call_function('stream_get_meta_data', [this.smtp_conn])
		if rt.is_true(var_sock_status.array_get(rt.new_string('eof'))) {
			this.edebug(rt.new_string('SMTP NOTICE: EOF caught while checking if connected'),
				(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_client()).to_i64())
			this.close()
			return false
		}
		return true
	}
	return false
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) close() {
	this.server_caps = rt.new_null()
	this.helo_rply = rt.new_null()
	if rt.is_true(rt.call_function('is_resource', [this.smtp_conn])) {
		rt.call_function('fclose', [this.smtp_conn])
		this.smtp_conn = rt.new_null()
		this.edebug(rt.new_string('Connection: closed'),
			(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_connection()).to_i64())
	}
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) iteratelines(var_s rt.PhpVal) {
	mut var_s_mutated := var_s
	mut var_start := rt.new_int(0)
	mut var_length := rt.new_int(var_s_mutated.clone().to_string().len)
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, var_length))) { break
		 }
		mut var_c := var_s_mutated.array_get(var_i)
		if rt.is_true(rt.identical(var_c, rt.new_string('\n')))
			|| rt.is_true(rt.identical(var_c, rt.new_string('\r'))) {
			rt.new_null()
			if rt.is_true(rt.identical(var_c, rt.new_string('\r')))
				&& rt.is_true(rt.less(rt.add(var_i, rt.new_int(1)), var_length))
				&& rt.is_true(rt.identical(var_s_mutated.array_get(rt.add(var_i, rt.new_int(1))), rt.new_string('\n'))) {
				rt.post_inc(var_i)
			}
			var_start = rt.add(var_i, rt.new_int(1))
		}
		rt.post_inc(var_i)
	}
	rt.new_null()
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) data(var_msg_data rt.PhpVal) bool {
	if !(this.sendcommand(rt.new_string('DATA'), rt.new_string('DATA'), rt.new_int(354))) {
		return false
	}
	mut var_lines := this.iteratelines(var_msg_data.clone())
	mut var_first_line := rt.call_method(var_lines, 'current', []rt.PhpVal{})
	mut var_field := rt.call_function('substr', [var_first_line.clone(),
		rt.new_int(0), rt.call_function('strpos', [var_first_line.clone(),
			rt.new_string(':')])])
	mut var_in_headers := rt.new_bool(false)
	if !(!rt.is_true(var_field))
		&& rt.is_true(rt.identical(rt.call_function('strpos', [var_field.clone(), rt.new_string(' ')]), rt.new_bool(false))) {
		var_in_headers = rt.new_bool(true)
	}
	mut iter_2 := var_lines.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_line := item_2.val
		mut var_lines_out := rt.new_array()
		if rt.is_true(var_in_headers) && rt.is_true(rt.identical(var_line, rt.new_string(''))) {
			var_in_headers = rt.new_bool(false)
		}
		for var_line.array_isset(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.max_line_length()) {
			mut var_pos := rt.call_function('strrpos', [
				rt.call_function('substr', [var_line.clone(),
					rt.new_int(0),
					Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.max_line_length()]),
				rt.new_string(' '),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_pos)))) {
				var_pos = rt.sub(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.max_line_length(),
					rt.new_int(1))
				var_lines_out.array_push(rt.call_function('substr', [
					var_line.clone(), rt.new_int(0), var_pos.clone()]))
				var_line = rt.call_function('substr', [var_line.clone(),
					var_pos.clone()])
			} else {
				var_lines_out.array_push(rt.call_function('substr', [
					var_line.clone(), rt.new_int(0), var_pos.clone()]))
				var_line = rt.call_function('substr', [var_line.clone(),
					rt.add(var_pos, rt.new_int(1))])
			}
			if rt.is_true(var_in_headers) {
				var_line = rt.new_string('\t' + var_line.str())
			}
		}
		var_lines_out.array_push(var_line.clone())
		mut iter_3 := var_lines_out.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_line_out := item_3.val
			if !(!rt.is_true(var_line_out))
				&& rt.is_true(rt.identical(var_line_out.array_get(rt.new_int(0)), rt.new_string('.'))) {
				var_line_out = rt.new_string('.' + var_line_out.str())
			}
			this.client_send(rt.new_string(var_line_out.str() +
				(Class_PHPMailer_PHPMailer_static.le()).str()), 'DATA')
		}
	}
	mut var_savetimelimit := this.Timelimit
	this.Timelimit = rt.mul(this.Timelimit, rt.new_int(2))
	mut var_result := rt.new_bool(this.sendcommand(rt.new_string('DATA END'), rt.new_string('.'),
		rt.new_int(250)))
	this.recordlasttransactionid()
	this.Timelimit = var_savetimelimit.clone()
	return var_result.to_bool()
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) hello(host string) bool {
	if rt.is_true(this.sendhello(rt.new_string('EHLO'), rt.new_string(host))) {
		return true
	}
	if rt.is_true(rt.equal(rt.call_function('substr', [this.helo_rply, rt.new_int(0),
		rt.new_int(3)]), rt.new_string('421')))
	{
		return false
	}
	return (this.sendhello(rt.new_string('HELO'), rt.new_string(host))).to_bool()
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) sendhello(var_hello rt.PhpVal, var_host rt.PhpVal) rt.PhpVal {
	mut var_noerror := rt.new_bool(this.sendcommand(var_hello.clone(), rt.new_string(
		var_hello.str() + ' ' + var_host.str()), rt.new_int(250)))
	this.helo_rply = this.last_reply
	if rt.is_true(var_noerror) {
		this.parsehellofields(var_hello.clone())
	} else {
		this.server_caps = rt.new_null()
	}
	return var_noerror.clone()
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) parsehellofields(var_type rt.PhpVal) {
	this.server_caps = rt.new_array()
	mut var_lines := rt.call_function('explode', [rt.new_string('\n'), this.helo_rply])
	mut iter_4 := var_lines.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_s := item_4.val
		mut var_n := item_4.key
		var_s = rt.new_string(rt.call_function('substr', [var_s.clone(),
			rt.new_int(4)]).to_string().trim_space())
		if !rt.is_true(var_s) {
			continue
		}
		mut var_fields := rt.call_function('explode', [rt.new_string(' '),
			var_s.clone()])
		if !(!rt.is_true(var_fields)) {
			if rt.is_true(rt.new_bool(!(rt.is_true(var_n)))) {
				mut var_name := var_type
				var_fields = var_fields.array_get(rt.new_int(0))
			} else {
				var_name = rt.call_function('array_shift', [var_fields.clone()])
				mut switch_val_3 := var_name
				if rt.is_true(rt.equal(switch_val_3, rt.new_string('SIZE'))) {
					var_fields = if rt.is_true(var_fields) {
						var_fields.array_get(rt.new_int(0))
					} else {
						rt.new_int(0)
					}
				} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('AUTH'))) {
					if !(var_fields.clone().is_array()) {
						var_fields = rt.new_array()
					}
				} else {
					var_fields = rt.new_bool(true)
				}
			}
			this.server_caps.array_set(var_name, var_fields.clone())
		}
	}
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) mail(var_from rt.PhpVal) rt.PhpVal {
	mut var_useVerp := rt.new_string((if rt.is_true(this.do_verp) { ' XVERP' } else { '' }).str())
	mut var_useSmtputf8 :=
		rt.new_string((if rt.is_true(this.do_smtputf8) { ' SMTPUTF8' } else { '' }).str())
	return rt.new_bool(this.sendcommand(rt.new_string('MAIL FROM'), rt.new_string('MAIL FROM:<' +
		var_from.str() + '>' + var_useSmtputf8.str() + var_useVerp.str()), rt.new_int(250)))
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) quit(close_on_error bool) rt.PhpVal {
	mut var_noerror := rt.new_bool(this.sendcommand(rt.new_string('QUIT'), rt.new_string('QUIT'),
		rt.new_int(221)))
	mut var_err := this.error
	if rt.is_true(var_noerror) || var_close_on_error {
		this.close()
		this.error = var_err.clone()
	}
	return var_noerror.clone()
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) recipient(var_address rt.PhpVal, dsn string) rt.PhpVal {
	mut dsn_mutated := dsn
	if dsn_mutated == '' {
		mut var_rcpt := rt.new_string('RCPT TO:<' + var_address.str() + '>')
	} else {
		dsn_mutated = dsn_mutated.to_upper()
		mut var_notify := rt.new_array()
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
			rt.new_string(dsn_mutated).clone(),
			rt.new_string('NEVER'),
		]), rt.new_bool(false)))))
		{
			var_notify.array_push('NEVER')
		} else {
			mut iter_5 := rt.create_array([rt.ArrayItem{ key: none, val: 'SUCCESS' },
				rt.ArrayItem{ key: none, val: 'FAILURE' }, rt.ArrayItem{ key: none, val: 'DELAY' }]).iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_value := item_5.val
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
					rt.new_string(dsn_mutated).clone(),
					var_value.clone(),
				]), rt.new_bool(false)))))
				{
					var_notify.array_push(var_value.clone())
				}
			}
		}
		var_rcpt = rt.new_string('RCPT TO:<' + var_address.str() + '> NOTIFY=' +
			(rt.call_function('implode', [rt.new_string(','), var_notify.clone()])).str())
	}
	return rt.new_bool(this.sendcommand(rt.new_string('RCPT TO'), var_rcpt.clone(), rt.create_array([
		rt.ArrayItem{ key: none, val: 250 },
		rt.ArrayItem{ key: none, val: 251 },
	])))
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) xclient(mut var_vars Class_PHPMailer_PHPMailer_array) bool {
	mut var_xclient_options := rt.new_string('')
	mut iter_6 := var_vars.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_value := item_6.val
		mut var_key := item_6.key
		if rt.is_true(rt.call_function('in_array', [var_key.clone(),
			rt.get_static_prop('PHPMailer_PHPMailer_SMTP', 'xclient_allowed_attributes')]))
		{
			var_xclient_options = rt.concat(var_xclient_options,
				rt.new_string(' ${var_key.to_string()}=${var_value.to_string()}'))
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_xclient_options)))) {
		return true
	}
	return this.sendcommand(rt.new_string('XCLIENT'), rt.new_string('XCLIENT' +
		var_xclient_options.str()), rt.new_int(250))
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) reset() rt.PhpVal {
	return rt.new_bool(this.sendcommand(rt.new_string('RSET'), rt.new_string('RSET'),
		rt.new_int(250)))
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) sendcommand(var_command rt.PhpVal, var_commandstring rt.PhpVal, var_expect rt.PhpVal) bool {
	if !(this.connected()) {
		this.seterror(rt.new_string('Called ${var_command.to_string()} without being connected'),
			'', '', '')
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [var_commandstring.clone(), rt.new_string('\n')]), rt.new_bool(false)))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [var_commandstring.clone(), rt.new_string('\r')]), rt.new_bool(false))))) {
		this.seterror(rt.new_string("Command '${var_command.to_string()}' contained line breaks"),
			'', '', '')
		return false
	}
	this.client_send(rt.new_string(var_commandstring.str() +
		(Class_PHPMailer_PHPMailer_static.le()).str()), var_command.str())
	this.last_reply = this.get_lines()
	mut var_matches := rt.new_array()
	if rt.is_true(rt.call_function('preg_match', [
		rt.new_string('/^([\\d]{3})[ -](?:([\\d]\\.[\\d]\\.[\\d]{1,2}) )?/'),
		this.last_reply,
		var_matches.clone(),
	]))
	{
		mut var_code := rt.new_int((var_matches.array_get(rt.new_int(1))).to_i64())
		mut var_code_ex := if var_matches.clone().array_count() > 2 {
			var_matches.array_get(rt.new_int(2))
		} else {
			rt.new_null()
		}
		mut var_detail := rt.call_function('preg_replace', [
			rt.new_string('/${var_code.to_string()}[ -]' +
				if rt.is_true(var_code_ex) { (rt.call_function('str_replace', [rt.new_string('.'), rt.new_string('\\.'), var_code_ex.clone()])).str() +
				' ' } else { '' } + '/m'),
			rt.new_string(''),
			this.last_reply,
		])
	} else {
		var_code = rt.new_int((rt.call_function('substr', [this.last_reply, rt.new_int(0),
			rt.new_int(3)])).to_i64())
		var_code_ex = rt.new_null()
		var_detail = rt.call_function('substr', [this.last_reply, rt.new_int(4)])
	}
	this.edebug(rt.new_string('SERVER -> CLIENT: ' + (this.last_reply).str()),
		(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_server()).to_i64())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_code.clone(), rt.cast_array(var_expect), rt.new_bool(true)])))))
	{
		this.seterror(rt.new_string('${var_command.to_string()} command failed'), var_detail.str(),
			var_code.str(), var_code_ex.str())
		this.edebug(rt.new_string('SMTP ERROR: ' +
			(this.error.array_get(rt.new_string('error'))).str() + ': ' + (this.last_reply).str()),
			(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_client()).to_i64())
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_command, rt.new_string('RSET'))))) {
		this.seterror(rt.new_string(''), '', '', '')
	}
	return true
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) sendandmail(var_from rt.PhpVal) rt.PhpVal {
	return rt.new_bool(this.sendcommand(rt.new_string('SAML'),
		rt.new_string('SAML FROM:${var_from.to_string()}'), rt.new_int(250)))
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) verify(var_name rt.PhpVal) rt.PhpVal {
	mut var_name_mutated := var_name
	return rt.new_bool(this.sendcommand(rt.new_string('VRFY'),
		rt.new_string('VRFY ${var_name.to_string()}'), rt.create_array([
		rt.ArrayItem{ key: none, val: 250 },
		rt.ArrayItem{ key: none, val: 251 },
	])))
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) noop() rt.PhpVal {
	return rt.new_bool(this.sendcommand(rt.new_string('NOOP'), rt.new_string('NOOP'),
		rt.new_int(250)))
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) turn() bool {
	this.seterror(rt.new_string('The SMTP TURN command is not implemented'), '', '', '')
	this.edebug(rt.new_string('SMTP NOTICE: ' + (this.error.array_get(rt.new_string('error'))).str()),
		(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_client()).to_i64())
	return false
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) client_send(var_data rt.PhpVal, command string) rt.PhpVal {
	mut var_data_mutated := var_data
	if rt.is_true(rt.greater(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_lowlevel(), this.do_debug))
		&& rt.is_true(rt.call_function('in_array', [rt.new_string(command), rt.create_array([rt.ArrayItem{
		key: none
		val: 'User & Password'
	}, rt.ArrayItem{ key: none, val: 'Username' }, rt.ArrayItem{ key: none, val: 'Password' }]), rt.new_bool(true)])) {
		this.edebug(rt.new_string('CLIENT -> SERVER: [credentials hidden]'),
			(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_client()).to_i64())
	} else {
		this.edebug(rt.new_string('CLIENT -> SERVER: ' + var_data_mutated.str()),
			(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_client()).to_i64())
	}
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		rt.call_function('call_user_func_array', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('PHPMailer_PHPMailer_SMTP', []string{},
					&this) },
				rt.ArrayItem{ key: none, val: 'errorHandler' },
			]),
			rt.call_function('func_get_args', []rt.PhpVal{}),
		])
		return rt.new_null()
	}
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		rt.call_function('call_user_func_array', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('PHPMailer_PHPMailer_SMTP', []string{},
					&this) },
				rt.ArrayItem{ key: none, val: 'errorHandler' },
			]),
			rt.call_function('func_get_args', []rt.PhpVal{}),
		])
		return rt.new_null()
	}
	rt.call_function('set_error_handler', [rt.new_closure(closure_7_fn)])
	mut var_result := rt.call_function('fwrite', [this.smtp_conn, var_data_mutated.clone()])
	rt.call_function('restore_error_handler', []rt.PhpVal{})
	return var_result.clone()
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) geterror() rt.PhpVal {
	return this.error
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) getserverextlist() rt.PhpVal {
	return this.server_caps
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) getserverext(var_name rt.PhpVal) rt.PhpVal {
	mut var_name_mutated := var_name
	if rt.is_true(rt.new_bool(!(rt.is_true(this.server_caps)))) {
		this.seterror(rt.new_string('No HELO/EHLO was sent'), '', '', '')
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.server_caps.array_isset(var_name_mutated.clone())))))) {
		if rt.is_true(rt.identical(rt.new_string('HELO'), var_name_mutated)) {
			return this.server_caps.array_get(rt.new_string('EHLO'))
		}
		if rt.is_true(rt.identical(rt.new_string('EHLO'), var_name_mutated))
			|| rt.is_true(rt.new_bool(this.server_caps.array_isset(rt.new_string('EHLO')))) {
			return rt.new_bool(false)
		}
		this.seterror(rt.new_string('HELO handshake was used; No information about server extensions available'),
			'', '', '')
		return rt.new_null()
	}
	return this.server_caps.array_get(var_name_mutated)
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) getlastreply() rt.PhpVal {
	return this.last_reply
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) get_lines() string {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [this.smtp_conn]))))) {
		return ''
	}
	mut var_data := rt.new_string('')
	mut var_endtime := rt.new_int(0)
	rt.call_function('stream_set_timeout', [this.smtp_conn, this.Timeout])
	if rt.is_true(rt.greater(this.Timelimit, rt.new_int(0))) {
		var_endtime = rt.add(rt.call_function('time', []rt.PhpVal{}), this.Timelimit)
	}
	mut var_selR := rt.create_array([rt.ArrayItem{ key: none, val: this.smtp_conn }])
	mut var_selW := rt.new_null()
	for rt.is_true(rt.call_function('is_resource', [this.smtp_conn]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('feof', [this.smtp_conn]))))) {
		closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			rt.call_function('call_user_func_array', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('PHPMailer_PHPMailer_SMTP',
						[]string{}, &this) },
					rt.ArrayItem{ key: none, val: 'errorHandler' },
				]),
				rt.call_function('func_get_args', []rt.PhpVal{}),
			])
			return rt.new_null()
		}
		closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			rt.call_function('call_user_func_array', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('PHPMailer_PHPMailer_SMTP',
						[]string{}, &this) },
					rt.ArrayItem{ key: none, val: 'errorHandler' },
				]),
				rt.call_function('func_get_args', []rt.PhpVal{}),
			])
			return rt.new_null()
		}
		rt.call_function('set_error_handler', [rt.new_closure(closure_9_fn)])
		mut var_n := rt.call_function('stream_select', [var_selR.clone(),
			var_selW.clone(), var_selW.clone(), this.Timelimit])
		rt.call_function('restore_error_handler', []rt.PhpVal{})
		if rt.is_true(rt.identical(var_n, rt.new_bool(false))) {
			mut var_message := this.geterror().array_get(rt.new_string('detail'))
			this.edebug(rt.new_string('SMTP -> get_lines(): select failed (' + var_message.str() +
				')'),
				(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_lowlevel()).to_i64())
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('stripos', [var_message.clone(), rt.new_string('interrupted system call')]), rt.new_bool(false)))))
				|| (rt.is_true(rt.call_function('defined', [rt.new_string('SOCKET_EINTR')]))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('stripos', [var_message.clone(), rt.new_string('stream_select(): Unable to select [' + (rt.get_constant('SOCKET_EINTR')).str() + ']')]), rt.new_bool(false)))))) {
				this.edebug(rt.new_string('SMTP -> get_lines(): retrying stream_select'),
					(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_lowlevel()).to_i64())
				this.seterror(rt.new_string(''), '', '', '')
				continue
			}
			break
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_n)))) {
			this.edebug(rt.new_string(
				'SMTP -> get_lines(): select timed-out in (' + (this.Timelimit).str() + ' sec)'),
				(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_lowlevel()).to_i64())
			break
		}
		mut var_str := rt.call_function('fgets', [this.smtp_conn,
			Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.max_reply_length()])
		this.edebug(rt.new_string('SMTP INBOUND: "' + var_str.clone().to_string().trim_space() + '"'),
			(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_lowlevel()).to_i64())
		var_data = rt.concat(var_data, var_str)
		if !(var_str.array_isset(rt.new_int(3)))
			|| rt.is_true(rt.identical(var_str.array_get(rt.new_int(3)), rt.new_string(' ')))
			|| rt.is_true(rt.identical(var_str.array_get(rt.new_int(3)), rt.new_string('\r')))
			|| rt.is_true(rt.identical(var_str.array_get(rt.new_int(3)), rt.new_string('\n'))) {
			break
		}
		mut var_info := rt.call_function('stream_get_meta_data', [this.smtp_conn])
		if rt.is_true(var_info.array_get(rt.new_string('timed_out'))) {
			this.edebug(rt.new_string(
				'SMTP -> get_lines(): stream timed-out (' + (this.Timeout).str() + ' sec)'),
				(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_lowlevel()).to_i64())
			break
		}
		if rt.is_true(var_endtime)
			&& rt.is_true(rt.greater(rt.call_function('time', []rt.PhpVal{}), var_endtime)) {
			this.edebug(rt.new_string(
				'SMTP -> get_lines(): timelimit reached (' + (this.Timelimit).str() + ' sec)'),
				(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_lowlevel()).to_i64())
			break
		}
	}
	return var_data.str()
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) setverp(enabled bool) {
	this.do_verp = rt.new_bool(enabled)
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) getverp() rt.PhpVal {
	return this.do_verp
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) setsmtputf8(enabled bool) {
	this.do_smtputf8 = rt.new_bool(enabled)
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) getsmtputf8() rt.PhpVal {
	return this.do_smtputf8
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) seterror(var_message rt.PhpVal, detail string, smtp_code string, smtp_code_ex string) {
	mut var_message_mutated := var_message
	mut detail_mutated := detail
	this.error = rt.create_array([rt.ArrayItem{ key: 'error', val: var_message_mutated },
		rt.ArrayItem{ key: 'detail', val: detail_mutated }, rt.ArrayItem{
			key: 'smtp_code'
			val: smtp_code
		}, rt.ArrayItem{ key: 'smtp_code_ex', val: smtp_code_ex }])
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) setdebugoutput(method string) {
	this.Debugoutput = rt.new_string(method)
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) getdebugoutput() rt.PhpVal {
	return this.Debugoutput
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) setdebuglevel(level i64) {
	this.do_debug = rt.new_int(level)
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) getdebuglevel() rt.PhpVal {
	return this.do_debug
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) settimeout(timeout i64) {
	this.Timeout = rt.new_int(timeout)
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) gettimeout() rt.PhpVal {
	return this.Timeout
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) errorhandler(var_errno rt.PhpVal, var_errmsg rt.PhpVal, errfile string, errline i64) {
	mut var_errno_mutated := var_errno
	mut var_notice := rt.new_string('Connection failed.')
	this.seterror(var_notice.clone(), var_errmsg.str(), var_errno_mutated.str(), '')
	this.edebug(rt.new_string('${var_notice.to_string()} Error #${var_errno.to_string()}: ${var_errmsg.to_string()} [${var_errfile} line ${var_errline.str()}]'),
		(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_connection()).to_i64())
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) recordlasttransactionid() rt.PhpVal {
	mut var_reply := this.getlastreply()
	if !rt.is_true(var_reply) {
		this.last_smtp_transaction_id = rt.new_null()
	} else {
		this.last_smtp_transaction_id = rt.new_bool(false)
		mut iter_7 := this.smtp_transaction_id_patterns.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_smtp_transaction_id_pattern := item_7.val
			mut var_matches := rt.new_array()
			if rt.is_true(rt.call_function('preg_match', [var_smtp_transaction_id_pattern.clone(),
				var_reply.clone(), var_matches.clone()]))
			{
				this.last_smtp_transaction_id =
					rt.new_string(var_matches.array_get(rt.new_int(1)).to_string().trim_space())
				break
			}
		}
	}
	return this.last_smtp_transaction_id
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) getlasttransactionid() rt.PhpVal {
	return this.last_smtp_transaction_id
}

struct Class_PHPMailer_PHPMailer_Exception {
	rt.PhpObjectBase
}

fn create_phpmailer_phpmailer_smtp(_args ...rt.PhpVal) &Class_PHPMailer_PHPMailer_SMTP {
	mut obj := &Class_PHPMailer_PHPMailer_SMTP{
		PhpObjectBase:                rt.PhpObjectBase{}
		do_debug:                     rt.new_null()
		Debugoutput:                  rt.new_string('echo')
		do_verp:                      rt.new_bool(false)
		do_smtputf8:                  rt.new_bool(false)
		Timeout:                      rt.new_int(300)
		Timelimit:                    rt.new_int(300)
		smtp_transaction_id_patterns: rt.new_array()
		last_smtp_transaction_id:     rt.new_null()
		smtp_conn:                    rt.new_null()
		error:                        rt.new_array()
		helo_rply:                    rt.new_null()
		server_caps:                  rt.new_null()
		last_reply:                   rt.new_string('')
	}
	return obj
}

fn create_phpmailer_phpmailer_exception(_args ...rt.PhpVal) &Class_PHPMailer_PHPMailer_Exception {
	mut obj := &Class_PHPMailer_PHPMailer_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'edebug' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			this.edebug(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'connect' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_bool(this.connect(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3))
		}
		'getSMTPConnection' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_bool(this.getsmtpconnection(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3))
		}
		'startTLS' {
			return rt.new_bool(this.starttls())
		}
		'authenticate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_bool(this.authenticate(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3))
		}
		'hmac' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.hmac(dispatch_arg_0, dispatch_arg_1))
		}
		'connected' {
			return rt.new_bool(this.connected())
		}
		'close' {
			this.close()
			return rt.new_null()
		}
		'iterateLines' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.iteratelines(dispatch_arg_0)
			return rt.new_null()
		}
		'data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.data(dispatch_arg_0))
		}
		'hello' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.hello(dispatch_arg_0))
		}
		'sendHello' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.sendhello(dispatch_arg_0, dispatch_arg_1)
		}
		'parseHelloFields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.parsehellofields(dispatch_arg_0)
			return rt.new_null()
		}
		'mail' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.mail(dispatch_arg_0)
		}
		'quit' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.quit(dispatch_arg_0)
		}
		'recipient' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.recipient(dispatch_arg_0, dispatch_arg_1)
		}
		'xclient' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_PHPMailer_PHPMailer_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.xclient(mut dispatch_arg_0))
		}
		'reset' {
			return this.reset()
		}
		'sendCommand' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.sendcommand(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'sendAndMail' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sendandmail(dispatch_arg_0)
		}
		'verify' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.verify(dispatch_arg_0)
		}
		'noop' {
			return this.noop()
		}
		'turn' {
			return rt.new_bool(this.turn())
		}
		'client_send' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.client_send(dispatch_arg_0, dispatch_arg_1)
		}
		'getError' {
			return this.geterror()
		}
		'getServerExtList' {
			return this.getserverextlist()
		}
		'getServerExt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.getserverext(dispatch_arg_0)
		}
		'getLastReply' {
			return this.getlastreply()
		}
		'get_lines' {
			return rt.new_string(this.get_lines())
		}
		'setVerp' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.setverp(dispatch_arg_0)
			return rt.new_null()
		}
		'getVerp' {
			return this.getverp()
		}
		'setSMTPUTF8' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.setsmtputf8(dispatch_arg_0)
			return rt.new_null()
		}
		'getSMTPUTF8' {
			return this.getsmtputf8()
		}
		'setError' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			this.seterror(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'setDebugOutput' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.setdebugoutput(dispatch_arg_0)
			return rt.new_null()
		}
		'getDebugOutput' {
			return this.getdebugoutput()
		}
		'setDebugLevel' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.setdebuglevel(dispatch_arg_0)
			return rt.new_null()
		}
		'getDebugLevel' {
			return this.getdebuglevel()
		}
		'setTimeout' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.settimeout(dispatch_arg_0)
			return rt.new_null()
		}
		'getTimeout' {
			return this.gettimeout()
		}
		'errorHandler' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			this.errorhandler(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'recordLastTransactionID' {
			return this.recordlasttransactionid()
		}
		'getLastTransactionID' {
			return this.getlasttransactionid()
		}
		else {
			return none
		}
	}
}

fn (this &Class_PHPMailer_PHPMailer_SMTP) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'do_debug' { return this.do_debug }
		'Debugoutput' { return this.Debugoutput }
		'do_verp' { return this.do_verp }
		'do_smtputf8' { return this.do_smtputf8 }
		'Timeout' { return this.Timeout }
		'Timelimit' { return this.Timelimit }
		'smtp_transaction_id_patterns' { return this.smtp_transaction_id_patterns }
		'last_smtp_transaction_id' { return this.last_smtp_transaction_id }
		'smtp_conn' { return this.smtp_conn }
		'error' { return this.error }
		'helo_rply' { return this.helo_rply }
		'server_caps' { return this.server_caps }
		'last_reply' { return this.last_reply }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'do_debug' {
			this.do_debug = val
			return true
		}
		'Debugoutput' {
			this.Debugoutput = val
			return true
		}
		'do_verp' {
			this.do_verp = val
			return true
		}
		'do_smtputf8' {
			this.do_smtputf8 = val
			return true
		}
		'Timeout' {
			this.Timeout = val
			return true
		}
		'Timelimit' {
			this.Timelimit = val
			return true
		}
		'smtp_transaction_id_patterns' {
			this.smtp_transaction_id_patterns = val
			return true
		}
		'last_smtp_transaction_id' {
			this.last_smtp_transaction_id = val
			return true
		}
		'smtp_conn' {
			this.smtp_conn = val
			return true
		}
		'error' {
			this.error = val
			return true
		}
		'helo_rply' {
			this.helo_rply = val
			return true
		}
		'server_caps' {
			this.server_caps = val
			return true
		}
		'last_reply' {
			this.last_reply = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_PHPMailer_PHPMailer_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_PHPMailer_PHPMailer_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_PHPMailer_PHPMailer_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
