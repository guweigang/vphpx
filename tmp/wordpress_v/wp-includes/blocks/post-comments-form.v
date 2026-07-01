import rt

fn render_block_core_post_comments_form(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('postId'))) {
		return ''
	}
	if rt.is_true(rt.call_function('post_password_required', [
		rt.get_property(var_block, 'context').array_get('postId')]))
	{
		return ''
	}
	mut var_classes := ['comment-respond']
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
	rt.call_function('add_filter', [rt.new_string('comment_form_defaults'),
		rt.new_string('post_comments_form_block_form_defaults')])
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('comment_form',
		[rt.new_array(), rt.get_property(var_block, 'context').array_get('postId')])
	mut var_form := rt.call_function('ob_get_clean', []rt.PhpVal{})
	rt.call_function('remove_filter', [rt.new_string('comment_form_defaults'),
		rt.new_string('post_comments_form_block_form_defaults')])
	var_form = rt.call_function('str_replace', [rt.new_string('class="comment-respond"'),
		var_wrapper_attributes.dup(), var_form.dup()])
	rt.call_function('wp_enqueue_script', [rt.new_string('comment-reply')])
	return var_form.str()
}

fn register_block_core_post_comments_form() {
	rt.call_function('register_block_type_from_metadata', [
		@DIR + '/post-comments-form',
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_post_comments_form' },
		]),
	])
}

fn post_comments_form_block_form_defaults(var_fields rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) {
		var_fields['submit_button'] =
			'<input name="%1$s" type="submit" id="%2$s" class="wp-block-button__link ' +
			(rt.call_function('wp_theme_get_element_class_name', [rt.new_string('button')])).str() +
			'" value="%4$s" />'
		var_fields['submit_field'] = '<p class="form-submit wp-block-button">%1$s %2$s</p>'
	}
	return var_fields.dup()
}

pub fn init_wp_includes_blocks_post_comments_form_php() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_post_comments_form')])
}
