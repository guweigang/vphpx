import rt

fn bin2hex(var_string rt.PhpVal) rt.PhpVal {
	mut iife_temp_0 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_0 := iife_temp_0.bin2hex(var_string.clone())
	return iife_result_0
}

fn compare(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	mut iife_temp_1 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_1 := iife_temp_1.compare(var_a.clone(), var_b.clone())
	return iife_result_1
}

fn crypto_aead_aes256gcm_decrypt(var_message rt.PhpVal, var_assocData rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) bool {
	mut var_ex := rt.new_null()
	mut iife_temp_2 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_2 := iife_temp_2.crypto_aead_aes256gcm_decrypt(var_message.clone(),
		var_assocData.clone(), var_nonce.clone(), var_key.clone())
	return iife_result_2.to_bool()
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Sodium_TypeError') {
		var_ex = var_e_1.clone()
		return false
		unsafe {
			goto end_label_1
		}
	} else if rt.instance_of(var_e_1, 'Sodium_SodiumException') {
		var_ex = var_e_1.clone()
		return false
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
	return false
}

fn crypto_aead_aes256gcm_encrypt(var_message rt.PhpVal, var_assocData rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_3 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_3 := iife_temp_3.crypto_aead_aes256gcm_encrypt(var_message.clone(),
		var_assocData.clone(), var_nonce.clone(), var_key.clone())
	return iife_result_3
}

fn crypto_aead_aes256gcm_is_available() rt.PhpVal {
	mut iife_temp_4 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_4 := iife_temp_4.crypto_aead_aes256gcm_is_available()
	return iife_result_4
}

fn crypto_aead_chacha20poly1305_decrypt(var_message rt.PhpVal, var_assocData rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) bool {
	mut var_ex := rt.new_null()
	mut iife_temp_5 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_5 := iife_temp_5.crypto_aead_chacha20poly1305_decrypt(var_message.clone(),
		var_assocData.clone(), var_nonce.clone(), var_key.clone())
	return iife_result_5.to_bool()
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Sodium_TypeError') {
		var_ex = var_e_2.clone()
		return false
		unsafe {
			goto end_label_2
		}
	} else if rt.instance_of(var_e_2, 'Sodium_SodiumException') {
		var_ex = var_e_2.clone()
		return false
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
	return false
}

fn crypto_aead_chacha20poly1305_encrypt(var_message rt.PhpVal, var_assocData rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_6 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_6 := iife_temp_6.crypto_aead_chacha20poly1305_encrypt(var_message.clone(),
		var_assocData.clone(), var_nonce.clone(), var_key.clone())
	return iife_result_6
}

fn crypto_aead_chacha20poly1305_ietf_decrypt(var_message rt.PhpVal, var_assocData rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) bool {
	mut var_ex := rt.new_null()
	mut iife_temp_7 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_7 := iife_temp_7.crypto_aead_chacha20poly1305_ietf_decrypt(var_message.clone(),
		var_assocData.clone(), var_nonce.clone(), var_key.clone())
	return iife_result_7.to_bool()
	unsafe {
		goto end_label_3
	}
	catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Sodium_TypeError') {
		var_ex = var_e_3.clone()
		return false
		unsafe {
			goto end_label_3
		}
	} else if rt.instance_of(var_e_3, 'Sodium_SodiumException') {
		var_ex = var_e_3.clone()
		return false
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
	return false
}

fn crypto_aead_chacha20poly1305_ietf_encrypt(var_message rt.PhpVal, var_assocData rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_8 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_8 := iife_temp_8.crypto_aead_chacha20poly1305_ietf_encrypt(var_message.clone(),
		var_assocData.clone(), var_nonce.clone(), var_key.clone())
	return iife_result_8
}

fn crypto_auth(var_message rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_9 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_9 := iife_temp_9.crypto_auth(var_message.clone(), var_key.clone())
	return iife_result_9
}

fn crypto_auth_verify(var_mac rt.PhpVal, var_message rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_10 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_10 := iife_temp_10.crypto_auth_verify(var_mac.clone(), var_message.clone(),
		var_key.clone())
	return iife_result_10
}

