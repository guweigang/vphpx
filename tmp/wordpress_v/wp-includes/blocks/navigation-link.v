import rt

fn block_core_navigation_link_build_css_colors(var_context rt.PhpVal, var_attributes rt.PhpVal, is_sub_menu bool) rt.PhpVal {
	mut var_colors := { 'css_classes': map[string]rt.PhpVal{}, 'inline_styles': rt.new_string('') }
	mut var_named_text_color := rt.new_null()
	mut var_custom_text_color := rt.new_null()
	if rt.is_true(rt.new_bool(var_is_sub_menu && rt.is_true(rt.new_bool(var_context.dup().array_isset(rt.new_string('customOverlayTextColor')))))) {
		var_custom_text_color = var_context.array_get('customOverlayTextColor')
	} else if rt.is_true(rt.new_bool(var_is_sub_menu && rt.is_true(rt.new_bool(var_context.dup().array_isset(rt.new_string('overlayTextColor')))))) {
		var_named_text_color = var_context.array_get('overlayTextColor')
	} else if rt.is_true(rt.new_bool(var_context.dup().array_isset(rt.new_string('customTextColor')))) {
		var_custom_text_color = var_context.array_get('customTextColor')
	} else if rt.is_true(rt.new_bool(var_context.dup().array_isset(rt.new_string('textColor')))) {
		var_named_text_color = var_context.array_get('textColor')
	} else if var_context.array_get('style').array_get('color').array_isset(rt.new_string('text')) {
		var_custom_text_color = var_context.array_get('style').array_get('color').array_get('text')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_named_text_color.dup().is_null()))))) {
		var_colors.array_get('css_classes').array_push(rt.new_string('has-text-color'))
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_custom_text_color.dup().is_null()))))) {
		var_colors.array_get_mut('css_classes').array_push('has-text-color')
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_named_background_color := rt.new_null()
	mut var_custom_background_color := rt.new_null()
	if rt.is_true(rt.new_bool(var_is_sub_menu && rt.is_true(rt.new_bool(var_context.dup().array_isset(rt.new_string('customOverlayBackgroundColor')))))) {
		var_custom_background_color = var_context.array_get('customOverlayBackgroundColor')
	} else if rt.is_true(rt.new_bool(var_is_sub_menu && rt.is_true(rt.new_bool(var_context.dup().array_isset(rt.new_string('overlayBackgroundColor')))))) {
		var_named_background_color = var_context.array_get('overlayBackgroundColor')
	} else if rt.is_true(rt.new_bool(var_context.dup().array_isset(rt.new_string('customBackgroundColor')))) {
		var_custom_background_color = var_context.array_get('customBackgroundColor')
	} else if rt.is_true(rt.new_bool(var_context.dup().array_isset(rt.new_string('backgroundColor')))) {
		var_named_background_color = var_context.array_get('backgroundColor')
	} else if var_context.array_get('style').array_get('color').array_isset(rt.new_string('background')) {
		var_custom_background_color = var_context.array_get('style').array_get('color').array_get('background')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_named_background_color.dup().is_null()))))) {
		var_colors.array_get('css_classes').array_push(rt.new_string('has-background'))
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_custom_background_color.dup().is_null()))))) {
		var_colors.array_get_mut('css_classes').array_push('has-background')
		// unsupported expression: Expr_AssignOp_Concat
	}
	return var_colors.dup()
}

fn block_core_navigation_link_build_css_font_sizes(var_context rt.PhpVal) rt.PhpVal {
	mut var_font_sizes := rt.create_array([rt.ArrayItem{ key: 'css_classes', val: map[string]rt.PhpVal{} }, rt.ArrayItem{ key: 'inline_styles', val: '' }])
	mut var_has_named_font_size := var_context.dup().array_isset(rt.new_string('fontSize'))
	mut var_has_custom_font_size := rt.new_bool(var_context.array_get('style').array_get('typography').array_isset(rt.new_string('fontSize')))
	if var_has_named_font_size {
		var_font_sizes.array_get_mut('css_classes').array_push(rt.call_function('sprintf', [rt.new_string('has-%s-font-size'), var_context.array_get('fontSize')]))
	} else if rt.is_true(var_has_custom_font_size) {
		var_font_sizes.array_set('inline_styles', rt.call_function('sprintf', [rt.new_string('font-size: %s;'), rt.call_function('wp_get_typography_font_size_value', [rt.create_array([rt.ArrayItem{ key: 'size', val: var_context.array_get('style').array_get('typography').array_get('fontSize') }])])]))
	}
	return var_font_sizes.dup()
}

