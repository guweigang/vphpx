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
	mut var_seed := rt.call_function('random_bytes', [Class_ParagonIE_Sodium_Core32_Ed25519.seed_bytes()])
	mut var_pk := rt.new_string(rt.new_string(''))
	mut var_sk := rt.new_string(rt.new_string(''))
	Class_ParagonIE_Sodium_Core32_Ed25519.seed_keypair(var_pk.dup(), var_sk.dup(), var_seed.dup())
	return (var_sk).str() + (var_pk).str()
}

fn Class_ParagonIE_Sodium_Core32_Ed25519.seed_keypair(var_pk rt.PhpVal, var_sk rt.PhpVal, var_seed rt.PhpVal) rt.PhpVal {
	mut var_pk_mutated := var_pk
	mut var_sk_mutated := var_sk
	mut var_seed_mutated := var_seed
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('RangeException', []string{}, create_rangeexception(rt.new_string('crypto_sign keypair seed must be 32 bytes long'))))
	}
	var_pk_mutated = Class_ParagonIE_Sodium_Core32_Ed25519.publickey_from_secretkey(var_seed_mutated.dup())
	var_sk_mutated = rt.new_string(rt.concat(var_seed_mutated, var_pk_mutated))
	return var_sk_mutated.dup()
}

fn Class_ParagonIE_Sodium_Core32_Ed25519.secretkey(var_keypair rt.PhpVal) rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('RangeException', []string{}, create_rangeexception(rt.new_string('crypto_sign keypair must be 96 bytes long'))))
	}
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_keypair.dup(), rt.new_int(0), rt.new_int(64))
}

fn Class_ParagonIE_Sodium_Core32_Ed25519.publickey(var_keypair rt.PhpVal) rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('RangeException', []string{}, create_rangeexception(rt.new_string('crypto_sign keypair must be 96 bytes long'))))
	}
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_keypair.dup(), rt.new_int(64), rt.new_int(32))
}

fn Class_ParagonIE_Sodium_Core32_Ed25519.publickey_from_secretkey(var_sk rt.PhpVal) rt.PhpVal {
	mut var_sk_mutated := var_sk
	var_sk_mutated = rt.call_function('hash', [rt.new_string('sha512'), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_sk_mutated.dup(), rt.new_int(0), rt.new_int(32)), rt.new_bool(true)])
	var_sk_mutated.array_set(0, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.inttochr(arg_0) }(rt.new_int(rt.bitwise_and(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.chrtoint(arg_0) }(var_sk_mutated.array_get(0)), rt.new_int(248)))))
	var_sk_mutated.array_set(31, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.inttochr(arg_0) }(rt.new_int(rt.bitwise_and(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.chrtoint(arg_0) }(var_sk_mutated.array_get(31)), rt.new_int(63)) | 64)))
	return Class_ParagonIE_Sodium_Core32_Ed25519.sk_to_pk(var_sk_mutated.dup())
}

fn Class_ParagonIE_Sodium_Core32_Ed25519.pk_to_curve25519(var_pk rt.PhpVal) rt.PhpVal {
	mut var_pk_mutated := var_pk
	if rt.is_true(Class_ParagonIE_Sodium_Core32_Ed25519.small_order(var_pk_mutated.dup())) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Public key is on a small order'))))
	}
	mut var_A := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.ge_frombytes_negate_vartime(arg_0) }(var_pk_mutated.dup())
	mut var_p1 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.ge_mul_l(arg_0) }(var_A.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.fe_isnonzero(arg_0) }(rt.get_property(var_p1, 'X')))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Unexpected zero result'))))
	}
	mut var_one_minux_y := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.fe_invert(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.fe_sub(arg_0, arg_1) }(fn () rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.fe_1() }(), rt.get_property(var_A, 'Y')))
	mut var_x := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.fe_mul(arg_0, arg_1) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.fe_add(arg_0, arg_1) }(fn () rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.fe_1() }(), rt.get_property(var_A, 'Y')), var_one_minux_y.dup())
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.fe_tobytes(arg_0) }(var_x.dup())
}

fn Class_ParagonIE_Sodium_Core32_Ed25519.sk_to_pk(var_sk rt.PhpVal) rt.PhpVal {
	mut var_sk_mutated := var_sk
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.ge_p3_tobytes(arg_0) }(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.ge_scalarmult_base(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_sk_mutated.dup(), rt.new_int(0), rt.new_int(32))))
}

