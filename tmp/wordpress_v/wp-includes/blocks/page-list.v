import rt

fn block_core_page_list_get_submenu_visibility(var_context rt.PhpVal) string {
	mut var_deprecated_open_submenus_on_click := if !(var_context.array_get('openSubmenusOnClick')).is_null() { var_context.array_get('openSubmenusOnClick') } else { rt.new_null() }
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return if !(!rt.is_true(var_deprecated_open_submenus_on_click)) { 'click' } else { 'hover' }
	}
	mut var_submenu_visibility := if !(var_context.array_get('submenuVisibility')).is_null() { var_context.array_get('submenuVisibility') } else { rt.new_null() }
	return (if !(var_submenu_visibility).is_null() { var_submenu_visibility } else { rt.new_string('hover') }).str()
}

fn block_core_page_list_build_css_colors(var_attributes rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_colors := rt.create_array([rt.ArrayItem{ key: 'css_classes', val: rt.new_array() }, rt.ArrayItem{ key: 'inline_styles', val: '' }, rt.ArrayItem{ key: 'overlay_css_classes', val: rt.new_array() }, rt.ArrayItem{ key: 'overlay_inline_styles', val: '' }])
	mut var_has_named_text_color := var_context.dup().array_isset(rt.new_string('textColor'))
	mut var_has_picked_text_color := var_context.dup().array_isset(rt.new_string('customTextColor'))
	mut var_has_custom_text_color := rt.new_bool(var_context.array_get('style').array_get('color').array_isset(rt.new_string('text')))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_has_custom_text_color) || var_has_picked_text_color)) || var_has_named_text_color)) {
		var_colors.array_get_mut('css_classes').array_push('has-text-color')
	}
	if var_has_named_text_color {
		var_colors.array_get_mut('css_classes').array_push(rt.call_function('sprintf', [rt.new_string('has-%s-color'), rt.call_function('_wp_to_kebab_case', [var_context.array_get('textColor')])]))
	} else if var_has_picked_text_color {
		// unsupported expression: Expr_AssignOp_Concat
	} else if rt.is_true(var_has_custom_text_color) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_has_named_background_color := var_context.dup().array_isset(rt.new_string('backgroundColor'))
	mut var_has_picked_background_color := var_context.dup().array_isset(rt.new_string('customBackgroundColor'))
	mut var_has_custom_background_color := rt.new_bool(var_context.array_get('style').array_get('color').array_isset(rt.new_string('background')))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_has_custom_background_color) || var_has_picked_background_color)) || var_has_named_background_color)) {
		var_colors.array_get_mut('css_classes').array_push('has-background')
	}
	if var_has_named_background_color {
		var_colors.array_get_mut('css_classes').array_push(rt.call_function('sprintf', [rt.new_string('has-%s-background-color'), rt.call_function('_wp_to_kebab_case', [var_context.array_get('backgroundColor')])]))
	} else if var_has_picked_background_color {
		// unsupported expression: Expr_AssignOp_Concat
	} else if rt.is_true(var_has_custom_background_color) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_has_named_overlay_text_color := var_context.dup().array_isset(rt.new_string('overlayTextColor'))
	mut var_has_picked_overlay_text_color := var_context.dup().array_isset(rt.new_string('customOverlayTextColor'))
	if var_has_named_overlay_text_color || var_has_picked_overlay_text_color {
		var_colors.array_get_mut('overlay_css_classes').array_push('has-text-color')
	}
	if var_has_named_overlay_text_color {
		var_colors.array_get_mut('overlay_css_classes').array_push(rt.call_function('sprintf', [rt.new_string('has-%s-color'), rt.call_function('_wp_to_kebab_case', [var_context.array_get('overlayTextColor')])]))
	} else if var_has_picked_overlay_text_color {
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_has_named_overlay_background_color := var_context.dup().array_isset(rt.new_string('overlayBackgroundColor'))
	mut var_has_picked_overlay_background_color := var_context.dup().array_isset(rt.new_string('customOverlayBackgroundColor'))
	if var_has_named_overlay_background_color || var_has_picked_overlay_background_color {
		var_colors.array_get_mut('overlay_css_classes').array_push('has-background')
	}
	if var_has_named_overlay_background_color {
		var_colors.array_get_mut('overlay_css_classes').array_push(rt.call_function('sprintf', [rt.new_string('has-%s-background-color'), rt.call_function('_wp_to_kebab_case', [var_context.array_get('overlayBackgroundColor')])]))
	} else if var_has_picked_overlay_background_color {
		// unsupported expression: Expr_AssignOp_Concat
	}
	return var_colors.dup()
}

