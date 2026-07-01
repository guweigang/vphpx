import rt

struct Class_WP_Duotone {
	rt.PhpObjectBase
pub mut:
		global_styles_block_names rt.PhpVal = rt.new_null()
		global_styles_presets rt.PhpVal = rt.new_null()
		used_global_styles_presets rt.PhpVal = rt.new_array()
		used_svg_filter_data rt.PhpVal = rt.new_array()
		block_css_declarations rt.PhpVal = rt.new_array()
}

fn Class_WP_Duotone.colord_clamp(var_number rt.PhpVal, min i64, max i64) rt.PhpVal {
	return if rt.is_true(rt.greater(var_number, rt.new_int(max))) { rt.new_int(max) } else { if rt.is_true(rt.greater(var_number, rt.new_int(min))) { var_number } else { rt.new_int(min) } }
}

fn Class_WP_Duotone.colord_clamp_hue(var_degrees rt.PhpVal) rt.PhpVal {
	mut var_degrees_mutated := var_degrees
	var_degrees_mutated = if rt.is_true(rt.call_function('is_finite', [var_degrees_mutated.dup()])) { rt.mod_(var_degrees_mutated, rt.new_int(360)) } else { rt.new_int(0) }
	return if rt.is_true(rt.greater(var_degrees_mutated, rt.new_int(0))) { var_degrees_mutated } else { rt.add(var_degrees_mutated, rt.new_int(360)) }
}

