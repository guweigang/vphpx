import rt

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Social_Links {
	rt.PhpObjectBase
pub mut:
		core_social_link_services_cache rt.PhpVal = rt.new_array()
		supported_image_types rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Social_Links) render_content(var_block_content rt.PhpVal, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_block_content_mutated := var_block_content
	mut var_attrs := if !(var_parsed_block.array_get('attrs')).is_null() { var_parsed_block.array_get('attrs') } else { rt.new_array() }
	mut var_inner_blocks := if !(var_parsed_block.array_get('innerBlocks')).is_null() { var_parsed_block.array_get('innerBlocks') } else { rt.new_array() }
	mut var_content := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := var_inner_blocks.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block := item_1.val
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	return (rt.call_function('str_replace', [rt.new_string('{social_links_content}'), var_content.dup(), this.get_block_wrapper(var_block_content_mutated.dup(), rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array', []string{}, var_parsed_block))])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Social_Links) generate_social_link_content(var_block rt.PhpVal, var_parent_block_attrs rt.PhpVal) string {
	mut var_service_name := if !(var_block.array_get('attrs').array_get('service')).is_null() { var_block.array_get('attrs').array_get('service') } else { rt.new_string('') }
	mut var_service_url := if !(var_block.array_get('attrs').array_get('url')).is_null() { var_block.array_get('attrs').array_get('url') } else { rt.new_string('') }
	mut var_label := if !(var_block.array_get('attrs').array_get('label')).is_null() { var_block.array_get('attrs').array_get('label') } else { rt.new_string('') }
	if !rt.is_true(var_service_name) || !rt.is_true(var_service_url) {
		return ''
	}
	if rt.is_true(rt.call_function('is_email', [var_service_url.dup()])) {
		var_service_url = rt.new_string('mailto:' + (rt.call_function('antispambot', [var_service_url.dup()])).str())
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_parse_url', [var_service_url.dup(), rt.get_constant('PHP_URL_SCHEME')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [var_service_url.dup(), rt.new_string('//')]))))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [var_service_url.dup(), rt.new_string('#')]))))))) {
		var_service_url = rt.new_string('https://' + (var_service_url).str())
	}
	mut var_open_in_new_tab := if !(var_parent_block_attrs.array_get('openInNewTab')).is_null() { var_parent_block_attrs.array_get('openInNewTab') } else { rt.new_bool(false) }
	mut var_show_labels := if !(var_parent_block_attrs.array_get('showLabels')).is_null() { var_parent_block_attrs.array_get('showLabels') } else { rt.new_bool(false) }
	mut var_size := if !(var_parent_block_attrs.array_get('size')).is_null() { var_parent_block_attrs.array_get('size') } else { fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Social_Links_Helper{}; return temp.get_default_social_link_size() }() }
	mut var_service_brand_color := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Social_Links_Helper{}; return temp.get_service_brand_color(arg_0) }(var_service_name.dup())
	mut var_icon_color_value := if !(var_parent_block_attrs.array_get('iconColorValue')).is_null() { var_parent_block_attrs.array_get('iconColorValue') } else { rt.new_string('#ffffff') }
	mut var_icon_background_color_value := if !(var_parent_block_attrs.array_get('iconBackgroundColorValue')).is_null() { var_parent_block_attrs.array_get('iconBackgroundColorValue') } else { rt.new_string('') }
	mut var_is_logos_only := // unsupported expression: Expr_BinaryOp_NotIdentical
	mut var_is_pill_shape := // unsupported expression: Expr_BinaryOp_NotIdentical
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_is_logos_only)))) && rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Social_Links_Helper{}; return temp.detect_whiteish_color(arg_0) }(var_icon_color_value.dup())))) && rt.is_true(rt.new_bool(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Social_Links_Helper{}; return temp.detect_whiteish_color(arg_0) }(var_icon_background_color_value.dup())) || !rt.is_true(var_icon_background_color_value))))) {
		var_icon_background_color_value = if !(!rt.is_true(var_service_brand_color)) { var_service_brand_color } else { rt.new_string('#000') }
	}
	if rt.is_true(var_is_logos_only) {
		var_icon_color_value = if !(!rt.is_true(var_service_brand_color)) { var_service_brand_color } else { rt.new_string('#000') }
	}
	mut var_icon_size := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Social_Links_Helper{}; return temp.get_social_link_size_option_value(arg_0) }(var_size.dup())
	mut var_service_icon_url := rt.new_string(this.get_service_icon_url(var_service_name.dup(), if rt.is_true(var_is_logos_only) { 'brand' } else { 'white' }))
	mut var_service_label := rt.new_string(rt.new_string(''))
	if rt.is_true(var_show_labels) {
		mut var_text := rt.new_string(if !(!rt.is_true(var_label)) { rt.new_string(var_label.dup().to_string().trim_space()) } else { rt.new_string('') })
		var_service_label = if rt.is_true(var_text) { var_text } else { rt.call_function('block_core_social_link_get_name', [var_service_name.dup()]) }
	}
	mut var_main_table_styles := this.compile_css(rt.create_array([rt.ArrayItem{ key: 'background-color', val: var_icon_background_color_value }, rt.ArrayItem{ key: 'border-radius', val: '9999px' }, rt.ArrayItem{ key: 'display', val: 'inline-table' }, rt.ArrayItem{ key: 'float', val: 'none' }]))
	mut var_font_size_value := // unsupported expression: Expr_Cast_Int
	mut var_font_size := rt.add(rt.div(var_font_size_value, rt.new_int(2)), rt.new_int(1))
	mut var_text_font_size := rt.new_string(rt.new_string("${var_font_size.to_string()}px"))
	mut var_anchor_styles := this.compile_css(rt.create_array([rt.ArrayItem{ key: 'color', val: var_icon_color_value }, rt.ArrayItem{ key: 'text-decoration', val: 'none' }, rt.ArrayItem{ key: 'text-transform', val: 'none' }, rt.ArrayItem{ key: 'font-size', val: var_text_font_size }]))
	mut var_anchor_html := rt.call_function('sprintf', [rt.new_string(' style="%s" '), rt.call_function('esc_attr', [var_anchor_styles.dup()])])
	if rt.is_true(var_open_in_new_tab) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_row_container_styles := rt.create_array([rt.ArrayItem{ key: 'display', val: 'block' }, rt.ArrayItem{ key: 'padding', val: '0.25em' }])
	if rt.is_true(var_is_pill_shape) {
		var_row_container_styles.array_set('padding-left', '17px')
		var_row_container_styles.array_set('padding-right', '17px')
	}
	var_row_container_styles = this.compile_css(var_row_container_styles.dup())
	mut var_icon_content := rt.call_function('sprintf', [rt.new_string('<a href="%1$s" %2$s class="wp-block-social-link-anchor">\n\t\t\t\t<img height="%3$s" src="%4$s" style="display:block;margin-right:0;" width="%3$s" alt="%5$s">\n\t\t\t</a>'), rt.call_function('esc_url', [var_service_url.dup()]), var_anchor_html.dup(), rt.call_function('esc_attr', [var_icon_size.dup()]), rt.call_function('esc_url', [var_service_icon_url.dup()]), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s icon'), rt.new_string('woocommerce')]), var_service_name.dup()])])
	var_icon_content = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}; return temp.render_table_wrapper(arg_0, arg_1, arg_2) }(var_icon_content.dup(), rt.new_array(), rt.create_array([rt.ArrayItem{ key: 'style', val: 'vertical-align:middle;' }]))
	var_icon_content = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}; return temp.render_table_cell(arg_0, arg_1) }(var_icon_content.dup(), rt.create_array([rt.ArrayItem{ key: 'style', val: rt.call_function('sprintf', [rt.new_string('vertical-align:middle;font-size:%s;'), var_text_font_size.dup()]) }]))
	mut var_label_content := rt.new_string(rt.new_string(''))
	if rt.is_true(var_service_label) {
		var_label_content = rt.call_function('sprintf', [rt.new_string('<a href="%1$s" %2$s class="wp-block-social-link-anchor">\n\t\t\t\t\t<span style="margin-left:.5em;margin-right:.5em"> %3$s </span>\n\t\t\t\t</a>'), rt.call_function('esc_url', [var_service_url.dup()]), var_anchor_html.dup(), rt.call_function('esc_html', [var_service_label.dup()])])
		mut var_label_cell_style := rt.call_function('sprintf', [rt.new_string('vertical-align:middle;padding-left:6px;padding-right:6px;font-size:%s;'), var_text_font_size.dup()])
		var_label_content = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}; return temp.render_table_cell(arg_0, arg_1) }(var_label_content.dup(), rt.create_array([rt.ArrayItem{ key: 'style', val: var_label_cell_style }]))
	}
	mut var_social_link_content := rt.new_string(rt.concat(var_icon_content, var_label_content))
	mut var_main_table_attrs := rt.create_array([rt.ArrayItem{ key: 'align', val: 'center' }, rt.ArrayItem{ key: 'style', val: var_main_table_styles }])
	mut var_main_row_attrs := rt.create_array([rt.ArrayItem{ key: 'style', val: var_row_container_styles }])
	mut var_main_table := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}; return temp.render_table_wrapper(arg_0, arg_1, arg_2, arg_3, arg_4) }(var_social_link_content.dup(), var_main_table_attrs.dup(), rt.new_array(), var_main_row_attrs.dup(), rt.new_bool(false))
	return (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}; return temp.render_outlook_table_cell(arg_0) }(var_main_table.dup())).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Social_Links) get_block_wrapper(var_block_content rt.PhpVal, var_parsed_block rt.PhpVal) rt.PhpVal {
	mut var_block_content_mutated := var_block_content
	mut var_content := this.adjust_block_content(var_block_content_mutated.dup(), var_parsed_block.dup())
	mut var_table_styles := var_content.array_get('table_styles')
	mut var_classes := var_content.array_get('classes')
	mut var_compiled_styles := var_content.array_get('compiled_styles')
	mut var_align := var_content.array_get('align')
	mut var_table_attrs := rt.create_array([rt.ArrayItem{ key: 'class', val: 'wp-block-social-links' }, rt.ArrayItem{ key: 'style', val: (var_table_styles).str() + ' vertical-align:top;' }, rt.ArrayItem{ key: 'width', val: '100%' }])
	mut var_cell_attrs := rt.create_array([rt.ArrayItem{ key: 'class', val: var_classes }, rt.ArrayItem{ key: 'style', val: var_compiled_styles }, rt.ArrayItem{ key: 'align', val: var_align }])
	mut var_row_attrs := rt.create_array([rt.ArrayItem{ key: 'role', val: 'presentation' }])
	mut var_inner_content := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}; return temp.render_outlook_table_wrapper(arg_0, arg_1, arg_2, arg_3, arg_4) }(rt.new_string('{social_links_content}'), rt.create_array([rt.ArrayItem{ key: 'align', val: 'center' }]), rt.new_array(), rt.new_array(), rt.new_bool(false))
	mut var_main_wrapper := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}; return temp.render_table_wrapper(arg_0, arg_1, arg_2, arg_3) }(var_inner_content.dup(), var_table_attrs.dup(), var_cell_attrs.dup(), var_row_attrs.dup())
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}; return temp.render_outlook_table_wrapper(arg_0, arg_1) }(var_main_wrapper.dup(), rt.create_array([rt.ArrayItem{ key: 'align', val: 'center' }]))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Social_Links) adjust_block_content(var_block_content rt.PhpVal, var_parsed_block rt.PhpVal) rt.PhpVal {
	mut var_block_content_mutated := var_block_content
	var_block_content_mutated = rt.new_string(this.adjust_style_attribute((var_block_content_mutated).str()))
	mut var_block_attributes := rt.call_function('wp_parse_args', [if !(var_parsed_block.array_get('attrs')).is_null() { var_parsed_block.array_get('attrs') } else { rt.new_array() }, rt.create_array([rt.ArrayItem{ key: 'textAlign', val: 'left' }, rt.ArrayItem{ key: 'style', val: rt.new_array() }])])
	mut var_html := create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_html_tag_processor(var_block_content_mutated.dup())
	mut var_classes := rt.new_string(rt.new_string('wp-block-social-links'))
	if rt.is_true(var_html.next_tag()) {
		mut var_block_classes := if !(var_html.get_attribute(rt.new_string('class'))).is_null() { var_html.get_attribute(rt.new_string('class')) } else { rt.new_string('') }
		// unsupported expression: Expr_AssignOp_Concat
		var_block_classes = rt.call_function('str_replace', [rt.new_string('has-background'), rt.new_string(''), var_block_classes.dup()])
		var_block_classes = rt.call_function('preg_replace', [rt.new_string('/[a-z-]+-border-[a-z-]+/'), rt.new_string(''), var_block_classes.dup()])
		var_html.set_attribute(rt.new_string('class'), rt.new_string(var_block_classes.dup().to_string().trim_space()))
		var_block_content_mutated = var_html.get_updated_html()
	}
	mut var_block_styles := this.get_styles_from_block(rt.create_array([rt.ArrayItem{ key: 'color', val: if !(var_block_attributes.array_get('style').array_get('color')).is_null() { var_block_attributes.array_get('style').array_get('color') } else { rt.new_array() } }, rt.ArrayItem{ key: 'spacing', val: if !(var_block_attributes.array_get('style').array_get('spacing')).is_null() { var_block_attributes.array_get('style').array_get('spacing') } else { rt.new_array() } }, rt.ArrayItem{ key: 'typography', val: if !(var_block_attributes.array_get('style').array_get('typography')).is_null() { var_block_attributes.array_get('style').array_get('typography') } else { rt.new_array() } }, rt.ArrayItem{ key: 'border', val: if !(var_block_attributes.array_get('style').array_get('border')).is_null() { var_block_attributes.array_get('style').array_get('border') } else { rt.new_array() } }]))
	mut var_styles := rt.create_array([rt.ArrayItem{ key: 'min-width', val: '100%' }, rt.ArrayItem{ key: 'vertical-align', val: 'middle' }, rt.ArrayItem{ key: 'word-break', val: 'break-word' }])
	var_styles.array_set('text-align', 'left')
	if !(!rt.is_true(var_parsed_block.array_get('attrs').array_get('textAlign'))) {
		var_styles.array_set('text-align', var_parsed_block.array_get('attrs').array_get('textAlign'))
	} else if rt.is_true(rt.call_function('in_array', [if !(var_parsed_block.array_get('attrs').array_get('align')).is_null() { var_parsed_block.array_get('attrs').array_get('align') } else { rt.new_null() }, rt.create_array([rt.ArrayItem{ key: none, val: 'left' }, rt.ArrayItem{ key: none, val: 'center' }, rt.ArrayItem{ key: none, val: 'right' }]), rt.new_bool(true)])) {
		var_styles.array_set('text-align', var_parsed_block.array_get('attrs').array_get('align'))
	}
	mut var_compiled_styles := this.compile_css(var_block_styles.array_get('declarations'), var_styles.dup())
	mut var_table_styles := rt.new_string(rt.new_string('border-collapse: separate;'))
	return rt.create_array([rt.ArrayItem{ key: 'table_styles', val: var_table_styles }, rt.ArrayItem{ key: 'classes', val: var_classes }, rt.ArrayItem{ key: 'compiled_styles', val: var_compiled_styles }, rt.ArrayItem{ key: 'align', val: var_styles.array_get('text-align') }, rt.ArrayItem{ key: 'block_content', val: var_block_content_mutated }])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Social_Links) adjust_style_attribute(block_content string) string {
	mut block_content_mutated := block_content
	mut var_html := create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_html_tag_processor(rt.new_string(block_content_mutated).dup())
	if rt.is_true(var_html.next_tag()) {
		mut var_element_style_value := var_html.get_attribute(rt.new_string('style'))
		mut var_element_style := rt.new_string(if !(var_element_style_value).is_null() { rt.new_string(var_element_style_value.dup().to_string()) } else { rt.new_string('') })
		var_element_style = rt.call_function('preg_replace', [rt.new_string('/padding[^:]*:.?[0-9a-z-()]+;?/'), rt.new_string(''), var_element_style.dup()])
		var_element_style = rt.call_function('preg_replace', [rt.new_string('/border[^:]*:.?[0-9a-z-()#]+;?/'), rt.new_string(''), rt.new_string(var_element_style.dup().to_string())])
		var_element_style = rt.call_function('preg_replace', [rt.new_string('/font-size:[^;]+;?/'), rt.new_string('font-size: inherit;'), rt.new_string(var_element_style.dup().to_string())])
		var_html.set_attribute(rt.new_string('style'), rt.call_function('esc_attr', [var_element_style.dup()]))
		block_content_mutated = (var_html.get_updated_html()).str()
	}
	return block_content_mutated
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Social_Links) get_service_icon_url(var_service rt.PhpVal, image_type string) string {
	mut var_service_mutated := var_service
	mut image_type_mutated := image_type
	image_type_mutated = if image_type_mutated == '' { 'white' } else { image_type_mutated }
	var_service_mutated = rt.new_string(if !rt.is_true(var_service_mutated) { rt.new_string('') } else { rt.new_string(var_service_mutated.dup().to_string().to_lower()) })
	if !rt.is_true(this.core_social_link_services_cache) {
		mut var_services := rt.call_function('block_core_social_link_services', []rt.PhpVal{})
		this.core_social_link_services_cache = 
	}
	if !(this.core_social_link_services_cache.array_isset(var_service_mutated)) {
		return 
	}
	if rt.is_true() {
	}
	
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Social_Links) get_service_png_url(var_service rt.PhpVal, image_type string) string {
	mut var_service_mutated := var_service
	mut image_type_mutated := image_type
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Social_Links) get_service_png_path(var_service rt.PhpVal, image_type string) string {
	mut var_service_mutated := var_service
	mut image_type_mutated := image_type
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Social_Links_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_social_links() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Social_Links {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Social_Links{
		PhpObjectBase: rt.PhpObjectBase{}
		core_social_link_services_cache: rt.new_array()
		supported_image_types: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_abstract_block_renderer() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_social_links_helper() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Social_Links_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Social_Links_Helper{
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

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_html_tag_processor() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Social_Links) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_string(this.render_content(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2))
		}
		'generate_social_link_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.generate_social_link_content(dispatch_arg_0, dispatch_arg_1))
		}
		'get_block_wrapper' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_block_wrapper(dispatch_arg_0, dispatch_arg_1)
		}
		'adjust_block_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.adjust_block_content(dispatch_arg_0, dispatch_arg_1)
		}
		'adjust_style_attribute' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.adjust_style_attribute(dispatch_arg_0))
		}
		'get_service_icon_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.get_service_icon_url(dispatch_arg_0, dispatch_arg_1))
		}
		'get_service_png_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.get_service_png_url(dispatch_arg_0, dispatch_arg_1))
		}
		'get_service_png_path' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.get_service_png_path(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Social_Links) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'core_social_link_services_cache' { return this.core_social_link_services_cache }
		'supported_image_types' { return this.supported_image_types }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Social_Links) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'core_social_link_services_cache' { this.core_social_link_services_cache = val; return true }
		'supported_image_types' { this.supported_image_types = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Social_Links_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Social_Links_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Social_Links_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_integrations_core_renderer_blocks_class_social_links_php() {
	// unsupported statement: Stmt_Declare
}
