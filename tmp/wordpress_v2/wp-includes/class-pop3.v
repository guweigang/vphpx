import rt
import crypto.md5

struct Class_POP3 {
	rt.PhpObjectBase
pub mut:
	ERROR      rt.PhpVal = rt.new_string('')
	TIMEOUT    rt.PhpVal = rt.new_int(60)
	COUNT      rt.PhpVal = rt.new_null()
	BUFFER     rt.PhpVal = rt.new_int(512)
	FP         rt.PhpVal = rt.new_string('')
	MAILSERVER rt.PhpVal = rt.new_string('')
	DEBUG      rt.PhpVal = rt.new_bool(false)
	BANNER     rt.PhpVal = rt.new_string('')
	ALLOWAPOP  rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_POP3) construct(server string, timeout string) {
	mut server_mutated := server
	rt.call_function('settype', [this.BUFFER, rt.new_string('integer')])
	if !(server_mutated == '') {
		if !rt.is_true(this.MAILSERVER) {
			this.MAILSERVER = rt.new_string(server_mutated).clone()
		}
	}
	if !(timeout == '') {
		rt.call_function('settype', [rt.new_string(timeout), rt.new_string('integer')])
		this.TIMEOUT = rt.new_string(timeout)
		if rt.is_true(rt.call_function('function_exists', [
			rt.new_string('set_time_limit'),
		]))
		{
			rt.call_function('set_time_limit', [rt.new_string(timeout)])
		}
	}
	return
}

fn (mut this Class_POP3) pop3(server string, timeout string) {
	mut server_mutated := server
	mut iife_temp_0 := Class_POP3{}
	mut iife_result_0 := iife_temp_0.construct(server_mutated, timeout)
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
	if !(!(rt.new_int(port_mutated)).is_null())
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(port_mutated))))) {
		port_mutated = 110
	}
	if !(!rt.is_true(this.MAILSERVER)) {
		var_server_mutated = this.MAILSERVER
	}
	if !rt.is_true(var_server_mutated) {
		this.ERROR = 'POP3 connect: ' +
			(rt.call_function('_', [rt.new_string('No server specified')])).str()
		this.FP = rt.new_null()
		return false
	}
	mut var_fp := rt.call_function('fsockopen', [
		rt.new_string('${var_server.to_string()}'),
		rt.new_int(port_mutated).clone(),
		var_errno.clone(),
		var_errstr.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_fp)))) {
		this.ERROR = 'POP3 connect: ' + (rt.call_function('_', [rt.new_string('Error ')])).str() +
			'[${var_errno.to_string()}] [${var_errstr.to_string()}]'
		this.FP = rt.new_null()
		return false
	}
	rt.call_function('socket_set_blocking', [var_fp.clone(), rt.new_int(-1)])
	this.update_timer()
	mut var_reply := rt.call_function('fgets', [var_fp.clone(), this.BUFFER])
	var_reply = this.strip_clf(var_reply.str())
	if rt.is_true(this.DEBUG) {
		rt.call_function('error_log', [
			rt.new_string('POP3 SEND [connect: ${var_server.to_string()}] GOT [${var_reply.to_string()}]'),
			rt.new_int(0),
		])
	}
	if !(this.is_ok(var_reply.str())) {
		this.ERROR = 'POP3 connect: ' + (rt.call_function('_', [rt.new_string('Error ')])).str() +
			'[${var_reply.to_string()}]'
		this.FP = rt.new_null()
		return false
	}
	this.FP = var_fp.clone()
	this.BANNER = this.parse_banner(var_reply.clone())
	return true
}

fn (mut this Class_POP3) user(user string) bool {
	if user == '' {
		this.ERROR = 'POP3 user: ' +
			(rt.call_function('_', [rt.new_string('no login ID submitted')])).str()
		return false
	} else if !(!(this.FP).is_null()) {
		this.ERROR = 'POP3 user: ' +
			(rt.call_function('_', [rt.new_string('connection not established')])).str()
		return false
	} else {
		mut var_reply := this.send_cmd('USER ${var_user}')
		if !(this.is_ok(var_reply.str())) {
			this.ERROR = 'POP3 user: ' + (rt.call_function('_', [rt.new_string('Error ')])).str() +
				'[${var_reply.to_string()}]'
			return false
		} else {
			return true
		}
	}
	return false
}

