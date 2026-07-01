import rt

fn render_block_core_site_tagline(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_site_tagline := rt.call_function('get_bloginfo', [rt.new_string('description')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_site_tagline)))) {
		return rt.new_null()
	}
	mut var_tag_name := rt.new_string(rt.new_string('p'))
	mut var_align_class_name := if !rt.is_true(var_attributes.array_get('textAlign')) { '' } else { rt.concat(rt.new_string('has-text-align-'), var_attributes.array_get('textAlign')) }
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [rt.create_array([rt.ArrayItem{ key: 'class', val: var_align_class_name }])])
	if rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('level')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_tag_name = rt.new_string('h' + (// unsupported expression: Expr_Cast_Int).str())
	}
	return rt.call_function('sprintf', [rt.new_string('<%1$s %2$s>%3$s</%1$s>'), var_tag_name.dup(), var_wrapper_attributes.dup(), var_site_tagline.dup()])
}

fn register_block_core_site_tagline() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/site-tagline', rt.create_array([rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_site_tagline' }])])
}



pub fn init_wp_includes_blocks_site_tagline_php() {
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('register_block_core_site_tagline')])
}
