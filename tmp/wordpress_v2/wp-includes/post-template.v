import rt

fn the_id() {
	rt.echo_val(get_the_id())
}

fn get_the_id() rt.PhpVal {
	mut var_post := rt.new_null()
	var_post = rt.call_function('get_post', []rt.PhpVal{})
	return if !(!rt.is_true(var_post)) {
		rt.get_property(var_post, 'ID')
	} else {
		rt.new_bool(false)
	}
}

fn the_title(before string, after string, display bool) rt.PhpVal {
	mut var_before := before
	mut var_after := after
	mut var_display := display
	mut var_title := rt.new_null()
	var_title = get_the_title(0)
	if var_title.clone().to_string().len == 0 {
		return rt.new_null()
	}
	var_title = rt.new_string(before + var_title.str() + after)
	if var_display {
		rt.echo_val(var_title)
	} else {
		return var_title.clone()
	}
	return rt.new_null()
}

fn the_title_attribute(args string) rt.PhpVal {
	mut var_args := args
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_parsed_args := rt.new_null()
	mut var_title := rt.new_null()
	var_defaults = {
		'before': rt.new_string('')
		'after':  rt.new_string('')
		'echo':   rt.new_bool(true)
		'post':   rt.call_function('get_post', []rt.PhpVal{})
	}
	var_parsed_args = rt.call_function('wp_parse_args', [rt.new_string(args),
		rt.create_array_from_native_map(var_defaults)])
	var_title = get_the_title(var_parsed_args.array_get(rt.new_string('post')))
	if var_title.clone().to_string().len == 0 {
		return rt.new_null()
	}
	var_title = rt.new_string(
		(var_parsed_args.array_get(rt.new_string('before'))).str() + var_title.str() +
		(var_parsed_args.array_get(rt.new_string('after'))).str())
	var_title = rt.call_function('esc_attr', [
		rt.call_function('strip_tags', [var_title.clone()]),
	])
	if rt.is_true(var_parsed_args.array_get(rt.new_string('echo'))) {
		rt.echo_val(var_title)
	} else {
		return var_title.clone()
	}
	return rt.new_null()
}

fn get_the_title(post i64) rt.PhpVal {
	mut var_post := post
	mut var_post_title := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_prepend := rt.new_null()
	mut var_protected_title_format := rt.new_null()
	mut var_private_title_format := rt.new_null()
	var_post = (rt.call_function('get_post', [rt.new_int(var_post)])).to_i64()
	var_post_title = if !(rt.get_property(rt.new_int(var_post), 'post_title')).is_null() {
		rt.get_property(rt.new_int(var_post), 'post_title')
	} else {
		rt.new_string('')
	}
	var_post_id = if !(rt.get_property(rt.new_int(var_post), 'ID')).is_null() {
		rt.get_property(rt.new_int(var_post), 'ID')
	} else {
		rt.new_int(0)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		if !(!rt.is_true(rt.get_property(rt.new_int(var_post), 'post_password'))) {
			var_prepend = rt.call_function('__', [rt.new_string('Protected: %s')])
			var_protected_title_format = rt.call_function('apply_filters', [
				rt.new_string('protected_title_format'),
				var_prepend.clone(),
				rt.new_int(var_post),
			])
			var_post_title = rt.call_function('sprintf', [var_protected_title_format.clone(),
				var_post_title.clone()])
		} else if !(rt.get_property(rt.new_int(var_post), 'post_status')).is_null()
			&& rt.is_true(rt.identical(rt.new_string('private'), rt.get_property(rt.new_int(var_post), 'post_status'))) {
			var_prepend = rt.call_function('__', [rt.new_string('Private: %s')])
			var_private_title_format = rt.call_function('apply_filters', [
				rt.new_string('private_title_format'),
				var_prepend.clone(),
				rt.new_int(var_post),
			])
			var_post_title = rt.call_function('sprintf', [var_private_title_format.clone(),
				var_post_title.clone()])
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('the_title'),
		var_post_title.clone(), var_post_id.clone()])
}

fn the_guid(post i64) {
	mut var_post := post
	mut var_post_guid := rt.new_null()
	mut var_post_id := rt.new_null()
	var_post = (rt.call_function('get_post', [rt.new_int(var_post)])).to_i64()
	var_post_guid = if !(rt.get_property(rt.new_int(var_post), 'guid')).is_null() {
		get_the_guid(var_post)
	} else {
		rt.new_string('')
	}
	var_post_id = if !(rt.get_property(rt.new_int(var_post), 'ID')).is_null() {
		rt.get_property(rt.new_int(var_post), 'ID')
	} else {
		rt.new_int(0)
	}
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('the_guid'),
		var_post_guid.clone(), var_post_id.clone()]))
}

fn get_the_guid(post i64) rt.PhpVal {
	mut var_post := post
	mut var_post_guid := rt.new_null()
	mut var_post_id := rt.new_null()
	var_post = (rt.call_function('get_post', [rt.new_int(var_post)])).to_i64()
	var_post_guid = if !(rt.get_property(rt.new_int(var_post), 'guid')).is_null() {
		rt.get_property(rt.new_int(var_post), 'guid')
	} else {
		rt.new_string('')
	}
	var_post_id = if !(rt.get_property(rt.new_int(var_post), 'ID')).is_null() {
		rt.get_property(rt.new_int(var_post), 'ID')
	} else {
		rt.new_int(0)
	}
	return rt.call_function('apply_filters', [rt.new_string('get_the_guid'),
		var_post_guid.clone(), var_post_id.clone()])
}

fn the_content(var_more_link_text rt.PhpVal, strip_teaser bool) {
	mut var_strip_teaser := strip_teaser
	mut var_content := rt.new_null()
	var_content = rt.new_string(get_the_content(var_more_link_text.clone(), strip_teaser,
		rt.new_null()))
	var_content = rt.call_function('apply_filters', [rt.new_string('the_content'),
		var_content.clone()])
	var_content = rt.call_function('str_replace', [rt.new_string(']]>'),
		rt.new_string(']]&gt;'), var_content.clone()])
	rt.echo_val(var_content)
}

fn get_the_content(var_more_link_text_arg rt.PhpVal, strip_teaser bool, var_post rt.PhpVal) string {
	mut var_strip_teaser := strip_teaser
	mut var_more_link_text := var_more_link_text_arg
	mut var_page := rt.new_null()
	mut var_more := rt.new_null()
	mut var_preview := rt.new_null()
	mut var_pages := rt.new_null()
	mut var_multipage := rt.new_null()
	mut var_matches := []rt.PhpVal{}
	mut var__post := rt.new_null()
	mut var_elements := rt.new_null()
	mut var_output := rt.new_null()
	mut var_has_teaser := false
	mut var_page_no := rt.new_null()
	mut var_content := rt.new_null()
	mut var_teaser := rt.new_null()
	var__post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var__post, 'WP_Post')))))) {
		return ''
	}
	if rt.is_true(rt.identical(rt.new_null(), var_post))
		&& rt.is_true(rt.call_function('did_action', [rt.new_string('the_post')])) {
		var_elements = rt.call_function('compact', [rt.new_string('page'),
			rt.new_string('more'), rt.new_string('preview'), rt.new_string('pages'),
			rt.new_string('multipage')])
	} else {
		var_elements = rt.call_function('generate_postdata', [
			var__post.clone()])
	}
	if rt.is_true(rt.identical(rt.new_null(), var_more_link_text)) {
		var_more_link_text = rt.call_function('sprintf', [
			rt.new_string('<span aria-label="%1$s">%2$s</span>'),
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Continue reading %s')]),
				the_title_attribute(rt.create_array([rt.ArrayItem{ key: 'echo', val: false },
					rt.ArrayItem{ key: 'post', val: var__post }])),
			]),
			rt.call_function('__', [
				rt.new_string('(more&hellip;)'),
			]),
		])
	}
	var_output = rt.new_string('')
	var_has_teaser = false
	if rt.is_true(post_password_required(var__post.clone())) {
		return (get_the_password_form(var__post.clone())).str()
	}
	if rt.is_true(rt.greater(var_elements.array_get(rt.new_string('page')),
		rt.new_int(var_elements.array_get(rt.new_string('pages')).array_count())))
	{
		var_elements.array_set('page', var_elements.array_get(rt.new_string('pages')).array_count())
	}
	var_page_no = var_elements.array_get(rt.new_string('page'))
	var_content = var_elements.array_get(rt.new_string('pages')).array_get(rt.sub(var_page_no,
		rt.new_int(1)))
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/<!--more(.*?)?-->/'),
		var_content.clone(), rt.create_array_from_list(var_matches)]))
	{
		if rt.is_true(rt.call_function('has_block', [rt.new_string('more'),
			var_content.clone()]))
		{
			var_content = rt.call_function('preg_replace', [
				rt.new_string('/<!-- \\/?wp:more(.*?) -->/'),
				rt.new_string(''),
				var_content.clone(),
			])
		}
		var_content = rt.call_function('explode', [var_matches[0], var_content.clone(),
			rt.new_int(2)])
		if !(!rt.is_true(var_matches[1])) && !(!rt.is_true(var_more_link_text)) {
			var_more_link_text = rt.call_function('strip_tags', [
				rt.call_function('wp_kses_no_null', [
					rt.new_string(var_matches[1].to_string().trim_space()),
				]),
			])
		}
		var_has_teaser = true
	} else {
		var_content = rt.create_array([rt.ArrayItem{ key: none, val: var_content }])
	}
	if rt.is_true(rt.call_function('str_contains', [rt.get_property(var__post, 'post_content'), rt.new_string('<!--noteaser-->')]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_elements.array_get(rt.new_string('multipage'))))))
		|| rt.is_true(rt.identical(rt.new_int(1), var_elements.array_get(rt.new_string('page')))) {
		var_strip_teaser = true
	}
	var_teaser = var_content.array_get(rt.new_int(0))
	if rt.is_true(var_elements.array_get(rt.new_string('more'))) && var_strip_teaser
		&& var_has_teaser {
		var_teaser = rt.new_string('')
	}
	var_output = rt.concat(var_output, var_teaser)
	if var_content.clone().array_count() > 1 {
		if rt.is_true(var_elements.array_get(rt.new_string('more'))) {
			var_output = rt.concat(var_output, rt.new_string('<span id="more-' +
				(rt.get_property(var__post, 'ID')).str() + '"></span>' +
				(var_content.array_get(rt.new_int(1))).str()))
		} else {
			if !(!rt.is_true(var_more_link_text)) {
				var_output = rt.concat(var_output, rt.call_function('apply_filters', [
					rt.new_string('the_content_more_link'),
					rt.new_string(' <a href="' +
						(rt.call_function('get_permalink', [var__post.clone()])).str() +
						rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('#more-'), rt.get_property(var__post, 'ID')), rt.new_string('" class="more-link">')), var_more_link_text), rt.new_string('</a>'))),
					var_more_link_text.clone(),
				]))
			}
			var_output = rt.call_function('force_balance_tags', [
				var_output.clone()])
		}
	}
	return var_output.str()
}

