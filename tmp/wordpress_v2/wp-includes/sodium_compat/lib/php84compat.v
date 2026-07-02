import rt

fn sodium_crypto_aead_aegis128l_decrypt(var_ciphertext rt.PhpVal, var_additional_data rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_0 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_0 := iife_temp_0.crypto_aead_aegis128l_decrypt(var_ciphertext.clone(),
		var_additional_data.clone(), var_nonce.clone(), var_key.clone())
	return iife_result_0
}

fn sodium_crypto_aead_aegis128l_encrypt(var_message rt.PhpVal, var_additional_data rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_1 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_1 := iife_temp_1.crypto_aead_aegis128l_encrypt(var_message.clone(),
		var_additional_data.clone(), var_nonce.clone(), var_key.clone())
	return iife_result_1
}

fn sodium_crypto_aead_aegis256_decrypt(var_ciphertext rt.PhpVal, var_additional_data rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_2 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_2 := iife_temp_2.crypto_aead_aegis256_decrypt(var_ciphertext.clone(),
		var_additional_data.clone(), var_nonce.clone(), var_key.clone())
	return iife_result_2
}

fn sodium_crypto_aead_aegis256_encrypt(var_message rt.PhpVal, var_additional_data rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_3 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_3 := iife_temp_3.crypto_aead_aegis256_encrypt(var_message.clone(),
		var_additional_data.clone(), var_nonce.clone(), var_key.clone())
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

	rt.include_file(
		(rt.call_function('dirname', [rt.call_function('dirname', [rt.new_string(@FILE)])])).str() +
		'/autoload.php', '4')
	mut iter_1 := rt.create_array([
		rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_AESGIS128L_KEYBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_AESGIS128L_NSECBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_AESGIS128L_NPUBBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_AESGIS128L_ABYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_AESGIS256_KEYBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_AESGIS256_NSECBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_AESGIS256_NPUBBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_AESGIS256_ABYTES' },
	]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_constant := item_1.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('SODIUM_${var_constant.to_string()}')])))))
			&& rt.is_true(rt.call_function('defined', [rt.new_string('ParagonIE_Sodium_Compat::${var_constant.to_string()}')])) {
			rt.call_function('define', [
				rt.new_string('SODIUM_${var_constant.to_string()}'),
				rt.call_function('constant', [
					rt.new_string('ParagonIE_Sodium_Compat::${var_constant.to_string()}'),
				]),
			])
		}
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_aead_aegis128l_decrypt'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_aead_aegis128l_encrypt'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_aead_aegis256_decrypt'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_aead_aegis256_encrypt'),
	])) {
	}
}
