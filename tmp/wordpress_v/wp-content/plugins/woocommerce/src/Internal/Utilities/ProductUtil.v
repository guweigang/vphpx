import rt

struct Class_Automattic_WooCommerce_Internal_Utilities_ProductUtil {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_ProductUtil) delete_product_specific_transients(var_product_or_id rt.PhpVal) {
	mut var_parent_id := rt.new_int(rt.new_int(0))
	if rt.is_true(rt.new_bool(rt.instance_of(var_product_or_id,
		'Automattic_WooCommerce_Internal_Utilities_WC_Product')))
	{
		mut var_product := var_product_or_id
		mut var_product_id := rt.call_method(var_product, 'get_id', []rt.PhpVal{})
	} else {
		var_product_id = var_product_or_id
		var_product = rt.call_function('wc_get_product', [var_product_id.dup()])
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_product,
		'Automattic_WooCommerce_Internal_Utilities_WC_Product_Variation')))
	{
		var_parent_id = rt.call_method(var_product, 'get_parent_id', []rt.PhpVal{})
	}
	mut var_product_specific_transient_names := rt.create_array([
		rt.ArrayItem{ key: none, val: 'wc_product_children_' },
		rt.ArrayItem{ key: none, val: 'wc_var_prices_' },
		rt.ArrayItem{ key: none, val: 'wc_related_' },
		rt.ArrayItem{ key: none, val: 'wc_child_has_weight_' },
		rt.ArrayItem{ key: none, val: 'wc_child_has_dimensions_' },
	])
	{
		mut iter_1 := var_product_specific_transient_names.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_transient := item_1.val
			rt.call_function('delete_transient', [
				rt.concat(var_transient, var_product_id),
			])
			if rt.is_true(var_parent_id) {
				rt.call_function('delete_transient', [
					rt.concat(var_transient, var_parent_id),
				])
			}
		}
	}
}

fn create_automattic_woocommerce_internal_utilities_productutil() &Class_Automattic_WooCommerce_Internal_Utilities_ProductUtil {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_ProductUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_ProductUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'delete_product_specific_transients' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.delete_product_specific_transients(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_ProductUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_ProductUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_utilities_productutil_php() {
	// unsupported statement: Stmt_Declare
}
