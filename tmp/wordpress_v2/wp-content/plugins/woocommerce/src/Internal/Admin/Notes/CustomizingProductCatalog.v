import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_CustomizingProductCatalog.note_name() string {
	return 'wc-admin-customizing-product-catalog'
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_CustomizingProductCatalog {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_CustomizingProductCatalog.get_note() rt.PhpVal {
	mut var_query := create_automattic_woocommerce_internal_admin_notes_wc_product_query(rt.create_array([
		rt.ArrayItem{ key: 'limit', val: 1 },
		rt.ArrayItem{ key: 'paginate', val: true },
		rt.ArrayItem{ key: 'status', val: rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductStatus.publish() },
		]) },
		rt.ArrayItem{ key: 'orderby', val: 'post_date' },
		rt.ArrayItem{ key: 'order', val: 'DESC' },
	]))
	mut var_products := var_query.get_products()
	if rt.is_true(rt.identical(rt.new_int(0), rt.get_property(var_products, 'total'))) {
		return rt.new_null()
	}
	mut var_product := rt.get_property(var_products, 'products').array_get(rt.new_int(0))
	mut var_created_timestamp := rt.call_method(rt.call_method(var_product, 'get_date_created',
		[]rt.PhpVal{}), 'getTimestamp', []rt.PhpVal{})
	mut var_is_a_day_old := rt.greater_equal(rt.sub(rt.call_function('time', []rt.PhpVal{}),
		var_created_timestamp), rt.get_constant('DAY_IN_SECONDS'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_a_day_old)))) {
		return rt.new_null()
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Admin_Notes_CustomizingProductCatalog{}
	mut iife_result_0 := iife_temp_0.wc_admin_active_for(rt.mul(rt.get_constant('DAY_IN_SECONDS'),
		rt.new_int(14)))
	if rt.is_true(iife_result_0) {
		return rt.new_null()
	}
	mut var_note := create_automattic_woocommerce_admin_notes_note()
	var_note.set_title(rt.call_function('__', [
		rt.new_string('How to customize your product catalog'),
		rt.new_string('woocommerce'),
	]))
	var_note.set_content(rt.call_function('__', [
		rt.new_string('You want your product catalog and images to look great and align with your brand. This guide will give you all the tips you need to get your products looking great in your store.'),
		rt.new_string('woocommerce'),
	]))
	var_note.set_type(Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_informational())
	var_note.set_name(Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_CustomizingProductCatalog.note_name())
	var_note.set_content_data(rt.new_object('stdClass', []string{},
		rt.array_to_object(rt.new_array())))
	var_note.set_source(rt.new_string('woocommerce-admin'))
	var_note.add_action(rt.new_string('day-after-first-product'), rt.call_function('__', [
		rt.new_string('Learn more'),
		rt.new_string('woocommerce'),
	]),
		rt.new_string('https://woocommerce.com/document/woocommerce-customizer/?utm_source=inbox&utm_medium=product'))
	return mut var_note
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Product_Query {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_notes_customizingproductcatalog(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Notes_CustomizingProductCatalog {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_CustomizingProductCatalog{
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_CustomizingProductCatalog) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_note' {
			return Class_Automattic_WooCommerce_Internal_Admin_Notes_CustomizingProductCatalog.get_note()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_CustomizingProductCatalog) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_CustomizingProductCatalog) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
