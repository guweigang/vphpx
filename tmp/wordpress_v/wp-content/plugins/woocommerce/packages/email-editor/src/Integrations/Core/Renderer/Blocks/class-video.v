import rt

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Video {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Video) render_content(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut block_content_mutated := block_content
	mut var_block_attrs := if !(var_parsed_block.array_get('attrs')).is_null() { var_parsed_block.array_get('attrs') } else { rt.new_array() }
	mut var_poster_url := rt.new_string(this.extract_poster_url(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_block_attrs), block_content_mutated))
	if !rt.is_true(var_poster_url) {
		return ''
	}
	mut var_cover_block := this.transform_to_cover_block(mut var_parsed_block, (var_poster_url).str())
	return (this.Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Cover.render_content(rt.new_string(block_content_mutated), var_cover_block.dup(), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context', []string{}, var_rendering_context))).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Video) extract_poster_url(mut var_block_attrs Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, block_content string) string {
	mut var_block_attrs_mutated := var_block_attrs
	mut block_content_mutated := block_content
	if !(!rt.is_true(var_block_attrs_mutated.array_get('poster'))) {
		return (rt.call_function('esc_url_raw', [var_block_attrs_mutated.array_get('poster')])).str()
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Video) extract_video_url(block_content string) string {
	mut block_content_mutated := block_content
	mut var_dom_helper := create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(rt.new_string(block_content_mutated).dup())
	mut var_wrapper_element := var_dom_helper.find_element(rt.new_string('div'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wrapper_element)))) {
		return ''
	}
	mut var_class_attr := var_dom_helper.get_attribute_value(var_wrapper_element.dup(), rt.new_string('class'))
	if rt.is_true(rt.identical(rt.call_function('strpos', [var_class_attr.dup(), rt.new_string('wp-block-embed__wrapper')]), rt.new_bool(false))) {
		return ''
	}
	mut var_inner_html := var_dom_helper.get_element_inner_html(var_wrapper_element.dup())
	mut var_url := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}; return temp.extract_url_from_text(arg_0) }(var_inner_html.dup())
	if !(!rt.is_true(var_url)) {
		var_url = rt.call_function('html_entity_decode', [var_url.dup(), rt.bitwise_or(rt.get_constant('ENT_QUOTES'), rt.get_constant('ENT_HTML5')), rt.new_string('UTF-8')])
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('filter_var', [var_url.dup(), rt.get_constant('FILTER_VALIDATE_URL')])) && rt.is_true(rt.call_function('wp_http_validate_url', [var_url.dup()])))) {
			return (var_url).str()
		}
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Video) transform_to_cover_block(mut var_video_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, poster_url string) rt.PhpVal {
	mut poster_url_mutated := poster_url
	mut var_block_attrs := if !(var_video_block.array_get('attrs')).is_null() { var_video_block.array_get('attrs') } else { rt.new_array() }
	mut var_block_content := if !(var_video_block.array_get('innerHTML')).is_null() { var_video_block.array_get('innerHTML') } else { rt.new_string('') }
	mut var_video_url := if !(var_block_attrs.array_get('videoUrl')).is_null() { var_block_attrs.array_get('videoUrl') } else { rt.new_string('') }
	if !rt.is_true(var_video_url) {
		var_video_url = rt.new_string(this.extract_video_url((var_block_content).str()))
	}
	mut var_link_url := if !(!rt.is_true(var_video_url)) { var_video_url } else { this.get_current_post_url() }
	return rt.create_array([rt.ArrayItem{ key: 'blockName', val: 'core/cover' }, rt.ArrayItem{ key: 'attrs', val: rt.create_array([rt.ArrayItem{ key: 'url', val: poster_url_mutated }, rt.ArrayItem{ key: 'minHeight', val: '390px' }]) }, rt.ArrayItem{ key: 'innerBlocks', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'blockName', val: 'core/html' }, rt.ArrayItem{ key: 'attrs', val: rt.new_array() }, rt.ArrayItem{ key: 'innerBlocks', val: rt.new_array() }, rt.ArrayItem{ key: 'innerHTML', val: this.create_play_button_html((var_link_url).str()) }, rt.ArrayItem{ key: 'innerContent', val: rt.create_array([rt.ArrayItem{ key: none, val: this.create_play_button_html((var_link_url).str()) }]) }]) }]) }, rt.ArrayItem{ key: 'innerHTML', val: var_block_content }])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Video) create_play_button_html(link_url string) string {
	mut link_url_mutated := link_url
	mut var_play_icon_url := rt.new_string(this.get_play_icon_url())
	mut var_play_button := rt.call_function('sprintf', [rt.new_string('<img src="%s" alt="%s" style="width: 48px; height: 48px; display: inline-block;" />'), rt.call_function('esc_url', [var_play_icon_url.dup()]), rt.call_function('esc_attr', [rt.call_function('__', [rt.new_string('Play'), rt.new_string('woocommerce')])])])
	if !(link_url_mutated == '') {
		var_play_button = rt.call_function('sprintf', [rt.new_string('<a href="%s" target="_blank" rel="noopener noreferrer nofollow" style="display: inline-block; text-decoration: none;">%s</a>'), rt.call_function('esc_url', [rt.new_string(link_url_mutated).dup()]), var_play_button.dup()])
	}
	return (rt.call_function('sprintf', [rt.new_string('<p style="text-align: center;">%s</p>'), var_play_button.dup()])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Video) get_play_icon_url() string {
	mut var_file_name := rt.new_string(rt.new_string('/icons/video/play2x.png'))
	return (rt.call_function('plugins_url', [var_file_name.dup(), rt.new_string(@FILE)])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Video) get_current_post_url() string {
	mut var_post := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_post, 'Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Post')))))) {
		return ''
	}
	mut var_permalink := rt.call_function('get_permalink', [rt.get_property(var_post, 'ID')])
	if !rt.is_true(var_permalink) {
		return ''
	}
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return ''
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_http_validate_url', [var_permalink.dup()]))))) {
		return ''
	}
	return (var_permalink).str()
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Cover {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_video() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Video {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Video{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_cover() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Cover {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Cover{
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

fn create_automattic_woocommerce_emaileditor_integrations_utils_html_processing_helper() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Video) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_string(this.render_content(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2))
		}
		'extract_poster_url' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.extract_poster_url(mut dispatch_arg_0, dispatch_arg_1))
		}
		'extract_video_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.extract_video_url(dispatch_arg_0))
		}
		'transform_to_cover_block' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.transform_to_cover_block(mut dispatch_arg_0, dispatch_arg_1)
		}
		'create_play_button_html' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.create_play_button_html(dispatch_arg_0))
		}
		'get_play_icon_url' {
			return rt.new_string(this.get_play_icon_url())
		}
		'get_current_post_url' {
			return rt.new_string(this.get_current_post_url())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Video) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Video) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Cover) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Cover) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Cover) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_integrations_core_renderer_blocks_class_video_php() {
	// unsupported statement: Stmt_Declare
}
