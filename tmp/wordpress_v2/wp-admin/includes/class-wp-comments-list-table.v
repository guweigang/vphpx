import rt

struct Class_WP_Comments_List_Table {
	rt.PhpObjectBase
pub mut:
	checkbox      rt.PhpVal = rt.new_bool(true)
	pending_count rt.PhpVal = rt.new_array()
	extra_items   rt.PhpVal = rt.new_null()
	user_can      rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Comments_List_Table) construct(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	mut var_post_id := rt.get_superglobal('post_id')
	var_post_id = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('p')) { rt.call_function('absint', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('p')),
		]) } else { rt.new_int(0) }
	if rt.is_true(rt.call_function('get_option', [rt.new_string('show_avatars')])) {
		rt.call_function('add_filter', [rt.new_string('comment_author'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_Comments_List_Table', [
					'WP_List_Table',
				], &this) },
				rt.ArrayItem{ key: none, val: 'floated_admin_avatar' },
			]),
			rt.new_int(10), rt.new_int(2)])
	}
	this.Class_WP_List_Table.construct(rt.create_array([
		rt.ArrayItem{ key: 'plural', val: 'comments' },
		rt.ArrayItem{ key: 'singular', val: 'comment' },
		rt.ArrayItem{ key: 'ajax', val: true },
		rt.ArrayItem{
			key: 'screen'
			val: if !(var_args_mutated.array_get(rt.new_string('screen'))).is_null() {
				var_args_mutated.array_get(rt.new_string('screen'))
			} else {
				rt.new_null()
			}
		},
	]))
}

fn (mut this Class_WP_Comments_List_Table) floated_admin_avatar(var_name rt.PhpVal, var_comment_id rt.PhpVal) string {
	mut var_name_mutated := var_name
	mut var_comment := rt.call_function('get_comment', [var_comment_id.clone()])
	mut var_avatar := rt.call_function('get_avatar', [var_comment.clone(),
		rt.new_int(32), rt.new_string('mystery')])
	return '${var_avatar.to_string()} ${var_name.to_string()}'
}

fn (mut this Class_WP_Comments_List_Table) ajax_user_can() rt.PhpVal {
	return rt.call_function('current_user_can', [rt.new_string('edit_posts')])
}

fn (mut this Class_WP_Comments_List_Table) prepare_items() {
	mut var_post_id := rt.new_null()
	mut var_mode := rt.get_superglobal('mode')
	mut var_comment_status := rt.get_superglobal('comment_status')
	mut var_comment_type := rt.get_superglobal('comment_type')
	mut var_search := rt.get_superglobal('search')
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('mode')))) {
		var_mode = rt.new_string((if rt.is_true(rt.identical(rt.new_string('excerpt'),
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('mode'))))
		{
			'excerpt'
		} else {
			'list'
		}).str())
		rt.call_function('set_user_setting', [rt.new_string('posts_list_mode'),
			var_mode.clone()])
	} else {
		var_mode = rt.call_function('get_user_setting', [
			rt.new_string('posts_list_mode'),
			rt.new_string('list'),
		])
	}
	var_comment_status = if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('comment_status'))).is_null() {
		rt.get_superglobal('_REQUEST').array_get(rt.new_string('comment_status'))
	} else {
		rt.new_string('all')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_comment_status.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'all' },
			rt.ArrayItem{ key: none, val: 'mine' },
			rt.ArrayItem{ key: none, val: 'moderated' },
			rt.ArrayItem{ key: none, val: 'approved' },
			rt.ArrayItem{ key: none, val: 'spam' },
			rt.ArrayItem{ key: none, val: 'trash' },
		]),
		rt.new_bool(true)])))))
	{
		var_comment_status = rt.new_string('all')
	}
	var_comment_type = rt.new_string('')
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('comment_type'))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('note'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('comment_type')))))) {
		var_comment_type = rt.get_superglobal('_REQUEST').array_get(rt.new_string('comment_type'))
	}
	var_search = if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('s'))).is_null() {
		rt.get_superglobal('_REQUEST').array_get(rt.new_string('s'))
	} else {
		rt.new_string('')
	}
	mut var_post_type := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('post_type')) { rt.call_function('sanitize_key', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_type')),
		]) } else { rt.new_string('') }
	mut var_user_id := if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('user_id'))).is_null() {
		rt.get_superglobal('_REQUEST').array_get(rt.new_string('user_id'))
	} else {
		rt.new_string('')
	}
	mut var_orderby := if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('orderby'))).is_null() {
		rt.get_superglobal('_REQUEST').array_get(rt.new_string('orderby'))
	} else {
		rt.new_string('')
	}
	mut var_order := if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('order'))).is_null() {
		rt.get_superglobal('_REQUEST').array_get(rt.new_string('order'))
	} else {
		rt.new_string('')
	}
	mut var_comments_per_page := this.get_per_page(var_comment_status.str())
	mut var_doing_ajax := rt.call_function('wp_doing_ajax', []rt.PhpVal{})
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('number')) {
		mut var_number :=
			rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('number'))).to_i64())
	} else {
		var_number = rt.add(var_comments_per_page, rt.call_function('min', [
			rt.new_int(8),
			var_comments_per_page.clone(),
		]))
	}
	mut var_page := this.get_pagenum()
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('start')) {
		mut var_start := rt.get_superglobal('_REQUEST').array_get(rt.new_string('start'))
	} else {
		var_start = rt.mul(rt.sub(var_page, rt.new_int(1)), var_comments_per_page)
	}
	if rt.is_true(var_doing_ajax)
		&& rt.get_superglobal('_REQUEST').array_isset(rt.new_string('offset')) {
		var_start = rt.add(var_start,
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('offset')))
	}
	mut var_status_map := rt.create_array([rt.ArrayItem{ key: 'mine', val: '' },
		rt.ArrayItem{ key: 'moderated', val: 'hold' }, rt.ArrayItem{ key: 'approved', val: 'approve' },
		rt.ArrayItem{ key: 'all', val: '' }])
	mut var_args := rt.create_array([
		rt.ArrayItem{
			key: 'status'
			val: if !(var_status_map.array_get(var_comment_status)).is_null() {
				var_status_map.array_get(var_comment_status)
			} else {
				var_comment_status
			}
		},
		rt.ArrayItem{ key: 'search', val: var_search },
		rt.ArrayItem{ key: 'user_id', val: var_user_id },
		rt.ArrayItem{ key: 'offset', val: var_start },
		rt.ArrayItem{ key: 'number', val: var_number },
		rt.ArrayItem{ key: 'post_id', val: var_post_id },
		rt.ArrayItem{ key: 'type', val: var_comment_type },
		rt.ArrayItem{ key: 'type__not_in', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'note' },
		]) },
		rt.ArrayItem{ key: 'orderby', val: var_orderby },
		rt.ArrayItem{ key: 'order', val: var_order },
		rt.ArrayItem{ key: 'post_type', val: var_post_type },
		rt.ArrayItem{ key: 'update_comment_post_cache', val: true },
	])
	var_args = rt.call_function('apply_filters', [
		rt.new_string('comments_list_table_query_args'),
		var_args.clone(),
	])
	mut var__comments := rt.call_function('get_comments', [var_args.clone()])
	if rt.is_true(rt.new_bool(var__comments.clone().is_array())) {
		this.dispatch_set_prop('items', rt.call_function('array_slice', [
			var__comments.clone(), rt.new_int(0), var_comments_per_page.clone()]))
		this.extra_items = rt.call_function('array_slice', [var__comments.clone(),
			var_comments_per_page.clone()])
		mut var__comment_post_ids := rt.call_function('array_unique', [
			rt.call_function('wp_list_pluck', [var__comments.clone(),
				rt.new_string('comment_post_ID')]),
		])
		this.pending_count = rt.call_function('get_pending_comments_num', [
			var__comment_post_ids.clone()])
	}
	mut var_total_comments := rt.call_function('get_comments', [
		rt.call_function('array_merge', [var_args.clone(),
			rt.create_array([rt.ArrayItem{ key: 'count', val: true },
				rt.ArrayItem{ key: 'offset', val: 0 }, rt.ArrayItem{ key: 'number', val: 0 },
				rt.ArrayItem{ key: 'orderby', val: 'none' }])]),
	])
	this.set_pagination_args(rt.create_array([
		rt.ArrayItem{ key: 'total_items', val: var_total_comments },
		rt.ArrayItem{ key: 'per_page', val: var_comments_per_page },
	]))
}

