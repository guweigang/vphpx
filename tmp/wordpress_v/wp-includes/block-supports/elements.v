import rt
import crypto.md5

fn wp_get_elements_class_name(var_block rt.PhpVal) string {
	return 'wp-elements-' + md5.hexhash(rt.call_function('serialize', [var_block.dup()]).to_string())
}

fn wp_should_add_elements_class_name(var_block rt.PhpVal, var_options rt.PhpVal) bool {
	if !(var_block.array_get('attrs').array_get('style').array_isset(rt.new_string('elements'))) {
		return false
	}
	mut var_element_color_properties := { 'button': { 'skip': if !(var_options.array_get('button').array_get('skip')).is_null() { var_options.array_get('button').array_get('skip') } else { rt.new_bool(false) }, 'paths': map[string]rt.PhpVal{} }, 'link': { 'skip': if !(var_options.array_get('link').array_get('skip')).is_null() { var_options.array_get('link').array_get('skip') } else { rt.new_bool(false) }, 'paths': map[string]rt.PhpVal{} }, 'heading': { 'skip': if !(var_options.array_get('heading').array_get('skip')).is_null() { var_options.array_get('heading').array_get('skip') } else { rt.new_bool(false) }, 'paths': map[string]rt.PhpVal{} } }
	mut var_elements_style_attributes := var_block.array_get('attrs').array_get('style').array_get('elements')
	for _, var_element_config in var_element_color_properties {
		if rt.is_true(var_element_config.array_get('skip')) {
			continue
		}
		{
			mut iter_1 := var_element_config.array_get('paths').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_path := item_1.val
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					return true
				}
			}
		}
	}
	return false
}

fn wp_render_elements_support_styles(var_parsed_block rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(var_parsed_block.dup().is_string())) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN), rt.new_string('6.6.0'), rt.call_function('__', [rt.new_string('Use as a `pre_render_block` filter is deprecated. Use with `render_block_data` instead.')])])
	}
	mut var_block_type := rt.call_method(fn () rt.PhpVal { mut temp := Class_WP_Block_Type_Registry{}; return temp.get_instance() }(), 'get_registered', [var_parsed_block.array_get('blockName')])
	mut var_element_block_styles := if !(var_parsed_block.array_get('attrs').array_get('style').array_get('elements')).is_null() { var_parsed_block.array_get('attrs').array_get('style').array_get('elements') } else { rt.new_null() }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_element_block_styles)))) {
		return var_parsed_block.dup()
	}
	mut var_skip_link_color_serialization := rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.dup(), rt.new_string('color'), rt.new_string('link')])
	mut var_skip_heading_color_serialization := rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.dup(), rt.new_string('color'), rt.new_string('heading')])
	mut var_skip_button_color_serialization := rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.dup(), rt.new_string('color'), rt.new_string('button')])
	mut var_skips_all_element_color_serialization := rt.is_true(rt.new_bool(rt.is_true(var_skip_link_color_serialization) && rt.is_true(var_skip_heading_color_serialization))) && rt.is_true(var_skip_button_color_serialization)
	if var_skips_all_element_color_serialization {
		return var_parsed_block.dup()
	}
	mut var_options := { 'button': { 'skip': var_skip_button_color_serialization }, 'link': { 'skip': var_skip_link_color_serialization }, 'heading': { 'skip': var_skip_heading_color_serialization } }
	if !(wp_should_add_elements_class_name(var_parsed_block.dup(), var_options.dup())) {
		return var_parsed_block.dup()
	}
	mut var_class_name := wp_get_elements_class_name(var_parsed_block.dup())
	mut var_updated_class_name := rt.new_string(if var_parsed_block.array_get('attrs').array_isset(rt.new_string('className')) { (var_parsed_block.array_get('attrs').array_get('className')).str() + " ${var_class_name}" } else { rt.new_string(var_class_name) })
	rt.call_function('_wp_array_set', [var_parsed_block.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'attrs' }, rt.ArrayItem{ key: none, val: 'className' }]), var_updated_class_name.dup()])
	mut var_element_types := { 'button': { 'selector': rt.new_string(".${var_class_name} .wp-element-button, .${var_class_name} .wp-block-button__link"), 'skip': var_skip_button_color_serialization }, 'link': { 'selector': rt.new_string(".${var_class_name} a:where(:not(.wp-element-button))"), 'hover_selector': rt.new_string(".${var_class_name} a:where(:not(.wp-element-button)):hover"), 'skip': var_skip_link_color_serialization }, 'heading': { 'selector': rt.new_string(".${var_class_name} h1, .${var_class_name} h2, .${var_class_name} h3, .${var_class_name} h4, .${var_class_name} h5, .${var_class_name} h6"), 'skip': var_skip_heading_color_serialization, 'elements': map[string]rt.PhpVal{} } }
	for var_element_type, var_element_config in var_element_types {
		if rt.is_true(var_element_config.array_get('skip')) {
			continue
		}
		mut var_element_style_object := if !(var_element_block_styles.array_get(element_type)).is_null() { var_element_block_styles.array_get(element_type) } else { rt.new_null() }
		if rt.is_true(var_element_style_object) {
			rt.call_function('wp_style_engine_get_styles', [var_element_style_object.dup(), rt.create_array([rt.ArrayItem{ key: 'selector', val: var_element_config.array_get('selector') }, rt.ArrayItem{ key: 'context', val: 'block-supports' }])])
			if var_element_style_object.array_isset(rt.new_string(':hover')) {
				rt.call_function('wp_style_engine_get_styles', [var_element_style_object.array_get(':hover'), rt.create_array([rt.ArrayItem{ key: 'selector', val: var_element_config.array_get('hover_selector') }, rt.ArrayItem{ key: 'context', val: 'block-supports' }])])
			}
		}
		if var_element_config.array_isset(rt.new_string('elements')) {
			{
				mut iter_1 := var_element_config.array_get('elements').iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_element := item_1.val
					var_element_style_object = if !(var_element_block_styles.array_get(var_element)).is_null() { var_element_block_styles.array_get(var_element) } else { rt.new_null() }
					if rt.is_true(var_element_style_object) {
						rt.call_function('wp_style_engine_get_styles', [var_element_style_object.dup(), rt.create_array([rt.ArrayItem{ key: 'selector', val: ".${var_class_name} ${var_element.to_string()}" }, rt.ArrayItem{ key: 'context', val: 'block-supports' }])])
					}
				}
			}
		}
	}
	return var_parsed_block.dup()
}

fn wp_render_elements_class_name(var_block_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_matches := []rt.PhpVal{}
	mut var_class_string := if !(var_block.array_get('attrs').array_get('className')).is_null() { var_block.array_get('attrs').array_get('className') } else { rt.new_string('') }
	rt.call_function('preg_match', [rt.new_string('/\\bwp-elements-\\S+\\b/'), var_class_string.dup(), var_matches.dup()])
	if !rt.is_true(var_matches) {
		return var_block_content.dup()
	}
	mut var_tags := create_wp_html_tag_processor(var_block_content.dup())
	if rt.is_true(var_tags.next_tag()) {
		var_tags.add_class(var_matches.array_get(0))
	}
	return var_tags.get_updated_html()
}

struct Class_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

struct Class_WP_HTML_Tag_Processor {
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




pub fn init_wp_includes_block_supports_elements_php() {
	rt.call_function('add_filter', [rt.new_string('render_block'), rt.new_string('wp_render_elements_class_name'), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('render_block_data'), rt.new_string('wp_render_elements_support_styles'), rt.new_int(10), rt.new_int(1)])
}
