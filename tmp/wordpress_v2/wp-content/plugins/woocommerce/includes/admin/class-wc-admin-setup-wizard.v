import rt

struct Class_WC_Admin_Setup_Wizard {
	rt.PhpObjectBase
pub mut:
	step                                      rt.PhpVal = rt.new_string('')
	steps                                     rt.PhpVal = rt.new_array()
	deferred_actions                          rt.PhpVal = rt.new_array()
	tweets                                    rt.PhpVal = rt.new_array()
	wc_admin_plugin_minimum_wordpress_version rt.PhpVal = rt.new_string('5.3')
}

fn (mut this Class_WC_Admin_Setup_Wizard) construct() {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
}

fn (mut this Class_WC_Admin_Setup_Wizard) admin_menus() {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	rt.call_function('add_dashboard_page', [rt.new_string(''),
		rt.new_string(''), rt.new_string('manage_options'), rt.new_string('wc-setup'),
		rt.new_string('')])
}

fn (mut this Class_WC_Admin_Setup_Wizard) should_show_theme() bool {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_support_woocommerce := rt.new_bool(
		rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('woocommerce')]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_is_wp_default_theme_active', []rt.PhpVal{}))))))
	return rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_themes')]))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('switch_themes')]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_support_woocommerce))))
}

fn (mut this Class_WC_Admin_Setup_Wizard) should_show_automated_tax() bool {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('install_plugins'),
	])))))
	{
		return false
	}
	mut var_country_code := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'countries'), 'get_base_country', []rt.PhpVal{})
	mut var_tax_supported_countries := rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'US' },
			rt.ArrayItem{ key: none, val: 'CA' }, rt.ArrayItem{ key: none, val: 'AU' },
			rt.ArrayItem{ key: none, val: 'GB' }]),
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'),
			'get_european_union_countries', []rt.PhpVal{}),
	])
	return (rt.call_function('in_array', [var_country_code.clone(),
		var_tax_supported_countries.clone(), rt.new_bool(true)])).to_bool()
}

fn (mut this Class_WC_Admin_Setup_Wizard) should_show_mailchimp() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	return rt.call_function('current_user_can', [rt.new_string('install_plugins')])
}

fn (mut this Class_WC_Admin_Setup_Wizard) should_show_facebook() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	return rt.call_function('current_user_can', [rt.new_string('install_plugins')])
}

fn (mut this Class_WC_Admin_Setup_Wizard) is_wc_admin_active() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	return rt.call_function('function_exists', [rt.new_string('wc_admin_url')])
}

fn (mut this Class_WC_Admin_Setup_Wizard) should_show_wc_admin() bool {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_wordpress_minimum_met := rt.call_function('version_compare', [
		rt.call_function('get_bloginfo', [rt.new_string('version')]),
		this.wc_admin_plugin_minimum_wordpress_version,
		rt.new_string('>='),
	])
	return rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_plugins')]))
		&& rt.is_true(var_wordpress_minimum_met)
		&& rt.is_true(rt.new_bool(!(rt.is_true(this.is_wc_admin_active()))))
}

fn (mut this Class_WC_Admin_Setup_Wizard) should_show_wc_admin_onboarding() bool {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	return !(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_setup_wizard_force_legacy'),
		rt.new_bool(false),
	])))
}

fn (mut this Class_WC_Admin_Setup_Wizard) should_show_recommended_step() bool {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	return this.should_show_theme() || this.should_show_automated_tax()
		|| rt.is_true(this.should_show_mailchimp()) || rt.is_true(this.should_show_facebook())
		|| this.should_show_wc_admin()
}

fn (mut this Class_WC_Admin_Setup_Wizard) enqueue_scripts() {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
}

fn (mut this Class_WC_Admin_Setup_Wizard) setup_wizard() {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('page')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('wc-setup'), rt.get_superglobal('_GET').array_get(rt.new_string('page')))))) {
		return
	}
	mut var_default_steps := {
		'new_onboarding': {
			'name':    rt.new_string('')
			'view':    map[string]rt.PhpVal{}
			'handler': map[string]rt.PhpVal{}
		}
		'store_setup':    {
			'name':    rt.call_function('__', [rt.new_string('Store setup'),
				rt.new_string('woocommerce')])
			'view':    map[string]rt.PhpVal{}
			'handler': map[string]rt.PhpVal{}
		}
		'payment':        {
			'name':    rt.call_function('__', [rt.new_string('Payment'),
				rt.new_string('woocommerce')])
			'view':    map[string]rt.PhpVal{}
			'handler': map[string]rt.PhpVal{}
		}
		'shipping':       {
			'name':    rt.call_function('__', [rt.new_string('Shipping'),
				rt.new_string('woocommerce')])
			'view':    map[string]rt.PhpVal{}
			'handler': map[string]rt.PhpVal{}
		}
		'recommended':    {
			'name':    rt.call_function('__', [rt.new_string('Recommended'),
				rt.new_string('woocommerce')])
			'view':    map[string]rt.PhpVal{}
			'handler': map[string]rt.PhpVal{}
		}
		'activate':       {
			'name':    rt.call_function('__', [rt.new_string('Activate'),
				rt.new_string('woocommerce')])
			'view':    map[string]rt.PhpVal{}
			'handler': map[string]rt.PhpVal{}
		}
		'next_steps':     {
			'name':    rt.call_function('__', [rt.new_string('Ready!'),
				rt.new_string('woocommerce')])
			'view':    map[string]rt.PhpVal{}
			'handler': rt.new_string('')
		}
	}
	if !(this.should_show_wc_admin_onboarding()) {
		var_default_steps.delete('new_onboarding')
	}
	if !(this.should_show_recommended_step()) {
		var_default_steps.delete('recommended')
	}
	if rt.is_true(rt.identical(rt.new_string('virtual'), rt.call_function('get_option', [
		rt.new_string('woocommerce_product_type'),
	])))
	{
		var_default_steps.delete('shipping')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('install_plugins'),
	])))))
	{
		var_default_steps.delete('activate')
	}
	this.steps = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_setup_wizard_steps'),
		rt.create_array_from_native_map(var_default_steps),
	])
	this.step = if rt.get_superglobal('_GET').array_isset(rt.new_string('step')) { rt.call_function('sanitize_key', [
			rt.get_superglobal('_GET').array_get(rt.new_string('step')),
		]) } else { rt.call_function('current', [rt.func_array_keys(this.steps)]) }
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('save_step'))))
		&& this.steps.array_get(this.step).array_isset(rt.new_string('handler')) {
		rt.call_function('call_user_func', [this.steps.array_get(this.step).array_get(rt.new_string('handler')),
			rt.new_object('WC_Admin_Setup_Wizard', []string{}, &this)])
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	this.setup_wizard_header()
	this.setup_wizard_steps()
	this.setup_wizard_content()
	this.setup_wizard_footer()
	exit(0)
}

fn (mut this Class_WC_Admin_Setup_Wizard) get_next_step_link(step string) string {
	mut step_mutated := step
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(step_mutated))))) {
		step_mutated = (this.step).str()
	}
	mut var_keys := rt.func_array_keys(this.steps)
	if rt.is_true(rt.identical(rt.call_function('end', [var_keys.clone()]),
		rt.new_string(step_mutated)))
	{
		return (rt.call_function('admin_url', []rt.PhpVal{})).str()
	}
	mut var_step_index := rt.call_function('array_search', [rt.new_string(step_mutated).clone(),
		var_keys.clone(), rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_step_index)) {
		return ''
	}
	return (rt.call_function('add_query_arg', [rt.new_string('step'),
		var_keys.array_get(rt.add(var_step_index, rt.new_int(1))),
		rt.call_function('remove_query_arg', [rt.new_string('activate_error')])])).str()
}

