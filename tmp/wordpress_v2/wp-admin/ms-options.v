import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	rt.call_function('wp_redirect', [
		rt.call_function('network_admin_url', [rt.new_string('settings.php')]),
	])
	exit(0)
}
