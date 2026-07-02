import rt

fn get_comment_author(comment_id i64) rt.PhpVal {
	mut var_comment_id := comment_id
	mut var_comment := rt.new_null()
	mut var_user := rt.new_null()
	mut var_comment_author := rt.new_null()
	var_comment = rt.call_function('get_comment', [rt.new_int(var_comment_id)])
	if !(!rt.is_true(rt.get_property(var_comment, 'comment_ID'))) {
		var_comment_id = (rt.get_property(var_comment, 'comment_ID')).to_i64()
	} else if rt.is_true(rt.call_function('is_scalar', [rt.new_int(var_comment_id)])) {
		var_comment_id = var_comment_id.str()
	} else {
		var_comment_id = '0'
	}
	if !rt.is_true(rt.get_property(var_comment, 'comment_author')) {
		var_user = if !(!rt.is_true(rt.get_property(var_comment, 'user_id'))) { rt.call_function('get_userdata', [
				rt.get_property(var_comment, 'user_id'),
			]) } else { rt.new_bool(false) }
		if rt.is_true(var_user) {
			var_comment_author = rt.get_property(var_user, 'display_name')
		} else {
			var_comment_author = rt.call_function('__', [rt.new_string('Anonymous')])
		}
	} else {
		var_comment_author = rt.get_property(var_comment, 'comment_author')
	}
	return rt.call_function('apply_filters', [rt.new_string('get_comment_author'),
		var_comment_author.clone(), rt.new_int(var_comment_id),
		var_comment.clone()])
}

fn comment_author(comment_id i64) {
	mut var_comment_id := comment_id
	mut var_comment := rt.new_null()
	mut var_comment_author := rt.new_null()
	var_comment = rt.call_function('get_comment', [rt.new_int(var_comment_id)])
	var_comment_author = get_comment_author(var_comment.clone())
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('comment_author'),
		var_comment_author.clone(), rt.get_property(var_comment, 'comment_ID')]))
}

fn get_comment_author_email(comment_id i64) rt.PhpVal {
	mut var_comment_id := comment_id
	mut var_comment := rt.new_null()
	var_comment = rt.call_function('get_comment', [rt.new_int(var_comment_id)])
	return rt.call_function('apply_filters', [rt.new_string('get_comment_author_email'),
		rt.get_property(var_comment, 'comment_author_email'),
		rt.get_property(var_comment, 'comment_ID'), var_comment.clone()])
}

fn comment_author_email(comment_id i64) {
	mut var_comment_id := comment_id
	mut var_comment := rt.new_null()
	mut var_comment_author_email := rt.new_null()
	var_comment = rt.call_function('get_comment', [rt.new_int(var_comment_id)])
	var_comment_author_email = get_comment_author_email(var_comment.clone())
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('author_email'),
		var_comment_author_email.clone(), rt.get_property(var_comment, 'comment_ID')]))
}

fn comment_author_email_link(link_text string, before string, after string, var_comment rt.PhpVal) {
	mut var_link_text := link_text
	mut var_before := before
	mut var_after := after
	mut var_link := rt.new_null()
	var_link = rt.new_string(get_comment_author_email_link(link_text, before, after,
		var_comment.clone()))
	if rt.is_true(var_link) {
		rt.echo_val(var_link)
	}
}

fn get_comment_author_email_link(link_text string, before string, after string, var_comment_arg rt.PhpVal) string {
	mut var_link_text := link_text
	mut var_before := before
	mut var_after := after
	mut var_comment := var_comment_arg
	mut var_comment_author_email := rt.new_null()
	mut var_display := rt.new_null()
	mut var_comment_author_email_link := rt.new_null()
	var_comment = rt.call_function('get_comment', [var_comment.clone()])
	var_comment_author_email = rt.call_function('apply_filters', [
		rt.new_string('comment_email'),
		rt.get_property(var_comment, 'comment_author_email'),
		var_comment.clone(),
	])
	if !(!rt.is_true(var_comment_author_email))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('@'), var_comment_author_email)))) {
		var_display = if rt.is_true(rt.new_bool('' != link_text)) {
			rt.new_string(link_text)
		} else {
			var_comment_author_email
		}
		var_comment_author_email_link = rt.new_string(before +
			(rt.call_function('sprintf', [rt.new_string('<a href="%1$s">%2$s</a>'), rt.call_function('esc_url', [rt.new_string('mailto:' + var_comment_author_email.str())]), rt.call_function('esc_html', [var_display.clone()])])).str() +
			after)
		return var_comment_author_email_link.str()
	} else {
		return ''
	}
	return ''
}

fn get_comment_author_link(comment_id i64) rt.PhpVal {
	mut var_comment_id := comment_id
	mut var_comment := rt.new_null()
	mut var_comment_author_url := rt.new_null()
	mut var_comment_author := rt.new_null()
	mut var_comment_author_link := rt.new_null()
	mut var_rel_parts := rt.new_null()
	mut var_rel := rt.new_null()
	var_comment = rt.call_function('get_comment', [rt.new_int(var_comment_id)])
	if !(!rt.is_true(rt.get_property(var_comment, 'comment_ID'))) {
		var_comment_id = (rt.get_property(var_comment, 'comment_ID')).to_i64()
	} else if rt.is_true(rt.call_function('is_scalar', [rt.new_int(var_comment_id)])) {
		var_comment_id = var_comment_id.str()
	} else {
		var_comment_id = '0'
	}
	var_comment_author_url = get_comment_author_url(var_comment.clone())
	var_comment_author = get_comment_author(var_comment.clone())
	if !rt.is_true(var_comment_author_url)
		|| rt.is_true(rt.identical(rt.new_string('http://'), var_comment_author_url)) {
		var_comment_author_link = var_comment_author.clone()
	} else {
		var_rel_parts = rt.create_array([rt.ArrayItem{ key: none, val: 'ugc' }])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_internal_link', [
			var_comment_author_url.clone(),
		])))))
		{
			var_rel_parts = rt.call_function('array_merge', [
				var_rel_parts.clone(),
				rt.create_array([
					rt.ArrayItem{ key: none, val: 'external' },
					rt.ArrayItem{ key: none, val: 'nofollow' },
				])])
		}
		var_rel_parts = rt.call_function('apply_filters', [
			rt.new_string('comment_author_link_rel'),
			var_rel_parts.clone(),
			var_comment.clone(),
		])
		var_rel = rt.call_function('implode', [rt.new_string(' '),
			var_rel_parts.clone()])
		var_rel = rt.call_function('esc_attr', [var_rel.clone()])
		var_rel = if !(!rt.is_true(var_rel)) { rt.call_function('sprintf', [
				rt.new_string(' rel="%s"'),
				var_rel.clone(),
			]) } else { rt.new_string('') }
		var_comment_author_link = rt.call_function('sprintf', [
			rt.new_string('<a href="%1$s" class="url"%2$s>%3$s</a>'),
			var_comment_author_url.clone(),
			var_rel.clone(),
			var_comment_author.clone(),
		])
	}
	return rt.call_function('apply_filters', [rt.new_string('get_comment_author_link'),
		var_comment_author_link.clone(), var_comment_author.clone(),
		rt.new_int(var_comment_id)])
}

fn comment_author_link(comment_id i64) {
	mut var_comment_id := comment_id
	rt.echo_val(get_comment_author_link(var_comment_id))
}

fn get_comment_author_ip(comment_id i64) rt.PhpVal {
	mut var_comment_id := comment_id
	mut var_comment := rt.new_null()
	var_comment = rt.call_function('get_comment', [rt.new_int(var_comment_id)])
	return rt.call_function('apply_filters', [rt.new_string('get_comment_author_IP'),
		rt.get_property(var_comment, 'comment_author_IP'), rt.get_property(var_comment, 'comment_ID'),
		var_comment.clone()])
	return rt.new_null()
}

fn comment_author_ip(comment_id i64) {
	mut var_comment_id := comment_id
	rt.echo_val(rt.call_function('esc_html', [get_comment_author_ip(var_comment_id)]))
}

fn get_comment_author_url(comment_id i64) rt.PhpVal {
	mut var_comment_id := comment_id
	mut var_comment := rt.new_null()
	mut var_comment_author_url := rt.new_null()
	var_comment = rt.call_function('get_comment', [rt.new_int(var_comment_id)])
	var_comment_author_url = rt.new_string('')
	var_comment_id = 0
	if !(!rt.is_true(var_comment)) {
		var_comment_author_url = if rt.is_true(rt.identical(rt.new_string('http://'), rt.get_property(var_comment,
			'comment_author_url')))
		{
			rt.new_string('')
		} else {
			rt.get_property(var_comment, 'comment_author_url')
		}
		var_comment_author_url = rt.call_function('esc_url', [
			var_comment_author_url.clone(),
			rt.create_array([
				rt.ArrayItem{ key: none, val: 'http' },
				rt.ArrayItem{ key: none, val: 'https' },
			])])
		var_comment_id = (rt.get_property(var_comment, 'comment_ID')).to_i64()
	}
	return rt.call_function('apply_filters', [rt.new_string('get_comment_author_url'),
		var_comment_author_url.clone(), rt.new_int(var_comment_id),
		var_comment.clone()])
}

fn comment_author_url(comment_id i64) {
	mut var_comment_id := comment_id
	mut var_comment := rt.new_null()
	mut var_comment_author_url := rt.new_null()
	var_comment = rt.call_function('get_comment', [rt.new_int(var_comment_id)])
	var_comment_author_url = get_comment_author_url(var_comment.clone())
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('comment_url'),
		var_comment_author_url.clone(), rt.get_property(var_comment, 'comment_ID')]))
}

fn get_comment_author_url_link(link_text string, before string, after string, comment i64) rt.PhpVal {
	mut var_link_text := link_text
	mut var_before := before
	mut var_after := after
	mut var_comment := comment
	mut var_comment_author_url := rt.new_null()
	mut var_display := rt.new_null()
	mut var_comment_author_url_link := rt.new_null()
	var_comment_author_url = get_comment_author_url(comment)
	var_display = if rt.is_true(rt.new_bool('' != link_text)) {
		rt.new_string(link_text)
	} else {
		var_comment_author_url
	}
	var_display = rt.call_function('str_replace', [rt.new_string('http://www.'),
		rt.new_string(''), var_display.clone()])
	var_display = rt.call_function('str_replace', [rt.new_string('http://'),
		rt.new_string(''), var_display.clone()])
	if rt.is_true(rt.call_function('str_ends_with', [var_display.clone(),
		rt.new_string('/')]))
	{
		var_display = rt.call_function('substr', [var_display.clone(),
			rt.new_int(0), rt.new_int(-1)])
	}
	var_comment_author_url_link = rt.new_string(before +
		(rt.call_function('sprintf', [rt.new_string('<a href="%1$s" rel="external">%2$s</a>'), var_comment_author_url.clone(), var_display.clone()])).str() +
		after)
	return rt.call_function('apply_filters', [
		rt.new_string('get_comment_author_url_link'),
		var_comment_author_url_link.clone(),
	])
}

fn comment_author_url_link(link_text string, before string, after string, comment i64) {
	mut var_link_text := link_text
	mut var_before := before
	mut var_after := after
	mut var_comment := comment
	rt.echo_val(get_comment_author_url_link(link_text, before, after, comment))
}

