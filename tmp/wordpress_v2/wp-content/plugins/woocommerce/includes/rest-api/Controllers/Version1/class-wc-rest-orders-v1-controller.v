import rt

struct Class_WC_REST_Orders_V1_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v1')
		rest_base rt.PhpVal = rt.new_string('orders')
		post_type rt.PhpVal = rt.new_string('shop_order')
}

fn (mut this Class_WC_REST_Orders_V1_Controller) construct() {
	rt.call_function('add_filter', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_query')), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'query_args' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_WC_REST_Orders_V1_Controller) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str()), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str() + '/(?P<id>[\\d]+)'), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether to bypass trash and force deletion.'), rt.new_string('woocommerce')]) }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str() + '/batch'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_batch_schema' }]) }])])
}

fn (mut this Class_WC_REST_Orders_V1_Controller) prepare_item_for_response(var_post rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	mut var_order := rt.call_function('wc_get_order', [var_post_mutated.clone()])
	mut var_dp := if var_request.array_get(rt.new_string('dp')).is_null() { rt.call_function('wc_get_price_decimals', []rt.PhpVal{}) } else { rt.call_function('absint', [var_request.array_get(rt.new_string('dp'))]) }
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_order, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'parent_id', val: rt.call_method(var_order, 'get_parent_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'status', val: rt.call_method(var_order, 'get_status', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'order_key', val: rt.call_method(var_order, 'get_order_key', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'number', val: rt.call_method(var_order, 'get_order_number', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'currency', val: rt.call_method(var_order, 'get_currency', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'version', val: rt.call_method(var_order, 'get_version', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'prices_include_tax', val: rt.call_method(var_order, 'get_prices_include_tax', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_order, 'get_date_created', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'date_modified', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_order, 'get_date_modified', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'customer_id', val: rt.call_method(var_order, 'get_customer_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'discount_total', val: rt.call_function('wc_format_decimal', [rt.call_method(var_order, 'get_total_discount', []rt.PhpVal{}), var_dp.clone()]) }, rt.ArrayItem{ key: 'discount_tax', val: rt.call_function('wc_format_decimal', [rt.call_method(var_order, 'get_discount_tax', []rt.PhpVal{}), var_dp.clone()]) }, rt.ArrayItem{ key: 'shipping_total', val: rt.call_function('wc_format_decimal', [rt.call_method(var_order, 'get_shipping_total', []rt.PhpVal{}), var_dp.clone()]) }, rt.ArrayItem{ key: 'shipping_tax', val: rt.call_function('wc_format_decimal', [rt.call_method(var_order, 'get_shipping_tax', []rt.PhpVal{}), var_dp.clone()]) }, rt.ArrayItem{ key: 'cart_tax', val: rt.call_function('wc_format_decimal', [rt.call_method(var_order, 'get_cart_tax', []rt.PhpVal{}), var_dp.clone()]) }, rt.ArrayItem{ key: 'total', val: rt.call_function('wc_format_decimal', [rt.call_method(var_order, 'get_total', []rt.PhpVal{}), var_dp.clone()]) }, rt.ArrayItem{ key: 'total_tax', val: rt.call_function('wc_format_decimal', [rt.call_method(var_order, 'get_total_tax', []rt.PhpVal{}), var_dp.clone()]) }, rt.ArrayItem{ key: 'billing', val: rt.new_array() }, rt.ArrayItem{ key: 'shipping', val: rt.new_array() }, rt.ArrayItem{ key: 'payment_method', val: rt.call_method(var_order, 'get_payment_method', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'payment_method_title', val: rt.call_method(var_order, 'get_payment_method_title', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'transaction_id', val: rt.call_method(var_order, 'get_transaction_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'customer_ip_address', val: rt.call_method(var_order, 'get_customer_ip_address', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'customer_user_agent', val: rt.call_method(var_order, 'get_customer_user_agent', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'created_via', val: rt.call_method(var_order, 'get_created_via', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'customer_note', val: rt.call_method(var_order, 'get_customer_note', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'date_completed', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_order, 'get_date_completed', []rt.PhpVal{}), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_paid', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_order, 'get_date_paid', []rt.PhpVal{}), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'cart_hash', val: rt.call_method(var_order, 'get_cart_hash', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'line_items', val: rt.new_array() }, rt.ArrayItem{ key: 'tax_lines', val: rt.new_array() }, rt.ArrayItem{ key: 'shipping_lines', val: rt.new_array() }, rt.ArrayItem{ key: 'fee_lines', val: rt.new_array() }, rt.ArrayItem{ key: 'coupon_lines', val: rt.new_array() }, rt.ArrayItem{ key: 'refunds', val: rt.new_array() }])
	var_data.array_set('billing', rt.call_method(var_order, 'get_address', [rt.new_string('billing')]))
	var_data.array_set('shipping', rt.call_method(var_order, 'get_address', [rt.new_string('shipping')]))
	mut iter_1 := rt.call_method(var_order, 'get_items', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_item := item_1.val
		mut var_item_id := item_1.key
		mut var_product := rt.call_method(var_item, 'get_product', []rt.PhpVal{})
		mut var_product_id := rt.new_int(0)
		mut var_variation_id := rt.new_int(0)
		mut var_product_sku := rt.new_null()
		if rt.is_true(rt.new_bool(var_product.clone().is_object())) {
		var_product_id = rt.call_method(var_item, 'get_product_id', []rt.PhpVal{})
		var_variation_id = rt.call_method(var_item, 'get_variation_id', []rt.PhpVal{})
		var_product_sku = rt.call_method(var_product, 'get_sku', []rt.PhpVal{})
		}
		mut var_item_meta := rt.new_array()
		mut var_hideprefix := if rt.is_true(rt.identical(rt.new_string('true'), var_request.array_get(rt.new_string('all_item_meta')))) { rt.new_null() } else { rt.new_string('_') }
		mut iter_2 := rt.call_method(var_item, 'get_all_formatted_meta_data', [var_hideprefix.clone()]).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_formatted_meta := item_2.val
			mut var_meta_key := item_2.key
			var_item_meta << rt.create_array([rt.ArrayItem{ key: 'key', val: rt.get_property(var_formatted_meta, 'key') }, rt.ArrayItem{ key: 'label', val: rt.get_property(var_formatted_meta, 'display_key') }, rt.ArrayItem{ key: 'value', val: rt.call_function('wc_clean', [rt.get_property(var_formatted_meta, 'display_value')]) }])
		}
		mut var_line_item := { 'id': var_item_id, 'name': var_item.array_get(rt.new_string('name')), 'sku': var_product_sku, 'product_id': rt.new_int((var_product_id).to_i64()), 'variation_id': rt.new_int((var_variation_id).to_i64()), 'quantity': rt.call_function('wc_stock_amount', [var_item.array_get(rt.new_string('qty'))]), 'tax_class': if !(!rt.is_true(var_item.array_get(rt.new_string('tax_class')))) { var_item.array_get(rt.new_string('tax_class')) } else { rt.new_string('') }, 'price': rt.call_function('wc_format_decimal', [rt.call_method(var_order, 'get_item_total', [var_item.clone(), rt.new_bool(false), rt.new_bool(false)]), var_dp.clone()]), 'subtotal': rt.call_function('wc_format_decimal', [rt.call_method(var_order, 'get_line_subtotal', [var_item.clone(), rt.new_bool(false), rt.new_bool(false)]), var_dp.clone()]), 'subtotal_tax': rt.call_function('wc_format_decimal', [var_item.array_get(rt.new_string('line_subtotal_tax')), var_dp.clone()]), 'total': rt.call_function('wc_format_decimal', [rt.call_method(var_order, 'get_line_total', [var_item.clone(), rt.new_bool(false), rt.new_bool(false)]), var_dp.clone()]), 'total_tax': rt.call_function('wc_format_decimal', [var_item.array_get(rt.new_string('line_tax')), var_dp.clone()]), 'taxes': rt.new_array(), 'meta': var_item_meta }
		mut var_item_line_taxes := rt.call_function('maybe_unserialize', [var_item.array_get(rt.new_string('line_tax_data'))])
		if var_item_line_taxes.array_isset(rt.new_string('total')) {
			mut var_line_tax := rt.new_array()
			mut iter_3 := var_item_line_taxes.array_get(rt.new_string('total')).iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_tax := item_3.val
				mut var_tax_rate_id := item_3.key
				var_line_tax.array_set(var_tax_rate_id, rt.create_array([rt.ArrayItem{ key: 'id', val: var_tax_rate_id }, rt.ArrayItem{ key: 'total', val: var_tax }, rt.ArrayItem{ key: 'subtotal', val: '' }]))
			}
			mut iter_4 := var_item_line_taxes.array_get(rt.new_string('subtotal')).iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_tax := item_4.val
				mut var_tax_rate_id := item_4.key
				var_line_tax.array_get_mut(var_tax_rate_id).array_set('subtotal', var_tax.clone())
			}
			var_line_item['taxes'] = rt.call_function('array_values', [var_line_tax.clone()])
		}
		var_data.array_get_mut('line_items').array_push(var_line_item.clone())
	}
	mut iter_5 := rt.call_method(var_order, 'get_items', [rt.new_string('tax')]).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_tax := item_5.val
		mut var_key := item_5.key
		mut var_tax_line := { 'id': var_key, 'rate_code': var_tax.array_get(rt.new_string('name')), 'rate_id': var_tax.array_get(rt.new_string('rate_id')), 'label': if var_tax.array_isset(rt.new_string('label')) { var_tax.array_get(rt.new_string('label')) } else { var_tax.array_get(rt.new_string('name')) }, 'compound': (var_tax.array_get(rt.new_string('compound'))).to_bool(), 'tax_total': rt.call_function('wc_format_decimal', [var_tax.array_get(rt.new_string('tax_amount')), var_dp.clone()]), 'shipping_tax_total': rt.call_function('wc_format_decimal', [var_tax.array_get(rt.new_string('shipping_tax_amount')), var_dp.clone()]) }
		var_data.array_get_mut('tax_lines').array_push(var_tax_line.clone())
	}
	mut iter_6 := rt.call_method(var_order, 'get_shipping_methods', []rt.PhpVal{}).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_shipping_item := item_6.val
		mut var_shipping_item_id := item_6.key
		mut var_shipping_line := { 'id': var_shipping_item_id, 'method_title': var_shipping_item.array_get(rt.new_string('name')), 'method_id': var_shipping_item.array_get(rt.new_string('method_id')), 'total': rt.call_function('wc_format_decimal', [var_shipping_item.array_get(rt.new_string('cost')), var_dp.clone()]), 'total_tax': rt.call_function('wc_format_decimal', [rt.new_string(''), var_dp.clone()]), 'taxes': rt.new_array() }
		mut var_shipping_taxes := rt.call_method(var_shipping_item, 'get_taxes', []rt.PhpVal{})
		if !(!rt.is_true(var_shipping_taxes.array_get(rt.new_string('total')))) {
			mut iife_temp_0 := Class_NumberUtil{}
			mut iife_result_0 := iife_temp_0.array_sum(var_shipping_taxes.array_get(rt.new_string('total')))
			mut var_total_tax := iife_result_0
			var_shipping_line['total_tax'] = rt.call_function('wc_format_decimal', [var_total_tax.clone(), var_dp.clone()])
			mut iter_7 := var_shipping_taxes.array_get(rt.new_string('total')).iterator()
			for {
				item_7 := iter_7.next() or { break }
				mut var_tax := item_7.val
				mut var_tax_rate_id := item_7.key
				var_shipping_line.array_get_mut('taxes').array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: var_tax_rate_id }, rt.ArrayItem{ key: 'total', val: var_tax }]))
			}
		}
		var_data.array_get_mut('shipping_lines').array_push(var_shipping_line.clone())
	}
	mut iter_8 := rt.call_method(var_order, 'get_fees', []rt.PhpVal{}).iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_fee_item := item_8.val
		mut var_fee_item_id := item_8.key
		mut var_fee_line := { 'id': var_fee_item_id, 'name': var_fee_item.array_get(rt.new_string('name')), 'tax_class': if !(!rt.is_true(var_fee_item.array_get(rt.new_string('tax_class')))) { var_fee_item.array_get(rt.new_string('tax_class')) } else { rt.new_string('') }, 'tax_status': Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable(), 'total': rt.call_function('wc_format_decimal', [rt.call_method(var_order, 'get_line_total', [var_fee_item.clone()]), var_dp.clone()]), 'total_tax': rt.call_function('wc_format_decimal', [rt.call_method(var_order, 'get_line_tax', [var_fee_item.clone()]), var_dp.clone()]), 'taxes': rt.new_array() }
		mut var_fee_line_taxes := rt.call_function('maybe_unserialize', [var_fee_item.array_get(rt.new_string('line_tax_data'))])
		if var_fee_line_taxes.array_isset(rt.new_string('total')) {
			mut var_fee_tax := rt.new_array()
			mut iter_9 := var_fee_line_taxes.array_get(rt.new_string('total')).iterator()
			for {
				item_9 := iter_9.next() or { break }
				mut var_tax := item_9.val
				mut var_tax_rate_id := item_9.key
				var_fee_tax.array_set(var_tax_rate_id, rt.create_array([rt.ArrayItem{ key: 'id', val: var_tax_rate_id }, rt.ArrayItem{ key: 'total', val: var_tax }, rt.ArrayItem{ key: 'subtotal', val: '' }]))
			}
			if var_fee_line_taxes.array_isset(rt.new_string('subtotal')) {
				mut iter_10 := var_fee_line_taxes.array_get(rt.new_string('subtotal')).iterator()
				for {
					item_10 := iter_10.next() or { break }
					mut var_tax := item_10.val
					mut var_tax_rate_id := item_10.key
					var_fee_tax.array_get_mut(var_tax_rate_id).array_set('subtotal', var_tax.clone())
				}
			}
			var_fee_line['taxes'] = rt.call_function('array_values', [var_fee_tax.clone()])
		}
		var_data.array_get_mut('fee_lines').array_push(var_fee_line.clone())
	}
	mut iter_11 := rt.call_method(var_order, 'get_items', [rt.new_string('coupon')]).iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_coupon_item := item_11.val
		mut var_coupon_item_id := item_11.key
		mut var_coupon_line := { 'id': var_coupon_item_id, 'code': rt.call_method(var_coupon_item, 'get_name', []rt.PhpVal{}), 'discount': rt.call_function('wc_format_decimal', [rt.call_method(var_coupon_item, 'get_discount', []rt.PhpVal{}), var_dp.clone()]), 'discount_tax': rt.call_function('wc_format_decimal', [rt.call_method(var_coupon_item, 'get_discount_tax', []rt.PhpVal{}), var_dp.clone()]) }
		var_data.array_get_mut('coupon_lines').array_push(var_coupon_line.clone())
	}
	mut iter_12 := rt.call_method(var_order, 'get_refunds', []rt.PhpVal{}).iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_refund := item_12.val
		var_data.array_get_mut('refunds').array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_refund, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'refund', val: if rt.is_true(rt.call_method(var_refund, 'get_reason', []rt.PhpVal{})) { rt.call_method(var_refund, 'get_reason', []rt.PhpVal{}) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'total', val: '-' + (rt.call_function('wc_format_decimal', [rt.call_method(var_refund, 'get_amount', []rt.PhpVal{}), var_dp.clone()])).str() }]))
	}
	mut var_context := if !(!rt.is_true(var_request.array_get(rt.new_string('context')))) { var_request.array_get(rt.new_string('context')) } else { rt.new_string('view') }
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.clone()])
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_order.clone(), var_request.clone())])
	return rt.call_function('apply_filters', [rt.concat(rt.new_string('woocommerce_rest_prepare_'), this.post_type), var_response.clone(), var_post_mutated.clone(), var_request.clone()])
}

