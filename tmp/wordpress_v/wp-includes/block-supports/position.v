import rt

fn wp_register_position_support(var_block_type rt.PhpVal) {
	mut var_has_position_support := rt.call_function('block_has_support', [var_block_type.dup(), rt.new_string('position'), rt.new_bool(false)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_block_type, 'attributes'))))) {
		rt.set_property(var_block_type, 'attributes', rt.new_array())
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_has_position_support) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'attributes').array_isset(rt.new_string('style'))))))))) {
		rt.get_property(var_block_type, 'attributes').array_set('style', rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }]))
	}
}

fn wp_render_position_support(var_block_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_block_type := rt.call_method(fn () rt.PhpVal { mut temp := Class_WP_Block_Type_Registry{}; return temp.get_instance() }(), 'get_registered', [var_block.array_get('blockName')])
	mut var_has_position_support := rt.call_function('block_has_support', [var_block_type.dup(), rt.new_string('position'), rt.new_bool(false)])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_has_position_support)))) || !rt.is_true(var_block.array_get('attrs').array_get('style').array_get('position')))) {
		return var_block_content.dup()
	}
	mut var_global_settings := rt.call_function('wp_get_global_settings', []rt.PhpVal{})
	mut var_theme_has_sticky_support := if !(var_global_settings.array_get('position').array_get('sticky')).is_null() { var_global_settings.array_get('position').array_get('sticky') } else { rt.new_bool(false) }
	mut var_theme_has_fixed_support := if !(var_global_settings.array_get('position').array_get('fixed')).is_null() { var_global_settings.array_get('position').array_get('fixed') } else { rt.new_bool(false) }
	mut var_allowed_position_types := rt.new_array()
	if rt.is_true(rt.identical(rt.new_bool(true), var_theme_has_sticky_support)) {
		var_allowed_position_types << 'sticky'
	}
	if rt.is_true(rt.identical(rt.new_bool(true), var_theme_has_fixed_support)) {
		var_allowed_position_types << 'fixed'
	}
	mut var_style_attribute := if !(var_block.array_get('attrs').array_get('style')).is_null() { var_block.array_get('attrs').array_get('style') } else { rt.new_null() }
	mut var_class_name := rt.call_function('wp_unique_id', [rt.new_string('wp-container-')])
	mut var_selector := ".${var_class_name.to_string()}"
	mut var_position_styles := rt.new_array()
	mut var_position_type := if !(var_style_attribute.array_get('position').array_get('type')).is_null() { var_style_attribute.array_get('position').array_get('type') } else { rt.new_string('') }
	mut var_wrapper_classes := rt.new_array()
	if rt.is_true(rt.call_function('in_array', [var_position_type.dup(), var_allowed_position_types.dup(), rt.new_bool(true)])) {
		var_wrapper_classes << var_class_name.dup()
		var_wrapper_classes << 'is-position-' + (var_position_type).str()
		mut var_sides := ['top', 'right', 'bottom', 'left']
		for var_side in var_sides {
			mut var_side_value := if !(var_style_attribute.array_get('position').array_get(side)).is_null() { var_style_attribute.array_get('position').array_get(side) } else { rt.new_null() }
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('top'), rt.new_string(side))) && rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('fixed'), var_position_type)) || rt.is_true(rt.identical(rt.new_string('sticky'), var_position_type)))))) {
					if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('0'), var_side_value)) || rt.is_true(rt.identical(rt.new_int(0), var_side_value)))) {
						var_side_value = rt.new_string(rt.new_string('0px'))
					}
					var_side_value = rt.new_string(rt.new_string("calc(${var_side_value.to_string()} + var(--wp-admin--admin-bar--position-offset, 0px))"))
				}
				var_position_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: var_selector }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: side, val: var_side_value }]) }])
			}
		}
		var_position_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: var_selector }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'position', val: var_position_type }, rt.ArrayItem{ key: 'z-index', val: '10' }]) }])
	}
	if !(!rt.is_true(var_position_styles)) {
		rt.call_function('wp_style_engine_get_stylesheet_from_css_rules', [var_position_styles.dup(), rt.create_array([rt.ArrayItem{ key: 'context', val: 'block-supports' }, rt.ArrayItem{ key: 'prettify', val: false }])])
		mut var_content := create_wp_html_tag_processor(var_block_content.dup())
		var_content.next_tag()
		for var_class in var_wrapper_classes {
			var_content.add_class(var_class.dup())
		}
		return // unsupported expression: Expr_Cast_String
	}
	return var_block_content.dup()
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

fn create_wp_block_type_registry() &Class_WP_Block_Type_Registry {
	mut obj := &Class_WP_Block_Type_Registry{
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

fn create_wp_block_supports() &Class_WP_Block_Supports {
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




pub fn init_wp_includes_block_supports_position_php() {
	rt.call_method(fn () rt.PhpVal { mut temp := Class_WP_Block_Supports{}; return temp.get_instance() }(), 'register', [rt.new_string('position'), rt.create_array([rt.ArrayItem{ key: 'register_attribute', val: 'wp_register_position_support' }])])
	rt.call_function('add_filter', [rt.new_string('render_block'), rt.new_string('wp_render_position_support'), rt.new_int(10), rt.new_int(2)])
}
