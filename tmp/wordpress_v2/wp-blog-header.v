import rt

fn main() {
	defer {
		rt.shutdown()
	}

	if !(!(rt.new_bool(var_wp_did_header)).is_null()) {
		mut var_wp_did_header := true
		rt.include_file(@DIR + '/wp-load.php', '4')
		rt.call_function('wp', []rt.PhpVal{})
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/template-loader.php',
			'4')
	}
}
