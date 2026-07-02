import rt

struct Class_VHttpd_DbGateway_Client {
	rt.PhpObjectBase
pub mut:
		client rt.PhpVal = rt.new_null()
}

fn (mut this Class_VHttpd_DbGateway_Client) construct(socketPath string, pool string, connectTimeoutSeconds f64, readTimeoutSeconds f64) {
	mut pool_mutated := pool
	this.client = create_vhttpd_wire_jsonclient(rt.get_property(rt.new_object('VHttpd_DbGateway_Client', []string{}, &this), 'socketPath'), rt.new_string('db_gateway'), rt.get_property(rt.new_object('VHttpd_DbGateway_Client', []string{}, &this), 'connectTimeoutSeconds'), rt.get_property(rt.new_object('VHttpd_DbGateway_Client', []string{}, &this), 'readTimeoutSeconds'))
}

fn Class_VHttpd_DbGateway_Client.fromenv(socketEnv string, poolEnv string, timeoutEnv string, defaultSocket string, defaultPool string) rt.PhpVal {
	mut var_socket := rt.call_function('getenv', [rt.new_string(socketEnv)])
	mut var_pool := rt.call_function('getenv', [rt.new_string(poolEnv)])
	mut var_timeout := rt.call_function('getenv', [rt.new_string(timeoutEnv)])
	mut var_timeoutSeconds := if var_timeout.clone().is_string() && rt.is_true(rt.call_function('ctype_digit', [var_timeout.clone()])) { rt.div(rt.call_function('max', [rt.new_int(1), rt.new_int((var_timeout).to_i64())]), rt.new_int(1000)) } else { rt.new_float(5) }
	return rt.new_object('VHttpd_DbGateway_self', []string{}, create_vhttpd_dbgateway_self(if var_socket.clone().is_string() && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_socket, rt.new_string(''))))) { var_socket } else { rt.new_string(defaultSocket) }, if var_pool.clone().is_string() && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_pool, rt.new_string(''))))) { var_pool } else { rt.new_string(defaultPool) }, rt.new_float(1), var_timeoutSeconds.clone()))
}

fn (mut this Class_VHttpd_DbGateway_Client) connect() {
	rt.call_method(this.client, 'connect', []rt.PhpVal{})
}

fn (mut this Class_VHttpd_DbGateway_Client) close() {
	rt.call_method(this.client, 'close', []rt.PhpVal{})
}

fn (mut this Class_VHttpd_DbGateway_Client) ping(timeoutMs i64) rt.PhpVal {
	return this.call('ping', '', mut rt.cast_object_ptr[Class_VHttpd_DbGateway_array](rt.new_array()), '', timeoutMs)
}

fn (mut this Class_VHttpd_DbGateway_Client) begintransaction(timeoutMs i64) string {
	mut var_response := this.call('begin_transaction', '', mut rt.cast_object_ptr[Class_VHttpd_DbGateway_array](rt.new_array()), '', timeoutMs)
	mut var_sessionId := rt.new_string((if !(var_response.array_get(rt.new_string('session_id'))).is_null() { var_response.array_get(rt.new_string('session_id')) } else { rt.new_string('') }).str())
	if rt.is_true(rt.identical(var_sessionId, rt.new_string(''))) {
		rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception(rt.new_string('db_begin_missing_session_id'))))
	}
	return (var_sessionId).str()
}

fn (mut this Class_VHttpd_DbGateway_Client) commit(sessionId string, timeoutMs i64) rt.PhpVal {
	mut sessionId_mutated := sessionId
	return this.call('commit', '', mut rt.cast_object_ptr[Class_VHttpd_DbGateway_array](rt.new_array()), sessionId_mutated, timeoutMs)
}

fn (mut this Class_VHttpd_DbGateway_Client) rollback(sessionId string, timeoutMs i64) rt.PhpVal {
	mut sessionId_mutated := sessionId
	return this.call('rollback', '', mut rt.cast_object_ptr[Class_VHttpd_DbGateway_array](rt.new_array()), sessionId_mutated, timeoutMs)
}

