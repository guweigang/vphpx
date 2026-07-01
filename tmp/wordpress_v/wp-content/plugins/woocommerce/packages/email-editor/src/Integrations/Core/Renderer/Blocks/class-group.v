import rt

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Group {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Group) render_content(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	return (rt.call_function('str_replace', [rt.new_string('{group_content}'),
		this.get_inner_content(rt.new_string(block_content)),
		this.get_block_wrapper(block_content, mut var_parsed_block, mut var_rendering_context)])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Group) get_block_wrapper(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_original_classname := if !(rt.call_method(create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(rt.new_string(block_content).dup()), 'get_attribute_value_by_tag_name', [
		rt.new_string('div'),
		rt.new_string('class'),
	])).is_null() { rt.call_method(create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(rt.new_string(block_content).dup()), 'get_attribute_value_by_tag_name', [
			rt.new_string('div'),
			rt.new_string('class'),
		]) } else { rt.new_string('') }
	mut var_block_attributes := rt.call_function('wp_parse_args', [if !(var_parsed_block.array_get('attrs')).is_null() {
		var_parsed_block.array_get('attrs')
	} else {
		rt.new_array()
	},
		rt.create_array([rt.ArrayItem{ key: 'style', val: rt.new_array() },
			rt.ArrayItem{ key: 'backgroundColor', val: '' }, rt.ArrayItem{ key: 'textColor', val: '' },
			rt.ArrayItem{ key: 'borderColor', val: '' }, rt.ArrayItem{
				key: 'layout'
				val: rt.new_array()
			}])])
	mut var_table_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
		return temp.get_block_styles(arg_0, arg_1, arg_2)
	}(var_block_attributes.dup(), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context',
		[]string{}, var_rendering_context), rt.create_array([
		rt.ArrayItem{ key: none, val: 'border' },
		rt.ArrayItem{ key: none, val: 'background' },
		rt.ArrayItem{ key: none, val: 'background-color' },
		rt.ArrayItem{ key: none, val: 'color' },
		rt.ArrayItem{ key: none, val: 'text-align' },
	]))
	var_table_styles = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
		return temp.extend_block_styles(arg_0, arg_1)
	}(var_table_styles.dup(), rt.call_function('array_filter', [
		rt.create_array([rt.ArrayItem{ key: 'border-collapse', val: 'separate' },
			rt.ArrayItem{
				key: 'background-size'
				val: if !(var_table_styles.array_get('background-size')).is_null() {
					var_table_styles.array_get('background-size')
				} else {
					rt.new_string('cover')
				}
			}]),
	]))
	mut var_cell_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
		return temp.get_block_styles(arg_0, arg_1, arg_2)
	}(var_block_attributes.dup(), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context',
		[]string{}, var_rendering_context), rt.create_array([
		rt.ArrayItem{ key: none, val: 'padding' },
	]))
	if !(!rt.is_true(var_parsed_block.array_get('email_attrs').array_get('suppress-horizontal-padding'))) {
		var_cell_styles =
			this.remove_horizontal_padding(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_cell_styles))
	}
	mut var_table_attrs := rt.create_array([
		rt.ArrayItem{ key: 'class', val: 'email-block-group ' + var_original_classname.str() },
		rt.ArrayItem{ key: 'style', val: var_table_styles.array_get('css') },
		rt.ArrayItem{ key: 'width', val: '100%' },
	])
	mut var_cell_attrs := rt.create_array([
		rt.ArrayItem{ key: 'class', val: 'email-block-group-content' },
		rt.ArrayItem{ key: 'style', val: var_cell_styles.array_get('css') },
		rt.ArrayItem{
			key: 'width'
			val: if !(var_parsed_block.array_get('email_attrs').array_get('width')).is_null() {
				var_parsed_block.array_get('email_attrs').array_get('width')
			} else {
				rt.new_string('100%')
			}
		},
	])
	return (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp :=
			Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
		return temp.render_table_wrapper(arg_0, arg_1, arg_2)
	}(rt.new_string('{group_content}'), var_table_attrs.dup(), var_cell_attrs.dup())).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Group) remove_horizontal_padding(mut var_cell_styles Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array) rt.PhpVal {
	mut var_cell_styles_mutated := var_cell_styles
	if rt.is_true(rt.new_bool(!(var_cell_styles_mutated.array_isset(rt.new_string('declarations')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_cell_styles_mutated.array_get('declarations').is_array())))))))
	{
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array',
			[]string{}, var_cell_styles_mutated)
	}
	var_cell_styles_mutated.array_get('declarations').array_unset(rt.new_string('padding-left'))
	var_cell_styles_mutated.array_get('declarations').array_unset(rt.new_string('padding-right'))
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
		return temp.extend_block_styles(arg_0, arg_1)
	}(rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array',
		[]string{}, var_cell_styles_mutated), rt.new_array())
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

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_group() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Group {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Group{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_abstract_block_renderer() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper{
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

fn create_automattic_woocommerce_emaileditor_integrations_utils_table_wrapper_helper() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Group) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'remove_horizontal_padding' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.remove_horizontal_padding(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Group) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Group) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_integrations_core_renderer_blocks_class_group_php() {
	// unsupported statement: Stmt_Declare
}
