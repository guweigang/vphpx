import rt

fn bin2hex(var_string rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.bin2hex(arg_0)
	}(var_string.dup())
}

fn compare(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.compare(arg_0, arg_1)
	}(var_a.dup(), var_b.dup())
}

fn crypto_aead_aes256gcm_decrypt(var_message rt.PhpVal, var_assocData rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_aead_aes256gcm_decrypt(arg_0, arg_1, arg_2, arg_3)
	}(var_message.dup(), var_assocData.dup(), var_nonce.dup(), var_key.dup())
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Sodium_TypeError') {
		mut var_ex := var_e_1.dup()
		return rt.new_bool(false)
		unsafe {
			goto end_label_1
		}
	} else if rt.instance_of(var_e_1, 'Sodium_SodiumException') {
		mut var_ex := var_e_1.dup()
		return rt.new_bool(false)
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
	return rt.new_null()
}

fn crypto_aead_aes256gcm_encrypt(var_message rt.PhpVal, var_assocData rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_aead_aes256gcm_encrypt(arg_0, arg_1, arg_2, arg_3)
	}(var_message.dup(), var_assocData.dup(), var_nonce.dup(), var_key.dup())
}

fn crypto_aead_aes256gcm_is_available() rt.PhpVal {
	return fn () rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_aead_aes256gcm_is_available()
	}()
}

fn crypto_aead_chacha20poly1305_decrypt(var_message rt.PhpVal, var_assocData rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_aead_chacha20poly1305_decrypt(arg_0, arg_1, arg_2, arg_3)
	}(var_message.dup(), var_assocData.dup(), var_nonce.dup(), var_key.dup())
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Sodium_TypeError') {
		mut var_ex := var_e_2.dup()
		return rt.new_bool(false)
		unsafe {
			goto end_label_2
		}
	} else if rt.instance_of(var_e_2, 'Sodium_SodiumException') {
		mut var_ex := var_e_2.dup()
		return rt.new_bool(false)
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
	return rt.new_null()
}

fn crypto_aead_chacha20poly1305_encrypt(var_message rt.PhpVal, var_assocData rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_aead_chacha20poly1305_encrypt(arg_0, arg_1, arg_2, arg_3)
	}(var_message.dup(), var_assocData.dup(), var_nonce.dup(), var_key.dup())
}

fn crypto_aead_chacha20poly1305_ietf_decrypt(var_message rt.PhpVal, var_assocData rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_aead_chacha20poly1305_ietf_decrypt(arg_0, arg_1, arg_2, arg_3)
	}(var_message.dup(), var_assocData.dup(), var_nonce.dup(), var_key.dup())
	unsafe {
		goto end_label_3
	}
	catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Sodium_TypeError') {
		mut var_ex := var_e_3.dup()
		return rt.new_bool(false)
		unsafe {
			goto end_label_3
		}
	} else if rt.instance_of(var_e_3, 'Sodium_SodiumException') {
		mut var_ex := var_e_3.dup()
		return rt.new_bool(false)
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
	return rt.new_null()
}

fn crypto_aead_chacha20poly1305_ietf_encrypt(var_message rt.PhpVal, var_assocData rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_aead_chacha20poly1305_ietf_encrypt(arg_0, arg_1, arg_2, arg_3)
	}(var_message.dup(), var_assocData.dup(), var_nonce.dup(), var_key.dup())
}

fn crypto_auth(var_message rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_auth(arg_0, arg_1)
	}(var_message.dup(), var_key.dup())
}

fn crypto_auth_verify(var_mac rt.PhpVal, var_message rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_auth_verify(arg_0, arg_1, arg_2)
	}(var_mac.dup(), var_message.dup(), var_key.dup())
}

fn crypto_box(var_message rt.PhpVal, var_nonce rt.PhpVal, var_kp rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_box(arg_0, arg_1, arg_2)
	}(var_message.dup(), var_nonce.dup(), var_kp.dup())
}

fn crypto_box_keypair() rt.PhpVal {
	return fn () rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_box_keypair()
	}()
}

