import rt

pub fn Class_ParagonIE_Sodium_Core_Ed25519.keypair_bytes() i64 {
	return 96
}

pub fn Class_ParagonIE_Sodium_Core_Ed25519.seed_bytes() i64 {
	return 32
}

pub fn Class_ParagonIE_Sodium_Core_Ed25519.scalar_bytes() i64 {
	return 32
}

struct Class_ParagonIE_Sodium_Core_Ed25519 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core_Ed25519.keypair() string {
	mut var_seed := rt.call_function('random_bytes', [
		rt.new_int(Class_ParagonIE_Sodium_Core_Ed25519.seed_bytes()),
	])
	mut var_pk := rt.new_string('')
	mut var_sk := rt.new_string('')
	Class_ParagonIE_Sodium_Core_Ed25519.seed_keypair(var_pk.clone(), var_sk.clone(),
		var_seed.clone())
	return var_sk.str() + var_pk.str()
}

fn Class_ParagonIE_Sodium_Core_Ed25519.seed_keypair(var_pk rt.PhpVal, var_sk rt.PhpVal, var_seed rt.PhpVal) rt.PhpVal {
	mut var_pk_mutated := var_pk
	mut var_sk_mutated := var_sk
	mut var_seed_mutated := var_seed
	mut iife_temp_0 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_0 := iife_temp_0.strlen(var_seed_mutated.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_0,
		Class_ParagonIE_Sodium_Core_Ed25519.seed_bytes()))))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('crypto_sign keypair seed must be 32 bytes long'))))
	}
	var_pk_mutated =
		Class_ParagonIE_Sodium_Core_Ed25519.publickey_from_secretkey(var_seed_mutated.clone())
	var_sk_mutated = rt.new_string(var_seed_mutated.str() + var_pk_mutated.str())
	return var_sk_mutated.clone()
}

fn Class_ParagonIE_Sodium_Core_Ed25519.secretkey(var_keypair rt.PhpVal) rt.PhpVal {
	mut iife_temp_1 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_1 := iife_temp_1.strlen(var_keypair.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_1,
		Class_ParagonIE_Sodium_Core_Ed25519.keypair_bytes()))))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('crypto_sign keypair must be 96 bytes long'))))
	}
	mut iife_temp_2 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_2 := iife_temp_2.substr(var_keypair.clone(), rt.new_int(0), rt.new_int(64))
	return iife_result_2
}

fn Class_ParagonIE_Sodium_Core_Ed25519.publickey(var_keypair rt.PhpVal) rt.PhpVal {
	mut iife_temp_3 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_3 := iife_temp_3.strlen(var_keypair.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_3,
		Class_ParagonIE_Sodium_Core_Ed25519.keypair_bytes()))))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('crypto_sign keypair must be 96 bytes long'))))
	}
	mut iife_temp_4 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_4 := iife_temp_4.substr(var_keypair.clone(), rt.new_int(64), rt.new_int(32))
	return iife_result_4
}

fn Class_ParagonIE_Sodium_Core_Ed25519.publickey_from_secretkey(var_sk rt.PhpVal) rt.PhpVal {
	mut var_sk_mutated := var_sk
	mut iife_temp_5 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_5 := iife_temp_5.substr(var_sk_mutated.clone(), rt.new_int(0), rt.new_int(32))
	var_sk_mutated = rt.call_function('hash', [rt.new_string('sha512'), iife_result_5,
		rt.new_bool(true)])
	mut iife_temp_6 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_6 := iife_temp_6.chrtoint(var_sk_mutated.array_get(rt.new_int(0)))
	mut iife_temp_7 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_7 := iife_temp_7.inttochr(rt.new_int(rt.bitwise_and(iife_result_6,
		rt.new_int(248))))
	var_sk_mutated.array_set(0, iife_result_7)
	mut iife_temp_8 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_8 := iife_temp_8.chrtoint(var_sk_mutated.array_get(rt.new_int(31)))
	mut iife_temp_9 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_9 := iife_temp_9.inttochr(rt.new_int(rt.bitwise_and(iife_result_8,
		rt.new_int(63)) | 64))
	var_sk_mutated.array_set(31, iife_result_9)
	return Class_ParagonIE_Sodium_Core_Ed25519.sk_to_pk(var_sk_mutated.clone())
}

