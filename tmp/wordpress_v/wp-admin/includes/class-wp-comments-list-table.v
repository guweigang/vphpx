import rt

struct Class_WP_Comments_List_Table {
	rt.PhpObjectBase
pub mut:
		checkbox rt.PhpVal = rt.new_bool(true)
		pending_count rt.PhpVal = rt.new_array()
		extra_items rt.PhpVal = rt.new_null()
		user_can rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Comments_List_Table) construct(var_args rt.PhpVal)  {
	mut var_args_mutated := var_args
	// unsupported statement: Stmt_Global
	mut var_post_id := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('p')) { rt.call_function('absint', [rt.get_superglobal('_REQUEST').array_get('p')]) } else { rt.new_int(0) }
	if rt.is_true(rt.call_function('get_option', [rt.new_string('show_avatars')])) {
		rt.call_function('add_filter', [rt.new_string('comment_author'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Comments_List_Table', ['WP_List_Table'], &this) }, rt.ArrayItem{ key: none, val: 'floated_admin_avatar' }]), rt.new_int(10), rt.new_int(2)])
	}
	this.Class_WP_List_Table.construct(rt.create_array([rt.ArrayItem{ key: 'plural', val: 'comments' }, rt.ArrayItem{ key: 'singular', val: 'comment' }, rt.ArrayItem{ key: 'ajax', val: true }, rt.ArrayItem{ key: 'screen', val: if !(var_args_mutated.array_get('screen')).is_null() { var_args_mutated.array_get('screen') } else { rt.new_null() } }]))
}

fn (mut this Class_WP_Comments_List_Table) floated_admin_avatar(var_name rt.PhpVal, var_comment_id rt.PhpVal) string {
	mut var_name_mutated := var_name
	mut var_comment := rt.call_function('get_comment', [var_comment_id.dup()])
	mut var_avatar := rt.call_function('get_avatar', [var_comment.dup(), rt.new_int(32), rt.new_string('mystery')])
	return "${var_avatar.to_string()} ${var_name.to_string()}"
}

fn (mut this Class_WP_Comments_List_Table) ajax_user_can() rt.PhpVal {
	return rt.call_function('current_user_can', [rt.new_string('edit_posts')])
}

fn (mut this Class_WP_Comments_List_Table) prepare_items()  {
	mut var_post_id := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('mode'))) {
		mut var_mode := rt.new_string(if rt.is_true(rt.identical(rt.new_string('excerpt'), rt.get_superglobal('_REQUEST').array_get('mode'))) { rt.new_string('excerpt') } else { rt.new_string('list') })
		rt.call_function('set_user_setting', [rt.new_string('posts_list_mode'), var_mode.dup()])
	} else {
		var_mode = rt.call_function('get_user_setting', [rt.new_string('posts_list_mode'), rt.new_string('list')])
	}
	mut var_comment_status := if !(rt.get_superglobal('_REQUEST').array_get('comment_status')).is_null() { rt.get_superglobal('_REQUEST').array_get('comment_status') } else { rt.new_string('all') }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_comment_status.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'all' }, rt.ArrayItem{ key: none, val: 'mine' }, rt.ArrayItem{ key: none, val: 'moderated' }, rt.ArrayItem{ key: none, val: 'approved' }, rt.ArrayItem{ key: none, val: 'spam' }, rt.ArrayItem{ key: none, val: 'trash' }]), rt.new_bool(true)]))))) {
		var_comment_status = rt.new_string(rt.new_string('all'))
	}
	mut var_comment_type := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('comment_type'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_comment_type = rt.get_superglobal('_REQUEST').array_get('comment_type')
	}
	mut var_search := if !(rt.get_superglobal('_REQUEST').array_get('s')).is_null() { rt.get_superglobal('_REQUEST').array_get('s') } else { rt.new_string('') }
	mut var_post_type := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('post_type')) { rt.call_function('sanitize_key', [rt.get_superglobal('_REQUEST').array_get('post_type')]) } else { rt.new_string('') }
	mut var_user_id := if !(rt.get_superglobal('_REQUEST').array_get('user_id')).is_null() { rt.get_superglobal('_REQUEST').array_get('user_id') } else { rt.new_string('') }
	mut var_orderby := if !(rt.get_superglobal('_REQUEST').array_get('orderby')).is_null() { rt.get_superglobal('_REQUEST').array_get('orderby') } else { rt.new_string('') }
	mut var_order := if !(rt.get_superglobal('_REQUEST').array_get('order')).is_null() { rt.get_superglobal('_REQUEST').array_get('order') } else { rt.new_string('') }
	mut var_comments_per_page := this.get_per_page((var_comment_status).str())
	mut var_doing_ajax := rt.call_function('wp_doing_ajax', []rt.PhpVal{})
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('number')) {
		mut var_number := // unsupported expression: Expr_Cast_Int
	} else {
		var_number = rt.add(var_comments_per_page, rt.call_function('min', [rt.new_int(8), var_comments_per_page.dup()]))
		// unsupported statement: Stmt_Nop
	}
	mut var_page := this.get_pagenum()
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('start')) {
		mut var_start := rt.get_superglobal('_REQUEST').array_get('start')
	} else {
		var_start = rt.mul(rt.sub(var_page, rt.new_int(1)), var_comments_per_page)
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_doing_ajax) && rt.get_superglobal('_REQUEST').array_isset(rt.new_string('offset')))) {
		// unsupported expression: Expr_AssignOp_Plus
	}
	mut var_status_map := rt.create_array([rt.ArrayItem{ key: 'mine', val: '' }, rt.ArrayItem{ key: 'moderated', val: 'hold' }, rt.ArrayItem{ key: 'approved', val: 'approve' }, rt.ArrayItem{ key: 'all', val: '' }])
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'status', val: if !(var_status_map.array_get(var_comment_status)).is_null() { var_status_map.array_get(var_comment_status) } else { var_comment_status } }, rt.ArrayItem{ key: 'search', val: var_search }, rt.ArrayItem{ key: 'user_id', val: var_user_id }, rt.ArrayItem{ key: 'offset', val: var_start }, rt.ArrayItem{ key: 'number', val: var_number }, rt.ArrayItem{ key: 'post_id', val: var_post_id }, rt.ArrayItem{ key: 'type', val: var_comment_type }, rt.ArrayItem{ key: 'type__not_in', val: rt.create_array([rt.ArrayItem{ key: none, val: 'note' }]) }, rt.ArrayItem{ key: 'orderby', val: var_orderby }, rt.ArrayItem{ key: 'order', val: var_order }, rt.ArrayItem{ key: 'post_type', val: var_post_type }, rt.ArrayItem{ key: 'update_comment_post_cache', val: true }])
	var_args = rt.call_function('apply_filters', [rt.new_string('comments_list_table_query_args'), var_args.dup()])
	mut var__comments := rt.call_function('get_comments', [var_args.dup()])
	if rt.is_true(rt.new_bool(var__comments.dup().is_array())) {
		this.dispatch_set_prop('items', rt.call_function('array_slice', [var__comments.dup(), rt.new_int(0), var_comments_per_page.dup()]))
		this.extra_items = rt.call_function('array_slice', [var__comments.dup(), var_comments_per_page.dup()])
		mut var__comment_post_ids := rt.call_function('array_unique', [rt.call_function('wp_list_pluck', [var__comments.dup(), rt.new_string('comment_post_ID')])])
		this.pending_count = rt.call_function('get_pending_comments_num', [var__comment_post_ids.dup()])
	}
	mut var_total_comments := rt.call_function('get_comments', [rt.call_function('array_merge', [var_args.dup(), rt.create_array([rt.ArrayItem{ key: 'count', val: true }, rt.ArrayItem{ key: 'offset', val: 0 }, rt.ArrayItem{ key: 'number', val: 0 }, rt.ArrayItem{ key: 'orderby', val: 'none' }])])])
	this.set_pagination_args(rt.create_array([rt.ArrayItem{ key: 'total_items', val: var_total_comments }, rt.ArrayItem{ key: 'per_page', val: var_comments_per_page }]))
}

