import rt

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Sale_Badge {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Sale_Badge) render_content(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_product := this.get_product_from_context(rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array',
		[]string{}, var_parsed_block))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return ''
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'is_on_sale', []rt.PhpVal{}))))) {
		return ''
	}
	mut var_attributes := if !(var_parsed_block.array_get(rt.new_string('attrs'))).is_null() {
		var_parsed_block.array_get(rt.new_string('attrs'))
	} else {
		rt.new_array()
	}
	mut var_sale_text := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_sale_badge_text'),
		rt.call_function('__', [rt.new_string('Sale'), rt.new_string('woocommerce')]),
		var_product.clone(),
	])
	mut var_badge_html := rt.new_string(this.build_badge_html(var_sale_text.str(), mut
		rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](var_attributes), mut
		var_rendering_context))
	return this.apply_email_wrapper(var_badge_html.str(), mut var_parsed_block)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Sale_Badge) build_badge_html(sale_text string, mut var_attributes Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut sale_text_mutated := sale_text
	mut var_attributes_mutated := var_attributes
	mut var_align := if !(var_attributes_mutated.array_get(rt.new_string('align'))).is_null() {
		var_attributes_mutated.array_get(rt.new_string('align'))
	} else {
		rt.new_string('left')
	}
	mut var_position_style := this.get_position_style(var_align.str())
	mut var_badge_styles := rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: 'font-size', val: '0.875em' },
			rt.ArrayItem{ key: 'padding', val: '0.25em 0.75em' },
			rt.ArrayItem{ key: 'display', val: 'inline-block' },
			rt.ArrayItem{ key: 'width', val: 'fit-content' },
			rt.ArrayItem{ key: 'border', val: '1px solid #43454b' },
			rt.ArrayItem{ key: 'border-radius', val: '4px' },
			rt.ArrayItem{ key: 'box-sizing', val: 'border-box' },
			rt.ArrayItem{ key: 'color', val: '#43454b' }, rt.ArrayItem{
				key: 'background'
				val: '#fff'
			}, rt.ArrayItem{ key: 'text-align', val: 'center' },
			rt.ArrayItem{ key: 'text-transform', val: 'uppercase' },
			rt.ArrayItem{ key: 'font-weight', val: '600' }, rt.ArrayItem{ key: 'z-index', val: '9' },
			rt.ArrayItem{ key: 'position', val: 'static' }]),
		var_position_style.clone(),
	])
	mut iife_temp_0 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
	mut iife_result_0 := iife_temp_0.get_block_styles(rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array',
		[]string{}, var_attributes_mutated), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context',
		[]string{}, var_rendering_context), rt.create_array([
		rt.ArrayItem{ key: none, val: 'border' },
		rt.ArrayItem{ key: none, val: 'background-color' },
		rt.ArrayItem{ key: none, val: 'color' },
		rt.ArrayItem{ key: none, val: 'typography' },
		rt.ArrayItem{ key: none, val: 'spacing' },
	]))
	mut var_custom_styles := iife_result_0
	mut iife_temp_1 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Style_Engine{}
	mut iife_result_1 := iife_temp_1.compile_css(rt.call_function('array_merge', [
		var_badge_styles.clone(),
		if !(var_custom_styles.array_get(rt.new_string('declarations'))).is_null() {
			var_custom_styles.array_get(rt.new_string('declarations'))
		} else {
			rt.new_array()
		},
	]), rt.new_string(''))
	mut var_style_attr := iife_result_1
	return (rt.call_function('sprintf', [
		rt.new_string('<span class="wc-block-components-product-sale-badge__text" style="%s">%s</span>'),
		rt.call_function('esc_attr', [var_style_attr.clone()]),
		rt.call_function('esc_html', [rt.new_string(sale_text_mutated).clone()]),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Sale_Badge) get_position_style(align string) rt.PhpVal {
	mut align_mutated := align
	mut switch_val_1 := rt.new_string(align_mutated)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('left'))) {
		return rt.create_array([rt.ArrayItem{ key: 'text-align', val: 'left' },
			rt.ArrayItem{ key: 'margin-right', val: 'auto' }])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('center'))) {
		return rt.create_array([rt.ArrayItem{ key: 'text-align', val: 'center' },
			rt.ArrayItem{ key: 'margin-left', val: 'auto' }, rt.ArrayItem{
				key: 'margin-right'
				val: 'auto'
			}])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('right'))) {
		return rt.create_array([rt.ArrayItem{ key: 'text-align', val: 'right' },
			rt.ArrayItem{ key: 'margin-left', val: 'auto' }])
	} else {
		return rt.create_array([rt.ArrayItem{ key: 'text-align', val: 'left' }])
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Sale_Badge) apply_email_wrapper(badge_html string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array) string {
	mut badge_html_mutated := badge_html
	mut var_align := if !(var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('align'))).is_null() {
		var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('align'))
	} else {
		rt.new_string('left')
	}
	mut var_wrapper_styles := rt.create_array([
		rt.ArrayItem{ key: 'border-collapse', val: 'collapse' },
		rt.ArrayItem{ key: 'width', val: '100%' },
	])
	mut var_cell_styles := rt.create_array([rt.ArrayItem{ key: 'padding', val: '5px 0' },
		rt.ArrayItem{ key: 'text-align', val: var_align }])
	mut iife_temp_2 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Style_Engine{}
	mut iife_result_2 := iife_temp_2.compile_css(var_wrapper_styles.clone(), rt.new_string(''))
	mut var_table_attrs := rt.create_array([
		rt.ArrayItem{ key: 'style', val: iife_result_2 },
		rt.ArrayItem{ key: 'width', val: '100%' },
	])
	mut iife_temp_3 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Style_Engine{}
	mut iife_result_3 := iife_temp_3.compile_css(var_cell_styles.clone(), rt.new_string(''))
	mut var_cell_attrs := rt.create_array([
		rt.ArrayItem{ key: 'class', val: 'email-product-sale-badge-cell' },
		rt.ArrayItem{ key: 'style', val: iife_result_3 },
		rt.ArrayItem{ key: 'align', val: var_align },
	])
	mut iife_temp_4 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
	mut iife_result_4 := iife_temp_4.render_table_wrapper(rt.new_string(badge_html_mutated),
		var_table_attrs.clone(), var_cell_attrs.clone())
	return iife_result_4.str()
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Style_Engine {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_integrations_woocommerce_renderer_blocks_product_sale_badge(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Sale_Badge {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Sale_Badge{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_woocommerce_renderer_blocks_abstract_product_block_renderer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer{
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

fn create_automattic_woocommerce_emaileditor_integrations_woocommerce_renderer_blocks_wp_style_engine(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Style_Engine {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Style_Engine{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_table_wrapper_helper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Sale_Badge) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.render_content(dispatch_arg_0, mut dispatch_arg_1, mut
				dispatch_arg_2))
		}
		'build_badge_html' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.build_badge_html(dispatch_arg_0, mut dispatch_arg_1, mut
				dispatch_arg_2))
		}
		'get_position_style' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_position_style(dispatch_arg_0)
		}
		'apply_email_wrapper' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.apply_email_wrapper(dispatch_arg_0, mut dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Sale_Badge) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Sale_Badge) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Style_Engine) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Style_Engine) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Style_Engine) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
