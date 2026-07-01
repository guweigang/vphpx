import rt

fn render_block_core_post_content(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_seen_ids := rt.new_null()
	// unsupported statement: Stmt_Static
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('postId'))) {
		return ''
	}
	mut var_post_id := rt.get_property(var_block, 'context').array_get('postId')
	if var_seen_ids.array_isset(var_post_id) {
		mut var_is_debug := rt.is_true(rt.get_constant('WP_DEBUG'))
			&& rt.is_true(rt.get_constant('WP_DEBUG_DISPLAY'))
		return (if var_is_debug {
			rt.call_function('__', [rt.new_string('[block rendering halted]')])
		} else {
			rt.new_string('')
		}).str()
	}
	var_seen_ids.array_set(var_post_id, true)
	var_content = rt.call_function('get_the_content', []rt.PhpVal{})
	if rt.is_true(rt.call_function('has_block', [rt.new_string('core/nextpage')])) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	var_content = rt.call_function('apply_filters', [rt.new_string('the_content'),
		rt.call_function('str_replace', [rt.new_string(']]>'),
			rt.new_string(']]&gt;'), var_content.dup()])])
	var_seen_ids.array_unset(var_post_id)
	if !rt.is_true(var_content) {
		return ''
	}
	mut var_tag_name := rt.new_string(rt.new_string('div'))
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_attributes.array_get('tagName')))
		&& rt.is_true(rt.identical(rt.call_function('tag_escape', [var_attributes.array_get('tagName')]), var_attributes.array_get('tagName')))))
	{
		var_tag_name = var_attributes.array_get('tagName')
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([rt.ArrayItem{ key: 'class', val: 'entry-content' }]),
	])
	return (rt.call_function('sprintf', [rt.new_string('<%1$s %2$s>%3$s</%1$s>'),
		var_tag_name.dup(), var_wrapper_attributes.dup(), var_content.dup()])).str()
}

fn register_block_core_post_content() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/post-content',
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_post_content' },
		])])
}

pub fn init_wp_includes_blocks_post_content_php() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_post_content')])
}
