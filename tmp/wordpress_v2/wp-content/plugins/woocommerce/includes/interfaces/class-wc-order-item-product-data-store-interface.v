import rt

interface WC_Order_Item_Product_Data_Store_Interface {
	get_download_ids(rt.PhpVal, rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_item := rt.new_null()
	mut var_order := rt.new_null()
}
