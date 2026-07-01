import rt

fn sodium_add(var_string1 rt.PhpVal, var_string2 rt.PhpVal) {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.add(arg_0, arg_1) }(var_string1.dup(), var_string2.dup())
}

fn sodium_base642bin(var_string rt.PhpVal, var_variant rt.PhpVal, ignore string) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.base642bin(arg_0, arg_1, arg_2) }(var_string.dup(), var_variant.dup(), rt.new_string(ignore))
}

fn sodium_bin2base64(var_string rt.PhpVal, var_variant rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.bin2base64(arg_0, arg_1) }(var_string.dup(), var_variant.dup())
}

fn sodium_bin2hex(var_string rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.bin2hex(arg_0) }(var_string.dup())
}

fn sodium_compare(var_string1 rt.PhpVal, var_string2 rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.compare(arg_0, arg_1) }(var_string1.dup(), var_string2.dup())
}

fn sodium_crypto_aead_aes256gcm_decrypt(var_ciphertext rt.PhpVal, var_additional_data rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_aead_aes256gcm_decrypt(arg_0, arg_1, arg_2, arg_3) }(var_ciphertext.dup(), var_additional_data.dup(), var_nonce.dup(), var_key.dup())
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Error') {
		mut var_ex := var_e_1.dup()
		return rt.new_bool(false)
		unsafe { goto end_label_1 }
	}
	else if rt.instance_of(var_e_1, 'Exception') {
		mut var_ex := var_e_1.dup()
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_ex, 'SodiumException'))) && rt.is_true(rt.identical(rt.call_method(var_ex, 'getMessage', []rt.PhpVal{}), rt.new_string('AES-256-GCM is not available'))))) {
			rt.throw_exception(var_ex)
		}
		return rt.new_bool(false)
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.new_null()
}

fn sodium_crypto_aead_aes256gcm_encrypt(var_message rt.PhpVal, var_additional_data rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_aead_aes256gcm_encrypt(arg_0, arg_1, arg_2, arg_3) }(var_message.dup(), var_additional_data.dup(), var_nonce.dup(), var_key.dup())
}

fn sodium_crypto_aead_aes256gcm_is_available() rt.PhpVal {
	return fn () rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_aead_aes256gcm_is_available() }()
}

fn sodium_crypto_aead_chacha20poly1305_decrypt(var_ciphertext rt.PhpVal, var_additional_data rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_aead_chacha20poly1305_decrypt(arg_0, arg_1, arg_2, arg_3) }(var_ciphertext.dup(), var_additional_data.dup(), var_nonce.dup(), var_key.dup())
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Error') {
		mut var_ex := var_e_2.dup()
		return rt.new_bool(false)
		unsafe { goto end_label_2 }
	}
	else if rt.instance_of(var_e_2, 'Exception') {
		mut var_ex := var_e_2.dup()
		return rt.new_bool(false)
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return rt.new_null()
}

fn sodium_crypto_aead_chacha20poly1305_encrypt(var_message rt.PhpVal, var_additional_data rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_aead_chacha20poly1305_encrypt(arg_0, arg_1, arg_2, arg_3) }(var_message.dup(), var_additional_data.dup(), var_nonce.dup(), var_key.dup())
}

fn sodium_crypto_aead_chacha20poly1305_keygen() rt.PhpVal {
	return fn () rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_aead_chacha20poly1305_keygen() }()
}

fn sodium_crypto_aead_chacha20poly1305_ietf_decrypt(var_message rt.PhpVal, var_additional_data rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_aead_chacha20poly1305_ietf_decrypt(arg_0, arg_1, arg_2, arg_3) }(var_message.dup(), var_additional_data.dup(), var_nonce.dup(), var_key.dup())
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Error') {
		mut var_ex := var_e_3.dup()
		return rt.new_bool(false)
		unsafe { goto end_label_3 }
	}
	else if rt.instance_of(var_e_3, 'Exception') {
		mut var_ex := var_e_3.dup()
		return rt.new_bool(false)
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	return rt.new_null()
}

fn sodium_crypto_aead_chacha20poly1305_ietf_encrypt(var_message rt.PhpVal, var_additional_data rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_aead_chacha20poly1305_ietf_encrypt(arg_0, arg_1, arg_2, arg_3) }(var_message.dup(), var_additional_data.dup(), var_nonce.dup(), var_key.dup())
}

fn sodium_crypto_aead_chacha20poly1305_ietf_keygen() rt.PhpVal {
	return fn () rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_aead_chacha20poly1305_ietf_keygen() }()
}

