import rt

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper {
	rt.PhpObjectBase
pub mut:
		empty_block_styles rt.PhpVal = rt.new_array()
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper.parse_value(var_value rt.PhpVal) f64 {
	mut var_m := rt.new_null()
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(var_value_mutated.dup().is_long() || var_value_mutated.dup().is_double())) {
		return (// unsupported expression: Expr_Cast_Double).to_f64()
	}
	if rt.is_true(rt.new_bool(var_value_mutated.dup().is_string())) {
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^\\s*(-?\\d+(?:\\.\\d+)?)/'), var_value_mutated.dup(), var_m.dup()])) {
			return (// unsupported expression: Expr_Cast_Double).to_f64()
		}
	}
	return 0
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper.parse_styles_to_array(styles string) rt.PhpVal {
	mut styles_mutated := styles
	styles_mutated = (rt.call_function('explode', [rt.new_string(';'), rt.new_string(styles_mutated).dup()])).str()
	mut var_parsed_styles := rt.new_array()
	{
		mut iter_1 := rt.new_string(styles_mutated).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_style := item_1.val
			var_style = rt.call_function('explode', [rt.new_string(':'), var_style.dup(), rt.new_int(2)])
			if var_style.dup().array_count() == 2 {
				var_parsed_styles.array_set(var_style.array_get(0).to_string().trim_space(), var_style.array_get(1).to_string().trim_space())
			}
		}
	}
	return var_parsed_styles.dup()
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper.get_normalized_block_styles(mut var_block_attributes Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) rt.PhpVal {
	mut var_normalized_colors := rt.call_function('array_filter', [rt.create_array([rt.ArrayItem{ key: 'color', val: rt.call_function('array_filter', [rt.create_array([rt.ArrayItem{ key: 'background', val: if rt.is_true(rt.new_bool(var_block_attributes.array_isset(rt.new_string('backgroundColor')) && rt.is_true(var_block_attributes.array_get('backgroundColor')))) { var_rendering_context.translate_slug_to_color(var_block_attributes.array_get('backgroundColor')) } else { rt.new_null() } }, rt.ArrayItem{ key: 'text', val: if rt.is_true(rt.new_bool(var_block_attributes.array_isset(rt.new_string('textColor')) && rt.is_true(var_block_attributes.array_get('textColor')))) { var_rendering_context.translate_slug_to_color(var_block_attributes.array_get('textColor')) } else { rt.new_null() } }])]) }, rt.ArrayItem{ key: 'border', val: rt.call_function('array_filter', [rt.create_array([rt.ArrayItem{ key: 'color', val: if rt.is_true(rt.new_bool(var_block_attributes.array_isset(rt.new_string('borderColor')) && rt.is_true(var_block_attributes.array_get('borderColor')))) { var_rendering_context.translate_slug_to_color(var_block_attributes.array_get('borderColor')) } else { rt.new_null() } }])]) }])])
	return rt.call_function('array_replace_recursive', [var_normalized_colors.dup(), if !(var_block_attributes.array_get('style')).is_null() { var_block_attributes.array_get('style') } else { rt.new_array() }])
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper.get_styles_from_block(mut var_block_styles Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array, skip_convert_vars bool) rt.PhpVal {
	mut var_pointer := rt.new_null()
	mut var_block_styles_mutated := var_block_styles
	mut var_unsupported_props := rt.create_array([rt.ArrayItem{ key: 'margin', val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'margin' }]) }])
	var_unsupported_props = rt.call_function('apply_filters', [rt.new_string('woocommerce_email_editor_styles_unsupported_props'), var_unsupported_props.dup()])
	{
		mut iter_1 := var_unsupported_props.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_path := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_path.dup().is_array()))))) || var_path.dup().array_count() == 0)) {
				continue
			}
			// unsupported expression: Expr_AssignRef
			mut var_last_key := rt.call_function('array_pop', [var_path.dup()])
			{
				mut iter_2 := var_path.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_segment := item_2.val
					if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_segment.dup().is_string()))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_segment.dup().is_long()))))))) {
						continue
					}
					if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_pointer.dup().array_isset(var_segment.dup())))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_pointer.array_get(var_segment).is_array()))))))) {
						continue
					}
					// unsupported expression: Expr_AssignRef
				}
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_last_key.dup().is_string())) || rt.is_true(rt.new_bool(var_last_key.dup().is_long())))) && rt.is_true(rt.new_bool(var_pointer.dup().array_isset(var_last_key.dup()))))) {
				var_pointer.array_unset(var_last_key)
			}
		}
	}
	return rt.call_function('wp_parse_args', [rt.call_function('wp_style_engine_get_styles', [var_block_styles_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'convert_vars_to_classnames', val: skip_convert_vars }])]), // unsupported expression: Expr_StaticPropertyFetch])
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper.extend_block_styles(mut var_block_styles Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array, mut var_css_declarations Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array) rt.PhpVal {
	mut var_block_styles_mutated := var_block_styles
	if rt.is_true(rt.new_bool(!(var_block_styles_mutated.array_isset(rt.new_string('declarations'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_block_styles_mutated.array_get('declarations').is_array()))))))) {
		var_block_styles_mutated = // unsupported expression: Expr_StaticPropertyFetch
	}
	var_block_styles_mutated.array_set('declarations', rt.call_function('array_merge', [var_block_styles_mutated.array_get('declarations'), var_css_declarations]))
	var_block_styles_mutated.array_set('css', fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Style_Engine{}; return temp.compile_css(arg_0, arg_1) }(var_block_styles_mutated.array_get('declarations'), rt.new_string('')))
	return rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_Utils_array', []string{}, var_block_styles_mutated)
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper.get_block_styles(mut var_block_attributes Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context, mut var_properties Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array) rt.PhpVal {
	mut var_filtered_styles_pointer := rt.new_null()
	mut var_styles := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper.get_normalized_block_styles(mut var_block_attributes, mut var_rendering_context)
	mut var_filtered_styles := rt.new_array()
	mut var_style_mappings := rt.create_array([rt.ArrayItem{ key: 'spacing', val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }]) }, rt.ArrayItem{ key: 'padding', val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'padding' }]) }, rt.ArrayItem{ key: 'margin', val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'margin' }]) }, rt.ArrayItem{ key: 'border', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }]) }, rt.ArrayItem{ key: 'border-width', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'width' }]) }, rt.ArrayItem{ key: 'border-style', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'style' }]) }, rt.ArrayItem{ key: 'border-radius', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'radius' }]) }, rt.ArrayItem{ key: 'border-color', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'color' }]) }, rt.ArrayItem{ key: 'background', val: rt.create_array([rt.ArrayItem{ key: none, val: 'background' }]) }, rt.ArrayItem{ key: 'background-color', val: rt.create_array([rt.ArrayItem{ key: none, val: 'color' }, rt.ArrayItem{ key: none, val: 'background' }]) }, rt.ArrayItem{ key: 'color', val: rt.create_array([rt.ArrayItem{ key: none, val: 'color' }, rt.ArrayItem{ key: none, val: 'text' }]) }, rt.ArrayItem{ key: 'typography', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }]) }, rt.ArrayItem{ key: 'font-size', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'fontSize' }]) }, rt.ArrayItem{ key: 'font-family', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'fontFamily' }]) }, rt.ArrayItem{ key: 'font-weight', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'fontWeight' }]) }])
	{
		mut iter_1 := var_properties.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_property := item_1.val
			if !(var_style_mappings.array_isset(var_property)) {
				continue
			}
			mut var_style_pointer := var_styles.dup()
			{
				mut iter_2 := var_style_mappings.array_get(var_property).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_path_segment := item_2.val
					if !(var_style_pointer.array_isset(var_path_segment)) {
						continue
					}
					var_style_pointer = var_style_pointer.array_get(var_path_segment)
				}
			}
			// unsupported expression: Expr_AssignRef
			{
				mut iter_2 := var_style_mappings.array_get(var_property).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_path_segment := item_2.val
					mut var_path_index := item_2.key
					if rt.is_true(rt.identical(var_style_mappings.array_get(var_property).array_count() - 1, var_path_index)) {
						var_filtered_styles_pointer.array_set(var_path_segment, var_style_pointer.dup())
						break
					}
					if rt.is_true(rt.new_bool(!(var_filtered_styles_pointer.array_isset(var_path_segment)) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_filtered_styles_pointer.array_get(var_path_segment).is_array()))))))) {
						var_filtered_styles_pointer.array_set(var_path_segment, rt.new_array())
					}
					// unsupported expression: Expr_AssignRef
				}
			}
		}
	}
	mut var_additional_css_declarations := rt.call_function('array_filter', [rt.call_function('array_intersect_key', [rt.create_array([rt.ArrayItem{ key: 'text-align', val: if !(var_block_attributes.array_get('textAlign')).is_null() { var_block_attributes.array_get('textAlign') } else { rt.new_null() } }]), rt.call_function('array_flip', [var_properties])])])
	var_styles = if var_filtered_styles.dup().array_count() > 0 { Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper.get_styles_from_block(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array](var_filtered_styles)) } else { // unsupported expression: Expr_StaticPropertyFetch }
	return Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper.extend_block_styles(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array](var_styles), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array](var_additional_css_declarations))
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper.convert_to_px(input string, use_fallback bool, mut var_base_font_size Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_?int) string {
	mut input_mutated := input
	mut var_fallback := if var_use_fallback { (var_base_font_size).str() + 'px' } else { rt.new_null() }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(input_mutated))))) {
		return (var_fallback).str()
	}
	input_mutated = input_mutated.trim_space()
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/[<>"\']/'), rt.new_string(input_mutated).dup()])) {
		return (var_fallback).str()
	}
	if rt.is_true(rt.call_function('str_ends_with', [rt.new_string(input_mutated).dup(), rt.new_string('px')])) {
		return input_mutated
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('str_ends_with', [rt.new_string(input_mutated).dup(), rt.new_string('rem')])) || rt.is_true(rt.call_function('str_ends_with', [rt.new_string(input_mutated).dup(), rt.new_string('em')])))) {
		mut var_value := // unsupported expression: Expr_Cast_Double
		return (rt.call_function('round', [rt.mul(var_value, var_base_font_size)])).str() + 'px'
	}
	if rt.is_true(rt.call_function('str_ends_with', [rt.new_string(input_mutated).dup(), rt.new_string('%')])) {
		var_value = // unsupported expression: Expr_Cast_Double
		return (rt.call_function('round', [rt.mul(rt.div(var_value, rt.new_int(100)), var_base_font_size)])).str() + 'px'
	}
	if rt.is_true(rt.new_bool(rt.new_string(input_mutated).dup().is_long() || rt.new_string(input_mutated).dup().is_double())) {
		return input_mutated + 'px'
	}
	return (var_fallback).str()
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper.remove_css_unit(input string) string {
	mut input_mutated := input
	mut var_units := rt.create_array([rt.ArrayItem{ key: none, val: 'px' }, rt.ArrayItem{ key: none, val: 'pt' }, rt.ArrayItem{ key: none, val: 'pc' }, rt.ArrayItem{ key: none, val: 'rem' }, rt.ArrayItem{ key: none, val: 'em' }, rt.ArrayItem{ key: none, val: 'vmin' }, rt.ArrayItem{ key: none, val: 'vmax' }, rt.ArrayItem{ key: none, val: '%' }, rt.ArrayItem{ key: none, val: 'vh' }, rt.ArrayItem{ key: none, val: 'vw' }, rt.ArrayItem{ key: none, val: 'ex' }, rt.ArrayItem{ key: none, val: 'ch' }, rt.ArrayItem{ key: none, val: 'fr' }])
	return (rt.call_function('str_ireplace', [var_units.dup(), rt.new_string(''), rt.new_string(input_mutated).dup()])).str()
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper.clamp_to_static_px(var_clamp_str rt.PhpVal, strategy string) string {
	if rt.is_true(rt.identical(rt.call_function('stripos', [var_clamp_str.dup(), rt.new_string('clamp(')]), rt.new_bool(false))) {
		return (var_clamp_str).str()
	}
	mut var_value_array := rt.call_function('explode', [rt.new_string(','), var_clamp_str.dup()])
	if var_value_array.dup().array_count() < 2 {
		return (var_clamp_str).str()
		// unsupported statement: Stmt_Nop
	}
	mut var_first_element := var_value_array.array_get(0)
	mut var_min := rt.new_string(rt.new_string(rt.call_function('str_ireplace', [rt.create_array([rt.ArrayItem{ key: none, val: 'clamp(' }, rt.ArrayItem{ key: none, val: 'min(' }, rt.ArrayItem{ key: none, val: 'max(' }]), rt.new_string(''), var_first_element.dup()]).to_string().trim_space()))
	mut var_last_element := var_value_array.array_get(var_value_array.dup().array_count() - 1)
	mut var_max := rt.new_string(rt.new_string(var_last_element.dup().to_string().trim_right(' \t\n\r').trim_space()))
	mut var_min_px := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper.convert_to_px((var_min).str(), false)
	mut var_max_px := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper.convert_to_px((var_max).str(), false)
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('min'), rt.new_string(strategy))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_min_px.dup().is_null()))))))) {
		return (var_min_px).str()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('max'), rt.new_string(strategy))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_max_px.dup().is_null()))))))) {
		return (var_max_px).str()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('avg'), rt.new_string(strategy))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_min_px.dup().is_null()))))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_max_px.dup().is_null()))))))) {
		mut var_avg := rt.div(rt.add(Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper.parse_value(var_min_px.dup()), Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper.parse_value(var_max_px.dup())), rt.new_int(2))
		return (var_avg).str() + 'px'
	}
	return (if !(var_min_px).is_null() { var_min_px } else { if !(var_max_px).is_null() { var_max_px } else { var_clamp_str } }).str()
}

struct Class_WP_Style_Engine {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_styles_helper() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
		empty_block_styles: rt.new_array()
	}
	return obj
}

fn create_wp_style_engine() &Class_WP_Style_Engine {
	mut obj := &Class_WP_Style_Engine{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'parse_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_float(Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper.parse_value(dispatch_arg_0))
		}
		'parse_styles_to_array' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper.parse_styles_to_array(dispatch_arg_0)
		}
		'get_normalized_block_styles' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper.get_normalized_block_styles(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_styles_from_block' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper.get_styles_from_block(mut dispatch_arg_0, dispatch_arg_1)
		}
		'extend_block_styles' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper.extend_block_styles(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_block_styles' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper.get_block_styles(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'convert_to_px' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_?int](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper.convert_to_px(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2))
		}
		'remove_css_unit' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper.remove_css_unit(dispatch_arg_0))
		}
		'clamp_to_static_px' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper.clamp_to_static_px(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'empty_block_styles' { return this.empty_block_styles }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'empty_block_styles' { this.empty_block_styles = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Style_Engine) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Style_Engine) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Style_Engine) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_integrations_utils_class_styles_helper_php() {
	// unsupported statement: Stmt_Declare
}
