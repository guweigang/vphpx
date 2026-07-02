import rt

fn wp_get_block_style_variation_name_from_registered_style(class_name string, var_registered_styles rt.PhpVal) string {
	mut var_class_name := class_name
	mut var_registered_names := rt.new_null()
	mut var_prefix := ''
	mut var_length := i64(0)
	mut var_class := rt.new_null()
	mut var_variation := rt.new_null()
	if !(var_class_name.len > 0 && var_class_name != '0') {
		return (rt.new_null()).str()
	}
	var_registered_names = rt.call_function('array_filter', [rt.call_function('array_column', [var_registered_styles.clone(), rt.new_string('name')])])
	var_prefix = 'is-style-'
	var_length = var_prefix.len
	mut iter_1 := rt.call_function('explode', [rt.new_string(' '), rt.new_string(class_name)]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_class_shadow := item_1.val
		if rt.is_true(rt.call_function('str_starts_with', [var_class_shadow.clone(), rt.new_string((var_prefix).str()).clone()])) {
			var_variation = rt.call_function('substr', [var_class_shadow.clone(), rt.new_int(var_length).clone()])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('default'), var_variation)))) && rt.is_true(rt.call_function('in_array', [var_variation.clone(), var_registered_names.clone(), rt.new_bool(true)])) {
				return (var_variation).str()
			}
		}
	}
	return (rt.new_null()).str()
}

fn wp_get_layout_definitions() rt.PhpVal {
	mut var_layout_definitions := rt.new_null()
	var_layout_definitions = rt.create_array([rt.ArrayItem{ key: 'default', val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'default' }, rt.ArrayItem{ key: 'slug', val: 'flow' }, rt.ArrayItem{ key: 'className', val: 'is-layout-flow' }, rt.ArrayItem{ key: 'baseStyles', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > .alignleft' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'float', val: 'left' }, rt.ArrayItem{ key: 'margin-inline-start', val: '0' }, rt.ArrayItem{ key: 'margin-inline-end', val: '2em' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > .alignright' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'float', val: 'right' }, rt.ArrayItem{ key: 'margin-inline-start', val: '2em' }, rt.ArrayItem{ key: 'margin-inline-end', val: '0' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > .aligncenter' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'margin-left', val: 'auto !important' }, rt.ArrayItem{ key: 'margin-right', val: 'auto !important' }]) }]) }]) }, rt.ArrayItem{ key: 'spacingStyles', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > :first-child' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'margin-block-start', val: '0' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > :last-child' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'margin-block-end', val: '0' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > *' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'margin-block-start', val: rt.new_null() }, rt.ArrayItem{ key: 'margin-block-end', val: '0' }]) }]) }]) }]) }, rt.ArrayItem{ key: 'constrained', val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'constrained' }, rt.ArrayItem{ key: 'slug', val: 'constrained' }, rt.ArrayItem{ key: 'className', val: 'is-layout-constrained' }, rt.ArrayItem{ key: 'baseStyles', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > .alignleft' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'float', val: 'left' }, rt.ArrayItem{ key: 'margin-inline-start', val: '0' }, rt.ArrayItem{ key: 'margin-inline-end', val: '2em' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > .alignright' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'float', val: 'right' }, rt.ArrayItem{ key: 'margin-inline-start', val: '2em' }, rt.ArrayItem{ key: 'margin-inline-end', val: '0' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > .aligncenter' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'margin-left', val: 'auto !important' }, rt.ArrayItem{ key: 'margin-right', val: 'auto !important' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > :where(:not(.alignleft):not(.alignright):not(.alignfull))' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'max-width', val: 'var(--wp--style--global--content-size)' }, rt.ArrayItem{ key: 'margin-left', val: 'auto !important' }, rt.ArrayItem{ key: 'margin-right', val: 'auto !important' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > .alignwide' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'max-width', val: 'var(--wp--style--global--wide-size)' }]) }]) }]) }, rt.ArrayItem{ key: 'spacingStyles', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > :first-child' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'margin-block-start', val: '0' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > :last-child' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'margin-block-end', val: '0' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > *' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'margin-block-start', val: rt.new_null() }, rt.ArrayItem{ key: 'margin-block-end', val: '0' }]) }]) }]) }]) }, rt.ArrayItem{ key: 'flex', val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'flex' }, rt.ArrayItem{ key: 'slug', val: 'flex' }, rt.ArrayItem{ key: 'className', val: 'is-layout-flex' }, rt.ArrayItem{ key: 'displayMode', val: 'flex' }, rt.ArrayItem{ key: 'baseStyles', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: '' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'flex-wrap', val: 'wrap' }, rt.ArrayItem{ key: 'align-items', val: 'center' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > :is(*, div)' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'margin', val: '0' }]) }]) }]) }, rt.ArrayItem{ key: 'spacingStyles', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: '' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'gap', val: rt.new_null() }]) }]) }]) }]) }, rt.ArrayItem{ key: 'grid', val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'grid' }, rt.ArrayItem{ key: 'slug', val: 'grid' }, rt.ArrayItem{ key: 'className', val: 'is-layout-grid' }, rt.ArrayItem{ key: 'displayMode', val: 'grid' }, rt.ArrayItem{ key: 'baseStyles', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: ' > :is(*, div)' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'margin', val: '0' }]) }]) }]) }, rt.ArrayItem{ key: 'spacingStyles', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'selector', val: '' }, rt.ArrayItem{ key: 'rules', val: rt.create_array([rt.ArrayItem{ key: 'gap', val: rt.new_null() }]) }]) }]) }]) }])
	return var_layout_definitions.clone()
}

fn wp_register_layout_support(var_block_type rt.PhpVal) {
	mut var_support_layout := false
	var_support_layout = rt.is_true(rt.call_function('block_has_support', [var_block_type.clone(), rt.new_string('layout'), rt.new_bool(false)])) || rt.is_true(rt.call_function('block_has_support', [var_block_type.clone(), rt.new_string('__experimentalLayout'), rt.new_bool(false)]))
	if var_support_layout {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_block_type, 'attributes'))))) {
			rt.set_property(var_block_type, 'attributes', rt.new_array())
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'attributes').array_isset(rt.new_string('layout'))))))) {
			rt.get_property(var_block_type, 'attributes').array_set('layout', rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }]))
		}
	}
}

