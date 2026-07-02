import rt

fn render_block_core_template_part(var_attributes rt.PhpVal) string {
	mut var_seen_ids := rt.new_null()
	mut var_wp_embed := rt.new_null()
	mut var_template_part_id := rt.new_null()
	mut var_content := rt.new_null()
	mut var_area := rt.new_null()
	mut var_theme := rt.new_null()
	mut var_template_part_query := rt.new_null()
	mut var_template_part_post := rt.new_null()
	mut var_block_template := rt.new_null()
	mut var_template_part_file_path := rt.new_null()
	mut var_block_template_file := rt.new_null()
	mut var_is_debug := false
	mut var_area_definition := rt.new_null()
	mut var_defined_areas := rt.new_null()
	mut var_defined_area := map[string]rt.PhpVal{}
	mut var_area_tag := rt.new_null()
	mut var_html_tag := rt.new_null()
	mut var_wrapper_attributes := rt.new_null()
	var_template_part_id = rt.new_null()
	var_content = rt.new_null()
	var_area = rt.get_constant('WP_TEMPLATE_PART_AREA_UNCATEGORIZED')
	var_theme = if !(var_attributes.array_get(rt.new_string('theme'))).is_null() {
		var_attributes.array_get(rt.new_string('theme'))
	} else {
		rt.call_function('get_stylesheet', []rt.PhpVal{})
	}
	if var_attributes.array_isset(rt.new_string('slug'))
		&& rt.is_true(rt.identical(rt.call_function('get_stylesheet', []rt.PhpVal{}), var_theme)) {
		var_template_part_id = rt.new_string(var_theme.str() + '//' +
			(var_attributes.array_get(rt.new_string('slug'))).str())
		var_template_part_query = create_wp_query(rt.create_array([
			rt.ArrayItem{ key: 'post_type', val: 'wp_template_part' },
			rt.ArrayItem{ key: 'post_status', val: 'publish' },
			rt.ArrayItem{ key: 'post_name__in', val: rt.create_array([
				rt.ArrayItem{ key: none, val: var_attributes.array_get(rt.new_string('slug')) },
			]) },
			rt.ArrayItem{ key: 'tax_query', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'taxonomy', val: 'wp_theme' },
					rt.ArrayItem{ key: 'field', val: 'name' },
					rt.ArrayItem{ key: 'terms', val: var_theme },
				]) },
			]) },
			rt.ArrayItem{ key: 'posts_per_page', val: 1 },
			rt.ArrayItem{ key: 'no_found_rows', val: true },
			rt.ArrayItem{ key: 'lazy_load_term_meta', val: false },
		]))
		var_template_part_post = if rt.is_true(var_template_part_query.have_posts()) {
			var_template_part_query.next_post()
		} else {
			rt.new_null()
		}
		if rt.is_true(var_template_part_post) {
			var_block_template = rt.call_function('_build_block_template_result_from_post', [
				var_template_part_post.clone(),
			])
			var_content = rt.get_property(var_block_template, 'content')
			if !(rt.get_property(var_block_template, 'area')).is_null() {
				var_area = rt.get_property(var_block_template, 'area')
			}
			rt.call_function('do_action', [
				rt.new_string('render_block_core_template_part_post'),
				var_template_part_id.clone(),
				rt.create_array_from_native_map(var_attributes),
				var_template_part_post.clone(),
				var_content.clone(),
			])
		} else {
			var_template_part_file_path = rt.new_string('')
			if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('validate_file', [
				var_attributes.array_get(rt.new_string('slug')),
			])))
			{
				var_block_template = rt.call_function('get_block_file_template', [
					var_template_part_id.clone(),
					rt.new_string('wp_template_part'),
				])
				if !(rt.get_property(var_block_template, 'content')).is_null() {
					var_content = rt.get_property(var_block_template, 'content')
				}
				if !(rt.get_property(var_block_template, 'area')).is_null() {
					var_area = rt.get_property(var_block_template, 'area')
				}
				var_block_template_file = rt.call_function('_get_block_template_file', [
					rt.new_string('wp_template_part'),
					var_attributes.array_get(rt.new_string('slug')),
				])
				if rt.is_true(var_block_template_file) {
					var_template_part_file_path =
						var_block_template_file.array_get(rt.new_string('path'))
				}
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_content))))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_content)))) {
				rt.call_function('do_action', [
					rt.new_string('render_block_core_template_part_file'),
					var_template_part_id.clone(),
					rt.create_array_from_native_map(var_attributes),
					var_template_part_file_path.clone(),
					var_content.clone(),
				])
			} else {
				rt.call_function('do_action', [
					rt.new_string('render_block_core_template_part_none'),
					var_template_part_id.clone(),
					rt.create_array_from_native_map(var_attributes),
					var_template_part_file_path.clone(),
				])
			}
		}
	}
	var_is_debug = rt.is_true(rt.get_constant('WP_DEBUG'))
		&& rt.is_true(rt.get_constant('WP_DEBUG_DISPLAY'))
	if rt.is_true(rt.new_bool(var_content.clone().is_null())) {
		if var_is_debug && var_attributes.array_isset(rt.new_string('slug')) {
			return (rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Template part has been deleted or is unavailable: %s'),
				]),
				var_attributes.array_get(rt.new_string('slug')),
			])).str()
		}
		return ''
	}
	if var_seen_ids.array_isset(var_template_part_id) {
		return (if var_is_debug {
			rt.call_function('__', [rt.new_string('[block rendering halted]')])
		} else {
			rt.new_string('')
		}).str()
	}
	var_area_definition = rt.new_null()
	var_defined_areas = rt.call_function('get_allowed_block_template_part_areas', []rt.PhpVal{})
	mut iter_1 := var_defined_areas.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_defined_area_shadow := item_1.val
		if rt.is_true(rt.identical(var_defined_area_shadow['area'], var_area)) {
			var_area_definition = var_defined_area_shadow
			break
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_area_definition)))) {
		var_area = rt.get_constant('WP_TEMPLATE_PART_AREA_UNCATEGORIZED')
	}
	var_content = rt.call_function('shortcode_unautop', [var_content.clone()])
	var_content = rt.call_function('do_shortcode', [var_content.clone()])
	var_seen_ids.array_set(var_template_part_id, true)
	var_content = rt.call_function('do_blocks', [var_content.clone()])
	var_seen_ids.array_unset(var_template_part_id)
	var_content = rt.call_function('wptexturize', [var_content.clone()])
	var_content = rt.call_function('convert_smilies', [var_content.clone()])
	var_content = rt.call_function('wp_filter_content_tags', [
		var_content.clone(), rt.new_string('template_part_${var_area.to_string()}')])
	var_content = rt.call_method(var_wp_embed, 'autoembed', [
		var_content.clone()])
	if !rt.is_true(var_attributes.array_get(rt.new_string('tagName')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('tag_escape', [var_attributes.array_get(rt.new_string('tagName'))]), var_attributes.array_get(rt.new_string('tagName')))))) {
		var_area_tag = rt.new_string('div')
		if rt.is_true(var_area_definition)
			&& var_area_definition.array_isset(rt.new_string('area_tag')) {
			var_area_tag = var_area_definition.array_get(rt.new_string('area_tag'))
		}
		var_html_tag = var_area_tag.clone()
	} else {
		var_html_tag = rt.call_function('esc_attr', [
			var_attributes.array_get(rt.new_string('tagName')),
		])
	}
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{})
	return '<${var_html_tag.to_string()} ${var_wrapper_attributes.to_string()}>' +
		(rt.call_function('str_replace', [rt.new_string(']]>'), rt.new_string(']]&gt;'), var_content.clone()])).str() +
		'</${var_html_tag.to_string()}>'
}

