import rt

interface SimplePie_Cache_Base {
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('interface_exists', [rt.new_string('SimplePie\\Cache\\Base')])
	if false {
	}
}
