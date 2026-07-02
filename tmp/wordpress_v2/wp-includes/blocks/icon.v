import rt

fn render_block_core_icon(var_attributes_arg rt.PhpVal) rt.PhpVal {
	mut var_attributes := var_attributes_arg
	mut var_registry := rt.new_null()
	mut var_icon := rt.new_null()
	mut var_color_styles := map[string]rt.PhpVal{}
	mut var_preset_text_color := rt.new_null()
	mut var_custom_text_color := rt.new_null()
	mut var_preset_background_color := rt.new_null()
	mut var_custom_background_color := rt.new_null()
	mut var_border_styles := rt.new_null()
	mut var_sides := []rt.PhpVal{}
	mut var_preset_color := rt.new_null()
	mut var_custom_color := rt.new_null()
	mut var_side := rt.new_null()
	mut var_border := rt.new_null()
	mut var_spacing_styles := map[string]rt.PhpVal{}
	mut var_dimensions_styles := map[string]rt.PhpVal{}
	mut var_styles := rt.new_null()
	mut var_processor := rt.new_null()
	mut var_aria_label := rt.new_null()
	mut var_svg := rt.new_null()
	if !rt.is_true(var_attributes.array_get(rt.new_string('icon'))) {
		return rt.new_null()
	}
	mut iife_temp_0 := Class_WP_Icons_Registry{}
	mut iife_result_0 := iife_temp_0.get_instance()
	var_registry = iife_result_0
	var_icon = rt.call_method(var_registry, 'get_registered_icon', [
		var_attributes.array_get(rt.new_string('icon')),
	])
	if rt.is_true(rt.new_bool(var_icon.clone().is_null())) {
		return rt.new_null()
	}
	var_color_styles = map[string]rt.PhpVal{}
	var_preset_text_color = if rt.is_true(rt.new_bool(var_attributes.clone().array_isset(rt.new_string('textColor')))) {
		rt.concat(rt.new_string('var:preset|color|'),
			var_attributes.array_get(rt.new_string('textColor')))
	} else {
		rt.new_null()
	}
	var_custom_text_color = if !(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('text'))).is_null() {
		var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('text'))
	} else {
		rt.new_null()
	}
	var_color_styles['text'] = if rt.is_true(var_preset_text_color) {
		var_preset_text_color
	} else {
		var_custom_text_color
	}
	var_preset_background_color = if rt.is_true(rt.new_bool(var_attributes.clone().array_isset(rt.new_string('backgroundColor')))) {
		rt.concat(rt.new_string('var:preset|color|'),
			var_attributes.array_get(rt.new_string('backgroundColor')))
	} else {
		rt.new_null()
	}
	var_custom_background_color = if !(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('background'))).is_null() {
		var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('background'))
	} else {
		rt.new_null()
	}
	var_color_styles['background'] = if rt.is_true(var_preset_background_color) {
		var_preset_background_color
	} else {
		var_custom_background_color
	}
	var_border_styles = map[string]rt.PhpVal{}
	var_sides = ['top', 'right', 'bottom', 'left']
	if var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_isset(rt.new_string('radius')) {
		var_border_styles.array_set('radius',
			var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string('radius')))
	}
	if var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_isset(rt.new_string('style')) {
		var_border_styles.array_set('style',
			var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string('style')))
	}
	if var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_isset(rt.new_string('width')) {
		var_border_styles.array_set('width',
			var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string('width')))
	}
	var_preset_color = if rt.is_true(rt.new_bool(var_attributes.clone().array_isset(rt.new_string('borderColor')))) {
		rt.concat(rt.new_string('var:preset|color|'),
			var_attributes.array_get(rt.new_string('borderColor')))
	} else {
		rt.new_null()
	}
	var_custom_color = if !(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string('color'))).is_null() {
		var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string('color'))
	} else {
		rt.new_null()
	}
	var_border_styles.array_set('color', if rt.is_true(var_preset_color) {
		var_preset_color
	} else {
		var_custom_color
	})
	for var_side_shadow in var_sides {
		var_border = if !(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string(var_side_shadow.str()))).is_null() {
			var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string(var_side_shadow.str()))
		} else {
			rt.new_null()
		}
		var_border_styles.array_set(rt.new_string(var_side_shadow.str()), rt.create_array([
			rt.ArrayItem{
				key: 'color'
				val: if !(var_border.array_get(rt.new_string('color'))).is_null() {
					var_border.array_get(rt.new_string('color'))
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'style'
				val: if !(var_border.array_get(rt.new_string('style'))).is_null() {
					var_border.array_get(rt.new_string('style'))
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'width'
				val: if !(var_border.array_get(rt.new_string('width'))).is_null() {
					var_border.array_get(rt.new_string('width'))
				} else {
					rt.new_null()
				}
			},
		]))
	}
	var_spacing_styles = map[string]rt.PhpVal{}
	if var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('spacing')).array_isset(rt.new_string('padding')) {
		var_spacing_styles['padding'] =
			var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('spacing')).array_get(rt.new_string('padding'))
	}
	var_dimensions_styles = map[string]rt.PhpVal{}
	if var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('dimensions')).array_isset(rt.new_string('width')) {
		var_dimensions_styles['width'] =
			var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('dimensions')).array_get(rt.new_string('width'))
	}
	var_styles = rt.call_function('wp_style_engine_get_styles', [
		rt.create_array([rt.ArrayItem{ key: 'color', val: var_color_styles },
			rt.ArrayItem{ key: 'border', val: var_border_styles },
			rt.ArrayItem{ key: 'spacing', val: var_spacing_styles },
			rt.ArrayItem{ key: 'dimensions', val: var_dimensions_styles }]),
	])
	var_processor = create_wp_html_tag_processor(var_icon.array_get(rt.new_string('content')))
	var_processor.next_tag(rt.new_string('svg'))
	if !(!rt.is_true(var_styles.array_get(rt.new_string('css')))) {
		var_processor.set_attribute(rt.new_string('style'),
			var_styles.array_get(rt.new_string('css')))
	}
	if !(!rt.is_true(var_styles.array_get(rt.new_string('classnames')))) {
		var_processor.add_class(var_styles.array_get(rt.new_string('classnames')))
	}
	var_aria_label = if !(!rt.is_true(var_attributes.array_get(rt.new_string('ariaLabel')))) {
		var_attributes.array_get(rt.new_string('ariaLabel'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_aria_label)))) {
		var_processor.set_attribute(rt.new_string('aria-hidden'), rt.new_string('true'))
		var_processor.set_attribute(rt.new_string('focusable'), rt.new_string('false'))
	} else {
		var_processor.set_attribute(rt.new_string('role'), rt.new_string('img'))
		var_processor.set_attribute(rt.new_string('aria-label'), var_aria_label.clone())
	}
	var_svg = var_processor.get_updated_html()
	var_attributes = rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{})
	return rt.call_function('sprintf', [rt.new_string('<div %s>%s</div>'),
		var_attributes.clone(), var_svg.clone()])
}

fn register_block_core_icon() {
	rt.call_function('register_block_type_from_metadata', [rt.new_string(@DIR + '/icon'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_icon' },
		])])
}

struct Class_WP_Icons_Registry {
	rt.PhpObjectBase
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_wp_icons_registry(_args ...rt.PhpVal) &Class_WP_Icons_Registry {
	mut obj := &Class_WP_Icons_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_html_tag_processor(_args ...rt.PhpVal) &Class_WP_HTML_Tag_Processor {
	mut obj := &Class_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Icons_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Icons_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Icons_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action',
		[rt.new_string('init'), rt.new_string('register_block_core_icon')])
}
