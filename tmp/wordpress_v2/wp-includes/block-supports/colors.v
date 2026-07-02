import rt

fn wp_register_colors_support(var_block_type rt.PhpVal) {
	mut var_color_support := rt.new_null()
	mut var_has_text_colors_support := false
	mut var_has_background_colors_support := false
	mut var_has_gradients_support := rt.new_null()
	mut var_has_link_colors_support := rt.new_null()
	mut var_has_button_colors_support := rt.new_null()
	mut var_has_heading_colors_support := rt.new_null()
	mut var_has_color_support := false
	var_color_support = rt.new_bool(false)
	if rt.is_true(rt.new_bool(rt.instance_of(var_block_type, 'WP_Block_Type'))) {
		var_color_support = if !(rt.get_property(var_block_type, 'supports').array_get(rt.new_string('color'))).is_null() {
			rt.get_property(var_block_type, 'supports').array_get(rt.new_string('color'))
		} else {
			rt.new_bool(false)
		}
	}
	var_has_text_colors_support = rt.is_true(rt.identical(rt.new_bool(true), var_color_support))
		|| (var_color_support.array_isset(rt.new_string('text'))
		&& rt.is_true(var_color_support.array_get(rt.new_string('text'))))
		|| var_color_support.clone().is_array()
		&& !(var_color_support.array_isset(rt.new_string('text')))
	var_has_background_colors_support =
		rt.is_true(rt.identical(rt.new_bool(true), var_color_support))
		|| (var_color_support.array_isset(rt.new_string('background'))
		&& rt.is_true(var_color_support.array_get(rt.new_string('background'))))
		|| var_color_support.clone().is_array()
		&& !(var_color_support.array_isset(rt.new_string('background')))
	var_has_gradients_support = if !(var_color_support.array_get(rt.new_string('gradients'))).is_null() {
		var_color_support.array_get(rt.new_string('gradients'))
	} else {
		rt.new_bool(false)
	}
	var_has_link_colors_support = if !(var_color_support.array_get(rt.new_string('link'))).is_null() {
		var_color_support.array_get(rt.new_string('link'))
	} else {
		rt.new_bool(false)
	}
	var_has_button_colors_support = if !(var_color_support.array_get(rt.new_string('button'))).is_null() {
		var_color_support.array_get(rt.new_string('button'))
	} else {
		rt.new_bool(false)
	}
	var_has_heading_colors_support = if !(var_color_support.array_get(rt.new_string('heading'))).is_null() {
		var_color_support.array_get(rt.new_string('heading'))
	} else {
		rt.new_bool(false)
	}
	var_has_color_support = var_has_text_colors_support || var_has_background_colors_support
		|| rt.is_true(var_has_gradients_support) || rt.is_true(var_has_link_colors_support)
		|| rt.is_true(var_has_button_colors_support) || rt.is_true(var_has_heading_colors_support)
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_block_type, 'attributes'))))) {
		rt.set_property(var_block_type, 'attributes', rt.new_array())
	}
	if var_has_color_support
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'attributes').array_isset(rt.new_string('style'))))))) {
		rt.get_property(var_block_type, 'attributes').array_set('style', rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'object' },
		]))
	}
	if var_has_background_colors_support
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'attributes').array_isset(rt.new_string('backgroundColor'))))))) {
		rt.get_property(var_block_type, 'attributes').array_set('backgroundColor', rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
		]))
	}
	if var_has_text_colors_support
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'attributes').array_isset(rt.new_string('textColor'))))))) {
		rt.get_property(var_block_type, 'attributes').array_set('textColor', rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
		]))
	}
	if rt.is_true(var_has_gradients_support)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'attributes').array_isset(rt.new_string('gradient'))))))) {
		rt.get_property(var_block_type, 'attributes').array_set('gradient', rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
		]))
	}
}

