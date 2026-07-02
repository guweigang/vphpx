import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Border_Style_Postprocessor {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Border_Style_Postprocessor) postprocess(html string) string {
	mut var_processor :=
		create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_postprocessors_wp_html_tag_processor(rt.new_string(html))
	for rt.is_true(var_processor.next_tag()) {
		mut var_style := var_processor.get_attribute(rt.new_string('style'))
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_style))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), var_style)))) {
			mut var_processed_style := rt.new_string(this.process_style(var_style.str()))
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_processed_style, var_style)))) {
				var_processor.set_attribute(rt.new_string('style'), var_processed_style.clone())
			}
		}
	}
	return (var_processor.get_updated_html()).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Border_Style_Postprocessor) process_style(style string) string {
	mut var_matches := rt.new_null()
	mut style_mutated := style
	mut var_styles := rt.new_array()
	mut iter_1 := rt.call_function('explode', [rt.new_string(';'),
		rt.new_string(style_mutated).clone()]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_declaration := item_1.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
			var_declaration.clone(),
			rt.new_string(':'),
		]), rt.new_bool(false)))))
		{
			mut list_tmp_1 := rt.call_function('array_map', [
				rt.new_string('trim'),
				rt.call_function('explode', [
					rt.new_string(':'), var_declaration.clone(),
					rt.new_int(2)])])
			mut var_prop := list_tmp_1.array_get(0)
			mut var_value := list_tmp_1.array_get(1)
			var_styles.array_set(var_prop.clone().to_string().to_lower(), var_value.clone())
		}
	}
	mut var_should_update_style := rt.new_bool(false)
	mut var_border_widths := rt.new_array()
	mut var_border_styles := rt.new_array()
	mut iter_2 := var_styles.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_value := item_2.val
		mut var_prop := item_2.key
		if rt.is_true(rt.identical(rt.new_string('border'), var_prop)) {
			mut var_border_width :=
				rt.new_string(this.extract_width_from_shorthand_value(var_value.str()))
			if rt.is_true(var_border_width) {
				var_border_widths.array_set('top', var_border_width.clone())
				var_border_widths.array_set('right', var_border_width.clone())
				var_border_widths.array_set('bottom', var_border_width.clone())
				var_border_widths.array_set('left', var_border_width.clone())
			}
			mut var_border_style :=
				rt.new_string(this.extract_style_from_shorthand_value(var_value.str()))
			if rt.is_true(var_border_style) {
				var_border_styles.array_set('top', var_border_style.clone())
				var_border_styles.array_set('right', var_border_style.clone())
				var_border_styles.array_set('bottom', var_border_style.clone())
				var_border_styles.array_set('left', var_border_style.clone())
			}
		}
		if rt.is_true(rt.call_function('preg_match', [
			rt.new_string('/^border-(top|right|bottom|left)$/'),
			var_prop.clone(),
			var_matches.clone(),
		]))
		{
			var_border_width =
				rt.new_string(this.extract_width_from_shorthand_value(var_value.str()))
			if rt.is_true(var_border_width) {
				var_border_widths.array_set(var_matches.array_get(rt.new_int(1)),
					var_border_width.clone())
			}
			var_border_style =
				rt.new_string(this.extract_style_from_shorthand_value(var_value.str()))
			if rt.is_true(var_border_style) {
				var_border_styles.array_set(var_matches.array_get(rt.new_int(1)),
					var_border_style.clone())
			}
		}
		if rt.is_true(rt.identical(rt.new_string('border-width'), var_prop)) {
			var_border_widths = rt.call_function('array_merge', [
				var_border_widths.clone(), this.expand_shorthand_value(var_value.str())])
		}
		if rt.is_true(rt.call_function('preg_match', [
			rt.new_string('/^border-(top|right|bottom|left)-width$/'),
			var_prop.clone(),
			var_matches.clone(),
		]))
		{
			var_border_widths.array_set(var_matches.array_get(rt.new_int(1)), var_value.clone())
		}
		if rt.is_true(rt.identical(rt.new_string('border-style'), var_prop)) {
			var_border_styles = rt.call_function('array_merge', [
				var_border_styles.clone(), this.expand_shorthand_value(var_value.str())])
			var_styles.array_unset(var_prop)
			var_should_update_style = rt.new_bool(true)
		}
		if rt.is_true(rt.call_function('preg_match', [
			rt.new_string('/^border-(top|right|bottom|left)-style$/'),
			var_prop.clone(),
			var_matches.clone(),
		]))
		{
			var_border_styles.array_set(var_matches.array_get(rt.new_int(1)), var_value.clone())
			var_styles.array_unset(var_prop)
			var_should_update_style = rt.new_bool(true)
		}
	}
	if rt.is_true(rt.call_function('array_diff', [
		rt.func_array_keys(var_border_widths.clone()),
		rt.func_array_keys(var_border_styles.clone()),
	]))
	{
		var_should_update_style = rt.new_bool(true)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_should_update_style)))) {
		return style_mutated
	}
	mut var_border_styles_declarations := rt.new_array()
	mut iter_3 := var_border_widths.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_value := item_3.val
		mut var_side := item_3.key
		if this.is_nonzero_width(var_value.str()) {
			var_border_styles_declarations.array_set('border-${var_side.to_string()}-style', if var_border_styles.array_isset(var_side) {
				var_border_styles.array_get(var_side)
			} else {
				rt.new_string('solid')
			})
		}
	}
	if 4 == var_border_styles_declarations.clone().array_count()
		&& 1 == rt.call_function('array_unique', [var_border_styles_declarations.clone()]).array_count() {
		var_border_styles_declarations = rt.create_array([
			rt.ArrayItem{ key: 'border-style', val: rt.call_function('array_values', [
				var_border_styles_declarations.clone(),
			]).array_get(rt.new_int(0)) },
		])
	}
	mut var_merged_styles := rt.call_function('array_merge', [
		var_styles.clone(), var_border_styles_declarations.clone()])
	mut var_updated_style := rt.new_string('')
	mut iter_4 := var_merged_styles.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_value := item_4.val
		mut var_prop := item_4.key
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_value)))) {
			var_updated_style = rt.concat(var_updated_style, rt.new_string(var_prop.str() + ': ' +
				var_value.str() + '; '))
		}
	}
	return var_updated_style.clone().to_string().trim_space()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Border_Style_Postprocessor) expand_shorthand_value(value string) rt.PhpVal {
	mut var_values := rt.call_function('preg_split', [rt.new_string('/\\s+/'),
		rt.new_string(value.trim_space())])
	if !(var_values.clone().is_array()) {
		return rt.new_array()
	}
	mut var_count := rt.new_int(var_values.clone().array_count())
	if rt.is_true(rt.identical(rt.new_int(4), var_count)) {
		return rt.create_array([
			rt.ArrayItem{
				key: 'top'
				val: if !(var_values.array_get(rt.new_int(0))).is_null() {
					var_values.array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'right'
				val: if !(var_values.array_get(rt.new_int(1))).is_null() {
					var_values.array_get(rt.new_int(1))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'bottom'
				val: if !(var_values.array_get(rt.new_int(2))).is_null() {
					var_values.array_get(rt.new_int(2))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'left'
				val: if !(var_values.array_get(rt.new_int(3))).is_null() {
					var_values.array_get(rt.new_int(3))
				} else {
					rt.new_string('')
				}
			},
		])
	}
	if rt.is_true(rt.identical(rt.new_int(3), var_count)) {
		return rt.create_array([
			rt.ArrayItem{
				key: 'top'
				val: if !(var_values.array_get(rt.new_int(0))).is_null() {
					var_values.array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'right'
				val: if !(var_values.array_get(rt.new_int(1))).is_null() {
					var_values.array_get(rt.new_int(1))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'bottom'
				val: if !(var_values.array_get(rt.new_int(2))).is_null() {
					var_values.array_get(rt.new_int(2))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'left'
				val: if !(var_values.array_get(rt.new_int(1))).is_null() {
					var_values.array_get(rt.new_int(1))
				} else {
					rt.new_string('')
				}
			},
		])
	}
	if rt.is_true(rt.identical(rt.new_int(2), var_count)) {
		return rt.create_array([
			rt.ArrayItem{
				key: 'top'
				val: if !(var_values.array_get(rt.new_int(0))).is_null() {
					var_values.array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'right'
				val: if !(var_values.array_get(rt.new_int(1))).is_null() {
					var_values.array_get(rt.new_int(1))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'bottom'
				val: if !(var_values.array_get(rt.new_int(0))).is_null() {
					var_values.array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'left'
				val: if !(var_values.array_get(rt.new_int(1))).is_null() {
					var_values.array_get(rt.new_int(1))
				} else {
					rt.new_string('')
				}
			},
		])
	}
	if rt.is_true(rt.identical(rt.new_int(1), var_count)) {
		return rt.create_array([
			rt.ArrayItem{
				key: 'top'
				val: if !(var_values.array_get(rt.new_int(0))).is_null() {
					var_values.array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'right'
				val: if !(var_values.array_get(rt.new_int(0))).is_null() {
					var_values.array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'bottom'
				val: if !(var_values.array_get(rt.new_int(0))).is_null() {
					var_values.array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'left'
				val: if !(var_values.array_get(rt.new_int(0))).is_null() {
					var_values.array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
		])
	}
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Border_Style_Postprocessor) extract_width_from_shorthand_value(value string) string {
	mut var_parts := rt.call_function('preg_split', [rt.new_string('/\\s+/'),
		rt.new_string(value.trim_space())])
	if !(var_parts.clone().is_array()) {
		return (rt.new_null()).str()
	}
	mut iter_5 := var_parts.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_part := item_5.val
		if rt.is_true(rt.call_function('preg_match', [
			rt.new_string('/^\\d+([a-z%]+)?$/'),
			var_part.clone(),
		]))
		{
			return var_part.str()
		}
	}
	return (rt.new_null()).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Border_Style_Postprocessor) extract_style_from_shorthand_value(value string) string {
	mut var_parts := rt.call_function('preg_split', [rt.new_string('/\\s+/'),
		rt.new_string(value.trim_space())])
	if !(var_parts.clone().is_array()) {
		return (rt.new_null()).str()
	}
	mut iter_6 := var_parts.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_part := item_6.val
		if rt.is_true(rt.call_function('in_array', [var_part.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'none' },
				rt.ArrayItem{ key: none, val: 'hidden' }, rt.ArrayItem{ key: none, val: 'dotted' },
				rt.ArrayItem{ key: none, val: 'dashed' }, rt.ArrayItem{ key: none, val: 'solid' },
				rt.ArrayItem{ key: none, val: 'double' }, rt.ArrayItem{ key: none, val: 'groove' },
				rt.ArrayItem{ key: none, val: 'ridge' }, rt.ArrayItem{ key: none, val: 'inset' },
				rt.ArrayItem{ key: none, val: 'outset' }]),
			rt.new_bool(true)]))
		{
			return var_part.str()
		}
	}
	return (rt.new_null()).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Border_Style_Postprocessor) is_nonzero_width(width string) bool {
	return if rt.is_true(rt.call_function('preg_match', [
		rt.new_string('/^0([a-z%]+)?$/'),
		rt.new_string(width.trim_space()),
	]))
	{ false } else { true }
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_postprocessors_border_style_postprocessor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Border_Style_Postprocessor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Border_Style_Postprocessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_postprocessors_wp_html_tag_processor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_WP_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Border_Style_Postprocessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'postprocess' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.postprocess(dispatch_arg_0))
		}
		'process_style' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.process_style(dispatch_arg_0))
		}
		'expand_shorthand_value' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.expand_shorthand_value(dispatch_arg_0)
		}
		'extract_width_from_shorthand_value' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.extract_width_from_shorthand_value(dispatch_arg_0))
		}
		'extract_style_from_shorthand_value' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.extract_style_from_shorthand_value(dispatch_arg_0))
		}
		'is_nonzero_width' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_nonzero_width(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Border_Style_Postprocessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Border_Style_Postprocessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
