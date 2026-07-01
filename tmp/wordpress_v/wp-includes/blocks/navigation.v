import rt

fn block_core_navigation_get_submenu_visibility(var_attributes rt.PhpVal) string {
	mut var_deprecated_open_submenus_on_click := if !(var_attributes.array_get('openSubmenusOnClick')).is_null() { var_attributes.array_get('openSubmenusOnClick') } else { rt.new_null() }
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return if !(!rt.is_true(var_deprecated_open_submenus_on_click)) { 'click' } else { 'hover' }
	}
	mut var_submenu_visibility := if !(var_attributes.array_get('submenuVisibility')).is_null() { var_attributes.array_get('submenuVisibility') } else { rt.new_null() }
	return (if !(var_submenu_visibility).is_null() { var_submenu_visibility } else { rt.new_string('hover') }).str()
}

struct Class_WP_Navigation_Block_Renderer {
	rt.PhpObjectBase
pub mut:
		has_submenus rt.PhpVal = rt.new_bool(false)
		needs_list_item_wrapper rt.PhpVal = rt.new_array()
		seen_menu_names rt.PhpVal = rt.new_array()
}

fn Class_WP_Navigation_Block_Renderer.is_responsive(var_attributes rt.PhpVal) bool {
	mut var_attributes_mutated := var_attributes
	mut var_has_old_responsive_attribute := rt.new_bool(rt.new_bool(!(!rt.is_true(var_attributes_mutated.array_get('isResponsive'))) && rt.is_true(var_attributes_mutated.array_get('isResponsive'))))
	return rt.is_true(rt.new_bool(var_attributes_mutated.array_isset(rt.new_string('overlayMenu')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) || rt.is_true(var_has_old_responsive_attribute)
}

fn Class_WP_Navigation_Block_Renderer.has_submenus(var_inner_blocks rt.PhpVal) rt.PhpVal {
	mut var_inner_blocks_mutated := var_inner_blocks
	if rt.is_true(rt.identical(rt.new_bool(true), // unsupported expression: Expr_StaticPropertyFetch)) {
		return // unsupported expression: Expr_StaticPropertyFetch
	}
	{
		mut iter_1 := var_inner_blocks_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_inner_block := item_1.val
			if rt.is_true(rt.identical(rt.new_string('core/page-list'), rt.get_property(var_inner_block, 'name'))) {
				mut var_all_pages := rt.call_function('get_pages', [rt.create_array([rt.ArrayItem{ key: 'sort_column', val: 'menu_order,post_title' }, rt.ArrayItem{ key: 'order', val: 'asc' }])])
				{
					mut iter_2 := rt.cast_array(var_all_pages).iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_page := item_2.val
						if rt.is_true(rt.get_property(var_page, 'post_parent')) {
							// unsupported assign target: Expr_StaticPropertyFetch
							break
						}
					}
				}
			}
			if rt.is_true(rt.identical(rt.new_string('core/navigation-submenu'), rt.get_property(var_inner_block, 'name'))) {
				// unsupported assign target: Expr_StaticPropertyFetch
				break
			}
		}
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn Class_WP_Navigation_Block_Renderer.is_interactive(var_attributes rt.PhpVal, var_inner_blocks rt.PhpVal) bool {
	mut var_attributes_mutated := var_attributes
	mut var_inner_blocks_mutated := var_inner_blocks
	mut var_has_submenus := Class_WP_Navigation_Block_Renderer.has_submenus(var_inner_blocks_mutated.dup())
	mut var_is_responsive_menu := Class_WP_Navigation_Block_Renderer.is_responsive(var_attributes_mutated.dup())
	mut var_computed_visibility := rt.new_string(rt.new_string(block_core_navigation_get_submenu_visibility(var_attributes_mutated.dup())))
	mut var_open_on_click := rt.identical(rt.new_string('click'), var_computed_visibility)
	mut var_show_submenu_icon := rt.new_bool(rt.new_bool(!(!rt.is_true(var_attributes_mutated.array_get('showSubmenuIcon')))))
	return rt.is_true(rt.new_bool(rt.is_true(var_has_submenus) && rt.is_true(rt.new_bool(rt.is_true(var_open_on_click) || rt.is_true(var_show_submenu_icon))))) || rt.is_true(var_is_responsive_menu)
}

fn Class_WP_Navigation_Block_Renderer.does_block_need_a_list_item_wrapper(var_block rt.PhpVal) rt.PhpVal {
	mut var_block_mutated := var_block
	mut var_needs_list_item_wrapper := rt.call_function('apply_filters', [rt.new_string('block_core_navigation_listable_blocks'), // unsupported expression: Expr_StaticPropertyFetch])
	return rt.call_function('in_array', [rt.get_property(var_block_mutated, 'name'), var_needs_list_item_wrapper.dup(), rt.new_bool(true)])
}

fn Class_WP_Navigation_Block_Renderer.get_markup_for_inner_block(var_inner_block rt.PhpVal) string {
	mut var_inner_block_content := rt.call_method(var_inner_block, 'render', []rt.PhpVal{})
	if !(!rt.is_true(var_inner_block_content)) {
		if rt.is_true(Class_WP_Navigation_Block_Renderer.does_block_need_a_list_item_wrapper(var_inner_block.dup())) {
			return '<li class="wp-block-navigation-item">' + (var_inner_block_content).str() + '</li>'
		}
	}
	return (var_inner_block_content).str()
}

fn Class_WP_Navigation_Block_Renderer.get_template_part_blocks_html(var_blocks rt.PhpVal) rt.PhpVal {
	mut var_blocks_mutated := var_blocks
	mut var_html := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := var_blocks_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block := item_1.val
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	return var_html.dup()
}

fn Class_WP_Navigation_Block_Renderer.get_inner_blocks_html(var_attributes rt.PhpVal, var_inner_blocks rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_inner_blocks_mutated := var_inner_blocks
	mut var_has_submenus := Class_WP_Navigation_Block_Renderer.has_submenus(var_inner_blocks_mutated.dup())
	mut var_is_interactive := Class_WP_Navigation_Block_Renderer.is_interactive(var_attributes_mutated.dup(), var_inner_blocks_mutated.dup())
	mut var_style := Class_WP_Navigation_Block_Renderer.get_styles(var_attributes_mutated.dup())
	mut var_class := Class_WP_Navigation_Block_Renderer.get_classes(var_attributes_mutated.dup())
	mut var_container_attributes := rt.call_function('get_block_wrapper_attributes', [rt.create_array([rt.ArrayItem{ key: 'class', val: 'wp-block-navigation__container ' + (var_class).str() }, rt.ArrayItem{ key: 'style', val: var_style }])])
	mut var_inner_blocks_html := rt.new_string(rt.new_string(''))
	mut var_is_list_open := rt.new_bool(rt.new_bool(false))
	{
		mut iter_1 := var_inner_blocks_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_inner_block := item_1.val
			mut var_inner_block_markup := Class_WP_Navigation_Block_Renderer.get_markup_for_inner_block(var_inner_block.dup())
			mut var_p := create_wp_html_tag_processor(var_inner_block_markup.dup())
			mut var_is_list_item := var_p.next_tag(rt.new_string('LI'))
			if rt.is_true(rt.new_bool(rt.is_true(var_is_list_item) && rt.is_true(rt.new_bool(!(rt.is_true(var_is_list_open)))))) {
				var_is_list_open = rt.new_bool(rt.new_bool(true))
				// unsupported expression: Expr_AssignOp_Concat
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_is_list_item)))) && rt.is_true(var_is_list_open))) {
				var_is_list_open = rt.new_bool(rt.new_bool(false))
				// unsupported expression: Expr_AssignOp_Concat
			}
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	if rt.is_true(var_is_list_open) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_has_submenus) && rt.is_true(var_is_interactive))) {
		mut var_tags := create_wp_html_tag_processor(var_inner_blocks_html.dup())
		var_inner_blocks_html = block_core_navigation_add_directives_to_submenu(var_tags, var_attributes_mutated.dup())
	}
	return var_inner_blocks_html.dup()
}

