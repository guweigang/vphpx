import rt

struct Class_ParagonIE_Sodium_File {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_ParagonIE_Sodium_File {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_file() &Class_ParagonIE_Sodium_File {
	mut obj := &Class_ParagonIE_Sodium_File{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_paragonie_sodium_file() &Class_ParagonIE_Sodium_ParagonIE_Sodium_File {
	mut obj := &Class_ParagonIE_Sodium_ParagonIE_Sodium_File{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_File) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_File) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_File) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_ParagonIE_Sodium_File) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_ParagonIE_Sodium_File) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_ParagonIE_Sodium_File) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_sodium_compat_namespaced_file_php() {
}
