import rt

struct Class_ParagonIE_Sodium_Core32_ChaCha20 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core32_ChaCha20.quarterround(mut var_a Class_ParagonIE_Sodium_Core32_Int32, mut var_b Class_ParagonIE_Sodium_Core32_Int32, mut var_c Class_ParagonIE_Sodium_Core32_Int32, mut var_d Class_ParagonIE_Sodium_Core32_Int32) rt.PhpVal {
	mut var_a_mutated := var_a
	mut var_b_mutated := var_b
	mut var_c_mutated := var_c
	mut var_d_mutated := var_d
	var_a_mutated = rt.call_method(var_a_mutated, 'addInt32', [var_b_mutated.dup()])
	var_d_mutated = rt.call_method(rt.call_method(var_d_mutated, 'xorInt32', [var_a_mutated.dup()]), 'rotateLeft', [rt.new_int(16)])
	var_c_mutated = rt.call_method(var_c_mutated, 'addInt32', [var_d_mutated.dup()])
	var_b_mutated = rt.call_method(rt.call_method(var_b_mutated, 'xorInt32', [var_c_mutated.dup()]), 'rotateLeft', [rt.new_int(12)])
	var_a_mutated = rt.call_method(var_a_mutated, 'addInt32', [var_b_mutated.dup()])
	var_d_mutated = rt.call_method(rt.call_method(var_d_mutated, 'xorInt32', [var_a_mutated.dup()]), 'rotateLeft', [rt.new_int(8)])
	var_c_mutated = rt.call_method(var_c_mutated, 'addInt32', [var_d_mutated.dup()])
	var_b_mutated = rt.call_method(rt.call_method(var_b_mutated, 'xorInt32', [var_c_mutated.dup()]), 'rotateLeft', [rt.new_int(7)])
	return rt.create_array([rt.ArrayItem{ key: none, val: var_a_mutated }, rt.ArrayItem{ key: none, val: var_b_mutated }, rt.ArrayItem{ key: none, val: var_c_mutated }, rt.ArrayItem{ key: none, val: var_d_mutated }])
}

