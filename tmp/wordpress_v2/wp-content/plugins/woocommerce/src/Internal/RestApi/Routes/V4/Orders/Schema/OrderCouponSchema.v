import rt

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderCouponSchema.identifier() string {
	return 'order-coupon'
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderCouponSchema {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderCouponSchema) get_item_schema_properties() rt.PhpVal {
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Item ID.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderCouponSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'code', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Coupon code.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderCouponSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'discount', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Discount total.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderCouponSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'discount_tax', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Discount total tax.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderCouponSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'discount_type', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Discount type.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'nominal_amount', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Discount amount as defined in the coupon (absolute value or a percent, depending on the discount type).'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'number' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'free_shipping', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Whether the coupon grants free shipping or not.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'boolean' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'meta_data', val: this.get_meta_data_schema() },
	])
	return var_schema.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderCouponSchema) get_item_response(var_order_item rt.PhpVal, mut var_request Class_WP_REST_Request, mut var_include_fields Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_array) rt.PhpVal {
	mut var_dp := if var_request.array_get(rt.new_string('num_decimals')).is_null() { rt.call_function('wc_get_price_decimals', []rt.PhpVal{}) } else { rt.call_function('absint', [
			var_request.array_get(rt.new_string('num_decimals')),
		]) }
	mut iife_temp_0 := Class_WC_Coupon{}
	mut iife_result_0 := iife_temp_0.from_order_item(var_order_item.clone())
	mut var_coupon := iife_result_0
	return rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.call_method(var_order_item, 'get_id', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'code', val: rt.call_method(var_order_item, 'get_code', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'discount', val: rt.call_function('wc_format_decimal', [
			rt.call_method(var_order_item, 'get_discount', []rt.PhpVal{}),
			var_dp.clone(),
		]) },
		rt.ArrayItem{ key: 'discount_tax', val: rt.call_function('wc_format_decimal', [
			rt.call_method(var_order_item, 'get_discount_tax', []rt.PhpVal{}),
			var_dp.clone(),
		]) },
		rt.ArrayItem{ key: 'discount_type', val: rt.call_method(var_coupon, 'get_discount_type',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'nominal_amount', val: rt.new_float((rt.call_method(var_coupon,
			'get_amount', []rt.PhpVal{})).to_f64()) },
		rt.ArrayItem{ key: 'free_shipping', val: rt.call_method(var_coupon, 'get_free_shipping',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'meta_data', val: this.prepare_meta_data(var_order_item.clone()) },
	])
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema {
	rt.PhpObjectBase
}

struct Class_WC_Coupon {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_orders_schema_ordercouponschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderCouponSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderCouponSchema{
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

fn create_wc_coupon(_args ...rt.PhpVal) &Class_WC_Coupon {
	mut obj := &Class_WC_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderCouponSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderCouponSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderCouponSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
