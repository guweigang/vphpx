import rt

pub fn Class_Automattic_WooCommerce_Admin_Composer_Package.version() string {
	return '3.3.0'
}
struct Class_Automattic_WooCommerce_Admin_Composer_Package {
	rt.PhpObjectBase
pub mut:
		package_active rt.PhpVal = rt.new_bool(false)
		active_version rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Admin_Composer_Package.init()  {
	if rt.is_true(rt.call_function('defined', [rt.new_string('WC_ADMIN_VERSION_NUMBER')])) {
		// unsupported assign target: Expr_StaticPropertyFetch
		return rt.new_null()
	}
	mut var_feature_plugin_instance := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_FeaturePlugin{}; return temp.instance() }()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WC_ADMIN_PACKAGE_EXISTS')]))))) {
		rt.call_function('define', [rt.new_string('WC_ADMIN_PACKAGE_EXISTS'), rt.new_bool(true)])
	}
	// unsupported assign target: Expr_StaticPropertyFetch
	// unsupported assign target: Expr_StaticPropertyFetch
	rt.call_method(var_feature_plugin_instance, 'init', []rt.PhpVal{})
	rt.call_function('remove_filter', [rt.new_string('action_scheduler_store_class'), rt.create_array([rt.ArrayItem{ key: none, val: var_feature_plugin_instance }, rt.ArrayItem{ key: none, val: 'replace_actionscheduler_store_class' }])])
}

fn Class_Automattic_WooCommerce_Admin_Composer_Package.get_version() rt.PhpVal {
	return Class_Automattic_WooCommerce_Admin_Composer_Automattic_WooCommerce_Admin_Composer_Package.version()
}

fn Class_Automattic_WooCommerce_Admin_Composer_Package.get_active_version() rt.PhpVal {
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn Class_Automattic_WooCommerce_Admin_Composer_Package.is_package_active() rt.PhpVal {
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn Class_Automattic_WooCommerce_Admin_Composer_Package.get_path() rt.PhpVal {
	return rt.call_function('dirname', [rt.new_string(@DIR)])
}

fn Class_Automattic_WooCommerce_Admin_Composer_Package.is_notes_initialized() bool {
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Notes_Notes{}; return temp.load_data_store() }()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Admin_Notes_NotesUnavailableException') {
		mut var_e := var_e_1.dup()
		return false
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return true
}

struct Class_Automattic_WooCommerce_Internal_Admin_FeaturePlugin {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Notes {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_composer_package() &Class_Automattic_WooCommerce_Admin_Composer_Package {
	mut obj := &Class_Automattic_WooCommerce_Admin_Composer_Package{
		PhpObjectBase: rt.PhpObjectBase{}
		package_active: rt.new_bool(false)
		active_version: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_featureplugin() &Class_Automattic_WooCommerce_Internal_Admin_FeaturePlugin {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_FeaturePlugin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_notes() &Class_Automattic_WooCommerce_Admin_Notes_Notes {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Notes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Composer_Package) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_Automattic_WooCommerce_Admin_Composer_Package.init()
			return rt.new_null()
		}
		'get_version' {
			return Class_Automattic_WooCommerce_Admin_Composer_Package.get_version()
		}
		'get_active_version' {
			return Class_Automattic_WooCommerce_Admin_Composer_Package.get_active_version()
		}
		'is_package_active' {
			return Class_Automattic_WooCommerce_Admin_Composer_Package.is_package_active()
		}
		'get_path' {
			return Class_Automattic_WooCommerce_Admin_Composer_Package.get_path()
		}
		'is_notes_initialized' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Composer_Package.is_notes_initialized())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Composer_Package) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'package_active' { return this.package_active }
		'active_version' { return this.active_version }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Composer_Package) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'package_active' { this.package_active = val; return true }
		'active_version' { this.active_version = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_FeaturePlugin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_FeaturePlugin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_FeaturePlugin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_composer_package_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
