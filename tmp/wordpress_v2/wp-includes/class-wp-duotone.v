import rt

struct Class_WP_Duotone {
	rt.PhpObjectBase
}

fn init_static_wp_duotone() {
	rt.init_static_prop('WP_Duotone', 'global_styles_block_names', rt.new_null())
	rt.init_static_prop('WP_Duotone', 'global_styles_presets', rt.new_null())
	rt.init_static_prop('WP_Duotone', 'used_global_styles_presets', rt.new_array())
	rt.init_static_prop('WP_Duotone', 'used_svg_filter_data', rt.new_array())
	rt.init_static_prop('WP_Duotone', 'block_css_declarations', rt.new_array())
}

fn Class_WP_Duotone.colord_clamp(var_number rt.PhpVal, min i64, max i64) rt.PhpVal {
	return if rt.is_true(rt.greater(var_number, rt.new_int(max))) {
		rt.new_int(max)
	} else {
		if rt.is_true(rt.greater(var_number, rt.new_int(min))) {
			var_number
		} else {
			rt.new_int(min)
		}
	}
}

fn Class_WP_Duotone.colord_clamp_hue(var_degrees rt.PhpVal) rt.PhpVal {
	mut var_degrees_mutated := var_degrees
	var_degrees_mutated = if rt.call_function('is_finite', [var_degrees_mutated.clone()]) {
		rt.mod_(var_degrees_mutated, rt.new_int(360))
	} else {
		rt.new_int(0)
	}
	return if rt.is_true(rt.greater(var_degrees_mutated, rt.new_int(0))) {
		var_degrees_mutated
	} else {
		rt.add(var_degrees_mutated, rt.new_int(360))
	}
}

fn Class_WP_Duotone.colord_parse_hue(var_value rt.PhpVal, unit string) f64 {
	mut var_angle_units := rt.create_array([rt.ArrayItem{ key: 'grad', val: 360 / 400 },
		rt.ArrayItem{ key: 'turn', val: 360 }, rt.ArrayItem{ key: 'rad', val: rt.div(rt.new_int(360), rt.mul(rt.get_constant('M_PI'),
			rt.new_int(2))) }])
	mut var_factor := if !(var_angle_units.array_get(rt.new_string(unit))).is_null() {
		var_angle_units.array_get(rt.new_string(unit))
	} else {
		rt.new_int(1)
	}
	return rt.new_float(var_value.to_f64()) * var_factor
}

fn Class_WP_Duotone.colord_parse_hex(var_hex rt.PhpVal) rt.PhpVal {
	mut var_hex_match := []rt.PhpVal{}
	mut var_hex_mutated := var_hex
	mut var_is_match := rt.call_function('preg_match', [
		rt.new_string('/^#([0-9a-f]{3,8})$/i'),
		var_hex_mutated.clone(),
		rt.create_array_from_list(var_hex_match),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_match)))) {
		return rt.new_null()
	}
	var_hex_mutated = var_hex_match.array_get(rt.new_int(1))
	if 4 >= var_hex_mutated.clone().to_string().len {
		return rt.create_array([
			rt.ArrayItem{ key: 'r', val: rt.new_int((rt.call_function('base_convert', [
				rt.new_string((var_hex_mutated.array_get(rt.new_int(0))).str() +
					(var_hex_mutated.array_get(rt.new_int(0))).str()),
				rt.new_int(16),
				rt.new_int(10),
			])).to_i64()) },
			rt.ArrayItem{ key: 'g', val: rt.new_int((rt.call_function('base_convert', [
				rt.new_string((var_hex_mutated.array_get(rt.new_int(1))).str() +
					(var_hex_mutated.array_get(rt.new_int(1))).str()),
				rt.new_int(16),
				rt.new_int(10),
			])).to_i64()) },
			rt.ArrayItem{ key: 'b', val: rt.new_int((rt.call_function('base_convert', [
				rt.new_string((var_hex_mutated.array_get(rt.new_int(2))).str() +
					(var_hex_mutated.array_get(rt.new_int(2))).str()),
				rt.new_int(16),
				rt.new_int(10),
			])).to_i64()) },
			rt.ArrayItem{
				key: 'a'
				val: if 4 == var_hex_mutated.clone().to_string().len { rt.call_function('round', [
						rt.new_int((rt.call_function('base_convert', [
							rt.new_string((var_hex_mutated.array_get(rt.new_int(3))).str() + (var_hex_mutated.array_get(rt.new_int(3))).str()),
							rt.new_int(16),
							rt.new_int(10),
						])).to_i64()) / 255,
						rt.new_int(2),
					]) } else { rt.new_int(1) }
			},
		])
	}
	if 6 == var_hex_mutated.clone().to_string().len || 8 == var_hex_mutated.clone().to_string().len {
		return rt.create_array([
			rt.ArrayItem{ key: 'r', val: rt.new_int((rt.call_function('base_convert', [
				rt.call_function('substr', [var_hex_mutated.clone(),
					rt.new_int(0), rt.new_int(2)]),
				rt.new_int(16),
				rt.new_int(10),
			])).to_i64()) },
			rt.ArrayItem{ key: 'g', val: rt.new_int((rt.call_function('base_convert', [
				rt.call_function('substr', [var_hex_mutated.clone(),
					rt.new_int(2), rt.new_int(2)]),
				rt.new_int(16),
				rt.new_int(10),
			])).to_i64()) },
			rt.ArrayItem{ key: 'b', val: rt.new_int((rt.call_function('base_convert', [
				rt.call_function('substr', [var_hex_mutated.clone(),
					rt.new_int(4), rt.new_int(2)]),
				rt.new_int(16),
				rt.new_int(10),
			])).to_i64()) },
			rt.ArrayItem{
				key: 'a'
				val: if 8 == var_hex_mutated.clone().to_string().len { rt.call_function('round', [
						rt.new_int((rt.call_function('base_convert', [
							rt.call_function('substr', [var_hex_mutated.clone(),
								rt.new_int(6), rt.new_int(2)]),
							rt.new_int(16), rt.new_int(10)])).to_i64()) / 255,
						rt.new_int(2),
					]) } else { rt.new_int(1) }
			},
		])
	}
	return rt.new_null()
}

