import rt

fn render_block_core_post_content(var_attributes rt.PhpVal, var_content_arg rt.PhpVal, var_block rt.PhpVal) string {
	mut var_content := var_content_arg
	mut var_seen_ids := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_is_debug := false
	mut var_tag_name := rt.new_null()
	mut var_wrapper_attributes := rt.new_null()
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('postId'))) {
		return ''
	}
	var_post_id = rt.get_property(var_block, 'context').array_get(rt.new_string('postId'))
	if var_seen_ids.array_isset(var_post_id) {
		var_is_debug = rt.is_true(rt.get_constant('WP_DEBUG'))
			&& rt.is_true(rt.get_constant('WP_DEBUG_DISPLAY'))
		return (if var_is_debug {
			rt.call_function('__', [rt.new_string('[block rendering halted]')])
		} else {
			rt.new_string('')
		}).str()
	}
	var_seen_ids.array_set(var_post_id, true)
	var_content = rt.call_function('get_the_content', []rt.PhpVal{})
	if rt.is_true(rt.call_function('has_block', [rt.new_string('core/nextpage')])) {
		var_content = rt.concat(var_content, rt.call_function('wp_link_pages', [
			rt.create_array([rt.ArrayItem{ key: 'echo', val: 0 }]),
		]))
	}
	var_content = rt.call_function('apply_filters', [rt.new_string('the_content'),
		rt.call_function('str_replace', [rt.new_string(']]>'),
			rt.new_string(']]&gt;'), var_content.clone()])])
	var_seen_ids.array_unset(var_post_id)
	if !rt.is_true(var_content) {
		return ''
	}
	var_tag_name = rt.new_string('div')
	if !(!rt.is_true(var_attributes.array_get(rt.new_string('tagName'))))
		&& rt.is_true(rt.identical(rt.call_function('tag_escape', [var_attributes.array_get(rt.new_string('tagName'))]), var_attributes.array_get(rt.new_string('tagName')))) {
		var_tag_name = var_attributes.array_get(rt.new_string('tagName'))
	}
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([rt.ArrayItem{ key: 'class', val: 'entry-content' }]),
	])
	return (rt.call_function('sprintf', [rt.new_string('<%1$s %2$s>%3$s</%1$s>'),
		var_tag_name.clone(), var_wrapper_attributes.clone(),
		var_content.clone()])).str()
}

fn register_block_core_post_content() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/post-content'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_post_content' },
		]),
	])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_post_content')])
}