fn the_excerpt() {
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('the_excerpt'),
		rt.new_string(get_the_excerpt(rt.new_null()))]))
}

fn get_the_excerpt(var_post_arg rt.PhpVal) string {
	mut var_post := var_post_arg
	if rt.is_true(rt.new_bool(var_post.clone().is_bool())) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('2.3.0')])
	}
	var_post = rt.call_function('get_post', [var_post.clone()])
	if !rt.is_true(var_post) {
		return ''
	}
	if rt.is_true(post_password_required(var_post.clone())) {
		return (rt.call_function('__', [
			rt.new_string('There is no excerpt because this is a protected post.'),
		])).str()
	}
	return (rt.call_function('apply_filters', [rt.new_string('get_the_excerpt'),
		rt.get_property(var_post, 'post_excerpt'), var_post.clone()])).str()
}

fn has_excerpt(post i64) bool {
	mut var_post := post
	var_post = (rt.call_function('get_post', [rt.new_int(var_post)])).to_i64()
	return !(!rt.is_true(rt.get_property(rt.new_int(var_post), 'post_excerpt')))
}

fn post_class(css_class string, var_post rt.PhpVal) {
	mut var_css_class := css_class
	print('class="' +
		(rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), get_post_class(css_class, var_post.clone())])])).str() +
		'"')
}

fn get_post_class(css_class string, var_post_arg rt.PhpVal) rt.PhpVal {
	mut var_css_class := css_class
	mut var_post := var_post_arg
	mut var_classes := rt.new_null()
	mut var_post_format := rt.new_null()
	mut var_post_password_required := rt.new_null()
	mut var_taxonomies := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_term := rt.new_null()
	mut var_term_class := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	var_classes = rt.new_array()
	if var_css_class.len > 0 && var_css_class != '0' {
		if !(rt.new_string(var_css_class.str()).is_array()) {
			var_css_class = (rt.call_function('preg_split', [
				rt.new_string('#\\s+#'), rt.new_string(var_css_class.str())])).str()
		}
		var_classes = rt.call_function('array_map', [rt.new_string('esc_attr'),
			rt.new_string(var_css_class.str())])
	} else {
		var_css_class = (rt.new_array()).str()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return var_classes.clone()
	}
	var_classes.array_push('post-' + (rt.get_property(var_post, 'ID')).str())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		var_classes.array_push(rt.get_property(var_post, 'post_type'))
	}
	var_classes.array_push('type-' + (rt.get_property(var_post, 'post_type')).str())
	var_classes.array_push('status-' + (rt.get_property(var_post, 'post_status')).str())
	if rt.is_true(rt.call_function('post_type_supports', [
		rt.get_property(var_post, 'post_type'),
		rt.new_string('post-formats'),
	]))
	{
		var_post_format = rt.call_function('get_post_format', [
			rt.get_property(var_post, 'ID'),
		])
		if rt.is_true(var_post_format)
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_post_format.clone()]))))) {
			var_classes.array_push('format-' +
				(rt.call_function('sanitize_html_class', [var_post_format.clone()])).str())
		} else {
			var_classes.array_push('format-standard')
		}
	}
	var_post_password_required = post_password_required(rt.get_property(var_post, 'ID'))
	if rt.is_true(var_post_password_required) {
		var_classes.array_push('post-password-required')
	} else if !(!rt.is_true(rt.get_property(var_post, 'post_password'))) {
		var_classes.array_push('post-password-protected')
	}
	if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('post-thumbnails')]))
		&& rt.is_true(rt.call_function('has_post_thumbnail', [rt.get_property(var_post, 'ID')]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_attachment', [var_post.clone()])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_post_password_required)))) {
		var_classes.array_push('has-post-thumbnail')
	}
	if rt.is_true(rt.call_function('is_sticky', [rt.get_property(var_post, 'ID')])) {
		if rt.is_true(rt.call_function('is_home', []rt.PhpVal{}))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_paged', []rt.PhpVal{}))))) {
			var_classes.array_push('sticky')
		} else if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
			var_classes.array_push('status-sticky')
		}
	}
	var_classes.array_push('hentry')
	var_taxonomies = rt.call_function('get_taxonomies', [
		rt.create_array([rt.ArrayItem{ key: 'public', val: true }]),
	])
	var_taxonomies = rt.call_function('apply_filters', [
		rt.new_string('post_class_taxonomies'),
		var_taxonomies.clone(),
		rt.get_property(var_post, 'ID'),
		var_classes.clone(),
		rt.new_string(var_css_class.str()),
	])
	mut iter_1 := rt.cast_array(var_taxonomies).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_taxonomy_shadow := item_1.val
		if rt.is_true(rt.call_function('is_object_in_taxonomy', [
			rt.get_property(var_post, 'post_type'),
			var_taxonomy_shadow.clone(),
		]))
		{
			mut iter_2 := rt.cast_array(rt.call_function('get_the_terms', [
				rt.get_property(var_post, 'ID'),
				var_taxonomy_shadow.clone(),
			])).iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_term_shadow := item_2.val
				if !rt.is_true(rt.get_property(var_term_shadow, 'slug')) {
					continue
				}
				var_term_class = rt.call_function('sanitize_html_class', [
					rt.get_property(var_term_shadow, 'slug'),
					rt.get_property(var_term_shadow, 'term_id'),
				])
				if var_term_class.clone().is_long() || var_term_class.clone().is_double()
					|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(var_term_class.clone().to_string().trim_space()))))) {
					var_term_class = rt.get_property(var_term_shadow, 'term_id')
				}
				if rt.is_true(rt.identical(rt.new_string('post_tag'), var_taxonomy_shadow)) {
					var_classes.array_push('tag-' + var_term_class.str())
				} else {
					var_classes.array_push(rt.call_function('sanitize_html_class', [
						rt.new_string(var_taxonomy_shadow.str() + '-' + var_term_class.str()),
						rt.new_string(var_taxonomy_shadow.str() + '-' +
							(rt.get_property(var_term_shadow, 'term_id')).str()),
					]))
				}
			}
		}
	}
	var_classes = rt.call_function('array_map', [rt.new_string('esc_attr'),
		var_classes.clone()])
	var_classes = rt.call_function('apply_filters', [rt.new_string('post_class'),
		var_classes.clone(), rt.new_string(var_css_class.str()),
		rt.get_property(var_post, 'ID')])
	var_classes = rt.call_function('array_unique', [var_classes.clone()])
	var_classes = rt.call_function('array_values', [var_classes.clone()])
	return var_classes.clone()
}

fn body_class(css_class string) {
	mut var_css_class := css_class
	print('class="' +
		(rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), get_body_class(var_css_class)])])).str() +
		'"')
}

