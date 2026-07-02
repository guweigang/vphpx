import rt

struct Class_ParagonIE_Sodium_Core_X25519 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core_X25519.fe_cswap(mut var_f Class_ParagonIE_Sodium_Core_Curve25519_Fe, mut var_g Class_ParagonIE_Sodium_Core_Curve25519_Fe, b i64) {
	mut b_mutated := b
	b_mutated = -b_mutated
	mut var_x0 := rt.new_int(rt.bitwise_xor(rt.get_property(var_f, 'e0'), rt.get_property(var_g, 'e0')) & b_mutated)
	mut var_x1 := rt.new_int(rt.bitwise_xor(rt.get_property(var_f, 'e1'), rt.get_property(var_g, 'e1')) & b_mutated)
	mut var_x2 := rt.new_int(rt.bitwise_xor(rt.get_property(var_f, 'e2'), rt.get_property(var_g, 'e2')) & b_mutated)
	mut var_x3 := rt.new_int(rt.bitwise_xor(rt.get_property(var_f, 'e3'), rt.get_property(var_g, 'e3')) & b_mutated)
	mut var_x4 := rt.new_int(rt.bitwise_xor(rt.get_property(var_f, 'e4'), rt.get_property(var_g, 'e4')) & b_mutated)
	mut var_x5 := rt.new_int(rt.bitwise_xor(rt.get_property(var_f, 'e5'), rt.get_property(var_g, 'e5')) & b_mutated)
	mut var_x6 := rt.new_int(rt.bitwise_xor(rt.get_property(var_f, 'e6'), rt.get_property(var_g, 'e6')) & b_mutated)
	mut var_x7 := rt.new_int(rt.bitwise_xor(rt.get_property(var_f, 'e7'), rt.get_property(var_g, 'e7')) & b_mutated)
	mut var_x8 := rt.new_int(rt.bitwise_xor(rt.get_property(var_f, 'e8'), rt.get_property(var_g, 'e8')) & b_mutated)
	mut var_x9 := rt.new_int(rt.bitwise_xor(rt.get_property(var_f, 'e9'), rt.get_property(var_g, 'e9')) & b_mutated)
	rt.new_null()
	rt.new_null()
	rt.new_null()
	rt.new_null()
	rt.new_null()
	rt.new_null()
	rt.new_null()
	rt.new_null()
	rt.new_null()
	rt.new_null()
	rt.new_null()
	rt.new_null()
	rt.new_null()
	rt.new_null()
	rt.new_null()
	rt.new_null()
	rt.new_null()
	rt.new_null()
	rt.new_null()
	rt.new_null()
}

