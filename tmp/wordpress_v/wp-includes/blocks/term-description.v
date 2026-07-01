import rt

fn render_block_core_term_description(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_term_description := rt.new_string(rt.new_string(''))
	if rt.get_property(var_block, 'context').array_isset(rt.new_string('termId'))
		&& rt.get_property(var_block, 'context').array_isset(rt.new_string('taxonomy')) {
		mut var_term := rt.call_function('get_term', [rt.get_property(var_block, 'context').array_get('termId'),
			rt.get_property(var_block, 'context').array_get('taxonomy')])
		if rt.is_true(rt.new_bool(rt.is_true(var_term)
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term.dup()])))))))
		{
			var_term_description = rt.get_property(var_term, 'description')
		}
	} else if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_category', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('is_tag', []rt.PhpVal{}))))
		|| rt.is_true(rt.call_function('is_tax', []rt.PhpVal{}))))
	{
		var_term_description = rt.call_function('term_description', []rt.PhpVal{})
	}
	if !rt.is_true(var_term_description) {
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
	return '<div ' + var_wrapper_attributes.str() + '>' + var_term_description.str() + '</div>'
}

fn register_block_core_term_description() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/term-description',
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_term_description' },
		])])
}

pub fn init_wp_includes_blocks_term_description_php() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_term_description')])
}
