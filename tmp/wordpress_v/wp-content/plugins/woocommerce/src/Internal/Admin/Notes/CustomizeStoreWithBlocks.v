import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_CustomizeStoreWithBlocks.note_name() string {
	return 'wc-admin-customize-store-with-blocks'
}
struct Class_Automattic_WooCommerce_Internal_Admin_Notes_CustomizeStoreWithBlocks {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_CustomizeStoreWithBlocks.get_note() rt.PhpVal {
	mut var_onboarding_profile := rt.call_function('get_option', [rt.new_string('woocommerce_onboarding_profile'), rt.new_array()])
	if !rt.is_true(var_onboarding_profile) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(var_onboarding_profile.array_isset(rt.new_string('setup_client'))) || rt.is_true(var_onboarding_profile.array_get('setup_client')))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Notes_CustomizeStoreWithBlocks{}; return temp.is_wc_admin_active_in_date_range(arg_0, arg_1) }(rt.new_string('week-1-4'), rt.mul(rt.new_int(14), rt.get_constant('DAY_IN_SECONDS'))))))) {
		return rt.new_null()
	}
	mut var_query := create_automattic_woocommerce_internal_admin_notes_wc_product_query(rt.create_array([rt.ArrayItem{ key: 'limit', val: 1 }, rt.ArrayItem{ key: 'return', val: 'ids' }, rt.ArrayItem{ key: 'status', val: rt.create_array([rt.ArrayItem{ key: none, val: 'publish' }]) }]))
	mut var_products := var_query.get_products()
	if 0 == var_products.dup().array_count() {
		return rt.new_null()
	}
	mut var_note := create_automattic_woocommerce_admin_notes_note()
	var_note.set_title(rt.call_function('__', [rt.new_string('Customize your online store with WooCommerce blocks'), rt.new_string('woocommerce')]))
	var_note.set_content(rt.call_function('__', [rt.new_string('With our blocks, you can select and display products, categories, filters, and more virtually anywhere on your site — no need to use shortcodes or edit lines of code. Learn more about how to use each one of them.'), rt.new_string('woocommerce')]))
	var_note.set_type(Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_informational())
	var_note.set_name(Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_CustomizeStoreWithBlocks.note_name())
	var_note.set_content_data(// unsupported expression: Expr_Cast_Object)
	var_note.set_source(rt.new_string('woocommerce-admin'))
	var_note.add_action(rt.new_string('customize-store-with-blocks'), rt.call_function('__', [rt.new_string('Learn more'), rt.new_string('woocommerce')]), rt.new_string('https://woocommerce.com/posts/how-to-customize-your-online-store-with-woocommerce-blocks/?utm_source=inbox&utm_medium=product'), Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_actioned())
	return mut var_note
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Product_Query {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_notes_customizestorewithblocks() &Class_Automattic_WooCommerce_Internal_Admin_Notes_CustomizeStoreWithBlocks {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_CustomizeStoreWithBlocks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_notes_wc_product_query() &Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Product_Query {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Product_Query{
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_CustomizeStoreWithBlocks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_note' {
			return Class_Automattic_WooCommerce_Internal_Admin_Notes_CustomizeStoreWithBlocks.get_note()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_CustomizeStoreWithBlocks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_CustomizeStoreWithBlocks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_notes_customizestorewithblocks_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