fn Class_ParagonIE_Sodium_Core32_ChaCha20.encryptbytes(mut var_ctx Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx, message string) rt.PhpVal {
	mut var_ctx_mutated := var_ctx
	mut message_mutated := message
	mut var_bytes := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20{}; return temp.strlen(arg_0) }(rt.new_string(message_mutated))
	mut var_j0 := var_ctx_mutated.array_get(0)
	mut var_j1 := var_ctx_mutated.array_get(1)
	mut var_j2 := var_ctx_mutated.array_get(2)
	mut var_j3 := var_ctx_mutated.array_get(3)
	mut var_j4 := var_ctx_mutated.array_get(4)
	mut var_j5 := var_ctx_mutated.array_get(5)
	mut var_j6 := var_ctx_mutated.array_get(6)
	mut var_j7 := var_ctx_mutated.array_get(7)
	mut var_j8 := var_ctx_mutated.array_get(8)
	mut var_j9 := var_ctx_mutated.array_get(9)
	mut var_j10 := var_ctx_mutated.array_get(10)
	mut var_j11 := var_ctx_mutated.array_get(11)
	mut var_j12 := var_ctx_mutated.array_get(12)
	mut var_j13 := var_ctx_mutated.array_get(13)
	mut var_j14 := var_ctx_mutated.array_get(14)
	mut var_j15 := var_ctx_mutated.array_get(15)
	mut var_c := rt.new_string(rt.new_string(''))
	{
		for {
			if rt.is_true(rt.less(var_bytes, rt.new_int(64))) {
				// unsupported expression: Expr_AssignOp_Concat
			}
			mut var_x0 := // unsupported expression: Expr_Clone
			mut var_x1 := // unsupported expression: Expr_Clone
			mut var_x2 := // unsupported expression: Expr_Clone
			mut var_x3 := // unsupported expression: Expr_Clone
			mut var_x4 := // unsupported expression: Expr_Clone
			mut var_x5 := // unsupported expression: Expr_Clone
			mut var_x6 := // unsupported expression: Expr_Clone
			mut var_x7 := // unsupported expression: Expr_Clone
			mut var_x8 := // unsupported expression: Expr_Clone
			mut var_x9 := // unsupported expression: Expr_Clone
			mut var_x10 := // unsupported expression: Expr_Clone
			mut var_x11 := // unsupported expression: Expr_Clone
			mut var_x12 := // unsupported expression: Expr_Clone
			mut var_x13 := // unsupported expression: Expr_Clone
			mut var_x14 := // unsupported expression: Expr_Clone
			mut var_x15 := // unsupported expression: Expr_Clone
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
			var_x0 = rt.call_method(var_x0, 'addInt32', [var_j0.dup()])
			var_x1 = rt.call_method(var_x1, 'addInt32', [var_j1.dup()])
			var_x2 = rt.call_method(var_x2, 'addInt32', [var_j2.dup()])
			var_x3 = rt.call_method(var_x3, 'addInt32', [var_j3.dup()])
			var_x4 = rt.call_method(var_x4, 'addInt32', [var_j4.dup()])
			var_x5 = rt.call_method(var_x5, 'addInt32', [var_j5.dup()])
			var_x6 = rt.call_method(var_x6, 'addInt32', [var_j6.dup()])
			var_x7 = rt.call_method(var_x7, 'addInt32', [var_j7.dup()])
			var_x8 = rt.call_method(var_x8, 'addInt32', [var_j8.dup()])
			var_x9 = rt.call_method(var_x9, 'addInt32', [var_j9.dup()])
			var_x10 = rt.call_method(var_x10, 'addInt32', [var_j10.dup()])
			var_x11 = rt.call_method(var_x11, 'addInt32', [var_j11.dup()])
			var_x12 = rt.call_method(var_x12, 'addInt32', [var_j12.dup()])
			var_x13 = rt.call_method(var_x13, 'addInt32', [var_j13.dup()])
			var_x14 = rt.call_method(var_x14, 'addInt32', [var_j14.dup()])
			var_x15 = rt.call_method(var_x15, 'addInt32', [var_j15.dup()])
			var_x0 = rt.call_method(var_x0, 'xorInt32', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(message_mutated), rt.new_int(0), rt.new_int(4)))])
			var_x1 = rt.call_method(var_x1, 'xorInt32', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(message_mutated), rt.new_int(4), rt.new_int(4)))])
			var_x2 = rt.call_method(var_x2, 'xorInt32', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(message_mutated), rt.new_int(8), rt.new_int(4)))])
			var_x3 = rt.call_method(var_x3, 'xorInt32', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(message_mutated), rt.new_int(12), rt.new_int(4)))])
			var_x4 = rt.call_method(var_x4, 'xorInt32', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(message_mutated), rt.new_int(16), rt.new_int(4)))])
			var_x5 = rt.call_method(var_x5, 'xorInt32', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(message_mutated), rt.new_int(20), rt.new_int(4)))])
			var_x6 = rt.call_method(var_x6, 'xorInt32', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(message_mutated), rt.new_int(24), rt.new_int(4)))])
			var_x7 = rt.call_method(var_x7, 'xorInt32', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(message_mutated), rt.new_int(28), rt.new_int(4)))])
			var_x8 = rt.call_method(var_x8, 'xorInt32', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(message_mutated), rt.new_int(32), rt.new_int(4)))])
			var_x9 = rt.call_method(var_x9, 'xorInt32', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(message_mutated), rt.new_int(36), rt.new_int(4)))])
			var_x10 = rt.call_method(var_x10, 'xorInt32', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(message_mutated), rt.new_int(40), rt.new_int(4)))])
			var_x11 = rt.call_method(var_x11, 'xorInt32', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(message_mutated), rt.new_int(44), rt.new_int(4)))])
			var_x12 = rt.call_method(var_x12, 'xorInt32', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(message_mutated), rt.new_int(48), rt.new_int(4)))])
			var_x13 = rt.call_method(var_x13, 'xorInt32', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(message_mutated), rt.new_int(52), rt.new_int(4)))])
			var_x14 = rt.call_method(var_x14, 'xorInt32', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(message_mutated), rt.new_int(56), rt.new_int(4)))])
			var_x15 = rt.call_method(var_x15, 'xorInt32', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(message_mutated), rt.new_int(60), rt.new_int(4)))])
			var_j12 = rt.call_method(var_j12, 'addInt', [rt.new_int(1)])
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.get_property(var_j12, 'limbs').array_get(0), rt.new_int(0))) && rt.is_true(rt.identical(rt.get_property(var_j12, 'limbs').array_get(1), rt.new_int(0))))) {
				var_j13 = rt.call_method(var_j13, 'addInt', [rt.new_int(1)])
			}
			mut var_block := rt.new_string( + ().str() + (rt.call_method(, 'toReverseString', []rt.PhpVal{})).str() + (rt.call_method(var_x10, 'toReverseString', []rt.PhpVal{})).str() + (rt.call_method(var_x11, 'toReverseString', []rt.PhpVal{})).str() + (rt.call_method(var_x12, 'toReverseString', []rt.PhpVal{})).str() + (rt.call_method(var_x13, 'toReverseString', []rt.PhpVal{})).str() + (rt.call_method(var_x14, 'toReverseString', []rt.PhpVal{})).str() + (rt.call_method(var_x15, 'toReverseString', []rt.PhpVal{})).str())
			if rt.is_true(rt.less(var_bytes, rt.new_int(64))) {
				// unsupported expression: Expr_AssignOp_Concat
				break
			}
			// unsupported expression: Expr_AssignOp_Concat
			// unsupported expression: Expr_AssignOp_Minus
			if rt.is_true(rt.less_equal(var_bytes, rt.new_int(0))) {
				break
			}
			message_mutated = (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_ChaCha20{}; return temp.substr(arg_0, arg_1) }(rt.new_string(), rt.new_int())).str()
		}
	}
	var_ctx_mutated.array_set(12, var_j12.dup())
	.array_set(, .dup())
	return .dup()
}

