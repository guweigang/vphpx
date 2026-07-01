import rt

pub fn Class_ParagonIE_Sodium_Crypto.aead_chacha20poly1305_keybytes() i64 {
	return 32
}
pub fn Class_ParagonIE_Sodium_Crypto.aead_chacha20poly1305_nsecbytes() i64 {
	return 0
}
pub fn Class_ParagonIE_Sodium_Crypto.aead_chacha20poly1305_npubbytes() i64 {
	return 8
}
pub fn Class_ParagonIE_Sodium_Crypto.aead_chacha20poly1305_abytes() i64 {
	return 16
}
pub fn Class_ParagonIE_Sodium_Crypto.aead_chacha20poly1305_ietf_keybytes() i64 {
	return 32
}
pub fn Class_ParagonIE_Sodium_Crypto.aead_chacha20poly1305_ietf_nsecbytes() i64 {
	return 0
}
pub fn Class_ParagonIE_Sodium_Crypto.aead_chacha20poly1305_ietf_npubbytes() i64 {
	return 12
}
pub fn Class_ParagonIE_Sodium_Crypto.aead_chacha20poly1305_ietf_abytes() i64 {
	return 16
}
pub fn Class_ParagonIE_Sodium_Crypto.aead_xchacha20poly1305_ietf_keybytes() i64 {
	return 32
}
pub fn Class_ParagonIE_Sodium_Crypto.aead_xchacha20poly1305_ietf_nsecbytes() i64 {
	return 0
}
pub fn Class_ParagonIE_Sodium_Crypto.aead_xchacha20poly1305_ietf_npubbytes() i64 {
	return 24
}
pub fn Class_ParagonIE_Sodium_Crypto.aead_xchacha20poly1305_ietf_abytes() i64 {
	return 16
}
pub fn Class_ParagonIE_Sodium_Crypto.box_curve25519xsalsa20poly1305_seedbytes() i64 {
	return 32
}
pub fn Class_ParagonIE_Sodium_Crypto.box_curve25519xsalsa20poly1305_publickeybytes() i64 {
	return 32
}
pub fn Class_ParagonIE_Sodium_Crypto.box_curve25519xsalsa20poly1305_secretkeybytes() i64 {
	return 32
}
pub fn Class_ParagonIE_Sodium_Crypto.box_curve25519xsalsa20poly1305_beforenmbytes() i64 {
	return 32
}
pub fn Class_ParagonIE_Sodium_Crypto.box_curve25519xsalsa20poly1305_noncebytes() i64 {
	return 24
}
pub fn Class_ParagonIE_Sodium_Crypto.box_curve25519xsalsa20poly1305_macbytes() i64 {
	return 16
}
pub fn Class_ParagonIE_Sodium_Crypto.box_curve25519xsalsa20poly1305_boxzerobytes() i64 {
	return 16
}
pub fn Class_ParagonIE_Sodium_Crypto.box_curve25519xsalsa20poly1305_zerobytes() i64 {
	return 32
}
pub fn Class_ParagonIE_Sodium_Crypto.onetimeauth_poly1305_bytes() i64 {
	return 16
}
pub fn Class_ParagonIE_Sodium_Crypto.onetimeauth_poly1305_keybytes() i64 {
	return 32
}
pub fn Class_ParagonIE_Sodium_Crypto.secretbox_xsalsa20poly1305_keybytes() i64 {
	return 32
}
pub fn Class_ParagonIE_Sodium_Crypto.secretbox_xsalsa20poly1305_noncebytes() i64 {
	return 24
}
pub fn Class_ParagonIE_Sodium_Crypto.secretbox_xsalsa20poly1305_macbytes() i64 {
	return 16
}
pub fn Class_ParagonIE_Sodium_Crypto.secretbox_xsalsa20poly1305_boxzerobytes() i64 {
	return 16
}
pub fn Class_ParagonIE_Sodium_Crypto.secretbox_xsalsa20poly1305_zerobytes() i64 {
	return 32
}
pub fn Class_ParagonIE_Sodium_Crypto.secretbox_xchacha20poly1305_keybytes() i64 {
	return 32
}
pub fn Class_ParagonIE_Sodium_Crypto.secretbox_xchacha20poly1305_noncebytes() i64 {
	return 24
}
pub fn Class_ParagonIE_Sodium_Crypto.secretbox_xchacha20poly1305_macbytes() i64 {
	return 16
}
pub fn Class_ParagonIE_Sodium_Crypto.secretbox_xchacha20poly1305_boxzerobytes() i64 {
	return 16
}
pub fn Class_ParagonIE_Sodium_Crypto.secretbox_xchacha20poly1305_zerobytes() i64 {
	return 32
}
pub fn Class_ParagonIE_Sodium_Crypto.stream_salsa20_keybytes() i64 {
	return 32
}
struct Class_ParagonIE_Sodium_Crypto {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Crypto.aead_chacha20poly1305_decrypt(message string, ad string, nonce string, key string) rt.PhpVal {
	mut nonce_mutated := nonce
	mut var_len := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.strlen(arg_0) }(rt.new_string(message))
	mut var_clen := rt.sub(var_len, Class_ParagonIE_Sodium_Crypto.aead_chacha20poly1305_abytes())
	mut var_adlen := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.strlen(arg_0) }(rt.new_string(ad))
	mut var_mac := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(message), var_clen.dup(), rt.new_int(Class_ParagonIE_Sodium_Crypto.aead_chacha20poly1305_abytes()))
	mut var_ciphertext := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(message), rt.new_int(0), var_clen.dup())
	mut var_block0 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20{}; return temp.stream(arg_0, arg_1, arg_2) }(rt.new_int(32), rt.new_string(nonce_mutated), rt.new_string(key))
	mut var_state := create_paragonie_sodium_core_poly1305_state(var_block0.dup())
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.memzero(arg_0) }(var_block0.dup())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'SodiumException') {
		mut var_ex := var_e_1.dup()
		var_block0 = rt.new_null()
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	rt.call_method(var_state, 'update', [rt.new_string(ad)])
	rt.call_method(var_state, 'update', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.store64_le(arg_0) }(var_adlen.dup())])
	rt.call_method(var_state, 'update', [var_ciphertext.dup()])
	rt.call_method(var_state, 'update', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.store64_le(arg_0) }(var_clen.dup())])
	mut var_computed_mac := rt.call_method(var_state, 'finish', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.verify_16(arg_0, arg_1) }(var_computed_mac.dup(), var_mac.dup()))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Invalid MAC'))))
	}
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20{}; return temp.streamxoric(arg_0, arg_1, arg_2, arg_3) }(var_ciphertext.dup(), rt.new_string(nonce_mutated), rt.new_string(key), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.store64_le(arg_0) }(rt.new_int(1)))
}

