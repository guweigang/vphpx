import rt

struct Class_ParagonIE_Sodium_Crypto {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_ParagonIE_Sodium_Crypto {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_crypto() &Class_ParagonIE_Sodium_Crypto {
	mut obj := &Class_ParagonIE_Sodium_Crypto{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_paragonie_sodium_crypto() &Class_ParagonIE_Sodium_ParagonIE_Sodium_Crypto {
	mut obj := &Class_ParagonIE_Sodium_ParagonIE_Sodium_Crypto{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Crypto) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Crypto) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Crypto) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_ParagonIE_Sodium_Crypto) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_ParagonIE_Sodium_Crypto) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_ParagonIE_Sodium_Crypto) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_sodium_compat_namespaced_crypto_php() {
}
