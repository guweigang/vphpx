import rt

struct Class_IXR_ClientMulticall {
	rt.PhpObjectBase
pub mut:
	calls rt.PhpVal = rt.new_array()
}

fn (mut this Class_IXR_ClientMulticall) construct(var_server rt.PhpVal, path bool, port i64) {
	this.Class_IXR_Client.ixr_client(var_server.clone(), rt.new_bool(path), rt.new_int(port))
	this.dispatch_set_prop('useragent',
		rt.new_string('The Incutio XML-RPC PHP Library (multicall client)'))
}

fn (mut this Class_IXR_ClientMulticall) ixr_clientmulticall(var_server rt.PhpVal, path bool, port i64) {
	mut iife_temp_0 := Class_IXR_ClientMulticall{}
	iife_temp_0.construct(var_server.to_bool(), path, rt.new_int(port))
	rt.new_null()
}

fn (mut this Class_IXR_ClientMulticall) addcall(var_args rt.PhpVal) {
	mut var_methodName := rt.call_function('array_shift', [var_args.clone()])
	mut var_struct := {
		'methodName': var_methodName
		'params':     var_args
	}
	this.calls.array_push(var_struct.clone())
}

fn (mut this Class_IXR_ClientMulticall) query(var_args rt.PhpVal) rt.PhpVal {
	return this.Class_IXR_Client.query(rt.new_string('system.multicall'), this.calls)
}

struct Class_IXR_Client {
	rt.PhpObjectBase
}

fn create_ixr_clientmulticall(path bool, port i64, arg_2 rt.PhpVal) &Class_IXR_ClientMulticall {
	mut obj := &Class_IXR_ClientMulticall{
		PhpObjectBase: rt.PhpObjectBase{}
		calls:         rt.new_array()
	}
	obj.construct(path, port, arg_2)
	return obj
}

fn create_ixr_client(_args ...rt.PhpVal) &Class_IXR_Client {
	mut obj := &Class_IXR_Client{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_IXR_ClientMulticall) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'IXR_ClientMulticall' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			this.ixr_clientmulticall(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'addCall' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.addcall(dispatch_arg_0)
			return rt.new_null()
		}
		'query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.query(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_IXR_ClientMulticall) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'calls' { return this.calls }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_IXR_ClientMulticall) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'calls' {
			this.calls = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_IXR_Client) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_IXR_Client) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_IXR_Client) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
