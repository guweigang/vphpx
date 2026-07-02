import rt

fn wp_register_typography_support(var_block_type rt.PhpVal) {
	mut var_typography_supports := rt.new_null()
	mut var_has_font_family_support := rt.new_null()
	mut var_has_font_size_support := rt.new_null()
	mut var_has_font_style_support := rt.new_null()
	mut var_has_font_weight_support := rt.new_null()
	mut var_has_letter_spacing_support := rt.new_null()
	mut var_has_line_height_support := rt.new_null()
	mut var_has_text_align_support := rt.new_null()
	mut var_has_text_columns_support := rt.new_null()
	mut var_has_text_decoration_support := rt.new_null()
	mut var_has_text_transform_support := rt.new_null()
	mut var_has_text_indent_support := rt.new_null()
	mut var_has_writing_mode_support := rt.new_null()
	mut var_has_typography_support := false
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_block_type,
		'WP_Block_Type'))))))
	{
		return
	}
	var_typography_supports = if !(rt.get_property(var_block_type, 'supports').array_get(rt.new_string('typography'))).is_null() {
		rt.get_property(var_block_type, 'supports').array_get(rt.new_string('typography'))
	} else {
		rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_typography_supports)))) {
		return
	}
	var_has_font_family_support = if !(var_typography_supports.array_get(rt.new_string('__experimentalFontFamily'))).is_null() {
		var_typography_supports.array_get(rt.new_string('__experimentalFontFamily'))
	} else {
		rt.new_bool(false)
	}
	var_has_font_size_support = if !(var_typography_supports.array_get(rt.new_string('fontSize'))).is_null() {
		var_typography_supports.array_get(rt.new_string('fontSize'))
	} else {
		rt.new_bool(false)
	}
	var_has_font_style_support = if !(var_typography_supports.array_get(rt.new_string('__experimentalFontStyle'))).is_null() {
		var_typography_supports.array_get(rt.new_string('__experimentalFontStyle'))
	} else {
		rt.new_bool(false)
	}
	var_has_font_weight_support = if !(var_typography_supports.array_get(rt.new_string('__experimentalFontWeight'))).is_null() {
		var_typography_supports.array_get(rt.new_string('__experimentalFontWeight'))
	} else {
		rt.new_bool(false)
	}
	var_has_letter_spacing_support = if !(var_typography_supports.array_get(rt.new_string('__experimentalLetterSpacing'))).is_null() {
		var_typography_supports.array_get(rt.new_string('__experimentalLetterSpacing'))
	} else {
		rt.new_bool(false)
	}
	var_has_line_height_support = if !(var_typography_supports.array_get(rt.new_string('lineHeight'))).is_null() {
		var_typography_supports.array_get(rt.new_string('lineHeight'))
	} else {
		rt.new_bool(false)
	}
	var_has_text_align_support = if !(var_typography_supports.array_get(rt.new_string('textAlign'))).is_null() {
		var_typography_supports.array_get(rt.new_string('textAlign'))
	} else {
		rt.new_bool(false)
	}
	var_has_text_columns_support = if !(var_typography_supports.array_get(rt.new_string('textColumns'))).is_null() {
		var_typography_supports.array_get(rt.new_string('textColumns'))
	} else {
		rt.new_bool(false)
	}
	var_has_text_decoration_support = if !(var_typography_supports.array_get(rt.new_string('__experimentalTextDecoration'))).is_null() {
		var_typography_supports.array_get(rt.new_string('__experimentalTextDecoration'))
	} else {
		rt.new_bool(false)
	}
	var_has_text_transform_support = if !(var_typography_supports.array_get(rt.new_string('__experimentalTextTransform'))).is_null() {
		var_typography_supports.array_get(rt.new_string('__experimentalTextTransform'))
	} else {
		rt.new_bool(false)
	}
	var_has_text_indent_support = if !(var_typography_supports.array_get(rt.new_string('textIndent'))).is_null() {
		var_typography_supports.array_get(rt.new_string('textIndent'))
	} else {
		rt.new_bool(false)
	}
	var_has_writing_mode_support = if !(var_typography_supports.array_get(rt.new_string('__experimentalWritingMode'))).is_null() {
		var_typography_supports.array_get(rt.new_string('__experimentalWritingMode'))
	} else {
		rt.new_bool(false)
	}
	var_has_typography_support = rt.is_true(var_has_font_family_support)
		|| rt.is_true(var_has_font_size_support) || rt.is_true(var_has_font_style_support)
		|| rt.is_true(var_has_font_weight_support) || rt.is_true(var_has_letter_spacing_support)
		|| rt.is_true(var_has_line_height_support) || rt.is_true(var_has_text_align_support)
		|| rt.is_true(var_has_text_columns_support) || rt.is_true(var_has_text_decoration_support)
		|| rt.is_true(var_has_text_transform_support) || rt.is_true(var_has_text_indent_support)
		|| rt.is_true(var_has_writing_mode_support)
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_block_type, 'attributes'))))) {
		rt.set_property(var_block_type, 'attributes', rt.new_array())
	}
	if var_has_typography_support
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'attributes').array_isset(rt.new_string('style'))))))) {
		rt.get_property(var_block_type, 'attributes').array_set('style', rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'object' },
		]))
	}
	if rt.is_true(var_has_font_size_support)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'attributes').array_isset(rt.new_string('fontSize'))))))) {
		rt.get_property(var_block_type, 'attributes').array_set('fontSize', rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
		]))
	}
	if rt.is_true(var_has_font_family_support)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'attributes').array_isset(rt.new_string('fontFamily'))))))) {
		rt.get_property(var_block_type, 'attributes').array_set('fontFamily', rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
		]))
	}
}