fn Class_WP_Duotone.colord_clamp_rgba(var_rgba rt.PhpVal) rt.PhpVal {
	mut var_rgba_mutated := var_rgba
	var_rgba_mutated.array_set('r', Class_WP_Duotone.colord_clamp((var_rgba_mutated.array_get(rt.new_string('r'))).to_i64(),
		0, rt.new_int(255)))
	var_rgba_mutated.array_set('g', Class_WP_Duotone.colord_clamp((var_rgba_mutated.array_get(rt.new_string('g'))).to_i64(),
		0, rt.new_int(255)))
	var_rgba_mutated.array_set('b', Class_WP_Duotone.colord_clamp((var_rgba_mutated.array_get(rt.new_string('b'))).to_i64(),
		0, rt.new_int(255)))
	var_rgba_mutated.array_set('a',
		Class_WP_Duotone.colord_clamp((var_rgba_mutated.array_get(rt.new_string('a'))).to_i64()))
	return var_rgba_mutated.clone()
}

fn Class_WP_Duotone.colord_parse_rgba_string(var_input rt.PhpVal) rt.PhpVal {
	mut var_match := rt.new_null()
	mut var_is_match := rt.call_function('preg_match', [
		rt.new_string('/^rgba?\\(\\s*([+-]?\\d*\\.?\\d+)(%)?\\s*,\\s*([+-]?\\d*\\.?\\d+)(%)?\\s*,\\s*([+-]?\\d*\\.?\\d+)(%)?\\s*(?:,\\s*([+-]?\\d*\\.?\\d+)(%)?\\s*)?\\)$/i'),
		var_input.clone(),
		var_match.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_match)))) {
		var_is_match = rt.call_function('preg_match', [
			rt.new_string('/^rgba?\\(\\s*([+-]?\\d*\\.?\\d+)(%)?\\s+([+-]?\\d*\\.?\\d+)(%)?\\s+([+-]?\\d*\\.?\\d+)(%)?\\s*(?:\\/\\s*([+-]?\\d*\\.?\\d+)(%)?\\s*)?\\)$/i'),
			var_input.clone(),
			var_match.clone(),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_match)))) {
		return rt.new_null()
	}
	mut var_i := rt.new_int(1)
	for {
		if !(rt.is_true(rt.less_equal(var_i, rt.new_int(8)))) { break
		 }
		if !(var_match.array_isset(var_i)) {
			var_match.array_set(var_i, '')
		}
		rt.post_inc(var_i)
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_match.array_get(rt.new_int(2)), var_match.array_get(rt.new_int(4))))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_match.array_get(rt.new_int(4)), var_match.array_get(rt.new_int(6)))))) {
		return rt.new_null()
	}
	return Class_WP_Duotone.colord_clamp_rgba(rt.create_array([
		rt.ArrayItem{ key: 'r', val: rt.new_float((var_match.array_get(rt.new_int(1))).to_f64()) / if rt.is_true(var_match.array_get(rt.new_int(2))) {
			100 / 255
		} else {
			1
		} },
		rt.ArrayItem{ key: 'g', val: rt.new_float((var_match.array_get(rt.new_int(3))).to_f64()) / if rt.is_true(var_match.array_get(rt.new_int(4))) {
			100 / 255
		} else {
			1
		} },
		rt.ArrayItem{ key: 'b', val: rt.new_float((var_match.array_get(rt.new_int(5))).to_f64()) / if rt.is_true(var_match.array_get(rt.new_int(6))) {
			100 / 255
		} else {
			1
		} },
		rt.ArrayItem{
			key: 'a'
			val: if rt.is_true(rt.identical(rt.new_string(''), var_match.array_get(rt.new_int(7)))) { rt.new_int(1) } else { rt.new_float((var_match.array_get(rt.new_int(7))).to_f64()) / if rt.is_true(var_match.array_get(rt.new_int(8))) {
					100
				} else {
					1
				}
			 }
		},
	]))
}

fn Class_WP_Duotone.colord_clamp_hsla(var_hsla rt.PhpVal) rt.PhpVal {
	mut var_hsla_mutated := var_hsla
	var_hsla_mutated.array_set('h',
		Class_WP_Duotone.colord_clamp_hue(var_hsla_mutated.array_get(rt.new_string('h'))))
	var_hsla_mutated.array_set('s', Class_WP_Duotone.colord_clamp((var_hsla_mutated.array_get(rt.new_string('s'))).to_i64(),
		0, rt.new_int(100)))
	var_hsla_mutated.array_set('l', Class_WP_Duotone.colord_clamp((var_hsla_mutated.array_get(rt.new_string('l'))).to_i64(),
		0, rt.new_int(100)))
	var_hsla_mutated.array_set('a',
		Class_WP_Duotone.colord_clamp((var_hsla_mutated.array_get(rt.new_string('a'))).to_i64()))
	return var_hsla_mutated.clone()
}