fn Class_WP_Duotone.colord_parse_hue(var_value rt.PhpVal, unit string) rt.PhpVal {
	mut var_angle_units := rt.create_array([rt.ArrayItem{ key: 'grad', val: 360 / 400 }, rt.ArrayItem{ key: 'turn', val: 360 }, rt.ArrayItem{ key: 'rad', val: rt.div(rt.new_int(360), rt.mul(rt.get_constant('M_PI'), rt.new_int(2))) }])
	mut var_factor := if !(var_angle_units.array_get(unit)).is_null() { var_angle_units.array_get(unit) } else { rt.new_int(1) }
	return rt.mul(// unsupported expression: Expr_Cast_Double, var_factor)
}

fn Class_WP_Duotone.colord_parse_hex(var_hex rt.PhpVal) rt.PhpVal {
	mut var_hex_match := []rt.PhpVal{}
	mut var_hex_mutated := var_hex
	mut var_is_match := rt.call_function('preg_match', [rt.new_string('/^#([0-9a-f]{3,8})$/i'), var_hex_mutated.dup(), var_hex_match.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_match)))) {
		return rt.new_null()
	}
	var_hex_mutated = var_hex_match.array_get(1)
	if 4 >= var_hex_mutated.dup().to_string().len {
		return rt.create_array([rt.ArrayItem{ key: 'r', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'g', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'b', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'a', val: if 4 == var_hex_mutated.dup().to_string().len { rt.call_function('round', [rt.div(// unsupported expression: Expr_Cast_Int, rt.new_int(255)), rt.new_int(2)]) } else { rt.new_int(1) } }])
	}
	if 6 == var_hex_mutated.dup().to_string().len || 8 == var_hex_mutated.dup().to_string().len {
		return rt.create_array([rt.ArrayItem{ key: 'r', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'g', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'b', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'a', val: if 8 == var_hex_mutated.dup().to_string().len { rt.call_function('round', [rt.div(// unsupported expression: Expr_Cast_Int, rt.new_int(255)), rt.new_int(2)]) } else { rt.new_int(1) } }])
	}
	return rt.new_null()
}

fn Class_WP_Duotone.colord_clamp_rgba(var_rgba rt.PhpVal) rt.PhpVal {
	mut var_rgba_mutated := var_rgba
	var_rgba_mutated.array_set('r', Class_WP_Duotone.colord_clamp((var_rgba_mutated.array_get('r')).to_i64(), 0, rt.new_int(255)))
	var_rgba_mutated.array_set('g', Class_WP_Duotone.colord_clamp((var_rgba_mutated.array_get('g')).to_i64(), 0, rt.new_int(255)))
	var_rgba_mutated.array_set('b', Class_WP_Duotone.colord_clamp((var_rgba_mutated.array_get('b')).to_i64(), 0, rt.new_int(255)))
	var_rgba_mutated.array_set('a', Class_WP_Duotone.colord_clamp((var_rgba_mutated.array_get('a')).to_i64()))
	return var_rgba_mutated.dup()
}

fn Class_WP_Duotone.colord_parse_rgba_string(var_input rt.PhpVal) rt.PhpVal {
	mut var_match := rt.new_null()
	mut var_is_match := rt.call_function('preg_match', [rt.new_string('/^rgba?\\(\\s*([+-]?\\d*\\.?\\d+)(%)?\\s*,\\s*([+-]?\\d*\\.?\\d+)(%)?\\s*,\\s*([+-]?\\d*\\.?\\d+)(%)?\\s*(?:,\\s*([+-]?\\d*\\.?\\d+)(%)?\\s*)?\\)$/i'), var_input.dup(), var_match.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_match)))) {
		var_is_match = rt.call_function('preg_match', [rt.new_string('/^rgba?\\(\\s*([+-]?\\d*\\.?\\d+)(%)?\\s+([+-]?\\d*\\.?\\d+)(%)?\\s+([+-]?\\d*\\.?\\d+)(%)?\\s*(?:\\/\\s*([+-]?\\d*\\.?\\d+)(%)?\\s*)?\\)$/i'), var_input.dup(), var_match.dup()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_match)))) {
		return rt.new_null()
	}
	{
		mut var_i := rt.new_int(rt.new_int(1))
		for {
			if !(rt.is_true(rt.less_equal(var_i, rt.new_int(8)))) { break }
			if !(var_match.array_isset(var_i)) {
				var_match.array_set(var_i, '')
			}
			rt.post_inc(var_i)
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	return Class_WP_Duotone.colord_clamp_rgba(rt.create_array([rt.ArrayItem{ key: 'r', val: rt.div(// unsupported expression: Expr_Cast_Double, if rt.is_true(var_match.array_get(2)) { 100 / 255 } else { rt.new_int(1) }) }, rt.ArrayItem{ key: 'g', val: rt.div(// unsupported expression: Expr_Cast_Double, if rt.is_true(var_match.array_get(4)) { 100 / 255 } else { rt.new_int(1) }) }, rt.ArrayItem{ key: 'b', val: rt.div(// unsupported expression: Expr_Cast_Double, if rt.is_true(var_match.array_get(6)) { 100 / 255 } else { rt.new_int(1) }) }, rt.ArrayItem{ key: 'a', val: if rt.is_true(rt.identical(rt.new_string(''), var_match.array_get(7))) { rt.new_int(1) } else { rt.div(// unsupported expression: Expr_Cast_Double, if rt.is_true(var_match.array_get(8)) { rt.new_int(100) } else { rt.new_int(1) }) } }]))
}

fn Class_WP_Duotone.colord_clamp_hsla(var_hsla rt.PhpVal) rt.PhpVal {
	mut var_hsla_mutated := var_hsla
	var_hsla_mutated.array_set('h', Class_WP_Duotone.colord_clamp_hue(var_hsla_mutated.array_get('h')))
	var_hsla_mutated.array_set('s', Class_WP_Duotone.colord_clamp((var_hsla_mutated.array_get('s')).to_i64(), 0, rt.new_int(100)))
	var_hsla_mutated.array_set('l', Class_WP_Duotone.colord_clamp((var_hsla_mutated.array_get('l')).to_i64(), 0, rt.new_int(100)))
	var_hsla_mutated.array_set('a', Class_WP_Duotone.colord_clamp((var_hsla_mutated.array_get('a')).to_i64()))
	return var_hsla_mutated.dup()
}

fn Class_WP_Duotone.colord_hsva_to_rgba(var_hsva rt.PhpVal) rt.PhpVal {
	mut var_h := rt.mul(rt.div(var_hsva.array_get('h'), rt.new_int(360)), rt.new_int(6))
	mut var_s := rt.div(var_hsva.array_get('s'), rt.new_int(100))
	mut var_v := rt.div(var_hsva.array_get('v'), rt.new_int(100))
	mut var_a := var_hsva.array_get('a')
	mut var_hh := rt.call_function('floor', [var_h.dup()])
	mut var_b := rt.mul(var_v, rt.sub(rt.new_int(1), var_s))
	mut var_c := rt.mul(var_v, rt.sub(rt.new_int(1), rt.mul(rt.sub(var_h, var_hh), var_s)))
	mut var_d := rt.mul(var_v, rt.sub(rt.new_int(1), rt.mul(rt.add(rt.sub(rt.new_int(1), var_h), var_hh), var_s)))
	mut var_module := rt.mod_(var_hh, rt.new_int(6))
	return rt.create_array([rt.ArrayItem{ key: 'r', val: rt.mul(rt.create_array([rt.ArrayItem{ key: none, val: var_v }, rt.ArrayItem{ key: none, val: var_c }, rt.ArrayItem{ key: none, val: var_b }, rt.ArrayItem{ key: none, val: var_b }, rt.ArrayItem{ key: none, val: var_d }, rt.ArrayItem{ key: none, val: var_v }]).array_get(var_module), rt.new_int(255)) }, rt.ArrayItem{ key: 'g', val: rt.mul(rt.create_array([rt.ArrayItem{ key: none, val: var_d }, rt.ArrayItem{ key: none, val: var_v }, rt.ArrayItem{ key: none, val: var_v }, rt.ArrayItem{ key: none, val: var_c }, rt.ArrayItem{ key: none, val: var_b }, rt.ArrayItem{ key: none, val: var_b }]).array_get(var_module), rt.new_int(255)) }, rt.ArrayItem{ key: 'b', val: rt.mul(rt.create_array([rt.ArrayItem{ key: none, val: var_b }, rt.ArrayItem{ key: none, val: var_b }, rt.ArrayItem{ key: none, val: var_d }, rt.ArrayItem{ key: none, val: var_v }, rt.ArrayItem{ key: none, val: var_v }, rt.ArrayItem{ key: none, val: var_c }]).array_get(var_module), rt.new_int(255)) }, rt.ArrayItem{ key: 'a', val: var_a }])
}

fn Class_WP_Duotone.colord_hsla_to_hsva(var_hsla rt.PhpVal) rt.PhpVal {
	mut var_hsla_mutated := var_hsla
	mut var_h := var_hsla_mutated.array_get('h')
	mut var_s := var_hsla_mutated.array_get('s')
	mut var_l := var_hsla_mutated.array_get('l')
	mut var_a := var_hsla_mutated.array_get('a')
	// unsupported expression: Expr_AssignOp_Mul
	return rt.create_array([rt.ArrayItem{ key: 'h', val: var_h }, rt.ArrayItem{ key: 's', val: if rt.is_true(rt.greater(var_s, rt.new_int(0))) { rt.mul(rt.div(rt.mul(rt.new_int(2), var_s), rt.add(var_l, var_s)), rt.new_int(100)) } else { rt.new_int(0) } }, rt.ArrayItem{ key: 'v', val: rt.add(var_l, var_s) }, rt.ArrayItem{ key: 'a', val: var_a }])
}

fn Class_WP_Duotone.colord_hsla_to_rgba(var_hsla rt.PhpVal) rt.PhpVal {
	mut var_hsla_mutated := var_hsla
	return Class_WP_Duotone.colord_hsva_to_rgba(Class_WP_Duotone.colord_hsla_to_hsva(var_hsla_mutated.dup()))
}

fn Class_WP_Duotone.colord_parse_hsla_string(var_input rt.PhpVal) rt.PhpVal {
	mut var_match := rt.new_null()
	mut var_is_match := rt.call_function('preg_match', [rt.new_string('/^hsla?\\(\\s*([+-]?\\d*\\.?\\d+)(deg|rad|grad|turn)?\\s*,\\s*([+-]?\\d*\\.?\\d+)%\\s*,\\s*([+-]?\\d*\\.?\\d+)%\\s*(?:,\\s*([+-]?\\d*\\.?\\d+)(%)?\\s*)?\\)$/i'), var_input.dup(), var_match.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_match)))) {
		var_is_match = rt.call_function('preg_match', [rt.new_string('/^hsla?\\(\\s*([+-]?\\d*\\.?\\d+)(deg|rad|grad|turn)?\\s+([+-]?\\d*\\.?\\d+)%\\s+([+-]?\\d*\\.?\\d+)%\\s*(?:\\/\\s*([+-]?\\d*\\.?\\d+)(%)?\\s*)?\\)$/i'), var_input.dup(), var_match.dup()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_match)))) {
		return rt.new_null()
	}
	{
		mut var_i := rt.new_int(rt.new_int(1))
		for {
			if !(rt.is_true(rt.less_equal(var_i, rt.new_int(6)))) { break }
			if !(var_match.array_isset(var_i)) {
				var_match.array_set(var_i, '')
			}
			rt.post_inc(var_i)
		}
	}
	mut var_hsla := Class_WP_Duotone.colord_clamp_hsla(rt.create_array([rt.ArrayItem{ key: 'h', val: Class_WP_Duotone.colord_parse_hue((var_match.array_get(1)).str(), var_match.array_get(2)) }, rt.ArrayItem{ key: 's', val: // unsupported expression: Expr_Cast_Double }, rt.ArrayItem{ key: 'l', val: // unsupported expression: Expr_Cast_Double }, rt.ArrayItem{ key: 'a', val: if rt.is_true(rt.identical(rt.new_string(''), var_match.array_get(5))) { rt.new_int(1) } else { rt.div(// unsupported expression: Expr_Cast_Double, if rt.is_true(var_match.array_get(6)) { rt.new_int(100) } else { rt.new_int(1) }) } }]))
	return Class_WP_Duotone.colord_hsla_to_rgba(var_hsla.dup())
}

fn Class_WP_Duotone.colord_parse(var_input rt.PhpVal) rt.PhpVal {
	mut var_result := Class_WP_Duotone.colord_parse_hex(var_input.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		var_result = Class_WP_Duotone.colord_parse_rgba_string(var_input.dup())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		var_result = Class_WP_Duotone.colord_parse_hsla_string(var_input.dup())
	}
	return var_result.dup()
}

fn Class_WP_Duotone.get_slug_from_attribute(var_duotone_attr rt.PhpVal) string {
	mut var_matches := rt.new_null()
	mut var_duotone_attr_mutated := var_duotone_attr
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_duotone_attr_mutated.dup().is_string()))))) {
		return ''
	}
	rt.call_function('preg_match', [rt.new_string('/(?|var:preset\\|duotone\\|(\\S+)|var\\(--wp--preset--duotone--(\\S+)\\))/'), var_duotone_attr_mutated.dup(), var_matches.dup()])
	return (if !(!rt.is_true(var_matches.array_get(1))) { var_matches.array_get(1) } else { rt.new_string('') }).str()
}

fn Class_WP_Duotone.is_preset(var_duotone_attr rt.PhpVal) bool {
	mut var_duotone_attr_mutated := var_duotone_attr
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_duotone_attr_mutated.dup().is_string()))))) {
		return false
	}
	mut var_slug := Class_WP_Duotone.get_slug_from_attribute(var_duotone_attr_mutated.dup())
	mut var_filter_id := Class_WP_Duotone.get_filter_id(var_slug.dup())
	return Class_WP_Duotone.get_all_global_styles_presets().array_isset(var_filter_id.dup())
}

fn Class_WP_Duotone.get_css_custom_property_name(var_slug rt.PhpVal) string {
	mut var_slug_mutated := var_slug
	return "--wp--preset--duotone--${var_slug.to_string()}"
}

fn Class_WP_Duotone.get_filter_id(var_slug rt.PhpVal) string {
	mut var_slug_mutated := var_slug
	return "wp-duotone-${var_slug.to_string()}"
}

fn Class_WP_Duotone.get_css_var(var_slug rt.PhpVal) string {
	mut var_slug_mutated := var_slug
	mut var_name := Class_WP_Duotone.get_css_custom_property_name(var_slug_mutated.dup())
	return "var(${var_name.to_string()})"
}

fn Class_WP_Duotone.get_filter_url(var_filter_id rt.PhpVal) string {
	mut var_filter_id_mutated := var_filter_id
	return "url(#${var_filter_id.to_string()})"
}

fn Class_WP_Duotone.get_filter_svg(var_filter_id rt.PhpVal, var_colors rt.PhpVal) rt.PhpVal {
	mut var_filter_id_mutated := var_filter_id
	mut var_colors_mutated := var_colors
	mut var_duotone_values := { 'r': map[string]rt.PhpVal{}, 'g': map[string]rt.PhpVal{}, 'b': map[string]rt.PhpVal{}, 'a': map[string]rt.PhpVal{} }
	{
		mut iter_1 := var_colors_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_color_str := item_1.val
			mut var_color := Class_WP_Duotone.colord_parse(var_color_str.dup())
			if rt.is_true(rt.identical(rt.new_null(), var_color)) {
				mut var_error_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('"%1$s" in %2$s %3$s is not a hex or rgb string.')]), var_color_str.dup(), rt.new_string('theme.json'), rt.new_string('settings.color.duotone')])
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), var_error_message.dup(), rt.new_string('6.3.0')])
			} else {
				var_duotone_values.array_get_mut('r').array_push(rt.div(var_color.array_get('r'), rt.new_int(255)))
				var_duotone_values.array_get_mut('g').array_push(rt.div(var_color.array_get('g'), rt.new_int(255)))
				var_duotone_values.array_get_mut('b').array_push(rt.div(var_color.array_get('b'), rt.new_int(255)))
				var_duotone_values.array_get_mut('a').array_push(var_color.array_get('a'))
			}
		}
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_filter_id_mutated.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), var_duotone_values.array_get('r')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), var_duotone_values.array_get('g')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), var_duotone_values.array_get('b')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), var_duotone_values.array_get('a')])]))
	// unsupported statement: Stmt_InlineHTML
	mut var_svg := rt.call_function('ob_get_clean', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('SCRIPT_DEBUG'))))) {
		var_svg = rt.call_function('preg_replace', [rt.new_string('/[\r\n\t ]+/'), rt.new_string(' '), var_svg.dup()])
		var_svg = rt.call_function('str_replace', [rt.new_string('> <'), rt.new_string('><'), var_svg.dup()])
		var_svg = rt.new_string(rt.new_string(var_svg.dup().to_string().trim_space()))
	}
	return var_svg.dup()
}