fn Class_ParagonIE_Sodium_Crypto.aead_chacha20poly1305_encrypt(message string, ad string, nonce string, key string) string {
	mut nonce_mutated := nonce
	mut var_len := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.strlen(arg_0) }(rt.new_string(message))
	mut var_adlen := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.strlen(arg_0) }(rt.new_string(ad))
	mut var_block0 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20{}; return temp.stream(arg_0, arg_1, arg_2) }(rt.new_int(32), rt.new_string(nonce_mutated), rt.new_string(key))
	mut var_state := create_paragonie_sodium_core_poly1305_state(var_block0.dup())
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.memzero(arg_0) }(var_block0.dup())
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'SodiumException') {
		mut var_ex := var_e_2.dup()
		var_block0 = rt.new_null()
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	mut var_ciphertext := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20{}; return temp.streamxoric(arg_0, arg_1, arg_2, arg_3) }(rt.new_string(message), rt.new_string(nonce_mutated), rt.new_string(key), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.store64_le(arg_0) }(rt.new_int(1)))
	rt.call_method(var_state, 'update', [rt.new_string(ad)])
	rt.call_method(var_state, 'update', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.store64_le(arg_0) }(var_adlen.dup())])
	rt.call_method(var_state, 'update', [var_ciphertext.dup()])
	rt.call_method(var_state, 'update', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.store64_le(arg_0) }(var_len.dup())])
	return (var_ciphertext).str() + (rt.call_method(var_state, 'finish', []rt.PhpVal{})).str()
}

