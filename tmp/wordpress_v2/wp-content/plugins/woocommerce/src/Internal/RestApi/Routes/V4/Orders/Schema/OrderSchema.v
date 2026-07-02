import rt

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.identifier() string {
	return 'order'
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema {
	rt.PhpObjectBase
pub mut:
	order_item_schema     rt.PhpVal = rt.new_null()
	order_coupon_schema   rt.PhpVal = rt.new_null()
	order_fee_schema      rt.PhpVal = rt.new_null()
	order_tax_schema      rt.PhpVal = rt.new_null()
	order_shipping_schema rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema) init(mut var_order_item_schema Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema, mut var_order_coupon_schema Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderCouponSchema, mut var_order_fee_schema Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderFeeSchema, mut var_order_tax_schema Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderTaxSchema, mut var_order_shipping_schema Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderShippingSchema) {
	this.order_item_schema = var_order_item_schema
	this.order_coupon_schema = var_order_coupon_schema
	this.order_fee_schema = var_order_fee_schema
	this.order_tax_schema = var_order_tax_schema
	this.order_shipping_schema = var_order_shipping_schema
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema) get_item_schema_properties() rt.PhpVal {
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Unique identifier for the resource.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'parent_id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Parent order ID.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
		]) },
		rt.ArrayItem{ key: 'number', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Order number.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'order_key', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Order key.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'created_via', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Shows where the order was created.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
		]) },
		rt.ArrayItem{ key: 'version', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Version of WooCommerce which last updated the order.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'status', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Order status.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'default'
				val: Class_Automattic_WooCommerce_Enums_OrderStatus.pending()
			},
			rt.ArrayItem{ key: 'enum', val: rt.call_function('array_map', [
				rt.new_string(
					(Class_Automattic_WooCommerce_Utilities_OrderUtil.class()).str() + '::remove_status_prefix'),
				rt.call_function('array_merge', [
					rt.create_array([
						rt.ArrayItem{
							key: none
							val: Class_Automattic_WooCommerce_Enums_OrderStatus.auto_draft()
						},
					]),
					rt.func_array_keys(rt.call_function('wc_get_order_statuses', []rt.PhpVal{})),
				]),
			]) },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
		]) },
		rt.ArrayItem{ key: 'currency', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Currency the order was created with, in ISO format.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'default', val: rt.call_function('get_woocommerce_currency',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'enum', val: rt.func_array_keys(rt.call_function('get_woocommerce_currencies',
				[]rt.PhpVal{})) },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'currency_symbol', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Currency symbol for the currency which can be used to format returned prices.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'date_created', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string("The date the order was created, in the site's timezone."),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'format', val: 'date-time' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'date_created_gmt', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The date the order was created, as GMT.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'format', val: 'date-time' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'date_modified', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string("The date the order was last modified, in the site's timezone."),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'format', val: 'date-time' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'date_modified_gmt', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The date the order was last modified, as GMT.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'format', val: 'date-time' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'discount_total', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Total discount amount for the order.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'discount_tax', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Total discount tax amount for the order.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'shipping_total', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Total shipping amount for the order.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'shipping_tax', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Total shipping tax amount for the order.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'cart_tax', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Sum of line item taxes only.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'total', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Grand total.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'total_tax', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Sum of all taxes.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'refund_total', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Total refund amount for the order.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'refund_tax', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Total refund tax amount for the order.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'prices_include_tax', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('True the prices included tax during checkout.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'boolean' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'customer_id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('User ID who owns the order. 0 for guests.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'default', val: 0 },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
		]) },
		rt.ArrayItem{ key: 'customer_ip_address', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string("Customer's IP address."),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'customer_user_agent', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('User agent of the customer.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'customer_note', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Note left by customer during checkout.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
		]) },
		rt.ArrayItem{ key: 'billing', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Billing address.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'properties', val: rt.create_array([
				rt.ArrayItem{ key: 'first_name', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('First name.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
					},
				]) },
				rt.ArrayItem{ key: 'last_name', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Last name.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
					},
				]) },
				rt.ArrayItem{ key: 'company', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Company name.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
					},
				]) },
				rt.ArrayItem{ key: 'address_1', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Address line 1'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
					},
				]) },
				rt.ArrayItem{ key: 'address_2', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Address line 2'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
					},
				]) },
				rt.ArrayItem{ key: 'city', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('City name.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
					},
				]) },
				rt.ArrayItem{ key: 'state', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('ISO code or name of the state, province or district.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
					},
				]) },
				rt.ArrayItem{ key: 'postcode', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Postal code.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
					},
				]) },
				rt.ArrayItem{ key: 'country', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Country code in ISO 3166-1 alpha-2 format.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
					},
				]) },
				rt.ArrayItem{ key: 'email', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Email address.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'string' },
						rt.ArrayItem{ key: none, val: 'null' },
					]) },
					rt.ArrayItem{ key: 'format', val: 'email' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
					},
				]) },
				rt.ArrayItem{ key: 'phone', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Phone number.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
					},
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'shipping', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Shipping address.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'properties', val: rt.create_array([
				rt.ArrayItem{ key: 'first_name', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('First name.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
					},
				]) },
				rt.ArrayItem{ key: 'last_name', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Last name.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
					},
				]) },
				rt.ArrayItem{ key: 'company', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Company name.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
					},
				]) },
				rt.ArrayItem{ key: 'address_1', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Address line 1'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
					},
				]) },
				rt.ArrayItem{ key: 'address_2', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Address line 2'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
					},
				]) },
				rt.ArrayItem{ key: 'city', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('City name.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
					},
				]) },
				rt.ArrayItem{ key: 'state', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('ISO code or name of the state, province or district.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
					},
				]) },
				rt.ArrayItem{ key: 'postcode', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Postal code.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
					},
				]) },
				rt.ArrayItem{ key: 'country', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Country code in ISO 3166-1 alpha-2 format.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
					},
				]) },
				rt.ArrayItem{ key: 'phone', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Phone number.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
					},
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'payment_method', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Payment method ID.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
		]) },
		rt.ArrayItem{ key: 'payment_method_title', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Payment method title.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
				rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
			]) },
		]) },
		rt.ArrayItem{ key: 'transaction_id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Unique transaction ID.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
		]) },
		rt.ArrayItem{ key: 'date_paid', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string("The date the order was paid, in the site's timezone."),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'format', val: 'date-time' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'date_paid_gmt', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The date the order was paid, as GMT.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'format', val: 'date-time' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'date_completed', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string("The date the order was completed, in the site's timezone."),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'format', val: 'date-time' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'date_completed_gmt', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The date the order was completed, as GMT.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'format', val: 'date-time' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'cart_hash', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('MD5 hash of cart items to ensure orders are not modified.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'meta_data', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Meta data.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Meta ID.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'integer' },
						rt.ArrayItem{
							key: 'context'
							val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
						},
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'key', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Meta key.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{
							key: 'context'
							val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
						},
					]) },
					rt.ArrayItem{ key: 'value', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Meta value.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'null' },
							rt.ArrayItem{ key: none, val: 'object' },
							rt.ArrayItem{ key: none, val: 'string' },
							rt.ArrayItem{ key: none, val: 'number' },
							rt.ArrayItem{ key: none, val: 'boolean' },
							rt.ArrayItem{ key: none, val: 'integer' },
							rt.ArrayItem{ key: none, val: 'array' },
						]) },
						rt.ArrayItem{
							key: 'context'
							val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
						},
					]) },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'line_items', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('A list of line items (products) within this order.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: rt.call_method(this.order_item_schema,
					'get_item_schema_properties', []rt.PhpVal{}) },
			]) },
		]) },
		rt.ArrayItem{ key: 'tax_lines', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Tax lines data.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: rt.call_method(this.order_tax_schema,
					'get_item_schema_properties', []rt.PhpVal{}) },
			]) },
		]) },
		rt.ArrayItem{ key: 'shipping_lines', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Shipping lines data.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: rt.call_method(this.order_shipping_schema,
					'get_item_schema_properties', []rt.PhpVal{}) },
			]) },
		]) },
		rt.ArrayItem{ key: 'fee_lines', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Fee lines data.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: rt.call_method(this.order_fee_schema,
					'get_item_schema_properties', []rt.PhpVal{}) },
			]) },
		]) },
		rt.ArrayItem{ key: 'coupon_lines', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Coupons line data.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: rt.call_method(this.order_coupon_schema,
					'get_item_schema_properties', []rt.PhpVal{}) },
			]) },
		]) },
		rt.ArrayItem{ key: 'payment_url', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Order payment URL.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'is_editable', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Whether an order can be edited.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'boolean' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'needs_payment', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Whether an order needs payment, based on status and order total.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'boolean' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'needs_processing', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Whether an order needs processing before it can be completed.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'boolean' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'fulfillment_status', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The fulfillment status of the order.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
	])
	if rt.is_true(this.cogs_is_enabled()) {
		var_schema =
			this.add_cogs_related_schema(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_array](var_schema))
	}
	return var_schema.clone()
}

fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.add_cogs_related_schema(mut var_schema Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_array) rt.PhpVal {
	mut var_schema_mutated := var_schema
	var_schema_mutated.array_set('cost_of_goods_sold', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Cost of Goods Sold data.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{
			key: 'context'
			val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
		},
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'total_value', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Total value of the Cost of Goods Sold for the order.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'number' },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{
					key: 'context'
					val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.view_edit_embed_context()
				},
			]) },
		]) },
	]))
	return rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_array',
		[]string{}, var_schema_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema) get_item_response(var_order rt.PhpVal, mut var_request Class_WP_REST_Request, mut var_include_fields Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_array) rt.PhpVal {
	mut var_dp := if var_request.array_get(rt.new_string('num_decimals')).is_null() { rt.call_function('wc_get_price_decimals', []rt.PhpVal{}) } else { rt.call_function('absint', [
			var_request.array_get(rt.new_string('num_decimals')),
		]) }
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_0 := iife_temp_0.remove_status_prefix(rt.call_method(var_order, 'get_status',
		[]rt.PhpVal{}))
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
	mut iife_result_1 := iife_temp_1.get_order_fulfillment_status(var_order.clone())
	mut var_data := rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.call_method(var_order, 'get_id', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'parent_id', val: rt.call_method(var_order, 'get_parent_id',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'number', val: rt.call_method(var_order, 'get_order_number',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'order_key', val: rt.call_method(var_order, 'get_order_key',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'created_via', val: rt.call_method(var_order, 'get_created_via',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'version', val: rt.call_method(var_order, 'get_version', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'status', val: iife_result_0 },
		rt.ArrayItem{ key: 'currency', val: rt.call_method(var_order, 'get_currency', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'currency_symbol', val: rt.call_function('html_entity_decode', [
			rt.call_function('get_woocommerce_currency_symbol', [
				rt.call_method(var_order, 'get_currency', []rt.PhpVal{}),
			]),
			rt.get_constant('ENT_QUOTES'),
		]) },
		rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [
			rt.call_method(var_order, 'get_date_created', []rt.PhpVal{}),
			rt.new_bool(false),
		]) },
		rt.ArrayItem{ key: 'date_created_gmt', val: rt.call_function('wc_rest_prepare_date_response', [
			rt.call_method(var_order, 'get_date_created', []rt.PhpVal{}),
		]) },
		rt.ArrayItem{ key: 'date_modified', val: rt.call_function('wc_rest_prepare_date_response', [
			rt.call_method(var_order, 'get_date_modified', []rt.PhpVal{}),
			rt.new_bool(false),
		]) },
		rt.ArrayItem{ key: 'date_modified_gmt', val: rt.call_function('wc_rest_prepare_date_response', [
			rt.call_method(var_order, 'get_date_modified', []rt.PhpVal{}),
		]) },
		rt.ArrayItem{ key: 'discount_total', val: rt.call_function('wc_format_decimal', [
			rt.call_method(var_order, 'get_discount_total', []rt.PhpVal{}),
			var_dp.clone(),
		]) },
		rt.ArrayItem{ key: 'discount_tax', val: rt.call_function('wc_format_decimal', [
			rt.call_method(var_order, 'get_discount_tax', []rt.PhpVal{}),
			var_dp.clone(),
		]) },
		rt.ArrayItem{ key: 'shipping_total', val: rt.call_function('wc_format_decimal', [
			rt.call_method(var_order, 'get_shipping_total', []rt.PhpVal{}),
			var_dp.clone(),
		]) },
		rt.ArrayItem{ key: 'shipping_tax', val: rt.call_function('wc_format_decimal', [
			rt.call_method(var_order, 'get_shipping_tax', []rt.PhpVal{}),
			var_dp.clone(),
		]) },
		rt.ArrayItem{ key: 'cart_tax', val: rt.call_function('wc_format_decimal', [
			rt.call_method(var_order, 'get_cart_tax', []rt.PhpVal{}),
			var_dp.clone(),
		]) },
		rt.ArrayItem{ key: 'total', val: rt.call_function('wc_format_decimal', [
			rt.call_method(var_order, 'get_total', []rt.PhpVal{}),
			var_dp.clone(),
		]) },
		rt.ArrayItem{ key: 'total_tax', val: rt.call_function('wc_format_decimal', [
			rt.call_method(var_order, 'get_total_tax', []rt.PhpVal{}),
			var_dp.clone(),
		]) },
		rt.ArrayItem{ key: 'prices_include_tax', val: rt.call_method(var_order,
			'get_prices_include_tax', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'customer_id', val: rt.call_method(var_order, 'get_customer_id',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'customer_ip_address', val: rt.call_method(var_order,
			'get_customer_ip_address', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'customer_user_agent', val: rt.call_method(var_order,
			'get_customer_user_agent', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'customer_note', val: rt.call_method(var_order, 'get_customer_note',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'billing', val: rt.create_array([
			rt.ArrayItem{ key: 'first_name', val: rt.call_method(var_order,
				'get_billing_first_name', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'last_name', val: rt.call_method(var_order, 'get_billing_last_name',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'company', val: rt.call_method(var_order, 'get_billing_company',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'address_1', val: rt.call_method(var_order, 'get_billing_address_1',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'address_2', val: rt.call_method(var_order, 'get_billing_address_2',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'city', val: rt.call_method(var_order, 'get_billing_city',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'state', val: rt.call_method(var_order, 'get_billing_state',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'postcode', val: rt.call_method(var_order, 'get_billing_postcode',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'country', val: rt.call_method(var_order, 'get_billing_country',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'email', val: rt.call_method(var_order, 'get_billing_email',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'phone', val: rt.call_method(var_order, 'get_billing_phone',
				[]rt.PhpVal{}) },
		]) },
		rt.ArrayItem{ key: 'shipping', val: rt.create_array([
			rt.ArrayItem{ key: 'first_name', val: rt.call_method(var_order,
				'get_shipping_first_name', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'last_name', val: rt.call_method(var_order,
				'get_shipping_last_name', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'company', val: rt.call_method(var_order, 'get_shipping_company',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'address_1', val: rt.call_method(var_order,
				'get_shipping_address_1', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'address_2', val: rt.call_method(var_order,
				'get_shipping_address_2', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'city', val: rt.call_method(var_order, 'get_shipping_city',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'state', val: rt.call_method(var_order, 'get_shipping_state',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'postcode', val: rt.call_method(var_order, 'get_shipping_postcode',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'country', val: rt.call_method(var_order, 'get_shipping_country',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'phone', val: rt.call_method(var_order, 'get_shipping_phone',
				[]rt.PhpVal{}) },
		]) },
		rt.ArrayItem{ key: 'payment_method', val: rt.call_method(var_order, 'get_payment_method',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'payment_method_title', val: rt.call_method(var_order,
			'get_payment_method_title', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'transaction_id', val: rt.call_method(var_order, 'get_transaction_id',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'date_paid', val: rt.call_function('wc_rest_prepare_date_response', [
			rt.call_method(var_order, 'get_date_paid', []rt.PhpVal{}),
			rt.new_bool(false),
		]) },
		rt.ArrayItem{ key: 'date_paid_gmt', val: rt.call_function('wc_rest_prepare_date_response', [
			rt.call_method(var_order, 'get_date_paid', []rt.PhpVal{}),
		]) },
		rt.ArrayItem{ key: 'date_completed', val: rt.call_function('wc_rest_prepare_date_response', [
			rt.call_method(var_order, 'get_date_completed', []rt.PhpVal{}),
			rt.new_bool(false),
		]) },
		rt.ArrayItem{ key: 'date_completed_gmt', val: rt.call_function('wc_rest_prepare_date_response', [
			rt.call_method(var_order, 'get_date_completed', []rt.PhpVal{}),
		]) },
		rt.ArrayItem{ key: 'cart_hash', val: rt.call_method(var_order, 'get_cart_hash',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'payment_url', val: rt.call_method(var_order,
			'get_checkout_payment_url', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'is_editable', val: rt.call_method(var_order, 'is_editable',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'needs_payment', val: rt.call_method(var_order, 'needs_payment',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'needs_processing', val: rt.call_method(var_order, 'needs_processing',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'fulfillment_status', val: iife_result_1 },
	])
	if rt.is_true(rt.call_function('in_array', [rt.new_string('refund_total'), var_include_fields,
		rt.new_bool(true)]))
	{
		var_data.array_set('refund_total', rt.call_function('wc_format_decimal', [
			rt.call_method(var_order, 'get_total_refunded', []rt.PhpVal{}),
			var_dp.clone(),
		]))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('refund_tax'), var_include_fields,
		rt.new_bool(true)]))
	{
		var_data.array_set('refund_tax', rt.call_function('wc_format_decimal', [
			rt.call_method(var_order, 'get_total_tax_refunded', []rt.PhpVal{}),
			var_dp.clone(),
		]))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('line_items'), var_include_fields,
		rt.new_bool(true)]))
	{
		mut var_line_items := rt.call_method(var_order, 'get_items', [
			Class_Automattic_WooCommerce_Enums_OrderItemType.line_item(),
		])
		var_data.array_set('line_items', rt.new_array())
		mut iter_1 := var_line_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_line_item := item_1.val
			var_data.array_get_mut('line_items').array_push(rt.call_method(this.order_item_schema,
				'get_item_response', [var_line_item.clone(), var_request]))
		}
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('shipping_lines'), var_include_fields,
		rt.new_bool(true)]))
	{
		var_line_items = rt.call_method(var_order, 'get_items', [
			Class_Automattic_WooCommerce_Enums_OrderItemType.shipping(),
		])
		var_data.array_set('shipping_lines', rt.new_array())
		mut iter_2 := var_line_items.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_line_item := item_2.val
			var_data.array_get_mut('shipping_lines').array_push(rt.call_method(this.order_shipping_schema,
				'get_item_response', [var_line_item.clone(), var_request]))
		}
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('coupon_lines'), var_include_fields,
		rt.new_bool(true)]))
	{
		var_line_items = rt.call_method(var_order, 'get_items', [
			Class_Automattic_WooCommerce_Enums_OrderItemType.coupon(),
		])
		var_data.array_set('coupon_lines', rt.new_array())
		mut iter_3 := var_line_items.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_line_item := item_3.val
			var_data.array_get_mut('coupon_lines').array_push(rt.call_method(this.order_coupon_schema,
				'get_item_response', [var_line_item.clone(), var_request]))
		}
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('fee_lines'), var_include_fields,
		rt.new_bool(true)]))
	{
		var_line_items = rt.call_method(var_order, 'get_items', [
			Class_Automattic_WooCommerce_Enums_OrderItemType.fee(),
		])
		var_data.array_set('fee_lines', rt.new_array())
		mut iter_4 := var_line_items.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_line_item := item_4.val
			var_data.array_get_mut('fee_lines').array_push(rt.call_method(this.order_fee_schema,
				'get_item_response', [var_line_item.clone(), var_request]))
		}
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('tax_lines'), var_include_fields,
		rt.new_bool(true)]))
	{
		var_line_items = rt.call_method(var_order, 'get_items', [
			Class_Automattic_WooCommerce_Enums_OrderItemType.tax(),
		])
		var_data.array_set('tax_lines', rt.new_array())
		mut iter_5 := var_line_items.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_line_item := item_5.val
			var_data.array_get_mut('tax_lines').array_push(rt.call_method(this.order_tax_schema,
				'get_item_response', [var_line_item.clone(), var_request]))
		}
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('meta_data'), var_include_fields,
		rt.new_bool(true)]))
	{
		mut var_filtered_meta_data := this.filter_internal_meta_keys(rt.call_method(var_order,
			'get_meta_data', []rt.PhpVal{}))
		var_data.array_set('meta_data', rt.new_array())
		mut iter_6 := var_filtered_meta_data.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_meta_item := item_6.val
			var_data.array_get_mut('meta_data').array_push(rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.get_property(var_meta_item, 'id') },
				rt.ArrayItem{ key: 'key', val: rt.get_property(var_meta_item, 'key') },
				rt.ArrayItem{ key: 'value', val: rt.get_property(var_meta_item, 'value') },
			]))
		}
	}
	if rt.is_true(this.cogs_is_enabled())
		&& rt.is_true(rt.call_function('in_array', [rt.new_string('cost_of_goods_sold'), var_include_fields, rt.new_bool(true)])) {
		var_data.array_get_mut('cost_of_goods_sold').array_set('total_value', rt.call_method(var_order,
			'get_cogs_total_value', []rt.PhpVal{}))
	}
	var_data = rt.call_function('array_intersect_key', [var_data.clone(),
		rt.call_function('array_flip', [var_include_fields])])
	return var_data.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema) filter_internal_meta_keys(var_meta_data rt.PhpVal) rt.PhpVal {
	mut var_meta_data_mutated := var_meta_data
	mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_2 := iife_temp_2.custom_orders_table_usage_is_enabled()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_2)))) {
		return var_meta_data_mutated.clone()
	}
	mut var_cpt_hidden_keys := rt.call_method(create_automattic_woocommerce_internal_restapi_routes_v4_orders_schema_wc_order_data_store_cpt(),
		'get_internal_meta_keys', []rt.PhpVal{})
	closure_4_fn := fn [var_cpt_hidden_keys] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_meta := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			rt.get_property(var_meta, 'key'),
			var_cpt_hidden_keys.clone(),
			rt.new_bool(true),
		]))))
	}
	var_meta_data_mutated = rt.call_function('array_filter', [
		var_meta_data_mutated.clone(), rt.new_closure(closure_4_fn)])
	return rt.call_function('array_values', [var_meta_data_mutated.clone()])
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_WC_Order_Data_Store_CPT {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_orders_schema_orderschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema{
		PhpObjectBase:         rt.PhpObjectBase{}
		order_item_schema:     rt.new_null()
		order_coupon_schema:   rt.new_null()
		order_fee_schema:      rt.new_null()
		order_tax_schema:      rt.new_null()
		order_shipping_schema: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_abstractschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_orders_schema_wc_order_data_store_cpt(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_WC_Order_Data_Store_CPT {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_WC_Order_Data_Store_CPT{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderItemSchema](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderCouponSchema](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderFeeSchema](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderTaxSchema](if args.len > 3 {
				args[3]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderShippingSchema](if args.len > 4 {
				args[4]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut
				dispatch_arg_3, mut dispatch_arg_4)
			return rt.new_null()
		}
		'get_item_schema_properties' {
			return this.get_item_schema_properties()
		}
		'add_cogs_related_schema' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema.add_cogs_related_schema(mut dispatch_arg_0)
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
		'filter_internal_meta_keys' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_internal_meta_keys(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'order_item_schema' { return this.order_item_schema }
		'order_coupon_schema' { return this.order_coupon_schema }
		'order_fee_schema' { return this.order_fee_schema }
		'order_tax_schema' { return this.order_tax_schema }
		'order_shipping_schema' { return this.order_shipping_schema }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'order_item_schema' {
			this.order_item_schema = val
			return true
		}
		'order_coupon_schema' {
			this.order_coupon_schema = val
			return true
		}
		'order_fee_schema' {
			this.order_fee_schema = val
			return true
		}
		'order_tax_schema' {
			this.order_tax_schema = val
			return true
		}
		'order_shipping_schema' {
			this.order_shipping_schema = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_WC_Order_Data_Store_CPT) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_WC_Order_Data_Store_CPT) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_WC_Order_Data_Store_CPT) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
