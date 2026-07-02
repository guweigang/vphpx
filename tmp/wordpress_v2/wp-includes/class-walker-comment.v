import rt

struct Class_Walker_Comment {
	rt.PhpObjectBase
pub mut:
	tree_type rt.PhpVal = rt.new_string('comment')
	db_fields rt.PhpVal = rt.new_array()
}

fn (mut this Class_Walker_Comment) start_lvl(var_output rt.PhpVal, depth i64, var_args rt.PhpVal) {
	mut var_GLOBALS := rt.new_null()
	mut depth_mutated := depth
	var_GLOBALS.array_set('comment_depth', depth_mutated + 1)
	mut switch_val_1 := var_args.array_get(rt.new_string('style'))
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('div'))) {
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('ol'))) {
		var_output = rt.concat(var_output, rt.new_string('<ol class="children">' + '\n'))
	} else {
		var_output = rt.concat(var_output, rt.new_string('<ul class="children">' + '\n'))
	}
}

fn (mut this Class_Walker_Comment) end_lvl(var_output rt.PhpVal, depth i64, var_args rt.PhpVal) {
	mut var_GLOBALS := rt.new_null()
	mut depth_mutated := depth
	var_GLOBALS.array_set('comment_depth', depth_mutated + 1)
	mut switch_val_2 := var_args.array_get(rt.new_string('style'))
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('div'))) {
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('ol'))) {
		var_output = rt.concat(var_output, rt.new_string('</ol><!-- .children -->\n'))
	} else {
		var_output = rt.concat(var_output, rt.new_string('</ul><!-- .children -->\n'))
	}
}

fn (mut this Class_Walker_Comment) display_element(var_element rt.PhpVal, var_children_elements rt.PhpVal, var_max_depth rt.PhpVal, var_depth rt.PhpVal, var_args rt.PhpVal, var_output rt.PhpVal) {
	mut var_depth_mutated := var_depth
	if rt.is_true(rt.new_bool(!(rt.is_true(var_element)))) {
		return
	}
	mut var_id_field := this.db_fields.array_get(rt.new_string('id'))
	mut var_id := rt.get_property(var_element,
		'{"nodeType":"Expr_Variable","line":137,"name":"id_field"}')
	this.Class_Walker.display_element(var_element.clone(), var_children_elements.clone(),
		var_max_depth.clone(), var_depth_mutated.clone(), var_args.clone(), var_output.clone())
	if rt.is_true(rt.less_equal(var_max_depth, rt.add(var_depth_mutated, rt.new_int(1))))
		&& var_children_elements.array_isset(var_id) {
		mut iter_1 := var_children_elements.array_get(var_id).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_child := item_1.val
			this.display_element(var_child.clone(), var_children_elements.clone(),
				var_max_depth.clone(), var_depth_mutated.clone(), var_args.clone(),
				var_output.clone())
		}
		var_children_elements.array_unset(var_id)
	}
}

fn (mut this Class_Walker_Comment) start_el(var_output rt.PhpVal, var_data_object rt.PhpVal, depth i64, var_args rt.PhpVal, current_object_id i64) {
	mut var_GLOBALS := rt.new_null()
	mut depth_mutated := depth
	mut var_comment := var_data_object
	rt.pre_inc(rt.new_int(depth_mutated))
	var_GLOBALS.array_set('comment_depth', depth_mutated)
	var_GLOBALS.array_set('comment', var_comment.clone())
	if !(!rt.is_true(var_args.array_get(rt.new_string('callback')))) {
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.call_function('call_user_func', [var_args.array_get(rt.new_string('callback')),
			var_comment.clone(), var_args.clone(), rt.new_int(depth_mutated).clone()])
		var_output = rt.concat(var_output, rt.call_function('ob_get_clean', []rt.PhpVal{}))
		return
	}
	if rt.is_true(rt.identical(rt.new_string('comment'), rt.get_property(var_comment,
		'comment_type')))
	{
		rt.call_function('add_filter', [rt.new_string('comment_text'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Walker_Comment', [
					'Walker',
				], &this) },
				rt.ArrayItem{ key: none, val: 'filter_comment_text' },
			]),
			rt.new_int(40), rt.new_int(2)])
	}
	if rt.is_true(rt.identical(rt.new_string('pingback'), rt.get_property(var_comment, 'comment_type')))
		|| rt.is_true(rt.identical(rt.new_string('trackback'), rt.get_property(var_comment, 'comment_type')))
		&& rt.is_true(var_args.array_get(rt.new_string('short_ping'))) {
		rt.call_function('ob_start', []rt.PhpVal{})
		this.ping(var_comment.clone(), rt.new_int(depth_mutated), var_args.clone())
		var_output = rt.concat(var_output, rt.call_function('ob_get_clean', []rt.PhpVal{}))
	} else if rt.is_true(rt.identical(rt.new_string('html5'),
		var_args.array_get(rt.new_string('format'))))
	{
		rt.call_function('ob_start', []rt.PhpVal{})
		this.html5_comment(var_comment.clone(), rt.new_int(depth_mutated), var_args.clone())
		var_output = rt.concat(var_output, rt.call_function('ob_get_clean', []rt.PhpVal{}))
	} else {
		rt.call_function('ob_start', []rt.PhpVal{})
		this.comment(var_comment.clone(), rt.new_int(depth_mutated), var_args.clone())
		var_output = rt.concat(var_output, rt.call_function('ob_get_clean', []rt.PhpVal{}))
	}
	if rt.is_true(rt.identical(rt.new_string('comment'), rt.get_property(var_comment,
		'comment_type')))
	{
		rt.call_function('remove_filter', [rt.new_string('comment_text'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Walker_Comment', [
					'Walker',
				], &this) },
				rt.ArrayItem{ key: none, val: 'filter_comment_text' },
			]),
			rt.new_int(40)])
	}
}

