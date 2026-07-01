import rt

struct Class_WC_REST_Orders_V1_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v1')
		rest_base rt.PhpVal = rt.new_string('orders')
		post_type rt.PhpVal = rt.new_string('shop_order')
}

fn (mut this Class_WC_REST_Orders_V1_Controller) construct()  {
	rt.call_function('add_filter', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_query')), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'query_args' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_WC_REST_Orders_V1_Controller) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/(?P<id>[\\d]+)', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether to bypass trash and force deletion.'), rt.new_string('woocommerce')]) }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/batch', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_batch_schema' }]) }])])
}

fn (mut this Class_WC_REST_Orders_V1_Controller) prepare_item_for_response(var_post rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	mut var_order := rt.call_function('wc_get_order', [var_post_mutated.dup()])
	mut var_dp := if rt.is_true(rt.new_bool(var_request.array_get('dp').is_null())) { rt.call_function('wc_get_price_decimals', []rt.PhpVal{}) } else { rt.call_function('absint', [var_request.array_get('dp')]) }
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_order, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'parent_id', val: rt.call_method(var_order, 'get_parent_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'status', val: rt.call_method(var_order, 'get_status', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'order_key', val: rt.call_method(var_order, 'get_order_key', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'number', val: rt.call_method(var_order, 'get_order_number', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'currency', val: rt.call_method(var_order, 'get_currency', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'version', val: rt.call_method(var_order, 'get_version', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'prices_include_tax', val: rt.call_method(var_order, 'get_prices_include_tax', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_order, 'get_date_created', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'date_modified', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_order, 'get_date_modified', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'customer_id', val: rt.call_method(var_order, 'get_customer_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'discount_total', val: rt.call_function('wc_format_decimal', [rt.call_method(var_order, 'get_total_discount', []rt.PhpVal{}), var_dp.dup()]) }, rt.ArrayItem{ key: 'discount_tax', val: rt.call_function('wc_format_decimal', [rt.call_method(var_order, 'get_discount_tax', []rt.PhpVal{}), var_dp.dup()]) }, rt.ArrayItem{ key: 'shipping_total', val: rt.call_function('wc_format_decimal', [rt.call_method(var_order, 'get_shipping_total', []rt.PhpVal{}), var_dp.dup()]) }, rt.ArrayItem{ key: 'shipping_tax', val: rt.call_function('wc_format_decimal', [rt.call_method(var_order, 'get_shipping_tax', []rt.PhpVal{}), var_dp.dup()]) }, rt.ArrayItem{ key: 'cart_tax', val: rt.call_function('wc_format_decimal', [rt.call_method(var_order, 'get_cart_tax', []rt.PhpVal{}), var_dp.dup()]) }, rt.ArrayItem{ key: 'total', val: rt.call_function('wc_format_decimal', [rt.call_method(var_order, 'get_total', []rt.PhpVal{}), var_dp.dup()]) }, rt.ArrayItem{ key: 'total_tax', val: rt.call_function('wc_format_decimal', [rt.call_method(var_order, 'get_total_tax', []rt.PhpVal{}), var_dp.dup()]) }, rt.ArrayItem{ key: 'billing', val: rt.new_array() }, rt.ArrayItem{ key: 'shipping', val: rt.new_array() }, rt.ArrayItem{ key: 'payment_method', val: rt.call_method(var_order, 'get_payment_method', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'payment_method_title', val: rt.call_method(var_order, 'get_payment_method_title', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'transaction_id', val: rt.call_method(var_order, 'get_transaction_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'customer_ip_address', val: rt.call_method(var_order, 'get_customer_ip_address', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'customer_user_agent', val: rt.call_method(var_order, 'get_customer_user_agent', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'created_via', val: rt.call_method(var_order, 'get_created_via', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'customer_note', val: rt.call_method(var_order, 'get_customer_note', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'date_completed', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_order, 'get_date_completed', []rt.PhpVal{}), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_paid', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_order, 'get_date_paid', []rt.PhpVal{}), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'cart_hash', val: rt.call_method(var_order, 'get_cart_hash', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'line_items', val: rt.new_array() }, rt.ArrayItem{ key: 'tax_lines', val: rt.new_array() }, rt.ArrayItem{ key: 'shipping_lines', val: rt.new_array() }, rt.ArrayItem{ key: 'fee_lines', val: rt.new_array() }, rt.ArrayItem{ key: 'coupon_lines', val: rt.new_array() }, rt.ArrayItem{ key: 'refunds', val: rt.new_array() }])
	var_data.array_set('billing', rt.call_method(var_order, 'get_address', [rt.new_string('billing')]))
	var_data.array_set('shipping', rt.call_method(var_order, 'get_address', [rt.new_string('shipping')]))
	{
		mut iter_1 := rt.call_method(var_order, 'get_items', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_item_id := item_1.key
			mut var_product := rt.call_method(var_item, 'get_product', []rt.PhpVal{})
			mut var_product_id := rt.new_int(rt.new_int(0))
			mut var_variation_id := rt.new_int(rt.new_int(0))
			mut var_product_sku := rt.new_null()
			if rt.is_true(rt.new_bool(var_product.dup().is_object())) {
				var_product_id = rt.call_method(var_item, 'get_product_id', []rt.PhpVal{})
				var_variation_id = rt.call_method(var_item, 'get_variation_id', []rt.PhpVal{})
				var_product_sku = rt.call_method(var_product, 'get_sku', []rt.PhpVal{})
			}
			mut var_item_meta := rt.new_array()
			mut var_hideprefix := if rt.is_true(rt.identical(rt.new_string('true'), var_request.array_get('all_item_meta'))) { rt.new_null() } else { rt.new_string('_') }
			{
				mut iter_2 := rt.call_method(var_item, 'get_all_formatted_meta_data', [var_hideprefix.dup()]).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_formatted_meta := item_2.val
					mut var_meta_key := item_2.key
					var_item_meta << rt.create_array([rt.ArrayItem{ key: 'key', val: rt.get_property(var_formatted_meta, 'key') }, rt.ArrayItem{ key: 'label', val: rt.get_property(var_formatted_meta, 'display_key') }, rt.ArrayItem{ key: 'value', val: rt.call_function('wc_clean', [rt.get_property(var_formatted_meta, 'display_value')]) }])
				}
			}
			mut var_line_item := { 'id': var_item_id, 'name': var_item.array_get('name'), 'sku': var_product_sku, 'product_id': // unsupported expression: Expr_Cast_Int, 'variation_id': // unsupported expression: Expr_Cast_Int, 'quantity': rt.call_function('wc_stock_amount', [var_item.array_get('qty')]), 'tax_class': if !(!rt.is_true(var_item.array_get('tax_class'))) { var_item.array_get('tax_class') } else { rt.new_string('') }, 'price': rt.call_function('wc_format_decimal', [rt.call_method(var_order, 'get_item_total', [var_item.dup(), rt.new_bool(false), rt.new_bool(false)]), var_dp.dup()]), 'subtotal': rt.call_function('wc_format_decimal', [rt.call_method(var_order, 'get_line_subtotal', [var_item.dup(), rt.new_bool(false), rt.new_bool(false)]), var_dp.dup()]), 'subtotal_tax': rt.call_function('wc_format_decimal', [var_item.array_get('line_subtotal_tax'), var_dp.dup()]), 'total': rt.call_function('wc_format_decimal', [rt.call_method(var_order, 'get_line_total', [var_item.dup(), rt.new_bool(false), rt.new_bool(false)]), var_dp.dup()]), 'total_tax': rt.call_function('wc_format_decimal', [var_item.array_get('line_tax'), var_dp.dup()]), 'taxes': rt.new_array(), 'meta': var_item_meta }
			mut var_item_line_taxes := rt.call_function('maybe_unserialize', [var_item.array_get('line_tax_data')])
			if var_item_line_taxes.array_isset(rt.new_string('total')) {
				mut var_line_tax := rt.new_array()
				{
					mut iter_2 := var_item_line_taxes.array_get('total').iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_tax := item_2.val
						mut var_tax_rate_id := item_2.key
						var_line_tax.array_set(var_tax_rate_id, rt.create_array([rt.ArrayItem{ key: 'id', val: var_tax_rate_id }, rt.ArrayItem{ key: 'total', val: var_tax }, rt.ArrayItem{ key: 'subtotal', val: '' }]))
					}
				}
				{
					mut iter_2 := var_item_line_taxes.array_get('subtotal').iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_tax := item_2.val
						mut var_tax_rate_id := item_2.key
						var_line_tax.array_get_mut(var_tax_rate_id).array_set('subtotal', var_tax.dup())
					}
				}
				var_line_item['taxes'] = rt.call_function('array_values', [var_line_tax.dup()])
			}
			var_data.array_get_mut('line_items').array_push(var_line_item.dup())
		}
	}
	{
		mut iter_1 := rt.call_method(var_order, 'get_items', [rt.new_string('tax')]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tax := item_1.val
			mut var_key := item_1.key
			mut var_tax_line := { 'id': var_key, 'rate_code': var_tax.array_get('name'), 'rate_id': var_tax.array_get('rate_id'), 'label': if var_tax.array_isset(rt.new_string('label')) { var_tax.array_get('label') } else { var_tax.array_get('name') }, 'compound': // unsupported expression: Expr_Cast_Bool, 'tax_total': rt.call_function('wc_format_decimal', [var_tax.array_get('tax_amount'), var_dp.dup()]), 'shipping_tax_total': rt.call_function('wc_format_decimal', [var_tax.array_get('shipping_tax_amount'), var_dp.dup()]) }
			var_data.array_get_mut('tax_lines').array_push(var_tax_line.dup())
		}
	}
	{
		mut iter_1 := rt.call_method(var_order, 'get_shipping_methods', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_shipping_item := item_1.val
			mut var_shipping_item_id := item_1.key
			mut var_shipping_line := { 'id': var_shipping_item_id, 'method_title': var_shipping_item.array_get('name'), 'method_id': var_shipping_item.array_get('method_id'), 'total': rt.call_function('wc_format_decimal', [var_shipping_item.array_get('cost'), var_dp.dup()]), 'total_tax': rt.call_function('wc_format_decimal', [rt.new_string(''), var_dp.dup()]), 'taxes': rt.new_array() }
			mut var_shipping_taxes := rt.call_method(var_shipping_item, 'get_taxes', []rt.PhpVal{})
			if !(!rt.is_true(var_shipping_taxes.array_get('total'))) {
				mut var_total_tax := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_NumberUtil{}; return temp.array_sum(arg_0) }(var_shipping_taxes.array_get('total'))
				var_shipping_line['total_tax'] = rt.call_function('wc_format_decimal', [var_total_tax.dup(), var_dp.dup()])
				{
					mut iter_2 := var_shipping_taxes.array_get('total').iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_tax := item_2.val
						mut var_tax_rate_id := item_2.key
						var_shipping_line.array_get_mut('taxes').array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: var_tax_rate_id }, rt.ArrayItem{ key: 'total', val: var_tax }]))
					}
				}
			}
			var_data.array_get_mut('shipping_lines').array_push(var_shipping_line.dup())
		}
	}
	{
		mut iter_1 := rt.call_method(var_order, 'get_fees', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_fee_item := item_1.val
			mut var_fee_item_id := item_1.key
			mut var_fee_line := { 'id': var_fee_item_id, 'name': var_fee_item.array_get('name'), 'tax_class': if !(!rt.is_true(var_fee_item.array_get('tax_class'))) { var_fee_item.array_get('tax_class') } else { rt.new_string('') }, 'tax_status': Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable(), 'total': rt.call_function('wc_format_decimal', [rt.call_method(var_order, 'get_line_total', [var_fee_item.dup()]), var_dp.dup()]), 'total_tax': rt.call_function('wc_format_decimal', [rt.call_method(var_order, 'get_line_tax', [var_fee_item.dup()]), var_dp.dup()]), 'taxes': rt.new_array() }
			mut var_fee_line_taxes := rt.call_function('maybe_unserialize', [var_fee_item.array_get('line_tax_data')])
			if var_fee_line_taxes.array_isset(rt.new_string('total')) {
				mut var_fee_tax := rt.new_array()
				{
					mut iter_2 := var_fee_line_taxes.array_get('total').iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_tax := item_2.val
						mut var_tax_rate_id := item_2.key
						var_fee_tax.array_set(var_tax_rate_id, rt.create_array([rt.ArrayItem{ key: 'id', val: var_tax_rate_id }, rt.ArrayItem{ key: 'total', val: var_tax }, rt.ArrayItem{ key: 'subtotal', val: '' }]))
					}
				}
				if var_fee_line_taxes.array_isset(rt.new_string('subtotal')) {
					{
						mut iter_2 := var_fee_line_taxes.array_get('subtotal').iterator()
						for {
							item_2 := iter_2.next() or { break }
							mut var_tax := item_2.val
							mut var_tax_rate_id := item_2.key
							var_fee_tax.array_get_mut(var_tax_rate_id).array_set('subtotal', var_tax.dup())
						}
					}
				}
				var_fee_line['taxes'] = rt.call_function('array_values', [var_fee_tax.dup()])
			}
			var_data.array_get_mut('fee_lines').array_push(var_fee_line.dup())
		}
	}
	{
		mut iter_1 := rt.call_method(var_order, 'get_items', [rt.new_string('coupon')]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_coupon_item := item_1.val
			mut var_coupon_item_id := item_1.key
			mut var_coupon_line := { 'id': var_coupon_item_id, 'code': rt.call_method(var_coupon_item, 'get_name', []rt.PhpVal{}), 'discount': rt.call_function('wc_format_decimal', [rt.call_method(var_coupon_item, 'get_discount', []rt.PhpVal{}), var_dp.dup()]), 'discount_tax': rt.call_function('wc_format_decimal', [rt.call_method(var_coupon_item, 'get_discount_tax', []rt.PhpVal{}), var_dp.dup()]) }
			var_data.array_get_mut('coupon_lines').array_push(var_coupon_line.dup())
		}
	}
	{
		mut iter_1 := rt.call_method(var_order, 'get_refunds', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_refund := item_1.val
			var_data.array_get_mut('refunds').array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_refund, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'refund', val: if rt.is_true(rt.call_method(var_refund, 'get_reason', []rt.PhpVal{})) { rt.call_method(var_refund, 'get_reason', []rt.PhpVal{}) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'total', val: '-' + (rt.call_function('wc_format_decimal', [rt.call_method(var_refund, 'get_amount', []rt.PhpVal{}), var_dp.dup()])).str() }]))
		}
	}
	mut var_context := if !(!rt.is_true(var_request.array_get('context'))) { var_request.array_get('context') } else { rt.new_string('view') }
	var_data = this.add_additional_fields_to_object(var_data.dup(), var_request.dup())
	var_data = this.filter_response_by_context(var_data.dup(), var_context.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_order.dup(), var_request.dup())])
	return rt.call_function('apply_filters', [rt.concat(rt.new_string('woocommerce_rest_prepare_'), this.post_type), var_response.dup(), var_post_mutated.dup(), var_request.dup()])
}