fn Class_ParagonIE_Sodium_Core_Ed25519.is_on_main_subgroup(mut var_A Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3) bool {
	mut var_A_mutated := var_A
	mut iife_temp_10 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_10 := iife_temp_10.ge_mul_l(rt.new_object('ParagonIE_Sodium_Core_Curve25519_Ge_P3',
		[]string{}, var_A_mutated))
	mut var_p1 := iife_result_10
	mut iife_temp_11 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_11 := iife_temp_11.fe_sub(rt.get_property(var_p1, 'Y'),
		rt.get_property(var_p1, 'Z'))
	mut var_t := iife_result_11
	mut iife_temp_12 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_12 := iife_temp_12.fe_isnonzero(rt.get_property(var_p1, 'X'))
	mut iife_temp_13 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_13 := iife_temp_13.fe_isnonzero(var_t.clone())
	return rt.is_true(iife_result_12) && rt.is_true(iife_result_13)
}

fn Class_ParagonIE_Sodium_Core_Ed25519.pk_to_curve25519(var_pk rt.PhpVal) rt.PhpVal {
	mut var_pk_mutated := var_pk
	if rt.is_true(Class_ParagonIE_Sodium_Core_Ed25519.small_order(var_pk_mutated.clone())) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Public key is on a small order'))))
	}
	mut iife_temp_14 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_14 := iife_temp_14.substr(var_pk_mutated.clone(), rt.new_int(0), rt.new_int(32))
	mut iife_temp_15 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_15 := iife_temp_15.ge_frombytes_negate_vartime(iife_result_14)
	mut var_A := iife_result_15
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_ParagonIE_Sodium_Core_Ed25519.is_on_main_subgroup(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3](var_A)))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Public key is not on a member of the main subgroup'))))
	}
	mut iife_temp_16 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_16 := iife_temp_16.fe_1()
	mut iife_temp_17 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_17 := iife_temp_17.fe_sub(iife_result_16, rt.get_property(var_A, 'Y'))
	mut iife_temp_18 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_18 := iife_temp_18.fe_invert(iife_result_17)
	mut var_one_minux_y := iife_result_18
	mut iife_temp_19 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_19 := iife_temp_19.fe_1()
	mut iife_temp_20 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_20 := iife_temp_20.fe_add(iife_result_19, rt.get_property(var_A, 'Y'))
	mut iife_temp_21 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_21 := iife_temp_21.fe_mul(iife_result_20, var_one_minux_y.clone())
	mut var_x := iife_result_21
	mut iife_temp_22 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_22 := iife_temp_22.fe_tobytes(var_x.clone())
	return iife_result_22
}

fn Class_ParagonIE_Sodium_Core_Ed25519.sk_to_pk(var_sk rt.PhpVal) rt.PhpVal {
	mut var_sk_mutated := var_sk
	mut iife_temp_23 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_23 := iife_temp_23.substr(var_sk_mutated.clone(), rt.new_int(0), rt.new_int(32))
	mut iife_temp_24 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_24 := iife_temp_24.ge_scalarmult_base(iife_result_23)
	mut iife_temp_25 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_25 := iife_temp_25.ge_p3_tobytes(iife_result_24)
	return iife_result_25
}

fn Class_ParagonIE_Sodium_Core_Ed25519.sign(var_message rt.PhpVal, var_sk rt.PhpVal) string {
	mut var_message_mutated := var_message
	mut var_sk_mutated := var_sk
	mut var_signature := Class_ParagonIE_Sodium_Core_Ed25519.sign_detached(var_message_mutated.clone(),
		var_sk_mutated.clone())
	return var_signature.str() + var_message_mutated.str()
}

fn Class_ParagonIE_Sodium_Core_Ed25519.sign_open(var_message rt.PhpVal, var_pk rt.PhpVal) rt.PhpVal {
	mut var_message_mutated := var_message
	mut var_pk_mutated := var_pk
	mut iife_temp_26 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_26 := iife_temp_26.substr(var_message_mutated.clone(), rt.new_int(0),
		rt.new_int(64))
	mut var_signature := iife_result_26
	mut iife_temp_27 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_27 := iife_temp_27.substr(var_message_mutated.clone(), rt.new_int(64))
	var_message_mutated = iife_result_27
	if rt.is_true(Class_ParagonIE_Sodium_Core_Ed25519.verify_detached(var_signature.clone(),
		var_message_mutated.clone(), var_pk_mutated.clone()))
	{
		return var_message_mutated.clone()
	}
	rt.throw_exception(rt.new_object('SodiumException', []string{},
		create_sodiumexception(rt.new_string('Invalid signature'))))
	return rt.new_null()
}

