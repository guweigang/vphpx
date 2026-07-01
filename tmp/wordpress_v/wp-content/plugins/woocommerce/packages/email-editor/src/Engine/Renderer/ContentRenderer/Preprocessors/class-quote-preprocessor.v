import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Quote_Preprocessor {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Quote_Preprocessor) preprocess(mut var_parsed_blocks Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array, mut var_layout Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array, mut var_styles Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array) rt.PhpVal {
	return this.process_blocks(mut var_parsed_blocks, mut var_styles)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Quote_Preprocessor) process_blocks(mut var_blocks Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array, mut var_styles Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array) rt.PhpVal {
	{
		mut iter_1 := var_blocks.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block := item_1.val
			if !(var_block.array_isset(rt.new_string('innerBlocks'))) {
				continue
			}
			if rt.is_true(rt.identical(rt.new_string('core/quote'), var_block.array_get('blockName'))) {
				mut var_quote_align := if !(var_block.array_get('attrs').array_get('textAlign')).is_null() { var_block.array_get('attrs').array_get('textAlign') } else { rt.new_null() }
				mut var_quote_typography := if !(var_block.array_get('attrs').array_get('style').array_get('typography')).is_null() { var_block.array_get('attrs').array_get('style').array_get('typography') } else { rt.new_array() }
				var_block.array_set('innerBlocks', this.apply_alignment_to_children(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](var_block.array_get('innerBlocks')), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_?string](var_quote_align)))
				var_block.array_set('innerBlocks', this.apply_typography_to_children(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](var_block.array_get('innerBlocks')), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](var_quote_typography), mut var_styles))
			}
			var_block.array_set('innerBlocks', this.process_blocks(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](var_block.array_get('innerBlocks')), mut var_styles))
		}
	}
	return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array', []string{}, var_blocks)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Quote_Preprocessor) apply_alignment_to_children(mut var_blocks Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array, mut var_text_align Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_?string) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_text_align)))) {
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array', []string{}, var_blocks)
	}
	{
		mut iter_1 := var_blocks.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block := item_1.val
			if !(var_block.array_get('attrs').array_isset(rt.new_string('textAlign'))) && !(var_block.array_get('attrs').array_isset(rt.new_string('align'))) {
				if !(var_block.array_isset(rt.new_string('attrs'))) {
					var_block.array_set('attrs', rt.new_array())
				}
				var_block.array_get_mut('attrs').array_set('textAlign', var_text_align.dup())
			}
			if var_block.array_isset(rt.new_string('innerBlocks')) {
				var_block.array_set('innerBlocks', this.apply_alignment_to_children(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](var_block.array_get('innerBlocks')), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_?string](if !(var_block.array_get('attrs').array_get('textAlign')).is_null() { var_block.array_get('attrs').array_get('textAlign') } else { var_block.array_get('attrs').array_get('align') })))
			}
		}
	}
	return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array', []string{}, var_blocks)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Quote_Preprocessor) apply_typography_to_children(mut var_blocks Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array, mut var_quote_typography Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array, mut var_styles Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array) rt.PhpVal {
	mut var_quote_typography_mutated := var_quote_typography
	mut var_default_typography := if !(var_styles.array_get('blocks').array_get('core/quote').array_get('typography')).is_null() { var_styles.array_get('blocks').array_get('core/quote').array_get('typography') } else { rt.new_array() }
	mut var_merged_typography := rt.call_function('array_merge', [var_default_typography.dup(), var_quote_typography_mutated.dup()])
	if !rt.is_true(var_merged_typography) {
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array', []string{}, var_blocks)
	}
	{
		mut iter_1 := var_blocks.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block := item_1.val
			if rt.is_true(rt.identical(rt.new_string('core/paragraph'), var_block.array_get('blockName'))) {
				if !(var_block.array_isset(rt.new_string('attrs'))) {
					var_block.array_set('attrs', rt.new_array())
				}
				if !(var_block.array_get('attrs').array_isset(rt.new_string('style'))) {
					var_block.array_get_mut('attrs').array_set('style', rt.new_array())
				}
				if !(var_block.array_get('attrs').array_get('style').array_isset(rt.new_string('typography'))) {
					var_block.array_get_mut('attrs').array_get_mut('style').array_set('typography', rt.new_array())
				}
				var_block.array_get_mut('attrs').array_get_mut('style').array_set('typography', rt.call_function('array_merge', [var_merged_typography.dup(), var_block.array_get('attrs').array_get('style').array_get('typography')]))
			}
		}
	}
	return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array', []string{}, var_blocks)
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_preprocessors_quote_preprocessor() &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Quote_Preprocessor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Quote_Preprocessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Quote_Preprocessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'preprocess' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.preprocess(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'process_blocks' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.process_blocks(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'apply_alignment_to_children' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.apply_alignment_to_children(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'apply_typography_to_children' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.apply_typography_to_children(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Quote_Preprocessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Quote_Preprocessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_engine_renderer_contentrenderer_preprocessors_class_quote_preprocessor_php() {
	// unsupported statement: Stmt_Declare
}
