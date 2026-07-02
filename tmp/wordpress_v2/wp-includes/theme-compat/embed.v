import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('get_header', [rt.new_string('embed')])
	if rt.is_true(rt.call_function('have_posts', []rt.PhpVal{})) {
		for rt.is_true(rt.call_function('have_posts', []rt.PhpVal{})) {
			rt.call_function('the_post', []rt.PhpVal{})
			rt.call_function('get_template_part', [rt.new_string('embed'),
				rt.new_string('content')])
		}
	} else {
		rt.call_function('get_template_part', [rt.new_string('embed'),
			rt.new_string('404')])
	}
	rt.call_function('get_footer', [rt.new_string('embed')])
}
