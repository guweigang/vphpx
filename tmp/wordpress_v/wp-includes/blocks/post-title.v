import rt

fn render_block_core_post_title(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('postId'))) {
		return ''
	}
	mut var_title := rt.call_function('get_the_title', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_title)))) {
		return ''
	}
	mut var_tag_name := rt.new_string(rt.new_string('h2'))
	if var_attributes.array_isset(rt.new_string('level')) {
		var_tag_name = rt.new_string(if rt.is_true(rt.identical(rt.new_int(0), var_attributes.array_get('level'))) { rt.new_string('p') } else { 'h' + (// unsupported expression: Expr_Cast_Int).str() })
	}
	if rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('isLink')) && rt.is_true(var_attributes.array_get('isLink')))) {
		mut var_rel := rt.new_string(if !(!rt.is_true(var_attributes.array_get('rel'))) { 'rel="' + (rt.call_function('esc_attr', [var_attributes.array_get('rel')])).str() + '"' } else { rt.new_string('') })
		var_title = rt.call_function('sprintf', [rt.new_string('<a href="%1$s" target="%2$s" %3$s>%4$s</a>'), rt.call_function('esc_url', [rt.call_function('get_the_permalink', [rt.get_property(var_block, 'context').array_get('postId')])]), rt.call_function('esc_attr', [var_attributes.array_get('linkTarget')]), var_rel.dup(), var_title.dup()])
	}
	mut var_classes := []rt.PhpVal{}
	if var_attributes.array_isset(rt.new_string('textAlign')) {
		var_classes << 'has-text-align-' + (var_attributes.array_get('textAlign')).str()
	}
	if var_attributes.array_get('style').array_get('elements').array_get('link').array_get('color').array_isset(rt.new_string('text')) {
		var_classes << 'has-link-color'
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [rt.create_array([rt.ArrayItem{ key: 'class', val: rt.call_function('implode', [rt.new_string(' '), var_classes.dup()]) }])])
	return (rt.call_function('sprintf', [rt.new_string('<%1$s %2$s>%3$s</%1$s>'), var_tag_name.dup(), var_wrapper_attributes.dup(), var_title.dup()])).str()
}

fn register_block_core_post_title() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/post-title', rt.create_array([rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_post_title' }])])
}



pub fn init_wp_includes_blocks_post_title_php() {
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('register_block_core_post_title')])
}
