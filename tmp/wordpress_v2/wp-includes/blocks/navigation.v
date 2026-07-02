import rt

fn block_core_navigation_get_submenu_visibility(var_attributes rt.PhpVal) string {
	mut var_deprecated_open_submenus_on_click := rt.new_null()
	mut var_submenu_visibility := rt.new_null()
	var_deprecated_open_submenus_on_click = if !(var_attributes.array_get(rt.new_string('openSubmenusOnClick'))).is_null() {
		var_attributes.array_get(rt.new_string('openSubmenusOnClick'))
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(),
		var_deprecated_open_submenus_on_click))))
	{
		return if !(!rt.is_true(var_deprecated_open_submenus_on_click)) { 'click' } else { 'hover' }
	}
	var_submenu_visibility = if !(var_attributes.array_get(rt.new_string('submenuVisibility'))).is_null() {
		var_attributes.array_get(rt.new_string('submenuVisibility'))
	} else {
		rt.new_null()
	}
	return (if !var_submenu_visibility.is_null() {
		var_submenu_visibility
	} else {
		rt.new_string('hover')
	}).str()
}

struct Class_WP_Navigation_Block_Renderer {
	rt.PhpObjectBase
}

fn init_static_wp_navigation_block_renderer() {
	rt.init_static_prop('WP_Navigation_Block_Renderer', 'has_submenus', rt.new_bool(false))
	rt.init_static_prop('WP_Navigation_Block_Renderer', 'needs_list_item_wrapper', rt.create_array([
		rt.ArrayItem{ key: none, val: 'core/site-title' },
		rt.ArrayItem{ key: none, val: 'core/site-logo' },
		rt.ArrayItem{ key: none, val: 'core/social-links' },
	]))
	rt.init_static_prop('WP_Navigation_Block_Renderer', 'seen_menu_names', rt.new_array())
}

fn Class_WP_Navigation_Block_Renderer.is_responsive(var_attributes rt.PhpVal) bool {
	mut var_attributes_mutated := var_attributes
	mut var_has_old_responsive_attribute := rt.new_bool(
		!(!rt.is_true(var_attributes_mutated.array_get(rt.new_string('isResponsive'))))
		&& rt.is_true(var_attributes_mutated.array_get(rt.new_string('isResponsive'))))
	return var_attributes_mutated.array_isset(rt.new_string('overlayMenu'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('never'), var_attributes_mutated.array_get(rt.new_string('overlayMenu'))))))
		|| rt.is_true(var_has_old_responsive_attribute)
}

fn Class_WP_Navigation_Block_Renderer.has_submenus(var_inner_blocks rt.PhpVal) rt.PhpVal {
	mut var_inner_blocks_mutated := var_inner_blocks
	if rt.is_true(rt.identical(rt.new_bool(true), rt.get_static_prop('WP_Navigation_Block_Renderer',
		'has_submenus')))
	{
		return rt.get_static_prop('WP_Navigation_Block_Renderer', 'has_submenus')
	}
	mut iter_1 := var_inner_blocks_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_inner_block := item_1.val
		if rt.is_true(rt.identical(rt.new_string('core/page-list'), rt.get_property(var_inner_block,
			'name')))
		{
			mut var_all_pages := rt.call_function('get_pages', [
				rt.create_array([
					rt.ArrayItem{ key: 'sort_column', val: 'menu_order,post_title' },
					rt.ArrayItem{ key: 'order', val: 'asc' },
				]),
			])
			mut iter_2 := rt.cast_array(var_all_pages).iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_page := item_2.val
				if rt.is_true(rt.get_property(var_page, 'post_parent')) {
					rt.set_static_prop('WP_Navigation_Block_Renderer', 'has_submenus',
						rt.new_bool(true))
					break
				}
			}
		}
		if rt.is_true(rt.identical(rt.new_string('core/navigation-submenu'), rt.get_property(var_inner_block,
			'name')))
		{
			rt.set_static_prop('WP_Navigation_Block_Renderer', 'has_submenus', rt.new_bool(true))
			break
		}
	}
	return rt.get_static_prop('WP_Navigation_Block_Renderer', 'has_submenus')
}

fn Class_WP_Navigation_Block_Renderer.is_interactive(var_attributes rt.PhpVal, var_inner_blocks rt.PhpVal) bool {
	mut var_attributes_mutated := var_attributes
	mut var_inner_blocks_mutated := var_inner_blocks
	mut var_has_submenus :=
		Class_WP_Navigation_Block_Renderer.has_submenus(var_inner_blocks_mutated.clone())
	mut var_is_responsive_menu :=
		Class_WP_Navigation_Block_Renderer.is_responsive(var_attributes_mutated.clone())
	mut var_computed_visibility :=
		rt.new_string(block_core_navigation_get_submenu_visibility(var_attributes_mutated.clone()))
	mut var_open_on_click := rt.identical(rt.new_string('click'), var_computed_visibility)
	mut var_show_submenu_icon :=
		rt.new_bool(!(!rt.is_true(var_attributes_mutated.array_get(rt.new_string('showSubmenuIcon')))))
	return rt.is_true(var_has_submenus) && rt.is_true(var_open_on_click)
		|| rt.is_true(var_show_submenu_icon) || rt.is_true(var_is_responsive_menu)
}

fn Class_WP_Navigation_Block_Renderer.does_block_need_a_list_item_wrapper(var_block rt.PhpVal) rt.PhpVal {
	mut var_block_mutated := var_block
	mut var_needs_list_item_wrapper := rt.call_function('apply_filters', [
		rt.new_string('block_core_navigation_listable_blocks'),
		rt.get_static_prop('WP_Navigation_Block_Renderer', 'needs_list_item_wrapper'),
	])
	return rt.call_function('in_array', [rt.get_property(var_block_mutated, 'name'),
		var_needs_list_item_wrapper.clone(), rt.new_bool(true)])
}

fn Class_WP_Navigation_Block_Renderer.get_markup_for_inner_block(var_inner_block rt.PhpVal) string {
	mut var_inner_block_content := rt.call_method(var_inner_block, 'render', []rt.PhpVal{})
	if !(!rt.is_true(var_inner_block_content)) {
		if rt.is_true(Class_WP_Navigation_Block_Renderer.does_block_need_a_list_item_wrapper(var_inner_block.clone())) {
			return '<li class="wp-block-navigation-item">' + var_inner_block_content.str() + '</li>'
		}
	}
	return var_inner_block_content.str()
}

fn Class_WP_Navigation_Block_Renderer.get_template_part_blocks_html(var_blocks rt.PhpVal) rt.PhpVal {
	mut var_blocks_mutated := var_blocks
	mut var_html := rt.new_string('')
	mut iter_3 := var_blocks_mutated.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_block := item_3.val
		var_html = rt.concat(var_html, rt.call_method(var_block, 'render', []rt.PhpVal{}))
	}
	return var_html.clone()
}

fn Class_WP_Navigation_Block_Renderer.get_inner_blocks_html(var_attributes rt.PhpVal, var_inner_blocks rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_inner_blocks_mutated := var_inner_blocks
	mut var_has_submenus :=
		Class_WP_Navigation_Block_Renderer.has_submenus(var_inner_blocks_mutated.clone())
	mut var_is_interactive := Class_WP_Navigation_Block_Renderer.is_interactive(var_attributes_mutated.clone(),
		var_inner_blocks_mutated.clone())
	mut var_style := Class_WP_Navigation_Block_Renderer.get_styles(var_attributes_mutated.clone())
	mut var_class := Class_WP_Navigation_Block_Renderer.get_classes(var_attributes_mutated.clone())
	mut var_container_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'class', val: 'wp-block-navigation__container ' + var_class.str() },
			rt.ArrayItem{ key: 'style', val: var_style },
		]),
	])
	mut var_inner_blocks_html := rt.new_string('')
	mut var_is_list_open := rt.new_bool(false)
	mut iter_4 := var_inner_blocks_mutated.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_inner_block := item_4.val
		mut var_inner_block_markup :=
			Class_WP_Navigation_Block_Renderer.get_markup_for_inner_block(var_inner_block.clone())
		mut var_p := create_wp_html_tag_processor(var_inner_block_markup.clone())
		mut var_is_list_item := var_p.next_tag(rt.new_string('LI'))
		if rt.is_true(var_is_list_item) && rt.is_true(rt.new_bool(!(rt.is_true(var_is_list_open)))) {
			var_is_list_open = rt.new_bool(true)
			var_inner_blocks_html = rt.concat(var_inner_blocks_html, rt.call_function('sprintf', [
				rt.new_string('<ul %1$s>'),
				var_container_attributes.clone(),
			]))
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_is_list_item)))) && rt.is_true(var_is_list_open) {
			var_is_list_open = rt.new_bool(false)
			var_inner_blocks_html = rt.concat(var_inner_blocks_html, rt.new_string('</ul>'))
		}
		var_inner_blocks_html = rt.concat(var_inner_blocks_html, var_inner_block_markup)
	}
	if rt.is_true(var_is_list_open) {
		var_inner_blocks_html = rt.concat(var_inner_blocks_html, rt.new_string('</ul>'))
	}
	if rt.is_true(var_has_submenus) && rt.is_true(var_is_interactive) {
		mut var_tags := create_wp_html_tag_processor(var_inner_blocks_html.clone())
		var_inner_blocks_html = block_core_navigation_add_directives_to_submenu(var_tags,
			var_attributes_mutated.clone())
	}
	return var_inner_blocks_html.clone()
}

