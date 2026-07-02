import rt

fn render_block_core_search(var_attributes_arg rt.PhpVal) rt.PhpVal {
	mut var_attributes := var_attributes_arg
	mut var_input_id := rt.new_null()
	mut var_classnames := rt.new_null()
	mut var_show_label := false
	mut var_use_icon_button := false
	mut var_show_button := false
	mut var_button_position := rt.new_null()
	mut var_query_params := rt.new_null()
	mut var_button := rt.new_null()
	mut var_query_params_markup := ''
	mut var_inline_styles := rt.new_null()
	mut var_color_classes := rt.new_null()
	mut var_typography_classes := rt.new_null()
	mut var_is_button_inside := false
	mut var_border_color_classes := rt.new_null()
	mut var_open_by_default := false
	mut var_label_inner_html := rt.new_null()
	mut var_label := rt.new_null()
	mut var_input := rt.new_null()
	mut var_input_classes := []rt.PhpVal{}
	mut var_is_expandable_searchfield := false
	mut var_value := rt.new_null()
	mut var_param := rt.new_null()
	mut var_button_classes := []rt.PhpVal{}
	mut var_button_internal_markup := rt.new_null()
	mut var_field_markup_classes := []rt.PhpVal{}
	mut var_field_markup := rt.new_null()
	mut var_wrapper_attributes := rt.new_null()
	mut var_form_directives := rt.new_null()
	mut var_aria_label_expanded := rt.new_null()
	mut var_aria_label_collapsed := rt.new_null()
	mut var_form_context := rt.new_null()
	var_attributes = rt.call_function('wp_parse_args', [var_attributes.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Search'),
			]) },
			rt.ArrayItem{ key: 'buttonText', val: rt.call_function('__', [
				rt.new_string('Search'),
			]) },
		])])
	var_input_id = rt.call_function('wp_unique_id', [
		rt.new_string('wp-block-search__input-'),
	])
	var_classnames = classnames_for_block_core_search(var_attributes.clone())
	var_show_label = !(!rt.is_true(var_attributes.array_get(rt.new_string('showLabel'))))
	var_use_icon_button = !(!rt.is_true(var_attributes.array_get(rt.new_string('buttonUseIcon'))))
	var_show_button = if !(!rt.is_true(var_attributes.array_get(rt.new_string('buttonPosition'))))
		&& rt.is_true(rt.identical(rt.new_string('no-button'), var_attributes.array_get(rt.new_string('buttonPosition')))) {
		false
	} else {
		true
	}
	var_button_position = if var_show_button {
		var_attributes.array_get(rt.new_string('buttonPosition'))
	} else {
		rt.new_null()
	}
	var_query_params = if !(!rt.is_true(var_attributes.array_get(rt.new_string('query')))) {
		var_attributes.array_get(rt.new_string('query'))
	} else {
		rt.new_array()
	}
	var_button = rt.new_string('')
	var_query_params_markup = ''
	var_inline_styles = styles_for_block_core_search(var_attributes.clone())
	var_color_classes = get_color_classes_for_block_core_search(var_attributes.clone())
	var_typography_classes = get_typography_classes_for_block_core_search(var_attributes.clone())
	var_is_button_inside =
		!(!rt.is_true(var_attributes.array_get(rt.new_string('buttonPosition'))))
		&& rt.is_true(rt.identical(rt.new_string('button-inside'), var_attributes.array_get(rt.new_string('buttonPosition'))))
	var_border_color_classes =
		get_border_color_classes_for_block_core_search(var_attributes.clone())
	var_open_by_default = false
	var_label_inner_html = if !rt.is_true(var_attributes.array_get(rt.new_string('label'))) { rt.call_function('__', [
			rt.new_string('Search'),
		]) } else { rt.call_function('wp_kses_post', [
			var_attributes.array_get(rt.new_string('label')),
		]) }
	var_label = create_wp_html_tag_processor(rt.call_function('sprintf', [
		rt.new_string('<label %1$s>%2$s</label>'),
		var_inline_styles.array_get(rt.new_string('label')),
		var_label_inner_html.clone(),
	]))
	if rt.is_true(var_label.next_tag()) {
		var_label.set_attribute(rt.new_string('for'), var_input_id.clone())
		var_label.add_class(rt.new_string('wp-block-search__label'))
		if var_show_label && !(!rt.is_true(var_attributes.array_get(rt.new_string('label')))) {
			if !(!rt.is_true(var_typography_classes)) {
				var_label.add_class(var_typography_classes.clone())
			}
		} else {
			var_label.add_class(rt.new_string('screen-reader-text'))
		}
	}
	var_input = create_wp_html_tag_processor(rt.call_function('sprintf', [
		rt.new_string('<input type="search" name="s" required %s/>'),
		var_inline_styles.array_get(rt.new_string('input')),
	]))
	var_input_classes = [rt.new_string('wp-block-search__input')]
	if !var_is_button_inside && !(!rt.is_true(var_border_color_classes)) {
		var_input_classes << var_border_color_classes.clone()
	}
	if !(!rt.is_true(var_typography_classes)) {
		var_input_classes << var_typography_classes.clone()
	}
	if rt.is_true(var_input.next_tag()) {
		var_input.add_class(rt.call_function('implode', [rt.new_string(' '),
			rt.create_array_from_list(var_input_classes)]))
		var_input.set_attribute(rt.new_string('id'), var_input_id.clone())
		var_input.set_attribute(rt.new_string('value'), rt.call_function('get_search_query',
			[]rt.PhpVal{}))
		var_input.set_attribute(rt.new_string('placeholder'),
			var_attributes.array_get(rt.new_string('placeholder')))
		var_is_expandable_searchfield = (rt.identical(rt.new_string('button-only'),
			var_button_position)).to_bool()
		if var_is_expandable_searchfield {
			rt.call_function('wp_enqueue_script_module', [
				rt.new_string('@wordpress/block-library/search/view'),
			])
			var_input.set_attribute(rt.new_string('data-wp-bind--aria-hidden'),
				rt.new_string('!context.isSearchInputVisible'))
			var_input.set_attribute(rt.new_string('data-wp-bind--tabindex'),
				rt.new_string('state.tabindex'))
			var_input.set_attribute(rt.new_string('aria-hidden'), rt.new_string('true'))
			var_input.set_attribute(rt.new_string('tabindex'), rt.new_string('-1'))
		}
	}
	if var_query_params.clone().array_count() > 0 {
		mut iter_1 := var_query_params.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value_shadow := item_1.val
			mut var_param_shadow := item_1.key
			var_query_params_markup = var_query_params_markup +(rt.call_function('sprintf', [rt.new_string('<input type="hidden" name="%s" value="%s" />'), rt.call_function('esc_attr', [var_param_shadow.clone()]), rt.call_function('esc_attr', [var_value_shadow.clone()])])).str()
		}
	}
	if var_show_button {
		var_button_classes = [rt.new_string('wp-block-search__button')]
		var_button_internal_markup = rt.new_string('')
		if !(!rt.is_true(var_color_classes)) {
			var_button_classes << var_color_classes.clone()
		}
		if !(!rt.is_true(var_typography_classes)) {
			var_button_classes << var_typography_classes.clone()
		}
		if !var_is_button_inside && !(!rt.is_true(var_border_color_classes)) {
			var_button_classes << var_border_color_classes.clone()
		}
		if !var_use_icon_button {
			if !(!rt.is_true(var_attributes.array_get(rt.new_string('buttonText')))) {
				var_button_internal_markup = rt.call_function('wp_kses_post', [
					var_attributes.array_get(rt.new_string('buttonText')),
				])
			}
		} else {
			var_button_classes << rt.new_string('has-icon')
			var_button_internal_markup =
				rt.new_string('<svg class="search-icon" viewBox="0 0 24 24" width="24" height="24">\n\t\t\t\t\t<path d="M13 5c-3.3 0-6 2.7-6 6 0 1.4.5 2.7 1.3 3.7l-3.8 3.8 1.1 1.1 3.8-3.8c1 .8 2.3 1.3 3.7 1.3 3.3 0 6-2.7 6-6S16.3 5 13 5zm0 10.5c-2.5 0-4.5-2-4.5-4.5s2-4.5 4.5-4.5 4.5 2 4.5 4.5-2 4.5-4.5 4.5z"></path>\n\t\t\t\t</svg>')
		}
		var_button_classes << rt.call_function('wp_theme_get_element_class_name', [
			rt.new_string('button'),
		])
		var_button = create_wp_html_tag_processor(rt.call_function('sprintf', [
			rt.new_string('<button type="submit" %s>%s</button>'),
			var_inline_styles.array_get(rt.new_string('button')),
			var_button_internal_markup.clone(),
		]))
		if rt.is_true(rt.call_method(var_button, 'next_tag', []rt.PhpVal{})) {
			rt.call_method(var_button, 'add_class', [
				rt.call_function('implode', [rt.new_string(' '),
					rt.create_array_from_list(var_button_classes)]),
			])
			if rt.is_true(rt.identical(rt.new_string('button-only'),
				var_attributes.array_get(rt.new_string('buttonPosition'))))
			{
				rt.call_method(var_button, 'set_attribute', [
					rt.new_string('data-wp-bind--aria-label'),
					rt.new_string('state.ariaLabel'),
				])
				rt.call_method(var_button, 'set_attribute', [
					rt.new_string('data-wp-bind--aria-controls'),
					rt.new_string('state.ariaControls'),
				])
				rt.call_method(var_button, 'set_attribute', [
					rt.new_string('data-wp-bind--aria-expanded'),
					rt.new_string('context.isSearchInputVisible'),
				])
				rt.call_method(var_button, 'set_attribute', [
					rt.new_string('data-wp-bind--type'),
					rt.new_string('state.type'),
				])
				rt.call_method(var_button, 'set_attribute', [
					rt.new_string('data-wp-on--click'),
					rt.new_string('actions.openSearchInput'),
				])
				rt.call_method(var_button, 'set_attribute', [
					rt.new_string('aria-label'),
					rt.call_function('__', [
						rt.new_string('Expand search field'),
					])])
				rt.call_method(var_button, 'set_attribute', [
					rt.new_string('aria-controls'),
					rt.new_string('wp-block-search__input-' + var_input_id.str()),
				])
				rt.call_method(var_button, 'set_attribute', [
					rt.new_string('aria-expanded'),
					rt.new_string('false'),
				])
				rt.call_method(var_button, 'set_attribute', [
					rt.new_string('type'), rt.new_string('button')])
			} else {
				rt.call_method(var_button, 'set_attribute', [
					rt.new_string('aria-label'),
					rt.call_function('wp_strip_all_tags', [
						var_attributes.array_get(rt.new_string('buttonText')),
					])])
			}
		}
	}
	var_field_markup_classes = [rt.new_string('wp-block-search__inside-wrapper')]
	if var_is_button_inside && !(!rt.is_true(var_border_color_classes)) {
		var_field_markup_classes << var_border_color_classes.clone()
	}
	var_field_markup = rt.call_function('sprintf', [
		rt.new_string('<div class="%s" %s>%s</div>'),
		rt.call_function('esc_attr', [
			rt.call_function('implode', [rt.new_string(' '),
				rt.create_array_from_list(var_field_markup_classes)]),
		]),
		var_inline_styles.array_get(rt.new_string('wrapper')),
		rt.new_string(var_input.str() + var_query_params_markup + var_button.str()),
	])
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([rt.ArrayItem{ key: 'class', val: var_classnames }]),
	])
	var_form_directives = rt.new_string('')
	if var_is_expandable_searchfield {
		var_aria_label_expanded = rt.call_function('__', [rt.new_string('Submit Search')])
		var_aria_label_collapsed = rt.call_function('__', [
			rt.new_string('Expand search field'),
		])
		var_form_context = rt.call_function('wp_interactivity_data_wp_context', [
			rt.create_array([
				rt.ArrayItem{ key: 'isSearchInputVisible', val: var_open_by_default },
				rt.ArrayItem{ key: 'inputId', val: var_input_id },
				rt.ArrayItem{ key: 'ariaLabelExpanded', val: var_aria_label_expanded },
				rt.ArrayItem{ key: 'ariaLabelCollapsed', val: var_aria_label_collapsed },
			]),
		])
		var_form_directives = rt.new_string('\n\t\t data-wp-interactive="core/search"\n\t\t ' +
			var_form_context.str() +
			'\n\t\t data-wp-class--wp-block-search__searchfield-hidden="!context.isSearchInputVisible"\n\t\t data-wp-on--keydown="actions.handleSearchKeydown"\n\t\t data-wp-on--focusout="actions.handleSearchFocusout"\n\t\t')
	}
	return rt.call_function('sprintf', [
		rt.new_string('<form role="search" method="get" action="%1s" %2s %3s>%4s</form>'),
		rt.call_function('esc_url', [rt.call_function('home_url', [
			rt.new_string('/')])]),
		var_wrapper_attributes.clone(),
		var_form_directives.clone(),
		rt.new_string(var_label.str() + var_field_markup.str()),
	])
}

