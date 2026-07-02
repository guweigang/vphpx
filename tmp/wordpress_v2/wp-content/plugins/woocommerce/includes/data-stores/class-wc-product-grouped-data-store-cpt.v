import rt

struct Class_WC_Product_Grouped_Data_Store_CPT {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Product_Grouped_Data_Store_CPT) update_post_meta(var_product rt.PhpVal, force bool) {
	mut var_meta_key_to_props := {
		'_children': 'children'
	}
	mut var_props_to_update := if var_force {
		var_meta_key_to_props
	} else {
		this.get_props_to_update(var_product.clone(), var_meta_key_to_props.clone())
	}
	mut iter_1 := var_props_to_update.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_prop := item_1.val
		mut var_meta_key := item_1.key
		mut var_value := rt.call_method(var_product, 'get_${var_prop.to_string()}', [
			rt.new_string('edit'),
		])
		mut var_updated := rt.call_function('update_post_meta', [
			rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
			var_meta_key.clone(),
			var_value.clone(),
		])
		if rt.is_true(var_updated) {
			rt.get_property(rt.new_object('WC_Product_Grouped_Data_Store_CPT', [
				'WC_Product_Data_Store_CPT',
				'WC_Object_Data_Store_Interface',
			], &this), 'updated_props').array_push(var_prop.clone())
		}
	}
	this.Class_WC_Product_Data_Store_CPT.update_post_meta(var_product.clone(), rt.new_bool(force))
}

fn (mut this Class_WC_Product_Grouped_Data_Store_CPT) handle_updated_props(var_product rt.PhpVal) {
	if rt.is_true(rt.call_function('in_array', [rt.new_string('children'),
		rt.get_property(rt.new_object('WC_Product_Grouped_Data_Store_CPT', [
			'WC_Product_Data_Store_CPT',
			'WC_Object_Data_Store_Interface',
		], &this), 'updated_props'),
		rt.new_bool(true)]))
	{
		this.update_prices_from_children(var_product.clone())
	}
	this.Class_WC_Product_Data_Store_CPT.handle_updated_props(var_product.clone())
}

fn (mut this Class_WC_Product_Grouped_Data_Store_CPT) sync_price(var_product rt.PhpVal) {
	this.update_prices_from_children(var_product.clone())
}

fn (mut this Class_WC_Product_Grouped_Data_Store_CPT) update_prices_from_children(var_product rt.PhpVal) {
	mut var_product_id := rt.call_method(var_product, 'get_id', []rt.PhpVal{})
	mut var_child_prices := rt.new_array()
	mut var_child_ids := rt.call_method(var_product, 'get_children', [
		rt.new_string('edit'),
	])
	if !(!rt.is_true(var_child_ids)) {
		rt.call_function('_prime_post_caches', [var_child_ids.clone()])
		mut iter_2 := var_child_ids.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_child_id := item_2.val
			mut var_child := rt.call_function('wc_get_product', [
				var_child_id.clone()])
			if rt.is_true(var_child) {
				var_child_prices.array_push(rt.call_method(var_child, 'get_price', [
					rt.new_string('edit'),
				]))
			}
		}
		var_child_prices = rt.call_function('array_filter', [
			var_child_prices.clone()])
	}
	rt.call_function('delete_post_meta', [var_product_id.clone(),
		rt.new_string('_price')])
	rt.call_function('delete_post_meta', [var_product_id.clone(),
		rt.new_string('_sale_price')])
	rt.call_function('delete_post_meta', [var_product_id.clone(),
		rt.new_string('_regular_price')])
	if !(!rt.is_true(var_child_prices)) {
		rt.call_function('add_post_meta', [var_product_id.clone(),
			rt.new_string('_price'), rt.call_function('min', [
				var_child_prices.clone()])])
		rt.call_function('add_post_meta', [var_product_id.clone(),
			rt.new_string('_price'), rt.call_function('max', [
				var_child_prices.clone()])])
	}
	this.update_lookup_table(var_product_id.clone(), rt.new_string('wc_product_meta_lookup'))
	rt.call_function('do_action', [rt.new_string('woocommerce_updated_product_price'),
		var_product_id.clone()])
}

struct Class_WC_Product_Data_Store_CPT {
	rt.PhpObjectBase
}

fn create_wc_product_grouped_data_store_cpt(_args ...rt.PhpVal) &Class_WC_Product_Grouped_Data_Store_CPT {
	mut obj := &Class_WC_Product_Grouped_Data_Store_CPT{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product_data_store_cpt(_args ...rt.PhpVal) &Class_WC_Product_Data_Store_CPT {
	mut obj := &Class_WC_Product_Data_Store_CPT{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Product_Grouped_Data_Store_CPT) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'update_post_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.update_post_meta(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'handle_updated_props' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handle_updated_props(dispatch_arg_0)
			return rt.new_null()
		}
		'sync_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.sync_price(dispatch_arg_0)
			return rt.new_null()
		}
		'update_prices_from_children' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update_prices_from_children(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Product_Grouped_Data_Store_CPT) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Grouped_Data_Store_CPT) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Product_Data_Store_CPT) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Data_Store_CPT) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Data_Store_CPT) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