fn build_template_part_block_area_variations(var_instance_variations rt.PhpVal) rt.PhpVal {
	mut var_variations := []rt.PhpVal{}
	mut var_defined_areas := rt.new_null()
	mut var_area := rt.new_null()
	mut var_has_instance_for_area := false
	mut var_variation := map[string]rt.PhpVal{}
	mut var_scope := rt.new_null()
	var_variations = []rt.PhpVal{}
	var_defined_areas = rt.call_function('get_allowed_block_template_part_areas', []rt.PhpVal{})
	mut iter_2 := var_defined_areas.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_area_shadow := item_2.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('uncategorized'), var_area_shadow.array_get(rt.new_string('area'))))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('navigation-overlay'), var_area_shadow.array_get(rt.new_string('area')))))) {
			var_has_instance_for_area = false
			mut iter_3 := var_instance_variations.iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_variation_shadow := item_3.val
				if rt.is_true(rt.identical(var_variation_shadow['attributes'].array_get(rt.new_string('area')),
					var_area_shadow.array_get(rt.new_string('area'))))
				{
					var_has_instance_for_area = true
					break
				}
			}
			var_scope = if var_has_instance_for_area { []rt.PhpVal{} } else { rt.create_array([
					rt.ArrayItem{ key: none, val: 'inserter' },
				]) }
			var_variations << rt.create_array([
				rt.ArrayItem{ key: 'name', val: 'area_' +
					(var_area_shadow.array_get(rt.new_string('area'))).str() },
				rt.ArrayItem{ key: 'title', val: var_area_shadow.array_get(rt.new_string('label')) },
				rt.ArrayItem{
					key: 'description'
					val: var_area_shadow.array_get(rt.new_string('description'))
				},
				rt.ArrayItem{ key: 'attributes', val: rt.create_array([
					rt.ArrayItem{ key: 'area', val: var_area_shadow.array_get(rt.new_string('area')) },
				]) },
				rt.ArrayItem{ key: 'scope', val: var_scope },
				rt.ArrayItem{ key: 'icon', val: var_area_shadow.array_get(rt.new_string('icon')) },
			])
		}
	}
	return var_variations.clone()
}

