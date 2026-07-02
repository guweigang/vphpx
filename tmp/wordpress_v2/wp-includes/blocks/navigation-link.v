import rt

fn block_core_navigation_link_build_css_colors(var_context rt.PhpVal, var_attributes rt.PhpVal, is_sub_menu bool) rt.PhpVal {
	mut var_is_sub_menu := is_sub_menu
	mut var_colors := map[string]rt.PhpVal{}
	mut var_named_text_color := rt.new_null()
	mut var_custom_text_color := rt.new_null()
	mut var_named_background_color := rt.new_null()
	mut var_custom_background_color := rt.new_null()
	var_colors = {
		'css_classes':   map[string]rt.PhpVal{}
		'inline_styles': rt.new_string('')
	}
	var_named_text_color = rt.new_null()
	var_custom_text_color = rt.new_null()
	if var_is_sub_menu
		&& rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_context).array_isset(rt.new_string('customOverlayTextColor')))) {
		var_custom_text_color = var_context.array_get(rt.new_string('customOverlayTextColor'))
	} else if var_is_sub_menu
		&& rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_context).array_isset(rt.new_string('overlayTextColor')))) {
		var_named_text_color = var_context.array_get(rt.new_string('overlayTextColor'))
	} else if rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_context).array_isset(rt.new_string('customTextColor')))) {
		var_custom_text_color = var_context.array_get(rt.new_string('customTextColor'))
	} else if rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_context).array_isset(rt.new_string('textColor')))) {
		var_named_text_color = var_context.array_get(rt.new_string('textColor'))
	} else if var_context.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_isset(rt.new_string('text')) {
		var_custom_text_color =
			var_context.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('text'))
	}
	if !(var_named_text_color.clone().is_null()) {
		var_colors['css_classes'].array_push(rt.new_string('has-text-color'))
	} else if !(var_custom_text_color.clone().is_null()) {
		var_colors.array_get_mut('css_classes').array_push('has-text-color')
		var_colors['inline_styles'] = rt.concat(var_colors['inline_styles'], rt.call_function('sprintf', [
			rt.new_string('color: %s;'),
			var_custom_text_color.clone(),
		]))
	}
	var_named_background_color = rt.new_null()
	var_custom_background_color = rt.new_null()
	if var_is_sub_menu
		&& rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_context).array_isset(rt.new_string('customOverlayBackgroundColor')))) {
		var_custom_background_color =
			var_context.array_get(rt.new_string('customOverlayBackgroundColor'))
	} else if var_is_sub_menu
		&& rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_context).array_isset(rt.new_string('overlayBackgroundColor')))) {
		var_named_background_color = var_context.array_get(rt.new_string('overlayBackgroundColor'))
	} else if rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_context).array_isset(rt.new_string('customBackgroundColor')))) {
		var_custom_background_color = var_context.array_get(rt.new_string('customBackgroundColor'))
	} else if rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_context).array_isset(rt.new_string('backgroundColor')))) {
		var_named_background_color = var_context.array_get(rt.new_string('backgroundColor'))
	} else if var_context.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_isset(rt.new_string('background')) {
		var_custom_background_color =
			var_context.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('background'))
	}
	if !(var_named_background_color.clone().is_null()) {
		var_colors['css_classes'].array_push(rt.new_string('has-background'))
	} else if !(var_custom_background_color.clone().is_null()) {
		var_colors.array_get_mut('css_classes').array_push('has-background')
		var_colors['inline_styles'] = rt.concat(var_colors['inline_styles'], rt.call_function('sprintf', [
			rt.new_string('background-color: %s;'),
			var_custom_background_color.clone(),
		]))
	}
	return var_colors.clone()
}