fn (mut this Class_WP_Comments_List_Table) get_per_page(comment_status string) rt.PhpVal {
	mut comment_status_mutated := comment_status
	mut var_comments_per_page := this.get_items_per_page(rt.new_string('edit_comments_per_page'))
	return rt.call_function('apply_filters', [rt.new_string('comments_per_page'),
		var_comments_per_page.clone(), rt.new_string(comment_status_mutated).clone()])
}

fn (mut this Class_WP_Comments_List_Table) no_items() {
	mut var_comment_status := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('moderated'), var_comment_status)) {
		rt.call_function('_e', [rt.new_string('No comments awaiting moderation.')])
	} else if rt.is_true(rt.identical(rt.new_string('trash'), var_comment_status)) {
		rt.call_function('_e', [rt.new_string('No comments found in Trash.')])
	} else {
		rt.call_function('_e', [rt.new_string('No comments found.')])
	}
}

fn (mut this Class_WP_Comments_List_Table) get_views() rt.PhpVal {
	mut var_post_id := rt.new_null()
	mut var_comment_status := rt.new_null()
	mut var_comment_type := rt.new_null()
	mut var_status_links := rt.new_array()
	mut var_num_comments := if rt.is_true(var_post_id) { rt.call_function('wp_count_comments', [
			var_post_id.clone(),
		]) } else { rt.call_function('wp_count_comments', []rt.PhpVal{}) }
	mut var_statuses := {
		'all':       rt.call_function('_nx_noop', [
			rt.new_string('All <span class="count">(%s)</span>'),
			rt.new_string('All <span class="count">(%s)</span>'),
			rt.new_string('comments'),
		])
		'mine':      rt.call_function('_nx_noop', [
			rt.new_string('Mine <span class="count">(%s)</span>'),
			rt.new_string('Mine <span class="count">(%s)</span>'),
			rt.new_string('comments'),
		])
		'moderated': rt.call_function('_nx_noop', [
			rt.new_string('Pending <span class="count">(%s)</span>'),
			rt.new_string('Pending <span class="count">(%s)</span>'),
			rt.new_string('comments'),
		])
		'approved':  rt.call_function('_nx_noop', [
			rt.new_string('Approved <span class="count">(%s)</span>'),
			rt.new_string('Approved <span class="count">(%s)</span>'),
			rt.new_string('comments'),
		])
		'spam':      rt.call_function('_nx_noop', [
			rt.new_string('Spam <span class="count">(%s)</span>'),
			rt.new_string('Spam <span class="count">(%s)</span>'),
			rt.new_string('comments'),
		])
		'trash':     rt.call_function('_nx_noop', [
			rt.new_string('Trash <span class="count">(%s)</span>'),
			rt.new_string('Trash <span class="count">(%s)</span>'),
			rt.new_string('comments'),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('EMPTY_TRASH_DAYS'))))) {
		var_statuses.delete('trash')
	}
	mut var_link := rt.call_function('admin_url', [rt.new_string('edit-comments.php')])
	if !(!rt.is_true(var_comment_type))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('all'), var_comment_type)))) {
		var_link = rt.call_function('add_query_arg', [rt.new_string('comment_type'),
			var_comment_type.clone(), var_link.clone()])
	}
	for var_status, var_label in var_statuses {
		if rt.is_true(rt.identical(rt.new_string('mine'), rt.new_string(status))) {
			mut var_current_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
			rt.set_property(var_num_comments, 'mine', rt.call_function('get_comments', [
				rt.create_array([
					rt.ArrayItem{
						key: 'post_id'
						val: if rt.is_true(var_post_id) { var_post_id } else { rt.new_int(0) }
					},
					rt.ArrayItem{ key: 'user_id', val: var_current_user_id },
					rt.ArrayItem{ key: 'count', val: true },
					rt.ArrayItem{ key: 'orderby', val: 'none' },
				]),
			]))
			var_link = rt.call_function('add_query_arg', [rt.new_string('user_id'),
				var_current_user_id.clone(), var_link.clone()])
		} else {
			var_link = rt.call_function('remove_query_arg', [
				rt.new_string('user_id'), var_link.clone()])
		}
		if !(!(rt.get_property(var_num_comments,
			'{"nodeType":"Expr_Variable","line":326,"name":"status"}')).is_null()) {
			rt.set_property(var_num_comments,
				'{"nodeType":"Expr_Variable","line":327,"name":"status"}', rt.new_int(10))
		}
		var_link = rt.call_function('add_query_arg', [rt.new_string('comment_status'),
			rt.new_string(status), var_link.clone()])
		if rt.is_true(var_post_id) {
			var_link = rt.call_function('add_query_arg', [rt.new_string('p'),
				rt.call_function('absint', [var_post_id.clone()]),
				var_link.clone()])
		}
		var_status_links.array_set(status, rt.create_array([
			rt.ArrayItem{ key: 'url', val: rt.call_function('esc_url', [
				var_link.clone()]) },
			rt.ArrayItem{
				key: 'label'
				val: rt.call_function('sprintf', [
					rt.call_function('translate_nooped_plural', [
						var_label.clone(),
						rt.get_property(var_num_comments,
							'{"nodeType":"Expr_Variable","line":345,"name":"status"}')]),
					rt.call_function('sprintf', [rt.new_string('<span class="%s-count">%s</span>'),
						rt.new_string((if rt.is_true(rt.identical(rt.new_string('moderated'),
							rt.new_string(status)))
						{
							'pending'
						} else {
							status
						}).str()),
						rt.call_function('number_format_i18n', [
							rt.get_property(var_num_comments,
								'{"nodeType":"Expr_Variable","line":349,"name":"status"}'),
						])]),
				])
			},
			rt.ArrayItem{ key: 'current', val: rt.identical(rt.new_string(status),
				var_comment_status) },
		]))
	}
	return rt.call_function('apply_filters', [rt.new_string('comment_status_links'),
		this.get_views_links(var_status_links.clone())])
}

