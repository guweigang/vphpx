import rt

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderShippingSchema.identifier() string {
	return 'order-shipping'
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderShippingSchema {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderShippingSchema) get_item_schema_properties() rt.PhpVal {
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Item ID.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderShippingSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'method_title', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Shipping method name.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderShippingSchema.view_edit_embed_context()
			},
		]) },
		rt.ArrayItem{ key: 'method_id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Shipping method ID.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderShippingSchema.view_edit_embed_context()
			},
		]) },
		rt.ArrayItem{ key: 'instance_id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Shipping instance ID.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderShippingSchema.view_edit_embed_context()
			},
		]) },
		rt.ArrayItem{ key: 'total', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Line total (after discounts).'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderShippingSchema.view_edit_embed_context()
			},
		]) },
		rt.ArrayItem{ key: 'total_tax', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Line total tax (after discounts).'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderShippingSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'taxes', val: this.get_taxes_schema() },
		rt.ArrayItem{ key: 'meta_data', val: this.get_meta_data_schema() },
	])
	return var_schema.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderShippingSchema) get_item_response(var_order_item rt.PhpVal, mut var_request Class_WP_REST_Request, mut var_include_fields Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_array) rt.PhpVal {
	mut var_dp := if var_request.array_get(rt.new_string('num_decimals')).is_null() { rt.call_function('wc_get_price_decimals', []rt.PhpVal{}) } else { rt.call_function('absint', [
			var_request.array_get(rt.new_string('num_decimals')),
		]) }
	mut var_data := rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.call_method(var_order_item, 'get_id', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'method_title', val: rt.call_method(var_order_item, 'get_method_title',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'method_id', val: rt.call_method(var_order_item, 'get_method_id',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'instance_id', val: rt.call_method(var_order_item, 'get_instance_id',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'total', val: rt.call_function('wc_format_decimal', [
			rt.call_method(var_order_item, 'get_total', []rt.PhpVal{}),
			var_dp.clone(),
		]) },
		rt.ArrayItem{ key: 'total_tax', val: rt.call_function('wc_format_decimal', [
			rt.call_method(var_order_item, 'get_total_tax', []rt.PhpVal{}),
			var_dp.clone(),
		]) },
		rt.ArrayItem{ key: 'taxes', val: this.prepare_taxes(var_order_item.clone(), rt.new_object('WP_REST_Request',
			[]string{}, var_request)) },
		rt.ArrayItem{ key: 'meta_data', val: this.prepare_meta_data(var_order_item.clone()) },
	])
	return var_data.clone()
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_orders_schema_ordershippingschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderShippingSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderShippingSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_orders_schema_abstractlineitemschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderShippingSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_item_schema_properties' {
			return this.get_item_schema_properties()
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return this.get_item_response(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderShippingSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderShippingSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
