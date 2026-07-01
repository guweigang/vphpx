import rt

struct Class_ParagonIE_Sodium_Core_Poly1305_State {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core_Poly1305_ParagonIE_Sodium_Core_Poly1305_State {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_poly1305_state() &Class_ParagonIE_Sodium_Core_Poly1305_State {
	mut obj := &Class_ParagonIE_Sodium_Core_Poly1305_State{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_poly1305_paragonie_sodium_core_poly1305_state() &Class_ParagonIE_Sodium_Core_Poly1305_ParagonIE_Sodium_Core_Poly1305_State {
	mut obj := &Class_ParagonIE_Sodium_Core_Poly1305_ParagonIE_Sodium_Core_Poly1305_State{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_Poly1305_State) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_Poly1305_State) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Poly1305_State) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core_Poly1305_ParagonIE_Sodium_Core_Poly1305_State) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_Poly1305_ParagonIE_Sodium_Core_Poly1305_State) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Poly1305_ParagonIE_Sodium_Core_Poly1305_State) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_sodium_compat_namespaced_core_poly1305_state_php() {
}
