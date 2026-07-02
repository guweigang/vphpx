import rt

fn render_block_core_post_terms(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_classes := []rt.PhpVal{}
	mut var_separator := rt.new_null()
	mut var_wrapper_attributes := rt.new_null()
	mut var_prefix := ''
	mut var_suffix := rt.new_null()
	mut var_post_terms := rt.new_null()
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('postId')))
		|| !(var_attributes.array_isset(rt.new_string('term'))) {
		return ''
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_taxonomy_viewable', [
		var_attributes.array_get(rt.new_string('term')),
	])))))
	{
		return ''
	}
	var_classes = [
		'taxonomy-' + (var_attributes.array_get(rt.new_string('term'))).str(),
	]
	if var_attributes.array_isset(rt.new_string('textAlign')) {
		var_classes << 'has-text-align-' +
			(var_attributes.array_get(rt.new_string('textAlign'))).str()
	}
	if var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('elements')).array_get(rt.new_string('link')).array_get(rt.new_string('color')).array_isset(rt.new_string('text')) {
		var_classes << 'has-link-color'
	}
	var_separator = if !rt.is_true(var_attributes.array_get(rt.new_string('separator'))) {
		rt.new_string(' ')
	} else {
		var_attributes.array_get(rt.new_string('separator'))
	}
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'class', val: rt.call_function('implode', [
				rt.new_string(' '),
				rt.create_array_from_list(var_classes),
			]) },
		]),
	])
	var_prefix = '<div ${var_wrapper_attributes.to_string()}>'
	if var_attributes.array_isset(rt.new_string('prefix'))
		&& rt.is_true(var_attributes.array_get(rt.new_string('prefix'))) {
		var_prefix = var_prefix + '<span class="wp-block-post-terms__prefix">' +
			(var_attributes.array_get(rt.new_string('prefix'))).str() + '</span>'
	}
	var_suffix = rt.new_string('</div>')
	if var_attributes.array_isset(rt.new_string('suffix'))
		&& rt.is_true(var_attributes.array_get(rt.new_string('suffix'))) {
		var_suffix = rt.new_string('<span class="wp-block-post-terms__suffix">' +
			(var_attributes.array_get(rt.new_string('suffix'))).str() + '</span>' + var_suffix.str())
	}
	var_post_terms = rt.call_function('get_the_term_list', [
		rt.get_property(var_block, 'context').array_get(rt.new_string('postId')),
		var_attributes.array_get(rt.new_string('term')),
		rt.call_function('wp_kses_post', [rt.new_string(var_prefix.str()).clone()]),
		rt.new_string('<span class="wp-block-post-terms__separator">' +
			(rt.call_function('esc_html', [var_separator.clone()])).str() + '</span>'),
		rt.call_function('wp_kses_post', [var_suffix.clone()]),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_post_terms.clone()]))
		|| !rt.is_true(var_post_terms) {
		return ''
	}
	return var_post_terms.str()
}

fn block_core_post_terms_build_variations() rt.PhpVal {
	mut var_taxonomies := rt.new_null()
	mut var_built_ins := []rt.PhpVal{}
	mut var_custom_variations := []rt.PhpVal{}
	mut var_taxonomy := rt.new_null()
	mut var_variation := map[string]rt.PhpVal{}
	var_taxonomies = rt.call_function('get_taxonomies', [
		rt.create_array([rt.ArrayItem{ key: 'publicly_queryable', val: true },
			rt.ArrayItem{ key: 'show_in_rest', val: true }]),
		rt.new_string('objects'),
	])
	var_built_ins = []rt.PhpVal{}
	var_custom_variations = []rt.PhpVal{}
	mut iter_1 := var_taxonomies.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_taxonomy_shadow := item_1.val
		var_variation = {
			'name':        rt.get_property(var_taxonomy_shadow, 'name')
			'title':       rt.get_property(var_taxonomy_shadow, 'label')
			'description': rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Display a list of assigned terms from the taxonomy: %s'),
				]),
				rt.get_property(var_taxonomy_shadow, 'label'),
			])
			'attributes':  {
				'term': rt.get_property(var_taxonomy_shadow, 'name')
			}
			'isActive':    map[string]rt.PhpVal{}
			'scope':       map[string]rt.PhpVal{}
		}
		if rt.is_true(rt.identical(rt.new_string('category'), rt.get_property(var_taxonomy_shadow,
			'name')))
		{
			var_variation['isDefault'] = rt.new_bool(true)
		}
		if rt.is_true(rt.get_property(var_taxonomy_shadow, '_builtin')) {
			var_built_ins << var_variation.clone()
		} else {
			var_custom_variations << var_variation.clone()
		}
	}
	return rt.call_function('array_merge', [rt.create_array_from_list(var_built_ins),
		rt.create_array_from_list(var_custom_variations)])
}

fn register_block_core_post_terms() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/post-terms'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_post_terms' },
			rt.ArrayItem{ key: 'variation_callback', val: 'block_core_post_terms_build_variations' },
		]),
	])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_post_terms')])
}