fn Class_WP_Duotone.colord_hsva_to_rgba(var_hsva rt.PhpVal) rt.PhpVal {
	mut var_h := rt.mul(rt.div(var_hsva.array_get(rt.new_string('h')), rt.new_int(360)),
		rt.new_int(6))
	mut var_s := rt.div(var_hsva.array_get(rt.new_string('s')), rt.new_int(100))
	mut var_v := rt.div(var_hsva.array_get(rt.new_string('v')), rt.new_int(100))
	mut var_a := var_hsva.array_get(rt.new_string('a'))
	mut var_hh := rt.call_function('floor', [var_h.clone()])
	mut var_b := rt.mul(var_v, rt.sub(rt.new_int(1), var_s))
	mut var_c := rt.mul(var_v, rt.sub(rt.new_int(1), rt.mul(rt.sub(var_h, var_hh), var_s)))
	mut var_d := rt.mul(var_v, rt.sub(rt.new_int(1), rt.mul(rt.add(rt.sub(rt.new_int(1), var_h),
		var_hh), var_s)))
	mut var_module := rt.mod_(var_hh, rt.new_int(6))
	return rt.create_array([
		rt.ArrayItem{ key: 'r', val: rt.mul(rt.create_array([
			rt.ArrayItem{ key: none, val: var_v },
			rt.ArrayItem{ key: none, val: var_c },
			rt.ArrayItem{ key: none, val: var_b },
			rt.ArrayItem{ key: none, val: var_b },
			rt.ArrayItem{ key: none, val: var_d },
			rt.ArrayItem{ key: none, val: var_v },
		]).array_get(var_module), rt.new_int(255)) },
		rt.ArrayItem{ key: 'g', val: rt.mul(rt.create_array([
			rt.ArrayItem{ key: none, val: var_d },
			rt.ArrayItem{ key: none, val: var_v },
			rt.ArrayItem{ key: none, val: var_v },
			rt.ArrayItem{ key: none, val: var_c },
			rt.ArrayItem{ key: none, val: var_b },
			rt.ArrayItem{ key: none, val: var_b },
		]).array_get(var_module), rt.new_int(255)) },
		rt.ArrayItem{ key: 'b', val: rt.mul(rt.create_array([
			rt.ArrayItem{ key: none, val: var_b },
			rt.ArrayItem{ key: none, val: var_b },
			rt.ArrayItem{ key: none, val: var_d },
			rt.ArrayItem{ key: none, val: var_v },
			rt.ArrayItem{ key: none, val: var_v },
			rt.ArrayItem{ key: none, val: var_c },
		]).array_get(var_module), rt.new_int(255)) },
		rt.ArrayItem{ key: 'a', val: var_a },
	])
}

fn Class_WP_Duotone.colord_hsla_to_hsva(var_hsla rt.PhpVal) rt.PhpVal {
	mut var_hsla_mutated := var_hsla
	mut var_h := var_hsla_mutated.array_get(rt.new_string('h'))
	mut var_s := var_hsla_mutated.array_get(rt.new_string('s'))
	mut var_l := var_hsla_mutated.array_get(rt.new_string('l'))
	mut var_a := var_hsla_mutated.array_get(rt.new_string('a'))
	var_s = rt.mul(var_s, rt.div(if rt.is_true(rt.less(var_l, rt.new_int(50))) {
		var_l
	} else {
		rt.sub(rt.new_int(100), var_l)
	}, rt.new_int(100)))
	return rt.create_array([rt.ArrayItem{ key: 'h', val: var_h },
		rt.ArrayItem{
			key: 's'
			val: if rt.is_true(rt.greater(var_s, rt.new_int(0))) {
				rt.mul(rt.div(rt.mul(rt.new_int(2), var_s), rt.add(var_l, var_s)), rt.new_int(100))
			} else {
				rt.new_int(0)
			}
		}, rt.ArrayItem{ key: 'v', val: rt.add(var_l, var_s) },
		rt.ArrayItem{ key: 'a', val: var_a }])
}

fn Class_WP_Duotone.colord_hsla_to_rgba(var_hsla rt.PhpVal) rt.PhpVal {
	mut var_hsla_mutated := var_hsla
	return Class_WP_Duotone.colord_hsva_to_rgba(Class_WP_Duotone.colord_hsla_to_hsva(var_hsla_mutated.clone()))
}

fn Class_WP_Duotone.colord_parse_hsla_string(var_input rt.PhpVal) rt.PhpVal {
	mut var_match := rt.new_null()
	mut var_is_match := rt.call_function('preg_match', [
		rt.new_string('/^hsla?\\(\\s*([+-]?\\d*\\.?\\d+)(deg|rad|grad|turn)?\\s*,\\s*([+-]?\\d*\\.?\\d+)%\\s*,\\s*([+-]?\\d*\\.?\\d+)%\\s*(?:,\\s*([+-]?\\d*\\.?\\d+)(%)?\\s*)?\\)$/i'),
		var_input.clone(),
		var_match.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_match)))) {
		var_is_match = rt.call_function('preg_match', [
			rt.new_string('/^hsla?\\(\\s*([+-]?\\d*\\.?\\d+)(deg|rad|grad|turn)?\\s+([+-]?\\d*\\.?\\d+)%\\s+([+-]?\\d*\\.?\\d+)%\\s*(?:\\/\\s*([+-]?\\d*\\.?\\d+)(%)?\\s*)?\\)$/i'),
			var_input.clone(),
			var_match.clone(),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_match)))) {
		return rt.new_null()
	}
	mut var_i := rt.new_int(1)
	for {
		if !(rt.is_true(rt.less_equal(var_i, rt.new_int(6)))) { break
		 }
		if !(var_match.array_isset(var_i)) {
			var_match.array_set(var_i, '')
		}
		rt.post_inc(var_i)
	}
	mut var_hsla := Class_WP_Duotone.colord_clamp_hsla(rt.create_array([
		rt.ArrayItem{ key: 'h', val: Class_WP_Duotone.colord_parse_hue((var_match.array_get(rt.new_int(1))).str(),
			var_match.array_get(rt.new_int(2))) },
		rt.ArrayItem{ key: 's', val: rt.new_float((var_match.array_get(rt.new_int(3))).to_f64()) },
		rt.ArrayItem{ key: 'l', val: rt.new_float((var_match.array_get(rt.new_int(4))).to_f64()) },
		rt.ArrayItem{
			key: 'a'
			val: if rt.is_true(rt.identical(rt.new_string(''), var_match.array_get(rt.new_int(5)))) { rt.new_int(1) } else { rt.new_float((var_match.array_get(rt.new_int(5))).to_f64()) / if rt.is_true(var_match.array_get(rt.new_int(6))) {
					100
				} else {
					1
				}
			 }
		},
	]))
	return Class_WP_Duotone.colord_hsla_to_rgba(var_hsla.clone())
}

