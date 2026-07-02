import rt

pub fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'class', val: '' },
		rt.ArrayItem{ key: 'style', val: '' }, rt.ArrayItem{ key: 'value', val: '' }])
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_color_value(var_color_value rt.PhpVal) rt.PhpVal {
	mut var_color_value_mutated := var_color_value
	if var_color_value_mutated.clone().is_string()
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [var_color_value_mutated.clone(), rt.new_string('var:preset|color|')]), rt.new_bool(false))))) {
		var_color_value_mutated = rt.call_function('str_replace', [
			rt.new_string('var:preset|color|'),
			rt.new_string(''),
			var_color_value_mutated.clone(),
		])
		return rt.call_function('sprintf', [
			rt.new_string('var(--wp--preset--color--%s)'),
			var_color_value_mutated.clone(),
		])
	}
	return var_color_value_mutated.clone()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_preset_value(var_preset_name rt.PhpVal) string {
	return 'var(--wp--preset--color--${var_preset_name.to_string()})'
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_shadow_value(var_shadow_name rt.PhpVal) string {
	mut var_shadow_name_mutated := var_shadow_name
	if var_shadow_name_mutated.clone().is_string()
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [var_shadow_name_mutated.clone(), rt.new_string('var:preset|shadow|')]), rt.new_bool(false))))) {
		var_shadow_name_mutated = rt.call_function('str_replace', [
			rt.new_string('var:preset|shadow|'),
			rt.new_string(''),
			var_shadow_name_mutated.clone(),
		])
		return 'var(--wp--preset--shadow--${var_shadow_name.to_string()})'
	}
	return var_shadow_name_mutated.str()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_spacing_value(var_spacing_value rt.PhpVal) rt.PhpVal {
	mut var_spacing_value_mutated := var_spacing_value
	if var_spacing_value_mutated.clone().is_string()
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [var_spacing_value_mutated.clone(), rt.new_string('var:preset|spacing|')]), rt.new_bool(false))))) {
		var_spacing_value_mutated = rt.call_function('str_replace', [
			rt.new_string('var:preset|spacing|'),
			rt.new_string(''),
			var_spacing_value_mutated.clone(),
		])
		return rt.call_function('sprintf', [
			rt.new_string('var(--wp--preset--spacing--%s)'),
			var_spacing_value_mutated.clone(),
		])
	}
	return var_spacing_value_mutated.clone()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_align_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_align_attribute := if !(var_attributes.array_get(rt.new_string('align'))).is_null() {
		var_attributes.array_get(rt.new_string('align'))
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_string('wide'), var_align_attribute)) {
		return rt.create_array([rt.ArrayItem{ key: 'class', val: 'alignwide' },
			rt.ArrayItem{ key: 'style', val: rt.new_null() }])
	}
	if rt.is_true(rt.identical(rt.new_string('full'), var_align_attribute)) {
		return rt.create_array([rt.ArrayItem{ key: 'class', val: 'alignfull' },
			rt.ArrayItem{ key: 'style', val: rt.new_null() }])
	}
	if rt.is_true(rt.identical(rt.new_string('left'), var_align_attribute)) {
		return rt.create_array([rt.ArrayItem{ key: 'class', val: 'alignleft' },
			rt.ArrayItem{ key: 'style', val: rt.new_null() }])
	}
	if rt.is_true(rt.identical(rt.new_string('right'), var_align_attribute)) {
		return rt.create_array([rt.ArrayItem{ key: 'class', val: 'alignright' },
			rt.ArrayItem{ key: 'style', val: rt.new_null() }])
	}
	if rt.is_true(rt.identical(rt.new_string('center'), var_align_attribute)) {
		return rt.create_array([rt.ArrayItem{ key: 'class', val: 'aligncenter' },
			rt.ArrayItem{ key: 'style', val: rt.new_null() }])
	}
	return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_background_color_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_gradient := if !(var_attributes.array_get(rt.new_string('gradient'))).is_null() {
		var_attributes.array_get(rt.new_string('gradient'))
	} else {
		rt.new_null()
	}
	mut var_background_color := if !(var_attributes.array_get(rt.new_string('backgroundColor'))).is_null() {
		var_attributes.array_get(rt.new_string('backgroundColor'))
	} else {
		rt.new_string('')
	}
	mut var_custom_background_color := if !(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('background'))).is_null() {
		var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('background'))
	} else {
		rt.new_string('')
	}
	mut var_classes := rt.create_array([rt.ArrayItem{ key: none, val: var_gradient }])
	mut var_styles := rt.new_array()
	mut var_value := rt.new_null()
	if rt.is_true(var_background_color) || rt.is_true(var_custom_background_color)
		|| rt.is_true(var_gradient) {
		var_classes.array_push('has-background')
	}
	if rt.is_true(var_background_color) {
		var_classes.array_push(rt.call_function('sprintf', [
			rt.new_string('has-%s-background-color'),
			var_background_color.clone(),
		]))
		var_value =
			Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_preset_value(var_background_color.clone())
	}
	if rt.is_true(var_custom_background_color) {
		var_styles.array_push(rt.call_function('sprintf', [
			rt.new_string('background-color: %s;'),
			var_custom_background_color.clone(),
		]))
		var_value = var_custom_background_color.clone()
	}
	if rt.is_true(var_gradient) {
		var_classes.array_push(rt.call_function('sprintf', [
			rt.new_string('has-%s-gradient-background'),
			var_gradient.clone(),
		]))
	}
	return rt.create_array([
		rt.ArrayItem{
			key: 'class'
			val: Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.join_styles(var_classes.clone())
		},
		rt.ArrayItem{
			key: 'style'
			val: Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.join_styles(var_styles.clone())
		},
		rt.ArrayItem{ key: 'value', val: var_value },
	])
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.join_styles(var_rules rt.PhpVal) rt.PhpVal {
	return rt.call_function('implode', [rt.new_string(' '),
		rt.call_function('array_unique', [
			rt.call_function('array_filter', [var_rules.clone()]),
		])])
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_border_color_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_border_color_linked_preset := if !(var_attributes.array_get(rt.new_string('borderColor'))).is_null() {
		var_attributes.array_get(rt.new_string('borderColor'))
	} else {
		rt.new_string('')
	}
	mut var_border_color_linked_custom := if !(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string('color'))).is_null() {
		var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string('color'))
	} else {
		rt.new_string('')
	}
	mut var_custom_border := if !(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border'))).is_null() {
		var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border'))
	} else {
		rt.new_string('')
	}
	mut var_class := rt.new_string('')
	mut var_style := rt.new_string('')
	mut var_value := rt.new_string('')
	if rt.is_true(var_border_color_linked_preset) {
		var_class = rt.call_function('sprintf', [
			rt.new_string('has-border-color has-%s-border-color'),
			var_border_color_linked_preset.clone(),
		])
		var_value =
			Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_preset_value(var_border_color_linked_preset.clone())
		var_style = rt.new_string('border-color:' + var_value.str() + ';')
	} else if rt.is_true(var_border_color_linked_custom) {
		var_style = rt.concat(var_style, rt.new_string('border-color:' +
			var_border_color_linked_custom.str() + ';'))
		var_value = var_border_color_linked_custom.clone()
	} else if rt.is_true(rt.new_bool(var_custom_border.clone().is_array())) {
		mut iter_1 := var_custom_border.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_border_color_value := item_1.val
			mut var_border_color_key := item_1.key
			if var_border_color_value.clone().is_array()
				&& rt.is_true(rt.new_bool(var_border_color_value.clone().array_isset(rt.new_string('color')))) {
				var_style = rt.concat(var_style, rt.new_string('border-' +
					var_border_color_key.str() + '-color:' +
					(Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_color_value(var_border_color_value.array_get(rt.new_string('color')))).str() + ';'))
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_class))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_style)))) {
		return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
	}
	return rt.create_array([rt.ArrayItem{ key: 'class', val: var_class },
		rt.ArrayItem{ key: 'style', val: var_style }, rt.ArrayItem{ key: 'value', val: var_value }])
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_border_radius_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_custom_border_radius := if !(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string('radius'))).is_null() {
		var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string('radius'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.identical(rt.new_string(''), var_custom_border_radius)) {
		return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
	}
	mut var_style := rt.new_string('')
	if rt.is_true(rt.new_bool(var_custom_border_radius.clone().is_string())) {
		var_style = rt.new_string('border-radius:' + var_custom_border_radius.str() + ';')
	} else {
		mut var_border_radius := rt.new_array()
		var_border_radius.array_set('border-top-left-radius', if !(var_custom_border_radius.array_get(rt.new_string('topLeft'))).is_null() {
			var_custom_border_radius.array_get(rt.new_string('topLeft'))
		} else {
			rt.new_string('')
		})
		var_border_radius.array_set('border-top-right-radius', if !(var_custom_border_radius.array_get(rt.new_string('topRight'))).is_null() {
			var_custom_border_radius.array_get(rt.new_string('topRight'))
		} else {
			rt.new_string('')
		})
		var_border_radius.array_set('border-bottom-right-radius', if !(var_custom_border_radius.array_get(rt.new_string('bottomRight'))).is_null() {
			var_custom_border_radius.array_get(rt.new_string('bottomRight'))
		} else {
			rt.new_string('')
		})
		var_border_radius.array_set('border-bottom-left-radius', if !(var_custom_border_radius.array_get(rt.new_string('bottomLeft'))).is_null() {
			var_custom_border_radius.array_get(rt.new_string('bottomLeft'))
		} else {
			rt.new_string('')
		})
		mut iter_2 := var_border_radius.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_border_radius_value := item_2.val
			mut var_border_radius_side := item_2.key
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''),
				var_border_radius_value))))
			{
				var_style = rt.concat(var_style, rt.new_string(var_border_radius_side.str() + ':' +
					var_border_radius_value.str() + ';'))
			}
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'class', val: rt.new_null() },
		rt.ArrayItem{ key: 'style', val: var_style }])
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_border_width_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_custom_border := if !(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border'))).is_null() {
		var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.identical(rt.new_string(''), var_custom_border)) {
		return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
	}
	mut var_style := rt.new_string('')
	if rt.is_true(rt.new_bool(var_custom_border.clone().array_isset(rt.new_string('width'))))
		&& !(!rt.is_true(var_custom_border.array_get(rt.new_string('width')))) {
		var_style = rt.new_string('border-width:' +
			(var_custom_border.array_get(rt.new_string('width'))).str() + ';')
	} else {
		mut iter_3 := var_custom_border.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_border_width_value := item_3.val
			mut var_border_width_side := item_3.key
			if var_border_width_value.array_isset(rt.new_string('width')) {
				var_style = rt.concat(var_style, rt.new_string('border-' +
					var_border_width_side.str() + '-width:' +
					(var_border_width_value.array_get(rt.new_string('width'))).str() + ';'))
			}
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'class', val: rt.new_null() },
		rt.ArrayItem{ key: 'style', val: var_style }])
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_border_style_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_custom_border := if !(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border'))).is_null() {
		var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.identical(rt.new_string(''), var_custom_border)) {
		return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
	}
	mut var_style := rt.new_string('')
	if rt.is_true(rt.new_bool(var_custom_border.clone().array_isset(rt.new_string('style'))))
		&& !(!rt.is_true(var_custom_border.array_get(rt.new_string('style')))) {
		var_style = rt.new_string('border-style:' +
			(var_custom_border.array_get(rt.new_string('style'))).str() + ';')
	} else {
		mut iter_4 := var_custom_border.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_value := item_4.val
			mut var_side := item_4.key
			if var_value.array_isset(rt.new_string('style')) {
				var_style = rt.concat(var_style, rt.new_string('border-' + var_side.str() +
					'-style:' + (var_value.array_get(rt.new_string('style'))).str() + ';'))
			}
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'class', val: rt.new_null() },
		rt.ArrayItem{ key: 'style', val: var_style }])
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_classes_by_attributes(var_attributes rt.PhpVal, var_properties rt.PhpVal) rt.PhpVal {
	mut var_classes_and_styles := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_classes_and_styles_by_attributes(var_attributes.clone(),
		var_properties.clone())
	return var_classes_and_styles.array_get(rt.new_string('classes'))
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_font_family_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_font_family := if !(var_attributes.array_get(rt.new_string('fontFamily'))).is_null() {
		var_attributes.array_get(rt.new_string('fontFamily'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(var_font_family) {
		return rt.create_array([
			rt.ArrayItem{ key: 'class', val: rt.call_function('sprintf', [
				rt.new_string('has-%s-font-family'),
				var_font_family.clone(),
			]) },
			rt.ArrayItem{ key: 'style', val: rt.new_null() },
		])
	}
	return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_font_size_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_font_size := if !(var_attributes.array_get(rt.new_string('fontSize'))).is_null() {
		var_attributes.array_get(rt.new_string('fontSize'))
	} else {
		rt.new_string('')
	}
	mut var_custom_font_size := if !(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontSize'))).is_null() {
		var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontSize'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_font_size))))
		&& rt.is_true(rt.identical(rt.new_string(''), var_custom_font_size)) {
		return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
	}
	if rt.is_true(var_font_size) {
		return rt.create_array([
			rt.ArrayItem{ key: 'class', val: rt.call_function('sprintf', [
				rt.new_string('has-font-size has-%s-font-size'),
				var_font_size.clone(),
			]) },
			rt.ArrayItem{ key: 'style', val: rt.new_null() },
		])
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''),
		var_custom_font_size))))
	{
		return rt.create_array([rt.ArrayItem{ key: 'class', val: rt.new_null() },
			rt.ArrayItem{ key: 'style', val: rt.call_function('sprintf', [
				rt.new_string('font-size: %s;'),
				var_custom_font_size.clone(),
			]) }])
	}
	return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_font_style_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_custom_font_style := if !(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontStyle'))).is_null() {
		var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontStyle'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_custom_font_style)))) {
		return rt.create_array([rt.ArrayItem{ key: 'class', val: rt.new_null() },
			rt.ArrayItem{ key: 'style', val: rt.call_function('sprintf', [
				rt.new_string('font-style: %s;'),
				var_custom_font_style.clone(),
			]) }])
	}
	return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_font_weight_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_custom_font_weight := if !(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontWeight'))).is_null() {
		var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontWeight'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_custom_font_weight)))) {
		return rt.create_array([rt.ArrayItem{ key: 'class', val: rt.new_null() },
			rt.ArrayItem{ key: 'style', val: rt.call_function('sprintf', [
				rt.new_string('font-weight: %s;'),
				var_custom_font_weight.clone(),
			]) }])
	}
	return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_letter_spacing_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_custom_letter_spacing := if !(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('letterSpacing'))).is_null() {
		var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('letterSpacing'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_custom_letter_spacing)))) {
		return rt.create_array([rt.ArrayItem{ key: 'class', val: rt.new_null() },
			rt.ArrayItem{ key: 'style', val: rt.call_function('sprintf', [
				rt.new_string('letter-spacing: %s;'),
				var_custom_letter_spacing.clone(),
			]) }])
	}
	return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_line_height_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_line_height := if !(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('lineHeight'))).is_null() {
		var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('lineHeight'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_line_height)))) {
		return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
	}
	return rt.create_array([rt.ArrayItem{ key: 'class', val: rt.new_null() },
		rt.ArrayItem{ key: 'style', val: rt.call_function('sprintf', [
			rt.new_string('line-height: %s;'),
			var_line_height.clone(),
		]) }])
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.array_get_value_by_path(mut var_array Class_Automattic_WooCommerce_Blocks_Utils_array, var_path rt.PhpVal, delimiter string) rt.PhpVal {
	mut var_ref := rt.new_null()
	mut var_array_path := rt.call_function('explode', [rt.new_string(delimiter),
		var_path.clone()])
	var_ref = var_array
	mut iter_5 := var_array_path.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_key := item_5.val
		if var_ref.clone().is_array()
			&& rt.is_true(rt.new_bool(var_ref.clone().array_isset(var_key.clone()))) {
			var_ref = var_ref.array_get(var_key)
		} else {
			return rt.new_null()
		}
	}
	return var_ref.clone()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_link_color_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_link_color := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.array_get_value_by_path(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Utils_array](var_attributes),
		'style.elements.link.color.text')
	if !rt.is_true(var_link_color) {
		return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
	}
	if rt.is_true(rt.call_function('strstr', [var_link_color.clone(),
		rt.new_string('|')]))
	{
		mut var_link_color_parts := rt.call_function('explode', [
			rt.new_string('|'), var_link_color.clone()])
		var_link_color = Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_preset_value(rt.call_function('end', [
			var_link_color_parts.clone(),
		]))
	}
	return rt.create_array([rt.ArrayItem{ key: 'class', val: 'has-link-color' },
		rt.ArrayItem{ key: 'style', val: rt.call_function('sprintf', [
			rt.new_string('color: %s;'),
			var_link_color.clone(),
		]) }, rt.ArrayItem{ key: 'value', val: var_link_color }])
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_link_hover_color_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_link_color := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.array_get_value_by_path(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Utils_array](var_attributes),
		'style.elements.link.:hover.color.text')
	if !rt.is_true(var_link_color) {
		return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
	}
	if rt.is_true(rt.call_function('strstr', [var_link_color.clone(),
		rt.new_string('|')]))
	{
		mut var_link_color_parts := rt.call_function('explode', [
			rt.new_string('|'), var_link_color.clone()])
		var_link_color = Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_preset_value(rt.call_function('end', [
			var_link_color_parts.clone(),
		]))
	}
	return rt.create_array([rt.ArrayItem{ key: 'class', val: 'has-link-color' },
		rt.ArrayItem{ key: 'style', val: rt.call_function('sprintf', [
			rt.new_string('color: %s;'),
			var_link_color.clone(),
		]) }, rt.ArrayItem{ key: 'value', val: var_link_color }])
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_margin_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_margin := if !(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('spacing')).array_get(rt.new_string('margin'))).is_null() {
		var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('spacing')).array_get(rt.new_string('margin'))
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_margin)))) {
		return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
	}
	mut var_spacing_values_css := rt.new_string('')
	mut iter_6 := var_margin.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_margin_value := item_6.val
		mut var_margin_side := item_6.key
		var_spacing_values_css = rt.concat(var_spacing_values_css, rt.new_string('margin-' +
			var_margin_side.str() + ':' +
			(Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_spacing_value(var_margin_value.clone())).str() + ';'))
	}
	return rt.create_array([rt.ArrayItem{ key: 'class', val: rt.new_null() },
		rt.ArrayItem{ key: 'style', val: var_spacing_values_css }])
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_padding_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_padding := if !(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('spacing')).array_get(rt.new_string('padding'))).is_null() {
		var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('spacing')).array_get(rt.new_string('padding'))
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_padding)))) {
		return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
	}
	mut var_spacing_values_css := rt.new_string('')
	mut iter_7 := var_padding.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_padding_value := item_7.val
		mut var_padding_side := item_7.key
		var_spacing_values_css = rt.concat(var_spacing_values_css, rt.new_string('padding-' +
			var_padding_side.str() + ':' +
			(Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_spacing_value(var_padding_value.clone())).str() + ';'))
	}
	return rt.create_array([rt.ArrayItem{ key: 'class', val: rt.new_null() },
		rt.ArrayItem{ key: 'style', val: var_spacing_values_css }])
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_shadow_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_shadow := if !(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('shadow'))).is_null() {
		var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('shadow'))
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_shadow)))) {
		return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
	}
	return rt.create_array([rt.ArrayItem{ key: 'class', val: rt.new_null() },
		rt.ArrayItem{ key: 'style', val: rt.call_function('sprintf', [
			rt.new_string('box-shadow: %s;'),
			Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_shadow_value(var_shadow.clone()),
		]) }])
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_styles_by_attributes(var_attributes rt.PhpVal, var_properties rt.PhpVal) rt.PhpVal {
	mut var_classes_and_styles := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_classes_and_styles_by_attributes(var_attributes.clone(),
		var_properties.clone())
	return var_classes_and_styles.array_get(rt.new_string('styles'))
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_text_align_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_text_align := if !(var_attributes.array_get(rt.new_string('textAlign'))).is_null() {
		var_attributes.array_get(rt.new_string('textAlign'))
	} else {
		if !(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('textAlign'))).is_null() {
			var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('textAlign'))
		} else {
			rt.new_null()
		}
	}
	if rt.is_true(var_text_align) {
		return rt.create_array([
			rt.ArrayItem{ key: 'class', val: 'has-text-align-' + var_text_align.str() },
			rt.ArrayItem{ key: 'style', val: rt.new_null() },
		])
	}
	return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_text_color_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_text_color := if !(var_attributes.array_get(rt.new_string('textColor'))).is_null() {
		var_attributes.array_get(rt.new_string('textColor'))
	} else {
		rt.new_string('')
	}
	mut var_custom_text_color := if !(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('text'))).is_null() {
		var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('text'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_text_color))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_custom_text_color)))) {
		return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
	}
	if rt.is_true(var_text_color) {
		return rt.create_array([
			rt.ArrayItem{ key: 'class', val: rt.call_function('sprintf', [
				rt.new_string('has-text-color has-%s-color'),
				var_text_color.clone(),
			]) },
			rt.ArrayItem{ key: 'style', val: rt.new_null() },
			rt.ArrayItem{
				key: 'value'
				val: Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_preset_value(var_text_color.clone())
			},
		])
	} else if rt.is_true(var_custom_text_color) {
		return rt.create_array([rt.ArrayItem{ key: 'class', val: rt.new_null() },
			rt.ArrayItem{ key: 'style', val: rt.call_function('sprintf', [
				rt.new_string('color: %s;'),
				var_custom_text_color.clone(),
			]) }, rt.ArrayItem{ key: 'value', val: var_custom_text_color }])
	}
	return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_text_decoration_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_custom_text_decoration := if !(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('textDecoration'))).is_null() {
		var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('textDecoration'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''),
		var_custom_text_decoration))))
	{
		return rt.create_array([rt.ArrayItem{ key: 'class', val: rt.new_null() },
			rt.ArrayItem{ key: 'style', val: rt.call_function('sprintf', [
				rt.new_string('text-decoration: %s;'),
				var_custom_text_decoration.clone(),
			]) }])
	}
	return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_text_transform_class_and_style(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_custom_text_transform := if !(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('textTransform'))).is_null() {
		var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('textTransform'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_custom_text_transform)))) {
		return rt.create_array([rt.ArrayItem{ key: 'class', val: rt.new_null() },
			rt.ArrayItem{ key: 'style', val: rt.call_function('sprintf', [
				rt.new_string('text-transform: %s;'),
				var_custom_text_transform.clone(),
			]) }])
	}
	return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_classes_from_attributes(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_extra_css_classes := if !(var_attributes.array_get(rt.new_string('className'))).is_null() {
		var_attributes.array_get(rt.new_string('className'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_extra_css_classes)))) {
		return rt.create_array([
			rt.ArrayItem{ key: 'class', val: rt.call_function('esc_attr', [
				var_extra_css_classes.clone()]) },
			rt.ArrayItem{ key: 'style', val: rt.new_null() },
		])
	}
	return Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.empty_style()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_classes_and_styles_by_attributes(var_attributes rt.PhpVal, var_properties rt.PhpVal, var_exclude rt.PhpVal) rt.PhpVal {
	mut var_classes_and_styles := rt.create_array([
		rt.ArrayItem{
			key: 'align'
			val: Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_align_class_and_style(var_attributes.clone())
		},
		rt.ArrayItem{
			key: 'background_color'
			val: Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_background_color_class_and_style(var_attributes.clone())
		},
		rt.ArrayItem{
			key: 'border_color'
			val: Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_border_color_class_and_style(var_attributes.clone())
		},
		rt.ArrayItem{
			key: 'border_radius'
			val: Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_border_radius_class_and_style(var_attributes.clone())
		},
		rt.ArrayItem{
			key: 'border_width'
			val: Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_border_width_class_and_style(var_attributes.clone())
		},
		rt.ArrayItem{
			key: 'border_style'
			val: Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_border_style_class_and_style(var_attributes.clone())
		},
		rt.ArrayItem{
			key: 'font_family'
			val: Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_font_family_class_and_style(var_attributes.clone())
		},
		rt.ArrayItem{
			key: 'font_size'
			val: Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_font_size_class_and_style(var_attributes.clone())
		},
		rt.ArrayItem{
			key: 'font_style'
			val: Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_font_style_class_and_style(var_attributes.clone())
		},
		rt.ArrayItem{
			key: 'font_weight'
			val: Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_font_weight_class_and_style(var_attributes.clone())
		},
		rt.ArrayItem{
			key: 'letter_spacing'
			val: Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_letter_spacing_class_and_style(var_attributes.clone())
		},
		rt.ArrayItem{
			key: 'line_height'
			val: Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_line_height_class_and_style(var_attributes.clone())
		},
		rt.ArrayItem{
			key: 'margin'
			val: Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_margin_class_and_style(var_attributes.clone())
		},
		rt.ArrayItem{
			key: 'padding'
			val: Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_padding_class_and_style(var_attributes.clone())
		},
		rt.ArrayItem{
			key: 'shadow'
			val: Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_shadow_class_and_style(var_attributes.clone())
		},
		rt.ArrayItem{
			key: 'text_align'
			val: Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_text_align_class_and_style(var_attributes.clone())
		},
		rt.ArrayItem{
			key: 'text_color'
			val: Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_text_color_class_and_style(var_attributes.clone())
		},
		rt.ArrayItem{
			key: 'text_decoration'
			val: Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_text_decoration_class_and_style(var_attributes.clone())
		},
		rt.ArrayItem{
			key: 'text_transform'
			val: Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_text_transform_class_and_style(var_attributes.clone())
		},
		rt.ArrayItem{
			key: 'extra_classes'
			val: Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_classes_from_attributes(var_attributes.clone())
		},
	])
	if !(!rt.is_true(var_properties)) {
		mut iter_8 := var_classes_and_styles.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_value := item_8.val
			mut var_key := item_8.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
				var_key.clone(),
				var_properties.clone(),
				rt.new_bool(true),
			])))))
			{
				var_classes_and_styles.array_unset(var_key)
			}
		}
	}
	if !(!rt.is_true(var_exclude)) {
		mut iter_9 := var_classes_and_styles.iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_value := item_9.val
			mut var_key := item_9.key
			if rt.is_true(rt.call_function('in_array', [var_key.clone(),
				var_exclude.clone(), rt.new_bool(true)]))
			{
				var_classes_and_styles.array_unset(var_key)
			}
		}
	}
	var_classes_and_styles = rt.call_function('array_filter', [
		var_classes_and_styles.clone()])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return var_item.array_get(rt.new_string('class'))
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return var_item.array_get(rt.new_string('class'))
	}
	mut var_classes := rt.call_function('array_map', [rt.new_closure(closure_1_fn),
		var_classes_and_styles.clone()])
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return var_item.array_get(rt.new_string('style'))
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return var_item.array_get(rt.new_string('style'))
	}
	mut var_styles := rt.call_function('array_map', [rt.new_closure(closure_3_fn),
		rt.call_function('array_diff_key', [var_classes_and_styles.clone(),
			rt.call_function('array_flip', [
				rt.create_array([rt.ArrayItem{ key: none, val: 'link_color' }]),
			])])])
	var_classes = rt.call_function('array_filter', [var_classes.clone()])
	var_styles = rt.call_function('array_filter', [var_styles.clone()])
	return rt.create_array([
		rt.ArrayItem{ key: 'classes', val: rt.call_function('implode', [
			rt.new_string(' '),
			var_classes.clone(),
		]) },
		rt.ArrayItem{ key: 'styles', val: rt.call_function('implode', [
			rt.new_string(' '),
			var_styles.clone(),
		]) },
	])
}

fn create_automattic_woocommerce_blocks_utils_styleattributesutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
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
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_classes_by_attributes(dispatch_arg_0,
				dispatch_arg_1)
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Utils_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.array_get_value_by_path(mut dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
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
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_styles_by_attributes(dispatch_arg_0,
				dispatch_arg_1)
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
			return Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils.get_classes_and_styles_by_attributes(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
