import rt

interface AbstractType {
	resolvevalue(rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	resolvetype(rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_objectValue := rt.new_null()
	mut var_context := rt.new_null()
	mut var_info := rt.new_null()
}