fn comment_class(css_class string, var_comment rt.PhpVal, var_post rt.PhpVal, display bool) rt.PhpVal {
	mut var_css_class := css_class
	mut var_display := display
	var_css_class = 'class="' +
		(rt.call_function('implode', [rt.new_string(' '), get_comment_class(var_css_class, var_comment.clone(), var_post.clone())])).str() +
		'"'
	if var_display {
		print(var_css_class)
	} else {
		return rt.new_string(var_css_class.str())
	}
	return rt.new_null()
}

fn get_comment_class(css_class string, var_comment_id rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	mut var_css_class := css_class
	mut var_classes := rt.new_null()
	mut var_comment := rt.new_null()
	mut var_user := rt.new_null()
	mut var__post := rt.new_null()
	mut var_comment_alt := i64(0)
	mut var_comment_depth := i64(0)
	mut var_comment_thread_alt := i64(0)
	var_classes = rt.new_array()
	var_comment = rt.call_function('get_comment', [var_comment_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_comment)))) {
		return var_classes.clone()
	}
	var_classes.array_push(if !rt.is_true(rt.get_property(var_comment, 'comment_type')) {
		rt.new_string('comment')
	} else {
		rt.get_property(var_comment, 'comment_type')
	})
	var_user = if rt.is_true(rt.get_property(var_comment, 'user_id')) { rt.call_function('get_userdata', [
			rt.get_property(var_comment, 'user_id'),
		]) } else { rt.new_bool(false) }
	if rt.is_true(var_user) {
		var_classes.array_push('byuser')
		var_classes.array_push('comment-author-' +(rt.call_function('sanitize_html_class', [rt.get_property(var_user, 'user_nicename'), rt.get_property(var_comment, 'user_id')])).str())
		var__post = rt.call_function('get_post', [var_post.clone()])
		if rt.is_true(var__post) {
			if rt.is_true(rt.identical(rt.get_property(var_comment, 'user_id'), rt.get_property(var__post,
				'post_author')))
			{
				var_classes.array_push('bypostauthor')
			}
		}
	}
	if var_comment_alt == 0 {
		var_comment_alt = 0
	}
	if var_comment_depth == 0 {
		var_comment_depth = 1
	}
	if var_comment_thread_alt == 0 {
		var_comment_thread_alt = 0
	}
	if rt.is_true(var_comment_alt % 2) {
		var_classes.array_push('odd')
		var_classes.array_push('alt')
	} else {
		var_classes.array_push('even')
	}
	var_comment_alt += 1
	if 1 == var_comment_depth {
		if rt.is_true(var_comment_thread_alt % 2) {
			var_classes.array_push('thread-odd')
			var_classes.array_push('thread-alt')
		} else {
			var_classes.array_push('thread-even')
		}
		var_comment_thread_alt += 1
	}
	var_classes.array_push('depth-${var_comment_depth.str()}')
	if !(var_css_class == '') {
		if !(rt.new_string(var_css_class.str()).is_array()) {
			var_css_class = (rt.call_function('preg_split', [
				rt.new_string('#\\s+#'), rt.new_string(var_css_class.str())])).str()
		}
		var_classes = rt.call_function('array_merge', [var_classes.clone(),
			rt.new_string(var_css_class.str())])
	}
	var_classes = rt.call_function('array_map', [rt.new_string('esc_attr'),
		var_classes.clone()])
	return rt.call_function('apply_filters', [rt.new_string('comment_class'),
		var_classes.clone(), rt.new_string(var_css_class.str()),
		rt.get_property(var_comment, 'comment_ID'), var_comment.clone(),
		var_post.clone()])
}

fn get_comment_date(format string, comment_id i64) rt.PhpVal {
	mut var_format := format
	mut var_comment_id := comment_id
	mut var_comment := rt.new_null()
	mut var__format := rt.new_null()
	mut var_comment_date := rt.new_null()
	var_comment = rt.call_function('get_comment', [rt.new_int(var_comment_id)])
	var__format = if !(format == '') { rt.new_string(format) } else { rt.call_function('get_option', [
			rt.new_string('date_format'),
		]) }
	var_comment_date = rt.call_function('mysql2date', [var__format.clone(),
		rt.get_property(var_comment, 'comment_date')])
	return rt.call_function('apply_filters', [rt.new_string('get_comment_date'),
		var_comment_date.clone(), rt.new_string(format), var_comment.clone()])
}

fn comment_date(format string, comment_id i64) {
	mut var_format := format
	mut var_comment_id := comment_id
	rt.echo_val(get_comment_date(format, var_comment_id))
}

fn get_comment_excerpt(comment_id i64) rt.PhpVal {
	mut var_comment_id := comment_id
	mut var_comment := rt.new_null()
	mut var_comment_text := rt.new_null()
	mut var_comment_excerpt_length := rt.new_null()
	mut var_comment_excerpt := rt.new_null()
	var_comment = rt.call_function('get_comment', [rt.new_int(var_comment_id)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('post_password_required', [
		rt.get_property(var_comment, 'comment_post_ID'),
	])))))
	{
		var_comment_text = rt.call_function('strip_tags', [
			rt.call_function('str_replace', [
				rt.create_array([rt.ArrayItem{ key: none, val: '\n' },
					rt.ArrayItem{ key: none, val: '\r' }]),
				rt.new_string(' '),
				rt.get_property(var_comment, 'comment_content'),
			]),
		])
	} else {
		var_comment_text = rt.call_function('__', [rt.new_string('Password protected')])
	}
	var_comment_excerpt_length = rt.new_int((rt.call_function('_x', [
		rt.new_string('20'), rt.new_string('comment_excerpt_length')])).to_i64())
	var_comment_excerpt_length = rt.call_function('apply_filters', [
		rt.new_string('comment_excerpt_length'),
		var_comment_excerpt_length.clone(),
	])
	var_comment_excerpt = rt.call_function('wp_trim_words', [
		var_comment_text.clone(), var_comment_excerpt_length.clone(),
		rt.new_string('&hellip;')])
	return rt.call_function('apply_filters', [rt.new_string('get_comment_excerpt'),
		var_comment_excerpt.clone(), rt.get_property(var_comment, 'comment_ID'),
		var_comment.clone()])
}

fn comment_excerpt(comment_id i64) {
	mut var_comment_id := comment_id
	mut var_comment := rt.new_null()
	mut var_comment_excerpt := rt.new_null()
	var_comment = rt.call_function('get_comment', [rt.new_int(var_comment_id)])
	var_comment_excerpt = get_comment_excerpt(var_comment.clone())
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('comment_excerpt'),
		var_comment_excerpt.clone(), rt.get_property(var_comment, 'comment_ID')]))
}

fn get_comment_id() rt.PhpVal {
	mut var_comment := rt.new_null()
	mut var_comment_id := rt.new_null()
	var_comment = rt.call_function('get_comment', []rt.PhpVal{})
	var_comment_id = if !(!rt.is_true(rt.get_property(var_comment, 'comment_ID'))) {
		rt.get_property(var_comment, 'comment_ID')
	} else {
		rt.new_string('0')
	}
	return rt.call_function('apply_filters', [rt.new_string('get_comment_ID'),
		var_comment_id.clone(), var_comment.clone()])
	return rt.new_null()
}

fn comment_id() {
	rt.echo_val(get_comment_id())
}

fn get_comment_link(var_comment_arg rt.PhpVal, var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_comment := var_comment_arg
	mut var_args := var_args_arg
	mut var_wp_rewrite := rt.new_null()
	mut var_in_comment_loop := rt.new_null()
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_comment_link := rt.new_null()
	mut var_cpage := rt.new_null()
	var_comment = rt.call_function('get_comment', [var_comment.clone()])
	if !(var_args.clone().is_array()) {
		var_args = rt.create_array([rt.ArrayItem{ key: 'page', val: var_args }])
	}
	var_defaults = {
		'type':      rt.new_string('all')
		'page':      rt.new_string('')
		'per_page':  rt.new_string('')
		'max_depth': rt.new_string('')
		'cpage':     rt.new_null()
	}
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array_from_native_map(var_defaults)])
	var_comment_link = rt.call_function('get_permalink', [
		rt.get_property(var_comment, 'comment_post_ID'),
	])
	if !(var_args.array_get(rt.new_string('cpage')).is_null()) {
		var_cpage = var_args.array_get(rt.new_string('cpage'))
	} else {
		if rt.is_true(rt.identical(rt.new_string(''), var_args.array_get(rt.new_string('per_page'))))
			&& rt.is_true(rt.call_function('get_option', [rt.new_string('page_comments')])) {
			var_args.array_set('per_page', rt.call_function('get_option', [
				rt.new_string('comments_per_page'),
			]))
		}
		if !rt.is_true(var_args.array_get(rt.new_string('per_page'))) {
			var_args.array_set('per_page', 0)
			var_args.array_set('page', 0)
		}
		var_cpage = var_args.array_get(rt.new_string('page'))
		if rt.is_true(rt.identical(rt.new_string(''), var_cpage)) {
			if !(!rt.is_true(var_in_comment_loop)) {
				var_cpage = rt.new_int((rt.call_function('get_query_var', [
					rt.new_string('cpage'),
				])).to_i64())
			} else {
				var_cpage = rt.call_function('get_page_of_comment', [
					rt.get_property(var_comment, 'comment_ID'),
					var_args.clone(),
				])
			}
		}
		if rt.is_true(rt.identical(rt.new_string('oldest'), rt.call_function('get_option', [rt.new_string('default_comments_page')])))
			&& rt.is_true(rt.identical(rt.new_int(1), var_cpage)) {
			var_cpage = rt.new_string('')
		}
	}
	if rt.is_true(var_cpage)
		&& rt.is_true(rt.call_function('get_option', [rt.new_string('page_comments')])) {
		if rt.is_true(rt.call_method(var_wp_rewrite, 'using_permalinks', []rt.PhpVal{})) {
			var_comment_link = rt.new_string(
				(rt.call_function('trailingslashit', [var_comment_link.clone()])).str() +
				(rt.get_property(var_wp_rewrite, 'comments_pagination_base')).str() + '-' +
				var_cpage.str())
		} else {
			var_comment_link = rt.call_function('add_query_arg', [
				rt.new_string('cpage'), var_cpage.clone(), var_comment_link.clone()])
		}
	}
	if rt.is_true(rt.call_method(var_wp_rewrite, 'using_permalinks', []rt.PhpVal{})) {
		var_comment_link = rt.call_function('user_trailingslashit', [
			var_comment_link.clone(), rt.new_string('comment')])
	}
	var_comment_link = rt.new_string(var_comment_link.str() + '#comment-' +
		(rt.get_property(var_comment, 'comment_ID')).str())
	return rt.call_function('apply_filters', [rt.new_string('get_comment_link'),
		var_comment_link.clone(), var_comment.clone(), var_args.clone(),
		var_cpage.clone()])
}

fn get_comments_link(post i64) rt.PhpVal {
	mut var_post := post
	mut var_hash := ''
	mut var_comments_link := rt.new_null()
	var_hash = if rt.is_true(get_comments_number(post)) { '#comments' } else { '#respond' }
	var_comments_link = rt.new_string(
		(rt.call_function('get_permalink', [rt.new_int(post)])).str() + var_hash)
	return rt.call_function('apply_filters', [rt.new_string('get_comments_link'),
		var_comments_link.clone(), rt.new_int(post)])
}