fn Class_WP_Navigation_Block_Renderer.get_inner_blocks_from_navigation_post(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_navigation_post := rt.call_function('get_post', [
		var_attributes_mutated.array_get(rt.new_string('ref')),
	])
	if !(!var_navigation_post.is_null()) {
		return rt.new_object('WP_Block_List', []string{}, create_wp_block_list(rt.new_array(),
			var_attributes_mutated.clone()))
	}
	if rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_navigation_post,
		'post_status')))
	{
		mut var_parsed_blocks := rt.call_function('parse_blocks', [
			rt.get_property(var_navigation_post, 'post_content'),
		])
		mut var_blocks := block_core_navigation_filter_out_empty_blocks(var_parsed_blocks.clone())
		mut var_markup := rt.call_function('serialize_blocks', [
			var_blocks.clone()])
		var_markup = rt.call_function('apply_block_hooks_to_content_from_post_object', [
			var_markup.clone(),
			var_navigation_post.clone(),
		])
		var_blocks = rt.call_function('parse_blocks', [var_markup.clone()])
		return rt.new_object('WP_Block_List', []string{}, create_wp_block_list(var_blocks.clone(),
			var_attributes_mutated.clone()))
	}
	return rt.new_null()
}

fn Class_WP_Navigation_Block_Renderer.get_inner_blocks_from_fallback(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_fallback_blocks := block_core_navigation_get_fallback_blocks()
	if !rt.is_true(var_fallback_blocks) || !(var_fallback_blocks.clone().is_array()) {
		return rt.new_object('WP_Block_List', []string{}, create_wp_block_list(rt.new_array(),
			var_attributes_mutated.clone()))
	}
	return rt.new_object('WP_Block_List', []string{}, create_wp_block_list(var_fallback_blocks.clone(),
		var_attributes_mutated.clone()))
}

fn Class_WP_Navigation_Block_Renderer.disable_overlay_menu_for_nested_navigation_blocks(var_blocks rt.PhpVal) rt.PhpVal {
	mut var_blocks_mutated := var_blocks
	if !rt.is_true(var_blocks_mutated) || !(var_blocks_mutated.clone().is_array()) {
		return var_blocks_mutated.clone()
	}
	mut iter_5 := var_blocks_mutated.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_block := item_5.val
		if !(var_block.array_isset(rt.new_string('blockName'))) {
			continue
		}
		if rt.is_true(rt.identical(rt.new_string('core/navigation'),
			var_block.array_get(rt.new_string('blockName'))))
		{
			if !(var_block.array_isset(rt.new_string('attrs'))) {
				var_block.array_set('attrs', rt.new_array())
			}
			var_block.array_get_mut('attrs').array_set('overlayMenu', 'never')
			var_block.array_get_mut('attrs').array_set('_isWithinOverlayTemplatePart', true)
		}
		if !(!rt.is_true(var_block.array_get(rt.new_string('innerBlocks'))))
			&& var_block.array_get(rt.new_string('innerBlocks')).is_array() {
			var_block.array_set('innerBlocks',
				Class_WP_Navigation_Block_Renderer.disable_overlay_menu_for_nested_navigation_blocks(var_block.array_get(rt.new_string('innerBlocks'))))
		}
	}
	return var_blocks_mutated.clone()
}

fn Class_WP_Navigation_Block_Renderer.get_overlay_blocks_from_template_part(var_overlay_template_part_id rt.PhpVal, var_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	if !rt.is_true(var_overlay_template_part_id)
		|| !(var_overlay_template_part_id.clone().is_string()) {
		return rt.new_object('WP_Block_List', []string{}, create_wp_block_list(rt.new_array(),
			var_attributes_mutated.clone()))
	}
	mut var_parts := rt.call_function('explode', [rt.new_string('//'),
		var_overlay_template_part_id.clone(), rt.new_int(2)])
	if var_parts.clone().array_count() == 2 {
		mut var_theme := var_parts.array_get(rt.new_int(0))
		mut var_slug := var_parts.array_get(rt.new_int(1))
	} else {
		var_theme = rt.call_function('get_stylesheet', []rt.PhpVal{})
		var_slug = var_overlay_template_part_id
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_stylesheet',
		[]rt.PhpVal{}), var_theme))))
	{
		return rt.new_object('WP_Block_List', []string{}, create_wp_block_list(rt.new_array(),
			var_attributes_mutated.clone()))
	}
	mut var_template_part_query := create_wp_query(rt.create_array([
		rt.ArrayItem{ key: 'post_type', val: 'wp_template_part' },
		rt.ArrayItem{ key: 'post_status', val: 'publish' },
		rt.ArrayItem{ key: 'post_name__in', val: rt.create_array([
			rt.ArrayItem{ key: none, val: var_slug },
		]) },
		rt.ArrayItem{ key: 'tax_query', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'taxonomy', val: 'wp_theme' },
				rt.ArrayItem{ key: 'field', val: 'name' },
				rt.ArrayItem{ key: 'terms', val: var_theme },
			]) },
		]) },
		rt.ArrayItem{ key: 'posts_per_page', val: 1 },
		rt.ArrayItem{ key: 'no_found_rows', val: true },
		rt.ArrayItem{ key: 'lazy_load_term_meta', val: false },
	]))
	mut var_template_part_post := if rt.is_true(var_template_part_query.have_posts()) {
		var_template_part_query.next_post()
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_template_part_post)))) {
		mut var_full_template_part_id := rt.new_string(var_theme.str() + '//' + var_slug.str())
		mut var_block_template := rt.call_function('get_block_file_template', [
			var_full_template_part_id.clone(),
			rt.new_string('wp_template_part'),
		])
		if !(rt.get_property(var_block_template, 'content')).is_null() {
			mut var_content := rt.call_function('shortcode_unautop', [
				rt.get_property(var_block_template, 'content'),
			])
			var_content = rt.call_function('do_shortcode', [var_content.clone()])
			mut var_parsed_blocks := rt.call_function('parse_blocks', [
				var_content.clone()])
			mut var_blocks :=
				block_core_navigation_filter_out_empty_blocks(var_parsed_blocks.clone())
			var_blocks =
				Class_WP_Navigation_Block_Renderer.disable_overlay_menu_for_nested_navigation_blocks(var_blocks.clone())
			return rt.new_object('WP_Block_List', []string{}, create_wp_block_list(var_blocks.clone(),
				var_attributes_mutated.clone()))
		}
		return rt.new_object('WP_Block_List', []string{}, create_wp_block_list(rt.new_array(),
			var_attributes_mutated.clone()))
	}
	var_block_template = rt.call_function('_build_block_template_result_from_post', [
		var_template_part_post.clone(),
	])
	if !(!(rt.get_property(var_block_template, 'content')).is_null()) {
		return rt.new_object('WP_Block_List', []string{}, create_wp_block_list(rt.new_array(),
			var_attributes_mutated.clone()))
	}
	var_parsed_blocks = rt.call_function('parse_blocks', [
		rt.get_property(var_block_template, 'content'),
	])
	var_blocks = block_core_navigation_filter_out_empty_blocks(var_parsed_blocks.clone())
	mut var_markup := rt.call_function('serialize_blocks', [var_blocks.clone()])
	var_markup = rt.call_function('apply_block_hooks_to_content_from_post_object', [
		var_markup.clone(),
		var_template_part_post.clone(),
	])
	var_markup = rt.call_function('shortcode_unautop', [var_markup.clone()])
	var_markup = rt.call_function('do_shortcode', [var_markup.clone()])
	var_blocks = rt.call_function('parse_blocks', [var_markup.clone()])
	var_blocks =
		Class_WP_Navigation_Block_Renderer.disable_overlay_menu_for_nested_navigation_blocks(var_blocks.clone())
	return rt.new_object('WP_Block_List', []string{}, create_wp_block_list(var_blocks.clone(),
		var_attributes_mutated.clone()))
}

fn Class_WP_Navigation_Block_Renderer.get_inner_blocks(var_attributes rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_block_mutated := var_block
	mut var_inner_blocks := rt.get_property(var_block_mutated, 'inner_blocks')
	if rt.is_true(rt.new_bool(var_attributes_mutated.clone().array_isset(rt.new_string('navigationMenuId')))) {
		var_attributes_mutated.array_set('ref',
			var_attributes_mutated.array_get(rt.new_string('navigationMenuId')))
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('IS_GUTENBERG_PLUGIN')]))
		&& rt.is_true(rt.get_constant('IS_GUTENBERG_PLUGIN'))
		&& rt.is_true(rt.new_bool(var_attributes_mutated.clone().array_isset(rt.new_string('__unstableLocation'))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_attributes_mutated.clone().array_isset(rt.new_string('ref')))))))
		&& !(!rt.is_true(block_core_navigation_get_menu_items_at_location(var_attributes_mutated.array_get(rt.new_string('__unstableLocation'))))) {
		var_inner_blocks =
			block_core_navigation_get_inner_blocks_from_unstable_location(var_attributes_mutated.clone())
	}
	if rt.is_true(rt.new_bool(var_attributes_mutated.clone().array_isset(rt.new_string('ref')))) {
		var_inner_blocks =
			Class_WP_Navigation_Block_Renderer.get_inner_blocks_from_navigation_post(var_attributes_mutated.clone())
	}
	if !rt.is_true(var_inner_blocks) {
		var_inner_blocks =
			Class_WP_Navigation_Block_Renderer.get_inner_blocks_from_fallback(var_attributes_mutated.clone())
	}
	var_inner_blocks = rt.call_function('apply_filters', [
		rt.new_string('block_core_navigation_render_inner_blocks'),
		var_inner_blocks.clone(),
	])
	mut var_post_ids := block_core_navigation_get_post_ids(var_inner_blocks.clone())
	if rt.is_true(var_post_ids) {
		rt.call_function('_prime_post_caches', [var_post_ids.clone(),
			rt.new_bool(false), rt.new_bool(false)])
	}
	return var_inner_blocks.clone()
}