fn (mut this Class_WC_REST_Orders_V1_Controller) prepare_links(var_order rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_links := { 'self': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace, this.rest_base, rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})])]) }, 'collection': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s'), this.namespace, this.rest_base])]) } }
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_links['customer'] = rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/customers/%d'), this.namespace, rt.call_method(var_order_mutated, 'get_user_id', []rt.PhpVal{})])]) }])
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_links['up'] = rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/orders/%d'), this.namespace, rt.call_method(var_order_mutated, 'get_parent_id', []rt.PhpVal{})])]) }])
	}
	return var_links.dup()
}

fn (mut this Class_WC_REST_Orders_V1_Controller) query_args(var_args rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	// unsupported statement: Stmt_Global
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_args_mutated.array_set('post_status', 'wc-' + (var_request.array_get('status')).str())
	} else {
		var_args_mutated.array_set('post_status', 'any')
	}
	if var_request.array_isset(rt.new_string('customer')) {
		if !(!rt.is_true(var_args_mutated.array_get('meta_query'))) {
			var_args_mutated.array_set('meta_query', rt.new_array())
		}
		var_args_mutated.array_get_mut('meta_query').array_push(rt.create_array([rt.ArrayItem{ key: 'key', val: '_customer_user' }, rt.ArrayItem{ key: 'value', val: var_request.array_get('customer') }, rt.ArrayItem{ key: 'type', val: 'NUMERIC' }]))
	}
	if !(!rt.is_true(var_request.array_get('product'))) {
		mut var_order_ids := rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\tSELECT order_id\n\t\t\t\tFROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_items\n\t\t\t\tWHERE order_item_id IN ( SELECT order_item_id FROM ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_itemmeta WHERE meta_key = \'_product_id\' AND meta_value = %d )\n\t\t\t\tAND order_item_type = \'line_item\'\n\t\t\t ')), var_request.array_get('product')])])
		var_order_ids = if !(!rt.is_true(var_order_ids)) { var_order_ids } else { rt.create_array([rt.ArrayItem{ key: none, val: 0 }]) }
		var_args_mutated.array_set('post__in', var_order_ids.dup())
	}
	if !(!rt.is_true(var_args_mutated.array_get('s'))) {
		var_order_ids = rt.call_function('wc_order_search', [var_args_mutated.array_get('s')])
		if !(!rt.is_true(var_order_ids)) {
			var_args_mutated.array_unset(rt.new_string('s'))
			var_args_mutated.array_set('post__in', rt.call_function('array_merge', [var_order_ids.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 0 }])]))
		}
	}
	return var_args_mutated.dup()
}

