import rt

pub fn Class_ParagonIE_Sodium_Crypto32.aead_chacha20poly1305_keybytes() i64 {
	return 32
}

pub fn Class_ParagonIE_Sodium_Crypto32.aead_chacha20poly1305_nsecbytes() i64 {
	return 0
}

pub fn Class_ParagonIE_Sodium_Crypto32.aead_chacha20poly1305_npubbytes() i64 {
	return 8
}

pub fn Class_ParagonIE_Sodium_Crypto32.aead_chacha20poly1305_abytes() i64 {
	return 16
}

pub fn Class_ParagonIE_Sodium_Crypto32.aead_chacha20poly1305_ietf_keybytes() i64 {
	return 32
}

pub fn Class_ParagonIE_Sodium_Crypto32.aead_chacha20poly1305_ietf_nsecbytes() i64 {
	return 0
}

pub fn Class_ParagonIE_Sodium_Crypto32.aead_chacha20poly1305_ietf_npubbytes() i64 {
	return 12
}

pub fn Class_ParagonIE_Sodium_Crypto32.aead_chacha20poly1305_ietf_abytes() i64 {
	return 16
}

pub fn Class_ParagonIE_Sodium_Crypto32.aead_xchacha20poly1305_ietf_keybytes() i64 {
	return 32
}

pub fn Class_ParagonIE_Sodium_Crypto32.aead_xchacha20poly1305_ietf_nsecbytes() i64 {
	return 0
}

pub fn Class_ParagonIE_Sodium_Crypto32.aead_xchacha20poly1305_ietf_npubbytes() i64 {
	return 24
}

pub fn Class_ParagonIE_Sodium_Crypto32.aead_xchacha20poly1305_ietf_abytes() i64 {
	return 16
}

pub fn Class_ParagonIE_Sodium_Crypto32.box_curve25519xsalsa20poly1305_seedbytes() i64 {
	return 32
}

pub fn Class_ParagonIE_Sodium_Crypto32.box_curve25519xsalsa20poly1305_publickeybytes() i64 {
	return 32
}

pub fn Class_ParagonIE_Sodium_Crypto32.box_curve25519xsalsa20poly1305_secretkeybytes() i64 {
	return 32
}

pub fn Class_ParagonIE_Sodium_Crypto32.box_curve25519xsalsa20poly1305_beforenmbytes() i64 {
	return 32
}

pub fn Class_ParagonIE_Sodium_Crypto32.box_curve25519xsalsa20poly1305_noncebytes() i64 {
	return 24
}

pub fn Class_ParagonIE_Sodium_Crypto32.box_curve25519xsalsa20poly1305_macbytes() i64 {
	return 16
}

pub fn Class_ParagonIE_Sodium_Crypto32.box_curve25519xsalsa20poly1305_boxzerobytes() i64 {
	return 16
}

pub fn Class_ParagonIE_Sodium_Crypto32.box_curve25519xsalsa20poly1305_zerobytes() i64 {
	return 32
}

pub fn Class_ParagonIE_Sodium_Crypto32.onetimeauth_poly1305_bytes() i64 {
	return 16
}

pub fn Class_ParagonIE_Sodium_Crypto32.onetimeauth_poly1305_keybytes() i64 {
	return 32
}

pub fn Class_ParagonIE_Sodium_Crypto32.secretbox_xsalsa20poly1305_keybytes() i64 {
	return 32
}

pub fn Class_ParagonIE_Sodium_Crypto32.secretbox_xsalsa20poly1305_noncebytes() i64 {
	return 24
}

pub fn Class_ParagonIE_Sodium_Crypto32.secretbox_xsalsa20poly1305_macbytes() i64 {
	return 16
}

pub fn Class_ParagonIE_Sodium_Crypto32.secretbox_xsalsa20poly1305_boxzerobytes() i64 {
	return 16
}

pub fn Class_ParagonIE_Sodium_Crypto32.secretbox_xsalsa20poly1305_zerobytes() i64 {
	return 32
}

pub fn Class_ParagonIE_Sodium_Crypto32.secretbox_xchacha20poly1305_keybytes() i64 {
	return 32
}

pub fn Class_ParagonIE_Sodium_Crypto32.secretbox_xchacha20poly1305_noncebytes() i64 {
	return 24
}

pub fn Class_ParagonIE_Sodium_Crypto32.secretbox_xchacha20poly1305_macbytes() i64 {
	return 16
}

pub fn Class_ParagonIE_Sodium_Crypto32.secretbox_xchacha20poly1305_boxzerobytes() i64 {
	return 16
}

pub fn Class_ParagonIE_Sodium_Crypto32.secretbox_xchacha20poly1305_zerobytes() i64 {
	return 32
}

pub fn Class_ParagonIE_Sodium_Crypto32.stream_salsa20_keybytes() i64 {
	return 32
}

struct Class_ParagonIE_Sodium_Crypto32 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Crypto32.aead_chacha20poly1305_decrypt(message string, ad string, nonce string, key string) rt.PhpVal {
	mut nonce_mutated := nonce
	mut iife_temp_0 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_0 := iife_temp_0.strlen(rt.new_string(message))
	mut var_len := iife_result_0
	mut var_clen := rt.sub(var_len, Class_ParagonIE_Sodium_Crypto32.aead_chacha20poly1305_abytes())
	mut iife_temp_1 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_1 := iife_temp_1.strlen(rt.new_string(ad))
	mut var_adlen := iife_result_1
	mut iife_temp_2 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_2 := iife_temp_2.substr(rt.new_string(message), var_clen.clone(),
		rt.new_int(Class_ParagonIE_Sodium_Crypto32.aead_chacha20poly1305_abytes()))
	mut var_mac := iife_result_2
	mut iife_temp_3 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_3 := iife_temp_3.substr(rt.new_string(message), rt.new_int(0), var_clen.clone())
	mut var_ciphertext := iife_result_3
	mut iife_temp_4 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
	mut iife_result_4 := iife_temp_4.stream(rt.new_int(32), rt.new_string(nonce_mutated),
		rt.new_string(key))
	mut var_block0 := iife_result_4
	mut var_state := create_paragonie_sodium_core32_poly1305_state(var_block0.clone())
	mut iife_temp_5 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_5 := iife_temp_5.memzero(var_block0.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'SodiumException') {
		mut var_ex := var_e_1.clone()
		var_block0 = rt.new_null()
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	rt.call_method(var_state, 'update', [rt.new_string(ad)])
	mut iife_temp_6 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_6 := iife_temp_6.store64_le(var_adlen.clone())
	rt.call_method(var_state, 'update', [iife_result_6])
	rt.call_method(var_state, 'update', [var_ciphertext.clone()])
	mut iife_temp_7 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_7 := iife_temp_7.store64_le(var_clen.clone())
	rt.call_method(var_state, 'update', [iife_result_7])
	mut var_computed_mac := rt.call_method(var_state, 'finish', []rt.PhpVal{})
	mut iife_temp_8 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_8 := iife_temp_8.verify_16(var_computed_mac.clone(), var_mac.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_8)))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Invalid MAC'))))
	}
	mut iife_temp_9 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_9 := iife_temp_9.store64_le(rt.new_int(1))
	mut iife_temp_10 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
	mut iife_result_10 := iife_temp_10.streamxoric(var_ciphertext.clone(),
		rt.new_string(nonce_mutated), rt.new_string(key), iife_result_9)
	return iife_result_10
}

fn Class_ParagonIE_Sodium_Crypto32.aead_chacha20poly1305_encrypt(message string, ad string, nonce string, key string) string {
	mut nonce_mutated := nonce
	mut iife_temp_11 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_11 := iife_temp_11.strlen(rt.new_string(message))
	mut var_len := iife_result_11
	mut iife_temp_12 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_12 := iife_temp_12.strlen(rt.new_string(ad))
	mut var_adlen := iife_result_12
	mut iife_temp_13 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
	mut iife_result_13 := iife_temp_13.stream(rt.new_int(32), rt.new_string(nonce_mutated),
		rt.new_string(key))
	mut var_block0 := iife_result_13
	mut var_state := create_paragonie_sodium_core32_poly1305_state(var_block0.clone())
	mut iife_temp_14 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_14 := iife_temp_14.memzero(var_block0.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'SodiumException') {
		mut var_ex := var_e_2.clone()
		var_block0 = rt.new_null()
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
	}

	end_label_2:
	mut iife_temp_15 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_15 := iife_temp_15.store64_le(rt.new_int(1))
	mut iife_temp_16 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
	mut iife_result_16 := iife_temp_16.streamxoric(rt.new_string(message),
		rt.new_string(nonce_mutated), rt.new_string(key), iife_result_15)
	mut var_ciphertext := iife_result_16
	rt.call_method(var_state, 'update', [rt.new_string(ad)])
	mut iife_temp_17 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_17 := iife_temp_17.store64_le(var_adlen.clone())
	rt.call_method(var_state, 'update', [iife_result_17])
	rt.call_method(var_state, 'update', [var_ciphertext.clone()])
	mut iife_temp_18 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_18 := iife_temp_18.store64_le(var_len.clone())
	rt.call_method(var_state, 'update', [iife_result_18])
	return var_ciphertext.str() + (rt.call_method(var_state, 'finish', []rt.PhpVal{})).str()
}

