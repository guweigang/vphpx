import rt

fn render_block_core_term_name(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_term_name := rt.new_null()
	mut var_term := rt.new_null()
	mut var_level := rt.new_null()
	mut var_tag_name := rt.new_null()
	mut var_term_link := rt.new_null()
	mut var_classes := []rt.PhpVal{}
	mut var_wrapper_attributes := rt.new_null()
	var_term_name = rt.new_string('')
	if rt.get_property(var_block, 'context').array_isset(rt.new_string('termId'))
		&& rt.get_property(var_block, 'context').array_isset(rt.new_string('taxonomy')) {
		var_term = rt.call_function('get_term', [rt.get_property(var_block, 'context').array_get(rt.new_string('termId')),
			rt.get_property(var_block, 'context').array_get(rt.new_string('taxonomy'))])
	} else {
		var_term = rt.call_function('get_queried_object', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_term, 'WP_Term')))))) {
			var_term = rt.new_null()
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_term))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
		return ''
	}
	var_term_name = rt.get_property(var_term, 'name')
	var_level = if !(var_attributes.array_get(rt.new_string('level'))).is_null() {
		var_attributes.array_get(rt.new_string('level'))
	} else {
		rt.new_int(0)
	}
	var_tag_name = rt.new_string((if rt.is_true(rt.identical(rt.new_int(0), var_level)) {
		'p'
	} else {
		'h' + rt.new_int(var_level.to_i64()).str()
	}).str())
	if var_attributes.array_isset(rt.new_string('isLink'))
		&& rt.is_true(var_attributes.array_get(rt.new_string('isLink'))) {
		var_term_link = rt.call_function('get_term_link', [var_term.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
			var_term_link.clone(),
		])))))
		{
			var_term_name = rt.call_function('sprintf', [
				rt.new_string('<a href="%1$s">%2$s</a>'),
				rt.call_function('esc_url', [var_term_link.clone()]),
				var_term_name.clone(),
			])
		}
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
	return (rt.call_function('sprintf', [rt.new_string('<%1$s %2$s>%3$s</%1$s>'),
		var_tag_name.clone(), var_wrapper_attributes.clone(),
		var_term_name.clone()])).str()
}

fn register_block_core_term_name() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/term-name'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_term_name' },
		]),
	])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_term_name')])
}