fn (mut this Class_WP_Comments_List_Table) get_per_page(comment_status string) rt.PhpVal {
	mut comment_status_mutated := comment_status
	mut var_comments_per_page := this.get_items_per_page(rt.new_string('edit_comments_per_page'))
	return rt.call_function('apply_filters', [rt.new_string('comments_per_page'), var_comments_per_page.dup(), rt.new_string(comment_status_mutated).dup()])
}

fn (mut this Class_WP_Comments_List_Table) no_items()  {
	mut var_comment_status := rt.new_null()
	// unsupported statement: Stmt_Global
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
	// unsupported statement: Stmt_Global
	mut var_status_links := rt.new_array()
	mut var_num_comments := if rt.is_true(var_post_id) { rt.call_function('wp_count_comments', [var_post_id.dup()]) } else { rt.call_function('wp_count_comments', []rt.PhpVal{}) }
	mut var_statuses := { 'all': rt.call_function('_nx_noop', [rt.new_string('All <span class="count">(%s)</span>'), rt.new_string('All <span class="count">(%s)</span>'), rt.new_string('comments')]), 'mine': rt.call_function('_nx_noop', [rt.new_string('Mine <span class="count">(%s)</span>'), rt.new_string('Mine <span class="count">(%s)</span>'), rt.new_string('comments')]), 'moderated': rt.call_function('_nx_noop', [rt.new_string('Pending <span class="count">(%s)</span>'), rt.new_string('Pending <span class="count">(%s)</span>'), rt.new_string('comments')]), 'approved': rt.call_function('_nx_noop', [rt.new_string('Approved <span class="count">(%s)</span>'), rt.new_string('Approved <span class="count">(%s)</span>'), rt.new_string('comments')]), 'spam': rt.call_function('_nx_noop', [rt.new_string('Spam <span class="count">(%s)</span>'), rt.new_string('Spam <span class="count">(%s)</span>'), rt.new_string('comments')]), 'trash': rt.call_function('_nx_noop', [rt.new_string('Trash <span class="count">(%s)</span>'), rt.new_string('Trash <span class="count">(%s)</span>'), rt.new_string('comments')]) }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('EMPTY_TRASH_DAYS'))))) {
		var_statuses.delete('trash')
	}
	mut var_link := rt.call_function('admin_url', [rt.new_string('edit-comments.php')])
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_comment_type)) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_link = rt.call_function('add_query_arg', [rt.new_string('comment_type'), var_comment_type.dup(), var_link.dup()])
	}
	for var_status, var_label in var_statuses {
		if rt.is_true(rt.identical(rt.new_string('mine'), rt.new_string(status))) {
			mut var_current_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
			rt.set_property(var_num_comments, 'mine', rt.call_function('get_comments', [rt.create_array([rt.ArrayItem{ key: 'post_id', val: if rt.is_true(var_post_id) { var_post_id } else { rt.new_int(0) } }, rt.ArrayItem{ key: 'user_id', val: var_current_user_id }, rt.ArrayItem{ key: 'count', val: true }, rt.ArrayItem{ key: 'orderby', val: 'none' }])]))
			var_link = rt.call_function('add_query_arg', [rt.new_string('user_id'), var_current_user_id.dup(), var_link.dup()])
		} else {
			var_link = rt.call_function('remove_query_arg', [rt.new_string('user_id'), var_link.dup()])
		}
		if !(!(rt.get_property(var_num_comments, '{"nodeType":"Expr_Variable","line":326,"name":"status"}')).is_null()) {
			rt.set_property(var_num_comments, '{"nodeType":"Expr_Variable","line":327,"name":"status"}', rt.new_int(10))
		}
		var_link = rt.call_function('add_query_arg', [rt.new_string('comment_status'), rt.new_string(status), var_link.dup()])
		if rt.is_true(var_post_id) {
			var_link = rt.call_function('add_query_arg', [rt.new_string('p'), rt.call_function('absint', [var_post_id.dup()]), var_link.dup()])
		}
		var_status_links.array_set(status, rt.create_array([rt.ArrayItem{ key: 'url', val: rt.call_function('esc_url', [var_link.dup()]) }, rt.ArrayItem{ key: 'label', val: rt.call_function('sprintf', [rt.call_function('translate_nooped_plural', [var_label.dup(), rt.get_property(var_num_comments, '{"nodeType":"Expr_Variable","line":345,"name":"status"}')]), rt.call_function('sprintf', [rt.new_string('<span class="%s-count">%s</span>'), if rt.is_true(rt.identical(rt.new_string('moderated'), rt.new_string(status))) { rt.new_string('pending') } else { rt.new_string(status) }, rt.call_function('number_format_i18n', [rt.get_property(var_num_comments, '{"nodeType":"Expr_Variable","line":349,"name":"status"}')])])]) }, rt.ArrayItem{ key: 'current', val: rt.identical(rt.new_string(status), var_comment_status) }]))
	}
	return rt.call_function('apply_filters', [rt.new_string('comment_status_links'), this.get_views_links(var_status_links.dup())])
}

