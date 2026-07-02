import rt

struct Class_ParagonIE_Sodium_Core_Curve25519_Ge_Cached {
	rt.PhpObjectBase
pub mut:
	YplusX  rt.PhpVal = rt.new_null()
	YminusX rt.PhpVal = rt.new_null()
	Z       rt.PhpVal = rt.new_null()
	T2d     rt.PhpVal = rt.new_null()
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Ge_Cached) construct(var_YplusX rt.PhpVal, var_YminusX rt.PhpVal, var_Z rt.PhpVal, var_T2d rt.PhpVal) {
	mut var_YplusX_mutated := var_YplusX
	mut var_YminusX_mutated := var_YminusX
	mut var_Z_mutated := var_Z
	mut var_T2d_mutated := var_T2d
	if rt.is_true(rt.identical(var_YplusX_mutated, rt.new_null())) {
		var_YplusX_mutated = create_paragonie_sodium_core_curve25519_fe()
	}
	if !(true) {
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Argument 1 must be an instance of ParagonIE_Sodium_Core_Curve25519_Fe'))))
	}
	this.YplusX = var_YplusX_mutated.clone()
	if rt.is_true(rt.identical(var_YminusX_mutated, rt.new_null())) {
		var_YminusX_mutated = create_paragonie_sodium_core_curve25519_fe()
	}
	if !(true) {
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Argument 2 must be an instance of ParagonIE_Sodium_Core_Curve25519_Fe'))))
	}
	this.YminusX = var_YminusX_mutated.clone()
	if rt.is_true(rt.identical(var_Z_mutated, rt.new_null())) {
		var_Z_mutated = create_paragonie_sodium_core_curve25519_fe()
	}
	if !(true) {
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Argument 3 must be an instance of ParagonIE_Sodium_Core_Curve25519_Fe'))))
	}
	this.Z = var_Z_mutated.clone()
	if rt.is_true(rt.identical(var_T2d_mutated, rt.new_null())) {
		var_T2d_mutated = create_paragonie_sodium_core_curve25519_fe()
	}
	if !(true) {
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Argument 4 must be an instance of ParagonIE_Sodium_Core_Curve25519_Fe'))))
	}
	this.T2d = var_T2d_mutated.clone()
}

struct Class_ParagonIE_Sodium_Core_Curve25519_Fe {
	rt.PhpObjectBase
}

struct Class_TypeError {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_curve25519_ge_cached(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) &Class_ParagonIE_Sodium_Core_Curve25519_Ge_Cached {
	mut obj := &Class_ParagonIE_Sodium_Core_Curve25519_Ge_Cached{
		PhpObjectBase: rt.PhpObjectBase{}
		YplusX:        rt.new_null()
		YminusX:       rt.new_null()
		Z:             rt.new_null()
		T2d:           rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3)
	return obj
}

fn create_paragonie_sodium_core_curve25519_fe(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_Curve25519_Fe {
	mut obj := &Class_ParagonIE_Sodium_Core_Curve25519_Fe{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_typeerror(_args ...rt.PhpVal) &Class_TypeError {
	mut obj := &Class_TypeError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Ge_Cached) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_ParagonIE_Sodium_Core_Curve25519_Ge_Cached) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'YplusX' { return this.YplusX }
		'YminusX' { return this.YminusX }
		'Z' { return this.Z }
		'T2d' { return this.T2d }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Ge_Cached) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'YplusX' {
			this.YplusX = val
			return true
		}
		'YminusX' {
			this.YminusX = val
			return true
		}
		'Z' {
			this.Z = val
			return true
		}
		'T2d' {
			this.T2d = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Fe) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_Curve25519_Fe) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Fe) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_TypeError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_TypeError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_TypeError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core_Curve25519_Ge_Cached'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}