fn Class_WP_Navigation_Block_Renderer.get_navigation_name(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_navigation_name := if !(var_attributes_mutated.array_get(rt.new_string('ariaLabel'))).is_null() {
		var_attributes_mutated.array_get(rt.new_string('ariaLabel'))
	} else {
		rt.new_string('')
	}
	if !(!rt.is_true(var_navigation_name)) {
		return var_navigation_name.clone()
	}
	if rt.is_true(rt.new_bool(var_attributes_mutated.clone().array_isset(rt.new_string('ref')))) {
		mut var_navigation_post := rt.call_function('get_post', [
			var_attributes_mutated.array_get(rt.new_string('ref')),
		])
		if !(!var_navigation_post.is_null()) {
			return var_navigation_name.clone()
		}
		if rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_navigation_post,
			'post_status')))
		{
			return rt.get_property(var_navigation_post, 'post_title')
		}
	}
	return var_navigation_name.clone()
}

fn Class_WP_Navigation_Block_Renderer.get_layout_class(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_layout_justification := rt.create_array([
		rt.ArrayItem{ key: 'left', val: 'items-justified-left' },
		rt.ArrayItem{ key: 'right', val: 'items-justified-right' },
		rt.ArrayItem{ key: 'center', val: 'items-justified-center' },
		rt.ArrayItem{ key: 'space-between', val: 'items-justified-space-between' },
	])
	mut var_layout_class := rt.new_string('')
	if var_attributes_mutated.array_get(rt.new_string('layout')).array_isset(rt.new_string('justifyContent'))
		&& var_layout_justification.array_isset(var_attributes_mutated.array_get(rt.new_string('layout')).array_get(rt.new_string('justifyContent'))) {
		var_layout_class = rt.concat(var_layout_class,
			var_layout_justification.array_get(var_attributes_mutated.array_get(rt.new_string('layout')).array_get(rt.new_string('justifyContent'))))
	}
	if var_attributes_mutated.array_get(rt.new_string('layout')).array_isset(rt.new_string('orientation'))
		&& rt.is_true(rt.identical(rt.new_string('vertical'), var_attributes_mutated.array_get(rt.new_string('layout')).array_get(rt.new_string('orientation')))) {
		var_layout_class = rt.concat(var_layout_class, rt.new_string(' is-vertical'))
	}
	if var_attributes_mutated.array_get(rt.new_string('layout')).array_isset(rt.new_string('flexWrap'))
		&& rt.is_true(rt.identical(rt.new_string('nowrap'), var_attributes_mutated.array_get(rt.new_string('layout')).array_get(rt.new_string('flexWrap')))) {
		var_layout_class = rt.concat(var_layout_class, rt.new_string(' no-wrap'))
	}
	return var_layout_class.clone()
}

fn Class_WP_Navigation_Block_Renderer.get_classes(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_layout_class :=
		Class_WP_Navigation_Block_Renderer.get_layout_class(var_attributes_mutated.clone())
	mut var_colors := block_core_navigation_build_css_colors(var_attributes_mutated.clone())
	mut var_font_sizes := block_core_navigation_build_css_font_sizes(var_attributes_mutated.clone())
	mut var_is_responsive_menu :=
		Class_WP_Navigation_Block_Renderer.is_responsive(var_attributes_mutated.clone())
	mut var_text_decoration := if !(var_attributes_mutated.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('textDecoration'))).is_null() {
		var_attributes_mutated.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('textDecoration'))
	} else {
		rt.new_null()
	}
	mut var_text_decoration_class := rt.call_function('sprintf', [
		rt.new_string('has-text-decoration-%s'),
		var_text_decoration.clone(),
	])
	mut var_classes := rt.call_function('array_merge', [
		var_colors.array_get(rt.new_string('css_classes')),
		var_font_sizes.array_get(rt.new_string('css_classes')),
		if rt.is_true(var_is_responsive_menu) { rt.create_array([
				rt.ArrayItem{ key: none, val: 'is-responsive' },
			]) } else { rt.new_array() },
		if rt.is_true(var_layout_class) { rt.create_array([
				rt.ArrayItem{ key: none, val: var_layout_class },
			]) } else { rt.new_array() },
		if rt.is_true(var_text_decoration) { rt.create_array([
				rt.ArrayItem{ key: none, val: var_text_decoration_class },
			]) } else { rt.new_array() },
	])
	return rt.call_function('implode', [rt.new_string(' '), var_classes.clone()])
}

fn Class_WP_Navigation_Block_Renderer.get_styles(var_attributes rt.PhpVal) string {
	mut var_attributes_mutated := var_attributes
	mut var_colors := block_core_navigation_build_css_colors(var_attributes_mutated.clone())
	mut var_font_sizes := block_core_navigation_build_css_font_sizes(var_attributes_mutated.clone())
	mut var_block_styles := if !(var_attributes_mutated.array_get(rt.new_string('styles'))).is_null() {
		var_attributes_mutated.array_get(rt.new_string('styles'))
	} else {
		rt.new_string('')
	}
	return var_block_styles.str() +(var_colors.array_get(rt.new_string('inline_styles'))).str() +
		(var_font_sizes.array_get(rt.new_string('inline_styles'))).str()
}

fn Class_WP_Navigation_Block_Renderer.get_responsive_container_classes(var_is_hidden_by_default rt.PhpVal, var_has_custom_overlay rt.PhpVal, var_colors rt.PhpVal) rt.PhpVal {
	mut var_is_hidden_by_default_mutated := var_is_hidden_by_default
	mut var_has_custom_overlay_mutated := var_has_custom_overlay
	mut var_colors_mutated := var_colors
	mut var_responsive_container_classes := rt.create_array([
		rt.ArrayItem{ key: none, val: 'wp-block-navigation__responsive-container' },
	])
	if rt.is_true(var_is_hidden_by_default_mutated) {
		var_responsive_container_classes.array_push('hidden-by-default')
	}
	if rt.is_true(var_has_custom_overlay_mutated) {
		var_responsive_container_classes.array_push('disable-default-overlay')
	} else {
		var_responsive_container_classes.array_push(rt.call_function('implode', [
			rt.new_string(' '),
			var_colors_mutated.array_get(rt.new_string('overlay_css_classes')),
		]))
	}
	return var_responsive_container_classes.clone()
}

fn Class_WP_Navigation_Block_Renderer.get_overlay_inline_styles(var_has_custom_overlay rt.PhpVal, var_colors rt.PhpVal) string {
	mut var_has_custom_overlay_mutated := var_has_custom_overlay
	mut var_colors_mutated := var_colors
	mut var_overlay_inline_styles := if rt.is_true(var_has_custom_overlay_mutated) { rt.new_string('') } else { rt.call_function('esc_attr', [
			rt.call_function('safecss_filter_attr', [
				var_colors_mutated.array_get(rt.new_string('overlay_inline_styles')),
			]),
		]) }
	return if !(!rt.is_true(var_overlay_inline_styles)) {
		"style=\"${var_overlay_inline_styles.to_string()}\""
	} else {
		''
	}
}

