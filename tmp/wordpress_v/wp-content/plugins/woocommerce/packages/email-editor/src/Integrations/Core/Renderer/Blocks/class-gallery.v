import rt

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Gallery {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Gallery) render_content(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_gallery_images := this.extract_images_from_gallery_content(block_content, mut var_parsed_block)
	if !rt.is_true(var_gallery_images) {
		return ''
	}
	return this.build_email_layout(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_gallery_images), mut var_parsed_block, block_content, mut var_rendering_context)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Gallery) extract_images_from_gallery_content(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array) rt.PhpVal {
	mut var_gallery_images := rt.new_array()
	mut var_inner_blocks := if !(var_parsed_block.array_get('innerBlocks')).is_null() { var_parsed_block.array_get('innerBlocks') } else { rt.new_array() }
	{
		mut iter_1 := var_inner_blocks.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('core/image'), var_block.array_get('blockName'))) && var_block.array_isset(rt.new_string('innerHTML')))) {
				mut var_extracted_image := rt.new_string(this.extract_image_from_html((var_block.array_get('innerHTML')).str()))
				if !(!rt.is_true(var_extracted_image)) {
					var_gallery_images.array_push(var_extracted_image.dup())
				}
			}
		}
	}
	return var_gallery_images.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Gallery) extract_image_from_html(html_content string) string {
	mut var_link_matches := rt.new_null()
	mut var_img_matches := rt.new_null()
	mut var_caption_matches := rt.new_null()
	mut var_result := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/<a[^>]*href=(["\'])(.*?)\\1[^>]*>(\\s*<img[^>]*>)\\s*<\\/a>/s'), rt.new_string(html_content), var_link_matches.dup()])) {
		mut var_sanitized_url := rt.call_function('esc_url', [var_link_matches.array_get(2)])
		if !(!rt.is_true(var_sanitized_url)) {
			mut var_sanitized_img := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}; return temp.sanitize_image_html(arg_0) }(var_link_matches.array_get(3))
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				// unsupported expression: Expr_AssignOp_Concat
			}
		} else {
			var_sanitized_img = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}; return temp.sanitize_image_html(arg_0) }(var_link_matches.array_get(3))
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
	} else if rt.is_true(rt.call_function('preg_match', [rt.new_string('/<img[^>]*>/'), rt.new_string(html_content), var_img_matches.dup()])) {
		var_sanitized_img = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}; return temp.sanitize_image_html(arg_0) }(var_img_matches.array_get(0))
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/(<figcaption[^>]*>)(.*?)(<\\/figcaption>)/s'), rt.new_string(html_content), var_caption_matches.dup()])) {
		if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}; return temp.validate_container_attributes(arg_0) }(rt.new_string((var_caption_matches.array_get(1)).str() + (var_caption_matches.array_get(3)).str()))) {
			mut var_sanitized_caption := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}; return temp.sanitize_caption_html(arg_0) }(var_caption_matches.array_get(2))
			// unsupported expression: Expr_AssignOp_Concat
		}
	} else if rt.is_true(rt.call_function('preg_match', [rt.new_string('/(<span class="wp-element-caption"[^>]*>)(.*?)(<\\/span>)/s'), rt.new_string(html_content), var_caption_matches.dup()])) {
		if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}; return temp.validate_container_attributes(arg_0) }(rt.new_string((var_caption_matches.array_get(1)).str() + (var_caption_matches.array_get(3)).str()))) {
			var_sanitized_caption = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}; return temp.sanitize_caption_html(arg_0) }(var_caption_matches.array_get(2))
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	return (var_result).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Gallery) extract_gallery_caption(block_content string) string {
	mut var_matches := rt.new_null()
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/(<figcaption class="blocks-gallery-caption[^"]*"[^>]*>)(.*?)(<\\/figcaption>)/s'), rt.new_string(block_content), var_matches.dup()])) {
		if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}; return temp.validate_container_attributes(arg_0) }(rt.new_string((var_matches.array_get(1)).str() + (var_matches.array_get(3)).str()))) {
			return (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}; return temp.sanitize_caption_html(arg_0) }(rt.new_string(var_matches.array_get(2).to_string().trim_space()))).str()
		}
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Gallery) build_email_layout(mut var_gallery_images Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, block_content string, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_gallery_images_mutated := var_gallery_images
	mut var_original_wrapper_classname := if !(rt.call_method(create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(rt.new_string(block_content).dup()), 'get_attribute_value_by_tag_name', [rt.new_string('figure'), rt.new_string('class')])).is_null() { rt.call_method(create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(rt.new_string(block_content).dup()), 'get_attribute_value_by_tag_name', [rt.new_string('figure'), rt.new_string('class')]) } else { rt.new_string('') }
	mut var_block_attrs := if !(var_parsed_block.array_get('attrs')).is_null() { var_parsed_block.array_get('attrs') } else { rt.new_array() }
	mut var_columns := rt.new_int(this.get_columns_from_attributes(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_block_attrs)))
	mut var_gallery_caption := rt.new_string(this.extract_gallery_caption(block_content))
	mut var_block_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.get_block_styles(arg_0, arg_1, arg_2) }(var_block_attrs.dup(), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context', []string{}, var_rendering_context), rt.create_array([rt.ArrayItem{ key: none, val: 'padding' }, rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'background' }, rt.ArrayItem{ key: none, val: 'background-color' }, rt.ArrayItem{ key: none, val: 'color' }]))
	var_block_styles = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.extend_block_styles(arg_0, arg_1) }(var_block_styles.dup(), rt.create_array([rt.ArrayItem{ key: 'width', val: '100%' }, rt.ArrayItem{ key: 'border-collapse', val: 'collapse' }, rt.ArrayItem{ key: 'text-align', val: 'left' }]))
	mut var_table_attrs := rt.create_array([rt.ArrayItem{ key: 'class', val: 'email-block-gallery ' + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}; return temp.clean_css_classes(arg_0) }(var_original_wrapper_classname.dup())).str() }, rt.ArrayItem{ key: 'style', val: var_block_styles.array_get('css') }, rt.ArrayItem{ key: 'align', val: 'left' }, rt.ArrayItem{ key: 'width', val: '100%' }])
	mut var_cell_attrs := rt.new_array()
	if var_parsed_block.array_get('email_attrs').array_isset(rt.new_string('width')) {
		var_cell_attrs.array_set('width', var_parsed_block.array_get('email_attrs').array_get('width'))
	}
	mut var_gallery_content := rt.new_string(this.build_gallery_table(mut var_gallery_images_mutated, (var_columns).to_i64()))
	if !(!rt.is_true(var_gallery_caption)) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	return (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}; return temp.render_table_wrapper(arg_0, arg_1, arg_2) }(var_gallery_content.dup(), var_table_attrs.dup(), var_cell_attrs.dup())).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Gallery) build_gallery_table(mut var_gallery_images Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, columns i64) string {
	mut var_gallery_images_mutated := var_gallery_images
	mut columns_mutated := columns
	mut var_content_parts := rt.new_array()
	mut var_image_count := rt.new_int(rt.new_int(var_gallery_images_mutated.dup().array_count()))
	mut var_cell_padding := rt.new_int(rt.new_int(8))
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, var_image_count))) { break }
			mut var_row_images := rt.call_function('array_slice', [var_gallery_images_mutated.dup(), var_i.dup(), rt.new_int(columns_mutated).dup()])
			var_content_parts.array_push(this.build_gallery_row_table(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_row_images), columns_mutated, (var_cell_padding).to_i64()))
			// unsupported expression: Expr_AssignOp_Plus
		}
	}
	return (rt.call_function('implode', [rt.new_string(''), var_content_parts.dup()])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Gallery) build_gallery_row_table(mut var_row_images Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, total_columns i64, cell_padding i64) string {
	mut var_row_images_mutated := var_row_images
	mut cell_padding_mutated := cell_padding
	mut var_images_in_row := rt.new_int(rt.new_int(var_row_images_mutated.dup().array_count()))
	mut var_row_cells := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.identical(rt.new_int(1), var_images_in_row)) {
		mut var_cell_attrs := rt.create_array([rt.ArrayItem{ key: 'style', val: rt.call_function('sprintf', [rt.new_string('width: %s; padding: %dpx; vertical-align: top; text-align: center;'), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}; return temp.sanitize_css_value(arg_0) }(rt.new_string('100%')), rt.new_int(cell_padding_mutated).dup()]) }, rt.ArrayItem{ key: 'valign', val: 'top' }, rt.ArrayItem{ key: 'colspan', val: total_columns }])
		// unsupported expression: Expr_AssignOp_Concat
	} else {
		mut var_cell_width_percent := rt.div(rt.new_int(100), var_images_in_row)
		{
			mut iter_1 := var_row_images_mutated.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_image_html := item_1.val
				var_cell_attrs = rt.create_array([rt.ArrayItem{ key: 'style', val: rt.call_function('sprintf', [rt.new_string('width: %s; padding: %dpx; vertical-align: top; text-align: center;'), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}; return temp.sanitize_css_value(arg_0) }(rt.call_function('sprintf', [rt.new_string('%.2f%%'), var_cell_width_percent.dup()])), rt.new_int(cell_padding_mutated).dup()]) }, rt.ArrayItem{ key: 'valign', val: 'top' }])
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
	}
	return (rt.call_function('sprintf', [rt.new_string('<table role="presentation" style="width: %s; border-collapse: collapse; table-layout: fixed;"><tr>%s</tr></table>'), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}; return temp.sanitize_css_value(arg_0) }(rt.new_string('100%')), var_row_cells.dup()])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Gallery) get_columns_from_attributes(mut var_block_attrs Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array) i64 {
	mut var_block_attrs_mutated := var_block_attrs
	mut var_columns := if !(var_block_attrs_mutated.array_get('columns')).is_null() { var_block_attrs_mutated.array_get('columns') } else { rt.new_int(3) }
	var_columns = rt.call_function('max', [rt.new_int(1), rt.call_function('min', [rt.new_int(5), // unsupported expression: Expr_Cast_Int])])
	return (var_columns).to_i64()
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper {
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

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_gallery() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Gallery {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Gallery{
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

fn create_automattic_woocommerce_emaileditor_integrations_utils_html_processing_helper() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{
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

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Gallery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_string(this.render_content(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2))
		}
		'extract_images_from_gallery_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.extract_images_from_gallery_content(dispatch_arg_0, mut dispatch_arg_1)
		}
		'extract_image_from_html' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.extract_image_from_html(dispatch_arg_0))
		}
		'extract_gallery_caption' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.extract_gallery_caption(dispatch_arg_0))
		}
		'build_email_layout' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 3 { args[3] } else { rt.new_null() })
			return rt.new_string(this.build_email_layout(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3))
		}
		'build_gallery_table' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_string(this.build_gallery_table(mut dispatch_arg_0, dispatch_arg_1))
		}
		'build_gallery_row_table' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return rt.new_string(this.build_gallery_row_table(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_columns_from_attributes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_int(this.get_columns_from_attributes(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Gallery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Gallery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_integrations_core_renderer_blocks_class_gallery_php() {
	// unsupported statement: Stmt_Declare
}
