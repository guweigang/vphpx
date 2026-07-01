import rt

struct Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonHelper {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonHelper) is_site_live() bool {
	return (// unsupported expression: Expr_BinaryOp_NotIdentical).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonHelper) is_site_coming_soon() bool {
	return rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_coming_soon')]))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonHelper) is_store_coming_soon() bool {
	return rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_coming_soon')]))) && rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_store_pages_only')])))
}

fn (mut this Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonHelper) is_current_page_coming_soon() bool {
	if this.is_site_live() {
		return false
	}
	if this.is_site_coming_soon() {
		return true
	}
	if rt.is_true(rt.new_bool(this.is_store_coming_soon() && rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_WCAdminHelper{}; return temp.is_current_page_store_page() }()))) {
		return true
	}
	return false
}

struct Class_Automattic_WooCommerce_Admin_WCAdminHelper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_comingsoon_comingsoonhelper() &Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonHelper {
	mut obj := &Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_wcadminhelper() &Class_Automattic_WooCommerce_Admin_WCAdminHelper {
	mut obj := &Class_Automattic_WooCommerce_Admin_WCAdminHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_site_live' {
			return rt.new_bool(this.is_site_live())
		}
		'is_site_coming_soon' {
			return rt.new_bool(this.is_site_coming_soon())
		}
		'is_store_coming_soon' {
			return rt.new_bool(this.is_store_coming_soon())
		}
		'is_current_page_coming_soon' {
			return rt.new_bool(this.is_current_page_coming_soon())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_WCAdminHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_WCAdminHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_WCAdminHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_comingsoon_comingsoonhelper_php() {
}
