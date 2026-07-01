import rt

struct Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx {
	rt.PhpObjectBase
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx) construct(key string, iv string, counter string)  {
	mut counter_mutated := counter
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.new_string('ChaCha20 expects a 96-bit nonce in IETF mode.'))))
	}
	counter_mutated = (this.initcounter(rt.new_string(counter_mutated))).str()
	this.Class_ParagonIE_Sodium_Core_ChaCha20_Ctx.construct(rt.new_string(key), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(iv), rt.new_int(0), rt.new_int(8)), rt.new_string(counter_mutated))
	rt.get_property(rt.new_object('ParagonIE_Sodium_Core_ChaCha20_IetfCtx', ['ParagonIE_Sodium_Core_ChaCha20_Ctx'], &this), 'container').array_set(12, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(counter_mutated), rt.new_int(0), rt.new_int(4))))
	rt.get_property(rt.new_object('ParagonIE_Sodium_Core_ChaCha20_IetfCtx', ['ParagonIE_Sodium_Core_ChaCha20_Ctx'], &this), 'container').array_set(13, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(iv), rt.new_int(0), rt.new_int(4))))
	rt.get_property(rt.new_object('ParagonIE_Sodium_Core_ChaCha20_IetfCtx', ['ParagonIE_Sodium_Core_ChaCha20_Ctx'], &this), 'container').array_set(14, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(iv), rt.new_int(4), rt.new_int(4))))
	rt.get_property(rt.new_object('ParagonIE_Sodium_Core_ChaCha20_IetfCtx', ['ParagonIE_Sodium_Core_ChaCha20_Ctx'], &this), 'container').array_set(15, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(iv), rt.new_int(8), rt.new_int(4))))
}

struct Class_ParagonIE_Sodium_Core_ChaCha20_Ctx {
	rt.PhpObjectBase
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_chacha20_ietfctx(key string, iv string, counter string) &Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx {
	mut obj := &Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(key, iv, counter)
	return obj
}

fn create_paragonie_sodium_core_chacha20_ctx() &Class_ParagonIE_Sodium_Core_ChaCha20_Ctx {
	mut obj := &Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{
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

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_Ctx) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_ChaCha20_Ctx) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_Ctx) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_sodium_compat_src_core_chacha20_ietfctx_php() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_Core_ChaCha20_IetfCtx'), rt.new_bool(false)])) {
		return rt.new_null()
	}
}
