import rt

struct Class_WP_Font_Face {
	rt.PhpObjectBase
pub mut:
	font_face_property_defaults rt.PhpVal = rt.new_array()
	valid_font_face_properties  rt.PhpVal = rt.new_array()
	valid_font_display          rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Font_Face) generate_and_print(mut var_fonts Class_array) {
	mut var_fonts_mutated := var_fonts
	var_fonts_mutated = this.validate_fonts(mut var_fonts_mutated)
	if !rt.is_true(var_fonts_mutated) {
		return rt.new_null()
	}
	mut var_css :=
		rt.new_string(this.get_css(rt.new_object('array', []string{}, var_fonts_mutated)))
	var_css = rt.call_function('wp_strip_all_tags', [var_css.dup()])
	if !rt.is_true(var_css) {
		return rt.new_null()
	}
	mut var_processor :=
		create_wp_html_tag_processor(rt.new_string('<style class="wp-fonts-local"></style>'))
	var_processor.next_tag()
	var_processor.set_modifiable_text(rt.new_string('\n${var_css.to_string()}\n'))
	print(rt.concat(var_processor.get_updated_html(), rt.new_string('\n')))
}

fn (mut this Class_WP_Font_Face) validate_fonts(mut var_fonts Class_array) rt.PhpVal {
	mut var_fonts_mutated := var_fonts
	mut var_validated_fonts := []rt.PhpVal{}
	{
		mut iter_1 := var_fonts_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_font_faces := item_1.val
			{
				mut iter_2 := var_font_faces.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_font_face := item_2.val
					var_font_face =
						rt.new_bool(this.validate_font_face_declarations(mut rt.cast_object_ptr[Class_array](var_font_face)))
					if rt.is_true(rt.identical(rt.new_bool(false), var_font_face)) {
						continue
					}
					var_validated_fonts << var_font_face.dup()
				}
			}
		}
	}
	return var_validated_fonts.dup()
}

fn (mut this Class_WP_Font_Face) validate_font_face_declarations(mut var_font_face Class_array) bool {
	mut var_font_face_mutated := var_font_face
	var_font_face_mutated = rt.call_function('wp_parse_args', [
		var_font_face_mutated.dup(), this.font_face_property_defaults])
	if rt.is_true(rt.new_bool(!rt.is_true(var_font_face_mutated.array_get('font-family'))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_font_face_mutated.array_get('font-family').is_string())))))))
	{
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('__', [
				rt.new_string('Font font-family must be a non-empty string.'),
			]),
			rt.new_string('6.4.0')])
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(var_font_face_mutated.array_get('src'))
		|| rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_font_face_mutated.array_get('src').is_string())))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_font_face_mutated.array_get('src').is_array())))))))))
	{
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('__', [
				rt.new_string('Font src must be a non-empty string or an array of strings.'),
			]),
			rt.new_string('6.4.0')])
		return false
	}
	{
		mut iter_1 := rt.cast_array(var_font_face_mutated.array_get('src')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_src := item_1.val
			if rt.is_true(rt.new_bool(!rt.is_true(var_src)
				|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_src.dup().is_string())))))))
			{
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
					rt.call_function('__', [
						rt.new_string('Each font src must be a non-empty string.'),
					]),
					rt.new_string('6.4.0')])
				return false
			}
		}
	}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_font_face_mutated.array_get('font-weight').is_string())))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_font_face_mutated.array_get('font-weight').is_long())))))))
	{
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('__', [
				rt.new_string('Font font-weight must be a properly formatted string or integer.'),
			]),
			rt.new_string('6.4.0')])
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_font_face_mutated.array_get('font-display'),
		this.valid_font_display,
		rt.new_bool(true),
	])))))
	{
		var_font_face_mutated.array_set('font-display',
			this.font_face_property_defaults.array_get('font-display'))
	}
	{
		mut iter_1 := var_font_face_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_property := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
				var_property.dup(),
				this.valid_font_face_properties,
				rt.new_bool(true),
			])))))
			{
				var_font_face_mutated.array_unset(var_property)
			}
		}
	}
	return var_font_face_mutated
}

fn (mut this Class_WP_Font_Face) get_css(var_font_faces rt.PhpVal) string {
	mut var_css := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := var_font_faces.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_font_face := item_1.val
			var_font_face = this.order_src(mut rt.cast_object_ptr[Class_array](var_font_face))
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	return var_css.dup().to_string().trim_right(' \t\n\r')
}

