import rt

fn sodium_add(var_string1 rt.PhpVal, var_string2 rt.PhpVal) {
	mut iife_temp_0 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_0 := iife_temp_0.add(var_string1.clone(), var_string2.clone())
}

fn sodium_base642bin(var_string rt.PhpVal, var_variant rt.PhpVal, ignore string) rt.PhpVal {
	mut var_ignore := ignore
	mut iife_temp_1 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_1 := iife_temp_1.base642bin(var_string.clone(), var_variant.clone(),
		rt.new_string(ignore))
	return iife_result_1
}

fn sodium_bin2base64(var_string rt.PhpVal, var_variant rt.PhpVal) rt.PhpVal {
	mut iife_temp_2 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_2 := iife_temp_2.bin2base64(var_string.clone(), var_variant.clone())
	return iife_result_2
}

fn sodium_bin2hex(var_string rt.PhpVal) rt.PhpVal {
	mut iife_temp_3 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_3 := iife_temp_3.bin2hex(var_string.clone())
	return iife_result_3
}

fn sodium_compare(var_string1 rt.PhpVal, var_string2 rt.PhpVal) rt.PhpVal {
	mut iife_temp_4 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_4 := iife_temp_4.compare(var_string1.clone(), var_string2.clone())
	return iife_result_4
}

