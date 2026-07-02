import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_product := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_review_ratings_enabled',
		[]rt.PhpVal{})))))
	{
		return rt.new_null()
	}
	rt.echo_val(rt.call_function('wc_get_rating_html', [
		rt.call_method(var_product, 'get_average_rating', []rt.PhpVal{}),
	]))
}
