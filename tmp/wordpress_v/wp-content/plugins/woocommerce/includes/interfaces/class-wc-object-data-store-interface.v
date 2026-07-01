import rt

interface WC_Object_Data_Store_Interface {
	create(rt.PhpVal) rt.PhpVal
	read(rt.PhpVal) rt.PhpVal
	update(rt.PhpVal) rt.PhpVal
	delete(rt.PhpVal, rt.PhpVal) rt.PhpVal
	read_meta(rt.PhpVal) rt.PhpVal
	delete_meta(rt.PhpVal, rt.PhpVal) rt.PhpVal
	add_meta(rt.PhpVal, rt.PhpVal) rt.PhpVal
	update_meta(rt.PhpVal, rt.PhpVal) rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_includes_interfaces_class_wc_object_data_store_interface_php() {
	mut var_data := rt.new_null()
	mut var_args := rt.new_null()
	mut var_meta := rt.new_null()
}
