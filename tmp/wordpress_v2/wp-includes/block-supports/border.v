import rt

fn wp_register_border_support(var_block_type rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_block_type, 'attributes'))))) {
		rt.set_property(var_block_type, 'attributes', rt.new_array())
	}
	if rt.is_true(rt.call_function('block_has_support', [var_block_type.clone(), rt.new_string('__experimentalBorder')]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'attributes').array_isset(rt.new_string('style'))))))) {
		rt.get_property(var_block_type, 'attributes').array_set('style', rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'object' },
		]))
	}
	if wp_has_border_feature_support(var_block_type.clone(), 'color')
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'attributes').array_isset(rt.new_string('borderColor'))))))) {
		rt.get_property(var_block_type, 'attributes').array_set('borderColor', rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
		]))
	}
}

fn wp_apply_border_support(var_block_type rt.PhpVal, var_block_attributes rt.PhpVal) rt.PhpVal {
	mut var_border_block_styles := rt.new_null()
	mut var_has_border_color_support := rt.new_null()
	mut var_has_border_width_support := rt.new_null()
	mut var_border_radius := rt.new_null()
	mut var_border_width := rt.new_null()
	mut var_preset_border_color := rt.new_null()
	mut var_custom_border_color := rt.new_null()
	mut var_side := rt.new_null()
	mut var_border := rt.new_null()
	mut var_border_side_values := map[string]rt.PhpVal{}
	mut var_attributes := map[string]rt.PhpVal{}
	mut var_styles := rt.new_null()
	if rt.is_true(rt.call_function('wp_should_skip_block_supports_serialization', [
		var_block_type.clone(),
		rt.new_string('border'),
	]))
	{
		return rt.new_array()
	}
	var_border_block_styles = rt.new_array()
	var_has_border_color_support = rt.new_bool(wp_has_border_feature_support(var_block_type.clone(),
		'color', false))
	var_has_border_width_support = rt.new_bool(wp_has_border_feature_support(var_block_type.clone(),
		'width', false))
	if wp_has_border_feature_support(var_block_type.clone(), 'radius')
		&& var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_isset(rt.new_string('radius'))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.clone(), rt.new_string('__experimentalBorder'), rt.new_string('radius')]))))) {
		var_border_radius =
			var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string('radius'))
		if rt.is_true(rt.new_bool(var_border_radius.clone().is_long()
			|| var_border_radius.clone().is_double()))
		{
			var_border_radius = rt.concat(var_border_radius, rt.new_string('px'))
		}
		var_border_block_styles.array_set('radius', var_border_radius.clone())
	}
	if wp_has_border_feature_support(var_block_type.clone(), 'style')
		&& var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_isset(rt.new_string('style'))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.clone(), rt.new_string('__experimentalBorder'), rt.new_string('style')]))))) {
		var_border_block_styles.array_set('style',
			var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string('style')))
	}
	if rt.is_true(var_has_border_width_support)
		&& var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_isset(rt.new_string('width'))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.clone(), rt.new_string('__experimentalBorder'), rt.new_string('width')]))))) {
		var_border_width =
			var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string('width'))
		if rt.is_true(rt.new_bool(var_border_width.clone().is_long()
			|| var_border_width.clone().is_double()))
		{
			var_border_width = rt.concat(var_border_width, rt.new_string('px'))
		}
		var_border_block_styles.array_set('width', var_border_width.clone())
	}
	if rt.is_true(var_has_border_color_support)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.clone(), rt.new_string('__experimentalBorder'), rt.new_string('color')]))))) {
		var_preset_border_color = if rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_block_attributes).array_isset(rt.new_string('borderColor')))) {
			rt.concat(rt.new_string('var:preset|color|'),
				var_block_attributes.array_get(rt.new_string('borderColor')))
		} else {
			rt.new_null()
		}
		var_custom_border_color = if !(var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string('color'))).is_null() {
			var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string('color'))
		} else {
			rt.new_null()
		}
		var_border_block_styles.array_set('color', if rt.is_true(var_preset_border_color) {
			var_preset_border_color
		} else {
			var_custom_border_color
		})
	}
	if rt.is_true(var_has_border_color_support) || rt.is_true(var_has_border_width_support) {
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'top' },
			rt.ArrayItem{ key: none, val: 'right' }, rt.ArrayItem{ key: none, val: 'bottom' },
			rt.ArrayItem{ key: none, val: 'left' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_side_shadow := item_1.val
			var_border = if !(var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(var_side_shadow)).is_null() {
				var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(var_side_shadow)
			} else {
				rt.new_null()
			}
			var_border_side_values = {
				'width': if var_border.array_isset(rt.new_string('width'))
					&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.clone(), rt.new_string('__experimentalBorder'), rt.new_string('width')]))))) {
					var_border.array_get(rt.new_string('width'))
				} else {
					rt.new_null()
				}
				'color': if var_border.array_isset(rt.new_string('color'))
					&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.clone(), rt.new_string('__experimentalBorder'), rt.new_string('color')]))))) {
					var_border.array_get(rt.new_string('color'))
				} else {
					rt.new_null()
				}
				'style': if var_border.array_isset(rt.new_string('style'))
					&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.clone(), rt.new_string('__experimentalBorder'), rt.new_string('style')]))))) {
					var_border.array_get(rt.new_string('style'))
				} else {
					rt.new_null()
				}
			}
			var_border_block_styles.array_set(var_side_shadow, var_border_side_values.clone())
		}
	}
	var_attributes = rt.new_array()
	var_styles = rt.call_function('wp_style_engine_get_styles', [
		rt.create_array([rt.ArrayItem{ key: 'border', val: var_border_block_styles }]),
	])
	if !(!rt.is_true(var_styles.array_get(rt.new_string('classnames')))) {
		var_attributes['class'] = var_styles.array_get(rt.new_string('classnames'))
	}
	if !(!rt.is_true(var_styles.array_get(rt.new_string('css')))) {
		var_attributes['style'] = var_styles.array_get(rt.new_string('css'))
	}
	return var_attributes.clone()
}

fn wp_has_border_feature_support(var_block_type rt.PhpVal, feature string, default_value bool) bool {
	mut var_feature := feature
	mut var_default_value := default_value
	mut var_block_type_supports_border := rt.new_null()
	if rt.is_true(rt.new_bool(rt.instance_of(var_block_type, 'WP_Block_Type'))) {
		var_block_type_supports_border = if !(rt.get_property(var_block_type, 'supports').array_get(rt.new_string('__experimentalBorder'))).is_null() {
			rt.get_property(var_block_type, 'supports').array_get(rt.new_string('__experimentalBorder'))
		} else {
			rt.new_bool(default_value)
		}
		if rt.is_true(rt.identical(rt.new_bool(true), var_block_type_supports_border)) {
			return true
		}
	}
	return (rt.call_function('block_has_support', [var_block_type.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: '__experimentalBorder' },
			rt.ArrayItem{ key: none, val: feature }]),
		rt.new_bool(default_value)])).to_bool()
}

struct Class_WP_Block_Supports {
	rt.PhpObjectBase
}

fn create_wp_block_supports(_args ...rt.PhpVal) &Class_WP_Block_Supports {
	mut obj := &Class_WP_Block_Supports{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
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
	rt.call_method(iife_result_0, 'register', [rt.new_string('border'),
		rt.create_array([
			rt.ArrayItem{ key: 'register_attribute', val: 'wp_register_border_support' },
			rt.ArrayItem{ key: 'apply', val: 'wp_apply_border_support' },
		])])
}
