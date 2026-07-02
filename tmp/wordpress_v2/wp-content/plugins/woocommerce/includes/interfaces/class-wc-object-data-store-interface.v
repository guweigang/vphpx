import rt

interface WC_Object_Data_Store_Interface {
	create(rt.PhpVal) rt.PhpVal
	read(rt.PhpVal) rt.PhpVal
	update(rt.PhpVal) rt.PhpVal
	delete(rt.PhpVal, rt.PhpVal) rt.PhpVal
	read_meta(rt.PhpVal) rt.PhpVal
	delete_meta(rt.PhpVal, rt.PhpVal) rt.PhpVal
	add_meta(rt.PhpVal, rt.PhpVal) rt.PhpVal
	update_meta(rt.PhpVal, rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_data := rt.new_null()
	mut var_args := rt.new_null()
	mut var_meta := rt.new_null()
}
