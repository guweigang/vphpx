import rt


fn main() {
	defer {
		rt.shutdown()
	}

	mut var_typenow := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	mut var_parent_file := rt.new_string(rt.new_string('edit.php'))
	mut var_submenu_file := 'edit.php'
	mut var_action := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('action'))) { rt.call_function('sanitize_text_field', [rt.get_superglobal('_REQUEST').array_get('action')]) } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('post')) && rt.get_superglobal('_POST').array_isset(rt.new_string('post_ID')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('A post ID mismatch has been detected.')]), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this item.')]), rt.new_int(400)])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('post')) {
		mut var_post_id := // unsupported expression: Expr_Cast_Int
	} else if rt.get_superglobal('_POST').array_isset(rt.new_string('post_ID')) {
		var_post_id = // unsupported expression: Expr_Cast_Int
	} else {
		var_post_id = rt.new_int(rt.new_int(0))
	}
	mut var_post_ID := var_post_id.dup()
	// unsupported statement: Stmt_Global
	if rt.is_true(var_post_id) {
		mut var_post := rt.call_function('get_post', [var_post_id.dup()])
	}
	if rt.is_true(var_post) {
		mut var_post_type := rt.get_property(var_post, 'post_type')
		mut var_post_type_object := rt.call_function('get_post_type_object', [var_post_type.dup()])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('post_type')) && rt.is_true(var_post))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('A post type mismatch has been detected.')]), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this item.')]), rt.new_int(400)])
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('deletepost')) {
		var_action = rt.new_string(rt.new_string('delete'))
	} else if rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('wp-preview')) && rt.is_true(rt.identical(rt.new_string('dopreview'), rt.get_superglobal('_POST').array_get('wp-preview'))))) {
		var_action = rt.new_string(rt.new_string('preview'))
	}
	mut var_sendback := rt.call_function('wp_get_referer', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_sendback)))) || rt.is_true(rt.call_function('str_contains', [var_sendback.dup(), rt.new_string('post.php')])))) || rt.is_true(rt.call_function('str_contains', [var_sendback.dup(), rt.new_string('post-new.php')])))) {
		if rt.is_true(rt.identical(rt.new_string('attachment'), var_post_type)) {
			var_sendback = rt.call_function('admin_url', [rt.new_string('upload.php')])
		} else {
			var_sendback = rt.call_function('admin_url', [rt.new_string('edit.php')])
			if !(!rt.is_true(var_post_type)) {
				var_sendback = rt.call_function('add_query_arg', [rt.new_string('post_type'), var_post_type.dup(), var_sendback.dup()])
			}
		}
	} else {
		var_sendback = rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: 'trashed' }, rt.ArrayItem{ key: none, val: 'untrashed' }, rt.ArrayItem{ key: none, val: 'deleted' }, rt.ArrayItem{ key: none, val: 'ids' }]), var_sendback.dup()])
	}
	mut switch_val_1 := var_action
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('post-quickdraft-save'))) {
		mut var_nonce := rt.get_superglobal('_REQUEST').array_get('_wpnonce')
		mut var_error_msg := rt.new_bool(rt.new_bool(false))
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/dashboard.php', '4')
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [var_nonce.dup(), rt.new_string('add-post')]))))) {
			var_error_msg = rt.call_function('__', [rt.new_string('Unable to submit this form, please refresh and try again.')])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [rt.new_string('post')]), 'cap'), 'create_posts')]))))) {
			// unsupported expression: Expr_Exit
		}
		if rt.is_true(var_error_msg) {
			return rt.call_function('wp_dashboard_quick_press', [var_error_msg.dup()])
		}
		var_post = rt.call_function('get_post', [rt.get_superglobal('_REQUEST').array_get('post_ID')])
		rt.call_function('check_admin_referer', ['add-' + (rt.get_property(var_post, 'post_type')).str()])
		rt.get_superglobal('_POST').array_set('comment_status', rt.call_function('get_default_comment_status', [rt.get_property(var_post, 'post_type')]))
		rt.get_superglobal('_POST').array_set('ping_status', rt.call_function('get_default_comment_status', [rt.get_property(var_post, 'post_type'), rt.new_string('pingback')]))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_POST').array_get('content'), rt.new_string('<!-- wp:paragraph -->')]))))) {
			rt.get_superglobal('_POST').array_set('content', rt.call_function('sprintf', [rt.new_string('<!-- wp:paragraph -->%s<!-- /wp:paragraph -->'), rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '\r\n' }, rt.ArrayItem{ key: none, val: '\r' }, rt.ArrayItem{ key: none, val: '\n' }]), rt.new_string('<br />'), rt.get_superglobal('_POST').array_get('content')])]))
		}
		rt.call_function('edit_post', []rt.PhpVal{})
		rt.call_function('wp_dashboard_quick_press', []rt.PhpVal{})
		// unsupported expression: Expr_Exit
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('postajaxpost'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('post'))) {
		rt.call_function('check_admin_referer', ['add-' + (var_post_type).str()])
		var_post_id = if rt.is_true(rt.identical(rt.new_string('postajaxpost'), var_action)) { rt.call_function('edit_post', []rt.PhpVal{}) } else { rt.call_function('write_post', []rt.PhpVal{}) }
		rt.call_function('redirect_post', [var_post_id.dup()])
		// unsupported expression: Expr_Exit
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit'))) {
		mut var_editing := true
		if !rt.is_true(var_post_id) {
			rt.call_function('wp_redirect', [rt.call_function('admin_url', [rt.new_string('post.php')])])
			// unsupported expression: Expr_Exit
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('You attempted to edit an item that does not exist. Perhaps it was deleted?')]), rt.new_int(404)])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type_object)))) {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Invalid post type.')]), rt.new_int(400)])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_typenow.dup(), rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'show_ui', val: true }])]), rt.new_bool(true)]))))) {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit posts in this post type.')]), rt.new_int(403)])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), var_post_id.dup()]))))) {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this item.')]), rt.new_int(403)])
		}
		if rt.is_true(rt.identical(rt.new_string('trash'), rt.get_property(var_post, 'post_status'))) {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('You cannot edit this item because it is in the Trash. Please restore it and try again.')]), rt.new_int(409)])
		}
		if !(!rt.is_true(rt.get_superglobal('_GET').array_get('get-post-lock'))) {
			rt.call_function('check_admin_referer', ['lock-post_' + (var_post_id).str()])
			rt.call_function('wp_set_post_lock', [var_post_id.dup()])
			rt.call_function('wp_redirect', [rt.call_function('get_edit_post_link', [var_post_id.dup(), rt.new_string('url')])])
			// unsupported expression: Expr_Exit
		}
		var_post_type = rt.get_property(var_post, 'post_type')
		if rt.is_true(rt.identical(rt.new_string('post'), var_post_type)) {
			var_parent_file = rt.new_string(rt.new_string('edit.php'))
			var_submenu_file = 'edit.php'
			mut var_post_new_file := 'post-new.php'
		} else if rt.is_true(rt.identical(rt.new_string('attachment'), var_post_type)) {
			var_parent_file = rt.new_string(rt.new_string('upload.php'))
			var_submenu_file = 'upload.php'
			var_post_new_file = 'media-new.php'
		} else {
			if rt.is_true(rt.new_bool(rt.is_true(rt.get_property(var_post_type_object, 'show_in_menu')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				var_parent_file = rt.get_property(var_post_type_object, 'show_in_menu')
			} else {
				var_parent_file = rt.new_string(rt.new_string("edit.php?post_type=${var_post_type.to_string()}"))
			}
			var_submenu_file = "edit.php?post_type=${var_post_type.to_string()}"
			var_post_new_file = "post-new.php?post_type=${var_post_type.to_string()}"
		}
		mut var_title := rt.get_property(rt.get_property(var_post_type_object, 'labels'), 'edit_item')
		if rt.is_true(rt.identical(rt.new_bool(true), rt.call_function('apply_filters', [rt.new_string('replace_editor'), rt.new_bool(false), var_post.dup()]))) {
			break
		}
		if rt.is_true(rt.call_function('use_block_editor_for_post', [var_post.dup()])) {
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/edit-form-blocks.php', '3')
			break
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_check_post_lock', [rt.get_property(var_post, 'ID')]))))) {
			mut var_active_post_lock := rt.call_function('wp_set_post_lock', [rt.get_property(var_post, 'ID')])
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				rt.call_function('wp_enqueue_script', [rt.new_string('autosave')])
			}
		}
		var_post = rt.call_function('get_post', [var_post_id.dup(), rt.get_constant('OBJECT'), rt.new_string('edit')])
		if rt.is_true(rt.call_function('post_type_supports', [var_post_type.dup(), rt.new_string('comments')])) {
			rt.call_function('wp_enqueue_script', [rt.new_string('admin-comments')])
			rt.call_function('enqueue_comment_hotkeys_js', []rt.PhpVal{})
		}
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/edit-form-advanced.php', '3')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('editattachment'))) {
		rt.call_function('check_admin_referer', ['update-post_' + (var_post_id).str()])
		rt.get_superglobal('_POST').array_unset(rt.new_string('guid'))
		rt.get_superglobal('_POST').array_set('post_type', 'attachment')
		mut var_newmeta := rt.call_function('wp_get_attachment_metadata', [var_post_id.dup(), rt.new_bool(true)])
		var_newmeta.array_set('thumb', rt.call_function('wp_basename', [rt.get_superglobal('_POST').array_get('thumb')]))
		rt.call_function('wp_update_attachment_metadata', [var_post_id.dup(), var_newmeta.dup()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('editpost'))) {
		rt.call_function('check_admin_referer', ['update-post_' + (var_post_id).str()])
		var_post_id = rt.call_function('edit_post', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(rt.get_superglobal('_COOKIE').array_isset(rt.new_string('wp-saving-post')) && rt.is_true(rt.identical(rt.get_superglobal('_COOKIE').array_get('wp-saving-post'), (var_post_id).str() + '-check')))) {
			rt.call_function('setcookie', [rt.new_string('wp-saving-post'), (var_post_id).str() + '-saved', rt.add(rt.call_function('time', []rt.PhpVal{}), rt.get_constant('DAY_IN_SECONDS')), rt.get_constant('ADMIN_COOKIE_PATH'), rt.get_constant('COOKIE_DOMAIN'), rt.call_function('is_ssl', []rt.PhpVal{})])
		}
		rt.call_function('redirect_post', [var_post_id.dup()])
		// unsupported expression: Expr_Exit
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('trash'))) {
		rt.call_function('check_admin_referer', ['trash-post_' + (var_post_id).str()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('The item you are trying to move to the Trash no longer exists.')]), rt.new_int(410)])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type_object)))) {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Invalid post type.')]), rt.new_int(400)])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_post'), var_post_id.dup()]))))) {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to move this item to the Trash.')]), rt.new_int(403)])
		}
		mut var_user_id := rt.call_function('wp_check_post_lock', [var_post_id.dup()])
		if rt.is_true(var_user_id) {
			mut var_user := rt.call_function('get_userdata', [var_user_id.dup()])
			rt.call_function('wp_die', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You cannot move this item to the Trash. %s is currently editing.')]), rt.get_property(var_user, 'display_name')]), rt.new_int(409)])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_trash_post', [var_post_id.dup()]))))) {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Error in moving the item to Trash.')]), rt.new_int(500)])
		}
		rt.call_function('wp_redirect', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'trashed', val: 1 }, rt.ArrayItem{ key: 'ids', val: var_post_id }]), var_sendback.dup()])])
		// unsupported expression: Expr_Exit
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('untrash'))) {
		rt.call_function('check_admin_referer', ['untrash-post_' + (var_post_id).str()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('The item you are trying to restore from the Trash no longer exists.')]), rt.new_int(410)])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type_object)))) {
			rt.call_function('wp_die', [rt.call_function('__', []), rt.new_int(400)])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [, .dup()]))))) {
			rt.call_function('wp_die', [, ])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true()))) {
			
		}
		
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	} else {
	}
}
