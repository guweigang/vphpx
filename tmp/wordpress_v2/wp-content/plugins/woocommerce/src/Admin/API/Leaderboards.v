import rt

struct Class_Automattic_WooCommerce_Admin_API_Leaderboards {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc-analytics')
	rest_base rt.PhpVal = rt.new_string('leaderboards')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Leaderboards) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' +
		(this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Leaderboards', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Leaderboards', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Leaderboards', [
					'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/allowed'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Leaderboards', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_allowed_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Leaderboards', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Leaderboards', [
					'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_allowed_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/(?P<leaderboard>\\w+)'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'leaderboard', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'customers' },
						rt.ArrayItem{ key: none, val: 'coupons' },
						rt.ArrayItem{ key: none, val: 'categories' },
						rt.ArrayItem{ key: none, val: 'products' },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Leaderboards', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Leaderboards', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Leaderboards', [
					'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Leaderboards) get_coupons_leaderboard(var_per_page rt.PhpVal, var_after rt.PhpVal, var_before rt.PhpVal, var_persisted_query rt.PhpVal) rt.PhpVal {
	mut var_persisted_query_mutated := var_persisted_query
	mut var_coupons_data_store :=
		create_automattic_woocommerce_admin_api_reports_coupons_datastore()
	mut var_coupons_data := if rt.is_true(rt.greater(var_per_page, rt.new_int(0))) { rt.get_property(var_coupons_data_store.get_data(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_analytics_coupons_query_args'),
			rt.create_array([rt.ArrayItem{ key: 'orderby', val: 'orders_count' },
				rt.ArrayItem{ key: 'order', val: 'desc' }, rt.ArrayItem{
					key: 'after'
					val: var_after
				}, rt.ArrayItem{ key: 'before', val: var_before },
				rt.ArrayItem{ key: 'per_page', val: var_per_page },
				rt.ArrayItem{ key: 'extended_info', val: true }]),
		])), 'data') } else { rt.new_array() }
	mut var_rows := rt.new_array()
	mut iter_1 := var_coupons_data.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_coupon := item_1.val
		mut var_url_query := rt.call_function('wp_parse_args', [
			rt.create_array([rt.ArrayItem{ key: 'filter', val: 'single_coupon' },
				rt.ArrayItem{ key: 'coupons', val: var_coupon.array_get(rt.new_string('coupon_id')) }]),
			var_persisted_query_mutated.clone(),
		])
		mut var_coupon_url := rt.call_function('wc_admin_url', [
			rt.new_string('/analytics/coupons'),
			var_url_query.clone(),
		])
		mut var_coupon_code := if var_coupon.array_isset(rt.new_string('extended_info'))
			&& var_coupon.array_get(rt.new_string('extended_info')).array_isset(rt.new_string('code')) {
			var_coupon.array_get(rt.new_string('extended_info')).array_get(rt.new_string('code'))
		} else {
			rt.new_string('')
		}
		var_rows.array_push(rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'display'
					val: "<a href='${var_coupon_url.to_string()}'>${var_coupon_code.to_string()}</a>"
				},
				rt.ArrayItem{ key: 'value', val: var_coupon_code },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'display', val: rt.call_function('wc_admin_number_format', [
					var_coupon.array_get(rt.new_string('orders_count')),
				]) },
				rt.ArrayItem{ key: 'value', val: var_coupon.array_get(rt.new_string('orders_count')) },
				rt.ArrayItem{ key: 'format', val: 'number' },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'display', val: rt.call_function('wc_price', [
					var_coupon.array_get(rt.new_string('amount')),
				]) },
				rt.ArrayItem{ key: 'value', val: var_coupon.array_get(rt.new_string('amount')) },
				rt.ArrayItem{ key: 'format', val: 'currency' },
			]) },
		]))
	}
	return rt.create_array([rt.ArrayItem{ key: 'id', val: 'coupons' },
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Top Coupons - Number of Orders'),
			rt.new_string('woocommerce'),
		]) }, rt.ArrayItem{ key: 'headers', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Coupon code'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Orders'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Amount discounted'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]) }, rt.ArrayItem{ key: 'rows', val: var_rows }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Leaderboards) get_categories_leaderboard(var_per_page rt.PhpVal, var_after rt.PhpVal, var_before rt.PhpVal, var_persisted_query rt.PhpVal) rt.PhpVal {
	mut var_persisted_query_mutated := var_persisted_query
	mut var_categories_data_store :=
		create_automattic_woocommerce_admin_api_reports_categories_datastore()
	mut var_categories_data := if rt.is_true(rt.greater(var_per_page, rt.new_int(0))) { rt.get_property(var_categories_data_store.get_data(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_analytics_categories_query_args'),
			rt.create_array([rt.ArrayItem{ key: 'orderby', val: 'items_sold' },
				rt.ArrayItem{ key: 'order', val: 'desc' }, rt.ArrayItem{
					key: 'after'
					val: var_after
				}, rt.ArrayItem{ key: 'before', val: var_before },
				rt.ArrayItem{ key: 'per_page', val: var_per_page },
				rt.ArrayItem{ key: 'extended_info', val: true }]),
		])), 'data') } else { rt.new_array() }
	mut var_rows := rt.new_array()
	mut iter_2 := var_categories_data.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_category := item_2.val
		mut var_url_query := rt.call_function('wp_parse_args', [
			rt.create_array([rt.ArrayItem{ key: 'filter', val: 'single_category' },
				rt.ArrayItem{
					key: 'categories'
					val: var_category.array_get(rt.new_string('category_id'))
				}]),
			var_persisted_query_mutated.clone(),
		])
		mut var_category_url := rt.call_function('wc_admin_url', [
			rt.new_string('/analytics/categories'),
			var_url_query.clone(),
		])
		mut var_category_name := if var_category.array_isset(rt.new_string('extended_info'))
			&& var_category.array_get(rt.new_string('extended_info')).array_isset(rt.new_string('name')) {
			var_category.array_get(rt.new_string('extended_info')).array_get(rt.new_string('name'))
		} else {
			rt.new_string('')
		}
		var_rows.array_push(rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'display'
					val: "<a href='${var_category_url.to_string()}'>${var_category_name.to_string()}</a>"
				},
				rt.ArrayItem{ key: 'value', val: var_category_name },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'display', val: rt.call_function('wc_admin_number_format', [
					var_category.array_get(rt.new_string('items_sold')),
				]) },
				rt.ArrayItem{ key: 'value', val: var_category.array_get(rt.new_string('items_sold')) },
				rt.ArrayItem{ key: 'format', val: 'number' },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'display', val: rt.call_function('wc_price', [
					var_category.array_get(rt.new_string('net_revenue')),
				]) },
				rt.ArrayItem{
					key: 'value'
					val: var_category.array_get(rt.new_string('net_revenue'))
				},
				rt.ArrayItem{ key: 'format', val: 'currency' },
			]) },
		]))
	}
	return rt.create_array([rt.ArrayItem{ key: 'id', val: 'categories' },
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Top categories - Items sold'),
			rt.new_string('woocommerce'),
		]) }, rt.ArrayItem{ key: 'headers', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Category'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Items sold'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Net sales'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]) }, rt.ArrayItem{ key: 'rows', val: var_rows }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Leaderboards) get_customers_leaderboard(var_per_page rt.PhpVal, var_after rt.PhpVal, var_before rt.PhpVal, var_persisted_query rt.PhpVal) rt.PhpVal {
	mut var_persisted_query_mutated := var_persisted_query
	mut var_customers_data_store :=
		create_automattic_woocommerce_admin_api_reports_customers_datastore()
	mut var_customers_data := if rt.is_true(rt.greater(var_per_page, rt.new_int(0))) { rt.get_property(var_customers_data_store.get_data(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_analytics_customers_query_args'),
			rt.create_array([rt.ArrayItem{ key: 'orderby', val: 'total_spend' },
				rt.ArrayItem{ key: 'order', val: 'desc' }, rt.ArrayItem{
					key: 'order_after'
					val: var_after
				}, rt.ArrayItem{ key: 'order_before', val: var_before },
				rt.ArrayItem{ key: 'per_page', val: var_per_page }]),
		])), 'data') } else { rt.new_array() }
	mut var_rows := rt.new_array()
	mut iter_3 := var_customers_data.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_customer := item_3.val
		mut var_url_query := rt.call_function('wp_parse_args', [
			rt.create_array([rt.ArrayItem{ key: 'filter', val: 'single_customer' },
				rt.ArrayItem{ key: 'customers', val: var_customer.array_get(rt.new_string('id')) }]),
			var_persisted_query_mutated.clone(),
		])
		mut var_customer_url := rt.call_function('wc_admin_url', [
			rt.new_string('/analytics/customers'),
			var_url_query.clone(),
		])
		var_rows.array_push(rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'display', val: rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string("<a href='"),
					var_customer_url), rt.new_string("'>")),
					var_customer.array_get(rt.new_string('name'))), rt.new_string('</a>')) },
				rt.ArrayItem{ key: 'value', val: var_customer.array_get(rt.new_string('name')) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'display', val: rt.call_function('wc_admin_number_format', [
					var_customer.array_get(rt.new_string('orders_count')),
				]) },
				rt.ArrayItem{
					key: 'value'
					val: var_customer.array_get(rt.new_string('orders_count'))
				},
				rt.ArrayItem{ key: 'format', val: 'number' },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'display', val: rt.call_function('wc_price', [
					var_customer.array_get(rt.new_string('total_spend')),
				]) },
				rt.ArrayItem{
					key: 'value'
					val: var_customer.array_get(rt.new_string('total_spend'))
				},
				rt.ArrayItem{ key: 'format', val: 'currency' },
			]) },
		]))
	}
	return rt.create_array([rt.ArrayItem{ key: 'id', val: 'customers' },
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Top Customers - Total Spend'),
			rt.new_string('woocommerce'),
		]) }, rt.ArrayItem{ key: 'headers', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Customer Name'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Orders'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Total Spend'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]) }, rt.ArrayItem{ key: 'rows', val: var_rows }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Leaderboards) get_products_leaderboard(var_per_page rt.PhpVal, var_after rt.PhpVal, var_before rt.PhpVal, var_persisted_query rt.PhpVal) rt.PhpVal {
	mut var_persisted_query_mutated := var_persisted_query
	mut var_products_data_store :=
		create_automattic_woocommerce_admin_api_reports_products_datastore()
	mut var_products_data := if rt.is_true(rt.greater(var_per_page, rt.new_int(0))) { rt.get_property(var_products_data_store.get_data(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_analytics_products_query_args'),
			rt.create_array([rt.ArrayItem{ key: 'orderby', val: 'items_sold' },
				rt.ArrayItem{ key: 'order', val: 'desc' }, rt.ArrayItem{
					key: 'after'
					val: var_after
				}, rt.ArrayItem{ key: 'before', val: var_before },
				rt.ArrayItem{ key: 'per_page', val: var_per_page },
				rt.ArrayItem{ key: 'extended_info', val: true }]),
		])), 'data') } else { rt.new_array() }
	mut var_rows := rt.new_array()
	mut iter_4 := var_products_data.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_product := item_4.val
		mut var_url_query := rt.call_function('wp_parse_args', [
			rt.create_array([rt.ArrayItem{ key: 'filter', val: 'single_product' },
				rt.ArrayItem{
					key: 'products'
					val: var_product.array_get(rt.new_string('product_id'))
				}]),
			var_persisted_query_mutated.clone(),
		])
		mut var_product_url := rt.call_function('wc_admin_url', [
			rt.new_string('/analytics/products'),
			var_url_query.clone(),
		])
		mut var_product_name := if var_product.array_isset(rt.new_string('extended_info'))
			&& var_product.array_get(rt.new_string('extended_info')).array_isset(rt.new_string('name')) {
			var_product.array_get(rt.new_string('extended_info')).array_get(rt.new_string('name'))
		} else {
			rt.new_string('')
		}
		var_rows.array_push(rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'display'
					val: "<a href='${var_product_url.to_string()}'>${var_product_name.to_string()}</a>"
				},
				rt.ArrayItem{ key: 'value', val: var_product_name },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'display', val: rt.call_function('wc_admin_number_format', [
					var_product.array_get(rt.new_string('items_sold')),
				]) },
				rt.ArrayItem{ key: 'value', val: var_product.array_get(rt.new_string('items_sold')) },
				rt.ArrayItem{ key: 'format', val: 'number' },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'display', val: rt.call_function('wc_price', [
					var_product.array_get(rt.new_string('net_revenue')),
				]) },
				rt.ArrayItem{ key: 'value', val: var_product.array_get(rt.new_string('net_revenue')) },
				rt.ArrayItem{ key: 'format', val: 'currency' },
			]) },
		]))
	}
	return rt.create_array([rt.ArrayItem{ key: 'id', val: 'products' },
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Top products - Items sold'),
			rt.new_string('woocommerce'),
		]) }, rt.ArrayItem{ key: 'headers', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Product'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Items sold'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Net sales'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]) }, rt.ArrayItem{ key: 'rows', val: var_rows }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Leaderboards) get_leaderboards(var_per_page rt.PhpVal, var_after rt.PhpVal, var_before rt.PhpVal, var_persisted_query rt.PhpVal) rt.PhpVal {
	mut var_persisted_query_mutated := var_persisted_query
	mut var_leaderboards := rt.create_array([
		rt.ArrayItem{ key: none, val: this.get_customers_leaderboard(var_per_page.clone(),
			var_after.clone(), var_before.clone(), var_persisted_query_mutated.clone()) },
		rt.ArrayItem{ key: none, val: this.get_coupons_leaderboard(var_per_page.clone(),
			var_after.clone(), var_before.clone(), var_persisted_query_mutated.clone()) },
		rt.ArrayItem{ key: none, val: this.get_categories_leaderboard(var_per_page.clone(),
			var_after.clone(), var_before.clone(), var_persisted_query_mutated.clone()) },
		rt.ArrayItem{ key: none, val: this.get_products_leaderboard(var_per_page.clone(),
			var_after.clone(), var_before.clone(), var_persisted_query_mutated.clone()) },
	])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_leaderboards'),
		var_leaderboards.clone(), var_per_page.clone(), var_after.clone(),
		var_before.clone(), var_persisted_query_mutated.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Leaderboards) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_persisted_query := rt.call_function('json_decode', [
		var_request.array_get(rt.new_string('persisted_query')),
		rt.new_bool(true),
	])
	mut switch_val_1 := var_request.array_get(rt.new_string('leaderboard'))
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('customers'))) {
		mut var_leaderboards := rt.create_array([
			rt.ArrayItem{ key: none, val: this.get_customers_leaderboard(var_request.array_get(rt.new_string('per_page')),
				var_request.array_get(rt.new_string('after')),
				var_request.array_get(rt.new_string('before')), var_persisted_query.clone()) },
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('coupons'))) {
		var_leaderboards = rt.create_array([
			rt.ArrayItem{ key: none, val: this.get_coupons_leaderboard(var_request.array_get(rt.new_string('per_page')),
				var_request.array_get(rt.new_string('after')),
				var_request.array_get(rt.new_string('before')), var_persisted_query.clone()) },
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('categories'))) {
		var_leaderboards = rt.create_array([
			rt.ArrayItem{ key: none, val: this.get_categories_leaderboard(var_request.array_get(rt.new_string('per_page')),
				var_request.array_get(rt.new_string('after')),
				var_request.array_get(rt.new_string('before')), var_persisted_query.clone()) },
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('products'))) {
		var_leaderboards = rt.create_array([
			rt.ArrayItem{ key: none, val: this.get_products_leaderboard(var_request.array_get(rt.new_string('per_page')),
				var_request.array_get(rt.new_string('after')),
				var_request.array_get(rt.new_string('before')), var_persisted_query.clone()) },
		])
	} else {
		var_leaderboards = this.get_leaderboards(var_request.array_get(rt.new_string('per_page')),
			var_request.array_get(rt.new_string('after')),
			var_request.array_get(rt.new_string('before')), var_persisted_query.clone())
	}
	mut var_data := rt.new_array()
	if !(!rt.is_true(var_leaderboards)) {
		mut iter_5 := var_leaderboards.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_leaderboard := item_5.val
			mut var_response := this.prepare_item_for_response(var_leaderboard.clone(),
				var_request.clone())
			var_data.array_push(this.prepare_response_for_collection(var_response.clone()))
		}
	}
	return rt.call_function('rest_ensure_response', [var_data.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Leaderboards) get_allowed_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_leaderboards := this.get_leaderboards(rt.new_int(0), rt.new_null(), rt.new_null(),
		rt.new_null())
	mut var_data := rt.new_array()
	mut iter_6 := var_leaderboards.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_leaderboard := item_6.val
		var_data.array_push(rt.array_to_object(rt.create_array([
			rt.ArrayItem{ key: 'id', val: var_leaderboard.array_get(rt.new_string('id')) },
			rt.ArrayItem{ key: 'label', val: var_leaderboard.array_get(rt.new_string('label')) },
			rt.ArrayItem{ key: 'headers', val: var_leaderboard.array_get(rt.new_string('headers')) },
		])))
	}
	mut var_objects := rt.new_array()
	mut iter_7 := var_data.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_item := item_7.val
		mut var_prepared := this.prepare_item_for_response(var_item.clone(), var_request.clone())
		var_objects.array_push(this.prepare_response_for_collection(var_prepared.clone()))
	}
	mut var_response := rt.call_function('rest_ensure_response', [
		var_objects.clone()])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'),
		rt.new_int(var_data.clone().array_count())])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'),
		rt.new_int(1)])
	mut var_base := rt.call_function('add_query_arg', [
		rt.call_method(var_request, 'get_query_params', []rt.PhpVal{}),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('/%s/%s'), this.namespace, this.rest_base]),
		]),
	])
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Leaderboards) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_data := this.add_additional_fields_to_object(var_item.clone(), var_request.clone())
	var_data = this.filter_response_by_context(var_data.clone(), rt.new_string('view'))
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_prepare_leaderboard'),
		var_response.clone(),
		var_item.clone(),
		var_request.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Leaderboards) get_collection_params() rt.PhpVal {
	mut var_params := rt.new_array()
	var_params.array_set('page', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Current page of the collection.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'default', val: 1 },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		rt.ArrayItem{ key: 'minimum', val: 1 },
	]))
	var_params.array_set('per_page', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Maximum number of items to be returned in result set.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'default', val: 5 },
		rt.ArrayItem{ key: 'minimum', val: 1 },
		rt.ArrayItem{ key: 'maximum', val: 20 },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('after', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to resources published after a given ISO8601 compliant date.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'format', val: 'date-time' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('before', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to resources published before a given ISO8601 compliant date.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'format', val: 'date-time' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('persisted_query', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('URL query to persist across links.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	return var_params.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Leaderboards) get_item_schema() rt.PhpVal {
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'leaderboard' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Leaderboard ID.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'label', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Displayed title for the leaderboard.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'headers', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Table headers.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'properties', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.create_array([
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('Table column header.'),
								rt.new_string('woocommerce'),
							]) },
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'context', val: rt.create_array([
								rt.ArrayItem{ key: none, val: 'view' },
								rt.ArrayItem{ key: none, val: 'edit' },
							]) },
							rt.ArrayItem{ key: 'readonly', val: true },
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'rows', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Table rows.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'properties', val: rt.create_array([
						rt.ArrayItem{ key: 'display', val: rt.create_array([
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('Table cell display.'),
								rt.new_string('woocommerce'),
							]) },
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'context', val: rt.create_array([
								rt.ArrayItem{ key: none, val: 'view' },
								rt.ArrayItem{ key: none, val: 'edit' },
							]) },
							rt.ArrayItem{ key: 'readonly', val: true },
						]) },
						rt.ArrayItem{ key: 'value', val: rt.create_array([
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('Table cell value.'),
								rt.new_string('woocommerce'),
							]) },
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'context', val: rt.create_array([
								rt.ArrayItem{ key: none, val: 'view' },
								rt.ArrayItem{ key: none, val: 'edit' },
							]) },
							rt.ArrayItem{ key: 'readonly', val: true },
						]) },
						rt.ArrayItem{ key: 'format', val: rt.create_array([
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('Table cell format.'),
								rt.new_string('woocommerce'),
							]) },
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'context', val: rt.create_array([
								rt.ArrayItem{ key: none, val: 'view' },
							]) },
							rt.ArrayItem{ key: 'enum', val: rt.create_array([
								rt.ArrayItem{ key: none, val: 'currency' },
								rt.ArrayItem{ key: none, val: 'number' },
							]) },
							rt.ArrayItem{ key: 'readonly', val: true },
							rt.ArrayItem{ key: 'required', val: false },
						]) },
					]) },
				]) },
			]) },
		]) },
	])
	return this.add_additional_fields_schema(var_schema.clone())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Leaderboards) get_public_allowed_item_schema() rt.PhpVal {
	mut var_schema := this.get_public_item_schema()
	var_schema.array_get(rt.new_string('properties')).array_unset(rt.new_string('rows'))
	return var_schema.clone()
}

struct Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_leaderboards(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Leaderboards {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Leaderboards{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc-analytics')
		rest_base:     rt.new_string('leaderboards')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_rest_data_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller{
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

fn create_automattic_woocommerce_admin_api_reports_categories_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore{
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

fn create_automattic_woocommerce_admin_api_reports_products_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Leaderboards) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_coupons_leaderboard' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.get_coupons_leaderboard(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
		}
		'get_categories_leaderboard' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.get_categories_leaderboard(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
		}
		'get_customers_leaderboard' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.get_customers_leaderboard(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
		}
		'get_products_leaderboard' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.get_products_leaderboard(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
		}
		'get_leaderboards' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.get_leaderboards(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_allowed_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_allowed_items(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_public_allowed_item_schema' {
			return this.get_public_allowed_item_schema()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Leaderboards) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Leaderboards) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		'rest_base' {
			this.rest_base = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
