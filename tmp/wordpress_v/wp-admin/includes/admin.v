import rt

pub fn init_wp_admin_includes_admin_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_ADMIN'),
	])))))
	{
		mut var_admin_locale := rt.call_function('get_locale', []rt.PhpVal{})
		rt.call_function('load_textdomain', [rt.new_string('default'),
			(rt.get_constant('WP_LANG_DIR')).str() + '/admin-' + var_admin_locale.str() + '.mo',
			var_admin_locale.dup()])
		var_admin_locale = rt.new_null()
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/admin-filters.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/bookmark.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/comment.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/image.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/media.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/import.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/misc.php', '4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-privacy-policy-content.php',
		'4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/options.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/post.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-screen.php',
		'4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/screen.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/taxonomy.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/template.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-list-table.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-list-table-compat.php',
		'4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/list-table.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/theme.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/privacy-tools.php', '4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-privacy-requests-table.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-privacy-data-export-requests-list-table.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-privacy-data-removal-requests-list-table.php',
		'4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/user.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-site-icon.php',
		'4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/update.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/deprecated.php', '4')
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/ms-admin-filters.php', '4')
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/ms.php', '4')
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/ms-deprecated.php',
			'4')
	}
}
