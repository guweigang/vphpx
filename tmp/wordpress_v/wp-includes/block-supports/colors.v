import rt

fn wp_register_colors_support(var_block_type rt.PhpVal) {
	mut var_color_support := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.new_bool(rt.instance_of(var_block_type, 'WP_Block_Type'))) {
		var_color_support = if !(rt.get_property(var_block_type, 'supports').array_get('color')).is_null() {
			rt.get_property(var_block_type, 'supports').array_get('color')
		} else {
			rt.new_bool(false)
		}
	}
	mut var_has_text_colors_support :=
		rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(true), var_color_support))
		|| rt.is_true(rt.new_bool(var_color_support.array_isset(rt.new_string('text'))
		&& rt.is_true(var_color_support.array_get('text'))))))
		|| rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_color_support.dup().is_array()))
		&& !(var_color_support.array_isset(rt.new_string('text')))))
	mut var_has_background_colors_support :=
		rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(true), var_color_support))
		|| rt.is_true(rt.new_bool(var_color_support.array_isset(rt.new_string('background'))
		&& rt.is_true(var_color_support.array_get('background'))))))
		|| rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_color_support.dup().is_array()))
		&& !(var_color_support.array_isset(rt.new_string('background')))))
	mut var_has_gradients_support := if !(var_color_support.array_get('gradients')).is_null() {
		var_color_support.array_get('gradients')
	} else {
		rt.new_bool(false)
	}
	mut var_has_link_colors_support := if !(var_color_support.array_get('link')).is_null() {
		var_color_support.array_get('link')
	} else {
		rt.new_bool(false)
	}
	mut var_has_button_colors_support := if !(var_color_support.array_get('button')).is_null() {
		var_color_support.array_get('button')
	} else {
		rt.new_bool(false)
	}
	mut var_has_heading_colors_support := if !(var_color_support.array_get('heading')).is_null() {
		var_color_support.array_get('heading')
	} else {
		rt.new_bool(false)
	}
	mut var_has_color_support :=
		rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_has_text_colors_support
		|| var_has_background_colors_support || rt.is_true(var_has_gradients_support)))
		|| rt.is_true(var_has_link_colors_support))) || rt.is_true(var_has_button_colors_support)))
		|| rt.is_true(var_has_heading_colors_support)
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_block_type, 'attributes'))))) {
		rt.set_property(var_block_type, 'attributes', rt.new_array())
	}
	if rt.is_true(rt.new_bool(var_has_color_support
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'attributes').array_isset(rt.new_string('style')))))))))
	{
		rt.get_property(var_block_type, 'attributes').array_set('style', rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'object' },
		]))
	}
	if rt.is_true(rt.new_bool(var_has_background_colors_support
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'attributes').array_isset(rt.new_string('backgroundColor')))))))))
	{
		rt.get_property(var_block_type, 'attributes').array_set('backgroundColor', rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
		]))
	}
	if rt.is_true(rt.new_bool(var_has_text_colors_support
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'attributes').array_isset(rt.new_string('textColor')))))))))
	{
		rt.get_property(var_block_type, 'attributes').array_set('textColor', rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
		]))
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_has_gradients_support)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'attributes').array_isset(rt.new_string('gradient')))))))))
	{
		rt.get_property(var_block_type, 'attributes').array_set('gradient', rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
		]))
	}
}