fn (mut this Class_Walker_Comment) end_el(var_output rt.PhpVal, var_data_object rt.PhpVal, depth i64, var_args rt.PhpVal) {
	mut depth_mutated := depth
	if !(!rt.is_true(var_args.array_get(rt.new_string('end-callback')))) {
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.call_function('call_user_func', [var_args.array_get(rt.new_string('end-callback')),
			var_data_object.clone(), var_args.clone(), rt.new_int(depth_mutated).clone()])
		var_output = rt.concat(var_output, rt.call_function('ob_get_clean', []rt.PhpVal{}))
		return
	}
	if rt.is_true(rt.identical(rt.new_string('div'), var_args.array_get(rt.new_string('style')))) {
		var_output = rt.concat(var_output, rt.new_string('</div><!-- #comment-## -->\n'))
	} else {
		var_output = rt.concat(var_output, rt.new_string('</li><!-- #comment-## -->\n'))
	}
}

fn (mut this Class_Walker_Comment) ping(var_comment rt.PhpVal, var_depth rt.PhpVal, var_args rt.PhpVal) {
	mut var_comment_mutated := var_comment
	mut var_depth_mutated := var_depth
	mut var_tag := rt.new_string((if rt.is_true(rt.identical(rt.new_string('div'),
		var_args.array_get(rt.new_string('style'))))
	{
		'div'
	} else {
		'li'
	}).str())
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_tag)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('comment_ID', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('comment_class', [rt.new_string(''), var_comment_mutated.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Pingback:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('comment_author_link', [var_comment_mutated.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('edit_comment_link', [
		rt.call_function('__', [rt.new_string('Edit')]),
		rt.new_string('<span class="edit-link">'),
		rt.new_string('</span>'),
	])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Walker_Comment) filter_comment_text(var_comment_text rt.PhpVal, var_comment rt.PhpVal) rt.PhpVal {
	mut var_comment_text_mutated := var_comment_text
	mut var_comment_mutated := var_comment
	mut var_commenter := rt.call_function('wp_get_current_commenter', []rt.PhpVal{})
	mut var_show_pending_links :=
		rt.new_bool(!(!rt.is_true(var_commenter.array_get(rt.new_string('comment_author')))))
	if rt.is_true(var_comment_mutated)
		&& rt.is_true(rt.identical(rt.new_string('0'), rt.get_property(var_comment_mutated, 'comment_approved')))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_show_pending_links)))) {
		var_comment_text_mutated = rt.call_function('wp_kses', [
			var_comment_text_mutated.clone(), rt.new_array()])
	}
	return var_comment_text_mutated.clone()
}

