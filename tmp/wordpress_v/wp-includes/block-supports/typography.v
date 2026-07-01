import rt

fn wp_register_typography_support(var_block_type rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_block_type, 'WP_Block_Type')))))) {
		return rt.new_null()
	}
	mut var_typography_supports := if !(rt.get_property(var_block_type, 'supports').array_get('typography')).is_null() { rt.get_property(var_block_type, 'supports').array_get('typography') } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_typography_supports)))) {
		return rt.new_null()
	}
	mut var_has_font_family_support := if !(var_typography_supports.array_get('__experimentalFontFamily')).is_null() { var_typography_supports.array_get('__experimentalFontFamily') } else { rt.new_bool(false) }
	mut var_has_font_size_support := if !(var_typography_supports.array_get('fontSize')).is_null() { var_typography_supports.array_get('fontSize') } else { rt.new_bool(false) }
	mut var_has_font_style_support := if !(var_typography_supports.array_get('__experimentalFontStyle')).is_null() { var_typography_supports.array_get('__experimentalFontStyle') } else { rt.new_bool(false) }
	mut var_has_font_weight_support := if !(var_typography_supports.array_get('__experimentalFontWeight')).is_null() { var_typography_supports.array_get('__experimentalFontWeight') } else { rt.new_bool(false) }
	mut var_has_letter_spacing_support := if !(var_typography_supports.array_get('__experimentalLetterSpacing')).is_null() { var_typography_supports.array_get('__experimentalLetterSpacing') } else { rt.new_bool(false) }
	mut var_has_line_height_support := if !(var_typography_supports.array_get('lineHeight')).is_null() { var_typography_supports.array_get('lineHeight') } else { rt.new_bool(false) }
	mut var_has_text_align_support := if !(var_typography_supports.array_get('textAlign')).is_null() { var_typography_supports.array_get('textAlign') } else { rt.new_bool(false) }
	mut var_has_text_columns_support := if !(var_typography_supports.array_get('textColumns')).is_null() { var_typography_supports.array_get('textColumns') } else { rt.new_bool(false) }
	mut var_has_text_decoration_support := if !(var_typography_supports.array_get('__experimentalTextDecoration')).is_null() { var_typography_supports.array_get('__experimentalTextDecoration') } else { rt.new_bool(false) }
	mut var_has_text_transform_support := if !(var_typography_supports.array_get('__experimentalTextTransform')).is_null() { var_typography_supports.array_get('__experimentalTextTransform') } else { rt.new_bool(false) }
	mut var_has_text_indent_support := if !(var_typography_supports.array_get('textIndent')).is_null() { var_typography_supports.array_get('textIndent') } else { rt.new_bool(false) }
	mut var_has_writing_mode_support := if !(var_typography_supports.array_get('__experimentalWritingMode')).is_null() { var_typography_supports.array_get('__experimentalWritingMode') } else { rt.new_bool(false) }
	mut var_has_typography_support := rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_has_font_family_support) || rt.is_true(var_has_font_size_support))) || rt.is_true(var_has_font_style_support))) || rt.is_true(var_has_font_weight_support))) || rt.is_true(var_has_letter_spacing_support))) || rt.is_true(var_has_line_height_support))) || rt.is_true(var_has_text_align_support))) || rt.is_true(var_has_text_columns_support))) || rt.is_true(var_has_text_decoration_support))) || rt.is_true(var_has_text_transform_support))) || rt.is_true(var_has_text_indent_support))) || rt.is_true(var_has_writing_mode_support)
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_block_type, 'attributes'))))) {
		rt.set_property(var_block_type, 'attributes', rt.new_array())
	}
	if rt.is_true(rt.new_bool(var_has_typography_support && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'attributes').array_isset(rt.new_string('style'))))))))) {
		rt.get_property(var_block_type, 'attributes').array_set('style', rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }]))
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_has_font_size_support) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'attributes').array_isset(rt.new_string('fontSize'))))))))) {
		rt.get_property(var_block_type, 'attributes').array_set('fontSize', rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]))
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_has_font_family_support) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'attributes').array_isset(rt.new_string('fontFamily'))))))))) {
		rt.get_property(var_block_type, 'attributes').array_set('fontFamily', rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]))
	}
}

