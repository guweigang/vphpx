import rt

fn render_block_core_site_tagline(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_site_tagline := rt.new_null()
	mut var_tag_name := rt.new_null()
	mut var_align_class_name := ''
	mut var_wrapper_attributes := rt.new_null()
	var_site_tagline = rt.call_function('get_bloginfo', [rt.new_string('description')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_site_tagline)))) {
		return rt.new_null()
	}
	var_tag_name = rt.new_string('p')
	var_align_class_name = if !rt.is_true(var_attributes.array_get(rt.new_string('textAlign'))) {
		''
	} else {
		rt.concat(rt.new_string('has-text-align-'),
			var_attributes.array_get(rt.new_string('textAlign')))
	}
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([rt.ArrayItem{ key: 'class', val: var_align_class_name }]),
	])
	if var_attributes.array_isset(rt.new_string('level'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_attributes.array_get(rt.new_string('level')))))) {
		var_tag_name = rt.new_string('h' +
			rt.new_int((var_attributes.array_get(rt.new_string('level'))).to_i64()).str())
	}
	return rt.call_function('sprintf', [rt.new_string('<%1$s %2$s>%3$s</%1$s>'),
		var_tag_name.clone(), var_wrapper_attributes.clone(),
		var_site_tagline.clone()])
}

fn register_block_core_site_tagline() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/site-tagline'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_site_tagline' },
		]),
	])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_site_tagline')])
}
