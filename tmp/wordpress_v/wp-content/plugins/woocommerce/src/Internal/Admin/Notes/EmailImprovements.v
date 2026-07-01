import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_EmailImprovements.note_name() string {
	return 'wc-admin-email-improvements'
}
struct Class_Automattic_WooCommerce_Internal_Admin_Notes_EmailImprovements {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_EmailImprovements.get_note() rt.PhpVal {
	if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements{}; return temp.is_email_improvements_enabled_for_existing_stores() }()) {
		return Class_Automattic_WooCommerce_Internal_Admin_Notes_EmailImprovements.get_email_improvements_enabled_note()
	}
	if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements{}; return temp.should_notify_merchant_about_email_improvements() }()) {
		return Class_Automattic_WooCommerce_Internal_Admin_Notes_EmailImprovements.get_try_email_improvements_note()
	}
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_EmailImprovements.get_email_improvements_enabled_note() rt.PhpVal {
	mut var_note := create_automattic_woocommerce_admin_notes_note()
	var_note.set_title(rt.call_function('__', [rt.new_string('Your store emails have had an upgrade!'), rt.new_string('woocommerce')]))
	var_note.set_content(rt.call_function('__', [rt.new_string('We’ve made some exciting improvements to your email templates, including modern, shopper-friendly designs and new customization options. And if you’re using a block theme, you can automatically sync your theme styles! Head to your email settings to explore the new changes.'), rt.new_string('woocommerce')]))
	var_note.set_type(Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_informational())
	var_note.set_name(Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_EmailImprovements.note_name())
	var_note.set_source(rt.new_string('woocommerce-admin'))
	var_note.add_action(rt.new_string('customize-your-emails'), rt.call_function('__', [rt.new_string('Customize your emails'), rt.new_string('woocommerce')]), rt.new_string('?page=wc-settings&tab=email'))
	return mut var_note
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_EmailImprovements.get_try_email_improvements_note() rt.PhpVal {
	mut var_note := create_automattic_woocommerce_admin_notes_note()
	var_note.set_title(rt.call_function('__', [rt.new_string('Store emails have had an upgrade!'), rt.new_string('woocommerce')]))
	var_note.set_content(rt.call_function('__', [rt.new_string('We’ve made some exciting improvements to our email templates, including modern, shopper-friendly designs and new customization options. And if you’re using a block theme, you can automatically sync your theme styles! Head to your email settings to explore the new features.'), rt.new_string('woocommerce')]))
	var_note.set_type(Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_informational())
	var_note.set_name(Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_EmailImprovements.note_name())
	var_note.set_source(rt.new_string('woocommerce-admin'))
	var_note.add_action(rt.new_string('try-the-new-templates'), rt.call_function('__', [rt.new_string('Try the new templates'), rt.new_string('woocommerce')]), rt.new_string('?page=wc-settings&tab=email&try-new-templates'))
	return mut var_note
}

struct Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_notes_emailimprovements() &Class_Automattic_WooCommerce_Internal_Admin_Notes_EmailImprovements {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_EmailImprovements{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_emailimprovements_emailimprovements() &Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements{
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_EmailImprovements) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_note' {
			return Class_Automattic_WooCommerce_Internal_Admin_Notes_EmailImprovements.get_note()
		}
		'get_email_improvements_enabled_note' {
			return Class_Automattic_WooCommerce_Internal_Admin_Notes_EmailImprovements.get_email_improvements_enabled_note()
		}
		'get_try_email_improvements_note' {
			return Class_Automattic_WooCommerce_Internal_Admin_Notes_EmailImprovements.get_try_email_improvements_note()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_EmailImprovements) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_EmailImprovements) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_notes_emailimprovements_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
