import rt

struct Class_ParagonIE_Sodium_Core_ChaCha20 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core_ChaCha20.rotate(var_v rt.PhpVal, var_n rt.PhpVal) rt.PhpVal {
	// unsupported expression: Expr_AssignOp_BitwiseAnd
	// unsupported expression: Expr_AssignOp_BitwiseAnd
	return // unsupported expression: Expr_Cast_Int
}

fn Class_ParagonIE_Sodium_Core_ChaCha20.quarterround(var_a rt.PhpVal, var_b rt.PhpVal, var_c rt.PhpVal, var_d rt.PhpVal) rt.PhpVal {
	mut var_a_mutated := var_a
	mut var_b_mutated := var_b
	mut var_c_mutated := var_c
	mut var_d_mutated := var_d
	var_a_mutated = rt.new_int(rt.bitwise_and(rt.add(var_a_mutated, var_b_mutated), rt.new_int(4294967295)))
	var_d_mutated = Class_ParagonIE_Sodium_Core_ChaCha20.rotate(rt.new_int(rt.bitwise_xor(var_d_mutated, var_a_mutated)), rt.new_int(16))
	var_c_mutated = rt.new_int(rt.bitwise_and(rt.add(var_c_mutated, var_d_mutated), rt.new_int(4294967295)))
	var_b_mutated = Class_ParagonIE_Sodium_Core_ChaCha20.rotate(rt.new_int(rt.bitwise_xor(var_b_mutated, var_c_mutated)), rt.new_int(12))
	var_a_mutated = rt.new_int(rt.bitwise_and(rt.add(var_a_mutated, var_b_mutated), rt.new_int(4294967295)))
	var_d_mutated = Class_ParagonIE_Sodium_Core_ChaCha20.rotate(rt.new_int(rt.bitwise_xor(var_d_mutated, var_a_mutated)), rt.new_int(8))
	var_c_mutated = rt.new_int(rt.bitwise_and(rt.add(var_c_mutated, var_d_mutated), rt.new_int(4294967295)))
	var_b_mutated = Class_ParagonIE_Sodium_Core_ChaCha20.rotate(rt.new_int(rt.bitwise_xor(var_b_mutated, var_c_mutated)), rt.new_int(7))
	return rt.create_array([rt.ArrayItem{ key: none, val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: none, val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: none, val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: none, val: // unsupported expression: Expr_Cast_Int }])
}

fn Class_ParagonIE_Sodium_Core_ChaCha20.encryptbytes(mut var_ctx Class_ParagonIE_Sodium_Core_ChaCha20_Ctx, message string) rt.PhpVal {
	mut var_ctx_mutated := var_ctx
	mut message_mutated := message
	mut var_bytes := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20{}; return temp.strlen(arg_0) }(rt.new_string(message_mutated))
	mut var_j0 := // unsupported expression: Expr_Cast_Int
	mut var_j1 := // unsupported expression: Expr_Cast_Int
	mut var_j2 := // unsupported expression: Expr_Cast_Int
	mut var_j3 := // unsupported expression: Expr_Cast_Int
	mut var_j4 := // unsupported expression: Expr_Cast_Int
	mut var_j5 := // unsupported expression: Expr_Cast_Int
	mut var_j6 := // unsupported expression: Expr_Cast_Int
	mut var_j7 := // unsupported expression: Expr_Cast_Int
	mut var_j8 := // unsupported expression: Expr_Cast_Int
	mut var_j9 := // unsupported expression: Expr_Cast_Int
	mut var_j10 := // unsupported expression: Expr_Cast_Int
	mut var_j11 := // unsupported expression: Expr_Cast_Int
	mut var_j12 := // unsupported expression: Expr_Cast_Int
	mut var_j13 := // unsupported expression: Expr_Cast_Int
	mut var_j14 := // unsupported expression: Expr_Cast_Int
	mut var_j15 := // unsupported expression: Expr_Cast_Int
	mut var_c := rt.new_string(rt.new_string(''))
	{
		for {
			if rt.is_true(rt.less(var_bytes, rt.new_int(64))) {
				// unsupported expression: Expr_AssignOp_Concat
			}
			mut var_x0 := // unsupported expression: Expr_Cast_Int
			mut var_x1 := // unsupported expression: Expr_Cast_Int
			mut var_x2 := // unsupported expression: Expr_Cast_Int
			mut var_x3 := // unsupported expression: Expr_Cast_Int
			mut var_x4 := // unsupported expression: Expr_Cast_Int
			mut var_x5 := // unsupported expression: Expr_Cast_Int
			mut var_x6 := // unsupported expression: Expr_Cast_Int
			mut var_x7 := // unsupported expression: Expr_Cast_Int
			mut var_x8 := // unsupported expression: Expr_Cast_Int
			mut var_x9 := // unsupported expression: Expr_Cast_Int
			mut var_x10 := // unsupported expression: Expr_Cast_Int
			mut var_x11 := // unsupported expression: Expr_Cast_Int
			mut var_x12 := // unsupported expression: Expr_Cast_Int
			mut var_x13 := // unsupported expression: Expr_Cast_Int
			mut var_x14 := // unsupported expression: Expr_Cast_Int
			mut var_x15 := // unsupported expression: Expr_Cast_Int
			{
				mut var_i := rt.new_int(rt.new_int(20))
				for {
					if !(rt.is_true(rt.greater(var_i, rt.new_int(0)))) { break }
					// unsupported assign target: Expr_List
					// unsupported assign target: Expr_List
					// unsupported assign target: Expr_List
					// unsupported assign target: Expr_List
					// unsupported assign target: Expr_List
					// unsupported assign target: Expr_List
					// unsupported assign target: Expr_List
					// unsupported assign target: Expr_List
					// unsupported expression: Expr_AssignOp_Minus
				}
			}
			var_x0 = rt.add(rt.bitwise_and(var_x0, rt.new_int(4294967295)), var_j0)
			var_x1 = rt.add(rt.bitwise_and(var_x1, rt.new_int(4294967295)), var_j1)
			var_x2 = rt.add(rt.bitwise_and(var_x2, rt.new_int(4294967295)), var_j2)
			var_x3 = rt.add(rt.bitwise_and(var_x3, rt.new_int(4294967295)), var_j3)
			var_x4 = rt.add(rt.bitwise_and(var_x4, rt.new_int(4294967295)), var_j4)
			var_x5 = rt.add(rt.bitwise_and(var_x5, rt.new_int(4294967295)), var_j5)
			var_x6 = rt.add(rt.bitwise_and(var_x6, rt.new_int(4294967295)), var_j6)
			var_x7 = rt.add(rt.bitwise_and(var_x7, rt.new_int(4294967295)), var_j7)
			var_x8 = rt.add(rt.bitwise_and(var_x8, rt.new_int(4294967295)), var_j8)
			var_x9 = rt.add(rt.bitwise_and(var_x9, rt.new_int(4294967295)), var_j9)
			var_x10 = rt.add(rt.bitwise_and(var_x10, rt.new_int(4294967295)), var_j10)
			var_x11 = rt.add(rt.bitwise_and(var_x11, rt.new_int(4294967295)), var_j11)
			var_x12 = rt.add(rt.bitwise_and(var_x12, rt.new_int(4294967295)), var_j12)
			var_x13 = rt.add(rt.bitwise_and(var_x13, rt.new_int(4294967295)), var_j13)
			var_x14 = rt.add(rt.bitwise_and(var_x14, rt.new_int(4294967295)), var_j14)
			var_x15 = rt.add(rt.bitwise_and(var_x15, rt.new_int(4294967295)), var_j15)
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			rt.pre_inc(var_j12)
			if rt.is_true(rt.bitwise_and(var_j12, rt.new_int(4026531840))) {
				rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Overflow'))))
			}
			mut var_block := rt.new_string( + ().str() + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20{}; return temp.store32_le(arg_0) }()).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20{}; return temp.store32_le(arg_0) }(// unsupported expression: Expr_Cast_Int)).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20{}; return temp.store32_le(arg_0) }(// unsupported expression: Expr_Cast_Int)).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_ChaCha20{}; return temp.store32_le(arg_0) }(// unsupported expression: Expr_Cast_Int)).str())
			if rt.is_true(rt.less(var_bytes, rt.new_int(64))) {
				// unsupported expression: Expr_AssignOp_Concat
				break
			}
			// unsupported expression: Expr_AssignOp_Concat
			// unsupported expression: Expr_AssignOp_Minus
			if rt.is_true(rt.less_equal(, )) {
				break
			}
			
		}
	}
}

fn Class_ParagonIE_Sodium_Core_ChaCha20.stream(var_len rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core_ChaCha20.ietfstream(var_len rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core_ChaCha20.ietfstreamxoric(var_message rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal, ic string) rt.PhpVal {
	mut var_message_mutated := var_message
}

fn Class_ParagonIE_Sodium_Core_ChaCha20.streamxoric(var_message rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal, ic string) rt.PhpVal {
	mut var_message_mutated := var_message
}

struct Class_ParagonIE_Sodium_Core_Util {
	rt.PhpObjectBase
}

struct Class_SodiumException {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_chacha20() &Class_ParagonIE_Sodium_Core_ChaCha20 {
	mut obj := &Class_ParagonIE_Sodium_Core_ChaCha20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_util() &Class_ParagonIE_Sodium_Core_Util {
	mut obj := &Class_ParagonIE_Sodium_Core_Util{
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

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'rotate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_ChaCha20.rotate(dispatch_arg_0, dispatch_arg_1)
		}
		'quarterRound' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_ChaCha20.quarterround(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'encryptBytes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_ChaCha20_Ctx](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Core_ChaCha20.encryptbytes(mut dispatch_arg_0, dispatch_arg_1)
		}
		'stream' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_ChaCha20.stream(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'ietfStream' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_ChaCha20.ietfstream(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'ietfStreamXorIc' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Core_ChaCha20.ietfstreamxoric(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'streamXorIc' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Core_ChaCha20.streamxoric(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		else { return none }
	}
}

fn (this &Class_ParagonIE_Sodium_Core_ChaCha20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_SodiumException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SodiumException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SodiumException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_sodium_compat_src_core_chacha20_php() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_Core_ChaCha20'), rt.new_bool(false)])) {
		return rt.new_null()
	}
}
