import rt

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	rt.call_function('the_title', [
		rt.new_string('<h1 class="product_title entry-title">'),
		rt.new_string('</h1>'),
	])
}
