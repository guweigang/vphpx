import rt

fn render_block_core_term_description(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_term_description := rt.new_null()
	mut var_term := rt.new_null()
	mut var_classes := []rt.PhpVal{}
	mut var_wrapper_attributes := rt.new_null()
	var_term_description = rt.new_string('')
	if rt.get_property(var_block, 'context').array_isset(rt.new_string('termId'))
		&& rt.get_property(var_block, 'context').array_isset(rt.new_string('taxonomy')) {
		var_term = rt.call_function('get_term', [rt.get_property(var_block, 'context').array_get(rt.new_string('termId')),
			rt.get_property(var_block, 'context').array_get(rt.new_string('taxonomy'))])
		if rt.is_true(var_term)
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term.clone()]))))) {
			var_term_description = rt.get_property(var_term, 'description')
		}
	} else if rt.is_true(rt.call_function('is_category', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('is_tag', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('is_tax', []rt.PhpVal{})) {
		var_term_description = rt.call_function('term_description', []rt.PhpVal{})
	}
	if !rt.is_true(var_term_description) {
		return ''
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
	return '<div ' + var_wrapper_attributes.str() + '>' + var_term_description.str() + '</div>'
}

fn register_block_core_term_description() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/term-description'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_term_description' },
		]),
	])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_term_description')])
}
