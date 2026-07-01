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
	mut var_seed := rt.call_function('random_bytes', [Class_ParagonIE_Sodium_Core_Ed25519.seed_bytes()])
	mut var_pk := rt.new_string(rt.new_string(''))
	mut var_sk := rt.new_string(rt.new_string(''))
	Class_ParagonIE_Sodium_Core_Ed25519.seed_keypair(var_pk.dup(), var_sk.dup(), var_seed.dup())
	return (var_sk).str() + (var_pk).str()
}

fn Class_ParagonIE_Sodium_Core_Ed25519.seed_keypair(var_pk rt.PhpVal, var_sk rt.PhpVal, var_seed rt.PhpVal) rt.PhpVal {
	mut var_pk_mutated := var_pk
	mut var_sk_mutated := var_sk
	mut var_seed_mutated := var_seed
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('crypto_sign keypair seed must be 32 bytes long'))))
	}
	var_pk_mutated = Class_ParagonIE_Sodium_Core_Ed25519.publickey_from_secretkey(var_seed_mutated.dup())
	var_sk_mutated = rt.new_string(rt.concat(var_seed_mutated, var_pk_mutated))
	return var_sk_mutated.dup()
}

fn Class_ParagonIE_Sodium_Core_Ed25519.secretkey(var_keypair rt.PhpVal) rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('crypto_sign keypair must be 96 bytes long'))))
	}
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_keypair.dup(), rt.new_int(0), rt.new_int(64))
}

fn Class_ParagonIE_Sodium_Core_Ed25519.publickey(var_keypair rt.PhpVal) rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('crypto_sign keypair must be 96 bytes long'))))
	}
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_keypair.dup(), rt.new_int(64), rt.new_int(32))
}

fn Class_ParagonIE_Sodium_Core_Ed25519.publickey_from_secretkey(var_sk rt.PhpVal) rt.PhpVal {
	mut var_sk_mutated := var_sk
	var_sk_mutated = rt.call_function('hash', [rt.new_string('sha512'), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_sk_mutated.dup(), rt.new_int(0), rt.new_int(32)), rt.new_bool(true)])
	var_sk_mutated.array_set(0, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.inttochr(arg_0) }(rt.new_int(rt.bitwise_and(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.chrtoint(arg_0) }(var_sk_mutated.array_get(0)), rt.new_int(248)))))
	var_sk_mutated.array_set(31, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.inttochr(arg_0) }(rt.new_int(rt.bitwise_and(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.chrtoint(arg_0) }(var_sk_mutated.array_get(31)), rt.new_int(63)) | 64)))
	return Class_ParagonIE_Sodium_Core_Ed25519.sk_to_pk(var_sk_mutated.dup())
}

fn Class_ParagonIE_Sodium_Core_Ed25519.is_on_main_subgroup(mut var_A Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3) bool {
	mut var_A_mutated := var_A
	mut var_p1 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.ge_mul_l(arg_0) }(rt.new_object('ParagonIE_Sodium_Core_Curve25519_Ge_P3', []string{}, var_A_mutated))
	mut var_t := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.fe_sub(arg_0, arg_1) }(rt.get_property(var_p1, 'Y'), rt.get_property(var_p1, 'Z'))
	return rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.fe_isnonzero(arg_0) }(rt.get_property(var_p1, 'X'))) && rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.fe_isnonzero(arg_0) }(var_t.dup()))
}

