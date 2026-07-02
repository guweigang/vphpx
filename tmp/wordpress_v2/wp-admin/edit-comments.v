import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_wpdb := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_messages := []rt.PhpVal{}
	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_posts'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.new_string('<h1>' +
				(rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() +
				'</h1>' + '<p>' +
				(rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit comments.')])).str() +
				'</p>'),
			rt.new_int(403),
		])
	}
	mut var_wp_list_table := rt.call_function('_get_list_table', [
		rt.new_string('WP_Comments_List_Table'),
	])
	mut var_pagenum := rt.call_method(var_wp_list_table, 'get_pagenum', []rt.PhpVal{})
	mut var_doaction := rt.call_method(var_wp_list_table, 'current_action', []rt.PhpVal{})
	if rt.is_true(var_doaction) {
		rt.call_function('check_admin_referer', [rt.new_string('bulk-comments')])
		if rt.is_true(rt.identical(rt.new_string('delete_all'), var_doaction))
			&& !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('pagegen_timestamp')))) {
			mut var_comment_status := rt.call_function('wp_unslash', [
				rt.get_superglobal('_REQUEST').array_get(rt.new_string('comment_status')),
			])
			mut var_delete_time := rt.call_function('wp_unslash', [
				rt.get_superglobal('_REQUEST').array_get(rt.new_string('pagegen_timestamp')),
			])
			mut var_comment_ids := rt.call_method(var_wpdb, 'get_col', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.concat(rt.concat(rt.new_string('SELECT comment_ID FROM '), rt.get_property(var_wpdb,
						'comments')),
						rt.new_string('\n\t\t\t\tWHERE comment_approved = %s AND %s > comment_date_gmt')),
					var_comment_status.clone(),
					var_delete_time.clone(),
				]),
			])
			var_doaction = rt.new_string('delete')
		} else if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('delete_comments')) {
			var_comment_ids =
				rt.get_superglobal('_REQUEST').array_get(rt.new_string('delete_comments'))
			var_doaction = rt.get_superglobal('_REQUEST').array_get(rt.new_string('action'))
		} else if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('ids')) {
			var_comment_ids = rt.call_function('array_map', [
				rt.new_string('absint'),
				rt.call_function('explode', [
					rt.new_string(','), rt.get_superglobal('_REQUEST').array_get(rt.new_string('ids'))])])
		} else if rt.is_true(rt.call_function('wp_get_referer', []rt.PhpVal{})) {
			rt.call_function('wp_safe_redirect', [
				rt.call_function('wp_get_referer', []rt.PhpVal{}),
			])
			exit(0)
		}
		mut var_approved := rt.new_int(0)
		mut var_unapproved := 0
		mut var_spammed := rt.new_int(0)
		mut var_unspammed := rt.new_int(0)
		mut var_trashed := rt.new_int(0)
		mut var_untrashed := rt.new_int(0)
		mut var_deleted := rt.new_int(0)
		mut var_redirect_to := rt.call_function('remove_query_arg', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'trashed' },
				rt.ArrayItem{ key: none, val: 'untrashed' }, rt.ArrayItem{ key: none, val: 'deleted' },
				rt.ArrayItem{ key: none, val: 'spammed' }, rt.ArrayItem{ key: none, val: 'unspammed' },
				rt.ArrayItem{ key: none, val: 'approved' }, rt.ArrayItem{
					key: none
					val: 'unapproved'
				}, rt.ArrayItem{ key: none, val: 'ids' }]),
			rt.call_function('wp_get_referer', []rt.PhpVal{}),
		])
		var_redirect_to = rt.call_function('add_query_arg', [
			rt.new_string('paged'), var_pagenum.clone(), var_redirect_to.clone()])
		rt.call_function('wp_defer_comment_counting', [rt.new_bool(true)])
		mut iter_1 := var_comment_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_comment_id := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('edit_comment'),
				var_comment_id.clone(),
			])))))
			{
				continue
			}
			mut switch_val_1 := var_doaction
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('approve'))) {
				rt.call_function('wp_set_comment_status', [var_comment_id.clone(),
					rt.new_string('approve')])
				rt.pre_inc(var_approved)
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('unapprove'))) {
				rt.call_function('wp_set_comment_status', [var_comment_id.clone(),
					rt.new_string('hold')])
				var_unapproved += 1
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('spam'))) {
				rt.call_function('wp_spam_comment', [var_comment_id.clone()])
				rt.pre_inc(var_spammed)
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('unspam'))) {
				rt.call_function('wp_unspam_comment', [var_comment_id.clone()])
				rt.pre_inc(var_unspammed)
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('trash'))) {
				rt.call_function('wp_trash_comment', [var_comment_id.clone()])
				rt.pre_inc(var_trashed)
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('untrash'))) {
				rt.call_function('wp_untrash_comment', [var_comment_id.clone()])
				rt.pre_inc(var_untrashed)
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete'))) {
				rt.call_function('wp_delete_comment', [var_comment_id.clone()])
				rt.pre_inc(var_deleted)
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_doaction.clone(),
			rt.create_array([
				rt.ArrayItem{ key: none, val: 'approve' },
				rt.ArrayItem{ key: none, val: 'unapprove' },
				rt.ArrayItem{ key: none, val: 'spam' },
				rt.ArrayItem{ key: none, val: 'unspam' },
				rt.ArrayItem{ key: none, val: 'trash' },
				rt.ArrayItem{ key: none, val: 'delete' },
			]),
			rt.new_bool(true)])))))
		{
			mut var_screen :=
				rt.get_property(rt.call_function('get_current_screen', []rt.PhpVal{}), 'id')
			var_redirect_to = rt.call_function('apply_filters', [
				rt.new_string('handle_bulk_actions-${var_screen.to_string()}'),
				var_redirect_to.clone(),
				var_doaction.clone(),
				var_comment_ids.clone(),
			])
		}
		rt.call_function('wp_defer_comment_counting', [rt.new_bool(false)])
		if rt.is_true(var_approved) {
			var_redirect_to = rt.call_function('add_query_arg', [
				rt.new_string('approved'),
				var_approved.clone(),
				var_redirect_to.clone(),
			])
		}
		if var_unapproved != 0 {
			var_redirect_to = rt.call_function('add_query_arg', [
				rt.new_string('unapproved'),
				rt.new_int(var_unapproved).clone(),
				var_redirect_to.clone(),
			])
		}
		if rt.is_true(var_spammed) {
			var_redirect_to = rt.call_function('add_query_arg', [
				rt.new_string('spammed'),
				var_spammed.clone(),
				var_redirect_to.clone(),
			])
		}
		if rt.is_true(var_unspammed) {
			var_redirect_to = rt.call_function('add_query_arg', [
				rt.new_string('unspammed'),
				var_unspammed.clone(),
				var_redirect_to.clone(),
			])
		}
		if rt.is_true(var_trashed) {
			var_redirect_to = rt.call_function('add_query_arg', [
				rt.new_string('trashed'),
				var_trashed.clone(),
				var_redirect_to.clone(),
			])
		}
		if rt.is_true(var_untrashed) {
			var_redirect_to = rt.call_function('add_query_arg', [
				rt.new_string('untrashed'),
				var_untrashed.clone(),
				var_redirect_to.clone(),
			])
		}
		if rt.is_true(var_deleted) {
			var_redirect_to = rt.call_function('add_query_arg', [
				rt.new_string('deleted'),
				var_deleted.clone(),
				var_redirect_to.clone(),
			])
		}
		if rt.is_true(var_trashed) || rt.is_true(var_spammed) {
			var_redirect_to = rt.call_function('add_query_arg', [
				rt.new_string('ids'),
				rt.call_function('implode', [
					rt.new_string(','), var_comment_ids.clone()]),
				var_redirect_to.clone()])
		}
		rt.call_function('wp_safe_redirect', [var_redirect_to.clone()])
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
	rt.call_function('wp_enqueue_script', [rt.new_string('admin-comments')])
	rt.call_function('enqueue_comment_hotkeys_js', []rt.PhpVal{})
	if rt.is_true(var_post_id) {
		mut var_comments_count := rt.call_function('wp_count_comments', [
			var_post_id.clone()])
		mut var_draft_or_post_title := rt.call_function('wp_html_excerpt', [
			rt.call_function('_draft_or_post_title', [var_post_id.clone()]),
			rt.new_int(50),
			rt.new_string('&hellip;'),
		])
		if rt.is_true(rt.greater(rt.get_property(var_comments_count, 'moderated'), rt.new_int(0))) {
			mut var_title := rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Comments (%1$s) on &#8220;%2$s&#8221;'),
				]),
				rt.call_function('number_format_i18n', [
					rt.get_property(var_comments_count, 'moderated'),
				]),
				var_draft_or_post_title.clone(),
			])
		} else {
			var_title = rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Comments on &#8220;%s&#8221;')]),
				var_draft_or_post_title.clone(),
			])
		}
	} else {
		var_comments_count = rt.call_function('wp_count_comments', []rt.PhpVal{})
		if rt.is_true(rt.greater(rt.get_property(var_comments_count, 'moderated'), rt.new_int(0))) {
			var_title = rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Comments (%s)')]),
				rt.call_function('number_format_i18n', [
					rt.get_property(var_comments_count, 'moderated'),
				]),
			])
		} else {
			var_title = rt.call_function('__', [rt.new_string('Comments')])
		}
	}
	rt.call_function('add_screen_option', [rt.new_string('per_page')])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('You can manage comments made on your site similar to the way you manage posts and other content. This screen is customizable in the same ways as other management screens, and you can act on comments using the on-hover action links or the bulk actions.')])).str() +
				'</p>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'moderating-comments' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Moderating Comments'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('A red bar on the left means the comment is waiting for you to moderate it.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('In the <strong>Author</strong> column, in addition to the author&#8217;s name, email address, and site URL, the commenter&#8217;s IP address is shown. Clicking on this link will show you all the comments made from this IP address.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('In the <strong>Comment</strong> column, hovering over any comment gives you options to approve, reply (and approve), quick edit, edit, spam mark, or trash that comment.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('In the <strong>In response to</strong> column, there are three elements. The text is the name of the post that inspired the comment, and links to the post editor for that entry. The View Post link leads to that post on your live site. The small bubble with the number in it shows the number of approved comments that post has received. If there are pending comments, a red notification circle with the number of pending comments is displayed. Clicking the notification circle will filter the comments screen to show only pending comments on that post.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('In the <strong>Submitted on</strong> column, the date and time the comment was left on your site appears. Clicking on the date/time link will take you to that comment on your live site.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('Many people take advantage of keyboard shortcuts to moderate their comments more quickly. Use the link to the side to learn more.')])).str() +
				'</p>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/comments-screen/">Documentation on Comments</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/understand-comment-spam/">Documentation on Comment Spam</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/keyboard-shortcuts-classic-editor/#keyboard-shortcuts-for-comments">Documentation on Keyboard Shortcuts</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>'),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}),
		'set_screen_reader_content', [
		rt.create_array([
			rt.ArrayItem{ key: 'heading_views', val: rt.call_function('__', [
				rt.new_string('Filter comments list'),
			]) },
			rt.ArrayItem{ key: 'heading_pagination', val: rt.call_function('__', [
				rt.new_string('Comments list navigation'),
			]) },
			rt.ArrayItem{ key: 'heading_list', val: rt.call_function('__', [
				rt.new_string('Comments list'),
			]) },
		]),
	])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_post_id) {
		rt.call_function('printf', [
			rt.call_function('__', [rt.new_string('Comments on &#8220;%s&#8221;')]),
			rt.call_function('sprintf', [rt.new_string('<a href="%1$s">%2$s</a>'),
				rt.call_function('get_edit_post_link', [
					var_post_id.clone(),
				]),
				rt.call_function('wp_html_excerpt', [
					rt.call_function('_draft_or_post_title', [
						var_post_id.clone()]),
					rt.new_int(50),
					rt.new_string('&hellip;'),
				])]),
		])
	} else {
		rt.call_function('_e', [rt.new_string('Comments')])
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_post_id) {
		mut var_post_type_object := rt.call_function('get_post_type_object', [
			rt.call_function('get_post_type', [var_post_id.clone()]),
		])
		if rt.is_true(var_post_type_object) {
			rt.call_function('printf', [
				rt.new_string('<a href="%1$s" class="comments-view-item-link">%2$s</a>'),
				rt.call_function('get_permalink', [var_post_id.clone()]),
				rt.get_property(rt.get_property(var_post_type_object, 'labels'), 'view_item'),
			])
		}
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('s'))
		&& rt.is_true(rt.new_int(rt.get_superglobal('_REQUEST').array_get(rt.new_string('s')).to_string().len)) {
		print('<span class="subtitle">')
		rt.call_function('printf', [
			rt.call_function('__', [rt.new_string('Search results for: %s')]),
			rt.new_string('<strong>' +
				(rt.call_function('esc_html', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('s'))])])).str() +
				'</strong>'),
		])
		print('</span>')
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('error')) {
		mut var_error :=
			rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('error'))).to_i64())
		mut var_error_msg := rt.new_string('')
		mut switch_val_2 := var_error
		if rt.is_true(rt.equal(switch_val_2, rt.new_int(1))) {
			var_error_msg = rt.call_function('__', [rt.new_string('Invalid comment ID.')])
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(2))) {
			var_error_msg = rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to edit comments on this post.'),
			])
		}
		if rt.is_true(var_error_msg) {
			rt.call_function('wp_admin_notice', [var_error_msg.clone(),
				rt.create_array([rt.ArrayItem{ key: 'id', val: 'moderated' },
					rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'error' },
					]) }])])
		}
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('approved'))
		|| rt.get_superglobal('_REQUEST').array_isset(rt.new_string('deleted'))
		|| rt.get_superglobal('_REQUEST').array_isset(rt.new_string('trashed'))
		|| rt.get_superglobal('_REQUEST').array_isset(rt.new_string('untrashed'))
		|| rt.get_superglobal('_REQUEST').array_isset(rt.new_string('spammed'))
		|| rt.get_superglobal('_REQUEST').array_isset(rt.new_string('unspammed'))
		|| rt.get_superglobal('_REQUEST').array_isset(rt.new_string('same')) {
		var_approved = rt.new_int((if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('approved'))).is_null() {
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('approved'))
		} else {
			rt.new_int(0)
		}).to_i64())
		var_deleted = rt.new_int((if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('deleted'))).is_null() {
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('deleted'))
		} else {
			rt.new_int(0)
		}).to_i64())
		var_trashed = rt.new_int((if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('trashed'))).is_null() {
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('trashed'))
		} else {
			rt.new_int(0)
		}).to_i64())
		var_untrashed = rt.new_int((if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('untrashed'))).is_null() {
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('untrashed'))
		} else {
			rt.new_int(0)
		}).to_i64())
		var_spammed = rt.new_int((if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('spammed'))).is_null() {
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('spammed'))
		} else {
			rt.new_int(0)
		}).to_i64())
		var_unspammed = rt.new_int((if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('unspammed'))).is_null() {
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('unspammed'))
		} else {
			rt.new_int(0)
		}).to_i64())
		mut var_same := rt.new_int((if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('same'))).is_null() {
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('same'))
		} else {
			rt.new_int(0)
		}).to_i64())
		if rt.is_true(rt.greater(var_approved, rt.new_int(0)))
			|| rt.is_true(rt.greater(var_deleted, rt.new_int(0)))
			|| rt.is_true(rt.greater(var_trashed, rt.new_int(0)))
			|| rt.is_true(rt.greater(var_untrashed, rt.new_int(0)))
			|| rt.is_true(rt.greater(var_spammed, rt.new_int(0)))
			|| rt.is_true(rt.greater(var_unspammed, rt.new_int(0)))
			|| rt.is_true(rt.greater(var_same, rt.new_int(0))) {
			if rt.is_true(rt.greater(var_approved, rt.new_int(0))) {
				var_messages << rt.call_function('sprintf', [
					rt.call_function('_n', [rt.new_string('%s comment approved.'),
						rt.new_string('%s comments approved.'),
						var_approved.clone()]),
					var_approved.clone(),
				])
			}
			if rt.is_true(rt.greater(var_spammed, rt.new_int(0))) {
				mut var_ids := if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('ids'))).is_null() {
					rt.get_superglobal('_REQUEST').array_get(rt.new_string('ids'))
				} else {
					rt.new_int(0)
				}
				var_messages <<
					(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%s comment marked as spam.'), rt.new_string('%s comments marked as spam.'), var_spammed.clone()]), var_spammed.clone()])).str() +(rt.call_function('sprintf', [rt.new_string(' <a href="%1$s">%2$s</a><br />'), rt.call_function('esc_url', [rt.call_function('wp_nonce_url', [rt.new_string('edit-comments.php?doaction=undo&action=unspam&ids=${var_ids.to_string()}'), rt.new_string('bulk-comments')])]), rt.call_function('__', [rt.new_string('Undo')])])).str()
			}
			if rt.is_true(rt.greater(var_unspammed, rt.new_int(0))) {
				var_messages << rt.call_function('sprintf', [
					rt.call_function('_n', [
						rt.new_string('%s comment restored from the spam.'),
						rt.new_string('%s comments restored from the spam.'),
						var_unspammed.clone(),
					]),
					var_unspammed.clone(),
				])
			}
			if rt.is_true(rt.greater(var_trashed, rt.new_int(0))) {
				var_ids = if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('ids'))).is_null() {
					rt.get_superglobal('_REQUEST').array_get(rt.new_string('ids'))
				} else {
					rt.new_int(0)
				}
				var_messages <<
					(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%s comment moved to the Trash.'), rt.new_string('%s comments moved to the Trash.'), var_trashed.clone()]), var_trashed.clone()])).str() +(rt.call_function('sprintf', [rt.new_string(' <a href="%1$s">%2$s</a><br />'), rt.call_function('esc_url', [rt.call_function('wp_nonce_url', [rt.new_string('edit-comments.php?doaction=undo&action=untrash&ids=${var_ids.to_string()}'), rt.new_string('bulk-comments')])]), rt.call_function('__', [rt.new_string('Undo')])])).str()
			}
			if rt.is_true(rt.greater(var_untrashed, rt.new_int(0))) {
				var_messages << rt.call_function('sprintf', [
					rt.call_function('_n', [
						rt.new_string('%s comment restored from the Trash.'),
						rt.new_string('%s comments restored from the Trash.'),
						var_untrashed.clone(),
					]),
					var_untrashed.clone(),
				])
			}
			if rt.is_true(rt.greater(var_deleted, rt.new_int(0))) {
				var_messages << rt.call_function('sprintf', [
					rt.call_function('_n', [
						rt.new_string('%s comment permanently deleted.'),
						rt.new_string('%s comments permanently deleted.'),
						var_deleted.clone(),
					]),
					var_deleted.clone(),
				])
			}
			if rt.is_true(rt.greater(var_same, rt.new_int(0))) {
				mut var_comment := rt.call_function('get_comment', [
					var_same.clone()])
				if rt.is_true(var_comment) {
					mut switch_val_3 := rt.get_property(var_comment, 'comment_approved')
					if rt.is_true(rt.equal(switch_val_3, rt.new_string('1'))) {
						var_messages <<
							(rt.call_function('__', [rt.new_string('This comment is already approved.')])).str() +(rt.call_function('sprintf', [rt.new_string(' <a href="%1$s">%2$s</a>'), rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('comment.php?action=editcomment&c=${var_same.to_string()}')])]), rt.call_function('__', [rt.new_string('Edit comment')])])).str()
					} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('trash'))) {
						var_messages <<
							(rt.call_function('__', [rt.new_string('This comment is already in the Trash.')])).str() +(rt.call_function('sprintf', [rt.new_string(' <a href="%1$s">%2$s</a>'), rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('edit-comments.php?comment_status=trash')])]), rt.call_function('__', [rt.new_string('View Trash')])])).str()
					} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('spam'))) {
						var_messages <<
							(rt.call_function('__', [rt.new_string('This comment is already marked as spam.')])).str() +(rt.call_function('sprintf', [rt.new_string(' <a href="%1$s">%2$s</a>'), rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('comment.php?action=editcomment&c=${var_same.to_string()}')])]), rt.call_function('__', [rt.new_string('Edit comment')])])).str()
					}
				}
			}
			rt.call_function('wp_admin_notice', [
				rt.call_function('implode', [rt.new_string('<br />\n'),
					rt.create_array_from_list(var_messages)]),
				rt.create_array([rt.ArrayItem{ key: 'id', val: 'moderated' },
					rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'updated' },
					]) }, rt.ArrayItem{ key: 'dismissible', val: true }]),
			])
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_wp_list_table, 'views', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_wp_list_table, 'search_box', [
		rt.call_function('__', [rt.new_string('Search Comments')]),
		rt.new_string('comment'),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_post_id) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.new_int(var_post_id.to_i64())]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_comment_status.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('current_time', [rt.new_string('mysql'),
			rt.new_bool(true)]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_wp_list_table, 'get_pagination_arg', [
			rt.new_string('total_items'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_wp_list_table, 'get_pagination_arg', [
			rt.new_string('per_page'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_wp_list_table, 'get_pagination_arg', [
			rt.new_string('page')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('paged')) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.call_function('absint',
				[rt.get_superglobal('_REQUEST').array_get(rt.new_string('paged'))]),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_wp_list_table, 'display', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_comment_reply', [rt.new_string('-1'),
		rt.new_bool(true), rt.new_string('detail')])
	rt.call_function('wp_comment_trashnotice', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
