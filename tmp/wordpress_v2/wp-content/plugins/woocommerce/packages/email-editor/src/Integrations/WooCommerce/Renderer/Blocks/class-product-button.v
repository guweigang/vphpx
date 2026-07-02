import rt

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Button {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Button) get_wrapper_styles(mut var_block_attributes Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) rt.PhpVal {
	mut var_block_attributes_mutated := var_block_attributes
	mut iife_temp_0 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
	mut iife_result_0 := iife_temp_0.get_block_styles(rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array',
		[]string{}, var_block_attributes_mutated), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context',
		[]string{}, var_rendering_context), rt.create_array([
		rt.ArrayItem{ key: none, val: 'border' },
		rt.ArrayItem{ key: none, val: 'background-color' },
		rt.ArrayItem{ key: none, val: 'color' },
		rt.ArrayItem{ key: none, val: 'typography' },
		rt.ArrayItem{ key: none, val: 'spacing' },
	]))
	mut var_block_styles := iife_result_0
	mut iife_temp_1 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
	mut iife_result_1 := iife_temp_1.extend_block_styles(var_block_styles.clone(), rt.create_array([
		rt.ArrayItem{ key: 'word-break', val: 'break-word' },
		rt.ArrayItem{ key: 'display', val: 'block' },
	]))
	return iife_result_1
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Button) get_button_styles(mut var_block_attributes Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) rt.PhpVal {
	mut var_block_attributes_mutated := var_block_attributes
	mut iife_temp_2 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
	mut iife_result_2 := iife_temp_2.get_block_styles(rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array',
		[]string{}, var_block_attributes_mutated), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context',
		[]string{}, var_rendering_context), rt.create_array([
		rt.ArrayItem{ key: none, val: 'color' },
		rt.ArrayItem{ key: none, val: 'typography' },
	]))
	mut var_block_styles := iife_result_2
	mut iife_temp_3 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
	mut iife_result_3 := iife_temp_3.extend_block_styles(var_block_styles.clone(), rt.create_array([
		rt.ArrayItem{ key: 'display', val: 'block' },
		rt.ArrayItem{ key: 'text-decoration', val: 'none' },
		rt.ArrayItem{ key: 'width', val: '100%' },
	]))
	return iife_result_3
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Button) render_content(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_product := this.get_product_from_context(rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array',
		[]string{}, var_parsed_block))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return ''
	}
	mut var_collection := if !(var_parsed_block.array_get(rt.new_string('context')).array_get(rt.new_string('collection'))).is_null() {
		var_parsed_block.array_get(rt.new_string('context')).array_get(rt.new_string('collection'))
	} else {
		rt.new_string('')
	}
	mut var_is_cart_contents := rt.identical(rt.new_string('woocommerce/product-collection/cart-contents'),
		var_collection)
	if rt.is_true(var_is_cart_contents) {
		mut var_button_text := rt.call_function('__', [rt.new_string('Finish checkout'),
			rt.new_string('woocommerce')])
		mut var_button_url := rt.call_function('wc_get_cart_url', []rt.PhpVal{})
	} else {
		var_button_text = if rt.is_true(rt.call_method(var_product, 'add_to_cart_text', []rt.PhpVal{})) { rt.call_method(var_product, 'add_to_cart_text', []rt.PhpVal{}) } else { rt.call_function('__', [
				rt.new_string('Add to cart'),
				rt.new_string('woocommerce'),
			]) }
		if rt.is_true(rt.call_method(var_product, 'is_type', [rt.new_string('external')]))
			&& rt.is_true(rt.new_bool(rt.instance_of(var_product, 'Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WC_Product_External'))) {
			mut var_external_url := rt.call_method(var_product, 'get_product_url', []rt.PhpVal{})
			var_button_url = if rt.is_true(var_external_url) {
				var_external_url
			} else {
				rt.call_method(var_product, 'get_permalink', []rt.PhpVal{})
			}
		} else {
			var_button_url = rt.call_method(var_product, 'get_permalink', []rt.PhpVal{})
		}
	}
	mut var_block_attributes := rt.call_function('array_replace_recursive', [
		rt.create_array([rt.ArrayItem{ key: 'textColor', val: '#ffffff' },
			rt.ArrayItem{ key: 'backgroundColor', val: '#000000' },
			rt.ArrayItem{ key: 'textAlign', val: 'left' }, rt.ArrayItem{ key: 'width', val: '' },
			rt.ArrayItem{ key: 'style', val: rt.create_array([
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: '16px' },
					rt.ArrayItem{ key: 'fontWeight', val: 'bold' },
				]) },
				rt.ArrayItem{ key: 'border', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: '0' },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: '12px 24px' },
				]) },
			]) }]),
		if !(var_parsed_block.array_get(rt.new_string('attrs'))).is_null() {
			var_parsed_block.array_get(rt.new_string('attrs'))
		} else {
			rt.new_array()
		},
	])
	mut var_wrapper_styles := this.get_wrapper_styles(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](var_block_attributes), mut
		var_rendering_context)
	mut var_button_styles := this.get_button_styles(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](var_block_attributes), mut
		var_rendering_context)
	mut var_table_attrs := rt.create_array([
		rt.ArrayItem{ key: 'style', val: 'width:' +
			if rt.is_true(var_block_attributes.array_get(rt.new_string('width'))) { '100%' } else { 'auto' } +
			';' },
		rt.ArrayItem{ key: 'align', val: var_block_attributes.array_get(rt.new_string('textAlign')) },
	])
	mut var_cell_attrs := rt.create_array([
		rt.ArrayItem{ key: 'class', val: var_wrapper_styles.array_get(rt.new_string('classnames')) },
		rt.ArrayItem{ key: 'style', val: var_wrapper_styles.array_get(rt.new_string('css')) },
		rt.ArrayItem{ key: 'align', val: var_block_attributes.array_get(rt.new_string('textAlign')) },
		rt.ArrayItem{ key: 'valign', val: 'middle' },
		rt.ArrayItem{ key: 'role', val: 'presentation' },
	])
	mut var_button_content := rt.call_function('sprintf', [
		rt.new_string('<a class="product-button-link %1$s" style="%2$s" href="%3$s" target="_blank">%4$s</a>'),
		rt.call_function('esc_attr', [var_button_styles.array_get(rt.new_string('classnames'))]),
		rt.call_function('esc_attr', [var_button_styles.array_get(rt.new_string('css'))]),
		rt.call_function('esc_url', [var_button_url.clone()]),
		rt.call_function('esc_html', [var_button_text.clone()]),
	])
	mut iife_temp_4 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
	mut iife_result_4 := iife_temp_4.render_table_wrapper(var_button_content.clone(),
		var_table_attrs.clone(), var_cell_attrs.clone())
	mut var_button_html := iife_result_4
	mut iife_temp_5 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
	mut iife_result_5 := iife_temp_5.render_table_wrapper(var_button_html.clone(), rt.create_array([
		rt.ArrayItem{ key: 'style', val: 'width: 100%' },
	]))
	return iife_result_5.str()
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_integrations_woocommerce_renderer_blocks_product_button(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Button {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Button{
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

fn create_automattic_woocommerce_emaileditor_integrations_utils_table_wrapper_helper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Button) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_wrapper_styles' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.get_wrapper_styles(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_button_styles' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.get_button_styles(mut dispatch_arg_0, mut dispatch_arg_1)
		}
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
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Button) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Button) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