fn (mut this Class_WC_Admin_Setup_Wizard) setup_wizard_header() {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_wp_version_class := rt.new_string('branch-' +(rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{
		key: none
		val: '.'
	}, rt.ArrayItem{ key: none, val: ',' }]), rt.new_string('-'), rt.new_float(rt.call_function('get_bloginfo', [rt.new_string('version')]).to_f64())])).str())
	rt.call_function('set_current_screen', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('language_attributes', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('WooCommerce &rsaquo; Setup Wizard'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('admin_enqueue_scripts')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_print_scripts', [rt.new_string('wc-setup')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('admin_print_styles')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('admin_head')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.new_string('wc-setup-step__' + (this.step).str()),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_wp_version_class.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('WooCommerce'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Setup_Wizard) setup_wizard_footer() {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_current_step := this.step
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_string('new_onboarding'), var_current_step))
		|| rt.is_true(rt.identical(rt.new_string('store-setup'), var_current_step)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('admin_url', []rt.PhpVal{}),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Not right now'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_string('recommended'), var_current_step))
		|| rt.is_true(rt.identical(rt.new_string('activate'), var_current_step)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.new_string(this.get_next_step_link('')),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Skip this step'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_setup_footer')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Setup_Wizard) setup_wizard_steps() {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_output_steps := this.steps
	mut var_selected_features := rt.call_function('array_filter', [
		this.wc_setup_activate_get_feature_list(),
	])
	mut iife_temp_0 := Class_Jetpack{}
	mut iife_result_0 := iife_temp_0.is_active()
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('Jetpack')]))
		&& rt.is_true(iife_result_0) && !rt.is_true(var_selected_features)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_transient', [rt.new_string('wc_setup_activated')]))))) {
		var_output_steps.array_unset(rt.new_string('activate'))
	}
	var_output_steps.array_unset(rt.new_string('new_onboarding'))
	// unsupported statement: Stmt_InlineHTML
	mut iter_1 := var_output_steps.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_step := item_1.val
		mut var_step_key := item_1.key
		mut var_is_completed := rt.greater(rt.call_function('array_search', [this.step,
			rt.func_array_keys(this.steps), rt.new_bool(true)]), rt.call_function('array_search', [
			var_step_key.clone(),
			rt.func_array_keys(this.steps),
			rt.new_bool(true),
		]))
		if rt.is_true(rt.identical(var_step_key, this.step)) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				var_step.array_get(rt.new_string('name')),
			]))
			// unsupported statement: Stmt_InlineHTML
		} else if rt.is_true(var_is_completed) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [
				rt.call_function('add_query_arg', [rt.new_string('step'),
					var_step_key.clone(),
					rt.call_function('remove_query_arg', [
						rt.new_string('activate_error'),
					])]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				var_step.array_get(rt.new_string('name')),
			]))
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				var_step.array_get(rt.new_string('name')),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Setup_Wizard) setup_wizard_content() {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	print('<div class="wc-setup-content">')
	if !(!rt.is_true(this.steps.array_get(this.step).array_get(rt.new_string('view')))) {
		rt.call_function('call_user_func', [this.steps.array_get(this.step).array_get(rt.new_string('view')),
			rt.new_object('WC_Admin_Setup_Wizard', []string{}, &this)])
	}
	print('</div>')
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_new_onboarding() {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Welcome to'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('WooCommerce'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Get your store up and running more quickly with our new and improved setup experience'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('wc-setup')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Yes please'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Yes please'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_wc_admin_active())))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('The "WooCommerce Admin" plugin will be installed and activated'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_new_onboarding_save() {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_store_setup() {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_address := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'countries'), 'get_base_address', []rt.PhpVal{})
	mut var_address_2 := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'countries'), 'get_base_address_2', []rt.PhpVal{})
	mut var_city := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'countries'), 'get_base_city', []rt.PhpVal{})
	mut var_state := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'countries'), 'get_base_state', []rt.PhpVal{})
	mut var_country := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'countries'), 'get_base_country', []rt.PhpVal{})
	mut var_postcode := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'countries'), 'get_base_postcode', []rt.PhpVal{})
	mut var_currency := rt.call_function('get_option', [
		rt.new_string('woocommerce_currency'),
		rt.new_string('USD'),
	])
	mut var_product_type := rt.call_function('get_option', [
		rt.new_string('woocommerce_product_type'),
		rt.new_string('both'),
	])
	mut var_sell_in_person := rt.call_function('get_option', [
		rt.new_string('woocommerce_sell_in_person'),
		rt.new_string('none_selected'),
	])
	if !rt.is_true(var_country) {
		mut iife_temp_1 := Class_WC_Geolocation{}
		mut iife_result_1 := iife_temp_1.geolocate_ip()
		mut var_user_location := iife_result_1
		var_country = var_user_location.array_get(rt.new_string('country'))
		var_state = var_user_location.array_get(rt.new_string('state'))
	}
	mut var_locale_info := rt.include_file(
		(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
		'/i18n/locale-info.php', '1')
	mut var_currency_by_country := rt.call_function('wp_list_pluck', [
		var_locale_info.clone(), rt.new_string('currency_code')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('wc-setup')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('The following wizard will help you configure your store and get you started quickly.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Where is your store based?'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Choose a country / region&hellip;'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Country / Region'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut iter_2 := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'),
		'get_countries', []rt.PhpVal{}).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_label := item_2.val
		mut var_code := item_2.key
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('selected', [var_code.clone(), var_country.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_code.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_label.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Address'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_address.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Address line 2'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_address_2.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('City'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_city.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('State'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Choose a state&hellip;'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('State'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Postcode / ZIP'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_postcode.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('What currency do you accept payments in?'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Choose a currency&hellip;'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Choose a currency&hellip;'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut iter_3 := rt.call_function('get_woocommerce_currencies', []rt.PhpVal{}).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_name := item_3.val
		mut var_code := item_3.key
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_code.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('selected', [var_currency.clone(), var_code.clone()])
		// unsupported statement: Stmt_InlineHTML
		mut var_symbol := rt.call_function('get_woocommerce_currency_symbol', [
			var_code.clone(),
		])
		if rt.is_true(rt.identical(var_symbol, var_code)) {
			rt.echo_val(rt.call_function('esc_html', [
				rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('%1$s (%2$s)'),
						rt.new_string('woocommerce')]),
					var_name.clone(),
					var_code.clone(),
				]),
			]))
		} else {
			rt.echo_val(rt.call_function('esc_html', [
				rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('%1$s (%2$s %3$s)'),
						rt.new_string('woocommerce')]),
					var_name.clone(),
					rt.call_function('get_woocommerce_currency_symbol', [
						var_code.clone()]),
					var_code.clone(),
				]),
			]))
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('rawurlencode', [
		rt.call_function('wp_json_encode', [var_currency_by_country.clone()]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [var_state.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('What type of products do you plan to sell?'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_product_type.clone(), rt.new_string('both')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('I plan to sell both physical and digital products'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_product_type.clone(), rt.new_string('physical')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('I plan to sell physical products'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_product_type.clone(), rt.new_string('virtual')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('I plan to sell digital products'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [var_sell_in_person.clone(), rt.new_bool(true)])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('I will also be selling products or services in person.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string('yes'),
		rt.call_function('get_option', [rt.new_string('woocommerce_allow_tracking'),
			rt.new_string('no')])])
	// unsupported statement: Stmt_InlineHTML
	this.tracking_modal()
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string("Let's go!"),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string("Let's go!"),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Setup_Wizard) tracking_modal() {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Help improve WooCommerce with usage tracking'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('wp_kses', [
			rt.call_function('__', [
				rt.new_string('Learn more about how usage tracking works, and how you\'ll be helping in our <a href="%1$s" target="_blank">usage tracking documentation</a>.'),
				rt.new_string('woocommerce'),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'a', val: rt.create_array([
					rt.ArrayItem{ key: 'href', val: rt.new_array() },
					rt.ArrayItem{ key: 'target', val: rt.new_array() },
				]) },
			]),
		]),
		rt.new_string('https://woocommerce.com/usage-tracking/'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string('yes'),
		rt.call_function('get_option', [rt.new_string('woocommerce_allow_tracking'),
			rt.new_string('no')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Enable usage tracking and help improve WooCommerce'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Continue'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Continue'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_store_setup_save() {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
}

fn (mut this Class_WC_Admin_Setup_Wizard) close_http_connection() {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	if rt.is_true(rt.call_function('session_id', []rt.PhpVal{})) {
		rt.call_function('session_write_close', []rt.PhpVal{})
	}
	rt.call_function('wc_set_time_limit', [rt.new_int(0)])
	if rt.is_true(rt.call_function('is_callable', [
		rt.new_string('fastcgi_finish_request'),
	]))
	{
		rt.call_function('fastcgi_finish_request', []rt.PhpVal{})
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
			rt.call_function('header', [rt.new_string('Connection: close')])
		}
		rt.call_function('ob_end_flush', []rt.PhpVal{})
		rt.call_function('flush', []rt.PhpVal{})
	}
}

fn (mut this Class_WC_Admin_Setup_Wizard) run_deferred_actions() {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	this.close_http_connection()
	mut iter_4 := this.deferred_actions.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_action := item_4.val
		rt.call_callable(var_action.array_get(rt.new_string('func')), [
			var_action.array_get(rt.new_string('args')),
		])
		if var_action.array_get(rt.new_string('func')).array_isset(rt.new_int(1))
			&& rt.is_true(rt.identical(rt.new_string('background_installer'), var_action.array_get(rt.new_string('func')).array_get(rt.new_int(1))))
			&& var_action.array_get(rt.new_string('args')).array_isset(rt.new_int(0)) {
			rt.call_function('delete_option', [
				rt.new_string('woocommerce_setup_background_installing_' +
					(var_action.array_get(rt.new_string('args')).array_get(rt.new_int(0))).str()),
			])
		}
	}
}

fn (mut this Class_WC_Admin_Setup_Wizard) install_plugin(var_plugin_id rt.PhpVal, var_plugin_info rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	if rt.is_true(rt.call_function('get_option', [
		rt.new_string('woocommerce_setup_background_installing_' + var_plugin_id.str()),
	]))
	{
		return
	}
	mut var_plugin_file := if var_plugin_info.array_isset(rt.new_string('file')) {
		var_plugin_info.array_get(rt.new_string('file'))
	} else {
		(var_plugin_info.array_get(rt.new_string('repo-slug'))).str() + '.php'
	}
	if rt.is_true(rt.call_function('is_plugin_active', [
		rt.new_string((var_plugin_info.array_get(rt.new_string('repo-slug'))).str() + '/' +
			var_plugin_file.str()),
	]))
	{
		return
	}
	if !rt.is_true(this.deferred_actions) {
		rt.call_function('add_action', [rt.new_string('shutdown'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Setup_Wizard', []string{},
					&this) },
				rt.ArrayItem{ key: none, val: 'run_deferred_actions' },
			])])
	}
	this.deferred_actions.array_push(rt.create_array([
		rt.ArrayItem{ key: 'func', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'WC_Install' },
			rt.ArrayItem{ key: none, val: 'background_installer' },
		]) },
		rt.ArrayItem{ key: 'args', val: rt.create_array([
			rt.ArrayItem{ key: none, val: var_plugin_id },
			rt.ArrayItem{ key: none, val: var_plugin_info },
		]) },
	]))
	rt.call_function('update_option', [
		rt.new_string('woocommerce_setup_background_installing_' + var_plugin_id.str()),
		rt.new_bool(true),
	])
}

