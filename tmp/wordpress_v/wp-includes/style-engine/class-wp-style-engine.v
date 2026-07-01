import rt

pub fn Class_WP_Style_Engine.block_style_definitions_metadata() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'background', val: rt.create_array([rt.ArrayItem{ key: 'backgroundImage', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'background-image' }]) }, rt.ArrayItem{ key: 'value_func', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_WP_Style_Engine.class() }, rt.ArrayItem{ key: none, val: 'get_url_or_value_css_declaration' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'background' }, rt.ArrayItem{ key: none, val: 'backgroundImage' }]) }]) }, rt.ArrayItem{ key: 'backgroundPosition', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'background-position' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'background' }, rt.ArrayItem{ key: none, val: 'backgroundPosition' }]) }]) }, rt.ArrayItem{ key: 'backgroundRepeat', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'background-repeat' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'background' }, rt.ArrayItem{ key: none, val: 'backgroundRepeat' }]) }]) }, rt.ArrayItem{ key: 'backgroundSize', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'background-size' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'background' }, rt.ArrayItem{ key: none, val: 'backgroundSize' }]) }]) }, rt.ArrayItem{ key: 'backgroundAttachment', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'background-attachment' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'background' }, rt.ArrayItem{ key: none, val: 'backgroundAttachment' }]) }]) }]) }, rt.ArrayItem{ key: 'color', val: rt.create_array([rt.ArrayItem{ key: 'text', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'color' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'color' }, rt.ArrayItem{ key: none, val: 'text' }]) }, rt.ArrayItem{ key: 'css_vars', val: rt.create_array([rt.ArrayItem{ key: 'color', val: '--wp--preset--color--$slug' }]) }, rt.ArrayItem{ key: 'classnames', val: rt.create_array([rt.ArrayItem{ key: 'has-text-color', val: true }, rt.ArrayItem{ key: 'has-$slug-color', val: 'color' }]) }]) }, rt.ArrayItem{ key: 'background', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'background-color' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'color' }, rt.ArrayItem{ key: none, val: 'background' }]) }, rt.ArrayItem{ key: 'css_vars', val: rt.create_array([rt.ArrayItem{ key: 'color', val: '--wp--preset--color--$slug' }]) }, rt.ArrayItem{ key: 'classnames', val: rt.create_array([rt.ArrayItem{ key: 'has-background', val: true }, rt.ArrayItem{ key: 'has-$slug-background-color', val: 'color' }]) }]) }, rt.ArrayItem{ key: 'gradient', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'background' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'color' }, rt.ArrayItem{ key: none, val: 'gradient' }]) }, rt.ArrayItem{ key: 'css_vars', val: rt.create_array([rt.ArrayItem{ key: 'gradient', val: '--wp--preset--gradient--$slug' }]) }, rt.ArrayItem{ key: 'classnames', val: rt.create_array([rt.ArrayItem{ key: 'has-background', val: true }, rt.ArrayItem{ key: 'has-$slug-gradient-background', val: 'gradient' }]) }]) }]) }, rt.ArrayItem{ key: 'border', val: rt.create_array([rt.ArrayItem{ key: 'color', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'border-color' }, rt.ArrayItem{ key: 'individual', val: 'border-%s-color' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'color' }]) }, rt.ArrayItem{ key: 'classnames', val: rt.create_array([rt.ArrayItem{ key: 'has-border-color', val: true }, rt.ArrayItem{ key: 'has-$slug-border-color', val: 'color' }]) }]) }, rt.ArrayItem{ key: 'radius', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'border-radius' }, rt.ArrayItem{ key: 'individual', val: 'border-%s-radius' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'radius' }]) }, rt.ArrayItem{ key: 'css_vars', val: rt.create_array([rt.ArrayItem{ key: 'border-radius', val: '--wp--preset--border-radius--$slug' }]) }]) }, rt.ArrayItem{ key: 'style', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'border-style' }, rt.ArrayItem{ key: 'individual', val: 'border-%s-style' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'style' }]) }]) }, rt.ArrayItem{ key: 'width', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'border-width' }, rt.ArrayItem{ key: 'individual', val: 'border-%s-width' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'width' }]) }]) }, rt.ArrayItem{ key: 'top', val: rt.create_array([rt.ArrayItem{ key: 'value_func', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_WP_Style_Engine.class() }, rt.ArrayItem{ key: none, val: 'get_individual_property_css_declarations' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'top' }]) }, rt.ArrayItem{ key: 'css_vars', val: rt.create_array([rt.ArrayItem{ key: 'color', val: '--wp--preset--color--$slug' }]) }]) }, rt.ArrayItem{ key: 'right', val: rt.create_array([rt.ArrayItem{ key: 'value_func', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_WP_Style_Engine.class() }, rt.ArrayItem{ key: none, val: 'get_individual_property_css_declarations' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'right' }]) }, rt.ArrayItem{ key: 'css_vars', val: rt.create_array([rt.ArrayItem{ key: 'color', val: '--wp--preset--color--$slug' }]) }]) }, rt.ArrayItem{ key: 'bottom', val: rt.create_array([rt.ArrayItem{ key: 'value_func', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_WP_Style_Engine.class() }, rt.ArrayItem{ key: none, val: 'get_individual_property_css_declarations' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'bottom' }]) }, rt.ArrayItem{ key: 'css_vars', val: rt.create_array([rt.ArrayItem{ key: 'color', val: '--wp--preset--color--$slug' }]) }]) }, rt.ArrayItem{ key: 'left', val: rt.create_array([rt.ArrayItem{ key: 'value_func', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_WP_Style_Engine.class() }, rt.ArrayItem{ key: none, val: 'get_individual_property_css_declarations' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'left' }]) }, rt.ArrayItem{ key: 'css_vars', val: rt.create_array([rt.ArrayItem{ key: 'color', val: '--wp--preset--color--$slug' }]) }]) }]) }, rt.ArrayItem{ key: 'shadow', val: rt.create_array([rt.ArrayItem{ key: 'shadow', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'box-shadow' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'shadow' }]) }, rt.ArrayItem{ key: 'css_vars', val: rt.create_array([rt.ArrayItem{ key: 'shadow', val: '--wp--preset--shadow--$slug' }]) }]) }]) }, rt.ArrayItem{ key: 'dimensions', val: rt.create_array([rt.ArrayItem{ key: 'aspectRatio', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'aspect-ratio' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'dimensions' }, rt.ArrayItem{ key: none, val: 'aspectRatio' }]) }, rt.ArrayItem{ key: 'classnames', val: rt.create_array([rt.ArrayItem{ key: 'has-aspect-ratio', val: true }]) }]) }, rt.ArrayItem{ key: 'height', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'height' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'dimensions' }, rt.ArrayItem{ key: none, val: 'height' }]) }, rt.ArrayItem{ key: 'css_vars', val: rt.create_array([rt.ArrayItem{ key: 'dimension', val: '--wp--preset--dimension--$slug' }]) }]) }, rt.ArrayItem{ key: 'minHeight', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'min-height' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'dimensions' }, rt.ArrayItem{ key: none, val: 'minHeight' }]) }, rt.ArrayItem{ key: 'css_vars', val: rt.create_array([rt.ArrayItem{ key: 'dimension', val: '--wp--preset--dimension--$slug' }]) }]) }, rt.ArrayItem{ key: 'width', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'width' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'dimensions' }, rt.ArrayItem{ key: none, val: 'width' }]) }, rt.ArrayItem{ key: 'css_vars', val: rt.create_array([rt.ArrayItem{ key: 'dimension', val: '--wp--preset--dimension--$slug' }]) }]) }]) }, rt.ArrayItem{ key: 'spacing', val: rt.create_array([rt.ArrayItem{ key: 'padding', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'padding' }, rt.ArrayItem{ key: 'individual', val: 'padding-%s' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'padding' }]) }, rt.ArrayItem{ key: 'css_vars', val: rt.create_array([rt.ArrayItem{ key: 'spacing', val: '--wp--preset--spacing--$slug' }]) }]) }, rt.ArrayItem{ key: 'margin', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'margin' }, rt.ArrayItem{ key: 'individual', val: 'margin-%s' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'margin' }]) }, rt.ArrayItem{ key: 'css_vars', val: rt.create_array([rt.ArrayItem{ key: 'spacing', val: '--wp--preset--spacing--$slug' }]) }]) }]) }, rt.ArrayItem{ key: 'typography', val: rt.create_array([rt.ArrayItem{ key: 'fontSize', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'font-size' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'fontSize' }]) }, rt.ArrayItem{ key: 'css_vars', val: rt.create_array([rt.ArrayItem{ key: 'font-size', val: '--wp--preset--font-size--$slug' }]) }, rt.ArrayItem{ key: 'classnames', val: rt.create_array([rt.ArrayItem{ key: 'has-$slug-font-size', val: 'font-size' }]) }]) }, rt.ArrayItem{ key: 'fontFamily', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'font-family' }]) }, rt.ArrayItem{ key: 'css_vars', val: rt.create_array([rt.ArrayItem{ key: 'font-family', val: '--wp--preset--font-family--$slug' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'fontFamily' }]) }, rt.ArrayItem{ key: 'classnames', val: rt.create_array([rt.ArrayItem{ key: 'has-$slug-font-family', val: 'font-family' }]) }]) }, rt.ArrayItem{ key: 'fontStyle', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'font-style' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'fontStyle' }]) }]) }, rt.ArrayItem{ key: 'fontWeight', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'font-weight' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'fontWeight' }]) }]) }, rt.ArrayItem{ key: 'lineHeight', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'line-height' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'lineHeight' }]) }]) }, rt.ArrayItem{ key: 'textColumns', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'column-count' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'textColumns' }]) }]) }, rt.ArrayItem{ key: 'textDecoration', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'text-decoration' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'textDecoration' }]) }]) }, rt.ArrayItem{ key: 'textIndent', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'text-indent' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'textIndent' }]) }]) }, rt.ArrayItem{ key: 'textTransform', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'text-transform' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'textTransform' }]) }]) }, rt.ArrayItem{ key: 'letterSpacing', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'letter-spacing' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'letterSpacing' }]) }]) }, rt.ArrayItem{ key: 'writingMode', val: rt.create_array([rt.ArrayItem{ key: 'property_keys', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'writing-mode' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'writingMode' }]) }]) }]) }])
}
struct Class_WP_Style_Engine {
	rt.PhpObjectBase
}

