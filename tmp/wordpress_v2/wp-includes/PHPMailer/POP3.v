import rt

pub fn Class_PHPMailer_PHPMailer_POP3.version() string {
	return '7.0.2'
}

pub fn Class_PHPMailer_PHPMailer_POP3.default_port() i64 {
	return 110
}

pub fn Class_PHPMailer_PHPMailer_POP3.default_timeout() i64 {
	return 30
}

pub fn Class_PHPMailer_PHPMailer_POP3.le() string {
	return '\r\n'
}

pub fn Class_PHPMailer_PHPMailer_POP3.debug_off() i64 {
	return 0
}

pub fn Class_PHPMailer_PHPMailer_POP3.debug_server() i64 {
	return 1
}

pub fn Class_PHPMailer_PHPMailer_POP3.debug_client() i64 {
	return 2
}

struct Class_PHPMailer_PHPMailer_POP3 {
	rt.PhpObjectBase
pub mut:
	do_debug  rt.PhpVal = rt.new_null()
	host      rt.PhpVal = rt.new_null()
	port      rt.PhpVal = rt.new_null()
	tval      rt.PhpVal = rt.new_null()
	username  rt.PhpVal = rt.new_null()
	password  rt.PhpVal = rt.new_null()
	pop_conn  rt.PhpVal = rt.new_null()
	connected bool
	errors    rt.PhpVal = rt.new_array()
}

fn Class_PHPMailer_PHPMailer_POP3.popbeforesmtp(var_host rt.PhpVal, port bool, timeout bool, username string, password string, debug_level i64) rt.PhpVal {
	mut port_mutated := port
	mut username_mutated := username
	mut password_mutated := password
	mut var_pop := create_phpmailer_phpmailer_self()
	return var_pop.authorise(var_host.clone(), rt.new_bool(port_mutated), rt.new_bool(timeout),
		rt.new_string(username_mutated), rt.new_string(password_mutated), rt.new_int(debug_level))
}

fn (mut this Class_PHPMailer_PHPMailer_POP3) authorise(var_host rt.PhpVal, port bool, timeout bool, username string, password string, debug_level i64) bool {
	mut port_mutated := port
	mut username_mutated := username
	mut password_mutated := password
	this.host = var_host.clone()
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(port_mutated))) {
		this.port = Class_PHPMailer_PHPMailer_static.default_port()
	} else {
		this.port = i64(port_mutated)
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(timeout))) {
		this.tval = Class_PHPMailer_PHPMailer_static.default_timeout()
	} else {
		this.tval = i64(timeout)
	}
	this.do_debug = rt.new_int(debug_level)
	this.username = rt.new_string(username_mutated).clone()
	this.password = rt.new_string(password_mutated).clone()
	this.errors = rt.new_array()
	mut var_result := rt.new_bool(this.connect(this.host, (this.port).to_bool(),
		(this.tval).to_i64()))
	if rt.is_true(var_result) {
		mut var_login_result :=
			rt.new_bool(this.login((this.username).str(), (this.password).str()))
		if rt.is_true(var_login_result) {
			this.disconnect()
			return true
		}
	}
	this.disconnect()
	return false
}

