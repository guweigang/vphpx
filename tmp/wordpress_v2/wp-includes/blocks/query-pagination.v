import rt

fn render_block_core_query_pagination(var_attributes rt.PhpVal, var_content rt.PhpVal) string {
	mut var_classes := ''
	mut var_wrapper_attributes := rt.new_null()
	if var_content.clone().to_string().trim_space() == '' {
		return ''
	}
	var_classes = if var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('elements')).array_get(rt.new_string('link')).array_get(rt.new_string('color')).array_isset(rt.new_string('text')) {
		'has-link-color'
	} else {
		''
	}
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'aria-label', val: rt.call_function('__', [
				rt.new_string('Pagination'),
			]) },
			rt.ArrayItem{ key: 'class', val: var_classes },
		]),
	])
	return (rt.call_function('sprintf', [rt.new_string('<nav %1$s>%2$s</nav>'),
		var_wrapper_attributes.clone(), var_content.clone()])).str()
}

fn register_block_core_query_pagination() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/query-pagination'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_query_pagination' },
		]),
	])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_query_pagination')])
}
