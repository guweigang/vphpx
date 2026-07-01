import rt

struct Class_ParagonIE_Sodium_Core_Curve25519_Ge_Precomp {
	rt.PhpObjectBase
pub mut:
	yplusx  rt.PhpVal = rt.new_null()
	yminusx rt.PhpVal = rt.new_null()
	xy2d    rt.PhpVal = rt.new_null()
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Ge_Precomp) construct(var_yplusx rt.PhpVal, var_yminusx rt.PhpVal, var_xy2d rt.PhpVal) {
	mut var_yplusx_mutated := var_yplusx
	mut var_yminusx_mutated := var_yminusx
	mut var_xy2d_mutated := var_xy2d
	if rt.is_true(rt.identical(var_yplusx_mutated, rt.new_null())) {
		var_yplusx_mutated = create_paragonie_sodium_core_curve25519_fe()
	}
	if !(true) {
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Argument 1 must be an instance of ParagonIE_Sodium_Core_Curve25519_Fe'))))
	}
	this.yplusx = var_yplusx_mutated.dup()
	if rt.is_true(rt.identical(var_yminusx_mutated, rt.new_null())) {
		var_yminusx_mutated = create_paragonie_sodium_core_curve25519_fe()
	}
	if !(true) {
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Argument 2 must be an instance of ParagonIE_Sodium_Core_Curve25519_Fe'))))
	}
	this.yminusx = var_yminusx_mutated.dup()
	if rt.is_true(rt.identical(var_xy2d_mutated, rt.new_null())) {
		var_xy2d_mutated = create_paragonie_sodium_core_curve25519_fe()
	}
	if !(true) {
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Argument 3 must be an instance of ParagonIE_Sodium_Core_Curve25519_Fe'))))
	}
	this.xy2d = var_xy2d_mutated.dup()
}

struct Class_ParagonIE_Sodium_Core_Curve25519_Fe {
	rt.PhpObjectBase
}

struct Class_TypeError {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_curve25519_ge_precomp(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_ParagonIE_Sodium_Core_Curve25519_Ge_Precomp {
	mut obj := &Class_ParagonIE_Sodium_Core_Curve25519_Ge_Precomp{
		PhpObjectBase: rt.PhpObjectBase{}
		yplusx:        rt.new_null()
		yminusx:       rt.new_null()
		xy2d:          rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
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

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Ge_Precomp) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_ParagonIE_Sodium_Core_Curve25519_Ge_Precomp) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'yplusx' { return this.yplusx }
		'yminusx' { return this.yminusx }
		'xy2d' { return this.xy2d }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Ge_Precomp) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'yplusx' {
			this.yplusx = val
			return true
		}
		'yminusx' {
			this.yminusx = val
			return true
		}
		'xy2d' {
			this.xy2d = val
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

pub fn init_wp_includes_sodium_compat_src_core_curve25519_ge_precomp_php() {
	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core_Curve25519_Ge_Precomp'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}
