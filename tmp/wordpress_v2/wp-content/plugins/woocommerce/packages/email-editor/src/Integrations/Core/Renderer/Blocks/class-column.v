import rt

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Column {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Column) add_spacer(var_content rt.PhpVal, var_email_attrs rt.PhpVal) string {
	return var_content.str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Column) render_content(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	return (rt.call_function('str_replace', [rt.new_string('{column_content}'),
		this.get_inner_content(rt.new_string(block_content)),
		rt.new_string(this.get_block_wrapper(block_content, mut var_parsed_block, mut
			var_rendering_context))])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Column) get_block_wrapper(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
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
		rt.create_array([rt.ArrayItem{ key: 'verticalAlignment', val: 'stretch' },
			rt.ArrayItem{
				key: 'width'
				val: var_rendering_context.get_layout_width_without_padding()
			}, rt.ArrayItem{ key: 'style', val: rt.new_array() }])])
	mut var_is_stretched := rt.new_bool(
		!rt.is_true(var_block_attributes.array_get(rt.new_string('verticalAlignment')))
		|| rt.is_true(rt.identical(rt.new_string('stretch'), var_block_attributes.array_get(rt.new_string('verticalAlignment')))))
	mut iife_temp_0 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
	mut iife_result_0 := iife_temp_0.get_block_styles(var_block_attributes.clone(), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context',
		[]string{}, var_rendering_context), rt.create_array([
		rt.ArrayItem{ key: none, val: 'padding' },
	]))
	mut var_padding_styles := iife_result_0
	mut iife_temp_1 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
	mut iife_result_1 := iife_temp_1.extend_block_styles(var_padding_styles.clone(), rt.create_array([
		rt.ArrayItem{ key: 'text-align', val: 'left' },
	]))
	var_padding_styles = iife_result_1
	mut iife_temp_2 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
	mut iife_result_2 := iife_temp_2.get_block_styles(var_block_attributes.clone(), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context',
		[]string{}, var_rendering_context), rt.create_array([
		rt.ArrayItem{ key: none, val: 'border' },
		rt.ArrayItem{ key: none, val: 'background' },
		rt.ArrayItem{ key: none, val: 'background-color' },
		rt.ArrayItem{ key: none, val: 'color' },
	]))
	mut var_cell_styles := iife_result_2
	mut iife_temp_3 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
	mut iife_result_3 := iife_temp_3.extend_block_styles(var_cell_styles.clone(), rt.call_function('array_filter', [
		rt.create_array([
			rt.ArrayItem{
				key: 'background-size'
				val: if
					!(!rt.is_true(var_cell_styles.array_get(rt.new_string('background-image'))))
					&& !rt.is_true(var_cell_styles.array_get(rt.new_string('background-size'))) {
					rt.new_string('cover')
				} else {
					rt.new_null()
				}
			},
		]),
	]))
	var_cell_styles = iife_result_3
	mut var_wrapper_classname := rt.new_string('block wp-block-column email-block-column')
	mut var_content_classname := rt.new_string('email-block-column-content')
	mut iife_temp_4 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
	mut iife_result_4 := iife_temp_4.extend_block_styles(rt.get_static_prop('Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper',
		'empty_block_styles'), rt.create_array([
		rt.ArrayItem{
			key: 'vertical-align'
			val: if rt.is_true(var_is_stretched) {
				rt.new_string('top')
			} else {
				var_block_attributes.array_get(rt.new_string('verticalAlignment'))
			}
		},
	]))
	mut var_wrapper_styles := iife_result_4
	mut iife_temp_5 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
	mut iife_result_5 := iife_temp_5.extend_block_styles(rt.get_static_prop('Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper',
		'empty_block_styles'), rt.create_array([
		rt.ArrayItem{ key: 'vertical-align', val: 'top' },
	]))
	mut var_content_styles := iife_result_5
	if rt.is_true(var_is_stretched) {
		var_wrapper_classname = rt.concat(var_wrapper_classname, rt.new_string(' ' +
			var_original_wrapper_classname.str()))
		mut iife_temp_6 :=
			Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
		mut iife_result_6 := iife_temp_6.extend_block_styles(var_wrapper_styles.clone(),
			var_cell_styles.array_get(rt.new_string('declarations')))
		var_wrapper_styles = iife_result_6
	} else {
		var_content_classname = rt.concat(var_content_classname, rt.new_string(' ' +
			var_original_wrapper_classname.str()))
		mut iife_temp_7 :=
			Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
		mut iife_result_7 := iife_temp_7.extend_block_styles(var_content_styles.clone(),
			var_cell_styles.array_get(rt.new_string('declarations')))
		var_content_styles = iife_result_7
	}
	mut var_inner_table_attrs := rt.create_array([
		rt.ArrayItem{ key: 'class', val: var_content_classname },
		rt.ArrayItem{ key: 'style', val: var_content_styles.array_get(rt.new_string('css')) },
		rt.ArrayItem{ key: 'width', val: '100%' },
	])
	mut var_inner_cell_attrs := rt.create_array([
		rt.ArrayItem{ key: 'align', val: 'left' },
		rt.ArrayItem{ key: 'style', val: var_padding_styles.array_get(rt.new_string('css')) },
	])
	mut iife_temp_8 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
	mut iife_result_8 := iife_temp_8.render_table_wrapper(rt.new_string('{column_content}'),
		var_inner_table_attrs.clone(), var_inner_cell_attrs.clone())
	mut var_inner_table := iife_result_8
	mut var_padding_left := if !(var_parsed_block.array_get(rt.new_string('email_attrs')).array_get(rt.new_string('padding-left'))).is_null() {
		var_parsed_block.array_get(rt.new_string('email_attrs')).array_get(rt.new_string('padding-left'))
	} else {
		rt.new_null()
	}
	if rt.is_true(var_padding_left) {
		mut var_gap_padding_styles := rt.call_function('wp_style_engine_get_styles', [
			rt.create_array([
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: rt.create_array([
						rt.ArrayItem{ key: 'left', val: var_padding_left },
					]) },
				]) },
			]),
		])
		mut iife_temp_9 :=
			Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
		mut iife_result_9 := iife_temp_9.extend_block_styles(var_wrapper_styles.clone(), if !(var_gap_padding_styles.array_get(rt.new_string('declarations'))).is_null() {
			var_gap_padding_styles.array_get(rt.new_string('declarations'))
		} else {
			rt.new_array()
		})
		var_wrapper_styles = iife_result_9
	}
	mut iife_temp_10 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
	mut iife_result_10 :=
		iife_temp_10.parse_value(var_block_attributes.array_get(rt.new_string('width')))
	mut var_wrapper_cell_attrs := rt.create_array([
		rt.ArrayItem{ key: 'class', val: var_wrapper_classname },
		rt.ArrayItem{ key: 'style', val: var_wrapper_styles.array_get(rt.new_string('css')) },
		rt.ArrayItem{ key: 'width', val: iife_result_10 },
	])
	mut iife_temp_11 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
	mut iife_result_11 := iife_temp_11.render_table_cell(var_inner_table.clone(),
		var_wrapper_cell_attrs.clone())
	return iife_result_11.str()
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

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_column(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Column {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Column{
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

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Column) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'add_spacer' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.add_spacer(dispatch_arg_0, dispatch_arg_1))
		}
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
		'get_block_wrapper' {
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
			return rt.new_string(this.get_block_wrapper(dispatch_arg_0, mut dispatch_arg_1, mut
				dispatch_arg_2))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Column) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Column) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