fn (mut this Class_WC_REST_Orders_V1_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
	mut var_id := if var_request.array_isset(rt.new_string('id')) { rt.call_function('absint', [var_request.array_get('id')]) } else { rt.new_int(0) }
	mut var_order := create_wc_order(var_id.dup())
	mut var_schema := this.get_item_schema()
	mut var_data_keys := rt.func_array_keys(rt.call_function('array_filter', [var_schema.array_get('properties'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'filter_writable_props' }])]))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_request.array_get('customer_id').is_null()))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		if rt.is_true(rt.call_function('is_wp_error', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Utilities_Users{}; return temp.get_user_in_current_site(arg_0) }(var_request.array_get('customer_id'))])) {
			rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_customer_id'), rt.call_function('__', [rt.new_string('Customer ID is invalid.'), rt.new_string('woocommerce')]), rt.new_int(400))))
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_member_of_blog', [var_request.array_get('customer_id')]))))))) {
			rt.call_function('add_user_to_blog', [rt.call_function('get_current_blog_id', []rt.PhpVal{}), var_request.array_get('customer_id'), rt.new_string('customer')])
		}
	}
	{
		mut iter_1 := var_data_keys.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			mut var_value := var_request.array_get(var_key)
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.dup().is_null()))))) {
				mut switch_val_1 := var_key
				if rt.is_true(rt.equal(switch_val_1, rt.new_string('billing'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('shipping'))) {
					this.update_address(var_order.dup(), var_value.dup(), (var_key).str())
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('line_items'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('shipping_lines'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('fee_lines'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('coupon_lines'))) {
					if rt.is_true(rt.new_bool(var_value.dup().is_array())) {
						{
							mut iter_2 := var_value.iterator()
							for {
								item_2 := iter_2.next() or { break }
								mut var_item := item_2.val
								if rt.is_true(rt.new_bool(var_item.dup().is_array())) {
									if rt.is_true(rt.new_bool(rt.is_true() || rt.is_true())) {
										
									} else {
									}
								}
							}
						}
					}
				} else {
					if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val:  }, rt.ArrayItem{ key: none, val:  }])])) {
						rt.call_method(, , [.dup()])
					}
				}
			}
		}
	}
	return rt.call_function('apply_filters', [rt.concat(, ), var_order.dup(), var_request.dup()])
}

