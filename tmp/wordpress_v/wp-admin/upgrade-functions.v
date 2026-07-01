import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('_deprecated_file', [
		rt.call_function('basename', [rt.new_string(@FILE)]),
		rt.new_string('2.5.0'),
		rt.new_string('wp-admin/includes/upgrade.php'),
	])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/upgrade.php', '4')
}
