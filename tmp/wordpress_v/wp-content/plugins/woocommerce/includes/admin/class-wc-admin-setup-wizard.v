import rt

struct Class_WC_Admin_Setup_Wizard {
	rt.PhpObjectBase
pub mut:
		step rt.PhpVal = rt.new_string('')
		steps rt.PhpVal = rt.new_array()
		deferred_actions rt.PhpVal = rt.new_array()
		tweets rt.PhpVal = rt.new_array()
		wc_admin_plugin_minimum_wordpress_version rt.PhpVal = rt.new_string('5.3')
}

fn (mut this Class_WC_Admin_Setup_Wizard) construct()  {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
}

fn (mut this Class_WC_Admin_Setup_Wizard) admin_menus()  {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	rt.call_function('add_dashboard_page', [rt.new_string(''), rt.new_string(''), rt.new_string('manage_options'), rt.new_string('wc-setup'), rt.new_string('')])
}

fn (mut this Class_WC_Admin_Setup_Wizard) should_show_theme() bool {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_support_woocommerce := rt.new_bool(rt.new_bool(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('woocommerce')])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_is_wp_default_theme_active', []rt.PhpVal{})))))))
	return rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_themes')])) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('switch_themes')])))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))))) && rt.is_true(rt.new_bool(!(rt.is_true(var_support_woocommerce))))
}

fn (mut this Class_WC_Admin_Setup_Wizard) should_show_automated_tax() bool {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_plugins')]))))) {
		return false
	}
	mut var_country_code := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_base_country', []rt.PhpVal{})
	mut var_tax_supported_countries := rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: 'US' }, rt.ArrayItem{ key: none, val: 'CA' }, rt.ArrayItem{ key: none, val: 'AU' }, rt.ArrayItem{ key: none, val: 'GB' }]), rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_european_union_countries', []rt.PhpVal{})])
	return (rt.call_function('in_array', [var_country_code.dup(), var_tax_supported_countries.dup(), rt.new_bool(true)])).to_bool()
}

fn (mut this Class_WC_Admin_Setup_Wizard) should_show_mailchimp() rt.PhpVal {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	return rt.call_function('current_user_can', [rt.new_string('install_plugins')])
}

fn (mut this Class_WC_Admin_Setup_Wizard) should_show_facebook() rt.PhpVal {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	return rt.call_function('current_user_can', [rt.new_string('install_plugins')])
}

fn (mut this Class_WC_Admin_Setup_Wizard) is_wc_admin_active() rt.PhpVal {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	return rt.call_function('function_exists', [rt.new_string('wc_admin_url')])
}

fn (mut this Class_WC_Admin_Setup_Wizard) should_show_wc_admin() bool {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_wordpress_minimum_met := rt.call_function('version_compare', [rt.call_function('get_bloginfo', [rt.new_string('version')]), this.wc_admin_plugin_minimum_wordpress_version, rt.new_string('>=')])
	return rt.is_true(rt.new_bool(rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_plugins')])) && rt.is_true(var_wordpress_minimum_met))) && rt.is_true(rt.new_bool(!(rt.is_true(this.is_wc_admin_active()))))
}

fn (mut this Class_WC_Admin_Setup_Wizard) should_show_wc_admin_onboarding() bool {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	return !(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_setup_wizard_force_legacy'), rt.new_bool(false)])))
}

fn (mut this Class_WC_Admin_Setup_Wizard) should_show_recommended_step() bool {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	return rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(this.should_show_theme() || this.should_show_automated_tax() || rt.is_true(this.should_show_mailchimp()))) || rt.is_true(this.should_show_facebook()))) || this.should_show_wc_admin()
}

fn (mut this Class_WC_Admin_Setup_Wizard) enqueue_scripts()  {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
}

