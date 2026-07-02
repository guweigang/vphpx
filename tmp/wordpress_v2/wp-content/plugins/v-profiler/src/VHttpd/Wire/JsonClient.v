import rt

struct Class_VHttpd_Wire_JsonClient {
	rt.PhpObjectBase
pub mut:
	conn rt.PhpVal = rt.new_null()
}

fn (mut this Class_VHttpd_Wire_JsonClient) construct(socketPath string, errorPrefix string, connectTimeoutSeconds f64, readTimeoutSeconds f64) {
}

fn (mut this Class_VHttpd_Wire_JsonClient) magic_destruct() {
	this.close()
}

fn (mut this Class_VHttpd_Wire_JsonClient) connect() {
	if rt.is_true(rt.call_function('is_resource', [this.conn])) {
		return
	}
	mut var_errno := rt.new_int(0)
	mut var_errstr := rt.new_string('')
	mut var_conn := rt.call_function('stream_socket_client', [
		rt.new_string('unix://' +(rt.get_property(rt.new_object('VHttpd_Wire_JsonClient', []string{}, &this), 'socketPath')).str()),
		var_errno.clone(),
		var_errstr.clone(),
		rt.get_property(rt.new_object('VHttpd_Wire_JsonClient', []string{}, &this),
			'connectTimeoutSeconds'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [
		var_conn.clone()])))))
	{
		rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.get_property(rt.new_object('VHttpd_Wire_JsonClient',
			[]string{}, &this), 'errorPrefix'), rt.new_string('_connect_failed: ')), var_errstr),
			rt.new_string(' (')), var_errno), rt.new_string(')')))))
	}
	rt.call_function('stream_set_blocking', [var_conn.clone(),
		rt.new_bool(true)])
	rt.call_function('stream_set_timeout', [var_conn.clone(),
		rt.new_int((rt.call_function('floor', [
			rt.get_property(rt.new_object('VHttpd_Wire_JsonClient', []string{}, &this),
				'readTimeoutSeconds'),
		])).to_i64()),
		rt.new_int((rt.mul(rt.sub(rt.get_property(rt.new_object('VHttpd_Wire_JsonClient',
			[]string{}, &this), 'readTimeoutSeconds'), rt.call_function('floor', [
			rt.get_property(rt.new_object('VHttpd_Wire_JsonClient', []string{}, &this),
				'readTimeoutSeconds'),
		])), rt.new_int(1000000))).to_i64())])
	this.conn = var_conn.clone()
}

fn (mut this Class_VHttpd_Wire_JsonClient) close() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [this.conn]))))) {
		return
	}
	rt.call_function('fclose', [this.conn])
	this.conn = rt.new_null()
}

fn (mut this Class_VHttpd_Wire_JsonClient) request(mut var_request Class_VHttpd_Wire_array) rt.PhpVal {
	this.connect()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [this.conn]))))) {
		rt.throw_exception(rt.new_object('RuntimeException', []string{},
			create_runtimeexception(rt.new_string('connection_not_open'))))
	}
	mut var_json := rt.new_string(rt.json_encode(var_request))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if !(var_json.clone().is_string()) {
		rt.throw_exception(rt.new_object('RuntimeException', []string{},
			create_runtimeexception(rt.new_string('json_encode_failed'))))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut iife_temp_0 := Class_VHttpd_Wire_FrameCodec{}
	mut iife_result_0 := iife_temp_0.write(this.conn, var_json.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut iife_temp_1 := Class_VHttpd_Wire_FrameCodec{}
	mut iife_result_1 := iife_temp_1.read(this.conn)
	mut var_raw := iife_result_1
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.identical(var_raw, rt.new_string(''))) {
		rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception(rt.concat(rt.get_property(rt.new_object('VHttpd_Wire_JsonClient',
			[]string{}, &this), 'errorPrefix'), rt.new_string('_empty_response')))))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_response := rt.call_function('json_decode', [var_raw.clone(),
		rt.new_bool(true)])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if !(var_response.clone().is_array()) {
		rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception(rt.concat(rt.get_property(rt.new_object('VHttpd_Wire_JsonClient',
			[]string{}, &this), 'errorPrefix'), rt.new_string('_invalid_response_json')))))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	return var_response.clone()
	unsafe {
		goto finally_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()

	finally_label_1:
	this.close()
	if rt.has_exception() { return rt.new_null() }

	end_label_1:
	return rt.new_null()
}

struct Class_RuntimeException {
	rt.PhpObjectBase
}

struct Class_VHttpd_Wire_FrameCodec {
	rt.PhpObjectBase
}

fn create_vhttpd_wire_jsonclient(socketPath string, errorPrefix string, connectTimeoutSeconds f64, readTimeoutSeconds f64) &Class_VHttpd_Wire_JsonClient {
	mut obj := &Class_VHttpd_Wire_JsonClient{
		PhpObjectBase: rt.PhpObjectBase{}
		conn:          rt.new_null()
	}
	obj.construct(socketPath, errorPrefix, connectTimeoutSeconds, readTimeoutSeconds)
	return obj
}

fn create_runtimeexception(_args ...rt.PhpVal) &Class_RuntimeException {
	mut obj := &Class_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_vhttpd_wire_framecodec(_args ...rt.PhpVal) &Class_VHttpd_Wire_FrameCodec {
	mut obj := &Class_VHttpd_Wire_FrameCodec{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_VHttpd_Wire_JsonClient) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_f64()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_f64()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'__destruct' {
			this.magic_destruct()
			return rt.new_null()
		}
		'connect' {
			this.connect()
			return rt.new_null()
		}
		'close' {
			this.close()
			return rt.new_null()
		}
		'request' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_Wire_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.request(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_VHttpd_Wire_JsonClient) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'conn' { return this.conn }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_VHttpd_Wire_JsonClient) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'conn' {
			this.conn = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_VHttpd_Wire_FrameCodec) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_VHttpd_Wire_FrameCodec) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_Wire_FrameCodec) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