fn Class_WP_Navigation_Block_Renderer.get_inner_blocks_from_navigation_post(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_navigation_post := rt.call_function('get_post', [var_attributes_mutated.array_get('ref')])
	if !(!(var_navigation_post).is_null()) {
		return create_wp_block_list(rt.new_array(), var_attributes_mutated.dup())
	}
	if rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_navigation_post, 'post_status'))) {
		mut var_parsed_blocks := rt.call_function('parse_blocks', [rt.get_property(var_navigation_post, 'post_content')])
		mut var_blocks := block_core_navigation_filter_out_empty_blocks(var_parsed_blocks.dup())
		mut var_markup := rt.call_function('serialize_blocks', [var_blocks.dup()])
		var_markup = rt.call_function('apply_block_hooks_to_content_from_post_object', [var_markup.dup(), var_navigation_post.dup()])
		var_blocks = rt.call_function('parse_blocks', [var_markup.dup()])
		return create_wp_block_list(var_blocks.dup(), var_attributes_mutated.dup())
	}
	return rt.new_null()
}

fn Class_WP_Navigation_Block_Renderer.get_inner_blocks_from_fallback(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_fallback_blocks := block_core_navigation_get_fallback_blocks()
	if rt.is_true(rt.new_bool(!rt.is_true(var_fallback_blocks) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_fallback_blocks.dup().is_array()))))))) {
		return create_wp_block_list(rt.new_array(), var_attributes_mutated.dup())
	}
	return create_wp_block_list(var_fallback_blocks.dup(), var_attributes_mutated.dup())
}