fn Class_WP_Duotone.colord_parse(var_input rt.PhpVal) rt.PhpVal {
	mut var_result := Class_WP_Duotone.colord_parse_hex(var_input.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		var_result = Class_WP_Duotone.colord_parse_rgba_string(var_input.clone())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		var_result = Class_WP_Duotone.colord_parse_hsla_string(var_input.clone())
	}
	return var_result.clone()
}

fn Class_WP_Duotone.get_slug_from_attribute(var_duotone_attr rt.PhpVal) string {
	mut var_matches := rt.new_null()
	mut var_duotone_attr_mutated := var_duotone_attr
	if !(var_duotone_attr_mutated.clone().is_string()) {
		return ''
	}
	rt.call_function('preg_match', [
		rt.new_string('/(?|var:preset\\|duotone\\|(\\S+)|var\\(--wp--preset--duotone--(\\S+)\\))/'),
		var_duotone_attr_mutated.clone(),
		var_matches.clone(),
	])
	return (if !(!rt.is_true(var_matches.array_get(rt.new_int(1)))) {
		var_matches.array_get(rt.new_int(1))
	} else {
		rt.new_string('')
	}).str()
}

fn Class_WP_Duotone.is_preset(var_duotone_attr rt.PhpVal) bool {
	mut var_duotone_attr_mutated := var_duotone_attr
	if !(var_duotone_attr_mutated.clone().is_string()) {
		return false
	}
	mut var_slug := Class_WP_Duotone.get_slug_from_attribute(var_duotone_attr_mutated.clone())
	mut var_filter_id := Class_WP_Duotone.get_filter_id(var_slug.clone())
	return Class_WP_Duotone.get_all_global_styles_presets().array_isset(var_filter_id.clone())
}

fn Class_WP_Duotone.get_css_custom_property_name(var_slug rt.PhpVal) string {
	mut var_slug_mutated := var_slug
	return '--wp--preset--duotone--${var_slug.to_string()}'
}

fn Class_WP_Duotone.get_filter_id(var_slug rt.PhpVal) string {
	mut var_slug_mutated := var_slug
	return 'wp-duotone-${var_slug.to_string()}'
}

fn Class_WP_Duotone.get_css_var(var_slug rt.PhpVal) string {
	mut var_slug_mutated := var_slug
	mut var_name := Class_WP_Duotone.get_css_custom_property_name(var_slug_mutated.clone())
	return 'var(${var_name.to_string()})'
}

fn Class_WP_Duotone.get_filter_url(var_filter_id rt.PhpVal) string {
	mut var_filter_id_mutated := var_filter_id
	return 'url(#${var_filter_id.to_string()})'
}

fn Class_WP_Duotone.get_filter_svg(var_filter_id rt.PhpVal, var_colors rt.PhpVal) rt.PhpVal {
	mut var_filter_id_mutated := var_filter_id
	mut var_colors_mutated := var_colors
	mut var_duotone_values := {
		'r': rt.new_array()
		'g': rt.new_array()
		'b': rt.new_array()
		'a': rt.new_array()
	}
	mut iter_1 := var_colors_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_color_str := item_1.val
		mut var_color := Class_WP_Duotone.colord_parse(var_color_str.clone())
		if rt.is_true(rt.identical(rt.new_null(), var_color)) {
			mut var_error_message := rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('"%1$s" in %2$s %3$s is not a hex or rgb string.'),
				]),
				var_color_str.clone(),
				rt.new_string('theme.json'),
				rt.new_string('settings.color.duotone'),
			])
			rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
				var_error_message.clone(), rt.new_string('6.3.0')])
		} else {
			var_duotone_values.array_get_mut('r').array_push(rt.div(var_color.array_get(rt.new_string('r')),
				rt.new_int(255)))
			var_duotone_values.array_get_mut('g').array_push(rt.div(var_color.array_get(rt.new_string('g')),
				rt.new_int(255)))
			var_duotone_values.array_get_mut('b').array_push(rt.div(var_color.array_get(rt.new_string('b')),
				rt.new_int(255)))
			var_duotone_values.array_get_mut('a').array_push(var_color.array_get(rt.new_string('a')))
		}
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_filter_id_mutated.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('implode', [rt.new_string(' '), var_duotone_values['r']]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('implode', [rt.new_string(' '), var_duotone_values['g']]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('implode', [rt.new_string(' '), var_duotone_values['b']]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('implode', [rt.new_string(' '), var_duotone_values['a']]),
	]))
	// unsupported statement: Stmt_InlineHTML
	mut var_svg := rt.call_function('ob_get_clean', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('SCRIPT_DEBUG'))))) {
		var_svg = rt.call_function('preg_replace', [rt.new_string('/[\r\n\t ]+/'),
			rt.new_string(' '), var_svg.clone()])
		var_svg = rt.call_function('str_replace', [rt.new_string('> <'),
			rt.new_string('><'), var_svg.clone()])
		var_svg = rt.new_string(var_svg.clone().to_string().trim_space())
	}
	return var_svg.clone()
}

