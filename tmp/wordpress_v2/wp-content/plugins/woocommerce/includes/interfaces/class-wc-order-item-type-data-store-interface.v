import rt

interface WC_Order_Item_Type_Data_Store_Interface {
	save_item_data(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_item := rt.new_null()
}
