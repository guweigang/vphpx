import rt

fn render_block_core_post_excerpt(var_attributes rt.PhpVal, var_content_arg rt.PhpVal, var_block rt.PhpVal) string {
	mut var_content := var_content_arg
	mut var_more_text := rt.new_null()
	mut var_filter_excerpt_more := rt.new_null()
	mut var_excerpt_length := rt.new_null()
	mut var_excerpt := rt.new_null()
	mut var_classes := []rt.PhpVal{}
	mut var_wrapper_attributes := rt.new_null()
	mut var_show_more_on_new_line := false
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('postId'))) {
		return ''
	}
	var_more_text = rt.new_string((if !(!rt.is_true(var_attributes.array_get(rt.new_string('moreText')))) {
		'<a class="wp-block-post-excerpt__more-link" href="' +
			(rt.call_function('esc_url', [rt.call_function('get_the_permalink', [rt.get_property(var_block, 'context').array_get(rt.new_string('postId'))])])).str() +
			'">' +
			(rt.call_function('wp_kses_post', [var_attributes.array_get(rt.new_string('moreText'))])).str() +
			'</a>'
	} else {
		''
	}).str())
	closure_1_fn := fn [var_more_text] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_more := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return (if !rt.is_true(var_more_text) {
			var_more
		} else {
			rt.new_string('')
		}).str()
	}
	var_filter_excerpt_more = rt.new_closure(closure_1_fn)
	rt.call_function('add_filter', [rt.new_string('excerpt_more'),
		var_filter_excerpt_more.clone()])
	var_excerpt_length = var_attributes.array_get(rt.new_string('excerptLength'))
	rt.call_function('add_filter', [rt.new_string('excerpt_length'),
		rt.new_string('block_core_post_excerpt_excerpt_length'),
		rt.get_constant('PHP_INT_MAX')])
	var_excerpt = rt.call_function('get_the_excerpt', [
		rt.get_property(var_block, 'context').array_get(rt.new_string('postId')),
	])
	rt.call_function('remove_filter', [rt.new_string('excerpt_length'),
		rt.new_string('block_core_post_excerpt_excerpt_length'),
		rt.get_constant('PHP_INT_MAX')])
	if !var_excerpt_length.is_null() {
		var_excerpt = rt.call_function('wp_trim_words', [var_excerpt.clone(),
			var_excerpt_length.clone()])
	}
	var_classes = []rt.PhpVal{}
	if var_attributes.array_isset(rt.new_string('textAlign')) {
		var_classes << 'has-text-align-' +
			(var_attributes.array_get(rt.new_string('textAlign'))).str()
	}
	if var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('elements')).array_get(rt.new_string('link')).array_get(rt.new_string('color')).array_isset(rt.new_string('text')) {
		var_classes << 'has-link-color'
	}
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'class', val: rt.call_function('implode', [
				rt.new_string(' '),
				rt.create_array_from_list(var_classes),
			]) },
		]),
	])
	var_content = rt.new_string('<p class="wp-block-post-excerpt__excerpt">' + var_excerpt.str())
	var_show_more_on_new_line = !(var_attributes.array_isset(rt.new_string('showMoreOnNewLine')))
		|| rt.is_true(var_attributes.array_get(rt.new_string('showMoreOnNewLine')))
	if var_show_more_on_new_line && !(!rt.is_true(var_more_text)) {
		var_content = rt.concat(var_content, rt.new_string(
			'</p><p class="wp-block-post-excerpt__more-text">' + var_more_text.str() + '</p>'))
	} else {
		var_content = rt.concat(var_content, rt.new_string(' ${var_more_text.to_string()}</p>'))
	}
	rt.call_function('remove_filter', [rt.new_string('excerpt_more'),
		var_filter_excerpt_more.clone()])
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
		var_wrapper_attributes.clone(), var_content.clone()])).str()
}

fn register_block_core_post_excerpt() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/post-excerpt'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_post_excerpt' },
		]),
	])
}

fn block_core_post_excerpt_excerpt_length() i64 {
	return 101
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_post_excerpt')])
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		rt.call_function('add_filter', [rt.new_string('excerpt_length'),
			rt.new_string('block_core_post_excerpt_excerpt_length'),
			rt.get_constant('PHP_INT_MAX')])
	}
}
