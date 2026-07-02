import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsRemindMeLater.note_name() string {
	return 'wc-admin-payments-remind-me-later'
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsRemindMeLater {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsRemindMeLater.is_applicable() rt.PhpVal {
	return Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsRemindMeLater.should_display_note()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsRemindMeLater.should_display_note() bool {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage{}
	mut iife_result_0 := iife_temp_0.instance()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(iife_result_0, 'has_incentive',
		[]rt.PhpVal{})))))
	{
		return false
	}
	mut var_view_timestamp := rt.call_function('get_option', [
		rt.new_string('wcpay_welcome_page_viewed_timestamp'),
		rt.new_bool(false),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_view_timestamp))))
		|| rt.is_true(rt.less(rt.sub(rt.call_function('time', []rt.PhpVal{}), var_view_timestamp), rt.mul(rt.new_int(3), rt.get_constant('DAY_IN_SECONDS')))) {
		return false
	}
	return true
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsRemindMeLater.get_note() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsRemindMeLater.should_display_note())))) {
		return rt.new_null()
	}
	mut var_content := rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('Save up to $800 in fees by managing transactions with %1$s. With %1$s, you can securely accept major cards, Apple Pay, and payments in over 100 currencies.'),
			rt.new_string('woocommerce'),
		]),
		rt.new_string('WooPayments'),
	])
	mut var_note := create_automattic_woocommerce_admin_notes_note()
	var_note.set_title(rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Save big with %s'),
			rt.new_string('woocommerce')]),
		rt.new_string('WooPayments'),
	]))
	var_note.set_content(var_content.clone())
	var_note.set_content_data(rt.new_object('stdClass', []string{},
		rt.array_to_object(rt.new_array())))
	var_note.set_type(Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_informational())
	var_note.set_name(Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsRemindMeLater.note_name())
	var_note.set_source(rt.new_string('woocommerce-admin'))
	var_note.add_action(rt.new_string('learn-more'), rt.call_function('__', [
		rt.new_string('Learn more'),
		rt.new_string('woocommerce'),
	]), rt.call_function('admin_url', [
		rt.new_string('admin.php?page=wc-admin&path=/wc-pay-welcome-page'),
	]))
	return mut var_note
}

struct Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_notes_paymentsremindmelater(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsRemindMeLater {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsRemindMeLater{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcpaywelcomepage(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage{
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsRemindMeLater) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_applicable' {
			return Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsRemindMeLater.is_applicable()
		}
		'should_display_note' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsRemindMeLater.should_display_note())
		}
		'get_note' {
			return Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsRemindMeLater.get_note()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsRemindMeLater) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsRemindMeLater) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
