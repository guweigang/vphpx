import rt

fn render_block_core_post_author(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_author_id := rt.new_null()
	mut var_avatar := rt.new_null()
	mut var_link := rt.new_null()
	mut var_author_name := rt.new_null()
	mut var_byline := rt.new_null()
	mut var_classes := []rt.PhpVal{}
	mut var_wrapper_attributes := rt.new_null()
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('postId'))) {
		var_author_id = rt.call_function('get_query_var', [rt.new_string('author')])
	} else {
		var_author_id = rt.call_function('get_post_field', [rt.new_string('post_author'),
			rt.get_property(var_block, 'context').array_get(rt.new_string('postId'))])
	}
	if !rt.is_true(var_author_id) {
		return ''
	}
	if rt.get_property(var_block, 'context').array_isset(rt.new_string('postType'))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('post_type_supports', [rt.get_property(var_block, 'context').array_get(rt.new_string('postType')), rt.new_string('author')]))))) {
		return ''
	}
	var_avatar = if !(!rt.is_true(var_attributes.array_get(rt.new_string('avatarSize')))) { rt.call_function('get_avatar', [
			var_author_id.clone(),
			var_attributes.array_get(rt.new_string('avatarSize')),
		]) } else { rt.new_null() }
	var_link = rt.call_function('get_author_posts_url', [var_author_id.clone()])
	var_author_name = rt.call_function('get_the_author_meta', [
		rt.new_string('display_name'),
		var_author_id.clone(),
	])
	if !(!(rt.is_true(var_attributes.array_get(rt.new_string('isLink')))
		&& !(!rt.is_true(var_attributes.array_get(rt.new_string('linkTarget')))))) {
		var_author_name = rt.call_function('sprintf', [
			rt.new_string('<a href="%1$s" target="%2$s">%3$s</a>'),
			rt.call_function('esc_url', [var_link.clone()]),
			rt.call_function('esc_attr', [var_attributes.array_get(rt.new_string('linkTarget'))]),
			var_author_name.clone(),
		])
	}
	var_byline = if !(!rt.is_true(var_attributes.array_get(rt.new_string('byline')))) {
		var_attributes.array_get(rt.new_string('byline'))
	} else {
		rt.new_bool(false)
	}
	var_classes = []rt.PhpVal{}
	if var_attributes.array_isset(rt.new_string('itemsJustification')) {
		var_classes << 'items-justified-' +
			(var_attributes.array_get(rt.new_string('itemsJustification'))).str()
	}
	if var_attributes.array_isset(rt.new_string('textAlign')) {
		var_classes << 'has-text-align-' +
			(var_attributes.array_get(rt.new_string('textAlign'))).str()
	}
	if var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('elements')).array_get(rt.new_string('link')).array_get(rt.new_string('color')).array_isset(rt.new_string('text')) {
		var_classes << 'has-link-color'
	}
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'class', val: rt.call_function('implode', [
				rt.new_string(' '),
				rt.create_array_from_list(var_classes),
			]) },
		]),
	])
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>'), var_wrapper_attributes.clone()])).str() + if !(!rt.is_true(var_attributes.array_get(rt.new_string('showAvatar')))) {
		'<div class="wp-block-post-author__avatar">' + var_avatar.str() + '</div>'
	} else {
		''
	} + '<div class="wp-block-post-author__content">' + if !(!rt.is_true(var_byline)) {
		'<p class="wp-block-post-author__byline">' + (rt.call_function('wp_kses_post', [var_byline.clone()])).str() + '</p>'
	} else {
		''
	} + '<p class="wp-block-post-author__name">' + var_author_name.str() + '</p>' + if !(!rt.is_true(var_attributes.array_get(rt.new_string('showBio')))) {
		'<p class="wp-block-post-author__bio">' + (rt.call_function('get_the_author_meta', [rt.new_string('user_description'), var_author_id.clone()])).str() + '</p>'
	} else {
		''
	} + '</div>' + '</div>'
}

fn register_block_core_post_author() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/post-author'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_post_author' },
		]),
	])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_post_author')])
}
