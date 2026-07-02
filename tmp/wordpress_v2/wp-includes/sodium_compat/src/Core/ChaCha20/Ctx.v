import rt

struct Class_ParagonIE_Sodium_Core_ChaCha20_Ctx {
	rt.PhpObjectBase
pub mut:
	container rt.PhpVal = rt.new_null()
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_Ctx) construct(key string, iv string, counter string) {
	mut counter_mutated := counter
	mut iife_temp_0 := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}
	mut iife_result_0 := iife_temp_0.strlen(rt.new_string(key))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_0, rt.new_int(32))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{},
			create_invalidargumentexception(rt.new_string('ChaCha20 expects a 256-bit key.'))))
	}
	mut iife_temp_1 := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}
	mut iife_result_1 := iife_temp_1.strlen(rt.new_string(iv))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_1, rt.new_int(8))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{},
			create_invalidargumentexception(rt.new_string('ChaCha20 expects a 64-bit nonce.'))))
	}
	this.container = create_splfixedarray(rt.new_int(16))
	this.container.array_set(0, 1634760805)
	this.container.array_set(1, 857760878)
	this.container.array_set(2, 2036477234)
	this.container.array_set(3, 1797285236)
	mut iife_temp_2 := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}
	mut iife_result_2 := iife_temp_2.substr(rt.new_string(key), rt.new_int(0), rt.new_int(4))
	mut iife_temp_3 := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}
	mut iife_result_3 := iife_temp_3.load_4(iife_result_2)
	this.container.array_set(4, iife_result_3)
	mut iife_temp_4 := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}
	mut iife_result_4 := iife_temp_4.substr(rt.new_string(key), rt.new_int(4), rt.new_int(4))
	mut iife_temp_5 := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}
	mut iife_result_5 := iife_temp_5.load_4(iife_result_4)
	this.container.array_set(5, iife_result_5)
	mut iife_temp_6 := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}
	mut iife_result_6 := iife_temp_6.substr(rt.new_string(key), rt.new_int(8), rt.new_int(4))
	mut iife_temp_7 := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}
	mut iife_result_7 := iife_temp_7.load_4(iife_result_6)
	this.container.array_set(6, iife_result_7)
	mut iife_temp_8 := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}
	mut iife_result_8 := iife_temp_8.substr(rt.new_string(key), rt.new_int(12), rt.new_int(4))
	mut iife_temp_9 := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}
	mut iife_result_9 := iife_temp_9.load_4(iife_result_8)
	this.container.array_set(7, iife_result_9)
	mut iife_temp_10 := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}
	mut iife_result_10 := iife_temp_10.substr(rt.new_string(key), rt.new_int(16), rt.new_int(4))
	mut iife_temp_11 := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}
	mut iife_result_11 := iife_temp_11.load_4(iife_result_10)
	this.container.array_set(8, iife_result_11)
	mut iife_temp_12 := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}
	mut iife_result_12 := iife_temp_12.substr(rt.new_string(key), rt.new_int(20), rt.new_int(4))
	mut iife_temp_13 := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}
	mut iife_result_13 := iife_temp_13.load_4(iife_result_12)
	this.container.array_set(9, iife_result_13)
	mut iife_temp_14 := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}
	mut iife_result_14 := iife_temp_14.substr(rt.new_string(key), rt.new_int(24), rt.new_int(4))
	mut iife_temp_15 := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}
	mut iife_result_15 := iife_temp_15.load_4(iife_result_14)
	this.container.array_set(10, iife_result_15)
	mut iife_temp_16 := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}
	mut iife_result_16 := iife_temp_16.substr(rt.new_string(key), rt.new_int(28), rt.new_int(4))
	mut iife_temp_17 := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}
	mut iife_result_17 := iife_temp_17.load_4(iife_result_16)
	this.container.array_set(11, iife_result_17)
	counter_mutated = this.initcounter(rt.new_string(counter_mutated))
	mut iife_temp_18 := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}
	mut iife_result_18 := iife_temp_18.substr(rt.new_string(counter_mutated), rt.new_int(0),
		rt.new_int(4))
	mut iife_temp_19 := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}
	mut iife_result_19 := iife_temp_19.load_4(iife_result_18)
	this.container.array_set(12, iife_result_19)
	mut iife_temp_20 := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}
	mut iife_result_20 := iife_temp_20.substr(rt.new_string(counter_mutated), rt.new_int(4),
		rt.new_int(4))
	mut iife_temp_21 := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}
	mut iife_result_21 := iife_temp_21.load_4(iife_result_20)
	this.container.array_set(13, iife_result_21)
	mut iife_temp_22 := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}
	mut iife_result_22 := iife_temp_22.substr(rt.new_string(iv), rt.new_int(0), rt.new_int(4))
	mut iife_temp_23 := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}
	mut iife_result_23 := iife_temp_23.load_4(iife_result_22)
	this.container.array_set(14, iife_result_23)
	mut iife_temp_24 := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}
	mut iife_result_24 := iife_temp_24.substr(rt.new_string(iv), rt.new_int(4), rt.new_int(4))
	mut iife_temp_25 := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}
	mut iife_result_25 := iife_temp_25.load_4(iife_result_24)
	this.container.array_set(15, iife_result_25)
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_Ctx) offsetset(var_offset rt.PhpVal, var_value rt.PhpVal) {
	if !(var_offset.clone().is_long()) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{},
			create_invalidargumentexception(rt.new_string('Expected an integer'))))
	}
	if !(var_value.clone().is_long()) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{},
			create_invalidargumentexception(rt.new_string('Expected an integer'))))
	}
	this.container.array_set(var_offset, var_value.clone())
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_Ctx) offsetexists(var_offset rt.PhpVal) rt.PhpVal {
	return rt.new_bool(this.container.array_isset(var_offset))
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_Ctx) offsetunset(var_offset rt.PhpVal) {
	this.container.array_unset(var_offset)
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_Ctx) offsetget(var_offset rt.PhpVal) rt.PhpVal {
	return if this.container.array_isset(var_offset) {
		this.container.array_get(var_offset)
	} else {
		rt.new_null()
	}
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_Ctx) initcounter(var_ctr rt.PhpVal) string {
	mut iife_temp_26 := Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{}
	mut iife_result_26 := iife_temp_26.strlen(var_ctr.clone())
	mut var_len := iife_result_26
	if rt.is_true(rt.identical(var_len, rt.new_int(0))) {
		return (rt.call_function('str_repeat', [rt.new_string(''),
			rt.new_int(8)])).str()
	}
	if rt.is_true(rt.less(var_len, rt.new_int(8))) {
		return var_ctr.str() +(rt.call_function('str_repeat', [rt.new_string(''), rt.sub(rt.new_int(8), var_len)])).str()
	}
	if rt.is_true(rt.greater(var_len, rt.new_int(8))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('counter cannot be more than 8 bytes'))))
	}
	return var_ctr.str()
}

struct Class_ParagonIE_Sodium_Core_Util {
	rt.PhpObjectBase
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_SplFixedArray {
	rt.PhpObjectBase
}

struct Class_SodiumException {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_chacha20_ctx(key string, iv string, counter string) &Class_ParagonIE_Sodium_Core_ChaCha20_Ctx {
	mut obj := &Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{
		PhpObjectBase: rt.PhpObjectBase{}
		container:     rt.new_null()
	}
	obj.construct(key, iv, counter)
	return obj
}

fn create_paragonie_sodium_core_util(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_Util {
	mut obj := &Class_ParagonIE_Sodium_Core_Util{
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

fn create_splfixedarray(_args ...rt.PhpVal) &Class_SplFixedArray {
	mut obj := &Class_SplFixedArray{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_sodiumexception(_args ...rt.PhpVal) &Class_SodiumException {
	mut obj := &Class_SodiumException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_Ctx) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
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
			return this.offsetget(dispatch_arg_0)
		}
		'initCounter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.initcounter(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_ParagonIE_Sodium_Core_ChaCha20_Ctx) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'container' { return this.container }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_Ctx) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'container' {
			this.container = val
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

fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core_ChaCha20_Ctx'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}
