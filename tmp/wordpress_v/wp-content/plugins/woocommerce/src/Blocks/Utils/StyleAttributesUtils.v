import rt

pub fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'class', val: '' }, rt.ArrayItem{ key: 'style', val: '' }, rt.ArrayItem{ key: 'value', val: '' }])
}
struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_color_value(var_color_value rt.PhpVal) rt.PhpVal {
	mut var_color_value_mutated := var_color_value
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_color_value_mutated.dup().is_string())) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_color_value_mutated = rt.call_function('str_replace', [rt.new_string('var:preset|color|'), rt.new_string(''), var_color_value_mutated.dup()])
		return rt.call_function('sprintf', [rt.new_string('var(--wp--preset--color--%s)'), var_color_value_mutated.dup()])
	}
	return var_color_value_mutated.dup()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_preset_value(var_preset_name rt.PhpVal) string {
	return "var(--wp--preset--color--${var_preset_name.to_string()})"
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_shadow_value(var_shadow_name rt.PhpVal) string {
	mut var_shadow_name_mutated := var_shadow_name
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_shadow_name_mutated.dup().is_string())) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_shadow_name_mutated = rt.call_function('str_replace', [rt.new_string('var:preset|shadow|'), rt.new_string(''), var_shadow_name_mutated.dup()])
		return "var(--wp--preset--shadow--${var_shadow_name.to_string()})"
	}
	return (var_shadow_name_mutated).str()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_spacing_value(var_spacing_value rt.PhpVal) rt.PhpVal {
	mut var_spacing_value_mutated := var_spacing_value
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_spacing_value_mutated.dup().is_string())) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_spacing_value_mutated = rt.call_function('str_replace', [rt.new_string('var:preset|spacing|'), rt.new_string(''), var_spacing_value_mutated.dup()])
		return rt.call_function('sprintf', [rt.new_string('var(--wp--preset--spacing--%s)'), var_spacing_value_mutated.dup()])
	}
	return var_spacing_value_mutated.dup()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_align_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_align_attribute := if !(var_attributes.array_get('align')).is_null() { var_attributes.array_get('align') } else { rt.new_null() }
	if rt.is_true(rt.identical(rt.new_string('wide'), var_align_attribute)) {
		return rt.create_array([rt.ArrayItem{ key: 'class', val: 'alignwide' }, rt.ArrayItem{ key: 'style', val: rt.new_null() }])
	}
	if rt.is_true(rt.identical(rt.new_string('full'), var_align_attribute)) {
		return rt.create_array([rt.ArrayItem{ key: 'class', val: 'alignfull' }, rt.ArrayItem{ key: 'style', val: rt.new_null() }])
	}
	if rt.is_true(rt.identical(rt.new_string('left'), var_align_attribute)) {
		return rt.create_array([rt.ArrayItem{ key: 'class', val: 'alignleft' }, rt.ArrayItem{ key: 'style', val: rt.new_null() }])
	}
	if rt.is_true(rt.identical(rt.new_string('right'), var_align_attribute)) {
		return rt.create_array([rt.ArrayItem{ key: 'class', val: 'alignright' }, rt.ArrayItem{ key: 'style', val: rt.new_null() }])
	}
	if rt.is_true(rt.identical(rt.new_string('center'), var_align_attribute)) {
		return rt.create_array([rt.ArrayItem{ key: 'class', val: 'aligncenter' }, rt.ArrayItem{ key: 'style', val: rt.new_null() }])
	}
	return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_background_color_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_gradient := if !(var_attributes.array_get('gradient')).is_null() { var_attributes.array_get('gradient') } else { rt.new_null() }
	mut var_background_color := if !(var_attributes.array_get('backgroundColor')).is_null() { var_attributes.array_get('backgroundColor') } else { rt.new_string('') }
	mut var_custom_background_color := if !(var_attributes.array_get('style').array_get('color').array_get('background')).is_null() { var_attributes.array_get('style').array_get('color').array_get('background') } else { rt.new_string('') }
	mut var_classes := rt.create_array([rt.ArrayItem{ key: none, val: var_gradient }])
	mut var_styles := rt.new_array()
	mut var_value := rt.new_null()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_background_color) || rt.is_true(var_custom_background_color))) || rt.is_true(var_gradient))) {
		var_classes.array_push('has-background')
	}
	if rt.is_true(var_background_color) {
		var_classes.array_push(rt.call_function('sprintf', [rt.new_string('has-%s-background-color'), var_background_color.dup()]))
		var_value = Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_preset_value(var_background_color.dup())
	}
	if rt.is_true(var_custom_background_color) {
		var_styles.array_push(rt.call_function('sprintf', [rt.new_string('background-color: %s;'), var_custom_background_color.dup()]))
		var_value = var_custom_background_color.dup()
	}
	if rt.is_true(var_gradient) {
		var_classes.array_push(rt.call_function('sprintf', [rt.new_string('has-%s-gradient-background'), var_gradient.dup()]))
	}
	return rt.create_array([rt.ArrayItem{ key: 'class', val: Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.join_styles(var_classes.dup()) }, rt.ArrayItem{ key: 'style', val: Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.join_styles(var_styles.dup()) }, rt.ArrayItem{ key: 'value', val: var_value }])
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.join_styles(var_rules rt.PhpVal) rt.PhpVal {
	return rt.call_function('implode', [rt.new_string(' '), rt.call_function('array_unique', [rt.call_function('array_filter', [var_rules.dup()])])])
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_border_color_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_border_color_linked_preset := if !(var_attributes.array_get('borderColor')).is_null() { var_attributes.array_get('borderColor') } else { rt.new_string('') }
	mut var_border_color_linked_custom := if !(var_attributes.array_get('style').array_get('border').array_get('color')).is_null() { var_attributes.array_get('style').array_get('border').array_get('color') } else { rt.new_string('') }
	mut var_custom_border := if !(var_attributes.array_get('style').array_get('border')).is_null() { var_attributes.array_get('style').array_get('border') } else { rt.new_string('') }
	mut var_class := rt.new_string(rt.new_string(''))
	mut var_style := rt.new_string(rt.new_string(''))
	mut var_value := rt.new_string(rt.new_string(''))
	if rt.is_true(var_border_color_linked_preset) {
		var_class = rt.call_function('sprintf', [rt.new_string('has-border-color has-%s-border-color'), var_border_color_linked_preset.dup()])
		var_value = Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_preset_value(var_border_color_linked_preset.dup())
		var_style = rt.new_string('border-color:' + (var_value).str() + ';')
	} else if rt.is_true(var_border_color_linked_custom) {
		// unsupported expression: Expr_AssignOp_Concat
		var_value = var_border_color_linked_custom.dup()
	} else if rt.is_true(rt.new_bool(var_custom_border.dup().is_array())) {
		{
			mut iter_1 := var_custom_border.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_border_color_value := item_1.val
				mut var_border_color_key := item_1.key
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_border_color_value.dup().is_array())) && rt.is_true(rt.new_bool(var_border_color_value.dup().array_isset(rt.new_string('color')))))) {
					// unsupported expression: Expr_AssignOp_Concat
				}
			}
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_class)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_style)))))) {
		return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
	}
	return rt.create_array([rt.ArrayItem{ key: 'class', val: var_class }, rt.ArrayItem{ key: 'style', val: var_style }, rt.ArrayItem{ key: 'value', val: var_value }])
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_border_radius_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_custom_border_radius := if !(var_attributes.array_get('style').array_get('border').array_get('radius')).is_null() { var_attributes.array_get('style').array_get('border').array_get('radius') } else { rt.new_string('') }
	if rt.is_true(rt.identical(rt.new_string(''), var_custom_border_radius)) {
		return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
	}
	mut var_style := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(var_custom_border_radius.dup().is_string())) {
		var_style = rt.new_string('border-radius:' + (var_custom_border_radius).str() + ';')
	} else {
		mut var_border_radius := rt.new_array()
		var_border_radius.array_set('border-top-left-radius', if !(var_custom_border_radius.array_get('topLeft')).is_null() { var_custom_border_radius.array_get('topLeft') } else { rt.new_string('') })
		var_border_radius.array_set('border-top-right-radius', if !(var_custom_border_radius.array_get('topRight')).is_null() { var_custom_border_radius.array_get('topRight') } else { rt.new_string('') })
		var_border_radius.array_set('border-bottom-right-radius', if !(var_custom_border_radius.array_get('bottomRight')).is_null() { var_custom_border_radius.array_get('bottomRight') } else { rt.new_string('') })
		var_border_radius.array_set('border-bottom-left-radius', if !(var_custom_border_radius.array_get('bottomLeft')).is_null() { var_custom_border_radius.array_get('bottomLeft') } else { rt.new_string('') })
		{
			mut iter_1 := var_border_radius.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_border_radius_value := item_1.val
				mut var_border_radius_side := item_1.key
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					// unsupported expression: Expr_AssignOp_Concat
				}
			}
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'class', val: rt.new_null() }, rt.ArrayItem{ key: 'style', val: var_style }])
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_border_width_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_custom_border := if !(var_attributes.array_get('style').array_get('border')).is_null() { var_attributes.array_get('style').array_get('border') } else { rt.new_string('') }
	if rt.is_true(rt.identical(rt.new_string(''), var_custom_border)) {
		return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
	}
	mut var_style := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_custom_border.dup().array_isset(rt.new_string('width')))) && !(!rt.is_true(var_custom_border.array_get('width'))))) {
		var_style = rt.new_string('border-width:' + (var_custom_border.array_get('width')).str() + ';')
	} else {
		{
			mut iter_1 := var_custom_border.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_border_width_value := item_1.val
				mut var_border_width_side := item_1.key
				if var_border_width_value.array_isset(rt.new_string('width')) {
					// unsupported expression: Expr_AssignOp_Concat
				}
			}
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'class', val: rt.new_null() }, rt.ArrayItem{ key: 'style', val: var_style }])
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_border_style_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_custom_border := if !(var_attributes.array_get('style').array_get('border')).is_null() { var_attributes.array_get('style').array_get('border') } else { rt.new_string('') }
	if rt.is_true(rt.identical(rt.new_string(''), var_custom_border)) {
		return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
	}
	mut var_style := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_custom_border.dup().array_isset(rt.new_string('style')))) && !(!rt.is_true(var_custom_border.array_get('style'))))) {
		var_style = rt.new_string('border-style:' + (var_custom_border.array_get('style')).str() + ';')
	} else {
		{
			mut iter_1 := var_custom_border.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_side := item_1.key
				if var_value.array_isset(rt.new_string('style')) {
					// unsupported expression: Expr_AssignOp_Concat
				}
			}
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'class', val: rt.new_null() }, rt.ArrayItem{ key: 'style', val: var_style }])
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_classes_by_attributes(var_attributes rt.PhpVal, var_properties rt.PhpVal) rt.PhpVal {
	mut var_classes_and_styles := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_classes_and_styles_by_attributes(var_attributes.dup(), var_properties.dup())
	return var_classes_and_styles.array_get('classes')
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_font_family_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_font_family := if !(var_attributes.array_get('fontFamily')).is_null() { var_attributes.array_get('fontFamily') } else { rt.new_string('') }
	if rt.is_true(var_font_family) {
		return rt.create_array([rt.ArrayItem{ key: 'class', val: rt.call_function('sprintf', [rt.new_string('has-%s-font-family'), var_font_family.dup()]) }, rt.ArrayItem{ key: 'style', val: rt.new_null() }])
	}
	return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_font_size_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_font_size := if !(var_attributes.array_get('fontSize')).is_null() { var_attributes.array_get('fontSize') } else { rt.new_string('') }
	mut var_custom_font_size := if !(var_attributes.array_get('style').array_get('typography').array_get('fontSize')).is_null() { var_attributes.array_get('style').array_get('typography').array_get('fontSize') } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_font_size)))) && rt.is_true(rt.identical(rt.new_string(''), var_custom_font_size)))) {
		return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
	}
	if rt.is_true(var_font_size) {
		return rt.create_array([rt.ArrayItem{ key: 'class', val: rt.call_function('sprintf', [rt.new_string('has-font-size has-%s-font-size'), var_font_size.dup()]) }, rt.ArrayItem{ key: 'style', val: rt.new_null() }])
	} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.create_array([rt.ArrayItem{ key: 'class', val: rt.new_null() }, rt.ArrayItem{ key: 'style', val: rt.call_function('sprintf', [rt.new_string('font-size: %s;'), var_custom_font_size.dup()]) }])
	}
	return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_font_style_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_custom_font_style := if !(var_attributes.array_get('style').array_get('typography').array_get('fontStyle')).is_null() { var_attributes.array_get('style').array_get('typography').array_get('fontStyle') } else { rt.new_string('') }
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.create_array([rt.ArrayItem{ key: 'class', val: rt.new_null() }, rt.ArrayItem{ key: 'style', val: rt.call_function('sprintf', [rt.new_string('font-style: %s;'), var_custom_font_style.dup()]) }])
	}
	return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_font_weight_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_custom_font_weight := if !(var_attributes.array_get('style').array_get('typography').array_get('fontWeight')).is_null() { var_attributes.array_get('style').array_get('typography').array_get('fontWeight') } else { rt.new_string('') }
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.create_array([rt.ArrayItem{ key: 'class', val: rt.new_null() }, rt.ArrayItem{ key: 'style', val: rt.call_function('sprintf', [rt.new_string('font-weight: %s;'), var_custom_font_weight.dup()]) }])
	}
	return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_letter_spacing_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_custom_letter_spacing := if !(var_attributes.array_get('style').array_get('typography').array_get('letterSpacing')).is_null() { var_attributes.array_get('style').array_get('typography').array_get('letterSpacing') } else { rt.new_string('') }
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.create_array([rt.ArrayItem{ key: 'class', val: rt.new_null() }, rt.ArrayItem{ key: 'style', val: rt.call_function('sprintf', [rt.new_string('letter-spacing: %s;'), var_custom_letter_spacing.dup()]) }])
	}
	return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_line_height_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_line_height := if !(.array_get().array_get('typography').array_get('lineHeight')).is_null() { .array_get().array_get('typography').array_get('lineHeight') } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_line_height)))) {
		return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
	}
	return rt.create_array([rt.ArrayItem{ key: 'class', val: rt.new_null() }, rt.ArrayItem{ key: 'style', val: rt.call_function('sprintf', [rt.new_string('line-height: %s;'), var_line_height.dup()]) }])
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.array_get_value_by_path(mut var_array Class_Automattic_WooCommerce_Blocks_Utils_array, var_path rt.PhpVal, delimiter string) rt.PhpVal {
	mut var_ref := rt.new_null()
	mut var_array_path := rt.call_function('explode', [, .dup()])
	// unsupported expression: Expr_AssignRef
	{
		mut iter_1 := .iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
		}
	}
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_link_color_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_link_hover_color_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_margin_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_padding_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_shadow_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_styles_by_attributes(var_attributes rt.PhpVal, var_properties rt.PhpVal) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_text_align_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_text_color_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_text_decoration_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_text_transform_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_classes_from_attributes(var_attributes rt.PhpVal) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_classes_and_styles_by_attributes(var_attributes rt.PhpVal, var_properties rt.PhpVal, var_exclude rt.PhpVal) rt.PhpVal {
}

