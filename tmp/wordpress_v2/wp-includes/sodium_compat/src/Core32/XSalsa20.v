import rt

struct Class_ParagonIE_Sodium_Core32_XSalsa20 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core32_XSalsa20.xsalsa20(var_len rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_0 := Class_ParagonIE_Sodium_Core32_XSalsa20{}
	mut iife_result_0 := iife_temp_0.substr(var_nonce.clone(), rt.new_int(16), rt.new_int(8))
	mut iife_temp_1 := Class_ParagonIE_Sodium_Core32_XSalsa20{}
	mut iife_result_1 := iife_temp_1.hsalsa20(var_nonce.clone(), var_key.clone())
	mut iife_temp_2 := Class_ParagonIE_Sodium_Core32_XSalsa20{}
	mut iife_result_2 := iife_temp_2.salsa20(var_len.clone(), iife_result_0, iife_result_1)
	mut var_ret := iife_result_2
	return var_ret.clone()
}

fn Class_ParagonIE_Sodium_Core32_XSalsa20.xsalsa20_xor(var_message rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_3 := Class_ParagonIE_Sodium_Core32_XSalsa20{}
	mut iife_result_3 := iife_temp_3.strlen(var_message.clone())
	mut iife_temp_4 := Class_ParagonIE_Sodium_Core32_XSalsa20{}
	mut iife_result_4 := iife_temp_4.xorstrings(var_message.clone(), Class_ParagonIE_Sodium_Core32_XSalsa20.xsalsa20(iife_result_3,
		var_nonce.clone(), var_key.clone()))
	return iife_result_4
}

struct Class_ParagonIE_Sodium_Core32_HSalsa20 {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core32_xsalsa20(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_XSalsa20 {
	mut obj := &Class_ParagonIE_Sodium_Core32_XSalsa20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_hsalsa20(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_HSalsa20 {
	mut obj := &Class_ParagonIE_Sodium_Core32_HSalsa20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core32_XSalsa20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'xsalsa20' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_XSalsa20.xsalsa20(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'xsalsa20_xor' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_XSalsa20.xsalsa20_xor(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_ParagonIE_Sodium_Core32_XSalsa20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_XSalsa20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core32_HSalsa20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_HSalsa20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_HSalsa20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core32_XSalsa20'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}
