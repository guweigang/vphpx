import rt

struct Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp {
	rt.PhpObjectBase
pub mut:
	yplusx  rt.PhpVal = rt.new_null()
	yminusx rt.PhpVal = rt.new_null()
	xy2d    rt.PhpVal = rt.new_null()
}

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp) construct(mut var_yplusx Class_ParagonIE_Sodium_Core32_Curve25519_Fe, mut var_yminusx Class_ParagonIE_Sodium_Core32_Curve25519_Fe, mut var_xy2d Class_ParagonIE_Sodium_Core32_Curve25519_Fe) {
	mut var_yplusx_mutated := var_yplusx
	mut var_yminusx_mutated := var_yminusx
	mut var_xy2d_mutated := var_xy2d
	if rt.is_true(rt.identical(var_yplusx_mutated, rt.new_null())) {
		mut iife_temp_0 := Class_ParagonIE_Sodium_Core32_Curve25519{}
		mut iife_result_0 := iife_temp_0.fe_0()
		var_yplusx_mutated = iife_result_0
	}
	this.yplusx = var_yplusx_mutated
	if rt.is_true(rt.identical(var_yminusx_mutated, rt.new_null())) {
		mut iife_temp_1 := Class_ParagonIE_Sodium_Core32_Curve25519{}
		mut iife_result_1 := iife_temp_1.fe_0()
		var_yminusx_mutated = iife_result_1
	}
	this.yminusx = var_yminusx_mutated
	if rt.is_true(rt.identical(var_xy2d_mutated, rt.new_null())) {
		mut iife_temp_2 := Class_ParagonIE_Sodium_Core32_Curve25519{}
		mut iife_result_2 := iife_temp_2.fe_0()
		var_xy2d_mutated = iife_result_2
	}
	this.xy2d = var_xy2d_mutated
}

struct Class_ParagonIE_Sodium_Core32_Curve25519 {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core32_curve25519_ge_precomp(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp {
	mut obj := &Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp{
		PhpObjectBase: rt.PhpObjectBase{}
		yplusx:        rt.new_null()
		yminusx:       rt.new_null()
		xy2d:          rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_paragonie_sodium_core32_curve25519(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Curve25519 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Curve25519{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'yplusx' { return this.yplusx }
		'yminusx' { return this.yminusx }
		'xy2d' { return this.xy2d }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Curve25519) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}
