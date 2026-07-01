import rt

fn render_block_core_comment_reply_link(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('commentId'))) {
		return ''
	}
	mut var_thread_comments := rt.call_function('get_option', [
		rt.new_string('thread_comments'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_thread_comments)))) {
		return ''
	}
	mut var_comment := rt.call_function('get_comment',
		[rt.get_property(var_block, 'context').array_get('commentId')])
	if !rt.is_true(var_comment) {
		return ''
	}
	mut var_depth := 1
	mut var_max_depth := rt.call_function('get_option', [
		rt.new_string('thread_comments_depth'),
	])
	mut var_parent_id := rt.get_property(var_comment, 'comment_parent')
	for !(!rt.is_true(var_parent_id)) {
		var_depth += 1
		var_parent_id = rt.get_property(rt.call_function('get_comment', [
			var_parent_id.dup()]), 'comment_parent')
	}
	mut var_comment_reply_link := rt.call_function('get_comment_reply_link', [
		rt.create_array([rt.ArrayItem{ key: 'depth', val: var_depth },
			rt.ArrayItem{ key: 'max_depth', val: var_max_depth }]),
		var_comment.dup(),
	])
	if !rt.is_true(var_comment_reply_link) {
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
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
		var_wrapper_attributes.dup(), var_comment_reply_link.dup()])).str()
}

fn register_block_core_comment_reply_link() {
	rt.call_function('register_block_type_from_metadata', [
		@DIR + '/comment-reply-link',
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_comment_reply_link' },
		]),
	])
}

pub fn init_wp_includes_blocks_comment_reply_link_php() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_comment_reply_link')])
}