fn Class_ParagonIE_Sodium_Crypto.aead_chacha20poly1305_ietf_decrypt(message string, ad string, nonce string, key string) rt.PhpVal {
	mut nonce_mutated := nonce
	mut var_adlen := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.strlen(arg_0) }(rt.new_string(ad))
	mut var_len := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.strlen(arg_0) }(rt.new_string(message))
	mut var_clen := rt.sub(var_len, Class_ParagonIE_Sodium_Crypto.aead_chacha20poly1305_ietf_abytes())
	mut var_block0 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20{}; return temp.ietfstream(arg_0, arg_1, arg_2) }(rt.new_int(32), rt.new_string(nonce_mutated), rt.new_string(key))
	mut var_mac := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(message), rt.sub(var_len, Class_ParagonIE_Sodium_Crypto.aead_chacha20poly1305_ietf_abytes()), rt.new_int(Class_ParagonIE_Sodium_Crypto.aead_chacha20poly1305_ietf_abytes()))
	mut var_ciphertext := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(message), rt.new_int(0), rt.sub(var_len, Class_ParagonIE_Sodium_Crypto.aead_chacha20poly1305_ietf_abytes()))
	mut var_state := create_paragonie_sodium_core_poly1305_state(var_block0.dup())
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.memzero(arg_0) }(var_block0.dup())
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'SodiumException') {
		mut var_ex := var_e_3.dup()
		var_block0 = rt.new_null()
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	rt.call_method(var_state, 'update', [rt.new_string(ad)])
	rt.call_method(var_state, 'update', [rt.call_function('str_repeat', [rt.new_string(''), rt.bitwise_and(rt.sub(rt.new_int(16), var_adlen), rt.new_int(15))])])
	rt.call_method(var_state, 'update', [var_ciphertext.dup()])
	rt.call_method(var_state, 'update', [rt.call_function('str_repeat', [rt.new_string(''), rt.bitwise_and(rt.sub(rt.new_int(16), var_clen), rt.new_int(15))])])
	rt.call_method(var_state, 'update', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.store64_le(arg_0) }(var_adlen.dup())])
	rt.call_method(var_state, 'update', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.store64_le(arg_0) }(var_clen.dup())])
	mut var_computed_mac := rt.call_method(var_state, 'finish', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.verify_16(arg_0, arg_1) }(var_computed_mac.dup(), var_mac.dup()))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Invalid MAC'))))
	}
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20{}; return temp.ietfstreamxoric(arg_0, arg_1, arg_2, arg_3) }(var_ciphertext.dup(), rt.new_string(nonce_mutated), rt.new_string(key), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.store64_le(arg_0) }(rt.new_int(1)))
}

fn Class_ParagonIE_Sodium_Crypto.aead_chacha20poly1305_ietf_encrypt(message string, ad string, nonce string, key string) string {
	mut nonce_mutated := nonce
	mut var_len := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.strlen(arg_0) }(rt.new_string(message))
	mut var_adlen := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.strlen(arg_0) }(rt.new_string(ad))
	mut var_block0 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20{}; return temp.ietfstream(arg_0, arg_1, arg_2) }(rt.new_int(32), rt.new_string(nonce_mutated), rt.new_string(key))
	mut var_state := create_paragonie_sodium_core_poly1305_state(var_block0.dup())
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.memzero(arg_0) }(var_block0.dup())
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	unsafe { goto end_label_4 }

catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'SodiumException') {
		mut var_ex := var_e_4.dup()
		var_block0 = rt.new_null()
		unsafe { goto end_label_4 }
	}
	else {
		rt.throw_exception(var_e_4)
		unsafe { goto end_label_4 }
	}

end_label_4:
	mut var_ciphertext := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20{}; return temp.ietfstreamxoric(arg_0, arg_1, arg_2, arg_3) }(rt.new_string(message), rt.new_string(nonce_mutated), rt.new_string(key), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.store64_le(arg_0) }(rt.new_int(1)))
	rt.call_method(var_state, 'update', [rt.new_string(ad)])
	rt.call_method(var_state, 'update', [rt.call_function('str_repeat', [rt.new_string(''), rt.bitwise_and(rt.sub(rt.new_int(16), var_adlen), rt.new_int(15))])])
	rt.call_method(var_state, 'update', [var_ciphertext.dup()])
	rt.call_method(var_state, 'update', [rt.call_function('str_repeat', [rt.new_string(''), rt.bitwise_and(rt.sub(rt.new_int(16), var_len), rt.new_int(15))])])
	rt.call_method(var_state, 'update', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.store64_le(arg_0) }(var_adlen.dup())])
	rt.call_method(var_state, 'update', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.store64_le(arg_0) }(var_len.dup())])
	return (var_ciphertext).str() + (rt.call_method(var_state, 'finish', []rt.PhpVal{})).str()
}

