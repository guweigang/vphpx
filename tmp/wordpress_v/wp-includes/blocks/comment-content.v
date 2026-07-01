import rt

fn render_block_core_comment_content(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
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
	mut var_args := rt.new_array()
	mut var_comment_text := rt.call_function('get_comment_text', [
		var_comment.dup(), var_args.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_comment_text)))) {
		return ''
	}
	var_comment_text = rt.call_function('apply_filters', [rt.new_string('comment_text'),
		var_comment_text.dup(), var_comment.dup(), var_args.dup()])
	mut var_moderation_note := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.identical(rt.new_string('0'), rt.get_property(var_comment, 'comment_approved'))) {
		var_commenter = rt.call_function('wp_get_current_commenter', []rt.PhpVal{})
		if rt.is_true(var_commenter.array_get('comment_author_email')) {
			var_moderation_note = rt.call_function('__', [
				rt.new_string('Your comment is awaiting moderation.'),
			])
		} else {
			var_moderation_note = rt.call_function('__', [
				rt.new_string('Your comment is awaiting moderation. This is a preview; your comment will be visible after it has been approved.'),
			])
		}
		var_moderation_note = rt.new_string('<p><em class="comment-awaiting-moderation">' +
			var_moderation_note.str() + '</em></p>')
		if !var_show_pending_links {
			var_comment_text = rt.call_function('wp_kses', [var_comment_text.dup(),
				rt.new_array()])
		}
	}
	mut var_classes := rt.new_array()
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
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s%3$s</div>'),
		var_wrapper_attributes.dup(), var_moderation_note.dup(),
		var_comment_text.dup()])).str()
}

fn register_block_core_comment_content() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/comment-content',
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_comment_content' },
		])])
}

pub fn init_wp_includes_blocks_comment_content_php() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_comment_content')])
}
