import rt

fn block_core_shared_navigation_item_should_render(var_attributes rt.PhpVal, var_block rt.PhpVal) bool {
	mut var_navigation_link_has_id := var_attributes.array_isset(rt.new_string('id'))
		&& rt.is_true(rt.new_bool(var_attributes.array_get('id').is_long()
		|| var_attributes.array_get('id').is_double()))
	mut var_is_post_type := var_attributes.array_isset(rt.new_string('kind'))
		&& rt.is_true(rt.identical(rt.new_string('post-type'), var_attributes.array_get('kind')))
	var_is_post_type = var_is_post_type
		|| rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('type'))
		&& rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('post'), var_attributes.array_get('type')))
		|| rt.is_true(rt.identical(rt.new_string('page'), var_attributes.array_get('type')))))))
	if var_is_post_type && var_navigation_link_has_id {
		mut var_post := rt.call_function('get_post', [var_attributes.array_get('id')])
		mut var_allowed_post_status := rt.cast_array(rt.call_function('apply_filters', [
			rt.new_string('render_block_core_navigation_link_allowed_post_status'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'publish' }]),
			var_attributes.dup(),
			var_block.dup(),
		]))
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_post))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_post, 'post_status'), var_allowed_post_status.dup(), rt.new_bool(true)])))))))
		{
			return false
		}
	}
	return true
}

pub fn init_wp_includes_blocks_navigation_link_shared_item_should_render_php() {
}
