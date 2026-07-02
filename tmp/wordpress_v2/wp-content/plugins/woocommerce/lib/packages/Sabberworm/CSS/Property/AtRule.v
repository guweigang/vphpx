import rt

interface AtRule {
	atrulename() rt.PhpVal
	atruleargs() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}
}