fn (mut this Class_POP3) pass(pass string) bool {
	if pass == '' {
		this.ERROR = 'POP3 pass: ' +
			(rt.call_function('_', [rt.new_string('No password submitted')])).str()
		return false
	} else if !(!(this.FP).is_null()) {
		this.ERROR = 'POP3 pass: ' +
			(rt.call_function('_', [rt.new_string('connection not established')])).str()
		return false
	} else {
		mut var_reply := this.send_cmd('PASS ${var_pass}')
		if !(this.is_ok(var_reply.str())) {
			this.ERROR = 'POP3 pass: ' +
				(rt.call_function('_', [rt.new_string('Authentication failed')])).str() +
				' [${var_reply.to_string()}]'
			this.quit()
			return false
		} else {
			mut var_count := this.last('count')
			this.COUNT = var_count.clone()
			return var_count.to_bool()
		}
	}
	return false
}

fn (mut this Class_POP3) apop(var_login rt.PhpVal, var_pass rt.PhpVal) bool {
	if !(!(this.FP).is_null()) {
		this.ERROR = 'POP3 apop: ' +
			(rt.call_function('_', [rt.new_string('No connection to server')])).str()
		return false
	} else if rt.is_true(rt.new_bool(!(rt.is_true(this.ALLOWAPOP)))) {
		mut var_retVal := rt.new_bool(this.login(var_login.str(), var_pass.str()))
		return var_retVal.to_bool()
	} else if !rt.is_true(var_login) {
		this.ERROR = 'POP3 apop: ' +
			(rt.call_function('_', [rt.new_string('No login ID submitted')])).str()
		return false
	} else if !rt.is_true(var_pass) {
		this.ERROR = 'POP3 apop: ' +
			(rt.call_function('_', [rt.new_string('No password submitted')])).str()
		return false
	} else {
		mut var_banner := this.BANNER
		if rt.is_true(rt.new_bool(!(rt.is_true(var_banner)))) || !rt.is_true(var_banner) {
			this.ERROR = 'POP3 apop: ' +
				(rt.call_function('_', [rt.new_string('No server banner')])).str() + ' - ' +
				(rt.call_function('_', [rt.new_string('abort')])).str()
			var_retVal = rt.new_bool(this.login(var_login.str(), var_pass.str()))
			return var_retVal.to_bool()
		} else {
			mut var_AuthString := var_banner.clone()
			var_AuthString = rt.concat(var_AuthString, var_pass)
			mut var_APOPString := rt.new_string(md5.hexhash(var_AuthString.clone().to_string()))
			mut var_cmd :=
				rt.new_string('APOP ${var_login.to_string()} ${var_APOPString.to_string()}')
			mut var_reply := this.send_cmd(var_cmd.str())
			if !(this.is_ok(var_reply.str())) {
				this.ERROR = 'POP3 apop: ' +
					(rt.call_function('_', [rt.new_string('apop authentication failed')])).str() +
					' - ' + (rt.call_function('_', [rt.new_string('abort')])).str()
				var_retVal = rt.new_bool(this.login(var_login.str(), var_pass.str()))
				return var_retVal.to_bool()
			} else {
				mut var_count := this.last('count')
				this.COUNT = var_count.clone()
				return var_count.to_bool()
			}
		}
	}
	return false
}

fn (mut this Class_POP3) login(login string, pass string) bool {
	if !(!(this.FP).is_null()) {
		this.ERROR = 'POP3 login: ' +
			(rt.call_function('_', [rt.new_string('No connection to server')])).str()
		return false
	} else {
		mut var_fp := this.FP
		if !(this.user(login)) {
			return false
		} else {
			mut var_count := rt.new_bool(this.pass(pass))
			if rt.is_true(rt.new_bool(!(rt.is_true(var_count))))
				|| rt.is_true(rt.equal(var_count, -1)) {
				return false
			} else {
				return var_count.to_bool()
			}
		}
	}
	return false
}

