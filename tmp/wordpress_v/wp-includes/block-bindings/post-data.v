import rt

fn _block_bindings_post_data_get_value(var_source_args rt.PhpVal, var_block_instance rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_source_args.array_get('field')) {
		if !rt.is_true(var_source_args.array_get('key')) {
			return rt.new_null()
		}
		mut var_field := var_source_args.array_get('key')
	} else {
		var_field = var_source_args.array_get('field')
	}
	mut var_block_name := if !(rt.get_property(var_block_instance, 'name')).is_null() {
		rt.get_property(var_block_instance, 'name')
	} else {
		rt.new_string('')
	}
	mut var_is_navigation_block := rt.call_function('in_array', [
		var_block_name.dup(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'core/navigation-link' },
			rt.ArrayItem{ key: none, val: 'core/navigation-submenu' },
		]),
		rt.new_bool(true)])
	if rt.is_true(var_is_navigation_block) {
		mut var_post_id := if !(rt.get_property(var_block_instance, 'attributes').array_get('id')).is_null() {
			rt.get_property(var_block_instance, 'attributes').array_get('id')
		} else {
			rt.new_null()
		}
	} else {
		var_post_id = if !(rt.get_property(var_block_instance, 'context').array_get('postId')).is_null() {
			rt.get_property(var_block_instance, 'context').array_get('postId')
		} else {
			rt.new_null()
		}
	}
	if !rt.is_true(var_post_id) {
		return rt.new_null()
	}
	mut var_post := rt.call_function('get_post', [var_post_id.dup()])
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_post_publicly_viewable', [var_post.dup()])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('read_post'), var_post_id.dup()])))))))
		|| rt.is_true(rt.call_function('post_password_required', [var_post.dup()]))))
	{
		return rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_string('date'), var_field)) {
		return rt.call_function('esc_attr', [
			rt.call_function('get_the_date', [rt.new_string('c'),
				var_post_id.dup()]),
		])
	}
	if rt.is_true(rt.identical(rt.new_string('modified'), var_field)) {
		if rt.is_true(rt.greater(rt.call_function('get_the_modified_date', [
			rt.new_string('U'),
			var_post_id.dup(),
		]), rt.call_function('get_the_date', [rt.new_string('U'),
			var_post_id.dup()])))
		{
			return rt.call_function('esc_attr', [
				rt.call_function('get_the_modified_date', [rt.new_string('c'),
					var_post_id.dup()]),
			])
		} else {
			return rt.new_string('')
		}
	}
	if rt.is_true(rt.identical(rt.new_string('link'), var_field)) {
		mut var_permalink := rt.call_function('get_permalink', [
			var_post_id.dup()])
		return if rt.is_true(rt.identical(rt.new_bool(false), var_permalink)) { rt.new_null() } else { rt.call_function('esc_url', [
				var_permalink.dup(),
			]) }
	}
	return rt.new_null()
}

fn _register_block_bindings_post_data_source() {
	rt.call_function('register_block_bindings_source', [rt.new_string('core/post-data'),
		rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Post Data'),
				rt.new_string('block bindings source'),
			]) },
			rt.ArrayItem{ key: 'get_value_callback', val: '_block_bindings_post_data_get_value' },
			rt.ArrayItem{ key: 'uses_context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'postType' },
			]) },
		])])
}

pub fn init_wp_includes_block_bindings_post_data_php() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('_register_block_bindings_post_data_source')])
}
