import rt

struct Class_ParagonIE_Sodium_Core_AES_Block {
	rt.PhpObjectBase
pub mut:
	values rt.PhpVal = rt.new_array()
	size   rt.PhpVal = rt.new_null()
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_Block) construct(size i64) {
	this.Class_SplFixedArray.construct(rt.new_int(size))
	this.size = rt.new_int(size)
	this.values = rt.call_function('array_fill', [rt.new_int(0),
		rt.new_int(size), rt.new_int(0)])
}

fn Class_ParagonIE_Sodium_Core_AES_Block.init() rt.PhpVal {
	return rt.new_object('ParagonIE_Sodium_Core_AES_Block', ['SplFixedArray'],
		create_paragonie_sodium_core_aes_block(rt.new_int(8)))
}

fn Class_ParagonIE_Sodium_Core_AES_Block.fromarray(var_array rt.PhpVal, var_save_indexes rt.PhpVal) rt.PhpVal {
	mut var_array_mutated := var_array
	mut var_count := rt.new_int(var_array_mutated.clone().array_count())
	if rt.is_true(var_save_indexes) {
		mut var_keys := rt.func_array_keys(var_array_mutated.clone())
	} else {
		var_keys = rt.call_function('range', [rt.new_int(0), rt.sub(var_count, rt.new_int(1))])
	}
	var_array_mutated = rt.call_function('array_values', [var_array_mutated.clone()])
	mut var_obj := create_paragonie_sodium_core_aes_block(0)
	if rt.is_true(var_save_indexes) {
		mut var_i := rt.new_int(0)
		for {
			if !(rt.is_true(rt.less(var_i, var_count))) { break
			 }
			var_obj.offsetset(var_keys.array_get(var_i), var_array_mutated.array_get(var_i))
			rt.pre_inc(var_i)
		}
	} else {
		var_i = rt.new_int(0)
		for {
			if !(rt.is_true(rt.less(var_i, var_count))) { break
			 }
			var_obj.offsetset(var_i.clone(), var_array_mutated.array_get(var_i))
			rt.pre_inc(var_i)
		}
	}
	return mut var_obj
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_Block) offsetset(var_offset rt.PhpVal, var_value rt.PhpVal) {
	if !(var_value.clone().is_long()) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{},
			create_invalidargumentexception(rt.new_string('Expected an integer'))))
	}
	if rt.is_true(rt.new_bool(var_offset.clone().is_null())) {
		this.values.array_push(var_value.clone())
	} else {
		this.values.array_set(var_offset, var_value.clone())
	}
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_Block) offsetexists(var_offset rt.PhpVal) rt.PhpVal {
	return rt.new_bool(this.values.array_isset(var_offset))
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_Block) offsetunset(var_offset rt.PhpVal) {
	this.values.array_unset(var_offset)
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_Block) offsetget(var_offset rt.PhpVal) i64 {
	if !(this.values.array_isset(var_offset)) {
		this.values.array_set(var_offset, 0)
	}
	return rt.new_int((this.values.array_get(var_offset)).to_i64())
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_Block) magic_debuginfo() rt.PhpVal {
	mut var_out := []rt.PhpVal{}
	mut iter_1 := this.values.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_v := item_1.val
		var_out << rt.call_function('str_pad', [
			rt.call_function('dechex', [var_v.clone()]),
			rt.new_int(8),
			rt.new_string('0'),
			rt.get_constant('STR_PAD_LEFT'),
		])
	}
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('implode', [
			rt.new_string(', '), rt.create_array_from_list(var_out)]) },
	])
	return rt.new_null()
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_Block) swapn(var_cl rt.PhpVal, var_ch rt.PhpVal, var_s rt.PhpVal, var_x rt.PhpVal, var_y rt.PhpVal) rt.PhpVal {
	mut var_u32mask := rt.new_null()
	mut var_x_mutated := var_x
	mut var_a := rt.new_int(rt.bitwise_and(this.values.array_get(var_x_mutated), var_u32mask))
	mut var_b := rt.new_int(rt.bitwise_and(this.values.array_get(var_y), var_u32mask))
	this.values.array_set(var_x_mutated, rt.bitwise_and(var_a, var_cl) | rt.bitwise_and(rt.shift_left(rt.bitwise_and(var_b,
		var_cl), var_s), var_u32mask))
	this.values.array_set(var_y, rt.shift_right(rt.bitwise_and(rt.bitwise_and(var_a, var_ch),
		var_u32mask), var_s) | rt.bitwise_and(var_b, var_ch))
	return rt.new_object('ParagonIE_Sodium_Core_AES_Block', []string{}, this)
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_Block) swap2(var_x rt.PhpVal, var_y rt.PhpVal) rt.PhpVal {
	mut var_x_mutated := var_x
	return this.swapn(rt.new_int(1431655765), rt.new_int(2863311530), rt.new_int(1),
		var_x_mutated.clone(), var_y.clone())
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_Block) swap4(var_x rt.PhpVal, var_y rt.PhpVal) rt.PhpVal {
	mut var_x_mutated := var_x
	return this.swapn(rt.new_int(858993459), rt.new_int(3435973836), rt.new_int(2),
		var_x_mutated.clone(), var_y.clone())
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_Block) swap8(var_x rt.PhpVal, var_y rt.PhpVal) rt.PhpVal {
	mut var_x_mutated := var_x
	return this.swapn(rt.new_int(252645135), rt.new_int(4042322160), rt.new_int(4),
		var_x_mutated.clone(), var_y.clone())
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_Block) orthogonalize() rt.PhpVal {
	return rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(this.swap2(rt.new_int(0),
		rt.new_int(1)), 'swap2', [rt.new_int(2), rt.new_int(3)]), 'swap2', [
		rt.new_int(4),
		rt.new_int(5),
	]), 'swap2', [rt.new_int(6), rt.new_int(7)]), 'swap4', [rt.new_int(0),
		rt.new_int(2)]), 'swap4', [rt.new_int(1), rt.new_int(3)]), 'swap4', [
		rt.new_int(4),
		rt.new_int(6),
	]), 'swap4', [rt.new_int(5), rt.new_int(7)]), 'swap8', [rt.new_int(0),
		rt.new_int(4)]), 'swap8', [rt.new_int(1), rt.new_int(5)]), 'swap8', [
		rt.new_int(2),
		rt.new_int(6),
	]), 'swap8', [rt.new_int(3), rt.new_int(7)])
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_Block) shiftrows() rt.PhpVal {
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(8)))) { break
		 }
		mut var_x := rt.new_int(rt.bitwise_and(this.values.array_get(var_i),
			Class_ParagonIE_Sodium_Core_Util.u32_max()))
		this.values.array_set(var_i, rt.bitwise_and(rt.bitwise_and(var_x, rt.new_int(255)) | rt.bitwise_and(var_x,
			rt.new_int(64512)) >> 2 | rt.bitwise_and(var_x, rt.new_int(768)) << 6 | rt.bitwise_and(var_x,
			rt.new_int(15728640)) >> 4 | rt.bitwise_and(var_x, rt.new_int(983040)) << 4 | rt.bitwise_and(var_x,
			rt.new_int(3221225472)) >> 6 | rt.bitwise_and(var_x, rt.new_int(1056964608)) << 2,
			Class_ParagonIE_Sodium_Core_Util.u32_max()))
		rt.pre_inc(var_i)
	}
	return rt.new_object('ParagonIE_Sodium_Core_AES_Block', []string{}, this)
}