fn wp_apply_typography_support(var_block_type rt.PhpVal, var_block_attributes rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_block_type, 'WP_Block_Type')))))) {
		return rt.new_array()
	}
	mut var_typography_supports := if !(rt.get_property(var_block_type, 'supports').array_get('typography')).is_null() { rt.get_property(var_block_type, 'supports').array_get('typography') } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_typography_supports)))) {
		return rt.new_array()
	}
	if rt.is_true(rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.dup(), rt.new_string('typography')])) {
		return rt.new_array()
	}
	mut var_has_font_family_support := if !(var_typography_supports.array_get('__experimentalFontFamily')).is_null() { var_typography_supports.array_get('__experimentalFontFamily') } else { rt.new_bool(false) }
	mut var_has_font_size_support := if !(var_typography_supports.array_get('fontSize')).is_null() { var_typography_supports.array_get('fontSize') } else { rt.new_bool(false) }
	mut var_has_font_style_support := if !(var_typography_supports.array_get('__experimentalFontStyle')).is_null() { var_typography_supports.array_get('__experimentalFontStyle') } else { rt.new_bool(false) }
	mut var_has_font_weight_support := if !(var_typography_supports.array_get('__experimentalFontWeight')).is_null() { var_typography_supports.array_get('__experimentalFontWeight') } else { rt.new_bool(false) }
	mut var_has_letter_spacing_support := if !(var_typography_supports.array_get('__experimentalLetterSpacing')).is_null() { var_typography_supports.array_get('__experimentalLetterSpacing') } else { rt.new_bool(false) }
	mut var_has_line_height_support := if !(var_typography_supports.array_get('lineHeight')).is_null() { var_typography_supports.array_get('lineHeight') } else { rt.new_bool(false) }
	mut var_has_text_align_support := if !(var_typography_supports.array_get('textAlign')).is_null() { var_typography_supports.array_get('textAlign') } else { rt.new_bool(false) }
	mut var_has_text_columns_support := if !(var_typography_supports.array_get('textColumns')).is_null() { var_typography_supports.array_get('textColumns') } else { rt.new_bool(false) }
	mut var_has_text_decoration_support := if !(var_typography_supports.array_get('__experimentalTextDecoration')).is_null() { var_typography_supports.array_get('__experimentalTextDecoration') } else { rt.new_bool(false) }
	mut var_has_text_transform_support := if !(var_typography_supports.array_get('__experimentalTextTransform')).is_null() { var_typography_supports.array_get('__experimentalTextTransform') } else { rt.new_bool(false) }
	mut var_has_text_indent_support := if !(var_typography_supports.array_get('textIndent')).is_null() { var_typography_supports.array_get('textIndent') } else { rt.new_bool(false) }
	mut var_has_writing_mode_support := if !(var_typography_supports.array_get('__experimentalWritingMode')).is_null() { var_typography_supports.array_get('__experimentalWritingMode') } else { rt.new_bool(false) }
	mut var_should_skip_font_size := rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.dup(), rt.new_string('typography'), rt.new_string('fontSize')])
	mut var_should_skip_font_family := rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.dup(), rt.new_string('typography'), rt.new_string('fontFamily')])
	mut var_should_skip_font_style := rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.dup(), rt.new_string('typography'), rt.new_string('fontStyle')])
	mut var_should_skip_font_weight := rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.dup(), rt.new_string('typography'), rt.new_string('fontWeight')])
	mut var_should_skip_line_height := rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.dup(), rt.new_string('typography'), rt.new_string('lineHeight')])
	mut var_should_skip_text_align := rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.dup(), rt.new_string('typography'), rt.new_string('textAlign')])
	mut var_should_skip_text_columns := rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.dup(), rt.new_string('typography'), rt.new_string('textColumns')])
	mut var_should_skip_text_decoration := rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.dup(), rt.new_string('typography'), rt.new_string('textDecoration')])
	mut var_should_skip_text_transform := rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.dup(), rt.new_string('typography'), rt.new_string('textTransform')])
	mut var_should_skip_letter_spacing := rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.dup(), rt.new_string('typography'), rt.new_string('letterSpacing')])
	mut var_should_skip_text_indent := rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.dup(), rt.new_string('typography'), rt.new_string('textIndent')])
	mut var_should_skip_writing_mode := rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.dup(), rt.new_string('typography'), rt.new_string('writingMode')])
	mut var_typography_block_styles := rt.new_array()
	if rt.is_true(rt.new_bool(rt.is_true(var_has_font_size_support) && rt.is_true(rt.new_bool(!(rt.is_true(var_should_skip_font_size)))))) {
		mut var_preset_font_size := if rt.is_true(rt.new_bool(var_block_attributes.dup().array_isset(rt.new_string('fontSize')))) { rt.concat(rt.new_string('var:preset|font-size|'), var_block_attributes.array_get('fontSize')) } else { rt.new_null() }
		mut var_custom_font_size := if !(var_block_attributes.array_get('style').array_get('typography').array_get('fontSize')).is_null() { var_block_attributes.array_get('style').array_get('typography').array_get('fontSize') } else { rt.new_null() }
		var_typography_block_styles['fontSize'] = if rt.is_true(var_preset_font_size) { var_preset_font_size } else { wp_get_typography_font_size_value(rt.create_array([rt.ArrayItem{ key: 'size', val: var_custom_font_size }]), rt.new_null()) }
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_has_font_family_support) && rt.is_true(rt.new_bool(!(rt.is_true(var_should_skip_font_family)))))) {
		mut var_preset_font_family := if rt.is_true(rt.new_bool(var_block_attributes.dup().array_isset(rt.new_string('fontFamily')))) { rt.concat(rt.new_string('var:preset|font-family|'), var_block_attributes.array_get('fontFamily')) } else { rt.new_null() }
		mut var_custom_font_family := if var_block_attributes.array_get('style').array_get('typography').array_isset(rt.new_string('fontFamily')) { wp_typography_get_preset_inline_style_value(var_block_attributes.array_get('style').array_get('typography').array_get('fontFamily'), 'font-family') } else { rt.new_null() }
		var_typography_block_styles['fontFamily'] = if rt.is_true(var_preset_font_family) { var_preset_font_family } else { var_custom_font_family }
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_has_font_style_support) && rt.is_true(rt.new_bool(!(rt.is_true(var_should_skip_font_style)))))) && var_block_attributes.array_get('style').array_get('typography').array_isset(rt.new_string('fontStyle')))) {
		var_typography_block_styles['fontStyle'] = wp_typography_get_preset_inline_style_value(var_block_attributes.array_get('style').array_get('typography').array_get('fontStyle'), 'font-style')
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_has_font_weight_support) && rt.is_true(rt.new_bool(!(rt.is_true(var_should_skip_font_weight)))))) && var_block_attributes.array_get('style').array_get('typography').array_isset(rt.new_string('fontWeight')))) {
		var_typography_block_styles['fontWeight'] = wp_typography_get_preset_inline_style_value(var_block_attributes.array_get('style').array_get('typography').array_get('fontWeight'), 'font-weight')
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_has_line_height_support) && rt.is_true(rt.new_bool(!(rt.is_true(var_should_skip_line_height)))))) {
		var_typography_block_styles['lineHeight'] = if !(var_block_attributes.array_get('style').array_get('typography').array_get('lineHeight')).is_null() { var_block_attributes.array_get('style').array_get('typography').array_get('lineHeight') } else { rt.new_null() }
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_has_text_align_support) && rt.is_true(rt.new_bool(!(rt.is_true(var_should_skip_text_align)))))) {
		var_typography_block_styles['textAlign'] = if !(var_block_attributes.array_get('style').array_get('typography').array_get('textAlign')).is_null() { var_block_attributes.array_get('style').array_get('typography').array_get('textAlign') } else { rt.new_null() }
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_has_text_columns_support) && rt.is_true(rt.new_bool(!(rt.is_true(var_should_skip_text_columns)))))) && var_block_attributes.array_get('style').array_get('typography').array_isset(rt.new_string('textColumns')))) {
		var_typography_block_styles['textColumns'] = if !(var_block_attributes.array_get('style').array_get('typography').array_get('textColumns')).is_null() { var_block_attributes.array_get('style').array_get('typography').array_get('textColumns') } else { rt.new_null() }
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_has_text_decoration_support) && rt.is_true(rt.new_bool(!(rt.is_true(var_should_skip_text_decoration)))))) && var_block_attributes.array_get('style').array_get('typography').array_isset(rt.new_string('textDecoration')))) {
		var_typography_block_styles['textDecoration'] = wp_typography_get_preset_inline_style_value(var_block_attributes.array_get('style').array_get('typography').array_get('textDecoration'), 'text-decoration')
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_has_text_transform_support) && rt.is_true(rt.new_bool(!(rt.is_true(var_should_skip_text_transform)))))) && var_block_attributes.array_get('style').array_get('typography').array_isset(rt.new_string('textTransform')))) {
		var_typography_block_styles['textTransform'] = wp_typography_get_preset_inline_style_value(var_block_attributes.array_get('style').array_get('typography').array_get('textTransform'), 'text-transform')
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_has_letter_spacing_support) && rt.is_true(rt.new_bool(!(rt.is_true(var_should_skip_letter_spacing)))))) && var_block_attributes.array_get('style').array_get('typography').array_isset(rt.new_string('letterSpacing')))) {
		var_typography_block_styles['letterSpacing'] = wp_typography_get_preset_inline_style_value(var_block_attributes.array_get('style').array_get('typography').array_get('letterSpacing'), 'letter-spacing')
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_has_writing_mode_support) && rt.is_true(rt.new_bool(!(rt.is_true(var_should_skip_writing_mode)))))) && var_block_attributes.array_get('style').array_get('typography').array_isset(rt.new_string('writingMode')))) {
		var_typography_block_styles['writingMode'] = if !(var_block_attributes.array_get('style').array_get('typography').array_get('writingMode')).is_null() { var_block_attributes.array_get('style').array_get('typography').array_get('writingMode') } else { rt.new_null() }
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_has_text_indent_support) && rt.is_true(rt.new_bool(!(rt.is_true(var_should_skip_text_indent)))))) && var_block_attributes.array_get('style').array_get('typography').array_isset(rt.new_string('textIndent')))) {
		var_typography_block_styles['textIndent'] = if !(var_block_attributes.array_get('style').array_get('typography').array_get('textIndent')).is_null() { var_block_attributes.array_get('style').array_get('typography').array_get('textIndent') } else { rt.new_null() }
	}
	mut var_attributes := rt.new_array()
	mut var_classnames := rt.new_array()
	mut var_styles := rt.call_function('wp_style_engine_get_styles', [rt.create_array([rt.ArrayItem{ key: 'typography', val: var_typography_block_styles }]), rt.create_array([rt.ArrayItem{ key: 'convert_vars_to_classnames', val: true }])])
	if !(!rt.is_true(var_styles.array_get('classnames'))) {
		var_classnames << var_styles.array_get('classnames')
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_has_text_align_support) && rt.is_true(rt.new_bool(!(rt.is_true(var_should_skip_text_align)))))) && var_block_attributes.array_get('style').array_get('typography').array_isset(rt.new_string('textAlign')))) {
		var_classnames << 'has-text-align-' + (var_block_attributes.array_get('style').array_get('typography').array_get('textAlign')).str()
	}
	if !(!rt.is_true(var_classnames)) {
		var_attributes['class'] = rt.call_function('implode', [rt.new_string(' '), var_classnames.dup()])
	}
	if !(!rt.is_true(var_styles.array_get('css'))) {
		var_attributes['style'] = var_styles.array_get('css')
	}
	return var_attributes.dup()
}