fn Class_ParagonIE_Sodium_Crypto32.aead_chacha20poly1305_ietf_decrypt(message string, ad string, nonce string, key string) rt.PhpVal {
	mut nonce_mutated := nonce
	mut iife_temp_19 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_19 := iife_temp_19.strlen(rt.new_string(ad))
	mut var_adlen := iife_result_19
	mut iife_temp_20 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_20 := iife_temp_20.strlen(rt.new_string(message))
	mut var_len := iife_result_20
	mut var_clen := rt.sub(var_len,
		Class_ParagonIE_Sodium_Crypto32.aead_chacha20poly1305_ietf_abytes())
	mut iife_temp_21 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
	mut iife_result_21 := iife_temp_21.ietfstream(rt.new_int(32), rt.new_string(nonce_mutated),
		rt.new_string(key))
	mut var_block0 := iife_result_21
	mut iife_temp_22 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_22 := iife_temp_22.substr(rt.new_string(message), rt.sub(var_len,
		Class_ParagonIE_Sodium_Crypto32.aead_chacha20poly1305_ietf_abytes()),
		rt.new_int(Class_ParagonIE_Sodium_Crypto32.aead_chacha20poly1305_ietf_abytes()))
	mut var_mac := iife_result_22
	mut iife_temp_23 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_23 := iife_temp_23.substr(rt.new_string(message), rt.new_int(0), rt.sub(var_len,
		Class_ParagonIE_Sodium_Crypto32.aead_chacha20poly1305_ietf_abytes()))
	mut var_ciphertext := iife_result_23
	mut var_state := create_paragonie_sodium_core32_poly1305_state(var_block0.clone())
	mut iife_temp_24 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_24 := iife_temp_24.memzero(var_block0.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	unsafe {
		goto end_label_3
	}
	catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'SodiumException') {
		mut var_ex := var_e_3.clone()
		var_block0 = rt.new_null()
		unsafe {
			goto end_label_3
		}
	} else {
		rt.throw_exception(var_e_3)
		unsafe {
			goto end_label_3
		}
	}

	end_label_3:
	rt.call_method(var_state, 'update', [rt.new_string(ad)])
	rt.call_method(var_state, 'update', [
		rt.call_function('str_repeat', [rt.new_string(''),
			rt.bitwise_and(rt.sub(rt.new_int(16), var_adlen), rt.new_int(15))]),
	])
	rt.call_method(var_state, 'update', [var_ciphertext.clone()])
	rt.call_method(var_state, 'update', [
		rt.call_function('str_repeat', [rt.new_string(''),
			rt.bitwise_and(rt.sub(rt.new_int(16), var_clen), rt.new_int(15))]),
	])
	mut iife_temp_25 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_25 := iife_temp_25.store64_le(var_adlen.clone())
	rt.call_method(var_state, 'update', [iife_result_25])
	mut iife_temp_26 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_26 := iife_temp_26.store64_le(var_clen.clone())
	rt.call_method(var_state, 'update', [iife_result_26])
	mut var_computed_mac := rt.call_method(var_state, 'finish', []rt.PhpVal{})
	mut iife_temp_27 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_27 := iife_temp_27.verify_16(var_computed_mac.clone(), var_mac.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_27)))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Invalid MAC'))))
	}
	mut iife_temp_28 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_28 := iife_temp_28.store64_le(rt.new_int(1))
	mut iife_temp_29 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
	mut iife_result_29 := iife_temp_29.ietfstreamxoric(var_ciphertext.clone(),
		rt.new_string(nonce_mutated), rt.new_string(key), iife_result_28)
	return iife_result_29
}

fn Class_ParagonIE_Sodium_Crypto32.aead_chacha20poly1305_ietf_encrypt(message string, ad string, nonce string, key string) string {
	mut nonce_mutated := nonce
	mut iife_temp_30 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_30 := iife_temp_30.strlen(rt.new_string(message))
	mut var_len := iife_result_30
	mut iife_temp_31 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_31 := iife_temp_31.strlen(rt.new_string(ad))
	mut var_adlen := iife_result_31
	mut iife_temp_32 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
	mut iife_result_32 := iife_temp_32.ietfstream(rt.new_int(32), rt.new_string(nonce_mutated),
		rt.new_string(key))
	mut var_block0 := iife_result_32
	mut var_state := create_paragonie_sodium_core32_poly1305_state(var_block0.clone())
	mut iife_temp_33 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_33 := iife_temp_33.memzero(var_block0.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_4
		}
	}
	unsafe {
		goto end_label_4
	}
	catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'SodiumException') {
		mut var_ex := var_e_4.clone()
		var_block0 = rt.new_null()
		unsafe {
			goto end_label_4
		}
	} else {
		rt.throw_exception(var_e_4)
		unsafe {
			goto end_label_4
		}
	}

	end_label_4:
	mut iife_temp_34 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_34 := iife_temp_34.store64_le(rt.new_int(1))
	mut iife_temp_35 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
	mut iife_result_35 := iife_temp_35.ietfstreamxoric(rt.new_string(message),
		rt.new_string(nonce_mutated), rt.new_string(key), iife_result_34)
	mut var_ciphertext := iife_result_35
	rt.call_method(var_state, 'update', [rt.new_string(ad)])
	rt.call_method(var_state, 'update', [
		rt.call_function('str_repeat', [rt.new_string(''),
			rt.bitwise_and(rt.sub(rt.new_int(16), var_adlen), rt.new_int(15))]),
	])
	rt.call_method(var_state, 'update', [var_ciphertext.clone()])
	rt.call_method(var_state, 'update', [
		rt.call_function('str_repeat', [rt.new_string(''),
			rt.bitwise_and(rt.sub(rt.new_int(16), var_len), rt.new_int(15))]),
	])
	mut iife_temp_36 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_36 := iife_temp_36.store64_le(var_adlen.clone())
	rt.call_method(var_state, 'update', [iife_result_36])
	mut iife_temp_37 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_37 := iife_temp_37.store64_le(var_len.clone())
	rt.call_method(var_state, 'update', [iife_result_37])
	return var_ciphertext.str() + (rt.call_method(var_state, 'finish', []rt.PhpVal{})).str()
}

fn Class_ParagonIE_Sodium_Crypto32.aead_xchacha20poly1305_ietf_decrypt(message string, ad string, nonce string, key string) rt.PhpVal {
	mut nonce_mutated := nonce
	mut iife_temp_38 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_38 := iife_temp_38.substr(rt.new_string(nonce_mutated), rt.new_int(0),
		rt.new_int(16))
	mut iife_temp_39 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
	mut iife_result_39 := iife_temp_39.hchacha20(iife_result_38, rt.new_string(key))
	mut var_subkey := iife_result_39
	mut iife_temp_40 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_40 := iife_temp_40.substr(rt.new_string(nonce_mutated), rt.new_int(16),
		rt.new_int(8))
	mut var_nonceLast := rt.new_string('' + iife_result_40.str())
	return Class_ParagonIE_Sodium_Crypto32.aead_chacha20poly1305_ietf_decrypt(message, ad,
		var_nonceLast.str(), var_subkey.str())
}

fn Class_ParagonIE_Sodium_Crypto32.aead_xchacha20poly1305_ietf_encrypt(message string, ad string, nonce string, key string) rt.PhpVal {
	mut nonce_mutated := nonce
	mut iife_temp_41 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_41 := iife_temp_41.substr(rt.new_string(nonce_mutated), rt.new_int(0),
		rt.new_int(16))
	mut iife_temp_42 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
	mut iife_result_42 := iife_temp_42.hchacha20(iife_result_41, rt.new_string(key))
	mut var_subkey := iife_result_42
	mut iife_temp_43 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_43 := iife_temp_43.substr(rt.new_string(nonce_mutated), rt.new_int(16),
		rt.new_int(8))
	mut var_nonceLast := rt.new_string('' + iife_result_43.str())
	return Class_ParagonIE_Sodium_Crypto32.aead_chacha20poly1305_ietf_encrypt(message, ad,
		var_nonceLast.str(), var_subkey.str())
}

fn Class_ParagonIE_Sodium_Crypto32.auth(var_message rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_44 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_44 := iife_temp_44.substr(rt.call_function('hash_hmac', [
		rt.new_string('sha512'),
		var_message.clone(),
		var_key.clone(),
		rt.new_bool(true),
	]), rt.new_int(0), rt.new_int(32))
	return iife_result_44
}

fn Class_ParagonIE_Sodium_Crypto32.auth_verify(var_mac rt.PhpVal, var_message rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut var_mac_mutated := var_mac
	mut iife_temp_45 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_45 := iife_temp_45.hashequals(var_mac_mutated.clone(), Class_ParagonIE_Sodium_Crypto32.auth(var_message.clone(),
		var_key.clone()))
	return iife_result_45
}

fn Class_ParagonIE_Sodium_Crypto32.box(var_plaintext rt.PhpVal, var_nonce rt.PhpVal, var_keypair rt.PhpVal) rt.PhpVal {
	mut var_nonce_mutated := var_nonce
	mut var_keypair_mutated := var_keypair
	return Class_ParagonIE_Sodium_Crypto32.secretbox(var_plaintext.clone(),
		var_nonce_mutated.clone(), Class_ParagonIE_Sodium_Crypto32.box_beforenm(Class_ParagonIE_Sodium_Crypto32.box_secretkey(var_keypair_mutated.clone()),
		Class_ParagonIE_Sodium_Crypto32.box_publickey(var_keypair_mutated.clone())))
}

