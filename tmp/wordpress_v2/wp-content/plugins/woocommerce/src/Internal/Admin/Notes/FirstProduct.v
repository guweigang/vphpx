import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_FirstProduct.note_name() string {
	return 'wc-admin-first-product'
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_FirstProduct {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_FirstProduct.get_note() rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Admin_Notes_FirstProduct{}
	mut iife_result_0 := iife_temp_0.is_wc_admin_active_in_date_range(rt.new_string('week-1-4'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		return rt.new_null()
	}
	mut var_onboarding_profile := rt.call_function('get_option', [
		rt.new_string('woocommerce_onboarding_profile'),
		rt.new_array(),
	])
	if !rt.is_true(var_onboarding_profile) {
		return rt.new_null()
	}
	if !(var_onboarding_profile.array_isset(rt.new_string('setup_client')))
		|| rt.is_true(var_onboarding_profile.array_get(rt.new_string('setup_client'))) {
		return rt.new_null()
	}
	mut var_query := create_automattic_woocommerce_internal_admin_notes_wc_product_query(rt.create_array([
		rt.ArrayItem{ key: 'limit', val: 1 },
		rt.ArrayItem{ key: 'paginate', val: true },
		rt.ArrayItem{ key: 'return', val: 'ids' },
		rt.ArrayItem{ key: 'status', val: rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductStatus.publish() },
		]) },
	]))
	mut var_products := var_query.get_products()
	mut var_count := rt.get_property(var_products, 'total')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_count)))) {
		return rt.new_null()
	}
	mut var_note := create_automattic_woocommerce_admin_notes_note()
	var_note.set_title(rt.call_function('__', [
		rt.new_string('Do you need help with adding your first product?'),
		rt.new_string('woocommerce'),
	]))
	var_note.set_content(rt.call_function('__', [
		rt.new_string('This video tutorial will help you go through the process of adding your first product in WooCommerce.'),
		rt.new_string('woocommerce'),
	]))
	var_note.set_type(Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_informational())
	var_note.set_name(Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_FirstProduct.note_name())
	var_note.set_content_data(rt.new_object('stdClass', []string{},
		rt.array_to_object(rt.new_array())))
	var_note.set_source(rt.new_string('woocommerce-admin'))
	var_note.add_action(rt.new_string('first-product-watch-tutorial'), rt.call_function('__', [
		rt.new_string('Watch tutorial'),
		rt.new_string('woocommerce'),
	]),
		rt.new_string('https://www.youtube.com/watch?v=sFtXa00Jf_o&list=PLHdG8zvZd0E575Ia8Mu3w1h750YLXNfsC&index=24'))
	return mut var_note
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Product_Query {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_notes_firstproduct(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Notes_FirstProduct {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_FirstProduct{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_notes_wc_product_query(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Product_Query {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Product_Query{
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_FirstProduct) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_note' {
			return Class_Automattic_WooCommerce_Internal_Admin_Notes_FirstProduct.get_note()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_FirstProduct) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_FirstProduct) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Product_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Product_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Product_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
