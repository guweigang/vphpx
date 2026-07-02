import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_internal_admin_schedulers_customersscheduler() {
	rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler',
		'name', rt.new_string('customers'))
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler.init() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}
	mut iife_result_0 := iife_temp_0.init()
	this.Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.init()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler.get_dependencies() rt.PhpVal {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler{}
	mut iife_result_1 := iife_temp_1.get_action(rt.new_string('delete_batch_init'))
	return rt.create_array([rt.ArrayItem{ key: 'delete_batch_init', val: iife_result_1 }])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler.get_items(limit i64, page i64, days bool, skip_existing bool) rt.PhpVal {
	mut var_customer_roles := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_analytics_import_customer_roles'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'customer' }]),
	])
	mut var_query_args := rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ID' },
		rt.ArrayItem{ key: 'orderby', val: 'ID' }, rt.ArrayItem{ key: 'order', val: 'ASC' },
		rt.ArrayItem{ key: 'number', val: limit }, rt.ArrayItem{ key: 'paged', val: page },
		rt.ArrayItem{ key: 'role__in', val: var_customer_roles }])
	if rt.is_true(rt.new_bool(rt.new_bool(days).is_long())) {
		var_query_args.array_set('date_query', rt.create_array([
			rt.ArrayItem{ key: 'after', val: rt.call_function('gmdate', [
				rt.new_string('Y-m-d 00:00:00'),
				rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.mul(rt.get_constant('DAY_IN_SECONDS'),
					rt.new_bool(days))),
			]) },
		]))
	}
	if var_skip_existing {
		rt.call_function('add_action', [rt.new_string('pre_user_query'),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'exclude_existing_customers_from_query' }])])
	}
	mut var_customer_query :=
		create_automattic_woocommerce_internal_admin_schedulers_wp_user_query(var_query_args.clone())
	rt.call_function('remove_action', [rt.new_string('pre_user_query'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'exclude_existing_customers_from_query' }])])
	return mut rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'total', val: var_customer_query.get_total() },
		rt.ArrayItem{ key: 'ids', val: var_customer_query.get_results() },
	]))
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler.exclude_existing_customers_from_query(var_wp_user_query rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	rt.get_property(var_wp_user_query, 'query_where') = rt.concat(rt.get_property(var_wp_user_query,
		'query_where'), rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' AND NOT EXISTS (\n\t\t\tSELECT ID FROM '), rt.get_property(var_wpdb,
		'prefix')), rt.new_string('wc_customer_lookup\n\t\t\tWHERE ')), rt.get_property(var_wpdb,
		'prefix')), rt.new_string('wc_customer_lookup.user_id = ')), rt.get_property(var_wpdb,
		'users')), rt.new_string('.ID\n\t\t)')))
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler.get_total_imported() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	return rt.call_method(var_wpdb, 'get_var', [
		rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM '), rt.get_property(var_wpdb,
			'prefix')), rt.new_string('wc_customer_lookup')),
	])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler.import(var_user_id rt.PhpVal) {
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}
	mut iife_result_2 := iife_temp_2.update_registered_customer(var_user_id.clone())
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler.delete(var_batch_size rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_customer_ids := rt.call_method(var_wpdb, 'get_col', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT customer_id FROM '), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('wc_customer_lookup ORDER BY customer_id ASC LIMIT %d')),
			var_batch_size.clone(),
		]),
	])
	mut iter_1 := var_customer_ids.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_customer_id := item_1.val
		mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}
		mut iife_result_3 := iife_temp_3.delete_customer(var_customer_id.clone())
	}
}

struct Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Schedulers_WP_User_Query {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_schedulers_customersscheduler(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_schedulers_importscheduler(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_customers_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_schedulers_ordersscheduler(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_schedulers_wp_user_query(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_WP_User_Query {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_WP_User_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler.init()
			return rt.new_null()
		}
		'get_dependencies' {
			return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler.get_dependencies()
		}
		'get_items' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler.get_items(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'exclude_existing_customers_from_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler.exclude_existing_customers_from_query(dispatch_arg_0)
			return rt.new_null()
		}
		'get_total_imported' {
			return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler.get_total_imported()
		}
		'import' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler.import
			dispatch_arg_0
			return rt.new_null()
		}
		'delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler.delete(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_WP_User_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_WP_User_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_WP_User_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