fn wp_apply_typography_support(var_block_type rt.PhpVal, var_block_attributes rt.PhpVal) rt.PhpVal {
	mut var_typography_supports := rt.new_null()
	mut var_has_font_family_support := rt.new_null()
	mut var_has_font_size_support := rt.new_null()
	mut var_has_font_style_support := rt.new_null()
	mut var_has_font_weight_support := rt.new_null()
	mut var_has_letter_spacing_support := rt.new_null()
	mut var_has_line_height_support := rt.new_null()
	mut var_has_text_align_support := rt.new_null()
	mut var_has_text_columns_support := rt.new_null()
	mut var_has_text_decoration_support := rt.new_null()
	mut var_has_text_transform_support := rt.new_null()
	mut var_has_text_indent_support := rt.new_null()
	mut var_has_writing_mode_support := rt.new_null()
	mut var_should_skip_font_size := rt.new_null()
	mut var_should_skip_font_family := rt.new_null()
	mut var_should_skip_font_style := rt.new_null()
	mut var_should_skip_font_weight := rt.new_null()
	mut var_should_skip_line_height := rt.new_null()
	mut var_should_skip_text_align := rt.new_null()
	mut var_should_skip_text_columns := rt.new_null()
	mut var_should_skip_text_decoration := rt.new_null()
	mut var_should_skip_text_transform := rt.new_null()
	mut var_should_skip_letter_spacing := rt.new_null()
	mut var_should_skip_text_indent := rt.new_null()
	mut var_should_skip_writing_mode := rt.new_null()
	mut var_typography_block_styles := map[string]rt.PhpVal{}
	mut var_preset_font_size := rt.new_null()
	mut var_custom_font_size := rt.new_null()
	mut var_preset_font_family := rt.new_null()
	mut var_custom_font_family := rt.new_null()
	mut var_attributes := map[string]rt.PhpVal{}
	mut var_classnames := []rt.PhpVal{}
	mut var_styles := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_block_type,
		'WP_Block_Type'))))))
	{
		return rt.new_array()
	}
	var_typography_supports = if !(rt.get_property(var_block_type, 'supports').array_get(rt.new_string('typography'))).is_null() {
		rt.get_property(var_block_type, 'supports').array_get(rt.new_string('typography'))
	} else {
		rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_typography_supports)))) {
		return rt.new_array()
	}
	if rt.is_true(rt.call_function('wp_should_skip_block_supports_serialization', [
		var_block_type.clone(),
		rt.new_string('typography'),
	]))
	{
		return rt.new_array()
	}
	var_has_font_family_support = if !(var_typography_supports.array_get(rt.new_string('__experimentalFontFamily'))).is_null() {
		var_typography_supports.array_get(rt.new_string('__experimentalFontFamily'))
	} else {
		rt.new_bool(false)
	}
	var_has_font_size_support = if !(var_typography_supports.array_get(rt.new_string('fontSize'))).is_null() {
		var_typography_supports.array_get(rt.new_string('fontSize'))
	} else {
		rt.new_bool(false)
	}
	var_has_font_style_support = if !(var_typography_supports.array_get(rt.new_string('__experimentalFontStyle'))).is_null() {
		var_typography_supports.array_get(rt.new_string('__experimentalFontStyle'))
	} else {
		rt.new_bool(false)
	}
	var_has_font_weight_support = if !(var_typography_supports.array_get(rt.new_string('__experimentalFontWeight'))).is_null() {
		var_typography_supports.array_get(rt.new_string('__experimentalFontWeight'))
	} else {
		rt.new_bool(false)
	}
	var_has_letter_spacing_support = if !(var_typography_supports.array_get(rt.new_string('__experimentalLetterSpacing'))).is_null() {
		var_typography_supports.array_get(rt.new_string('__experimentalLetterSpacing'))
	} else {
		rt.new_bool(false)
	}
	var_has_line_height_support = if !(var_typography_supports.array_get(rt.new_string('lineHeight'))).is_null() {
		var_typography_supports.array_get(rt.new_string('lineHeight'))
	} else {
		rt.new_bool(false)
	}
	var_has_text_align_support = if !(var_typography_supports.array_get(rt.new_string('textAlign'))).is_null() {
		var_typography_supports.array_get(rt.new_string('textAlign'))
	} else {
		rt.new_bool(false)
	}
	var_has_text_columns_support = if !(var_typography_supports.array_get(rt.new_string('textColumns'))).is_null() {
		var_typography_supports.array_get(rt.new_string('textColumns'))
	} else {
		rt.new_bool(false)
	}
	var_has_text_decoration_support = if !(var_typography_supports.array_get(rt.new_string('__experimentalTextDecoration'))).is_null() {
		var_typography_supports.array_get(rt.new_string('__experimentalTextDecoration'))
	} else {
		rt.new_bool(false)
	}
	var_has_text_transform_support = if !(var_typography_supports.array_get(rt.new_string('__experimentalTextTransform'))).is_null() {
		var_typography_supports.array_get(rt.new_string('__experimentalTextTransform'))
	} else {
		rt.new_bool(false)
	}
	var_has_text_indent_support = if !(var_typography_supports.array_get(rt.new_string('textIndent'))).is_null() {
		var_typography_supports.array_get(rt.new_string('textIndent'))
	} else {
		rt.new_bool(false)
	}
	var_has_writing_mode_support = if !(var_typography_supports.array_get(rt.new_string('__experimentalWritingMode'))).is_null() {
		var_typography_supports.array_get(rt.new_string('__experimentalWritingMode'))
	} else {
		rt.new_bool(false)
	}
	var_should_skip_font_size = rt.call_function('wp_should_skip_block_supports_serialization', [
		var_block_type.clone(),
		rt.new_string('typography'),
		rt.new_string('fontSize'),
	])
	var_should_skip_font_family = rt.call_function('wp_should_skip_block_supports_serialization', [
		var_block_type.clone(),
		rt.new_string('typography'),
		rt.new_string('fontFamily'),
	])
	var_should_skip_font_style = rt.call_function('wp_should_skip_block_supports_serialization', [
		var_block_type.clone(),
		rt.new_string('typography'),
		rt.new_string('fontStyle'),
	])
	var_should_skip_font_weight = rt.call_function('wp_should_skip_block_supports_serialization', [
		var_block_type.clone(),
		rt.new_string('typography'),
		rt.new_string('fontWeight'),
	])
	var_should_skip_line_height = rt.call_function('wp_should_skip_block_supports_serialization', [
		var_block_type.clone(),
		rt.new_string('typography'),
		rt.new_string('lineHeight'),
	])
	var_should_skip_text_align = rt.call_function('wp_should_skip_block_supports_serialization', [
		var_block_type.clone(),
		rt.new_string('typography'),
		rt.new_string('textAlign'),
	])
	var_should_skip_text_columns = rt.call_function('wp_should_skip_block_supports_serialization', [
		var_block_type.clone(),
		rt.new_string('typography'),
		rt.new_string('textColumns'),
	])
	var_should_skip_text_decoration = rt.call_function('wp_should_skip_block_supports_serialization', [
		var_block_type.clone(),
		rt.new_string('typography'),
		rt.new_string('textDecoration'),
	])
	var_should_skip_text_transform = rt.call_function('wp_should_skip_block_supports_serialization', [
		var_block_type.clone(),
		rt.new_string('typography'),
		rt.new_string('textTransform'),
	])
	var_should_skip_letter_spacing = rt.call_function('wp_should_skip_block_supports_serialization', [
		var_block_type.clone(),
		rt.new_string('typography'),
		rt.new_string('letterSpacing'),
	])
	var_should_skip_text_indent = rt.call_function('wp_should_skip_block_supports_serialization', [
		var_block_type.clone(),
		rt.new_string('typography'),
		rt.new_string('textIndent'),
	])
	var_should_skip_writing_mode = rt.call_function('wp_should_skip_block_supports_serialization', [
		var_block_type.clone(),
		rt.new_string('typography'),
		rt.new_string('writingMode'),
	])
	var_typography_block_styles = rt.new_array()
	if rt.is_true(var_has_font_size_support)
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_should_skip_font_size)))) {
		var_preset_font_size = if rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_block_attributes).array_isset(rt.new_string('fontSize')))) {
			rt.concat(rt.new_string('var:preset|font-size|'),
				var_block_attributes.array_get(rt.new_string('fontSize')))
		} else {
			rt.new_null()
		}
		var_custom_font_size = if !(var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontSize'))).is_null() {
			var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontSize'))
		} else {
			rt.new_null()
		}
		var_typography_block_styles['fontSize'] = if rt.is_true(var_preset_font_size) { var_preset_font_size } else { wp_get_typography_font_size_value(rt.create_array([
				rt.ArrayItem{ key: 'size', val: var_custom_font_size },
			]), rt.new_null()) }
	}
	if rt.is_true(var_has_font_family_support)
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_should_skip_font_family)))) {
		var_preset_font_family = if rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_block_attributes).array_isset(rt.new_string('fontFamily')))) {
			rt.concat(rt.new_string('var:preset|font-family|'),
				var_block_attributes.array_get(rt.new_string('fontFamily')))
		} else {
			rt.new_null()
		}
		var_custom_font_family = if var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_isset(rt.new_string('fontFamily')) {
			wp_typography_get_preset_inline_style_value(var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontFamily')),
				'font-family')
		} else {
			rt.new_null()
		}
		var_typography_block_styles['fontFamily'] = if rt.is_true(var_preset_font_family) {
			var_preset_font_family
		} else {
			var_custom_font_family
		}
	}
	if rt.is_true(var_has_font_style_support)
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_should_skip_font_style))))
		&& var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_isset(rt.new_string('fontStyle')) {
		var_typography_block_styles['fontStyle'] = wp_typography_get_preset_inline_style_value(var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontStyle')),
			'font-style')
	}
	if rt.is_true(var_has_font_weight_support)
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_should_skip_font_weight))))
		&& var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_isset(rt.new_string('fontWeight')) {
		var_typography_block_styles['fontWeight'] = wp_typography_get_preset_inline_style_value(var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontWeight')),
			'font-weight')
	}
	if rt.is_true(var_has_line_height_support)
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_should_skip_line_height)))) {
		var_typography_block_styles['lineHeight'] = if !(var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('lineHeight'))).is_null() {
			var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('lineHeight'))
		} else {
			rt.new_null()
		}
	}
	if rt.is_true(var_has_text_align_support)
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_should_skip_text_align)))) {
		var_typography_block_styles['textAlign'] = if !(var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('textAlign'))).is_null() {
			var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('textAlign'))
		} else {
			rt.new_null()
		}
	}
	if rt.is_true(var_has_text_columns_support)
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_should_skip_text_columns))))
		&& var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_isset(rt.new_string('textColumns')) {
		var_typography_block_styles['textColumns'] = if !(var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('textColumns'))).is_null() {
			var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('textColumns'))
		} else {
			rt.new_null()
		}
	}
	if rt.is_true(var_has_text_decoration_support)
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_should_skip_text_decoration))))
		&& var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_isset(rt.new_string('textDecoration')) {
		var_typography_block_styles['textDecoration'] = wp_typography_get_preset_inline_style_value(var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('textDecoration')),
			'text-decoration')
	}
	if rt.is_true(var_has_text_transform_support)
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_should_skip_text_transform))))
		&& var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_isset(rt.new_string('textTransform')) {
		var_typography_block_styles['textTransform'] = wp_typography_get_preset_inline_style_value(var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('textTransform')),
			'text-transform')
	}
	if rt.is_true(var_has_letter_spacing_support)
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_should_skip_letter_spacing))))
		&& var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_isset(rt.new_string('letterSpacing')) {
		var_typography_block_styles['letterSpacing'] = wp_typography_get_preset_inline_style_value(var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('letterSpacing')),
			'letter-spacing')
	}
	if rt.is_true(var_has_writing_mode_support)
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_should_skip_writing_mode))))
		&& var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_isset(rt.new_string('writingMode')) {
		var_typography_block_styles['writingMode'] = if !(var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('writingMode'))).is_null() {
			var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('writingMode'))
		} else {
			rt.new_null()
		}
	}
	if rt.is_true(var_has_text_indent_support)
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_should_skip_text_indent))))
		&& var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_isset(rt.new_string('textIndent')) {
		var_typography_block_styles['textIndent'] = if !(var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('textIndent'))).is_null() {
			var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('textIndent'))
		} else {
			rt.new_null()
		}
	}
	var_attributes = rt.new_array()
	var_classnames = rt.new_array()
	var_styles = rt.call_function('wp_style_engine_get_styles', [
		rt.create_array([
			rt.ArrayItem{ key: 'typography', val: var_typography_block_styles },
		]),
		rt.create_array([
			rt.ArrayItem{ key: 'convert_vars_to_classnames', val: true },
		]),
	])
	if !(!rt.is_true(var_styles.array_get(rt.new_string('classnames')))) {
		var_classnames << var_styles.array_get(rt.new_string('classnames'))
	}
	if rt.is_true(var_has_text_align_support)
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_should_skip_text_align))))
		&& var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_isset(rt.new_string('textAlign')) {
		var_classnames << 'has-text-align-' +(var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('textAlign'))).str()
	}
	if !(!rt.is_true(var_classnames)) {
		var_attributes['class'] = rt.call_function('implode', [
			rt.new_string(' '), rt.create_array_from_list(var_classnames)])
	}
	if !(!rt.is_true(var_styles.array_get(rt.new_string('css')))) {
		var_attributes['style'] = var_styles.array_get(rt.new_string('css'))
	}
	return var_attributes.clone()
}

