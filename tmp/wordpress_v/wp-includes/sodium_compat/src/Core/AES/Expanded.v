import rt

struct Class_ParagonIE_Sodium_Core_AES_Expanded {
	rt.PhpObjectBase
pub mut:
	expanded rt.PhpVal = rt.new_bool(true)
}

struct Class_ParagonIE_Sodium_Core_AES_KeySchedule {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_aes_expanded() &Class_ParagonIE_Sodium_Core_AES_Expanded {
	mut obj := &Class_ParagonIE_Sodium_Core_AES_Expanded{
		PhpObjectBase: rt.PhpObjectBase{}
		expanded:      rt.new_bool(true)
	}
	return obj
}

fn create_paragonie_sodium_core_aes_keyschedule() &Class_ParagonIE_Sodium_Core_AES_KeySchedule {
	mut obj := &Class_ParagonIE_Sodium_Core_AES_KeySchedule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_Expanded) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_AES_Expanded) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'expanded' { return this.expanded }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_Expanded) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'expanded' {
			this.expanded = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_KeySchedule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_AES_KeySchedule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_AES_KeySchedule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_sodium_compat_src_core_aes_expanded_php() {
	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core_AES_Expanded'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}