fn (mut this Class_WC_REST_Orders_V1_Controller) prepare_links(var_order rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_links := { 'self': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace, this.rest_base, rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})])]) }, 'collection': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s'), this.namespace, this.rest_base])]) } }
	if rt.is_true(rt.new_bool(0 != rt.new_int((rt.call_method(var_order_mutated, 'get_user_id', []rt.PhpVal{})).to_i64()))) {
		var_links['customer'] = rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/customers/%d'), this.namespace, rt.call_method(var_order_mutated, 'get_user_id', []rt.PhpVal{})])]) }])
	}
	if rt.is_true(rt.new_bool(0 != rt.new_int((rt.call_method(var_order_mutated, 'get_parent_id', []rt.PhpVal{})).to_i64()))) {
		var_links['up'] = rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/orders/%d'), this.namespace, rt.call_method(var_order_mutated, 'get_parent_id', []rt.PhpVal{})])]) }])
	}
	return var_links.clone()
}

fn (mut this Class_WC_REST_Orders_V1_Controller) query_args(var_args rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('any'), var_request.array_get(rt.new_string('status')))))) {
		var_args_mutated.array_set('post_status', 'wc-' + (var_request.array_get(rt.new_string('status'))).str())
	} else {
		var_args_mutated.array_set('post_status', 'any')
	}
	if var_request.array_isset(rt.new_string('customer')) {
		if !(!rt.is_true(var_args_mutated.array_get(rt.new_string('meta_query')))) {
			var_args_mutated.array_set('meta_query', rt.new_array())
		}
		var_args_mutated.array_get_mut('meta_query').array_push(rt.create_array([rt.ArrayItem{ key: 'key', val: '_customer_user' }, rt.ArrayItem{ key: 'value', val: var_request.array_get(rt.new_string('customer')) }, rt.ArrayItem{ key: 'type', val: 'NUMERIC' }]))
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('product')))) {
		mut var_order_ids := rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\tSELECT order_id\n\t\t\t\tFROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_items\n\t\t\t\tWHERE order_item_id IN ( SELECT order_item_id FROM ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_itemmeta WHERE meta_key = \'_product_id\' AND meta_value = %d )\n\t\t\t\tAND order_item_type = \'line_item\'\n\t\t\t ')), var_request.array_get(rt.new_string('product'))])])
		var_order_ids = if !(!rt.is_true(var_order_ids)) { var_order_ids } else { rt.create_array([rt.ArrayItem{ key: none, val: 0 }]) }
		var_args_mutated.array_set('post__in', var_order_ids.clone())
	}
	if !(!rt.is_true(var_args_mutated.array_get(rt.new_string('s')))) {
		var_order_ids = rt.call_function('wc_order_search', [var_args_mutated.array_get(rt.new_string('s'))])
		if !(!rt.is_true(var_order_ids)) {
			var_args_mutated.array_unset(rt.new_string('s'))
			var_args_mutated.array_set('post__in', rt.call_function('array_merge', [var_order_ids.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 0 }])]))
		}
	}
	return var_args_mutated.clone()
}