fn block_core_navigation_link_build_css_font_sizes(var_context rt.PhpVal) rt.PhpVal {
	mut var_font_sizes := rt.new_null()
	mut var_has_named_font_size := false
	mut var_has_custom_font_size := rt.new_null()
	var_font_sizes = rt.create_array([
		rt.ArrayItem{
			key: 'css_classes'
			val: map[string]rt.PhpVal{}
		},
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

fn block_core_navigation_link_maybe_urldecode(var_url rt.PhpVal) rt.PhpVal {
	mut var_is_url_encoded := false
	mut var_query := rt.new_null()
	mut var_query_params := rt.new_null()
	mut var_query_param := rt.new_null()
	mut var_can_query_param_be_encoded := false
	var_is_url_encoded = false
	var_query = rt.call_function('parse_url', [var_url.clone(),
		rt.get_constant('PHP_URL_QUERY')])
	var_query_params = rt.call_function('wp_parse_args', [var_query.clone()])
	mut iter_1 := var_query_params.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_query_param_shadow := item_1.val
		var_can_query_param_be_encoded = var_query_param_shadow.clone().is_string()
			&& !(!rt.is_true(var_query_param_shadow))
		if !var_can_query_param_be_encoded {
			continue
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('rawurldecode', [
			var_query_param_shadow.clone(),
		]), var_query_param_shadow))))
		{
			var_is_url_encoded = true
			break
		}
	}
	if var_is_url_encoded {
		return rt.call_function('rawurldecode', [var_url.clone()])
	}
	return var_url.clone()
}

fn render_block_core_navigation_link(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_font_sizes := rt.new_null()
	mut var_classes := rt.new_null()
	mut var_style_attribute := rt.new_null()
	mut var_inner_blocks_html := ''
	mut var_inner_block := rt.new_null()
	mut var_has_submenu := false
	mut var_css_classes := ''
	mut var_kind := rt.new_null()
	mut var_is_active := false
	mut var_queried_archive_link := rt.new_null()
	mut var_wrapper_attributes := rt.new_null()
	mut var_html := rt.new_null()
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
	var_font_sizes = block_core_navigation_link_build_css_font_sizes(rt.get_property(var_block,
		'context'))
	var_classes = rt.call_function('array_merge', [
		var_font_sizes.array_get(rt.new_string('css_classes')),
	])
	var_style_attribute = var_font_sizes.array_get(rt.new_string('inline_styles'))
	var_inner_blocks_html = ''
	mut iter_2 := rt.get_property(var_block, 'inner_blocks').iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_inner_block_shadow := item_2.val
		var_inner_blocks_html = var_inner_blocks_html +
			(rt.call_method(var_inner_block_shadow, 'render', []rt.PhpVal{})).str()
	}
	var_has_submenu = !(var_inner_blocks_html.trim_space() == '')
	var_css_classes = rt.call_function('implode', [rt.new_string(' '),
		var_classes.clone()]).to_string().trim_space()
	var_kind = if !rt.is_true(var_attributes.array_get(rt.new_string('kind'))) { rt.new_string('post_type') } else { rt.call_function('str_replace', [
			rt.new_string('-'),
			rt.new_string('_'),
			var_attributes.array_get(rt.new_string('kind')),
		]) }
	var_is_active = !(!rt.is_true(var_attributes.array_get(rt.new_string('id'))))
		&& rt.is_true(rt.identical(rt.call_function('get_queried_object_id', []rt.PhpVal{}), rt.new_int((var_attributes.array_get(rt.new_string('id'))).to_i64())))
		&& !(!rt.is_true(rt.get_property(rt.call_function('get_queried_object', []rt.PhpVal{}), '{"nodeType":"Expr_Variable","line":198,"name":"kind"}')))
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
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'class', val: var_css_classes + ' wp-block-navigation-item' +
				if var_has_submenu { ' has-child' } else { '' } +
				if var_is_active { ' current-menu-item' } else { '' } },
			rt.ArrayItem{ key: 'style', val: var_style_attribute },
		]),
	])
	var_html = rt.new_string('<li ' + var_wrapper_attributes.str() + '>' +
		'<a class="wp-block-navigation-item__content" ')
	if var_attributes.array_isset(rt.new_string('url')) {
		var_html = rt.concat(var_html, rt.new_string(' href="' +
			(rt.call_function('esc_url', [block_core_navigation_link_maybe_urldecode(var_attributes.array_get(rt.new_string('url')))])).str() +
			'"'))
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
	var_html = rt.concat(var_html, rt.new_string('>' +
		'<span class="wp-block-navigation-item__label">'))
	if var_attributes.array_isset(rt.new_string('label')) {
		var_html = rt.concat(var_html, rt.call_function('wp_kses_post', [
			var_attributes.array_get(rt.new_string('label')),
		]))
	}
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
	if rt.get_property(var_block, 'context').array_isset(rt.new_string('showSubmenuIcon'))
		&& rt.is_true(rt.get_property(var_block, 'context').array_get(rt.new_string('showSubmenuIcon')))
		&& var_has_submenu {
		var_html = rt.concat(var_html, rt.new_string(
			'<span class="wp-block-navigation__submenu-icon">' +
			(rt.call_function('block_core_navigation_render_submenu_icon', []rt.PhpVal{})).str() +
			'</span>'))
	}
	if var_has_submenu {
		var_html = rt.concat(var_html, rt.call_function('sprintf', [
			rt.new_string('<ul class="wp-block-navigation__submenu-container">%s</ul>'),
			rt.new_string(var_inner_blocks_html.str()).clone(),
		]))
	}
	var_html = rt.concat(var_html, rt.new_string('</li>'))
	return var_html.str()
}

