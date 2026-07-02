import rt

struct Class_ParagonIE_Sodium_Core32_ChaCha20_IetfCtx {
	rt.PhpObjectBase
}

fn (mut this Class_ParagonIE_Sodium_Core32_ChaCha20_IetfCtx) construct(key string, iv string, counter string) {
	mut iife_temp_0 := Class_ParagonIE_Sodium_Core32_ChaCha20_IetfCtx{}
	mut iife_result_0 := iife_temp_0.strlen(rt.new_string(iv))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_0, rt.new_int(12))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{},
			create_invalidargumentexception(rt.new_string('ChaCha20 expects a 96-bit nonce in IETF mode.'))))
	}
	mut iife_temp_1 := Class_ParagonIE_Sodium_Core32_ChaCha20_IetfCtx{}
	mut iife_result_1 := iife_temp_1.substr(rt.new_string(iv), rt.new_int(0), rt.new_int(8))
	this.Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx.construct(rt.new_string(key), iife_result_1,
		rt.new_string(counter))
	if !(counter == '') {
		mut iife_temp_2 := Class_ParagonIE_Sodium_Core32_ChaCha20_IetfCtx{}
		mut iife_result_2 := iife_temp_2.substr(rt.new_string(counter), rt.new_int(0),
			rt.new_int(4))
		mut iife_temp_3 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_3 := iife_temp_3.fromreversestring(iife_result_2)
		rt.get_property(rt.new_object('ParagonIE_Sodium_Core32_ChaCha20_IetfCtx', [
			'ParagonIE_Sodium_Core32_ChaCha20_Ctx',
		], &this), 'container').array_set(12, iife_result_3)
	}
	mut iife_temp_4 := Class_ParagonIE_Sodium_Core32_ChaCha20_IetfCtx{}
	mut iife_result_4 := iife_temp_4.substr(rt.new_string(iv), rt.new_int(0), rt.new_int(4))
	mut iife_temp_5 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_5 := iife_temp_5.fromreversestring(iife_result_4)
	rt.get_property(rt.new_object('ParagonIE_Sodium_Core32_ChaCha20_IetfCtx', [
		'ParagonIE_Sodium_Core32_ChaCha20_Ctx',
	], &this), 'container').array_set(13, iife_result_5)
	mut iife_temp_6 := Class_ParagonIE_Sodium_Core32_ChaCha20_IetfCtx{}
	mut iife_result_6 := iife_temp_6.substr(rt.new_string(iv), rt.new_int(4), rt.new_int(4))
	mut iife_temp_7 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_7 := iife_temp_7.fromreversestring(iife_result_6)
	rt.get_property(rt.new_object('ParagonIE_Sodium_Core32_ChaCha20_IetfCtx', [
		'ParagonIE_Sodium_Core32_ChaCha20_Ctx',
	], &this), 'container').array_set(14, iife_result_7)
	mut iife_temp_8 := Class_ParagonIE_Sodium_Core32_ChaCha20_IetfCtx{}
	mut iife_result_8 := iife_temp_8.substr(rt.new_string(iv), rt.new_int(8), rt.new_int(4))
	mut iife_temp_9 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_9 := iife_temp_9.fromreversestring(iife_result_8)
	rt.get_property(rt.new_object('ParagonIE_Sodium_Core32_ChaCha20_IetfCtx', [
		'ParagonIE_Sodium_Core32_ChaCha20_Ctx',
	], &this), 'container').array_set(15, iife_result_9)
}

struct Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx {
	rt.PhpObjectBase
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Int32 {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core32_chacha20_ietfctx(key string, iv string, counter string) &Class_ParagonIE_Sodium_Core32_ChaCha20_IetfCtx {
	mut obj := &Class_ParagonIE_Sodium_Core32_ChaCha20_IetfCtx{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(key, iv, counter)
	return obj
}

fn create_paragonie_sodium_core32_chacha20_ctx(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx {
	mut obj := &Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_invalidargumentexception(_args ...rt.PhpVal) &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_int32(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Int32 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Int32{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core32_ChaCha20_IetfCtx) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_ParagonIE_Sodium_Core32_ChaCha20_IetfCtx) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_ChaCha20_IetfCtx) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core_ChaCha20_IetfCtx'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}
