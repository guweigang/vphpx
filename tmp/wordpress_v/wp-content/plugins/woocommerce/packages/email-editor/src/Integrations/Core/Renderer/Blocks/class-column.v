import rt

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Column {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Column) add_spacer(var_content rt.PhpVal, var_email_attrs rt.PhpVal) string {
	return (var_content).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Column) render_content(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	return (rt.call_function('str_replace', [rt.new_string('{column_content}'), this.get_inner_content(rt.new_string(block_content)), this.get_block_wrapper(block_content, mut var_parsed_block, mut var_rendering_context)])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Column) get_block_wrapper(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_original_wrapper_classname := if !(rt.call_method(create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(rt.new_string(block_content).dup()), 'get_attribute_value_by_tag_name', [rt.new_string('div'), rt.new_string('class')])).is_null() { rt.call_method(create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(rt.new_string(block_content).dup()), 'get_attribute_value_by_tag_name', [rt.new_string('div'), rt.new_string('class')]) } else { rt.new_string('') }
	mut var_block_attributes := rt.call_function('wp_parse_args', [if !(var_parsed_block.array_get('attrs')).is_null() { var_parsed_block.array_get('attrs') } else { rt.new_array() }, rt.create_array([rt.ArrayItem{ key: 'verticalAlignment', val: 'stretch' }, rt.ArrayItem{ key: 'width', val: var_rendering_context.get_layout_width_without_padding() }, rt.ArrayItem{ key: 'style', val: rt.new_array() }])])
	mut var_is_stretched := rt.new_bool(rt.new_bool(!rt.is_true(var_block_attributes.array_get('verticalAlignment')) || rt.is_true(rt.identical(rt.new_string('stretch'), var_block_attributes.array_get('verticalAlignment')))))
	mut var_padding_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.get_block_styles(arg_0, arg_1, arg_2) }(var_block_attributes.dup(), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context', []string{}, var_rendering_context), rt.create_array([rt.ArrayItem{ key: none, val: 'padding' }]))
	var_padding_styles = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.extend_block_styles(arg_0, arg_1) }(var_padding_styles.dup(), rt.create_array([rt.ArrayItem{ key: 'text-align', val: 'left' }]))
	mut var_cell_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.get_block_styles(arg_0, arg_1, arg_2) }(var_block_attributes.dup(), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context', []string{}, var_rendering_context), rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'background' }, rt.ArrayItem{ key: none, val: 'background-color' }, rt.ArrayItem{ key: none, val: 'color' }]))
	var_cell_styles = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.extend_block_styles(arg_0, arg_1) }(var_cell_styles.dup(), rt.call_function('array_filter', [rt.create_array([rt.ArrayItem{ key: 'background-size', val: if !(!rt.is_true(var_cell_styles.array_get('background-image'))) && !rt.is_true(var_cell_styles.array_get('background-size')) { rt.new_string('cover') } else { rt.new_null() } }])]))
	mut var_wrapper_classname := rt.new_string(rt.new_string('block wp-block-column email-block-column'))
	mut var_content_classname := rt.new_string(rt.new_string('email-block-column-content'))
	mut var_wrapper_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.extend_block_styles(arg_0, arg_1) }(// unsupported expression: Expr_StaticPropertyFetch, rt.create_array([rt.ArrayItem{ key: 'vertical-align', val: if rt.is_true(var_is_stretched) { rt.new_string('top') } else { var_block_attributes.array_get('verticalAlignment') } }]))
	mut var_content_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.extend_block_styles(arg_0, arg_1) }(// unsupported expression: Expr_StaticPropertyFetch, rt.create_array([rt.ArrayItem{ key: 'vertical-align', val: 'top' }]))
	if rt.is_true(var_is_stretched) {
		// unsupported expression: Expr_AssignOp_Concat
		var_wrapper_styles = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.extend_block_styles(arg_0, arg_1) }(var_wrapper_styles.dup(), var_cell_styles.array_get('declarations'))
	} else {
		// unsupported expression: Expr_AssignOp_Concat
		var_content_styles = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.extend_block_styles(arg_0, arg_1) }(var_content_styles.dup(), var_cell_styles.array_get('declarations'))
	}
	mut var_inner_table_attrs := rt.create_array([rt.ArrayItem{ key: 'class', val: var_content_classname }, rt.ArrayItem{ key: 'style', val: var_content_styles.array_get('css') }, rt.ArrayItem{ key: 'width', val: '100%' }])
	mut var_inner_cell_attrs := rt.create_array([rt.ArrayItem{ key: 'align', val: 'left' }, rt.ArrayItem{ key: 'style', val: var_padding_styles.array_get('css') }])
	mut var_inner_table := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}; return temp.render_table_wrapper(arg_0, arg_1, arg_2) }(rt.new_string('{column_content}'), var_inner_table_attrs.dup(), var_inner_cell_attrs.dup())
	mut var_padding_left := if !(var_parsed_block.array_get('email_attrs').array_get('padding-left')).is_null() { var_parsed_block.array_get('email_attrs').array_get('padding-left') } else { rt.new_null() }
	if rt.is_true(var_padding_left) {
		mut var_gap_padding_styles := rt.call_function('wp_style_engine_get_styles', [rt.create_array([rt.ArrayItem{ key: 'spacing', val: rt.create_array([rt.ArrayItem{ key: 'padding', val: rt.create_array([rt.ArrayItem{ key: 'left', val: var_padding_left }]) }]) }])])
		var_wrapper_styles = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.extend_block_styles(arg_0, arg_1) }(var_wrapper_styles.dup(), if !(var_gap_padding_styles.array_get('declarations')).is_null() { var_gap_padding_styles.array_get('declarations') } else { rt.new_array() })
	}
	mut var_wrapper_cell_attrs := rt.create_array([rt.ArrayItem{ key: 'class', val: var_wrapper_classname }, rt.ArrayItem{ key: 'style', val: var_wrapper_styles.array_get('css') }, rt.ArrayItem{ key: 'width', val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.parse_value(arg_0) }(var_block_attributes.array_get('width')) }])
	return (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}; return temp.render_table_cell(arg_0, arg_1) }(var_inner_table.dup(), var_wrapper_cell_attrs.dup())).str()
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

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_column() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Column {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Column{
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

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Column) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'add_spacer' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.add_spacer(dispatch_arg_0, dispatch_arg_1))
		}
		'render_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_string(this.render_content(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2))
		}
		'get_block_wrapper' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_string(this.get_block_wrapper(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2))
		}
		else { return none }
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




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_integrations_core_renderer_blocks_class_column_php() {
	// unsupported statement: Stmt_Declare
}