fn Class_WP_Navigation_Block_Renderer.get_responsive_container_markup(var_attributes rt.PhpVal, var_inner_blocks rt.PhpVal, var_inner_blocks_html rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_inner_blocks_mutated := var_inner_blocks
	mut var_inner_blocks_html_mutated := var_inner_blocks_html
	mut var_is_interactive := Class_WP_Navigation_Block_Renderer.is_interactive(var_attributes_mutated.clone(),
		var_inner_blocks_mutated.clone())
	mut var_colors := block_core_navigation_build_css_colors(var_attributes_mutated.clone())
	mut var_modal_unique_id := rt.call_function('wp_unique_id', [
		rt.new_string('modal-')])
	mut var_is_hidden_by_default := rt.new_bool(
		var_attributes_mutated.array_isset(rt.new_string('overlayMenu'))
		&& rt.is_true(rt.identical(rt.new_string('always'), var_attributes_mutated.array_get(rt.new_string('overlayMenu')))))
	mut var_has_custom_overlay := rt.new_bool(false)
	mut var_close_button_markup := rt.new_string('')
	mut var_has_custom_overlay_close_block := rt.new_bool(false)
	mut var_overlay_blocks_html := rt.new_string('')
	mut var_custom_overlay_markup := rt.new_string('')
	if !(!rt.is_true(var_attributes_mutated.array_get(rt.new_string('overlay')))) {
		mut var_overlay_blocks := Class_WP_Navigation_Block_Renderer.get_overlay_blocks_from_template_part(var_attributes_mutated.array_get(rt.new_string('overlay')),
			var_attributes_mutated.clone())
		var_overlay_blocks_html =
			Class_WP_Navigation_Block_Renderer.get_template_part_blocks_html(var_overlay_blocks.clone())
		var_has_custom_overlay_close_block =
			block_core_navigation_overlay_html_has_close_block(var_overlay_blocks_html.clone())
		if rt.is_true(var_has_custom_overlay_close_block) && rt.is_true(var_is_interactive) {
			mut var_tags := create_wp_html_tag_processor(var_overlay_blocks_html.clone())
			var_overlay_blocks_html =
				block_core_navigation_add_directives_to_overlay_close(var_tags)
		}
		var_overlay_blocks_html =
			rt.new_string(block_core_navigation_set_overlay_image_fetch_priority(var_overlay_blocks_html.clone()))
	}
	var_has_custom_overlay = rt.new_bool(!(!rt.is_true(var_overlay_blocks_html)))
	mut var_responsive_container_classes := Class_WP_Navigation_Block_Renderer.get_responsive_container_classes(var_is_hidden_by_default.clone(),
		var_has_custom_overlay.clone(), var_colors.clone())
	mut var_open_button_classes := ['wp-block-navigation__responsive-container-open', if rt.is_true(var_is_hidden_by_default) {
		'always-shown'
	} else {
		''
	}]
	mut var_should_display_icon_label := rt.new_bool(
		var_attributes_mutated.array_isset(rt.new_string('hasIcon'))
		&& rt.is_true(rt.identical(rt.new_bool(true), var_attributes_mutated.array_get(rt.new_string('hasIcon')))))
	mut var_toggle_button_icon :=
		rt.new_string('<svg width="24" height="24" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" aria-hidden="true" focusable="false"><path d="M4 7.5h16v1.5H4z"></path><path d="M4 15h16v1.5H4z"></path></svg>')
	if var_attributes_mutated.array_isset(rt.new_string('icon')) {
		if rt.is_true(rt.identical(rt.new_string('menu'),
			var_attributes_mutated.array_get(rt.new_string('icon'))))
		{
			var_toggle_button_icon =
				rt.new_string('<svg width="24" height="24" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M5 5v1.5h14V5H5z"></path><path d="M5 12.8h14v-1.5H5v1.5z"></path><path d="M5 19h14v-1.5H5V19z"></path></svg>')
		}
	}
	mut var_toggle_button_content := if rt.is_true(var_should_display_icon_label) { var_toggle_button_icon } else { rt.call_function('__', [
			rt.new_string('Menu'),
		]) }
	mut var_toggle_close_button_icon :=
		rt.new_string('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24" aria-hidden="true" focusable="false"><path d="m13.06 12 6.47-6.47-1.06-1.06L12 10.94 5.53 4.47 4.47 5.53 10.94 12l-6.47 6.47 1.06 1.06L12 13.06l6.47 6.47 1.06-1.06L13.06 12Z"></path></svg>')
	mut var_toggle_close_button_content := if rt.is_true(var_should_display_icon_label) { var_toggle_close_button_icon } else { rt.call_function('__', [
			rt.new_string('Close'),
		]) }
	mut var_toggle_aria_label_open := rt.new_string((if rt.is_true(var_should_display_icon_label) {
		'aria-label="' + (rt.call_function('__', [rt.new_string('Open menu')])).str() + '"'
	} else {
		''
	}).str())
	mut var_toggle_aria_label_close := rt.new_string((if rt.is_true(var_should_display_icon_label) {
		'aria-label="' + (rt.call_function('__', [rt.new_string('Close menu')])).str() + '"'
	} else {
		''
	}).str())
	mut var_open_button_directives := rt.new_string('')
	mut var_responsive_container_directives := rt.new_string('')
	mut var_responsive_dialog_directives := rt.new_string('')
	mut var_close_button_directives := rt.new_string('')
	if rt.is_true(var_is_interactive) {
		var_open_button_directives =
			rt.new_string('\n\t\t\t\tdata-wp-on--click="actions.openMenuOnClick"\n\t\t\t\tdata-wp-on--keydown="actions.handleMenuKeydown"\n\t\t\t')
		var_responsive_container_directives =
			rt.new_string('\n\t\t\t\tdata-wp-class--has-modal-open="state.isMenuOpen"\n\t\t\t\tdata-wp-class--is-menu-open="state.isMenuOpen"\n\t\t\t\tdata-wp-watch="callbacks.initMenu"\n\t\t\t\tdata-wp-on--keydown="actions.handleMenuKeydown"\n\t\t\t\tdata-wp-on--focusout="actions.handleMenuFocusout"\n\t\t\t\ttabindex="-1"\n\t\t\t')
		var_responsive_dialog_directives =
			rt.new_string('\n\t\t\t\tdata-wp-bind--aria-modal="state.ariaModal"\n\t\t\t\tdata-wp-bind--aria-label="state.ariaLabel"\n\t\t\t\tdata-wp-bind--role="state.roleAttribute"\n\t\t\t')
		var_close_button_directives =
			rt.new_string('\n\t\t\t\tdata-wp-on--click="actions.closeMenuOnClick"\n\t\t\t')
		mut var_responsive_container_content_directives :=
			rt.new_string('\n\t\t\t\tdata-wp-watch="callbacks.focusFirstElement"\n\t\t\t')
	}
	mut var_overlay_inline_styles := Class_WP_Navigation_Block_Renderer.get_overlay_inline_styles(var_has_custom_overlay.clone(),
		var_colors.clone())
	if rt.is_true(var_has_custom_overlay) {
		var_custom_overlay_markup = rt.call_function('sprintf', [
			rt.new_string('<div class="wp-block-navigation__overlay-container">%s</div>'),
			var_overlay_blocks_html.clone(),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_has_custom_overlay_close_block)))) {
		var_close_button_markup = rt.call_function('sprintf', [
			rt.new_string('<button %1$s class="wp-block-navigation__responsive-container-close" %2$s>%3$s</button>'),
			var_toggle_aria_label_close.clone(),
			var_close_button_directives.clone(),
			var_toggle_close_button_content.clone(),
		])
	}
	return rt.call_function('sprintf', [
		rt.new_string('<button aria-haspopup="dialog" %3$s class="%6$s" %10$s>%8$s</button>\n\t\t\t\t<div class="%5$s" %7$s id="%1$s" %11$s>\n\t\t\t\t\t<div class="wp-block-navigation__responsive-close" tabindex="-1">\n\t\t\t\t\t\t<div class="wp-block-navigation__responsive-dialog" %12$s>\n\t\t\t\t\t\t\t%13$s\n\t\t\t\t\t\t\t<div class="wp-block-navigation__responsive-container-content" %14$s id="%1$s-content">\n\t\t\t\t\t\t\t\t%2$s\n\t\t\t\t\t\t\t\t%15$s\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t</div>\n\t\t\t\t\t</div>\n\t\t\t\t</div>'),
		rt.call_function('esc_attr', [var_modal_unique_id.clone()]),
		var_inner_blocks_html_mutated.clone(),
		var_toggle_aria_label_open.clone(),
		var_toggle_aria_label_close.clone(),
		rt.call_function('esc_attr', [
			rt.new_string(rt.call_function('implode', [rt.new_string(' '),
				var_responsive_container_classes.clone()]).to_string().trim_space()),
		]),
		rt.call_function('esc_attr', [
			rt.new_string(rt.call_function('implode', [rt.new_string(' '),
				rt.create_array_from_list(var_open_button_classes)]).to_string().trim_space()),
		]),
		var_overlay_inline_styles.clone(),
		var_toggle_button_content.clone(),
		var_toggle_close_button_content.clone(),
		var_open_button_directives.clone(),
		var_responsive_container_directives.clone(),
		var_responsive_dialog_directives.clone(),
		var_close_button_markup.clone(),
		var_responsive_container_content_directives.clone(),
		if rt.is_true(var_has_custom_overlay) {
			var_custom_overlay_markup
		} else {
			rt.new_string('')
		},
	])
}

fn Class_WP_Navigation_Block_Renderer.get_nav_attributes(var_attributes rt.PhpVal, var_inner_blocks rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_inner_blocks_mutated := var_inner_blocks
	mut var_is_interactive := Class_WP_Navigation_Block_Renderer.is_interactive(var_attributes_mutated.clone(),
		var_inner_blocks_mutated.clone())
	mut var_is_responsive_menu :=
		Class_WP_Navigation_Block_Renderer.is_responsive(var_attributes_mutated.clone())
	mut var_style := Class_WP_Navigation_Block_Renderer.get_styles(var_attributes_mutated.clone())
	mut var_class := Class_WP_Navigation_Block_Renderer.get_classes(var_attributes_mutated.clone())
	mut var_extra_attributes := {
		'class': var_class
		'style': var_style
	}
	mut var_is_within_overlay := if !(var_attributes_mutated.array_get(rt.new_string('_isWithinOverlayTemplatePart'))).is_null() {
		var_attributes_mutated.array_get(rt.new_string('_isWithinOverlayTemplatePart'))
	} else {
		rt.new_bool(false)
	}
	if rt.is_true(var_is_within_overlay) {
		mut var_nav_menu_name :=
			Class_WP_Navigation_Block_Renderer.get_navigation_name(var_attributes_mutated.clone())
	} else {
		var_nav_menu_name =
			Class_WP_Navigation_Block_Renderer.get_unique_navigation_name(var_attributes_mutated.clone())
	}
	if !(!rt.is_true(var_nav_menu_name)) {
		var_extra_attributes['aria-label'] = var_nav_menu_name.clone()
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array_from_native_map(var_extra_attributes),
	])
	if rt.is_true(var_is_responsive_menu) {
		mut var_nav_element_directives :=
			Class_WP_Navigation_Block_Renderer.get_nav_element_directives(var_is_interactive.clone())
		var_wrapper_attributes = rt.concat(var_wrapper_attributes, rt.new_string(' ' +
			var_nav_element_directives.str()))
	}
	return var_wrapper_attributes.clone()
}

fn Class_WP_Navigation_Block_Renderer.get_nav_element_directives(var_is_interactive rt.PhpVal) string {
	mut var_is_interactive_mutated := var_is_interactive
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_interactive_mutated)))) {
		return ''
	}
	mut var_nav_element_context := rt.call_function('wp_interactivity_data_wp_context', [
		rt.create_array([
			rt.ArrayItem{ key: 'overlayOpenedBy', val: rt.create_array([
				rt.ArrayItem{ key: 'click', val: false },
				rt.ArrayItem{ key: 'hover', val: false },
				rt.ArrayItem{ key: 'focus', val: false },
			]) },
			rt.ArrayItem{ key: 'type', val: 'overlay' },
			rt.ArrayItem{ key: 'roleAttribute', val: '' },
			rt.ArrayItem{ key: 'ariaLabel', val: rt.call_function('__', [
				rt.new_string('Menu'),
			]) },
		]),
	])
	mut var_nav_element_directives := rt.new_string(
		'\n\t\t data-wp-interactive="core/navigation" ' + var_nav_element_context.str())
	return var_nav_element_directives.str()
}