fn Class_WP_Duotone.get_filter_id_from_preset(var_preset rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('6.3.0')])
	mut var_filter_id := rt.new_string(rt.new_string(''))
	if var_preset.array_isset(rt.new_string('slug')) {
		
	}
	return .dup()
}

fn Class_WP_Duotone.get_filter_svg_from_preset(var_preset rt.PhpVal) rt.PhpVal {
}

fn Class_WP_Duotone.get_svg_definitions(var_sources rt.PhpVal) rt.PhpVal {
}

fn Class_WP_Duotone.get_global_styles_presets(var_sources rt.PhpVal) rt.PhpVal {
}

fn Class_WP_Duotone.enqueue_block_css(var_filter_id rt.PhpVal, var_duotone_selector rt.PhpVal, var_filter_value rt.PhpVal)  {
	mut var_filter_id_mutated := var_filter_id
	mut var_duotone_selector_mutated := var_duotone_selector
	mut var_filter_value_mutated := var_filter_value
}

fn Class_WP_Duotone.enqueue_custom_filter(var_filter_id rt.PhpVal, var_duotone_selector rt.PhpVal, var_filter_value rt.PhpVal, var_filter_data rt.PhpVal)  {
	mut var_filter_id_mutated := var_filter_id
	mut var_duotone_selector_mutated := var_duotone_selector
	mut var_filter_value_mutated := var_filter_value
	mut var_filter_data_mutated := var_filter_data
}

