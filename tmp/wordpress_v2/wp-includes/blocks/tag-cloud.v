import rt

fn render_block_core_tag_cloud(var_attributes rt.PhpVal) string {
	mut var_m := rt.new_null()
	mut var_smallest_font_size := rt.new_null()
	mut var_unit := rt.new_null()
	mut var_args := map[string]rt.PhpVal{}
	mut var_tag_cloud := rt.new_null()
	mut var_wrapper_attributes := rt.new_null()
	var_smallest_font_size = var_attributes.array_get(rt.new_string('smallestFontSize'))
	var_unit = if rt.is_true(rt.call_function('preg_match', [
		rt.new_string('/^[0-9.]+(?P<unit>[a-z%]+)$/i'),
		var_smallest_font_size.clone(),
		var_m.clone(),
	]))
	{ var_m.array_get(rt.new_string('unit')) } else { rt.new_string('pt') }
	var_args = {
		'echo':       rt.new_bool(false)
		'unit':       var_unit
		'taxonomy':   var_attributes['taxonomy']
		'show_count': var_attributes['showTagCounts']
		'number':     var_attributes['numberOfTags']
		'smallest':   rt.call_function('floatVal', [
			var_attributes.array_get(rt.new_string('smallestFontSize')),
		])
		'largest':    rt.call_function('floatVal', [
			var_attributes.array_get(rt.new_string('largestFontSize')),
		])
	}
	var_tag_cloud = rt.call_function('wp_tag_cloud', [
		rt.create_array_from_native_map(var_args),
	])
	if !rt.is_true(var_tag_cloud) {
		if rt.is_true(rt.call_function('wp_is_serving_rest_request', []rt.PhpVal{})) {
			var_tag_cloud = rt.call_function('__', [
				rt.new_string('There&#8217;s no content to show here yet.'),
			])
		} else {
			return ''
		}
	}
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{})
	return (rt.call_function('sprintf', [rt.new_string('<p %1$s>%2$s</p>'),
		var_wrapper_attributes.clone(), var_tag_cloud.clone()])).str()
}

fn register_block_core_tag_cloud() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/tag-cloud'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_tag_cloud' },
		]),
	])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_tag_cloud')])
}
