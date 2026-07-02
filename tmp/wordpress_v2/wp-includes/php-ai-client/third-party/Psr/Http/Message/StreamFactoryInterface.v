import rt

interface StreamFactoryInterface {
	createstream(rt.PhpVal) rt.PhpVal
	createstreamfromfile(rt.PhpVal, rt.PhpVal) rt.PhpVal
	createstreamfromresource(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_content := rt.new_null()
	mut var_filename := rt.new_null()
	mut var_mode := rt.new_null()
	mut var_resource := rt.new_null()
}
