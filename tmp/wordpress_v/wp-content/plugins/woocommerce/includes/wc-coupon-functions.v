import rt
import crypto.md5

fn wc_get_coupon_types() rt.PhpVal {
	return rt.cast_array(rt.call_function('apply_filters', [rt.new_string('woocommerce_coupon_discount_types'), rt.create_array([rt.ArrayItem{ key: 'percent', val: rt.call_function('__', [rt.new_string('Percentage discount'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'fixed_cart', val: rt.call_function('__', [rt.new_string('Fixed cart discount'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'fixed_product', val: rt.call_function('__', [rt.new_string('Fixed product discount'), rt.new_string('woocommerce')]) }])]))
}

fn wc_get_coupon_type(type string) rt.PhpVal {
	mut var_types := wc_get_coupon_types()
	return if var_types.array_isset(rt.new_string(type)) { var_types.array_get(type) } else { rt.new_string('') }
}

fn wc_get_product_coupon_types() rt.PhpVal {
	return rt.cast_array(rt.call_function('apply_filters', [rt.new_string('woocommerce_product_coupon_types'), rt.create_array([rt.ArrayItem{ key: none, val: 'fixed_product' }, rt.ArrayItem{ key: none, val: 'percent' }])]))
}

fn wc_get_cart_coupon_types() rt.PhpVal {
	return rt.cast_array(rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_coupon_types'), rt.create_array([rt.ArrayItem{ key: none, val: 'fixed_cart' }])]))
}

fn wc_coupons_enabled() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_coupons_enabled'), rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_enable_coupons')]))])
}

fn wc_is_same_coupon(var_coupon_1 rt.PhpVal, var_coupon_2 rt.PhpVal) rt.PhpVal {
	return rt.identical(rt.call_function('wc_strtolower', [var_coupon_1.dup()]), rt.call_function('wc_strtolower', [var_coupon_2.dup()]))
}

fn wc_get_coupon_code_by_id(var_id rt.PhpVal) rt.PhpVal {
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('coupon'))
	return if !rt.is_true(var_id) { rt.new_string('') } else { // unsupported expression: Expr_Cast_String }
}

fn wc_get_coupon_id_by_code(var_code rt.PhpVal, exclude i64) i64 {
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_StringUtil{}; return temp.is_null_or_whitespace(arg_0) }(var_code.dup())) {
		return 0
	}
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('coupon'))
	mut var_hashed_code := md5.hexhash(rt.call_function('wc_strtolower', [var_code.dup()]).to_string())
	mut var_cache_key := rt.new_string((fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.get_cache_prefix(arg_0) }(rt.new_string('coupons'))).str() + 'coupon_id_from_code_' + var_hashed_code)
	mut var_ids := rt.call_function('wp_cache_get', [var_cache_key.dup(), rt.new_string('coupons')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_ids)) {
		var_ids = rt.call_method(var_data_store, 'get_ids_by_code', [var_code.dup()])
		if rt.is_true(var_ids) {
			rt.call_function('wp_cache_set', [var_cache_key.dup(), var_ids.dup(), rt.new_string('coupons')])
		}
	}
	var_ids = rt.call_function('array_diff', [rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('absint'), rt.cast_array(var_ids)])]), rt.create_array([rt.ArrayItem{ key: none, val: exclude }])])
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_get_coupon_id_from_code'), rt.call_function('absint', [rt.call_function('current', [var_ids.dup()])]), var_code.dup(), rt.new_int(exclude)])).to_i64()
}

fn wc_repair_zero_discount_coupons_lookup_table() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_table_name := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_coupon_lookup')
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.create_array([rt.ArrayItem{ key: 'success', val: false }, rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('Coupons lookup table does not exist.'), rt.new_string('woocommerce')]) }])
	}
	mut var_zero_discount_entries := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.new_string("SELECT order_id, coupon_id FROM ${var_table_name.to_string()} WHERE discount_amount = %f"), rt.new_float(0)]), rt.get_constant('ARRAY_A')])
	if !rt.is_true(var_zero_discount_entries) {
		return rt.create_array([rt.ArrayItem{ key: 'success', val: true }, rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('No entries with zero discount amount found. Coupons lookup table is up to date.'), rt.new_string('woocommerce')]) }])
	}
	mut var_processed_count := 0
	mut var_error_count := 0
	{
		mut iter_1 := var_zero_discount_entries.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_entry := item_1.val
			mut var_result := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore{}; return temp.sync_order_coupons(arg_0) }(var_entry.array_get('order_id'))
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				var_processed_count += 1
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			} else {
				var_error_count += 1
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			unsafe { goto end_label_1 }

catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'Exception') {
				mut var_e := var_e_1.dup()
				var_error_count += 1
				mut var_logger := rt.call_function('wc_get_logger', []rt.PhpVal{})
				rt.call_method(var_logger, 'error', [rt.call_function('sprintf', [rt.new_string('Error fixing coupon lookup entry for order %d: %s'), var_entry.array_get('order_id'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'coupons-lookup-fix' }, rt.ArrayItem{ key: 'order_id', val: var_entry.array_get('order_id') }, rt.ArrayItem{ key: 'error', val: var_e }])])
				unsafe { goto end_label_1 }
			}
			else {
				rt.throw_exception(var_e_1)
				unsafe { goto end_label_1 }
			}

end_label_1:
		}
	}
	rt.call_function('wp_cache_flush_group', [rt.new_string('coupons')])
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.get_transient_version(arg_0, arg_1) }(rt.new_string('woocommerce_reports'), rt.new_bool(true))
	mut var_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Coupons lookup table entries with zero discount amount repaired successfully. Processed %1$d entries with %2$d errors.'), rt.new_string('woocommerce')]), rt.new_int(var_processed_count).dup(), rt.new_int(var_error_count).dup()])
	return rt.create_array([rt.ArrayItem{ key: 'success', val: true }, rt.ArrayItem{ key: 'message', val: var_message }])
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_StringUtil {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore {
	rt.PhpObjectBase
}

fn create_wc_data_store() &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_stringutil() &Class_Automattic_WooCommerce_Utilities_StringUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_StringUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cache_helper() &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_coupons_datastore() &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_wc_coupon_functions_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