fn (mut this Class_WC_REST_Orders_V1_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
	mut var_id := if var_request.array_isset(rt.new_string('id')) { rt.call_function('absint', [var_request.array_get(rt.new_string('id'))]) } else { rt.new_int(0) }
	mut var_order := create_wc_order(var_id.clone())
	mut var_schema := this.get_item_schema()
	mut var_data_keys := rt.func_array_keys(rt.call_function('array_filter', [var_schema.array_get(rt.new_string('properties')), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'filter_writable_props' }])]))
	if !(var_request.array_get(rt.new_string('customer_id')).is_null()) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_request.array_get(rt.new_string('customer_id')))))) {
		mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
		mut iife_result_1 := iife_temp_1.get_user_in_current_site(var_request.array_get(rt.new_string('customer_id')))
		mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
		mut iife_result_2 := iife_temp_2.get_user_in_current_site(var_request.array_get(rt.new_string('customer_id')))
		if rt.is_true(rt.call_function('is_wp_error', [iife_result_1])) {
			rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_customer_id'), rt.call_function('__', [rt.new_string('Customer ID is invalid.'), rt.new_string('woocommerce')]), rt.new_int(400))))
		}
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_member_of_blog', [var_request.array_get(rt.new_string('customer_id'))]))))) {
			rt.call_function('add_user_to_blog', [rt.call_function('get_current_blog_id', []rt.PhpVal{}), var_request.array_get(rt.new_string('customer_id')), rt.new_string('customer')])
		}
	}
	mut iter_13 := var_data_keys.iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_key := item_13.val
		mut var_value := var_request.array_get(var_key)
		if !(var_value.clone().is_null()) {
			mut switch_val_1 := var_key
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('billing'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('shipping'))) {
				this.update_address(var_order.clone(), var_value.clone(), (var_key).str())
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('line_items'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('shipping_lines'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('fee_lines'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('coupon_lines'))) {
				if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
					mut iter_14 := var_value.iterator()
					for {
						item_14 := iter_14.next() or { break }
						mut var_item := item_14.val
						if rt.is_true(rt.new_bool(var_item.clone().is_array())) {
							if this.item_is_null(var_item.clone()) || (var_item.array_isset(rt.new_string('quantity')) && rt.is_true(rt.identical(rt.new_int(0), var_item.array_get(rt.new_string('quantity'))))) {
								rt.call_method(var_order, 'remove_item', [var_item.array_get(rt.new_string('id'))])
							} else {
								this.set_item(var_order.clone(), var_key.clone(), var_item.clone())
							}
						}
					}
				}
			} else {
				if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_order }, rt.ArrayItem{ key: none, val: "set_${var_key.to_string()}" }])])) {
					rt.call_method(var_order, "set_${var_key.to_string()}", [var_value.clone()])
				}
			}
		}
	}
	return rt.call_function('apply_filters', [rt.concat(rt.new_string('woocommerce_rest_pre_insert_'), this.post_type), var_order.clone(), var_request.clone()])
}