fn crypto_box_keypair_from_secretkey_and_publickey(var_sk rt.PhpVal, var_pk rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_box_keypair_from_secretkey_and_publickey(arg_0, arg_1)
	}(var_sk.dup(), var_pk.dup())
}

fn crypto_box_open(var_message rt.PhpVal, var_nonce rt.PhpVal, var_kp rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_box_open(arg_0, arg_1, arg_2)
	}(var_message.dup(), var_nonce.dup(), var_kp.dup())
	unsafe {
		goto end_label_4
	}
	catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'Sodium_TypeError') {
		mut var_ex := var_e_4.dup()
		return rt.new_bool(false)
		unsafe {
			goto end_label_4
		}
	} else if rt.instance_of(var_e_4, 'Sodium_SodiumException') {
		mut var_ex := var_e_4.dup()
		return rt.new_bool(false)
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
	return rt.new_null()
}

fn crypto_box_publickey(var_keypair rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_box_publickey(arg_0)
	}(var_keypair.dup())
}

fn crypto_box_publickey_from_secretkey(var_sk rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_box_publickey_from_secretkey(arg_0)
	}(var_sk.dup())
}

fn crypto_box_seal(var_message rt.PhpVal, var_publicKey rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_box_seal(arg_0, arg_1)
	}(var_message.dup(), var_publicKey.dup())
}

fn crypto_box_seal_open(var_message rt.PhpVal, var_kp rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_box_seal_open(arg_0, arg_1)
	}(var_message.dup(), var_kp.dup())
	unsafe {
		goto end_label_5
	}
	catch_label_5:
	mut var_e_5 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_5, 'Sodium_TypeError') {
		mut var_ex := var_e_5.dup()
		return rt.new_bool(false)
		unsafe {
			goto end_label_5
		}
	} else if rt.instance_of(var_e_5, 'Sodium_SodiumException') {
		mut var_ex := var_e_5.dup()
		return rt.new_bool(false)
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
	return rt.new_null()
}

fn crypto_box_secretkey(var_keypair rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_box_secretkey(arg_0)
	}(var_keypair.dup())
}

fn crypto_generichash(var_message rt.PhpVal, var_key rt.PhpVal, outLen i64) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_generichash(arg_0, arg_1, arg_2)
	}(var_message.dup(), var_key.dup(), rt.new_int(outLen))
}

fn crypto_generichash_final(var_ctx rt.PhpVal, outputLength i64) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_generichash_final(arg_0, arg_1)
	}(var_ctx.dup(), rt.new_int(outputLength))
}

fn crypto_generichash_init(var_key rt.PhpVal, outLen i64) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_generichash_init(arg_0, arg_1)
	}(var_key.dup(), rt.new_int(outLen))
}

fn crypto_generichash_update(var_ctx rt.PhpVal, message string) {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_generichash_update(arg_0, arg_1)
	}(var_ctx.dup(), rt.new_string(message))
}

fn crypto_kx(var_my_secret rt.PhpVal, var_their_public rt.PhpVal, var_client_public rt.PhpVal, var_server_public rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_kx(arg_0, arg_1, arg_2, arg_3, arg_4)
	}(var_my_secret.dup(), var_their_public.dup(), var_client_public.dup(),
		var_server_public.dup(), rt.new_bool(true))
}

fn crypto_pwhash(var_outlen rt.PhpVal, var_passwd rt.PhpVal, var_salt rt.PhpVal, var_opslimit rt.PhpVal, var_memlimit rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_pwhash(arg_0, arg_1, arg_2, arg_3, arg_4)
	}(var_outlen.dup(), var_passwd.dup(), var_salt.dup(), var_opslimit.dup(), var_memlimit.dup())
}

fn crypto_pwhash_str(var_passwd rt.PhpVal, var_opslimit rt.PhpVal, var_memlimit rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_pwhash_str(arg_0, arg_1, arg_2)
	}(var_passwd.dup(), var_opslimit.dup(), var_memlimit.dup())
}

fn crypto_pwhash_str_verify(var_passwd rt.PhpVal, var_hash rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_pwhash_str_verify(arg_0, arg_1)
	}(var_passwd.dup(), var_hash.dup())
}

