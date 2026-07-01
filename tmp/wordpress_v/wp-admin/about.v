import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_display_version := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	mut var_title := rt.call_function('_x', [rt.new_string('About'),
		rt.new_string('page title')])
	// unsupported assign target: Expr_List
	mut var_display_major_version := '7.0'
	mut var_release_notes_url := rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('https://wordpress.org/documentation/wordpress-version/version-%s/'),
		]),
		rt.call_function('sanitize_title', [
			rt.new_string(var_display_major_version).dup(),
		]),
	])
	mut var_field_guide_url := rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('https://make.wordpress.org/core/wordpress-%s-field-guide/'),
		]),
		rt.call_function('sanitize_title', [
			rt.new_string(var_display_major_version).dup(),
		]),
	])
	mut var_release_page_url := rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('https://wordpress.org/download/releases/%s/'),
		]),
		rt.call_function('sanitize_title', [
			rt.new_string(var_display_major_version).dup(),
		]),
	])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('__', [rt.new_string('WordPress %s')]),
		var_display_version.dup()])
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
	rt.call_function('_e', [rt.new_string('Welcome to WordPress 7.0')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('WordPress 7.0 introduces the foundation for AI across the platform, letting you connect your preferred provider and put it to work across your site. Edit more simply by dropping in layouts and swapping content without diving into blocks. The navigation overlay now taps into the full potential of blocks, and reviewing historical changes is easier with a visual comparison.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Design your navigation overlay')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('A dedicated canvas for your menu.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Build the menu overlay you want visitors to see. Go beyond a simple list of links: add columns, increase the font size, and align everything to your liking. Start from a pre-built template, or design your own from scratch.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('AI foundations')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('A centralized hub for your connections.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('The Connectors screen introduces a single hub for managing a range of external service integrations, including AI providers. Opt in by connecting your preferred AI provider, then put it to work across your site. The optional AI plugin adds a growing set of tools directly into the editor: create titles and excerpts, generate and edit images, and suggest alt text. Any plugin that needs to connect to an outside service can tap into this standardized connection management system, making it easy for users and developers alike.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Visual revisions')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Scrub through every version of your page.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Review your post&#8217;s revision history with a timeline slider and see exactly what changed in the document with visual markers, block by block. Find the version you want and restore it in one click.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('A simpler way to build with patterns')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Patterns as single blocks.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Drop a pattern onto your page and it behaves like one block, so you don’t have to hunt through nested blocks for the element you want to change. Swap the text and images, adjust styles from the inspector, and keep moving. For any advanced edits, a single click to "edit pattern" gives you access to all available tools.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Performance')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('WordPress 7.0 improves the accuracy of image loading prioritization, preventing hidden images in navigation overlays or interactive blocks from degrading the loading of critical resources. On-demand block stylesheet loading in classic themes is more reliable, and the ability is added for scripts to depend on script modules to reduce render-blocking.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Accessibility')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('WordPress continues to polish accessibility across WordPress Core and Gutenberg, advancing the goals to meet accessibility standards. WordPress 7.0 includes fixes across the platform, improving media management, usability for voice control, and improvements to color contrast with the new admin color scheme. The editor ships with new blocks and improvements to editor navigation and interaction.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('And much more')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('For a comprehensive overview of all the new features and enhancements in WordPress %s, please visit the feature-showcase website.'),
		]),
		rt.new_string(var_display_major_version).dup(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_release_page_url.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('See everything new')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [
			rt.new_string('images/about-release-badge.svg?ver=7.0'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('Learn more about WordPress %s')]),
		rt.new_string(var_display_major_version).dup(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('<a href="%1$s">Learn WordPress</a> is a free resource for new and experienced WordPress users. Learn is stocked with how-to videos on using various features in WordPress, <a href="%2$s">interactive workshops</a> for exploring topics in-depth, and lesson plans for diving deep into specific areas of WordPress.'),
		]),
		rt.new_string('https://learn.wordpress.org/'),
		rt.new_string('https://learn.wordpress.org/online-workshops/'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_release_notes_url.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('WordPress %s Release Notes')]),
		rt.new_string(var_display_major_version).dup(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('Read the WordPress %s Release Notes for information on installation, enhancements, fixed issues, release contributors, learning resources, and the list of file changes.'),
		]),
		rt.new_string(var_display_major_version).dup(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_field_guide_url.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('WordPress %s Field Guide')]),
		rt.new_string(var_display_major_version).dup(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('Explore the WordPress %s Field Guide. Learn about the changes in this release with detailed developer notes to help you build with WordPress.'),
		]),
		rt.new_string(var_display_major_version).dup(),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('updated'))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')]))))
	{
		rt.call_function('printf', [rt.new_string('<a href="%1$s">%2$s</a> | '),
			rt.call_function('esc_url', [
				rt.call_function('self_admin_url', [rt.new_string('update-core.php')]),
			]),
			if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) { rt.call_function('__', [
					rt.new_string('Go to Updates'),
				]) } else { rt.call_function('__', [
					rt.new_string('Go to Dashboard &rarr; Updates'),
				]) }])
	}
	rt.call_function('printf', [rt.new_string('<a href="%1$s">%2$s</a>'),
		rt.call_function('esc_url', [rt.call_function('self_admin_url', []rt.PhpVal{})]),
		if rt.is_true(rt.call_function('is_blog_admin', []rt.PhpVal{})) { rt.call_function('__', [
				rt.new_string('Go to Dashboard &rarr; Home')]) } else { rt.call_function('__', [
				rt.new_string('Go to Dashboard')]) }])
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
	// unsupported statement: Stmt_InlineHTML
	return rt.new_null()
	rt.call_function('__', [rt.new_string('Maintenance Release')])
	rt.call_function('__', [rt.new_string('Maintenance Releases')])
	rt.call_function('__', [rt.new_string('Security Release')])
	rt.call_function('__', [rt.new_string('Security Releases')])
	rt.call_function('__', [rt.new_string('Maintenance and Security Release')])
	rt.call_function('__', [rt.new_string('Maintenance and Security Releases')])
	rt.call_function('__', [
		rt.new_string('<strong>Version %s</strong> addressed one security issue.'),
	])
	rt.call_function('__', [])
}
