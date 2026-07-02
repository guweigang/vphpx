import rt

struct Class_DateTime {
	rt.PhpObjectBase
}

struct Class_DateTimeZone {
	rt.PhpObjectBase
}

fn create_datetime(_args ...rt.PhpVal) &Class_DateTime {
	mut obj := &Class_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetimezone(_args ...rt.PhpVal) &Class_DateTimeZone {
	mut obj := &Class_DateTimeZone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_DateTimeZone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTimeZone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTimeZone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_wp_locale := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/translation-install.php',
		'4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_options'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to manage options for this site.'),
			]),
		])
	}
	mut var_title := rt.call_function('__', [rt.new_string('General Settings')])
	mut var_parent_file := 'options-general.php'
	mut var_timezone_format := rt.call_function('_x', [rt.new_string('Y-m-d H:i:s'),
		rt.new_string('timezone date format')])
	rt.call_function('add_action', [rt.new_string('admin_head'),
		rt.new_string('options_general_add_js')])
	mut var_options_help := rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('The fields on this screen determine some of the basics of your site setup.')])).str() +
		'</p>' + '<p>' +
		(rt.call_function('__', [rt.new_string('Most themes show the site title at the top of every page, in the title bar of the browser, and as the identifying name for syndicated feeds. Many themes also show the tagline.')])).str() +
		'</p>')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		var_options_help = rt.concat(var_options_help, rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('Two terms you will want to know are the WordPress URL and the site URL. The WordPress URL is where the core WordPress installation files are, and the site URL is the address a visitor uses in the browser to go to your site.')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Though the terms refer to two different concepts, in practice, they can be the same address or different. For example, you can have the core WordPress installation files in the root directory (<code>https://example.com</code>), in which case the two URLs would be the same. Or the <a href="%s">WordPress files can be in a subdirectory</a> (<code>https://example.com/wordpress</code>). In that case, the WordPress URL and the site URL would be different.')]), rt.call_function('__', [rt.new_string('https://developer.wordpress.org/advanced-administration/server/wordpress-in-directory/')])])).str() +
			'</p>' + '<p>' +
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Both WordPress URL and site URL can start with either %1$s or %2$s. A URL starting with %2$s requires an SSL certificate, so be sure that you have one before changing to %2$s. With %2$s, a padlock will appear next to the address in the browser address bar. Both %2$s and the padlock signal that your site meets some basic security requirements, which can build trust with your visitors and with search engines.')]), rt.new_string('<code>http://</code>'), rt.new_string('<code>https://</code>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('If you want site visitors to be able to register themselves, check the membership box. If you want the site administrator to register every new user, leave the box unchecked. In either case, you can set a default user role for all new users.')])).str() +
			'</p>'))
	}
	var_options_help = rt.concat(var_options_help, rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('You can set the language, and WordPress will automatically download and install the translation files (available if your filesystem is writable).')])).str() +
		'</p>' + '<p>' +
		(rt.call_function('__', [rt.new_string('UTC means Coordinated Universal Time.')])).str() +
		'</p>' + '<p>' +
		(rt.call_function('__', [rt.new_string('You must click the Save Changes button at the bottom of the screen for new settings to take effect.')])).str() +
		'</p>'))
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: var_options_help }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/settings-general-screen/">Documentation on General Settings</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>'),
	])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('settings_fields', [rt.new_string('general')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Site Title')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('form_option', [rt.new_string('blogname')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		mut var_sample_tagline := rt.call_function('__', [
			rt.new_string('Just another WordPress site'),
		])
	} else {
		var_sample_tagline = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Just another %s site')]),
			rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'site_name'),
		])
	}
	mut var_tagline_description := rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('In a few words, explain what this site is about. Example: &#8220;%s.&#8221;'),
		]),
		var_sample_tagline.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Tagline')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('form_option', [rt.new_string('blogdescription')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_tagline_description)
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('upload_files')])) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Site Icon')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_enqueue_media', []rt.PhpVal{})
		rt.call_function('wp_enqueue_script', [rt.new_string('site-icon')])
		mut var_classes_for_upload_button := 'upload-button button-hero button'
		mut var_classes_for_update_button := 'button'
		mut var_classes_for_wrapper := ''
		if rt.is_true(rt.call_function('has_site_icon', []rt.PhpVal{})) {
			var_classes_for_wrapper = var_classes_for_wrapper + ' has-site-icon'
			mut var_classes_for_button := var_classes_for_update_button
			mut var_classes_for_button_on_change := var_classes_for_upload_button
		} else {
			var_classes_for_wrapper = var_classes_for_wrapper + ' hidden'
			var_classes_for_button = var_classes_for_upload_button
			var_classes_for_button_on_change = var_classes_for_update_button
		}
		mut var_site_icon_id := rt.new_int((rt.call_function('get_option', [
			rt.new_string('site_icon'),
		])).to_i64())
		mut var_app_icon_alt_value := rt.new_string('')
		mut var_browser_icon_alt_value := rt.new_string('')
		mut var_site_icon_url := rt.call_function('get_site_icon_url', []rt.PhpVal{})
		if rt.is_true(var_site_icon_id) {
			mut var_img_alt := rt.call_function('get_post_meta', [
				var_site_icon_id.clone(), rt.new_string('_wp_attachment_image_alt'),
				rt.new_bool(true)])
			mut var_filename := rt.call_function('wp_basename', [
				var_site_icon_url.clone()])
			var_app_icon_alt_value = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('App icon preview: The current image has no alternative text. The file name is: %s'),
				]),
				var_filename.clone(),
			])
			var_browser_icon_alt_value = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Browser icon preview: The current image has no alternative text. The file name is: %s'),
				]),
				var_filename.clone(),
			])
			if rt.is_true(var_img_alt) {
				var_app_icon_alt_value = rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('App icon preview: Current image: %s'),
					]),
					var_img_alt.clone(),
				])
				var_browser_icon_alt_value = rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Browser icon preview: Current image: %s'),
					]),
					var_img_alt.clone(),
				])
			}
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_site_icon_url.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr',
			[rt.new_string(var_classes_for_wrapper.str()).clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_site_icon_url.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_app_icon_alt_value.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_site_icon_url.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_browser_icon_alt_value.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('bloginfo', [rt.new_string('name')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('form_option', [rt.new_string('site_icon')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr',
			[rt.new_string(var_classes_for_button.str()).clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr',
			[rt.new_string(var_classes_for_button_on_change.str()).clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Choose a Site Icon')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Change Site Icon')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Set as Site Icon')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.call_function('has_site_icon', []rt.PhpVal{}),
		]))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('has_site_icon', []rt.PhpVal{})) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Change Site Icon')])
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Choose a Site Icon')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		print(if rt.is_true(rt.call_function('has_site_icon', []rt.PhpVal{})) {
			'class="button button-secondary reset remove-site-icon"'
		} else {
			'class="button button-secondary reset remove-site-icon hidden"'
		})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Remove Site Icon')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('The Site Icon is what you see in browser tabs, bookmark bars, and within the WordPress mobile apps. It should be square and at least <code>%1$s by %2$s</code> pixels.'),
			]),
			rt.new_int(512),
			rt.new_int(512),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		mut var_wp_site_url_class := ''
		mut var_wp_home_class := ''
		if rt.is_true(rt.call_function('defined', [rt.new_string('WP_SITEURL')])) {
			var_wp_site_url_class = ' disabled'
		}
		if rt.is_true(rt.call_function('defined', [rt.new_string('WP_HOME')])) {
			var_wp_home_class = ' disabled'
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('WordPress Address (URL)')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('form_option', [rt.new_string('siteurl')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('disabled', [
			rt.call_function('defined', [rt.new_string('WP_SITEURL')]),
		])
		// unsupported statement: Stmt_InlineHTML
		print(var_wp_site_url_class)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Site Address (URL)')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('form_option', [rt.new_string('home')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('disabled', [
			rt.call_function('defined', [rt.new_string('WP_HOME')]),
		])
		// unsupported statement: Stmt_InlineHTML
		print(var_wp_home_class)
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
			rt.new_string('WP_HOME'),
		])))))
		{
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [
				rt.call_function('__', [
					rt.new_string('Enter the same address here unless you <a href="%s">want your site home page to be different from your WordPress installation directory</a>.'),
				]),
				rt.call_function('__', [
					rt.new_string('https://developer.wordpress.org/advanced-administration/server/wordpress-in-directory/'),
				]),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Administration Email Address')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('form_option', [rt.new_string('admin_email')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('This address is used for admin purposes. If you change this, an email will be sent to your new address to confirm it. <strong>The new address will not become active until confirmed.</strong>'),
	])
	// unsupported statement: Stmt_InlineHTML
	mut var_new_admin_email := rt.call_function('get_option', [
		rt.new_string('new_admin_email'),
	])
	if rt.is_true(var_new_admin_email)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('admin_email')]), var_new_admin_email)))) {
		mut var_pending_admin_email_message := rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('There is a pending change of the admin email to %s.'),
			]),
			rt.new_string('<code>' +
				(rt.call_function('esc_html', [var_new_admin_email.clone()])).str() + '</code>'),
		])
		var_pending_admin_email_message = rt.concat(var_pending_admin_email_message, rt.call_function('sprintf', [
			rt.new_string(' <a href="%1$s">%2$s</a>'),
			rt.call_function('esc_url', [
				rt.call_function('wp_nonce_url', [
					rt.call_function('admin_url', [
						rt.new_string('options.php?dismiss=new_admin_email'),
					]),
					rt.new_string('dismiss-' +
						(rt.call_function('get_current_blog_id', []rt.PhpVal{})).str() +
						'-new_admin_email'),
				]),
			]),
			rt.call_function('__', [
				rt.new_string('Cancel'),
			]),
		]))
		rt.call_function('wp_admin_notice', [var_pending_admin_email_message.clone(),
			rt.create_array([
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'updated' },
					rt.ArrayItem{ key: none, val: 'inline' },
				]) },
			])])
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		mut var_membership_title := rt.call_function('__', [rt.new_string('Membership')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_membership_title)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_membership_title)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [rt.new_string('1'),
			rt.call_function('get_option', [rt.new_string('users_can_register')])])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Anyone can register')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('New User Default Role')])
		// unsupported statement: Stmt_InlineHTML
		mut var_excluded_roles := rt.cast_array(rt.call_function('apply_filters', [
			rt.new_string('default_role_dropdown_excluded_roles'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'administrator' },
				rt.ArrayItem{ key: none, val: 'editor' }]),
		]))
		mut var_editable_roles := rt.call_function('array_reverse', [
			rt.call_function('get_editable_roles', []rt.PhpVal{}),
		])
		mut var_selected := rt.call_function('get_option', [
			rt.new_string('default_role'),
		])
		mut iter_1 := var_editable_roles.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_details := item_1.val
			mut var_role := item_1.key
			if rt.is_true(rt.call_function('in_array', [var_role.clone(), var_excluded_roles.clone(), rt.new_bool(true)]))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_role, var_selected)))) {
				var_editable_roles.array_unset(var_role)
			}
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_dropdown_roles', [var_selected.clone(),
			var_editable_roles.clone()])
		// unsupported statement: Stmt_InlineHTML
	}
	mut var_languages := rt.call_function('get_available_languages', []rt.PhpVal{})
	mut var_translations := rt.call_function('wp_get_available_translations', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_function('defined', [rt.new_string('WPLANG')]))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.get_constant('WPLANG')))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('en_US'), rt.get_constant('WPLANG')))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_constant('WPLANG'), var_languages.clone(), rt.new_bool(true)]))))) {
		var_languages.array_push(rt.get_constant('WPLANG'))
	}
	if !(!rt.is_true(var_languages)) || !(!rt.is_true(var_translations)) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Site Language')])
		// unsupported statement: Stmt_InlineHTML
		mut var_locale := rt.call_function('get_locale', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_locale.clone(), var_languages.clone(), rt.new_bool(true)])))))
		{
			var_locale = rt.new_string('')
		}
		rt.call_function('wp_dropdown_languages', [
			rt.create_array([rt.ArrayItem{ key: 'name', val: 'WPLANG' },
				rt.ArrayItem{ key: 'id', val: 'WPLANG' }, rt.ArrayItem{
					key: 'selected'
					val: var_locale
				}, rt.ArrayItem{ key: 'languages', val: var_languages },
				rt.ArrayItem{ key: 'translations', val: var_translations },
				rt.ArrayItem{ key: 'show_available_translations', val:
					rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_languages')]))
					&& rt.is_true(rt.call_function('wp_can_install_language_pack', []rt.PhpVal{})) }]),
		])
		if rt.is_true(rt.call_function('defined', [rt.new_string('WPLANG')]))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.get_constant('WPLANG')))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_constant('WPLANG'), var_locale)))) {
			rt.call_function('_deprecated_argument', [rt.new_string('define()'),
				rt.new_string('4.0.0'),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('The %1$s constant in your %2$s file is no longer needed.'),
					]),
					rt.new_string('WPLANG'),
					rt.new_string('wp-config.php'),
				])])
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_current_offset := rt.call_function('get_option', [
		rt.new_string('gmt_offset'),
	])
	mut var_tzstring := rt.call_function('get_option', [rt.new_string('timezone_string')])
	mut var_check_zone_info := true
	if rt.is_true(rt.call_function('str_contains', [var_tzstring.clone(),
		rt.new_string('Etc/GMT')]))
	{
		var_tzstring = rt.new_string('')
	}
	if !rt.is_true(var_tzstring) {
		var_check_zone_info = false
		if 0 == rt.new_int(var_current_offset.to_i64()) {
			var_tzstring = rt.new_string('UTC+0')
		} else if rt.is_true(rt.less(var_current_offset, rt.new_int(0))) {
			var_tzstring = rt.new_string('UTC' + var_current_offset.str())
		} else {
			var_tzstring = rt.new_string('UTC+' + var_current_offset.str())
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Timezone')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_timezone_choice', [var_tzstring.clone(),
		rt.call_function('get_user_locale', []rt.PhpVal{})]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('Choose either a city in the same timezone as you or a %s (Coordinated Universal Time) time offset.'),
		]),
		rt.new_string('<abbr>UTC</abbr>'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('Universal time is %s.')]),
		rt.new_string('<code>' +
			(rt.call_function('date_i18n', [var_timezone_format.clone(), rt.new_bool(false), rt.new_bool(true)])).str() +
			'</code>'),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('get_option', [rt.new_string('timezone_string')]))
		|| !(!rt.is_true(var_current_offset)) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [rt.new_string('Local time is %s.')]),
			rt.new_string('<code>' +
				(rt.call_function('date_i18n', [var_timezone_format.clone()])).str() + '</code>'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if var_check_zone_info && rt.is_true(var_tzstring) {
		// unsupported statement: Stmt_InlineHTML
		mut var_now := create_datetime(rt.new_string('now'),
			create_datetimezone(var_tzstring.clone()))
		mut var_dst := rt.new_bool((var_now.format(rt.new_string('I'))).to_bool())
		if rt.is_true(var_dst) {
			rt.call_function('_e', [
				rt.new_string('This timezone is currently in daylight saving time.'),
			])
		} else {
			rt.call_function('_e', [
				rt.new_string('This timezone is currently in standard time.'),
			])
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('in_array', [var_tzstring.clone(),
			rt.call_function('timezone_identifiers_list', [
				Class_DateTimeZone.all_with_bc(),
			]),
			rt.new_bool(true)]))
		{
			mut var_transitions := rt.call_function('timezone_transitions_get', [
				rt.call_function('timezone_open', [var_tzstring.clone()]),
				rt.call_function('time', []rt.PhpVal{}),
			])
			if !(!rt.is_true(var_transitions.array_get(rt.new_int(1)))) {
				print(' ')
				mut var_message := if rt.is_true(var_transitions.array_get(rt.new_int(1)).array_get(rt.new_string('isdst'))) { rt.call_function('__', [
						rt.new_string('Daylight saving time begins on: %s.'),
					]) } else { rt.call_function('__', [
						rt.new_string('Standard time begins on: %s.'),
					]) }
				rt.call_function('printf', [var_message.clone(),
					rt.new_string('<code>' +
						(rt.call_function('wp_date', [rt.call_function('__', [rt.new_string('F j, Y g:i a')]), var_transitions.array_get(rt.new_int(1)).array_get(rt.new_string('ts'))])).str() +
						'</code>')])
			} else {
				rt.call_function('_e', [
					rt.new_string('This timezone does not observe daylight saving time.'),
				])
			}
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_date_format_title := rt.call_function('__', [rt.new_string('Date Format')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_date_format_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_date_format_title)
	// unsupported statement: Stmt_InlineHTML
	mut var_date_formats := rt.call_function('array_unique', [
		rt.call_function('apply_filters', [rt.new_string('date_formats'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('F j, Y'),
				]) },
				rt.ArrayItem{ key: none, val: 'Y-m-d' },
				rt.ArrayItem{ key: none, val: 'm/d/Y' },
				rt.ArrayItem{ key: none, val: 'd/m/Y' },
				rt.ArrayItem{ key: none, val: 'd.m.Y' },
			])]),
	])
	mut var_custom := true
	mut iter_2 := var_date_formats.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_format := item_2.val
		print("\t<label><input type='radio' name='date_format' value='" +
			(rt.call_function('esc_attr', [var_format.clone()])).str() + "'")
		if rt.is_true(rt.identical(rt.call_function('get_option', [
			rt.new_string('date_format'),
		]), var_format))
		{
			print(" checked='checked'")
			var_custom = false
		}
		print(' /> <span class="date-time-text format-i18n">' +
			(rt.call_function('date_i18n', [var_format.clone()])).str() + '</span><code>' +
			(rt.call_function('esc_html', [var_format.clone()])).str() + '</code></label><br />\n')
	}
	print('<label><input type="radio" name="date_format" id="date_format_custom_radio" value="\\c\\u\\s\\t\\o\\m"')
	rt.call_function('checked', [rt.new_bool(var_custom).clone()])
	print('/> <span class="date-time-text date-time-custom-text">' +
		(rt.call_function('__', [rt.new_string('Custom:')])).str() +
		'<span class="screen-reader-text"> ' +
		(rt.call_function('__', [rt.new_string('enter a custom date format in the following field')])).str() +
		'</span></span></label>' + '<label for="date_format_custom" class="screen-reader-text">' +
		(rt.call_function('__', [rt.new_string('Custom date format:')])).str() + '</label>' +
		'<input type="text" name="date_format_custom" id="date_format_custom" value="' +
		(rt.call_function('esc_attr', [rt.call_function('get_option', [rt.new_string('date_format')])])).str() +
		'" class="small-text" />' + '<br />' + '<p><strong>' +
		(rt.call_function('__', [rt.new_string('Preview:')])).str() +
		'</strong> <span class="example">' +
		(rt.call_function('date_i18n', [rt.call_function('get_option', [rt.new_string('date_format')])])).str() +
		'</span>' + "<span class='spinner'></span>\n" + '</p>')
	// unsupported statement: Stmt_InlineHTML
	mut var_time_format_title := rt.call_function('__', [rt.new_string('Time Format')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_time_format_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_time_format_title)
	// unsupported statement: Stmt_InlineHTML
	mut var_time_formats := rt.call_function('array_unique', [
		rt.call_function('apply_filters', [rt.new_string('time_formats'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('g:i a'),
				]) },
				rt.ArrayItem{ key: none, val: 'g:i A' },
				rt.ArrayItem{ key: none, val: 'H:i' },
			])]),
	])
	var_custom = true
	mut iter_3 := var_time_formats.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_format := item_3.val
		print("\t<label><input type='radio' name='time_format' value='" +
			(rt.call_function('esc_attr', [var_format.clone()])).str() + "'")
		if rt.is_true(rt.identical(rt.call_function('get_option', [
			rt.new_string('time_format'),
		]), var_format))
		{
			print(" checked='checked'")
			var_custom = false
		}
		print(' /> <span class="date-time-text format-i18n">' +
			(rt.call_function('date_i18n', [var_format.clone()])).str() + '</span><code>' +
			(rt.call_function('esc_html', [var_format.clone()])).str() + '</code></label><br />\n')
	}
	print('<label><input type="radio" name="time_format" id="time_format_custom_radio" value="\\c\\u\\s\\t\\o\\m"')
	rt.call_function('checked', [rt.new_bool(var_custom).clone()])
	print('/> <span class="date-time-text date-time-custom-text">' +
		(rt.call_function('__', [rt.new_string('Custom:')])).str() +
		'<span class="screen-reader-text"> ' +
		(rt.call_function('__', [rt.new_string('enter a custom time format in the following field')])).str() +
		'</span></span></label>' + '<label for="time_format_custom" class="screen-reader-text">' +
		(rt.call_function('__', [rt.new_string('Custom time format:')])).str() + '</label>' +
		'<input type="text" name="time_format_custom" id="time_format_custom" value="' +
		(rt.call_function('esc_attr', [rt.call_function('get_option', [rt.new_string('time_format')])])).str() +
		'" class="small-text" />' + '<br />' + '<p><strong>' +
		(rt.call_function('__', [rt.new_string('Preview:')])).str() +
		'</strong> <span class="example">' +
		(rt.call_function('date_i18n', [rt.call_function('get_option', [rt.new_string('time_format')])])).str() +
		'</span>' + "<span class='spinner'></span>\n" + '</p>')
	print("\t<p class='date-time-doc'>" +
		(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/customize-date-and-time-format/">Documentation on date and time formatting</a>.')])).str() +
		'</p>\n')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Week Starts On')])
	// unsupported statement: Stmt_InlineHTML
	mut var_day_index := 0
	for {
		if !(var_day_index <= 6) { break
		 }
		var_selected = rt.new_string((if rt.new_int((rt.call_function('get_option', [
			rt.new_string('start_of_week'),
		])).to_i64()) == var_day_index { 'selected="selected"' } else { '' }).str())
		print("\n\t<option value='" +
			(rt.call_function('esc_attr', [rt.new_int(var_day_index).clone()])).str() +
			"' ${var_selected.to_string()}>" +
			(rt.call_method(var_wp_locale, 'get_weekday', [rt.new_int(var_day_index).clone()])).str() +
			'</option>')
		var_day_index += 1
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_settings_fields', [rt.new_string('general'),
		rt.new_string('default')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_settings_sections', [rt.new_string('general')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
