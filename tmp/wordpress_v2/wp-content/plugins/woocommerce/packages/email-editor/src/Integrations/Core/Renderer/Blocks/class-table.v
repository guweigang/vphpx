import rt

pub fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table.valid_text_alignments() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'left' }, rt.ArrayItem{ key: none, val: 'center' }, rt.ArrayItem{ key: none, val: 'right' }])
}
struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) render_content(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_extracted_data := this.extract_table_and_caption_from_figure(block_content)
	mut var_table_content := var_extracted_data.array_get(rt.new_string('table'))
	mut var_caption := var_extracted_data.array_get(rt.new_string('caption'))
	if !(this.is_valid_table_content((var_table_content).str())) {
		return ''
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/<(th|td)/i'), var_table_content.clone()]))))) {
		return ''
	}
	mut var_block_attributes := rt.call_function('wp_parse_args', [if !(var_parsed_block.array_get(rt.new_string('attrs'))).is_null() { var_parsed_block.array_get(rt.new_string('attrs')) } else { rt.new_array() }, rt.create_array([rt.ArrayItem{ key: 'textAlign', val: 'left' }, rt.ArrayItem{ key: 'style', val: rt.new_array() }])])
	mut var_html := create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_html_tag_processor(var_table_content.clone())
	mut var_classes := rt.new_string('email-table-block')
	if rt.is_true(var_html.next_tag()) {
		mut var_block_classes := rt.new_string((if !(var_html.get_attribute(rt.new_string('class'))).is_null() { var_html.get_attribute(rt.new_string('class')) } else { rt.new_string('') }).str())
		var_classes = rt.concat(var_classes, rt.new_string(' ' + (var_block_classes).str()))
		mut iife_temp_0 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}
		mut iife_result_0 := iife_temp_0.clean_css_classes(var_block_classes.clone())
		var_block_classes = iife_result_0
		var_html.set_attribute(rt.new_string('class'), var_block_classes.clone())
	var_table_content = var_html.get_updated_html()
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}
	mut iife_result_1 := iife_temp_1.clean_css_classes(var_classes.clone())
	var_classes = iife_result_1
	mut iife_temp_2 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
	mut iife_result_2 := iife_temp_2.get_block_styles(var_block_attributes.clone(), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context', []string{}, var_rendering_context), rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }]))
	mut var_spacing_styles := iife_result_2
	mut iife_temp_3 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
	mut iife_result_3 := iife_temp_3.get_block_styles(var_block_attributes.clone(), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context', []string{}, var_rendering_context), rt.create_array([rt.ArrayItem{ key: none, val: 'background-color' }, rt.ArrayItem{ key: none, val: 'color' }, rt.ArrayItem{ key: none, val: 'typography' }]))
	mut var_table_styles := iife_result_3
	mut var_spacing_css := if !(var_spacing_styles.array_get(rt.new_string('css'))).is_null() { var_spacing_styles.array_get(rt.new_string('css')) } else { rt.new_string('') }
	var_spacing_css = rt.new_string((if !(rt.call_function('preg_replace', [rt.new_string('/background[^;]*;?/'), rt.new_string(''), var_spacing_css.clone()])).is_null() { rt.call_function('preg_replace', [rt.new_string('/background[^;]*;?/'), rt.new_string(''), var_spacing_css.clone()]) } else { rt.new_string('') }).str())
	var_spacing_css = rt.new_string((if !(rt.call_function('preg_replace', [rt.new_string('/\\s*;\\s*;/'), rt.new_string(';'), var_spacing_css.clone()])).is_null() { rt.call_function('preg_replace', [rt.new_string('/\\s*;\\s*;/'), rt.new_string(';'), var_spacing_css.clone()]) } else { rt.new_string('') }).str())
	var_spacing_css = rt.new_string(var_spacing_css.clone().to_string().trim_space())
	var_spacing_styles.array_set('css', if rt.is_true(var_spacing_css) { (var_spacing_css).str() + '; background: transparent !important;' } else { 'background: transparent !important;' })
	mut var_additional_styles := rt.create_array([rt.ArrayItem{ key: 'min-width', val: '100%' }])
	if !rt.is_true(var_table_styles.array_get(rt.new_string('declarations')).array_get(rt.new_string('color'))) {
		mut var_email_styles := var_rendering_context.get_theme_styles()
		mut var_color := if !(var_parsed_block.array_get(rt.new_string('email_attrs')).array_get(rt.new_string('color'))).is_null() { var_parsed_block.array_get(rt.new_string('email_attrs')).array_get(rt.new_string('color')) } else { if !(var_email_styles.array_get(rt.new_string('color')).array_get(rt.new_string('text'))).is_null() { var_email_styles.array_get(rt.new_string('color')).array_get(rt.new_string('text')) } else { rt.new_string('#000000') } }
		mut iife_temp_4 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}
		mut iife_result_4 := iife_temp_4.sanitize_color(var_color.clone())
		var_additional_styles.array_set('color', iife_result_4)
	}
	var_additional_styles.array_set('text-align', 'left')
	if !(!rt.is_true(var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('textAlign')))) {
		mut var_text_align := var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('textAlign'))
		if rt.is_true(rt.call_function('in_array', [var_text_align.clone(), Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table.valid_text_alignments(), rt.new_bool(true)])) {
			var_additional_styles.array_set('text-align', var_text_align.clone())
		}
	} else if rt.is_true(rt.call_function('in_array', [if !(var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('align'))).is_null() { var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('align')) } else { rt.new_null() }, Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table.valid_text_alignments(), rt.new_bool(true)])) {
		var_additional_styles.array_set('text-align', var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('align')))
	}
	mut iife_temp_5 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
	mut iife_result_5 := iife_temp_5.extend_block_styles(var_table_styles.clone(), var_additional_styles.clone())
	var_table_styles = iife_result_5
	mut var_is_striped_table := rt.new_bool(this.is_striped_table(block_content, mut var_parsed_block))
	var_table_content = rt.new_string(this.process_table_content((var_table_content).str(), mut var_parsed_block, mut var_rendering_context, (var_is_striped_table).to_bool()))
	mut var_table_content_with_styles := rt.new_string(this.apply_styles_to_table_element((var_table_content).str(), (var_table_styles.array_get(rt.new_string('css'))).str()))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [rt.new_string(block_content), rt.new_string('wp-block-table')]))))) {
	var_table_content_with_styles = rt.new_string(this.add_class_to_table_element((var_table_content_with_styles).str(), 'wp-block-table'))
	}
	mut var_complete_content := var_table_content_with_styles.clone()
	if !(!rt.is_true(var_caption)) {
		mut iife_temp_6 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}
		mut iife_result_6 := iife_temp_6.sanitize_caption_html(var_caption.clone())
		mut var_sanitized_caption := iife_result_6
		mut var_caption_styles := rt.new_string(this.extract_typography_styles_for_caption((var_table_styles.array_get(rt.new_string('css'))).str()))
		var_complete_content = rt.concat(var_complete_content, rt.new_string('<div style="text-align: center; margin-top: 8px; ' + (var_caption_styles).str() + '">' + (var_sanitized_caption).str() + '</div>'))
	}
	mut var_table_attrs := rt.create_array([rt.ArrayItem{ key: 'style', val: 'border-collapse: separate;' }, rt.ArrayItem{ key: 'width', val: '100%' }])
	mut var_cell_attrs := rt.create_array([rt.ArrayItem{ key: 'class', val: var_classes }, rt.ArrayItem{ key: 'style', val: var_spacing_styles.array_get(rt.new_string('css')) }, rt.ArrayItem{ key: 'align', val: var_additional_styles.array_get(rt.new_string('text-align')) }])
	mut iife_temp_7 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
	mut iife_result_7 := iife_temp_7.render_table_wrapper(var_complete_content.clone(), var_table_attrs.clone(), var_cell_attrs.clone())
	mut var_rendered_table := iife_result_7
	return (var_rendered_table).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) process_table_content(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context, is_striped_table bool) string {
	mut is_striped_table_mutated := is_striped_table
	mut var_html := create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_html_tag_processor(rt.new_string(block_content))
	mut var_custom_border_color := rt.new_string(this.get_custom_border_color(mut var_parsed_block, mut var_rendering_context))
	mut var_custom_border_width := rt.new_string(this.get_custom_border_width(mut var_parsed_block))
	if rt.is_true(var_custom_border_color) {
	mut var_border_color := var_custom_border_color.clone()
	} else {
	mut var_email_styles := var_rendering_context.get_theme_styles()
	mut iife_temp_8 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}
	mut iife_result_8 := iife_temp_8.sanitize_color(if !(var_parsed_block.array_get(rt.new_string('email_attrs')).array_get(rt.new_string('color'))).is_null() { var_parsed_block.array_get(rt.new_string('email_attrs')).array_get(rt.new_string('color')) } else { if !(var_email_styles.array_get(rt.new_string('color')).array_get(rt.new_string('text'))).is_null() { var_email_styles.array_get(rt.new_string('color')).array_get(rt.new_string('text')) } else { rt.new_string('#000000') } })
	var_border_color = iife_result_8
	}
	mut var_current_section := rt.new_string('')
	mut var_row_count := rt.new_int(0)
	for rt.is_true(var_html.next_tag()) {
		mut var_tag_name := var_html.get_tag()
		if rt.is_true(rt.identical(rt.new_string('TABLE'), var_tag_name)) {
			var_html.set_attribute(rt.new_string('border'), rt.new_string('1'))
			var_html.set_attribute(rt.new_string('cellpadding'), rt.new_string('8'))
			var_html.set_attribute(rt.new_string('cellspacing'), rt.new_string('0'))
			var_html.set_attribute(rt.new_string('role'), rt.new_string('presentation'))
			var_html.set_attribute(rt.new_string('width'), rt.new_string('100%'))
			mut var_existing_style := rt.new_string((if !(var_html.get_attribute(rt.new_string('style'))).is_null() { var_html.get_attribute(rt.new_string('style')) } else { rt.new_string('') }).str())
			mut var_class_attr := rt.new_string((if !(var_html.get_attribute(rt.new_string('class'))).is_null() { var_html.get_attribute(rt.new_string('class')) } else { rt.new_string('') }).str())
			mut var_table_layout := rt.new_string((if this.has_fixed_layout((var_class_attr).str()) { 'table-layout: fixed; ' } else { '' }).str())
			mut var_email_table_styles := rt.new_string("${var_table_layout.to_string()}border-collapse: collapse; width: 100%;")
			var_existing_style = rt.new_string(var_existing_style.clone().to_string().trim_right(' \t\n\r'))
			mut var_new_style := if rt.is_true(var_existing_style) { (var_existing_style).str() + '; ' + (var_email_table_styles).str() } else { var_email_table_styles }
			var_html.set_attribute(rt.new_string('style'), var_new_style.clone())
			mut iife_temp_9 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}
			mut iife_result_9 := iife_temp_9.clean_css_classes(var_class_attr.clone())
			var_class_attr = iife_result_9
			var_html.set_attribute(rt.new_string('class'), var_class_attr.clone())
		} else if rt.is_true(rt.identical(rt.new_string('THEAD'), var_tag_name)) {
		var_current_section = rt.new_string('thead')
		var_row_count = rt.new_int(0)
		} else if rt.is_true(rt.identical(rt.new_string('TBODY'), var_tag_name)) {
		var_current_section = rt.new_string('tbody')
		var_row_count = rt.new_int(0)
		} else if rt.is_true(rt.identical(rt.new_string('TFOOT'), var_tag_name)) {
		var_current_section = rt.new_string('tfoot')
		var_row_count = rt.new_int(0)
		} else if rt.is_true(rt.identical(rt.new_string('TR'), var_tag_name)) {
			rt.pre_inc(var_row_count)
		} else if rt.is_true(rt.identical(rt.new_string('TD'), var_tag_name)) || rt.is_true(rt.identical(rt.new_string('TH'), var_tag_name)) {
			var_html.set_attribute(rt.new_string('valign'), rt.new_string('top'))
			var_existing_style = rt.new_string((if !(var_html.get_attribute(rt.new_string('style'))).is_null() { var_html.get_attribute(rt.new_string('style')) } else { rt.new_string('') }).str())
			var_existing_style = rt.new_string(var_existing_style.clone().to_string().trim_right(' \t\n\r'))
			mut var_border_width := if rt.is_true(var_custom_border_width) { var_custom_border_width } else { rt.new_string('1px') }
			mut var_border_style := rt.new_string(this.get_custom_border_style(mut var_parsed_block))
			mut var_cell_text_align := rt.new_string(this.get_cell_text_alignment(mut var_html))
			mut var_email_cell_styles := rt.new_string("vertical-align: top; border: ${var_border_width.to_string()} ${var_border_style.to_string()} ${var_border_color.to_string()}; padding: 8px; text-align: ${var_cell_text_align.to_string()};")
			var_email_cell_styles = rt.new_string(this.add_header_footer_borders(mut var_html, (var_email_cell_styles).str(), (var_border_color).str(), (var_current_section).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_?string](var_custom_border_width)))
			if rt.is_true(rt.new_bool(is_striped_table_mutated)) && rt.is_true(rt.identical(rt.new_string('tbody'), var_current_section)) && rt.is_true(rt.identical(rt.new_int(1), rt.mod_(var_row_count, rt.new_int(2)))) {
				var_email_cell_styles = rt.concat(var_email_cell_styles, rt.new_string(' background-color: #f8f9fa;'))
			}
			mut var_new_cell_style := if rt.is_true(var_existing_style) { (var_existing_style).str() + '; ' + (var_email_cell_styles).str() } else { var_email_cell_styles }
			var_html.set_attribute(rt.new_string('style'), var_new_cell_style.clone())
		}
	}
	return (var_html.get_updated_html()).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) get_custom_border_color(mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_block_attributes := if !(var_parsed_block.array_get(rt.new_string('attrs'))).is_null() { var_parsed_block.array_get(rt.new_string('attrs')) } else { rt.new_array() }
	if !(!rt.is_true(var_block_attributes.array_get(rt.new_string('borderColor')))) {
		mut var_border_color := var_rendering_context.translate_slug_to_color(var_block_attributes.array_get(rt.new_string('borderColor')))
		mut iife_temp_10 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}
		mut iife_result_10 := iife_temp_10.sanitize_color(var_border_color.clone())
		return (iife_result_10).str()
	}
	return (rt.new_null()).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) get_custom_border_width(mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array) string {
	mut var_block_attributes := if !(var_parsed_block.array_get(rt.new_string('attrs'))).is_null() { var_parsed_block.array_get(rt.new_string('attrs')) } else { rt.new_array() }
	if !(!rt.is_true(var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string('width')))) {
		mut var_border_width := var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string('width'))
		mut iife_temp_11 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}
		mut iife_result_11 := iife_temp_11.sanitize_css_value(var_border_width.clone())
		var_border_width = iife_result_11
		if !rt.is_true(var_border_width) {
			return (rt.new_null()).str()
		}
		if rt.is_true(rt.new_bool(var_border_width.clone().is_long() || var_border_width.clone().is_double())) {
			return (var_border_width).str() + 'px'
		}
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[0-9]+\\.?[0-9]*(px|em|rem|pt|pc|in|cm|mm|ex|ch|vw|vh|vmin|vmax)$/'), var_border_width.clone()])) {
			return (var_border_width).str()
		}
		return (rt.new_null()).str()
	}
	return (rt.new_null()).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) get_custom_border_style(mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array) string {
	mut var_style := rt.new_string((if !(var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string('style'))).is_null() { var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string('style')) } else { rt.new_string('') }).str().to_lower())
	mut var_allowed := rt.create_array([rt.ArrayItem{ key: none, val: 'solid' }, rt.ArrayItem{ key: none, val: 'dashed' }, rt.ArrayItem{ key: none, val: 'dotted' }])
	return (if rt.is_true(rt.call_function('in_array', [var_style.clone(), var_allowed.clone(), rt.new_bool(true)])) { var_style } else { rt.new_string('solid') }).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) add_header_footer_borders(mut var_html Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor, base_styles string, border_color string, current_section string, mut var_custom_border_width Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_?string) string {
	mut var_html_mutated := var_html
	mut border_color_mutated := border_color
	mut current_section_mutated := current_section
	mut var_custom_border_width_mutated := var_custom_border_width
	mut var_tag_name := var_html_mutated.get_tag()
	if rt.is_true(var_custom_border_width_mutated) {
		return base_styles
	}
	if rt.is_true(rt.identical(rt.new_string('TH'), var_tag_name)) {
		base_styles = base_styles + " border-bottom: 3px solid ${var_border_color.to_string()};"
	}
	if rt.is_true(rt.identical(rt.new_string('TD'), var_tag_name)) && rt.is_true(rt.identical(rt.new_string('tfoot'), rt.new_string(current_section_mutated))) {
		base_styles = base_styles + " border-top: 3px solid ${var_border_color.to_string()};"
	}
	return base_styles
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) get_cell_text_alignment(mut var_html Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor) string {
	mut var_html_mutated := var_html
	mut var_data_align := var_html_mutated.get_attribute(rt.new_string('data-align'))
	if rt.is_true(var_data_align) && rt.is_true(rt.call_function('in_array', [var_data_align.clone(), Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table.valid_text_alignments(), rt.new_bool(true)])) {
		return (var_data_align).str()
	}
	mut var_class_attr := rt.new_string((if !(var_html_mutated.get_attribute(rt.new_string('class'))).is_null() { var_html_mutated.get_attribute(rt.new_string('class')) } else { rt.new_string('') }).str())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_class_attr.clone(), rt.new_string('has-text-align-center')]))))) {
		return 'center'
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_class_attr.clone(), rt.new_string('has-text-align-right')]))))) {
		return 'right'
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_class_attr.clone(), rt.new_string('has-text-align-left')]))))) {
		return 'left'
	}
	return 'left'
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) has_fixed_layout(class_attr string) bool {
	mut class_attr_mutated := class_attr
	return rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [rt.new_string(class_attr_mutated).clone(), rt.new_string('has-fixed-layout')]))))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) extract_table_and_caption_from_figure(block_content string) rt.PhpVal {
	mut var_table_matches := rt.new_null()
	mut var_figcaption_matches := rt.new_null()
	mut var_dom_helper := create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(rt.new_string(block_content))
	mut var_figure_tag := var_dom_helper.find_element(rt.new_string('figure'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_figure_tag)))) {
		return rt.create_array([rt.ArrayItem{ key: 'table', val: block_content }, rt.ArrayItem{ key: 'caption', val: '' }])
	}
	mut var_figure_class_attr := var_dom_helper.get_attribute_value(var_figure_tag.clone(), rt.new_string('class'))
	mut var_figure_class := rt.new_string((if rt.is_true(var_figure_class_attr) { var_figure_class_attr } else { rt.new_string('') }).str())
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_figure_class.clone(), rt.new_string('wp-block-table')]))) {
		return rt.create_array([rt.ArrayItem{ key: 'table', val: block_content }, rt.ArrayItem{ key: 'caption', val: '' }])
	}
	mut var_figure_html := var_dom_helper.get_outer_html(var_figure_tag.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/<table[^>]*>.*?<\\/table>/is'), var_figure_html.clone(), var_table_matches.clone()]))))) {
		return rt.create_array([rt.ArrayItem{ key: 'table', val: block_content }, rt.ArrayItem{ key: 'caption', val: '' }])
	}
	mut var_table_html := var_table_matches.array_get(rt.new_int(0))
	mut var_caption := rt.new_string('')
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/<figcaption[^>]*>(.*?)<\\/figcaption>/is'), var_figure_html.clone(), var_figcaption_matches.clone()])) {
	var_caption = var_figcaption_matches.array_get(rt.new_int(1))
	}
	return rt.create_array([rt.ArrayItem{ key: 'table', val: var_table_html }, rt.ArrayItem{ key: 'caption', val: var_caption }])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) apply_styles_to_table_element(table_content string, styles string) string {
	mut table_content_mutated := table_content
	mut var_html := create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_html_tag_processor(rt.new_string(table_content_mutated).clone())
	if rt.is_true(var_html.next_tag(rt.create_array([rt.ArrayItem{ key: 'tag_name', val: 'TABLE' }]))) {
		mut var_existing_style := rt.new_string((if !(var_html.get_attribute(rt.new_string('style'))).is_null() { var_html.get_attribute(rt.new_string('style')) } else { rt.new_string('') }).str())
		var_existing_style = rt.new_string(var_existing_style.clone().to_string().trim_right(' \t\n\r'))
		mut var_border_width_styles := rt.new_string(this.get_default_border_widths((var_existing_style).str()))
		mut var_new_style := var_existing_style.clone()
		if !(!rt.is_true(var_border_width_styles)) {
		var_new_style = if rt.is_true(var_new_style) { (var_new_style).str() + '; ' + (var_border_width_styles).str() } else { var_border_width_styles }
		}
		if !(styles == '') {
		var_new_style = rt.new_string((if rt.is_true(var_new_style) { (var_new_style).str() + '; ' + styles } else { styles }).str())
		}
		var_html.set_attribute(rt.new_string('style'), var_new_style.clone())
		return (var_html.get_updated_html()).str()
	}
	return table_content_mutated
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) get_default_border_widths(existing_style string) string {
	mut existing_style_mutated := existing_style
	mut var_sides := rt.create_array([rt.ArrayItem{ key: none, val: 'top' }, rt.ArrayItem{ key: none, val: 'right' }, rt.ArrayItem{ key: none, val: 'bottom' }, rt.ArrayItem{ key: none, val: 'left' }])
	mut var_border_width_styles := rt.new_array()
	mut iter_1 := var_sides.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_side := item_1.val
		mut var_has_color := rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [rt.new_string(existing_style_mutated).clone(), rt.new_string("border-${var_side.to_string()}-color:")]), rt.new_bool(false))))
		mut var_has_width := rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [rt.new_string(existing_style_mutated).clone(), rt.new_string("border-${var_side.to_string()}-width:")]), rt.new_bool(false))))
		if rt.is_true(var_has_color) && rt.is_true(rt.new_bool(!(rt.is_true(var_has_width)))) {
			var_border_width_styles.array_push("border-${var_side.to_string()}-width: 1.5px")
		}
	}
	return (rt.call_function('implode', [rt.new_string('; '), var_border_width_styles.clone()])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) add_class_to_table_element(table_content string, class_name string) string {
	mut table_content_mutated := table_content
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[a-zA-Z0-9\\-_]+$/'), rt.new_string(class_name)]))))) {
		return table_content_mutated
	}
	mut var_html := create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_html_tag_processor(rt.new_string(table_content_mutated).clone())
	if rt.is_true(var_html.next_tag(rt.create_array([rt.ArrayItem{ key: 'tag_name', val: 'TABLE' }]))) {
		mut var_existing_class := rt.new_string((if !(var_html.get_attribute(rt.new_string('class'))).is_null() { var_html.get_attribute(rt.new_string('class')) } else { rt.new_string('') }).str())
		var_existing_class = rt.new_string(var_existing_class.clone().to_string().trim_space())
		if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_existing_class.clone(), rt.new_string(class_name)]))) {
			mut var_new_class := rt.new_string((if rt.is_true(var_existing_class) { (var_existing_class).str() + ' ' + class_name } else { class_name }).str())
			var_html.set_attribute(rt.new_string('class'), var_new_class.clone())
		}
		return (var_html.get_updated_html()).str()
	}
	return table_content_mutated
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) extract_typography_styles_for_caption(css string) string {
	mut var_matches := rt.new_null()
	mut iife_temp_12 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}
	mut iife_result_12 := iife_temp_12.get_caption_css_properties()
	mut var_typography_properties := iife_result_12
	mut var_caption_styles := rt.new_array()
	mut iter_2 := var_typography_properties.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_property := item_2.val
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('/' + (rt.call_function('preg_quote', [var_property.clone(), rt.new_string('/')])).str() + '\\s*:\\s*([^;]+)/i'), rt.new_string(css), var_matches.clone()])) {
			mut var_value := rt.new_string(var_matches.array_get(rt.new_int(1)).to_string().trim_space())
			mut iife_temp_13 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}
			mut iife_result_13 := iife_temp_13.sanitize_css_value(var_value.clone())
			mut var_sanitized_value := iife_result_13
			if !(!rt.is_true(var_sanitized_value)) {
				var_caption_styles.array_push((var_property).str() + ': ' + (var_sanitized_value).str())
			}
		}
	}
	return (rt.call_function('implode', [rt.new_string('; '), var_caption_styles.clone()])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) is_striped_table(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array) bool {
	if var_parsed_block.array_get(rt.new_string('attrs')).array_isset(rt.new_string('className')) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('className')), rt.new_string('is-style-stripes')]))))) {
		return true
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [rt.new_string(block_content), rt.new_string('is-style-stripes')]))))) {
		return true
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) is_valid_table_content(content string) bool {
	return (rt.call_function('preg_match', [rt.new_string('/<table[^>]*>.*?<\\/table>/is'), rt.new_string(content)])).to_bool()
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

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_table(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table{
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

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_html_tag_processor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_html_processing_helper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{
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