fn (mut this Class_WC_REST_Orders_V1_Controller) create_base_order(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	return rt.call_function('wc_create_order', [.dup()])
}

fn (mut this Class_WC_REST_Orders_V1_Controller) filter_writable_props(var_schema rt.PhpVal) rt.PhpVal {
	mut var_schema_mutated := var_schema
	return 
}

fn (mut this Class_WC_REST_Orders_V1_Controller) create_order(var_request rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_WC_REST_Orders_V1_Controller) update_order(var_request rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_WC_REST_Orders_V1_Controller) update_address(var_order rt.PhpVal, var_posted rt.PhpVal, type string)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_REST_Orders_V1_Controller) get_product_id(var_posted rt.PhpVal, action string) rt.PhpVal {
	mut action_mutated := action
}

fn (mut this Class_WC_REST_Orders_V1_Controller) maybe_set_item_prop(var_item rt.PhpVal, var_prop rt.PhpVal, var_posted rt.PhpVal)  {
	mut var_item_mutated := var_item
}

fn (mut this Class_WC_REST_Orders_V1_Controller) maybe_set_item_props(var_item rt.PhpVal, var_props rt.PhpVal, var_posted rt.PhpVal)  {
	mut var_item_mutated := var_item
}

fn (mut this Class_WC_REST_Orders_V1_Controller) prepare_line_items(var_posted rt.PhpVal, action string) rt.PhpVal {
	mut action_mutated := action
}