fn Class_ParagonIE_Sodium_Crypto.aead_xchacha20poly1305_ietf_decrypt(message string, ad string, nonce string, key string) rt.PhpVal {
	mut nonce_mutated := nonce
	mut var_subkey := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.hchacha20(arg_0, arg_1) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(nonce_mutated), rt.new_int(0), rt.new_int(16)), rt.new_string(key))
	mut var_nonceLast := rt.new_string('' + (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(nonce_mutated), rt.new_int(16), rt.new_int(8))).str())
	return Class_ParagonIE_Sodium_Crypto.aead_chacha20poly1305_ietf_decrypt(message, ad, (var_nonceLast).str(), (var_subkey).str())
}

fn Class_ParagonIE_Sodium_Crypto.aead_xchacha20poly1305_ietf_encrypt(message string, ad string, nonce string, key string) rt.PhpVal {
	mut nonce_mutated := nonce
	mut var_subkey := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.hchacha20(arg_0, arg_1) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(nonce_mutated), rt.new_int(0), rt.new_int(16)), rt.new_string(key))
	mut var_nonceLast := rt.new_string('' + (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(nonce_mutated), rt.new_int(16), rt.new_int(8))).str())
	return Class_ParagonIE_Sodium_Crypto.aead_chacha20poly1305_ietf_encrypt(message, ad, (var_nonceLast).str(), (var_subkey).str())
}

fn Class_ParagonIE_Sodium_Crypto.auth(var_message rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.call_function('hash_hmac', [rt.new_string('sha512'), var_message.dup(), var_key.dup(), rt.new_bool(true)]), rt.new_int(0), rt.new_int(32))
}

fn Class_ParagonIE_Sodium_Crypto.auth_verify(var_mac rt.PhpVal, var_message rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut var_mac_mutated := var_mac
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.hashequals(arg_0, arg_1) }(var_mac_mutated.dup(), Class_ParagonIE_Sodium_Crypto.auth(var_message.dup(), var_key.dup()))
}

fn Class_ParagonIE_Sodium_Crypto.box(var_plaintext rt.PhpVal, var_nonce rt.PhpVal, var_keypair rt.PhpVal) rt.PhpVal {
	mut var_nonce_mutated := var_nonce
	mut var_keypair_mutated := var_keypair
	mut var_c := Class_ParagonIE_Sodium_Crypto.secretbox(var_plaintext.dup(), var_nonce_mutated.dup(), Class_ParagonIE_Sodium_Crypto.box_beforenm(Class_ParagonIE_Sodium_Crypto.box_secretkey(var_keypair_mutated.dup()), Class_ParagonIE_Sodium_Crypto.box_publickey(var_keypair_mutated.dup())))
	return var_c.dup()
}

fn Class_ParagonIE_Sodium_Crypto.box_seal(var_message rt.PhpVal, var_publicKey rt.PhpVal) string {
	mut var_publicKey_mutated := var_publicKey
	mut var_ephemeralKeypair := Class_ParagonIE_Sodium_Crypto.box_keypair()
	mut var_ephemeralSK := Class_ParagonIE_Sodium_Crypto.box_secretkey(var_ephemeralKeypair.dup())
	mut var_ephemeralPK := Class_ParagonIE_Sodium_Crypto.box_publickey(var_ephemeralKeypair.dup())
	mut var_nonce := Class_ParagonIE_Sodium_Crypto.generichash((var_ephemeralPK).str() + (var_publicKey_mutated).str(), '', rt.new_int(24))
	mut var_keypair := Class_ParagonIE_Sodium_Crypto.box_keypair_from_secretkey_and_publickey(var_ephemeralSK.dup(), var_publicKey_mutated.dup())
	mut var_ciphertext := Class_ParagonIE_Sodium_Crypto.box(var_message.dup(), var_nonce.dup(), var_keypair.dup())
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.memzero(arg_0) }(var_ephemeralKeypair.dup())
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.memzero(arg_0) }(var_ephemeralSK.dup())
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.memzero(arg_0) }(var_nonce.dup())
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	unsafe { goto end_label_5 }