fn (mut this Class_WC_REST_Orders_V1_Controller) create_base_order(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	return rt.call_function('wc_create_order', [var_data_mutated.clone()])
}

fn (mut this Class_WC_REST_Orders_V1_Controller) filter_writable_props(var_schema rt.PhpVal) rt.PhpVal {
	mut var_schema_mutated := var_schema
	return rt.new_bool(!rt.is_true(var_schema_mutated.array_get(rt.new_string('readonly'))))
}

fn (mut this Class_WC_REST_Orders_V1_Controller) create_order(var_request rt.PhpVal) rt.PhpVal {
	mut var_order := this.prepare_item_for_database(var_request.clone())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_order, 'set_created_via', [rt.new_string('rest-api')])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_order, 'set_prices_include_tax', [rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_prices_include_tax')]))])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_order, 'calculate_totals', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_order, 'save', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.identical(rt.new_bool(true), var_request.array_get(rt.new_string('set_paid')))) {
		rt.call_method(var_order, 'payment_complete', [var_request.array_get(rt.new_string('transaction_id'))])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return rt.call_method(var_order, 'get_id', []rt.PhpVal{})
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'WC_Data_Exception') {
		mut var_e := var_e_1.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.call_method(var_e, 'getErrorData', []rt.PhpVal{})))
		unsafe { goto end_label_1 }
	}
	else if rt.instance_of(var_e_1, 'WC_REST_Exception') {
		var_e = var_e_1.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) }])))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.new_null()
}

