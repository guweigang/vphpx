import rt

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Media_Text {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Media_Text) render_content(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_block_attrs := if !(var_parsed_block.array_get(rt.new_string('attrs'))).is_null() {
		var_parsed_block.array_get(rt.new_string('attrs'))
	} else {
		rt.new_array()
	}
	mut var_inner_blocks := if !(var_parsed_block.array_get(rt.new_string('innerBlocks'))).is_null() {
		var_parsed_block.array_get(rt.new_string('innerBlocks'))
	} else {
		rt.new_array()
	}
	mut var_media_content := rt.new_string(this.extract_media_from_html((if !(var_parsed_block.array_get(rt.new_string('innerHTML'))).is_null() {
		var_parsed_block.array_get(rt.new_string('innerHTML'))
	} else {
		rt.new_string(block_content)
	}).str()))
	mut var_text_content := rt.new_string('')
	mut iter_1 := var_inner_blocks.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_block := item_1.val
		var_text_content = rt.concat(var_text_content, rt.call_function('render_block', [
			var_block.clone(),
		]))
	}
	if !rt.is_true(var_media_content) || !rt.is_true(var_text_content) {
		return ''
	}
	return this.build_email_layout(var_media_content.str(), var_text_content.str(), mut
		rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_block_attrs),
		block_content, mut var_rendering_context)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Media_Text) extract_media_from_html(block_content string) string {
	mut var_matches := rt.new_null()
	mut var_media_content := rt.new_string('')
	if rt.is_true(rt.call_function('preg_match', [
		rt.new_string('/<figure[^>]*class="[^"]*\\bwp-block-media-text__media\\b[^"]*"[^>]*>(.*?)<\\/figure>/s'),
		rt.new_string(block_content),
		var_matches.clone(),
	]))
	{
		var_media_content =
			rt.new_string(var_matches.array_get(rt.new_int(1)).to_string().trim_space())
	}
	return var_media_content.str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Media_Text) build_email_layout(media_content string, text_content string, mut var_block_attrs Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, block_content string, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut media_content_mutated := media_content
	mut text_content_mutated := text_content
	mut var_block_attrs_mutated := var_block_attrs
	mut var_original_wrapper_classname := if !(rt.call_method(create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(rt.new_string(block_content)), 'get_attribute_value_by_tag_name', [
		rt.new_string('div'),
		rt.new_string('class'),
	])).is_null() { rt.call_method(create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(rt.new_string(block_content)), 'get_attribute_value_by_tag_name', [
			rt.new_string('div'),
			rt.new_string('class'),
		]) } else { rt.new_string('') }
	mut var_media_position := if !(var_block_attrs_mutated.array_get(rt.new_string('mediaPosition'))).is_null() {
		var_block_attrs_mutated.array_get(rt.new_string('mediaPosition'))
	} else {
		rt.new_string('left')
	}
	mut var_vertical_alignment :=
		rt.new_string(this.get_vertical_alignment_from_attributes(mut var_block_attrs_mutated))
	mut var_media_width :=
		rt.new_int(this.get_media_width_from_attributes(mut var_block_attrs_mutated))
	mut var_text_width := rt.sub(rt.new_int(100), var_media_width)
	if !(!rt.is_true(var_block_attrs_mutated.array_get(rt.new_string('href')))) {
		media_content_mutated = this.wrap_media_with_link(media_content_mutated,
			(var_block_attrs_mutated.array_get(rt.new_string('href'))).str())
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
	mut iife_result_0 := iife_temp_0.get_block_styles(rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array',
		[]string{}, var_block_attrs_mutated), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context',
		[]string{}, var_rendering_context), rt.create_array([
		rt.ArrayItem{ key: none, val: 'padding' },
		rt.ArrayItem{ key: none, val: 'border' },
		rt.ArrayItem{ key: none, val: 'background' },
		rt.ArrayItem{ key: none, val: 'background-color' },
		rt.ArrayItem{ key: none, val: 'color' },
	]))
	mut var_block_styles := iife_result_0
	mut iife_temp_1 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
	mut iife_result_1 := iife_temp_1.extend_block_styles(var_block_styles.clone(), rt.create_array([
		rt.ArrayItem{ key: 'width', val: '100%' },
		rt.ArrayItem{ key: 'border-collapse', val: 'collapse' },
		rt.ArrayItem{ key: 'text-align', val: 'left' },
	]))
	var_block_styles = iife_result_1
	mut var_table_attrs := rt.create_array([
		rt.ArrayItem{ key: 'class', val: 'email-block-media-text ' +
			var_original_wrapper_classname.str() },
		rt.ArrayItem{ key: 'style', val: var_block_styles.array_get(rt.new_string('css')) },
		rt.ArrayItem{ key: 'align', val: 'left' },
		rt.ArrayItem{ key: 'width', val: '100%' },
	])
	mut var_media_cell_attrs := rt.create_array([
		rt.ArrayItem{ key: 'style', val: rt.call_function('sprintf', [
			rt.new_string('width: %d%%; padding: 10px; vertical-align: %s;'),
			var_media_width.clone(),
			var_vertical_alignment.clone(),
		]) },
		rt.ArrayItem{ key: 'valign', val: var_vertical_alignment },
	])
	mut var_text_cell_attrs := rt.create_array([
		rt.ArrayItem{ key: 'style', val: rt.call_function('sprintf', [
			rt.new_string('width: %d%%; padding: 0 8%%; vertical-align: %s;'),
			var_text_width.clone(),
			var_vertical_alignment.clone(),
		]) },
		rt.ArrayItem{ key: 'valign', val: var_vertical_alignment },
	])
	mut iife_temp_2 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
	mut iife_result_2 := iife_temp_2.render_table_cell(rt.new_string(media_content_mutated),
		var_media_cell_attrs.clone())
	mut var_media_cell := iife_result_2
	mut iife_temp_3 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
	mut iife_result_3 := iife_temp_3.render_table_cell(rt.new_string(text_content_mutated),
		var_text_cell_attrs.clone())
	mut var_text_cell := iife_result_3
	if rt.is_true(rt.identical(rt.new_string('right'), var_media_position)) {
		mut var_cells := rt.new_string(var_text_cell.str() + var_media_cell.str())
	} else {
		var_cells = rt.new_string(var_media_cell.str() + var_text_cell.str())
	}
	mut iife_temp_4 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
	mut iife_result_4 := iife_temp_4.render_table_wrapper(var_cells.clone(),
		var_table_attrs.clone(), rt.new_array(), rt.new_array(), rt.new_bool(false))
	return iife_result_4.str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Media_Text) get_vertical_alignment_from_attributes(mut var_block_attrs Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array) string {
	mut var_block_attrs_mutated := var_block_attrs
	mut var_vertical_alignment := if !(var_block_attrs_mutated.array_get(rt.new_string('verticalAlignment'))).is_null() {
		var_block_attrs_mutated.array_get(rt.new_string('verticalAlignment'))
	} else {
		rt.new_string('middle')
	}
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
	mut var_media_width := if !(var_block_attrs_mutated.array_get(rt.new_string('mediaWidth'))).is_null() {
		var_block_attrs_mutated.array_get(rt.new_string('mediaWidth'))
	} else {
		rt.new_int(50)
	}
	var_media_width = rt.call_function('max', [rt.new_int(1),
		rt.call_function('min', [rt.new_int(99), rt.new_int(var_media_width.to_i64())])])
	return var_media_width.to_i64()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Media_Text) wrap_media_with_link(media_content string, href string) string {
	mut media_content_mutated := media_content
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [
		rt.new_string(media_content_mutated).clone(),
		rt.new_string('<a '),
	])))))
	{
		return media_content_mutated
	}
	return '<a href="' + (rt.call_function('esc_url', [rt.new_string(href)])).str() + '">' +
		media_content_mutated + '</a>'
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

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_media_text(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Media_Text {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Media_Text{
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

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Media_Text) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'extract_media_from_html' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.extract_media_from_html(dispatch_arg_0))
		}
		'build_email_layout' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 4 {
				args[4]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.build_email_layout(dispatch_arg_0, dispatch_arg_1, mut
				dispatch_arg_2, dispatch_arg_3, mut dispatch_arg_4))
		}
		'get_vertical_alignment_from_attributes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.get_vertical_alignment_from_attributes(mut dispatch_arg_0))
		}
		'get_media_width_from_attributes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_int(this.get_media_width_from_attributes(mut dispatch_arg_0))
		}
		'wrap_media_with_link' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.wrap_media_with_link(dispatch_arg_0, dispatch_arg_1))
		}
		else {
			return none
		}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
