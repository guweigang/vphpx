import rt

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_StockManagementHelper {
	rt.PhpObjectBase
pub mut:
		managed_variations rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_StockManagementHelper) get_managed_variations(mut var_product Class_WC_Product) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product.is_type(Class_Automattic_WooCommerce_Enums_ProductType.variable()))))) {
		return rt.new_array()
	}
	mut var_product_id := var_product.get_id()
	if this.managed_variations.array_isset(var_product_id) {
		return this.managed_variations.array_get(var_product_id)
	}
	mut var_children := var_product.get_children()
	if !rt.is_true(var_children) {
		return rt.new_array()
	}
	// unsupported statement: Stmt_Global
	mut var_format := rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_children.dup().array_count()), rt.new_string('%d')])
	mut var_query_in := rt.new_string('(' + (rt.call_function('implode', [rt.new_string(','), var_format.dup()])).str() + ')')
	mut var_managed_children := rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.new_string('SELECT DISTINCT post_id FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE meta_key = \'_manage_stock\' AND meta_value != \'yes\' AND post_id IN ')), var_query_in), var_children.dup()])])
	this.managed_variations.array_set(var_product_id, rt.call_function('array_map', [rt.new_string('intval'), var_managed_children.dup()]))
	return this.managed_variations.array_get(var_product_id)
}

fn create_automattic_woocommerce_internal_stocknotifications_utilities_stockmanagementhelper() &Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_StockManagementHelper {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_StockManagementHelper{
		PhpObjectBase: rt.PhpObjectBase{}
		managed_variations: rt.new_array()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_StockManagementHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_managed_variations' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_managed_variations(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_StockManagementHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'managed_variations' { return this.managed_variations }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_StockManagementHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'managed_variations' { this.managed_variations = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_src_internal_stocknotifications_utilities_stockmanagementhelper_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