fn crypto_box(var_message rt.PhpVal, var_nonce rt.PhpVal, var_kp rt.PhpVal) rt.PhpVal {
	mut iife_temp_11 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_11 := iife_temp_11.crypto_box(var_message.clone(), var_nonce.clone(),
		var_kp.clone())
	return iife_result_11
}

fn crypto_box_keypair() rt.PhpVal {
	mut iife_temp_12 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_12 := iife_temp_12.crypto_box_keypair()
	return iife_result_12
}

fn crypto_box_keypair_from_secretkey_and_publickey(var_sk rt.PhpVal, var_pk rt.PhpVal) rt.PhpVal {
	mut iife_temp_13 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_13 := iife_temp_13.crypto_box_keypair_from_secretkey_and_publickey(var_sk.clone(),
		var_pk.clone())
	return iife_result_13
}

fn crypto_box_open(var_message rt.PhpVal, var_nonce rt.PhpVal, var_kp rt.PhpVal) bool {
	mut var_ex := rt.new_null()
	mut iife_temp_14 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_14 := iife_temp_14.crypto_box_open(var_message.clone(), var_nonce.clone(),
		var_kp.clone())
	return iife_result_14.to_bool()
	unsafe {
		goto end_label_4
	}
	catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'Sodium_TypeError') {
		var_ex = var_e_4.clone()
		return false
		unsafe {
			goto end_label_4
		}
	} else if rt.instance_of(var_e_4, 'Sodium_SodiumException') {
		var_ex = var_e_4.clone()
		return false
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
	return false
}

fn crypto_box_publickey(var_keypair rt.PhpVal) rt.PhpVal {
	mut iife_temp_15 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_15 := iife_temp_15.crypto_box_publickey(var_keypair.clone())
	return iife_result_15
}

fn crypto_box_publickey_from_secretkey(var_sk rt.PhpVal) rt.PhpVal {
	mut iife_temp_16 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_16 := iife_temp_16.crypto_box_publickey_from_secretkey(var_sk.clone())
	return iife_result_16
}

fn crypto_box_seal(var_message rt.PhpVal, var_publicKey rt.PhpVal) rt.PhpVal {
	mut iife_temp_17 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_17 := iife_temp_17.crypto_box_seal(var_message.clone(), var_publicKey.clone())
	return iife_result_17
}

fn crypto_box_seal_open(var_message rt.PhpVal, var_kp rt.PhpVal) bool {
	mut var_ex := rt.new_null()
	mut iife_temp_18 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_18 := iife_temp_18.crypto_box_seal_open(var_message.clone(), var_kp.clone())
	return iife_result_18.to_bool()
	unsafe {
		goto end_label_5
	}
	catch_label_5:
	mut var_e_5 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_5, 'Sodium_TypeError') {
		var_ex = var_e_5.clone()
		return false
		unsafe {
			goto end_label_5
		}
	} else if rt.instance_of(var_e_5, 'Sodium_SodiumException') {
		var_ex = var_e_5.clone()
		return false
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
	return false
}

fn crypto_box_secretkey(var_keypair rt.PhpVal) rt.PhpVal {
	mut iife_temp_19 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_19 := iife_temp_19.crypto_box_secretkey(var_keypair.clone())
	return iife_result_19
}

fn crypto_generichash(var_message rt.PhpVal, var_key rt.PhpVal, outLen i64) rt.PhpVal {
	mut var_outLen := outLen
	mut iife_temp_20 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_20 := iife_temp_20.crypto_generichash(var_message.clone(), var_key.clone(),
		rt.new_int(outLen))
	return iife_result_20
}

fn crypto_generichash_final(var_ctx rt.PhpVal, outputLength i64) rt.PhpVal {
	mut var_outputLength := outputLength
	mut iife_temp_21 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_21 := iife_temp_21.crypto_generichash_final(var_ctx.clone(),
		rt.new_int(outputLength))
	return iife_result_21
}

fn crypto_generichash_init(var_key rt.PhpVal, outLen i64) rt.PhpVal {
	mut var_outLen := outLen
	mut iife_temp_22 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_22 := iife_temp_22.crypto_generichash_init(var_key.clone(), rt.new_int(outLen))
	return iife_result_22
}

