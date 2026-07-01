import rt
import crypto.md5

struct Class_POP3 {
	rt.PhpObjectBase
pub mut:
		ERROR rt.PhpVal = rt.new_string('')
		TIMEOUT rt.PhpVal = rt.new_int(60)
		COUNT rt.PhpVal = rt.new_null()
		BUFFER rt.PhpVal = rt.new_int(512)
		FP rt.PhpVal = rt.new_string('')
		MAILSERVER rt.PhpVal = rt.new_string('')
		DEBUG rt.PhpVal = rt.new_bool(false)
		BANNER rt.PhpVal = rt.new_string('')
		ALLOWAPOP rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_POP3) construct(server string, timeout string)  {
	mut server_mutated := server
	rt.call_function('settype', [this.BUFFER, rt.new_string('integer')])
	if !(server_mutated == '') {
		if !rt.is_true(this.MAILSERVER) {
			this.MAILSERVER = rt.new_string(server_mutated).dup()
		}
	}
	if !(timeout == '') {
		rt.call_function('settype', [rt.new_string(timeout), rt.new_string('integer')])
		this.TIMEOUT = rt.new_string(timeout).dup()
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('set_time_limit')])) {
			rt.call_function('set_time_limit', [rt.new_string(timeout)])
		}
	}
	return
}

fn (mut this Class_POP3) pop3(server string, timeout string)  {
	mut server_mutated := server
	fn (arg_0 string, arg_1 string) rt.PhpVal { mut temp := Class_POP3{}; return temp.construct(arg_0, arg_1) }(server_mutated, timeout)
}

fn (mut this Class_POP3) update_timer() bool {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('set_time_limit')])) {
		rt.call_function('set_time_limit', [this.TIMEOUT])
	}
	return true
}

fn (mut this Class_POP3) connect(var_server rt.PhpVal, port i64) bool {
	mut var_errno := rt.new_null()
	mut var_errstr := rt.new_null()
	mut var_server_mutated := var_server
	mut port_mutated := port
	if rt.is_true(rt.new_bool(!(!(rt.new_int(port_mutated)).is_null()) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(port_mutated))))))) {
		port_mutated = 110
	}
	if !(!rt.is_true(this.MAILSERVER)) {
		var_server_mutated = this.MAILSERVER
	}
	if !rt.is_true(var_server_mutated) {
		this.ERROR = 'POP3 connect: ' + (rt.call_function('_', [rt.new_string('No server specified')])).str()
		this.FP = rt.new_null()
		return false
	}
	mut var_fp := rt.call_function('fsockopen', [rt.new_string("${var_server.to_string()}"), rt.new_int(port_mutated).dup(), var_errno.dup(), var_errstr.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_fp)))) {
		this.ERROR = 'POP3 connect: ' + (rt.call_function('_', [rt.new_string('Error ')])).str() + "[${var_errno.to_string()}] [${var_errstr.to_string()}]"
		this.FP = rt.new_null()
		return false
	}
	rt.call_function('socket_set_blocking', [var_fp.dup(), // unsupported expression: Expr_UnaryMinus])
	this.update_timer()
	mut var_reply := rt.call_function('fgets', [var_fp.dup(), this.BUFFER])
	var_reply = this.strip_clf((var_reply).str())
	if rt.is_true(this.DEBUG) {
		rt.call_function('error_log', [rt.new_string("POP3 SEND [connect: ${var_server.to_string()}] GOT [${var_reply.to_string()}]"), rt.new_int(0)])
	}
	if !(this.is_ok((var_reply).str())) {
		this.ERROR = 'POP3 connect: ' + (rt.call_function('_', [rt.new_string('Error ')])).str() + "[${var_reply.to_string()}]"
		this.FP = rt.new_null()
		return false
	}
	this.FP = var_fp.dup()
	this.BANNER = this.parse_banner(var_reply.dup())
	return true
}

fn (mut this Class_POP3) user(user string) bool {
	if user == '' {
		this.ERROR = 'POP3 user: ' + (rt.call_function('_', [rt.new_string('no login ID submitted')])).str()
		return false
	} else if !(!(this.FP).is_null()) {
		this.ERROR = 'POP3 user: ' + (rt.call_function('_', [rt.new_string('connection not established')])).str()
		return false
	} else {
		mut var_reply := this.send_cmd("USER ${var_user}")
		if !(this.is_ok((var_reply).str())) {
			this.ERROR = 'POP3 user: ' + (rt.call_function('_', [rt.new_string('Error ')])).str() + "[${var_reply.to_string()}]"
			return false
		} else {
			return true
		}
	}
	return false
}

fn (mut this Class_POP3) pass(pass string) bool {
	if pass == '' {
		this.ERROR = 'POP3 pass: ' + (rt.call_function('_', [rt.new_string('No password submitted')])).str()
		return false
	} else if !(!(this.FP).is_null()) {
		this.ERROR = 'POP3 pass: ' + (rt.call_function('_', [rt.new_string('connection not established')])).str()
		return false
	} else {
		mut var_reply := this.send_cmd("PASS ${var_pass}")
		if !(this.is_ok((var_reply).str())) {
			this.ERROR = 'POP3 pass: ' + (rt.call_function('_', [rt.new_string('Authentication failed')])).str() + " [${var_reply.to_string()}]"
			this.quit()
			return false
		} else {
			mut var_count := this.last('count')
			this.COUNT = var_count.dup()
			return (var_count).to_bool()
		}
	}
	return false
}

fn (mut this Class_POP3) apop(var_login rt.PhpVal, var_pass rt.PhpVal) bool {
	if !(!(this.FP).is_null()) {
		this.ERROR = 'POP3 apop: ' + (rt.call_function('_', [rt.new_string('No connection to server')])).str()
		return false
	} else if rt.is_true(rt.new_bool(!(rt.is_true(this.ALLOWAPOP)))) {
		mut var_retVal := rt.new_bool(this.login((var_login).str(), (var_pass).str()))
		return (var_retVal).to_bool()
	} else if !rt.is_true(var_login) {
		this.ERROR = 'POP3 apop: ' + (rt.call_function('_', [rt.new_string('No login ID submitted')])).str()
		return false
	} else if !rt.is_true(var_pass) {
		this.ERROR = 'POP3 apop: ' + (rt.call_function('_', [rt.new_string('No password submitted')])).str()
		return false
	} else {
		mut var_banner := this.BANNER
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_banner)))) || !rt.is_true(var_banner))) {
			this.ERROR = 'POP3 apop: ' + (rt.call_function('_', [rt.new_string('No server banner')])).str() + ' - ' + (rt.call_function('_', [rt.new_string('abort')])).str()
			var_retVal = rt.new_bool(this.login((var_login).str(), (var_pass).str()))
			return (var_retVal).to_bool()
		} else {
			mut var_AuthString := var_banner.dup()
			// unsupported expression: Expr_AssignOp_Concat
			mut var_APOPString := rt.new_string(rt.new_string(md5.hexhash(var_AuthString.dup().to_string())))
			mut var_cmd := rt.new_string(rt.new_string("APOP ${var_login.to_string()} ${var_APOPString.to_string()}"))
			mut var_reply := this.send_cmd((var_cmd).str())
			if !(this.is_ok((var_reply).str())) {
				this.ERROR = 'POP3 apop: ' + (rt.call_function('_', [rt.new_string('apop authentication failed')])).str() + ' - ' + (rt.call_function('_', [rt.new_string('abort')])).str()
				var_retVal = rt.new_bool(this.login((var_login).str(), (var_pass).str()))
				return (var_retVal).to_bool()
			} else {
				mut var_count := this.last('count')
				this.COUNT = var_count.dup()
				return (var_count).to_bool()
			}
		}
	}
	return false
}

