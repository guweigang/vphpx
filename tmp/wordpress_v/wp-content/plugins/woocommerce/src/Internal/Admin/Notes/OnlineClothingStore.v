import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_OnlineClothingStore.note_name() string {
	return 'wc-admin-online-clothing-store'
}
struct Class_Automattic_WooCommerce_Internal_Admin_Notes_OnlineClothingStore {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_OnlineClothingStore.is_in_fashion_industry(var_industries rt.PhpVal) bool {
	{
		mut iter_1 := var_industries.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_industry := item_1.val
			if rt.is_true(rt.identical(rt.new_string('fashion-apparel-accessories'), var_industry.array_get('slug'))) {
				return true
			}
		}
	}
	return false
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_OnlineClothingStore.get_note() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Notes_OnlineClothingStore{}; return temp.is_wc_admin_active_in_date_range(arg_0, arg_1) }(rt.new_string('week-1'), rt.mul(rt.new_int(2), rt.get_constant('DAY_IN_SECONDS'))))))) {
		return rt.new_null()
	}
	mut var_onboarding_profile := rt.call_function('get_option', [rt.new_string('woocommerce_onboarding_profile'), rt.new_array()])
	if !rt.is_true(var_onboarding_profile) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(var_onboarding_profile.array_isset(rt.new_string('setup_client'))) || rt.is_true(var_onboarding_profile.array_get('setup_client')))) {
		return rt.new_null()
	}
	if !(var_onboarding_profile.array_isset(rt.new_string('industry'))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Internal_Admin_Notes_OnlineClothingStore.is_in_fashion_industry(var_onboarding_profile.array_get('industry')))))) {
		return rt.new_null()
	}
	mut var_note := create_automattic_woocommerce_admin_notes_note()
	var_note.set_title(rt.call_function('__', [rt.new_string('Start your online clothing store'), rt.new_string('woocommerce')]))
	var_note.set_content(rt.call_function('__', [rt.new_string('Starting a fashion website is exciting but it may seem overwhelming as well. In this article, we\'ll walk you through the setup process, teach you to create successful product listings, and show you how to market to your ideal audience.'), rt.new_string('woocommerce')]))
	var_note.set_type(Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_informational())
	var_note.set_name(Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_OnlineClothingStore.note_name())
	var_note.set_content_data(// unsupported expression: Expr_Cast_Object)
	var_note.set_source(rt.new_string('woocommerce-admin'))
	var_note.add_action(rt.new_string('online-clothing-store'), rt.call_function('__', [rt.new_string('Learn more'), rt.new_string('woocommerce')]), rt.new_string('https://woocommerce.com/posts/starting-an-online-clothing-store/?utm_source=inbox&utm_medium=product'), Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_actioned())
	return mut var_note
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_notes_onlineclothingstore() &Class_Automattic_WooCommerce_Internal_Admin_Notes_OnlineClothingStore {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_OnlineClothingStore{
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_OnlineClothingStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_in_fashion_industry' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Admin_Notes_OnlineClothingStore.is_in_fashion_industry(dispatch_arg_0))
		}
		'get_note' {
			return Class_Automattic_WooCommerce_Internal_Admin_Notes_OnlineClothingStore.get_note()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_OnlineClothingStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_OnlineClothingStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_notes_onlineclothingstore_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