fn crypto_generichash_update(var_ctx rt.PhpVal, message string) {
	mut var_message := message
	mut iife_temp_23 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_23 := iife_temp_23.crypto_generichash_update(var_ctx.clone(),
		rt.new_string(message))
}

fn crypto_kx(var_my_secret rt.PhpVal, var_their_public rt.PhpVal, var_client_public rt.PhpVal, var_server_public rt.PhpVal) rt.PhpVal {
	mut iife_temp_24 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_24 := iife_temp_24.crypto_kx(var_my_secret.clone(), var_their_public.clone(),
		var_client_public.clone(), var_server_public.clone(), rt.new_bool(true))
	return iife_result_24
}

fn crypto_pwhash(var_outlen rt.PhpVal, var_passwd rt.PhpVal, var_salt rt.PhpVal, var_opslimit rt.PhpVal, var_memlimit rt.PhpVal) rt.PhpVal {
	mut iife_temp_25 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_25 := iife_temp_25.crypto_pwhash(var_outlen.clone(), var_passwd.clone(),
		var_salt.clone(), var_opslimit.clone(), var_memlimit.clone())
	return iife_result_25
}

fn crypto_pwhash_str(var_passwd rt.PhpVal, var_opslimit rt.PhpVal, var_memlimit rt.PhpVal) rt.PhpVal {
	mut iife_temp_26 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_26 := iife_temp_26.crypto_pwhash_str(var_passwd.clone(), var_opslimit.clone(),
		var_memlimit.clone())
	return iife_result_26
}

fn crypto_pwhash_str_verify(var_passwd rt.PhpVal, var_hash rt.PhpVal) rt.PhpVal {
	mut iife_temp_27 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_27 := iife_temp_27.crypto_pwhash_str_verify(var_passwd.clone(),
		var_hash.clone())
	return iife_result_27
}

fn crypto_pwhash_scryptsalsa208sha256(var_outlen rt.PhpVal, var_passwd rt.PhpVal, var_salt rt.PhpVal, var_opslimit rt.PhpVal, var_memlimit rt.PhpVal) rt.PhpVal {
	mut iife_temp_28 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_28 := iife_temp_28.crypto_pwhash_scryptsalsa208sha256(var_outlen.clone(),
		var_passwd.clone(), var_salt.clone(), var_opslimit.clone(), var_memlimit.clone())
	return iife_result_28
}

fn crypto_pwhash_scryptsalsa208sha256_str(var_passwd rt.PhpVal, var_opslimit rt.PhpVal, var_memlimit rt.PhpVal) rt.PhpVal {
	mut iife_temp_29 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_29 := iife_temp_29.crypto_pwhash_scryptsalsa208sha256_str(var_passwd.clone(),
		var_opslimit.clone(), var_memlimit.clone())
	return iife_result_29
}

fn crypto_pwhash_scryptsalsa208sha256_str_verify(var_passwd rt.PhpVal, var_hash rt.PhpVal) rt.PhpVal {
	mut iife_temp_30 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_30 := iife_temp_30.crypto_pwhash_scryptsalsa208sha256_str_verify(var_passwd.clone(),
		var_hash.clone())
	return iife_result_30
}

fn crypto_scalarmult(var_n rt.PhpVal, var_p rt.PhpVal) rt.PhpVal {
	mut iife_temp_31 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_31 := iife_temp_31.crypto_scalarmult(var_n.clone(), var_p.clone())
	return iife_result_31
}

fn crypto_scalarmult_base(var_n rt.PhpVal) rt.PhpVal {
	mut iife_temp_32 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_32 := iife_temp_32.crypto_scalarmult_base(var_n.clone())
	return iife_result_32
}

fn crypto_secretbox(var_message rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_33 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_33 := iife_temp_33.crypto_secretbox(var_message.clone(), var_nonce.clone(),
		var_key.clone())
	return iife_result_33
}

