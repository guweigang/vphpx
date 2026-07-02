import rt

fn render_block_core_comment_date(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_comment := rt.new_null()
	mut var_classes := ''
	mut var_wrapper_attributes := rt.new_null()
	mut var_formatted_date := rt.new_null()
	mut var_link := rt.new_null()
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('commentId'))) {
		return ''
	}
	var_comment = rt.call_function('get_comment', [
		rt.get_property(var_block, 'context').array_get(rt.new_string('commentId')),
	])
	if !rt.is_true(var_comment) {
		return ''
	}
	var_classes = if var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('elements')).array_get(rt.new_string('link')).array_get(rt.new_string('color')).array_isset(rt.new_string('text')) {
		'has-link-color'
	} else {
		''
	}
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([rt.ArrayItem{ key: 'class', val: var_classes }]),
	])
	if var_attributes.array_isset(rt.new_string('format'))
		&& rt.is_true(rt.identical(rt.new_string('human-diff'), var_attributes.array_get(rt.new_string('format')))) {
		var_formatted_date = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s ago')]),
			rt.call_function('human_time_diff', [
				rt.call_function('get_comment_date', [rt.new_string('U'),
					var_comment.clone()]),
			]),
		])
	} else {
		var_formatted_date = rt.call_function('get_comment_date', [if !rt.is_true(var_attributes.array_get(rt.new_string('format'))) {
			rt.new_string('')
		} else {
			var_attributes.array_get(rt.new_string('format'))
		}, var_comment.clone()])
	}
	var_link = rt.call_function('get_comment_link', [var_comment.clone()])
	if !(!rt.is_true(var_attributes.array_get(rt.new_string('isLink')))) {
		var_formatted_date = rt.call_function('sprintf', [
			rt.new_string('<a href="%1s">%2s</a>'),
			rt.call_function('esc_url', [var_link.clone()]),
			var_formatted_date.clone(),
		])
	}
	return (rt.call_function('sprintf', [
		rt.new_string('<div %1$s><time datetime="%2$s">%3$s</time></div>'),
		var_wrapper_attributes.clone(),
		rt.call_function('esc_attr', [
			rt.call_function('get_comment_date', [rt.new_string('c'),
				var_comment.clone()]),
		]),
		var_formatted_date.clone(),
	])).str()
}

fn register_block_core_comment_date() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/comment-date'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_comment_date' },
		]),
	])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_comment_date')])
}
