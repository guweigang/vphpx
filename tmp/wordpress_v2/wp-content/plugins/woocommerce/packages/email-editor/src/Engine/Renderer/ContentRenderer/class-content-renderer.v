import rt

pub fn Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer.content_styles_file() string {
	return 'content.css'
}
struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer {
	rt.PhpObjectBase
pub mut:
		process_manager rt.PhpVal = rt.new_null()
		theme_controller rt.PhpVal = rt.new_null()
		block_type_registry rt.PhpVal = rt.new_null()
		backup_template_content rt.PhpVal = rt.new_null()
		backup_template_id rt.PhpVal = rt.new_null()
		backup_post rt.PhpVal = rt.new_null()
		backup_query rt.PhpVal = rt.new_null()
		fallback_renderer rt.PhpVal = rt.new_null()
		logger rt.PhpVal = rt.new_null()
		backup_post_content_callback rt.PhpVal = rt.new_null()
		post_content_width rt.PhpVal = rt.new_null()
		container_padding rt.PhpVal = rt.new_array()
		css_inliner rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer) construct(mut var_preprocess_manager Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Process_Manager, mut var_css_inliner Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Css_Inliner, mut var_theme_controller Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller, mut var_logger Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger) {
	this.process_manager = var_preprocess_manager
	this.css_inliner = var_css_inliner
	this.theme_controller = var_theme_controller
	this.logger = var_logger
	mut iife_temp_0 := Class_WP_Block_Type_Registry{}
	mut iife_result_0 := iife_temp_0.get_instance()
	this.block_type_registry = iife_result_0
	this.fallback_renderer = create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_fallback()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer) initialize() {
	rt.call_function('add_filter', [rt.new_string('render_block'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'render_block' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('block_parser_class'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'block_parser' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_email_blocks_renderer_parsed_blocks'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'preprocess_parsed_blocks' }])])
	mut var_post_content_type := rt.call_method(this.block_type_registry, 'get_registered', [rt.new_string('core/post-content')])
	if rt.is_true(var_post_content_type) {
		this.backup_post_content_callback = rt.get_property(var_post_content_type, 'render_callback')
		mut var_post_content_renderer := create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_post_content()
		rt.set_property(var_post_content_type, 'render_callback', rt.create_array([rt.ArrayItem{ key: none, val: var_post_content_renderer }, rt.ArrayItem{ key: none, val: 'render_stateless' }]))
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer) render(mut var_post Class_WP_Post, mut var_template Class_WP_Block_Template) string {
	mut var_post_mutated := var_post
	mut var_result := this.render_without_css_inline(mut var_post_mutated, mut var_template)
	mut var_styles := rt.new_string('<style>' + (var_result.array_get(rt.new_string('styles'))).str() + '</style>')
	mut var_html := rt.call_method(rt.call_method(rt.call_method(this.css_inliner, 'from_html', [rt.new_string((var_styles).str() + (var_result.array_get(rt.new_string('html'))).str())]), 'inline_css', []rt.PhpVal{}), 'render', []rt.PhpVal{})
	return (rt.call_method(this.process_manager, 'postprocess', [var_html.clone()])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer) render_without_css_inline(mut var_post Class_WP_Post, mut var_template Class_WP_Block_Template) rt.PhpVal {
	mut var_post_mutated := var_post
	this.set_template_globals(mut var_post_mutated, mut var_template)
	this.initialize()
	rt.call_function('do_action', [rt.new_string('woocommerce_email_editor_render_start')])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_rendered_html := rt.call_function('get_the_block_template_html', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto finally_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()

finally_label_1:
	this.reset()
	if rt.has_exception() { return rt.new_null() }

end_label_1:
	return rt.create_array([rt.ArrayItem{ key: 'html', val: var_rendered_html }, rt.ArrayItem{ key: 'styles', val: this.collect_styles(mut var_post_mutated, rt.new_object('WP_Block_Template', []string{}, var_template)) }])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer) block_parser() string {
	return 'Automattic\\WooCommerce\\EmailEditor\\Engine\\Renderer\\ContentRenderer\\Blocks_Parser'
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer) preprocess_parsed_blocks(mut var_parsed_blocks Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_array) rt.PhpVal {
	mut var_styles := rt.call_method(this.theme_controller, 'get_styles', []rt.PhpVal{})
	mut var_layout := rt.call_method(this.theme_controller, 'get_layout_settings', []rt.PhpVal{})
	var_styles.array_set('__variables_map', rt.call_method(this.theme_controller, 'get_variables_values_map', []rt.PhpVal{}))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), this.post_content_width)))) {
		mut var_post_content_num := rt.new_float((rt.call_function('str_replace', [rt.new_string('px'), rt.new_string(''), this.post_content_width])).to_f64())
		mut var_content_size_num := rt.new_float((rt.call_function('str_replace', [rt.new_string('px'), rt.new_string(''), var_layout.array_get(rt.new_string('contentSize'))])).to_f64())
		if rt.is_true(rt.less(var_post_content_num, var_content_size_num - 0.01)) {
			var_styles.array_get(rt.new_string('spacing')).array_get(rt.new_string('padding')).array_unset(rt.new_string('left'))
			var_styles.array_get(rt.new_string('spacing')).array_get(rt.new_string('padding')).array_unset(rt.new_string('right'))
		}
		if !(!rt.is_true(this.container_padding)) {
			var_styles.array_set('__container_padding', this.container_padding)
		}
	}
	mut var_result := rt.call_method(this.process_manager, 'preprocess', [var_parsed_blocks, var_layout.clone(), var_styles.clone()])
	if rt.is_true(rt.identical(rt.new_null(), this.post_content_width)) {
		this.post_content_width = this.find_post_content_width(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_array](var_result), rt.new_null())
		this.container_padding = this.find_container_padding(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_array](var_result))
	}
	return var_result.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer) find_post_content_width(mut var_blocks Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_array, mut var_post_content_block_names Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_?array) string {
	mut var_post_content_block_names_mutated := var_post_content_block_names
	if rt.is_true(rt.identical(rt.new_null(), var_post_content_block_names_mutated)) {
	var_post_content_block_names_mutated = rt.cast_array(rt.call_function('apply_filters', [rt.new_string('woocommerce_email_editor_post_content_block_names'), rt.create_array([rt.ArrayItem{ key: none, val: 'core/post-content' }])]))
	}
	mut iter_1 := var_blocks.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_block := item_1.val
		mut var_block_name := if !(var_block.array_get(rt.new_string('blockName'))).is_null() { var_block.array_get(rt.new_string('blockName')) } else { rt.new_string('') }
		if rt.is_true(rt.call_function('in_array', [var_block_name.clone(), var_post_content_block_names_mutated, rt.new_bool(true)])) {
			return (if !(var_block.array_get(rt.new_string('email_attrs')).array_get(rt.new_string('width'))).is_null() { var_block.array_get(rt.new_string('email_attrs')).array_get(rt.new_string('width')) } else { rt.new_null() }).str()
		}
		if !(!rt.is_true(var_block.array_get(rt.new_string('innerBlocks')))) {
			mut var_found := rt.new_string(this.find_post_content_width(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_array](var_block.array_get(rt.new_string('innerBlocks'))), mut var_post_content_block_names_mutated))
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_found)))) {
				return (var_found).str()
			}
		}
	}
	return (rt.new_null()).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer) find_container_padding(mut var_blocks Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_array) rt.PhpVal {
	mut var_variables_map := rt.call_method(this.theme_controller, 'get_variables_values_map', []rt.PhpVal{})
	mut iter_2 := var_blocks.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_block := item_2.val
		mut var_email_attrs := if !(var_block.array_get(rt.new_string('email_attrs'))).is_null() { var_block.array_get(rt.new_string('email_attrs')) } else { rt.new_array() }
		if !(!rt.is_true(var_email_attrs.array_get(rt.new_string('suppress-horizontal-padding')))) {
			mut var_padding := if !(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('style')).array_get(rt.new_string('spacing')).array_get(rt.new_string('padding'))).is_null() { var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('style')).array_get(rt.new_string('spacing')).array_get(rt.new_string('padding')) } else { rt.new_array() }
			mut var_result := rt.new_array()
			if var_padding.array_isset(rt.new_string('left')) && var_padding.array_get(rt.new_string('left')).is_string() {
				mut iife_temp_1 := Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver{}
				mut iife_result_1 := iife_temp_1.resolve(var_padding.array_get(rt.new_string('left')), var_variables_map.clone())
				var_result.array_set('left', iife_result_1)
			}
			if var_padding.array_isset(rt.new_string('right')) && var_padding.array_get(rt.new_string('right')).is_string() {
				mut iife_temp_2 := Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver{}
				mut iife_result_2 := iife_temp_2.resolve(var_padding.array_get(rt.new_string('right')), var_variables_map.clone())
				var_result.array_set('right', iife_result_2)
			}
			if !(!rt.is_true(var_result)) {
				return var_result.clone()
			}
		}
		if !(!rt.is_true(var_block.array_get(rt.new_string('innerBlocks')))) {
			mut var_found := this.find_container_padding(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_array](var_block.array_get(rt.new_string('innerBlocks'))))
			if !(!rt.is_true(var_found)) {
				return var_found.clone()
			}
		}
	}
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer) render_block(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_array) string {
	mut var_email_context := rt.call_function('apply_filters', [rt.new_string('woocommerce_email_editor_rendering_email_context'), rt.new_array()])
	mut var_context := create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_rendering_context(rt.call_method(this.theme_controller, 'get_theme', []rt.PhpVal{}), var_email_context.clone())
	mut var_block_type := rt.call_method(this.block_type_registry, 'get_registered', [var_parsed_block.array_get(rt.new_string('blockName'))])
	mut var_result := rt.new_null()
	if rt.is_true(var_block_type) && !(rt.get_property(var_block_type, 'render_email_callback')).is_null() && rt.call_function('is_callable', [rt.get_property(var_block_type, 'render_email_callback')]) {
		var_result = rt.call_function('call_user_func', [rt.get_property(var_block_type, 'render_email_callback'), rt.new_string(block_content), var_parsed_block, var_context])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Exception') {
		mut var_error := var_e_2.clone()
		rt.call_method(this.logger, 'error', [rt.new_string('Error thrown while rendering block.'), rt.create_array([rt.ArrayItem{ key: 'exception', val: var_error }, rt.ArrayItem{ key: 'block_name', val: var_parsed_block.array_get(rt.new_string('blockName')) }, rt.ArrayItem{ key: 'parsed_block', val: var_parsed_block }, rt.ArrayItem{ key: 'message', val: rt.call_method(var_error, 'getMessage', []rt.PhpVal{}) }])])
		return block_content
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	if rt.is_true(rt.identical(rt.new_null(), var_result)) {
	var_result = rt.call_method(this.fallback_renderer, 'render', [rt.new_string(block_content), var_parsed_block, var_context])
	}
	return this.add_root_horizontal_padding((var_result).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_array](if !(var_parsed_block.array_get(rt.new_string('email_attrs'))).is_null() { var_parsed_block.array_get(rt.new_string('email_attrs')) } else { rt.new_array() }))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer) add_root_horizontal_padding(content string, mut var_email_attrs Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_array) string {
	mut var_email_attrs_mutated := var_email_attrs
	mut var_padding_left := rt.new_float(this.sum_padding_values(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_?string](if !(var_email_attrs_mutated.array_get(rt.new_string('root-padding-left'))).is_null() { var_email_attrs_mutated.array_get(rt.new_string('root-padding-left')) } else { rt.new_null() }), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_?string](if !(var_email_attrs_mutated.array_get(rt.new_string('container-padding-left'))).is_null() { var_email_attrs_mutated.array_get(rt.new_string('container-padding-left')) } else { rt.new_null() })))
	mut var_padding_right := rt.new_float(this.sum_padding_values(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_?string](if !(var_email_attrs_mutated.array_get(rt.new_string('root-padding-right'))).is_null() { var_email_attrs_mutated.array_get(rt.new_string('root-padding-right')) } else { rt.new_null() }), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_?string](if !(var_email_attrs_mutated.array_get(rt.new_string('container-padding-right'))).is_null() { var_email_attrs_mutated.array_get(rt.new_string('container-padding-right')) } else { rt.new_null() })))
	mut var_css_attrs := rt.new_array()
	if rt.is_true(rt.greater(var_padding_left, rt.new_int(0))) {
		var_css_attrs.array_set('padding-left', (var_padding_left).str() + 'px')
	}
	if rt.is_true(rt.greater(var_padding_right, rt.new_int(0))) {
		var_css_attrs.array_set('padding-right', (var_padding_right).str() + 'px')
	}
	if !rt.is_true(var_css_attrs) {
		return content
	}
	mut iife_temp_3 := Class_WP_Style_Engine{}
	mut iife_result_3 := iife_temp_3.compile_css(var_css_attrs.clone(), rt.new_string(''))
	mut var_padding_style := iife_result_3
	if !rt.is_true(var_padding_style) {
		return content
	}
	mut var_table_attrs := rt.create_array([rt.ArrayItem{ key: 'align', val: 'left' }, rt.ArrayItem{ key: 'width', val: '100%' }])
	mut var_cell_attrs := rt.create_array([rt.ArrayItem{ key: 'style', val: var_padding_style }])
	mut var_div_content := rt.call_function('sprintf', [rt.new_string('<div class="email-root-padding" style="%1$s">%2$s</div>'), rt.call_function('esc_attr', [var_padding_style.clone()]), rt.new_string(content)])
	mut iife_temp_4 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
	mut iife_result_4 := iife_temp_4.render_outlook_table_wrapper(var_div_content.clone(), var_table_attrs.clone(), var_cell_attrs.clone())
	return (iife_result_4).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer) sum_padding_values(mut var_value1 Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_?string, mut var_value2 Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_?string) f64 {
	mut var_sum := rt.new_float(0)
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_value1)))) {
		var_sum = rt.add(var_sum, rt.new_float((rt.call_function('str_replace', [rt.new_string('px'), rt.new_string(''), var_value1])).to_f64()))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_value2)))) {
		var_sum = rt.add(var_sum, rt.new_float((rt.call_function('str_replace', [rt.new_string('px'), rt.new_string(''), var_value2])).to_f64()))
	}
	return (var_sum).to_f64()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer) set_template_globals(mut var_email_post Class_WP_Post, mut var_template Class_WP_Block_Template) {
	mut var__wp_current_template_content := rt.get_superglobal('_wp_current_template_content')
	mut var__wp_current_template_id := rt.get_superglobal('_wp_current_template_id')
	mut var_wp_query := rt.get_superglobal('wp_query')
	mut var_post := rt.get_superglobal('post')
	this.backup_template_content = var__wp_current_template_content.clone()
	this.backup_template_id = var__wp_current_template_id.clone()
	this.backup_query = var_wp_query.clone()
	this.backup_post = var_post.clone()
var__wp_current_template_id = rt.get_property(var_template, 'id')
var__wp_current_template_content = rt.get_property(var_template, 'content')
var_wp_query = create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_wp_query(rt.create_array([rt.ArrayItem{ key: 'p', val: rt.get_property(var_email_post, 'ID') }]))
var_post = var_email_post
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer) reset() {
	rt.call_function('remove_filter', [rt.new_string('render_block'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'render_block' }])])
	rt.call_function('remove_filter', [rt.new_string('block_parser_class'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'block_parser' }])])
	rt.call_function('remove_filter', [rt.new_string('woocommerce_email_blocks_renderer_parsed_blocks'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'preprocess_parsed_blocks' }])])
	this.post_content_width = rt.new_null()
	this.container_padding = rt.new_array()
	mut var_post_content_type := rt.call_method(this.block_type_registry, 'get_registered', [rt.new_string('core/post-content')])
	if rt.is_true(var_post_content_type) {
		rt.set_property(var_post_content_type, 'render_callback', this.backup_post_content_callback)
	}
	mut var__wp_current_template_content := rt.get_superglobal('_wp_current_template_content')
	mut var__wp_current_template_id := rt.get_superglobal('_wp_current_template_id')
	mut var_wp_query := rt.get_superglobal('wp_query')
	mut var_post := rt.get_superglobal('post')
