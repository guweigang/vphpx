import rt

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Media_Text {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Media_Text) render_content(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_block_attrs := if !(var_parsed_block.array_get('attrs')).is_null() { var_parsed_block.array_get('attrs') } else { rt.new_array() }
	mut var_inner_blocks := if !(var_parsed_block.array_get('innerBlocks')).is_null() { var_parsed_block.array_get('innerBlocks') } else { rt.new_array() }
	mut var_media_content := rt.new_string(this.extract_media_from_html((if !(var_parsed_block.array_get('innerHTML')).is_null() { var_parsed_block.array_get('innerHTML') } else { rt.new_string(block_content) }).str()))
	mut var_text_content := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := var_inner_blocks.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block := item_1.val
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	if !rt.is_true(var_media_content) || !rt.is_true(var_text_content) {
		return ''
	}
	return this.build_email_layout((var_media_content).str(), (var_text_content).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_block_attrs), block_content, mut var_rendering_context)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Media_Text) extract_media_from_html(block_content string) string {
	mut var_matches := rt.new_null()
	mut var_media_content := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/<figure[^>]*class="[^"]*\\bwp-block-media-text__media\\b[^"]*"[^>]*>(.*?)<\\/figure>/s'), rt.new_string(block_content), var_matches.dup()])) {
		var_media_content = rt.new_string(rt.new_string(var_matches.array_get(1).to_string().trim_space()))
	}
	return (var_media_content).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Media_Text) build_email_layout(media_content string, text_content string, mut var_block_attrs Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, block_content string, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut media_content_mutated := media_content
	mut text_content_mutated := text_content
	mut var_block_attrs_mutated := var_block_attrs
	mut var_original_wrapper_classname := if !(rt.call_method(create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(rt.new_string(block_content).dup()), 'get_attribute_value_by_tag_name', [rt.new_string('div'), rt.new_string('class')])).is_null() { rt.call_method(create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(rt.new_string(block_content).dup()), 'get_attribute_value_by_tag_name', [rt.new_string('div'), rt.new_string('class')]) } else { rt.new_string('') }
	mut var_media_position := if !(var_block_attrs_mutated.array_get('mediaPosition')).is_null() { var_block_attrs_mutated.array_get('mediaPosition') } else { rt.new_string('left') }
	mut var_vertical_alignment := rt.new_string(this.get_vertical_alignment_from_attributes(mut var_block_attrs_mutated))
	mut var_media_width := rt.new_int(this.get_media_width_from_attributes(mut var_block_attrs_mutated))
	mut var_text_width := rt.sub(rt.new_int(100), var_media_width)
	if !(!rt.is_true(var_block_attrs_mutated.array_get('href'))) {
		media_content_mutated = this.wrap_media_with_link(media_content_mutated, (var_block_attrs_mutated.array_get('href')).str())
	}
	mut var_block_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.get_block_styles(arg_0, arg_1, arg_2) }(rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array', []string{}, var_block_attrs_mutated), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context', []string{}, var_rendering_context), rt.create_array([rt.ArrayItem{ key: none, val: 'padding' }, rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'background' }, rt.ArrayItem{ key: none, val: 'background-color' }, rt.ArrayItem{ key: none, val: 'color' }]))
	var_block_styles = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.extend_block_styles(arg_0, arg_1) }(var_block_styles.dup(), rt.create_array([rt.ArrayItem{ key: 'width', val: '100%' }, rt.ArrayItem{ key: 'border-collapse', val: 'collapse' }, rt.ArrayItem{ key: 'text-align', val: 'left' }]))
	mut var_table_attrs := rt.create_array([rt.ArrayItem{ key: 'class', val: 'email-block-media-text ' + (var_original_wrapper_classname).str() }, rt.ArrayItem{ key: 'style', val: var_block_styles.array_get('css') }, rt.ArrayItem{ key: 'align', val: 'left' }, rt.ArrayItem{ key: 'width', val: '100%' }])
	mut var_media_cell_attrs := rt.create_array([rt.ArrayItem{ key: 'style', val: rt.call_function('sprintf', [rt.new_string('width: %d%%; padding: 10px; vertical-align: %s;'), var_media_width.dup(), var_vertical_alignment.dup()]) }, rt.ArrayItem{ key: 'valign', val: var_vertical_alignment }])
	mut var_text_cell_attrs := rt.create_array([rt.ArrayItem{ key: 'style', val: rt.call_function('sprintf', [rt.new_string('width: %d%%; padding: 0 8%%; vertical-align: %s;'), var_text_width.dup(), var_vertical_alignment.dup()]) }, rt.ArrayItem{ key: 'valign', val: var_vertical_alignment }])
	mut var_media_cell := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}; return temp.render_table_cell(arg_0, arg_1) }(rt.new_string(media_content_mutated), var_media_cell_attrs.dup())
	mut var_text_cell := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}; return temp.render_table_cell(arg_0, arg_1) }(rt.new_string(text_content_mutated), var_text_cell_attrs.dup())
	if rt.is_true(rt.identical(rt.new_string('right'), var_media_position)) {
		mut var_cells := rt.new_string(rt.concat(var_text_cell, var_media_cell))
	} else {
		var_cells = rt.new_string(rt.concat(var_media_cell, var_text_cell))
	}
	return (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}; return temp.render_table_wrapper(arg_0, arg_1, arg_2, arg_3, arg_4) }(var_cells.dup(), var_table_attrs.dup(), rt.new_array(), rt.new_array(), rt.new_bool(false))).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Media_Text) get_vertical_alignment_from_attributes(mut var_block_attrs Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array) string {
	mut var_block_attrs_mutated := var_block_attrs
	mut var_vertical_alignment := if !(var_block_attrs_mutated.array_get('verticalAlignment')).is_null() { var_block_attrs_mutated.array_get('verticalAlignment') } else { rt.new_string('middle') }
	mut switch_val_1 := var_vertical_alignment
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('top'))) {
		return 'top'
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('center'))) {
		return 'middle'
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('bottom'))) {
		return 'bottom'
	} else {
		return 'middle'
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Media_Text) get_media_width_from_attributes(mut var_block_attrs Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array) i64 {
	mut var_block_attrs_mutated := var_block_attrs
	mut var_media_width := if !(var_block_attrs_mutated.array_get('mediaWidth')).is_null() { var_block_attrs_mutated.array_get('mediaWidth') } else { rt.new_int(50) }
	var_media_width = rt.call_function('max', [rt.new_int(1), rt.call_function('min', [rt.new_int(99), // unsupported expression: Expr_Cast_Int])])
	return (var_media_width).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Media_Text) wrap_media_with_link(media_content string, href string) string {
	mut media_content_mutated := media_content
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return media_content_mutated
	}
	return '<a href="' + (rt.call_function('esc_url', [rt.new_string(href)])).str() + '">' + media_content_mutated + '</a>'
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

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_media_text() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Media_Text {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Media_Text{
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

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Media_Text) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_string(this.render_content(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2))
		}
		'extract_media_from_html' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.extract_media_from_html(dispatch_arg_0))
		}
		'build_email_layout' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 4 { args[4] } else { rt.new_null() })
			return rt.new_string(this.build_email_layout(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3, mut dispatch_arg_4))
		}
		'get_vertical_alignment_from_attributes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_vertical_alignment_from_attributes(mut dispatch_arg_0))
		}
		'get_media_width_from_attributes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_int(this.get_media_width_from_attributes(mut dispatch_arg_0))
		}
		'wrap_media_with_link' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.wrap_media_with_link(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Media_Text) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Media_Text) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_integrations_core_renderer_blocks_class_media_text_php() {
	// unsupported statement: Stmt_Declare
}
