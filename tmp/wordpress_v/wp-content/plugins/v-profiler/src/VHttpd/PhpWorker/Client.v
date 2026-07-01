import rt

struct Class_VHttpd_PhpWorker_Client {
	rt.PhpObjectBase
pub mut:
	wire rt.PhpVal = rt.new_null()
}

fn (mut this Class_VHttpd_PhpWorker_Client) construct(socketPath string, connectTimeoutSeconds f64, readTimeoutSeconds f64) {
	this.wire = create_vhttpd_wire_jsonclient(rt.new_string(socketPath).dup(),
		rt.new_string('worker'), rt.new_float(connectTimeoutSeconds).dup(),
		rt.new_float(readTimeoutSeconds).dup())
}

fn (mut this Class_VHttpd_PhpWorker_Client) connect() {
	rt.call_method(this.wire, 'connect', []rt.PhpVal{})
}

fn (mut this Class_VHttpd_PhpWorker_Client) close() {
	rt.call_method(this.wire, 'close', []rt.PhpVal{})
}

fn (mut this Class_VHttpd_PhpWorker_Client) request(mut var_request Class_VHttpd_PhpWorker_Request) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_VHttpd_PhpWorker_Response{}
		return temp.fromarray(arg_0)
	}(rt.call_method(this.wire, 'request', [var_request.toarray()]))
}

struct Class_VHttpd_Wire_JsonClient {
	rt.PhpObjectBase
}

struct Class_VHttpd_PhpWorker_Response {
	rt.PhpObjectBase
}

fn create_vhttpd_phpworker_client(socketPath string, connectTimeoutSeconds f64, readTimeoutSeconds f64) &Class_VHttpd_PhpWorker_Client {
	mut obj := &Class_VHttpd_PhpWorker_Client{
		PhpObjectBase: rt.PhpObjectBase{}
		wire:          rt.new_null()
	}
	obj.construct(socketPath, connectTimeoutSeconds, readTimeoutSeconds)
	return obj
}

fn create_vhttpd_wire_jsonclient() &Class_VHttpd_Wire_JsonClient {
	mut obj := &Class_VHttpd_Wire_JsonClient{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_vhttpd_phpworker_response() &Class_VHttpd_PhpWorker_Response {
	mut obj := &Class_VHttpd_PhpWorker_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_VHttpd_PhpWorker_Client) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_f64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_f64()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_PhpWorker_Request](if args.len > 0 {
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

fn (this &Class_VHttpd_PhpWorker_Client) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'wire' { return this.wire }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_VHttpd_PhpWorker_Client) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'wire' {
			this.wire = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_VHttpd_PhpWorker_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_VHttpd_PhpWorker_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_PhpWorker_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_v_profiler_src_vhttpd_phpworker_client_php() {
	// unsupported statement: Stmt_Declare
}