fn (mut this Class_WC_Admin_Setup_Wizard) setup_wizard()  {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.get_superglobal('_GET').array_get('page')) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	mut var_default_steps := { 'new_onboarding': { 'name': rt.new_string(''), 'view': map[string]rt.PhpVal{}, 'handler': map[string]rt.PhpVal{} }, 'store_setup': { 'name': rt.call_function('__', [rt.new_string('Store setup'), rt.new_string('woocommerce')]), 'view': map[string]rt.PhpVal{}, 'handler': map[string]rt.PhpVal{} }, 'payment': { 'name': rt.call_function('__', [rt.new_string('Payment'), rt.new_string('woocommerce')]), 'view': map[string]rt.PhpVal{}, 'handler': map[string]rt.PhpVal{} }, 'shipping': { 'name': rt.call_function('__', [rt.new_string('Shipping'), rt.new_string('woocommerce')]), 'view': map[string]rt.PhpVal{}, 'handler': map[string]rt.PhpVal{} }, 'recommended': { 'name': rt.call_function('__', [rt.new_string('Recommended'), rt.new_string('woocommerce')]), 'view': map[string]rt.PhpVal{}, 'handler': map[string]rt.PhpVal{} }, 'activate': { 'name': rt.call_function('__', [rt.new_string('Activate'), rt.new_string('woocommerce')]), 'view': map[string]rt.PhpVal{}, 'handler': map[string]rt.PhpVal{} }, 'next_steps': { 'name': rt.call_function('__', [rt.new_string('Ready!'), rt.new_string('woocommerce')]), 'view': map[string]rt.PhpVal{}, 'handler': rt.new_string('') } }
	if !(this.should_show_wc_admin_onboarding()) {
		var_default_steps.delete('new_onboarding')
	}
	if !(this.should_show_recommended_step()) {
		var_default_steps.delete('recommended')
	}
	if rt.is_true(rt.identical(rt.new_string('virtual'), rt.call_function('get_option', [rt.new_string('woocommerce_product_type')]))) {
		var_default_steps.delete('shipping')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_plugins')]))))) {
		var_default_steps.delete('activate')
	}
	this.steps = rt.call_function('apply_filters', [rt.new_string('woocommerce_setup_wizard_steps'), var_default_steps.dup()])
	this.step = if rt.get_superglobal('_GET').array_isset(rt.new_string('step')) { rt.call_function('sanitize_key', [rt.get_superglobal('_GET').array_get('step')]) } else { rt.call_function('current', [rt.func_array_keys(this.steps)]) }
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get('save_step'))) && this.steps.array_get(this.step).array_isset(rt.new_string('handler')) {
		rt.call_function('call_user_func', [this.steps.array_get(this.step).array_get('handler'), rt.new_object('WC_Admin_Setup_Wizard', []string{}, &this)])
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	this.setup_wizard_header()
	this.setup_wizard_steps()
	this.setup_wizard_content()
	this.setup_wizard_footer()
	// unsupported expression: Expr_Exit
}

fn (mut this Class_WC_Admin_Setup_Wizard) get_next_step_link(step string) string {
	mut step_mutated := step
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(step_mutated))))) {
		step_mutated = (this.step).str()
	}
	mut var_keys := rt.func_array_keys(this.steps)
	if rt.is_true(rt.identical(rt.call_function('end', [var_keys.dup()]), rt.new_string(step_mutated))) {
		return (rt.call_function('admin_url', []rt.PhpVal{})).str()
	}
	mut var_step_index := rt.call_function('array_search', [rt.new_string(step_mutated).dup(), var_keys.dup(), rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_step_index)) {
		return ''
	}
	return (rt.call_function('add_query_arg', [rt.new_string('step'), var_keys.array_get(rt.add(var_step_index, rt.new_int(1))), rt.call_function('remove_query_arg', [rt.new_string('activate_error')])])).str()
}

