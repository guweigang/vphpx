import rt

fn block_core_navigation_submenu_get_submenu_visibility(var_context rt.PhpVal) string {
	mut var_deprecated_open_submenus_on_click := if !(var_context.array_get('openSubmenusOnClick')).is_null() { var_context.array_get('openSubmenusOnClick') } else { rt.new_null() }
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return if !(!rt.is_true(var_deprecated_open_submenus_on_click)) { 'click' } else { 'hover' }
	}
	mut var_submenu_visibility := if !(var_context.array_get('submenuVisibility')).is_null() { var_context.array_get('submenuVisibility') } else { rt.new_null() }
	return (if !(var_submenu_visibility).is_null() { var_submenu_visibility } else { rt.new_string('hover') }).str()
}

fn block_core_navigation_submenu_build_css_font_sizes(var_context rt.PhpVal) rt.PhpVal {
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

fn render_block_core_navigation_submenu(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('IS_GUTENBERG_PLUGIN')])) && rt.is_true(rt.get_constant('IS_GUTENBERG_PLUGIN')))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('gutenberg_block_core_shared_navigation_item_should_render', [var_attributes.dup(), var_block.dup()]))))) {
			return ''
		}
	}
	if !rt.is_true(var_attributes.array_get('label')) {
		return ''
	}
	mut var_font_sizes := block_core_navigation_submenu_build_css_font_sizes(rt.get_property(var_block, 'context'))
	mut var_style_attribute := var_font_sizes.array_get('inline_styles')
	mut var_inner_blocks_html := ''
	{
		mut iter_1 := rt.get_property(var_block, 'inner_blocks').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_inner_block := item_1.val
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	mut var_has_submenu := !(var_inner_blocks_html.trim_space() == '')
	mut var_kind := if !rt.is_true(var_attributes.array_get('kind')) { rt.new_string('post_type') } else { rt.call_function('str_replace', [rt.new_string('-'), rt.new_string('_'), var_attributes.array_get('kind')]) }
	mut var_is_active := rt.is_true(rt.new_bool(!(!rt.is_true(var_attributes.array_get('id'))) && rt.is_true(rt.identical(rt.call_function('get_queried_object_id', []rt.PhpVal{}), // unsupported expression: Expr_Cast_Int)))) && !(!rt.is_true(rt.get_property(rt.call_function('get_queried_object', []rt.PhpVal{}), '{"nodeType":"Expr_Variable","line":130,"name":"kind"}')))
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_post_type_archive', []rt.PhpVal{})) && !(!rt.is_true(var_attributes.array_get('url'))))) {
		mut var_queried_archive_link := rt.call_function('get_post_type_archive_link', [rt.get_property(rt.call_function('get_queried_object', []rt.PhpVal{}), 'name')])
		if rt.is_true(rt.identical(var_attributes.array_get('url'), var_queried_archive_link)) {
			var_is_active = true
		}
	}
	mut var_show_submenu_indicators := rt.get_property(var_block, 'context').array_isset(rt.new_string('showSubmenuIcon')) && rt.is_true(rt.get_property(var_block, 'context').array_get('showSubmenuIcon'))
	mut var_computed_visibility := block_core_navigation_submenu_get_submenu_visibility(rt.get_property(var_block, 'context'))
	mut var_open_on_click := (rt.identical(rt.new_string('click'), rt.new_string(var_computed_visibility))).to_bool()
	mut var_open_on_hover := (rt.identical(rt.new_string('hover'), rt.new_string(var_computed_visibility))).to_bool()
	mut var_open_on_hover_and_click := var_open_on_hover && var_show_submenu_indicators
	mut var_classes := rt.create_array([rt.ArrayItem{ key: none, val: 'wp-block-navigation-item' }])
	var_classes = rt.call_function('array_merge', [var_classes.dup(), var_font_sizes.array_get('css_classes')])
	if var_has_submenu {
		var_classes.array_push('has-child')
	}
	if var_open_on_click {
		var_classes.array_push('open-on-click')
	}
	if var_open_on_hover_and_click {
		var_classes.array_push('open-on-hover-click')
	}
	if rt.is_true(rt.identical(rt.new_string('always'), rt.new_string(var_computed_visibility))) {
		var_classes.array_push('open-always')
	}
	if var_is_active {
		var_classes.array_push('current-menu-item')
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [rt.create_array([rt.ArrayItem{ key: 'class', val: rt.call_function('implode', [rt.new_string(' '), var_classes.dup()]) }, rt.ArrayItem{ key: 'style', val: var_style_attribute }])])
	mut var_label := ''
	if var_attributes.array_isset(rt.new_string('label')) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_aria_label := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s submenu')]), rt.call_function('wp_strip_all_tags', [rt.new_string(var_label).dup()])])
	mut var_html := rt.new_string('<li ' + (var_wrapper_attributes).str() + '>')
	if !(var_open_on_click) {
		mut var_item_url := if !(var_attributes.array_get('url')).is_null() { var_attributes.array_get('url') } else { rt.new_string('') }
		// unsupported expression: Expr_AssignOp_Concat
		if !(!rt.is_true(var_item_url)) {
			// unsupported expression: Expr_AssignOp_Concat
		}
		if var_is_active {
			// unsupported expression: Expr_AssignOp_Concat
		}
		if rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('opensInNewTab')) && rt.is_true(rt.identical(rt.new_bool(true), var_attributes.array_get('opensInNewTab'))))) {
			// unsupported expression: Expr_AssignOp_Concat
		}
		if var_attributes.array_isset(rt.new_string('rel')) {
			// unsupported expression: Expr_AssignOp_Concat
		} else if rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('nofollow')) && rt.is_true(var_attributes.array_get('nofollow')))) {
			// unsupported expression: Expr_AssignOp_Concat
		}
		if var_attributes.array_isset(rt.new_string('title')) {
			// unsupported expression: Expr_AssignOp_Concat
		}
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		if !(!rt.is_true(var_attributes.array_get('description'))) {
			// unsupported expression: Expr_AssignOp_Concat
			// unsupported expression: Expr_AssignOp_Concat
			// unsupported expression: Expr_AssignOp_Concat
		}
		// unsupported expression: Expr_AssignOp_Concat
		if var_show_submenu_indicators && var_has_submenu {
			// unsupported expression: Expr_AssignOp_Concat
		}
	} else {
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		if !(!rt.is_true(var_attributes.array_get('description'))) {
			// unsupported expression: Expr_AssignOp_Concat
			// unsupported expression: Expr_AssignOp_Concat
			// unsupported expression: Expr_AssignOp_Concat
		}
		// unsupported expression: Expr_AssignOp_Concat
		if var_has_submenu {
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	if var_has_submenu {
		if rt.is_true(rt.new_bool(rt.get_property(var_block, 'context').array_isset(rt.new_string('overlayTextColor')))) {
			var_attributes['textColor'] = rt.get_property(var_block, 'context').array_get('overlayTextColor')
		}
		if rt.is_true(rt.new_bool(rt.get_property(var_block, 'context').array_isset(rt.new_string('overlayBackgroundColor')))) {
			var_attributes['backgroundColor'] = rt.get_property(var_block, 'context').array_get('overlayBackgroundColor')
		}
		if rt.is_true(rt.new_bool(rt.get_property(var_block, 'context').array_isset(rt.new_string('customOverlayTextColor')))) {
			var_attributes.array_get_mut('style').array_get_mut('color').array_set('text', rt.get_property(var_block, 'context').array_get('customOverlayTextColor'))
		}
		if rt.is_true(rt.new_bool(rt.get_property(var_block, 'context').array_isset(rt.new_string('customOverlayBackgroundColor')))) {
			var_attributes.array_get_mut('style').array_get_mut('color').array_set('background', rt.get_property(var_block, 'context').array_get('customOverlayBackgroundColor'))
		}
		rt.get_property(rt.get_property(var_block, 'block_type'), 'supports').array_set('color', true)
		mut var_colors_supports := rt.call_function('wp_apply_colors_support', [rt.get_property(var_block, 'block_type'), var_attributes.dup()])
		mut var_css_classes := 'wp-block-navigation__submenu-container'
		if rt.is_true(rt.new_bool(var_colors_supports.dup().array_isset(rt.new_string('class')))) {
			// unsupported expression: Expr_AssignOp_Concat
		}
		var_style_attribute = rt.new_string(rt.new_string(''))
		if rt.is_true(rt.new_bool(var_colors_supports.dup().array_isset(rt.new_string('style')))) {
			var_style_attribute = var_colors_supports.array_get('style')
		}
		if rt.is_true(rt.call_function('strpos', [rt.new_string(var_inner_blocks_html).dup(), rt.new_string('current-menu-item')])) {
			mut var_tag_processor := create_wp_html_tag_processor(var_html.dup())
			for rt.is_true(var_tag_processor.next_tag(rt.create_array([rt.ArrayItem{ key: 'class_name', val: 'wp-block-navigation-item' }]))) {
				var_tag_processor.add_class(rt.new_string('current-menu-ancestor'))
			}
			var_html = var_tag_processor.get_updated_html()
		}
		var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [rt.create_array([rt.ArrayItem{ key: 'class', val: var_css_classes }, rt.ArrayItem{ key: 'style', val: var_style_attribute }])])
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	return (var_html).str()
}

fn register_block_core_navigation_submenu() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/navigation-submenu', rt.create_array([rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_navigation_submenu' }])])
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_wp_html_tag_processor() &Class_WP_HTML_Tag_Processor {
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




pub fn init_wp_includes_blocks_navigation_submenu_php() {
	if rt.is_true(rt.call_function('file_exists', [@DIR + '/../navigation-link/shared/item-should-render.php'])) {
		rt.include_file(@DIR + '/../navigation-link/shared/item-should-render.php', '4')
		rt.include_file(@DIR + '/../navigation-link/shared/render-submenu-icon.php', '4')
	} else {
		rt.include_file(@DIR + '/navigation-link/shared/item-should-render.php', '4')
		rt.include_file(@DIR + '/navigation-link/shared/render-submenu-icon.php', '4')
	}
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('register_block_core_navigation_submenu')])
}