fn (mut this Class_WP_Comments_List_Table) get_bulk_actions() rt.PhpVal {
	mut var_comment_status := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('moderate_comments'),
	])))))
	{
		return rt.new_array()
	}
	mut var_actions := rt.new_array()
	if rt.is_true(rt.call_function('in_array', [var_comment_status.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'all' },
			rt.ArrayItem{ key: none, val: 'approved' }]),
		rt.new_bool(true)]))
	{
		var_actions.array_set('unapprove', rt.call_function('__', [
			rt.new_string('Unapprove'),
		]))
	}
	if rt.is_true(rt.call_function('in_array', [var_comment_status.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'all' },
			rt.ArrayItem{ key: none, val: 'moderated' }]),
		rt.new_bool(true)]))
	{
		var_actions.array_set('approve', rt.call_function('__', [
			rt.new_string('Approve'),
		]))
	}
	if rt.is_true(rt.call_function('in_array', [var_comment_status.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'all' },
			rt.ArrayItem{ key: none, val: 'moderated' }, rt.ArrayItem{ key: none, val: 'approved' },
			rt.ArrayItem{ key: none, val: 'trash' }]),
		rt.new_bool(true)]))
	{
		var_actions.array_set('spam', rt.call_function('_x', [
			rt.new_string('Mark as spam'),
			rt.new_string('comment'),
		]))
	}
	if rt.is_true(rt.identical(rt.new_string('trash'), var_comment_status)) {
		var_actions.array_set('untrash', rt.call_function('__', [
			rt.new_string('Restore'),
		]))
	} else if rt.is_true(rt.identical(rt.new_string('spam'), var_comment_status)) {
		var_actions.array_set('unspam', rt.call_function('_x', [
			rt.new_string('Not spam'),
			rt.new_string('comment'),
		]))
	}
	if rt.is_true(rt.call_function('in_array', [var_comment_status.clone(), rt.create_array([rt.ArrayItem{
		key: none
		val: 'trash'
	}, rt.ArrayItem{ key: none, val: 'spam' }]), rt.new_bool(true)]))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('EMPTY_TRASH_DAYS'))))) {
		var_actions.array_set('delete', rt.call_function('__', [
			rt.new_string('Delete permanently'),
		]))
	} else {
		var_actions.array_set('trash', rt.call_function('__', [
			rt.new_string('Move to Trash'),
		]))
	}
	return var_actions.clone()
}

fn (mut this Class_WP_Comments_List_Table) extra_tablenav(var_which rt.PhpVal) {
	mut var_comment_status := rt.new_null()
	mut var_comment_type := rt.new_null()
	mut var_has_items := rt.new_null()
	if !(!var_has_items.is_null()) {
		var_has_items = this.has_items()
	}
	print('<div class="alignleft actions">')
	if rt.is_true(rt.identical(rt.new_string('top'), var_which)) {
		rt.call_function('ob_start', []rt.PhpVal{})
		this.comment_type_dropdown(var_comment_type.clone())
		rt.call_function('do_action', [rt.new_string('restrict_manage_comments')])
		mut var_output := rt.call_function('ob_get_clean', []rt.PhpVal{})
		if !(!rt.is_true(var_output)) && rt.is_true(this.has_items()) {
			rt.echo_val(var_output)
			rt.call_function('submit_button', [
				rt.call_function('__', [rt.new_string('Filter')]),
				rt.new_string(''),
				rt.new_string('filter_action'),
				rt.new_bool(false),
				rt.create_array([rt.ArrayItem{ key: 'id', val: 'post-query-submit' }]),
			])
		}
	}
	if rt.is_true(rt.identical(rt.new_string('spam'), var_comment_status))
		|| rt.is_true(rt.identical(rt.new_string('trash'), var_comment_status))
		&& rt.is_true(var_has_items)
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('moderate_comments')])) {
		rt.call_function('wp_nonce_field', [rt.new_string('bulk-destroy'),
			rt.new_string('_destroy_nonce')])
		mut var_title := if rt.is_true(rt.identical(rt.new_string('spam'), var_comment_status)) { rt.call_function('esc_attr__', [
				rt.new_string('Empty Spam'),
			]) } else { rt.call_function('esc_attr__', [rt.new_string('Empty Trash')]) }
		rt.call_function('submit_button', [var_title.clone(),
			rt.new_string('apply'), rt.new_string('delete_all'),
			rt.new_bool(false)])
	}
	rt.call_function('do_action', [rt.new_string('manage_comments_nav'),
		var_comment_status.clone(), var_which.clone()])
	print('</div>')
}

fn (mut this Class_WP_Comments_List_Table) current_action() string {
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('delete_all'))
		|| rt.get_superglobal('_REQUEST').array_isset(rt.new_string('delete_all2')) {
		return 'delete_all'
	}
	return (this.Class_WP_List_Table.current_action()).str()
}