fn create_automattic_woocommerce_blocks_utils_styleattributesutils() &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_color_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_color_value(dispatch_arg_0)
		}
		'get_preset_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_preset_value(dispatch_arg_0))
		}
		'get_shadow_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_shadow_value(dispatch_arg_0))
		}
		'get_spacing_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_spacing_value(dispatch_arg_0)
		}
		'get_align_class_and_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_align_class_and_style(dispatch_arg_0)
		}
		'get_background_color_class_and_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_background_color_class_and_style(dispatch_arg_0)
		}
		'join_styles' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.join_styles(dispatch_arg_0)
		}
		'get_border_color_class_and_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_border_color_class_and_style(dispatch_arg_0)
		}
		'get_border_radius_class_and_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_border_radius_class_and_style(dispatch_arg_0)
		}
		'get_border_width_class_and_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_border_width_class_and_style(dispatch_arg_0)
		}
		'get_border_style_class_and_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_border_style_class_and_style(dispatch_arg_0)
		}
		'get_classes_by_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_classes_by_attributes(dispatch_arg_0, dispatch_arg_1)
		}
		'get_font_family_class_and_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_font_family_class_and_style(dispatch_arg_0)
		}
		'get_font_size_class_and_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_font_size_class_and_style(dispatch_arg_0)
		}
		'get_font_style_class_and_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_font_style_class_and_style(dispatch_arg_0)
		}
		'get_font_weight_class_and_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_font_weight_class_and_style(dispatch_arg_0)
		}
		'get_letter_spacing_class_and_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_letter_spacing_class_and_style(dispatch_arg_0)
		}
		'get_line_height_class_and_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_line_height_class_and_style(dispatch_arg_0)
		}
		'array_get_value_by_path' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.array_get_value_by_path(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_link_color_class_and_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_link_color_class_and_style(dispatch_arg_0)
		}
		'get_link_hover_color_class_and_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_link_hover_color_class_and_style(dispatch_arg_0)
		}
		'get_margin_class_and_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_margin_class_and_style(dispatch_arg_0)
		}
		'get_padding_class_and_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_padding_class_and_style(dispatch_arg_0)
		}
		'get_shadow_class_and_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_shadow_class_and_style(dispatch_arg_0)
		}
		'get_styles_by_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_styles_by_attributes(dispatch_arg_0, dispatch_arg_1)
		}
		'get_text_align_class_and_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_text_align_class_and_style(dispatch_arg_0)
		}
		'get_text_color_class_and_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_text_color_class_and_style(dispatch_arg_0)
		}
		'get_text_decoration_class_and_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_text_decoration_class_and_style(dispatch_arg_0)
		}
		'get_text_transform_class_and_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_text_transform_class_and_style(dispatch_arg_0)
		}
		'get_classes_from_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_classes_from_attributes(dispatch_arg_0)
		}
		'get_classes_and_styles_by_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_classes_and_styles_by_attributes(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_utils_styleattributesutils_php() {
}
