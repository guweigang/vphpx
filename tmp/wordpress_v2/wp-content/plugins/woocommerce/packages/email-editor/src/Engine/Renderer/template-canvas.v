import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_subject := rt.new_null()
	mut var_meta_robots := rt.new_null()
	mut var_layout := map[string]rt.PhpVal{}
	mut var_pre_header := rt.new_null()
	mut var_template_html := rt.new_null()
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('language_attributes', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_subject.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo', [rt.new_string('charset')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_meta_robots)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_layout['contentSize']]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_layout['contentSize']]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_layout['contentSize']]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('wp_strip_all_tags', [var_pre_header.clone()]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_template_html)
	// unsupported statement: Stmt_InlineHTML
}
