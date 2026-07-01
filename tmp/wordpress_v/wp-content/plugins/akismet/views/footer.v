import rt

pub fn init_wp_content_plugins_akismet_views_footer_php() {
	// unsupported statement: Stmt_Declare
	rt.call_function('do_action', [rt.new_string('akismet_footer')])
}
