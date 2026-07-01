import rt

pub fn Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Renderer.template_file() string {
	return 'template-canvas.php'
}
pub fn Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Renderer.template_styles_file() string {
	return 'template-canvas.css'
}
struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Renderer {
	rt.PhpObjectBase
pub mut:
		theme_controller rt.PhpVal = rt.new_null()
		content_renderer rt.PhpVal = rt.new_null()
		templates rt.PhpVal = rt.new_null()
		css_inliner rt.PhpVal = rt.new_null()
		process_manager rt.PhpVal = rt.new_null()
		personalization_tags_registry rt.PhpVal = rt.new_null()
		personalization_tag_placeholders rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Renderer) construct(mut var_content_renderer Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer, mut var_templates Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates, mut var_css_inliner Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Css_Inliner, mut var_theme_controller Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller, mut var_personalization_tags_registry Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry, mut var_process_manager Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Process_Manager)  {
	this.content_renderer = var_content_renderer.dup()
	this.templates = var_templates.dup()
	this.theme_controller = var_theme_controller.dup()
	this.css_inliner = var_css_inliner.dup()
	this.personalization_tags_registry = var_personalization_tags_registry.dup()
	this.process_manager = var_process_manager.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Renderer) render(mut var_post Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_WP_Post, subject string, pre_header string, language string, meta_robots string, template_slug string) rt.PhpVal {
	mut template_slug_mutated := template_slug
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(template_slug_mutated))))) {
		template_slug_mutated = (if rt.is_true(rt.call_function('get_page_template_slug', [var_post])) { rt.call_function('get_page_template_slug', [var_post]) } else { rt.new_string('email-general') }).str()
	}
	mut var_template := rt.call_method(this.templates, 'get_block_template', [rt.new_string(template_slug_mutated).dup()])
	mut var_email_styles := rt.call_method(this.theme_controller, 'get_styles', []rt.PhpVal{})
	mut var_content_result := rt.call_method(this.content_renderer, 'render_without_css_inline', [var_post, var_template.dup()])
	mut var_template_html := var_content_result.array_get('html')
	mut var_content_styles := var_content_result.array_get('styles')
	mut var_layout := rt.call_method(this.theme_controller, 'get_layout_settings', []rt.PhpVal{})
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.include_file((Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Renderer.template_file()).to_string(), '1')
	mut var_rendered_template := // unsupported expression: Expr_Cast_String
	mut var_template_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Style_Engine{}; return temp.compile_css(arg_0, arg_1) }(rt.create_array([rt.ArrayItem{ key: 'background-color', val: if !(var_email_styles.array_get('color').array_get('background')).is_null() { var_email_styles.array_get('color').array_get('background') } else { rt.new_string('inherit') } }, rt.ArrayItem{ key: 'color', val: if !(var_email_styles.array_get('color').array_get('text')).is_null() { var_email_styles.array_get('color').array_get('text') } else { rt.new_string('inherit') } }, rt.ArrayItem{ key: 'padding-top', val: if !(var_email_styles.array_get('spacing').array_get('padding').array_get('top')).is_null() { var_email_styles.array_get('spacing').array_get('padding').array_get('top') } else { rt.new_string('0px') } }, rt.ArrayItem{ key: 'padding-bottom', val: if !(var_email_styles.array_get('spacing').array_get('padding').array_get('bottom')).is_null() { var_email_styles.array_get('spacing').array_get('padding').array_get('bottom') } else { rt.new_string('0px') } }, rt.ArrayItem{ key: 'font-family', val: if !(var_email_styles.array_get('typography').array_get('fontFamily')).is_null() { var_email_styles.array_get('typography').array_get('fontFamily') } else { rt.new_string('inherit') } }, rt.ArrayItem{ key: 'line-height', val: if !(var_email_styles.array_get('typography').array_get('lineHeight')).is_null() { var_email_styles.array_get('typography').array_get('lineHeight') } else { rt.new_string('1.5') } }, rt.ArrayItem{ key: 'font-size', val: if !(var_email_styles.array_get('typography').array_get('fontSize')).is_null() { var_email_styles.array_get('typography').array_get('fontSize') } else { rt.new_string('inherit') } }]), rt.new_string('body, .email_layout_wrapper'))
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	var_template_styles = rt.call_function('wp_strip_all_tags', [// unsupported expression: Expr_Cast_String])
	mut var_all_styles := rt.new_string('<style>' + (var_template_styles).str() + (var_content_styles).str() + '</style>')
	var_rendered_template = this.inline_css_styles(rt.new_string((var_all_styles).str() + (var_rendered_template).str()))
	var_rendered_template = rt.call_method(this.process_manager, 'postprocess', [var_rendered_template.dup()])
	if var_email_styles.array_get('elements').array_get('link').array_get(':hover').array_get('color').array_isset(rt.new_string('text')) {
		var_rendered_template = rt.call_function('str_replace', [rt.new_string('<!-- Forced Styles -->'), '<style>a:hover { color: ' + (rt.call_function('esc_attr', [var_email_styles.array_get('elements').array_get('link').array_get(':hover').array_get('color').array_get('text')])).str() + ' !important; }</style>', var_rendered_template.dup()])
	}
	return rt.create_array([rt.ArrayItem{ key: 'html', val: var_rendered_template }, rt.ArrayItem{ key: 'text', val: this.render_text_version(var_rendered_template.dup()) }])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Renderer) inline_css_styles(var_template rt.PhpVal) rt.PhpVal {
	mut var_template_mutated := var_template
	return rt.call_method(rt.call_method(rt.call_method(this.css_inliner, 'from_html', [var_template_mutated.dup()]), 'inline_css', []rt.PhpVal{}), 'render', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Renderer) render_text_version(var_template rt.PhpVal) string {
	mut var_template_mutated := var_template
	var_template_mutated = if rt.is_true(rt.call_function('mb_detect_encoding', [var_template_mutated.dup(), rt.new_string('UTF-8'), rt.new_bool(true)])) { var_template_mutated } else { rt.call_function('mb_convert_encoding', [var_template_mutated.dup(), rt.new_string('UTF-8'), rt.call_function('mb_list_encodings', []rt.PhpVal{})]) }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_template_mutated.dup().is_string()))))) {
		return ''
	}
	var_template_mutated = rt.new_string(this.preserve_personalization_tags((var_template_mutated).str()))
	mut var_result := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text{}; return temp.convert(arg_0, arg_1) }(// unsupported expression: Expr_Cast_String, rt.create_array([rt.ArrayItem{ key: 'ignore_errors', val: true }]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return ''
	}
	var_result = rt.new_string(this.restore_personalization_tags((var_result).str()))
	return (var_result).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Renderer) preserve_personalization_tags(template string) string {
	mut template_mutated := template
	mut var_all_registered_tags := rt.call_method(this.personalization_tags_registry, 'get_all', []rt.PhpVal{})
	this.personalization_tag_placeholders = rt.new_array()
	mut var_counter := rt.new_int(rt.new_int(0))
	mut var_base_tokens := rt.new_array()
	mut var_token_prefixes := rt.new_array()
	{
		mut iter_1 := var_all_registered_tags.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tag := item_1.val
			mut var_token := rt.call_method(var_tag, 'get_token', []rt.PhpVal{})
			var_base_tokens.array_set(var_token, true)
			var_token_prefixes.array_push(rt.call_function('preg_quote', [rt.call_function('substr', [var_token.dup(), rt.new_int(1), // unsupported expression: Expr_UnaryMinus]), rt.new_string('/')]))
		}
	}
	if !rt.is_true(var_token_prefixes) {
		return template_mutated
	}
	mut var_pattern := rt.new_string('/<!--\\[(' + (rt.call_function('implode', [rt.new_string('|'), var_token_prefixes.dup()])).str() + ')(?:\\s+[^\\]]*)?\\]-->/')
	closure_1_fn := fn [mut var_counter, var_base_tokens] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_matches := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_base_token := rt.new_string('[' + (var_matches.array_get(1)).str() + ']')
	if var_base_tokens.array_isset(var_base_token) {
		mut var_placeholder := rt.new_string('PERSONALIZATION_TAG_PLACEHOLDER_' + (var_counter).str())
		this.personalization_tag_placeholders.array_set(var_placeholder, var_matches.array_get(0))
		rt.pre_inc(var_counter)
		return (var_placeholder).str()
	}
	return (var_matches.array_get(0)).str()
	}
	template_mutated = (rt.call_function('preg_replace_callback', [var_pattern.dup(), rt.new_closure(closure_1_fn), rt.new_string(template_mutated).dup()])).str()
	return if !(rt.new_string(template_mutated)).is_null() { template_mutated } else { '' }
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Renderer) restore_personalization_tags(text string) string {
	mut text_mutated := text
	if !rt.is_true(this.personalization_tag_placeholders) {
		return text_mutated
	}
	{
		mut iter_1 := this.personalization_tag_placeholders.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_html_comment := item_1.val
			mut var_placeholder := item_1.key
			text_mutated = (rt.call_function('str_replace', [var_placeholder.dup(), var_html_comment.dup(), rt.new_string(text_mutated).dup()])).str()
		}
	}
	return text_mutated
}

struct Class_WP_Style_Engine {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_renderer(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal, arg_5 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Renderer {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Renderer{
		PhpObjectBase: rt.PhpObjectBase{}
		theme_controller: rt.new_null()
		content_renderer: rt.new_null()
		templates: rt.new_null()
		css_inliner: rt.new_null()
		process_manager: rt.new_null()
		personalization_tags_registry: rt.new_null()
		personalization_tag_placeholders: rt.new_array()
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5)
	return obj
}

fn create_wp_style_engine() &Class_WP_Style_Engine {
	mut obj := &Class_WP_Style_Engine{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_html2text() &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Renderer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Css_Inliner](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry](if args.len > 4 { args[4] } else { rt.new_null() })
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Process_Manager](if args.len > 5 { args[5] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4, mut dispatch_arg_5)
			return rt.new_null()
		}
		'render' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_WP_Post](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
			return this.render(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5)
		}
		'inline_css_styles' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.inline_css_styles(dispatch_arg_0)
		}
		'render_text_version' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.render_text_version(dispatch_arg_0))
		}
		'preserve_personalization_tags' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.preserve_personalization_tags(dispatch_arg_0))
		}
		'restore_personalization_tags' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.restore_personalization_tags(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Renderer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'theme_controller' { return this.theme_controller }
		'content_renderer' { return this.content_renderer }
		'templates' { return this.templates }
		'css_inliner' { return this.css_inliner }
		'process_manager' { return this.process_manager }
		'personalization_tags_registry' { return this.personalization_tags_registry }
		'personalization_tag_placeholders' { return this.personalization_tag_placeholders }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Renderer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'theme_controller' { this.theme_controller = val; return true }
		'content_renderer' { this.content_renderer = val; return true }
		'templates' { this.templates = val; return true }
		'css_inliner' { this.css_inliner = val; return true }
		'process_manager' { this.process_manager = val; return true }
		'personalization_tags_registry' { this.personalization_tags_registry = val; return true }
		'personalization_tag_placeholders' { this.personalization_tag_placeholders = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_engine_renderer_class_renderer_php() {
	// unsupported statement: Stmt_Declare
}
