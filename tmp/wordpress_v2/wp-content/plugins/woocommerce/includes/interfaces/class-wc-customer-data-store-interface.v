import rt

interface WC_Customer_Data_Store_Interface {
	get_last_order(rt.PhpVal) rt.PhpVal
	get_order_count(rt.PhpVal) rt.PhpVal
	get_total_spent(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_customer := rt.new_null()
}
