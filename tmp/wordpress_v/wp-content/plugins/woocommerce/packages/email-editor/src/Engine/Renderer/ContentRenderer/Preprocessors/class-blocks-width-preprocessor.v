import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Blocks_Width_Preprocessor {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Blocks_Width_Preprocessor) preprocess(mut var_parsed_blocks Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array, mut var_layout Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array, mut var_styles Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array) rt.PhpVal {
	mut var_parsed_blocks_mutated := var_parsed_blocks
	mut var_variables_map := if !(var_styles.array_get('__variables_map')).is_null() { var_styles.array_get('__variables_map') } else { rt.new_array() }
	var_styles.array_get_mut('spacing').array_get_mut('padding').array_set('left', '0px')
	var_styles.array_get_mut('spacing').array_get_mut('padding').array_set('right', '0px')
	return this.calculate_widths(mut var_parsed_blocks_mutated, mut var_layout, mut var_styles, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](var_variables_map))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Blocks_Width_Preprocessor) calculate_widths(mut var_parsed_blocks Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array, mut var_layout Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array, mut var_styles Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array, mut var_variables_map Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array) rt.PhpVal {
	mut var_parsed_blocks_mutated := var_parsed_blocks
	mut var_variables_map_mutated := var_variables_map
	{
		mut iter_1 := var_parsed_blocks_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block := item_1.val
			mut var_key := item_1.key
			mut var_layout_width := rt.new_float(this.parse_number_from_string_with_pixels((var_layout.array_get('contentSize')).str()))
			mut var_alignment := if !(var_block.array_get('attrs').array_get('align')).is_null() { var_block.array_get('attrs').array_get('align') } else { rt.new_null() }
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				// unsupported expression: Expr_AssignOp_Minus
				// unsupported expression: Expr_AssignOp_Minus
			}
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				// unsupported expression: Expr_AssignOp_Minus
				// unsupported expression: Expr_AssignOp_Minus
				// unsupported expression: Expr_AssignOp_Minus
				// unsupported expression: Expr_AssignOp_Minus
			}
			mut var_suppress_h_padding := rt.new_bool(rt.new_bool(!(!rt.is_true(var_block.array_get('email_attrs').array_get('suppress-horizontal-padding')))))
			mut var_block_padding_left := if rt.is_true(var_suppress_h_padding) { rt.new_string('0px') } else { fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver{}; return temp.resolve(arg_0, arg_1) }(if !(var_block.array_get('attrs').array_get('style').array_get('spacing').array_get('padding').array_get('left')).is_null() { var_block.array_get('attrs').array_get('style').array_get('spacing').array_get('padding').array_get('left') } else { rt.new_string('0px') }, rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array', []string{}, var_variables_map_mutated)) }
			mut var_block_padding_right := if rt.is_true(var_suppress_h_padding) { rt.new_string('0px') } else { fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver{}; return temp.resolve(arg_0, arg_1) }(if !(var_block.array_get('attrs').array_get('style').array_get('spacing').array_get('padding').array_get('right')).is_null() { var_block.array_get('attrs').array_get('style').array_get('spacing').array_get('padding').array_get('right') } else { rt.new_string('0px') }, rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array', []string{}, var_variables_map_mutated)) }
			mut var_width_input := if !(var_block.array_get('attrs').array_get('width')).is_null() { var_block.array_get('attrs').array_get('width') } else { rt.new_string('100%') }
			var_width_input = if rt.is_true(rt.new_bool(var_width_input.dup().is_long() || var_width_input.dup().is_double())) { rt.new_string("${var_width_input.to_string()}%") } else { var_width_input }
			var_width_input = if rt.is_true(rt.new_bool(var_width_input.dup().is_string())) { var_width_input } else { rt.new_string('100%') }
			mut var_width := rt.new_float(this.convert_width_to_pixels((var_width_input).str(), (var_layout_width).to_f64()))
			if rt.is_true(rt.identical(rt.new_string('core/columns'), var_block.array_get('blockName'))) {
				mut var_columns_width := var_layout_width.dup()
				// unsupported expression: Expr_AssignOp_Minus
				// unsupported expression: Expr_AssignOp_Minus
				mut var_border_width := if !(var_block.array_get('attrs').array_get('style').array_get('border').array_get('width')).is_null() { var_block.array_get('attrs').array_get('style').array_get('border').array_get('width') } else { rt.new_string('0px') }
				// unsupported expression: Expr_AssignOp_Minus
				// unsupported expression: Expr_AssignOp_Minus
				var_block.array_set('innerBlocks', this.add_missing_column_widths(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](var_block.array_get('innerBlocks')), (var_columns_width).to_f64(), mut var_variables_map_mutated))
			}
			mut var_modified_layout := var_layout
			var_modified_layout.array_set('contentSize', "${var_width.to_string()}px")
			mut var_modified_styles := var_styles
			var_modified_styles.array_get_mut('spacing').array_get_mut('padding').array_set('left', var_block_padding_left.dup())
			var_modified_styles.array_get_mut('spacing').array_get_mut('padding').array_set('right', var_block_padding_right.dup())
			var_block.array_get_mut('email_attrs').array_set('width', "${var_width.to_string()}px")
			var_block.array_set('innerBlocks', this.calculate_widths(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](var_block.array_get('innerBlocks')), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](var_modified_layout), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](var_modified_styles), mut var_variables_map_mutated))
			var_parsed_blocks_mutated.array_set(var_key, var_block.dup())
		}
	}
	return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array', []string{}, var_parsed_blocks_mutated)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Blocks_Width_Preprocessor) convert_width_to_pixels(current_width string, layout_width f64) f64 {
	mut layout_width_mutated := layout_width
	mut var_width := rt.new_float(rt.new_float(layout_width_mutated)).dup()
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_width = // unsupported expression: Expr_Cast_Double
		var_width = rt.call_function('round', [var_width / 100 * layout_width_mutated])
	} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_width = rt.new_float(this.parse_number_from_string_with_pixels(current_width))
	}
	return (var_width).to_f64()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Blocks_Width_Preprocessor) parse_number_from_string_with_pixels(value string) f64 {
	return (// unsupported expression: Expr_Cast_Double).to_f64()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Blocks_Width_Preprocessor) add_missing_column_widths(mut var_columns Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array, columns_width f64, mut var_variables_map Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array) rt.PhpVal {
	mut columns_width_mutated := columns_width
	mut var_variables_map_mutated := var_variables_map
	mut var_columns_count_with_defined_width := rt.new_int(rt.new_int(0))
	mut var_defined_column_width := rt.new_int(rt.new_int(0))
	mut var_columns_count := rt.new_int(rt.new_int(var_columns.array_count()))
	{
		mut iter_1 := var_columns.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_column := item_1.val
			if var_column.array_get('attrs').array_isset(rt.new_string('width')) && !(!rt.is_true(var_column.array_get('attrs').array_get('width'))) {
				rt.pre_inc(var_columns_count_with_defined_width)
				// unsupported expression: Expr_AssignOp_Plus
			} else {
				// unsupported expression: Expr_AssignOp_Plus
				// unsupported expression: Expr_AssignOp_Plus
				mut var_border_width := if !(var_column.array_get('attrs').array_get('style').array_get('border').array_get('width')).is_null() { var_column.array_get('attrs').array_get('style').array_get('border').array_get('width') } else { rt.new_string('0px') }
				// unsupported expression: Expr_AssignOp_Plus
				// unsupported expression: Expr_AssignOp_Plus
			}
		}
	}
	if rt.is_true(rt.greater(rt.sub(var_columns_count, var_columns_count_with_defined_width), rt.new_int(0))) {
		mut var_default_columns_width := rt.call_function('round', [columns_width_mutated - var_defined_column_width / var_columns_count - var_columns_count_with_defined_width, rt.new_int(2)])
		{
			mut iter_1 := var_columns.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_column := item_1.val
				mut var_key := item_1.key
				if !(var_column.array_get('attrs').array_isset(rt.new_string('width'))) || !rt.is_true(var_column.array_get('attrs').array_get('width')) {
					mut var_column_width := var_default_columns_width.dup()
					// unsupported expression: Expr_AssignOp_Plus
					// unsupported expression: Expr_AssignOp_Plus
					mut var_border_width := if !(var_column.array_get('attrs').array_get('style').array_get('border').array_get('width')).is_null() { var_column.array_get('attrs').array_get('style').array_get('border').array_get('width') } else { rt.new_string('0px') }
					// unsupported expression: Expr_AssignOp_Plus
					// unsupported expression: Expr_AssignOp_Plus
					var_columns.array_get_mut(var_key).array_get_mut('attrs').array_set('width', "${var_column_width.to_string()}px")
				}
			}
		}
	}
	return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array', []string{}, var_columns)
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_preprocessors_blocks_width_preprocessor() &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Blocks_Width_Preprocessor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Blocks_Width_Preprocessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_preset_variable_resolver() &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Blocks_Width_Preprocessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'preprocess' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.preprocess(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'calculate_widths' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 3 { args[3] } else { rt.new_null() })
			return this.calculate_widths(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3)
		}
		'convert_width_to_pixels' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_f64()
			return rt.new_float(this.convert_width_to_pixels(dispatch_arg_0, dispatch_arg_1))
		}
		'parse_number_from_string_with_pixels' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_float(this.parse_number_from_string_with_pixels(dispatch_arg_0))
		}
		'add_missing_column_widths' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_f64()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.add_missing_column_widths(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Blocks_Width_Preprocessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Blocks_Width_Preprocessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_engine_renderer_contentrenderer_preprocessors_class_blocks_width_preprocessor_php() {
	// unsupported statement: Stmt_Declare
}