fn Class_ParagonIE_Sodium_Core_Ed25519.pk_to_curve25519(var_pk rt.PhpVal) rt.PhpVal {
	mut var_pk_mutated := var_pk
	if rt.is_true(Class_ParagonIE_Sodium_Core_Ed25519.small_order(var_pk_mutated.dup())) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Public key is on a small order'))))
	}
	mut var_A := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.ge_frombytes_negate_vartime(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_pk_mutated.dup(), rt.new_int(0), rt.new_int(32)))
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_ParagonIE_Sodium_Core_Ed25519.is_on_main_subgroup(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3](var_A)))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Public key is not on a member of the main subgroup'))))
	}
	mut var_one_minux_y := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.fe_invert(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.fe_sub(arg_0, arg_1) }(fn () rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.fe_1() }(), rt.get_property(var_A, 'Y')))
	mut var_x := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.fe_mul(arg_0, arg_1) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.fe_add(arg_0, arg_1) }(fn () rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.fe_1() }(), rt.get_property(var_A, 'Y')), var_one_minux_y.dup())
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.fe_tobytes(arg_0) }(var_x.dup())
}

fn Class_ParagonIE_Sodium_Core_Ed25519.sk_to_pk(var_sk rt.PhpVal) rt.PhpVal {
	mut var_sk_mutated := var_sk
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.ge_p3_tobytes(arg_0) }(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.ge_scalarmult_base(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_sk_mutated.dup(), rt.new_int(0), rt.new_int(32))))
}

fn Class_ParagonIE_Sodium_Core_Ed25519.sign(var_message rt.PhpVal, var_sk rt.PhpVal) string {
	mut var_message_mutated := var_message
	mut var_sk_mutated := var_sk
	mut var_signature := Class_ParagonIE_Sodium_Core_Ed25519.sign_detached(var_message_mutated.dup(), var_sk_mutated.dup())
	return (var_signature).str() + (var_message_mutated).str()
}

fn Class_ParagonIE_Sodium_Core_Ed25519.sign_open(var_message rt.PhpVal, var_pk rt.PhpVal) rt.PhpVal {
	mut var_message_mutated := var_message
	mut var_pk_mutated := var_pk
	mut var_signature := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_message_mutated.dup(), rt.new_int(0), rt.new_int(64))
	var_message_mutated = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.substr(arg_0, arg_1) }(var_message_mutated.dup(), rt.new_int(64))
	if rt.is_true(Class_ParagonIE_Sodium_Core_Ed25519.verify_detached(var_signature.dup(), var_message_mutated.dup(), var_pk_mutated.dup())) {
		return var_message_mutated.dup()
	}
	rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Invalid signature'))))
	return rt.new_null()
}

fn Class_ParagonIE_Sodium_Core_Ed25519.sign_detached(var_message rt.PhpVal, var_sk rt.PhpVal) rt.PhpVal {
	mut var_message_mutated := var_message
	mut var_sk_mutated := var_sk
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Argument 2 must be CRYPTO_SIGN_SECRETKEYBYTES long'))))
	}
	mut var_az := rt.call_function('hash', [rt.new_string('sha512'), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_sk_mutated.dup(), rt.new_int(0), rt.new_int(32)), rt.new_bool(true)])
	var_az.array_set(0, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.inttochr(arg_0) }(rt.new_int(rt.bitwise_and(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.chrtoint(arg_0) }(var_az.array_get(0)), rt.new_int(248)))))
	var_az.array_set(31, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.inttochr(arg_0) }(rt.new_int(rt.bitwise_and(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.chrtoint(arg_0) }(var_az.array_get(31)), rt.new_int(63)) | 64)))
	mut var_hs := rt.call_function('hash_init', [rt.new_string('sha512')])
	rt.call_function('hash_update', [var_hs.dup(), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_az.dup(), rt.new_int(32), rt.new_int(32))])
	rt.call_function('hash_update', [var_hs.dup(), var_message_mutated.dup()])
	mut var_nonceHash := rt.call_function('hash_final', [var_hs.dup(), rt.new_bool(true)])
	mut var_pk := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_sk_mutated.dup(), rt.new_int(32), rt.new_int(32))
	mut var_nonce := rt.new_string(rt.concat(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.sc_reduce(arg_0) }(var_nonceHash.dup()), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.substr(arg_0, arg_1) }(var_nonceHash.dup(), rt.new_int(32))))
	mut var_sig := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.ge_p3_tobytes(arg_0) }(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.ge_scalarmult_base(arg_0) }(var_nonce.dup()))
	var_hs = rt.call_function('hash_init', [rt.new_string('sha512')])
	rt.call_function('hash_update', [var_hs.dup(), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_sig.dup(), rt.new_int(0), rt.new_int(32))])
	rt.call_function('hash_update', [var_hs.dup(), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_pk.dup(), rt.new_int(0), rt.new_int(32))])
	rt.call_function('hash_update', [var_hs.dup(), var_message_mutated.dup()])
	mut var_hramHash := rt.call_function('hash_final', [var_hs.dup(), rt.new_bool(true)])
	mut var_hram := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.sc_reduce(arg_0) }(var_hramHash.dup())
	mut var_sigAfter := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.sc_muladd(arg_0, arg_1, arg_2) }(var_hram.dup(), var_az.dup(), var_nonce.dup())
	var_sig = rt.new_string(rt.concat(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_sig.dup(), rt.new_int(0), rt.new_int(32)), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_sigAfter.dup(), rt.new_int(0), rt.new_int(32))))
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.memzero(arg_0) }(var_az.dup())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'SodiumException') {
		mut var_ex := var_e_1.dup()
		var_az = rt.new_null()
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return var_sig.dup()
}

