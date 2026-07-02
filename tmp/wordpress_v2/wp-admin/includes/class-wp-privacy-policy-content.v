import rt

struct Class_WP_Privacy_Policy_Content {
	rt.PhpObjectBase
}

fn init_static_wp_privacy_policy_content() {
	rt.init_static_prop('WP_Privacy_Policy_Content', 'policy_content', rt.new_array())
}

fn (mut this Class_WP_Privacy_Policy_Content) construct() {
}

fn Class_WP_Privacy_Policy_Content.add(var_plugin_name rt.PhpVal, var_policy_text rt.PhpVal) {
	mut var_plugin_name_mutated := var_plugin_name
	if !rt.is_true(var_plugin_name_mutated) || !rt.is_true(var_policy_text) {
		return
	}
	mut var_data := {
		'plugin_name': var_plugin_name_mutated
		'policy_text': var_policy_text
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.create_array_from_native_map(var_data),
		rt.get_static_prop('WP_Privacy_Policy_Content', 'policy_content'),
		rt.new_bool(true),
	])))))
	{
		rt.get_static_prop('WP_Privacy_Policy_Content', 'policy_content').array_push(var_data.clone())
	}
}

fn Class_WP_Privacy_Policy_Content.text_change_check() bool {
	mut var_policy_page_id := rt.new_int((rt.call_function('get_option', [
		rt.new_string('wp_page_for_privacy_policy'),
	])).to_i64())
	if !rt.is_true(var_policy_page_id) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		var_policy_page_id.clone(),
	])))))
	{
		return false
	}
	mut var_old := rt.cast_array(rt.call_function('get_post_meta', [
		var_policy_page_id.clone(), rt.new_string('_wp_suggested_privacy_policy_content')]))
	if !rt.is_true(var_old) {
		return false
	}
	mut var_cached := rt.call_function('get_option', [
		rt.new_string('_wp_suggested_policy_text_has_changed'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [
		rt.new_string('admin_init'),
	])))))
	{
		return (rt.identical(rt.new_string('changed'), var_cached)).to_bool()
	}
	mut var_new := rt.get_static_prop('WP_Privacy_Policy_Content', 'policy_content')
	mut iter_1 := var_old.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_data := item_1.val
		mut var_key := item_1.key
		if !(var_data.clone().is_array())
			|| !(!rt.is_true(var_data.array_get(rt.new_string('removed')))) {
			var_old.array_unset(var_key)
			continue
		}
		var_old.array_set(var_key, rt.create_array([
			rt.ArrayItem{ key: 'plugin_name', val: var_data.array_get(rt.new_string('plugin_name')) },
			rt.ArrayItem{ key: 'policy_text', val: var_data.array_get(rt.new_string('policy_text')) },
		]))
	}
	rt.call_function('sort', [var_old.clone()])
	rt.call_function('sort', [var_new.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_new, var_old)))) {
		rt.call_function('add_action', [rt.new_string('admin_notices'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'WP_Privacy_Policy_Content' },
				rt.ArrayItem{ key: none, val: 'policy_text_changed_notice' }])])
		mut var_state := rt.new_string('changed')
	} else {
		var_state = rt.new_string('not-changed')
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_cached, var_state)))) {
		rt.call_function('update_option', [
			rt.new_string('_wp_suggested_policy_text_has_changed'),
			var_state.clone(),
			rt.new_bool(false),
		])
	}
	return (rt.identical(rt.new_string('changed'), var_state)).to_bool()
}

fn Class_WP_Privacy_Policy_Content.policy_text_changed_notice() {
	mut var_screen := rt.get_property(rt.call_function('get_current_screen', []rt.PhpVal{}), 'id')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('privacy'), var_screen)))) {
		return
	}
	mut var_privacy_message := rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('The suggested privacy policy text has changed. Please <a href="%s">review the guide</a> and update your privacy policy.'),
		]),
		rt.call_function('esc_url', [
			rt.call_function('admin_url', [
				rt.new_string('privacy-policy-guide.php?tab=policyguide'),
			]),
		]),
	])
	rt.call_function('wp_admin_notice', [var_privacy_message.clone(),
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'warning' },
			rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'policy-text-updated' },
			]) }, rt.ArrayItem{ key: 'dismissible', val: true }])])
}