fn (mut this Class_WC_REST_Orders_V1_Controller) update_order(var_request rt.PhpVal) rt.PhpVal {
	mut var_order := this.prepare_item_for_database(var_request.clone())
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	rt.call_method(var_order, 'save', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.call_method(var_order, 'needs_payment', []rt.PhpVal{})) && rt.is_true(rt.identical(rt.new_bool(true), var_request.array_get(rt.new_string('set_paid')))) {
		rt.call_method(var_order, 'payment_complete', [var_request.array_get(rt.new_string('transaction_id'))])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if var_request.array_isset(rt.new_string('billing')) || var_request.array_isset(rt.new_string('shipping')) || var_request.array_isset(rt.new_string('line_items')) || var_request.array_isset(rt.new_string('shipping_lines')) || var_request.array_isset(rt.new_string('fee_lines')) || var_request.array_isset(rt.new_string('coupon_lines')) {
		rt.call_method(var_order, 'calculate_totals', [rt.new_bool(true)])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	return rt.call_method(var_order, 'get_id', []rt.PhpVal{})
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'WC_Data_Exception') {
		mut var_e := var_e_2.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.call_method(var_e, 'getErrorData', []rt.PhpVal{})))
		unsafe { goto end_label_2 }
	}
	else if rt.instance_of(var_e_2, 'WC_REST_Exception') {
		var_e = var_e_2.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) }])))
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return rt.new_null()
}

fn (mut this Class_WC_REST_Orders_V1_Controller) update_address(var_order rt.PhpVal, var_posted rt.PhpVal, type string) {
	mut var_order_mutated := var_order
	mut iter_15 := var_posted.iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_value := item_15.val
		mut var_key := item_15.key
		if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_order_mutated }, rt.ArrayItem{ key: none, val: "set_${var_type}_${var_key.to_string()}" }])])) {
			rt.call_method(var_order_mutated, "set_${var_type}_${var_key.to_string()}", [var_value.clone()])
		}
	}
}

fn (mut this Class_WC_REST_Orders_V1_Controller) get_product_id(var_posted rt.PhpVal, action string) rt.PhpVal {
	mut action_mutated := action
	if !(!rt.is_true(var_posted.array_get(rt.new_string('sku')))) {
	mut var_product_id := rt.new_int((rt.call_function('wc_get_product_id_by_sku', [var_posted.array_get(rt.new_string('sku'))])).to_i64())
	} else if !(!rt.is_true(var_posted.array_get(rt.new_string('product_id')))) && !rt.is_true(var_posted.array_get(rt.new_string('variation_id'))) {
	var_product_id = rt.new_int((var_posted.array_get(rt.new_string('product_id'))).to_i64())
	} else if !(!rt.is_true(var_posted.array_get(rt.new_string('variation_id')))) {
	var_product_id = rt.new_int((var_posted.array_get(rt.new_string('variation_id'))).to_i64())
	} else if rt.is_true(rt.identical(rt.new_string('update'), rt.new_string(action_mutated))) {
	var_product_id = rt.new_int(0)
	} else {
		rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_required_product_reference'), rt.call_function('__', [rt.new_string('Product ID or SKU is required.'), rt.new_string('woocommerce')]), rt.new_int(400))))
	}
	return var_product_id.clone()
}

fn (mut this Class_WC_REST_Orders_V1_Controller) maybe_set_item_prop(var_item rt.PhpVal, var_prop rt.PhpVal, var_posted rt.PhpVal) {
	mut var_item_mutated := var_item
	if var_posted.array_isset(var_prop) {
		rt.call_method(var_item_mutated, "set_${var_prop.to_string()}", [var_posted.array_get(var_prop)])
	}
}

fn (mut this Class_WC_REST_Orders_V1_Controller) maybe_set_item_props(var_item rt.PhpVal, var_props rt.PhpVal, var_posted rt.PhpVal) {
	mut var_item_mutated := var_item
	mut iter_16 := var_props.iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_prop := item_16.val
		this.maybe_set_item_prop(var_item_mutated.clone(), var_prop.clone(), var_posted.clone())
	}
}

fn (mut this Class_WC_REST_Orders_V1_Controller) prepare_line_items(var_posted rt.PhpVal, action string) rt.PhpVal {
	mut action_mutated := action
	mut var_item := create_wc_order_item_product(if !(!rt.is_true(var_posted.array_get(rt.new_string('id')))) { var_posted.array_get(rt.new_string('id')) } else { rt.new_string('') })
	mut var_product := rt.call_function('wc_get_product', [this.get_product_id(var_posted.clone(), action_mutated)])
	if rt.is_true(var_product) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_product, rt.call_method(var_item, 'get_product', []rt.PhpVal{}))))) {
		rt.call_method(var_item, 'set_product', [var_product.clone()])
		if rt.is_true(rt.identical(rt.new_string('create'), rt.new_string(action_mutated))) {
			mut var_quantity := if var_posted.array_isset(rt.new_string('quantity')) { var_posted.array_get(rt.new_string('quantity')) } else { rt.new_int(1) }
			mut var_total := rt.call_function('wc_get_price_excluding_tax', [var_product.clone(), rt.create_array([rt.ArrayItem{ key: 'qty', val: var_quantity }])])
			rt.call_method(var_item, 'set_total', [var_total.clone()])
			rt.call_method(var_item, 'set_subtotal', [var_total.clone()])
		}
	}
	this.maybe_set_item_props(var_item.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'quantity' }, rt.ArrayItem{ key: none, val: 'total' }, rt.ArrayItem{ key: none, val: 'subtotal' }, rt.ArrayItem{ key: none, val: 'tax_class' }]), var_posted.clone())
	return var_item.clone()
}

fn (mut this Class_WC_REST_Orders_V1_Controller) prepare_shipping_lines(var_posted rt.PhpVal, var_action rt.PhpVal) rt.PhpVal {
	mut var_action_mutated := var_action
	mut var_item := create_wc_order_item_shipping(if !(!rt.is_true(var_posted.array_get(rt.new_string('id')))) { var_posted.array_get(rt.new_string('id')) } else { rt.new_string('') })
	if rt.is_true(rt.identical(rt.new_string('create'), var_action_mutated)) {
		if !rt.is_true(var_posted.array_get(rt.new_string('method_id'))) {
			rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_shipping_item'), rt.call_function('__', [rt.new_string('Shipping method ID is required.'), rt.new_string('woocommerce')]), rt.new_int(400))))
		}
	}
	this.maybe_set_item_props(var_item.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'method_id' }, rt.ArrayItem{ key: none, val: 'method_title' }, rt.ArrayItem{ key: none, val: 'total' }]), var_posted.clone())
	return var_item.clone()
}