fn Class_ParagonIE_Sodium_Core_AES_Block.rotr16(var_x rt.PhpVal) i64 {
	mut var_x_mutated := var_x
	return rt.bitwise_and(rt.shift_left(var_x_mutated, rt.new_int(16)),
		Class_ParagonIE_Sodium_Core_Util.u32_max()) | rt.shift_right(var_x_mutated, rt.new_int(16))
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_Block) mixcolumns() rt.PhpVal {
	mut var_q0 := this.values.array_get(rt.new_int(0))
	mut var_q1 := this.values.array_get(rt.new_int(1))
	mut var_q2 := this.values.array_get(rt.new_int(2))
	mut var_q3 := this.values.array_get(rt.new_int(3))
	mut var_q4 := this.values.array_get(rt.new_int(4))
	mut var_q5 := this.values.array_get(rt.new_int(5))
	mut var_q6 := this.values.array_get(rt.new_int(6))
	mut var_q7 := this.values.array_get(rt.new_int(7))
	mut var_r0 := rt.new_int(rt.bitwise_and(rt.shift_right(var_q0, rt.new_int(8)) | rt.shift_left(var_q0,
		rt.new_int(24)), Class_ParagonIE_Sodium_Core_Util.u32_max()))
	mut var_r1 := rt.new_int(rt.bitwise_and(rt.shift_right(var_q1, rt.new_int(8)) | rt.shift_left(var_q1,
		rt.new_int(24)), Class_ParagonIE_Sodium_Core_Util.u32_max()))
	mut var_r2 := rt.new_int(rt.bitwise_and(rt.shift_right(var_q2, rt.new_int(8)) | rt.shift_left(var_q2,
		rt.new_int(24)), Class_ParagonIE_Sodium_Core_Util.u32_max()))
	mut var_r3 := rt.new_int(rt.bitwise_and(rt.shift_right(var_q3, rt.new_int(8)) | rt.shift_left(var_q3,
		rt.new_int(24)), Class_ParagonIE_Sodium_Core_Util.u32_max()))
	mut var_r4 := rt.new_int(rt.bitwise_and(rt.shift_right(var_q4, rt.new_int(8)) | rt.shift_left(var_q4,
		rt.new_int(24)), Class_ParagonIE_Sodium_Core_Util.u32_max()))
	mut var_r5 := rt.new_int(rt.bitwise_and(rt.shift_right(var_q5, rt.new_int(8)) | rt.shift_left(var_q5,
		rt.new_int(24)), Class_ParagonIE_Sodium_Core_Util.u32_max()))
	mut var_r6 := rt.new_int(rt.bitwise_and(rt.shift_right(var_q6, rt.new_int(8)) | rt.shift_left(var_q6,
		rt.new_int(24)), Class_ParagonIE_Sodium_Core_Util.u32_max()))
	mut var_r7 := rt.new_int(rt.bitwise_and(rt.shift_right(var_q7, rt.new_int(8)) | rt.shift_left(var_q7,
		rt.new_int(24)), Class_ParagonIE_Sodium_Core_Util.u32_max()))
	this.values.array_set(0, rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(var_q7, var_r7), var_r0), Class_ParagonIE_Sodium_Core_AES_Block.rotr16(rt.new_int(rt.bitwise_xor(var_q0,
		var_r0)))))
	this.values.array_set(1, rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(var_q0,
		var_r0), var_q7), var_r7), var_r1), Class_ParagonIE_Sodium_Core_AES_Block.rotr16(rt.new_int(rt.bitwise_xor(var_q1,
		var_r1)))))
	this.values.array_set(2, rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(var_q1, var_r1), var_r2), Class_ParagonIE_Sodium_Core_AES_Block.rotr16(rt.new_int(rt.bitwise_xor(var_q2,
		var_r2)))))
	this.values.array_set(3, rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(var_q2,
		var_r2), var_q7), var_r7), var_r3), Class_ParagonIE_Sodium_Core_AES_Block.rotr16(rt.new_int(rt.bitwise_xor(var_q3,
		var_r3)))))
	this.values.array_set(4, rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(var_q3,
		var_r3), var_q7), var_r7), var_r4), Class_ParagonIE_Sodium_Core_AES_Block.rotr16(rt.new_int(rt.bitwise_xor(var_q4,
		var_r4)))))
	this.values.array_set(5, rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(var_q4, var_r4), var_r5), Class_ParagonIE_Sodium_Core_AES_Block.rotr16(rt.new_int(rt.bitwise_xor(var_q5,
		var_r5)))))
	this.values.array_set(6, rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(var_q5, var_r5), var_r6), Class_ParagonIE_Sodium_Core_AES_Block.rotr16(rt.new_int(rt.bitwise_xor(var_q6,
		var_r6)))))
	this.values.array_set(7, rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(var_q6, var_r6), var_r7), Class_ParagonIE_Sodium_Core_AES_Block.rotr16(rt.new_int(rt.bitwise_xor(var_q7,
		var_r7)))))
	return rt.new_object('ParagonIE_Sodium_Core_AES_Block', []string{}, this)
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_Block) inversemixcolumns() rt.PhpVal {
	mut var_q0 := this.values.array_get(rt.new_int(0))
	mut var_q1 := this.values.array_get(rt.new_int(1))
	mut var_q2 := this.values.array_get(rt.new_int(2))
	mut var_q3 := this.values.array_get(rt.new_int(3))
	mut var_q4 := this.values.array_get(rt.new_int(4))
	mut var_q5 := this.values.array_get(rt.new_int(5))
	mut var_q6 := this.values.array_get(rt.new_int(6))
	mut var_q7 := this.values.array_get(rt.new_int(7))
	mut var_r0 := rt.new_int(rt.bitwise_and(rt.shift_right(var_q0, rt.new_int(8)) | rt.shift_left(var_q0,
		rt.new_int(24)), Class_ParagonIE_Sodium_Core_Util.u32_max()))
	mut var_r1 := rt.new_int(rt.bitwise_and(rt.shift_right(var_q1, rt.new_int(8)) | rt.shift_left(var_q1,
		rt.new_int(24)), Class_ParagonIE_Sodium_Core_Util.u32_max()))
	mut var_r2 := rt.new_int(rt.bitwise_and(rt.shift_right(var_q2, rt.new_int(8)) | rt.shift_left(var_q2,
		rt.new_int(24)), Class_ParagonIE_Sodium_Core_Util.u32_max()))
	mut var_r3 := rt.new_int(rt.bitwise_and(rt.shift_right(var_q3, rt.new_int(8)) | rt.shift_left(var_q3,
		rt.new_int(24)), Class_ParagonIE_Sodium_Core_Util.u32_max()))
	mut var_r4 := rt.new_int(rt.bitwise_and(rt.shift_right(var_q4, rt.new_int(8)) | rt.shift_left(var_q4,
		rt.new_int(24)), Class_ParagonIE_Sodium_Core_Util.u32_max()))
	mut var_r5 := rt.new_int(rt.bitwise_and(rt.shift_right(var_q5, rt.new_int(8)) | rt.shift_left(var_q5,
		rt.new_int(24)), Class_ParagonIE_Sodium_Core_Util.u32_max()))
	mut var_r6 := rt.new_int(rt.bitwise_and(rt.shift_right(var_q6, rt.new_int(8)) | rt.shift_left(var_q6,
		rt.new_int(24)), Class_ParagonIE_Sodium_Core_Util.u32_max()))
	mut var_r7 := rt.new_int(rt.bitwise_and(rt.shift_right(var_q7, rt.new_int(8)) | rt.shift_left(var_q7,
		rt.new_int(24)), Class_ParagonIE_Sodium_Core_Util.u32_max()))
	this.values.array_set(0, rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(var_q5,
		var_q6), var_q7), var_r0), var_r5), var_r7), Class_ParagonIE_Sodium_Core_AES_Block.rotr16(rt.new_int(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(var_q0,
		var_q5), var_q6), var_r0), var_r5)))))
	this.values.array_set(1, rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(var_q0,
		var_q5), var_r0), var_r1), var_r5), var_r6), var_r7), Class_ParagonIE_Sodium_Core_AES_Block.rotr16(rt.new_int(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(var_q1,
		var_q5), var_q7), var_r1), var_r5), var_r6)))))
	this.values.array_set(2, rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(var_q0,
		var_q1), var_q6), var_r1), var_r2), var_r6), var_r7), Class_ParagonIE_Sodium_Core_AES_Block.rotr16(rt.new_int(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(var_q0,
		var_q2), var_q6), var_r2), var_r6), var_r7)))))
	this.values.array_set(3, rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(var_q0,
		var_q1), var_q2), var_q5), var_q6), var_r0), var_r2), var_r3), var_r5), Class_ParagonIE_Sodium_Core_AES_Block.rotr16(rt.new_int(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(var_q0,
		var_q1), var_q3), var_q5), var_q6), var_q7), var_r0), var_r3), var_r5), var_r7)))))
	this.values.array_set(4, rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(var_q1,
		var_q2), var_q3), var_q5), var_r1), var_r3), var_r4), var_r5), var_r6), var_r7), Class_ParagonIE_Sodium_Core_AES_Block.rotr16(rt.new_int(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(var_q1,
		var_q2), var_q4), var_q5), var_q7), var_r1), var_r4), var_r5), var_r6)))))
	this.values.array_set(5, rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(var_q2,
		var_q3), var_q4), var_q6), var_r2), var_r4), var_r5), var_r6), var_r7), Class_ParagonIE_Sodium_Core_AES_Block.rotr16(rt.new_int(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(var_q2,
		var_q3), var_q5), var_q6), var_r2), var_r5), var_r6), var_r7)))))
	this.values.array_set(6, rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(var_q3,
		var_q4), var_q5), var_q7), var_r3), var_r5), var_r6), var_r7), Class_ParagonIE_Sodium_Core_AES_Block.rotr16(rt.new_int(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(var_q3,
		var_q4), var_q6), var_q7), var_r3), var_r6), var_r7)))))
	this.values.array_set(7, rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(var_q4,
		var_q5), var_q6), var_r4), var_r6), var_r7), Class_ParagonIE_Sodium_Core_AES_Block.rotr16(rt.new_int(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(var_q4,
		var_q5), var_q7), var_r4), var_r7)))))
	return rt.new_object('ParagonIE_Sodium_Core_AES_Block', []string{}, this)
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_Block) inverseshiftrows() rt.PhpVal {
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(8)))) { break
		 }
		mut var_x := this.values.array_get(var_i)
		this.values.array_set(var_i, rt.bitwise_and(Class_ParagonIE_Sodium_Core_Util.u32_max(), rt.bitwise_and(var_x,
			rt.new_int(255)) | rt.bitwise_and(var_x, rt.new_int(16128)) << 2 | rt.bitwise_and(var_x,
			rt.new_int(49152)) >> 6 | rt.bitwise_and(var_x, rt.new_int(983040)) << 4 | rt.bitwise_and(var_x,
			rt.new_int(15728640)) >> 4 | rt.bitwise_and(var_x, rt.new_int(50331648)) << 6 | rt.bitwise_and(var_x,
			rt.new_int(4227858432)) >> 2))
		rt.pre_inc(var_i)
	}
	return rt.new_object('ParagonIE_Sodium_Core_AES_Block', []string{}, this)
}

