import rt

fn render_block_core_post_featured_image(var_attributes rt.PhpVal, var_content_arg rt.PhpVal, var_block rt.PhpVal) string {
	mut var_content := var_content_arg
	mut var_post_ID := rt.new_null()
	mut var_is_link := false
	mut var_size_slug := rt.new_null()
	mut var_attr := rt.new_null()
	mut var_overlay_markup := rt.new_null()
	mut var_title := rt.new_null()
	mut var_extra_styles := ''
	mut var_shadow_styles := rt.new_null()
	mut var_featured_image := rt.new_null()
	mut var_content_post := rt.new_null()
	mut var_processor := rt.new_null()
	mut var_tag_html := rt.new_null()
	mut var_name := rt.new_null()
	mut var_link_target := rt.new_null()
	mut var_rel := rt.new_null()
	mut var_height := rt.new_null()
	mut var_aspect_ratio := rt.new_null()
	mut var_width := rt.new_null()
	mut var_wrapper_attributes := rt.new_null()
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('postId'))) {
		return ''
	}
	var_post_ID = rt.get_property(var_block, 'context').array_get(rt.new_string('postId'))
	var_is_link = var_attributes.array_isset(rt.new_string('isLink'))
		&& rt.is_true(var_attributes.array_get(rt.new_string('isLink')))
	var_size_slug = if !(var_attributes.array_get(rt.new_string('sizeSlug'))).is_null() {
		var_attributes.array_get(rt.new_string('sizeSlug'))
	} else {
		rt.new_string('post-thumbnail')
	}
	var_attr =
		get_block_core_post_featured_image_border_attributes(rt.create_array_from_native_map(var_attributes))
	var_overlay_markup =
		rt.new_string(get_block_core_post_featured_image_overlay_element_markup(rt.create_array_from_native_map(var_attributes)))
	if var_is_link {
		var_title = rt.call_function('get_the_title', [var_post_ID.clone()])
		if rt.is_true(var_title) {
			var_attr.array_set('alt', rt.call_function('strip_tags', [
				var_title.clone()]).to_string().trim_space())
		} else {
			var_attr.array_set('alt', rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Untitled post %d')]),
				var_post_ID.clone(),
			]))
		}
	}
	var_extra_styles = ''
	if !(!rt.is_true(var_attributes.array_get(rt.new_string('aspectRatio')))) {
		var_extra_styles = var_extra_styles + 'width:100%;height:100%;'
	} else if !(!rt.is_true(var_attributes.array_get(rt.new_string('height')))) {
		var_extra_styles = var_extra_styles +
			rt.concat(rt.concat(rt.new_string('height:'), var_attributes.array_get(rt.new_string('height'))), rt.new_string(';'))
	}
	if !(!rt.is_true(var_attributes.array_get(rt.new_string('scale')))) {
		var_extra_styles = var_extra_styles +
			rt.concat(rt.concat(rt.new_string('object-fit:'), var_attributes.array_get(rt.new_string('scale'))), rt.new_string(';'))
	}
	if !(!rt.is_true(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('shadow')))) {
		var_shadow_styles = rt.call_function('wp_style_engine_get_styles', [
			rt.create_array([
				rt.ArrayItem{
					key: 'shadow'
					val: var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('shadow'))
				},
			]),
		])
		if !(!rt.is_true(var_shadow_styles.array_get(rt.new_string('css')))) {
			var_extra_styles = var_extra_styles +
				(var_shadow_styles.array_get(rt.new_string('css'))).str()
		}
	}
	if !(var_extra_styles == '') {
		var_attr.array_set('style', if !rt.is_true(var_attr.array_get(rt.new_string('style'))) {
			var_extra_styles
		} else {
			(var_attr.array_get(rt.new_string('style'))).str() + var_extra_styles
		})
	}
	var_featured_image = rt.call_function('get_the_post_thumbnail', [
		var_post_ID.clone(), var_size_slug.clone(), var_attr.clone()])
	if rt.is_true(var_attributes.array_get(rt.new_string('useFirstImageFromPost')))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_featured_image)))) {
		var_content_post = rt.call_function('get_post', [var_post_ID.clone()])
		var_content = rt.get_property(var_content_post, 'post_content')
		var_processor = create_wp_html_tag_processor(var_content.clone())
		if rt.is_true(var_processor.next_tag(rt.new_string('img'))) {
			var_tag_html = create_wp_html_tag_processor(rt.new_string('<img>'))
			var_tag_html.next_tag()
			mut iter_1 :=
				var_processor.get_attribute_names_with_prefix(rt.new_string('')).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_name_shadow := item_1.val
				var_tag_html.set_attribute(var_name_shadow.clone(),
					var_processor.get_attribute(var_name_shadow.clone()))
			}
			var_featured_image = var_tag_html.get_updated_html()
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_featured_image)))) {
		return ''
	}
	if var_is_link {
		var_link_target = var_attributes.array_get(rt.new_string('linkTarget'))
		var_rel = rt.new_string((if !(!rt.is_true(var_attributes.array_get(rt.new_string('rel')))) {
			'rel="' +
				(rt.call_function('esc_attr', [var_attributes.array_get(rt.new_string('rel'))])).str() +
				'"'
		} else {
			''
		}).str())
		var_height = rt.new_string((if !(!rt.is_true(var_attributes.array_get(rt.new_string('height')))) {
			'style="' +
				(rt.call_function('esc_attr', [rt.call_function('safecss_filter_attr', [rt.new_string('height:' + (var_attributes.array_get(rt.new_string('height'))).str())])])).str() + '"'
		} else {
			''
		}).str())
		var_featured_image = rt.call_function('sprintf', [
			rt.new_string('<a href="%1$s" target="%2$s" %3$s %4$s>%5$s%6$s</a>'),
			rt.call_function('get_the_permalink', [var_post_ID.clone()]),
			rt.call_function('esc_attr', [var_link_target.clone()]),
			var_rel.clone(),
			var_height.clone(),
			var_featured_image.clone(),
			var_overlay_markup.clone(),
		])
	} else {
		var_featured_image = rt.new_string(var_featured_image.str() + var_overlay_markup.str())
	}
	var_aspect_ratio = rt.new_string((if !(!rt.is_true(var_attributes.array_get(rt.new_string('aspectRatio')))) {
			(rt.call_function('esc_attr', [rt.call_function('safecss_filter_attr', [rt.new_string('aspect-ratio:' +
			(var_attributes.array_get(rt.new_string('aspectRatio'))).str())])])).str() + ';'
	} else {
		''
	}).str())
	var_width = rt.new_string((if !(!rt.is_true(var_attributes.array_get(rt.new_string('width')))) {
		(rt.call_function('esc_attr', [rt.call_function('safecss_filter_attr', [rt.new_string('width:' +
			(var_attributes.array_get(rt.new_string('width'))).str())])])).str() + ';'
	} else {
		''
	}).str())
	var_height = rt.new_string((if !(!rt.is_true(var_attributes.array_get(rt.new_string('height')))) {
		(rt.call_function('esc_attr', [rt.call_function('safecss_filter_attr', [rt.new_string('height:' +
			(var_attributes.array_get(rt.new_string('height'))).str())])])).str() + ';'
	} else {
		''
	}).str())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_height))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_width))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_aspect_ratio)))) {
		var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{})
	} else {
		var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
			rt.create_array([
				rt.ArrayItem{ key: 'style', val: var_aspect_ratio.str() + var_width.str() +
					var_height.str() },
			]),
		])
	}
	return '<figure ${var_wrapper_attributes.to_string()}>${var_featured_image.to_string()}</figure>'
}

