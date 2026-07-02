import rt

struct Class_VHttpd_Cache_Client {
	rt.PhpObjectBase
pub mut:
		client rt.PhpVal = rt.new_null()
}

fn (mut this Class_VHttpd_Cache_Client) construct(socketPath string, namespace string, connectTimeoutSeconds f64, readTimeoutSeconds f64) {
	mut namespace_mutated := namespace
	this.client = create_vhttpd_wire_jsonclient(rt.get_property(rt.new_object('VHttpd_Cache_Client', []string{}, &this), 'socketPath'), rt.new_string('cache_gateway'), rt.get_property(rt.new_object('VHttpd_Cache_Client', []string{}, &this), 'connectTimeoutSeconds'), rt.get_property(rt.new_object('VHttpd_Cache_Client', []string{}, &this), 'readTimeoutSeconds'))
}

fn Class_VHttpd_Cache_Client.fromenv(socketEnv string, namespaceEnv string, defaultSocket string, defaultNamespace string) rt.PhpVal {
	mut var_socket := rt.call_function('getenv', [rt.new_string(socketEnv)])
	if !(var_socket.clone().is_string()) || rt.is_true(rt.identical(var_socket, rt.new_string(''))) {
	var_socket = if !(rt.get_superglobal('_SERVER').array_get(rt.new_string(socketEnv))).is_null() { rt.get_superglobal('_SERVER').array_get(rt.new_string(socketEnv)) } else { rt.new_string('') }
	}
	mut var_namespace := rt.call_function('getenv', [rt.new_string(namespaceEnv)])
	if !(var_namespace.clone().is_string()) || rt.is_true(rt.identical(var_namespace, rt.new_string(''))) {
	var_namespace = if !(rt.get_superglobal('_SERVER').array_get(rt.new_string(namespaceEnv))).is_null() { rt.get_superglobal('_SERVER').array_get(rt.new_string(namespaceEnv)) } else { rt.new_string('') }
	}
	return rt.new_object('VHttpd_Cache_self', []string{}, create_vhttpd_cache_self(if var_socket.clone().is_string() && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_socket, rt.new_string(''))))) { var_socket } else { rt.new_string(defaultSocket) }, if var_namespace.clone().is_string() && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_namespace, rt.new_string(''))))) { var_namespace } else { rt.new_string(defaultNamespace) }))
}

fn (mut this Class_VHttpd_Cache_Client) ping() bool {
	mut var_response := this.call('ping', '', rt.new_null(), false)
	return (if !(var_response.array_get(rt.new_string('pong'))).is_null() { var_response.array_get(rt.new_string('pong')) } else { rt.new_bool(false) }).to_bool()
}

fn (mut this Class_VHttpd_Cache_Client) get(key string, mut var_default Class_VHttpd_Cache_?string) string {
	mut var_response := this.call('get', key, rt.new_null(), false)
	if rt.is_true(rt.new_bool(!(rt.is_true((if !(var_response.array_get(rt.new_string('found'))).is_null() { var_response.array_get(rt.new_string('found')) } else { rt.new_bool(false) }).to_bool())))) {
		return var_default
	}
	return (if !(var_response.array_get(rt.new_string('value'))).is_null() { var_response.array_get(rt.new_string('value')) } else { rt.new_string('') }).str()
}

fn (mut this Class_VHttpd_Cache_Client) set(key string, value string, ttlMs i64) bool {
	mut value_mutated := value
	this.call('set', key, mut rt.cast_object_ptr[Class_VHttpd_Cache_array](rt.create_array([rt.ArrayItem{ key: 'value', val: value_mutated }, rt.ArrayItem{ key: 'ttl_ms', val: rt.call_function('max', [rt.new_int(0), rt.new_int(ttlMs)]) }])), false)
	return true
}

fn (mut this Class_VHttpd_Cache_Client) delete(key string) bool {
	this.call('delete', key, rt.new_null(), false)
	return true
}

fn (mut this Class_VHttpd_Cache_Client) exists(key string) bool {
	mut var_response := this.call('exists', key, rt.new_null(), false)
	return (if !(var_response.array_get(rt.new_string('found'))).is_null() { var_response.array_get(rt.new_string('found')) } else { rt.new_bool(false) }).to_bool()
}

fn (mut this Class_VHttpd_Cache_Client) keys() rt.PhpVal {
	mut var_response := this.call('keys', '', rt.new_null(), false)
	mut var_keys := if !(var_response.array_get(rt.new_string('keys'))).is_null() { var_response.array_get(rt.new_string('keys')) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(var_keys.clone().is_array())) {
		return rt.call_function('array_values', [rt.call_function('array_filter', [var_keys.clone(), rt.new_string('is_string')])])
	}
	mut var_raw := rt.new_string((if !(var_response.array_get(rt.new_string('value'))).is_null() { var_response.array_get(rt.new_string('value')) } else { rt.new_string('[]') }).str())
	mut var_decoded := rt.call_function('json_decode', [var_raw.clone(), rt.new_bool(true)])
	if !(var_decoded.clone().is_array()) {
		return rt.new_array()
	}
	return rt.call_function('array_values', [rt.call_function('array_filter', [var_decoded.clone(), rt.new_string('is_string')])])
}