fn (mut this Class_WP_Comments_List_Table) get_columns() rt.PhpVal {
	mut var_post_id := rt.new_null()
	mut var_columns := rt.new_array()
	if rt.is_true(this.checkbox) {
		var_columns['cb'] = rt.new_string('<input type="checkbox" />')
	}
	var_columns['author'] = rt.call_function('__', [rt.new_string('Author')])
	var_columns['comment'] = rt.call_function('_x', [rt.new_string('Comment'),
		rt.new_string('column name')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
		var_columns['response'] = rt.call_function('__', [
			rt.new_string('In response to'),
		])
	}
	var_columns['date'] = rt.call_function('_x', [rt.new_string('Submitted on'),
		rt.new_string('column name')])
	return var_columns.clone()
}

fn (mut this Class_WP_Comments_List_Table) comment_type_dropdown(var_comment_type rt.PhpVal) {
	mut var_comment_type_mutated := var_comment_type
	mut var_comment_types := rt.call_function('apply_filters', [
		rt.new_string('admin_comment_types_dropdown'),
		rt.create_array([
			rt.ArrayItem{ key: 'comment', val: rt.call_function('__', [
				rt.new_string('Comments'),
			]) },
			rt.ArrayItem{ key: 'pings', val: rt.call_function('__', [
				rt.new_string('Pings'),
			]) },
		]),
	])
	if rt.is_true(var_comment_types) && var_comment_types.clone().is_array() {
		rt.call_function('printf', [
			rt.new_string('<label class="screen-reader-text" for="filter-by-comment-type">%s</label>'),
			rt.call_function('__', [rt.new_string('Filter by comment type')]),
		])
		print('<select id="filter-by-comment-type" name="comment_type">')
		rt.call_function('printf', [rt.new_string("\t<option value=''>%s</option>"),
			rt.call_function('__', [rt.new_string('All comment types')])])
		mut iter_1 := var_comment_types.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_label := item_1.val
			mut var_type := item_1.key
			if rt.is_true(rt.call_function('get_comments', [
				rt.create_array([rt.ArrayItem{ key: 'count', val: true },
					rt.ArrayItem{ key: 'orderby', val: 'none' },
					rt.ArrayItem{ key: 'type', val: var_type }]),
			]))
			{
				rt.call_function('printf', [
					rt.new_string("\t<option value='%s'%s>%s</option>\n"),
					rt.call_function('esc_attr', [var_type.clone()]),
					rt.call_function('selected', [var_comment_type_mutated.clone(),
						var_type.clone(), rt.new_bool(false)]),
					rt.call_function('esc_html', [var_label.clone()]),
				])
			}
		}
		print('</select>')
	}
}

fn (mut this Class_WP_Comments_List_Table) get_sortable_columns() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'author', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'comment_author' },
			rt.ArrayItem{ key: none, val: false },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Author'),
			]) },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Table ordered by Comment Author.'),
			]) },
		]) },
		rt.ArrayItem{ key: 'response', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'comment_post_ID' },
			rt.ArrayItem{ key: none, val: false },
			rt.ArrayItem{ key: none, val: rt.call_function('_x', [
				rt.new_string('In Response To'),
				rt.new_string('column name'),
			]) },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Table ordered by Post Replied To.'),
			]) },
		]) },
		rt.ArrayItem{ key: 'date', val: 'comment_date' },
	])
}

fn (mut this Class_WP_Comments_List_Table) get_default_primary_column_name() string {
	return 'comment'
}

fn (mut this Class_WP_Comments_List_Table) display() {
	rt.call_function('wp_nonce_field', [
		rt.new_string('fetch-list-' +(rt.call_function('get_class', [rt.new_object('WP_Comments_List_Table', ['WP_List_Table'], &this)])).str()),
		rt.new_string('_ajax_fetch_list_nonce'),
	])
	mut var_has_items := rt.new_null()
	if !(!var_has_items.is_null()) {
		var_has_items = this.has_items()
		if rt.is_true(var_has_items) {
			this.display_tablenav(rt.new_string('top'))
		}
	}
	rt.call_method(rt.get_property(rt.new_object('WP_Comments_List_Table', [
		'WP_List_Table',
	], &this), 'screen'), 'render_screen_reader_content', [rt.new_string('heading_list')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('implode', [rt.new_string(' '),
		this.get_table_classes()]))
	// unsupported statement: Stmt_InlineHTML
	if !(rt.get_superglobal('_GET').array_isset(rt.new_string('orderby'))) {
		print('<caption class="screen-reader-text">' +
			(rt.call_function('__', [rt.new_string('Ordered by Comment Date, descending.')])).str() +
			'</caption>')
	} else {
		this.print_table_description()
	}
	// unsupported statement: Stmt_InlineHTML
	this.print_column_headers()
	// unsupported statement: Stmt_InlineHTML
	this.display_rows_or_placeholder()
	// unsupported statement: Stmt_InlineHTML
	mut var_items := rt.get_property(rt.new_object('WP_Comments_List_Table', [
		'WP_List_Table',
	], &this), 'items')
	this.dispatch_set_prop('items', this.extra_items)
	this.display_rows_or_placeholder()
	this.dispatch_set_prop('items', var_items.clone())
	// unsupported statement: Stmt_InlineHTML
	this.print_column_headers(rt.new_bool(false))
	// unsupported statement: Stmt_InlineHTML
	this.display_tablenav(rt.new_string('bottom'))
}

fn (mut this Class_WP_Comments_List_Table) single_row(var_item rt.PhpVal) bool {
	mut var_GLOBALS := rt.new_null()
	mut var_post := rt.get_superglobal('post')
	mut var_comment := rt.get_superglobal('comment')
	var_comment = var_item
	if rt.is_true(rt.greater(rt.get_property(var_comment, 'comment_post_ID'), rt.new_int(0))) {
		var_post = rt.call_function('get_post', [
			rt.get_property(var_comment, 'comment_post_ID'),
		])
	}
	mut var_edit_post_cap := rt.new_string((if rt.is_true(var_post) {
		'edit_post'
	} else {
		'edit_posts'
	}).str())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [var_edit_post_cap.clone(), rt.get_property(var_comment, 'comment_post_ID')])))))
		&& rt.is_true(rt.call_function('post_password_required', [rt.get_property(var_comment, 'comment_post_ID')]))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('read_post'), rt.get_property(var_comment, 'comment_post_ID')]))))) {
		return false
	}
	mut var_the_comment_class := rt.call_function('wp_get_comment_status', [
		var_comment.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_the_comment_class)))) {
		var_the_comment_class = rt.new_string('')
	}
	var_the_comment_class = rt.call_function('implode', [rt.new_string(' '),
		rt.call_function('get_comment_class', [var_the_comment_class.clone(),
			var_comment.clone(), rt.get_property(var_comment, 'comment_post_ID')])])
	this.user_can = rt.call_function('current_user_can', [rt.new_string('edit_comment'),
		rt.get_property(var_comment, 'comment_ID')])
	print(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string("<tr id='comment-"), rt.get_property(var_comment,
		'comment_ID')), rt.new_string("' class='")), var_the_comment_class), rt.new_string("'>")))
	this.single_row_columns(var_comment.clone())
	print('</tr>\n')
	var_GLOBALS.array_unset(rt.new_string('post'))
	var_GLOBALS.array_unset(rt.new_string('comment'))
	return false
}

