import rt

pub fn init_wp_content_themes_twentytwentyfour_patterns_hidden_portfolio_hero_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('__', [
			rt.new_string('I’m <em>Leia Acosta</em>, a passionate photographer who finds inspiration in capturing the fleeting beauty of life.'),
			rt.new_string('twentytwentyfour'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
}