fn Class_ParagonIE_Sodium_Core32_ChaCha20.stream(len i64, nonce string, key string) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core32_ChaCha20.ietfstream(var_len rt.PhpVal, nonce string, key string) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core32_ChaCha20.ietfstreamxoric(var_message rt.PhpVal, nonce string, key string, ic string) rt.PhpVal {
	mut var_message_mutated := var_message
}

fn Class_ParagonIE_Sodium_Core32_ChaCha20.streamxoric(var_message rt.PhpVal, nonce string, key string, ic string) rt.PhpVal {
	mut var_message_mutated := var_message
}

struct Class_ParagonIE_Sodium_Core32_Util {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Int32 {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core32_chacha20() &Class_ParagonIE_Sodium_Core32_ChaCha20 {
	mut obj := &Class_ParagonIE_Sodium_Core32_ChaCha20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_util() &Class_ParagonIE_Sodium_Core32_Util {
	mut obj := &Class_ParagonIE_Sodium_Core32_Util{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_int32() &Class_ParagonIE_Sodium_Core32_Int32 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Int32{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core32_ChaCha20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'quarterRound' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](if args.len > 3 { args[3] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_ChaCha20.quarterround(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3)
		}
		'encryptBytes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Core32_ChaCha20.encryptbytes(mut dispatch_arg_0, dispatch_arg_1)
		}
		'stream' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Core32_ChaCha20.stream(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'ietfStream' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Core32_ChaCha20.ietfstream(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'ietfStreamXorIc' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Core32_ChaCha20.ietfstreamxoric(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'streamXorIc' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Core32_ChaCha20.streamxoric(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		else { return none }
	}
}

fn (this &Class_ParagonIE_Sodium_Core32_ChaCha20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_ChaCha20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ParagonIE_Sodium_Core32_Util) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Util) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Util) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ParagonIE_Sodium_Core32_Int32) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Int32) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int32) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_sodium_compat_src_core32_chacha20_php() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_Core32_ChaCha20'), rt.new_bool(false)])) {
		return rt.new_null()
	}
}