fn crypto_secretbox_open(var_message rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) bool {
	mut var_ex := rt.new_null()
	mut iife_temp_34 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_34 := iife_temp_34.crypto_secretbox_open(var_message.clone(),
		var_nonce.clone(), var_key.clone())
	return iife_result_34.to_bool()
	unsafe {
		goto end_label_6
	}
	catch_label_6:
	mut var_e_6 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_6, 'Sodium_TypeError') {
		var_ex = var_e_6.clone()
		return false
		unsafe {
			goto end_label_6
		}
	} else if rt.instance_of(var_e_6, 'Sodium_SodiumException') {
		var_ex = var_e_6.clone()
		return false
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
	return false
}

fn crypto_shorthash(var_message rt.PhpVal, key string) rt.PhpVal {
	mut var_key := key
	mut iife_temp_35 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_35 := iife_temp_35.crypto_shorthash(var_message.clone(), rt.new_string(key))
	return iife_result_35
}

fn crypto_sign(var_message rt.PhpVal, var_sk rt.PhpVal) rt.PhpVal {
	mut iife_temp_36 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_36 := iife_temp_36.crypto_sign(var_message.clone(), var_sk.clone())
	return iife_result_36
}

fn crypto_sign_detached(var_message rt.PhpVal, var_sk rt.PhpVal) rt.PhpVal {
	mut iife_temp_37 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_37 := iife_temp_37.crypto_sign_detached(var_message.clone(), var_sk.clone())
	return iife_result_37
}

fn crypto_sign_keypair() rt.PhpVal {
	mut iife_temp_38 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_38 := iife_temp_38.crypto_sign_keypair()
	return iife_result_38
}

fn crypto_sign_open(var_signedMessage rt.PhpVal, var_pk rt.PhpVal) bool {
	mut var_ex := rt.new_null()
	mut iife_temp_39 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_39 := iife_temp_39.crypto_sign_open(var_signedMessage.clone(), var_pk.clone())
	return iife_result_39.to_bool()
	unsafe {
		goto end_label_7
	}
	catch_label_7:
	mut var_e_7 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_7, 'Sodium_TypeError') {
		var_ex = var_e_7.clone()
		return false
		unsafe {
			goto end_label_7
		}
	} else if rt.instance_of(var_e_7, 'Sodium_SodiumException') {
		var_ex = var_e_7.clone()
		return false
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
	return false
}

fn crypto_sign_publickey(var_keypair rt.PhpVal) rt.PhpVal {
	mut iife_temp_40 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_40 := iife_temp_40.crypto_sign_publickey(var_keypair.clone())
	return iife_result_40
}

fn crypto_sign_publickey_from_secretkey(var_sk rt.PhpVal) rt.PhpVal {
	mut iife_temp_41 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_41 := iife_temp_41.crypto_sign_publickey_from_secretkey(var_sk.clone())
	return iife_result_41
}

fn crypto_sign_secretkey(var_keypair rt.PhpVal) rt.PhpVal {
	mut iife_temp_42 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_42 := iife_temp_42.crypto_sign_secretkey(var_keypair.clone())
	return iife_result_42
}

fn crypto_sign_seed_keypair(var_seed rt.PhpVal) rt.PhpVal {
	mut iife_temp_43 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_43 := iife_temp_43.crypto_sign_seed_keypair(var_seed.clone())
	return iife_result_43
}

fn crypto_sign_verify_detached(var_signature rt.PhpVal, var_message rt.PhpVal, var_pk rt.PhpVal) rt.PhpVal {
	mut iife_temp_44 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_44 := iife_temp_44.crypto_sign_verify_detached(var_signature.clone(),
		var_message.clone(), var_pk.clone())
	return iife_result_44
}

fn crypto_sign_ed25519_pk_to_curve25519(var_pk rt.PhpVal) rt.PhpVal {
	mut iife_temp_45 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_45 := iife_temp_45.crypto_sign_ed25519_pk_to_curve25519(var_pk.clone())
	return iife_result_45
}

fn crypto_sign_ed25519_sk_to_curve25519(var_sk rt.PhpVal) rt.PhpVal {
	mut iife_temp_46 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_46 := iife_temp_46.crypto_sign_ed25519_sk_to_curve25519(var_sk.clone())
	return iife_result_46
}

