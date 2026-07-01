import rt

fn render_block_core_post_author_name(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if rt.get_property(var_block, 'context').array_isset(rt.new_string('postId')) {
		mut var_author_id := rt.call_function('get_post_field', [
			rt.new_string('post_author'),
			rt.get_property(var_block, 'context').array_get('postId'),
		])
	} else {
		var_author_id = rt.call_function('get_query_var', [rt.new_string('author')])
	}
	if !rt.is_true(var_author_id) {
		return ''
	}
	if rt.is_true(rt.new_bool(
		rt.get_property(var_block, 'context').array_isset(rt.new_string('postType'))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('post_type_supports', [rt.get_property(var_block, 'context').array_get('postType'), rt.new_string('author')])))))))
	{
		return ''
	}
	mut var_author_name := rt.call_function('get_the_author_meta', [
		rt.new_string('display_name'),
		var_author_id.dup(),
	])
	if rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('isLink'))
		&& rt.is_true(var_attributes.array_get('isLink'))))
	{
		var_author_name = rt.call_function('sprintf', [
			rt.new_string('<a href="%1$s" target="%2$s" class="wp-block-post-author-name__link">%3$s</a>'),
			rt.call_function('get_author_posts_url', [var_author_id.dup()]),
			rt.call_function('esc_attr', [var_attributes.array_get('linkTarget')]),
			var_author_name.dup(),
		])
	}
	mut var_classes := []rt.PhpVal{}
	if var_attributes.array_isset(rt.new_string('textAlign')) {
		var_classes << 'has-text-align-' + (var_attributes.array_get('textAlign')).str()
	}
	if var_attributes.array_get('style').array_get('elements').array_get('link').array_get('color').array_isset(rt.new_string('text')) {
		var_classes << 'has-link-color'
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'class', val: rt.call_function('implode', [
				rt.new_string(' '),
				var_classes.dup(),
			]) },
		]),
	])
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
		var_wrapper_attributes.dup(), var_author_name.dup()])).str()
}

fn register_block_core_post_author_name() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/post-author-name',
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_post_author_name' },
		])])
}

pub fn init_wp_includes_blocks_post_author_name_php() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_post_author_name')])
}
