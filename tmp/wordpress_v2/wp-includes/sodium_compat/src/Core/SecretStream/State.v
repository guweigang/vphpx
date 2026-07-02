import rt

struct Class_ParagonIE_Sodium_Core_SecretStream_State {
	rt.PhpObjectBase
pub mut:
	key     rt.PhpVal = rt.new_null()
	counter i64
	nonce   rt.PhpVal = rt.new_null()
	_pad    rt.PhpVal = rt.new_null()
}

fn (mut this Class_ParagonIE_Sodium_Core_SecretStream_State) construct(var_key rt.PhpVal, var_nonce rt.PhpVal) {
	mut var_nonce_mutated := var_nonce
	this.key = var_key.clone()
	this.counter = 1
	if rt.is_true(rt.new_bool(var_nonce_mutated.clone().is_null())) {
		var_nonce_mutated = rt.call_function('str_repeat', [rt.new_string(''),
			rt.new_int(12)])
	}
	this.nonce = rt.call_function('str_pad', [var_nonce_mutated.clone(),
		rt.new_int(12), rt.new_string(''), rt.get_constant('STR_PAD_RIGHT')])
	this._pad = rt.call_function('str_repeat', [rt.new_string(''),
		rt.new_int(4)])
}

fn (mut this Class_ParagonIE_Sodium_Core_SecretStream_State) counterreset() rt.PhpVal {
	this.counter = 1
	this._pad = rt.call_function('str_repeat', [rt.new_string(''),
		rt.new_int(4)])
	return rt.new_object('ParagonIE_Sodium_Core_SecretStream_State', []string{}, this)
}

fn (mut this Class_ParagonIE_Sodium_Core_SecretStream_State) getkey() rt.PhpVal {
	return this.key
}

fn (mut this Class_ParagonIE_Sodium_Core_SecretStream_State) getcounter() rt.PhpVal {
	mut iife_temp_0 := Class_ParagonIE_Sodium_Core_Util{}
	mut iife_result_0 := iife_temp_0.store32_le(rt.new_int(this.counter))
	return iife_result_0
}

fn (mut this Class_ParagonIE_Sodium_Core_SecretStream_State) getnonce() rt.PhpVal {
	if !(this.nonce.is_string()) {
		this.nonce = rt.call_function('str_repeat', [rt.new_string(''),
			rt.new_int(12)])
	}
	mut iife_temp_1 := Class_ParagonIE_Sodium_Core_Util{}
	mut iife_result_1 := iife_temp_1.strlen(this.nonce)
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_1, rt.new_int(12))))) {
		this.nonce = rt.call_function('str_pad', [this.nonce, rt.new_int(12),
			rt.new_string(''), rt.get_constant('STR_PAD_RIGHT')])
	}
	return this.nonce
}

fn (mut this Class_ParagonIE_Sodium_Core_SecretStream_State) getcombinednonce() string {
	mut iife_temp_2 := Class_ParagonIE_Sodium_Core_Util{}
	mut iife_result_2 := iife_temp_2.substr(this.getnonce(), rt.new_int(0), rt.new_int(8))
	return (this.getcounter()).str() + iife_result_2.str()
}

fn (mut this Class_ParagonIE_Sodium_Core_SecretStream_State) incrementcounter() rt.PhpVal {
	rt.pre_inc(this.counter)
	return rt.new_object('ParagonIE_Sodium_Core_SecretStream_State', []string{}, this)
}

fn (mut this Class_ParagonIE_Sodium_Core_SecretStream_State) needsrekey() bool {
	return rt.new_bool(this.counter & 65535 == 0)
}

fn (mut this Class_ParagonIE_Sodium_Core_SecretStream_State) rekey(var_newKeyAndNonce rt.PhpVal) rt.PhpVal {
	mut iife_temp_3 := Class_ParagonIE_Sodium_Core_Util{}
	mut iife_result_3 := iife_temp_3.substr(var_newKeyAndNonce.clone(), rt.new_int(0),
		rt.new_int(32))
	this.key = iife_result_3
	mut iife_temp_4 := Class_ParagonIE_Sodium_Core_Util{}
	mut iife_result_4 := iife_temp_4.substr(var_newKeyAndNonce.clone(), rt.new_int(32))
	mut iife_temp_5 := Class_ParagonIE_Sodium_Core_Util{}
	mut iife_result_5 := iife_temp_5.substr(var_newKeyAndNonce.clone(), rt.new_int(32))
	this.nonce = rt.call_function('str_pad', [iife_result_4, rt.new_int(12),
		rt.new_string(''), rt.get_constant('STR_PAD_RIGHT')])
	return rt.new_object('ParagonIE_Sodium_Core_SecretStream_State', []string{}, this)
}

fn (mut this Class_ParagonIE_Sodium_Core_SecretStream_State) xornonce(var_str rt.PhpVal) rt.PhpVal {
	mut iife_temp_6 := Class_ParagonIE_Sodium_Core_Util{}
	mut iife_result_6 := iife_temp_6.substr(var_str.clone(), rt.new_int(0), rt.new_int(8))
	mut iife_temp_7 := Class_ParagonIE_Sodium_Core_Util{}
	mut iife_result_7 := iife_temp_7.substr(var_str.clone(), rt.new_int(0), rt.new_int(8))
	mut iife_temp_8 := Class_ParagonIE_Sodium_Core_Util{}
	mut iife_result_8 := iife_temp_8.xorstrings(this.getnonce(), rt.call_function('str_pad', [
		iife_result_6,
		rt.new_int(12),
		rt.new_string(''),
		rt.get_constant('STR_PAD_RIGHT'),
	]))
	this.nonce = iife_result_8
	return rt.new_object('ParagonIE_Sodium_Core_SecretStream_State', []string{}, this)
}

fn Class_ParagonIE_Sodium_Core_SecretStream_State.fromstring(var_string rt.PhpVal) rt.PhpVal {
	mut iife_temp_9 := Class_ParagonIE_Sodium_Core_Util{}
	mut iife_result_9 := iife_temp_9.substr(var_string.clone(), rt.new_int(0), rt.new_int(32))
	mut var_state := create_paragonie_sodium_core_secretstream_state(iife_result_9, rt.new_null())
	mut iife_temp_10 := Class_ParagonIE_Sodium_Core_Util{}
	mut iife_result_10 := iife_temp_10.substr(var_string.clone(), rt.new_int(32), rt.new_int(4))
	mut iife_temp_11 := Class_ParagonIE_Sodium_Core_Util{}
	mut iife_result_11 := iife_temp_11.load_4(iife_result_10)
	var_state.counter = iife_result_11
	mut iife_temp_12 := Class_ParagonIE_Sodium_Core_Util{}
	mut iife_result_12 := iife_temp_12.substr(var_string.clone(), rt.new_int(36), rt.new_int(12))
	var_state.nonce = iife_result_12
	mut iife_temp_13 := Class_ParagonIE_Sodium_Core_Util{}
	mut iife_result_13 := iife_temp_13.substr(var_string.clone(), rt.new_int(48), rt.new_int(8))
	var_state._pad = iife_result_13
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
		key:           rt.new_null()
		counter:       i64(0)
		nonce:         rt.new_null()
		_pad:          rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_paragonie_sodium_core_util(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_Util {
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
		else {
			return none
		}
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
		'key' {
			this.key = val
			return true
		}
		'counter' {
			this.counter = val.to_i64()
			return true
		}
		'nonce' {
			this.nonce = val
			return true
		}
		'_pad' {
			this._pad = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
