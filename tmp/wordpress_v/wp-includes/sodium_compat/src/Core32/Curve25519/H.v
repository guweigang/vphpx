import rt

struct Class_ParagonIE_Sodium_Core32_Curve25519_H {
	rt.PhpObjectBase
pub mut:
	base   rt.PhpVal = rt.new_array()
	base2  rt.PhpVal = rt.new_array()
	d      rt.PhpVal = rt.new_array()
	d2     rt.PhpVal = rt.new_array()
	sqrtm1 rt.PhpVal = rt.new_array()
}

struct Class_ParagonIE_Sodium_Core32_Util {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core32_curve25519_h() &Class_ParagonIE_Sodium_Core32_Curve25519_H {
	mut obj := &Class_ParagonIE_Sodium_Core32_Curve25519_H{
		PhpObjectBase: rt.PhpObjectBase{}
		base:          rt.new_array()
		base2:         rt.new_array()
		d:             rt.new_array()
		d2:            rt.new_array()
		sqrtm1:        rt.new_array()
	}
	return obj
}

fn create_paragonie_sodium_core32_util() &Class_ParagonIE_Sodium_Core32_Util {
	mut obj := &Class_ParagonIE_Sodium_Core32_Util{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_H) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Curve25519_H) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'base' { return this.base }
		'base2' { return this.base2 }
		'd' { return this.d }
		'd2' { return this.d2 }
		'sqrtm1' { return this.sqrtm1 }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_H) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'base' {
			this.base = val
			return true
		}
		'base2' {
			this.base2 = val
			return true
		}
		'd' {
			this.d = val
			return true
		}
		'd2' {
			this.d2 = val
			return true
		}
		'sqrtm1' {
			this.sqrtm1 = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

pub fn init_wp_includes_sodium_compat_src_core32_curve25519_h_php() {
	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core32_Curve25519_H'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}
