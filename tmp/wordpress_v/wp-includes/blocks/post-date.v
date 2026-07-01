import rt

fn render_block_core_post_date(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_classes := []rt.PhpVal{}
	if !(var_attributes.array_isset(rt.new_string('datetime')))
		&& !(var_attributes.array_get('metadata').array_get('bindings').array_get('datetime').array_isset(rt.new_string('source'))
		&& var_attributes.array_get('metadata').array_get('bindings').array_get('datetime').array_isset(rt.new_string('args'))) {
		mut var_source := rt.call_function('get_block_bindings_source', [
			rt.new_string('core/post-data'),
		])
		if rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('displayType'))
			&& rt.is_true(rt.identical(rt.new_string('modified'), var_attributes.array_get('displayType')))))
		{
			mut var_source_args := {
				'field': 'modified'
			}
		} else {
			var_source_args = {
				'field': 'date'
			}
		}
		var_attributes['datetime'] = rt.call_method(var_source, 'get_value', [
			var_source_args.dup(), var_block.dup(), rt.new_string('datetime')])
	}
	if rt.is_true(rt.new_bool(var_source_args.array_isset(rt.new_string('field'))
		&& rt.is_true(rt.identical(rt.new_string('modified'), var_source_args.array_get('field')))))
	{
		var_classes << 'wp-block-post-date__modified-date'
	}
	if !rt.is_true(var_attributes.array_get('datetime')) {
		return ''
	}
	mut var_unformatted_date := var_attributes.array_get('datetime')
	mut var_post_timestamp := rt.call_function('strtotime', [
		var_unformatted_date.dup()])
	if rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('format'))
		&& rt.is_true(rt.identical(rt.new_string('human-diff'), var_attributes.array_get('format')))))
	{
		if rt.is_true(rt.greater(var_post_timestamp, rt.call_function('time', []rt.PhpVal{}))) {
			mut var_formatted_date := rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('%s from now')]),
				rt.call_function('human_time_diff', [var_post_timestamp.dup()]),
			])
		} else {
			var_formatted_date = rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('%s ago')]),
				rt.call_function('human_time_diff', [var_post_timestamp.dup()]),
			])
		}
	} else {
		mut var_format := if !rt.is_true(var_attributes.array_get('format')) { rt.call_function('get_option', [
				rt.new_string('date_format'),
			]) } else { var_attributes.array_get('format') }
		var_formatted_date = rt.call_function('wp_date', [var_format.dup(),
			var_post_timestamp.dup()])
	}
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
	mut var_time_tag := rt.call_function('sprintf', [
		rt.new_string('<time datetime="%1$s">%2$s</time>'),
		var_unformatted_date.dup(),
		var_formatted_date.dup(),
	])
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('isLink'))
		&& rt.is_true(var_attributes.array_get('isLink'))))
		&& rt.get_property(var_block, 'context').array_isset(rt.new_string('postId'))))
	{
		var_time_tag = rt.call_function('sprintf', [
			rt.new_string('<a href="%1s">%2s</a>'),
			rt.call_function('get_the_permalink',
				[rt.get_property(var_block, 'context').array_get('postId')]),
			var_time_tag.dup(),
		])
	}
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
		var_wrapper_attributes.dup(), var_time_tag.dup()])).str()
}

fn register_block_core_post_date() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/post-date',
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_post_date' },
		])])
}

pub fn init_wp_includes_blocks_post_date_php() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_post_date')])
}