fn Class_ParagonIE_Sodium_Core_Ed25519.verify_detached(var_sig rt.PhpVal, var_message rt.PhpVal, var_pk rt.PhpVal) rt.PhpVal {
	mut var_sig_mutated := var_sig
	mut var_message_mutated := var_message
	mut var_pk_mutated := var_pk
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Argument 1 must be CRYPTO_SIGN_BYTES long'))))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Argument 3 must be CRYPTO_SIGN_PUBLICKEYBYTES long'))))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.bitwise_and(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.chrtoint(arg_0) }(var_sig_mutated.array_get(63)), rt.new_int(240))) && rt.is_true(Class_ParagonIE_Sodium_Core_Ed25519.check_s_lt_l(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_sig_mutated.dup(), rt.new_int(32), rt.new_int(32)))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('S >= L - Invalid signature'))))
	}
	if rt.is_true(Class_ParagonIE_Sodium_Core_Ed25519.small_order(var_sig_mutated.dup())) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Signature is on too small of an order'))))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Invalid signature'))))
	}
	mut var_d := rt.new_int(rt.new_int(0))
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, rt.new_int(32)))) { break }
			// unsupported expression: Expr_AssignOp_BitwiseOr
			rt.pre_inc(var_i)
		}
	}
	if rt.is_true(rt.identical(var_d, rt.new_int(0))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('All zero public key'))))
	}
	mut var_orig := // unsupported expression: Expr_StaticPropertyFetch
	// unsupported assign target: Expr_StaticPropertyFetch
	mut var_A := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.ge_frombytes_negate_vartime(arg_0) }(var_pk_mutated.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_ParagonIE_Sodium_Core_Ed25519.is_on_main_subgroup(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3](var_A)))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Public key is not on a member of the main subgroup'))))
	}
	mut var_hDigest := rt.call_function('hash', [rt.new_string('sha512'), (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_sig_mutated.dup(), rt.new_int(0), rt.new_int(32))).str() + (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_pk_mutated.dup(), rt.new_int(0), rt.new_int(32))).str() + (var_message_mutated).str(), rt.new_bool(true)])
	mut var_h := rt.new_string(rt.concat(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.sc_reduce(arg_0) }(var_hDigest.dup()), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.substr(arg_0, arg_1) }(var_hDigest.dup(), rt.new_int(32))))
	mut var_R := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.ge_double_scalarmult_vartime(arg_0, arg_1, arg_2) }(var_h.dup(), var_A.dup(), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.substr(arg_0, arg_1) }(var_sig_mutated.dup(), rt.new_int(32)))
	mut var_rcheck := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.ge_tobytes(arg_0) }(var_R.dup())
	// unsupported assign target: Expr_StaticPropertyFetch
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.verify_32(arg_0, arg_1) }(var_rcheck.dup(), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_sig_mutated.dup(), rt.new_int(0), rt.new_int(32)))
}