fn get_block_core_post_featured_image_overlay_element_markup(var_attributes rt.PhpVal) string {
	mut var_has_dim_background := false
	mut var_has_gradient := false
	mut var_has_custom_gradient := false
	mut var_has_solid_overlay := false
	mut var_has_custom_overlay := false
	mut var_class_names := []rt.PhpVal{}
	mut var_styles := rt.new_null()
	mut var_border_attributes := rt.new_null()
	var_has_dim_background = var_attributes.array_isset(rt.new_string('dimRatio'))
		&& rt.is_true(var_attributes.array_get(rt.new_string('dimRatio')))
	var_has_gradient = var_attributes.array_isset(rt.new_string('gradient'))
		&& rt.is_true(var_attributes.array_get(rt.new_string('gradient')))
	var_has_custom_gradient = var_attributes.array_isset(rt.new_string('customGradient'))
		&& rt.is_true(var_attributes.array_get(rt.new_string('customGradient')))
	var_has_solid_overlay = var_attributes.array_isset(rt.new_string('overlayColor'))
		&& rt.is_true(var_attributes.array_get(rt.new_string('overlayColor')))
	var_has_custom_overlay = var_attributes.array_isset(rt.new_string('customOverlayColor'))
		&& rt.is_true(var_attributes.array_get(rt.new_string('customOverlayColor')))
	var_class_names = [rt.new_string('wp-block-post-featured-image__overlay')]
	var_styles = rt.new_array()
	if !var_has_dim_background {
		return ''
	}
	var_border_attributes =
		get_block_core_post_featured_image_border_attributes(rt.create_array_from_native_map(var_attributes))
	if !(!rt.is_true(var_border_attributes.array_get(rt.new_string('class')))) {
		var_class_names << var_border_attributes.array_get(rt.new_string('class'))
	}
	if !(!rt.is_true(var_border_attributes.array_get(rt.new_string('style')))) {
		var_styles.array_push(var_border_attributes.array_get(rt.new_string('style')))
	}
	if var_has_dim_background {
		var_class_names << rt.new_string('has-background-dim')
		var_class_names << rt.concat(rt.new_string('has-background-dim-'),
			var_attributes.array_get(rt.new_string('dimRatio')))
	}
	if var_has_solid_overlay {
		var_class_names << rt.concat(rt.concat(rt.new_string('has-'),
			var_attributes.array_get(rt.new_string('overlayColor'))),
			rt.new_string('-background-color'))
	}
	if var_has_gradient || var_has_custom_gradient {
		var_class_names << rt.new_string('has-background-gradient')
	}
	if var_has_gradient {
		var_class_names << rt.concat(rt.concat(rt.new_string('has-'),
			var_attributes.array_get(rt.new_string('gradient'))),
			rt.new_string('-gradient-background'))
	}
	if var_has_custom_gradient {
		var_styles.array_push(rt.call_function('sprintf', [
			rt.new_string('background-image: %s;'),
			var_attributes.array_get(rt.new_string('customGradient')),
		]))
	}
	if var_has_custom_overlay {
		var_styles.array_push(rt.call_function('sprintf', [
			rt.new_string('background-color: %s;'),
			var_attributes.array_get(rt.new_string('customOverlayColor')),
		]))
	}
	return (rt.call_function('sprintf', [
		rt.new_string('<span class="%s" style="%s" aria-hidden="true"></span>'),
		rt.call_function('esc_attr', [
			rt.call_function('implode',
				[rt.new_string(' '), rt.create_array_from_list(var_class_names)]),
		]),
		rt.call_function('esc_attr', [
			rt.call_function('safecss_filter_attr', [
				rt.call_function('implode', [rt.new_string(' '),
					var_styles.clone()]),
			]),
		]),
	])).str()
}

