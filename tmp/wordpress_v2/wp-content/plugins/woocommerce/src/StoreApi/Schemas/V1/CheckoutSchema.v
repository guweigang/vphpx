import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema.identifier() string {
	return 'checkout'
}
struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema {
	rt.PhpObjectBase
pub mut:
		title rt.PhpVal = rt.new_string('checkout')
		billing_address_schema rt.PhpVal = rt.new_null()
		shipping_address_schema rt.PhpVal = rt.new_null()
		image_attachment_schema rt.PhpVal = rt.new_null()
		cart_schema rt.PhpVal = rt.new_null()
		additional_fields_controller rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema) construct(mut var_extend Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema, mut var_controller Class_Automattic_WooCommerce_StoreApi_SchemaController) {
	this.Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema.construct(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema', []string{}, var_extend), rt.new_object('Automattic_WooCommerce_StoreApi_SchemaController', []string{}, var_controller))
	this.billing_address_schema = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema', ['Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema'], &this), 'controller'), 'get', [Class_Automattic_WooCommerce_StoreApi_Schemas_V1_BillingAddressSchema.identifier()])
	this.shipping_address_schema = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema', ['Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema'], &this), 'controller'), 'get', [Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ShippingAddressSchema.identifier()])
	this.image_attachment_schema = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema', ['Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema'], &this), 'controller'), 'get', [Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ImageAttachmentSchema.identifier()])
	this.cart_schema = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema', ['Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema'], &this), 'controller'), 'get', [Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema.identifier()])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_Package{}
	mut iife_result_0 := iife_temp_0.container()
	this.additional_fields_controller = rt.call_method(iife_result_0, 'get', [Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.class()])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema) get_properties() rt.PhpVal {
	mut var_additional_field_schema := this.get_additional_fields_schema()
	return rt.create_array([rt.ArrayItem{ key: 'order_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The order ID to process during checkout.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'status', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Order status. Payment providers will update this value after payment.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'order_key', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Order key used to check validity or protect access to certain order data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'order_number', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Order number used for display.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'customer_note', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Note added to the order by the customer during checkout.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'customer_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Customer ID if registered. Will return 0 for guests.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'billing_address', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Billing address.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'properties', val: rt.call_method(this.billing_address_schema, 'get_properties', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'arg_options', val: rt.create_array([rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: this.billing_address_schema }, rt.ArrayItem{ key: none, val: 'sanitize_callback' }]) }, rt.ArrayItem{ key: 'validate_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: this.billing_address_schema }, rt.ArrayItem{ key: none, val: 'validate_callback' }]) }]) }, rt.ArrayItem{ key: 'required', val: true }]) }, rt.ArrayItem{ key: 'shipping_address', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shipping address.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'properties', val: rt.call_method(this.shipping_address_schema, 'get_properties', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'arg_options', val: rt.create_array([rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: this.shipping_address_schema }, rt.ArrayItem{ key: none, val: 'sanitize_callback' }]) }, rt.ArrayItem{ key: 'validate_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: this.shipping_address_schema }, rt.ArrayItem{ key: none, val: 'validate_callback' }]) }]) }]) }, rt.ArrayItem{ key: 'payment_method', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The ID of the payment method being used to process the payment.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'enum', val: rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: '' }]), rt.call_function('array_values', [rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways'), 'get_payment_gateway_ids', []rt.PhpVal{})])]) }]) }, rt.ArrayItem{ key: 'create_account', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether to create a new user account as part of order processing.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'payment_result', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Result of payment processing, or null if not yet processed.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'object' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'payment_status', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Status of the payment returned by the gateway. One of success, pending, failure, error.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'payment_details', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('An array of data being returned from the payment gateway.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'key', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'value', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }]) }, rt.ArrayItem{ key: 'redirect_url', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('A URL to redirect the customer after checkout. This could be, for example, a link to the payment processors website.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }, rt.ArrayItem{ key: 'additional_fields', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Additional fields to be persisted on the order.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'properties', val: var_additional_field_schema }, rt.ArrayItem{ key: 'arg_options', val: rt.create_array([rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema', ['Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema'], &this) }, rt.ArrayItem{ key: none, val: 'sanitize_additional_fields' }]) }, rt.ArrayItem{ key: 'validate_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema', ['Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema'], &this) }, rt.ArrayItem{ key: none, val: 'validate_additional_fields' }]) }]) }, rt.ArrayItem{ key: 'required', val: this.schema_has_required_property(var_additional_field_schema.clone()) }]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema.extending_key(), val: this.get_extended_schema(Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema.identifier()) }])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema) get_item_response(var_item rt.PhpVal) rt.PhpVal {
	mut var_cart := if rt.is_true(rt.call_function('property_exists', [var_item.clone(), rt.new_string('cart')])) { rt.get_property(var_item, 'cart') } else { rt.new_null() }
	mut var_payment_result := if rt.is_true(rt.call_function('property_exists', [var_item.clone(), rt.new_string('payment_result')])) { rt.get_property(var_item, 'payment_result') } else { rt.new_null() }
	return this.get_checkout_response(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Order](rt.get_property(var_item, 'order')), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_?PaymentResult](var_payment_result), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_?WC_Cart](var_cart))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema) get_checkout_response(mut var_order Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Order, mut var_payment_result Class_Automattic_WooCommerce_StoreApi_Schemas_V1_?PaymentResult, mut var_cart Class_Automattic_WooCommerce_StoreApi_Schemas_V1_?WC_Cart) rt.PhpVal {
	mut var_payment_result_mutated := var_payment_result
	mut var_cart_mutated := var_cart
	var_payment_result_mutated = if rt.is_true(var_payment_result_mutated) { rt.create_array([rt.ArrayItem{ key: 'payment_status', val: rt.get_property(var_payment_result_mutated, 'status') }, rt.ArrayItem{ key: 'payment_details', val: this.prepare_payment_details_for_response(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_array](rt.get_property(var_payment_result_mutated, 'payment_details'))) }, rt.ArrayItem{ key: 'redirect_url', val: rt.get_property(var_payment_result_mutated, 'redirect_url') }]) } else { rt.new_null() }
	return rt.create_array([rt.ArrayItem{ key: 'order_id', val: var_order.get_id() }, rt.ArrayItem{ key: 'status', val: var_order.get_status() }, rt.ArrayItem{ key: 'order_key', val: var_order.get_order_key() }, rt.ArrayItem{ key: 'order_number', val: var_order.get_order_number() }, rt.ArrayItem{ key: 'customer_note', val: var_order.get_customer_note() }, rt.ArrayItem{ key: 'customer_id', val: var_order.get_customer_id() }, rt.ArrayItem{ key: 'billing_address', val: rt.array_to_object(rt.call_method(this.billing_address_schema, 'get_item_response', [var_order])) }, rt.ArrayItem{ key: 'shipping_address', val: rt.array_to_object(rt.call_method(this.shipping_address_schema, 'get_item_response', [var_order])) }, rt.ArrayItem{ key: 'payment_method', val: var_order.get_payment_method() }, rt.ArrayItem{ key: 'payment_result', val: var_payment_result_mutated }, rt.ArrayItem{ key: 'additional_fields', val: rt.array_to_object(this.get_additional_fields_response(mut var_order)) }, rt.ArrayItem{ key: '__experimentalCart', val: if rt.is_true(var_cart_mutated) { rt.array_to_object(rt.call_method(this.cart_schema, 'get_item_response', [var_cart_mutated])) } else { rt.new_null() } }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema.extending_key(), val: this.get_extended_data(Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema.identifier()) }])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema) prepare_payment_details_for_response(mut var_payment_details Class_Automattic_WooCommerce_StoreApi_Schemas_V1_array) rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_key := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_value := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return rt.new_object('stdClass', []string{}, rt.array_to_object(rt.create_array([rt.ArrayItem{ key: 'key', val: var_key }, rt.ArrayItem{ key: 'value', val: var_value }])))
		}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_key := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_value := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return rt.new_object('stdClass', []string{}, rt.array_to_object(rt.create_array([rt.ArrayItem{ key: 'key', val: var_key }, rt.ArrayItem{ key: 'value', val: var_value }])))
		}
	return rt.call_function('array_map', [rt.new_closure(closure_2_fn), rt.func_array_keys(var_payment_details), var_payment_details])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema) get_additional_fields_response(mut var_order Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Order) rt.PhpVal {
	mut var_fields := rt.call_function('wp_parse_args', [rt.call_method(this.additional_fields_controller, 'get_all_fields_from_object', [var_order, rt.new_string('other')]), rt.call_method(this.additional_fields_controller, 'get_all_fields_from_object', [rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'customer'), rt.new_string('other')])])
	mut var_additional_field_schema := this.get_additional_fields_schema()
	mut iter_1 := var_fields.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_key := item_1.key
		if !(var_additional_field_schema.array_isset(var_key)) {
			var_fields.array_unset(var_key)
			continue
		}
		if var_additional_field_schema.array_get(var_key).array_isset(rt.new_string('type')) && rt.is_true(rt.identical(rt.new_string('boolean'), var_additional_field_schema.array_get(var_key).array_get(rt.new_string('type')))) {
			var_fields.array_set(var_key, (var_value).to_bool())
		} else {
			var_fields.array_set(var_key, this.prepare_html_response(var_value.clone()))
		}
	}
	return mut rt.array_to_object(var_fields)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema) get_additional_fields_schema() rt.PhpVal {
	return this.generate_additional_fields_schema(rt.call_method(this.additional_fields_controller, 'get_fields_for_location', [rt.new_string('contact')]), rt.call_method(this.additional_fields_controller, 'get_fields_for_location', [rt.new_string('order')]))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema) generate_additional_fields_schema(var_args rt.PhpVal) rt.PhpVal {
	mut var_additional_fields := rt.call_function('array_merge', [var_args.clone()])
	mut var_schema := rt.new_array()
	mut iter_2 := var_additional_fields.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_field := item_2.val
		mut var_key := item_2.key
		mut var_field_schema := rt.create_array([rt.ArrayItem{ key: 'description', val: var_field.array_get(rt.new_string('label')) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'required', val: if rt.is_true(rt.call_method(this.additional_fields_controller, 'is_conditional_field', [var_field.clone()])) { rt.new_bool(false) } else { rt.identical(rt.new_bool(true), var_field.array_get(rt.new_string('required'))) } }])
		if rt.is_true(rt.identical(rt.new_string('select'), var_field.array_get(rt.new_string('type')))) {
			closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_option := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return var_option.array_get(rt.new_string('value'))
				}
			closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_option := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return var_option.array_get(rt.new_string('value'))
				}
			var_field_schema.array_set('enum', rt.call_function('array_map', [rt.new_closure(closure_4_fn), var_field.array_get(rt.new_string('options'))]))
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), var_field.array_get(rt.new_string('required')))))) || rt.is_true(rt.call_method(this.additional_fields_controller, 'is_conditional_field', [var_field.clone()])) {
				var_field_schema.array_get_mut('enum').array_push('')
			}
		}
		if rt.is_true(rt.identical(rt.new_string('checkbox'), var_field.array_get(rt.new_string('type')))) {
			var_field_schema.array_set('type', 'boolean')
		}
		if rt.is_true(rt.identical(rt.new_string('checkbox'), var_field.array_get(rt.new_string('type')))) && rt.is_true(rt.identical(rt.new_bool(true), var_field.array_get(rt.new_string('required')))) {
			var_field_schema.array_get_mut('enum').array_push(true)
		}
		var_schema.array_set(var_key, var_field_schema.clone())
	}
	return var_schema.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema) schema_has_required_property(var_additional_fields_schema rt.PhpVal) rt.PhpVal {
	closure_6_fn := fn [var_additional_fields_schema] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_carry := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_key := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return rt.new_bool(rt.is_true(var_carry) || rt.is_true(rt.identical(rt.new_bool(true), var_additional_fields_schema.array_get(var_key).array_get(rt.new_string('required')))))
		}
	return rt.call_function('array_reduce', [rt.func_array_keys(var_additional_fields_schema.clone()), rt.new_closure(closure_6_fn), rt.new_bool(false)])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema) sanitize_additional_fields(var_fields rt.PhpVal) rt.PhpVal {
	mut var_fields_mutated := var_fields
	mut var_properties := this.get_additional_fields_schema()
	mut var_sanitization_utils := create_automattic_woocommerce_storeapi_utilities_sanitizationutils()
	closure_7_fn := fn [var_fields, var_properties] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_carry := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_key := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		if !(var_properties.array_isset(var_key)) {
			return var_carry.clone()
		}
		mut var_field_schema := var_properties.array_get(var_key)
		mut var_rest_sanitized := rt.call_function('rest_sanitize_value_from_schema', [rt.call_function('wp_unslash', [var_fields_mutated.array_get(var_key)]), var_field_schema.clone(), var_key.clone()])
		var_rest_sanitized = rt.call_method(this.additional_fields_controller, 'sanitize_field', [var_key.clone(), var_rest_sanitized.clone()])
		var_carry.array_set(var_key, var_rest_sanitized.clone())
		return var_carry.clone()
		}
	var_fields_mutated = var_sanitization_utils.wp_kses_array(rt.call_function('array_reduce', [rt.func_array_keys(var_fields_mutated.clone()), rt.new_closure(closure_7_fn), rt.new_array()]))
	return var_sanitization_utils.wp_kses_array(var_fields_mutated.clone())
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema) validate_additional_fields(var_fields rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_fields_mutated := var_fields
	mut var_errors := create_automattic_woocommerce_storeapi_schemas_v1_wp_error()
	var_fields_mutated = this.sanitize_additional_fields(var_fields_mutated.clone())
	mut var_additional_field_schema := this.get_additional_fields_schema()
	if rt.is_true(rt.identical(rt.call_method(var_request, 'get_method', []rt.PhpVal{}), rt.new_string('PUT'))) {
	var_additional_field_schema = rt.call_function('array_intersect_key', [var_additional_field_schema.clone(), var_fields_mutated.clone()])
	}
	mut iter_3 := var_additional_field_schema.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_schema := item_3.val
		mut var_key := item_3.key
		if !(var_fields_mutated.array_isset(var_key)) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), var_schema.array_get(rt.new_string('required')))))) {
			continue
		}
		mut var_result := rt.call_function('rest_validate_value_from_schema', [if !(var_fields_mutated.array_get(var_key)).is_null() { var_fields_mutated.array_get(var_key) } else { rt.new_null() }, var_schema.clone(), var_key.clone()])
		if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) && rt.is_true(rt.call_method(var_result, 'has_errors', []rt.PhpVal{})) {
			mut var_location := rt.call_method(this.additional_fields_controller, 'get_field_location', [var_key.clone()])
			mut iter_4 := rt.call_method(var_result, 'get_error_codes', []rt.PhpVal{}).iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_code := item_4.val
				rt.call_method(var_result, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'location', val: var_location }, rt.ArrayItem{ key: 'key', val: var_key }]), var_code.clone()])
			}
			var_errors.merge_from(var_result.clone())
		}
	}
	return if rt.is_true(var_errors.has_errors()) { var_errors } else { rt.new_bool(true) }
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Package {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_SanitizationUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_schemas_v1_checkoutschema(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema{
		PhpObjectBase: rt.PhpObjectBase{}
		title: rt.new_string('checkout')
		billing_address_schema: rt.new_null()
		shipping_address_schema: rt.new_null()
		image_attachment_schema: rt.new_null()
		cart_schema: rt.new_null()
		additional_fields_controller: rt.new_null()
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

fn create_automattic_woocommerce_blocks_package(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Package {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Package{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_sanitizationutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_SanitizationUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_SanitizationUtils{
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_SchemaController](if args.len > 1 { args[1] } else { rt.new_null() })
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
		'get_checkout_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_?PaymentResult](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_?WC_Cart](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.get_checkout_response(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'prepare_payment_details_for_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.prepare_payment_details_for_response(mut dispatch_arg_0)
		}
		'get_additional_fields_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_additional_fields_response(mut dispatch_arg_0)
		}
		'get_additional_fields_schema' {
			return this.get_additional_fields_schema()
		}
		'generate_additional_fields_schema' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.generate_additional_fields_schema(dispatch_arg_0)
		}
		'schema_has_required_property' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.schema_has_required_property(dispatch_arg_0)
		}
		'sanitize_additional_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sanitize_additional_fields(dispatch_arg_0)
		}
		'validate_additional_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.validate_additional_fields(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'title' { return this.title }
		'billing_address_schema' { return this.billing_address_schema }
		'shipping_address_schema' { return this.shipping_address_schema }
		'image_attachment_schema' { return this.image_attachment_schema }
		'cart_schema' { return this.cart_schema }
		'additional_fields_controller' { return this.additional_fields_controller }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'title' { this.title = val; return true }
		'billing_address_schema' { this.billing_address_schema = val; return true }
		'shipping_address_schema' { this.shipping_address_schema = val; return true }
		'image_attachment_schema' { this.image_attachment_schema = val; return true }
		'cart_schema' { this.cart_schema = val; return true }
		'additional_fields_controller' { this.additional_fields_controller = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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


fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Package) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_SanitizationUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_SanitizationUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_SanitizationUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
