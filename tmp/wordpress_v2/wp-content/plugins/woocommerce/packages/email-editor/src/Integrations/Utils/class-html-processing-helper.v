import rt

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.clean_css_classes(classes string) string {
	mut classes_mutated := classes
	if classes_mutated.len > 1000 {
	classes_mutated = (rt.call_function('substr', [rt.new_string(classes_mutated).clone(), rt.new_int(0), rt.new_int(1000)])).str()
	}
	mut var_result := rt.call_function('preg_replace', [rt.new_string('/\\bhas-background\\b/'), rt.new_string(''), rt.new_string(classes_mutated).clone()])
	if rt.is_true(rt.identical(rt.new_null(), var_result)) {
	classes_mutated = ''
	} else {
	classes_mutated = (var_result).str()
	}
	var_result = rt.call_function('preg_replace', [rt.new_string('/\\bhas-[a-z-]*border[a-z-]*\\b/'), rt.new_string(''), rt.new_string(classes_mutated).clone()])
	if rt.is_true(rt.identical(rt.new_null(), var_result)) {
	classes_mutated = ''
	} else {
	classes_mutated = (var_result).str()
	}
	var_result = rt.call_function('preg_replace', [rt.new_string('/\\b[a-z-]+-border-[a-z-]+\\b/'), rt.new_string(''), rt.new_string(classes_mutated).clone()])
	if rt.is_true(rt.identical(rt.new_null(), var_result)) {
	classes_mutated = ''
	} else {
	classes_mutated = (var_result).str()
	}
	var_result = rt.call_function('preg_replace', [rt.new_string('/\\s+/'), rt.new_string(' '), rt.new_string(classes_mutated).clone()])
	if rt.is_true(rt.identical(rt.new_null(), var_result)) {
	classes_mutated = ''
	} else {
	classes_mutated = (var_result).str()
	}
	return classes_mutated.trim_space()
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.sanitize_css_value(value string) string {
	mut value_mutated := value
	mut var_result := rt.call_function('preg_replace', [rt.new_string('/[<>]/'), rt.new_string(''), rt.new_string(value_mutated).clone()])
	if rt.is_true(rt.identical(rt.new_null(), var_result)) {
	value_mutated = ''
	} else {
	value_mutated = (var_result).str()
	}
	mut var_dangerous_patterns := rt.create_array([rt.ArrayItem{ key: none, val: '/expression\\s*\\(/i' }, rt.ArrayItem{ key: none, val: '/url\\s*\\(\\s*javascript\\s*:/i' }, rt.ArrayItem{ key: none, val: '/url\\s*\\(\\s*data\\s*:/i' }, rt.ArrayItem{ key: none, val: '/url\\s*\\(\\s*vbscript\\s*:/i' }, rt.ArrayItem{ key: none, val: '/import\\s*\\(/i' }, rt.ArrayItem{ key: none, val: '/behavior\\s*:/i' }, rt.ArrayItem{ key: none, val: '/binding\\s*:/i' }, rt.ArrayItem{ key: none, val: '/filter\\s*:/i' }, rt.ArrayItem{ key: none, val: '/progid\\s*:/i' }])
	mut iter_1 := var_dangerous_patterns.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_pattern := item_1.val
		if rt.is_true(rt.call_function('preg_match', [var_pattern.clone(), rt.new_string(value_mutated).clone()])) {
			return ''
		}
	}
	return value_mutated.trim_space()
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.sanitize_dimension_value(var_value rt.PhpVal) string {
	mut var_value_mutated := var_value
	if !(var_value_mutated.clone().is_string()) && !(var_value_mutated.clone().is_long() || var_value_mutated.clone().is_double()) {
		return ''
	}
	var_value_mutated = rt.new_string((var_value_mutated).str())
	if rt.is_true(rt.new_bool(var_value_mutated.clone().is_long() || var_value_mutated.clone().is_double())) {
	var_value_mutated = rt.new_string((var_value_mutated).str() + 'px')
	}
	mut var_sanitized_value := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.sanitize_css_value((var_value_mutated).str())
	if !(!rt.is_true(var_sanitized_value)) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/^(\\d+(?:\\.\\d+)?)(px|em|rem|%|vh|vw|ex|ch|in|cm|mm|pt|pc)$/'), var_sanitized_value.clone()])) {
		return (var_sanitized_value).str()
	}
	return ''
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.sanitize_color(color string) string {
	mut color_mutated := color
	color_mutated = color_mutated.trim_space()
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^#([0-9a-fA-F]{3}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})$/'), rt.new_string(color_mutated).clone()])) {
		return color_mutated.to_lower()
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^rgba?\\(\\s*(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\s*,\\s*(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\s*,\\s*(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\s*(?:,\\s*(?:1(?:\\.0+)?|0(?:\\.\\d+)?|\\.\\d+)\\s*)?\\)$/'), rt.new_string(color_mutated).clone()])) {
		return color_mutated
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^hsla?\\(\\s*(360|3[0-5]\\d|[12]\\d{2}|\\d{1,2})\\s*,\\s*(100|[1-9]?\\d)%\\s*,\\s*(100|[1-9]?\\d)%\\s*(?:,\\s*(?:1(?:\\.0+)?|0(?:\\.\\d+)?|\\.\\d+)\\s*)?\\)$/'), rt.new_string(color_mutated).clone()])) {
		return color_mutated
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[a-zA-Z][a-zA-Z0-9-]*$/'), rt.new_string(color_mutated).clone()])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^(expression|javascript|vbscript|data|import|behavior|binding|filter|progid)/i'), rt.new_string(color_mutated).clone()]))))) {
		return color_mutated.to_lower()
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^var\\(--[a-zA-Z0-9\\-_]+\\)$/'), rt.new_string(color_mutated).clone()])) {
		return color_mutated
	}
	return '#000000'
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.normalize_rel_attribute(mut var_rel_value Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_?string, require_security_tokens bool) string {
	mut var_rel_value_mutated := var_rel_value
	mut var_allowed_tokens := rt.create_array([rt.ArrayItem{ key: none, val: 'noopener' }, rt.ArrayItem{ key: none, val: 'noreferrer' }, rt.ArrayItem{ key: none, val: 'nofollow' }, rt.ArrayItem{ key: none, val: 'external' }])
	mut var_required_tokens := if var_require_security_tokens { rt.create_array([rt.ArrayItem{ key: none, val: 'noopener' }, rt.ArrayItem{ key: none, val: 'noreferrer' }]) } else { rt.new_array() }
	if rt.is_true(rt.identical(rt.new_null(), var_rel_value_mutated)) && !rt.is_true(var_required_tokens) {
		return ''
	}
	mut var_tokens := var_required_tokens.clone()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_rel_value_mutated)))) {
		mut var_existing_tokens := rt.call_function('preg_split', [rt.new_string('/\\s+/'), rt.new_string(var_rel_value_mutated.to_string().trim_space())])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_existing_tokens)))) {
		closure_1_fn := fn [var_allowed_tokens] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_token := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return !(!rt.is_true(var_token)) && rt.is_true(rt.call_function('in_array', [var_token.clone(), var_allowed_tokens.clone(), rt.new_bool(true)]))
			}
		mut var_normalized_existing := rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('strtolower'), var_existing_tokens.clone()]), rt.new_closure(closure_1_fn)])
		var_tokens = rt.call_function('array_unique', [rt.call_function('array_merge', [var_tokens.clone(), var_normalized_existing.clone()])])
		}
	}
	return (if !rt.is_true(var_tokens) { rt.new_string('') } else { rt.call_function('implode', [rt.new_string(' '), var_tokens.clone()]) }).str()
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.validate_caption_attribute(mut var_html Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_WP_HTML_Tag_Processor, attr_name string) {
	mut var_html_mutated := var_html
	mut var_attr_value := var_html_mutated.get_attribute(rt.new_string(attr_name))
	if rt.is_true(rt.identical(rt.new_null(), var_attr_value)) {
		return
	}
	if rt.is_true(rt.call_function('str_starts_with', [rt.new_string(attr_name), rt.new_string('on')])) {
		var_html_mutated.remove_attribute(rt.new_string(attr_name))
		return
	}
	mut switch_val_1 := rt.new_string(attr_name)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('href'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^(https?:\\/\\/|mailto:|tel:)/i'), rt.new_string((var_attr_value).str())]))))) {
			var_html_mutated.remove_attribute(rt.new_string(attr_name))
		}
		mut var_sanitized_url := rt.call_function('esc_url_raw', [rt.new_string((var_attr_value).str())])
		if !rt.is_true(var_sanitized_url) {
			var_html_mutated.remove_attribute(rt.new_string(attr_name))
		} else {
			var_html_mutated.set_attribute(rt.new_string(attr_name), var_sanitized_url.clone())
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('target'))) {
		mut var_allowed_targets := rt.create_array([rt.ArrayItem{ key: none, val: '_blank' }, rt.ArrayItem{ key: none, val: '_self' }])
		mut var_target_value := rt.new_string((var_attr_value).str().to_lower())
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_target_value.clone(), var_allowed_targets.clone(), rt.new_bool(true)]))))) {
			var_html_mutated.remove_attribute(rt.new_string(attr_name))
		} else if rt.is_true(rt.identical(rt.new_string('_blank'), var_target_value)) {
			mut var_current_rel := var_html_mutated.get_attribute(rt.new_string('rel'))
			mut var_rel_value := if var_current_rel.clone().is_string() { var_current_rel } else { rt.new_null() }
			mut var_normalized_rel := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.normalize_rel_attribute(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_?string](var_rel_value), true)
			var_html_mutated.set_attribute(rt.new_string('rel'), var_normalized_rel.clone())
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('rel'))) {
		var_rel_value = if var_attr_value.clone().is_string() { var_attr_value } else { rt.new_null() }
		var_normalized_rel = Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.normalize_rel_attribute(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_?string](var_rel_value), false)
		if !rt.is_true(var_normalized_rel) {
			var_html_mutated.remove_attribute(rt.new_string(attr_name))
		} else {
			var_html_mutated.set_attribute(rt.new_string(attr_name), var_normalized_rel.clone())
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('style'))) {
		mut var_safe_properties := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.get_safe_css_properties()
		mut var_sanitized_styles := rt.new_array()
		mut var_style_parts := rt.call_function('explode', [rt.new_string(';'), rt.new_string((var_attr_value).str())])
		mut iter_2 := var_style_parts.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_style_part := item_2.val
			var_style_part = rt.new_string(var_style_part.clone().to_string().trim_space())
			if !rt.is_true(var_style_part) {
				continue
			}
			mut var_property_parts := rt.call_function('explode', [rt.new_string(':'), var_style_part.clone(), rt.new_int(2)])
			if rt.is_true(rt.new_bool(var_property_parts.clone().array_count() != 2)) {
				continue
			}
			mut var_property := rt.new_string(var_property_parts.array_get(rt.new_int(0)).to_string().to_lower().trim_space())
			mut var_value := rt.new_string(var_property_parts.array_get(rt.new_int(1)).to_string().trim_space())
			if rt.is_true(rt.call_function('in_array', [var_property.clone(), var_safe_properties.clone(), rt.new_bool(true)])) {
				mut var_sanitized_value := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.sanitize_css_value((var_value).str())
				if !(!rt.is_true(var_sanitized_value)) {
					var_sanitized_styles.array_push((var_property).str() + ': ' + (var_sanitized_value).str())
				}
			}
		}
		if !rt.is_true(var_sanitized_styles) {
			var_html_mutated.remove_attribute(rt.new_string(attr_name))
		} else {
			var_html_mutated.set_attribute(rt.new_string(attr_name), rt.call_function('implode', [rt.new_string('; '), var_sanitized_styles.clone()]))
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('class'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[a-zA-Z0-9\\s\\-_]+$/'), rt.new_string((var_attr_value).str())]))))) {
			var_html_mutated.remove_attribute(rt.new_string(attr_name))
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('data-type'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('data-id'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[a-zA-Z0-9\\-_]+$/'), rt.new_string((var_attr_value).str())]))))) {
			var_html_mutated.remove_attribute(rt.new_string(attr_name))
		}
	} else {
		if rt.is_true(rt.call_function('str_starts_with', [rt.new_string(attr_name), rt.new_string('data-')])) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[a-zA-Z0-9\\-_]+$/'), rt.new_string((var_attr_value).str())]))))) {
				var_html_mutated.remove_attribute(rt.new_string(attr_name))
			}
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
	mut var_html := create_automattic_woocommerce_emaileditor_integrations_utils_wp_html_tag_processor(rt.new_string(container_html))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_html.next_tag())))) {
		return false
	}
	mut var_attributes := var_html.get_attribute_names_with_prefix(rt.new_string(''))
	if rt.is_true(rt.new_bool(var_attributes.clone().is_array())) {
		mut iter_3 := var_attributes.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_attr_name := item_3.val
			mut var_attr_value := var_html.get_attribute(var_attr_name.clone())
			if rt.is_true(rt.identical(rt.new_null(), var_attr_value)) {
				continue
			}
			if rt.is_true(rt.call_function('str_starts_with', [var_attr_name.clone(), rt.new_string('on')])) {
				return false
			}
			mut var_escaped_value := rt.call_function('htmlspecialchars', [rt.new_string((var_attr_value).str()), rt.get_constant('ENT_QUOTES'), rt.new_string('UTF-8')])
			mut var_temp_html := create_automattic_woocommerce_emaileditor_integrations_utils_wp_html_tag_processor('<span ' + (var_attr_name).str() + '="' + (var_escaped_value).str() + '">test</span>')
			if rt.is_true(var_temp_html.next_tag()) {
				mut var_original_value := var_temp_html.get_attribute(var_attr_name.clone())
				Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.validate_caption_attribute(mut var_temp_html, (var_attr_name).str())
				mut var_validated_value := var_temp_html.get_attribute(var_attr_name.clone())
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_original_value)))) && rt.is_true(rt.identical(rt.new_null(), var_validated_value)) {
					return false
				}
			}
		}
	}
	return true
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.sanitize_caption_html(caption_html string) string {
	mut caption_html_mutated := caption_html
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [rt.new_string(caption_html_mutated).clone(), rt.new_string('<')]))) {
		return caption_html_mutated
	}
	mut var_result := rt.call_function('preg_replace', [rt.new_string('/<(script|style|iframe|object|embed|form|input|button)\\b[^>]*>.*?<\\/\\1>/is'), rt.new_string(''), rt.new_string(caption_html_mutated).clone()])
	if rt.is_true(rt.identical(rt.new_null(), var_result)) {
	caption_html_mutated = ''
	} else {
	caption_html_mutated = (var_result).str()
	}
	mut var_allowed_tags := rt.create_array([rt.ArrayItem{ key: none, val: 'strong' }, rt.ArrayItem{ key: none, val: 'em' }, rt.ArrayItem{ key: none, val: 'a' }, rt.ArrayItem{ key: none, val: 'mark' }, rt.ArrayItem{ key: none, val: 'kbd' }, rt.ArrayItem{ key: none, val: 's' }, rt.ArrayItem{ key: none, val: 'sub' }, rt.ArrayItem{ key: none, val: 'sup' }, rt.ArrayItem{ key: none, val: 'span' }, rt.ArrayItem{ key: none, val: 'br' }])
	mut var_html := create_automattic_woocommerce_emaileditor_integrations_utils_wp_html_tag_processor(rt.new_string(caption_html_mutated).clone())
	for rt.is_true(var_html.next_tag()) {
		mut var_tag_name := var_html.get_tag()
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_tag_name.clone(), var_allowed_tags.clone(), rt.new_bool(true)]))))) {
			continue
		}
		mut var_attributes := var_html.get_attribute_names_with_prefix(rt.new_string(''))
		if rt.is_true(rt.new_bool(var_attributes.clone().is_array())) {
			mut iter_4 := var_attributes.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_attr_name := item_4.val
				Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.validate_caption_attribute(mut var_html, (var_attr_name).str())
			}
		}
	}
	mut var_final_html := var_html.get_updated_html()
	mut var_allowed_tags_pattern := rt.call_function('implode', [rt.new_string('|'), rt.call_function('array_map', [rt.new_string('preg_quote'), var_allowed_tags.clone()])])
	var_result = rt.call_function('preg_replace', [rt.new_string('/<(?!(?:' + (var_allowed_tags_pattern).str() + ')\\b)[^>]*>(.*?)<\\/(?!(?:' + (var_allowed_tags_pattern).str() + ')\\b)[^>]*>/s'), rt.new_string('$1'), var_final_html.clone()])
	if rt.is_true(rt.identical(rt.new_null(), var_result)) {
	var_final_html = rt.new_string('')
	} else {
	var_final_html = var_result.clone()
	}
	var_result = rt.call_function('preg_replace', [rt.new_string('/<(?!(?:' + (var_allowed_tags_pattern).str() + ')\\b)[^>]*\\/>/s'), rt.new_string(''), var_final_html.clone()])
	if rt.is_true(rt.identical(rt.new_null(), var_result)) {
	var_final_html = rt.new_string('')
	} else {
	var_final_html = var_result.clone()
	}
	return (var_final_html).str()
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.sanitize_image_html(image_html string) string {
	mut var_matches := rt.new_null()
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [rt.new_string(image_html), rt.new_string('<')]))) {
		return image_html
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/<img[^>]*>/i'), rt.new_string(image_html), var_matches.clone()]))))) {
		return image_html
	}
	mut var_img_tag := var_matches.array_get(rt.new_int(0))
	mut var_sanitized_attributes := rt.new_array()
	mut var_has_src := rt.new_bool(false)
	mut var_html := create_automattic_woocommerce_emaileditor_integrations_utils_wp_html_tag_processor(var_img_tag.clone())
	if rt.is_true(var_html.next_tag()) {
		mut var_attributes := var_html.get_attribute_names_with_prefix(rt.new_string(''))
		if rt.is_true(rt.new_bool(var_attributes.clone().is_array())) {
			mut iter_5 := var_attributes.iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_attr_name := item_5.val
				mut var_attr_value := var_html.get_attribute(var_attr_name.clone())
				mut switch_val_2 := var_attr_name
				if rt.is_true(rt.equal(switch_val_2, rt.new_string('src'))) {
					mut var_sanitized_src := rt.call_function('esc_url', [rt.new_string((var_attr_value).str())])
					if !(!rt.is_true(var_sanitized_src)) {
						var_sanitized_attributes.array_push((var_attr_name).str() + '="' + (var_sanitized_src).str() + '"')
					var_has_src = rt.new_bool(true)
					}
				} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('alt'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('width'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('height'))) {
					var_sanitized_attributes.array_push((var_attr_name).str() + '="' + (rt.call_function('esc_attr', [rt.new_string((var_attr_value).str())])).str() + '"')
				} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('class'))) {
					mut var_cleaned_classes := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.clean_css_classes((var_attr_value).str())
					if !(!rt.is_true(var_cleaned_classes)) {
						var_sanitized_attributes.array_push((var_attr_name).str() + '="' + (rt.call_function('esc_attr', [var_cleaned_classes.clone()])).str() + '"')
					}
				} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('style'))) {
					mut var_sanitized_styles := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.sanitize_image_styles((var_attr_value).str())
					if !(!rt.is_true(var_sanitized_styles)) {
						var_sanitized_attributes.array_push((var_attr_name).str() + '="' + (rt.call_function('esc_attr', [var_sanitized_styles.clone()])).str() + '"')
					}
				}
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_has_src)))) {
		return ''
	}
	if !rt.is_true(var_sanitized_attributes) {
		return ''
	}
	return '<img ' + (rt.call_function('implode', [rt.new_string(' '), var_sanitized_attributes.clone()])).str() + '>'
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.extract_url_from_text(text string) string {
	mut var_matches := rt.new_null()
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/(?<![a-zA-Z0-9.-])https?:\\/\\/[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}[a-zA-Z0-9\\/?=&%_.~+#-]*(?![a-zA-Z0-9._~+#-])/'), rt.new_string(text), var_matches.clone()])) {
		return (var_matches.array_get(rt.new_int(0))).str()
	}
	return ''
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.sanitize_image_styles(style_value string) string {
	mut var_sanitized_styles := rt.new_array()
	mut var_style_parts := rt.call_function('explode', [rt.new_string(';'), rt.new_string(style_value)])
	mut iter_6 := var_style_parts.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_style_part := item_6.val
		var_style_part = rt.new_string(var_style_part.clone().to_string().trim_space())
		if !rt.is_true(var_style_part) {
			continue
		}
		mut var_property_parts := rt.call_function('explode', [rt.new_string(':'), var_style_part.clone(), rt.new_int(2)])
		if rt.is_true(rt.new_bool(var_property_parts.clone().array_count() != 2)) {
			continue
		}
		mut var_property := rt.new_string(var_property_parts.array_get(rt.new_int(0)).to_string().to_lower().trim_space())
		mut var_value := rt.new_string(var_property_parts.array_get(rt.new_int(1)).to_string().trim_space())
		mut var_safe_properties := rt.create_array([rt.ArrayItem{ key: none, val: 'width' }, rt.ArrayItem{ key: none, val: 'height' }, rt.ArrayItem{ key: none, val: 'max-width' }, rt.ArrayItem{ key: none, val: 'max-height' }, rt.ArrayItem{ key: none, val: 'display' }, rt.ArrayItem{ key: none, val: 'margin' }, rt.ArrayItem{ key: none, val: 'padding' }, rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'border-radius' }])
		if rt.is_true(rt.call_function('in_array', [var_property.clone(), var_safe_properties.clone(), rt.new_bool(true)])) {
			mut var_sanitized_value := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper.sanitize_css_value((var_value).str())
			if !(!rt.is_true(var_sanitized_value)) {
				var_sanitized_styles.array_push((var_property).str() + ': ' + (var_sanitized_value).str())
			}
		}
	}
	return (rt.call_function('implode', [rt.new_string('; '), var_sanitized_styles.clone()])).str()
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_html_processing_helper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_wp_html_tag_processor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_WP_HTML_Tag_Processor {
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



fn main() {
	defer {
		rt.shutdown()
	}

}