fn Class_ParagonIE_Sodium_Core_X25519.fe_mul121666(mut var_f Class_ParagonIE_Sodium_Core_Curve25519_Fe) rt.PhpVal {
	mut iife_temp_0 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_0 := iife_temp_0.mul(rt.get_property(var_f, 'e0'), rt.new_int(121666), rt.new_int(17))
	mut var_h0 := iife_result_0
	mut iife_temp_1 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_1 := iife_temp_1.mul(rt.get_property(var_f, 'e1'), rt.new_int(121666), rt.new_int(17))
	mut var_h1 := iife_result_1
	mut iife_temp_2 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_2 := iife_temp_2.mul(rt.get_property(var_f, 'e2'), rt.new_int(121666), rt.new_int(17))
	mut var_h2 := iife_result_2
	mut iife_temp_3 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_3 := iife_temp_3.mul(rt.get_property(var_f, 'e3'), rt.new_int(121666), rt.new_int(17))
	mut var_h3 := iife_result_3
	mut iife_temp_4 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_4 := iife_temp_4.mul(rt.get_property(var_f, 'e4'), rt.new_int(121666), rt.new_int(17))
	mut var_h4 := iife_result_4
	mut iife_temp_5 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_5 := iife_temp_5.mul(rt.get_property(var_f, 'e5'), rt.new_int(121666), rt.new_int(17))
	mut var_h5 := iife_result_5
	mut iife_temp_6 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_6 := iife_temp_6.mul(rt.get_property(var_f, 'e6'), rt.new_int(121666), rt.new_int(17))
	mut var_h6 := iife_result_6
	mut iife_temp_7 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_7 := iife_temp_7.mul(rt.get_property(var_f, 'e7'), rt.new_int(121666), rt.new_int(17))
	mut var_h7 := iife_result_7
	mut iife_temp_8 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_8 := iife_temp_8.mul(rt.get_property(var_f, 'e8'), rt.new_int(121666), rt.new_int(17))
	mut var_h8 := iife_result_8
	mut iife_temp_9 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_9 := iife_temp_9.mul(rt.get_property(var_f, 'e9'), rt.new_int(121666), rt.new_int(17))
	mut var_h9 := iife_result_9
	mut var_carry9 := rt.new_int(rt.shift_right(rt.add(var_h9, 1 << 24), rt.new_int(25)))
	mut iife_temp_10 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_10 := iife_temp_10.mul(var_carry9.clone(), rt.new_int(19), rt.new_int(5))
	var_h0 = rt.add(var_h0, iife_result_10)
	var_h9 = rt.sub(var_h9, rt.shift_left(var_carry9, rt.new_int(25)))
	mut var_carry1 := rt.new_int(rt.shift_right(rt.add(var_h1, 1 << 24), rt.new_int(25)))
	var_h2 = rt.add(var_h2, var_carry1)
	var_h1 = rt.sub(var_h1, rt.shift_left(var_carry1, rt.new_int(25)))
	mut var_carry3 := rt.new_int(rt.shift_right(rt.add(var_h3, 1 << 24), rt.new_int(25)))
	var_h4 = rt.add(var_h4, var_carry3)
	var_h3 = rt.sub(var_h3, rt.shift_left(var_carry3, rt.new_int(25)))
	mut var_carry5 := rt.new_int(rt.shift_right(rt.add(var_h5, 1 << 24), rt.new_int(25)))
	var_h6 = rt.add(var_h6, var_carry5)
	var_h5 = rt.sub(var_h5, rt.shift_left(var_carry5, rt.new_int(25)))
	mut var_carry7 := rt.new_int(rt.shift_right(rt.add(var_h7, 1 << 24), rt.new_int(25)))
	var_h8 = rt.add(var_h8, var_carry7)
	var_h7 = rt.sub(var_h7, rt.shift_left(var_carry7, rt.new_int(25)))
	mut var_carry0 := rt.new_int(rt.shift_right(rt.add(var_h0, 1 << 25), rt.new_int(26)))
	var_h1 = rt.add(var_h1, var_carry0)
	var_h0 = rt.sub(var_h0, rt.shift_left(var_carry0, rt.new_int(26)))
	mut var_carry2 := rt.new_int(rt.shift_right(rt.add(var_h2, 1 << 25), rt.new_int(26)))
	var_h3 = rt.add(var_h3, var_carry2)
	var_h2 = rt.sub(var_h2, rt.shift_left(var_carry2, rt.new_int(26)))
	mut var_carry4 := rt.new_int(rt.shift_right(rt.add(var_h4, 1 << 25), rt.new_int(26)))
	var_h5 = rt.add(var_h5, var_carry4)
	var_h4 = rt.sub(var_h4, rt.shift_left(var_carry4, rt.new_int(26)))
	mut var_carry6 := rt.new_int(rt.shift_right(rt.add(var_h6, 1 << 25), rt.new_int(26)))
	var_h7 = rt.add(var_h7, var_carry6)
	var_h6 = rt.sub(var_h6, rt.shift_left(var_carry6, rt.new_int(26)))
	mut var_carry8 := rt.new_int(rt.shift_right(rt.add(var_h8, 1 << 25), rt.new_int(26)))
	var_h9 = rt.add(var_h9, var_carry8)
	var_h8 = rt.sub(var_h8, rt.shift_left(var_carry8, rt.new_int(26)))
	return rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe', []string{}, create_paragonie_sodium_core_curve25519_fe(var_h0.clone(), var_h1.clone(), var_h2.clone(), var_h3.clone(), var_h4.clone(), var_h5.clone(), var_h6.clone(), var_h7.clone(), var_h8.clone(), var_h9.clone()))
}