fn (mut this Class_WC_Admin_Setup_Wizard) install_theme(var_theme_id rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	if !rt.is_true(this.deferred_actions) {
		rt.call_function('add_action', [rt.new_string('shutdown'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Setup_Wizard', []string{},
					&this) },
				rt.ArrayItem{ key: none, val: 'run_deferred_actions' },
			])])
	}
	this.deferred_actions.array_push(rt.create_array([
		rt.ArrayItem{ key: 'func', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'WC_Install' },
			rt.ArrayItem{ key: none, val: 'theme_background_installer' },
		]) },
		rt.ArrayItem{ key: 'args', val: rt.create_array([
			rt.ArrayItem{ key: none, val: var_theme_id },
		]) },
	]))
}

fn (mut this Class_WC_Admin_Setup_Wizard) install_jetpack() {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	this.install_plugin(rt.new_string('jetpack'), rt.create_array([
		rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
			rt.new_string('Jetpack'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'repo-slug', val: 'jetpack' },
	]))
}

fn (mut this Class_WC_Admin_Setup_Wizard) install_woocommerce_services() {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	this.install_jetpack()
	this.install_plugin(rt.new_string('woocommerce-services'), rt.create_array([
		rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
			rt.new_string('WooCommerce Services'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'repo-slug', val: 'woocommerce-services' },
	]))
}

fn (mut this Class_WC_Admin_Setup_Wizard) get_wcs_requisite_plugins() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_plugins := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_plugin_active', [rt.new_string('woocommerce-services/woocommerce-services.php')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [rt.new_string('woocommerce_setup_background_installing_woocommerce-services')]))))) {
		var_plugins.array_push(rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('WooCommerce Services'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'slug', val: 'woocommerce-services' },
		]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_plugin_active', [rt.new_string('jetpack/jetpack.php')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [rt.new_string('woocommerce_setup_background_installing_jetpack')]))))) {
		var_plugins.array_push(rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Jetpack'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'slug', val: 'jetpack' },
		]))
	}
	return var_plugins.clone()
}

fn (mut this Class_WC_Admin_Setup_Wizard) plugin_install_info() {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('The following plugins will be installed and activated for you:'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Setup_Wizard) get_wizard_shipping_methods(var_country_code rt.PhpVal, var_currency_code rt.PhpVal) rt.PhpVal {
	mut var_country_code_mutated := var_country_code
	mut var_currency_code_mutated := var_currency_code
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_shipping_methods := rt.create_array([
		rt.ArrayItem{ key: 'flat_rate', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Flat Rate'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Set a fixed price to cover shipping costs.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'settings', val: rt.create_array([
				rt.ArrayItem{ key: 'cost', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'text' },
					rt.ArrayItem{ key: 'default_value', val: rt.call_function('__', [
						rt.new_string('Cost'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('What would you like to charge for flat rate shipping?'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'required', val: true },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'free_shipping', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Free Shipping'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string("Don't charge for shipping."),
				rt.new_string('woocommerce'),
			]) },
		]) },
	])
	return var_shipping_methods.clone()
}

fn (mut this Class_WC_Admin_Setup_Wizard) shipping_method_selection_form(var_country_code rt.PhpVal, var_currency_code rt.PhpVal, var_input_prefix rt.PhpVal) {
	mut var_country_code_mutated := var_country_code
	mut var_currency_code_mutated := var_currency_code
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_selected := rt.new_string('flat_rate')
	mut var_shipping_methods := this.get_wizard_shipping_methods(var_country_code_mutated.clone(),
		var_currency_code_mutated.clone())
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.new_string('${var_input_prefix.to_string()}[method]'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.new_string('${var_input_prefix.to_string()}[method]'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_esc_json', [
		rt.call_function('wp_json_encode', [this.get_wcs_requisite_plugins()]),
	]))
	// unsupported statement: Stmt_InlineHTML
	mut iter_5 := var_shipping_methods.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_method := item_5.val
		mut var_method_id := item_5.key
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_method_id.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('selected', [var_selected.clone(), var_method_id.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_method.array_get(rt.new_string('name'))]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut iter_6 := var_shipping_methods.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_method := item_6.val
		mut var_method_id := item_6.key
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_method_id.clone()]))
		// unsupported statement: Stmt_InlineHTML
		print(if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_method_id, var_selected)))) {
			'hide'
		} else {
			''
		})
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			var_method.array_get(rt.new_string('description')),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut iter_7 := var_shipping_methods.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_method := item_7.val
		mut var_method_id := item_7.key
		// unsupported statement: Stmt_InlineHTML
		if !rt.is_true(var_method.array_get(rt.new_string('settings'))) {
			continue
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_method_id.clone()]))
		// unsupported statement: Stmt_InlineHTML
		print(if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_method_id, var_selected)))) {
			'hide'
		} else {
			''
		})
		// unsupported statement: Stmt_InlineHTML
		mut iter_8 := var_method.array_get(rt.new_string('settings')).iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_setting := item_8.val
			mut var_setting_id := item_8.key
			// unsupported statement: Stmt_InlineHTML
			mut var_method_setting_id :=
				rt.new_string('${var_input_prefix.to_string()}[${var_method_id.to_string()}][${var_setting_id.to_string()}]')
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_setting.array_get(rt.new_string('type')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_setting.array_get(rt.new_string('default_value')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_method_setting_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_method_setting_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.new_string((if rt.is_true(var_setting.array_get(rt.new_string('required'))) {
					'shipping-method-required-field'
				} else {
					''
				}).str()),
			]))
			// unsupported statement: Stmt_InlineHTML
			print(if rt.is_true(rt.identical(var_method_id, var_selected))
				&& rt.is_true(var_setting.array_get(rt.new_string('required'))) {
				'required'
			} else {
				''
			})
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				var_setting.array_get(rt.new_string('description')),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Setup_Wizard) get_product_weight_selection() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_weight_unit := rt.call_function('get_option', [
		rt.new_string('woocommerce_weight_unit'),
	])
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_weight_unit.clone(), rt.new_string('kg')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Kilograms'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_weight_unit.clone(), rt.new_string('g')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Grams'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_weight_unit.clone(), rt.new_string('lbs')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Pounds'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_weight_unit.clone(), rt.new_string('oz')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Ounces'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_WC_Admin_Setup_Wizard) get_product_dimension_selection() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_dimension_unit := rt.call_function('get_option', [
		rt.new_string('woocommerce_dimension_unit'),
	])
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_dimension_unit.clone(),
		rt.new_string('m')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Meters'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_dimension_unit.clone(),
		rt.new_string('cm')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Centimeters'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_dimension_unit.clone(),
		rt.new_string('mm')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Millimeters'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_dimension_unit.clone(),
		rt.new_string('in')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Inches'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_dimension_unit.clone(),
		rt.new_string('yd')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Yards'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_shipping() {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_country_code := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'countries'), 'get_base_country', []rt.PhpVal{})
	mut var_country_name := rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'countries'), 'countries').array_get(var_country_code)
	mut var_prefixed_country_name := rt.new_string(
		(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'estimated_for_prefix', [var_country_code.clone()])).str() +
		var_country_name.str())
	mut var_currency_code := rt.call_function('get_woocommerce_currency', []rt.PhpVal{})
	mut iife_temp_2 := Class_WC_Shipping_Zones{}
	mut iife_result_2 := iife_temp_2.get_zones()
	mut var_existing_zones := iife_result_2
	mut var_intro_text := rt.new_string('')
	if !rt.is_true(var_existing_zones) {
		var_intro_text = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string("We've created two Shipping Zones - for %s and for the rest of the world. Below you can set Flat Rate shipping costs for these Zones or offer Free Shipping."),
				rt.new_string('woocommerce'),
			]),
			var_prefixed_country_name.clone(),
		])
	}
	mut var_is_wcs_labels_supported :=
		this.is_wcs_shipping_labels_supported_country(var_country_code.clone())
	mut var_is_shipstation_supported :=
		this.is_shipstation_supported_country(var_country_code.clone())
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Shipping'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_intro_text) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [var_intro_text.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_is_wcs_labels_supported) || rt.is_true(var_is_shipstation_supported) {
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_is_wcs_labels_supported) {
			this.display_recommended_item(rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'woocommerce_services' },
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Did you know you can print shipping labels at home?'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Use WooCommerce Shipping (powered by WooCommerce Services & Jetpack) to save time at the post office by printing your shipping labels at home.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'img_url', val:
					(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
					'/assets/images/obw-woocommerce-services-icon.png' },
				rt.ArrayItem{ key: 'img_alt', val: rt.call_function('__', [
					rt.new_string('WooCommerce Services icon'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'plugins', val: this.get_wcs_requisite_plugins() },
			]))
		} else if rt.is_true(var_is_shipstation_supported) {
			this.display_recommended_item(rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'shipstation' },
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Did you know you can print shipping labels at home?'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('We recommend using ShipStation to save time at the post office by printing your shipping labels at home. Try ShipStation free for 30 days.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'img_url', val:
					(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
					'/assets/images/obw-shipstation-icon.png' },
				rt.ArrayItem{ key: 'img_alt', val: rt.call_function('__', [
					rt.new_string('ShipStation icon'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'plugins', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
							rt.new_string('ShipStation'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'slug', val: 'woocommerce-shipstation-integration' },
					]) },
				]) },
			]))
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if !rt.is_true(var_existing_zones) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Shipping Zone'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Shipping Method'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_country_name.clone()]))
		// unsupported statement: Stmt_InlineHTML
		this.shipping_method_selection_form(var_country_code.clone(), var_currency_code.clone(),
			rt.new_string('shipping_zones[domestic]'))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Locations not covered by your other zones'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
		this.shipping_method_selection_form(var_country_code.clone(), var_currency_code.clone(),
			rt.new_string('shipping_zones[intl]'))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('wp_kses', [
				rt.call_function('__', [
					rt.new_string('If you\'d like to offer <span class="help_tip" data-tip="%1$s">live rates</span> from a specific carrier (e.g. UPS) you can find a variety of extensions available for WooCommerce <a href="%2$s" target="_blank">here</a>.'),
					rt.new_string('woocommerce'),
				]),
				rt.create_array([
					rt.ArrayItem{ key: 'span', val: rt.create_array([
						rt.ArrayItem{ key: 'class', val: rt.new_array() },
						rt.ArrayItem{ key: 'data-tip', val: rt.new_array() },
					]) },
					rt.ArrayItem{ key: 'a', val: rt.create_array([
						rt.ArrayItem{ key: 'href', val: rt.new_array() },
						rt.ArrayItem{ key: 'target', val: rt.new_array() },
					]) },
				]),
			]),
			rt.call_function('esc_attr__', [
				rt.new_string('A live rate is the exact cost to ship an order, quoted directly from the shipping carrier.'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('https://woocommerce.com/product-category/woocommerce-extensions/shipping-methods/shipping-carriers/'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses', [
		rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string("We'll use %1$s for product weight and %2$s for product dimensions."),
				rt.new_string('woocommerce'),
			]),
			this.get_product_weight_selection(),
			this.get_product_dimension_selection(),
		]),
		rt.create_array([
			rt.ArrayItem{ key: 'span', val: rt.create_array([
				rt.ArrayItem{ key: 'class', val: rt.new_array() },
			]) },
			rt.ArrayItem{ key: 'select', val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.new_array() },
				rt.ArrayItem{ key: 'name', val: rt.new_array() },
				rt.ArrayItem{ key: 'class', val: rt.new_array() },
			]) },
			rt.ArrayItem{ key: 'option', val: rt.create_array([
				rt.ArrayItem{ key: 'value', val: rt.new_array() },
				rt.ArrayItem{ key: 'selected', val: rt.new_array() },
			]) },
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	this.plugin_install_info()
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Continue'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Continue'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('wc-setup')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_shipping_save() {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
}

