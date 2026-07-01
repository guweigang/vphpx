import rt

struct Class_ParagonIE_Sodium_Core_Curve25519_Fe {
	rt.PhpObjectBase
pub mut:
		e0 rt.PhpVal = rt.new_int(0)
		e1 rt.PhpVal = rt.new_int(0)
		e2 rt.PhpVal = rt.new_int(0)
		e3 rt.PhpVal = rt.new_int(0)
		e4 rt.PhpVal = rt.new_int(0)
		e5 rt.PhpVal = rt.new_int(0)
		e6 rt.PhpVal = rt.new_int(0)
		e7 rt.PhpVal = rt.new_int(0)
		e8 rt.PhpVal = rt.new_int(0)
		e9 rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Fe) construct(e0 i64, e1 i64, e2 i64, e3 i64, e4 i64, e5 i64, e6 i64, e7 i64, e8 i64, e9 i64)  {
	this.e0 = rt.new_int(e0).dup()
	this.e1 = rt.new_int(e1).dup()
	this.e2 = rt.new_int(e2).dup()
	this.e3 = rt.new_int(e3).dup()
	this.e4 = rt.new_int(e4).dup()
	this.e5 = rt.new_int(e5).dup()
	this.e6 = rt.new_int(e6).dup()
	this.e7 = rt.new_int(e7).dup()
	this.e8 = rt.new_int(e8).dup()
	this.e9 = rt.new_int(e9).dup()
}