fn Class_WP_Privacy_Policy_Content._policy_page_updated(var_post_id rt.PhpVal) {
	mut var_policy_page_id := rt.new_int((rt.call_function('get_option', [
		rt.new_string('wp_page_for_privacy_policy'),
	])).to_i64())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_policy_page_id))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_policy_page_id, rt.new_int(var_post_id.to_i64()))))) {
		return
	}
	mut var_old := rt.cast_array(rt.call_function('get_post_meta', [
		var_policy_page_id.clone(), rt.new_string('_wp_suggested_privacy_policy_content')]))
	mut var_done := rt.new_array()
	mut var_update_cache := rt.new_bool(false)
	mut iter_2 := var_old.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_old_data := item_2.val
		mut var_old_key := item_2.key
		if !(!rt.is_true(var_old_data.array_get(rt.new_string('removed')))) {
			var_update_cache = rt.new_bool(true)
			continue
		}
		if !(!rt.is_true(var_old_data.array_get(rt.new_string('updated')))) {
			var_done << rt.create_array([
				rt.ArrayItem{
					key: 'plugin_name'
					val: var_old_data.array_get(rt.new_string('plugin_name'))
				},
				rt.ArrayItem{
					key: 'policy_text'
					val: var_old_data.array_get(rt.new_string('policy_text'))
				},
				rt.ArrayItem{ key: 'added', val: var_old_data.array_get(rt.new_string('updated')) },
			])
			var_update_cache = rt.new_bool(true)
		} else {
			var_done << var_old_data.clone()
		}
	}
	if rt.is_true(var_update_cache) {
		rt.call_function('delete_post_meta', [var_policy_page_id.clone(),
			rt.new_string('_wp_suggested_privacy_policy_content')])
		for var_data in var_done {
			rt.call_function('add_post_meta', [var_policy_page_id.clone(),
				rt.new_string('_wp_suggested_privacy_policy_content'),
				var_data.clone()])
		}
	}
}

fn Class_WP_Privacy_Policy_Content.get_suggested_policy_text() rt.PhpVal {
	mut var_policy_page_id := rt.new_int((rt.call_function('get_option', [
		rt.new_string('wp_page_for_privacy_policy'),
	])).to_i64())
	mut var_checked := rt.new_array()
	mut var_time := rt.call_function('time', []rt.PhpVal{})
	mut var_update_cache := rt.new_bool(false)
	mut var_new := rt.get_static_prop('WP_Privacy_Policy_Content', 'policy_content')
	mut var_old := rt.new_array()
	if rt.is_true(var_policy_page_id) {
		var_old = rt.cast_array(rt.call_function('get_post_meta', [
			var_policy_page_id.clone(), rt.new_string('_wp_suggested_privacy_policy_content')]))
	}
	mut iter_3 := var_new.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_new_data := item_3.val
		mut var_new_key := item_3.key
		mut iter_4 := var_old.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_old_data := item_4.val
			mut var_old_key := item_4.key
			mut var_found := rt.new_bool(false)
			if rt.is_true(rt.identical(var_new_data.array_get(rt.new_string('policy_text')),
				var_old_data.array_get(rt.new_string('policy_text'))))
			{
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_old_data.array_get(rt.new_string('plugin_name')),
					var_new_data.array_get(rt.new_string('plugin_name'))))))
				{
					var_old_data.array_set('plugin_name',
						var_new_data.array_get(rt.new_string('plugin_name')))
					var_update_cache = rt.new_bool(true)
				}
				if !(!rt.is_true(var_old_data.array_get(rt.new_string('removed')))) {
					var_old_data.array_unset(rt.new_string('removed'))
					var_old_data.array_set('added', var_time.clone())
					var_update_cache = rt.new_bool(true)
				}
				var_checked << var_old_data.clone()
				var_found = rt.new_bool(true)
			} else if rt.is_true(rt.identical(var_new_data.array_get(rt.new_string('plugin_name')),
				var_old_data.array_get(rt.new_string('plugin_name'))))
			{
				var_checked << rt.create_array([
					rt.ArrayItem{
						key: 'plugin_name'
						val: var_new_data.array_get(rt.new_string('plugin_name'))
					},
					rt.ArrayItem{
						key: 'policy_text'
						val: var_new_data.array_get(rt.new_string('policy_text'))
					},
					rt.ArrayItem{ key: 'updated', val: var_time },
				])
				var_found = rt.new_bool(true)
				var_update_cache = rt.new_bool(true)
			}
			if rt.is_true(var_found) {
				var_new.array_unset(var_new_key)
				var_old.array_unset(var_old_key)
				continue
			}
		}
	}
	if !(!rt.is_true(var_new)) {
		mut iter_5 := var_new.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_new_data := item_5.val
			if !(!rt.is_true(var_new_data.array_get(rt.new_string('plugin_name'))))
				&& !(!rt.is_true(var_new_data.array_get(rt.new_string('policy_text')))) {
				var_new_data.array_set('added', var_time.clone())
				var_checked << var_new_data.clone()
			}
		}
		var_update_cache = rt.new_bool(true)
	}
	if !(!rt.is_true(var_old)) {
		mut iter_6 := var_old.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_old_data := item_6.val
			if !(!rt.is_true(var_old_data.array_get(rt.new_string('plugin_name'))))
				&& !(!rt.is_true(var_old_data.array_get(rt.new_string('policy_text')))) {
				mut var_data := {
					'plugin_name': var_old_data.array_get(rt.new_string('plugin_name'))
					'policy_text': var_old_data.array_get(rt.new_string('policy_text'))
					'removed':     var_time
				}
				var_checked << var_data.clone()
			}
		}
		var_update_cache = rt.new_bool(true)
	}
	if rt.is_true(var_update_cache) && rt.is_true(var_policy_page_id) {
		rt.call_function('delete_post_meta', [var_policy_page_id.clone(),
			rt.new_string('_wp_suggested_privacy_policy_content')])
		for var_data in var_checked {
			rt.call_function('add_post_meta', [var_policy_page_id.clone(),
				rt.new_string('_wp_suggested_privacy_policy_content'),
				var_data.clone()])
		}
	}
	return var_checked.clone()
}