fn get_block_core_post_featured_image_border_attributes(var_attributes_arg rt.PhpVal) rt.PhpVal {
	mut var_attributes := var_attributes_arg
	mut var_border_styles := rt.new_null()
	mut var_sides := []rt.PhpVal{}
	mut var_preset_color := rt.new_null()
	mut var_custom_color := rt.new_null()
	mut var_side := rt.new_null()
	mut var_border := rt.new_null()
	mut var_styles := rt.new_null()
	var_border_styles = rt.new_array()
	var_sides = ['top', 'right', 'bottom', 'left']
	if var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_isset(rt.new_string('radius')) {
		var_border_styles.array_set('radius',
			var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string('radius')))
	}
	if var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_isset(rt.new_string('style')) {
		var_border_styles.array_set('style',
			var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string('style')))
	}
	if var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_isset(rt.new_string('width')) {
		var_border_styles.array_set('width',
			var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string('width')))
	}
	var_preset_color = if rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_attributes).array_isset(rt.new_string('borderColor')))) {
		rt.concat(rt.new_string('var:preset|color|'),
			var_attributes.array_get(rt.new_string('borderColor')))
	} else {
		rt.new_null()
	}
	var_custom_color = if !(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string('color'))).is_null() {
		var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string('color'))
	} else {
		rt.new_null()
	}
	var_border_styles.array_set('color', if rt.is_true(var_preset_color) {
		var_preset_color
	} else {
		var_custom_color
	})
	for var_side_shadow in var_sides {
		var_border = if !(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string(var_side_shadow.str()))).is_null() {
			var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string(var_side_shadow.str()))
		} else {
			rt.new_null()
		}
		var_border_styles.array_set(rt.new_string(var_side_shadow.str()), rt.create_array([
			rt.ArrayItem{
				key: 'color'
				val: if !(var_border.array_get(rt.new_string('color'))).is_null() {
					var_border.array_get(rt.new_string('color'))
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'style'
				val: if !(var_border.array_get(rt.new_string('style'))).is_null() {
					var_border.array_get(rt.new_string('style'))
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'width'
				val: if !(var_border.array_get(rt.new_string('width'))).is_null() {
					var_border.array_get(rt.new_string('width'))
				} else {
					rt.new_null()
				}
			},
		]))
	}
	var_styles = rt.call_function('wp_style_engine_get_styles', [
		rt.create_array([rt.ArrayItem{ key: 'border', val: var_border_styles }]),
	])
	var_attributes = rt.new_array()
	if !(!rt.is_true(var_styles.array_get(rt.new_string('classnames')))) {
		var_attributes['class'] = var_styles.array_get(rt.new_string('classnames'))
	}
	if !(!rt.is_true(var_styles.array_get(rt.new_string('css')))) {
		var_attributes['style'] = var_styles.array_get(rt.new_string('css'))
	}
	return var_attributes.clone()
}

fn register_block_core_post_featured_image() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/post-featured-image'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_post_featured_image' },
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

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_post_featured_image')])
}
