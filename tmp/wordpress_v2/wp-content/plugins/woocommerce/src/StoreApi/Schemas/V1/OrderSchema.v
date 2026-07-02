import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderSchema.identifier() string {
	return 'order'
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderSchema {
	rt.PhpObjectBase
pub mut:
	title                   rt.PhpVal = rt.new_string('order')
	item_schema             rt.PhpVal = rt.new_null()
	order_controller        rt.PhpVal = rt.new_null()
	coupon_schema           rt.PhpVal = rt.new_null()
	cross_sells_item_schema rt.PhpVal = rt.new_null()
	fee_schema              rt.PhpVal = rt.new_null()
	shipping_rate_schema    rt.PhpVal = rt.new_null()
	shipping_address_schema rt.PhpVal = rt.new_null()
	billing_address_schema  rt.PhpVal = rt.new_null()
	error_schema            rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderSchema) construct(mut var_extend Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema, mut var_controller Class_Automattic_WooCommerce_StoreApi_SchemaController) {
	this.Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema.construct(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema',
		[]string{}, var_extend), rt.new_object('Automattic_WooCommerce_StoreApi_SchemaController',
		[]string{}, var_controller))
	this.item_schema = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_OrderSchema', [
		'Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema',
	], &this), 'controller'), 'get', [
		Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderItemSchema.identifier(),
	])
	this.coupon_schema = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_OrderSchema', [
		'Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema',
	], &this), 'controller'), 'get', [
		Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderCouponSchema.identifier(),
	])
	this.fee_schema = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_OrderSchema', [
		'Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema',
	], &this), 'controller'), 'get', [
		Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderFeeSchema.identifier(),
	])
	this.shipping_rate_schema = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_OrderSchema', [
		'Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema',
	], &this), 'controller'), 'get', [
		Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartShippingRateSchema.identifier(),
	])
	this.shipping_address_schema = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_OrderSchema', [
		'Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema',
	], &this), 'controller'), 'get', [
		Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ShippingAddressSchema.identifier(),
	])
	this.billing_address_schema = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_OrderSchema', [
		'Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema',
	], &this), 'controller'), 'get', [
		Class_Automattic_WooCommerce_StoreApi_Schemas_V1_BillingAddressSchema.identifier(),
	])
	this.error_schema = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_OrderSchema', [
		'Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema',
	], &this), 'controller'), 'get', [
		Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ErrorSchema.identifier(),
	])
	this.order_controller = create_automattic_woocommerce_storeapi_utilities_ordercontroller()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderSchema) get_properties() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The order ID.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Line items data.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: this.force_schema_readonly(rt.call_method(this.item_schema,
					'get_properties', []rt.PhpVal{})) },
			]) },
		]) },
		rt.ArrayItem{ key: 'totals', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Order totals.'),
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
					rt.ArrayItem{ key: 'subtotal', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Subtotal of the order.'),
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
					rt.ArrayItem{ key: 'total_shipping', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Total price of shipping.'),
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
					rt.ArrayItem{ key: 'total_tax', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Total tax applied to the order.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'total_refund', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Total refund applied to the order.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
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
					rt.ArrayItem{ key: 'total_items', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Total price of items in the order.'),
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
							rt.new_string('Total tax on items in the order.'),
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
		rt.ArrayItem{ key: 'status', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Status of the order.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderSchema) get_item_response(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_id := rt.call_method(var_order, 'get_id', []rt.PhpVal{})
	mut var_errors := rt.new_array()
	mut var_failed_order_stock_error := rt.call_method(this.order_controller,
		'get_failed_order_stock_error', [var_order_id.clone()])
	if rt.is_true(var_failed_order_stock_error) {
		var_errors.array_push(var_failed_order_stock_error.clone())
	}
	return rt.create_array([rt.ArrayItem{ key: 'id', val: var_order_id },
		rt.ArrayItem{ key: 'status', val: rt.call_method(var_order, 'get_status', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'items', val: this.get_item_responses_from_schema(this.item_schema, rt.call_method(var_order,
			'get_items', []rt.PhpVal{})) }, rt.ArrayItem{ key: 'coupons', val: this.get_item_responses_from_schema(this.coupon_schema, rt.call_method(var_order,
			'get_items', [Class_Automattic_WooCommerce_Enums_OrderItemType.coupon()])) },
		rt.ArrayItem{ key: 'fees', val: this.get_item_responses_from_schema(this.fee_schema, rt.call_method(var_order,
			'get_items', [Class_Automattic_WooCommerce_Enums_OrderItemType.fee()])) },
		rt.ArrayItem{
			key: 'totals'
			val: rt.array_to_object(this.prepare_currency_response(this.get_totals(var_order.clone())))
		}, rt.ArrayItem{ key: 'shipping_address', val: rt.array_to_object(rt.call_method(this.shipping_address_schema,
			'get_item_response', [var_order.clone()])) }, rt.ArrayItem{ key: 'billing_address', val: rt.array_to_object(rt.call_method(this.billing_address_schema,
			'get_item_response', [var_order.clone()])) }, rt.ArrayItem{ key: 'needs_payment', val: rt.call_method(var_order,
			'needs_payment', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'needs_shipping', val: rt.call_method(var_order,
			'needs_shipping_address', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'payment_requirements', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_OrderSchema', [
			'Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema'], &this), 'extend'),
			'get_payment_requirements', []rt.PhpVal{}) }, rt.ArrayItem{
			key: 'errors'
			val: var_errors
		}])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderSchema) get_totals(var_order rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_item, 'get_total', []rt.PhpVal{})
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_item, 'get_total', []rt.PhpVal{})
	}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_item, 'get_total', []rt.PhpVal{})
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_item, 'get_total', []rt.PhpVal{})
	}
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_item, 'get_tax_total', []rt.PhpVal{})
	}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_item, 'get_tax_total', []rt.PhpVal{})
	}
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_item, 'get_tax_total', []rt.PhpVal{})
	}
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_item, 'get_tax_total', []rt.PhpVal{})
	}
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_item, 'get_total_tax', []rt.PhpVal{})
	}
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_item, 'get_total_tax', []rt.PhpVal{})
	}
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_item, 'get_total_tax', []rt.PhpVal{})
	}
	closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_item, 'get_total_tax', []rt.PhpVal{})
	}
	closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_method(var_item, 'get_label', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'price', val: this.prepare_money_response(rt.call_method(var_item,
				'get_tax_total', []rt.PhpVal{})) },
			rt.ArrayItem{ key: 'rate', val: rt.call_method(var_item, 'get_rate_percent',
				[]rt.PhpVal{}).to_string() },
		])
	}
	closure_14_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_method(var_item, 'get_label', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'price', val: this.prepare_money_response(rt.call_method(var_item,
				'get_tax_total', []rt.PhpVal{})) },
			rt.ArrayItem{ key: 'rate', val: rt.call_method(var_item, 'get_rate_percent',
				[]rt.PhpVal{}).to_string() },
		])
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'subtotal', val: this.prepare_money_response(rt.call_method(var_order,
			'get_subtotal', []rt.PhpVal{})) },
		rt.ArrayItem{ key: 'total_discount', val: this.prepare_money_response(rt.call_method(var_order,
			'get_total_discount', []rt.PhpVal{})) },
		rt.ArrayItem{ key: 'total_shipping', val: this.prepare_money_response(rt.call_method(var_order,
			'get_total_shipping', []rt.PhpVal{})) },
		rt.ArrayItem{ key: 'total_fees', val: this.prepare_money_response(rt.call_method(var_order,
			'get_total_fees', []rt.PhpVal{})) },
		rt.ArrayItem{ key: 'total_tax', val: this.prepare_money_response(rt.call_method(var_order,
			'get_total_tax', []rt.PhpVal{})) },
		rt.ArrayItem{ key: 'total_refund', val: this.prepare_money_response(rt.call_method(var_order,
			'get_total_refunded', []rt.PhpVal{})) },
		rt.ArrayItem{ key: 'total_price', val: this.prepare_money_response(rt.call_method(var_order,
			'get_total', []rt.PhpVal{})) },
		rt.ArrayItem{ key: 'total_items', val: this.prepare_money_response(rt.call_function('array_sum', [
			rt.call_function('array_map', [rt.new_closure(closure_1_fn),
				rt.call_function('array_values', [
					rt.call_method(var_order, 'get_items', [
						Class_Automattic_WooCommerce_Enums_OrderItemType.line_item(),
					]),
				])]),
		])) },
		rt.ArrayItem{ key: 'total_items_tax', val: this.prepare_money_response(rt.call_function('array_sum', [
			rt.call_function('array_map', [rt.new_closure(closure_5_fn),
				rt.call_function('array_values', [
					rt.call_method(var_order, 'get_items', [
						Class_Automattic_WooCommerce_Enums_OrderItemType.tax(),
					]),
				])]),
		])) },
		rt.ArrayItem{ key: 'total_fees_tax', val: this.prepare_money_response(rt.call_function('array_sum', [
			rt.call_function('array_map', [rt.new_closure(closure_9_fn),
				rt.call_function('array_values', [
					rt.call_method(var_order, 'get_items', [
						Class_Automattic_WooCommerce_Enums_OrderItemType.fee(),
					]),
				])]),
		])) },
		rt.ArrayItem{ key: 'total_discount_tax', val: this.prepare_money_response(rt.call_method(var_order,
			'get_discount_tax', []rt.PhpVal{})) },
		rt.ArrayItem{ key: 'total_shipping_tax', val: this.prepare_money_response(rt.call_method(var_order,
			'get_shipping_tax', []rt.PhpVal{})) },
		rt.ArrayItem{ key: 'tax_lines', val: rt.call_function('array_map', [
			rt.new_closure(closure_13_fn),
			rt.call_function('array_values', [
				rt.call_method(var_order, 'get_items', [
					Class_Automattic_WooCommerce_Enums_OrderItemType.tax(),
				]),
			]),
		]) },
	])
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_schemas_v1_orderschema(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderSchema{
		PhpObjectBase:           rt.PhpObjectBase{}
		title:                   rt.new_string('order')
		item_schema:             rt.new_null()
		order_controller:        rt.new_null()
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

fn create_automattic_woocommerce_storeapi_utilities_ordercontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'title' { return this.title }
		'item_schema' { return this.item_schema }
		'order_controller' { return this.order_controller }
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'title' {
			this.title = val
			return true
		}
		'item_schema' {
			this.item_schema = val
			return true
		}
		'order_controller' {
			this.order_controller = val
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