fn (mut this Class_PHPMailer_PHPMailer_POP3) connect(var_host rt.PhpVal, port bool, tval i64) bool {
	mut port_mutated := port
	if this.connected {
		return true
	}
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		rt.call_function('call_user_func_array', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('PHPMailer_PHPMailer_POP3', []string{},
					&this) },
				rt.ArrayItem{ key: none, val: 'catchWarning' },
			]),
			rt.call_function('func_get_args', []rt.PhpVal{}),
		])
		return rt.new_null()
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		rt.call_function('call_user_func_array', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('PHPMailer_PHPMailer_POP3', []string{},
					&this) },
				rt.ArrayItem{ key: none, val: 'catchWarning' },
			]),
			rt.call_function('func_get_args', []rt.PhpVal{}),
		])
		return rt.new_null()
	}
	rt.call_function('set_error_handler', [rt.new_closure(closure_1_fn)])
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(port_mutated))) {
		port_mutated = (Class_PHPMailer_PHPMailer_static.default_port()).to_bool()
	}
	mut var_errno := rt.new_int(0)
	mut var_errstr := rt.new_string('')
	this.pop_conn = rt.call_function('fsockopen', [var_host.clone(),
		rt.new_bool(port_mutated).clone(), var_errno.clone(),
		var_errstr.clone(), rt.new_int(tval)])
	rt.call_function('restore_error_handler', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_bool(false), this.pop_conn)) {
		this.seterror(rt.new_string('Failed to connect to server ${var_host.to_string()} on port ${var_port.to_string()}. errno: ${var_errno.to_string()}; errstr: ${var_errstr.to_string()}'))
		return false
	}
	rt.call_function('stream_set_timeout', [this.pop_conn, rt.new_int(tval),
		rt.new_int(0)])
	mut var_pop3_response := this.getresponse(0)
	if this.checkresponse(var_pop3_response.clone()) {
		this.connected = true
		return true
	}
	return false
}

fn (mut this Class_PHPMailer_PHPMailer_POP3) login(username string, password string) bool {
	mut username_mutated := username
	mut password_mutated := password
	if !(this.connected) {
		this.seterror(rt.new_string('Not connected to POP3 server'))
		return false
	}
	if username_mutated == '' {
		username_mutated = (this.username).str()
	}
	if password_mutated == '' {
		password_mutated = (this.password).str()
	}
	this.sendstring(rt.new_string('USER ${var_username.to_string()}' +
		(Class_PHPMailer_PHPMailer_static.le()).str()))
	mut var_pop3_response := this.getresponse(0)
	if this.checkresponse(var_pop3_response.clone()) {
		this.sendstring(rt.new_string('PASS ${var_password.to_string()}' +
			(Class_PHPMailer_PHPMailer_static.le()).str()))
		var_pop3_response = this.getresponse(0)
		if this.checkresponse(var_pop3_response.clone()) {
			return true
		}
	}
	return false
}

fn (mut this Class_PHPMailer_PHPMailer_POP3) disconnect() {
	if rt.is_true(rt.identical(this.pop_conn, rt.new_bool(false))) {
		return
	}
	this.sendstring(rt.new_string('QUIT' + (Class_PHPMailer_PHPMailer_static.le()).str()))
	this.getresponse(0)
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
	rt.call_function('fclose', [this.pop_conn])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'PHPMailer_PHPMailer_Exception') {
		var_e = var_e_2.clone()
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
	}

	end_label_2:
	this.connected = false
	this.pop_conn = rt.new_bool(false)
}

fn (mut this Class_PHPMailer_PHPMailer_POP3) getresponse(size i64) rt.PhpVal {
	mut var_response := rt.call_function('fgets', [this.pop_conn, rt.new_int(size)])
	if rt.is_true(rt.greater_equal(this.do_debug,
		Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_POP3.debug_server()))
	{
		print('Server -> Client: ')
		rt.echo_val(var_response)
	}
	return var_response.clone()
}

fn (mut this Class_PHPMailer_PHPMailer_POP3) sendstring(var_string rt.PhpVal) i64 {
	if rt.is_true(this.pop_conn) {
		if rt.is_true(rt.greater_equal(this.do_debug,
			Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_POP3.debug_client()))
		{
			print('Client -> Server: ')
			rt.echo_val(var_string)
		}
		return (rt.call_function('fwrite', [this.pop_conn, var_string.clone(),
			rt.new_int(var_string.clone().to_string().len)])).to_i64()
	}
	return 0
}

fn (mut this Class_PHPMailer_PHPMailer_POP3) checkresponse(var_string rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
		var_string.clone(),
		rt.new_string('+OK'),
	]), rt.new_int(0)))))
	{
		this.seterror(rt.new_string('Server reported an error: ${var_string.to_string()}'))
		return false
	}
	return true
}

