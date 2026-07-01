import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_MagentoMigration.note_name() string {
	return 'wc-admin-magento-migration'
}
struct Class_Automattic_WooCommerce_Internal_Admin_Notes_MagentoMigration {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_MagentoMigration) construct()  {
	rt.call_function('add_action', ['update_option_' + (Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.data_option()).str(), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'possibly_add_note' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_admin_magento_migration_note'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'save_note' }])])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_MagentoMigration.possibly_add_note()  {
	mut var_onboarding_profile := rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.data_option(), rt.new_array()])
	if !rt.is_true(var_onboarding_profile) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(var_onboarding_profile.array_isset(rt.new_string('other_platform'))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(var_onboarding_profile.array_isset(rt.new_string('setup_client'))) || rt.is_true(var_onboarding_profile.array_get('setup_client')))) {
		return rt.new_null()
	}
	rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue', []rt.PhpVal{}), 'schedule_single', [rt.add(rt.call_function('time', []rt.PhpVal{}), rt.mul(rt.new_int(5), rt.get_constant('MINUTE_IN_SECONDS'))), rt.new_string('woocommerce_admin_magento_migration_note')])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_MagentoMigration.save_note()  {
	mut var_note := Class_Automattic_WooCommerce_Internal_Admin_Notes_MagentoMigration.get_note()
	if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Notes_MagentoMigration{}; return temp.note_exists() }()) {
		return rt.new_null()
	}
	rt.call_method(var_note, 'save', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_MagentoMigration.get_note() rt.PhpVal {
	mut var_note := create_automattic_woocommerce_admin_notes_note()
	rt.call_method(var_note, 'set_title', [rt.call_function('__', [rt.new_string('How to Migrate from Magento to WooCommerce'), rt.new_string('woocommerce')])])
	rt.call_method(var_note, 'set_content', [rt.call_function('__', [rt.new_string('Changing platforms might seem like a big hurdle to overcome, but it is easier than you might think to move your products, customers, and orders to WooCommerce. This article will help you with going through this process.'), rt.new_string('woocommerce')])])
	rt.call_method(var_note, 'set_content_data', [// unsupported expression: Expr_Cast_Object])
	rt.call_method(var_note, 'set_type', [Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_informational()])
	rt.call_method(var_note, 'set_name', [Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_MagentoMigration.note_name()])
	rt.call_method(var_note, 'set_source', [rt.new_string('woocommerce-admin')])
	rt.call_method(var_note, 'add_action', [rt.new_string('learn-more'), rt.call_function('__', [rt.new_string('Learn more'), rt.new_string('woocommerce')]), rt.new_string('https://woocommerce.com/posts/how-migrate-from-magento-to-woocommerce/?utm_source=inbox')])
	return var_note.dup()
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_notes_magentomigration() &Class_Automattic_WooCommerce_Internal_Admin_Notes_MagentoMigration {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_MagentoMigration{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_notes_note() &Class_Automattic_WooCommerce_Admin_Notes_Note {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Note{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_MagentoMigration) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'possibly_add_note' {
			Class_Automattic_WooCommerce_Internal_Admin_Notes_MagentoMigration.possibly_add_note()
			return rt.new_null()
		}
		'save_note' {
			Class_Automattic_WooCommerce_Internal_Admin_Notes_MagentoMigration.save_note()
			return rt.new_null()
		}
		'get_note' {
			return Class_Automattic_WooCommerce_Internal_Admin_Notes_MagentoMigration.get_note()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_MagentoMigration) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_MagentoMigration) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_notes_magentomigration_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
