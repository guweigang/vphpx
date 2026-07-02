import rt

fn render_block_core_comment_author_name(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_comment := rt.new_null()
	mut var_commenter := rt.new_null()
	mut var_show_pending_links := false
	mut var_classes := []rt.PhpVal{}
	mut var_wrapper_attributes := rt.new_null()
	mut var_comment_author := rt.new_null()
	mut var_link := rt.new_null()
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('commentId'))) {
		return ''
	}
	var_comment = rt.call_function('get_comment', [
		rt.get_property(var_block, 'context').array_get(rt.new_string('commentId')),
	])
	var_commenter = rt.call_function('wp_get_current_commenter', []rt.PhpVal{})
	var_show_pending_links = var_commenter.array_isset(rt.new_string('comment_author'))
		&& rt.is_true(var_commenter.array_get(rt.new_string('comment_author')))
	if !rt.is_true(var_comment) {
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
	var_comment_author = rt.call_function('get_comment_author', [
		var_comment.clone()])
	var_link = rt.call_function('get_comment_author_url', [var_comment.clone()])
	if !(!rt.is_true(var_link)) && !(!rt.is_true(var_attributes.array_get(rt.new_string('isLink'))))
		&& !(!rt.is_true(var_attributes.array_get(rt.new_string('linkTarget')))) {
		var_comment_author = rt.call_function('sprintf', [
			rt.new_string('<a rel="external nofollow ugc" href="%1s" target="%2s" >%3s</a>'),
			rt.call_function('esc_url', [var_link.clone()]),
			rt.call_function('esc_attr', [var_attributes.array_get(rt.new_string('linkTarget'))]),
			var_comment_author.clone(),
		])
	}
	if rt.is_true(rt.identical(rt.new_string('0'), rt.get_property(var_comment, 'comment_approved')))
		&& !var_show_pending_links {
		var_comment_author = rt.call_function('wp_kses', [var_comment_author.clone(),
			[]rt.PhpVal{}])
	}
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
		var_wrapper_attributes.clone(), var_comment_author.clone()])).str()
}

fn register_block_core_comment_author_name() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/comment-author-name'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_comment_author_name' },
		]),
	])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_comment_author_name')])
}
