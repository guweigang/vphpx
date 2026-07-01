import rt

fn render_block_core_query_pagination_next(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_wp_query := rt.new_null()
	mut var_page_key := rt.new_string(if rt.get_property(var_block, 'context').array_isset(rt.new_string('queryId')) { 'query-' + (rt.get_property(var_block, 'context').array_get('queryId')).str() + '-page' } else { rt.new_string('query-page') })
	mut var_enhanced_pagination := // unsupported expression: Expr_Cast_Bool
	mut var_page := if !rt.is_true(rt.get_superglobal('_GET').array_get(var_page_key)) { rt.new_int(1) } else { // unsupported expression: Expr_Cast_Int }
	mut var_max_page := // unsupported expression: Expr_Cast_Int
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{})
	mut var_show_label := // unsupported expression: Expr_Cast_Bool
	mut var_default_label := rt.call_function('__', [rt.new_string('Next Page')])
	mut var_label_text := if var_attributes.array_isset(rt.new_string('label')) && !(!rt.is_true(var_attributes.array_get('label'))) { rt.call_function('esc_html', [var_attributes.array_get('label')]) } else { var_default_label }
	mut var_label := if rt.is_true(var_show_label) { var_label_text } else { rt.new_string('') }
	mut var_pagination_arrow := rt.call_function('get_query_pagination_arrow', [var_block.dup(), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_label)))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(var_pagination_arrow) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	var_content = rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(rt.get_property(var_block, 'context').array_get('query').array_isset(rt.new_string('inherit')) && rt.is_true(rt.get_property(var_block, 'context').array_get('query').array_get('inherit')))) {
		closure_1_fn := fn [var_wrapper_attributes] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	return var_wrapper_attributes.dup()
	}
		mut var_filter_link_attributes := rt.new_closure(closure_1_fn)
		rt.call_function('add_filter', [rt.new_string('next_posts_link_attributes'), var_filter_link_attributes.dup()])
		// unsupported statement: Stmt_Global
		if rt.is_true(rt.greater(var_max_page, rt.get_property(var_wp_query, 'max_num_pages'))) {
			var_max_page = rt.get_property(var_wp_query, 'max_num_pages')
		}
		var_content = rt.call_function('get_next_posts_link', [var_label.dup(), var_max_page.dup()])
		rt.call_function('remove_filter', [rt.new_string('next_posts_link_attributes'), var_filter_link_attributes.dup()])
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_max_page)))) || rt.is_true(rt.greater(var_max_page, var_page)))) {
		mut var_custom_query := create_wp_query(rt.call_function('build_query_vars_from_query_block', [var_block.dup(), var_page.dup()]))
		mut var_custom_query_max_pages := // unsupported expression: Expr_Cast_Int
		if rt.is_true(rt.new_bool(rt.is_true(var_custom_query_max_pages) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			var_content = rt.call_function('sprintf', [rt.new_string('<a href="%1$s" %2$s>%3$s</a>'), rt.call_function('esc_url', [rt.call_function('add_query_arg', [var_page_key.dup(), rt.add(var_page, rt.new_int(1))])]), var_wrapper_attributes.dup(), var_label.dup()])
		}
		rt.call_function('wp_reset_postdata', []rt.PhpVal{})
		// unsupported statement: Stmt_Nop
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_enhanced_pagination) && !(var_content).is_null())) {
		mut var_p := create_wp_html_tag_processor(var_content.dup())
		if rt.is_true(var_p.next_tag(rt.create_array([rt.ArrayItem{ key: 'tag_name', val: 'a' }, rt.ArrayItem{ key: 'class_name', val: 'wp-block-query-pagination-next' }]))) {
			var_p.set_attribute(rt.new_string('data-wp-key'), rt.new_string('query-pagination-next'))
			var_p.set_attribute(rt.new_string('data-wp-on--click'), rt.new_string('core/query::actions.navigate'))
			var_p.set_attribute(rt.new_string('data-wp-on--mouseenter'), rt.new_string('core/query::actions.prefetch'))
			var_p.set_attribute(rt.new_string('data-wp-watch'), rt.new_string('core/query::callbacks.prefetch'))
			var_content = var_p.get_updated_html()
		}
	}
	return var_content.dup()
}

fn register_block_core_query_pagination_next() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/query-pagination-next', rt.create_array([rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_query_pagination_next' }])])
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_wp_query() &Class_WP_Query {
	mut obj := &Class_WP_Query{
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

fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_blocks_query_pagination_next_php() {
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('register_block_core_query_pagination_next')])
}
