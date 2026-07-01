import rt

struct Class_VHttpd_PhpWorker_SessionHandler {
	rt.PhpObjectBase
}

fn (mut this Class_VHttpd_PhpWorker_SessionHandler) construct(mut var_client Class_VHttpd_PhpWorker_object, prefix string, ttlSeconds i64) {
}

fn (mut this Class_VHttpd_PhpWorker_SessionHandler) open(path string, name string) bool {
	return true
}

fn (mut this Class_VHttpd_PhpWorker_SessionHandler) close() bool {
	return true
}

fn (mut this Class_VHttpd_PhpWorker_SessionHandler) read(id string) string {
	return (if !(rt.call_method(rt.get_property(rt.new_object('VHttpd_PhpWorker_SessionHandler', [
		'SessionHandlerInterface',
	], &this), 'client'), 'get', [
		(rt.get_property(rt.new_object('VHttpd_PhpWorker_SessionHandler', ['SessionHandlerInterface'], &this), 'prefix')).str() +
		id])).is_null() {
		rt.call_method(rt.get_property(rt.new_object('VHttpd_PhpWorker_SessionHandler', [
			'SessionHandlerInterface',
		], &this), 'client'), 'get', [
			(rt.get_property(rt.new_object('VHttpd_PhpWorker_SessionHandler', ['SessionHandlerInterface'], &this), 'prefix')).str() +
			id])
	} else {
		rt.new_string('')
	}).str()
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'VHttpd_PhpWorker_Throwable') {
		return ''
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	return ''
}

fn (mut this Class_VHttpd_PhpWorker_SessionHandler) write(id string, data string) bool {
	return (rt.call_method(rt.get_property(rt.new_object('VHttpd_PhpWorker_SessionHandler', [
		'SessionHandlerInterface',
	], &this), 'client'), 'set', [
		(rt.get_property(rt.new_object('VHttpd_PhpWorker_SessionHandler', ['SessionHandlerInterface'], &this), 'prefix')).str() +
		id,
		rt.new_string(data),
		rt.mul(rt.get_property(rt.new_object('VHttpd_PhpWorker_SessionHandler', [
			'SessionHandlerInterface',
		], &this), 'ttlSeconds'), rt.new_int(1000))])).to_bool()
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'VHttpd_PhpWorker_Throwable') {
		return false
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
	}

	end_label_2:
	return false
}

fn (mut this Class_VHttpd_PhpWorker_SessionHandler) destroy(id string) bool {
	return (rt.call_method(rt.get_property(rt.new_object('VHttpd_PhpWorker_SessionHandler', [
		'SessionHandlerInterface',
	], &this), 'client'), 'delete', [
		(rt.get_property(rt.new_object('VHttpd_PhpWorker_SessionHandler', ['SessionHandlerInterface'], &this), 'prefix')).str() +
		id])).to_bool()
	unsafe {
		goto end_label_3
	}
	catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'VHttpd_PhpWorker_Throwable') {
		return false
		unsafe {
			goto end_label_3
		}
	} else {
		rt.throw_exception(var_e_3)
		unsafe {
			goto end_label_3
		}
	}

	end_label_3:
	return false
}

fn (mut this Class_VHttpd_PhpWorker_SessionHandler) gc(max_lifetime i64) i64 {
	return 0
}

fn create_vhttpd_phpworker_sessionhandler(arg_0 rt.PhpVal, prefix string, ttlSeconds i64) &Class_VHttpd_PhpWorker_SessionHandler {
	mut obj := &Class_VHttpd_PhpWorker_SessionHandler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(arg_0, prefix, ttlSeconds)
	return obj
}

fn (mut this Class_VHttpd_PhpWorker_SessionHandler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_PhpWorker_object](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			this.construct(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'open' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.open(dispatch_arg_0, dispatch_arg_1))
		}
		'close' {
			return rt.new_bool(this.close())
		}
		'read' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.read(dispatch_arg_0))
		}
		'write' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.write(dispatch_arg_0, dispatch_arg_1))
		}
		'destroy' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.destroy(dispatch_arg_0))
		}
		'gc' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_int(this.gc(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_VHttpd_PhpWorker_SessionHandler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_PhpWorker_SessionHandler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_v_profiler_src_vhttpd_phpworker_sessionhandler_php() {
	// unsupported statement: Stmt_Declare
}