fn Class_ParagonIE_Sodium_Crypto32.box_seal(var_message rt.PhpVal, var_publicKey rt.PhpVal) string {
	mut var_publicKey_mutated := var_publicKey
	mut var_ephemeralKeypair := Class_ParagonIE_Sodium_Crypto32.box_keypair()
	mut var_ephemeralSK :=
		Class_ParagonIE_Sodium_Crypto32.box_secretkey(var_ephemeralKeypair.clone())
	mut var_ephemeralPK :=
		Class_ParagonIE_Sodium_Crypto32.box_publickey(var_ephemeralKeypair.clone())
	mut var_nonce := Class_ParagonIE_Sodium_Crypto32.generichash(var_ephemeralPK.str() +
		var_publicKey_mutated.str(), '', rt.new_int(24))
	mut var_keypair := Class_ParagonIE_Sodium_Crypto32.box_keypair_from_secretkey_and_publickey(var_ephemeralSK.clone(),
		var_publicKey_mutated.clone())
	mut var_ciphertext := Class_ParagonIE_Sodium_Crypto32.box(var_message.clone(),
		var_nonce.clone(), var_keypair.clone())
	mut iife_temp_46 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_46 := iife_temp_46.memzero(var_ephemeralKeypair.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_5
		}
	}
	mut iife_temp_47 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_47 := iife_temp_47.memzero(var_ephemeralSK.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_5
		}
	}
	mut iife_temp_48 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_48 := iife_temp_48.memzero(var_nonce.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_5
		}
	}
	unsafe {
		goto end_label_5
	}
	catch_label_5:
	mut var_e_5 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_5, 'SodiumException') {
		mut var_ex := var_e_5.clone()
		var_ephemeralKeypair = rt.new_null()
		var_ephemeralSK = rt.new_null()
		var_nonce = rt.new_null()
		unsafe {
			goto end_label_5
		}
	} else {
		rt.throw_exception(var_e_5)
		unsafe {
			goto end_label_5
		}
	}

	end_label_5:
	return var_ephemeralPK.str() + var_ciphertext.str()
}

fn Class_ParagonIE_Sodium_Crypto32.box_seal_open(var_message rt.PhpVal, var_keypair rt.PhpVal) rt.PhpVal {
	mut var_keypair_mutated := var_keypair
	mut iife_temp_49 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_49 := iife_temp_49.substr(var_message.clone(), rt.new_int(0), rt.new_int(32))
	mut var_ephemeralPK := iife_result_49
	mut iife_temp_50 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_50 := iife_temp_50.substr(var_message.clone(), rt.new_int(32))
	mut var_ciphertext := iife_result_50
	mut var_secretKey := Class_ParagonIE_Sodium_Crypto32.box_secretkey(var_keypair_mutated.clone())
	mut var_publicKey := Class_ParagonIE_Sodium_Crypto32.box_publickey(var_keypair_mutated.clone())
	mut var_nonce := Class_ParagonIE_Sodium_Crypto32.generichash(var_ephemeralPK.str() +
		var_publicKey.str(), '', rt.new_int(24))
	var_keypair_mutated = Class_ParagonIE_Sodium_Crypto32.box_keypair_from_secretkey_and_publickey(var_secretKey.clone(),
		var_ephemeralPK.clone())
	mut var_m := Class_ParagonIE_Sodium_Crypto32.box_open(var_ciphertext.clone(),
		var_nonce.clone(), var_keypair_mutated.clone())
	mut iife_temp_51 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_51 := iife_temp_51.memzero(var_secretKey.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_6
		}
	}
	mut iife_temp_52 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_52 := iife_temp_52.memzero(var_ephemeralPK.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_6
		}
	}
	mut iife_temp_53 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_53 := iife_temp_53.memzero(var_nonce.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_6
		}
	}
	unsafe {
		goto end_label_6
	}
	catch_label_6:
	mut var_e_6 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_6, 'SodiumException') {
		mut var_ex := var_e_6.clone()
		var_secretKey = rt.new_null()
		var_ephemeralPK = rt.new_null()
		var_nonce = rt.new_null()
		unsafe {
			goto end_label_6
		}
	} else {
		rt.throw_exception(var_e_6)
		unsafe {
			goto end_label_6
		}
	}

	end_label_6:
	return var_m.clone()
}

fn Class_ParagonIE_Sodium_Crypto32.box_beforenm(var_sk rt.PhpVal, var_pk rt.PhpVal) rt.PhpVal {
	mut iife_temp_54 := Class_ParagonIE_Sodium_Core32_HSalsa20{}
	mut iife_result_54 := iife_temp_54.hsalsa20(rt.call_function('str_repeat', [
		rt.new_string(''),
		rt.new_int(16),
	]), Class_ParagonIE_Sodium_Crypto32.scalarmult(var_sk.clone(), var_pk.clone()))
	return iife_result_54
}

fn Class_ParagonIE_Sodium_Crypto32.box_keypair() string {
	mut var_sKey := rt.call_function('random_bytes', [rt.new_int(32)])
	mut var_pKey := Class_ParagonIE_Sodium_Crypto32.scalarmult_base(var_sKey.clone())
	return var_sKey.str() + var_pKey.str()
}

fn Class_ParagonIE_Sodium_Crypto32.box_seed_keypair(var_seed rt.PhpVal) string {
	mut iife_temp_55 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_55 := iife_temp_55.substr(rt.call_function('hash', [
		rt.new_string('sha512'),
		var_seed.clone(),
		rt.new_bool(true),
	]), rt.new_int(0), rt.new_int(32))
	mut var_sKey := iife_result_55
	mut var_pKey := Class_ParagonIE_Sodium_Crypto32.scalarmult_base(var_sKey.clone())
	return var_sKey.str() + var_pKey.str()
}

fn Class_ParagonIE_Sodium_Crypto32.box_keypair_from_secretkey_and_publickey(var_sKey rt.PhpVal, var_pKey rt.PhpVal) string {
	mut var_sKey_mutated := var_sKey
	mut var_pKey_mutated := var_pKey
	mut iife_temp_56 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_56 := iife_temp_56.substr(var_sKey_mutated.clone(), rt.new_int(0),
		rt.new_int(32))
	mut iife_temp_57 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_57 := iife_temp_57.substr(var_pKey_mutated.clone(), rt.new_int(0),
		rt.new_int(32))
	return iife_result_56.str() + iife_result_57.str()
}

fn Class_ParagonIE_Sodium_Crypto32.box_secretkey(var_keypair rt.PhpVal) rt.PhpVal {
	mut var_keypair_mutated := var_keypair
	mut iife_temp_58 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_58 := iife_temp_58.strlen(var_keypair_mutated.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_58, rt.new_int(64))))) {
		rt.throw_exception(rt.new_object('RangeException', []string{},
			create_rangeexception(rt.new_string('Must be ParagonIE_Sodium_Compat::CRYPTO_BOX_KEYPAIRBYTES bytes long.'))))
	}
	mut iife_temp_59 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_59 := iife_temp_59.substr(var_keypair_mutated.clone(), rt.new_int(0),
		rt.new_int(32))
	return iife_result_59
}

fn Class_ParagonIE_Sodium_Crypto32.box_publickey(var_keypair rt.PhpVal) rt.PhpVal {
	mut var_keypair_mutated := var_keypair
	mut iife_temp_60 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_60 := iife_temp_60.strlen(var_keypair_mutated.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_60,
		Class_ParagonIE_Sodium_Compat.crypto_box_keypairbytes()))))
	{
		rt.throw_exception(rt.new_object('RangeException', []string{},
			create_rangeexception(rt.new_string('Must be ParagonIE_Sodium_Compat::CRYPTO_BOX_KEYPAIRBYTES bytes long.'))))
	}
	mut iife_temp_61 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_61 := iife_temp_61.substr(var_keypair_mutated.clone(), rt.new_int(32),
		rt.new_int(32))
	return iife_result_61
}

fn Class_ParagonIE_Sodium_Crypto32.box_publickey_from_secretkey(var_sKey rt.PhpVal) rt.PhpVal {
	mut var_sKey_mutated := var_sKey
	mut iife_temp_62 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_62 := iife_temp_62.strlen(var_sKey_mutated.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_62,
		Class_ParagonIE_Sodium_Compat.crypto_box_secretkeybytes()))))
	{
		rt.throw_exception(rt.new_object('RangeException', []string{},
			create_rangeexception(rt.new_string('Must be ParagonIE_Sodium_Compat::CRYPTO_BOX_SECRETKEYBYTES bytes long.'))))
	}
	return Class_ParagonIE_Sodium_Crypto32.scalarmult_base(var_sKey_mutated.clone())
}

fn Class_ParagonIE_Sodium_Crypto32.box_open(var_ciphertext rt.PhpVal, var_nonce rt.PhpVal, var_keypair rt.PhpVal) rt.PhpVal {
	mut var_ciphertext_mutated := var_ciphertext
	mut var_nonce_mutated := var_nonce
	mut var_keypair_mutated := var_keypair
	return Class_ParagonIE_Sodium_Crypto32.secretbox_open(var_ciphertext_mutated.clone(),
		var_nonce_mutated.clone(), Class_ParagonIE_Sodium_Crypto32.box_beforenm(Class_ParagonIE_Sodium_Crypto32.box_secretkey(var_keypair_mutated.clone()),
		Class_ParagonIE_Sodium_Crypto32.box_publickey(var_keypair_mutated.clone())))
}