fn sodium_crypto_aead_xchacha20poly1305_ietf_decrypt(var_ciphertext rt.PhpVal, var_additional_data rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_aead_xchacha20poly1305_ietf_decrypt(arg_0, arg_1, arg_2, arg_3, arg_4) }(var_ciphertext.dup(), var_additional_data.dup(), var_nonce.dup(), var_key.dup(), rt.new_bool(true))
	unsafe { goto end_label_4 }

catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'Error') {
		mut var_ex := var_e_4.dup()
		return rt.new_bool(false)
		unsafe { goto end_label_4 }
	}
	else if rt.instance_of(var_e_4, 'Exception') {
		mut var_ex := var_e_4.dup()
		return rt.new_bool(false)
		unsafe { goto end_label_4 }
	}
	else {
		rt.throw_exception(var_e_4)
		unsafe { goto end_label_4 }
	}

end_label_4:
	return rt.new_null()
}

fn sodium_crypto_aead_xchacha20poly1305_ietf_encrypt(var_message rt.PhpVal, var_additional_data rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_aead_xchacha20poly1305_ietf_encrypt(arg_0, arg_1, arg_2, arg_3, arg_4) }(var_message.dup(), var_additional_data.dup(), var_nonce.dup(), var_key.dup(), rt.new_bool(true))
}

fn sodium_crypto_aead_xchacha20poly1305_ietf_keygen() rt.PhpVal {
	return fn () rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_aead_xchacha20poly1305_ietf_keygen() }()
}

fn sodium_crypto_auth(var_message rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_auth(arg_0, arg_1) }(var_message.dup(), var_key.dup())
}

fn sodium_crypto_auth_keygen() rt.PhpVal {
	return fn () rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_auth_keygen() }()
}

fn sodium_crypto_auth_verify(var_mac rt.PhpVal, var_message rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_auth_verify(arg_0, arg_1, arg_2) }(var_mac.dup(), var_message.dup(), var_key.dup())
}

fn sodium_crypto_box(var_message rt.PhpVal, var_nonce rt.PhpVal, var_key_pair rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_box(arg_0, arg_1, arg_2) }(var_message.dup(), var_nonce.dup(), var_key_pair.dup())
}

fn sodium_crypto_box_keypair() rt.PhpVal {
	return fn () rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_box_keypair() }()
}

fn sodium_crypto_box_keypair_from_secretkey_and_publickey(var_secret_key rt.PhpVal, var_public_key rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_box_keypair_from_secretkey_and_publickey(arg_0, arg_1) }(var_secret_key.dup(), var_public_key.dup())
}

fn sodium_crypto_box_open(var_ciphertext rt.PhpVal, var_nonce rt.PhpVal, var_key_pair rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_box_open(arg_0, arg_1, arg_2) }(var_ciphertext.dup(), var_nonce.dup(), var_key_pair.dup())
	unsafe { goto end_label_5 }

catch_label_5:
	mut var_e_5 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_5, 'Error') {
		mut var_ex := var_e_5.dup()
		return rt.new_bool(false)
		unsafe { goto end_label_5 }
	}
	else if rt.instance_of(var_e_5, 'Exception') {
		mut var_ex := var_e_5.dup()
		return rt.new_bool(false)
		unsafe { goto end_label_5 }
	}
	else {
		rt.throw_exception(var_e_5)
		unsafe { goto end_label_5 }
	}

end_label_5:
	return rt.new_null()
}

fn sodium_crypto_box_publickey(var_key_pair rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_box_publickey(arg_0) }(var_key_pair.dup())
}

fn sodium_crypto_box_publickey_from_secretkey(var_secret_key rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_box_publickey_from_secretkey(arg_0) }(var_secret_key.dup())
}

fn sodium_crypto_box_seal(var_message rt.PhpVal, var_public_key rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_box_seal(arg_0, arg_1) }(var_message.dup(), var_public_key.dup())
}

fn sodium_crypto_box_seal_open(var_message rt.PhpVal, var_key_pair rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_box_seal_open(arg_0, arg_1) }(var_message.dup(), var_key_pair.dup())
	unsafe { goto end_label_6 }

catch_label_6:
	mut var_e_6 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_6, 'SodiumException') {
		mut var_ex := var_e_6.dup()
		if rt.is_true(rt.identical(rt.call_method(var_ex, 'getMessage', []rt.PhpVal{}), rt.new_string('Argument 2 must be CRYPTO_BOX_KEYPAIRBYTES long.'))) {
			rt.throw_exception(var_ex)
		}
		return rt.new_bool(false)
		unsafe { goto end_label_6 }
	}
	else {
		rt.throw_exception(var_e_6)
		unsafe { goto end_label_6 }
	}

end_label_6:
	return rt.new_null()
}

fn sodium_crypto_box_secretkey(var_key_pair rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_box_secretkey(arg_0) }(var_key_pair.dup())
}