fn (mut this Class_VHttpd_DbGateway_Client) query(sql string, mut var_params Class_VHttpd_DbGateway_array, sessionId string, timeoutMs i64) rt.PhpVal {
	mut sessionId_mutated := sessionId
	return this.call('query', sql, mut var_params, sessionId_mutated, timeoutMs)
}

fn (mut this Class_VHttpd_DbGateway_Client) execute(sql string, mut var_params Class_VHttpd_DbGateway_array, sessionId string, timeoutMs i64) rt.PhpVal {
	mut sessionId_mutated := sessionId
	return this.call('execute', sql, mut var_params, sessionId_mutated, timeoutMs)
}

fn (mut this Class_VHttpd_DbGateway_Client) escape(value string, sessionId string, timeoutMs i64) string {
	mut sessionId_mutated := sessionId
	mut var_response := this.call('escape', '', mut rt.cast_object_ptr[Class_VHttpd_DbGateway_array](rt.create_array([rt.ArrayItem{ key: none, val: value }])), sessionId_mutated, timeoutMs)
	return (if !(var_response.array_get(rt.new_string('escaped'))).is_null() { var_response.array_get(rt.new_string('escaped')) } else { rt.new_string('') }).str()
}

fn (mut this Class_VHttpd_DbGateway_Client) call(op string, sql string, mut var_params Class_VHttpd_DbGateway_array, sessionId string, timeoutMs i64) rt.PhpVal {
	mut var_value := ''
	mut sessionId_mutated := sessionId
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return var_value
		}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return var_value
		}
	mut var_stringParams := rt.call_function('array_map', [rt.new_closure(closure_1_fn), rt.call_function('array_values', [var_params])])
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return Class_VHttpd_DbGateway_Client.jsonsafeparam(var_value)
		}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return Class_VHttpd_DbGateway_Client.jsonsafeparam(var_value)
		}
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('base64_encode', [rt.new_string((var_value).str()).clone()])
		}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('base64_encode', [rt.new_string((var_value).str()).clone()])
		}
	mut var_request := rt.create_array([rt.ArrayItem{ key: 'version', val: 1 }, rt.ArrayItem{ key: 'mode', val: 'db' }, rt.ArrayItem{ key: 'op', val: op }, rt.ArrayItem{ key: 'pool', val: rt.get_property(rt.new_object('VHttpd_DbGateway_Client', []string{}, &this), 'pool') }, rt.ArrayItem{ key: 'timeout_ms', val: timeoutMs }, rt.ArrayItem{ key: 'session_id', val: sessionId_mutated }, rt.ArrayItem{ key: 'trace_id', val: Class_VHttpd_DbGateway_Client.runtimevalue('VHTTPD_TRACE_ID', 'HTTP_X_VHTTPD_TRACE_ID') }, rt.ArrayItem{ key: 'request_id', val: Class_VHttpd_DbGateway_Client.runtimevalue('VHTTPD_REQUEST_ID', 'HTTP_X_REQUEST_ID') }, rt.ArrayItem{ key: 'sql', val: sql }, rt.ArrayItem{ key: 'params', val: rt.call_function('array_map', [rt.new_closure(closure_3_fn), var_stringParams.clone()]) }, rt.ArrayItem{ key: 'params_base64', val: rt.call_function('array_map', [rt.new_closure(closure_5_fn), var_stringParams.clone()]) }])
	mut var_response := rt.call_method(this.client, 'request', [var_request.clone()])
	if rt.is_true((if !(var_response.array_get(rt.new_string('ok'))).is_null() { var_response.array_get(rt.new_string('ok')) } else { rt.new_bool(false) }).to_bool()) {
		return var_response.clone()
	}
	mut var_error := if !(var_response.array_get(rt.new_string('error'))).is_null() { var_response.array_get(rt.new_string('error')) } else { rt.new_string('db gateway call failed') }
	mut var_message := rt.new_string((if var_error.clone().is_array() { (if !(var_error.array_get(rt.new_string('message'))).is_null() { var_error.array_get(rt.new_string('message')) } else { rt.new_string('db gateway call failed') }).str() } else { (var_error).str() }).str())
	rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception(if rt.is_true(rt.identical(var_message, rt.new_string(''))) { rt.new_string('db gateway call failed') } else { var_message })))
	return rt.new_null()
}