fn Class_ParagonIE_Sodium_Crypto32.generichash(var_message rt.PhpVal, key string, outlen i64) rt.PhpVal {
	mut iife_temp_63 := Class_ParagonIE_Sodium_Core32_BLAKE2b{}
	mut iife_result_63 := iife_temp_63.pseudoconstructor()
	mut var_k := rt.new_null()
	if !(key == '') {
		mut iife_temp_64 := Class_ParagonIE_Sodium_Core32_BLAKE2b{}
		mut iife_result_64 := iife_temp_64.stringtosplfixedarray(rt.new_string(key))
		var_k = iife_result_64
		if rt.is_true(rt.greater(rt.call_method(var_k, 'count', []rt.PhpVal{}),
			Class_ParagonIE_Sodium_Core32_BLAKE2b.keybytes()))
		{
			rt.throw_exception(rt.new_object('RangeException', []string{},
				create_rangeexception(rt.new_string('Invalid key size'))))
		}
	}
	mut iife_temp_65 := Class_ParagonIE_Sodium_Core32_BLAKE2b{}
	mut iife_result_65 := iife_temp_65.stringtosplfixedarray(var_message.clone())
	mut var_in := iife_result_65
	mut iife_temp_66 := Class_ParagonIE_Sodium_Core32_BLAKE2b{}
	mut iife_result_66 := iife_temp_66.init(var_k.clone(), rt.new_int(outlen))
	mut var_ctx := iife_result_66
	mut iife_temp_67 := Class_ParagonIE_Sodium_Core32_BLAKE2b{}
	mut iife_result_67 := iife_temp_67.update(var_ctx.clone(), var_in.clone(), rt.call_method(var_in,
		'count', []rt.PhpVal{}))
	mut var_out := create_splfixedarray(rt.new_int(outlen))
	mut iife_temp_68 := Class_ParagonIE_Sodium_Core32_BLAKE2b{}
	mut iife_result_68 := iife_temp_68.finish(var_ctx.clone(), var_out.clone())
	var_out = iife_result_68
	mut var_outArray := rt.call_method(var_out, 'toArray', []rt.PhpVal{})
	mut iife_temp_69 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_69 := iife_temp_69.intarraytostring(var_outArray.clone())
	return iife_result_69
}

fn Class_ParagonIE_Sodium_Crypto32.generichash_final(var_ctx rt.PhpVal, outlen i64) rt.PhpVal {
	mut var_ctx_mutated := var_ctx
	if !(var_ctx_mutated.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Context must be a string'))))
	}
	mut var_out := create_splfixedarray(rt.new_int(outlen))
	mut iife_temp_70 := Class_ParagonIE_Sodium_Core32_BLAKE2b{}
	mut iife_result_70 := iife_temp_70.stringtocontext(var_ctx_mutated.clone())
	mut var_context := iife_result_70
	mut iife_temp_71 := Class_ParagonIE_Sodium_Core32_BLAKE2b{}
	mut iife_result_71 := iife_temp_71.finish(var_context.clone(), var_out.clone())
	var_out = iife_result_71
	mut var_outArray := rt.call_method(var_out, 'toArray', []rt.PhpVal{})
	mut iife_temp_72 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_72 := iife_temp_72.intarraytostring(var_outArray.clone())
	return iife_result_72
}

fn Class_ParagonIE_Sodium_Crypto32.generichash_init(key string, outputLength i64) rt.PhpVal {
	mut iife_temp_73 := Class_ParagonIE_Sodium_Core32_BLAKE2b{}
	mut iife_result_73 := iife_temp_73.pseudoconstructor()
	mut var_k := rt.new_null()
	if !(key == '') {
		mut iife_temp_74 := Class_ParagonIE_Sodium_Core32_BLAKE2b{}
		mut iife_result_74 := iife_temp_74.stringtosplfixedarray(rt.new_string(key))
		var_k = iife_result_74
		if rt.is_true(rt.greater(rt.call_method(var_k, 'count', []rt.PhpVal{}),
			Class_ParagonIE_Sodium_Core32_BLAKE2b.keybytes()))
		{
			rt.throw_exception(rt.new_object('RangeException', []string{},
				create_rangeexception(rt.new_string('Invalid key size'))))
		}
	}
	mut iife_temp_75 := Class_ParagonIE_Sodium_Core32_BLAKE2b{}
	mut iife_result_75 := iife_temp_75.init(var_k.clone(), rt.new_int(outputLength))
	mut var_ctx := iife_result_75
	mut iife_temp_76 := Class_ParagonIE_Sodium_Core32_BLAKE2b{}
	mut iife_result_76 := iife_temp_76.contexttostring(var_ctx.clone())
	return iife_result_76
}

fn Class_ParagonIE_Sodium_Crypto32.generichash_init_salt_personal(key string, outputLength i64, salt string, personal string) rt.PhpVal {
	mut iife_temp_77 := Class_ParagonIE_Sodium_Core32_BLAKE2b{}
	mut iife_result_77 := iife_temp_77.pseudoconstructor()
	mut var_k := rt.new_null()
	if !(key == '') {
		mut iife_temp_78 := Class_ParagonIE_Sodium_Core32_BLAKE2b{}
		mut iife_result_78 := iife_temp_78.stringtosplfixedarray(rt.new_string(key))
		var_k = iife_result_78
		if rt.is_true(rt.greater(rt.call_method(var_k, 'count', []rt.PhpVal{}),
			Class_ParagonIE_Sodium_Core32_BLAKE2b.keybytes()))
		{
			rt.throw_exception(rt.new_object('RangeException', []string{},
				create_rangeexception(rt.new_string('Invalid key size'))))
		}
	}
	if !(salt == '') {
		mut iife_temp_79 := Class_ParagonIE_Sodium_Core32_BLAKE2b{}
		mut iife_result_79 := iife_temp_79.stringtosplfixedarray(rt.new_string(salt))
		mut var_s := iife_result_79
	} else {
		var_s = rt.new_null()
	}
	if !(salt == '') {
		mut iife_temp_80 := Class_ParagonIE_Sodium_Core32_BLAKE2b{}
		mut iife_result_80 := iife_temp_80.stringtosplfixedarray(rt.new_string(personal))
		mut var_p := iife_result_80
	} else {
		var_p = rt.new_null()
	}
	mut iife_temp_81 := Class_ParagonIE_Sodium_Core32_BLAKE2b{}
	mut iife_result_81 := iife_temp_81.init(var_k.clone(), rt.new_int(outputLength), var_s.clone(),
		var_p.clone())
	mut var_ctx := iife_result_81
	mut iife_temp_82 := Class_ParagonIE_Sodium_Core32_BLAKE2b{}
	mut iife_result_82 := iife_temp_82.contexttostring(var_ctx.clone())
	return iife_result_82
}

fn Class_ParagonIE_Sodium_Crypto32.generichash_update(var_ctx rt.PhpVal, var_message rt.PhpVal) rt.PhpVal {
	mut var_ctx_mutated := var_ctx
	mut iife_temp_83 := Class_ParagonIE_Sodium_Core32_BLAKE2b{}
	mut iife_result_83 := iife_temp_83.pseudoconstructor()
	mut iife_temp_84 := Class_ParagonIE_Sodium_Core32_BLAKE2b{}
	mut iife_result_84 := iife_temp_84.stringtocontext(var_ctx_mutated.clone())
	mut var_context := iife_result_84
	mut iife_temp_85 := Class_ParagonIE_Sodium_Core32_BLAKE2b{}
	mut iife_result_85 := iife_temp_85.stringtosplfixedarray(var_message.clone())
	mut var_in := iife_result_85
	mut iife_temp_86 := Class_ParagonIE_Sodium_Core32_BLAKE2b{}
	mut iife_result_86 := iife_temp_86.update(var_context.clone(), var_in.clone(), rt.call_method(var_in,
		'count', []rt.PhpVal{}))
	mut iife_temp_87 := Class_ParagonIE_Sodium_Core32_BLAKE2b{}
	mut iife_result_87 := iife_temp_87.contexttostring(var_context.clone())
	return iife_result_87
}

fn Class_ParagonIE_Sodium_Crypto32.keyexchange(var_my_sk rt.PhpVal, var_their_pk rt.PhpVal, var_client_pk rt.PhpVal, var_server_pk rt.PhpVal) rt.PhpVal {
	return Class_ParagonIE_Sodium_Crypto32.generichash(
		(Class_ParagonIE_Sodium_Crypto32.scalarmult(var_my_sk.clone(), var_their_pk.clone())).str() +
		var_client_pk.str() + var_server_pk.str())
}

fn Class_ParagonIE_Sodium_Crypto32.scalarmult(var_sKey rt.PhpVal, var_pKey rt.PhpVal) rt.PhpVal {
	mut var_sKey_mutated := var_sKey
	mut var_pKey_mutated := var_pKey
	mut iife_temp_88 := Class_ParagonIE_Sodium_Core32_X25519{}
	mut iife_result_88 := iife_temp_88.crypto_scalarmult_curve25519_ref10(var_sKey_mutated.clone(),
		var_pKey_mutated.clone())
	mut var_q := iife_result_88
	Class_ParagonIE_Sodium_Crypto32.scalarmult_throw_if_zero(var_q.clone())
	return var_q.clone()
}

fn Class_ParagonIE_Sodium_Crypto32.scalarmult_base(var_secret rt.PhpVal) rt.PhpVal {
	mut iife_temp_89 := Class_ParagonIE_Sodium_Core32_X25519{}
	mut iife_result_89 := iife_temp_89.crypto_scalarmult_curve25519_ref10_base(var_secret.clone())
	mut var_q := iife_result_89
	Class_ParagonIE_Sodium_Crypto32.scalarmult_throw_if_zero(var_q.clone())
	return var_q.clone()
}

fn Class_ParagonIE_Sodium_Crypto32.scalarmult_throw_if_zero(var_q rt.PhpVal) {
	mut var_q_mutated := var_q
	mut var_d := rt.new_int(0)
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, Class_ParagonIE_Sodium_Crypto32.box_curve25519xsalsa20poly1305_secretkeybytes()))) { break
		 }
		rt.new_null()
		rt.pre_inc(var_i)
	}
	if rt.is_true(-1 & rt.shift_right(rt.sub(var_d, rt.new_int(1)), rt.new_int(8))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Zero public key is not allowed'))))
	}
}