fn Class_WP_Duotone.get_filter_id_from_preset(var_preset rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.3.0')])
	mut var_filter_id := rt.new_string('')
	if var_preset.array_isset(rt.new_string('slug')) {
		var_filter_id = Class_WP_Duotone.get_filter_id(var_preset.array_get(rt.new_string('slug')))
	}
	return var_filter_id.clone()
}

fn Class_WP_Duotone.get_filter_svg_from_preset(var_preset rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.3.0')])
	mut var_filter_id := Class_WP_Duotone.get_filter_id_from_preset(var_preset.clone())
	return Class_WP_Duotone.get_filter_svg(var_filter_id.clone(),
		var_preset.array_get(rt.new_string('colors')))
}

fn Class_WP_Duotone.get_svg_definitions(var_sources rt.PhpVal) rt.PhpVal {
	mut var_svgs := rt.new_string('')
	mut iter_2 := var_sources.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_filter_data := item_2.val
		mut var_filter_id := item_2.key
		mut var_colors := var_filter_data.array_get(rt.new_string('colors'))
		var_svgs = rt.concat(var_svgs, Class_WP_Duotone.get_filter_svg(var_filter_id.clone(),
			var_colors.clone()))
	}
	return var_svgs.clone()
}

fn Class_WP_Duotone.get_global_styles_presets(var_sources rt.PhpVal) rt.PhpVal {
	mut var_css := rt.new_string((Class_WP_Theme_JSON.root_css_properties_selector()).str() + '{')
	mut iter_3 := var_sources.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_filter_data := item_3.val
		mut var_filter_id := item_3.key
		mut var_slug := var_filter_data.array_get(rt.new_string('slug'))
		mut var_colors := var_filter_data.array_get(rt.new_string('colors'))
		mut var_css_property_name := Class_WP_Duotone.get_css_custom_property_name(var_slug.clone())
		mut var_declaration_value := if var_colors.clone().is_string() {
			var_colors
		} else {
			Class_WP_Duotone.get_filter_url(var_filter_id.clone())
		}
		var_css = rt.concat(var_css,
			rt.new_string('${var_css_property_name.to_string()}:${var_declaration_value.to_string()};'))
	}
	var_css = rt.concat(var_css, rt.new_string('}'))
	return var_css.clone()
}

fn Class_WP_Duotone.enqueue_block_css(var_filter_id rt.PhpVal, var_duotone_selector rt.PhpVal, var_filter_value rt.PhpVal) {
	mut var_filter_id_mutated := var_filter_id
	mut var_duotone_selector_mutated := var_duotone_selector
	mut var_filter_value_mutated := var_filter_value
	mut var_selectors := rt.call_function('explode', [rt.new_string(','),
		var_duotone_selector_mutated.clone()])
	mut var_selectors_scoped := rt.new_array()
	mut iter_4 := var_selectors.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_selector_part := item_4.val
		var_selectors_scoped << '.' + var_filter_id_mutated.str() +
			var_selector_part.clone().to_string().trim_space()
	}
	mut var_selector := rt.call_function('implode', [rt.new_string(', '),
		rt.create_array_from_list(var_selectors_scoped)])
	rt.get_static_prop('WP_Duotone', 'block_css_declarations').array_push(rt.create_array([
		rt.ArrayItem{ key: 'selector', val: var_selector },
		rt.ArrayItem{ key: 'declarations', val: rt.create_array([
			rt.ArrayItem{ key: 'filter', val: var_filter_value_mutated },
		]) },
	]))
}

fn Class_WP_Duotone.enqueue_custom_filter(var_filter_id rt.PhpVal, var_duotone_selector rt.PhpVal, var_filter_value rt.PhpVal, var_filter_data rt.PhpVal) {
	mut var_filter_id_mutated := var_filter_id
	mut var_duotone_selector_mutated := var_duotone_selector
	mut var_filter_value_mutated := var_filter_value
	mut var_filter_data_mutated := var_filter_data
	rt.get_static_prop('WP_Duotone', 'used_svg_filter_data').array_set(var_filter_id_mutated,
		var_filter_data_mutated.clone())
	Class_WP_Duotone.enqueue_block_css(var_filter_id_mutated.clone(),
		var_duotone_selector_mutated.clone(), var_filter_value_mutated.clone())
}

fn Class_WP_Duotone.enqueue_global_styles_preset(var_filter_id rt.PhpVal, var_duotone_selector rt.PhpVal, var_filter_value rt.PhpVal) {
	mut var_filter_id_mutated := var_filter_id
	mut var_duotone_selector_mutated := var_duotone_selector
	mut var_filter_value_mutated := var_filter_value
	mut var_global_styles_presets := Class_WP_Duotone.get_all_global_styles_presets()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_global_styles_presets.clone().array_isset(var_filter_id_mutated.clone())))))) {
		mut var_error_message := rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The duotone id "%1$s" is not registered in %2$s settings'),
			]),
			var_filter_id_mutated.clone(),
			rt.new_string('theme.json'),
		])
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			var_error_message.clone(), rt.new_string('6.3.0')])
		return
	}
	rt.get_static_prop('WP_Duotone', 'used_global_styles_presets').array_set(var_filter_id_mutated,
		var_global_styles_presets.array_get(var_filter_id_mutated))
	Class_WP_Duotone.enqueue_custom_filter(var_filter_id_mutated.clone(),
		var_duotone_selector_mutated.clone(), var_filter_value_mutated.clone(),
		var_global_styles_presets.array_get(var_filter_id_mutated))
}

