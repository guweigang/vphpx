import rt

struct Class_Automattic_WooCommerce_Internal_Admin_MobileAppBanner {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Internal_Admin_MobileAppBanner.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_MobileAppBanner) construct()  {
	rt.call_function('add_filter', [rt.new_string('woocommerce_admin_get_user_data_fields'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_MobileAppBanner', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_user_data_fields' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_MobileAppBanner) add_user_data_fields(var_user_data_fields rt.PhpVal) rt.PhpVal {
	return rt.call_function('array_merge', [var_user_data_fields.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'android_app_banner_dismissed' }])])
}

fn create_automattic_woocommerce_internal_admin_mobileappbanner() &Class_Automattic_WooCommerce_Internal_Admin_MobileAppBanner {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_MobileAppBanner{
		PhpObjectBase: rt.PhpObjectBase{}
		instance: rt.new_null()
	}
	obj.construct()
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_MobileAppBanner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			return Class_Automattic_WooCommerce_Internal_Admin_MobileAppBanner.get_instance()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'add_user_data_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_user_data_fields(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_MobileAppBanner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_MobileAppBanner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_mobileappbanner_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