fn register_block_core_search() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/search'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_search' },
		]),
	])
}

fn classnames_for_block_core_search(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_classnames := rt.new_null()
	var_classnames = rt.new_array()
	if !(!rt.is_true(var_attributes.array_get(rt.new_string('buttonPosition')))) {
		if rt.is_true(rt.identical(rt.new_string('button-inside'),
			var_attributes.array_get(rt.new_string('buttonPosition'))))
		{
			var_classnames.array_push('wp-block-search__button-inside')
		}
		if rt.is_true(rt.identical(rt.new_string('button-outside'),
			var_attributes.array_get(rt.new_string('buttonPosition'))))
		{
			var_classnames.array_push('wp-block-search__button-outside')
		}
		if rt.is_true(rt.identical(rt.new_string('no-button'),
			var_attributes.array_get(rt.new_string('buttonPosition'))))
		{
			var_classnames.array_push('wp-block-search__no-button')
		}
		if rt.is_true(rt.identical(rt.new_string('button-only'),
			var_attributes.array_get(rt.new_string('buttonPosition'))))
		{
			var_classnames.array_push('wp-block-search__button-only wp-block-search__searchfield-hidden')
		}
	}
	if var_attributes.array_isset(rt.new_string('buttonUseIcon')) {
		if !(!rt.is_true(var_attributes.array_get(rt.new_string('buttonPosition'))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('no-button'), var_attributes.array_get(rt.new_string('buttonPosition')))))) {
			if rt.is_true(var_attributes.array_get(rt.new_string('buttonUseIcon'))) {
				var_classnames.array_push('wp-block-search__icon-button')
			} else {
				var_classnames.array_push('wp-block-search__text-button')
			}
		}
	}
	return rt.call_function('implode', [rt.new_string(' '), var_classnames.clone()])
}

