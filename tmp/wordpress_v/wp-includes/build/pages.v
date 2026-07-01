import rt

pub fn init_wp_includes_build_pages_php() {
	rt.include_file(@DIR + '/pages/font-library/page.php', '4')
	rt.include_file(@DIR + '/pages/font-library/page-wp-admin.php', '4')
	rt.include_file(@DIR + '/pages/options-connectors/page.php', '4')
	rt.include_file(@DIR + '/pages/options-connectors/page-wp-admin.php', '4')
}