fn get_body_class(css_class string) rt.PhpVal {
	mut var_css_class := css_class
	mut var_wp_query := rt.new_null()
	mut var_classes := rt.new_null()
	mut var_post := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_post_type := rt.new_null()
	mut var_template_slug := rt.new_null()
	mut var_template_parts := rt.new_null()
	mut var_part := rt.new_null()
	mut var_post_format := rt.new_null()
	mut var_mime_type := rt.new_null()
	mut var_mime_prefix := []rt.PhpVal{}
	mut var_author := rt.new_null()
	mut var_cat := rt.new_null()
	mut var_cat_class := rt.new_null()
	mut var_tag := rt.new_null()
	mut var_tag_class := rt.new_null()
	mut var_term := rt.new_null()
	mut var_term_class := rt.new_null()
	mut var_page := rt.new_null()
	var_classes = rt.new_array()
	if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) {
		var_classes.array_push('rtl')
	}
	if rt.is_true(rt.call_function('is_front_page', []rt.PhpVal{})) {
		var_classes.array_push('home')
	}
	if rt.is_true(rt.call_function('is_home', []rt.PhpVal{})) {
		var_classes.array_push('blog')
	}
	if rt.is_true(rt.call_function('is_privacy_policy', []rt.PhpVal{})) {
		var_classes.array_push('privacy-policy')
	}
	if rt.is_true(rt.call_function('is_archive', []rt.PhpVal{})) {
		var_classes.array_push('archive')
	}
	if rt.is_true(rt.call_function('is_date', []rt.PhpVal{})) {
		var_classes.array_push('date')
	}
	if rt.is_true(rt.call_function('is_search', []rt.PhpVal{})) {
		var_classes.array_push('search')
		var_classes.array_push(if rt.is_true(rt.get_property(var_wp_query, 'posts')) {
			'search-results'
		} else {
			'search-no-results'
		})
	}
	if rt.is_true(rt.call_function('is_paged', []rt.PhpVal{})) {
		var_classes.array_push('paged')
	}
	if rt.is_true(rt.call_function('is_attachment', []rt.PhpVal{})) {
		var_classes.array_push('attachment')
	}
	if rt.is_true(rt.call_function('is_404', []rt.PhpVal{})) {
		var_classes.array_push('error404')
	}
	if rt.is_true(rt.call_function('is_singular', []rt.PhpVal{})) {
		var_post = rt.call_method(var_wp_query, 'get_queried_object', []rt.PhpVal{})
		var_post_id = rt.get_property(var_post, 'ID')
		var_post_type = rt.get_property(var_post, 'post_type')
		var_classes.array_push('wp-singular')
		if rt.is_true(rt.new_bool(is_page_template(''))) {
			var_classes.array_push('${var_post_type.to_string()}-template')
			var_template_slug = get_page_template_slug(var_post_id.clone())
			var_template_parts = rt.call_function('explode', [
				rt.new_string('/'), var_template_slug.clone()])
			mut iter_3 := var_template_parts.iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_part_shadow := item_3.val
				var_classes.array_push('${var_post_type.to_string()}-template-' +(rt.call_function('sanitize_html_class', [rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{
					key: none
					val: '.'
				}, rt.ArrayItem{ key: none, val: '/' }]), rt.new_string('-'), rt.call_function('basename', [var_part_shadow.clone(), rt.new_string('.php')])])])).str())
			}
			var_classes.array_push('${var_post_type.to_string()}-template-' +(rt.call_function('sanitize_html_class', [rt.call_function('str_replace', [rt.new_string('.'), rt.new_string('-'), var_template_slug.clone()])])).str())
		} else {
			var_classes.array_push('${var_post_type.to_string()}-template-default')
		}
		if rt.is_true(rt.call_function('is_single', []rt.PhpVal{})) {
			var_classes.array_push('single')
			if !(rt.get_property(var_post, 'post_type')).is_null() {
				var_classes.array_push('single-' +(rt.call_function('sanitize_html_class', [rt.get_property(var_post, 'post_type'), var_post_id.clone()])).str())
				var_classes.array_push('postid-' + var_post_id.str())
				if rt.is_true(rt.call_function('post_type_supports', [
					rt.get_property(var_post, 'post_type'),
					rt.new_string('post-formats'),
				]))
				{
					var_post_format = rt.call_function('get_post_format', [
						rt.get_property(var_post, 'ID'),
					])
					if rt.is_true(var_post_format)
						&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_post_format.clone()]))))) {
						var_classes.array_push('single-format-' +(rt.call_function('sanitize_html_class', [var_post_format.clone()])).str())
					} else {
						var_classes.array_push('single-format-standard')
					}
				}
			}
		}
		if rt.is_true(rt.call_function('is_attachment', []rt.PhpVal{})) {
			var_mime_type = rt.call_function('get_post_mime_type', [
				var_post_id.clone()])
			var_mime_prefix = ['application/', 'image/', 'text/', 'audio/', 'video/', 'music/']
			var_classes.array_push('attachmentid-' + var_post_id.str())
			var_classes.array_push('attachment-' +(rt.call_function('str_replace', [rt.create_array_from_list(var_mime_prefix), rt.new_string(''), var_mime_type.clone()])).str())
		} else if rt.is_true(rt.call_function('is_page', []rt.PhpVal{})) {
			var_classes.array_push('page')
			var_classes.array_push('page-id-' + var_post_id.str())
			if rt.is_true(rt.call_function('get_pages', [
				rt.create_array([rt.ArrayItem{ key: 'parent', val: var_post_id },
					rt.ArrayItem{ key: 'number', val: 1 }]),
			]))
			{
				var_classes.array_push('page-parent')
			}
			if rt.is_true(rt.get_property(var_post, 'post_parent')) {
				var_classes.array_push('page-child')
				var_classes.array_push('parent-pageid-' +
					(rt.get_property(var_post, 'post_parent')).str())
			}
		}
	} else if rt.is_true(rt.call_function('is_archive', []rt.PhpVal{})) {
		if rt.is_true(rt.call_function('is_post_type_archive', []rt.PhpVal{})) {
			var_classes.array_push('post-type-archive')
			var_post_type = rt.call_function('get_query_var', [
				rt.new_string('post_type'),
			])
			if rt.is_true(rt.new_bool(var_post_type.clone().is_array())) {
				var_post_type = rt.call_function('reset', [var_post_type.clone()])
			}
			var_classes.array_push('post-type-archive-' +
				(rt.call_function('sanitize_html_class', [var_post_type.clone()])).str())
		} else if rt.is_true(rt.call_function('is_author', []rt.PhpVal{})) {
			var_author = rt.call_method(var_wp_query, 'get_queried_object', []rt.PhpVal{})
			var_classes.array_push('author')
			if !(rt.get_property(var_author, 'user_nicename')).is_null() {
				var_classes.array_push('author-' +(rt.call_function('sanitize_html_class', [rt.get_property(var_author, 'user_nicename'), rt.get_property(var_author, 'ID')])).str())
				var_classes.array_push('author-' + (rt.get_property(var_author, 'ID')).str())
			}
		} else if rt.is_true(rt.call_function('is_category', []rt.PhpVal{})) {
			var_cat = rt.call_method(var_wp_query, 'get_queried_object', []rt.PhpVal{})
			var_classes.array_push('category')
			if !(rt.get_property(var_cat, 'term_id')).is_null() {
				var_cat_class = rt.call_function('sanitize_html_class', [
					rt.get_property(var_cat, 'slug'),
					rt.get_property(var_cat, 'term_id'),
				])
				if var_cat_class.clone().is_long() || var_cat_class.clone().is_double()
					|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(var_cat_class.clone().to_string().trim_space()))))) {
					var_cat_class = rt.get_property(var_cat, 'term_id')
				}
				var_classes.array_push('category-' + var_cat_class.str())
				var_classes.array_push('category-' + (rt.get_property(var_cat, 'term_id')).str())
			}
		} else if rt.is_true(rt.call_function('is_tag', []rt.PhpVal{})) {
			var_tag = rt.call_method(var_wp_query, 'get_queried_object', []rt.PhpVal{})
			var_classes.array_push('tag')
			if !(rt.get_property(var_tag, 'term_id')).is_null() {
				var_tag_class = rt.call_function('sanitize_html_class', [
					rt.get_property(var_tag, 'slug'),
					rt.get_property(var_tag, 'term_id'),
				])
				if var_tag_class.clone().is_long() || var_tag_class.clone().is_double()
					|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(var_tag_class.clone().to_string().trim_space()))))) {
					var_tag_class = rt.get_property(var_tag, 'term_id')
				}
				var_classes.array_push('tag-' + var_tag_class.str())
				var_classes.array_push('tag-' + (rt.get_property(var_tag, 'term_id')).str())
			}
		} else if rt.is_true(rt.call_function('is_tax', []rt.PhpVal{})) {
			var_term = rt.call_method(var_wp_query, 'get_queried_object', []rt.PhpVal{})
			if !(rt.get_property(var_term, 'term_id')).is_null() {
				var_term_class = rt.call_function('sanitize_html_class', [
					rt.get_property(var_term, 'slug'),
					rt.get_property(var_term, 'term_id'),
				])
				if var_term_class.clone().is_long() || var_term_class.clone().is_double()
					|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(var_term_class.clone().to_string().trim_space()))))) {
					var_term_class = rt.get_property(var_term, 'term_id')
				}
				var_classes.array_push('tax-' +(rt.call_function('sanitize_html_class', [rt.get_property(var_term, 'taxonomy')])).str())
				var_classes.array_push('term-' + var_term_class.str())
				var_classes.array_push('term-' + (rt.get_property(var_term, 'term_id')).str())
			}
		}
	}
	if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
		var_classes.array_push('logged-in')
	}
	if rt.is_true(rt.call_function('is_admin_bar_showing', []rt.PhpVal{})) {
		var_classes.array_push('admin-bar')
		var_classes.array_push('no-customize-support')
	}
	if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('custom-background')]))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_background_color', []rt.PhpVal{}), rt.call_function('get_theme_support', [rt.new_string('custom-background'), rt.new_string('default-color')])))))
		|| rt.is_true(rt.call_function('get_background_image', []rt.PhpVal{})) {
		var_classes.array_push('custom-background')
	}
	if rt.is_true(rt.call_function('has_custom_logo', []rt.PhpVal{})) {
		var_classes.array_push('wp-custom-logo')
	}
	if rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('responsive-embeds'),
	]))
	{
		var_classes.array_push('wp-embed-responsive')
	}
	var_page = rt.call_method(var_wp_query, 'get', [rt.new_string('page')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_page))))
		|| rt.is_true(rt.less(var_page, rt.new_int(2))) {
		var_page = rt.call_method(var_wp_query, 'get', [rt.new_string('paged')])
	}
	if rt.is_true(var_page) && rt.is_true(rt.greater(var_page, rt.new_int(1)))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_404', []rt.PhpVal{}))))) {
		var_classes.array_push('paged-' + var_page.str())
		if rt.is_true(rt.call_function('is_single', []rt.PhpVal{})) {
			var_classes.array_push('single-paged-' + var_page.str())
		} else if rt.is_true(rt.call_function('is_page', []rt.PhpVal{})) {
			var_classes.array_push('page-paged-' + var_page.str())
		} else if rt.is_true(rt.call_function('is_category', []rt.PhpVal{})) {
			var_classes.array_push('category-paged-' + var_page.str())
		} else if rt.is_true(rt.call_function('is_tag', []rt.PhpVal{})) {
			var_classes.array_push('tag-paged-' + var_page.str())
		} else if rt.is_true(rt.call_function('is_date', []rt.PhpVal{})) {
			var_classes.array_push('date-paged-' + var_page.str())
		} else if rt.is_true(rt.call_function('is_author', []rt.PhpVal{})) {
			var_classes.array_push('author-paged-' + var_page.str())
		} else if rt.is_true(rt.call_function('is_search', []rt.PhpVal{})) {
			var_classes.array_push('search-paged-' + var_page.str())
		} else if rt.is_true(rt.call_function('is_post_type_archive', []rt.PhpVal{})) {
			var_classes.array_push('post-type-paged-' + var_page.str())
		}
	}
	var_classes.array_push('wp-theme-' +(rt.call_function('sanitize_html_class', [rt.call_function('get_template', []rt.PhpVal{})])).str())
	if rt.is_true(rt.call_function('is_child_theme', []rt.PhpVal{})) {
		var_classes.array_push('wp-child-theme-' +(rt.call_function('sanitize_html_class', [rt.call_function('get_stylesheet', []rt.PhpVal{})])).str())
	}
	if !(var_css_class == '') {
		if !(rt.new_string(var_css_class.str()).is_array()) {
			var_css_class = (rt.call_function('preg_split', [
				rt.new_string('#\\s+#'), rt.new_string(var_css_class.str())])).str()
		}
		var_classes = rt.call_function('array_merge', [var_classes.clone(),
			rt.new_string(var_css_class.str())])
	} else {
		var_css_class = (rt.new_array()).str()
	}
	var_classes = rt.call_function('array_map', [rt.new_string('esc_attr'),
		var_classes.clone()])
	var_classes = rt.call_function('apply_filters', [rt.new_string('body_class'),
		var_classes.clone(), rt.new_string(var_css_class.str())])
	return rt.call_function('array_unique', [var_classes.clone()])
}