fn Class_WP_Style_Engine.get_slug_from_preset_value(var_style_value rt.PhpVal, var_property_key rt.PhpVal) string {
	mut var_style_value_mutated := var_style_value
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_style_value_mutated.dup().is_string())) && rt.is_true(rt.new_bool(var_property_key.dup().is_string())))) && rt.is_true(rt.call_function('str_contains', [var_style_value_mutated.dup(), rt.new_string("var:preset|${var_property_key.to_string()}|")])))) {
		mut var_index_to_splice := rt.add(rt.call_function('strrpos', [var_style_value_mutated.dup(), rt.new_string('|')]), rt.new_int(1))
		return (rt.call_function('_wp_to_kebab_case', [rt.call_function('substr', [var_style_value_mutated.dup(), var_index_to_splice.dup()])])).str()
	}
	return ''
}

fn Class_WP_Style_Engine.get_css_var_value(var_style_value rt.PhpVal, var_css_vars rt.PhpVal) string {
	mut var_style_value_mutated := var_style_value
	{
		mut iter_1 := var_css_vars.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_css_var_pattern := item_1.val
			mut var_property_key := item_1.key
			mut var_slug := Class_WP_Style_Engine.get_slug_from_preset_value(var_style_value_mutated.dup(), var_property_key.dup())
			if rt.is_true(Class_WP_Style_Engine.is_valid_style_value(var_slug.dup())) {
				mut var_var := rt.call_function('strtr', [var_css_var_pattern.dup(), rt.create_array([rt.ArrayItem{ key: '$slug', val: var_slug }])])
				return "var(${var_var.to_string()})"
			}
		}
	}
	return ''
}

