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
	mut var_image_url := var_parsed_html.array_get('imageUrl')
	mut var_image := var_parsed_html.array_get('image')
	mut var_caption := var_parsed_html.array_get('caption')
	mut var_class := var_parsed_html.array_get('class')
	mut var_anchor_tag_href := var_parsed_html.array_get('anchor_tag_href')
	mut var_anchor_data_link_href := var_parsed_html.array_get('anchor_data_link_href')
	var_parsed_block_mutated = this.add_image_size_when_missing(mut var_parsed_block_mutated, (var_image_url).str())
	var_image = rt.new_string(this.add_image_dimensions((var_image).str(), mut var_parsed_block_mutated))
	mut var_image_with_wrapper := rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '{image_content}' }, rt.ArrayItem{ key: none, val: '{caption_content}' }]), rt.create_array([rt.ArrayItem{ key: none, val: var_image }, rt.ArrayItem{ key: none, val: var_caption }]), this.get_block_wrapper(mut var_parsed_block_mutated, mut var_rendering_context, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_?string](var_caption), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_?string](var_anchor_tag_href), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_?string](var_anchor_data_link_href))])
	var_image_with_wrapper = rt.new_string(this.apply_rounded_style((var_image_with_wrapper).str(), mut var_parsed_block_mutated))
	var_image_with_wrapper = rt.new_string(this.apply_image_border_style((var_image_with_wrapper).str(), mut var_parsed_block_mutated, (var_class).str()))
	return (var_image_with_wrapper).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image) apply_rounded_style(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array) string {
	mut block_content_mutated := block_content
	mut var_parsed_block_mutated := var_parsed_block
	if rt.is_true(rt.new_bool(var_parsed_block_mutated.array_get('attrs').array_isset(rt.new_string('className')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
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
	if var_parsed_block_mutated.array_get('attrs').array_isset(rt.new_string('width')) {
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array', []string{}, var_parsed_block_mutated)
	}
	if !(var_parsed_block_mutated.array_get('email_attrs').array_isset(rt.new_string('width'))) {
		var_parsed_block_mutated.array_get_mut('attrs').array_set('width', '100%')
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array', []string{}, var_parsed_block_mutated)
	}
	mut var_max_width := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.parse_value(arg_0) }(var_parsed_block_mutated.array_get('email_attrs').array_get('width'))
	mut var_image_size := rt.new_null()
	if rt.is_true(rt.new_string(image_url_mutated)) {
		mut var_parsed_url := rt.call_function('wp_parse_url', [rt.new_string(image_url_mutated).dup()])
		if var_parsed_url.array_isset(rt.new_string('query')) {
			rt.call_function('parse_str', [var_parsed_url.array_get('query'), var_query_params.dup()])
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_query_params.array_isset(rt.new_string('w')) && rt.is_true(rt.new_bool(var_query_params.array_get('w').is_long() || var_query_params.array_get('w').is_double())))) && rt.is_true(rt.greater(var_query_params.array_get('w'), rt.new_int(0))))) {
				var_image_size = // unsupported expression: Expr_Cast_Int
			}
		}
		if !(!(var_image_size).is_null()) {
			mut var_attachment_id := if !(var_parsed_block_mutated.array_get('attrs').array_get('id')).is_null() { var_parsed_block_mutated.array_get('attrs').array_get('id') } else { rt.new_null() }
			if rt.is_true(var_attachment_id) {
				mut var_size_slug := if !(var_parsed_block_mutated.array_get('attrs').array_get('sizeSlug')).is_null() { var_parsed_block_mutated.array_get('attrs').array_get('sizeSlug') } else { rt.new_string('large') }
				mut var_metadata := rt.call_function('wp_get_attachment_metadata', [var_attachment_id.dup()])
				if rt.is_true(var_metadata) {
					if var_metadata.array_get('sizes').array_get(var_size_slug).array_isset(rt.new_string('width')) {
						var_image_size = // unsupported expression: Expr_Cast_Int
					} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('full'), var_size_slug)) && var_metadata.array_isset(rt.new_string('width')))) {
						var_image_size = // unsupported expression: Expr_Cast_Int
					}
				}
				if !(!(var_image_size).is_null()) {
					mut var_image_src := rt.call_function('wp_get_attachment_image_src', [var_attachment_id.dup(), var_size_slug.dup()])
					if rt.is_true(rt.new_bool(rt.is_true(var_image_src) && var_image_src.array_isset(rt.new_int(1)))) {
						var_image_size = // unsupported expression: Expr_Cast_Int
					}
				}
			}
		}
		if !(!(var_image_size).is_null()) {
			mut var_upload_dir := rt.call_function('wp_upload_dir', []rt.PhpVal{})
			mut var_image_path := rt.call_function('str_replace', [var_upload_dir.array_get('baseurl'), var_upload_dir.array_get('basedir'), rt.new_string(image_url_mutated).dup()])
			mut var_result := rt.call_function('wp_getimagesize', [var_image_path.dup()])
			if rt.is_true(var_result) {
				var_image_size = // unsupported expression: Expr_Cast_Int
			}
		}
	}
	mut var_width := if !(var_image_size).is_null() { rt.call_function('min', [var_image_size.dup(), var_max_width.dup()]) } else { var_max_width }
	var_parsed_block_mutated.array_get_mut('attrs').array_set('width', "${var_width.to_string()}px")
	return rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array', []string{}, var_parsed_block_mutated)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image) apply_image_border_style(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, class_name string) string {
	mut block_content_mutated := block_content
	mut var_parsed_block_mutated := var_parsed_block
	mut class_name_mutated := class_name
	mut var_border_styles := rt.call_function('wp_style_engine_get_styles', [rt.create_array([rt.ArrayItem{ key: 'border', val: if !(var_parsed_block_mutated.array_get('attrs').array_get('style').array_get('border')).is_null() { var_parsed_block_mutated.array_get('attrs').array_get('style').array_get('border') } else { rt.new_array() } }])])
	var_border_styles = if !(var_border_styles.array_get('declarations')).is_null() { var_border_styles.array_get('declarations') } else { rt.new_array() }
	if !(!rt.is_true(var_border_styles)) {
		var_border_styles.array_set('border-style', 'solid')
		var_border_styles.array_set('box-sizing', 'border-box')
	}
	mut var_border_element_tag := rt.create_array([rt.ArrayItem{ key: 'tag_name', val: 'td' }, rt.ArrayItem{ key: 'class_name', val: 'email-image-border-cell' }])
	mut var_content_with_border_styles := rt.new_string(this.add_style_to_element(rt.new_string(block_content_mutated), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_border_element_tag), (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Style_Engine{}; return temp.compile_css(arg_0, arg_1) }(var_border_styles.dup(), rt.new_string(''))).str()))
	var_content_with_border_styles = rt.new_string(this.remove_style_attribute_from_element(var_content_with_border_styles.dup(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](rt.create_array([rt.ArrayItem{ key: 'tag_name', val: 'img' }])), 'border-style'))
	var_content_with_border_styles = rt.new_string(this.remove_style_attribute_from_element(var_content_with_border_styles.dup(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](rt.create_array([rt.ArrayItem{ key: 'tag_name', val: 'img' }])), 'border-width'))
	var_content_with_border_styles = rt.new_string(this.remove_style_attribute_from_element(var_content_with_border_styles.dup(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](rt.create_array([rt.ArrayItem{ key: 'tag_name', val: 'img' }])), 'border-color'))
	var_content_with_border_styles = rt.new_string(this.remove_style_attribute_from_element(var_content_with_border_styles.dup(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](rt.create_array([rt.ArrayItem{ key: 'tag_name', val: 'img' }])), 'border-radius'))
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_class_name := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return (// unsupported expression: Expr_BinaryOp_NotIdentical).str()
	}
	mut var_border_classes := rt.call_function('array_filter', [rt.call_function('explode', [rt.new_string(' '), rt.new_string(class_name_mutated).dup()]), rt.new_closure(closure_1_fn)])
	mut var_html := create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_html_tag_processor(var_content_with_border_styles.dup())
	if rt.is_true(var_html.next_tag(var_border_element_tag.dup())) {
		class_name_mutated = (if !(var_html.get_attribute(rt.new_string('class'))).is_null() { var_html.get_attribute(rt.new_string('class')) } else { rt.new_string('') }).str()
		var_border_classes.array_push(class_name_mutated)
		var_html.set_attribute(rt.new_string('class'), rt.call_function('implode', [rt.new_string(' '), var_border_classes.dup()]))
	}
	return (var_html.get_updated_html()).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image) add_image_dimensions(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array) string {
	mut block_content_mutated := block_content
	mut var_parsed_block_mutated := var_parsed_block
	mut var_html := create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_html_tag_processor(rt.new_string(block_content_mutated).dup())
	if rt.is_true(var_html.next_tag(rt.create_array([rt.ArrayItem{ key: 'tag_name', val: 'img' }]))) {
		mut var_styles := if !(var_html.get_attribute(rt.new_string('style'))).is_null() { var_html.get_attribute(rt.new_string('style')) } else { rt.new_string('') }
		var_styles = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.parse_styles_to_array(arg_0) }(var_styles.dup())
		mut var_height := if !(var_styles.array_get('height')).is_null() { var_styles.array_get('height') } else { rt.new_null() }
		if rt.is_true(rt.new_bool(rt.is_true(var_height) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			var_height = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.parse_value(arg_0) }(var_height.dup())
			var_html.set_attribute(rt.new_string('height'), rt.call_function('esc_attr', [var_height.dup()]))
		}
		if var_parsed_block_mutated.array_get('attrs').array_isset(rt.new_string('width')) {
			mut var_width := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.parse_value(arg_0) }(var_parsed_block_mutated.array_get('attrs').array_get('width'))
			var_html.set_attribute(rt.new_string('width'), rt.call_function('esc_attr', [var_width.dup()]))
		}
		block_content_mutated = (var_html.get_updated_html()).str()
	}
	return block_content_mutated
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image) get_caption_styles(mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array) string {
	mut var_parsed_block_mutated := var_parsed_block
	mut var_theme_data := rt.call_method(var_rendering_context.get_theme_json(), 'get_data', []rt.PhpVal{})
	mut var_align := if !(var_parsed_block_mutated.array_get('attrs').array_get('align')).is_null() { var_parsed_block_mutated.array_get('attrs').array_get('align') } else { rt.new_string('') }
	mut var_styles := rt.create_array([rt.ArrayItem{ key: 'text-align', val: if rt.is_true(var_align) { 'center' } else { 'left' } }])
	var_styles.array_set('font-size', if !(var_parsed_block_mutated.array_get('email_attrs').array_get('font-size')).is_null() { var_parsed_block_mutated.array_get('email_attrs').array_get('font-size') } else { var_theme_data.array_get('styles').array_get('typography').array_get('fontSize') })
	return (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Style_Engine{}; return temp.compile_css(arg_0, arg_1) }(var_styles.dup(), rt.new_string(''))).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image) get_block_wrapper(mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context, mut var_caption Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_?string, mut var_anchor_tag_href Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_?string, mut var_anchor_data_link_href Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_?string) string {
	mut var_parsed_block_mutated := var_parsed_block
	mut var_caption_mutated := var_caption
	mut var_anchor_tag_href_mutated := var_anchor_tag_href
	mut var_anchor_data_link_href_mutated := var_anchor_data_link_href
	mut var_styles := rt.create_array([rt.ArrayItem{ key: 'border-collapse', val: 'collapse' }, rt.ArrayItem{ key: 'border-spacing', val: '0px' }, rt.ArrayItem{ key: 'font-size', val: '0px' }, rt.ArrayItem{ key: 'vertical-align', val: 'top' }, rt.ArrayItem{ key: 'width', val: '100%' }])
	mut var_width := if !(var_parsed_block_mutated.array_get('attrs').array_get('width')).is_null() { var_parsed_block_mutated.array_get('attrs').array_get('width') } else { rt.new_string('100%') }
	mut var_wrapper_width := if rt.is_true(rt.new_bool(rt.is_true(var_width) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) { var_width } else { rt.new_string('auto') }
	mut var_wrapper_styles := var_styles.dup()
	var_wrapper_styles.array_set('width', var_wrapper_width.dup())
	var_wrapper_styles.array_set('border-collapse', 'separate')
	mut var_caption_html := rt.new_string(rt.new_string(''))
	if rt.is_true(var_caption_mutated) {
		mut var_caption_width := if var_parsed_block_mutated.array_get('attrs').array_isset(rt.new_string('align')) { if !(var_parsed_block_mutated.array_get('attrs').array_get('width')).is_null() { var_parsed_block_mutated.array_get('attrs').array_get('width') } else { rt.new_string('100%') } } else { rt.new_string('100%') }
		mut var_caption_wrapper_styles := var_styles.dup()
		var_caption_wrapper_styles.array_set('width', var_caption_width.dup())
		mut var_caption_styles := rt.new_string(this.get_caption_styles(mut var_rendering_context, mut var_parsed_block_mutated))
		mut var_caption_table_attrs := rt.create_array([rt.ArrayItem{ key: 'class', val: 'email-table-with-width' }, rt.ArrayItem{ key: 'style', val: fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Style_Engine{}; return temp.compile_css(arg_0, arg_1) }(var_caption_wrapper_styles.dup(), rt.new_string('')) }, rt.ArrayItem{ key: 'width', val: var_caption_width }])
		mut var_caption_cell_attrs := rt.create_array([rt.ArrayItem{ key: 'style', val: var_caption_styles }])
		var_caption_html = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}; return temp.render_table_wrapper(arg_0, arg_1, arg_2) }(rt.new_string('{caption_content}'), var_caption_table_attrs.dup(), var_caption_cell_attrs.dup())
	}
	var_styles.array_set('width', '100%')
	mut var_align := if !(.array_get().array_get('align')).is_null() { .array_get().array_get('align') } else { rt.new_string('left') }
	mut var_css_align := if rt.is_true(rt.call_function('in_array', [.dup(), , ])) { rt.new_string('center') } else { var_align }
	mut var_table_attrs := rt.create_array([rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }])
	mut var_cell_attrs := 
	
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image) add_style_to_element(var_block_content rt.PhpVal, mut var_tag Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, style string) string {
	mut var_block_content_mutated := var_block_content
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image) remove_style_attribute_from_element(var_block_content rt.PhpVal, mut var_tag Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, style_name string) string {
	mut var_block_content_mutated := var_block_content
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image) parse_block_content(block_content string) rt.PhpVal {
	mut block_content_mutated := block_content
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image) cleanup_image_html(content_html string) string {
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

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_image() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_abstract_block_renderer() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer{
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

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_style_engine() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Style_Engine {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Style_Engine{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_html_tag_processor() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_table_wrapper_helper() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{
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




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_integrations_core_renderer_blocks_class_image_php() {
	// unsupported statement: Stmt_Declare
}