fn (mut this Class_POP3) login(login string, pass string) bool {
	if !(!(this.FP).is_null()) {
		this.ERROR = 'POP3 login: ' + (rt.call_function('_', [rt.new_string('No connection to server')])).str()
		return false
	} else {
		mut var_fp := this.FP
		if !(this.user(login)) {
			return false
		} else {
			mut var_count := rt.new_bool(this.pass(pass))
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_count)))) || rt.is_true(rt.equal(var_count, // unsupported expression: Expr_UnaryMinus)))) {
				return false
			} else {
				return (var_count).to_bool()
			}
		}
	}
	return false
}

fn (mut this Class_POP3) top(var_msgNum rt.PhpVal, numLines string) rt.PhpVal {
	if !(!(this.FP).is_null()) {
		this.ERROR = 'POP3 top: ' + (rt.call_function('_', [rt.new_string('No connection to server')])).str()
		return rt.new_bool(false)
	}
	this.update_timer()
	mut var_fp := this.FP
	mut var_buffer := this.BUFFER
	mut var_cmd := rt.new_string(rt.new_string("TOP ${var_msgNum.to_string()} ${var_numLines}"))
	rt.call_function('fwrite', [var_fp.dup(), rt.new_string("TOP ${var_msgNum.to_string()} ${var_numLines}\r\n")])
	mut var_reply := rt.call_function('fgets', [var_fp.dup(), var_buffer.dup()])
	var_reply = this.strip_clf((var_reply).str())
	if rt.is_true(this.DEBUG) {
		rt.call_function('error_log', [rt.new_string("POP3 SEND [${var_cmd.to_string()}] GOT [${var_reply.to_string()}]"), rt.new_int(0)])
	}
	if !(this.is_ok((var_reply).str())) {
		this.ERROR = 'POP3 top: ' + (rt.call_function('_', [rt.new_string('Error ')])).str() + "[${var_reply.to_string()}]"
		return rt.new_bool(false)
	}
	mut var_count := rt.new_int(rt.new_int(0))
	mut var_MsgArray := rt.new_array()
	mut var_line := rt.call_function('fgets', [var_fp.dup(), var_buffer.dup()])
	for rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^\\.\\r\\n/'), var_line.dup()]))))) {
		var_MsgArray.array_set(var_count, var_line.dup())
		rt.post_inc(var_count)
		var_line = rt.call_function('fgets', [.dup(), .dup()])
		if !rt.is_true(var_line) {
			break
		}
	}
	return .dup()
}

