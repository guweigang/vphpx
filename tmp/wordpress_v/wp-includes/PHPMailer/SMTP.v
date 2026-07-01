import rt

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
		do_debug rt.PhpVal = rt.new_null()
		Debugoutput rt.PhpVal = rt.new_string('echo')
		do_verp rt.PhpVal = rt.new_bool(false)
		do_smtputf8 rt.PhpVal = rt.new_bool(false)
		Timeout rt.PhpVal = rt.new_int(300)
		Timelimit rt.PhpVal = rt.new_int(300)
		smtp_transaction_id_patterns rt.PhpVal = rt.new_array()
		xclient_allowed_attributes rt.PhpVal = rt.new_array()
		last_smtp_transaction_id rt.PhpVal = rt.new_null()
		smtp_conn rt.PhpVal = rt.new_null()
		error rt.PhpVal = rt.new_array()
		helo_rply rt.PhpVal = rt.new_null()
		server_caps rt.PhpVal = rt.new_null()
		last_reply rt.PhpVal = rt.new_string('')
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) edebug(var_str rt.PhpVal, level i64)  {
	mut var_str_mutated := var_str
	if rt.is_true(rt.greater(rt.new_int(level), this.do_debug)) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(this.Debugoutput, 'PHPMailer_PHPMailer_Psr_Log_LoggerInterface'))) {
		rt.call_method(this.Debugoutput, 'debug', [rt.new_string(var_str_mutated.dup().to_string().trim_right(' \t\n\r'))])
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_callable', [this.Debugoutput])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [this.Debugoutput, rt.create_array([rt.ArrayItem{ key: none, val: 'error_log' }, rt.ArrayItem{ key: none, val: 'html' }, rt.ArrayItem{ key: none, val: 'echo' }])]))))))) {
		rt.call_function('call_user_func', [this.Debugoutput, var_str_mutated.dup(), rt.new_int(level)])
		return rt.new_null()
	}
	mut switch_val_1 := this.Debugoutput
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('error_log'))) {
		rt.call_function('error_log', [var_str_mutated.dup()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('html'))) {
		rt.echo_val(rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s')]))
		print(' ')
		rt.echo_val(rt.call_function('htmlentities', [rt.call_function('preg_replace', [rt.new_string('/[\\r\\n]+/'), rt.new_string(''), var_str_mutated.dup()]), rt.get_constant('ENT_QUOTES'), rt.new_string('UTF-8')]))
		print('<br>\n')
	} else {
		var_str_mutated = rt.call_function('preg_replace', [rt.new_string('/\\r\\n|\\r/m'), rt.new_string('\n'), var_str_mutated.dup()])
		rt.echo_val(rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s')]))
		print('\t')
		print(rt.call_function('str_replace', [rt.new_string('\n'), rt.new_string('\n                   \t                  '), rt.new_string(var_str_mutated.dup().to_string().trim_space())]).to_string().trim_space())
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
	this.edebug(rt.new_string("Connection: opening to ${var_host.to_string()}:${var_port.to_string()}, timeout=${var_timeout.str()}, options=" + (if var_options.dup().array_count() > 0 { rt.call_function('var_export', [var_options.dup(), rt.new_bool(true)]) } else { rt.new_string('array()') }).str()), (Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_connection()).to_i64())
	this.smtp_conn = this.getsmtpconnection(var_host.dup(), var_port_mutated.dup(), timeout, var_options.dup())
	if rt.is_true(rt.identical(this.smtp_conn, rt.new_bool(false))) {
		return false
	}
	this.edebug(rt.new_string('Connection: opened'), (Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_connection()).to_i64())
	this.last_reply = this.get_lines()
	this.edebug(rt.new_string('SERVER -> CLIENT: ' + (this.last_reply).str()), (Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_server()).to_i64())
	mut var_responseCode := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.identical(var_responseCode, rt.new_int(220))) {
		return true
	}
	if rt.is_true(rt.identical(var_responseCode, rt.new_int(554))) {
		this.quit(false)
	}
	this.edebug(rt.new_string('Connection: closing due to error'), (Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_connection()).to_i64())
	this.close()
	return false
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) getsmtpconnection(var_host rt.PhpVal, var_port rt.PhpVal, timeout i64, var_options rt.PhpVal) bool {
	mut var_port_mutated := var_port
	// unsupported statement: Stmt_Static
	if rt.is_true(rt.identical(rt.new_null(), var_streamok)) {
		mut var_streamok := rt.call_function('function_exists', [rt.new_string('stream_socket_client')])
	}
	mut var_errno := rt.new_int(rt.new_int(0))
	mut var_errstr := rt.new_string(rt.new_string(''))
	if rt.is_true(var_streamok) {
		mut var_socket_context := rt.call_function('stream_context_create', [var_options.dup()])
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	rt.call_function('call_user_func_array', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('PHPMailer_PHPMailer_SMTP', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'errorHandler' }]), rt.call_function('func_get_args', []rt.PhpVal{})])
	return rt.new_null()
	}
	rt.call_function('call_user_func_array', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('PHPMailer_PHPMailer_SMTP', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'errorHandler' }]), rt.call_function('func_get_args', []rt.PhpVal{})])
	return rt.new_null()
	}
		rt.call_function('set_error_handler', [rt.new_closure(closure_1_fn)])
		mut var_connection := rt.call_function('stream_socket_client', [(var_host).str() + ':' + (var_port_mutated).str(), var_errno.dup(), var_errstr.dup(), rt.new_int(timeout), rt.get_constant('STREAM_CLIENT_CONNECT'), var_socket_context.dup()])
	} else {
		this.edebug(rt.new_string('Connection: stream_socket_client not available, falling back to fsockopen'), (Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_connection()).to_i64())
		closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	rt.call_function('call_user_func_array', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('PHPMailer_PHPMailer_SMTP', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'errorHandler' }]), rt.call_function('func_get_args', []rt.PhpVal{})])
	return rt.new_null()
	}
	rt.call_function('call_user_func_array', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('PHPMailer_PHPMailer_SMTP', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'errorHandler' }]), rt.call_function('func_get_args', []rt.PhpVal{})])
	return rt.new_null()
	}
		rt.call_function('set_error_handler', [rt.new_closure(closure_3_fn)])
		var_connection = rt.call_function('fsockopen', [var_host.dup(), var_port_mutated.dup(), var_errno.dup(), var_errstr.dup(), rt.new_int(timeout)])
	}
	rt.call_function('restore_error_handler', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [var_connection.dup()]))))) {
		this.seterror(rt.new_string('Failed to connect to server'), '', (// unsupported expression: Expr_Cast_String).str(), (var_errstr).str())
		this.edebug(rt.new_string('SMTP ERROR: ' + (this.error.array_get('error')).str() + ": ${var_errstr.to_string()} (${var_errno.to_string()})"), (Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_client()).to_i64())
		return false
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_max := // unsupported expression: Expr_Cast_Int
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.greater(rt.new_int(timeout), var_max)))) && rt.is_true(rt.identical(rt.call_function('strpos', [rt.call_function('ini_get', [rt.new_string('disable_functions')]), rt.new_string('set_time_limit')]), rt.new_bool(false))))) {
			rt.call_function('set_time_limit', [rt.new_int(timeout)])
		}
		rt.call_function('stream_set_timeout', [var_connection.dup(), rt.new_int(timeout), rt.new_int(0)])
	}
	return (var_connection).to_bool()
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) starttls() bool {
	if !(this.sendcommand(rt.new_string('STARTTLS'), rt.new_string('STARTTLS'), rt.new_int(220))) {
		return false
	}
	mut var_crypto_method := rt.get_constant('STREAM_CRYPTO_METHOD_TLS_CLIENT')
	if rt.is_true(rt.call_function('defined', [rt.new_string('STREAM_CRYPTO_METHOD_TLSv1_2_CLIENT')])) {
		// unsupported expression: Expr_AssignOp_BitwiseOr
		// unsupported expression: Expr_AssignOp_BitwiseOr
	}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	rt.call_function('call_user_func_array', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('PHPMailer_PHPMailer_SMTP', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'errorHandler' }]), rt.call_function('func_get_args', []rt.PhpVal{})])
	return rt.new_null()
	}
	rt.call_function('call_user_func_array', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('PHPMailer_PHPMailer_SMTP', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'errorHandler' }]), rt.call_function('func_get_args', []rt.PhpVal{})])
	return rt.new_null()
	}
	rt.call_function('set_error_handler', [rt.new_closure(closure_5_fn)])
	mut var_crypto_ok := rt.call_function('stream_socket_enable_crypto', [this.smtp_conn, rt.new_bool(true), var_crypto_method.dup()])
	rt.call_function('restore_error_handler', []rt.PhpVal{})
	return (// unsupported expression: Expr_Cast_Bool).to_bool()
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
		this.edebug(rt.new_string('Auth method requested: ' + (if rt.is_true(var_authtype_mutated) { var_authtype_mutated } else { rt.new_string('UNSPECIFIED') }).str()), (Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_lowlevel()).to_i64())
		this.edebug(rt.new_string('Auth methods available on the server: ' + (rt.call_function('implode', [rt.new_string(','), this.server_caps.array_get('AUTH')])).str()), (Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_lowlevel()).to_i64())
		if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_authtype_mutated.dup(), this.server_caps.array_get('AUTH'), rt.new_bool(true)]))))))) {
			this.edebug(rt.new_string('Requested auth method not available: ' + (var_authtype_mutated).str()), (Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_lowlevel()).to_i64())
			var_authtype_mutated = rt.new_null()
		}
		if !rt.is_true(var_authtype_mutated) {
			{
				mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'CRAM-MD5' }, rt.ArrayItem{ key: none, val: 'LOGIN' }, rt.ArrayItem{ key: none, val: 'PLAIN' }, rt.ArrayItem{ key: none, val: 'XOAUTH2' }]).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_method := item_1.val
					if rt.is_true(rt.call_function('in_array', [var_method.dup(), this.server_caps.array_get('AUTH'), rt.new_bool(true)])) {
						var_authtype_mutated = var_method
						break
					}
				}
			}
			if !rt.is_true(var_authtype_mutated) {
				this.seterror(rt.new_string('No supported authentication methods found'), '', '', '')
				return false
			}
			this.edebug(rt.new_string('Auth method selected: ' + (var_authtype_mutated).str()), (Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_SMTP.debug_lowlevel()).to_i64())
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_authtype_mutated.dup(), this.server_caps.array_get('AUTH'), rt.new_bool(true)]))))) {
			this.seterror(rt.new_string("The requested authentication method \"${var_authtype.to_string()}\" is not supported by the server"), '', '', '')
			return false
		}
	} else if !rt.is_true(var_authtype_mutated) {
		var_authtype_mutated = rt.new_string(rt.new_string('LOGIN'))
	}
	mut switch_val_2 := var_authtype_mutated
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('PLAIN'))) {
		if !(this.sendcommand(rt.new_string('AUTH'), rt.new_string('AUTH PLAIN'), rt.new_int(334))) {
			return false
		}
		if !(this.sendcommand(rt.new_string('User & Password'), rt.call_function('base64_encode', ['' + (var_username).str() + '' + (var_password).str()]), rt.new_int(235))) {
			return false
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('LOGIN'))) {
		if !(this.sendcommand(rt.new_string('AUTH'), rt.new_string('AUTH LOGIN'), rt.new_int(334))) {
			return false
		}
		if !(this.sendcommand(rt.new_string('Username'), rt.call_function('base64_encode', [var_username.dup()]), rt.new_int(334))) {
			return false
		}
		if !(this.sendcommand(rt.new_string('Password'), rt.call_function('base64_encode', [var_password.dup()]), rt.new_int(235))) {
			return false
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('CRAM-MD5'))) {
		if !(this.sendcommand(rt.new_string('AUTH CRAM-MD5'), rt.new_string('AUTH CRAM-MD5'), rt.new_int(334))) {
			return false
		}
		mut var_challenge := rt.call_function('base64_decode', [rt.call_function('substr', [this.last_reply, rt.new_int(4)])])
		mut var_response := rt.new_string((var_username).str() + ' ' + this.hmac(var_challenge.dup(), var_password.dup()))
		return this.sendcommand(rt.new_string('Username'), rt.call_function('base64_encode', [var_response.dup()]), rt.new_int(235))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('XOAUTH2'))) {
		if rt.is_true(rt.identical(rt.new_null(), var_OAuth)) {
			return false
		}
		mut var_oauth := rt.call_method(var_OAuth, 'getOauth64', []rt.PhpVal{})
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'PHPMailer_PHPMailer_Exception') {
			mut var_e := var_e_1.dup()
			rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(rt.new_string('SMTP authentication error'), rt.new_int(0), var_e.dup())))
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
		if rt.is_true(rt.identical(var_oauth, rt.new_string(''))) {
			if !(this.sendcommand(rt.new_string('AUTH'), rt.new_string('AUTH XOAUTH2 ='), rt.new_int(235))) {
				return false
			}
		} else if var_oauth.dup().to_string().len <= 497 {
			if !(this.sendcommand(rt.new_string('AUTH'), rt.new_string('AUTH XOAUTH2 ' + (var_oauth).str()), rt.new_int(235))) {
				return false
			}
		} else {
			if !(this.sendcommand(rt.new_string('AUTH'), rt.new_string('AUTH XOAUTH2'), rt.new_int(334))) {
				return false
			}
			if !(this.sendcommand(rt.new_string('OAuth TOKEN'), var_oauth.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 235 }, rt.ArrayItem{ key: none, val: 334 }]))) {
				return false
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.call_function('substr', [, , ]), rt.new_string('334'))) && this.sendcommand(rt.new_string('AUTH End'), rt.new_string(''), rt.new_int(235)))) {
				return false
			}
		}
	} else {
		this.seterror(rt.new_string("Authentication method \"${var_authtype.to_string()}\" is not supported"), '', '', '')
		return false
	}
	return true
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) hmac(var_data rt.PhpVal, var_key rt.PhpVal) string {
	mut var_data_mutated := var_data
	mut var_key_mutated := var_key
	if rt.is_true() {
	}
	
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) connected() bool {
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) close()  {
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) iteratelines(var_s rt.PhpVal)  {
	mut var_s_mutated := var_s
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) data(var_msg_data rt.PhpVal) bool {
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) hello(host string) bool {
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) sendhello(var_hello rt.PhpVal, var_host rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) parsehellofields(var_type rt.PhpVal)  {
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) mail(var_from rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) quit(close_on_error bool) rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) recipient(var_address rt.PhpVal, dsn string) rt.PhpVal {
	mut dsn_mutated := dsn
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) xclient(mut var_vars Class_PHPMailer_PHPMailer_array) bool {
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) reset() rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) sendcommand(var_command rt.PhpVal, var_commandstring rt.PhpVal, var_expect rt.PhpVal) bool {
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) sendandmail(var_from rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) verify(var_name rt.PhpVal) rt.PhpVal {
	mut var_name_mutated := var_name
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) noop() rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) turn() bool {
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) client_send(var_data rt.PhpVal, command string) rt.PhpVal {
	mut var_data_mutated := var_data
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) geterror() rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) getserverextlist() rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) getserverext(var_name rt.PhpVal) rt.PhpVal {
	mut var_name_mutated := var_name
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) getlastreply() rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) get_lines() string {
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) setverp(enabled bool)  {
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) getverp() rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) setsmtputf8(enabled bool)  {
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) getsmtputf8() rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) seterror(var_message rt.PhpVal, detail string, smtp_code string, smtp_code_ex string)  {
	mut var_message_mutated := var_message
	mut detail_mutated := detail
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) setdebugoutput(method string)  {
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) getdebugoutput() rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) setdebuglevel(level i64)  {
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) getdebuglevel() rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) settimeout(timeout i64)  {
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) gettimeout() rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) errorhandler(var_errno rt.PhpVal, var_errmsg rt.PhpVal, errfile string, errline i64)  {
	mut var_errno_mutated := var_errno
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) recordlasttransactionid() rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) getlasttransactionid() rt.PhpVal {
}

