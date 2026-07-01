import rt

fn wp_get_block_style_variation_name_from_class(var_class_string rt.PhpVal) rt.PhpVal {
	mut var_matches := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_class_string.dup().is_string()))))) {
		return rt.new_null()
	}
	rt.call_function('preg_match_all', [
		rt.new_string('/\\bis-style-(?!default)(\\S+)\\b/'),
		var_class_string.dup(),
		var_matches.dup(),
	])
	return if !(var_matches.array_get(1)).is_null() {
		var_matches.array_get(1)
	} else {
		rt.new_null()
	}
}

fn wp_resolve_block_style_variation_ref_values(var_variation_data rt.PhpVal, var_theme_json rt.PhpVal) {
	{
		mut iter_1 := var_variation_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(var_value.dup().is_array())) {
				if rt.is_true(rt.new_bool(var_value.dup().array_isset(rt.new_string('ref')))) {
					if rt.is_true(rt.new_bool(!rt.is_true(var_value.array_get('ref'))
						|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.array_get('ref').is_string())))))))
					{
						var_variation_data.array_unset(var_key)
					}
					mut var_value_path := rt.call_function('explode', [
						rt.new_string('.'),
						if !(var_value.array_get('ref')).is_null() {
							var_value.array_get('ref')
						} else {
							rt.new_string('')
						},
					])
					mut var_ref_value := rt.call_function('_wp_array_get', [
						var_theme_json.dup(), var_value_path.dup()])
					if rt.is_true(rt.identical(rt.new_null(), var_ref_value)) {
						var_variation_data.array_unset(var_key)
					} else {
						var_value = var_ref_value.dup()
					}
				} else {
					wp_resolve_block_style_variation_ref_values(var_value.dup(),
						var_theme_json.dup())
				}
			}
		}
	}
}

fn wp_render_block_style_variation_support_styles(var_parsed_block rt.PhpVal) rt.PhpVal {
	mut var_classes := if !(var_parsed_block.array_get('attrs').array_get('className')).is_null() {
		var_parsed_block.array_get('attrs').array_get('className')
	} else {
		rt.new_null()
	}
	mut var_variations := wp_get_block_style_variation_name_from_class(var_classes.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_variations)))) {
		return var_parsed_block.dup()
	}
	mut var_tree := fn () rt.PhpVal {
		mut temp := Class_WP_Theme_JSON_Resolver{}
		return temp.get_merged_data()
	}()
	mut var_theme_json := rt.call_method(var_tree, 'get_raw_data', []rt.PhpVal{})
	mut var_variation_data := rt.new_array()
	{
		mut iter_1 := var_variations.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_variation := item_1.val
			var_variation_data = if !(var_theme_json.array_get('styles').array_get('blocks').array_get(var_parsed_block.array_get('blockName')).array_get('variations').array_get(var_variation)).is_null() {
				var_theme_json.array_get('styles').array_get('blocks').array_get(var_parsed_block.array_get('blockName')).array_get('variations').array_get(var_variation)
			} else {
				rt.new_array()
			}
			if !(!rt.is_true(var_variation_data)) {
				break
			}
		}
	}
	if !rt.is_true(var_variation_data) {
		return var_parsed_block.dup()
	}
	wp_resolve_block_style_variation_ref_values(var_variation_data.dup(), var_theme_json.dup())
	mut var_variation_instance := rt.call_function('wp_unique_id', [var_variation.str() + '--'])
	mut var_class_name := 'is-style-${var_variation_instance.to_string()}'
	mut var_updated_class_name := rt.new_string(
		(var_parsed_block.array_get('attrs').array_get('className')).str() + ' ${var_class_name}')
	mut var_elements_data := if !(var_variation_data.array_get('elements')).is_null() {
		var_variation_data.array_get('elements')
	} else {
		rt.new_array()
	}
	mut var_blocks_data := if !(var_variation_data.array_get('blocks')).is_null() {
		var_variation_data.array_get('blocks')
	} else {
		rt.new_array()
	}
	var_variation_data.array_unset(rt.new_string('elements'))
	var_variation_data.array_unset(rt.new_string('blocks'))
	rt.call_function('_wp_array_set', [var_blocks_data.dup(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: var_parsed_block.array_get('blockName') },
			rt.ArrayItem{ key: none, val: 'variations' },
			rt.ArrayItem{ key: none, val: var_variation_instance },
		]),
		var_variation_data.dup()])
	mut var_config := {
		'version':  Class_WP_Theme_JSON.latest_schema()
		'settings': {
			'spacing': {
				'blockGap': rt.new_bool(true)
			}
		}
		'styles':   {
			'elements': var_elements_data
			'blocks':   var_blocks_data
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		rt.call_function('remove_filter', [
			rt.new_string('wp_theme_json_get_style_nodes'),
			rt.new_string('wp_filter_out_block_nodes'),
		])
	}
	mut var_styles_registry := fn () rt.PhpVal {
		mut temp := Class_WP_Block_Styles_Registry{}
		return temp.get_instance()
	}()
	rt.call_method(var_styles_registry, 'register', [var_parsed_block.array_get('blockName'),
		rt.create_array([rt.ArrayItem{ key: 'name', val: var_variation_instance }])])
	mut var_variation_theme_json := create_wp_theme_json(var_config.dup(), rt.new_string('blocks'))
	mut var_variation_styles := var_variation_theme_json.get_stylesheet(rt.create_array([
		rt.ArrayItem{ key: none, val: 'styles' },
	]), rt.create_array([rt.ArrayItem{ key: none, val: 'custom' }]), rt.create_array([
		rt.ArrayItem{ key: 'include_block_style_variations', val: true },
		rt.ArrayItem{ key: 'skip_root_layout_styles', val: true },
		rt.ArrayItem{ key: 'scope', val: '.${var_class_name}' },
	]))
	rt.call_method(var_styles_registry, 'unregister', [var_parsed_block.array_get('blockName'),
		var_variation_instance.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		rt.call_function('add_filter', [rt.new_string('wp_theme_json_get_style_nodes'),
			rt.new_string('wp_filter_out_block_nodes')])
	}
	if !rt.is_true(var_variation_styles) {
		return var_parsed_block.dup()
	}
	rt.call_function('wp_register_style', [rt.new_string('block-style-variation-styles'),
		rt.new_bool(false),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'wp-block-library' },
			rt.ArrayItem{ key: none, val: 'global-styles' },
		])])
	rt.call_function('wp_add_inline_style', [
		rt.new_string('block-style-variation-styles'),
		var_variation_styles.dup(),
	])
	rt.call_function('_wp_array_set', [var_parsed_block.dup(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'attrs' },
			rt.ArrayItem{ key: none, val: 'className' }]),
		var_updated_class_name.dup()])
	return var_parsed_block.dup()
}