fn (mut this Class_POP3) top(var_msgNum rt.PhpVal, numLines string) rt.PhpVal {
	if !(!(this.FP).is_null()) {
		this.ERROR = 'POP3 top: ' +
			(rt.call_function('_', [rt.new_string('No connection to server')])).str()
		return rt.new_bool(false)
	}
	this.update_timer()
	mut var_fp := this.FP
	mut var_buffer := this.BUFFER
	mut var_cmd := rt.new_string('TOP ${var_msgNum.to_string()} ${var_numLines}')
	rt.call_function('fwrite', [var_fp.clone(),
		rt.new_string('TOP ${var_msgNum.to_string()} ${var_numLines}\r\n')])
	mut var_reply := rt.call_function('fgets', [var_fp.clone(),
		var_buffer.clone()])
	var_reply = this.strip_clf(var_reply.str())
	if rt.is_true(this.DEBUG) {
		rt.call_function('error_log', [
			rt.new_string('POP3 SEND [${var_cmd.to_string()}] GOT [${var_reply.to_string()}]'),
			rt.new_int(0),
		])
	}
	if !(this.is_ok(var_reply.str())) {
		this.ERROR = 'POP3 top: ' + (rt.call_function('_', [rt.new_string('Error ')])).str() +
			'[${var_reply.to_string()}]'
		return rt.new_bool(false)
	}
	mut var_count := rt.new_int(0)
	mut var_MsgArray := rt.new_array()
	mut var_line := rt.call_function('fgets', [var_fp.clone(),
		var_buffer.clone()])
	for rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
		rt.new_string('/^\\.\\r\\n/'),
		var_line.clone(),
	]))))) {
		var_MsgArray.array_set(var_count, var_line.clone())
		rt.post_inc(var_count)
		var_line = rt.call_function('fgets', [var_fp.clone(),
			var_buffer.clone()])
		if !rt.is_true(var_line) {
			break
		}
	}
	return var_MsgArray.clone()
}