fn wp_get_layout_style(selector string, var_layout rt.PhpVal, has_block_gap_support bool, var_gap_value_arg rt.PhpVal, should_skip_gap_serialization bool, fallback_gap_value string, var_block_spacing rt.PhpVal) string {
	mut var_selector := selector
	mut var_has_block_gap_support := has_block_gap_support
	mut var_should_skip_gap_serialization := should_skip_gap_serialization
	mut var_fallback_gap_value := fallback_gap_value
	mut var_gap_value := var_gap_value_arg
	mut var_layout_type := rt.new_null()
	mut var_layout_styles := []rt.PhpVal{}
	mut var_index_to_splice := rt.new_null()
	mut var_slug := rt.new_null()
	mut var_content_size := rt.new_null()
	mut var_wide_size := rt.new_null()
	mut var_justify_content := rt.new_null()
	mut var_all_max_width_value := rt.new_null()
	mut var_wide_max_width_value := rt.new_null()
	mut var_margin_left := ''
	mut var_margin_right := ''
	mut var_block_spacing_values := rt.new_null()
	mut var_padding_right := rt.new_null()
	mut var_padding_left := rt.new_null()
	mut var_layout_orientation := rt.new_null()
	mut var_justify_content_options := rt.new_null()
	mut var_vertical_alignment_options := rt.new_null()
	mut var_combined_gap_value := ''
	mut var_gap_sides := rt.new_null()
	mut var_gap_side := rt.new_null()
	mut var_process_value := rt.new_null()
	mut var_fallback_value := rt.new_null()
	mut var_responsive_gap_value := rt.new_null()
	mut var_max_value := rt.new_null()
	mut var_minimum_column_width := rt.new_null()
	var_layout_type = if !(var_layout.array_get(rt.new_string('type'))).is_null() { var_layout.array_get(rt.new_string('type')) } else { rt.new_string('default') }
	var_layout_styles = rt.new_array()
	if rt.is_true(rt.identical(rt.new_string('default'), var_layout_type)) {
		if var_has_block_gap_support {
			if rt.is_true(rt.new_bool(var_gap_value.clone().is_array())) {
			var_gap_value = if !(var_gap_value.array_get(rt.new_string('top'))).is_null() { var_gap_value.array_get(rt.new_string('top')) } else { rt.new_null() }
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_gap_value)))) && !(var_should_skip_gap_serialization) {
				if var_gap_value.clone().is_string() && rt.is_true(rt.call_function('str_contains', [var_gap_value.clone(), rt.new_string('var:preset|spacing|')])) {
				var_index_to_splice = rt.add(rt.call_function('strrpos', [var_gap_value.clone(), rt.new_string('|')]), rt.new_int(1))
				var_slug = rt.call_function('_wp_to_kebab_case', [rt.call_function('substr', [var_gap_value.clone(), var_index_to_splice.clone()])])
				var_gap_value = rt.new_string("var(--wp--preset--spacing--${var_slug.to_string()})")
				}
				rt.create_array_from_list(var_layout_styles).array_push(rt.create_array([rt.ArrayItem{ key: 'selector', val: "${var_selector} > *" }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'margin-block-start', val: '0' }, rt.ArrayItem{ key: 'margin-block-end', val: '0' }]) }]))
			}
		}
	} else if rt.is_true(rt.identical(rt.new_string('constrained'), var_layout_type)) {
		var_content_size = if !(var_layout.array_get(rt.new_string('contentSize'))).is_null() { var_layout.array_get(rt.new_string('contentSize')) } else { rt.new_string('') }
		var_wide_size = if !(var_layout.array_get(rt.new_string('wideSize'))).is_null() { var_layout.array_get(rt.new_string('wideSize')) } else { rt.new_string('') }
		var_justify_content = if !(var_layout.array_get(rt.new_string('justifyContent'))).is_null() { var_layout.array_get(rt.new_string('justifyContent')) } else { rt.new_string('center') }
		var_all_max_width_value = if rt.is_true(var_content_size) { var_content_size } else { var_wide_size }
		var_wide_max_width_value = if rt.is_true(var_wide_size) { var_wide_size } else { var_content_size }
		var_all_max_width_value = rt.call_function('safecss_filter_attr', [rt.call_function('explode', [rt.new_string(';'), var_all_max_width_value.clone()]).array_get(rt.new_int(0))])
		var_wide_max_width_value = rt.call_function('safecss_filter_attr', [rt.call_function('explode', [rt.new_string(';'), var_wide_max_width_value.clone()]).array_get(rt.new_int(0))])
		var_margin_left = if rt.is_true(rt.identical(rt.new_string('left'), var_justify_content)) { '0 !important' } else { 'auto !important' }
		var_margin_right = if rt.is_true(rt.identical(rt.new_string('right'), var_justify_content)) { '0 !important' } else { 'auto !important' }
		if rt.is_true(var_content_size) || rt.is_true(var_wide_size) {
			rt.create_array_from_list(var_layout_styles).array_push(rt.create_array([rt.ArrayItem{ key: 'selector', val: "${var_selector} > :where(:not(.alignleft):not(.alignright):not(.alignfull))" }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'max-width', val: var_all_max_width_value }, rt.ArrayItem{ key: 'margin-left', val: var_margin_left }, rt.ArrayItem{ key: 'margin-right', val: var_margin_right }]) }]))
		}
		if !(var_block_spacing).is_null() {
			var_block_spacing_values = rt.call_function('wp_style_engine_get_styles', [rt.create_array([rt.ArrayItem{ key: 'spacing', val: var_block_spacing }])])
			if var_block_spacing_values.array_get(rt.new_string('declarations')).array_isset(rt.new_string('padding-right')) {
				var_padding_right = var_block_spacing_values.array_get(rt.new_string('declarations')).array_get(rt.new_string('padding-right'))
				if rt.is_true(rt.identical(rt.new_string('0'), var_padding_right)) {
				var_padding_right = rt.new_string('0px')
				}
				var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: "${var_selector} > .alignfull" }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'margin-right', val: "calc(${var_padding_right.to_string()} * -1)" }]) }])
			}
			if var_block_spacing_values.array_get(rt.new_string('declarations')).array_isset(rt.new_string('padding-left')) {
				var_padding_left = var_block_spacing_values.array_get(rt.new_string('declarations')).array_get(rt.new_string('padding-left'))
				if rt.is_true(rt.identical(rt.new_string('0'), var_padding_left)) {
				var_padding_left = rt.new_string('0px')
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
			if rt.is_true(rt.new_bool(var_gap_value.clone().is_array())) {
			var_gap_value = if !(var_gap_value.array_get(rt.new_string('top'))).is_null() { var_gap_value.array_get(rt.new_string('top')) } else { rt.new_null() }
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_gap_value)))) && !(var_should_skip_gap_serialization) {
				if var_gap_value.clone().is_string() && rt.is_true(rt.call_function('str_contains', [var_gap_value.clone(), rt.new_string('var:preset|spacing|')])) {
				var_index_to_splice = rt.add(rt.call_function('strrpos', [var_gap_value.clone(), rt.new_string('|')]), rt.new_int(1))
				var_slug = rt.call_function('_wp_to_kebab_case', [rt.call_function('substr', [var_gap_value.clone(), var_index_to_splice.clone()])])
				var_gap_value = rt.new_string("var(--wp--preset--spacing--${var_slug.to_string()})")
				}
				rt.create_array_from_list(var_layout_styles).array_push(rt.create_array([rt.ArrayItem{ key: 'selector', val: "${var_selector} > *" }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'margin-block-start', val: '0' }, rt.ArrayItem{ key: 'margin-block-end', val: '0' }]) }]))
			}
		}
	} else if rt.is_true(rt.identical(rt.new_string('flex'), var_layout_type)) {
		var_layout_orientation = if !(var_layout.array_get(rt.new_string('orientation'))).is_null() { var_layout.array_get(rt.new_string('orientation')) } else { rt.new_string('horizontal') }
		var_justify_content_options = rt.create_array([rt.ArrayItem{ key: 'left', val: 'flex-start' }, rt.ArrayItem{ key: 'right', val: 'flex-end' }, rt.ArrayItem{ key: 'center', val: 'center' }])
		var_vertical_alignment_options = rt.create_array([rt.ArrayItem{ key: 'top', val: 'flex-start' }, rt.ArrayItem{ key: 'center', val: 'center' }, rt.ArrayItem{ key: 'bottom', val: 'flex-end' }])
		if rt.is_true(rt.identical(rt.new_string('horizontal'), var_layout_orientation)) {
			var_justify_content_options = rt.add(var_justify_content_options, rt.create_array([rt.ArrayItem{ key: 'space-between', val: 'space-between' }]))
			var_vertical_alignment_options = rt.add(var_vertical_alignment_options, rt.create_array([rt.ArrayItem{ key: 'stretch', val: 'stretch' }]))
		} else {
			var_justify_content_options = rt.add(var_justify_content_options, rt.create_array([rt.ArrayItem{ key: 'stretch', val: 'stretch' }]))
			var_vertical_alignment_options = rt.add(var_vertical_alignment_options, rt.create_array([rt.ArrayItem{ key: 'space-between', val: 'space-between' }]))
		}
		if !(!rt.is_true(var_layout.array_get(rt.new_string('flexWrap')))) && rt.is_true(rt.identical(rt.new_string('nowrap'), var_layout.array_get(rt.new_string('flexWrap')))) {
			var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: selector }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'flex-wrap', val: 'nowrap' }]) }])
		}
		if var_has_block_gap_support && !(var_gap_value).is_null() {
			var_combined_gap_value = ''
			var_gap_sides = if var_gap_value.clone().is_array() { rt.create_array([rt.ArrayItem{ key: none, val: 'top' }, rt.ArrayItem{ key: none, val: 'left' }]) } else { rt.create_array([rt.ArrayItem{ key: none, val: 'top' }]) }
			mut iter_2 := var_gap_sides.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_gap_side_shadow := item_2.val
				var_process_value = var_gap_value.clone()
				if rt.is_true(rt.new_bool(var_gap_value.clone().is_array())) {
					if rt.is_true(rt.new_bool(rt.new_string(fallback_gap_value).is_array())) {
					var_fallback_value = if !(rt.new_string(fallback_gap_value).array_get(var_gap_side_shadow)).is_null() { rt.new_string(fallback_gap_value).array_get(var_gap_side_shadow) } else { rt.call_function('reset', [rt.new_string(fallback_gap_value)]) }
					} else {
					var_fallback_value = rt.new_string(fallback_gap_value)
					}
				var_process_value = if !(var_gap_value.array_get(var_gap_side_shadow)).is_null() { var_gap_value.array_get(var_gap_side_shadow) } else { var_fallback_value }
				}
				if var_process_value.clone().is_string() && rt.is_true(rt.call_function('str_contains', [var_process_value.clone(), rt.new_string('var:preset|spacing|')])) {
				var_index_to_splice = rt.add(rt.call_function('strrpos', [var_process_value.clone(), rt.new_string('|')]), rt.new_int(1))
				var_slug = rt.call_function('_wp_to_kebab_case', [rt.call_function('substr', [var_process_value.clone(), var_index_to_splice.clone()])])
				var_process_value = rt.new_string("var(--wp--preset--spacing--${var_slug.to_string()})")
				}
				var_combined_gap_value = var_combined_gap_value + "${var_process_value.to_string()} "
			}
			var_gap_value = rt.new_string(var_combined_gap_value.trim_space())
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_gap_value)))) && !(var_should_skip_gap_serialization) {
				var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: selector }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'gap', val: var_gap_value }]) }])
			}
		}
		if rt.is_true(rt.identical(rt.new_string('horizontal'), var_layout_orientation)) {
			if !(!rt.is_true(var_layout.array_get(rt.new_string('justifyContent')))) && rt.is_true(rt.new_bool(var_justify_content_options.clone().array_isset(var_layout.array_get(rt.new_string('justifyContent'))))) {
				var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: selector }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'justify-content', val: var_justify_content_options.array_get(var_layout.array_get(rt.new_string('justifyContent'))) }]) }])
			}
			if !(!rt.is_true(var_layout.array_get(rt.new_string('verticalAlignment')))) && rt.is_true(rt.new_bool(var_vertical_alignment_options.clone().array_isset(var_layout.array_get(rt.new_string('verticalAlignment'))))) {
				var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: selector }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'align-items', val: var_vertical_alignment_options.array_get(var_layout.array_get(rt.new_string('verticalAlignment'))) }]) }])
			}
		} else {
			var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: selector }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'flex-direction', val: 'column' }]) }])
			if !(!rt.is_true(var_layout.array_get(rt.new_string('justifyContent')))) && rt.is_true(rt.new_bool(var_justify_content_options.clone().array_isset(var_layout.array_get(rt.new_string('justifyContent'))))) {
				var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: selector }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'align-items', val: var_justify_content_options.array_get(var_layout.array_get(rt.new_string('justifyContent'))) }]) }])
			} else {
				var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: selector }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'align-items', val: 'flex-start' }]) }])
			}
			if !(!rt.is_true(var_layout.array_get(rt.new_string('verticalAlignment')))) && rt.is_true(rt.new_bool(var_vertical_alignment_options.clone().array_isset(var_layout.array_get(rt.new_string('verticalAlignment'))))) {
				var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: selector }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'justify-content', val: var_vertical_alignment_options.array_get(var_layout.array_get(rt.new_string('verticalAlignment'))) }]) }])
			}
		}
	} else if rt.is_true(rt.identical(rt.new_string('grid'), var_layout_type)) {
		if rt.is_true(rt.new_bool(rt.new_string(fallback_gap_value).is_array())) {
		var_responsive_gap_value = if !(rt.new_string(fallback_gap_value).array_get(rt.new_string('left'))).is_null() { rt.new_string(fallback_gap_value).array_get(rt.new_string('left')) } else { rt.call_function('reset', [rt.new_string(fallback_gap_value)]) }
		} else {
		var_responsive_gap_value = rt.new_string(fallback_gap_value)
		}
		if var_has_block_gap_support && !(var_gap_value).is_null() {
			var_combined_gap_value = ''
			var_gap_sides = if var_gap_value.clone().is_array() { rt.create_array([rt.ArrayItem{ key: none, val: 'top' }, rt.ArrayItem{ key: none, val: 'left' }]) } else { rt.create_array([rt.ArrayItem{ key: none, val: 'top' }]) }
			mut iter_3 := var_gap_sides.iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_gap_side_shadow := item_3.val
				var_process_value = var_gap_value.clone()
				if rt.is_true(rt.new_bool(var_gap_value.clone().is_array())) {
					if rt.is_true(rt.new_bool(rt.new_string(fallback_gap_value).is_array())) {
					var_fallback_value = if !(rt.new_string(fallback_gap_value).array_get(var_gap_side_shadow)).is_null() { rt.new_string(fallback_gap_value).array_get(var_gap_side_shadow) } else { rt.call_function('reset', [rt.new_string(fallback_gap_value)]) }
					} else {
					var_fallback_value = rt.new_string(fallback_gap_value)
					}
				var_process_value = if !(var_gap_value.array_get(var_gap_side_shadow)).is_null() { var_gap_value.array_get(var_gap_side_shadow) } else { var_fallback_value }
				}
				if var_process_value.clone().is_string() && rt.is_true(rt.call_function('str_contains', [var_process_value.clone(), rt.new_string('var:preset|spacing|')])) {
				var_index_to_splice = rt.add(rt.call_function('strrpos', [var_process_value.clone(), rt.new_string('|')]), rt.new_int(1))
				var_slug = rt.call_function('_wp_to_kebab_case', [rt.call_function('substr', [var_process_value.clone(), var_index_to_splice.clone()])])
				var_process_value = rt.new_string("var(--wp--preset--spacing--${var_slug.to_string()})")
				}
				var_combined_gap_value = var_combined_gap_value + "${var_process_value.to_string()} "
			}
		var_gap_value = rt.new_string(var_combined_gap_value.trim_space())
		var_responsive_gap_value = var_gap_value.clone()
		}
		if rt.is_true(rt.identical(rt.new_string('0'), var_responsive_gap_value)) || rt.is_true(rt.identical(rt.new_int(0), var_responsive_gap_value)) {
		var_responsive_gap_value = rt.new_string('0px')
		}
		if !(!rt.is_true(var_layout.array_get(rt.new_string('columnCount')))) && !(!rt.is_true(var_layout.array_get(rt.new_string('minimumColumnWidth')))) {
			var_max_value = rt.new_string('max(min(' + (var_layout.array_get(rt.new_string('minimumColumnWidth'))).str() + ', 100%), (100% - (' + (var_responsive_gap_value).str() + ' * (' + (var_layout.array_get(rt.new_string('columnCount'))).str() + ' - 1))) /' + (var_layout.array_get(rt.new_string('columnCount'))).str() + ')')
			var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: selector }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'grid-template-columns', val: 'repeat(auto-fill, minmax(' + (var_max_value).str() + ', 1fr))' }, rt.ArrayItem{ key: 'container-type', val: 'inline-size' }]) }])
			if !(!rt.is_true(var_layout.array_get(rt.new_string('rowCount')))) {
				var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: selector }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'grid-template-rows', val: 'repeat(' + (var_layout.array_get(rt.new_string('rowCount'))).str() + ', minmax(1rem, auto))' }]) }])
			}
		} else if !(!rt.is_true(var_layout.array_get(rt.new_string('columnCount')))) {
			var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: selector }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'grid-template-columns', val: 'repeat(' + (var_layout.array_get(rt.new_string('columnCount'))).str() + ', minmax(0, 1fr))' }]) }])
			if !(!rt.is_true(var_layout.array_get(rt.new_string('rowCount')))) {
				var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: selector }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'grid-template-rows', val: 'repeat(' + (var_layout.array_get(rt.new_string('rowCount'))).str() + ', minmax(1rem, auto))' }]) }])
			}
		} else {
			var_minimum_column_width = if !(!rt.is_true(var_layout.array_get(rt.new_string('minimumColumnWidth')))) { var_layout.array_get(rt.new_string('minimumColumnWidth')) } else { rt.new_string('12rem') }
			var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: selector }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'grid-template-columns', val: 'repeat(auto-fill, minmax(min(' + (var_minimum_column_width).str() + ', 100%), 1fr))' }, rt.ArrayItem{ key: 'container-type', val: 'inline-size' }]) }])
		}
		if var_has_block_gap_support && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_gap_value)))) && !(var_should_skip_gap_serialization) {
			var_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: selector }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'gap', val: var_gap_value }]) }])
		}
	}
	if !(!rt.is_true(var_layout_styles)) {
		return (rt.call_function('wp_style_engine_get_stylesheet_from_css_rules', [rt.create_array_from_list(var_layout_styles), rt.create_array([rt.ArrayItem{ key: 'context', val: 'block-supports' }, rt.ArrayItem{ key: 'prettify', val: false }])])).str()
	}
	return ''
}

