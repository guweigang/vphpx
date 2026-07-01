import rt

fn wp_latest_comments_draft_or_post_title(post i64) rt.PhpVal {
	mut var_title := rt.call_function('get_the_title', [rt.new_int(post)])
	if !rt.is_true(var_title) {
		var_title = rt.call_function('__', [rt.new_string('(no title)')])
	}
	return var_title.dup()
}

fn render_block_core_latest_comments(var_attributes rt.PhpVal) rt.PhpVal {
	if var_attributes.array_isset(rt.new_string('displayExcerpt')) {
		mut var_display_content := rt.new_string(if rt.is_true(var_attributes.array_get('displayExcerpt')) { rt.new_string('excerpt') } else { rt.new_string('none') })
	} else {
		var_display_content = if !(var_attributes.array_get('displayContent')).is_null() { var_attributes.array_get('displayContent') } else { rt.new_string('excerpt') }
	}
	mut var_comments := rt.call_function('get_comments', [rt.call_function('apply_filters', [rt.new_string('widget_comments_args'), rt.create_array([rt.ArrayItem{ key: 'number', val: var_attributes.array_get('commentsToShow') }, rt.ArrayItem{ key: 'status', val: 'approve' }, rt.ArrayItem{ key: 'post_status', val: 'publish' }]), rt.new_array()])])
	mut var_list_items_markup := ''
	if !(!rt.is_true(var_comments)) {
		mut var_post_ids := rt.call_function('array_unique', [rt.call_function('wp_list_pluck', [var_comments.dup(), rt.new_string('comment_post_ID')])])
		rt.call_function('_prime_post_caches', [var_post_ids.dup(), rt.call_function('strpos', [rt.call_function('get_option', [rt.new_string('permalink_structure')]), rt.new_string('%category%')]), rt.new_bool(false)])
		{
			mut iter_1 := var_comments.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_comment := item_1.val
				// unsupported expression: Expr_AssignOp_Concat
				if rt.is_true(var_attributes.array_get('displayAvatar')) {
					mut var_avatar := rt.call_function('get_avatar', [var_comment.dup(), rt.new_int(48), rt.new_string(''), rt.new_string(''), rt.create_array([rt.ArrayItem{ key: 'class', val: 'wp-block-latest-comments__comment-avatar' }])])
					if rt.is_true(var_avatar) {
						// unsupported expression: Expr_AssignOp_Concat
					}
				}
				// unsupported expression: Expr_AssignOp_Concat
				// unsupported expression: Expr_AssignOp_Concat
				mut var_author_url := rt.call_function('get_comment_author_url', [var_comment.dup()])
				if !rt.is_true(var_author_url) && !(!rt.is_true(rt.get_property(var_comment, 'user_id'))) {
					var_author_url = rt.call_function('get_author_posts_url', [rt.get_property(var_comment, 'user_id')])
				}
				mut var_author_markup := ''
				if rt.is_true(var_author_url) {
					// unsupported expression: Expr_AssignOp_Concat
				} else {
					// unsupported expression: Expr_AssignOp_Concat
				}
				mut var_post_title := rt.new_string('<a class="wp-block-latest-comments__comment-link" href="' + (rt.call_function('esc_url', [rt.call_function('get_comment_link', [var_comment.dup()])])).str() + '">' + (wp_latest_comments_draft_or_post_title(rt.get_property(var_comment, 'comment_post_ID'))).str() + '</a>')
				// unsupported expression: Expr_AssignOp_Concat
				if rt.is_true(var_attributes.array_get('displayDate')) {
					// unsupported expression: Expr_AssignOp_Concat
				}
				// unsupported expression: Expr_AssignOp_Concat
				if rt.is_true(rt.identical(rt.new_string('full'), var_display_content)) {
					// unsupported expression: Expr_AssignOp_Concat
				} else if rt.is_true(rt.identical(rt.new_string('excerpt'), var_display_content)) {
					// unsupported expression: Expr_AssignOp_Concat
				}
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
	}
	mut var_classnames := rt.new_array()
	if rt.is_true(var_attributes.array_get('displayAvatar')) {
		var_classnames << 'has-avatars'
	}
	if rt.is_true(var_attributes.array_get('displayDate')) {
		var_classnames << 'has-dates'
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_classnames << 'has-excerpts'
	}
	if !rt.is_true(var_comments) {
		var_classnames << 'no-comments'
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [rt.create_array([rt.ArrayItem{ key: 'class', val: rt.call_function('implode', [rt.new_string(' '), var_classnames.dup()]) }])])
	return if !(!rt.is_true(var_comments)) { rt.call_function('sprintf', [rt.new_string('<ol %1$s>%2$s</ol>'), var_wrapper_attributes.dup(), rt.new_string(var_list_items_markup).dup()]) } else { rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'), var_wrapper_attributes.dup(), rt.call_function('__', [rt.new_string('No comments to show.')])]) }
}

fn register_block_core_latest_comments() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/latest-comments', rt.create_array([rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_latest_comments' }])])
}



pub fn init_wp_includes_blocks_latest_comments_php() {
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('register_block_core_latest_comments')])
}
