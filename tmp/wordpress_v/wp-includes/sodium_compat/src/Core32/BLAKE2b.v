import rt

pub fn Class_ParagonIE_Sodium_Core32_BLAKE2b.blockbytes() i64 {
	return 128
}
pub fn Class_ParagonIE_Sodium_Core32_BLAKE2b.outbytes() i64 {
	return 64
}
pub fn Class_ParagonIE_Sodium_Core32_BLAKE2b.keybytes() i64 {
	return 64
}
struct Class_ParagonIE_Sodium_Core32_BLAKE2b {
	rt.PhpObjectBase
pub mut:
		iv rt.PhpVal = rt.new_null()
		sigma rt.PhpVal = rt.new_array()
}

fn Class_ParagonIE_Sodium_Core32_BLAKE2b.new64(var_high rt.PhpVal, var_low rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int64{}; return temp.fromints(arg_0, arg_1) }(var_low.dup(), var_high.dup())
}

fn Class_ParagonIE_Sodium_Core32_BLAKE2b.to64(var_num rt.PhpVal) rt.PhpVal {
	mut var_hi := rt.new_null()
	mut var_lo := rt.new_null()
	// unsupported assign target: Expr_List
	return Class_ParagonIE_Sodium_Core32_BLAKE2b.new64(var_hi.dup(), var_lo.dup())
}

fn Class_ParagonIE_Sodium_Core32_BLAKE2b.add64(var_x rt.PhpVal, var_y rt.PhpVal) rt.PhpVal {
	mut var_x_mutated := var_x
	return rt.call_method(var_x_mutated, 'addInt64', [var_y.dup()])
}

fn Class_ParagonIE_Sodium_Core32_BLAKE2b.add364(var_x rt.PhpVal, var_y rt.PhpVal, var_z rt.PhpVal) rt.PhpVal {
	mut var_x_mutated := var_x
	return rt.call_method(rt.call_method(var_x_mutated, 'addInt64', [var_y.dup()]), 'addInt64', [var_z.dup()])
}

fn Class_ParagonIE_Sodium_Core32_BLAKE2b.xor64(mut var_x Class_ParagonIE_Sodium_Core32_Int64, mut var_y Class_ParagonIE_Sodium_Core32_Int64) rt.PhpVal {
	mut var_x_mutated := var_x
	return rt.call_method(var_x_mutated, 'xorInt64', [var_y])
}

fn Class_ParagonIE_Sodium_Core32_BLAKE2b.rotr64(mut var_x Class_ParagonIE_Sodium_Core32_Int64, var_c rt.PhpVal) rt.PhpVal {
	mut var_x_mutated := var_x
	mut var_c_mutated := var_c
	return rt.call_method(var_x_mutated, 'rotateRight', [var_c_mutated.dup()])
}

fn Class_ParagonIE_Sodium_Core32_BLAKE2b.load64(var_x rt.PhpVal, var_i rt.PhpVal) rt.PhpVal {
	mut var_x_mutated := var_x
	mut var_i_mutated := var_i
	mut var_l := rt.new_int(rt.bitwise_or(// unsupported expression: Expr_Cast_Int, rt.shift_left(// unsupported expression: Expr_Cast_Int, rt.new_int(8))) | rt.shift_left(// unsupported expression: Expr_Cast_Int, rt.new_int(16)) | rt.shift_left(// unsupported expression: Expr_Cast_Int, rt.new_int(24)))
	mut var_h := rt.new_int(rt.bitwise_or(// unsupported expression: Expr_Cast_Int, rt.shift_left(// unsupported expression: Expr_Cast_Int, rt.new_int(8))) | rt.shift_left(// unsupported expression: Expr_Cast_Int, rt.new_int(16)) | rt.shift_left(// unsupported expression: Expr_Cast_Int, rt.new_int(24)))
	return Class_ParagonIE_Sodium_Core32_BLAKE2b.new64(var_h.dup(), var_l.dup())
}

fn Class_ParagonIE_Sodium_Core32_BLAKE2b.store64(mut var_x Class_SplFixedArray, var_i rt.PhpVal, mut var_u Class_ParagonIE_Sodium_Core32_Int64)  {
	mut var_x_mutated := var_x
	mut var_i_mutated := var_i
	mut var_v := // unsupported expression: Expr_Clone
	mut var_maxLength := rt.sub(rt.call_method(var_x_mutated, 'getSize', []rt.PhpVal{}), rt.new_int(1))
	{
		mut var_j := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_j, rt.new_int(8)))) { break }
			mut var_k := rt.new_int(3 - rt.shift_right(var_j, rt.new_int(1)))
			var_x_mutated.array_set(var_i_mutated, rt.bitwise_and(rt.get_property(var_v, 'limbs').array_get(var_k), rt.new_int(255)))
			if rt.is_true(rt.greater(rt.pre_inc(var_i_mutated), var_maxLength)) {
				return rt.new_null()
			}
			// unsupported expression: Expr_AssignOp_ShiftRight
			rt.pre_inc(var_j)
		}
	}
}

