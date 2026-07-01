import rt

fn render_block_core_comment_author_name(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('commentId'))) {
		return ''
	}
	mut var_comment := rt.call_function('get_comment',
		[rt.get_property(var_block, 'context').array_get('commentId')])
	mut var_commenter := rt.call_function('wp_get_current_commenter', []rt.PhpVal{})
	mut var_show_pending_links := var_commenter.array_isset(rt.new_string('comment_author'))
		&& rt.is_true(var_commenter.array_get('comment_author'))
	if !rt.is_true(var_comment) {
		return ''
	}
	mut var_classes := []rt.PhpVal{}
	if var_attributes.array_isset(rt.new_string('textAlign')) {
		var_classes << 'has-text-align-' + (var_attributes.array_get('textAlign')).str()
	}
	if var_attributes.array_get('style').array_get('elements').array_get('link').array_get('color').array_isset(rt.new_string('text')) {
		var_classes << 'has-link-color'
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'class', val: rt.call_function('implode', [
				rt.new_string(' '),
				var_classes.dup(),
			]) },
		]),
	])
	mut var_comment_author := rt.call_function('get_comment_author', [
		var_comment.dup()])
	mut var_link := rt.call_function('get_comment_author_url', [
		var_comment.dup()])
	if !(!rt.is_true(var_link)) && !(!rt.is_true(var_attributes.array_get('isLink')))
		&& !(!rt.is_true(var_attributes.array_get('linkTarget'))) {
		var_comment_author = rt.call_function('sprintf', [
			rt.new_string('<a rel="external nofollow ugc" href="%1s" target="%2s" >%3s</a>'),
			rt.call_function('esc_url', [var_link.dup()]),
			rt.call_function('esc_attr', [var_attributes.array_get('linkTarget')]),
			var_comment_author.dup(),
		])
	}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.identical(rt.new_string('0'), rt.get_property(var_comment, 'comment_approved')))
		&& !var_show_pending_links))
	{
		var_comment_author = rt.call_function('wp_kses', [var_comment_author.dup(),
			[]rt.PhpVal{}])
	}
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
		var_wrapper_attributes.dup(), var_comment_author.dup()])).str()
}

fn register_block_core_comment_author_name() {
	rt.call_function('register_block_type_from_metadata', [
		@DIR + '/comment-author-name',
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_comment_author_name' },
		]),
	])
}

pub fn init_wp_includes_blocks_comment_author_name_php() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_comment_author_name')])
}