fn sodium_crypto_box_seed_keypair(var_seed rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_box_seed_keypair(arg_0) }(var_seed.dup())
}

fn sodium_crypto_generichash(var_message rt.PhpVal, var_key rt.PhpVal, length i64) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_generichash(arg_0, arg_1, arg_2) }(var_message.dup(), var_key.dup(), rt.new_int(length))
}

fn sodium_crypto_generichash_final(var_state rt.PhpVal, outputLength i64) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_generichash_final(arg_0, arg_1) }(var_state.dup(), rt.new_int(outputLength))
}

fn sodium_crypto_generichash_init(var_key rt.PhpVal, length i64) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_generichash_init(arg_0, arg_1) }(var_key.dup(), rt.new_int(length))
}

fn sodium_crypto_generichash_keygen() rt.PhpVal {
	return fn () rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_generichash_keygen() }()
}

fn sodium_crypto_generichash_update(var_state rt.PhpVal, message string) {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_generichash_update(arg_0, arg_1) }(var_state.dup(), rt.new_string(message))
}

fn sodium_crypto_kdf_keygen() rt.PhpVal {
	return fn () rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_kdf_keygen() }()
}

fn sodium_crypto_kdf_derive_from_key(var_subkey_length rt.PhpVal, var_subkey_id rt.PhpVal, var_context rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_kdf_derive_from_key(arg_0, arg_1, arg_2, arg_3) }(var_subkey_length.dup(), var_subkey_id.dup(), var_context.dup(), var_key.dup())
}

fn sodium_crypto_kx(var_my_secret rt.PhpVal, var_their_public rt.PhpVal, var_client_public rt.PhpVal, var_server_public rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_kx(arg_0, arg_1, arg_2, arg_3) }(.dup(), .dup(), .dup(), .dup())
}

