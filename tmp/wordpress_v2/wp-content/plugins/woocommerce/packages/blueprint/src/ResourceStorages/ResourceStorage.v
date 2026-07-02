import rt

interface ResourceStorage {
	get_supported_resource() rt.PhpVal
	download(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_slug := rt.new_null()
}