fn (mut this Class_WP_Comments_List_Table) handle_row_actions(var_item rt.PhpVal, var_column_name rt.PhpVal, var_primary rt.PhpVal) string {
	mut var_comment_status := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_primary, var_column_name)))) {
		return ''
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.user_can)))) {
		return ''
	}
	mut var_comment := var_item
	mut var_the_comment_status := rt.call_function('wp_get_comment_status', [
		var_comment.clone()])
	mut var_output := rt.new_string('')
	mut var_approve_nonce := rt.call_function('esc_html', [
		rt.new_string('_wpnonce=' +
			(rt.call_function('wp_create_nonce', [rt.new_string('approve-comment_' +
			(rt.get_property(var_comment, 'comment_ID')).str())])).str()),
	])
	mut var_del_nonce := rt.call_function('esc_html', [
		rt.new_string('_wpnonce=' +
			(rt.call_function('wp_create_nonce', [rt.new_string('delete-comment_' +
			(rt.get_property(var_comment, 'comment_ID')).str())])).str()),
	])
	mut var_action_string := rt.new_string('comment.php?action=%s&c=' +
		(rt.get_property(var_comment, 'comment_ID')).str() + '&%s')
	mut var_approve_url := rt.call_function('sprintf', [var_action_string.clone(),
		rt.new_string('approvecomment'), var_approve_nonce.clone()])
	mut var_unapprove_url := rt.call_function('sprintf', [var_action_string.clone(),
		rt.new_string('unapprovecomment'), var_approve_nonce.clone()])
	mut var_spam_url := rt.call_function('sprintf', [var_action_string.clone(),
		rt.new_string('spamcomment'), var_del_nonce.clone()])
	mut var_unspam_url := rt.call_function('sprintf', [var_action_string.clone(),
		rt.new_string('unspamcomment'), var_del_nonce.clone()])
	mut var_trash_url := rt.call_function('sprintf', [var_action_string.clone(),
		rt.new_string('trashcomment'), var_del_nonce.clone()])
	mut var_untrash_url := rt.call_function('sprintf', [var_action_string.clone(),
		rt.new_string('untrashcomment'), var_del_nonce.clone()])
	mut var_delete_url := rt.call_function('sprintf', [var_action_string.clone(),
		rt.new_string('deletecomment'), var_del_nonce.clone()])
	mut var_actions := rt.create_array([rt.ArrayItem{ key: 'approve', val: '' },
		rt.ArrayItem{ key: 'unapprove', val: '' }, rt.ArrayItem{ key: 'reply', val: '' },
		rt.ArrayItem{ key: 'quickedit', val: '' }, rt.ArrayItem{ key: 'edit', val: '' },
		rt.ArrayItem{ key: 'spam', val: '' }, rt.ArrayItem{ key: 'unspam', val: '' },
		rt.ArrayItem{ key: 'trash', val: '' }, rt.ArrayItem{ key: 'untrash', val: '' },
		rt.ArrayItem{ key: 'delete', val: '' }])
	if rt.is_true(var_comment_status)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('all'), var_comment_status)))) {
		if rt.is_true(rt.identical(rt.new_string('approved'), var_the_comment_status)) {
			var_actions.array_set('unapprove', rt.call_function('sprintf', [
				rt.new_string('<a href="%s" data-wp-lists="%s" class="vim-u vim-destructive aria-button-if-js" aria-label="%s">%s</a>'),
				rt.call_function('esc_url', [var_unapprove_url.clone()]),
				rt.concat(rt.concat(rt.new_string('delete:the-comment-list:comment-'), rt.get_property(var_comment,
					'comment_ID')), rt.new_string(':e7e7d3:action=dim-comment&amp;new=unapproved')),
				rt.call_function('esc_attr__', [rt.new_string('Unapprove this comment')]),
				rt.call_function('__', [rt.new_string('Unapprove')]),
			]))
		} else if rt.is_true(rt.identical(rt.new_string('unapproved'), var_the_comment_status)) {
			var_actions.array_set('approve', rt.call_function('sprintf', [
				rt.new_string('<a href="%s" data-wp-lists="%s" class="vim-a vim-destructive aria-button-if-js" aria-label="%s">%s</a>'),
				rt.call_function('esc_url', [var_approve_url.clone()]),
				rt.concat(rt.concat(rt.new_string('delete:the-comment-list:comment-'), rt.get_property(var_comment,
					'comment_ID')), rt.new_string(':e7e7d3:action=dim-comment&amp;new=approved')),
				rt.call_function('esc_attr__', [rt.new_string('Approve this comment')]),
				rt.call_function('__', [rt.new_string('Approve')]),
			]))
		}
	} else {
		var_actions.array_set('approve', rt.call_function('sprintf', [
			rt.new_string('<a href="%s" data-wp-lists="%s" class="vim-a aria-button-if-js" aria-label="%s">%s</a>'),
			rt.call_function('esc_url', [var_approve_url.clone()]),
			rt.concat(rt.concat(rt.new_string('dim:the-comment-list:comment-'), rt.get_property(var_comment,
				'comment_ID')), rt.new_string(':unapproved:e7e7d3:e7e7d3:new=approved')),
			rt.call_function('esc_attr__', [rt.new_string('Approve this comment')]),
			rt.call_function('__', [rt.new_string('Approve')]),
		]))
		var_actions.array_set('unapprove', rt.call_function('sprintf', [
			rt.new_string('<a href="%s" data-wp-lists="%s" class="vim-u aria-button-if-js" aria-label="%s">%s</a>'),
			rt.call_function('esc_url', [var_unapprove_url.clone()]),
			rt.concat(rt.concat(rt.new_string('dim:the-comment-list:comment-'), rt.get_property(var_comment,
				'comment_ID')), rt.new_string(':unapproved:e7e7d3:e7e7d3:new=unapproved')),
			rt.call_function('esc_attr__', [rt.new_string('Unapprove this comment')]),
			rt.call_function('__', [rt.new_string('Unapprove')]),
		]))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('spam'),
		var_the_comment_status))))
	{
		var_actions.array_set('spam', rt.call_function('sprintf', [
			rt.new_string('<a href="%s" data-wp-lists="%s" class="vim-s vim-destructive aria-button-if-js" aria-label="%s">%s</a>'),
			rt.call_function('esc_url', [var_spam_url.clone()]),
			rt.concat(rt.concat(rt.new_string('delete:the-comment-list:comment-'), rt.get_property(var_comment,
				'comment_ID')), rt.new_string('::spam=1')),
			rt.call_function('esc_attr__', [rt.new_string('Mark this comment as spam')]),
			rt.call_function('_x', [rt.new_string('Spam'), rt.new_string('verb')]),
		]))
	} else if rt.is_true(rt.identical(rt.new_string('spam'), var_the_comment_status)) {
		var_actions.array_set('unspam', rt.call_function('sprintf', [
			rt.new_string('<a href="%s" data-wp-lists="%s" class="vim-z vim-destructive aria-button-if-js" aria-label="%s">%s</a>'),
			rt.call_function('esc_url', [var_unspam_url.clone()]),
			rt.concat(rt.concat(rt.new_string('delete:the-comment-list:comment-'), rt.get_property(var_comment,
				'comment_ID')), rt.new_string(':66cc66:unspam=1')),
			rt.call_function('esc_attr__', [rt.new_string('Restore this comment from the spam')]),
			rt.call_function('_x', [rt.new_string('Not Spam'),
				rt.new_string('comment')]),
		]))
	}
	if rt.is_true(rt.identical(rt.new_string('trash'), var_the_comment_status)) {
		var_actions.array_set('untrash', rt.call_function('sprintf', [
			rt.new_string('<a href="%s" data-wp-lists="%s" class="vim-z vim-destructive aria-button-if-js" aria-label="%s">%s</a>'),
			rt.call_function('esc_url', [var_untrash_url.clone()]),
			rt.concat(rt.concat(rt.new_string('delete:the-comment-list:comment-'), rt.get_property(var_comment,
				'comment_ID')), rt.new_string(':66cc66:untrash=1')),
			rt.call_function('esc_attr__', [rt.new_string('Restore this comment from the Trash')]),
			rt.call_function('__', [rt.new_string('Restore')]),
		]))
	}
	if rt.is_true(rt.identical(rt.new_string('spam'), var_the_comment_status))
		|| rt.is_true(rt.identical(rt.new_string('trash'), var_the_comment_status))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('EMPTY_TRASH_DAYS'))))) {
		var_actions.array_set('delete', rt.call_function('sprintf', [
			rt.new_string('<a href="%s" data-wp-lists="%s" class="delete vim-d vim-destructive aria-button-if-js" aria-label="%s">%s</a>'),
			rt.call_function('esc_url', [var_delete_url.clone()]),
			rt.concat(rt.concat(rt.new_string('delete:the-comment-list:comment-'), rt.get_property(var_comment,
				'comment_ID')), rt.new_string('::delete=1')),
			rt.call_function('esc_attr__', [rt.new_string('Delete this comment permanently')]),
			rt.call_function('__', [rt.new_string('Delete Permanently')]),
		]))
	} else {
		var_actions.array_set('trash', rt.call_function('sprintf', [
			rt.new_string('<a href="%s" data-wp-lists="%s" class="delete vim-d vim-destructive aria-button-if-js" aria-label="%s">%s</a>'),
			rt.call_function('esc_url', [var_trash_url.clone()]),
			rt.concat(rt.concat(rt.new_string('delete:the-comment-list:comment-'), rt.get_property(var_comment,
				'comment_ID')), rt.new_string('::trash=1')),
			rt.call_function('esc_attr__', [rt.new_string('Move this comment to the Trash')]),
			rt.call_function('_x', [rt.new_string('Trash'), rt.new_string('verb')]),
		]))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('spam'), var_the_comment_status))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('trash'), var_the_comment_status)))) {
		var_actions.array_set('edit', rt.call_function('sprintf', [
			rt.new_string('<a href="%s" aria-label="%s">%s</a>'),
			rt.concat(rt.new_string('comment.php?action=editcomment&amp;c='), rt.get_property(var_comment,
				'comment_ID')),
			rt.call_function('esc_attr__', [rt.new_string('Edit this comment')]),
			rt.call_function('__', [rt.new_string('Edit')]),
		]))
		mut var_format :=
			rt.new_string('<button type="button" data-comment-id="%d" data-post-id="%d" data-action="%s" class="%s button-link" aria-expanded="false" aria-label="%s">%s</button>')
		var_actions.array_set('quickedit', rt.call_function('sprintf', [
			var_format.clone(), rt.get_property(var_comment, 'comment_ID'),
			rt.get_property(var_comment, 'comment_post_ID'), rt.new_string('edit'),
			rt.new_string('vim-q comment-inline'),
			rt.call_function('esc_attr__', [
				rt.new_string('Quick edit this comment inline'),
			]),
			rt.call_function('__', [
				rt.new_string('Quick&nbsp;Edit'),
			])]))
		var_actions.array_set('reply', rt.call_function('sprintf', [
			var_format.clone(), rt.get_property(var_comment, 'comment_ID'),
			rt.get_property(var_comment, 'comment_post_ID'), rt.new_string('replyto'),
			rt.new_string('vim-r comment-inline'),
			rt.call_function('esc_attr__', [
				rt.new_string('Reply to this comment'),
			]),
			rt.call_function('_x', [
				rt.new_string('Reply'),
				rt.new_string('verb'),
			])]))
	}
	var_actions = rt.call_function('apply_filters', [
		rt.new_string('comment_row_actions'),
		rt.call_function('array_filter', [var_actions.clone()]),
		var_comment.clone(),
	])
	mut var_always_visible := rt.new_bool(false)
	mut var_mode := rt.call_function('get_user_setting', [
		rt.new_string('posts_list_mode'),
		rt.new_string('list'),
	])
	if rt.is_true(rt.identical(rt.new_string('excerpt'), var_mode)) {
		var_always_visible = rt.new_bool(true)
	}
	var_output = rt.concat(var_output, rt.new_string('<div class="' +
		if rt.is_true(var_always_visible) { 'row-actions visible' } else { 'row-actions' } + '">'))
	mut var_i := rt.new_int(0)
	mut iter_2 := var_actions.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_link := item_2.val
		mut var_action := item_2.key
		rt.pre_inc(var_i)
		if (rt.is_true(rt.identical(rt.new_string('approve'), var_action))
			|| rt.is_true(rt.identical(rt.new_string('unapprove'), var_action))
			&& rt.is_true(rt.identical(rt.new_int(2), var_i)))
			|| rt.is_true(rt.identical(rt.new_int(1), var_i)) {
			mut var_separator := rt.new_string('')
		} else {
			var_separator = rt.new_string(' | ')
		}
		if rt.is_true(rt.identical(rt.new_string('reply'), var_action))
			|| rt.is_true(rt.identical(rt.new_string('quickedit'), var_action))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{}))))) {
			var_action = rt.concat(var_action, rt.new_string(' hide-if-no-js'))
		} else if (rt.is_true(rt.identical(rt.new_string('untrash'), var_action))
			&& rt.is_true(rt.identical(rt.new_string('trash'), var_the_comment_status)))
			|| (rt.is_true(rt.identical(rt.new_string('unspam'), var_action))
			&& rt.is_true(rt.identical(rt.new_string('spam'), var_the_comment_status))) {
			if rt.is_true(rt.identical(rt.new_string('1'), rt.call_function('get_comment_meta', [
				rt.get_property(var_comment, 'comment_ID'),
				rt.new_string('_wp_trash_meta_status'),
				rt.new_bool(true),
			])))
			{
				var_action = rt.concat(var_action, rt.new_string(' approve'))
			} else {
				var_action = rt.concat(var_action, rt.new_string(' unapprove'))
			}
		}
		var_output = rt.concat(var_output,
			rt.new_string("<span class='${var_action.to_string()}'>${var_separator.to_string()}${var_link.to_string()}</span>"))
	}
	var_output = rt.concat(var_output, rt.new_string('</div>'))
	var_output = rt.concat(var_output, rt.new_string(
		'<button type="button" class="toggle-row"><span class="screen-reader-text">' +
		(rt.call_function('__', [rt.new_string('Show more details')])).str() + '</span></button>'))
	return var_output.str()
}