fn wp_typography_get_preset_inline_style_value(var_style_value rt.PhpVal, css_property string) rt.PhpVal {
	mut var_css_property := css_property
	mut var_index_to_splice := rt.new_null()
	mut var_slug := rt.new_null()
	if !rt.is_true(var_style_value)
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_style_value.clone(), rt.new_string('var:preset|${var_css_property}|')]))))) {
		return var_style_value.clone()
	}
	var_index_to_splice = rt.add(rt.call_function('strrpos', [
		var_style_value.clone(), rt.new_string('|')]), rt.new_int(1))
	var_slug = rt.call_function('_wp_to_kebab_case', [
		rt.call_function('substr', [var_style_value.clone(), var_index_to_splice.clone()]),
	])
	return rt.call_function('sprintf', [rt.new_string('var(--wp--preset--%s--%s);'),
		rt.new_string(css_property), var_slug.clone()])
}

fn wp_render_typography_support(var_block_content_arg rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_block_content := var_block_content_arg
	mut var_processor := rt.new_null()
	mut var_custom_font_size := rt.new_null()
	mut var_fluid_font_size := rt.new_null()
	if !(!rt.is_true(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('fitText'))))
		&& rt.is_true(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('fitText')))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		rt.call_function('wp_enqueue_script_module', [
			rt.new_string('@wordpress/block-editor/utils/fit-text-frontend'),
		])
		if !(!rt.is_true(var_block_content)) {
			var_processor = create_wp_html_tag_processor(var_block_content.clone())
			if rt.is_true(var_processor.next_tag()) {
				if rt.is_true(rt.new_bool(!(rt.is_true(var_processor.get_attribute(rt.new_string('data-wp-interactive')))))) {
					var_processor.set_attribute(rt.new_string('data-wp-interactive'),
						rt.new_bool(true))
				}
				var_processor.set_attribute(rt.new_string('data-wp-context---core-fit-text'),
					rt.new_string('core/fit-text::{"fontSize":""}'))
				var_processor.set_attribute(rt.new_string('data-wp-init---core-fit-text'),
					rt.new_string('core/fit-text::callbacks.init'))
				var_processor.set_attribute(rt.new_string('data-wp-style--font-size'),
					rt.new_string('core/fit-text::context.fontSize'))
				var_block_content = var_processor.get_updated_html()
			}
		}
		return var_block_content.clone()
	}
	if !(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_isset(rt.new_string('fontSize'))) {
		return var_block_content.clone()
	}
	var_custom_font_size =
		var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontSize'))
	var_fluid_font_size = wp_get_typography_font_size_value(rt.create_array([
		rt.ArrayItem{ key: 'size', val: var_custom_font_size },
	]), rt.new_null())
	if !(!rt.is_true(var_fluid_font_size))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_fluid_font_size, var_custom_font_size)))) {
		return rt.call_function('preg_replace', [
			rt.new_string('/font-size\\s*:\\s*' +
				(rt.call_function('preg_quote', [var_custom_font_size.clone(), rt.new_string('/')])).str() +
				'\\s*;?/'),
			rt.new_string('font-size:' +
				(rt.call_function('esc_attr', [var_fluid_font_size.clone()])).str() + ';'),
			var_block_content.clone(),
			rt.new_int(1),
		])
	}
	return var_block_content.clone()
}