fn Class_WP_Privacy_Policy_Content.notice(var_post rt.PhpVal) {
	mut var_post_mutated := var_post
	if rt.is_true(rt.new_bool(var_post_mutated.clone().is_null())) {
	} else {
		var_post_mutated = rt.call_function('get_post', [var_post_mutated.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_post_mutated, 'WP_Post')))))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_privacy_options'),
	])))))
	{
		return
	}
	mut var_current_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	mut var_policy_page_id := rt.new_int((rt.call_function('get_option', [
		rt.new_string('wp_page_for_privacy_policy'),
	])).to_i64())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('post'), rt.get_property(var_current_screen, 'base')))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_policy_page_id, rt.get_property(var_post_mutated, 'ID'))))) {
		return
	}
	mut var_message := rt.call_function('__', [
		rt.new_string('Need help putting together your new Privacy Policy page? Check out the guide for recommendations on what content to include, along with policies suggested by your plugins and theme.'),
	])
	mut var_url := rt.call_function('esc_url', [
		rt.call_function('admin_url', [
			rt.new_string('options-privacy.php?tab=policyguide'),
		]),
	])
	mut var_label := rt.call_function('__', [rt.new_string('View Privacy Policy Guide.')])
	if rt.is_true(rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}),
		'is_block_editor', []rt.PhpVal{}))
	{
		rt.call_function('wp_enqueue_script', [rt.new_string('wp-notices')])
		mut var_action := {
			'url':   var_url
			'label': var_label
		}
		rt.call_function('wp_add_inline_script', [rt.new_string('wp-notices'),
			rt.call_function('sprintf', [
				rt.new_string('wp.data.dispatch( "core/notices" ).createWarningNotice( "%s", { actions: [ %s ], isDismissible: false } )'),
				var_message.clone(),
				rt.call_function('wp_json_encode', [
					rt.create_array_from_native_map(var_action),
					rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
						rt.get_constant('JSON_UNESCAPED_SLASHES')),
				]),
			]),
			rt.new_string('after')])
	} else {
		var_message = rt.concat(var_message, rt.call_function('sprintf', [
			rt.new_string(' <a href="%s" target="_blank">%s <span class="screen-reader-text">%s</span></a>'),
			var_url.clone(),
			var_label.clone(),
			rt.call_function('__', [rt.new_string('(opens in a new tab)')]),
		]))
		rt.call_function('wp_admin_notice', [var_message.clone(),
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'warning' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'inline' },
					rt.ArrayItem{ key: none, val: 'wp-pp-notice' },
				]) }])])
	}
}

