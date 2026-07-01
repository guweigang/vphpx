import rt

struct Class_ParagonIE_Sodium_Core_SecretStream_State {
	rt.PhpObjectBase
pub mut:
		key rt.PhpVal = rt.new_null()
		counter i64
		nonce rt.PhpVal = rt.new_null()
		_pad rt.PhpVal = rt.new_null()
}

fn (mut this Class_ParagonIE_Sodium_Core_SecretStream_State) construct(var_key rt.PhpVal, var_nonce rt.PhpVal)  {
	mut var_nonce_mutated := var_nonce
	this.key = var_key.dup()
	this.counter = 1
	if rt.is_true(rt.new_bool(var_nonce_mutated.dup().is_null())) {
		var_nonce_mutated = rt.call_function('str_repeat', [rt.new_string(''), rt.new_int(12)])
	}
	this.nonce = rt.call_function('str_pad', [var_nonce_mutated.dup(), rt.new_int(12), rt.new_string(''), rt.get_constant('STR_PAD_RIGHT')])
	this._pad = rt.call_function('str_repeat', [rt.new_string(''), rt.new_int(4)])
}

fn (mut this Class_ParagonIE_Sodium_Core_SecretStream_State) counterreset() rt.PhpVal {
	this.counter = 1
	this._pad = rt.call_function('str_repeat', [rt.new_string(''), rt.new_int(4)])
	return rt.new_object('ParagonIE_Sodium_Core_SecretStream_State', []string{}, this)
}

fn (mut this Class_ParagonIE_Sodium_Core_SecretStream_State) getkey() rt.PhpVal {
	return this.key
}

fn (mut this Class_ParagonIE_Sodium_Core_SecretStream_State) getcounter() rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.store32_le(arg_0) }(rt.new_int(this.counter))
}

fn (mut this Class_ParagonIE_Sodium_Core_SecretStream_State) getnonce() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.nonce.is_string()))))) {
		this.nonce = rt.call_function('str_repeat', [rt.new_string(''), rt.new_int(12)])
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.nonce = rt.call_function('str_pad', [this.nonce, rt.new_int(12), rt.new_string(''), rt.get_constant('STR_PAD_RIGHT')])
	}
	return this.nonce
}

fn (mut this Class_ParagonIE_Sodium_Core_SecretStream_State) getcombinednonce() string {
	return (this.getcounter()).str() + (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.substr(arg_0, arg_1, arg_2) }(this.getnonce(), rt.new_int(0), rt.new_int(8))).str()
}

fn (mut this Class_ParagonIE_Sodium_Core_SecretStream_State) incrementcounter() rt.PhpVal {
	rt.pre_inc(this.counter)
	return rt.new_object('ParagonIE_Sodium_Core_SecretStream_State', []string{}, this)
}

fn (mut this Class_ParagonIE_Sodium_Core_SecretStream_State) needsrekey() bool {
	return rt.new_bool(this.counter & 65535 == 0)
}

fn (mut this Class_ParagonIE_Sodium_Core_SecretStream_State) rekey(var_newKeyAndNonce rt.PhpVal) rt.PhpVal {
	this.key = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.substr(arg_0, arg_1, arg_2) }(var_newKeyAndNonce.dup(), rt.new_int(0), rt.new_int(32))
	this.nonce = rt.call_function('str_pad', [fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.substr(arg_0, arg_1) }(var_newKeyAndNonce.dup(), rt.new_int(32)), rt.new_int(12), rt.new_string(''), rt.get_constant('STR_PAD_RIGHT')])
	return rt.new_object('ParagonIE_Sodium_Core_SecretStream_State', []string{}, this)
}

fn (mut this Class_ParagonIE_Sodium_Core_SecretStream_State) xornonce(var_str rt.PhpVal) rt.PhpVal {
	this.nonce = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.xorstrings(arg_0, arg_1) }(this.getnonce(), rt.call_function('str_pad', [fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.substr(arg_0, arg_1, arg_2) }(var_str.dup(), rt.new_int(0), rt.new_int(8)), rt.new_int(12), rt.new_string(''), rt.get_constant('STR_PAD_RIGHT')]))
	return rt.new_object('ParagonIE_Sodium_Core_SecretStream_State', []string{}, this)
}

fn Class_ParagonIE_Sodium_Core_SecretStream_State.fromstring(var_string rt.PhpVal) rt.PhpVal {
	mut var_state := create_paragonie_sodium_core_secretstream_state(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.substr(arg_0, arg_1, arg_2) }(var_string.dup(), rt.new_int(0), rt.new_int(32)), rt.new_null())
	var_state.counter = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.substr(arg_0, arg_1, arg_2) }(var_string.dup(), rt.new_int(32), rt.new_int(4)))
	var_state.nonce = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.substr(arg_0, arg_1, arg_2) }(var_string.dup(), rt.new_int(36), rt.new_int(12))
	var_state._pad = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.substr(arg_0, arg_1, arg_2) }(var_string.dup(), rt.new_int(48), rt.new_int(8))
	return mut var_state
}

fn (mut this Class_ParagonIE_Sodium_Core_SecretStream_State) tostring() string {
	return (this.key).str() + (this.getcounter()).str() + (this.nonce).str() + (this._pad).str()
}

struct Class_ParagonIE_Sodium_Core_Util {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_secretstream_state(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_ParagonIE_Sodium_Core_SecretStream_State {
	mut obj := &Class_ParagonIE_Sodium_Core_SecretStream_State{
		PhpObjectBase: rt.PhpObjectBase{}
		key: rt.new_null()
		counter: i64(0)
		nonce: rt.new_null()
		_pad: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_paragonie_sodium_core_util() &Class_ParagonIE_Sodium_Core_Util {
	mut obj := &Class_ParagonIE_Sodium_Core_Util{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_SecretStream_State) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'counterReset' {
			return this.counterreset()
		}
		'getKey' {
			return this.getkey()
		}
		'getCounter' {
			return this.getcounter()
		}
		'getNonce' {
			return this.getnonce()
		}
		'getCombinedNonce' {
			return rt.new_string(this.getcombinednonce())
		}
		'incrementCounter' {
			return this.incrementcounter()
		}
		'needsRekey' {
			return rt.new_bool(this.needsrekey())
		}
		'rekey' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.rekey(dispatch_arg_0)
		}
		'xorNonce' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.xornonce(dispatch_arg_0)
		}
		'fromString' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_SecretStream_State.fromstring(dispatch_arg_0)
		}
		'toString' {
			return rt.new_string(this.tostring())
		}
		else { return none }
	}
}

fn (this &Class_ParagonIE_Sodium_Core_SecretStream_State) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'key' { return this.key }
		'counter' { return rt.new_int(this.counter) }
		'nonce' { return this.nonce }
		'_pad' { return this._pad }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ParagonIE_Sodium_Core_SecretStream_State) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'key' { this.key = val; return true }
		'counter' { this.counter = (val).to_i64(); return true }
		'nonce' { this.nonce = val; return true }
		'_pad' { this._pad = val; return true }
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




pub fn init_wp_includes_sodium_compat_src_core_secretstream_state_php() {
}
