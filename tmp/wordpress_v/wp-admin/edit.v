import rt


fn main() {
	defer {
		rt.shutdown()
	}

	mut var_typenow := rt.new_null()
	mut var_wpdb := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(var_typenow)))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Invalid post type.')])])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_typenow.dup(), rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'show_ui', val: true }])]), rt.new_bool(true)]))))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit posts in this post type.')])])
	}
	if rt.is_true(rt.identical(rt.new_string('attachment'), var_typenow)) {
		if rt.is_true(rt.call_function('wp_redirect', [rt.call_function('admin_url', [rt.new_string('upload.php')])])) {
			// unsupported expression: Expr_Exit
		}
	}
	// unsupported statement: Stmt_Global
	mut var_post_type := var_typenow
	mut var_post_type_object := rt.call_function('get_post_type_object', [var_post_type.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type_object)))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Invalid post type.')])])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type_object, 'cap'), 'edit_posts')]))))) {
		rt.call_function('wp_die', ['<h1>' + (rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() + '</h1>' + '<p>' + (rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit posts in this post type.')])).str() + '</p>', rt.new_int(403)])
	}
	mut var_wp_list_table := rt.call_function('_get_list_table', [rt.new_string('WP_Posts_List_Table')])
	mut var_pagenum := rt.call_method(var_wp_list_table, 'get_pagenum', []rt.PhpVal{})
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'p' }, rt.ArrayItem{ key: none, val: 'attachment_id' }, rt.ArrayItem{ key: none, val: 'page_id' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var__redirect := item_1.val
			if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(var__redirect))) {
				rt.call_function('wp_redirect', [rt.call_function('admin_url', ['edit-comments.php?p=' + (rt.call_function('absint', [rt.get_superglobal('_REQUEST').array_get(var__redirect)])).str()])])
				// unsupported expression: Expr_Exit
			}
		}
	}
	var__redirect = rt.new_null()
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_parent_file := "edit.php?post_type=${var_post_type.to_string()}"
		mut var_submenu_file := "edit.php?post_type=${var_post_type.to_string()}"
		mut var_post_new_file := "post-new.php?post_type=${var_post_type.to_string()}"
	} else {
		var_parent_file = 'edit.php'
		var_submenu_file = 'edit.php'
		var_post_new_file = 'post-new.php'
	}
	mut var_doaction := rt.call_method(var_wp_list_table, 'current_action', []rt.PhpVal{})
	if rt.is_true(var_doaction) {
		rt.call_function('check_admin_referer', [rt.new_string('bulk-posts')])
		mut var_sendback := rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: 'trashed' }, rt.ArrayItem{ key: none, val: 'untrashed' }, rt.ArrayItem{ key: none, val: 'deleted' }, rt.ArrayItem{ key: none, val: 'locked' }, rt.ArrayItem{ key: none, val: 'ids' }]), rt.call_function('wp_get_referer', []rt.PhpVal{})])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_sendback)))) {
			var_sendback = rt.call_function('admin_url', [rt.new_string(var_parent_file).dup()])
		}
		var_sendback = rt.call_function('add_query_arg', [rt.new_string('paged'), var_pagenum.dup(), var_sendback.dup()])
		if rt.is_true(rt.call_function('str_contains', [var_sendback.dup(), rt.new_string('post.php')])) {
			var_sendback = rt.call_function('admin_url', [rt.new_string(var_post_new_file).dup()])
		}
		mut var_post_ids := rt.new_array()
		if rt.is_true(rt.identical(rt.new_string('delete_all'), var_doaction)) {
			mut var_post_status := rt.call_function('preg_replace', [rt.new_string('/[^a-z0-9_-]+/i'), rt.new_string(''), rt.get_superglobal('_REQUEST').array_get('post_status')])
			if rt.is_true(rt.call_function('get_post_status_object', [var_post_status.dup()])) {
				// unsupported statement: Stmt_Global
				var_post_ids = rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_type=%s AND post_status = %s')), var_post_type.dup(), var_post_status.dup()])])
			}
			var_doaction = rt.new_string(rt.new_string('delete'))
		} else if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('media')) {
			var_post_ids = rt.get_superglobal('_REQUEST').array_get('media')
		} else if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('ids')) {
			var_post_ids = rt.call_function('explode', [rt.new_string(','), rt.get_superglobal('_REQUEST').array_get('ids')])
		} else if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('post'))) {
			var_post_ids = rt.call_function('array_map', [rt.new_string('intval'), rt.get_superglobal('_REQUEST').array_get('post')])
		}
		if !rt.is_true(var_post_ids) {
			rt.call_function('wp_redirect', [var_sendback.dup()])
			// unsupported expression: Expr_Exit
		}
		mut switch_val_1 := var_doaction
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('trash'))) {
			mut var_trashed := 0
			mut var_locked := 0
			{
				mut iter_1 := rt.cast_array(var_post_ids).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_post_id := item_1.val
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_post'), var_post_id.dup()]))))) {
						rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to move this item to the Trash.')])])
					}
					if rt.is_true(rt.call_function('wp_check_post_lock', [var_post_id.dup()])) {
						var_locked += 1
						continue
					}
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_trash_post', [var_post_id.dup()]))))) {
						rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Error in moving the item to Trash.')])])
					}
					var_trashed += 1
				}
			}
			var_sendback = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'trashed', val: var_trashed }, rt.ArrayItem{ key: 'ids', val: rt.call_function('implode', [rt.new_string(','), var_post_ids.dup()]) }, rt.ArrayItem{ key: 'locked', val: var_locked }]), var_sendback.dup()])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('untrash'))) {
			mut var_untrashed := 0
			if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('doaction')) && rt.is_true(rt.identical(rt.new_string('undo'), rt.get_superglobal('_GET').array_get('doaction'))))) {
				rt.call_function('add_filter', [rt.new_string('wp_untrash_post_status'), rt.new_string('wp_untrash_post_set_previous_status'), rt.new_int(10), rt.new_int(3)])
			}
			{
				mut iter_1 := rt.cast_array(var_post_ids).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_post_id := item_1.val
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_post'), var_post_id.dup()]))))) {
						rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to restore this item from the Trash.')])])
					}
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_untrash_post', [var_post_id.dup()]))))) {
						rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Error in restoring the item from Trash.')])])
					}
					var_untrashed += 1
				}
			}
			var_sendback = rt.call_function('add_query_arg', [rt.new_string('untrashed'), rt.new_int(var_untrashed).dup(), var_sendback.dup()])
			rt.call_function('remove_filter', [rt.new_string('wp_untrash_post_status'), rt.new_string('wp_untrash_post_set_previous_status'), rt.new_int(10)])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete'))) {
			mut var_deleted := 0
			{
				mut iter_1 := rt.cast_array(var_post_ids).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_post_id := item_1.val
					mut var_post_del := rt.call_function('get_post', [var_post_id.dup()])
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_post'), var_post_id.dup()]))))) {
						rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete this item.')])])
					}
					if rt.is_true(rt.identical(rt.new_string('attachment'), rt.get_property(var_post_del, 'post_type'))) {
						if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_delete_attachment', [var_post_id.dup()]))))) {
							rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Error in deleting the attachment.')])])
						}
					} else {
						if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_delete_post', [var_post_id.dup()]))))) {
							rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Error in deleting the item.')])])
						}
					}
					var_deleted += 1
				}
			}
			var_sendback = rt.call_function('add_query_arg', [rt.new_string('deleted'), rt.new_int(var_deleted).dup(), var_sendback.dup()])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit'))) {
			if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('bulk_edit')) {
				mut var_done := rt.call_function('bulk_edit_posts', [rt.get_superglobal('_REQUEST').dup()])
				if rt.is_true(rt.new_bool(var_done.dup().is_array())) {
					var_done.array_set('updated', var_done.array_get('updated').array_count())
					var_done.array_set('skipped', var_done.array_get('skipped').array_count())
					var_done.array_set('locked', var_done.array_get('locked').array_count())
					var_sendback = rt.call_function('add_query_arg', [var_done.dup(), var_sendback.dup()])
				}
			}
		} else {
			mut var_screen := rt.get_property(rt.call_function('get_current_screen', []rt.PhpVal{}), 'id')
			var_sendback = rt.call_function('apply_filters', [rt.new_string("handle_bulk_actions-${var_screen.to_string()}"), var_sendback.dup(), var_doaction.dup(), var_post_ids.dup()])
		}
		var_sendback = rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: 'action' }, rt.ArrayItem{ key: none, val: 'action2' }, rt.ArrayItem{ key: none, val: 'tags_input' }, rt.ArrayItem{ key: none, val: 'post_author' }, rt.ArrayItem{ key: none, val: 'comment_status' }, rt.ArrayItem{ key: none, val: 'ping_status' }, rt.ArrayItem{ key: none, val: '_status' }, rt.ArrayItem{ key: none, val: 'post' }, rt.ArrayItem{ key: none, val: 'bulk_edit' }, rt.ArrayItem{ key: none, val: 'post_view' }]), var_sendback.dup()])
		rt.call_function('wp_redirect', [var_sendback.dup()])
		// unsupported expression: Expr_Exit
	} else if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('_wp_http_referer'))) {
		rt.call_function('wp_redirect', [rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: '_wp_http_referer' }, rt.ArrayItem{ key: none, val: '_wpnonce' }]), rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('REQUEST_URI')])])])
		// unsupported expression: Expr_Exit
	}
	rt.call_method(var_wp_list_table, 'prepare_items', []rt.PhpVal{})
	rt.call_function('wp_enqueue_script', [rt.new_string('inline-edit-post')])
	rt.call_function('wp_enqueue_script', [rt.new_string('heartbeat')])
	if rt.is_true(rt.identical(rt.new_string('wp_block'), var_post_type)) {
		rt.call_function('wp_enqueue_script', [rt.new_string('wp-list-reusable-blocks')])
		rt.call_function('wp_enqueue_style', [rt.new_string('wp-list-reusable-blocks')])
	}
	mut var_title := rt.get_property(rt.get_property(var_post_type_object, 'labels'), 'name')
	if rt.is_true(rt.identical(rt.new_string('post'), var_post_type)) {
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview')]) }, rt.ArrayItem{ key: 'content', val: '<p>' + (rt.call_function('__', [rt.new_string('This screen provides access to all of your posts. You can customize the display of this screen to suit your workflow.')])).str() + '</p>' }])])
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'screen-content' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Screen Content')]) }, rt.ArrayItem{ key: 'content', val:  +  + (rt.call_function('__', [])).str() + '</li>' + '<li>' + (rt.call_function('__', [rt.new_string('You can filter the list of posts by post status using the text links above the posts list to only show posts with that status. The default view is to show all posts.')])).str() + '</li>' + '<li>' + (rt.call_function('__', [rt.new_string('You can view posts in a simple title list or with an excerpt using the Screen Options tab.')])).str() + '</li>' + '<li>' + (rt.call_function('__', [rt.new_string('You can refine the list to show only posts in a specific category or from a specific month by using the dropdown menus above the posts list. Click the Filter button after making your selection. You also can refine the list by clicking on the post author, category or tag in the posts list.')])).str() + '</li>' + '</ul>' }])])
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'action-links' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Available Actions')]) }, rt.ArrayItem{ key: 'content', val:  + ().str() + '</li>' + '<li>' + (rt.call_function('__', [rt.new_string('<strong>Quick Edit</strong> provides inline access to the metadata of your post, allowing you to update post details without leaving this screen.')])).str() + '</li>' + '<li>' + (rt.call_function('__', [rt.new_string('<strong>Trash</strong> removes your post from this list and places it in the Trash, from which you can permanently delete it.')])).str() + '</li>' + '<li>' + (rt.call_function('__', [rt.new_string('<strong>Preview</strong> will show you what your draft post will look like if you publish it. View will take you to your live site to view the post. Which link is available depends on your post&#8217;s status.')])).str() + '</li>' + '</ul>' }])])
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'bulk-actions' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Bulk actions')]) }, rt.ArrayItem{ key: 'content', val: '<p>' + (rt.call_function('__', [rt.new_string('You can also edit or move multiple posts to the Trash at once. Select the posts you want to act on using the checkboxes, then select the action you want to take from the Bulk actions menu and click Apply.')])).str() + '</p>' + '<p>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('When using Bulk Edit, you can change the metadata (categories, author, etc.) for all selected posts at once. To remove a post from the grouping, just click the %s<span class="screen-reader-text">remove</span> button next to its name in the Bulk Edit area that appears.')]), rt.new_string('<span class="dashicons dashicons-dismiss" aria-hidden="true" style="font-size: 16px; width: 16px; vertical-align: middle;"></span>')])).str() + '</p>' }])])
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', ['<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/posts-screen/">Documentation on Managing Posts</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() + '</p>'])
	} else if rt.is_true(rt.identical(rt.new_string('page'), var_post_type)) {
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview')]) }, rt.ArrayItem{ key: 'content', val: '<p>' + (rt.call_function('__', [rt.new_string('Pages are similar to posts in that they have a title, body text, and associated metadata, but they are different in that they are not part of the chronological blog stream, kind of like permanent posts. Pages are not categorized or tagged, but can have a hierarchy. You can nest pages under other pages by making one the &#8220;Parent&#8221; of the other, creating a group of pages.')])).str() + '</p>' }])])
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'managing-pages' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Managing Pages')]) }, rt.ArrayItem{ key: 'content', val: '<p>' + (rt.call_function('__', [rt.new_string('Managing pages is very similar to managing posts, and the screens can be customized in the same way.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('You can also perform the same types of actions, including narrowing the list by using the filters, acting on a page using the action links that appear when you hover over a row, or using the Bulk actions menu to edit the metadata for multiple pages at once.')])).str() + '</p>' }])])
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [ + ().str() + '</strong></p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/pages-screen/">Documentation on Managing Pages</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() + '</p>'])
	}
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_screen_reader_content', [rt.create_array([rt.ArrayItem{ key: 'heading_views', val: rt.get_property(rt.get_property(var_post_type_object, 'labels'), 'filter_items_list') }, rt.ArrayItem{ key: 'heading_pagination', val: rt.get_property(rt.get_property(var_post_type_object, 'labels'), 'items_list_navigation') }, rt.ArrayItem{ key: 'heading_list', val: rt.get_property(rt.get_property(var_post_type_object, 'labels'), 'items_list') }])])
	rt.call_function('add_screen_option', [rt.new_string('per_page'), rt.create_array([rt.ArrayItem{ key: 'default', val: 20 }, rt.ArrayItem{ key: 'option', val: 'edit_' + (var_post_type).str() + '_per_page' }])])
	mut var_bulk_counts := rt.create_array([rt.ArrayItem{ key: 'updated', val: if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('updated')) { rt.call_function('absint', [rt.get_superglobal('_REQUEST').array_get('updated')]) } else { rt.new_int(0) } }, rt.ArrayItem{ key: 'locked', val: if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('locked')) { rt.call_function('absint', [rt.get_superglobal('_REQUEST').array_get('locked')]) } else { rt.new_int(0) } }, rt.ArrayItem{ key: 'deleted', val: if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('deleted')) { rt.call_function('absint', [rt.get_superglobal('_REQUEST').array_get('deleted')]) } else { rt.new_int(0) } }, rt.ArrayItem{ key: 'trashed', val: if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('trashed')) { rt.call_function('absint', [rt.get_superglobal('_REQUEST').array_get('trashed')]) } else { rt.new_int(0) } }, rt.ArrayItem{ key: 'untrashed', val: if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('untrashed')) { rt.call_function('absint', [rt.get_superglobal('_REQUEST').array_get('untrashed')]) } else { rt.new_int(0) } }])
	mut var_bulk_messages := rt.new_array()
	var_bulk_messages.array_set('post', rt.create_array([rt.ArrayItem{ key: 'updated', val: rt.call_function('_n', [rt.new_string('%s post updated.'), rt.new_string('%s posts updated.'), var_bulk_counts.array_get('updated')]) }, rt.ArrayItem{ key: 'locked', val: if rt.is_true(rt.identical(rt.new_int(1), .array_get())) { rt.call_function('__', [rt.new_string('1 post not updated, somebody is editing it.')]) } else { rt.call_function('_n', [rt.new_string('%s post not updated, somebody is editing it.'), rt.new_string('%s posts not updated, somebody is editing them.'), .array_get()]) } }, rt.ArrayItem{ key: 'deleted', val: rt.call_function('_n', [rt.new_string('%s post permanently deleted.'), rt.new_string('%s posts permanently deleted.'), var_bulk_counts.array_get('deleted')]) }, rt.ArrayItem{ key: 'trashed', val: rt.call_function('_n', [rt.new_string('%s post moved to the Trash.'), rt.new_string('%s posts moved to the Trash.'), var_bulk_counts.array_get('trashed')]) }, rt.ArrayItem{ key: 'untrashed', val: rt.call_function('_n', [rt.new_string('%s post restored from the Trash.'), rt.new_string('%s posts restored from the Trash.'), var_bulk_counts.array_get('untrashed')]) }]))
	var_bulk_messages.array_set('page', rt.create_array([rt.ArrayItem{ key: 'updated', val: rt.call_function('_n', [rt.new_string('%s page updated.'), rt.new_string('%s pages updated.'), .array_get()]) }, rt.ArrayItem{ key: 'locked', val: if rt.is_true(rt.identical(, )) { rt.call_function('__', []) } else { rt.call_function('_n', [, , ]) } }, rt.ArrayItem{ key: 'deleted', val: rt.call_function('_n', [rt.new_string('%s page permanently deleted.'), rt.new_string('%s pages permanently deleted.'), .array_get()]) }, rt.ArrayItem{ key: 'trashed', val: rt.call_function('_n', [rt.new_string('%s page moved to the Trash.'), rt.new_string('%s pages moved to the Trash.'), .array_get()]) }, rt.ArrayItem{ key: 'untrashed', val: rt.call_function('_n', [rt.new_string('%s page restored from the Trash.'), rt.new_string('%s pages restored from the Trash.'), .array_get()]) }]))
	var_bulk_messages.array_set('wp_block', rt.create_array([rt.ArrayItem{ key: 'updated', val: rt.call_function('_n', [, , ]) }, rt.ArrayItem{ key: 'locked', val: if rt.is_true() {  } else {  } }, rt.ArrayItem{ key: 'deleted', val: rt.call_function('_n', [, , ]) }, rt.ArrayItem{ key: 'trashed', val: rt.call_function('_n', [, , ]) }, rt.ArrayItem{ key: 'untrashed', val: rt.call_function('_n', [, , ]) }]))
	var_bulk_messages = rt.call_function('apply_filters', [, .dup(), .dup()])
	var_bulk_counts = 
	
}
