import rt

pub fn Class_Automattic_WooCommerce_Internal_EmailEditor_Package.version() rt.PhpVal {
	return Class_Automattic_WooCommerce_Internal_EmailEditor_Automattic_WooCommerce_EmailEditor_Package.version()
}
struct Class_Automattic_WooCommerce_Internal_EmailEditor_Package {
	rt.PhpObjectBase
pub mut:
		package_active rt.PhpVal = rt.new_bool(false)
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_Package.init()  {
	// unsupported assign target: Expr_StaticPropertyFetch
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		return rt.new_null()
	}
	Class_Automattic_WooCommerce_Internal_EmailEditor_Package.initialize()
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_EmailEditor_Automattic_WooCommerce_EmailEditor_Package{}; return temp.init() }()
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_Package.get_version() rt.PhpVal {
	return fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_EmailEditor_Automattic_WooCommerce_EmailEditor_Package{}; return temp.get_version() }()
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_Package.get_path() rt.PhpVal {
	return fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_EmailEditor_Automattic_WooCommerce_EmailEditor_Package{}; return temp.get_path() }()
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_Package.initialize()  {
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.class()])
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_Automattic_WooCommerce_EmailEditor_Package {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_emaileditor_package() &Class_Automattic_WooCommerce_Internal_EmailEditor_Package {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_Package{
		PhpObjectBase: rt.PhpObjectBase{}
		package_active: rt.new_bool(false)
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_automattic_woocommerce_emaileditor_package() &Class_Automattic_WooCommerce_Internal_EmailEditor_Automattic_WooCommerce_EmailEditor_Package {
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
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_Package) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'package_active' { return this.package_active }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Package) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'package_active' { this.package_active = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_content_plugins_woocommerce_src_internal_emaileditor_package_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
