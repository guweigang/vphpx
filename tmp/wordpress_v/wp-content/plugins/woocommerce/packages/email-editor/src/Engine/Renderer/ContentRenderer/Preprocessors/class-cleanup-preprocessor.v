import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Cleanup_Preprocessor {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Cleanup_Preprocessor) preprocess(mut var_parsed_blocks Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array, mut var_layout Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array, mut var_styles Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array) rt.PhpVal {
	{
		mut iter_1 := var_parsed_blocks.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(
				rt.is_true(rt.identical(rt.new_null(), var_block.array_get('blockName')))
				&& rt.is_true(rt.identical(rt.new_string(''), rt.new_string(if !(var_block.array_get('innerHTML')).is_null() { var_block.array_get('innerHTML') } else { rt.new_string('') }.to_string().trim_space())))))
			{
				var_parsed_blocks.array_unset(var_key)
			}
		}
	}
	return rt.call_function('array_values', [var_parsed_blocks])
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_preprocessors_cleanup_preprocessor() &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Cleanup_Preprocessor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Cleanup_Preprocessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Cleanup_Preprocessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'preprocess' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return this.preprocess(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Cleanup_Preprocessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Cleanup_Preprocessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_engine_renderer_contentrenderer_preprocessors_class_cleanup_preprocessor_php() {
	// unsupported statement: Stmt_Declare
}
