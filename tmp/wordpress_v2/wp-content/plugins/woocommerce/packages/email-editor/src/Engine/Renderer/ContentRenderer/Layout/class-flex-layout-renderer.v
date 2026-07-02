import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_Flex_Layout_Renderer {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_Flex_Layout_Renderer) render_inner_blocks_in_layout(mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_theme_styles := var_rendering_context.get_theme_styles()
	mut var_flex_gap := if !(var_theme_styles.array_get(rt.new_string('spacing')).array_get(rt.new_string('blockGap'))).is_null() {
		var_theme_styles.array_get(rt.new_string('spacing')).array_get(rt.new_string('blockGap'))
	} else {
		rt.new_string('0px')
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
	mut iife_result_0 := iife_temp_0.parse_value(var_flex_gap.clone())
	mut var_flex_gap_number := iife_result_0
	mut var_margin_top := if !(var_parsed_block.array_get(rt.new_string('email_attrs')).array_get(rt.new_string('margin-top'))).is_null() {
		var_parsed_block.array_get(rt.new_string('email_attrs')).array_get(rt.new_string('margin-top'))
	} else {
		rt.new_string('0px')
	}
	mut var_justify := if !(var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('layout')).array_get(rt.new_string('justifyContent'))).is_null() {
		var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('layout')).array_get(rt.new_string('justifyContent'))
	} else {
		rt.new_string('left')
	}
	mut var_styles := if !(rt.call_function('wp_style_engine_get_styles', [if !(var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('style'))).is_null() {
		var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('style'))
	} else {
		rt.new_array()
	}]).array_get(rt.new_string('css'))).is_null() { rt.call_function('wp_style_engine_get_styles', [
			if !(var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('style'))).is_null() {
				var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('style'))
			} else {
				rt.new_array()
			},
		]).array_get(rt.new_string('css'))
	 } else { rt.new_string('')
	 }
	var_styles = rt.concat(var_styles, rt.new_string('margin-top: ' + var_margin_top.str() + ';'))
	var_styles = rt.concat(var_styles, rt.new_string('text-align: ' + var_justify.str()))
	mut var_output_html := rt.call_function('sprintf', [
		rt.new_string('<!--[if mso | IE]><table align="%2$s" role="presentation" border="0" cellpadding="0" cellspacing="0" width="100%%"><tr><td style="%1$s" ><![endif]-->\n      <div style="%1$s"><table class="layout-flex-wrapper" style="display:inline-block"><tbody><tr>'),
		rt.call_function('esc_attr', [var_styles.clone()]),
		rt.call_function('esc_attr', [var_justify.clone()]),
	])
	mut var_inner_blocks := this.compute_widths_for_flex_layout(mut var_parsed_block,
		var_flex_gap_number.to_f64())
	mut iter_1 := var_inner_blocks.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_block := item_1.val
		mut var_key := item_1.key
		var_styles = rt.new_array()
		if rt.is_true(if !(var_block.array_get(rt.new_string('email_attrs')).array_get(rt.new_string('layout_width'))).is_null() {
			var_block.array_get(rt.new_string('email_attrs')).array_get(rt.new_string('layout_width'))
		} else {
			rt.new_null()
		})
		{
			var_styles.array_set('width',
				var_block.array_get(rt.new_string('email_attrs')).array_get(rt.new_string('layout_width')))
		}
		if rt.is_true(rt.greater(var_key, rt.new_int(0))) {
			var_styles.array_set('padding-left', var_flex_gap.clone())
		}
		mut iife_temp_1 :=
			Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_WP_Style_Engine{}
		mut iife_result_1 := iife_temp_1.compile_css(var_styles.clone(), rt.new_string(''))
		mut iife_temp_2 :=
			Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_WP_Style_Engine{}
		mut iife_result_2 := iife_temp_2.compile_css(var_styles.clone(), rt.new_string(''))
		var_output_html = rt.concat(var_output_html, rt.new_string(
			'<td class="layout-flex-item" style="' +
			(rt.call_function('esc_attr', [iife_result_1])).str() + '">' +
			(rt.call_function('render_block', [var_block.clone()])).str() + '</td>'))
	}
	var_output_html = rt.concat(var_output_html,
		rt.new_string('</tr></table></div>\n    <!--[if mso | IE]></td></tr></table><![endif]-->'))
	return var_output_html.str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_Flex_Layout_Renderer) compute_widths_for_flex_layout(mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_array, flex_gap f64) rt.PhpVal {
	mut flex_gap_mutated := flex_gap
	if !(var_parsed_block.array_get(rt.new_string('email_attrs')).array_isset(rt.new_string('width'))) {
		return if !(var_parsed_block.array_get(rt.new_string('innerBlocks'))).is_null() {
			var_parsed_block.array_get(rt.new_string('innerBlocks'))
		} else {
			rt.new_array()
		}
	}
	mut var_blocks_count :=
		rt.new_int(var_parsed_block.array_get(rt.new_string('innerBlocks')).array_count())
	mut var_total_used_width := rt.new_int(0)
	mut iife_temp_3 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
	mut iife_result_3 :=
		iife_temp_3.parse_value(var_parsed_block.array_get(rt.new_string('email_attrs')).array_get(rt.new_string('width')))
	mut var_parent_width := iife_result_3
	mut var_inner_blocks := if !(var_parsed_block.array_get(rt.new_string('innerBlocks'))).is_null() {
		var_parsed_block.array_get(rt.new_string('innerBlocks'))
	} else {
		rt.new_array()
	}
	mut iter_2 := var_inner_blocks.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_block := item_2.val
		mut var_key := item_2.key
		mut var_block_width_percent := rt.new_int(if rt.is_true(if !(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('width'))).is_null() {
			var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('width'))
		} else {
			rt.new_int(0)
		})
		{ var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('width')).to_i64()
		 } else { 0
		 })
		mut var_block_width := rt.call_function('floor', [
			rt.mul(var_parent_width, rt.div(var_block_width_percent, rt.new_int(100))),
		])
		var_total_used_width = rt.add(var_total_used_width, if rt.is_true(var_block_width) { var_block_width } else { rt.call_function('floor', [
				rt.mul(var_parent_width, 25 / 100),
			]) })
		if rt.is_true(rt.new_bool(!(rt.is_true(var_block_width)))) {
			var_inner_blocks.array_get_mut(var_key).array_get_mut('email_attrs').array_set('layout_width',
				rt.new_null())
			continue
		}
		var_inner_blocks.array_get_mut(var_key).array_get_mut('email_attrs').array_set('layout_width',
			this.get_width_without_gap(var_block_width.to_f64(), flex_gap_mutated, var_block_width_percent.to_f64()).str() +
			'px')
	}
	if rt.is_true(rt.less_equal(var_blocks_count, rt.new_int(1)))
		|| rt.is_true(rt.less_equal(var_total_used_width, var_parent_width)) {
		return var_inner_blocks.clone()
	}
	mut iter_3 := var_inner_blocks.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_block := item_3.val
		mut var_key := item_3.key
		mut var_proportional_space_overflow := rt.div(var_parent_width, var_total_used_width)
		mut iife_temp_4 :=
			Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
		mut iife_result_4 :=
			iife_temp_4.parse_value(var_block.array_get(rt.new_string('email_attrs')).array_get(rt.new_string('layout_width')))
		mut var_block_width := if rt.is_true(var_block.array_get(rt.new_string('email_attrs')).array_get(rt.new_string('layout_width'))) {
			iife_result_4
		} else {
			rt.new_int(0)
		}
		mut var_block_proportional_width := rt.mul(var_block_width, var_proportional_space_overflow)
		mut var_block_proportional_percentage := rt.mul(rt.div(var_block_proportional_width,
			var_parent_width), rt.new_int(100))
		var_inner_blocks.array_get_mut(var_key).array_get_mut('email_attrs').array_set('layout_width', if rt.is_true(var_block_width) {
				this.get_width_without_gap(var_block_proportional_width.to_f64(), flex_gap_mutated, var_block_proportional_percentage.to_f64()).str() +
				'px'
		} else {
			rt.new_null()
		})
	}
	return var_inner_blocks.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_Flex_Layout_Renderer) get_width_without_gap(block_width f64, flex_gap f64, block_width_percent f64) i64 {
	mut block_width_mutated := block_width
	mut flex_gap_mutated := flex_gap
	mut block_width_percent_mutated := block_width_percent
	mut var_width_gap_reduction :=
		rt.new_float(flex_gap_mutated * 100 - block_width_percent_mutated / 100)
	return rt.call_function('floor', [
		rt.new_float(block_width_mutated - var_width_gap_reduction),
	]).to_i64()
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_WP_Style_Engine {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_layout_flex_layout_renderer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_Flex_Layout_Renderer {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_Flex_Layout_Renderer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_styles_helper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_layout_wp_style_engine(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_WP_Style_Engine {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_WP_Style_Engine{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_Flex_Layout_Renderer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_inner_blocks_in_layout' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.render_inner_blocks_in_layout(mut dispatch_arg_0, mut
				dispatch_arg_1))
		}
		'compute_widths_for_flex_layout' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_f64()
			return this.compute_widths_for_flex_layout(mut dispatch_arg_0, dispatch_arg_1)
		}
		'get_width_without_gap' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_f64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_f64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_f64()
			return rt.new_int(this.get_width_without_gap(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_Flex_Layout_Renderer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_Flex_Layout_Renderer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_WP_Style_Engine) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_WP_Style_Engine) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_WP_Style_Engine) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
