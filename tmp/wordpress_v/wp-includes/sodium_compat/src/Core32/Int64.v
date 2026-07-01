import rt

struct Class_ParagonIE_Sodium_Core32_Int64 {
	rt.PhpObjectBase
pub mut:
		limbs rt.PhpVal = rt.new_array()
		overflow i64
		unsignedInt rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) construct(var_array rt.PhpVal, unsignedInt bool)  {
	this.limbs = rt.create_array([rt.ArrayItem{ key: none, val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: none, val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: none, val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: none, val: // unsupported expression: Expr_Cast_Int }])
	this.overflow = 0
	this.unsignedInt = rt.new_bool(unsignedInt).dup()
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) addint64(mut var_addend Class_ParagonIE_Sodium_Core32_Int64) rt.PhpVal {
	mut var_i0 := this.limbs.array_get(0)
	mut var_i1 := this.limbs.array_get(1)
	mut var_i2 := this.limbs.array_get(2)
	mut var_i3 := this.limbs.array_get(3)
	mut var_j0 := var_addend.limbs.array_get(0)
	mut var_j1 := var_addend.limbs.array_get(1)
	mut var_j2 := var_addend.limbs.array_get(2)
	mut var_j3 := var_addend.limbs.array_get(3)
	mut var_r3 := rt.add(var_i3, rt.bitwise_and(var_j3, rt.new_int(65535)))
	mut var_carry := rt.new_int(rt.shift_right(var_r3, rt.new_int(16)))
	mut var_r2 := rt.add(rt.add(var_i2, rt.bitwise_and(var_j2, rt.new_int(65535))), var_carry)
	var_carry = rt.new_int(rt.shift_right(var_r2, rt.new_int(16)))
	mut var_r1 := rt.add(rt.add(var_i1, rt.bitwise_and(var_j1, rt.new_int(65535))), var_carry)
	var_carry = rt.new_int(rt.shift_right(var_r1, rt.new_int(16)))
	mut var_r0 := rt.add(rt.add(var_i0, rt.bitwise_and(var_j0, rt.new_int(65535))), var_carry)
	var_carry = rt.new_int(rt.shift_right(var_r0, rt.new_int(16)))
	// unsupported expression: Expr_AssignOp_BitwiseAnd
	// unsupported expression: Expr_AssignOp_BitwiseAnd
	// unsupported expression: Expr_AssignOp_BitwiseAnd
	// unsupported expression: Expr_AssignOp_BitwiseAnd
	mut var_return := create_paragonie_sodium_core32_int64(rt.create_array([rt.ArrayItem{ key: none, val: var_r0 }, rt.ArrayItem{ key: none, val: var_r1 }, rt.ArrayItem{ key: none, val: var_r2 }, rt.ArrayItem{ key: none, val: var_r3 }]), false)
	rt.set_property(var_return, 'overflow', var_carry.dup())
	rt.set_property(var_return, 'unsignedInt', this.unsignedInt)
	return var_return.dup()
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) addint(var_int rt.PhpVal) rt.PhpVal {
	mut var_int_mutated := var_int
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Util{}; return temp.declarescalartype(arg_0, arg_1, arg_2) }(var_int_mutated.dup(), rt.new_string('int'), rt.new_int(1))
	var_int_mutated = // unsupported expression: Expr_Cast_Int
	mut var_i0 := this.limbs.array_get(0)
	mut var_i1 := this.limbs.array_get(1)
	mut var_i2 := this.limbs.array_get(2)
	mut var_i3 := this.limbs.array_get(3)
	mut var_r3 := rt.add(var_i3, rt.bitwise_and(var_int_mutated, rt.new_int(65535)))
	mut var_carry := rt.new_int(rt.shift_right(var_r3, rt.new_int(16)))
	mut var_r2 := rt.add(rt.add(var_i2, rt.shift_right(var_int_mutated, rt.new_int(16)) & 65535), var_carry)
	var_carry = rt.new_int(rt.shift_right(var_r2, rt.new_int(16)))
	mut var_r1 := rt.add(var_i1, var_carry)
	var_carry = rt.new_int(rt.shift_right(var_r1, rt.new_int(16)))
	mut var_r0 := rt.add(var_i0, var_carry)
	var_carry = rt.new_int(rt.shift_right(var_r0, rt.new_int(16)))
	// unsupported expression: Expr_AssignOp_BitwiseAnd
	// unsupported expression: Expr_AssignOp_BitwiseAnd
	// unsupported expression: Expr_AssignOp_BitwiseAnd
	// unsupported expression: Expr_AssignOp_BitwiseAnd
	mut var_return := create_paragonie_sodium_core32_int64(rt.create_array([rt.ArrayItem{ key: none, val: var_r0 }, rt.ArrayItem{ key: none, val: var_r1 }, rt.ArrayItem{ key: none, val: var_r2 }, rt.ArrayItem{ key: none, val: var_r3 }]), false)
	rt.set_property(var_return, 'overflow', var_carry.dup())
	rt.set_property(var_return, 'unsignedInt', this.unsignedInt)
	return var_return.dup()
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) compareint(b i64) rt.PhpVal {
	mut b_mutated := b
	mut var_gt := rt.new_int(rt.new_int(0))
	mut var_eq := rt.new_int(rt.new_int(1))
	mut var_i := rt.new_int(rt.new_int(4))
	mut var_j := rt.new_int(rt.new_int(0))
	for rt.is_true(rt.greater(var_i, rt.new_int(0))) {
		rt.pre_dec(var_i)
		mut var_x1 := this.limbs.array_get(var_i)
		mut var_x2 := rt.new_int(b_mutated >> rt.shift_left(var_j, rt.new_int(4)) & 65535)
		// unsupported expression: Expr_AssignOp_BitwiseOr
		// unsupported expression: Expr_AssignOp_BitwiseAnd
	}
	return rt.add(rt.sub(rt.add(var_gt, var_gt), var_eq), rt.new_int(1))
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) isgreaterthan(b i64) rt.PhpVal {
	mut b_mutated := b
	return rt.greater(this.compareint(b_mutated), rt.new_int(0))
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) islessthanint(b i64) rt.PhpVal {
	mut b_mutated := b
	return rt.less(this.compareint(b_mutated), rt.new_int(0))
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) mask64(hi i64, lo i64) rt.PhpVal {
	mut var_a := rt.new_int(hi >> 16 & 65535)
	mut var_b := rt.new_int(hi & 65535)
	mut var_c := rt.new_int(lo >> 16 & 65535)
	mut var_d := rt.new_int(lo & 65535)
	return create_paragonie_sodium_core32_int64(rt.create_array([rt.ArrayItem{ key: none, val: rt.bitwise_and(this.limbs.array_get(0), var_a) }, rt.ArrayItem{ key: none, val: rt.bitwise_and(this.limbs.array_get(1), var_b) }, rt.ArrayItem{ key: none, val: rt.bitwise_and(this.limbs.array_get(2), var_c) }, rt.ArrayItem{ key: none, val: rt.bitwise_and(this.limbs.array_get(3), var_d) }]), this.unsignedInt)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) mulint(int i64, size i64) rt.PhpVal {
	mut int_mutated := int
	mut size_mutated := size
	if rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		return this.mulintfast(rt.new_int(int_mutated))
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Util{}; return temp.declarescalartype(arg_0, arg_1, arg_2) }(rt.new_int(int_mutated), rt.new_string('int'), rt.new_int(1))
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Util{}; return temp.declarescalartype(arg_0, arg_1, arg_2) }(rt.new_int(size_mutated), rt.new_string('int'), rt.new_int(2))
	int_mutated = (// unsupported expression: Expr_Cast_Int).to_i64()
	size_mutated = (// unsupported expression: Expr_Cast_Int).to_i64()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(size_mutated))))) {
		size_mutated = 63
	}
	mut var_a := // unsupported expression: Expr_Clone
	mut var_return := create_paragonie_sodium_core32_int64(rt.new_null(), false)
	rt.set_property(var_return, 'unsignedInt', this.unsignedInt)
	mut var_ret0 := rt.new_int(rt.new_int(0))
	mut var_ret1 := rt.new_int(rt.new_int(0))
	mut var_ret2 := rt.new_int(rt.new_int(0))
	mut var_ret3 := rt.new_int(rt.new_int(0))
	mut var_a0 := rt.get_property(var_a, 'limbs').array_get(0)
	mut var_a1 := rt.get_property(var_a, 'limbs').array_get(1)
	mut var_a2 := rt.get_property(var_a, 'limbs').array_get(2)
	mut var_a3 := rt.get_property(var_a, 'limbs').array_get(3)
	{
		mut var_i := rt.new_int(rt.new_int(size_mutated)).dup()
		for {
			if !(rt.is_true(rt.greater_equal(var_i, rt.new_int(0)))) { break }
			mut var_mask := // unsupported expression: Expr_UnaryMinus
			mut var_x0 := rt.new_int(rt.bitwise_and(var_a0, var_mask))
			mut var_x1 := rt.new_int(rt.bitwise_and(var_a1, var_mask))
			mut var_x2 := rt.new_int(rt.bitwise_and(var_a2, var_mask))
			mut var_x3 := rt.new_int(rt.bitwise_and(var_a3, var_mask))
			// unsupported expression: Expr_AssignOp_Plus
			mut var_c := rt.new_int(rt.shift_right(var_ret3, rt.new_int(16)))
			// unsupported expression: Expr_AssignOp_Plus
			var_c = rt.new_int(rt.shift_right(var_ret2, rt.new_int(16)))
			// unsupported expression: Expr_AssignOp_Plus
			var_c = rt.new_int(rt.shift_right(var_ret1, rt.new_int(16)))
			// unsupported expression: Expr_AssignOp_Plus
			// unsupported expression: Expr_AssignOp_BitwiseAnd
			
			
		}
	}
}

fn Class_ParagonIE_Sodium_Core32_Int64.ctselect(mut var_A Class_ParagonIE_Sodium_Core32_Int64, mut var_B Class_ParagonIE_Sodium_Core32_Int64) rt.PhpVal {
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) multiplylong(mut var_a Class_array, mut var_b Class_array, baseLog2 i64) rt.PhpVal {
	mut var_a_mutated := var_a
	mut var_b_mutated := var_b
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) mulintfast(var_int rt.PhpVal) rt.PhpVal {
	mut var_int_mutated := var_int
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) mulint64fast(mut var_right Class_ParagonIE_Sodium_Core32_Int64) rt.PhpVal {
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) mulint64(mut var_int Class_ParagonIE_Sodium_Core32_Int64, size i64) rt.PhpVal {
	mut var_a := rt.new_null()
	mut var_b := rt.new_null()
	mut var_int_mutated := var_int
	mut size_mutated := size
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) orint64(mut var_b Class_ParagonIE_Sodium_Core32_Int64) rt.PhpVal {
	mut var_b_mutated := var_b
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) rotateleft(c i64) rt.PhpVal {
	mut var_limbs := rt.new_null()
	mut var_myLimbs := rt.new_null()
	mut c_mutated := c
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) rotateright(c i64) rt.PhpVal {
	mut var_limbs := rt.new_null()
	mut var_myLimbs := rt.new_null()
	mut c_mutated := c
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) shiftleft(c i64) rt.PhpVal {
	mut c_mutated := c
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) shiftright(c i64) rt.PhpVal {
	mut c_mutated := c
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) subint(var_int rt.PhpVal) rt.PhpVal {
	mut var_int_mutated := var_int
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) subint64(mut var_b Class_ParagonIE_Sodium_Core32_Int64) rt.PhpVal {
	mut var_b_mutated := var_b
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) xorint64(mut var_b Class_ParagonIE_Sodium_Core32_Int64) rt.PhpVal {
	mut var_b_mutated := var_b
}

fn Class_ParagonIE_Sodium_Core32_Int64.fromints(var_low rt.PhpVal, var_high rt.PhpVal) rt.PhpVal {
	mut var_low_mutated := var_low
	mut var_high_mutated := var_high
}

fn Class_ParagonIE_Sodium_Core32_Int64.fromint(var_low rt.PhpVal) rt.PhpVal {
	mut var_low_mutated := var_low
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) toint() rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core32_Int64.fromstring(var_string rt.PhpVal) rt.PhpVal {
	mut var_string_mutated := var_string
}

fn Class_ParagonIE_Sodium_Core32_Int64.fromreversestring(var_string rt.PhpVal) rt.PhpVal {
	mut var_string_mutated := var_string
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) toarray() rt.PhpVal {
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) toint32() rt.PhpVal {
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) toint64() rt.PhpVal {
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) setunsignedint(bool bool) rt.PhpVal {
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) tostring() string {
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) toreversestring() string {
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) magic_tostring() rt.PhpVal {
	return rt.new_null()
}

struct Class_ParagonIE_Sodium_Core32_Util {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core32_int64(arg_0 rt.PhpVal, unsignedInt bool) &Class_ParagonIE_Sodium_Core32_Int64 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Int64{
		PhpObjectBase: rt.PhpObjectBase{}
		limbs: rt.new_array()
		overflow: i64(0)
		unsignedInt: rt.new_bool(false)
	}
	obj.construct(arg_0, unsignedInt)
	return obj
}

fn create_paragonie_sodium_core32_util() &Class_ParagonIE_Sodium_Core32_Util {
	mut obj := &Class_ParagonIE_Sodium_Core32_Util{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'addInt64' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.addint64(mut dispatch_arg_0)
		}
		'addInt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.addint(dispatch_arg_0)
		}
		'compareInt' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.compareint(dispatch_arg_0)
		}
		'isGreaterThan' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.isgreaterthan(dispatch_arg_0)
		}
		'isLessThanInt' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.islessthanint(dispatch_arg_0)
		}
		'mask64' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.mask64(dispatch_arg_0, dispatch_arg_1)
		}
		'mulInt' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.mulint(dispatch_arg_0, dispatch_arg_1)
		}
		'ctSelect' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_Int64.ctselect(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'multiplyLong' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return this.multiplylong(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'mulIntFast' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.mulintfast(dispatch_arg_0)
		}
		'mulInt64Fast' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.mulint64fast(mut dispatch_arg_0)
		}
		'mulInt64' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.mulint64(mut dispatch_arg_0, dispatch_arg_1)
		}
		'orInt64' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.orint64(mut dispatch_arg_0)
		}
		'rotateLeft' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.rotateleft(dispatch_arg_0)
		}
		'rotateRight' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.rotateright(dispatch_arg_0)
		}
		'shiftLeft' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.shiftleft(dispatch_arg_0)
		}
		'shiftRight' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.shiftright(dispatch_arg_0)
		}
		'subInt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.subint(dispatch_arg_0)
		}
		'subInt64' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.subint64(mut dispatch_arg_0)
		}
		'xorInt64' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.xorint64(mut dispatch_arg_0)
		}
		'fromInts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Int64.fromints(dispatch_arg_0, dispatch_arg_1)
		}
		'fromInt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Int64.fromint(dispatch_arg_0)
		}
		'toInt' {
			return this.toint()
		}
		'fromString' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Int64.fromstring(dispatch_arg_0)
		}
		'fromReverseString' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Int64.fromreversestring(dispatch_arg_0)
		}
		'toArray' {
			return this.toarray()
		}
		'toInt32' {
			return this.toint32()
		}
		'toInt64' {
			return this.toint64()
		}
		'setUnsignedInt' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.setunsignedint(dispatch_arg_0)
		}
		'toString' {
			return rt.new_string(this.tostring())
		}
		'toReverseString' {
			return rt.new_string(this.toreversestring())
		}
		'__toString' {
			return this.magic_tostring()
		}
		else { return none }
	}
}

fn (this &Class_ParagonIE_Sodium_Core32_Int64) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'limbs' { return this.limbs }
		'overflow' { return rt.new_int(this.overflow) }
		'unsignedInt' { return this.unsignedInt }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'limbs' { this.limbs = val; return true }
		'overflow' { this.overflow = (val).to_i64(); return true }
		'unsignedInt' { this.unsignedInt = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_includes_sodium_compat_src_core32_int64_php() {
}