fn comments_link(deprecated string, deprecated_2 string) {
	mut var_deprecated := deprecated
	mut var_deprecated_2 := deprecated_2
	if !(deprecated == '') {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('0.72')])
	}
	if !(deprecated_2 == '') {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('1.3.0')])
	}
	rt.echo_val(rt.call_function('esc_url', [get_comments_link(0)]))
}

fn get_comments_number(post i64) rt.PhpVal {
	mut var_post := post
	mut var_comments_number := rt.new_null()
	mut var_post_id := rt.new_null()
	var_post = (rt.call_function('get_post', [rt.new_int(var_post)])).to_i64()
	var_comments_number = if var_post != 0 {
		rt.get_property(rt.new_int(var_post), 'comment_count')
	} else {
		rt.new_int(0)
	}
	var_post_id = if var_post != 0 {
		rt.get_property(rt.new_int(var_post), 'ID')
	} else {
		rt.new_int(0)
	}
	return rt.call_function('apply_filters', [rt.new_string('get_comments_number'),
		var_comments_number.clone(), var_post_id.clone()])
}

fn comments_number(zero bool, one bool, more bool, post i64) {
	mut var_zero := zero
	mut var_one := one
	mut var_more := more
	mut var_post := post
	rt.echo_val(get_comments_number_text(zero, one, more, var_post))
}

fn get_comments_number_text(zero bool, one bool, more bool, post i64) rt.PhpVal {
	mut var_zero := zero
	mut var_one := one
	mut var_more := more
	mut var_post := post
	mut var_comments_number := rt.new_null()
	mut var_comments_number_text := rt.new_null()
	mut var_text := rt.new_null()
	mut var_new_text := rt.new_null()
	var_comments_number = rt.new_int((get_comments_number(var_post)).to_i64())
	if rt.is_true(rt.greater(var_comments_number, rt.new_int(1))) {
		if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(var_more))) {
			var_comments_number_text = rt.call_function('sprintf', [
				rt.call_function('_n', [rt.new_string('%s Comment'),
					rt.new_string('%s Comments'), var_comments_number.clone()]),
				rt.call_function('number_format_i18n', [var_comments_number.clone()]),
			])
		} else {
			if rt.is_true(rt.identical(rt.new_string('on'), rt.call_function('_x', [
				rt.new_string('off'),
				rt.new_string('Comment number declension: on or off'),
			])))
			{
				var_text = rt.call_function('preg_replace', [
					rt.new_string('#<span class="screen-reader-text">.+?</span>#'),
					rt.new_string(''),
					rt.new_bool(var_more),
				])
				var_text = rt.call_function('preg_replace', [
					rt.new_string('/&.+?;/'), rt.new_string(''),
					var_text.clone()])
				var_text = rt.new_string(rt.call_function('strip_tags', [
					var_text.clone()]).to_string().trim_space())
				if rt.is_true(var_text)
					&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/[0-9]+/'), var_text.clone()])))))
					&& rt.is_true(rt.call_function('str_contains', [rt.new_bool(var_more), rt.new_string('%')])) {
					var_new_text = rt.call_function('_n', [rt.new_string('%s Comment'),
						rt.new_string('%s Comments'), var_comments_number.clone()])
					var_new_text = rt.new_string(rt.call_function('sprintf', [
						var_new_text.clone(), rt.new_string('')]).to_string().trim_space())
					var_more = (rt.call_function('str_replace', [
						var_text.clone(), var_new_text.clone(),
						rt.new_bool(var_more)])).to_bool()
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
						rt.new_bool(var_more),
						rt.new_string('%'),
					])))))
					{
						var_more = '% ' + var_more.str()
					}
				}
			}
			var_comments_number_text = rt.call_function('str_replace', [
				rt.new_string('%'),
				rt.call_function('number_format_i18n', [var_comments_number.clone()]),
				rt.new_bool(var_more),
			])
		}
	} else if rt.is_true(rt.identical(rt.new_int(0), var_comments_number)) {
		var_comments_number_text = if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(zero))) { rt.call_function('__', [
				rt.new_string('No Comments'),
			]) } else { rt.new_bool(zero) }
	} else {
		var_comments_number_text = if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(one))) { rt.call_function('__', [
				rt.new_string('1 Comment'),
			]) } else { rt.new_bool(one) }
	}
	return rt.call_function('apply_filters', [rt.new_string('comments_number'),
		var_comments_number_text.clone(), var_comments_number.clone()])
}

fn get_comment_text(comment_id i64, var_args rt.PhpVal) rt.PhpVal {
	mut var_comment_id := comment_id
	mut var_comment := rt.new_null()
	mut var_comment_text := rt.new_null()
	mut var_parent := rt.new_null()
	mut var_parent_link := rt.new_null()
	mut var_name := rt.new_null()
	var_comment = rt.call_function('get_comment', [rt.new_int(var_comment_id)])
	var_comment_text = rt.get_property(var_comment, 'comment_content')
	if rt.is_true(rt.call_function('is_comment_feed', []rt.PhpVal{}))
		&& rt.is_true(rt.get_property(var_comment, 'comment_parent')) {
		var_parent = rt.call_function('get_comment', [
			rt.get_property(var_comment, 'comment_parent'),
		])
		if rt.is_true(var_parent) {
			var_parent_link = rt.call_function('esc_url', [
				get_comment_link(var_parent.clone(), rt.new_null()),
			])
			var_name = get_comment_author(var_parent.clone())
			var_comment_text = rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('ent2ncr', [rt.call_function('__', [rt.new_string('In reply to %s.')])]), rt.new_string('<a href="' + var_parent_link.str() +
				'">' + var_name.str() + '</a>')])).str() + '\n\n' + var_comment_text.str())
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('get_comment_text'),
		var_comment_text.clone(), var_comment.clone(), var_args.clone()])
}

fn comment_text(comment_id i64, var_args rt.PhpVal) {
	mut var_comment_id := comment_id
	mut var_comment := rt.new_null()
	mut var_comment_text := rt.new_null()
	var_comment = rt.call_function('get_comment', [rt.new_int(var_comment_id)])
	var_comment_text = get_comment_text(var_comment.clone(), var_args.clone())
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('comment_text'),
		var_comment_text.clone(), var_comment.clone(), var_args.clone()]))
}

fn get_comment_time(format string, gmt bool, translate bool, comment_id i64) string {
	mut var_format := format
	mut var_gmt := gmt
	mut var_translate := translate
	mut var_comment_id := comment_id
	mut var_comment := rt.new_null()
	mut var_comment_date := rt.new_null()
	mut var__format := rt.new_null()
	mut var_comment_time := rt.new_null()
	var_comment = rt.call_function('get_comment', [rt.new_int(var_comment_id)])
	if rt.is_true(rt.identical(rt.new_null(), var_comment)) {
		return ''
	}
	var_comment_date = if var_gmt {
		rt.get_property(var_comment, 'comment_date_gmt')
	} else {
		rt.get_property(var_comment, 'comment_date')
	}
	var__format = if !(format == '') { rt.new_string(format) } else { rt.call_function('get_option', [
			rt.new_string('time_format'),
		]) }
	var_comment_time = rt.call_function('mysql2date', [var__format.clone(),
		var_comment_date.clone(), rt.new_bool(translate)])
	return (rt.call_function('apply_filters', [rt.new_string('get_comment_time'),
		var_comment_time.clone(), rt.new_string(format), rt.new_bool(gmt),
		rt.new_bool(translate), var_comment.clone()])).str()
}

fn comment_time(format string, comment_id i64) {
	mut var_format := format
	mut var_comment_id := comment_id
	print(get_comment_time(format, false, true, var_comment_id))
}

fn get_comment_type(comment_id i64) rt.PhpVal {
	mut var_comment_id := comment_id
	mut var_comment := rt.new_null()
	var_comment = rt.call_function('get_comment', [rt.new_int(var_comment_id)])
	if rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_comment, 'comment_type'))) {
		rt.set_property(var_comment, 'comment_type', rt.new_string('comment'))
	}
	return rt.call_function('apply_filters', [rt.new_string('get_comment_type'),
		rt.get_property(var_comment, 'comment_type'), rt.get_property(var_comment, 'comment_ID'),
		var_comment.clone()])
}

fn comment_type(comment_text bool, trackback_text bool, pingback_text bool) {
	mut var_comment_text := comment_text
	mut var_trackback_text := trackback_text
	mut var_pingback_text := pingback_text
	mut var_type := rt.new_null()
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(var_comment_text))) {
		var_comment_text = (rt.call_function('_x', [rt.new_string('Comment'),
			rt.new_string('noun')])).to_bool()
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(var_trackback_text))) {
		var_trackback_text = (rt.call_function('__', [rt.new_string('Trackback')])).to_bool()
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(var_pingback_text))) {
		var_pingback_text = (rt.call_function('__', [rt.new_string('Pingback')])).to_bool()
	}
	var_type = get_comment_type(0)
	mut switch_val_1 := var_type
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('trackback'))) {
		print(if var_trackback_text { '1' } else { '' })
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('pingback'))) {
		print(if var_pingback_text { '1' } else { '' })
	} else {
		print(if var_comment_text { '1' } else { '' })
	}
}

fn get_trackback_url() rt.PhpVal {
	mut var_trackback_url := rt.new_null()
	if rt.is_true(rt.call_function('get_option', [rt.new_string('permalink_structure')])) {
		var_trackback_url = rt.new_string(
			(rt.call_function('trailingslashit', [rt.call_function('get_permalink', []rt.PhpVal{})])).str() +(rt.call_function('user_trailingslashit', [rt.new_string('trackback'), rt.new_string('single_trackback')])).str())
	} else {
		var_trackback_url = rt.new_string(
			(rt.call_function('get_option', [rt.new_string('siteurl')])).str() +
			'/wp-trackback.php?p=' + (rt.call_function('get_the_ID', []rt.PhpVal{})).str())
	}
	return rt.call_function('apply_filters', [rt.new_string('trackback_url'),
		var_trackback_url.clone()])
}

fn trackback_url(deprecated_echo bool) rt.PhpVal {
	mut var_deprecated_echo := deprecated_echo
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true),
		rt.new_bool(deprecated_echo)))))
	{
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('2.5.0'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Use %s instead if you do not want the value echoed.'),
				]),
				rt.new_string('<code>get_trackback_url()</code>'),
			])])
	}
	if var_deprecated_echo {
		rt.echo_val(get_trackback_url())
	} else {
		return get_trackback_url()
	}
	return rt.new_null()
}

fn trackback_rdf(deprecated string) {
	mut var_deprecated := deprecated
	if !(deprecated == '') {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('2.5.0')])
	}
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_USER_AGENT'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')), rt.new_string('W3C_Validator')]))))) {
		return
	}
	print('<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"\n\t\t\txmlns:dc="http://purl.org/dc/elements/1.1/"\n\t\t\txmlns:trackback="http://madskills.com/public/xml/rss/module/trackback/">\n\t\t<rdf:Description rdf:about="')
	rt.call_function('the_permalink', []rt.PhpVal{})
	print('"' + '\n')
	print('    dc:identifier="')
	rt.call_function('the_permalink', []rt.PhpVal{})
	print('"' + '\n')
	print('    dc:title="' +
		(rt.call_function('str_replace', [rt.new_string('--'), rt.new_string('&#x2d;&#x2d;'), rt.call_function('wptexturize', [rt.call_function('strip_tags', [rt.call_function('get_the_title', []rt.PhpVal{})])])])).str() +
		'"' + '\n')
	print('    trackback:ping="' + (get_trackback_url()).str() + '"' + ' />\n')
	print('</rdf:RDF>')
}

