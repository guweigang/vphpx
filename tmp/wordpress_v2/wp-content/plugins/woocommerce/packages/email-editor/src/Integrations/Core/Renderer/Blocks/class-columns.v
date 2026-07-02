import rt

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Columns {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Columns) render_content(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	return (rt.call_function('str_replace', [rt.new_string('{columns_content}'),
		this.get_inner_content(rt.new_string(block_content)),
		rt.new_string(this.getblockwrapper(block_content, mut var_parsed_block, mut
			var_rendering_context))])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Columns) getblockwrapper(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_original_wrapper_classname := if !(rt.call_method(create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(rt.new_string(block_content)), 'get_attribute_value_by_tag_name', [
		rt.new_string('div'),
		rt.new_string('class'),
	])).is_null() { rt.call_method(create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(rt.new_string(block_content)), 'get_attribute_value_by_tag_name', [
			rt.new_string('div'),
			rt.new_string('class'),
		]) } else { rt.new_string('') }
	mut var_block_attributes := rt.call_function('wp_parse_args', [if !(var_parsed_block.array_get(rt.new_string('attrs'))).is_null() {
		var_parsed_block.array_get(rt.new_string('attrs'))
	} else {
		rt.new_array()
	},
		rt.create_array([rt.ArrayItem{ key: 'align', val: rt.new_null() },
			rt.ArrayItem{
				key: 'width'
				val: var_rendering_context.get_layout_width_without_padding()
			}, rt.ArrayItem{ key: 'style', val: rt.new_array() }])])
	mut iife_temp_0 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
	mut iife_result_0 := iife_temp_0.get_block_styles(var_block_attributes.clone(), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context',
		[]string{}, var_rendering_context), rt.create_array([
		rt.ArrayItem{ key: none, val: 'padding' },
		rt.ArrayItem{ key: none, val: 'border' },
		rt.ArrayItem{ key: none, val: 'background' },
		rt.ArrayItem{ key: none, val: 'background-color' },
		rt.ArrayItem{ key: none, val: 'color' },
	]))
	mut var_columns_styles := iife_result_0
	mut iife_temp_1 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
	mut iife_result_1 := iife_temp_1.extend_block_styles(var_columns_styles.clone(), rt.create_array([
		rt.ArrayItem{ key: 'width', val: '100%' },
		rt.ArrayItem{ key: 'border-collapse', val: 'separate' },
		rt.ArrayItem{ key: 'text-align', val: 'left' },
		rt.ArrayItem{
			key: 'background-size'
			val: if !(var_columns_styles.array_get(rt.new_string('declarations')).array_get(rt.new_string('background-size'))).is_null() {
				var_columns_styles.array_get(rt.new_string('declarations')).array_get(rt.new_string('background-size'))
			} else {
				rt.new_string('cover')
			}
		},
	]))
	var_columns_styles = iife_result_1
	mut var_columns_table_attrs := rt.create_array([
		rt.ArrayItem{ key: 'class', val: 'email-block-columns ' +
			var_original_wrapper_classname.str() },
		rt.ArrayItem{ key: 'style', val: var_columns_styles.array_get(rt.new_string('css')) },
		rt.ArrayItem{ key: 'align', val: 'center' },
	])
	mut iife_temp_2 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
	mut iife_result_2 := iife_temp_2.render_table_wrapper(rt.new_string('{columns_content}'),
		var_columns_table_attrs.clone(), rt.new_array(), rt.new_array(), rt.new_bool(false))
	mut var_columns_content := iife_result_2
	mut var_margins := if !(var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('spacing')).array_get(rt.new_string('margin'))).is_null() {
		var_block_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('spacing')).array_get(rt.new_string('margin'))
	} else {
		rt.new_array()
	}
	if !(!rt.is_true(var_margins)) {
		mut var_magin_to_padding_attributes := rt.create_array([
			rt.ArrayItem{ key: 'style', val: rt.create_array([
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: var_margins },
				]) },
			]) },
		])
		mut iife_temp_3 :=
			Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
		mut iife_result_3 := iife_temp_3.get_block_styles(var_magin_to_padding_attributes.clone(), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context',
			[]string{}, var_rendering_context), rt.create_array([
			rt.ArrayItem{ key: none, val: 'padding' },
		]))
		mut var_margin_wrapper_styles := iife_result_3
		mut iife_temp_4 :=
			Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
		mut iife_result_4 := iife_temp_4.extend_block_styles(var_margin_wrapper_styles.clone(), rt.create_array([
			rt.ArrayItem{ key: 'width', val: '100%' },
			rt.ArrayItem{ key: 'border-collapse', val: 'separate' },
			rt.ArrayItem{ key: 'text-align', val: 'left' },
		]))
		var_margin_wrapper_styles = iife_result_4
		mut var_wrapper_table_attrs := rt.create_array([
			rt.ArrayItem{ key: 'class', val: 'email-block-columns-wrapper' },
			rt.ArrayItem{
				key: 'style'
				val: var_margin_wrapper_styles.array_get(rt.new_string('css'))
			},
			rt.ArrayItem{ key: 'align', val: 'center' },
		])
		mut iife_temp_5 :=
			Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
		mut iife_result_5 := iife_temp_5.render_table_wrapper(var_columns_content.clone(),
			var_wrapper_table_attrs.clone())
		return iife_result_5.str()
	}
	return var_columns_content.str()
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_columns(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Columns {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Columns{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_abstract_block_renderer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper{
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

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Columns) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 {
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
		'getBlockWrapper' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.getblockwrapper(dispatch_arg_0, mut dispatch_arg_1, mut
				dispatch_arg_2))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Columns) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Columns) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