fn sodium_crypto_aead_aes256gcm_decrypt(var_ciphertext rt.PhpVal, var_additional_data rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) bool {
	mut var_ex := rt.new_null()
	mut iife_temp_5 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_5 := iife_temp_5.crypto_aead_aes256gcm_decrypt(var_ciphertext.clone(),
		var_additional_data.clone(), var_nonce.clone(), var_key.clone())
	return iife_result_5.to_bool()
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Error') {
		var_ex = var_e_1.clone()
		return false
		unsafe {
			goto end_label_1
		}
	} else if rt.instance_of(var_e_1, 'Exception') {
		var_ex = var_e_1.clone()
		if rt.is_true(rt.new_bool(rt.instance_of(var_ex, 'SodiumException')))
			&& rt.is_true(rt.identical(rt.call_method(var_ex, 'getMessage', []rt.PhpVal{}), rt.new_string('AES-256-GCM is not available'))) {
			rt.throw_exception(var_ex)
		}
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

fn sodium_crypto_aead_aes256gcm_encrypt(var_message rt.PhpVal, var_additional_data rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_6 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_6 := iife_temp_6.crypto_aead_aes256gcm_encrypt(var_message.clone(),
		var_additional_data.clone(), var_nonce.clone(), var_key.clone())
	return iife_result_6
}

fn sodium_crypto_aead_aes256gcm_is_available() rt.PhpVal {
	mut iife_temp_7 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_7 := iife_temp_7.crypto_aead_aes256gcm_is_available()
	return iife_result_7
}

fn sodium_crypto_aead_chacha20poly1305_decrypt(var_ciphertext rt.PhpVal, var_additional_data rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) bool {
	mut var_ex := rt.new_null()
	mut iife_temp_8 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_8 := iife_temp_8.crypto_aead_chacha20poly1305_decrypt(var_ciphertext.clone(),
		var_additional_data.clone(), var_nonce.clone(), var_key.clone())
	return iife_result_8.to_bool()
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Error') {
		var_ex = var_e_2.clone()
		return false
		unsafe {
			goto end_label_2
		}
	} else if rt.instance_of(var_e_2, 'Exception') {
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

fn sodium_crypto_aead_chacha20poly1305_encrypt(var_message rt.PhpVal, var_additional_data rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_9 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_9 := iife_temp_9.crypto_aead_chacha20poly1305_encrypt(var_message.clone(),
		var_additional_data.clone(), var_nonce.clone(), var_key.clone())
	return iife_result_9
}

fn sodium_crypto_aead_chacha20poly1305_keygen() rt.PhpVal {
	mut iife_temp_10 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_10 := iife_temp_10.crypto_aead_chacha20poly1305_keygen()
	return iife_result_10
}

fn sodium_crypto_aead_chacha20poly1305_ietf_decrypt(var_message rt.PhpVal, var_additional_data rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) bool {
	mut var_ex := rt.new_null()
	mut iife_temp_11 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_11 := iife_temp_11.crypto_aead_chacha20poly1305_ietf_decrypt(var_message.clone(),
		var_additional_data.clone(), var_nonce.clone(), var_key.clone())
	return iife_result_11.to_bool()
	unsafe {
		goto end_label_3
	}
	catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Error') {
		var_ex = var_e_3.clone()
		return false
		unsafe {
			goto end_label_3
		}
	} else if rt.instance_of(var_e_3, 'Exception') {
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

fn sodium_crypto_aead_chacha20poly1305_ietf_encrypt(var_message rt.PhpVal, var_additional_data rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_12 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_12 := iife_temp_12.crypto_aead_chacha20poly1305_ietf_encrypt(var_message.clone(),
		var_additional_data.clone(), var_nonce.clone(), var_key.clone())
	return iife_result_12
}

fn sodium_crypto_aead_chacha20poly1305_ietf_keygen() rt.PhpVal {
	mut iife_temp_13 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_13 := iife_temp_13.crypto_aead_chacha20poly1305_ietf_keygen()
	return iife_result_13
}

fn sodium_crypto_aead_xchacha20poly1305_ietf_decrypt(var_ciphertext rt.PhpVal, var_additional_data rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) bool {
	mut var_ex := rt.new_null()
	mut iife_temp_14 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_14 := iife_temp_14.crypto_aead_xchacha20poly1305_ietf_decrypt(var_ciphertext.clone(),
		var_additional_data.clone(), var_nonce.clone(), var_key.clone(), rt.new_bool(true))
	return iife_result_14.to_bool()
	unsafe {
		goto end_label_4
	}
	catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'Error') {
		var_ex = var_e_4.clone()
		return false
		unsafe {
			goto end_label_4
		}
	} else if rt.instance_of(var_e_4, 'Exception') {
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

fn sodium_crypto_aead_xchacha20poly1305_ietf_encrypt(var_message rt.PhpVal, var_additional_data rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_15 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_15 := iife_temp_15.crypto_aead_xchacha20poly1305_ietf_encrypt(var_message.clone(),
		var_additional_data.clone(), var_nonce.clone(), var_key.clone(), rt.new_bool(true))
	return iife_result_15
}

fn sodium_crypto_aead_xchacha20poly1305_ietf_keygen() rt.PhpVal {
	mut iife_temp_16 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_16 := iife_temp_16.crypto_aead_xchacha20poly1305_ietf_keygen()
	return iife_result_16
}

fn sodium_crypto_auth(var_message rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_17 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_17 := iife_temp_17.crypto_auth(var_message.clone(), var_key.clone())
	return iife_result_17
}

fn sodium_crypto_auth_keygen() rt.PhpVal {
	mut iife_temp_18 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_18 := iife_temp_18.crypto_auth_keygen()
	return iife_result_18
}

fn sodium_crypto_auth_verify(var_mac rt.PhpVal, var_message rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_19 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_19 := iife_temp_19.crypto_auth_verify(var_mac.clone(), var_message.clone(),
		var_key.clone())
	return iife_result_19
}

fn sodium_crypto_box(var_message rt.PhpVal, var_nonce rt.PhpVal, var_key_pair rt.PhpVal) rt.PhpVal {
	mut iife_temp_20 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_20 := iife_temp_20.crypto_box(var_message.clone(), var_nonce.clone(),
		var_key_pair.clone())
	return iife_result_20
}

fn sodium_crypto_box_keypair() rt.PhpVal {
	mut iife_temp_21 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_21 := iife_temp_21.crypto_box_keypair()
	return iife_result_21
}

fn sodium_crypto_box_keypair_from_secretkey_and_publickey(var_secret_key rt.PhpVal, var_public_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_22 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_22 := iife_temp_22.crypto_box_keypair_from_secretkey_and_publickey(var_secret_key.clone(),
		var_public_key.clone())
	return iife_result_22
}

fn sodium_crypto_box_open(var_ciphertext rt.PhpVal, var_nonce rt.PhpVal, var_key_pair rt.PhpVal) bool {
	mut var_ex := rt.new_null()
	mut iife_temp_23 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_23 := iife_temp_23.crypto_box_open(var_ciphertext.clone(), var_nonce.clone(),
		var_key_pair.clone())
	return iife_result_23.to_bool()
	unsafe {
		goto end_label_5
	}
	catch_label_5:
	mut var_e_5 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_5, 'Error') {
		var_ex = var_e_5.clone()
		return false
		unsafe {
			goto end_label_5
		}
	} else if rt.instance_of(var_e_5, 'Exception') {
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

fn sodium_crypto_box_publickey(var_key_pair rt.PhpVal) rt.PhpVal {
	mut iife_temp_24 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_24 := iife_temp_24.crypto_box_publickey(var_key_pair.clone())
	return iife_result_24
}

fn sodium_crypto_box_publickey_from_secretkey(var_secret_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_25 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_25 := iife_temp_25.crypto_box_publickey_from_secretkey(var_secret_key.clone())
	return iife_result_25
}

fn sodium_crypto_box_seal(var_message rt.PhpVal, var_public_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_26 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_26 := iife_temp_26.crypto_box_seal(var_message.clone(), var_public_key.clone())
	return iife_result_26
}

fn sodium_crypto_box_seal_open(var_message rt.PhpVal, var_key_pair rt.PhpVal) bool {
	mut var_ex := rt.new_null()
	mut iife_temp_27 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_27 := iife_temp_27.crypto_box_seal_open(var_message.clone(),
		var_key_pair.clone())
	return iife_result_27.to_bool()
	unsafe {
		goto end_label_6
	}
	catch_label_6:
	mut var_e_6 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_6, 'SodiumException') {
		var_ex = var_e_6.clone()
		if rt.is_true(rt.identical(rt.call_method(var_ex, 'getMessage', []rt.PhpVal{}),
			rt.new_string('Argument 2 must be CRYPTO_BOX_KEYPAIRBYTES long.')))
		{
			rt.throw_exception(var_ex)
		}
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

fn sodium_crypto_box_secretkey(var_key_pair rt.PhpVal) rt.PhpVal {
	mut iife_temp_28 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_28 := iife_temp_28.crypto_box_secretkey(var_key_pair.clone())
	return iife_result_28
}

fn sodium_crypto_box_seed_keypair(var_seed rt.PhpVal) rt.PhpVal {
	mut iife_temp_29 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_29 := iife_temp_29.crypto_box_seed_keypair(var_seed.clone())
	return iife_result_29
}

fn sodium_crypto_generichash(var_message rt.PhpVal, var_key rt.PhpVal, length i64) rt.PhpVal {
	mut var_length := length
	mut iife_temp_30 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_30 := iife_temp_30.crypto_generichash(var_message.clone(), var_key.clone(),
		rt.new_int(length))
	return iife_result_30
}

fn sodium_crypto_generichash_final(var_state rt.PhpVal, outputLength i64) rt.PhpVal {
	mut var_outputLength := outputLength
	mut iife_temp_31 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_31 := iife_temp_31.crypto_generichash_final(var_state.clone(),
		rt.new_int(outputLength))
	return iife_result_31
}

fn sodium_crypto_generichash_init(var_key rt.PhpVal, length i64) rt.PhpVal {
	mut var_length := length
	mut iife_temp_32 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_32 := iife_temp_32.crypto_generichash_init(var_key.clone(), rt.new_int(length))
	return iife_result_32
}

fn sodium_crypto_generichash_keygen() rt.PhpVal {
	mut iife_temp_33 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_33 := iife_temp_33.crypto_generichash_keygen()
	return iife_result_33
}

fn sodium_crypto_generichash_update(var_state rt.PhpVal, message string) {
	mut var_message := message
	mut iife_temp_34 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_34 := iife_temp_34.crypto_generichash_update(var_state.clone(),
		rt.new_string(message))
}

fn sodium_crypto_kdf_keygen() rt.PhpVal {
	mut iife_temp_35 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_35 := iife_temp_35.crypto_kdf_keygen()
	return iife_result_35
}

fn sodium_crypto_kdf_derive_from_key(var_subkey_length rt.PhpVal, var_subkey_id rt.PhpVal, var_context rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_36 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_36 := iife_temp_36.crypto_kdf_derive_from_key(var_subkey_length.clone(),
		var_subkey_id.clone(), var_context.clone(), var_key.clone())
	return iife_result_36
}

fn sodium_crypto_kx(var_my_secret rt.PhpVal, var_their_public rt.PhpVal, var_client_public rt.PhpVal, var_server_public rt.PhpVal) rt.PhpVal {
	mut iife_temp_37 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_37 := iife_temp_37.crypto_kx(var_my_secret.clone(), var_their_public.clone(),
		var_client_public.clone(), var_server_public.clone())
	return iife_result_37
}

fn sodium_crypto_kx_seed_keypair(var_seed rt.PhpVal) rt.PhpVal {
	mut iife_temp_38 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_38 := iife_temp_38.crypto_kx_seed_keypair(var_seed.clone())
	return iife_result_38
}

fn sodium_crypto_kx_keypair() rt.PhpVal {
	mut iife_temp_39 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_39 := iife_temp_39.crypto_kx_keypair()
	return iife_result_39
}

fn sodium_crypto_kx_client_session_keys(var_client_key_pair rt.PhpVal, var_server_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_40 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_40 := iife_temp_40.crypto_kx_client_session_keys(var_client_key_pair.clone(),
		var_server_key.clone())
	return iife_result_40
}

fn sodium_crypto_kx_server_session_keys(var_server_key_pair rt.PhpVal, var_client_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_41 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_41 := iife_temp_41.crypto_kx_server_session_keys(var_server_key_pair.clone(),
		var_client_key.clone())
	return iife_result_41
}

fn sodium_crypto_kx_secretkey(var_key_pair rt.PhpVal) rt.PhpVal {
	mut iife_temp_42 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_42 := iife_temp_42.crypto_kx_secretkey(var_key_pair.clone())
	return iife_result_42
}

fn sodium_crypto_kx_publickey(var_key_pair rt.PhpVal) rt.PhpVal {
	mut iife_temp_43 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_43 := iife_temp_43.crypto_kx_publickey(var_key_pair.clone())
	return iife_result_43
}

fn sodium_crypto_pwhash(var_length rt.PhpVal, var_passwd rt.PhpVal, var_salt rt.PhpVal, var_opslimit rt.PhpVal, var_memlimit rt.PhpVal, var_algo rt.PhpVal) rt.PhpVal {
	mut iife_temp_44 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_44 := iife_temp_44.crypto_pwhash(var_length.clone(), var_passwd.clone(),
		var_salt.clone(), var_opslimit.clone(), var_memlimit.clone(), var_algo.clone())
	return iife_result_44
}

fn sodium_crypto_pwhash_str(var_passwd rt.PhpVal, var_opslimit rt.PhpVal, var_memlimit rt.PhpVal) rt.PhpVal {
	mut iife_temp_45 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_45 := iife_temp_45.crypto_pwhash_str(var_passwd.clone(), var_opslimit.clone(),
		var_memlimit.clone())
	return iife_result_45
}

fn sodium_crypto_pwhash_str_needs_rehash(var_hash rt.PhpVal, var_opslimit rt.PhpVal, var_memlimit rt.PhpVal) rt.PhpVal {
	mut iife_temp_46 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_46 := iife_temp_46.crypto_pwhash_str_needs_rehash(var_hash.clone(),
		var_opslimit.clone(), var_memlimit.clone())
	return iife_result_46
}

fn sodium_crypto_pwhash_str_verify(var_passwd rt.PhpVal, var_hash rt.PhpVal) rt.PhpVal {
	mut iife_temp_47 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_47 := iife_temp_47.crypto_pwhash_str_verify(var_passwd.clone(),
		var_hash.clone())
	return iife_result_47
}

fn sodium_crypto_pwhash_scryptsalsa208sha256(var_length rt.PhpVal, var_passwd rt.PhpVal, var_salt rt.PhpVal, var_opslimit rt.PhpVal, var_memlimit rt.PhpVal) rt.PhpVal {
	mut iife_temp_48 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_48 := iife_temp_48.crypto_pwhash_scryptsalsa208sha256(var_length.clone(),
		var_passwd.clone(), var_salt.clone(), var_opslimit.clone(), var_memlimit.clone())
	return iife_result_48
}

fn sodium_crypto_pwhash_scryptsalsa208sha256_str(var_passwd rt.PhpVal, var_opslimit rt.PhpVal, var_memlimit rt.PhpVal) rt.PhpVal {
	mut iife_temp_49 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_49 := iife_temp_49.crypto_pwhash_scryptsalsa208sha256_str(var_passwd.clone(),
		var_opslimit.clone(), var_memlimit.clone())
	return iife_result_49
}

fn sodium_crypto_pwhash_scryptsalsa208sha256_str_verify(var_passwd rt.PhpVal, var_hash rt.PhpVal) rt.PhpVal {
	mut iife_temp_50 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_50 := iife_temp_50.crypto_pwhash_scryptsalsa208sha256_str_verify(var_passwd.clone(),
		var_hash.clone())
	return iife_result_50
}

fn sodium_crypto_scalarmult(var_n rt.PhpVal, var_p rt.PhpVal) rt.PhpVal {
	mut iife_temp_51 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_51 := iife_temp_51.crypto_scalarmult(var_n.clone(), var_p.clone())
	return iife_result_51
}

fn sodium_crypto_scalarmult_base(var_n rt.PhpVal) rt.PhpVal {
	mut iife_temp_52 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_52 := iife_temp_52.crypto_scalarmult_base(var_n.clone())
	return iife_result_52
}

fn sodium_crypto_secretbox(var_message rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_53 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_53 := iife_temp_53.crypto_secretbox(var_message.clone(), var_nonce.clone(),
		var_key.clone())
	return iife_result_53
}

fn sodium_crypto_secretbox_keygen() rt.PhpVal {
	mut iife_temp_54 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_54 := iife_temp_54.crypto_secretbox_keygen()
	return iife_result_54
}

fn sodium_crypto_secretbox_open(var_ciphertext rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) bool {
	mut var_ex := rt.new_null()
	mut iife_temp_55 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_55 := iife_temp_55.crypto_secretbox_open(var_ciphertext.clone(),
		var_nonce.clone(), var_key.clone())
	return iife_result_55.to_bool()
	unsafe {
		goto end_label_7
	}
	catch_label_7:
	mut var_e_7 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_7, 'Error') {
		var_ex = var_e_7.clone()
		return false
		unsafe {
			goto end_label_7
		}
	} else if rt.instance_of(var_e_7, 'Exception') {
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

fn sodium_crypto_secretstream_xchacha20poly1305_init_push(var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_56 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_56 :=
		iife_temp_56.crypto_secretstream_xchacha20poly1305_init_push(var_key.clone())
	return iife_result_56
}

fn sodium_crypto_secretstream_xchacha20poly1305_push(var_state rt.PhpVal, var_message rt.PhpVal, additional_data string, tag i64) rt.PhpVal {
	mut var_additional_data := additional_data
	mut var_tag := tag
	mut iife_temp_57 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_57 := iife_temp_57.crypto_secretstream_xchacha20poly1305_push(var_state.clone(),
		var_message.clone(), rt.new_string(additional_data), rt.new_int(tag))
	return iife_result_57
}

fn sodium_crypto_secretstream_xchacha20poly1305_init_pull(var_header rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_58 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_58 := iife_temp_58.crypto_secretstream_xchacha20poly1305_init_pull(var_header.clone(),
		var_key.clone())
	return iife_result_58
}

fn sodium_crypto_secretstream_xchacha20poly1305_pull(var_state rt.PhpVal, var_ciphertext rt.PhpVal, additional_data string) rt.PhpVal {
	mut var_additional_data := additional_data
	mut iife_temp_59 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_59 := iife_temp_59.crypto_secretstream_xchacha20poly1305_pull(var_state.clone(),
		var_ciphertext.clone(), rt.new_string(additional_data))
	return iife_result_59
}

fn sodium_crypto_secretstream_xchacha20poly1305_rekey(var_state rt.PhpVal) {
	mut iife_temp_60 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_60 :=
		iife_temp_60.crypto_secretstream_xchacha20poly1305_rekey(var_state.clone())
}

fn sodium_crypto_secretstream_xchacha20poly1305_keygen() rt.PhpVal {
	mut iife_temp_61 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_61 := iife_temp_61.crypto_secretstream_xchacha20poly1305_keygen()
	return iife_result_61
}

fn sodium_crypto_shorthash(var_message rt.PhpVal, key string) rt.PhpVal {
	mut var_key := key
	mut iife_temp_62 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_62 := iife_temp_62.crypto_shorthash(var_message.clone(), rt.new_string(key))
	return iife_result_62
}

fn sodium_crypto_shorthash_keygen() rt.PhpVal {
	mut iife_temp_63 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_63 := iife_temp_63.crypto_shorthash_keygen()
	return iife_result_63
}

fn sodium_crypto_sign(var_message rt.PhpVal, var_secret_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_64 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_64 := iife_temp_64.crypto_sign(var_message.clone(), var_secret_key.clone())
	return iife_result_64
}

fn sodium_crypto_sign_detached(var_message rt.PhpVal, var_secret_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_65 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_65 := iife_temp_65.crypto_sign_detached(var_message.clone(),
		var_secret_key.clone())
	return iife_result_65
}

fn sodium_crypto_sign_keypair_from_secretkey_and_publickey(var_secret_key rt.PhpVal, var_public_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_66 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_66 := iife_temp_66.crypto_sign_keypair_from_secretkey_and_publickey(var_secret_key.clone(),
		var_public_key.clone())
	return iife_result_66
}

fn sodium_crypto_sign_keypair() rt.PhpVal {
	mut iife_temp_67 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_67 := iife_temp_67.crypto_sign_keypair()
	return iife_result_67
}

fn sodium_crypto_sign_open(var_signedMessage rt.PhpVal, var_public_key rt.PhpVal) bool {
	mut var_ex := rt.new_null()
	mut iife_temp_68 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_68 := iife_temp_68.crypto_sign_open(var_signedMessage.clone(),
		var_public_key.clone())
	return iife_result_68.to_bool()
	unsafe {
		goto end_label_8
	}
	catch_label_8:
	mut var_e_8 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_8, 'Error') {
		var_ex = var_e_8.clone()
		return false
		unsafe {
			goto end_label_8
		}
	} else if rt.instance_of(var_e_8, 'Exception') {
		var_ex = var_e_8.clone()
		return false
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
	return false
}

fn sodium_crypto_sign_publickey(var_key_pair rt.PhpVal) rt.PhpVal {
	mut iife_temp_69 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_69 := iife_temp_69.crypto_sign_publickey(var_key_pair.clone())
	return iife_result_69
}

fn sodium_crypto_sign_publickey_from_secretkey(var_secret_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_70 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_70 := iife_temp_70.crypto_sign_publickey_from_secretkey(var_secret_key.clone())
	return iife_result_70
}

fn sodium_crypto_sign_secretkey(var_key_pair rt.PhpVal) rt.PhpVal {
	mut iife_temp_71 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_71 := iife_temp_71.crypto_sign_secretkey(var_key_pair.clone())
	return iife_result_71
}

fn sodium_crypto_sign_seed_keypair(var_seed rt.PhpVal) rt.PhpVal {
	mut iife_temp_72 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_72 := iife_temp_72.crypto_sign_seed_keypair(var_seed.clone())
	return iife_result_72
}

fn sodium_crypto_sign_verify_detached(var_signature rt.PhpVal, var_message rt.PhpVal, var_public_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_73 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_73 := iife_temp_73.crypto_sign_verify_detached(var_signature.clone(),
		var_message.clone(), var_public_key.clone())
	return iife_result_73
}

fn sodium_crypto_sign_ed25519_pk_to_curve25519(var_public_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_74 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_74 := iife_temp_74.crypto_sign_ed25519_pk_to_curve25519(var_public_key.clone())
	return iife_result_74
}

fn sodium_crypto_sign_ed25519_sk_to_curve25519(var_secret_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_75 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_75 := iife_temp_75.crypto_sign_ed25519_sk_to_curve25519(var_secret_key.clone())
	return iife_result_75
}

fn sodium_crypto_stream(var_length rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_76 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_76 := iife_temp_76.crypto_stream(var_length.clone(), var_nonce.clone(),
		var_key.clone())
	return iife_result_76
}

fn sodium_crypto_stream_keygen() rt.PhpVal {
	mut iife_temp_77 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_77 := iife_temp_77.crypto_stream_keygen()
	return iife_result_77
}

fn sodium_crypto_stream_xor(var_message rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_78 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_78 := iife_temp_78.crypto_stream_xor(var_message.clone(), var_nonce.clone(),
		var_key.clone())
	return iife_result_78
}

fn sodium_hex2bin(var_string rt.PhpVal, ignore string) rt.PhpVal {
	mut var_ignore := ignore
	mut iife_temp_79 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_79 := iife_temp_79.hex2bin(var_string.clone(), rt.new_string(ignore))
	return iife_result_79
}

fn sodium_increment(var_string rt.PhpVal) {
	mut iife_temp_80 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_80 := iife_temp_80.increment(var_string.clone())
}

fn sodium_library_version_major() rt.PhpVal {
	mut iife_temp_81 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_81 := iife_temp_81.library_version_major()
	return iife_result_81
}

fn sodium_library_version_minor() rt.PhpVal {
	mut iife_temp_82 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_82 := iife_temp_82.library_version_minor()
	return iife_result_82
}

fn sodium_version_string() rt.PhpVal {
	mut iife_temp_83 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_83 := iife_temp_83.version_string()
	return iife_result_83
}

fn sodium_memcmp(var_string1 rt.PhpVal, var_string2 rt.PhpVal) rt.PhpVal {
	mut iife_temp_84 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_84 := iife_temp_84.memcmp(var_string1.clone(), var_string2.clone())
	return iife_result_84
}

fn sodium_memzero(var_string rt.PhpVal) {
	mut iife_temp_85 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_85 := iife_temp_85.memzero(var_string.clone())
}

fn sodium_pad(var_unpadded rt.PhpVal, var_block_size rt.PhpVal) rt.PhpVal {
	mut iife_temp_86 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_86 := iife_temp_86.pad(var_unpadded.clone(), var_block_size.clone(),
		rt.new_bool(true))
	return iife_result_86
}

fn sodium_unpad(var_padded rt.PhpVal, var_block_size rt.PhpVal) rt.PhpVal {
	mut iife_temp_87 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_87 := iife_temp_87.unpad(var_padded.clone(), var_block_size.clone(),
		rt.new_bool(true))
	return iife_result_87
}

fn sodium_randombytes_buf(var_amount rt.PhpVal) rt.PhpVal {
	mut iife_temp_88 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_88 := iife_temp_88.randombytes_buf(var_amount.clone())
	return iife_result_88
}

fn sodium_randombytes_uniform(var_upperLimit rt.PhpVal) rt.PhpVal {
	mut iife_temp_89 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_89 := iife_temp_89.randombytes_uniform(var_upperLimit.clone())
	return iife_result_89
}

fn sodium_randombytes_random16() rt.PhpVal {
	mut iife_temp_90 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_90 := iife_temp_90.randombytes_random16()
	return iife_result_90
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
		rt.ArrayItem{ key: none, val: 'BASE64_VARIANT_ORIGINAL' },
		rt.ArrayItem{ key: none, val: 'BASE64_VARIANT_ORIGINAL_NO_PADDING' },
		rt.ArrayItem{ key: none, val: 'BASE64_VARIANT_URLSAFE' },
		rt.ArrayItem{ key: none, val: 'BASE64_VARIANT_URLSAFE_NO_PADDING' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_AES256GCM_KEYBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_AES256GCM_NSECBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_AES256GCM_NPUBBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_AES256GCM_ABYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_CHACHA20POLY1305_KEYBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_CHACHA20POLY1305_NSECBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_CHACHA20POLY1305_NPUBBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_CHACHA20POLY1305_ABYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_CHACHA20POLY1305_IETF_KEYBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_CHACHA20POLY1305_IETF_NSECBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_CHACHA20POLY1305_IETF_NPUBBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_CHACHA20POLY1305_IETF_ABYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_XCHACHA20POLY1305_IETF_KEYBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_XCHACHA20POLY1305_IETF_NSECBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_XCHACHA20POLY1305_IETF_NPUBBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_AEAD_XCHACHA20POLY1305_IETF_ABYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_AUTH_BYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_AUTH_KEYBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_BOX_SEALBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_BOX_SECRETKEYBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_BOX_PUBLICKEYBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_BOX_KEYPAIRBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_BOX_MACBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_BOX_NONCEBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_BOX_SEEDBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_KDF_BYTES_MIN' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_KDF_BYTES_MAX' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_KDF_CONTEXTBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_KDF_KEYBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_KX_BYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_KX_KEYPAIRBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_KX_PRIMITIVE' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_KX_SEEDBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_KX_PUBLICKEYBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_KX_SECRETKEYBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_KX_SESSIONKEYBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_GENERICHASH_BYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_GENERICHASH_BYTES_MIN' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_GENERICHASH_BYTES_MAX' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_GENERICHASH_KEYBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_GENERICHASH_KEYBYTES_MIN' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_GENERICHASH_KEYBYTES_MAX' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_SALTBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_STRPREFIX' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_ALG_ARGON2I13' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_ALG_ARGON2ID13' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_MEMLIMIT_INTERACTIVE' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_OPSLIMIT_INTERACTIVE' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_MEMLIMIT_MODERATE' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_OPSLIMIT_MODERATE' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_MEMLIMIT_SENSITIVE' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_OPSLIMIT_SENSITIVE' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_SCRYPTSALSA208SHA256_SALTBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_SCRYPTSALSA208SHA256_STRPREFIX' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_SCRYPTSALSA208SHA256_MEMLIMIT_INTERACTIVE' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_SCRYPTSALSA208SHA256_OPSLIMIT_INTERACTIVE' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_SCRYPTSALSA208SHA256_MEMLIMIT_SENSITIVE' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_PWHASH_SCRYPTSALSA208SHA256_OPSLIMIT_SENSITIVE' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_SCALARMULT_BYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_SCALARMULT_SCALARBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_SHORTHASH_BYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_SHORTHASH_KEYBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_SECRETBOX_KEYBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_SECRETBOX_MACBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_SECRETBOX_NONCEBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_SECRETSTREAM_XCHACHA20POLY1305_ABYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_SECRETSTREAM_XCHACHA20POLY1305_HEADERBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_SECRETSTREAM_XCHACHA20POLY1305_KEYBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_SECRETSTREAM_XCHACHA20POLY1305_TAG_PUSH' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_SECRETSTREAM_XCHACHA20POLY1305_TAG_PULL' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_SECRETSTREAM_XCHACHA20POLY1305_TAG_REKEY' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_SECRETSTREAM_XCHACHA20POLY1305_TAG_FINAL' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_SECRETSTREAM_XCHACHA20POLY1305_MESSAGEBYTES_MAX' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_SIGN_BYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_SIGN_SEEDBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_SIGN_PUBLICKEYBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_SIGN_SECRETKEYBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_SIGN_KEYPAIRBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_STREAM_KEYBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_STREAM_NONCEBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_STREAM_XCHACHA20_KEYBYTES' },
		rt.ArrayItem{ key: none, val: 'CRYPTO_STREAM_XCHACHA20_NONCEBYTES' },
		rt.ArrayItem{ key: none, val: 'LIBRARY_MAJOR_VERSION' },
		rt.ArrayItem{ key: none, val: 'LIBRARY_MINOR_VERSION' },
		rt.ArrayItem{ key: none, val: 'LIBRARY_VERSION_MAJOR' },
		rt.ArrayItem{ key: none, val: 'LIBRARY_VERSION_MINOR' },
		rt.ArrayItem{ key: none, val: 'VERSION_STRING' },
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
	if !(rt.call_function('is_callable', [rt.new_string('sodium_add')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_base642bin')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_bin2base64')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_bin2hex')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_compare')])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_aead_aes256gcm_decrypt'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_aead_aes256gcm_encrypt'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_aead_aes256gcm_is_available'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_aead_chacha20poly1305_decrypt'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_aead_chacha20poly1305_encrypt'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_aead_chacha20poly1305_keygen'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_aead_chacha20poly1305_ietf_decrypt'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_aead_chacha20poly1305_ietf_encrypt'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_aead_chacha20poly1305_ietf_keygen'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_aead_xchacha20poly1305_ietf_decrypt'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_aead_xchacha20poly1305_ietf_encrypt'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_aead_xchacha20poly1305_ietf_keygen'),
	])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_auth')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_auth_keygen')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_auth_verify')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_box')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_box_keypair')])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_box_keypair_from_secretkey_and_publickey'),
	])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_box_open')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_box_publickey')])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_box_publickey_from_secretkey'),
	])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_box_seal')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_box_seal_open')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_box_secretkey')])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_box_seed_keypair'),
	])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_generichash')])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_generichash_final'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_generichash_init'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_generichash_keygen'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_generichash_update'),
	])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_kdf_keygen')])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_kdf_derive_from_key'),
	])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_kx')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_kx_seed_keypair')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_kx_keypair')])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_kx_client_session_keys'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_kx_server_session_keys'),
	])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_kx_secretkey')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_kx_publickey')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_pwhash')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_pwhash_str')])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_pwhash_str_needs_rehash'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_pwhash_str_verify'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_pwhash_scryptsalsa208sha256'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_pwhash_scryptsalsa208sha256_str'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_pwhash_scryptsalsa208sha256_str_verify'),
	])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_scalarmult')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_scalarmult_base')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_secretbox')])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_secretbox_keygen'),
	])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_secretbox_open')])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_secretstream_xchacha20poly1305_init_push'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_secretstream_xchacha20poly1305_push'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_secretstream_xchacha20poly1305_init_pull'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_secretstream_xchacha20poly1305_pull'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_secretstream_xchacha20poly1305_rekey'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_secretstream_xchacha20poly1305_keygen'),
	])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_shorthash')])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_shorthash_keygen'),
	])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_sign')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_sign_detached')])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_sign_keypair_from_secretkey_and_publickey'),
	])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_sign_keypair')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_sign_open')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_sign_publickey')])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_sign_publickey_from_secretkey'),
	])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_sign_secretkey')])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_sign_seed_keypair'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_sign_verify_detached'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_sign_ed25519_pk_to_curve25519'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_sign_ed25519_sk_to_curve25519'),
	])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_stream')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_stream_keygen')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_crypto_stream_xor')])) {
	}
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
		'/stream-xchacha20.php', '4')
	if !(rt.call_function('is_callable', [rt.new_string('sodium_hex2bin')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_increment')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_library_version_major')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_library_version_minor')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_version_string')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_memcmp')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_memzero')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_pad')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_unpad')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_randombytes_buf')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_randombytes_uniform')])) {
	}
	if !(rt.call_function('is_callable', [rt.new_string('sodium_randombytes_random16')])) {
	}
}
