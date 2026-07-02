import rt

pub fn Class_Automattic_WooCommerce_EmailEditor_Engine_Dependency_Check.min_wp_version() string {
	return '6.7'
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Dependency_Check {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Dependency_Check) are_dependencies_met() bool {
	if !(this.is_wp_version_compatible()) {
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Dependency_Check) is_wp_version_compatible() bool {
	return (rt.call_function('version_compare', [
		rt.call_function('get_bloginfo', [rt.new_string('version')]),
		Class_Automattic_WooCommerce_EmailEditor_Engine_Automattic_WooCommerce_EmailEditor_Engine_Dependency_Check.min_wp_version(),
		rt.new_string('>='),
	])).to_bool()
}

fn create_automattic_woocommerce_emaileditor_engine_dependency_check(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Dependency_Check {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Dependency_Check{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Dependency_Check) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'are_dependencies_met' {
			return rt.new_bool(this.are_dependencies_met())
		}
		'is_wp_version_compatible' {
			return rt.new_bool(this.is_wp_version_compatible())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Dependency_Check) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Dependency_Check) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
