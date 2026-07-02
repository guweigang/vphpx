import rt

fn render_block_core_shortcode(var_attributes rt.PhpVal, var_content rt.PhpVal) rt.PhpVal {
	return rt.call_function('wpautop', [var_content.clone()])
}

fn register_block_core_shortcode() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/shortcode'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_shortcode' },
		]),
	])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_shortcode')])
}