fn Class_ParagonIE_Sodium_Core32_BLAKE2b.pseudoconstructor()  {
	// unsupported statement: Stmt_Static
	if rt.is_true(var_called) {
		return rt.new_null()
	}
	// unsupported assign target: Expr_StaticPropertyFetch
	// unsupported expression: Expr_StaticPropertyFetch.array_set(0, Class_ParagonIE_Sodium_Core32_BLAKE2b.new64(rt.new_int(1779033703), rt.new_int(4089235720)))
	// unsupported expression: Expr_StaticPropertyFetch.array_set(1, Class_ParagonIE_Sodium_Core32_BLAKE2b.new64(rt.new_int(3144134277), rt.new_int(2227873595)))
	// unsupported expression: Expr_StaticPropertyFetch.array_set(2, Class_ParagonIE_Sodium_Core32_BLAKE2b.new64(rt.new_int(1013904242), rt.new_int(4271175723)))
	// unsupported expression: Expr_StaticPropertyFetch.array_set(3, Class_ParagonIE_Sodium_Core32_BLAKE2b.new64(rt.new_int(2773480762), rt.new_int(1595750129)))
	// unsupported expression: Expr_StaticPropertyFetch.array_set(4, Class_ParagonIE_Sodium_Core32_BLAKE2b.new64(rt.new_int(1359893119), rt.new_int(2917565137)))
	// unsupported expression: Expr_StaticPropertyFetch.array_set(5, Class_ParagonIE_Sodium_Core32_BLAKE2b.new64(rt.new_int(2600822924), rt.new_int(725511199)))
	// unsupported expression: Expr_StaticPropertyFetch.array_set(6, Class_ParagonIE_Sodium_Core32_BLAKE2b.new64(rt.new_int(528734635), rt.new_int(4215389547)))
	// unsupported expression: Expr_StaticPropertyFetch.array_set(7, Class_ParagonIE_Sodium_Core32_BLAKE2b.new64(rt.new_int(1541459225), rt.new_int(327033209)))
	mut var_called := rt.new_bool(rt.new_bool(true))
}