fn build_template_part_block_instance_variations() rt.PhpVal {
	mut var_variations := []rt.PhpVal{}
	mut var_template_parts := rt.new_null()
	mut var_defined_areas := rt.new_null()
	mut var_icon_by_area := rt.new_null()
	mut var_template_part := rt.new_null()
	mut var_scope := rt.new_null()
	if rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})) {
		return []rt.PhpVal{}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('block-templates')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('block-template-parts')]))))) {
		return []rt.PhpVal{}
	}
	var_variations = []rt.PhpVal{}
	var_template_parts = rt.call_function('get_block_templates', [
		rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'wp_template_part' }]),
		rt.new_string('wp_template_part'),
	])
	var_defined_areas = rt.call_function('get_allowed_block_template_part_areas', []rt.PhpVal{})
	var_icon_by_area = rt.call_function('array_combine', [
		rt.call_function('array_column', [var_defined_areas.clone(),
			rt.new_string('area')]),
		rt.call_function('array_column', [var_defined_areas.clone(),
			rt.new_string('icon')]),
	])
	mut iter_4 := var_template_parts.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_template_part_shadow := item_4.val
		var_scope = if rt.is_true(rt.identical(rt.new_string('navigation-overlay'), rt.get_property(var_template_part_shadow, 'area'))) { []rt.PhpVal{} } else { rt.create_array([
				rt.ArrayItem{ key: none, val: 'inserter' },
			]) }
		var_variations << rt.create_array([
			rt.ArrayItem{
				key: 'name'
				val: 'instance_' +(rt.call_function('sanitize_title', [rt.get_property(var_template_part_shadow, 'slug')])).str()
			},
			rt.ArrayItem{ key: 'title', val: rt.get_property(var_template_part_shadow, 'title') },
			rt.ArrayItem{ key: 'description', val:
				rt.is_true(rt.get_property(var_template_part_shadow, 'description'))
				|| rt.is_true(rt.new_string('&nbsp;')) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'slug', val: rt.get_property(var_template_part_shadow, 'slug') },
				rt.ArrayItem{ key: 'theme', val: rt.get_property(var_template_part_shadow, 'theme') },
				rt.ArrayItem{ key: 'area', val: rt.get_property(var_template_part_shadow, 'area') },
			]) },
			rt.ArrayItem{ key: 'scope', val: var_scope },
			rt.ArrayItem{
				key: 'icon'
				val: if !(var_icon_by_area.array_get(rt.get_property(var_template_part_shadow,
					'area'))).is_null() {
					var_icon_by_area.array_get(rt.get_property(var_template_part_shadow, 'area'))
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{ key: 'example', val: rt.create_array([
				rt.ArrayItem{ key: 'attributes', val: rt.create_array([
					rt.ArrayItem{ key: 'slug', val: rt.get_property(var_template_part_shadow,
						'slug') },
					rt.ArrayItem{ key: 'theme', val: rt.get_property(var_template_part_shadow,
						'theme') },
					rt.ArrayItem{ key: 'area', val: rt.get_property(var_template_part_shadow,
						'area') },
				]) },
			]) },
		])
	}
	return var_variations.clone()
}

fn build_template_part_block_variations() rt.PhpVal {
	mut var_instance_variations := rt.new_null()
	mut var_area_variations := rt.new_null()
	var_instance_variations = build_template_part_block_instance_variations()
	var_area_variations = build_template_part_block_area_variations(var_instance_variations.clone())
	return rt.call_function('array_merge', [var_area_variations.clone(),
		var_instance_variations.clone()])
}

fn register_block_core_template_part() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/template-part'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_template_part' },
			rt.ArrayItem{ key: 'variation_callback', val: 'build_template_part_block_variations' },
		]),
	])
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_template_part')])
}
