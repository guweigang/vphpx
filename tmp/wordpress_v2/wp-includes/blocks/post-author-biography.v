import rt

fn render_block_core_post_author_biography(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_author_id := rt.new_null()
	mut var_author_biography := rt.new_null()
	mut var_align_class_name := ''
	mut var_wrapper_attributes := rt.new_null()
	if rt.get_property(var_block, 'context').array_isset(rt.new_string('postId')) {
		var_author_id = rt.call_function('get_post_field', [rt.new_string('post_author'),
			rt.get_property(var_block, 'context').array_get(rt.new_string('postId'))])
	} else {
		var_author_id = rt.call_function('get_query_var', [rt.new_string('author')])
	}
	if !rt.is_true(var_author_id) {
		return ''
	}
	var_author_biography = rt.call_function('get_the_author_meta', [
		rt.new_string('description'),
		var_author_id.clone(),
	])
	if !rt.is_true(var_author_biography) {
		return ''
	}
	var_align_class_name = if !rt.is_true(var_attributes.array_get(rt.new_string('textAlign'))) {
		''
	} else {
		rt.concat(rt.new_string('has-text-align-'),
			var_attributes.array_get(rt.new_string('textAlign')))
	}
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([rt.ArrayItem{ key: 'class', val: var_align_class_name }]),
	])
	return
		(rt.call_function('sprintf', [rt.new_string('<div %1$s>'), var_wrapper_attributes.clone()])).str() +
		var_author_biography.str() + '</div>'
}

fn register_block_core_post_author_biography() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/post-author-biography'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_post_author_biography' },
		]),
	])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_post_author_biography')])
}
