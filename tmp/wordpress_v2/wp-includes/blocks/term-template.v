import rt

fn render_block_core_term_template(var_attributes rt.PhpVal, var_content_arg rt.PhpVal, var_block rt.PhpVal) string {
	mut var_content := var_content_arg
	mut var_query := rt.new_null()
	mut var_query_args := map[string]rt.PhpVal{}
	mut var_inherit_query := false
	mut var_queried_object := rt.new_null()
	mut var_terms_query := rt.new_null()
	mut var_terms := rt.new_null()
	mut var_term := rt.new_null()
	mut var_block_instance := rt.new_null()
	mut var_term_id := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_filter_block_context := rt.new_null()
	mut var_block_content := rt.new_null()
	mut var_term_classes := ''
	mut var_classnames := ''
	mut var_wrapper_attributes := rt.new_null()
	if !(!(rt.get_property(var_block, 'context')).is_null())
		|| !rt.is_true(rt.get_property(var_block, 'context').array_get(rt.new_string('termQuery'))) {
		return ''
	}
	var_query = rt.get_property(var_block, 'context').array_get(rt.new_string('termQuery'))
	var_query_args = {
		'number':     var_query.array_get(rt.new_string('perPage'))
		'order':      var_query.array_get(rt.new_string('order'))
		'orderby':    var_query.array_get(rt.new_string('orderBy'))
		'hide_empty': var_query.array_get(rt.new_string('hideEmpty'))
	}
	var_inherit_query = var_query.array_isset(rt.new_string('inherit'))
		&& rt.is_true(var_query.array_get(rt.new_string('inherit')))
		&& rt.is_true(rt.call_function('is_tax', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('is_category', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('is_tag', []rt.PhpVal{}))
	if var_inherit_query {
		var_queried_object = rt.call_function('get_queried_object', []rt.PhpVal{})
		if rt.is_true(rt.call_function('is_taxonomy_hierarchical', [
			rt.get_property(var_queried_object, 'taxonomy'),
		]))
		{
			if !(!rt.is_true(var_query.array_get(rt.new_string('showNested')))) {
				var_query_args['child_of'] = rt.get_property(var_queried_object, 'term_id')
			} else {
				var_query_args['parent'] = rt.get_property(var_queried_object, 'term_id')
			}
		}
		var_query_args['taxonomy'] = rt.get_property(var_queried_object, 'taxonomy')
	} else {
		var_query_args['taxonomy'] = var_query.array_get(rt.new_string('taxonomy'))
		if !(!rt.is_true(var_query.array_get(rt.new_string('include')))) {
			var_query_args['include'] = rt.call_function('array_unique', [
				rt.call_function('array_map', [rt.new_string('intval'),
					var_query.array_get(rt.new_string('include'))]),
			])
			var_query_args['orderby'] = rt.new_string('include')
			var_query_args['order'] = rt.new_string('asc')
		} else if
			rt.is_true(rt.call_function('is_taxonomy_hierarchical', [var_query.array_get(rt.new_string('taxonomy'))]))
			&& !rt.is_true(var_query.array_get(rt.new_string('showNested'))) {
			var_query_args['parent'] = rt.new_int(0)
		}
	}
	var_terms_query = create_wp_term_query(var_query_args.clone())
	var_terms = var_terms_query.get_terms()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_terms))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_terms.clone()])) {
		return ''
	}
	var_content = ''
	mut iter_1 := var_terms.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_term_shadow := item_1.val
		var_block_instance = rt.get_property(var_block, 'parsed_block')
		var_block_instance.array_set('blockName', 'core/null')
		var_term_id = rt.get_property(var_term_shadow, 'term_id')
		var_taxonomy = rt.get_property(var_term_shadow, 'taxonomy')
		closure_1_fn := fn [var_term_id, var_taxonomy] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_context := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			var_context.array_set('termId', var_term_id.clone())
			var_context.array_set('taxonomy', var_taxonomy.clone())
			return var_context.str()
		}
		var_filter_block_context = rt.new_closure(closure_1_fn)
		rt.call_function('add_filter', [rt.new_string('render_block_context'),
			var_filter_block_context.clone(), rt.new_int(1)])
		var_block_content = rt.call_method(create_wp_block(var_block_instance.clone()), 'render', [
			rt.create_array([rt.ArrayItem{ key: 'dynamic', val: false }]),
		])
		rt.call_function('remove_filter', [rt.new_string('render_block_context'),
			var_filter_block_context.clone(), rt.new_int(1)])
		var_term_classes = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('wp-block-term term-'), rt.get_property(var_term_shadow,
			'term_id')), rt.new_string(' ')), rt.get_property(var_term_shadow, 'taxonomy')),
			rt.new_string(' taxonomy-')), rt.get_property(var_term_shadow, 'taxonomy'))
		var_content = var_content + '<li class="' +
			(rt.call_function('esc_attr', [rt.new_string(var_term_classes.str()).clone()])).str() +
			'">' + var_block_content.str() + '</li>'
	}
	var_classnames = ''
	if var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('elements')).array_get(rt.new_string('link')).array_get(rt.new_string('color')).array_isset(rt.new_string('text')) {
		var_classnames = var_classnames + 'has-link-color'
	}
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([rt.ArrayItem{ key: 'class', val: var_classnames.trim_space() }]),
	])
	return (rt.call_function('sprintf', [rt.new_string('<ul %s>%s</ul>'),
		var_wrapper_attributes.clone(), rt.new_string(var_content.str()).clone()])).str()
}

fn register_block_core_term_template() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/term-template'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_term_template' },
		]),
	])
}

struct Class_WP_Term_Query {
	rt.PhpObjectBase
}

struct Class_WP_Block {
	rt.PhpObjectBase
}

fn create_wp_term_query(_args ...rt.PhpVal) &Class_WP_Term_Query {
	mut obj := &Class_WP_Term_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block(_args ...rt.PhpVal) &Class_WP_Block {
	mut obj := &Class_WP_Block{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Term_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Term_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Term_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Block) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_term_template')])
}
