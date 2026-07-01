import rt

pub fn Class_ParagonIE_Sodium_Core32_Poly1305.block_size() i64 {
	return 16
}

struct Class_ParagonIE_Sodium_Core32_Poly1305 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core32_Poly1305.onetimeauth(var_m rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.less(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_Poly1305{}
		return temp.strlen(arg_0)
	}(var_key.dup()), rt.new_int(32)))
	{
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{},
			create_invalidargumentexception(rt.new_string('Key must be 32 bytes long.'))))
	}
	mut var_state := create_paragonie_sodium_core32_poly1305_state(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_Poly1305{}
		return temp.substr(arg_0, arg_1, arg_2)
	}(var_key.dup(), rt.new_int(0), rt.new_int(32)))
	return rt.call_method(var_state.update(var_m.dup()), 'finish', []rt.PhpVal{})
}

fn Class_ParagonIE_Sodium_Core32_Poly1305.onetimeauth_verify(var_mac rt.PhpVal, var_m rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.less(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_Poly1305{}
		return temp.strlen(arg_0)
	}(var_key.dup()), rt.new_int(32)))
	{
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{},
			create_invalidargumentexception(rt.new_string('Key must be 32 bytes long.'))))
	}
	mut var_state := create_paragonie_sodium_core32_poly1305_state(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_Poly1305{}
		return temp.substr(arg_0, arg_1, arg_2)
	}(var_key.dup(), rt.new_int(0), rt.new_int(32)))
	mut var_calc := rt.call_method(var_state.update(var_m.dup()), 'finish', []rt.PhpVal{})
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_Poly1305{}
		return temp.verify_16(arg_0, arg_1)
	}(var_calc.dup(), var_mac.dup())
}

struct Class_ParagonIE_Sodium_Core32_Util {
	rt.PhpObjectBase
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Poly1305_State {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core32_poly1305() &Class_ParagonIE_Sodium_Core32_Poly1305 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Poly1305{
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

fn create_invalidargumentexception() &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_poly1305_state() &Class_ParagonIE_Sodium_Core32_Poly1305_State {
	mut obj := &Class_ParagonIE_Sodium_Core32_Poly1305_State{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core32_Poly1305) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'onetimeauth' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Poly1305.onetimeauth(dispatch_arg_0,
				dispatch_arg_1)
		}
		'onetimeauth_verify' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Poly1305.onetimeauth_verify(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_ParagonIE_Sodium_Core32_Poly1305) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Poly1305) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Poly1305_State) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Poly1305_State) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Poly1305_State) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_sodium_compat_src_core32_poly1305_php() {
	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core32_Poly1305'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}
