import rt

pub fn Class_ParagonIE_Sodium_Core32_Ed25519.keypair_bytes() i64 {
	return 96
}

pub fn Class_ParagonIE_Sodium_Core32_Ed25519.seed_bytes() i64 {
	return 32
}

struct Class_ParagonIE_Sodium_Core32_Ed25519 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core32_Ed25519.keypair() string {
	mut var_seed := rt.call_function('random_bytes', [
		rt.new_int(Class_ParagonIE_Sodium_Core32_Ed25519.seed_bytes()),
	])
	mut var_pk := rt.new_string('')
	mut var_sk := rt.new_string('')
	Class_ParagonIE_Sodium_Core32_Ed25519.seed_keypair(var_pk.clone(), var_sk.clone(),
		var_seed.clone())
	return var_sk.str() + var_pk.str()
}

fn Class_ParagonIE_Sodium_Core32_Ed25519.seed_keypair(var_pk rt.PhpVal, var_sk rt.PhpVal, var_seed rt.PhpVal) rt.PhpVal {
	mut var_pk_mutated := var_pk
	mut var_sk_mutated := var_sk
	mut var_seed_mutated := var_seed
	mut iife_temp_0 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_0 := iife_temp_0.strlen(var_seed_mutated.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_0,
		Class_ParagonIE_Sodium_Core32_Ed25519.seed_bytes()))))
	{
		rt.throw_exception(rt.new_object('RangeException', []string{},
			create_rangeexception(rt.new_string('crypto_sign keypair seed must be 32 bytes long'))))
	}
	var_pk_mutated =
		Class_ParagonIE_Sodium_Core32_Ed25519.publickey_from_secretkey(var_seed_mutated.clone())
	var_sk_mutated = rt.new_string(var_seed_mutated.str() + var_pk_mutated.str())
	return var_sk_mutated.clone()
}

fn Class_ParagonIE_Sodium_Core32_Ed25519.secretkey(var_keypair rt.PhpVal) rt.PhpVal {
	mut iife_temp_1 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_1 := iife_temp_1.strlen(var_keypair.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_1,
		Class_ParagonIE_Sodium_Core32_Ed25519.keypair_bytes()))))
	{
		rt.throw_exception(rt.new_object('RangeException', []string{},
			create_rangeexception(rt.new_string('crypto_sign keypair must be 96 bytes long'))))
	}
	mut iife_temp_2 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_2 := iife_temp_2.substr(var_keypair.clone(), rt.new_int(0), rt.new_int(64))
	return iife_result_2
}

fn Class_ParagonIE_Sodium_Core32_Ed25519.publickey(var_keypair rt.PhpVal) rt.PhpVal {
	mut iife_temp_3 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_3 := iife_temp_3.strlen(var_keypair.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_3,
		Class_ParagonIE_Sodium_Core32_Ed25519.keypair_bytes()))))
	{
		rt.throw_exception(rt.new_object('RangeException', []string{},
			create_rangeexception(rt.new_string('crypto_sign keypair must be 96 bytes long'))))
	}
	mut iife_temp_4 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_4 := iife_temp_4.substr(var_keypair.clone(), rt.new_int(64), rt.new_int(32))
	return iife_result_4
}

fn Class_ParagonIE_Sodium_Core32_Ed25519.publickey_from_secretkey(var_sk rt.PhpVal) rt.PhpVal {
	mut var_sk_mutated := var_sk
	mut iife_temp_5 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_5 := iife_temp_5.substr(var_sk_mutated.clone(), rt.new_int(0), rt.new_int(32))
	var_sk_mutated = rt.call_function('hash', [rt.new_string('sha512'), iife_result_5,
		rt.new_bool(true)])
	mut iife_temp_6 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_6 := iife_temp_6.chrtoint(var_sk_mutated.array_get(rt.new_int(0)))
	mut iife_temp_7 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_7 := iife_temp_7.inttochr(rt.new_int(rt.bitwise_and(iife_result_6,
		rt.new_int(248))))
	var_sk_mutated.array_set(0, iife_result_7)
	mut iife_temp_8 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_8 := iife_temp_8.chrtoint(var_sk_mutated.array_get(rt.new_int(31)))
	mut iife_temp_9 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_9 := iife_temp_9.inttochr(rt.new_int(rt.bitwise_and(iife_result_8,
		rt.new_int(63)) | 64))
	var_sk_mutated.array_set(31, iife_result_9)
	return Class_ParagonIE_Sodium_Core32_Ed25519.sk_to_pk(var_sk_mutated.clone())
}

