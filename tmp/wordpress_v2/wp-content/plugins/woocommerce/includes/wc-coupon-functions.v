import rt
import crypto.md5

fn wc_get_coupon_types() rt.PhpVal {
	return rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_coupon_discount_types'),
		rt.create_array([
			rt.ArrayItem{ key: 'percent', val: rt.call_function('__', [
				rt.new_string('Percentage discount'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'fixed_cart', val: rt.call_function('__', [
				rt.new_string('Fixed cart discount'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'fixed_product', val: rt.call_function('__', [
				rt.new_string('Fixed product discount'),
				rt.new_string('woocommerce'),
			]) },
		]),
	]))
}

fn wc_get_coupon_type(type string) rt.PhpVal {
	mut var_type := type
	mut var_types := rt.new_null()
	var_types = wc_get_coupon_types()
	return if var_types.array_isset(rt.new_string(type)) {
		var_types.array_get(rt.new_string(type))
	} else {
		rt.new_string('')
	}
}

fn wc_get_product_coupon_types() rt.PhpVal {
	return rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_coupon_types'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'fixed_product' },
			rt.ArrayItem{ key: none, val: 'percent' }]),
	]))
}

fn wc_get_cart_coupon_types() rt.PhpVal {
	return rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cart_coupon_types'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'fixed_cart' }]),
	]))
}

fn wc_coupons_enabled() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_coupons_enabled'),
		rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
			rt.new_string('woocommerce_enable_coupons'),
		])),
	])
}

fn wc_is_same_coupon(var_coupon_1 rt.PhpVal, var_coupon_2 rt.PhpVal) rt.PhpVal {
	return rt.identical(rt.call_function('wc_strtolower', [var_coupon_1.clone()]), rt.call_function('wc_strtolower', [
		var_coupon_2.clone(),
	]))
}

fn wc_get_coupon_code_by_id(var_id rt.PhpVal) string {
	mut var_data_store := rt.new_null()
	mut iife_temp_0 := Class_WC_Data_Store{}
	mut iife_result_0 := iife_temp_0.load(rt.new_string('coupon'))
	var_data_store = iife_result_0
	return if !rt.is_true(var_id) { '' } else { (rt.call_method(var_data_store, 'get_code_by_id', [
			var_id.clone(),
		])).str() }
}

fn wc_get_coupon_id_by_code(var_code rt.PhpVal, exclude i64) i64 {
	mut var_exclude := exclude
	mut var_data_store := rt.new_null()
	mut var_hashed_code := ''
	mut var_cache_key := rt.new_null()
	mut var_ids := rt.new_null()
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_StringUtil{}
	mut iife_result_1 := iife_temp_1.is_null_or_whitespace(var_code.clone())
	if rt.is_true(iife_result_1) {
		return 0
	}
	mut iife_temp_2 := Class_WC_Data_Store{}
	mut iife_result_2 := iife_temp_2.load(rt.new_string('coupon'))
	var_data_store = iife_result_2
	var_hashed_code = md5.hexhash(rt.call_function('wc_strtolower', [
		var_code.clone()]).to_string())
	mut iife_temp_3 := Class_WC_Cache_Helper{}
	mut iife_result_3 := iife_temp_3.get_cache_prefix(rt.new_string('coupons'))
	var_cache_key = rt.new_string(iife_result_3.str() + 'coupon_id_from_code_' + var_hashed_code)
	var_ids = rt.call_function('wp_cache_get', [var_cache_key.clone(),
		rt.new_string('coupons')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_ids)) {
		var_ids = rt.call_method(var_data_store, 'get_ids_by_code', [
			var_code.clone()])
		if rt.is_true(var_ids) {
			rt.call_function('wp_cache_set', [var_cache_key.clone(),
				var_ids.clone(), rt.new_string('coupons')])
		}
	}
	var_ids = rt.call_function('array_diff', [
		rt.call_function('array_filter', [
			rt.call_function('array_map', [rt.new_string('absint'),
				rt.cast_array(var_ids)]),
		]),
		rt.create_array([
			rt.ArrayItem{ key: none, val: exclude },
		]),
	])
	return (rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_coupon_id_from_code'),
		rt.call_function('absint', [rt.call_function('current', [
			var_ids.clone()])]),
		var_code.clone(),
		rt.new_int(exclude),
	])).to_i64()
}

