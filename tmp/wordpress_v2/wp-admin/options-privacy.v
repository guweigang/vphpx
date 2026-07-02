import rt

struct Class_WP_Privacy_Policy_Content {
	rt.PhpObjectBase
}

fn create_wp_privacy_policy_content(_args ...rt.PhpVal) &Class_WP_Privacy_Policy_Content {
	mut obj := &Class_WP_Privacy_Policy_Content{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Privacy_Policy_Content) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Privacy_Policy_Content) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Privacy_Policy_Content) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_privacy_options'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to manage privacy options on this site.'),
			]),
		])
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('tab'))
		&& rt.is_true(rt.identical(rt.new_string('policyguide'), rt.get_superglobal('_GET').array_get(rt.new_string('tab')))) {
		rt.include_file(@DIR + '/privacy-policy-guide.php', '4')
		return rt.new_null()
	}
	mut var_title := rt.call_function('__', [rt.new_string('Privacy')])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_body_class := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		var_body_class = rt.concat(var_body_class, rt.new_string(' privacy-settings '))
		return var_body_class.clone()
	}
	rt.call_function('add_filter', [rt.new_string('admin_body_class'),
		rt.new_closure(closure_1_fn)])
	mut var_action := if !(rt.get_superglobal('_POST').array_get(rt.new_string('action'))).is_null() {
		rt.get_superglobal('_POST').array_get(rt.new_string('action'))
	} else {
		rt.new_string('')
	}
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('The Privacy screen lets you either build a new privacy-policy page or choose one you already have to show.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('This screen includes suggestions to help you write your own privacy policy. However, it is your responsibility to use these resources correctly, to provide the information required by your privacy policy, and to keep this information current and accurate.')])).str() +
				'</p>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/settings-privacy-screen/">Documentation on Privacy Settings</a>')])).str() +
			'</p>'),
	])
	if !(!rt.is_true(var_action)) {
		rt.call_function('check_admin_referer', [var_action.clone()])
		if rt.is_true(rt.identical(rt.new_string('set-privacy-page'), var_action)) {
			mut var_privacy_policy_page_id := rt.new_int(if rt.get_superglobal('_POST').array_isset(rt.new_string('page_for_privacy_policy')) {
				rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('page_for_privacy_policy'))).to_i64())
			} else {
				0
			})
			rt.call_function('update_option', [
				rt.new_string('wp_page_for_privacy_policy'),
				var_privacy_policy_page_id.clone(),
			])
			mut var_privacy_page_updated_message := rt.call_function('__', [
				rt.new_string('Privacy Policy page updated successfully.'),
			])
			if rt.is_true(var_privacy_policy_page_id) {
				if rt.is_true(rt.identical(rt.new_string('publish'), rt.call_function('get_post_status', [var_privacy_policy_page_id.clone()])))
					&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')]))
					&& rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('menus')])) {
					var_privacy_page_updated_message = rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Privacy Policy page setting updated successfully. Remember to <a href="%s">update your menus</a>!'),
						]),
						rt.call_function('esc_url', [
							rt.call_function('add_query_arg', [
								rt.new_string('autofocus[panel]'),
								rt.new_string('nav_menus'),
								rt.call_function('admin_url', [
									rt.new_string('customize.php'),
								]),
							]),
						]),
					])
				}
			}
			rt.call_function('add_settings_error', [
				rt.new_string('page_for_privacy_policy'),
				rt.new_string('page_for_privacy_policy'),
				var_privacy_page_updated_message.clone(),
				rt.new_string('success'),
			])
		} else if rt.is_true(rt.identical(rt.new_string('create-privacy-page'), var_action)) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
				rt.new_string('WP_Privacy_Policy_Content'),
			])))))
			{
				rt.include_file(
					(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-privacy-policy-content.php',
					'4')
			}
			mut iife_temp_1 := Class_WP_Privacy_Policy_Content{}
			mut iife_result_1 := iife_temp_1.get_default_content()
			mut var_privacy_policy_page_content := iife_result_1
			var_privacy_policy_page_id = rt.call_function('wp_insert_post', [
				rt.create_array([
					rt.ArrayItem{ key: 'post_title', val: rt.call_function('__', [
						rt.new_string('Privacy Policy'),
					]) },
					rt.ArrayItem{ key: 'post_status', val: 'draft' },
					rt.ArrayItem{ key: 'post_type', val: 'page' },
					rt.ArrayItem{ key: 'post_content', val: var_privacy_policy_page_content },
				]),
				rt.new_bool(true),
			])
			if rt.is_true(rt.call_function('is_wp_error', [var_privacy_policy_page_id.clone()])) {
				rt.call_function('add_settings_error', [
					rt.new_string('page_for_privacy_policy'),
					rt.new_string('page_for_privacy_policy'),
					rt.call_function('__', [
						rt.new_string('Unable to create a Privacy Policy page.'),
					]),
					rt.new_string('error'),
				])
			} else {
				rt.call_function('update_option', [
					rt.new_string('wp_page_for_privacy_policy'),
					var_privacy_policy_page_id.clone(),
				])
				rt.call_function('wp_redirect', [
					rt.call_function('admin_url', [
						rt.new_string('post.php?post=' + var_privacy_policy_page_id.str() +
							'&action=edit'),
					]),
				])
				exit(0)
			}
		}
	}
	mut var_privacy_policy_page_exists := false
	var_privacy_policy_page_id = rt.new_int((rt.call_function('get_option', [
		rt.new_string('wp_page_for_privacy_policy'),
	])).to_i64())
	if !(!rt.is_true(var_privacy_policy_page_id)) {
		mut var_privacy_policy_page := rt.call_function('get_post', [
			var_privacy_policy_page_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_privacy_policy_page,
			'WP_Post'))))))
		{
			rt.call_function('add_settings_error', [
				rt.new_string('page_for_privacy_policy'),
				rt.new_string('page_for_privacy_policy'),
				rt.call_function('__', [
					rt.new_string('The currently selected Privacy Policy page does not exist. Please create or select a new page.'),
				]),
				rt.new_string('error'),
			])
		} else {
			if rt.is_true(rt.identical(rt.new_string('trash'), rt.get_property(var_privacy_policy_page,
				'post_status')))
			{
				rt.call_function('add_settings_error', [
					rt.new_string('page_for_privacy_policy'),
					rt.new_string('page_for_privacy_policy'),
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('The currently selected Privacy Policy page is in the Trash. Please create or select a new Privacy Policy page or <a href="%s">restore the current page</a>.'),
						]),
						rt.new_string('edit.php?post_status=trash&post_type=page'),
					]),
					rt.new_string('error'),
				])
			} else {
				var_privacy_policy_page_exists = true
			}
		}
	}
	mut var_parent_file := 'options-general.php'
	rt.call_function('wp_enqueue_script', [rt.new_string('privacy-tools')])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Privacy')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Secondary menu')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [rt.new_string('options-privacy.php')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Settings'), rt.new_string('Privacy Settings')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [
			rt.new_string('options-privacy.php?tab=policyguide'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Policy Guide'), rt.new_string('Privacy Settings')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_admin_notice', [
		rt.call_function('__', [
			rt.new_string('The Privacy Settings require JavaScript.'),
		]),
		rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'error' },
			rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'hide-if-js' },
			]) },
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Privacy Settings')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('As a website owner, you may need to follow national or international privacy laws. For example, you may need to create and display a privacy policy.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('If you already have a Privacy Policy page, please select it below. If not, please create one.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('The new page will include help and suggestions for your privacy policy.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('However, it is your responsibility to use those resources correctly, to provide the information that your privacy policy requires, and to keep that information current and accurate.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('After your Privacy Policy page is set, you should edit it.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('You should also review your privacy policy from time to time, especially after installing or updating any themes or plugins. There may be changes or new suggested information for you to consider adding to your policy.'),
	])
	// unsupported statement: Stmt_InlineHTML
	if var_privacy_policy_page_exists {
		mut var_edit_href := rt.call_function('add_query_arg', [
			rt.create_array([
				rt.ArrayItem{ key: 'post', val: var_privacy_policy_page_id },
				rt.ArrayItem{ key: 'action', val: 'edit' },
			]),
			rt.call_function('admin_url', [
				rt.new_string('post.php'),
			]),
		])
		mut var_view_href := rt.call_function('get_permalink', [
			var_privacy_policy_page_id.clone()])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.identical(rt.new_string('publish'), rt.call_function('get_post_status', [
			var_privacy_policy_page_id.clone(),
		])))
		{
			rt.call_function('printf', [
				rt.call_function('__', [
					rt.new_string('<a href="%1$s">Edit</a> or <a href="%2$s">view</a> your Privacy Policy page content.'),
				]),
				rt.call_function('esc_url', [
					var_edit_href.clone(),
				]),
				rt.call_function('esc_url', [
					var_view_href.clone(),
				]),
			])
		} else {
			rt.call_function('printf', [
				rt.call_function('__', [
					rt.new_string('<a href="%1$s">Edit</a> or <a href="%2$s">preview</a> your Privacy Policy page content.'),
				]),
				rt.call_function('esc_url', [
					var_edit_href.clone(),
				]),
				rt.call_function('esc_url', [
					var_view_href.clone(),
				]),
			])
		}
		// unsupported statement: Stmt_InlineHTML
	}
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('Need help putting together your new Privacy Policy page? <a href="%1$s" %2$s>Check out the privacy policy guide%3$s</a> for recommendations on what content to include, along with policies suggested by your plugins and theme.'),
		]),
		rt.call_function('esc_url', [
			rt.call_function('admin_url', [
				rt.new_string('options-privacy.php?tab=policyguide'),
			]),
		]),
		rt.new_string(''),
		rt.new_string(''),
	])
	// unsupported statement: Stmt_InlineHTML
	mut var_has_pages := rt.new_bool((rt.call_function('get_posts', [
		rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'page' },
			rt.ArrayItem{ key: 'posts_per_page', val: 1 }, rt.ArrayItem{ key: 'post_status', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'publish' },
				rt.ArrayItem{ key: none, val: 'draft' },
			]) }]),
	])).to_bool())
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_has_pages) {
		rt.call_function('_e', [rt.new_string('Create a new Privacy Policy page')])
	} else {
		rt.call_function('_e', [rt.new_string('There are no pages.')])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('create-privacy-page')])
	rt.call_function('submit_button', [rt.call_function('__', [
		rt.new_string('Create')]),
		rt.new_string('secondary'), rt.new_string('submit'), rt.new_bool(false),
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'create-page' }])])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_has_pages) {
		// unsupported statement: Stmt_InlineHTML
		if var_privacy_policy_page_exists {
			rt.call_function('_e', [rt.new_string('Change your Privacy Policy page')])
		} else {
			rt.call_function('_e', [rt.new_string('Select a Privacy Policy page')])
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_dropdown_pages', [
			rt.create_array([rt.ArrayItem{ key: 'name', val: 'page_for_privacy_policy' },
				rt.ArrayItem{ key: 'show_option_none', val: rt.call_function('__', [
					rt.new_string('&mdash; Select &mdash;'),
				]) }, rt.ArrayItem{ key: 'option_none_value', val: '0' },
				rt.ArrayItem{ key: 'selected', val: var_privacy_policy_page_id },
				rt.ArrayItem{ key: 'post_status', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'draft' },
					rt.ArrayItem{ key: none, val: 'publish' },
				]) }]),
		])
		rt.call_function('wp_nonce_field', [rt.new_string('set-privacy-page')])
		rt.call_function('submit_button', [
			rt.call_function('__', [rt.new_string('Use This Page')]),
			rt.new_string('primary'),
			rt.new_string('submit'),
			rt.new_bool(false),
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'set-page' }]),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
