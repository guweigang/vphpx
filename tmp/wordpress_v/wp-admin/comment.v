import rt


fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	mut var_parent_file := 'edit-comments.php'
	mut var_submenu_file := 'edit-comments.php'
	// unsupported statement: Stmt_Global
	mut var_action := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('action'))) { rt.call_function('sanitize_text_field', [rt.get_superglobal('_REQUEST').array_get('action')]) } else { rt.new_string('') }
	if rt.get_superglobal('_POST').array_isset(rt.new_string('deletecomment')) {
		var_action = rt.new_string(rt.new_string('deletecomment'))
	}
	if rt.is_true(rt.identical(rt.new_string('cdc'), var_action)) {
		var_action = rt.new_string(rt.new_string('delete'))
	} else if rt.is_true(rt.identical(rt.new_string('mac'), var_action)) {
		var_action = rt.new_string(rt.new_string('approve'))
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('dt')) {
		if rt.is_true(rt.identical(rt.new_string('spam'), rt.get_superglobal('_GET').array_get('dt'))) {
			var_action = rt.new_string(rt.new_string('spam'))
		} else if rt.is_true(rt.identical(rt.new_string('trash'), rt.get_superglobal('_GET').array_get('dt'))) {
			var_action = rt.new_string(rt.new_string('trash'))
		}
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('c')) {
		mut var_comment_id := rt.call_function('absint', [rt.get_superglobal('_REQUEST').array_get('c')])
		mut var_comment := rt.call_function('get_comment', [var_comment_id.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(var_comment) && rt.is_true(rt.identical(rt.new_string('trash'), rt.call_function('get_post_status', [rt.get_property(var_comment, 'comment_post_ID')]))))) {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('You cannot edit this comment because the associated post is in the Trash. Please restore the post first, then try again.')])])
		}
	} else {
		var_comment_id = rt.new_int(rt.new_int(0))
		var_comment = rt.new_null()
	}
	mut switch_val_1 := var_action
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('editcomment'))) {
		mut var_title := rt.call_function('__', [rt.new_string('Edit Comment')])
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview')]) }, rt.ArrayItem{ key: 'content', val: '<p>' + (rt.call_function('__', [rt.new_string('You can edit the information left in a comment if needed. This is often useful when you notice that a commenter has made a typographical error.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('You can also moderate the comment from this screen using the Status box, where you can also change the timestamp of the comment.')])).str() + '</p>' }])])
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', ['<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/comments-screen/">Documentation on Comments</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() + '</p>'])
		rt.call_function('wp_enqueue_script', [rt.new_string('comment')])
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
		if rt.is_true(rt.new_bool(!(rt.is_true(var_comment)))) {
			rt.call_function('comment_footer_die', [rt.concat(rt.call_function('__', [rt.new_string('Invalid comment ID.')]), rt.call_function('sprintf', [' <a href="%s">' + (rt.call_function('__', [rt.new_string('Go back')])).str() + '</a>.', rt.new_string('javascript:history.go(-1)')]))])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_comment'), var_comment_id.dup()]))))) {
			rt.call_function('comment_footer_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this comment.')])])
		}
		if rt.is_true(rt.identical(rt.new_string('trash'), rt.get_property(var_comment, 'comment_approved'))) {
			rt.call_function('comment_footer_die', [rt.call_function('__', [rt.new_string('This comment is in the Trash. Please move it out of the Trash if you want to edit it.')])])
		}
		var_comment = rt.call_function('get_comment_to_edit', [var_comment_id.dup()])
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/edit-form-comment.php', '3')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('approve'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('trash'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('spam'))) {
		var_title = rt.call_function('__', [rt.new_string('Moderate Comment')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_comment)))) {
			rt.call_function('wp_redirect', [rt.call_function('admin_url', [rt.new_string('edit-comments.php?error=1')])])
			// unsupported expression: Expr_Exit
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_comment'), rt.get_property(var_comment, 'comment_ID')]))))) {
			rt.call_function('wp_redirect', [rt.call_function('admin_url', [rt.new_string('edit-comments.php?error=2')])])
			// unsupported expression: Expr_Exit
		}
		if rt.is_true(rt.identical(rt.call_function('str_replace', [rt.new_string('1'), rt.new_string('approve'), rt.get_property(var_comment, 'comment_approved')]), var_action)) {
			rt.call_function('wp_redirect', [rt.call_function('admin_url', ['edit-comments.php?same=' + (var_comment_id).str()])])
			// unsupported expression: Expr_Exit
		}
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
		mut var_formaction := rt.new_string((var_action).str() + 'comment')
		mut var_nonce_action := if rt.is_true(rt.identical(rt.new_string('approve'), var_action)) { 'approve-comment_' } else { 'delete-comment_' }
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_title.dup()]))
		// unsupported statement: Stmt_InlineHTML
		mut switch_val_2 := var_action
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('spam'))) {
			mut var_caution_msg := rt.call_function('__', [rt.new_string('You are about to mark the following comment as spam:')])
			mut var_button := rt.call_function('_x', [rt.new_string('Mark as spam'), rt.new_string('comment')])
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('trash'))) {
			var_caution_msg = rt.call_function('__', [rt.new_string('You are about to move the following comment to the Trash:')])
			var_button = rt.call_function('__', [rt.new_string('Move to Trash')])
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('delete'))) {
			var_caution_msg = rt.call_function('__', [rt.new_string('You are about to delete the following comment:')])
			var_button = rt.call_function('__', [rt.new_string('Permanently delete comment')])
		} else {
			var_caution_msg = rt.call_function('__', [rt.new_string('You are about to approve the following comment:')])
			var_button = rt.call_function('__', [rt.new_string('Approve comment')])
		}
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			mut var_message := rt.new_string(rt.new_string(''))
			mut switch_val_3 := rt.get_property(var_comment, 'comment_approved')
			if rt.is_true(rt.equal(switch_val_3, rt.new_string('1'))) {
				var_message = rt.call_function('__', [rt.new_string('This comment is currently approved.')])
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('spam'))) {
				var_message = rt.call_function('__', [rt.new_string('This comment is currently marked as spam.')])
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('trash'))) {
				var_message = rt.call_function('__', [rt.new_string('This comment is currently in the Trash.')])
			}
			if rt.is_true(var_message) {
				rt.call_function('wp_admin_notice', [var_message.dup(), rt.create_array([rt.ArrayItem{ key: 'type', val: 'info' }, rt.ArrayItem{ key: 'id', val: 'message' }])])
			}
		}
		rt.call_function('wp_admin_notice', ['<strong>' + (rt.call_function('__', [rt.new_string('Caution:')])).str() + '</strong> ' + (var_caution_msg).str(), rt.create_array([rt.ArrayItem{ key: 'type', val: 'warning' }, rt.ArrayItem{ key: 'id', val: 'message' }])])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Author')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('comment_author', [var_comment.dup()])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('get_comment_author_email', [var_comment.dup()])) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Email')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('comment_author_email', [var_comment.dup()])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('get_comment_author_url', [var_comment.dup()])) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('URL')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('comment_author_url', [var_comment.dup()])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('comment_author_url', [var_comment.dup()])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('In response to')])
		// unsupported statement: Stmt_InlineHTML
		mut var_post_id := rt.get_property(var_comment, 'comment_post_ID')
		if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), var_post_id.dup()])) {
			mut var_post_link := rt.new_string('<a href=\'' + (rt.call_function('esc_url', [rt.call_function('get_edit_post_link', [var_post_id.dup()])])).str() + '\'>')
			// unsupported expression: Expr_AssignOp_Concat
		} else {
			var_post_link = rt.call_function('esc_html', [rt.call_function('get_the_title', [var_post_id.dup()])])
		}
		rt.echo_val(var_post_link)
		if rt.is_true(rt.get_property(var_comment, 'comment_parent')) {
			mut var_parent := rt.call_function('get_comment', [rt.get_property(var_comment, 'comment_parent')])
			mut var_parent_link := rt.call_function('esc_url', [rt.call_function('get_comment_link', [var_parent.dup()])])
			mut var_name := rt.call_function('get_comment_author', [var_parent.dup()])
			rt.call_function('printf', [' | ' + (rt.call_function('__', [rt.new_string('In reply to %s.')])).str(), '<a href="' + (var_parent_link).str() + '">' + (var_name).str() + '</a>'])
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Submitted on')])
		// unsupported statement: Stmt_InlineHTML
		mut var_submitted := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s at %2$s')]), rt.call_function('get_comment_date', [rt.call_function('__', [rt.new_string('Y/m/d')]), var_comment.dup()]), rt.call_function('get_comment_date', [rt.call_function('__', [rt.new_string('g:i a')]), var_comment.dup()])])
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('approved'), rt.call_function('wp_get_comment_status', [var_comment.dup()]))) && !(!rt.is_true(rt.get_property(var_comment, 'comment_post_ID'))))) {
			print('<a href="' + (rt.call_function('esc_url', [rt.call_function('get_comment_link', [var_comment.dup()])])).str() + '">' + (var_submitted).str() + '</a>')
		} else {
			rt.echo_val(var_submitted)
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_ex', [rt.new_string('Comment'), rt.new_string('noun')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('comment_text', [var_comment.dup()])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [rt.call_function('admin_url', [])]))
		// unsupported statement: Stmt_InlineHTML
		
	} else if rt.is_true(rt.equal(switch_val_1, )) || rt.is_true(rt.equal(switch_val_1, )) || rt.is_true(rt.equal(switch_val_1, )) || rt.is_true(rt.equal(switch_val_1, )) || rt.is_true(rt.equal(switch_val_1, )) || rt.is_true(rt.equal(switch_val_1, )) || rt.is_true(rt.equal(switch_val_1, )) {
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	} else {
	}
}
