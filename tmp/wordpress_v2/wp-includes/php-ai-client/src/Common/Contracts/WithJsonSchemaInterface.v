import rt

interface WithJsonSchemaInterface {
	getjsonschema() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}
}
