import rt

fn wp_register_background_support(var_block_type rt.PhpVal) {
	mut var_has_background_support := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_block_type, 'attributes'))))) {
		rt.set_property(var_block_type, 'attributes', rt.new_array())
	}
	if rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'attributes').array_isset(rt.new_string('style')))) {
		return
	}
	var_has_background_support = rt.call_function('block_has_support', [
		var_block_type.clone(), rt.create_array([
			rt.ArrayItem{ key: none, val: 'background' },
		]),
		rt.new_bool(false)])
	if rt.is_true(var_has_background_support) {
		rt.get_property(var_block_type, 'attributes').array_set('style', rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'object' },
		]))
	}
}

fn wp_render_background_support(var_block_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_block_type := rt.new_null()
	mut var_block_attributes := rt.new_null()
	mut var_has_background_image_support := rt.new_null()
	mut var_background_styles := map[string]rt.PhpVal{}
	mut var_styles := rt.new_null()
	mut var_tags := rt.new_null()
	mut var_existing_style := rt.new_null()
	mut var_separator := ''
	mut var_updated_style := rt.new_null()
	mut iife_temp_0 := Class_WP_Block_Type_Registry{}
	mut iife_result_0 := iife_temp_0.get_instance()
	var_block_type = rt.call_method(iife_result_0, 'get_registered', [
		var_block.array_get(rt.new_string('blockName')),
	])
	var_block_attributes = if var_block.array_isset(rt.new_string('attrs'))
		&& var_block.array_get(rt.new_string('attrs')).is_array() {
		var_block.array_get(rt.new_string('attrs'))
	} else {
		rt.new_array()
	}
	var_has_background_image_support = rt.call_function('block_has_support', [
		var_block_type.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'background' },
			rt.ArrayItem{ key: none, val: 'backgroundImage' },
		]),
		rt.new_bool(false)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_has_background_image_support))))
		|| rt.is_true(rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.clone(), rt.new_string('background'), rt.new_string('backgroundImage')]))
		|| !(var_block_attributes.array_get(rt.new_string('style')).array_isset(rt.new_string('background'))) {
		return var_block_content.clone()
	}
	var_background_styles = rt.new_array()
	var_background_styles['backgroundImage'] = if !(var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('background')).array_get(rt.new_string('backgroundImage'))).is_null() {
		var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('background')).array_get(rt.new_string('backgroundImage'))
	} else {
		rt.new_null()
	}
	var_background_styles['backgroundSize'] = if !(var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('background')).array_get(rt.new_string('backgroundSize'))).is_null() {
		var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('background')).array_get(rt.new_string('backgroundSize'))
	} else {
		rt.new_null()
	}
	var_background_styles['backgroundPosition'] = if !(var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('background')).array_get(rt.new_string('backgroundPosition'))).is_null() {
		var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('background')).array_get(rt.new_string('backgroundPosition'))
	} else {
		rt.new_null()
	}
	var_background_styles['backgroundRepeat'] = if !(var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('background')).array_get(rt.new_string('backgroundRepeat'))).is_null() {
		var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('background')).array_get(rt.new_string('backgroundRepeat'))
	} else {
		rt.new_null()
	}
	var_background_styles['backgroundAttachment'] = if !(var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('background')).array_get(rt.new_string('backgroundAttachment'))).is_null() {
		var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('background')).array_get(rt.new_string('backgroundAttachment'))
	} else {
		rt.new_null()
	}
	if !(!rt.is_true(var_background_styles['backgroundImage'])) {
		var_background_styles['backgroundSize'] = if !(var_background_styles['backgroundSize']).is_null() {
			var_background_styles['backgroundSize']
		} else {
			rt.new_string('cover')
		}
		if rt.is_true(rt.identical(rt.new_string('contain'), var_background_styles['backgroundSize']))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_background_styles['backgroundPosition'])))) {
			var_background_styles['backgroundPosition'] = rt.new_string('50% 50%')
		}
	}
	var_styles = rt.call_function('wp_style_engine_get_styles', [
		rt.create_array([rt.ArrayItem{ key: 'background', val: var_background_styles }]),
	])
	if !(!rt.is_true(var_styles.array_get(rt.new_string('css')))) {
		var_tags = create_wp_html_tag_processor(var_block_content.clone())
		if rt.is_true(var_tags.next_tag()) {
			var_existing_style = var_tags.get_attribute(rt.new_string('style'))
			if var_existing_style.clone().is_string()
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_existing_style)))) {
				var_separator = if rt.is_true(rt.call_function('str_ends_with', [
					var_existing_style.clone(),
					rt.new_string(';'),
				]))
				{ '' } else { ';' }
				var_updated_style = rt.new_string((rt.concat(rt.concat(var_existing_style,
					rt.new_string(var_separator.str())), var_styles.array_get(rt.new_string('css')))).str())
			} else {
				var_updated_style = var_styles.array_get(rt.new_string('css'))
			}
			var_tags.set_attribute(rt.new_string('style'), var_updated_style.clone())
			var_tags.add_class(rt.new_string('has-background'))
		}
		return var_tags.get_updated_html()
	}
	return var_block_content.clone()
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
	rt.call_method(iife_result_1, 'register', [rt.new_string('background'),
		rt.create_array([
			rt.ArrayItem{ key: 'register_attribute', val: 'wp_register_background_support' },
		])])
	rt.call_function('add_filter', [rt.new_string('render_block'),
		rt.new_string('wp_render_background_support'), rt.new_int(10),
		rt.new_int(2)])
}
