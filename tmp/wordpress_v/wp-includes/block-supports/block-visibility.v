import rt

fn wp_render_block_visibility_support(var_block_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_block_type := rt.call_method(fn () rt.PhpVal {
		mut temp := Class_WP_Block_Type_Registry{}
		return temp.get_instance()
	}(), 'get_registered', [var_block.array_get('blockName')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_block_type))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('block_has_support', [var_block_type.dup(), rt.new_string('visibility'), rt.new_bool(true)])))))))
	{
		return var_block_content.str()
	}
	mut var_block_visibility := if !(var_block.array_get('attrs').array_get('metadata').array_get('blockVisibility')).is_null() {
		var_block.array_get('attrs').array_get('metadata').array_get('blockVisibility')
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_block_visibility)) {
		return ''
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_block_visibility.dup().is_array()))
		&& !(!rt.is_true(var_block_visibility))))
	{
		mut var_viewport_config := if !(var_block_visibility.array_get('viewport')).is_null() {
			var_block_visibility.array_get('viewport')
		} else {
			rt.new_null()
		}
		if rt.is_true(rt.new_bool(
			rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_viewport_config.dup().is_array())))))
			|| !rt.is_true(var_viewport_config)))
		{
			return var_block_content.str()
		}
		mut var_viewport_sizes := [
			[rt.new_string('Mobile'), rt.new_string('mobile'),
				rt.new_string('480px')],
			[rt.new_string('Tablet'), rt.new_string('tablet'),
				rt.new_string('782px')],
			[rt.new_string('Desktop'), rt.new_string('desktop')],
		]
		mut var_viewport_media_queries := rt.new_array()
		mut var_previous_size := rt.new_null()
		for var_index, var_viewport_size in var_viewport_sizes {
			if 0 == index {
				var_viewport_media_queries.array_set(var_viewport_size.array_get('slug'), rt.concat(rt.concat(rt.new_string('@media (width <= '),
					var_viewport_size.array_get('size')), rt.new_string(')')))
			} else if rt.is_true(rt.new_bool(var_viewport_sizes.len - 1 == index
				&& rt.is_true(var_previous_size)))
			{
				var_viewport_media_queries.array_set(var_viewport_size.array_get('slug'),
					'@media (width > ${var_previous_size.to_string()})')
			} else {
				var_viewport_media_queries.array_set(var_viewport_size.array_get('slug'), rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('@media ('),
					var_previous_size), rt.new_string(' < width <= ')),
					var_viewport_size.array_get('size')), rt.new_string(')')))
			}
			var_previous_size = if !(var_viewport_size.array_get('size')).is_null() {
				var_viewport_size.array_get('size')
			} else {
				rt.new_null()
			}
		}
		mut var_hidden_on := rt.new_array()
		{
			mut iter_1 := var_viewport_config.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_is_visible := item_1.val
				mut var_viewport_config_size := item_1.key
				if rt.is_true(rt.new_bool(
					rt.is_true(rt.identical(rt.new_bool(false), var_is_visible))
					&& var_viewport_media_queries.array_isset(var_viewport_config_size)))
				{
					var_hidden_on << var_viewport_config_size.dup()
				}
			}
		}
		if !rt.is_true(var_hidden_on) {
			return var_block_content.str()
		}
		rt.call_function('sort', [var_hidden_on.dup()])
		mut var_css_rules := rt.new_array()
		mut var_class_names := rt.new_array()
		for var_hidden_viewport_size in var_hidden_on {
			mut var_visibility_class := rt.new_string('wp-block-hidden-' +
				var_hidden_viewport_size.str())
			var_class_names << var_visibility_class.dup()
			var_css_rules << rt.create_array([
				rt.ArrayItem{ key: 'selector', val: '.' + var_visibility_class.str() },
				rt.ArrayItem{ key: 'declarations', val: rt.create_array([
					rt.ArrayItem{ key: 'display', val: 'none !important' },
				]) },
				rt.ArrayItem{
					key: 'rules_group'
					val: var_viewport_media_queries.array_get(var_hidden_viewport_size)
				},
			])
		}
		rt.call_function('wp_style_engine_get_stylesheet_from_css_rules', [
			var_css_rules.dup(),
			rt.create_array([
				rt.ArrayItem{ key: 'context', val: 'block-supports' },
				rt.ArrayItem{ key: 'prettify', val: false },
			])])
		if !(!rt.is_true(var_block_content)) {
			mut var_processor := create_wp_html_tag_processor(var_block_content.dup())
			if rt.is_true(var_processor.next_tag()) {
				var_processor.add_class(rt.call_function('implode', [
					rt.new_string(' '), var_class_names.dup()]))
				for {
					if rt.is_true(rt.identical(rt.new_string('IMG'), var_processor.get_tag())) {
						var_processor.set_attribute(rt.new_string('fetchpriority'),
							rt.new_string('auto'))
					}
					if !(rt.is_true(var_processor.next_tag())) {
						break
					}
				}
				var_block_content = var_processor.get_updated_html()
			}
		}
	}
	return var_block_content.str()
}

struct Class_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_wp_block_type_registry() &Class_WP_Block_Type_Registry {
	mut obj := &Class_WP_Block_Type_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_html_tag_processor() &Class_WP_HTML_Tag_Processor {
	mut obj := &Class_WP_HTML_Tag_Processor{
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

pub fn init_wp_includes_block_supports_block_visibility_php() {
	rt.call_function('add_filter', [rt.new_string('render_block'),
		rt.new_string('wp_render_block_visibility_support'), rt.new_int(10),
		rt.new_int(2)])
}