fn comments_open(var_post rt.PhpVal) rt.PhpVal {
	mut var__post := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_comments_open := false
	var__post = rt.call_function('get_post', [var_post.clone()])
	var_post_id = if rt.is_true(var__post) {
		rt.get_property(var__post, 'ID')
	} else {
		rt.new_int(0)
	}
	var_comments_open = rt.is_true(var__post)
		&& rt.is_true(rt.identical(rt.new_string('open'), rt.get_property(var__post, 'comment_status')))
	return rt.call_function('apply_filters', [rt.new_string('comments_open'),
		rt.new_bool(var_comments_open).clone(), var_post_id.clone()])
}

fn pings_open(var_post rt.PhpVal) rt.PhpVal {
	mut var__post := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_pings_open := false
	var__post = rt.call_function('get_post', [var_post.clone()])
	var_post_id = if rt.is_true(var__post) {
		rt.get_property(var__post, 'ID')
	} else {
		rt.new_int(0)
	}
	var_pings_open = rt.is_true(var__post)
		&& rt.is_true(rt.identical(rt.new_string('open'), rt.get_property(var__post, 'ping_status')))
	return rt.call_function('apply_filters', [rt.new_string('pings_open'),
		rt.new_bool(var_pings_open).clone(), var_post_id.clone()])
}

fn wp_comment_form_unfiltered_html_nonce() {
	mut var_post := rt.new_null()
	mut var_post_id := rt.new_null()
	var_post = rt.call_function('get_post', []rt.PhpVal{})
	var_post_id = if rt.is_true(var_post) { rt.get_property(var_post, 'ID') } else { rt.new_int(0) }
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('unfiltered_html')])) {
		rt.call_function('wp_nonce_field', [
			rt.new_string('unfiltered-html-comment_' + var_post_id.str()),
			rt.new_string('_wp_unfiltered_html_comment_disabled'),
			rt.new_bool(false),
		])
		rt.call_function('wp_print_inline_script_tag', [
			rt.new_string(
				"(function(){if(window===window.parent){document.getElementById('_wp_unfiltered_html_comment_disabled').name='_wp_unfiltered_html_comment';}})();\n//# sourceURL=" +
				(rt.call_function('rawurlencode', [rt.new_string(@FN)])).str()),
		])
	}
}

fn comments_template(file string, separate_comments bool) {
	mut var_file := file
	mut var_separate_comments := separate_comments
	mut var_wp_query := rt.new_null()
	mut var_withcomments := rt.new_null()
	mut var_post := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_id := rt.new_null()
	mut var_comment := rt.new_null()
	mut var_user_login := rt.new_null()
	mut var_user_identity := rt.new_null()
	mut var_wp_stylesheet_path := rt.new_null()
	mut var_wp_template_path := rt.new_null()
	mut var_comments := rt.new_null()
	mut var_comments_by_type := rt.new_null()
	mut var_req := rt.new_null()
	mut var_commenter := rt.new_null()
	mut var_comment_author := rt.new_null()
	mut var_comment_author_email := rt.new_null()
	mut var_comment_author_url := rt.new_null()
	mut var_comment_args := rt.new_null()
	mut var_unapproved_email := rt.new_null()
	mut var_per_page := rt.new_null()
	mut var_page := rt.new_null()
	mut var_top_level_query := rt.new_null()
	mut var_top_level_args := rt.new_null()
	mut var_top_level_count := rt.new_null()
	mut var_comment_query := rt.new_null()
	mut var__comments := rt.new_null()
	mut var_comments_flat := rt.new_null()
	mut var__comment := rt.new_null()
	mut var_comment_children := rt.new_null()
	mut var_comment_child := rt.new_null()
	mut var_overridden_cpage := false
	mut var_theme_template := rt.new_null()
	mut var_include := rt.new_null()
	if !(rt.is_true(rt.call_function('is_single', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('is_page', []rt.PhpVal{})) || rt.is_true(var_withcomments))
		|| !rt.is_true(var_post) {
		return
	}
	if var_file == '' {
		var_file = '/comments.php'
	}
	var_req = rt.call_function('get_option', [rt.new_string('require_name_email')])
	var_commenter = rt.call_function('wp_get_current_commenter', []rt.PhpVal{})
	var_comment_author = var_commenter.array_get(rt.new_string('comment_author'))
	var_comment_author_email = var_commenter.array_get(rt.new_string('comment_author_email'))
	var_comment_author_url = rt.call_function('esc_url', [
		var_commenter.array_get(rt.new_string('comment_author_url')),
	])
	var_comment_args = rt.create_array([
		rt.ArrayItem{ key: 'orderby', val: 'comment_date_gmt' },
		rt.ArrayItem{ key: 'order', val: 'ASC' },
		rt.ArrayItem{ key: 'status', val: 'approve' },
		rt.ArrayItem{ key: 'post_id', val: rt.get_property(var_post, 'ID') },
		rt.ArrayItem{ key: 'no_found_rows', val: false },
	])
	if rt.is_true(rt.call_function('get_option', [rt.new_string('thread_comments')])) {
		var_comment_args.array_set('hierarchical', 'threaded')
	} else {
		var_comment_args.array_set('hierarchical', false)
	}
	if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
		var_comment_args.array_set('include_unapproved', rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('get_current_user_id', []rt.PhpVal{}) },
		]))
	} else {
		var_unapproved_email = rt.call_function('wp_get_unapproved_comment_author_email',
			[]rt.PhpVal{})
		if rt.is_true(var_unapproved_email) {
			var_comment_args.array_set('include_unapproved', rt.create_array([
				rt.ArrayItem{ key: none, val: var_unapproved_email },
			]))
		}
	}
	var_per_page = rt.new_int(0)
	if rt.is_true(rt.call_function('get_option', [rt.new_string('page_comments')])) {
		var_per_page = rt.new_int((rt.call_function('get_query_var', [
			rt.new_string('comments_per_page'),
		])).to_i64())
		if rt.is_true(rt.identical(rt.new_int(0), var_per_page)) {
			var_per_page = rt.new_int((rt.call_function('get_option', [
				rt.new_string('comments_per_page'),
			])).to_i64())
		}
		var_comment_args.array_set('number', var_per_page.clone())
		var_page = rt.new_int((rt.call_function('get_query_var', [
			rt.new_string('cpage')])).to_i64())
		if rt.is_true(var_page) {
			var_comment_args.array_set('offset', rt.mul(rt.sub(var_page, rt.new_int(1)),
				var_per_page))
		} else if rt.is_true(rt.identical(rt.new_string('oldest'), rt.call_function('get_option', [
			rt.new_string('default_comments_page'),
		])))
		{
			var_comment_args.array_set('offset', 0)
		} else {
			var_top_level_query = create_wp_comment_query()
			var_top_level_args = rt.create_array([
				rt.ArrayItem{ key: 'count', val: true },
				rt.ArrayItem{ key: 'orderby', val: false },
				rt.ArrayItem{ key: 'post_id', val: rt.get_property(var_post, 'ID') },
				rt.ArrayItem{ key: 'status', val: 'approve' },
			])
			if rt.is_true(var_comment_args.array_get(rt.new_string('hierarchical'))) {
				var_top_level_args.array_set('parent', 0)
			}
			if var_comment_args.array_isset(rt.new_string('include_unapproved')) {
				var_top_level_args.array_set('include_unapproved',
					var_comment_args.array_get(rt.new_string('include_unapproved')))
			}
			var_top_level_args = rt.call_function('apply_filters', [
				rt.new_string('comments_template_top_level_query_args'),
				var_top_level_args.clone(),
			])
			var_top_level_count = var_top_level_query.query(var_top_level_args.clone())
			var_comment_args.array_set('offset', rt.mul(rt.new_int((rt.call_function('ceil', [
				rt.div(var_top_level_count, var_per_page),
			])).to_i64()) - 1, var_per_page))
		}
	}
	var_comment_args = rt.call_function('apply_filters', [
		rt.new_string('comments_template_query_args'),
		var_comment_args.clone(),
	])
	var_comment_query = create_wp_comment_query(var_comment_args.clone())
	var__comments = rt.get_property(var_comment_query, 'comments')
	if rt.is_true(var_comment_args.array_get(rt.new_string('hierarchical'))) {
		var_comments_flat = rt.new_array()
		mut iter_1 := var__comments.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var__comment_shadow := item_1.val
			var_comments_flat.array_push(var__comment_shadow.clone())
			var_comment_children = rt.call_method(var__comment_shadow, 'get_children', [
				rt.create_array([rt.ArrayItem{ key: 'format', val: 'flat' },
					rt.ArrayItem{
						key: 'status'
						val: var_comment_args.array_get(rt.new_string('status'))
					}, rt.ArrayItem{
						key: 'orderby'
						val: var_comment_args.array_get(rt.new_string('orderby'))
					}]),
			])
			mut iter_2 := var_comment_children.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_comment_child_shadow := item_2.val
				var_comments_flat.array_push(var_comment_child_shadow.clone())
			}
		}
	} else {
		var_comments_flat = var__comments.clone()
	}
	rt.set_property(var_wp_query, 'comments', rt.call_function('apply_filters', [
		rt.new_string('comments_array'),
		var_comments_flat.clone(),
		rt.get_property(var_post, 'ID'),
	]))
	var_comments = rt.get_property(var_wp_query, 'comments')
	rt.set_property(var_wp_query, 'comment_count', rt.new_int(rt.get_property(var_wp_query,
		'comments').array_count()))
	rt.set_property(var_wp_query, 'max_num_comment_pages', rt.get_property(var_comment_query,
		'max_num_pages'))
	if var_separate_comments {
		rt.set_property(var_wp_query, 'comments_by_type', rt.call_function('separate_comments', [
			var_comments.clone(),
		]))
		var_comments_by_type = rt.get_property(var_wp_query, 'comments_by_type')
	} else {
		rt.set_property(var_wp_query, 'comments_by_type', rt.new_array())
	}
	var_overridden_cpage = false
	if rt.is_true(rt.identical(rt.new_string(''), rt.call_function('get_query_var', [rt.new_string('cpage')])))
		&& rt.is_true(rt.greater(rt.get_property(var_wp_query, 'max_num_comment_pages'), rt.new_int(1))) {
		rt.call_function('set_query_var', [rt.new_string('cpage'), if rt.is_true(rt.identical(rt.new_string('newest'), rt.call_function('get_option', [
			rt.new_string('default_comments_page'),
		])))
		{ rt.call_function('get_comment_pages_count', []rt.PhpVal{}) } else { rt.new_int(1) }])
		var_overridden_cpage = true
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('COMMENTS_TEMPLATE'),
	])))))
	{
		rt.call_function('define', [rt.new_string('COMMENTS_TEMPLATE'),
			rt.new_bool(true)])
	}
	var_theme_template = rt.new_string(
		(rt.call_function('trailingslashit', [var_wp_stylesheet_path.clone()])).str() + var_file)
	var_include = rt.call_function('apply_filters', [rt.new_string('comments_template'),
		var_theme_template.clone()])
	if rt.is_true(rt.call_function('file_exists', [var_include.clone()])) {
		rt.include_file(var_include.to_string(), '3')
	} else if rt.is_true(rt.call_function('file_exists', [
		rt.new_string((rt.call_function('trailingslashit', [var_wp_template_path.clone()])).str() +
			var_file),
	]))
	{
		rt.include_file(
			(rt.call_function('trailingslashit', [var_wp_template_path.clone()])).str() + var_file,
			'3')
	} else {
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/theme-compat/comments.php',
			'3')
	}
}