fn Class_WP_Style_Engine.is_valid_style_value(var_style_value rt.PhpVal) bool {
	mut var_style_value_mutated := var_style_value
	return rt.is_true(rt.identical(rt.new_string('0'), var_style_value_mutated)) || !(!rt.is_true(var_style_value_mutated))
}

fn Class_WP_Style_Engine.store_css_rule(var_store_name rt.PhpVal, var_css_selector rt.PhpVal, var_css_declarations rt.PhpVal, rules_group string)  {
	mut var_css_declarations_mutated := var_css_declarations
	if !rt.is_true(var_store_name) || !rt.is_true(var_css_selector) || !rt.is_true(var_css_declarations_mutated) {
		return rt.new_null()
	}
	rt.call_method(rt.call_method(Class_WP_Style_Engine.get_store(var_store_name.dup()), 'add_rule', [var_css_selector.dup(), rt.new_string(rules_group)]), 'add_declarations', [var_css_declarations_mutated.dup()])
}

fn Class_WP_Style_Engine.get_store(var_store_name rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Style_Engine_CSS_Rules_Store{}; return temp.get_store(arg_0) }(var_store_name.dup())
}

fn Class_WP_Style_Engine.parse_block_styles(var_block_styles rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_parsed_styles := { 'classnames': map[string]rt.PhpVal{}, 'declarations': map[string]rt.PhpVal{} }
	if rt.is_true(rt.new_bool(!rt.is_true(var_block_styles) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_block_styles.dup().is_array()))))))) {
		return var_parsed_styles.dup()
	}
	{
		mut iter_1 := Class_static.block_style_definitions_metadata().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_definition_group_style := item_1.val
			mut var_definition_group_key := item_1.key
			if !rt.is_true(var_block_styles.array_get(var_definition_group_key)) {
				continue
			}
			{
				mut iter_2 := var_definition_group_style.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_style_definition := item_2.val
					mut var_style_value := rt.call_function('_wp_array_get', [var_block_styles.dup(), var_style_definition.array_get('path'), rt.new_null()])
					if rt.is_true(rt.new_bool(!(rt.is_true(Class_WP_Style_Engine.is_valid_style_value(var_style_value.dup()))))) {
						continue
					}
					mut var_classnames := Class_WP_Style_Engine.get_classnames(var_style_value.dup(), var_style_definition.dup())
					if !(!rt.is_true(var_classnames)) {
						var_parsed_styles['classnames'] = rt.call_function('array_merge', [var_parsed_styles.array_get('classnames'), var_classnames.dup()])
					}
					mut var_css_declarations := Class_WP_Style_Engine.get_css_declarations(var_style_value.dup(), var_style_definition.dup(), var_options.dup())
					if !(!rt.is_true(var_css_declarations)) {
						var_parsed_styles['declarations'] = rt.call_function('array_merge', [var_parsed_styles.array_get('declarations'), var_css_declarations.dup()])
					}
				}
			}
		}
	}
	return var_parsed_styles.dup()
}

