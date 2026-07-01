import rt

fn render_block_core_comment_edit_link(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if rt.is_true(rt.new_bool(
		!(rt.get_property(var_block, 'context').array_isset(rt.new_string('commentId')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_comment'), rt.get_property(var_block, 'context').array_get('commentId')])))))))
	{
		return ''
	}
	mut var_edit_comment_link := rt.call_function('get_edit_comment_link', [
		rt.get_property(var_block, 'context').array_get('commentId'),
	])
	mut var_link_atts := ''
	if !(!rt.is_true(var_attributes.array_get('linkTarget'))) {
		// unsupported expression: Expr_AssignOp_Concat
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
	return (rt.call_function('sprintf', [
		rt.new_string('<div %1$s><a href="%2$s" %3$s>%4$s</a></div>'),
		var_wrapper_attributes.dup(),
		rt.call_function('esc_url', [var_edit_comment_link.dup()]),
		rt.new_string(var_link_atts).dup(),
		rt.call_function('esc_html__', [rt.new_string('Edit')]),
	])).str()
}

fn register_block_core_comment_edit_link() {
	rt.call_function('register_block_type_from_metadata', [
		@DIR + '/comment-edit-link',
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_comment_edit_link' },
		]),
	])
}

pub fn init_wp_includes_blocks_comment_edit_link_php() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_comment_edit_link')])
}