fn Class_ParagonIE_Sodium_Crypto32.secretbox(var_plaintext rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut var_nonce_mutated := var_nonce
	mut iife_temp_90 := Class_ParagonIE_Sodium_Core32_HSalsa20{}
	mut iife_result_90 := iife_temp_90.hsalsa20(var_nonce_mutated.clone(), var_key.clone())
	mut var_subkey := iife_result_90
	mut var_block0 := rt.call_function('str_repeat', [rt.new_string(''),
		rt.new_int(32)])
	mut iife_temp_91 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_91 := iife_temp_91.strlen(var_plaintext.clone())
	mut var_mlen := iife_result_91
	mut var_mlen0 := var_mlen.clone()
	if rt.is_true(rt.greater(var_mlen0,
		64 - Class_ParagonIE_Sodium_Crypto32.secretbox_xsalsa20poly1305_zerobytes()))
	{
		var_mlen0 =
			rt.new_int(64 - Class_ParagonIE_Sodium_Crypto32.secretbox_xsalsa20poly1305_zerobytes())
	}
	mut iife_temp_92 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_92 := iife_temp_92.substr(var_plaintext.clone(), rt.new_int(0),
		var_mlen0.clone())
	var_block0 = rt.concat(var_block0, iife_result_92)
	mut iife_temp_93 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_93 := iife_temp_93.substr(var_nonce_mutated.clone(), rt.new_int(16),
		rt.new_int(8))
	mut iife_temp_94 := Class_ParagonIE_Sodium_Core32_Salsa20{}
	mut iife_result_94 := iife_temp_94.salsa20_xor(var_block0.clone(), iife_result_93,
		var_subkey.clone())
	var_block0 = iife_result_94
	mut iife_temp_95 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_95 := iife_temp_95.substr(var_block0.clone(),
		rt.new_int(Class_ParagonIE_Sodium_Crypto32.secretbox_xsalsa20poly1305_zerobytes()))
	mut var_c := iife_result_95
	if rt.is_true(rt.greater(var_mlen, var_mlen0)) {
		mut iife_temp_96 := Class_ParagonIE_Sodium_Core32_Util{}
		mut iife_result_96 := iife_temp_96.substr(var_plaintext.clone(),
			rt.new_int(Class_ParagonIE_Sodium_Crypto32.secretbox_xsalsa20poly1305_zerobytes()))
		mut iife_temp_97 := Class_ParagonIE_Sodium_Core32_Util{}
		mut iife_result_97 := iife_temp_97.substr(var_nonce_mutated.clone(), rt.new_int(16),
			rt.new_int(8))
		mut iife_temp_98 := Class_ParagonIE_Sodium_Core32_Salsa20{}
		mut iife_result_98 := iife_temp_98.salsa20_xor_ic(iife_result_96, iife_result_97,
			rt.new_int(1), var_subkey.clone())
		var_c = rt.concat(var_c, iife_result_98)
	}
	mut iife_temp_99 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_99 := iife_temp_99.substr(var_block0.clone(), rt.new_int(0),
		rt.new_int(Class_ParagonIE_Sodium_Crypto32.onetimeauth_poly1305_keybytes()))
	mut var_state := create_paragonie_sodium_core32_poly1305_state(iife_result_99)
	mut iife_temp_100 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_100 := iife_temp_100.memzero(var_block0.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_7
		}
	}
	mut iife_temp_101 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_101 := iife_temp_101.memzero(var_subkey.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_7
		}
	}
	unsafe {
		goto end_label_7
	}
	catch_label_7:
	mut var_e_7 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_7, 'SodiumException') {
		mut var_ex := var_e_7.clone()
		var_block0 = rt.new_null()
		var_subkey = rt.new_null()
		unsafe {
			goto end_label_7
		}
	} else {
		rt.throw_exception(var_e_7)
		unsafe {
			goto end_label_7
		}
	}

	end_label_7:
	rt.call_method(var_state, 'update', [var_c.clone()])
	var_c = rt.new_string((rt.call_method(var_state, 'finish', []rt.PhpVal{})).str() + var_c.str())
	var_state = rt.new_null()
	return var_c.clone()
}

fn Class_ParagonIE_Sodium_Crypto32.secretbox_open(var_ciphertext rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut var_ciphertext_mutated := var_ciphertext
	mut var_nonce_mutated := var_nonce
	mut iife_temp_102 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_102 := iife_temp_102.substr(var_ciphertext_mutated.clone(), rt.new_int(0),
		rt.new_int(Class_ParagonIE_Sodium_Crypto32.secretbox_xsalsa20poly1305_macbytes()))
	mut var_mac := iife_result_102
	mut iife_temp_103 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_103 := iife_temp_103.substr(var_ciphertext_mutated.clone(),
		rt.new_int(Class_ParagonIE_Sodium_Crypto32.secretbox_xsalsa20poly1305_macbytes()))
	mut var_c := iife_result_103
	mut iife_temp_104 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_104 := iife_temp_104.strlen(var_c.clone())
	mut var_clen := iife_result_104
	mut iife_temp_105 := Class_ParagonIE_Sodium_Core32_HSalsa20{}
	mut iife_result_105 := iife_temp_105.hsalsa20(var_nonce_mutated.clone(), var_key.clone())
	mut var_subkey := iife_result_105
	mut iife_temp_106 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_106 := iife_temp_106.substr(var_nonce_mutated.clone(), rt.new_int(16),
		rt.new_int(8))
	mut iife_temp_107 := Class_ParagonIE_Sodium_Core32_Salsa20{}
	mut iife_result_107 := iife_temp_107.salsa20(rt.new_int(64), iife_result_106,
		var_subkey.clone())
	mut var_block0 := iife_result_107
	mut iife_temp_108 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_108 := iife_temp_108.substr(var_block0.clone(), rt.new_int(0), rt.new_int(32))
	mut iife_temp_109 := Class_ParagonIE_Sodium_Core32_Poly1305{}
	mut iife_result_109 := iife_temp_109.onetimeauth_verify(var_mac.clone(), var_c.clone(),
		iife_result_108)
	mut var_verified := iife_result_109
	if rt.is_true(rt.new_bool(!(rt.is_true(var_verified)))) {
		mut iife_temp_110 := Class_ParagonIE_Sodium_Compat{}
		mut iife_result_110 := iife_temp_110.memzero(var_subkey.clone())
		if rt.has_exception() {
			unsafe {
				goto catch_label_8
			}
		}
		unsafe {
			goto end_label_8
		}
		catch_label_8:
		mut var_e_8 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_8, 'SodiumException') {
			mut var_ex := var_e_8.clone()
			var_subkey = rt.new_null()
			unsafe {
				goto end_label_8
			}
		} else {
			rt.throw_exception(var_e_8)
			unsafe {
				goto end_label_8
			}
		}

		end_label_8:
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Invalid MAC'))))
	}
	mut iife_temp_111 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_111 := iife_temp_111.substr(var_block0.clone(),
		rt.new_int(Class_ParagonIE_Sodium_Crypto32.secretbox_xsalsa20poly1305_zerobytes()))
	mut iife_temp_112 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_112 := iife_temp_112.substr(var_c.clone(), rt.new_int(0),
		rt.new_int(Class_ParagonIE_Sodium_Crypto32.secretbox_xsalsa20poly1305_zerobytes()))
	mut iife_temp_113 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_113 := iife_temp_113.xorstrings(iife_result_111, iife_result_112)
	mut var_m := iife_result_113
	if rt.is_true(rt.greater(var_clen,
		Class_ParagonIE_Sodium_Crypto32.secretbox_xsalsa20poly1305_zerobytes()))
	{
		mut iife_temp_114 := Class_ParagonIE_Sodium_Core32_Util{}
		mut iife_result_114 := iife_temp_114.substr(var_c.clone(),
			rt.new_int(Class_ParagonIE_Sodium_Crypto32.secretbox_xsalsa20poly1305_zerobytes()))
		mut iife_temp_115 := Class_ParagonIE_Sodium_Core32_Util{}
		mut iife_result_115 := iife_temp_115.substr(var_nonce_mutated.clone(), rt.new_int(16),
			rt.new_int(8))
		mut iife_temp_116 := Class_ParagonIE_Sodium_Core32_Salsa20{}
		mut iife_result_116 := iife_temp_116.salsa20_xor_ic(iife_result_114, iife_result_115,
			rt.new_int(1), rt.new_string(var_subkey.str()))
		var_m = rt.concat(var_m, iife_result_116)
	}
	return var_m.clone()
}