fn Class_WP_Privacy_Policy_Content.privacy_policy_guide() {
	mut var_content_array := Class_WP_Privacy_Policy_Content.get_suggested_policy_text()
	mut var_date_format := rt.call_function('__', [rt.new_string('F j, Y')])
	mut var_i := rt.new_int(0)
	mut iter_7 := var_content_array.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_section := item_7.val
		rt.pre_inc(var_i)
		mut var_removed := rt.new_string('')
		if !(!rt.is_true(var_section.array_get(rt.new_string('removed')))) {
			mut var_badge_class := rt.new_string(' red')
			mut var_date := rt.call_function('date_i18n', [var_date_format.clone(),
				var_section.array_get(rt.new_string('removed'))])
			mut var_badge_title := rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Removed %s.')]),
				var_date.clone(),
			])
			var_removed = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('You deactivated this plugin on %s and may no longer need this policy.'),
				]),
				var_date.clone(),
			])
			var_removed = rt.call_function('wp_get_admin_notice', [
				var_removed.clone(),
				rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'info' },
					rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'inline' },
					]) },
				])])
		} else if !(!rt.is_true(var_section.array_get(rt.new_string('updated')))) {
			var_badge_class = rt.new_string(' blue')
			var_date = rt.call_function('date_i18n', [var_date_format.clone(),
				var_section.array_get(rt.new_string('updated'))])
			var_badge_title = rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Updated %s.')]),
				var_date.clone(),
			])
		}
		mut var_plugin_name := rt.call_function('esc_html', [
			var_section.array_get(rt.new_string('plugin_name')),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_i)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_plugin_name)
		// unsupported statement: Stmt_InlineHTML
		if !(!rt.is_true(var_section.array_get(rt.new_string('removed'))))
			|| !(!rt.is_true(var_section.array_get(rt.new_string('updated')))) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_badge_class)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_badge_title)
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_i)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_removed)
		rt.echo_val(var_section.array_get(rt.new_string('policy_text')))
		// unsupported statement: Stmt_InlineHTML
		if !rt.is_true(var_section.array_get(rt.new_string('removed'))) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Copied!')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('Copy suggested policy text to clipboard'),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [
				rt.call_function('__', [
					rt.new_string('Copy suggested policy text from %s.'),
				]),
				var_plugin_name.clone(),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
}

