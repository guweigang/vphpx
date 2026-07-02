import rt

fn sodium_crypto_stream_xchacha20(var_len rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_0 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_0 := iife_temp_0.crypto_stream_xchacha20(var_len.clone(), var_nonce.clone(),
		var_key.clone(), rt.new_bool(true))
	return iife_result_0
}

fn sodium_crypto_stream_xchacha20_keygen() rt.PhpVal {
	mut iife_temp_1 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_1 := iife_temp_1.crypto_stream_xchacha20_keygen()
	return iife_result_1
}

fn sodium_crypto_stream_xchacha20_xor(var_message rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_2 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_2 := iife_temp_2.crypto_stream_xchacha20_xor(var_message.clone(),
		var_nonce.clone(), var_key.clone(), rt.new_bool(true))
	return iife_result_2
}

fn sodium_crypto_stream_xchacha20_xor_ic(var_message rt.PhpVal, var_nonce rt.PhpVal, var_counter rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_3 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_3 := iife_temp_3.crypto_stream_xchacha20_xor_ic(var_message.clone(),
		var_nonce.clone(), var_counter.clone(), var_key.clone(), rt.new_bool(true))
	return iife_result_3
}

struct Class_ParagonIE_Sodium_Compat {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_compat(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Compat {
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

fn main() {
	defer {
		rt.shutdown()
	}

	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_stream_xchacha20'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_stream_xchacha20_keygen'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_stream_xchacha20_xor'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_stream_xchacha20_xor_ic'),
	])) {
	}
}
