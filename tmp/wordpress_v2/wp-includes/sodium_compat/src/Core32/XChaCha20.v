import rt

struct Class_ParagonIE_Sodium_Core32_XChaCha20 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core32_XChaCha20.stream(len i64, nonce string, key string) rt.PhpVal {
	mut iife_temp_0 := Class_ParagonIE_Sodium_Core32_XChaCha20{}
	mut iife_result_0 := iife_temp_0.strlen(rt.new_string(nonce))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_0, rt.new_int(24))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Nonce must be 24 bytes long'))))
	}
	mut iife_temp_1 := Class_ParagonIE_Sodium_Core32_XChaCha20{}
	mut iife_result_1 := iife_temp_1.substr(rt.new_string(nonce), rt.new_int(0), rt.new_int(16))
	mut iife_temp_2 := Class_ParagonIE_Sodium_Core32_XChaCha20{}
	mut iife_result_2 := iife_temp_2.hchacha20(iife_result_1, rt.new_string(key))
	mut iife_temp_3 := Class_ParagonIE_Sodium_Core32_XChaCha20{}
	mut iife_result_3 := iife_temp_3.substr(rt.new_string(nonce), rt.new_int(16), rt.new_int(8))
	mut iife_temp_4 := Class_ParagonIE_Sodium_Core32_XChaCha20{}
	mut iife_result_4 := iife_temp_4.encryptbytes(create_paragonie_sodium_core32_chacha20_ctx(iife_result_2,
		iife_result_3), rt.call_function('str_repeat', [rt.new_string(''),
		rt.new_int(len)]))
	return iife_result_4
}

fn Class_ParagonIE_Sodium_Core32_XChaCha20.streamxoric(var_message rt.PhpVal, nonce string, key string, ic string) rt.PhpVal {
	mut iife_temp_5 := Class_ParagonIE_Sodium_Core32_XChaCha20{}
	mut iife_result_5 := iife_temp_5.strlen(rt.new_string(nonce))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_5, rt.new_int(24))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Nonce must be 24 bytes long'))))
	}
	mut iife_temp_6 := Class_ParagonIE_Sodium_Core32_XChaCha20{}
	mut iife_result_6 := iife_temp_6.substr(rt.new_string(nonce), rt.new_int(0), rt.new_int(16))
	mut iife_temp_7 := Class_ParagonIE_Sodium_Core32_XChaCha20{}
	mut iife_result_7 := iife_temp_7.hchacha20(iife_result_6, rt.new_string(key))
	mut iife_temp_8 := Class_ParagonIE_Sodium_Core32_XChaCha20{}
	mut iife_result_8 := iife_temp_8.substr(rt.new_string(nonce), rt.new_int(16), rt.new_int(8))
	mut iife_temp_9 := Class_ParagonIE_Sodium_Core32_XChaCha20{}
	mut iife_result_9 := iife_temp_9.encryptbytes(create_paragonie_sodium_core32_chacha20_ctx(iife_result_7,
		iife_result_8, rt.new_string(ic)), var_message.clone())
	return iife_result_9
}

fn Class_ParagonIE_Sodium_Core32_XChaCha20.ietfstreamxoric(var_message rt.PhpVal, nonce string, key string, ic string) rt.PhpVal {
	mut iife_temp_10 := Class_ParagonIE_Sodium_Core32_XChaCha20{}
	mut iife_result_10 := iife_temp_10.substr(rt.new_string(nonce), rt.new_int(0), rt.new_int(16))
	mut iife_temp_11 := Class_ParagonIE_Sodium_Core32_XChaCha20{}
	mut iife_result_11 := iife_temp_11.hchacha20(iife_result_10, rt.new_string(key))
	mut iife_temp_12 := Class_ParagonIE_Sodium_Core32_XChaCha20{}
	mut iife_result_12 := iife_temp_12.substr(rt.new_string(nonce), rt.new_int(16), rt.new_int(8))
	mut iife_temp_13 := Class_ParagonIE_Sodium_Core32_XChaCha20{}
	mut iife_result_13 := iife_temp_13.encryptbytes(create_paragonie_sodium_core32_chacha20_ietfctx(iife_result_11,

		'' + iife_result_12.str(), rt.new_string(ic)), var_message.clone())
	return iife_result_13
}

struct Class_ParagonIE_Sodium_Core32_HChaCha20 {
	rt.PhpObjectBase
}

struct Class_SodiumException {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_ChaCha20_IetfCtx {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core32_xchacha20(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_XChaCha20 {
	mut obj := &Class_ParagonIE_Sodium_Core32_XChaCha20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_hchacha20(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_HChaCha20 {
	mut obj := &Class_ParagonIE_Sodium_Core32_HChaCha20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_sodiumexception(_args ...rt.PhpVal) &Class_SodiumException {
	mut obj := &Class_SodiumException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_chacha20_ctx(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx {
	mut obj := &Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_chacha20_ietfctx(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_ChaCha20_IetfCtx {
	mut obj := &Class_ParagonIE_Sodium_Core32_ChaCha20_IetfCtx{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core32_XChaCha20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'stream' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Core32_XChaCha20.stream(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'streamXorIc' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Core32_XChaCha20.streamxoric(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'ietfStreamXorIc' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Core32_XChaCha20.ietfstreamxoric(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		else {
			return none
		}
	}
}

fn (this &Class_ParagonIE_Sodium_Core32_XChaCha20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_XChaCha20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core32_HChaCha20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_HChaCha20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_HChaCha20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core32_ChaCha20_IetfCtx) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_ChaCha20_IetfCtx) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_ChaCha20_IetfCtx) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core32_XChaCha20'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}