fn (mut this Class_WC_REST_Orders_V1_Controller) prepare_fee_lines(var_posted rt.PhpVal, var_action rt.PhpVal) rt.PhpVal {
	mut var_action_mutated := var_action
	mut var_item := create_wc_order_item_fee(if !(!rt.is_true(var_posted.array_get(rt.new_string('id')))) { var_posted.array_get(rt.new_string('id')) } else { rt.new_string('') })
	if rt.is_true(rt.identical(rt.new_string('create'), var_action_mutated)) {
		if !rt.is_true(var_posted.array_get(rt.new_string('name'))) {
			rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_fee_item'), rt.call_function('__', [rt.new_string('Fee name is required.'), rt.new_string('woocommerce')]), rt.new_int(400))))
		}
	}
	this.maybe_set_item_props(var_item.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'tax_class' }, rt.ArrayItem{ key: none, val: 'tax_status' }, rt.ArrayItem{ key: none, val: 'total' }]), var_posted.clone())
	return var_item.clone()
}

fn (mut this Class_WC_REST_Orders_V1_Controller) prepare_coupon_lines(var_posted rt.PhpVal, var_action rt.PhpVal) rt.PhpVal {
	mut var_action_mutated := var_action
	mut var_item := create_wc_order_item_coupon(if !(!rt.is_true(var_posted.array_get(rt.new_string('id')))) { var_posted.array_get(rt.new_string('id')) } else { rt.new_string('') })
	if rt.is_true(rt.identical(rt.new_string('create'), var_action_mutated)) {
		mut iife_temp_3 := Class_ArrayUtil{}
		mut iife_result_3 := iife_temp_3.get_value_or_default(var_posted.clone(), rt.new_string('code'))
		mut var_coupon_code := iife_result_3
		mut iife_temp_4 := Class_StringUtil{}
		mut iife_result_4 := iife_temp_4.is_null_or_whitespace(var_coupon_code.clone())
		if rt.is_true(iife_result_4) {
			rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_coupon_coupon'), rt.call_function('__', [rt.new_string('Coupon code is required.'), rt.new_string('woocommerce')]), rt.new_int(400))))
		}
	}
	this.maybe_set_item_props(var_item.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'code' }, rt.ArrayItem{ key: none, val: 'discount' }]), var_posted.clone())
	return var_item.clone()
}

fn (mut this Class_WC_REST_Orders_V1_Controller) set_item(var_order rt.PhpVal, var_item_type rt.PhpVal, var_posted rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_order_mutated := var_order
	if !(!rt.is_true(var_posted.array_get(rt.new_string('id')))) {
	mut var_action := rt.new_string('update')
	} else {
	var_action = rt.new_string('create')
	}
	mut var_method := rt.new_string('prepare_' + (var_item_type).str())
	if rt.is_true(rt.identical(rt.new_string('update'), var_action)) {
		mut var_result := rt.call_method(var_wpdb, 'get_row', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_items WHERE order_item_id = %d AND order_id = %d')), rt.call_function('absint', [var_posted.array_get(rt.new_string('id'))]), rt.call_function('absint', [rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})])])])
		if rt.is_true(rt.new_bool(var_result.clone().is_null())) {
			rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_item_id'), rt.call_function('__', [rt.new_string('Order item ID provided is not associated with order.'), rt.new_string('woocommerce')]), rt.new_int(400))))
		}
	}
	mut var_item := rt.call_method(rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this), var_method, [var_posted.clone(), var_action.clone()])
	rt.call_function('do_action', [rt.new_string('woocommerce_rest_set_order_item'), var_item.clone(), var_posted.clone()])
	if rt.is_true(rt.identical(rt.new_string('create'), var_action)) {
		rt.call_method(var_order_mutated, 'add_item', [var_item.clone()])
	} else {
		rt.call_method(var_item, 'save', []rt.PhpVal{})
	}
}

fn (mut this Class_WC_REST_Orders_V1_Controller) item_is_null(var_item rt.PhpVal) bool {
	mut var_item_mutated := var_item
	mut var_keys := ['product_id', 'method_id', 'method_title', 'name', 'code']
	for var_key in var_keys {
		if rt.is_true(rt.new_bool(var_item_mutated.clone().array_isset(rt.new_string(key)))) && var_item_mutated.array_get(rt.new_string(key)).is_null() {
			return true
		}
	}
	return false
}

fn (mut this Class_WC_REST_Orders_V1_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_request.array_get(rt.new_string('id')))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_exists')), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Cannot create existing %s.'), rt.new_string('woocommerce')]), this.post_type]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	mut var_order_id := this.create_order(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_order_id.clone()])) {
		return var_order_id.clone()
	}
	mut var_post := rt.call_function('get_post', [var_order_id.clone()])
	this.update_additional_fields_for_object(var_post.clone(), var_request.clone())
	rt.call_function('do_action', [rt.concat(rt.new_string('woocommerce_rest_insert_'), this.post_type), var_post.clone(), var_request.clone(), rt.new_bool(true)])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_post.clone(), var_request.clone())
	var_response = rt.call_function('rest_ensure_response', [var_response.clone()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'), rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace, this.rest_base, rt.get_property(var_post, 'ID')])])])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Orders_V1_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_post_id := rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64())
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	if !rt.is_true(var_post_id) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_post_type', [var_post_id.clone()]), this.post_type)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_invalid_id')), rt.call_function('__', [rt.new_string('ID is invalid.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	mut var_order_id := this.update_order(var_request.clone())
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	if rt.is_true(rt.call_function('is_wp_error', [var_order_id.clone()])) {
		return var_order_id.clone()
	}
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	mut var_post := rt.call_function('get_post', [var_order_id.clone()])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	this.update_additional_fields_for_object(var_post.clone(), var_request.clone())
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	rt.call_function('do_action', [rt.concat(rt.new_string('woocommerce_rest_insert_'), this.post_type), var_post.clone(), var_request.clone(), rt.new_bool(false)])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	mut var_response := this.prepare_item_for_response(var_post.clone(), var_request.clone())
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	return rt.call_function('rest_ensure_response', [var_response.clone()])
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Exception') {
		mut var_e := var_e_3.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) }])))
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	return rt.new_null()
}