catch_label_5:
	mut var_e_5 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_5, 'SodiumException') {
		mut var_ex := var_e_5.dup()
		var_ephemeralKeypair = rt.new_null()
		var_ephemeralSK = rt.new_null()
		var_nonce = rt.new_null()
		unsafe { goto end_label_5 }
	}
	else {
		rt.throw_exception(var_e_5)
		unsafe { goto end_label_5 }
	}

end_label_5:
	return (var_ephemeralPK).str() + (var_ciphertext).str()
}

fn Class_ParagonIE_Sodium_Crypto.box_seal_open(var_message rt.PhpVal, var_keypair rt.PhpVal) rt.PhpVal {
	mut var_keypair_mutated := var_keypair
	mut var_ephemeralPK := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.substr(arg_0, arg_1, arg_2) }(var_message.dup(), rt.new_int(0), rt.new_int(32))
	mut var_ciphertext := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.substr(arg_0, arg_1) }(var_message.dup(), rt.new_int(32))
	mut var_secretKey := Class_ParagonIE_Sodium_Crypto.box_secretkey(var_keypair_mutated.dup())
	mut var_publicKey := Class_ParagonIE_Sodium_Crypto.box_publickey(var_keypair_mutated.dup())
	mut var_nonce := Class_ParagonIE_Sodium_Crypto.generichash((var_ephemeralPK).str() + (var_publicKey).str(), '', rt.new_int(24))
	var_keypair_mutated = Class_ParagonIE_Sodium_Crypto.box_keypair_from_secretkey_and_publickey(var_secretKey.dup(), var_ephemeralPK.dup())
	mut var_m := Class_ParagonIE_Sodium_Crypto.box_open(var_ciphertext.dup(), var_nonce.dup(), var_keypair_mutated.dup())
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.memzero(arg_0) }(.dup())
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	unsafe { goto end_label_6 }

catch_label_6:
	mut var_e_6 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_6, 'SodiumException') {
		mut var_ex := var_e_6.dup()
		unsafe { goto end_label_6 }
	}
	else {
		rt.throw_exception(var_e_6)
		unsafe { goto end_label_6 }
	}

end_label_6:
}

fn Class_ParagonIE_Sodium_Crypto.box_beforenm(var_sk rt.PhpVal, var_pk rt.PhpVal) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Crypto.box_keypair() string {
}

fn Class_ParagonIE_Sodium_Crypto.box_seed_keypair(var_seed rt.PhpVal) string {
}

fn Class_ParagonIE_Sodium_Crypto.box_keypair_from_secretkey_and_publickey(var_sKey rt.PhpVal, var_pKey rt.PhpVal) string {
	mut var_sKey_mutated := var_sKey
	mut var_pKey_mutated := var_pKey
}

fn Class_ParagonIE_Sodium_Crypto.box_secretkey(var_keypair rt.PhpVal) rt.PhpVal {
	mut var_keypair_mutated := var_keypair
}

fn Class_ParagonIE_Sodium_Crypto.box_publickey(var_keypair rt.PhpVal) rt.PhpVal {
	mut var_keypair_mutated := var_keypair
}

fn Class_ParagonIE_Sodium_Crypto.box_publickey_from_secretkey(var_sKey rt.PhpVal) rt.PhpVal {
	mut var_sKey_mutated := var_sKey
}

fn Class_ParagonIE_Sodium_Crypto.box_open(var_ciphertext rt.PhpVal, var_nonce rt.PhpVal, var_keypair rt.PhpVal) rt.PhpVal {
	mut var_ciphertext_mutated := var_ciphertext
	mut var_nonce_mutated := var_nonce
	mut var_keypair_mutated := var_keypair
}

fn Class_ParagonIE_Sodium_Crypto.generichash(var_message rt.PhpVal, key string, outlen i64) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Crypto.generichash_final(var_ctx rt.PhpVal, outlen i64) rt.PhpVal {
	mut var_ctx_mutated := var_ctx
}

fn Class_ParagonIE_Sodium_Crypto.generichash_init(key string, outputLength i64) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Crypto.generichash_init_salt_personal(key string, outputLength i64, salt string, personal string) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Crypto.generichash_update(var_ctx rt.PhpVal, var_message rt.PhpVal) rt.PhpVal {
	mut var_ctx_mutated := var_ctx
}

