import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommerceSubscriptions.note_name() string {
	return 'wc-admin-woocommerce-subscriptions'
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommerceSubscriptions {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommerceSubscriptions.get_note() rt.PhpVal {
	mut var_onboarding_data := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.data_option(),
		rt.new_array(),
	])
	if !(var_onboarding_data.array_isset(rt.new_string('product_types')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('subscriptions'), var_onboarding_data.array_get(rt.new_string('product_types')), rt.new_bool(true)]))))) {
		return rt.new_null()
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommerceSubscriptions{}
	mut iife_result_0 := iife_temp_0.is_wc_admin_active_in_date_range(rt.new_string('week-1'),
		rt.get_constant('DAY_IN_SECONDS'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		return rt.new_null()
	}
	mut var_note := create_automattic_woocommerce_admin_notes_note()
	var_note.set_title(rt.call_function('__', [
		rt.new_string('Do you need more info about WooCommerce Subscriptions?'),
		rt.new_string('woocommerce'),
	]))
	var_note.set_content(rt.call_function('__', [
		rt.new_string('WooCommerce Subscriptions allows you to introduce a variety of subscriptions for physical or virtual products and services. Create product-of-the-month clubs, weekly service subscriptions or even yearly software billing packages. Add sign-up fees, offer free trials, or set expiration periods.'),
		rt.new_string('woocommerce'),
	]))
	var_note.set_type(Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_marketing())
	var_note.set_name(Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_WooCommerceSubscriptions.note_name())
	var_note.set_content_data(rt.new_object('stdClass', []string{},
		rt.array_to_object(rt.new_array())))
	var_note.set_source(rt.new_string('woocommerce-admin'))
	var_note.add_action(rt.new_string('learn-more'), rt.call_function('__', [
		rt.new_string('Learn More'),
		rt.new_string('woocommerce'),
	]),
		rt.new_string('https://woocommerce.com/products/woocommerce-subscriptions/?utm_source=inbox&utm_medium=product'),
		Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_unactioned(),
		rt.new_bool(true))
	return mut var_note
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_notes_woocommercesubscriptions(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommerceSubscriptions {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommerceSubscriptions{
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommerceSubscriptions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_note' {
			return Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommerceSubscriptions.get_note()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommerceSubscriptions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommerceSubscriptions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
