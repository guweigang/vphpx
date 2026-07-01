import rt

struct Class_WC_Settings_Site_Visibility {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Settings_Site_Visibility) construct()  {
	this.dispatch_set_prop('id', rt.new_string('site-visibility'))
	this.dispatch_set_prop('label', rt.call_function('__', [rt.new_string('Site visibility'), rt.new_string('woocommerce')]))
	this.Class_WC_Settings_Page.construct()
}

fn (mut this Class_WC_Settings_Site_Visibility) get_settings_for_default_section() rt.PhpVal {
	mut var_settings := [[rt.new_string('wc_settings_site_visibility_slotfill'), rt.new_string('slotfill_placeholder')]]
	return var_settings.dup()
}

struct Class_WC_Settings_Page {
	rt.PhpObjectBase
}

fn create_wc_settings_site_visibility() &Class_WC_Settings_Site_Visibility {
	mut obj := &Class_WC_Settings_Site_Visibility{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wc_settings_page() &Class_WC_Settings_Page {
	mut obj := &Class_WC_Settings_Page{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Settings_Site_Visibility) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_settings_for_default_section' {
			return this.get_settings_for_default_section()
		}
		else { return none }
	}
}

fn (this &Class_WC_Settings_Site_Visibility) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Settings_Site_Visibility) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Settings_Page) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Settings_Page) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Settings_Page) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_settings_class_wc_settings_site_visibility_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Settings_Site_Visibility'), rt.new_bool(false)])) {
		return create_wc_settings_site_visibility()
	}
	return create_wc_settings_site_visibility()
}