fn build_variation_for_navigation_link(var_entity rt.PhpVal, kind string) rt.PhpVal {
	mut var_kind := kind
	mut var_title := rt.new_null()
	mut var_description := rt.new_null()
	mut var_default_labels := rt.new_null()
	mut var_is_default_title := rt.new_null()
	mut var_is_default_description := rt.new_null()
	mut var_singular := rt.new_null()
	mut var_variation := rt.new_null()
	mut var_variation_overrides := rt.new_null()
	var_title = rt.new_string('')
	var_description = rt.new_string('')
	var_default_labels = rt.new_null()
	if rt.is_true(rt.new_bool(rt.instance_of(var_entity, 'WP_Post_Type'))) {
		mut iife_temp_0 := Class_WP_Post_Type{}
		mut iife_result_0 := iife_temp_0.get_default_labels()
		var_default_labels = iife_result_0
	} else if rt.is_true(rt.new_bool(rt.instance_of(var_entity, 'WP_Taxonomy'))) {
		mut iife_temp_1 := Class_WP_Taxonomy{}
		mut iife_result_1 := iife_temp_1.get_default_labels()
		var_default_labels = iife_result_1
	}
	var_is_default_title = rt.new_bool(false)
	if rt.is_true(rt.call_function('property_exists', [
		rt.get_property(var_entity, 'labels'),
		rt.new_string('item_link'),
	]))
	{
		var_title = rt.get_property(rt.get_property(var_entity, 'labels'), 'item_link')
		if var_default_labels.array_isset(rt.new_string('item_link')) {
			var_is_default_title = rt.call_function('in_array', [
				var_title.clone(), var_default_labels.array_get(rt.new_string('item_link')),
				rt.new_bool(true)])
		}
	}
	var_is_default_description = rt.new_bool(false)
	if rt.is_true(rt.call_function('property_exists', [
		rt.get_property(var_entity, 'labels'),
		rt.new_string('item_link_description'),
	]))
	{
		var_description = rt.get_property(rt.get_property(var_entity, 'labels'),
			'item_link_description')
		if var_default_labels.array_isset(rt.new_string('item_link_description')) {
			var_is_default_description = rt.call_function('in_array', [
				var_description.clone(), var_default_labels.array_get(rt.new_string('item_link_description')),
				rt.new_bool(true)])
		}
	}
	var_singular = if !(rt.get_property(rt.get_property(var_entity, 'labels'), 'singular_name')).is_null() { rt.get_property(rt.get_property(var_entity, 'labels'), 'singular_name') } else { rt.call_function('ucfirst', [
			rt.get_property(var_entity, 'name'),
		]) }
	if rt.is_true(var_is_default_title) || rt.is_true(rt.identical(rt.new_string(''), var_title)) {
		var_title = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s link')]),
			var_singular.clone(),
		])
	}
	if rt.is_true(var_is_default_description)
		|| rt.is_true(rt.identical(rt.new_string(''), var_description)) {
		var_description = rt.new_string(' ')
	}
	var_variation = rt.create_array([
		rt.ArrayItem{ key: 'name', val: rt.get_property(var_entity, 'name') },
		rt.ArrayItem{ key: 'title', val: var_title },
		rt.ArrayItem{ key: 'description', val: var_description },
		rt.ArrayItem{ key: 'attributes', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: rt.get_property(var_entity, 'name') },
			rt.ArrayItem{ key: 'kind', val: kind },
		]) },
	])
	var_variation_overrides = rt.create_array([
		rt.ArrayItem{ key: 'post_tag', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'tag' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'tag' },
				rt.ArrayItem{ key: 'kind', val: kind },
			]) },
		]) },
		rt.ArrayItem{ key: 'post_format', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Post Format Link'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('A link to a post format'),
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'post_format' },
				rt.ArrayItem{ key: 'kind', val: kind },
			]) },
		]) },
	])
	if rt.is_true(rt.new_bool(var_variation_overrides.clone().array_isset(rt.get_property(var_entity,
		'name'))))
	{
		var_variation = rt.call_function('array_merge', [var_variation.clone(),
			var_variation_overrides.array_get(rt.get_property(var_entity, 'name'))])
	}
	return var_variation.clone()
}

