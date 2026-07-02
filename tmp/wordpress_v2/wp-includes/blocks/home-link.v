import rt

fn block_core_home_link_build_css_colors(var_context rt.PhpVal) rt.PhpVal {
	mut var_colors := rt.new_null()
	mut var_has_named_text_color := false
	mut var_has_custom_text_color := rt.new_null()
	mut var_has_named_background_color := false
	mut var_has_custom_background_color := rt.new_null()
	var_colors = rt.create_array([
		rt.ArrayItem{ key: 'css_classes', val: rt.new_array() },
		rt.ArrayItem{ key: 'inline_styles', val: '' },
	])
	var_has_named_text_color =
		rt.create_array_from_native_map(var_context).array_isset(rt.new_string('textColor'))
	var_has_custom_text_color =
		rt.new_bool(var_context.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_isset(rt.new_string('text')))
	if rt.is_true(var_has_custom_text_color) || var_has_named_text_color {
		var_colors.array_get_mut('css_classes').array_push('has-text-color')
	}
	if var_has_named_text_color {
		var_colors.array_get_mut('css_classes').array_push(rt.call_function('sprintf', [
			rt.new_string('has-%s-color'),
			var_context.array_get(rt.new_string('textColor')),
		]))
	} else if rt.is_true(var_has_custom_text_color) {
		var_colors.array_get(rt.new_string('inline_styles')) = rt.concat(var_colors.array_get(rt.new_string('inline_styles')), rt.call_function('sprintf', [
			rt.new_string('color: %s;'),
			var_context.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('text')),
		]))
	}
	var_has_named_background_color =
		rt.create_array_from_native_map(var_context).array_isset(rt.new_string('backgroundColor'))
	var_has_custom_background_color =
		rt.new_bool(var_context.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_isset(rt.new_string('background')))
	if rt.is_true(var_has_custom_background_color) || var_has_named_background_color {
		var_colors.array_get_mut('css_classes').array_push('has-background')
	}
	if var_has_named_background_color {
		var_colors.array_get_mut('css_classes').array_push(rt.call_function('sprintf', [
			rt.new_string('has-%s-background-color'),
			var_context.array_get(rt.new_string('backgroundColor')),
		]))
	} else if rt.is_true(var_has_custom_background_color) {
		var_colors.array_get(rt.new_string('inline_styles')) = rt.concat(var_colors.array_get(rt.new_string('inline_styles')), rt.call_function('sprintf', [
			rt.new_string('background-color: %s;'),
			var_context.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('background')),
		]))
	}
	return var_colors.clone()
}

fn block_core_home_link_build_css_font_sizes(var_context rt.PhpVal) rt.PhpVal {
	mut var_font_sizes := rt.new_null()
	mut var_has_named_font_size := false
	mut var_has_custom_font_size := rt.new_null()
	var_font_sizes = rt.create_array([
		rt.ArrayItem{ key: 'css_classes', val: rt.new_array() },
		rt.ArrayItem{ key: 'inline_styles', val: '' },
	])
	var_has_named_font_size =
		rt.create_array_from_native_map(var_context).array_isset(rt.new_string('fontSize'))
	var_has_custom_font_size =
		rt.new_bool(var_context.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_isset(rt.new_string('fontSize')))
	if var_has_named_font_size {
		var_font_sizes.array_get_mut('css_classes').array_push(rt.call_function('sprintf', [
			rt.new_string('has-%s-font-size'),
			var_context.array_get(rt.new_string('fontSize')),
		]))
	} else if rt.is_true(var_has_custom_font_size) {
		var_font_sizes.array_set('inline_styles', rt.call_function('sprintf', [
			rt.new_string('font-size: %s;'),
			var_context.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontSize')),
		]))
	}
	return var_font_sizes.clone()
}

fn block_core_home_link_build_li_wrapper_attributes(var_context rt.PhpVal) rt.PhpVal {
	mut var_colors := rt.new_null()
	mut var_font_sizes := rt.new_null()
	mut var_classes := rt.new_null()
	mut var_style_attribute := rt.new_null()
	mut var_wrapper_attributes := rt.new_null()
	var_colors = block_core_home_link_build_css_colors(rt.create_array_from_native_map(var_context))
	var_font_sizes =
		block_core_home_link_build_css_font_sizes(rt.create_array_from_native_map(var_context))
	var_classes = rt.call_function('array_merge', [
		var_colors.array_get(rt.new_string('css_classes')),
		var_font_sizes.array_get(rt.new_string('css_classes')),
	])
	var_style_attribute = rt.new_string(
		(var_colors.array_get(rt.new_string('inline_styles'))).str() +
		(var_font_sizes.array_get(rt.new_string('inline_styles'))).str())
	var_classes.array_push('wp-block-navigation-item')
	if rt.is_true(rt.call_function('is_front_page', []rt.PhpVal{})) {
		var_classes.array_push('current-menu-item')
	} else if rt.is_true(rt.call_function('is_home', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int((rt.call_function('get_option', [rt.new_string('page_for_posts')])).to_i64()), rt.call_function('get_queried_object_id', []rt.PhpVal{}))))) {
		var_classes.array_push('current-menu-item')
	}
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'class', val: rt.call_function('implode', [
				rt.new_string(' '),
				var_classes.clone(),
			]) },
			rt.ArrayItem{ key: 'style', val: var_style_attribute },
		]),
	])
	return var_wrapper_attributes.clone()
}

fn render_block_core_home_link(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_aria_current := ''
	if !rt.is_true(var_attributes.array_get(rt.new_string('label'))) {
		var_attributes['label'] = rt.call_function('__', [rt.new_string('Home')])
	}
	var_aria_current = ''
	if rt.is_true(rt.call_function('is_front_page', []rt.PhpVal{})) {
		var_aria_current = ' aria-current="page"'
	} else if rt.is_true(rt.call_function('is_home', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int((rt.call_function('get_option', [rt.new_string('page_for_posts')])).to_i64()), rt.call_function('get_queried_object_id', []rt.PhpVal{}))))) {
		var_aria_current = ' aria-current="page"'
	}
	return rt.call_function('sprintf', [
		rt.new_string('<li %1$s><a class="wp-block-home-link__content wp-block-navigation-item__content" href="%2$s" rel="home"%3$s>%4$s</a></li>'),
		block_core_home_link_build_li_wrapper_attributes(rt.get_property(var_block, 'context')),
		rt.call_function('esc_url', [rt.call_function('home_url', []rt.PhpVal{})]),
		rt.new_string(var_aria_current.str()).clone(),
		rt.call_function('wp_kses_post', [var_attributes.array_get(rt.new_string('label'))]),
	])
}

fn register_block_core_home_link() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/home-link'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_home_link' },
		]),
	])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_home_link')])
}