fn wp_render_layout_support_flag(var_block_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_block_type := rt.new_null()
	mut var_block_supports_layout := false
	mut var_child_layout := rt.new_null()
	mut var_outer_class_names := []rt.PhpVal{}
	mut var_container_content_class := rt.new_null()
	mut var_child_layout_declarations := map[string]rt.PhpVal{}
	mut var_child_layout_styles := []rt.PhpVal{}
	mut var_self_stretch := rt.new_null()
	mut var_column_span := rt.new_null()
	mut var_row_span := rt.new_null()
	mut var_column_span_number := f64(0.0)
	mut var_parent_column_width := rt.new_null()
	mut var_parent_column_value := rt.new_null()
	mut var_parent_column_unit := rt.new_null()
	mut var_default_gap_value := rt.new_null()
	mut var_container_query_value := rt.new_null()
	mut var_child_css := rt.new_null()
	mut var_processor := rt.new_null()
	mut var_class_name := rt.new_null()
	mut var_global_settings := rt.new_null()
	mut var_fallback_layout := rt.new_null()
	mut var_used_layout := rt.new_null()
	mut var_class_names := []rt.PhpVal{}
	mut var_layout_definitions := rt.new_null()
	mut var_root_padding_aware_alignments := rt.new_null()
	mut var_layout_classname := rt.new_null()
	mut var_gap_value := rt.new_null()
	mut var_value := rt.new_null()
	mut var_key := rt.new_null()
	mut var_fallback_gap_value := rt.new_null()
	mut var_block_spacing := rt.new_null()
	mut var_should_skip_gap_serialization := rt.new_null()
	mut var_block_gap := rt.new_null()
	mut var_has_block_gap_support := rt.new_null()
	mut var_block_name := rt.new_null()
	mut var_global_styles := rt.new_null()
	mut var_variation_block_gap_value := rt.new_null()
	mut var_block_class_name := rt.new_null()
	mut var_styles_registry := rt.new_null()
	mut var_registered_styles := rt.new_null()
	mut var_variation_name := ''
	mut var_global_block_gap_value := rt.new_null()
	mut var_container_class := rt.new_null()
	mut var_style := ''
	mut var_split_block_name := rt.new_null()
	mut var_full_block_name := rt.new_null()
	mut var_outer_class_name := rt.new_null()
	mut var_inner_block_wrapper_classes := rt.new_null()
	mut var_first_chunk := rt.new_null()
	mut var_first_chunk_processor := rt.new_null()
	mut var_class_attribute := rt.new_null()
	mut iife_temp_0 := Class_WP_Block_Type_Registry{}
	mut iife_result_0 := iife_temp_0.get_instance()
	var_block_type = rt.call_method(iife_result_0, 'get_registered', [var_block.array_get(rt.new_string('blockName'))])
	var_block_supports_layout = rt.is_true(rt.call_function('block_has_support', [var_block_type.clone(), rt.new_string('layout'), rt.new_bool(false)])) || rt.is_true(rt.call_function('block_has_support', [var_block_type.clone(), rt.new_string('__experimentalLayout'), rt.new_bool(false)]))
	var_child_layout = if !(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('style')).array_get(rt.new_string('layout'))).is_null() { var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('style')).array_get(rt.new_string('layout')) } else { rt.new_null() }
	if !(var_block_supports_layout) && rt.is_true(rt.new_bool(!(rt.is_true(var_child_layout)))) {
		return var_block_content.clone()
	}
	var_outer_class_names = rt.new_array()
	if rt.is_true(var_child_layout) {
		var_container_content_class = rt.call_function('wp_unique_id_from_values', [rt.create_array([rt.ArrayItem{ key: 'layout', val: rt.call_function('array_intersect_key', [if !(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('style')).array_get(rt.new_string('layout'))).is_null() { var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('style')).array_get(rt.new_string('layout')) } else { rt.new_array() }, rt.call_function('array_flip', [rt.create_array([rt.ArrayItem{ key: none, val: 'selfStretch' }, rt.ArrayItem{ key: none, val: 'flexSize' }, rt.ArrayItem{ key: none, val: 'columnStart' }, rt.ArrayItem{ key: none, val: 'columnSpan' }, rt.ArrayItem{ key: none, val: 'rowStart' }, rt.ArrayItem{ key: none, val: 'rowSpan' }])])]) }, rt.ArrayItem{ key: 'parentLayout', val: rt.call_function('array_intersect_key', [if !(var_block.array_get(rt.new_string('parentLayout'))).is_null() { var_block.array_get(rt.new_string('parentLayout')) } else { rt.new_array() }, rt.call_function('array_flip', [rt.create_array([rt.ArrayItem{ key: none, val: 'minimumColumnWidth' }, rt.ArrayItem{ key: none, val: 'columnCount' }])])]) }]), rt.new_string('wp-container-content-')])
		var_child_layout_declarations = rt.new_array()
		var_child_layout_styles = rt.new_array()
		var_self_stretch = if !(var_child_layout.array_get(rt.new_string('selfStretch'))).is_null() { var_child_layout.array_get(rt.new_string('selfStretch')) } else { rt.new_null() }
		if rt.is_true(rt.identical(rt.new_string('fixed'), var_self_stretch)) && var_child_layout.array_isset(rt.new_string('flexSize')) {
			var_child_layout_declarations['flex-basis'] = var_child_layout.array_get(rt.new_string('flexSize'))
			var_child_layout_declarations['box-sizing'] = rt.new_string('border-box')
		} else if rt.is_true(rt.identical(rt.new_string('fill'), var_self_stretch)) {
			var_child_layout_declarations['flex-grow'] = rt.new_string('1')
		}
		if var_child_layout.array_isset(rt.new_string('columnSpan')) {
			var_column_span = var_child_layout.array_get(rt.new_string('columnSpan'))
			var_child_layout_declarations['grid-column'] = rt.new_string("span ${var_column_span.to_string()}")
		}
		if var_child_layout.array_isset(rt.new_string('rowSpan')) {
			var_row_span = var_child_layout.array_get(rt.new_string('rowSpan'))
			var_child_layout_declarations['grid-row'] = rt.new_string("span ${var_row_span.to_string()}")
		}
		var_child_layout_styles << rt.create_array([rt.ArrayItem{ key: 'selector', val: ".${var_container_content_class.to_string()}" }, rt.ArrayItem{ key: 'declarations', val: var_child_layout_declarations }])
		if var_child_layout.array_isset(rt.new_string('columnSpan')) && var_block.array_get(rt.new_string('parentLayout')).array_isset(rt.new_string('minimumColumnWidth')) || !(var_block.array_get(rt.new_string('parentLayout')).array_isset(rt.new_string('columnCount'))) {
			var_column_span_number = var_child_layout.array_get(rt.new_string('columnSpan')).to_f64()
			var_parent_column_width = if !(var_block.array_get(rt.new_string('parentLayout')).array_get(rt.new_string('minimumColumnWidth'))).is_null() { var_block.array_get(rt.new_string('parentLayout')).array_get(rt.new_string('minimumColumnWidth')) } else { rt.new_string('12rem') }
			var_parent_column_value = rt.new_float(var_parent_column_width.clone().to_f64())
			var_parent_column_unit = rt.call_function('explode', [var_parent_column_value.clone(), var_parent_column_width.clone()])
			if var_parent_column_unit.clone().array_count() <= 1 {
			var_parent_column_unit = rt.new_string('rem')
			var_parent_column_value = rt.new_int(12)
			} else {
				var_parent_column_unit = var_parent_column_unit.array_get(rt.new_int(1))
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_parent_column_unit.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'px' }, rt.ArrayItem{ key: none, val: 'rem' }, rt.ArrayItem{ key: none, val: 'em' }]), rt.new_bool(true)]))))) {
				var_parent_column_unit = rt.new_string('rem')
				}
			}
			var_default_gap_value = if rt.is_true(rt.identical(rt.new_string('px'), var_parent_column_unit)) { rt.new_int(24) } else { rt.new_float(1.5) }
			var_container_query_value = rt.new_float(var_column_span_number * var_parent_column_value + var_column_span_number - 1 * var_default_gap_value)
			var_container_query_value = rt.new_string((var_container_query_value).str() + (var_parent_column_unit).str())
			var_child_layout_styles << rt.create_array([rt.ArrayItem{ key: 'rules_group', val: "@container (max-width: ${var_container_query_value.to_string()} )" }, rt.ArrayItem{ key: 'selector', val: ".${var_container_content_class.to_string()}" }, rt.ArrayItem{ key: 'declarations', val: rt.create_array([rt.ArrayItem{ key: 'grid-column', val: '1/-1' }]) }])
		}
		var_child_css = rt.call_function('wp_style_engine_get_stylesheet_from_css_rules', [rt.create_array_from_list(var_child_layout_styles), rt.create_array([rt.ArrayItem{ key: 'context', val: 'block-supports' }, rt.ArrayItem{ key: 'prettify', val: false }])])
		if rt.is_true(var_child_css) {
			var_outer_class_names << var_container_content_class.clone()
		}
	}
	var_processor = create_wp_html_tag_processor(var_block_content.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_processor.next_tag())))) {
		return var_block_content.clone()
	}
	if !(var_block_supports_layout) && !(!rt.is_true(var_outer_class_names)) {
		for var_class_name_shadow in var_outer_class_names {
			var_processor.add_class(var_class_name_shadow.clone())
		}
		return var_processor.get_updated_html()
	} else if !(var_block_supports_layout) {
		return var_block_content.clone()
	}
	var_global_settings = rt.call_function('wp_get_global_settings', []rt.PhpVal{})
	var_fallback_layout = if !(rt.get_property(var_block_type, 'supports').array_get(rt.new_string('layout')).array_get(rt.new_string('default'))).is_null() { rt.get_property(var_block_type, 'supports').array_get(rt.new_string('layout')).array_get(rt.new_string('default')) } else { rt.new_array() }
	if !rt.is_true(var_fallback_layout) {
	var_fallback_layout = if !(rt.get_property(var_block_type, 'supports').array_get(rt.new_string('__experimentalLayout')).array_get(rt.new_string('default'))).is_null() { rt.get_property(var_block_type, 'supports').array_get(rt.new_string('__experimentalLayout')).array_get(rt.new_string('default')) } else { rt.new_array() }
	}
	var_used_layout = if !(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('layout'))).is_null() { var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('layout')) } else { var_fallback_layout }
	var_class_names = rt.new_array()
	var_layout_definitions = wp_get_layout_definitions()
	if (var_used_layout.array_isset(rt.new_string('inherit')) && rt.is_true(var_used_layout.array_get(rt.new_string('inherit')))) || (var_used_layout.array_isset(rt.new_string('contentSize')) && rt.is_true(var_used_layout.array_get(rt.new_string('contentSize')))) {
		var_used_layout.array_set('type', 'constrained')
	}
	var_root_padding_aware_alignments = if !(var_global_settings.array_get(rt.new_string('useRootPaddingAwareAlignments'))).is_null() { var_global_settings.array_get(rt.new_string('useRootPaddingAwareAlignments')) } else { rt.new_bool(false) }
	if rt.is_true(var_root_padding_aware_alignments) && var_used_layout.array_isset(rt.new_string('type')) && rt.is_true(rt.identical(rt.new_string('constrained'), var_used_layout.array_get(rt.new_string('type')))) {
		var_class_names << rt.new_string('has-global-padding')
	}
	if !(!rt.is_true(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('layout')).array_get(rt.new_string('orientation')))) {
		var_class_names << 'is-' + (rt.call_function('sanitize_title', [var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('layout')).array_get(rt.new_string('orientation'))])).str()
	}
	if !(!rt.is_true(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('layout')).array_get(rt.new_string('justifyContent')))) {
		var_class_names << 'is-content-justification-' + (rt.call_function('sanitize_title', [var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('layout')).array_get(rt.new_string('justifyContent'))])).str()
	}
	if !(!rt.is_true(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('layout')).array_get(rt.new_string('flexWrap')))) && rt.is_true(rt.identical(rt.new_string('nowrap'), var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('layout')).array_get(rt.new_string('flexWrap')))) {
		var_class_names << rt.new_string('is-nowrap')
	}
	if var_used_layout.array_isset(rt.new_string('type')) {
	var_layout_classname = if !(var_layout_definitions.array_get(var_used_layout.array_get(rt.new_string('type'))).array_get(rt.new_string('className'))).is_null() { var_layout_definitions.array_get(var_used_layout.array_get(rt.new_string('type'))).array_get(rt.new_string('className')) } else { rt.new_string('') }
	} else {
	var_layout_classname = if !(var_layout_definitions.array_get(rt.new_string('default')).array_get(rt.new_string('className'))).is_null() { var_layout_definitions.array_get(rt.new_string('default')).array_get(rt.new_string('className')) } else { rt.new_string('') }
	}
	if rt.is_true(var_layout_classname) && var_layout_classname.clone().is_string() {
		var_class_names << rt.call_function('sanitize_title', [var_layout_classname.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('disable-layout-styles')]))))) {
		var_gap_value = if !(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('style')).array_get(rt.new_string('spacing')).array_get(rt.new_string('blockGap'))).is_null() { var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('style')).array_get(rt.new_string('spacing')).array_get(rt.new_string('blockGap')) } else { rt.new_null() }
		if rt.is_true(rt.new_bool(var_gap_value.clone().is_array())) {
			mut iter_4 := var_gap_value.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_value_shadow := item_4.val
				mut var_key_shadow := item_4.key
				var_gap_value.array_set(var_key_shadow, if rt.is_true(var_value_shadow) && rt.is_true(rt.call_function('preg_match', [rt.new_string('%[\\\\(&=}]|/\\*%'), var_value_shadow.clone()])) { rt.new_null() } else { var_value_shadow })
			}
		} else {
		var_gap_value = if rt.is_true(var_gap_value) && rt.is_true(rt.call_function('preg_match', [rt.new_string('%[\\\\(&=}]|/\\*%'), var_gap_value.clone()])) { rt.new_null() } else { var_gap_value }
		}
		var_fallback_gap_value = if !(rt.get_property(var_block_type, 'supports').array_get(rt.new_string('spacing')).array_get(rt.new_string('blockGap')).array_get(rt.new_string('__experimentalDefault'))).is_null() { rt.get_property(var_block_type, 'supports').array_get(rt.new_string('spacing')).array_get(rt.new_string('blockGap')).array_get(rt.new_string('__experimentalDefault')) } else { rt.new_string('0.5em') }
		var_block_spacing = if !(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('style')).array_get(rt.new_string('spacing'))).is_null() { var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('style')).array_get(rt.new_string('spacing')) } else { rt.new_null() }
		var_should_skip_gap_serialization = rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.clone(), rt.new_string('spacing'), rt.new_string('blockGap')])
		var_block_gap = if !(var_global_settings.array_get(rt.new_string('spacing')).array_get(rt.new_string('blockGap'))).is_null() { var_global_settings.array_get(rt.new_string('spacing')).array_get(rt.new_string('blockGap')) } else { rt.new_null() }
		var_has_block_gap_support = rt.new_bool(!(var_block_gap).is_null())
		var_block_name = if !(var_block.array_get(rt.new_string('blockName'))).is_null() { var_block.array_get(rt.new_string('blockName')) } else { rt.new_string('') }
		if rt.is_true(rt.identical(rt.new_null(), var_global_styles)) {
		var_global_styles = rt.call_function('wp_get_global_styles', []rt.PhpVal{})
		}
		var_variation_block_gap_value = rt.new_null()
		var_block_class_name = if !(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('className'))).is_null() { var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('className')) } else { rt.new_string('') }
		if rt.is_true(var_block_class_name) && rt.is_true(rt.call_function('str_contains', [var_block_class_name.clone(), rt.new_string('is-style-')])) && rt.is_true(var_block_name) {
			mut iife_temp_1 := Class_WP_Block_Styles_Registry{}
			mut iife_result_1 := iife_temp_1.get_instance()
			var_styles_registry = iife_result_1
			var_registered_styles = rt.call_method(var_styles_registry, 'get_registered_styles_for_block', [var_block_name.clone()])
			var_variation_name = wp_get_block_style_variation_name_from_registered_style(var_block_class_name.clone(), var_registered_styles.clone())
			if var_variation_name.len > 0 && var_variation_name != '0' {
			var_variation_block_gap_value = if !(var_global_styles.array_get(rt.new_string('blocks')).array_get(var_block_name).array_get(rt.new_string('variations')).array_get(rt.new_string((var_variation_name).str())).array_get(rt.new_string('spacing')).array_get(rt.new_string('blockGap'))).is_null() { var_global_styles.array_get(rt.new_string('blocks')).array_get(var_block_name).array_get(rt.new_string('variations')).array_get(rt.new_string((var_variation_name).str())).array_get(rt.new_string('spacing')).array_get(rt.new_string('blockGap')) } else { rt.new_null() }
			}
		}
		var_global_block_gap_value = if !(var_variation_block_gap_value).is_null() { var_variation_block_gap_value } else { if !(var_global_styles.array_get(rt.new_string('blocks')).array_get(var_block_name).array_get(rt.new_string('spacing')).array_get(rt.new_string('blockGap'))).is_null() { var_global_styles.array_get(rt.new_string('blocks')).array_get(var_block_name).array_get(rt.new_string('spacing')).array_get(rt.new_string('blockGap')) } else { if !(var_global_styles.array_get(rt.new_string('spacing')).array_get(rt.new_string('blockGap'))).is_null() { var_global_styles.array_get(rt.new_string('spacing')).array_get(rt.new_string('blockGap')) } else { rt.new_null() } } }
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_global_block_gap_value)))) {
		var_fallback_gap_value = var_global_block_gap_value.clone()
		}
		var_container_class = rt.call_function('wp_unique_id_from_values', [rt.create_array([rt.ArrayItem{ key: none, val: var_used_layout }, rt.ArrayItem{ key: none, val: var_has_block_gap_support }, rt.ArrayItem{ key: none, val: var_gap_value }, rt.ArrayItem{ key: none, val: var_should_skip_gap_serialization }, rt.ArrayItem{ key: none, val: var_fallback_gap_value }, rt.ArrayItem{ key: none, val: var_block_spacing }]), rt.new_string('wp-container-' + (rt.call_function('sanitize_title', [var_block.array_get(rt.new_string('blockName'))])).str() + '-is-layout-')])
		var_style = wp_get_layout_style(".${var_container_class.to_string()}", var_used_layout.clone(), var_has_block_gap_support.clone(), var_gap_value.clone(), var_should_skip_gap_serialization.clone(), var_fallback_gap_value.clone(), var_block_spacing.clone())
		if !(var_style == '') {
			var_class_names << var_container_class.clone()
		}
	}
	var_split_block_name = rt.call_function('explode', [rt.new_string('/'), var_block.array_get(rt.new_string('blockName'))])
	var_full_block_name = if rt.is_true(rt.identical(rt.new_string('core'), var_split_block_name.array_get(rt.new_int(0)))) { rt.call_function('end', [var_split_block_name.clone()]) } else { rt.call_function('implode', [rt.new_string('-'), var_split_block_name.clone()]) }
	var_class_names << 'wp-block-' + (var_full_block_name).str() + '-' + (var_layout_classname).str()
	if !(!rt.is_true(var_outer_class_names)) {
		for var_outer_class_name_shadow in var_outer_class_names {
			var_processor.add_class(var_outer_class_name_shadow.clone())
		}
	}
	var_inner_block_wrapper_classes = rt.new_null()
	var_first_chunk = if !(var_block.array_get(rt.new_string('innerContent')).array_get(rt.new_int(0))).is_null() { var_block.array_get(rt.new_string('innerContent')).array_get(rt.new_int(0)) } else { rt.new_null() }
	if var_first_chunk.clone().is_string() && var_block.array_get(rt.new_string('innerContent')).array_count() > 1 {
		var_first_chunk_processor = create_wp_html_tag_processor(var_first_chunk.clone())
		for rt.is_true(var_first_chunk_processor.next_tag()) {
			var_class_attribute = var_first_chunk_processor.get_attribute(rt.new_string('class'))
			if var_class_attribute.clone().is_string() && !(!rt.is_true(var_class_attribute)) {
			var_inner_block_wrapper_classes = var_class_attribute.clone()
			}
		}
	}
	for {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_inner_block_wrapper_classes)))) {
			break
		}
		var_class_attribute = var_processor.get_attribute(rt.new_string('class'))
		if var_class_attribute.clone().is_string() && rt.is_true(rt.call_function('str_contains', [var_class_attribute.clone(), var_inner_block_wrapper_classes.clone()])) {
			break
		}
		if !(rt.is_true(var_processor.next_tag())) {
			break
		}
	}
	for var_class_name_shadow in var_class_names {
		var_processor.add_class(var_class_name_shadow.clone())
	}
	return var_processor.get_updated_html()
}

