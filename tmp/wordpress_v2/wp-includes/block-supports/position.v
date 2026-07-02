import rt

fn wp_register_position_support(var_block_type rt.PhpVal) {
	mut var_has_position_support := rt.new_null()
	var_has_position_support = rt.call_function('block_has_support', [
		var_block_type.clone(), rt.new_string('position'), rt.new_bool(false)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_block_type, 'attributes'))))) {
		rt.set_property(var_block_type, 'attributes', rt.new_array())
	}
	if rt.is_true(var_has_position_support)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'attributes').array_isset(rt.new_string('style'))))))) {
		rt.get_property(var_block_type, 'attributes').array_set('style', rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'object' },
		]))
	}
}

fn wp_render_position_support(var_block_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_block_type := rt.new_null()
	mut var_has_position_support := rt.new_null()
	mut var_global_settings := rt.new_null()
	mut var_theme_has_sticky_support := rt.new_null()
	mut var_theme_has_fixed_support := rt.new_null()
	mut var_allowed_position_types := []rt.PhpVal{}
	mut var_style_attribute := rt.new_null()
	mut var_class_name := rt.new_null()
	mut var_selector := ''
	mut var_position_styles := []rt.PhpVal{}
	mut var_position_type := rt.new_null()
	mut var_wrapper_classes := []rt.PhpVal{}
	mut var_sides := []rt.PhpVal{}
	mut var_side := rt.new_null()
	mut var_side_value := rt.new_null()
	mut var_content := rt.new_null()
	mut var_class := rt.new_null()
	mut iife_temp_0 := Class_WP_Block_Type_Registry{}
	mut iife_result_0 := iife_temp_0.get_instance()
	var_block_type = rt.call_method(iife_result_0, 'get_registered', [
		var_block.array_get(rt.new_string('blockName')),
	])
	var_has_position_support = rt.call_function('block_has_support', [
		var_block_type.clone(), rt.new_string('position'), rt.new_bool(false)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_has_position_support))))
		|| !rt.is_true(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('style')).array_get(rt.new_string('position'))) {
		return var_block_content.str()
	}
	var_global_settings = rt.call_function('wp_get_global_settings', []rt.PhpVal{})
	var_theme_has_sticky_support = if !(var_global_settings.array_get(rt.new_string('position')).array_get(rt.new_string('sticky'))).is_null() {
		var_global_settings.array_get(rt.new_string('position')).array_get(rt.new_string('sticky'))
	} else {
		rt.new_bool(false)
	}
	var_theme_has_fixed_support = if !(var_global_settings.array_get(rt.new_string('position')).array_get(rt.new_string('fixed'))).is_null() {
		var_global_settings.array_get(rt.new_string('position')).array_get(rt.new_string('fixed'))
	} else {
		rt.new_bool(false)
	}
	var_allowed_position_types = rt.new_array()
	if rt.is_true(rt.identical(rt.new_bool(true), var_theme_has_sticky_support)) {
		var_allowed_position_types << 'sticky'
	}
	if rt.is_true(rt.identical(rt.new_bool(true), var_theme_has_fixed_support)) {
		var_allowed_position_types << 'fixed'
	}
	var_style_attribute = if !(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('style'))).is_null() {
		var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('style'))
	} else {
		rt.new_null()
	}
	var_class_name = rt.call_function('wp_unique_id', [rt.new_string('wp-container-')])
	var_selector = '.${var_class_name.to_string()}'
	var_position_styles = rt.new_array()
	var_position_type = if !(var_style_attribute.array_get(rt.new_string('position')).array_get(rt.new_string('type'))).is_null() {
		var_style_attribute.array_get(rt.new_string('position')).array_get(rt.new_string('type'))
	} else {
		rt.new_string('')
	}
	var_wrapper_classes = rt.new_array()
	if rt.is_true(rt.call_function('in_array', [var_position_type.clone(),
		rt.create_array_from_list(var_allowed_position_types),
		rt.new_bool(true)]))
	{
		var_wrapper_classes << var_class_name.clone()
		var_wrapper_classes << 'is-position-' + var_position_type.str()
		var_sides = ['top', 'right', 'bottom', 'left']
		for var_side_shadow in var_sides {
			var_side_value = if !(var_style_attribute.array_get(rt.new_string('position')).array_get(rt.new_string(var_side_shadow.str()))).is_null() {
				var_style_attribute.array_get(rt.new_string('position')).array_get(rt.new_string(var_side_shadow.str()))
			} else {
				rt.new_null()
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_side_value)))) {
				if rt.is_true(rt.identical(rt.new_string('top'), rt.new_string(var_side_shadow.str())))
					&& rt.is_true(rt.identical(rt.new_string('fixed'), var_position_type))
					|| rt.is_true(rt.identical(rt.new_string('sticky'), var_position_type)) {
					if rt.is_true(rt.identical(rt.new_string('0'), var_side_value))
						|| rt.is_true(rt.identical(rt.new_int(0), var_side_value)) {
						var_side_value = rt.new_string('0px')
					}
					var_side_value =
						rt.new_string('calc(${var_side_value.to_string()} + var(--wp-admin--admin-bar--position-offset, 0px))')
				}
				var_position_styles << rt.create_array([
					rt.ArrayItem{ key: 'selector', val: var_selector },
					rt.ArrayItem{ key: 'declarations', val: rt.create_array([
						rt.ArrayItem{ key: rt.new_string(var_side_shadow.str()), val: var_side_value },
					]) },
				])
			}
		}
		var_position_styles << rt.create_array([
			rt.ArrayItem{ key: 'selector', val: var_selector },
			rt.ArrayItem{ key: 'declarations', val: rt.create_array([
				rt.ArrayItem{ key: 'position', val: var_position_type },
				rt.ArrayItem{ key: 'z-index', val: '10' },
			]) },
		])
	}
	if !(!rt.is_true(var_position_styles)) {
		rt.call_function('wp_style_engine_get_stylesheet_from_css_rules', [
			rt.create_array_from_list(var_position_styles),
			rt.create_array([rt.ArrayItem{ key: 'context', val: 'block-supports' },
				rt.ArrayItem{ key: 'prettify', val: false }]),
		])
		var_content = create_wp_html_tag_processor(var_block_content.clone())
		var_content.next_tag()
		for var_class_shadow in var_wrapper_classes {
			var_content.add_class(var_class_shadow.clone())
		}
		return var_content.str()
	}
	return var_block_content.str()
}

struct Class_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_WP_Block_Supports {
	rt.PhpObjectBase
}

fn create_wp_block_type_registry(_args ...rt.PhpVal) &Class_WP_Block_Type_Registry {
	mut obj := &Class_WP_Block_Type_Registry{
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

fn create_wp_block_supports(_args ...rt.PhpVal) &Class_WP_Block_Supports {
	mut obj := &Class_WP_Block_Supports{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Type_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

	mut iife_temp_1 := Class_WP_Block_Supports{}
	mut iife_result_1 := iife_temp_1.get_instance()
	rt.call_method(iife_result_1, 'register', [rt.new_string('position'),
		rt.create_array([
			rt.ArrayItem{ key: 'register_attribute', val: 'wp_register_position_support' },
		])])
	rt.call_function('add_filter', [rt.new_string('render_block'),
		rt.new_string('wp_render_position_support'), rt.new_int(10),
		rt.new_int(2)])
}
