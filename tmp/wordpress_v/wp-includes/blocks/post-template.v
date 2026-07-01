import rt

fn block_core_post_template_uses_featured_image(var_inner_blocks rt.PhpVal) bool {
	{
		mut iter_1 := var_inner_blocks.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block := item_1.val
			if rt.is_true(rt.identical(rt.new_string('core/post-featured-image'), rt.get_property(var_block, 'name'))) {
				return true
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('core/cover'), rt.get_property(var_block, 'name'))) && !(!rt.is_true(rt.get_property(var_block, 'attributes').array_get('useFeaturedImage'))))) {
				return true
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.get_property(var_block, 'inner_blocks')) && block_core_post_template_uses_featured_image(rt.get_property(var_block, 'inner_blocks')))) {
				return true
			}
		}
	}
	return false
}

fn render_block_core_post_template(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_wp_query := rt.new_null()
	mut var_page_key := rt.new_string(if rt.get_property(var_block, 'context').array_isset(rt.new_string('queryId')) { 'query-' + (rt.get_property(var_block, 'context').array_get('queryId')).str() + '-page' } else { rt.new_string('query-page') })
	mut var_enhanced_pagination := // unsupported expression: Expr_Cast_Bool
	mut var_page := if !rt.is_true(rt.get_superglobal('_GET').array_get(var_page_key)) { rt.new_int(1) } else { // unsupported expression: Expr_Cast_Int }
	mut var_use_global_query := // unsupported expression: Expr_Cast_Bool
	if rt.is_true(var_use_global_query) {
		// unsupported statement: Stmt_Global
		if rt.is_true(rt.call_function('in_the_loop', []rt.PhpVal{})) {
			mut var_query := // unsupported expression: Expr_Clone
			rt.call_method(var_query, 'rewind_posts', []rt.PhpVal{})
		} else {
			var_query = var_wp_query
		}
	} else {
		mut var_query_args := rt.call_function('build_query_vars_from_query_block', [var_block.dup(), var_page.dup()])
		var_query = create_wp_query(var_query_args.dup())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_query, 'have_posts', []rt.PhpVal{}))))) {
		return ''
	}
	if rt.is_true(rt.new_bool(block_core_post_template_uses_featured_image(rt.get_property(var_block, 'inner_blocks')))) {
		rt.call_function('update_post_thumbnail_cache', [var_query.dup()])
	}
	mut var_classnames := ''
	if rt.get_property(var_block, 'context').array_isset(rt.new_string('displayLayout')) && rt.get_property(var_block, 'context').array_isset(rt.new_string('query')) {
		if rt.is_true(rt.new_bool(rt.get_property(var_block, 'context').array_get('displayLayout').array_isset(rt.new_string('type')) && rt.is_true(rt.identical(rt.new_string('flex'), rt.get_property(var_block, 'context').array_get('displayLayout').array_get('type'))))) {
			var_classnames = rt.concat(rt.new_string('is-flex-container columns-'), rt.get_property(var_block, 'context').array_get('displayLayout').array_get('columns'))
		}
	}
	if var_attributes.array_get('style').array_get('elements').array_get('link').array_get('color').array_isset(rt.new_string('text')) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_attributes.array_get('layout').array_isset(rt.new_string('type')) && rt.is_true(rt.identical(rt.new_string('grid'), var_attributes.array_get('layout').array_get('type'))))) && !(!rt.is_true(var_attributes.array_get('layout').array_get('columnCount'))))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [rt.create_array([rt.ArrayItem{ key: 'class', val: var_classnames.trim_space() }])])
	var_content = ''
	for rt.is_true(rt.call_method(var_query, 'have_posts', []rt.PhpVal{})) {
		rt.call_method(var_query, 'the_post', []rt.PhpVal{})
		mut var_block_instance := rt.get_property(var_block, 'parsed_block')
		var_block_instance.array_set('blockName', 'core/null')
		mut var_post_id := rt.call_function('get_the_ID', []rt.PhpVal{})
		mut var_post_type := rt.call_function('get_post_type', []rt.PhpVal{})
		closure_1_fn := fn [var_post_id, var_post_type] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_context := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	var_context.array_set('postType', var_post_type.dup())
	var_context.array_set('postId', var_post_id.dup())
	return (var_context).str()
	}
		mut var_filter_block_context := rt.new_closure(closure_1_fn)
		rt.call_function('add_filter', [rt.new_string('render_block_context'), var_filter_block_context.dup(), rt.new_int(1)])
		mut var_block_content := rt.call_method(create_wp_block(var_block_instance.dup()), 'render', [rt.create_array([rt.ArrayItem{ key: 'dynamic', val: false }])])
		rt.call_function('remove_filter', [rt.new_string('render_block_context'), var_filter_block_context.dup(), rt.new_int(1)])
		mut var_post_classes := rt.call_function('implode', [rt.new_string(' '), rt.call_function('get_post_class', [rt.new_string('wp-block-post')])])
		mut var_inner_block_directives := rt.new_string(if rt.is_true(var_enhanced_pagination) { ' data-wp-key="post-template-item-' + (var_post_id).str() + '"' } else { rt.new_string('') })
		// unsupported expression: Expr_AssignOp_Concat
	}
	rt.call_function('wp_reset_postdata', []rt.PhpVal{})
	return (rt.call_function('sprintf', [rt.new_string('<ul %1$s>%2$s</ul>'), var_wrapper_attributes.dup(), rt.new_string(var_content).dup()])).str()
}

fn register_block_core_post_template() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/post-template', rt.create_array([rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_post_template' }, rt.ArrayItem{ key: 'skip_inner_blocks', val: true }])])
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

struct Class_WP_Block {
	rt.PhpObjectBase
}

fn create_wp_query() &Class_WP_Query {
	mut obj := &Class_WP_Query{
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

fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_blocks_post_template_php() {
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('register_block_core_post_template')])
}