fn (mut this Class_WP_Comments_List_Table) get_bulk_actions() rt.PhpVal {
	mut var_comment_status := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('moderate_comments')]))))) {
		return rt.new_array()
		// unsupported statement: Stmt_Nop
	}
	mut var_actions := rt.new_array()
	if rt.is_true(rt.call_function('in_array', [var_comment_status.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'all' }, rt.ArrayItem{ key: none, val: 'approved' }]), rt.new_bool(true)])) {
		var_actions.array_set('unapprove', rt.call_function('__', [rt.new_string('Unapprove')]))
	}
	if rt.is_true(rt.call_function('in_array', [var_comment_status.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'all' }, rt.ArrayItem{ key: none, val: 'moderated' }]), rt.new_bool(true)])) {
		var_actions.array_set('approve', rt.call_function('__', [rt.new_string('Approve')]))
	}
	if rt.is_true(rt.call_function('in_array', [var_comment_status.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'all' }, rt.ArrayItem{ key: none, val: 'moderated' }, rt.ArrayItem{ key: none, val: 'approved' }, rt.ArrayItem{ key: none, val: 'trash' }]), rt.new_bool(true)])) {
		var_actions.array_set('spam', rt.call_function('_x', [rt.new_string('Mark as spam'), rt.new_string('comment')]))
	}
	if rt.is_true(rt.identical(rt.new_string('trash'), var_comment_status)) {
		var_actions.array_set('untrash', rt.call_function('__', [rt.new_string('Restore')]))
	} else if rt.is_true(rt.identical(rt.new_string('spam'), var_comment_status)) {
		var_actions.array_set('unspam', rt.call_function('_x', [rt.new_string('Not spam'), rt.new_string('comment')]))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [var_comment_status.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'trash' }, rt.ArrayItem{ key: none, val: 'spam' }]), rt.new_bool(true)])) || rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('EMPTY_TRASH_DAYS'))))))) {
		var_actions.array_set('delete', rt.call_function('__', [rt.new_string('Delete permanently')]))
	} else {
		var_actions.array_set('trash', rt.call_function('__', [rt.new_string('Move to Trash')]))
	}
	return var_actions.dup()
}