fn crypto_pwhash_scryptsalsa208sha256(var_outlen rt.PhpVal, var_passwd rt.PhpVal, var_salt rt.PhpVal, var_opslimit rt.PhpVal, var_memlimit rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_pwhash_scryptsalsa208sha256(arg_0, arg_1, arg_2, arg_3, arg_4)
	}(var_outlen.dup(), var_passwd.dup(), var_salt.dup(), var_opslimit.dup(), var_memlimit.dup())
}

fn crypto_pwhash_scryptsalsa208sha256_str(var_passwd rt.PhpVal, var_opslimit rt.PhpVal, var_memlimit rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_pwhash_scryptsalsa208sha256_str(arg_0, arg_1, arg_2)
	}(var_passwd.dup(), var_opslimit.dup(), var_memlimit.dup())
}

fn crypto_pwhash_scryptsalsa208sha256_str_verify(var_passwd rt.PhpVal, var_hash rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_pwhash_scryptsalsa208sha256_str_verify(arg_0, arg_1)
	}(var_passwd.dup(), var_hash.dup())
}

fn crypto_scalarmult(var_n rt.PhpVal, var_p rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_scalarmult(arg_0, arg_1)
	}(var_n.dup(), var_p.dup())
}

fn crypto_scalarmult_base(var_n rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_scalarmult_base(arg_0)
	}(var_n.dup())
}

fn crypto_secretbox(var_message rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_secretbox(arg_0, arg_1, arg_2)
	}(var_message.dup(), var_nonce.dup(), var_key.dup())
}

fn crypto_secretbox_open(var_message rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_secretbox_open(arg_0, arg_1, arg_2)
	}(var_message.dup(), var_nonce.dup(), var_key.dup())
	unsafe {
		goto end_label_6
	}
	catch_label_6:
	mut var_e_6 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_6, 'Sodium_TypeError') {
		mut var_ex := var_e_6.dup()
		return rt.new_bool(false)
		unsafe {
			goto end_label_6
		}
	} else if rt.instance_of(var_e_6, 'Sodium_SodiumException') {
		mut var_ex := var_e_6.dup()
		return rt.new_bool(false)
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
	return rt.new_null()
}

fn crypto_shorthash(var_message rt.PhpVal, key string) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_shorthash(arg_0, arg_1)
	}(var_message.dup(), rt.new_string(key))
}

fn crypto_sign(var_message rt.PhpVal, var_sk rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_sign(arg_0, arg_1)
	}(var_message.dup(), var_sk.dup())
}

fn crypto_sign_detached(var_message rt.PhpVal, var_sk rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.crypto_sign_detached(arg_0, arg_1)
	}(var_message.dup(), var_sk.dup())
}

fn crypto_sign_keypair() rt.PhpVal {
	return
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

pub fn init_wp_includes_sodium_compat_lib_sodium_compat_php() {
	rt.include_file(
		(rt.call_function('dirname', [rt.call_function('dirname', [rt.new_string(@FILE)])])).str() +
		'/autoload.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\bin2hex'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\compare'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_aead_aes256gcm_decrypt'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_aead_aes256gcm_encrypt'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_aead_aes256gcm_is_available'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_aead_chacha20poly1305_decrypt'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_aead_chacha20poly1305_encrypt'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_aead_chacha20poly1305_ietf_decrypt'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_aead_chacha20poly1305_ietf_encrypt'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_auth'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_auth_verify'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_box'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_box_keypair'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_box_keypair_from_secretkey_and_publickey'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_box_open'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_box_publickey'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_box_publickey_from_secretkey'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_box_seal'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_box_seal_open'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_box_secretkey'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_generichash'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_generichash_final'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_generichash_init'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_generichash_update'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_kx'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_pwhash'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_pwhash_str'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_pwhash_str_verify'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_pwhash_scryptsalsa208sha256'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_pwhash_scryptsalsa208sha256_str'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_pwhash_scryptsalsa208sha256_str_verify'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_scalarmult'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_scalarmult_base'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_secretbox'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_secretbox_open'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_shorthash'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_sign'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('\\Sodium\\crypto_sign_detached'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', []))))) {
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
