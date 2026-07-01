import rt

fn render_block_core_post_comments_count(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('postId'))) {
		return ''
	}
	mut var_classes := ''
	if var_attributes.array_isset(rt.new_string('textAlign')) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([rt.ArrayItem{ key: 'class', val: var_classes }]),
	])
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
		var_wrapper_attributes.dup(),
		rt.call_function('get_comments_number', [
			rt.get_property(var_block, 'context').array_get('postId'),
		])])).str()
}

fn register_block_core_post_comments_count() {
	rt.call_function('register_block_type_from_metadata', [
		@DIR + '/post-comments-count',
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_post_comments_count' },
		]),
	])
}

pub fn init_wp_includes_blocks_post_comments_count_php() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_post_comments_count')])
}
