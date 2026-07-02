import rt

fn block_core_page_list_get_submenu_visibility(var_context rt.PhpVal) string {
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

fn block_core_page_list_build_css_colors(var_attributes rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_colors := rt.new_null()
	mut var_has_named_text_color := false
	mut var_has_picked_text_color := false
	mut var_has_custom_text_color := rt.new_null()
	mut var_has_named_background_color := false
	mut var_has_picked_background_color := false
	mut var_has_custom_background_color := rt.new_null()
	mut var_has_named_overlay_text_color := false
	mut var_has_picked_overlay_text_color := false
	mut var_has_named_overlay_background_color := false
	mut var_has_picked_overlay_background_color := false
	var_colors = rt.create_array([
		rt.ArrayItem{ key: 'css_classes', val: rt.new_array() },
		rt.ArrayItem{ key: 'inline_styles', val: '' },
		rt.ArrayItem{ key: 'overlay_css_classes', val: rt.new_array() },
		rt.ArrayItem{ key: 'overlay_inline_styles', val: '' },
	])
	var_has_named_text_color =
		rt.create_array_from_native_map(var_context).array_isset(rt.new_string('textColor'))
	var_has_picked_text_color =
		rt.create_array_from_native_map(var_context).array_isset(rt.new_string('customTextColor'))
	var_has_custom_text_color =
		rt.new_bool(var_context.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_isset(rt.new_string('text')))
	if rt.is_true(var_has_custom_text_color) || var_has_picked_text_color
		|| var_has_named_text_color {
		var_colors.array_get_mut('css_classes').array_push('has-text-color')
	}
	if var_has_named_text_color {
		var_colors.array_get_mut('css_classes').array_push(rt.call_function('sprintf', [
			rt.new_string('has-%s-color'),
			rt.call_function('_wp_to_kebab_case', [
				var_context.array_get(rt.new_string('textColor')),
			]),
		]))
	} else if var_has_picked_text_color {
		var_colors.array_get(rt.new_string('inline_styles')) = rt.concat(var_colors.array_get(rt.new_string('inline_styles')), rt.call_function('sprintf', [
			rt.new_string('color: %s;'),
			var_context.array_get(rt.new_string('customTextColor')),
		]))
	} else if rt.is_true(var_has_custom_text_color) {
		var_colors.array_get(rt.new_string('inline_styles')) = rt.concat(var_colors.array_get(rt.new_string('inline_styles')), rt.call_function('sprintf', [
			rt.new_string('color: %s;'),
			var_context.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('text')),
		]))
	}
	var_has_named_background_color =
		rt.create_array_from_native_map(var_context).array_isset(rt.new_string('backgroundColor'))
	var_has_picked_background_color =
		rt.create_array_from_native_map(var_context).array_isset(rt.new_string('customBackgroundColor'))
	var_has_custom_background_color =
		rt.new_bool(var_context.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_isset(rt.new_string('background')))
	if rt.is_true(var_has_custom_background_color) || var_has_picked_background_color
		|| var_has_named_background_color {
		var_colors.array_get_mut('css_classes').array_push('has-background')
	}
	if var_has_named_background_color {
		var_colors.array_get_mut('css_classes').array_push(rt.call_function('sprintf', [
			rt.new_string('has-%s-background-color'),
			rt.call_function('_wp_to_kebab_case', [
				var_context.array_get(rt.new_string('backgroundColor')),
			]),
		]))
	} else if var_has_picked_background_color {
		var_colors.array_get(rt.new_string('inline_styles')) = rt.concat(var_colors.array_get(rt.new_string('inline_styles')), rt.call_function('sprintf', [
			rt.new_string('background-color: %s;'),
			var_context.array_get(rt.new_string('customBackgroundColor')),
		]))
	} else if rt.is_true(var_has_custom_background_color) {
		var_colors.array_get(rt.new_string('inline_styles')) = rt.concat(var_colors.array_get(rt.new_string('inline_styles')), rt.call_function('sprintf', [
			rt.new_string('background-color: %s;'),
			var_context.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('background')),
		]))
	}
	var_has_named_overlay_text_color =
		rt.create_array_from_native_map(var_context).array_isset(rt.new_string('overlayTextColor'))
	var_has_picked_overlay_text_color =
		rt.create_array_from_native_map(var_context).array_isset(rt.new_string('customOverlayTextColor'))
	if var_has_named_overlay_text_color || var_has_picked_overlay_text_color {
		var_colors.array_get_mut('overlay_css_classes').array_push('has-text-color')
	}
	if var_has_named_overlay_text_color {
		var_colors.array_get_mut('overlay_css_classes').array_push(rt.call_function('sprintf', [
			rt.new_string('has-%s-color'),
			rt.call_function('_wp_to_kebab_case', [
				var_context.array_get(rt.new_string('overlayTextColor')),
			]),
		]))
	} else if var_has_picked_overlay_text_color {
		var_colors.array_get(rt.new_string('overlay_inline_styles')) = rt.concat(var_colors.array_get(rt.new_string('overlay_inline_styles')), rt.call_function('sprintf', [
			rt.new_string('color: %s;'),
			var_context.array_get(rt.new_string('customOverlayTextColor')),
		]))
	}
	var_has_named_overlay_background_color =
		rt.create_array_from_native_map(var_context).array_isset(rt.new_string('overlayBackgroundColor'))
	var_has_picked_overlay_background_color =
		rt.create_array_from_native_map(var_context).array_isset(rt.new_string('customOverlayBackgroundColor'))
	if var_has_named_overlay_background_color || var_has_picked_overlay_background_color {
		var_colors.array_get_mut('overlay_css_classes').array_push('has-background')
	}
	if var_has_named_overlay_background_color {
		var_colors.array_get_mut('overlay_css_classes').array_push(rt.call_function('sprintf', [
			rt.new_string('has-%s-background-color'),
			rt.call_function('_wp_to_kebab_case', [
				var_context.array_get(rt.new_string('overlayBackgroundColor')),
			]),
		]))
	} else if var_has_picked_overlay_background_color {
		var_colors.array_get(rt.new_string('overlay_inline_styles')) = rt.concat(var_colors.array_get(rt.new_string('overlay_inline_styles')), rt.call_function('sprintf', [
			rt.new_string('background-color: %s;'),
			var_context.array_get(rt.new_string('customOverlayBackgroundColor')),
		]))
	}
	return var_colors.clone()
}

