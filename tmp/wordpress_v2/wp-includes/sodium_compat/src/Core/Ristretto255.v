import rt

pub fn Class_ParagonIE_Sodium_Core_Ristretto255.crypto_core_ristretto255_hashbytes() i64 {
	return 64
}

pub fn Class_ParagonIE_Sodium_Core_Ristretto255.hash_sc_l() i64 {
	return 48
}

pub fn Class_ParagonIE_Sodium_Core_Ristretto255.core_h2c_sha256() i64 {
	return 1
}

pub fn Class_ParagonIE_Sodium_Core_Ristretto255.core_h2c_sha512() i64 {
	return 2
}

struct Class_ParagonIE_Sodium_Core_Ristretto255 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.fe_cneg(mut var_f Class_ParagonIE_Sodium_Core_Curve25519_Fe, var_b rt.PhpVal) rt.PhpVal {
	mut iife_temp_0 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_0 := iife_temp_0.fe_neg(rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe',
		[]string{}, var_f))
	mut var_negf := iife_result_0
	mut iife_temp_1 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_1 := iife_temp_1.fe_cmov(rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe',
		[]string{}, var_f), var_negf.clone(), var_b.clone())
	return iife_result_1
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.fe_abs(mut var_f Class_ParagonIE_Sodium_Core_Curve25519_Fe) rt.PhpVal {
	mut iife_temp_2 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_2 := iife_temp_2.fe_isnegative(rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe',
		[]string{}, var_f))
	return Class_ParagonIE_Sodium_Core_Ristretto255.fe_cneg(mut var_f, iife_result_2)
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.fe_iszero(mut var_f Class_ParagonIE_Sodium_Core_Curve25519_Fe) i64 {
	mut var_zero := rt.new_null()
	if rt.is_true(rt.identical(var_zero, rt.new_null())) {
		var_zero = rt.call_function('str_repeat', [rt.new_string(''),
			rt.new_int(32)])
	}
	mut iife_temp_3 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_3 := iife_temp_3.fe_tobytes(rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe',
		[]string{}, var_f))
	mut var_str := iife_result_3
	mut var_d := rt.new_int(0)
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(32)))) { break
		 }
		rt.new_null()
		rt.pre_inc(var_i)
	}
	return rt.shift_right(rt.sub(var_d, rt.new_int(1)), rt.new_int(31)) & 1
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_sqrt_ratio_m1(mut var_u Class_ParagonIE_Sodium_Core_Curve25519_Fe, mut var_v Class_ParagonIE_Sodium_Core_Curve25519_Fe) rt.PhpVal {
	mut var_u_mutated := var_u
	mut var_v_mutated := var_v
	mut iife_temp_4 := Class_ParagonIE_Sodium_Core_Curve25519_Fe{}
	mut iife_result_4 := iife_temp_4.fromarray(rt.get_static_prop('ParagonIE_Sodium_Core_Ristretto255',
		'sqrtm1'))
	mut var_sqrtm1 := iife_result_4
	mut iife_temp_5 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_5 := iife_temp_5.fe_sq(rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe',
		[]string{}, var_v_mutated))
	mut iife_temp_6 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_6 := iife_temp_6.fe_mul(iife_result_5, rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe',
		[]string{}, var_v_mutated))
	mut var_v3 := iife_result_6
	mut iife_temp_7 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_7 := iife_temp_7.fe_sq(var_v3.clone())
	mut iife_temp_8 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_8 := iife_temp_8.fe_mul(iife_result_7, rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe',
		[]string{}, var_u_mutated))
	mut iife_temp_9 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_9 := iife_temp_9.fe_mul(iife_result_8, rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe',
		[]string{}, var_v_mutated))
	mut var_x := iife_result_9
	mut iife_temp_10 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_10 := iife_temp_10.fe_pow22523(var_x.clone())
	mut iife_temp_11 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_11 := iife_temp_11.fe_mul(iife_result_10, var_v3.clone())
	mut iife_temp_12 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_12 := iife_temp_12.fe_mul(iife_result_11, rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe',
		[]string{}, var_u_mutated))
	var_x = iife_result_12
	mut iife_temp_13 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_13 := iife_temp_13.fe_sq(var_x.clone())
	mut iife_temp_14 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_14 := iife_temp_14.fe_mul(iife_result_13, rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe',
		[]string{}, var_v_mutated))
	mut var_vxx := iife_result_14
	mut iife_temp_15 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_15 := iife_temp_15.fe_sub(var_vxx.clone(), rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe',
		[]string{}, var_u_mutated))
	mut var_m_root_check := iife_result_15
	mut iife_temp_16 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_16 := iife_temp_16.fe_add(var_vxx.clone(), rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe',
		[]string{}, var_u_mutated))
	mut var_p_root_check := iife_result_16
	mut iife_temp_17 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_17 := iife_temp_17.fe_mul(rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe',
		[]string{}, var_u_mutated), var_sqrtm1.clone())
	mut var_f_root_check := iife_result_17
	mut iife_temp_18 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_18 := iife_temp_18.fe_add(var_vxx.clone(), var_f_root_check.clone())
	var_f_root_check = iife_result_18
	mut var_has_m_root :=
		Class_ParagonIE_Sodium_Core_Ristretto255.fe_iszero(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_m_root_check))
	mut var_has_p_root :=
		Class_ParagonIE_Sodium_Core_Ristretto255.fe_iszero(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_p_root_check))
	mut var_has_f_root :=
		Class_ParagonIE_Sodium_Core_Ristretto255.fe_iszero(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_f_root_check))
	mut iife_temp_19 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_19 := iife_temp_19.fe_mul(var_x.clone(), var_sqrtm1.clone())
	mut var_x_sqrtm1 := iife_result_19
	mut iife_temp_20 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_20 := iife_temp_20.fe_cmov(var_x.clone(), var_x_sqrtm1.clone(), rt.new_int(rt.bitwise_or(var_has_p_root,
		var_has_f_root)))
	var_x =
		Class_ParagonIE_Sodium_Core_Ristretto255.fe_abs(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](iife_result_20))
	return rt.create_array([rt.ArrayItem{ key: 'x', val: var_x },
		rt.ArrayItem{ key: 'nonsquare', val: rt.bitwise_or(var_has_m_root, var_has_p_root) }])
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_point_is_canonical(var_s rt.PhpVal) i64 {
	mut var_s_mutated := var_s
	mut iife_temp_21 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_21 := iife_temp_21.chrtoint(var_s_mutated.array_get(rt.new_int(31)))
	mut var_c := rt.new_int(rt.bitwise_and(iife_result_21, rt.new_int(127)) ^ 127)
	mut var_i := rt.new_int(30)
	for {
		if !(rt.is_true(rt.greater(var_i, rt.new_int(0)))) { break
		 }
		rt.new_null()
		rt.pre_dec(var_i)
	}
	var_c = rt.new_int(rt.shift_right(rt.sub(var_c, rt.new_int(1)), rt.new_int(8)))
	mut iife_temp_22 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_22 := iife_temp_22.chrtoint(var_s_mutated.array_get(rt.new_int(0)))
	mut var_d := rt.new_int(rt.shift_right(rt.sub(237 - 1, iife_result_22), rt.new_int(8)))
	mut iife_temp_23 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_23 := iife_temp_23.chrtoint(var_s_mutated.array_get(rt.new_int(31)))
	mut var_e := rt.new_int(rt.shift_right(iife_result_23, rt.new_int(7)))
	mut iife_temp_24 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_24 := iife_temp_24.chrtoint(var_s_mutated.array_get(rt.new_int(0)))
	return 1 - rt.bitwise_or(rt.bitwise_or(rt.bitwise_and(var_c, var_d), var_e), iife_result_24) & 1
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_frombytes(var_s rt.PhpVal, skipCanonicalCheck bool) rt.PhpVal {
	mut var_s_mutated := var_s
	if !var_skipCanonicalCheck {
		if rt.is_true(rt.new_bool(!(rt.is_true(Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_point_is_canonical(var_s_mutated.clone()))))) {
			rt.throw_exception(rt.new_object('SodiumException', []string{},
				create_sodiumexception(rt.new_string('S is not canonical'))))
		}
	}
	mut iife_temp_25 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_25 := iife_temp_25.fe_frombytes(var_s_mutated.clone())
	mut var_s_ := iife_result_25
	mut iife_temp_26 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_26 := iife_temp_26.fe_sq(var_s_.clone())
	mut var_ss := iife_result_26
	mut iife_temp_27 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_27 := iife_temp_27.fe_1()
	mut iife_temp_28 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_28 := iife_temp_28.fe_sub(iife_result_27, var_ss.clone())
	mut var_u1 := iife_result_28
	mut iife_temp_29 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_29 := iife_temp_29.fe_sq(var_u1.clone())
	mut var_u1u1 := iife_result_29
	mut iife_temp_30 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_30 := iife_temp_30.fe_1()
	mut iife_temp_31 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_31 := iife_temp_31.fe_add(iife_result_30, var_ss.clone())
	mut var_u2 := iife_result_31
	mut iife_temp_32 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_32 := iife_temp_32.fe_sq(var_u2.clone())
	mut var_u2u2 := iife_result_32
	mut iife_temp_33 := Class_ParagonIE_Sodium_Core_Curve25519_Fe{}
	mut iife_result_33 :=
		iife_temp_33.fromarray(rt.get_static_prop('ParagonIE_Sodium_Core_Ristretto255', 'd'))
	mut iife_temp_34 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_34 := iife_temp_34.fe_mul(iife_result_33, var_u1u1.clone())
	mut var_v := iife_result_34
	mut iife_temp_35 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_35 := iife_temp_35.fe_neg(var_v.clone())
	var_v = iife_result_35
	mut iife_temp_36 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_36 := iife_temp_36.fe_sub(var_v.clone(), var_u2u2.clone())
	var_v = iife_result_36
	mut iife_temp_37 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_37 := iife_temp_37.fe_mul(var_v.clone(), var_u2u2.clone())
	mut var_v_u2u2 := iife_result_37
	mut iife_temp_38 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_38 := iife_temp_38.fe_1()
	mut var_one := iife_result_38
	mut var_result := Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_sqrt_ratio_m1(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_one), mut
		rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_v_u2u2))
	mut var_inv_sqrt := var_result.array_get(rt.new_string('x'))
	mut var_notsquare := var_result.array_get(rt.new_string('nonsquare'))
	mut var_h := create_paragonie_sodium_core_curve25519_ge_p3()
	mut iife_temp_39 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_39 := iife_temp_39.fe_mul(var_inv_sqrt.clone(), var_u2.clone())
	rt.set_property(var_h, 'X', iife_result_39)
	mut iife_temp_40 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_40 := iife_temp_40.fe_mul(var_inv_sqrt.clone(), rt.get_property(var_h, 'X'))
	mut iife_temp_41 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_41 := iife_temp_41.fe_mul(iife_result_40, var_v.clone())
	rt.set_property(var_h, 'Y', iife_result_41)
	mut iife_temp_42 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_42 := iife_temp_42.fe_mul(rt.get_property(var_h, 'X'), var_s_.clone())
	rt.set_property(var_h, 'X', iife_result_42)
	mut iife_temp_43 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_43 := iife_temp_43.fe_add(rt.get_property(var_h, 'X'),
		rt.get_property(var_h, 'X'))
	rt.set_property(var_h, 'X',
		Class_ParagonIE_Sodium_Core_Ristretto255.fe_abs(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](iife_result_43)))
	mut iife_temp_44 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_44 := iife_temp_44.fe_mul(var_u1.clone(), rt.get_property(var_h, 'Y'))
	rt.set_property(var_h, 'Y', iife_result_44)
	mut iife_temp_45 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_45 := iife_temp_45.fe_1()
	rt.set_property(var_h, 'Z', iife_result_45)
	mut iife_temp_46 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_46 := iife_temp_46.fe_mul(rt.get_property(var_h, 'X'),
		rt.get_property(var_h, 'Y'))
	rt.set_property(var_h, 'T', iife_result_46)
	mut iife_temp_47 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_47 := iife_temp_47.fe_isnegative(rt.get_property(var_h, 'T'))
	mut var_res := rt.new_int(-rt.bitwise_or(rt.bitwise_or(rt.sub(rt.new_int(1), var_notsquare),
		iife_result_47),
		Class_ParagonIE_Sodium_Core_Ristretto255.fe_iszero(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](rt.get_property(var_h, 'Y')))))
	return rt.create_array([rt.ArrayItem{ key: 'h', val: var_h },
		rt.ArrayItem{ key: 'res', val: var_res }])
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_p3_tobytes(mut var_h Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3) rt.PhpVal {
	mut var_h_mutated := var_h
	mut iife_temp_48 := Class_ParagonIE_Sodium_Core_Curve25519_Fe{}
	mut iife_result_48 := iife_temp_48.fromarray(rt.get_static_prop('ParagonIE_Sodium_Core_Ristretto255',
		'sqrtm1'))
	mut var_sqrtm1 := iife_result_48
	mut iife_temp_49 := Class_ParagonIE_Sodium_Core_Curve25519_Fe{}
	mut iife_result_49 := iife_temp_49.fromarray(rt.get_static_prop('ParagonIE_Sodium_Core_Ristretto255',
		'invsqrtamd'))
	mut var_invsqrtamd := iife_result_49
	mut iife_temp_50 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_50 := iife_temp_50.fe_add(rt.get_property(var_h_mutated, 'Z'),
		rt.get_property(var_h_mutated, 'Y'))
	mut var_u1 := iife_result_50
	mut iife_temp_51 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_51 := iife_temp_51.fe_sub(rt.get_property(var_h_mutated, 'Z'),
		rt.get_property(var_h_mutated, 'Y'))
	mut var_zmy := iife_result_51
	mut iife_temp_52 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_52 := iife_temp_52.fe_mul(var_u1.clone(), var_zmy.clone())
	var_u1 = iife_result_52
	mut iife_temp_53 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_53 := iife_temp_53.fe_mul(rt.get_property(var_h_mutated, 'X'),
		rt.get_property(var_h_mutated, 'Y'))
	mut var_u2 := iife_result_53
	mut iife_temp_54 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_54 := iife_temp_54.fe_sq(var_u2.clone())
	mut iife_temp_55 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_55 := iife_temp_55.fe_mul(iife_result_54, var_u1.clone())
	mut var_u1_u2u2 := iife_result_55
	mut iife_temp_56 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_56 := iife_temp_56.fe_1()
	mut var_one := iife_result_56
	mut var_result := Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_sqrt_ratio_m1(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_one), mut
		rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_u1_u2u2))
	mut var_inv_sqrt := var_result.array_get(rt.new_string('x'))
	mut iife_temp_57 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_57 := iife_temp_57.fe_mul(var_inv_sqrt.clone(), var_u1.clone())
	mut var_den1 := iife_result_57
	mut iife_temp_58 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_58 := iife_temp_58.fe_mul(var_inv_sqrt.clone(), var_u2.clone())
	mut var_den2 := iife_result_58
	mut iife_temp_59 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_59 := iife_temp_59.fe_mul(var_den1.clone(), var_den2.clone())
	mut iife_temp_60 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_60 := iife_temp_60.fe_mul(rt.get_property(var_h_mutated, 'T'), iife_result_59)
	mut var_z_inv := iife_result_60
	mut iife_temp_61 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_61 := iife_temp_61.fe_mul(rt.get_property(var_h_mutated, 'X'),
		var_sqrtm1.clone())
	mut var_ix := iife_result_61
	mut iife_temp_62 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_62 := iife_temp_62.fe_mul(rt.get_property(var_h_mutated, 'Y'),
		var_sqrtm1.clone())
	mut var_iy := iife_result_62
	mut iife_temp_63 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_63 := iife_temp_63.fe_mul(var_den1.clone(), var_invsqrtamd.clone())
	mut var_eden := iife_result_63
	mut iife_temp_64 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_64 := iife_temp_64.fe_mul(rt.get_property(var_h_mutated, 'T'),
		var_z_inv.clone())
	mut var_t_z_inv := iife_result_64
	mut iife_temp_65 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_65 := iife_temp_65.fe_isnegative(var_t_z_inv.clone())
	mut var_rotate := iife_result_65
	mut iife_temp_66 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_66 := iife_temp_66.fe_copy(rt.get_property(var_h_mutated, 'X'))
	mut var_x_ := iife_result_66
	mut iife_temp_67 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_67 := iife_temp_67.fe_copy(rt.get_property(var_h_mutated, 'Y'))
	mut var_y_ := iife_result_67
	mut iife_temp_68 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_68 := iife_temp_68.fe_copy(var_den2.clone())
	mut var_den_inv := iife_result_68
	mut iife_temp_69 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_69 := iife_temp_69.fe_cmov(var_x_.clone(), var_iy.clone(), var_rotate.clone())
	var_x_ = iife_result_69
	mut iife_temp_70 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_70 := iife_temp_70.fe_cmov(var_y_.clone(), var_ix.clone(), var_rotate.clone())
	var_y_ = iife_result_70
	mut iife_temp_71 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_71 := iife_temp_71.fe_cmov(var_den_inv.clone(), var_eden.clone(),
		var_rotate.clone())
	var_den_inv = iife_result_71
	mut iife_temp_72 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_72 := iife_temp_72.fe_mul(var_x_.clone(), var_z_inv.clone())
	mut var_x_z_inv := iife_result_72
	mut iife_temp_73 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_73 := iife_temp_73.fe_isnegative(var_x_z_inv.clone())
	var_y_ = Class_ParagonIE_Sodium_Core_Ristretto255.fe_cneg(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_y_),
		iife_result_73)
	mut iife_temp_74 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_74 := iife_temp_74.fe_sub(rt.get_property(var_h_mutated, 'Z'), var_y_.clone())
	mut iife_temp_75 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_75 := iife_temp_75.fe_mul(var_den_inv.clone(), iife_result_74)
	mut iife_temp_76 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_76 :=
		iife_temp_76.fe_tobytes(Class_ParagonIE_Sodium_Core_Ristretto255.fe_abs(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](iife_result_75)))
	return iife_result_76
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_elligator(mut var_t Class_ParagonIE_Sodium_Core_Curve25519_Fe) rt.PhpVal {
	mut var_t_mutated := var_t
	mut iife_temp_77 := Class_ParagonIE_Sodium_Core_Curve25519_Fe{}
	mut iife_result_77 := iife_temp_77.fromarray(rt.get_static_prop('ParagonIE_Sodium_Core_Ristretto255',
		'sqrtm1'))
	mut var_sqrtm1 := iife_result_77
	mut iife_temp_78 := Class_ParagonIE_Sodium_Core_Curve25519_Fe{}
	mut iife_result_78 := iife_temp_78.fromarray(rt.get_static_prop('ParagonIE_Sodium_Core_Ristretto255',
		'onemsqd'))
	mut var_onemsqd := iife_result_78
	mut iife_temp_79 := Class_ParagonIE_Sodium_Core_Curve25519_Fe{}
	mut iife_result_79 :=
		iife_temp_79.fromarray(rt.get_static_prop('ParagonIE_Sodium_Core_Ristretto255', 'd'))
	mut var_d := iife_result_79
	mut iife_temp_80 := Class_ParagonIE_Sodium_Core_Curve25519_Fe{}
	mut iife_result_80 := iife_temp_80.fromarray(rt.get_static_prop('ParagonIE_Sodium_Core_Ristretto255',
		'sqdmone'))
	mut var_sqdmone := iife_result_80
	mut iife_temp_81 := Class_ParagonIE_Sodium_Core_Curve25519_Fe{}
	mut iife_result_81 := iife_temp_81.fromarray(rt.get_static_prop('ParagonIE_Sodium_Core_Ristretto255',
		'sqrtadm1'))
	mut var_sqrtadm1 := iife_result_81
	mut iife_temp_82 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_82 := iife_temp_82.fe_1()
	mut var_one := iife_result_82
	mut iife_temp_83 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_83 := iife_temp_83.fe_sq(rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe',
		[]string{}, var_t_mutated))
	mut iife_temp_84 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_84 := iife_temp_84.fe_mul(var_sqrtm1.clone(), iife_result_83)
	mut var_r := iife_result_84
	mut iife_temp_85 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_85 := iife_temp_85.fe_add(var_r.clone(), var_one.clone())
	mut iife_temp_86 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_86 := iife_temp_86.fe_mul(iife_result_85, var_onemsqd.clone())
	mut var_u := iife_result_86
	mut iife_temp_87 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_87 := iife_temp_87.fe_1()
	mut iife_temp_88 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_88 := iife_temp_88.fe_neg(iife_result_87)
	mut var_c := iife_result_88
	mut iife_temp_89 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_89 := iife_temp_89.fe_add(var_r.clone(), var_d.clone())
	mut var_rpd := iife_result_89
	mut iife_temp_90 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_90 := iife_temp_90.fe_mul(var_r.clone(), var_d.clone())
	mut iife_temp_91 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_91 := iife_temp_91.fe_sub(var_c.clone(), iife_result_90)
	mut iife_temp_92 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_92 := iife_temp_92.fe_mul(iife_result_91, var_rpd.clone())
	mut var_v := iife_result_92
	mut var_result := Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_sqrt_ratio_m1(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_u), mut
		rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_v))
	mut var_s := var_result.array_get(rt.new_string('x'))
	mut var_wasnt_square := rt.sub(rt.new_int(1), var_result.array_get(rt.new_string('nonsquare')))
	mut iife_temp_93 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_93 := iife_temp_93.fe_mul(var_s.clone(), rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe',
		[]string{}, var_t_mutated))
	mut iife_temp_94 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_94 :=
		iife_temp_94.fe_neg(Class_ParagonIE_Sodium_Core_Ristretto255.fe_abs(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](iife_result_93)))
	mut var_s_prime := iife_result_94
	mut iife_temp_95 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_95 := iife_temp_95.fe_cmov(var_s.clone(), var_s_prime.clone(),
		var_wasnt_square.clone())
	var_s = iife_result_95
	mut iife_temp_96 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_96 := iife_temp_96.fe_cmov(var_c.clone(), var_r.clone(),
		var_wasnt_square.clone())
	var_c = iife_result_96
	mut iife_temp_97 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_97 := iife_temp_97.fe_sub(var_r.clone(), var_one.clone())
	mut iife_temp_98 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_98 := iife_temp_98.fe_mul(iife_result_97, var_c.clone())
	mut iife_temp_99 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_99 := iife_temp_99.fe_mul(iife_result_98, var_sqdmone.clone())
	mut iife_temp_100 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_100 := iife_temp_100.fe_sub(iife_result_99, var_v.clone())
	mut var_n := iife_result_100
	mut iife_temp_101 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_101 := iife_temp_101.fe_add(var_s.clone(), var_s.clone())
	mut iife_temp_102 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_102 := iife_temp_102.fe_mul(iife_result_101, var_v.clone())
	mut var_w0 := iife_result_102
	mut iife_temp_103 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_103 := iife_temp_103.fe_mul(var_n.clone(), var_sqrtadm1.clone())
	mut var_w1 := iife_result_103
	mut iife_temp_104 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_104 := iife_temp_104.fe_sq(var_s.clone())
	mut var_ss := iife_result_104
	mut iife_temp_105 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_105 := iife_temp_105.fe_sub(var_one.clone(), var_ss.clone())
	mut var_w2 := iife_result_105
	mut iife_temp_106 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_106 := iife_temp_106.fe_add(var_one.clone(), var_ss.clone())
	mut var_w3 := iife_result_106
	mut iife_temp_107 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_107 := iife_temp_107.fe_mul(var_w0.clone(), var_w3.clone())
	mut iife_temp_108 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_108 := iife_temp_108.fe_mul(var_w2.clone(), var_w1.clone())
	mut iife_temp_109 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_109 := iife_temp_109.fe_mul(var_w1.clone(), var_w3.clone())
	mut iife_temp_110 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_110 := iife_temp_110.fe_mul(var_w0.clone(), var_w2.clone())
	return rt.new_object('ParagonIE_Sodium_Core_Curve25519_Ge_P3', []string{}, create_paragonie_sodium_core_curve25519_ge_p3(iife_result_107,
		iife_result_108, iife_result_109, iife_result_110))
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_from_hash(var_h rt.PhpVal) rt.PhpVal {
	mut var_h_mutated := var_h
	mut iife_temp_111 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_111 := iife_temp_111.strlen(var_h_mutated.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_111, rt.new_int(64))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Hash must be 64 bytes'))))
	}
	mut iife_temp_112 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_112 := iife_temp_112.substr(var_h_mutated.clone(), rt.new_int(0),
		rt.new_int(32))
	mut iife_temp_113 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_113 := iife_temp_113.fe_frombytes(iife_result_112)
	mut var_r0 := iife_result_113
	mut iife_temp_114 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_114 := iife_temp_114.substr(var_h_mutated.clone(), rt.new_int(32),
		rt.new_int(32))
	mut iife_temp_115 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_115 := iife_temp_115.fe_frombytes(iife_result_114)
	mut var_r1 := iife_result_115
	mut var_p0 :=
		Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_elligator(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_r0))
	mut var_p1 :=
		Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_elligator(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_r1))
	mut iife_temp_116 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_116 := iife_temp_116.ge_p3_to_cached(var_p1.clone())
	mut iife_temp_117 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_117 := iife_temp_117.ge_add(var_p0.clone(), iife_result_116)
	mut var_p_p1p1 := iife_result_117
	mut iife_temp_118 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_118 := iife_temp_118.ge_p1p1_to_p3(var_p_p1p1.clone())
	return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_p3_tobytes(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3](iife_result_118))
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.is_valid_point(var_p rt.PhpVal) i64 {
	mut var_result :=
		Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_frombytes(var_p.to_bool())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_result.array_get(rt.new_string('res')),
		rt.new_int(0)))))
	{
		return 0
	}
	return 1
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_add(var_p rt.PhpVal, var_q rt.PhpVal) rt.PhpVal {
	mut var_q_mutated := var_q
	mut var_p_res :=
		Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_frombytes(var_p.to_bool())
	mut var_q_res :=
		Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_frombytes(var_q_mutated.to_bool())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_p_res.array_get(rt.new_string('res')), rt.new_int(0)))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_q_res.array_get(rt.new_string('res')), rt.new_int(0))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not add points'))))
	}
	mut var_p_p3 := var_p_res.array_get(rt.new_string('h'))
	mut var_q_p3 := var_q_res.array_get(rt.new_string('h'))
	mut iife_temp_119 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_119 := iife_temp_119.ge_p3_to_cached(var_q_p3.clone())
	mut var_q_cached := iife_result_119
	mut iife_temp_120 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_120 := iife_temp_120.ge_add(var_p_p3.clone(), var_q_cached.clone())
	mut var_r_p1p1 := iife_result_120
	mut iife_temp_121 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_121 := iife_temp_121.ge_p1p1_to_p3(var_r_p1p1.clone())
	mut var_r_p3 := iife_result_121
	return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_p3_tobytes(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3](var_r_p3))
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_sub(var_p rt.PhpVal, var_q rt.PhpVal) rt.PhpVal {
	mut var_q_mutated := var_q
	mut var_p_res :=
		Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_frombytes(var_p.to_bool())
	mut var_q_res :=
		Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_frombytes(var_q_mutated.to_bool())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_p_res.array_get(rt.new_string('res')), rt.new_int(0)))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_q_res.array_get(rt.new_string('res')), rt.new_int(0))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not add points'))))
	}
	mut var_p_p3 := var_p_res.array_get(rt.new_string('h'))
	mut var_q_p3 := var_q_res.array_get(rt.new_string('h'))
	mut iife_temp_122 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_122 := iife_temp_122.ge_p3_to_cached(var_q_p3.clone())
	mut var_q_cached := iife_result_122
	mut iife_temp_123 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_123 := iife_temp_123.ge_sub(var_p_p3.clone(), var_q_cached.clone())
	mut var_r_p1p1 := iife_result_123
	mut iife_temp_124 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_124 := iife_temp_124.ge_p1p1_to_p3(var_r_p1p1.clone())
	mut var_r_p3 := iife_result_124
	return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_p3_tobytes(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3](var_r_p3))
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.h2c_string_to_hash_sha256(var_hLen rt.PhpVal, var_ctx rt.PhpVal, var_msg rt.PhpVal) rt.PhpVal {
	mut var_ctx_mutated := var_ctx
	mut var_h := rt.call_function('array_fill', [rt.new_int(0),
		var_hLen.clone(), rt.new_int(0)])
	mut iife_temp_125 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_125 := iife_temp_125.strlen(var_ctx_mutated.clone())
	mut var_ctx_len := if !(var_ctx_mutated.clone().is_null()) {
		iife_result_125
	} else {
		rt.new_int(0)
	}
	if rt.is_true(rt.greater(var_hLen, rt.new_int(255))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Hash must be less than 256 bytes'))))
	}
	if rt.is_true(rt.greater(var_ctx_len, rt.new_int(255))) {
		mut var_st := rt.call_function('hash_init', [rt.new_string('sha256')])
		mut iife_temp_126 := Class_ParagonIE_Sodium_Core_Ristretto255{}
		mut iife_result_126 := iife_temp_126.hash_update(var_st.clone(),
			rt.new_string('H2C-OVERSIZE-DST-'))
		mut iife_temp_127 := Class_ParagonIE_Sodium_Core_Ristretto255{}
		mut iife_result_127 := iife_temp_127.hash_update(var_st.clone(), var_ctx_mutated.clone())
		var_ctx_mutated = rt.call_function('hash_final', [var_st.clone(),
			rt.new_bool(true)])
		var_ctx_len = rt.new_int(32)
	}
	mut var_t := rt.create_array([rt.ArrayItem{ key: none, val: 0 },
		rt.ArrayItem{ key: none, val: var_hLen }, rt.ArrayItem{ key: none, val: 0 }])
	mut var_ux := rt.call_function('str_repeat', [rt.new_string(''),
		rt.new_int(64)])
	var_st = rt.call_function('hash_init', [rt.new_string('sha256')])
	mut iife_temp_128 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_128 := iife_temp_128.hash_update(var_st.clone(), var_ux.clone())
	mut iife_temp_129 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_129 := iife_temp_129.hash_update(var_st.clone(), var_msg.clone())
	mut iife_temp_130 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_130 := iife_temp_130.intarraytostring(var_t.clone())
	mut iife_temp_131 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_131 := iife_temp_131.hash_update(var_st.clone(), iife_result_130)
	mut iife_temp_132 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_132 := iife_temp_132.hash_update(var_st.clone(), var_ctx_mutated.clone())
	mut iife_temp_133 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_133 := iife_temp_133.inttochr(var_ctx_len.clone())
	mut iife_temp_134 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_134 := iife_temp_134.hash_update(var_st.clone(), iife_result_133)
	mut var_u0 := rt.call_function('hash_final', [var_st.clone(),
		rt.new_bool(true)])
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, var_hLen))) { break
		 }
		mut iife_temp_135 := Class_ParagonIE_Sodium_Core_Ristretto255{}
		mut iife_result_135 := iife_temp_135.xorstrings(var_ux.clone(), var_u0.clone())
		var_ux = iife_result_135
		rt.pre_inc(var_t.array_get(rt.new_int(2)))
		var_st = rt.call_function('hash_init', [rt.new_string('sha256')])
		mut iife_temp_136 := Class_ParagonIE_Sodium_Core_Ristretto255{}
		mut iife_result_136 := iife_temp_136.hash_update(var_st.clone(), var_ux.clone())
		mut iife_temp_137 := Class_ParagonIE_Sodium_Core_Ristretto255{}
		mut iife_result_137 := iife_temp_137.inttochr(var_t.array_get(rt.new_int(2)))
		mut iife_temp_138 := Class_ParagonIE_Sodium_Core_Ristretto255{}
		mut iife_result_138 := iife_temp_138.hash_update(var_st.clone(), iife_result_137)
		mut iife_temp_139 := Class_ParagonIE_Sodium_Core_Ristretto255{}
		mut iife_result_139 := iife_temp_139.hash_update(var_st.clone(), var_ctx_mutated.clone())
		mut iife_temp_140 := Class_ParagonIE_Sodium_Core_Ristretto255{}
		mut iife_result_140 := iife_temp_140.inttochr(var_ctx_len.clone())
		mut iife_temp_141 := Class_ParagonIE_Sodium_Core_Ristretto255{}
		mut iife_result_141 := iife_temp_141.hash_update(var_st.clone(), iife_result_140)
		var_ux = rt.call_function('hash_final', [var_st.clone(),
			rt.new_bool(true)])
		mut var_amount := rt.call_function('min', [rt.sub(var_hLen, var_i),
			rt.new_int(64)])
		mut var_j := rt.new_int(0)
		for {
			if !(rt.is_true(rt.less(var_j, var_amount))) { break
			 }
			mut iife_temp_142 := Class_ParagonIE_Sodium_Core_Ristretto255{}
			mut iife_result_142 := iife_temp_142.chrtoint(var_ux.array_get(var_i))
			var_h.array_set(rt.add(var_i, var_j), iife_result_142)
			rt.pre_inc(var_j)
		}
		var_i = rt.add(var_i, rt.new_int(64))
	}
	mut iife_temp_143 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_143 := iife_temp_143.intarraytostring(rt.call_function('array_slice', [
		var_h.clone(),
		rt.new_int(0),
		var_hLen.clone(),
	]))
	return iife_result_143
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.h2c_string_to_hash_sha512(var_hLen rt.PhpVal, var_ctx rt.PhpVal, var_msg rt.PhpVal) rt.PhpVal {
	mut var_ctx_mutated := var_ctx
	mut var_h := rt.call_function('array_fill', [rt.new_int(0),
		var_hLen.clone(), rt.new_int(0)])
	mut iife_temp_144 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_144 := iife_temp_144.strlen(var_ctx_mutated.clone())
	mut var_ctx_len := if !(var_ctx_mutated.clone().is_null()) {
		iife_result_144
	} else {
		rt.new_int(0)
	}
	if rt.is_true(rt.greater(var_hLen, rt.new_int(255))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Hash must be less than 256 bytes'))))
	}
	if rt.is_true(rt.greater(var_ctx_len, rt.new_int(255))) {
		mut var_st := rt.call_function('hash_init', [rt.new_string('sha256')])
		mut iife_temp_145 := Class_ParagonIE_Sodium_Core_Ristretto255{}
		mut iife_result_145 := iife_temp_145.hash_update(var_st.clone(),
			rt.new_string('H2C-OVERSIZE-DST-'))
		mut iife_temp_146 := Class_ParagonIE_Sodium_Core_Ristretto255{}
		mut iife_result_146 := iife_temp_146.hash_update(var_st.clone(), var_ctx_mutated.clone())
		var_ctx_mutated = rt.call_function('hash_final', [var_st.clone(),
			rt.new_bool(true)])
		var_ctx_len = rt.new_int(32)
	}
	mut var_t := rt.create_array([rt.ArrayItem{ key: none, val: 0 },
		rt.ArrayItem{ key: none, val: var_hLen }, rt.ArrayItem{ key: none, val: 0 }])
	mut var_ux := rt.call_function('str_repeat', [rt.new_string(''),
		rt.new_int(128)])
	var_st = rt.call_function('hash_init', [rt.new_string('sha512')])
	mut iife_temp_147 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_147 := iife_temp_147.hash_update(var_st.clone(), var_ux.clone())
	mut iife_temp_148 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_148 := iife_temp_148.hash_update(var_st.clone(), var_msg.clone())
	mut iife_temp_149 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_149 := iife_temp_149.intarraytostring(var_t.clone())
	mut iife_temp_150 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_150 := iife_temp_150.hash_update(var_st.clone(), iife_result_149)
	mut iife_temp_151 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_151 := iife_temp_151.hash_update(var_st.clone(), var_ctx_mutated.clone())
	mut iife_temp_152 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_152 := iife_temp_152.inttochr(var_ctx_len.clone())
	mut iife_temp_153 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_153 := iife_temp_153.hash_update(var_st.clone(), iife_result_152)
	mut var_u0 := rt.call_function('hash_final', [var_st.clone(),
		rt.new_bool(true)])
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, var_hLen))) { break
		 }
		mut iife_temp_154 := Class_ParagonIE_Sodium_Core_Ristretto255{}
		mut iife_result_154 := iife_temp_154.xorstrings(var_ux.clone(), var_u0.clone())
		var_ux = iife_result_154
		rt.pre_inc(var_t.array_get(rt.new_int(2)))
		var_st = rt.call_function('hash_init', [rt.new_string('sha512')])
		mut iife_temp_155 := Class_ParagonIE_Sodium_Core_Ristretto255{}
		mut iife_result_155 := iife_temp_155.hash_update(var_st.clone(), var_ux.clone())
		mut iife_temp_156 := Class_ParagonIE_Sodium_Core_Ristretto255{}
		mut iife_result_156 := iife_temp_156.inttochr(var_t.array_get(rt.new_int(2)))
		mut iife_temp_157 := Class_ParagonIE_Sodium_Core_Ristretto255{}
		mut iife_result_157 := iife_temp_157.hash_update(var_st.clone(), iife_result_156)
		mut iife_temp_158 := Class_ParagonIE_Sodium_Core_Ristretto255{}
		mut iife_result_158 := iife_temp_158.hash_update(var_st.clone(), var_ctx_mutated.clone())
		mut iife_temp_159 := Class_ParagonIE_Sodium_Core_Ristretto255{}
		mut iife_result_159 := iife_temp_159.inttochr(var_ctx_len.clone())
		mut iife_temp_160 := Class_ParagonIE_Sodium_Core_Ristretto255{}
		mut iife_result_160 := iife_temp_160.hash_update(var_st.clone(), iife_result_159)
		var_ux = rt.call_function('hash_final', [var_st.clone(),
			rt.new_bool(true)])
		mut var_amount := rt.call_function('min', [rt.sub(var_hLen, var_i),
			rt.new_int(128)])
		mut var_j := rt.new_int(0)
		for {
			if !(rt.is_true(rt.less(var_j, var_amount))) { break
			 }
			mut iife_temp_161 := Class_ParagonIE_Sodium_Core_Ristretto255{}
			mut iife_result_161 := iife_temp_161.chrtoint(var_ux.array_get(var_i))
			var_h.array_set(rt.add(var_i, var_j), iife_result_161)
			rt.pre_inc(var_j)
		}
		var_i = rt.add(var_i, rt.new_int(128))
	}
	mut iife_temp_162 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_162 := iife_temp_162.intarraytostring(rt.call_function('array_slice', [
		var_h.clone(),
		rt.new_int(0),
		var_hLen.clone(),
	]))
	return iife_result_162
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.h2c_string_to_hash(var_hLen rt.PhpVal, var_ctx rt.PhpVal, var_msg rt.PhpVal, var_hash_alg rt.PhpVal) rt.PhpVal {
	mut var_ctx_mutated := var_ctx
	mut switch_val_1 := var_hash_alg
	if rt.is_true(rt.equal(switch_val_1, Class_ParagonIE_Sodium_Core_Ristretto255.core_h2c_sha256())) {
		return Class_ParagonIE_Sodium_Core_Ristretto255.h2c_string_to_hash_sha256(var_hLen.clone(),
			var_ctx_mutated.clone(), var_msg.clone())
	} else if rt.is_true(rt.equal(switch_val_1,
		Class_ParagonIE_Sodium_Core_Ristretto255.core_h2c_sha512()))
	{
		return Class_ParagonIE_Sodium_Core_Ristretto255.h2c_string_to_hash_sha512(var_hLen.clone(),
			var_ctx_mutated.clone(), var_msg.clone())
	} else {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Invalid H2C hash algorithm'))))
	}
	return rt.new_null()
}