fn Class_WP_Duotone.register_duotone_support(var_block_type rt.PhpVal) {
	mut var_block_type_mutated := var_block_type
	if rt.is_true(rt.call_function('block_has_support', [var_block_type_mutated.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'filter' },
			rt.ArrayItem{ key: none, val: 'duotone' }]),
		rt.new_null()]))
	{
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_block_type_mutated, 'attributes'))))) {
			rt.set_property(var_block_type_mutated, 'attributes', rt.new_array())
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_block_type_mutated,
			'attributes').array_isset(rt.new_string('style')))))))
		{
			rt.get_property(var_block_type_mutated, 'attributes').array_set('style', rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
			]))
		}
	}
}

fn Class_WP_Duotone.get_selector(var_block_type rt.PhpVal) rt.PhpVal {
	mut var_block_type_mutated := var_block_type
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_block_type_mutated,
		'WP_Block_Type'))))))
	{
		return rt.new_null()
	}
	mut var_duotone_support := rt.call_function('block_has_support', [
		var_block_type_mutated.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'filter' },
			rt.ArrayItem{ key: none, val: 'duotone' },
		])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_duotone_support)))) {
		return rt.new_null()
	}
	mut var_experimental_duotone := if !(rt.get_property(var_block_type_mutated, 'supports').array_get(rt.new_string('color')).array_get(rt.new_string('__experimentalDuotone'))).is_null() {
		rt.get_property(var_block_type_mutated, 'supports').array_get(rt.new_string('color')).array_get(rt.new_string('__experimentalDuotone'))
	} else {
		rt.new_bool(false)
	}
	if rt.is_true(var_experimental_duotone) {
		mut var_root_selector := rt.call_function('wp_get_block_css_selector', [
			var_block_type_mutated.clone(),
		])
		mut iife_temp_0 := Class_WP_Theme_JSON{}
		mut iife_result_0 := iife_temp_0.scope_selector(var_root_selector.clone(),
			var_experimental_duotone.clone())
		return if var_experimental_duotone.clone().is_string() {
			iife_result_0
		} else {
			var_root_selector
		}
	}
	return rt.call_function('wp_get_block_css_selector', [var_block_type_mutated.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'filter' },
			rt.ArrayItem{ key: none, val: 'duotone' }]),
		rt.new_bool(true)])
}

fn Class_WP_Duotone.get_all_global_styles_presets() rt.PhpVal {
	if !(rt.get_static_prop('WP_Duotone', 'global_styles_presets')).is_null() {
		return rt.get_static_prop('WP_Duotone', 'global_styles_presets')
	}
	mut var_tree := rt.call_function('wp_get_global_settings', []rt.PhpVal{})
	mut var_presets_by_origin := if !(var_tree.array_get(rt.new_string('color')).array_get(rt.new_string('duotone'))).is_null() {
		var_tree.array_get(rt.new_string('color')).array_get(rt.new_string('duotone'))
	} else {
		rt.new_array()
	}
	rt.set_static_prop('WP_Duotone', 'global_styles_presets', rt.new_array())
	mut iter_5 := var_presets_by_origin.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_presets := item_5.val
		mut iter_6 := var_presets.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_preset := item_6.val
			mut var_filter_id := Class_WP_Duotone.get_filter_id(rt.call_function('_wp_to_kebab_case', [
				var_preset.array_get(rt.new_string('slug')),
			]))
			rt.get_static_prop('WP_Duotone', 'global_styles_presets').array_set(var_filter_id,
				var_preset.clone())
		}
	}
	return rt.get_static_prop('WP_Duotone', 'global_styles_presets')
}

fn Class_WP_Duotone.get_all_global_style_block_names() rt.PhpVal {
	if !(rt.get_static_prop('WP_Duotone', 'global_styles_block_names')).is_null() {
		return rt.get_static_prop('WP_Duotone', 'global_styles_block_names')
	}
	mut iife_temp_1 := Class_WP_Theme_JSON_Resolver{}
	mut iife_result_1 := iife_temp_1.get_merged_data()
	mut var_tree := iife_result_1
	mut var_block_nodes := rt.call_method(var_tree, 'get_styles_block_nodes', []rt.PhpVal{})
	mut var_theme_json := rt.call_method(var_tree, 'get_raw_data', []rt.PhpVal{})
	rt.set_static_prop('WP_Duotone', 'global_styles_block_names', rt.new_array())
	mut iter_7 := var_block_nodes.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_block_node := item_7.val
		if !rt.is_true(var_block_node.array_get(rt.new_string('duotone'))) {
			continue
		}
		mut var_duotone_attr_path := rt.call_function('array_merge', [
			var_block_node.array_get(rt.new_string('path')),
			rt.create_array([rt.ArrayItem{ key: none, val: 'filter' },
				rt.ArrayItem{ key: none, val: 'duotone' }]),
		])
		mut var_duotone_attr := rt.call_function('_wp_array_get', [
			var_theme_json.clone(), var_duotone_attr_path.clone(),
			rt.new_array()])
		if !rt.is_true(var_duotone_attr) {
			continue
		}
		if !(var_duotone_attr.clone().is_string()) {
			continue
		}
		mut var_slug := Class_WP_Duotone.get_slug_from_attribute(var_duotone_attr.clone())
		if rt.is_true(var_slug)
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_slug, var_duotone_attr)))) {
			rt.get_static_prop('WP_Duotone', 'global_styles_block_names').array_set(var_block_node.array_get(rt.new_string('name')),
				var_slug.clone())
		}
	}
	return rt.get_static_prop('WP_Duotone', 'global_styles_block_names')
}

