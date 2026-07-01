import rt

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Button {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Button) get_wrapper_styles(mut var_block_attributes Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) rt.PhpVal {
	mut var_block_attributes_mutated := var_block_attributes
	mut var_block_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
		return temp.get_block_styles(arg_0, arg_1, arg_2)
	}(rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array',
		[]string{}, var_block_attributes_mutated), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context',
		[]string{}, var_rendering_context), rt.create_array([
		rt.ArrayItem{ key: none, val: 'border' },
		rt.ArrayItem{ key: none, val: 'background-color' },
		rt.ArrayItem{ key: none, val: 'color' },
		rt.ArrayItem{ key: none, val: 'typography' },
		rt.ArrayItem{ key: none, val: 'spacing' },
	]))
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
		return temp.extend_block_styles(arg_0, arg_1)
	}(var_block_styles.dup(), rt.create_array([
		rt.ArrayItem{ key: 'word-break', val: 'break-word' },
		rt.ArrayItem{ key: 'display', val: 'block' },
	]))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Button) get_link_styles(mut var_block_attributes Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) rt.PhpVal {
	mut var_block_attributes_mutated := var_block_attributes
	mut var_block_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
		return temp.get_block_styles(arg_0, arg_1, arg_2)
	}(rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array',
		[]string{}, var_block_attributes_mutated), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context',
		[]string{}, var_rendering_context), rt.create_array([
		rt.ArrayItem{ key: none, val: 'color' },
		rt.ArrayItem{ key: none, val: 'typography' },
	]))
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
		return temp.extend_block_styles(arg_0, arg_1)
	}(var_block_styles.dup(), rt.create_array([
		rt.ArrayItem{ key: 'display', val: 'block' },
	]))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Button) render(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	return this.render_content(block_content, mut var_parsed_block, mut var_rendering_context)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Button) render_content(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	if !rt.is_true(var_parsed_block.array_get('innerHTML')) {
		return ''
	}
	mut var_dom_helper :=
		create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(var_parsed_block.array_get('innerHTML'))
	mut var_block_classname := if !(var_dom_helper.get_attribute_value_by_tag_name(rt.new_string('div'),
		rt.new_string('class'))).is_null() {
		var_dom_helper.get_attribute_value_by_tag_name(rt.new_string('div'), rt.new_string('class'))
	} else {
		rt.new_string('')
	}
	mut var_button_link := var_dom_helper.find_element(rt.new_string('a'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_button_link)))) {
		return ''
	}
	mut var_button_text := if rt.is_true(var_dom_helper.get_element_inner_html(var_button_link.dup())) {
		var_dom_helper.get_element_inner_html(var_button_link.dup())
	} else {
		rt.new_string('')
	}
	mut var_button_url := if rt.is_true(rt.call_method(var_button_link, 'getAttribute', [
		rt.new_string('href'),
	]))
	{
		rt.call_method(var_button_link, 'getAttribute', [rt.new_string('href')])
	} else {
		rt.new_string('#')
	}
	mut var_data_link_href := rt.call_method(var_button_link, 'getAttribute', [
		rt.new_string('data-link-href'),
	])
	mut var_block_attributes := rt.call_function('wp_parse_args', [if !(var_parsed_block.array_get('attrs')).is_null() {
		var_parsed_block.array_get('attrs')
	} else {
		rt.new_array()
	},
		rt.create_array([rt.ArrayItem{ key: 'width', val: '' },
			rt.ArrayItem{ key: 'style', val: rt.new_array() },
			rt.ArrayItem{ key: 'textAlign', val: 'center' }, rt.ArrayItem{
				key: 'backgroundColor'
				val: ''
			}, rt.ArrayItem{ key: 'textColor', val: '' }])])
	mut var_wrapper_styles := this.get_wrapper_styles(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_block_attributes), mut
		var_rendering_context)
	mut var_link_styles := this.get_link_styles(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_block_attributes), mut
		var_rendering_context)
	mut var_table_attrs := rt.create_array([
		rt.ArrayItem{ key: 'style', val: 'width:' +
			if rt.is_true(var_block_attributes.array_get('width')) { '100%' } else { 'auto' } + ';' },
	])
	mut var_cell_attrs := rt.create_array([
		rt.ArrayItem{ key: 'class', val:
			(var_wrapper_styles.array_get('classnames')).str() + ' ' + var_block_classname.str() },
		rt.ArrayItem{ key: 'style', val: var_wrapper_styles.array_get('css') },
		rt.ArrayItem{ key: 'align', val: var_block_attributes.array_get('textAlign') },
		rt.ArrayItem{ key: 'valign', val: 'middle' },
		rt.ArrayItem{ key: 'role', val: 'presentation' },
	])
	mut var_data_link_attr := if rt.is_true(var_data_link_href) { rt.call_function('sprintf', [
			rt.new_string(' data-link-href="%s"'),
			rt.call_function('esc_attr', [var_data_link_href.dup()]),
		]) } else { rt.new_string('') }
	mut var_button_content := rt.call_function('sprintf', [
		rt.new_string('<a class="button-link %1$s" style="%2$s" href="%3$s"%4$s target="_blank">%5$s</a>'),
		rt.call_function('esc_attr', [var_link_styles.array_get('classnames')]),
		rt.call_function('esc_attr', [var_link_styles.array_get('css')]),
		rt.call_function('esc_url', [var_button_url.dup()]),
		var_data_link_attr.dup(),
		var_button_text.dup(),
	])
	return (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp :=
			Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
		return temp.render_table_wrapper(arg_0, arg_1, arg_2)
	}(var_button_content.dup(), var_table_attrs.dup(), var_cell_attrs.dup())).str()
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_button() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Button {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Button{
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

fn create_automattic_woocommerce_emaileditor_integrations_utils_styles_helper() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{
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

fn create_automattic_woocommerce_emaileditor_integrations_utils_table_wrapper_helper() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Button) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_wrapper_styles' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 0 {
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
		'get_link_styles' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.get_link_styles(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'render' {
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
			return rt.new_string(this.render(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2))
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
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Button) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Button) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_integrations_core_renderer_blocks_class_button_php() {
	// unsupported statement: Stmt_Declare
}
