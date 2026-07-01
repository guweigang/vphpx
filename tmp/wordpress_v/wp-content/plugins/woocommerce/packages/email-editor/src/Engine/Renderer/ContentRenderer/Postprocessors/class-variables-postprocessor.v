import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Variables_Postprocessor {
	rt.PhpObjectBase
pub mut:
		theme_controller rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Variables_Postprocessor) construct(mut var_theme_controller Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller)  {
	this.theme_controller = var_theme_controller.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Variables_Postprocessor) postprocess(html string) string {
	mut var_variables := rt.call_method(this.theme_controller, 'get_variables_values_map', []rt.PhpVal{})
	mut var_replacements := rt.new_array()
	{
		mut iter_1 := var_variables.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_name := item_1.key
			mut var_var_pattern := rt.new_string('/' + (rt.call_function('preg_quote', ['var(' + (var_name).str() + ')', rt.new_string('/')])).str() + '/i')
			var_replacements.array_set(var_var_pattern, var_value.dup())
		}
	}
	mut var_processor := create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_postprocessors_wp_html_tag_processor(rt.new_string(html).dup())
	for rt.is_true(var_processor.next_tag()) {
		mut var_style := var_processor.get_attribute(rt.new_string('style'))
		if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			mut var_processed_style := rt.call_function('preg_replace', [rt.func_array_keys(var_replacements.dup()), rt.call_function('array_values', [var_replacements.dup()]), var_style.dup()])
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				var_processor.set_attribute(rt.new_string('style'), var_processed_style.dup())
			}
		}
	}
	return (var_processor.get_updated_html()).str()
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_postprocessors_variables_postprocessor(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Variables_Postprocessor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Variables_Postprocessor{
		PhpObjectBase: rt.PhpObjectBase{}
		theme_controller: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_postprocessors_wp_html_tag_processor() &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_WP_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Variables_Postprocessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'postprocess' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.postprocess(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Variables_Postprocessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'theme_controller' { return this.theme_controller }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Variables_Postprocessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'theme_controller' { this.theme_controller = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_engine_renderer_contentrenderer_postprocessors_class_variables_postprocessor_php() {
	// unsupported statement: Stmt_Declare
}
