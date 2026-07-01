import rt

fn render_block_core_query_total(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{})
	if rt.is_true(if !(rt.get_property(var_block, 'context').array_get('query').array_get('inherit')).is_null() { rt.get_property(var_block, 'context').array_get('query').array_get('inherit') } else { rt.new_bool(false) }) {
		mut var_query_to_use := var_wp_query
		mut var_current_page := rt.call_function('max', [rt.new_int(1), // unsupported expression: Expr_Cast_Int])
	} else {
		mut var_page_key := rt.new_string(if rt.get_property(var_block, 'context').array_isset(rt.new_string('queryId')) { 'query-' + (rt.get_property(var_block, 'context').array_get('queryId')).str() + '-page' } else { rt.new_string('query-page') })
		var_current_page = // unsupported expression: Expr_Cast_Int
		var_query_to_use = create_wp_query(rt.call_function('build_query_vars_from_query_block', [var_block.dup(), var_current_page.dup()]))
	}
	mut var_max_rows := rt.get_property(var_query_to_use, 'found_posts')
	mut var_posts_per_page := // unsupported expression: Expr_Cast_Int
	mut var_start := if rt.is_true(rt.identical(rt.new_int(0), var_max_rows)) { rt.new_int(0) } else { rt.add(rt.mul(rt.sub(var_current_page, rt.new_int(1)), var_posts_per_page), rt.new_int(1)) }
	mut var_end := rt.call_function('min', [rt.sub(rt.add(var_start, var_posts_per_page), rt.new_int(1)), var_max_rows.dup()])
	mut var_output := ''
	mut switch_val_1 := var_attributes.array_get('displayType')
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('range-display'))) {
		if rt.is_true(rt.identical(var_start, var_end)) {
			var_output = (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Displaying %1$s of %2$s')]), var_start.dup(), var_max_rows.dup()])).str()
		} else {
			var_output = (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Displaying %1$s – %2$s of %3$s')]), var_start.dup(), var_end.dup(), var_max_rows.dup()])).str()
		}
	} else {
		var_output = (rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%d result found'), rt.new_string('%d results found'), var_max_rows.dup()]), var_max_rows.dup()])).str()
	}
	return rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'), var_wrapper_attributes.dup(), rt.new_string(var_output).dup()])
}

fn register_block_core_query_total() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/query-total', rt.create_array([rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_query_total' }])])
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




pub fn init_wp_includes_blocks_query_total_php() {
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('register_block_core_query_total')])
}
