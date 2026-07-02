import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-requests.php',
		'2')
}