fn wp_add_parent_layout_to_parsed_block(var_parsed_block rt.PhpVal, var_source_block rt.PhpVal, var_parent_block rt.PhpVal) rt.PhpVal {
	if rt.is_true(var_parent_block) && rt.get_property(var_parent_block, 'parsed_block').array_get(rt.new_string('attrs')).array_isset(rt.new_string('layout')) {
		var_parsed_block['parentLayout'] = rt.get_property(var_parent_block, 'parsed_block').array_get(rt.new_string('attrs')).array_get(rt.new_string('layout'))
	}
	return var_parsed_block.clone()
}

fn wp_restore_group_inner_container(var_block_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_tag_name := rt.new_null()
	mut var_group_with_inner_container_regex := rt.new_null()
	mut var_layout_classes := []rt.PhpVal{}
	mut var_processor := rt.new_null()
	mut var_class_name := rt.new_null()
	mut var_content_without_layout_classes := rt.new_null()
	mut var_replace_regex := rt.new_null()
	mut var_updated_content := rt.new_null()
	var_tag_name = if !(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('tagName'))).is_null() { var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('tagName')) } else { rt.new_string('div') }
	var_group_with_inner_container_regex = rt.call_function('sprintf', [rt.new_string('/(^\\s*<%1$s\\b[^>]*wp-block-group(\\s|")[^>]*>)(\\s*<div\\b[^>]*wp-block-group__inner-container(\\s|")[^>]*>)((.|\\S|\\s)*)/U'), rt.call_function('preg_quote', [var_tag_name.clone(), rt.new_string('/')])])
	if rt.is_true(rt.call_function('wp_theme_has_theme_json', []rt.PhpVal{})) || rt.is_true(rt.identical(rt.new_int(1), rt.call_function('preg_match', [var_group_with_inner_container_regex.clone(), var_block_content.clone()]))) || (var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('layout')).array_isset(rt.new_string('type')) && rt.is_true(rt.identical(rt.new_string('flex'), var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('layout')).array_get(rt.new_string('type')))) || rt.is_true(rt.identical(rt.new_string('grid'), var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('layout')).array_get(rt.new_string('type'))))) {
		return var_block_content.clone()
	}
	var_layout_classes = rt.new_array()
	var_processor = create_wp_html_tag_processor(var_block_content.clone())
	if rt.is_true(var_processor.next_tag(rt.create_array([rt.ArrayItem{ key: 'class_name', val: 'wp-block-group' }]))) {
		mut iter_5 := var_processor.class_list().iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_class_name_shadow := item_5.val
			if rt.is_true(rt.call_function('str_contains', [var_class_name_shadow.clone(), rt.new_string('is-layout-')])) {
				var_layout_classes << var_class_name_shadow.clone()
				var_processor.remove_class(var_class_name_shadow.clone())
			}
		}
	}
	var_content_without_layout_classes = var_processor.get_updated_html()
	var_replace_regex = rt.call_function('sprintf', [rt.new_string('/(^\\s*<%1$s\\b[^>]*wp-block-group[^>]*>)(.*)(<\\/%1$s>\\s*$)/ms'), rt.call_function('preg_quote', [var_tag_name.clone(), rt.new_string('/')])])
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_matches := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_string((var_matches.array_get(rt.new_int(1))).str() + '<div class="wp-block-group__inner-container">' + (var_matches.array_get(rt.new_int(2))).str() + '</div>' + (var_matches.array_get(rt.new_int(3))).str())
		}
	var_updated_content = rt.call_function('preg_replace_callback', [var_replace_regex.clone(), rt.new_closure(closure_4_fn), var_content_without_layout_classes.clone()])
	if !(!rt.is_true(var_layout_classes)) {
		var_processor = create_wp_html_tag_processor(var_updated_content.clone())
		if rt.is_true(var_processor.next_tag(rt.create_array([rt.ArrayItem{ key: 'class_name', val: 'wp-block-group__inner-container' }]))) {
			for var_class_name_shadow in var_layout_classes {
				var_processor.add_class(var_class_name_shadow.clone())
			}
		}
	var_updated_content = var_processor.get_updated_html()
	}
	return var_updated_content.clone()
}

