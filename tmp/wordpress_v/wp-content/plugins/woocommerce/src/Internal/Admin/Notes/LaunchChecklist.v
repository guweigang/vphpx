import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_LaunchChecklist.note_name() string {
	return 'wc-admin-launch-checklist'
}
struct Class_Automattic_WooCommerce_Internal_Admin_Notes_LaunchChecklist {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_LaunchChecklist.get_note() rt.PhpVal {
	mut var_completed_tasks := rt.call_function('get_option', [rt.new_string('woocommerce_task_list_tracked_completed_tasks'), rt.new_array()])
	mut var_ten_days_in_seconds := rt.mul(rt.new_int(10), rt.get_constant('DAY_IN_SECONDS'))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [rt.new_string('woocommerce_task_list_complete')]))))) && rt.is_true(rt.new_bool(var_completed_tasks.dup().array_count() < 3 || rt.is_true(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Notes_LaunchChecklist{}; return temp.is_wc_admin_active_in_date_range(arg_0, arg_1) }(rt.new_string('week-1-4'), var_ten_days_in_seconds.dup())))))) {
		return rt.new_null()
	}
	mut var_content := rt.call_function('__', [rt.new_string('To make sure you never get that sinking "what did I forget" feeling, we\'ve put together the essential pre-launch checklist.'), rt.new_string('woocommerce')])
	mut var_note := create_automattic_woocommerce_admin_notes_note()
	var_note.set_title(rt.call_function('__', [rt.new_string('Ready to launch your store?'), rt.new_string('woocommerce')]))
	var_note.set_content(var_content.dup())
	var_note.set_content_data(// unsupported expression: Expr_Cast_Object)
	var_note.set_type(Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_informational())
	var_note.set_name(Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_LaunchChecklist.note_name())
	var_note.set_source(rt.new_string('woocommerce-admin'))
	var_note.add_action(rt.new_string('learn-more'), rt.call_function('__', [rt.new_string('Learn more'), rt.new_string('woocommerce')]), rt.new_string('https://woocommerce.com/posts/pre-launch-checklist-the-essentials/?utm_source=inbox&utm_medium=product'))
	return mut var_note
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_notes_launchchecklist() &Class_Automattic_WooCommerce_Internal_Admin_Notes_LaunchChecklist {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_LaunchChecklist{
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_LaunchChecklist) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_note' {
			return Class_Automattic_WooCommerce_Internal_Admin_Notes_LaunchChecklist.get_note()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_LaunchChecklist) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_LaunchChecklist) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_notes_launchchecklist_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