fn Class_ParagonIE_Sodium_Core32_Ed25519.pk_to_curve25519(var_pk rt.PhpVal) rt.PhpVal {
	mut var_pk_mutated := var_pk
	if rt.is_true(Class_ParagonIE_Sodium_Core32_Ed25519.small_order(var_pk_mutated.clone())) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Public key is on a small order'))))
	}
	mut iife_temp_10 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_10 := iife_temp_10.ge_frombytes_negate_vartime(var_pk_mutated.clone())
	mut var_A := iife_result_10
	mut iife_temp_11 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_11 := iife_temp_11.ge_mul_l(var_A.clone())
	mut var_p1 := iife_result_11
	mut iife_temp_12 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_12 := iife_temp_12.fe_isnonzero(rt.get_property(var_p1, 'X'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_12)))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Unexpected zero result'))))
	}
	mut iife_temp_13 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_13 := iife_temp_13.fe_1()
	mut iife_temp_14 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_14 := iife_temp_14.fe_sub(iife_result_13, rt.get_property(var_A, 'Y'))
	mut iife_temp_15 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_15 := iife_temp_15.fe_invert(iife_result_14)
	mut var_one_minux_y := iife_result_15
	mut iife_temp_16 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_16 := iife_temp_16.fe_1()
	mut iife_temp_17 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_17 := iife_temp_17.fe_add(iife_result_16, rt.get_property(var_A, 'Y'))
	mut iife_temp_18 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_18 := iife_temp_18.fe_mul(iife_result_17, var_one_minux_y.clone())
	mut var_x := iife_result_18
	mut iife_temp_19 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_19 := iife_temp_19.fe_tobytes(var_x.clone())
	return iife_result_19
}

fn Class_ParagonIE_Sodium_Core32_Ed25519.sk_to_pk(var_sk rt.PhpVal) rt.PhpVal {
	mut var_sk_mutated := var_sk
	mut iife_temp_20 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_20 := iife_temp_20.substr(var_sk_mutated.clone(), rt.new_int(0), rt.new_int(32))
	mut iife_temp_21 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_21 := iife_temp_21.ge_scalarmult_base(iife_result_20)
	mut iife_temp_22 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_22 := iife_temp_22.ge_p3_tobytes(iife_result_21)
	return iife_result_22
}

fn Class_ParagonIE_Sodium_Core32_Ed25519.sign(var_message rt.PhpVal, var_sk rt.PhpVal) string {
	mut var_message_mutated := var_message
	mut var_sk_mutated := var_sk
	mut var_signature := Class_ParagonIE_Sodium_Core32_Ed25519.sign_detached(var_message_mutated.clone(),
		var_sk_mutated.clone())
	return var_signature.str() + var_message_mutated.str()
}

fn Class_ParagonIE_Sodium_Core32_Ed25519.sign_open(var_message rt.PhpVal, var_pk rt.PhpVal) rt.PhpVal {
	mut var_message_mutated := var_message
	mut var_pk_mutated := var_pk
	mut iife_temp_23 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_23 := iife_temp_23.substr(var_message_mutated.clone(), rt.new_int(0),
		rt.new_int(64))
	mut var_signature := iife_result_23
	mut iife_temp_24 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_24 := iife_temp_24.substr(var_message_mutated.clone(), rt.new_int(64))
	var_message_mutated = iife_result_24
	if rt.is_true(Class_ParagonIE_Sodium_Core32_Ed25519.verify_detached(var_signature.clone(),
		var_message_mutated.clone(), var_pk_mutated.clone()))
	{
		return var_message_mutated.clone()
	}
	rt.throw_exception(rt.new_object('SodiumException', []string{},
		create_sodiumexception(rt.new_string('Invalid signature'))))
	return rt.new_null()
}