fn wp_get_typography_value_and_unit(var_raw_value_arg rt.PhpVal, var_options_arg rt.PhpVal) rt.PhpVal {
	mut var_raw_value := var_raw_value_arg
	mut var_options := var_options_arg
	mut var_matches := []rt.PhpVal{}
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_acceptable_units_group := rt.new_null()
	mut var_pattern := rt.new_null()
	mut var_value := rt.new_null()
	mut var_unit := rt.new_null()
	if !(var_raw_value.clone().is_string()) && !(var_raw_value.clone().is_long())
		&& !(var_raw_value.clone().is_double()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Raw size value must be a string, integer, or float.'),
			]),
			rt.new_string('6.1.0')])
		return rt.new_null()
	}
	if !rt.is_true(var_raw_value) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(var_raw_value.clone().is_long() || var_raw_value.clone().is_double())) {
		var_raw_value = rt.new_string(var_raw_value.str() + 'px')
	}
	var_defaults = {
		'coerce_to':        rt.new_string('')
		'root_size_value':  rt.new_int(16)
		'acceptable_units': map[string]rt.PhpVal{}
	}
	var_options = rt.call_function('wp_parse_args', [var_options.clone(),
		rt.create_array_from_native_map(var_defaults)])
	var_acceptable_units_group = rt.call_function('implode', [
		rt.new_string('|'), var_options.array_get(rt.new_string('acceptable_units'))])
	var_pattern = rt.new_string('/^(\\d*\\.?\\d+)(' + var_acceptable_units_group.str() + '){1,1}$/')
	rt.call_function('preg_match', [var_pattern.clone(), var_raw_value.clone(),
		rt.create_array_from_list(var_matches)])
	if !(var_matches.array_isset(rt.new_int(1))) || !(var_matches.array_isset(rt.new_int(2))) {
		return rt.new_null()
	}
	var_value = var_matches[1]
	var_unit = var_matches[2]
	if rt.is_true(rt.identical(rt.new_string('px'), var_options.array_get(rt.new_string('coerce_to'))))
		&& rt.is_true(rt.identical(rt.new_string('em'), var_unit))
		|| rt.is_true(rt.identical(rt.new_string('rem'), var_unit)) {
		var_value = rt.mul(var_value, var_options.array_get(rt.new_string('root_size_value')))
		var_unit = var_options.array_get(rt.new_string('coerce_to'))
	}
	if rt.is_true(rt.identical(rt.new_string('px'), var_unit))
		&& rt.is_true(rt.identical(rt.new_string('em'), var_options.array_get(rt.new_string('coerce_to'))))
		|| rt.is_true(rt.identical(rt.new_string('rem'), var_options.array_get(rt.new_string('coerce_to')))) {
		var_value = rt.div(var_value, var_options.array_get(rt.new_string('root_size_value')))
		var_unit = var_options.array_get(rt.new_string('coerce_to'))
	}
	if rt.is_true(rt.identical(rt.new_string('em'), var_options.array_get(rt.new_string('coerce_to'))))
		|| rt.is_true(rt.identical(rt.new_string('rem'), var_options.array_get(rt.new_string('coerce_to'))))
		&& rt.is_true(rt.identical(rt.new_string('em'), var_unit))
		|| rt.is_true(rt.identical(rt.new_string('rem'), var_unit)) {
		var_unit = var_options.array_get(rt.new_string('coerce_to'))
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'value', val: rt.call_function('round', [
			var_value.clone(), rt.new_int(3)]) },
		rt.ArrayItem{ key: 'unit', val: var_unit },
	])
}