fn Class_ParagonIE_Sodium_Core32_BLAKE2b.context() rt.PhpVal {
	mut var_ctx := create_splfixedarray(rt.new_int(6))
	var_ctx.array_set(0, create_splfixedarray(rt.new_int(8)))
	var_ctx.array_set(1, create_splfixedarray(rt.new_int(2)))
	var_ctx.array_set(2, create_splfixedarray(rt.new_int(2)))
	var_ctx.array_set(3, create_splfixedarray(rt.new_int(256)))
	var_ctx.array_set(4, 0)
	var_ctx.array_set(5, 0)
	{
		mut var_i := rt.new_int(rt.new_int(8))
		for {
			if !(rt.is_true(rt.post_dec(var_i))) { break }
			var_ctx.array_get_mut(0).array_set(var_i, // unsupported expression: Expr_StaticPropertyFetch.array_get(var_i))
		}
	}
	{
		var_i = rt.new_int(rt.new_int(256))
		for {
			if !(rt.is_true(rt.post_dec(var_i))) { break }
			var_ctx.array_get_mut(3).array_set(var_i, 0)
		}
	}
	mut var_zero := Class_ParagonIE_Sodium_Core32_BLAKE2b.new64(rt.new_int(0), rt.new_int(0))
	var_ctx.array_get_mut(1).array_set(0, var_zero.dup())
	var_ctx.array_get_mut(1).array_set(1, var_zero.dup())
	var_ctx.array_get_mut(2).array_set(0, var_zero.dup())
	var_ctx.array_get_mut(2).array_set(1, var_zero.dup())
	return var_ctx.dup()
}

fn Class_ParagonIE_Sodium_Core32_BLAKE2b.compress(mut var_ctx Class_SplFixedArray, mut var_buf Class_SplFixedArray)  {
	mut var_ctx_mutated := var_ctx
	mut var_m := create_splfixedarray(rt.new_int(16))
	mut var_v := create_splfixedarray(rt.new_int(16))
	{
		mut var_i := rt.new_int(rt.new_int(16))
		for {
			if !(rt.is_true(rt.post_dec(var_i))) { break }
			var_m.array_set(var_i, Class_ParagonIE_Sodium_Core32_BLAKE2b.load64(rt.new_object('SplFixedArray', []string{}, var_buf), rt.new_int(rt.shift_left(var_i, rt.new_int(3)))))
		}
	}
	{
		var_i = rt.new_int(rt.new_int(8))
		for {
			if !(rt.is_true(rt.post_dec(var_i))) { break }
			var_v.array_set(var_i, var_ctx_mutated.array_get(0).array_get(var_i))
		}
	}
	var_v.array_set(8, // unsupported expression: Expr_StaticPropertyFetch.array_get(0))
	var_v.array_set(9, // unsupported expression: Expr_StaticPropertyFetch.array_get(1))
	var_v.array_set(10, // unsupported expression: Expr_StaticPropertyFetch.array_get(2))
	var_v.array_set(11, // unsupported expression: Expr_StaticPropertyFetch.array_get(3))
	var_v.array_set(12, Class_ParagonIE_Sodium_Core32_BLAKE2b.xor64(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](var_ctx_mutated.array_get(1).array_get(0)), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](// unsupported expression: Expr_StaticPropertyFetch.array_get(4))))
	var_v.array_set(13, Class_ParagonIE_Sodium_Core32_BLAKE2b.xor64(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](var_ctx_mutated.array_get(1).array_get(1)), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](// unsupported expression: Expr_StaticPropertyFetch.array_get(5))))
	var_v.array_set(14, Class_ParagonIE_Sodium_Core32_BLAKE2b.xor64(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](var_ctx_mutated.array_get(2).array_get(0)), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](// unsupported expression: Expr_StaticPropertyFetch.array_get(6))))
	var_v.array_set(15, Class_ParagonIE_Sodium_Core32_BLAKE2b.xor64(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](var_ctx_mutated.array_get(2).array_get(1)), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](// unsupported expression: Expr_StaticPropertyFetch.array_get(7))))
	{
		mut var_r := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_r, rt.new_int(12)))) { break }
			var_v = Class_ParagonIE_Sodium_Core32_BLAKE2b.g(mut rt.cast_object_ptr[Class_SplFixedArray](var_r), mut 0, rt.new_int(0), rt.new_int(4), rt.new_int(8), rt.new_int(12), var_v.dup(), var_m.dup())
			var_v = Class_ParagonIE_Sodium_Core32_BLAKE2b.g(mut rt.cast_object_ptr[Class_SplFixedArray](var_r), mut 1, rt.new_int(1), rt.new_int(5), rt.new_int(9), rt.new_int(13), var_v.dup(), var_m.dup())
			var_v = Class_ParagonIE_Sodium_Core32_BLAKE2b.g(mut rt.cast_object_ptr[Class_SplFixedArray](var_r), mut 2, rt.new_int(2), rt.new_int(6), rt.new_int(10), rt.new_int(14), var_v.dup(), var_m.dup())
			var_v = Class_ParagonIE_Sodium_Core32_BLAKE2b.g(mut rt.cast_object_ptr[Class_SplFixedArray](var_r), mut 3, rt.new_int(3), rt.new_int(7), rt.new_int(11), rt.new_int(15), var_v.dup(), var_m.dup())
			var_v = Class_ParagonIE_Sodium_Core32_BLAKE2b.g(mut rt.cast_object_ptr[Class_SplFixedArray](var_r), mut 4, rt.new_int(0), rt.new_int(5), rt.new_int(10), rt.new_int(15), var_v.dup(), var_m.dup())
			var_v = Class_ParagonIE_Sodium_Core32_BLAKE2b.g(mut rt.cast_object_ptr[Class_SplFixedArray](var_r), mut 5, rt.new_int(1), rt.new_int(6), rt.new_int(11), rt.new_int(12), var_v.dup(), var_m.dup())
			var_v = Class_ParagonIE_Sodium_Core32_BLAKE2b.g(mut rt.cast_object_ptr[Class_SplFixedArray](var_r), mut 6, rt.new_int(2), rt.new_int(7), rt.new_int(8), rt.new_int(13), var_v.dup(), var_m.dup())
			var_v = Class_ParagonIE_Sodium_Core32_BLAKE2b.g(mut rt.cast_object_ptr[Class_SplFixedArray](var_r), mut 7, rt.new_int(3), rt.new_int(4), rt.new_int(9), rt.new_int(14), var_v.dup(), var_m.dup())
			rt.pre_inc(var_r)
		}
	}
	{
		mut var_i := rt.new_int(rt.new_int(8))
		for {
			if !(rt.is_true(rt.post_dec(var_i))) { break }
			var_ctx_mutated.array_get_mut(0).array_set(var_i, Class_ParagonIE_Sodium_Core32_BLAKE2b.xor64(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](var_ctx_mutated.array_get(0).array_get(var_i)), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](Class_ParagonIE_Sodium_Core32_BLAKE2b.xor64(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](var_v.array_get(var_i)), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](var_v.array_get(rt.add(var_i, rt.new_int(8))))))))
		}
	}
}

fn Class_ParagonIE_Sodium_Core32_BLAKE2b.g(var_r rt.PhpVal, var_i rt.PhpVal, var_a rt.PhpVal, var_b rt.PhpVal, var_c rt.PhpVal, var_d rt.PhpVal, mut var_v Class_SplFixedArray, mut var_m Class_SplFixedArray) rt.PhpVal {
	mut var_r_mutated := var_r
	mut var_i_mutated := var_i
	mut var_c_mutated := var_c
	mut var_v_mutated := var_v
	mut var_m_mutated := var_m
	var_v_mutated.array_set(var_a, Class_ParagonIE_Sodium_Core32_BLAKE2b.add364(var_v_mutated.array_get(var_a), var_v_mutated.array_get(var_b), var_m_mutated.array_get(// unsupported expression: Expr_StaticPropertyFetch.array_get(var_r_mutated).array_get(rt.shift_left(var_i_mutated, rt.new_int(1))))))
	var_v_mutated.array_set(var_d, Class_ParagonIE_Sodium_Core32_BLAKE2b.rotr64(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](Class_ParagonIE_Sodium_Core32_BLAKE2b.xor64(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](var_v_mutated.array_get(var_d)), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](var_v_mutated.array_get(var_a)))), rt.new_int(32)))
	var_v_mutated.array_set(var_c_mutated, Class_ParagonIE_Sodium_Core32_BLAKE2b.add64(var_v_mutated.array_get(var_c_mutated), var_v_mutated.array_get(var_d)))
	var_v_mutated.array_set(var_b, Class_ParagonIE_Sodium_Core32_BLAKE2b.rotr64(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](Class_ParagonIE_Sodium_Core32_BLAKE2b.xor64(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](var_v_mutated.array_get(var_b)), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](var_v_mutated.array_get(var_c_mutated)))), rt.new_int(24)))
	var_v_mutated.array_set(var_a, Class_ParagonIE_Sodium_Core32_BLAKE2b.add364(var_v_mutated.array_get(var_a), var_v_mutated.array_get(var_b), var_m_mutated.array_get(// unsupported expression: Expr_StaticPropertyFetch.array_get(var_r_mutated).array_get(rt.shift_left(var_i_mutated, rt.new_int(1)) + 1))))
	var_v_mutated.array_set(var_d, Class_ParagonIE_Sodium_Core32_BLAKE2b.rotr64(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](Class_ParagonIE_Sodium_Core32_BLAKE2b.xor64(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](var_v_mutated.array_get(var_d)), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](var_v_mutated.array_get(var_a)))), rt.new_int(16)))
	var_v_mutated.array_set(var_c_mutated, Class_ParagonIE_Sodium_Core32_BLAKE2b.add64(var_v_mutated.array_get(var_c_mutated), var_v_mutated.array_get(var_d)))
	var_v_mutated.array_set(var_b, Class_ParagonIE_Sodium_Core32_BLAKE2b.rotr64(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](Class_ParagonIE_Sodium_Core32_BLAKE2b.xor64(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](var_v_mutated.array_get(var_b)), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](var_v_mutated.array_get(var_c_mutated)))), rt.new_int(63)))
	return rt.new_object('SplFixedArray', []string{}, var_v_mutated)
}