fn block_core_page_list_build_css_font_sizes(var_context rt.PhpVal) rt.PhpVal {
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

fn block_core_page_list_render_nested_page_list(var_submenu_visibility rt.PhpVal, var_show_submenu_icons rt.PhpVal, var_is_navigation_child rt.PhpVal, var_nested_pages rt.PhpVal, var_is_nested rt.PhpVal, var_active_page_ancestor_ids rt.PhpVal, var_colors rt.PhpVal, depth i64) string {
	mut var_depth := depth
	mut var_front_page_id := rt.new_null()
	mut var_markup := ''
	mut var_open_on_click := false
	mut var_open_on_hover := false
	mut var_open_always := false
	mut var_page := map[string]rt.PhpVal{}
	mut var_css_class := ''
	mut var_aria_current := ''
	mut var_style_attribute := rt.new_null()
	mut var_navigation_child_content_class := ''
	mut var_title := rt.new_null()
	mut var_aria_label := rt.new_null()
	if !rt.is_true(var_nested_pages) {
		return ''
	}
	var_front_page_id = rt.new_int((rt.call_function('get_option', [
		rt.new_string('page_on_front'),
	])).to_i64())
	var_markup = ''
	var_open_on_click = (rt.identical(rt.new_string('click'), var_submenu_visibility)).to_bool()
	var_open_on_hover = (rt.identical(rt.new_string('hover'), var_submenu_visibility)).to_bool()
	var_open_always = (rt.identical(rt.new_string('always'), var_submenu_visibility)).to_bool()
	mut iter_1 := rt.cast_array(var_nested_pages).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_page_shadow := item_1.val
		var_css_class = if rt.is_true(var_page_shadow['is_active']) {
			' current-menu-item'
		} else {
			''
		}
		var_aria_current = if rt.is_true(var_page_shadow['is_active']) {
			' aria-current="page"'
		} else {
			''
		}
		var_style_attribute = rt.new_string('')
		var_css_class = var_css_class +
			if rt.is_true(rt.call_function('in_array', [var_page_shadow['page_id'], var_active_page_ancestor_ids.clone(), rt.new_bool(true)])) { ' current-menu-ancestor' } else { '' }
		if var_page_shadow.array_isset(rt.new_string('children')) {
			var_css_class = var_css_class + ' has-child'
		}
		if rt.is_true(var_is_navigation_child) {
			var_css_class = var_css_class + ' wp-block-navigation-item'
			if var_open_on_click {
				var_css_class = var_css_class + ' open-on-click'
			} else if var_open_on_hover && rt.is_true(var_show_submenu_icons) {
				var_css_class = var_css_class + ' open-on-hover-click'
			} else if var_open_always {
				var_css_class = var_css_class + ' open-always'
			}
		}
		var_navigation_child_content_class = if rt.is_true(var_is_navigation_child) {
			' wp-block-navigation-item__content'
		} else {
			''
		}
		if (0 < depth && rt.is_true(rt.new_bool(!(rt.is_true(var_is_nested)))))
			|| rt.is_true(var_is_nested)
			&& var_colors.array_isset(rt.new_string('overlay_css_classes'))
			&& var_colors.array_isset(rt.new_string('overlay_inline_styles')) {
			var_css_class = var_css_class + ' ' +
				rt.call_function('implode', [rt.new_string(' '), var_colors.array_get(rt.new_string('overlay_css_classes'))]).to_string().trim_space()
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''),
				var_colors.array_get(rt.new_string('overlay_inline_styles'))))))
			{
				var_style_attribute = rt.call_function('sprintf', [
					rt.new_string(' style="%s"'),
					rt.call_function('esc_attr', [
						var_colors.array_get(rt.new_string('overlay_inline_styles')),
					]),
				])
			}
		}
		if rt.is_true(rt.identical(rt.new_int((var_page_shadow['page_id']).to_i64()),
			var_front_page_id))
		{
			var_css_class = var_css_class + ' menu-item-home'
		}
		var_title = if rt.is_true(var_page_shadow['title']) { var_page_shadow['title'] } else { rt.call_function('__', [
				rt.new_string('(no title)'),
			]) }
		var_aria_label = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s submenu')]),
			rt.call_function('wp_strip_all_tags', [var_title.clone()]),
		])
		var_markup = var_markup + '<li class="wp-block-pages-list__item' +
			(rt.call_function('esc_attr', [rt.new_string(var_css_class.str()).clone()])).str() +
			'"' + var_style_attribute.str() + '>'
		if var_page_shadow.array_isset(rt.new_string('children'))
			&& rt.is_true(var_is_navigation_child) && var_open_on_click {
			var_markup = var_markup + '<button aria-label="' +
				(rt.call_function('esc_attr', [var_aria_label.clone()])).str() + '" class="' +
				(rt.call_function('esc_attr', [rt.new_string(var_navigation_child_content_class.str()).clone()])).str() +
				' wp-block-navigation-submenu__toggle" aria-expanded="false">' +
				(rt.call_function('wp_kses_post', [var_title.clone()])).str() +
				'</button><span class="wp-block-page-list__submenu-icon wp-block-navigation__submenu-icon"><svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12" fill="none" aria-hidden="true" focusable="false"><path d="M1.50002 4L6.00002 8L10.5 4" stroke-width="1.5"></path></svg></span>'
		} else {
			var_markup = var_markup + '<a class="wp-block-pages-list__item__link' +
				(rt.call_function('esc_attr', [rt.new_string(var_navigation_child_content_class.str()).clone()])).str() +
				'" href="' + (rt.call_function('esc_url', [var_page_shadow['link']])).str() + '"' +
				var_aria_current + '>' +
				(rt.call_function('wp_kses_post', [var_title.clone()])).str() + '</a>'
		}
		if var_page_shadow.array_isset(rt.new_string('children')) {
			if rt.is_true(var_is_navigation_child) && rt.is_true(var_show_submenu_icons)
				&& !var_open_on_click {
				var_markup = var_markup + '<button aria-label="' +
					(rt.call_function('esc_attr', [var_aria_label.clone()])).str() +
					'" class="wp-block-navigation__submenu-icon wp-block-navigation-submenu__toggle" aria-expanded="false">'
				var_markup = var_markup +
					'<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12" fill="none" aria-hidden="true" focusable="false"><path d="M1.50002 4L6.00002 8L10.5 4" stroke-width="1.5"></path></svg>'
				var_markup = var_markup + '</button>'
			}
			var_markup = var_markup + '<ul class="wp-block-navigation__submenu-container">'
			var_markup = var_markup +
				block_core_page_list_render_nested_page_list(var_submenu_visibility.clone(), var_show_submenu_icons.clone(), var_is_navigation_child.clone(), var_page_shadow['children'], var_is_nested.clone(), var_active_page_ancestor_ids.clone(), var_colors.clone(), depth +
				1)
			var_markup = var_markup + '</ul>'
		}
		var_markup = var_markup + '</li>'
	}
	return var_markup
}

