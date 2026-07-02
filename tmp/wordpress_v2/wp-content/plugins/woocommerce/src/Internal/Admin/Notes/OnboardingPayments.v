import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_OnboardingPayments.note_name() string {
	return 'wc-admin-onboarding-payments-reminder'
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_OnboardingPayments {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_OnboardingPayments.get_note() rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Admin_Notes_OnboardingPayments{}
	mut iife_result_0 := iife_temp_0.is_wc_admin_active_in_date_range(rt.new_string('week-1-4'), rt.mul(rt.new_int(5),
		rt.get_constant('DAY_IN_SECONDS')))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		return rt.new_null()
	}
	mut var_gateways := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'payment_gateways'), 'get_available_payment_gateways', []rt.PhpVal{})
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_gateway := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Notes_Note](rt.identical(rt.new_string('yes'), rt.get_property(var_gateway,
			'enabled')))
	}
	mut var_enabled_gateways := rt.call_function('array_filter', [
		var_gateways.clone(), rt.new_closure(closure_2_fn)])
	if !(!rt.is_true(var_enabled_gateways)) {
		return rt.new_null()
	}
	mut var_note := create_automattic_woocommerce_admin_notes_note()
	var_note.set_title(rt.call_function('__', [
		rt.new_string('Start accepting payments on your store!'),
		rt.new_string('woocommerce'),
	]))
	var_note.set_content(rt.call_function('__', [
		rt.new_string('Take payments with the provider that’s right for you - choose from 100+ payment gateways for WooCommerce.'),
		rt.new_string('woocommerce'),
	]))
	var_note.set_type(Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_informational())
	var_note.set_name(Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_OnboardingPayments.note_name())
	var_note.set_content_data(rt.new_object('stdClass', []string{},
		rt.array_to_object(rt.new_array())))
	var_note.set_source(rt.new_string('woocommerce-admin'))
	var_note.add_action(rt.new_string('view-payment-gateways'), rt.call_function('__', [
		rt.new_string('Learn more'),
		rt.new_string('woocommerce'),
	]),
		rt.new_string('https://woocommerce.com/product-category/woocommerce-extensions/payment-gateways/?utm_medium=product'),
		Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_actioned(), rt.new_bool(true))
	return mut var_note
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_notes_onboardingpayments(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Notes_OnboardingPayments {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_OnboardingPayments{
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_OnboardingPayments) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_note' {
			return Class_Automattic_WooCommerce_Internal_Admin_Notes_OnboardingPayments.get_note()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_OnboardingPayments) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_OnboardingPayments) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
