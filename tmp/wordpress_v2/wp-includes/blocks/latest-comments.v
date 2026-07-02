import rt

fn wp_latest_comments_draft_or_post_title(post i64) rt.PhpVal {
	mut var_post := post
	mut var_title := rt.new_null()
	var_title = rt.call_function('get_the_title', [rt.new_int(post)])
	if !rt.is_true(var_title) {
		var_title = rt.call_function('__', [rt.new_string('(no title)')])
	}
	return var_title.clone()
}

fn render_block_core_latest_comments(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_display_content := rt.new_null()
	mut var_comments := rt.new_null()
	mut var_list_items_markup := ''
	mut var_post_ids := rt.new_null()
	mut var_comment := rt.new_null()
	mut var_avatar := rt.new_null()
	mut var_author_url := rt.new_null()
	mut var_author_markup := ''
	mut var_post_title := rt.new_null()
	mut var_classnames := []rt.PhpVal{}
	mut var_wrapper_attributes := rt.new_null()
	if var_attributes.array_isset(rt.new_string('displayExcerpt')) {
		var_display_content = rt.new_string((if rt.is_true(var_attributes.array_get(rt.new_string('displayExcerpt'))) {
			'excerpt'
		} else {
			'none'
		}).str())
	} else {
		var_display_content = if !(var_attributes.array_get(rt.new_string('displayContent'))).is_null() {
			var_attributes.array_get(rt.new_string('displayContent'))
		} else {
			rt.new_string('excerpt')
		}
	}
	var_comments = rt.call_function('get_comments', [
		rt.call_function('apply_filters', [rt.new_string('widget_comments_args'),
			rt.create_array([
				rt.ArrayItem{
					key: 'number'
					val: var_attributes.array_get(rt.new_string('commentsToShow'))
				},
				rt.ArrayItem{ key: 'status', val: 'approve' },
				rt.ArrayItem{ key: 'post_status', val: 'publish' },
			]),
			rt.new_array()]),
	])
	var_list_items_markup = ''
	if !(!rt.is_true(var_comments)) {
		var_post_ids = rt.call_function('array_unique', [
			rt.call_function('wp_list_pluck', [var_comments.clone(),
				rt.new_string('comment_post_ID')]),
		])
		rt.call_function('_prime_post_caches', [var_post_ids.clone(),
			rt.call_function('strpos', [
				rt.call_function('get_option', [rt.new_string('permalink_structure')]),
				rt.new_string('%category%'),
			]),
			rt.new_bool(false)])
		mut iter_1 := var_comments.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_comment_shadow := item_1.val
			var_list_items_markup = var_list_items_markup +
				'<li class="wp-block-latest-comments__comment">'
			if rt.is_true(var_attributes.array_get(rt.new_string('displayAvatar'))) {
				var_avatar = rt.call_function('get_avatar', [
					var_comment_shadow.clone(), rt.new_int(48),
					rt.new_string(''), rt.new_string(''),
					rt.create_array([
						rt.ArrayItem{ key: 'class', val: 'wp-block-latest-comments__comment-avatar' },
					])])
				if rt.is_true(var_avatar) {
					var_list_items_markup = var_list_items_markup + var_avatar.str()
				}
			}
			var_list_items_markup = var_list_items_markup + '<article>'
			var_list_items_markup = var_list_items_markup +
				'<footer class="wp-block-latest-comments__comment-meta">'
			var_author_url = rt.call_function('get_comment_author_url', [
				var_comment_shadow.clone()])
			if !rt.is_true(var_author_url)
				&& !(!rt.is_true(rt.get_property(var_comment_shadow, 'user_id'))) {
				var_author_url = rt.call_function('get_author_posts_url', [
					rt.get_property(var_comment_shadow, 'user_id'),
				])
			}
			var_author_markup = ''
			if rt.is_true(var_author_url) {
				var_author_markup = var_author_markup +
					'<a class="wp-block-latest-comments__comment-author" href="' +
					(rt.call_function('esc_url', [var_author_url.clone()])).str() + '">' +
					(rt.call_function('get_comment_author', [var_comment_shadow.clone()])).str() +
					'</a>'
			} else {
				var_author_markup = var_author_markup +
					'<span class="wp-block-latest-comments__comment-author">' +
					(rt.call_function('get_comment_author', [var_comment_shadow.clone()])).str() +
					'</span>'
			}
			var_post_title = rt.new_string(
				'<a class="wp-block-latest-comments__comment-link" href="' +
				(rt.call_function('esc_url', [rt.call_function('get_comment_link', [var_comment_shadow.clone()])])).str() +
				'">' +
				(wp_latest_comments_draft_or_post_title(rt.get_property(var_comment_shadow, 'comment_post_ID'))).str() +
				'</a>')
			var_list_items_markup = var_list_items_markup +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s on %2$s')]), rt.new_string(var_author_markup.str()).clone(), var_post_title.clone()])).str()
			if rt.is_true(var_attributes.array_get(rt.new_string('displayDate'))) {
				var_list_items_markup = var_list_items_markup +(rt.call_function('sprintf', [rt.new_string('<time datetime="%1$s" class="wp-block-latest-comments__comment-date">%2$s</time>'), rt.call_function('esc_attr', [rt.call_function('get_comment_date', [rt.new_string('c'), var_comment_shadow.clone()])]), rt.call_function('date_i18n', [rt.call_function('get_option', [rt.new_string('date_format')]), rt.call_function('get_comment_date', [rt.new_string('U'), var_comment_shadow.clone()])])])).str()
			}
			var_list_items_markup = var_list_items_markup + '</footer>'
			if rt.is_true(rt.identical(rt.new_string('full'), var_display_content)) {
				var_list_items_markup = var_list_items_markup +
					'<div class="wp-block-latest-comments__comment-excerpt">' +
					(rt.call_function('wpautop', [rt.call_function('get_comment_text', [var_comment_shadow.clone()])])).str() +
					'</div>'
			} else if rt.is_true(rt.identical(rt.new_string('excerpt'), var_display_content)) {
				var_list_items_markup = var_list_items_markup +
					'<div class="wp-block-latest-comments__comment-excerpt">' +
					(rt.call_function('wpautop', [rt.call_function('get_comment_excerpt', [var_comment_shadow.clone()])])).str() +
					'</div>'
			}
			var_list_items_markup = var_list_items_markup + '</article></li>'
		}
	}
	var_classnames = rt.new_array()
	if rt.is_true(var_attributes.array_get(rt.new_string('displayAvatar'))) {
		var_classnames << 'has-avatars'
	}
	if rt.is_true(var_attributes.array_get(rt.new_string('displayDate'))) {
		var_classnames << 'has-dates'
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('none'), var_display_content)))) {
		var_classnames << 'has-excerpts'
	}
	if !rt.is_true(var_comments) {
		var_classnames << 'no-comments'
	}
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'class', val: rt.call_function('implode', [
				rt.new_string(' '),
				rt.create_array_from_list(var_classnames),
			]) },
		]),
	])
	return if !(!rt.is_true(var_comments)) { rt.call_function('sprintf', [
			rt.new_string('<ol %1$s>%2$s</ol>'),
			var_wrapper_attributes.clone(),
			rt.new_string(var_list_items_markup.str()).clone(),
		]) } else { rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
			var_wrapper_attributes.clone(),
			rt.call_function('__', [
				rt.new_string('No comments to show.'),
			])]) }
}

fn register_block_core_latest_comments() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/latest-comments'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_latest_comments' },
		]),
	])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_latest_comments')])
}
