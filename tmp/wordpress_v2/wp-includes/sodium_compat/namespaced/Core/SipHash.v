import rt

struct Class_ParagonIE_Sodium_Core_SipHash {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core_ParagonIE_Sodium_Core_SipHash {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_siphash(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_SipHash {
	mut obj := &Class_ParagonIE_Sodium_Core_SipHash{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_paragonie_sodium_core_siphash(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_ParagonIE_Sodium_Core_SipHash {
	mut obj := &Class_ParagonIE_Sodium_Core_ParagonIE_Sodium_Core_SipHash{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_SipHash) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_SipHash) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_SipHash) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core_ParagonIE_Sodium_Core_SipHash) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_ParagonIE_Sodium_Core_SipHash) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_ParagonIE_Sodium_Core_SipHash) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
