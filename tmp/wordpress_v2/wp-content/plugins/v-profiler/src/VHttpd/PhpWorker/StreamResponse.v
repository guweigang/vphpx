import rt

struct Class_VHttpd_PhpWorker_StreamResponse {
	rt.PhpObjectBase
}

fn (mut this Class_VHttpd_PhpWorker_StreamResponse) construct(mut var_chunks Class_VHttpd_PhpWorker_iterable, status i64, mut var_headers Class_VHttpd_PhpWorker_array, streamType string, contentType string) {
}

fn Class_VHttpd_PhpWorker_StreamResponse.text(mut var_chunks Class_VHttpd_PhpWorker_iterable, status i64, contentType string, mut var_headers Class_VHttpd_PhpWorker_array) rt.PhpVal {
	return rt.new_object('VHttpd_PhpWorker_self', []string{}, create_vhttpd_phpworker_self(var_chunks,
		rt.new_int(status), var_headers, rt.new_string('text'), rt.new_string(contentType)))
}

fn Class_VHttpd_PhpWorker_StreamResponse.sse(mut var_events Class_VHttpd_PhpWorker_iterable, status i64, mut var_headers Class_VHttpd_PhpWorker_array) rt.PhpVal {
	return rt.new_object('VHttpd_PhpWorker_self', []string{}, create_vhttpd_phpworker_self(var_events,
		rt.new_int(status), var_headers, rt.new_string('sse'), rt.new_string('text/event-stream')))
}

struct Class_VHttpd_PhpWorker_self {
	rt.PhpObjectBase
}

fn create_vhttpd_phpworker_streamresponse(arg_0 rt.PhpVal, status i64, arg_2 rt.PhpVal, streamType string, contentType string) &Class_VHttpd_PhpWorker_StreamResponse {
	mut obj := &Class_VHttpd_PhpWorker_StreamResponse{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(arg_0, status, arg_2, streamType, contentType)
	return obj
}

fn create_vhttpd_phpworker_self(_args ...rt.PhpVal) &Class_VHttpd_PhpWorker_self {
	mut obj := &Class_VHttpd_PhpWorker_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_VHttpd_PhpWorker_StreamResponse) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_PhpWorker_iterable](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_VHttpd_PhpWorker_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			this.construct(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3,
				dispatch_arg_4)
			return rt.new_null()
		}
		'text' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_PhpWorker_iterable](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_VHttpd_PhpWorker_array](if args.len > 3 {
				args[3]
			} else {
				rt.new_null()
			})
			return Class_VHttpd_PhpWorker_StreamResponse.text(mut dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, mut dispatch_arg_3)
		}
		'sse' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_PhpWorker_iterable](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_VHttpd_PhpWorker_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return Class_VHttpd_PhpWorker_StreamResponse.sse(mut dispatch_arg_0, dispatch_arg_1, mut
				dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_VHttpd_PhpWorker_StreamResponse) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_PhpWorker_StreamResponse) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_VHttpd_PhpWorker_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_VHttpd_PhpWorker_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_PhpWorker_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
