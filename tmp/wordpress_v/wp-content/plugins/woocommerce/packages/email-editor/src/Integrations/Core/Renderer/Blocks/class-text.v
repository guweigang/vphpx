import rt

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Text {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Text) render_content(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut block_content_mutated := block_content
	if rt.call_function('wp_strip_all_tags', [rt.new_string(block_content_mutated).dup()]).to_string().trim_space() == '' {
		return ''
	}
	block_content_mutated = this.adjuststyleattribute(block_content_mutated)
	mut var_block_attributes := rt.call_function('wp_parse_args', [if !(var_parsed_block.array_get('attrs')).is_null() { var_parsed_block.array_get('attrs') } else { rt.new_array() }, rt.create_array([rt.ArrayItem{ key: 'textAlign', val: 'left' }, rt.ArrayItem{ key: 'style', val: rt.new_array() }])])
	mut var_html := create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_html_tag_processor(rt.new_string(block_content_mutated).dup())
	mut var_classes := rt.new_string(rt.new_string('email-text-block'))
	mut var_alignment_from_class := rt.new_null()
	if rt.is_true(var_html.next_tag()) {
		mut var_block_classes := if !(var_html.get_attribute(rt.new_string('class'))).is_null() { var_html.get_attribute(rt.new_string('class')) } else { rt.new_string('') }
		// unsupported expression: Expr_AssignOp_Concat
		mut var_class_attr := // unsupported expression: Expr_Cast_String
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_alignment_from_class = rt.new_string(rt.new_string('center'))
		} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_alignment_from_class = rt.new_string(rt.new_string('right'))
		} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_alignment_from_class = rt.new_string(rt.new_string('left'))
		}
		var_block_classes = rt.call_function('str_replace', [rt.new_string('has-background'), rt.new_string(''), var_block_classes.dup()])
		var_block_classes = rt.call_function('preg_replace', [rt.new_string('/[a-z-]+-border-[a-z-]+/'), rt.new_string(''), var_block_classes.dup()])
		var_html.set_attribute(rt.new_string('class'), rt.new_string(var_block_classes.dup().to_string().trim_space()))
		block_content_mutated = (var_html.get_updated_html()).str()
	}
	mut var_block_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.get_block_styles(arg_0, arg_1, arg_2) }(var_block_attributes.dup(), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context', []string{}, var_rendering_context), rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'background-color' }, rt.ArrayItem{ key: none, val: 'color' }, rt.ArrayItem{ key: none, val: 'typography' }]))
	mut var_additional_styles := rt.create_array([rt.ArrayItem{ key: 'min-width', val: '100%' }])
	if !rt.is_true(var_block_styles.array_get('declarations').array_get('color')) {
		mut var_email_styles := var_rendering_context.get_theme_styles()
		var_additional_styles.array_set('color', if !(var_parsed_block.array_get('email_attrs').array_get('color')).is_null() { var_parsed_block.array_get('email_attrs').array_get('color') } else { if !(var_email_styles.array_get('color').array_get('text')).is_null() { var_email_styles.array_get('color').array_get('text') } else { rt.new_string('#000000') } })
		// unsupported statement: Stmt_Nop
	}
	var_additional_styles.array_set('text-align', 'left')
	if !(!rt.is_true(var_parsed_block.array_get('attrs').array_get('textAlign'))) {
		var_additional_styles.array_set('text-align', var_parsed_block.array_get('attrs').array_get('textAlign'))
	} else if rt.is_true(rt.call_function('in_array', [if !(var_parsed_block.array_get('attrs').array_get('align')).is_null() { var_parsed_block.array_get('attrs').array_get('align') } else { rt.new_null() }, rt.create_array([rt.ArrayItem{ key: none, val: 'left' }, rt.ArrayItem{ key: none, val: 'center' }, rt.ArrayItem{ key: none, val: 'right' }]), rt.new_bool(true)])) {
		var_additional_styles.array_set('text-align', var_parsed_block.array_get('attrs').array_get('align'))
	} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_additional_styles.array_set('text-align', var_alignment_from_class.dup())
	}
	var_block_styles = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.extend_block_styles(arg_0, arg_1) }(var_block_styles.dup(), var_additional_styles.dup())
	mut var_table_attrs := rt.create_array([rt.ArrayItem{ key: 'style', val: 'border-collapse: separate;' }, rt.ArrayItem{ key: 'width', val: '100%' }])
	mut var_cell_attrs := rt.create_array([rt.ArrayItem{ key: 'class', val: var_classes }, rt.ArrayItem{ key: 'style', val: var_block_styles.array_get('css') }, rt.ArrayItem{ key: 'align', val: var_additional_styles.array_get('text-align') }])
	return (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}; return temp.render_table_wrapper(arg_0, arg_1, arg_2) }(rt.new_string(block_content_mutated), var_table_attrs.dup(), var_cell_attrs.dup())).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Text) adjuststyleattribute(block_content string) string {
	mut block_content_mutated := block_content
	mut var_html := create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_html_tag_processor(rt.new_string(block_content_mutated).dup())
	if rt.is_true(var_html.next_tag()) {
		mut var_element_style_value := var_html.get_attribute(rt.new_string('style'))
		mut var_element_style := rt.new_string(if !(var_element_style_value).is_null() { rt.new_string(var_element_style_value.dup().to_string()) } else { rt.new_string('') })
		var_element_style = // unsupported expression: Expr_Cast_String
		var_element_style = // unsupported expression: Expr_Cast_String
		var_element_style = // unsupported expression: Expr_Cast_String
		var_element_style = // unsupported expression: Expr_Cast_String
		var_html.set_attribute(rt.new_string('style'), rt.call_function('esc_attr', [var_element_style.dup()]))
		block_content_mutated = (var_html.get_updated_html()).str()
	}
	return block_content_mutated
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_text() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Text {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Text{
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

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_html_tag_processor() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor{
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

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Text) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_string(this.render_content(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2))
		}
		'adjustStyleAttribute' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.adjuststyleattribute(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Text) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Text) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_integrations_core_renderer_blocks_class_text_php() {
	// unsupported statement: Stmt_Declare
}
