import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_RemoteInboxNotifications.toggle_option_name() string {
	return 'woocommerce_show_marketplace_suggestions'
}
struct Class_Automattic_WooCommerce_Internal_Admin_RemoteInboxNotifications {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Internal_Admin_RemoteInboxNotifications.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteInboxNotifications) construct()  {
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}; return temp.is_enabled(arg_0) }(rt.new_string('remote-inbox-notifications'))) {
		fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine{}; return temp.init() }()
	}
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_remoteinboxnotifications() &Class_Automattic_WooCommerce_Internal_Admin_RemoteInboxNotifications {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_RemoteInboxNotifications{
		PhpObjectBase: rt.PhpObjectBase{}
		instance: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_features_features() &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remoteinboxnotifications_remoteinboxnotificationsengine() &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteInboxNotifications) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			return Class_Automattic_WooCommerce_Internal_Admin_RemoteInboxNotifications.get_instance()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_RemoteInboxNotifications) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteInboxNotifications) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_remoteinboxnotifications_php() {
}
