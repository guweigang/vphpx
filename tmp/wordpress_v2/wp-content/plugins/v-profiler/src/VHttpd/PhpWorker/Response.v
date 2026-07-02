import rt

struct Class_VHttpd_PhpWorker_Response {
	rt.PhpObjectBase
}

fn (mut this Class_VHttpd_PhpWorker_Response) construct(id string, status i64, mut var_headers Class_VHttpd_PhpWorker_array, body string) {
	mut var_headers_mutated := var_headers
}

fn Class_VHttpd_PhpWorker_Response.fromarray(mut var_payload Class_VHttpd_PhpWorker_array) rt.PhpVal {
	return rt.new_object('VHttpd_PhpWorker_self', []string{}, create_vhttpd_phpworker_self((if !(var_payload.array_get(rt.new_string('id'))).is_null() {
		var_payload.array_get(rt.new_string('id'))
	} else {
		rt.new_string('')
	}).str(), rt.new_int((if !(var_payload.array_get(rt.new_string('status'))).is_null() {
		var_payload.array_get(rt.new_string('status'))
	} else {
		rt.new_int(200)
	}).to_i64()), Class_VHttpd_PhpWorker_Response.normalizeheaders(mut rt.cast_object_ptr[Class_VHttpd_PhpWorker_mixed](if !(var_payload.array_get(rt.new_string('headers'))).is_null() {
		var_payload.array_get(rt.new_string('headers'))
	} else {
		rt.new_array()
	})), (if !(var_payload.array_get(rt.new_string('body'))).is_null() {
		var_payload.array_get(rt.new_string('body'))
	} else {
		rt.new_string('')
	}).str()))
}

fn Class_VHttpd_PhpWorker_Response.text(body string, status i64, mut var_headers Class_VHttpd_PhpWorker_array, id string) rt.PhpVal {
	mut var_headers_mutated := var_headers
	if !(var_headers_mutated.array_isset(rt.new_string('content-type'))) {
		var_headers_mutated.array_set('content-type', 'text/plain; charset=utf-8')
	}
	return rt.new_object('VHttpd_PhpWorker_self', []string{}, create_vhttpd_phpworker_self(rt.new_string(id),
		rt.new_int(status), var_headers_mutated, rt.new_string(body)))
}

fn Class_VHttpd_PhpWorker_Response.html(body string, status i64, mut var_headers Class_VHttpd_PhpWorker_array, id string) rt.PhpVal {
	mut var_headers_mutated := var_headers
	if !(var_headers_mutated.array_isset(rt.new_string('content-type'))) {
		var_headers_mutated.array_set('content-type', 'text/html; charset=utf-8')
	}
	return rt.new_object('VHttpd_PhpWorker_self', []string{}, create_vhttpd_phpworker_self(rt.new_string(id),
		rt.new_int(status), var_headers_mutated, rt.new_string(body)))
}

fn Class_VHttpd_PhpWorker_Response.json(mut var_data Class_VHttpd_PhpWorker_array, status i64, mut var_headers Class_VHttpd_PhpWorker_array, id string) rt.PhpVal {
	mut var_headers_mutated := var_headers
	if !(var_headers_mutated.array_isset(rt.new_string('content-type'))) {
		var_headers_mutated.array_set('content-type', 'application/json; charset=utf-8')
	}
	return rt.new_object('VHttpd_PhpWorker_self', []string{}, create_vhttpd_phpworker_self(rt.new_string(id),
		rt.new_int(status), var_headers_mutated, rt.new_string(rt.json_encode(var_data))))
}

fn (mut this Class_VHttpd_PhpWorker_Response) toarray() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.get_property(rt.new_object('VHttpd_PhpWorker_Response',
			[]string{}, &this), 'id') },
		rt.ArrayItem{ key: 'status', val: rt.get_property(rt.new_object('VHttpd_PhpWorker_Response',
			[]string{}, &this), 'status') },
		rt.ArrayItem{ key: 'headers', val: Class_VHttpd_PhpWorker_Response.normalizeheaders(mut rt.cast_object_ptr[Class_VHttpd_PhpWorker_mixed](rt.get_property(rt.new_object('VHttpd_PhpWorker_Response',
			[]string{}, &this), 'headers'))) },
		rt.ArrayItem{ key: 'body', val: rt.get_property(rt.new_object('VHttpd_PhpWorker_Response',
			[]string{}, &this), 'body') },
	])
}

fn Class_VHttpd_PhpWorker_Response.normalizeheaders(mut var_headers Class_VHttpd_PhpWorker_mixed) rt.PhpVal {
	mut var_headers_mutated := var_headers
	if !(var_headers_mutated.is_array()) {
		return rt.new_array()
	}
	mut var_out := rt.new_array()
	mut iter_1 := var_headers_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_name := item_1.key
		if !(var_name.clone().is_string()) && !(var_name.clone().is_long()) {
			continue
		}
		var_out.array_set(var_name.str().to_lower(), if var_value.clone().is_array() { rt.call_function('implode', [
				rt.new_string(', '),
				rt.call_function('array_map', [rt.new_string('strval'),
					var_value.clone()]),
			]) } else { var_value.str() })
	}
	return var_out.clone()
}

struct Class_VHttpd_PhpWorker_self {
	rt.PhpObjectBase
}

fn create_vhttpd_phpworker_response(id string, status i64, arg_2 rt.PhpVal, body string) &Class_VHttpd_PhpWorker_Response {
	mut obj := &Class_VHttpd_PhpWorker_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(id, status, arg_2, body)
	return obj
}

fn create_vhttpd_phpworker_self(_args ...rt.PhpVal) &Class_VHttpd_PhpWorker_self {
	mut obj := &Class_VHttpd_PhpWorker_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_VHttpd_PhpWorker_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_VHttpd_PhpWorker_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'fromArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_PhpWorker_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_VHttpd_PhpWorker_Response.fromarray(mut dispatch_arg_0)
		}
		'text' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_VHttpd_PhpWorker_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return Class_VHttpd_PhpWorker_Response.text(dispatch_arg_0, dispatch_arg_1, mut
				dispatch_arg_2, dispatch_arg_3)
		}
		'html' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_VHttpd_PhpWorker_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return Class_VHttpd_PhpWorker_Response.html(dispatch_arg_0, dispatch_arg_1, mut
				dispatch_arg_2, dispatch_arg_3)
		}
		'json' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_PhpWorker_array](if args.len > 0 {
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
			return Class_VHttpd_PhpWorker_Response.json(mut dispatch_arg_0, dispatch_arg_1, mut
				dispatch_arg_2, dispatch_arg_3)
		}
		'toArray' {
			return this.toarray()
		}
		'normalizeHeaders' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_PhpWorker_mixed](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_VHttpd_PhpWorker_Response.normalizeheaders(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_VHttpd_PhpWorker_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_PhpWorker_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