fn comments_popup_link(zero bool, one bool, more bool, css_class string, none bool) {
	mut var_zero := zero
	mut var_one := one
	mut var_more := more
	mut var_css_class := css_class
	mut var_none := none
	mut var_post_id := rt.new_null()
	mut var_post_title := rt.new_null()
	mut var_comments_number := rt.new_null()
	mut var_respond_link := rt.new_null()
	mut var_comments_link := rt.new_null()
	mut var_link_attributes := rt.new_null()
	var_post_id = rt.call_function('get_the_ID', []rt.PhpVal{})
	var_post_title = rt.call_function('get_the_title', []rt.PhpVal{})
	var_comments_number = rt.new_int((get_comments_number(var_post_id.clone())).to_i64())
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(var_zero))) {
		var_zero = (rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('No Comments<span class="screen-reader-text"> on %s</span>'),
			]),
			var_post_title.clone(),
		])).to_bool()
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(var_one))) {
		var_one = (rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('1 Comment<span class="screen-reader-text"> on %s</span>'),
			]),
			var_post_title.clone(),
		])).to_bool()
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(var_more))) {
		var_more = (rt.call_function('_n', [
			rt.new_string('%1$s Comment<span class="screen-reader-text"> on %2$s</span>'),
			rt.new_string('%1$s Comments<span class="screen-reader-text"> on %2$s</span>'),
			var_comments_number.clone(),
		])).to_bool()
		var_more = (rt.call_function('sprintf', [rt.new_bool(var_more),
			rt.call_function('number_format_i18n', [var_comments_number.clone()]),
			var_post_title.clone()])).to_bool()
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(var_none))) {
		var_none = (rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Comments Off<span class="screen-reader-text"> on %s</span>'),
			]),
			var_post_title.clone(),
		])).to_bool()
	}
	if rt.is_true(rt.identical(rt.new_int(0), var_comments_number))
		&& rt.is_true(rt.new_bool(!(rt.is_true(comments_open(rt.new_null())))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(pings_open(rt.new_null()))))) {
		rt.call_function('printf', [rt.new_string('<span%1$s>%2$s</span>'),
			rt.new_string((if !(var_css_class == '') {
				' class="' +
					(rt.call_function('esc_attr', [rt.new_string(var_css_class.str())])).str() + '"'
			} else {
				''
			}).str()),
			rt.new_bool(var_none)])
		return
	}
	if rt.is_true(rt.call_function('post_password_required', []rt.PhpVal{})) {
		rt.call_function('_e', [rt.new_string('Enter your password to view comments.')])
		return
	}
	if rt.is_true(rt.identical(rt.new_int(0), var_comments_number)) {
		var_respond_link = rt.new_string((rt.call_function('get_permalink', []rt.PhpVal{})).str() +
			'#respond')
		var_comments_link = rt.call_function('apply_filters', [
			rt.new_string('respond_link'),
			var_respond_link.clone(),
			var_post_id.clone(),
		])
	} else {
		var_comments_link = get_comments_link(0)
	}
	var_link_attributes = rt.new_string('')
	var_link_attributes = rt.call_function('apply_filters', [
		rt.new_string('comments_popup_link_attributes'),
		var_link_attributes.clone(),
	])
	rt.call_function('printf', [rt.new_string('<a href="%1$s"%2$s%3$s>%4$s</a>'),
		rt.call_function('esc_url', [var_comments_link.clone()]),
		rt.new_string((if !(var_css_class == '') { ' class="' + var_css_class + '" ' } else { '' }).str()),
		var_link_attributes.clone(), get_comments_number_text(var_zero, var_one, var_more, 0)])
}

fn get_comment_reply_link(var_args_arg rt.PhpVal, var_comment_arg rt.PhpVal, var_post_arg rt.PhpVal) rt.PhpVal {
	mut var_args := var_args_arg
	mut var_comment := var_comment_arg
	mut var_post := var_post_arg
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_permalink := rt.new_null()
	mut var_link := rt.new_null()
	mut var_data_attributes := map[string]rt.PhpVal{}
	mut var_data_attribute_string := ''
	mut var_value := rt.new_null()
	mut var_name := rt.new_null()
	mut var_reply_text := rt.new_null()
	mut var_aria_label := rt.new_null()
	mut var_comment_reply_link := rt.new_null()
	var_defaults = {
		'add_below':          rt.new_string('comment')
		'respond_id':         rt.new_string('respond')
		'reply_text':         rt.call_function('_x', [rt.new_string('Reply'),
			rt.new_string('verb')])
		'reply_to_text':      rt.call_function('__', [rt.new_string('Reply to %s')])
		'login_text':         rt.call_function('__', [rt.new_string('Log in to Reply')])
		'max_depth':          rt.new_int(0)
		'depth':              rt.new_int(0)
		'before':             rt.new_string('')
		'after':              rt.new_string('')
		'show_reply_to_text': rt.new_bool(false)
	}
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array_from_native_map(var_defaults)])
	var_args.array_set('max_depth',
		rt.new_int((var_args.array_get(rt.new_string('max_depth'))).to_i64()))
	var_args.array_set('depth', rt.new_int((var_args.array_get(rt.new_string('depth'))).to_i64()))
	if rt.is_true(rt.identical(rt.new_int(0), var_args.array_get(rt.new_string('depth'))))
		|| rt.is_true(rt.less_equal(var_args.array_get(rt.new_string('max_depth')), var_args.array_get(rt.new_string('depth')))) {
		return rt.new_null()
	}
	var_comment = rt.call_function('get_comment', [var_comment.clone()])
	if !rt.is_true(var_comment) {
		return rt.new_null()
	}
	if !rt.is_true(var_post) {
		var_post = rt.get_property(var_comment, 'comment_post_ID')
	}
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(comments_open(rt.get_property(var_post, 'ID')))))) {
		return rt.new_bool(false)
	}
	if rt.is_true(rt.call_function('get_option', [rt.new_string('page_comments')])) {
		var_permalink = rt.call_function('str_replace', [
			rt.new_string('#comment-' + (rt.get_property(var_comment, 'comment_ID')).str()),
			rt.new_string(''),
			get_comment_link(var_comment.clone(), rt.new_null()),
		])
	} else {
		var_permalink = rt.call_function('get_permalink', [
			rt.get_property(var_post, 'ID'),
		])
	}
	var_args = rt.call_function('apply_filters', [
		rt.new_string('comment_reply_link_args'),
		var_args.clone(),
		var_comment.clone(),
		var_post.clone(),
	])
	if rt.is_true(rt.call_function('get_option', [rt.new_string('comment_registration')]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
		var_link = rt.call_function('sprintf', [
			rt.new_string('<a rel="nofollow" class="comment-reply-login" href="%s">%s</a>'),
			rt.call_function('esc_url', [
				rt.call_function('wp_login_url', [
					rt.call_function('get_permalink', []rt.PhpVal{}),
				]),
			]),
			var_args.array_get(rt.new_string('login_text')),
		])
	} else {
		var_data_attributes = {
			'commentid':      rt.get_property(var_comment, 'comment_ID')
			'postid':         rt.get_property(var_post, 'ID')
			'belowelement':   (var_args.array_get(rt.new_string('add_below'))).str() + '-' +
				(rt.get_property(var_comment, 'comment_ID')).str()
			'respondelement': var_args.array_get(rt.new_string('respond_id'))
			'replyto':        rt.call_function('sprintf', [
				var_args.array_get(rt.new_string('reply_to_text')),
				get_comment_author(var_comment.clone()),
			])
		}
		var_data_attribute_string = ''
		for var_name_shadow, var_value_shadow in var_data_attributes {
			var_data_attribute_string = var_data_attribute_string +
				" data-${var_name.to_string()}=\"" +
				(rt.call_function('esc_attr', [var_value_shadow.clone()])).str() + '"'
		}
		var_data_attribute_string = var_data_attribute_string.trim_space()
		var_reply_text = if rt.is_true(var_args.array_get(rt.new_string('show_reply_to_text'))) { rt.call_function('sprintf', [
				var_args.array_get(rt.new_string('reply_to_text')),
				get_comment_author(var_comment.clone()),
			]) } else { var_args.array_get(rt.new_string('reply_text')) }
		var_aria_label = if rt.is_true(var_args.array_get(rt.new_string('show_reply_to_text'))) { rt.new_string('') } else { rt.call_function('sprintf', [
				var_args.array_get(rt.new_string('reply_to_text')),
				get_comment_author(var_comment.clone()),
			]) }
		var_link = rt.call_function('sprintf', [
			rt.new_string('<a rel="nofollow" class="comment-reply-link" href="%s" %s%s>%s</a>'),
			rt.new_string(
				(rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{
				key: 'replytocom'
				val: rt.get_property(var_comment, 'comment_ID')
			}, rt.ArrayItem{ key: 'unapproved', val: false }, rt.ArrayItem{
				key: 'moderation-hash'
				val: false
			}]), var_permalink.clone()])])).str() +
				'#' + (var_args.array_get(rt.new_string('respond_id'))).str()),
			rt.new_string(var_data_attribute_string.str()).clone(),
			rt.new_string((if rt.is_true(var_aria_label) {
				' aria-label="' + (rt.call_function('esc_attr', [var_aria_label.clone()])).str() +
					'"'
			} else {
				''
			}).str()),
			var_reply_text.clone(),
		])
	}
	var_comment_reply_link = rt.new_string(
		(var_args.array_get(rt.new_string('before'))).str() + var_link.str() +
		(var_args.array_get(rt.new_string('after'))).str())
	return rt.call_function('apply_filters', [rt.new_string('comment_reply_link'),
		var_comment_reply_link.clone(), var_args.clone(), var_comment.clone(),
		var_post.clone()])
}

fn comment_reply_link(var_args rt.PhpVal, var_comment rt.PhpVal, var_post rt.PhpVal) {
	rt.echo_val(get_comment_reply_link(var_args.clone(), var_comment.clone(), var_post.clone()))
}