fn Class_ParagonIE_Sodium_Core_Ed25519.sign_detached(var_message rt.PhpVal, var_sk rt.PhpVal) rt.PhpVal {
	mut var_message_mutated := var_message
	mut var_sk_mutated := var_sk
	mut iife_temp_28 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_28 := iife_temp_28.strlen(var_sk_mutated.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_28, rt.new_int(64))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Argument 2 must be CRYPTO_SIGN_SECRETKEYBYTES long'))))
	}
	mut iife_temp_29 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_29 := iife_temp_29.substr(var_sk_mutated.clone(), rt.new_int(0), rt.new_int(32))
	mut var_az := rt.call_function('hash',
		[rt.new_string('sha512'), iife_result_29, rt.new_bool(true)])
	mut iife_temp_30 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_30 := iife_temp_30.chrtoint(var_az.array_get(rt.new_int(0)))
	mut iife_temp_31 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_31 := iife_temp_31.inttochr(rt.new_int(rt.bitwise_and(iife_result_30,
		rt.new_int(248))))
	var_az.array_set(0, iife_result_31)
	mut iife_temp_32 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_32 := iife_temp_32.chrtoint(var_az.array_get(rt.new_int(31)))
	mut iife_temp_33 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_33 := iife_temp_33.inttochr(rt.new_int(rt.bitwise_and(iife_result_32,
		rt.new_int(63)) | 64))
	var_az.array_set(31, iife_result_33)
	mut var_hs := rt.call_function('hash_init', [rt.new_string('sha512')])
	mut iife_temp_34 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_34 := iife_temp_34.substr(var_az.clone(), rt.new_int(32), rt.new_int(32))
	rt.call_function('hash_update', [var_hs.clone(), iife_result_34])
	rt.call_function('hash_update', [var_hs.clone(), var_message_mutated.clone()])
	mut var_nonceHash := rt.call_function('hash_final', [var_hs.clone(),
		rt.new_bool(true)])
	mut iife_temp_35 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_35 := iife_temp_35.substr(var_sk_mutated.clone(), rt.new_int(32),
		rt.new_int(32))
	mut var_pk := iife_result_35
	mut iife_temp_36 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_36 := iife_temp_36.sc_reduce(var_nonceHash.clone())
	mut iife_temp_37 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_37 := iife_temp_37.substr(var_nonceHash.clone(), rt.new_int(32))
	mut var_nonce := rt.new_string(iife_result_36.str() + iife_result_37.str())
	mut iife_temp_38 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_38 := iife_temp_38.ge_scalarmult_base(var_nonce.clone())
	mut iife_temp_39 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_39 := iife_temp_39.ge_p3_tobytes(iife_result_38)
	mut var_sig := iife_result_39
	var_hs = rt.call_function('hash_init', [rt.new_string('sha512')])
	mut iife_temp_40 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_40 := iife_temp_40.substr(var_sig.clone(), rt.new_int(0), rt.new_int(32))
	rt.call_function('hash_update', [var_hs.clone(), iife_result_40])
	mut iife_temp_41 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_41 := iife_temp_41.substr(var_pk.clone(), rt.new_int(0), rt.new_int(32))
	rt.call_function('hash_update', [var_hs.clone(), iife_result_41])
	rt.call_function('hash_update', [var_hs.clone(), var_message_mutated.clone()])
	mut var_hramHash := rt.call_function('hash_final', [var_hs.clone(),
		rt.new_bool(true)])
	mut iife_temp_42 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_42 := iife_temp_42.sc_reduce(var_hramHash.clone())
	mut var_hram := iife_result_42
	mut iife_temp_43 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_43 := iife_temp_43.sc_muladd(var_hram.clone(), var_az.clone(),
		var_nonce.clone())
	mut var_sigAfter := iife_result_43
	mut iife_temp_44 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_44 := iife_temp_44.substr(var_sig.clone(), rt.new_int(0), rt.new_int(32))
	mut iife_temp_45 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_45 := iife_temp_45.substr(var_sigAfter.clone(), rt.new_int(0), rt.new_int(32))
	var_sig = rt.new_string(iife_result_44.str() + iife_result_45.str())
	mut iife_temp_46 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_46 := iife_temp_46.memzero(var_az.clone())
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
		var_az = rt.new_null()
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
	return var_sig.clone()
}