fn apply_block_core_search_border_style(var_attributes rt.PhpVal, var_property rt.PhpVal, var_side rt.PhpVal, var_wrapper_styles rt.PhpVal, var_button_styles rt.PhpVal, var_input_styles rt.PhpVal) {
	mut var_is_button_inside := false
	mut var_path := []rt.PhpVal{}
	mut var_value := rt.new_null()
	mut var_has_color_preset := rt.new_null()
	mut var_named_color_value := rt.new_null()
	mut var_property_suffix := rt.new_null()
	var_is_button_inside = var_attributes.array_isset(rt.new_string('buttonPosition'))
		&& rt.is_true(rt.identical(rt.new_string('button-inside'), var_attributes.array_get(rt.new_string('buttonPosition'))))
	var_path = [rt.new_string('style'), rt.new_string('border'), var_property]
	if rt.is_true(var_side) {
		rt.call_function('array_splice', [rt.create_array_from_list(var_path),
			rt.new_int(2), rt.new_int(0), var_side.clone()])
	}
	var_value = rt.call_function('_wp_array_get', [var_attributes.clone(),
		rt.create_array_from_list(var_path), rt.new_bool(false)])
	if !rt.is_true(var_value) {
		return
	}
	if rt.is_true(rt.identical(rt.new_string('color'), var_property)) && rt.is_true(var_side) {
		var_has_color_preset = rt.call_function('str_contains', [
			var_value.clone(), rt.new_string('var:preset|color|')])
		if rt.is_true(var_has_color_preset) {
			var_named_color_value = rt.call_function('substr', [
				var_value.clone(),
				rt.add(rt.call_function('strrpos', [
					var_value.clone(), rt.new_string('|')]), rt.new_int(1))])
			var_value = rt.call_function('sprintf', [
				rt.new_string('var(--wp--preset--color--%s)'),
				var_named_color_value.clone(),
			])
		}
	}
	var_property_suffix = if rt.is_true(var_side) { rt.call_function('sprintf', [
			rt.new_string('%s-%s'),
			var_side.clone(),
			var_property.clone(),
		]) } else { var_property }
	if var_is_button_inside {
		var_wrapper_styles << rt.call_function('sprintf', [
			rt.new_string('border-%s: %s;'),
			var_property_suffix.clone(),
			rt.call_function('esc_attr', [var_value.clone()]),
		])
	} else {
		var_button_styles << rt.call_function('sprintf', [
			rt.new_string('border-%s: %s;'),
			var_property_suffix.clone(),
			rt.call_function('esc_attr', [var_value.clone()]),
		])
		var_input_styles << rt.call_function('sprintf', [rt.new_string('border-%s: %s;'),
			var_property_suffix.clone(), rt.call_function('esc_attr', [
				var_value.clone()])])
	}
}