fn Class_WP_Duotone.enqueue_global_styles_preset(var_filter_id rt.PhpVal, var_duotone_selector rt.PhpVal, var_filter_value rt.PhpVal)  {
	mut var_filter_id_mutated := var_filter_id
	mut var_duotone_selector_mutated := var_duotone_selector
	mut var_filter_value_mutated := var_filter_value
}

fn Class_WP_Duotone.register_duotone_support(var_block_type rt.PhpVal)  {
	mut var_block_type_mutated := var_block_type
}

fn Class_WP_Duotone.get_selector(var_block_type rt.PhpVal) rt.PhpVal {
	mut var_block_type_mutated := var_block_type
}

fn Class_WP_Duotone.get_all_global_styles_presets() rt.PhpVal {
}

fn Class_WP_Duotone.get_all_global_style_block_names() rt.PhpVal {
}

fn Class_WP_Duotone.render_duotone_support(var_block_content rt.PhpVal, var_block rt.PhpVal, var_wp_block rt.PhpVal) rt.PhpVal {
}

fn Class_WP_Duotone.restore_image_outer_container(var_block_content rt.PhpVal) rt.PhpVal {
}

fn Class_WP_Duotone.output_block_styles()  {
}

fn Class_WP_Duotone.output_global_styles()  {
}

