import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_Flex_Layout_Renderer {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_Flex_Layout_Renderer) render_inner_blocks_in_layout(mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_theme_styles := var_rendering_context.get_theme_styles()
	mut var_flex_gap := if !(var_theme_styles.array_get('spacing').array_get('blockGap')).is_null() {
		var_theme_styles.array_get('spacing').array_get('blockGap')
	} else {
		rt.new_string('0px')
	}
	mut var_flex_gap_number := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
		return temp.parse_value(arg_0)
	}(var_flex_gap.dup())
	mut var_margin_top := if !(var_parsed_block.array_get('email_attrs').array_get('margin-top')).is_null() {
		var_parsed_block.array_get('email_attrs').array_get('margin-top')
	} else {
		rt.new_string('0px')
	}
	mut var_justify := if !(var_parsed_block.array_get('attrs').array_get('layout').array_get('justifyContent')).is_null() {
		var_parsed_block.array_get('attrs').array_get('layout').array_get('justifyContent')
	} else {
		rt.new_string('left')
	}
	mut var_styles := if !(rt.call_function('wp_style_engine_get_styles', [if !(var_parsed_block.array_get('attrs').array_get('style')).is_null() {
		var_parsed_block.array_get('attrs').array_get('style')
	} else {
		rt.new_array()
	}]).array_get('css')).is_null() { rt.call_function('wp_style_engine_get_styles', [
			if !(var_parsed_block.array_get('attrs').array_get('style')).is_null() {
				var_parsed_block.array_get('attrs').array_get('style')
			} else {
				rt.new_array()
			},
		]).array_get('css')
	 } else { rt.new_string('')
	 }
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	mut var_output_html := rt.call_function('sprintf', [
		rt.new_string('<!--[if mso | IE]><table align="%2$s" role="presentation" border="0" cellpadding="0" cellspacing="0" width="100%%"><tr><td style="%1$s" ><![endif]-->\n      <div style="%1$s"><table class="layout-flex-wrapper" style="display:inline-block"><tbody><tr>'),
		rt.call_function('esc_attr', [var_styles.dup()]),
		rt.call_function('esc_attr', [var_justify.dup()]),
	])
	mut var_inner_blocks := this.compute_widths_for_flex_layout(mut var_parsed_block,
		var_flex_gap_number.to_f64())
	{
		mut iter_1 := var_inner_blocks.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block := item_1.val
			mut var_key := item_1.key
			var_styles = rt.new_array()
			if rt.is_true(if !(var_block.array_get('email_attrs').array_get('layout_width')).is_null() {
				var_block.array_get('email_attrs').array_get('layout_width')
			} else {
				rt.new_null()
			})
			{
				var_styles.array_set('width',
					var_block.array_get('email_attrs').array_get('layout_width'))
			}
			if rt.is_true(rt.greater(var_key, rt.new_int(0))) {
				var_styles.array_set('padding-left', var_flex_gap.dup())
			}
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	// unsupported expression: Expr_AssignOp_Concat
	return var_output_html.str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_Flex_Layout_Renderer) compute_widths_for_flex_layout(mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_array, flex_gap f64) rt.PhpVal {
	mut flex_gap_mutated := flex_gap
	if !(var_parsed_block.array_get('email_attrs').array_isset(rt.new_string('width'))) {
		return if !(var_parsed_block.array_get('innerBlocks')).is_null() {
			var_parsed_block.array_get('innerBlocks')
		} else {
			rt.new_array()
		}
	}
	mut var_blocks_count :=
		rt.new_int(rt.new_int(var_parsed_block.array_get('innerBlocks').array_count()))
	mut var_total_used_width := rt.new_int(rt.new_int(0))
	mut var_parent_width := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
		return temp.parse_value(arg_0)
	}(var_parsed_block.array_get('email_attrs').array_get('width'))
	mut var_inner_blocks := if !(var_parsed_block.array_get('innerBlocks')).is_null() {
		var_parsed_block.array_get('innerBlocks')
	} else {
		rt.new_array()
	}
	{
		mut iter_1 := var_inner_blocks.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block := item_1.val
			mut var_key := item_1.key
			mut var_block_width_percent := rt.new_int(if rt.is_true(if !(var_block.array_get('attrs').array_get('width')).is_null() {
				var_block.array_get('attrs').array_get('width')
			} else {
				rt.new_int(0)
			})
			{ rt.new_int(var_block.array_get('attrs').array_get('width').to_i64())
			 } else { rt.new_int(0)
			 })
			mut var_block_width := rt.call_function('floor', [
				rt.mul(var_parent_width, rt.div(var_block_width_percent, rt.new_int(100))),
			])
			// unsupported expression: Expr_AssignOp_Plus
			if rt.is_true(rt.new_bool(!(rt.is_true(var_block_width)))) {
				var_inner_blocks.array_get_mut(var_key).array_get_mut('email_attrs').array_set('layout_width',
					rt.new_null())
				continue
			}
			var_inner_blocks.array_get_mut(var_key).array_get_mut('email_attrs').array_set('layout_width',
				this.get_width_without_gap(var_block_width.to_f64(), flex_gap_mutated, var_block_width_percent.to_f64()).str() +
				'px')
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.less_equal(var_blocks_count, rt.new_int(1)))
		|| rt.is_true(rt.less_equal(var_total_used_width, var_parent_width))))
	{
		return var_inner_blocks.dup()
	}
	{
		mut iter_1 := var_inner_blocks.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block := item_1.val
			mut var_key := item_1.key
			mut var_proportional_space_overflow := rt.div(var_parent_width, var_total_used_width)
			mut var_block_width := if rt.is_true(var_block.array_get('email_attrs').array_get('layout_width')) {
				fn (arg_0 rt.PhpVal) rt.PhpVal {
					mut temp :=
						Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
					return temp.parse_value(arg_0)
				}(var_block.array_get('email_attrs').array_get('layout_width'))
			} else {
				rt.new_int(0)
			}
			mut var_block_proportional_width := rt.mul(var_block_width,
				var_proportional_space_overflow)
			mut var_block_proportional_percentage := rt.mul(rt.div(var_block_proportional_width,
				var_parent_width), rt.new_int(100))
			var_inner_blocks.array_get_mut(var_key).array_get_mut('email_attrs').array_set('layout_width', if rt.is_true(var_block_width) {
					this.get_width_without_gap(var_block_proportional_width.to_f64(), flex_gap_mutated, var_block_proportional_percentage.to_f64()).str() +
					'px'
			} else {
				rt.new_null()
			})
		}
	}
	return var_inner_blocks.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_Flex_Layout_Renderer) get_width_without_gap(block_width f64, flex_gap f64, block_width_percent f64) i64 {
	mut block_width_mutated := block_width
	mut flex_gap_mutated := flex_gap
	mut block_width_percent_mutated := block_width_percent
	mut var_width_gap_reduction :=
		rt.new_float(flex_gap_mutated * 100 - block_width_percent_mutated / 100)
	return rt.call_function('floor', [block_width_mutated - var_width_gap_reduction]).to_i64()
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_layout_flex_layout_renderer() &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_Flex_Layout_Renderer {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_Flex_Layout_Renderer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_styles_helper() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{
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

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_engine_renderer_contentrenderer_layout_class_flex_layout_renderer_php() {
	// unsupported statement: Stmt_Declare
}