fn (mut this Class_POP3) pop_list(msgNum string) rt.PhpVal {
	mut var_junk := rt.new_null()
	mut var_num := rt.new_null()
	mut var_size := rt.new_null()
	mut var_thisMsg := rt.new_null()
	mut var_msgSize := rt.new_null()
	if !(!(this.FP).is_null()) {
		this.ERROR = 'POP3 pop_list: ' +
			(rt.call_function('_', [rt.new_string('No connection to server')])).str()
		return rt.new_bool(false)
	}
	mut var_fp := this.FP
	mut var_Total := this.COUNT
	if rt.is_true(rt.new_bool(!(rt.is_true(var_Total)))) || rt.is_true(rt.equal(var_Total, -1)) {
		return rt.new_bool(false)
	}
	if rt.is_true(rt.equal(var_Total, rt.new_int(0))) {
		return rt.create_array([rt.ArrayItem{ key: none, val: '0' },
			rt.ArrayItem{ key: none, val: '0' }])
	}
	this.update_timer()
	if !(msgNum == '') {
		mut var_cmd := rt.new_string('LIST ${var_msgNum}')
		rt.call_function('fwrite', [var_fp.clone(), rt.new_string('${var_cmd.to_string()}\r\n')])
		mut var_reply := rt.call_function('fgets', [var_fp.clone(), this.BUFFER])
		var_reply = this.strip_clf(var_reply.str())
		if rt.is_true(this.DEBUG) {
			rt.call_function('error_log', [
				rt.new_string('POP3 SEND [${var_cmd.to_string()}] GOT [${var_reply.to_string()}]'),
				rt.new_int(0),
			])
		}
		if !(this.is_ok(var_reply.str())) {
			this.ERROR = 'POP3 pop_list: ' +
				(rt.call_function('_', [rt.new_string('Error ')])).str() +
				'[${var_reply.to_string()}]'
			return rt.new_bool(false)
		}
		mut list_tmp_1 := rt.call_function('preg_split', [rt.new_string('/\\s+/'),
			var_reply.clone()])
		var_junk = list_tmp_1.array_get(0)
		var_num = list_tmp_1.array_get(1)
		var_size = list_tmp_1.array_get(2)
		return var_size.clone()
	}
	var_cmd = rt.new_string('LIST')
	var_reply = this.send_cmd(var_cmd.str())
	if !(this.is_ok(var_reply.str())) {
		var_reply = this.strip_clf(var_reply.str())
		this.ERROR = 'POP3 pop_list: ' + (rt.call_function('_', [rt.new_string('Error ')])).str() +
			'[${var_reply.to_string()}]'
		return rt.new_bool(false)
	}
	mut var_MsgArray := rt.new_array()
	var_MsgArray.array_set(0, var_Total.clone())
	mut var_msgC := rt.new_int(1)
	for {
		if !(rt.is_true(rt.less_equal(var_msgC, var_Total))) { break
		 }
		if rt.is_true(rt.greater(var_msgC, var_Total)) {
			break
		}
		mut var_line := rt.call_function('fgets', [var_fp.clone(), this.BUFFER])
		var_line = this.strip_clf(var_line.str())
		if rt.is_true(rt.identical(rt.call_function('strpos', [
			var_line.clone(), rt.new_string('.')]), rt.new_int(0)))
		{
			this.ERROR = 'POP3 pop_list: ' +
				(rt.call_function('_', [rt.new_string('Premature end of list')])).str()
			return rt.new_bool(false)
		}
		mut list_tmp_2 := rt.call_function('preg_split', [rt.new_string('/\\s+/'),
			var_line.clone()])
		var_thisMsg = list_tmp_2.array_get(0)
		var_msgSize = list_tmp_2.array_get(1)
		rt.call_function('settype', [var_thisMsg.clone(), rt.new_string('integer')])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_thisMsg, var_msgC)))) {
			var_MsgArray.array_set(var_msgC, 'deleted')
		} else {
			var_MsgArray.array_set(var_msgC, var_msgSize.clone())
		}
		rt.post_inc(var_msgC)
	}
	return var_MsgArray.clone()
}

fn (mut this Class_POP3) get(var_msgNum rt.PhpVal) rt.PhpVal {
	if !(!(this.FP).is_null()) {
		this.ERROR = 'POP3 get: ' +
			(rt.call_function('_', [rt.new_string('No connection to server')])).str()
		return rt.new_bool(false)
	}
	this.update_timer()
	mut var_fp := this.FP
	mut var_buffer := this.BUFFER
	mut var_cmd := rt.new_string('RETR ${var_msgNum.to_string()}')
	mut var_reply := this.send_cmd(var_cmd.str())
	if !(this.is_ok(var_reply.str())) {
		this.ERROR = 'POP3 get: ' + (rt.call_function('_', [rt.new_string('Error ')])).str() +
			'[${var_reply.to_string()}]'
		return rt.new_bool(false)
	}
	mut var_count := rt.new_int(0)
	mut var_MsgArray := rt.new_array()
	mut var_line := rt.call_function('fgets', [var_fp.clone(),
		var_buffer.clone()])
	for rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
		rt.new_string('/^\\.\\r\\n/'),
		var_line.clone(),
	]))))) {
		if rt.is_true(rt.equal(var_line.array_get(rt.new_int(0)), rt.new_string('.'))) {
			var_line = rt.call_function('substr', [var_line.clone(),
				rt.new_int(1)])
		}
		var_MsgArray.array_set(var_count, var_line.clone())
		rt.post_inc(var_count)
		var_line = rt.call_function('fgets', [var_fp.clone(),
			var_buffer.clone()])
		if !rt.is_true(var_line) {
			break
		}
	}
	return var_MsgArray.clone()
}

