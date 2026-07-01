import rt

fn render_block_core_term_template(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if !(!(rt.get_property(var_block, 'context')).is_null())
		|| !rt.is_true(rt.get_property(var_block, 'context').array_get('termQuery')) {
		return ''
	}
	mut var_query := rt.get_property(var_block, 'context').array_get('termQuery')
	mut var_query_args := {
		'number':     var_query.array_get('perPage')
		'order':      var_query.array_get('order')
		'orderby':    var_query.array_get('orderBy')
		'hide_empty': var_query.array_get('hideEmpty')
	}
	mut var_inherit_query := rt.is_true(rt.new_bool(var_query.array_isset(rt.new_string('inherit'))
		&& rt.is_true(var_query.array_get('inherit'))))
		&& rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_tax', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('is_category', []rt.PhpVal{}))))
		|| rt.is_true(rt.call_function('is_tag', []rt.PhpVal{}))))
	if var_inherit_query {
		mut var_queried_object := rt.call_function('get_queried_object', []rt.PhpVal{})
		if rt.is_true(rt.call_function('is_taxonomy_hierarchical', [
			rt.get_property(var_queried_object, 'taxonomy'),
		]))
		{
			if !(!rt.is_true(var_query.array_get('showNested'))) {
				var_query_args['child_of'] = rt.get_property(var_queried_object, 'term_id')
			} else {
				var_query_args['parent'] = rt.get_property(var_queried_object, 'term_id')
			}
		}
		var_query_args['taxonomy'] = rt.get_property(var_queried_object, 'taxonomy')
	} else {
		var_query_args['taxonomy'] = var_query.array_get('taxonomy')
		if !(!rt.is_true(var_query.array_get('include'))) {
			var_query_args['include'] = rt.call_function('array_unique', [
				rt.call_function('array_map', [rt.new_string('intval'),
					var_query.array_get('include')]),
			])
			var_query_args['orderby'] = rt.new_string('include')
			var_query_args['order'] = rt.new_string('asc')
		} else if rt.is_true(rt.new_bool(
			rt.is_true(rt.call_function('is_taxonomy_hierarchical', [var_query.array_get('taxonomy')]))
			&& !rt.is_true(var_query.array_get('showNested'))))
		{
			var_query_args['parent'] = rt.new_int(0)
		}
	}
	mut var_terms_query := create_wp_term_query(var_query_args.dup())
	mut var_terms := var_terms_query.get_terms()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_terms))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_terms.dup()]))))
	{
		return ''
	}
	var_content = ''
	{
		mut iter_1 := var_terms.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_term := item_1.val
			mut var_block_instance := rt.get_property(var_block, 'parsed_block')
			var_block_instance.array_set('blockName', 'core/null')
			mut var_term_id := rt.get_property(var_term, 'term_id')
			mut var_taxonomy := rt.get_property(var_term, 'taxonomy')
			closure_1_fn := fn [var_term_id, var_taxonomy] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_context := if args.len > 0 { args[0].dup() } else { rt.new_null() }
				var_context.array_set('termId', var_term_id.dup())
				var_context.array_set('taxonomy', var_taxonomy.dup())
				return var_context.str()
			}
			mut var_filter_block_context := rt.new_closure(closure_1_fn)
			rt.call_function('add_filter', [rt.new_string('render_block_context'),
				var_filter_block_context.dup(), rt.new_int(1)])
			mut var_block_content := rt.call_method(create_wp_block(var_block_instance.dup()),
				'render', [rt.create_array([rt.ArrayItem{ key: 'dynamic', val: false }])])
			rt.call_function('remove_filter', [rt.new_string('render_block_context'),
				var_filter_block_context.dup(), rt.new_int(1)])
			mut var_term_classes := rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('wp-block-term term-'), rt.get_property(var_term,
				'term_id')), rt.new_string(' ')), rt.get_property(var_term, 'taxonomy')),
				rt.new_string(' taxonomy-')), rt.get_property(var_term, 'taxonomy'))
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	mut var_classnames := ''
	if var_attributes.array_get('style').array_get('elements').array_get('link').array_get('color').array_isset(rt.new_string('text')) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([rt.ArrayItem{ key: 'class', val: var_classnames.trim_space() }]),
	])
	return (rt.call_function('sprintf', [rt.new_string('<ul %s>%s</ul>'),
		var_wrapper_attributes.dup(), rt.new_string(var_content).dup()])).str()
}

fn register_block_core_term_template() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/term-template',
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_term_template' },
		])])
}

struct Class_WP_Term_Query {
	rt.PhpObjectBase
}

struct Class_WP_Block {
	rt.PhpObjectBase
}

fn create_wp_term_query() &Class_WP_Term_Query {
	mut obj := &Class_WP_Term_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block() &Class_WP_Block {
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

pub fn init_wp_includes_blocks_term_template_php() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_term_template')])
}
