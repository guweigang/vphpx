import rt

struct Class_Automattic_WooCommerce_Internal_Admin_SystemStatusReport {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Internal_Admin_SystemStatusReport.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_SystemStatusReport) construct()  {
	rt.call_function('add_action', [rt.new_string('woocommerce_system_status_report'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_SystemStatusReport', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'system_status_report' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_SystemStatusReport) system_status_report()  {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Admin'), rt.new_string('woocommerce')])
	rt.echo_val(rt.call_function('wc_help_tip', [rt.call_function('esc_html__', [rt.new_string('This section shows details of WC Admin.'), rt.new_string('woocommerce')])]))
	// unsupported statement: Stmt_InlineHTML
	this.render_features()
	this.render_daily_cron()
	this.render_options()
	this.render_notes()
	this.render_onboarding_state()
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_SystemStatusReport) render_features()  {
	mut var_features := rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_get_feature_config'), rt.call_function('wc_admin_get_feature_config', []rt.PhpVal{})])
	mut var_enabled_features := rt.call_function('array_filter', [var_features.dup()])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_feature := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(!rt.is_true(var_feature))
	}
	mut var_disabled_features := rt.call_function('array_filter', [var_features.dup(), rt.new_closure(closure_1_fn)])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Enabled Features'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [rt.call_function('esc_html__', [rt.new_string('Which features are enabled?'), rt.new_string('woocommerce')])]))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [rt.call_function('implode', [rt.new_string(', '), rt.func_array_keys(var_enabled_features.dup())])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Disabled Features'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [rt.call_function('esc_html__', [rt.new_string('Which features are disabled?'), rt.new_string('woocommerce')])]))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [rt.call_function('implode', [rt.new_string(', '), rt.func_array_keys(var_disabled_features.dup())])]))
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_SystemStatusReport) render_daily_cron()  {
	mut var_next_daily_cron := rt.call_function('wp_next_scheduled', [rt.new_string('wc_admin_daily')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Daily Cron'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [rt.call_function('esc_html__', [rt.new_string('Is the daily cron job active, when does it next run?'), rt.new_string('woocommerce')])]))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	if !rt.is_true(var_next_daily_cron) {
		print('<mark class="error"><span class="dashicons dashicons-warning"></span> ' + (rt.call_function('esc_html__', [rt.new_string('Not scheduled'), rt.new_string('woocommerce')])).str() + '</mark>')
	} else {
		print('<mark class="yes"><span class="dashicons dashicons-yes"></span> Next scheduled: ' + (rt.call_function('esc_html', [rt.call_function('date_i18n', [rt.new_string('Y-m-d H:i:s P'), var_next_daily_cron.dup()])])).str() + '</mark>')
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_SystemStatusReport) render_options()  {
	mut var_woocommerce_admin_install_timestamp := rt.call_function('get_option', [rt.new_string('woocommerce_admin_install_timestamp')])
	mut var_all_options_expected := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_woocommerce_admin_install_timestamp.dup().is_long() || var_woocommerce_admin_install_timestamp.dup().is_double())) && rt.is_true(rt.less(rt.new_int(0), // unsupported expression: Expr_Cast_Int)))) && rt.is_true(rt.new_bool(rt.call_function('get_option', [rt.new_string('woocommerce_onboarding_profile'), rt.new_array()]).is_array()))))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Options'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [rt.call_function('esc_html__', [rt.new_string('Do the important options return expected values?'), rt.new_string('woocommerce')])]))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_all_options_expected) {
		print('<mark class="yes"><span class="dashicons dashicons-yes"></span></mark>')
	} else {
		print('<mark class="error"><span class="dashicons dashicons-warning"></span> ' + (rt.call_function('esc_html__', [rt.new_string('Not all expected'), rt.new_string('woocommerce')])).str() + '</mark>')
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_SystemStatusReport) render_notes()  {
	mut var_notes_count := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Notes_Notes{}; return temp.get_notes_count() }()
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Notes'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [rt.call_function('esc_html__', [rt.new_string('How many notes in the database?'), rt.new_string('woocommerce')])]))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_notes_count.dup()]))
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_SystemStatusReport) render_onboarding_state()  {
	mut var_onboarding_profile := rt.call_function('get_option', [rt.new_string('woocommerce_onboarding_profile'), rt.new_array()])
	mut var_onboarding_state := rt.new_string(rt.new_string('-'))
	if rt.is_true(rt.new_bool(var_onboarding_profile.array_isset(rt.new_string('skipped')) && rt.is_true(var_onboarding_profile.array_get('skipped')))) {
		var_onboarding_state = rt.new_string(rt.new_string('skipped'))
	}
	if rt.is_true(rt.new_bool(var_onboarding_profile.array_isset(rt.new_string('completed')) && rt.is_true(var_onboarding_profile.array_get('completed')))) {
		var_onboarding_state = rt.new_string(rt.new_string('completed'))
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Onboarding'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [rt.call_function('esc_html__', [rt.new_string('Was onboarding completed or skipped?'), rt.new_string('woocommerce')])]))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_onboarding_state.dup()]))
	// unsupported statement: Stmt_InlineHTML
}

struct Class_Automattic_WooCommerce_Admin_Notes_Notes {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_systemstatusreport() &Class_Automattic_WooCommerce_Internal_Admin_SystemStatusReport {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_SystemStatusReport{
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_SystemStatusReport) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			return Class_Automattic_WooCommerce_Internal_Admin_SystemStatusReport.get_instance()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'system_status_report' {
			this.system_status_report()
			return rt.new_null()
		}
		'render_features' {
			this.render_features()
			return rt.new_null()
		}
		'render_daily_cron' {
			this.render_daily_cron()
			return rt.new_null()
		}
		'render_options' {
			this.render_options()
			return rt.new_null()
		}
		'render_notes' {
			this.render_notes()
			return rt.new_null()
		}
		'render_onboarding_state' {
			this.render_onboarding_state()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_SystemStatusReport) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_SystemStatusReport) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_systemstatusreport_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
