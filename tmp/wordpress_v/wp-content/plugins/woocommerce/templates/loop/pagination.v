import rt



pub fn init_wp_content_plugins_woocommerce_templates_loop_pagination_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	mut var_total := if !(var_total).is_null() { var_total } else { rt.call_function('wc_get_loop_prop', [rt.new_string('total_pages')]) }
	mut var_current := if !(var_current).is_null() { var_current } else { rt.call_function('wc_get_loop_prop', [rt.new_string('current_page')]) }
	mut var_base := if !(var_base).is_null() { var_base } else { rt.call_function('esc_url_raw', [rt.call_function('str_replace', [rt.new_int(999999999), rt.new_string('%#%'), rt.call_function('remove_query_arg', [rt.new_string('add-to-cart'), rt.call_function('get_pagenum_link', [rt.new_int(999999999), rt.new_bool(false)])])])]) }
	mut var_format := if !(var_format).is_null() { var_format } else { rt.new_string('') }
	if rt.is_true(rt.less_equal(var_total, rt.new_int(1))) {
		return rt.new_null()
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Product Pagination'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('paginate_links', [rt.call_function('apply_filters', [rt.new_string('woocommerce_pagination_args'), rt.create_array([rt.ArrayItem{ key: 'base', val: var_base }, rt.ArrayItem{ key: 'format', val: var_format }, rt.ArrayItem{ key: 'add_args', val: false }, rt.ArrayItem{ key: 'current', val: rt.call_function('max', [rt.new_int(1), var_current.dup()]) }, rt.ArrayItem{ key: 'total', val: var_total }, rt.ArrayItem{ key: 'prev_text', val: if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { '&rarr;' } else { '&larr;' } }, rt.ArrayItem{ key: 'next_text', val: if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { '&larr;' } else { '&rarr;' } }, rt.ArrayItem{ key: 'type', val: 'list' }, rt.ArrayItem{ key: 'end_size', val: 3 }, rt.ArrayItem{ key: 'mid_size', val: 3 }])])]))
	// unsupported statement: Stmt_InlineHTML
}