fn post_password_required(var_post_arg rt.PhpVal) rt.PhpVal {
	mut var_post := var_post_arg
	mut var_hasher := rt.new_null()
	mut var_hash := rt.new_null()
	mut var_required := false
	var_post = rt.call_function('get_post', [var_post.clone()])
	if !rt.is_true(rt.get_property(var_post, 'post_password')) {
		return rt.call_function('apply_filters', [
			rt.new_string('post_password_required'),
			rt.new_bool(false),
			var_post.clone(),
		])
	}
	if !(rt.get_superglobal('_COOKIE').array_isset('wp-postpass_' +
		(rt.get_constant('COOKIEHASH')).str())) {
		return rt.call_function('apply_filters', [
			rt.new_string('post_password_required'),
			rt.new_bool(true),
			var_post.clone(),
		])
	}
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-phpass.php',
		'4')
	var_hasher = create_passwordhash(rt.new_int(8), rt.new_bool(true))
	var_hash = rt.call_function('wp_unslash', [
		rt.get_superglobal('_COOKIE').array_get(rt.new_string('wp-postpass_' +
			(rt.get_constant('COOKIEHASH')).str())),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [
		var_hash.clone(),
		rt.new_string('$P$B'),
	])))))
	{
		var_required = true
	} else {
		var_required = !(rt.is_true(var_hasher.checkpassword(rt.get_property(var_post,
			'post_password'), var_hash.clone())))
	}
	return rt.call_function('apply_filters', [rt.new_string('post_password_required'),
		rt.new_bool(var_required).clone(), var_post.clone()])
}

fn wp_link_pages(args string) rt.PhpVal {
	mut var_args := args
	mut var_page := rt.new_null()
	mut var_numpages := rt.new_null()
	mut var_multipage := rt.new_null()
	mut var_more := rt.new_null()
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_parsed_args := rt.new_null()
	mut var_output := ''
	mut var_link := rt.new_null()
	mut var_i := i64(0)
	mut var_prev := rt.new_null()
	mut var_next := rt.new_null()
	mut var_html := rt.new_null()
	var_defaults = {
		'before':           '<p class="post-nav-links">' +
			(rt.call_function('__', [rt.new_string('Pages:')])).str()
		'after':            rt.new_string('</p>')
		'link_before':      rt.new_string('')
		'link_after':       rt.new_string('')
		'aria_current':     rt.new_string('page')
		'next_or_number':   rt.new_string('number')
		'separator':        rt.new_string(' ')
		'nextpagelink':     rt.call_function('__', [rt.new_string('Next page')])
		'previouspagelink': rt.call_function('__', [rt.new_string('Previous page')])
		'pagelink':         rt.new_string('%')
		'echo':             rt.new_int(1)
	}
	var_parsed_args = rt.call_function('wp_parse_args', [rt.new_string(args),
		rt.create_array_from_native_map(var_defaults)])
	var_parsed_args = rt.call_function('apply_filters', [
		rt.new_string('wp_link_pages_args'),
		var_parsed_args.clone(),
	])
	var_output = ''
	if rt.is_true(var_multipage) {
		if rt.is_true(rt.identical(rt.new_string('number'),
			var_parsed_args.array_get(rt.new_string('next_or_number'))))
		{
			var_output = var_output + (var_parsed_args.array_get(rt.new_string('before'))).str()
			var_i = 1
			for {
				if !(rt.is_true(rt.less_equal(rt.new_int(var_i), var_numpages))) { break
				 }
				var_link = rt.new_string(
					(var_parsed_args.array_get(rt.new_string('link_before'))).str() + (rt.call_function('str_replace', [rt.new_string('%'), rt.new_int(var_i).clone(), var_parsed_args.array_get(rt.new_string('pagelink'))])).str() +
					(var_parsed_args.array_get(rt.new_string('link_after'))).str())
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(var_i), var_page))))
					|| (rt.is_true(rt.new_bool(!(rt.is_true(var_more))))
					&& rt.is_true(rt.identical(rt.new_int(1), var_page))) {
					var_link = rt.new_string(_wp_link_page(var_i) + var_link.str() + '</a>')
				} else if rt.is_true(rt.identical(rt.new_int(var_i), var_page)) {
					var_link = rt.new_string(
						'<span class="post-page-numbers current" aria-current="' +
						(rt.call_function('esc_attr', [var_parsed_args.array_get(rt.new_string('aria_current'))])).str() +
						'">' + var_link.str() + '</span>')
				}
				var_link = rt.call_function('apply_filters', [
					rt.new_string('wp_link_pages_link'),
					var_link.clone(),
					rt.new_int(var_i).clone(),
				])
				var_output = var_output +(if 1 == var_i { rt.new_string(' ') } else { var_parsed_args.array_get(rt.new_string('separator')) }).str()
				var_output = var_output + var_link.str()
				var_i += 1
			}
			var_output = var_output + (var_parsed_args.array_get(rt.new_string('after'))).str()
		} else if rt.is_true(var_more) {
			var_output = var_output + (var_parsed_args.array_get(rt.new_string('before'))).str()
			var_prev = rt.sub(var_page, rt.new_int(1))
			if rt.is_true(rt.greater(var_prev, rt.new_int(0))) {
				var_link = rt.new_string(_wp_link_page(var_prev.clone()) +
					(var_parsed_args.array_get(rt.new_string('link_before'))).str() + (var_parsed_args.array_get(rt.new_string('previouspagelink'))).str() + (var_parsed_args.array_get(rt.new_string('link_after'))).str() + '</a>')
				var_output = var_output +(rt.call_function('apply_filters', [rt.new_string('wp_link_pages_link'), var_link.clone(), var_prev.clone()])).str()
			}
			var_next = rt.add(var_page, rt.new_int(1))
			if rt.is_true(rt.less_equal(var_next, var_numpages)) {
				if rt.is_true(var_prev) {
					var_output = var_output +
						(var_parsed_args.array_get(rt.new_string('separator'))).str()
				}
				var_link = rt.new_string(_wp_link_page(var_next.clone()) +
					(var_parsed_args.array_get(rt.new_string('link_before'))).str() + (var_parsed_args.array_get(rt.new_string('nextpagelink'))).str() + (var_parsed_args.array_get(rt.new_string('link_after'))).str() + '</a>')
				var_output = var_output +(rt.call_function('apply_filters', [rt.new_string('wp_link_pages_link'), var_link.clone(), var_next.clone()])).str()
			}
			var_output = var_output + (var_parsed_args.array_get(rt.new_string('after'))).str()
		}
	}
	var_html = rt.call_function('apply_filters', [rt.new_string('wp_link_pages'),
		rt.new_string(var_output.str()).clone(), rt.new_string(args)])
	if rt.is_true(var_parsed_args.array_get(rt.new_string('echo'))) {
		rt.echo_val(var_html)
	}
	return var_html.clone()
}

