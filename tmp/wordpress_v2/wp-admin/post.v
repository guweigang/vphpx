import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_typenow := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	mut var_parent_file := rt.new_string('edit.php')
	mut var_submenu_file := 'edit.php'
	mut var_action := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('action')))) { rt.call_function('sanitize_text_field', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('action')),
		]) } else { rt.new_string('') }
	if rt.get_superglobal('_GET').array_isset(rt.new_string('post'))
		&& rt.get_superglobal('_POST').array_isset(rt.new_string('post_ID'))
		&& rt.is_true(rt.new_bool(rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('post'))).to_i64()) != rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('post_ID'))).to_i64()))) {
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('A post ID mismatch has been detected.'),
			]),
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to edit this item.'),
			]),
			rt.new_int(400),
		])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('post')) {
		mut var_post_id :=
			rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('post'))).to_i64())
	} else if rt.get_superglobal('_POST').array_isset(rt.new_string('post_ID')) {
		var_post_id =
			rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('post_ID'))).to_i64())
	} else {
		var_post_id = rt.new_int(0)
	}
	mut var_post_ID := var_post_id.clone()
	mut var_post_type := rt.get_superglobal('post_type')
	mut var_post_type_object := rt.get_superglobal('post_type_object')
	mut var_post := rt.get_superglobal('post')
	if rt.is_true(var_post_id) {
		var_post = rt.call_function('get_post', [var_post_id.clone()])
	}
	if rt.is_true(var_post) {
		var_post_type = rt.get_property(var_post, 'post_type')
		var_post_type_object = rt.call_function('get_post_type_object', [
			var_post_type.clone()])
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('post_type')) && rt.is_true(var_post)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_post_type, rt.get_superglobal('_POST').array_get(rt.new_string('post_type')))))) {
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('A post type mismatch has been detected.'),
			]),
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to edit this item.'),
			]),
			rt.new_int(400),
		])
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('deletepost')) {
		var_action = rt.new_string('delete')
	} else if rt.get_superglobal('_POST').array_isset(rt.new_string('wp-preview'))
		&& rt.is_true(rt.identical(rt.new_string('dopreview'), rt.get_superglobal('_POST').array_get(rt.new_string('wp-preview')))) {
		var_action = rt.new_string('preview')
	}
	mut var_sendback := rt.call_function('wp_get_referer', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_sendback))))
		|| rt.is_true(rt.call_function('str_contains', [var_sendback.clone(), rt.new_string('post.php')]))
		|| rt.is_true(rt.call_function('str_contains', [var_sendback.clone(), rt.new_string('post-new.php')])) {
		if rt.is_true(rt.identical(rt.new_string('attachment'), var_post_type)) {
			var_sendback = rt.call_function('admin_url', [rt.new_string('upload.php')])
		} else {
			var_sendback = rt.call_function('admin_url', [rt.new_string('edit.php')])
			if !(!rt.is_true(var_post_type)) {
				var_sendback = rt.call_function('add_query_arg', [
					rt.new_string('post_type'),
					var_post_type.clone(),
					var_sendback.clone(),
				])
			}
		}
	} else {
		var_sendback = rt.call_function('remove_query_arg', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'trashed' },
				rt.ArrayItem{ key: none, val: 'untrashed' }, rt.ArrayItem{ key: none, val: 'deleted' },
				rt.ArrayItem{ key: none, val: 'ids' }]),
			var_sendback.clone(),
		])
	}
	mut switch_val_1 := var_action
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('post-quickdraft-save'))) {
		mut var_nonce := rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wpnonce'))
		mut var_error_msg := rt.new_bool(false)
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/dashboard.php', '4')
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [
			var_nonce.clone(),
			rt.new_string('add-post'),
		])))))
		{
			var_error_msg = rt.call_function('__', [
				rt.new_string('Unable to submit this form, please refresh and try again.'),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [
				rt.new_string('post'),
			]), 'cap'), 'create_posts'),
		])))))
		{
			exit(0)
		}
		if rt.is_true(var_error_msg) {
			return rt.call_function('wp_dashboard_quick_press', [
				var_error_msg.clone()])
		}
		var_post = rt.call_function('get_post',
			[rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_ID'))])
		rt.call_function('check_admin_referer', [
			rt.new_string('add-' + (rt.get_property(var_post, 'post_type')).str()),
		])
		rt.get_superglobal('_POST').array_set('comment_status', rt.call_function('get_default_comment_status', [
			rt.get_property(var_post, 'post_type'),
		]))
		rt.get_superglobal('_POST').array_set('ping_status', rt.call_function('get_default_comment_status', [
			rt.get_property(var_post, 'post_type'),
			rt.new_string('pingback'),
		]))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
			rt.get_superglobal('_POST').array_get(rt.new_string('content')),
			rt.new_string('<!-- wp:paragraph -->'),
		])))))
		{
			rt.get_superglobal('_POST').array_set('content', rt.call_function('sprintf', [
				rt.new_string('<!-- wp:paragraph -->%s<!-- /wp:paragraph -->'),
				rt.call_function('str_replace', [
					rt.create_array([rt.ArrayItem{ key: none, val: '\r\n' },
						rt.ArrayItem{ key: none, val: '\r' },
						rt.ArrayItem{ key: none, val: '\n' }]),
					rt.new_string('<br />'),
					rt.get_superglobal('_POST').array_get(rt.new_string('content')),
				]),
			]))
		}
		rt.call_function('edit_post', []rt.PhpVal{})
		rt.call_function('wp_dashboard_quick_press', []rt.PhpVal{})
		exit(0)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('postajaxpost')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('post'))) {
		rt.call_function('check_admin_referer', [
			rt.new_string('add-' + var_post_type.str()),
		])
		var_post_id = if rt.is_true(rt.identical(rt.new_string('postajaxpost'), var_action)) {
			rt.call_function('edit_post', []rt.PhpVal{})
		} else {
			rt.call_function('write_post', []rt.PhpVal{})
		}
		rt.call_function('redirect_post', [var_post_id.clone()])
		exit(0)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit'))) {
		mut var_editing := true
		if !rt.is_true(var_post_id) {
			rt.call_function('wp_redirect', [
				rt.call_function('admin_url', [rt.new_string('post.php')]),
			])
			exit(0)
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('You attempted to edit an item that does not exist. Perhaps it was deleted?'),
				]),
				rt.new_int(404),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type_object)))) {
			rt.call_function('wp_die', [
				rt.call_function('__', [rt.new_string('Invalid post type.')]),
				rt.new_int(400),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_typenow.clone(),
			rt.call_function('get_post_types', [
				rt.create_array([rt.ArrayItem{ key: 'show_ui', val: true }]),
			]),
			rt.new_bool(true)])))))
		{
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to edit posts in this post type.'),
				]),
				rt.new_int(403),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_post'),
			var_post_id.clone(),
		])))))
		{
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to edit this item.'),
				]),
				rt.new_int(403),
			])
		}
		if rt.is_true(rt.identical(rt.new_string('trash'), rt.get_property(var_post, 'post_status'))) {
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('You cannot edit this item because it is in the Trash. Please restore it and try again.'),
				]),
				rt.new_int(409),
			])
		}
		if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('get-post-lock')))) {
			rt.call_function('check_admin_referer', [
				rt.new_string('lock-post_' + var_post_id.str()),
			])
			rt.call_function('wp_set_post_lock', [var_post_id.clone()])
			rt.call_function('wp_redirect', [
				rt.call_function('get_edit_post_link', [var_post_id.clone(),
					rt.new_string('url')]),
			])
			exit(0)
		}
		var_post_type = rt.get_property(var_post, 'post_type')
		if rt.is_true(rt.identical(rt.new_string('post'), var_post_type)) {
			var_parent_file = rt.new_string('edit.php')
			var_submenu_file = 'edit.php'
			mut var_post_new_file := 'post-new.php'
		} else if rt.is_true(rt.identical(rt.new_string('attachment'), var_post_type)) {
			var_parent_file = rt.new_string('upload.php')
			var_submenu_file = 'upload.php'
			var_post_new_file = 'media-new.php'
		} else {
			if rt.is_true(rt.get_property(var_post_type_object, 'show_in_menu'))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), rt.get_property(var_post_type_object, 'show_in_menu'))))) {
				var_parent_file = rt.get_property(var_post_type_object, 'show_in_menu')
			} else {
				var_parent_file = rt.new_string('edit.php?post_type=${var_post_type.to_string()}')
			}
			var_submenu_file = 'edit.php?post_type=${var_post_type.to_string()}'
			var_post_new_file = 'post-new.php?post_type=${var_post_type.to_string()}'
		}
		mut var_title := rt.get_property(rt.get_property(var_post_type_object, 'labels'),
			'edit_item')
		if rt.is_true(rt.identical(rt.new_bool(true), rt.call_function('apply_filters', [
			rt.new_string('replace_editor'),
			rt.new_bool(false),
			var_post.clone(),
		])))
		{
		}
		if rt.is_true(rt.call_function('use_block_editor_for_post', [
			var_post.clone()]))
		{
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/edit-form-blocks.php',
				'3')
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_check_post_lock', [
			rt.get_property(var_post, 'ID'),
		])))))
		{
			mut var_active_post_lock := rt.call_function('wp_set_post_lock', [
				rt.get_property(var_post, 'ID'),
			])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('attachment'),
				var_post_type))))
			{
				rt.call_function('wp_enqueue_script', [rt.new_string('autosave')])
			}
		}
		var_post = rt.call_function('get_post', [var_post_id.clone(),
			rt.get_constant('OBJECT'), rt.new_string('edit')])
		if rt.is_true(rt.call_function('post_type_supports', [
			var_post_type.clone(), rt.new_string('comments')]))
		{
			rt.call_function('wp_enqueue_script', [rt.new_string('admin-comments')])
			rt.call_function('enqueue_comment_hotkeys_js', []rt.PhpVal{})
		}
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/edit-form-advanced.php', '3')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('editattachment'))) {
		rt.call_function('check_admin_referer', [
			rt.new_string('update-post_' + var_post_id.str()),
		])
		rt.get_superglobal('_POST').array_unset(rt.new_string('guid'))
		rt.get_superglobal('_POST').array_set('post_type', 'attachment')
		mut var_newmeta := rt.call_function('wp_get_attachment_metadata', [
			var_post_id.clone(), rt.new_bool(true)])
		var_newmeta.array_set('thumb', rt.call_function('wp_basename', [
			rt.get_superglobal('_POST').array_get(rt.new_string('thumb')),
		]))
		rt.call_function('wp_update_attachment_metadata', [var_post_id.clone(),
			var_newmeta.clone()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('editpost'))) {
		rt.call_function('check_admin_referer', [
			rt.new_string('update-post_' + var_post_id.str()),
		])
		var_post_id = rt.call_function('edit_post', []rt.PhpVal{})
		if rt.get_superglobal('_COOKIE').array_isset(rt.new_string('wp-saving-post'))
			&& rt.is_true(rt.identical(rt.get_superglobal('_COOKIE').array_get(rt.new_string('wp-saving-post')), var_post_id.str() + '-check')) {
			rt.call_function('setcookie', [rt.new_string('wp-saving-post'),
				rt.new_string(var_post_id.str() + '-saved'),
				rt.add(rt.call_function('time',
					[]rt.PhpVal{}), rt.get_constant('DAY_IN_SECONDS')),
				rt.get_constant('ADMIN_COOKIE_PATH'), rt.get_constant('COOKIE_DOMAIN'),
				rt.call_function('is_ssl', []rt.PhpVal{})])
		}
		rt.call_function('redirect_post', [var_post_id.clone()])
		exit(0)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('trash'))) {
		rt.call_function('check_admin_referer', [
			rt.new_string('trash-post_' + var_post_id.str()),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('The item you are trying to move to the Trash no longer exists.'),
				]),
				rt.new_int(410),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type_object)))) {
			rt.call_function('wp_die', [
				rt.call_function('__', [rt.new_string('Invalid post type.')]),
				rt.new_int(400),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('delete_post'),
			var_post_id.clone(),
		])))))
		{
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to move this item to the Trash.'),
				]),
				rt.new_int(403),
			])
		}
		mut var_user_id := rt.call_function('wp_check_post_lock', [
			var_post_id.clone()])
		if rt.is_true(var_user_id) {
			mut var_user := rt.call_function('get_userdata', [
				var_user_id.clone()])
			rt.call_function('wp_die', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('You cannot move this item to the Trash. %s is currently editing.'),
					]),
					rt.get_property(var_user, 'display_name'),
				]),
				rt.new_int(409),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_trash_post', [
			var_post_id.clone(),
		])))))
		{
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Error in moving the item to Trash.'),
				]),
				rt.new_int(500),
			])
		}
		rt.call_function('wp_redirect', [
			rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'trashed', val: 1 },
					rt.ArrayItem{ key: 'ids', val: var_post_id }]),
				var_sendback.clone(),
			]),
		])
		exit(0)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('untrash'))) {
		rt.call_function('check_admin_referer', [
			rt.new_string('untrash-post_' + var_post_id.str()),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('The item you are trying to restore from the Trash no longer exists.'),
				]),
				rt.new_int(410),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type_object)))) {
			rt.call_function('wp_die', [
				rt.call_function('__', [rt.new_string('Invalid post type.')]),
				rt.new_int(400),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('delete_post'),
			var_post_id.clone(),
		])))))
		{
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to restore this item from the Trash.'),
				]),
				rt.new_int(403),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_untrash_post', [
			var_post_id.clone(),
		])))))
		{
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Error in restoring the item from Trash.'),
				]),
				rt.new_int(500),
			])
		}
		var_sendback = rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'untrashed', val: 1 },
				rt.ArrayItem{ key: 'ids', val: var_post_id }]),
			var_sendback.clone(),
		])
		rt.call_function('wp_redirect', [var_sendback.clone()])
		exit(0)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete'))) {
		rt.call_function('check_admin_referer', [
			rt.new_string('delete-post_' + var_post_id.str()),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('This item has already been deleted.'),
				]),
				rt.new_int(410),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type_object)))) {
			rt.call_function('wp_die', [
				rt.call_function('__', [rt.new_string('Invalid post type.')]),
				rt.new_int(400),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('delete_post'),
			var_post_id.clone(),
		])))))
		{
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to delete this item.'),
				]),
				rt.new_int(403),
			])
		}
		if rt.is_true(rt.identical(rt.new_string('attachment'), rt.get_property(var_post,
			'post_type')))
		{
			mut var_force := !(rt.is_true(rt.get_constant('MEDIA_TRASH')))
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_delete_attachment', [
				var_post_id.clone(),
				rt.new_bool(var_force).clone(),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Error in deleting the attachment.'),
					]),
					rt.new_int(500),
				])
			}
		} else {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_delete_post', [
				var_post_id.clone(),
				rt.new_bool(true),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('__', [rt.new_string('Error in deleting the item.')]),
					rt.new_int(500),
				])
			}
		}
		rt.call_function('wp_redirect', [
			rt.call_function('add_query_arg', [rt.new_string('deleted'),
				rt.new_int(1), var_sendback.clone()]),
		])
		exit(0)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('preview'))) {
		rt.call_function('check_admin_referer', [
			rt.new_string('update-post_' + var_post_id.str()),
		])
		mut var_url := rt.call_function('post_preview', []rt.PhpVal{})
		rt.call_function('wp_redirect', [var_url.clone()])
		exit(0)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('toggle-custom-fields'))) {
		rt.call_function('check_admin_referer', [rt.new_string('toggle-custom-fields'),
			rt.new_string('toggle-custom-fields-nonce')])
		mut var_current_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
		if rt.is_true(var_current_user_id) {
			mut var_enable_custom_fields := rt.new_bool((rt.call_function('get_user_meta', [
				var_current_user_id.clone(),
				rt.new_string('enable_custom_fields'),
				rt.new_bool(true),
			])).to_bool())
			rt.call_function('update_user_meta', [var_current_user_id.clone(),
				rt.new_string('enable_custom_fields'),
				rt.new_bool(!(rt.is_true(var_enable_custom_fields)))])
		}
		rt.call_function('wp_safe_redirect', [
			rt.call_function('wp_get_referer', []rt.PhpVal{}),
		])
		exit(0)
	} else {
		rt.call_function('do_action', [
			rt.new_string('post_action_${var_action.to_string()}'),
			var_post_id.clone(),
		])
		rt.call_function('wp_redirect', [
			rt.call_function('admin_url', [rt.new_string('edit.php')]),
		])
		exit(0)
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
