import rt

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image) render_content(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut block_content_mutated := block_content
	mut var_parsed_block_mutated := var_parsed_block
	mut var_parsed_html := this.parse_block_content(block_content_mutated)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_parsed_html)))) {
		return ''
	}
	mut var_image_url := var_parsed_html.array_get(rt.new_string('imageUrl'))
	mut var_image := var_parsed_html.array_get(rt.new_string('image'))
	mut var_caption := var_parsed_html.array_get(rt.new_string('caption'))
	mut var_class := var_parsed_html.array_get(rt.new_string('class'))
	mut var_anchor_tag_href := var_parsed_html.array_get(rt.new_string('anchor_tag_href'))
	mut var_anchor_data_link_href := var_parsed_html.array_get(rt.new_string('anchor_data_link_href'))
	var_parsed_block_mutated = this.add_image_size_when_missing(mut var_parsed_block_mutated, (var_image_url).str())
	var_image = rt.new_string(this.add_image_dimensions((var_image).str(), mut var_parsed_block_mutated))
	mut var_image_with_wrapper := rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '{image_content}' }, rt.ArrayItem{ key: none, val: '{caption_content}' }]), rt.create_array([rt.ArrayItem{ key: none, val: var_image }, rt.ArrayItem{ key: none, val: var_caption }]), rt.new_string(this.get_block_wrapper(mut var_parsed_block_mutated, mut var_rendering_context, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_?string](var_caption), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_?string](var_anchor_tag_href), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_?string](var_anchor_data_link_href)))])
	var_image_with_wrapper = rt.new_string(this.apply_rounded_style((var_image_with_wrapper).str(), mut var_parsed_block_mutated))
	var_image_with_wrapper = rt.new_string(this.apply_image_border_style((var_image_with_wrapper).str(), mut var_parsed_block_mutated, (var_class).str()))
	return (var_image_with_wrapper).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image) apply_rounded_style(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array) string {
	mut block_content_mutated := block_content
	mut var_parsed_block_mutated := var_parsed_block
	if var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_isset(rt.new_string('className')) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_get(rt.new_string('className')), rt.new_string('is-style-rounded')]), rt.new_bool(false))))) {
	block_content_mutated = this.remove_style_attribute_from_element(rt.new_string(block_content_mutated), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](rt.create_array([rt.ArrayItem{ key: 'tag_name', val: 'td' }, rt.ArrayItem{ key: 'class_name', val: 'email-image-border-cell' }])), 'border-radius')
	block_content_mutated = this.add_style_to_element(rt.new_string(block_content_mutated), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](rt.create_array([rt.ArrayItem{ key: 'tag_name', val: 'td' }, rt.ArrayItem{ key: 'class_name', val: 'email-image-border-cell' }])), 'border-radius: 9999px;')
	block_content_mutated = this.remove_style_attribute_from_element(rt.new_string(block_content_mutated), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](rt.create_array([rt.ArrayItem{ key: 'tag_name', val: 'img' }])), 'border-radius')
	block_content_mutated = this.add_style_to_element(rt.new_string(block_content_mutated), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](rt.create_array([rt.ArrayItem{ key: 'tag_name', val: 'img' }])), 'border-radius: 9999px;')
	}
	return block_content_mutated
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image) add_image_size_when_missing(mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, image_url string) rt.PhpVal {
	mut var_query_params := rt.new_null()
	mut var_parsed_block_mutated := var_parsed_block
	mut image_url_mutated := image_url
	if var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_isset(rt.new_string('width')) {
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array', []string{}, var_parsed_block_mutated)
	}
	if !(var_parsed_block_mutated.array_get(rt.new_string('email_attrs')).array_isset(rt.new_string('width'))) {
		var_parsed_block_mutated.array_get_mut('attrs').array_set('width', '100%')
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array', []string{}, var_parsed_block_mutated)
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
	mut iife_result_0 := iife_temp_0.parse_value(var_parsed_block_mutated.array_get(rt.new_string('email_attrs')).array_get(rt.new_string('width')))
	mut var_max_width := iife_result_0
	mut var_image_size := rt.new_null()
	if rt.is_true(rt.new_string(image_url_mutated)) {
		mut var_parsed_url := rt.call_function('wp_parse_url', [rt.new_string(image_url_mutated).clone()])
		if var_parsed_url.array_isset(rt.new_string('query')) {
			rt.call_function('parse_str', [var_parsed_url.array_get(rt.new_string('query')), var_query_params.clone()])
			if var_query_params.array_isset(rt.new_string('w')) && var_query_params.array_get(rt.new_string('w')).is_long() || var_query_params.array_get(rt.new_string('w')).is_double() && rt.is_true(rt.greater(var_query_params.array_get(rt.new_string('w')), rt.new_int(0))) {
			var_image_size = rt.new_int((var_query_params.array_get(rt.new_string('w'))).to_i64())
			}
		}
		if !(!(var_image_size).is_null()) {
			mut var_attachment_id := if !(var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_get(rt.new_string('id'))).is_null() { var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_get(rt.new_string('id')) } else { rt.new_null() }
			if rt.is_true(var_attachment_id) {
				mut var_size_slug := if !(var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_get(rt.new_string('sizeSlug'))).is_null() { var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_get(rt.new_string('sizeSlug')) } else { rt.new_string('large') }
				mut var_metadata := rt.call_function('wp_get_attachment_metadata', [var_attachment_id.clone()])
				if rt.is_true(var_metadata) {
					if var_metadata.array_get(rt.new_string('sizes')).array_get(var_size_slug).array_isset(rt.new_string('width')) {
					var_image_size = rt.new_int((var_metadata.array_get(rt.new_string('sizes')).array_get(var_size_slug).array_get(rt.new_string('width'))).to_i64())
					} else if rt.is_true(rt.identical(rt.new_string('full'), var_size_slug)) && var_metadata.array_isset(rt.new_string('width')) {
					var_image_size = rt.new_int((var_metadata.array_get(rt.new_string('width'))).to_i64())
					}
				}
				if !(!(var_image_size).is_null()) {
					mut var_image_src := rt.call_function('wp_get_attachment_image_src', [var_attachment_id.clone(), var_size_slug.clone()])
					if rt.is_true(var_image_src) && var_image_src.array_isset(rt.new_int(1)) {
					var_image_size = rt.new_int((var_image_src.array_get(rt.new_int(1))).to_i64())
					}
				}
			}
		}
		if !(!(var_image_size).is_null()) {
			mut var_upload_dir := rt.call_function('wp_upload_dir', []rt.PhpVal{})
			mut var_image_path := rt.call_function('str_replace', [var_upload_dir.array_get(rt.new_string('baseurl')), var_upload_dir.array_get(rt.new_string('basedir')), rt.new_string(image_url_mutated).clone()])
			mut var_result := rt.call_function('wp_getimagesize', [var_image_path.clone()])
			if rt.is_true(var_result) {
			var_image_size = rt.new_int((var_result.array_get(rt.new_int(0))).to_i64())
			}
		}
	}
	mut var_width := if !(var_image_size).is_null() { rt.call_function('min', [var_image_size.clone(), var_max_width.clone()]) } else { var_max_width }
	var_parsed_block_mutated.array_get_mut('attrs').array_set('width', "${var_width.to_string()}px")
	return rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array', []string{}, var_parsed_block_mutated)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image) apply_image_border_style(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, class_name string) string {
	mut block_content_mutated := block_content
	mut var_parsed_block_mutated := var_parsed_block
	mut class_name_mutated := class_name
	mut var_border_styles := rt.call_function('wp_style_engine_get_styles', [rt.create_array([rt.ArrayItem{ key: 'border', val: if !(var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_get(rt.new_string('style')).array_get(rt.new_string('border'))).is_null() { var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_get(rt.new_string('style')).array_get(rt.new_string('border')) } else { rt.new_array() } }])])
	var_border_styles = if !(var_border_styles.array_get(rt.new_string('declarations'))).is_null() { var_border_styles.array_get(rt.new_string('declarations')) } else { rt.new_array() }
	if !(!rt.is_true(var_border_styles)) {
		var_border_styles.array_set('border-style', 'solid')
		var_border_styles.array_set('box-sizing', 'border-box')
	}
	mut var_border_element_tag := rt.create_array([rt.ArrayItem{ key: 'tag_name', val: 'td' }, rt.ArrayItem{ key: 'class_name', val: 'email-image-border-cell' }])
	mut iife_temp_1 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Style_Engine{}
	mut iife_result_1 := iife_temp_1.compile_css(var_border_styles.clone(), rt.new_string(''))
	mut var_content_with_border_styles := rt.new_string(this.add_style_to_element(rt.new_string(block_content_mutated), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_border_element_tag), (iife_result_1).str()))
	var_content_with_border_styles = rt.new_string(this.remove_style_attribute_from_element(var_content_with_border_styles.clone(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](rt.create_array([rt.ArrayItem{ key: 'tag_name', val: 'img' }])), 'border-style'))
	var_content_with_border_styles = rt.new_string(this.remove_style_attribute_from_element(var_content_with_border_styles.clone(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](rt.create_array([rt.ArrayItem{ key: 'tag_name', val: 'img' }])), 'border-width'))
	var_content_with_border_styles = rt.new_string(this.remove_style_attribute_from_element(var_content_with_border_styles.clone(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](rt.create_array([rt.ArrayItem{ key: 'tag_name', val: 'img' }])), 'border-color'))
	var_content_with_border_styles = rt.new_string(this.remove_style_attribute_from_element(var_content_with_border_styles.clone(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](rt.create_array([rt.ArrayItem{ key: 'tag_name', val: 'img' }])), 'border-radius'))
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_class_name := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [rt.new_string(class_name_mutated).clone(), rt.new_string('border')]), rt.new_bool(false))))
		}
	mut var_border_classes := rt.call_function('array_filter', [rt.call_function('explode', [rt.new_string(' '), rt.new_string(class_name_mutated).clone()]), rt.new_closure(closure_3_fn)])
	mut var_html := create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_html_tag_processor(var_content_with_border_styles.clone())
	if rt.is_true(var_html.next_tag(var_border_element_tag.clone())) {
		class_name_mutated = (if !(var_html.get_attribute(rt.new_string('class'))).is_null() { var_html.get_attribute(rt.new_string('class')) } else { rt.new_string('') }).str()
		var_border_classes.array_push(class_name_mutated)
		var_html.set_attribute(rt.new_string('class'), rt.call_function('implode', [rt.new_string(' '), var_border_classes.clone()]))
	}
	return (var_html.get_updated_html()).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image) add_image_dimensions(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array) string {
	mut block_content_mutated := block_content
	mut var_parsed_block_mutated := var_parsed_block
	mut var_html := create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_html_tag_processor(rt.new_string(block_content_mutated).clone())
	if rt.is_true(var_html.next_tag(rt.create_array([rt.ArrayItem{ key: 'tag_name', val: 'img' }]))) {
		mut var_styles := if !(var_html.get_attribute(rt.new_string('style'))).is_null() { var_html.get_attribute(rt.new_string('style')) } else { rt.new_string('') }
		mut iife_temp_3 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
		mut iife_result_3 := iife_temp_3.parse_styles_to_array(var_styles.clone())
		var_styles = iife_result_3
		mut var_height := if !(var_styles.array_get(rt.new_string('height'))).is_null() { var_styles.array_get(rt.new_string('height')) } else { rt.new_null() }
		if rt.is_true(var_height) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('auto'), var_height)))) {
			mut iife_temp_4 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
			mut iife_result_4 := iife_temp_4.parse_value(var_height.clone())
			var_height = iife_result_4
			var_html.set_attribute(rt.new_string('height'), rt.call_function('esc_attr', [var_height.clone()]))
		}
		if var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_isset(rt.new_string('width')) {
			mut iife_temp_5 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
			mut iife_result_5 := iife_temp_5.parse_value(var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_get(rt.new_string('width')))
			mut var_width := iife_result_5
			var_html.set_attribute(rt.new_string('width'), rt.call_function('esc_attr', [var_width.clone()]))
		}
	block_content_mutated = (var_html.get_updated_html()).str()
	}
	return block_content_mutated
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image) get_caption_styles(mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array) string {
	mut var_parsed_block_mutated := var_parsed_block
	mut var_theme_data := rt.call_method(var_rendering_context.get_theme_json(), 'get_data', []rt.PhpVal{})
	mut var_align := if !(var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_get(rt.new_string('align'))).is_null() { var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_get(rt.new_string('align')) } else { rt.new_string('') }
	mut var_styles := rt.create_array([rt.ArrayItem{ key: 'text-align', val: if rt.is_true(var_align) { 'center' } else { 'left' } }])
	var_styles.array_set('font-size', if !(var_parsed_block_mutated.array_get(rt.new_string('email_attrs')).array_get(rt.new_string('font-size'))).is_null() { var_parsed_block_mutated.array_get(rt.new_string('email_attrs')).array_get(rt.new_string('font-size')) } else { var_theme_data.array_get(rt.new_string('styles')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontSize')) })
	mut iife_temp_6 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Style_Engine{}
	mut iife_result_6 := iife_temp_6.compile_css(var_styles.clone(), rt.new_string(''))
	return (iife_result_6).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image) get_block_wrapper(mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context, mut var_caption Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_?string, mut var_anchor_tag_href Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_?string, mut var_anchor_data_link_href Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_?string) string {
	mut var_parsed_block_mutated := var_parsed_block
	mut var_caption_mutated := var_caption
	mut var_anchor_tag_href_mutated := var_anchor_tag_href
	mut var_anchor_data_link_href_mutated := var_anchor_data_link_href
	mut var_styles := rt.create_array([rt.ArrayItem{ key: 'border-collapse', val: 'collapse' }, rt.ArrayItem{ key: 'border-spacing', val: '0px' }, rt.ArrayItem{ key: 'font-size', val: '0px' }, rt.ArrayItem{ key: 'vertical-align', val: 'top' }, rt.ArrayItem{ key: 'width', val: '100%' }])
	mut var_width := if !(var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_get(rt.new_string('width'))).is_null() { var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_get(rt.new_string('width')) } else { rt.new_string('100%') }
	mut var_wrapper_width := if rt.is_true(var_width) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('100%'), var_width)))) { var_width } else { rt.new_string('auto') }
	mut var_wrapper_styles := var_styles.clone()
	var_wrapper_styles.array_set('width', var_wrapper_width.clone())
	var_wrapper_styles.array_set('border-collapse', 'separate')
	mut var_caption_html := rt.new_string('')
	if rt.is_true(var_caption_mutated) {
		mut var_caption_width := if var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_isset(rt.new_string('align')) { if !(var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_get(rt.new_string('width'))).is_null() { var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_get(rt.new_string('width')) } else { rt.new_string('100%') } } else { rt.new_string('100%') }
		mut var_caption_wrapper_styles := var_styles.clone()
		var_caption_wrapper_styles.array_set('width', var_caption_width.clone())
	mut var_caption_styles := rt.new_string(this.get_caption_styles(mut var_rendering_context, mut var_parsed_block_mutated))
	mut iife_temp_7 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Style_Engine{}
	mut iife_result_7 := iife_temp_7.compile_css(var_caption_wrapper_styles.clone(), rt.new_string(''))
	mut var_caption_table_attrs := rt.create_array([rt.ArrayItem{ key: 'class', val: 'email-table-with-width' }, rt.ArrayItem{ key: 'style', val: iife_result_7 }, rt.ArrayItem{ key: 'width', val: var_caption_width }])
	mut var_caption_cell_attrs := rt.create_array([rt.ArrayItem{ key: 'style', val: var_caption_styles }])
	mut iife_temp_8 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
	mut iife_result_8 := iife_temp_8.render_table_wrapper(rt.new_string('{caption_content}'), var_caption_table_attrs.clone(), var_caption_cell_attrs.clone())
	var_caption_html = iife_result_8
	}
	var_styles.array_set('width', '100%')
	mut var_align := if !(var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_get(rt.new_string('align'))).is_null() { var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_get(rt.new_string('align')) } else { rt.new_string('left') }
	mut var_css_align := if rt.is_true(rt.call_function('in_array', [var_align.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'full' }, rt.ArrayItem{ key: none, val: 'wide' }]), rt.new_bool(true)])) { rt.new_string('center') } else { var_align }
	mut iife_temp_9 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Style_Engine{}
	mut iife_result_9 := iife_temp_9.compile_css(var_styles.clone(), rt.new_string(''))
	mut var_table_attrs := rt.create_array([rt.ArrayItem{ key: 'style', val: iife_result_9 }, rt.ArrayItem{ key: 'width', val: '100%' }])
	mut var_cell_attrs := rt.create_array([rt.ArrayItem{ key: 'align', val: var_css_align }])
	mut iife_temp_10 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Style_Engine{}
	mut iife_result_10 := iife_temp_10.compile_css(var_wrapper_styles.clone(), rt.new_string(''))
	mut var_image_table_attrs := rt.create_array([rt.ArrayItem{ key: 'class', val: 'email-table-with-width' }, rt.ArrayItem{ key: 'style', val: iife_result_10 }, rt.ArrayItem{ key: 'width', val: var_wrapper_width }])
	mut var_image_cell_attrs := rt.create_array([rt.ArrayItem{ key: 'class', val: 'email-image-cell' }, rt.ArrayItem{ key: 'style', val: 'overflow: hidden;' }, rt.ArrayItem{ key: 'align', val: var_css_align }])
	mut var_image_content := rt.new_string('{image_content}')
	if rt.is_true(var_anchor_tag_href_mutated) {
	mut var_data_link_attr := if rt.is_true(var_anchor_data_link_href_mutated) { rt.call_function('sprintf', [rt.new_string(' data-link-href="%s"'), rt.call_function('esc_attr', [var_anchor_data_link_href_mutated])]) } else { rt.new_string('') }
	var_image_content = rt.call_function('sprintf', [rt.new_string('<a href="%s"%s rel="noopener nofollow" target="_blank">%s</a>'), rt.call_function('esc_url', [var_anchor_tag_href_mutated]), var_data_link_attr.clone(), rt.new_string('{image_content}')])
	}
	mut var_border_wrapper_styles := rt.create_array([rt.ArrayItem{ key: 'border-collapse', val: 'separate' }, rt.ArrayItem{ key: 'border-spacing', val: '0px' }])
	mut iife_temp_11 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Style_Engine{}
	mut iife_result_11 := iife_temp_11.compile_css(var_border_wrapper_styles.clone(), rt.new_string(''))
	mut var_border_wrapper_attrs := rt.create_array([rt.ArrayItem{ key: 'class', val: 'email-image-border-wrapper' }, rt.ArrayItem{ key: 'style', val: iife_result_11 }])
	mut var_border_cell_attrs := rt.create_array([rt.ArrayItem{ key: 'class', val: 'email-image-border-cell' }])
	mut iife_temp_12 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
	mut iife_result_12 := iife_temp_12.render_table_wrapper(var_image_content.clone(), var_border_wrapper_attrs.clone(), var_border_cell_attrs.clone())
	var_image_content = iife_result_12
	mut iife_temp_13 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
	mut iife_result_13 := iife_temp_13.render_table_wrapper(var_image_content.clone(), var_image_table_attrs.clone(), var_image_cell_attrs.clone())
	mut var_image_html := iife_result_13
	mut var_inner_content := rt.new_string((var_image_html).str() + (var_caption_html).str())
	mut iife_temp_14 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
	mut iife_result_14 := iife_temp_14.render_table_wrapper(var_inner_content.clone(), var_table_attrs.clone(), var_cell_attrs.clone())
	return (iife_result_14).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image) add_style_to_element(var_block_content rt.PhpVal, mut var_tag Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, style string) string {
	mut var_block_content_mutated := var_block_content
	mut var_html := create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_html_tag_processor(var_block_content_mutated.clone())
	if rt.is_true(var_html.next_tag(rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array', []string{}, var_tag))) {
		mut var_element_style := if !(var_html.get_attribute(rt.new_string('style'))).is_null() { var_html.get_attribute(rt.new_string('style')) } else { rt.new_string('') }
		var_element_style = rt.new_string((if !(!rt.is_true(var_element_style)) { var_element_style.clone().to_string().trim_right(' \t\n\r') + ';' } else { '' }).str())
		var_element_style = rt.concat(var_element_style, rt.new_string(style))
		var_html.set_attribute(rt.new_string('style'), rt.call_function('esc_attr', [var_element_style.clone()]))
	var_block_content_mutated = var_html.get_updated_html()
	}
	return (var_block_content_mutated).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image) remove_style_attribute_from_element(var_block_content rt.PhpVal, mut var_tag Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, style_name string) string {
	mut var_block_content_mutated := var_block_content
	mut var_html := create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_html_tag_processor(var_block_content_mutated.clone())
	if rt.is_true(var_html.next_tag(rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array', []string{}, var_tag))) {
		mut var_element_style := if !(var_html.get_attribute(rt.new_string('style'))).is_null() { var_html.get_attribute(rt.new_string('style')) } else { rt.new_string('') }
		var_element_style = rt.call_function('preg_replace', [rt.new_string('/' + (rt.call_function('preg_quote', [rt.new_string(style_name), rt.new_string('/')])).str() + '\\s*:\\s*[^;]+;?/'), rt.new_string(''), var_element_style.clone()])
		var_html.set_attribute(rt.new_string('style'), rt.call_function('esc_attr', [rt.new_string(var_element_style.clone().to_string())]))
	var_block_content_mutated = var_html.get_updated_html()
	}
	return (var_block_content_mutated).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image) parse_block_content(block_content string) rt.PhpVal {
	mut block_content_mutated := block_content
	if block_content_mutated == '' {
		return rt.new_null()
	}
	mut var_dom_helper := create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(rt.new_string(block_content_mutated).clone())
	mut var_figure_tag := var_dom_helper.find_element(rt.new_string('figure'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_figure_tag)))) {
		return rt.new_null()
	}
	mut var_img_tag := var_dom_helper.find_element(rt.new_string('img'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_img_tag)))) {
		return rt.new_null()
	}
	mut var_image_src := var_dom_helper.get_attribute_value(var_img_tag.clone(), rt.new_string('src'))
	mut var_image_class := var_dom_helper.get_attribute_value(var_img_tag.clone(), rt.new_string('class'))
	mut var_image_html := var_dom_helper.get_outer_html(var_img_tag.clone())
	mut var_figcaption := var_dom_helper.find_element(rt.new_string('figcaption'))
	mut var_figcaption_html := if rt.is_true(var_figcaption) { var_dom_helper.get_outer_html(var_figcaption.clone()) } else { rt.new_string('') }
	var_figcaption_html = rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '<figcaption' }, rt.ArrayItem{ key: none, val: '</figcaption>' }]), rt.create_array([rt.ArrayItem{ key: none, val: '<span' }, rt.ArrayItem{ key: none, val: '</span>' }]), var_figcaption_html.clone()])
	mut var_anchor_tag := var_dom_helper.find_element(rt.new_string('a'))
	mut var_anchor_tag_href := if rt.is_true(var_anchor_tag) { var_dom_helper.get_attribute_value(var_anchor_tag.clone(), rt.new_string('href')) } else { rt.new_string('') }
	mut var_anchor_data_link_href := if rt.is_true(var_anchor_tag) { var_dom_helper.get_attribute_value(var_anchor_tag.clone(), rt.new_string('data-link-href')) } else { rt.new_string('') }
	return rt.create_array([rt.ArrayItem{ key: 'imageUrl', val: if rt.is_true(var_image_src) { var_image_src } else { rt.new_string('') } }, rt.ArrayItem{ key: 'image', val: this.cleanup_image_html((var_image_html).str()) }, rt.ArrayItem{ key: 'caption', val: if rt.is_true(var_figcaption_html) { var_figcaption_html } else { rt.new_string('') } }, rt.ArrayItem{ key: 'class', val: if rt.is_true(var_image_class) { var_image_class } else { rt.new_string('') } }, rt.ArrayItem{ key: 'anchor_tag_href', val: if rt.is_true(var_anchor_tag_href) { var_anchor_tag_href } else { rt.new_string('') } }, rt.ArrayItem{ key: 'anchor_data_link_href', val: if rt.is_true(var_anchor_data_link_href) { var_anchor_data_link_href } else { rt.new_string('') } }])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image) cleanup_image_html(content_html string) string {
	mut var_html := create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_html_tag_processor(rt.new_string(content_html))
	if rt.is_true(var_html.next_tag(rt.create_array([rt.ArrayItem{ key: 'tag_name', val: 'img' }]))) {
		var_html.remove_attribute(rt.new_string('srcset'))
		var_html.remove_attribute(rt.new_string('class'))
	}
	return (var_html.get_updated_html()).str()
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Style_Engine {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_image(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_abstract_block_renderer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_styles_helper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_style_engine(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Style_Engine {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Style_Engine{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_html_tag_processor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_table_wrapper_helper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_string(this.render_content(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2))
		}
		'apply_rounded_style' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(this.apply_rounded_style(dispatch_arg_0, mut dispatch_arg_1))
		}
		'add_image_size_when_missing' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.add_image_size_when_missing(mut dispatch_arg_0, dispatch_arg_1)
		}
		'apply_image_border_style' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_string(this.apply_image_border_style(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2))
		}
		'add_image_dimensions' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(this.add_image_dimensions(dispatch_arg_0, mut dispatch_arg_1))
		}
		'get_caption_styles' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(this.get_caption_styles(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'get_block_wrapper' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_?string](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_?string](if args.len > 4 { args[4] } else { rt.new_null() })
			return rt.new_string(this.get_block_wrapper(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4))
		}
		'add_style_to_element' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_string(this.add_style_to_element(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2))
		}
		'remove_style_attribute_from_element' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_string(this.remove_style_attribute_from_element(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2))
		}
		'parse_block_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.parse_block_content(dispatch_arg_0)
		}
		'cleanup_image_html' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.cleanup_image_html(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Style_Engine) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Style_Engine) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Style_Engine) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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



fn main() {
	defer {
		rt.shutdown()
	}

}