fn Class_WP_Duotone.render_duotone_support(var_block_content rt.PhpVal, var_block rt.PhpVal, var_wp_block rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_block.array_get(rt.new_string('blockName')))))) {
		return var_block_content.clone()
	}
	mut var_duotone_selector := Class_WP_Duotone.get_selector(rt.get_property(var_wp_block,
		'block_type'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_duotone_selector)))) {
		return var_block_content.clone()
	}
	mut var_global_styles_block_names := Class_WP_Duotone.get_all_global_style_block_names()
	mut var_has_duotone_attribute :=
		rt.new_bool(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_isset(rt.new_string('duotone')))
	mut var_has_global_styles_duotone :=
		rt.new_bool(var_global_styles_block_names.clone().array_isset(var_block.array_get(rt.new_string('blockName'))))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_has_duotone_attribute))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_has_global_styles_duotone)))) {
		return var_block_content.clone()
	}
	if rt.is_true(var_has_duotone_attribute) {
		mut var_duotone_attr :=
			var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('duotone'))
		mut var_is_preset := rt.new_bool(var_duotone_attr.clone().is_string()
			&& rt.is_true(Class_WP_Duotone.is_preset(var_duotone_attr.clone())))
		mut var_is_css := rt.new_bool(var_duotone_attr.clone().is_string()
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_is_preset)))))
		mut var_is_custom := rt.new_bool(var_duotone_attr.clone().is_array())
		if rt.is_true(var_is_preset) {
			mut var_slug := Class_WP_Duotone.get_slug_from_attribute(var_duotone_attr.clone())
			mut var_filter_id := Class_WP_Duotone.get_filter_id(var_slug.clone())
			mut var_filter_value := Class_WP_Duotone.get_css_var(var_slug.clone())
			Class_WP_Duotone.enqueue_global_styles_preset(var_filter_id.clone(),
				var_duotone_selector.clone(), var_filter_value.clone())
		} else if rt.is_true(var_is_css) {
			var_slug = rt.call_function('wp_unique_id', [
				rt.call_function('sanitize_key', [
					rt.new_string(var_duotone_attr.str() + '-'),
				]),
			])
			var_filter_id = Class_WP_Duotone.get_filter_id(var_slug.clone())
			var_filter_value = var_duotone_attr.clone()
			Class_WP_Duotone.enqueue_block_css(var_filter_id.clone(), var_duotone_selector.clone(),
				var_filter_value.clone())
		} else if rt.is_true(var_is_custom) {
			var_slug = rt.call_function('wp_unique_id', [
				rt.call_function('sanitize_key', [
					rt.new_string(
						(rt.call_function('implode', [rt.new_string('-'), var_duotone_attr.clone()])).str() +
						'-'),
				]),
			])
			var_filter_id = Class_WP_Duotone.get_filter_id(var_slug.clone())
			var_filter_value = Class_WP_Duotone.get_filter_url(var_filter_id.clone())
			mut var_filter_data := {
				'slug':   var_slug
				'colors': var_duotone_attr
			}
			Class_WP_Duotone.enqueue_custom_filter(var_filter_id.clone(),
				var_duotone_selector.clone(), var_filter_value.clone(), var_filter_data.clone())
		}
	} else if rt.is_true(var_has_global_styles_duotone) {
		var_slug =
			var_global_styles_block_names.array_get(var_block.array_get(rt.new_string('blockName')))
		var_filter_id = Class_WP_Duotone.get_filter_id(var_slug.clone())
		var_filter_value = Class_WP_Duotone.get_css_var(var_slug.clone())
		Class_WP_Duotone.enqueue_global_styles_preset(var_filter_id.clone(),
			var_duotone_selector.clone(), var_filter_value.clone())
	}
	mut var_tags := create_wp_html_tag_processor(var_block_content.clone())
	if rt.is_true(var_tags.next_tag()) {
		var_tags.add_class(var_filter_id.clone())
	}
	return var_tags.get_updated_html()
}

fn Class_WP_Duotone.restore_image_outer_container(var_block_content rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('wp_theme_has_theme_json', []rt.PhpVal{})) {
		return var_block_content.clone()
	}
	mut var_tags := create_wp_html_tag_processor(var_block_content.clone())
	mut var_wrapper_query := {
		'tag_name':   'div'
		'class_name': 'wp-block-image'
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_tags.next_tag(var_wrapper_query.clone()))))) {
		return var_block_content.clone()
	}
	var_tags.set_bookmark(rt.new_string('wrapper-div'))
	var_tags.next_tag()
	mut var_inner_classnames := rt.call_function('explode', [
		rt.new_string(' '), var_tags.get_attribute(rt.new_string('class'))])
	mut iter_8 := var_inner_classnames.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_classname := item_8.val
		if rt.is_true(rt.call_function('str_starts_with', [var_classname.clone(),
			rt.new_string('wp-duotone')]))
		{
			var_tags.remove_class(var_classname.clone())
			var_tags.seek(rt.new_string('wrapper-div'))
			var_tags.add_class(var_classname.clone())
			break
		}
	}
	return var_tags.get_updated_html()
}

fn Class_WP_Duotone.output_block_styles() {
	if !(!rt.is_true(rt.get_static_prop('WP_Duotone', 'block_css_declarations'))) {
		rt.call_function('wp_style_engine_get_stylesheet_from_css_rules', [
			rt.get_static_prop('WP_Duotone', 'block_css_declarations'),
			rt.create_array([rt.ArrayItem{ key: 'context', val: 'block-supports' }]),
		])
	}
}

fn Class_WP_Duotone.output_global_styles() {
	if !(!rt.is_true(rt.get_static_prop('WP_Duotone', 'used_global_styles_presets'))) {
		rt.call_function('wp_add_inline_style', [rt.new_string('global-styles'),
			Class_WP_Duotone.get_global_styles_presets(rt.get_static_prop('WP_Duotone',
				'used_global_styles_presets'))])
	}
}