fn Class_ParagonIE_Sodium_Core_Ristretto255._string_to_element(var_ctx rt.PhpVal, var_msg rt.PhpVal, var_hash_alg rt.PhpVal) rt.PhpVal {
	mut var_ctx_mutated := var_ctx
	return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_from_hash(Class_ParagonIE_Sodium_Core_Ristretto255.h2c_string_to_hash(rt.new_int(Class_ParagonIE_Sodium_Core_Ristretto255.crypto_core_ristretto255_hashbytes()),
		var_ctx_mutated.clone(), var_msg.clone(), var_hash_alg.clone()))
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_random() rt.PhpVal {
	mut iife_temp_163 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_163 :=
		iife_temp_163.randombytes_buf(rt.new_int(Class_ParagonIE_Sodium_Core_Ristretto255.crypto_core_ristretto255_hashbytes()))
	return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_from_hash(iife_result_163)
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_random() rt.PhpVal {
	mut iife_temp_164 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_164 := iife_temp_164.scalar_random()
	return iife_result_164
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_complement(var_s rt.PhpVal) rt.PhpVal {
	mut var_s_mutated := var_s
	mut iife_temp_165 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_165 := iife_temp_165.scalar_complement(var_s_mutated.clone())
	return iife_result_165
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_invert(var_s rt.PhpVal) rt.PhpVal {
	mut var_s_mutated := var_s
	mut iife_temp_166 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_166 := iife_temp_166.sc25519_invert(var_s_mutated.clone())
	return iife_result_166
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_negate(var_s rt.PhpVal) rt.PhpVal {
	mut var_s_mutated := var_s
	mut iife_temp_167 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_167 := iife_temp_167.scalar_negate(var_s_mutated.clone())
	return iife_result_167
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_add(var_x rt.PhpVal, var_y rt.PhpVal) rt.PhpVal {
	mut var_x_mutated := var_x
	mut iife_temp_168 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_168 := iife_temp_168.scalar_add(var_x_mutated.clone(), var_y.clone())
	return iife_result_168
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_sub(var_x rt.PhpVal, var_y rt.PhpVal) rt.PhpVal {
	mut var_x_mutated := var_x
	mut iife_temp_169 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_169 := iife_temp_169.scalar_sub(var_x_mutated.clone(), var_y.clone())
	return iife_result_169
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_mul(var_x rt.PhpVal, var_y rt.PhpVal) rt.PhpVal {
	mut var_x_mutated := var_x
	mut iife_temp_170 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_170 := iife_temp_170.sc25519_mul(var_x_mutated.clone(), var_y.clone())
	return iife_result_170
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_from_string(var_ctx rt.PhpVal, var_msg rt.PhpVal, var_hash_alg rt.PhpVal) rt.PhpVal {
	mut var_ctx_mutated := var_ctx
	mut var_h := rt.call_function('array_fill', [rt.new_int(0),
		rt.new_int(64), rt.new_int(0)])
	mut iife_temp_171 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_171 := iife_temp_171.stringtointarray(Class_ParagonIE_Sodium_Core_Ristretto255.h2c_string_to_hash(rt.new_int(Class_ParagonIE_Sodium_Core_Ristretto255.hash_sc_l()),
		var_ctx_mutated.clone(), var_msg.clone(), var_hash_alg.clone()))
	mut var_h_be := iife_result_171
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, Class_ParagonIE_Sodium_Core_Ristretto255.hash_sc_l()))) { break
		 }
		var_h.array_set(var_i, var_h_be.array_get(rt.sub(Class_ParagonIE_Sodium_Core_Ristretto255.hash_sc_l() - 1,
			var_i)))
		rt.pre_inc(var_i)
	}
	mut iife_temp_172 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_172 := iife_temp_172.intarraytostring(var_h.clone())
	return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_reduce(iife_result_172)
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_reduce(var_s rt.PhpVal) rt.PhpVal {
	mut var_s_mutated := var_s
	mut iife_temp_173 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_173 := iife_temp_173.sc_reduce(var_s_mutated.clone())
	return iife_result_173
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.scalarmult_ristretto255(var_n rt.PhpVal, var_p rt.PhpVal) rt.PhpVal {
	mut var_n_mutated := var_n
	mut iife_temp_174 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_174 := iife_temp_174.strlen(var_n_mutated.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_174, rt.new_int(32))))) {
		mut iife_temp_175 := Class_ParagonIE_Sodium_Core_Ristretto255{}
		mut iife_result_175 := iife_temp_175.strlen(var_p.clone())
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(
			'Scalar must be 32 bytes, ' + iife_result_175.str() + ' given.')))
	}
	mut iife_temp_176 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_176 := iife_temp_176.strlen(var_p.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_176, rt.new_int(32))))) {
		mut iife_temp_177 := Class_ParagonIE_Sodium_Core_Ristretto255{}
		mut iife_result_177 := iife_temp_177.strlen(var_p.clone())
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(
			'Point must be 32 bytes, ' + iife_result_177.str() + ' given.')))
	}
	mut var_result :=
		Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_frombytes(var_p.to_bool())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_result.array_get(rt.new_string('res')),
		rt.new_int(0)))))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not multiply points'))))
	}
	mut var_P := var_result.array_get(rt.new_string('h'))
	mut iife_temp_178 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_178 := iife_temp_178.stringtointarray(var_n_mutated.clone())
	mut var_t := iife_result_178
	rt.new_null()
	mut iife_temp_179 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_179 := iife_temp_179.intarraytostring(var_t.clone())
	mut iife_temp_180 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_180 := iife_temp_180.ge_scalarmult(iife_result_179, var_P.clone())
	mut var_Q := iife_result_180
	mut var_q :=
		Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_p3_tobytes(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3](var_Q))
	mut iife_temp_181 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_181 := iife_temp_181.is_zero(var_q.clone())
	if rt.is_true(iife_result_181) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('An unknown error has occurred'))))
	}
	return var_q.clone()
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.scalarmult_ristretto255_base(var_n rt.PhpVal) rt.PhpVal {
	mut var_n_mutated := var_n
	mut iife_temp_182 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_182 := iife_temp_182.stringtointarray(var_n_mutated.clone())
	mut var_t := iife_result_182
	rt.new_null()
	mut iife_temp_183 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_183 := iife_temp_183.intarraytostring(var_t.clone())
	mut iife_temp_184 := Class_ParagonIE_Sodium_Core_Ristretto255{}
	mut iife_result_184 := iife_temp_184.ge_scalarmult_base(iife_result_183)
	mut var_Q := iife_result_184
	mut var_q :=
		Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_p3_tobytes(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3](var_Q))
	mut iife_temp_185 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_185 := iife_temp_185.is_zero(var_q.clone())
	if rt.is_true(iife_result_185) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('An unknown error has occurred'))))
	}
	return var_q.clone()
}