fn Class_ParagonIE_Sodium_Core_Ed25519.check_s_lt_l(var_S rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.less(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.strlen(arg_0) }(var_S.dup()), rt.new_int(32))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Signature must be 32 bytes'))))
	}
	mut var_L := rt.create_array([rt.ArrayItem{ key: none, val: 237 }, rt.ArrayItem{ key: none, val: 211 }, rt.ArrayItem{ key: none, val: 245 }, rt.ArrayItem{ key: none, val: 92 }, rt.ArrayItem{ key: none, val: 26 }, rt.ArrayItem{ key: none, val: 99 }, rt.ArrayItem{ key: none, val: 18 }, rt.ArrayItem{ key: none, val: 88 }, rt.ArrayItem{ key: none, val: 214 }, rt.ArrayItem{ key: none, val: 156 }, rt.ArrayItem{ key: none, val: 247 }, rt.ArrayItem{ key: none, val: 162 }, rt.ArrayItem{ key: none, val: 222 }, rt.ArrayItem{ key: none, val: 249 }, rt.ArrayItem{ key: none, val: 222 }, rt.ArrayItem{ key: none, val: 20 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 16 }])
	mut var_c := rt.new_int(rt.new_int(0))
	mut var_n := rt.new_int(rt.new_int(1))
	mut var_i := rt.new_int(rt.new_int(32))
	for {
		rt.pre_dec(var_i)
		mut var_x := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ed25519{}; return temp.chrtoint(arg_0) }(var_S.array_get(var_i))
		// unsupported expression: Expr_AssignOp_BitwiseOr
		// unsupported expression: Expr_AssignOp_BitwiseAnd
		if !(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)) {
			break
		}
	}
	return rt.identical(var_c, rt.new_int(0))
}

