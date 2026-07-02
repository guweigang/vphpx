import rt

interface HasAlias {
	get_alias() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}
}
