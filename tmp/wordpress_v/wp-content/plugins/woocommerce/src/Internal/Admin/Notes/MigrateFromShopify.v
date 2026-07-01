import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_MigrateFromShopify.note_name() string {
	return 'wc-admin-migrate-from-shopify'
}
struct Class_Automattic_WooCommerce_Internal_Admin_Notes_MigrateFromShopify {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_MigrateFromShopify.get_note() rt.PhpVal {
	mut var_two_days := rt.mul(rt.new_int(2), rt.get_constant('DAY_IN_SECONDS'))
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Notes_MigrateFromShopify{}; return temp.is_wc_admin_active_in_date_range(arg_0, arg_1) }(rt.new_string('week-1'), var_two_days.dup()))))) {
		return rt.new_null()
	}
	mut var_onboarding_profile := rt.call_function('get_option', [rt.new_string('woocommerce_onboarding_profile'), rt.new_array()])
	if !(var_onboarding_profile.array_isset(rt.new_string('setup_client'))) || !(var_onboarding_profile.array_isset(rt.new_string('selling_venues'))) || !(var_onboarding_profile.array_isset(rt.new_string('other_platform'))) {
		return rt.new_null()
	}
	if rt.is_true(var_onboarding_profile.array_get('setup_client')) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	mut var_note := create_automattic_woocommerce_admin_notes_note()
	var_note.set_title(rt.call_function('__', [rt.new_string('Do you want to migrate from Shopify to WooCommerce?'), rt.new_string('woocommerce')]))
	var_note.set_content(rt.call_function('__', [rt.new_string('Changing eCommerce platforms might seem like a big hurdle to overcome, but it is easier than you might think to move your products, customers, and orders to WooCommerce. This article will help you with going through this process.'), rt.new_string('woocommerce')]))
	var_note.set_type(Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_informational())
	var_note.set_name(Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_MigrateFromShopify.note_name())
	var_note.set_content_data(// unsupported expression: Expr_Cast_Object)
	var_note.set_source(rt.new_string('woocommerce-admin'))
	var_note.add_action(rt.new_string('migrate-from-shopify'), rt.call_function('__', [rt.new_string('Learn more'), rt.new_string('woocommerce')]), rt.new_string('https://woocommerce.com/posts/migrate-from-shopify-to-woocommerce/?utm_source=inbox&utm_medium=product'), Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_actioned())
	return mut var_note
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_notes_migratefromshopify() &Class_Automattic_WooCommerce_Internal_Admin_Notes_MigrateFromShopify {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_MigrateFromShopify{
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_MigrateFromShopify) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_note' {
			return Class_Automattic_WooCommerce_Internal_Admin_Notes_MigrateFromShopify.get_note()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_MigrateFromShopify) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_MigrateFromShopify) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_notes_migratefromshopify_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
