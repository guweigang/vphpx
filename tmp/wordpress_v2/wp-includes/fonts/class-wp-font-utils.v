import rt

struct Class_WP_Font_Utils {
	rt.PhpObjectBase
}

fn Class_WP_Font_Utils.maybe_add_quotes(var_item rt.PhpVal) string {
	mut var_item_mutated := var_item
	mut var_regex := rt.new_string('/^(?!generic\\([a-zA-Z\\-]+\\)$)(?!^[a-zA-Z\\-]+$).+/')
	var_item_mutated = rt.new_string(var_item_mutated.clone().to_string().trim_space())
	if rt.is_true(rt.call_function('preg_match', [var_regex.clone(),
		var_item_mutated.clone()]))
	{
		var_item_mutated = rt.new_string(var_item_mutated.clone().to_string().trim_space())
		return '"' + var_item_mutated.str() + '"'
	}
	return var_item_mutated.str()
}

fn Class_WP_Font_Utils.sanitize_font_family(var_font_family rt.PhpVal) string {
	mut var_font_family_mutated := var_font_family
	if rt.is_true(rt.new_bool(!(rt.is_true(var_font_family_mutated)))) {
		return ''
	}
	mut var_output := rt.call_function('sanitize_text_field', [
		var_font_family_mutated.clone()])
	mut var_formatted_items := []rt.PhpVal{}
	if rt.is_true(rt.call_function('str_contains', [var_output.clone(),
		rt.new_string(',')]))
	{
		mut var_items := rt.call_function('explode', [rt.new_string(','),
			var_output.clone()])
		mut iter_1 := var_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_formatted_item := Class_WP_Font_Utils.maybe_add_quotes(var_item.clone())
			if !(!rt.is_true(var_formatted_item)) {
				var_formatted_items << var_formatted_item.clone()
			}
		}
		return (rt.call_function('implode', [rt.new_string(', '),
			rt.create_array_from_list(var_formatted_items)])).str()
	}
	return (Class_WP_Font_Utils.maybe_add_quotes(var_output.clone())).str()
}

fn Class_WP_Font_Utils.get_font_face_slug(var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	mut var_defaults := {
		'fontFamily':   ''
		'fontStyle':    'normal'
		'fontWeight':   '400'
		'fontStretch':  '100%'
		'unicodeRange': 'U+0-10FFFF'
	}
	var_settings_mutated = rt.call_function('wp_parse_args', [
		var_settings_mutated.clone(), rt.create_array_from_native_map(var_defaults)])
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('mb_strtolower')])) {
		mut var_font_family := rt.call_function('mb_strtolower', [
			var_settings_mutated.array_get(rt.new_string('fontFamily')),
		])
	} else {
		var_font_family =
			rt.new_string(var_settings_mutated.array_get(rt.new_string('fontFamily')).to_string().to_lower())
	}
	mut var_font_style :=
		rt.new_string(var_settings_mutated.array_get(rt.new_string('fontStyle')).to_string().to_lower())
	mut var_font_weight :=
		rt.new_string(var_settings_mutated.array_get(rt.new_string('fontWeight')).to_string().to_lower())
	mut var_font_stretch :=
		rt.new_string(var_settings_mutated.array_get(rt.new_string('fontStretch')).to_string().to_lower())
	mut var_unicode_range :=
		rt.new_string(var_settings_mutated.array_get(rt.new_string('unicodeRange')).to_string().to_upper())
	var_font_weight = rt.call_function('str_replace', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'normal' },
			rt.ArrayItem{ key: none, val: 'bold' }]),
		rt.create_array([rt.ArrayItem{ key: none, val: '400' },
			rt.ArrayItem{ key: none, val: '700' }]),
		var_font_weight.clone(),
	])
	mut var_font_stretch_map := {
		'ultra-condensed': '50%'
		'extra-condensed': '62.5%'
		'condensed':       '75%'
		'semi-condensed':  '87.5%'
		'normal':          '100%'
		'semi-expanded':   '112.5%'
		'expanded':        '125%'
		'extra-expanded':  '150%'
		'ultra-expanded':  '200%'
	}
	var_font_stretch = rt.call_function('str_replace', [
		rt.func_array_keys(rt.create_array_from_native_map(var_font_stretch_map)),
		rt.call_function('array_values', [
			rt.create_array_from_native_map(var_font_stretch_map),
		]),
		var_font_stretch.clone(),
	])
	mut var_slug_elements := rt.create_array([
		rt.ArrayItem{ key: none, val: var_font_family },
		rt.ArrayItem{ key: none, val: var_font_style },
		rt.ArrayItem{ key: none, val: var_font_weight },
		rt.ArrayItem{ key: none, val: var_font_stretch },
		rt.ArrayItem{ key: none, val: var_unicode_range },
	])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_elem := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		var_elem = rt.new_string(rt.call_function('str_replace', [
			rt.create_array([rt.ArrayItem{ key: none, val: '"' },
				rt.ArrayItem{ key: none, val: "'" }, rt.ArrayItem{ key: none, val: ';' }]),
			rt.new_string(''),
			var_elem.clone(),
		]).to_string().trim_space())
		return rt.call_function('preg_replace', [rt.new_string('/,\\s+/'),
			rt.new_string(','), var_elem.clone()])
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_elem := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		var_elem = rt.new_string(rt.call_function('str_replace', [
			rt.create_array([rt.ArrayItem{ key: none, val: '"' },
				rt.ArrayItem{ key: none, val: "'" }, rt.ArrayItem{ key: none, val: ';' }]),
			rt.new_string(''),
			var_elem.clone(),
		]).to_string().trim_space())
		return rt.call_function('preg_replace', [rt.new_string('/,\\s+/'),
			rt.new_string(','), var_elem.clone()])
	}
	var_slug_elements = rt.call_function('array_map', [rt.new_closure(closure_1_fn),
		var_slug_elements.clone()])
	return rt.call_function('sanitize_text_field', [
		rt.call_function('implode', [rt.new_string(';'), var_slug_elements.clone()]),
	])
}

