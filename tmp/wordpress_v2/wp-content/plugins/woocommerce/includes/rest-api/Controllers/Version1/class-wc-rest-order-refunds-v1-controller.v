import rt

struct Class_WC_REST_Order_Refunds_V1_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v1')
	rest_base rt.PhpVal = rt.new_string('orders/(?P<order_id>[\\d]+)/refunds')
	post_type rt.PhpVal = rt.new_string('shop_order_refund')
}

fn (mut this Class_WC_REST_Order_Refunds_V1_Controller) construct() {
	rt.call_function('add_filter', [
		rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type),
			rt.new_string('_trashable')),
		rt.new_string('__return_false'),
	])
	rt.call_function('add_filter', [
		rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type),
			rt.new_string('_query')),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Refunds_V1_Controller', [
				'WC_REST_Orders_V1_Controller',
			], &this) },
			rt.ArrayItem{ key: none, val: 'query_args' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
}

fn (mut this Class_WC_REST_Order_Refunds_V1_Controller) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' +
		(this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'order_id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('The order ID.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Refunds_V1_Controller', [
						'WC_REST_Orders_V1_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Refunds_V1_Controller', [
						'WC_REST_Orders_V1_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Refunds_V1_Controller', [
						'WC_REST_Orders_V1_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Refunds_V1_Controller', [
						'WC_REST_Orders_V1_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item_permissions_check' },
				]) },
				rt.ArrayItem{
					key: 'args'
					val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable())
				},
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Refunds_V1_Controller', [
					'WC_REST_Orders_V1_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/(?P<id>[\\d]+)'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'order_id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('The order ID.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique identifier for the resource.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Refunds_V1_Controller', [
						'WC_REST_Orders_V1_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Refunds_V1_Controller', [
						'WC_REST_Orders_V1_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
						rt.ArrayItem{ key: 'default', val: 'view' },
					])) },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Refunds_V1_Controller', [
						'WC_REST_Orders_V1_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Refunds_V1_Controller', [
						'WC_REST_Orders_V1_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'force', val: rt.create_array([
						rt.ArrayItem{ key: 'default', val: true },
						rt.ArrayItem{ key: 'type', val: 'boolean' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Required to be true, as resource does not support trashing.'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Refunds_V1_Controller', [
					'WC_REST_Orders_V1_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
}

fn (mut this Class_WC_REST_Order_Refunds_V1_Controller) prepare_item_for_response(var_post rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	mut var_order := rt.call_function('wc_get_order', [
		rt.new_int((var_request.array_get(rt.new_string('order_id'))).to_i64()),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_invalid_order_id'), rt.call_function('__', [
			rt.new_string('Invalid order ID.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(404)))
	}
	mut var_refund := rt.call_function('wc_get_order', [var_post_mutated.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_refund))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_refund, 'get_parent_id', []rt.PhpVal{}), rt.call_method(var_order, 'get_id', []rt.PhpVal{}))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_invalid_order_refund_id'), rt.call_function('__', [
			rt.new_string('Invalid order refund ID.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(404)))
	}
	mut var_dp := if var_request.array_get(rt.new_string('dp')).is_null() { rt.call_function('wc_get_price_decimals', []rt.PhpVal{}) } else { rt.call_function('absint', [
			var_request.array_get(rt.new_string('dp')),
		]) }
	mut var_data := rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.call_method(var_refund, 'get_id', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [
			rt.call_method(var_refund, 'get_date_created', []rt.PhpVal{}),
		]) },
		rt.ArrayItem{ key: 'amount', val: rt.call_function('wc_format_decimal', [
			rt.call_method(var_refund, 'get_amount', []rt.PhpVal{}),
			var_dp.clone(),
		]) },
		rt.ArrayItem{ key: 'reason', val: rt.call_method(var_refund, 'get_reason', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'line_items', val: rt.new_array() },
	])
	mut iter_1 := rt.call_method(var_refund, 'get_items', []rt.PhpVal{}).iterator()
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
		mut var_hideprefix := if rt.is_true(rt.identical(rt.new_string('true'),
			var_request.array_get(rt.new_string('all_item_meta'))))
		{
			rt.new_null()
		} else {
			rt.new_string('_')
		}
		mut iter_2 := rt.call_method(var_item, 'get_all_formatted_meta_data', [
			var_hideprefix.clone(),
		]).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_formatted_meta := item_2.val
			mut var_meta_key := item_2.key
			var_item_meta << rt.create_array([
				rt.ArrayItem{ key: 'key', val: rt.get_property(var_formatted_meta, 'key') },
				rt.ArrayItem{ key: 'label', val: rt.get_property(var_formatted_meta, 'display_key') },
				rt.ArrayItem{ key: 'value', val: rt.call_function('wc_clean', [
					rt.get_property(var_formatted_meta, 'display_value'),
				]) },
			])
		}
		mut var_line_item := {
			'id':           var_item_id
			'name':         var_item.array_get(rt.new_string('name'))
			'sku':          var_product_sku
			'product_id':   rt.new_int(var_product_id.to_i64())
			'variation_id': rt.new_int(var_variation_id.to_i64())
			'quantity':     rt.call_function('wc_stock_amount', [
				var_item.array_get(rt.new_string('qty')),
			])
			'tax_class':    if !(!rt.is_true(var_item.array_get(rt.new_string('tax_class')))) {
				var_item.array_get(rt.new_string('tax_class'))
			} else {
				rt.new_string('')
			}
			'price':        rt.call_function('wc_format_decimal', [
				rt.call_method(var_refund, 'get_item_total', [
					var_item.clone(), rt.new_bool(false), rt.new_bool(false)]),
				var_dp.clone(),
			])
			'subtotal':     rt.call_function('wc_format_decimal', [
				rt.call_method(var_refund, 'get_line_subtotal', [
					var_item.clone(), rt.new_bool(false), rt.new_bool(false)]),
				var_dp.clone(),
			])
			'subtotal_tax': rt.call_function('wc_format_decimal', [
				var_item.array_get(rt.new_string('line_subtotal_tax')),
				var_dp.clone(),
			])
			'total':        rt.call_function('wc_format_decimal', [
				rt.call_method(var_refund, 'get_line_total', [
					var_item.clone(), rt.new_bool(false), rt.new_bool(false)]),
				var_dp.clone(),
			])
			'total_tax':    rt.call_function('wc_format_decimal', [
				var_item.array_get(rt.new_string('line_tax')),
				var_dp.clone(),
			])
			'taxes':        rt.new_array()
			'meta':         var_item_meta
		}
		mut var_item_line_taxes := rt.call_function('maybe_unserialize', [
			var_item.array_get(rt.new_string('line_tax_data')),
		])
		if var_item_line_taxes.array_isset(rt.new_string('total')) {
			mut var_line_tax := rt.new_array()
			mut iter_3 := var_item_line_taxes.array_get(rt.new_string('total')).iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_tax := item_3.val
				mut var_tax_rate_id := item_3.key
				var_line_tax.array_set(var_tax_rate_id, rt.create_array([
					rt.ArrayItem{ key: 'id', val: var_tax_rate_id },
					rt.ArrayItem{ key: 'total', val: var_tax },
					rt.ArrayItem{ key: 'subtotal', val: '' },
				]))
			}
			mut iter_4 := var_item_line_taxes.array_get(rt.new_string('subtotal')).iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_tax := item_4.val
				mut var_tax_rate_id := item_4.key
				var_line_tax.array_get_mut(var_tax_rate_id).array_set('subtotal', var_tax.clone())
			}
			var_line_item['taxes'] = rt.call_function('array_values', [
				var_line_tax.clone()])
		}
		var_data.array_get_mut('line_items').array_push(var_line_item.clone())
	}
	mut var_context := if !(!rt.is_true(var_request.array_get(rt.new_string('context')))) {
		var_request.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	rt.call_method(var_response, 'add_links', [
		this.prepare_links(var_refund.clone(), var_request.clone()),
	])
	return rt.call_function('apply_filters', [
		rt.concat(rt.new_string('woocommerce_rest_prepare_'), this.post_type),
		var_response.clone(),
		var_post_mutated.clone(),
		var_request.clone(),
	])
}

