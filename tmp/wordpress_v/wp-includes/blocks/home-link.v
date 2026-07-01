import rt

fn block_core_home_link_build_css_colors(var_context rt.PhpVal) rt.PhpVal {
	mut var_colors := rt.create_array([rt.ArrayItem{ key: 'css_classes', val: rt.new_array() }, rt.ArrayItem{ key: 'inline_styles', val: '' }])
	mut var_has_named_text_color := var_context.dup().array_isset(rt.new_string('textColor'))
	mut var_has_custom_text_color := rt.new_bool(var_context.array_get('style').array_get('color').array_isset(rt.new_string('text')))
	if rt.is_true(rt.new_bool(rt.is_true(var_has_custom_text_color) || var_has_named_text_color)) {
		var_colors.array_get_mut('css_classes').array_push('has-text-color')
	}
	if var_has_named_text_color {
		var_colors.array_get_mut('css_classes').array_push(rt.call_function('sprintf', [rt.new_string('has-%s-color'), var_context.array_get('textColor')]))
	} else if rt.is_true(var_has_custom_text_color) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_has_named_background_color := var_context.dup().array_isset(rt.new_string('backgroundColor'))
	mut var_has_custom_background_color := rt.new_bool(var_context.array_get('style').array_get('color').array_isset(rt.new_string('background')))
	if rt.is_true(rt.new_bool(rt.is_true(var_has_custom_background_color) || var_has_named_background_color)) {
		var_colors.array_get_mut('css_classes').array_push('has-background')
	}
	if var_has_named_background_color {
		var_colors.array_get_mut('css_classes').array_push(rt.call_function('sprintf', [rt.new_string('has-%s-background-color'), var_context.array_get('backgroundColor')]))
	} else if rt.is_true(var_has_custom_background_color) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	return var_colors.dup()
}

fn block_core_home_link_build_css_font_sizes(var_context rt.PhpVal) rt.PhpVal {
	mut var_font_sizes := rt.create_array([rt.ArrayItem{ key: 'css_classes', val: rt.new_array() }, rt.ArrayItem{ key: 'inline_styles', val: '' }])
	mut var_has_named_font_size := var_context.dup().array_isset(rt.new_string('fontSize'))
	mut var_has_custom_font_size := rt.new_bool(var_context.array_get('style').array_get('typography').array_isset(rt.new_string('fontSize')))
	if var_has_named_font_size {
		var_font_sizes.array_get_mut('css_classes').array_push(rt.call_function('sprintf', [rt.new_string('has-%s-font-size'), var_context.array_get('fontSize')]))
	} else if rt.is_true(var_has_custom_font_size) {
		var_font_sizes.array_set('inline_styles', rt.call_function('sprintf', [rt.new_string('font-size: %s;'), var_context.array_get('style').array_get('typography').array_get('fontSize')]))
	}
	return var_font_sizes.dup()
}

fn block_core_home_link_build_li_wrapper_attributes(var_context rt.PhpVal) rt.PhpVal {
	mut var_colors := block_core_home_link_build_css_colors(var_context.dup())
	mut var_font_sizes := block_core_home_link_build_css_font_sizes(var_context.dup())
	mut var_classes := rt.call_function('array_merge', [var_colors.array_get('css_classes'), var_font_sizes.array_get('css_classes')])
	mut var_style_attribute := rt.new_string(rt.concat(var_colors.array_get('inline_styles'), var_font_sizes.array_get('inline_styles')))
	var_classes.array_push('wp-block-navigation-item')
	if rt.is_true(rt.call_function('is_front_page', []rt.PhpVal{})) {
		var_classes.array_push('current-menu-item')
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_home', []rt.PhpVal{})) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_classes.array_push('current-menu-item')
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [rt.create_array([rt.ArrayItem{ key: 'class', val: rt.call_function('implode', [rt.new_string(' '), var_classes.dup()]) }, rt.ArrayItem{ key: 'style', val: var_style_attribute }])])
	return var_wrapper_attributes.dup()
}

fn render_block_core_home_link(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_attributes.array_get('label')) {
		var_attributes['label'] = rt.call_function('__', [rt.new_string('Home')])
	}
	mut var_aria_current := ''
	if rt.is_true(rt.call_function('is_front_page', []rt.PhpVal{})) {
		var_aria_current = ' aria-current="page"'
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_home', []rt.PhpVal{})) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_aria_current = ' aria-current="page"'
	}
	return rt.call_function('sprintf', [rt.new_string('<li %1$s><a class="wp-block-home-link__content wp-block-navigation-item__content" href="%2$s" rel="home"%3$s>%4$s</a></li>'), block_core_home_link_build_li_wrapper_attributes(rt.get_property(var_block, 'context')), rt.call_function('esc_url', [rt.call_function('home_url', []rt.PhpVal{})]), rt.new_string(var_aria_current).dup(), rt.call_function('wp_kses_post', [var_attributes.array_get('label')])])
}

fn register_block_core_home_link() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/home-link', rt.create_array([rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_home_link' }])])
}



pub fn init_wp_includes_blocks_home_link_php() {
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('register_block_core_home_link')])
}
