import rt

pub fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table.valid_text_alignments() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'left' }, rt.ArrayItem{ key: none, val: 'center' }, rt.ArrayItem{ key: none, val: 'right' }])
}
struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) render_content(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_extracted_data := this.extract_table_and_caption_from_figure(block_content)
	mut var_table_content := var_extracted_data.array_get('table')
	mut var_caption := var_extracted_data.array_get('caption')
	if !(this.is_valid_table_content((var_table_content).str())) {
		return ''
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/<(th|td)/i'), var_table_content.dup()]))))) {
		return ''
	}
	mut var_block_attributes := rt.call_function('wp_parse_args', [if !(var_parsed_block.array_get('attrs')).is_null() { var_parsed_block.array_get('attrs') } else { rt.new_array() }, rt.create_array([rt.ArrayItem{ key: 'textAlign', val: 'left' }, rt.ArrayItem{ key: 'style', val: rt.new_array() }])])
	mut var_html := create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_html_tag_processor(var_table_content.dup())
	mut var_classes := rt.new_string(rt.new_string('email-table-block'))
	if rt.is_true(var_html.next_tag()) {
		mut var_block_classes := // unsupported expression: Expr_Cast_String
		// unsupported expression: Expr_AssignOp_Concat
		var_block_classes = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}; return temp.clean_css_classes(arg_0) }(var_block_classes.dup())
		var_html.set_attribute(rt.new_string('class'), var_block_classes.dup())
		var_table_content = var_html.get_updated_html()
	}
	var_classes = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}; return temp.clean_css_classes(arg_0) }(var_classes.dup())
	mut var_spacing_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.get_block_styles(arg_0, arg_1, arg_2) }(var_block_attributes.dup(), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context', []string{}, var_rendering_context), rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }]))
	mut var_table_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.get_block_styles(arg_0, arg_1, arg_2) }(var_block_attributes.dup(), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context', []string{}, var_rendering_context), rt.create_array([rt.ArrayItem{ key: none, val: 'background-color' }, rt.ArrayItem{ key: none, val: 'color' }, rt.ArrayItem{ key: none, val: 'typography' }]))
	mut var_spacing_css := if !(var_spacing_styles.array_get('css')).is_null() { var_spacing_styles.array_get('css') } else { rt.new_string('') }
	var_spacing_css = // unsupported expression: Expr_Cast_String
	var_spacing_css = // unsupported expression: Expr_Cast_String
	var_spacing_css = rt.new_string(rt.new_string(var_spacing_css.dup().to_string().trim_space()))
	var_spacing_styles.array_set('css', if rt.is_true(var_spacing_css) { (var_spacing_css).str() + '; background: transparent !important;' } else { 'background: transparent !important;' })
	mut var_additional_styles := rt.create_array([rt.ArrayItem{ key: 'min-width', val: '100%' }])
	if !rt.is_true(var_table_styles.array_get('declarations').array_get('color')) {
		mut var_email_styles := var_rendering_context.get_theme_styles()
		mut var_color := if !(var_parsed_block.array_get('email_attrs').array_get('color')).is_null() { var_parsed_block.array_get('email_attrs').array_get('color') } else { if !(var_email_styles.array_get('color').array_get('text')).is_null() { var_email_styles.array_get('color').array_get('text') } else { rt.new_string('#000000') } }
		var_additional_styles.array_set('color', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}; return temp.sanitize_color(arg_0) }(var_color.dup()))
	}
	var_additional_styles.array_set('text-align', 'left')
	if !(!rt.is_true(var_parsed_block.array_get('attrs').array_get('textAlign'))) {
		mut var_text_align := var_parsed_block.array_get('attrs').array_get('textAlign')
		if rt.is_true(rt.call_function('in_array', [var_text_align.dup(), Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table.valid_text_alignments(), rt.new_bool(true)])) {
			var_additional_styles.array_set('text-align', var_text_align.dup())
		}
	} else if rt.is_true(rt.call_function('in_array', [if !(var_parsed_block.array_get('attrs').array_get('align')).is_null() { var_parsed_block.array_get('attrs').array_get('align') } else { rt.new_null() }, Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table.valid_text_alignments(), rt.new_bool(true)])) {
		var_additional_styles.array_set('text-align', var_parsed_block.array_get('attrs').array_get('align'))
	}
	var_table_styles = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.extend_block_styles(arg_0, arg_1) }(var_table_styles.dup(), var_additional_styles.dup())
	mut var_is_striped_table := rt.new_bool(this.is_striped_table(block_content, mut var_parsed_block))
	var_table_content = rt.new_string(this.process_table_content((var_table_content).str(), mut var_parsed_block, mut var_rendering_context, (var_is_striped_table).to_bool()))
	mut var_table_content_with_styles := rt.new_string(this.apply_styles_to_table_element((var_table_content).str(), (var_table_styles.array_get('css')).str()))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_table_content_with_styles = rt.new_string(this.add_class_to_table_element((var_table_content_with_styles).str(), 'wp-block-table'))
	}
	mut var_complete_content := var_table_content_with_styles.dup()
	if !(!rt.is_true(var_caption)) {
		mut var_sanitized_caption := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}; return temp.sanitize_caption_html(arg_0) }(var_caption.dup())
		mut var_caption_styles := rt.new_string(this.extract_typography_styles_for_caption((var_table_styles.array_get('css')).str()))
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_table_attrs := rt.create_array([rt.ArrayItem{ key: 'style', val: 'border-collapse: separate;' }, rt.ArrayItem{ key: 'width', val: '100%' }])
	mut var_cell_attrs := rt.create_array([rt.ArrayItem{ key: 'class', val: var_classes }, rt.ArrayItem{ key: 'style', val: var_spacing_styles.array_get('css') }, rt.ArrayItem{ key: 'align', val: var_additional_styles.array_get('text-align') }])
	mut var_rendered_table := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}; return temp.render_table_wrapper(arg_0, arg_1, arg_2) }(var_complete_content.dup(), var_table_attrs.dup(), var_cell_attrs.dup())
	return (var_rendered_table).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) process_table_content(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context, is_striped_table bool) string {
	mut is_striped_table_mutated := is_striped_table
	mut var_html := create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_html_tag_processor(rt.new_string(block_content).dup())
	mut var_custom_border_color := rt.new_string(this.get_custom_border_color(mut var_parsed_block, mut var_rendering_context))
	mut var_custom_border_width := rt.new_string(this.get_custom_border_width(mut var_parsed_block))
	if rt.is_true(var_custom_border_color) {
		mut var_border_color := var_custom_border_color.dup()
	} else {
		mut var_email_styles := var_rendering_context.get_theme_styles()
		var_border_color = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}; return temp.sanitize_color(arg_0) }(if !(var_parsed_block.array_get('email_attrs').array_get('color')).is_null() { var_parsed_block.array_get('email_attrs').array_get('color') } else { if !(var_email_styles.array_get('color').array_get('text')).is_null() { var_email_styles.array_get('color').array_get('text') } else { rt.new_string('#000000') } })
	}
	mut var_current_section := rt.new_string(rt.new_string(''))
	mut var_row_count := rt.new_int(rt.new_int(0))
	for rt.is_true(var_html.next_tag()) {
		mut var_tag_name := var_html.get_tag()
		if rt.is_true(rt.identical(rt.new_string('TABLE'), var_tag_name)) {
			var_html.set_attribute(rt.new_string('border'), rt.new_string('1'))
			var_html.set_attribute(rt.new_string('cellpadding'), rt.new_string('8'))
			var_html.set_attribute(rt.new_string('cellspacing'), rt.new_string('0'))
			var_html.set_attribute(rt.new_string('role'), rt.new_string('presentation'))
			var_html.set_attribute(rt.new_string('width'), rt.new_string('100%'))
			mut var_existing_style := // unsupported expression: Expr_Cast_String
			mut var_class_attr := // unsupported expression: Expr_Cast_String
			mut var_table_layout := rt.new_string(if this.has_fixed_layout((var_class_attr).str()) { rt.new_string('table-layout: fixed; ') } else { rt.new_string('') })
			mut var_email_table_styles := rt.new_string(rt.new_string("${var_table_layout.to_string()}border-collapse: collapse; width: 100%;"))
			var_existing_style = rt.new_string(rt.new_string(var_existing_style.dup().to_string().trim_right(' \t\n\r')))
			mut var_new_style := if rt.is_true(var_existing_style) { (var_existing_style).str() + '; ' + (var_email_table_styles).str() } else { var_email_table_styles }
			var_html.set_attribute(rt.new_string('style'), var_new_style.dup())
			var_class_attr = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}; return temp.clean_css_classes(arg_0) }(var_class_attr.dup())
			var_html.set_attribute(rt.new_string('class'), var_class_attr.dup())
		} else if rt.is_true(rt.identical(rt.new_string('THEAD'), var_tag_name)) {
			var_current_section = rt.new_string(rt.new_string('thead'))
			var_row_count = rt.new_int(rt.new_int(0))
		} else if rt.is_true(rt.identical(rt.new_string('TBODY'), var_tag_name)) {
			var_current_section = rt.new_string(rt.new_string('tbody'))
			var_row_count = rt.new_int(rt.new_int(0))
		} else if rt.is_true(rt.identical(rt.new_string('TFOOT'), var_tag_name)) {
			var_current_section = rt.new_string(rt.new_string('tfoot'))
			var_row_count = rt.new_int(rt.new_int(0))
		} else if rt.is_true(rt.identical(rt.new_string('TR'), var_tag_name)) {
			rt.pre_inc(var_row_count)
		} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('TD'), var_tag_name)) || rt.is_true(rt.identical(rt.new_string('TH'), var_tag_name)))) {
			var_html.set_attribute(rt.new_string('valign'), rt.new_string('top'))
			var_existing_style = // unsupported expression: Expr_Cast_String
			var_existing_style = rt.new_string(rt.new_string(var_existing_style.dup().to_string().trim_right(' \t\n\r')))
			mut var_border_width := if rt.is_true(var_custom_border_width) { var_custom_border_width } else { rt.new_string('1px') }
			mut var_border_style := rt.new_string(this.get_custom_border_style(mut var_parsed_block))
			mut var_cell_text_align := rt.new_string(this.get_cell_text_alignment(mut var_html))
			mut var_email_cell_styles := rt.new_string(rt.new_string("vertical-align: top; border: ${var_border_width.to_string()} ${var_border_style.to_string()} ${var_border_color.to_string()}; padding: 8px; text-align: ${var_cell_text_align.to_string()};"))
			var_email_cell_styles = rt.new_string(this.add_header_footer_borders(mut var_html, (var_email_cell_styles).str(), (var_border_color).str(), (var_current_section).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_?string](var_custom_border_width)))
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(is_striped_table_mutated)) && rt.is_true(rt.identical(rt.new_string('tbody'), var_current_section)))) && rt.is_true(rt.identical(rt.new_int(1), rt.mod_(var_row_count, rt.new_int(2)))))) {
				// unsupported expression: Expr_AssignOp_Concat
			}
			mut var_new_cell_style := if rt.is_true(var_existing_style) { (var_existing_style).str() + '; ' + (var_email_cell_styles).str() } else { var_email_cell_styles }
			var_html.set_attribute(rt.new_string('style'), var_new_cell_style.dup())
		}
	}
	return (var_html.get_updated_html()).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) get_custom_border_color(mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_block_attributes := if !(var_parsed_block.array_get('attrs')).is_null() { var_parsed_block.array_get('attrs') } else { rt.new_array() }
	if !(!rt.is_true(var_block_attributes.array_get('borderColor'))) {
		mut var_border_color := var_rendering_context.translate_slug_to_color(var_block_attributes.array_get('borderColor'))
		return (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}; return temp.sanitize_color(arg_0) }(var_border_color.dup())).str()
	}
	return (rt.new_null()).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) get_custom_border_width(mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array) string {
	mut var_block_attributes := if !().is_null() {  } else {  }
	if !(!rt.is_true(.array_get())) {
		
	}
	return ().str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) get_custom_border_style(mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array) string {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) add_header_footer_borders(mut var_html Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor, base_styles string, border_color string, current_section string, mut var_custom_border_width Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_?string) string {
	mut var_html_mutated := var_html
	mut border_color_mutated := border_color
	mut current_section_mutated := current_section
	mut var_custom_border_width_mutated := var_custom_border_width
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) get_cell_text_alignment(mut var_html Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor) string {
	mut var_html_mutated := var_html
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) has_fixed_layout(class_attr string) bool {
	mut class_attr_mutated := class_attr
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) extract_table_and_caption_from_figure(block_content string) rt.PhpVal {
	mut var_table_matches := rt.new_null()
	mut var_figcaption_matches := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) apply_styles_to_table_element(table_content string, styles string) string {
	mut table_content_mutated := table_content
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) get_default_border_widths(existing_style string) string {
	mut existing_style_mutated := existing_style
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) add_class_to_table_element(table_content string, class_name string) string {
	mut table_content_mutated := table_content
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) extract_typography_styles_for_caption(css string) string {
	mut var_matches := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) is_striped_table(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array) bool {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) is_valid_table_content(content string) bool {
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_table() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table{
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

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_html_tag_processor() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_html_processing_helper() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{
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

fn create_automattic_woocommerce_emaileditor_integrations_utils_table_wrapper_helper() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_string(this.render_content(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2))
		}
		'process_table_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return rt.new_string(this.process_table_content(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3))
		}
		'get_custom_border_color' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(this.get_custom_border_color(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'get_custom_border_width' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_custom_border_width(mut dispatch_arg_0))
		}
		'get_custom_border_style' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_custom_border_style(mut dispatch_arg_0))
		}
		'add_header_footer_borders' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_?string](if args.len > 4 { args[4] } else { rt.new_null() })
			return rt.new_string(this.add_header_footer_borders(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, mut dispatch_arg_4))
		}
		'get_cell_text_alignment' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_cell_text_alignment(mut dispatch_arg_0))
		}
		'has_fixed_layout' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.has_fixed_layout(dispatch_arg_0))
		}
		'extract_table_and_caption_from_figure' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.extract_table_and_caption_from_figure(dispatch_arg_0)
		}
		'apply_styles_to_table_element' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.apply_styles_to_table_element(dispatch_arg_0, dispatch_arg_1))
		}
		'get_default_border_widths' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_default_border_widths(dispatch_arg_0))
		}
		'add_class_to_table_element' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.add_class_to_table_element(dispatch_arg_0, dispatch_arg_1))
		}
		'extract_typography_styles_for_caption' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.extract_typography_styles_for_caption(dispatch_arg_0))
		}
		'is_striped_table' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(this.is_striped_table(dispatch_arg_0, mut dispatch_arg_1))
		}
		'is_valid_table_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_valid_table_content(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_integrations_core_renderer_blocks_class_table_php() {
	// unsupported statement: Stmt_Declare
}