fn Class_ParagonIE_Sodium_Core32_BLAKE2b.increment_counter(var_ctx rt.PhpVal, var_inc rt.PhpVal)  {
	mut var_ctx_mutated := var_ctx
	if rt.is_true(rt.less(var_inc, rt.new_int(0))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Increasing by a negative number makes no sense.'))))
	}
	mut var_t := Class_ParagonIE_Sodium_Core32_BLAKE2b.to64(var_inc.dup())
	var_ctx_mutated.array_get_mut(1).array_set(0, Class_ParagonIE_Sodium_Core32_BLAKE2b.add64(var_ctx_mutated.array_get(1).array_get(0), var_t.dup()))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_ctx_mutated.array_get(1).array_get(0), 'ParagonIE_Sodium_Core32_Int64')))))) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(rt.new_string('Not an int64'))))
	}
	mut var_c := var_ctx_mutated.array_get(1).array_get(0)
	if rt.is_true(rt.call_method(var_c, 'isLessThanInt', [var_inc.dup()])) {
		var_ctx_mutated.array_get_mut(1).array_set(1, Class_ParagonIE_Sodium_Core32_BLAKE2b.add64(var_ctx_mutated.array_get(1).array_get(1), Class_ParagonIE_Sodium_Core32_BLAKE2b.to64(rt.new_int(1))))
	}
}

