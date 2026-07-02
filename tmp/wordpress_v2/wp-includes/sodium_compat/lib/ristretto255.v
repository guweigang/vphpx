import rt

fn sodium_crypto_core_ristretto255_add(var_p rt.PhpVal, var_q rt.PhpVal) rt.PhpVal {
	mut iife_temp_0 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_0 := iife_temp_0.ristretto255_add(var_p.clone(), var_q.clone(),
		rt.new_bool(true))
	return iife_result_0
}

fn sodium_crypto_core_ristretto255_from_hash(var_s rt.PhpVal) rt.PhpVal {
	mut iife_temp_1 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_1 := iife_temp_1.ristretto255_from_hash(var_s.clone(), rt.new_bool(true))
	return iife_result_1
}

fn sodium_crypto_core_ristretto255_is_valid_point(var_s rt.PhpVal) rt.PhpVal {
	mut iife_temp_2 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_2 := iife_temp_2.ristretto255_is_valid_point(var_s.clone(), rt.new_bool(true))
	return iife_result_2
}

fn sodium_crypto_core_ristretto255_random() rt.PhpVal {
	mut iife_temp_3 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_3 := iife_temp_3.ristretto255_random(rt.new_bool(true))
	return iife_result_3
}

fn sodium_crypto_core_ristretto255_scalar_add(var_x rt.PhpVal, var_y rt.PhpVal) rt.PhpVal {
	mut iife_temp_4 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_4 := iife_temp_4.ristretto255_scalar_add(var_x.clone(), var_y.clone(),
		rt.new_bool(true))
	return iife_result_4
}

fn sodium_crypto_core_ristretto255_scalar_complement(var_s rt.PhpVal) rt.PhpVal {
	mut iife_temp_5 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_5 := iife_temp_5.ristretto255_scalar_complement(var_s.clone(),
		rt.new_bool(true))
	return iife_result_5
}

fn sodium_crypto_core_ristretto255_scalar_invert(var_p rt.PhpVal) rt.PhpVal {
	mut iife_temp_6 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_6 := iife_temp_6.ristretto255_scalar_invert(var_p.clone(), rt.new_bool(true))
	return iife_result_6
}

fn sodium_crypto_core_ristretto255_scalar_mul(var_x rt.PhpVal, var_y rt.PhpVal) rt.PhpVal {
	mut iife_temp_7 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_7 := iife_temp_7.ristretto255_scalar_mul(var_x.clone(), var_y.clone(),
		rt.new_bool(true))
	return iife_result_7
}

fn sodium_crypto_core_ristretto255_scalar_negate(var_s rt.PhpVal) rt.PhpVal {
	mut iife_temp_8 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_8 := iife_temp_8.ristretto255_scalar_negate(var_s.clone(), rt.new_bool(true))
	return iife_result_8
}

fn sodium_crypto_core_ristretto255_scalar_random() rt.PhpVal {
	mut iife_temp_9 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_9 := iife_temp_9.ristretto255_scalar_random(rt.new_bool(true))
	return iife_result_9
}

fn sodium_crypto_core_ristretto255_scalar_reduce(var_s rt.PhpVal) rt.PhpVal {
	mut iife_temp_10 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_10 := iife_temp_10.ristretto255_scalar_reduce(var_s.clone(), rt.new_bool(true))
	return iife_result_10
}

fn sodium_crypto_core_ristretto255_scalar_sub(var_x rt.PhpVal, var_y rt.PhpVal) rt.PhpVal {
	mut iife_temp_11 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_11 := iife_temp_11.ristretto255_scalar_sub(var_x.clone(), var_y.clone(),
		rt.new_bool(true))
	return iife_result_11
}

fn sodium_crypto_core_ristretto255_sub(var_p rt.PhpVal, var_q rt.PhpVal) rt.PhpVal {
	mut iife_temp_12 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_12 := iife_temp_12.ristretto255_sub(var_p.clone(), var_q.clone(),
		rt.new_bool(true))
	return iife_result_12
}

fn sodium_crypto_scalarmult_ristretto255(var_n rt.PhpVal, var_p rt.PhpVal) rt.PhpVal {
	mut iife_temp_13 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_13 := iife_temp_13.scalarmult_ristretto255(var_n.clone(), var_p.clone(),
		rt.new_bool(true))
	return iife_result_13
}

fn sodium_crypto_scalarmult_ristretto255_base(var_n rt.PhpVal) rt.PhpVal {
	mut iife_temp_14 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_14 := iife_temp_14.scalarmult_ristretto255_base(var_n.clone(),
		rt.new_bool(true))
	return iife_result_14
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

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('SODIUM_CRYPTO_CORE_RISTRETTO255_BYTES'),
	])))))
	{
		rt.call_function('define', [
			rt.new_string('SODIUM_CRYPTO_CORE_RISTRETTO255_BYTES'),
			Class_ParagonIE_Sodium_Compat.crypto_core_ristretto255_bytes(),
		])
		rt.call_function('define', [
			rt.new_string('SODIUM_COMPAT_POLYFILLED_RISTRETTO255'),
			rt.new_bool(true),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('SODIUM_CRYPTO_CORE_RISTRETTO255_HASHBYTES'),
	])))))
	{
		rt.call_function('define', [
			rt.new_string('SODIUM_CRYPTO_CORE_RISTRETTO255_HASHBYTES'),
			Class_ParagonIE_Sodium_Compat.crypto_core_ristretto255_hashbytes(),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('SODIUM_CRYPTO_CORE_RISTRETTO255_SCALARBYTES'),
	])))))
	{
		rt.call_function('define', [
			rt.new_string('SODIUM_CRYPTO_CORE_RISTRETTO255_SCALARBYTES'),
			Class_ParagonIE_Sodium_Compat.crypto_core_ristretto255_scalarbytes(),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('SODIUM_CRYPTO_CORE_RISTRETTO255_NONREDUCEDSCALARBYTES'),
	])))))
	{
		rt.call_function('define', [
			rt.new_string('SODIUM_CRYPTO_CORE_RISTRETTO255_NONREDUCEDSCALARBYTES'),
			Class_ParagonIE_Sodium_Compat.crypto_core_ristretto255_nonreducedscalarbytes(),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('SODIUM_CRYPTO_SCALARMULT_RISTRETTO255_SCALARBYTES'),
	])))))
	{
		rt.call_function('define', [
			rt.new_string('SODIUM_CRYPTO_SCALARMULT_RISTRETTO255_SCALARBYTES'),
			Class_ParagonIE_Sodium_Compat.crypto_scalarmult_ristretto255_scalarbytes(),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('SODIUM_CRYPTO_SCALARMULT_RISTRETTO255_BYTES'),
	])))))
	{
		rt.call_function('define', [
			rt.new_string('SODIUM_CRYPTO_SCALARMULT_RISTRETTO255_BYTES'),
			Class_ParagonIE_Sodium_Compat.crypto_scalarmult_ristretto255_bytes(),
		])
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_core_ristretto255_add'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_core_ristretto255_from_hash'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_core_ristretto255_is_valid_point'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_core_ristretto255_random'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_core_ristretto255_scalar_add'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_core_ristretto255_scalar_complement'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_core_ristretto255_scalar_invert'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_core_ristretto255_scalar_mul'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_core_ristretto255_scalar_negate'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_core_ristretto255_scalar_random'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_core_ristretto255_scalar_reduce'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_core_ristretto255_scalar_sub'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_core_ristretto255_sub'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_scalarmult_ristretto255'),
	])) {
	}
	if !(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_scalarmult_ristretto255_base'),
	])) {
	}
}