fn (mut this Class_WP_Comments_List_Table) column_cb(var_item rt.PhpVal) {
	mut var_comment := var_item
	if rt.is_true(this.user_can) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(var_comment, 'comment_ID'))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(var_comment, 'comment_ID'))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(var_comment, 'comment_ID'))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Select comment')])
		// unsupported statement: Stmt_InlineHTML
	}
}

fn (mut this Class_WP_Comments_List_Table) column_comment(var_comment rt.PhpVal) {
	mut var_comment_mutated := var_comment
	print('<div class="comment-author">')
	this.column_author(var_comment_mutated.clone())
	print('</div>')
	if rt.is_true(rt.get_property(var_comment_mutated, 'comment_parent')) {
		mut var_parent := rt.call_function('get_comment', [
			rt.get_property(var_comment_mutated, 'comment_parent'),
		])
		if rt.is_true(var_parent) {
			mut var_parent_link := rt.call_function('esc_url', [
				rt.call_function('get_comment_link', [var_parent.clone()]),
			])
			mut var_name := rt.call_function('get_comment_author', [
				var_parent.clone()])
			rt.call_function('printf', [
				rt.call_function('__', [rt.new_string('In reply to %s.')]),
				rt.new_string('<a href="' + var_parent_link.str() + '">' + var_name.str() + '</a>'),
			])
		}
	}
	rt.call_function('comment_text', [var_comment_mutated.clone()])
	if rt.is_true(this.user_can) {
		mut var_comment_content := rt.call_function('apply_filters', [
			rt.new_string('comment_edit_pre'),
			rt.get_property(var_comment_mutated, 'comment_content'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(var_comment_mutated, 'comment_ID'))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_textarea', [var_comment_content.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			rt.get_property(var_comment_mutated, 'comment_author_email'),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			rt.get_property(var_comment_mutated, 'comment_author'),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.get_property(var_comment_mutated, 'comment_author_url'),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(var_comment_mutated, 'comment_approved'))
		// unsupported statement: Stmt_InlineHTML
	}
}

fn (mut this Class_WP_Comments_List_Table) column_author(var_comment rt.PhpVal) {
	mut var_comment_status := rt.new_null()
	mut var_comment_mutated := var_comment
	mut var_author_url := rt.call_function('get_comment_author_url', [
		var_comment_mutated.clone()])
	mut var_author_url_display := rt.call_function('untrailingslashit', [
		rt.call_function('preg_replace', [rt.new_string('|^http(s)?://(www\\.)?|i'),
			rt.new_string(''), var_author_url.clone()]),
	])
	if var_author_url_display.clone().to_string().len > 50 {
		var_author_url_display = rt.call_function('wp_html_excerpt', [
			var_author_url_display.clone(), rt.new_int(49), rt.new_string('&hellip;')])
	}
	print('<strong>')
	rt.call_function('comment_author', [var_comment_mutated.clone()])
	print('</strong><br />')
	if !(!rt.is_true(var_author_url_display)) {
		rt.call_function('printf', [
			rt.new_string('<a href="%s" rel="noopener noreferrer">%s</a><br />'),
			rt.call_function('esc_url', [var_author_url.clone()]),
			rt.call_function('esc_html', [var_author_url_display.clone()]),
		])
	}
	if rt.is_true(this.user_can) {
		if !(!rt.is_true(rt.get_property(var_comment_mutated, 'comment_author_email'))) {
			mut var_email := rt.call_function('apply_filters', [
				rt.new_string('comment_email'),
				rt.get_property(var_comment_mutated, 'comment_author_email'),
				var_comment_mutated.clone(),
			])
			if !(!rt.is_true(var_email))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('@'), var_email)))) {
				rt.call_function('printf', [
					rt.new_string('<a href="%1$s">%2$s</a><br />'),
					rt.call_function('esc_url', [
						rt.new_string('mailto:' + var_email.str()),
					]),
					rt.call_function('esc_html', [
						var_email.clone(),
					]),
				])
			}
		}
		mut var_author_ip := rt.call_function('get_comment_author_IP', [
			var_comment_mutated.clone()])
		if rt.is_true(var_author_ip) {
			mut var_author_ip_url := rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 's', val: var_author_ip },
					rt.ArrayItem{ key: 'mode', val: 'detail' }]),
				rt.call_function('admin_url', [rt.new_string('edit-comments.php')]),
			])
			if rt.is_true(rt.identical(rt.new_string('spam'), var_comment_status)) {
				var_author_ip_url = rt.call_function('add_query_arg', [
					rt.new_string('comment_status'),
					rt.new_string('spam'),
					var_author_ip_url.clone(),
				])
			}
			rt.call_function('printf', [rt.new_string('<a href="%1$s">%2$s</a>'),
				rt.call_function('esc_url', [var_author_ip_url.clone()]),
				rt.call_function('esc_html', [var_author_ip.clone()])])
		}
	}
}