fn Class_WP_Duotone.output_footer_assets()  {
}

fn Class_WP_Duotone.add_editor_settings(var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
}

fn Class_WP_Duotone.migrate_experimental_duotone_support_flag(var_settings rt.PhpVal, var_metadata rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
}

fn Class_WP_Duotone.get_filter_css_property_value_from_preset(var_preset rt.PhpVal) string {
}

fn create_wp_duotone() &Class_WP_Duotone {
	mut obj := &Class_WP_Duotone{
		PhpObjectBase: rt.PhpObjectBase{}
		global_styles_block_names: rt.new_null()
		global_styles_presets: rt.new_null()
		used_global_styles_presets: rt.new_array()
		used_svg_filter_data: rt.new_array()
		block_css_declarations: rt.new_array()
	}
	return obj
}

fn (mut this Class_WP_Duotone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'colord_clamp' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return Class_WP_Duotone.colord_clamp(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'colord_clamp_hue' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Duotone.colord_clamp_hue(dispatch_arg_0)
		}
		'colord_parse_hue' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_WP_Duotone.colord_parse_hue(dispatch_arg_0, dispatch_arg_1)
		}
		'colord_parse_hex' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Duotone.colord_parse_hex(dispatch_arg_0)
		}
		'colord_clamp_rgba' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Duotone.colord_clamp_rgba(dispatch_arg_0)
		}
		'colord_parse_rgba_string' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Duotone.colord_parse_rgba_string(dispatch_arg_0)
		}
		'colord_clamp_hsla' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Duotone.colord_clamp_hsla(dispatch_arg_0)
		}
		'colord_hsva_to_rgba' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Duotone.colord_hsva_to_rgba(dispatch_arg_0)
		}
		'colord_hsla_to_hsva' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Duotone.colord_hsla_to_hsva(dispatch_arg_0)
		}
		'colord_hsla_to_rgba' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Duotone.colord_hsla_to_rgba(dispatch_arg_0)
		}
		'colord_parse_hsla_string' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Duotone.colord_parse_hsla_string(dispatch_arg_0)
		}
		'colord_parse' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Duotone.colord_parse(dispatch_arg_0)
		}
		'get_slug_from_attribute' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WP_Duotone.get_slug_from_attribute(dispatch_arg_0))
		}
		'is_preset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Duotone.is_preset(dispatch_arg_0))
		}
		'get_css_custom_property_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WP_Duotone.get_css_custom_property_name(dispatch_arg_0))
		}
		'get_filter_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WP_Duotone.get_filter_id(dispatch_arg_0))
		}
		'get_css_var' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WP_Duotone.get_css_var(dispatch_arg_0))
		}
		'get_filter_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WP_Duotone.get_filter_url(dispatch_arg_0))
		}
		'get_filter_svg' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Duotone.get_filter_svg(dispatch_arg_0, dispatch_arg_1)
		}
		'get_filter_id_from_preset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Duotone.get_filter_id_from_preset(dispatch_arg_0)
		}
		'get_filter_svg_from_preset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Duotone.get_filter_svg_from_preset(dispatch_arg_0)
		}
		'get_svg_definitions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Duotone.get_svg_definitions(dispatch_arg_0)
		}
		'get_global_styles_presets' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Duotone.get_global_styles_presets(dispatch_arg_0)
		}
		'enqueue_block_css' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_WP_Duotone.enqueue_block_css(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'enqueue_custom_filter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			Class_WP_Duotone.enqueue_custom_filter(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'enqueue_global_styles_preset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_WP_Duotone.enqueue_global_styles_preset(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'register_duotone_support' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WP_Duotone.register_duotone_support(dispatch_arg_0)
			return rt.new_null()
		}
		'get_selector' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Duotone.get_selector(dispatch_arg_0)
		}
		'get_all_global_styles_presets' {
			return Class_WP_Duotone.get_all_global_styles_presets()
		}
		'get_all_global_style_block_names' {
			return Class_WP_Duotone.get_all_global_style_block_names()
		}
		'render_duotone_support' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WP_Duotone.render_duotone_support(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'restore_image_outer_container' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Duotone.restore_image_outer_container(dispatch_arg_0)
		}
		'output_block_styles' {
			Class_WP_Duotone.output_block_styles()
			return rt.new_null()
		}
		'output_global_styles' {
			Class_WP_Duotone.output_global_styles()
			return rt.new_null()
		}
		'output_footer_assets' {
			Class_WP_Duotone.output_footer_assets()
			return rt.new_null()
		}
		'add_editor_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Duotone.add_editor_settings(dispatch_arg_0)
		}
		'migrate_experimental_duotone_support_flag' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Duotone.migrate_experimental_duotone_support_flag(dispatch_arg_0, dispatch_arg_1)
		}
		'get_filter_css_property_value_from_preset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WP_Duotone.get_filter_css_property_value_from_preset(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_WP_Duotone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'global_styles_block_names' { return this.global_styles_block_names }
		'global_styles_presets' { return this.global_styles_presets }
		'used_global_styles_presets' { return this.used_global_styles_presets }
		'used_svg_filter_data' { return this.used_svg_filter_data }
		'block_css_declarations' { return this.block_css_declarations }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Duotone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'global_styles_block_names' { this.global_styles_block_names = val; return true }
		'global_styles_presets' { this.global_styles_presets = val; return true }
		'used_global_styles_presets' { this.used_global_styles_presets = val; return true }
		'used_svg_filter_data' { this.used_svg_filter_data = val; return true }
		'block_css_declarations' { this.block_css_declarations = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_class_wp_duotone_php() {
}
