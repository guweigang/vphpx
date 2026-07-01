import rt

fn render_block_core_term_name(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_term_name := rt.new_string(rt.new_string(''))
	if rt.get_property(var_block, 'context').array_isset(rt.new_string('termId')) && rt.get_property(var_block, 'context').array_isset(rt.new_string('taxonomy')) {
		mut var_term := rt.call_function('get_term', [rt.get_property(var_block, 'context').array_get('termId'), rt.get_property(var_block, 'context').array_get('taxonomy')])
	} else {
		var_term = rt.call_function('get_queried_object', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_term, 'WP_Term')))))) {
			var_term = rt.new_null()
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_term)))) || rt.is_true(rt.call_function('is_wp_error', [var_term.dup()])))) {
		return ''
	}
	var_term_name = rt.get_property(var_term, 'name')
	mut var_level := if !(var_attributes.array_get('level')).is_null() { var_attributes.array_get('level') } else { rt.new_int(0) }
	mut var_tag_name := rt.new_string(if rt.is_true(rt.identical(rt.new_int(0), var_level)) { rt.new_string('p') } else { 'h' + (// unsupported expression: Expr_Cast_Int).str() })
	if rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('isLink')) && rt.is_true(var_attributes.array_get('isLink')))) {
		mut var_term_link := rt.call_function('get_term_link', [var_term.dup()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term_link.dup()]))))) {
			var_term_name = rt.call_function('sprintf', [rt.new_string('<a href="%1$s">%2$s</a>'), rt.call_function('esc_url', [var_term_link.dup()]), var_term_name.dup()])
		}
	}
	mut var_classes := []rt.PhpVal{}
	if var_attributes.array_isset(rt.new_string('textAlign')) {
		var_classes << 'has-text-align-' + (var_attributes.array_get('textAlign')).str()
	}
	if var_attributes.array_get('style').array_get('elements').array_get('link').array_get('color').array_isset(rt.new_string('text')) {
		var_classes << 'has-link-color'
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [rt.create_array([rt.ArrayItem{ key: 'class', val: rt.call_function('implode', [rt.new_string(' '), var_classes.dup()]) }])])
	return (rt.call_function('sprintf', [rt.new_string('<%1$s %2$s>%3$s</%1$s>'), var_tag_name.dup(), var_wrapper_attributes.dup(), var_term_name.dup()])).str()
}

fn register_block_core_term_name() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/term-name', rt.create_array([rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_term_name' }])])
}



pub fn init_wp_includes_blocks_term_name_php() {
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('register_block_core_term_name')])
}
