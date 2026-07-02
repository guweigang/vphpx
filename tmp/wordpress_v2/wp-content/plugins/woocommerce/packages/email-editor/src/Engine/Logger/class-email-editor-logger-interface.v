import rt

interface Email_Editor_Logger_Interface {
	emergency(rt.PhpVal, rt.PhpVal) rt.PhpVal
	alert(rt.PhpVal, rt.PhpVal) rt.PhpVal
	critical(rt.PhpVal, rt.PhpVal) rt.PhpVal
	error(rt.PhpVal, rt.PhpVal) rt.PhpVal
	warning(rt.PhpVal, rt.PhpVal) rt.PhpVal
	notice(rt.PhpVal, rt.PhpVal) rt.PhpVal
	info(rt.PhpVal, rt.PhpVal) rt.PhpVal
	debug(rt.PhpVal, rt.PhpVal) rt.PhpVal
	log(rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_message := rt.new_null()
	mut var_context := rt.new_null()
	mut var_level := rt.new_null()
}
