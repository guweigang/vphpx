import rt

interface WC_Abstract_Order_Data_Store_Interface {
	read_items(rt.PhpVal, rt.PhpVal) rt.PhpVal
	delete_items(rt.PhpVal, rt.PhpVal) rt.PhpVal
	get_payment_token_ids(rt.PhpVal) rt.PhpVal
	update_payment_token_ids(rt.PhpVal, rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_order := rt.new_null()
	mut var_type := rt.new_null()
	mut var_token_ids := rt.new_null()
}