struct Class_PHPMailer_PHPMailer_Exception {
	rt.PhpObjectBase
}

fn create_phpmailer_phpmailer_smtp() &Class_PHPMailer_PHPMailer_SMTP {
	mut obj := &Class_PHPMailer_PHPMailer_SMTP{
		PhpObjectBase: rt.PhpObjectBase{}
		do_debug: rt.new_null()
		Debugoutput: rt.new_string('echo')
		do_verp: rt.new_bool(false)
		do_smtputf8: rt.new_bool(false)
		Timeout: rt.new_int(300)
		Timelimit: rt.new_int(300)
		smtp_transaction_id_patterns: rt.new_array()
		xclient_allowed_attributes: rt.new_array()
		last_smtp_transaction_id: rt.new_null()
		smtp_conn: rt.new_null()
		error: rt.new_array()
		helo_rply: rt.new_null()
		server_caps: rt.new_null()
		last_reply: rt.new_string('')
	}
	return obj
}

fn create_phpmailer_phpmailer_exception() &Class_PHPMailer_PHPMailer_Exception {
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
			return rt.new_bool(this.connect(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'getSMTPConnection' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_bool(this.getsmtpconnection(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'startTLS' {
			return rt.new_bool(this.starttls())
		}
		'authenticate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_bool(this.authenticate(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_PHPMailer_PHPMailer_array](if args.len > 0 { args[0] } else { rt.new_null() })
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
		else { return none }
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
		'xclient_allowed_attributes' { return this.xclient_allowed_attributes }
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
		'do_debug' { this.do_debug = val; return true }
		'Debugoutput' { this.Debugoutput = val; return true }
		'do_verp' { this.do_verp = val; return true }
		'do_smtputf8' { this.do_smtputf8 = val; return true }
		'Timeout' { this.Timeout = val; return true }
		'Timelimit' { this.Timelimit = val; return true }
		'smtp_transaction_id_patterns' { this.smtp_transaction_id_patterns = val; return true }
		'xclient_allowed_attributes' { this.xclient_allowed_attributes = val; return true }
		'last_smtp_transaction_id' { this.last_smtp_transaction_id = val; return true }
		'smtp_conn' { this.smtp_conn = val; return true }
		'error' { this.error = val; return true }
		'helo_rply' { this.helo_rply = val; return true }
		'server_caps' { this.server_caps = val; return true }
		'last_reply' { this.last_reply = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_includes_phpmailer_smtp_php() {
}
