import rt

fn block_core_navigation_submenu_get_submenu_visibility(var_context rt.PhpVal) string {
	mut var_deprecated_open_submenus_on_click := rt.new_null()
	mut var_submenu_visibility := rt.new_null()
	var_deprecated_open_submenus_on_click = if !(var_context.array_get(rt.new_string('openSubmenusOnClick'))).is_null() {
		var_context.array_get(rt.new_string('openSubmenusOnClick'))
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(),
		var_deprecated_open_submenus_on_click))))
	{
		return if !(!rt.is_true(var_deprecated_open_submenus_on_click)) { 'click' } else { 'hover' }
	}
	var_submenu_visibility = if !(var_context.array_get(rt.new_string('submenuVisibility'))).is_null() {
		var_context.array_get(rt.new_string('submenuVisibility'))
	} else {
		rt.new_null()
	}
	return (if !var_submenu_visibility.is_null() {
		var_submenu_visibility
	} else {
		rt.new_string('hover')
	}).str()
}

fn block_core_navigation_submenu_build_css_font_sizes(var_context rt.PhpVal) rt.PhpVal {
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
			rt.call_function('wp_get_typography_font_size_value', [
				rt.create_array([
					rt.ArrayItem{
						key: 'size'
						val: var_context.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontSize'))
					},
				]),
			]),
		]))
	}
	return var_font_sizes.clone()
}

