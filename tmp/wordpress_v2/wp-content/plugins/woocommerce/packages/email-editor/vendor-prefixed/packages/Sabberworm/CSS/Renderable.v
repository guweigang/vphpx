import rt

interface Renderable {
	magic_tostring() rt.PhpVal
	render(rt.PhpVal) rt.PhpVal
	getlineno() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_oOutputFormat := rt.new_null()
}