fn apply_block_core_search_border_styles(var_attributes rt.PhpVal, property string, var_wrapper_styles rt.PhpVal, var_button_styles rt.PhpVal, var_input_styles rt.PhpVal) {
	mut var_property := property
	apply_block_core_search_border_style(var_attributes.clone(), rt.new_string(property),
		rt.new_null(), rt.create_array_from_list(var_wrapper_styles),
		rt.create_array_from_list(var_button_styles), rt.create_array_from_list(var_input_styles))
	apply_block_core_search_border_style(var_attributes.clone(), rt.new_string(property),
		rt.new_string('top'), rt.create_array_from_list(var_wrapper_styles),
		rt.create_array_from_list(var_button_styles), rt.create_array_from_list(var_input_styles))
	apply_block_core_search_border_style(var_attributes.clone(), rt.new_string(property),
		rt.new_string('right'), rt.create_array_from_list(var_wrapper_styles),
		rt.create_array_from_list(var_button_styles), rt.create_array_from_list(var_input_styles))
	apply_block_core_search_border_style(var_attributes.clone(), rt.new_string(property),
		rt.new_string('bottom'), rt.create_array_from_list(var_wrapper_styles),
		rt.create_array_from_list(var_button_styles), rt.create_array_from_list(var_input_styles))
	apply_block_core_search_border_style(var_attributes.clone(), rt.new_string(property),
		rt.new_string('left'), rt.create_array_from_list(var_wrapper_styles),
		rt.create_array_from_list(var_button_styles), rt.create_array_from_list(var_input_styles))
}

