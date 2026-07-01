import rt

fn render_block_core_post_featured_image(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('postId'))) {
		return ''
	}
	mut var_post_ID := rt.get_property(var_block, 'context').array_get('postId')
	mut var_is_link := var_attributes.array_isset(rt.new_string('isLink'))
		&& rt.is_true(var_attributes.array_get('isLink'))
	mut var_size_slug := if !(var_attributes.array_get('sizeSlug')).is_null() {
		var_attributes.array_get('sizeSlug')
	} else {
		rt.new_string('post-thumbnail')
	}
	mut var_attr := get_block_core_post_featured_image_border_attributes(var_attributes.dup())
	mut var_overlay_markup :=
		rt.new_string(rt.new_string(get_block_core_post_featured_image_overlay_element_markup(var_attributes.dup())))
	if var_is_link {
		mut var_title := rt.call_function('get_the_title', [var_post_ID.dup()])
		if rt.is_true(var_title) {
			var_attr.array_set('alt', rt.call_function('strip_tags', [
				var_title.dup()]).to_string().trim_space())
		} else {
			var_attr.array_set('alt', rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Untitled post %d')]),
				var_post_ID.dup(),
			]))
		}
	}
	mut var_extra_styles := ''
	if !(!rt.is_true(var_attributes.array_get('aspectRatio'))) {
		// unsupported expression: Expr_AssignOp_Concat
	} else if !(!rt.is_true(var_attributes.array_get('height'))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if !(!rt.is_true(var_attributes.array_get('scale'))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if !(!rt.is_true(var_attributes.array_get('style').array_get('shadow'))) {
		mut var_shadow_styles := rt.call_function('wp_style_engine_get_styles', [
			rt.create_array([
				rt.ArrayItem{
					key: 'shadow'
					val: var_attributes.array_get('style').array_get('shadow')
				},
			]),
		])
		if !(!rt.is_true(var_shadow_styles.array_get('css'))) {
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	if !(var_extra_styles == '') {
		var_attr.array_set('style', if !rt.is_true(var_attr.array_get('style')) {
			var_extra_styles
		} else {
			(var_attr.array_get('style')).str() + var_extra_styles
		})
	}
	mut var_featured_image := rt.call_function('get_the_post_thumbnail', [
		var_post_ID.dup(), var_size_slug.dup(), var_attr.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(var_attributes.array_get('useFirstImageFromPost'))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_featured_image))))))
	{
		mut var_content_post := rt.call_function('get_post', [
			var_post_ID.dup()])
		var_content = rt.get_property(var_content_post, 'post_content')
		mut var_processor := create_wp_html_tag_processor(var_content.dup())
		if rt.is_true(var_processor.next_tag(rt.new_string('img'))) {
			mut var_tag_html := create_wp_html_tag_processor(rt.new_string('<img>'))
			var_tag_html.next_tag()
			{
				mut iter_1 :=
					var_processor.get_attribute_names_with_prefix(rt.new_string('')).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_name := item_1.val
					var_tag_html.set_attribute(var_name.dup(),
						var_processor.get_attribute(var_name.dup()))
				}
			}
			var_featured_image = var_tag_html.get_updated_html()
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_featured_image)))) {
		return ''
	}
	if var_is_link {
		mut var_link_target := var_attributes.array_get('linkTarget')
		mut var_rel := rt.new_string(if !(!rt.is_true(var_attributes.array_get('rel'))) {
			'rel="' + (rt.call_function('esc_attr', [var_attributes.array_get('rel')])).str() + '"'
		} else {
			rt.new_string('')
		})
		mut var_height := rt.new_string(if !(!rt.is_true(var_attributes.array_get('height'))) {
			'style="' +
				(rt.call_function('esc_attr', [rt.call_function('safecss_filter_attr', ['height:' + (var_attributes.array_get('height')).str()])])).str() + '"'
		} else {
			rt.new_string('')
		})
		var_featured_image = rt.call_function('sprintf', [
			rt.new_string('<a href="%1$s" target="%2$s" %3$s %4$s>%5$s%6$s</a>'),
			rt.call_function('get_the_permalink', [var_post_ID.dup()]),
			rt.call_function('esc_attr', [var_link_target.dup()]),
			var_rel.dup(),
			var_height.dup(),
			var_featured_image.dup(),
			var_overlay_markup.dup(),
		])
	} else {
		var_featured_image = rt.new_string(rt.concat(var_featured_image, var_overlay_markup))
	}
	mut var_aspect_ratio := rt.new_string(if !(!rt.is_true(var_attributes.array_get('aspectRatio'))) {
		(rt.call_function('esc_attr', [rt.call_function('safecss_filter_attr', ['aspect-ratio:' +
			(var_attributes.array_get('aspectRatio')).str()])])).str() + ';'
	} else {
		rt.new_string('')
	})
	mut var_width := rt.new_string(if !(!rt.is_true(var_attributes.array_get('width'))) {
		(rt.call_function('esc_attr', [rt.call_function('safecss_filter_attr', ['width:' +
			(var_attributes.array_get('width')).str()])])).str() + ';'
	} else {
		rt.new_string('')
	})
	var_height = rt.new_string(if !(!rt.is_true(var_attributes.array_get('height'))) {
		(rt.call_function('esc_attr', [rt.call_function('safecss_filter_attr', ['height:' +
			(var_attributes.array_get('height')).str()])])).str() + ';'
	} else {
		rt.new_string('')
	})
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_height))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_width))))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_aspect_ratio))))))
	{
		mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes',
			[]rt.PhpVal{})
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
	mut var_has_dim_background := var_attributes.array_isset(rt.new_string('dimRatio'))
		&& rt.is_true(var_attributes.array_get('dimRatio'))
	mut var_has_gradient := var_attributes.array_isset(rt.new_string('gradient'))
		&& rt.is_true(var_attributes.array_get('gradient'))
	mut var_has_custom_gradient := var_attributes.array_isset(rt.new_string('customGradient'))
		&& rt.is_true(var_attributes.array_get('customGradient'))
	mut var_has_solid_overlay := var_attributes.array_isset(rt.new_string('overlayColor'))
		&& rt.is_true(var_attributes.array_get('overlayColor'))
	mut var_has_custom_overlay := var_attributes.array_isset(rt.new_string('customOverlayColor'))
		&& rt.is_true(var_attributes.array_get('customOverlayColor'))
	mut var_class_names := [rt.new_string('wp-block-post-featured-image__overlay')]
	mut var_styles := rt.new_array()
	if !var_has_dim_background {
		return ''
	}
	mut var_border_attributes :=
		get_block_core_post_featured_image_border_attributes(var_attributes.dup())
	if !(!rt.is_true(var_border_attributes.array_get('class'))) {
		var_class_names << var_border_attributes.array_get('class')
	}
	if !(!rt.is_true(var_border_attributes.array_get('style'))) {
		var_styles.array_push(var_border_attributes.array_get('style'))
	}
	if var_has_dim_background {
		var_class_names << rt.new_string('has-background-dim')
		var_class_names << rt.concat(rt.new_string('has-background-dim-'),
			var_attributes.array_get('dimRatio'))
	}
	if var_has_solid_overlay {
		var_class_names << rt.concat(rt.concat(rt.new_string('has-'),
			var_attributes.array_get('overlayColor')), rt.new_string('-background-color'))
	}
	if var_has_gradient || var_has_custom_gradient {
		var_class_names << rt.new_string('has-background-gradient')
	}
	if var_has_gradient {
		var_class_names << rt.concat(rt.concat(rt.new_string('has-'),
			var_attributes.array_get('gradient')), rt.new_string('-gradient-background'))
	}
	if var_has_custom_gradient {
		var_styles.array_push(rt.call_function('sprintf', [
			rt.new_string('background-image: %s;'),
			var_attributes.array_get('customGradient'),
		]))
	}
	if var_has_custom_overlay {
		var_styles.array_push(rt.call_function('sprintf', [
			rt.new_string('background-color: %s;'),
			var_attributes.array_get('customOverlayColor'),
		]))
	}
	return (rt.call_function('sprintf', [
		rt.new_string('<span class="%s" style="%s" aria-hidden="true"></span>'),
		rt.call_function('esc_attr', [
			rt.call_function('implode', [rt.new_string(' '), var_class_names.dup()]),
		]),
		rt.call_function('esc_attr', [
			rt.call_function('safecss_filter_attr', [
				rt.call_function('implode', [rt.new_string(' '),
					var_styles.dup()]),
			]),
		]),
	])).str()
}