fn block_core_navigation_link_filter_variations(var_variations rt.PhpVal, var_block_type rt.PhpVal) rt.PhpVal {
	mut var_generated_variations := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('core/navigation-link'), rt.get_property(var_block_type,
		'name')))))
	{
		return var_variations.clone()
	}
	var_generated_variations = block_core_navigation_link_build_variations()
	return rt.call_function('array_merge', [var_generated_variations.clone(),
		rt.create_array_from_list(var_variations)])
}

fn block_core_navigation_link_build_variations() rt.PhpVal {
	mut var_post_types := rt.new_null()
	mut var_taxonomies := rt.new_null()
	mut var_built_ins := []rt.PhpVal{}
	mut var_variations := []rt.PhpVal{}
	mut var_post_type := rt.new_null()
	mut var_variation := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_all_variations := rt.new_null()
	var_post_types = rt.call_function('get_post_types', [
		rt.create_array([rt.ArrayItem{ key: 'show_in_nav_menus', val: true }]),
		rt.new_string('objects'),
	])
	var_taxonomies = rt.call_function('get_taxonomies', [
		rt.create_array([rt.ArrayItem{ key: 'show_in_nav_menus', val: true }]),
		rt.new_string('objects'),
	])
	var_built_ins = map[string]rt.PhpVal{}
	var_variations = map[string]rt.PhpVal{}
	if rt.is_true(var_post_types) {
		mut iter_3 := var_post_types.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_post_type_shadow := item_3.val
			var_variation = build_variation_for_navigation_link(var_post_type_shadow.clone(),
				'post-type')
			if rt.is_true(rt.get_property(var_post_type_shadow, '_builtin')) {
				var_built_ins << var_variation.clone()
			} else {
				var_variations << var_variation.clone()
			}
		}
	}
	if rt.is_true(var_taxonomies) {
		mut iter_4 := var_taxonomies.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_taxonomy_shadow := item_4.val
			var_variation = build_variation_for_navigation_link(var_taxonomy_shadow.clone(),
				'taxonomy')
			if rt.is_true(rt.get_property(var_taxonomy_shadow, '_builtin')) {
				var_built_ins << var_variation.clone()
			} else {
				var_variations << var_variation.clone()
			}
		}
	}
	var_all_variations = rt.call_function('array_merge', [
		rt.create_array_from_list(var_built_ins),
		rt.create_array_from_list(var_variations),
	])
	return var_all_variations.clone()
}

fn register_block_core_navigation_link() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/navigation-link'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_navigation_link' },
		]),
	])
}

struct Class_WP_Post_Type {
	rt.PhpObjectBase
}

struct Class_WP_Taxonomy {
	rt.PhpObjectBase
}

fn create_wp_post_type(_args ...rt.PhpVal) &Class_WP_Post_Type {
	mut obj := &Class_WP_Post_Type{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_taxonomy(_args ...rt.PhpVal) &Class_WP_Taxonomy {
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

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('file_exists', [
		rt.new_string(@DIR + '/shared/item-should-render.php'),
	]))
	{
		rt.include_file(@DIR + '/shared/item-should-render.php', '4')
		rt.include_file(@DIR + '/shared/render-submenu-icon.php', '4')
	} else {
		rt.include_file(@DIR + '/navigation-link/shared/item-should-render.php', '4')
		rt.include_file(@DIR + '/navigation-link/shared/render-submenu-icon.php', '4')
	}
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_navigation_link')])
	rt.call_function('add_action', [rt.new_string('get_block_type_variations'),
		rt.new_string('block_core_navigation_link_filter_variations'),
		rt.new_int(10), rt.new_int(2)])
}
