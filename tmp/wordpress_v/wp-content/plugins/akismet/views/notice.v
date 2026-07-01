import rt

struct Class_Akismet_Admin {
	rt.PhpObjectBase
}

struct Class_Akismet {
	rt.PhpObjectBase
}

fn create_akismet_admin() &Class_Akismet_Admin {
	mut obj := &Class_Akismet_Admin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_akismet() &Class_Akismet {
	mut obj := &Class_Akismet{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Akismet_Admin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Akismet_Admin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet_Admin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Akismet) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Akismet) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_akismet_views_notice_php() {
	mut var_link_text := rt.new_null()
	mut var_code := rt.new_null()
	mut var_parent_view := rt.new_null()
	mut var_msg := rt.new_null()
	mut var_notice_header := rt.new_null()
	mut var_notice_text := rt.new_null()
	mut var_time_saved := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_api_calls := rt.new_null()
	mut var_usage_limit := rt.new_null()
	mut var_upgrade_url := rt.new_null()
	mut var_upgrade_via_support := rt.new_null()
	mut var_upgrade_type := rt.new_null()
	mut var_recommended_plan_name := rt.new_null()
	mut var_upgrade_plan := rt.new_null()
	mut var_kses_allow_link := { 'a': { 'href': rt.new_bool(true), 'target': rt.new_bool(true), 'class': rt.new_bool(true) } }
	mut var_kses_allow_strong := { 'strong': true }
	if !(!(rt.new_bool(var_type)).is_null()) {
		mut var_type := false
		// unsupported statement: Stmt_Nop
	}
	// unsupported statement: Stmt_Nop
	if rt.is_true(rt.identical(rt.new_bool(var_type), rt.new_string('plugin'))) {
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [fn () rt.PhpVal { mut temp := Class_Akismet_Admin{}; return temp.get_page_url() }()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Set up your Akismet account'), rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Almost done! Configure Akismet and say goodbye to spam'), rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_bool(var_type), rt.new_string('spam-check'))) {
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Akismet has detected a problem.'), rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Some comments have not yet been checked for spam by Akismet. They have been temporarily held for moderation and will automatically be rechecked later.'), rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		if !(!rt.is_true(var_link_text)) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses', [var_link_text.dup(), var_kses_allow_link.dup()]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_bool(var_type), rt.new_string('spam-check-cron-disabled'))) {
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Akismet has detected a problem.'), rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('WP-Cron has been disabled using the DISABLE_WP_CRON constant. Comment rechecks may not work properly.'), rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(var_type), rt.new_string('alert'))) && rt.is_true(rt.identical(var_code, Class_Akismet.alert_code_commercial())))) && !(var_parent_view).is_null())) && rt.is_true(rt.identical(var_parent_view, rt.new_string('config'))))) {
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('We detected commercial activity on your site'), rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Your current subscription is for <a class="akismet-external-link" href="%s">personal, non-commercial use</a>. Please upgrade your plan to continue using Akismet.'), rt.new_string('akismet')]), rt.call_function('esc_url', [rt.new_string('https://akismet.com/support/getting-started/free-or-paid/?utm_source=akismet_plugin&utm_campaign=plugin_static_link&utm_medium=in_plugin&utm_content=commercial_support')])]), var_kses_allow_link.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('If you believe your site should not be classified as commercial, <a class="akismet-external-link" href="%s">please get in touch</a>'), rt.new_string('akismet')]), rt.call_function('esc_url', [rt.new_string('https://akismet.com/contact/?purpose=commercial&utm_source=akismet_plugin&utm_campaign=plugin_static_link&utm_medium=in_plugin&utm_content=commercial_contact')])]), var_kses_allow_link.dup()]))
		// unsupported statement: Stmt_InlineHTML
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Akismet{}; return temp.view(arg_0, arg_1) }(rt.new_string('get'), rt.create_array([rt.ArrayItem{ key: 'text', val: rt.call_function('__', [rt.new_string('Upgrade plan'), rt.new_string('akismet')]) }, rt.ArrayItem{ key: 'classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'akismet-alert-button' }, rt.ArrayItem{ key: none, val: 'akismet-button' }]) }, rt.ArrayItem{ key: 'redirect', val: 'upgrade' }, rt.ArrayItem{ key: 'utm_content', val: 'commercial_upgrade' }]))
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_bool(var_type), rt.new_string('alert'))) {
		// unsupported statement: Stmt_InlineHTML
		print(if rt.is_true(rt.new_bool(!(var_parent_view).is_null() && rt.is_true(rt.identical(var_parent_view, rt.new_string('config'))))) { 'akismet-alert is-bad' } else { 'error' })
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('Akismet error code: %s'), rt.new_string('akismet')]), rt.call_function('esc_html', [var_code.dup()])])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(if !(var_msg).is_null() { rt.call_function('esc_html', [var_msg.dup()]) } else { rt.new_string('') })
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('For more information, see the <a class="akismet-external-link" href="%s">error documentation on akismet.com</a>'), rt.new_string('akismet')]), rt.call_function('esc_url', ['https://akismet.com/developers/detailed-docs/errors/akismet-error-' + (rt.call_function('absint', [var_code.dup()])).str() + '?utm_source=akismet_plugin&utm_campaign=plugin_static_link&utm_medium=in_plugin&utm_content=error_info'])]), var_kses_allow_link.dup()]))
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_bool(var_type), rt.new_string('notice'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [var_notice_header.dup(), fn () rt.PhpVal { mut temp := Class_Akismet_Admin{}; return temp.get_notice_kses_allowed_elements() }()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [var_notice_text.dup(), fn () rt.PhpVal { mut temp := Class_Akismet_Admin{}; return temp.get_notice_kses_allowed_elements() }()]))
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_bool(var_type), rt.new_string('missing-functions'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Network functions are disabled.'), rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [rt.call_function('__', [rt.new_string('Your web host or server administrator has disabled PHP&#8217;s <code>gethostbynamel</code> function.'), rt.new_string('akismet')]), rt.call_function('array_merge', [var_kses_allow_link.dup(), var_kses_allow_strong.dup(), rt.create_array([rt.ArrayItem{ key: 'code', val: true }])])]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Please contact your web host or firewall administrator and give them <a class="akismet-external-link" href="%s" target="_blank">this information about Akismet&#8217;s system requirements</a>'), rt.new_string('akismet')]), rt.call_function('esc_url', [rt.new_string('https://akismet.com/akismet-hosting-faq/?utm_source=akismet_plugin&utm_campaign=plugin_static_link&utm_medium=in_plugin&utm_content=hosting_faq_php')])]), rt.call_function('array_merge', [var_kses_allow_link.dup(), var_kses_allow_strong.dup(), rt.create_array([rt.ArrayItem{ key: 'code', val: true }])])]))
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_bool(var_type), rt.new_string('servers-be-down'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Your site can&#8217;t connect to the Akismet servers.'), rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Your firewall may be blocking Akismet from connecting to its API. Please contact your host and refer to <a class="akismet-external-link" href="%s" target="_blank">our guide about firewalls</a>'), rt.new_string('akismet')]), rt.call_function('esc_url', [rt.new_string('https://akismet.com/akismet-hosting-faq/?utm_source=akismet_plugin&utm_campaign=plugin_static_link&utm_medium=in_plugin&utm_content=hosting_faq_firewall')])]), var_kses_allow_link.dup()]))
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_bool(var_type), rt.new_string('cancelled'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Your Akismet plan has been cancelled.'), rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Please visit <a class="akismet-external-link" href="%s" target="_blank">Akismet.com</a> to purchase a new subscription.'), rt.new_string('akismet')]), rt.call_function('esc_url', [rt.new_string('https://akismet.com/pricing/?utm_source=akismet_plugin&utm_campaign=plugin_static_link&utm_medium=in_plugin&utm_content=pricing_cancelled')])]), var_kses_allow_link.dup()]))
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_bool(var_type), rt.new_string('suspended'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Your Akismet subscription is suspended.'), rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Please contact <a class="akismet-external-link" href="%s" target="_blank">Akismet support</a> for assistance.'), rt.new_string('akismet')]), rt.call_function('esc_url', [rt.new_string('https://akismet.com/contact/?utm_source=akismet_plugin&utm_campaign=plugin_static_link&utm_medium=in_plugin&utm_content=support_suspended')])]), var_kses_allow_link.dup()]))
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(var_type), rt.new_string('active-notice'))) && rt.is_true(var_time_saved))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_time_saved.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You can help us fight spam and upgrade your account by <a class="akismet-external-link" href="%s" target="_blank">contributing a token amount</a>'), rt.new_string('akismet')]), rt.call_function('esc_url', [rt.new_string('https://akismet.com/pricing?utm_source=akismet_plugin&utm_campaign=plugin_static_link&utm_medium=in_plugin&utm_content=upgrade_contribution')])]), var_kses_allow_link.dup()]))
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_bool(var_type), rt.new_string('missing'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('There is a problem with your API key.'), rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Please contact <a class="akismet-external-link" href="%s" target="_blank">Akismet support</a> for assistance.'), rt.new_string('akismet')]), rt.call_function('esc_url', [rt.new_string('https://akismet.com/contact/?utm_source=akismet_plugin&utm_campaign=plugin_static_link&utm_medium=in_plugin&utm_content=support_missing')])]), var_kses_allow_link.dup()]))
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_bool(var_type), rt.new_string('no-sub'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('You don&#8217;t have an Akismet plan.'), rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Please <a class="akismet-external-link" href="%s" target="_blank">choose a free or paid plan</a> so Akismet can protect your site from spam.'), rt.new_string('akismet')]), rt.call_function('esc_url', [rt.new_string('https://akismet.com/pricing?utm_source=akismet_plugin&utm_campaign=plugin_static_link&utm_medium=in_plugin&utm_content=choose_plan')])]), var_kses_allow_link.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Once you\'ve chosen a plan, return here to complete your setup.'), rt.new_string('akismet')]))
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(, )) {
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true() {
	} else if rt.is_true() {
	} else if rt.is_true() {
	} else if rt.is_true() {
	}
}