fn styles_for_block_core_search(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_wrapper_styles := []rt.PhpVal{}
	mut var_button_styles := []rt.PhpVal{}
	mut var_input_styles := []rt.PhpVal{}
	mut var_label_styles := []rt.PhpVal{}
	mut var_is_button_inside := false
	mut var_show_label := false
	mut var_has_width := false
	mut var_has_border_radius := false
	mut var_default_padding := ''
	mut var_border_radius := rt.new_null()
	mut var_value := ''
	mut var_key := rt.new_null()
	mut var_index_to_splice := rt.new_null()
	mut var_slug := rt.new_null()
	mut var_name := ''
	mut var_border_style := rt.new_null()
	mut var_has_text_color := false
	mut var_has_background_color := false
	mut var_has_custom_gradient := false
	mut var_typography_styles := rt.new_null()
	mut var_text_decoration_value := rt.new_null()
	var_wrapper_styles = rt.new_array()
	var_button_styles = rt.new_array()
	var_input_styles = rt.new_array()
	var_label_styles = rt.new_array()
	var_is_button_inside =
		!(!rt.is_true(var_attributes.array_get(rt.new_string('buttonPosition'))))
		&& rt.is_true(rt.identical(rt.new_string('button-inside'), var_attributes.array_get(rt.new_string('buttonPosition'))))
	var_show_label = var_attributes.array_isset(rt.new_string('showLabel'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_attributes.array_get(rt.new_string('showLabel'))))))
	var_has_width = !(!rt.is_true(var_attributes.array_get(rt.new_string('width'))))
		&& !(!rt.is_true(var_attributes.array_get(rt.new_string('widthUnit'))))
	if var_has_width {
		var_wrapper_styles << rt.call_function('sprintf', [rt.new_string('width: %d%s;'),
			rt.call_function('esc_attr', [var_attributes.array_get(rt.new_string('width'))]),
			rt.call_function('esc_attr', [var_attributes.array_get(rt.new_string('widthUnit'))])])
	}
	apply_block_core_search_border_styles(var_attributes.clone(), 'width',
		rt.create_array_from_list(var_wrapper_styles),
		rt.create_array_from_list(var_button_styles), rt.create_array_from_list(var_input_styles))
	apply_block_core_search_border_styles(var_attributes.clone(), 'color',
		rt.create_array_from_list(var_wrapper_styles),
		rt.create_array_from_list(var_button_styles), rt.create_array_from_list(var_input_styles))
	apply_block_core_search_border_styles(var_attributes.clone(), 'style',
		rt.create_array_from_list(var_wrapper_styles),
		rt.create_array_from_list(var_button_styles), rt.create_array_from_list(var_input_styles))
	var_has_border_radius = !(!rt.is_true(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string('radius'))))
	if var_has_border_radius {
		var_default_padding = '4px'
		var_border_radius =
			var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string('radius'))
		if rt.is_true(rt.new_bool(var_border_radius.clone().is_array())) {
			mut iter_2 := var_border_radius.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_value_shadow := item_2.val
				mut var_key_shadow := item_2.key
				if rt.new_string(var_value_shadow.str()).is_string()
					&& rt.is_true(rt.call_function('str_contains', [rt.new_string(var_value_shadow.str()), rt.new_string('var:preset|border-radius|')])) {
					var_index_to_splice = rt.add(rt.call_function('strrpos', [
						rt.new_string(var_value_shadow.str()),
						rt.new_string('|'),
					]), rt.new_int(1))
					var_slug = rt.call_function('_wp_to_kebab_case', [
						rt.call_function('substr', [
							rt.new_string(var_value_shadow.str()),
							var_index_to_splice.clone(),
						]),
					])
					var_value_shadow =
						rt.new_string('var(--wp--preset--border-radius--${var_slug.to_string()})')
				}
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_value_shadow)))) {
					var_name = rt.call_function('preg_replace', [
						rt.new_string('/(?<!^)[A-Z]/'),
						rt.new_string('-$0'),
						var_key_shadow.clone(),
					]).to_string().to_lower()
					var_border_style = rt.call_function('sprintf', [
						rt.new_string('border-%s-radius: %s;'),
						rt.call_function('esc_attr', [rt.new_string(var_name.str()).clone()]),
						rt.call_function('esc_attr', [rt.new_string(var_value_shadow.str())]),
					])
					var_input_styles << var_border_style.clone()
					var_button_styles << var_border_style.clone()
					if var_is_button_inside
						&& rt.is_true(rt.new_bool(rt.new_string(var_value_shadow.str()).to_i64() != 0))
						|| rt.is_true(rt.call_function('str_contains', [rt.new_string(var_value_shadow.str()), rt.new_string('var(--wp--preset--border-radius--')])) {
						var_wrapper_styles << rt.call_function('sprintf', [
							rt.new_string('border-%s-radius: calc(%s + %s);'),
							rt.call_function('esc_attr', [rt.new_string(var_name.str()).clone()]),
							rt.call_function('esc_attr', [rt.new_string(var_value_shadow.str())]),
							rt.new_string(var_default_padding.str()).clone(),
						])
					}
				}
			}
		} else {
			var_border_radius = if var_border_radius.clone().is_long()
				|| var_border_radius.clone().is_double() {
				var_border_radius.str() + 'px'
			} else {
				var_border_radius
			}
			if var_border_radius.clone().is_string()
				&& rt.is_true(rt.call_function('str_contains', [var_border_radius.clone(), rt.new_string('var:preset|border-radius|')])) {
				var_index_to_splice = rt.add(rt.call_function('strrpos', [
					var_border_radius.clone(), rt.new_string('|')]), rt.new_int(1))
				var_slug = rt.call_function('_wp_to_kebab_case', [
					rt.call_function('substr', [var_border_radius.clone(),
						var_index_to_splice.clone()]),
				])
				var_border_radius =
					rt.new_string('var(--wp--preset--border-radius--${var_slug.to_string()})')
			}
			var_border_style = rt.call_function('sprintf', [
				rt.new_string('border-radius: %s;'),
				rt.call_function('esc_attr', [var_border_radius.clone()]),
			])
			var_input_styles << var_border_style.clone()
			var_button_styles << var_border_style.clone()
			if var_is_button_inside
				&& rt.is_true(rt.new_bool(var_border_radius.clone().to_i64() != 0)) {
				var_wrapper_styles << rt.call_function('sprintf', [
					rt.new_string('border-radius: calc(%s + %s);'),
					rt.call_function('esc_attr', [var_border_radius.clone()]),
					rt.new_string(var_default_padding.str()).clone(),
				])
			}
		}
	}
	var_has_text_color = !(!rt.is_true(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('text'))))
	if var_has_text_color {
		var_button_styles << rt.call_function('sprintf', [rt.new_string('color: %s;'),
			var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('text'))])
	}
	var_has_background_color = !(!rt.is_true(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('background'))))
	if var_has_background_color {
		var_button_styles << rt.call_function('sprintf', [
			rt.new_string('background-color: %s;'),
			var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('background')),
		])
	}
	var_has_custom_gradient = !(!rt.is_true(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('gradient'))))
	if var_has_custom_gradient {
		var_button_styles << rt.call_function('sprintf', [
			rt.new_string('background: %s;'),
			var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('gradient')),
		])
	}
	var_typography_styles = rt.call_function('esc_attr', [
		get_typography_styles_for_block_core_search(var_attributes.clone()),
	])
	if !(!rt.is_true(var_typography_styles)) {
		var_label_styles << var_typography_styles.clone()
		var_button_styles << var_typography_styles.clone()
		var_input_styles << var_typography_styles.clone()
	}
	if !(!rt.is_true(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('textDecoration')))) {
		var_text_decoration_value = rt.call_function('sprintf', [
			rt.new_string('text-decoration: %s;'),
			rt.call_function('esc_attr',
				[var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('textDecoration'))]),
		])
		var_button_styles << var_text_decoration_value.clone()
		if var_show_label {
			var_label_styles << var_text_decoration_value.clone()
		}
	}
	return rt.create_array([
		rt.ArrayItem{
			key: 'input'
			val: if !(!rt.is_true(var_input_styles)) { rt.call_function('sprintf', [
					rt.new_string(' style="%s"'),
					rt.call_function('esc_attr', [
						rt.call_function('safecss_filter_attr', [
							rt.call_function('implode', [rt.new_string(' '),
								rt.create_array_from_list(var_input_styles)]),
						]),
					]),
				]) } else { rt.new_string('') }
		},
		rt.ArrayItem{
			key: 'button'
			val: if !(!rt.is_true(var_button_styles)) { rt.call_function('sprintf', [
					rt.new_string(' style="%s"'),
					rt.call_function('esc_attr', [
						rt.call_function('safecss_filter_attr', [
							rt.call_function('implode', [rt.new_string(' '),
								rt.create_array_from_list(var_button_styles)]),
						]),
					]),
				]) } else { rt.new_string('') }
		},
		rt.ArrayItem{
			key: 'wrapper'
			val: if !(!rt.is_true(var_wrapper_styles)) { rt.call_function('sprintf', [
					rt.new_string(' style="%s"'),
					rt.call_function('esc_attr', [
						rt.call_function('safecss_filter_attr', [
							rt.call_function('implode', [rt.new_string(' '),
								rt.create_array_from_list(var_wrapper_styles)]),
						]),
					]),
				]) } else { rt.new_string('') }
		},
		rt.ArrayItem{
			key: 'label'
			val: if !(!rt.is_true(var_label_styles)) { rt.call_function('sprintf', [
					rt.new_string(' style="%s"'),
					rt.call_function('esc_attr', [
						rt.call_function('safecss_filter_attr', [
							rt.call_function('implode', [rt.new_string(' '),
								rt.create_array_from_list(var_label_styles)]),
						]),
					]),
				]) } else { rt.new_string('') }
		},
	])
}