fn (mut this Class_WC_REST_Order_Refunds_V1_Controller) prepare_links(var_refund rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_refund_mutated := var_refund
	mut var_order_id := rt.call_method(var_refund_mutated, 'get_parent_id', []rt.PhpVal{})
	mut var_base := rt.call_function('str_replace', [
		rt.new_string('(?P<order_id>[\\d]+)'),
		var_order_id.clone(),
		this.rest_base,
	])
	mut var_links := {
		'self':       {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace,
					var_base.clone(), rt.call_method(var_refund_mutated, 'get_id', []rt.PhpVal{})]),
			])
		}
		'collection': {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf',
					[rt.new_string('/%s/%s'), this.namespace, var_base.clone()]),
			])
		}
		'up':         {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('/%s/orders/%d'), this.namespace,
					var_order_id.clone()]),
			])
		}
	}
	return var_links.clone()
}

fn (mut this Class_WC_REST_Order_Refunds_V1_Controller) query_args(var_args rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	var_args_mutated.array_set('post_status', rt.func_array_keys(rt.call_function('wc_get_order_statuses',
		[]rt.PhpVal{})))
	var_args_mutated.array_set('post_parent__in', rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('absint', [
			var_request.array_get(rt.new_string('order_id')),
		]) },
	]))
	return var_args_mutated.clone()
}

