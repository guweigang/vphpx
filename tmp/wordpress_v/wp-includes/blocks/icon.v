import rt

fn render_block_core_icon(var_attributes rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_attributes.array_get('icon')) {
		return rt.new_null()
	}
	mut var_registry := fn () rt.PhpVal {
		mut temp := Class_WP_Icons_Registry{}
		return temp.get_instance()
	}()
	mut var_icon := rt.call_method(var_registry, 'get_registered_icon', [
		var_attributes.array_get('icon'),
	])
	if rt.is_true(rt.new_bool(var_icon.dup().is_null())) {
		return rt.new_null()
	}
	mut var_color_styles := map[string]rt.PhpVal{}
	mut var_preset_text_color := if rt.is_true(rt.new_bool(var_attributes.dup().array_isset(rt.new_string('textColor')))) {
		rt.concat(rt.new_string('var:preset|color|'), var_attributes.array_get('textColor'))
	} else {
		rt.new_null()
	}
	mut var_custom_text_color := if !(var_attributes.array_get('style').array_get('color').array_get('text')).is_null() {
		var_attributes.array_get('style').array_get('color').array_get('text')
	} else {
		rt.new_null()
	}
	var_color_styles['text'] = if rt.is_true(var_preset_text_color) {
		var_preset_text_color
	} else {
		var_custom_text_color
	}
	mut var_preset_background_color := if rt.is_true(rt.new_bool(var_attributes.dup().array_isset(rt.new_string('backgroundColor')))) {
		rt.concat(rt.new_string('var:preset|color|'), var_attributes.array_get('backgroundColor'))
	} else {
		rt.new_null()
	}
	mut var_custom_background_color := if !(var_attributes.array_get('style').array_get('color').array_get('background')).is_null() {
		var_attributes.array_get('style').array_get('color').array_get('background')
	} else {
		rt.new_null()
	}
	var_color_styles['background'] = if rt.is_true(var_preset_background_color) {
		var_preset_background_color
	} else {
		var_custom_background_color
	}
	mut var_border_styles := map[string]rt.PhpVal{}
	mut var_sides := ['top', 'right', 'bottom', 'left']
	if var_attributes.array_get('style').array_get('border').array_isset(rt.new_string('radius')) {
		var_border_styles.array_set('radius',
			var_attributes.array_get('style').array_get('border').array_get('radius'))
	}
	if var_attributes.array_get('style').array_get('border').array_isset(rt.new_string('style')) {
		var_border_styles.array_set('style',
			var_attributes.array_get('style').array_get('border').array_get('style'))
	}
	if var_attributes.array_get('style').array_get('border').array_isset(rt.new_string('width')) {
		var_border_styles.array_set('width',
			var_attributes.array_get('style').array_get('border').array_get('width'))
	}
	mut var_preset_color := if rt.is_true(rt.new_bool(var_attributes.dup().array_isset(rt.new_string('borderColor')))) {
		rt.concat(rt.new_string('var:preset|color|'), var_attributes.array_get('borderColor'))
	} else {
		rt.new_null()
	}
	mut var_custom_color := if !(var_attributes.array_get('style').array_get('border').array_get('color')).is_null() {
		var_attributes.array_get('style').array_get('border').array_get('color')
	} else {
		rt.new_null()
	}
	var_border_styles.array_set('color', if rt.is_true(var_preset_color) {
		var_preset_color
	} else {
		var_custom_color
	})
	for var_side in var_sides {
		mut var_border := if !(var_attributes.array_get('style').array_get('border').array_get(side)).is_null() {
			var_attributes.array_get('style').array_get('border').array_get(side)
		} else {
			rt.new_null()
		}
		var_border_styles.array_set(side, rt.create_array([
			rt.ArrayItem{
				key: 'color'
				val: if !(var_border.array_get('color')).is_null() {
					var_border.array_get('color')
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'style'
				val: if !(var_border.array_get('style')).is_null() {
					var_border.array_get('style')
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'width'
				val: if !(var_border.array_get('width')).is_null() {
					var_border.array_get('width')
				} else {
					rt.new_null()
				}
			},
		]))
	}
	mut var_spacing_styles := map[string]rt.PhpVal{}
	if var_attributes.array_get('style').array_get('spacing').array_isset(rt.new_string('padding')) {
		var_spacing_styles['padding'] =
			var_attributes.array_get('style').array_get('spacing').array_get('padding')
	}
	mut var_dimensions_styles := map[string]rt.PhpVal{}
	if var_attributes.array_get('style').array_get('dimensions').array_isset(rt.new_string('width')) {
		var_dimensions_styles['width'] =
			var_attributes.array_get('style').array_get('dimensions').array_get('width')
	}
	mut var_styles := rt.call_function('wp_style_engine_get_styles', [
		rt.create_array([rt.ArrayItem{ key: 'color', val: var_color_styles },
			rt.ArrayItem{ key: 'border', val: var_border_styles },
			rt.ArrayItem{ key: 'spacing', val: var_spacing_styles },
			rt.ArrayItem{ key: 'dimensions', val: var_dimensions_styles }]),
	])
	mut var_processor := create_wp_html_tag_processor(var_icon.array_get('content'))
	var_processor.next_tag(rt.new_string('svg'))
	if !(!rt.is_true(var_styles.array_get('css'))) {
		var_processor.set_attribute(rt.new_string('style'), var_styles.array_get('css'))
	}
	if !(!rt.is_true(var_styles.array_get('classnames'))) {
		var_processor.add_class(var_styles.array_get('classnames'))
	}
	mut var_aria_label := if !(!rt.is_true(var_attributes.array_get('ariaLabel'))) {
		var_attributes.array_get('ariaLabel')
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_aria_label)))) {
		var_processor.set_attribute(rt.new_string('aria-hidden'), rt.new_string('true'))
		var_processor.set_attribute(rt.new_string('focusable'), rt.new_string('false'))
	} else {
		var_processor.set_attribute(rt.new_string('role'), rt.new_string('img'))
		var_processor.set_attribute(rt.new_string('aria-label'), var_aria_label.dup())
	}
	mut var_svg := var_processor.get_updated_html()
	var_attributes = rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{})
	return rt.call_function('sprintf', [rt.new_string('<div %s>%s</div>'),
		var_attributes.dup(), var_svg.dup()])
}

fn register_block_core_icon() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/icon',
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

fn create_wp_icons_registry() &Class_WP_Icons_Registry {
	mut obj := &Class_WP_Icons_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_html_tag_processor() &Class_WP_HTML_Tag_Processor {
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

pub fn init_wp_includes_blocks_icon_php() {
	rt.call_function('add_action',
		[rt.new_string('init'), rt.new_string('register_block_core_icon')])
}
