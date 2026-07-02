import rt

interface RouteInterface {
	get_path() rt.PhpVal
	get_args() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}
}