fn (mut this Class_Walker_Comment) comment(var_comment rt.PhpVal, var_depth rt.PhpVal, var_args rt.PhpVal) {
	mut var_comment_mutated := var_comment
	mut var_depth_mutated := var_depth
	if rt.is_true(rt.identical(rt.new_string('div'), var_args.array_get(rt.new_string('style')))) {
		mut var_tag := rt.new_string('div')
		mut var_add_below := rt.new_string('comment')
	} else {
		var_tag = rt.new_string('li')
		var_add_below = rt.new_string('div-comment')
	}
	mut var_commenter := rt.call_function('wp_get_current_commenter', []rt.PhpVal{})
	mut var_show_pending_links := rt.new_bool(
		var_commenter.array_isset(rt.new_string('comment_author'))
		&& rt.is_true(var_commenter.array_get(rt.new_string('comment_author'))))
	if rt.is_true(var_commenter.array_get(rt.new_string('comment_author_email'))) {
		mut var_moderation_note := rt.call_function('__', [
			rt.new_string('Your comment is awaiting moderation.'),
		])
	} else {
		var_moderation_note = rt.call_function('__', [
			rt.new_string('Your comment is awaiting moderation. This is a preview; your comment will be visible after it has been approved.'),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_tag)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('comment_class', [
		rt.new_string((if rt.is_true(rt.get_property(rt.new_object('Walker_Comment', [
			'Walker',
		], &this), 'has_children'))
		{ 'parent' } else { '' }).str()),
		var_comment_mutated.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('comment_ID', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('div'),
		var_args.array_get(rt.new_string('style'))))))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('comment_ID', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0),
		var_args.array_get(rt.new_string('avatar_size'))))))
	{
		rt.echo_val(rt.call_function('get_avatar', [var_comment_mutated.clone(),
			var_args.array_get(rt.new_string('avatar_size'))]))
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_comment_author := rt.call_function('get_comment_author_link', [
		var_comment_mutated.clone()])
	if rt.is_true(rt.identical(rt.new_string('0'), rt.get_property(var_comment_mutated, 'comment_approved')))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_show_pending_links)))) {
		var_comment_author = rt.call_function('get_comment_author', [
			var_comment_mutated.clone()])
	}
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('%s <span class="says">says:</span>')]),
		rt.call_function('sprintf', [rt.new_string('<cite class="fn">%s</cite>'),
			var_comment_author.clone()]),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_string('0'), rt.get_property(var_comment_mutated,
		'comment_approved')))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_moderation_note)
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.new_string('<a href="%s">%s</a>'),
		rt.call_function('esc_url', [
			rt.call_function('get_comment_link', [var_comment_mutated.clone(),
				var_args.clone()]),
		]),
		rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%1$s at %2$s')]),
			rt.call_function('get_comment_date', [rt.new_string(''),
				var_comment_mutated.clone()]),
			rt.call_function('get_comment_time', []rt.PhpVal{}),
		])])
	rt.call_function('edit_comment_link', [
		rt.call_function('__', [rt.new_string('(Edit)')]),
		rt.new_string(' &nbsp;&nbsp;'),
		rt.new_string(''),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('comment_text', [var_comment_mutated.clone(),
		rt.call_function('array_merge', [var_args.clone(),
			rt.create_array([rt.ArrayItem{ key: 'add_below', val: var_add_below },
				rt.ArrayItem{ key: 'depth', val: var_depth_mutated },
				rt.ArrayItem{ key: 'max_depth', val: var_args.array_get(rt.new_string('max_depth')) }])])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('comment_reply_link', [
		rt.call_function('array_merge', [var_args.clone(),
			rt.create_array([rt.ArrayItem{ key: 'add_below', val: var_add_below },
				rt.ArrayItem{ key: 'depth', val: var_depth_mutated },
				rt.ArrayItem{ key: 'max_depth', val: var_args.array_get(rt.new_string('max_depth')) },
				rt.ArrayItem{ key: 'before', val: '<div class="reply">' },
				rt.ArrayItem{ key: 'after', val: '</div>' }])]),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('div'),
		var_args.array_get(rt.new_string('style'))))))
	{
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Walker_Comment) html5_comment(var_comment rt.PhpVal, var_depth rt.PhpVal, var_args rt.PhpVal) {
	mut var_comment_mutated := var_comment
	mut var_depth_mutated := var_depth
	mut var_tag := rt.new_string((if rt.is_true(rt.identical(rt.new_string('div'),
		var_args.array_get(rt.new_string('style'))))
	{
		'div'
	} else {
		'li'
	}).str())
	mut var_commenter := rt.call_function('wp_get_current_commenter', []rt.PhpVal{})
	mut var_show_pending_links :=
		rt.new_bool(!(!rt.is_true(var_commenter.array_get(rt.new_string('comment_author')))))
	if rt.is_true(var_commenter.array_get(rt.new_string('comment_author_email'))) {
		mut var_moderation_note := rt.call_function('__', [
			rt.new_string('Your comment is awaiting moderation.'),
		])
	} else {
		var_moderation_note = rt.call_function('__', [
			rt.new_string('Your comment is awaiting moderation. This is a preview; your comment will be visible after it has been approved.'),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_tag)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('comment_ID', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('comment_class', [
		rt.new_string((if rt.is_true(rt.get_property(rt.new_object('Walker_Comment', [
			'Walker',
		], &this), 'has_children'))
		{ 'parent' } else { '' }).str()),
		var_comment_mutated.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('comment_ID', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0),
		var_args.array_get(rt.new_string('avatar_size'))))))
	{
		rt.echo_val(rt.call_function('get_avatar', [var_comment_mutated.clone(),
			var_args.array_get(rt.new_string('avatar_size'))]))
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_comment_author := rt.call_function('get_comment_author_link', [
		var_comment_mutated.clone()])
	if rt.is_true(rt.identical(rt.new_string('0'), rt.get_property(var_comment_mutated, 'comment_approved')))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_show_pending_links)))) {
		var_comment_author = rt.call_function('get_comment_author', [
			var_comment_mutated.clone()])
	}
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('%s <span class="says">says:</span>')]),
		rt.call_function('sprintf', [rt.new_string('<b class="fn">%s</b>'),
			var_comment_author.clone()]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.new_string('<a href="%s"><time datetime="%s">%s</time></a>'),
		rt.call_function('esc_url', [
			rt.call_function('get_comment_link', [var_comment_mutated.clone(),
				var_args.clone()]),
		]),
		rt.call_function('get_comment_time', [
			rt.new_string('c'),
		]),
		rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%1$s at %2$s')]),
			rt.call_function('get_comment_date', [rt.new_string(''),
				var_comment_mutated.clone()]),
			rt.call_function('get_comment_time', []rt.PhpVal{}),
		]),
	])
	rt.call_function('edit_comment_link', [
		rt.call_function('__', [rt.new_string('Edit')]),
		rt.new_string(' <span class="edit-link">'),
		rt.new_string('</span>'),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_string('0'), rt.get_property(var_comment_mutated,
		'comment_approved')))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_moderation_note)
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('comment_text', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_string('1'), rt.get_property(var_comment_mutated, 'comment_approved')))
		|| rt.is_true(var_show_pending_links) {
		rt.call_function('comment_reply_link', [
			rt.call_function('array_merge', [var_args.clone(),
				rt.create_array([rt.ArrayItem{ key: 'add_below', val: 'div-comment' },
					rt.ArrayItem{ key: 'depth', val: var_depth_mutated },
					rt.ArrayItem{
						key: 'max_depth'
						val: var_args.array_get(rt.new_string('max_depth'))
					}, rt.ArrayItem{ key: 'before', val: '<div class="reply">' },
					rt.ArrayItem{ key: 'after', val: '</div>' }])]),
		])
	}
	// unsupported statement: Stmt_InlineHTML
}