fn _wp_link_page(var_i rt.PhpVal) string {
	mut var_wp_rewrite := rt.new_null()
	mut var_post := rt.new_null()
	mut var_query_args := map[string]rt.PhpVal{}
	mut var_url := rt.new_null()
	var_post = rt.call_function('get_post', []rt.PhpVal{})
	var_query_args = rt.new_array()
	if rt.is_true(rt.identical(rt.new_int(1), var_i)) {
		var_url = rt.call_function('get_permalink', []rt.PhpVal{})
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [rt.new_string('permalink_structure')])))))
			|| rt.is_true(rt.call_function('in_array', [rt.get_property(var_post, 'post_status'), rt.create_array([rt.ArrayItem{
			key: none
			val: 'draft'
		}, rt.ArrayItem{ key: none, val: 'pending' }]), rt.new_bool(true)])) {
			var_url = rt.call_function('add_query_arg', [rt.new_string('page'),
				var_i.clone(), rt.call_function('get_permalink', []rt.PhpVal{})])
		} else if
			rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')])))
			&& rt.is_true(rt.identical(rt.new_int((rt.call_function('get_option', [rt.new_string('page_on_front')])).to_i64()), rt.get_property(var_post, 'ID'))) {
			var_url = rt.new_string(
				(rt.call_function('trailingslashit', [rt.call_function('get_permalink', []rt.PhpVal{})])).str() +
				(rt.call_function('user_trailingslashit', [rt.new_string((rt.concat(rt.get_property(var_wp_rewrite, 'pagination_base'), rt.new_string('/')) +
				var_i.str()).str()), rt.new_string('single_paged')])).str())
		} else {
			var_url = rt.new_string(
				(rt.call_function('trailingslashit', [rt.call_function('get_permalink', []rt.PhpVal{})])).str() +(rt.call_function('user_trailingslashit', [var_i.clone(), rt.new_string('single_paged')])).str())
		}
	}
	if rt.is_true(rt.call_function('is_preview', []rt.PhpVal{})) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('draft'), rt.get_property(var_post, 'post_status')))))
			&& rt.get_superglobal('_GET').array_isset(rt.new_string('preview_id'))
			&& rt.get_superglobal('_GET').array_isset(rt.new_string('preview_nonce')) {
			var_query_args['preview_id'] = rt.call_function('wp_unslash', [
				rt.get_superglobal('_GET').array_get(rt.new_string('preview_id')),
			])
			var_query_args['preview_nonce'] = rt.call_function('wp_unslash', [
				rt.get_superglobal('_GET').array_get(rt.new_string('preview_nonce')),
			])
		}
		var_url = rt.call_function('get_preview_post_link', [
			var_post.clone(), rt.create_array_from_native_map(var_query_args),
			var_url.clone()])
	}
	return '<a href="' + (rt.call_function('esc_url', [var_url.clone()])).str() +
		'" class="post-page-numbers">'
}

fn post_custom(key string) bool {
	mut var_key := key
	mut var_custom := rt.new_null()
	var_custom = rt.call_function('get_post_custom', []rt.PhpVal{})
	if !(var_custom.array_isset(rt.new_string(key))) {
		return false
	} else if 1 == var_custom.array_get(rt.new_string(key)).array_count() {
		return (var_custom.array_get(rt.new_string(key)).array_get(rt.new_int(0))).to_bool()
	} else {
		return (var_custom.array_get(rt.new_string(key))).to_bool()
	}
	return false
}

fn the_meta() {
	mut var_keys := rt.new_null()
	mut var_li_html := ''
	mut var_key := rt.new_null()
	mut var_keyt := ''
	mut var_values := rt.new_null()
	mut var_value := rt.new_null()
	mut var_html := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.0.2'), rt.new_string('get_post_meta()')])
	var_keys = rt.call_function('get_post_custom_keys', []rt.PhpVal{})
	if rt.is_true(var_keys) {
		var_li_html = ''
		mut iter_4 := rt.cast_array(var_keys).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_key_shadow := item_4.val
			var_keyt = var_key_shadow.clone().to_string().trim_space()
			if rt.is_true(rt.call_function('is_protected_meta', [
				rt.new_string(var_keyt.str()).clone(), rt.new_string('post')]))
			{
				continue
			}
			var_values = rt.call_function('array_map', [rt.new_string('trim'),
				rt.call_function('get_post_custom_values', [var_key_shadow.clone()])])
			var_value = rt.call_function('implode', [rt.new_string(', '),
				var_values.clone()])
			var_html = rt.call_function('sprintf', [
				rt.new_string("<li><span class='post-meta-key'>%s</span> %s</li>\n"),
				rt.call_function('esc_html', [
					rt.call_function('sprintf', [
						rt.call_function('_x', [rt.new_string('%s:'),
							rt.new_string('Post custom field name')]),
						var_key_shadow.clone(),
					]),
				]),
				rt.call_function('esc_html', [
					var_value.clone(),
				]),
			])
			var_li_html = var_li_html +(rt.call_function('apply_filters', [rt.new_string('the_meta_key'), var_html.clone(), var_key_shadow.clone(), var_value.clone()])).str()
		}
		if var_li_html.len > 0 && var_li_html != '0' {
			print("<ul class='post-meta'>\n${var_li_html}</ul>\n")
		}
	}
}

fn wp_dropdown_pages(args string) rt.PhpVal {
	mut var_args := args
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_parsed_args := rt.new_null()
	mut var_pages := rt.new_null()
	mut var_output := rt.new_null()
	mut var_class := rt.new_null()
	mut var_html := rt.new_null()
	var_defaults = {
		'depth':                 rt.new_int(0)
		'child_of':              rt.new_int(0)
		'selected':              rt.new_int(0)
		'echo':                  rt.new_int(1)
		'name':                  rt.new_string('page_id')
		'id':                    rt.new_string('')
		'class':                 rt.new_string('')
		'show_option_none':      rt.new_string('')
		'show_option_no_change': rt.new_string('')
		'option_none_value':     rt.new_string('')
		'value_field':           rt.new_string('ID')
	}
	var_parsed_args = rt.call_function('wp_parse_args', [rt.new_string(args),
		rt.create_array_from_native_map(var_defaults)])
	var_pages = rt.call_function('get_pages', [var_parsed_args.clone()])
	var_output = rt.new_string('')
	if !rt.is_true(var_parsed_args.array_get(rt.new_string('id'))) {
		var_parsed_args.array_set('id', var_parsed_args.array_get(rt.new_string('name')))
	}
	if !(!rt.is_true(var_pages)) {
		var_class = rt.new_string('')
		if !(!rt.is_true(var_parsed_args.array_get(rt.new_string('class')))) {
			var_class = rt.new_string(" class='" +
				(rt.call_function('esc_attr', [var_parsed_args.array_get(rt.new_string('class'))])).str() +
				"'")
		}
		var_output = rt.new_string("<select name='" +
			(rt.call_function('esc_attr', [var_parsed_args.array_get(rt.new_string('name'))])).str() +
			"'" + var_class.str() + " id='" +
			(rt.call_function('esc_attr', [var_parsed_args.array_get(rt.new_string('id'))])).str() +
			"'>\n")
		if rt.is_true(var_parsed_args.array_get(rt.new_string('show_option_no_change'))) {
			var_output = rt.concat(var_output, rt.new_string('\t<option value="-1">' +
				(var_parsed_args.array_get(rt.new_string('show_option_no_change'))).str() + '</option>\n'))
		}
		if rt.is_true(var_parsed_args.array_get(rt.new_string('show_option_none'))) {
			var_output = rt.concat(var_output, rt.new_string('\t<option value="' +
				(rt.call_function('esc_attr', [var_parsed_args.array_get(rt.new_string('option_none_value'))])).str() +
				'">' +
				(var_parsed_args.array_get(rt.new_string('show_option_none'))).str() + '</option>\n'))
		}
		var_output = rt.concat(var_output, walk_page_dropdown_tree(var_pages.clone(),
			var_parsed_args.array_get(rt.new_string('depth')), var_parsed_args.clone()))
		var_output = rt.concat(var_output, rt.new_string('</select>\n'))
	}
	var_html = rt.call_function('apply_filters', [rt.new_string('wp_dropdown_pages'),
		var_output.clone(), var_parsed_args.clone(), var_pages.clone()])
	if rt.is_true(var_parsed_args.array_get(rt.new_string('echo'))) {
		rt.echo_val(var_html)
	}
	return var_html.clone()
}

