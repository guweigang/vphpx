import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	mut var_parent_file := 'edit-comments.php'
	mut var_submenu_file := 'edit-comments.php'
	mut var_action := rt.get_superglobal('action')
	var_action = if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('action')))) { rt.call_function('sanitize_text_field', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('action')),
		]) } else { rt.new_string('') }
	if rt.get_superglobal('_POST').array_isset(rt.new_string('deletecomment')) {
		var_action = rt.new_string('deletecomment')
	}
	if rt.is_true(rt.identical(rt.new_string('cdc'), var_action)) {
		var_action = rt.new_string('delete')
	} else if rt.is_true(rt.identical(rt.new_string('mac'), var_action)) {
		var_action = rt.new_string('approve')
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('dt')) {
		if rt.is_true(rt.identical(rt.new_string('spam'),
			rt.get_superglobal('_GET').array_get(rt.new_string('dt'))))
		{
			var_action = rt.new_string('spam')
		} else if rt.is_true(rt.identical(rt.new_string('trash'),
			rt.get_superglobal('_GET').array_get(rt.new_string('dt'))))
		{
			var_action = rt.new_string('trash')
		}
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('c')) {
		mut var_comment_id := rt.call_function('absint', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('c')),
		])
		mut var_comment := rt.call_function('get_comment', [var_comment_id.clone()])
		if rt.is_true(var_comment)
			&& rt.is_true(rt.identical(rt.new_string('trash'), rt.call_function('get_post_status', [rt.get_property(var_comment, 'comment_post_ID')]))) {
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('You cannot edit this comment because the associated post is in the Trash. Please restore the post first, then try again.'),
				]),
			])
		}
	} else {
		var_comment_id = rt.new_int(0)
		var_comment = rt.new_null()
	}
	mut switch_val_1 := var_action
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('editcomment'))) {
		mut var_title := rt.call_function('__', [rt.new_string('Edit Comment')])
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Overview'),
				]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
					(rt.call_function('__', [rt.new_string('You can edit the information left in a comment if needed. This is often useful when you notice that a commenter has made a typographical error.')])).str() +
					'</p>' + '<p>' +
					(rt.call_function('__', [rt.new_string('You can also moderate the comment from this screen using the Status box, where you can also change the timestamp of the comment.')])).str() +
					'</p>' }]),
		])
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
			rt.new_string('<p><strong>' +
				(rt.call_function('__', [rt.new_string('For more information:')])).str() +
				'</strong></p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/comments-screen/">Documentation on Comments</a>')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
				'</p>'),
		])
		rt.call_function('wp_enqueue_script', [rt.new_string('comment')])
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
		if rt.is_true(rt.new_bool(!(rt.is_true(var_comment)))) {
			rt.call_function('comment_footer_die', [
				rt.new_string(
					(rt.call_function('__', [rt.new_string('Invalid comment ID.')])).str() +
					(rt.call_function('sprintf', [rt.new_string(' <a href="%s">' + (rt.call_function('__', [rt.new_string('Go back')])).str() +
					'</a>.'), rt.new_string('javascript:history.go(-1)')])).str()),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_comment'),
			var_comment_id.clone(),
		])))))
		{
			rt.call_function('comment_footer_die', [
				rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to edit this comment.'),
				]),
			])
		}
		if rt.is_true(rt.identical(rt.new_string('trash'), rt.get_property(var_comment,
			'comment_approved')))
		{
			rt.call_function('comment_footer_die', [
				rt.call_function('__', [
					rt.new_string('This comment is in the Trash. Please move it out of the Trash if you want to edit it.'),
				]),
			])
		}
		var_comment = rt.call_function('get_comment_to_edit', [
			var_comment_id.clone()])
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/edit-form-comment.php', '3')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('approve')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('trash')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('spam'))) {
		var_title = rt.call_function('__', [rt.new_string('Moderate Comment')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_comment)))) {
			rt.call_function('wp_redirect', [
				rt.call_function('admin_url', [
					rt.new_string('edit-comments.php?error=1'),
				]),
			])
			exit(0)
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_comment'),
			rt.get_property(var_comment, 'comment_ID'),
		])))))
		{
			rt.call_function('wp_redirect', [
				rt.call_function('admin_url', [
					rt.new_string('edit-comments.php?error=2'),
				]),
			])
			exit(0)
		}
		if rt.is_true(rt.identical(rt.call_function('str_replace', [
			rt.new_string('1'), rt.new_string('approve'),
			rt.get_property(var_comment,
				'comment_approved')]), var_action))
		{
			rt.call_function('wp_redirect', [
				rt.call_function('admin_url', [
					rt.new_string('edit-comments.php?same=' + var_comment_id.str()),
				]),
			])
			exit(0)
		}
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
		mut var_formaction := rt.new_string(var_action.str() + 'comment')
		mut var_nonce_action := if rt.is_true(rt.identical(rt.new_string('approve'), var_action)) {
			'approve-comment_'
		} else {
			'delete-comment_'
		}
		var_nonce_action = var_nonce_action + var_comment_id.str()
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
		// unsupported statement: Stmt_InlineHTML
		mut switch_val_2 := var_action
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('spam'))) {
			mut var_caution_msg := rt.call_function('__', [
				rt.new_string('You are about to mark the following comment as spam:'),
			])
			mut var_button := rt.call_function('_x', [rt.new_string('Mark as spam'),
				rt.new_string('comment')])
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('trash'))) {
			var_caution_msg = rt.call_function('__', [
				rt.new_string('You are about to move the following comment to the Trash:'),
			])
			var_button = rt.call_function('__', [rt.new_string('Move to Trash')])
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('delete'))) {
			var_caution_msg = rt.call_function('__', [
				rt.new_string('You are about to delete the following comment:'),
			])
			var_button = rt.call_function('__', [
				rt.new_string('Permanently delete comment'),
			])
		} else {
			var_caution_msg = rt.call_function('__', [
				rt.new_string('You are about to approve the following comment:'),
			])
			var_button = rt.call_function('__', [rt.new_string('Approve comment')])
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('0'), rt.get_property(var_comment,
			'comment_approved')))))
		{
			mut var_message := rt.new_string('')
			mut switch_val_3 := rt.get_property(var_comment, 'comment_approved')
			if rt.is_true(rt.equal(switch_val_3, rt.new_string('1'))) {
				var_message = rt.call_function('__', [
					rt.new_string('This comment is currently approved.'),
				])
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('spam'))) {
				var_message = rt.call_function('__', [
					rt.new_string('This comment is currently marked as spam.'),
				])
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('trash'))) {
				var_message = rt.call_function('__', [
					rt.new_string('This comment is currently in the Trash.'),
				])
			}
			if rt.is_true(var_message) {
				rt.call_function('wp_admin_notice', [var_message.clone(),
					rt.create_array([rt.ArrayItem{ key: 'type', val: 'info' },
						rt.ArrayItem{ key: 'id', val: 'message' }])])
			}
		}
		rt.call_function('wp_admin_notice', [
			rt.new_string('<strong>' + (rt.call_function('__', [rt.new_string('Caution:')])).str() +
				'</strong> ' + var_caution_msg.str()),
			rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'warning' },
				rt.ArrayItem{ key: 'id', val: 'message' },
			]),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Author')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('comment_author', [var_comment.clone()])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('get_comment_author_email', [
			var_comment.clone()]))
		{
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Email')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('comment_author_email', [var_comment.clone()])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('get_comment_author_url', [
			var_comment.clone()]))
		{
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('URL')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('comment_author_url', [var_comment.clone()])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('comment_author_url', [var_comment.clone()])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('In response to')])
		// unsupported statement: Stmt_InlineHTML
		mut var_post_id := rt.get_property(var_comment, 'comment_post_ID')
		if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'),
			var_post_id.clone()]))
		{
			mut var_post_link := rt.new_string("<a href='" +
				(rt.call_function('esc_url', [rt.call_function('get_edit_post_link', [var_post_id.clone()])])).str() +
				"'>")
			var_post_link = rt.concat(var_post_link, rt.new_string(
				(rt.call_function('esc_html', [rt.call_function('get_the_title', [var_post_id.clone()])])).str() +
				'</a>'))
		} else {
			var_post_link = rt.call_function('esc_html', [
				rt.call_function('get_the_title', [var_post_id.clone()]),
			])
		}
		rt.echo_val(var_post_link)
		if rt.is_true(rt.get_property(var_comment, 'comment_parent')) {
			mut var_parent := rt.call_function('get_comment', [
				rt.get_property(var_comment, 'comment_parent'),
			])
			mut var_parent_link := rt.call_function('esc_url', [
				rt.call_function('get_comment_link', [var_parent.clone()]),
			])
			mut var_name := rt.call_function('get_comment_author', [
				var_parent.clone()])
			rt.call_function('printf', [
				rt.new_string(' | ' +
					(rt.call_function('__', [rt.new_string('In reply to %s.')])).str()),
				rt.new_string('<a href="' + var_parent_link.str() + '">' + var_name.str() + '</a>'),
			])
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Submitted on')])
		// unsupported statement: Stmt_InlineHTML
		mut var_submitted := rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%1$s at %2$s')]),
			rt.call_function('get_comment_date', [rt.call_function('__', [
				rt.new_string('Y/m/d'),
			]),
				var_comment.clone()]),
			rt.call_function('get_comment_date', [rt.call_function('__', [
				rt.new_string('g:i a'),
			]),
				var_comment.clone()]),
		])
		if rt.is_true(rt.identical(rt.new_string('approved'), rt.call_function('wp_get_comment_status', [var_comment.clone()])))
			&& !(!rt.is_true(rt.get_property(var_comment, 'comment_post_ID'))) {
			print('<a href="' +
				(rt.call_function('esc_url', [rt.call_function('get_comment_link', [var_comment.clone()])])).str() +
				'">' + var_submitted.str() + '</a>')
		} else {
			rt.echo_val(var_submitted)
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_ex', [rt.new_string('Comment'), rt.new_string('noun')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('comment_text', [var_comment.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('admin_url', [
				rt.concat(rt.new_string('comment.php?action=editcomment&c='), rt.get_property(var_comment,
					'comment_ID')),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Edit')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('submit_button', [var_button.clone(),
			rt.new_string('primary'), rt.new_string('submit'),
			rt.new_bool(false)])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('admin_url', [rt.new_string('edit-comments.php')]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Cancel')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_nonce_field', [rt.new_string(var_nonce_action.str()).clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_formaction.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.get_property(var_comment, 'comment_ID'),
		]))
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('deletecomment')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('trashcomment')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('untrashcomment')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('spamcomment')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('unspamcomment')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('approvecomment')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('unapprovecomment'))) {
		var_comment_id = rt.call_function('absint',
			[rt.get_superglobal('_REQUEST').array_get(rt.new_string('c'))])
		if rt.is_true(rt.call_function('in_array', [var_action.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'approvecomment' },
				rt.ArrayItem{ key: none, val: 'unapprovecomment' }]),
			rt.new_bool(true)]))
		{
			rt.call_function('check_admin_referer', [
				rt.new_string('approve-comment_' + var_comment_id.str()),
			])
		} else {
			rt.call_function('check_admin_referer', [
				rt.new_string('delete-comment_' + var_comment_id.str()),
			])
		}
		mut var_noredir :=
			rt.new_bool(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('noredir')))
		var_comment = rt.call_function('get_comment', [var_comment_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_comment)))) {
			rt.call_function('comment_footer_die', [
				rt.new_string(
					(rt.call_function('__', [rt.new_string('Invalid comment ID.')])).str() +
					(rt.call_function('sprintf', [rt.new_string(' <a href="%s">' + (rt.call_function('__', [rt.new_string('Go back')])).str() +
					'</a>.'), rt.new_string('edit-comments.php')])).str()),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_comment'),
			rt.get_property(var_comment, 'comment_ID'),
		])))))
		{
			rt.call_function('comment_footer_die', [
				rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to edit comments on this post.'),
				]),
			])
		}
		if rt.is_true(rt.call_function('wp_get_referer', []rt.PhpVal{}))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_noredir))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [rt.call_function('wp_get_referer', []rt.PhpVal{}), rt.new_string('comment.php')]))))) {
			mut var_redir := rt.call_function('wp_get_referer', []rt.PhpVal{})
		} else if rt.is_true(rt.call_function('wp_get_original_referer', []rt.PhpVal{}))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_noredir)))) {
			var_redir = rt.call_function('wp_get_original_referer', []rt.PhpVal{})
		} else if rt.is_true(rt.call_function('in_array', [var_action.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'approvecomment' },
				rt.ArrayItem{ key: none, val: 'unapprovecomment' }]),
			rt.new_bool(true)]))
		{
			var_redir = rt.call_function('admin_url', [
				rt.new_string('edit-comments.php?p=' +(rt.call_function('absint', [rt.get_property(var_comment, 'comment_post_ID')])).str()),
			])
		} else {
			var_redir = rt.call_function('admin_url', [
				rt.new_string('edit-comments.php'),
			])
		}
		var_redir = rt.call_function('remove_query_arg', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'spammed' },
				rt.ArrayItem{ key: none, val: 'unspammed' }, rt.ArrayItem{ key: none, val: 'trashed' },
				rt.ArrayItem{ key: none, val: 'untrashed' }, rt.ArrayItem{ key: none, val: 'deleted' },
				rt.ArrayItem{ key: none, val: 'ids' }, rt.ArrayItem{ key: none, val: 'approved' },
				rt.ArrayItem{ key: none, val: 'unapproved' }]),
			var_redir.clone(),
		])
		mut switch_val_4 := var_action
		if rt.is_true(rt.equal(switch_val_4, rt.new_string('deletecomment'))) {
			rt.call_function('wp_delete_comment', [var_comment.clone()])
			var_redir = rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'deleted', val: '1' }]),
				var_redir.clone(),
			])
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('trashcomment'))) {
			rt.call_function('wp_trash_comment', [var_comment.clone()])
			var_redir = rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'trashed', val: '1' },
					rt.ArrayItem{ key: 'ids', val: var_comment_id }]),
				var_redir.clone(),
			])
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('untrashcomment'))) {
			rt.call_function('wp_untrash_comment', [var_comment.clone()])
			var_redir = rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'untrashed', val: '1' }]),
				var_redir.clone(),
			])
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('spamcomment'))) {
			rt.call_function('wp_spam_comment', [var_comment.clone()])
			var_redir = rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'spammed', val: '1' },
					rt.ArrayItem{ key: 'ids', val: var_comment_id }]),
				var_redir.clone(),
			])
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('unspamcomment'))) {
			rt.call_function('wp_unspam_comment', [var_comment.clone()])
			var_redir = rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'unspammed', val: '1' }]),
				var_redir.clone(),
			])
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('approvecomment'))) {
			rt.call_function('wp_set_comment_status', [var_comment.clone(),
				rt.new_string('approve')])
			var_redir = rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'approved', val: 1 }]),
				var_redir.clone(),
			])
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('unapprovecomment'))) {
			rt.call_function('wp_set_comment_status', [var_comment.clone(),
				rt.new_string('hold')])
			var_redir = rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'unapproved', val: 1 }]),
				var_redir.clone(),
			])
		}
		rt.call_function('wp_redirect', [var_redir.clone()])
		exit(0)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('editedcomment'))) {
		var_comment_id = rt.call_function('absint', [
			rt.get_superglobal('_POST').array_get(rt.new_string('comment_ID')),
		])
		mut var_comment_post_id := rt.call_function('absint', [
			rt.get_superglobal('_POST').array_get(rt.new_string('comment_post_ID')),
		])
		rt.call_function('check_admin_referer', [
			rt.new_string('update-comment_' + var_comment_id.str()),
		])
		mut var_updated := rt.call_function('edit_comment', []rt.PhpVal{})
		if rt.is_true(rt.call_function('is_wp_error', [var_updated.clone()])) {
			rt.call_function('wp_die', [
				rt.call_method(var_updated, 'get_error_message', []rt.PhpVal{}),
			])
		}
		mut var_location := rt.new_string(
			(if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('referredby'))) { rt.new_string('edit-comments.php?p=${var_comment_post_id.to_string()}') } else { rt.get_superglobal('_POST').array_get(rt.new_string('referredby')) }).str() +
			'#comment-' + var_comment_id.str())
		var_location = rt.call_function('apply_filters', [
			rt.new_string('comment_edit_redirect'),
			var_location.clone(),
			var_comment_id.clone(),
		])
		rt.call_function('wp_redirect', [var_location.clone()])
		exit(0)
	} else {
		rt.call_function('wp_die', [
			rt.call_function('__', [rt.new_string('Unknown action.')]),
		])
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