fn Class_VHttpd_DbGateway_Client.runtimevalue(envName string, serverName string) string {
	mut var_serverValue := if !(rt.get_superglobal('_SERVER').array_get(rt.new_string(serverName))).is_null() { rt.get_superglobal('_SERVER').array_get(rt.new_string(serverName)) } else { if !(rt.get_superglobal('_SERVER').array_get(rt.new_string(envName))).is_null() { rt.get_superglobal('_SERVER').array_get(rt.new_string(envName)) } else { rt.new_string('') } }
	if var_serverValue.clone().is_string() && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_serverValue, rt.new_string(''))))) {
		return (var_serverValue).str()
	}
	mut var_envValue := rt.call_function('getenv', [rt.new_string(envName)])
	return (if var_envValue.clone().is_string() { var_envValue } else { rt.new_string('') }).str()
}

fn Class_VHttpd_DbGateway_Client.jsonsafeparam(value string) string {
	return if rt.is_true(rt.identical(rt.call_function('preg_match', [rt.new_string('//u'), rt.new_string(value)]), rt.new_int(1))) { value } else { '' }
}

struct Class_VHttpd_Wire_JsonClient {
	rt.PhpObjectBase
}

struct Class_VHttpd_DbGateway_self {
	rt.PhpObjectBase
}

struct Class_RuntimeException {
	rt.PhpObjectBase
}

fn create_vhttpd_dbgateway_client(socketPath string, pool string, connectTimeoutSeconds f64, readTimeoutSeconds f64) &Class_VHttpd_DbGateway_Client {
	mut obj := &Class_VHttpd_DbGateway_Client{
		PhpObjectBase: rt.PhpObjectBase{}
		client: rt.new_null()
	}
	obj.construct(socketPath, pool, connectTimeoutSeconds, readTimeoutSeconds)
	return obj
}

fn create_vhttpd_wire_jsonclient(_args ...rt.PhpVal) &Class_VHttpd_Wire_JsonClient {
	mut obj := &Class_VHttpd_Wire_JsonClient{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_vhttpd_dbgateway_self(_args ...rt.PhpVal) &Class_VHttpd_DbGateway_self {
	mut obj := &Class_VHttpd_DbGateway_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_runtimeexception(_args ...rt.PhpVal) &Class_RuntimeException {
	mut obj := &Class_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_VHttpd_DbGateway_Client) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_f64()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_f64()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'fromEnv' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			return Class_VHttpd_DbGateway_Client.fromenv(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		'connect' {
			this.connect()
			return rt.new_null()
		}
		'close' {
			this.close()
			return rt.new_null()
		}
		'ping' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.ping(dispatch_arg_0)
		}
		'beginTransaction' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_string(this.begintransaction(dispatch_arg_0))
		}
		'commit' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.commit(dispatch_arg_0, dispatch_arg_1)
		}
		'rollback' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.rollback(dispatch_arg_0, dispatch_arg_1)
		}
		'query' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_VHttpd_DbGateway_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			return this.query(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'execute' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_VHttpd_DbGateway_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			return this.execute(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'escape' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return rt.new_string(this.escape(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'call' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_VHttpd_DbGateway_array](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_i64()
			return this.call(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		'runtimeValue' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(Class_VHttpd_DbGateway_Client.runtimevalue(dispatch_arg_0, dispatch_arg_1))
		}
		'jsonSafeParam' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_VHttpd_DbGateway_Client.jsonsafeparam(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_VHttpd_DbGateway_Client) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'client' { return this.client }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_VHttpd_DbGateway_Client) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'client' { this.client = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_VHttpd_Wire_JsonClient) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_VHttpd_Wire_JsonClient) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_Wire_JsonClient) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_VHttpd_DbGateway_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_VHttpd_DbGateway_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_DbGateway_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
