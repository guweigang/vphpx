import rt

pub fn init_wp_includes_requests_library_requests_php() {
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-requests.php',
		'2')
}
