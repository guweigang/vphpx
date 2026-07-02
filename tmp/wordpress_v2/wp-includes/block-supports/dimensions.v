import rt

fn wp_register_dimensions_support(var_block_type rt.PhpVal) {
	mut var_has_dimensions_support := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_block_type, 'attributes'))))) {
		rt.set_property(var_block_type, 'attributes', rt.new_array())
	}
	if rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'attributes').array_isset(rt.new_string('style')))) {
		return
	}
	var_has_dimensions_support = rt.call_function('block_has_support', [
		var_block_type.clone(), rt.new_string('dimensions'), rt.new_bool(false)])
	if rt.is_true(var_has_dimensions_support) {
		rt.get_property(var_block_type, 'attributes').array_set('style', rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'object' },
		]))
	}
}

fn wp_apply_dimensions_support(var_block_type rt.PhpVal, var_block_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes := map[string]rt.PhpVal{}
	mut var_block_styles := rt.new_null()
	mut var_dimensions_block_styles := rt.new_null()
	mut var_supported_features := []rt.PhpVal{}
	mut var_feature := rt.new_null()
	mut var_has_support := rt.new_null()
	mut var_skip_serialization := rt.new_null()
	mut var_styles := rt.new_null()
	var_attributes = rt.new_array()
	if rt.is_true(rt.call_function('wp_should_skip_block_supports_serialization', [
		var_block_type.clone(),
		rt.new_string('dimensions'),
	]))
	{
		return var_attributes.clone()
	}
	var_block_styles = if !(var_block_attributes.array_get(rt.new_string('style'))).is_null() {
		var_block_attributes.array_get(rt.new_string('style'))
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_block_styles)))) {
		return var_attributes.clone()
	}
	var_dimensions_block_styles = rt.new_array()
	var_supported_features = ['minHeight', 'height', 'width']
	for var_feature_shadow in var_supported_features {
		var_has_support = rt.call_function('block_has_support', [
			var_block_type.clone(),
			rt.create_array([
				rt.ArrayItem{ key: none, val: 'dimensions' },
				rt.ArrayItem{ key: none, val: rt.new_string(var_feature_shadow.str()) },
			]),
			rt.new_bool(false)])
		var_skip_serialization = rt.call_function('wp_should_skip_block_supports_serialization', [
			var_block_type.clone(),
			rt.new_string('dimensions'),
			rt.new_string(var_feature_shadow.str()).clone(),
		])
		var_dimensions_block_styles.array_set(rt.new_string(var_feature_shadow.str()),
			rt.new_null())
		if rt.is_true(var_has_support)
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_skip_serialization)))) {
			var_dimensions_block_styles.array_set(rt.new_string(var_feature_shadow.str()), if !(var_block_styles.array_get(rt.new_string('dimensions')).array_get(rt.new_string(var_feature_shadow.str()))).is_null() {
				var_block_styles.array_get(rt.new_string('dimensions')).array_get(rt.new_string(var_feature_shadow.str()))
			} else {
				rt.new_null()
			})
		}
	}
	var_styles = rt.call_function('wp_style_engine_get_styles', [
		rt.create_array([
			rt.ArrayItem{ key: 'dimensions', val: var_dimensions_block_styles },
		]),
	])
	if !(!rt.is_true(var_styles.array_get(rt.new_string('css')))) {
		var_attributes['style'] = var_styles.array_get(rt.new_string('css'))
	}
	return var_attributes.clone()
}

fn wp_render_dimensions_support(var_block_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_block_type := rt.new_null()
	mut var_block_attributes := rt.new_null()
	mut var_has_aspect_ratio_support := rt.new_null()
	mut var_dimensions_block_styles := rt.new_null()
	mut var_styles := rt.new_null()
	mut var_tags := rt.new_null()
	mut var_existing_style := rt.new_null()
	mut var_updated_style := rt.new_null()
	mut var_class_name := rt.new_null()
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
	var_has_aspect_ratio_support = rt.call_function('block_has_support', [
		var_block_type.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'dimensions' },
			rt.ArrayItem{ key: none, val: 'aspectRatio' },
		]),
		rt.new_bool(false)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_has_aspect_ratio_support))))
		|| rt.is_true(rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.clone(), rt.new_string('dimensions'), rt.new_string('aspectRatio')])) {
		return var_block_content.clone()
	}
	var_dimensions_block_styles = rt.new_array()
	var_dimensions_block_styles.array_set('aspectRatio', if !(var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('dimensions')).array_get(rt.new_string('aspectRatio'))).is_null() {
		var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('dimensions')).array_get(rt.new_string('aspectRatio'))
	} else {
		rt.new_null()
	})
	if var_dimensions_block_styles.array_isset(rt.new_string('aspectRatio')) {
		var_dimensions_block_styles.array_set('minHeight', 'unset')
	} else if
		var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('dimensions')).array_isset(rt.new_string('minHeight'))
		|| var_block_attributes.array_isset(rt.new_string('minHeight')) {
		var_dimensions_block_styles.array_set('aspectRatio', 'unset')
	}
	var_styles = rt.call_function('wp_style_engine_get_styles', [
		rt.create_array([
			rt.ArrayItem{ key: 'dimensions', val: var_dimensions_block_styles },
		]),
	])
	if !(!rt.is_true(var_styles.array_get(rt.new_string('css')))) {
		var_tags = create_wp_html_tag_processor(var_block_content.clone())
		if rt.is_true(var_tags.next_tag()) {
			var_existing_style = var_tags.get_attribute(rt.new_string('style'))
			var_updated_style = rt.new_string('')
			if !(!rt.is_true(var_existing_style)) {
				var_updated_style = var_existing_style.clone()
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_ends_with', [
					var_existing_style.clone(),
					rt.new_string(';'),
				])))))
				{
					var_updated_style = rt.concat(var_updated_style, rt.new_string(';'))
				}
			}
			var_updated_style = rt.concat(var_updated_style,
				var_styles.array_get(rt.new_string('css')))
			var_tags.set_attribute(rt.new_string('style'), var_updated_style.clone())
			if !(!rt.is_true(var_styles.array_get(rt.new_string('classnames')))) {
				mut iter_1 := rt.call_function('explode', [rt.new_string(' '),
					var_styles.array_get(rt.new_string('classnames'))]).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_class_name_shadow := item_1.val
					if rt.is_true(rt.call_function('str_contains', [var_class_name_shadow.clone(), rt.new_string('aspect-ratio')]))
						&& !(var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('dimensions')).array_isset(rt.new_string('aspectRatio'))) {
						continue
					}
					var_tags.add_class(var_class_name_shadow.clone())
				}
			}
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

	rt.call_function('add_filter', [rt.new_string('render_block'),
		rt.new_string('wp_render_dimensions_support'), rt.new_int(10),
		rt.new_int(2)])
	mut iife_temp_1 := Class_WP_Block_Supports{}
	mut iife_result_1 := iife_temp_1.get_instance()
	rt.call_method(iife_result_1, 'register', [rt.new_string('dimensions'),
		rt.create_array([
			rt.ArrayItem{ key: 'register_attribute', val: 'wp_register_dimensions_support' },
			rt.ArrayItem{ key: 'apply', val: 'wp_apply_dimensions_support' },
		])])
}