fn Class_WP_Navigation_Block_Renderer.disable_overlay_menu_for_nested_navigation_blocks(var_blocks rt.PhpVal) rt.PhpVal {
	mut var_blocks_mutated := var_blocks
	if rt.is_true(rt.new_bool(!rt.is_true(var_blocks_mutated) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_blocks_mutated.dup().is_array()))))))) {
		return var_blocks_mutated.dup()
	}
	{
		mut iter_1 := var_blocks_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block := item_1.val
			if !(var_block.array_isset(rt.new_string('blockName'))) {
				continue
			}
			if rt.is_true(rt.identical(rt.new_string('core/navigation'), var_block.array_get('blockName'))) {
				if !(var_block.array_isset(rt.new_string('attrs'))) {
					var_block.array_set('attrs', rt.new_array())
				}
				var_block.array_get_mut('attrs').array_set('overlayMenu', 'never')
				var_block.array_get_mut('attrs').array_set('_isWithinOverlayTemplatePart', true)
			}
			if rt.is_true(rt.new_bool(!(!rt.is_true(var_block.array_get('innerBlocks'))) && rt.is_true(rt.new_bool(var_block.array_get('innerBlocks').is_array())))) {
				var_block.array_set('innerBlocks', Class_WP_Navigation_Block_Renderer.disable_overlay_menu_for_nested_navigation_blocks(var_block.array_get('innerBlocks')))
			}
		}
	}
	return var_blocks_mutated.dup()
}

fn Class_WP_Navigation_Block_Renderer.get_overlay_blocks_from_template_part(var_overlay_template_part_id rt.PhpVal, var_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	if rt.is_true(rt.new_bool(!rt.is_true(var_overlay_template_part_id) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_overlay_template_part_id.dup().is_string()))))))) {
		return create_wp_block_list(rt.new_array(), var_attributes_mutated.dup())
	}
	mut var_parts := rt.call_function('explode', [rt.new_string('//'), var_overlay_template_part_id.dup(), rt.new_int(2)])
	if var_parts.dup().array_count() == 2 {
		mut var_theme := var_parts.array_get(0)
		mut var_slug := var_parts.array_get(1)
	} else {
		var_theme = rt.call_function('get_stylesheet', []rt.PhpVal{})
		var_slug = var_overlay_template_part_id
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return create_wp_block_list(rt.new_array(), var_attributes_mutated.dup())
	}
	mut var_template_part_query := create_wp_query(rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'wp_template_part' }, rt.ArrayItem{ key: 'post_status', val: 'publish' }, rt.ArrayItem{ key: 'post_name__in', val: rt.create_array([rt.ArrayItem{ key: none, val: var_slug }]) }, rt.ArrayItem{ key: 'tax_query', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'wp_theme' }, rt.ArrayItem{ key: 'field', val: 'name' }, rt.ArrayItem{ key: 'terms', val: var_theme }]) }]) }, rt.ArrayItem{ key: 'posts_per_page', val: 1 }, rt.ArrayItem{ key: 'no_found_rows', val: true }, rt.ArrayItem{ key: 'lazy_load_term_meta', val: false }]))
	mut var_template_part_post := if rt.is_true(var_template_part_query.have_posts()) { var_template_part_query.next_post() } else { rt.new_null() }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_template_part_post)))) {
		mut var_full_template_part_id := rt.new_string((var_theme).str() + '//' + (var_slug).str())
		mut var_block_template := rt.call_function('get_block_file_template', [var_full_template_part_id.dup(), rt.new_string('wp_template_part')])
		if !(rt.get_property(var_block_template, 'content')).is_null() {
			mut var_content := rt.call_function('shortcode_unautop', [rt.get_property(var_block_template, 'content')])
			var_content = rt.call_function('do_shortcode', [var_content.dup()])
			mut var_parsed_blocks := rt.call_function('parse_blocks', [var_content.dup()])
			mut var_blocks := block_core_navigation_filter_out_empty_blocks(var_parsed_blocks.dup())
			var_blocks = Class_WP_Navigation_Block_Renderer.disable_overlay_menu_for_nested_navigation_blocks(var_blocks.dup())
			return create_wp_block_list(var_blocks.dup(), var_attributes_mutated.dup())
		}
		return create_wp_block_list(rt.new_array(), var_attributes_mutated.dup())
	}
	var_block_template = rt.call_function('_build_block_template_result_from_post', [var_template_part_post.dup()])
	if !(!(rt.get_property(var_block_template, 'content')).is_null()) {
		return create_wp_block_list(rt.new_array(), var_attributes_mutated.dup())
	}
	var_parsed_blocks = rt.call_function('parse_blocks', [rt.get_property(var_block_template, 'content')])
	var_blocks = block_core_navigation_filter_out_empty_blocks(var_parsed_blocks.dup())
	mut var_markup := rt.call_function('serialize_blocks', [var_blocks.dup()])
	var_markup = rt.call_function('apply_block_hooks_to_content_from_post_object', [var_markup.dup(), var_template_part_post.dup()])
	var_markup = rt.call_function('shortcode_unautop', [var_markup.dup()])
	var_markup = rt.call_function('do_shortcode', [var_markup.dup()])
	var_blocks = rt.call_function('parse_blocks', [.dup()])
	var_blocks = 
	return 
}

