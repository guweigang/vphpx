import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/revision.php', '3')
	mut var_revision_id := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('revision')))) { rt.call_function('absint', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('revision')),
		]) } else { rt.new_int(0) }
	mut var_action := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('action')))) { rt.call_function('sanitize_text_field', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('action')),
		]) } else { rt.new_string('') }
	mut var_from := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('from')))) && rt.get_superglobal('_REQUEST').array_get(rt.new_string('from')).is_long() || rt.get_superglobal('_REQUEST').array_get(rt.new_string('from')).is_double() { rt.call_function('absint', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('from')),
		]) } else { rt.new_null() }
	mut var_to := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('to')))) && rt.get_superglobal('_REQUEST').array_get(rt.new_string('to')).is_long() || rt.get_superglobal('_REQUEST').array_get(rt.new_string('to')).is_double() { rt.call_function('absint', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('to')),
		]) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_revision_id)))) {
		var_revision_id = var_to.clone()
	}
	mut var_redirect := rt.new_string('edit.php')
	mut switch_val_1 := var_action
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('restore'))) {
		mut var_revision := rt.call_function('wp_get_post_revision', [
			var_revision_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_revision)))) {
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_post'),
			rt.get_property(var_revision, 'post_parent'),
		])))))
		{
		}
		mut var_post := rt.call_function('get_post', [
			rt.get_property(var_revision, 'post_parent'),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_revisions_enabled', [var_post.clone()])))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_post_autosave', [var_revision.clone()]))))) {
			var_redirect = rt.new_string('edit.php?post_type=' +
				(rt.get_property(var_post, 'post_type')).str())
		}
		if rt.is_true(rt.call_function('wp_check_post_lock', [
			rt.get_property(var_post, 'ID'),
		]))
		{
		}
		rt.call_function('check_admin_referer', [
			rt.concat(rt.new_string('restore-post_'), rt.get_property(var_revision, 'ID')),
		])
		mut var_backup_global_post := var_post.dup()
		rt.call_function('wp_restore_post_revision', [
			rt.get_property(var_revision, 'ID'),
		])
		var_post = var_backup_global_post.clone()
		var_redirect = rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'message', val: 5 },
				rt.ArrayItem{ key: 'revision', val: rt.get_property(var_revision, 'ID') }]),
			rt.call_function('get_edit_post_link', [rt.get_property(var_post, 'ID'),
				rt.new_string('url')]),
		])
	} else {
		var_revision = rt.call_function('wp_get_post_revision', [
			var_revision_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_revision)))) {
		}
		var_post = rt.call_function('get_post', [
			rt.get_property(var_revision, 'post_parent'),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('read_post'), rt.get_property(var_revision, 'ID')])))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.get_property(var_revision, 'post_parent')]))))) {
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_revisions_enabled', [var_post.clone()])))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_post_autosave', [var_revision.clone()]))))) {
			var_redirect = rt.new_string('edit.php?post_type=' +
				(rt.get_property(var_post, 'post_type')).str())
		}
		mut var_post_edit_link := rt.call_function('get_edit_post_link', []rt.PhpVal{})
		mut var_post_title := rt.new_string('<a href="' +
			(rt.call_function('esc_url', [var_post_edit_link.clone()])).str() + '">' +
			(rt.call_function('_draft_or_post_title', []rt.PhpVal{})).str() + '</a>')
		mut var_h1 := rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Compare Revisions of &#8220;%s&#8221;'),
			]),
			var_post_title.clone(),
		])
		mut var_return_to_post := rt.new_string('<a href="' +
			(rt.call_function('esc_url', [var_post_edit_link.clone()])).str() + '">' +
			(rt.call_function('__', [rt.new_string('&larr; Go to editor')])).str() + '</a>')
		mut var_title := rt.call_function('__', [rt.new_string('Revisions')])
		var_redirect = rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_redirect))))
		&& !rt.is_true(rt.get_property(var_post, 'post_type')) {
		var_redirect = rt.new_string('edit.php')
	}
	if !(!rt.is_true(var_redirect)) {
		rt.call_function('wp_redirect', [var_redirect.clone()])
		exit(0)
	}
	if !(!rt.is_true(rt.get_property(var_post, 'post_type')))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('post'), rt.get_property(var_post, 'post_type'))))) {
		mut var_parent_file := rt.new_string('edit.php?post_type=' +
			(rt.get_property(var_post, 'post_type')).str())
	} else {
		var_parent_file = rt.new_string('edit.php')
	}
	mut var_submenu_file := var_parent_file.clone()
	rt.call_function('wp_enqueue_script', [rt.new_string('revisions')])
	rt.call_function('wp_localize_script', [rt.new_string('revisions'),
		rt.new_string('_wpRevisionsSettings'),
		rt.call_function('wp_prepare_revisions_for_js', [
			var_post.clone(),
			var_revision_id.clone(),
			var_from.clone(),
		])])
	mut var_revisions_overview := rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('This screen is used for managing your content revisions.')])).str() +
		'</p>')
	var_revisions_overview = rt.concat(var_revisions_overview, rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('Revisions are saved copies of your post or page, which are periodically created as you update your content. The red text on the left shows the content that was removed. The green text on the right shows the content that was added.')])).str() +
		'</p>'))
	var_revisions_overview = rt.concat(var_revisions_overview, rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('From this screen you can review, compare, and restore revisions:')])).str() +
		'</p>'))
	var_revisions_overview = rt.concat(var_revisions_overview, rt.new_string('<ul><li>' +
		(rt.call_function('__', [rt.new_string('To navigate between revisions, <strong>drag the slider handle left or right</strong> or <strong>use the Previous or Next buttons</strong>.')])).str() +
		'</li>'))
	var_revisions_overview = rt.concat(var_revisions_overview, rt.new_string('<li>' +
		(rt.call_function('__', [rt.new_string('Compare two different revisions by <strong>selecting the &#8220;Compare any two revisions&#8221; box</strong> to the side.')])).str() +
		'</li>'))
	var_revisions_overview = rt.concat(var_revisions_overview, rt.new_string('<li>' +
		(rt.call_function('__', [rt.new_string('To restore a revision, <strong>click Restore This Revision</strong>.')])).str() +
		'</li></ul>'))
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'revisions-overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: var_revisions_overview }]),
	])
	mut var_revisions_sidebar := rt.new_string('<p><strong>' +
		(rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>')
	var_revisions_sidebar = rt.concat(var_revisions_sidebar, rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/revisions/">Revisions Management</a>')])).str() +
		'</p>'))
	var_revisions_sidebar = rt.concat(var_revisions_sidebar, rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
		'</p>'))
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		var_revisions_sidebar.clone(),
	])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_h1)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_return_to_post)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_print_revision_templates', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
