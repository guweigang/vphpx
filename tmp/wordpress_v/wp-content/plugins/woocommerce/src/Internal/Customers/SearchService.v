import rt

struct Class_Automattic_WooCommerce_Internal_Customers_SearchService {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Customers_SearchService) find_user_ids_by_billing_email_for_coupons_usage_lookup(mut var_emails Class_Automattic_WooCommerce_Internal_Customers_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_emails_mutated := var_emails
	var_emails_mutated = rt.call_function('array_unique', [
		rt.call_function('array_map', [rt.new_string('strtolower'),
			rt.call_function('array_map', [rt.new_string('sanitize_email'),
				var_emails_mutated.dup()])]),
	])
	mut var_include_user_ids := rt.new_array()
	if rt.is_true(fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
		return temp.custom_orders_table_usage_is_enabled()
	}())
	{
		// unsupported statement: Stmt_Global
		mut var_placeholders := rt.call_function('implode', [
			rt.new_string(', '),
			rt.call_function('array_fill', [
				rt.new_int(0), rt.new_int(var_emails_mutated.dup().array_count()),
				rt.new_string('%s')])])
		var_include_user_ids = rt.call_method(var_wpdb, 'get_col', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.new_string('SELECT DISTINCT customer_id FROM %i WHERE billing_email IN (${var_placeholders.to_string()})'),
				fn () rt.PhpVal {
					mut temp :=
						Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{}
					return temp.get_orders_table_name()
				}(),
				var_emails_mutated.dup(),
			]),
		])
		if rt.is_true(rt.identical(rt.new_array(), var_include_user_ids)) {
			return rt.new_array()
		}
	}
	mut var_users_query := create_automattic_woocommerce_internal_customers_wp_user_query(rt.create_array([
		rt.ArrayItem{ key: 'fields', val: 'ID' },
		rt.ArrayItem{ key: 'include', val: var_include_user_ids },
		rt.ArrayItem{ key: 'meta_query', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'key', val: 'billing_email' },
				rt.ArrayItem{ key: 'value', val: var_emails_mutated },
				rt.ArrayItem{ key: 'compare', val: 'IN' },
			]) },
		]) },
	]))
	return rt.call_function('array_map', [rt.new_string('intval'),
		rt.call_function('array_unique', [var_users_query.get_results()])])
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Customers_WP_User_Query {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_customers_searchservice() &Class_Automattic_WooCommerce_Internal_Customers_SearchService {
	mut obj := &Class_Automattic_WooCommerce_Internal_Customers_SearchService{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil() &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_orderstabledatastore() &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_customers_wp_user_query() &Class_Automattic_WooCommerce_Internal_Customers_WP_User_Query {
	mut obj := &Class_Automattic_WooCommerce_Internal_Customers_WP_User_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Customers_SearchService) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'find_user_ids_by_billing_email_for_coupons_usage_lookup' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Customers_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.find_user_ids_by_billing_email_for_coupons_usage_lookup(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Customers_SearchService) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Customers_SearchService) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Customers_WP_User_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Customers_WP_User_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Customers_WP_User_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_customers_searchservice_php() {
	// unsupported statement: Stmt_Declare
}