fn block_core_navigation_link_maybe_urldecode(var_url rt.PhpVal) rt.PhpVal {
	mut var_is_url_encoded := false
	mut var_query := rt.call_function('parse_url', [var_url.dup(), rt.get_constant('PHP_URL_QUERY')])
	mut var_query_params := rt.call_function('wp_parse_args', [var_query.dup()])
	{
		mut iter_1 := var_query_params.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_query_param := item_1.val
			mut var_can_query_param_be_encoded := rt.is_true(rt.new_bool(var_query_param.dup().is_string())) && !(!rt.is_true(var_query_param))
			if !(var_can_query_param_be_encoded) {
				continue
			}
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				var_is_url_encoded = true
				break
			}
		}
	}
	if var_is_url_encoded {
		return rt.call_function('rawurldecode', [var_url.dup()])
	}
	return var_url.dup()
}

fn render_block_core_navigation_link(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('IS_GUTENBERG_PLUGIN')])) && rt.is_true(rt.get_constant('IS_GUTENBERG_PLUGIN')))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('gutenberg_block_core_shared_navigation_item_should_render', [var_attributes.dup(), var_block.dup()]))))) {
			return ''
		}
	}
	if !rt.is_true(var_attributes.array_get('label')) {
		return ''
	}
	mut var_font_sizes := block_core_navigation_link_build_css_font_sizes(rt.get_property(var_block, 'context'))
	mut var_classes := rt.call_function('array_merge', [var_font_sizes.array_get('css_classes')])
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
	mut var_css_classes := rt.call_function('implode', [rt.new_string(' '), var_classes.dup()]).to_string().trim_space()
	mut var_kind := if !rt.is_true(var_attributes.array_get('kind')) { rt.new_string('post_type') } else { rt.call_function('str_replace', [rt.new_string('-'), rt.new_string('_'), var_attributes.array_get('kind')]) }
	mut var_is_active := rt.is_true(rt.new_bool(!(!rt.is_true(var_attributes.array_get('id'))) && rt.is_true(rt.identical(rt.call_function('get_queried_object_id', []rt.PhpVal{}), // unsupported expression: Expr_Cast_Int)))) && !(!rt.is_true(rt.get_property(rt.call_function('get_queried_object', []rt.PhpVal{}), '{"nodeType":"Expr_Variable","line":198,"name":"kind"}')))
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_post_type_archive', []rt.PhpVal{})) && !(!rt.is_true(var_attributes.array_get('url'))))) {
		mut var_queried_archive_link := rt.call_function('get_post_type_archive_link', [rt.get_property(rt.call_function('get_queried_object', []rt.PhpVal{}), 'name')])
		if rt.is_true(rt.identical(var_attributes.array_get('url'), var_queried_archive_link)) {
			var_is_active = true
		}
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [rt.create_array([rt.ArrayItem{ key: 'class', val: var_css_classes + ' wp-block-navigation-item' + if var_has_submenu { ' has-child' } else { '' } + if var_is_active { ' current-menu-item' } else { '' } }, rt.ArrayItem{ key: 'style', val: var_style_attribute }])])
	mut var_html := rt.new_string('<li ' + (var_wrapper_attributes).str() + '>' + '<a class="wp-block-navigation-item__content" ')
	if var_attributes.array_isset(rt.new_string('url')) {
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
	if var_attributes.array_isset(rt.new_string('label')) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	if !(!rt.is_true(var_attributes.array_get('description'))) {
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.get_property(var_block, 'context').array_isset(rt.new_string('showSubmenuIcon')) && rt.is_true(rt.get_property(var_block, 'context').array_get('showSubmenuIcon')))) && var_has_submenu)) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if var_has_submenu {
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	return (var_html).str()
}

fn build_variation_for_navigation_link(var_entity rt.PhpVal, kind string) rt.PhpVal {
	mut var_title := rt.new_string(rt.new_string(''))
	mut var_description := rt.new_string(rt.new_string(''))
	mut var_default_labels := rt.new_null()
	if rt.is_true(rt.new_bool(rt.instance_of(var_entity, 'WP_Post_Type'))) {
		var_default_labels = fn () rt.PhpVal { mut temp := Class_WP_Post_Type{}; return temp.get_default_labels() }()
	} else if rt.is_true(rt.new_bool(rt.instance_of(var_entity, 'WP_Taxonomy'))) {
		var_default_labels = fn () rt.PhpVal { mut temp := Class_WP_Taxonomy{}; return temp.get_default_labels() }()
	}
	mut var_is_default_title := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.call_function('property_exists', [rt.get_property(var_entity, 'labels'), rt.new_string('item_link')])) {
		var_title = rt.get_property(rt.get_property(var_entity, 'labels'), 'item_link')
		if var_default_labels.array_isset(rt.new_string('item_link')) {
			var_is_default_title = rt.call_function('in_array', [var_title.dup(), var_default_labels.array_get('item_link'), rt.new_bool(true)])
		}
	}
	mut var_is_default_description := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.call_function('property_exists', [rt.get_property(var_entity, 'labels'), rt.new_string('item_link_description')])) {
		var_description = rt.get_property(rt.get_property(var_entity, 'labels'), 'item_link_description')
		if var_default_labels.array_isset(rt.new_string('item_link_description')) {
			var_is_default_description = rt.call_function('in_array', [var_description.dup(), var_default_labels.array_get('item_link_description'), rt.new_bool(true)])
		}
	}
	mut var_singular := if !(rt.get_property(rt.get_property(var_entity, 'labels'), 'singular_name')).is_null() { rt.get_property(rt.get_property(var_entity, 'labels'), 'singular_name') } else { rt.call_function('ucfirst', [rt.get_property(var_entity, 'name')]) }
	if rt.is_true(rt.new_bool(rt.is_true(var_is_default_title) || rt.is_true(rt.identical(rt.new_string(''), var_title)))) {
		var_title = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s link')]), var_singular.dup()])
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_is_default_description) || rt.is_true(rt.identical(rt.new_string(''), var_description)))) {
		var_description = rt.new_string(rt.new_string(' '))
	}
	mut var_variation := rt.create_array([rt.ArrayItem{ key: 'name', val: rt.get_property(var_entity, 'name') }, rt.ArrayItem{ key: 'title', val: var_title }, rt.ArrayItem{ key: 'description', val: var_description }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([rt.ArrayItem{ key: 'type', val: rt.get_property(var_entity, 'name') }, rt.ArrayItem{ key: 'kind', val: kind }]) }])
	mut var_variation_overrides := rt.create_array([rt.ArrayItem{ key: 'post_tag', val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'tag' }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }]) }]) }, rt.ArrayItem{ key: 'post_format', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', []) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', []) }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }]) }]) }])
	if rt.is_true(rt.new_bool(var_variation_overrides.dup().array_isset(rt.get_property(var_entity, 'name')))) {
		var_variation = rt.call_function('array_merge', [.dup(), ])
	}
	return var_variation.dup()
}

fn block_core_navigation_link_filter_variations(var_variations rt.PhpVal, var_block_type rt.PhpVal) rt.PhpVal {
	if rt.is_true() {
	}
	
}

struct Class_WP_Post_Type {
	rt.PhpObjectBase
}

struct Class_WP_Taxonomy {
	rt.PhpObjectBase
}

fn create_wp_post_type() &Class_WP_Post_Type {
	mut obj := &Class_WP_Post_Type{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_taxonomy() &Class_WP_Taxonomy {
	mut obj := &Class_WP_Taxonomy{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Post_Type) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Post_Type) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Post_Type) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Taxonomy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Taxonomy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Taxonomy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_blocks_navigation_link_php() {
	if rt.is_true(rt.call_function('file_exists', [@DIR + '/shared/item-should-render.php'])) {
		rt.include_file(@DIR + '/shared/item-should-render.php', '4')
		rt.include_file(@DIR + '/shared/render-submenu-icon.php', '4')
	} else {
		rt.include_file(@DIR + '/navigation-link/shared/item-should-render.php', '4')
		rt.include_file(@DIR + '/navigation-link/shared/render-submenu-icon.php', '4')
	}
}
