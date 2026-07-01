import rt

fn render_block_core_search(var_attributes rt.PhpVal) rt.PhpVal {
	var_attributes = rt.call_function('wp_parse_args', [var_attributes.dup(), rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Search')]) }, rt.ArrayItem{ key: 'buttonText', val: rt.call_function('__', [rt.new_string('Search')]) }])])
	mut var_input_id := rt.call_function('wp_unique_id', [rt.new_string('wp-block-search__input-')])
	mut var_classnames := classnames_for_block_core_search(var_attributes.dup())
	mut var_show_label := !(!rt.is_true(var_attributes.array_get('showLabel')))
	mut var_use_icon_button := !(!rt.is_true(var_attributes.array_get('buttonUseIcon')))
	mut var_show_button := if rt.is_true(rt.new_bool(!(!rt.is_true(var_attributes.array_get('buttonPosition'))) && rt.is_true(rt.identical(rt.new_string('no-button'), var_attributes.array_get('buttonPosition'))))) { false } else { true }
	mut var_button_position := if var_show_button { var_attributes.array_get('buttonPosition') } else { rt.new_null() }
	mut var_query_params := if !(!rt.is_true(var_attributes.array_get('query'))) { var_attributes.array_get('query') } else { rt.new_array() }
	mut var_button := rt.new_string(rt.new_string(''))
	mut var_query_params_markup := ''
	mut var_inline_styles := styles_for_block_core_search(var_attributes.dup())
	mut var_color_classes := get_color_classes_for_block_core_search(var_attributes.dup())
	mut var_typography_classes := get_typography_classes_for_block_core_search(var_attributes.dup())
	mut var_is_button_inside := !(!rt.is_true(var_attributes.array_get('buttonPosition'))) && rt.is_true(rt.identical(rt.new_string('button-inside'), var_attributes.array_get('buttonPosition')))
	mut var_border_color_classes := get_border_color_classes_for_block_core_search(var_attributes.dup())
	mut var_open_by_default := false
	mut var_label_inner_html := if !rt.is_true(var_attributes.array_get('label')) { rt.call_function('__', [rt.new_string('Search')]) } else { rt.call_function('wp_kses_post', [var_attributes.array_get('label')]) }
	mut var_label := create_wp_html_tag_processor(rt.call_function('sprintf', [rt.new_string('<label %1$s>%2$s</label>'), var_inline_styles.array_get('label'), var_label_inner_html.dup()]))
	if rt.is_true(var_label.next_tag()) {
		var_label.set_attribute(rt.new_string('for'), var_input_id.dup())
		var_label.add_class(rt.new_string('wp-block-search__label'))
		if var_show_label && !(!rt.is_true(var_attributes.array_get('label'))) {
			if !(!rt.is_true(var_typography_classes)) {
				var_label.add_class(var_typography_classes.dup())
			}
		} else {
			var_label.add_class(rt.new_string('screen-reader-text'))
		}
	}
	mut var_input := create_wp_html_tag_processor(rt.call_function('sprintf', [rt.new_string('<input type="search" name="s" required %s/>'), var_inline_styles.array_get('input')]))
	mut var_input_classes := [rt.new_string('wp-block-search__input')]
	if !(var_is_button_inside) && !(!rt.is_true(var_border_color_classes)) {
		var_input_classes << var_border_color_classes.dup()
	}
	if !(!rt.is_true(var_typography_classes)) {
		var_input_classes << var_typography_classes.dup()
	}
	if rt.is_true(var_input.next_tag()) {
		var_input.add_class(rt.call_function('implode', [rt.new_string(' '), var_input_classes.dup()]))
		var_input.set_attribute(rt.new_string('id'), var_input_id.dup())
		var_input.set_attribute(rt.new_string('value'), rt.call_function('get_search_query', []rt.PhpVal{}))
		var_input.set_attribute(rt.new_string('placeholder'), var_attributes.array_get('placeholder'))
		mut var_is_expandable_searchfield := (rt.identical(rt.new_string('button-only'), var_button_position)).to_bool()
		if var_is_expandable_searchfield {
			rt.call_function('wp_enqueue_script_module', [rt.new_string('@wordpress/block-library/search/view')])
			var_input.set_attribute(rt.new_string('data-wp-bind--aria-hidden'), rt.new_string('!context.isSearchInputVisible'))
			var_input.set_attribute(rt.new_string('data-wp-bind--tabindex'), rt.new_string('state.tabindex'))
			var_input.set_attribute(rt.new_string('aria-hidden'), rt.new_string('true'))
			var_input.set_attribute(rt.new_string('tabindex'), rt.new_string('-1'))
		}
	}
	if var_query_params.dup().array_count() > 0 {
		{
			mut iter_1 := var_query_params.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_param := item_1.key
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
	}
	if var_show_button {
		mut var_button_classes := [rt.new_string('wp-block-search__button')]
		mut var_button_internal_markup := rt.new_string(rt.new_string(''))
		if !(!rt.is_true(var_color_classes)) {
			var_button_classes << var_color_classes.dup()
		}
		if !(!rt.is_true(var_typography_classes)) {
			var_button_classes << var_typography_classes.dup()
		}
		if !(var_is_button_inside) && !(!rt.is_true(var_border_color_classes)) {
			var_button_classes << var_border_color_classes.dup()
		}
		if !(var_use_icon_button) {
			if !(!rt.is_true(var_attributes.array_get('buttonText'))) {
				var_button_internal_markup = rt.call_function('wp_kses_post', [var_attributes.array_get('buttonText')])
			}
		} else {
			var_button_classes << rt.new_string('has-icon')
			var_button_internal_markup = rt.new_string(rt.new_string('<svg class="search-icon" viewBox="0 0 24 24" width="24" height="24">\n\t\t\t\t\t<path d="M13 5c-3.3 0-6 2.7-6 6 0 1.4.5 2.7 1.3 3.7l-3.8 3.8 1.1 1.1 3.8-3.8c1 .8 2.3 1.3 3.7 1.3 3.3 0 6-2.7 6-6S16.3 5 13 5zm0 10.5c-2.5 0-4.5-2-4.5-4.5s2-4.5 4.5-4.5 4.5 2 4.5 4.5-2 4.5-4.5 4.5z"></path>\n\t\t\t\t</svg>'))
		}
		var_button_classes << rt.call_function('wp_theme_get_element_class_name', [rt.new_string('button')])
		var_button = create_wp_html_tag_processor(rt.call_function('sprintf', [rt.new_string('<button type="submit" %s>%s</button>'), var_inline_styles.array_get('button'), var_button_internal_markup.dup()]))
		if rt.is_true(rt.call_method(var_button, 'next_tag', []rt.PhpVal{})) {
			rt.call_method(var_button, 'add_class', [rt.call_function('implode', [rt.new_string(' '), var_button_classes.dup()])])
			if rt.is_true(rt.identical(rt.new_string('button-only'), var_attributes.array_get('buttonPosition'))) {
				rt.call_method(var_button, 'set_attribute', [rt.new_string('data-wp-bind--aria-label'), rt.new_string('state.ariaLabel')])
				rt.call_method(var_button, 'set_attribute', [rt.new_string('data-wp-bind--aria-controls'), rt.new_string('state.ariaControls')])
				rt.call_method(var_button, 'set_attribute', [rt.new_string('data-wp-bind--aria-expanded'), rt.new_string('context.isSearchInputVisible')])
				rt.call_method(var_button, 'set_attribute', [rt.new_string('data-wp-bind--type'), rt.new_string('state.type')])
				rt.call_method(var_button, 'set_attribute', [rt.new_string('data-wp-on--click'), rt.new_string('actions.openSearchInput')])
				rt.call_method(var_button, 'set_attribute', [rt.new_string('aria-label'), rt.call_function('__', [rt.new_string('Expand search field')])])
				rt.call_method(var_button, 'set_attribute', [rt.new_string('aria-controls'), 'wp-block-search__input-' + (var_input_id).str()])
				rt.call_method(var_button, 'set_attribute', [rt.new_string('aria-expanded'), rt.new_string('false')])
				rt.call_method(var_button, 'set_attribute', [rt.new_string('type'), rt.new_string('button')])
			} else {
				rt.call_method(var_button, 'set_attribute', [rt.new_string('aria-label'), rt.call_function('wp_strip_all_tags', [var_attributes.array_get('buttonText')])])
			}
		}
	}
	mut var_field_markup_classes := [rt.new_string('wp-block-search__inside-wrapper')]
	if var_is_button_inside && !(!rt.is_true(var_border_color_classes)) {
		var_field_markup_classes << var_border_color_classes.dup()
	}
	mut var_field_markup := rt.call_function('sprintf', [rt.new_string('<div class="%s" %s>%s</div>'), rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), var_field_markup_classes.dup()])]), var_inline_styles.array_get('wrapper'), (var_input).str() + var_query_params_markup + (var_button).str()])
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [rt.create_array([rt.ArrayItem{ key: 'class', val: var_classnames }])])
	mut var_form_directives := rt.new_string(rt.new_string(''))
	if var_is_expandable_searchfield {
		mut var_aria_label_expanded := rt.call_function('__', [rt.new_string('Submit Search')])
		mut var_aria_label_collapsed := rt.call_function('__', [rt.new_string('Expand search field')])
		mut var_form_context := rt.call_function('wp_interactivity_data_wp_context', [rt.create_array([rt.ArrayItem{ key: 'isSearchInputVisible', val: var_open_by_default }, rt.ArrayItem{ key: 'inputId', val: var_input_id }, rt.ArrayItem{ key: 'ariaLabelExpanded', val: var_aria_label_expanded }, rt.ArrayItem{ key: 'ariaLabelCollapsed', val: var_aria_label_collapsed }])])
		var_form_directives = rt.new_string('\n\t\t data-wp-interactive="core/search"\n\t\t ' + (var_form_context).str() + '\n\t\t data-wp-class--wp-block-search__searchfield-hidden="!context.isSearchInputVisible"\n\t\t data-wp-on--keydown="actions.handleSearchKeydown"\n\t\t data-wp-on--focusout="actions.handleSearchFocusout"\n\t\t')
	}
	return rt.call_function('sprintf', [rt.new_string('<form role="search" method="get" action="%1s" %2s %3s>%4s</form>'), rt.call_function('esc_url', [rt.call_function('home_url', [rt.new_string('/')])]), var_wrapper_attributes.dup(), var_form_directives.dup(), rt.concat(var_label, var_field_markup)])
}