fn wp_restore_image_outer_container(var_block_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_figure_processor := rt.new_null()
	mut var_wrapper_processor := rt.new_null()
	mut var_class_name := rt.new_null()
	if rt.is_true(rt.call_function('wp_theme_has_theme_json', []rt.PhpVal{})) {
		return (var_block_content).str()
	}
	var_figure_processor = create_wp_html_tag_processor(var_block_content.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_figure_processor.next_tag(rt.new_string('FIGURE')))))) || rt.is_true(rt.new_bool(!(rt.is_true(var_figure_processor.has_class(rt.new_string('wp-block-image')))))) || !(rt.is_true(var_figure_processor.has_class(rt.new_string('alignleft'))) || rt.is_true(var_figure_processor.has_class(rt.new_string('aligncenter'))) || rt.is_true(var_figure_processor.has_class(rt.new_string('alignright')))) {
		return (var_block_content).str()
	}
	var_wrapper_processor = create_wp_html_tag_processor(rt.new_string('<div>'))
	var_wrapper_processor.next_token()
	var_wrapper_processor.set_attribute(rt.new_string('class'), rt.new_string((if if !(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('className'))).is_null() { var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('className')) } else { rt.new_null() }.is_string() { rt.concat(rt.new_string('wp-block-image '), var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('className'))) } else { 'wp-block-image' }).str()))
	var_figure_processor.remove_class(rt.new_string('wp-block-image'))
	mut iter_6 := var_wrapper_processor.class_list().iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_class_name_shadow := item_6.val
		var_figure_processor.remove_class(var_class_name_shadow.clone())
	}
	return rt.concat(rt.concat(var_wrapper_processor.get_updated_html(), var_figure_processor.get_updated_html()), rt.new_string('</div>'))
}

