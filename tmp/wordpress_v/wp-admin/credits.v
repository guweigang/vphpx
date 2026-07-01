import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_display_version := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	rt.include_file(@DIR + '/includes/credits.php', '4')
	mut var_title := rt.call_function('__', [rt.new_string('Credits')])
	// unsupported assign target: Expr_List
	mut var_header_alt_text := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('WordPress %s')]),
		var_display_version.dup(),
	])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	mut var_credits := rt.call_function('wp_credits', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_header_alt_text.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Contributors')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Created by a worldwide team of passionate individuals'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Secondary menu')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('What&#8217;s New')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Credits')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Freedoms')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Privacy')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Get Involved')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(var_credits)))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('WordPress is created by a <a href="%1$s">worldwide team</a> of passionate individuals.'),
			]),
			rt.call_function('__', [
				rt.new_string('https://wordpress.org/about/'),
			]),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('__', [
				rt.new_string('https://make.wordpress.org/contribute/'),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Get involved in WordPress.')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Want to see your name in lights on this page?'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('__', [
				rt.new_string('https://make.wordpress.org/contribute/'),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Get involved in WordPress.')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(var_credits)))) {
		print('</div>')
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_credits_section_title',
		[var_credits.array_get('groups').array_get('core-developers')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_credits_section_list', [var_credits.dup(),
		rt.new_string('core-developers')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_credits_section_list', [var_credits.dup(),
		rt.new_string('contributing-developers')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_credits_section_title',
		[var_credits.array_get('groups').array_get('props')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_credits_section_list', [var_credits.dup(),
		rt.new_string('props')])
	// unsupported statement: Stmt_InlineHTML
	if var_credits.array_get('groups').array_isset(rt.new_string('translators'))
		|| var_credits.array_get('groups').array_isset(rt.new_string('validators')) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_credits_section_title',
			[var_credits.array_get('groups').array_get('validators')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_credits_section_list', [var_credits.dup(),
			rt.new_string('validators')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_credits_section_list', [var_credits.dup(),
			rt.new_string('translators')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_credits_section_title',
		[var_credits.array_get('groups').array_get('libraries')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_credits_section_list', [var_credits.dup(),
		rt.new_string('libraries')])
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
	return rt.new_null()
	rt.call_function('__', [rt.new_string('Project Leaders')])
	rt.call_function('__', [rt.new_string('Core Contributors to WordPress %s')])
	rt.call_function('__', [rt.new_string('Noteworthy Contributors')])
	rt.call_function('__', [rt.new_string('Cofounder, Project Lead')])
	rt.call_function('__', [rt.new_string('Lead Developer')])
	rt.call_function('__', [rt.new_string('Release Lead')])
	rt.call_function('__', [rt.new_string('Release Design Lead')])
	rt.call_function('__', [rt.new_string('Release Deputy')])
	rt.call_function('__', [rt.new_string('Release Coordination')])
	rt.call_function('__', [rt.new_string('Minor Release Lead')])
	rt.call_function('__', [rt.new_string('Core Developer')])
	rt.call_function('__', [rt.new_string('Core Tech Lead')])
	rt.call_function('__', [rt.new_string('Core Triage Lead')])
	rt.call_function('__', [rt.new_string('Editor Tech Lead')])
	rt.call_function('__', [rt.new_string('Editor Triage Lead')])
	rt.call_function('__', [rt.new_string('Documentation Lead')])
	rt.call_function('__', [rt.new_string('Test Lead')])
	rt.call_function('__', [rt.new_string('Design Lead')])
	rt.call_function('__', [rt.new_string('Performance Lead')])
	rt.call_function('__', [rt.new_string('Default Theme Design Lead')])
	rt.call_function('__', [rt.new_string('Default Theme Development Lead')])
	rt.call_function('__', [rt.new_string('Tech Lead')])
	rt.call_function('__', [rt.new_string('Triage Lead')])
	rt.call_function('__', [rt.new_string('External Libraries')])
}