fn Class_ParagonIE_Sodium_Core_X25519.crypto_scalarmult_curve25519_ref10(var_n rt.PhpVal, var_p rt.PhpVal) rt.PhpVal {
	mut var_e := rt.new_string('' + (var_n).str())
	mut iife_temp_11 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_11 := iife_temp_11.chrtoint(var_e.array_get(rt.new_int(0)))
	mut iife_temp_12 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_12 := iife_temp_12.inttochr(rt.new_int(rt.bitwise_and(iife_result_11, rt.new_int(248))))
	var_e.array_set(0, iife_result_12)
	mut iife_temp_13 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_13 := iife_temp_13.chrtoint(var_e.array_get(rt.new_int(31)))
	mut iife_temp_14 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_14 := iife_temp_14.inttochr(rt.new_int(rt.bitwise_and(iife_result_13, rt.new_int(127)) | 64))
	var_e.array_set(31, iife_result_14)
	mut iife_temp_15 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_15 := iife_temp_15.fe_frombytes(var_p.clone())
	mut var_x1 := iife_result_15
	mut iife_temp_16 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_16 := iife_temp_16.fe_1()
	mut var_x2 := iife_result_16
	mut iife_temp_17 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_17 := iife_temp_17.fe_0()
	mut var_z2 := iife_result_17
	mut iife_temp_18 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_18 := iife_temp_18.fe_copy(var_x1.clone())
	mut var_x3 := iife_result_18
	mut iife_temp_19 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_19 := iife_temp_19.fe_1()
	mut var_z3 := iife_result_19
	mut var_swap := rt.new_int(0)
	mut var_pos := rt.new_int(254)
	for {
		if !(rt.is_true(rt.greater_equal(var_pos, rt.new_int(0)))) { break }
		mut iife_temp_20 := Class_ParagonIE_Sodium_Core_X25519{}
		mut iife_result_20 := iife_temp_20.chrtoint(var_e.array_get(rt.new_int((rt.call_function('floor', [rt.div(var_pos, rt.new_int(8))])).to_i64())))
		mut var_b := rt.new_int(rt.shift_right(iife_result_20, rt.bitwise_and(var_pos, rt.new_int(7))))
		rt.new_null()
		rt.new_null()
		Class_ParagonIE_Sodium_Core_X25519.fe_cswap(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_x2), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_x3), (var_swap).to_i64())
		Class_ParagonIE_Sodium_Core_X25519.fe_cswap(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_z2), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_z3), (var_swap).to_i64())
		var_swap = var_b.clone()
		mut iife_temp_21 := Class_ParagonIE_Sodium_Core_X25519{}
		mut iife_result_21 := iife_temp_21.fe_sub(var_x3.clone(), var_z3.clone())
		mut var_tmp0 := iife_result_21
		mut iife_temp_22 := Class_ParagonIE_Sodium_Core_X25519{}
		mut iife_result_22 := iife_temp_22.fe_sub(var_x2.clone(), var_z2.clone())
		mut var_tmp1 := iife_result_22
		mut iife_temp_23 := Class_ParagonIE_Sodium_Core_X25519{}
		mut iife_result_23 := iife_temp_23.fe_add(var_x2.clone(), var_z2.clone())
		var_x2 = iife_result_23
		mut iife_temp_24 := Class_ParagonIE_Sodium_Core_X25519{}
		mut iife_result_24 := iife_temp_24.fe_add(var_x3.clone(), var_z3.clone())
		var_z2 = iife_result_24
		mut iife_temp_25 := Class_ParagonIE_Sodium_Core_X25519{}
		mut iife_result_25 := iife_temp_25.fe_mul(var_tmp0.clone(), var_x2.clone())
		var_z3 = iife_result_25
		mut iife_temp_26 := Class_ParagonIE_Sodium_Core_X25519{}
		mut iife_result_26 := iife_temp_26.fe_mul(var_z2.clone(), var_tmp1.clone())
		var_z2 = iife_result_26
		mut iife_temp_27 := Class_ParagonIE_Sodium_Core_X25519{}
		mut iife_result_27 := iife_temp_27.fe_sq(var_tmp1.clone())
		var_tmp0 = iife_result_27
		mut iife_temp_28 := Class_ParagonIE_Sodium_Core_X25519{}
		mut iife_result_28 := iife_temp_28.fe_sq(var_x2.clone())
		var_tmp1 = iife_result_28
		mut iife_temp_29 := Class_ParagonIE_Sodium_Core_X25519{}
		mut iife_result_29 := iife_temp_29.fe_add(var_z3.clone(), var_z2.clone())
		var_x3 = iife_result_29
		mut iife_temp_30 := Class_ParagonIE_Sodium_Core_X25519{}
		mut iife_result_30 := iife_temp_30.fe_sub(var_z3.clone(), var_z2.clone())
		var_z2 = iife_result_30
		mut iife_temp_31 := Class_ParagonIE_Sodium_Core_X25519{}
		mut iife_result_31 := iife_temp_31.fe_mul(var_tmp1.clone(), var_tmp0.clone())
		var_x2 = iife_result_31
		mut iife_temp_32 := Class_ParagonIE_Sodium_Core_X25519{}
		mut iife_result_32 := iife_temp_32.fe_sub(var_tmp1.clone(), var_tmp0.clone())
		var_tmp1 = iife_result_32
		mut iife_temp_33 := Class_ParagonIE_Sodium_Core_X25519{}
		mut iife_result_33 := iife_temp_33.fe_sq(var_z2.clone())
		var_z2 = iife_result_33
		var_z3 = Class_ParagonIE_Sodium_Core_X25519.fe_mul121666(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_tmp1))
		mut iife_temp_34 := Class_ParagonIE_Sodium_Core_X25519{}
		mut iife_result_34 := iife_temp_34.fe_sq(var_x3.clone())
		var_x3 = iife_result_34
		mut iife_temp_35 := Class_ParagonIE_Sodium_Core_X25519{}
		mut iife_result_35 := iife_temp_35.fe_add(var_tmp0.clone(), var_z3.clone())
		var_tmp0 = iife_result_35
		mut iife_temp_36 := Class_ParagonIE_Sodium_Core_X25519{}
		mut iife_result_36 := iife_temp_36.fe_mul(var_x1.clone(), var_z2.clone())
		var_z3 = iife_result_36
		mut iife_temp_37 := Class_ParagonIE_Sodium_Core_X25519{}
		mut iife_result_37 := iife_temp_37.fe_mul(var_tmp1.clone(), var_tmp0.clone())
		var_z2 = iife_result_37
		rt.pre_dec(var_pos)
	}
	Class_ParagonIE_Sodium_Core_X25519.fe_cswap(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_x2), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_x3), (var_swap).to_i64())
	Class_ParagonIE_Sodium_Core_X25519.fe_cswap(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_z2), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_z3), (var_swap).to_i64())
	mut iife_temp_38 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_38 := iife_temp_38.fe_invert(var_z2.clone())
	mut var_z2 := iife_result_38
	mut iife_temp_39 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_39 := iife_temp_39.fe_mul(var_x2.clone(), var_z2.clone())
	mut var_x2 := iife_result_39
	mut iife_temp_40 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_40 := iife_temp_40.fe_tobytes(var_x2.clone())
	return iife_result_40
}