fn Class_ParagonIE_Sodium_Core_Ed25519.verify_detached(var_sig rt.PhpVal, var_message rt.PhpVal, var_pk rt.PhpVal) rt.PhpVal {
	mut var_sig_mutated := var_sig
	mut var_message_mutated := var_message
	mut var_pk_mutated := var_pk
	mut iife_temp_47 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_47 := iife_temp_47.strlen(var_sig_mutated.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_47, rt.new_int(64))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Argument 1 must be CRYPTO_SIGN_BYTES long'))))
	}
	mut iife_temp_48 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_48 := iife_temp_48.strlen(var_pk_mutated.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_48, rt.new_int(32))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Argument 3 must be CRYPTO_SIGN_PUBLICKEYBYTES long'))))
	}
	mut iife_temp_49 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_49 := iife_temp_49.chrtoint(var_sig_mutated.array_get(rt.new_int(63)))
	mut iife_temp_50 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_50 := iife_temp_50.substr(var_sig_mutated.clone(), rt.new_int(32),
		rt.new_int(32))
	if rt.is_true(rt.bitwise_and(iife_result_49, rt.new_int(240)))
		&& rt.is_true(Class_ParagonIE_Sodium_Core_Ed25519.check_s_lt_l(iife_result_50)) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('S >= L - Invalid signature'))))
	}
	if rt.is_true(Class_ParagonIE_Sodium_Core_Ed25519.small_order(var_sig_mutated.clone())) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Signature is on too small of an order'))))
	}
	mut iife_temp_51 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_51 := iife_temp_51.chrtoint(var_sig_mutated.array_get(rt.new_int(63)))
	if rt.is_true(rt.new_bool(rt.bitwise_and(iife_result_51, rt.new_int(224)) != 0)) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Invalid signature'))))
	}
	mut var_d := rt.new_int(0)
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(32)))) { break
		 }
		rt.new_null()
		rt.pre_inc(var_i)
	}
	if rt.is_true(rt.identical(var_d, rt.new_int(0))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('All zero public key'))))
	}
	mut var_orig := rt.get_static_prop('ParagonIE_Sodium_Compat', 'fastMult')
	rt.set_static_prop('ParagonIE_Sodium_Compat', 'fastMult', rt.new_bool(true))
	mut iife_temp_52 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_52 := iife_temp_52.ge_frombytes_negate_vartime(var_pk_mutated.clone())
	mut var_A := iife_result_52
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_ParagonIE_Sodium_Core_Ed25519.is_on_main_subgroup(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3](var_A)))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Public key is not on a member of the main subgroup'))))
	}
	mut iife_temp_53 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_53 := iife_temp_53.substr(var_sig_mutated.clone(), rt.new_int(0),
		rt.new_int(32))
	mut iife_temp_54 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_54 := iife_temp_54.substr(var_pk_mutated.clone(), rt.new_int(0), rt.new_int(32))
	mut var_hDigest := rt.call_function('hash', [rt.new_string('sha512'),
		rt.new_string(iife_result_53.str() + iife_result_54.str() + var_message_mutated.str()),
		rt.new_bool(true)])
	mut iife_temp_55 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_55 := iife_temp_55.sc_reduce(var_hDigest.clone())
	mut iife_temp_56 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_56 := iife_temp_56.substr(var_hDigest.clone(), rt.new_int(32))
	mut var_h := rt.new_string(iife_result_55.str() + iife_result_56.str())
	mut iife_temp_57 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_57 := iife_temp_57.substr(var_sig_mutated.clone(), rt.new_int(32))
	mut iife_temp_58 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_58 := iife_temp_58.ge_double_scalarmult_vartime(var_h.clone(), var_A.clone(),
		iife_result_57)
	mut var_R := iife_result_58
	mut iife_temp_59 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_59 := iife_temp_59.ge_tobytes(var_R.clone())
	mut var_rcheck := iife_result_59
	rt.set_static_prop('ParagonIE_Sodium_Compat', 'fastMult', var_orig.clone())
	mut iife_temp_60 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_60 := iife_temp_60.substr(var_sig_mutated.clone(), rt.new_int(0),
		rt.new_int(32))
	mut iife_temp_61 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_61 := iife_temp_61.verify_32(var_rcheck.clone(), iife_result_60)
	return iife_result_61
}