fn Class_WP_Privacy_Policy_Content.get_default_content(description bool, blocks bool) rt.PhpVal {
	mut var_suggested_text := rt.new_string('<strong class="privacy-policy-tutorial">' +
		(rt.call_function('__', [rt.new_string('Suggested text:')])).str() + ' </strong>')
	mut var_content := rt.new_string('')
	mut var_strings := rt.new_array()
	if var_description {
		var_strings.array_push('<div class="wp-suggested-text">')
	}
	var_strings.array_push('<h2 class="wp-block-heading">' +
		(rt.call_function('__', [rt.new_string('Who we are')])).str() + '</h2>')
	if var_description {
		var_strings.array_push('<p class="privacy-policy-tutorial">' +
			(rt.call_function('__', [rt.new_string('In this section you should note your site URL, as well as the name of the company, organization, or individual behind it, and some accurate contact information.')])).str() +
			'</p>')
		var_strings.array_push('<p class="privacy-policy-tutorial">' +
			(rt.call_function('__', [rt.new_string('The amount of information you may be required to show will vary depending on your local or national business regulations. You may, for example, be required to display a physical address, a registered address, or your company registration number.')])).str() +
			'</p>')
	} else {
		var_strings.array_push('<p>' + var_suggested_text.str() +
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Our website address is: %s.')]), rt.call_function('get_bloginfo', [rt.new_string('url'), rt.new_string('display')])])).str() +
			'</p>')
	}
	if var_description {
		var_strings.array_push('<h2>' +
			(rt.call_function('__', [rt.new_string('What personal data we collect and why we collect it')])).str() +
			'</h2>')
		var_strings.array_push('<p class="privacy-policy-tutorial">' +
			(rt.call_function('__', [rt.new_string('In this section you should note what personal data you collect from users and site visitors. This may include personal data, such as name, email address, personal account preferences; transactional data, such as purchase information; and technical data, such as information about cookies.')])).str() +
			'</p>')
		var_strings.array_push('<p class="privacy-policy-tutorial">' +
			(rt.call_function('__', [rt.new_string('You should also note any collection and retention of sensitive personal data, such as data concerning health.')])).str() +
			'</p>')
		var_strings.array_push('<p class="privacy-policy-tutorial">' +
			(rt.call_function('__', [rt.new_string('In addition to listing what personal data you collect, you need to note why you collect it. These explanations must note either the legal basis for your data collection and retention or the active consent the user has given.')])).str() +
			'</p>')
		var_strings.array_push('<p class="privacy-policy-tutorial">' +
			(rt.call_function('__', [rt.new_string('Personal data is not just created by a user&#8217;s interactions with your site. Personal data is also generated from technical processes such as contact forms, comments, cookies, analytics, and third party embeds.')])).str() +
			'</p>')
		var_strings.array_push('<p class="privacy-policy-tutorial">' +
			(rt.call_function('__', [rt.new_string('By default WordPress does not collect any personal data about visitors, and only collects the data shown on the User Profile screen from registered users. However some of your plugins may collect personal data. You should add the relevant information below.')])).str() +
			'</p>')
	}
	var_strings.array_push('<h2 class="wp-block-heading">' +
		(rt.call_function('__', [rt.new_string('Comments')])).str() + '</h2>')
	if var_description {
		var_strings.array_push('<p class="privacy-policy-tutorial">' +
			(rt.call_function('__', [rt.new_string('In this subsection you should note what information is captured through comments. We have noted the data which WordPress collects by default.')])).str() +
			'</p>')
	} else {
		var_strings.array_push('<p>' + var_suggested_text.str() +
			(rt.call_function('__', [rt.new_string('When visitors leave comments on the site we collect the data shown in the comments form, and also the visitor&#8217;s IP address and browser user agent string to help spam detection.')])).str() +
			'</p>')
		var_strings.array_push('<p>' +
			(rt.call_function('__', [rt.new_string('An anonymized string created from your email address (also called a hash) may be provided to the Gravatar service to see if you are using it. The Gravatar service privacy policy is available here: https://automattic.com/privacy/. After approval of your comment, your profile picture is visible to the public in the context of your comment.')])).str() +
			'</p>')
	}
	var_strings.array_push('<h2 class="wp-block-heading">' +
		(rt.call_function('__', [rt.new_string('Media')])).str() + '</h2>')
	if var_description {
		var_strings.array_push('<p class="privacy-policy-tutorial">' +
			(rt.call_function('__', [rt.new_string('In this subsection you should note what information may be disclosed by users who can upload media files. All uploaded files are usually publicly accessible.')])).str() +
			'</p>')
	} else {
		var_strings.array_push('<p>' + var_suggested_text.str() +
			(rt.call_function('__', [rt.new_string('If you upload images to the website, you should avoid uploading images with embedded location data (EXIF GPS) included. Visitors to the website can download and extract any location data from images on the website.')])).str() +
			'</p>')
	}
	if var_description {
		var_strings.array_push('<h2>' +
			(rt.call_function('__', [rt.new_string('Contact forms')])).str() + '</h2>')
		var_strings.array_push('<p class="privacy-policy-tutorial">' +
			(rt.call_function('__', [rt.new_string('By default, WordPress does not include a contact form. If you use a contact form plugin, use this subsection to note what personal data is captured when someone submits a contact form, and how long you keep it. For example, you may note that you keep contact form submissions for a certain period for customer service purposes, but you do not use the information submitted through them for marketing purposes.')])).str() +
			'</p>')
	}
	var_strings.array_push('<h2 class="wp-block-heading">' +
		(rt.call_function('__', [rt.new_string('Cookies')])).str() + '</h2>')
	if var_description {
		var_strings.array_push('<p class="privacy-policy-tutorial">' +
			(rt.call_function('__', [rt.new_string('In this subsection you should list the cookies your website uses, including those set by your plugins, social media, and analytics. We have provided the cookies which WordPress installs by default.')])).str() +
			'</p>')
	} else {
		var_strings.array_push('<p>' + var_suggested_text.str() +
			(rt.call_function('__', [rt.new_string('If you leave a comment on our site you may opt-in to saving your name, email address and website in cookies. These are for your convenience so that you do not have to fill in your details again when you leave another comment. These cookies will last for one year.')])).str() +
			'</p>')
		var_strings.array_push('<p>' +
			(rt.call_function('__', [rt.new_string('If you visit our login page, we will set a temporary cookie to determine if your browser accepts cookies. This cookie contains no personal data and is discarded when you close your browser.')])).str() +
			'</p>')
		var_strings.array_push('<p>' +
			(rt.call_function('__', [rt.new_string('When you log in, we will also set up several cookies to save your login information and your screen display choices. Login cookies last for two days, and screen options cookies last for a year. If you select &quot;Remember Me&quot;, your login will persist for two weeks. If you log out of your account, the login cookies will be removed.')])).str() +
			'</p>')
		var_strings.array_push('<p>' +
			(rt.call_function('__', [rt.new_string('If you edit or publish an article, an additional cookie will be saved in your browser. This cookie includes no personal data and simply indicates the post ID of the article you just edited. It expires after 1 day.')])).str() +
			'</p>')
	}
	if !var_description {
		var_strings.array_push('<h2 class="wp-block-heading">' +
			(rt.call_function('__', [rt.new_string('Embedded content from other websites')])).str() +
			'</h2>')
		var_strings.array_push('<p>' + var_suggested_text.str() +
			(rt.call_function('__', [rt.new_string('Articles on this site may include embedded content (e.g. videos, images, articles, etc.). Embedded content from other websites behaves in the exact same way as if the visitor has visited the other website.')])).str() +
			'</p>')
		var_strings.array_push('<p>' +
			(rt.call_function('__', [rt.new_string('These websites may collect data about you, use cookies, embed additional third-party tracking, and monitor your interaction with that embedded content, including tracking your interaction with the embedded content if you have an account and are logged in to that website.')])).str() +
			'</p>')
	}
	if var_description {
		var_strings.array_push('<h2>' +
			(rt.call_function('__', [rt.new_string('Analytics')])).str() + '</h2>')
		var_strings.array_push('<p class="privacy-policy-tutorial">' +
			(rt.call_function('__', [rt.new_string('In this subsection you should note what analytics package you use, how users can opt out of analytics tracking, and a link to your analytics provider&#8217;s privacy policy, if any.')])).str() +
			'</p>')
		var_strings.array_push('<p class="privacy-policy-tutorial">' +
			(rt.call_function('__', [rt.new_string('By default WordPress does not collect any analytics data. However, many web hosting accounts collect some anonymous analytics data. You may also have installed a WordPress plugin that provides analytics services. In that case, add information from that plugin here.')])).str() +
			'</p>')
	}
	var_strings.array_push('<h2 class="wp-block-heading">' +
		(rt.call_function('__', [rt.new_string('Who we share your data with')])).str() + '</h2>')
	if var_description {
		var_strings.array_push('<p class="privacy-policy-tutorial">' +
			(rt.call_function('__', [rt.new_string('In this section you should name and list all third party providers with whom you share site data, including partners, cloud-based services, payment processors, and third party service providers, and note what data you share with them and why. Link to their own privacy policies if possible.')])).str() +
			'</p>')
		var_strings.array_push('<p class="privacy-policy-tutorial">' +
			(rt.call_function('__', [rt.new_string('By default WordPress does not share any personal data with anyone.')])).str() +
			'</p>')
	} else {
		var_strings.array_push('<p>' + var_suggested_text.str() +
			(rt.call_function('__', [rt.new_string('If you request a password reset, your IP address will be included in the reset email.')])).str() +
			'</p>')
	}
	var_strings.array_push('<h2 class="wp-block-heading">' +
		(rt.call_function('__', [rt.new_string('How long we retain your data')])).str() + '</h2>')
	if var_description {
		var_strings.array_push('<p class="privacy-policy-tutorial">' +
			(rt.call_function('__', [rt.new_string('In this section you should explain how long you retain personal data collected or processed by the website. While it is your responsibility to come up with the schedule of how long you keep each dataset for and why you keep it, that information does need to be listed here. For example, you may want to say that you keep contact form entries for six months, analytics records for a year, and customer purchase records for ten years.')])).str() +
			'</p>')
	} else {
		var_strings.array_push('<p>' + var_suggested_text.str() +
			(rt.call_function('__', [rt.new_string('If you leave a comment, the comment and its metadata are retained indefinitely. This is so we can recognize and approve any follow-up comments automatically instead of holding them in a moderation queue.')])).str() +
			'</p>')
		var_strings.array_push('<p>' +
			(rt.call_function('__', [rt.new_string('For users that register on our website (if any), we also store the personal information they provide in their user profile. All users can see, edit, or delete their personal information at any time (except they cannot change their username). Website administrators can also see and edit that information.')])).str() +
			'</p>')
	}
	var_strings.array_push('<h2 class="wp-block-heading">' +
		(rt.call_function('__', [rt.new_string('What rights you have over your data')])).str() +
		'</h2>')
	if var_description {
		var_strings.array_push('<p class="privacy-policy-tutorial">' +
			(rt.call_function('__', [rt.new_string('In this section you should explain what rights your users have over their data and how they can invoke those rights.')])).str() +
			'</p>')
	} else {
		var_strings.array_push('<p>' + var_suggested_text.str() +
			(rt.call_function('__', [rt.new_string('If you have an account on this site, or have left comments, you can request to receive an exported file of the personal data we hold about you, including any data you have provided to us. You can also request that we erase any personal data we hold about you. This does not include any data we are obliged to keep for administrative, legal, or security purposes.')])).str() +
			'</p>')
	}
	var_strings.array_push('<h2 class="wp-block-heading">' +
		(rt.call_function('__', [rt.new_string('Where your data is sent')])).str() + '</h2>')
	if var_description {
		var_strings.array_push('<p class="privacy-policy-tutorial">' +
			(rt.call_function('__', [rt.new_string('In this section you should list all transfers of your site data outside the European Union and describe the means by which that data is safeguarded to European data protection standards. This could include your web hosting, cloud storage, or other third party services.')])).str() +
			'</p>')
		var_strings.array_push('<p class="privacy-policy-tutorial">' +
			(rt.call_function('__', [rt.new_string('European data protection law requires data about European residents which is transferred outside the European Union to be safeguarded to the same standards as if the data was in Europe. So in addition to listing where data goes, you should describe how you ensure that these standards are met either by yourself or by your third party providers, whether that is through an agreement such as Privacy Shield, model clauses in your contracts, or binding corporate rules.')])).str() +
			'</p>')
	} else {
		var_strings.array_push('<p>' + var_suggested_text.str() +
			(rt.call_function('__', [rt.new_string('Visitor comments may be checked through an automated spam detection service.')])).str() +
			'</p>')
	}
	if var_description {
		var_strings.array_push('<h2>' +
			(rt.call_function('__', [rt.new_string('Contact information')])).str() + '</h2>')
		var_strings.array_push('<p class="privacy-policy-tutorial">' +
			(rt.call_function('__', [rt.new_string('In this section you should provide a contact method for privacy-specific concerns. If you are required to have a Data Protection Officer, list their name and full contact details here as well.')])).str() +
			'</p>')
	}
	if var_description {
		var_strings.array_push('<h2>' +
			(rt.call_function('__', [rt.new_string('Additional information')])).str() + '</h2>')
		var_strings.array_push('<p class="privacy-policy-tutorial">' +
			(rt.call_function('__', [rt.new_string('If you use your site for commercial purposes and you engage in more complex collection or processing of personal data, you should note the following information in your privacy policy in addition to the information we have already discussed.')])).str() +
			'</p>')
	}
	if var_description {
		var_strings.array_push('<h2>' +
			(rt.call_function('__', [rt.new_string('How we protect your data')])).str() + '</h2>')
		var_strings.array_push('<p class="privacy-policy-tutorial">' +
			(rt.call_function('__', [rt.new_string('In this section you should explain what measures you have taken to protect your users&#8217; data. This could include technical measures such as encryption; security measures such as two factor authentication; and measures such as staff training in data protection. If you have carried out a Privacy Impact Assessment, you can mention it here too.')])).str() +
			'</p>')
	}
	if var_description {
		var_strings.array_push('<h2>' +
			(rt.call_function('__', [rt.new_string('What data breach procedures we have in place')])).str() +
			'</h2>')
		var_strings.array_push('<p class="privacy-policy-tutorial">' +
			(rt.call_function('__', [rt.new_string('In this section you should explain what procedures you have in place to deal with data breaches, either potential or real, such as internal reporting systems, contact mechanisms, or bug bounties.')])).str() +
			'</p>')
	}
	if var_description {
		var_strings.array_push('<h2>' +
			(rt.call_function('__', [rt.new_string('What third parties we receive data from')])).str() +
			'</h2>')
		var_strings.array_push('<p class="privacy-policy-tutorial">' +
			(rt.call_function('__', [rt.new_string('If your website receives data about users from third parties, including advertisers, this information must be included within the section of your privacy policy dealing with third party data.')])).str() +
			'</p>')
	}
	if var_description {
		var_strings.array_push('<h2>' +
			(rt.call_function('__', [rt.new_string('What automated decision making and/or profiling we do with user data')])).str() +
			'</h2>')
		var_strings.array_push('<p class="privacy-policy-tutorial">' +
			(rt.call_function('__', [rt.new_string('If your website provides a service which includes automated decision making - for example, allowing customers to apply for credit, or aggregating their data into an advertising profile - you must note that this is taking place, and include information about how that information is used, what decisions are made with that aggregated data, and what rights users have over decisions made without human intervention.')])).str() +
			'</p>')
	}
	if var_description {
		var_strings.array_push('<h2>' +
			(rt.call_function('__', [rt.new_string('Industry regulatory disclosure requirements')])).str() +
			'</h2>')
		var_strings.array_push('<p class="privacy-policy-tutorial">' +
			(rt.call_function('__', [rt.new_string('If you are a member of a regulated industry, or if you are subject to additional privacy laws, you may be required to disclose that information here.')])).str() +
			'</p>')
		var_strings.array_push('</div>')
	}
	if var_blocks {
		mut iter_8 := var_strings.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_string := item_8.val
			mut var_key := item_8.key
			if rt.is_true(rt.call_function('str_starts_with', [
				var_string.clone(), rt.new_string('<p>')]))
			{
				var_strings.array_set(var_key, '<!-- wp:paragraph -->\n' + var_string.str() +
					'\n<!-- /wp:paragraph -->\n')
			}
			if rt.is_true(rt.call_function('str_starts_with', [
				var_string.clone(), rt.new_string('<h2 ')]))
			{
				var_strings.array_set(var_key, '<!-- wp:heading -->\n' + var_string.str() +
					'\n<!-- /wp:heading -->\n')
			}
		}
	}
	var_content = rt.call_function('implode', [rt.new_string(''),
		var_strings.clone()])
	return rt.call_function('apply_filters_deprecated', [
		rt.new_string('wp_get_default_privacy_policy_content'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_content },
			rt.ArrayItem{ key: none, val: var_strings }, rt.ArrayItem{ key: none, val: description },
			rt.ArrayItem{ key: none, val: blocks }]),
		rt.new_string('5.7.0'),
		rt.new_string('wp_add_privacy_policy_content()'),
	])
}