fn Class_ParagonIE_Sodium_Crypto32.secretbox_xchacha20poly1305(var_plaintext rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut var_nonce_mutated := var_nonce
	mut iife_temp_117 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_117 := iife_temp_117.substr(var_nonce_mutated.clone(), rt.new_int(0),
		rt.new_int(16))
	mut iife_temp_118 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
	mut iife_result_118 := iife_temp_118.hchacha20(iife_result_117, var_key.clone())
	mut var_subkey := iife_result_118
	mut iife_temp_119 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_119 := iife_temp_119.substr(var_nonce_mutated.clone(), rt.new_int(16),
		rt.new_int(8))
	mut var_nonceLast := iife_result_119
	mut var_block0 := rt.call_function('str_repeat', [rt.new_string(''),
		rt.new_int(32)])
	mut iife_temp_120 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_120 := iife_temp_120.strlen(var_plaintext.clone())
	mut var_mlen := iife_result_120
	mut var_mlen0 := var_mlen.clone()
	if rt.is_true(rt.greater(var_mlen0,
		64 - Class_ParagonIE_Sodium_Crypto32.secretbox_xchacha20poly1305_zerobytes()))
	{
		var_mlen0 =
			rt.new_int(64 - Class_ParagonIE_Sodium_Crypto32.secretbox_xchacha20poly1305_zerobytes())
	}
	mut iife_temp_121 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_121 := iife_temp_121.substr(var_plaintext.clone(), rt.new_int(0),
		var_mlen0.clone())
	var_block0 = rt.concat(var_block0, iife_result_121)
	mut iife_temp_122 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
	mut iife_result_122 := iife_temp_122.streamxoric(var_block0.clone(), var_nonceLast.clone(),
		var_subkey.clone())
	var_block0 = iife_result_122
	mut iife_temp_123 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_123 := iife_temp_123.substr(var_block0.clone(),
		rt.new_int(Class_ParagonIE_Sodium_Crypto32.secretbox_xchacha20poly1305_zerobytes()))
	mut var_c := iife_result_123
	if rt.is_true(rt.greater(var_mlen, var_mlen0)) {
		mut iife_temp_124 := Class_ParagonIE_Sodium_Core32_Util{}
		mut iife_result_124 := iife_temp_124.substr(var_plaintext.clone(),
			rt.new_int(Class_ParagonIE_Sodium_Crypto32.secretbox_xchacha20poly1305_zerobytes()))
		mut iife_temp_125 := Class_ParagonIE_Sodium_Core32_Util{}
		mut iife_result_125 := iife_temp_125.store64_le(rt.new_int(1))
		mut iife_temp_126 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
		mut iife_result_126 := iife_temp_126.streamxoric(iife_result_124, var_nonceLast.clone(),
			var_subkey.clone(), iife_result_125)
		var_c = rt.concat(var_c, iife_result_126)
	}
	mut iife_temp_127 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_127 := iife_temp_127.substr(var_block0.clone(), rt.new_int(0),
		rt.new_int(Class_ParagonIE_Sodium_Crypto32.onetimeauth_poly1305_keybytes()))
	mut var_state := create_paragonie_sodium_core32_poly1305_state(iife_result_127)
	mut iife_temp_128 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_128 := iife_temp_128.memzero(var_block0.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_9
		}
	}
	mut iife_temp_129 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_129 := iife_temp_129.memzero(var_subkey.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_9
		}
	}
	unsafe {
		goto end_label_9
	}
	catch_label_9:
	mut var_e_9 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_9, 'SodiumException') {
		mut var_ex := var_e_9.clone()
		var_block0 = rt.new_null()
		var_subkey = rt.new_null()
		unsafe {
			goto end_label_9
		}
	} else {
		rt.throw_exception(var_e_9)
		unsafe {
			goto end_label_9
		}
	}

	end_label_9:
	rt.call_method(var_state, 'update', [var_c.clone()])
	var_c = rt.new_string((rt.call_method(var_state, 'finish', []rt.PhpVal{})).str() + var_c.str())
	var_state = rt.new_null()
	return var_c.clone()
}

fn Class_ParagonIE_Sodium_Crypto32.secretbox_xchacha20poly1305_open(var_ciphertext rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut var_ciphertext_mutated := var_ciphertext
	mut var_nonce_mutated := var_nonce
	mut iife_temp_130 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_130 := iife_temp_130.substr(var_ciphertext_mutated.clone(), rt.new_int(0),
		rt.new_int(Class_ParagonIE_Sodium_Crypto32.secretbox_xchacha20poly1305_macbytes()))
	mut var_mac := iife_result_130
	mut iife_temp_131 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_131 := iife_temp_131.substr(var_ciphertext_mutated.clone(),
		rt.new_int(Class_ParagonIE_Sodium_Crypto32.secretbox_xchacha20poly1305_macbytes()))
	mut var_c := iife_result_131
	mut iife_temp_132 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_132 := iife_temp_132.strlen(var_c.clone())
	mut var_clen := iife_result_132
	mut iife_temp_133 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
	mut iife_result_133 := iife_temp_133.hchacha20(var_nonce_mutated.clone(), var_key.clone())
	mut var_subkey := iife_result_133
	mut iife_temp_134 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_134 := iife_temp_134.substr(var_nonce_mutated.clone(), rt.new_int(16),
		rt.new_int(8))
	mut iife_temp_135 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
	mut iife_result_135 := iife_temp_135.stream(rt.new_int(64), iife_result_134, var_subkey.clone())
	mut var_block0 := iife_result_135
	mut iife_temp_136 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_136 := iife_temp_136.substr(var_block0.clone(), rt.new_int(0), rt.new_int(32))
	mut iife_temp_137 := Class_ParagonIE_Sodium_Core32_Poly1305{}
	mut iife_result_137 := iife_temp_137.onetimeauth_verify(var_mac.clone(), var_c.clone(),
		iife_result_136)
	mut var_verified := iife_result_137
	if rt.is_true(rt.new_bool(!(rt.is_true(var_verified)))) {
		mut iife_temp_138 := Class_ParagonIE_Sodium_Compat{}
		mut iife_result_138 := iife_temp_138.memzero(var_subkey.clone())
		if rt.has_exception() {
			unsafe {
				goto catch_label_10
			}
		}
		unsafe {
			goto end_label_10
		}
		catch_label_10:
		mut var_e_10 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_10, 'SodiumException') {
			mut var_ex := var_e_10.clone()
			var_subkey = rt.new_null()
			unsafe {
				goto end_label_10
			}
		} else {
			rt.throw_exception(var_e_10)
			unsafe {
				goto end_label_10
			}
		}

		end_label_10:
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Invalid MAC'))))
	}
	mut iife_temp_139 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_139 := iife_temp_139.substr(var_block0.clone(),
		rt.new_int(Class_ParagonIE_Sodium_Crypto32.secretbox_xchacha20poly1305_zerobytes()))
	mut iife_temp_140 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_140 := iife_temp_140.substr(var_c.clone(), rt.new_int(0),
		rt.new_int(Class_ParagonIE_Sodium_Crypto32.secretbox_xchacha20poly1305_zerobytes()))
	mut iife_temp_141 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_141 := iife_temp_141.xorstrings(iife_result_139, iife_result_140)
	mut var_m := iife_result_141
	if rt.is_true(rt.greater(var_clen,
		Class_ParagonIE_Sodium_Crypto32.secretbox_xchacha20poly1305_zerobytes()))
	{
		mut iife_temp_142 := Class_ParagonIE_Sodium_Core32_Util{}
		mut iife_result_142 := iife_temp_142.substr(var_c.clone(),
			rt.new_int(Class_ParagonIE_Sodium_Crypto32.secretbox_xchacha20poly1305_zerobytes()))
		mut iife_temp_143 := Class_ParagonIE_Sodium_Core32_Util{}
		mut iife_result_143 := iife_temp_143.substr(var_nonce_mutated.clone(), rt.new_int(16),
			rt.new_int(8))
		mut iife_temp_144 := Class_ParagonIE_Sodium_Core32_Util{}
		mut iife_result_144 := iife_temp_144.store64_le(rt.new_int(1))
		mut iife_temp_145 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
		mut iife_result_145 := iife_temp_145.streamxoric(iife_result_142, iife_result_143,
			rt.new_string(var_subkey.str()), iife_result_144)
		var_m = rt.concat(var_m, iife_result_145)
	}
	return var_m.clone()
}

fn Class_ParagonIE_Sodium_Crypto32.secretstream_xchacha20poly1305_init_push(var_key rt.PhpVal) rt.PhpVal {
	mut var_out := rt.call_function('random_bytes', [rt.new_int(24)])
	mut iife_temp_146 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
	mut iife_result_146 := iife_temp_146.hchacha20(var_out.clone(), var_key.clone())
	mut var_subkey := iife_result_146
	mut iife_temp_147 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_147 := iife_temp_147.substr(var_out.clone(), rt.new_int(16), rt.new_int(8))
	mut var_state := create_paragonie_sodium_core32_secretstream_state(var_subkey.clone(),
		iife_result_147.str() +
		(rt.call_function('str_repeat', [rt.new_string(''), rt.new_int(4)])).str())
	rt.call_method(var_state, 'counterReset', []rt.PhpVal{})
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_method(var_state, 'toString', []rt.PhpVal{}) },
		rt.ArrayItem{ key: none, val: var_out },
	])
}

fn Class_ParagonIE_Sodium_Crypto32.secretstream_xchacha20poly1305_init_pull(var_key rt.PhpVal, var_header rt.PhpVal) rt.PhpVal {
	mut iife_temp_148 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_148 := iife_temp_148.substr(var_header.clone(), rt.new_int(0), rt.new_int(16))
	mut iife_temp_149 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
	mut iife_result_149 := iife_temp_149.hchacha20(iife_result_148, var_key.clone())
	mut var_subkey := iife_result_149
	mut iife_temp_150 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_150 := iife_temp_150.substr(var_header.clone(), rt.new_int(16))
	mut var_state := create_paragonie_sodium_core32_secretstream_state(var_subkey.clone(),
		iife_result_150)
	rt.call_method(var_state, 'counterReset', []rt.PhpVal{})
	return rt.call_method(var_state, 'toString', []rt.PhpVal{})
}