fn Class_ParagonIE_Sodium_Core_Ed25519.small_order(var_R rt.PhpVal) bool {
	mut var_R_mutated := var_R
	mut var_blocklist := rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 1 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 38 }, rt.ArrayItem{ key: none, val: 232 }, rt.ArrayItem{ key: none, val: 149 }, rt.ArrayItem{ key: none, val: 143 }, rt.ArrayItem{ key: none, val: 194 }, rt.ArrayItem{ key: none, val: 178 }, rt.ArrayItem{ key: none, val: 39 }, rt.ArrayItem{ key: none, val: 176 }, rt.ArrayItem{ key: none, val: 69 }, rt.ArrayItem{ key: none, val: 195 }, rt.ArrayItem{ key: none, val: 244 }, rt.ArrayItem{ key: none, val: 137 }, rt.ArrayItem{ key: none, val: 242 }, rt.ArrayItem{ key: none, val: 239 }, rt.ArrayItem{ key: none, val: 152 }, rt.ArrayItem{ key: none, val: 240 }, rt.ArrayItem{ key: none, val: 213 }, rt.ArrayItem{ key: none, val: 223 }, rt.ArrayItem{ key: none, val: 172 }, rt.ArrayItem{ key: none, val: 5 }, rt.ArrayItem{ key: none, val: 211 }, rt.ArrayItem{ key: none, val: 198 }, rt.ArrayItem{ key: none, val: 51 }, rt.ArrayItem{ key: none, val: 57 }, rt.ArrayItem{ key: none, val: 177 }, rt.ArrayItem{ key: none, val: 56 }, rt.ArrayItem{ key: none, val: 2 }, rt.ArrayItem{ key: none, val: 136 }, rt.ArrayItem{ key: none, val: 109 }, rt.ArrayItem{ key: none, val: 83 }, rt.ArrayItem{ key: none, val: 252 }, rt.ArrayItem{ key: none, val: 5 }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 199 }, rt.ArrayItem{ key: none, val: 23 }, rt.ArrayItem{ key: none, val: 106 }, rt.ArrayItem{ key: none, val: 112 }, rt.ArrayItem{ key: none, val: 61 }, rt.ArrayItem{ key: none, val: 77 }, rt.ArrayItem{ key: none, val: 216 }, rt.ArrayItem{ key: none, val: 79 }, rt.ArrayItem{ key: none, val: 186 }, rt.ArrayItem{ key: none, val: 60 }, rt.ArrayItem{ key: none, val: 11 }, rt.ArrayItem{ key: none, val: 118 }, rt.ArrayItem{ key: none, val: 13 }, rt.ArrayItem{ key: none, val: 16 }, rt.ArrayItem{ key: none, val: 103 }, rt.ArrayItem{ key: none, val: 15 }, rt.ArrayItem{ key: none, val: 42 }, rt.ArrayItem{ key: none, val: 32 }, rt.ArrayItem{ key: none, val: 83 }, rt.ArrayItem{ key: none, val: 250 }, rt.ArrayItem{ key: none, val: 44 }, rt.ArrayItem{ key: none, val: 57 }, rt.ArrayItem{ key: none, val: 204 }, rt.ArrayItem{ key: none, val: 198 }, rt.ArrayItem{ key: none, val: 78 }, rt.ArrayItem{ key: none, val: 199 }, rt.ArrayItem{ key: none, val: 253 }, rt.ArrayItem{ key: none, val: 119 }, rt.ArrayItem{ key: none, val: 146 }, rt.ArrayItem{ key: none, val: 172 }, rt.ArrayItem{ key: none, val: 3 }, rt.ArrayItem{ key: none, val: 122 }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 19 }, rt.ArrayItem{ key: none, val: 232 }, rt.ArrayItem{ key: none, val: 149 }, rt.ArrayItem{ key: none, val: 143 }, rt.ArrayItem{ key: none, val: 194 }, rt.ArrayItem{ key: none, val: 178 }, rt.ArrayItem{ key: none, val: 39 }, rt.ArrayItem{ key: none, val: 176 }, rt.ArrayItem{ key: none, val: 69 }, rt.ArrayItem{ key: none, val: 195 }, rt.ArrayItem{ key: none, val: 244 }, rt.ArrayItem{ key: none, val: 137 }, rt.ArrayItem{ key: none, val: 242 }, rt.ArrayItem{ key: none, val: 239 }, rt.ArrayItem{ key: none, val: 152 }, rt.ArrayItem{ key: none, val: 240 }, rt.ArrayItem{ key: none, val: 213 }, rt.ArrayItem{ key: none, val: 223 }, rt.ArrayItem{ key: none, val: 172 }, rt.ArrayItem{ key: none, val: 5 }, rt.ArrayItem{ key: none, val: 211 }, rt.ArrayItem{ key: none, val: 198 }, rt.ArrayItem{ key: none, val: 51 }, rt.ArrayItem{ key: none, val: 57 }, rt.ArrayItem{ key: none, val: 177 }, rt.ArrayItem{ key: none, val: 56 }, rt.ArrayItem{ key: none, val: 2 }, rt.ArrayItem{ key: none, val: 136 }, rt.ArrayItem{ key: none, val: 109 }, rt.ArrayItem{ key: none, val: 83 }, rt.ArrayItem{ key: none, val: 252 }, rt.ArrayItem{ key: none, val: 133 }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 180 }, rt.ArrayItem{ key: none, val: 23 }, rt.ArrayItem{ key: none, val: 106 }, rt.ArrayItem{ key: none, val: 112 }, rt.ArrayItem{ key: none, val: 61 }, rt.ArrayItem{ key: none, val: 77 }, rt.ArrayItem{ key: none, val: 216 }, rt.ArrayItem{ key: none, val: 79 }, rt.ArrayItem{ key: none, val: 186 }, rt.ArrayItem{ key: none, val: 60 }, rt.ArrayItem{ key: none, val: 11 }, rt.ArrayItem{ key: none, val: 118 }, rt.ArrayItem{ key: none, val: 13 }, rt.ArrayItem{ key: none, val: 16 }, rt.ArrayItem{ key: none, val: 103 }, rt.ArrayItem{ key: none, val: 15 }, rt.ArrayItem{ key: none, val: 42 }, rt.ArrayItem{ key: none, val: 32 }, rt.ArrayItem{ key: none, val: 83 }, rt.ArrayItem{ key: none, val: 250 }, rt.ArrayItem{ key: none, val: 44 }, rt.ArrayItem{ key: none, val: 57 }, rt.ArrayItem{ key: none, val: 204 }, rt.ArrayItem{ key: none, val: 198 }, rt.ArrayItem{ key: none, val: 78 }, rt.ArrayItem{ key: none, val: 199 }, rt.ArrayItem{ key: none, val: 253 }, rt.ArrayItem{ key: none, val: 119 }, rt.ArrayItem{ key: none, val: 146 }, rt.ArrayItem{ key: none, val: 172 }, rt.ArrayItem{ key: none, val: 3 }, rt.ArrayItem{ key: none, val: 250 }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 236 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 127 }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 237 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 127 }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 238 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 127 }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 217 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 218 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 219 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }, rt.ArrayItem{ key: none, val: 255 }]) }])
	mut var_countBlocklist := rt.new_int(rt.new_int(var_blocklist.dup().array_count()))
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, var_countBlocklist))) { break }
			mut var_c := rt.new_int(rt.new_int(0))
			{
				mut var_j := rt.new_int(rt.new_int(0))
				for {
					if !(rt.is_true(rt.less(var_j, rt.new_int(32)))) { break }
					// unsupported expression: Expr_AssignOp_BitwiseOr
					rt.pre_inc(var_j)
				}
			}
			if rt.is_true(rt.identical(var_c, rt.new_int(0))) {
				return true
			}
			rt.pre_inc(var_i)
		}
	}
	return false
}

