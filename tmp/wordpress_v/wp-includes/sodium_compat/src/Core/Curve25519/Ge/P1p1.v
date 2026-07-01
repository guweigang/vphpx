import rt

struct Class_ParagonIE_Sodium_Core_Curve25519_Ge_P1p1 {
	rt.PhpObjectBase
pub mut:
	X rt.PhpVal = rt.new_null()
	Y rt.PhpVal = rt.new_null()
	Z rt.PhpVal = rt.new_null()
	T rt.PhpVal = rt.new_null()
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Ge_P1p1) construct(var_x rt.PhpVal, var_y rt.PhpVal, var_z rt.PhpVal, var_t rt.PhpVal) {
	mut var_x_mutated := var_x
	mut var_y_mutated := var_y
	mut var_z_mutated := var_z
	mut var_t_mutated := var_t
	if rt.is_true(rt.identical(var_x_mutated, rt.new_null())) {
		var_x_mutated = create_paragonie_sodium_core_curve25519_fe()
	}
	if !(true) {
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Argument 1 must be an instance of ParagonIE_Sodium_Core_Curve25519_Fe'))))
	}
	this.X = var_x_mutated.dup()
	if rt.is_true(rt.identical(var_y_mutated, rt.new_null())) {
		var_y_mutated = create_paragonie_sodium_core_curve25519_fe()
	}
	if !(true) {
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Argument 2 must be an instance of ParagonIE_Sodium_Core_Curve25519_Fe'))))
	}
	this.Y = var_y_mutated.dup()
	if rt.is_true(rt.identical(var_z_mutated, rt.new_null())) {
		var_z_mutated = create_paragonie_sodium_core_curve25519_fe()
	}
	if !(true) {
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Argument 3 must be an instance of ParagonIE_Sodium_Core_Curve25519_Fe'))))
	}
	this.Z = var_z_mutated.dup()
	if rt.is_true(rt.identical(var_t_mutated, rt.new_null())) {
		var_t_mutated = create_paragonie_sodium_core_curve25519_fe()
	}
	if !(true) {
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Argument 4 must be an instance of ParagonIE_Sodium_Core_Curve25519_Fe'))))
	}
	this.T = var_t_mutated.dup()
}

struct Class_ParagonIE_Sodium_Core_Curve25519_Fe {
	rt.PhpObjectBase
}

struct Class_TypeError {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_curve25519_ge_p1p1(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) &Class_ParagonIE_Sodium_Core_Curve25519_Ge_P1p1 {
	mut obj := &Class_ParagonIE_Sodium_Core_Curve25519_Ge_P1p1{
		PhpObjectBase: rt.PhpObjectBase{}
		X:             rt.new_null()
		Y:             rt.new_null()
		Z:             rt.new_null()
		T:             rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3)
	return obj
}

fn create_paragonie_sodium_core_curve25519_fe() &Class_ParagonIE_Sodium_Core_Curve25519_Fe {
	mut obj := &Class_ParagonIE_Sodium_Core_Curve25519_Fe{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_typeerror() &Class_TypeError {
	mut obj := &Class_TypeError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Ge_P1p1) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_ParagonIE_Sodium_Core_Curve25519_Ge_P1p1) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'X' { return this.X }
		'Y' { return this.Y }
		'Z' { return this.Z }
		'T' { return this.T }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Ge_P1p1) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'X' {
			this.X = val
			return true
		}
		'Y' {
			this.Y = val
			return true
		}
		'Z' {
			this.Z = val
			return true
		}
		'T' {
			this.T = val
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

pub fn init_wp_includes_sodium_compat_src_core_curve25519_ge_p1p1_php() {
	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core_Curve25519_Ge_P1p1'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}