fn (mut this Class_WC_REST_Orders_V1_Controller) get_order_statuses() rt.PhpVal {
	mut var_order_statuses := rt.new_array()
	mut iter_17 := rt.func_array_keys(rt.call_function('wc_get_order_statuses', []rt.PhpVal{})).iterator()
	for {
		item_17 := iter_17.next() or { break }
		mut var_status := item_17.val
		var_order_statuses << rt.call_function('str_replace', [rt.new_string('wc-'), rt.new_string(''), var_status.clone()])
	}
	return var_order_statuses.clone()
}

fn (mut this Class_WC_REST_Orders_V1_Controller) get_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_object := rt.call_function('wc_get_order', [rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64())])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_object)))) || rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_object, 'get_id', []rt.PhpVal{}))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('read')]))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot view this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }])))
	}
	return this.Class_WC_REST_Posts_Controller.get_item_permissions_check(var_request.clone())
}

fn (mut this Class_WC_REST_Orders_V1_Controller) update_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_object := rt.call_function('wc_get_order', [rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64())])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_object)))) || rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_object, 'get_id', []rt.PhpVal{}))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('read')]))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_cannot_edit'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }])))
	}
	return this.Class_WC_REST_Posts_Controller.update_item_permissions_check(var_request.clone())
}

fn (mut this Class_WC_REST_Orders_V1_Controller) delete_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_object := rt.call_function('wc_get_order', [rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64())])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_object)))) || rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_object, 'get_id', []rt.PhpVal{}))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('read')]))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_cannot_delete'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }])))
	}
	return this.Class_WC_REST_Posts_Controller.delete_item_permissions_check(var_request.clone())
}

fn (mut this Class_WC_REST_Orders_V1_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := rt.create_array([rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' }, rt.ArrayItem{ key: 'title', val: this.post_type }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'parent_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Parent order ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'status', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Order status.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: Class_Automattic_WooCommerce_Enums_OrderStatus.pending() }, rt.ArrayItem{ key: 'enum', val: this.get_order_statuses() }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'order_key', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Order key.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'number', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Order number.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'currency', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Currency the order was created with, in ISO format.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: rt.call_function('get_woocommerce_currency', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'enum', val: rt.func_array_keys(rt.call_function('get_woocommerce_currencies', []rt.PhpVal{})) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'version', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Version of WooCommerce which last updated the order.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'prices_include_tax', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('True the prices included tax during checkout.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'date_created', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the order was created, as GMT.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'date_modified', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the order was last modified, as GMT.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'customer_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('User ID who owns the order. 0 for guests.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'default', val: 0 }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'discount_total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Total discount amount for the order.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'discount_tax', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Total discount tax amount for the order.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'shipping_total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Total shipping amount for the order.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'shipping_tax', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Total shipping tax amount for the order.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'cart_tax', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Sum of line item taxes only.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Grand total.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'total_tax', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Sum of all taxes.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'billing', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Billing address.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'first_name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('First name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'last_name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Last name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'company', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Company name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'address_1', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Address line 1.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'address_2', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Address line 2.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'city', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('City name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'state', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('ISO code or name of the state, province or district.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'postcode', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Postal code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'country', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Country code in ISO 3166-1 alpha-2 format.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'email', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Email address.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'email' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'phone', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Phone number.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }]) }]) }, rt.ArrayItem{ key: 'shipping', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shipping address.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'first_name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('First name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'last_name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Last name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'company', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Company name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'address_1', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Address line 1.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'address_2', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Address line 2.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'city', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('City name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'state', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('ISO code or name of the state, province or district.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'postcode', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Postal code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'country', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Country code in ISO 3166-1 alpha-2 format.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }]) }]) }, rt.ArrayItem{ key: 'payment_method', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Payment method ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'payment_method_title', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Payment method title.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'arg_options', val: rt.create_array([rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }]) }]) }, rt.ArrayItem{ key: 'set_paid', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Define if the order is paid. It will set the status to processing and reduce stock items.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'transaction_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique transaction ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'customer_ip_address', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Customer\'s IP address.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'customer_user_agent', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('User agent of the customer.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'created_via', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shows where the order was created.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'customer_note', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Note left by customer during checkout.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'date_completed', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the order was completed, in the site\'s timezone.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'date_paid', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the order was paid, in the site\'s timezone.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'cart_hash', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('MD5 hash of cart items to ensure orders are not modified.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'line_items', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Line items data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Item ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'mixed' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'sku', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product SKU.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'product_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'mixed' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'variation_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Variation ID, if applicable.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'quantity', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Quantity ordered.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'tax_class', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax class of product.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'price', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product price.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'subtotal', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Line subtotal (before discounts).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'subtotal_tax', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Line subtotal tax (before discounts).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Line total (after discounts).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'total_tax', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Line total tax (after discounts).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'taxes', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Line taxes.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax rate ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax total.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'subtotal', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax subtotal.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]) }]) }, rt.ArrayItem{ key: 'meta', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Line item meta data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'key', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta key.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'label', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta label.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'value', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta value.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'mixed' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]) }]) }]) }]) }]) }, rt.ArrayItem{ key: 'tax_lines', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax lines data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Item ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'rate_code', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax rate code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'rate_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax rate ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'label', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax rate label.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'compound', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Show if is a compound tax rate.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'tax_total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax total (not including shipping taxes).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'shipping_tax_total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shipping tax total.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]) }]) }, rt.ArrayItem{ key: 'shipping_lines', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shipping lines data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Item ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'method_title', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shipping method name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'mixed' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'method_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shipping method ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'mixed' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Line total (after discounts).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'total_tax', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Line total tax (after discounts).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'taxes', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Line taxes.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax rate ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax total.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]) }]) }]) }]) }]) }, rt.ArrayItem{ key: 'fee_lines', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Fee lines data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Item ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Fee name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'mixed' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'tax_class', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax class of fee.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'tax_status', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax status of fee.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.none() }]) }]) }, rt.ArrayItem{ key: 'total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Line total (after discounts).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'total_tax', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Line total tax (after discounts).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'taxes', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Line taxes.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax rate ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax total.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'subtotal', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax subtotal.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]) }]) }]) }]) }]) }, rt.ArrayItem{ key: 'coupon_lines', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Coupons line data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Item ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'code', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Coupon code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'mixed' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'discount', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Discount total.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'discount_tax', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Discount total tax.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]) }]) }, rt.ArrayItem{ key: 'refunds', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of refunds.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Refund ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'reason', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Refund reason.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Refund total.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]) }]) }]) }])
	return this.add_additional_fields_schema(var_schema.clone())
}

