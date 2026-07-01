import rt

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_engine_renderer_template_canvas_php() {
	mut var_subject := rt.new_null()
	mut var_meta_robots := rt.new_null()
	mut var_layout := map[string]rt.PhpVal{}
	mut var_pre_header := rt.new_null()
	mut var_template_html := rt.new_null()
	// unsupported statement: Stmt_Declare
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('language_attributes', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_subject.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo', [rt.new_string('charset')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_meta_robots)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_layout.array_get('contentSize')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_layout.array_get('contentSize')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_layout.array_get('contentSize')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('wp_strip_all_tags', [var_pre_header.dup()]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_template_html)
	// unsupported statement: Stmt_InlineHTML
}