var__wp_current_template_content = this.backup_template_content
var__wp_current_template_id = this.backup_template_id
var_wp_query = this.backup_query
var_post = this.backup_post
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer) collect_styles(mut var_post Class_WP_Post, var_template rt.PhpVal) string {
	mut var_post_mutated := var_post
	mut var_styles := rt.new_string((rt.call_function('file_get_contents', [rt.new_string(@DIR + '/' + (Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer.content_styles_file()).str())])).str())
	var_styles = rt.concat(var_styles, rt.new_string((rt.call_function('file_get_contents', [rt.new_string(@DIR + '/../../content-shared.css')])).str()))
	mut var_layout := rt.call_method(this.theme_controller, 'get_layout_settings', []rt.PhpVal{})
	var_styles = rt.concat(var_styles, rt.call_function('sprintf', [rt.new_string('\n      .is-layout-constrained > *:not(.alignleft):not(.alignright):not(.alignfull) {\n        max-width: %1$s;\n        margin-left: auto !important;\n        margin-right: auto !important;\n      }\n      .is-layout-constrained > .alignwide {\n        max-width: %2$s;\n        margin-left: auto !important;\n        margin-right: auto !important;\n      }\n      '), var_layout.array_get(rt.new_string('contentSize')), if !(var_layout.array_get(rt.new_string('wideSize'))).is_null() { var_layout.array_get(rt.new_string('wideSize')) } else { var_layout.array_get(rt.new_string('contentSize')) }]))
	var_styles = rt.concat(var_styles, rt.call_method(this.theme_controller, 'get_stylesheet_for_rendering', [var_post_mutated, var_template.clone()]))
	mut var_block_support_styles := rt.call_method(this.theme_controller, 'get_stylesheet_from_context', [rt.new_string('block-supports'), rt.new_array()])
	var_block_support_styles = rt.call_function('str_replace', [rt.new_string(':where(:not(.alignleft):not(.alignright):not(.alignfull))'), rt.new_string('*:not(.alignleft):not(.alignright):not(.alignfull)'), var_block_support_styles.clone()])
	var_block_support_styles = rt.call_function('preg_replace', [rt.new_string('/group-is-layout-(\\d+) >/'), rt.new_string('group-is-layout-$1 > tbody tr td >'), var_block_support_styles.clone()])
	var_styles = rt.concat(var_styles, var_block_support_styles)
	return (rt.call_function('wp_strip_all_tags', [rt.new_string((rt.call_function('apply_filters', [rt.new_string('woocommerce_email_content_renderer_styles'), var_styles.clone(), var_post_mutated])).str())])).str()
}

