import rt

fn sodium_crypto_core_ristretto255_add(var_p rt.PhpVal, var_q rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.ristretto255_add(arg_0, arg_1, arg_2)
	}(var_p.dup(), var_q.dup(), rt.new_bool(true))
}

fn sodium_crypto_core_ristretto255_from_hash(var_s rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.ristretto255_from_hash(arg_0, arg_1)
	}(var_s.dup(), rt.new_bool(true))
}

fn sodium_crypto_core_ristretto255_is_valid_point(var_s rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.ristretto255_is_valid_point(arg_0, arg_1)
	}(var_s.dup(), rt.new_bool(true))
}

fn sodium_crypto_core_ristretto255_random() rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.ristretto255_random(arg_0)
	}(rt.new_bool(true))
}

fn sodium_crypto_core_ristretto255_scalar_add(var_x rt.PhpVal, var_y rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.ristretto255_scalar_add(arg_0, arg_1, arg_2)
	}(var_x.dup(), var_y.dup(), rt.new_bool(true))
}

fn sodium_crypto_core_ristretto255_scalar_complement(var_s rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.ristretto255_scalar_complement(arg_0, arg_1)
	}(var_s.dup(), rt.new_bool(true))
}

fn sodium_crypto_core_ristretto255_scalar_invert(var_p rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.ristretto255_scalar_invert(arg_0, arg_1)
	}(var_p.dup(), rt.new_bool(true))
}

fn sodium_crypto_core_ristretto255_scalar_mul(var_x rt.PhpVal, var_y rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.ristretto255_scalar_mul(arg_0, arg_1, arg_2)
	}(var_x.dup(), var_y.dup(), rt.new_bool(true))
}

fn sodium_crypto_core_ristretto255_scalar_negate(var_s rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.ristretto255_scalar_negate(arg_0, arg_1)
	}(var_s.dup(), rt.new_bool(true))
}

fn sodium_crypto_core_ristretto255_scalar_random() rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.ristretto255_scalar_random(arg_0)
	}(rt.new_bool(true))
}

fn sodium_crypto_core_ristretto255_scalar_reduce(var_s rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.ristretto255_scalar_reduce(arg_0, arg_1)
	}(var_s.dup(), rt.new_bool(true))
}

fn sodium_crypto_core_ristretto255_scalar_sub(var_x rt.PhpVal, var_y rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.ristretto255_scalar_sub(arg_0, arg_1, arg_2)
	}(var_x.dup(), var_y.dup(), rt.new_bool(true))
}

fn sodium_crypto_core_ristretto255_sub(var_p rt.PhpVal, var_q rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.ristretto255_sub(arg_0, arg_1, arg_2)
	}(var_p.dup(), var_q.dup(), rt.new_bool(true))
}

fn sodium_crypto_scalarmult_ristretto255(var_n rt.PhpVal, var_p rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.scalarmult_ristretto255(arg_0, arg_1, arg_2)
	}(var_n.dup(), var_p.dup(), rt.new_bool(true))
}

fn sodium_crypto_scalarmult_ristretto255_base(var_n rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Compat{}
		return temp.scalarmult_ristretto255_base(arg_0, arg_1)
	}(var_n.dup(), rt.new_bool(true))
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

pub fn init_wp_includes_sodium_compat_lib_ristretto255_php() {
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
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_core_ristretto255_add'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_core_ristretto255_from_hash'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_core_ristretto255_is_valid_point'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_core_ristretto255_random'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_core_ristretto255_scalar_add'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_core_ristretto255_scalar_complement'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_core_ristretto255_scalar_invert'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_core_ristretto255_scalar_mul'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_core_ristretto255_scalar_negate'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_core_ristretto255_scalar_random'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_core_ristretto255_scalar_reduce'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_core_ristretto255_scalar_sub'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_core_ristretto255_sub'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_scalarmult_ristretto255'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		rt.new_string('sodium_crypto_scalarmult_ristretto255_base'),
	])))))
	{
	}
}
