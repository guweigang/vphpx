import rt

struct Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Cached {
	rt.PhpObjectBase
pub mut:
	YplusX  rt.PhpVal = rt.new_null()
	YminusX rt.PhpVal = rt.new_null()
	Z       rt.PhpVal = rt.new_null()
	T2d     rt.PhpVal = rt.new_null()
}

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Cached) construct(mut var_YplusX Class_ParagonIE_Sodium_Core32_Curve25519_Fe, mut var_YminusX Class_ParagonIE_Sodium_Core32_Curve25519_Fe, mut var_Z Class_ParagonIE_Sodium_Core32_Curve25519_Fe, mut var_T2d Class_ParagonIE_Sodium_Core32_Curve25519_Fe) {
	mut var_YplusX_mutated := var_YplusX
	mut var_YminusX_mutated := var_YminusX
	mut var_Z_mutated := var_Z
	mut var_T2d_mutated := var_T2d
	if rt.is_true(rt.identical(var_YplusX_mutated, rt.new_null())) {
		var_YplusX_mutated = create_paragonie_sodium_core32_curve25519_fe()
	}
	this.YplusX = var_YplusX_mutated.dup()
	if rt.is_true(rt.identical(var_YminusX_mutated, rt.new_null())) {
		var_YminusX_mutated = create_paragonie_sodium_core32_curve25519_fe()
	}
	this.YminusX = var_YminusX_mutated.dup()
	if rt.is_true(rt.identical(var_Z_mutated, rt.new_null())) {
		var_Z_mutated = create_paragonie_sodium_core32_curve25519_fe()
	}
	this.Z = var_Z_mutated.dup()
	if rt.is_true(rt.identical(var_T2d_mutated, rt.new_null())) {
		var_T2d_mutated = create_paragonie_sodium_core32_curve25519_fe()
	}
	this.T2d = var_T2d_mutated.dup()
}

struct Class_ParagonIE_Sodium_Core32_Curve25519_Fe {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core32_curve25519_ge_cached(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Cached {
	mut obj := &Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Cached{
		PhpObjectBase: rt.PhpObjectBase{}
		YplusX:        rt.new_null()
		YminusX:       rt.new_null()
		Z:             rt.new_null()
		T2d:           rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3)
	return obj
}

fn create_paragonie_sodium_core32_curve25519_fe() &Class_ParagonIE_Sodium_Core32_Curve25519_Fe {
	mut obj := &Class_ParagonIE_Sodium_Core32_Curve25519_Fe{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Cached) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](if args.len > 3 {
				args[3]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut
				dispatch_arg_3)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Cached) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'YplusX' { return this.YplusX }
		'YminusX' { return this.YminusX }
		'Z' { return this.Z }
		'T2d' { return this.T2d }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Cached) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_Fe) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Curve25519_Fe) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_Fe) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_sodium_compat_src_core32_curve25519_ge_cached_php() {
	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core32_Curve25519_Ge_Cached'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}
