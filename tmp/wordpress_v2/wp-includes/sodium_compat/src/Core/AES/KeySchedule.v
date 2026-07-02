import rt

struct Class_ParagonIE_Sodium_Core_AES_KeySchedule {
	rt.PhpObjectBase
pub mut:
	skey      rt.PhpVal = rt.new_null()
	expanded  rt.PhpVal = rt.new_bool(false)
	numRounds rt.PhpVal = rt.new_null()
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_KeySchedule) construct(mut var_skey Class_array, numRounds i64) {
	this.skey = var_skey
	this.numRounds = rt.new_int(numRounds)
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_KeySchedule) get(var_i rt.PhpVal) rt.PhpVal {
	return this.skey.array_get(var_i)
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_KeySchedule) getnumrounds() rt.PhpVal {
	return this.numRounds
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_KeySchedule) getroundkey(var_offset rt.PhpVal) rt.PhpVal {
	mut iife_temp_0 := Class_ParagonIE_Sodium_Core_AES_Block{}
	mut iife_result_0 := iife_temp_0.fromarray(rt.call_function('array_slice', [this.skey,
		var_offset.clone(), rt.new_int(8)]))
	return iife_result_0
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_KeySchedule) expand() rt.PhpVal {
	mut var_exp := create_paragonie_sodium_core_aes_expanded(rt.call_function('array_fill', [
		rt.new_int(0),
		rt.new_int(120),
		rt.new_int(0),
	]), this.numRounds)
	mut var_n := rt.new_int(rt.shift_left(rt.add(rt.get_property(var_exp, 'numRounds'),
		rt.new_int(1)), rt.new_int(2)))
	mut var_u := rt.new_int(0)
	mut var_v := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_u, var_n))) { break
		 }
		mut var_y := this.skey.array_get(var_u)
		mut var_x := var_y
		rt.new_null()
		rt.get_property(var_exp, 'skey').array_set(var_v, rt.bitwise_and(rt.bitwise_or(var_x, rt.shift_left(var_x,
			rt.new_int(1))), Class_ParagonIE_Sodium_Core_Util.u32_max()))
		rt.new_null()
		rt.get_property(var_exp, 'skey').array_set(rt.add(var_v, rt.new_int(1)), rt.bitwise_and(rt.bitwise_or(var_y, rt.shift_right(var_y,
			rt.new_int(1))), Class_ParagonIE_Sodium_Core_Util.u32_max()))
		rt.pre_inc(var_u)
		var_v = rt.add(var_v, rt.new_int(2))
	}
	return mut var_exp
}

struct Class_ParagonIE_Sodium_Core_AES_Block {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core_AES_Expanded {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_aes_keyschedule(arg_0 rt.PhpVal, numRounds i64) &Class_ParagonIE_Sodium_Core_AES_KeySchedule {
	mut obj := &Class_ParagonIE_Sodium_Core_AES_KeySchedule{
		PhpObjectBase: rt.PhpObjectBase{}
		skey:          rt.new_null()
		expanded:      rt.new_bool(false)
		numRounds:     rt.new_null()
	}
	obj.construct(arg_0, numRounds)
	return obj
}

fn create_paragonie_sodium_core_aes_block(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_AES_Block {
	mut obj := &Class_ParagonIE_Sodium_Core_AES_Block{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_aes_expanded(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_AES_Expanded {
	mut obj := &Class_ParagonIE_Sodium_Core_AES_Expanded{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_KeySchedule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			this.construct(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get(dispatch_arg_0)
		}
		'getNumRounds' {
			return this.getnumrounds()
		}
		'getRoundKey' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.getroundkey(dispatch_arg_0)
		}
		'expand' {
			return this.expand()
		}
		else {
			return none
		}
	}
}

fn (this &Class_ParagonIE_Sodium_Core_AES_KeySchedule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'skey' { return this.skey }
		'expanded' { return this.expanded }
		'numRounds' { return this.numRounds }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_KeySchedule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'skey' {
			this.skey = val
			return true
		}
		'expanded' {
			this.expanded = val
			return true
		}
		'numRounds' {
			this.numRounds = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_Block) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_AES_Block) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_Block) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_Expanded) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_AES_Expanded) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_Expanded) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core_AES_KeySchedule'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}
