import rt

fn render_block_core_avatar(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_size := if !(var_attributes.array_get('size')).is_null() { var_attributes.array_get('size') } else { rt.new_int(96) }
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{})
	mut var_border_attributes := get_block_core_avatar_border_attributes(var_attributes.dup())
	mut var_image_classes := if !(!rt.is_true(var_border_attributes.array_get('class'))) { rt.concat(rt.new_string('wp-block-avatar__image '), var_border_attributes.array_get('class')) } else { 'wp-block-avatar__image' }
	mut var_image_styles := if !(!rt.is_true(var_border_attributes.array_get('style'))) { rt.call_function('sprintf', [rt.new_string(' style="%s"'), rt.call_function('esc_attr', [var_border_attributes.array_get('style')])]) } else { rt.new_string('') }
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('commentId'))) {
		if var_attributes.array_isset(rt.new_string('userId')) {
			mut var_author_id := var_attributes.array_get('userId')
		} else if rt.get_property(var_block, 'context').array_isset(rt.new_string('postId')) {
			var_author_id = rt.call_function('get_post_field', [rt.new_string('post_author'), rt.get_property(var_block, 'context').array_get('postId')])
		} else {
			var_author_id = rt.call_function('get_query_var', [rt.new_string('author')])
		}
		if !rt.is_true(var_author_id) {
			return ''
		}
		mut var_author_name := rt.call_function('get_the_author_meta', [rt.new_string('display_name'), var_author_id.dup()])
		mut var_alt := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s Avatar')]), var_author_name.dup()])
		mut var_avatar_block := rt.call_function('get_avatar', [var_author_id.dup(), var_size.dup(), rt.new_string(''), var_alt.dup(), rt.create_array([rt.ArrayItem{ key: 'extra_attr', val: var_image_styles }, rt.ArrayItem{ key: 'class', val: var_image_classes }])])
		if rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('isLink')) && rt.is_true(var_attributes.array_get('isLink')))) {
			mut var_label := rt.new_string(rt.new_string(''))
			if rt.is_true(rt.identical(rt.new_string('_blank'), var_attributes.array_get('linkTarget'))) {
				var_label = rt.new_string('aria-label="' + (rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('(%s author archive, opens in a new tab)')]), var_author_name.dup()])])).str() + '"')
			}
			var_avatar_block = rt.call_function('sprintf', [rt.new_string('<a href="%1$s" target="%2$s" %3$s class="wp-block-avatar__link">%4$s</a>'), rt.call_function('esc_url', [rt.call_function('get_author_posts_url', [var_author_id.dup()])]), rt.call_function('esc_attr', [var_attributes.array_get('linkTarget')]), var_label.dup(), var_avatar_block.dup()])
		}
		return (rt.call_function('sprintf', [rt.new_string('<div %1s>%2s</div>'), var_wrapper_attributes.dup(), var_avatar_block.dup()])).str()
	}
	mut var_comment := rt.call_function('get_comment', [rt.get_property(var_block, 'context').array_get('commentId')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_comment)))) {
		return ''
	}
	var_alt = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s Avatar')]), rt.get_property(var_comment, 'comment_author')])
	var_avatar_block = rt.call_function('get_avatar', [var_comment.dup(), var_size.dup(), rt.new_string(''), var_alt.dup(), rt.create_array([rt.ArrayItem{ key: 'extra_attr', val: var_image_styles }, rt.ArrayItem{ key: 'class', val: var_image_classes }])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('isLink')) && rt.is_true(var_attributes.array_get('isLink')))) && !(rt.get_property(var_comment, 'comment_author_url')).is_null())) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_label = rt.new_string(rt.new_string(''))
		if rt.is_true(rt.identical(rt.new_string('_blank'), var_attributes.array_get('linkTarget'))) {
			var_label = rt.new_string('aria-label="' + (rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('(%s website link, opens in a new tab)')]), rt.get_property(var_comment, 'comment_author')])])).str() + '"')
		}
		var_avatar_block = rt.call_function('sprintf', [rt.new_string('<a href="%1$s" target="%2$s" %3$s class="wp-block-avatar__link">%4$s</a>'), rt.call_function('esc_url', [rt.get_property(var_comment, 'comment_author_url')]), rt.call_function('esc_attr', [var_attributes.array_get('linkTarget')]), var_label.dup(), var_avatar_block.dup()])
	}
	return (rt.call_function('sprintf', [rt.new_string('<div %1s>%2s</div>'), var_wrapper_attributes.dup(), var_avatar_block.dup()])).str()
}

fn get_block_core_avatar_border_attributes(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_border_styles := rt.new_array()
	mut var_sides := ['top', 'right', 'bottom', 'left']
	if var_attributes.array_get('style').array_get('border').array_isset(rt.new_string('radius')) {
		var_border_styles.array_set('radius', var_attributes.array_get('style').array_get('border').array_get('radius'))
	}
	if var_attributes.array_get('style').array_get('border').array_isset(rt.new_string('style')) {
		var_border_styles.array_set('style', var_attributes.array_get('style').array_get('border').array_get('style'))
	}
	if var_attributes.array_get('style').array_get('border').array_isset(rt.new_string('width')) {
		var_border_styles.array_set('width', var_attributes.array_get('style').array_get('border').array_get('width'))
	}
	mut var_preset_color := if rt.is_true(rt.new_bool(var_attributes.dup().array_isset(rt.new_string('borderColor')))) { rt.concat(rt.new_string('var:preset|color|'), var_attributes.array_get('borderColor')) } else { rt.new_null() }
	mut var_custom_color := if !(var_attributes.array_get('style').array_get('border').array_get('color')).is_null() { var_attributes.array_get('style').array_get('border').array_get('color') } else { rt.new_null() }
	var_border_styles.array_set('color', if rt.is_true(var_preset_color) { var_preset_color } else { var_custom_color })
	for var_side in var_sides {
		mut var_border := if !(var_attributes.array_get('style').array_get('border').array_get(side)).is_null() { var_attributes.array_get('style').array_get('border').array_get(side) } else { rt.new_null() }
		var_border_styles.array_set(side, rt.create_array([rt.ArrayItem{ key: 'color', val: if !(var_border.array_get('color')).is_null() { var_border.array_get('color') } else { rt.new_null() } }, rt.ArrayItem{ key: 'style', val: if !(var_border.array_get('style')).is_null() { var_border.array_get('style') } else { rt.new_null() } }, rt.ArrayItem{ key: 'width', val: if !(var_border.array_get('width')).is_null() { var_border.array_get('width') } else { rt.new_null() } }]))
	}
	mut var_styles := rt.call_function('wp_style_engine_get_styles', [rt.create_array([rt.ArrayItem{ key: 'border', val: var_border_styles }])])
	var_attributes = rt.new_array()
	if !(!rt.is_true(var_styles.array_get('classnames'))) {
		var_attributes['class'] = var_styles.array_get('classnames')
	}
	if !(!rt.is_true(var_styles.array_get('css'))) {
		var_attributes['style'] = var_styles.array_get('css')
	}
	return var_attributes.dup()
}

fn register_block_core_avatar() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/avatar', rt.create_array([rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_avatar' }])])
}



pub fn init_wp_includes_blocks_avatar_php() {
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('register_block_core_avatar')])
}