fn wp_typography_get_preset_inline_style_value(var_style_value rt.PhpVal, css_property string) rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(var_style_value) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_style_value.dup(), rt.new_string("var:preset|${var_css_property}|")]))))))) {
		return var_style_value.dup()
	}
	mut var_index_to_splice := rt.add(rt.call_function('strrpos', [var_style_value.dup(), rt.new_string('|')]), rt.new_int(1))
	mut var_slug := rt.call_function('_wp_to_kebab_case', [rt.call_function('substr', [var_style_value.dup(), var_index_to_splice.dup()])])
	return rt.call_function('sprintf', [rt.new_string('var(--wp--preset--%s--%s);'), rt.new_string(css_property), var_slug.dup()])
}

fn wp_render_typography_support(var_block_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(var_block.array_get('attrs').array_get('fitText'))) && rt.is_true(var_block.array_get('attrs').array_get('fitText')))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))))) {
		rt.call_function('wp_enqueue_script_module', [rt.new_string('@wordpress/block-editor/utils/fit-text-frontend')])
		if !(!rt.is_true(var_block_content)) {
			mut var_processor := create_wp_html_tag_processor(var_block_content.dup())
			if rt.is_true(var_processor.next_tag()) {
				if rt.is_true(rt.new_bool(!(rt.is_true(var_processor.get_attribute(rt.new_string('data-wp-interactive')))))) {
					var_processor.set_attribute(rt.new_string('data-wp-interactive'), rt.new_bool(true))
				}
				var_processor.set_attribute(rt.new_string('data-wp-context---core-fit-text'), rt.new_string('core/fit-text::{"fontSize":""}'))
				var_processor.set_attribute(rt.new_string('data-wp-init---core-fit-text'), rt.new_string('core/fit-text::callbacks.init'))
				var_processor.set_attribute(rt.new_string('data-wp-style--font-size'), rt.new_string('core/fit-text::context.fontSize'))
				var_block_content = var_processor.get_updated_html()
			}
		}
		return var_block_content.dup()
	}
	if !(var_block.array_get('attrs').array_get('style').array_get('typography').array_isset(rt.new_string('fontSize'))) {
		return var_block_content.dup()
	}
	mut var_custom_font_size := var_block.array_get('attrs').array_get('style').array_get('typography').array_get('fontSize')
	mut var_fluid_font_size := wp_get_typography_font_size_value(rt.create_array([rt.ArrayItem{ key: 'size', val: var_custom_font_size }]), rt.new_null())
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_fluid_font_size)) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.call_function('preg_replace', ['/font-size\\s*:\\s*' + (rt.call_function('preg_quote', [var_custom_font_size.dup(), rt.new_string('/')])).str() + '\\s*;?/', 'font-size:' + (rt.call_function('esc_attr', [var_fluid_font_size.dup()])).str() + ';', var_block_content.dup(), rt.new_int(1)])
	}
	return var_block_content.dup()
}

fn wp_get_typography_value_and_unit(var_raw_value rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_matches := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(.dup().is_string()))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(.dup().is_long()))))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_raw_value.dup().is_double()))))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Raw size value must be a string, integer, or float.')]), rt.new_string('6.1.0')])
		return rt.new_null()
	}
	if !rt.is_true(var_raw_value) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(.dup().is_long() || .dup().is_double())) {
		
	}
	
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




pub fn init_wp_includes_block_supports_typography_php() {
}
