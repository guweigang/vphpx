import rt

struct Class_ParagonIE_Sodium_Core_ChaCha20_Ctx {
	rt.PhpObjectBase
pub mut:
		container rt.PhpVal = rt.new_null()
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_Ctx) construct(key string, iv string, counter string)  {
	mut counter_mutated := counter
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.new_string('ChaCha20 expects a 256-bit key.'))))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.new_string('ChaCha20 expects a 64-bit nonce.'))))
	}
	this.container = create_splfixedarray(rt.new_int(16))
	this.container.array_set(0, 1634760805)
	this.container.array_set(1, 857760878)
	this.container.array_set(2, 2036477234)
	this.container.array_set(3, 1797285236)
	this.container.array_set(4, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(key), rt.new_int(0), rt.new_int(4))))
	this.container.array_set(5, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(key), rt.new_int(4), rt.new_int(4))))
	this.container.array_set(6, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(key), rt.new_int(8), rt.new_int(4))))
	this.container.array_set(7, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(key), rt.new_int(12), rt.new_int(4))))
	this.container.array_set(8, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(key), rt.new_int(16), rt.new_int(4))))
	this.container.array_set(9, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(key), rt.new_int(20), rt.new_int(4))))
	this.container.array_set(10, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(key), rt.new_int(24), rt.new_int(4))))
	this.container.array_set(11, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(key), rt.new_int(28), rt.new_int(4))))
	counter_mutated = this.initcounter(rt.new_string(counter_mutated))
	this.container.array_set(12, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(counter_mutated), rt.new_int(0), rt.new_int(4))))
	this.container.array_set(13, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(counter_mutated), rt.new_int(4), rt.new_int(4))))
	this.container.array_set(14, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(iv), rt.new_int(0), rt.new_int(4))))
	this.container.array_set(15, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(iv), rt.new_int(4), rt.new_int(4))))
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_Ctx) offsetset(var_offset rt.PhpVal, var_value rt.PhpVal)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_offset.dup().is_long()))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.new_string('Expected an integer'))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.dup().is_long()))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.new_string('Expected an integer'))))
	}
	this.container.array_set(var_offset, var_value.dup())
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_Ctx) offsetexists(var_offset rt.PhpVal) rt.PhpVal {
	return rt.new_bool(this.container.array_isset(var_offset))
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_Ctx) offsetunset(var_offset rt.PhpVal)  {
	this.container.array_unset(var_offset)
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_Ctx) offsetget(var_offset rt.PhpVal) rt.PhpVal {
	return if this.container.array_isset(var_offset) { this.container.array_get(var_offset) } else { rt.new_null() }
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_Ctx) initcounter(var_ctr rt.PhpVal) string {
	mut var_len := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}; return temp.strlen(arg_0) }(var_ctr.dup())
	if rt.is_true(rt.identical(var_len, rt.new_int(0))) {
		return (rt.call_function('str_repeat', [rt.new_string(''), rt.new_int(8)])).str()
	}
	if rt.is_true(rt.less(var_len, rt.new_int(8))) {
		return (var_ctr).str() + (rt.call_function('str_repeat', [rt.new_string(''), rt.sub(rt.new_int(8), var_len)])).str()
	}
	if rt.is_true(rt.greater(var_len, rt.new_int(8))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('counter cannot be more than 8 bytes'))))
	}
	return (var_ctr).str()
}

struct Class_ParagonIE_Sodium_Core_Util {
	rt.PhpObjectBase
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_SplFixedArray {
	rt.PhpObjectBase
}

struct Class_SodiumException {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_chacha20_ctx(key string, iv string, counter string) &Class_ParagonIE_Sodium_Core_ChaCha20_Ctx {
	mut obj := &Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{
		PhpObjectBase: rt.PhpObjectBase{}
		container: rt.new_null()
	}
	obj.construct(key, iv, counter)
	return obj
}

fn create_paragonie_sodium_core_util() &Class_ParagonIE_Sodium_Core_Util {
	mut obj := &Class_ParagonIE_Sodium_Core_Util{
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

fn create_sodiumexception() &Class_SodiumException {
	mut obj := &Class_SodiumException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_Ctx) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'initCounter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.initcounter(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_ParagonIE_Sodium_Core_ChaCha20_Ctx) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'container' { return this.container }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_Ctx) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'container' { this.container = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_ParagonIE_Sodium_Core_Util) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_Util) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Util) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_SodiumException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SodiumException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SodiumException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_sodium_compat_src_core_chacha20_ctx_php() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_Core_ChaCha20_Ctx'), rt.new_bool(false)])) {
		return rt.new_null()
	}
}
