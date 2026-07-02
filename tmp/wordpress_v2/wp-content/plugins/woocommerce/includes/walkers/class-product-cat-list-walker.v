import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
		'/class-wc-product-cat-list-walker.php', '3')
}