fn (mut this Class_VHttpd_Cache_Client) compareandswapset(key string, expectedFound bool, expectedValue string, value string, ttlMs i64) bool {
	mut value_mutated := value
	mut var_response := this.call('patch', key, mut rt.cast_object_ptr[Class_VHttpd_Cache_array](rt.create_array([rt.ArrayItem{ key: 'expected_found', val: expectedFound }, rt.ArrayItem{ key: 'expected_value', val: expectedValue }, rt.ArrayItem{ key: 'value', val: value_mutated }, rt.ArrayItem{ key: 'ttl_ms', val: rt.call_function('max', [rt.new_int(0), rt.new_int(ttlMs)]) }])), false)
	return rt.is_true((if !(var_response.array_get(rt.new_string('ok'))).is_null() { var_response.array_get(rt.new_string('ok')) } else { rt.new_bool(false) }).to_bool()) && rt.is_true(rt.new_bool(!(rt.is_true((if !(var_response.array_get(rt.new_string('conflict'))).is_null() { var_response.array_get(rt.new_string('conflict')) } else { rt.new_bool(false) }).to_bool()))))
}

fn (mut this Class_VHttpd_Cache_Client) compareandswapdelete(key string, expectedFound bool, expectedValue string) bool {
	mut var_response := this.call('patch', key, mut rt.cast_object_ptr[Class_VHttpd_Cache_array](rt.create_array([rt.ArrayItem{ key: 'expected_found', val: expectedFound }, rt.ArrayItem{ key: 'expected_value', val: expectedValue }, rt.ArrayItem{ key: 'delete_value', val: true }])), false)
	return rt.is_true((if !(var_response.array_get(rt.new_string('ok'))).is_null() { var_response.array_get(rt.new_string('ok')) } else { rt.new_bool(false) }).to_bool()) && rt.is_true(rt.new_bool(!(rt.is_true((if !(var_response.array_get(rt.new_string('conflict'))).is_null() { var_response.array_get(rt.new_string('conflict')) } else { rt.new_bool(false) }).to_bool()))))
}

fn (mut this Class_VHttpd_Cache_Client) remember(key string, ttlMs i64, mut var_loader Class_VHttpd_Cache_callable) string {
	mut var_cached := rt.new_string(this.get(key, rt.new_null()))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_cached, rt.new_null())))) {
		return (var_cached).str()
	}
	mut var_value := rt.new_string((rt.call_callable(var_loader, []rt.PhpVal{})).str())
	this.set(key, (var_value).str(), ttlMs)
	return (var_value).str()
}

fn (mut this Class_VHttpd_Cache_Client) call(op string, key string, mut var_extra Class_VHttpd_Cache_array, throwOnConflict bool) rt.PhpVal {
	mut var_request := rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'version', val: 1 }, rt.ArrayItem{ key: 'mode', val: 'cache' }, rt.ArrayItem{ key: 'op', val: op }, rt.ArrayItem{ key: 'namespace', val: rt.get_property(rt.new_object('VHttpd_Cache_Client', []string{}, &this), 'namespace') }, rt.ArrayItem{ key: 'key', val: key }]), var_extra])
	mut var_response := rt.call_method(this.client, 'request', [var_request.clone()])
	if rt.is_true((if !(var_response.array_get(rt.new_string('ok'))).is_null() { var_response.array_get(rt.new_string('ok')) } else { rt.new_bool(false) }).to_bool()) {
		return var_response.clone()
	}
	if !(var_throwOnConflict) && rt.is_true((if !(var_response.array_get(rt.new_string('conflict'))).is_null() { var_response.array_get(rt.new_string('conflict')) } else { rt.new_bool(false) }).to_bool()) {
		return var_response.clone()
	}
	mut var_error := rt.new_string((if !(var_response.array_get(rt.new_string('error'))).is_null() { var_response.array_get(rt.new_string('error')) } else { rt.new_string('cache gateway call failed') }).str())
	rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception(if rt.is_true(rt.identical(var_error, rt.new_string(''))) { rt.new_string('cache gateway call failed') } else { var_error })))
	return rt.new_null()
}

struct Class_VHttpd_Wire_JsonClient {
	rt.PhpObjectBase
}

struct Class_VHttpd_Cache_self {
	rt.PhpObjectBase
}

struct Class_RuntimeException {
	rt.PhpObjectBase
}

fn create_vhttpd_cache_client(socketPath string, namespace string, connectTimeoutSeconds f64, readTimeoutSeconds f64) &Class_VHttpd_Cache_Client {
	mut obj := &Class_VHttpd_Cache_Client{
		PhpObjectBase: rt.PhpObjectBase{}
		client: rt.new_null()
	}
	obj.construct(socketPath, namespace, connectTimeoutSeconds, readTimeoutSeconds)
	return obj
}

fn create_vhttpd_wire_jsonclient(_args ...rt.PhpVal) &Class_VHttpd_Wire_JsonClient {
	mut obj := &Class_VHttpd_Wire_JsonClient{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_vhttpd_cache_self(_args ...rt.PhpVal) &Class_VHttpd_Cache_self {
	mut obj := &Class_VHttpd_Cache_self{
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

fn (mut this Class_VHttpd_Cache_Client) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
			return Class_VHttpd_Cache_Client.fromenv(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'ping' {
			return rt.new_bool(this.ping())
		}
		'get' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_VHttpd_Cache_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(this.get(dispatch_arg_0, mut dispatch_arg_1))
		}
		'set' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.set(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'delete' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.delete(dispatch_arg_0))
		}
		'exists' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.exists(dispatch_arg_0))
		}
		'keys' {
			return this.keys()
		}
		'compareAndSwapSet' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.compareandswapset(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
		}
		'compareAndSwapDelete' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_bool(this.compareandswapdelete(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'remember' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_VHttpd_Cache_callable](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_string(this.remember(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2))
		}
		'call' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_VHttpd_Cache_array](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return this.call(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3)
		}
		else { return none }
	}
}

fn (this &Class_VHttpd_Cache_Client) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'client' { return this.client }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_VHttpd_Cache_Client) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_VHttpd_Cache_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_VHttpd_Cache_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_Cache_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn init_registry() {
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

}
