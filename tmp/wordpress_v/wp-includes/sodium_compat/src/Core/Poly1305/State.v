import rt

struct Class_ParagonIE_Sodium_Core_Poly1305_State {
	rt.PhpObjectBase
pub mut:
		buffer rt.PhpVal = rt.new_array()
		final bool
		h rt.PhpVal = rt.new_null()
		leftover rt.PhpVal = rt.new_int(0)
		r rt.PhpVal = rt.new_null()
		pad rt.PhpVal = rt.new_null()
}

fn (mut this Class_ParagonIE_Sodium_Core_Poly1305_State) construct(key string)  {
	if rt.is_true(rt.less(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.strlen(arg_0) }(rt.new_string(key)), rt.new_int(32))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.new_string('Poly1305 requires a 32-byte key'))))
	}
	this.r = rt.create_array([rt.ArrayItem{ key: none, val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: none, val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: none, val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: none, val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: none, val: // unsupported expression: Expr_Cast_Int }])
	this.h = rt.create_array([rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }])
	this.pad = rt.create_array([rt.ArrayItem{ key: none, val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(key), rt.new_int(16), rt.new_int(4))) }, rt.ArrayItem{ key: none, val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(key), rt.new_int(20), rt.new_int(4))) }, rt.ArrayItem{ key: none, val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(key), rt.new_int(24), rt.new_int(4))) }, rt.ArrayItem{ key: none, val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(key), rt.new_int(28), rt.new_int(4))) }])
	this.leftover = rt.new_int(0)
	this.final = false
}

fn (mut this Class_ParagonIE_Sodium_Core_Poly1305_State) magic_destruct()  {
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
	this.leftover = rt.new_int(0)
	this.final = true
}

fn (mut this Class_ParagonIE_Sodium_Core_Poly1305_State) update(message string) rt.PhpVal {
	mut message_mutated := message
	mut var_bytes := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.strlen(arg_0) }(rt.new_string(message_mutated))
	if rt.is_true(rt.less(var_bytes, rt.new_int(1))) {
		return rt.new_object('ParagonIE_Sodium_Core_Poly1305_State', []string{}, this)
	}
	if rt.is_true(this.leftover) {
		mut var_want := rt.sub(Class_ParagonIE_Sodium_Core_Poly1305.block_size(), this.leftover)
		if rt.is_true(rt.greater(var_want, var_bytes)) {
			var_want = var_bytes.dup()
		}
		{
			mut var_i := rt.new_int(rt.new_int(0))
			for {
				if !(rt.is_true(rt.less(var_i, var_want))) { break }
				mut var_mi := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.chrtoint(arg_0) }(rt.new_string(message_mutated).array_get(var_i))
				this.buffer.array_set(rt.add(this.leftover, var_i), var_mi.dup())
				rt.pre_inc(var_i)
			}
		}
		message_mutated = (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.substr(arg_0, arg_1) }(rt.new_string(message_mutated), var_want.dup())).str()
		var_bytes = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.strlen(arg_0) }(rt.new_string(message_mutated))
		// unsupported expression: Expr_AssignOp_Plus
		if rt.is_true(rt.less(this.leftover, Class_ParagonIE_Sodium_Core_Poly1305.block_size())) {
			return rt.new_object('ParagonIE_Sodium_Core_Poly1305_State', []string{}, this)
		}
		this.blocks(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.intarraytostring(arg_0) }(this.buffer), Class_ParagonIE_Sodium_Core_Poly1305.block_size())
		this.leftover = rt.new_int(0)
	}
	if rt.is_true(rt.greater_equal(var_bytes, Class_ParagonIE_Sodium_Core_Poly1305.block_size())) {
		var_want = rt.new_int(rt.bitwise_and(var_bytes, rt.bitwise_not(rt.sub(Class_ParagonIE_Sodium_Core_Poly1305.block_size(), rt.new_int(1)))))
		if rt.is_true(rt.greater_equal(var_want, Class_ParagonIE_Sodium_Core_Poly1305.block_size())) {
			mut var_block := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(message_mutated), rt.new_int(0), var_want.dup())
			if rt.is_true(rt.greater_equal(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.strlen(arg_0) }(var_block.dup()), Class_ParagonIE_Sodium_Core_Poly1305.block_size())) {
				this.blocks(var_block.dup(), var_want.dup())
				message_mutated = (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.substr(arg_0, arg_1) }(rt.new_string(message_mutated), var_want.dup())).str()
				var_bytes = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.strlen(arg_0) }(rt.new_string(message_mutated))
			}
		}
	}
	if rt.is_true(var_bytes) {
		{
			mut var_i := rt.new_int(rt.new_int(0))
			for {
				if !(rt.is_true(rt.less(var_i, var_bytes))) { break }
				mut var_mi := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.chrtoint(arg_0) }(rt.new_string(message_mutated).array_get(var_i))
				this.buffer.array_set(rt.add(this.leftover, var_i), var_mi.dup())
				rt.pre_inc(var_i)
			}
		}
		this.leftover = rt.add(// unsupported expression: Expr_Cast_Int, var_bytes)
	}
	return rt.new_object('ParagonIE_Sodium_Core_Poly1305_State', []string{}, this)
}

