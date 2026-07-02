import rt

fn render_block_core_comment_edit_link(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_edit_comment_link := rt.new_null()
	mut var_link_atts := ''
	mut var_classes := []rt.PhpVal{}
	mut var_wrapper_attributes := rt.new_null()
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('commentId')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_comment'), rt.get_property(var_block, 'context').array_get(rt.new_string('commentId'))]))))) {
		return ''
	}
	var_edit_comment_link = rt.call_function('get_edit_comment_link', [
		rt.get_property(var_block, 'context').array_get(rt.new_string('commentId')),
	])
	var_link_atts = ''
	if !(!rt.is_true(var_attributes.array_get(rt.new_string('linkTarget')))) {
		var_link_atts = var_link_atts +(rt.call_function('sprintf', [rt.new_string('target="%s"'), rt.call_function('esc_attr', [var_attributes.array_get(rt.new_string('linkTarget'))])])).str()
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
	return (rt.call_function('sprintf', [
		rt.new_string('<div %1$s><a href="%2$s" %3$s>%4$s</a></div>'),
		var_wrapper_attributes.clone(),
		rt.call_function('esc_url', [var_edit_comment_link.clone()]),
		rt.new_string(var_link_atts.str()).clone(),
		rt.call_function('esc_html__', [rt.new_string('Edit')]),
	])).str()
}

fn register_block_core_comment_edit_link() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/comment-edit-link'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_comment_edit_link' },
		]),
	])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_comment_edit_link')])
}