struct Class_ParagonIE_Sodium_Core_Ed25519 {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core_Curve25519_Fe {
	rt.PhpObjectBase
}

struct Class_SodiumException {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3 {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Compat {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_ristretto255(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_Ristretto255 {
	mut obj := &Class_ParagonIE_Sodium_Core_Ristretto255{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_ed25519(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_Ed25519 {
	mut obj := &Class_ParagonIE_Sodium_Core_Ed25519{
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

fn create_sodiumexception(_args ...rt.PhpVal) &Class_SodiumException {
	mut obj := &Class_SodiumException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_curve25519_ge_p3(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3 {
	mut obj := &Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3{
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

fn (mut this Class_ParagonIE_Sodium_Core_Ristretto255) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'fe_cneg' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.fe_cneg(mut dispatch_arg_0,
				dispatch_arg_1)
		}
		'fe_abs' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_ParagonIE_Sodium_Core_Ristretto255.fe_abs(mut dispatch_arg_0)
		}
		'fe_iszero' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_int(Class_ParagonIE_Sodium_Core_Ristretto255.fe_iszero(mut dispatch_arg_0))
		}
		'ristretto255_sqrt_ratio_m1' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_sqrt_ratio_m1(mut dispatch_arg_0, mut
				dispatch_arg_1)
		}
		'ristretto255_point_is_canonical' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_point_is_canonical(dispatch_arg_0))
		}
		'ristretto255_frombytes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_frombytes(dispatch_arg_0,
				dispatch_arg_1)
		}
		'ristretto255_p3_tobytes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_p3_tobytes(mut dispatch_arg_0)
		}
		'ristretto255_elligator' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_elligator(mut dispatch_arg_0)
		}
		'ristretto255_from_hash' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_from_hash(dispatch_arg_0)
		}
		'is_valid_point' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(Class_ParagonIE_Sodium_Core_Ristretto255.is_valid_point(dispatch_arg_0))
		}
		'ristretto255_add' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_add(dispatch_arg_0,
				dispatch_arg_1)
		}
		'ristretto255_sub' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_sub(dispatch_arg_0,
				dispatch_arg_1)
		}
		'h2c_string_to_hash_sha256' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.h2c_string_to_hash_sha256(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'h2c_string_to_hash_sha512' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.h2c_string_to_hash_sha512(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'h2c_string_to_hash' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.h2c_string_to_hash(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'_string_to_element' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255._string_to_element(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'ristretto255_random' {
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_random()
		}
		'ristretto255_scalar_random' {
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_random()
		}
		'ristretto255_scalar_complement' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_complement(dispatch_arg_0)
		}
		'ristretto255_scalar_invert' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_invert(dispatch_arg_0)
		}
		'ristretto255_scalar_negate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_negate(dispatch_arg_0)
		}
		'ristretto255_scalar_add' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_add(dispatch_arg_0,
				dispatch_arg_1)
		}
		'ristretto255_scalar_sub' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_sub(dispatch_arg_0,
				dispatch_arg_1)
		}
		'ristretto255_scalar_mul' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_mul(dispatch_arg_0,
				dispatch_arg_1)
		}
		'ristretto255_scalar_from_string' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_from_string(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'ristretto255_scalar_reduce' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_reduce(dispatch_arg_0)
		}
		'scalarmult_ristretto255' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.scalarmult_ristretto255(dispatch_arg_0,
				dispatch_arg_1)
		}
		'scalarmult_ristretto255_base' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.scalarmult_ristretto255_base(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_ParagonIE_Sodium_Core_Ristretto255) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Ristretto255) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core_Ed25519) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_Ed25519) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Ed25519) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_SodiumException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SodiumException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SodiumException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
}