fn (mut this Class_ParagonIE_Sodium_Core_Poly1305_State) blocks(var_message rt.PhpVal, var_bytes rt.PhpVal) rt.PhpVal {
	mut var_message_mutated := var_message
	mut var_bytes_mutated := var_bytes
	if rt.is_true(rt.less(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.strlen(arg_0) }(var_message_mutated.dup()), rt.new_int(16))) {
		var_message_mutated = rt.call_function('str_pad', [var_message_mutated.dup(), rt.new_int(16), rt.new_string(''), rt.get_constant('STR_PAD_RIGHT')])
	}
	mut var_hibit := rt.new_int(if rt.is_true(this.final) { rt.new_int(0) } else { 1 << 24 })
	mut var_r0 := // unsupported expression: Expr_Cast_Int
	mut var_r1 := // unsupported expression: Expr_Cast_Int
	mut var_r2 := // unsupported expression: Expr_Cast_Int
	mut var_r3 := // unsupported expression: Expr_Cast_Int
	mut var_r4 := // unsupported expression: Expr_Cast_Int
	mut var_s1 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.mul(arg_0, arg_1, arg_2) }(var_r1.dup(), rt.new_int(5), rt.new_int(3))
	mut var_s2 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.mul(arg_0, arg_1, arg_2) }(var_r2.dup(), rt.new_int(5), rt.new_int(3))
	mut var_s3 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.mul(arg_0, arg_1, arg_2) }(var_r3.dup(), rt.new_int(5), rt.new_int(3))
	mut var_s4 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.mul(arg_0, arg_1, arg_2) }(var_r4.dup(), rt.new_int(5), rt.new_int(3))
	mut var_h0 := this.h.array_get(0)
	mut var_h1 := this.h.array_get(1)
	mut var_h2 := this.h.array_get(2)
	mut var_h3 := this.h.array_get(3)
	mut var_h4 := this.h.array_get(4)
	for rt.is_true(rt.greater_equal(var_bytes_mutated, Class_ParagonIE_Sodium_Core_Poly1305.block_size())) {
		// unsupported expression: Expr_AssignOp_Plus
		// unsupported expression: Expr_AssignOp_Plus
		// unsupported expression: Expr_AssignOp_Plus
		// unsupported expression: Expr_AssignOp_Plus
		// unsupported expression: Expr_AssignOp_Plus
		mut var_d0 := rt.add(rt.add(rt.add(rt.add(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.mul(arg_0, arg_1, arg_2) }(var_h0.dup(), var_r0.dup(), rt.new_int(27)), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.mul(arg_0, arg_1, arg_2) }(var_s4.dup(), var_h1.dup(), rt.new_int(27))), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.mul(arg_0, arg_1, arg_2) }(var_s3.dup(), var_h2.dup(), rt.new_int(27))), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.mul(arg_0, arg_1, arg_2) }(var_s2.dup(), var_h3.dup(), rt.new_int(27))), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.mul(arg_0, arg_1, arg_2) }(var_s1.dup(), var_h4.dup(), rt.new_int(27)))
		mut var_d1 := rt.add(rt.add(rt.add(rt.add(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.mul(arg_0, arg_1, arg_2) }(var_h0.dup(), var_r1.dup(), rt.new_int(27)), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.mul(arg_0, arg_1, arg_2) }(var_h1.dup(), var_r0.dup(), rt.new_int(27))), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.mul(arg_0, arg_1, arg_2) }(var_s4.dup(), var_h2.dup(), rt.new_int(27))), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.mul(arg_0, arg_1, arg_2) }(var_s3.dup(), var_h3.dup(), rt.new_int(27))), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.mul(arg_0, arg_1, arg_2) }(var_s2.dup(), var_h4.dup(), rt.new_int(27)))
		mut var_d2 := rt.add(rt.add(rt.add(rt.add(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.mul(arg_0, arg_1, arg_2) }(var_h0.dup(), var_r2.dup(), rt.new_int(27)), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.mul(arg_0, arg_1, arg_2) }(var_h1.dup(), var_r1.dup(), rt.new_int(27))), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.mul(arg_0, arg_1, arg_2) }(var_h2.dup(), var_r0.dup(), rt.new_int(27))), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.mul(arg_0, arg_1, arg_2) }(var_s4.dup(), var_h3.dup(), rt.new_int(27))), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.mul(arg_0, arg_1, arg_2) }(var_s3.dup(), var_h4.dup(), rt.new_int(27)))
		mut var_d3 := rt.add(rt.add(rt.add(rt.add(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.mul(arg_0, arg_1, arg_2) }(var_h0.dup(), var_r3.dup(), rt.new_int(27)), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.mul(arg_0, arg_1, arg_2) }(var_h1.dup(), var_r2.dup(), rt.new_int(27))), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.mul(arg_0, arg_1, arg_2) }(var_h2.dup(), var_r1.dup(), rt.new_int(27))), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.mul(arg_0, arg_1, arg_2) }(var_h3.dup(), var_r0.dup(), rt.new_int(27))), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.mul(arg_0, arg_1, arg_2) }(var_s4.dup(), var_h4.dup(), rt.new_int(27)))
		mut var_d4 := rt.add(rt.add(rt.add(rt.add(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.mul(arg_0, arg_1, arg_2) }(var_h0.dup(), var_r4.dup(), rt.new_int(27)), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.mul(arg_0, arg_1, arg_2) }(var_h1.dup(), var_r3.dup(), rt.new_int(27))), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.mul(arg_0, arg_1, arg_2) }(var_h2.dup(), var_r2.dup(), rt.new_int(27))), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.mul(arg_0, arg_1, arg_2) }(var_h3.dup(), var_r1.dup(), rt.new_int(27))), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.mul(arg_0, arg_1, arg_2) }(var_h4.dup(), var_r0.dup(), rt.new_int(27)))
		mut var_c := rt.new_int(rt.shift_right(var_d0, rt.new_int(26)))
		var_h0 = rt.new_int(rt.bitwise_and(var_d0, rt.new_int(67108863)))
		// unsupported expression: Expr_AssignOp_Plus
		var_c = rt.new_int(rt.shift_right(var_d1, rt.new_int(26)))
		var_h1 = rt.new_int(rt.bitwise_and(var_d1, rt.new_int(67108863)))
		// unsupported expression: Expr_AssignOp_Plus
		var_c = rt.new_int(rt.shift_right(var_d2, rt.new_int(26)))
		var_h2 = rt.new_int(rt.bitwise_and(var_d2, rt.new_int(67108863)))
		// unsupported expression: Expr_AssignOp_Plus
		var_c = rt.new_int(rt.shift_right(var_d3, rt.new_int(26)))
		var_h3 = rt.new_int(rt.bitwise_and(var_d3, rt.new_int(67108863)))
		// unsupported expression: Expr_AssignOp_Plus
		var_c = rt.new_int(rt.shift_right(var_d4, rt.new_int(26)))
		var_h4 = rt.new_int(rt.bitwise_and(var_d4, rt.new_int(67108863)))
		// unsupported expression: Expr_AssignOp_Plus
		var_c = rt.new_int(rt.shift_right(var_h0, rt.new_int(26)))
		// unsupported expression: Expr_AssignOp_BitwiseAnd
		// unsupported expression: Expr_AssignOp_Plus
		var_message_mutated = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Poly1305_State{}; return temp.substr(arg_0, arg_1) }(var_message_mutated.dup(), Class_ParagonIE_Sodium_Core_Poly1305.block_size())
		// unsupported expression: Expr_AssignOp_Minus
	}
	this.h = rt.create_array([rt.ArrayItem{ key: none, val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: none, val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: none, val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: none, val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: none, val: // unsupported expression: Expr_Cast_Int }])
	return rt.new_object('ParagonIE_Sodium_Core_Poly1305_State', []string{}, this)
}

fn (mut this Class_ParagonIE_Sodium_Core_Poly1305_State) finish() string {
	if rt.is_true(this.leftover) {
		mut var_i := this.leftover
		.array_set(, )
		{
			for {
				if !(rt.is_true()) { break }
				
			}
		}
	}
	
}

struct Class_ParagonIE_Sodium_Core_Util {
	rt.PhpObjectBase
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_poly1305_state(key string) &Class_ParagonIE_Sodium_Core_Poly1305_State {
	mut obj := &Class_ParagonIE_Sodium_Core_Poly1305_State{
		PhpObjectBase: rt.PhpObjectBase{}
		buffer: rt.new_array()
		final: false
		h: rt.new_null()
		leftover: rt.new_int(0)
		r: rt.new_null()
		pad: rt.new_null()
	}
	obj.construct(key)
	return obj
}

fn create_paragonie_sodium_core_util() &Class_ParagonIE_Sodium_Core_Util {
	mut obj := &Class_ParagonIE_Sodium_Core_Util{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_invalidargumentexception() &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_Poly1305_State) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'__destruct' {
			this.magic_destruct()
			return rt.new_null()
		}
		'update' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.update(dispatch_arg_0)
		}
		'blocks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.blocks(dispatch_arg_0, dispatch_arg_1)
		}
		'finish' {
			return rt.new_string(this.finish())
		}
		else { return none }
	}
}

fn (this &Class_ParagonIE_Sodium_Core_Poly1305_State) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'buffer' { return this.buffer }
		'final' { return rt.new_bool(this.final) }
		'h' { return this.h }
		'leftover' { return this.leftover }
		'r' { return this.r }
		'pad' { return this.pad }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ParagonIE_Sodium_Core_Poly1305_State) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'buffer' { this.buffer = val; return true }
		'final' { this.final = (val).to_bool(); return true }
		'h' { this.h = val; return true }
		'leftover' { this.leftover = val; return true }
		'r' { this.r = val; return true }
		'pad' { this.pad = val; return true }
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


fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_sodium_compat_src_core_poly1305_state_php() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_Core_Poly1305_State'), rt.new_bool(false)])) {
		return rt.new_null()
	}
}
