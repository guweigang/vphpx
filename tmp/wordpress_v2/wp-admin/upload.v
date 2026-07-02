import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_messages := rt.new_null()
	mut var_wpdb := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('upload_files'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to upload files.'),
			]),
		])
	}
	mut var_message := rt.new_string('')
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('posted')))) {
		var_message = rt.call_function('__', [rt.new_string('Media file updated.')])
		rt.get_superglobal('_SERVER').array_set('REQUEST_URI', rt.call_function('remove_query_arg', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'posted' }]),
			rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
		]))
		rt.get_superglobal('_GET').array_unset(rt.new_string('posted'))
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('attached'))))
		&& rt.is_true(rt.call_function('absint', [rt.get_superglobal('_GET').array_get(rt.new_string('attached'))])) {
		mut var_attached := rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('attached')),
		])
		if rt.is_true(rt.identical(rt.new_int(1), var_attached)) {
			var_message = rt.call_function('__', [rt.new_string('Media file attached.')])
		} else {
			var_message = rt.call_function('sprintf', [
				rt.call_function('_n', [rt.new_string('%s media file attached.'),
					rt.new_string('%s media files attached.'),
					var_attached.clone()]),
				rt.call_function('number_format_i18n', [var_attached.clone()]),
			])
		}
		rt.get_superglobal('_SERVER').array_set('REQUEST_URI', rt.call_function('remove_query_arg', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'detach' },
				rt.ArrayItem{ key: none, val: 'attached' }]),
			rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
		]))
		rt.get_superglobal('_GET').array_unset(rt.new_string('detach'))
		rt.get_superglobal('_GET').array_unset(rt.new_string('attached'))
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('detach'))))
		&& rt.is_true(rt.call_function('absint', [rt.get_superglobal('_GET').array_get(rt.new_string('detach'))])) {
		mut var_detached := rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('detach')),
		])
		if rt.is_true(rt.identical(rt.new_int(1), var_detached)) {
			var_message = rt.call_function('__', [rt.new_string('Media file detached.')])
		} else {
			var_message = rt.call_function('sprintf', [
				rt.call_function('_n', [rt.new_string('%s media file detached.'),
					rt.new_string('%s media files detached.'),
					var_detached.clone()]),
				rt.call_function('number_format_i18n', [var_detached.clone()]),
			])
		}
		rt.get_superglobal('_SERVER').array_set('REQUEST_URI', rt.call_function('remove_query_arg', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'detach' },
				rt.ArrayItem{ key: none, val: 'attached' }]),
			rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
		]))
		rt.get_superglobal('_GET').array_unset(rt.new_string('detach'))
		rt.get_superglobal('_GET').array_unset(rt.new_string('attached'))
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('deleted'))))
		&& rt.is_true(rt.call_function('absint', [rt.get_superglobal('_GET').array_get(rt.new_string('deleted'))])) {
		mut var_deleted := rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('deleted')),
		])
		if rt.is_true(rt.identical(rt.new_int(1), var_deleted)) {
			var_message = rt.call_function('__', [
				rt.new_string('Media file permanently deleted.'),
			])
		} else {
			var_message = rt.call_function('sprintf', [
				rt.call_function('_n', [
					rt.new_string('%s media file permanently deleted.'),
					rt.new_string('%s media files permanently deleted.'),
					var_deleted.clone(),
				]),
				rt.call_function('number_format_i18n', [
					var_deleted.clone(),
				]),
			])
		}
		rt.get_superglobal('_SERVER').array_set('REQUEST_URI', rt.call_function('remove_query_arg', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'deleted' }]),
			rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
		]))
		rt.get_superglobal('_GET').array_unset(rt.new_string('deleted'))
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('trashed'))))
		&& rt.is_true(rt.call_function('absint', [rt.get_superglobal('_GET').array_get(rt.new_string('trashed'))])) {
		mut var_trashed := rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('trashed')),
		])
		if rt.is_true(rt.identical(rt.new_int(1), var_trashed)) {
			var_message = rt.call_function('__', [
				rt.new_string('Media file moved to the Trash.'),
			])
		} else {
			var_message = rt.call_function('sprintf', [
				rt.call_function('_n', [
					rt.new_string('%s media file moved to the Trash.'),
					rt.new_string('%s media files moved to the Trash.'),
					var_trashed.clone(),
				]),
				rt.call_function('number_format_i18n', [
					var_trashed.clone(),
				]),
			])
		}
		var_message = rt.concat(var_message, rt.call_function('sprintf', [
			rt.new_string(' <a href="%1$s">%2$s</a>'),
			rt.call_function('esc_url', [
				rt.call_function('wp_nonce_url', [
					rt.new_string('upload.php?doaction=undo&action=untrash&ids=' +(if !(rt.get_superglobal('_GET').array_get(rt.new_string('ids'))).is_null() { rt.get_superglobal('_GET').array_get(rt.new_string('ids')) } else { rt.new_string('') }).str()),
					rt.new_string('bulk-media'),
				]),
			]),
			rt.call_function('__', [
				rt.new_string('Undo'),
			]),
		]))
		rt.get_superglobal('_SERVER').array_set('REQUEST_URI', rt.call_function('remove_query_arg', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'trashed' }]),
			rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
		]))
		rt.get_superglobal('_GET').array_unset(rt.new_string('trashed'))
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('untrashed'))))
		&& rt.is_true(rt.call_function('absint', [rt.get_superglobal('_GET').array_get(rt.new_string('untrashed'))])) {
		mut var_untrashed := rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('untrashed')),
		])
		if rt.is_true(rt.identical(rt.new_int(1), var_untrashed)) {
			var_message = rt.call_function('__', [
				rt.new_string('Media file restored from the Trash.'),
			])
		} else {
			var_message = rt.call_function('sprintf', [
				rt.call_function('_n', [
					rt.new_string('%s media file restored from the Trash.'),
					rt.new_string('%s media files restored from the Trash.'),
					var_untrashed.clone(),
				]),
				rt.call_function('number_format_i18n', [
					var_untrashed.clone(),
				]),
			])
		}
		rt.get_superglobal('_SERVER').array_set('REQUEST_URI', rt.call_function('remove_query_arg', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'untrashed' }]),
			rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
		]))
		rt.get_superglobal('_GET').array_unset(rt.new_string('untrashed'))
	}
	var_messages.array_set(1, rt.call_function('__', [
		rt.new_string('Media file updated.'),
	]))
	var_messages.array_set(2, rt.call_function('__', [
		rt.new_string('Media file permanently deleted.'),
	]))
	var_messages.array_set(3, rt.call_function('__', [
		rt.new_string('Error saving media file.'),
	]))
	var_messages.array_set(4,
		(rt.call_function('__', [rt.new_string('Media file moved to the Trash.')])).str() +
		(rt.call_function('sprintf', [rt.new_string(' <a href="%1$s">%2$s</a>'), rt.call_function('esc_url', [rt.call_function('wp_nonce_url', [rt.new_string('upload.php?doaction=undo&action=untrash&ids=' +(if !(rt.get_superglobal('_GET').array_get(rt.new_string('ids'))).is_null() { rt.get_superglobal('_GET').array_get(rt.new_string('ids')) } else { rt.new_string('') }).str()), rt.new_string('bulk-media')])]), rt.call_function('__', [rt.new_string('Undo')])])).str())
	var_messages.array_set(5, rt.call_function('__', [
		rt.new_string('Media file restored from the Trash.'),
	]))
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('message'))))
		&& var_messages.array_isset(rt.get_superglobal('_GET').array_get(rt.new_string('message'))) {
		var_message =
			var_messages.array_get(rt.get_superglobal('_GET').array_get(rt.new_string('message')))
		rt.get_superglobal('_SERVER').array_set('REQUEST_URI', rt.call_function('remove_query_arg', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'message' }]),
			rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
		]))
	}
	mut var_modes := ['grid', 'list']
	if rt.get_superglobal('_GET').array_isset(rt.new_string('mode'))
		&& rt.is_true(rt.call_function('in_array', [rt.get_superglobal('_GET').array_get(rt.new_string('mode')), rt.create_array_from_list(var_modes), rt.new_bool(true)])) {
		mut var_mode := rt.get_superglobal('_GET').array_get(rt.new_string('mode'))
		rt.call_function('update_user_option', [
			rt.call_function('get_current_user_id', []rt.PhpVal{}),
			rt.new_string('media_library_mode'),
			var_mode.clone(),
		])
	} else {
		var_mode = if rt.is_true(rt.call_function('get_user_option', [
			rt.new_string('media_library_mode'),
			rt.call_function('get_current_user_id', []rt.PhpVal{}),
		]))
		{
			rt.call_function('get_user_option', [rt.new_string('media_library_mode'),
				rt.call_function('get_current_user_id', []rt.PhpVal{})])
		} else {
			rt.new_string('grid')
		}
	}
	if rt.is_true(rt.identical(rt.new_string('grid'), var_mode)) {
		rt.call_function('wp_enqueue_media', []rt.PhpVal{})
		rt.call_function('wp_enqueue_script', [rt.new_string('media-grid')])
		rt.call_function('wp_enqueue_script', [rt.new_string('media')])
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			return rt.create_array([rt.ArrayItem{ key: none, val: 'error' }])
		}
		rt.call_function('add_filter', [rt.new_string('removable_query_args'),
			rt.new_closure(closure_1_fn), rt.new_int(10), rt.new_int(0)])
		mut var_query_string := rt.get_superglobal('_GET')
		var_query_string.array_unset(rt.new_string('s'))
		mut var_query_vars := rt.call_function('wp_edit_attachments_query_vars', [
			var_query_string.clone(),
		])
		mut var_ignore := ['mode', 'post_type', 'post_status', 'posts_per_page']
		mut iter_1 := var_query_vars.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(var_value))))
				|| rt.is_true(rt.call_function('in_array', [var_key.clone(), rt.create_array_from_list(var_ignore), rt.new_bool(true)])) {
				var_query_vars.array_unset(var_key)
			}
		}
		rt.call_function('wp_localize_script', [rt.new_string('media-grid'),
			rt.new_string('_wpMediaGridSettings'),
			rt.create_array([
				rt.ArrayItem{ key: 'adminUrl', val: rt.call_function('parse_url', [
					rt.call_function('self_admin_url', []rt.PhpVal{}),
					rt.get_constant('PHP_URL_PATH'),
				]) },
				rt.ArrayItem{ key: 'queryVars', val: rt.array_to_object(var_query_vars) },
			])])
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Overview'),
				]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
					(rt.call_function('__', [rt.new_string('All the files you&#8217;ve uploaded are listed in the Media Library, with the most recent uploads listed first.')])).str() +
					'</p>' + '<p>' +
					(rt.call_function('__', [rt.new_string('You can view your media in a simple visual grid or a list with columns. Switch between these views using the icons to the left above the media.')])).str() +
					'</p>' + '<p>' +
					(rt.call_function('__', [rt.new_string('To delete media items, click the <strong>Bulk select</strong> button at the top of the screen. Select any items you wish to delete, then click the <strong>Delete permanently</strong> button. Clicking the <strong>Cancel</strong> button takes you back to viewing your media.')])).str() +
					'</p>' }]),
		])
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'attachment-details' },
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Attachment Details'),
				]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
					(rt.call_function('__', [rt.new_string('Clicking an item will display an Attachment Details dialog, which allows you to preview media and make quick edits. Any changes you make to the attachment details will be automatically saved.')])).str() +
					'</p>' + '<p>' +
					(rt.call_function('__', [rt.new_string('Use the arrow buttons at the top of the dialog, or the left and right arrow keys on your keyboard, to navigate between media items quickly.')])).str() +
					'</p>' + '<p>' +
					(rt.call_function('__', [rt.new_string('You can also delete individual items and access the extended edit screen from the details dialog.')])).str() +
					'</p>' }]),
		])
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
			rt.new_string('<p><strong>' +
				(rt.call_function('__', [rt.new_string('For more information:')])).str() +
				'</strong></p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/media-library-screen/">Documentation on Media Library</a>')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
				'</p>'),
		])
		mut var_title := rt.call_function('__', [rt.new_string('Media Library')])
		mut var_parent_file := 'upload.php'
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_admin_search_query', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('upload_files'),
		]))
		{
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [
				rt.call_function('admin_url', [rt.new_string('media-new.php')]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Add Media File')]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if !(!rt.is_true(var_message)) {
			rt.call_function('wp_admin_notice', [var_message.clone(),
				rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' },
					rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'updated' },
					]) }, rt.ArrayItem{ key: 'dismissible', val: true }])])
		}
		mut var_js_required_message := rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The grid view for the Media Library requires JavaScript. <a href="%s">Switch to the list view</a>.'),
			]),
			rt.new_string('upload.php?mode=list'),
		])
		rt.call_function('wp_admin_notice', [var_js_required_message.clone(),
			rt.create_array([
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'error' },
					rt.ArrayItem{ key: none, val: 'hide-if-js' },
				]) },
			])])
		// unsupported statement: Stmt_InlineHTML
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
		exit(0)
	}
	mut var_wp_list_table := rt.call_function('_get_list_table', [
		rt.new_string('WP_Media_List_Table'),
	])
	mut var_pagenum := rt.call_method(var_wp_list_table, 'get_pagenum', []rt.PhpVal{})
	mut var_doaction := rt.call_method(var_wp_list_table, 'current_action', []rt.PhpVal{})
	if rt.is_true(var_doaction) {
		rt.call_function('check_admin_referer', [rt.new_string('bulk-media')])
		mut var_post_ids := rt.new_array()
		if rt.is_true(rt.identical(rt.new_string('delete_all'), var_doaction)) {
			var_post_ids = rt.call_method(var_wpdb, 'get_col', [
				rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb,
					'posts')),
					rt.new_string(" WHERE post_type='attachment' AND post_status = 'trash'")),
			])
			var_doaction = rt.new_string('delete')
		} else if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('media')) {
			var_post_ids = rt.get_superglobal('_REQUEST').array_get(rt.new_string('media'))
		} else if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('ids')) {
			var_post_ids = rt.call_function('explode', [rt.new_string(','),
				rt.get_superglobal('_REQUEST').array_get(rt.new_string('ids'))])
		}
		var_post_ids = rt.call_function('array_map', [rt.new_string('intval'),
			rt.cast_array(var_post_ids)])
		mut var_location := rt.new_string('upload.php')
		mut var_referer := rt.call_function('wp_get_referer', []rt.PhpVal{})
		if rt.is_true(var_referer) {
			if rt.is_true(rt.call_function('str_contains', [var_referer.clone(),
				rt.new_string('upload.php')]))
			{
				var_location = rt.call_function('remove_query_arg', [
					rt.create_array([rt.ArrayItem{ key: none, val: 'trashed' },
						rt.ArrayItem{ key: none, val: 'untrashed' },
						rt.ArrayItem{ key: none, val: 'deleted' },
						rt.ArrayItem{ key: none, val: 'message' },
						rt.ArrayItem{ key: none, val: 'ids' },
						rt.ArrayItem{ key: none, val: 'posted' }]),
					var_referer.clone(),
				])
			}
		}
		mut switch_val_1 := var_doaction
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('detach'))) {
			rt.call_function('wp_media_attach_action', [
				rt.get_superglobal('_REQUEST').array_get(rt.new_string('parent_post_id')),
				rt.new_string('detach'),
			])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('attach'))) {
			rt.call_function('wp_media_attach_action', [
				rt.get_superglobal('_REQUEST').array_get(rt.new_string('found_post_id')),
			])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('trash'))) {
			if !rt.is_true(var_post_ids) {
			}
			mut iter_2 := var_post_ids.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_post_id := item_2.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
					rt.new_string('delete_post'),
					var_post_id.clone(),
				])))))
				{
					rt.call_function('wp_die', [
						rt.call_function('__', [
							rt.new_string('Sorry, you are not allowed to move this item to the Trash.'),
						]),
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
					])
				}
			}
			var_location = rt.call_function('add_query_arg', [
				rt.create_array([
					rt.ArrayItem{ key: 'trashed', val: var_post_ids.clone().array_count() },
					rt.ArrayItem{ key: 'ids', val: rt.call_function('implode', [
						rt.new_string(','),
						var_post_ids.clone(),
					]) },
				]),
				var_location.clone(),
			])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('untrash'))) {
			if !rt.is_true(var_post_ids) {
			}
			mut iter_3 := var_post_ids.iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_post_id := item_3.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
					rt.new_string('delete_post'),
					var_post_id.clone(),
				])))))
				{
					rt.call_function('wp_die', [
						rt.call_function('__', [
							rt.new_string('Sorry, you are not allowed to restore this item from the Trash.'),
						]),
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
					])
				}
			}
			var_location = rt.call_function('add_query_arg', [
				rt.new_string('untrashed'), rt.new_int(var_post_ids.clone().array_count()),
				var_location.clone()])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete'))) {
			if !rt.is_true(var_post_ids) {
			}
			mut iter_4 := var_post_ids.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_post_id_del := item_4.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
					rt.new_string('delete_post'),
					var_post_id_del.clone(),
				])))))
				{
					rt.call_function('wp_die', [
						rt.call_function('__', [
							rt.new_string('Sorry, you are not allowed to delete this item.'),
						]),
					])
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_delete_attachment', [
					var_post_id_del.clone(),
				])))))
				{
					rt.call_function('wp_die', [
						rt.call_function('__', [
							rt.new_string('Error in deleting the attachment.'),
						]),
					])
				}
			}
			var_location = rt.call_function('add_query_arg', [
				rt.new_string('deleted'), rt.new_int(var_post_ids.clone().array_count()),
				var_location.clone()])
		} else {
			mut var_screen :=
				rt.get_property(rt.call_function('get_current_screen', []rt.PhpVal{}), 'id')
			var_location = rt.call_function('apply_filters', [
				rt.new_string('handle_bulk_actions-${var_screen.to_string()}'),
				var_location.clone(),
				var_doaction.clone(),
				var_post_ids.clone(),
			])
		}
		rt.call_function('wp_redirect', [var_location.clone()])
		exit(0)
	} else if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('_wp_http_referer')))) {
		rt.call_function('wp_redirect', [
			rt.call_function('remove_query_arg', [
				rt.create_array([rt.ArrayItem{ key: none, val: '_wp_http_referer' },
					rt.ArrayItem{ key: none, val: '_wpnonce' }]),
				rt.call_function('wp_unslash',
					[rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))]),
			]),
		])
		exit(0)
	}
	rt.call_method(var_wp_list_table, 'prepare_items', []rt.PhpVal{})
	var_title = rt.call_function('__', [rt.new_string('Media Library')])
	var_parent_file = 'upload.php'
	rt.call_function('wp_enqueue_script', [rt.new_string('media')])
	rt.call_function('add_screen_option', [rt.new_string('per_page')])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('All the files you&#8217;ve uploaded are listed in the Media Library, with the most recent uploads listed first. You can use the Screen Options tab to customize the display of this screen.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('You can narrow the list by file type/status or by date using the dropdown menus above the media table.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('You can view your media in a simple visual grid or a list with columns. Switch between these views using the icons to the left above the media.')])).str() +
				'</p>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'actions-links' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Available Actions'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('Hovering over a row reveals action links that allow you to manage media items. You can perform the following actions:')])).str() +
				'</p>' + '<ul>' + '<li>' +
				(rt.call_function('__', [rt.new_string('<strong>Edit</strong> takes you to a simple screen to edit that individual file&#8217;s metadata. You can also reach that screen by clicking on the media file name or thumbnail.')])).str() +
				'</li>' + '<li>' +
				(rt.call_function('__', [rt.new_string('<strong>Delete Permanently</strong> will delete the file from the media library (as well as from any posts to which it is currently attached).')])).str() +
				'</li>' + '<li>' +
				(rt.call_function('__', [rt.new_string('<strong>View</strong> will take you to a public display page for that file.')])).str() +
				'</li>' + '<li>' +
				(rt.call_function('__', [rt.new_string('<strong>Copy URL</strong> copies the URL for the media file to your clipboard.')])).str() +
				'</li>' + '<li>' +
				(rt.call_function('__', [rt.new_string('<strong>Download file</strong> downloads the original media file to your device.')])).str() +
				'</li>' + '</ul>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'attaching-files' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Attaching Files'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('If a media file has not been attached to any content, you will see that in the Uploaded To column, and can click on Attach to launch a small popup that will allow you to search for existing content and attach the file.')])).str() +
				'</p>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/media-library-screen/">Documentation on Media Library</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>'),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}),
		'set_screen_reader_content', [
		rt.create_array([
			rt.ArrayItem{ key: 'heading_views', val: rt.call_function('__', [
				rt.new_string('Filter media items list'),
			]) },
			rt.ArrayItem{ key: 'heading_pagination', val: rt.call_function('__', [
				rt.new_string('Media items list navigation'),
			]) },
			rt.ArrayItem{ key: 'heading_list', val: rt.call_function('__', [
				rt.new_string('Media items list'),
			]) },
		]),
	])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('upload_files')])) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('admin_url', [rt.new_string('media-new.php')]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Add Media File')]))
		// unsupported statement: Stmt_InlineHTML
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('s'))
		&& rt.is_true(rt.new_int(rt.get_superglobal('_REQUEST').array_get(rt.new_string('s')).to_string().len)) {
		print('<span class="subtitle">')
		rt.call_function('printf', [
			rt.call_function('__', [rt.new_string('Search results for: %s')]),
			rt.new_string('<strong>' + (rt.call_function('get_search_query', []rt.PhpVal{})).str() +
				'</strong>'),
		])
		print('</span>')
	}
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_message)) {
		rt.call_function('wp_admin_notice', [var_message.clone(),
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'updated' },
				]) }, rt.ArrayItem{ key: 'dismissible', val: true }])])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_wp_list_table, 'views', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_wp_list_table, 'display', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('find_posts_div', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