fn (mut this Class_WP_Comments_List_Table) extra_tablenav(var_which rt.PhpVal)  {
	mut var_comment_status := rt.new_null()
	mut var_comment_type := rt.new_null()
	// unsupported statement: Stmt_Global
	// unsupported statement: Stmt_Static
	if !(!(var_has_items).is_null()) {
		mut var_has_items := this.has_items()
	}
	print('<div class="alignleft actions">')
	if rt.is_true(rt.identical(rt.new_string('top'), var_which)) {
		rt.call_function('ob_start', []rt.PhpVal{})
		this.comment_type_dropdown(var_comment_type.dup())
		rt.call_function('do_action', [rt.new_string('restrict_manage_comments')])
		mut var_output := rt.call_function('ob_get_clean', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(!rt.is_true(var_output)) && rt.is_true(this.has_items()))) {
			rt.echo_val(var_output)
			rt.call_function('submit_button', [rt.call_function('__', [rt.new_string('Filter')]), rt.new_string(''), rt.new_string('filter_action'), rt.new_bool(false), rt.create_array([rt.ArrayItem{ key: 'id', val: 'post-query-submit' }])])
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('spam'), var_comment_status)) || rt.is_true(rt.identical(rt.new_string('trash'), var_comment_status)))) && rt.is_true(var_has_items))) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('moderate_comments')])))) {
		rt.call_function('wp_nonce_field', [rt.new_string('bulk-destroy'), rt.new_string('_destroy_nonce')])
		mut var_title := if rt.is_true(rt.identical(rt.new_string('spam'), var_comment_status)) { rt.call_function('esc_attr__', [rt.new_string('Empty Spam')]) } else { rt.call_function('esc_attr__', [rt.new_string('Empty Trash')]) }
		rt.call_function('submit_button', [var_title.dup(), rt.new_string('apply'), rt.new_string('delete_all'), rt.new_bool(false)])
	}
	rt.call_function('do_action', [rt.new_string('manage_comments_nav'), var_comment_status.dup(), var_which.dup()])
	print('</div>')
}