fn Class_ParagonIE_Sodium_Core_Ed25519.check_s_lt_l(var_S rt.PhpVal) rt.PhpVal {
	mut iife_temp_62 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_62 := iife_temp_62.strlen(var_S.clone())
	if rt.is_true(rt.less(iife_result_62, rt.new_int(32))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Signature must be 32 bytes'))))
	}
	mut var_L := rt.create_array([rt.ArrayItem{ key: none, val: 237 },
		rt.ArrayItem{ key: none, val: 211 }, rt.ArrayItem{ key: none, val: 245 },
		rt.ArrayItem{ key: none, val: 92 }, rt.ArrayItem{ key: none, val: 26 },
		rt.ArrayItem{ key: none, val: 99 }, rt.ArrayItem{ key: none, val: 18 },
		rt.ArrayItem{ key: none, val: 88 }, rt.ArrayItem{ key: none, val: 214 },
		rt.ArrayItem{ key: none, val: 156 }, rt.ArrayItem{ key: none, val: 247 },
		rt.ArrayItem{ key: none, val: 162 }, rt.ArrayItem{ key: none, val: 222 },
		rt.ArrayItem{ key: none, val: 249 }, rt.ArrayItem{ key: none, val: 222 },
		rt.ArrayItem{ key: none, val: 20 }, rt.ArrayItem{ key: none, val: 0 },
		rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
		rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
		rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
		rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
		rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
		rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
		rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
		rt.ArrayItem{ key: none, val: 16 }])
	mut var_c := rt.new_int(0)
	mut var_n := rt.new_int(1)
	mut var_i := rt.new_int(32)
	for {
		rt.pre_dec(var_i)
		mut iife_temp_63 := Class_ParagonIE_Sodium_Core_Ed25519{}
		mut iife_result_63 := iife_temp_63.chrtoint(var_S.array_get(var_i))
		mut var_x := iife_result_63
		rt.new_null()
		rt.new_null()
		if !(rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_i, rt.new_int(0)))))) {
			break
		}
	}
	return rt.identical(var_c, rt.new_int(0))
}