fn render_block_core_navigation_submenu(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_font_sizes := rt.new_null()
	mut var_style_attribute := rt.new_null()
	mut var_inner_blocks_html := ''
	mut var_inner_block := rt.new_null()
	mut var_has_submenu := false
	mut var_kind := rt.new_null()
	mut var_is_active := false
	mut var_queried_archive_link := rt.new_null()
	mut var_show_submenu_indicators := false
	mut var_computed_visibility := ''
	mut var_open_on_click := false
	mut var_open_on_hover := false
	mut var_open_on_hover_and_click := false
	mut var_classes := rt.new_null()
	mut var_wrapper_attributes := rt.new_null()
	mut var_label := ''
	mut var_aria_label := rt.new_null()
	mut var_html := rt.new_null()
	mut var_item_url := rt.new_null()
	mut var_colors_supports := rt.new_null()
	mut var_css_classes := ''
	mut var_tag_processor := rt.new_null()
	if rt.is_true(rt.call_function('defined', [rt.new_string('IS_GUTENBERG_PLUGIN')]))
		&& rt.is_true(rt.get_constant('IS_GUTENBERG_PLUGIN')) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('gutenberg_block_core_shared_navigation_item_should_render', [
			rt.create_array_from_native_map(var_attributes),
			var_block.clone(),
		])))))
		{
			return ''
		}
	}
	if !rt.is_true(var_attributes.array_get(rt.new_string('label'))) {
		return ''
	}
	var_font_sizes = block_core_navigation_submenu_build_css_font_sizes(rt.get_property(var_block,
		'context'))
	var_style_attribute = var_font_sizes.array_get(rt.new_string('inline_styles'))
	var_inner_blocks_html = ''
	mut iter_1 := rt.get_property(var_block, 'inner_blocks').iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_inner_block_shadow := item_1.val
		var_inner_blocks_html = var_inner_blocks_html +
			(rt.call_method(var_inner_block_shadow, 'render', []rt.PhpVal{})).str()
	}
	var_has_submenu = !(var_inner_blocks_html.trim_space() == '')
	var_kind = if !rt.is_true(var_attributes.array_get(rt.new_string('kind'))) { rt.new_string('post_type') } else { rt.call_function('str_replace', [
			rt.new_string('-'),
			rt.new_string('_'),
			var_attributes.array_get(rt.new_string('kind')),
		]) }
	var_is_active = !(!rt.is_true(var_attributes.array_get(rt.new_string('id'))))
		&& rt.is_true(rt.identical(rt.call_function('get_queried_object_id', []rt.PhpVal{}), rt.new_int((var_attributes.array_get(rt.new_string('id'))).to_i64())))
		&& !(!rt.is_true(rt.get_property(rt.call_function('get_queried_object', []rt.PhpVal{}), '{"nodeType":"Expr_Variable","line":130,"name":"kind"}')))
	if rt.is_true(rt.call_function('is_post_type_archive', []rt.PhpVal{}))
		&& !(!rt.is_true(var_attributes.array_get(rt.new_string('url')))) {
		var_queried_archive_link = rt.call_function('get_post_type_archive_link', [
			rt.get_property(rt.call_function('get_queried_object', []rt.PhpVal{}), 'name'),
		])
		if rt.is_true(rt.identical(var_attributes.array_get(rt.new_string('url')),
			var_queried_archive_link))
		{
			var_is_active = true
		}
	}
	var_show_submenu_indicators =
		rt.get_property(var_block, 'context').array_isset(rt.new_string('showSubmenuIcon'))
		&& rt.is_true(rt.get_property(var_block, 'context').array_get(rt.new_string('showSubmenuIcon')))
	var_computed_visibility = block_core_navigation_submenu_get_submenu_visibility(rt.get_property(var_block,
		'context'))
	var_open_on_click = (rt.identical(rt.new_string('click'),
		rt.new_string(var_computed_visibility.str()))).to_bool()
	var_open_on_hover = (rt.identical(rt.new_string('hover'),
		rt.new_string(var_computed_visibility.str()))).to_bool()
	var_open_on_hover_and_click = var_open_on_hover && var_show_submenu_indicators
	var_classes = rt.create_array([
		rt.ArrayItem{ key: none, val: 'wp-block-navigation-item' },
	])
	var_classes = rt.call_function('array_merge', [var_classes.clone(),
		var_font_sizes.array_get(rt.new_string('css_classes'))])
	if var_has_submenu {
		var_classes.array_push('has-child')
	}
	if var_open_on_click {
		var_classes.array_push('open-on-click')
	}
	if var_open_on_hover_and_click {
		var_classes.array_push('open-on-hover-click')
	}
	if rt.is_true(rt.identical(rt.new_string('always'),
		rt.new_string(var_computed_visibility.str())))
	{
		var_classes.array_push('open-always')
	}
	if var_is_active {
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
	var_label = ''
	if var_attributes.array_isset(rt.new_string('label')) {
		var_label = var_label +(rt.call_function('wp_kses_post', [var_attributes.array_get(rt.new_string('label'))])).str()
	}
	var_aria_label = rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('%s submenu')]),
		rt.call_function('wp_strip_all_tags', [rt.new_string(var_label.str()).clone()]),
	])
	var_html = rt.new_string('<li ' + var_wrapper_attributes.str() + '>')
	if !var_open_on_click {
		var_item_url = if !(var_attributes.array_get(rt.new_string('url'))).is_null() {
			var_attributes.array_get(rt.new_string('url'))
		} else {
			rt.new_string('')
		}
		var_html = rt.concat(var_html,
			rt.new_string('<a class="wp-block-navigation-item__content"'))
		if !(!rt.is_true(var_item_url)) {
			var_html = rt.concat(var_html, rt.new_string(' href="' +
				(rt.call_function('esc_url', [var_item_url.clone()])).str() + '"'))
		}
		if var_is_active {
			var_html = rt.concat(var_html, rt.new_string(' aria-current="page"'))
		}
		if var_attributes.array_isset(rt.new_string('opensInNewTab'))
			&& rt.is_true(rt.identical(rt.new_bool(true), var_attributes.array_get(rt.new_string('opensInNewTab')))) {
			var_html = rt.concat(var_html, rt.new_string(' target="_blank"  '))
		}
		if var_attributes.array_isset(rt.new_string('rel')) {
			var_html = rt.concat(var_html, rt.new_string(' rel="' +
				(rt.call_function('esc_attr', [var_attributes.array_get(rt.new_string('rel'))])).str() +
				'"'))
		} else if var_attributes.array_isset(rt.new_string('nofollow'))
			&& rt.is_true(var_attributes.array_get(rt.new_string('nofollow'))) {
			var_html = rt.concat(var_html, rt.new_string(' rel="nofollow"'))
		}
		if var_attributes.array_isset(rt.new_string('title')) {
			var_html = rt.concat(var_html, rt.new_string(' title="' +
				(rt.call_function('esc_attr', [var_attributes.array_get(rt.new_string('title'))])).str() +
				'"'))
		}
		var_html = rt.concat(var_html, rt.new_string('>'))
		var_html = rt.concat(var_html,
			rt.new_string('<span class="wp-block-navigation-item__label">'))
		var_html = rt.concat(var_html, rt.new_string(var_label.str()))
		var_html = rt.concat(var_html, rt.new_string('</span>'))
		if !(!rt.is_true(var_attributes.array_get(rt.new_string('description')))) {
			var_html = rt.concat(var_html,
				rt.new_string('<span class="wp-block-navigation-item__description">'))
			var_html = rt.concat(var_html, rt.call_function('wp_kses_post', [
				var_attributes.array_get(rt.new_string('description')),
			]))
			var_html = rt.concat(var_html, rt.new_string('</span>'))
		}
		var_html = rt.concat(var_html, rt.new_string('</a>'))
		if var_show_submenu_indicators && var_has_submenu {
			var_html = rt.concat(var_html, rt.new_string('<button aria-label="' +
				(rt.call_function('esc_attr', [var_aria_label.clone()])).str() +
				'" class="wp-block-navigation__submenu-icon wp-block-navigation-submenu__toggle" aria-expanded="false">' +
				(rt.call_function('block_core_navigation_render_submenu_icon', []rt.PhpVal{})).str() +
				'</button>'))
		}
	} else {
		var_html = rt.concat(var_html, rt.new_string('<button aria-label="' +
			(rt.call_function('esc_attr', [var_aria_label.clone()])).str() +
			'" class="wp-block-navigation-item__content wp-block-navigation-submenu__toggle" aria-expanded="false">'))
		var_html = rt.concat(var_html,
			rt.new_string('<span class="wp-block-navigation-item__label">'))
		var_html = rt.concat(var_html, rt.new_string(var_label.str()))
		var_html = rt.concat(var_html, rt.new_string('</span>'))
		if !(!rt.is_true(var_attributes.array_get(rt.new_string('description')))) {
			var_html = rt.concat(var_html,
				rt.new_string('<span class="wp-block-navigation-item__description">'))
			var_html = rt.concat(var_html, rt.call_function('wp_kses_post', [
				var_attributes.array_get(rt.new_string('description')),
			]))
			var_html = rt.concat(var_html, rt.new_string('</span>'))
		}
		var_html = rt.concat(var_html, rt.new_string('</button>'))
		if var_has_submenu {
			var_html = rt.concat(var_html, rt.new_string(
				'<span class="wp-block-navigation__submenu-icon">' +
				(rt.call_function('block_core_navigation_render_submenu_icon', []rt.PhpVal{})).str() +
				'</span>'))
		}
	}
	if var_has_submenu {
		if rt.is_true(rt.new_bool(rt.get_property(var_block, 'context').array_isset(rt.new_string('overlayTextColor')))) {
			var_attributes['textColor'] =
				rt.get_property(var_block, 'context').array_get(rt.new_string('overlayTextColor'))
		}
		if rt.is_true(rt.new_bool(rt.get_property(var_block, 'context').array_isset(rt.new_string('overlayBackgroundColor')))) {
			var_attributes['backgroundColor'] =
				rt.get_property(var_block, 'context').array_get(rt.new_string('overlayBackgroundColor'))
		}
		if rt.is_true(rt.new_bool(rt.get_property(var_block, 'context').array_isset(rt.new_string('customOverlayTextColor')))) {
			var_attributes.array_get_mut('style').array_get_mut('color').array_set('text', rt.get_property(var_block,
				'context').array_get(rt.new_string('customOverlayTextColor')))
		}
		if rt.is_true(rt.new_bool(rt.get_property(var_block, 'context').array_isset(rt.new_string('customOverlayBackgroundColor')))) {
			var_attributes.array_get_mut('style').array_get_mut('color').array_set('background', rt.get_property(var_block,
				'context').array_get(rt.new_string('customOverlayBackgroundColor')))
		}
		rt.get_property(rt.get_property(var_block, 'block_type'), 'supports').array_set('color',
			true)
		var_colors_supports = rt.call_function('wp_apply_colors_support', [
			rt.get_property(var_block, 'block_type'),
			rt.create_array_from_native_map(var_attributes),
		])
		var_css_classes = 'wp-block-navigation__submenu-container'
		if rt.is_true(rt.new_bool(var_colors_supports.clone().array_isset(rt.new_string('class')))) {
			var_css_classes = var_css_classes + ' ' +
				(var_colors_supports.array_get(rt.new_string('class'))).str()
		}
		var_style_attribute = rt.new_string('')
		if rt.is_true(rt.new_bool(var_colors_supports.clone().array_isset(rt.new_string('style')))) {
			var_style_attribute = var_colors_supports.array_get(rt.new_string('style'))
		}
		if rt.is_true(rt.call_function('strpos', [rt.new_string(var_inner_blocks_html.str()).clone(),
			rt.new_string('current-menu-item')]))
		{
			var_tag_processor = create_wp_html_tag_processor(var_html.clone())
			for rt.is_true(var_tag_processor.next_tag(rt.create_array([rt.ArrayItem, {
				key: 'class_name'
				val: 'wp-block-navigation-item'
			}]))) {
				var_tag_processor.add_class(rt.new_string('current-menu-ancestor'))
			}
			var_html = var_tag_processor.get_updated_html()
		}
		var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
			rt.create_array([rt.ArrayItem{ key: 'class', val: var_css_classes },
				rt.ArrayItem{ key: 'style', val: var_style_attribute }]),
		])
		var_html = rt.concat(var_html, rt.call_function('sprintf', [
			rt.new_string('<ul %s>%s</ul>'),
			var_wrapper_attributes.clone(),
			rt.new_string(var_inner_blocks_html.str()).clone(),
		]))
	}
	var_html = rt.concat(var_html, rt.new_string('</li>'))
	return var_html.str()
}

fn register_block_core_navigation_submenu() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/navigation-submenu'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_navigation_submenu' },
		]),
	])
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_wp_html_tag_processor(_args ...rt.PhpVal) &Class_WP_HTML_Tag_Processor {
	mut obj := &Class_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('file_exists', [
		rt.new_string(@DIR + '/../navigation-link/shared/item-should-render.php'),
	]))
	{
		rt.include_file(@DIR + '/../navigation-link/shared/item-should-render.php', '4')
		rt.include_file(@DIR + '/../navigation-link/shared/render-submenu-icon.php', '4')
	} else {
		rt.include_file(@DIR + '/navigation-link/shared/item-should-render.php', '4')
		rt.include_file(@DIR + '/navigation-link/shared/render-submenu-icon.php', '4')
	}
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_navigation_submenu')])
}