fn Class_WP_Privacy_Policy_Content.add_suggested_content() {
	mut var_content := Class_WP_Privacy_Policy_Content.get_default_content(false, false)
	rt.call_function('wp_add_privacy_policy_content', [
		rt.call_function('__', [rt.new_string('WordPress')]),
		var_content.clone(),
	])
}

fn create_wp_privacy_policy_content() &Class_WP_Privacy_Policy_Content {
	mut obj := &Class_WP_Privacy_Policy_Content{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn (mut this Class_WP_Privacy_Policy_Content) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'add' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WP_Privacy_Policy_Content.add(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'text_change_check' {
			return rt.new_bool(Class_WP_Privacy_Policy_Content.text_change_check())
		}
		'policy_text_changed_notice' {
			Class_WP_Privacy_Policy_Content.policy_text_changed_notice()
			return rt.new_null()
		}
		'_policy_page_updated' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WP_Privacy_Policy_Content._policy_page_updated(dispatch_arg_0)
			return rt.new_null()
		}
		'get_suggested_policy_text' {
			return Class_WP_Privacy_Policy_Content.get_suggested_policy_text()
		}
		'notice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WP_Privacy_Policy_Content.notice(dispatch_arg_0)
			return rt.new_null()
		}
		'privacy_policy_guide' {
			Class_WP_Privacy_Policy_Content.privacy_policy_guide()
			return rt.new_null()
		}
		'get_default_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_WP_Privacy_Policy_Content.get_default_content(dispatch_arg_0,
				dispatch_arg_1)
		}
		'add_suggested_content' {
			Class_WP_Privacy_Policy_Content.add_suggested_content()
			return rt.new_null()
		}
		else {
			return none
		}
	}
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
}