fn Class_ParagonIE_Sodium_Core32_Ed25519.sign(var_message rt.PhpVal, var_sk rt.PhpVal) string {
	mut var_message_mutated := var_message
	mut var_sk_mutated := var_sk
	mut var_signature := Class_ParagonIE_Sodium_Core32_Ed25519.sign_detached(var_message_mutated.dup(), var_sk_mutated.dup())
	return (var_signature).str() + (var_message_mutated).str()
}

fn Class_ParagonIE_Sodium_Core32_Ed25519.sign_open(var_message rt.PhpVal, var_pk rt.PhpVal) rt.PhpVal {
	mut var_message_mutated := var_message
	mut var_pk_mutated := var_pk
	mut var_signature := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_message_mutated.dup(), rt.new_int(0), rt.new_int(64))
	var_message_mutated = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.substr(arg_0, arg_1) }(var_message_mutated.dup(), rt.new_int(64))
	if rt.is_true(Class_ParagonIE_Sodium_Core32_Ed25519.verify_detached(var_signature.dup(), var_message_mutated.dup(), var_pk_mutated.dup())) {
		return var_message_mutated.dup()
	}
	rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Invalid signature'))))
	return rt.new_null()
}

fn Class_ParagonIE_Sodium_Core32_Ed25519.sign_detached(var_message rt.PhpVal, var_sk rt.PhpVal) rt.PhpVal {
	mut var_message_mutated := var_message
	mut var_sk_mutated := var_sk
	mut var_az := rt.call_function('hash', [rt.new_string('sha512'), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_sk_mutated.dup(), rt.new_int(0), rt.new_int(32)), rt.new_bool(true)])
	var_az.array_set(0, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.inttochr(arg_0) }(rt.new_int(rt.bitwise_and(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.chrtoint(arg_0) }(var_az.array_get(0)), rt.new_int(248)))))
	var_az.array_set(31, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.inttochr(arg_0) }(rt.new_int(rt.bitwise_and(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.chrtoint(arg_0) }(var_az.array_get(31)), rt.new_int(63)) | 64)))
	mut var_hs := rt.call_function('hash_init', [rt.new_string('sha512')])
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.hash_update(arg_0, arg_1) }(var_hs.dup(), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_az.dup(), rt.new_int(32), rt.new_int(32)))
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.hash_update(arg_0, arg_1) }(var_hs.dup(), var_message_mutated.dup())
	mut var_nonceHash := rt.call_function('hash_final', [var_hs.dup(), rt.new_bool(true)])
	mut var_pk := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_sk_mutated.dup(), rt.new_int(32), rt.new_int(32))
	mut var_nonce := rt.new_string(rt.concat(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.sc_reduce(arg_0) }(var_nonceHash.dup()), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.substr(arg_0, arg_1) }(var_nonceHash.dup(), rt.new_int(32))))
	mut var_sig := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.ge_p3_tobytes(arg_0) }(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.ge_scalarmult_base(arg_0) }(var_nonce.dup()))
	var_hs = rt.call_function('hash_init', [rt.new_string('sha512')])
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.hash_update(arg_0, arg_1) }(var_hs.dup(), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_sig.dup(), rt.new_int(0), rt.new_int(32)))
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.hash_update(arg_0, arg_1) }(var_hs.dup(), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_pk.dup(), rt.new_int(0), rt.new_int(32)))
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.hash_update(arg_0, arg_1) }(var_hs.dup(), var_message_mutated.dup())
	mut var_hramHash := rt.call_function('hash_final', [var_hs.dup(), rt.new_bool(true)])
	mut var_hram := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.sc_reduce(arg_0) }(var_hramHash.dup())
	mut var_sigAfter := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.sc_muladd(arg_0, arg_1, arg_2) }(var_hram.dup(), var_az.dup(), var_nonce.dup())
	var_sig = rt.new_string(rt.concat(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_sig.dup(), rt.new_int(0), rt.new_int(32)), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_sigAfter.dup(), rt.new_int(0), rt.new_int(32))))
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