fn Class_ParagonIE_Sodium_Core32_Ed25519.sign_detached(var_message rt.PhpVal, var_sk rt.PhpVal) rt.PhpVal {
	mut var_message_mutated := var_message
	mut var_sk_mutated := var_sk
	mut iife_temp_25 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_25 := iife_temp_25.substr(var_sk_mutated.clone(), rt.new_int(0), rt.new_int(32))
	mut var_az := rt.call_function('hash',
		[rt.new_string('sha512'), iife_result_25, rt.new_bool(true)])
	mut iife_temp_26 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_26 := iife_temp_26.chrtoint(var_az.array_get(rt.new_int(0)))
	mut iife_temp_27 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_27 := iife_temp_27.inttochr(rt.new_int(rt.bitwise_and(iife_result_26,
		rt.new_int(248))))
	var_az.array_set(0, iife_result_27)
	mut iife_temp_28 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_28 := iife_temp_28.chrtoint(var_az.array_get(rt.new_int(31)))
	mut iife_temp_29 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_29 := iife_temp_29.inttochr(rt.new_int(rt.bitwise_and(iife_result_28,
		rt.new_int(63)) | 64))
	var_az.array_set(31, iife_result_29)
	mut var_hs := rt.call_function('hash_init', [rt.new_string('sha512')])
	mut iife_temp_30 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_30 := iife_temp_30.substr(var_az.clone(), rt.new_int(32), rt.new_int(32))
	mut iife_temp_31 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_31 := iife_temp_31.hash_update(var_hs.clone(), iife_result_30)
	mut iife_temp_32 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_32 := iife_temp_32.hash_update(var_hs.clone(), var_message_mutated.clone())
	mut var_nonceHash := rt.call_function('hash_final', [var_hs.clone(),
		rt.new_bool(true)])
	mut iife_temp_33 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_33 := iife_temp_33.substr(var_sk_mutated.clone(), rt.new_int(32),
		rt.new_int(32))
	mut var_pk := iife_result_33
	mut iife_temp_34 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_34 := iife_temp_34.sc_reduce(var_nonceHash.clone())
	mut iife_temp_35 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_35 := iife_temp_35.substr(var_nonceHash.clone(), rt.new_int(32))
	mut var_nonce := rt.new_string(iife_result_34.str() + iife_result_35.str())
	mut iife_temp_36 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_36 := iife_temp_36.ge_scalarmult_base(var_nonce.clone())
	mut iife_temp_37 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_37 := iife_temp_37.ge_p3_tobytes(iife_result_36)
	mut var_sig := iife_result_37
	var_hs = rt.call_function('hash_init', [rt.new_string('sha512')])
	mut iife_temp_38 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_38 := iife_temp_38.substr(var_sig.clone(), rt.new_int(0), rt.new_int(32))
	mut iife_temp_39 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_39 := iife_temp_39.hash_update(var_hs.clone(), iife_result_38)
	mut iife_temp_40 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_40 := iife_temp_40.substr(var_pk.clone(), rt.new_int(0), rt.new_int(32))
	mut iife_temp_41 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_41 := iife_temp_41.hash_update(var_hs.clone(), iife_result_40)
	mut iife_temp_42 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_42 := iife_temp_42.hash_update(var_hs.clone(), var_message_mutated.clone())
	mut var_hramHash := rt.call_function('hash_final', [var_hs.clone(),
		rt.new_bool(true)])
	mut iife_temp_43 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_43 := iife_temp_43.sc_reduce(var_hramHash.clone())
	mut var_hram := iife_result_43
	mut iife_temp_44 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_44 := iife_temp_44.sc_muladd(var_hram.clone(), var_az.clone(),
		var_nonce.clone())
	mut var_sigAfter := iife_result_44
	mut iife_temp_45 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_45 := iife_temp_45.substr(var_sig.clone(), rt.new_int(0), rt.new_int(32))
	mut iife_temp_46 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_46 := iife_temp_46.substr(var_sigAfter.clone(), rt.new_int(0), rt.new_int(32))
	var_sig = rt.new_string(iife_result_45.str() + iife_result_46.str())
	mut iife_temp_47 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_47 := iife_temp_47.memzero(var_az.clone())
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

fn Class_ParagonIE_Sodium_Core32_Ed25519.verify_detached(var_sig rt.PhpVal, var_message rt.PhpVal, var_pk rt.PhpVal) rt.PhpVal {
	mut var_sig_mutated := var_sig
	mut var_message_mutated := var_message
	mut var_pk_mutated := var_pk
	mut iife_temp_48 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_48 := iife_temp_48.strlen(var_sig_mutated.clone())
	if rt.is_true(rt.less(iife_result_48, rt.new_int(64))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Signature is too short'))))
	}
	mut iife_temp_49 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_49 := iife_temp_49.chrtoint(var_sig_mutated.array_get(rt.new_int(63)))
	mut iife_temp_50 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_50 := iife_temp_50.substr(var_sig_mutated.clone(), rt.new_int(32),
		rt.new_int(32))
	if rt.is_true(rt.bitwise_and(iife_result_49, rt.new_int(240)))
		&& rt.is_true(Class_ParagonIE_Sodium_Core32_Ed25519.check_s_lt_l(iife_result_50)) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('S < L - Invalid signature'))))
	}
	if rt.is_true(Class_ParagonIE_Sodium_Core32_Ed25519.small_order(var_sig_mutated.clone())) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Signature is on too small of an order'))))
	}
	mut iife_temp_51 := Class_ParagonIE_Sodium_Core32_Ed25519{}
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
	mut iife_temp_52 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_52 := iife_temp_52.ge_frombytes_negate_vartime(var_pk_mutated.clone())
	mut var_A := iife_result_52
	mut iife_temp_53 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_53 := iife_temp_53.substr(var_sig_mutated.clone(), rt.new_int(0),
		rt.new_int(32))
	mut iife_temp_54 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_54 := iife_temp_54.substr(var_pk_mutated.clone(), rt.new_int(0), rt.new_int(32))
	mut var_hDigest := rt.call_function('hash', [rt.new_string('sha512'),
		rt.new_string(iife_result_53.str() + iife_result_54.str() + var_message_mutated.str()),
		rt.new_bool(true)])
	mut iife_temp_55 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_55 := iife_temp_55.sc_reduce(var_hDigest.clone())
	mut iife_temp_56 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_56 := iife_temp_56.substr(var_hDigest.clone(), rt.new_int(32))
	mut var_h := rt.new_string(iife_result_55.str() + iife_result_56.str())
	mut iife_temp_57 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_57 := iife_temp_57.substr(var_sig_mutated.clone(), rt.new_int(32))
	mut iife_temp_58 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_58 := iife_temp_58.ge_double_scalarmult_vartime(var_h.clone(), var_A.clone(),
		iife_result_57)
	mut var_R := iife_result_58
	mut iife_temp_59 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_59 := iife_temp_59.ge_tobytes(var_R.clone())
	mut var_rcheck := iife_result_59
	rt.set_static_prop('ParagonIE_Sodium_Compat', 'fastMult', var_orig.clone())
	mut iife_temp_60 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_60 := iife_temp_60.substr(var_sig_mutated.clone(), rt.new_int(0),
		rt.new_int(32))
	mut iife_temp_61 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_61 := iife_temp_61.verify_32(var_rcheck.clone(), iife_result_60)
	return iife_result_61
}

