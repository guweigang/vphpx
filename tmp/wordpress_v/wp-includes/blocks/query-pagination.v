import rt

fn render_block_core_query_pagination(var_attributes rt.PhpVal, var_content rt.PhpVal) string {
	if var_content.dup().to_string().trim_space() == '' {
		return ''
	}
	mut var_classes := if var_attributes.array_get('style').array_get('elements').array_get('link').array_get('color').array_isset(rt.new_string('text')) {
		'has-link-color'
	} else {
		''
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'aria-label', val: rt.call_function('__', [
				rt.new_string('Pagination'),
			]) },
			rt.ArrayItem{ key: 'class', val: var_classes },
		]),
	])
	return (rt.call_function('sprintf', [rt.new_string('<nav %1$s>%2$s</nav>'),
		var_wrapper_attributes.dup(), var_content.dup()])).str()
}

fn register_block_core_query_pagination() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/query-pagination',
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_query_pagination' },
		])])
}

pub fn init_wp_includes_blocks_query_pagination_php() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_query_pagination')])
}