fn (mut this Class_WC_Admin_Setup_Wizard) is_stripe_supported_country(var_country_code rt.PhpVal) rt.PhpVal {
	mut var_country_code_mutated := var_country_code
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_stripe_supported_countries := ['AU', 'AT', 'BE', 'CA', 'DK', 'FI', 'FR', 'DE', 'HK',
		'IE', 'JP', 'LU', 'NL', 'NZ', 'NO', 'SG', 'ES', 'SE', 'CH', 'GB', 'US']
	return rt.call_function('in_array', [var_country_code_mutated.clone(),
		rt.create_array_from_list(var_stripe_supported_countries),
		rt.new_bool(true)])
}

fn (mut this Class_WC_Admin_Setup_Wizard) is_paypal_supported_currency(var_currency rt.PhpVal) rt.PhpVal {
	mut var_currency_mutated := var_currency
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_supported_currencies := ['AUD', 'BRL', 'CAD', 'MXN', 'NZD', 'HKD', 'SGD', 'USD', 'EUR',
		'JPY', 'TRY', 'NOK', 'CZK', 'DKK', 'HUF', 'ILS', 'MYR', 'PHP', 'PLN', 'SEK', 'CHF', 'TWD',
		'THB', 'GBP', 'RMB', 'RUB', 'INR']
	return rt.call_function('in_array', [var_currency_mutated.clone(),
		rt.create_array_from_list(var_supported_currencies), rt.new_bool(true)])
}

fn (mut this Class_WC_Admin_Setup_Wizard) is_klarna_checkout_supported_country(var_country_code rt.PhpVal) rt.PhpVal {
	mut var_country_code_mutated := var_country_code
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_supported_countries := ['SE', 'FI', 'NO', 'NL']
	return rt.call_function('in_array', [var_country_code_mutated.clone(),
		rt.create_array_from_list(var_supported_countries), rt.new_bool(true)])
}

fn (mut this Class_WC_Admin_Setup_Wizard) is_klarna_payments_supported_country(var_country_code rt.PhpVal) rt.PhpVal {
	mut var_country_code_mutated := var_country_code
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_supported_countries := ['DK', 'DE', 'AT']
	return rt.call_function('in_array', [var_country_code_mutated.clone(),
		rt.create_array_from_list(var_supported_countries), rt.new_bool(true)])
}

fn (mut this Class_WC_Admin_Setup_Wizard) is_square_supported_country(var_country_code rt.PhpVal) rt.PhpVal {
	mut var_country_code_mutated := var_country_code
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_square_supported_countries := ['US', 'CA', 'JP', 'GB', 'AU']
	return rt.call_function('in_array', [var_country_code_mutated.clone(),
		rt.create_array_from_list(var_square_supported_countries),
		rt.new_bool(true)])
}

fn (mut this Class_WC_Admin_Setup_Wizard) is_eway_payments_supported_country(var_country_code rt.PhpVal) rt.PhpVal {
	mut var_country_code_mutated := var_country_code
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_supported_countries := ['AU', 'NZ']
	return rt.call_function('in_array', [var_country_code_mutated.clone(),
		rt.create_array_from_list(var_supported_countries), rt.new_bool(true)])
}

fn (mut this Class_WC_Admin_Setup_Wizard) is_shipstation_supported_country(var_country_code rt.PhpVal) rt.PhpVal {
	mut var_country_code_mutated := var_country_code
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_supported_countries := ['AU', 'CA', 'GB']
	return rt.call_function('in_array', [var_country_code_mutated.clone(),
		rt.create_array_from_list(var_supported_countries), rt.new_bool(true)])
}

fn (mut this Class_WC_Admin_Setup_Wizard) is_wcs_shipping_labels_supported_country(var_country_code rt.PhpVal) rt.PhpVal {
	mut var_country_code_mutated := var_country_code
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_supported_countries := ['US']
	return rt.call_function('in_array', [var_country_code_mutated.clone(),
		rt.create_array_from_list(var_supported_countries), rt.new_bool(true)])
}

fn (mut this Class_WC_Admin_Setup_Wizard) get_current_user_email() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_current_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
	mut var_user_email := rt.get_property(var_current_user, 'user_email')
	return var_user_email.clone()
}

