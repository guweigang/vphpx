import rt

pub fn init_wp_includes_theme_compat_footer_embed_php() {
	rt.call_function('do_action', [rt.new_string('embed_footer')])
	// unsupported statement: Stmt_InlineHTML
}
