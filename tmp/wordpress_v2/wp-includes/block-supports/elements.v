import rt
import crypto.md5

fn wp_get_elements_class_name(var_block rt.PhpVal) string {
	return 'wp-elements-' +
		md5.hexhash(rt.call_function('serialize', [rt.create_array_from_native_map(var_block)]).to_string())
}

fn wp_should_add_elements_class_name(var_block rt.PhpVal, var_options rt.PhpVal) bool {
	mut var_element_color_properties := map[string]rt.PhpVal{}
	mut var_elements_style_attributes := rt.new_null()
	mut var_element_config := map[string]rt.PhpVal{}
	mut var_path := rt.new_null()
	if !(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('style')).array_isset(rt.new_string('elements'))) {
		return false
	}
	var_element_color_properties = {
		'button':  {
			'skip':  if !(var_options.array_get(rt.new_string('button')).array_get(rt.new_string('skip'))).is_null() {
				var_options.array_get(rt.new_string('button')).array_get(rt.new_string('skip'))
			} else {
				rt.new_bool(false)
			}
			'paths': map[string]rt.PhpVal{}
		}
		'link':    {
			'skip':  if !(var_options.array_get(rt.new_string('link')).array_get(rt.new_string('skip'))).is_null() {
				var_options.array_get(rt.new_string('link')).array_get(rt.new_string('skip'))
			} else {
				rt.new_bool(false)
			}
			'paths': map[string]rt.PhpVal{}
		}
		'heading': {
			'skip':  if !(var_options.array_get(rt.new_string('heading')).array_get(rt.new_string('skip'))).is_null() {
				var_options.array_get(rt.new_string('heading')).array_get(rt.new_string('skip'))
			} else {
				rt.new_bool(false)
			}
			'paths': map[string]rt.PhpVal{}
		}
	}
	var_elements_style_attributes =
		var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('style')).array_get(rt.new_string('elements'))
	for _, var_element_config_shadow in var_element_color_properties {
		if rt.is_true(var_element_config_shadow['skip']) {
			continue
		}
		mut iter_1 := var_element_config_shadow['paths'].iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_path_shadow := item_1.val
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.call_function('_wp_array_get', [
				var_elements_style_attributes.clone(),
				var_path_shadow.clone(),
				rt.new_null(),
			])))))
			{
				return true
			}
		}
	}
	return false
}