fn get_typography_classes_for_block_core_search(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_typography_classes := rt.new_null()
	mut var_has_named_font_family := false
	mut var_has_named_font_size := false
	var_typography_classes = rt.new_array()
	var_has_named_font_family = !(!rt.is_true(var_attributes.array_get(rt.new_string('fontFamily'))))
	var_has_named_font_size = !(!rt.is_true(var_attributes.array_get(rt.new_string('fontSize'))))
	if var_has_named_font_size {
		var_typography_classes.array_push(rt.call_function('sprintf', [
			rt.new_string('has-%s-font-size'),
			rt.call_function('esc_attr', [var_attributes.array_get(rt.new_string('fontSize'))]),
		]))
	}
	if var_has_named_font_family {
		var_typography_classes.array_push(rt.call_function('sprintf', [
			rt.new_string('has-%s-font-family'),
			rt.call_function('esc_attr', [var_attributes.array_get(rt.new_string('fontFamily'))]),
		]))
	}
	return rt.call_function('implode', [rt.new_string(' '), var_typography_classes.clone()])
}

fn get_typography_styles_for_block_core_search(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_typography_styles := rt.new_null()
	var_typography_styles = rt.new_array()
	if !(!rt.is_true(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontSize')))) {
		var_typography_styles.array_push(rt.call_function('sprintf', [
			rt.new_string('font-size: %s;'),
			rt.call_function('wp_get_typography_font_size_value', [
				rt.create_array([
					rt.ArrayItem{
						key: 'size'
						val: var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontSize'))
					},
				]),
			]),
		]))
	}
	if !(!rt.is_true(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontFamily')))) {
		var_typography_styles.array_push(rt.call_function('sprintf', [
			rt.new_string('font-family: %s;'),
			var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontFamily')),
		]))
	}
	if !(!rt.is_true(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('letterSpacing')))) {
		var_typography_styles.array_push(rt.call_function('sprintf', [
			rt.new_string('letter-spacing: %s;'),
			var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('letterSpacing')),
		]))
	}
	if !(!rt.is_true(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontWeight')))) {
		var_typography_styles.array_push(rt.call_function('sprintf', [
			rt.new_string('font-weight: %s;'),
			var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontWeight')),
		]))
	}
	if !(!rt.is_true(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontStyle')))) {
		var_typography_styles.array_push(rt.call_function('sprintf', [
			rt.new_string('font-style: %s;'),
			var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontStyle')),
		]))
	}
	if !(!rt.is_true(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('lineHeight')))) {
		var_typography_styles.array_push(rt.call_function('sprintf', [
			rt.new_string('line-height: %s;'),
			var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('lineHeight')),
		]))
	}
	if !(!rt.is_true(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('textTransform')))) {
		var_typography_styles.array_push(rt.call_function('sprintf', [
			rt.new_string('text-transform: %s;'),
			var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('textTransform')),
		]))
	}
	return rt.call_function('implode', [rt.new_string(''), var_typography_styles.clone()])
}

