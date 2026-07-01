import rt

struct Class_ParagonIE_Sodium_Core_Poly1305 {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core_ParagonIE_Sodium_Core_Poly1305 {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_poly1305() &Class_ParagonIE_Sodium_Core_Poly1305 {
	mut obj := &Class_ParagonIE_Sodium_Core_Poly1305{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_paragonie_sodium_core_poly1305() &Class_ParagonIE_Sodium_Core_ParagonIE_Sodium_Core_Poly1305 {
	mut obj := &Class_ParagonIE_Sodium_Core_ParagonIE_Sodium_Core_Poly1305{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_Poly1305) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_Poly1305) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Poly1305) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core_ParagonIE_Sodium_Core_Poly1305) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_ParagonIE_Sodium_Core_Poly1305) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_ParagonIE_Sodium_Core_Poly1305) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_sodium_compat_namespaced_core_poly1305_php() {
}