struct Class_SplFixedArray {
	rt.PhpObjectBase
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_aes_block(size i64) &Class_ParagonIE_Sodium_Core_AES_Block {
	mut obj := &Class_ParagonIE_Sodium_Core_AES_Block{
		PhpObjectBase: rt.PhpObjectBase{}
		values:        rt.new_array()
		size:          rt.new_null()
	}
	obj.construct(size)
	return obj
}

fn create_splfixedarray(_args ...rt.PhpVal) &Class_SplFixedArray {
	mut obj := &Class_SplFixedArray{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_invalidargumentexception(_args ...rt.PhpVal) &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_Block) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'init' {
			return Class_ParagonIE_Sodium_Core_AES_Block.init()
		}
		'fromArray' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_AES_Block.fromarray(dispatch_arg_0, dispatch_arg_1)
		}
		'offsetSet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.offsetset(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'offsetExists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.offsetexists(dispatch_arg_0)
		}
		'offsetUnset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.offsetunset(dispatch_arg_0)
			return rt.new_null()
		}
		'offsetGet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.offsetget(dispatch_arg_0))
		}
		'__debugInfo' {
			return this.magic_debuginfo()
		}
		'swapN' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return this.swapn(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3,
				dispatch_arg_4)
		}
		'swap2' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.swap2(dispatch_arg_0, dispatch_arg_1)
		}
		'swap4' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.swap4(dispatch_arg_0, dispatch_arg_1)
		}
		'swap8' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.swap8(dispatch_arg_0, dispatch_arg_1)
		}
		'orthogonalize' {
			return this.orthogonalize()
		}
		'shiftRows' {
			return this.shiftrows()
		}
		'rotr16' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(Class_ParagonIE_Sodium_Core_AES_Block.rotr16(dispatch_arg_0))
		}
		'mixColumns' {
			return this.mixcolumns()
		}
		'inverseMixColumns' {
			return this.inversemixcolumns()
		}
		'inverseShiftRows' {
			return this.inverseshiftrows()
		}
		else {
			return none
		}
	}
}

fn (this &Class_ParagonIE_Sodium_Core_AES_Block) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'values' { return this.values }
		'size' { return this.size }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_Block) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'values' {
			this.values = val
			return true
		}
		'size' {
			this.size = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core_AES_Block'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}