fn (mut this Class_WP_Comments_List_Table) column_date(var_comment rt.PhpVal) {
	mut var_comment_mutated := var_comment
	mut var_submitted := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('%1$s at %2$s')]),
		rt.call_function('get_comment_date', [rt.call_function('__', [
			rt.new_string('Y/m/d'),
		]),
			var_comment_mutated.clone()]),
		rt.call_function('get_comment_date', [rt.call_function('__', [
			rt.new_string('g:i a'),
		]),
			var_comment_mutated.clone()]),
	])
	print('<div class="submitted-on">')
	if rt.is_true(rt.identical(rt.new_string('approved'), rt.call_function('wp_get_comment_status', [var_comment_mutated.clone()])))
		&& !(!rt.is_true(rt.get_property(var_comment_mutated, 'comment_post_ID'))) {
		rt.call_function('printf', [rt.new_string('<a href="%s">%s</a>'),
			rt.call_function('esc_url', [
				rt.call_function('get_comment_link', [var_comment_mutated.clone()]),
			]),
			var_submitted.clone()])
	} else {
		rt.echo_val(var_submitted)
	}
	print('</div>')
}

fn (mut this Class_WP_Comments_List_Table) column_response(var_comment rt.PhpVal) {
	mut var_comment_mutated := var_comment
	mut var_post := rt.call_function('get_post', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return
	}
	if this.pending_count.array_isset(rt.get_property(var_post, 'ID')) {
		mut var_pending_comments := this.pending_count.array_get(rt.get_property(var_post, 'ID'))
	} else {
		mut var__pending_count_temp := rt.call_function('get_pending_comments_num', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.get_property(var_post, 'ID') },
			]),
		])
		var_pending_comments = var__pending_count_temp.array_get(rt.get_property(var_post, 'ID'))
		this.pending_count.array_set(rt.get_property(var_post, 'ID'), var_pending_comments.clone())
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'),
		rt.get_property(var_post, 'ID')]))
	{
		mut var_post_link := rt.new_string("<a href='" +
			(rt.call_function('get_edit_post_link', [rt.get_property(var_post, 'ID')])).str() +
			"' class='comments-edit-item-link'>")
		var_post_link = rt.concat(var_post_link, rt.new_string(
			(rt.call_function('esc_html', [rt.call_function('get_the_title', [rt.get_property(var_post, 'ID')])])).str() +
			'</a>'))
	} else {
		var_post_link = rt.call_function('esc_html', [
			rt.call_function('get_the_title', [rt.get_property(var_post, 'ID')]),
		])
	}
	print('<div class="response-links">')
	if rt.is_true(rt.identical(rt.new_string('attachment'), rt.get_property(var_post, 'post_type'))) {
		mut var_thumb := rt.call_function('wp_get_attachment_image', [
			rt.get_property(var_post, 'ID'),
			rt.create_array([rt.ArrayItem{ key: none, val: 80 },
				rt.ArrayItem{ key: none, val: 60 }]),
			rt.new_bool(true),
		])
		if rt.is_true(var_thumb) {
			rt.echo_val(var_thumb)
		}
	}
	rt.echo_val(var_post_link)
	mut var_post_type_object := rt.call_function('get_post_type_object', [
		rt.get_property(var_post, 'post_type'),
	])
	print("<a href='" +
		(rt.call_function('get_permalink', [rt.get_property(var_post, 'ID')])).str() +
		"' class='comments-view-item-link'>" +
		(rt.get_property(rt.get_property(var_post_type_object, 'labels'), 'view_item')).str() +
		'</a>')
	print('<span class="post-com-count-wrapper post-com-count-')
	rt.echo_val(rt.get_property(var_post, 'ID'))
	print('">')
	this.comments_bubble(rt.get_property(var_post, 'ID'), var_pending_comments.clone())
	print('</span> ')
	print('</div>')
}