fn wp_list_pages(args string) rt.PhpVal {
	mut var_args := args
	mut var_wp_query := rt.new_null()
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_parsed_args := rt.new_null()
	mut var_output := ''
	mut var_current_page := rt.new_null()
	mut var_exclude_array := rt.new_null()
	mut var_pages := rt.new_null()
	mut var_queried_object := rt.new_null()
	mut var_html := rt.new_null()
	var_defaults = {
		'depth':        rt.new_int(0)
		'show_date':    rt.new_string('')
		'date_format':  rt.call_function('get_option', [rt.new_string('date_format')])
		'child_of':     rt.new_int(0)
		'exclude':      rt.new_string('')
		'title_li':     rt.call_function('__', [rt.new_string('Pages')])
		'echo':         rt.new_int(1)
		'authors':      rt.new_string('')
		'sort_column':  rt.new_string('menu_order, post_title')
		'link_before':  rt.new_string('')
		'link_after':   rt.new_string('')
		'item_spacing': rt.new_string('preserve')
		'walker':       rt.new_string('')
	}
	var_parsed_args = rt.call_function('wp_parse_args', [rt.new_string(args),
		rt.create_array_from_native_map(var_defaults)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_parsed_args.array_get(rt.new_string('item_spacing')),
		rt.create_array([rt.ArrayItem{ key: none, val: 'preserve' },
			rt.ArrayItem{ key: none, val: 'discard' }]),
		rt.new_bool(true),
	])))))
	{
		var_parsed_args.array_set('item_spacing', var_defaults['item_spacing'])
	}
	var_output = ''
	var_current_page = rt.new_int(0)
	var_parsed_args.array_set('exclude', rt.call_function('preg_replace', [
		rt.new_string('/[^0-9,]/'),
		rt.new_string(''),
		var_parsed_args.array_get(rt.new_string('exclude')),
	]))
	var_exclude_array = if rt.is_true(var_parsed_args.array_get(rt.new_string('exclude'))) { rt.call_function('explode', [
			rt.new_string(','),
			var_parsed_args.array_get(rt.new_string('exclude')),
		]) } else { rt.new_array() }
	var_parsed_args.array_set('exclude', rt.call_function('implode', [
		rt.new_string(','),
		rt.call_function('apply_filters', [
			rt.new_string('wp_list_pages_excludes'),
			var_exclude_array.clone(),
		])]))
	var_parsed_args.array_set('hierarchical', 0)
	var_pages = rt.call_function('get_pages', [var_parsed_args.clone()])
	if !(!rt.is_true(var_pages)) {
		if rt.is_true(var_parsed_args.array_get(rt.new_string('title_li'))) {
			var_output = var_output + '<li class="pagenav">' +
				(var_parsed_args.array_get(rt.new_string('title_li'))).str() + '<ul>'
		}
		if rt.is_true(rt.call_function('is_page', []rt.PhpVal{}))
			|| rt.is_true(rt.call_function('is_attachment', []rt.PhpVal{}))
			|| rt.is_true(rt.get_property(var_wp_query, 'is_posts_page')) {
			var_current_page = rt.call_function('get_queried_object_id', []rt.PhpVal{})
		} else if rt.is_true(rt.call_function('is_singular', []rt.PhpVal{})) {
			var_queried_object = rt.call_function('get_queried_object', []rt.PhpVal{})
			if rt.is_true(rt.call_function('is_post_type_hierarchical', [
				rt.get_property(var_queried_object, 'post_type'),
			]))
			{
				var_current_page = rt.get_property(var_queried_object, 'ID')
			}
		}
		var_output = var_output +(walk_page_tree(var_pages.clone(), var_parsed_args.array_get(rt.new_string('depth')), var_current_page.clone(), var_parsed_args.clone())).str()
		if rt.is_true(var_parsed_args.array_get(rt.new_string('title_li'))) {
			var_output = var_output + '</ul></li>'
		}
	}
	var_html = rt.call_function('apply_filters', [rt.new_string('wp_list_pages'),
		rt.new_string(var_output.str()).clone(), var_parsed_args.clone(),
		var_pages.clone()])
	if rt.is_true(var_parsed_args.array_get(rt.new_string('echo'))) {
		rt.echo_val(var_html)
	} else {
		return var_html.clone()
	}
	return rt.new_null()
}

fn wp_page_menu(var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_args := var_args_arg
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_t := ''
	mut var_n := ''
	mut var_menu := rt.new_null()
	mut var_list_args := rt.new_null()
	mut var_text := rt.new_null()
	mut var_class := ''
	mut var_container := rt.new_null()
	mut var_attrs := ''
	var_defaults = {
		'sort_column':  rt.new_string('menu_order, post_title')
		'menu_id':      rt.new_string('')
		'menu_class':   rt.new_string('menu')
		'container':    rt.new_string('div')
		'echo':         rt.new_bool(true)
		'link_before':  rt.new_string('')
		'link_after':   rt.new_string('')
		'before':       rt.new_string('<ul>')
		'after':        rt.new_string('</ul>')
		'item_spacing': rt.new_string('discard')
		'walker':       rt.new_string('')
	}
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array_from_native_map(var_defaults)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_args.array_get(rt.new_string('item_spacing')),
		rt.create_array([rt.ArrayItem{ key: none, val: 'preserve' },
			rt.ArrayItem{ key: none, val: 'discard' }]),
		rt.new_bool(true),
	])))))
	{
		var_args.array_set('item_spacing', var_defaults['item_spacing'])
	}
	if rt.is_true(rt.identical(rt.new_string('preserve'),
		var_args.array_get(rt.new_string('item_spacing'))))
	{
		var_t = '\t'
		var_n = '\n'
	} else {
		var_t = ''
		var_n = ''
	}
	var_args = rt.call_function('apply_filters', [rt.new_string('wp_page_menu_args'),
		var_args.clone()])
	var_menu = rt.new_string('')
	var_list_args = var_args.clone()
	if !(!rt.is_true(var_args.array_get(rt.new_string('show_home')))) {
		if rt.is_true(rt.identical(rt.new_bool(true), var_args.array_get(rt.new_string('show_home'))))
			|| rt.is_true(rt.identical(rt.new_string('1'), var_args.array_get(rt.new_string('show_home'))))
			|| rt.is_true(rt.identical(rt.new_int(1), var_args.array_get(rt.new_string('show_home')))) {
			var_text = rt.call_function('__', [rt.new_string('Home')])
		} else {
			var_text = var_args.array_get(rt.new_string('show_home'))
		}
		var_class = ''
		if rt.is_true(rt.call_function('is_front_page', []rt.PhpVal{}))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_paged', []rt.PhpVal{}))))) {
			var_class = 'class="current_page_item"'
		}
		var_menu = rt.concat(var_menu, rt.new_string('<li ' + var_class + '><a href="' +
			(rt.call_function('esc_url', [rt.call_function('home_url', [rt.new_string('/')])])).str() +
			'">' + (var_args.array_get(rt.new_string('link_before'))).str() + var_text.str() +
			(var_args.array_get(rt.new_string('link_after'))).str() + '</a></li>'))
		if rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [
			rt.new_string('show_on_front'),
		])))
		{
			if !(!rt.is_true(var_list_args.array_get(rt.new_string('exclude')))) {
				var_list_args.array_get(rt.new_string('exclude')) = rt.concat(var_list_args.array_get(rt.new_string('exclude')),
					rt.new_string(','))
			} else {
				var_list_args.array_set('exclude', '')
			}
			var_list_args.array_get(rt.new_string('exclude')) = rt.concat(var_list_args.array_get(rt.new_string('exclude')), rt.call_function('get_option', [
				rt.new_string('page_on_front'),
			]))
		}
	}
	var_list_args.array_set('echo', false)
	var_list_args.array_set('title_li', '')
	var_menu = rt.concat(var_menu, wp_list_pages(var_list_args.clone()))
	var_container = rt.call_function('sanitize_text_field', [
		var_args.array_get(rt.new_string('container')),
	])
	if !rt.is_true(var_container) {
		var_container = rt.new_string('div')
	}
	if rt.is_true(var_menu) {
		if var_args.array_isset(rt.new_string('fallback_cb'))
			&& rt.is_true(rt.identical(rt.new_string('wp_page_menu'), var_args.array_get(rt.new_string('fallback_cb'))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('ul'), var_container)))) {
			var_args.array_set('before', '<ul>${var_n}')
			var_args.array_set('after', '</ul>')
		}
		var_menu = rt.new_string(
			(var_args.array_get(rt.new_string('before'))).str() + var_menu.str() +
			(var_args.array_get(rt.new_string('after'))).str())
	}
	var_attrs = ''
	if !(!rt.is_true(var_args.array_get(rt.new_string('menu_id')))) {
		var_attrs = var_attrs + ' id="' +
			(rt.call_function('esc_attr', [var_args.array_get(rt.new_string('menu_id'))])).str() +
			'"'
	}
	if !(!rt.is_true(var_args.array_get(rt.new_string('menu_class')))) {
		var_attrs = var_attrs + ' class="' +
			(rt.call_function('esc_attr', [var_args.array_get(rt.new_string('menu_class'))])).str() +
			'"'
	}
	var_menu = rt.new_string('<${var_container.to_string()}${var_attrs}>' + var_menu.str() +
		'</${var_container.to_string()}>${var_n}')
	var_menu = rt.call_function('apply_filters', [rt.new_string('wp_page_menu'),
		var_menu.clone(), var_args.clone()])
	if rt.is_true(var_args.array_get(rt.new_string('echo'))) {
		rt.echo_val(var_menu)
	} else {
		return var_menu.clone()
	}
	return rt.new_null()
}

fn walk_page_tree(var_pages rt.PhpVal, var_depth rt.PhpVal, var_current_page rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_walker := rt.new_null()
	mut var_page := rt.new_null()
	if !rt.is_true(var_args.array_get(rt.new_string('walker'))) {
		var_walker = create_walker_page()
	} else {
		var_walker = var_args.array_get(rt.new_string('walker'))
	}
	mut iter_5 := rt.cast_array(var_pages).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_page_shadow := item_5.val
		if rt.is_true(rt.get_property(var_page_shadow, 'post_parent')) {
			var_args.array_get_mut('pages_with_children').array_set(rt.get_property(var_page_shadow,
				'post_parent'), true)
		}
	}
	return rt.call_method(var_walker, 'walk', [var_pages.clone(),
		var_depth.clone(), var_args.clone(), var_current_page.clone()])
}

fn walk_page_dropdown_tree(var_args_origin ...rt.PhpVal) rt.PhpVal {
	mut var_args := rt.create_array_from_list(var_args_origin)
	mut var_walker := rt.new_null()
	if !rt.is_true(var_args.array_get(rt.new_int(2)).array_get(rt.new_string('walker'))) {
		var_walker = create_walker_pagedropdown()
	} else {
		var_walker = var_args.array_get(rt.new_int(2)).array_get(rt.new_string('walker'))
	}
	return rt.call_method(var_walker, 'walk', [var_args.clone()])
}

fn the_attachment_link(post i64, fullsize bool, deprecated bool, permalink bool) {
	mut var_post := post
	mut var_fullsize := fullsize
	mut var_deprecated := deprecated
	mut var_permalink := permalink
	if !(!deprecated) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('2.5.0')])
	}
	if var_fullsize {
		rt.echo_val(wp_get_attachment_link(var_post, 'full', permalink, false, false, ''))
	} else {
		rt.echo_val(wp_get_attachment_link(var_post, 'thumbnail', permalink, false, false, ''))
	}
}

