import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Process_Manager {
	rt.PhpObjectBase
pub mut:
	preprocessors  rt.PhpVal = rt.new_array()
	postprocessors rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Process_Manager) construct(mut var_cleanup_preprocessor Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Cleanup_Preprocessor, mut var_blocks_width_preprocessor Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Blocks_Width_Preprocessor, mut var_typography_preprocessor Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Typography_Preprocessor, mut var_spacing_preprocessor Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor, mut var_quote_preprocessor Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Quote_Preprocessor, mut var_highlighting_postprocessor Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Highlighting_Postprocessor, mut var_variables_postprocessor Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Variables_Postprocessor, mut var_border_style_postprocessor Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Border_Style_Postprocessor) {
	this.register_preprocessor(mut var_cleanup_preprocessor)
	this.register_preprocessor(mut var_spacing_preprocessor)
	this.register_preprocessor(mut var_blocks_width_preprocessor)
	this.register_preprocessor(mut var_typography_preprocessor)
	this.register_preprocessor(mut var_quote_preprocessor)
	this.register_postprocessor(mut var_highlighting_postprocessor)
	this.register_postprocessor(mut var_border_style_postprocessor)
	this.register_postprocessor(mut var_variables_postprocessor)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Process_Manager) preprocess(mut var_parsed_blocks Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_array, mut var_layout Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_array, mut var_styles Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_array) rt.PhpVal {
	mut var_parsed_blocks_mutated := var_parsed_blocks
	{
		mut iter_1 := this.preprocessors.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_preprocessor := item_1.val
			var_parsed_blocks_mutated = rt.call_method(var_preprocessor, 'preprocess', [
				var_parsed_blocks_mutated.dup(),
				var_layout,
				var_styles,
			])
		}
	}
	return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_array',
		[]string{}, var_parsed_blocks_mutated)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Process_Manager) postprocess(html string) string {
	mut html_mutated := html
	{
		mut iter_1 := this.postprocessors.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_postprocessor := item_1.val
			html_mutated = (rt.call_method(var_postprocessor, 'postprocess', [
				rt.new_string(html_mutated).dup()])).str()
		}
	}
	return html_mutated
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Process_Manager) register_preprocessor(mut var_preprocessor Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Preprocessor) {
	this.preprocessors.array_push(var_preprocessor.dup())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Process_Manager) register_postprocessor(mut var_postprocessor Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Postprocessor) {
	this.postprocessors.array_push(var_postprocessor.dup())
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_process_manager(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal, arg_5 rt.PhpVal, arg_6 rt.PhpVal, arg_7 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Process_Manager {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Process_Manager{
		PhpObjectBase:  rt.PhpObjectBase{}
		preprocessors:  rt.new_array()
		postprocessors: rt.new_array()
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Process_Manager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Cleanup_Preprocessor](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Blocks_Width_Preprocessor](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Typography_Preprocessor](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor](if args.len > 3 {
				args[3]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Quote_Preprocessor](if args.len > 4 {
				args[4]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Highlighting_Postprocessor](if args.len > 5 {
				args[5]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_6 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Variables_Postprocessor](if args.len > 6 {
				args[6]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_7 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Border_Style_Postprocessor](if args.len > 7 {
				args[7]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut
				dispatch_arg_3, mut dispatch_arg_4, mut dispatch_arg_5, mut dispatch_arg_6, mut
				dispatch_arg_7)
			return rt.new_null()
		}
		'preprocess' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return this.preprocess(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'postprocess' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.postprocess(dispatch_arg_0))
		}
		'register_preprocessor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Preprocessor](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.register_preprocessor(mut dispatch_arg_0)
			return rt.new_null()
		}
		'register_postprocessor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Postprocessor](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.register_postprocessor(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Process_Manager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'preprocessors' { return this.preprocessors }
		'postprocessors' { return this.postprocessors }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Process_Manager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'preprocessors' {
			this.preprocessors = val
			return true
		}
		'postprocessors' {
			this.postprocessors = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_engine_renderer_contentrenderer_class_process_manager_php() {
	// unsupported statement: Stmt_Declare
}