fn Class_ParagonIE_Sodium_Core32_BLAKE2b.update(mut var_ctx Class_SplFixedArray, mut var_p Class_SplFixedArray, var_plen rt.PhpVal)  {
	mut var_ctx_mutated := var_ctx
	mut var_p_mutated := var_p
	Class_ParagonIE_Sodium_Core32_BLAKE2b.pseudoconstructor()
	mut var_offset := rt.new_int(rt.new_int(0))
	for rt.is_true(rt.greater(var_plen, rt.new_int(0))) {
		mut var_left := var_ctx_mutated.array_get(4)
		mut var_fill := rt.sub(rt.new_int(256), var_left)
		if rt.is_true(rt.greater(var_plen, var_fill)) {
			{
				mut var_i := var_fill.dup()
				for {
					if !(rt.is_true(rt.post_dec(var_i))) { break }
					var_ctx_mutated.array_get_mut(3).array_set(rt.add(var_i, var_left), var_p_mutated.array_get(rt.add(var_i, var_offset)))
				}
			}
			// unsupported expression: Expr_AssignOp_Plus
			Class_ParagonIE_Sodium_Core32_BLAKE2b.increment_counter(rt.new_object('SplFixedArray', []string{}, var_ctx_mutated), rt.new_int(128))
			Class_ParagonIE_Sodium_Core32_BLAKE2b.compress(mut , mut rt.cast_object_ptr[Class_SplFixedArray]())
			{
				
				for {
					if !(rt.is_true()) { break }
				}
			}
		} else {
		}
	}
}

fn Class_ParagonIE_Sodium_Core32_BLAKE2b.finish(mut var_ctx Class_SplFixedArray, mut var_out Class_SplFixedArray) rt.PhpVal {
	mut var_ctx_mutated := var_ctx
	
}

fn Class_ParagonIE_Sodium_Core32_BLAKE2b.init(var_key rt.PhpVal, outlen i64, var_salt rt.PhpVal, var_personal rt.PhpVal) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core32_BLAKE2b.stringtosplfixedarray(str string) rt.PhpVal {
	mut str_mutated := str
}

fn Class_ParagonIE_Sodium_Core32_BLAKE2b.splfixedarraytostring(mut var_a Class_SplFixedArray) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core32_BLAKE2b.contexttostring(mut var_ctx Class_SplFixedArray) string {
	mut var_ctx_mutated := var_ctx
}

fn Class_ParagonIE_Sodium_Core32_BLAKE2b.stringtocontext(var_string rt.PhpVal) rt.PhpVal {
}

