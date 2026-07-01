import rt


fn main() {
	defer {
		rt.shutdown()
	}

	mut var_user_email := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_options')]))))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to manage options for this site.')])])
	}
	mut var_title := rt.call_function('__', [rt.new_string('Discussion Settings')])
	mut var_parent_file := 'options-general.php'
	rt.call_function('add_action', [rt.new_string('admin_print_footer_scripts'), rt.new_string('options_discussion_add_js')])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview')]) }, rt.ArrayItem{ key: 'content', val: '<p>' + (rt.call_function('__', [rt.new_string('This screen provides many options for controlling the management and display of comments and links to your posts/pages. So many, in fact, they will not all fit here! :) Use the documentation links to get information on what each discussion setting does.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('You must click the Save Changes button at the bottom of the screen for new settings to take effect.')])).str() + '</p>' }])])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', ['<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/settings-discussion-screen/">Documentation on Discussion Settings</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() + '</p>'])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('settings_fields', [rt.new_string('discussion')])
	// unsupported statement: Stmt_InlineHTML
	mut var_default_post_settings_title := rt.call_function('__', [rt.new_string('Default post settings')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_default_post_settings_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_default_post_settings_title)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string('1'), rt.call_function('get_option', [rt.new_string('default_pingback_flag')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Attempt to notify any blogs linked to from the post')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string('open'), rt.call_function('get_option', [rt.new_string('default_ping_status')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Allow link notifications from other blogs (pingbacks and trackbacks) on new posts')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string('open'), rt.call_function('get_option', [rt.new_string('default_comment_status')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Allow people to submit comments on new posts')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Individual posts may override these settings. Changes here will only be applied to new posts.')])
	// unsupported statement: Stmt_InlineHTML
	mut var_other_comment_settings_title := rt.call_function('__', [rt.new_string('Other comment settings')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_other_comment_settings_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_other_comment_settings_title)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string('1'), rt.call_function('get_option', [rt.new_string('require_name_email')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Comment author must fill out name and email')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string('1'), rt.call_function('get_option', [rt.new_string('comment_registration')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Users must be registered and logged in to comment')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [rt.new_string('users_can_register')]))))) && rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))) {
		print(' ' + (rt.call_function('__', [rt.new_string('(Signup has been disabled. Only members of this site can comment.)')])).str())
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string('1'), rt.call_function('get_option', [rt.new_string('close_comments_for_old_posts')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Automatically close comments on old posts')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Close comments when post is how many days old')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('get_option', [rt.new_string('close_comments_days_old')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string('1'), rt.call_function('get_option', [rt.new_string('show_comments_cookies_opt_in')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Show comments cookies opt-in checkbox, allowing comment author cookies to be set')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string('1'), rt.call_function('get_option', [rt.new_string('thread_comments')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Enable threaded (nested) comments')])
	// unsupported statement: Stmt_InlineHTML
	mut var_maxdeep := // unsupported expression: Expr_Cast_Int
	mut var_thread_comments_depth := '<select name="thread_comments_depth" id="thread_comments_depth">'
	{
		mut var_i := 2
		for {
			if !(rt.is_true(rt.less_equal(rt.new_int(var_i), var_maxdeep))) { break }
			// unsupported expression: Expr_AssignOp_Concat
			if rt.is_true(rt.identical(// unsupported expression: Expr_Cast_Int, rt.new_int(var_i))) {
				// unsupported expression: Expr_AssignOp_Concat
			}
			// unsupported expression: Expr_AssignOp_Concat
			var_i += 1
		}
	}
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Number of levels for threaded (nested) comments')])
	// unsupported statement: Stmt_InlineHTML
	print(var_thread_comments_depth)
	// unsupported statement: Stmt_InlineHTML
	mut var_comment_pagination_title := rt.call_function('__', [rt.new_string('Comment Pagination')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_comment_pagination_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_comment_pagination_title)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string('1'), rt.call_function('get_option', [rt.new_string('page_comments')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Break comments into pages')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Top level comments per page')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('get_option', [rt.new_string('comments_per_page')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Comments page to display by default')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [rt.new_string('newest'), rt.call_function('get_option', [rt.new_string('default_comments_page')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('last page')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [rt.new_string('oldest'), rt.call_function('get_option', [rt.new_string('default_comments_page')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [])
	// unsupported statement: Stmt_InlineHTML
}