fn (mut this Class_POP3) last(type string) rt.PhpVal {
	mut var_last := rt.new_int(-1)
	if !(!(this.FP).is_null()) {
		this.ERROR = 'POP3 last: ' +
			(rt.call_function('_', [rt.new_string('No connection to server')])).str()
		return var_last.clone()
	}
	mut var_reply := this.send_cmd('STAT')
	if !(this.is_ok(var_reply.str())) {
		this.ERROR = 'POP3 last: ' + (rt.call_function('_', [rt.new_string('Error ')])).str() +
			'[${var_reply.to_string()}]'
		return var_last.clone()
	}
	mut var_Vars := rt.call_function('preg_split', [rt.new_string('/\\s+/'),
		var_reply.clone()])
	mut var_count := var_Vars.array_get(rt.new_int(1))
	mut var_size := var_Vars.array_get(rt.new_int(2))
	rt.call_function('settype', [var_count.clone(), rt.new_string('integer')])
	rt.call_function('settype', [var_size.clone(), rt.new_string('integer')])
	if rt.is_true(rt.new_bool(type != 'count')) {
		return rt.create_array([rt.ArrayItem{ key: none, val: var_count },
			rt.ArrayItem{ key: none, val: var_size }])
	}
	return var_count.clone()
}

fn (mut this Class_POP3) reset() bool {
	if !(!(this.FP).is_null()) {
		this.ERROR = 'POP3 reset: ' +
			(rt.call_function('_', [rt.new_string('No connection to server')])).str()
		return false
	}
	mut var_reply := this.send_cmd('RSET')
	if !(this.is_ok(var_reply.str())) {
		this.ERROR = 'POP3 reset: ' + (rt.call_function('_', [rt.new_string('Error ')])).str() +
			'[${var_reply.to_string()}]'
		rt.call_function('error_log', [
			rt.new_string('POP3 reset: ERROR [${var_reply.to_string()}]'),
			rt.new_int(0),
		])
	}
	this.quit()
	return true
}

fn (mut this Class_POP3) send_cmd(cmd string) rt.PhpVal {
	mut cmd_mutated := cmd
	if !(!(this.FP).is_null()) {
		this.ERROR = 'POP3 send_cmd: ' +
			(rt.call_function('_', [rt.new_string('No connection to server')])).str()
		return rt.new_bool(false)
	}
	if cmd_mutated == '' {
		this.ERROR = 'POP3 send_cmd: ' +
			(rt.call_function('_', [rt.new_string('Empty command string')])).str()
		return rt.new_string('')
	}
	mut var_fp := this.FP
	mut var_buffer := this.BUFFER
	this.update_timer()
	rt.call_function('fwrite', [var_fp.clone(), rt.new_string('${var_cmd.to_string()}\r\n')])
	mut var_reply := rt.call_function('fgets', [var_fp.clone(),
		var_buffer.clone()])
	var_reply = this.strip_clf(var_reply.str())
	if rt.is_true(this.DEBUG) {
		rt.call_function('error_log', [
			rt.new_string('POP3 SEND [${var_cmd.to_string()}] GOT [${var_reply.to_string()}]'),
			rt.new_int(0),
		])
	}
	return var_reply.clone()
}

fn (mut this Class_POP3) quit() bool {
	if !(!(this.FP).is_null()) {
		this.ERROR = 'POP3 quit: ' +
			(rt.call_function('_', [rt.new_string('connection does not exist')])).str()
		return false
	}
	mut var_fp := this.FP
	mut var_cmd := rt.new_string('QUIT')
	rt.call_function('fwrite', [var_fp.clone(), rt.new_string('${var_cmd.to_string()}\r\n')])
	mut var_reply := rt.call_function('fgets', [var_fp.clone(), this.BUFFER])
	var_reply = this.strip_clf(var_reply.str())
	if rt.is_true(this.DEBUG) {
		rt.call_function('error_log', [
			rt.new_string('POP3 SEND [${var_cmd.to_string()}] GOT [${var_reply.to_string()}]'),
			rt.new_int(0),
		])
	}
	rt.call_function('fclose', [var_fp.clone()])
	this.FP = rt.new_null()
	return true
}

