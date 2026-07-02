import rt

interface WC_Order_Item_Data_Store_Interface {
	add_order_item(rt.PhpVal, rt.PhpVal) rt.PhpVal
	update_order_item(rt.PhpVal, rt.PhpVal) rt.PhpVal
	delete_order_item(rt.PhpVal) rt.PhpVal
	update_metadata(rt.PhpVal, rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	add_metadata(rt.PhpVal, rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	delete_metadata(rt.PhpVal, rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	get_metadata(rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	get_order_id_by_order_item_id(rt.PhpVal) rt.PhpVal
	get_order_item_type(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_order_id := rt.new_null()
	mut var_item := rt.new_null()
	mut var_item_id := rt.new_null()
	mut var_meta_key := rt.new_null()
	mut var_meta_value := rt.new_null()
	mut var_prev_value := rt.new_null()
	mut var_unique := rt.new_null()
	mut var_delete_all := rt.new_null()
	mut var_key := rt.new_null()
	mut var_single := rt.new_null()
}
