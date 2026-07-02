import rt

struct Class_ParagonIE_Sodium_Core_HSalsa20 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core_HSalsa20.hsalsa20(var_in rt.PhpVal, var_k rt.PhpVal, var_c rt.PhpVal) string {
	if rt.is_true(rt.identical(var_c, rt.new_null())) {
		mut var_x0 := rt.new_int(1634760805)
		mut var_x5 := rt.new_int(857760878)
		mut var_x10 := rt.new_int(2036477234)
		mut var_x15 := rt.new_int(1797285236)
	} else {
		mut iife_temp_0 := Class_ParagonIE_Sodium_Core_HSalsa20{}
		mut iife_result_0 := iife_temp_0.substr(var_c.clone(), rt.new_int(0), rt.new_int(4))
		mut iife_temp_1 := Class_ParagonIE_Sodium_Core_HSalsa20{}
		mut iife_result_1 := iife_temp_1.load_4(iife_result_0)
		var_x0 = iife_result_1
		mut iife_temp_2 := Class_ParagonIE_Sodium_Core_HSalsa20{}
		mut iife_result_2 := iife_temp_2.substr(var_c.clone(), rt.new_int(4), rt.new_int(4))
		mut iife_temp_3 := Class_ParagonIE_Sodium_Core_HSalsa20{}
		mut iife_result_3 := iife_temp_3.load_4(iife_result_2)
		var_x5 = iife_result_3
		mut iife_temp_4 := Class_ParagonIE_Sodium_Core_HSalsa20{}
		mut iife_result_4 := iife_temp_4.substr(var_c.clone(), rt.new_int(8), rt.new_int(4))
		mut iife_temp_5 := Class_ParagonIE_Sodium_Core_HSalsa20{}
		mut iife_result_5 := iife_temp_5.load_4(iife_result_4)
		var_x10 = iife_result_5
		mut iife_temp_6 := Class_ParagonIE_Sodium_Core_HSalsa20{}
		mut iife_result_6 := iife_temp_6.substr(var_c.clone(), rt.new_int(12), rt.new_int(4))
		mut iife_temp_7 := Class_ParagonIE_Sodium_Core_HSalsa20{}
		mut iife_result_7 := iife_temp_7.load_4(iife_result_6)
		var_x15 = iife_result_7
	}
	mut iife_temp_8 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_8 := iife_temp_8.substr(var_k.clone(), rt.new_int(0), rt.new_int(4))
	mut iife_temp_9 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_9 := iife_temp_9.load_4(iife_result_8)
	mut var_x1 := iife_result_9
	mut iife_temp_10 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_10 := iife_temp_10.substr(var_k.clone(), rt.new_int(4), rt.new_int(4))
	mut iife_temp_11 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_11 := iife_temp_11.load_4(iife_result_10)
	mut var_x2 := iife_result_11
	mut iife_temp_12 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_12 := iife_temp_12.substr(var_k.clone(), rt.new_int(8), rt.new_int(4))
	mut iife_temp_13 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_13 := iife_temp_13.load_4(iife_result_12)
	mut var_x3 := iife_result_13
	mut iife_temp_14 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_14 := iife_temp_14.substr(var_k.clone(), rt.new_int(12), rt.new_int(4))
	mut iife_temp_15 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_15 := iife_temp_15.load_4(iife_result_14)
	mut var_x4 := iife_result_15
	mut iife_temp_16 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_16 := iife_temp_16.substr(var_k.clone(), rt.new_int(16), rt.new_int(4))
	mut iife_temp_17 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_17 := iife_temp_17.load_4(iife_result_16)
	mut var_x11 := iife_result_17
	mut iife_temp_18 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_18 := iife_temp_18.substr(var_k.clone(), rt.new_int(20), rt.new_int(4))
	mut iife_temp_19 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_19 := iife_temp_19.load_4(iife_result_18)
	mut var_x12 := iife_result_19
	mut iife_temp_20 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_20 := iife_temp_20.substr(var_k.clone(), rt.new_int(24), rt.new_int(4))
	mut iife_temp_21 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_21 := iife_temp_21.load_4(iife_result_20)
	mut var_x13 := iife_result_21
	mut iife_temp_22 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_22 := iife_temp_22.substr(var_k.clone(), rt.new_int(28), rt.new_int(4))
	mut iife_temp_23 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_23 := iife_temp_23.load_4(iife_result_22)
	mut var_x14 := iife_result_23
	mut iife_temp_24 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_24 := iife_temp_24.substr(var_in.clone(), rt.new_int(0), rt.new_int(4))
	mut iife_temp_25 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_25 := iife_temp_25.load_4(iife_result_24)
	mut var_x6 := iife_result_25
	mut iife_temp_26 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_26 := iife_temp_26.substr(var_in.clone(), rt.new_int(4), rt.new_int(4))
	mut iife_temp_27 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_27 := iife_temp_27.load_4(iife_result_26)
	mut var_x7 := iife_result_27
	mut iife_temp_28 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_28 := iife_temp_28.substr(var_in.clone(), rt.new_int(8), rt.new_int(4))
	mut iife_temp_29 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_29 := iife_temp_29.load_4(iife_result_28)
	mut var_x8 := iife_result_29
	mut iife_temp_30 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_30 := iife_temp_30.substr(var_in.clone(), rt.new_int(12), rt.new_int(4))
	mut iife_temp_31 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_31 := iife_temp_31.load_4(iife_result_30)
	mut var_x9 := iife_result_31
	mut var_i := Class_ParagonIE_Sodium_Core_HSalsa20.rounds()
	for {
		if !(rt.is_true(rt.greater(var_i, rt.new_int(0)))) { break
		 }
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
		var_i = rt.sub(var_i, rt.new_int(2))
	}
	mut iife_temp_32 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_32 := iife_temp_32.store32_le(var_x0.clone())
	mut iife_temp_33 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_33 := iife_temp_33.store32_le(var_x5.clone())
	mut iife_temp_34 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_34 := iife_temp_34.store32_le(var_x10.clone())
	mut iife_temp_35 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_35 := iife_temp_35.store32_le(var_x15.clone())
	mut iife_temp_36 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_36 := iife_temp_36.store32_le(var_x6.clone())
	mut iife_temp_37 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_37 := iife_temp_37.store32_le(var_x7.clone())
	mut iife_temp_38 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_38 := iife_temp_38.store32_le(var_x8.clone())
	mut iife_temp_39 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_39 := iife_temp_39.store32_le(var_x9.clone())
	return iife_result_32.str() + iife_result_33.str() + iife_result_34.str() +
		iife_result_35.str() + iife_result_36.str() + iife_result_37.str() + iife_result_38.str() +
		iife_result_39.str()
}

struct Class_ParagonIE_Sodium_Core_Salsa20 {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_hsalsa20(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_HSalsa20 {
	mut obj := &Class_ParagonIE_Sodium_Core_HSalsa20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_salsa20(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_Salsa20 {
	mut obj := &Class_ParagonIE_Sodium_Core_Salsa20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_HSalsa20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'hsalsa20' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(Class_ParagonIE_Sodium_Core_HSalsa20.hsalsa20(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2))
		}
		else {
			return none
		}
	}
}

fn (this &Class_ParagonIE_Sodium_Core_HSalsa20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_HSalsa20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core_Salsa20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_Salsa20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Salsa20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core_HSalsa20'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}
