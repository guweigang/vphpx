import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_display_version := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	mut var_title := rt.call_function('__', [rt.new_string('Privacy')])
	// unsupported assign target: Expr_List
	mut var_header_alt_text := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('WordPress %s')]),
		var_display_version.dup(),
	])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_header_alt_text.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Privacy')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('WordPress.org takes privacy and transparency very seriously'),
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
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [rt.new_string('images/privacy.svg?ver=6.5')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('From time to time, your WordPress site may send data to WordPress.org &#8212; including, but not limited to &#8212; the version you are using, and a list of installed plugins and themes.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('This data is used to provide general enhancements to WordPress, which includes helping to protect your site by finding and automatically installing new updates. It is also used to calculate statistics, such as those shown on the <a href="%s">WordPress.org stats page</a>.'),
		]),
		rt.call_function('__', [
			rt.new_string('https://wordpress.org/about/stats/'),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('WordPress.org takes privacy and transparency very seriously. To learn more about what data is collected, and how it is used, please visit <a href="%s">the WordPress.org Privacy Policy</a>.'),
		]),
		rt.call_function('__', [
			rt.new_string('https://wordpress.org/about/privacy/'),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