fn block_core_page_list_build_css_font_sizes(var_context rt.PhpVal) rt.PhpVal {
	mut var_font_sizes := rt.create_array([rt.ArrayItem{ key: 'css_classes', val: rt.new_array() }, rt.ArrayItem{ key: 'inline_styles', val: '' }])
	mut var_has_named_font_size := var_context.dup().array_isset(rt.new_string('fontSize'))
	mut var_has_custom_font_size := rt.new_bool(var_context.array_get('style').array_get('typography').array_isset(rt.new_string('fontSize')))
	if var_has_named_font_size {
		var_font_sizes.array_get_mut('css_classes').array_push(rt.call_function('sprintf', [rt.new_string('has-%s-font-size'), var_context.array_get('fontSize')]))
	} else if rt.is_true(var_has_custom_font_size) {
		var_font_sizes.array_set('inline_styles', rt.call_function('sprintf', [rt.new_string('font-size: %s;'), rt.call_function('wp_get_typography_font_size_value', [rt.create_array([rt.ArrayItem{ key: 'size', val: var_context.array_get('style').array_get('typography').array_get('fontSize') }])])]))
	}
	return var_font_sizes.dup()
}

fn block_core_page_list_render_nested_page_list(var_submenu_visibility rt.PhpVal, var_show_submenu_icons rt.PhpVal, var_is_navigation_child rt.PhpVal, var_nested_pages rt.PhpVal, var_is_nested rt.PhpVal, var_active_page_ancestor_ids rt.PhpVal, var_colors rt.PhpVal, depth i64) string {
	if !rt.is_true(var_nested_pages) {
		return ''
	}
	mut var_front_page_id := // unsupported expression: Expr_Cast_Int
	mut var_markup := ''
	mut var_open_on_click := (rt.identical(rt.new_string('click'), var_submenu_visibility)).to_bool()
	mut var_open_on_hover := (rt.identical(rt.new_string('hover'), var_submenu_visibility)).to_bool()
	mut var_open_always := (rt.identical(rt.new_string('always'), var_submenu_visibility)).to_bool()
	{
		mut iter_1 := rt.cast_array(var_nested_pages).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_page := item_1.val
			mut var_css_class := if rt.is_true(var_page.array_get('is_active')) { ' current-menu-item' } else { '' }
			mut var_aria_current := if rt.is_true(var_page.array_get('is_active')) { ' aria-current="page"' } else { '' }
			mut var_style_attribute := rt.new_string(rt.new_string(''))
			// unsupported expression: Expr_AssignOp_Concat
			if var_page.array_isset(rt.new_string('children')) {
				// unsupported expression: Expr_AssignOp_Concat
			}
			if rt.is_true(var_is_navigation_child) {
				// unsupported expression: Expr_AssignOp_Concat
				if var_open_on_click {
					// unsupported expression: Expr_AssignOp_Concat
				} else if rt.is_true(rt.new_bool(var_open_on_hover && rt.is_true(var_show_submenu_icons))) {
					// unsupported expression: Expr_AssignOp_Concat
				} else if var_open_always {
					// unsupported expression: Expr_AssignOp_Concat
				}
			}
			mut var_navigation_child_content_class := if rt.is_true(var_is_navigation_child) { ' wp-block-navigation-item__content' } else { '' }
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(0 < depth && rt.is_true(rt.new_bool(!(rt.is_true(var_is_nested)))))) || rt.is_true(var_is_nested))) && var_colors.array_isset(rt.new_string('overlay_css_classes')) && var_colors.array_isset(rt.new_string('overlay_inline_styles')))) {
				// unsupported expression: Expr_AssignOp_Concat
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					var_style_attribute = rt.call_function('sprintf', [rt.new_string(' style="%s"'), rt.call_function('esc_attr', [var_colors.array_get('overlay_inline_styles')])])
				}
			}
			if rt.is_true(rt.identical(// unsupported expression: Expr_Cast_Int, var_front_page_id)) {
				// unsupported expression: Expr_AssignOp_Concat
			}
			mut var_title := if rt.is_true(var_page.array_get('title')) { var_page.array_get('title') } else { rt.call_function('__', [rt.new_string('(no title)')]) }
			mut var_aria_label := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s submenu')]), rt.call_function('wp_strip_all_tags', [var_title.dup()])])
			// unsupported expression: Expr_AssignOp_Concat
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_page.array_isset(rt.new_string('children')) && rt.is_true(var_is_navigation_child))) && var_open_on_click)) {
				// unsupported expression: Expr_AssignOp_Concat
			} else {
				// unsupported expression: Expr_AssignOp_Concat
			}
			if var_page.array_isset(rt.new_string('children')) {
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_is_navigation_child) && rt.is_true(var_show_submenu_icons))) && !(var_open_on_click))) {
					// unsupported expression: Expr_AssignOp_Concat
					// unsupported expression: Expr_AssignOp_Concat
					// unsupported expression: Expr_AssignOp_Concat
				}
				// unsupported expression: Expr_AssignOp_Concat
				// unsupported expression: Expr_AssignOp_Concat
				// unsupported expression: Expr_AssignOp_Concat
			}
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	return var_markup
}

