import rt

struct Class_ParagonIE_Sodium_Core_Curve25519_Ge_Precomp {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core_Curve25519_Ge_ParagonIE_Sodium_Core_Curve25519_Ge_Precomp {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_curve25519_ge_precomp() &Class_ParagonIE_Sodium_Core_Curve25519_Ge_Precomp {
	mut obj := &Class_ParagonIE_Sodium_Core_Curve25519_Ge_Precomp{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_curve25519_ge_paragonie_sodium_core_curve25519_ge_precomp() &Class_ParagonIE_Sodium_Core_Curve25519_Ge_ParagonIE_Sodium_Core_Curve25519_Ge_Precomp {
	mut obj := &Class_ParagonIE_Sodium_Core_Curve25519_Ge_ParagonIE_Sodium_Core_Curve25519_Ge_Precomp{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Ge_Precomp) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_Curve25519_Ge_Precomp) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Ge_Precomp) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Ge_ParagonIE_Sodium_Core_Curve25519_Ge_Precomp) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_Curve25519_Ge_ParagonIE_Sodium_Core_Curve25519_Ge_Precomp) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Ge_ParagonIE_Sodium_Core_Curve25519_Ge_Precomp) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_sodium_compat_namespaced_core_curve25519_ge_precomp_php() {
}