fn wc_repair_zero_discount_coupons_lookup_table() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_table_name := rt.new_null()
	mut var_zero_discount_entries := rt.new_null()
	mut var_processed_count := i64(0)
	mut var_error_count := i64(0)
	mut var_entry := rt.new_null()
	mut var_result := rt.new_null()
	mut var_e := rt.new_null()
	mut var_logger := rt.new_null()
	mut var_message := rt.new_null()
	var_table_name = rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
		'wc_order_coupon_lookup')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_wpdb, 'get_var', [
		rt.new_string("SHOW TABLES LIKE '${var_table_name.to_string()}'"),
	]), var_table_name))))
	{
		return rt.create_array([rt.ArrayItem{ key: 'success', val: false },
			rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
				rt.new_string('Coupons lookup table does not exist.'),
				rt.new_string('woocommerce'),
			]) }])
	}
	var_zero_discount_entries = rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('SELECT order_id, coupon_id FROM ${var_table_name.to_string()} WHERE discount_amount = %f'),
			rt.new_float(0),
		]),
		rt.get_constant('ARRAY_A'),
	])
	if !rt.is_true(var_zero_discount_entries) {
		return rt.create_array([rt.ArrayItem{ key: 'success', val: true },
			rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
				rt.new_string('No entries with zero discount amount found. Coupons lookup table is up to date.'),
				rt.new_string('woocommerce'),
			]) }])
	}
	var_processed_count = 0
	var_error_count = 0
	mut iter_1 := var_zero_discount_entries.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_entry_shadow := item_1.val
		mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore{}
		mut iife_result_4 :=
			iife_temp_4.sync_order_coupons(var_entry_shadow.array_get(rt.new_string('order_id')))
		var_result = iife_result_4
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_result)))) {
			var_processed_count += 1
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
		} else {
			var_error_count += 1
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		unsafe {
			goto end_label_1
		}
		catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Exception') {
			var_e = var_e_1.clone()
			var_error_count += 1
			var_logger = rt.call_function('wc_get_logger', []rt.PhpVal{})
			rt.call_method(var_logger, 'error', [
				rt.call_function('sprintf', [
					rt.new_string('Error fixing coupon lookup entry for order %d: %s'),
					var_entry_shadow.array_get(rt.new_string('order_id')),
					rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
				]),
				rt.create_array([
					rt.ArrayItem{ key: 'source', val: 'coupons-lookup-fix' },
					rt.ArrayItem{
						key: 'order_id'
						val: var_entry_shadow.array_get(rt.new_string('order_id'))
					},
					rt.ArrayItem{ key: 'error', val: var_e },
				]),
			])
			unsafe {
				goto end_label_1
			}
		} else {
			rt.throw_exception(var_e_1)
			unsafe {
				goto end_label_1
			}
		}

		end_label_1:
	}
	rt.call_function('wp_cache_flush_group', [rt.new_string('coupons')])
	mut iife_temp_5 := Class_WC_Cache_Helper{}
	mut iife_result_5 := iife_temp_5.get_transient_version(rt.new_string('woocommerce_reports'),
		rt.new_bool(true))
	var_message = rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('Coupons lookup table entries with zero discount amount repaired successfully. Processed %1$d entries with %2$d errors.'),
			rt.new_string('woocommerce'),
		]),
		rt.new_int(var_processed_count).clone(),
		rt.new_int(var_error_count).clone(),
	])
	return rt.create_array([rt.ArrayItem{ key: 'success', val: true },
		rt.ArrayItem{ key: 'message', val: var_message }])
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

fn create_wc_data_store(_args ...rt.PhpVal) &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_stringutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_StringUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_StringUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cache_helper(_args ...rt.PhpVal) &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_coupons_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