fn Class_WP_Navigation_Block_Renderer.handle_view_script_module_loading(var_attributes rt.PhpVal, var_block rt.PhpVal, var_inner_blocks rt.PhpVal) {
	mut var_attributes_mutated := var_attributes
	mut var_block_mutated := var_block
	mut var_inner_blocks_mutated := var_inner_blocks
	if rt.is_true(Class_WP_Navigation_Block_Renderer.is_interactive(var_attributes_mutated.clone(),
		var_inner_blocks_mutated.clone()))
	{
		rt.call_function('wp_enqueue_script_module', [
			rt.new_string('@wordpress/block-library/navigation/view'),
		])
	}
}

fn Class_WP_Navigation_Block_Renderer.get_inner_block_markup(var_attributes rt.PhpVal, var_inner_blocks rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_inner_blocks_mutated := var_inner_blocks
	mut var_inner_blocks_html := Class_WP_Navigation_Block_Renderer.get_inner_blocks_html(var_attributes_mutated.clone(),
		var_inner_blocks_mutated.clone())
	if rt.is_true(Class_WP_Navigation_Block_Renderer.is_responsive(var_attributes_mutated.clone())) {
		return Class_WP_Navigation_Block_Renderer.get_responsive_container_markup(var_attributes_mutated.clone(),
			var_inner_blocks_mutated.clone(), var_inner_blocks_html.clone())
	}
	return var_inner_blocks_html.clone()
}

fn Class_WP_Navigation_Block_Renderer.get_unique_navigation_name(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_nav_menu_name :=
		Class_WP_Navigation_Block_Renderer.get_navigation_name(var_attributes_mutated.clone())
	if rt.get_static_prop('WP_Navigation_Block_Renderer', 'seen_menu_names').array_isset(var_nav_menu_name) {
		rt.pre_inc(rt.get_static_prop('WP_Navigation_Block_Renderer', 'seen_menu_names').array_get(var_nav_menu_name))
	} else {
		rt.get_static_prop('WP_Navigation_Block_Renderer', 'seen_menu_names').array_set(var_nav_menu_name,
			1)
	}
	if rt.get_static_prop('WP_Navigation_Block_Renderer', 'seen_menu_names').array_isset(var_nav_menu_name)
		&& rt.is_true(rt.greater(rt.get_static_prop('WP_Navigation_Block_Renderer', 'seen_menu_names').array_get(var_nav_menu_name), rt.new_int(1))) {
		mut var_count :=
			rt.get_static_prop('WP_Navigation_Block_Renderer', 'seen_menu_names').array_get(var_nav_menu_name)
		var_nav_menu_name = rt.new_string(var_nav_menu_name.str() + ' ' + var_count.str())
	}
	return var_nav_menu_name.clone()
}

fn Class_WP_Navigation_Block_Renderer.render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_attributes_mutated := var_attributes
	mut var_content_mutated := var_content
	mut var_block_mutated := var_block
	if var_attributes_mutated.array_isset(rt.new_string('rgbTextColor'))
		&& !rt.is_true(var_attributes_mutated.array_get(rt.new_string('textColor'))) {
		var_attributes_mutated.array_set('customTextColor',
			var_attributes_mutated.array_get(rt.new_string('rgbTextColor')))
	}
	if var_attributes_mutated.array_isset(rt.new_string('rgbBackgroundColor'))
		&& !rt.is_true(var_attributes_mutated.array_get(rt.new_string('backgroundColor'))) {
		var_attributes_mutated.array_set('customBackgroundColor',
			var_attributes_mutated.array_get(rt.new_string('rgbBackgroundColor')))
	}
	var_attributes_mutated.array_unset(rt.new_string('rgbTextColor'))
	var_attributes_mutated.array_unset(rt.new_string('rgbBackgroundColor'))
	mut var_inner_blocks := Class_WP_Navigation_Block_Renderer.get_inner_blocks(var_attributes_mutated.clone(),
		var_block_mutated.clone())
	if rt.is_true(rt.new_bool(block_core_navigation_block_tree_has_block_type(var_inner_blocks.clone(),
		'core/navigation', rt.new_null())))
	{
		return ''
	}
	Class_WP_Navigation_Block_Renderer.handle_view_script_module_loading(var_attributes_mutated.clone(),
		var_block_mutated.clone(), var_inner_blocks.clone())
	mut var_is_within_overlay := if !(var_attributes_mutated.array_get(rt.new_string('_isWithinOverlayTemplatePart'))).is_null() {
		var_attributes_mutated.array_get(rt.new_string('_isWithinOverlayTemplatePart'))
	} else {
		rt.new_bool(false)
	}
	mut var_tag_name :=
		rt.new_string((if rt.is_true(var_is_within_overlay) { 'div' } else { 'nav' }).str())
	return (rt.call_function('sprintf', [rt.new_string('<%1$s %2$s>%3$s</%1$s>'),
		var_tag_name.clone(),
		Class_WP_Navigation_Block_Renderer.get_nav_attributes(var_attributes_mutated.clone(),
			var_inner_blocks.clone()),
		Class_WP_Navigation_Block_Renderer.get_inner_block_markup(var_attributes_mutated.clone(),
			var_inner_blocks.clone())])).str()
}

fn block_core_navigation_get_menu_items_at_location(var_location rt.PhpVal) rt.PhpVal {
	mut var_locations := rt.new_null()
	mut var_menu := rt.new_null()
	mut var_menu_items := rt.new_null()
	if !rt.is_true(var_location) {
		return rt.new_null()
	}
	var_locations = rt.call_function('get_nav_menu_locations', []rt.PhpVal{})
	if !(var_locations.array_isset(var_location)) {
		return rt.new_null()
	}
	var_menu = rt.call_function('wp_get_nav_menu_object', [var_locations.array_get(var_location)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_menu))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_menu.clone()])) {
		return rt.new_null()
	}
	var_menu_items = rt.call_function('wp_get_nav_menu_items', [
		rt.get_property(var_menu, 'term_id'),
		rt.create_array([rt.ArrayItem{ key: 'update_post_term_cache', val: false }]),
	])
	rt.call_function('_wp_menu_item_classes_by_context', [var_menu_items.clone()])
	return var_menu_items.clone()
}

fn block_core_navigation_sort_menu_items_by_parent_id(var_menu_items rt.PhpVal) rt.PhpVal {
	mut var_sorted_menu_items := rt.new_null()
	mut var_menu_item := rt.new_null()
	mut var_menu_items_by_parent_id := rt.new_null()
	var_sorted_menu_items = rt.new_array()
	mut iter_6 := rt.cast_array(var_menu_items).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_menu_item_shadow := item_6.val
		var_sorted_menu_items.array_set(rt.get_property(var_menu_item_shadow, 'menu_order'),
			var_menu_item_shadow.clone())
	}
	var_menu_items = rt.new_null()
	var_menu_item = rt.new_null()
	var_menu_items_by_parent_id = rt.new_array()
	mut iter_7 := var_sorted_menu_items.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_menu_item_shadow := item_7.val
		var_menu_items_by_parent_id.array_get_mut(rt.get_property(var_menu_item_shadow,
			'menu_item_parent')).array_push(var_menu_item_shadow.clone())
	}
	return var_menu_items_by_parent_id.clone()
}

fn block_core_navigation_get_inner_blocks_from_unstable_location(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_menu_items := rt.new_null()
	mut var_menu_items_by_parent_id := rt.new_null()
	mut var_parsed_blocks := rt.new_null()
	var_menu_items =
		block_core_navigation_get_menu_items_at_location(var_attributes.array_get(rt.new_string('__unstableLocation')))
	if !rt.is_true(var_menu_items) {
		return rt.new_object('WP_Block_List', []string{}, create_wp_block_list(rt.new_array(),
			var_attributes.clone()))
	}
	var_menu_items_by_parent_id =
		block_core_navigation_sort_menu_items_by_parent_id(var_menu_items.clone())
	var_parsed_blocks = block_core_navigation_parse_blocks_from_menu_items(var_menu_items_by_parent_id.array_get(rt.new_int(0)),
		var_menu_items_by_parent_id.clone())
	return rt.new_object('WP_Block_List', []string{}, create_wp_block_list(var_parsed_blocks.clone(),
		var_attributes.clone()))
}

fn block_core_navigation_overlay_html_has_close_block(var_html rt.PhpVal) rt.PhpVal {
	mut var_tags := rt.new_null()
	var_tags = create_wp_html_tag_processor(var_html.clone())
	return var_tags.next_tag(rt.create_array([
		rt.ArrayItem{ key: 'tag_name', val: 'BUTTON' },
		rt.ArrayItem{ key: 'class_name', val: 'wp-block-navigation-overlay-close' },
	]))
}

fn block_core_navigation_add_directives_to_overlay_close(var_tags rt.PhpVal) rt.PhpVal {
	for rt.is_true(var_tags.next_tag(rt.create_array([rt.ArrayItem, {
		key: 'tag_name'
		val: 'BUTTON'
	}, rt.ArrayItem, {
		key: 'class_name'
		val: 'wp-block-navigation-overlay-close'
	}]))) {
		var_tags.set_attribute(rt.new_string('data-wp-on--click'),
			rt.new_string('actions.closeMenuOnClick'))
	}
	return var_tags.get_updated_html()
}

fn block_core_navigation_set_overlay_image_fetch_priority(overlay_blocks_html string) string {
	mut var_overlay_blocks_html := overlay_blocks_html
	mut var_tags := rt.new_null()
	var_tags = create_wp_html_tag_processor(rt.new_string(overlay_blocks_html))
	for rt.is_true(var_tags.next_tag(rt.new_string('IMG'))) {
		var_tags.set_attribute(rt.new_string('fetchpriority'), rt.new_string('low'))
	}
	return (var_tags.get_updated_html()).str()
}