fn (mut this Class_WC_Admin_Setup_Wizard) get_wizard_available_in_cart_payment_gateways() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_user_email := this.get_current_user_email()
	mut var_stripe_description := rt.new_string('<p>' +
		(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Accept debit and credit cards in 135+ currencies, methods such as Alipay, and one-touch checkout with Apple Pay. <a href="%s" target="_blank">Learn more</a>.'), rt.new_string('woocommerce')]), rt.new_string('https://woocommerce.com/products/stripe/')])).str() +
		'</p>')
	mut var_paypal_checkout_description := rt.new_string('<p>' +
		(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Safe and secure payments using credit cards or your customer\'s PayPal account. <a href="%s" target="_blank">Learn more</a>.'), rt.new_string('woocommerce')]), rt.new_string('https://woocommerce.com/products/woocommerce-gateway-paypal-checkout/')])).str() +
		'</p>')
	mut var_klarna_checkout_description := rt.new_string('<p>' +
		(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Full checkout experience with pay now, pay later and slice it. No credit card numbers, no passwords, no worries. <a href="%s" target="_blank">Learn more about Klarna</a>.'), rt.new_string('woocommerce')]), rt.new_string('https://woocommerce.com/products/klarna-checkout/')])).str() +
		'</p>')
	mut var_klarna_payments_description := rt.new_string('<p>' +
		(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Choose the payment that you want, pay now, pay later or slice it. No credit card numbers, no passwords, no worries. <a href="%s" target="_blank">Learn more about Klarna</a>.'), rt.new_string('woocommerce')]), rt.new_string('https://woocommerce.com/products/klarna-payments/ ')])).str() +
		'</p>')
	mut var_square_description := rt.new_string('<p>' +
		(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Securely accept credit and debit cards with one low rate, no surprise fees (custom rates available). Sell online and in store and track sales and inventory in one place. <a href="%s" target="_blank">Learn more about Square</a>.'), rt.new_string('woocommerce')]), rt.new_string('https://woocommerce.com/products/square/')])).str() +
		'</p>')
	return rt.create_array([
		rt.ArrayItem{ key: 'stripe', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('WooCommerce Stripe Gateway'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val:
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/images/stripe.png' },
			rt.ArrayItem{ key: 'description', val: var_stripe_description },
			rt.ArrayItem{ key: 'class', val: 'checked stripe-logo' },
			rt.ArrayItem{ key: 'repo-slug', val: 'woocommerce-gateway-stripe' },
			rt.ArrayItem{ key: 'settings', val: rt.create_array([
				rt.ArrayItem{ key: 'create_account', val: rt.create_array([
					rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
						rt.new_string('Set up Stripe for me using this email:'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'checkbox' },
					rt.ArrayItem{ key: 'value', val: 'yes' },
					rt.ArrayItem{ key: 'default', val: 'yes' },
					rt.ArrayItem{ key: 'placeholder', val: '' },
					rt.ArrayItem{ key: 'required', val: false },
					rt.ArrayItem{ key: 'plugins', val: this.get_wcs_requisite_plugins() },
				]) },
				rt.ArrayItem{ key: 'email', val: rt.create_array([
					rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
						rt.new_string('Stripe email address:'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'email' },
					rt.ArrayItem{ key: 'value', val: var_user_email },
					rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [
						rt.new_string('Stripe email address'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'required', val: true },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'ppec_paypal', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('WooCommerce PayPal Checkout Gateway'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val:
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/images/paypal.png' },
			rt.ArrayItem{ key: 'description', val: var_paypal_checkout_description },
			rt.ArrayItem{ key: 'enabled', val: false },
			rt.ArrayItem{ key: 'class', val: 'checked paypal-logo' },
			rt.ArrayItem{ key: 'repo-slug', val: 'woocommerce-gateway-paypal-express-checkout' },
			rt.ArrayItem{ key: 'settings', val: rt.create_array([
				rt.ArrayItem{ key: 'reroute_requests', val: rt.create_array([
					rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
						rt.new_string('Set up PayPal for me using this email:'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'checkbox' },
					rt.ArrayItem{ key: 'value', val: 'yes' },
					rt.ArrayItem{ key: 'default', val: 'yes' },
					rt.ArrayItem{ key: 'placeholder', val: '' },
					rt.ArrayItem{ key: 'required', val: false },
					rt.ArrayItem{ key: 'plugins', val: this.get_wcs_requisite_plugins() },
				]) },
				rt.ArrayItem{ key: 'email', val: rt.create_array([
					rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
						rt.new_string('Direct payments to email address:'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'email' },
					rt.ArrayItem{ key: 'value', val: var_user_email },
					rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [
						rt.new_string('Email address to receive payments'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'required', val: true },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: Class_WC_Gateway_Paypal.id(), val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('PayPal Standard'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Accept payments via PayPal using account balance or credit card.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val: '' },
			rt.ArrayItem{ key: 'settings', val: rt.create_array([
				rt.ArrayItem{ key: 'email', val: rt.create_array([
					rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
						rt.new_string('PayPal email address:'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'email' },
					rt.ArrayItem{ key: 'value', val: var_user_email },
					rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [
						rt.new_string('PayPal email address'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'required', val: true },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'klarna_checkout', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Klarna Checkout for WooCommerce'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: var_klarna_checkout_description },
			rt.ArrayItem{ key: 'image', val:
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/images/klarna-black.png' },
			rt.ArrayItem{ key: 'enabled', val: true },
			rt.ArrayItem{ key: 'class', val: 'klarna-logo' },
			rt.ArrayItem{ key: 'repo-slug', val: 'klarna-checkout-for-woocommerce' },
		]) },
		rt.ArrayItem{ key: 'klarna_payments', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Klarna Payments for WooCommerce'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: var_klarna_payments_description },
			rt.ArrayItem{ key: 'image', val:
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/images/klarna-black.png' },
			rt.ArrayItem{ key: 'enabled', val: true },
			rt.ArrayItem{ key: 'class', val: 'klarna-logo' },
			rt.ArrayItem{ key: 'repo-slug', val: 'klarna-payments-for-woocommerce' },
		]) },
		rt.ArrayItem{ key: 'square', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('WooCommerce Square'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: var_square_description },
			rt.ArrayItem{ key: 'image', val:
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/images/square-black.png' },
			rt.ArrayItem{ key: 'class', val: 'square-logo' },
			rt.ArrayItem{ key: 'enabled', val: false },
			rt.ArrayItem{ key: 'repo-slug', val: 'woocommerce-square' },
		]) },
		rt.ArrayItem{ key: 'eway', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('WooCommerce eWAY Gateway'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The eWAY extension for WooCommerce allows you to take credit card payments directly on your store without redirecting your customers to a third party site to make payment.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val:
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/images/eway-logo.jpg' },
			rt.ArrayItem{ key: 'enabled', val: false },
			rt.ArrayItem{ key: 'class', val: 'eway-logo' },
			rt.ArrayItem{ key: 'repo-slug', val: 'woocommerce-gateway-eway' },
		]) },
		rt.ArrayItem{ key: 'payfast', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('WooCommerce PayFast Gateway'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The PayFast extension for WooCommerce enables you to accept payments by Credit Card and EFT via one of South Africa’s most popular payment gateways. No setup fees or monthly subscription costs.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val:
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/images/payfast.png' },
			rt.ArrayItem{ key: 'class', val: 'payfast-logo' },
			rt.ArrayItem{ key: 'enabled', val: false },
			rt.ArrayItem{ key: 'repo-slug', val: 'woocommerce-payfast-gateway' },
			rt.ArrayItem{ key: 'file', val: 'gateway-payfast.php' },
		]) },
	])
}

fn (mut this Class_WC_Admin_Setup_Wizard) get_wizard_in_cart_payment_gateways() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_gateways := this.get_wizard_available_in_cart_payment_gateways()
	mut var_country := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'countries'), 'get_base_country', []rt.PhpVal{})
	mut var_currency := rt.call_function('get_woocommerce_currency', []rt.PhpVal{})
	mut var_can_stripe := this.is_stripe_supported_country(var_country.clone())
	mut var_can_eway := this.is_eway_payments_supported_country(var_country.clone())
	mut var_can_payfast := rt.identical(rt.new_string('ZA'), var_country)
	mut var_can_paypal := this.is_paypal_supported_currency(var_currency.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('install_plugins'),
	])))))
	{
		return if rt.is_true(var_can_paypal) { rt.create_array([
				rt.ArrayItem{
					key: Class_WC_Gateway_Paypal.id()
					val: var_gateways.array_get(Class_WC_Gateway_Paypal.id())
				},
			]) } else { rt.new_array() }
	}
	mut var_klarna_or_square := rt.new_bool(false)
	if rt.is_true(this.is_klarna_checkout_supported_country(var_country.clone())) {
		var_klarna_or_square = rt.new_string('klarna_checkout')
	} else if rt.is_true(this.is_klarna_payments_supported_country(var_country.clone())) {
		var_klarna_or_square = rt.new_string('klarna_payments')
	} else if rt.is_true(this.is_square_supported_country(var_country.clone()))
		&& rt.is_true(rt.call_function('get_option', [rt.new_string('woocommerce_sell_in_person')])) {
		var_klarna_or_square = rt.new_string('square')
	}
	mut var_offered_gateways := rt.new_array()
	if rt.is_true(var_can_stripe) {
		var_gateways.array_get_mut('stripe').array_set('enabled', true)
		var_gateways.array_get_mut('stripe').array_set('featured', true)
		var_offered_gateways = rt.add(var_offered_gateways, rt.create_array([
			rt.ArrayItem{ key: 'stripe', val: var_gateways.array_get(rt.new_string('stripe')) },
		]))
	} else if rt.is_true(var_can_paypal) {
		var_gateways.array_get_mut('ppec_paypal').array_set('enabled', true)
	}
	if rt.is_true(var_klarna_or_square) {
		if rt.is_true(rt.call_function('in_array', [var_klarna_or_square.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'klarna_checkout' },
				rt.ArrayItem{ key: none, val: 'klarna_payments' }]),
			rt.new_bool(true)]))
		{
			var_gateways.array_get_mut(var_klarna_or_square).array_set('enabled', true)
			var_gateways.array_get_mut(var_klarna_or_square).array_set('featured', false)
			var_offered_gateways = rt.add(var_offered_gateways, rt.create_array([
				rt.ArrayItem{
					key: var_klarna_or_square
					val: var_gateways.array_get(var_klarna_or_square)
				},
			]))
		} else {
			var_offered_gateways = rt.add(var_offered_gateways, rt.create_array([
				rt.ArrayItem{
					key: var_klarna_or_square
					val: var_gateways.array_get(var_klarna_or_square)
				},
			]))
		}
	}
	if rt.is_true(var_can_paypal) {
		var_offered_gateways = rt.add(var_offered_gateways, rt.create_array([
			rt.ArrayItem{
				key: 'ppec_paypal'
				val: var_gateways.array_get(rt.new_string('ppec_paypal'))
			},
		]))
	}
	if rt.is_true(var_can_eway) {
		var_offered_gateways = rt.add(var_offered_gateways, rt.create_array([
			rt.ArrayItem{ key: 'eway', val: var_gateways.array_get(rt.new_string('eway')) },
		]))
	}
	if rt.is_true(var_can_payfast) {
		var_offered_gateways = rt.add(var_offered_gateways, rt.create_array([
			rt.ArrayItem{ key: 'payfast', val: var_gateways.array_get(rt.new_string('payfast')) },
		]))
	}
	return var_offered_gateways.clone()
}

fn (mut this Class_WC_Admin_Setup_Wizard) get_wizard_manual_payment_gateways() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_gateways := rt.create_array([
		rt.ArrayItem{ key: Class_WC_Gateway_Cheque.id(), val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('_x', [
				rt.new_string('Check payments'),
				rt.new_string('Check payment method'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('A simple offline gateway that lets you accept a check as method of payment.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val: '' },
			rt.ArrayItem{ key: 'class', val: '' },
		]) },
		rt.ArrayItem{ key: Class_WC_Gateway_BACS.id(), val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Bank transfer (BACS) payments'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('A simple offline gateway that lets you accept BACS payment.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val: '' },
			rt.ArrayItem{ key: 'class', val: '' },
		]) },
		rt.ArrayItem{ key: Class_WC_Gateway_COD.id(), val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Cash on delivery'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('A simple offline gateway that lets you accept cash on delivery.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val: '' },
			rt.ArrayItem{ key: 'class', val: '' },
		]) },
	])
	return var_gateways.clone()
}

fn (mut this Class_WC_Admin_Setup_Wizard) display_service_item(var_item_id rt.PhpVal, var_item_info rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_item_class := rt.new_string('wc-wizard-service-item')
	if var_item_info.array_isset(rt.new_string('class')) {
		var_item_class = rt.concat(var_item_class, rt.new_string(' ' +
			(var_item_info.array_get(rt.new_string('class'))).str()))
	}
	mut var_previously_saved_settings := rt.call_function('get_option', [
		rt.new_string('woocommerce_' + var_item_id.str() + '_settings'),
	])
	if rt.is_true(rt.new_bool(var_previously_saved_settings.clone().is_array())) {
		mut var_should_enable_toggle := rt.new_bool(if
			var_previously_saved_settings.array_isset(rt.new_string('enabled'))
			&& rt.is_true(rt.identical(rt.new_string('yes'), var_previously_saved_settings.array_get(rt.new_string('enabled')))) {
			true
		} else {
			var_item_info.array_isset(rt.new_string('enabled'))
				&& rt.is_true(var_item_info.array_get(rt.new_string('enabled')))
		})
	} else {
		var_should_enable_toggle = rt.new_bool(var_item_info.array_isset(rt.new_string('enabled'))
			&& rt.is_true(var_item_info.array_get(rt.new_string('enabled'))))
	}
	mut var_plugins := rt.new_null()
	if var_item_info.array_isset(rt.new_string('repo-slug')) {
		mut var_plugin := {
			'slug': var_item_info.array_get(rt.new_string('repo-slug'))
			'name': var_item_info.array_get(rt.new_string('name'))
		}
		var_plugins = rt.create_array([rt.ArrayItem{ key: none, val: var_plugin }])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_item_class.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_item_info.array_get(rt.new_string('image')))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_item_info.array_get(rt.new_string('image'))]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_item_info.array_get(rt.new_string('name'))]))
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_item_info.array_get(rt.new_string('name'))]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.new_string((if rt.is_true(var_should_enable_toggle) { '' } else { 'disabled' }).str()),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_item_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_item_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [var_should_enable_toggle.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_esc_json', [
		rt.call_function('wp_json_encode', [var_plugins.clone()]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_item_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('wpautop', [var_item_info.array_get(rt.new_string('description'))]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_item_info.array_get(rt.new_string('settings')))) {
		// unsupported statement: Stmt_InlineHTML
		print(if rt.is_true(var_should_enable_toggle) { '' } else { 'hide' })
		// unsupported statement: Stmt_InlineHTML
		mut iter_9 := var_item_info.array_get(rt.new_string('settings')).iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_setting := item_9.val
			mut var_setting_id := item_9.key
			// unsupported statement: Stmt_InlineHTML
			mut var_is_checkbox := rt.identical(rt.new_string('checkbox'),
				var_setting.array_get(rt.new_string('type')))
			if rt.is_true(var_is_checkbox) {
				mut var_checked := rt.new_bool(false)
				if var_previously_saved_settings.array_isset(var_setting_id) {
					var_checked = rt.identical(rt.new_string('yes'),
						var_previously_saved_settings.array_get(var_setting_id))
				} else if
					rt.is_true(rt.identical(rt.new_bool(false), var_previously_saved_settings))
					&& var_setting.array_isset(rt.new_string('default')) {
					var_checked = rt.identical(rt.new_string('yes'),
						var_setting.array_get(rt.new_string('default')))
				}
			}
			if rt.is_true(rt.identical(rt.new_string('email'),
				var_setting.array_get(rt.new_string('type'))))
			{
				mut var_value := if !rt.is_true(var_previously_saved_settings.array_get(var_setting_id)) {
					var_setting.array_get(rt.new_string('value'))
				} else {
					var_previously_saved_settings.array_get(var_setting_id)
				}
			}
			// unsupported statement: Stmt_InlineHTML
			mut var_input_id := rt.new_string(var_item_id.str() + '_' + var_setting_id.str())
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.new_string('wc-wizard-service-setting-' + var_input_id.str()),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_input_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_input_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				var_setting.array_get(rt.new_string('label')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_setting.array_get(rt.new_string('type')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_input_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.new_string('payment-' +
					(var_setting.array_get(rt.new_string('type'))).str() + '-input'),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_input_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [if !var_value.is_null() {
				var_value
			} else {
				var_setting.array_get(rt.new_string('value'))
			}]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_setting.array_get(rt.new_string('placeholder')),
			]))
			// unsupported statement: Stmt_InlineHTML
			print(if rt.is_true(var_setting.array_get(rt.new_string('required'))) {
				'required'
			} else {
				''
			})
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(if rt.is_true(var_is_checkbox) { rt.call_function('checked', [
					rt.new_bool(!var_checked.is_null() && rt.is_true(var_checked)),
					rt.new_bool(true),
					rt.new_bool(false),
				]) } else { rt.new_string('') })
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wc_esc_json', [
				rt.call_function('wp_json_encode', [if var_setting.array_isset(rt.new_string('plugins')) {
					var_setting.array_get(rt.new_string('plugins'))
				} else {
					rt.new_null()
				}]),
			]))
			// unsupported statement: Stmt_InlineHTML
			if !(!rt.is_true(var_setting.array_get(rt.new_string('description')))) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [
					var_setting.array_get(rt.new_string('description')),
				]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Setup_Wizard) is_featured_service(var_service rt.PhpVal) bool {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	return !(!rt.is_true(var_service.array_get(rt.new_string('featured'))))
}