struct Class_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Fallback {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Post_Content {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context {
	rt.PhpObjectBase
}

struct Class_WP_Style_Engine {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_WP_Query {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_content_renderer(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer{
		PhpObjectBase: rt.PhpObjectBase{}
		process_manager: rt.new_null()
		theme_controller: rt.new_null()
		block_type_registry: rt.new_null()
		backup_template_content: rt.new_null()
		backup_template_id: rt.new_null()
		backup_post: rt.new_null()
		backup_query: rt.new_null()
		fallback_renderer: rt.new_null()
		logger: rt.new_null()
		backup_post_content_callback: rt.new_null()
		post_content_width: rt.new_null()
		container_padding: rt.new_array()
		css_inliner: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3)
	return obj
}

fn create_wp_block_type_registry(_args ...rt.PhpVal) &Class_WP_Block_Type_Registry {
	mut obj := &Class_WP_Block_Type_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_fallback(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Fallback {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Fallback{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_post_content(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Post_Content {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Post_Content{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_preset_variable_resolver(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_rendering_context(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_style_engine(_args ...rt.PhpVal) &Class_WP_Style_Engine {
	mut obj := &Class_WP_Style_Engine{
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

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_wp_query(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_WP_Query {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Process_Manager](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Css_Inliner](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger](if args.len > 3 { args[3] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3)
			return rt.new_null()
		}
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'render' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Post](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_Block_Template](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(this.render(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'render_without_css_inline' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Post](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_Block_Template](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.render_without_css_inline(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'block_parser' {
			return rt.new_string(this.block_parser())
		}
		'preprocess_parsed_blocks' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.preprocess_parsed_blocks(mut dispatch_arg_0)
		}
		'find_post_content_width' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(this.find_post_content_width(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'find_container_padding' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.find_container_padding(mut dispatch_arg_0)
		}
		'render_block' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(this.render_block(dispatch_arg_0, mut dispatch_arg_1))
		}
		'add_root_horizontal_padding' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(this.add_root_horizontal_padding(dispatch_arg_0, mut dispatch_arg_1))
		}
		'sum_padding_values' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_float(this.sum_padding_values(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'set_template_globals' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Post](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_Block_Template](if args.len > 1 { args[1] } else { rt.new_null() })
			this.set_template_globals(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'reset' {
			this.reset()
			return rt.new_null()
		}
		'collect_styles' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Post](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.collect_styles(mut dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'process_manager' { return this.process_manager }
		'theme_controller' { return this.theme_controller }
		'block_type_registry' { return this.block_type_registry }
		'backup_template_content' { return this.backup_template_content }
		'backup_template_id' { return this.backup_template_id }
		'backup_post' { return this.backup_post }
		'backup_query' { return this.backup_query }
		'fallback_renderer' { return this.fallback_renderer }
		'logger' { return this.logger }
		'backup_post_content_callback' { return this.backup_post_content_callback }
		'post_content_width' { return this.post_content_width }
		'container_padding' { return this.container_padding }
		'css_inliner' { return this.css_inliner }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'process_manager' { this.process_manager = val; return true }
		'theme_controller' { this.theme_controller = val; return true }
		'block_type_registry' { this.block_type_registry = val; return true }
		'backup_template_content' { this.backup_template_content = val; return true }
		'backup_template_id' { this.backup_template_id = val; return true }
		'backup_post' { this.backup_post = val; return true }
		'backup_query' { this.backup_query = val; return true }
		'fallback_renderer' { this.fallback_renderer = val; return true }
		'logger' { this.logger = val; return true }
		'backup_post_content_callback' { this.backup_post_content_callback = val; return true }
		'post_content_width' { this.post_content_width = val; return true }
		'container_padding' { this.container_padding = val; return true }
		'css_inliner' { this.css_inliner = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Block_Type_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Type_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Fallback) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Fallback) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Fallback) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Post_Content) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Post_Content) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Post_Content) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Style_Engine) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Style_Engine) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Style_Engine) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