fn get_post_reply_link(var_args_arg rt.PhpVal, var_post_arg rt.PhpVal) bool {
	mut var_args := var_args_arg
	mut var_post := var_post_arg
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_link := rt.new_null()
	mut var_onclick := rt.new_null()
	mut var_post_reply_link := rt.new_null()
	var_defaults = {
		'add_below':  rt.new_string('post')
		'respond_id': rt.new_string('respond')
		'reply_text': rt.call_function('__', [rt.new_string('Leave a Comment')])
		'login_text': rt.call_function('__', [rt.new_string('Log in to leave a Comment')])
		'before':     rt.new_string('')
		'after':      rt.new_string('')
	}
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array_from_native_map(var_defaults)])
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(comments_open(rt.get_property(var_post, 'ID')))))) {
		return false
	}
	if rt.is_true(rt.call_function('get_option', [rt.new_string('comment_registration')]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
		var_link = rt.call_function('sprintf', [
			rt.new_string('<a rel="nofollow" class="comment-reply-login" href="%s">%s</a>'),
			rt.call_function('wp_login_url', [
				rt.call_function('get_permalink', []rt.PhpVal{}),
			]),
			var_args.array_get(rt.new_string('login_text')),
		])
	} else {
		var_onclick = rt.call_function('sprintf', [
			rt.new_string('return addComment.moveForm( "%1$s-%2$s", "0", "%3$s", "%2$s" )'),
			var_args.array_get(rt.new_string('add_below')),
			rt.get_property(var_post, 'ID'),
			var_args.array_get(rt.new_string('respond_id')),
		])
		var_link = rt.call_function('sprintf', [
			rt.new_string("<a rel='nofollow' class='comment-reply-link' href='%s' onclick='%s'>%s</a>"),
			rt.new_string(
				(rt.call_function('get_permalink', [rt.get_property(var_post, 'ID')])).str() + '#' +
				(var_args.array_get(rt.new_string('respond_id'))).str()),
			var_onclick.clone(),
			var_args.array_get(rt.new_string('reply_text')),
		])
	}
	var_post_reply_link = rt.new_string(
		(var_args.array_get(rt.new_string('before'))).str() + var_link.str() +
		(var_args.array_get(rt.new_string('after'))).str())
	return (rt.call_function('apply_filters', [rt.new_string('post_comments_link'),
		var_post_reply_link.clone(), var_post.clone()])).to_bool()
}

fn post_reply_link(var_args rt.PhpVal, var_post rt.PhpVal) {
	rt.echo_val(rt.new_bool(get_post_reply_link(var_args.clone(), var_post.clone())))
}

fn get_cancel_comment_reply_link(link_text string, var_post_arg rt.PhpVal) rt.PhpVal {
	mut var_link_text := link_text
	mut var_post := var_post_arg
	mut var_reply_to_id := rt.new_null()
	mut var_link_style := ''
	mut var_link_url := rt.new_null()
	mut var_cancel_comment_reply_link := rt.new_null()
	if var_link_text == '' {
		var_link_text = (rt.call_function('__', [
			rt.new_string('Click here to cancel reply.'),
		])).str()
	}
	var_post = rt.call_function('get_post', [var_post.clone()])
	var_reply_to_id = rt.new_int(if rt.is_true(var_post) {
		_get_comment_reply_id(rt.get_property(var_post, 'ID'))
	} else {
		0
	})
	var_link_style = if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0),
		var_reply_to_id))))
	{
		''
	} else {
		' style="display:none;"'
	}
	var_link_url = rt.new_string(
		(rt.call_function('esc_url', [rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{
		key: none
		val: 'replytocom'
	}, rt.ArrayItem{ key: none, val: 'unapproved' }, rt.ArrayItem{ key: none, val: 'moderation-hash' }])])])).str() +
		'#respond')
	var_cancel_comment_reply_link = rt.call_function('sprintf', [
		rt.new_string('<a rel="nofollow" id="cancel-comment-reply-link" href="%1$s"%2$s>%3$s</a>'),
		var_link_url.clone(),
		rt.new_string(var_link_style.str()).clone(),
		rt.new_string(var_link_text.str()),
	])
	return rt.call_function('apply_filters', [rt.new_string('cancel_comment_reply_link'),
		var_cancel_comment_reply_link.clone(), var_link_url.clone(),
		rt.new_string(var_link_text.str())])
}

fn cancel_comment_reply_link(link_text string) {
	mut var_link_text := link_text
	rt.echo_val(get_cancel_comment_reply_link(var_link_text, rt.new_null()))
}

fn get_comment_id_fields(var_post_arg rt.PhpVal) string {
	mut var_post := var_post_arg
	mut var_post_id := rt.new_null()
	mut var_reply_to_id := rt.new_null()
	mut var_comment_id_fields := ''
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return ''
	}
	var_post_id = rt.get_property(var_post, 'ID')
	var_reply_to_id = rt.new_int(_get_comment_reply_id(var_post_id.clone()))
	var_comment_id_fields = "<input type='hidden' name='comment_post_ID' value='${var_post_id.to_string()}' id='comment_post_ID' />\n"
	var_comment_id_fields = var_comment_id_fields +
		"<input type='hidden' name='comment_parent' id='comment_parent' value='${var_reply_to_id.to_string()}' />\n"
	return (rt.call_function('apply_filters', [rt.new_string('comment_id_fields'),
		rt.new_string(var_comment_id_fields.str()).clone(), var_post_id.clone(),
		var_reply_to_id.clone()])).str()
}

fn comment_id_fields(var_post rt.PhpVal) {
	print(get_comment_id_fields(var_post.clone()))
}

fn comment_form_title(no_reply_text bool, reply_text bool, link_to_parent bool, var_post_arg rt.PhpVal) {
	mut var_no_reply_text := no_reply_text
	mut var_reply_text := reply_text
	mut var_link_to_parent := link_to_parent
	mut var_post := var_post_arg
	mut var_reply_to_id := rt.new_null()
	mut var_comment := rt.new_null()
	mut var_comment_author := rt.new_null()
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(var_no_reply_text))) {
		var_no_reply_text = (rt.call_function('__', [rt.new_string('Leave a Reply')])).to_bool()
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(var_reply_text))) {
		var_reply_text = (rt.call_function('__', [rt.new_string('Leave a Reply to %s')])).to_bool()
	}
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		print(if var_no_reply_text { '1' } else { '' })
		return
	}
	var_reply_to_id = rt.new_int(_get_comment_reply_id(rt.get_property(var_post, 'ID')))
	if rt.is_true(rt.identical(rt.new_int(0), var_reply_to_id)) {
		print(if var_no_reply_text { '1' } else { '' })
		return
	}
	var_comment = rt.call_function('get_comment', [var_reply_to_id.clone()])
	if var_link_to_parent {
		var_comment_author = rt.call_function('sprintf', [
			rt.new_string('<a href="#comment-%1$s">%2$s</a>'),
			get_comment_id(),
			get_comment_author(var_reply_to_id.clone()),
		])
	} else {
		var_comment_author = get_comment_author(var_reply_to_id.clone())
	}
	rt.call_function('printf', [rt.new_bool(var_reply_text), var_comment_author.clone()])
}

fn _get_comment_reply_id(var_post_arg rt.PhpVal) i64 {
	mut var_post := var_post_arg
	mut var_reply_to_id := rt.new_null()
	mut var_comment := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post))))
		|| !(rt.get_superglobal('_GET').array_isset(rt.new_string('replytocom')))
		|| !(rt.get_superglobal('_GET').array_get(rt.new_string('replytocom')).is_long()
		|| rt.get_superglobal('_GET').array_get(rt.new_string('replytocom')).is_double()) {
		return 0
	}
	var_reply_to_id =
		rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('replytocom'))).to_i64())
	var_comment = rt.call_function('get_comment', [var_reply_to_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_comment, 'WP_Comment'))))))
		|| 0 == rt.new_int((rt.get_property(var_comment, 'comment_approved')).to_i64())
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_post, 'ID'), rt.new_int((rt.get_property(var_comment, 'comment_post_ID')).to_i64()))))) {
		return 0
	}
	return var_reply_to_id.to_i64()
}

