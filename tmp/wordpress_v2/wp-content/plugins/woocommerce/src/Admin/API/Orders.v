import rt

struct Class_Automattic_WooCommerce_Admin_API_Orders {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc-analytics')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Orders) get_collection_params() rt.PhpVal {
	mut var_params :=
		this.Class_Automattic_WooCommerce_Admin_API_WC_REST_Orders_Controller.get_collection_params()
	var_params.array_set('number', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to orders matching part of an order number.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_get_mut('status').array_set('default', rt.create_array([
		rt.ArrayItem{ key: none, val: 'any' },
	]))
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_API_Reports_Controller{}
	mut iife_result_0 := iife_temp_0.get_order_statuses()
	var_params.array_get_mut('status').array_get_mut('items').array_set('enum', iife_result_0)
	return var_params.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Orders) prepare_objects_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_args :=
		this.Class_Automattic_WooCommerce_Admin_API_WC_REST_Orders_Controller.prepare_objects_query(var_request.clone())
	if !(!rt.is_true(var_request.array_get(rt.new_string('number')))) {
		var_args = this.search_partial_order_number(var_request.array_get(rt.new_string('number')),
			var_args.clone())
	}
	return var_args.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Orders) search_partial_order_number(var_number rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	mut var_partial_number := rt.new_string(var_number.clone().to_string().trim_space())
	mut var_limit :=
		rt.new_int(var_args_mutated.array_get(rt.new_string('posts_per_page')).to_i64())
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_1 := iife_temp_1.custom_orders_table_usage_is_enabled()
	if rt.is_true(iife_result_1) {
		mut iife_temp_2 :=
			Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{}
		mut iife_result_2 := iife_temp_2.get_orders_table_name()
		mut var_order_table_name := iife_result_2
		mut var_order_ids := rt.call_method(var_wpdb, 'get_col', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.new_string("SELECT id\n\t\t\t\t\tFROM ${var_order_table_name.to_string()}\n\t\t\t\t\t    WHERE type = 'shop_order'\n\t\t\t\t\t    AND id LIKE %s\n\t\t\t\t\tLIMIT %d"),
				rt.new_string(
					(rt.call_method(var_wpdb, 'esc_like', [rt.call_function('absint', [var_partial_number.clone()])])).str() +
					'%'),
				var_limit.clone(),
			]),
		])
	} else {
		var_order_ids = rt.call_method(var_wpdb, 'get_col', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT ID\n\t\t\t\tFROM '), rt.get_property(var_wpdb,
					'prefix')),
					rt.new_string("posts\n\t\t\t\tWHERE post_type = 'shop_order'\n\t\t\t\tAND ID LIKE %s\n\t\t\t\tLIMIT %d")),
				rt.new_string(
					(rt.call_method(var_wpdb, 'esc_like', [rt.call_function('absint', [var_partial_number.clone()])])).str() +
					'%'),
				var_limit.clone(),
			]),
		])
	}
	var_order_ids = if !rt.is_true(var_order_ids) { rt.create_array([
			rt.ArrayItem{ key: none, val: 0 },
		]) } else { var_order_ids }
	var_args_mutated.array_set('post__in', var_order_ids.clone())
	return var_args_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Orders) get_products_by_order_id(var_order_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_order_items_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
		'woocommerce_order_items')
	mut var_order_itemmeta_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
		'woocommerce_order_itemmeta')
	mut var_products := rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT\n\t\t\t\torder_id,\n\t\t\t\torder_itemmeta.meta_value as product_id,\n\t\t\t\torder_itemmeta_2.meta_value as product_quantity,\n\t\t\t\torder_itemmeta_3.meta_value as variation_id,\n\t\t\t\t'), rt.get_property(var_wpdb,
				'posts')), rt.new_string('.post_title as product_name\n\t\t\tFROM ')),
				var_order_items_table), rt.new_string(' order_items\n\t\t\t    LEFT JOIN ')),
				var_order_itemmeta_table),
				rt.new_string(' order_itemmeta on order_items.order_item_id = order_itemmeta.order_item_id\n\t\t\t    LEFT JOIN ')),
				var_order_itemmeta_table),
				rt.new_string(' order_itemmeta_2 on order_items.order_item_id = order_itemmeta_2.order_item_id\n\t\t\t    LEFT JOIN ')),
				var_order_itemmeta_table),
				rt.new_string(' order_itemmeta_3 on order_items.order_item_id = order_itemmeta_3.order_item_id\n\t\t\t    LEFT JOIN ')), rt.get_property(var_wpdb,
				'posts')), rt.new_string(' on ')), rt.get_property(var_wpdb, 'posts')),
				rt.new_string(".ID = order_itemmeta.meta_value\n\t\t\tWHERE\n\t\t\t\torder_id = ( %d )\n\t\t\t    AND order_itemmeta.meta_key = '_product_id'\n\t\t\t\tAND order_itemmeta_2.meta_key = '_qty'\n\t\t\t  \tAND order_itemmeta_3.meta_key = '_variation_id'\n\t\t\tGROUP BY product_id\n\t\t\t")),
			var_order_id.clone(),
		]),
		rt.get_constant('ARRAY_A'),
	])
	return var_products.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Orders) get_customer_by_id(var_customer_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_customer_lookup_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
		'wc_customer_lookup')
	mut var_customer := rt.call_method(var_wpdb, 'get_row', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('SELECT * FROM ${var_customer_lookup_table.to_string()} WHERE customer_id = ( %d )'),
			var_customer_id.clone(),
		]),
		rt.get_constant('ARRAY_A'),
	])
	return var_customer.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Orders) get_formatted_item_data(var_object rt.PhpVal) rt.PhpVal {
	mut var_extra_fields := rt.create_array([rt.ArrayItem{ key: none, val: 'customer' },
		rt.ArrayItem{ key: none, val: 'products' }])
	mut var_fields := rt.new_bool(false)
	if !(!rt.is_true(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Orders', [
		'Automattic_WooCommerce_Admin_API_WC_REST_Orders_Controller',
	], &this), 'request').array_get(rt.new_string('_fields')))) {
		var_fields = rt.call_function('wp_parse_list', [
			rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Orders', [
				'Automattic_WooCommerce_Admin_API_WC_REST_Orders_Controller',
			], &this), 'request').array_get(rt.new_string('_fields')),
		])
		if 0 == var_fields.clone().array_count() {
			var_fields = rt.new_bool(false)
		} else {
			var_fields = rt.call_function('array_map', [rt.new_string('trim'),
				var_fields.clone()])
		}
	}
	mut var_using_order_class_override := rt.call_function('is_a', [
		var_object.clone(), rt.new_string('\\Automattic\\WooCommerce\\Admin\\Overrides\\Order')])
	if rt.is_true(var_using_order_class_override) {
		mut var_data := rt.call_method(var_object, 'get_data_without_line_items', []rt.PhpVal{})
	} else {
		var_data = rt.call_method(var_object, 'get_data', []rt.PhpVal{})
	}
	var_extra_fields = if rt.is_true(rt.identical(rt.new_bool(false), var_fields)) { rt.new_array() } else { rt.call_function('array_intersect', [
			var_extra_fields.clone(),
			var_fields.clone(),
		]) }
	mut var_format_decimal := rt.create_array([
		rt.ArrayItem{ key: none, val: 'discount_total' },
		rt.ArrayItem{ key: none, val: 'discount_tax' },
		rt.ArrayItem{ key: none, val: 'shipping_total' },
		rt.ArrayItem{ key: none, val: 'shipping_tax' },
		rt.ArrayItem{ key: none, val: 'shipping_total' },
		rt.ArrayItem{ key: none, val: 'shipping_tax' },
		rt.ArrayItem{ key: none, val: 'cart_tax' },
		rt.ArrayItem{ key: none, val: 'total' },
		rt.ArrayItem{ key: none, val: 'total_tax' },
	])
	mut var_format_date := rt.create_array([
		rt.ArrayItem{ key: none, val: 'date_created' },
		rt.ArrayItem{ key: none, val: 'date_modified' },
		rt.ArrayItem{ key: none, val: 'date_completed' },
		rt.ArrayItem{ key: none, val: 'date_paid' },
	])
	mut var_format_line_items := rt.create_array([
		rt.ArrayItem{ key: none, val: 'line_items' },
		rt.ArrayItem{ key: none, val: 'tax_lines' },
		rt.ArrayItem{ key: none, val: 'shipping_lines' },
		rt.ArrayItem{ key: none, val: 'fee_lines' },
		rt.ArrayItem{ key: none, val: 'coupon_lines' },
	])
	mut var_extra_data := rt.new_array()
	mut iter_1 := var_extra_fields.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_field := item_1.val
		mut switch_val_1 := var_field
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('customer'))) {
			var_extra_data.array_set('customer',
				this.get_customer_by_id(var_data.array_get(rt.new_string('customer_id'))))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('products'))) {
			var_extra_data.array_set('products', this.get_products_by_order_id(rt.call_method(var_object,
				'get_id', []rt.PhpVal{})))
		}
	}
	mut iter_2 := var_format_decimal.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_key := item_2.val
		var_data.array_set(var_key, rt.call_function('wc_format_decimal', [
			var_data.array_get(var_key),
			rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Orders', [
				'Automattic_WooCommerce_Admin_API_WC_REST_Orders_Controller',
			], &this), 'request').array_get(rt.new_string('dp')),
		]))
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_object,
		'Automattic_WooCommerce_Admin_API_WC_Order')))
	{
		var_data.array_set('total_formatted', rt.call_function('wp_strip_all_tags', [
			rt.call_function('html_entity_decode', [
				rt.call_method(var_object, 'get_formatted_order_total', []rt.PhpVal{}),
			]),
			rt.new_bool(true),
		]))
	}
	mut iter_3 := var_format_date.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_key := item_3.val
		mut var_datetime := var_data.array_get(var_key)
		var_data.array_set(var_key, rt.call_function('wc_rest_prepare_date_response', [
			var_datetime.clone(),
			rt.new_bool(false),
		]))
		var_data.array_set(var_key.str() + '_gmt', rt.call_function('wc_rest_prepare_date_response', [
			var_datetime.clone(),
		]))
	}
	mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_3 :=
		iife_temp_3.remove_status_prefix(var_data.array_get(rt.new_string('status')))
	var_data.array_set('status', iife_result_3)
	mut var_formatted_line_items := rt.new_array()
	mut iter_4 := var_format_line_items.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_key := item_4.val
		if rt.is_true(rt.identical(rt.new_bool(false), var_fields))
			|| rt.is_true(rt.call_function('in_array', [var_key.clone(), var_fields.clone(), rt.new_bool(true)])) {
			if rt.is_true(var_using_order_class_override) {
				mut var_line_item_data := rt.call_method(var_object, 'get_line_item_data', [
					var_key.clone(),
				])
			} else {
				var_line_item_data = var_data.array_get(var_key)
			}
			var_formatted_line_items.array_set(var_key, rt.call_function('array_values', [
				rt.call_function('array_map', [
					rt.create_array([
						rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Orders', [
							'Automattic_WooCommerce_Admin_API_WC_REST_Orders_Controller',
						], &this) },
						rt.ArrayItem{ key: none, val: 'get_order_item_data' },
					]),
					var_line_item_data.clone(),
				]),
			]))
		}
	}
	var_data.array_set('refunds', rt.new_array())
	mut iter_5 := rt.call_method(var_object, 'get_refunds', []rt.PhpVal{}).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_refund := item_5.val
		var_data.array_get_mut('refunds').array_push(rt.create_array([
			rt.ArrayItem{ key: 'id', val: rt.call_method(var_refund, 'get_id', []rt.PhpVal{}) },
			rt.ArrayItem{
				key: 'reason'
				val: if rt.is_true(rt.call_method(var_refund, 'get_reason', []rt.PhpVal{})) {
					rt.call_method(var_refund, 'get_reason', []rt.PhpVal{})
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'total'
				val: '-' +(rt.call_function('wc_format_decimal', [rt.call_method(var_refund, 'get_amount', []rt.PhpVal{}), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Orders', ['Automattic_WooCommerce_Admin_API_WC_REST_Orders_Controller'], &this), 'request').array_get(rt.new_string('dp'))])).str()
			},
		]))
	}
	return rt.call_function('array_merge', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: rt.call_method(var_object, 'get_id', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'parent_id', val: var_data.array_get(rt.new_string('parent_id')) },
			rt.ArrayItem{ key: 'number', val: var_data.array_get(rt.new_string('number')) },
			rt.ArrayItem{ key: 'order_key', val: var_data.array_get(rt.new_string('order_key')) },
			rt.ArrayItem{ key: 'created_via', val: var_data.array_get(rt.new_string('created_via')) },
			rt.ArrayItem{ key: 'version', val: var_data.array_get(rt.new_string('version')) },
			rt.ArrayItem{ key: 'status', val: var_data.array_get(rt.new_string('status')) },
			rt.ArrayItem{ key: 'currency', val: var_data.array_get(rt.new_string('currency')) },
			rt.ArrayItem{
				key: 'date_created'
				val: var_data.array_get(rt.new_string('date_created'))
			},
			rt.ArrayItem{
				key: 'date_created_gmt'
				val: var_data.array_get(rt.new_string('date_created_gmt'))
			},
			rt.ArrayItem{
				key: 'date_modified'
				val: var_data.array_get(rt.new_string('date_modified'))
			},
			rt.ArrayItem{
				key: 'date_modified_gmt'
				val: var_data.array_get(rt.new_string('date_modified_gmt'))
			},
			rt.ArrayItem{
				key: 'discount_total'
				val: var_data.array_get(rt.new_string('discount_total'))
			},
			rt.ArrayItem{
				key: 'discount_tax'
				val: var_data.array_get(rt.new_string('discount_tax'))
			},
			rt.ArrayItem{
				key: 'shipping_total'
				val: var_data.array_get(rt.new_string('shipping_total'))
			},
			rt.ArrayItem{
				key: 'shipping_tax'
				val: var_data.array_get(rt.new_string('shipping_tax'))
			},
			rt.ArrayItem{ key: 'cart_tax', val: var_data.array_get(rt.new_string('cart_tax')) },
			rt.ArrayItem{ key: 'total', val: var_data.array_get(rt.new_string('total')) },
			rt.ArrayItem{
				key: 'total_formatted'
				val: if var_data.array_isset(rt.new_string('total_formatted')) {
					var_data.array_get(rt.new_string('total_formatted'))
				} else {
					var_data.array_get(rt.new_string('total'))
				}
			},
			rt.ArrayItem{ key: 'total_tax', val: var_data.array_get(rt.new_string('total_tax')) },
			rt.ArrayItem{
				key: 'prices_include_tax'
				val: var_data.array_get(rt.new_string('prices_include_tax'))
			},
			rt.ArrayItem{ key: 'customer_id', val: var_data.array_get(rt.new_string('customer_id')) },
			rt.ArrayItem{
				key: 'customer_ip_address'
				val: var_data.array_get(rt.new_string('customer_ip_address'))
			},
			rt.ArrayItem{
				key: 'customer_user_agent'
				val: var_data.array_get(rt.new_string('customer_user_agent'))
			},
			rt.ArrayItem{
				key: 'customer_note'
				val: var_data.array_get(rt.new_string('customer_note'))
			},
			rt.ArrayItem{ key: 'billing', val: var_data.array_get(rt.new_string('billing')) },
			rt.ArrayItem{ key: 'shipping', val: var_data.array_get(rt.new_string('shipping')) },
			rt.ArrayItem{
				key: 'payment_method'
				val: var_data.array_get(rt.new_string('payment_method'))
			},
			rt.ArrayItem{
				key: 'payment_method_title'
				val: var_data.array_get(rt.new_string('payment_method_title'))
			},
			rt.ArrayItem{
				key: 'transaction_id'
				val: var_data.array_get(rt.new_string('transaction_id'))
			},
			rt.ArrayItem{ key: 'date_paid', val: var_data.array_get(rt.new_string('date_paid')) },
			rt.ArrayItem{
				key: 'date_paid_gmt'
				val: var_data.array_get(rt.new_string('date_paid_gmt'))
			},
			rt.ArrayItem{
				key: 'date_completed'
				val: var_data.array_get(rt.new_string('date_completed'))
			},
			rt.ArrayItem{
				key: 'date_completed_gmt'
				val: var_data.array_get(rt.new_string('date_completed_gmt'))
			},
			rt.ArrayItem{ key: 'cart_hash', val: var_data.array_get(rt.new_string('cart_hash')) },
			rt.ArrayItem{ key: 'meta_data', val: var_data.array_get(rt.new_string('meta_data')) },
			rt.ArrayItem{ key: 'refunds', val: var_data.array_get(rt.new_string('refunds')) },
		]),
		var_formatted_line_items.clone(),
		var_extra_data.clone(),
	])
}

struct Class_Automattic_WooCommerce_Admin_API_WC_REST_Orders_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_orders(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Orders {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Orders{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc-analytics')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_rest_orders_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_WC_REST_Orders_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_REST_Orders_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_Orders) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_collection_params' {
			return this.get_collection_params()
		}
		'prepare_objects_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_objects_query(dispatch_arg_0)
		}
		'search_partial_order_number' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.search_partial_order_number(dispatch_arg_0, dispatch_arg_1)
		}
		'get_products_by_order_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_products_by_order_id(dispatch_arg_0)
		}
		'get_customer_by_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_customer_by_id(dispatch_arg_0)
		}
		'get_formatted_item_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_formatted_item_data(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Orders) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Orders) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Orders_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WC_REST_Orders_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Orders_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