fn crypto_stream(var_len rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_47 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_47 := iife_temp_47.crypto_stream(var_len.clone(), var_nonce.clone(),
		var_key.clone())
	return iife_result_47
}

fn crypto_stream_xor(var_message rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_48 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_48 := iife_temp_48.crypto_stream_xor(var_message.clone(), var_nonce.clone(),
		var_key.clone())
	return iife_result_48
}

fn hex2bin(var_string rt.PhpVal) rt.PhpVal {
	mut iife_temp_49 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_49 := iife_temp_49.hex2bin(var_string.clone())
	return iife_result_49
}

fn memcmp(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	mut iife_temp_50 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_50 := iife_temp_50.memcmp(var_a.clone(), var_b.clone())
	return iife_result_50
}

fn memzero(var_str rt.PhpVal) {
	mut iife_temp_51 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_51 := iife_temp_51.memzero(var_str.clone())
}

fn randombytes_buf(var_amount rt.PhpVal) rt.PhpVal {
	mut iife_temp_52 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_52 := iife_temp_52.randombytes_buf(var_amount.clone())
	return iife_result_52
}

fn randombytes_uniform(var_upperLimit rt.PhpVal) rt.PhpVal {
	mut iife_temp_53 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_53 := iife_temp_53.randombytes_uniform(var_upperLimit.clone())
	return iife_result_53
}

fn randombytes_random16() rt.PhpVal {
	mut iife_temp_54 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_54 := iife_temp_54.randombytes_random16()
	return iife_result_54
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
	if !(rt.call_function('is_callable', [rt.new_string('\\Sodium\\bin2hex')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('\\Sodium\\compare')])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_aead_aes256gcm_decrypt'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_aead_aes256gcm_encrypt'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_aead_aes256gcm_is_available'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_aead_chacha20poly1305_decrypt'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_aead_chacha20poly1305_encrypt'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_aead_chacha20poly1305_ietf_decrypt'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_aead_chacha20poly1305_ietf_encrypt'),
	])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('\\Sodium\\crypto_auth')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('\\Sodium\\crypto_auth_verify')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('\\Sodium\\crypto_box')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('\\Sodium\\crypto_box_keypair')])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_box_keypair_from_secretkey_and_publickey'),
	])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('\\Sodium\\crypto_box_open')])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_box_publickey'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_box_publickey_from_secretkey'),
	])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('\\Sodium\\crypto_box_seal')])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_box_seal_open'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_box_secretkey'),
	])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('\\Sodium\\crypto_generichash')])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_generichash_final'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_generichash_init'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_generichash_update'),
	])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('\\Sodium\\crypto_kx')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('\\Sodium\\crypto_pwhash')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('\\Sodium\\crypto_pwhash_str')])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_pwhash_str_verify'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_pwhash_scryptsalsa208sha256'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_pwhash_scryptsalsa208sha256_str'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_pwhash_scryptsalsa208sha256_str_verify'),
	])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('\\Sodium\\crypto_scalarmult')])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_scalarmult_base'),
	])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('\\Sodium\\crypto_secretbox')])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_secretbox_open'),
	])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('\\Sodium\\crypto_shorthash')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('\\Sodium\\crypto_sign')])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_sign_detached'),
	])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('\\Sodium\\crypto_sign_keypair')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('\\Sodium\\crypto_sign_open')])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_sign_publickey'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_sign_publickey_from_secretkey'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_sign_secretkey'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_sign_seed_keypair'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_sign_verify_detached'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_sign_ed25519_pk_to_curve25519'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_sign_ed25519_sk_to_curve25519'),
	])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('\\Sodium\\crypto_stream')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('\\Sodium\\crypto_stream_xor')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('\\Sodium\\hex2bin')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('\\Sodium\\memcmp')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('\\Sodium\\memzero')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('\\Sodium\\randombytes_buf')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('\\Sodium\\randombytes_uniform')])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\randombytes_random16'),
	])) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('\\Sodium\\CRYPTO_AUTH_BYTES'),
	])))))
	{
		rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
			'/constants.php', '4')
	}
}
