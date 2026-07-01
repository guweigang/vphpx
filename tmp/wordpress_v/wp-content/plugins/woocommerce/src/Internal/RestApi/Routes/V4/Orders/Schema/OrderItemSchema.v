import rt

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema.identifier() string {
	return 'order-item'
}
struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema) get_item_schema_properties() rt.PhpVal {
	mut var_schema := rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Item ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Item name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema.view_edit_embed_context() }]) }, rt.ArrayItem{ key: 'image', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Line item image, if available.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'product_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product or variation ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'integer' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema.view_edit_embed_context() }]) }, rt.ArrayItem{ key: 'product_data', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product data this item is linked to.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'object' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'properties', val: this.get_product_data_schema() }]) }, rt.ArrayItem{ key: 'quantity', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Quantity ordered.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema.view_edit_embed_context() }]) }, rt.ArrayItem{ key: 'price', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Item price. Calculated as total / quantity.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'tax_class', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax class of product.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema.view_edit_embed_context() }]) }, rt.ArrayItem{ key: 'subtotal', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Line subtotal (before discounts).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema.view_edit_embed_context() }]) }, rt.ArrayItem{ key: 'subtotal_tax', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Line subtotal tax (before discounts).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Line total (after discounts).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema.view_edit_embed_context() }]) }, rt.ArrayItem{ key: 'total_tax', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Line total tax (after discounts).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'taxes', val: this.get_taxes_schema() }, rt.ArrayItem{ key: 'meta_data', val: this.get_meta_data_schema() }, rt.ArrayItem{ key: 'currency', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Currency the order item was created with, in ISO format.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: rt.call_function('get_woocommerce_currency', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'enum', val: rt.func_array_keys(rt.call_function('get_woocommerce_currencies', []rt.PhpVal{})) }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'currency_symbol', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Currency symbol for the currency which can be used to format returned prices.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }])
	if rt.is_true(this.cogs_is_enabled()) {
		var_schema = this.add_cogs_related_schema(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_array](var_schema))
	}
	return var_schema.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema) add_cogs_related_schema(mut var_schema Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_array) rt.PhpVal {
	mut var_schema_mutated := var_schema
	var_schema_mutated.array_set('cost_of_goods_sold', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Cost of Goods Sold data. Only present for product line items.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'total_value', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Value of the Cost of Goods Sold for the order item.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema.view_edit_embed_context() }]) }]) }]))
	return rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_array', []string{}, var_schema_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema) get_item_response(var_order_item rt.PhpVal, mut var_request Class_WP_REST_Request, mut var_include_fields Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_array) rt.PhpVal {
	mut var_dp := if rt.is_true(rt.new_bool(var_request.array_get('num_decimals').is_null())) { rt.call_function('wc_get_price_decimals', []rt.PhpVal{}) } else { rt.call_function('absint', [var_request.array_get('num_decimals')]) }
	mut var_quantity_amount := // unsupported expression: Expr_Cast_Double
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_order_item, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'name', val: rt.call_method(var_order_item, 'get_name', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'image', val: this.get_image(mut rt.cast_object_ptr[Class_WC_Order_Item_Product](var_order_item)) }, rt.ArrayItem{ key: 'product_id', val: if rt.is_true(rt.call_method(var_order_item, 'get_variation_id', []rt.PhpVal{})) { rt.call_method(var_order_item, 'get_variation_id', []rt.PhpVal{}) } else { rt.call_method(var_order_item, 'get_product_id', []rt.PhpVal{}) } }, rt.ArrayItem{ key: 'product_data', val: this.get_product_data(mut rt.cast_object_ptr[Class_WC_Order_Item_Product](var_order_item)) }, rt.ArrayItem{ key: 'quantity', val: rt.call_method(var_order_item, 'get_quantity', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'price', val: if rt.is_true(var_quantity_amount) { rt.div(rt.call_method(var_order_item, 'get_total', []rt.PhpVal{}), var_quantity_amount) } else { rt.new_int(0) } }, rt.ArrayItem{ key: 'tax_class', val: rt.call_method(var_order_item, 'get_tax_class', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'subtotal', val: rt.call_function('wc_format_decimal', [rt.call_method(var_order_item, 'get_subtotal', []rt.PhpVal{}), var_dp.dup()]) }, rt.ArrayItem{ key: 'subtotal_tax', val: rt.call_function('wc_format_decimal', [rt.call_method(var_order_item, 'get_subtotal_tax', []rt.PhpVal{}), var_dp.dup()]) }, rt.ArrayItem{ key: 'total', val: rt.call_function('wc_format_decimal', [rt.call_method(var_order_item, 'get_total', []rt.PhpVal{}), var_dp.dup()]) }, rt.ArrayItem{ key: 'total_tax', val: rt.call_function('wc_format_decimal', [rt.call_method(var_order_item, 'get_total_tax', []rt.PhpVal{}), var_dp.dup()]) }, rt.ArrayItem{ key: 'taxes', val: this.prepare_taxes(var_order_item.dup(), rt.new_object('WP_REST_Request', []string{}, var_request)) }, rt.ArrayItem{ key: 'meta_data', val: this.prepare_meta_data(var_order_item.dup()) }, rt.ArrayItem{ key: 'currency', val: rt.call_method(rt.call_method(var_order_item, 'get_order', []rt.PhpVal{}), 'get_currency', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'currency_symbol', val: rt.call_function('html_entity_decode', [rt.call_function('get_woocommerce_currency_symbol', [rt.call_method(rt.call_method(var_order_item, 'get_order', []rt.PhpVal{}), 'get_currency', []rt.PhpVal{})]), rt.get_constant('ENT_QUOTES')]) }])
	if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema{}; return temp.cogs_is_enabled() }()) {
		var_data.array_get_mut('cost_of_goods_sold').array_set('total_value', if var_data.array_isset(rt.new_string('cogs_value')) { var_data.array_get('cogs_value') } else { rt.new_int(0) })
		var_data.array_unset(rt.new_string('cogs_value'))
	}
	return var_data.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema) get_product_data_schema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema.view_edit_embed_context() }]) }, rt.ArrayItem{ key: 'permalink', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product permalink.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema.view_edit_embed_context() }]) }, rt.ArrayItem{ key: 'sku', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product SKU.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema.view_edit_embed_context() }]) }, rt.ArrayItem{ key: 'global_unique_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product global unique ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema.view_edit_embed_context() }]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product type.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema.view_edit_embed_context() }]) }, rt.ArrayItem{ key: 'is_virtual', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product is virtual.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema.view_edit_embed_context() }]) }, rt.ArrayItem{ key: 'is_downloadable', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product is downloadable.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema.view_edit_embed_context() }]) }, rt.ArrayItem{ key: 'needs_shipping', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product needs shipping.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema.view_edit_embed_context() }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema) get_product_data(mut var_order_item Class_WC_Order_Item_Product) rt.PhpVal {
	mut var_product := var_order_item.get_product()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'WC_Product')))))) {
		return rt.new_null()
	}
	return rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_method(var_product, 'get_name', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'permalink', val: rt.call_method(var_product, 'get_permalink', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'sku', val: rt.call_method(var_product, 'get_sku', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'global_unique_id', val: rt.call_method(var_product, 'get_global_unique_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'type', val: rt.call_method(var_product, 'get_type', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'is_virtual', val: rt.call_method(var_product, 'is_virtual', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'is_downloadable', val: rt.call_method(var_product, 'is_downloadable', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'needs_shipping', val: rt.call_method(var_product, 'needs_shipping', []rt.PhpVal{}) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema) get_image(mut var_order_item Class_WC_Order_Item_Product) string {
	mut var_product := var_order_item.get_product()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'WC_Product')))))) {
		return ''
	}
	mut var_image_id := if rt.is_true(rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})) { rt.call_method(var_product, 'get_image_id', []rt.PhpVal{}) } else { rt.new_int(0) }
	return (if rt.is_true(var_image_id) { rt.call_function('wp_get_attachment_image_url', [var_image_id.dup(), rt.new_string('full')]) } else { rt.new_string('') }).str()
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_orders_schema_orderitemschema() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_orders_schema_abstractlineitemschema() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_item_schema_properties' {
			return this.get_item_schema_properties()
		}
		'add_cogs_related_schema' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.add_cogs_related_schema(mut dispatch_arg_0)
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.get_item_response(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'get_product_data_schema' {
			return this.get_product_data_schema()
		}
		'get_product_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order_Item_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_product_data(mut dispatch_arg_0)
		}
		'get_image' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order_Item_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_image(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_restapi_routes_v4_orders_schema_orderitemschema_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