fn (mut this Class_WC_REST_Orders_V1_Controller) get_collection_params() rt.PhpVal {
	mut var_params := this.Class_WC_REST_Posts_Controller.get_collection_params()
	var_params.array_set('status', rt.create_array([rt.ArrayItem{ key: 'default', val: 'any' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to orders assigned a specific status.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: 'any' }]), this.get_order_statuses()]) }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('customer', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to orders assigned a specific customer.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('product', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to orders assigned a specific product.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('dp', rt.create_array([rt.ArrayItem{ key: 'default', val: rt.call_function('wc_get_price_decimals', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Number of decimal points to use in each resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	return var_params.clone()
}

struct Class_WC_REST_Posts_Controller {
	rt.PhpObjectBase
}

struct Class_NumberUtil {
	rt.PhpObjectBase
}

struct Class_WC_Order {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Utilities_Users {
	rt.PhpObjectBase
}

struct Class_WC_REST_Exception {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WC_Order_Item_Product {
	rt.PhpObjectBase
}

struct Class_WC_Order_Item_Shipping {
	rt.PhpObjectBase
}

struct Class_WC_Order_Item_Fee {
	rt.PhpObjectBase
}

struct Class_WC_Order_Item_Coupon {
	rt.PhpObjectBase
}

struct Class_ArrayUtil {
	rt.PhpObjectBase
}

struct Class_StringUtil {
	rt.PhpObjectBase
}

fn create_wc_rest_orders_v1_controller() &Class_WC_REST_Orders_V1_Controller {
	mut obj := &Class_WC_REST_Orders_V1_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v1')
		rest_base: rt.new_string('orders')
		post_type: rt.new_string('shop_order')
	}
	obj.construct()
	return obj
}

fn create_wc_rest_posts_controller(_args ...rt.PhpVal) &Class_WC_REST_Posts_Controller {
	mut obj := &Class_WC_REST_Posts_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_numberutil(_args ...rt.PhpVal) &Class_NumberUtil {
	mut obj := &Class_NumberUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order(_args ...rt.PhpVal) &Class_WC_Order {
	mut obj := &Class_WC_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_users(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Utilities_Users {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_Users{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_rest_exception(_args ...rt.PhpVal) &Class_WC_REST_Exception {
	mut obj := &Class_WC_REST_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_product(_args ...rt.PhpVal) &Class_WC_Order_Item_Product {
	mut obj := &Class_WC_Order_Item_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_shipping(_args ...rt.PhpVal) &Class_WC_Order_Item_Shipping {
	mut obj := &Class_WC_Order_Item_Shipping{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_fee(_args ...rt.PhpVal) &Class_WC_Order_Item_Fee {
	mut obj := &Class_WC_Order_Item_Fee{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_coupon(_args ...rt.PhpVal) &Class_WC_Order_Item_Coupon {
	mut obj := &Class_WC_Order_Item_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_arrayutil(_args ...rt.PhpVal) &Class_ArrayUtil {
	mut obj := &Class_ArrayUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_stringutil(_args ...rt.PhpVal) &Class_StringUtil {
	mut obj := &Class_StringUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Orders_V1_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0, dispatch_arg_1)
		}
		'query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.query_args(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_item_for_database' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_item_for_database(dispatch_arg_0)
		}
		'create_base_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_base_order(dispatch_arg_0)
		}
		'filter_writable_props' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_writable_props(dispatch_arg_0)
		}
		'create_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_order(dispatch_arg_0)
		}
		'update_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_order(dispatch_arg_0)
		}
		'update_address' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.update_address(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_product_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_product_id(dispatch_arg_0, dispatch_arg_1)
		}
		'maybe_set_item_prop' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.maybe_set_item_prop(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'maybe_set_item_props' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.maybe_set_item_props(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'prepare_line_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.prepare_line_items(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_shipping_lines' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_shipping_lines(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_fee_lines' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_fee_lines(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_coupon_lines' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_coupon_lines(dispatch_arg_0, dispatch_arg_1)
		}
		'set_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.set_item(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'item_is_null' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.item_is_null(dispatch_arg_0))
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'get_order_statuses' {
			return this.get_order_statuses()
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_permissions_check(dispatch_arg_0)
		}
		'update_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item_permissions_check(dispatch_arg_0)
		}
		'delete_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item_permissions_check(dispatch_arg_0)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Orders_V1_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		'post_type' { return this.post_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Orders_V1_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		'post_type' { this.post_type = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_Posts_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Posts_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Posts_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_NumberUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_NumberUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_NumberUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_REST_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Order_Item_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Item_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Order_Item_Shipping) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Item_Shipping) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item_Shipping) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Order_Item_Fee) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Item_Fee) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item_Fee) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Order_Item_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Item_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ArrayUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ArrayUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ArrayUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_StringUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_StringUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_StringUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

	// unsupported statement: Stmt_GroupUse
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		exit(0)
	}
}
