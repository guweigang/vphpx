import rt

struct Class_WC_Admin_Setup_Wizard_Tracking {
	rt.PhpObjectBase
pub mut:
		steps rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Admin_Setup_Wizard_Tracking) init()  {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.call_function('__', [rt.new_string('Onboarding is maintained in WooCommerce Admin.'), rt.new_string('woocommerce')])])
}

fn (mut this Class_WC_Admin_Setup_Wizard_Tracking) get_current_step() rt.PhpVal {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.call_function('__', [rt.new_string('Onboarding is maintained in WooCommerce Admin.'), rt.new_string('woocommerce')])])
	return if rt.get_superglobal('_GET').array_isset(rt.new_string('step')) { rt.call_function('sanitize_key', [rt.get_superglobal('_GET').array_get('step')]) } else { rt.new_string('') }
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn (mut this Class_WC_Admin_Setup_Wizard_Tracking) add_footer_scripts()  {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.call_function('__', [rt.new_string('Onboarding is maintained in WooCommerce Admin.'), rt.new_string('woocommerce')])])
}

fn (mut this Class_WC_Admin_Setup_Wizard_Tracking) dequeue_non_allowed_scripts()  {
	mut var_wp_scripts := rt.new_null()
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.call_function('__', [rt.new_string('Onboarding is maintained in WooCommerce Admin.'), rt.new_string('woocommerce')])])
	// unsupported statement: Stmt_Global
	mut var_allowed := ['woo-tracks']
	{
		mut iter_1 := rt.get_property(var_wp_scripts, 'queue').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_script := item_1.val
			if rt.is_true(rt.call_function('in_array', [var_script.dup(), var_allowed.dup(), rt.new_bool(true)])) {
				continue
			}
			rt.call_function('wp_dequeue_script', [var_script.dup()])
		}
	}
}

fn (mut this Class_WC_Admin_Setup_Wizard_Tracking) track_start(var_option rt.PhpVal, var_value rt.PhpVal)  {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.call_function('__', [rt.new_string('Onboarding is maintained in WooCommerce Admin.'), rt.new_string('woocommerce')])])
}

fn (mut this Class_WC_Admin_Setup_Wizard_Tracking) track_ready_next_steps()  {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.call_function('__', [rt.new_string('Onboarding is maintained in WooCommerce Admin.'), rt.new_string('woocommerce')])])
}

fn (mut this Class_WC_Admin_Setup_Wizard_Tracking) add_step_save_events()  {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.call_function('__', [rt.new_string('Onboarding is maintained in WooCommerce Admin.'), rt.new_string('woocommerce')])])
}

fn (mut this Class_WC_Admin_Setup_Wizard_Tracking) track_store_setup()  {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.call_function('__', [rt.new_string('Onboarding is maintained in WooCommerce Admin.'), rt.new_string('woocommerce')])])
}

fn (mut this Class_WC_Admin_Setup_Wizard_Tracking) track_payments()  {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.call_function('__', [rt.new_string('Onboarding is maintained in WooCommerce Admin.'), rt.new_string('woocommerce')])])
}

fn (mut this Class_WC_Admin_Setup_Wizard_Tracking) track_shipping()  {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.call_function('__', [rt.new_string('Onboarding is maintained in WooCommerce Admin.'), rt.new_string('woocommerce')])])
}

fn (mut this Class_WC_Admin_Setup_Wizard_Tracking) track_recommended()  {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.call_function('__', [rt.new_string('Onboarding is maintained in WooCommerce Admin.'), rt.new_string('woocommerce')])])
}

fn (mut this Class_WC_Admin_Setup_Wizard_Tracking) track_jetpack_activate()  {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.call_function('__', [rt.new_string('Onboarding is maintained in WooCommerce Admin.'), rt.new_string('woocommerce')])])
}

fn (mut this Class_WC_Admin_Setup_Wizard_Tracking) track_next_steps()  {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.call_function('__', [rt.new_string('Onboarding is maintained in WooCommerce Admin.'), rt.new_string('woocommerce')])])
}

fn (mut this Class_WC_Admin_Setup_Wizard_Tracking) track_skip_step()  {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.call_function('__', [rt.new_string('Onboarding is maintained in WooCommerce Admin.'), rt.new_string('woocommerce')])])
}

fn (mut this Class_WC_Admin_Setup_Wizard_Tracking) set_obw_steps(var_steps rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.call_function('__', [rt.new_string('Onboarding is maintained in WooCommerce Admin.'), rt.new_string('woocommerce')])])
	this.steps = var_steps.dup()
	return var_steps.dup()
}

fn create_wc_admin_setup_wizard_tracking() &Class_WC_Admin_Setup_Wizard_Tracking {
	mut obj := &Class_WC_Admin_Setup_Wizard_Tracking{
		PhpObjectBase: rt.PhpObjectBase{}
		steps: rt.new_array()
	}
	return obj
}

fn (mut this Class_WC_Admin_Setup_Wizard_Tracking) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'get_current_step' {
			return this.get_current_step()
		}
		'add_footer_scripts' {
			this.add_footer_scripts()
			return rt.new_null()
		}
		'dequeue_non_allowed_scripts' {
			this.dequeue_non_allowed_scripts()
			return rt.new_null()
		}
		'track_start' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.track_start(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'track_ready_next_steps' {
			this.track_ready_next_steps()
			return rt.new_null()
		}
		'add_step_save_events' {
			this.add_step_save_events()
			return rt.new_null()
		}
		'track_store_setup' {
			this.track_store_setup()
			return rt.new_null()
		}
		'track_payments' {
			this.track_payments()
			return rt.new_null()
		}
		'track_shipping' {
			this.track_shipping()
			return rt.new_null()
		}
		'track_recommended' {
			this.track_recommended()
			return rt.new_null()
		}
		'track_jetpack_activate' {
			this.track_jetpack_activate()
			return rt.new_null()
		}
		'track_next_steps' {
			this.track_next_steps()
			return rt.new_null()
		}
		'track_skip_step' {
			this.track_skip_step()
			return rt.new_null()
		}
		'set_obw_steps' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.set_obw_steps(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_Admin_Setup_Wizard_Tracking) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'steps' { return this.steps }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Admin_Setup_Wizard_Tracking) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'steps' { this.steps = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_includes_tracks_events_class_wc_admin_setup_wizard_tracking_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
