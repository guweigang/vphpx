import rt

fn block_core_shared_navigation_item_should_render(var_attributes rt.PhpVal, var_block rt.PhpVal) bool {
	mut var_navigation_link_has_id := false
	mut var_is_post_type := false
	mut var_post := rt.new_null()
	mut var_allowed_post_status := rt.new_null()
	var_navigation_link_has_id = var_attributes.array_isset(rt.new_string('id'))
		&& var_attributes.array_get(rt.new_string('id')).is_long()
		|| var_attributes.array_get(rt.new_string('id')).is_double()
	var_is_post_type = var_attributes.array_isset(rt.new_string('kind'))
		&& rt.is_true(rt.identical(rt.new_string('post-type'), var_attributes.array_get(rt.new_string('kind'))))
	var_is_post_type = var_is_post_type
		|| var_attributes.array_isset(rt.new_string('type'))
		&& rt.is_true(rt.identical(rt.new_string('post'), var_attributes.array_get(rt.new_string('type'))))
		|| rt.is_true(rt.identical(rt.new_string('page'), var_attributes.array_get(rt.new_string('type'))))
	if var_is_post_type && var_navigation_link_has_id {
		var_post = rt.call_function('get_post', [var_attributes.array_get(rt.new_string('id'))])
		var_allowed_post_status = rt.cast_array(rt.call_function('apply_filters', [
			rt.new_string('render_block_core_navigation_link_allowed_post_status'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'publish' }]),
			rt.create_array_from_native_map(var_attributes),
			var_block.clone(),
		]))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_post, 'post_status'), var_allowed_post_status.clone(), rt.new_bool(true)]))))) {
			return false
		}
	}
	return true
}

fn main() {
	defer {
		rt.shutdown()
	}
}