fn Class_ParagonIE_Sodium_Core_X25519.edwards_to_montgomery(mut var_edwardsY Class_ParagonIE_Sodium_Core_Curve25519_Fe, mut var_edwardsZ Class_ParagonIE_Sodium_Core_Curve25519_Fe) rt.PhpVal {
	mut iife_temp_41 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_41 := iife_temp_41.fe_add(rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe', []string{}, var_edwardsZ), rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe', []string{}, var_edwardsY))
	mut var_tempX := iife_result_41
	mut iife_temp_42 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_42 := iife_temp_42.fe_sub(rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe', []string{}, var_edwardsZ), rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe', []string{}, var_edwardsY))
	mut var_tempZ := iife_result_42
	mut iife_temp_43 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_43 := iife_temp_43.fe_invert(var_tempZ.clone())
	var_tempZ = iife_result_43
	mut iife_temp_44 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_44 := iife_temp_44.fe_mul(var_tempX.clone(), var_tempZ.clone())
	return iife_result_44
}

fn Class_ParagonIE_Sodium_Core_X25519.crypto_scalarmult_curve25519_ref10_base(var_n rt.PhpVal) rt.PhpVal {
	mut var_e := rt.new_string('' + (var_n).str())
	mut iife_temp_45 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_45 := iife_temp_45.chrtoint(var_e.array_get(rt.new_int(0)))
	mut iife_temp_46 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_46 := iife_temp_46.inttochr(rt.new_int(rt.bitwise_and(iife_result_45, rt.new_int(248))))
	var_e.array_set(0, iife_result_46)
	mut iife_temp_47 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_47 := iife_temp_47.chrtoint(var_e.array_get(rt.new_int(31)))
	mut iife_temp_48 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_48 := iife_temp_48.inttochr(rt.new_int(rt.bitwise_and(iife_result_47, rt.new_int(127)) | 64))
	var_e.array_set(31, iife_result_48)
	mut iife_temp_49 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_49 := iife_temp_49.ge_scalarmult_base(var_e.clone())
	mut var_A := iife_result_49
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.get_property(var_A, 'Y'), 'ParagonIE_Sodium_Core_Curve25519_Fe')))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.get_property(var_A, 'Z'), 'ParagonIE_Sodium_Core_Curve25519_Fe')))))) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(rt.new_string('Null points encountered'))))
	}
	mut var_pk := Class_ParagonIE_Sodium_Core_X25519.edwards_to_montgomery(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](rt.get_property(var_A, 'Y')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](rt.get_property(var_A, 'Z')))
	mut iife_temp_50 := Class_ParagonIE_Sodium_Core_X25519{}
	mut iife_result_50 := iife_temp_50.fe_tobytes(var_pk.clone())
	return iife_result_50
}

