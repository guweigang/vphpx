import rt

fn render_block_core_comment_date(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('commentId'))) {
		return ''
	}
	mut var_comment := rt.call_function('get_comment',
		[rt.get_property(var_block, 'context').array_get('commentId')])
	if !rt.is_true(var_comment) {
		return ''
	}
	mut var_classes := if var_attributes.array_get('style').array_get('elements').array_get('link').array_get('color').array_isset(rt.new_string('text')) {
		'has-link-color'
	} else {
		''
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([rt.ArrayItem{ key: 'class', val: var_classes }]),
	])
	if rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('format'))
		&& rt.is_true(rt.identical(rt.new_string('human-diff'), var_attributes.array_get('format')))))
	{
		mut var_formatted_date := rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s ago')]),
			rt.call_function('human_time_diff', [
				rt.call_function('get_comment_date', [rt.new_string('U'),
					var_comment.dup()]),
			]),
		])
	} else {
		var_formatted_date = rt.call_function('get_comment_date', [if !rt.is_true(var_attributes.array_get('format')) {
			rt.new_string('')
		} else {
			var_attributes.array_get('format')
		}, var_comment.dup()])
	}
	mut var_link := rt.call_function('get_comment_link', [var_comment.dup()])
	if !(!rt.is_true(var_attributes.array_get('isLink'))) {
		var_formatted_date = rt.call_function('sprintf', [
			rt.new_string('<a href="%1s">%2s</a>'),
			rt.call_function('esc_url', [var_link.dup()]),
			var_formatted_date.dup(),
		])
	}
	return (rt.call_function('sprintf', [
		rt.new_string('<div %1$s><time datetime="%2$s">%3$s</time></div>'),
		var_wrapper_attributes.dup(),
		rt.call_function('esc_attr', [
			rt.call_function('get_comment_date', [rt.new_string('c'),
				var_comment.dup()]),
		]),
		var_formatted_date.dup(),
	])).str()
}

fn register_block_core_comment_date() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/comment-date',
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_comment_date' },
		])])
}

pub fn init_wp_includes_blocks_comment_date_php() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_comment_date')])
}
