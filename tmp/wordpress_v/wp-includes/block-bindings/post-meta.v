import rt

fn _block_bindings_post_meta_get_value(var_source_args rt.PhpVal, var_block_instance rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_source_args.array_get('key')) {
		return rt.new_null()
	}
	if !rt.is_true(rt.get_property(var_block_instance, 'context').array_get('postId')) {
		return rt.new_null()
	}
	mut var_post_id := rt.get_property(var_block_instance, 'context').array_get('postId')
	mut var_post := rt.call_function('get_post', [var_post_id.dup()])
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_post_publicly_viewable', [var_post.dup()])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('read_post'), var_post_id.dup()])))))))
		|| rt.is_true(rt.call_function('post_password_required', [var_post.dup()]))))
	{
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('is_protected_meta', [var_source_args.array_get('key'),
		rt.new_string('post')]))
	{
		return rt.new_null()
	}
	mut var_meta_keys := rt.call_function('get_registered_meta_keys', [
		rt.new_string('post'),
		rt.get_property(var_block_instance, 'context').array_get('postType'),
	])
	var_meta_keys = rt.call_function('array_merge', [var_meta_keys.dup(),
		rt.call_function('get_registered_meta_keys', [rt.new_string('post'),
			rt.new_string('')])])
	if !rt.is_true(var_meta_keys.array_get(var_source_args.array_get('key')).array_get('show_in_rest')) {
		return rt.new_null()
	}
	return rt.call_function('get_post_meta', [var_post_id.dup(),
		var_source_args.array_get('key'), rt.new_bool(true)])
}

fn _register_block_bindings_post_meta_source() {
	rt.call_function('register_block_bindings_source', [rt.new_string('core/post-meta'),
		rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Post Meta'),
				rt.new_string('block bindings source'),
			]) },
			rt.ArrayItem{ key: 'get_value_callback', val: '_block_bindings_post_meta_get_value' },
			rt.ArrayItem{ key: 'uses_context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'postType' },
			]) },
		])])
}

pub fn init_wp_includes_block_bindings_post_meta_php() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('_register_block_bindings_post_meta_source')])
}