fn Class_ParagonIE_Sodium_Crypto32.secretstream_xchacha20poly1305_push(var_state rt.PhpVal, var_msg rt.PhpVal, aad string, tag i64) rt.PhpVal {
	mut var_state_mutated := var_state
	mut tag_mutated := tag
	mut iife_temp_151 := Class_ParagonIE_Sodium_Core32_SecretStream_State{}
	mut iife_result_151 := iife_temp_151.fromstring(var_state_mutated.clone())
	mut var_st := iife_result_151
	mut iife_temp_152 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_152 := iife_temp_152.strlen(var_msg.clone())
	mut var_msglen := iife_result_152
	mut iife_temp_153 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_153 := iife_temp_153.strlen(rt.new_string(aad))
	mut var_aadlen := iife_result_153
	if rt.shift_right(rt.add(var_msglen, rt.new_int(63)), rt.new_int(6)) > 4294967294 {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('message cannot be larger than SODIUM_CRYPTO_SECRETSTREAM_XCHACHA20POLY1305_MESSAGEBYTES_MAX bytes'))))
	}
	mut iife_temp_154 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
	mut iife_result_154 := iife_temp_154.ietfstream(rt.new_int(32), rt.call_method(var_st,
		'getCombinedNonce', []rt.PhpVal{}), rt.call_method(var_st, 'getKey', []rt.PhpVal{}))
	mut var_auth := create_paragonie_sodium_core32_poly1305_state(iife_result_154)
	var_auth.update(rt.new_string(aad))
	var_auth.update(rt.call_function('str_repeat', [rt.new_string(''),
		rt.bitwise_and(rt.sub(rt.new_int(16), var_aadlen), rt.new_int(15))]))
	mut iife_temp_155 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_155 := iife_temp_155.inttochr(rt.new_int(tag_mutated))
	mut iife_temp_156 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_156 := iife_temp_156.store64_le(rt.new_int(1))
	mut iife_temp_157 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
	mut iife_result_157 := iife_temp_157.ietfstreamxoric(rt.new_string(iife_result_155.str() +
		(rt.call_function('str_repeat', [rt.new_string(''), rt.new_int(63)])).str()), rt.call_method(var_st,
		'getCombinedNonce', []rt.PhpVal{}), rt.call_method(var_st, 'getKey', []rt.PhpVal{}),
		iife_result_156)
	mut var_block := iife_result_157
	var_auth.update(var_block.clone())
	mut var_out := var_block.array_get(rt.new_int(0))
	mut iife_temp_158 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_158 := iife_temp_158.store64_le(rt.new_int(2))
	mut iife_temp_159 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
	mut iife_result_159 := iife_temp_159.ietfstreamxoric(var_msg.clone(), rt.call_method(var_st,
		'getCombinedNonce', []rt.PhpVal{}), rt.call_method(var_st, 'getKey', []rt.PhpVal{}),
		iife_result_158)
	mut var_cipher := iife_result_159
	var_auth.update(var_cipher.clone())
	var_out = rt.concat(var_out, var_cipher)
	var_cipher = rt.new_null()
	var_auth.update(rt.call_function('str_repeat', [rt.new_string(''),
		rt.bitwise_and(rt.add(16 - 64, var_msglen), rt.new_int(15))]))
	mut iife_temp_160 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_160 := iife_temp_160.store64_le(var_aadlen.clone())
	mut var_slen := iife_result_160
	var_auth.update(var_slen.clone())
	mut iife_temp_161 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_161 := iife_temp_161.store64_le(rt.add(rt.new_int(64), var_msglen))
	var_slen = iife_result_161
	var_auth.update(var_slen.clone())
	mut var_mac := var_auth.finish()
	var_out = rt.concat(var_out, var_mac)
	var_auth = rt.new_null()
	rt.call_method(var_st, 'xorNonce', [var_mac.clone()])
	rt.call_method(var_st, 'incrementCounter', []rt.PhpVal{})
	var_state_mutated = rt.call_method(var_st, 'toString', []rt.PhpVal{})
	mut var_rekey := rt.new_bool(rt.bitwise_and(rt.new_int(tag_mutated),
		Class_ParagonIE_Sodium_Compat.crypto_secretstream_xchacha20poly1305_tag_rekey()) != 0)
	if rt.is_true(var_rekey) || rt.is_true(rt.call_method(var_st, 'needsRekey', []rt.PhpVal{})) {
		Class_ParagonIE_Sodium_Crypto32.secretstream_xchacha20poly1305_rekey(var_state_mutated.clone())
	}
	return var_out.clone()
}

fn Class_ParagonIE_Sodium_Crypto32.secretstream_xchacha20poly1305_pull(var_state rt.PhpVal, var_cipher rt.PhpVal, aad string) rt.PhpVal {
	mut var_state_mutated := var_state
	mut var_cipher_mutated := var_cipher
	mut iife_temp_162 := Class_ParagonIE_Sodium_Core32_SecretStream_State{}
	mut iife_result_162 := iife_temp_162.fromstring(var_state_mutated.clone())
	mut var_st := iife_result_162
	mut iife_temp_163 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_163 := iife_temp_163.strlen(var_cipher_mutated.clone())
	mut var_cipherlen := iife_result_163
	mut var_msglen := rt.sub(var_cipherlen,
		Class_ParagonIE_Sodium_Compat.crypto_secretstream_xchacha20poly1305_abytes())
	mut iife_temp_164 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_164 := iife_temp_164.strlen(rt.new_string(aad))
	mut var_aadlen := iife_result_164
	if rt.shift_right(rt.add(var_msglen, rt.new_int(63)), rt.new_int(6)) > 4294967294 {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('message cannot be larger than SODIUM_CRYPTO_SECRETSTREAM_XCHACHA20POLY1305_MESSAGEBYTES_MAX bytes'))))
	}
	mut iife_temp_165 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
	mut iife_result_165 := iife_temp_165.ietfstream(rt.new_int(32), rt.call_method(var_st,
		'getCombinedNonce', []rt.PhpVal{}), rt.call_method(var_st, 'getKey', []rt.PhpVal{}))
	mut var_auth := create_paragonie_sodium_core32_poly1305_state(iife_result_165)
	var_auth.update(rt.new_string(aad))
	var_auth.update(rt.call_function('str_repeat', [rt.new_string(''),
		rt.bitwise_and(rt.sub(rt.new_int(16), var_aadlen), rt.new_int(15))]))
	mut iife_temp_166 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_166 := iife_temp_166.store64_le(rt.new_int(1))
	mut iife_temp_167 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
	mut iife_result_167 := iife_temp_167.ietfstreamxoric(rt.new_string(
		(var_cipher_mutated.array_get(rt.new_int(0))).str() +
		(rt.call_function('str_repeat', [rt.new_string(''), rt.new_int(63)])).str()), rt.call_method(var_st,
		'getCombinedNonce', []rt.PhpVal{}), rt.call_method(var_st, 'getKey', []rt.PhpVal{}),
		iife_result_166)
	mut var_block := iife_result_167
	mut iife_temp_168 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_168 := iife_temp_168.chrtoint(var_block.array_get(rt.new_int(0)))
	mut var_tag := iife_result_168
	var_block.array_set(0, var_cipher_mutated.array_get(rt.new_int(0)))
	var_auth.update(var_block.clone())
	mut iife_temp_169 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_169 := iife_temp_169.substr(var_cipher_mutated.clone(), rt.new_int(1),
		var_msglen.clone())
	var_auth.update(iife_result_169)
	var_auth.update(rt.call_function('str_repeat', [rt.new_string(''),
		rt.bitwise_and(rt.add(16 - 64, var_msglen), rt.new_int(15))]))
	mut iife_temp_170 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_170 := iife_temp_170.store64_le(var_aadlen.clone())
	mut var_slen := iife_result_170
	var_auth.update(var_slen.clone())
	mut iife_temp_171 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_171 := iife_temp_171.store64_le(rt.add(rt.new_int(64), var_msglen))
	var_slen = iife_result_171
	var_auth.update(var_slen.clone())
	mut var_mac := var_auth.finish()
	mut iife_temp_172 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_172 := iife_temp_172.substr(var_cipher_mutated.clone(), rt.add(var_msglen,
		rt.new_int(1)), rt.new_int(16))
	mut var_stored := iife_result_172
	mut iife_temp_173 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_173 := iife_temp_173.hashequals(var_mac.clone(), var_stored.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_173)))) {
		return rt.new_bool(false)
	}
	mut iife_temp_174 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_174 := iife_temp_174.substr(var_cipher_mutated.clone(), rt.new_int(1),
		var_msglen.clone())
	mut iife_temp_175 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_175 := iife_temp_175.store64_le(rt.new_int(2))
	mut iife_temp_176 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
	mut iife_result_176 := iife_temp_176.ietfstreamxoric(iife_result_174, rt.call_method(var_st,
		'getCombinedNonce', []rt.PhpVal{}), rt.call_method(var_st, 'getKey', []rt.PhpVal{}),
		iife_result_175)
	mut var_out := iife_result_176
	rt.call_method(var_st, 'xorNonce', [var_mac.clone()])
	rt.call_method(var_st, 'incrementCounter', []rt.PhpVal{})
	var_state_mutated = rt.call_method(var_st, 'toString', []rt.PhpVal{})
	mut var_rekey := rt.new_bool(rt.bitwise_and(var_tag,
		Class_ParagonIE_Sodium_Compat.crypto_secretstream_xchacha20poly1305_tag_rekey()) != 0)
	if rt.is_true(var_rekey) || rt.is_true(rt.call_method(var_st, 'needsRekey', []rt.PhpVal{})) {
		Class_ParagonIE_Sodium_Crypto32.secretstream_xchacha20poly1305_rekey(var_state_mutated.clone())
	}
	return rt.create_array([rt.ArrayItem{ key: none, val: var_out },
		rt.ArrayItem{ key: none, val: var_tag }])
}

fn Class_ParagonIE_Sodium_Crypto32.secretstream_xchacha20poly1305_rekey(var_state rt.PhpVal) {
	mut var_state_mutated := var_state
	mut iife_temp_177 := Class_ParagonIE_Sodium_Core32_SecretStream_State{}
	mut iife_result_177 := iife_temp_177.fromstring(var_state_mutated.clone())
	mut var_st := iife_result_177
	mut var_new_key_and_inonce := rt.call_method(var_st, 'getKey', []rt.PhpVal{})
	mut iife_temp_178 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_178 := iife_temp_178.substr(rt.call_method(var_st, 'getNonce', []rt.PhpVal{}),
		rt.new_int(0), rt.new_int(8))
	var_new_key_and_inonce = rt.concat(var_new_key_and_inonce, iife_result_178)
	mut iife_temp_179 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_179 := iife_temp_179.store64_le(rt.new_int(0))
	mut iife_temp_180 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
	mut iife_result_180 := iife_temp_180.ietfstreamxoric(var_new_key_and_inonce.clone(), rt.call_method(var_st,
		'getCombinedNonce', []rt.PhpVal{}), rt.call_method(var_st, 'getKey', []rt.PhpVal{}),
		iife_result_179)
	rt.call_method(var_st, 'rekey', [iife_result_180])
	rt.call_method(var_st, 'counterReset', []rt.PhpVal{})
	var_state_mutated = rt.call_method(var_st, 'toString', []rt.PhpVal{})
}