fn sodium_crypto_kx_seed_keypair(var_seed rt.PhpVal) rt.PhpVal {
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




pub fn init_wp_includes_sodium_compat_lib_php72compat_php() {
	rt.include_file((rt.call_function('dirname', [rt.call_function('dirname', [rt.new_string(@FILE)])])).str() + '/autoload.php', '4')
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'BASE64_VARIANT_ORIGINAL' }, rt.ArrayItem{ key: none, val: 'BASE64_VARIANT_ORIGINAL_NO_PADDING' }, rt.ArrayItem{ key: none, val: 'BASE64_VARIANT_URLSAFE' }, rt.ArrayItem{ key: none, val: 'BASE64_VARIANT_URLSAFE_NO_PADDING' }, rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_AES256GCM_KEYBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_AES256GCM_NSECBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_AES256GCM_NPUBBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_AES256GCM_ABYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_CHACHA20POLY1305_KEYBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_CHACHA20POLY1305_NSECBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_CHACHA20POLY1305_NPUBBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_CHACHA20POLY1305_ABYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_CHACHA20POLY1305_IETF_KEYBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_CHACHA20POLY1305_IETF_NSECBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_CHACHA20POLY1305_IETF_NPUBBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_CHACHA20POLY1305_IETF_ABYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_XCHACHA20POLY1305_IETF_KEYBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_XCHACHA20POLY1305_IETF_NSECBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_XCHACHA20POLY1305_IETF_NPUBBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_XCHACHA20POLY1305_IETF_ABYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_AUTH_BYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_AUTH_KEYBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_BOX_SEALBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_BOX_SECRETKEYBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_BOX_PUBLICKEYBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_BOX_KEYPAIRBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_BOX_MACBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_BOX_NONCEBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_BOX_SEEDBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_KDF_BYTES_MIN' }, rt.ArrayItem{ key: none, val: 'CRYPTO_KDF_BYTES_MAX' }, rt.ArrayItem{ key: none, val: 'CRYPTO_KDF_CONTEXTBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_KDF_KEYBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_KX_BYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_KX_KEYPAIRBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_KX_PRIMITIVE' }, rt.ArrayItem{ key: none, val: 'CRYPTO_KX_SEEDBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_KX_PUBLICKEYBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_KX_SECRETKEYBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_KX_SESSIONKEYBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_GENERICHASH_BYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_GENERICHASH_BYTES_MIN' }, rt.ArrayItem{ key: none, val: 'CRYPTO_GENERICHASH_BYTES_MAX' }, rt.ArrayItem{ key: none, val: 'CRYPTO_GENERICHASH_KEYBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_GENERICHASH_KEYBYTES_MIN' }, rt.ArrayItem{ key: none, val: 'CRYPTO_GENERICHASH_KEYBYTES_MAX' }, rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_SALTBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_STRPREFIX' }, rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_ALG_ARGON2I13' }, rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_ALG_ARGON2ID13' }, rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_MEMLIMIT_INTERACTIVE' }, rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_OPSLIMIT_INTERACTIVE' }, rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_MEMLIMIT_MODERATE' }, rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_OPSLIMIT_MODERATE' }, rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_MEMLIMIT_SENSITIVE' }, rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_OPSLIMIT_SENSITIVE' }, rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_SCRYPTSALSA208SHA256_SALTBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_SCRYPTSALSA208SHA256_STRPREFIX' }, rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_SCRYPTSALSA208SHA256_MEMLIMIT_INTERACTIVE' }, rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_SCRYPTSALSA208SHA256_OPSLIMIT_INTERACTIVE' }, rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_SCRYPTSALSA208SHA256_MEMLIMIT_SENSITIVE' }, rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_SCRYPTSALSA208SHA256_OPSLIMIT_SENSITIVE' }, rt.ArrayItem{ key: none, val: 'CRYPTO_SCALARMULT_BYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_SCALARMULT_SCALARBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_SHORTHASH_BYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_SHORTHASH_KEYBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_SECRETBOX_KEYBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_SECRETBOX_MACBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_SECRETBOX_NONCEBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_SECRETSTREAM_XCHACHA20POLY1305_ABYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_SECRETSTREAM_XCHACHA20POLY1305_HEADERBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_SECRETSTREAM_XCHACHA20POLY1305_KEYBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_SECRETSTREAM_XCHACHA20POLY1305_TAG_PUSH' }, rt.ArrayItem{ key: none, val: 'CRYPTO_SECRETSTREAM_XCHACHA20POLY1305_TAG_PULL' }, rt.ArrayItem{ key: none, val: 'CRYPTO_SECRETSTREAM_XCHACHA20POLY1305_TAG_REKEY' }, rt.ArrayItem{ key: none, val: 'CRYPTO_SECRETSTREAM_XCHACHA20POLY1305_TAG_FINAL' }, rt.ArrayItem{ key: none, val: 'CRYPTO_SECRETSTREAM_XCHACHA20POLY1305_MESSAGEBYTES_MAX' }, rt.ArrayItem{ key: none, val: 'CRYPTO_SIGN_BYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_SIGN_SEEDBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_SIGN_PUBLICKEYBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_SIGN_SECRETKEYBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_SIGN_KEYPAIRBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_STREAM_KEYBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_STREAM_NONCEBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_STREAM_XCHACHA20_KEYBYTES' }, rt.ArrayItem{ key: none, val: 'CRYPTO_STREAM_XCHACHA20_NONCEBYTES' }, rt.ArrayItem{ key: none, val: 'LIBRARY_MAJOR_VERSION' }, rt.ArrayItem{ key: none, val: 'LIBRARY_MINOR_VERSION' }, rt.ArrayItem{ key: none, val: 'LIBRARY_VERSION_MAJOR' }, rt.ArrayItem{ key: none, val: 'LIBRARY_VERSION_MINOR' }, rt.ArrayItem{ key: none, val: 'VERSION_STRING' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_constant := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string("SODIUM_${var_constant.to_string()}")]))))) && rt.is_true(rt.call_function('defined', [rt.new_string("ParagonIE_Sodium_Compat::${var_constant.to_string()}")])))) {
				rt.call_function('define', [rt.new_string("SODIUM_${var_constant.to_string()}"), rt.call_function('constant', [rt.new_string("ParagonIE_Sodium_Compat::${var_constant.to_string()}")])])
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_add')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_base642bin')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_bin2base64')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_bin2hex')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_compare')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_aead_aes256gcm_decrypt')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_aead_aes256gcm_encrypt')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_aead_aes256gcm_is_available')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_aead_chacha20poly1305_decrypt')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_aead_chacha20poly1305_encrypt')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_aead_chacha20poly1305_keygen')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_aead_chacha20poly1305_ietf_decrypt')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_aead_chacha20poly1305_ietf_encrypt')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_aead_chacha20poly1305_ietf_keygen')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_aead_xchacha20poly1305_ietf_decrypt')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_aead_xchacha20poly1305_ietf_encrypt')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_aead_xchacha20poly1305_ietf_keygen')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_auth')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_auth_keygen')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_auth_verify')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_box')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_box_keypair')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_box_keypair_from_secretkey_and_publickey')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_box_open')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_box_publickey')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_box_publickey_from_secretkey')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_box_seal')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_box_seal_open')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_box_secretkey')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_box_seed_keypair')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_generichash')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_generichash_final')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_generichash_init')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_generichash_keygen')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_generichash_update')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_kdf_keygen')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_kdf_derive_from_key')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string('sodium_crypto_kx')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true()))) {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	
}