fn wp_apply_colors_support(var_block_type rt.PhpVal, var_block_attributes rt.PhpVal) rt.PhpVal {
	mut var_color_support := rt.new_null()
	mut var_has_text_colors_support := false
	mut var_has_background_colors_support := false
	mut var_has_gradients_support := rt.new_null()
	mut var_color_block_styles := map[string]rt.PhpVal{}
	mut var_preset_text_color := rt.new_null()
	mut var_custom_text_color := rt.new_null()
	mut var_preset_background_color := rt.new_null()
	mut var_custom_background_color := rt.new_null()
	mut var_preset_gradient_color := rt.new_null()
	mut var_custom_gradient_color := rt.new_null()
	mut var_attributes := map[string]rt.PhpVal{}
	mut var_styles := rt.new_null()
	var_color_support = if !(rt.get_property(var_block_type, 'supports').array_get(rt.new_string('color'))).is_null() {
		rt.get_property(var_block_type, 'supports').array_get(rt.new_string('color'))
	} else {
		rt.new_bool(false)
	}
	if var_color_support.clone().is_array()
		&& rt.is_true(rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.clone(), rt.new_string('color')])) {
		return rt.new_array()
	}
	var_has_text_colors_support = rt.is_true(rt.identical(rt.new_bool(true), var_color_support))
		|| (var_color_support.array_isset(rt.new_string('text'))
		&& rt.is_true(var_color_support.array_get(rt.new_string('text'))))
		|| var_color_support.clone().is_array()
		&& !(var_color_support.array_isset(rt.new_string('text')))
	var_has_background_colors_support =
		rt.is_true(rt.identical(rt.new_bool(true), var_color_support))
		|| (var_color_support.array_isset(rt.new_string('background'))
		&& rt.is_true(var_color_support.array_get(rt.new_string('background'))))
		|| var_color_support.clone().is_array()
		&& !(var_color_support.array_isset(rt.new_string('background')))
	var_has_gradients_support = if !(var_color_support.array_get(rt.new_string('gradients'))).is_null() {
		var_color_support.array_get(rt.new_string('gradients'))
	} else {
		rt.new_bool(false)
	}
	var_color_block_styles = rt.new_array()
	if var_has_text_colors_support
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.clone(), rt.new_string('color'), rt.new_string('text')]))))) {
		var_preset_text_color = if rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_block_attributes).array_isset(rt.new_string('textColor')))) {
			rt.concat(rt.new_string('var:preset|color|'),
				var_block_attributes.array_get(rt.new_string('textColor')))
		} else {
			rt.new_null()
		}
		var_custom_text_color = if !(var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('text'))).is_null() {
			var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('text'))
		} else {
			rt.new_null()
		}
		var_color_block_styles['text'] = if rt.is_true(var_preset_text_color) {
			var_preset_text_color
		} else {
			var_custom_text_color
		}
	}
	if var_has_background_colors_support
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.clone(), rt.new_string('color'), rt.new_string('background')]))))) {
		var_preset_background_color = if rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_block_attributes).array_isset(rt.new_string('backgroundColor')))) {
			rt.concat(rt.new_string('var:preset|color|'),
				var_block_attributes.array_get(rt.new_string('backgroundColor')))
		} else {
			rt.new_null()
		}
		var_custom_background_color = if !(var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('background'))).is_null() {
			var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('background'))
		} else {
			rt.new_null()
		}
		var_color_block_styles['background'] = if rt.is_true(var_preset_background_color) {
			var_preset_background_color
		} else {
			var_custom_background_color
		}
	}
	if rt.is_true(var_has_gradients_support)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.clone(), rt.new_string('color'), rt.new_string('gradients')]))))) {
		var_preset_gradient_color = if rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_block_attributes).array_isset(rt.new_string('gradient')))) {
			rt.concat(rt.new_string('var:preset|gradient|'),
				var_block_attributes.array_get(rt.new_string('gradient')))
		} else {
			rt.new_null()
		}
		var_custom_gradient_color = if !(var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('gradient'))).is_null() {
			var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('gradient'))
		} else {
			rt.new_null()
		}
		var_color_block_styles['gradient'] = if rt.is_true(var_preset_gradient_color) {
			var_preset_gradient_color
		} else {
			var_custom_gradient_color
		}
	}
	var_attributes = rt.new_array()
	var_styles = rt.call_function('wp_style_engine_get_styles', [
		rt.create_array([rt.ArrayItem{ key: 'color', val: var_color_block_styles }]),
		rt.create_array([rt.ArrayItem{ key: 'convert_vars_to_classnames', val: true }]),
	])
	if !(!rt.is_true(var_styles.array_get(rt.new_string('classnames')))) {
		var_attributes['class'] = var_styles.array_get(rt.new_string('classnames'))
	}
	if !(!rt.is_true(var_styles.array_get(rt.new_string('css')))) {
		var_attributes['style'] = var_styles.array_get(rt.new_string('css'))
	}
	return var_attributes.clone()
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
	rt.call_method(iife_result_0, 'register', [rt.new_string('colors'),
		rt.create_array([
			rt.ArrayItem{ key: 'register_attribute', val: 'wp_register_colors_support' },
			rt.ArrayItem{ key: 'apply', val: 'wp_apply_colors_support' },
		])])
}
