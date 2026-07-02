import rt

pub fn Class_Automattic_WooCommerce_EmailEditor_Package.version() string {
	return '0.1.0'
}

struct Class_Automattic_WooCommerce_EmailEditor_Package {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_EmailEditor_Package.init() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container{}
	mut iife_result_0 := iife_temp_0.init()
}

fn Class_Automattic_WooCommerce_EmailEditor_Package.get_version() rt.PhpVal {
	return Class_Automattic_WooCommerce_EmailEditor_Automattic_WooCommerce_EmailEditor_Package.version()
}

fn Class_Automattic_WooCommerce_EmailEditor_Package.get_path() rt.PhpVal {
	return rt.call_function('dirname', [rt.new_string(@DIR)])
}

struct Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_package(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Package {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Package{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_email_editor_container(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Package) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_Automattic_WooCommerce_EmailEditor_Package.init()
			return rt.new_null()
		}
		'get_version' {
			return Class_Automattic_WooCommerce_EmailEditor_Package.get_version()
		}
		'get_path' {
			return Class_Automattic_WooCommerce_EmailEditor_Package.get_path()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Package) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Package) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