fn wp_render_block_style_variation_class_name(var_block_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_matches := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_block_content))))
		|| !rt.is_true(var_block.array_get('attrs').array_get('className'))))
	{
		return var_block_content.dup()
	}
	rt.call_function('preg_match', [rt.new_string('/\\bis-style-(\\S+?--\\d+)\\b/'),
		var_block.array_get('attrs').array_get('className'), var_matches.dup()])
	if !rt.is_true(var_matches) {
		return var_block_content.dup()
	}
	mut var_tags := create_wp_html_tag_processor(var_block_content.dup())
	if rt.is_true(var_tags.next_tag()) {
		var_tags.add_class(var_matches.array_get(0))
	}
	return var_tags.get_updated_html()
}

fn wp_enqueue_block_style_variation_styles() {
	rt.call_function('wp_enqueue_style', [rt.new_string('block-style-variation-styles')])
}

fn wp_register_block_style_variations_from_theme_json_partials(var_variations rt.PhpVal) {
	if !rt.is_true(var_variations) {
		return rt.new_null()
	}
	mut var_registry := fn () rt.PhpVal {
		mut temp := Class_WP_Block_Styles_Registry{}
		return temp.get_instance()
	}()
	{
		mut iter_1 := var_variations.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_variation := item_1.val
			if !rt.is_true(var_variation.array_get('blockTypes'))
				|| !rt.is_true(var_variation.array_get('styles')) {
				continue
			}
			mut var_variation_name := if !(var_variation.array_get('slug')).is_null() { var_variation.array_get('slug') } else { rt.call_function('_wp_to_kebab_case', [
					var_variation.array_get('title'),
				]) }
			mut var_variation_label := if !(var_variation.array_get('title')).is_null() {
				var_variation.array_get('title')
			} else {
				var_variation_name
			}
			{
				mut iter_2 := var_variation.array_get('blockTypes').iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_block_type := item_2.val
					mut var_registered_styles := rt.call_method(var_registry,
						'get_registered_styles_for_block', [var_block_type.dup()])
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_registered_styles.dup().array_isset(var_variation_name.dup())))))) {
						rt.call_function('register_block_style', [
							var_block_type.dup(),
							rt.create_array([
								rt.ArrayItem{ key: 'name', val: var_variation_name },
								rt.ArrayItem{ key: 'label', val: var_variation_label },
							])])
					}
				}
			}
		}
	}
}

struct Class_WP_Theme_JSON_Resolver {
	rt.PhpObjectBase
}

struct Class_WP_Block_Styles_Registry {
	rt.PhpObjectBase
}

struct Class_WP_Theme_JSON {
	rt.PhpObjectBase
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_WP_Block_Supports {
	rt.PhpObjectBase
}

fn create_wp_theme_json_resolver() &Class_WP_Theme_JSON_Resolver {
	mut obj := &Class_WP_Theme_JSON_Resolver{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_styles_registry() &Class_WP_Block_Styles_Registry {
	mut obj := &Class_WP_Block_Styles_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_theme_json() &Class_WP_Theme_JSON {
	mut obj := &Class_WP_Theme_JSON{
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

fn create_wp_block_supports() &Class_WP_Block_Supports {
	mut obj := &Class_WP_Block_Supports{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Theme_JSON_Resolver) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme_JSON_Resolver) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme_JSON_Resolver) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_Theme_JSON) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme_JSON) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme_JSON) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_Block_Supports) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Supports) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Supports) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_block_supports_block_style_variations_php() {
	rt.call_method(fn () rt.PhpVal {
		mut temp := Class_WP_Block_Supports{}
		return temp.get_instance()
	}(), 'register', [rt.new_string('block-style-variation'),
		rt.new_array()])
	rt.call_function('add_filter', [rt.new_string('render_block_data'),
		rt.new_string('wp_render_block_style_variation_support_styles'),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('render_block'),
		rt.new_string('wp_render_block_style_variation_class_name'),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'),
		rt.new_string('wp_enqueue_block_style_variation_styles'),
		rt.new_int(1)])
}
