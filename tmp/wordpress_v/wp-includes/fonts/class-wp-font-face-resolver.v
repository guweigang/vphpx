import rt

struct Class_WP_Font_Face_Resolver {
	rt.PhpObjectBase
}

fn Class_WP_Font_Face_Resolver.get_fonts_from_theme_json() rt.PhpVal {
	mut var_settings := rt.call_function('wp_get_global_settings', []rt.PhpVal{})
	if !rt.is_true(var_settings.array_get('typography').array_get('fontFamilies')) {
		return rt.new_array()
	}
	return Class_WP_Font_Face_Resolver.parse_settings(mut rt.cast_object_ptr[Class_array](var_settings))
}

fn Class_WP_Font_Face_Resolver.get_fonts_from_style_variations() rt.PhpVal {
	mut var_variations := fn () rt.PhpVal { mut temp := Class_WP_Theme_JSON_Resolver{}; return temp.get_style_variations() }()
	mut var_fonts := rt.new_array()
	if !rt.is_true(var_variations) {
		return var_fonts.dup()
	}
	{
		mut iter_1 := var_variations.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_variation := item_1.val
			if !(!rt.is_true(var_variation.array_get('settings').array_get('typography').array_get('fontFamilies').array_get('theme'))) {
				var_fonts = rt.call_function('array_merge', [var_fonts.dup(), var_variation.array_get('settings').array_get('typography').array_get('fontFamilies').array_get('theme')])
			}
		}
	}
	mut var_settings := rt.create_array([rt.ArrayItem{ key: 'typography', val: rt.create_array([rt.ArrayItem{ key: 'fontFamilies', val: rt.create_array([rt.ArrayItem{ key: 'theme', val: var_fonts }]) }]) }])
	return Class_WP_Font_Face_Resolver.parse_settings(mut rt.cast_object_ptr[Class_array](var_settings))
}

fn Class_WP_Font_Face_Resolver.parse_settings(mut var_settings Class_array) rt.PhpVal {
	mut var_settings_mutated := var_settings
	mut var_fonts := rt.new_array()
	{
		mut iter_1 := var_settings_mutated.array_get('typography').array_get('fontFamilies').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_font_families := item_1.val
			{
				mut iter_2 := var_font_families.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_definition := item_2.val
					if !rt.is_true(var_definition.array_get('fontFace')) {
						continue
					}
					if !rt.is_true(var_definition.array_get('fontFamily')) {
						continue
					}
					mut var_font_family_name := Class_WP_Font_Face_Resolver.maybe_parse_name_from_comma_separated_list(var_definition.array_get('fontFamily'))
					if !rt.is_true(var_font_family_name) {
						continue
					}
					var_fonts.array_push(Class_WP_Font_Face_Resolver.convert_font_face_properties(mut rt.cast_object_ptr[Class_array](var_definition.array_get('fontFace')), var_font_family_name.dup()))
				}
			}
		}
	}
	return var_fonts.dup()
}

fn Class_WP_Font_Face_Resolver.maybe_parse_name_from_comma_separated_list(var_font_family rt.PhpVal) string {
	mut var_font_family_mutated := var_font_family
	if rt.is_true(rt.call_function('str_contains', [var_font_family_mutated.dup(), rt.new_string(',')])) {
		var_font_family_mutated = rt.call_function('explode', [rt.new_string(','), var_font_family_mutated.dup()]).array_get(0)
	}
	return var_font_family_mutated.dup().to_string().trim_space()
}

fn Class_WP_Font_Face_Resolver.convert_font_face_properties(mut var_font_face_definition Class_array, var_font_family_property rt.PhpVal) rt.PhpVal {
	mut var_converted_font_faces := rt.new_array()
	{
		mut iter_1 := var_font_face_definition.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_font_face := item_1.val
			var_font_face.array_set('font-family', var_font_family_property.dup())
			if !(!rt.is_true(var_font_face.array_get('src'))) {
				var_font_face.array_set('src', Class_WP_Font_Face_Resolver.to_theme_file_uri(mut rt.cast_object_ptr[Class_array](rt.cast_array(var_font_face.array_get('src')))))
			}
			var_font_face = Class_WP_Font_Face_Resolver.to_kebab_case(mut rt.cast_object_ptr[Class_array](var_font_face))
			var_converted_font_faces << var_font_face.dup()
		}
	}
	return var_converted_font_faces.dup()
}

fn Class_WP_Font_Face_Resolver.to_theme_file_uri(mut var_src Class_array) rt.PhpVal {
	mut var_src_mutated := var_src
	mut var_placeholder := rt.new_string(rt.new_string('file:./'))
	{
		mut iter_1 := var_src_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_src_url := item_1.val
			mut var_src_key := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [var_src_url.dup(), var_placeholder.dup()]))))) {
				continue
			}
			mut var_src_file := rt.call_function('str_replace', [var_placeholder.dup(), rt.new_string(''), var_src_url.dup()])
			var_src_mutated.array_set(var_src_key, rt.call_function('get_theme_file_uri', [var_src_file.dup()]))
		}
	}
	return rt.new_object('array', []string{}, var_src_mutated)
}

fn Class_WP_Font_Face_Resolver.to_kebab_case(mut var_data Class_array) rt.PhpVal {
	mut var_data_mutated := var_data
	{
		mut iter_1 := var_data_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			mut var_kebab_case := rt.call_function('_wp_to_kebab_case', [var_key.dup()])
			var_data_mutated.array_set(var_kebab_case, var_value.dup())
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				var_data_mutated.array_unset(var_key)
			}
		}
	}
	return rt.new_object('array', []string{}, var_data_mutated)
}

struct Class_WP_Theme_JSON_Resolver {
	rt.PhpObjectBase
}

fn create_wp_font_face_resolver() &Class_WP_Font_Face_Resolver {
	mut obj := &Class_WP_Font_Face_Resolver{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_theme_json_resolver() &Class_WP_Theme_JSON_Resolver {
	mut obj := &Class_WP_Theme_JSON_Resolver{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Font_Face_Resolver) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_fonts_from_theme_json' {
			return Class_WP_Font_Face_Resolver.get_fonts_from_theme_json()
		}
		'get_fonts_from_style_variations' {
			return Class_WP_Font_Face_Resolver.get_fonts_from_style_variations()
		}
		'parse_settings' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WP_Font_Face_Resolver.parse_settings(mut dispatch_arg_0)
		}
		'maybe_parse_name_from_comma_separated_list' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WP_Font_Face_Resolver.maybe_parse_name_from_comma_separated_list(dispatch_arg_0))
		}
		'convert_font_face_properties' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Font_Face_Resolver.convert_font_face_properties(mut dispatch_arg_0, dispatch_arg_1)
		}
		'to_theme_file_uri' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WP_Font_Face_Resolver.to_theme_file_uri(mut dispatch_arg_0)
		}
		'to_kebab_case' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WP_Font_Face_Resolver.to_kebab_case(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WP_Font_Face_Resolver) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Font_Face_Resolver) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_fonts_class_wp_font_face_resolver_php() {
}