fn block_core_page_list_nest_pages(var_current_level rt.PhpVal, var_children rt.PhpVal) rt.PhpVal {
	mut var_current := rt.new_null()
	mut var_key := rt.new_null()
	if !rt.is_true(var_current_level) {
		return rt.new_null()
	}
	mut iter_2 := rt.cast_array(var_current_level).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_current_shadow := item_2.val
		mut var_key_shadow := item_2.key
		if var_children.array_isset(var_key_shadow) {
			var_current_level.array_get_mut(var_key_shadow).array_set('children', block_core_page_list_nest_pages(var_children.array_get(var_key_shadow),
				var_children.clone()))
		}
	}
	return var_current_level.clone()
}

fn render_block_core_page_list(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_block_id := rt.new_null()
	mut var_parent_page_id := rt.new_null()
	mut var_is_nested := rt.new_null()
	mut var_all_pages := rt.new_null()
	mut var_top_level_pages := rt.new_null()
	mut var_pages_with_children := rt.new_null()
	mut var_active_page_ancestor_ids := rt.new_null()
	mut var_page := map[string]rt.PhpVal{}
	mut var_is_active := false
	mut var_colors := rt.new_null()
	mut var_font_sizes := rt.new_null()
	mut var_classes := rt.new_null()
	mut var_style_attribute := rt.new_null()
	mut var_css_classes := ''
	mut var_nested_pages := rt.new_null()
	mut var_is_navigation_child := false
	mut var_submenu_visibility := ''
	mut var_show_submenu_icons := rt.new_null()
	mut var_wrapper_markup := ''
	mut var_items_markup := ''
	mut var_wrapper_attributes := rt.new_null()
	rt.pre_inc(var_block_id)
	var_parent_page_id = var_attributes.array_get(rt.new_string('parentPageID'))
	var_is_nested = var_attributes.array_get(rt.new_string('isNested'))
	var_all_pages = rt.call_function('get_pages', [
		rt.create_array([
			rt.ArrayItem{ key: 'sort_column', val: 'menu_order,post_title' },
			rt.ArrayItem{ key: 'order', val: 'asc' },
		]),
	])
	if !rt.is_true(var_all_pages) {
		return rt.new_null()
	}
	var_top_level_pages = rt.new_array()
	var_pages_with_children = rt.new_array()
	var_active_page_ancestor_ids = rt.new_array()
	mut iter_3 := rt.cast_array(var_all_pages).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_page_shadow := item_3.val
		var_is_active = !(!rt.is_true(rt.get_property(var_page_shadow, 'ID')))
			&& rt.is_true(rt.identical(rt.call_function('get_queried_object_id', []rt.PhpVal{}), rt.get_property(var_page_shadow, 'ID')))
		if var_is_active {
			var_active_page_ancestor_ids = rt.call_function('get_post_ancestors', [
				rt.get_property(var_page_shadow, 'ID'),
			])
		}
		if rt.is_true(rt.get_property(var_page_shadow, 'post_parent')) {
			var_pages_with_children.array_get_mut(rt.get_property(var_page_shadow, 'post_parent')).array_set(rt.get_property(var_page_shadow,
				'ID'), rt.create_array([
				rt.ArrayItem{ key: 'page_id', val: rt.get_property(var_page_shadow, 'ID') },
				rt.ArrayItem{ key: 'title', val: rt.get_property(var_page_shadow, 'post_title') },
				rt.ArrayItem{ key: 'link', val: rt.call_function('get_permalink', [
					var_page_shadow.clone(),
				]) },
				rt.ArrayItem{ key: 'is_active', val: var_is_active },
			]))
		} else {
			var_top_level_pages.array_set(rt.get_property(var_page_shadow, 'ID'), rt.create_array([
				rt.ArrayItem{ key: 'page_id', val: rt.get_property(var_page_shadow, 'ID') },
				rt.ArrayItem{ key: 'title', val: rt.get_property(var_page_shadow, 'post_title') },
				rt.ArrayItem{ key: 'link', val: rt.call_function('get_permalink', [
					var_page_shadow.clone(),
				]) },
				rt.ArrayItem{ key: 'is_active', val: var_is_active },
			]))
		}
	}
	var_colors = block_core_page_list_build_css_colors(rt.create_array_from_native_map(var_attributes), rt.get_property(var_block,
		'context'))
	var_font_sizes =
		block_core_page_list_build_css_font_sizes(rt.get_property(var_block, 'context'))
	var_classes = rt.call_function('array_merge', [
		var_colors.array_get(rt.new_string('css_classes')),
		var_font_sizes.array_get(rt.new_string('css_classes')),
	])
	var_style_attribute = rt.new_string(
		(var_colors.array_get(rt.new_string('inline_styles'))).str() +
		(var_font_sizes.array_get(rt.new_string('inline_styles'))).str())
	var_css_classes = rt.call_function('implode', [rt.new_string(' '),
		var_classes.clone()]).to_string().trim_space()
	var_nested_pages = block_core_page_list_nest_pages(var_top_level_pages.clone(),
		var_pages_with_children.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_parent_page_id)))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_pages_with_children.clone().array_isset(var_parent_page_id.clone())))))) {
			return rt.new_null()
		}
		var_nested_pages = block_core_page_list_nest_pages(var_pages_with_children.array_get(var_parent_page_id),
			var_pages_with_children.clone())
	}
	var_is_navigation_child =
		rt.get_property(var_block, 'context').array_isset(rt.new_string('showSubmenuIcon'))
	var_submenu_visibility = if var_is_navigation_child {
		block_core_page_list_get_submenu_visibility(rt.get_property(var_block, 'context'))
	} else {
		'hover'
	}
	var_show_submenu_icons = if rt.is_true(rt.new_bool(rt.get_property(var_block, 'context').array_isset(rt.new_string('showSubmenuIcon')))) {
		rt.get_property(var_block, 'context').array_get(rt.new_string('showSubmenuIcon'))
	} else {
		rt.new_bool(false)
	}
	var_wrapper_markup = if rt.is_true(var_is_nested) { '%2$s' } else { '<ul %1$s>%2$s</ul>' }
	var_items_markup = block_core_page_list_render_nested_page_list(var_submenu_visibility,
		var_show_submenu_icons.clone(), var_is_navigation_child, var_nested_pages.clone(),
		var_is_nested.clone(), var_active_page_ancestor_ids.clone(), var_colors.clone())
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([rt.ArrayItem{ key: 'class', val: var_css_classes },
			rt.ArrayItem{ key: 'style', val: var_style_attribute }]),
	])
	return rt.call_function('sprintf', [rt.new_string(var_wrapper_markup.str()).clone(),
		var_wrapper_attributes.clone(), rt.new_string(var_items_markup.str()).clone()])
}

fn register_block_core_page_list() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/page-list'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_page_list' },
		]),
	])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_page_list')])
}
