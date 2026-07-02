import rt

interface WC_Coupon_Data_Store_Interface {
	increase_usage_count(rt.PhpVal, rt.PhpVal) rt.PhpVal
	decrease_usage_count(rt.PhpVal, rt.PhpVal) rt.PhpVal
	get_usage_by_user_id(rt.PhpVal, rt.PhpVal) rt.PhpVal
	get_code_by_id(rt.PhpVal) rt.PhpVal
	get_ids_by_code(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_coupon := rt.new_null()
	mut var_used_by := rt.new_null()
	mut var_user_id := rt.new_null()
	mut var_id := rt.new_null()
	mut var_code := rt.new_null()
}
