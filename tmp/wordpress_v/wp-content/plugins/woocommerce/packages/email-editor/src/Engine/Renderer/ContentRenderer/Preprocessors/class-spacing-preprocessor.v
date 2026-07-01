import rt

pub fn Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor.container_blocks() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'core/group' }, rt.ArrayItem{ key: none, val: 'core/post-content' }])
}
struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor {
	rt.PhpObjectBase
pub mut:
		post_content_block_names rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor) preprocess(mut var_parsed_blocks Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array, mut var_layout Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array, mut var_styles Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array) rt.PhpVal {
	mut var_parsed_blocks_mutated := var_parsed_blocks
	mut var_root_padding := this.get_root_padding(mut var_styles)
	mut var_container_padding := if !(var_styles.array_get('__container_padding')).is_null() { var_styles.array_get('__container_padding') } else { rt.new_array() }
	mut var_variables_map := if !(var_styles.array_get('__variables_map')).is_null() { var_styles.array_get('__variables_map') } else { rt.new_array() }
	var_parsed_blocks_mutated = this.add_block_gaps(mut var_parsed_blocks_mutated, (if !(var_styles.array_get('spacing').array_get('blockGap')).is_null() { var_styles.array_get('spacing').array_get('blockGap') } else { rt.new_string('') }).str(), rt.new_null(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](var_root_padding), false, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](var_container_padding), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](var_variables_map))
	return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array', []string{}, var_parsed_blocks_mutated)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor) get_block_horizontal_padding(mut var_block Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array, mut var_variables_map Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array) rt.PhpVal {
	mut var_block_mutated := var_block
	mut var_variables_map_mutated := var_variables_map
	mut var_padding := if !(var_block_mutated.array_get('attrs').array_get('style').array_get('spacing').array_get('padding')).is_null() { var_block_mutated.array_get('attrs').array_get('style').array_get('spacing').array_get('padding') } else { rt.new_array() }
	mut var_has_left := rt.new_bool(var_padding.array_isset(rt.new_string('left')))
	mut var_has_right := rt.new_bool(var_padding.array_isset(rt.new_string('right')))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_has_left)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_has_right)))))) {
		return rt.new_array()
	}
	mut var_left := if rt.is_true(var_has_left) { var_padding.array_get('left') } else { rt.new_string('0px') }
	mut var_right := if rt.is_true(var_has_right) { var_padding.array_get('right') } else { rt.new_string('0px') }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_left.dup().is_string()))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_right.dup().is_string()))))))) || rt.is_true(rt.call_function('preg_match', [rt.new_string('/[<>"\']/'), rt.concat(var_left, var_right)])))) {
		return rt.new_array()
	}
	var_left = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver{}; return temp.resolve(arg_0, arg_1) }(var_left.dup(), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array', []string{}, var_variables_map_mutated))
	var_right = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver{}; return temp.resolve(arg_0, arg_1) }(var_right.dup(), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array', []string{}, var_variables_map_mutated))
	if this.is_zero_value(var_left.dup()) && this.is_zero_value(var_right.dup()) {
		return rt.new_array()
	}
	return rt.create_array([rt.ArrayItem{ key: 'left', val: var_left }, rt.ArrayItem{ key: 'right', val: var_right }])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor) add_block_gaps(mut var_parsed_blocks Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array, gap string, var_parent_block rt.PhpVal, mut var_root_padding Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array, apply_root_padding bool, mut var_container_padding Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array, mut var_variables_map Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array) rt.PhpVal {
	mut var_parsed_blocks_mutated := var_parsed_blocks
	mut var_root_padding_mutated := var_root_padding
	mut var_container_padding_mutated := var_container_padding
	mut var_variables_map_mutated := var_variables_map
	{
		mut iter_1 := var_parsed_blocks_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block := item_1.val
			mut var_key := item_1.key
			mut var_block_name := if !(var_block.array_get('blockName')).is_null() { var_block.array_get('blockName') } else { rt.new_string('') }
			mut var_parent_block_name := if !(var_parent_block.array_get('blockName')).is_null() { var_parent_block.array_get('blockName') } else { rt.new_string('') }
			var_block.array_set('email_attrs', if !(var_block.array_get('email_attrs')).is_null() { var_block.array_get('email_attrs') } else { rt.new_array() })
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && var_gap.len > 0 && var_gap != '0')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				var_block.array_get_mut('email_attrs').array_set('margin-top', gap)
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('core/columns'), var_parent_block_name)) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				mut var_columns_gap := rt.new_string(this.get_columns_block_gap(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](var_parent_block), gap))
				if rt.is_true(var_columns_gap) {
					var_block.array_get_mut('email_attrs').array_set('padding-left', var_columns_gap.dup())
				}
			}
			mut var_is_root_level := rt.identical(rt.new_null(), var_parent_block)
			mut var_is_container := rt.call_function('in_array', [var_block_name.dup(), Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor.container_blocks(), rt.new_bool(true)])
			mut var_alignment := if !(var_block.array_get('attrs').array_get('align')).is_null() { var_block.array_get('attrs').array_get('align') } else { rt.new_null() }
			mut var_has_zero_padding := rt.new_bool(this.has_zero_horizontal_padding(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](var_block)))
			mut var_has_own_padding := rt.new_bool(this.has_explicit_horizontal_padding(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](var_block)))
			mut var_wraps_post_content := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(var_apply_root_padding && rt.is_true(var_is_container))) && this.contains_post_content(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](var_block))))
			mut var_should_apply := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(var_apply_root_padding || rt.is_true(rt.new_bool(rt.is_true(var_is_root_level) && rt.is_true(rt.new_bool(!(rt.is_true(var_is_container)))))))) || rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_is_root_level) && rt.is_true(var_is_container))) && rt.is_true(var_has_own_padding)))))
			mut var_post_content_block_names := this.get_post_content_block_names()
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_should_apply) && rt.is_true(rt.new_bool(!(rt.is_true(var_has_zero_padding)))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_block_name.dup(), var_post_content_block_names.dup(), rt.new_bool(true)]))))))) && rt.is_true(rt.new_bool(!(rt.is_true(var_wraps_post_content)))))) && !(!rt.is_true(var_root_padding_mutated)))) {
				var_block.array_get_mut('email_attrs').array_set('root-padding-left', var_root_padding_mutated.array_get('left'))
				var_block.array_get_mut('email_attrs').array_set('root-padding-right', var_root_padding_mutated.array_get('right'))
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_should_apply) && rt.is_true(rt.new_bool(!(rt.is_true(var_has_zero_padding)))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_block_name.dup(), var_post_content_block_names.dup(), rt.new_bool(true)]))))))) && rt.is_true(rt.new_bool(!(rt.is_true(var_wraps_post_content)))))) && !(!rt.is_true(var_container_padding_mutated)))) {
				var_block.array_get_mut('email_attrs').array_set('container-padding-left', var_container_padding_mutated.array_get('left'))
				var_block.array_get_mut('email_attrs').array_set('container-padding-right', var_container_padding_mutated.array_get('right'))
			}
			mut var_children_apply := rt.new_bool(rt.new_bool(false))
			mut var_children_container_pad := var_container_padding_mutated.dup()
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_is_root_level) && rt.is_true(var_is_container))) && rt.is_true(rt.new_bool(!(rt.is_true(var_has_own_padding)))))) {
				var_children_apply = rt.new_bool(rt.new_bool(true))
			} else if rt.is_true(rt.new_bool(var_apply_root_padding && rt.is_true(rt.call_function('in_array', [var_block_name.dup(), var_post_content_block_names.dup(), rt.new_bool(true)])))) {
				var_children_apply = rt.new_bool(rt.new_bool(true))
			} else if rt.is_true(var_wraps_post_content) {
				var_children_apply = rt.new_bool(rt.new_bool(true))
				mut var_block_padding := this.get_block_horizontal_padding(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](var_block), mut var_variables_map_mutated)
				if !(!rt.is_true(var_block_padding)) {
					var_children_container_pad = var_block_padding.dup()
					var_block.array_get_mut('email_attrs').array_set('suppress-horizontal-padding', true)
				}
			} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_is_root_level) && rt.is_true(var_is_container))) && rt.is_true(var_has_own_padding))) && rt.is_true(rt.new_bool(!(rt.is_true(var_has_zero_padding)))))) && this.contains_post_content(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](var_block)))) {
				var_children_apply = rt.new_bool(rt.new_bool(true))
				var_block_padding = this.get_block_horizontal_padding(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](var_block), mut var_variables_map_mutated)
				if !(!rt.is_true(var_block_padding)) {
					var_children_container_pad = var_block_padding.dup()
					var_block.array_get_mut('email_attrs').array_set('suppress-horizontal-padding', true)
				}
				var_block.array_get('email_attrs').array_unset(rt.new_string('root-padding-left'))
				var_block.array_get('email_attrs').array_unset(rt.new_string('root-padding-right'))
			}
			var_block.array_set('innerBlocks', this.add_block_gaps(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if !(var_block.array_get('innerBlocks')).is_null() { var_block.array_get('innerBlocks') } else { rt.new_array() }), gap, var_block.dup(), mut var_root_padding_mutated, (var_children_apply).to_bool(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](var_children_container_pad), mut var_variables_map_mutated))
			var_parsed_blocks_mutated.array_set(var_key, var_block.dup())
		}
	}
	return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array', []string{}, var_parsed_blocks_mutated)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor) get_post_content_block_names() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), this.post_content_block_names)) {
		this.post_content_block_names = rt.cast_array(rt.call_function('apply_filters', [rt.new_string('woocommerce_email_editor_post_content_block_names'), rt.create_array([rt.ArrayItem{ key: none, val: 'core/post-content' }])]))
	}
	return this.post_content_block_names
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor) contains_post_content(mut var_block Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array) bool {
	mut var_block_mutated := var_block
	mut var_post_content_block_names := this.get_post_content_block_names()
	{
		mut iter_1 := if !(var_block_mutated.array_get('innerBlocks')).is_null() { var_block_mutated.array_get('innerBlocks') } else { rt.new_array() }.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_inner_block := item_1.val
			mut var_name := if !(var_inner_block.array_get('blockName')).is_null() { var_inner_block.array_get('blockName') } else { rt.new_string('') }
			if rt.is_true(rt.call_function('in_array', [var_name.dup(), var_post_content_block_names.dup(), rt.new_bool(true)])) {
				return true
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [var_name.dup(), Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor.container_blocks(), rt.new_bool(true)])) && this.contains_post_content(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](var_inner_block)))) {
				return true
			}
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor) has_zero_horizontal_padding(mut var_block Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array) bool {
	mut var_block_mutated := var_block
	mut var_padding := if !(var_block_mutated.array_get('attrs').array_get('style').array_get('spacing').array_get('padding')).is_null() { var_block_mutated.array_get('attrs').array_get('style').array_get('spacing').array_get('padding') } else { rt.new_array() }
	mut var_left := if !(var_padding.array_get('left')).is_null() { var_padding.array_get('left') } else { rt.new_null() }
	mut var_right := if !(var_padding.array_get('right')).is_null() { var_padding.array_get('right') } else { rt.new_null() }
	return this.is_zero_value(var_left.dup()) || this.is_zero_value(var_right.dup())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor) has_explicit_horizontal_padding(mut var_block Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array) bool {
	mut var_block_mutated := var_block
	mut var_padding := if !(var_block_mutated.array_get('attrs').array_get('style').array_get('spacing').array_get('padding')).is_null() { var_block_mutated.array_get('attrs').array_get('style').array_get('spacing').array_get('padding') } else { rt.new_array() }
	return var_padding.array_isset(rt.new_string('left')) || var_padding.array_isset(rt.new_string('right'))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor) is_zero_value(var_value rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.dup().is_string()))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.dup().is_long() || var_value.dup().is_double()))))))) {
		return false
	}
	return (// unsupported expression: Expr_Cast_Bool).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor) get_root_padding(mut var_styles Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array) rt.PhpVal {
	mut var_padding := if !(var_styles.array_get('spacing').array_get('padding')).is_null() { var_styles.array_get('spacing').array_get('padding') } else { rt.new_array() }
	mut var_has_left := rt.new_bool(var_padding.array_isset(rt.new_string('left')))
	mut var_has_right := rt.new_bool(var_padding.array_isset(rt.new_string('right')))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_has_left)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_has_right)))))) {
		return rt.new_array()
	}
	mut var_left := if rt.is_true(var_has_left) { var_padding.array_get('left') } else { rt.new_string('0px') }
	mut var_right := if rt.is_true(var_has_right) { var_padding.array_get('right') } else { rt.new_string('0px') }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_left.dup().is_string()))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_right.dup().is_string()))))))) || rt.is_true(rt.call_function('preg_match', [rt.new_string('/[<>"\']/'), rt.concat(var_left, var_right)])))) {
		return rt.new_array()
	}
	return rt.create_array([rt.ArrayItem{ key: 'left', val: var_left }, rt.ArrayItem{ key: 'right', val: var_right }])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor) get_columns_block_gap(mut var_columns_block Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array, default_gap string) string {
	mut var_block_gap := if !(var_columns_block.array_get('attrs').array_get('style').array_get('spacing').array_get('blockGap')).is_null() { var_columns_block.array_get('attrs').array_get('style').array_get('spacing').array_get('blockGap') } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_block_gap.dup().is_array())) && var_block_gap.array_isset(rt.new_string('left')))) && rt.is_true(rt.new_bool(var_block_gap.array_get('left').is_string())))) {
		mut var_gap_value := var_block_gap.array_get('left')
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('/[<>"\']/'), var_gap_value.dup()])) {
			return (rt.new_null()).str()
		}
		return (var_gap_value).str()
	}
	if var_default_gap.len > 0 && var_default_gap != '0' {
		return default_gap
	}
	return (rt.new_null()).str()
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_preprocessors_spacing_preprocessor() &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor{
		PhpObjectBase: rt.PhpObjectBase{}
		post_content_block_names: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_preset_variable_resolver() &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'preprocess' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.preprocess(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'get_block_horizontal_padding' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.get_block_horizontal_padding(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'add_block_gaps' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 3 { args[3] } else { rt.new_null() })
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 5 { args[5] } else { rt.new_null() })
			mut dispatch_arg_6 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 6 { args[6] } else { rt.new_null() })
			return this.add_block_gaps(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3, dispatch_arg_4, mut dispatch_arg_5, mut dispatch_arg_6)
		}
		'get_post_content_block_names' {
			return this.get_post_content_block_names()
		}
		'contains_post_content' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.contains_post_content(mut dispatch_arg_0))
		}
		'has_zero_horizontal_padding' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.has_zero_horizontal_padding(mut dispatch_arg_0))
		}
		'has_explicit_horizontal_padding' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.has_explicit_horizontal_padding(mut dispatch_arg_0))
		}
		'is_zero_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_zero_value(dispatch_arg_0))
		}
		'get_root_padding' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_root_padding(mut dispatch_arg_0)
		}
		'get_columns_block_gap' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.get_columns_block_gap(mut dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'post_content_block_names' { return this.post_content_block_names }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'post_content_block_names' { this.post_content_block_names = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_engine_renderer_contentrenderer_preprocessors_class_spacing_preprocessor_php() {
	// unsupported statement: Stmt_Declare
}