fn (mut this Class_WC_Admin_Setup_Wizard) is_not_featured_service(var_service rt.PhpVal) bool {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	return !(this.is_featured_service(var_service.clone()))
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_payment() {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_featured_gateways := rt.call_function('array_filter', [
		this.get_wizard_in_cart_payment_gateways(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Setup_Wizard', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'is_featured_service' },
		]),
	])
	mut var_in_cart_gateways := rt.call_function('array_filter', [
		this.get_wizard_in_cart_payment_gateways(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Setup_Wizard', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'is_not_featured_service' },
		]),
	])
	mut var_manual_gateways := this.get_wizard_manual_payment_gateways()
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Payment'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('wp_kses', [
			rt.call_function('__', [
				rt.new_string('WooCommerce can accept both online and offline payments. <a href="%s" target="_blank">Additional payment methods</a> can be installed later.'),
				rt.new_string('woocommerce'),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'a', val: rt.create_array([
					rt.ArrayItem{ key: 'href', val: rt.new_array() },
					rt.ArrayItem{ key: 'target', val: rt.new_array() },
				]) },
			]),
		]),
		rt.call_function('esc_url', [
			rt.call_function('admin_url', [
				rt.new_string('admin.php?page=wc-addons&section=payment-gateways'),
			]),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_featured_gateways) {
		// unsupported statement: Stmt_InlineHTML
		mut iter_10 := var_featured_gateways.iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_gateway := item_10.val
			mut var_gateway_id := item_10.key
			this.display_service_item(var_gateway_id.clone(), var_gateway.clone())
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_in_cart_gateways) {
		// unsupported statement: Stmt_InlineHTML
		mut iter_11 := var_in_cart_gateways.iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var_gateway := item_11.val
			mut var_gateway_id := item_11.key
			this.display_service_item(var_gateway_id.clone(), var_gateway.clone())
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Offline Payments'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Collect payments from customers offline.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	mut iter_12 := var_manual_gateways.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_gateway := item_12.val
		mut var_gateway_id := item_12.key
		this.display_service_item(var_gateway_id.clone(), var_gateway.clone())
	}
	// unsupported statement: Stmt_InlineHTML
	this.plugin_install_info()
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Continue'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Continue'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('wc-setup')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_payment_save() {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
}

fn (mut this Class_WC_Admin_Setup_Wizard) display_recommended_item(var_item_info rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_type := var_item_info.array_get(rt.new_string('type'))
	mut var_title := var_item_info.array_get(rt.new_string('title'))
	mut var_description := var_item_info.array_get(rt.new_string('description'))
	mut var_img_url := var_item_info.array_get(rt.new_string('img_url'))
	mut var_img_alt := var_item_info.array_get(rt.new_string('img_alt'))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.new_string('wc_recommended_' + var_type.str()),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string('setup_' + var_type.str())]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_esc_json', [
		rt.call_function('wp_json_encode', [if var_item_info.array_isset(rt.new_string('plugins')) {
			var_item_info.array_get(rt.new_string('plugins'))
		} else {
			rt.new_null()
		}]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.new_string('wc_recommended_' + var_type.str()),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_img_url.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.new_string('recommended-item-icon-' + var_type.str()),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_img_alt.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses', [var_description.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'a', val: rt.create_array([
				rt.ArrayItem{ key: 'href', val: rt.new_array() },
				rt.ArrayItem{ key: 'target', val: rt.new_array() },
				rt.ArrayItem{ key: 'rel', val: rt.new_array() },
			]) },
			rt.ArrayItem{ key: 'em', val: rt.new_array() },
		])]))
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_recommended() {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Recommended for All WooCommerce Stores'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Enhance your store with these recommended free features.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	if this.should_show_theme() {
		mut var_theme := rt.call_function('wp_get_theme', []rt.PhpVal{})
		mut var_theme_name := var_theme.array_get(rt.new_string('Name'))
		this.display_recommended_item(rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'storefront_theme' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Storefront Theme'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Design your store with deep WooCommerce integration. If toggled on, we’ll install <a href="https://woocommerce.com/storefront/" target="_blank" rel="noopener noreferrer">Storefront</a>, and your current theme <em>%s</em> will be deactivated.'),
					rt.new_string('woocommerce'),
				]),
				var_theme_name.clone(),
			]) },
			rt.ArrayItem{ key: 'img_url', val:
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/images/obw-storefront-icon.svg' },
			rt.ArrayItem{ key: 'img_alt', val: rt.call_function('__', [
				rt.new_string('Storefront icon'),
				rt.new_string('woocommerce'),
			]) },
		]))
	}
	if this.should_show_automated_tax() {
		this.display_recommended_item(rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'automated_taxes' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Automated Taxes'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Save time and errors with automated tax calculation and collection at checkout. Powered by WooCommerce Services and Jetpack.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'img_url', val:
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/images/obw-taxes-icon.svg' },
			rt.ArrayItem{ key: 'img_alt', val: rt.call_function('__', [
				rt.new_string('automated taxes icon'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'plugins', val: this.get_wcs_requisite_plugins() },
		]))
	}
	if this.should_show_wc_admin() {
		this.display_recommended_item(rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'wc_admin' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('WooCommerce Admin'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string("Manage your store's reports and monitor key metrics with a new and improved interface and dashboard."),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'img_url', val:
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/images/obw-woocommerce-admin-icon.svg' },
			rt.ArrayItem{ key: 'img_alt', val: rt.call_function('__', [
				rt.new_string('WooCommerce Admin icon'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'plugins', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
						rt.new_string('WooCommerce Admin'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'slug', val: 'woocommerce-admin' },
				]) },
			]) },
		]))
	}
	if rt.is_true(this.should_show_mailchimp()) {
		this.display_recommended_item(rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'mailchimp' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Mailchimp'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Join the 16 million customers who use Mailchimp. Sync list and store data to send automated emails, and targeted campaigns.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'img_url', val:
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/images/obw-mailchimp-icon.svg' },
			rt.ArrayItem{ key: 'img_alt', val: rt.call_function('__', [
				rt.new_string('Mailchimp icon'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'plugins', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
						rt.new_string('Mailchimp for WooCommerce'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'slug', val: 'mailchimp-for-woocommerce' },
				]) },
			]) },
		]))
	}
	if rt.is_true(this.should_show_facebook()) {
		this.display_recommended_item(rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'facebook' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Facebook'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Enjoy all Facebook products combined in one extension: pixel tracking, catalog sync, messenger chat, shop functionality and Instagram shopping (coming soon)!'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'img_url', val:
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/images/obw-facebook-icon.svg' },
			rt.ArrayItem{ key: 'img_alt', val: rt.call_function('__', [
				rt.new_string('Facebook icon'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'plugins', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
						rt.new_string('Facebook for WooCommerce'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'slug', val: 'facebook-for-woocommerce' },
				]) },
			]) },
		]))
	}
	// unsupported statement: Stmt_InlineHTML
	this.plugin_install_info()
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Continue'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Continue'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('wc-setup')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_recommended_save() {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_activate_actions() {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut iife_temp_3 := Class_Jetpack{}
	mut iife_result_3 := iife_temp_3.is_active()
	if rt.get_superglobal('_GET').array_isset(rt.new_string('from'))
		&& rt.is_true(rt.identical(rt.new_string('wpcom'), rt.get_superglobal('_GET').array_get(rt.new_string('from'))))
		&& rt.is_true(rt.call_function('class_exists', [rt.new_string('Jetpack')]))
		&& rt.is_true(iife_result_3) {
		rt.call_function('wp_redirect', [
			rt.call_function('esc_url_raw', [
				rt.call_function('remove_query_arg', [rt.new_string('from'),
					rt.new_string(this.get_next_step_link(''))]),
			]),
		])
		exit(0)
	}
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_activate_get_feature_list() rt.PhpVal {
	mut var_features := rt.new_array()
	mut var_stripe_settings := rt.call_function('get_option', [
		rt.new_string('woocommerce_stripe_settings'),
		rt.new_bool(false),
	])
	mut var_stripe_enabled := rt.new_bool(var_stripe_settings.clone().is_array()
		&& var_stripe_settings.array_isset(rt.new_string('create_account'))
		&& rt.is_true(rt.identical(rt.new_string('yes'), var_stripe_settings.array_get(rt.new_string('create_account'))))
		&& var_stripe_settings.array_isset(rt.new_string('enabled'))
		&& rt.is_true(rt.identical(rt.new_string('yes'), var_stripe_settings.array_get(rt.new_string('enabled')))))
	mut var_ppec_settings := rt.call_function('get_option', [
		rt.new_string('woocommerce_ppec_paypal_settings'),
		rt.new_bool(false),
	])
	mut var_ppec_enabled := rt.new_bool(var_ppec_settings.clone().is_array()
		&& var_ppec_settings.array_isset(rt.new_string('reroute_requests'))
		&& rt.is_true(rt.identical(rt.new_string('yes'), var_ppec_settings.array_get(rt.new_string('reroute_requests'))))
		&& var_ppec_settings.array_isset(rt.new_string('enabled'))
		&& rt.is_true(rt.identical(rt.new_string('yes'), var_ppec_settings.array_get(rt.new_string('enabled')))))
	var_features.array_set('payment',
		rt.is_true(var_stripe_enabled) || rt.is_true(var_ppec_enabled))
	var_features.array_set('taxes', (rt.call_function('get_option', [
		rt.new_string('woocommerce_setup_automated_taxes'),
		rt.new_bool(false),
	])).to_bool())
	var_features.array_set('labels', (rt.call_function('get_option', [
		rt.new_string('woocommerce_setup_shipping_labels'),
		rt.new_bool(false),
	])).to_bool())
	return var_features.clone()
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_activate_get_feature_list_str() bool {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_features := this.wc_setup_activate_get_feature_list()
	if rt.is_true(var_features.array_get(rt.new_string('payment')))
		&& rt.is_true(var_features.array_get(rt.new_string('taxes')))
		&& rt.is_true(var_features.array_get(rt.new_string('labels'))) {
		return (rt.call_function('__', [
			rt.new_string('payment setup, automated taxes and discounted shipping labels'),
			rt.new_string('woocommerce'),
		])).to_bool()
	} else {
		if rt.is_true(var_features.array_get(rt.new_string('payment')))
			&& rt.is_true(var_features.array_get(rt.new_string('taxes'))) {
			return (rt.call_function('__', [
				rt.new_string('payment setup and automated taxes'),
				rt.new_string('woocommerce'),
			])).to_bool()
		} else {
			if rt.is_true(var_features.array_get(rt.new_string('payment')))
				&& rt.is_true(var_features.array_get(rt.new_string('labels'))) {
				return (rt.call_function('__', [
					rt.new_string('payment setup and discounted shipping labels'),
					rt.new_string('woocommerce'),
				])).to_bool()
			} else {
				if rt.is_true(var_features.array_get(rt.new_string('payment'))) {
					return (rt.call_function('__', [rt.new_string('payment setup'),
						rt.new_string('woocommerce')])).to_bool()
				} else {
					if rt.is_true(var_features.array_get(rt.new_string('taxes')))
						&& rt.is_true(var_features.array_get(rt.new_string('labels'))) {
						return (rt.call_function('__', [
							rt.new_string('automated taxes and discounted shipping labels'),
							rt.new_string('woocommerce'),
						])).to_bool()
					} else {
						if rt.is_true(var_features.array_get(rt.new_string('taxes'))) {
							return (rt.call_function('__', [
								rt.new_string('automated taxes'),
								rt.new_string('woocommerce'),
							])).to_bool()
						} else {
							if rt.is_true(var_features.array_get(rt.new_string('labels'))) {
								return (rt.call_function('__', [
									rt.new_string('discounted shipping labels'),
									rt.new_string('woocommerce'),
								])).to_bool()
							}
						}
					}
				}
			}
		}
	}
	return false
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_activate() {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	this.wc_setup_activate_actions()
	mut iife_temp_4 := Class_Jetpack{}
	mut iife_result_4 := iife_temp_4.is_active()
	mut var_jetpack_connected := rt.new_bool(
		rt.is_true(rt.call_function('class_exists', [rt.new_string('Jetpack')]))
		&& rt.is_true(iife_result_4))
	mut var_has_jetpack_error := rt.new_bool(false)
	if rt.get_superglobal('_GET').array_isset(rt.new_string('activate_error')) {
		var_has_jetpack_error = rt.new_bool(true)
		mut var_title := rt.call_function('__', [
			rt.new_string("Sorry, we couldn't connect your store to Jetpack"),
			rt.new_string('woocommerce'),
		])
		mut var_error_message := this.get_activate_error_message((rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_GET').array_get(rt.new_string('activate_error')),
			]),
		])).str())
		mut var_description := var_error_message.clone()
	} else {
		mut var_feature_list := rt.new_bool(this.wc_setup_activate_get_feature_list_str())
		var_description = rt.new_bool(false)
		if rt.is_true(var_feature_list) {
			if rt.is_true(rt.new_bool(!(rt.is_true(var_jetpack_connected)))) {
				mut var_description_base := rt.call_function('__', [
					rt.new_string('Your store is almost ready! To activate services like %s, just connect with Jetpack.'),
					rt.new_string('woocommerce'),
				])
			} else {
				var_description_base = rt.call_function('__', [
					rt.new_string('Thanks for using Jetpack! Your store is almost ready: to activate services like %s, just connect your store.'),
					rt.new_string('woocommerce'),
				])
			}
			var_description = rt.call_function('sprintf', [var_description_base.clone(),
				var_feature_list.clone()])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_jetpack_connected)))) {
			var_title = if rt.is_true(var_feature_list) { rt.call_function('__', [
					rt.new_string('Connect your store to Jetpack'),
					rt.new_string('woocommerce'),
				]) } else { rt.call_function('__', [
					rt.new_string('Connect your store to Jetpack to enable extra features'),
					rt.new_string('woocommerce'),
				]) }
			mut var_button_text := rt.call_function('__', [
				rt.new_string('Continue with Jetpack'),
				rt.new_string('woocommerce'),
			])
		} else if rt.is_true(var_feature_list) {
			var_title = rt.call_function('__', [
				rt.new_string('Connect your store to activate WooCommerce Services'),
				rt.new_string('woocommerce'),
			])
			var_button_text = rt.call_function('__', [
				rt.new_string('Continue with WooCommerce Services'),
				rt.new_string('woocommerce'),
			])
		} else {
			rt.call_function('wp_redirect', [
				rt.call_function('esc_url_raw', [
					rt.new_string(this.get_next_step_link('')),
				]),
			])
			exit(0)
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [rt.new_string(var_description.str())]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_jetpack_connected) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.new_string(
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/images/jetpack_horizontal_logo.png'),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Jetpack logo'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.new_string(
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/images/wcs-notice.png'),
		]))
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.new_string(
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/images/jetpack_vertical_logo.png'),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Jetpack logo'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_has_jetpack_error) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.new_string(this.get_next_step_link('')),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Finish setting up your store'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('wp_kses_post', [
				rt.call_function('__', [
					rt.new_string('By connecting your site you agree to our fascinating <a href="%1$s" target="_blank">Terms of Service</a> and to <a href="%2$s" target="_blank">share details</a> with WordPress.com'),
					rt.new_string('woocommerce'),
				]),
			]),
			rt.new_string('https://wordpress.com/tos'),
			rt.new_string('https://jetpack.com/support/what-data-does-jetpack-sync'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_button_text.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_button_text.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_nonce_field', [rt.new_string('wc-setup')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(!(rt.is_true(var_jetpack_connected)))) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [if rt.is_true(var_description) { rt.call_function('__', [
					rt.new_string("Bonus reasons you'll love Jetpack"),
					rt.new_string('woocommerce'),
				]) } else { rt.call_function('__', [
					rt.new_string("Reasons you'll love Jetpack"),
					rt.new_string('woocommerce'),
				]) }]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Better security'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [
				rt.new_string('Protect your store from unauthorized access.'),
				rt.new_string('woocommerce'),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Store stats'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [
				rt.new_string('Get insights on how your store is doing, including total sales, top products, and more.'),
				rt.new_string('woocommerce'),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Store monitoring'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [
				rt.new_string('Get an alert if your store is down for even a few minutes.'),
				rt.new_string('woocommerce'),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Product promotion'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [
				rt.new_string("Share new items on social media the moment they're live in your store."),
				rt.new_string('woocommerce'),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Setup_Wizard) get_all_activate_errors() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	return rt.create_array([
		rt.ArrayItem{ key: 'default', val: rt.call_function('__', [
			rt.new_string("Sorry! We tried, but we couldn't connect Jetpack just now 😭. Please go to the Plugins tab to connect Jetpack, so that you can finish setting up your store."),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'jetpack_cant_be_installed', val: rt.call_function('__', [
			rt.new_string("Sorry! We tried, but we couldn't install Jetpack for you 😭. Please go to the Plugins tab to install it, and finish setting up your store."),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'register_http_request_failed', val: rt.call_function('__', [
			rt.new_string("Sorry! We couldn't contact Jetpack just now 😭. Please make sure that your site is visible over the internet, and that it accepts incoming and outgoing requests via curl. You can also try to connect to Jetpack again, and if you run into any more issues, please contact support."),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'siteurl_private_ip_dev', val: rt.call_function('__', [
			rt.new_string('Your site might be on a private network. Jetpack can only connect to public sites. Please make sure your site is visible over the internet, and then try connecting again 🙏.'),
			rt.new_string('woocommerce'),
		]) },
	])
}

fn (mut this Class_WC_Admin_Setup_Wizard) get_activate_error_message(code string) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut var_errors := this.get_all_activate_errors()
	return if rt.is_true(rt.new_bool(var_errors.clone().array_isset(rt.new_string(code)))) {
		var_errors.array_get(rt.new_string(code))
	} else {
		var_errors.array_get(rt.new_string('default'))
	}
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_activate_save() {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
}

fn (mut this Class_WC_Admin_Setup_Wizard) wc_setup_ready() {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('4.6.0'), rt.new_string('Onboarding is maintained in WooCommerce Admin.')])
	mut iife_temp_5 := Class_WC_Admin_Notices{}
	mut iife_result_5 := iife_temp_5.remove_notice(rt.new_string('install'), rt.new_bool(true))
	mut var_user_email := this.get_current_user_email()
	mut var_docs_url :=
		rt.new_string('https://woocommerce.com/documentation/plugins/woocommerce/getting-started/?utm_source=setupwizard&utm_medium=product&utm_content=docs&utm_campaign=woocommerceplugin')
	mut var_help_text := rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('Visit WooCommerce.com to learn more about <a href="%1$s" target="_blank">getting started</a>.'),
			rt.new_string('woocommerce'),
		]),
		var_docs_url.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string("You're ready to start selling!"),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string("We're here for you — get tips, product updates, and inspiration straight to your mailbox."),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_user_email.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Email address'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Yes please!'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Yes please!'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Next step'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Create some products'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string("You're ready to add products to your store."),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [
			rt.new_string('post-new.php?post_type=product&tutorial=true'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Create a product'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Have an existing store?'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Import products'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Transfer existing products to your new store — just import a CSV file.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [
			rt.new_string('edit.php?post_type=product&page=product_importer'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Import products'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('You can also:'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Visit Dashboard'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Review Settings'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('add_query_arg', [
			rt.create_array([
				rt.ArrayItem{ key: 'autofocus', val: rt.create_array([
					rt.ArrayItem{ key: 'panel', val: 'woocommerce' },
				]) },
				rt.ArrayItem{ key: 'url', val: rt.call_function('wc_get_page_permalink', [
					rt.new_string('shop'),
				]) },
			]),
			rt.call_function('admin_url', [
				rt.new_string('customize.php'),
			]),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('View &amp; Customize'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [var_help_text.clone()]))
	// unsupported statement: Stmt_InlineHTML
}

struct Class_Jetpack {
	rt.PhpObjectBase
}

struct Class_WC_Geolocation {
	rt.PhpObjectBase
}

struct Class_WC_Shipping_Zones {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Notices {
	rt.PhpObjectBase
}

fn create_wc_admin_setup_wizard() &Class_WC_Admin_Setup_Wizard {
	mut obj := &Class_WC_Admin_Setup_Wizard{
		PhpObjectBase:                             rt.PhpObjectBase{}
		step:                                      rt.new_string('')
		steps:                                     rt.new_array()
		deferred_actions:                          rt.new_array()
		tweets:                                    rt.new_array()
		wc_admin_plugin_minimum_wordpress_version: rt.new_string('5.3')
	}
	obj.construct()
	return obj
}

fn create_jetpack(_args ...rt.PhpVal) &Class_Jetpack {
	mut obj := &Class_Jetpack{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_geolocation(_args ...rt.PhpVal) &Class_WC_Geolocation {
	mut obj := &Class_WC_Geolocation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shipping_zones(_args ...rt.PhpVal) &Class_WC_Shipping_Zones {
	mut obj := &Class_WC_Shipping_Zones{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_notices(_args ...rt.PhpVal) &Class_WC_Admin_Notices {
	mut obj := &Class_WC_Admin_Notices{
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
		else {
			return none
		}
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
		'step' {
			this.step = val
			return true
		}
		'steps' {
			this.steps = val
			return true
		}
		'deferred_actions' {
			this.deferred_actions = val
			return true
		}
		'tweets' {
			this.tweets = val
			return true
		}
		'wc_admin_plugin_minimum_wordpress_version' {
			this.wc_admin_plugin_minimum_wordpress_version = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_WC_Geolocation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Geolocation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Geolocation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Shipping_Zones) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shipping_Zones) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping_Zones) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Admin_Notices) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Notices) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Notices) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
