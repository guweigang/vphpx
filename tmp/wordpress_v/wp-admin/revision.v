import rt


fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/revision.php', '3')
	mut var_revision_id := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('revision'))) { rt.call_function('absint', [rt.get_superglobal('_REQUEST').array_get('revision')]) } else { rt.new_int(0) }
	mut var_action := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('action'))) { rt.call_function('sanitize_text_field', [rt.get_superglobal('_REQUEST').array_get('action')]) } else { rt.new_string('') }
	mut var_from := if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('from'))) && rt.is_true(rt.new_bool(rt.get_superglobal('_REQUEST').array_get('from').is_long() || rt.get_superglobal('_REQUEST').array_get('from').is_double())))) { rt.call_function('absint', [rt.get_superglobal('_REQUEST').array_get('from')]) } else { rt.new_null() }
	mut var_to := if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('to'))) && rt.is_true(rt.new_bool(rt.get_superglobal('_REQUEST').array_get('to').is_long() || rt.get_superglobal('_REQUEST').array_get('to').is_double())))) { rt.call_function('absint', [rt.get_superglobal('_REQUEST').array_get('to')]) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_revision_id)))) {
		var_revision_id = var_to.dup()
	}
	mut var_redirect := rt.new_string(rt.new_string('edit.php'))
	mut switch_val_1 := var_action
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('restore'))) {
		mut var_revision := rt.call_function('wp_get_post_revision', [var_revision_id.dup()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_revision)))) {
			break
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.get_property(var_revision, 'post_parent')]))))) {
			break
		}
		mut var_post := rt.call_function('get_post', [rt.get_property(var_revision, 'post_parent')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
			break
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_revisions_enabled', [var_post.dup()]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_post_autosave', [var_revision.dup()]))))))) {
			var_redirect = rt.new_string('edit.php?post_type=' + (rt.get_property(var_post, 'post_type')).str())
			break
		}
		if rt.is_true(rt.call_function('wp_check_post_lock', [rt.get_property(var_post, 'ID')])) {
			break
		}
		rt.call_function('check_admin_referer', [rt.concat(rt.new_string('restore-post_'), rt.get_property(var_revision, 'ID'))])
		mut var_backup_global_post := // unsupported expression: Expr_Clone
		rt.call_function('wp_restore_post_revision', [rt.get_property(var_revision, 'ID')])
		var_post = var_backup_global_post.dup()
		var_redirect = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'message', val: 5 }, rt.ArrayItem{ key: 'revision', val: rt.get_property(var_revision, 'ID') }]), rt.call_function('get_edit_post_link', [rt.get_property(var_post, 'ID'), rt.new_string('url')])])
	} else {
		var_revision = rt.call_function('wp_get_post_revision', [var_revision_id.dup()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_revision)))) {
			break
		}
		var_post = rt.call_function('get_post', [rt.get_property(var_revision, 'post_parent')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
			break
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('read_post'), rt.get_property(var_revision, 'ID')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.get_property(var_revision, 'post_parent')]))))))) {
			break
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_revisions_enabled', [var_post.dup()]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_post_autosave', [var_revision.dup()]))))))) {
			var_redirect = rt.new_string('edit.php?post_type=' + (rt.get_property(var_post, 'post_type')).str())
			break
		}
		mut var_post_edit_link := rt.call_function('get_edit_post_link', []rt.PhpVal{})
		mut var_post_title := rt.new_string('<a href="' + (rt.call_function('esc_url', [var_post_edit_link.dup()])).str() + '">' + (rt.call_function('_draft_or_post_title', []rt.PhpVal{})).str() + '</a>')
		mut var_h1 := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Compare Revisions of &#8220;%s&#8221;')]), var_post_title.dup()])
		mut var_return_to_post := rt.new_string('<a href="' + (rt.call_function('esc_url', [var_post_edit_link.dup()])).str() + '">' + (rt.call_function('__', [rt.new_string('&larr; Go to editor')])).str() + '</a>')
		mut var_title := rt.call_function('__', [rt.new_string('Revisions')])
		var_redirect = rt.new_bool(rt.new_bool(false))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_redirect)))) && !rt.is_true(rt.get_property(var_post, 'post_type')))) {
		var_redirect = rt.new_string(rt.new_string('edit.php'))
	}
	if !(!rt.is_true(var_redirect)) {
		rt.call_function('wp_redirect', [var_redirect.dup()])
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_property(var_post, 'post_type'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		mut var_parent_file := rt.new_string('edit.php?post_type=' + (rt.get_property(var_post, 'post_type')).str())
	} else {
		var_parent_file = rt.new_string(rt.new_string('edit.php'))
	}
	mut var_submenu_file := var_parent_file.dup()
	rt.call_function('wp_enqueue_script', [rt.new_string('revisions')])
	rt.call_function('wp_localize_script', [rt.new_string('revisions'), rt.new_string('_wpRevisionsSettings'), rt.call_function('wp_prepare_revisions_for_js', [var_post.dup(), var_revision_id.dup(), var_from.dup()])])
	mut var_revisions_overview := rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('This screen is used for managing your content revisions.')])).str() + '</p>')
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'revisions-overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview')]) }, rt.ArrayItem{ key: 'content', val: var_revisions_overview }])])
	mut var_revisions_sidebar := rt.new_string('<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>')
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [var_revisions_sidebar.dup()])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_h1)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_return_to_post)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_print_revision_templates', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
