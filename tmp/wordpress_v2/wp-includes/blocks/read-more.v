import rt

fn render_block_core_read_more(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_post_ID := rt.new_null()
	mut var_post_title := rt.new_null()
	mut var_screen_reader_text := rt.new_null()
	mut var_justify_class_name := ''
	mut var_wrapper_attributes := rt.new_null()
	mut var_more_text := rt.new_null()
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('postId'))) {
		return ''
	}
	var_post_ID = rt.get_property(var_block, 'context').array_get(rt.new_string('postId'))
	var_post_title = rt.call_function('get_the_title', [var_post_ID.clone()])
	if rt.is_true(rt.identical(rt.new_string(''), var_post_title)) {
		var_post_title = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('untitled post %s')]),
			var_post_ID.clone(),
		])
	}
	var_screen_reader_text = rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string(': %s')]),
		var_post_title.clone(),
	])
	var_justify_class_name = if !rt.is_true(var_attributes.array_get(rt.new_string('justifyContent'))) {
		''
	} else {
		rt.concat(rt.new_string('is-justified-'),
			var_attributes.array_get(rt.new_string('justifyContent')))
	}
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([rt.ArrayItem{ key: 'class', val: var_justify_class_name }]),
	])
	var_more_text = if !(!rt.is_true(var_attributes.array_get(rt.new_string('content')))) { rt.call_function('wp_kses_post', [
			var_attributes.array_get(rt.new_string('content')),
		]) } else { rt.call_function('__', [rt.new_string('Read more')]) }
	return (rt.call_function('sprintf', [
		rt.new_string('<a %1s href="%2s" target="%3s">%4s<span class="screen-reader-text">%5s</span></a>'),
		var_wrapper_attributes.clone(),
		rt.call_function('get_the_permalink', [var_post_ID.clone()]),
		rt.call_function('esc_attr', [var_attributes.array_get(rt.new_string('linkTarget'))]),
		var_more_text.clone(),
		var_screen_reader_text.clone(),
	])).str()
}

fn register_block_core_read_more() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/read-more'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_read_more' },
		]),
	])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_read_more')])
}
