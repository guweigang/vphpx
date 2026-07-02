import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_display_version := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	mut var_title := rt.call_function('__', [rt.new_string('Get Involved')])
	mut list_tmp_1 := rt.call_function('explode', [rt.new_string('-'),
		rt.call_function('get_bloginfo', [rt.new_string('version')])])
	var_display_version = list_tmp_1.array_get(0)
	mut var_header_alt_text := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('WordPress %s')]),
		var_display_version.clone(),
	])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_header_alt_text.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Get Involved')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Be the future of WordPress')])
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
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [
			rt.new_string('images/contribute-main.svg?ver=6.5'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Do you use WordPress for work, for personal projects, or even just for fun? You can help shape the long-term success of the open source project that powers millions of websites around the world.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Join the diverse WordPress contributor community and connect with other people who are passionate about maintaining a free and open web.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Be part of a global open source community.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Apply your skills or learn new ones.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Grow your network and make friends.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('No-code contribution')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('WordPress may thrive on technical contributions, but you don&#8217;t have to code to contribute. Here are some of the ways you can make an impact without writing a single line of code:'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('<strong>Share</strong> your knowledge in the WordPress support forums.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('<strong>Write</strong> or improve documentation for WordPress.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('<strong>Translate</strong> WordPress into your local language.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('<strong>Create</strong> and improve WordPress educational materials.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('<strong>Promote</strong> the WordPress project to your community.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('<strong>Curate</strong> submissions or take photos for the Photo Directory.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('<strong>Organize</strong> or participate in local Meetups and WordCamps.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('<strong>Lend</strong> your creative imagination to the WordPress UI design.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('<strong>Edit</strong> videos and add captions to WordPress.tv.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('<strong>Explore</strong> ways to reduce the environmental impact of websites.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [
			rt.new_string('images/contribute-no-code.svg?ver=6.5'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [
			rt.new_string('images/contribute-code.svg?ver=6.5'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Code-based contribution')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('If you do code, or want to learn how, you can contribute technically in numerous ways:'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('<strong>Find</strong> and report bugs in the WordPress core software.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('<strong>Test</strong> new releases and proposed features for the Block Editor.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('<strong>Write</strong> and submit patches to fix bugs or help build new features.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('<strong>Contribute</strong> to the code, improve the UX, and test the WordPress app.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('WordPress embraces new technologies, while being committed to backward compatibility. The WordPress project uses the following languages and libraries:'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('WordPress Core and Block Editor: HTML, CSS, PHP, SQL, JavaScript, and React.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('WordPress app: Kotlin, Java, Swift, Objective-C, Vue, Python, and TypeScript.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Shape the future of the web with WordPress')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Finding the area that aligns with your skills and interests is the first step toward meaningful contribution. With more than 20 Make WordPress teams working on different parts of the open source WordPress project, there&#8217;s a place for everyone, no matter what your skill set is.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('__', [rt.new_string('https://make.wordpress.org/contribute/')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Find your team &rarr;')])
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