fn wp_get_attachment_link(post i64, size string, permalink bool, icon bool, text bool, attr string) rt.PhpVal {
	mut var_post := post
	mut var_size := size
	mut var_permalink := permalink
	mut var_icon := icon
	mut var_text := text
	mut var_attr := attr
	mut var__post := rt.new_null()
	mut var_url := rt.new_null()
	mut var_link_text := rt.new_null()
	mut var_attributes := rt.new_null()
	mut var_link_attributes := ''
	mut var_value := rt.new_null()
	mut var_name := rt.new_null()
	mut var_link_html := ''
	var__post = rt.call_function('get_post', [rt.new_int(var_post)])
	if !rt.is_true(var__post)
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('attachment'), rt.get_property(var__post, 'post_type')))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_get_attachment_url', [rt.get_property(var__post, 'ID')]))))) {
		return rt.call_function('__', [rt.new_string('Missing Attachment')])
	}
	var_url = rt.call_function('wp_get_attachment_url', [
		rt.get_property(var__post, 'ID'),
	])
	if var_permalink {
		var_url = rt.call_function('get_attachment_link', [
			rt.get_property(var__post, 'ID'),
		])
	}
	if var_text {
		var_link_text = rt.new_bool(text)
	} else if var_size.len > 0 && var_size != '0' && rt.is_true(rt.new_bool('none' != size)) {
		var_link_text = rt.call_function('wp_get_attachment_image', [
			rt.get_property(var__post, 'ID'),
			rt.new_string(size),
			rt.new_bool(icon),
			rt.new_string(attr),
		])
	} else {
		var_link_text = rt.new_string('')
	}
	if rt.is_true(rt.identical(rt.new_string(''),
		rt.new_string(var_link_text.clone().to_string().trim_space())))
	{
		var_link_text = rt.get_property(var__post, 'post_title')
	}
	if rt.is_true(rt.identical(rt.new_string(''),
		rt.new_string(var_link_text.clone().to_string().trim_space())))
	{
		var_link_text = rt.call_function('esc_html', [
			rt.call_function('pathinfo', [
				rt.call_function('get_attached_file', [rt.get_property(var__post, 'ID')]),
				rt.get_constant('PATHINFO_FILENAME'),
			]),
		])
	}
	var_attributes = rt.call_function('apply_filters', [
		rt.new_string('wp_get_attachment_link_attributes'),
		rt.create_array([rt.ArrayItem{ key: 'href', val: var_url }]),
		rt.get_property(var__post, 'ID'),
	])
	var_link_attributes = ''
	mut iter_6 := var_attributes.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_value_shadow := item_6.val
		mut var_name_shadow := item_6.key
		var_value_shadow = if rt.is_true(rt.identical(rt.new_string('href'), var_name_shadow)) { rt.call_function('esc_url', [
				var_value_shadow.clone(),
			]) } else { rt.call_function('esc_attr', [var_value_shadow.clone()]) }
		var_link_attributes = var_link_attributes + ' ' +
			(rt.call_function('esc_attr', [var_name_shadow.clone()])).str() + "='" +
			var_value_shadow.str() + "'"
	}
	var_link_html = '<a${var_link_attributes}>${var_link_text.to_string()}</a>'
	return rt.call_function('apply_filters', [rt.new_string('wp_get_attachment_link'),
		rt.new_string(var_link_html.str()).clone(), rt.new_int(var_post),
		rt.new_string(size), rt.new_bool(permalink), rt.new_bool(icon),
		rt.new_bool(text), rt.new_string(attr)])
}

fn prepend_attachment(var_content rt.PhpVal) string {
	mut var_post := rt.new_null()
	mut var_meta := rt.new_null()
	mut var_atts := map[string]rt.PhpVal{}
	mut var_p := rt.new_null()
	var_post = rt.call_function('get_post', []rt.PhpVal{})
	if !rt.is_true(rt.get_property(var_post, 'post_type'))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('attachment'), rt.get_property(var_post, 'post_type'))))) {
		return var_content.str()
	}
	if rt.is_true(rt.call_function('wp_attachment_is', [rt.new_string('video'),
		var_post.clone()]))
	{
		var_meta = rt.call_function('wp_get_attachment_metadata', [
			get_the_id()])
		var_atts = {
			'src': rt.call_function('wp_get_attachment_url', []rt.PhpVal{})
		}
		if !(!rt.is_true(var_meta.array_get(rt.new_string('width'))))
			&& !(!rt.is_true(var_meta.array_get(rt.new_string('height')))) {
			var_atts['width'] = rt.new_int((var_meta.array_get(rt.new_string('width'))).to_i64())
			var_atts['height'] = rt.new_int((var_meta.array_get(rt.new_string('height'))).to_i64())
		}
		if rt.is_true(rt.call_function('has_post_thumbnail', []rt.PhpVal{})) {
			var_atts['poster'] = rt.call_function('wp_get_attachment_url', [
				rt.call_function('get_post_thumbnail_id', []rt.PhpVal{}),
			])
		}
		var_p = rt.call_function('wp_video_shortcode', [
			rt.create_array_from_native_map(var_atts),
		])
	} else if rt.is_true(rt.call_function('wp_attachment_is', [
		rt.new_string('audio'), var_post.clone()]))
	{
		var_p = rt.call_function('wp_audio_shortcode', [
			rt.create_array([
				rt.ArrayItem{ key: 'src', val: rt.call_function('wp_get_attachment_url',
					[]rt.PhpVal{}) },
			]),
		])
	} else {
		var_p = rt.new_string('<p class="attachment">')
		var_p = rt.concat(var_p, wp_get_attachment_link(0, 'medium', false, false, false, ''))
		var_p = rt.concat(var_p, rt.new_string('</p>'))
	}
	var_p = rt.call_function('apply_filters', [rt.new_string('prepend_attachment'),
		var_p.clone()])
	return '${var_p.to_string()}\n${var_content.to_string()}'
}

fn get_the_password_form(post i64) rt.PhpVal {
	mut var_post := post
	mut var_field_id := rt.new_null()
	mut var_invalid_password := rt.new_null()
	mut var_invalid_password_html := rt.new_null()
	mut var_aria := rt.new_null()
	mut var_class := ''
	mut var_redirect_field := rt.new_null()
	mut var_output := rt.new_null()
	var_post = (rt.call_function('get_post', [rt.new_int(var_post)])).to_i64()
	var_field_id =
		rt.new_string('pwbox-' +(if !rt.is_true(rt.get_property(rt.new_int(var_post), 'ID')) { rt.call_function('wp_rand', []rt.PhpVal{}) } else { rt.get_property(rt.new_int(var_post), 'ID') }).str())
	var_invalid_password = rt.new_string('')
	var_invalid_password_html = rt.new_string('')
	var_aria = rt.new_string('')
	var_class = ''
	var_redirect_field = rt.new_string('')
	if !(!rt.is_true(rt.get_property(rt.new_int(var_post), 'ID')))
		&& rt.is_true(rt.identical(rt.call_function('wp_get_raw_referer', []rt.PhpVal{}), rt.call_function('get_permalink', [rt.get_property(rt.new_int(var_post), 'ID')])))
		&& rt.get_superglobal('_COOKIE').array_isset('wp-postpass_' + (rt.get_constant('COOKIEHASH')).str()) {
		var_invalid_password = rt.call_function('apply_filters', [
			rt.new_string('the_password_form_incorrect_password'),
			rt.call_function('__', [rt.new_string('Invalid password.')]),
			rt.new_int(var_post),
		])
		var_invalid_password_html = rt.new_string(
			'<div class="post-password-form-invalid-password" role="alert"><p id="error-' +
			var_field_id.str() + '">' + var_invalid_password.str() + '</p></div>')
		var_aria = rt.new_string(' aria-describedby="error-' + var_field_id.str() + '"')
		var_class = ' password-form-error'
	}
	if !(!rt.is_true(rt.get_property(rt.new_int(var_post), 'ID'))) {
		var_redirect_field = rt.call_function('sprintf', [
			rt.new_string('<input type="hidden" name="redirect_to" value="%s" />'),
			rt.call_function('esc_attr', [
				rt.call_function('get_permalink', [
					rt.get_property(rt.new_int(var_post), 'ID'),
				]),
			]),
		])
	}
	var_output = rt.new_string('<form action="' +
		(rt.call_function('esc_url', [rt.call_function('site_url', [rt.new_string('wp-login.php?action=postpass'), rt.new_string('login_post')])])).str() +
		'" class="post-password-form' + var_class + '" method="post">' + var_redirect_field.str() +
		var_invalid_password_html.str() + '\n\t<p>' +
		(rt.call_function('__', [rt.new_string('This content is password-protected. To view it, please enter the password below.')])).str() +
		'</p>\n\t<p><label for="' + var_field_id.str() + '">' +
		(rt.call_function('__', [rt.new_string('Password:')])).str() +
		' <input name="post_password" id="' + var_field_id.str() +
		'" type="password" spellcheck="false" required size="20"' + var_aria.str() +
		' /></label> <input type="submit" name="Submit" value="' +
		(rt.call_function('esc_attr_x', [rt.new_string('Enter'), rt.new_string('post password form')])).str() +
		'" /></p></form>\n\t')
	return rt.call_function('apply_filters', [rt.new_string('the_password_form'),
		var_output.clone(), rt.new_int(var_post), var_invalid_password.clone()])
}

