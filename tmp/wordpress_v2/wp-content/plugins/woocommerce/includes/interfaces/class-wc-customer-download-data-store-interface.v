import rt

interface WC_Customer_Download_Data_Store_Interface {
	delete_by_id(rt.PhpVal) rt.PhpVal
	delete_by_order_id(rt.PhpVal) rt.PhpVal
	delete_by_download_id(rt.PhpVal) rt.PhpVal
	get_downloads(rt.PhpVal) rt.PhpVal
	update_download_id(rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	get_downloads_for_customer(rt.PhpVal) rt.PhpVal
	update_user_by_order_id(rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_id := rt.new_null()
	mut var_args := rt.new_null()
	mut var_product_id := rt.new_null()
	mut var_old_id := rt.new_null()
	mut var_new_id := rt.new_null()
	mut var_customer_id := rt.new_null()
	mut var_order_id := rt.new_null()
	mut var_email := rt.new_null()
}
