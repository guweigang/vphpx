import rt

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.clean_css_classes(classes string) string {
	mut classes_mutated := classes
	if classes_mutated.len > 1000 {
		classes_mutated = (rt.call_function('substr', [rt.new_string(classes_mutated).dup(), rt.new_int(0), rt.new_int(1000)])).str()
	}
	mut var_result := rt.call_function('preg_replace', [rt.new_string('/\\bhas-background\\b/'), rt.new_string(''), rt.new_string(classes_mutated).dup()])
	if rt.is_true(rt.identical(rt.new_null(), var_result)) {
		classes_mutated = ''
	} else {
		classes_mutated = (var_result).str()
	}
	var_result = rt.call_function('preg_replace', [rt.new_string('/\\bhas-[a-z-]*border[a-z-]*\\b/'), rt.new_string(''), rt.new_string(classes_mutated).dup()])
	if rt.is_true(rt.identical(rt.new_null(), var_result)) {
		classes_mutated = ''
	} else {
		classes_mutated = (var_result).str()
	}
	var_result = rt.call_function('preg_replace', [rt.new_string('/\\b[a-z-]+-border-[a-z-]+\\b/'), rt.new_string(''), rt.new_string(classes_mutated).dup()])
	if rt.is_true(rt.identical(rt.new_null(), var_result)) {
		classes_mutated = ''
	} else {
		classes_mutated = (var_result).str()
	}
	var_result = rt.call_function('preg_replace', [rt.new_string('/\\s+/'), rt.new_string(' '), rt.new_string(classes_mutated).dup()])
	if rt.is_true(rt.identical(rt.new_null(), var_result)) {
		classes_mutated = ''
	} else {
		classes_mutated = (var_result).str()
	}
	return classes_mutated.trim_space()
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.sanitize_css_value(value string) string {
	mut value_mutated := value
	mut var_result := rt.call_function('preg_replace', [rt.new_string('/[<>]/'), rt.new_string(''), rt.new_string(value_mutated).dup()])
	if rt.is_true(rt.identical(rt.new_null(), var_result)) {
		value_mutated = ''
	} else {
		value_mutated = (var_result).str()
	}
	mut var_dangerous_patterns := rt.create_array([rt.ArrayItem{ key: none, val: '/expression\\s*\\(/i' }, rt.ArrayItem{ key: none, val: '/url\\s*\\(\\s*javascript\\s*:/i' }, rt.ArrayItem{ key: none, val: '/url\\s*\\(\\s*data\\s*:/i' }, rt.ArrayItem{ key: none, val: '/url\\s*\\(\\s*vbscript\\s*:/i' }, rt.ArrayItem{ key: none, val: '/import\\s*\\(/i' }, rt.ArrayItem{ key: none, val: '/behavior\\s*:/i' }, rt.ArrayItem{ key: none, val: '/binding\\s*:/i' }, rt.ArrayItem{ key: none, val: '/filter\\s*:/i' }, rt.ArrayItem{ key: none, val: '/progid\\s*:/i' }])
	{
		mut iter_1 := var_dangerous_patterns.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_pattern := item_1.val
			if rt.is_true(rt.call_function('preg_match', [var_pattern.dup(), rt.new_string(value_mutated).dup()])) {
				return ''
			}
		}
	}
	return value_mutated.trim_space()
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.sanitize_dimension_value(var_value rt.PhpVal) string {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_string()))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_long() || var_value_mutated.dup().is_double()))))))) {
		return ''
	}
	var_value_mutated = // unsupported expression: Expr_Cast_String
	if rt.is_true(rt.new_bool(var_value_mutated.dup().is_long() || var_value_mutated.dup().is_double())) {
		var_value_mutated = rt.new_string((var_value_mutated).str() + 'px')
	}
	mut var_sanitized_value := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.sanitize_css_value((var_value_mutated).str())
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_sanitized_value)) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/^(\\d+(?:\\.\\d+)?)(px|em|rem|%|vh|vw|ex|ch|in|cm|mm|pt|pc)$/'), var_sanitized_value.dup()])))) {
		return (var_sanitized_value).str()
	}
	return ''
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.sanitize_color(color string) string {
	mut color_mutated := color
	color_mutated = color_mutated.trim_space()
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^#([0-9a-fA-F]{3}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})$/'), rt.new_string(color_mutated).dup()])) {
		return color_mutated.to_lower()
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^rgba?\\(\\s*(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\s*,\\s*(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\s*,\\s*(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\s*(?:,\\s*(?:1(?:\\.0+)?|0(?:\\.\\d+)?|\\.\\d+)\\s*)?\\)$/'), rt.new_string(color_mutated).dup()])) {
		return color_mutated
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^hsla?\\(\\s*(360|3[0-5]\\d|[12]\\d{2}|\\d{1,2})\\s*,\\s*(100|[1-9]?\\d)%\\s*,\\s*(100|[1-9]?\\d)%\\s*(?:,\\s*(?:1(?:\\.0+)?|0(?:\\.\\d+)?|\\.\\d+)\\s*)?\\)$/'), rt.new_string(color_mutated).dup()])) {
		return color_mutated
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[a-zA-Z][a-zA-Z0-9-]*$/'), rt.new_string(color_mutated).dup()])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^(expression|javascript|vbscript|data|import|behavior|binding|filter|progid)/i'), rt.new_string(color_mutated).dup()]))))))) {
		return color_mutated.to_lower()
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^var\\(--[a-zA-Z0-9\\-_]+\\)$/'), rt.new_string(color_mutated).dup()])) {
		return color_mutated
	}
	return '#000000'
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.normalize_rel_attribute(mut var_rel_value Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_?string, require_security_tokens bool) string {
	mut var_rel_value_mutated := var_rel_value
	mut var_allowed_tokens := rt.create_array([rt.ArrayItem{ key: none, val: 'noopener' }, rt.ArrayItem{ key: none, val: 'noreferrer' }, rt.ArrayItem{ key: none, val: 'nofollow' }, rt.ArrayItem{ key: none, val: 'external' }])
	mut var_required_tokens := if var_require_security_tokens { rt.create_array([rt.ArrayItem{ key: none, val: 'noopener' }, rt.ArrayItem{ key: none, val: 'noreferrer' }]) } else { rt.new_array() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_null(), var_rel_value_mutated)) && !rt.is_true(var_required_tokens))) {
		return ''
	}
	mut var_tokens := var_required_tokens.dup()
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_existing_tokens := rt.call_function('preg_split', [rt.new_string('/\\s+/'), rt.new_string(var_rel_value_mutated.dup().to_string().trim_space())])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			closure_1_fn := fn [var_allowed_tokens] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_token := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return !(!rt.is_true(var_token)) && rt.is_true(rt.call_function('in_array', [var_token.dup(), var_allowed_tokens.dup(), rt.new_bool(true)]))
	}
			mut var_normalized_existing := rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('strtolower'), var_existing_tokens.dup()]), rt.new_closure(closure_1_fn)])
			var_tokens = rt.call_function('array_unique', [rt.call_function('array_merge', [var_tokens.dup(), var_normalized_existing.dup()])])
		}
	}
	return (if !rt.is_true(var_tokens) { rt.new_string('') } else { rt.call_function('implode', [rt.new_string(' '), var_tokens.dup()]) }).str()
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.validate_caption_attribute(mut var_html Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_WP_HTML_Tag_Processor, attr_name string)  {
	mut var_html_mutated := var_html
	mut var_attr_value := var_html_mutated.get_attribute(rt.new_string(attr_name))
	if rt.is_true(rt.identical(rt.new_null(), var_attr_value)) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('str_starts_with', [rt.new_string(attr_name), rt.new_string('on')])) {
		var_html_mutated.remove_attribute(rt.new_string(attr_name))
		return rt.new_null()
	}
	mut switch_val_1 := rt.new_string(attr_name)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('href'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^(https?:\\/\\/|mailto:|tel:)/i'), // unsupported expression: Expr_Cast_String]))))) {
			var_html_mutated.remove_attribute(rt.new_string(attr_name))
			break
		}
		mut var_sanitized_url := rt.call_function('esc_url_raw', [// unsupported expression: Expr_Cast_String])
		if !rt.is_true(var_sanitized_url) {
			var_html_mutated.remove_attribute(rt.new_string(attr_name))
		} else {
			var_html_mutated.set_attribute(rt.new_string(attr_name), var_sanitized_url.dup())
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('target'))) {
		mut var_allowed_targets := rt.create_array([rt.ArrayItem{ key: none, val: '_blank' }, rt.ArrayItem{ key: none, val: '_self' }])
		mut var_target_value := rt.new_string(rt.new_string(// unsupported expression: Expr_Cast_String.to_string().to_lower()))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_target_value.dup(), var_allowed_targets.dup(), rt.new_bool(true)]))))) {
			var_html_mutated.remove_attribute(rt.new_string(attr_name))
		} else if rt.is_true(rt.identical(rt.new_string('_blank'), var_target_value)) {
			mut var_current_rel := var_html_mutated.get_attribute(rt.new_string('rel'))
			mut var_rel_value := if rt.is_true(rt.new_bool(var_current_rel.dup().is_string())) { var_current_rel } else { rt.new_null() }
			mut var_normalized_rel := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.normalize_rel_attribute(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_?string](var_rel_value), true)
			var_html_mutated.set_attribute(rt.new_string('rel'), var_normalized_rel.dup())
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('rel'))) {
		var_rel_value = if rt.is_true(rt.new_bool(var_attr_value.dup().is_string())) { var_attr_value } else { rt.new_null() }
		var_normalized_rel = Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.normalize_rel_attribute(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_?string](var_rel_value), false)
		if !rt.is_true(var_normalized_rel) {
			var_html_mutated.remove_attribute(rt.new_string(attr_name))
		} else {
			var_html_mutated.set_attribute(rt.new_string(attr_name), var_normalized_rel.dup())
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('style'))) {
		mut var_safe_properties := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.get_safe_css_properties()
		mut var_sanitized_styles := rt.new_array()
		mut var_style_parts := rt.call_function('explode', [rt.new_string(';'), // unsupported expression: Expr_Cast_String])
		{
			mut iter_1 := var_style_parts.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_style_part := item_1.val
				var_style_part = rt.new_string(rt.new_string(var_style_part.dup().to_string().trim_space()))
				if !rt.is_true(var_style_part) {
					continue
				}
				mut var_property_parts := rt.call_function('explode', [rt.new_string(':'), var_style_part.dup(), rt.new_int(2)])
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					continue
				}
				mut var_property := rt.new_string(rt.new_string(var_property_parts.array_get(0).to_string().to_lower().trim_space()))
				mut var_value := rt.new_string(rt.new_string(var_property_parts.array_get(1).to_string().trim_space()))
				if rt.is_true(rt.call_function('in_array', [var_property.dup(), var_safe_properties.dup(), rt.new_bool(true)])) {
					mut var_sanitized_value := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.sanitize_css_value((var_value).str())
					if !(!rt.is_true(var_sanitized_value)) {
						var_sanitized_styles.array_push((var_property).str() + ': ' + (var_sanitized_value).str())
					}
				}
			}
		}
		if !rt.is_true(var_sanitized_styles) {
			var_html_mutated.remove_attribute(rt.new_string(attr_name))
		} else {
			var_html_mutated.set_attribute(rt.new_string(attr_name), rt.call_function('implode', [rt.new_string('; '), var_sanitized_styles.dup()]))
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('class'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[a-zA-Z0-9\\s\\-_]+$/'), // unsupported expression: Expr_Cast_String]))))) {
			var_html_mutated.remove_attribute(rt.new_string(attr_name))
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('data-type'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('data-id'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[a-zA-Z0-9\\-_]+$/'), // unsupported expression: Expr_Cast_String]))))) {
			var_html_mutated.remove_attribute(rt.new_string(attr_name))
		}
	} else {
		if rt.is_true(rt.call_function('str_starts_with', [rt.new_string(attr_name), rt.new_string('data-')])) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[a-zA-Z0-9\\-_]+$/'), // unsupported expression: Expr_Cast_String]))))) {
				var_html_mutated.remove_attribute(rt.new_string(attr_name))
			}
			break
		}
		var_html_mutated.remove_attribute(rt.new_string(attr_name))
	}
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.get_safe_css_properties() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'color' }, rt.ArrayItem{ key: none, val: 'background-color' }, rt.ArrayItem{ key: none, val: 'font-family' }, rt.ArrayItem{ key: none, val: 'font-size' }, rt.ArrayItem{ key: none, val: 'font-weight' }, rt.ArrayItem{ key: none, val: 'font-style' }, rt.ArrayItem{ key: none, val: 'text-decoration' }, rt.ArrayItem{ key: none, val: 'text-align' }, rt.ArrayItem{ key: none, val: 'line-height' }, rt.ArrayItem{ key: none, val: 'letter-spacing' }, rt.ArrayItem{ key: none, val: 'text-transform' }])
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.get_caption_css_properties() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'font-family' }, rt.ArrayItem{ key: none, val: 'font-size' }, rt.ArrayItem{ key: none, val: 'font-weight' }, rt.ArrayItem{ key: none, val: 'font-style' }, rt.ArrayItem{ key: none, val: 'text-decoration' }, rt.ArrayItem{ key: none, val: 'line-height' }, rt.ArrayItem{ key: none, val: 'letter-spacing' }, rt.ArrayItem{ key: none, val: 'text-transform' }])
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.validate_container_attributes(container_html string) bool {
	mut var_html := create_automattic_woocommerce_emaileditor_integrations_utils_wp_html_tag_processor(rt.new_string(container_html).dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_html.next_tag())))) {
		return false
	}
	mut var_attributes := var_html.get_attribute_names_with_prefix(rt.new_string(''))
	if rt.is_true(rt.new_bool(var_attributes.dup().is_array())) {
		{
			mut iter_1 := var_attributes.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_attr_name := item_1.val
				mut var_attr_value := var_html.get_attribute(var_attr_name.dup())
				if rt.is_true(rt.identical(rt.new_null(), var_attr_value)) {
					continue
				}
				if rt.is_true(rt.call_function('str_starts_with', [var_attr_name.dup(), rt.new_string('on')])) {
					return false
				}
				mut var_escaped_value := rt.call_function('htmlspecialchars', [// unsupported expression: Expr_Cast_String, rt.get_constant('ENT_QUOTES'), rt.new_string('UTF-8')])
				mut var_temp_html := create_automattic_woocommerce_emaileditor_integrations_utils_wp_html_tag_processor()
				if rt.is_true(.next_tag()) {
					
				}
			}
		}
	}
	return true
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.sanitize_caption_html(caption_html string) string {
	mut caption_html_mutated := caption_html
	if rt.is_true() {
	}
	
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.sanitize_image_html(image_html string) string {
	mut var_matches := rt.new_null()
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.extract_url_from_text(text string) string {
	mut var_matches := rt.new_null()
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.sanitize_image_styles(style_value string) string {
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_html_processing_helper() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_wp_html_tag_processor() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_WP_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'clean_css_classes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.clean_css_classes(dispatch_arg_0))
		}
		'sanitize_css_value' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.sanitize_css_value(dispatch_arg_0))
		}
		'sanitize_dimension_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.sanitize_dimension_value(dispatch_arg_0))
		}
		'sanitize_color' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.sanitize_color(dispatch_arg_0))
		}
		'normalize_rel_attribute' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.normalize_rel_attribute(mut dispatch_arg_0, dispatch_arg_1))
		}
		'validate_caption_attribute' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_WP_HTML_Tag_Processor](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.validate_caption_attribute(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_safe_css_properties' {
			return Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.get_safe_css_properties()
		}
		'get_caption_css_properties' {
			return Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.get_caption_css_properties()
		}
		'validate_container_attributes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.validate_container_attributes(dispatch_arg_0))
		}
		'sanitize_caption_html' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.sanitize_caption_html(dispatch_arg_0))
		}
		'sanitize_image_html' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.sanitize_image_html(dispatch_arg_0))
		}
		'extract_url_from_text' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.extract_url_from_text(dispatch_arg_0))
		}
		'sanitize_image_styles' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.sanitize_image_styles(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_integrations_utils_class_html_processing_helper_php() {
	// unsupported statement: Stmt_Declare
}