fn is_page_template(template string) bool {
	mut var_template := template
	mut var_page_template := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_singular', []rt.PhpVal{}))))) {
		return false
	}
	var_page_template = get_page_template_slug(rt.call_function('get_queried_object_id',
		[]rt.PhpVal{}))
	if template == '' {
		return var_page_template.to_bool()
	}
	if rt.is_true(rt.identical(rt.new_string(template), var_page_template)) {
		return true
	}
	if rt.is_true(rt.new_bool(rt.new_string(template).is_array())) {
		if (rt.is_true(rt.call_function('in_array', [rt.new_string('default'), rt.new_string(template), rt.new_bool(true)]))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_page_template)))))
			|| rt.is_true(rt.call_function('in_array', [var_page_template.clone(), rt.new_string(template), rt.new_bool(true)])) {
			return true
		}
	}
	return rt.is_true(rt.identical(rt.new_string('default'), rt.new_string(template)))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_page_template))))
}

fn get_page_template_slug(var_post_arg rt.PhpVal) rt.PhpVal {
	mut var_post := var_post_arg
	mut var_template := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return rt.new_bool(false)
	}
	var_template = rt.call_function('get_post_meta', [rt.get_property(var_post, 'ID'),
		rt.new_string('_wp_page_template'), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_template))))
		|| rt.is_true(rt.identical(rt.new_string('default'), var_template)) {
		return rt.new_string('')
	}
	return var_template.clone()
}

fn wp_post_revision_title(var_revision_arg rt.PhpVal, link bool) bool {
	mut var_link := link
	mut var_revision := var_revision_arg
	mut var_datef := rt.new_null()
	mut var_autosavef := rt.new_null()
	mut var_currentf := rt.new_null()
	mut var_date := rt.new_null()
	mut var_edit_link := rt.new_null()
	var_revision = rt.call_function('get_post', [var_revision.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_revision)))) {
		return var_revision.to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.get_property(var_revision, 'post_type'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'post' },
			rt.ArrayItem{ key: none, val: 'page' }, rt.ArrayItem{ key: none, val: 'revision' }]),
		rt.new_bool(true),
	])))))
	{
		return false
	}
	var_datef = rt.call_function('_x', [rt.new_string('F j, Y @ H:i:s'),
		rt.new_string('revision date format')])
	var_autosavef = rt.call_function('__', [rt.new_string('%s [Autosave]')])
	var_currentf = rt.call_function('__', [rt.new_string('%s [Current Revision]')])
	var_date = rt.call_function('date_i18n', [var_datef.clone(),
		rt.call_function('strtotime', [rt.get_property(var_revision, 'post_modified')])])
	var_edit_link = rt.call_function('get_edit_post_link', [
		rt.get_property(var_revision, 'ID'),
	])
	if var_link
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.get_property(var_revision, 'ID')]))
		&& rt.is_true(var_edit_link) {
		var_date =
			rt.new_string("<a href='${var_edit_link.to_string()}'>${var_date.to_string()}</a>")
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_post_revision', [
		var_revision.clone(),
	])))))
	{
		var_date = rt.call_function('sprintf', [var_currentf.clone(),
			var_date.clone()])
	} else if rt.is_true(rt.call_function('wp_is_post_autosave', [
		var_revision.clone()]))
	{
		var_date = rt.call_function('sprintf', [var_autosavef.clone(),
			var_date.clone()])
	}
	return var_date.to_bool()
}

fn wp_post_revision_title_expanded(var_revision_arg rt.PhpVal, link bool) bool {
	mut var_link := link
	mut var_revision := var_revision_arg
	mut var_author := rt.new_null()
	mut var_datef := rt.new_null()
	mut var_gravatar := rt.new_null()
	mut var_date := rt.new_null()
	mut var_edit_link := rt.new_null()
	mut var_revision_date_author := rt.new_null()
	mut var_autosavef := rt.new_null()
	mut var_currentf := rt.new_null()
	var_revision = rt.call_function('get_post', [var_revision.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_revision)))) {
		return var_revision.to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.get_property(var_revision, 'post_type'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'post' },
			rt.ArrayItem{ key: none, val: 'page' }, rt.ArrayItem{ key: none, val: 'revision' }]),
		rt.new_bool(true),
	])))))
	{
		return false
	}
	var_author = rt.call_function('get_the_author_meta', [rt.new_string('display_name'),
		rt.get_property(var_revision, 'post_author')])
	var_datef = rt.call_function('_x', [rt.new_string('F j, Y @ H:i:s'),
		rt.new_string('revision date format')])
	var_gravatar = rt.call_function('get_avatar', [
		rt.get_property(var_revision, 'post_author'),
		rt.new_int(24),
	])
	var_date = rt.call_function('date_i18n', [var_datef.clone(),
		rt.call_function('strtotime', [rt.get_property(var_revision, 'post_modified')])])
	var_edit_link = rt.call_function('get_edit_post_link', [
		rt.get_property(var_revision, 'ID'),
	])
	if var_link
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.get_property(var_revision, 'ID')]))
		&& rt.is_true(var_edit_link) {
		var_date =
			rt.new_string("<a href='${var_edit_link.to_string()}'>${var_date.to_string()}</a>")
	}
	var_revision_date_author = rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('%1$s %2$s, %3$s ago (%4$s)')]),
		var_gravatar.clone(),
		var_author.clone(),
		rt.call_function('human_time_diff', [
			rt.call_function('strtotime', [
				rt.get_property(var_revision, 'post_modified_gmt'),
			]),
		]),
		var_date.clone(),
	])
	var_autosavef = rt.call_function('__', [rt.new_string('%s [Autosave]')])
	var_currentf = rt.call_function('__', [rt.new_string('%s [Current Revision]')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_post_revision', [
		var_revision.clone(),
	])))))
	{
		var_revision_date_author = rt.call_function('sprintf', [
			var_currentf.clone(), var_revision_date_author.clone()])
	} else if rt.is_true(rt.call_function('wp_is_post_autosave', [
		var_revision.clone()]))
	{
		var_revision_date_author = rt.call_function('sprintf', [
			var_autosavef.clone(), var_revision_date_author.clone()])
	}
	return (rt.call_function('apply_filters', [
		rt.new_string('wp_post_revision_title_expanded'),
		var_revision_date_author.clone(),
		var_revision.clone(),
		rt.new_bool(link),
	])).to_bool()
}

fn wp_list_post_revisions(post i64, type string) {
	mut var_post := post
	mut var_type := type
	mut var_revisions := rt.new_null()
	mut var_rows := ''
	mut var_revision := rt.new_null()
	mut var_is_autosave := rt.new_null()
	var_post = (rt.call_function('get_post', [rt.new_int(var_post)])).to_i64()
	if !(var_post != 0) {
		return
	}
	if rt.is_true(rt.new_bool(rt.new_string(var_type.str()).is_array())) {
		var_type = (if !(!rt.is_true(rt.new_string(var_type.str()).array_get(rt.new_string('type')))) {
			rt.new_string(var_type.str()).array_get(rt.new_string('type'))
		} else {
			rt.new_string(var_type.str())
		}).str()
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('3.6.0')])
	}
	var_revisions = rt.call_function('wp_get_post_revisions', [
		rt.get_property(rt.new_int(var_post), 'ID'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_revisions)))) {
		return
	}
	var_rows = ''
	mut iter_7 := var_revisions.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_revision_shadow := item_7.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('read_post'),
			rt.get_property(var_revision_shadow, 'ID'),
		])))))
		{
			continue
		}
		var_is_autosave = rt.call_function('wp_is_post_autosave', [
			var_revision_shadow.clone()])
		if (rt.is_true(rt.identical(rt.new_string('revision'), rt.new_string(var_type.str())))
			&& rt.is_true(var_is_autosave))
			|| (rt.is_true(rt.identical(rt.new_string('autosave'), rt.new_string(var_type.str())))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_is_autosave))))) {
			continue
		}
		var_rows = var_rows + '\t<li>' +
			wp_post_revision_title_expanded(var_revision_shadow.clone()).str() + '</li>\n'
	}
	print("<div class='hide-if-js'><p>" +
		(rt.call_function('__', [rt.new_string('JavaScript must be enabled to use this feature.')])).str() +
		'</p></div>\n')
	print("<ul class='post-revisions hide-if-no-js'>\n")
	print(var_rows)
	print('</ul>')
}

fn get_post_parent(var_post rt.PhpVal) rt.PhpVal {
	mut var_wp_post := rt.new_null()
	var_wp_post = rt.call_function('get_post', [var_post.clone()])
	return if !(!rt.is_true(rt.get_property(var_wp_post, 'post_parent'))) { rt.call_function('get_post', [
			rt.get_property(var_wp_post, 'post_parent'),
		]) } else { rt.new_null() }
}

fn has_post_parent(var_post rt.PhpVal) bool {
	return (get_post_parent(var_post.clone())).to_bool()
}

struct Class_PasswordHash {
	rt.PhpObjectBase
}

struct Class_Walker_Page {
	rt.PhpObjectBase
}

struct Class_Walker_PageDropdown {
	rt.PhpObjectBase
}

fn create_passwordhash(_args ...rt.PhpVal) &Class_PasswordHash {
	mut obj := &Class_PasswordHash{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_walker_page(_args ...rt.PhpVal) &Class_Walker_Page {
	mut obj := &Class_Walker_Page{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_walker_pagedropdown(_args ...rt.PhpVal) &Class_Walker_PageDropdown {
	mut obj := &Class_Walker_PageDropdown{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_PasswordHash) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_PasswordHash) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_PasswordHash) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Walker_Page) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Walker_Page) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Walker_Page) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Walker_PageDropdown) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Walker_PageDropdown) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Walker_PageDropdown) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