fn (mut this Class_POP3) pop_list(msgNum string) rt.PhpVal {
	mut var_junk := rt.new_null()
	mut var_num := rt.new_null()
	mut var_size := rt.new_null()
	mut var_thisMsg := rt.new_null()
	mut var_msgSize := rt.new_null()
}

fn (mut this Class_POP3) get(var_msgNum rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_POP3) last(type string) rt.PhpVal {
}

fn (mut this Class_POP3) reset() bool {
}

fn (mut this Class_POP3) send_cmd(cmd string) rt.PhpVal {
	mut cmd_mutated := cmd
}

fn (mut this Class_POP3) quit() bool {
}

fn (mut this Class_POP3) popstat() bool {
}

fn (mut this Class_POP3) uidl(msgNum string) rt.PhpVal {
	mut var_ok := rt.new_null()
	mut var_num := rt.new_null()
	mut var_myUidl := rt.new_null()
	mut var_msg := rt.new_null()
}

fn (mut this Class_POP3) delete(msgNum string) bool {
}

fn (mut this Class_POP3) is_ok(cmd string) bool {
	mut cmd_mutated := cmd
	return false
}

fn (mut this Class_POP3) strip_clf(text string) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_POP3) parse_banner(var_server_text rt.PhpVal) string {
}

fn create_pop3(server string, timeout string) &Class_POP3 {
	mut obj := &Class_POP3{
		PhpObjectBase: rt.PhpObjectBase{}
		ERROR: rt.new_string('')
		TIMEOUT: rt.new_int(60)
		COUNT: rt.new_null()
		BUFFER: rt.new_int(512)
		FP: rt.new_string('')
		MAILSERVER: rt.new_string('')
		DEBUG: rt.new_bool(false)
		BANNER: rt.new_string('')
		ALLOWAPOP: rt.new_bool(false)
	}
	obj.construct(server, timeout)
	return obj
}

fn (mut this Class_POP3) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'POP3' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.pop3(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'update_timer' {
			return rt.new_bool(this.update_timer())
		}
		'connect' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.connect(dispatch_arg_0, dispatch_arg_1))
		}
		'user' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.user(dispatch_arg_0))
		}
		'pass' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.pass(dispatch_arg_0))
		}
		'apop' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.apop(dispatch_arg_0, dispatch_arg_1))
		}
		'login' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.login(dispatch_arg_0, dispatch_arg_1))
		}
		'top' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.top(dispatch_arg_0, dispatch_arg_1)
		}
		'pop_list' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.pop_list(dispatch_arg_0)
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get(dispatch_arg_0)
		}
		'last' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.last(dispatch_arg_0)
		}
		'reset' {
			return rt.new_bool(this.reset())
		}
		'send_cmd' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.send_cmd(dispatch_arg_0)
		}
		'quit' {
			return rt.new_bool(this.quit())
		}
		'popstat' {
			return rt.new_bool(this.popstat())
		}
		'uidl' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.uidl(dispatch_arg_0)
		}
		'delete' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.delete(dispatch_arg_0))
		}
		'is_ok' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_ok(dispatch_arg_0))
		}
		'strip_clf' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.strip_clf(dispatch_arg_0)
		}
		'parse_banner' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.parse_banner(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_POP3) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'ERROR' { return this.ERROR }
		'TIMEOUT' { return this.TIMEOUT }
		'COUNT' { return this.COUNT }
		'BUFFER' { return this.BUFFER }
		'FP' { return this.FP }
		'MAILSERVER' { return this.MAILSERVER }
		'DEBUG' { return this.DEBUG }
		'BANNER' { return this.BANNER }
		'ALLOWAPOP' { return this.ALLOWAPOP }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_POP3) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'ERROR' { this.ERROR = val; return true }
		'TIMEOUT' { this.TIMEOUT = val; return true }
		'COUNT' { this.COUNT = val; return true }
		'BUFFER' { this.BUFFER = val; return true }
		'FP' { this.FP = val; return true }
		'MAILSERVER' { this.MAILSERVER = val; return true }
		'DEBUG' { this.DEBUG = val; return true }
		'BANNER' { this.BANNER = val; return true }
		'ALLOWAPOP' { this.ALLOWAPOP = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_class_pop3_php() {
}
