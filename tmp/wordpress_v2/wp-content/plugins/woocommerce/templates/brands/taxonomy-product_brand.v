import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('wc_get_template', [rt.new_string('archive-product.php')])
}