struct Class_ParagonIE_Sodium_Core_Curve25519 {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core_Curve25519_Fe {
	rt.PhpObjectBase
}

struct Class_TypeError {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_x25519(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_X25519 {
	mut obj := &Class_ParagonIE_Sodium_Core_X25519{
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

fn create_paragonie_sodium_core_curve25519_fe(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_Curve25519_Fe {
	mut obj := &Class_ParagonIE_Sodium_Core_Curve25519_Fe{
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

fn (mut this Class_ParagonIE_Sodium_Core_X25519) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'fe_cswap' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			Class_ParagonIE_Sodium_Core_X25519.fe_cswap(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'fe_mul121666' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_X25519.fe_mul121666(mut dispatch_arg_0)
		}
		'crypto_scalarmult_curve25519_ref10' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_X25519.crypto_scalarmult_curve25519_ref10(dispatch_arg_0, dispatch_arg_1)
		}
		'edwards_to_montgomery' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_X25519.edwards_to_montgomery(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'crypto_scalarmult_curve25519_ref10_base' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_X25519.crypto_scalarmult_curve25519_ref10_base(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_ParagonIE_Sodium_Core_X25519) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_X25519) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Fe) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_Curve25519_Fe) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Fe) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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



fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_Core_X25519'), rt.new_bool(false)])) {
		return rt.new_null()
	}
}
