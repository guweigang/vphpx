import rt

struct Class_VHttpd_PhpWorker_Request {
	rt.PhpObjectBase
}

fn (mut this Class_VHttpd_PhpWorker_Request) construct(id string, method string, path string, mut var_query Class_VHttpd_PhpWorker_array, mut var_headers Class_VHttpd_PhpWorker_array, body string) {
}

fn Class_VHttpd_PhpWorker_Request.fromarray(mut var_payload Class_VHttpd_PhpWorker_array) rt.PhpVal {
	return rt.new_object('VHttpd_PhpWorker_self', []string{}, create_vhttpd_phpworker_self((if !(var_payload.array_get(rt.new_string('id'))).is_null() {
		var_payload.array_get(rt.new_string('id'))
	} else {
		rt.new_string('')
	}).str(), rt.new_string((if !(var_payload.array_get(rt.new_string('method'))).is_null() {
		var_payload.array_get(rt.new_string('method'))
	} else {
		rt.new_string('GET')
	}).str().to_upper()), (if !(var_payload.array_get(rt.new_string('path'))).is_null() {
		var_payload.array_get(rt.new_string('path'))
	} else {
		rt.new_string('/')
	}).str(), Class_VHttpd_PhpWorker_Request.stringmap(mut rt.cast_object_ptr[Class_VHttpd_PhpWorker_mixed](if !(var_payload.array_get(rt.new_string('query'))).is_null() {
		var_payload.array_get(rt.new_string('query'))
	} else {
		rt.new_array()
	})), Class_VHttpd_PhpWorker_Request.stringmap(mut rt.cast_object_ptr[Class_VHttpd_PhpWorker_mixed](if !(var_payload.array_get(rt.new_string('headers'))).is_null() {
		var_payload.array_get(rt.new_string('headers'))
	} else {
		rt.new_array()
	})), (if !(var_payload.array_get(rt.new_string('body'))).is_null() {
		var_payload.array_get(rt.new_string('body'))
	} else {
		rt.new_string('')
	}).str()))
}

fn Class_VHttpd_PhpWorker_Request.http(method string, path string, mut var_query Class_VHttpd_PhpWorker_array, mut var_headers Class_VHttpd_PhpWorker_array, body string, id string) rt.PhpVal {
	return rt.new_object('VHttpd_PhpWorker_self', []string{}, create_vhttpd_phpworker_self(rt.new_string(id),
		rt.new_string(method.to_upper()), rt.new_string(path), var_query, var_headers,
		rt.new_string(body)))
}

fn (mut this Class_VHttpd_PhpWorker_Request) toarray() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.get_property(rt.new_object('VHttpd_PhpWorker_Request',
			[]string{}, &this), 'id') },
		rt.ArrayItem{ key: 'method', val: rt.get_property(rt.new_object('VHttpd_PhpWorker_Request',
			[]string{}, &this), 'method') },
		rt.ArrayItem{ key: 'path', val: rt.get_property(rt.new_object('VHttpd_PhpWorker_Request',
			[]string{}, &this), 'path') },
		rt.ArrayItem{ key: 'query', val: rt.get_property(rt.new_object('VHttpd_PhpWorker_Request',
			[]string{}, &this), 'query') },
		rt.ArrayItem{ key: 'headers', val: rt.get_property(rt.new_object('VHttpd_PhpWorker_Request',
			[]string{}, &this), 'headers') },
		rt.ArrayItem{ key: 'body', val: rt.get_property(rt.new_object('VHttpd_PhpWorker_Request',
			[]string{}, &this), 'body') },
	])
}

fn Class_VHttpd_PhpWorker_Request.stringmap(mut var_value Class_VHttpd_PhpWorker_mixed) rt.PhpVal {
	if !(var_value.is_array()) {
		return rt.new_array()
	}
	mut var_out := rt.new_array()
	mut iter_1 := var_value.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_item := item_1.val
		mut var_key := item_1.key
		if !(var_key.clone().is_string()) && !(var_key.clone().is_long()) {
			continue
		}
		var_out.array_set(var_key.str(), if var_item.clone().is_array() { rt.call_function('implode', [
				rt.new_string(', '),
				rt.call_function('array_map', [rt.new_string('strval'),
					var_item.clone()]),
			]) } else { var_item.str() })
	}
	return var_out.clone()
}

struct Class_VHttpd_PhpWorker_self {
	rt.PhpObjectBase
}

fn create_vhttpd_phpworker_request(id string, method string, path string, arg_3 rt.PhpVal, arg_4 rt.PhpVal, body string) &Class_VHttpd_PhpWorker_Request {
	mut obj := &Class_VHttpd_PhpWorker_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(id, method, path, arg_3, arg_4, body)
	return obj
}

fn create_vhttpd_phpworker_self(_args ...rt.PhpVal) &Class_VHttpd_PhpWorker_self {
	mut obj := &Class_VHttpd_PhpWorker_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_VHttpd_PhpWorker_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_VHttpd_PhpWorker_array](if args.len > 3 {
				args[3]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_VHttpd_PhpWorker_array](if args.len > 4 {
				args[4]
			} else {
				rt.new_null()
			})
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3, mut
				dispatch_arg_4, dispatch_arg_5)
			return rt.new_null()
		}
		'fromArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_PhpWorker_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_VHttpd_PhpWorker_Request.fromarray(mut dispatch_arg_0)
		}
		'http' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_VHttpd_PhpWorker_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_VHttpd_PhpWorker_array](if args.len > 3 {
				args[3]
			} else {
				rt.new_null()
			})
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
			return Class_VHttpd_PhpWorker_Request.http(dispatch_arg_0, dispatch_arg_1, mut
				dispatch_arg_2, mut dispatch_arg_3, dispatch_arg_4, dispatch_arg_5)
		}
		'toArray' {
			return this.toarray()
		}
		'stringMap' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_PhpWorker_mixed](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_VHttpd_PhpWorker_Request.stringmap(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_VHttpd_PhpWorker_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_PhpWorker_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
