import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomerHistory {
	rt.PhpObjectBase
pub mut:
	excluded_statuses rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomerHistory) output(mut var_order Class_WC_Order) {
	if rt.is_true(rt.identical(rt.new_string('auto-draft'), var_order.get_status())) {
		return
	}
	mut var_customer_history := this.get_customer_history(mut var_order)
	rt.call_function('wc_get_template', [rt.new_string('order/customer-history.php'),
		var_customer_history.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomerHistory) get_customer_history(mut var_order Class_WC_Order) rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_0 := iife_temp_0.custom_orders_table_usage_is_enabled()
	if rt.is_true(iife_result_0) {
		mut var_customer_id := var_order.get_customer_id()
		mut var_billing_email := var_order.get_billing_email()
		mut var_result := this.query_hpos(var_customer_id.to_i64(), var_billing_email.str())
	} else if rt.is_true(rt.call_function('method_exists', [var_order,
		rt.new_string('get_report_customer_id')]))
	{
		var_result = this.query_cpt((var_order.get_report_customer_id()).to_i64())
	} else {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [
			rt.new_string('CustomerHistory: Order object does not have get_report_customer_id method.'),
			rt.create_array([rt.ArrayItem{ key: 'source', val: 'customer-history' }]),
		])
		var_result = rt.array_to_object(rt.create_array([
			rt.ArrayItem{ key: 'orders_count', val: 0 },
			rt.ArrayItem{ key: 'total_spend', val: 0 },
		]))
	}
	mut var_orders_count := rt.new_int((if !(rt.get_property(var_result, 'orders_count')).is_null() {
		rt.get_property(var_result, 'orders_count')
	} else {
		rt.new_int(0)
	}).to_i64())
	mut var_total_spend := rt.new_float((if !(rt.get_property(var_result, 'total_spend')).is_null() {
		rt.get_property(var_result, 'total_spend')
	} else {
		rt.new_int(0)
	}).to_f64())
	mut var_all_statuses := rt.call_function('wc_get_order_statuses', []rt.PhpVal{})
	mut var_excluded_labels := rt.new_array()
	mut iter_1 := this.get_excluded_statuses().iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_slug := item_1.val
		if rt.is_true(rt.identical(rt.new_string('checkout-draft'), var_slug)) {
			continue
		}
		mut var_prefixed := rt.new_string('wc-' + var_slug.str())
		if var_all_statuses.array_isset(var_prefixed) {
			var_excluded_labels.array_push(rt.call_function('mb_strtolower', [
				var_all_statuses.array_get(var_prefixed),
			]))
		}
	}
	if !(!rt.is_true(var_excluded_labels)) {
		mut var_tooltip := rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Total number of orders for this customer, excluding %s orders, including the current one.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('wp_sprintf_l', [
				rt.new_string('%l'),
				var_excluded_labels.clone(),
			]),
		])
	} else {
		var_tooltip = rt.call_function('__', [
			rt.new_string('Total number of orders for this customer, including the current one.'),
			rt.new_string('woocommerce'),
		])
	}
	return rt.create_array([rt.ArrayItem{ key: 'orders_count', val: var_orders_count },
		rt.ArrayItem{ key: 'total_spend', val: var_total_spend },
		rt.ArrayItem{
			key: 'avg_order_value'
			val: if rt.is_true(rt.greater(var_orders_count, rt.new_int(0))) {
				rt.div(var_total_spend, var_orders_count)
			} else {
				rt.new_int(0)
			}
		}, rt.ArrayItem{ key: 'tooltip', val: var_tooltip }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomerHistory) query_hpos(customer_id i64, billing_email string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut customer_id_mutated := customer_id
	mut billing_email_mutated := billing_email
	mut var_default := rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'orders_count', val: 0 },
		rt.ArrayItem{ key: 'total_spend', val: 0 },
	]))
	mut var_excluded_statuses_sql := rt.new_string(this.get_excluded_statuses_sql())
	mut iife_temp_1 :=
		Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{}
	mut iife_result_1 := iife_temp_1.get_orders_table_name()
	mut var_orders_table := iife_result_1
	mut var_sql := rt.new_null()
	if customer_id_mutated > 0 {
		mut var_status_filter := rt.new_string((if rt.is_true(var_excluded_statuses_sql) {
			'AND status NOT IN ${var_excluded_statuses_sql.to_string()}'
		} else {
			''
		}).str())
		mut var_co_status_filter := rt.new_string((if rt.is_true(var_excluded_statuses_sql) {
			'AND co.status NOT IN ${var_excluded_statuses_sql.to_string()}'
		} else {
			''
		}).str())
		var_sql = rt.call_method(var_wpdb, 'prepare', [
			rt.new_string("SELECT COUNT(*) AS orders_count,\n\t\t\t\t\tCOALESCE( SUM( filtered.total_amount ), 0 ) + COALESCE( SUM( r.refund_total ), 0 ) AS total_spend\n\t\t\t\tFROM (\n\t\t\t\t\tSELECT id, total_amount\n\t\t\t\t\tFROM %i\n\t\t\t\t\tWHERE customer_id = %d AND type = 'shop_order' ${var_status_filter.to_string()}\n\t\t\t\t) AS filtered\n\t\t\t\tLEFT JOIN (\n\t\t\t\t\tSELECT rp.parent_order_id, SUM( rp.total_amount ) AS refund_total\n\t\t\t\t\tFROM %i AS rp\n\t\t\t\t\tINNER JOIN %i AS co ON rp.parent_order_id = co.id\n\t\t\t\t\tWHERE rp.type = 'shop_order_refund'\n\t\t\t\t\t\tAND co.customer_id = %d AND co.type = 'shop_order' ${var_co_status_filter.to_string()}\n\t\t\t\t\tGROUP BY rp.parent_order_id\n\t\t\t\t) AS r ON filtered.id = r.parent_order_id"),
			var_orders_table.clone(),
			rt.new_int(customer_id_mutated).clone(),
			var_orders_table.clone(),
			var_orders_table.clone(),
			rt.new_int(customer_id_mutated).clone(),
		])
	} else if rt.is_true(rt.new_bool('' != billing_email_mutated)) {
		mut iife_temp_2 :=
			Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{}
		mut iife_result_2 := iife_temp_2.get_addresses_table_name()
		mut var_addresses_table := iife_result_2
		mut var_o_status_filter := rt.new_string((if rt.is_true(var_excluded_statuses_sql) {
			'AND o.status NOT IN ${var_excluded_statuses_sql.to_string()}'
		} else {
			''
		}).str())
		var_co_status_filter = rt.new_string((if rt.is_true(var_excluded_statuses_sql) {
			'AND co.status NOT IN ${var_excluded_statuses_sql.to_string()}'
		} else {
			''
		}).str())
		var_sql = rt.call_method(var_wpdb, 'prepare', [
			rt.new_string("SELECT COUNT(*) AS orders_count,\n\t\t\t\t\tCOALESCE( SUM( filtered.total_amount ), 0 ) + COALESCE( SUM( r.refund_total ), 0 ) AS total_spend\n\t\t\t\tFROM (\n\t\t\t\t\tSELECT o.id, o.total_amount\n\t\t\t\t\tFROM %i AS o\n\t\t\t\t\tINNER JOIN %i AS a ON o.id = a.order_id AND a.address_type = 'billing'\n\t\t\t\t\tWHERE o.customer_id = 0 AND a.email = %s AND o.type = 'shop_order' ${var_o_status_filter.to_string()}\n\t\t\t\t) AS filtered\n\t\t\t\tLEFT JOIN (\n\t\t\t\t\tSELECT rp.parent_order_id, SUM( rp.total_amount ) AS refund_total\n\t\t\t\t\tFROM %i AS rp\n\t\t\t\t\tINNER JOIN %i AS co ON rp.parent_order_id = co.id\n\t\t\t\t\tINNER JOIN %i AS ca ON co.id = ca.order_id AND ca.address_type = 'billing'\n\t\t\t\t\tWHERE rp.type = 'shop_order_refund'\n\t\t\t\t\t\tAND co.customer_id = 0 AND ca.email = %s AND co.type = 'shop_order' ${var_co_status_filter.to_string()}\n\t\t\t\t\tGROUP BY rp.parent_order_id\n\t\t\t\t) AS r ON filtered.id = r.parent_order_id"),
			var_orders_table.clone(),
			var_addresses_table.clone(),
			rt.new_string(billing_email_mutated).clone(),
			var_orders_table.clone(),
			var_orders_table.clone(),
			var_addresses_table.clone(),
			rt.new_string(billing_email_mutated).clone(),
		])
	}
	if rt.is_true(rt.identical(rt.new_null(), var_sql)) {
		return var_default.clone()
	}
	mut var_row := rt.call_method(var_wpdb, 'get_row', [var_sql.clone()])
	if rt.is_true(rt.get_property(var_wpdb, 'last_error')) {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [
			rt.call_function('sprintf', [
				rt.new_string('CustomerHistory: Failed to query HPOS order stats for customer_id=%d. DB error: %s'),
				rt.new_int(customer_id_mutated).clone(),
				rt.get_property(var_wpdb, 'last_error'),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'source', val: 'customer-history' },
			]),
		])
	}
	return if !var_row.is_null() { var_row } else { var_default }
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomerHistory) query_cpt(customer_report_id i64) rt.PhpVal {
	mut var_args := rt.create_array([
		rt.ArrayItem{ key: 'customers', val: rt.create_array([
			rt.ArrayItem{ key: none, val: customer_report_id },
		]) },
		rt.ArrayItem{ key: 'order_after', val: rt.new_null() },
		rt.ArrayItem{ key: 'order_before', val: rt.new_null() },
	])
	mut var_customers_query :=
		create_automattic_woocommerce_admin_api_reports_customers_query(var_args.clone())
	mut var_customer_data := var_customers_query.get_data()
	mut var_customer_row := if !(rt.get_property(var_customer_data, 'data').array_get(rt.new_int(0))).is_null() {
		rt.get_property(var_customer_data, 'data').array_get(rt.new_int(0))
	} else {
		rt.new_null()
	}
	return mut rt.array_to_object(rt.create_array([
		rt.ArrayItem{
			key: 'orders_count'
			val: if !(var_customer_row.array_get(rt.new_string('orders_count'))).is_null() {
				var_customer_row.array_get(rt.new_string('orders_count'))
			} else {
				rt.new_int(0)
			}
		},
		rt.ArrayItem{
			key: 'total_spend'
			val: if !(var_customer_row.array_get(rt.new_string('total_spend'))).is_null() {
				var_customer_row.array_get(rt.new_string('total_spend'))
			} else {
				rt.new_int(0)
			}
		},
	]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomerHistory) get_excluded_statuses() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), this.excluded_statuses)))) {
		return this.excluded_statuses
	}
	mut var_excluded_statuses := rt.call_function('get_option', [
		rt.new_string('woocommerce_excluded_report_order_statuses'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'pending' },
			rt.ArrayItem{ key: none, val: 'failed' }, rt.ArrayItem{ key: none, val: 'cancelled' }]),
	])
	if !(var_excluded_statuses.clone().is_array()) {
		var_excluded_statuses = rt.create_array([
			rt.ArrayItem{ key: none, val: 'pending' },
			rt.ArrayItem{ key: none, val: 'failed' },
			rt.ArrayItem{ key: none, val: 'cancelled' },
		])
	}
	var_excluded_statuses = rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'auto-draft' },
			rt.ArrayItem{ key: none, val: 'trash' }]),
		var_excluded_statuses.clone(),
	])
	var_excluded_statuses = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_analytics_excluded_order_statuses'),
		var_excluded_statuses.clone(),
	])
	if !(var_excluded_statuses.clone().is_array()) {
		var_excluded_statuses = rt.create_array([
			rt.ArrayItem{ key: none, val: 'auto-draft' },
			rt.ArrayItem{ key: none, val: 'trash' },
			rt.ArrayItem{ key: none, val: 'pending' },
			rt.ArrayItem{ key: none, val: 'failed' },
			rt.ArrayItem{ key: none, val: 'cancelled' },
		])
	}
	this.excluded_statuses = var_excluded_statuses.clone()
	return this.excluded_statuses
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomerHistory) get_excluded_statuses_sql() string {
	mut var_wpdb := rt.new_null()
	mut var_excluded_statuses := this.get_excluded_statuses()
	if !rt.is_true(var_excluded_statuses) {
		return ''
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_status := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		var_status = rt.call_function('sanitize_title', [var_status.clone()])
		return (if rt.is_true(rt.identical(rt.new_string('auto-draft'), var_status))
			|| rt.is_true(rt.identical(rt.new_string('trash'), var_status)) {
			var_status
		} else {
			'wc-' + var_status.str()
		}).str()
	}
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_status := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		var_status = rt.call_function('sanitize_title', [var_status.clone()])
		return (if rt.is_true(rt.identical(rt.new_string('auto-draft'), var_status))
			|| rt.is_true(rt.identical(rt.new_string('trash'), var_status)) {
			var_status
		} else {
			'wc-' + var_status.str()
		}).str()
	}
	mut var_prefixed := rt.call_function('array_map', [rt.new_closure(closure_4_fn),
		var_excluded_statuses.clone()])
	mut var_placeholders := rt.call_function('implode', [rt.new_string(','),
		rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_prefixed.clone().array_count()),
			rt.new_string('%s')])])
	return (rt.call_method(var_wpdb, 'prepare', [
		rt.new_string('( ${var_placeholders.to_string()} )'),
		var_prefixed.clone(),
	])).str()
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Query {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_orders_metaboxes_customerhistory(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomerHistory {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomerHistory{
		PhpObjectBase:     rt.PhpObjectBase{}
		excluded_statuses: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_orderstabledatastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_customers_query(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Query {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomerHistory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'output' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.output(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_customer_history' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_customer_history(mut dispatch_arg_0)
		}
		'query_hpos' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.query_hpos(dispatch_arg_0, dispatch_arg_1)
		}
		'query_cpt' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.query_cpt(dispatch_arg_0)
		}
		'get_excluded_statuses' {
			return this.get_excluded_statuses()
		}
		'get_excluded_statuses_sql' {
			return rt.new_string(this.get_excluded_statuses_sql())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomerHistory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'excluded_statuses' { return this.excluded_statuses }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomerHistory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'excluded_statuses' {
			this.excluded_statuses = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
