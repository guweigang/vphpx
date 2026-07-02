import rt

interface HasFieldsType {
	getfield(rt.PhpVal) rt.PhpVal
	hasfield(rt.PhpVal) rt.PhpVal
	findfield(rt.PhpVal) rt.PhpVal
	getfields() rt.PhpVal
	getvisiblefields() rt.PhpVal
	getfieldnames() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_name := rt.new_null()
}