fn (mut this Class_POP3) popstat() bool {
	mut var_PopArray := this.last('array')
	if rt.is_true(rt.equal(var_PopArray, -1)) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_PopArray)))) || !rt.is_true(var_PopArray) {
		return false
	}
	return var_PopArray.to_bool()
}

fn (mut this Class_POP3) uidl(msgNum string) rt.PhpVal {
	mut var_ok := rt.new_null()
	mut var_num := rt.new_null()
	mut var_myUidl := rt.new_null()
	mut var_msg := rt.new_null()
	if !(!(this.FP).is_null()) {
		this.ERROR = 'POP3 uidl: ' +
			(rt.call_function('_', [rt.new_string('No connection to server')])).str()
		return rt.new_bool(false)
	}
	mut var_fp := this.FP
	mut var_buffer := this.BUFFER
	if !(msgNum == '') {
		mut var_cmd := rt.new_string('UIDL ${var_msgNum}')
		mut var_reply := this.send_cmd(var_cmd.str())
		if !(this.is_ok(var_reply.str())) {
			this.ERROR = 'POP3 uidl: ' + (rt.call_function('_', [rt.new_string('Error ')])).str() +
				'[${var_reply.to_string()}]'
			return rt.new_bool(false)
		}
		mut list_tmp_3 := rt.call_function('preg_split', [rt.new_string('/\\s+/'),
			var_reply.clone()])
		var_ok = list_tmp_3.array_get(0)
		var_num = list_tmp_3.array_get(1)
		var_myUidl = list_tmp_3.array_get(2)
		return var_myUidl.clone()
	} else {
		this.update_timer()
		mut var_UIDLArray := rt.new_array()
		mut var_Total := this.COUNT
		var_UIDLArray.array_set(0, var_Total.clone())
		if rt.is_true(rt.less(var_Total, rt.new_int(1))) {
			return var_UIDLArray.clone()
		}
		var_cmd = rt.new_string('UIDL')
		rt.call_function('fwrite', [var_fp.clone(), rt.new_string('UIDL\r\n')])
		var_reply = rt.call_function('fgets', [var_fp.clone(),
			var_buffer.clone()])
		var_reply = this.strip_clf(var_reply.str())
		if rt.is_true(this.DEBUG) {
			rt.call_function('error_log', [
				rt.new_string('POP3 SEND [${var_cmd.to_string()}] GOT [${var_reply.to_string()}]'),
				rt.new_int(0),
			])
		}
		if !(this.is_ok(var_reply.str())) {
			this.ERROR = 'POP3 uidl: ' + (rt.call_function('_', [rt.new_string('Error ')])).str() +
				'[${var_reply.to_string()}]'
			return rt.new_bool(false)
		}
		mut var_line := rt.new_string('')
		mut var_count := rt.new_int(1)
		var_line = rt.call_function('fgets', [var_fp.clone(),
			var_buffer.clone()])
		for rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
			rt.new_string('/^\\.\\r\\n/'),
			var_line.clone(),
		]))))) {
			mut list_tmp_4 := rt.call_function('preg_split', [
				rt.new_string('/\\s+/'), var_line.clone()])
			var_msg = list_tmp_4.array_get(0)
			mut var_msgUidl := list_tmp_4.array_get(1)
			var_msgUidl = this.strip_clf(var_msgUidl.str())
			if rt.is_true(rt.equal(var_count, var_msg)) {
				var_UIDLArray.array_set(var_msg, var_msgUidl.clone())
			} else {
				var_UIDLArray.array_set(var_count, 'deleted')
			}
			rt.post_inc(var_count)
			var_line = rt.call_function('fgets', [var_fp.clone(),
				var_buffer.clone()])
		}
	}
	return var_UIDLArray.clone()
}