fn block_core_navigation_add_directives_to_submenu(var_tags rt.PhpVal, var_block_attributes rt.PhpVal) rt.PhpVal {
	mut var_computed_visibility := ''
	mut var_open_on_hover := false
	for rt.is_true(var_tags.next_tag(rt.create_array([rt.ArrayItem, {
		key: 'tag_name'
		val: 'LI'
	}, rt.ArrayItem, {
		key: 'class_name'
		val: 'has-child'
	}]))) {
		var_tags.set_attribute(rt.new_string('data-wp-interactive'),
			rt.new_string('core/navigation'))
		var_tags.set_attribute(rt.new_string('data-wp-context'),
			rt.new_string('{ "submenuOpenedBy": { "click": false, "hover": false, "focus": false }, "type": "submenu", "modal": null, "previousFocus": null }'))
		var_tags.set_attribute(rt.new_string('data-wp-watch'), rt.new_string('callbacks.initMenu'))
		var_tags.set_attribute(rt.new_string('data-wp-on--focusout'),
			rt.new_string('actions.handleMenuFocusout'))
		var_tags.set_attribute(rt.new_string('data-wp-on--keydown'),
			rt.new_string('actions.handleMenuKeydown'))
		var_tags.set_attribute(rt.new_string('tabindex'), rt.new_string('-1'))
		var_computed_visibility =
			block_core_navigation_get_submenu_visibility(var_block_attributes.clone())
		var_open_on_hover = (rt.identical(rt.new_string('hover'),
			rt.new_string(var_computed_visibility.str()))).to_bool()
		if var_open_on_hover {
			var_tags.set_attribute(rt.new_string('data-wp-on--pointerenter'),
				rt.new_string('actions.openMenuOnHover'))
			var_tags.set_attribute(rt.new_string('data-wp-on--pointerleave'),
				rt.new_string('actions.closeMenuOnHover'))
		}
		if rt.is_true(var_tags.next_tag(rt.create_array([
			rt.ArrayItem{ key: 'tag_name', val: 'BUTTON' },
			rt.ArrayItem{ key: 'class_name', val: 'wp-block-navigation-submenu__toggle' },
		])))
		{
			var_tags.set_attribute(rt.new_string('data-wp-on--click'),
				rt.new_string('actions.toggleMenuOnClick'))
			var_tags.set_attribute(rt.new_string('data-wp-bind--aria-expanded'),
				rt.new_string('state.isMenuOpen'))
		}
		if rt.is_true(var_tags.next_tag(rt.create_array([
			rt.ArrayItem{ key: 'tag_name', val: 'UL' },
			rt.ArrayItem{ key: 'class_name', val: 'wp-block-navigation__submenu-container' },
		])))
		{
			var_tags.set_attribute(rt.new_string('data-wp-on--focus'),
				rt.new_string('actions.openMenuOnFocus'))
		}
		block_core_navigation_add_directives_to_submenu(var_tags, var_block_attributes.clone())
	}
	return var_tags.get_updated_html()
}

fn block_core_navigation_build_css_colors(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_colors := rt.new_null()
	mut var_has_named_text_color := false
	mut var_has_custom_text_color := false
	mut var_has_named_background_color := false
	mut var_has_custom_background_color := false
	mut var_has_named_overlay_text_color := false
	mut var_has_custom_overlay_text_color := false
	mut var_has_named_overlay_background_color := false
	mut var_has_custom_overlay_background_color := false
	var_colors = rt.create_array([
		rt.ArrayItem{ key: 'css_classes', val: rt.new_array() },
		rt.ArrayItem{ key: 'inline_styles', val: '' },
		rt.ArrayItem{ key: 'overlay_css_classes', val: rt.new_array() },
		rt.ArrayItem{ key: 'overlay_inline_styles', val: '' },
	])
	var_has_named_text_color =
		rt.create_array_from_native_map(var_attributes).array_isset(rt.new_string('textColor'))
	var_has_custom_text_color =
		rt.create_array_from_native_map(var_attributes).array_isset(rt.new_string('customTextColor'))
	if var_has_custom_text_color || var_has_named_text_color {
		var_colors.array_get_mut('css_classes').array_push('has-text-color')
	}
	if var_has_named_text_color {
		var_colors.array_get_mut('css_classes').array_push(rt.call_function('sprintf', [
			rt.new_string('has-%s-color'),
			var_attributes.array_get(rt.new_string('textColor')),
		]))
	} else if var_has_custom_text_color {
		var_colors.array_get(rt.new_string('inline_styles')) = rt.concat(var_colors.array_get(rt.new_string('inline_styles')), rt.call_function('sprintf', [
			rt.new_string('color: %s;'),
			var_attributes.array_get(rt.new_string('customTextColor')),
		]))
	}
	var_has_named_background_color =
		rt.create_array_from_native_map(var_attributes).array_isset(rt.new_string('backgroundColor'))
	var_has_custom_background_color =
		rt.create_array_from_native_map(var_attributes).array_isset(rt.new_string('customBackgroundColor'))
	if var_has_custom_background_color || var_has_named_background_color {
		var_colors.array_get_mut('css_classes').array_push('has-background')
	}
	if var_has_named_background_color {
		var_colors.array_get_mut('css_classes').array_push(rt.call_function('sprintf', [
			rt.new_string('has-%s-background-color'),
			var_attributes.array_get(rt.new_string('backgroundColor')),
		]))
	} else if var_has_custom_background_color {
		var_colors.array_get(rt.new_string('inline_styles')) = rt.concat(var_colors.array_get(rt.new_string('inline_styles')), rt.call_function('sprintf', [
			rt.new_string('background-color: %s;'),
			var_attributes.array_get(rt.new_string('customBackgroundColor')),
		]))
	}
	var_has_named_overlay_text_color =
		rt.create_array_from_native_map(var_attributes).array_isset(rt.new_string('overlayTextColor'))
	var_has_custom_overlay_text_color =
		rt.create_array_from_native_map(var_attributes).array_isset(rt.new_string('customOverlayTextColor'))
	if var_has_custom_overlay_text_color || var_has_named_overlay_text_color {
		var_colors.array_get_mut('overlay_css_classes').array_push('has-text-color')
	}
	if var_has_named_overlay_text_color {
		var_colors.array_get_mut('overlay_css_classes').array_push(rt.call_function('sprintf', [
			rt.new_string('has-%s-color'),
			var_attributes.array_get(rt.new_string('overlayTextColor')),
		]))
	} else if var_has_custom_overlay_text_color {
		var_colors.array_get(rt.new_string('overlay_inline_styles')) = rt.concat(var_colors.array_get(rt.new_string('overlay_inline_styles')), rt.call_function('sprintf', [
			rt.new_string('color: %s;'),
			var_attributes.array_get(rt.new_string('customOverlayTextColor')),
		]))
	}
	var_has_named_overlay_background_color =
		rt.create_array_from_native_map(var_attributes).array_isset(rt.new_string('overlayBackgroundColor'))
	var_has_custom_overlay_background_color =
		rt.create_array_from_native_map(var_attributes).array_isset(rt.new_string('customOverlayBackgroundColor'))
	if var_has_custom_overlay_background_color || var_has_named_overlay_background_color {
		var_colors.array_get_mut('overlay_css_classes').array_push('has-background')
	}
	if var_has_named_overlay_background_color {
		var_colors.array_get_mut('overlay_css_classes').array_push(rt.call_function('sprintf', [
			rt.new_string('has-%s-background-color'),
			var_attributes.array_get(rt.new_string('overlayBackgroundColor')),
		]))
	} else if var_has_custom_overlay_background_color {
		var_colors.array_get(rt.new_string('overlay_inline_styles')) = rt.concat(var_colors.array_get(rt.new_string('overlay_inline_styles')), rt.call_function('sprintf', [
			rt.new_string('background-color: %s;'),
			var_attributes.array_get(rt.new_string('customOverlayBackgroundColor')),
		]))
	}
	return var_colors.clone()
}

fn block_core_navigation_build_css_font_sizes(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_font_sizes := rt.new_null()
	mut var_has_named_font_size := false
	mut var_has_custom_font_size := false
	var_font_sizes = rt.create_array([
		rt.ArrayItem{ key: 'css_classes', val: rt.new_array() },
		rt.ArrayItem{ key: 'inline_styles', val: '' },
	])
	var_has_named_font_size =
		rt.create_array_from_native_map(var_attributes).array_isset(rt.new_string('fontSize'))
	var_has_custom_font_size =
		rt.create_array_from_native_map(var_attributes).array_isset(rt.new_string('customFontSize'))
	if var_has_named_font_size {
		var_font_sizes.array_get_mut('css_classes').array_push(rt.call_function('sprintf', [
			rt.new_string('has-%s-font-size'),
			var_attributes.array_get(rt.new_string('fontSize')),
		]))
	} else if var_has_custom_font_size {
		var_font_sizes.array_set('inline_styles', rt.call_function('sprintf', [
			rt.new_string('font-size: %spx;'),
			var_attributes.array_get(rt.new_string('customFontSize')),
		]))
	}
	return var_font_sizes.clone()
}

fn block_core_navigation_render_submenu_icon() string {
	return '<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12" fill="none" aria-hidden="true" focusable="false"><path d="M1.50002 4L6.00002 8L10.5 4" stroke-width="1.5"></path></svg>'
}

fn block_core_navigation_filter_out_empty_blocks(var_parsed_blocks rt.PhpVal) rt.PhpVal {
	mut var_filtered := rt.new_null()
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_block := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(var_block.array_isset(rt.new_string('blockName')))
	}
	var_filtered = rt.call_function('array_filter', [var_parsed_blocks.clone(),
		rt.new_closure(closure_1_fn)])
	return rt.call_function('array_values', [var_filtered.clone()])
}