fn (mut this Class_PHPMailer_PHPMailer_POP3) seterror(var_error rt.PhpVal) {
	this.errors.array_push(var_error.clone())
	if rt.is_true(rt.greater_equal(this.do_debug,
		Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_POP3.debug_server()))
	{
		print('<pre>')
		mut iter_1 := this.errors.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_e := item_1.val
			println(var_e.clone().to_string())
		}
		print('</pre>')
	}
}

fn (mut this Class_PHPMailer_PHPMailer_POP3) geterrors() rt.PhpVal {
	return this.errors
}

fn (mut this Class_PHPMailer_PHPMailer_POP3) catchwarning(var_errno rt.PhpVal, var_errstr rt.PhpVal, var_errfile rt.PhpVal, var_errline rt.PhpVal) {
	mut var_errno_mutated := var_errno
	mut var_errstr_mutated := var_errstr
	this.seterror(rt.new_string('Connecting to the POP3 server raised a PHP warning:' +
		'errno: ${var_errno.to_string()} errstr: ${var_errstr.to_string()}; errfile: ${var_errfile.to_string()}; errline: ${var_errline.to_string()}'))
}

struct Class_PHPMailer_PHPMailer_self {
	rt.PhpObjectBase
}

fn create_phpmailer_phpmailer_pop3(_args ...rt.PhpVal) &Class_PHPMailer_PHPMailer_POP3 {
	mut obj := &Class_PHPMailer_PHPMailer_POP3{
		PhpObjectBase: rt.PhpObjectBase{}
		do_debug:      rt.new_null()
		host:          rt.new_null()
		port:          rt.new_null()
		tval:          rt.new_null()
		username:      rt.new_null()
		password:      rt.new_null()
		pop_conn:      rt.new_null()
		connected:     false
		errors:        rt.new_array()
	}
	return obj
}

fn create_phpmailer_phpmailer_self(_args ...rt.PhpVal) &Class_PHPMailer_PHPMailer_self {
	mut obj := &Class_PHPMailer_PHPMailer_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_PHPMailer_PHPMailer_POP3) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'popBeforeSmtp' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).to_i64()
			return Class_PHPMailer_PHPMailer_POP3.popbeforesmtp(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5)
		}
		'authorise' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.authorise(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3, dispatch_arg_4, dispatch_arg_5))
		}
		'connect' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.connect(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'login' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.login(dispatch_arg_0, dispatch_arg_1))
		}
		'disconnect' {
			this.disconnect()
			return rt.new_null()
		}
		'getResponse' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.getresponse(dispatch_arg_0)
		}
		'sendString' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.sendstring(dispatch_arg_0))
		}
		'checkResponse' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.checkresponse(dispatch_arg_0))
		}
		'setError' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.seterror(dispatch_arg_0)
			return rt.new_null()
		}
		'getErrors' {
			return this.geterrors()
		}
		'catchWarning' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.catchwarning(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_PHPMailer_PHPMailer_POP3) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'do_debug' { return this.do_debug }
		'host' { return this.host }
		'port' { return this.port }
		'tval' { return this.tval }
		'username' { return this.username }
		'password' { return this.password }
		'pop_conn' { return this.pop_conn }
		'connected' { return rt.new_bool(this.connected) }
		'errors' { return this.errors }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_PHPMailer_PHPMailer_POP3) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'do_debug' {
			this.do_debug = val
			return true
		}
		'host' {
			this.host = val
			return true
		}
		'port' {
			this.port = val
			return true
		}
		'tval' {
			this.tval = val
			return true
		}
		'username' {
			this.username = val
			return true
		}
		'password' {
			this.password = val
			return true
		}
		'pop_conn' {
			this.pop_conn = val
			return true
		}
		'connected' {
			this.connected = val.to_bool()
			return true
		}
		'errors' {
			this.errors = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_PHPMailer_PHPMailer_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_PHPMailer_PHPMailer_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_PHPMailer_PHPMailer_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
