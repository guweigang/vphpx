import rt

fn render_block_core_read_more(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('postId'))) {
		return ''
	}
	mut var_post_ID := rt.get_property(var_block, 'context').array_get('postId')
	mut var_post_title := rt.call_function('get_the_title', [
		var_post_ID.dup()])
	if rt.is_true(rt.identical(rt.new_string(''), var_post_title)) {
		var_post_title = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('untitled post %s')]),
			var_post_ID.dup(),
		])
	}
	mut var_screen_reader_text := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string(': %s')]),
		var_post_title.dup(),
	])
	mut var_justify_class_name := if !rt.is_true(var_attributes.array_get('justifyContent')) {
		''
	} else {
		rt.concat(rt.new_string('is-justified-'), var_attributes.array_get('justifyContent'))
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([rt.ArrayItem{ key: 'class', val: var_justify_class_name }]),
	])
	mut var_more_text := if !(!rt.is_true(var_attributes.array_get('content'))) { rt.call_function('wp_kses_post', [
			var_attributes.array_get('content'),
		]) } else { rt.call_function('__', [rt.new_string('Read more')]) }
	return (rt.call_function('sprintf', [
		rt.new_string('<a %1s href="%2s" target="%3s">%4s<span class="screen-reader-text">%5s</span></a>'),
		var_wrapper_attributes.dup(),
		rt.call_function('get_the_permalink', [var_post_ID.dup()]),
		rt.call_function('esc_attr', [var_attributes.array_get('linkTarget')]),
		var_more_text.dup(),
		var_screen_reader_text.dup(),
	])).str()
}

fn register_block_core_read_more() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/read-more',
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_read_more' },
		])])
}

pub fn init_wp_includes_blocks_read_more_php() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_read_more')])
}