fn (mut this Class_WC_Admin_Setup_Wizard) setup_wizard_header()  {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_wp_version_class := rt.new_string('branch-' + (rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '.' }, rt.ArrayItem{ key: none, val: ',' }]), rt.new_string('-'), rt.new_float(rt.call_function('get_bloginfo', [rt.new_string('version')]).to_f64())])).str())
	rt.call_function('set_current_screen', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('language_attributes', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('WooCommerce &rsaquo; Setup Wizard'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('admin_enqueue_scripts')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_print_scripts', [rt.new_string('wc-setup')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('admin_print_styles')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('admin_head')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', ['wc-setup-step__' + (this.step).str()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_wp_version_class.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('WooCommerce'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Setup_Wizard) setup_wizard_footer()  {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_current_step := this.step
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('new_onboarding'), var_current_step)) || rt.is_true(rt.identical(rt.new_string('store-setup'), var_current_step)))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [rt.call_function('admin_url', []rt.PhpVal{})]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Not right now'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('recommended'), var_current_step)) || rt.is_true(rt.identical(rt.new_string('activate'), var_current_step)))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [this.get_next_step_link('')]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Skip this step'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_setup_footer')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Setup_Wizard) setup_wizard_steps()  {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_output_steps := this.steps
	mut var_selected_features := rt.call_function('array_filter', [this.wc_setup_activate_get_feature_list()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('class_exists', [rt.new_string('Jetpack')])) && rt.is_true(fn () rt.PhpVal { mut temp := Class_Jetpack{}; return temp.is_active() }()))) && !rt.is_true(var_selected_features))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_output_steps.array_unset(rt.new_string('activate'))
	}
	var_output_steps.array_unset(rt.new_string('new_onboarding'))
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_output_steps.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_step := item_1.val
			mut var_step_key := item_1.key
			mut var_is_completed := 
			if rt.is_true() {
			} else if rt.is_true() {
			} else {
			}
		}
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Setup_Wizard) setup_wizard_content()  {
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_new_onboarding()  {
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_new_onboarding_save()  {
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_store_setup()  {
}

fn (mut this Class_WC_Admin_Setup_Wizard) tracking_modal()  {
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_store_setup_save()  {
}

fn (mut this Class_WC_Admin_Setup_Wizard) close_http_connection()  {
}

fn (mut this Class_WC_Admin_Setup_Wizard) run_deferred_actions()  {
}

fn (mut this Class_WC_Admin_Setup_Wizard) install_plugin(var_plugin_id rt.PhpVal, var_plugin_info rt.PhpVal)  {
}

fn (mut this Class_WC_Admin_Setup_Wizard) install_theme(var_theme_id rt.PhpVal)  {
}

fn (mut this Class_WC_Admin_Setup_Wizard) install_jetpack()  {
}

fn (mut this Class_WC_Admin_Setup_Wizard) install_woocommerce_services()  {
}

fn (mut this Class_WC_Admin_Setup_Wizard) get_wcs_requisite_plugins() rt.PhpVal {
}

fn (mut this Class_WC_Admin_Setup_Wizard) plugin_install_info()  {
}

fn (mut this Class_WC_Admin_Setup_Wizard) get_wizard_shipping_methods(var_country_code rt.PhpVal, var_currency_code rt.PhpVal) rt.PhpVal {
	mut var_country_code_mutated := var_country_code
	mut var_currency_code_mutated := var_currency_code
}

fn (mut this Class_WC_Admin_Setup_Wizard) shipping_method_selection_form(var_country_code rt.PhpVal, var_currency_code rt.PhpVal, var_input_prefix rt.PhpVal)  {
	mut var_country_code_mutated := var_country_code
	mut var_currency_code_mutated := var_currency_code
}

fn (mut this Class_WC_Admin_Setup_Wizard) get_product_weight_selection() rt.PhpVal {
}

fn (mut this Class_WC_Admin_Setup_Wizard) get_product_dimension_selection() rt.PhpVal {
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_shipping()  {
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_shipping_save()  {
}

fn (mut this Class_WC_Admin_Setup_Wizard) is_stripe_supported_country(var_country_code rt.PhpVal) rt.PhpVal {
	mut var_country_code_mutated := var_country_code
}

fn (mut this Class_WC_Admin_Setup_Wizard) is_paypal_supported_currency(var_currency rt.PhpVal) rt.PhpVal {
	mut var_currency_mutated := var_currency
}

fn (mut this Class_WC_Admin_Setup_Wizard) is_klarna_checkout_supported_country(var_country_code rt.PhpVal) rt.PhpVal {
	mut var_country_code_mutated := var_country_code
}

fn (mut this Class_WC_Admin_Setup_Wizard) is_klarna_payments_supported_country(var_country_code rt.PhpVal) rt.PhpVal {
	mut var_country_code_mutated := var_country_code
}

fn (mut this Class_WC_Admin_Setup_Wizard) is_square_supported_country(var_country_code rt.PhpVal) rt.PhpVal {
	mut var_country_code_mutated := var_country_code
}

fn (mut this Class_WC_Admin_Setup_Wizard) is_eway_payments_supported_country(var_country_code rt.PhpVal) rt.PhpVal {
	mut var_country_code_mutated := var_country_code
}

fn (mut this Class_WC_Admin_Setup_Wizard) is_shipstation_supported_country(var_country_code rt.PhpVal) rt.PhpVal {
	mut var_country_code_mutated := var_country_code
}

fn (mut this Class_WC_Admin_Setup_Wizard) is_wcs_shipping_labels_supported_country(var_country_code rt.PhpVal) rt.PhpVal {
	mut var_country_code_mutated := var_country_code
}

fn (mut this Class_WC_Admin_Setup_Wizard) get_current_user_email() rt.PhpVal {
}

fn (mut this Class_WC_Admin_Setup_Wizard) get_wizard_available_in_cart_payment_gateways() rt.PhpVal {
}

fn (mut this Class_WC_Admin_Setup_Wizard) get_wizard_in_cart_payment_gateways() rt.PhpVal {
}

fn (mut this Class_WC_Admin_Setup_Wizard) get_wizard_manual_payment_gateways() rt.PhpVal {
}

fn (mut this Class_WC_Admin_Setup_Wizard) display_service_item(var_item_id rt.PhpVal, var_item_info rt.PhpVal)  {
}

fn (mut this Class_WC_Admin_Setup_Wizard) is_featured_service(var_service rt.PhpVal) bool {
}

fn (mut this Class_WC_Admin_Setup_Wizard) is_not_featured_service(var_service rt.PhpVal) bool {
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_payment()  {
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_payment_save()  {
}

fn (mut this Class_WC_Admin_Setup_Wizard) display_recommended_item(var_item_info rt.PhpVal)  {
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_recommended()  {
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_recommended_save()  {
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_activate_actions()  {
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_activate_get_feature_list() rt.PhpVal {
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_activate_get_feature_list_str() bool {
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_activate()  {
}

fn (mut this Class_WC_Admin_Setup_Wizard) get_all_activate_errors() rt.PhpVal {
}

fn (mut this Class_WC_Admin_Setup_Wizard) get_activate_error_message(code string) rt.PhpVal {
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_activate_save()  {
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_ready()  {
}

struct Class_Jetpack {
	rt.PhpObjectBase
}

fn create_wc_admin_setup_wizard() &Class_WC_Admin_Setup_Wizard {
	mut obj := &Class_WC_Admin_Setup_Wizard{
		PhpObjectBase: rt.PhpObjectBase{}
		step: rt.new_string('')
		steps: rt.new_array()
		deferred_actions: rt.new_array()
		tweets: rt.new_array()
		wc_admin_plugin_minimum_wordpress_version: rt.new_string('5.3')
	}
	obj.construct()
	return obj
}

fn create_jetpack() &Class_Jetpack {
	mut obj := &Class_Jetpack{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_Setup_Wizard) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'admin_menus' {
			this.admin_menus()
			return rt.new_null()
		}
		'should_show_theme' {
			return rt.new_bool(this.should_show_theme())
		}
		'should_show_automated_tax' {
			return rt.new_bool(this.should_show_automated_tax())
		}
		'should_show_mailchimp' {
			return this.should_show_mailchimp()
		}
		'should_show_facebook' {
			return this.should_show_facebook()
		}
		'is_wc_admin_active' {
			return this.is_wc_admin_active()
		}
		'should_show_wc_admin' {
			return rt.new_bool(this.should_show_wc_admin())
		}
		'should_show_wc_admin_onboarding' {
			return rt.new_bool(this.should_show_wc_admin_onboarding())
		}
		'should_show_recommended_step' {
			return rt.new_bool(this.should_show_recommended_step())
		}
		'enqueue_scripts' {
			this.enqueue_scripts()
			return rt.new_null()
		}
		'setup_wizard' {
			this.setup_wizard()
			return rt.new_null()
		}
		'get_next_step_link' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_next_step_link(dispatch_arg_0))
		}
		'setup_wizard_header' {
			this.setup_wizard_header()
			return rt.new_null()
		}
		'setup_wizard_footer' {
			this.setup_wizard_footer()
			return rt.new_null()
		}
		'setup_wizard_steps' {
			this.setup_wizard_steps()
			return rt.new_null()
		}
		'setup_wizard_content' {
			this.setup_wizard_content()
			return rt.new_null()
		}
		'wc_setup_new_onboarding' {
			this.wc_setup_new_onboarding()
			return rt.new_null()
		}
		'wc_setup_new_onboarding_save' {
			this.wc_setup_new_onboarding_save()
			return rt.new_null()
		}
		'wc_setup_store_setup' {
			this.wc_setup_store_setup()
			return rt.new_null()
		}
		'tracking_modal' {
			this.tracking_modal()
			return rt.new_null()
		}
		'wc_setup_store_setup_save' {
			this.wc_setup_store_setup_save()
			return rt.new_null()
		}
		'close_http_connection' {
			this.close_http_connection()
			return rt.new_null()
		}
		'run_deferred_actions' {
			this.run_deferred_actions()
			return rt.new_null()
		}
		'install_plugin' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.install_plugin(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'install_theme' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.install_theme(dispatch_arg_0)
			return rt.new_null()
		}
		'install_jetpack' {
			this.install_jetpack()
			return rt.new_null()
		}
		'install_woocommerce_services' {
			this.install_woocommerce_services()
			return rt.new_null()
		}
		'get_wcs_requisite_plugins' {
			return this.get_wcs_requisite_plugins()
		}
		'plugin_install_info' {
			this.plugin_install_info()
			return rt.new_null()
		}
		'get_wizard_shipping_methods' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_wizard_shipping_methods(dispatch_arg_0, dispatch_arg_1)
		}
		'shipping_method_selection_form' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.shipping_method_selection_form(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_product_weight_selection' {
			return this.get_product_weight_selection()
		}
		'get_product_dimension_selection' {
			return this.get_product_dimension_selection()
		}
		'wc_setup_shipping' {
			this.wc_setup_shipping()
			return rt.new_null()
		}
		'wc_setup_shipping_save' {
			this.wc_setup_shipping_save()
			return rt.new_null()
		}
		'is_stripe_supported_country' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_stripe_supported_country(dispatch_arg_0)
		}
		'is_paypal_supported_currency' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_paypal_supported_currency(dispatch_arg_0)
		}
		'is_klarna_checkout_supported_country' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_klarna_checkout_supported_country(dispatch_arg_0)
		}
		'is_klarna_payments_supported_country' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_klarna_payments_supported_country(dispatch_arg_0)
		}
		'is_square_supported_country' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_square_supported_country(dispatch_arg_0)
		}
		'is_eway_payments_supported_country' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_eway_payments_supported_country(dispatch_arg_0)
		}
		'is_shipstation_supported_country' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_shipstation_supported_country(dispatch_arg_0)
		}
		'is_wcs_shipping_labels_supported_country' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_wcs_shipping_labels_supported_country(dispatch_arg_0)
		}
		'get_current_user_email' {
			return this.get_current_user_email()
		}
		'get_wizard_available_in_cart_payment_gateways' {
			return this.get_wizard_available_in_cart_payment_gateways()
		}
		'get_wizard_in_cart_payment_gateways' {
			return this.get_wizard_in_cart_payment_gateways()
		}
		'get_wizard_manual_payment_gateways' {
			return this.get_wizard_manual_payment_gateways()
		}
		'display_service_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.display_service_item(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'is_featured_service' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_featured_service(dispatch_arg_0))
		}
		'is_not_featured_service' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_not_featured_service(dispatch_arg_0))
		}
		'wc_setup_payment' {
			this.wc_setup_payment()
			return rt.new_null()
		}
		'wc_setup_payment_save' {
			this.wc_setup_payment_save()
			return rt.new_null()
		}
		'display_recommended_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.display_recommended_item(dispatch_arg_0)
			return rt.new_null()
		}
		'wc_setup_recommended' {
			this.wc_setup_recommended()
			return rt.new_null()
		}
		'wc_setup_recommended_save' {
			this.wc_setup_recommended_save()
			return rt.new_null()
		}
		'wc_setup_activate_actions' {
			this.wc_setup_activate_actions()
			return rt.new_null()
		}
		'wc_setup_activate_get_feature_list' {
			return this.wc_setup_activate_get_feature_list()
		}
		'wc_setup_activate_get_feature_list_str' {
			return rt.new_bool(this.wc_setup_activate_get_feature_list_str())
		}
		'wc_setup_activate' {
			this.wc_setup_activate()
			return rt.new_null()
		}
		'get_all_activate_errors' {
			return this.get_all_activate_errors()
		}
		'get_activate_error_message' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_activate_error_message(dispatch_arg_0)
		}
		'wc_setup_activate_save' {
			this.wc_setup_activate_save()
			return rt.new_null()
		}
		'wc_setup_ready' {
			this.wc_setup_ready()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Admin_Setup_Wizard) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'step' { return this.step }
		'steps' { return this.steps }
		'deferred_actions' { return this.deferred_actions }
		'tweets' { return this.tweets }
		'wc_admin_plugin_minimum_wordpress_version' { return this.wc_admin_plugin_minimum_wordpress_version }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Admin_Setup_Wizard) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'step' { this.step = val; return true }
		'steps' { this.steps = val; return true }
		'deferred_actions' { this.deferred_actions = val; return true }
		'tweets' { this.tweets = val; return true }
		'wc_admin_plugin_minimum_wordpress_version' { this.wc_admin_plugin_minimum_wordpress_version = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Jetpack) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Jetpack) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Jetpack) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_admin_class_wc_admin_setup_wizard_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