fn (mut this Class_WP_Comments_List_Table) current_action() string {
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('delete_all')) || rt.get_superglobal('_REQUEST').array_isset(rt.new_string('delete_all2')) {
		return 'delete_all'
	}
	return (this.Class_WP_List_Table.current_action()).str()
}

fn (mut this Class_WP_Comments_List_Table) get_columns() rt.PhpVal {
	mut var_post_id := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_columns := rt.new_array()
	if rt.is_true(this.checkbox) {
		var_columns['cb'] = rt.new_string('<input type="checkbox" />')
	}
	var_columns['author'] = rt.call_function('__', [rt.new_string('Author')])
	var_columns['comment'] = rt.call_function('_x', [, ])
	if rt.is_true(rt.new_bool(!(rt.is_true()))) {
		
	}
	
}

fn (mut this Class_WP_Comments_List_Table) comment_type_dropdown(var_comment_type rt.PhpVal)  {
	mut var_comment_type_mutated := var_comment_type
}

fn (mut this Class_WP_Comments_List_Table) get_sortable_columns() rt.PhpVal {
}

fn (mut this Class_WP_Comments_List_Table) get_default_primary_column_name() string {
}

fn (mut this Class_WP_Comments_List_Table) display()  {
}

fn (mut this Class_WP_Comments_List_Table) single_row(var_item rt.PhpVal) bool {
	mut var_GLOBALS := rt.new_null()
	return false
}

fn (mut this Class_WP_Comments_List_Table) handle_row_actions(var_item rt.PhpVal, var_column_name rt.PhpVal, var_primary rt.PhpVal) string {
	mut var_comment_status := rt.new_null()
}

fn (mut this Class_WP_Comments_List_Table) column_cb(var_item rt.PhpVal)  {
}

fn (mut this Class_WP_Comments_List_Table) column_comment(var_comment rt.PhpVal)  {
	mut var_comment_mutated := var_comment
}

fn (mut this Class_WP_Comments_List_Table) column_author(var_comment rt.PhpVal)  {
	mut var_comment_status := rt.new_null()
	mut var_comment_mutated := var_comment
}

fn (mut this Class_WP_Comments_List_Table) column_date(var_comment rt.PhpVal)  {
	mut var_comment_mutated := var_comment
}

fn (mut this Class_WP_Comments_List_Table) column_response(var_comment rt.PhpVal)  {
	mut var_comment_mutated := var_comment
}

fn (mut this Class_WP_Comments_List_Table) column_default(var_item rt.PhpVal, var_column_name rt.PhpVal)  {
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

fn create_wp_comments_list_table(arg_0 rt.PhpVal) &Class_WP_Comments_List_Table {
	mut obj := &Class_WP_Comments_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
		checkbox: rt.new_bool(true)
		pending_count: rt.new_array()
		extra_items: rt.new_null()
		user_can: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_list_table() &Class_WP_List_Table {
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
			return rt.new_string(this.handle_row_actions(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
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
		else { return none }
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
		'checkbox' { this.checkbox = val; return true }
		'pending_count' { this.pending_count = val; return true }
		'extra_items' { this.extra_items = val; return true }
		'user_can' { this.user_can = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_admin_includes_class_wp_comments_list_table_php() {
}
