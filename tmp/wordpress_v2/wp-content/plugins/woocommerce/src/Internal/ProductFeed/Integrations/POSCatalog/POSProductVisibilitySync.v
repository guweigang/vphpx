import rt

struct Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSProductVisibilitySync {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSProductVisibilitySync) register_hooks() {
	rt.call_function('add_action', [rt.new_string('woocommerce_new_product_variation'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSProductVisibilitySync',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'inherit_parent_pos_visibility' },
		]),
		rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSProductVisibilitySync) set_product_pos_visibility(product_id i64, visible_in_pos bool) {
	mut var_is_currently_visible := rt.new_bool(!(rt.is_true(rt.call_function('has_term', [
		rt.new_string('pos-hidden'),
		rt.new_string('pos_product_visibility'),
		rt.new_int(product_id),
	]))))
	if rt.is_true(rt.identical(var_is_currently_visible, rt.new_bool(visible_in_pos))) {
		return
	}
	if var_visible_in_pos {
		rt.call_function('wp_remove_object_terms', [rt.new_int(product_id),
			rt.new_string('pos-hidden'), rt.new_string('pos_product_visibility')])
	} else {
		rt.call_function('wp_set_object_terms', [rt.new_int(product_id),
			rt.new_string('pos-hidden'), rt.new_string('pos_product_visibility')])
	}
	mut var_product := rt.call_function('wc_get_product', [rt.new_int(product_id)])
	if rt.is_true(var_product)
		&& rt.is_true(rt.call_method(var_product, 'is_type', [rt.new_string('variable')])) {
		this.sync_pos_visibility_to_variations(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_WC_Product](var_product),
			visible_in_pos)
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSProductVisibilitySync) sync_pos_visibility_to_variations(mut var_product Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_WC_Product, visible_in_pos bool) {
	mut var_product_mutated := var_product
	mut var_variation_ids := rt.call_method(var_product_mutated, 'get_children', []rt.PhpVal{})
	mut iter_1 := var_variation_ids.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_variation_id := item_1.val
		if var_visible_in_pos {
			rt.call_function('wp_remove_object_terms', [var_variation_id.clone(),
				rt.new_string('pos-hidden'), rt.new_string('pos_product_visibility')])
		} else {
			rt.call_function('wp_set_object_terms', [var_variation_id.clone(),
				rt.new_string('pos-hidden'), rt.new_string('pos_product_visibility')])
		}
		mut var_variation := rt.call_function('wc_get_product', [
			var_variation_id.clone()])
		if rt.is_true(var_variation) {
			rt.call_method(var_variation, 'save', []rt.PhpVal{})
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSProductVisibilitySync) inherit_parent_pos_visibility(var_variation_id rt.PhpVal, var_variation rt.PhpVal) {
	mut var_variation_mutated := var_variation
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_variation_mutated,
		'Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_WC_Product_Variation'))))))
	{
		return
	}
	mut var_parent_id := rt.call_method(var_variation_mutated, 'get_parent_id', []rt.PhpVal{})
	if rt.is_true(rt.call_function('has_term', [rt.new_string('pos-hidden'),
		rt.new_string('pos_product_visibility'), var_parent_id.clone()]))
	{
		rt.call_function('wp_set_object_terms', [var_variation_id.clone(),
			rt.new_string('pos-hidden'), rt.new_string('pos_product_visibility')])
	}
}

fn create_automattic_woocommerce_internal_productfeed_integrations_poscatalog_posproductvisibilitysync(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSProductVisibilitySync {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSProductVisibilitySync{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSProductVisibilitySync) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_hooks' {
			this.register_hooks()
			return rt.new_null()
		}
		'set_product_pos_visibility' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.set_product_pos_visibility(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'sync_pos_visibility_to_variations' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_WC_Product](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.sync_pos_visibility_to_variations(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'inherit_parent_pos_visibility' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.inherit_parent_pos_visibility(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSProductVisibilitySync) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSProductVisibilitySync) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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