fn Class_WP_Navigation_Block_Renderer.get_inner_blocks(var_attributes rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_block_mutated := var_block
}

fn Class_WP_Navigation_Block_Renderer.get_navigation_name(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
}

fn Class_WP_Navigation_Block_Renderer.get_layout_class(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
}

fn Class_WP_Navigation_Block_Renderer.get_classes(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
}

fn Class_WP_Navigation_Block_Renderer.get_styles(var_attributes rt.PhpVal) string {
	mut var_attributes_mutated := var_attributes
}

fn Class_WP_Navigation_Block_Renderer.get_responsive_container_classes(var_is_hidden_by_default rt.PhpVal, var_has_custom_overlay rt.PhpVal, var_colors rt.PhpVal) rt.PhpVal {
	mut var_is_hidden_by_default_mutated := var_is_hidden_by_default
	mut var_has_custom_overlay_mutated := var_has_custom_overlay
	mut var_colors_mutated := var_colors
}

fn Class_WP_Navigation_Block_Renderer.get_overlay_inline_styles(var_has_custom_overlay rt.PhpVal, var_colors rt.PhpVal) string {
	mut var_has_custom_overlay_mutated := var_has_custom_overlay
	mut var_colors_mutated := var_colors
}

fn Class_WP_Navigation_Block_Renderer.get_responsive_container_markup(var_attributes rt.PhpVal, var_inner_blocks rt.PhpVal, var_inner_blocks_html rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_inner_blocks_mutated := var_inner_blocks
	mut var_inner_blocks_html_mutated := var_inner_blocks_html
}

fn Class_WP_Navigation_Block_Renderer.get_nav_attributes(var_attributes rt.PhpVal, var_inner_blocks rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_inner_blocks_mutated := var_inner_blocks
}

fn Class_WP_Navigation_Block_Renderer.get_nav_element_directives(var_is_interactive rt.PhpVal) string {
	mut var_is_interactive_mutated := var_is_interactive
}

fn Class_WP_Navigation_Block_Renderer.handle_view_script_module_loading(var_attributes rt.PhpVal, var_block rt.PhpVal, var_inner_blocks rt.PhpVal)  {
	mut var_attributes_mutated := var_attributes
	mut var_block_mutated := var_block
	mut var_inner_blocks_mutated := var_inner_blocks
}

fn Class_WP_Navigation_Block_Renderer.get_inner_block_markup(var_attributes rt.PhpVal, var_inner_blocks rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_inner_blocks_mutated := var_inner_blocks
}

fn Class_WP_Navigation_Block_Renderer.get_unique_navigation_name(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
}