fn Class_ParagonIE_Sodium_Crypto32.sign_detached(var_message rt.PhpVal, var_sk rt.PhpVal) rt.PhpVal {
	mut iife_temp_181 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_181 := iife_temp_181.sign_detached(var_message.clone(), var_sk.clone())
	return iife_result_181
}

fn Class_ParagonIE_Sodium_Crypto32.sign(var_message rt.PhpVal, var_sk rt.PhpVal) rt.PhpVal {
	mut iife_temp_182 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_182 := iife_temp_182.sign(var_message.clone(), var_sk.clone())
	return iife_result_182
}

fn Class_ParagonIE_Sodium_Crypto32.sign_open(var_signedMessage rt.PhpVal, var_pk rt.PhpVal) rt.PhpVal {
	mut iife_temp_183 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_183 := iife_temp_183.sign_open(var_signedMessage.clone(), var_pk.clone())
	return iife_result_183
}

fn Class_ParagonIE_Sodium_Crypto32.sign_verify_detached(var_signature rt.PhpVal, var_message rt.PhpVal, var_pk rt.PhpVal) rt.PhpVal {
	mut iife_temp_184 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_184 := iife_temp_184.verify_detached(var_signature.clone(),
		var_message.clone(), var_pk.clone())
	return iife_result_184
}

struct Class_ParagonIE_Sodium_Core32_Util {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_ChaCha20 {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Poly1305_State {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Compat {
	rt.PhpObjectBase
}

struct Class_SodiumException {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_HChaCha20 {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_HSalsa20 {
	rt.PhpObjectBase
}

struct Class_RangeException {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_BLAKE2b {
	rt.PhpObjectBase
}

struct Class_SplFixedArray {
	rt.PhpObjectBase
}

struct Class_TypeError {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_X25519 {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Salsa20 {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Poly1305 {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_SecretStream_State {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Ed25519 {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_crypto32(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Crypto32 {
	mut obj := &Class_ParagonIE_Sodium_Crypto32{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_util(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Util {
	mut obj := &Class_ParagonIE_Sodium_Core32_Util{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_chacha20(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_ChaCha20 {
	mut obj := &Class_ParagonIE_Sodium_Core32_ChaCha20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_poly1305_state(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Poly1305_State {
	mut obj := &Class_ParagonIE_Sodium_Core32_Poly1305_State{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_compat(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Compat {
	mut obj := &Class_ParagonIE_Sodium_Compat{
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

fn create_paragonie_sodium_core32_hchacha20(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_HChaCha20 {
	mut obj := &Class_ParagonIE_Sodium_Core32_HChaCha20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_hsalsa20(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_HSalsa20 {
	mut obj := &Class_ParagonIE_Sodium_Core32_HSalsa20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_rangeexception(_args ...rt.PhpVal) &Class_RangeException {
	mut obj := &Class_RangeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_blake2b(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_BLAKE2b {
	mut obj := &Class_ParagonIE_Sodium_Core32_BLAKE2b{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_splfixedarray(_args ...rt.PhpVal) &Class_SplFixedArray {
	mut obj := &Class_SplFixedArray{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_typeerror(_args ...rt.PhpVal) &Class_TypeError {
	mut obj := &Class_TypeError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_x25519(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_X25519 {
	mut obj := &Class_ParagonIE_Sodium_Core32_X25519{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_salsa20(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Salsa20 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Salsa20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_poly1305(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Poly1305 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Poly1305{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_secretstream_state(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_SecretStream_State {
	mut obj := &Class_ParagonIE_Sodium_Core32_SecretStream_State{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_ed25519(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Ed25519 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Ed25519{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Crypto32) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'aead_chacha20poly1305_decrypt' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Crypto32.aead_chacha20poly1305_decrypt(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'aead_chacha20poly1305_encrypt' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return rt.new_string(Class_ParagonIE_Sodium_Crypto32.aead_chacha20poly1305_encrypt(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'aead_chacha20poly1305_ietf_decrypt' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Crypto32.aead_chacha20poly1305_ietf_decrypt(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'aead_chacha20poly1305_ietf_encrypt' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return rt.new_string(Class_ParagonIE_Sodium_Crypto32.aead_chacha20poly1305_ietf_encrypt(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'aead_xchacha20poly1305_ietf_decrypt' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Crypto32.aead_xchacha20poly1305_ietf_decrypt(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'aead_xchacha20poly1305_ietf_encrypt' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Crypto32.aead_xchacha20poly1305_ietf_encrypt(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'auth' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto32.auth(dispatch_arg_0, dispatch_arg_1)
		}
		'auth_verify' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto32.auth_verify(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'box' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto32.box(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'box_seal' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_ParagonIE_Sodium_Crypto32.box_seal(dispatch_arg_0,
				dispatch_arg_1))
		}
		'box_seal_open' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto32.box_seal_open(dispatch_arg_0, dispatch_arg_1)
		}
		'box_beforenm' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto32.box_beforenm(dispatch_arg_0, dispatch_arg_1)
		}
		'box_keypair' {
			return rt.new_string(Class_ParagonIE_Sodium_Crypto32.box_keypair())
		}
		'box_seed_keypair' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_ParagonIE_Sodium_Crypto32.box_seed_keypair(dispatch_arg_0))
		}
		'box_keypair_from_secretkey_and_publickey' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_ParagonIE_Sodium_Crypto32.box_keypair_from_secretkey_and_publickey(dispatch_arg_0,
				dispatch_arg_1))
		}
		'box_secretkey' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto32.box_secretkey(dispatch_arg_0)
		}
		'box_publickey' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto32.box_publickey(dispatch_arg_0)
		}
		'box_publickey_from_secretkey' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto32.box_publickey_from_secretkey(dispatch_arg_0)
		}
		'box_open' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto32.box_open(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'generichash' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return Class_ParagonIE_Sodium_Crypto32.generichash(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'generichash_final' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_ParagonIE_Sodium_Crypto32.generichash_final(dispatch_arg_0, dispatch_arg_1)
		}
		'generichash_init' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_ParagonIE_Sodium_Crypto32.generichash_init(dispatch_arg_0, dispatch_arg_1)
		}
		'generichash_init_salt_personal' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Crypto32.generichash_init_salt_personal(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'generichash_update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto32.generichash_update(dispatch_arg_0,
				dispatch_arg_1)
		}
		'keyExchange' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto32.keyexchange(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3)
		}
		'scalarmult' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto32.scalarmult(dispatch_arg_0, dispatch_arg_1)
		}
		'scalarmult_base' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto32.scalarmult_base(dispatch_arg_0)
		}
		'scalarmult_throw_if_zero' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_ParagonIE_Sodium_Crypto32.scalarmult_throw_if_zero(dispatch_arg_0)
			return rt.new_null()
		}
		'secretbox' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto32.secretbox(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'secretbox_open' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto32.secretbox_open(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'secretbox_xchacha20poly1305' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto32.secretbox_xchacha20poly1305(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'secretbox_xchacha20poly1305_open' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto32.secretbox_xchacha20poly1305_open(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'secretstream_xchacha20poly1305_init_push' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto32.secretstream_xchacha20poly1305_init_push(dispatch_arg_0)
		}
		'secretstream_xchacha20poly1305_init_pull' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto32.secretstream_xchacha20poly1305_init_pull(dispatch_arg_0,
				dispatch_arg_1)
		}
		'secretstream_xchacha20poly1305_push' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			return Class_ParagonIE_Sodium_Crypto32.secretstream_xchacha20poly1305_push(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'secretstream_xchacha20poly1305_pull' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Crypto32.secretstream_xchacha20poly1305_pull(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'secretstream_xchacha20poly1305_rekey' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_ParagonIE_Sodium_Crypto32.secretstream_xchacha20poly1305_rekey(dispatch_arg_0)
			return rt.new_null()
		}
		'sign_detached' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto32.sign_detached(dispatch_arg_0, dispatch_arg_1)
		}
		'sign' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto32.sign(dispatch_arg_0, dispatch_arg_1)
		}
		'sign_open' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto32.sign_open(dispatch_arg_0, dispatch_arg_1)
		}
		'sign_verify_detached' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Crypto32.sign_verify_detached(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_ParagonIE_Sodium_Crypto32) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Crypto32) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Util) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Util) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Util) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core32_ChaCha20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_ChaCha20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_ChaCha20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Poly1305_State) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Poly1305_State) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Poly1305_State) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_ParagonIE_Sodium_Core32_HChaCha20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_HChaCha20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_HChaCha20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core32_HSalsa20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_HSalsa20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_HSalsa20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_RangeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_RangeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_RangeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core32_BLAKE2b) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_BLAKE2b) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_BLAKE2b) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_TypeError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_TypeError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_TypeError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core32_X25519) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_X25519) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_X25519) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Salsa20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Salsa20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Salsa20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Poly1305) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Poly1305) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Poly1305) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core32_SecretStream_State) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_SecretStream_State) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_SecretStream_State) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Ed25519) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Ed25519) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Ed25519) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Crypto32'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}