fn Class_WP_Style_Engine.get_classnames(var_style_value rt.PhpVal, var_style_definition rt.PhpVal) rt.PhpVal {
	mut var_style_value_mutated := var_style_value
	mut var_style_definition_mutated := var_style_definition
	if !rt.is_true(var_style_value_mutated) {
		return map[string]rt.PhpVal{}
	}
	mut var_classnames := map[string]rt.PhpVal{}
	if !(!rt.is_true(var_style_definition_mutated.array_get('classnames'))) {
		{
			mut iter_1 := var_style_definition_mutated.array_get('classnames').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_property_key := item_1.val
				mut var_classname := item_1.key
				if rt.is_true(rt.identical(rt.new_bool(true), var_property_key)) {
					var_classnames.array_push(var_classname.dup())
					continue
				}
				mut var_slug := Class_WP_Style_Engine.get_slug_from_preset_value(var_style_value_mutated.dup(), var_property_key.dup())
				if rt.is_true(var_slug) {
					var_classnames.array_push(rt.call_function('strtr', [var_classname.dup(), rt.create_array([rt.ArrayItem{ key: '$slug', val: var_slug }])]))
				}
			}
		}
	}
	return var_classnames.dup()
}

fn Class_WP_Style_Engine.get_css_declarations(var_style_value rt.PhpVal, var_style_definition rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_style_value_mutated := var_style_value
	mut var_style_definition_mutated := var_style_definition
	if rt.is_true(rt.new_bool(var_style_definition_mutated.array_isset(rt.new_string('value_func')) && rt.is_true(rt.call_function('is_callable', [var_style_definition_mutated.array_get('value_func')])))) {
		return rt.call_function('call_user_func', [var_style_definition_mutated.array_get('value_func'), var_style_value_mutated.dup(), var_style_definition_mutated.dup(), var_options.dup()])
	}
	mut var_css_declarations := map[string]rt.PhpVal{}
	mut var_style_property_keys := var_style_definition_mutated.array_get('property_keys')
	mut var_should_skip_css_vars := rt.new_bool(rt.new_bool(var_options.array_isset(rt.new_string('convert_vars_to_classnames')) && rt.is_true(rt.identical(rt.new_bool(true), var_options.array_get('convert_vars_to_classnames')))))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_style_value_mutated.dup().is_string())) && rt.is_true(rt.call_function('str_contains', [var_style_value_mutated.dup(), rt.new_string('var:')])))) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_should_skip_css_vars)))) && !(!rt.is_true(var_style_definition_mutated.array_get('css_vars'))))) {
			mut var_css_var := Class_WP_Style_Engine.get_css_var_value(var_style_value_mutated.dup(), var_style_definition_mutated.array_get('css_vars'))
			if rt.is_true(Class_WP_Style_Engine.is_valid_style_value(var_css_var.dup())) {
				var_css_declarations.array_set(var_style_property_keys.array_get('default'), var_css_var.dup())
			}
		}
		return var_css_declarations.dup()
	}
	if rt.is_true(rt.new_bool(var_style_value_mutated.dup().is_array())) {
		if !(var_style_property_keys.array_isset(rt.new_string('individual'))) {
			return var_css_declarations.dup()
		}
		{
			mut iter_1 := var_style_value_mutated.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_key := item_1.key
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_value.dup().is_string())) && rt.is_true(rt.call_function('str_contains', [var_value.dup(), rt.new_string('var:')])))) && rt.is_true(rt.new_bool(!(rt.is_true(var_should_skip_css_vars)))))) && !(!rt.is_true(var_style_definition_mutated.array_get('css_vars'))))) {
					var_value = Class_WP_Style_Engine.get_css_var_value(var_value.dup(), var_style_definition_mutated.array_get('css_vars'))
				}
				mut var_individual_property := rt.call_function('sprintf', [var_style_property_keys.array_get('individual'), rt.call_function('_wp_to_kebab_case', [var_key.dup()])])
				if rt.is_true(rt.new_bool(rt.is_true(var_individual_property) && rt.is_true(Class_WP_Style_Engine.is_valid_style_value(var_value.dup())))) {
					var_css_declarations.array_set(var_individual_property, var_value.dup())
				}
			}
		}
		return var_css_declarations.dup()
	}
	var_css_declarations.array_set(var_style_property_keys.array_get('default'), var_style_value_mutated.dup())
	return var_css_declarations.dup()
}

