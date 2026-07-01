import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_ScheduledUpdatesPromotion.note_name() string {
	return 'wc-admin-scheduled-updates-promotion'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_ScheduledUpdatesPromotion.option_name() string {
	return 'woocommerce_analytics_scheduled_import'
}
struct Class_Automattic_WooCommerce_Internal_Admin_Notes_ScheduledUpdatesPromotion {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_ScheduledUpdatesPromotion) construct()  {
	rt.call_function('add_action', [rt.new_string('woocommerce_note_action_scheduled-updates-enable'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Notes_ScheduledUpdatesPromotion', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'enable_scheduled_updates' }])])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_ScheduledUpdatesPromotion.is_applicable() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}; return temp.is_enabled(arg_0) }(rt.new_string('analytics-scheduled-import')))))) {
		return false
	}
	mut var_immediate_import := rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_ScheduledUpdatesPromotion.option_name(), rt.new_bool(false)])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return false
	}
	return true
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_ScheduledUpdatesPromotion.get_note() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Internal_Admin_Notes_ScheduledUpdatesPromotion.is_applicable())))) {
		return rt.new_null()
	}
	mut var_note := create_automattic_woocommerce_admin_notes_note()
	var_note.set_title(rt.call_function('__', [rt.new_string('Analytics now supports scheduled updates'), rt.new_string('woocommerce')]))
	var_note.set_content(rt.call_function('__', [rt.new_string('This provides improved performance to your store, enable it in Analytics > Settings.'), rt.new_string('woocommerce')]))
	var_note.set_content_data(// unsupported expression: Expr_Cast_Object)
	var_note.set_type(Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_informational())
	var_note.set_name(Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_ScheduledUpdatesPromotion.note_name())
	var_note.set_source(rt.new_string('woocommerce-admin'))
	var_note.add_action(rt.new_string('scheduled-updates-enable'), rt.call_function('__', [rt.new_string('Enable'), rt.new_string('woocommerce')]), rt.call_function('wc_admin_url', []rt.PhpVal{}), Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_actioned(), rt.new_bool(true), rt.call_function('__', [rt.new_string('Scheduled updates enabled'), rt.new_string('woocommerce')]))
	return rt.new_object('Automattic_WooCommerce_Admin_Notes_Note', []string{}, var_note)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_ScheduledUpdatesPromotion) enable_scheduled_updates(var_note rt.PhpVal)  {
	mut var_note_mutated := var_note
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	rt.call_function('update_option', [Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_ScheduledUpdatesPromotion.option_name(), rt.new_string('yes')])
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_notes_scheduledupdatespromotion() &Class_Automattic_WooCommerce_Internal_Admin_Notes_ScheduledUpdatesPromotion {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_ScheduledUpdatesPromotion{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_features_features() &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_ScheduledUpdatesPromotion) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'is_applicable' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Admin_Notes_ScheduledUpdatesPromotion.is_applicable())
		}
		'get_note' {
			return Class_Automattic_WooCommerce_Internal_Admin_Notes_ScheduledUpdatesPromotion.get_note()
		}
		'enable_scheduled_updates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.enable_scheduled_updates(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_ScheduledUpdatesPromotion) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_ScheduledUpdatesPromotion) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_notes_scheduledupdatespromotion_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
