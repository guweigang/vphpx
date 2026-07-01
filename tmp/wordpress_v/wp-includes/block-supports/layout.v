import rt

fn wp_get_block_style_variation_name_from_registered_style(class_name string, var_registered_styles rt.PhpVal) string {
	if !(var_class_name.len > 0 && var_class_name != '0') {
		return (rt.new_null()).str()
	}
	mut var_registered_names := rt.call_function('array_filter', [rt.call_function('array_column', [var_registered_styles.dup(), rt.new_string('name')])])
	mut var_prefix := 'is-style-'
	mut var_length := var_prefix.len
	{
		mut iter_1 := rt.call_function('explode', [rt.new_string(' '), rt.new_string(class_name)]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_class := item_1.val
			if rt.is_true(rt.call_function('str_starts_with', [var_class.dup(), rt.new_string(var_prefix).dup()])) {
				mut var_variation := rt.call_function('substr', [var_class.dup(), rt.new_int(var_length).dup()])
				if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.call_function('in_array', [var_variation.dup(), var_registered_names.dup(), rt.new_bool(true)])))) {
					return (var_variation).str()
				}
			}
		}
	}
	return (rt.new_null()).str()
}

fn wp_get_layout_definitions() rt.PhpVal {
	mut var_layout_definitions := rt.create_array([rt.ArrayItem{ key: 'default', val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'default' }, rt.ArrayItem{ key: 'slug', val: 'flow' }, rt.ArrayItem{ key: 'className', val: 'is-layout-flow' }, rt.ArrayItem{ key: 'baseStyles', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > .alignleft' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'float', val: 'left' }, rt.ArrayItem{ key: 'margin-inline-start', val: '0' }, rt.ArrayItem{ key: 'margin-inline-end', val: '2em' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > .alignright' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'float', val: 'right' }, rt.ArrayItem{ key: 'margin-inline-start', val: '2em' }, rt.ArrayItem{ key: 'margin-inline-end', val: '0' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > .aligncenter' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'margin-left', val: 'auto !important' }, rt.ArrayItem{ key: 'margin-right', val: 'auto !important' }]) }]) }]) }, rt.ArrayItem{ key: 'spacingStyles', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > :first-child' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'margin-block-start', val: '0' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > :last-child' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'margin-block-end', val: '0' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > *' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'margin-block-start', val: rt.new_null() }, rt.ArrayItem{ key: 'margin-block-end', val: '0' }]) }]) }]) }]) }, rt.ArrayItem{ key: 'constrained', val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'constrained' }, rt.ArrayItem{ key: 'slug', val: 'constrained' }, rt.ArrayItem{ key: 'className', val: 'is-layout-constrained' }, rt.ArrayItem{ key: 'baseStyles', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > .alignleft' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'float', val: 'left' }, rt.ArrayItem{ key: 'margin-inline-start', val: '0' }, rt.ArrayItem{ key: 'margin-inline-end', val: '2em' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > .alignright' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'float', val: 'right' }, rt.ArrayItem{ key: 'margin-inline-start', val: '2em' }, rt.ArrayItem{ key: 'margin-inline-end', val: '0' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > .aligncenter' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'margin-left', val: 'auto !important' }, rt.ArrayItem{ key: 'margin-right', val: 'auto !important' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > :where(:not(.alignleft):not(.alignright):not(.alignfull))' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'max-width', val: 'var(--wp--style--global--content-size)' }, rt.ArrayItem{ key: 'margin-left', val: 'auto !important' }, rt.ArrayItem{ key: 'margin-right', val: 'auto !important' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > .alignwide' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'max-width', val: 'var(--wp--style--global--wide-size)' }]) }]) }]) }, rt.ArrayItem{ key: 'spacingStyles', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > :first-child' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'margin-block-start', val: '0' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > :last-child' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'margin-block-end', val: '0' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > *' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'margin-block-start', val: rt.new_null() }, rt.ArrayItem{ key: 'margin-block-end', val: '0' }]) }]) }]) }]) }, rt.ArrayItem{ key: 'flex', val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'flex' }, rt.ArrayItem{ key: 'slug', val: 'flex' }, rt.ArrayItem{ key: 'className', val: 'is-layout-flex' }, rt.ArrayItem{ key: 'displayMode', val: 'flex' }, rt.ArrayItem{ key: 'baseStyles', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: '' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'flex-wrap', val: 'wrap' }, rt.ArrayItem{ key: 'align-items', val: 'center' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > :is(*, div)' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'margin', val: '0' }]) }]) }]) }, rt.ArrayItem{ key: 'spacingStyles', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: '' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'gap', val: rt.new_null() }]) }]) }]) }]) }, rt.ArrayItem{ key: 'grid', val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'grid' }, rt.ArrayItem{ key: 'slug', val: 'grid' }, rt.ArrayItem{ key: 'className', val: 'is-layout-grid' }, rt.ArrayItem{ key: 'displayMode', val: 'grid' }, rt.ArrayItem{ key: 'baseStyles', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > :is(*, div)' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'margin', val: '0' }]) }]) }]) }, rt.ArrayItem{ key: 'spacingStyles', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: '' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'gap', val: rt.new_null() }]) }]) }]) }]) }])
	return var_layout_definitions.dup()
}

