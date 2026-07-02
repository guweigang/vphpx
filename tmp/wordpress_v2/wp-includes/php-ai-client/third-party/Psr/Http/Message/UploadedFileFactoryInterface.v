import rt

interface UploadedFileFactoryInterface {
	createuploadedfile(rt.PhpVal, rt.PhpVal, rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_stream := rt.new_null()
	mut var_size := rt.new_null()
	mut var_error := rt.new_null()
	mut var_clientFilename := rt.new_null()
	mut var_clientMediaType := rt.new_null()
}
