import rt

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	rt.call_function('_deprecated_file', [
		rt.call_function('basename', [rt.new_string(@FILE)]),
		rt.new_string('5.3.0'),
		rt.new_string('wp-admin/includes/class-custom-background.php'),
	])
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-custom-background.php', '4')
}