fn register_block_core_search() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/search', rt.create_array([rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_search' }])])
}

fn classnames_for_block_core_search(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_classnames := rt.new_array()
	if !(!rt.is_true(var_attributes.array_get('buttonPosition'))) {
		if rt.is_true(rt.identical(rt.new_string('button-inside'), var_attributes.array_get('buttonPosition'))) {
			var_classnames.array_push('wp-block-search__button-inside')
		}
		if rt.is_true(rt.identical(rt.new_string('button-outside'), var_attributes.array_get('buttonPosition'))) {
			var_classnames.array_push('wp-block-search__button-outside')
		}
		if rt.is_true(rt.identical(rt.new_string('no-button'), var_attributes.array_get('buttonPosition'))) {
			var_classnames.array_push('wp-block-search__no-button')
		}
		if rt.is_true(rt.identical(rt.new_string('button-only'), var_attributes.array_get('buttonPosition'))) {
			var_classnames.array_push('wp-block-search__button-only wp-block-search__searchfield-hidden')
		}
	}
	if var_attributes.array_isset(rt.new_string('buttonUseIcon')) {
		if rt.is_true(rt.new_bool(!(!rt.is_true(var_attributes.array_get('buttonPosition'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			if rt.is_true(var_attributes.array_get('buttonUseIcon')) {
				var_classnames.array_push('wp-block-search__icon-button')
			} else {
				var_classnames.array_push('wp-block-search__text-button')
			}
		}
	}
	return rt.call_function('implode', [rt.new_string(' '), var_classnames.dup()])
}

fn apply_block_core_search_border_style(var_attributes rt.PhpVal, var_property rt.PhpVal, var_side rt.PhpVal, var_wrapper_styles rt.PhpVal, var_button_styles rt.PhpVal, var_input_styles rt.PhpVal) {
	mut var_is_button_inside := var_attributes.array_isset(rt.new_string('buttonPosition')) && rt.is_true(rt.identical(rt.new_string('button-inside'), var_attributes.array_get('buttonPosition')))
	mut var_path := [rt.new_string('style'), rt.new_string('border'), var_property]
	if rt.is_true(var_side) {
		rt.call_function('array_splice', [var_path.dup(), rt.new_int(2), rt.new_int(0), var_side.dup()])
	}
	mut var_value := rt.call_function('_wp_array_get', [var_attributes.dup(), var_path.dup(), rt.new_bool(false)])
	if !rt.is_true(var_value) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('color'), var_property)) && rt.is_true(var_side))) {
		mut var_has_color_preset := rt.call_function('str_contains', [var_value.dup(), rt.new_string('var:preset|color|')])
		if rt.is_true(var_has_color_preset) {
			mut var_named_color_value := rt.call_function('substr', [var_value.dup(), rt.add(rt.call_function('strrpos', [var_value.dup(), rt.new_string('|')]), rt.new_int(1))])
			var_value = rt.call_function('sprintf', [rt.new_string('var(--wp--preset--color--%s)'), var_named_color_value.dup()])
		}
	}
	mut var_property_suffix := if rt.is_true(var_side) { rt.call_function('sprintf', [rt.new_string('%s-%s'), var_side.dup(), var_property.dup()]) } else { var_property }
	if var_is_button_inside {
		var_wrapper_styles << rt.call_function('sprintf', [rt.new_string('border-%s: %s;'), var_property_suffix.dup(), rt.call_function('esc_attr', [var_value.dup()])])
	} else {
		var_button_styles << rt.call_function('sprintf', [rt.new_string('border-%s: %s;'), var_property_suffix.dup(), rt.call_function('esc_attr', [var_value.dup()])])
		var_input_styles << rt.call_function('sprintf', [rt.new_string('border-%s: %s;'), var_property_suffix.dup(), rt.call_function('esc_attr', [var_value.dup()])])
	}
}

fn apply_block_core_search_border_styles(var_attributes rt.PhpVal, property string, var_wrapper_styles rt.PhpVal, var_button_styles rt.PhpVal, var_input_styles rt.PhpVal) {
	apply_block_core_search_border_style(var_attributes.dup(), rt.new_string(property), rt.new_null(), var_wrapper_styles.dup(), var_button_styles.dup(), var_input_styles.dup())
	apply_block_core_search_border_style(var_attributes.dup(), rt.new_string(property), rt.new_string('top'), var_wrapper_styles.dup(), var_button_styles.dup(), var_input_styles.dup())
	apply_block_core_search_border_style(.dup(), , , .dup(), .dup(), .dup())
	
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_wp_html_tag_processor() &Class_WP_HTML_Tag_Processor {
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




pub fn init_wp_includes_blocks_search_php() {
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('register_block_core_search')])
}