fn wp_list_comments(var_args rt.PhpVal, var_comments_arg rt.PhpVal) rt.PhpVal {
	mut var_comments := var_comments_arg
	mut var_wp_query := rt.new_null()
	mut var_overridden_cpage := rt.new_null()
	mut var_in_comment_loop := false
	mut var_comment_alt := i64(0)
	mut var_comment_thread_alt := i64(0)
	mut var_comment_depth := i64(0)
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_parsed_args := rt.new_null()
	mut var_comments_by_type := rt.new_null()
	mut var__comments := rt.new_null()
	mut var_current_cpage := rt.new_null()
	mut var_current_per_page := rt.new_null()
	mut var_comment_args := rt.new_null()
	mut var_unapproved_email := rt.new_null()
	mut var_default_comments_page := rt.new_null()
	mut var_cpage := rt.new_null()
	mut var_threaded := rt.new_null()
	mut var_walker := rt.new_null()
	mut var_output := rt.new_null()
	var_in_comment_loop = true
	var_comment_alt = 0
	var_comment_thread_alt = 0
	var_comment_depth = 1
	var_defaults = {
		'walker':            rt.new_null()
		'max_depth':         rt.new_string('')
		'style':             rt.new_string('ul')
		'callback':          rt.new_null()
		'end-callback':      rt.new_null()
		'type':              rt.new_string('all')
		'page':              rt.new_string('')
		'per_page':          rt.new_string('')
		'avatar_size':       rt.new_int(32)
		'reverse_top_level': rt.new_null()
		'reverse_children':  rt.new_string('')
		'format':            if rt.is_true(rt.call_function('current_theme_supports', [
			rt.new_string('html5'),
			rt.new_string('comment-list'),
		]))
		{ 'html5' } else { 'xhtml' }
		'short_ping':        rt.new_bool(false)
		'echo':              rt.new_bool(true)
	}
	var_parsed_args = rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array_from_native_map(var_defaults)])
	var_parsed_args = rt.call_function('apply_filters', [
		rt.new_string('wp_list_comments_args'),
		var_parsed_args.clone(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_comments)))) {
		var_comments = rt.cast_array(var_comments)
		if !rt.is_true(var_comments) {
			return rt.new_null()
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('all'),
			var_parsed_args.array_get(rt.new_string('type'))))))
		{
			var_comments_by_type = rt.call_function('separate_comments', [
				var_comments.clone()])
			if !rt.is_true(var_comments_by_type.array_get(var_parsed_args.array_get(rt.new_string('type')))) {
				return rt.new_null()
			}
			var__comments =
				var_comments_by_type.array_get(var_parsed_args.array_get(rt.new_string('type')))
		} else {
			var__comments = var_comments.clone()
		}
	} else {
		if rt.is_true(var_parsed_args.array_get(rt.new_string('page')))
			|| rt.is_true(var_parsed_args.array_get(rt.new_string('per_page'))) {
			var_current_cpage = rt.new_int((rt.call_function('get_query_var', [
				rt.new_string('cpage'),
			])).to_i64())
			if rt.is_true(rt.new_bool(!(rt.is_true(var_current_cpage)))) {
				var_current_cpage = if rt.is_true(rt.identical(rt.new_string('newest'), rt.call_function('get_option', [
					rt.new_string('default_comments_page'),
				])))
				{ rt.new_int(1) } else { rt.get_property(var_wp_query, 'max_num_comment_pages') }
			}
			var_current_per_page = rt.new_int((rt.call_function('get_query_var', [
				rt.new_string('comments_per_page'),
			])).to_i64())
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int((var_parsed_args.array_get(rt.new_string('page'))).to_i64()), var_current_cpage))))
				|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int((var_parsed_args.array_get(rt.new_string('per_page'))).to_i64()), var_current_per_page)))) {
				var_comment_args = rt.create_array([
					rt.ArrayItem{ key: 'post_id', val: rt.call_function('get_the_ID', []rt.PhpVal{}) },
					rt.ArrayItem{ key: 'orderby', val: 'comment_date_gmt' },
					rt.ArrayItem{ key: 'order', val: 'ASC' },
					rt.ArrayItem{ key: 'status', val: 'approve' },
				])
				if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
					var_comment_args.array_set('include_unapproved', rt.create_array([
						rt.ArrayItem{ key: none, val: rt.call_function('get_current_user_id',
							[]rt.PhpVal{}) },
					]))
				} else {
					var_unapproved_email = rt.call_function('wp_get_unapproved_comment_author_email',
						[]rt.PhpVal{})
					if rt.is_true(var_unapproved_email) {
						var_comment_args.array_set('include_unapproved', rt.create_array([
							rt.ArrayItem{ key: none, val: var_unapproved_email },
						]))
					}
				}
				var_comments = rt.call_function('get_comments', [
					var_comment_args.clone()])
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('all'),
					var_parsed_args.array_get(rt.new_string('type'))))))
				{
					var_comments_by_type = rt.call_function('separate_comments', [
						var_comments.clone(),
					])
					if !rt.is_true(var_comments_by_type.array_get(var_parsed_args.array_get(rt.new_string('type')))) {
						return rt.new_null()
					}
					var__comments =
						var_comments_by_type.array_get(var_parsed_args.array_get(rt.new_string('type')))
				} else {
					var__comments = var_comments.clone()
				}
			}
		} else {
			if !rt.is_true(rt.get_property(var_wp_query, 'comments')) {
				return rt.new_null()
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('all'),
				var_parsed_args.array_get(rt.new_string('type'))))))
			{
				if !rt.is_true(rt.get_property(var_wp_query, 'comments_by_type')) {
					rt.set_property(var_wp_query, 'comments_by_type', rt.call_function('separate_comments', [
						rt.get_property(var_wp_query, 'comments'),
					]))
				}
				if !rt.is_true(rt.get_property(var_wp_query, 'comments_by_type').array_get(var_parsed_args.array_get(rt.new_string('type')))) {
					return rt.new_null()
				}
				var__comments =
					rt.get_property(var_wp_query, 'comments_by_type').array_get(var_parsed_args.array_get(rt.new_string('type')))
			} else {
				var__comments = rt.get_property(var_wp_query, 'comments')
			}
			if rt.is_true(rt.get_property(var_wp_query, 'max_num_comment_pages')) {
				var_default_comments_page = rt.call_function('get_option', [
					rt.new_string('default_comments_page'),
				])
				var_cpage = rt.new_int((rt.call_function('get_query_var', [
					rt.new_string('cpage'),
				])).to_i64())
				if rt.is_true(rt.identical(rt.new_string('newest'), var_default_comments_page)) {
					var_parsed_args.array_set('cpage', var_cpage.clone())
				} else if rt.is_true(rt.identical(rt.new_int(1), var_cpage)) {
					var_parsed_args.array_set('cpage', '')
				} else {
					var_parsed_args.array_set('cpage', var_cpage.clone())
				}
				var_parsed_args.array_set('page', 0)
				var_parsed_args.array_set('per_page', 0)
			}
		}
	}
	if rt.is_true(rt.identical(rt.new_string(''), var_parsed_args.array_get(rt.new_string('per_page'))))
		&& rt.is_true(rt.call_function('get_option', [rt.new_string('page_comments')])) {
		var_parsed_args.array_set('per_page', rt.call_function('get_query_var', [
			rt.new_string('comments_per_page'),
		]))
	}
	if !rt.is_true(var_parsed_args.array_get(rt.new_string('per_page'))) {
		var_parsed_args.array_set('per_page', 0)
		var_parsed_args.array_set('page', 0)
	}
	if rt.is_true(rt.identical(rt.new_string(''),
		var_parsed_args.array_get(rt.new_string('max_depth'))))
	{
		if rt.is_true(rt.call_function('get_option', [rt.new_string('thread_comments')])) {
			var_parsed_args.array_set('max_depth', rt.call_function('get_option', [
				rt.new_string('thread_comments_depth'),
			]))
		} else {
			var_parsed_args.array_set('max_depth', -1)
		}
	}
	if rt.is_true(rt.identical(rt.new_string(''), var_parsed_args.array_get(rt.new_string('page')))) {
		if !rt.is_true(var_overridden_cpage) {
			var_parsed_args.array_set('page', rt.call_function('get_query_var', [
				rt.new_string('cpage'),
			]))
		} else {
			var_threaded =
				rt.new_bool(-1 != rt.new_int((var_parsed_args.array_get(rt.new_string('max_depth'))).to_i64()))
			var_parsed_args.array_set('page', if rt.is_true(rt.identical(rt.new_string('newest'), rt.call_function('get_option', [
				rt.new_string('default_comments_page'),
			])))
			{ rt.call_function('get_comment_pages_count', [var__comments.clone(),
					var_parsed_args.array_get(rt.new_string('per_page')),
					var_threaded.clone()]) } else { rt.new_int(1) })
			rt.call_function('set_query_var', [rt.new_string('cpage'),
				var_parsed_args.array_get(rt.new_string('page'))])
		}
	}
	var_parsed_args.array_set('page',
		rt.new_int((var_parsed_args.array_get(rt.new_string('page'))).to_i64()))
	var_parsed_args.array_set('per_page',
		rt.new_int((var_parsed_args.array_get(rt.new_string('per_page'))).to_i64()))
	if rt.is_true(rt.identical(rt.new_int(0), var_parsed_args.array_get(rt.new_string('page'))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_parsed_args.array_get(rt.new_string('per_page')))))) {
		var_parsed_args.array_set('page', 1)
	}
	if rt.is_true(rt.identical(rt.new_null(),
		var_parsed_args.array_get(rt.new_string('reverse_top_level'))))
	{
		var_parsed_args.array_set('reverse_top_level', rt.identical(rt.new_string('desc'), rt.call_function('get_option', [
			rt.new_string('comment_order'),
		])))
	}
	if !rt.is_true(var_parsed_args.array_get(rt.new_string('walker'))) {
		var_walker = create_walker_comment()
	} else {
		var_walker = var_parsed_args.array_get(rt.new_string('walker'))
	}
	var_output = rt.call_method(var_walker, 'paged_walk', [var__comments.clone(),
		var_parsed_args.array_get(rt.new_string('max_depth')),
		var_parsed_args.array_get(rt.new_string('page')), var_parsed_args.array_get(rt.new_string('per_page')),
		var_parsed_args.clone()])
	var_in_comment_loop = false
	if rt.is_true(var_parsed_args.array_get(rt.new_string('echo'))) {
		rt.echo_val(var_output)
	} else {
		return var_output.clone()
	}
	return rt.new_null()
}