fn Class_ParagonIE_Sodium_Crypto.keyexchange(var_my_sk rt.PhpVal, var_their_pk rt.PhpVal, var_client_pk rt.PhpVal, var_server_pk rt.PhpVal) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Crypto.scalarmult(var_sKey rt.PhpVal, var_pKey rt.PhpVal) rt.PhpVal {
	mut var_sKey_mutated := var_sKey
	mut var_pKey_mutated := var_pKey
}

fn Class_ParagonIE_Sodium_Crypto.scalarmult_base(var_secret rt.PhpVal) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Crypto.scalarmult_throw_if_zero(var_q rt.PhpVal)  {
	mut var_q_mutated := var_q
}

fn Class_ParagonIE_Sodium_Crypto.secretbox(var_plaintext rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut var_nonce_mutated := var_nonce
}

fn Class_ParagonIE_Sodium_Crypto.secretbox_open(var_ciphertext rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut var_ciphertext_mutated := var_ciphertext
	mut var_nonce_mutated := var_nonce
}

fn Class_ParagonIE_Sodium_Crypto.secretbox_xchacha20poly1305(var_plaintext rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut var_nonce_mutated := var_nonce
}

fn Class_ParagonIE_Sodium_Crypto.secretbox_xchacha20poly1305_open(var_ciphertext rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut var_ciphertext_mutated := var_ciphertext
	mut var_nonce_mutated := var_nonce
}

fn Class_ParagonIE_Sodium_Crypto.secretstream_xchacha20poly1305_init_push(var_key rt.PhpVal) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Crypto.secretstream_xchacha20poly1305_init_pull(var_key rt.PhpVal, var_header rt.PhpVal) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Crypto.secretstream_xchacha20poly1305_push(var_state rt.PhpVal, var_msg rt.PhpVal, aad string, tag i64) rt.PhpVal {
	mut var_state_mutated := var_state
	mut tag_mutated := tag
}

fn Class_ParagonIE_Sodium_Crypto.secretstream_xchacha20poly1305_pull(var_state rt.PhpVal, var_cipher rt.PhpVal, aad string) rt.PhpVal {
	mut var_state_mutated := var_state
	mut var_cipher_mutated := var_cipher
}

fn Class_ParagonIE_Sodium_Crypto.secretstream_xchacha20poly1305_rekey(var_state rt.PhpVal)  {
	mut var_state_mutated := var_state
}

fn Class_ParagonIE_Sodium_Crypto.sign_detached(var_message rt.PhpVal, var_sk rt.PhpVal) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Crypto.sign(var_message rt.PhpVal, var_sk rt.PhpVal) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Crypto.sign_open(var_signedMessage rt.PhpVal, var_pk rt.PhpVal) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Crypto.sign_verify_detached(var_signature rt.PhpVal, var_message rt.PhpVal, var_pk rt.PhpVal) rt.PhpVal {
}