fn Class_ParagonIE_Sodium_Core_Ed25519.small_order(var_R rt.PhpVal) bool {
	mut var_R_mutated := var_R
	mut var_blocklist := rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }]) },
		rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 1 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 }]) },
		rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 38 },
			rt.ArrayItem{ key: none, val: 232 }, rt.ArrayItem{ key: none, val: 149 },
			rt.ArrayItem{ key: none, val: 143 }, rt.ArrayItem{ key: none, val: 194 },
			rt.ArrayItem{ key: none, val: 178 }, rt.ArrayItem{ key: none, val: 39 },
			rt.ArrayItem{ key: none, val: 176 }, rt.ArrayItem{ key: none, val: 69 },
			rt.ArrayItem{ key: none, val: 195 }, rt.ArrayItem{ key: none, val: 244 },
			rt.ArrayItem{ key: none, val: 137 }, rt.ArrayItem{ key: none, val: 242 },
			rt.ArrayItem{ key: none, val: 239 }, rt.ArrayItem{ key: none, val: 152 },
			rt.ArrayItem{ key: none, val: 240 }, rt.ArrayItem{ key: none, val: 213 },
			rt.ArrayItem{ key: none, val: 223 }, rt.ArrayItem{ key: none, val: 172 },
			rt.ArrayItem{ key: none, val: 5 }, rt.ArrayItem{ key: none, val: 211 },
			rt.ArrayItem{ key: none, val: 198 }, rt.ArrayItem{ key: none, val: 51 },
			rt.ArrayItem{ key: none, val: 57 }, rt.ArrayItem{ key: none, val: 177 },
			rt.ArrayItem{ key: none, val: 56 }, rt.ArrayItem{ key: none, val: 2 },
			rt.ArrayItem{ key: none, val: 136 }, rt.ArrayItem{ key: none, val: 109 },
			rt.ArrayItem{ key: none, val: 83 }, rt.ArrayItem{ key: none, val: 252 },
			rt.ArrayItem{ key: none, val: 5 }]) },
		rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 199 },
			rt.ArrayItem{ key: none, val: 23 }, rt.ArrayItem{ key: none, val: 106 },
			rt.ArrayItem{ key: none, val: 112 }, rt.ArrayItem{ key: none, val: 61 },
			rt.ArrayItem{ key: none, val: 77 }, rt.ArrayItem{ key: none, val: 216 },
			rt.ArrayItem{ key: none, val: 79 }, rt.ArrayItem{ key: none, val: 186 },
			rt.ArrayItem{ key: none, val: 60 }, rt.ArrayItem{ key: none, val: 11 },
			rt.ArrayItem{ key: none, val: 118 }, rt.ArrayItem{ key: none, val: 13 },
			rt.ArrayItem{ key: none, val: 16 }, rt.ArrayItem{ key: none, val: 103 },
			rt.ArrayItem{ key: none, val: 15 }, rt.ArrayItem{ key: none, val: 42 },
			rt.ArrayItem{ key: none, val: 32 }, rt.ArrayItem{ key: none, val: 83 },
			rt.ArrayItem{ key: none, val: 250 }, rt.ArrayItem{ key: none, val: 44 },
			rt.ArrayItem{ key: none, val: 57 }, rt.ArrayItem{ key: none, val: 204 },
			rt.ArrayItem{ key: none, val: 198 }, rt.ArrayItem{ key: none, val: 78 },
			rt.ArrayItem{ key: none, val: 199 }, rt.ArrayItem{ key: none, val: 253 },
			rt.ArrayItem{ key: none, val: 119 }, rt.ArrayItem{ key: none, val: 146 },
			rt.ArrayItem{ key: none, val: 172 }, rt.ArrayItem{ key: none, val: 3 },
			rt.ArrayItem{ key: none, val: 122 }]) },
		rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 19 },
			rt.ArrayItem{ key: none, val: 232 }, rt.ArrayItem{ key: none, val: 149 },
			rt.ArrayItem{ key: none, val: 143 }, rt.ArrayItem{ key: none, val: 194 },
			rt.ArrayItem{ key: none, val: 178 }, rt.ArrayItem{ key: none, val: 39 },
			rt.ArrayItem{ key: none, val: 176 }, rt.ArrayItem{ key: none, val: 69 },
			rt.ArrayItem{ key: none, val: 195 }, rt.ArrayItem{ key: none, val: 244 },
			rt.ArrayItem{ key: none, val: 137 }, rt.ArrayItem{ key: none, val: 242 },
			rt.ArrayItem{ key: none, val: 239 }, rt.ArrayItem{ key: none, val: 152 },
			rt.ArrayItem{ key: none, val: 240 }, rt.ArrayItem{ key: none, val: 213 },
			rt.ArrayItem{ key: none, val: 223 }, rt.ArrayItem{ key: none, val: 172 },
			rt.ArrayItem{ key: none, val: 5 }, rt.ArrayItem{ key: none, val: 211 },
			rt.ArrayItem{ key: none, val: 198 }, rt.ArrayItem{ key: none, val: 51 },
			rt.ArrayItem{ key: none, val: 57 }, rt.ArrayItem{ key: none, val: 177 },
			rt.ArrayItem{ key: none, val: 56 }, rt.ArrayItem{ key: none, val: 2 },
			rt.ArrayItem{ key: none, val: 136 }, rt.ArrayItem{ key: none, val: 109 },
			rt.ArrayItem{ key: none, val: 83 }, rt.ArrayItem{ key: none, val: 252 },
			rt.ArrayItem{ key: none, val: 133 }]) },
		rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 180 },
			rt.ArrayItem{ key: none, val: 23 }, rt.ArrayItem{ key: none, val: 106 },
			rt.ArrayItem{ key: none, val: 112 }, rt.ArrayItem{ key: none, val: 61 },
			rt.ArrayItem{ key: none, val: 77 }, rt.ArrayItem{ key: none, val: 216 },
			rt.ArrayItem{ key: none, val: 79 }, rt.ArrayItem{ key: none, val: 186 },
			rt.ArrayItem{ key: none, val: 60 }, rt.ArrayItem{ key: none, val: 11 },
			rt.ArrayItem{ key: none, val: 118 }, rt.ArrayItem{ key: none, val: 13 },
			rt.ArrayItem{ key: none, val: 16 }, rt.ArrayItem{ key: none, val: 103 },
			rt.ArrayItem{ key: none, val: 15 }, rt.ArrayItem{ key: none, val: 42 },
			rt.ArrayItem{ key: none, val: 32 }, rt.ArrayItem{ key: none, val: 83 },
			rt.ArrayItem{ key: none, val: 250 }, rt.ArrayItem{ key: none, val: 44 },
			rt.ArrayItem{ key: none, val: 57 }, rt.ArrayItem{ key: none, val: 204 },
			rt.ArrayItem{ key: none, val: 198 }, rt.ArrayItem{ key: none, val: 78 },
			rt.ArrayItem{ key: none, val: 199 }, rt.ArrayItem{ key: none, val: 253 },
			rt.ArrayItem{ key: none, val: 119 }, rt.ArrayItem{ key: none, val: 146 },
			rt.ArrayItem{ key: none, val: 172 }, rt.ArrayItem{ key: none, val: 3 },
			rt.ArrayItem{ key: none, val: 250 }]) },
		rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 236 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 127 }]) },
		rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 237 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 127 }]) },
		rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 238 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 127 }]) },
		rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 217 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }]) },
		rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 218 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }]) },
		rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 219 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 },
			rt.ArrayItem{ key: none, val: 255 }]) },
	])
	mut var_countBlocklist := rt.new_int(var_blocklist.clone().array_count())
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, var_countBlocklist))) { break
		 }
		mut var_c := rt.new_int(0)
		mut var_j := rt.new_int(0)
		for {
			if !(rt.is_true(rt.less(var_j, rt.new_int(32)))) { break
			 }
			rt.new_null()
			rt.pre_inc(var_j)
		}
		if rt.is_true(rt.identical(var_c, rt.new_int(0))) {
			return true
		}
		rt.pre_inc(var_i)
	}
	return false
}