fn (mut this Class_WC_REST_Order_Refunds_V1_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_request.array_get(rt.new_string('id')))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'),
			this.post_type), rt.new_string('_exists')), rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Cannot create existing %s.'),
				rt.new_string('woocommerce')]),
			this.post_type,
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	mut var_order_data := rt.call_function('get_post', [
		rt.new_int((var_request.array_get(rt.new_string('order_id'))).to_i64()),
	])
	if !rt.is_true(var_order_data) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_invalid_order'), rt.call_function('__', [
			rt.new_string('Order is invalid'),
			rt.new_string('woocommerce'),
		]), rt.new_int(400)))
	}
	if rt.is_true(rt.greater(rt.new_int(0), var_request.array_get(rt.new_string('amount')))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_invalid_order_refund'), rt.call_function('__', [
			rt.new_string('Refund amount must be greater than zero.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(400)))
	}
	mut var_refund := rt.call_function('wc_create_refund', [
		rt.create_array([
			rt.ArrayItem{ key: 'order_id', val: rt.get_property(var_order_data, 'ID') },
			rt.ArrayItem{ key: 'amount', val: var_request.array_get(rt.new_string('amount')) },
			rt.ArrayItem{
				key: 'reason'
				val: if !rt.is_true(var_request.array_get(rt.new_string('reason'))) {
					rt.new_null()
				} else {
					var_request.array_get(rt.new_string('reason'))
				}
			},
			rt.ArrayItem{
				key: 'refund_payment'
				val: if var_request.array_get(rt.new_string('api_refund')).is_bool() {
					var_request.array_get(rt.new_string('api_refund'))
				} else {
					rt.new_bool(true)
				}
			},
			rt.ArrayItem{ key: 'restock_items', val: true },
		]),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_refund.clone()])) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_cannot_create_order_refund'), rt.call_method(var_refund,
			'get_error_message', []rt.PhpVal{}), rt.new_int(500)))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_refund)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_cannot_create_order_refund'), rt.call_function('__', [
			rt.new_string('Cannot create order refund, please try again.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(500)))
	}
	mut var_post := rt.call_function('get_post', [
		rt.call_method(var_refund, 'get_id', []rt.PhpVal{}),
	])
	this.update_additional_fields_for_object(var_post.clone(), var_request.clone())
	rt.call_function('do_action', [
		rt.concat(rt.new_string('woocommerce_rest_insert_'), this.post_type),
		var_post.clone(),
		var_request.clone(),
		rt.new_bool(true),
	])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_post.clone(), var_request.clone())
	var_response = rt.call_function('rest_ensure_response', [
		var_response.clone()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace, this.rest_base,
				rt.get_property(var_post, 'ID')]),
		])])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Order_Refunds_V1_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := {
		'$schema':    rt.new_string('http://json-schema.org/draft-04/schema#')
		'title':      this.post_type
		'type':       rt.new_string('object')
		'properties': {
			'id':           {
				'description': rt.call_function('__', [
					rt.new_string('Unique identifier for the resource.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('integer')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'date_created': {
				'description': rt.call_function('__', [
					rt.new_string("The date the order refund was created, in the site's timezone."),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('date-time')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'amount':       {
				'description': rt.call_function('__', [rt.new_string('Refund amount.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
			}
			'reason':       {
				'description': rt.call_function('__', [
					rt.new_string('Reason for refund.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
			}
			'line_items':   {
				'description': rt.call_function('__', [rt.new_string('Line items data.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('array')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
				'items':       {
					'type':       rt.new_string('object')
					'properties': {
						'id':           {
							'description': rt.call_function('__', [
								rt.new_string('Item ID.'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('integer')
							'context':     map[string]rt.PhpVal{}
							'readonly':    rt.new_bool(true)
						}
						'name':         {
							'description': rt.call_function('__', [
								rt.new_string('Product name.'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('mixed')
							'context':     map[string]rt.PhpVal{}
							'readonly':    rt.new_bool(true)
						}
						'sku':          {
							'description': rt.call_function('__', [
								rt.new_string('Product SKU.'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('string')
							'context':     map[string]rt.PhpVal{}
							'readonly':    rt.new_bool(true)
						}
						'product_id':   {
							'description': rt.call_function('__', [
								rt.new_string('Product ID.'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('mixed')
							'context':     map[string]rt.PhpVal{}
							'readonly':    rt.new_bool(true)
						}
						'variation_id': {
							'description': rt.call_function('__', [
								rt.new_string('Variation ID, if applicable.'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('integer')
							'context':     map[string]rt.PhpVal{}
							'readonly':    rt.new_bool(true)
						}
						'quantity':     {
							'description': rt.call_function('__', [
								rt.new_string('Quantity ordered.'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('integer')
							'context':     map[string]rt.PhpVal{}
							'readonly':    rt.new_bool(true)
						}
						'tax_class':    {
							'description': rt.call_function('__', [
								rt.new_string('Tax class of product.'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('string')
							'context':     map[string]rt.PhpVal{}
							'readonly':    rt.new_bool(true)
						}
						'price':        {
							'description': rt.call_function('__', [
								rt.new_string('Product price.'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('string')
							'context':     map[string]rt.PhpVal{}
							'readonly':    rt.new_bool(true)
						}
						'subtotal':     {
							'description': rt.call_function('__', [
								rt.new_string('Line subtotal (before discounts).'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('string')
							'context':     map[string]rt.PhpVal{}
							'readonly':    rt.new_bool(true)
						}
						'subtotal_tax': {
							'description': rt.call_function('__', [
								rt.new_string('Line subtotal tax (before discounts).'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('string')
							'context':     map[string]rt.PhpVal{}
							'readonly':    rt.new_bool(true)
						}
						'total':        {
							'description': rt.call_function('__', [
								rt.new_string('Line total (after discounts).'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('string')
							'context':     map[string]rt.PhpVal{}
							'readonly':    rt.new_bool(true)
						}
						'total_tax':    {
							'description': rt.call_function('__', [
								rt.new_string('Line total tax (after discounts).'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('string')
							'context':     map[string]rt.PhpVal{}
							'readonly':    rt.new_bool(true)
						}
						'taxes':        {
							'description': rt.call_function('__', [
								rt.new_string('Line taxes.'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('array')
							'context':     map[string]rt.PhpVal{}
							'readonly':    rt.new_bool(true)
							'items':       {
								'type':       rt.new_string('object')
								'properties': {
									'id':       {
										'description': rt.call_function('__', [
											rt.new_string('Tax rate ID.'),
											rt.new_string('woocommerce'),
										])
										'type':        rt.new_string('integer')
										'context':     map[string]rt.PhpVal{}
										'readonly':    rt.new_bool(true)
									}
									'total':    {
										'description': rt.call_function('__', [
											rt.new_string('Tax total.'),
											rt.new_string('woocommerce'),
										])
										'type':        rt.new_string('string')
										'context':     map[string]rt.PhpVal{}
										'readonly':    rt.new_bool(true)
									}
									'subtotal': {
										'description': rt.call_function('__', [
											rt.new_string('Tax subtotal.'),
											rt.new_string('woocommerce'),
										])
										'type':        rt.new_string('string')
										'context':     map[string]rt.PhpVal{}
										'readonly':    rt.new_bool(true)
									}
								}
							}
						}
						'meta':         {
							'description': rt.call_function('__', [
								rt.new_string('Line item meta data.'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('array')
							'context':     map[string]rt.PhpVal{}
							'readonly':    rt.new_bool(true)
							'items':       {
								'type':       rt.new_string('object')
								'properties': {
									'key':   {
										'description': rt.call_function('__', [
											rt.new_string('Meta key.'),
											rt.new_string('woocommerce'),
										])
										'type':        rt.new_string('string')
										'context':     map[string]rt.PhpVal{}
										'readonly':    rt.new_bool(true)
									}
									'label': {
										'description': rt.call_function('__', [
											rt.new_string('Meta label.'),
											rt.new_string('woocommerce'),
										])
										'type':        rt.new_string('string')
										'context':     map[string]rt.PhpVal{}
										'readonly':    rt.new_bool(true)
									}
									'value': {
										'description': rt.call_function('__', [
											rt.new_string('Meta value.'),
											rt.new_string('woocommerce'),
										])
										'type':        rt.new_string('mixed')
										'context':     map[string]rt.PhpVal{}
										'readonly':    rt.new_bool(true)
									}
								}
							}
						}
					}
				}
			}
		}
	}
	return this.add_additional_fields_schema(var_schema.clone())
}

fn (mut this Class_WC_REST_Order_Refunds_V1_Controller) get_collection_params() rt.PhpVal {
	mut var_params := this.Class_WC_REST_Orders_V1_Controller.get_collection_params()
	var_params.array_set('dp', rt.create_array([
		rt.ArrayItem{ key: 'default', val: rt.call_function('wc_get_price_decimals', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Number of decimal points to use in each resource.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	return var_params.clone()
}

struct Class_WC_REST_Orders_V1_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_rest_order_refunds_v1_controller() &Class_WC_REST_Order_Refunds_V1_Controller {
	mut obj := &Class_WC_REST_Order_Refunds_V1_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v1')
		rest_base:     rt.new_string('orders/(?P<order_id>[\\d]+)/refunds')
		post_type:     rt.new_string('shop_order_refund')
	}
	obj.construct()
	return obj
}

fn create_wc_rest_orders_v1_controller(_args ...rt.PhpVal) &Class_WC_REST_Orders_V1_Controller {
	mut obj := &Class_WC_REST_Orders_V1_Controller{
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

fn (mut this Class_WC_REST_Order_Refunds_V1_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_REST_Order_Refunds_V1_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		'post_type' { return this.post_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Order_Refunds_V1_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		'rest_base' {
			this.rest_base = val
			return true
		}
		'post_type' {
			this.post_type = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_REST_Orders_V1_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Orders_V1_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Orders_V1_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