fn Class_ParagonIE_Sodium_Core_Ed25519.scalar_complement(var_s rt.PhpVal) rt.PhpVal {
	mut var_t_ := rt.new_string(rt.concat(, ))
	rt.call_function('sodium_increment', [.dup()])
	
}

fn Class_ParagonIE_Sodium_Core_Ed25519.scalar_random() rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core_Ed25519.scalar_negate(var_s rt.PhpVal) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core_Ed25519.scalar_add(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core_Ed25519.scalar_sub(var_x rt.PhpVal, var_y rt.PhpVal) rt.PhpVal {
	mut var_x_mutated := var_x
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

fn create_paragonie_sodium_core_ed25519() &Class_ParagonIE_Sodium_Core_Ed25519 {
	mut obj := &Class_ParagonIE_Sodium_Core_Ed25519{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_curve25519() &Class_ParagonIE_Sodium_Core_Curve25519 {
	mut obj := &Class_ParagonIE_Sodium_Core_Curve25519{
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

fn create_paragonie_sodium_compat() &Class_ParagonIE_Sodium_Compat {
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
			return Class_ParagonIE_Sodium_Core_Ed25519.seed_keypair(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3](if args.len > 0 { args[0] } else { rt.new_null() })
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
			return rt.new_string(Class_ParagonIE_Sodium_Core_Ed25519.sign(dispatch_arg_0, dispatch_arg_1))
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
			return Class_ParagonIE_Sodium_Core_Ed25519.verify_detached(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
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
		else { return none }
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




pub fn init_wp_includes_sodium_compat_src_core_ed25519_php() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_Core_Ed25519'), rt.new_bool(false)])) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_Core_Curve25519'), rt.new_bool(false)]))))) {
		rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() + '/Curve25519.php', '4')
	}
}