fn wp_get_computed_fluid_typography_value(var_args rt.PhpVal) rt.PhpVal {
	mut var_maximum_viewport_width_raw := rt.new_null()
	mut var_minimum_viewport_width_raw := rt.new_null()
	mut var_maximum_font_size_raw := rt.new_null()
	mut var_minimum_font_size_raw := rt.new_null()
	mut var_scale_factor := rt.new_null()
	mut var_minimum_font_size := rt.new_null()
	mut var_font_size_unit := rt.new_null()
	mut var_maximum_font_size := rt.new_null()
	mut var_minimum_font_size_rem := rt.new_null()
	mut var_maximum_viewport_width := rt.new_null()
	mut var_minimum_viewport_width := rt.new_null()
	mut var_linear_factor_denominator := rt.new_null()
	mut var_view_port_width_offset := rt.new_null()
	mut var_linear_factor := rt.new_null()
	mut var_linear_factor_scaled := rt.new_null()
	mut var_fluid_target_font_size := rt.new_null()
	var_maximum_viewport_width_raw = if !(var_args.array_get(rt.new_string('maximum_viewport_width'))).is_null() {
		var_args.array_get(rt.new_string('maximum_viewport_width'))
	} else {
		rt.new_null()
	}
	var_minimum_viewport_width_raw = if !(var_args.array_get(rt.new_string('minimum_viewport_width'))).is_null() {
		var_args.array_get(rt.new_string('minimum_viewport_width'))
	} else {
		rt.new_null()
	}
	var_maximum_font_size_raw = if !(var_args.array_get(rt.new_string('maximum_font_size'))).is_null() {
		var_args.array_get(rt.new_string('maximum_font_size'))
	} else {
		rt.new_null()
	}
	var_minimum_font_size_raw = if !(var_args.array_get(rt.new_string('minimum_font_size'))).is_null() {
		var_args.array_get(rt.new_string('minimum_font_size'))
	} else {
		rt.new_null()
	}
	var_scale_factor = if !(var_args.array_get(rt.new_string('scale_factor'))).is_null() {
		var_args.array_get(rt.new_string('scale_factor'))
	} else {
		rt.new_null()
	}
	var_minimum_font_size = wp_get_typography_value_and_unit(var_minimum_font_size_raw.clone(),
		rt.new_null())
	var_font_size_unit = if !(var_minimum_font_size.array_get(rt.new_string('unit'))).is_null() {
		var_minimum_font_size.array_get(rt.new_string('unit'))
	} else {
		rt.new_string('rem')
	}
	var_maximum_font_size = wp_get_typography_value_and_unit(var_maximum_font_size_raw.clone(), rt.create_array([
		rt.ArrayItem{ key: 'coerce_to', val: var_font_size_unit },
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_maximum_font_size))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_minimum_font_size)))) {
		return rt.new_null()
	}
	var_minimum_font_size_rem = wp_get_typography_value_and_unit(var_minimum_font_size_raw.clone(), rt.create_array([
		rt.ArrayItem{ key: 'coerce_to', val: 'rem' },
	]))
	var_maximum_viewport_width = wp_get_typography_value_and_unit(var_maximum_viewport_width_raw.clone(), rt.create_array([
		rt.ArrayItem{ key: 'coerce_to', val: var_font_size_unit },
	]))
	var_minimum_viewport_width = wp_get_typography_value_and_unit(var_minimum_viewport_width_raw.clone(), rt.create_array([
		rt.ArrayItem{ key: 'coerce_to', val: var_font_size_unit },
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_minimum_viewport_width))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_maximum_viewport_width)))) {
		return rt.new_null()
	}
	var_linear_factor_denominator = rt.sub(var_maximum_viewport_width.array_get(rt.new_string('value')),
		var_minimum_viewport_width.array_get(rt.new_string('value')))
	if !rt.is_true(var_linear_factor_denominator) {
		return rt.new_null()
	}
	var_view_port_width_offset = rt.new_string(
		(rt.call_function('round', [rt.div(var_minimum_viewport_width.array_get(rt.new_string('value')), rt.new_int(100)), rt.new_int(3)])).str() +
		var_font_size_unit.str())
	var_linear_factor = rt.mul(rt.new_int(100), rt.div(rt.sub(var_maximum_font_size.array_get(rt.new_string('value')),
		var_minimum_font_size.array_get(rt.new_string('value'))), var_linear_factor_denominator))
	var_linear_factor_scaled = rt.call_function('round', [
		rt.mul(var_linear_factor, var_scale_factor),
		rt.new_int(3),
	])
	var_linear_factor_scaled = if !rt.is_true(var_linear_factor_scaled) {
		rt.new_int(1)
	} else {
		var_linear_factor_scaled
	}
	var_fluid_target_font_size = rt.new_string(
		(rt.call_function('implode', [rt.new_string(''), var_minimum_font_size_rem.clone()])).str() +
		' +
		((1vw - ${var_view_port_width_offset.to_string()}) * ${var_linear_factor_scaled.to_string()})')
	return rt.new_string('clamp(${var_minimum_font_size_raw.to_string()}, ${var_fluid_target_font_size.to_string()}, ${var_maximum_font_size_raw.to_string()})')
}