fn Class_WP_Navigation_Block_Renderer.render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_attributes_mutated := var_attributes
	mut var_content_mutated := var_content
	mut var_block_mutated := var_block
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_WP_Block_List {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_wp_navigation_block_renderer() &Class_WP_Navigation_Block_Renderer {
	mut obj := &Class_WP_Navigation_Block_Renderer{
		PhpObjectBase: rt.PhpObjectBase{}
		has_submenus: rt.new_bool(false)
		needs_list_item_wrapper: rt.new_array()
		seen_menu_names: rt.new_array()
	}
	return obj
}

fn create_wp_html_tag_processor() &Class_WP_HTML_Tag_Processor {
	mut obj := &Class_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_list() &Class_WP_Block_List {
	mut obj := &Class_WP_Block_List{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_query() &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Navigation_Block_Renderer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_responsive' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Navigation_Block_Renderer.is_responsive(dispatch_arg_0))
		}
		'has_submenus' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Navigation_Block_Renderer.has_submenus(dispatch_arg_0)
		}
		'is_interactive' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Navigation_Block_Renderer.is_interactive(dispatch_arg_0, dispatch_arg_1))
		}
		'does_block_need_a_list_item_wrapper' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Navigation_Block_Renderer.does_block_need_a_list_item_wrapper(dispatch_arg_0)
		}
		'get_markup_for_inner_block' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WP_Navigation_Block_Renderer.get_markup_for_inner_block(dispatch_arg_0))
		}
		'get_template_part_blocks_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Navigation_Block_Renderer.get_template_part_blocks_html(dispatch_arg_0)
		}
		'get_inner_blocks_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Navigation_Block_Renderer.get_inner_blocks_html(dispatch_arg_0, dispatch_arg_1)
		}
		'get_inner_blocks_from_navigation_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Navigation_Block_Renderer.get_inner_blocks_from_navigation_post(dispatch_arg_0)
		}
		'get_inner_blocks_from_fallback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Navigation_Block_Renderer.get_inner_blocks_from_fallback(dispatch_arg_0)
		}
		'disable_overlay_menu_for_nested_navigation_blocks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Navigation_Block_Renderer.disable_overlay_menu_for_nested_navigation_blocks(dispatch_arg_0)
		}
		'get_overlay_blocks_from_template_part' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Navigation_Block_Renderer.get_overlay_blocks_from_template_part(dispatch_arg_0, dispatch_arg_1)
		}
		'get_inner_blocks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Navigation_Block_Renderer.get_inner_blocks(dispatch_arg_0, dispatch_arg_1)
		}
		'get_navigation_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Navigation_Block_Renderer.get_navigation_name(dispatch_arg_0)
		}
		'get_layout_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Navigation_Block_Renderer.get_layout_class(dispatch_arg_0)
		}
		'get_classes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Navigation_Block_Renderer.get_classes(dispatch_arg_0)
		}
		'get_styles' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WP_Navigation_Block_Renderer.get_styles(dispatch_arg_0))
		}
		'get_responsive_container_classes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WP_Navigation_Block_Renderer.get_responsive_container_classes(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_overlay_inline_styles' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_WP_Navigation_Block_Renderer.get_overlay_inline_styles(dispatch_arg_0, dispatch_arg_1))
		}
		'get_responsive_container_markup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WP_Navigation_Block_Renderer.get_responsive_container_markup(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_nav_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Navigation_Block_Renderer.get_nav_attributes(dispatch_arg_0, dispatch_arg_1)
		}
		'get_nav_element_directives' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WP_Navigation_Block_Renderer.get_nav_element_directives(dispatch_arg_0))
		}
		'handle_view_script_module_loading' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_WP_Navigation_Block_Renderer.handle_view_script_module_loading(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_inner_block_markup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Navigation_Block_Renderer.get_inner_block_markup(dispatch_arg_0, dispatch_arg_1)
		}
		'get_unique_navigation_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Navigation_Block_Renderer.get_unique_navigation_name(dispatch_arg_0)
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(Class_WP_Navigation_Block_Renderer.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		else { return none }
	}
}

fn (this &Class_WP_Navigation_Block_Renderer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'has_submenus' { return this.has_submenus }
		'needs_list_item_wrapper' { return this.needs_list_item_wrapper }
		'seen_menu_names' { return this.seen_menu_names }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Navigation_Block_Renderer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'has_submenus' { this.has_submenus = val; return true }
		'needs_list_item_wrapper' { this.needs_list_item_wrapper = val; return true }
		'seen_menu_names' { this.seen_menu_names = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_WP_Block_List) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_List) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_List) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_blocks_navigation_php() {
}
