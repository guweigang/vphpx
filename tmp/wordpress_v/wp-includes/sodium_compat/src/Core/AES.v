import rt

struct Class_ParagonIE_Sodium_Core_AES {
	rt.PhpObjectBase
pub mut:
		Rcon rt.PhpVal = rt.new_array()
}

fn Class_ParagonIE_Sodium_Core_AES.sbox(mut var_q Class_ParagonIE_Sodium_Core_AES_Block)  {
	mut var_q_mutated := var_q
	mut var_x0 := rt.new_int(rt.bitwise_and(var_q_mutated.array_get(7), Class_ParagonIE_Sodium_Core_AES.u32_max()))
	mut var_x1 := rt.new_int(rt.bitwise_and(var_q_mutated.array_get(6), Class_ParagonIE_Sodium_Core_AES.u32_max()))
	mut var_x2 := rt.new_int(rt.bitwise_and(var_q_mutated.array_get(5), Class_ParagonIE_Sodium_Core_AES.u32_max()))
	mut var_x3 := rt.new_int(rt.bitwise_and(var_q_mutated.array_get(4), Class_ParagonIE_Sodium_Core_AES.u32_max()))
	mut var_x4 := rt.new_int(rt.bitwise_and(var_q_mutated.array_get(3), Class_ParagonIE_Sodium_Core_AES.u32_max()))
	mut var_x5 := rt.new_int(rt.bitwise_and(var_q_mutated.array_get(2), Class_ParagonIE_Sodium_Core_AES.u32_max()))
	mut var_x6 := rt.new_int(rt.bitwise_and(var_q_mutated.array_get(1), Class_ParagonIE_Sodium_Core_AES.u32_max()))
	mut var_x7 := rt.new_int(rt.bitwise_and(var_q_mutated.array_get(0), Class_ParagonIE_Sodium_Core_AES.u32_max()))
	mut var_y14 := rt.new_int(rt.bitwise_xor(var_x3, var_x5))
	mut var_y13 := rt.new_int(rt.bitwise_xor(var_x0, var_x6))
	mut var_y9 := rt.new_int(rt.bitwise_xor(var_x0, var_x3))
	mut var_y8 := rt.new_int(rt.bitwise_xor(var_x0, var_x5))
	mut var_t0 := rt.new_int(rt.bitwise_xor(var_x1, var_x2))
	mut var_y1 := rt.new_int(rt.bitwise_xor(var_t0, var_x7))
	mut var_y4 := rt.new_int(rt.bitwise_xor(var_y1, var_x3))
	mut var_y12 := rt.new_int(rt.bitwise_xor(var_y13, var_y14))
	mut var_y2 := rt.new_int(rt.bitwise_xor(var_y1, var_x0))
	mut var_y5 := rt.new_int(rt.bitwise_xor(var_y1, var_x6))
	mut var_y3 := rt.new_int(rt.bitwise_xor(var_y5, var_y8))
	mut var_t1 := rt.new_int(rt.bitwise_xor(var_x4, var_y12))
	mut var_y15 := rt.new_int(rt.bitwise_xor(var_t1, var_x5))
	mut var_y20 := rt.new_int(rt.bitwise_xor(var_t1, var_x1))
	mut var_y6 := rt.new_int(rt.bitwise_xor(var_y15, var_x7))
	mut var_y10 := rt.new_int(rt.bitwise_xor(var_y15, var_t0))
	mut var_y11 := rt.new_int(rt.bitwise_xor(var_y20, var_y9))
	mut var_y7 := rt.new_int(rt.bitwise_xor(var_x7, var_y11))
	mut var_y17 := rt.new_int(rt.bitwise_xor(var_y10, var_y11))
	mut var_y19 := rt.new_int(rt.bitwise_xor(var_y10, var_y8))
	mut var_y16 := rt.new_int(rt.bitwise_xor(var_t0, var_y11))
	mut var_y21 := rt.new_int(rt.bitwise_xor(var_y13, var_y16))
	mut var_y18 := rt.new_int(rt.bitwise_xor(var_x0, var_y16))
	mut var_t2 := rt.new_int(rt.bitwise_and(var_y12, var_y15))
	mut var_t3 := rt.new_int(rt.bitwise_and(var_y3, var_y6))
	mut var_t4 := rt.new_int(rt.bitwise_xor(var_t3, var_t2))
	mut var_t5 := rt.new_int(rt.bitwise_and(var_y4, var_x7))
	mut var_t6 := rt.new_int(rt.bitwise_xor(var_t5, var_t2))
	mut var_t7 := rt.new_int(rt.bitwise_and(var_y13, var_y16))
	mut var_t8 := rt.new_int(rt.bitwise_and(var_y5, var_y1))
	mut var_t9 := rt.new_int(rt.bitwise_xor(var_t8, var_t7))
	mut var_t10 := rt.new_int(rt.bitwise_and(var_y2, var_y7))
	mut var_t11 := rt.new_int(rt.bitwise_xor(var_t10, var_t7))
	mut var_t12 := rt.new_int(rt.bitwise_and(var_y9, var_y11))
	mut var_t13 := rt.new_int(rt.bitwise_and(var_y14, var_y17))
	mut var_t14 := rt.new_int(rt.bitwise_xor(var_t13, var_t12))
	mut var_t15 := rt.new_int(rt.bitwise_and(var_y8, var_y10))
	mut var_t16 := rt.new_int(rt.bitwise_xor(var_t15, var_t12))
	mut var_t17 := rt.new_int(rt.bitwise_xor(var_t4, var_t14))
	mut var_t18 := rt.new_int(rt.bitwise_xor(var_t6, var_t16))
	mut var_t19 := rt.new_int(rt.bitwise_xor(var_t9, var_t14))
	mut var_t20 := rt.new_int(rt.bitwise_xor(var_t11, var_t16))
	mut var_t21 := rt.new_int(rt.bitwise_xor(var_t17, var_y20))
	mut var_t22 := rt.new_int(rt.bitwise_xor(var_t18, var_y19))
	mut var_t23 := rt.new_int(rt.bitwise_xor(var_t19, var_y21))
	mut var_t24 := rt.new_int(rt.bitwise_xor(var_t20, var_y18))
	mut var_t25 := rt.new_int(rt.bitwise_xor(var_t21, var_t22))
	mut var_t26 := rt.new_int(rt.bitwise_and(var_t21, var_t23))
	mut var_t27 := rt.new_int(rt.bitwise_xor(var_t24, var_t26))
	mut var_t28 := rt.new_int(rt.bitwise_and(var_t25, var_t27))
	mut var_t29 := rt.new_int(rt.bitwise_xor(var_t28, var_t22))
	mut var_t30 := rt.new_int(rt.bitwise_xor(var_t23, var_t24))
	mut var_t31 := rt.new_int(rt.bitwise_xor(var_t22, var_t26))
	mut var_t32 := rt.new_int(rt.bitwise_and(var_t31, var_t30))
	mut var_t33 := rt.new_int(rt.bitwise_xor(var_t32, var_t24))
	mut var_t34 := rt.new_int(rt.bitwise_xor(var_t23, var_t33))
	mut var_t35 := rt.new_int(rt.bitwise_xor(var_t27, var_t33))
	mut var_t36 := rt.new_int(rt.bitwise_and(var_t24, var_t35))
	mut var_t37 := rt.new_int(rt.bitwise_xor(var_t36, var_t34))
	mut var_t38 := rt.new_int(rt.bitwise_xor(var_t27, var_t36))
	mut var_t39 := rt.new_int(rt.bitwise_and(var_t29, var_t38))
	mut var_t40 := rt.new_int(rt.bitwise_xor(var_t25, var_t39))
	mut var_t41 := rt.new_int(rt.bitwise_xor(var_t40, var_t37))
	mut var_t42 := rt.new_int(rt.bitwise_xor(var_t29, var_t33))
	mut var_t43 := rt.new_int(rt.bitwise_xor(var_t29, var_t40))
	mut var_t44 := rt.new_int(rt.bitwise_xor(var_t33, var_t37))
	mut var_t45 := rt.new_int(rt.bitwise_xor(var_t42, var_t41))
	mut var_z0 := rt.new_int(rt.bitwise_and(var_t44, var_y15))
	mut var_z1 := rt.new_int(rt.bitwise_and(var_t37, var_y6))
	mut var_z2 := rt.new_int(rt.bitwise_and(var_t33, var_x7))
	mut var_z3 := rt.new_int(rt.bitwise_and(var_t43, var_y16))
	mut var_z4 := rt.new_int(rt.bitwise_and(var_t40, var_y1))
	mut var_z5 := rt.new_int(rt.bitwise_and(var_t29, var_y7))
	mut var_z6 := rt.new_int(rt.bitwise_and(var_t42, var_y11))
	mut var_z7 := rt.new_int(rt.bitwise_and(var_t45, var_y17))
	mut var_z8 := rt.new_int(rt.bitwise_and(var_t41, var_y10))
	mut var_z9 := rt.new_int(rt.bitwise_and(var_t44, var_y12))
	mut var_z10 := rt.new_int(rt.bitwise_and(var_t37, var_y3))
	mut var_z11 := rt.new_int(rt.bitwise_and(var_t33, var_y4))
	mut var_z12 := rt.new_int(rt.bitwise_and(var_t43, var_y13))
	mut var_z13 := rt.new_int(rt.bitwise_and(var_t40, var_y5))
	mut var_z14 := rt.new_int(rt.bitwise_and(var_t29, var_y2))
	mut var_z15 := rt.new_int(rt.bitwise_and(var_t42, var_y9))
	mut var_z16 := rt.new_int(rt.bitwise_and(var_t45, var_y14))
	mut var_z17 := rt.new_int(rt.bitwise_and(var_t41, var_y8))
	mut var_t46 := rt.new_int(rt.bitwise_xor(var_z15, var_z16))
	mut var_t47 := rt.new_int(rt.bitwise_xor(var_z10, var_z11))
	mut var_t48 := rt.new_int(rt.bitwise_xor(, ))
	mut var_t49 := rt.new_int()
	
}

