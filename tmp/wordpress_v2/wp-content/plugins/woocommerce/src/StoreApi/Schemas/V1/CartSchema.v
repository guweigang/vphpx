import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema.identifier() string {
	return 'cart'
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema {
	rt.PhpObjectBase
pub mut:
	title                   rt.PhpVal = rt.new_string('cart')
	item_schema             rt.PhpVal = rt.new_null()
	coupon_schema           rt.PhpVal = rt.new_null()
	cross_sells_item_schema rt.PhpVal = rt.new_null()
	fee_schema              rt.PhpVal = rt.new_null()
	shipping_rate_schema    rt.PhpVal = rt.new_null()
	shipping_address_schema rt.PhpVal = rt.new_null()
	billing_address_schema  rt.PhpVal = rt.new_null()
	error_schema            rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema) construct(mut var_extend Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema, mut var_controller Class_Automattic_WooCommerce_StoreApi_SchemaController) {
	mut var_controller_mutated := var_controller
	this.Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema.construct(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema',
		[]string{}, var_extend), rt.new_object('Automattic_WooCommerce_StoreApi_SchemaController',
		[]string{}, var_controller_mutated))
	this.item_schema = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema', [
		'Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema',
	], &this), 'controller'), 'get', [
		Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartItemSchema.identifier(),
	])
	this.cross_sells_item_schema = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema', [
		'Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema',
	], &this), 'controller'), 'get', [
		Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema.identifier(),
	])
	this.coupon_schema = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema', [
		'Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema',
	], &this), 'controller'), 'get', [
		Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartCouponSchema.identifier(),
	])
	this.fee_schema = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema', [
		'Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema',
	], &this), 'controller'), 'get', [
		Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartFeeSchema.identifier(),
	])
	this.shipping_rate_schema = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema', [
		'Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema',
	], &this), 'controller'), 'get', [
		Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartShippingRateSchema.identifier(),
	])
	this.shipping_address_schema = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema', [
		'Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema',
	], &this), 'controller'), 'get', [
		Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ShippingAddressSchema.identifier(),
	])
	this.billing_address_schema = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema', [
		'Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema',
	], &this), 'controller'), 'get', [
		Class_Automattic_WooCommerce_StoreApi_Schemas_V1_BillingAddressSchema.identifier(),
	])
	this.error_schema = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema', [
		'Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema',
	], &this), 'controller'), 'get', [
		Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ErrorSchema.identifier(),
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema) get_properties() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'coupons', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('List of applied cart coupons.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: this.force_schema_readonly(rt.call_method(this.coupon_schema,
					'get_properties', []rt.PhpVal{})) },
			]) },
		]) },
		rt.ArrayItem{ key: 'shipping_rates', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('List of available shipping rates for the cart.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: this.force_schema_readonly(rt.call_method(this.shipping_rate_schema,
					'get_properties', []rt.PhpVal{})) },
			]) },
		]) },
		rt.ArrayItem{ key: 'shipping_address', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Current set shipping address for the customer.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'properties', val: this.force_schema_readonly(rt.call_method(this.shipping_address_schema,
				'get_properties', []rt.PhpVal{})) },
		]) },
		rt.ArrayItem{ key: 'billing_address', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Current set billing address for the customer.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'properties', val: this.force_schema_readonly(rt.call_method(this.billing_address_schema,
				'get_properties', []rt.PhpVal{})) },
		]) },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('List of cart items.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: this.force_schema_readonly(rt.call_method(this.item_schema,
					'get_properties', []rt.PhpVal{})) },
			]) },
		]) },
		rt.ArrayItem{ key: 'items_count', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Number of items in the cart.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'items_weight', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Total weight (in grams) of all products in the cart.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'number' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'cross_sells', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('List of cross-sells items related to cart items.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: this.force_schema_readonly(rt.call_method(this.cross_sells_item_schema,
					'get_properties', []rt.PhpVal{})) },
			]) },
		]) },
		rt.ArrayItem{ key: 'needs_payment', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('True if the cart needs payment. False for carts with only free products and no shipping costs.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'boolean' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'needs_shipping', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('True if the cart needs shipping. False for carts with only digital goods or stores with no shipping methods set-up.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'boolean' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'has_calculated_shipping', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('True if the cart meets the criteria for showing shipping costs, and rates have been calculated and included in the totals.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'boolean' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'fees', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('List of cart fees.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: this.force_schema_readonly(rt.call_method(this.fee_schema,
					'get_properties', []rt.PhpVal{})) },
			]) },
		]) },
		rt.ArrayItem{ key: 'totals', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Cart total amounts provided using the smallest unit of the currency.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'properties', val: rt.call_function('array_merge', [
				this.get_store_currency_properties(),
				rt.create_array([
					rt.ArrayItem{ key: 'total_items', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Total price of items in the cart.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'total_items_tax', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Total tax on items in the cart.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'total_fees', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Total price of any applied fees.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'total_fees_tax', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Total tax on fees.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'total_discount', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Total discount from applied coupons.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'total_discount_tax', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Total tax removed due to discount from applied coupons.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'total_shipping', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Total price of shipping. If shipping has not been calculated, a null response will be sent.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'string' },
							rt.ArrayItem{ key: none, val: 'null' },
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'total_shipping_tax', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Total tax on shipping. If shipping has not been calculated, a null response will be sent.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'string' },
							rt.ArrayItem{ key: none, val: 'null' },
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'total_price', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Total price the customer will pay.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'total_tax', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Total tax applied to items and shipping.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'tax_lines', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Lines of taxes applied to items and shipping.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'array' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
						rt.ArrayItem{ key: 'items', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'object' },
							rt.ArrayItem{ key: 'properties', val: rt.create_array([
								rt.ArrayItem{ key: 'name', val: rt.create_array([
									rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
										rt.new_string('The name of the tax.'),
										rt.new_string('woocommerce'),
									]) },
									rt.ArrayItem{ key: 'type', val: 'string' },
									rt.ArrayItem{ key: 'context', val: rt.create_array([
										rt.ArrayItem{ key: none, val: 'view' },
										rt.ArrayItem{ key: none, val: 'edit' },
									]) },
									rt.ArrayItem{ key: 'readonly', val: true },
								]) },
								rt.ArrayItem{ key: 'price', val: rt.create_array([
									rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
										rt.new_string('The amount of tax charged.'),
										rt.new_string('woocommerce'),
									]) },
									rt.ArrayItem{ key: 'type', val: 'string' },
									rt.ArrayItem{ key: 'context', val: rt.create_array([
										rt.ArrayItem{ key: none, val: 'view' },
										rt.ArrayItem{ key: none, val: 'edit' },
									]) },
									rt.ArrayItem{ key: 'readonly', val: true },
								]) },
								rt.ArrayItem{ key: 'rate', val: rt.create_array([
									rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
										rt.new_string('The rate at which tax is applied.'),
										rt.new_string('woocommerce'),
									]) },
									rt.ArrayItem{ key: 'type', val: 'string' },
									rt.ArrayItem{ key: 'context', val: rt.create_array([
										rt.ArrayItem{ key: none, val: 'view' },
										rt.ArrayItem{ key: none, val: 'edit' },
									]) },
									rt.ArrayItem{ key: 'readonly', val: true },
								]) },
							]) },
						]) },
					]) },
				]),
			]) },
		]) },
		rt.ArrayItem{ key: 'errors', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('List of cart item errors, for example, items in the cart which are out of stock.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: this.force_schema_readonly(rt.call_method(this.error_schema,
					'get_properties', []rt.PhpVal{})) },
			]) },
		]) },
		rt.ArrayItem{ key: 'payment_methods', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('List of available payment method IDs that can be used to process the order.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'payment_requirements', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('List of required payment gateway features to process the order.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema.extending_key()
			val: this.get_extended_schema(Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema.identifier())
		},
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema) get_item_response(var_cart rt.PhpVal) rt.PhpVal {
	mut var_product := rt.new_null()
	mut var_item := rt.new_null()
	mut var_controller := create_automattic_woocommerce_storeapi_utilities_cartcontroller()
	mut var_cart_errors := this.get_cart_errors(var_cart.clone())
	mut var_shipping_packages := if rt.is_true(rt.call_method(var_cart, 'has_calculated_shipping',
		[]rt.PhpVal{}))
	{
		var_controller.get_shipping_packages()
	} else {
		rt.new_array()
	}
	mut var_cross_sells := rt.new_array()
	mut var_cross_sell_ids := rt.call_method(var_cart, 'get_cross_sells', []rt.PhpVal{})
	mut var_image_ids := rt.new_array()
	if !(!rt.is_true(var_cross_sell_ids)) {
		rt.call_function('_prime_post_caches', [var_cross_sell_ids.clone()])
		var_cross_sells = rt.call_function('array_values', [
			rt.call_function('array_filter', [
				rt.call_function('array_map', [rt.new_string('wc_get_product'),
					var_cross_sell_ids.clone()]),
				rt.new_string('wc_products_array_filter_visible'),
			]),
		])
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_int((rt.call_method(var_product,
					'get_image_id', []rt.PhpVal{})).to_i64()) },
				rt.ArrayItem{ key: none, val: rt.call_method(var_product, 'get_gallery_image_ids',
					[]rt.PhpVal{}) },
			])
		}
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_int((rt.call_method(var_product,
					'get_image_id', []rt.PhpVal{})).to_i64()) },
				rt.ArrayItem{ key: none, val: rt.call_method(var_product, 'get_gallery_image_ids',
					[]rt.PhpVal{}) },
			])
		}
		mut var_ids := rt.call_function('array_map', [rt.new_closure(closure_1_fn),
			var_cross_sells.clone()])
		var_image_ids.array_push(rt.call_function('array_values', [
			rt.call_function('array_filter', [
				rt.call_function('array_merge', [var_ids.clone()]),
			]),
		]))
	}
	mut var_cart_all_items := rt.call_method(var_cart, 'get_cart', []rt.PhpVal{})
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(rt.instance_of(if !(var_item.array_get(rt.new_string('data'))).is_null() {
			var_item.array_get(rt.new_string('data'))
		} else {
			rt.new_null()
		}, 'Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product'))
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(rt.instance_of(if !(var_item.array_get(rt.new_string('data'))).is_null() {
			var_item.array_get(rt.new_string('data'))
		} else {
			rt.new_null()
		}, 'Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product'))
	}
	mut var_cart_line_items := rt.call_function('array_values', [
		rt.call_function('array_filter', [var_cart_all_items.clone(),
			rt.new_closure(closure_3_fn)]),
	])
	if !(!rt.is_true(var_cart_line_items)) {
		closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_int((rt.call_method(var_item.array_get(rt.new_string('data')),
					'get_image_id', []rt.PhpVal{})).to_i64()) },
				rt.ArrayItem{ key: none, val: rt.call_method(var_item.array_get(rt.new_string('data')),
					'get_gallery_image_ids', []rt.PhpVal{}) },
			])
		}
		closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_int((rt.call_method(var_item.array_get(rt.new_string('data')),
					'get_image_id', []rt.PhpVal{})).to_i64()) },
				rt.ArrayItem{ key: none, val: rt.call_method(var_item.array_get(rt.new_string('data')),
					'get_gallery_image_ids', []rt.PhpVal{}) },
			])
		}
		var_ids = rt.call_function('array_map', [rt.new_closure(closure_5_fn),
			var_cart_line_items.clone()])
		var_image_ids.array_push(rt.call_function('array_values', [
			rt.call_function('array_filter', [
				rt.call_function('array_merge', [
					rt.call_function('array_values', [var_ids.clone()]),
				]),
			]),
		]))
	}
	if !(!rt.is_true(var_image_ids)) {
		rt.call_function('_prime_post_caches', [
			rt.call_function('array_unique', [
				rt.call_function('array_merge', [var_image_ids.clone()]),
			]),
		])
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'items', val: this.get_item_responses_from_schema(this.item_schema,
			var_cart_all_items.clone()) },
		rt.ArrayItem{ key: 'coupons', val: this.get_item_responses_from_schema(this.coupon_schema, rt.call_method(var_cart,
			'get_applied_coupons', []rt.PhpVal{})) },
		rt.ArrayItem{ key: 'fees', val: this.get_item_responses_from_schema(this.fee_schema, rt.call_method(var_cart,
			'get_fees', []rt.PhpVal{})) },
		rt.ArrayItem{
			key: 'totals'
			val: rt.array_to_object(this.prepare_currency_response(this.get_totals(var_cart.clone())))
		},
		rt.ArrayItem{ key: 'shipping_address', val: rt.array_to_object(rt.call_method(this.shipping_address_schema,
			'get_item_response', [
			rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'customer'),
		])) },
		rt.ArrayItem{ key: 'billing_address', val: rt.array_to_object(rt.call_method(this.billing_address_schema,
			'get_item_response', [
			rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'customer'),
		])) },
		rt.ArrayItem{ key: 'needs_payment', val: rt.call_method(var_cart, 'needs_payment',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'needs_shipping', val: rt.call_method(var_cart, 'needs_shipping',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'payment_requirements', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema', [
			'Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema',
		], &this), 'extend'), 'get_payment_requirements', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'has_calculated_shipping', val: rt.call_method(var_cart,
			'has_calculated_shipping', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'shipping_rates', val: this.get_item_responses_from_schema(this.shipping_rate_schema,
			var_shipping_packages.clone()) },
		rt.ArrayItem{ key: 'items_count', val: rt.call_method(var_cart, 'get_cart_contents_count',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'items_weight', val: rt.call_function('wc_get_weight', [
			rt.call_method(var_cart, 'get_cart_contents_weight', []rt.PhpVal{}),
			rt.new_string('g'),
		]) },
		rt.ArrayItem{ key: 'cross_sells', val: this.get_item_responses_from_schema(this.cross_sells_item_schema,
			var_cross_sells.clone()) },
		rt.ArrayItem{ key: 'errors', val: var_cart_errors },
		rt.ArrayItem{ key: 'payment_methods', val: rt.call_function('array_values', [
			rt.call_function('wp_list_pluck', [
				rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
					'payment_gateways'), 'get_available_payment_gateways', []rt.PhpVal{}),
				rt.new_string('id'),
			]),
		]) },
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema.extending_key()
			val: this.get_extended_data(Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema.identifier())
		},
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema) get_totals(var_cart rt.PhpVal) rt.PhpVal {
	mut var_decimals := rt.call_function('wc_get_price_decimals', []rt.PhpVal{})
	return rt.create_array([
		rt.ArrayItem{ key: 'total_items', val: this.prepare_money_response(rt.call_method(var_cart,
			'get_subtotal', []rt.PhpVal{}), var_decimals.clone()) },
		rt.ArrayItem{ key: 'total_items_tax', val: this.prepare_money_response(rt.call_method(var_cart,
			'get_subtotal_tax', []rt.PhpVal{}), var_decimals.clone()) },
		rt.ArrayItem{ key: 'total_fees', val: this.prepare_money_response(rt.call_method(var_cart,
			'get_fee_total', []rt.PhpVal{}), var_decimals.clone()) },
		rt.ArrayItem{ key: 'total_fees_tax', val: this.prepare_money_response(rt.call_method(var_cart,
			'get_fee_tax', []rt.PhpVal{}), var_decimals.clone()) },
		rt.ArrayItem{ key: 'total_discount', val: this.prepare_money_response(rt.call_method(var_cart,
			'get_discount_total', []rt.PhpVal{}), var_decimals.clone()) },
		rt.ArrayItem{ key: 'total_discount_tax', val: this.prepare_money_response(rt.call_method(var_cart,
			'get_discount_tax', []rt.PhpVal{}), var_decimals.clone()) },
		rt.ArrayItem{
			key: 'total_shipping'
			val: if rt.is_true(rt.call_method(var_cart, 'has_calculated_shipping', []rt.PhpVal{})) {
				this.prepare_money_response(rt.call_method(var_cart, 'get_shipping_total',
					[]rt.PhpVal{}), var_decimals.clone())
			} else {
				rt.new_null()
			}
		},
		rt.ArrayItem{
			key: 'total_shipping_tax'
			val: if rt.is_true(rt.call_method(var_cart, 'has_calculated_shipping', []rt.PhpVal{})) {
				this.prepare_money_response(rt.call_method(var_cart, 'get_shipping_tax',
					[]rt.PhpVal{}), var_decimals.clone())
			} else {
				rt.new_null()
			}
		},
		rt.ArrayItem{ key: 'total_price', val: this.prepare_money_response(rt.call_method(var_cart,
			'get_total', [rt.new_string('edit')]), var_decimals.clone()) },
		rt.ArrayItem{ key: 'total_tax', val: this.prepare_money_response(rt.call_method(var_cart,
			'get_total_tax', []rt.PhpVal{}), var_decimals.clone()) },
		rt.ArrayItem{ key: 'tax_lines', val: this.get_tax_lines(var_cart.clone()) },
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema) get_tax_lines(var_cart rt.PhpVal) rt.PhpVal {
	mut var_tax_lines := rt.new_array()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('itemized'), rt.call_function('get_option', [
		rt.new_string('woocommerce_tax_total_display'),
	])))))
	{
		return var_tax_lines.clone()
	}
	mut var_cart_tax_totals := rt.call_method(var_cart, 'get_tax_totals', []rt.PhpVal{})
	mut var_decimals := rt.call_function('wc_get_price_decimals', []rt.PhpVal{})
	mut iter_1 := var_cart_tax_totals.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_cart_tax_total := item_1.val
		mut iife_temp_6 := Class_WC_Tax{}
		mut iife_result_6 := iife_temp_6.get_rate_percent(rt.get_property(var_cart_tax_total,
			'tax_rate_id'))
		var_tax_lines.array_push(rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.get_property(var_cart_tax_total, 'label') },
			rt.ArrayItem{ key: 'price', val: this.prepare_money_response(rt.get_property(var_cart_tax_total,
				'amount'), var_decimals.clone()) },
			rt.ArrayItem{ key: 'rate', val: iife_result_6 },
		]))
	}
	return var_tax_lines.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema) get_cart_errors(var_cart rt.PhpVal) rt.PhpVal {
	mut var_controller := create_automattic_woocommerce_storeapi_utilities_cartcontroller()
	mut var_errors := var_controller.get_cart_errors()
	mut var_cart_errors := rt.new_array()
	mut iter_2 := rt.cast_array(rt.get_property(var_errors, 'errors')).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_messages := item_2.val
		mut var_code := item_2.key
		mut iter_3 := rt.cast_array(var_messages).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_message := item_3.val
			var_cart_errors.array_push(create_automattic_woocommerce_storeapi_schemas_v1_wp_error(var_code.clone(),
				var_message.clone(), rt.call_method(var_errors, 'get_error_data', [
				var_code.clone(),
			])))
		}
	}
	return rt.call_function('array_values', [
		rt.call_function('array_map', [
			rt.create_array([rt.ArrayItem{ key: none, val: this.error_schema },
				rt.ArrayItem{ key: none, val: 'get_item_response' }]),
			var_cart_errors.clone(),
		]),
	])
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_CartController {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_schemas_v1_cartschema(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema{
		PhpObjectBase:           rt.PhpObjectBase{}
		title:                   rt.new_string('cart')
		item_schema:             rt.new_null()
		coupon_schema:           rt.new_null()
		cross_sells_item_schema: rt.new_null()
		fee_schema:              rt.new_null()
		shipping_rate_schema:    rt.new_null()
		shipping_address_schema: rt.new_null()
		billing_address_schema:  rt.new_null()
		error_schema:            rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_automattic_woocommerce_storeapi_schemas_v1_abstractschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_cartcontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_CartController {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_CartController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tax(_args ...rt.PhpVal) &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_schemas_v1_wp_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_SchemaController](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_properties' {
			return this.get_properties()
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_response(dispatch_arg_0)
		}
		'get_totals' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_totals(dispatch_arg_0)
		}
		'get_tax_lines' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_tax_lines(dispatch_arg_0)
		}
		'get_cart_errors' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_cart_errors(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'title' { return this.title }
		'item_schema' { return this.item_schema }
		'coupon_schema' { return this.coupon_schema }
		'cross_sells_item_schema' { return this.cross_sells_item_schema }
		'fee_schema' { return this.fee_schema }
		'shipping_rate_schema' { return this.shipping_rate_schema }
		'shipping_address_schema' { return this.shipping_address_schema }
		'billing_address_schema' { return this.billing_address_schema }
		'error_schema' { return this.error_schema }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'title' {
			this.title = val
			return true
		}
		'item_schema' {
			this.item_schema = val
			return true
		}
		'coupon_schema' {
			this.coupon_schema = val
			return true
		}
		'cross_sells_item_schema' {
			this.cross_sells_item_schema = val
			return true
		}
		'fee_schema' {
			this.fee_schema = val
			return true
		}
		'shipping_rate_schema' {
			this.shipping_rate_schema = val
			return true
		}
		'shipping_address_schema' {
			this.shipping_address_schema = val
			return true
		}
		'billing_address_schema' {
			this.billing_address_schema = val
			return true
		}
		'error_schema' {
			this.error_schema = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Tax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
