import rt

pub fn init_wp_content_plugins_akismet_views_predefined_php() {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Manual configuration'),
		rt.new_string('akismet')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('esc_html__', [
			rt.new_string('An Akismet API key has been defined in the %s file for this site.'),
			rt.new_string('akismet'),
		]),
		rt.new_string('<code>wp-config.php</code>'),
	])
	// unsupported statement: Stmt_InlineHTML
}