fn Class_WP_Style_Engine.get_individual_property_css_declarations(var_style_value rt.PhpVal, var_individual_property_definition rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_style_value_mutated := var_style_value
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_style_value_mutated.dup().is_array()))))) || !rt.is_true(var_style_value_mutated))) || !rt.is_true(var_individual_property_definition.array_get('path')))) {
		return map[string]rt.PhpVal{}
	}
	mut var_definition_group_key := var_individual_property_definition.array_get('path').array_get(0)
	mut var_individual_property_key := var_individual_property_definition.array_get('path').array_get(1)
	mut var_should_skip_css_vars := rt.new_bool(rt.new_bool(var_options.array_isset(rt.new_string('convert_vars_to_classnames')) && rt.is_true(rt.identical(rt.new_bool(true), var_options.array_get('convert_vars_to_classnames')))))
	mut var_css_declarations := map[string]rt.PhpVal{}
	{
		mut iter_1 := var_style_value_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_css_property := item_1.key
			if !rt.is_true(var_value) {
				continue
			}
			mut var_style_definition_path := [var_definition_group_key, var_css_property]
			mut var_style_definition := rt.call_function('_wp_array_get', [Class_static.block_style_definitions_metadata(), var_style_definition_path.dup(), rt.new_null()])
			if rt.is_true(rt.new_bool(rt.is_true(var_style_definition) && var_style_definition.array_get('property_keys').array_isset(rt.new_string('individual')))) {
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_value.dup().is_string())) && rt.is_true(rt.call_function('str_contains', [var_value.dup(), rt.new_string('var:')])))) && rt.is_true(rt.new_bool(!(rt.is_true(var_should_skip_css_vars)))))) && !(!rt.is_true(var_individual_property_definition.array_get('css_vars'))))) {
					var_value = Class_WP_Style_Engine.get_css_var_value(var_value.dup(), var_individual_property_definition.array_get('css_vars'))
				}
				mut var_individual_css_property := rt.call_function('sprintf', [var_style_definition.array_get('property_keys').array_get('individual'), var_individual_property_key.dup()])
				var_css_declarations.array_set(var_individual_css_property, var_value.dup())
			}
		}
	}
	return var_css_declarations.dup()
}

fn Class_WP_Style_Engine.get_url_or_value_css_declaration(var_style_value rt.PhpVal, var_style_definition rt.PhpVal) rt.PhpVal {
	mut var_style_value_mutated := var_style_value
	mut var_style_definition_mutated := var_style_definition
	if !rt.is_true(var_style_value_mutated) {
		return map[string]rt.PhpVal{}
	}
	mut var_css_declarations := map[string]rt.PhpVal{}
	if var_style_definition_mutated.array_get('property_keys').array_isset(rt.new_string('default')) {
		mut var_value := rt.new_null()
		if !(!rt.is_true(var_style_value_mutated.array_get('url'))) {
			var_value = rt.new_string('url(\'' + (var_style_value_mutated.array_get('url')).str() + '\')')
		} else if rt.is_true(rt.new_bool(var_style_value_mutated.dup().is_string())) {
			var_value = var_style_value_mutated.dup()
		}
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_css_declarations.array_set(var_style_definition_mutated.array_get('property_keys').array_get('default'), var_value.dup())
		}
	}
	return var_css_declarations.dup()
}