fn Class_WP_Duotone.output_footer_assets() {
	if !(!rt.is_true(rt.get_static_prop('WP_Duotone', 'used_svg_filter_data'))) {
		rt.echo_val(Class_WP_Duotone.get_svg_definitions(rt.get_static_prop('WP_Duotone',
			'used_svg_filter_data')))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))))) {
		mut var_style_tag_id := rt.new_string('core-block-supports-duotone')
		rt.call_function('wp_register_style', [var_style_tag_id.clone(),
			rt.new_bool(false)])
		if !(!rt.is_true(rt.get_static_prop('WP_Duotone', 'used_global_styles_presets'))) {
			rt.call_function('wp_add_inline_style', [var_style_tag_id.clone(),
				Class_WP_Duotone.get_global_styles_presets(rt.get_static_prop('WP_Duotone',
					'used_global_styles_presets'))])
		}
		if !(!rt.is_true(rt.get_static_prop('WP_Duotone', 'block_css_declarations'))) {
			rt.call_function('wp_add_inline_style', [var_style_tag_id.clone(),
				rt.call_function('wp_style_engine_get_stylesheet_from_css_rules', [
					rt.get_static_prop('WP_Duotone', 'block_css_declarations'),
				])])
		}
		rt.call_function('wp_enqueue_style', [var_style_tag_id.clone()])
	}
}

fn Class_WP_Duotone.add_editor_settings(var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	mut var_global_styles_presets := Class_WP_Duotone.get_all_global_styles_presets()
	if !(!rt.is_true(var_global_styles_presets)) {
		if !(var_settings_mutated.array_isset(rt.new_string('styles'))) {
			var_settings_mutated.array_set('styles', rt.new_array())
		}
		var_settings_mutated.array_get_mut('styles').array_push(rt.create_array([
			rt.ArrayItem{
				key: 'assets'
				val: Class_WP_Duotone.get_svg_definitions(var_global_styles_presets.clone())
			},
			rt.ArrayItem{ key: '__unstableType', val: 'svgs' },
			rt.ArrayItem{ key: 'isGlobalStyles', val: false },
		]))
		var_settings_mutated.array_get_mut('styles').array_push(rt.create_array([
			rt.ArrayItem{
				key: 'css'
				val: Class_WP_Duotone.get_global_styles_presets(var_global_styles_presets.clone())
			},
			rt.ArrayItem{ key: '__unstableType', val: 'presets' },
			rt.ArrayItem{ key: 'isGlobalStyles', val: false },
		]))
	}
	return var_settings_mutated.clone()
}

fn Class_WP_Duotone.migrate_experimental_duotone_support_flag(var_settings rt.PhpVal, var_metadata rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	mut var_duotone_support := if !(var_metadata.array_get(rt.new_string('supports')).array_get(rt.new_string('color')).array_get(rt.new_string('__experimentalDuotone'))).is_null() {
		var_metadata.array_get(rt.new_string('supports')).array_get(rt.new_string('color')).array_get(rt.new_string('__experimentalDuotone'))
	} else {
		rt.new_null()
	}
	if !(var_settings_mutated.array_get(rt.new_string('supports')).array_get(rt.new_string('filter')).array_isset(rt.new_string('duotone')))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_duotone_support)))) {
		rt.call_function('_wp_array_set', [var_settings_mutated.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'supports' },
				rt.ArrayItem{ key: none, val: 'filter' }, rt.ArrayItem{ key: none, val: 'duotone' }]),
			rt.new_bool(var_duotone_support.to_bool())])
	}
	return var_settings_mutated.clone()
}

fn Class_WP_Duotone.get_filter_css_property_value_from_preset(var_preset rt.PhpVal) string {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.3.0')])
	if var_preset.array_isset(rt.new_string('colors'))
		&& var_preset.array_get(rt.new_string('colors')).is_string() {
		return (var_preset.array_get(rt.new_string('colors'))).str()
	}
	mut var_filter_id := Class_WP_Duotone.get_filter_id_from_preset(var_preset.clone())
	return 'url(#' + var_filter_id.str() + ')'
}

struct Class_WP_Theme_JSON {
	rt.PhpObjectBase
}

struct Class_WP_Theme_JSON_Resolver {
	rt.PhpObjectBase
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_wp_duotone(_args ...rt.PhpVal) &Class_WP_Duotone {
	mut obj := &Class_WP_Duotone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_theme_json(_args ...rt.PhpVal) &Class_WP_Theme_JSON {
	mut obj := &Class_WP_Theme_JSON{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_theme_json_resolver(_args ...rt.PhpVal) &Class_WP_Theme_JSON_Resolver {
	mut obj := &Class_WP_Theme_JSON_Resolver{
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
			return rt.new_float(Class_WP_Duotone.colord_parse_hue(dispatch_arg_0, dispatch_arg_1))
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
			Class_WP_Duotone.enqueue_custom_filter(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
			return rt.new_null()
		}
		'enqueue_global_styles_preset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_WP_Duotone.enqueue_global_styles_preset(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
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
			return Class_WP_Duotone.render_duotone_support(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
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
			return Class_WP_Duotone.migrate_experimental_duotone_support_flag(dispatch_arg_0,
				dispatch_arg_1)
		}
		'get_filter_css_property_value_from_preset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WP_Duotone.get_filter_css_property_value_from_preset(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Duotone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Duotone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Theme_JSON) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme_JSON) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme_JSON) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Theme_JSON_Resolver) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme_JSON_Resolver) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme_JSON_Resolver) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
}
