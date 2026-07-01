import rt

fn render_block_core_tag_cloud(var_attributes rt.PhpVal) string {
	mut var_m := rt.new_null()
	mut var_smallest_font_size := var_attributes.array_get('smallestFontSize')
	mut var_unit := if rt.is_true(rt.call_function('preg_match', [
		rt.new_string('/^[0-9.]+(?P<unit>[a-z%]+)$/i'),
		var_smallest_font_size.dup(),
		var_m.dup(),
	]))
	{ var_m.array_get('unit') } else { rt.new_string('pt') }
	mut var_args := {
		'echo':       rt.new_bool(false)
		'unit':       var_unit
		'taxonomy':   var_attributes['taxonomy']
		'show_count': var_attributes['showTagCounts']
		'number':     var_attributes['numberOfTags']
		'smallest':   rt.call_function('floatVal', [var_attributes.array_get('smallestFontSize')])
		'largest':    rt.call_function('floatVal', [var_attributes.array_get('largestFontSize')])
	}
	mut var_tag_cloud := rt.call_function('wp_tag_cloud', [var_args.dup()])
	if !rt.is_true(var_tag_cloud) {
		if rt.is_true(rt.call_function('wp_is_serving_rest_request', []rt.PhpVal{})) {
			var_tag_cloud = rt.call_function('__', [
				rt.new_string('There&#8217;s no content to show here yet.'),
			])
		} else {
			return ''
		}
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{})
	return (rt.call_function('sprintf', [rt.new_string('<p %1$s>%2$s</p>'),
		var_wrapper_attributes.dup(), var_tag_cloud.dup()])).str()
}

fn register_block_core_tag_cloud() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/tag-cloud',
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_tag_cloud' },
		])])
}

pub fn init_wp_includes_blocks_tag_cloud_php() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_tag_cloud')])
}
