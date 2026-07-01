import rt

fn wp_register_background_support(var_block_type rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_block_type, 'attributes'))))) {
		rt.set_property(var_block_type, 'attributes', rt.new_array())
	}
	if rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'attributes').array_isset(rt.new_string('style')))) {
		return rt.new_null()
	}
	mut var_has_background_support := rt.call_function('block_has_support', [var_block_type.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'background' }]), rt.new_bool(false)])
	if rt.is_true(var_has_background_support) {
		rt.get_property(var_block_type, 'attributes').array_set('style', rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }]))
	}
}

fn wp_render_background_support(var_block_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_block_type := rt.call_method(fn () rt.PhpVal { mut temp := Class_WP_Block_Type_Registry{}; return temp.get_instance() }(), 'get_registered', [var_block.array_get('blockName')])
	mut var_block_attributes := if rt.is_true(rt.new_bool(var_block.array_isset(rt.new_string('attrs')) && rt.is_true(rt.new_bool(var_block.array_get('attrs').is_array())))) { var_block.array_get('attrs') } else { rt.new_array() }
	mut var_has_background_image_support := rt.call_function('block_has_support', [var_block_type.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'background' }, rt.ArrayItem{ key: none, val: 'backgroundImage' }]), rt.new_bool(false)])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_has_background_image_support)))) || rt.is_true(rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.dup(), rt.new_string('background'), rt.new_string('backgroundImage')])))) || !(var_block_attributes.array_get('style').array_isset(rt.new_string('background'))))) {
		return var_block_content.dup()
	}
	mut var_background_styles := rt.new_array()
	var_background_styles['backgroundImage'] = if !(var_block_attributes.array_get('style').array_get('background').array_get('backgroundImage')).is_null() { var_block_attributes.array_get('style').array_get('background').array_get('backgroundImage') } else { rt.new_null() }
	var_background_styles['backgroundSize'] = if !(var_block_attributes.array_get('style').array_get('background').array_get('backgroundSize')).is_null() { var_block_attributes.array_get('style').array_get('background').array_get('backgroundSize') } else { rt.new_null() }
	var_background_styles['backgroundPosition'] = if !(var_block_attributes.array_get('style').array_get('background').array_get('backgroundPosition')).is_null() { var_block_attributes.array_get('style').array_get('background').array_get('backgroundPosition') } else { rt.new_null() }
	var_background_styles['backgroundRepeat'] = if !(var_block_attributes.array_get('style').array_get('background').array_get('backgroundRepeat')).is_null() { var_block_attributes.array_get('style').array_get('background').array_get('backgroundRepeat') } else { rt.new_null() }
	var_background_styles['backgroundAttachment'] = if !(var_block_attributes.array_get('style').array_get('background').array_get('backgroundAttachment')).is_null() { var_block_attributes.array_get('style').array_get('background').array_get('backgroundAttachment') } else { rt.new_null() }
	if !(!rt.is_true(var_background_styles.array_get('backgroundImage'))) {
		var_background_styles['backgroundSize'] = if !(var_background_styles.array_get('backgroundSize')).is_null() { var_background_styles.array_get('backgroundSize') } else { rt.new_string('cover') }
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('contain'), var_background_styles.array_get('backgroundSize'))) && rt.is_true(rt.new_bool(!(rt.is_true(var_background_styles.array_get('backgroundPosition'))))))) {
			var_background_styles['backgroundPosition'] = rt.new_string('50% 50%')
		}
	}
	mut var_styles := rt.call_function('wp_style_engine_get_styles', [rt.create_array([rt.ArrayItem{ key: 'background', val: var_background_styles }])])
	if !(!rt.is_true(var_styles.array_get('css'))) {
		mut var_tags := create_wp_html_tag_processor(var_block_content.dup())
		if rt.is_true(var_tags.next_tag()) {
			mut var_existing_style := var_tags.get_attribute(rt.new_string('style'))
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_existing_style.dup().is_string())) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				mut var_separator := if rt.is_true(rt.call_function('str_ends_with', [var_existing_style.dup(), rt.new_string(';')])) { '' } else { ';' }
				mut var_updated_style := rt.new_string(rt.concat(rt.concat(var_existing_style, rt.new_string(var_separator)), var_styles.array_get('css')))
			} else {
				var_updated_style = var_styles.array_get('css')
			}
			var_tags.set_attribute(rt.new_string('style'), var_updated_style.dup())
			var_tags.add_class(rt.new_string('has-background'))
		}
		return var_tags.get_updated_html()
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




pub fn init_wp_includes_block_supports_background_php() {
	rt.call_method(fn () rt.PhpVal { mut temp := Class_WP_Block_Supports{}; return temp.get_instance() }(), 'register', [rt.new_string('background'), rt.create_array([rt.ArrayItem{ key: 'register_attribute', val: 'wp_register_background_support' }])])
	rt.call_function('add_filter', [rt.new_string('render_block'), rt.new_string('wp_render_background_support'), rt.new_int(10), rt.new_int(2)])
}