fn block_core_navigation_block_tree_has_block_type(var_blocks rt.PhpVal, block_type string, var_skip_block_types rt.PhpVal) bool {
	mut var_block_type := block_type
	mut var_block := map[string]rt.PhpVal{}
	if !rt.is_true(var_blocks) {
		return false
	}
	mut iter_8 := var_blocks.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_block_shadow := item_8.val
		if rt.is_true(rt.identical(rt.new_string(block_type), rt.get_property(var_block_shadow,
			'name')))
		{
			return true
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_block_shadow, 'name'), var_skip_block_types.clone(), rt.new_bool(true)])))))
			&& !(!rt.is_true(rt.get_property(var_block_shadow, 'inner_blocks'))) {
			if rt.is_true(rt.new_bool(block_core_navigation_block_tree_has_block_type(rt.get_property(var_block_shadow,
				'inner_blocks'), block_type, var_skip_block_types.clone())))
			{
				return true
			}
		}
	}
	return false
}

fn block_core_navigation_block_contains_core_navigation(var_inner_blocks rt.PhpVal) bool {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('7.0.0'), rt.new_string('block_core_navigation_block_tree_has_block_type()')])
	return block_core_navigation_block_tree_has_block_type(var_inner_blocks.clone(),
		'core/navigation')
}

fn block_core_navigation_get_fallback_blocks() rt.PhpVal {
	mut var_page_list_fallback := []rt.PhpVal{}
	mut var_registry := rt.new_null()
	mut var_fallback_blocks := rt.new_null()
	mut var_navigation_post := rt.new_null()
	mut var_parsed_blocks := rt.new_null()
	mut var_maybe_fallback := rt.new_null()
	mut var_markup := rt.new_null()
	var_page_list_fallback = [
		[rt.new_string('core/page-list'), rt.new_array(), rt.new_array()],
	]
	mut iife_temp_1 := Class_WP_Block_Type_Registry{}
	mut iife_result_1 := iife_temp_1.get_instance()
	var_registry = iife_result_1
	var_fallback_blocks = if rt.is_true(rt.call_method(var_registry, 'is_registered', [
		rt.new_string('core/page-list'),
	]))
	{ var_page_list_fallback } else { rt.new_array() }
	mut iife_temp_2 := Class_WP_Navigation_Fallback{}
	mut iife_result_2 := iife_temp_2.get_fallback()
	var_navigation_post = iife_result_2
	if rt.is_true(var_navigation_post) {
		var_parsed_blocks = rt.call_function('parse_blocks', [
			rt.get_property(var_navigation_post, 'post_content'),
		])
		var_maybe_fallback =
			block_core_navigation_filter_out_empty_blocks(var_parsed_blocks.clone())
		var_fallback_blocks = if !(!rt.is_true(var_maybe_fallback)) {
			var_maybe_fallback
		} else {
			var_fallback_blocks
		}
		var_markup = rt.call_function('serialize_blocks', [var_fallback_blocks.clone()])
		var_markup = rt.call_function('apply_block_hooks_to_content_from_post_object', [
			var_markup.clone(),
			var_navigation_post.clone(),
		])
		var_fallback_blocks = rt.call_function('parse_blocks', [
			var_markup.clone()])
	}
	return rt.call_function('apply_filters', [
		rt.new_string('block_core_navigation_render_fallback'),
		var_fallback_blocks.clone(),
	])
}

fn block_core_navigation_get_post_ids(var_inner_blocks rt.PhpVal) rt.PhpVal {
	mut var_post_ids := rt.new_null()
	var_post_ids = rt.call_function('array_map', [
		rt.new_string('block_core_navigation_from_block_get_post_ids'),
		rt.call_function('iterator_to_array', [var_inner_blocks.clone()]),
	])
	return rt.call_function('array_unique', [
		rt.call_function('array_merge', [var_post_ids.clone()]),
	])
}

fn block_core_navigation_from_block_get_post_ids(var_block rt.PhpVal) rt.PhpVal {
	mut var_post_ids := rt.new_null()
	var_post_ids = rt.new_array()
	if rt.is_true(rt.get_property(var_block, 'inner_blocks')) {
		var_post_ids =
			block_core_navigation_get_post_ids(rt.get_property(var_block, 'inner_blocks'))
	}
	if rt.is_true(rt.identical(rt.new_string('core/navigation-link'), rt.get_property(var_block, 'name')))
		|| rt.is_true(rt.identical(rt.new_string('core/navigation-submenu'), rt.get_property(var_block, 'name'))) {
		if rt.is_true(rt.get_property(var_block, 'attributes'))
			&& rt.get_property(var_block, 'attributes').array_isset(rt.new_string('kind'))
			&& rt.is_true(rt.identical(rt.new_string('post-type'), rt.get_property(var_block, 'attributes').array_get(rt.new_string('kind'))))
			&& rt.get_property(var_block, 'attributes').array_isset(rt.new_string('id')) {
			var_post_ids.array_push(rt.get_property(var_block, 'attributes').array_get(rt.new_string('id')))
		}
	}
	return var_post_ids.clone()
}

fn render_block_core_navigation(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	return Class_WP_Navigation_Block_Renderer.render(var_attributes.clone(), var_content.clone(),
		var_block.clone())
}

fn register_block_core_navigation() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/navigation'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_navigation' },
		]),
	])
}

fn block_core_navigation_typographic_presets_backcompatibility(var_parsed_block rt.PhpVal) rt.PhpVal {
	mut var_attribute_to_prefix_map := map[string]rt.PhpVal{}
	mut var_prefix := rt.new_null()
	mut var_style_attribute := rt.new_null()
	mut var_prefix_len := i64(0)
	mut var_attribute_value := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('core/navigation'),
		var_parsed_block.array_get(rt.new_string('blockName'))))
	{
		var_attribute_to_prefix_map = {
			'fontStyle':      'var:preset|font-style|'
			'fontWeight':     'var:preset|font-weight|'
			'textDecoration': 'var:preset|text-decoration|'
			'textTransform':  'var:preset|text-transform|'
		}
		for var_style_attribute_shadow, var_prefix_shadow in var_attribute_to_prefix_map {
			if !(!rt.is_true(var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string(var_style_attribute_shadow.str())))) {
				var_prefix_len = rt.new_string(var_prefix_shadow.str()).clone().to_string().len
				var_attribute_value =
					var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string(var_style_attribute_shadow.str()))
				if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strncmp', [
					var_attribute_value.clone(),
					rt.new_string(var_prefix_shadow.str()).clone(),
					rt.new_int(var_prefix_len).clone(),
				])))
				{
					var_attribute_value = rt.call_function('substr', [
						var_attribute_value.clone(), rt.new_int(var_prefix_len).clone()])
				}
				if rt.is_true(rt.identical(rt.new_string('textDecoration'), rt.new_string(var_style_attribute_shadow.str())))
					&& rt.is_true(rt.identical(rt.new_string('strikethrough'), var_attribute_value)) {
					var_attribute_value = rt.new_string('line-through')
				}
			}
		}
	}
	return var_parsed_block.clone()
}

fn block_core_navigation_parse_blocks_from_menu_items(var_menu_items rt.PhpVal, var_menu_items_by_parent_id rt.PhpVal) rt.PhpVal {
	mut var_blocks := rt.new_null()
	mut var_menu_item := rt.new_null()
	mut var_class_name := rt.new_null()
	mut var_id := rt.new_null()
	mut var_opens_in_new_tab := false
	mut var_rel := rt.new_null()
	mut var_kind := rt.new_null()
	mut var_block := map[string]rt.PhpVal{}
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.3.0'), rt.new_string('WP_Navigation_Fallback::parse_blocks_from_menu_items')])
	if !rt.is_true(var_menu_items) {
		return rt.new_array()
	}
	var_blocks = rt.new_array()
	mut iter_9 := var_menu_items.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_menu_item_shadow := item_9.val
		var_class_name = if !(!rt.is_true(rt.get_property(var_menu_item_shadow, 'classes'))) { rt.call_function('implode', [
				rt.new_string(' '),
				rt.cast_array(rt.get_property(var_menu_item_shadow, 'classes')),
			]) } else { rt.new_null() }
		var_id = if
			rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.get_property(var_menu_item_shadow, 'object_id')))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('custom'), rt.get_property(var_menu_item_shadow, 'object'))))) {
			rt.get_property(var_menu_item_shadow, 'object_id')
		} else {
			rt.new_null()
		}
		var_opens_in_new_tab =
			rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.get_property(var_menu_item_shadow, 'target')))))
			&& rt.is_true(rt.identical(rt.new_string('_blank'), rt.get_property(var_menu_item_shadow, 'target')))
		var_rel = if
			rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.get_property(var_menu_item_shadow, 'xfn')))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_menu_item_shadow, 'xfn'))))) {
			rt.get_property(var_menu_item_shadow, 'xfn')
		} else {
			rt.new_null()
		}
		var_kind = if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.get_property(var_menu_item_shadow, 'type'))))) { rt.call_function('str_replace', [
				rt.new_string('_'),
				rt.new_string('-'),
				rt.get_property(var_menu_item_shadow, 'type'),
			]) } else { rt.new_string('custom') }
		var_block = {
			'blockName': if var_menu_items_by_parent_id.array_isset(rt.get_property(var_menu_item_shadow, 'ID')) {
				'core/navigation-submenu'
			} else {
				'core/navigation-link'
			}
			'attrs':     {
				'className':     var_class_name
				'description':   rt.get_property(var_menu_item_shadow, 'description')
				'id':            var_id
				'kind':          var_kind
				'label':         rt.get_property(var_menu_item_shadow, 'title')
				'opensInNewTab': rt.new_bool(var_opens_in_new_tab)
				'rel':           var_rel
				'title':         rt.get_property(var_menu_item_shadow, 'attr_title')
				'type':          rt.get_property(var_menu_item_shadow, 'object')
				'url':           rt.get_property(var_menu_item_shadow, 'url')
			}
		}
		var_block['innerBlocks'] = if var_menu_items_by_parent_id.array_isset(rt.get_property(var_menu_item_shadow, 'ID')) {
			block_core_navigation_parse_blocks_from_menu_items(var_menu_items_by_parent_id.array_get(rt.get_property(var_menu_item_shadow, 'ID')),
				var_menu_items_by_parent_id.clone())
		} else {
			rt.new_array()
		}
		var_block['innerContent'] = rt.call_function('array_map', [
			rt.new_string('serialize_block'),
			var_block['innerBlocks'],
		])
		var_blocks.array_push(var_block.clone())
	}
	return var_blocks.clone()
}

