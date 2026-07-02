import rt

pub fn Class_Automattic_WooCommerce_Internal_EmailEditor_Package.version() rt.PhpVal {
	return Class_Automattic_WooCommerce_Internal_EmailEditor_Automattic_WooCommerce_EmailEditor_Package.version()
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_Package {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_internal_emaileditor_package() {
	rt.init_static_prop('Automattic_WooCommerce_Internal_EmailEditor_Package', 'package_active',
		rt.new_bool(false))
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_Package.init() {
	rt.set_static_prop('Automattic_WooCommerce_Internal_EmailEditor_Package', 'package_active', rt.identical(rt.call_function('get_option', [
		rt.new_string('woocommerce_feature_block_email_editor_enabled'),
		rt.new_string('no'),
	]), rt.new_string('yes')))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Internal_EmailEditor_Package',
		'package_active')))))
	{
		return
	}
	Class_Automattic_WooCommerce_Internal_EmailEditor_Package.initialize()
	mut iife_temp_0 :=
		Class_Automattic_WooCommerce_Internal_EmailEditor_Automattic_WooCommerce_EmailEditor_Package{}
	mut iife_result_0 := iife_temp_0.init()
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_Package.get_version() rt.PhpVal {
	mut iife_temp_1 :=
		Class_Automattic_WooCommerce_Internal_EmailEditor_Automattic_WooCommerce_EmailEditor_Package{}
	mut iife_result_1 := iife_temp_1.get_version()
	return iife_result_1
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_Package.get_path() rt.PhpVal {
	mut iife_temp_2 :=
		Class_Automattic_WooCommerce_Internal_EmailEditor_Automattic_WooCommerce_EmailEditor_Package{}
	mut iife_result_2 := iife_temp_2.get_path()
	return iife_result_2
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_Package.initialize() {
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.class(),
	])
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_Automattic_WooCommerce_EmailEditor_Package {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_emaileditor_package(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_Package {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_Package{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_automattic_woocommerce_emaileditor_package(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_Automattic_WooCommerce_EmailEditor_Package {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_Automattic_WooCommerce_EmailEditor_Package{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Package) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_Automattic_WooCommerce_Internal_EmailEditor_Package.init()
			return rt.new_null()
		}
		'get_version' {
			return Class_Automattic_WooCommerce_Internal_EmailEditor_Package.get_version()
		}
		'get_path' {
			return Class_Automattic_WooCommerce_Internal_EmailEditor_Package.get_path()
		}
		'initialize' {
			Class_Automattic_WooCommerce_Internal_EmailEditor_Package.initialize()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_Package) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Package) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Automattic_WooCommerce_EmailEditor_Package) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_Automattic_WooCommerce_EmailEditor_Package) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Automattic_WooCommerce_EmailEditor_Package) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