fn Class_WP_Style_Engine.compile_css(var_css_declarations rt.PhpVal, var_css_selector rt.PhpVal) string {
	mut var_css_declarations_mutated := var_css_declarations
	if rt.is_true(rt.new_bool(!rt.is_true(var_css_declarations_mutated) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_css_declarations_mutated.dup().is_array()))))))) {
		return ''
	}
	if rt.is_true(var_css_selector) {
		mut var_css_rule := create_wp_style_engine_css_rule(var_css_selector.dup(), var_css_declarations_mutated.dup())
		return (var_css_rule.get_css()).str()
	}
	var_css_declarations_mutated = create_wp_style_engine_css_declarations(var_css_declarations_mutated.dup())
	return (rt.call_method(var_css_declarations_mutated, 'get_declarations_string', []rt.PhpVal{})).str()
}

fn Class_WP_Style_Engine.compile_stylesheet_from_css_rules(var_css_rules rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_processor := create_wp_style_engine_processor()
	var_processor.add_rules(var_css_rules.dup())
	return var_processor.get_css(var_options.dup())
}

struct Class_WP_Style_Engine_CSS_Rules_Store {
	rt.PhpObjectBase
}

struct Class_WP_Style_Engine_CSS_Rule {
	rt.PhpObjectBase
}

struct Class_WP_Style_Engine_CSS_Declarations {
	rt.PhpObjectBase
}

struct Class_WP_Style_Engine_Processor {
	rt.PhpObjectBase
}

fn create_wp_style_engine() &Class_WP_Style_Engine {
	mut obj := &Class_WP_Style_Engine{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_style_engine_css_rules_store() &Class_WP_Style_Engine_CSS_Rules_Store {
	mut obj := &Class_WP_Style_Engine_CSS_Rules_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_style_engine_css_rule() &Class_WP_Style_Engine_CSS_Rule {
	mut obj := &Class_WP_Style_Engine_CSS_Rule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_style_engine_css_declarations() &Class_WP_Style_Engine_CSS_Declarations {
	mut obj := &Class_WP_Style_Engine_CSS_Declarations{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_style_engine_processor() &Class_WP_Style_Engine_Processor {
	mut obj := &Class_WP_Style_Engine_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Style_Engine) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_slug_from_preset_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_WP_Style_Engine.get_slug_from_preset_value(dispatch_arg_0, dispatch_arg_1))
		}
		'get_css_var_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_WP_Style_Engine.get_css_var_value(dispatch_arg_0, dispatch_arg_1))
		}
		'is_valid_style_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Style_Engine.is_valid_style_value(dispatch_arg_0))
		}
		'store_css_rule' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			Class_WP_Style_Engine.store_css_rule(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'get_store' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Style_Engine.get_store(dispatch_arg_0)
		}
		'parse_block_styles' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Style_Engine.parse_block_styles(dispatch_arg_0, dispatch_arg_1)
		}
		'get_classnames' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Style_Engine.get_classnames(dispatch_arg_0, dispatch_arg_1)
		}
		'get_css_declarations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WP_Style_Engine.get_css_declarations(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_individual_property_css_declarations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WP_Style_Engine.get_individual_property_css_declarations(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_url_or_value_css_declaration' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Style_Engine.get_url_or_value_css_declaration(dispatch_arg_0, dispatch_arg_1)
		}
		'compile_css' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_WP_Style_Engine.compile_css(dispatch_arg_0, dispatch_arg_1))
		}
		'compile_stylesheet_from_css_rules' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Style_Engine.compile_stylesheet_from_css_rules(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_WP_Style_Engine) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Style_Engine) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Style_Engine_CSS_Rules_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Style_Engine_CSS_Rules_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Style_Engine_CSS_Rules_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Style_Engine_CSS_Rule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Style_Engine_CSS_Rule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Style_Engine_CSS_Rule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Style_Engine_CSS_Declarations) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Style_Engine_CSS_Declarations) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Style_Engine_CSS_Declarations) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Style_Engine_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Style_Engine_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Style_Engine_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_style_engine_class_wp_style_engine_php() {
}