fn wp_render_elements_support_styles(var_parsed_block rt.PhpVal) rt.PhpVal {
	mut var_block_type := rt.new_null()
	mut var_element_block_styles := rt.new_null()
	mut var_skip_link_color_serialization := rt.new_null()
	mut var_skip_heading_color_serialization := rt.new_null()
	mut var_skip_button_color_serialization := rt.new_null()
	mut var_skips_all_element_color_serialization := false
	mut var_options := map[string]rt.PhpVal{}
	mut var_class_name := ''
	mut var_updated_class_name := rt.new_null()
	mut var_element_types := map[string]rt.PhpVal{}
	mut var_element_config := map[string]rt.PhpVal{}
	mut var_element_type := rt.new_null()
	mut var_element_style_object := rt.new_null()
	mut var_element := rt.new_null()
	if rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_parsed_block).is_string())) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('6.6.0'),
			rt.call_function('__', [
				rt.new_string('Use as a `pre_render_block` filter is deprecated. Use with `render_block_data` instead.'),
			])])
	}
	mut iife_temp_0 := Class_WP_Block_Type_Registry{}
	mut iife_result_0 := iife_temp_0.get_instance()
	var_block_type = rt.call_method(iife_result_0, 'get_registered', [
		var_parsed_block.array_get(rt.new_string('blockName')),
	])
	var_element_block_styles = if !(var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('style')).array_get(rt.new_string('elements'))).is_null() {
		var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('style')).array_get(rt.new_string('elements'))
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_element_block_styles)))) {
		return var_parsed_block.clone()
	}
	var_skip_link_color_serialization = rt.call_function('wp_should_skip_block_supports_serialization', [
		var_block_type.clone(),
		rt.new_string('color'),
		rt.new_string('link'),
	])
	var_skip_heading_color_serialization = rt.call_function('wp_should_skip_block_supports_serialization', [
		var_block_type.clone(),
		rt.new_string('color'),
		rt.new_string('heading'),
	])
	var_skip_button_color_serialization = rt.call_function('wp_should_skip_block_supports_serialization', [
		var_block_type.clone(),
		rt.new_string('color'),
		rt.new_string('button'),
	])
	var_skips_all_element_color_serialization = rt.is_true(var_skip_link_color_serialization)
		&& rt.is_true(var_skip_heading_color_serialization)
		&& rt.is_true(var_skip_button_color_serialization)
	if var_skips_all_element_color_serialization {
		return var_parsed_block.clone()
	}
	var_options = {
		'button':  {
			'skip': var_skip_button_color_serialization
		}
		'link':    {
			'skip': var_skip_link_color_serialization
		}
		'heading': {
			'skip': var_skip_heading_color_serialization
		}
	}
	if !(wp_should_add_elements_class_name(rt.create_array_from_native_map(var_parsed_block),
		rt.create_array_from_native_map(var_options))) {
		return var_parsed_block.clone()
	}
	var_class_name = wp_get_elements_class_name(rt.create_array_from_native_map(var_parsed_block))
	var_updated_class_name = rt.new_string((if var_parsed_block.array_get(rt.new_string('attrs')).array_isset(rt.new_string('className')) {
		(var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('className'))).str() +
			' ${var_class_name}'
	} else {
		var_class_name
	}).str())
	rt.call_function('_wp_array_set', [rt.create_array_from_native_map(var_parsed_block),
		rt.create_array([rt.ArrayItem{ key: none, val: 'attrs' },
			rt.ArrayItem{ key: none, val: 'className' }]),
		var_updated_class_name.clone()])
	var_element_types = {
		'button':  {
			'selector': rt.new_string('.${var_class_name} .wp-element-button, .${var_class_name} .wp-block-button__link')
			'skip':     var_skip_button_color_serialization
		}
		'link':    {
			'selector':       rt.new_string('.${var_class_name} a:where(:not(.wp-element-button))')
			'hover_selector': rt.new_string('.${var_class_name} a:where(:not(.wp-element-button)):hover')
			'skip':           var_skip_link_color_serialization
		}
		'heading': {
			'selector': rt.new_string('.${var_class_name} h1, .${var_class_name} h2, .${var_class_name} h3, .${var_class_name} h4, .${var_class_name} h5, .${var_class_name} h6')
			'skip':     var_skip_heading_color_serialization
			'elements': map[string]rt.PhpVal{}
		}
	}
	for var_element_type_shadow, var_element_config_shadow in var_element_types {
		if rt.is_true(var_element_config_shadow['skip']) {
			continue
		}
		var_element_style_object = if !(var_element_block_styles.array_get(rt.new_string(var_element_type_shadow.str()))).is_null() {
			var_element_block_styles.array_get(rt.new_string(var_element_type_shadow.str()))
		} else {
			rt.new_null()
		}
		if rt.is_true(var_element_style_object) {
			rt.call_function('wp_style_engine_get_styles', [var_element_style_object.clone(),
				rt.create_array([
					rt.ArrayItem{ key: 'selector', val: var_element_config_shadow['selector'] },
					rt.ArrayItem{ key: 'context', val: 'block-supports' },
				])])
			if var_element_style_object.array_isset(rt.new_string(':hover')) {
				rt.call_function('wp_style_engine_get_styles', [
					var_element_style_object.array_get(rt.new_string(':hover')),
					rt.create_array([
						rt.ArrayItem{
							key: 'selector'
							val: var_element_config_shadow['hover_selector']
						},
						rt.ArrayItem{ key: 'context', val: 'block-supports' },
					]),
				])
			}
		}
		if var_element_config_shadow.array_isset(rt.new_string('elements')) {
			mut iter_2 := var_element_config_shadow['elements'].iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_element_shadow := item_2.val
				var_element_style_object = if !(var_element_block_styles.array_get(var_element_shadow)).is_null() {
					var_element_block_styles.array_get(var_element_shadow)
				} else {
					rt.new_null()
				}
				if rt.is_true(var_element_style_object) {
					rt.call_function('wp_style_engine_get_styles', [
						var_element_style_object.clone(),
						rt.create_array([
							rt.ArrayItem{
								key: 'selector'
								val: '.${var_class_name} ${var_element.to_string()}'
							},
							rt.ArrayItem{ key: 'context', val: 'block-supports' },
						])])
				}
			}
		}
	}
	return var_parsed_block.clone()
}

fn wp_render_elements_class_name(var_block_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_matches := []rt.PhpVal{}
	mut var_class_string := rt.new_null()
	mut var_tags := rt.new_null()
	var_class_string = if !(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('className'))).is_null() {
		var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('className'))
	} else {
		rt.new_string('')
	}
	rt.call_function('preg_match', [rt.new_string('/\\bwp-elements-\\S+\\b/'),
		var_class_string.clone(), rt.create_array_from_list(var_matches)])
	if !rt.is_true(var_matches) {
		return var_block_content.clone()
	}
	var_tags = create_wp_html_tag_processor(var_block_content.clone())
	if rt.is_true(var_tags.next_tag()) {
		var_tags.add_class(var_matches[0])
	}
	return var_tags.get_updated_html()
}

struct Class_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

struct Class_WP_HTML_Tag_Processor {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_filter', [rt.new_string('render_block'),
		rt.new_string('wp_render_elements_class_name'), rt.new_int(10),
		rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('render_block_data'),
		rt.new_string('wp_render_elements_support_styles'), rt.new_int(10),
		rt.new_int(1)])
}
