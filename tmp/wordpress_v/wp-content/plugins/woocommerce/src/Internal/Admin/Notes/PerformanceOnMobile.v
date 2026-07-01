import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_PerformanceOnMobile.note_name() string {
	return 'wc-admin-performance-on-mobile'
}
struct Class_Automattic_WooCommerce_Internal_Admin_Notes_PerformanceOnMobile {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_PerformanceOnMobile.get_note() rt.PhpVal {
	mut var_nine_months_in_seconds := rt.mul(rt.get_constant('MONTH_IN_SECONDS'), rt.new_int(9))
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Notes_PerformanceOnMobile{}; return temp.wc_admin_active_for(arg_0) }(var_nine_months_in_seconds.dup()))))) {
		return rt.new_null()
	}
	if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Notes_MobileApp{}; return temp.has_note_been_actioned() }()) {
		return rt.new_null()
	}
	if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Notes_RealTimeOrderAlerts{}; return temp.has_note_been_actioned() }()) {
		return rt.new_null()
	}
	if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Notes_ManageOrdersOnTheGo{}; return temp.has_note_been_actioned() }()) {
		return rt.new_null()
	}
	mut var_note := create_automattic_woocommerce_admin_notes_note()
	var_note.set_title(rt.call_function('__', [rt.new_string('Track your store performance on mobile'), rt.new_string('woocommerce')]))
	var_note.set_content(rt.call_function('__', [rt.new_string('Monitor your sales and high performing products with the Woo app.'), rt.new_string('woocommerce')]))
	var_note.set_content_data(// unsupported expression: Expr_Cast_Object)
	var_note.set_type(Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_informational())
	var_note.set_name(Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_PerformanceOnMobile.note_name())
	var_note.set_source(rt.new_string('woocommerce-admin'))
	var_note.add_action(rt.new_string('learn-more'), rt.call_function('__', [rt.new_string('Learn more'), rt.new_string('woocommerce')]), rt.new_string('https://woocommerce.com/mobile/?utm_source=inbox&utm_medium=product'))
	return mut var_note
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_MobileApp {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_RealTimeOrderAlerts {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_ManageOrdersOnTheGo {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_notes_performanceonmobile() &Class_Automattic_WooCommerce_Internal_Admin_Notes_PerformanceOnMobile {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_PerformanceOnMobile{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_notes_mobileapp() &Class_Automattic_WooCommerce_Internal_Admin_Notes_MobileApp {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_MobileApp{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_notes_realtimeorderalerts() &Class_Automattic_WooCommerce_Internal_Admin_Notes_RealTimeOrderAlerts {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_RealTimeOrderAlerts{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_notes_manageordersonthego() &Class_Automattic_WooCommerce_Internal_Admin_Notes_ManageOrdersOnTheGo {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_ManageOrdersOnTheGo{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_note() &Class_Automattic_WooCommerce_Admin_Notes_Note {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Note{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_PerformanceOnMobile) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_note' {
			return Class_Automattic_WooCommerce_Internal_Admin_Notes_PerformanceOnMobile.get_note()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_PerformanceOnMobile) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_PerformanceOnMobile) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_MobileApp) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_MobileApp) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_MobileApp) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_RealTimeOrderAlerts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_RealTimeOrderAlerts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_RealTimeOrderAlerts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_ManageOrdersOnTheGo) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_ManageOrdersOnTheGo) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_ManageOrdersOnTheGo) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_notes_performanceonmobile_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
