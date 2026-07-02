import rt

interface UploadedFileInterface {
	getstream() rt.PhpVal
	moveto(rt.PhpVal) rt.PhpVal
	getsize() rt.PhpVal
	geterror() rt.PhpVal
	getclientfilename() rt.PhpVal
	getclientmediatype() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_targetPath := rt.new_null()
}