fn get_block_core_post_featured_image_border_attributes(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_border_styles := rt.new_array()
	mut var_sides := ['top', 'right', 'bottom', 'left']
	if var_attributes.array_get('style').array_get('border').array_isset(rt.new_string('radius')) {
		var_border_styles.array_set('radius',
			var_attributes.array_get('style').array_get('border').array_get('radius'))
	}
	if var_attributes.array_get('style').array_get('border').array_isset(rt.new_string('style')) {
		var_border_styles.array_set('style',
			var_attributes.array_get('style').array_get('border').array_get('style'))
	}
	if var_attributes.array_get('style').array_get('border').array_isset(rt.new_string('width')) {
		var_border_styles.array_set('width',
			var_attributes.array_get('style').array_get('border').array_get('width'))
	}
	mut var_preset_color := if rt.is_true(rt.new_bool(var_attributes.dup().array_isset(rt.new_string('borderColor')))) {
		rt.concat(rt.new_string('var:preset|color|'), var_attributes.array_get('borderColor'))
	} else {
		rt.new_null()
	}
	mut var_custom_color := if !(var_attributes.array_get('style').array_get('border').array_get('color')).is_null() {
		var_attributes.array_get('style').array_get('border').array_get('color')
	} else {
		rt.new_null()
	}
	var_border_styles.array_set('color', if rt.is_true(var_preset_color) {
		var_preset_color
	} else {
		var_custom_color
	})
	for var_side in var_sides {
		mut var_border := if !(var_attributes.array_get('style').array_get('border').array_get(side)).is_null() {
			var_attributes.array_get('style').array_get('border').array_get(side)
		} else {
			rt.new_null()
		}
		var_border_styles.array_set(side, rt.create_array([
			rt.ArrayItem{
				key: 'color'
				val: if !(var_border.array_get('color')).is_null() {
					var_border.array_get('color')
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'style'
				val: if !(var_border.array_get('style')).is_null() {
					var_border.array_get('style')
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'width'
				val: if !(var_border.array_get('width')).is_null() {
					var_border.array_get('width')
				} else {
					rt.new_null()
				}
			},
		]))
	}
	mut var_styles := rt.call_function('wp_style_engine_get_styles', [
		rt.create_array([rt.ArrayItem{ key: 'border', val: var_border_styles }]),
	])
	var_attributes = rt.new_array()
	if !(!rt.is_true(var_styles.array_get('classnames'))) {
		var_attributes['class'] = var_styles.array_get('classnames')
	}
	if !(!rt.is_true(var_styles.array_get('css'))) {
		var_attributes['style'] = var_styles.array_get('css')
	}
	return var_attributes.dup()
}

fn register_block_core_post_featured_image() {
	rt.call_function('register_block_type_from_metadata', [
		@DIR + '/post-featured-image',
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_post_featured_image' },
		]),
	])
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

pub fn init_wp_includes_blocks_post_featured_image_php() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_post_featured_image')])
}
