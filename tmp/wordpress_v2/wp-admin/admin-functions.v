import rt

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		fn () {
			print((rt.new_string('-1')).str())
			exit(0)
		}()
	}
	rt.call_function('_deprecated_file', [
		rt.call_function('basename', [rt.new_string(@FILE)]),
		rt.new_string('2.5.0'),
		rt.new_string('wp-admin/includes/admin.php'),
	])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/admin.php', '4')
}
