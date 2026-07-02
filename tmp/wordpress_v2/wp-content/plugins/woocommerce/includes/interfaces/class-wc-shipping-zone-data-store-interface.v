import rt

interface WC_Shipping_Zone_Data_Store_Interface {
	get_methods(rt.PhpVal, rt.PhpVal) rt.PhpVal
	get_method_count(rt.PhpVal) rt.PhpVal
	add_method(rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	delete_method(rt.PhpVal) rt.PhpVal
	get_method(rt.PhpVal) rt.PhpVal
	get_zone_id_from_package(rt.PhpVal) rt.PhpVal
	get_zones() rt.PhpVal
	get_zone_id_by_instance_id(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_zone_id := rt.new_null()
	mut var_enabled_only := rt.new_null()
	mut var_type := rt.new_null()
	mut var_order := rt.new_null()
	mut var_instance_id := rt.new_null()
	mut var_package := rt.new_null()
	mut var_id := rt.new_null()
}