fn (mut this Class_WP_Font_Face) order_src(mut var_font_face Class_array) rt.PhpVal {
	mut var_font_face_mutated := var_font_face
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_font_face_mutated.array_get('src').is_array()))))) {
		var_font_face_mutated.array_set('src',
			rt.cast_array(var_font_face_mutated.array_get('src')))
	}
	mut var_src := []rt.PhpVal{}
	mut var_src_ordered := []rt.PhpVal{}
	{
		mut iter_1 := var_font_face_mutated.array_get('src').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_url := item_1.val
			if rt.is_true(rt.call_function('str_starts_with', [
				rt.new_string(var_url.dup().to_string().trim_space()),
				rt.new_string('data:'),
			]))
			{
				var_src_ordered << rt.create_array([
					rt.ArrayItem{ key: 'url', val: var_url },
					rt.ArrayItem{ key: 'format', val: 'data' },
				])
				continue
			}
			mut var_format := rt.call_function('pathinfo', [var_url.dup(),
				rt.get_constant('PATHINFO_EXTENSION')])
			var_src.array_set(var_format, var_url.dup())
		}
	}
	if !(!rt.is_true(var_src.array_get('woff2'))) {
		var_src_ordered << rt.create_array([
			rt.ArrayItem{ key: 'url', val: var_src.array_get('woff2') },
			rt.ArrayItem{ key: 'format', val: 'woff2' },
		])
	}
	if !(!rt.is_true(var_src.array_get('woff'))) {
		var_src_ordered << rt.create_array([
			rt.ArrayItem{ key: 'url', val: var_src.array_get('woff') },
			rt.ArrayItem{ key: 'format', val: 'woff' },
		])
	}
	if !(!rt.is_true(var_src.array_get('ttf'))) {
		var_src_ordered << rt.create_array([
			rt.ArrayItem{ key: 'url', val: var_src.array_get('ttf') },
			rt.ArrayItem{ key: 'format', val: 'truetype' },
		])
	}
	if !(!rt.is_true(var_src.array_get('eot'))) {
		var_src_ordered << rt.create_array([
			rt.ArrayItem{ key: 'url', val: var_src.array_get('eot') },
			rt.ArrayItem{ key: 'format', val: 'embedded-opentype' },
		])
	}
	if !(!rt.is_true(var_src.array_get('otf'))) {
		var_src_ordered << rt.create_array([
			rt.ArrayItem{ key: 'url', val: var_src.array_get('otf') },
			rt.ArrayItem{ key: 'format', val: 'opentype' },
		])
	}
	var_font_face_mutated.array_set('src', var_src_ordered.dup())
	return rt.new_object('array', []string{}, var_font_face_mutated)
}

fn (mut this Class_WP_Font_Face) build_font_face_css(mut var_font_face Class_array) rt.PhpVal {
	mut var_font_face_mutated := var_font_face
	mut var_css := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.call_function('str_contains', [var_font_face_mutated.array_get('font-family'), rt.new_string(' ')]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_font_face_mutated.array_get('font-family'), rt.new_string('"')])))))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_font_face_mutated.array_get('font-family'), rt.new_string("'")])))))))
	{
		var_font_face_mutated.array_set('font-family', '"' +
			(var_font_face_mutated.array_get('font-family')).str() + '"')
	}
	{
		mut iter_1 := var_font_face_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.identical(rt.new_string('src'), var_key)) {
				var_value = this.compile_src(mut rt.cast_object_ptr[Class_array](var_value))
			}
			if rt.is_true(rt.new_bool(
				rt.is_true(rt.identical(rt.new_string('font-variation-settings'), var_key))
				&& rt.is_true(rt.new_bool(var_value.dup().is_array()))))
			{
				var_value = this.compile_variations(mut rt.cast_object_ptr[Class_array](var_value))
			}
			if !(!rt.is_true(var_value)) {
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
	}
	return var_css.dup()
}

fn (mut this Class_WP_Font_Face) compile_src(mut var_value Class_array) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_src := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := var_value_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	var_src = rt.new_string(rt.new_string(var_src.dup().to_string().trim_left(' \t\n\r')))
	return var_src.dup()
}

fn (mut this Class_WP_Font_Face) compile_variations(mut var_font_variation_settings Class_array) rt.PhpVal {
	mut var_variations := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := var_font_variation_settings.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	return var_variations.dup()
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_wp_font_face() &Class_WP_Font_Face {
	mut obj := &Class_WP_Font_Face{
		PhpObjectBase:               rt.PhpObjectBase{}
		font_face_property_defaults: rt.new_array()
		valid_font_face_properties:  rt.new_array()
		valid_font_display:          rt.new_array()
	}
	return obj
}

fn create_wp_html_tag_processor() &Class_WP_HTML_Tag_Processor {
	mut obj := &Class_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Font_Face) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'generate_and_print' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.generate_and_print(mut dispatch_arg_0)
			return rt.new_null()
		}
		'validate_fonts' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.validate_fonts(mut dispatch_arg_0)
		}
		'validate_font_face_declarations' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.validate_font_face_declarations(mut dispatch_arg_0))
		}
		'get_css' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_css(dispatch_arg_0))
		}
		'order_src' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.order_src(mut dispatch_arg_0)
		}
		'build_font_face_css' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.build_font_face_css(mut dispatch_arg_0)
		}
		'compile_src' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.compile_src(mut dispatch_arg_0)
		}
		'compile_variations' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.compile_variations(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Font_Face) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'font_face_property_defaults' { return this.font_face_property_defaults }
		'valid_font_face_properties' { return this.valid_font_face_properties }
		'valid_font_display' { return this.valid_font_display }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Font_Face) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'font_face_property_defaults' {
			this.font_face_property_defaults = val
			return true
		}
		'valid_font_face_properties' {
			this.valid_font_face_properties = val
			return true
		}
		'valid_font_display' {
			this.valid_font_display = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

pub fn init_wp_includes_fonts_class_wp_font_face_php() {
}