fn Class_ParagonIE_Sodium_Core_AES.invsbox(mut var_q Class_ParagonIE_Sodium_Core_AES_Block)  {
	mut var_q_mutated := var_q
}

fn Class_ParagonIE_Sodium_Core_AES.processinversion(mut var_q Class_ParagonIE_Sodium_Core_AES_Block)  {
	mut var_q_mutated := var_q
}

fn Class_ParagonIE_Sodium_Core_AES.subword(var_x rt.PhpVal) i64 {
}

fn Class_ParagonIE_Sodium_Core_AES.keyschedule(var_key rt.PhpVal) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core_AES.addroundkey(mut var_q Class_ParagonIE_Sodium_Core_AES_Block, mut var_skey Class_ParagonIE_Sodium_Core_AES_KeySchedule, offset i64)  {
	mut var_q_mutated := var_q
	mut var_skey_mutated := var_skey
}

fn Class_ParagonIE_Sodium_Core_AES.decryptblockecb(var_message rt.PhpVal, var_key rt.PhpVal) string {
}

fn Class_ParagonIE_Sodium_Core_AES.encryptblockecb(var_message rt.PhpVal, var_key rt.PhpVal) string {
}

fn Class_ParagonIE_Sodium_Core_AES.bitsliceencryptblock(mut var_skey Class_ParagonIE_Sodium_Core_AES_Expanded, mut var_q Class_ParagonIE_Sodium_Core_AES_Block)  {
	mut var_skey_mutated := var_skey
	mut var_q_mutated := var_q
}

