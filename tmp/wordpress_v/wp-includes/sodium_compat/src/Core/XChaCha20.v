import rt

struct Class_ParagonIE_Sodium_Core_XChaCha20 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core_XChaCha20.stream(var_len rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Nonce must be 24 bytes long'))))
	}
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_XChaCha20{}; return temp.encryptbytes(arg_0, arg_1) }(create_paragonie_sodium_core_chacha20_ctx(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_XChaCha20{}; return temp.hchacha20(arg_0, arg_1) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_XChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_nonce.dup(), rt.new_int(0), rt.new_int(16)), var_key.dup()), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_XChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_nonce.dup(), rt.new_int(16), rt.new_int(8))), rt.call_function('str_repeat', [rt.new_string(''), var_len.dup()]))
}

fn Class_ParagonIE_Sodium_Core_XChaCha20.ietfstream(var_len rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Nonce must be 24 bytes long'))))
	}
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_XChaCha20{}; return temp.encryptbytes(arg_0, arg_1) }(create_paragonie_sodium_core_chacha20_ietfctx(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_XChaCha20{}; return temp.hchacha20(arg_0, arg_1) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_XChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_nonce.dup(), rt.new_int(0), rt.new_int(16)), var_key.dup()), '' + (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_XChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_nonce.dup(), rt.new_int(16), rt.new_int(8))).str()), rt.call_function('str_repeat', [rt.new_string(''), var_len.dup()]))
}

fn Class_ParagonIE_Sodium_Core_XChaCha20.streamxoric(var_message rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal, ic string) rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Nonce must be 24 bytes long'))))
	}
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_XChaCha20{}; return temp.encryptbytes(arg_0, arg_1) }(create_paragonie_sodium_core_chacha20_ctx(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_XChaCha20{}; return temp.hchacha20(arg_0, arg_1) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_XChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_nonce.dup(), rt.new_int(0), rt.new_int(16)), var_key.dup()), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_XChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_nonce.dup(), rt.new_int(16), rt.new_int(8)), rt.new_string(ic).dup()), var_message.dup())
}

fn Class_ParagonIE_Sodium_Core_XChaCha20.ietfstreamxoric(var_message rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal, ic string) rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Nonce must be 24 bytes long'))))
	}
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_XChaCha20{}; return temp.encryptbytes(arg_0, arg_1) }(create_paragonie_sodium_core_chacha20_ietfctx(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_XChaCha20{}; return temp.hchacha20(arg_0, arg_1) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_XChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_nonce.dup(), rt.new_int(0), rt.new_int(16)), var_key.dup()), '' + (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_XChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_nonce.dup(), rt.new_int(16), rt.new_int(8))).str(), rt.new_string(ic).dup()), var_message.dup())
}

struct Class_ParagonIE_Sodium_Core_HChaCha20 {
	rt.PhpObjectBase
}

struct Class_SodiumException {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core_ChaCha20_Ctx {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_xchacha20() &Class_ParagonIE_Sodium_Core_XChaCha20 {
	mut obj := &Class_ParagonIE_Sodium_Core_XChaCha20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_hchacha20() &Class_ParagonIE_Sodium_Core_HChaCha20 {
	mut obj := &Class_ParagonIE_Sodium_Core_HChaCha20{
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

fn create_paragonie_sodium_core_chacha20_ctx() &Class_ParagonIE_Sodium_Core_ChaCha20_Ctx {
	mut obj := &Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_chacha20_ietfctx() &Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx {
	mut obj := &Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_XChaCha20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'stream' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_XChaCha20.stream(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'ietfStream' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_XChaCha20.ietfstream(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'streamXorIc' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Core_XChaCha20.streamxoric(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'ietfStreamXorIc' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Core_XChaCha20.ietfstreamxoric(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		else { return none }
	}
}

fn (this &Class_ParagonIE_Sodium_Core_XChaCha20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_XChaCha20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ParagonIE_Sodium_Core_HChaCha20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_HChaCha20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_HChaCha20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_Ctx) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_ChaCha20_Ctx) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_Ctx) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_sodium_compat_src_core_xchacha20_php() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_Core_XChaCha20'), rt.new_bool(false)])) {
		return rt.new_null()
	}
}