struct Class_ParagonIE_Sodium_Core_Util {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Int64 {
	rt.PhpObjectBase
}

struct Class_SplFixedArray {
	rt.PhpObjectBase
}

struct Class_SodiumException {
	rt.PhpObjectBase
}

struct Class_TypeError {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core32_blake2b() &Class_ParagonIE_Sodium_Core32_BLAKE2b {
	mut obj := &Class_ParagonIE_Sodium_Core32_BLAKE2b{
		PhpObjectBase: rt.PhpObjectBase{}
		iv: rt.new_null()
		sigma: rt.new_array()
	}
	return obj
}

fn create_paragonie_sodium_core_util() &Class_ParagonIE_Sodium_Core_Util {
	mut obj := &Class_ParagonIE_Sodium_Core_Util{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_int64() &Class_ParagonIE_Sodium_Core32_Int64 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Int64{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_splfixedarray() &Class_SplFixedArray {
	mut obj := &Class_SplFixedArray{
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

fn create_typeerror() &Class_TypeError {
	mut obj := &Class_TypeError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core32_BLAKE2b) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'new64' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_BLAKE2b.new64(dispatch_arg_0, dispatch_arg_1)
		}
		'to64' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_BLAKE2b.to64(dispatch_arg_0)
		}
		'add64' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_BLAKE2b.add64(dispatch_arg_0, dispatch_arg_1)
		}
		'add364' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_BLAKE2b.add364(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'xor64' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_BLAKE2b.xor64(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'rotr64' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_BLAKE2b.rotr64(mut dispatch_arg_0, dispatch_arg_1)
		}
		'load64' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_BLAKE2b.load64(dispatch_arg_0, dispatch_arg_1)
		}
		'store64' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SplFixedArray](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int64](if args.len > 2 { args[2] } else { rt.new_null() })
			Class_ParagonIE_Sodium_Core32_BLAKE2b.store64(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'pseudoConstructor' {
			Class_ParagonIE_Sodium_Core32_BLAKE2b.pseudoconstructor()
			return rt.new_null()
		}
		'context' {
			return Class_ParagonIE_Sodium_Core32_BLAKE2b.context()
		}
		'compress' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SplFixedArray](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_SplFixedArray](if args.len > 1 { args[1] } else { rt.new_null() })
			Class_ParagonIE_Sodium_Core32_BLAKE2b.compress(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'G' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			mut dispatch_arg_6 := rt.cast_object_ptr[Class_SplFixedArray](if args.len > 6 { args[6] } else { rt.new_null() })
			mut dispatch_arg_7 := rt.cast_object_ptr[Class_SplFixedArray](if args.len > 7 { args[7] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_BLAKE2b.g(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5, mut dispatch_arg_6, mut dispatch_arg_7)
		}
		'increment_counter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_ParagonIE_Sodium_Core32_BLAKE2b.increment_counter(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'update' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SplFixedArray](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_SplFixedArray](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_ParagonIE_Sodium_Core32_BLAKE2b.update(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'finish' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SplFixedArray](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_SplFixedArray](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_BLAKE2b.finish(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'init' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_BLAKE2b.init(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'stringToSplFixedArray' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Core32_BLAKE2b.stringtosplfixedarray(dispatch_arg_0)
		}
		'SplFixedArrayToString' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SplFixedArray](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_BLAKE2b.splfixedarraytostring(mut dispatch_arg_0)
		}
		'contextToString' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SplFixedArray](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(Class_ParagonIE_Sodium_Core32_BLAKE2b.contexttostring(mut dispatch_arg_0))
		}
		'stringToContext' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_BLAKE2b.stringtocontext(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_ParagonIE_Sodium_Core32_BLAKE2b) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'iv' { return this.iv }
		'sigma' { return this.sigma }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ParagonIE_Sodium_Core32_BLAKE2b) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'iv' { this.iv = val; return true }
		'sigma' { this.sigma = val; return true }
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


fn (mut this Class_ParagonIE_Sodium_Core32_Int64) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Int64) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_SplFixedArray) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SplFixedArray) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SplFixedArray) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_TypeError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_TypeError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_TypeError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_sodium_compat_src_core32_blake2b_php() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_Core_BLAKE2b'), rt.new_bool(false)])) {
		return rt.new_null()
	}
}
