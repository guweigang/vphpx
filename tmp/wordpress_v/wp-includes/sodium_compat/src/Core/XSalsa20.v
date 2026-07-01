import rt

struct Class_ParagonIE_Sodium_Core_XSalsa20 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core_XSalsa20.xsalsa20(var_len rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut var_ret := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_XSalsa20{}
		return temp.salsa20(arg_0, arg_1, arg_2)
	}(var_len.dup(), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_XSalsa20{}
		return temp.substr(arg_0, arg_1, arg_2)
	}(var_nonce.dup(), rt.new_int(16), rt.new_int(8)), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_XSalsa20{}
		return temp.hsalsa20(arg_0, arg_1)
	}(var_nonce.dup(), var_key.dup()))
	return var_ret.dup()
}

fn Class_ParagonIE_Sodium_Core_XSalsa20.xsalsa20_xor(var_message rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_XSalsa20{}
		return temp.xorstrings(arg_0, arg_1)
	}(var_message.dup(), Class_ParagonIE_Sodium_Core_XSalsa20.xsalsa20(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_XSalsa20{}
		return temp.strlen(arg_0)
	}(var_message.dup()), var_nonce.dup(), var_key.dup()))
}

struct Class_ParagonIE_Sodium_Core_HSalsa20 {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_xsalsa20() &Class_ParagonIE_Sodium_Core_XSalsa20 {
	mut obj := &Class_ParagonIE_Sodium_Core_XSalsa20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_hsalsa20() &Class_ParagonIE_Sodium_Core_HSalsa20 {
	mut obj := &Class_ParagonIE_Sodium_Core_HSalsa20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_XSalsa20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'xsalsa20' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_XSalsa20.xsalsa20(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'xsalsa20_xor' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_XSalsa20.xsalsa20_xor(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_ParagonIE_Sodium_Core_XSalsa20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_XSalsa20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core_HSalsa20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_HSalsa20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_HSalsa20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_sodium_compat_src_core_xsalsa20_php() {
	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core_XSalsa20'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}
