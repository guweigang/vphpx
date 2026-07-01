import rt

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Image {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Image) render_content(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_parsed_block_mutated := var_parsed_block
	mut var_product := this.get_product_from_context(rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array', []string{}, var_parsed_block_mutated))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return ''
	}
	mut var_attributes := this.parse_attributes(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if !(var_parsed_block_mutated.array_get('attrs')).is_null() { var_parsed_block_mutated.array_get('attrs') } else { rt.new_array() }))
	mut var_image_data := this.get_product_image_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WC_Product](var_product), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](var_attributes))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_image_data)))) {
		return ''
	}
	var_parsed_block_mutated = this.add_image_size_when_missing(mut var_parsed_block_mutated, mut var_rendering_context)
	var_attributes = this.parse_attributes(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if !(var_parsed_block_mutated.array_get('attrs')).is_null() { var_parsed_block_mutated.array_get('attrs') } else { rt.new_array() }))
	mut var_image_html := rt.new_string(this.build_image_html(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](var_image_data), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](var_attributes), mut var_rendering_context))
	mut var_inner_blocks := this.process_inner_blocks(mut var_parsed_block_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WC_Product](var_product), mut var_rendering_context)
	mut var_combined_content := rt.new_string(this.create_overlay_structure((var_image_html).str(), (var_inner_blocks.array_get('badges')).str(), (var_inner_blocks.array_get('other_content')).str(), (var_inner_blocks.array_get('badge_alignment')).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_?WC_Product](var_product), (var_attributes.array_get('showProductLink')).to_bool()))
	return this.apply_email_wrapper((var_combined_content).str(), mut var_parsed_block_mutated, mut var_rendering_context)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Image) process_inner_blocks(mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, mut var_product Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WC_Product, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) rt.PhpVal {
	mut var_parsed_block_mutated := var_parsed_block
	mut var_product_mutated := var_product
	mut var_badges := rt.new_string(rt.new_string(''))
	mut var_other_content := rt.new_string(rt.new_string(''))
	mut var_badge_alignment := rt.new_string(rt.new_string('left'))
	if !(!rt.is_true(var_parsed_block_mutated.array_get('innerBlocks'))) {
		{
			mut iter_1 := var_parsed_block_mutated.array_get('innerBlocks').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_inner_block := item_1.val
				var_inner_block.array_set('context', if !(var_inner_block.array_get('context')).is_null() { var_inner_block.array_get('context') } else { rt.new_array() })
				var_inner_block.array_get_mut('context').array_set('postId', rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}))
				if rt.is_true(rt.identical(rt.new_string('woocommerce/product-sale-badge'), var_inner_block.array_get('blockName'))) {
					// unsupported expression: Expr_AssignOp_Concat
					var_badge_alignment = if !(var_inner_block.array_get('attrs').array_get('align')).is_null() { var_inner_block.array_get('attrs').array_get('align') } else { rt.new_string('left') }
				} else {
					// unsupported expression: Expr_AssignOp_Concat
				}
			}
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'badges', val: var_badges }, rt.ArrayItem{ key: 'other_content', val: var_other_content }, rt.ArrayItem{ key: 'badge_alignment', val: var_badge_alignment }])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Image) render_overlay_badge(mut var_badge_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, mut var_product Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WC_Product, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_product_mutated := var_product
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product_mutated, 'is_on_sale', []rt.PhpVal{}))))) {
		return ''
	}
	mut var_sale_text := rt.call_function('apply_filters', [rt.new_string('woocommerce_sale_badge_text'), rt.call_function('__', [rt.new_string('Sale'), rt.new_string('woocommerce')]), var_product_mutated.dup()])
	mut var_badge_attributes := rt.call_function('array_replace_recursive', [rt.create_array([rt.ArrayItem{ key: 'textColor', val: '#43454b' }, rt.ArrayItem{ key: 'backgroundColor', val: '#fff' }, rt.ArrayItem{ key: 'style', val: rt.create_array([rt.ArrayItem{ key: 'border', val: rt.create_array([rt.ArrayItem{ key: 'width', val: '1px' }, rt.ArrayItem{ key: 'radius', val: '4px' }, rt.ArrayItem{ key: 'color', val: '#43454b' }]) }, rt.ArrayItem{ key: 'spacing', val: rt.create_array([rt.ArrayItem{ key: 'padding', val: '4px 12px' }]) }, rt.ArrayItem{ key: 'typography', val: rt.create_array([rt.ArrayItem{ key: 'fontSize', val: '14px' }, rt.ArrayItem{ key: 'fontWeight', val: '600' }, rt.ArrayItem{ key: 'textTransform', val: 'uppercase' }, rt.ArrayItem{ key: 'lineHeight', val: '1.5' }]) }]) }]), rt.call_function('wp_parse_args', [if !(var_badge_block.array_get('attrs')).is_null() { var_badge_block.array_get('attrs') } else { rt.new_array() }])])
	mut var_block_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.get_block_styles(arg_0, arg_1, arg_2) }(var_badge_attributes.dup(), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context', []string{}, var_rendering_context), rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'background-color' }, rt.ArrayItem{ key: none, val: 'color' }, rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'spacing' }]))
	mut var_additional_styles := rt.create_array([rt.ArrayItem{ key: 'display', val: 'inline-block' }, rt.ArrayItem{ key: 'width', val: 'fit-content' }, rt.ArrayItem{ key: 'box-sizing', val: 'border-box' }])
	mut var_final_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.extend_block_styles(arg_0, arg_1) }(var_block_styles.dup(), var_additional_styles.dup())
	return (rt.call_function('sprintf', [rt.new_string('<span class="wc-block-components-product-sale-badge__text" style="%s">%s</span>'), rt.call_function('esc_attr', [var_final_styles.array_get('css')]), rt.call_function('esc_html', [var_sale_text.dup()])])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Image) create_overlay_structure(image_html string, badges_html string, other_content string, badge_alignment string, mut var_product Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_?WC_Product, show_product_link bool) string {
	mut image_html_mutated := image_html
	mut other_content_mutated := other_content
	mut badge_alignment_mutated := badge_alignment
	mut var_product_mutated := var_product
	if badges_html == '' {
		mut var_linked_image_html := rt.new_string(rt.new_string(image_html_mutated)).dup()
		if rt.is_true(rt.new_bool(var_show_product_link && rt.is_true(var_product_mutated))) {
			var_linked_image_html = rt.new_string(this.wrap_with_link(image_html_mutated, mut var_product_mutated))
		}
		return (var_linked_image_html).str() + other_content_mutated
	}
	mut var_image_width := rt.new_float(this.extract_image_width(image_html_mutated))
	mut var_image_height := rt.new_float(this.extract_image_height(image_html_mutated))
	var_linked_image_html = rt.new_string(rt.new_string(image_html_mutated)).dup()
	if rt.is_true(rt.new_bool(var_show_product_link && rt.is_true(var_product_mutated))) {
		var_linked_image_html = rt.new_string(this.wrap_with_link(image_html_mutated, mut var_product_mutated))
	}
	mut var_vml_side := rt.new_string(if rt.is_true(rt.identical(rt.new_string('left'), rt.new_string(badge_alignment_mutated))) { rt.new_string('left') } else { rt.new_string('right') })
	mut var_overlay_html := rt.call_function('sprintf', ['<table cellpadding="0" cellspacing="0" border="0" style="width: %dpx; height: %dpx; table-layout: fixed;">\n\t\t\t\t<tr>\n\t\t\t\t\t<td style="font-size: 0; line-height: 0; padding: 0; height: %dpx; width: %dpx;">\n\t\t\t\t\t<div style="max-height:0; position:relative; opacity:0.999;">\n\t\t\t\t\t\t<!--[if mso]>\n\t\t\t\t\t\t<v:rect xmlns:v="urn:schemas-microsoft-com:vml" stroked="false" filled="false" style="mso-width-percent: 1000; position:absolute; top:16px; ' + (rt.call_function('esc_attr', [var_vml_side.dup()])).str() + ':16px;">\n\t\t\t\t\t\t<v:textbox inset="0,0,0,0">\n\t\t\t\t\t\t<![endif]-->\n\t\t\t\t\t\t<div style="padding: 12px; box-sizing: border-box; display: inline-block; width: 100%%; text-align: %s;">\n\t\t\t\t\t\t\t%s\n\t\t\t\t\t\t</div>\n\t\t\t\t\t\t<!--[if mso]>\n\t\t\t\t\t\t</v:textbox>\n\t\t\t\t\t\t</v:rect>\n\t\t\t\t\t\t<![endif]-->\n\t\t\t\t\t</div>\n\t\t\t\t\t\t%s\n\t\t\t\t\t</td>\n\t\t\t\t</tr>\n\t\t\t</table>%s', var_image_width.dup(), var_image_height.dup(), var_image_height.dup(), var_image_width.dup(), rt.new_string(badge_alignment_mutated).dup(), rt.new_string(badges_html), var_linked_image_html.dup(), rt.new_string(other_content_mutated).dup()])
	return (var_overlay_html).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Image) extract_image_width(image_html string) f64 {
	mut image_html_mutated := image_html
	mut var_width := if !(rt.call_method(create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(rt.new_string(image_html_mutated).dup()), 'get_attribute_value_by_tag_name', [rt.new_string('img'), rt.new_string('width')])).is_null() { rt.call_method(create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(rt.new_string(image_html_mutated).dup()), 'get_attribute_value_by_tag_name', [rt.new_string('img'), rt.new_string('width')]) } else { rt.new_string('') }
	if rt.is_true(var_width) {
		return (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.parse_value(arg_0) }(var_width.dup())).to_f64()
	}
	return 300
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Image) extract_image_height(image_html string) f64 {
	mut image_html_mutated := image_html
	mut var_height := if !(rt.call_method(create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(rt.new_string(image_html_mutated).dup()), 'get_attribute_value_by_tag_name', [rt.new_string('img'), rt.new_string('height')])).is_null() { rt.call_method(create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(rt.new_string(image_html_mutated).dup()), 'get_attribute_value_by_tag_name', [rt.new_string('img'), rt.new_string('height')]) } else { rt.new_string('') }
	if rt.is_true(var_height) {
		return (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.parse_value(arg_0) }(var_height.dup())).to_f64()
	}
	return 300
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Image) add_image_size_when_missing(mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) rt.PhpVal {
	mut var_parsed_block_mutated := var_parsed_block
	if var_parsed_block_mutated.array_get('attrs').array_isset(rt.new_string('width')) {
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array', []string{}, var_parsed_block_mutated)
	}
	mut var_align := if !(var_parsed_block_mutated.array_get('attrs').array_get('align')).is_null() { var_parsed_block_mutated.array_get('attrs').array_get('align') } else { rt.new_string('') }
	if rt.is_true(rt.identical(rt.new_string('full'), var_align)) {
		mut var_layout_settings := if !(var_rendering_context.get_theme_settings().array_get('layout')).is_null() { var_rendering_context.get_theme_settings().array_get('layout') } else { rt.new_array() }
		var_parsed_block_mutated.array_get_mut('attrs').array_set('width', if !(var_layout_settings.array_get('contentSize')).is_null() { var_layout_settings.array_get('contentSize') } else { rt.new_string('100%') })
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array', []string{}, var_parsed_block_mutated)
	}
	if !(var_parsed_block_mutated.array_get('email_attrs').array_isset(rt.new_string('width'))) {
		var_parsed_block_mutated.array_get_mut('attrs').array_set('width', '100%')
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array', []string{}, var_parsed_block_mutated)
	}
	var_parsed_block_mutated.array_get_mut('attrs').array_set('width', var_parsed_block_mutated.array_get('email_attrs').array_get('width'))
	return rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array', []string{}, var_parsed_block_mutated)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Image) parse_attributes(mut var_attributes Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	return rt.call_function('wp_parse_args', [var_attributes_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'showProductLink', val: true }, rt.ArrayItem{ key: 'imageSizing', val: 'single' }, rt.ArrayItem{ key: 'scale', val: 'cover' }, rt.ArrayItem{ key: 'showSaleBadge', val: false }, rt.ArrayItem{ key: 'saleBadgeAlign', val: 'right' }])])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Image) get_product_image_data(mut var_product Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WC_Product, mut var_attributes Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_attributes_mutated := var_attributes
	mut var_image_size := rt.new_string(if rt.is_true(rt.identical(rt.new_string('single'), var_attributes_mutated.array_get('imageSizing'))) { rt.new_string('woocommerce_single') } else { rt.new_string('woocommerce_thumbnail') })
	mut var_image_id := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(!(rt.is_true(var_image_id)))) {
		mut var_placeholder := rt.call_function('wc_placeholder_img_src', [var_image_size.dup()])
		return rt.create_array([rt.ArrayItem{ key: 'url', val: var_placeholder }, rt.ArrayItem{ key: 'alt', val: rt.call_method(var_product_mutated, 'get_name', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'width', val: 300 }, rt.ArrayItem{ key: 'height', val: 300 }])
	}
	mut var_image_url := rt.call_function('wp_get_attachment_image_url', [var_image_id.dup(), var_image_size.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_image_url)))) {
		return rt.new_null()
	}
	mut var_alt_text := rt.call_function('get_post_meta', [var_image_id.dup(), rt.new_string('_wp_attachment_image_alt'), rt.new_bool(true)])
	mut var_image_meta := rt.call_function('wp_get_attachment_metadata', [var_image_id.dup()])
	return rt.create_array([rt.ArrayItem{ key: 'url', val: var_image_url }, rt.ArrayItem{ key: 'alt', val: if rt.is_true(var_alt_text) { var_alt_text } else { rt.call_method(var_product_mutated, 'get_name', []rt.PhpVal{}) } }, rt.ArrayItem{ key: 'width', val: if !(var_image_meta.array_get('width')).is_null() { var_image_meta.array_get('width') } else { rt.new_int(300) } }, rt.ArrayItem{ key: 'height', val: if !(var_image_meta.array_get('height')).is_null() { var_image_meta.array_get('height') } else { rt.new_int(300) } }])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Image) build_image_html(mut var_image_data Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, mut var_attributes Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_image_data_mutated := var_image_data
	mut var_attributes_mutated := var_attributes
	mut var_style_parts := rt.create_array([rt.ArrayItem{ key: 'max-width', val: '100%' }, rt.ArrayItem{ key: 'height', val: 'auto' }, rt.ArrayItem{ key: 'display', val: 'block' }])
	if !(!rt.is_true(var_attributes_mutated.array_get('scale'))) {
		var_style_parts.array_set('object-fit', var_attributes_mutated.array_get('scale'))
	}
	if !(!rt.is_true(var_attributes_mutated.array_get('width'))) {
		var_style_parts.array_set('width', var_attributes_mutated.array_get('width'))
	}
	if !(!rt.is_true(var_attributes_mutated.array_get('height'))) {
		var_style_parts.array_set('height', var_attributes_mutated.array_get('height'))
	}
	if !(!rt.is_true(var_attributes_mutated.array_get('aspectRatio'))) {
		var_style_parts.array_set('aspect-ratio', var_attributes_mutated.array_get('aspectRatio'))
	}
	mut var_width := if !(!rt.is_true(var_attributes_mutated.array_get('width'))) { fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.parse_value(arg_0) }(var_attributes_mutated.array_get('width')) } else { var_image_data_mutated.array_get('width') }
	mut var_layout_width := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.parse_value(arg_0) }(var_rendering_context.get_layout_width_without_padding())
	if rt.is_true(rt.greater(var_width, var_layout_width)) {
		var_width = var_layout_width.dup()
		mut var_aspect_ratio := rt.div(var_image_data_mutated.array_get('height'), var_image_data_mutated.array_get('width'))
		var_attributes_mutated.array_set('height', (rt.call_function('round', [rt.mul(var_width, var_aspect_ratio)])).str() + 'px')
	}
	mut var_height := var_image_data_mutated.array_get('height')
	if !(!rt.is_true(var_attributes_mutated.array_get('height'))) {
		var_height = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.parse_value(arg_0) }(var_attributes_mutated.array_get('height'))
	} else if rt.is_true(rt.new_bool(!(!rt.is_true(var_attributes_mutated.array_get('width'))) && rt.is_true(rt.greater(var_image_data_mutated.array_get('width'), rt.new_int(0))))) {
		var_aspect_ratio = rt.div(var_image_data_mutated.array_get('height'), var_image_data_mutated.array_get('width'))
		var_height = rt.call_function('round', [rt.mul(var_width, var_aspect_ratio)])
	}
	return (rt.call_function('sprintf', [rt.new_string('<img class="email-editor-product-image skip-lazy" data-skip-lazy="1" loading="eager" decoding="auto" src="%s" alt="%s" style="%s" width="%d" height="%d" />'), rt.call_function('esc_url', [var_image_data_mutated.array_get('url')]), rt.call_function('esc_attr', [var_image_data_mutated.array_get('alt')]), rt.call_function('esc_attr', [fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Style_Engine{}; return temp.compile_css(arg_0, arg_1) }(var_style_parts.dup(), rt.new_string(''))]), var_width.dup(), var_height.dup()])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Image) wrap_with_link(image_html string, mut var_product Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WC_Product) string {
	mut image_html_mutated := image_html
	mut var_product_mutated := var_product
	mut var_product_url := rt.call_method(var_product_mutated, 'get_permalink', []rt.PhpVal{})
	return (rt.call_function('sprintf', [rt.new_string('<a href="%s" style="display: block; text-decoration: none;">%s</a>'), rt.call_function('esc_url', [var_product_url.dup()]), rt.new_string(image_html_mutated).dup()])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Image) apply_email_wrapper(image_html string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut image_html_mutated := image_html
	mut var_parsed_block_mutated := var_parsed_block
	mut var_width := if !(var_parsed_block_mutated.array_get('attrs').array_get('width')).is_null() { var_parsed_block_mutated.array_get('attrs').array_get('width') } else { rt.new_string('') }
	mut var_align := if !(var_parsed_block_mutated.array_get('attrs').array_get('align')).is_null() { var_parsed_block_mutated.array_get('attrs').array_get('align') } else { rt.new_string('') }
	mut var_is_full := rt.identical(rt.new_string('full'), var_align)
	mut var_wrapper_width := if rt.is_true(var_is_full) { rt.new_string('100%') } else { if rt.is_true(rt.new_bool(rt.is_true(var_width) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) { var_width } else { rt.new_string('auto') } }
	mut var_image_height := rt.new_string(this.extract_image_height(image_html_mutated).str() + 'px')
	mut var_css_align := if rt.is_true(var_is_full) { rt.new_string('center') } else { if rt.is_true(var_align) { var_align } else { rt.new_string('left') } }
	mut var_wrapper_styles := rt.create_array([rt.ArrayItem{ key: 'border-collapse', val: 'separate' }, rt.ArrayItem{ key: 'width', val: var_wrapper_width }])
	mut var_cell_styles := rt.create_array([rt.ArrayItem{ key: 'overflow', val: 'hidden' }, rt.ArrayItem{ key: 'vertical-align', val: 'top' }])
	mut var_padding_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.get_block_styles(arg_0, arg_1, arg_2) }(if !(.array_get()).is_null() { .array_get() } else { rt.new_array() }, rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context', []string{}, var_rendering_context), rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }]))
	if !(!rt.is_true(var_padding_styles.array_get('declarations'))) {
		var_cell_styles = rt.call_function('array_merge', [.dup(), ])
	}
	var_cell_styles.array_set('text-align', var_css_align.dup())
	mut var_outer_table_attrs := 
	
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Style_Engine {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_integrations_woocommerce_renderer_blocks_product_image() &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Image {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Image{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_woocommerce_renderer_blocks_abstract_product_block_renderer() &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_styles_helper() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_woocommerce_renderer_blocks_wp_style_engine() &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Style_Engine {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Style_Engine{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Image) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_string(this.render_content(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2))
		}
		'process_inner_blocks' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WC_Product](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.process_inner_blocks(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'render_overlay_badge' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WC_Product](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_string(this.render_overlay_badge(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2))
		}
		'create_overlay_structure' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_?WC_Product](if args.len > 4 { args[4] } else { rt.new_null() })
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).to_bool()
			return rt.new_string(this.create_overlay_structure(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, mut dispatch_arg_4, dispatch_arg_5))
		}
		'extract_image_width' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_float(this.extract_image_width(dispatch_arg_0))
		}
		'extract_image_height' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_float(this.extract_image_height(dispatch_arg_0))
		}
		'add_image_size_when_missing' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.add_image_size_when_missing(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'parse_attributes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.parse_attributes(mut dispatch_arg_0)
		}
		'get_product_image_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.get_product_image_data(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'build_image_html' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_string(this.build_image_html(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2))
		}
		'wrap_with_link' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WC_Product](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(this.wrap_with_link(dispatch_arg_0, mut dispatch_arg_1))
		}
		'apply_email_wrapper' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_string(this.apply_email_wrapper(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Image) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Image) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Style_Engine) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Style_Engine) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Style_Engine) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_integrations_woocommerce_renderer_blocks_class_product_image_php() {
	// unsupported statement: Stmt_Declare
}