struct Class_ParagonIE_Sodium_Core_Util {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core_ChaCha20 {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core_Poly1305_State {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Compat {
	rt.PhpObjectBase
}

struct Class_SodiumException {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core_HChaCha20 {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_crypto() &Class_ParagonIE_Sodium_Crypto {
	mut obj := &Class_ParagonIE_Sodium_Crypto{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_util() &Class_ParagonIE_Sodium_Core_Util {
	mut obj := &Class_ParagonIE_Sodium_Core_Util{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_chacha20() &Class_ParagonIE_Sodium_Core_ChaCha20 {
	mut obj := &Class_ParagonIE_Sodium_Core_ChaCha20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_poly1305_state() &Class_ParagonIE_Sodium_Core_Poly1305_State {
	mut obj := &Class_ParagonIE_Sodium_Core_Poly1305_State{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_compat() &Class_ParagonIE_Sodium_Compat {
	mut obj := &Class_ParagonIE_Sodium_Compat{
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

fn create_paragonie_sodium_core_hchacha20() &Class_ParagonIE_Sodium_Core_HChaCha20 {
	mut obj := &Class_ParagonIE_Sodium_Core_HChaCha20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Crypto) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'aead_chacha20poly1305_decrypt' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Crypto.aead_chacha20poly1305_decrypt(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'aead_chacha20poly1305_encrypt' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return rt.new_string(Class_ParagonIE_Sodium_Crypto.aead_chacha20poly1305_encrypt(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'aead_chacha20poly1305_ietf_decrypt' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Crypto.aead_chacha20poly1305_ietf_decrypt(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'aead_chacha20poly1305_ietf_encrypt' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return rt.new_string(Class_ParagonIE_Sodium_Crypto.aead_chacha20poly1305_ietf_encrypt(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'aead_xchacha20poly1305_ietf_decrypt' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Crypto.aead_xchacha20poly1305_ietf_decrypt(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'aead_xchacha20poly1305_ietf_encrypt' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Crypto.aead_xchacha20poly1305_ietf_encrypt(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'auth' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto.auth(dispatch_arg_0, dispatch_arg_1)
		}
		'auth_verify' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto.auth_verify(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'box' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto.box(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'box_seal' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_ParagonIE_Sodium_Crypto.box_seal(dispatch_arg_0, dispatch_arg_1))
		}
		'box_seal_open' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto.box_seal_open(dispatch_arg_0, dispatch_arg_1)
		}
		'box_beforenm' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto.box_beforenm(dispatch_arg_0, dispatch_arg_1)
		}
		'box_keypair' {
			return rt.new_string(Class_ParagonIE_Sodium_Crypto.box_keypair())
		}
		'box_seed_keypair' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_ParagonIE_Sodium_Crypto.box_seed_keypair(dispatch_arg_0))
		}
		'box_keypair_from_secretkey_and_publickey' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_ParagonIE_Sodium_Crypto.box_keypair_from_secretkey_and_publickey(dispatch_arg_0, dispatch_arg_1))
		}
		'box_secretkey' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto.box_secretkey(dispatch_arg_0)
		}
		'box_publickey' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto.box_publickey(dispatch_arg_0)
		}
		'box_publickey_from_secretkey' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto.box_publickey_from_secretkey(dispatch_arg_0)
		}
		'box_open' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto.box_open(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'generichash' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return Class_ParagonIE_Sodium_Crypto.generichash(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'generichash_final' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_ParagonIE_Sodium_Crypto.generichash_final(dispatch_arg_0, dispatch_arg_1)
		}
		'generichash_init' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_ParagonIE_Sodium_Crypto.generichash_init(dispatch_arg_0, dispatch_arg_1)
		}
		'generichash_init_salt_personal' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Crypto.generichash_init_salt_personal(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'generichash_update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto.generichash_update(dispatch_arg_0, dispatch_arg_1)
		}
		'keyExchange' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto.keyexchange(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'scalarmult' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto.scalarmult(dispatch_arg_0, dispatch_arg_1)
		}
		'scalarmult_base' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto.scalarmult_base(dispatch_arg_0)
		}
		'scalarmult_throw_if_zero' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_ParagonIE_Sodium_Crypto.scalarmult_throw_if_zero(dispatch_arg_0)
			return rt.new_null()
		}
		'secretbox' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto.secretbox(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'secretbox_open' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto.secretbox_open(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'secretbox_xchacha20poly1305' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto.secretbox_xchacha20poly1305(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'secretbox_xchacha20poly1305_open' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto.secretbox_xchacha20poly1305_open(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'secretstream_xchacha20poly1305_init_push' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto.secretstream_xchacha20poly1305_init_push(dispatch_arg_0)
		}
		'secretstream_xchacha20poly1305_init_pull' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto.secretstream_xchacha20poly1305_init_pull(dispatch_arg_0, dispatch_arg_1)
		}
		'secretstream_xchacha20poly1305_push' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			return Class_ParagonIE_Sodium_Crypto.secretstream_xchacha20poly1305_push(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'secretstream_xchacha20poly1305_pull' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Crypto.secretstream_xchacha20poly1305_pull(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'secretstream_xchacha20poly1305_rekey' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_ParagonIE_Sodium_Crypto.secretstream_xchacha20poly1305_rekey(dispatch_arg_0)
			return rt.new_null()
		}
		'sign_detached' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto.sign_detached(dispatch_arg_0, dispatch_arg_1)
		}
		'sign' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto.sign(dispatch_arg_0, dispatch_arg_1)
		}
		'sign_open' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto.sign_open(dispatch_arg_0, dispatch_arg_1)
		}
		'sign_verify_detached' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto.sign_verify_detached(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_ParagonIE_Sodium_Crypto) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Crypto) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_ChaCha20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ParagonIE_Sodium_Core_Poly1305_State) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_Poly1305_State) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Poly1305_State) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_SodiumException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SodiumException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SodiumException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_sodium_compat_src_crypto_php() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_Crypto'), rt.new_bool(false)])) {
		return rt.new_null()
	}
}