fn wp_get_typography_font_size_value(var_preset rt.PhpVal, var_settings_arg rt.PhpVal) rt.PhpVal {
	mut var_settings := var_settings_arg
	mut var_fluid_font_size_settings := rt.new_null()
	mut var_global_settings := rt.new_null()
	mut var_typography_settings := rt.new_null()
	mut var_fluid_settings := rt.new_null()
	mut var_layout_settings := rt.new_null()
	mut var_default_maximum_viewport_width := ''
	mut var_default_minimum_viewport_width := ''
	mut var_default_minimum_font_size_factor_max := f64(0.0)
	mut var_default_minimum_font_size_factor_min := f64(0.0)
	mut var_default_scale_factor := i64(0)
	mut var_default_minimum_font_size_limit := ''
	mut var_minimum_viewport_width := rt.new_null()
	mut var_maximum_viewport_width := rt.new_null()
	mut var_has_min_font_size := false
	mut var_minimum_font_size_limit := rt.new_null()
	mut var_minimum_font_size_raw := rt.new_null()
	mut var_maximum_font_size_raw := rt.new_null()
	mut var_preferred_size := rt.new_null()
	mut var_preferred_font_size_in_px := rt.new_null()
	mut var_minimum_font_size_factor := rt.new_null()
	mut var_calculated_minimum_font_size := rt.new_null()
	mut var_fluid_font_size_value := rt.new_null()
	if !(var_preset.array_isset(rt.new_string('size'))) {
		return rt.new_null()
	}
	var_fluid_font_size_settings = if !(var_preset.array_get(rt.new_string('fluid'))).is_null() {
		var_preset.array_get(rt.new_string('fluid'))
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_fluid_font_size_settings))
		|| !rt.is_true(var_preset.array_get(rt.new_string('size'))) {
		return var_preset.array_get(rt.new_string('size'))
	}
	if rt.is_true(rt.new_bool(var_settings.clone().is_bool())) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('6.6.0'),
			rt.call_function('__', [
				rt.new_string('`boolean` type for second argument `$settings` is deprecated. Use `array()` instead.'),
			])])
		var_settings = rt.create_array([
			rt.ArrayItem{ key: 'typography', val: rt.create_array([
				rt.ArrayItem{ key: 'fluid', val: var_settings },
			]) },
		])
	}
	var_global_settings = rt.call_function('wp_get_global_settings', []rt.PhpVal{})
	var_settings = rt.call_function('wp_parse_args', [var_settings.clone(),
		var_global_settings.clone()])
	var_typography_settings = if !(var_settings.array_get(rt.new_string('typography'))).is_null() {
		var_settings.array_get(rt.new_string('typography'))
	} else {
		rt.new_array()
	}
	if !rt.is_true(var_typography_settings.array_get(rt.new_string('fluid')))
		&& !rt.is_true(var_fluid_font_size_settings) {
		return var_preset.array_get(rt.new_string('size'))
	}
	var_fluid_settings = if !(var_typography_settings.array_get(rt.new_string('fluid'))).is_null() {
		var_typography_settings.array_get(rt.new_string('fluid'))
	} else {
		rt.new_array()
	}
	var_layout_settings = if !(var_settings.array_get(rt.new_string('layout'))).is_null() {
		var_settings.array_get(rt.new_string('layout'))
	} else {
		rt.new_array()
	}
	var_default_maximum_viewport_width = '1600px'
	var_default_minimum_viewport_width = '320px'
	var_default_minimum_font_size_factor_max = 0.75
	var_default_minimum_font_size_factor_min = 0.25
	var_default_scale_factor = 1
	var_default_minimum_font_size_limit = '14px'
	var_minimum_viewport_width = if !(var_fluid_settings.array_get(rt.new_string('minViewportWidth'))).is_null() {
		var_fluid_settings.array_get(rt.new_string('minViewportWidth'))
	} else {
		rt.new_string(var_default_minimum_viewport_width.str())
	}
	var_maximum_viewport_width = if var_layout_settings.array_isset(rt.new_string('wideSize'))
		&& !(!rt.is_true(wp_get_typography_value_and_unit(var_layout_settings.array_get(rt.new_string('wideSize')), rt.new_null()))) {
		var_layout_settings.array_get(rt.new_string('wideSize'))
	} else {
		rt.new_string(var_default_maximum_viewport_width.str())
	}
	if var_fluid_settings.array_isset(rt.new_string('maxViewportWidth')) {
		var_maximum_viewport_width = var_fluid_settings.array_get(rt.new_string('maxViewportWidth'))
	}
	var_has_min_font_size = var_fluid_settings.array_isset(rt.new_string('minFontSize'))
		&& !(!rt.is_true(wp_get_typography_value_and_unit(var_fluid_settings.array_get(rt.new_string('minFontSize')), rt.new_null())))
	var_minimum_font_size_limit = if var_has_min_font_size {
		var_fluid_settings.array_get(rt.new_string('minFontSize'))
	} else {
		rt.new_string(var_default_minimum_font_size_limit.str())
	}
	var_minimum_font_size_raw = if !(var_fluid_font_size_settings.array_get(rt.new_string('min'))).is_null() {
		var_fluid_font_size_settings.array_get(rt.new_string('min'))
	} else {
		rt.new_null()
	}
	var_maximum_font_size_raw = if !(var_fluid_font_size_settings.array_get(rt.new_string('max'))).is_null() {
		var_fluid_font_size_settings.array_get(rt.new_string('max'))
	} else {
		rt.new_null()
	}
	var_preferred_size = wp_get_typography_value_and_unit(var_preset.array_get(rt.new_string('size')),
		rt.new_null())
	if !rt.is_true(var_preferred_size.array_get(rt.new_string('unit'))) {
		return var_preset.array_get(rt.new_string('size'))
	}
	var_minimum_font_size_limit = wp_get_typography_value_and_unit(var_minimum_font_size_limit.clone(), rt.create_array([
		rt.ArrayItem{ key: 'coerce_to', val: var_preferred_size.array_get(rt.new_string('unit')) },
	]))
	if !(!rt.is_true(var_minimum_font_size_limit))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_minimum_font_size_raw))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_maximum_font_size_raw)))) {
		if rt.is_true(rt.less_equal(var_preferred_size.array_get(rt.new_string('value')),
			var_minimum_font_size_limit.array_get(rt.new_string('value'))))
		{
			return var_preset.array_get(rt.new_string('size'))
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_maximum_font_size_raw)))) {
		var_maximum_font_size_raw = rt.new_string(
			(var_preferred_size.array_get(rt.new_string('value'))).str() +
			(var_preferred_size.array_get(rt.new_string('unit'))).str())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_minimum_font_size_raw)))) {
		var_preferred_font_size_in_px = if rt.is_true(rt.identical(rt.new_string('px'),
			var_preferred_size.array_get(rt.new_string('unit'))))
		{
			var_preferred_size.array_get(rt.new_string('value'))
		} else {
			rt.mul(var_preferred_size.array_get(rt.new_string('value')), rt.new_int(16))
		}
		var_minimum_font_size_factor = rt.call_function('min', [
			rt.call_function('max', [
				rt.new_float(1 - 0.075 * rt.call_function('log', [
					var_preferred_font_size_in_px.clone(), rt.new_int(2)])),
				rt.new_float(var_default_minimum_font_size_factor_min).clone(),
			]),
			rt.new_float(var_default_minimum_font_size_factor_max).clone(),
		])
		var_calculated_minimum_font_size = rt.call_function('round', [
			rt.mul(var_preferred_size.array_get(rt.new_string('value')),
				var_minimum_font_size_factor),
			rt.new_int(3),
		])
		if !(!rt.is_true(var_minimum_font_size_limit))
			&& rt.is_true(rt.less_equal(var_calculated_minimum_font_size, var_minimum_font_size_limit.array_get(rt.new_string('value')))) {
			var_minimum_font_size_raw = rt.new_string(
				(var_minimum_font_size_limit.array_get(rt.new_string('value'))).str() +
				(var_minimum_font_size_limit.array_get(rt.new_string('unit'))).str())
		} else {
			var_minimum_font_size_raw = rt.new_string(var_calculated_minimum_font_size.str() +
				(var_preferred_size.array_get(rt.new_string('unit'))).str())
		}
	}
	var_fluid_font_size_value = wp_get_computed_fluid_typography_value(rt.create_array([
		rt.ArrayItem{ key: 'minimum_viewport_width', val: var_minimum_viewport_width },
		rt.ArrayItem{ key: 'maximum_viewport_width', val: var_maximum_viewport_width },
		rt.ArrayItem{ key: 'minimum_font_size', val: var_minimum_font_size_raw },
		rt.ArrayItem{ key: 'maximum_font_size', val: var_maximum_font_size_raw },
		rt.ArrayItem{ key: 'scale_factor', val: var_default_scale_factor },
	]))
	if !(!rt.is_true(var_fluid_font_size_value)) {
		return var_fluid_font_size_value.clone()
	}
	return var_preset.array_get(rt.new_string('size'))
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_WP_Block_Supports {
	rt.PhpObjectBase
}

fn create_wp_html_tag_processor(_args ...rt.PhpVal) &Class_WP_HTML_Tag_Processor {
	mut obj := &Class_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_supports(_args ...rt.PhpVal) &Class_WP_Block_Supports {
	mut obj := &Class_WP_Block_Supports{
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

fn (mut this Class_WP_Block_Supports) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Supports) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Supports) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut iife_temp_0 := Class_WP_Block_Supports{}
	mut iife_result_0 := iife_temp_0.get_instance()
	rt.call_method(iife_result_0, 'register', [rt.new_string('typography'),
		rt.create_array([
			rt.ArrayItem{ key: 'register_attribute', val: 'wp_register_typography_support' },
			rt.ArrayItem{ key: 'apply', val: 'wp_apply_typography_support' },
		])])
}
