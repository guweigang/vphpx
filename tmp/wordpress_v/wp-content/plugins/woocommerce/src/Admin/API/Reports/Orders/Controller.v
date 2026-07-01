import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Controller {
	rt.PhpObjectBase
pub mut:
		rest_base rt.PhpVal = rt.new_string('reports/orders')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Controller) get_datastore_data(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query := create_automattic_woocommerce_admin_api_reports_orders_query(var_query_args.dup())
	return var_query.get_data()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Controller) prepare_reports_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_args := rt.new_array()
	var_args.array_set('before', var_request.array_get('before'))
	var_args.array_set('after', var_request.array_get('after'))
	var_args.array_set('page', var_request.array_get('page'))
	var_args.array_set('per_page', var_request.array_get('per_page'))
	var_args.array_set('orderby', var_request.array_get('orderby'))
	var_args.array_set('order', var_request.array_get('order'))
	var_args.array_set('product_includes', rt.cast_array(var_request.array_get('product_includes')))
	var_args.array_set('product_excludes', rt.cast_array(var_request.array_get('product_excludes')))
	var_args.array_set('variation_includes', rt.cast_array(var_request.array_get('variation_includes')))
	var_args.array_set('variation_excludes', rt.cast_array(var_request.array_get('variation_excludes')))
	var_args.array_set('coupon_includes', rt.cast_array(var_request.array_get('coupon_includes')))
	var_args.array_set('coupon_excludes', rt.cast_array(var_request.array_get('coupon_excludes')))
	var_args.array_set('tax_rate_includes', rt.cast_array(var_request.array_get('tax_rate_includes')))
	var_args.array_set('tax_rate_excludes', rt.cast_array(var_request.array_get('tax_rate_excludes')))
	var_args.array_set('status_is', rt.cast_array(var_request.array_get('status_is')))
	var_args.array_set('status_is_not', rt.cast_array(var_request.array_get('status_is_not')))
	var_args.array_set('customer_type', var_request.array_get('customer_type'))
	var_args.array_set('extended_info', var_request.array_get('extended_info'))
	var_args.array_set('refunds', var_request.array_get('refunds'))
	var_args.array_set('match', var_request.array_get('match'))
	var_args.array_set('order_includes', var_request.array_get('order_includes'))
	var_args.array_set('order_excludes', var_request.array_get('order_excludes'))
	var_args.array_set('attribute_is', rt.cast_array(var_request.array_get('attribute_is')))
	var_args.array_set('attribute_is_not', rt.cast_array(var_request.array_get('attribute_is_not')))
	var_args.array_set('force_cache_refresh', var_request.array_get('force_cache_refresh'))
	return var_args.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Controller) prepare_item_for_response(var_report rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_report_mutated := var_report
	var_report_mutated.array_set('order_number', this.get_order_number(var_report_mutated.array_get('order_id')))
	var_report_mutated.array_set('total_formatted', this.get_total_formatted(var_report_mutated.array_get('order_id')))
	mut var_response := this.Class_Automattic_WooCommerce_Admin_API_Reports_GenericController.prepare_item_for_response(var_report_mutated.dup(), var_request.dup())
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_report_mutated.dup())])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_prepare_report_orders'), var_response.dup(), var_report_mutated.dup(), var_request.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Controller) prepare_links(var_object rt.PhpVal) rt.PhpVal {
	mut var_links := rt.create_array([rt.ArrayItem{ key: 'order', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/orders/%d'), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Controller', ['Automattic_WooCommerce_Admin_API_Reports_GenericController', 'ExportableInterface'], &this), 'namespace'), var_object.array_get('order_id')])]) }]) }])
	return var_links.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := rt.create_array([rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' }, rt.ArrayItem{ key: 'title', val: 'report_orders' }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'order_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Order ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'order_number', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Order Number.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'date_created', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Date the order was created, in the site\'s timezone.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'date_created_gmt', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Date the order was created, as GMT.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'status', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Order status.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'customer_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Customer ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'num_items_sold', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Number of items sold.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'net_total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Net total revenue.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'float' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'total_formatted', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Net total revenue (formatted).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'customer_type', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Returning or new customer.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'extended_info', val: rt.create_array([rt.ArrayItem{ key: 'products', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of order product IDs, names, quantities.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'coupons', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of order coupons.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'customer', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Order customer information.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'attribution', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Order attribution information.'), rt.new_string('woocommerce')]) }]) }]) }]) }])
	return this.add_additional_fields_schema(var_schema.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Controller) get_collection_params() rt.PhpVal {
	mut var_params := this.Class_Automattic_WooCommerce_Admin_API_Reports_GenericController.get_collection_params()
	var_params.array_get_mut('per_page').array_set('minimum', 0)
	var_params.array_get_mut('orderby').array_set('enum', this.apply_custom_orderby_filters(rt.create_array([rt.ArrayItem{ key: none, val: 'date' }, rt.ArrayItem{ key: none, val: 'num_items_sold' }, rt.ArrayItem{ key: none, val: 'net_total' }])))
	var_params.array_set('product_includes', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to items that have the specified product(s) assigned.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('product_excludes', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to items that don\'t have the specified product(s) assigned.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }]))
	var_params.array_set('variation_includes', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to items that have the specified variation(s) assigned.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('variation_excludes', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to items that don\'t have the specified variation(s) assigned.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }]))
	var_params.array_set('coupon_includes', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to items that have the specified coupon(s) assigned.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('coupon_excludes', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to items that don\'t have the specified coupon(s) assigned.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }]))
	var_params.array_set('tax_rate_includes', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to items that have the specified tax rate(s) assigned.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('tax_rate_excludes', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to items that don\'t have the specified tax rate(s) assigned.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }]))
	var_params.array_set('status_is', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to items that have the specified order status.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_slug_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'enum', val: fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Controller{}; return temp.get_order_statuses() }() }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]))
	var_params.array_set('status_is_not', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to items that don\'t have the specified order status.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_slug_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'enum', val: fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Controller{}; return temp.get_order_statuses() }() }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]))
	var_params.array_set('customer_type', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to returning or new customers.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: '' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: '' }, rt.ArrayItem{ key: none, val: 'returning' }, rt.ArrayItem{ key: none, val: 'new' }]) }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('refunds', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to specific types of refunds.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: '' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: '' }, rt.ArrayItem{ key: none, val: 'all' }, rt.ArrayItem{ key: none, val: 'partial' }, rt.ArrayItem{ key: none, val: 'full' }, rt.ArrayItem{ key: none, val: 'none' }]) }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('extended_info', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Add additional piece of info about each coupon to the report.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wc_string_to_bool' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('order_includes', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to items that have the specified order ids.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }]))
	var_params.array_set('order_excludes', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to items that don\'t have the specified order ids.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }]))
	var_params.array_set('attribute_is', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to orders that include products with the specified attributes.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('attribute_is_not', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to orders that don\'t include products with the specified attributes.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	return var_params.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Controller) get_customer_name(var_customer rt.PhpVal) string {
	return (var_customer.array_get('first_name')).str() + ' ' + (var_customer.array_get('last_name')).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Controller) get_products(var_products rt.PhpVal) rt.PhpVal {
	mut var_products_list := rt.new_array()
	{
		mut iter_1 := var_products.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_product := item_1.val
			var_products_list.array_push(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s× %2$s'), rt.new_string('woocommerce')]), var_product.array_get('quantity'), var_product.array_get('name')]))
		}
	}
	return rt.call_function('implode', [rt.new_string(', '), var_products_list.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Controller) get_coupons(var_coupons rt.PhpVal) rt.PhpVal {
	return rt.call_function('implode', [rt.new_string(', '), rt.call_function('wp_list_pluck', [var_coupons.dup(), rt.new_string('code')])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Controller) get_export_columns() rt.PhpVal {
	mut var_export_columns := rt.create_array([rt.ArrayItem{ key: 'date_created', val: rt.call_function('__', [rt.new_string('Date'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'order_number', val: rt.call_function('__', [rt.new_string('Order #'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'total_formatted', val: rt.call_function('__', [rt.new_string('N. Revenue (formatted)'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'status', val: rt.call_function('__', [rt.new_string('Status'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'customer_name', val: rt.call_function('__', [rt.new_string('Customer'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'customer_type', val: rt.call_function('__', [rt.new_string('Customer type'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'products', val: rt.call_function('__', [rt.new_string('Product(s)'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'num_items_sold', val: rt.call_function('__', [rt.new_string('Items sold'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'coupons', val: rt.call_function('__', [rt.new_string('Coupon(s)'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'net_total', val: rt.call_function('__', [rt.new_string('Net Sales'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'attribution', val: rt.call_function('__', [rt.new_string('Attribution'), rt.new_string('woocommerce')]) }])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_report_orders_export_columns'), var_export_columns.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Controller) prepare_item_for_export(var_item rt.PhpVal) rt.PhpVal {
	mut var_export_item := rt.create_array([rt.ArrayItem{ key: 'date_created', val: var_item.array_get('date') }, rt.ArrayItem{ key: 'order_number', val: var_item.array_get('order_number') }, rt.ArrayItem{ key: 'total_formatted', val: var_item.array_get('total_formatted') }, rt.ArrayItem{ key: 'status', val: var_item.array_get('status') }, rt.ArrayItem{ key: 'customer_name', val: if var_item.array_get('extended_info').array_isset(rt.new_string('customer')) { this.get_customer_name(var_item.array_get('extended_info').array_get('customer')) } else { rt.new_null() } }, rt.ArrayItem{ key: 'customer_type', val: var_item.array_get('customer_type') }, rt.ArrayItem{ key: 'products', val: if var_item.array_get('extended_info').array_isset(rt.new_string('products')) { this.get_products(var_item.array_get('extended_info').array_get('products')) } else { rt.new_null() } }, rt.ArrayItem{ key: 'num_items_sold', val: var_item.array_get('num_items_sold') }, rt.ArrayItem{ key: 'coupons', val: if var_item.array_get('extended_info').array_isset(rt.new_string('coupons')) { this.get_coupons(var_item.array_get('extended_info').array_get('coupons')) } else { rt.new_null() } }, rt.ArrayItem{ key: 'net_total', val: var_item.array_get('net_total') }, rt.ArrayItem{ key: 'attribution', val: var_item.array_get('extended_info').array_get('attribution').array_get('origin') }])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_report_orders_prepare_export_item'), var_export_item.dup(), var_item.dup()])
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_GenericController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Query {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_orders_controller() &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		rest_base: rt.new_string('reports/orders')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_genericcontroller() &Class_Automattic_WooCommerce_Admin_API_Reports_GenericController {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_GenericController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_orders_query() &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Query {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_datastore_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_datastore_data(dispatch_arg_0)
		}
		'prepare_reports_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_reports_query(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'get_customer_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_customer_name(dispatch_arg_0))
		}
		'get_products' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_products(dispatch_arg_0)
		}
		'get_coupons' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_coupons(dispatch_arg_0)
		}
		'get_export_columns' {
			return this.get_export_columns()
		}
		'prepare_item_for_export' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_item_for_export(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_base' { this.rest_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_GenericController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_reports_orders_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
