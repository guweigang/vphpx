import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_RealTimeOrderAlerts.note_name() string {
	return 'wc-admin-real-time-order-alerts'
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_RealTimeOrderAlerts {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_RealTimeOrderAlerts.get_note() rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Admin_Notes_RealTimeOrderAlerts{}
	mut iife_result_0 := iife_temp_0.is_wc_admin_active_in_date_range(rt.new_string('month-3-6'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		return rt.new_null()
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Admin_Notes_MobileApp{}
	mut iife_result_1 := iife_temp_1.has_note_been_actioned()
	if rt.is_true(iife_result_1) {
		return rt.new_null()
	}
	mut var_content := rt.call_function('__', [
		rt.new_string('Get notifications about store activity, including new orders and product reviews directly on your mobile devices with the Woo app.'),
		rt.new_string('woocommerce'),
	])
	mut var_note := create_automattic_woocommerce_admin_notes_note()
	var_note.set_title(rt.call_function('__', [
		rt.new_string('Get real-time order alerts anywhere'),
		rt.new_string('woocommerce'),
	]))
	var_note.set_content(var_content.clone())
	var_note.set_content_data(rt.new_object('stdClass', []string{},
		rt.array_to_object(rt.new_array())))
	var_note.set_type(Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_informational())
	var_note.set_name(Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_RealTimeOrderAlerts.note_name())
	var_note.set_source(rt.new_string('woocommerce-admin'))
	var_note.add_action(rt.new_string('learn-more'), rt.call_function('__', [
		rt.new_string('Learn more'),
		rt.new_string('woocommerce'),
	]), rt.new_string('https://woocommerce.com/mobile/?utm_source=inbox&utm_medium=product'))
	return mut var_note
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_MobileApp {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_notes_realtimeorderalerts(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Notes_RealTimeOrderAlerts {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_RealTimeOrderAlerts{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_notes_mobileapp(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Notes_MobileApp {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_MobileApp{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_note(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_Note {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Note{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_RealTimeOrderAlerts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_note' {
			return Class_Automattic_WooCommerce_Internal_Admin_Notes_RealTimeOrderAlerts.get_note()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_RealTimeOrderAlerts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_RealTimeOrderAlerts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
