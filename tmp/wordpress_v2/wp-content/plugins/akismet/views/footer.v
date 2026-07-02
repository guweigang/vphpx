import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('do_action', [rt.new_string('akismet_footer')])
}
