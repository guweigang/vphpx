import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_EUVATNumber.note_name() string {
	return 'wc-admin-eu-vat-number'
}
struct Class_Automattic_WooCommerce_Internal_Admin_Notes_EUVATNumber {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_EUVATNumber.get_note() rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	mut var_country_code := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_base_country', []rt.PhpVal{})
	mut var_eu_countries := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_european_union_countries', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_country_code.dup(), var_eu_countries.dup(), rt.new_bool(true)]))))) {
		return rt.new_null()
	}
	mut var_content := rt.call_function('__', [rt.new_string('If your store is based in the EU, we recommend using the EU VAT Number extension in addition to automated taxes. It provides your checkout with a field to collect and validate a customer\'s EU VAT number, if they have one.'), rt.new_string('woocommerce')])
	mut var_note := create_automattic_woocommerce_admin_notes_note()
	var_note.set_title(rt.call_function('__', [rt.new_string('Collect and validate EU VAT numbers at checkout'), rt.new_string('woocommerce')]))
	var_note.set_content(var_content.dup())
	var_note.set_content_data(// unsupported expression: Expr_Cast_Object)
	var_note.set_type(Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_marketing())
	var_note.set_name(Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_EUVATNumber.note_name())
	var_note.set_source(rt.new_string('woocommerce-admin'))
	var_note.add_action(rt.new_string('learn-more'), rt.call_function('__', [rt.new_string('Learn more'), rt.new_string('woocommerce')]), rt.new_string('https://woocommerce.com/products/eu-vat-number/?utm_medium=product'), Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_actioned())
	return mut var_note
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_notes_euvatnumber() &Class_Automattic_WooCommerce_Internal_Admin_Notes_EUVATNumber {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_EUVATNumber{
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_EUVATNumber) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_note' {
			return Class_Automattic_WooCommerce_Internal_Admin_Notes_EUVATNumber.get_note()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_EUVATNumber) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_EUVATNumber) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_notes_euvatnumber_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
