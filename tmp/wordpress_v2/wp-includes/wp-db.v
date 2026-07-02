import rt

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('function_exists', [rt.new_string('_deprecated_file')])) {
		rt.call_function('_deprecated_file', [
			rt.call_function('basename', [rt.new_string(@FILE)]),
			rt.new_string('6.1.0'),
			rt.new_string('wp-includes/class-wpdb.php'),
		])
	}
	rt.include_file(@DIR + '/class-wpdb.php', '4')
}
