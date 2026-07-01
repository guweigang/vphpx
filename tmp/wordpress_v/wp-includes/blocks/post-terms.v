import rt

fn render_block_core_post_terms(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('postId')))
		|| !(var_attributes.array_isset(rt.new_string('term'))) {
		return ''
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_taxonomy_viewable', [
		var_attributes.array_get('term'),
	])))))
	{
		return ''
	}
	mut var_classes := ['taxonomy-' + (var_attributes.array_get('term')).str()]
	if var_attributes.array_isset(rt.new_string('textAlign')) {
		var_classes << 'has-text-align-' + (var_attributes.array_get('textAlign')).str()
	}
	if var_attributes.array_get('style').array_get('elements').array_get('link').array_get('color').array_isset(rt.new_string('text')) {
		var_classes << 'has-link-color'
	}
	mut var_separator := if !rt.is_true(var_attributes.array_get('separator')) {
		rt.new_string(' ')
	} else {
		var_attributes.array_get('separator')
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'class', val: rt.call_function('implode', [
				rt.new_string(' '),
				var_classes.dup(),
			]) },
		]),
	])
	mut var_prefix := '<div ${var_wrapper_attributes.to_string()}>'
	if rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('prefix'))
		&& rt.is_true(var_attributes.array_get('prefix'))))
	{
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_suffix := rt.new_string(rt.new_string('</div>'))
	if rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('suffix'))
		&& rt.is_true(var_attributes.array_get('suffix'))))
	{
		var_suffix = rt.new_string('<span class="wp-block-post-terms__suffix">' +
			(var_attributes.array_get('suffix')).str() + '</span>' + var_suffix.str())
	}
	mut var_post_terms := rt.call_function('get_the_term_list', [
		rt.get_property(var_block, 'context').array_get('postId'),
		var_attributes.array_get('term'),
		rt.call_function('wp_kses_post', [
			rt.new_string(var_prefix).dup()]),
		
			'<span class="wp-block-post-terms__separator">' +
			(rt.call_function('esc_html', [var_separator.dup()])).str() + '</span>',
		rt.call_function('wp_kses_post', [var_suffix.dup()])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_post_terms.dup()]))
		|| !rt.is_true(var_post_terms)))
	{
		return ''
	}
	return var_post_terms.str()
}

fn block_core_post_terms_build_variations() rt.PhpVal {
	mut var_taxonomies := rt.call_function('get_taxonomies', [
		rt.create_array([rt.ArrayItem{ key: 'publicly_queryable', val: true },
			rt.ArrayItem{ key: 'show_in_rest', val: true }]),
		rt.new_string('objects'),
	])
	mut var_built_ins := []rt.PhpVal{}
	mut var_custom_variations := []rt.PhpVal{}
	{
		mut iter_1 := var_taxonomies.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_taxonomy := item_1.val
			mut var_variation := {
				'name':        rt.get_property(var_taxonomy, 'name')
				'title':       rt.get_property(var_taxonomy, 'label')
				'description': rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Display a list of assigned terms from the taxonomy: %s'),
					]),
					rt.get_property(var_taxonomy, 'label'),
				])
				'attributes':  {
					'term': rt.get_property(var_taxonomy, 'name')
				}
				'isActive':    map[string]rt.PhpVal{}
				'scope':       map[string]rt.PhpVal{}
			}
			if rt.is_true(rt.identical(rt.new_string('category'), rt.get_property(var_taxonomy,
				'name')))
			{
				var_variation['isDefault'] = rt.new_bool(true)
			}
			if rt.is_true(rt.get_property(var_taxonomy, '_builtin')) {
				var_built_ins << var_variation.dup()
			} else {
				var_custom_variations << var_variation.dup()
			}
		}
	}
	return rt.call_function('array_merge', [var_built_ins.dup(),
		var_custom_variations.dup()])
}

fn register_block_core_post_terms() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/post-terms',
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_post_terms' },
			rt.ArrayItem{ key: 'variation_callback', val: 'block_core_post_terms_build_variations' },
		])])
}

pub fn init_wp_includes_blocks_post_terms_php() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_post_terms')])
}