fn comment_form(var_args_arg rt.PhpVal, var_post_arg rt.PhpVal) {
	mut var_args := var_args_arg
	mut var_post := var_post_arg
	mut var_post_id := rt.new_null()
	mut var_commenter := rt.new_null()
	mut var_user := rt.new_null()
	mut var_user_identity := rt.new_null()
	mut var_req := rt.new_null()
	mut var_html5 := false
	mut var_required_attribute := ''
	mut var_checked_attribute := ''
	mut var_required_indicator := rt.new_null()
	mut var_required_text := rt.new_null()
	mut var_fields := rt.new_null()
	mut var_consent := ''
	mut var_original_fields := rt.new_null()
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_comment_fields := rt.new_null()
	mut var_comment_field_keys := rt.new_null()
	mut var_first_field := rt.new_null()
	mut var_last_field := rt.new_null()
	mut var_field := rt.new_null()
	mut var_name := rt.new_null()
	mut var_submit_button := rt.new_null()
	mut var_submit_field := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(comments_open(var_post.clone()))))) {
		rt.call_function('do_action', [rt.new_string('comment_form_comments_closed')])
		return
	}
	var_post_id = rt.get_property(var_post, 'ID')
	var_commenter = rt.call_function('wp_get_current_commenter', []rt.PhpVal{})
	var_user = rt.call_function('wp_get_current_user', []rt.PhpVal{})
	var_user_identity = if rt.is_true(rt.call_method(var_user, 'exists', []rt.PhpVal{})) {
		rt.get_property(var_user, 'display_name')
	} else {
		rt.new_string('')
	}
	var_args = rt.call_function('wp_parse_args', [var_args.clone()])
	if !(var_args.array_isset(rt.new_string('format'))) {
		var_args.array_set('format', if rt.is_true(rt.call_function('current_theme_supports', [
			rt.new_string('html5'),
			rt.new_string('comment-form'),
		]))
		{ 'html5' } else { 'xhtml' })
	}
	var_req = rt.call_function('get_option', [rt.new_string('require_name_email')])
	var_html5 =
		(rt.identical(rt.new_string('html5'), var_args.array_get(rt.new_string('format')))).to_bool()
	var_required_attribute = if var_html5 { ' required' } else { ' required="required"' }
	var_checked_attribute = if var_html5 { ' checked' } else { ' checked="checked"' }
	var_required_indicator = rt.new_string(' ' +
		(rt.call_function('wp_required_field_indicator', []rt.PhpVal{})).str())
	var_required_text = rt.new_string(' ' +
		(rt.call_function('wp_required_field_message', []rt.PhpVal{})).str())
	var_fields = rt.create_array([
		rt.ArrayItem{ key: 'author', val: rt.call_function('sprintf', [
			rt.new_string('<p class="comment-form-author">%s %s</p>'),
			rt.call_function('sprintf', [
				rt.new_string('<label for="author">%s%s</label>'),
				rt.call_function('__', [rt.new_string('Name')]),
				if rt.is_true(var_req) { var_required_indicator } else { rt.new_string('') },
			]),
			rt.call_function('sprintf', [
				rt.new_string('<input id="author" name="author" type="text" value="%s" size="30" maxlength="245" autocomplete="name"%s />'),
				rt.call_function('esc_attr',
					[var_commenter.array_get(rt.new_string('comment_author'))]),
				rt.new_string((if rt.is_true(var_req) { var_required_attribute } else { '' }).str()),
			]),
		]) },
		rt.ArrayItem{ key: 'email', val: rt.call_function('sprintf', [
			rt.new_string('<p class="comment-form-email">%s %s</p>'),
			rt.call_function('sprintf', [
				rt.new_string('<label for="email">%s%s</label>'),
				rt.call_function('__', [rt.new_string('Email')]),
				if rt.is_true(var_req) { var_required_indicator } else { rt.new_string('') },
			]),
			rt.call_function('sprintf', [
				rt.new_string('<input id="email" name="email" %s value="%s" size="30" maxlength="100" aria-describedby="email-notes" autocomplete="email"%s />'),
				rt.new_string((if var_html5 { 'type="email"' } else { 'type="text"' }).str()),
				rt.call_function('esc_attr',
					[var_commenter.array_get(rt.new_string('comment_author_email'))]),
				rt.new_string((if rt.is_true(var_req) { var_required_attribute } else { '' }).str()),
			]),
		]) },
		rt.ArrayItem{ key: 'url', val: rt.call_function('sprintf', [
			rt.new_string('<p class="comment-form-url">%s %s</p>'),
			rt.call_function('sprintf', [
				rt.new_string('<label for="url">%s</label>'),
				rt.call_function('__', [rt.new_string('Website')]),
			]),
			rt.call_function('sprintf', [
				rt.new_string('<input id="url" name="url" %s value="%s" size="30" maxlength="200" autocomplete="url" />'),
				rt.new_string((if var_html5 { 'type="url"' } else { 'type="text"' }).str()),
				rt.call_function('esc_attr',
					[var_commenter.array_get(rt.new_string('comment_author_url'))]),
			]),
		]) },
	])
	if rt.is_true(rt.call_function('has_action', [rt.new_string('set_comment_cookies'), rt.new_string('wp_set_comment_cookies')]))
		&& rt.is_true(rt.call_function('get_option', [rt.new_string('show_comments_cookies_opt_in')])) {
		var_consent = if !rt.is_true(var_commenter.array_get(rt.new_string('comment_author_email'))) {
			''
		} else {
			var_checked_attribute
		}
		var_fields.array_set('cookies', rt.call_function('sprintf', [
			rt.new_string('<p class="comment-form-cookies-consent">%s %s</p>'),
			rt.call_function('sprintf', [
				rt.new_string('<input id="wp-comment-cookies-consent" name="wp-comment-cookies-consent" type="checkbox" value="yes"%s />'),
				rt.new_string(var_consent.str()).clone(),
			]),
			rt.call_function('sprintf', [
				rt.new_string('<label for="wp-comment-cookies-consent">%s</label>'),
				rt.call_function('__', [
					rt.new_string('Save my name, email, and website in this browser for the next time I comment.'),
				]),
			]),
		]))
		if var_args.array_isset(rt.new_string('fields'))
			&& !(var_args.array_get(rt.new_string('fields')).array_isset(rt.new_string('cookies'))) {
			var_args.array_get_mut('fields').array_set('cookies',
				var_fields.array_get(rt.new_string('cookies')))
		}
	}
	var_original_fields = var_fields.clone()
	var_fields = rt.call_function('apply_filters', [
		rt.new_string('comment_form_default_fields'),
		var_fields.clone(),
	])
	var_defaults = {
		'fields':               var_fields
		'comment_field':        rt.call_function('sprintf', [
			rt.new_string('<p class="comment-form-comment">%s %s</p>'),
			rt.call_function('sprintf', [
				rt.new_string('<label for="comment">%s%s</label>'),
				rt.call_function('_x', [rt.new_string('Comment'),
					rt.new_string('noun')]),
				var_required_indicator.clone(),
			]),
			rt.new_string(
				'<textarea id="comment" name="comment" cols="45" rows="8" maxlength="65525"' +
				var_required_attribute + '></textarea>'),
		])
		'must_log_in':          rt.call_function('sprintf', [
			rt.new_string('<p class="must-log-in">%s</p>'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('You must be <a href="%s">logged in</a> to post a comment.'),
				]),
				rt.call_function('wp_login_url', [
					rt.call_function('apply_filters', [rt.new_string('the_permalink'),
						rt.call_function('get_permalink', [var_post_id.clone()]),
						var_post_id.clone()]),
				]),
			]),
		])
		'logged_in_as':         rt.call_function('sprintf', [
			rt.new_string('<p class="logged-in-as">%s%s</p>'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Logged in as %1$s. <a href="%2$s">Edit your profile</a>. <a href="%3$s">Log out?</a>'),
				]),
				var_user_identity.clone(),
				rt.call_function('get_edit_user_link', []rt.PhpVal{}),
				rt.call_function('wp_logout_url', [
					rt.call_function('apply_filters', [rt.new_string('the_permalink'),
						rt.call_function('get_permalink', [var_post_id.clone()]),
						var_post_id.clone()]),
				]),
			]),
			var_required_text.clone(),
		])
		'comment_notes_before': rt.call_function('sprintf', [
			rt.new_string('<p class="comment-notes">%s%s</p>'),
			rt.call_function('sprintf', [
				rt.new_string('<span id="email-notes">%s</span>'),
				rt.call_function('__', [
					rt.new_string('Your email address will not be published.'),
				]),
			]),
			var_required_text.clone(),
		])
		'comment_notes_after':  rt.new_string('')
		'action':               rt.call_function('site_url', [
			rt.new_string('/wp-comments-post.php'),
		])
		'novalidate':           rt.new_bool(false)
		'id_form':              rt.new_string('commentform')
		'id_submit':            rt.new_string('submit')
		'class_container':      rt.new_string('comment-respond')
		'class_form':           rt.new_string('comment-form')
		'class_submit':         rt.new_string('submit')
		'name_submit':          rt.new_string('submit')
		'title_reply':          rt.call_function('__', [rt.new_string('Leave a Reply')])
		'title_reply_to':       rt.call_function('__', [
			rt.new_string('Leave a Reply to %s'),
		])
		'title_reply_before':   rt.new_string('<h3 id="reply-title" class="comment-reply-title">')
		'title_reply_after':    rt.new_string('</h3>')
		'cancel_reply_before':  rt.new_string(' <small>')
		'cancel_reply_after':   rt.new_string('</small>')
		'cancel_reply_link':    rt.call_function('__', [rt.new_string('Cancel reply')])
		'label_submit':         rt.call_function('__', [rt.new_string('Post Comment')])
		'submit_button':        rt.new_string('<input name="%1$s" type="submit" id="%2$s" class="%3$s" value="%4$s" />')
		'submit_field':         rt.new_string('<p class="form-submit">%1$s %2$s</p>')
		'format':               rt.new_string('xhtml')
	}
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		rt.call_function('apply_filters', [rt.new_string('comment_form_defaults'),
			rt.create_array_from_native_map(var_defaults)])])
	var_args = rt.call_function('array_merge', [
		rt.create_array_from_native_map(var_defaults),
		var_args.clone(),
	])
	if var_args.array_get(rt.new_string('fields')).array_isset(rt.new_string('email'))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_args.array_get(rt.new_string('comment_notes_before')), rt.new_string('id="email-notes"')]))))) {
		var_args.array_get_mut('fields').array_set('email', rt.call_function('str_replace', [
			rt.new_string(' aria-describedby="email-notes"'),
			rt.new_string(''),
			var_args.array_get(rt.new_string('fields')).array_get(rt.new_string('email')),
		]))
	}
	rt.call_function('do_action', [rt.new_string('comment_form_before')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		var_args.array_get(rt.new_string('class_container')),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_args.array_get(rt.new_string('title_reply_before')))
	comment_form_title(var_args.array_get(rt.new_string('title_reply')),
		var_args.array_get(rt.new_string('title_reply_to')), true, var_post_id.clone())
	if rt.is_true(rt.call_function('get_option', [rt.new_string('thread_comments')])) {
		rt.echo_val(var_args.array_get(rt.new_string('cancel_reply_before')))
		cancel_comment_reply_link(var_args.array_get(rt.new_string('cancel_reply_link')))
		rt.echo_val(var_args.array_get(rt.new_string('cancel_reply_after')))
	}
	rt.echo_val(var_args.array_get(rt.new_string('title_reply_after')))
	if rt.is_true(rt.call_function('get_option', [rt.new_string('comment_registration')]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
		rt.echo_val(var_args.array_get(rt.new_string('must_log_in')))
		rt.call_function('do_action', [rt.new_string('comment_form_must_log_in_after')])
	} else {
		rt.call_function('printf', [
			rt.new_string('<form action="%s" method="post" id="%s" class="%s"%s>'),
			rt.call_function('esc_url', [var_args.array_get(rt.new_string('action'))]),
			rt.call_function('esc_attr', [var_args.array_get(rt.new_string('id_form'))]),
			rt.call_function('esc_attr', [var_args.array_get(rt.new_string('class_form'))]),
			rt.new_string((if rt.is_true(var_args.array_get(rt.new_string('novalidate'))) {
				' novalidate'
			} else {
				''
			}).str()),
		])
		rt.call_function('do_action', [rt.new_string('comment_form_top')])
		if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
			rt.echo_val(rt.call_function('apply_filters', [
				rt.new_string('comment_form_logged_in'),
				var_args.array_get(rt.new_string('logged_in_as')),
				var_commenter.clone(),
				var_user_identity.clone(),
			]))
			rt.call_function('do_action', [rt.new_string('comment_form_logged_in_after'),
				var_commenter.clone(), var_user_identity.clone()])
		} else {
			rt.echo_val(var_args.array_get(rt.new_string('comment_notes_before')))
		}
		var_comment_fields = rt.add(rt.create_array([
			rt.ArrayItem{ key: 'comment', val: var_args.array_get(rt.new_string('comment_field')) },
		]), rt.cast_array(var_args.array_get(rt.new_string('fields'))))
		var_comment_fields = rt.call_function('apply_filters', [
			rt.new_string('comment_form_fields'),
			var_comment_fields.clone(),
		])
		var_comment_field_keys = rt.call_function('array_diff', [
			rt.func_array_keys(var_comment_fields.clone()),
			rt.create_array([rt.ArrayItem{ key: none, val: 'comment' }]),
		])
		var_first_field = rt.call_function('reset', [var_comment_field_keys.clone()])
		var_last_field = rt.call_function('end', [var_comment_field_keys.clone()])
		mut iter_3 := var_comment_fields.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_field_shadow := item_3.val
			mut var_name_shadow := item_3.key
			if rt.is_true(rt.identical(rt.new_string('comment'), var_name_shadow)) {
				rt.echo_val(rt.call_function('apply_filters', [
					rt.new_string('comment_form_field_comment'),
					var_field_shadow.clone(),
				]))
				rt.echo_val(var_args.array_get(rt.new_string('comment_notes_after')))
			} else if
				rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})))))
				|| !(var_original_fields.array_isset(var_name_shadow)) {
				if rt.is_true(rt.identical(var_first_field, var_name_shadow)) {
					rt.call_function('do_action', [
						rt.new_string('comment_form_before_fields'),
					])
				}
				print(
					(rt.call_function('apply_filters', [rt.new_string('comment_form_field_${var_name.to_string()}'), var_field_shadow.clone()])).str() +
					'\n')
				if rt.is_true(rt.identical(var_last_field, var_name_shadow)) {
					rt.call_function('do_action', [
						rt.new_string('comment_form_after_fields'),
					])
				}
			}
		}
		var_submit_button = rt.call_function('sprintf', [
			var_args.array_get(rt.new_string('submit_button')),
			rt.call_function('esc_attr', [var_args.array_get(rt.new_string('name_submit'))]),
			rt.call_function('esc_attr', [var_args.array_get(rt.new_string('id_submit'))]),
			rt.call_function('esc_attr', [var_args.array_get(rt.new_string('class_submit'))]),
			rt.call_function('esc_attr', [var_args.array_get(rt.new_string('label_submit'))]),
		])
		var_submit_button = rt.call_function('apply_filters', [
			rt.new_string('comment_form_submit_button'),
			var_submit_button.clone(),
			var_args.clone(),
		])
		var_submit_field = rt.call_function('sprintf', [
			var_args.array_get(rt.new_string('submit_field')),
			var_submit_button.clone(),
			rt.new_string(get_comment_id_fields(var_post_id.clone())),
		])
		rt.echo_val(rt.call_function('apply_filters', [
			rt.new_string('comment_form_submit_field'),
			var_submit_field.clone(),
			var_args.clone(),
		]))
		rt.call_function('do_action', [rt.new_string('comment_form'),
			var_post_id.clone()])
		print('</form>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('comment_form_after')])
}

struct Class_WP_Comment_Query {
	rt.PhpObjectBase
}

struct Class_Walker_Comment {
	rt.PhpObjectBase
}

fn create_wp_comment_query(_args ...rt.PhpVal) &Class_WP_Comment_Query {
	mut obj := &Class_WP_Comment_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_walker_comment(_args ...rt.PhpVal) &Class_Walker_Comment {
	mut obj := &Class_Walker_Comment{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Comment_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Comment_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Comment_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Walker_Comment) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Walker_Comment) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Walker_Comment) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
