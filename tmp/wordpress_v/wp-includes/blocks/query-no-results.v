import rt

fn render_block_core_query_no_results(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_wp_query := rt.new_null()
	if var_content.dup().to_string().trim_space() == '' {
		return ''
	}
	mut var_page_key := rt.new_string(if rt.get_property(var_block, 'context').array_isset(rt.new_string('queryId')) { 'query-' + (rt.get_property(var_block, 'context').array_get('queryId')).str() + '-page' } else { rt.new_string('query-page') })
	mut var_page := if !rt.is_true(rt.get_superglobal('_GET').array_get(var_page_key)) { rt.new_int(1) } else { // unsupported expression: Expr_Cast_Int }
	mut var_use_global_query := rt.get_property(var_block, 'context').array_get('query').array_isset(rt.new_string('inherit')) && rt.is_true(rt.get_property(var_block, 'context').array_get('query').array_get('inherit'))
	if var_use_global_query {
		// unsupported statement: Stmt_Global
		mut var_query := var_wp_query
	} else {
		mut var_query_args := rt.call_function('build_query_vars_from_query_block', [var_block.dup(), var_page.dup()])
		var_query = create_wp_query(var_query_args.dup())
	}
	if rt.is_true(rt.greater(rt.get_property(var_query, 'post_count'), rt.new_int(0))) {
		return ''
	}
	mut var_classes := if var_attributes.array_get('style').array_get('elements').array_get('link').array_get('color').array_isset(rt.new_string('text')) { 'has-link-color' } else { '' }
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [rt.create_array([rt.ArrayItem{ key: 'class', val: var_classes }])])
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'), var_wrapper_attributes.dup(), var_content.dup()])).str()
}

fn register_block_core_query_no_results() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/query-no-results', rt.create_array([rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_query_no_results' }])])
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_wp_query() &Class_WP_Query {
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




pub fn init_wp_includes_blocks_query_no_results_php() {
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('register_block_core_query_no_results')])
}
