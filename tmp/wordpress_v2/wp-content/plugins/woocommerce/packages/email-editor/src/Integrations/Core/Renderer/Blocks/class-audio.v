import rt

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Audio {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Audio) render(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	if !(var_parsed_block.array_isset(rt.new_string('attrs')))
		|| !(var_parsed_block.array_get(rt.new_string('attrs')).is_array())
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('\\Automattic\\WooCommerce\\EmailEditor\\Integrations\\Utils\\Table_Wrapper_Helper')]))))) {
		return ''
	}
	mut var_attr := var_parsed_block.array_get(rt.new_string('attrs'))
	mut var_has_attachment_id :=
		rt.new_bool(!(!rt.is_true(var_attr.array_get(rt.new_string('id')))))
	mut var_has_src_in_html := rt.call_function('preg_match', [
		rt.new_string('#<audio[^>]*\\ssrc=["\']([^"\']*)["\'][^>]*/?>#'),
		rt.new_string(block_content),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_has_attachment_id))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_has_src_in_html)))) {
		return ''
	}
	mut var_rendered_content := rt.new_string(this.render_content(block_content, mut
		var_parsed_block, mut var_rendering_context))
	if !rt.is_true(var_rendered_content) {
		return ''
	}
	return (this.add_spacer(var_rendered_content.clone(), if !(var_parsed_block.array_get(rt.new_string('email_attrs'))).is_null() {
		var_parsed_block.array_get(rt.new_string('email_attrs'))
	} else {
		rt.new_array()
	})).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Audio) render_content(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_audio := rt.new_null()
	mut var_attr := var_parsed_block.array_get(rt.new_string('attrs'))
	if var_attr.array_isset(rt.new_string('id')) {
		mut var_url := rt.call_function('wp_get_attachment_url', [
			var_attr.array_get(rt.new_string('id')),
		])
		mut var_meta := rt.call_function('get_post_meta', [
			var_attr.array_get(rt.new_string('id')),
			rt.new_string('_wp_attachment_metadata'),
			rt.new_bool(true),
		])
		mut var_length := if var_meta.clone().is_array()
			&& var_meta.array_isset(rt.new_string('length_formatted'))
			&& var_meta.array_get(rt.new_string('length_formatted')).is_string() {
			var_meta.array_get(rt.new_string('length_formatted'))
		} else {
			rt.new_string('')
		}
	} else {
		rt.call_function('preg_match', [
			rt.new_string('#<audio[^>]*\\ssrc=["\']([^"\']*)["\'][^>]*/?>#'),
			rt.new_string(block_content),
			var_audio.clone(),
		])
		var_url = if var_audio.array_isset(rt.new_int(1)) {
			var_audio.array_get(rt.new_int(1))
		} else {
			if !(var_attr.array_get(rt.new_string('src'))).is_null() {
				var_attr.array_get(rt.new_string('src'))
			} else {
				rt.new_string('')
			}
		}
		var_length = rt.new_null()
	}
	if !rt.is_true(var_url) {
		return ''
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [var_url.clone(), rt.new_string('data:audio/')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [var_url.clone(), rt.new_string('/')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [var_url.clone(), rt.new_string('https://')]))))) {
		return ''
	}
	if rt.is_true(rt.call_function('str_starts_with', [var_url.clone(), rt.new_string('https://')]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_http_validate_url', [var_url.clone()]))))) {
		return ''
	}
	mut var_email_attrs := if !(var_parsed_block.array_get(rt.new_string('email_attrs'))).is_null() {
		var_parsed_block.array_get(rt.new_string('email_attrs'))
	} else {
		rt.new_array()
	}
	mut var_table_margin_style := rt.new_string('')
	if !(!rt.is_true(var_email_attrs))
		&& rt.is_true(rt.call_function('class_exists', [rt.new_string('\\WP_Style_Engine')])) {
		mut iife_temp_0 :=
			Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Style_Engine{}
		mut iife_result_0 := iife_temp_0.compile_css(rt.call_function('array_intersect_key', [
			var_email_attrs.clone(),
			rt.call_function('array_flip', [
				rt.create_array([rt.ArrayItem{ key: none, val: 'margin' }]),
			]),
		]), rt.new_string(''))
		var_table_margin_style = iife_result_0
	}
	mut var_icon_image := rt.new_string(this.get_audio_icon_url())
	mut var_label := if !(!rt.is_true(var_attr.array_get(rt.new_string('label')))) { var_attr.array_get(rt.new_string('label')) } else { rt.call_function('__', [
			rt.new_string('Listen to the audio'),
			rt.new_string('woocommerce'),
		]) }
	if !(!rt.is_true(var_length)) {
		var_label = rt.concat(var_label, rt.new_string(
			' (' + (rt.call_function('esc_html', [rt.new_string(var_length.str())])).str() + ')'))
	}
	mut var_audio_url := rt.call_function('esc_url', [var_url.clone()])
	mut var_background_color := rt.new_string('#f6f7f7')
	mut var_border_color := rt.new_string('#AAA')
	mut var_icon_size := rt.new_string('18px')
	mut var_font_size := rt.new_string('14px')
	mut var_icon_content := rt.call_function('sprintf', [
		rt.new_string('<a href="%1$s" rel="noopener nofollow" target="_blank" style="padding: 0.25em; padding-left: 17px; display: inline-block; vertical-align: middle;"><img height="%2$s" src="%3$s" style="display:block;margin-right:0;vertical-align:middle;" width="%2$s" alt="%4$s"></a>'),
		var_audio_url.clone(),
		rt.call_function('esc_attr', [var_icon_size.clone()]),
		rt.call_function('esc_url', [var_icon_image.clone()]),
		rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s icon'),
				rt.new_string('woocommerce')]),
			rt.call_function('__', [rt.new_string('Audio'), rt.new_string('woocommerce')]),
		]),
	])
	mut iife_temp_1 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
	mut iife_result_1 := iife_temp_1.render_table_cell(var_icon_content.clone(), rt.create_array([
		rt.ArrayItem{ key: 'style', val: rt.call_function('sprintf', [
			rt.new_string('vertical-align:middle;font-size:%s;'),
			var_font_size.clone(),
		]) },
	]))
	var_icon_content = iife_result_1
	mut var_label_content := rt.call_function('sprintf', [
		rt.new_string('<a href="%1$s" rel="noopener nofollow" target="_blank" style="text-decoration:none; padding: 0.25em; padding-right: 17px; display: inline-block;"><span style="margin-left:.5em;margin-right:.5em;font-weight:bold"> %2$s </span></a>'),
		var_audio_url.clone(),
		rt.call_function('esc_html', [var_label.clone()]),
	])
	mut var_label_cell_style := rt.call_function('sprintf', [
		rt.new_string('vertical-align:middle;font-size:%s;'),
		var_font_size.clone(),
	])
	mut iife_temp_2 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
	mut iife_result_2 := iife_temp_2.render_table_cell(var_label_content.clone(), rt.create_array([
		rt.ArrayItem{ key: 'style', val: var_label_cell_style },
	]))
	var_label_content = iife_result_2
	mut var_audio_content := rt.new_string(var_icon_content.str() + var_label_content.str())
	mut var_main_table_styles := rt.call_function('sprintf', [
		rt.new_string('background-color: %s; border-radius: 9999px; float: none; border: 1px solid %s; border-collapse: separate;'),
		var_background_color.clone(),
		var_border_color.clone(),
	])
	mut var_main_table_attrs := rt.create_array([
		rt.ArrayItem{ key: 'align', val: 'left' },
		rt.ArrayItem{ key: 'style', val: var_main_table_styles },
	])
	mut iife_temp_3 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
	mut iife_result_3 := iife_temp_3.render_table_wrapper(var_audio_content.clone(),
		var_main_table_attrs.clone(), rt.new_array(), rt.new_array(), rt.new_bool(false))
	mut var_main_table := iife_result_3
	mut var_table_style := rt.new_string('width: 100%;')
	if !(!rt.is_true(var_table_margin_style)) {
		var_table_style = rt.new_string(var_table_margin_style.str() + '; ' + var_table_style.str())
	} else {
		var_table_style = rt.new_string('margin: 16px 0; ' + var_table_style.str())
	}
	mut var_table_attrs := rt.create_array([
		rt.ArrayItem{ key: 'style', val: var_table_style },
	])
	mut var_cell_attrs := rt.create_array([
		rt.ArrayItem{
			key: 'style'
			val: 'min-width: 100%; vertical-align: middle; word-break: break-word; text-align: left;'
		},
	])
	mut iife_temp_4 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
	mut iife_result_4 := iife_temp_4.render_table_wrapper(var_main_table.clone(),
		var_table_attrs.clone(), var_cell_attrs.clone())
	mut var_main_wrapper := iife_result_4
	mut iife_temp_5 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
	mut iife_result_5 := iife_temp_5.render_outlook_table_wrapper(var_main_wrapper.clone(), rt.create_array([
		rt.ArrayItem{ key: 'align', val: 'left' },
	]))
	return iife_result_5.str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Audio) get_audio_icon_url() string {
	mut var_file_name := rt.new_string('/icons/audio/audio-play.png')
	return (rt.call_function('plugins_url', [var_file_name.clone(),
		rt.new_string(@FILE)])).str()
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Style_Engine {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_audio(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Audio {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Audio{
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

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_style_engine(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Style_Engine {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Style_Engine{
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

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Audio) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
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
		'get_audio_icon_url' {
			return rt.new_string(this.get_audio_icon_url())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Audio) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Audio) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Style_Engine) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Style_Engine) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Style_Engine) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