struct Class_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_WP_Block_Styles_Registry {
	rt.PhpObjectBase
}

struct Class_WP_Block_Supports {
	rt.PhpObjectBase
}

fn create_wp_block_type_registry(_args ...rt.PhpVal) &Class_WP_Block_Type_Registry {
	mut obj := &Class_WP_Block_Type_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_html_tag_processor(_args ...rt.PhpVal) &Class_WP_HTML_Tag_Processor {
	mut obj := &Class_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_styles_registry(_args ...rt.PhpVal) &Class_WP_Block_Styles_Registry {
	mut obj := &Class_WP_Block_Styles_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_supports(_args ...rt.PhpVal) &Class_WP_Block_Supports {
	mut obj := &Class_WP_Block_Supports{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
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


fn (mut this Class_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Block_Styles_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Styles_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Styles_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Block_Supports) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Supports) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Supports) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_filter', [rt.new_string('render_block_data'), rt.new_string('wp_add_parent_layout_to_parsed_block'), rt.new_int(10), rt.new_int(3)])
	mut iife_temp_2 := Class_WP_Block_Supports{}
	mut iife_result_2 := iife_temp_2.get_instance()
	rt.call_method(iife_result_2, 'register', [rt.new_string('layout'), rt.create_array([rt.ArrayItem{ key: 'register_attribute', val: 'wp_register_layout_support' }])])
	rt.call_function('add_filter', [rt.new_string('render_block'), rt.new_string('wp_render_layout_support_flag'), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('render_block_core/group'), rt.new_string('wp_restore_group_inner_container'), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('render_block_core/image'), rt.new_string('wp_restore_image_outer_container'), rt.new_int(10), rt.new_int(2)])
}