fn get_border_color_classes_for_block_core_search(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_border_color_classes := rt.new_null()
	mut var_has_custom_border_color := false
	mut var_has_named_border_color := false
	var_border_color_classes = rt.new_array()
	var_has_custom_border_color = !(!rt.is_true(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('border')).array_get(rt.new_string('color'))))
	var_has_named_border_color = !(!rt.is_true(var_attributes.array_get(rt.new_string('borderColor'))))
	if var_has_custom_border_color || var_has_named_border_color {
		var_border_color_classes.array_push('has-border-color')
	}
	if var_has_named_border_color {
		var_border_color_classes.array_push(rt.call_function('sprintf', [
			rt.new_string('has-%s-border-color'),
			rt.call_function('esc_attr', [var_attributes.array_get(rt.new_string('borderColor'))]),
		]))
	}
	return rt.call_function('implode', [rt.new_string(' '), var_border_color_classes.clone()])
}

fn get_color_classes_for_block_core_search(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_classnames := rt.new_null()
	mut var_has_named_text_color := false
	mut var_has_custom_text_color := false
	mut var_has_named_background_color := false
	mut var_has_custom_background_color := false
	mut var_has_named_gradient := false
	mut var_has_custom_gradient := false
	var_classnames = rt.new_array()
	var_has_named_text_color = !(!rt.is_true(var_attributes.array_get(rt.new_string('textColor'))))
	var_has_custom_text_color = !(!rt.is_true(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('text'))))
	if var_has_named_text_color {
		var_classnames.array_push(rt.call_function('sprintf', [
			rt.new_string('has-text-color has-%s-color'),
			var_attributes.array_get(rt.new_string('textColor')),
		]))
	} else if var_has_custom_text_color {
		var_classnames.array_push('has-text-color')
	}
	var_has_named_background_color = !(!rt.is_true(var_attributes.array_get(rt.new_string('backgroundColor'))))
	var_has_custom_background_color = !(!rt.is_true(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('background'))))
	var_has_named_gradient = !(!rt.is_true(var_attributes.array_get(rt.new_string('gradient'))))
	var_has_custom_gradient = !(!rt.is_true(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('gradient'))))
	if var_has_named_background_color || var_has_custom_background_color || var_has_named_gradient
		|| var_has_custom_gradient {
		var_classnames.array_push('has-background')
	}
	if var_has_named_background_color {
		var_classnames.array_push(rt.call_function('sprintf', [
			rt.new_string('has-%s-background-color'),
			var_attributes.array_get(rt.new_string('backgroundColor')),
		]))
	}
	if var_has_named_gradient {
		var_classnames.array_push(rt.call_function('sprintf', [
			rt.new_string('has-%s-gradient-background'),
			var_attributes.array_get(rt.new_string('gradient')),
		]))
	}
	return rt.call_function('implode', [rt.new_string(' '), var_classnames.clone()])
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_wp_html_tag_processor(_args ...rt.PhpVal) &Class_WP_HTML_Tag_Processor {
	mut obj := &Class_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action',
		[rt.new_string('init'), rt.new_string('register_block_core_search')])
}
