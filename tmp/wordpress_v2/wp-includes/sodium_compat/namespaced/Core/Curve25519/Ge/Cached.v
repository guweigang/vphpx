import rt

struct Class_ParagonIE_Sodium_Core_Curve25519_Ge_Cached {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core_Curve25519_Ge_ParagonIE_Sodium_Core_Curve25519_Ge_Cached {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_curve25519_ge_cached(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_Curve25519_Ge_Cached {
	mut obj := &Class_ParagonIE_Sodium_Core_Curve25519_Ge_Cached{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_curve25519_ge_paragonie_sodium_core_curve25519_ge_cached(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_Curve25519_Ge_ParagonIE_Sodium_Core_Curve25519_Ge_Cached {
	mut obj := &Class_ParagonIE_Sodium_Core_Curve25519_Ge_ParagonIE_Sodium_Core_Curve25519_Ge_Cached{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Ge_Cached) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_Curve25519_Ge_Cached) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Ge_Cached) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Ge_ParagonIE_Sodium_Core_Curve25519_Ge_Cached) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_Curve25519_Ge_ParagonIE_Sodium_Core_Curve25519_Ge_Cached) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Ge_ParagonIE_Sodium_Core_Curve25519_Ge_Cached) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