fn Class_ParagonIE_Sodium_Core_Ed25519.scalar_complement(var_s rt.PhpVal) rt.PhpVal {
	mut var_t_ := rt.new_string((Class_ParagonIE_Sodium_Core_Ed25519.l()).str() +
		(rt.call_function('str_repeat', [rt.new_string(''), rt.new_int(32)])).str())
	rt.call_function('sodium_increment', [var_t_.clone()])
	mut var_s_ := rt.new_string(var_s.str() +
		(rt.call_function('str_repeat', [rt.new_string(''), rt.new_int(32)])).str())
	mut iife_temp_64 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_64 := iife_temp_64.sub(var_t_.clone(), var_s_.clone())
	mut iife_temp_65 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_65 := iife_temp_65.sc_reduce(var_t_.clone())
	return iife_result_65
}

fn Class_ParagonIE_Sodium_Core_Ed25519.scalar_random() rt.PhpVal {
	mut iife_temp_66 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_66 := iife_temp_66.is_zero(var_r.clone())
	for {
		mut iife_temp_67 := Class_ParagonIE_Sodium_Compat{}
		mut iife_result_67 :=
			iife_temp_67.randombytes_buf(rt.new_int(Class_ParagonIE_Sodium_Core_Ed25519.scalar_bytes()))
		mut var_r := iife_result_67
		mut iife_temp_68 := Class_ParagonIE_Sodium_Core_Ed25519{}
		mut iife_result_68 :=
			iife_temp_68.chrtoint(var_r.array_get(rt.new_int(Class_ParagonIE_Sodium_Core_Ed25519.scalar_bytes() - 1)))
		mut iife_temp_69 := Class_ParagonIE_Sodium_Core_Ed25519{}
		mut iife_result_69 := iife_temp_69.inttochr(rt.new_int(rt.bitwise_and(iife_result_68,
			rt.new_int(31))))
		var_r.array_set(Class_ParagonIE_Sodium_Core_Ed25519.scalar_bytes() - 1, iife_result_69)
		if !(
			rt.is_true(rt.new_bool(!(rt.is_true(Class_ParagonIE_Sodium_Core_Ed25519.check_s_lt_l(var_r.clone())))))
			|| rt.is_true(iife_result_66)) {
			break
		}
	}
	return var_r.clone()
}