fn (mut this Class_WC_REST_Orders_V1_Controller) prepare_shipping_lines(var_posted rt.PhpVal, var_action rt.PhpVal) rt.PhpVal {
	mut var_action_mutated := var_action
}

fn (mut this Class_WC_REST_Orders_V1_Controller) prepare_fee_lines(var_posted rt.PhpVal, var_action rt.PhpVal) rt.PhpVal {
	mut var_action_mutated := var_action
}

fn (mut this Class_WC_REST_Orders_V1_Controller) prepare_coupon_lines(var_posted rt.PhpVal, var_action rt.PhpVal) rt.PhpVal {
	mut var_action_mutated := var_action
}

fn (mut this Class_WC_REST_Orders_V1_Controller) set_item(var_order rt.PhpVal, var_item_type rt.PhpVal, var_posted rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_REST_Orders_V1_Controller) item_is_null(var_item rt.PhpVal) bool {
	mut var_item_mutated := var_item
}

fn (mut this Class_WC_REST_Orders_V1_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_REST_Orders_V1_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_WC_REST_Orders_V1_Controller) get_order_statuses() rt.PhpVal {
}

fn (mut this Class_WC_REST_Orders_V1_Controller) get_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_REST_Orders_V1_Controller) update_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_REST_Orders_V1_Controller) delete_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_REST_Orders_V1_Controller) get_item_schema() rt.PhpVal {
}

fn (mut this Class_WC_REST_Orders_V1_Controller) get_collection_params() rt.PhpVal {
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

fn create_wc_rest_posts_controller() &Class_WC_REST_Posts_Controller {
	mut obj := &Class_WC_REST_Posts_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_numberutil() &Class_NumberUtil {
	mut obj := &Class_NumberUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order() &Class_WC_Order {
	mut obj := &Class_WC_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_users() &Class_Automattic_WooCommerce_Internal_Utilities_Users {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_Users{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_rest_exception() &Class_WC_REST_Exception {
	mut obj := &Class_WC_REST_Exception{
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


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version1_class_wc_rest_orders_v1_controller_php() {
	// unsupported statement: Stmt_GroupUse
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
