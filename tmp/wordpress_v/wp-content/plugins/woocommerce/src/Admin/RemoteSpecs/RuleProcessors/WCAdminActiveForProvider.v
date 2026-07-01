import rt

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_WCAdminActiveForProvider {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_WCAdminActiveForProvider) get_wcadmin_active_for_in_seconds() rt.PhpVal {
	return fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_WCAdminHelper{}; return temp.get_wcadmin_active_for_in_seconds() }()
}

struct Class_Automattic_WooCommerce_Admin_WCAdminHelper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_wcadminactiveforprovider() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_WCAdminActiveForProvider {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_WCAdminActiveForProvider{
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

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_WCAdminActiveForProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_wcadmin_active_for_in_seconds' {
			return this.get_wcadmin_active_for_in_seconds()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_WCAdminActiveForProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_WCAdminActiveForProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_admin_remotespecs_ruleprocessors_wcadminactiveforprovider_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
