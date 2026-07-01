import rt

struct Class_VHttpd_Wire_FrameCodec {
	rt.PhpObjectBase
}

fn Class_VHttpd_Wire_FrameCodec.read(var_conn rt.PhpVal, maxBytes i64) string {
	mut var_header := Class_VHttpd_Wire_FrameCodec.readexact((var_conn).to_i64(), rt.new_int(4))
	mut var_unpacked := rt.call_function('unpack', [rt.new_string('Nsize'), var_header.dup()])
	mut var_size := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(rt.is_true(rt.less_equal(var_size, rt.new_int(0))) || rt.is_true(rt.greater(var_size, rt.new_int(maxBytes))))) {
		rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception('invalid frame size: ' + (var_size).str())))
	}
	return (Class_VHttpd_Wire_FrameCodec.readexact((var_conn).to_i64(), var_size.dup())).str()
}

fn Class_VHttpd_Wire_FrameCodec.write(var_conn rt.PhpVal, payload string)  {
	mut var_data := rt.new_string((rt.call_function('pack', [rt.new_string('N'), rt.new_int(payload.len)])).str() + payload)
	mut var_written := rt.new_int(rt.new_int(0))
	mut var_size := rt.new_int(rt.new_int(var_data.dup().to_string().len))
	for rt.is_true(rt.less(var_written, var_size)) {
		mut var_n := rt.call_function('fwrite', [var_conn.dup(), rt.call_function('substr', [var_data.dup(), var_written.dup()])])
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_n, rt.new_bool(false))) || rt.is_true(rt.identical(var_n, rt.new_int(0))))) {
			rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception(rt.new_string('failed to write frame'))))
		}
		// unsupported expression: Expr_AssignOp_Plus
	}
}

fn Class_VHttpd_Wire_FrameCodec.readexact(var_conn rt.PhpVal, size i64) string {
	mut size_mutated := size
	mut var_buf := rt.new_string(rt.new_string(''))
	for var_buf.dup().to_string().len < size_mutated {
		mut var_chunk := rt.call_function('fread', [var_conn.dup(), size_mutated - var_buf.dup().to_string().len])
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_chunk, rt.new_bool(false))) || rt.is_true(rt.identical(var_chunk, rt.new_string(''))))) {
			rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception(rt.new_string('unexpected EOF while reading frame'))))
		}
		// unsupported expression: Expr_AssignOp_Concat
	}
	return (var_buf).str()
}

struct Class_RuntimeException {
	rt.PhpObjectBase
}

fn create_vhttpd_wire_framecodec() &Class_VHttpd_Wire_FrameCodec {
	mut obj := &Class_VHttpd_Wire_FrameCodec{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_runtimeexception() &Class_RuntimeException {
	mut obj := &Class_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_VHttpd_Wire_FrameCodec) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'read' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_string(Class_VHttpd_Wire_FrameCodec.read(dispatch_arg_0, dispatch_arg_1))
		}
		'write' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			Class_VHttpd_Wire_FrameCodec.write(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'readExact' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_string(Class_VHttpd_Wire_FrameCodec.readexact(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_VHttpd_Wire_FrameCodec) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_Wire_FrameCodec) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_v_profiler_src_vhttpd_wire_framecodec_php() {
	// unsupported statement: Stmt_Declare
}
