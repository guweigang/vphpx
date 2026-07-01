import rt

struct Class_Automattic_WooCommerce_Internal_Admin_ActivityPanels {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Internal_Admin_ActivityPanels.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ActivityPanels) construct()  {
	rt.call_function('add_filter', [rt.new_string('woocommerce_admin_get_user_data_fields'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ActivityPanels', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_user_data_fields' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_components_settings'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ActivityPanels', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'component_settings' }]), rt.new_int(20)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_admin_shared_settings'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ActivityPanels', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'component_settings' }]), rt.new_int(20)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ActivityPanels) add_user_data_fields(var_user_data_fields rt.PhpVal) rt.PhpVal {
	return rt.call_function('array_merge', [var_user_data_fields.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'activity_panel_inbox_last_read' }, rt.ArrayItem{ key: none, val: 'activity_panel_reviews_last_read' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ActivityPanels) component_settings(var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	var_settings_mutated.array_set('alertCount', fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Notes_Notes{}; return temp.get_notes_count(arg_0, arg_1) }(rt.create_array([rt.ArrayItem{ key: none, val: 'error' }, rt.ArrayItem{ key: none, val: 'update' }]), rt.create_array([rt.ArrayItem{ key: none, val: 'unactioned' }])))
	return var_settings_mutated.dup()
}

struct Class_Automattic_WooCommerce_Admin_Notes_Notes {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_activitypanels() &Class_Automattic_WooCommerce_Internal_Admin_ActivityPanels {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_ActivityPanels{
		PhpObjectBase: rt.PhpObjectBase{}
		instance: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_notes_notes() &Class_Automattic_WooCommerce_Admin_Notes_Notes {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Notes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ActivityPanels) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			return Class_Automattic_WooCommerce_Internal_Admin_ActivityPanels.get_instance()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'add_user_data_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_user_data_fields(dispatch_arg_0)
		}
		'component_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.component_settings(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_ActivityPanels) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ActivityPanels) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_activitypanels_php() {
}
