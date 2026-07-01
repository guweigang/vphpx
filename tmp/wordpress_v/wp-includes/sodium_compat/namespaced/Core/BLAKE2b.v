import rt

struct Class_ParagonIE_Sodium_Core_BLAKE2b {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core_ParagonIE_Sodium_Core_BLAKE2b {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_blake2b() &Class_ParagonIE_Sodium_Core_BLAKE2b {
	mut obj := &Class_ParagonIE_Sodium_Core_BLAKE2b{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_paragonie_sodium_core_blake2b() &Class_ParagonIE_Sodium_Core_ParagonIE_Sodium_Core_BLAKE2b {
	mut obj := &Class_ParagonIE_Sodium_Core_ParagonIE_Sodium_Core_BLAKE2b{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_BLAKE2b) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_BLAKE2b) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_BLAKE2b) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core_ParagonIE_Sodium_Core_BLAKE2b) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_ParagonIE_Sodium_Core_BLAKE2b) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_ParagonIE_Sodium_Core_BLAKE2b) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_sodium_compat_namespaced_core_blake2b_php() {
}
