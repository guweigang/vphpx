import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_user_email := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
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
	mut var_title := rt.call_function('__', [rt.new_string('Discussion Settings')])
	mut var_parent_file := 'options-general.php'
	rt.call_function('add_action', [rt.new_string('admin_print_footer_scripts'),
		rt.new_string('options_discussion_add_js')])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('This screen provides many options for controlling the management and display of comments and links to your posts/pages. So many, in fact, they will not all fit here! :) Use the documentation links to get information on what each discussion setting does.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('You must click the Save Changes button at the bottom of the screen for new settings to take effect.')])).str() +
				'</p>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/settings-discussion-screen/">Documentation on Discussion Settings</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>'),
	])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('settings_fields', [rt.new_string('discussion')])
	// unsupported statement: Stmt_InlineHTML
	mut var_default_post_settings_title := rt.call_function('__', [
		rt.new_string('Default post settings'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_default_post_settings_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_default_post_settings_title)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string('1'),
		rt.call_function('get_option', [rt.new_string('default_pingback_flag')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Attempt to notify any blogs linked to from the post'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string('open'),
		rt.call_function('get_option', [rt.new_string('default_ping_status')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Allow link notifications from other blogs (pingbacks and trackbacks) on new posts'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string('open'),
		rt.call_function('get_option', [rt.new_string('default_comment_status')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Allow people to submit comments on new posts'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Individual posts may override these settings. Changes here will only be applied to new posts.'),
	])
	// unsupported statement: Stmt_InlineHTML
	mut var_other_comment_settings_title := rt.call_function('__', [
		rt.new_string('Other comment settings'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_other_comment_settings_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_other_comment_settings_title)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string('1'),
		rt.call_function('get_option', [rt.new_string('require_name_email')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Comment author must fill out name and email')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string('1'),
		rt.call_function('get_option', [rt.new_string('comment_registration')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Users must be registered and logged in to comment'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [rt.new_string('users_can_register')])))))
		&& rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		print(' ' +(rt.call_function('__', [rt.new_string('(Signup has been disabled. Only members of this site can comment.)')])).str())
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string('1'),
		rt.call_function('get_option', [rt.new_string('close_comments_for_old_posts')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Automatically close comments on old posts')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Close comments when post is how many days old'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('get_option', [rt.new_string('close_comments_days_old')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string('1'),
		rt.call_function('get_option', [rt.new_string('show_comments_cookies_opt_in')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Show comments cookies opt-in checkbox, allowing comment author cookies to be set'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string('1'),
		rt.call_function('get_option', [rt.new_string('thread_comments')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Enable threaded (nested) comments')])
	// unsupported statement: Stmt_InlineHTML
	mut var_maxdeep := rt.new_int((rt.call_function('apply_filters', [
		rt.new_string('thread_comments_depth_max'),
		rt.new_int(10),
	])).to_i64())
	mut var_thread_comments_depth := '<select name="thread_comments_depth" id="thread_comments_depth">'
	mut var_i := 2
	for {
		if !(rt.is_true(rt.less_equal(rt.new_int(var_i), var_maxdeep))) { break
		 }
		var_thread_comments_depth = var_thread_comments_depth + "<option value='" +
			(rt.call_function('esc_attr', [rt.new_int(var_i).clone()])).str() + "'"
		if rt.new_int((rt.call_function('get_option', [
			rt.new_string('thread_comments_depth'),
		])).to_i64()) == var_i {
			var_thread_comments_depth = var_thread_comments_depth + " selected='selected'"
		}
		var_thread_comments_depth = var_thread_comments_depth + '>${var_i.str()}</option>'
		var_i += 1
	}
	var_thread_comments_depth = var_thread_comments_depth + '</select>'
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Number of levels for threaded (nested) comments'),
	])
	// unsupported statement: Stmt_InlineHTML
	print(var_thread_comments_depth)
	// unsupported statement: Stmt_InlineHTML
	mut var_comment_pagination_title := rt.call_function('__', [
		rt.new_string('Comment Pagination'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_comment_pagination_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_comment_pagination_title)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string('1'),
		rt.call_function('get_option', [rt.new_string('page_comments')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Break comments into pages')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Top level comments per page')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('get_option', [rt.new_string('comments_per_page')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Comments page to display by default')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [rt.new_string('newest'),
		rt.call_function('get_option', [rt.new_string('default_comments_page')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('last page')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [rt.new_string('oldest'),
		rt.call_function('get_option', [rt.new_string('default_comments_page')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('first page')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Comments to display at the top of each page')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [rt.new_string('asc'),
		rt.call_function('get_option', [rt.new_string('comment_order')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('older')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [rt.new_string('desc'),
		rt.call_function('get_option', [rt.new_string('comment_order')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('newer')])
	// unsupported statement: Stmt_InlineHTML
	mut var_email_me_whenever_title := rt.call_function('__', [
		rt.new_string('Email me whenever'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_email_me_whenever_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_email_me_whenever_title)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string('1'),
		rt.call_function('get_option', [rt.new_string('comments_notify')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Anyone posts a comment')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string('1'),
		rt.call_function('get_option', [rt.new_string('moderation_notify')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('A comment is held for moderation')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string('1'),
		rt.call_function('get_option', [rt.new_string('wp_notes_notify'),
			rt.new_int(1)])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Anyone posts a note')])
	// unsupported statement: Stmt_InlineHTML
	mut var_before_comment_appears_title := rt.call_function('__', [
		rt.new_string('Before a comment appears'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_before_comment_appears_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_before_comment_appears_title)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string('1'),
		rt.call_function('get_option', [rt.new_string('comment_moderation')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Comment must be manually approved')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string('1'),
		rt.call_function('get_option', [rt.new_string('comment_previously_approved')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Comment author must have a previously approved comment'),
	])
	// unsupported statement: Stmt_InlineHTML
	mut var_comment_moderation_title := rt.call_function('__', [
		rt.new_string('Comment Moderation'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_comment_moderation_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_comment_moderation_title)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('Hold a comment in the queue if it contains %s or more links. (A common characteristic of comment spam is a large number of hyperlinks.)'),
		]),
		rt.new_string(
			'<input name="comment_max_links" type="number" step="1" min="0" id="comment_max_links" value="' +
			(rt.call_function('esc_attr', [rt.call_function('get_option', [rt.new_string('comment_max_links')])])).str() +
			'" class="small-text" />'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('When a comment contains any of these words in its content, author name, URL, email, IP address, or browser&#8217;s user agent string, it will be held in the <a href="edit-comments.php?comment_status=moderated">moderation queue</a>. One word or IP address per line. It will match inside words, so &#8220;press&#8221; will match &#8220;WordPress&#8221;.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_textarea', [
		rt.call_function('get_option', [rt.new_string('moderation_keys')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	mut var_disallowed_comment_keys_title := rt.call_function('__', [
		rt.new_string('Disallowed Comment Keys'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_disallowed_comment_keys_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_disallowed_comment_keys_title)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('When a comment contains any of these words in its content, author name, URL, email, IP address, or browser&#8217;s user agent string, it will be put in the Trash. One word or IP address per line. It will match inside words, so &#8220;press&#8221; will match &#8220;WordPress&#8221;.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_textarea', [
		rt.call_function('get_option', [rt.new_string('disallowed_keys')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_settings_fields', [rt.new_string('discussion'),
		rt.new_string('default')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Avatars')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('An avatar is an image that can be associated with a user across multiple websites. In this area, you can choose to display avatars of users who interact with the site.'),
	])
	// unsupported statement: Stmt_InlineHTML
	mut var_show_avatars := rt.call_function('get_option', [
		rt.new_string('show_avatars'),
	])
	mut var_show_avatars_class := ''
	if rt.is_true(rt.new_bool(!(rt.is_true(var_show_avatars)))) {
		var_show_avatars_class = ' hide-if-js'
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Avatar Display')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [var_show_avatars.clone(), rt.new_int(1)])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Show Avatars')])
	// unsupported statement: Stmt_InlineHTML
	mut var_maximum_rating_title := rt.call_function('__', [
		rt.new_string('Maximum Rating'),
	])
	// unsupported statement: Stmt_InlineHTML
	print(var_show_avatars_class)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_maximum_rating_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_maximum_rating_title)
	// unsupported statement: Stmt_InlineHTML
	mut var_ratings := {
		'G':  rt.call_function('__', [
			rt.new_string('G &#8212; Suitable for all audiences'),
		])
		'PG': rt.call_function('__', [
			rt.new_string('PG &#8212; Possibly offensive, usually for audiences 13 and above'),
		])
		'R':  rt.call_function('__', [
			rt.new_string('R &#8212; Intended for adult audiences above 17'),
		])
		'X':  rt.call_function('__', [
			rt.new_string('X &#8212; Even more mature than above'),
		])
	}
	for var_key, var_rating in var_ratings {
		mut var_selected := if rt.is_true(rt.identical(rt.call_function('get_option', [
			rt.new_string('avatar_rating'),
		]), rt.new_string(key)))
		{ 'checked="checked"' } else { '' }
		print("\n\t<label><input type='radio' name='avatar_rating' value='" +
			(rt.call_function('esc_attr', [rt.new_string(key)])).str() +
			"' ${var_selected}/> ${var_rating.to_string()}</label><br />")
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_default_avatar_title := rt.call_function('__', [
		rt.new_string('Default Avatar'),
	])
	// unsupported statement: Stmt_InlineHTML
	print(var_show_avatars_class)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_default_avatar_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_default_avatar_title)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('For users without a custom avatar of their own, you can either display a generic logo or a generated one based on their email address.'),
	])
	// unsupported statement: Stmt_InlineHTML
	mut var_avatar_defaults := rt.create_array([
		rt.ArrayItem{ key: 'mystery', val: rt.call_function('__', [
			rt.new_string('Mystery Person'),
		]) },
		rt.ArrayItem{ key: 'blank', val: rt.call_function('__', [
			rt.new_string('Blank'),
		]) },
		rt.ArrayItem{ key: 'gravatar_default', val: rt.call_function('__', [
			rt.new_string('Gravatar Logo'),
		]) },
		rt.ArrayItem{ key: 'identicon', val: rt.call_function('__', [
			rt.new_string('Identicon (Generated)'),
		]) },
		rt.ArrayItem{ key: 'wavatar', val: rt.call_function('__', [
			rt.new_string('Wavatar (Generated)'),
		]) },
		rt.ArrayItem{ key: 'monsterid', val: rt.call_function('__', [
			rt.new_string('MonsterID (Generated)'),
		]) },
		rt.ArrayItem{ key: 'retro', val: rt.call_function('__', [
			rt.new_string('Retro (Generated)'),
		]) },
		rt.ArrayItem{ key: 'robohash', val: rt.call_function('__', [
			rt.new_string('RoboHash (Generated)'),
		]) },
		rt.ArrayItem{ key: 'initials', val: rt.call_function('__', [
			rt.new_string('Initials (Generated)'),
		]) },
		rt.ArrayItem{ key: 'color', val: rt.call_function('__', [
			rt.new_string('Color (Generated)'),
		]) },
	])
	var_avatar_defaults = rt.call_function('apply_filters', [
		rt.new_string('avatar_defaults'),
		var_avatar_defaults.clone(),
	])
	mut var_default := rt.call_function('get_option', [rt.new_string('avatar_default'),
		rt.new_string('mystery')])
	mut var_avatar_list := ''
	rt.call_function('add_filter', [rt.new_string('pre_option_show_avatars'),
		rt.new_string('__return_true'), rt.new_int(100)])
	mut iter_1 := var_avatar_defaults.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_default_name := item_1.val
		mut var_default_key := item_1.key
		mut var_selected := if rt.is_true(rt.identical(var_default, var_default_key)) {
			'checked="checked" '
		} else {
			''
		}
		var_avatar_list = var_avatar_list +
			"\n\t<label><input type='radio' name='avatar_default' id='avatar_${var_default_key.to_string()}' value='" +
			(rt.call_function('esc_attr', [var_default_key.clone()])).str() + "' ${var_selected}/> "
		var_avatar_list = var_avatar_list +(rt.call_function('get_avatar', [var_user_email.clone(), rt.new_int(32), var_default_key.clone(), rt.new_string(''), rt.create_array([rt.ArrayItem{
			key: 'force_default'
			val: true
		}])])).str()
		var_avatar_list = var_avatar_list + ' ' + var_default_name.str() + '</label>'
		var_avatar_list = var_avatar_list + '<br />'
	}
	rt.call_function('remove_filter', [rt.new_string('pre_option_show_avatars'),
		rt.new_string('__return_true'), rt.new_int(100)])
	rt.echo_val(rt.call_function('apply_filters', [
		rt.new_string('default_avatar_select'),
		rt.new_string(var_avatar_list.str()).clone(),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_settings_fields', [rt.new_string('discussion'),
		rt.new_string('avatars')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_settings_sections', [rt.new_string('discussion')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