fn wp_register_layout_support(var_block_type rt.PhpVal) {
	mut var_support_layout := rt.is_true(rt.call_function('block_has_support', [var_block_type.dup(), rt.new_string('layout'), rt.new_bool(false)])) || rt.is_true(rt.call_function('block_has_support', [var_block_type.dup(), rt.new_string('__experimentalLayout'), rt.new_bool(false)]))
	if var_support_layout {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_block_type, 'attributes'))))) {
			rt.set_property(var_block_type, 'attributes', rt.new_array())
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'attributes').array_isset(rt.new_string('layout'))))))) {
			rt.get_property(var_block_type, 'attributes').array_set('layout', rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }]))
		}
	}
}

fn wp_get_layout_style(selector string, var_layout rt.PhpVal, has_block_gap_support bool, var_gap_value rt.PhpVal, should_skip_gap_serialization bool, fallback_gap_value string, var_block_spacing rt.PhpVal) string {
	mut var_layout_type := if !(var_layout.array_get('type')).is_null() { var_layout.array_get('type') } else { rt.new_string('default') }
	mut var_layout_styles := rt.new_array()
	if rt.is_true(rt.identical(rt.new_string('default'), var_layout_type)) {
		if var_has_block_gap_support {
			if rt.is_true(rt.new_bool(var_gap_value.dup().is_array())) {
				var_gap_value = if !(var_gap_value.array_get('top')).is_null() { var_gap_value.array_get('top') } else { rt.new_null() }
			}
			if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && !(var_should_skip_gap_serialization))) {
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_gap_value.dup().is_string())) && rt.is_true(rt.call_function('str_contains', [var_gap_value.dup(), rt.new_string('var:preset|spacing|')])))) {
					mut var_index_to_splice := rt.add(rt.call_function('strrpos', [var_gap_value.dup(), rt.new_string('|')]), rt.new_int(1))
					mut var_slug := rt.call_function('_wp_to_kebab_case', [rt.call_function('substr', [var_gap_value.dup(), var_index_to_splice.dup()])])
					var_gap_value = rt.new_string(rt.new_string("var(--wp--preset--spacing--${var_slug.to_string()})"))
				}
				var_layout_styles.dup().array_push(rt.create_array([rt.ArrayItem{ key: 'selector', val: "${var_selector} > *" }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'margin-block-start', val: '0' }, rt.ArrayItem{ key: 'margin-block-end', val: '0' }]) }]))
			}
		}
	} else if rt.is_true(rt.identical(rt.new_string('constrained'), var_layout_type)) {
		mut var_content_size := if !(var_layout.array_get('contentSize')).is_null() { var_layout.array_get('contentSize') } else { rt.new_string('') }
		mut var_wide_size := if !(var_layout.array_get('wideSize')).is_null() { var_layout.array_get('wideSize') } else { rt.new_string('') }
		mut var_justify_content := if !(var_layout.array_get('justifyContent')).is_null() { var_layout.array_get('justifyContent') } else { rt.new_string('center') }
		mut var_all_max_width_value := if rt.is_true(var_content_size) { var_content_size } else { var_wide_size }
		mut var_wide_max_width_value := if rt.is_true(var_wide_size) { var_wide_size } else { var_content_size }
		var_all_max_width_value = rt.call_function('safecss_filter_attr', [rt.call_function('explode', [rt.new_string(';'), var_all_max_width_value.dup()]).array_get(0)])
		var_wide_max_width_value = rt.call_function('safecss_filter_attr', [rt.call_function('explode', [rt.new_string(';'), var_wide_max_width_value.dup()]).array_get(0)])
		mut var_margin_left := if rt.is_true(rt.identical(rt.new_string('left'), var_justify_content)) { '0 !important' } else { 'auto !important' }
		mut var_margin_right := if rt.is_true(rt.identical(rt.new_string('right'), var_justify_content)) { '0 !important' } else { 'auto !important' }
		if rt.is_true(rt.new_bool(rt.is_true(var_content_size) || rt.is_true(var_wide_size))) {
			var_layout_styles.dup().array_push(rt.create_array([rt.ArrayItem{ key: 'selector', val: "${var_selector} > :where(:not(.alignleft):not(.alignright):not(.alignfull))" }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'max-width', val: var_all_max_width_value }, rt.ArrayItem{ key: 'margin-left', val: var_margin_left }, rt.ArrayItem{ key: 'margin-right', val: var_margin_right }]) }]))
		}
		if !(var_block_spacing).is_null() {
			mut var_block_spacing_values := rt.call_function('wp_style_engine_get_styles', [rt.create_array([rt.ArrayItem{ key: 'spacing', val: var_block_spacing }])])
			if var_block_spacing_values.array_get('declarations').array_isset(rt.new_string('padding-right')) {
				mut var_padding_right := var_block_spacing_values.array_get('declarations').array_get('padding-right')
				if rt.is_true(rt.identical(rt.new_string('0'), var_padding_right)) {
					var_padding_right = rt.new_string(rt.new_string('0px'))
				}
				var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: "${var_selector} > .alignfull" }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'margin-right', val: "calc(${var_padding_right.to_string()} * -1)" }]) }])
			}
			if var_block_spacing_values.array_get('declarations').array_isset(rt.new_string('padding-left')) {
				mut var_padding_left := var_block_spacing_values.array_get('declarations').array_get('padding-left')
				if rt.is_true(rt.identical(rt.new_string('0'), var_padding_left)) {
					var_padding_left = rt.new_string(rt.new_string('0px'))
				}
				var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: "${var_selector} > .alignfull" }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'margin-left', val: "calc(${var_padding_left.to_string()} * -1)" }]) }])
			}
		}
		if rt.is_true(rt.identical(rt.new_string('left'), var_justify_content)) {
			var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: "${var_selector} > :where(:not(.alignleft):not(.alignright):not(.alignfull))" }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'margin-left', val: '0 !important' }]) }])
		}
		if rt.is_true(rt.identical(rt.new_string('right'), var_justify_content)) {
			var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: "${var_selector} > :where(:not(.alignleft):not(.alignright):not(.alignfull))" }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'margin-right', val: '0 !important' }]) }])
		}
		if var_has_block_gap_support {
			if rt.is_true(rt.new_bool(var_gap_value.dup().is_array())) {
				var_gap_value = if !(var_gap_value.array_get('top')).is_null() { var_gap_value.array_get('top') } else { rt.new_null() }
			}
			if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && !(var_should_skip_gap_serialization))) {
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_gap_value.dup().is_string())) && rt.is_true(rt.call_function('str_contains', [var_gap_value.dup(), rt.new_string('var:preset|spacing|')])))) {
					var_index_to_splice = rt.add(rt.call_function('strrpos', [var_gap_value.dup(), rt.new_string('|')]), rt.new_int(1))
					var_slug = rt.call_function('_wp_to_kebab_case', [rt.call_function('substr', [var_gap_value.dup(), var_index_to_splice.dup()])])
					var_gap_value = rt.new_string(rt.new_string("var(--wp--preset--spacing--${var_slug.to_string()})"))
				}
				var_layout_styles.dup().array_push(rt.create_array([rt.ArrayItem{ key: 'selector', val: "${var_selector} > *" }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'margin-block-start', val: '0' }, rt.ArrayItem{ key: 'margin-block-end', val: '0' }]) }]))
			}
		}
	} else if rt.is_true(rt.identical(rt.new_string('flex'), var_layout_type)) {
		mut var_layout_orientation := if !(var_layout.array_get('orientation')).is_null() { var_layout.array_get('orientation') } else { rt.new_string('horizontal') }
		mut var_justify_content_options := rt.create_array([rt.ArrayItem{ key: 'left', val: 'flex-start' }, rt.ArrayItem{ key: 'right', val: 'flex-end' }, rt.ArrayItem{ key: 'center', val: 'center' }])
		mut var_vertical_alignment_options := rt.create_array([rt.ArrayItem{ key: 'top', val: 'flex-start' }, rt.ArrayItem{ key: 'center', val: 'center' }, rt.ArrayItem{ key: 'bottom', val: 'flex-end' }])
		if rt.is_true(rt.identical(rt.new_string('horizontal'), var_layout_orientation)) {
			// unsupported expression: Expr_AssignOp_Plus
			// unsupported expression: Expr_AssignOp_Plus
		} else {
			// unsupported expression: Expr_AssignOp_Plus
			// unsupported expression: Expr_AssignOp_Plus
		}
		if rt.is_true(rt.new_bool(!(!rt.is_true(var_layout.array_get('flexWrap'))) && rt.is_true(rt.identical(rt.new_string('nowrap'), var_layout.array_get('flexWrap'))))) {
			var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: selector }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'flex-wrap', val: 'nowrap' }]) }])
		}
		if var_has_block_gap_support && !(var_gap_value).is_null() {
			mut var_combined_gap_value := ''
			mut var_gap_sides := if rt.is_true(rt.new_bool(var_gap_value.dup().is_array())) { rt.create_array([rt.ArrayItem{ key: none, val: 'top' }, rt.ArrayItem{ key: none, val: 'left' }]) } else { rt.create_array([rt.ArrayItem{ key: none, val: 'top' }]) }
			{
				mut iter_1 := var_gap_sides.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_gap_side := item_1.val
					mut var_process_value := var_gap_value.dup()
					if rt.is_true(rt.new_bool(var_gap_value.dup().is_array())) {
						if rt.is_true(rt.new_bool(rt.new_string(fallback_gap_value).is_array())) {
							mut var_fallback_value := if !(rt.new_string(fallback_gap_value).array_get(var_gap_side)).is_null() { rt.new_string(fallback_gap_value).array_get(var_gap_side) } else { rt.call_function('reset', [rt.new_string(fallback_gap_value)]) }
						} else {
							var_fallback_value = rt.new_string(rt.new_string(fallback_gap_value)).dup()
						}
						var_process_value = if !(var_gap_value.array_get(var_gap_side)).is_null() { var_gap_value.array_get(var_gap_side) } else { var_fallback_value }
					}
					if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_process_value.dup().is_string())) && rt.is_true(rt.call_function('str_contains', [var_process_value.dup(), rt.new_string('var:preset|spacing|')])))) {
						var_index_to_splice = rt.add(rt.call_function('strrpos', [var_process_value.dup(), rt.new_string('|')]), rt.new_int(1))
						var_slug = rt.call_function('_wp_to_kebab_case', [rt.call_function('substr', [var_process_value.dup(), var_index_to_splice.dup()])])
						var_process_value = rt.new_string(rt.new_string("var(--wp--preset--spacing--${var_slug.to_string()})"))
					}
					// unsupported expression: Expr_AssignOp_Concat
				}
			}
			var_gap_value = rt.new_string(rt.new_string(var_combined_gap_value.trim_space()))
			if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && !(var_should_skip_gap_serialization))) {
				var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: selector }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'gap', val: var_gap_value }]) }])
			}
		}
		if rt.is_true(rt.identical(rt.new_string('horizontal'), var_layout_orientation)) {
			if rt.is_true(rt.new_bool(!(!rt.is_true(var_layout.array_get('justifyContent'))) && rt.is_true(rt.new_bool(var_justify_content_options.dup().array_isset(var_layout.array_get('justifyContent')))))) {
				var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: selector }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'justify-content', val: var_justify_content_options.array_get(var_layout.array_get('justifyContent')) }]) }])
			}
			if rt.is_true(rt.new_bool(!(!rt.is_true(var_layout.array_get('verticalAlignment'))) && rt.is_true(rt.new_bool(var_vertical_alignment_options.dup().array_isset(var_layout.array_get('verticalAlignment')))))) {
				var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: selector }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'align-items', val: var_vertical_alignment_options.array_get(var_layout.array_get('verticalAlignment')) }]) }])
			}
		} else {
			var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: selector }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'flex-direction', val: 'column' }]) }])
			if rt.is_true(rt.new_bool(!(!rt.is_true(var_layout.array_get('justifyContent'))) && rt.is_true(rt.new_bool(var_justify_content_options.dup().array_isset(var_layout.array_get('justifyContent')))))) {
				var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: selector }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'align-items', val: var_justify_content_options.array_get(var_layout.array_get('justifyContent')) }]) }])
			} else {
				var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: selector }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'align-items', val: 'flex-start' }]) }])
			}
			if rt.is_true(rt.new_bool(!(!rt.is_true(var_layout.array_get('verticalAlignment'))) && rt.is_true(rt.new_bool(var_vertical_alignment_options.dup().array_isset(var_layout.array_get('verticalAlignment')))))) {
				var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: selector }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'justify-content', val: var_vertical_alignment_options.array_get(var_layout.array_get('verticalAlignment')) }]) }])
			}
		}
	} else if rt.is_true(rt.identical(rt.new_string('grid'), var_layout_type)) {
		if rt.is_true(rt.new_bool(rt.new_string(fallback_gap_value).is_array())) {
			mut var_responsive_gap_value := if !(rt.new_string(fallback_gap_value).array_get('left')).is_null() { rt.new_string(fallback_gap_value).array_get('left') } else { rt.call_function('reset', [rt.new_string(fallback_gap_value)]) }
		} else {
			var_responsive_gap_value = rt.new_string(rt.new_string(fallback_gap_value)).dup()
		}
		if var_has_block_gap_support && !(var_gap_value).is_null() {
			var_combined_gap_value = ''
			var_gap_sides = if rt.is_true(rt.new_bool(var_gap_value.dup().is_array())) { rt.create_array([rt.ArrayItem{ key: none, val: 'top' }, rt.ArrayItem{ key: none, val: 'left' }]) } else { rt.create_array([rt.ArrayItem{ key: none, val: 'top' }]) }
			{
				mut iter_1 := var_gap_sides.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_gap_side := item_1.val
					mut var_process_value := var_gap_value.dup()
					if rt.is_true(rt.new_bool(var_gap_value.dup().is_array())) {
						if rt.is_true(rt.new_bool(rt.new_string(fallback_gap_value).is_array())) {
							mut var_fallback_value := if !(rt.new_string(fallback_gap_value).array_get(var_gap_side)).is_null() { rt.new_string(fallback_gap_value).array_get(var_gap_side) } else { rt.call_function('reset', [rt.new_string(fallback_gap_value)]) }
						} else {
							var_fallback_value = rt.new_string(rt.new_string(fallback_gap_value)).dup()
						}
						var_process_value = if !(var_gap_value.array_get(var_gap_side)).is_null() { var_gap_value.array_get(var_gap_side) } else { var_fallback_value }
					}
					if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_process_value.dup().is_string())) && rt.is_true(rt.call_function('str_contains', [var_process_value.dup(), rt.new_string('var:preset|spacing|')])))) {
						var_index_to_splice = rt.add(rt.call_function('strrpos', [var_process_value.dup(), rt.new_string('|')]), rt.new_int(1))
						var_slug = rt.call_function('_wp_to_kebab_case', [rt.call_function('substr', [var_process_value.dup(), var_index_to_splice.dup()])])
						var_process_value = rt.new_string(rt.new_string("var(--wp--preset--spacing--${var_slug.to_string()})"))
					}
					// unsupported expression: Expr_AssignOp_Concat
				}
			}
			var_gap_value = rt.new_string(rt.new_string(var_combined_gap_value.trim_space()))
			var_responsive_gap_value = var_gap_value.dup()
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('0'), var_responsive_gap_value)) || rt.is_true(rt.identical(rt.new_int(0), var_responsive_gap_value)))) {
			var_responsive_gap_value = rt.new_string(rt.new_string('0px'))
		}
		if !(!rt.is_true(var_layout.array_get('columnCount'))) && !(!rt.is_true(var_layout.array_get('minimumColumnWidth'))) {
			mut var_max_value := rt.new_string( +  + (.array_get()).str() + ' - 1))) /' + (var_layout.array_get('columnCount')).str() + ')')
			var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: selector }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'grid-template-columns', val:  + ().str() + ', 1fr))' }, rt.ArrayItem{ key: 'container-type', val: 'inline-size' }]) }])
			if !(!rt.is_true(var_layout.array_get('rowCount'))) {
				var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: selector }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: , val:  }]) }])
			}
		} else if !(!rt.is_true(var_layout.array_get('columnCount'))) {
			var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: selector }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: , val:  }]) }])
			if !(!rt.is_true(var_layout.array_get('rowCount'))) {
				 << 
			}
		} else {
			mut var_minimum_column_width := 
			
		}
		if rt.is_true() {
		}
	}
	if !(!rt.is_true(var_layout_styles)) {
		return ().str()
	}
	return 
}



pub fn init_wp_includes_block_supports_layout_php() {
}
