import rt

struct Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core_ChaCha20_ParagonIE_Sodium_Core_ChaCha20_IetfCtx {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_chacha20_ietfctx() &Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx {
	mut obj := &Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_chacha20_paragonie_sodium_core_chacha20_ietfctx() &Class_ParagonIE_Sodium_Core_ChaCha20_ParagonIE_Sodium_Core_ChaCha20_IetfCtx {
	mut obj := &Class_ParagonIE_Sodium_Core_ChaCha20_ParagonIE_Sodium_Core_ChaCha20_IetfCtx{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_ParagonIE_Sodium_Core_ChaCha20_IetfCtx) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_ChaCha20_ParagonIE_Sodium_Core_ChaCha20_IetfCtx) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_ParagonIE_Sodium_Core_ChaCha20_IetfCtx) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_sodium_compat_namespaced_core_chacha20_ietfctx_php() {
}
