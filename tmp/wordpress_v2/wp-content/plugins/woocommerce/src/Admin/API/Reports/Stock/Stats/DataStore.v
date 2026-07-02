import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_DataStore {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_DataStore) get_data(var_query rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
	mut var_report_data := rt.new_array()
	mut var_cache_expire := rt.mul(rt.get_constant('DAY_IN_SECONDS'), rt.new_int(30))
	mut var_low_stock_transient_name := rt.new_string('wc_admin_stock_count_lowstock')
	mut var_low_stock_count := rt.call_function('get_transient', [
		var_low_stock_transient_name.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_low_stock_count)) {
		var_low_stock_count = rt.new_int(this.get_low_stock_count())
		rt.call_function('set_transient', [var_low_stock_transient_name.clone(),
			var_low_stock_count.clone(), var_cache_expire.clone()])
	} else {
		var_low_stock_count = rt.new_int(var_low_stock_count.clone().to_i64())
	}
	var_report_data.array_set(Class_Automattic_WooCommerce_Enums_ProductStockStatus.low_stock(),
		var_low_stock_count.clone())
	mut var_status_options := rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{})
	mut iter_1 := var_status_options.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_label := item_1.val
		mut var_status := item_1.key
		mut var_transient_name := rt.new_string('wc_admin_stock_count_' + var_status.str())
		mut var_count := rt.call_function('get_transient', [var_transient_name.clone()])
		if rt.is_true(rt.identical(rt.new_bool(false), var_count)) {
			var_count = rt.new_int(this.get_count(var_status.clone()))
			rt.call_function('set_transient', [var_transient_name.clone(),
				var_count.clone(), var_cache_expire.clone()])
		} else {
			var_count = rt.new_int(var_count.clone().to_i64())
		}
		var_report_data.array_set(var_status, var_count.clone())
	}
	mut var_product_count_transient_name := rt.new_string('wc_admin_product_count')
	mut var_product_count := rt.call_function('get_transient', [
		var_product_count_transient_name.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_product_count)) {
		var_product_count = rt.new_int(this.get_product_count())
		rt.call_function('set_transient', [var_product_count_transient_name.clone(),
			var_product_count.clone(), var_cache_expire.clone()])
	} else {
		var_product_count = rt.new_int(var_product_count.clone().to_i64())
	}
	var_report_data.array_set('products', var_product_count.clone())
	return var_report_data.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_DataStore) get_low_stock_count() i64 {
	mut var_wpdb := rt.new_null()
	mut var_no_stock_amount := rt.call_function('absint', [
		rt.call_function('max', [
			rt.call_function('get_option', [
				rt.new_string('woocommerce_notify_no_stock_amount'),
			]),
			rt.new_int(0),
		]),
	])
	mut var_low_stock_amount := rt.call_function('absint', [
		rt.call_function('max', [
			rt.call_function('get_option', [
				rt.new_string('woocommerce_notify_low_stock_amount'),
			]),
			rt.new_int(1),
		]),
	])
	return rt.new_int((rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\tSELECT count( DISTINCT posts.ID ) FROM '), rt.get_property(var_wpdb,
				'posts')), rt.new_string(' posts\n\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb,
				'wc_product_meta_lookup')),
				rt.new_string(' wc_product_meta_lookup ON posts.ID = wc_product_meta_lookup.product_id\n\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb,
				'postmeta')),
				rt.new_string(" low_stock_amount_meta ON posts.ID = low_stock_amount_meta.post_id AND low_stock_amount_meta.meta_key = '_low_stock_amount'\n\t\t\t\tWHERE posts.post_type IN ( 'product', 'product_variation' )\n\t\t\t\tAND posts.post_status IN ( 'publish', 'private' )\n\t\t\t\tAND wc_product_meta_lookup.stock_quantity IS NOT NULL\n\t\t\t\tAND wc_product_meta_lookup.stock_status = 'instock'\n\t\t\t\tAND (\n\t\t\t\t\t(\n\t\t\t\t\t\tlow_stock_amount_meta.meta_value > ''\n\t\t\t\t\t\tAND wc_product_meta_lookup.stock_quantity <= CAST(low_stock_amount_meta.meta_value AS SIGNED)\n\t\t\t\t\t\tAND wc_product_meta_lookup.stock_quantity > %d\n\t\t\t\t\t)\n\t\t\t\t\tOR (\n\t\t\t\t\t\t(\n\t\t\t\t\t\t\tlow_stock_amount_meta.meta_value IS NULL OR low_stock_amount_meta.meta_value <= ''\n\t\t\t\t\t\t)\n\t\t\t\t\t\tAND wc_product_meta_lookup.stock_quantity <= %d\n\t\t\t\t\t\tAND wc_product_meta_lookup.stock_quantity > %d\n\t\t\t\t\t)\n\t\t\t\t)\n\t\t\t\t")),
			var_no_stock_amount.clone(),
			var_low_stock_amount.clone(),
			var_no_stock_amount.clone(),
		]),
	])).to_i64())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_DataStore) get_count(var_status rt.PhpVal) i64 {
	mut var_wpdb := rt.new_null()
	return rt.new_int((rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\tSELECT count( DISTINCT posts.ID ) FROM '), rt.get_property(var_wpdb,
				'posts')), rt.new_string(' posts\n\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb,
				'wc_product_meta_lookup')),
				rt.new_string(" wc_product_meta_lookup ON posts.ID = wc_product_meta_lookup.product_id\n\t\t\t\tWHERE posts.post_type IN ( 'product', 'product_variation' )\n\t\t\t\tAND posts.post_status IN ( 'publish', 'private' )\n\t\t\t\tAND wc_product_meta_lookup.stock_status = %s\n\t\t\t\t")),
			var_status.clone(),
		]),
	])).to_i64())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_DataStore) get_product_count() i64 {
	mut var_query_args := rt.new_array()
	var_query_args.array_set('post_type', rt.create_array([
		rt.ArrayItem{ key: none, val: 'product' },
		rt.ArrayItem{ key: none, val: 'product_variation' },
	]))
	mut var_query := create_automattic_woocommerce_admin_api_reports_stock_stats_wp_query()
	var_query.query(var_query_args.clone())
	return rt.get_property(var_query, 'found_posts').to_i64()
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_WP_Query {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_stock_stats_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_stock_stats_wp_query(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_WP_Query {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_data(dispatch_arg_0)
		}
		'get_low_stock_count' {
			return rt.new_int(this.get_low_stock_count())
		}
		'get_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.get_count(dispatch_arg_0))
		}
		'get_product_count' {
			return rt.new_int(this.get_product_count())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