fn Class_ParagonIE_Sodium_Core32_Ed25519.check_s_lt_l(var_S rt.PhpVal) rt.PhpVal {
	mut var_L := rt.new_null()
	mut iife_temp_62 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_62 := iife_temp_62.strlen(var_S.clone())
	if rt.is_true(rt.less(iife_result_62, rt.new_int(32))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Signature must be 32 bytes'))))
	}
	mut var_c := rt.new_int(0)
	mut var_n := rt.new_int(1)
	mut var_i := rt.new_int(32)
	for {
		rt.pre_dec(var_i)
		mut iife_temp_63 := Class_ParagonIE_Sodium_Core32_Ed25519{}
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

fn Class_ParagonIE_Sodium_Core32_Ed25519.small_order(var_R rt.PhpVal) bool {
	mut var_blocklist := rt.new_null()
	mut var_R_mutated := var_R
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

struct Class_ParagonIE_Sodium_Core32_Curve25519 {
	rt.PhpObjectBase
}

struct Class_RangeException {
	rt.PhpObjectBase
}

struct Class_SodiumException {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Compat {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core32_ed25519(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Ed25519 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Ed25519{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_curve25519(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Curve25519 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Curve25519{
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

fn (mut this Class_ParagonIE_Sodium_Core32_Ed25519) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'keypair' {
			return rt.new_string(Class_ParagonIE_Sodium_Core32_Ed25519.keypair())
		}
		'seed_keypair' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Ed25519.seed_keypair(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'secretkey' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Ed25519.secretkey(dispatch_arg_0)
		}
		'publickey' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Ed25519.publickey(dispatch_arg_0)
		}
		'publickey_from_secretkey' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Ed25519.publickey_from_secretkey(dispatch_arg_0)
		}
		'pk_to_curve25519' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Ed25519.pk_to_curve25519(dispatch_arg_0)
		}
		'sk_to_pk' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Ed25519.sk_to_pk(dispatch_arg_0)
		}
		'sign' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_ParagonIE_Sodium_Core32_Ed25519.sign(dispatch_arg_0,
				dispatch_arg_1))
		}
		'sign_open' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Ed25519.sign_open(dispatch_arg_0, dispatch_arg_1)
		}
		'sign_detached' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Ed25519.sign_detached(dispatch_arg_0,
				dispatch_arg_1)
		}
		'verify_detached' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Ed25519.verify_detached(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'check_S_lt_L' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Ed25519.check_s_lt_l(dispatch_arg_0)
		}
		'small_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_ParagonIE_Sodium_Core32_Ed25519.small_order(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_ParagonIE_Sodium_Core32_Ed25519) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Ed25519) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Curve25519) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
		rt.new_string('ParagonIE_Sodium_Core32_Ed25519'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core32_Curve25519'),
	])))))
	{
		rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
			'/Curve25519.php', '4')
	}
}