fn (mut this Class_WP_Comments_List_Table) column_default(var_item rt.PhpVal, var_column_name rt.PhpVal) {
	mut var_comment := var_item
	rt.call_function('do_action', [rt.new_string('manage_comments_custom_column'),
		var_column_name.clone(), rt.get_property(var_comment, 'comment_ID')])
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

fn create_wp_comments_list_table(arg_0 rt.PhpVal) &Class_WP_Comments_List_Table {
	mut obj := &Class_WP_Comments_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
		checkbox:      rt.new_bool(true)
		pending_count: rt.new_array()
		extra_items:   rt.new_null()
		user_can:      rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_list_table(_args ...rt.PhpVal) &Class_WP_List_Table {
	mut obj := &Class_WP_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Comments_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'floated_admin_avatar' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.floated_admin_avatar(dispatch_arg_0, dispatch_arg_1))
		}
		'ajax_user_can' {
			return this.ajax_user_can()
		}
		'prepare_items' {
			this.prepare_items()
			return rt.new_null()
		}
		'get_per_page' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_per_page(dispatch_arg_0)
		}
		'no_items' {
			this.no_items()
			return rt.new_null()
		}
		'get_views' {
			return this.get_views()
		}
		'get_bulk_actions' {
			return this.get_bulk_actions()
		}
		'extra_tablenav' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.extra_tablenav(dispatch_arg_0)
			return rt.new_null()
		}
		'current_action' {
			return rt.new_string(this.current_action())
		}
		'get_columns' {
			return this.get_columns()
		}
		'comment_type_dropdown' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.comment_type_dropdown(dispatch_arg_0)
			return rt.new_null()
		}
		'get_sortable_columns' {
			return this.get_sortable_columns()
		}
		'get_default_primary_column_name' {
			return rt.new_string(this.get_default_primary_column_name())
		}
		'display' {
			this.display()
			return rt.new_null()
		}
		'single_row' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.single_row(dispatch_arg_0))
		}
		'handle_row_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.handle_row_actions(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2))
		}
		'column_cb' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_cb(dispatch_arg_0)
			return rt.new_null()
		}
		'column_comment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_comment(dispatch_arg_0)
			return rt.new_null()
		}
		'column_author' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_author(dispatch_arg_0)
			return rt.new_null()
		}
		'column_date' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_date(dispatch_arg_0)
			return rt.new_null()
		}
		'column_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_response(dispatch_arg_0)
			return rt.new_null()
		}
		'column_default' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.column_default(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Comments_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'checkbox' { return this.checkbox }
		'pending_count' { return this.pending_count }
		'extra_items' { return this.extra_items }
		'user_can' { return this.user_can }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Comments_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'checkbox' {
			this.checkbox = val
			return true
		}
		'pending_count' {
			this.pending_count = val
			return true
		}
		'extra_items' {
			this.extra_items = val
			return true
		}
		'user_can' {
			this.user_can = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
