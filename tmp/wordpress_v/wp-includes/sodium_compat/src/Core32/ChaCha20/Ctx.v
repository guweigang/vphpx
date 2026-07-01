import rt

struct Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx {
	rt.PhpObjectBase
pub mut:
		container rt.PhpVal = rt.new_null()
}

fn (mut this Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx) construct(key string, iv string, counter string)  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.new_string('ChaCha20 expects a 256-bit key.'))))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.new_string('ChaCha20 expects a 64-bit nonce.'))))
	}
	this.container = create_splfixedarray(rt.new_int(16))
	this.container.array_set(0, create_paragonie_sodium_core32_int32(rt.create_array([rt.ArrayItem{ key: none, val: 24944 }, rt.ArrayItem{ key: none, val: 30821 }])))
	this.container.array_set(1, create_paragonie_sodium_core32_int32(rt.create_array([rt.ArrayItem{ key: none, val: 13088 }, rt.ArrayItem{ key: none, val: 25710 }])))
	this.container.array_set(2, create_paragonie_sodium_core32_int32(rt.create_array([rt.ArrayItem{ key: none, val: 31074 }, rt.ArrayItem{ key: none, val: 11570 }])))
	this.container.array_set(3, create_paragonie_sodium_core32_int32(rt.create_array([rt.ArrayItem{ key: none, val: 27424 }, rt.ArrayItem{ key: none, val: 25972 }])))
	this.container.array_set(4, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(key), rt.new_int(0), rt.new_int(4))))
	this.container.array_set(5, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(key), rt.new_int(4), rt.new_int(4))))
	this.container.array_set(6, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(key), rt.new_int(8), rt.new_int(4))))
	this.container.array_set(7, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(key), rt.new_int(12), rt.new_int(4))))
	this.container.array_set(8, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(key), rt.new_int(16), rt.new_int(4))))
	this.container.array_set(9, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(key), rt.new_int(20), rt.new_int(4))))
	this.container.array_set(10, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(key), rt.new_int(24), rt.new_int(4))))
	this.container.array_set(11, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(key), rt.new_int(28), rt.new_int(4))))
	if counter == '' {
		this.container.array_set(12, create_paragonie_sodium_core32_int32())
		this.container.array_set(13, create_paragonie_sodium_core32_int32())
	} else {
		this.container.array_set(12, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(counter), rt.new_int(0), rt.new_int(4))))
		this.container.array_set(13, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(counter), rt.new_int(4), rt.new_int(4))))
	}
	this.container.array_set(14, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(iv), rt.new_int(0), rt.new_int(4))))
	this.container.array_set(15, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(iv), rt.new_int(4), rt.new_int(4))))
}

fn (mut this Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx) offsetset(var_offset rt.PhpVal, var_value rt.PhpVal)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_offset.dup().is_long()))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.new_string('Expected an integer'))))
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_value, 'ParagonIE_Sodium_Core32_Int32'))) {
		// unsupported statement: Stmt_Nop
	} else {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.new_string('Expected an integer'))))
	}
	this.container.array_set(var_offset, var_value.dup())
}

fn (mut this Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx) offsetexists(var_offset rt.PhpVal) rt.PhpVal {
	return rt.new_bool(this.container.array_isset(var_offset))
}

fn (mut this Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx) offsetunset(var_offset rt.PhpVal)  {
	this.container.array_unset(var_offset)
}

fn (mut this Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx) offsetget(var_offset rt.PhpVal) rt.PhpVal {
	return if this.container.array_isset(var_offset) { this.container.array_get(var_offset) } else { rt.new_null() }
}

struct Class_ParagonIE_Sodium_Core32_Util {
	rt.PhpObjectBase
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_SplFixedArray {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Int32 {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core32_chacha20_ctx(key string, iv string, counter string) &Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx {
	mut obj := &Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx{
		PhpObjectBase: rt.PhpObjectBase{}
		container: rt.new_null()
	}
	obj.construct(key, iv, counter)
	return obj
}

fn create_paragonie_sodium_core32_util() &Class_ParagonIE_Sodium_Core32_Util {
	mut obj := &Class_ParagonIE_Sodium_Core32_Util{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_invalidargumentexception() &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_splfixedarray() &Class_SplFixedArray {
	mut obj := &Class_SplFixedArray{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_int32() &Class_ParagonIE_Sodium_Core32_Int32 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Int32{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'offsetSet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.offsetset(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'offsetExists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.offsetexists(dispatch_arg_0)
		}
		'offsetUnset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.offsetunset(dispatch_arg_0)
			return rt.new_null()
		}
		'offsetGet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.offsetget(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'container' { return this.container }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'container' { this.container = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_ParagonIE_Sodium_Core32_Util) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Util) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Util) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_SplFixedArray) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SplFixedArray) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SplFixedArray) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ParagonIE_Sodium_Core32_Int32) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Int32) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int32) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_sodium_compat_src_core32_chacha20_ctx_php() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_Core_ChaCha20_Ctx'), rt.new_bool(false)])) {
		return rt.new_null()
	}
}
