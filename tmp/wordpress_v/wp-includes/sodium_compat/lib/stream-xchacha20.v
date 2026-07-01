import rt

fn sodium_crypto_stream_xchacha20(var_len rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_stream_xchacha20(arg_0, arg_1, arg_2, arg_3)
	}(var_len.dup(), var_nonce.dup(), var_key.dup(), rt.new_bool(true))
}

fn sodium_crypto_stream_xchacha20_keygen() rt.PhpVal {
	return fn () rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_stream_xchacha20_keygen()
	}()
}

fn sodium_crypto_stream_xchacha20_xor(var_message rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_stream_xchacha20_xor(arg_0, arg_1, arg_2, arg_3)
	}(var_message.dup(), var_nonce.dup(), var_key.dup(), rt.new_bool(true))
}

fn sodium_crypto_stream_xchacha20_xor_ic(var_message rt.PhpVal, var_nonce rt.PhpVal, var_counter rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_stream_xchacha20_xor_ic(arg_0, arg_1, arg_2, arg_3, arg_4)
	}(var_message.dup(), var_nonce.dup(), var_counter.dup(), var_key.dup(), rt.new_bool(true))
}

struct Class_ParagonIE_Sodium_Compat {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_compat() &Class_ParagonIE_Sodium_Compat {
	mut obj := &Class_ParagonIE_Sodium_Compat{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Compat) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Compat) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Compat) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_sodium_compat_lib_stream_xchacha20_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_stream_xchacha20'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_stream_xchacha20_keygen'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_stream_xchacha20_xor'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_stream_xchacha20_xor_ic'),
	])))))
	{
	}
}