fn Class_ParagonIE_Sodium_Core32_Ed25519.verify_detached(var_sig rt.PhpVal, var_message rt.PhpVal, var_pk rt.PhpVal) rt.PhpVal {
	mut var_sig_mutated := var_sig
	mut var_message_mutated := var_message
	mut var_pk_mutated := var_pk
	if rt.is_true(rt.less(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.strlen(arg_0) }(var_sig_mutated.dup()), rt.new_int(64))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Signature is too short'))))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.bitwise_and(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.chrtoint(arg_0) }(var_sig_mutated.array_get(63)), rt.new_int(240))) && rt.is_true(Class_ParagonIE_Sodium_Core32_Ed25519.check_s_lt_l(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_sig_mutated.dup(), rt.new_int(32), rt.new_int(32)))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('S < L - Invalid signature'))))
	}
	if rt.is_true(Class_ParagonIE_Sodium_Core32_Ed25519.small_order(var_sig_mutated.dup())) {
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
	mut var_A := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.ge_frombytes_negate_vartime(arg_0) }(var_pk_mutated.dup())
	mut var_hDigest := rt.call_function('hash', [rt.new_string('sha512'), (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_sig_mutated.dup(), rt.new_int(0), rt.new_int(32))).str() + (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_pk_mutated.dup(), rt.new_int(0), rt.new_int(32))).str() + (var_message_mutated).str(), rt.new_bool(true)])
	mut var_h := rt.new_string(rt.concat(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.sc_reduce(arg_0) }(var_hDigest.dup()), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.substr(arg_0, arg_1) }(var_hDigest.dup(), rt.new_int(32))))
	mut var_R := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.ge_double_scalarmult_vartime(arg_0, arg_1, arg_2) }(var_h.dup(), var_A.dup(), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.substr(arg_0, arg_1) }(var_sig_mutated.dup(), rt.new_int(32)))
	mut var_rcheck := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.ge_tobytes(arg_0) }(var_R.dup())
	// unsupported assign target: Expr_StaticPropertyFetch
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.verify_32(arg_0, arg_1) }(var_rcheck.dup(), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_sig_mutated.dup(), rt.new_int(0), rt.new_int(32)))
}

fn Class_ParagonIE_Sodium_Core32_Ed25519.check_s_lt_l(var_S rt.PhpVal) rt.PhpVal {
	mut var_L := rt.new_null()
	if rt.is_true(rt.less(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.strlen(arg_0) }(var_S.dup()), rt.new_int(32))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Signature must be 32 bytes'))))
	}
	// unsupported statement: Stmt_Static
	mut var_c := rt.new_int(rt.new_int(0))
	mut var_n := rt.new_int(rt.new_int(1))
	mut var_i := rt.new_int(rt.new_int(32))
	for {
		rt.pre_dec(var_i)
		mut var_x := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Ed25519{}; return temp.chrtoint(arg_0) }(var_S.array_get(var_i))
		// unsupported expression: Expr_AssignOp_BitwiseOr
		// unsupported expression: Expr_AssignOp_BitwiseAnd
		if !(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)) {
			break
		}
	}
	return rt.identical(var_c, rt.new_int(0))
}

fn Class_ParagonIE_Sodium_Core32_Ed25519.small_order(var_R rt.PhpVal) bool {
	mut var_blocklist := rt.new_null()
	mut var_R_mutated := var_R
	// unsupported statement: Stmt_Static
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

fn create_paragonie_sodium_core32_ed25519() &Class_ParagonIE_Sodium_Core32_Ed25519 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Ed25519{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_curve25519() &Class_ParagonIE_Sodium_Core32_Curve25519 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Curve25519{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_rangeexception() &Class_RangeException {
	mut obj := &Class_RangeException{
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

fn (mut this Class_ParagonIE_Sodium_Core32_Ed25519) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'keypair' {
			return rt.new_string(Class_ParagonIE_Sodium_Core32_Ed25519.keypair())
		}
		'seed_keypair' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Ed25519.seed_keypair(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
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
			return rt.new_string(Class_ParagonIE_Sodium_Core32_Ed25519.sign(dispatch_arg_0, dispatch_arg_1))
		}
		'sign_open' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Ed25519.sign_open(dispatch_arg_0, dispatch_arg_1)
		}
		'sign_detached' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Ed25519.sign_detached(dispatch_arg_0, dispatch_arg_1)
		}
		'verify_detached' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Ed25519.verify_detached(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'check_S_lt_L' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Ed25519.check_s_lt_l(dispatch_arg_0)
		}
		'small_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_ParagonIE_Sodium_Core32_Ed25519.small_order(dispatch_arg_0))
		}
		else { return none }
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




pub fn init_wp_includes_sodium_compat_src_core32_ed25519_php() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_Core32_Ed25519'), rt.new_bool(false)])) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_Core32_Curve25519')]))))) {
		rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() + '/Curve25519.php', '4')
	}
}
