import rt

struct Class_Akismet_Admin {
	rt.PhpObjectBase
}

struct Class_Akismet {
	rt.PhpObjectBase
}

fn create_akismet_admin(_args ...rt.PhpVal) &Class_Akismet_Admin {
	mut obj := &Class_Akismet_Admin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_akismet(_args ...rt.PhpVal) &Class_Akismet {
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

fn main() {
	defer {
		rt.shutdown()
	}

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
	mut var_kses_allow_link := {
		'a': {
			'href':   rt.new_bool(true)
			'target': rt.new_bool(true)
			'class':  rt.new_bool(true)
		}
	}
	mut var_kses_allow_strong := {
		'strong': true
	}
	if !(!(rt.new_bool(var_type)).is_null()) {
		mut var_type := false
	}
	if rt.is_true(rt.identical(rt.new_bool(var_type), rt.new_string('plugin'))) {
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_InlineHTML
		mut iife_temp_0 := Class_Akismet_Admin{}
		mut iife_result_0 := iife_temp_0.get_page_url()
		mut iife_temp_1 := Class_Akismet_Admin{}
		mut iife_result_1 := iife_temp_1.get_page_url()
		rt.echo_val(rt.call_function('esc_url', [iife_result_0]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Set up your Akismet account'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Almost done! Configure Akismet and say goodbye to spam'),
			rt.new_string('akismet'),
		])
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_bool(var_type), rt.new_string('spam-check'))) {
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Akismet has detected a problem.'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Some comments have not yet been checked for spam by Akismet. They have been temporarily held for moderation and will automatically be rechecked later.'),
			rt.new_string('akismet'),
		])
		// unsupported statement: Stmt_InlineHTML
		if !(!rt.is_true(var_link_text)) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses', [var_link_text.clone(),
				rt.create_array_from_native_map(var_kses_allow_link)]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_bool(var_type),
		rt.new_string('spam-check-cron-disabled')))
	{
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Akismet has detected a problem.'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('WP-Cron has been disabled using the DISABLE_WP_CRON constant. Comment rechecks may not work properly.'),
			rt.new_string('akismet'),
		])
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_bool(var_type), rt.new_string('alert')))
		&& rt.is_true(rt.identical(var_code, Class_Akismet.alert_code_commercial()))
		&& !var_parent_view.is_null()
		&& rt.is_true(rt.identical(var_parent_view, rt.new_string('config'))) {
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('We detected commercial activity on your site'),
			rt.new_string('akismet'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Your current subscription is for <a class="akismet-external-link" href="%s">personal, non-commercial use</a>. Please upgrade your plan to continue using Akismet.'),
					rt.new_string('akismet'),
				]),
				rt.call_function('esc_url', [
					rt.new_string('https://akismet.com/support/getting-started/free-or-paid/?utm_source=akismet_plugin&utm_campaign=plugin_static_link&utm_medium=in_plugin&utm_content=commercial_support'),
				]),
			]),
			rt.create_array_from_native_map(var_kses_allow_link),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('If you believe your site should not be classified as commercial, <a class="akismet-external-link" href="%s">please get in touch</a>'),
					rt.new_string('akismet'),
				]),
				rt.call_function('esc_url', [
					rt.new_string('https://akismet.com/contact/?purpose=commercial&utm_source=akismet_plugin&utm_campaign=plugin_static_link&utm_medium=in_plugin&utm_content=commercial_contact'),
				]),
			]),
			rt.create_array_from_native_map(var_kses_allow_link),
		]))
		// unsupported statement: Stmt_InlineHTML
		mut iife_temp_2 := Class_Akismet{}
		mut iife_result_2 := iife_temp_2.view(rt.new_string('get'), rt.create_array([
			rt.ArrayItem{ key: 'text', val: rt.call_function('__', [
				rt.new_string('Upgrade plan'),
				rt.new_string('akismet'),
			]) },
			rt.ArrayItem{ key: 'classes', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'akismet-alert-button' },
				rt.ArrayItem{ key: none, val: 'akismet-button' },
			]) },
			rt.ArrayItem{ key: 'redirect', val: 'upgrade' },
			rt.ArrayItem{ key: 'utm_content', val: 'commercial_upgrade' },
		]))
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_bool(var_type), rt.new_string('alert'))) {
		// unsupported statement: Stmt_InlineHTML
		print(if !var_parent_view.is_null()
			&& rt.is_true(rt.identical(var_parent_view, rt.new_string('config'))) {
			'akismet-alert is-bad'
		} else {
			'error'
		})
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('esc_html__', [rt.new_string('Akismet error code: %s'),
				rt.new_string('akismet')]),
			rt.call_function('esc_html', [var_code.clone()]),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(if !var_msg.is_null() { rt.call_function('esc_html', [
				var_msg.clone()]) } else { rt.new_string('') })
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('For more information, see the <a class="akismet-external-link" href="%s">error documentation on akismet.com</a>'),
					rt.new_string('akismet'),
				]),
				rt.call_function('esc_url', [
					rt.new_string(
						'https://akismet.com/developers/detailed-docs/errors/akismet-error-' +
						(rt.call_function('absint', [var_code.clone()])).str() +
						'?utm_source=akismet_plugin&utm_campaign=plugin_static_link&utm_medium=in_plugin&utm_content=error_info'),
				]),
			]),
			rt.create_array_from_native_map(var_kses_allow_link),
		]))
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_bool(var_type), rt.new_string('notice'))) {
		// unsupported statement: Stmt_InlineHTML
		mut iife_temp_3 := Class_Akismet_Admin{}
		mut iife_result_3 := iife_temp_3.get_notice_kses_allowed_elements()
		rt.echo_val(rt.call_function('wp_kses', [var_notice_header.clone(), iife_result_3]))
		// unsupported statement: Stmt_InlineHTML
		mut iife_temp_4 := Class_Akismet_Admin{}
		mut iife_result_4 := iife_temp_4.get_notice_kses_allowed_elements()
		rt.echo_val(rt.call_function('wp_kses', [var_notice_text.clone(), iife_result_4]))
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_bool(var_type), rt.new_string('missing-functions'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Network functions are disabled.'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [
			rt.call_function('__', [
				rt.new_string('Your web host or server administrator has disabled PHP&#8217;s <code>gethostbynamel</code> function.'),
				rt.new_string('akismet'),
			]),
			rt.call_function('array_merge', [
				rt.create_array_from_native_map(var_kses_allow_link),
				rt.create_array_from_native_map(var_kses_allow_strong),
				rt.create_array([rt.ArrayItem{ key: 'code', val: true }]),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Please contact your web host or firewall administrator and give them <a class="akismet-external-link" href="%s" target="_blank">this information about Akismet&#8217;s system requirements</a>'),
					rt.new_string('akismet'),
				]),
				rt.call_function('esc_url', [
					rt.new_string('https://akismet.com/akismet-hosting-faq/?utm_source=akismet_plugin&utm_campaign=plugin_static_link&utm_medium=in_plugin&utm_content=hosting_faq_php'),
				]),
			]),
			rt.call_function('array_merge', [
				rt.create_array_from_native_map(var_kses_allow_link),
				rt.create_array_from_native_map(var_kses_allow_strong),
				rt.create_array([
					rt.ArrayItem{ key: 'code', val: true },
				]),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_bool(var_type), rt.new_string('servers-be-down'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Your site can&#8217;t connect to the Akismet servers.'),
			rt.new_string('akismet'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Your firewall may be blocking Akismet from connecting to its API. Please contact your host and refer to <a class="akismet-external-link" href="%s" target="_blank">our guide about firewalls</a>'),
					rt.new_string('akismet'),
				]),
				rt.call_function('esc_url', [
					rt.new_string('https://akismet.com/akismet-hosting-faq/?utm_source=akismet_plugin&utm_campaign=plugin_static_link&utm_medium=in_plugin&utm_content=hosting_faq_firewall'),
				]),
			]),
			rt.create_array_from_native_map(var_kses_allow_link),
		]))
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_bool(var_type), rt.new_string('cancelled'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Your Akismet plan has been cancelled.'),
			rt.new_string('akismet'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Please visit <a class="akismet-external-link" href="%s" target="_blank">Akismet.com</a> to purchase a new subscription.'),
					rt.new_string('akismet'),
				]),
				rt.call_function('esc_url', [
					rt.new_string('https://akismet.com/pricing/?utm_source=akismet_plugin&utm_campaign=plugin_static_link&utm_medium=in_plugin&utm_content=pricing_cancelled'),
				]),
			]),
			rt.create_array_from_native_map(var_kses_allow_link),
		]))
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_bool(var_type), rt.new_string('suspended'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Your Akismet subscription is suspended.'),
			rt.new_string('akismet'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Please contact <a class="akismet-external-link" href="%s" target="_blank">Akismet support</a> for assistance.'),
					rt.new_string('akismet'),
				]),
				rt.call_function('esc_url', [
					rt.new_string('https://akismet.com/contact/?utm_source=akismet_plugin&utm_campaign=plugin_static_link&utm_medium=in_plugin&utm_content=support_suspended'),
				]),
			]),
			rt.create_array_from_native_map(var_kses_allow_link),
		]))
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_bool(var_type), rt.new_string('active-notice')))
		&& rt.is_true(var_time_saved) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_time_saved.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('You can help us fight spam and upgrade your account by <a class="akismet-external-link" href="%s" target="_blank">contributing a token amount</a>'),
					rt.new_string('akismet'),
				]),
				rt.call_function('esc_url', [
					rt.new_string('https://akismet.com/pricing?utm_source=akismet_plugin&utm_campaign=plugin_static_link&utm_medium=in_plugin&utm_content=upgrade_contribution'),
				]),
			]),
			rt.create_array_from_native_map(var_kses_allow_link),
		]))
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_bool(var_type), rt.new_string('missing'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('There is a problem with your API key.'),
			rt.new_string('akismet'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Please contact <a class="akismet-external-link" href="%s" target="_blank">Akismet support</a> for assistance.'),
					rt.new_string('akismet'),
				]),
				rt.call_function('esc_url', [
					rt.new_string('https://akismet.com/contact/?utm_source=akismet_plugin&utm_campaign=plugin_static_link&utm_medium=in_plugin&utm_content=support_missing'),
				]),
			]),
			rt.create_array_from_native_map(var_kses_allow_link),
		]))
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_bool(var_type), rt.new_string('no-sub'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('You don&#8217;t have an Akismet plan.'),
			rt.new_string('akismet'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Please <a class="akismet-external-link" href="%s" target="_blank">choose a free or paid plan</a> so Akismet can protect your site from spam.'),
					rt.new_string('akismet'),
				]),
				rt.call_function('esc_url', [
					rt.new_string('https://akismet.com/pricing?utm_source=akismet_plugin&utm_campaign=plugin_static_link&utm_medium=in_plugin&utm_content=choose_plan'),
				]),
			]),
			rt.create_array_from_native_map(var_kses_allow_link),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html__', [
			rt.new_string("Once you've chosen a plan, return here to complete your setup."),
			rt.new_string('akismet'),
		]))
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_bool(var_type), rt.new_string('new-key-valid'))) {
		// unsupported statement: Stmt_InlineHTML
		mut var_check_pending_link := rt.new_bool(false)
		mut var_at_least_one_comment_in_moderation := !(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wpdb,
			'get_var', [
			rt.concat(rt.concat(rt.new_string('SELECT comment_ID FROM '), rt.get_property(var_wpdb,
				'comments')), rt.new_string(" WHERE comment_approved = '0' LIMIT 1")),
		]))))))
		if var_at_least_one_comment_in_moderation {
			var_check_pending_link = rt.new_string('edit-comments.php?akismet_recheck=' +
				(rt.call_function('wp_create_nonce', [rt.new_string('akismet_recheck')])).str())
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Akismet is now protecting your site from spam.'),
			rt.new_string('akismet'),
		])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_check_pending_link) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Would you like to <a href="%s">scan pending comments for spam</a>?'),
						rt.new_string('akismet'),
					]),
					rt.call_function('esc_url', [
						var_check_pending_link.clone(),
					]),
				]),
				rt.create_array_from_native_map(var_kses_allow_link),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_bool(var_type), rt.new_string('new-key-invalid'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('The key you entered is invalid. Please double-check it.'),
			rt.new_string('akismet'),
		])
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_bool(var_type),
		Class_Akismet_Admin.notice_existing_key_invalid()))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_function('__', [rt.new_string('Your API key is no longer valid.'),
				rt.new_string('akismet')]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Please enter a new key or <a class="akismet-external-link" href="%s" target="_blank">contact Akismet support</a>'),
					rt.new_string('akismet'),
				]),
				rt.new_string('https://akismet.com/contact/?utm_source=akismet_plugin&utm_campaign=plugin_static_link&utm_medium=in_plugin&utm_content=support_invalid_key'),
			]),
			rt.create_array_from_native_map(var_kses_allow_link),
		]))
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_bool(var_type), rt.new_string('new-key-failed'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('The API key you entered could not be verified.'),
			rt.new_string('akismet'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The connection to akismet.com could not be established. Please refer to <a class="akismet-external-link" href="%s" target="_blank">our guide about firewalls</a> and check your server configuration.'),
					rt.new_string('akismet'),
				]),
				rt.new_string('https://akismet.com/akismet-hosting-faq/?utm_source=akismet_plugin&utm_campaign=plugin_static_link&utm_medium=in_plugin&utm_content=hosting_faq'),
			]),
			rt.create_array_from_native_map(var_kses_allow_link),
		]))
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_bool(var_type), rt.new_string('usage-limit')))
		&& rt.get_static_prop('Akismet', 'limit_notices').array_isset(var_code) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('plugins_url', [rt.new_string('../_inc/img/logo-a-2x.png'),
				rt.new_string(@FILE)]),
		]))
		// unsupported statement: Stmt_InlineHTML
		mut switch_val_1 := rt.get_static_prop('Akismet', 'limit_notices').array_get(var_code)
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('FIRST_MONTH_OVER_LIMIT')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('SECOND_MONTH_OVER_LIMIT'))) {
			rt.call_function('esc_html_e', [
				rt.new_string('Your Akismet account usage is over your plan&#8217;s limit'),
				rt.new_string('akismet'),
			])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('THIRD_MONTH_APPROACHING_LIMIT'))) {
			rt.call_function('esc_html_e', [
				rt.new_string('Your Akismet account usage is approaching your plan&#8217;s limit'),
				rt.new_string('akismet'),
			])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('THIRD_MONTH_OVER_LIMIT')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('FOUR_PLUS_MONTHS_OVER_LIMIT'))) {
			rt.call_function('esc_html_e', [
				rt.new_string('Your account has been restricted'),
				rt.new_string('akismet'),
			])
		} else {
		}
		// unsupported statement: Stmt_InlineHTML
		mut switch_val_2 := rt.get_static_prop('Akismet', 'limit_notices').array_get(var_code)
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('FIRST_MONTH_OVER_LIMIT'))) {
			rt.echo_val(rt.call_function('esc_html', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Since %1$s, your account made %2$s API calls, compared to your plan&#8217;s limit of %3$s.'),
						rt.new_string('akismet'),
					]),
					rt.call_function('esc_html', [
						rt.new_string((rt.call_function('gmdate', [rt.new_string('F')])).str() +
							' 1'),
					]),
					rt.call_function('number_format', [
						var_api_calls.clone(),
					]),
					rt.call_function('number_format', [
						var_usage_limit.clone(),
					]),
				]),
			]))
			print('&nbsp;')
			print('<a class="akismet-external-link" href="https://akismet.com/support/general/akismet-api-usage-limits/?utm_source=akismet_plugin&amp;utm_campaign=plugin_static_link&amp;utm_medium=in_plugin&amp;utm_content=usage_limit_docs" target="_blank">')
			rt.echo_val(rt.call_function('esc_html', [
				rt.call_function('__', [rt.new_string('Learn more about usage limits'),
					rt.new_string('akismet')]),
			]))
			print('</a>')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('SECOND_MONTH_OVER_LIMIT'))) {
			rt.echo_val(rt.call_function('esc_html', [
				rt.call_function('__', [
					rt.new_string('Your Akismet usage has been over your plan&#8217;s limit for two consecutive months. Next month, we will restrict your account after you reach the limit. Increase your limit to make sure your site stays protected from spam.'),
					rt.new_string('akismet'),
				]),
			]))
			print('&nbsp;')
			print('<a class="akismet-external-link" href="https://akismet.com/support/general/akismet-api-usage-limits/?utm_source=akismet_plugin&amp;utm_campaign=plugin_static_link&amp;utm_medium=in_plugin&amp;utm_content=usage_limit_docs" target="_blank">')
			rt.echo_val(rt.call_function('esc_html', [
				rt.call_function('__', [rt.new_string('Learn more about usage limits'),
					rt.new_string('akismet')]),
			]))
			print('</a>')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('THIRD_MONTH_APPROACHING_LIMIT'))) {
			rt.echo_val(rt.call_function('esc_html', [
				rt.call_function('__', [
					rt.new_string('Your Akismet usage is nearing your plan&#8217;s limit for the third consecutive month. We will restrict your account after you reach the limit. Increase your limit to make sure your site stays protected from spam.'),
					rt.new_string('akismet'),
				]),
			]))
			print('&nbsp;')
			print('<a class="akismet-external-link" href="https://akismet.com/support/general/akismet-api-usage-limits/?utm_source=akismet_plugin&amp;utm_campaign=plugin_static_link&amp;utm_medium=in_plugin&amp;utm_content=usage_limit_docs" target="_blank">')
			rt.echo_val(rt.call_function('esc_html', [
				rt.call_function('__', [rt.new_string('Learn more about usage limits'),
					rt.new_string('akismet')]),
			]))
			print('</a>')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('THIRD_MONTH_OVER_LIMIT')))
			|| rt.is_true(rt.equal(switch_val_2, rt.new_string('FOUR_PLUS_MONTHS_OVER_LIMIT'))) {
			rt.echo_val(rt.call_function('esc_html', [
				rt.call_function('__', [
					rt.new_string('Your Akismet usage has been over your plan&#8217;s limit for three consecutive months. We have restricted your account for the rest of the month. Increase your limit to make sure your site stays protected from spam.'),
					rt.new_string('akismet'),
				]),
			]))
			print('&nbsp;')
			print('<a class="akismet-external-link" href="https://akismet.com/support/general/akismet-api-usage-limits/?utm_source=akismet_plugin&amp;utm_campaign=plugin_static_link&amp;utm_medium=in_plugin&amp;utm_content=usage_limit_docs" target="_blank">')
			rt.echo_val(rt.call_function('esc_html', [
				rt.call_function('__', [rt.new_string('Learn more about usage limits'),
					rt.new_string('akismet')]),
			]))
			print('</a>')
		} else {
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.new_string(var_upgrade_url.str() +
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [var_upgrade_url.clone(), rt.new_string('?')]), rt.new_bool(false))))) { '&' } else { '?' } +
				'utm_source=akismet_plugin&utm_campaign=plugin_static_link&utm_medium=in_plugin&utm_content=usage_limit_upgrade'),
		]))
		// unsupported statement: Stmt_InlineHTML
		if !var_upgrade_via_support.is_null() && rt.is_true(var_upgrade_via_support) {
			rt.call_function('esc_html_e', [rt.new_string('Contact Akismet support'),
				rt.new_string('akismet')])
		} else if !(!rt.is_true(var_upgrade_type))
			&& rt.is_true(rt.identical(rt.new_string('qty'), var_upgrade_type)) {
			if !(!rt.is_true(var_recommended_plan_name))
				&& var_recommended_plan_name.clone().is_string() {
				rt.echo_val(rt.call_function('esc_html', [
					rt.call_function('sprintf', [
						rt.call_function('__', [rt.new_string('Add an %s subscription'),
							rt.new_string('akismet')]),
						var_recommended_plan_name.clone(),
					]),
				]))
			} else {
				rt.call_function('esc_html_e', [rt.new_string('Increase your limit'),
					rt.new_string('akismet')])
			}
		} else {
			rt.echo_val(rt.call_function('esc_html', [
				rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('Upgrade to %s'),
						rt.new_string('akismet')]),
					var_upgrade_plan.clone(),
				]),
			]))
		}
		// unsupported statement: Stmt_InlineHTML
	}
}