fn wp_apply_colors_support(var_block_type rt.PhpVal, var_block_attributes rt.PhpVal) rt.PhpVal {
	mut var_color_support := if !(rt.get_property(var_block_type, 'supports').array_get('color')).is_null() {
		rt.get_property(var_block_type, 'supports').array_get('color')
	} else {
		rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_color_support.dup().is_array()))
		&& rt.is_true(rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.dup(), rt.new_string('color')]))))
	{
		return rt.new_array()
	}
	mut var_has_text_colors_support :=
		rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(true), var_color_support))
		|| rt.is_true(rt.new_bool(var_color_support.array_isset(rt.new_string('text'))
		&& rt.is_true(var_color_support.array_get('text'))))))
		|| rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_color_support.dup().is_array()))
		&& !(var_color_support.array_isset(rt.new_string('text')))))
	mut var_has_background_colors_support :=
		rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(true), var_color_support))
		|| rt.is_true(rt.new_bool(var_color_support.array_isset(rt.new_string('background'))
		&& rt.is_true(var_color_support.array_get('background'))))))
		|| rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_color_support.dup().is_array()))
		&& !(var_color_support.array_isset(rt.new_string('background')))))
	mut var_has_gradients_support := if !(var_color_support.array_get('gradients')).is_null() {
		var_color_support.array_get('gradients')
	} else {
		rt.new_bool(false)
	}
	mut var_color_block_styles := rt.new_array()
	if rt.is_true(rt.new_bool(var_has_text_colors_support
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.dup(), rt.new_string('color'), rt.new_string('text')])))))))
	{
		mut var_preset_text_color := if rt.is_true(rt.new_bool(var_block_attributes.dup().array_isset(rt.new_string('textColor')))) {
			rt.concat(rt.new_string('var:preset|color|'),
				var_block_attributes.array_get('textColor'))
		} else {
			rt.new_null()
		}
		mut var_custom_text_color := if !(var_block_attributes.array_get('style').array_get('color').array_get('text')).is_null() {
			var_block_attributes.array_get('style').array_get('color').array_get('text')
		} else {
			rt.new_null()
		}
		var_color_block_styles['text'] = if rt.is_true(var_preset_text_color) {
			var_preset_text_color
		} else {
			var_custom_text_color
		}
	}
	if rt.is_true(rt.new_bool(var_has_background_colors_support
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.dup(), rt.new_string('color'), rt.new_string('background')])))))))
	{
		mut var_preset_background_color := if rt.is_true(rt.new_bool(var_block_attributes.dup().array_isset(rt.new_string('backgroundColor')))) {
			rt.concat(rt.new_string('var:preset|color|'),
				var_block_attributes.array_get('backgroundColor'))
		} else {
			rt.new_null()
		}
		mut var_custom_background_color := if !(var_block_attributes.array_get('style').array_get('color').array_get('background')).is_null() {
			var_block_attributes.array_get('style').array_get('color').array_get('background')
		} else {
			rt.new_null()
		}
		var_color_block_styles['background'] = if rt.is_true(var_preset_background_color) {
			var_preset_background_color
		} else {
			var_custom_background_color
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_has_gradients_support)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.dup(), rt.new_string('color'), rt.new_string('gradients')])))))))
	{
		mut var_preset_gradient_color := if rt.is_true(rt.new_bool(var_block_attributes.dup().array_isset(rt.new_string('gradient')))) {
			rt.concat(rt.new_string('var:preset|gradient|'),
				var_block_attributes.array_get('gradient'))
		} else {
			rt.new_null()
		}
		mut var_custom_gradient_color := if !(var_block_attributes.array_get('style').array_get('color').array_get('gradient')).is_null() {
			var_block_attributes.array_get('style').array_get('color').array_get('gradient')
		} else {
			rt.new_null()
		}
		var_color_block_styles['gradient'] = if rt.is_true(var_preset_gradient_color) {
			var_preset_gradient_color
		} else {
			var_custom_gradient_color
		}
	}
	mut var_attributes := rt.new_array()
	mut var_styles := rt.call_function('wp_style_engine_get_styles', [
		rt.create_array([rt.ArrayItem{ key: 'color', val: var_color_block_styles }]),
		rt.create_array([rt.ArrayItem{ key: 'convert_vars_to_classnames', val: true }]),
	])
	if !(!rt.is_true(var_styles.array_get('classnames'))) {
		var_attributes['class'] = var_styles.array_get('classnames')
	}
	if !(!rt.is_true(var_styles.array_get('css'))) {
		var_attributes['style'] = var_styles.array_get('css')
	}
	return var_attributes.dup()
}

struct Class_WP_Block_Supports {
	rt.PhpObjectBase
}

fn create_wp_block_supports() &Class_WP_Block_Supports {
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

pub fn init_wp_includes_block_supports_colors_php() {
	rt.call_method(fn () rt.PhpVal {
		mut temp := Class_WP_Block_Supports{}
		return temp.get_instance()
	}(), 'register', [rt.new_string('colors'),
		rt.create_array([
			rt.ArrayItem{ key: 'register_attribute', val: 'wp_register_colors_support' },
			rt.ArrayItem{ key: 'apply', val: 'wp_apply_colors_support' },
		])])
}