fn block_core_page_list_nest_pages(var_current_level rt.PhpVal, var_children rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_current_level) {
		return rt.new_null()
	}
	{
		mut iter_1 := rt.cast_array(var_current_level).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_current := item_1.val
			mut var_key := item_1.key
			if var_children.array_isset(var_key) {
				var_current_level.array_get_mut(var_key).array_set('children', block_core_page_list_nest_pages(var_children.array_get(var_key), var_children.dup()))
			}
		}
	}
	return var_current_level.dup()
}

fn render_block_core_page_list(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_block_id := rt.new_null()
	// unsupported statement: Stmt_Static
	rt.pre_inc(var_block_id)
	mut var_parent_page_id := var_attributes.array_get('parentPageID')
	mut var_is_nested := var_attributes.array_get('isNested')
	mut var_all_pages := rt.call_function('get_pages', [rt.create_array([rt.ArrayItem{ key: 'sort_column', val: 'menu_order,post_title' }, rt.ArrayItem{ key: 'order', val: 'asc' }])])
	if !rt.is_true(var_all_pages) {
		return rt.new_null()
	}
	mut var_top_level_pages := rt.new_array()
	mut var_pages_with_children := rt.new_array()
	mut var_active_page_ancestor_ids := rt.new_array()
	{
		mut iter_1 := rt.cast_array(var_all_pages).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_page := item_1.val
			mut var_is_active := !(!rt.is_true(rt.get_property(var_page, 'ID'))) && rt.is_true(rt.identical(rt.call_function('get_queried_object_id', []rt.PhpVal{}), rt.get_property(var_page, 'ID')))
			if var_is_active {
				var_active_page_ancestor_ids = rt.call_function('get_post_ancestors', [rt.get_property(var_page, 'ID')])
			}
			if rt.is_true(rt.get_property(var_page, 'post_parent')) {
				var_pages_with_children.array_get_mut(rt.get_property(var_page, 'post_parent')).array_set(rt.get_property(var_page, 'ID'), rt.create_array([rt.ArrayItem{ key: 'page_id', val: rt.get_property(var_page, 'ID') }, rt.ArrayItem{ key: 'title', val: rt.get_property(var_page, 'post_title') }, rt.ArrayItem{ key: 'link', val: rt.call_function('get_permalink', [var_page.dup()]) }, rt.ArrayItem{ key: 'is_active', val: var_is_active }]))
			} else {
				var_top_level_pages.array_set(rt.get_property(var_page, 'ID'), rt.create_array([rt.ArrayItem{ key: 'page_id', val: rt.get_property(var_page, 'ID') }, rt.ArrayItem{ key: 'title', val: rt.get_property(var_page, 'post_title') }, rt.ArrayItem{ key: 'link', val: rt.call_function('get_permalink', [var_page.dup()]) }, rt.ArrayItem{ key: 'is_active', val: var_is_active }]))
			}
		}
	}
	mut var_colors := block_core_page_list_build_css_colors(var_attributes.dup(), rt.get_property(var_block, 'context'))
	mut var_font_sizes := block_core_page_list_build_css_font_sizes(rt.get_property(var_block, 'context'))
	mut var_classes := rt.call_function('array_merge', [var_colors.array_get('css_classes'), var_font_sizes.array_get('css_classes')])
	mut var_style_attribute := rt.new_string(rt.concat(.array_get(), .array_get()))
	mut var_css_classes := .to_string().trim_space()
	mut var_nested_pages := 
	if rt.is_true() {
	}
	
}



pub fn init_wp_includes_blocks_page_list_php() {
}
