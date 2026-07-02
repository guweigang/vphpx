import rt

interface WC_Product_Data_Store_Interface {
	get_on_sale_products() rt.PhpVal
	get_featured_product_ids() rt.PhpVal
	is_existing_sku(rt.PhpVal, rt.PhpVal) rt.PhpVal
	get_product_id_by_sku(rt.PhpVal) rt.PhpVal
	get_starting_sales() rt.PhpVal
	get_ending_sales() rt.PhpVal
	find_matching_product_variation(rt.PhpVal, rt.PhpVal) rt.PhpVal
	sort_all_product_variations(rt.PhpVal) rt.PhpVal
	get_related_products(rt.PhpVal, rt.PhpVal, rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	update_product_stock(rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	update_product_sales(rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	get_shipping_class_id_by_slug(rt.PhpVal) rt.PhpVal
	get_products(rt.PhpVal) rt.PhpVal
	get_product_type(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_product_id := rt.new_null()
	mut var_sku := rt.new_null()
	mut var_product := rt.new_null()
	mut var_match_attributes := rt.new_null()
	mut var_parent_id := rt.new_null()
	mut var_cats_array := rt.new_null()
	mut var_tags_array := rt.new_null()
	mut var_exclude_ids := rt.new_null()
	mut var_limit := rt.new_null()
	mut var_product_id_with_stock := rt.new_null()
	mut var_stock_quantity := rt.new_null()
	mut var_operation := rt.new_null()
	mut var_quantity := rt.new_null()
	mut var_slug := rt.new_null()
	mut var_args := rt.new_null()
}
