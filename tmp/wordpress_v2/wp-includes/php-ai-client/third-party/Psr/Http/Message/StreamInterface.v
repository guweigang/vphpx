import rt

interface StreamInterface {
	magic_tostring() rt.PhpVal
	close() rt.PhpVal
	detach() rt.PhpVal
	getsize() rt.PhpVal
	tell() rt.PhpVal
	eof() rt.PhpVal
	isseekable() rt.PhpVal
	seek(rt.PhpVal, rt.PhpVal) rt.PhpVal
	rewind() rt.PhpVal
	iswritable() rt.PhpVal
	write(rt.PhpVal) rt.PhpVal
	isreadable() rt.PhpVal
	read(rt.PhpVal) rt.PhpVal
	getcontents() rt.PhpVal
	getmetadata(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_offset := rt.new_null()
	mut var_whence := rt.new_null()
	mut var_string := rt.new_null()
	mut var_length := rt.new_null()
	mut var_key := rt.new_null()
}
