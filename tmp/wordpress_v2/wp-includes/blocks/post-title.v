import rt

fn render_block_core_post_title(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_title := rt.new_null()
	mut var_tag_name := rt.new_null()
	mut var_rel := rt.new_null()
	mut var_classes := []rt.PhpVal{}
	mut var_wrapper_attributes := rt.new_null()
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('postId'))) {
		return ''
	}
	var_title = rt.call_function('get_the_title', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_title)))) {
		return ''
	}
	var_tag_name = rt.new_string('h2')
	if var_attributes.array_isset(rt.new_string('level')) {
		var_tag_name = rt.new_string((if rt.is_true(rt.identical(rt.new_int(0),
			var_attributes.array_get(rt.new_string('level'))))
		{
			'p'
		} else {
			'h' + rt.new_int((var_attributes.array_get(rt.new_string('level'))).to_i64()).str()
		}).str())
	}
	if var_attributes.array_isset(rt.new_string('isLink'))
		&& rt.is_true(var_attributes.array_get(rt.new_string('isLink'))) {
		var_rel = rt.new_string((if !(!rt.is_true(var_attributes.array_get(rt.new_string('rel')))) {
			'rel="' +
				(rt.call_function('esc_attr', [var_attributes.array_get(rt.new_string('rel'))])).str() +
				'"'
		} else {
			''
		}).str())
		var_title = rt.call_function('sprintf', [
			rt.new_string('<a href="%1$s" target="%2$s" %3$s>%4$s</a>'),
			rt.call_function('esc_url', [
				rt.call_function('get_the_permalink', [
					rt.get_property(var_block, 'context').array_get(rt.new_string('postId')),
				]),
			]),
			rt.call_function('esc_attr', [
				var_attributes.array_get(rt.new_string('linkTarget')),
			]),
			var_rel.clone(),
			var_title.clone(),
		])
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
		var_title.clone()])).str()
}

fn register_block_core_post_title() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/post-title'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_post_title' },
		]),
	])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_post_title')])
}