fn Class_ParagonIE_Sodium_Core_AES.aesround(var_x rt.PhpVal, var_y rt.PhpVal) string {
}

fn Class_ParagonIE_Sodium_Core_AES.doubleround(var_b0 rt.PhpVal, var_rk0 rt.PhpVal, var_b1 rt.PhpVal, var_rk1 rt.PhpVal) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core_AES.bitslicedecryptblock(mut var_skey Class_ParagonIE_Sodium_Core_AES_Expanded, mut var_q Class_ParagonIE_Sodium_Core_AES_Block)  {
	mut var_skey_mutated := var_skey
	mut var_q_mutated := var_q
}

struct Class_ParagonIE_Sodium_Core_Util {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_aes() &Class_ParagonIE_Sodium_Core_AES {
	mut obj := &Class_ParagonIE_Sodium_Core_AES{
		PhpObjectBase: rt.PhpObjectBase{}
		Rcon: rt.new_array()
	}
	return obj
}

fn create_paragonie_sodium_core_util() &Class_ParagonIE_Sodium_Core_Util {
	mut obj := &Class_ParagonIE_Sodium_Core_Util{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_AES) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'sbox' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_AES_Block](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_ParagonIE_Sodium_Core_AES.sbox(mut dispatch_arg_0)
			return rt.new_null()
		}
		'invSbox' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_AES_Block](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_ParagonIE_Sodium_Core_AES.invsbox(mut dispatch_arg_0)
			return rt.new_null()
		}
		'processInversion' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_AES_Block](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_ParagonIE_Sodium_Core_AES.processinversion(mut dispatch_arg_0)
			return rt.new_null()
		}
		'subWord' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(Class_ParagonIE_Sodium_Core_AES.subword(dispatch_arg_0))
		}
		'keySchedule' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_AES.keyschedule(dispatch_arg_0)
		}
		'addRoundKey' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_AES_Block](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_AES_KeySchedule](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			Class_ParagonIE_Sodium_Core_AES.addroundkey(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'decryptBlockECB' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_ParagonIE_Sodium_Core_AES.decryptblockecb(dispatch_arg_0, dispatch_arg_1))
		}
		'encryptBlockECB' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_ParagonIE_Sodium_Core_AES.encryptblockecb(dispatch_arg_0, dispatch_arg_1))
		}
		'bitsliceEncryptBlock' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_AES_Expanded](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_AES_Block](if args.len > 1 { args[1] } else { rt.new_null() })
			Class_ParagonIE_Sodium_Core_AES.bitsliceencryptblock(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'aesRound' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_ParagonIE_Sodium_Core_AES.aesround(dispatch_arg_0, dispatch_arg_1))
		}
		'doubleRound' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_AES.doubleround(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'bitsliceDecryptBlock' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_AES_Expanded](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_AES_Block](if args.len > 1 { args[1] } else { rt.new_null() })
			Class_ParagonIE_Sodium_Core_AES.bitslicedecryptblock(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_ParagonIE_Sodium_Core_AES) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'Rcon' { return this.Rcon }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ParagonIE_Sodium_Core_AES) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'Rcon' { this.Rcon = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_ParagonIE_Sodium_Core_Util) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_Util) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Util) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_sodium_compat_src_core_aes_php() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_Core_AES'), rt.new_bool(false)])) {
		return rt.new_null()
	}
}
