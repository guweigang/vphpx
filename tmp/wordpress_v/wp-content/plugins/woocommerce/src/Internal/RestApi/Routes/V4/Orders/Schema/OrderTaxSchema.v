import rt

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderTaxSchema.identifier() string {
	return 'order-tax'
}
struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderTaxSchema {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderTaxSchema) get_item_schema_properties() rt.PhpVal {
	mut var_schema := rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Item ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderTaxSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'rate_code', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax rate code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderTaxSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'rate_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax rate ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderTaxSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'label', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax rate label.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderTaxSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'compound', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Show if is a compound tax rate.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderTaxSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'tax_total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax total (not including shipping taxes).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderTaxSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'shipping_tax_total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shipping tax total.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderTaxSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'meta_data', val: this.get_meta_data_schema() }])
	return var_schema.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderTaxSchema) get_item_response(var_order_item rt.PhpVal, mut var_request Class_WP_REST_Request, mut var_include_fields Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_array) rt.PhpVal {
	mut var_dp := if rt.is_true(rt.new_bool(var_request.array_get('num_decimals').is_null())) { rt.call_function('wc_get_price_decimals', []rt.PhpVal{}) } else { rt.call_function('absint', [var_request.array_get('num_decimals')]) }
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_order_item, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'rate_code', val: rt.call_method(var_order_item, 'get_rate_code', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'rate_id', val: rt.call_method(var_order_item, 'get_rate_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'label', val: rt.call_method(var_order_item, 'get_label', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'compound', val: rt.call_method(var_order_item, 'get_compound', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'tax_total', val: rt.call_function('wc_format_decimal', [rt.call_method(var_order_item, 'get_tax_total', []rt.PhpVal{}), var_dp.dup()]) }, rt.ArrayItem{ key: 'shipping_tax_total', val: rt.call_function('wc_format_decimal', [rt.call_method(var_order_item, 'get_shipping_tax_total', []rt.PhpVal{}), var_dp.dup()]) }, rt.ArrayItem{ key: 'meta_data', val: this.prepare_meta_data(var_order_item.dup()) }])
	return var_data.dup()
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_orders_schema_ordertaxschema() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderTaxSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderTaxSchema{
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

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderTaxSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_item_schema_properties' {
			return this.get_item_schema_properties()
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.get_item_response(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderTaxSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderTaxSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_restapi_routes_v4_orders_schema_ordertaxschema_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