fn Class_ParagonIE_Sodium_Core_Ed25519.scalar_negate(var_s rt.PhpVal) rt.PhpVal {
	mut var_t_ := rt.new_string((Class_ParagonIE_Sodium_Core_Ed25519.l()).str() +
		(rt.call_function('str_repeat', [rt.new_string(''), rt.new_int(32)])).str())
	mut var_s_ := rt.new_string(var_s.str() +
		(rt.call_function('str_repeat', [rt.new_string(''), rt.new_int(32)])).str())
	mut iife_temp_70 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_70 := iife_temp_70.sub(var_t_.clone(), var_s_.clone())
	mut iife_temp_71 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_71 := iife_temp_71.sc_reduce(var_t_.clone())
	return iife_result_71
}

fn Class_ParagonIE_Sodium_Core_Ed25519.scalar_add(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	mut var_a_ := rt.new_string(var_a.str() +
		(rt.call_function('str_repeat', [rt.new_string(''), rt.new_int(32)])).str())
	mut var_b_ := rt.new_string(var_b.str() +
		(rt.call_function('str_repeat', [rt.new_string(''), rt.new_int(32)])).str())
	mut iife_temp_72 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_72 := iife_temp_72.add(var_a_.clone(), var_b_.clone())
	mut iife_temp_73 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_73 := iife_temp_73.sc_reduce(var_a_.clone())
	return iife_result_73
}

fn Class_ParagonIE_Sodium_Core_Ed25519.scalar_sub(var_x rt.PhpVal, var_y rt.PhpVal) rt.PhpVal {
	mut var_x_mutated := var_x
	mut var_yn := Class_ParagonIE_Sodium_Core_Ed25519.scalar_negate(var_y.clone())
	return Class_ParagonIE_Sodium_Core_Ed25519.scalar_add(var_x_mutated.clone(), var_yn.clone())
}

struct Class_ParagonIE_Sodium_Core_Curve25519 {
	rt.PhpObjectBase
}

struct Class_SodiumException {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Compat {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_ed25519(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_Ed25519 {
	mut obj := &Class_ParagonIE_Sodium_Core_Ed25519{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_curve25519(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_Curve25519 {
	mut obj := &Class_ParagonIE_Sodium_Core_Curve25519{
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

fn create_paragonie_sodium_compat(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Compat {
	mut obj := &Class_ParagonIE_Sodium_Compat{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_Ed25519) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'keypair' {
			return rt.new_string(Class_ParagonIE_Sodium_Core_Ed25519.keypair())
		}
		'seed_keypair' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ed25519.seed_keypair(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'secretkey' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ed25519.secretkey(dispatch_arg_0)
		}
		'publickey' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ed25519.publickey(dispatch_arg_0)
		}
		'publickey_from_secretkey' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ed25519.publickey_from_secretkey(dispatch_arg_0)
		}
		'is_on_main_subgroup' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(Class_ParagonIE_Sodium_Core_Ed25519.is_on_main_subgroup(mut dispatch_arg_0))
		}
		'pk_to_curve25519' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ed25519.pk_to_curve25519(dispatch_arg_0)
		}
		'sk_to_pk' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ed25519.sk_to_pk(dispatch_arg_0)
		}
		'sign' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_ParagonIE_Sodium_Core_Ed25519.sign(dispatch_arg_0,
				dispatch_arg_1))
		}
		'sign_open' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ed25519.sign_open(dispatch_arg_0, dispatch_arg_1)
		}
		'sign_detached' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ed25519.sign_detached(dispatch_arg_0, dispatch_arg_1)
		}
		'verify_detached' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ed25519.verify_detached(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'check_S_lt_L' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ed25519.check_s_lt_l(dispatch_arg_0)
		}
		'small_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_ParagonIE_Sodium_Core_Ed25519.small_order(dispatch_arg_0))
		}
		'scalar_complement' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ed25519.scalar_complement(dispatch_arg_0)
		}
		'scalar_random' {
			return Class_ParagonIE_Sodium_Core_Ed25519.scalar_random()
		}
		'scalar_negate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ed25519.scalar_negate(dispatch_arg_0)
		}
		'scalar_add' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ed25519.scalar_add(dispatch_arg_0, dispatch_arg_1)
		}
		'scalar_sub' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ed25519.scalar_sub(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_ParagonIE_Sodium_Core_Ed25519) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Ed25519) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_Curve25519) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core_Ed25519'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core_Curve25519'),
		rt.new_bool(false),
	])))))
	{
		rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
			'/Curve25519.php', '4')
	}
}
