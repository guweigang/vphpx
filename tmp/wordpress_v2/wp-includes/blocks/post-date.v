import rt

fn render_block_core_post_date(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_classes := []rt.PhpVal{}
	mut var_source := rt.new_null()
	mut var_source_args := map[string]rt.PhpVal{}
	mut var_unformatted_date := rt.new_null()
	mut var_post_timestamp := rt.new_null()
	mut var_formatted_date := rt.new_null()
	mut var_format := rt.new_null()
	mut var_wrapper_attributes := rt.new_null()
	mut var_time_tag := rt.new_null()
	var_classes = []rt.PhpVal{}
	if !(var_attributes.array_isset(rt.new_string('datetime')))
		&& !(var_attributes.array_get(rt.new_string('metadata')).array_get(rt.new_string('bindings')).array_get(rt.new_string('datetime')).array_isset(rt.new_string('source'))
		&& var_attributes.array_get(rt.new_string('metadata')).array_get(rt.new_string('bindings')).array_get(rt.new_string('datetime')).array_isset(rt.new_string('args'))) {
		var_source = rt.call_function('get_block_bindings_source', [
			rt.new_string('core/post-data'),
		])
		if var_attributes.array_isset(rt.new_string('displayType'))
			&& rt.is_true(rt.identical(rt.new_string('modified'), var_attributes.array_get(rt.new_string('displayType')))) {
			var_source_args = {
				'field': 'modified'
			}
		} else {
			var_source_args = {
				'field': 'date'
			}
		}
		var_attributes['datetime'] = rt.call_method(var_source, 'get_value', [
			rt.create_array_from_native_map(var_source_args),
			var_block.clone(),
			rt.new_string('datetime'),
		])
	}
	if var_source_args.array_isset(rt.new_string('field'))
		&& rt.is_true(rt.identical(rt.new_string('modified'), rt.new_string((var_source_args['field']).str()))) {
		var_classes << 'wp-block-post-date__modified-date'
	}
	if !rt.is_true(var_attributes.array_get(rt.new_string('datetime'))) {
		return ''
	}
	var_unformatted_date = var_attributes.array_get(rt.new_string('datetime'))
	var_post_timestamp = rt.call_function('strtotime', [var_unformatted_date.clone()])
	if var_attributes.array_isset(rt.new_string('format'))
		&& rt.is_true(rt.identical(rt.new_string('human-diff'), var_attributes.array_get(rt.new_string('format')))) {
		if rt.is_true(rt.greater(var_post_timestamp, rt.call_function('time', []rt.PhpVal{}))) {
			var_formatted_date = rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('%s from now')]),
				rt.call_function('human_time_diff', [var_post_timestamp.clone()]),
			])
		} else {
			var_formatted_date = rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('%s ago')]),
				rt.call_function('human_time_diff', [var_post_timestamp.clone()]),
			])
		}
	} else {
		var_format = if !rt.is_true(var_attributes.array_get(rt.new_string('format'))) { rt.call_function('get_option', [
				rt.new_string('date_format'),
			]) } else { var_attributes.array_get(rt.new_string('format')) }
		var_formatted_date = rt.call_function('wp_date', [var_format.clone(),
			var_post_timestamp.clone()])
	}
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
	var_time_tag = rt.call_function('sprintf', [
		rt.new_string('<time datetime="%1$s">%2$s</time>'),
		var_unformatted_date.clone(),
		var_formatted_date.clone(),
	])
	if var_attributes.array_isset(rt.new_string('isLink'))
		&& rt.is_true(var_attributes.array_get(rt.new_string('isLink')))
		&& rt.get_property(var_block, 'context').array_isset(rt.new_string('postId')) {
		var_time_tag = rt.call_function('sprintf', [
			rt.new_string('<a href="%1s">%2s</a>'),
			rt.call_function('get_the_permalink',
				[rt.get_property(var_block, 'context').array_get(rt.new_string('postId'))]),
			var_time_tag.clone(),
		])
	}
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
		var_wrapper_attributes.clone(), var_time_tag.clone()])).str()
}

fn register_block_core_post_date() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/post-date'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_post_date' },
		]),
	])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_post_date')])
}