struct Class_Walker {
	rt.PhpObjectBase
}

fn create_walker_comment(_args ...rt.PhpVal) &Class_Walker_Comment {
	mut obj := &Class_Walker_Comment{
		PhpObjectBase: rt.PhpObjectBase{}
		tree_type:     rt.new_string('comment')
		db_fields:     rt.new_array()
	}
	return obj
}

fn create_walker(_args ...rt.PhpVal) &Class_Walker {
	mut obj := &Class_Walker{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Walker_Comment) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'start_lvl' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.start_lvl(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'end_lvl' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.end_lvl(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'display_element' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			this.display_element(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3,
				dispatch_arg_4, dispatch_arg_5)
			return rt.new_null()
		}
		'start_el' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_i64()
			this.start_el(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3,
				dispatch_arg_4)
			return rt.new_null()
		}
		'end_el' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.end_el(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'ping' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.ping(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'filter_comment_text' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.filter_comment_text(dispatch_arg_0, dispatch_arg_1)
		}
		'comment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.comment(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'html5_comment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.html5_comment(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Walker_Comment) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'tree_type' { return this.tree_type }
		'db_fields' { return this.db_fields }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Walker_Comment) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'tree_type' {
			this.tree_type = val
			return true
		}
		'db_fields' {
			this.db_fields = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Walker) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Walker) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Walker) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
