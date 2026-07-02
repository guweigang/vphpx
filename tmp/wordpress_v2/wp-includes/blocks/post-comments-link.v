import rt

fn render_block_core_post_comments_link(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_classes := []rt.PhpVal{}
	mut var_wrapper_attributes := rt.new_null()
	mut var_comments_number := rt.new_null()
	mut var_comments_link := rt.new_null()
	mut var_post_title := rt.new_null()
	mut var_comment_html := rt.new_null()
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('postId')))
		|| (rt.get_property(var_block, 'context').array_isset(rt.new_string('postId'))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('comments_open', [rt.get_property(var_block, 'context').array_get(rt.new_string('postId'))])))))) {
		return ''
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
	var_comments_number = rt.new_int((rt.call_function('get_comments_number', [
		rt.get_property(var_block, 'context').array_get(rt.new_string('postId')),
	])).to_i64())
	var_comments_link = rt.call_function('get_comments_link', [
		rt.get_property(var_block, 'context').array_get(rt.new_string('postId')),
	])
	var_post_title = rt.call_function('get_the_title', [
		rt.get_property(var_block, 'context').array_get(rt.new_string('postId')),
	])
	var_comment_html = rt.new_string('')
	if rt.is_true(rt.identical(rt.new_int(0), var_comments_number)) {
		var_comment_html = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('No comments<span class="screen-reader-text"> on %s</span>'),
			]),
			var_post_title.clone(),
		])
	} else {
		var_comment_html = rt.call_function('sprintf', [
			rt.call_function('_n', [
				rt.new_string('%1$s comment<span class="screen-reader-text"> on %2$s</span>'),
				rt.new_string('%1$s comments<span class="screen-reader-text"> on %2$s</span>'),
				var_comments_number.clone(),
			]),
			rt.call_function('esc_html', [
				rt.call_function('number_format_i18n', [var_comments_number.clone()]),
			]),
			var_post_title.clone(),
		])
	}
	return '<div ' + var_wrapper_attributes.str() + '><a href=' +
		(rt.call_function('esc_url', [var_comments_link.clone()])).str() + '>' +
		var_comment_html.str() + '</a></div>'
}

fn register_block_core_post_comments_link() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/post-comments-link'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_post_comments_link' },
		]),
	])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_post_comments_link')])
}