fn block_core_navigation_get_classic_menu_fallback() rt.PhpVal {
	mut var_classic_nav_menus := rt.new_null()
	mut var_locations := rt.new_null()
	mut var_primary_menu := rt.new_null()
	mut var_classic_nav_menu := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.3.0'), rt.new_string('WP_Navigation_Fallback::get_classic_menu_fallback')])
	var_classic_nav_menus = rt.call_function('wp_get_nav_menus', []rt.PhpVal{})
	if rt.is_true(var_classic_nav_menus)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_classic_nav_menus.clone()]))))) {
		var_locations = rt.call_function('get_nav_menu_locations', []rt.PhpVal{})
		if var_locations.array_isset(rt.new_string('primary')) {
			var_primary_menu = rt.call_function('wp_get_nav_menu_object', [
				var_locations.array_get(rt.new_string('primary')),
			])
			if rt.is_true(var_primary_menu) {
				return var_primary_menu.clone()
			}
		}
		mut iter_10 := var_classic_nav_menus.iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_classic_nav_menu_shadow := item_10.val
			if rt.is_true(rt.identical(rt.new_string('primary'), rt.get_property(var_classic_nav_menu_shadow,
				'slug')))
			{
				return var_classic_nav_menu_shadow.clone()
			}
		}
		closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_a := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_b := if args.len > 1 { args[1].clone() } else { rt.new_null() }
			return rt.sub(rt.get_property(var_b, 'term_id'), rt.get_property(var_a, 'term_id'))
		}
		rt.call_function('usort', [var_classic_nav_menus.clone(),
			rt.new_closure(closure_4_fn)])
		return var_classic_nav_menus.array_get(rt.new_int(0))
	}
	return rt.new_null()
}

fn block_core_navigation_get_classic_menu_fallback_blocks(var_classic_nav_menu rt.PhpVal) rt.PhpVal {
	mut var_menu_items := rt.new_null()
	mut var_sorted_menu_items := rt.new_null()
	mut var_menu_item := rt.new_null()
	mut var_menu_items_by_parent_id := rt.new_null()
	mut var_inner_blocks := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.3.0'),
		rt.new_string('WP_Navigation_Fallback::get_classic_menu_fallback_blocks')])
	var_menu_items = rt.call_function('wp_get_nav_menu_items', [
		rt.get_property(var_classic_nav_menu, 'term_id'),
		rt.create_array([rt.ArrayItem{ key: 'update_post_term_cache', val: false }]),
	])
	rt.call_function('_wp_menu_item_classes_by_context', [var_menu_items.clone()])
	var_sorted_menu_items = rt.new_array()
	mut iter_11 := rt.cast_array(var_menu_items).iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_menu_item_shadow := item_11.val
		var_sorted_menu_items.array_set(rt.get_property(var_menu_item_shadow, 'menu_order'),
			var_menu_item_shadow.clone())
	}
	var_menu_items = rt.new_null()
	var_menu_item = rt.new_null()
	var_menu_items_by_parent_id = rt.new_array()
	mut iter_12 := var_sorted_menu_items.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_menu_item_shadow := item_12.val
		var_menu_items_by_parent_id.array_get_mut(rt.get_property(var_menu_item_shadow,
			'menu_item_parent')).array_push(var_menu_item_shadow.clone())
	}
	var_inner_blocks = block_core_navigation_parse_blocks_from_menu_items(if !(var_menu_items_by_parent_id.array_get(rt.new_int(0))).is_null() {
		var_menu_items_by_parent_id.array_get(rt.new_int(0))
	} else {
		rt.new_array()
	}, var_menu_items_by_parent_id.clone())
	return rt.call_function('serialize_blocks', [var_inner_blocks.clone()])
}

fn block_core_navigation_maybe_use_classic_menu_fallback() rt.PhpVal {
	mut var_classic_nav_menu := rt.new_null()
	mut var_classic_nav_menu_blocks := rt.new_null()
	mut var_wp_insert_post_result := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.3.0'), rt.new_string('WP_Navigation_Fallback::create_classic_menu_fallback')])
	var_classic_nav_menu = block_core_navigation_get_classic_menu_fallback()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_classic_nav_menu)))) {
		return rt.new_null()
	}
	var_classic_nav_menu_blocks =
		block_core_navigation_get_classic_menu_fallback_blocks(var_classic_nav_menu.clone())
	if !rt.is_true(var_classic_nav_menu_blocks) {
		return rt.new_null()
	}
	var_wp_insert_post_result = rt.call_function('wp_insert_post', [
		rt.create_array([
			rt.ArrayItem{ key: 'post_content', val: var_classic_nav_menu_blocks },
			rt.ArrayItem{ key: 'post_title', val: rt.get_property(var_classic_nav_menu, 'name') },
			rt.ArrayItem{ key: 'post_name', val: rt.get_property(var_classic_nav_menu, 'slug') },
			rt.ArrayItem{ key: 'post_status', val: 'publish' },
			rt.ArrayItem{ key: 'post_type', val: 'wp_navigation' },
		]),
		rt.new_bool(true),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_wp_insert_post_result.clone()])) {
		return rt.new_null()
	}
	return block_core_navigation_get_most_recently_published_navigation()
}

fn block_core_navigation_get_most_recently_published_navigation() rt.PhpVal {
	mut var_parsed_args := map[string]rt.PhpVal{}
	mut var_navigation_post := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.3.0'),
		rt.new_string('WP_Navigation_Fallback::get_most_recently_published_navigation')])
	var_parsed_args = {
		'post_type':              rt.new_string('wp_navigation')
		'no_found_rows':          rt.new_bool(true)
		'update_post_meta_cache': rt.new_bool(false)
		'update_post_term_cache': rt.new_bool(false)
		'order':                  rt.new_string('DESC')
		'orderby':                rt.new_string('date')
		'post_status':            rt.new_string('publish')
		'posts_per_page':         rt.new_int(1)
	}
	var_navigation_post = create_wp_query(var_parsed_args.clone())
	if rt.get_property(var_navigation_post, 'posts').array_count() > 0 {
		return rt.get_property(var_navigation_post, 'posts').array_get(rt.new_int(0))
	}
	return rt.new_null()
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

struct Class_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

struct Class_WP_Navigation_Fallback {
	rt.PhpObjectBase
}

fn create_wp_navigation_block_renderer(_args ...rt.PhpVal) &Class_WP_Navigation_Block_Renderer {
	mut obj := &Class_WP_Navigation_Block_Renderer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_html_tag_processor(_args ...rt.PhpVal) &Class_WP_HTML_Tag_Processor {
	mut obj := &Class_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_list(_args ...rt.PhpVal) &Class_WP_Block_List {
	mut obj := &Class_WP_Block_List{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_type_registry(_args ...rt.PhpVal) &Class_WP_Block_Type_Registry {
	mut obj := &Class_WP_Block_Type_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_navigation_fallback(_args ...rt.PhpVal) &Class_WP_Navigation_Fallback {
	mut obj := &Class_WP_Navigation_Fallback{
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
			return rt.new_bool(Class_WP_Navigation_Block_Renderer.is_interactive(dispatch_arg_0,
				dispatch_arg_1))
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
			return Class_WP_Navigation_Block_Renderer.get_inner_blocks_html(dispatch_arg_0,
				dispatch_arg_1)
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
			return Class_WP_Navigation_Block_Renderer.get_overlay_blocks_from_template_part(dispatch_arg_0,
				dispatch_arg_1)
		}
		'get_inner_blocks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Navigation_Block_Renderer.get_inner_blocks(dispatch_arg_0,
				dispatch_arg_1)
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
			return Class_WP_Navigation_Block_Renderer.get_responsive_container_classes(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'get_overlay_inline_styles' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_WP_Navigation_Block_Renderer.get_overlay_inline_styles(dispatch_arg_0,
				dispatch_arg_1))
		}
		'get_responsive_container_markup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WP_Navigation_Block_Renderer.get_responsive_container_markup(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'get_nav_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Navigation_Block_Renderer.get_nav_attributes(dispatch_arg_0,
				dispatch_arg_1)
		}
		'get_nav_element_directives' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WP_Navigation_Block_Renderer.get_nav_element_directives(dispatch_arg_0))
		}
		'handle_view_script_module_loading' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_WP_Navigation_Block_Renderer.handle_view_script_module_loading(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_inner_block_markup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Navigation_Block_Renderer.get_inner_block_markup(dispatch_arg_0,
				dispatch_arg_1)
		}
		'get_unique_navigation_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Navigation_Block_Renderer.get_unique_navigation_name(dispatch_arg_0)
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(Class_WP_Navigation_Block_Renderer.render(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Navigation_Block_Renderer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Navigation_Block_Renderer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn (mut this Class_WP_Block_Type_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Type_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Navigation_Fallback) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Navigation_Fallback) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Navigation_Fallback) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('defined', [rt.new_string('IS_GUTENBERG_PLUGIN')]))
		&& rt.is_true(rt.get_constant('IS_GUTENBERG_PLUGIN')) {
	}
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_navigation')])
	rt.call_function('add_filter', [rt.new_string('render_block_data'),
		rt.new_string('block_core_navigation_typographic_presets_backcompatibility')])
}