fn (mut this Class_POP3) delete(msgNum string) bool {
	if !(!(this.FP).is_null()) {
		this.ERROR = 'POP3 delete: ' +
			(rt.call_function('_', [rt.new_string('No connection to server')])).str()
		return false
	}
	if msgNum == '' {
		this.ERROR = 'POP3 delete: ' +
			(rt.call_function('_', [rt.new_string('No msg number submitted')])).str()
		return false
	}
	mut var_reply := this.send_cmd('DELE ${var_msgNum}')
	if !(this.is_ok(var_reply.str())) {
		this.ERROR = 'POP3 delete: ' +
			(rt.call_function('_', [rt.new_string('Command failed ')])).str() +
			'[${var_reply.to_string()}]'
		return false
	}
	return true
}

fn (mut this Class_POP3) is_ok(cmd string) bool {
	mut cmd_mutated := cmd
	if cmd_mutated == '' {
		return false
	} else {
		return rt.new_bool(!rt.is_true(rt.identical(stripos(rt.new_string(cmd_mutated).clone(),
			'+OK'), rt.new_bool(false))))
	}
	return false
}

fn (mut this Class_POP3) strip_clf(text string) rt.PhpVal {
	if text == '' {
		return rt.new_string(text)
	} else {
		mut var_stripped := rt.call_function('str_replace', [
			rt.create_array([rt.ArrayItem{ key: none, val: '\r' },
				rt.ArrayItem{ key: none, val: '\n' }]),
			rt.new_string(''),
			rt.new_string(text),
		])
		return var_stripped.clone()
	}
	return rt.new_null()
}

fn (mut this Class_POP3) parse_banner(var_server_text rt.PhpVal) string {
	mut var_outside := rt.new_bool(true)
	mut var_banner := rt.new_string('')
	mut var_length := rt.new_int(var_server_text.clone().to_string().len)
	mut var_count := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_count, var_length))) { break
		 }
		mut var_digit := rt.call_function('substr', [var_server_text.clone(),
			var_count.clone(), rt.new_int(1)])
		if !(!rt.is_true(var_digit)) {
			if rt.is_true(rt.new_bool(!(rt.is_true(var_outside))))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_digit, rt.new_string('<')))))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_digit, rt.new_string('>'))))) {
				var_banner = rt.concat(var_banner, var_digit)
			}
			if rt.is_true(rt.equal(var_digit, rt.new_string('<'))) {
				var_outside = rt.new_bool(false)
			}
			if rt.is_true(rt.equal(var_digit, rt.new_string('>'))) {
				var_outside = rt.new_bool(true)
			}
		}
		rt.post_inc(var_count)
	}
	var_banner = this.strip_clf(var_banner.str())
	return '<${var_banner.to_string()}>'
}

fn stripos(var_haystack rt.PhpVal, needle string) rt.PhpVal {
	mut var_needle := needle
	return rt.call_function('strpos', [var_haystack.clone(),
		rt.call_function('stristr', [var_haystack.clone(), rt.new_string(needle)])])
}

fn create_pop3(server string, timeout string) &Class_POP3 {
	mut obj := &Class_POP3{
		PhpObjectBase: rt.PhpObjectBase{}
		ERROR:         rt.new_string('')
		TIMEOUT:       rt.new_int(60)
		COUNT:         rt.new_null()
		BUFFER:        rt.new_int(512)
		FP:            rt.new_string('')
		MAILSERVER:    rt.new_string('')
		DEBUG:         rt.new_bool(false)
		BANNER:        rt.new_string('')
		ALLOWAPOP:     rt.new_bool(false)
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
		else {
			return none
		}
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
		'ERROR' {
			this.ERROR = val
			return true
		}
		'TIMEOUT' {
			this.TIMEOUT = val
			return true
		}
		'COUNT' {
			this.COUNT = val
			return true
		}
		'BUFFER' {
			this.BUFFER = val
			return true
		}
		'FP' {
			this.FP = val
			return true
		}
		'MAILSERVER' {
			this.MAILSERVER = val
			return true
		}
		'DEBUG' {
			this.DEBUG = val
			return true
		}
		'BANNER' {
			this.BANNER = val
			return true
		}
		'ALLOWAPOP' {
			this.ALLOWAPOP = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('stripos'),
	])))))
	{
	}
}
