import rt

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Cover {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Cover) render_content(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_block_attrs := if !(var_parsed_block.array_get('attrs')).is_null() { var_parsed_block.array_get('attrs') } else { rt.new_array() }
	mut var_inner_blocks := if !(var_parsed_block.array_get('innerBlocks')).is_null() { var_parsed_block.array_get('innerBlocks') } else { rt.new_array() }
	mut var_inner_content := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := var_inner_blocks.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block := item_1.val
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	if !rt.is_true(var_inner_content) {
		return ''
	}
	mut var_background_image := rt.new_string(this.extract_background_image(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_block_attrs), (if !(var_parsed_block.array_get('innerHTML')).is_null() { var_parsed_block.array_get('innerHTML') } else { rt.new_string(block_content) }).str()))
	return this.build_email_layout((var_inner_content).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_block_attrs), block_content, (var_background_image).str(), mut var_rendering_context)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Cover) build_email_layout(inner_content string, mut var_block_attrs Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, block_content string, background_image string, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut inner_content_mutated := inner_content
	mut var_block_attrs_mutated := var_block_attrs
	mut background_image_mutated := background_image
	mut var_original_wrapper_classname := if !(rt.call_method(create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(rt.new_string(block_content).dup()), 'get_attribute_value_by_tag_name', [rt.new_string('div'), rt.new_string('class')])).is_null() { rt.call_method(create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(rt.new_string(block_content).dup()), 'get_attribute_value_by_tag_name', [rt.new_string('div'), rt.new_string('class')]) } else { rt.new_string('') }
	mut var_background_color := rt.new_string(this.get_background_color(mut var_block_attrs_mutated, mut var_rendering_context))
	mut var_block_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.get_block_styles(arg_0, arg_1, arg_2) }(rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array', []string{}, var_block_attrs_mutated), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context', []string{}, var_rendering_context), rt.create_array([rt.ArrayItem{ key: none, val: 'padding' }, rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'background-color' }]))
	mut var_default_styles := rt.create_array([rt.ArrayItem{ key: 'width', val: '100%' }, rt.ArrayItem{ key: 'border-collapse', val: 'collapse' }, rt.ArrayItem{ key: 'text-align', val: 'center' }])
	mut var_min_height := rt.new_string(this.get_minimum_height(mut var_block_attrs_mutated))
	var_default_styles.array_set('min-height', if !(!rt.is_true(var_min_height)) { var_min_height } else { rt.new_string('430px') })
	var_block_styles = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.extend_block_styles(arg_0, arg_1) }(var_block_styles.dup(), var_default_styles.dup())
	if !(background_image_mutated == '') {
		var_block_styles = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.extend_block_styles(arg_0, arg_1) }(var_block_styles.dup(), rt.create_array([rt.ArrayItem{ key: 'background-image', val: 'url("' + (rt.call_function('esc_url_raw', [rt.new_string(background_image_mutated).dup()])).str() + '")' }, rt.ArrayItem{ key: 'background-size', val: 'cover' }, rt.ArrayItem{ key: 'background-position', val: 'center' }, rt.ArrayItem{ key: 'background-repeat', val: 'no-repeat' }]))
	} else if !(!rt.is_true(var_background_color)) {
		var_block_styles = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.extend_block_styles(arg_0, arg_1) }(var_block_styles.dup(), rt.create_array([rt.ArrayItem{ key: 'background-color', val: var_background_color }]))
	}
	mut var_table_attrs := rt.create_array([rt.ArrayItem{ key: 'class', val: 'email-block-cover ' + (rt.call_function('esc_attr', [var_original_wrapper_classname.dup()])).str() }, rt.ArrayItem{ key: 'style', val: var_block_styles.array_get('css') }, rt.ArrayItem{ key: 'align', val: 'center' }, rt.ArrayItem{ key: 'width', val: '100%' }])
	mut var_cover_content := rt.new_string(this.build_cover_content(inner_content_mutated))
	mut var_cell_attrs := rt.create_array([rt.ArrayItem{ key: 'valign', val: 'middle' }, rt.ArrayItem{ key: 'align', val: 'center' }])
	mut var_cell := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}; return temp.render_table_cell(arg_0, arg_1) }(var_cover_content.dup(), var_cell_attrs.dup())
	return (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}; return temp.render_table_wrapper(arg_0, arg_1, arg_2, arg_3, arg_4) }(var_cell.dup(), var_table_attrs.dup(), rt.new_array(), rt.new_array(), rt.new_bool(false))).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Cover) extract_background_image(mut var_block_attrs Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, block_content string) string {
	mut var_block_attrs_mutated := var_block_attrs
	if !(!rt.is_true(var_block_attrs_mutated.array_get('url'))) {
		return (rt.call_function('esc_url_raw', [var_block_attrs_mutated.array_get('url')])).str()
	}
	mut var_html := create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_html_tag_processor(rt.new_string(block_content).dup())
	for rt.is_true(var_html.next_tag(rt.create_array([rt.ArrayItem{ key: 'tag_name', val: 'img' }]))) {
		mut var_class_attr := var_html.get_attribute(rt.new_string('class'))
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_class_attr.dup().is_string())) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			mut var_src := var_html.get_attribute(rt.new_string('src'))
			if rt.is_true(rt.new_bool(var_src.dup().is_string())) {
				return (rt.call_function('esc_url_raw', [var_src.dup()])).str()
			}
		}
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Cover) get_minimum_height(mut var_block_attrs Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array) string {
	mut var_block_attrs_mutated := var_block_attrs
	if !(!rt.is_true(var_block_attrs_mutated.array_get('minHeight'))) {
		return (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}; return temp.sanitize_dimension_value(arg_0) }(var_block_attrs_mutated.array_get('minHeight'))).str()
	}
	if !(!rt.is_true(var_block_attrs_mutated.array_get('style').array_get('dimensions').array_get('minHeight'))) {
		return (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}; return temp.sanitize_dimension_value(arg_0) }(var_block_attrs_mutated.array_get('style').array_get('dimensions').array_get('minHeight'))).str()
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Cover) get_background_color(mut var_block_attrs Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_block_attrs_mutated := var_block_attrs
	if !(!rt.is_true(var_block_attrs_mutated.array_get('customOverlayColor'))) {
		mut var_color := var_block_attrs_mutated.array_get('customOverlayColor')
		mut var_sanitized_color := rt.new_string(this.validate_and_sanitize_color((var_color).str()))
		if !(!rt.is_true(var_sanitized_color)) {
			return (var_sanitized_color).str()
		}
	}
	if !(!rt.is_true(var_block_attrs_mutated.array_get('overlayColor'))) {
		mut var_translated_color := var_rendering_context.translate_slug_to_color(var_block_attrs_mutated.array_get('overlayColor'))
		var_sanitized_color = rt.new_string(this.validate_and_sanitize_color((var_translated_color).str()))
		if !(!rt.is_true(var_sanitized_color)) {
			return (var_sanitized_color).str()
		}
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Cover) validate_and_sanitize_color(color string) string {
	mut color_mutated := color
	mut var_sanitized_color := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}; return temp.sanitize_color(arg_0) }(rt.new_string(color_mutated))
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('#000000'), var_sanitized_color)) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return ''
	}
	return (var_sanitized_color).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Cover) build_cover_content(inner_content string) string {
	mut inner_content_mutated := inner_content
	mut var_cover_style := rt.new_string(rt.new_string('position: relative; display: inline-block; width: 100%; max-width: 100%;'))
	mut var_inner_wrapper_style := rt.new_string(rt.new_string('padding: 20px;'))
	mut var_inner_wrapper_html := rt.call_function('sprintf', [rt.new_string('<div class="wp-block-cover__inner-container" style="%s">%s</div>'), var_inner_wrapper_style.dup(), rt.new_string(inner_content_mutated).dup()])
	return (rt.call_function('sprintf', [rt.new_string('<div class="wp-block-cover" style="%s">%s</div>'), var_cover_style.dup(), var_inner_wrapper_html.dup()])).str()
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

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_cover() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Cover {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Cover{
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

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_html_tag_processor() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_html_processing_helper() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Cover) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_string(this.render_content(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2))
		}
		'build_email_layout' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 4 { args[4] } else { rt.new_null() })
			return rt.new_string(this.build_email_layout(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, mut dispatch_arg_4))
		}
		'extract_background_image' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.extract_background_image(mut dispatch_arg_0, dispatch_arg_1))
		}
		'get_minimum_height' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_minimum_height(mut dispatch_arg_0))
		}
		'get_background_color' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(this.get_background_color(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'validate_and_sanitize_color' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.validate_and_sanitize_color(dispatch_arg_0))
		}
		'build_cover_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.build_cover_content(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Cover) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Cover) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_integrations_core_renderer_blocks_class_cover_php() {
	// unsupported statement: Stmt_Declare
}
