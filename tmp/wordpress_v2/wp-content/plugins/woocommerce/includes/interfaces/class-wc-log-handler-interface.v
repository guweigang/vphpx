import rt

interface WC_Log_Handler_Interface {
	handle(rt.PhpVal, rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_timestamp := rt.new_null()
	mut var_level := rt.new_null()
	mut var_message := rt.new_null()
	mut var_context := rt.new_null()
}
