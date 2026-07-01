import rt

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.identifier() string {
	return 'order'
}
struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema {
	rt.PhpObjectBase
pub mut:
		order_item_schema rt.PhpVal = rt.new_null()
		order_fee_schema rt.PhpVal = rt.new_null()
		order_tax_schema rt.PhpVal = rt.new_null()
		order_shipping_schema rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema) init(mut var_order_item_schema Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema, mut var_order_fee_schema Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderFeeSchema, mut var_order_tax_schema Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderTaxSchema, mut var_order_shipping_schema Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderShippingSchema)  {
	this.order_item_schema = var_order_item_schema.dup()
	this.order_fee_schema = var_order_fee_schema.dup()
	this.order_tax_schema = var_order_tax_schema.dup()
	this.order_shipping_schema = var_order_shipping_schema.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema) get_item_schema_properties() rt.PhpVal {
	mut var_schema := rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the refund.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'order_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The ID of the order that was refunded.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }]) }, rt.ArrayItem{ key: 'amount', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Amount that was refunded. This is calculated from the line items if not provided.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'default', val: 0 }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }, rt.ArrayItem{ key: 'reason', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Reason for the refund.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'default', val: '' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }]) }, rt.ArrayItem{ key: 'currency', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Currency the refund was created with, in ISO format.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: rt.call_function('get_woocommerce_currency', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'enum', val: rt.func_array_keys(rt.call_function('get_woocommerce_currencies', []rt.PhpVal{})) }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'currency_symbol', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Currency symbol for the currency which can be used to format returned prices.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'date_created', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the refund was created, in the site\'s timezone.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'date_created_gmt', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the refund was created, as GMT.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'refunded_by', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('User who created the refund.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('User ID of user who created the refund.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'display_name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Display name of the user who created the refund.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'avatar_url', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Avatar URL of the user who created the refund.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'format', val: 'uri' }]) }]) }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'refunded_payment', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('If the payment was refunded via the API.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'meta_data', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'key', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta key.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.view_edit_embed_context() }]) }, rt.ArrayItem{ key: 'value', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta value.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'null' }, rt.ArrayItem{ key: none, val: 'object' }, rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'number' }, rt.ArrayItem{ key: none, val: 'boolean' }, rt.ArrayItem{ key: none, val: 'integer' }, rt.ArrayItem{ key: none, val: 'array' }]) }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.view_edit_embed_context() }]) }]) }]) }]) }, rt.ArrayItem{ key: 'line_items', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Refunded line items. This can include products, fees, and shipping lines, combined into a single array.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('ID of the refund line item. This is not the ID of the original line item.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'line_item_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('ID of the original line item.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }, rt.ArrayItem{ key: 'quantity', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Quantity refunded.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'default', val: 0 }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wc_stock_amount' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }, rt.ArrayItem{ key: 'refund_total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Total refunded for this item.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'default', val: 0 }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }, rt.ArrayItem{ key: 'refund_tax', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Optional: Taxes refunded for this item. If not provided, tax will be automatically extracted from refund_total using the order\'s tax rates.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }, rt.ArrayItem{ key: 'refund_total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Amount refunded for this tax.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }]) }]) }]) }]) }]) }]) }])
	if rt.is_true(this.cogs_is_enabled()) {
		var_schema = this.add_cogs_related_schema(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_array](var_schema))
	}
	return var_schema.dup()
}

fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.add_cogs_related_schema(mut var_schema Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_array) rt.PhpVal {
	mut var_schema_mutated := var_schema
	var_schema_mutated.array_set('cost_of_goods_sold', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Cost of Goods Sold data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'total_value', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Total value of the Cost of Goods Sold for the refund.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.view_edit_embed_context() }]) }]) }]))
	return rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_array', []string{}, var_schema_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema) get_item_response(var_refund rt.PhpVal, mut var_request Class_WP_REST_Request, mut var_include_fields Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_array) rt.PhpVal {
	mut var_dp := if rt.is_true(rt.new_bool(var_request.array_get('num_decimals').is_null())) { rt.call_function('wc_get_price_decimals', []rt.PhpVal{}) } else { rt.call_function('absint', [var_request.array_get('num_decimals')]) }
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_refund, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'order_id', val: rt.call_method(var_refund, 'get_parent_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'currency', val: rt.call_method(var_refund, 'get_currency', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'currency_symbol', val: rt.call_function('html_entity_decode', [rt.call_function('get_woocommerce_currency_symbol', [rt.call_method(var_refund, 'get_currency', []rt.PhpVal{})]), rt.get_constant('ENT_QUOTES')]) }, rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_refund, 'get_date_created', []rt.PhpVal{}), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_created_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_refund, 'get_date_created', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'amount', val: rt.call_function('wc_format_decimal', [rt.call_method(var_refund, 'get_amount', []rt.PhpVal{}), var_dp.dup()]) }, rt.ArrayItem{ key: 'reason', val: rt.call_method(var_refund, 'get_reason', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'refunded_payment', val: rt.call_method(var_refund, 'get_refunded_payment', []rt.PhpVal{}) }])
	if rt.is_true(rt.call_function('in_array', [rt.new_string('refunded_by'), var_include_fields, rt.new_bool(true)])) {
		mut var_refunded_user := create_automattic_woocommerce_internal_restapi_routes_v4_refunds_schema_wp_user(rt.call_method(var_refund, 'get_refunded_by', []rt.PhpVal{}))
		if rt.is_true(var_refunded_user.exists()) {
			var_data.array_set('refunded_by', rt.create_array([rt.ArrayItem{ key: 'id', val: rt.get_property(var_refunded_user, 'ID') }, rt.ArrayItem{ key: 'display_name', val: rt.get_property(var_refunded_user, 'display_name') }, rt.ArrayItem{ key: 'avatar_url', val: rt.call_function('get_avatar_url', [var_refunded_user]) }]))
		} else {
			var_data.array_set('refunded_by', rt.new_null())
		}
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('line_items'), var_include_fields, rt.new_bool(true)])) {
		var_data.array_set('line_items', rt.call_function('array_merge', [this.get_line_items_response(rt.call_method(var_refund, 'get_items', [Class_Automattic_WooCommerce_Enums_OrderItemType.line_item()]), mut var_request), this.get_line_items_response(rt.call_method(var_refund, 'get_items', [Class_Automattic_WooCommerce_Enums_OrderItemType.fee()]), mut var_request), this.get_line_items_response(rt.call_method(var_refund, 'get_items', [Class_Automattic_WooCommerce_Enums_OrderItemType.shipping()]), mut var_request)]))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('meta_data'), var_include_fields, rt.new_bool(true)])) {
		mut var_filtered_meta_data := this.filter_internal_meta_keys(rt.call_method(var_refund, 'get_meta_data', []rt.PhpVal{}))
		var_data.array_set('meta_data', rt.new_array())
		{
			mut iter_1 := var_filtered_meta_data.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_meta_item := item_1.val
				var_data.array_get_mut('meta_data').array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: rt.get_property(var_meta_item, 'id') }, rt.ArrayItem{ key: 'key', val: rt.get_property(var_meta_item, 'key') }, rt.ArrayItem{ key: 'value', val: rt.get_property(var_meta_item, 'value') }]))
			}
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(this.cogs_is_enabled()) && rt.is_true(rt.call_function('in_array', [rt.new_string('cost_of_goods_sold'), var_include_fields, rt.new_bool(true)])))) {
		var_data.array_get_mut('cost_of_goods_sold').array_set('total_value', rt.call_method(var_refund, 'get_cogs_total_value', []rt.PhpVal{}))
	}
	var_data = rt.call_function('array_intersect_key', [var_data.dup(), rt.call_function('array_flip', [var_include_fields])])
	return var_data.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema) get_line_items_response(var_line_items rt.PhpVal, mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_line_items_response := rt.new_array()
	{
		mut iter_1 := var_line_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_line_item := item_1.val
			var_line_items_response.array_push(this.prepare_line_item(var_line_item.dup(), mut var_request))
		}
	}
	return var_line_items_response.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema) prepare_line_item(var_line_item rt.PhpVal, mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_dp := if rt.is_true(rt.new_bool(var_request.array_get('num_decimals').is_null())) { rt.call_function('wc_get_price_decimals', []rt.PhpVal{}) } else { rt.call_function('absint', [var_request.array_get('num_decimals')]) }
	mut var_tax_response := rt.new_array()
	mut var_taxes := rt.call_method(var_line_item, 'get_taxes', []rt.PhpVal{})
	{
		mut iter_1 := if !(var_taxes.array_get('total')).is_null() { var_taxes.array_get('total') } else { rt.new_array() }.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tax := item_1.val
			mut var_tax_rate_id := item_1.key
			var_tax_response.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_function('absint', [var_tax_rate_id.dup()]) }, rt.ArrayItem{ key: 'refund_total', val: rt.call_function('wc_format_decimal', [rt.call_function('abs', [// unsupported expression: Expr_Cast_Double]), var_dp.dup()]) }]))
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_function('absint', [rt.call_method(var_line_item, 'get_id', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'line_item_id', val: rt.call_function('absint', [rt.call_method(var_line_item, 'get_meta', [rt.new_string('_refunded_item_id')])]) }, rt.ArrayItem{ key: 'quantity', val: rt.call_function('wc_stock_amount', [rt.call_function('abs', [// unsupported expression: Expr_Cast_Double])]) }, rt.ArrayItem{ key: 'refund_total', val: rt.call_function('wc_format_decimal', [rt.call_function('abs', [// unsupported expression: Expr_Cast_Double]), var_dp.dup()]) }, rt.ArrayItem{ key: 'refund_tax', val: var_tax_response }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema) filter_internal_meta_keys(var_meta_data rt.PhpVal) rt.PhpVal {
	mut var_meta_data_mutated := var_meta_data
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.custom_orders_table_usage_is_enabled() }())))) {
		return var_meta_data_mutated.dup()
	}
	mut var_cpt_hidden_keys := rt.call_method(create_automattic_woocommerce_internal_restapi_routes_v4_refunds_schema_wc_order_data_store_cpt(), 'get_internal_meta_keys', []rt.PhpVal{})
	closure_1_fn := fn [var_cpt_hidden_keys] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_meta := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_meta, 'key'), var_cpt_hidden_keys.dup(), rt.new_bool(true)]))))
	}
	var_meta_data_mutated = rt.call_function('array_filter', [var_meta_data_mutated.dup(), rt.new_closure(closure_1_fn)])
	return rt.call_function('array_values', [var_meta_data_mutated.dup()])
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_WP_User {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_WC_Order_Data_Store_CPT {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_refunds_schema_refundschema() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema{
		PhpObjectBase: rt.PhpObjectBase{}
		order_item_schema: rt.new_null()
		order_fee_schema: rt.new_null()
		order_tax_schema: rt.new_null()
		order_shipping_schema: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_abstractschema() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_refunds_schema_wp_user() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_WP_User {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_WP_User{
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

fn create_automattic_woocommerce_internal_restapi_routes_v4_refunds_schema_wc_order_data_store_cpt() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_WC_Order_Data_Store_CPT {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_WC_Order_Data_Store_CPT{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderFeeSchema](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderTaxSchema](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderShippingSchema](if args.len > 3 { args[3] } else { rt.new_null() })
			this.init(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3)
			return rt.new_null()
		}
		'get_item_schema_properties' {
			return this.get_item_schema_properties()
		}
		'add_cogs_related_schema' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema.add_cogs_related_schema(mut dispatch_arg_0)
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.get_item_response(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'get_line_items_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.get_line_items_response(dispatch_arg_0, mut dispatch_arg_1)
		}
		'prepare_line_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.prepare_line_item(dispatch_arg_0, mut dispatch_arg_1)
		}
		'filter_internal_meta_keys' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_internal_meta_keys(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'order_item_schema' { return this.order_item_schema }
		'order_fee_schema' { return this.order_fee_schema }
		'order_tax_schema' { return this.order_tax_schema }
		'order_shipping_schema' { return this.order_shipping_schema }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'order_item_schema' { this.order_item_schema = val; return true }
		'order_fee_schema' { this.order_fee_schema = val; return true }
		'order_tax_schema' { this.order_tax_schema = val; return true }
		'order_shipping_schema' { this.order_shipping_schema = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_WP_User) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_WP_User) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_WP_User) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_WC_Order_Data_Store_CPT) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_WC_Order_Data_Store_CPT) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_WC_Order_Data_Store_CPT) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_restapi_routes_v4_refunds_schema_refundschema_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
