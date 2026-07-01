import rt

pub fn Class_Automattic_WooCommerce_Internal_Email_EmailStyleSync.auto_sync_option() string {
	return 'woocommerce_email_auto_sync_with_theme'
}
struct Class_Automattic_WooCommerce_Internal_Email_EmailStyleSync {
	rt.PhpObjectBase
pub mut:
		is_syncing bool
}

fn (mut this Class_Automattic_WooCommerce_Internal_Email_EmailStyleSync) register()  {
	rt.call_function('add_action', [rt.new_string('after_switch_theme'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Email_EmailStyleSync', ['RegisterHooksInterface'], &this) }, rt.ArrayItem{ key: none, val: 'sync_email_styles_with_theme' }])])
	rt.call_function('add_action', [rt.new_string('customize_save_after'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Email_EmailStyleSync', ['RegisterHooksInterface'], &this) }, rt.ArrayItem{ key: none, val: 'sync_email_styles_with_theme' }])])
	rt.call_function('add_action', [rt.new_string('wp_theme_json_data_updated'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Email_EmailStyleSync', ['RegisterHooksInterface'], &this) }, rt.ArrayItem{ key: none, val: 'sync_email_styles_with_theme' }])])
	rt.call_function('add_action', [rt.new_string('rest_after_insert_global_styles'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Email_EmailStyleSync', ['RegisterHooksInterface'], &this) }, rt.ArrayItem{ key: none, val: 'sync_email_styles_with_theme' }])])
	rt.call_function('add_action', [rt.new_string('update_option_wp_global_styles'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Email_EmailStyleSync', ['RegisterHooksInterface'], &this) }, rt.ArrayItem{ key: none, val: 'sync_email_styles_with_theme' }])])
	rt.call_function('add_action', [rt.new_string('save_post_wp_global_styles'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Email_EmailStyleSync', ['RegisterHooksInterface'], &this) }, rt.ArrayItem{ key: none, val: 'sync_email_styles_with_theme' }])])
	rt.call_function('add_action', [rt.new_string('wp_ajax_wp_save_styles'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Email_EmailStyleSync', ['RegisterHooksInterface'], &this) }, rt.ArrayItem{ key: none, val: 'sync_email_styles_with_theme' }]), rt.new_int(999)])
	rt.call_function('add_action', ['update_option_' + (Class_Automattic_WooCommerce_Internal_Email_Automattic_WooCommerce_Internal_Email_EmailStyleSync.auto_sync_option()).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Email_EmailStyleSync', ['RegisterHooksInterface'], &this) }, rt.ArrayItem{ key: none, val: 'maybe_sync_on_option_update' }]), rt.new_int(10), rt.new_int(3)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Email_EmailStyleSync) maybe_sync_on_option_update(var_old_value rt.PhpVal, var_new_value rt.PhpVal, var_option rt.PhpVal)  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('yes'), var_new_value)) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		this.is_syncing = true
		this.update_email_colors()
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto finally_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()

finally_label_1:
		this.is_syncing = false
		if rt.has_exception() { return }

end_label_1:
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Email_EmailStyleSync) is_auto_sync_enabled() rt.PhpVal {
	return rt.identical(rt.new_string('yes'), rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_Email_Automattic_WooCommerce_Internal_Email_EmailStyleSync.auto_sync_option(), rt.new_string('no')]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Email_EmailStyleSync) set_auto_sync(enabled bool) rt.PhpVal {
	return rt.call_function('update_option', [Class_Automattic_WooCommerce_Internal_Email_Automattic_WooCommerce_Internal_Email_EmailStyleSync.auto_sync_option(), if var_enabled { rt.new_string('yes') } else { rt.new_string('no') }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Email_EmailStyleSync) sync_email_styles_with_theme()  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(this.is_syncing) || rt.is_true(rt.new_bool(!(rt.is_true(this.is_auto_sync_enabled())))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_theme_has_theme_json', []rt.PhpVal{}))))))) {
		return rt.new_null()
	}
	this.is_syncing = true
	this.update_email_colors()
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto finally_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()

finally_label_2:
	this.is_syncing = false
	if rt.has_exception() { return }

end_label_2:
}

fn (mut this Class_Automattic_WooCommerce_Internal_Email_EmailStyleSync) update_email_colors()  {
	mut var_colors := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Email_EmailColors{}; return temp.get_default_colors() }()
	if !rt.is_true(var_colors) {
		return rt.new_null()
	}
	if !(!rt.is_true(var_colors.array_get('base'))) {
		rt.call_function('update_option', [rt.new_string('woocommerce_email_base_color'), var_colors.array_get('base')])
	}
	if !(!rt.is_true(var_colors.array_get('bg'))) {
		rt.call_function('update_option', [rt.new_string('woocommerce_email_background_color'), var_colors.array_get('bg')])
	}
	if !(!rt.is_true(var_colors.array_get('body_bg'))) {
		rt.call_function('update_option', [rt.new_string('woocommerce_email_body_background_color'), var_colors.array_get('body_bg')])
	}
	if !(!rt.is_true(var_colors.array_get('body_text'))) {
		rt.call_function('update_option', [rt.new_string('woocommerce_email_text_color'), var_colors.array_get('body_text')])
	}
	if !(!rt.is_true(var_colors.array_get('footer_text'))) {
		rt.call_function('update_option', [rt.new_string('woocommerce_email_footer_text_color'), var_colors.array_get('footer_text')])
	}
}

struct Class_Automattic_WooCommerce_Internal_Email_EmailColors {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_email_emailstylesync() &Class_Automattic_WooCommerce_Internal_Email_EmailStyleSync {
	mut obj := &Class_Automattic_WooCommerce_Internal_Email_EmailStyleSync{
		PhpObjectBase: rt.PhpObjectBase{}
		is_syncing: false
	}
	return obj
}

fn create_automattic_woocommerce_internal_email_emailcolors() &Class_Automattic_WooCommerce_Internal_Email_EmailColors {
	mut obj := &Class_Automattic_WooCommerce_Internal_Email_EmailColors{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Email_EmailStyleSync) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			this.register()
			return rt.new_null()
		}
		'maybe_sync_on_option_update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.maybe_sync_on_option_update(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'is_auto_sync_enabled' {
			return this.is_auto_sync_enabled()
		}
		'set_auto_sync' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.set_auto_sync(dispatch_arg_0)
		}
		'sync_email_styles_with_theme' {
			this.sync_email_styles_with_theme()
			return rt.new_null()
		}
		'update_email_colors' {
			this.update_email_colors()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Email_EmailStyleSync) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'is_syncing' { return rt.new_bool(this.is_syncing) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Email_EmailStyleSync) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'is_syncing' { this.is_syncing = (val).to_bool(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_Email_EmailColors) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Email_EmailColors) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Email_EmailColors) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_email_emailstylesync_php() {
	// unsupported statement: Stmt_Declare
}