fn Class_WP_Font_Utils.sanitize_from_schema(var_tree rt.PhpVal, var_schema rt.PhpVal) rt.PhpVal {
	mut var_tree_mutated := var_tree
	if !(var_tree_mutated.clone().is_array()) || !(var_schema.clone().is_array()) {
		return []rt.PhpVal{}
	}
	mut iter_2 := var_tree_mutated.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_value := item_2.val
		mut var_key := item_2.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_schema.clone().array_isset(var_key.clone())))))) {
			var_tree_mutated.array_unset(var_key)
			continue
		}
		mut var_is_value_array := rt.new_bool(var_value.clone().is_array())
		mut var_is_schema_array := rt.new_bool(var_schema.array_get(var_key).is_array()
			&& !(rt.call_function('is_callable', [var_schema.array_get(var_key)])))
		if rt.is_true(var_is_value_array) && rt.is_true(var_is_schema_array) {
			if rt.is_true(rt.call_function('wp_is_numeric_array', [
				var_value.clone()]))
			{
				mut iter_3 := var_value.iterator()
				for {
					item_3 := iter_3.next() or { break }
					mut var_item_value := item_3.val
					mut var_item_key := item_3.key
					var_tree_mutated.array_get_mut(var_key).array_set(var_item_key, if
						var_schema.array_get(var_key).array_isset(rt.new_int(0))
						&& var_schema.array_get(var_key).array_get(rt.new_int(0)).is_array() {
						Class_WP_Font_Utils.sanitize_from_schema(var_item_value.clone(),
							var_schema.array_get(var_key).array_get(rt.new_int(0)))
					} else {
						Class_WP_Font_Utils.apply_sanitizer(var_item_value.clone(),
							var_schema.array_get(var_key).array_get(rt.new_int(0)))
					})
				}
			} else {
				var_tree_mutated.array_set(var_key, Class_WP_Font_Utils.sanitize_from_schema(var_value.clone(),
					var_schema.array_get(var_key)))
			}
		} else if rt.is_true(rt.new_bool(!(rt.is_true(var_is_value_array))))
			&& rt.is_true(var_is_schema_array) {
			var_tree_mutated.array_unset(var_key)
		} else if rt.is_true(rt.new_bool(!(rt.is_true(var_is_schema_array)))) {
			var_tree_mutated.array_set(var_key, Class_WP_Font_Utils.apply_sanitizer(var_value.clone(),
				var_schema.array_get(var_key)))
		}
		if !rt.is_true(var_tree_mutated.array_get(var_key)) {
			var_tree_mutated.array_unset(var_key)
		}
	}
	return var_tree_mutated.clone()
}

fn Class_WP_Font_Utils.apply_sanitizer(var_value rt.PhpVal, var_sanitizer rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), var_sanitizer)) {
		return var_value.clone()
	}
	return rt.call_function('call_user_func', [var_sanitizer.clone(),
		var_value.clone()])
}

fn Class_WP_Font_Utils.get_allowed_font_mime_types() rt.PhpVal {
	mut var_php_7_ttf_mime_type := rt.new_string((if rt.is_true(rt.greater_equal(rt.get_constant('PHP_VERSION_ID'),
		rt.new_int(70300)))
	{
		'application/font-sfnt'
	} else {
		'application/x-font-ttf'
	}).str())
	return rt.create_array([
		rt.ArrayItem{ key: 'otf', val: 'application/vnd.ms-opentype' },
		rt.ArrayItem{
			key: 'ttf'
			val: if rt.is_true(rt.greater_equal(rt.get_constant('PHP_VERSION_ID'),
				rt.new_int(70400)))
			{
				rt.new_string('font/sfnt')
			} else {
				var_php_7_ttf_mime_type
			}
		},
		rt.ArrayItem{
			key: 'woff'
			val: if rt.is_true(rt.greater_equal(rt.get_constant('PHP_VERSION_ID'),
				rt.new_int(80112)))
			{
				'font/woff'
			} else {
				'application/font-woff'
			}
		},
		rt.ArrayItem{
			key: 'woff2'
			val: if rt.is_true(rt.greater_equal(rt.get_constant('PHP_VERSION_ID'),
				rt.new_int(80112)))
			{
				'font/woff2'
			} else {
				'application/font-woff2'
			}
		},
	])
}

fn create_wp_font_utils(_args ...rt.PhpVal) &Class_WP_Font_Utils {
	mut obj := &Class_WP_Font_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Font_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'maybe_add_quotes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WP_Font_Utils.maybe_add_quotes(dispatch_arg_0))
		}
		'sanitize_font_family' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WP_Font_Utils.sanitize_font_family(dispatch_arg_0))
		}
		'get_font_face_slug' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Font_Utils.get_font_face_slug(dispatch_arg_0)
		}
		'sanitize_from_schema' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Font_Utils.sanitize_from_schema(dispatch_arg_0, dispatch_arg_1)
		}
		'apply_sanitizer' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Font_Utils.apply_sanitizer(dispatch_arg_0, dispatch_arg_1)
		}
		'get_allowed_font_mime_types' {
			return Class_WP_Font_Utils.get_allowed_font_mime_types()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Font_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Font_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