fn Class_ParagonIE_Sodium_Core_Curve25519_Fe.fromarray(var_array rt.PhpVal) rt.PhpVal {
	mut var_obj := create_paragonie_sodium_core_curve25519_fe(0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	var_obj.e0 = if var_array.array_isset(rt.new_int(0)) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	var_obj.e1 = if var_array.array_isset(rt.new_int(1)) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	var_obj.e2 = if var_array.array_isset(rt.new_int(2)) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	var_obj.e3 = if var_array.array_isset(rt.new_int(3)) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	var_obj.e4 = if var_array.array_isset(rt.new_int(4)) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	var_obj.e5 = if var_array.array_isset(rt.new_int(5)) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	var_obj.e6 = if var_array.array_isset(rt.new_int(6)) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	var_obj.e7 = if var_array.array_isset(rt.new_int(7)) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	var_obj.e8 = if var_array.array_isset(rt.new_int(8)) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	var_obj.e9 = if var_array.array_isset(rt.new_int(9)) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	return mut var_obj
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Fe) offsetset(var_offset rt.PhpVal, var_value rt.PhpVal)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.dup().is_long()))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.new_string('Expected an integer'))))
	}
	mut switch_val_1 := var_offset
	if rt.is_true(rt.equal(switch_val_1, rt.new_int(0))) {
		this.e0 = var_value.dup()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(1))) {
		this.e1 = var_value.dup()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(2))) {
		this.e2 = var_value.dup()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(3))) {
		this.e3 = var_value.dup()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(4))) {
		this.e4 = var_value.dup()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(5))) {
		this.e5 = var_value.dup()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(6))) {
		this.e6 = var_value.dup()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(7))) {
		this.e7 = var_value.dup()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(8))) {
		this.e8 = var_value.dup()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(9))) {
		this.e9 = var_value.dup()
	} else {
		rt.throw_exception(rt.new_object('OutOfBoundsException', []string{}, create_outofboundsexception(rt.new_string('Index out of bounds'))))
	}
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Fe) offsetexists(var_offset rt.PhpVal) bool {
	return rt.is_true(rt.greater_equal(var_offset, rt.new_int(0))) && rt.is_true(rt.less(var_offset, rt.new_int(10)))
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Fe) offsetunset(var_offset rt.PhpVal)  {
	mut switch_val_2 := var_offset
	if rt.is_true(rt.equal(switch_val_2, rt.new_int(0))) {
		this.e0 = rt.new_int(0)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(1))) {
		this.e1 = rt.new_int(0)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(2))) {
		this.e2 = rt.new_int(0)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(3))) {
		this.e3 = rt.new_int(0)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(4))) {
		this.e4 = rt.new_int(0)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(5))) {
		this.e5 = rt.new_int(0)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(6))) {
		this.e6 = rt.new_int(0)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(7))) {
		this.e7 = rt.new_int(0)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(8))) {
		this.e8 = rt.new_int(0)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(9))) {
		this.e9 = rt.new_int(0)
	} else {
		rt.throw_exception(rt.new_object('OutOfBoundsException', []string{}, create_outofboundsexception(rt.new_string('Index out of bounds'))))
	}
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Fe) offsetget(var_offset rt.PhpVal)  {
	mut switch_val_3 := var_offset
	if rt.is_true(rt.equal(switch_val_3, rt.new_int(0))) {
		return // unsupported expression: Expr_Cast_Int
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_int(1))) {
		return // unsupported expression: Expr_Cast_Int
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_int(2))) {
		return // unsupported expression: Expr_Cast_Int
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_int(3))) {
		return // unsupported expression: Expr_Cast_Int
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_int(4))) {
		return // unsupported expression: Expr_Cast_Int
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_int(5))) {
		return // unsupported expression: Expr_Cast_Int
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_int(6))) {
		return // unsupported expression: Expr_Cast_Int
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_int(7))) {
		return // unsupported expression: Expr_Cast_Int
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_int(8))) {
		return // unsupported expression: Expr_Cast_Int
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_int(9))) {
		return // unsupported expression: Expr_Cast_Int
	} else {
		rt.throw_exception(rt.new_object('OutOfBoundsException', []string{}, create_outofboundsexception(rt.new_string('Index out of bounds'))))
	}
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Fe) magic_debuginfo() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('implode', [rt.new_string(', '), rt.create_array([rt.ArrayItem{ key: none, val: this.e0 }, rt.ArrayItem{ key: none, val: this.e1 }, rt.ArrayItem{ key: none, val: this.e2 }, rt.ArrayItem{ key: none, val: this.e3 }, rt.ArrayItem{ key: none, val: this.e4 }, rt.ArrayItem{ key: none, val: this.e5 }, rt.ArrayItem{ key: none, val: this.e6 }, rt.ArrayItem{ key: none, val: this.e7 }, rt.ArrayItem{ key: none, val: this.e8 }, rt.ArrayItem{ key: none, val: this.e9 }])]) }])
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_OutOfBoundsException {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_curve25519_fe(e0 i64, e1 i64, e2 i64, e3 i64, e4 i64, e5 i64, e6 i64, e7 i64, e8 i64, e9 i64) &Class_ParagonIE_Sodium_Core_Curve25519_Fe {
	mut obj := &Class_ParagonIE_Sodium_Core_Curve25519_Fe{
		PhpObjectBase: rt.PhpObjectBase{}
		e0: rt.new_int(0)
		e1: rt.new_int(0)
		e2: rt.new_int(0)
		e3: rt.new_int(0)
		e4: rt.new_int(0)
		e5: rt.new_int(0)
		e6: rt.new_int(0)
		e7: rt.new_int(0)
		e8: rt.new_int(0)
		e9: rt.new_int(0)
	}
	obj.construct(e0, e1, e2, e3, e4, e5, e6, e7, e8, e9)
	return obj
}

fn create_invalidargumentexception() &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_outofboundsexception() &Class_OutOfBoundsException {
	mut obj := &Class_OutOfBoundsException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Fe) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_i64()
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).to_i64()
			dispatch_arg_6 := (if args.len > 6 { args[6] } else { rt.new_null() }).to_i64()
			dispatch_arg_7 := (if args.len > 7 { args[7] } else { rt.new_null() }).to_i64()
			dispatch_arg_8 := (if args.len > 8 { args[8] } else { rt.new_null() }).to_i64()
			dispatch_arg_9 := (if args.len > 9 { args[9] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5, dispatch_arg_6, dispatch_arg_7, dispatch_arg_8, dispatch_arg_9)
			return rt.new_null()
		}
		'fromArray' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Curve25519_Fe.fromarray(dispatch_arg_0)
		}
		'offsetSet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.offsetset(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'offsetExists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.offsetexists(dispatch_arg_0))
		}
		'offsetUnset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.offsetunset(dispatch_arg_0)
			return rt.new_null()
		}
		'offsetGet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.offsetget(dispatch_arg_0)
			return rt.new_null()
		}
		'__debugInfo' {
			return this.magic_debuginfo()
		}
		else { return none }
	}
}

fn (this &Class_ParagonIE_Sodium_Core_Curve25519_Fe) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'e0' { return this.e0 }
		'e1' { return this.e1 }
		'e2' { return this.e2 }
		'e3' { return this.e3 }
		'e4' { return this.e4 }
		'e5' { return this.e5 }
		'e6' { return this.e6 }
		'e7' { return this.e7 }
		'e8' { return this.e8 }
		'e9' { return this.e9 }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Fe) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'e0' { this.e0 = val; return true }
		'e1' { this.e1 = val; return true }
		'e2' { this.e2 = val; return true }
		'e3' { this.e3 = val; return true }
		'e4' { this.e4 = val; return true }
		'e5' { this.e5 = val; return true }
		'e6' { this.e6 = val; return true }
		'e7' { this.e7 = val; return true }
		'e8' { this.e8 = val; return true }
		'e9' { this.e9 = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_OutOfBoundsException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_OutOfBoundsException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_OutOfBoundsException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_sodium_compat_src_core_curve25519_fe_php() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_Core_Curve25519_Fe'), rt.new_bool(false)])) {
		return rt.new_null()
	}
}
