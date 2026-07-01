import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema.identifier() string {
	return 'agentic-checkout-session'
}
struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema {
	rt.PhpObjectBase
pub mut:
		title rt.PhpVal = rt.new_string('agentic_checkout_session')
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema) get_properties() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the checkout session.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'buyer', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Buyer information.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'object' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'first_name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('First name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'last_name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Last name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'email', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Email address.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'phone_number', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Phone number.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }, rt.ArrayItem{ key: 'payment_provider', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Payment provider information.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'object' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'provider', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Payment provider identifier.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'supported_payment_methods', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of supported payment methods.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }]) }, rt.ArrayItem{ key: 'status', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Status of the checkout session.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_CheckoutSessionStatus.not_ready_for_payment() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_CheckoutSessionStatus.ready_for_payment() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_CheckoutSessionStatus.completed() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_CheckoutSessionStatus.canceled() }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'currency', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Currency code (ISO 4217).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'line_items', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Line items in the checkout session.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Line item ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'item', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product item details.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'quantity', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Quantity.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }]) }, rt.ArrayItem{ key: 'base_amount', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Base amount in cents.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'discount', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Discount amount in cents.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'subtotal', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Subtotal in cents.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'tax', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax amount in cents.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Total amount in cents.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }]) }]) }, rt.ArrayItem{ key: 'fulfillment_address', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Fulfillment/shipping address.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'object' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Full name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'line_one', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Address line 1.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'line_two', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Address line 2.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'null' }]) }]) }, rt.ArrayItem{ key: 'city', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('City.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'state', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('State/province.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'country', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Country code (ISO 3166-1 alpha-2).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'postal_code', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Postal/ZIP code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }, rt.ArrayItem{ key: 'fulfillment_options', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Available fulfillment options.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Fulfillment type.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_FulfillmentType.shipping() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_FulfillmentType.digital() }]) }]) }, rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Fulfillment option ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Title.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'subtitle', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Subtitle.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'null' }]) }]) }, rt.ArrayItem{ key: 'carrier', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Carrier name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'null' }]) }]) }, rt.ArrayItem{ key: 'earliest_delivery_time', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Earliest delivery time (ISO 8601).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'null' }]) }]) }, rt.ArrayItem{ key: 'latest_delivery_time', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Latest delivery time (ISO 8601).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'null' }]) }]) }, rt.ArrayItem{ key: 'subtotal', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Subtotal in cents.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'tax', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax in cents.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Total in cents.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }]) }]) }, rt.ArrayItem{ key: 'fulfillment_option_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Selected fulfillment option ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'totals', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Order totals breakdown.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Total type.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'display_text', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Display text.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'amount', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Amount in cents.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }]) }]) }, rt.ArrayItem{ key: 'messages', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Messages (info, warnings, errors).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Message type.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_MessageType.info() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_MessageType.warning() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_MessageType.error() }]) }]) }, rt.ArrayItem{ key: 'param', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('JSON path to the related field.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'null' }]) }]) }, rt.ArrayItem{ key: 'content_type', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Content type.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_MessageContentType.plain() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_MessageContentType.markdown() }]) }]) }, rt.ArrayItem{ key: 'content', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Message content.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }]) }, rt.ArrayItem{ key: 'links', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Related links.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Link type.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'url', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('URL.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }]) }])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema) get_item_response(var_checkout_session rt.PhpVal) rt.PhpVal {
	mut var_cart := rt.call_method(var_checkout_session, 'get_cart', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_method(var_checkout_session, 'get_messages', []rt.PhpVal{}), 'has_errors', []rt.PhpVal{}))))) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils{}; return temp.validate(arg_0) }(var_checkout_session.dup())
	}
	mut var_completed_order := if rt.is_true(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session')) { rt.call_function('wc_get_order', [rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_SessionKey.agentic_checkout_completed_order_id()])]) } else { rt.new_null() }
	mut var_cart_items := rt.call_method(var_cart, 'get_cart', []rt.PhpVal{})
	mut var_line_items := if rt.is_true(rt.new_bool(rt.instance_of(var_completed_order, 'WC_Order'))) { this.format_line_items_from_order(var_completed_order.dup()) } else { this.format_line_items_from_cart(var_cart_items.dup()) }
	mut var_response := rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_checkout_session, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'buyer', val: if rt.is_true(rt.new_bool(rt.instance_of(var_completed_order, 'WC_Order'))) { this.format_buyer_from_order(var_completed_order.dup()) } else { this.format_buyer() } }, rt.ArrayItem{ key: 'payment_provider', val: this.format_payment_provider() }, rt.ArrayItem{ key: 'status', val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils{}; return temp.calculate_status(arg_0) }(var_checkout_session.dup()) }, rt.ArrayItem{ key: 'currency', val: if rt.is_true(rt.new_bool(rt.instance_of(var_completed_order, 'WC_Order'))) { rt.call_method(var_completed_order, 'get_currency', []rt.PhpVal{}).to_string().to_lower() } else { rt.call_function('get_woocommerce_currency', []rt.PhpVal{}).to_string().to_lower() } }, rt.ArrayItem{ key: 'line_items', val: var_line_items }, rt.ArrayItem{ key: 'fulfillment_address', val: if rt.is_true(rt.new_bool(rt.instance_of(var_completed_order, 'WC_Order'))) { this.format_fulfillment_address_from_order(var_completed_order.dup()) } else { this.format_fulfillment_address() } }, rt.ArrayItem{ key: 'fulfillment_options', val: if rt.is_true(rt.new_bool(rt.instance_of(var_completed_order, 'WC_Order'))) { this.format_fulfillment_options_from_order(var_completed_order.dup()) } else { this.format_fulfillment_options() } }, rt.ArrayItem{ key: 'fulfillment_option_id', val: if rt.is_true(rt.new_bool(rt.instance_of(var_completed_order, 'WC_Order'))) { this.get_selected_fulfillment_option_id_from_order(var_completed_order.dup()) } else { this.get_selected_fulfillment_option_id() } }, rt.ArrayItem{ key: 'totals', val: if rt.is_true(rt.new_bool(rt.instance_of(var_completed_order, 'WC_Order'))) { this.format_totals_from_order(var_completed_order.dup()) } else { this.format_totals(var_cart.dup()) } }, rt.ArrayItem{ key: 'messages', val: rt.call_method(rt.call_method(var_checkout_session, 'get_messages', []rt.PhpVal{}), 'get_formatted_messages', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'links', val: this.get_links() }])
	if rt.is_true(rt.new_bool(rt.instance_of(var_completed_order, 'WC_Order'))) {
		var_response.array_set('order', rt.create_array([rt.ArrayItem{ key: 'id', val: // unsupported expression: Expr_Cast_String }, rt.ArrayItem{ key: 'checkout_session_id', val: rt.call_method(var_checkout_session, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'permalink_url', val: rt.call_method(var_completed_order, 'get_checkout_order_received_url', []rt.PhpVal{}) }]))
	}
	return var_response.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema) format_buyer() rt.PhpVal {
	mut var_customer := rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_customer)))) {
		return rt.new_null()
	}
	mut var_first_name := if rt.is_true(rt.call_method(var_customer, 'get_billing_first_name', []rt.PhpVal{})) { rt.call_method(var_customer, 'get_billing_first_name', []rt.PhpVal{}) } else { rt.call_method(var_customer, 'get_shipping_first_name', []rt.PhpVal{}) }
	mut var_last_name := if rt.is_true(rt.call_method(var_customer, 'get_billing_last_name', []rt.PhpVal{})) { rt.call_method(var_customer, 'get_billing_last_name', []rt.PhpVal{}) } else { rt.call_method(var_customer, 'get_shipping_last_name', []rt.PhpVal{}) }
	mut var_email := rt.call_method(var_customer, 'get_billing_email', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_first_name)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_last_name)))))) && rt.is_true(rt.new_bool(!(rt.is_true(var_email)))))) {
		return rt.new_null()
	}
	return rt.create_array([rt.ArrayItem{ key: 'first_name', val: if rt.is_true(var_first_name) { var_first_name } else { rt.new_string('') } }, rt.ArrayItem{ key: 'last_name', val: if rt.is_true(var_last_name) { var_last_name } else { rt.new_string('') } }, rt.ArrayItem{ key: 'email', val: if rt.is_true(var_email) { var_email } else { rt.new_string('') } }, rt.ArrayItem{ key: 'phone_number', val: if rt.is_true(rt.call_method(var_customer, 'get_billing_phone', []rt.PhpVal{})) { rt.call_method(var_customer, 'get_billing_phone', []rt.PhpVal{}) } else { rt.new_string('') } }])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema) format_buyer_from_order(var_order rt.PhpVal) rt.PhpVal {
	mut var_first_name := if rt.is_true(rt.call_method(var_order, 'get_billing_first_name', []rt.PhpVal{})) { rt.call_method(var_order, 'get_billing_first_name', []rt.PhpVal{}) } else { rt.call_method(var_order, 'get_shipping_first_name', []rt.PhpVal{}) }
	mut var_last_name := if rt.is_true(rt.call_method(var_order, 'get_billing_last_name', []rt.PhpVal{})) { rt.call_method(var_order, 'get_billing_last_name', []rt.PhpVal{}) } else { rt.call_method(var_order, 'get_shipping_last_name', []rt.PhpVal{}) }
	mut var_email := rt.call_method(var_order, 'get_billing_email', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_first_name)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_last_name)))))) && rt.is_true(rt.new_bool(!(rt.is_true(var_email)))))) {
		return rt.new_null()
	}
	return rt.create_array([rt.ArrayItem{ key: 'first_name', val: if rt.is_true(var_first_name) { var_first_name } else { rt.new_string('') } }, rt.ArrayItem{ key: 'last_name', val: if rt.is_true(var_last_name) { var_last_name } else { rt.new_string('') } }, rt.ArrayItem{ key: 'email', val: if rt.is_true(var_email) { var_email } else { rt.new_string('') } }, rt.ArrayItem{ key: 'phone_number', val: if rt.is_true(rt.call_method(var_order, 'get_billing_phone', []rt.PhpVal{})) { rt.call_method(var_order, 'get_billing_phone', []rt.PhpVal{}) } else { rt.new_string('') } }])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema) format_payment_provider() rt.PhpVal {
	mut var_available_gateways := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{}), 'get_available_payment_gateways', []rt.PhpVal{})
	if !rt.is_true(var_available_gateways) {
		return rt.new_null()
	}
	mut var_gateway := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils{}; return temp.get_agentic_commerce_gateway(arg_0) }(var_available_gateways.dup())
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.create_array([rt.ArrayItem{ key: 'provider', val: rt.call_method(var_gateway, 'get_agentic_commerce_provider', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'supported_payment_methods', val: rt.call_method(var_gateway, 'get_agentic_commerce_payment_methods', []rt.PhpVal{}) }])
	}
	return rt.create_array([rt.ArrayItem{ key: 'provider', val: 'stripe' }, rt.ArrayItem{ key: 'supported_payment_methods', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_PaymentMethod.card() }]) }])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema) amount_to_cents(var_amount rt.PhpVal) rt.PhpVal {
	return // unsupported expression: Expr_Cast_Int
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema) format_line_items_from_cart(var_cart_items rt.PhpVal) rt.PhpVal {
	mut var_cart_items_mutated := var_cart_items
	mut var_items := rt.new_array()
	{
		mut iter_1 := var_cart_items_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_cart_item := item_1.val
			mut var_cart_item_key := item_1.key
			mut var_product := var_cart_item.array_get('data')
			mut var_quantity := var_cart_item.array_get('quantity')
			mut var_base_amount := this.amount_to_cents(rt.mul(rt.call_method(var_product, 'get_price', []rt.PhpVal{}), var_quantity))
			mut var_discount := this.amount_to_cents(rt.sub(var_cart_item.array_get('line_subtotal'), var_cart_item.array_get('line_total')))
			mut var_subtotal := rt.sub(var_base_amount, var_discount)
			mut var_tax := this.amount_to_cents(var_cart_item.array_get('line_tax'))
			mut var_total := rt.add(var_subtotal, var_tax)
			var_items.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: // unsupported expression: Expr_Cast_String }, rt.ArrayItem{ key: 'item', val: rt.create_array([rt.ArrayItem{ key: 'id', val: // unsupported expression: Expr_Cast_String }, rt.ArrayItem{ key: 'quantity', val: var_quantity }]) }, rt.ArrayItem{ key: 'base_amount', val: var_base_amount }, rt.ArrayItem{ key: 'discount', val: var_discount }, rt.ArrayItem{ key: 'subtotal', val: var_subtotal }, rt.ArrayItem{ key: 'tax', val: var_tax }, rt.ArrayItem{ key: 'total', val: var_total }]))
		}
	}
	return var_items.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema) format_line_items_from_order(var_order rt.PhpVal) rt.PhpVal {
	mut var_items := rt.new_array()
	{
		mut iter_1 := rt.call_method(var_order, 'get_items', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_item_id := item_1.key
			mut var_quantity := rt.call_method(var_item, 'get_quantity', []rt.PhpVal{})
			mut var_base_amount := this.amount_to_cents(rt.call_method(var_item, 'get_subtotal', []rt.PhpVal{}))
			mut var_discount := this.amount_to_cents(rt.sub(rt.call_method(var_item, 'get_subtotal', []rt.PhpVal{}), rt.call_method(var_item, 'get_total', []rt.PhpVal{})))
			mut var_subtotal := rt.sub(var_base_amount, var_discount)
			mut var_tax := this.amount_to_cents(rt.call_method(var_item, 'get_total_tax', []rt.PhpVal{}))
			mut var_total := rt.add(var_subtotal, var_tax)
			mut var_item_product_id := if rt.is_true(rt.call_method(var_item, 'get_variation_id', []rt.PhpVal{})) { rt.call_method(var_item, 'get_variation_id', []rt.PhpVal{}) } else { rt.call_method(var_item, 'get_product_id', []rt.PhpVal{}) }
			var_items.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: // unsupported expression: Expr_Cast_String }, rt.ArrayItem{ key: 'item', val: rt.create_array([rt.ArrayItem{ key: 'id', val: // unsupported expression: Expr_Cast_String }, rt.ArrayItem{ key: 'quantity', val: var_quantity }]) }, rt.ArrayItem{ key: 'base_amount', val: var_base_amount }, rt.ArrayItem{ key: 'discount', val: var_discount }, rt.ArrayItem{ key: 'subtotal', val: var_subtotal }, rt.ArrayItem{ key: 'tax', val: var_tax }, rt.ArrayItem{ key: 'total', val: var_total }]))
		}
	}
	return var_items.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema) format_fulfillment_address() rt.PhpVal {
	mut var_customer := rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer')
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_customer)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_customer, 'get_shipping_address_1', []rt.PhpVal{}))))))) {
		return rt.new_null()
	}
	return this.build_address_array(rt.call_method(var_customer, 'get_shipping_first_name', []rt.PhpVal{}), rt.call_method(var_customer, 'get_shipping_last_name', []rt.PhpVal{}), rt.call_method(var_customer, 'get_shipping_address_1', []rt.PhpVal{}), rt.call_method(var_customer, 'get_shipping_address_2', []rt.PhpVal{}), rt.call_method(var_customer, 'get_shipping_city', []rt.PhpVal{}), rt.call_method(var_customer, 'get_shipping_state', []rt.PhpVal{}), rt.call_method(var_customer, 'get_shipping_country', []rt.PhpVal{}), rt.call_method(var_customer, 'get_shipping_postcode', []rt.PhpVal{}))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema) format_fulfillment_address_from_order(var_order rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'get_shipping_address_1', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	return this.build_address_array(rt.call_method(var_order, 'get_shipping_first_name', []rt.PhpVal{}), rt.call_method(var_order, 'get_shipping_last_name', []rt.PhpVal{}), rt.call_method(var_order, 'get_shipping_address_1', []rt.PhpVal{}), rt.call_method(var_order, 'get_shipping_address_2', []rt.PhpVal{}), rt.call_method(var_order, 'get_shipping_city', []rt.PhpVal{}), rt.call_method(var_order, 'get_shipping_state', []rt.PhpVal{}), rt.call_method(var_order, 'get_shipping_country', []rt.PhpVal{}), rt.call_method(var_order, 'get_shipping_postcode', []rt.PhpVal{}))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema) build_address_array(var_first_name rt.PhpVal, var_last_name rt.PhpVal, var_address_1 rt.PhpVal, var_address_2 rt.PhpVal, var_city rt.PhpVal, var_state rt.PhpVal, var_country rt.PhpVal, var_postcode rt.PhpVal) rt.PhpVal {
	mut var_first_name_mutated := var_first_name
	mut var_last_name_mutated := var_last_name
	mut var_name := rt.new_string(rt.new_string((var_first_name_mutated).str() + ' ' + (var_last_name_mutated).str().trim_space()))
	return rt.create_array([rt.ArrayItem{ key: 'name', val: if rt.is_true(var_name) { var_name } else { rt.new_string('Customer') } }, rt.ArrayItem{ key: 'line_one', val: var_address_1 }, rt.ArrayItem{ key: 'line_two', val: if rt.is_true(var_address_2) { var_address_2 } else { rt.new_string('') } }, rt.ArrayItem{ key: 'city', val: var_city }, rt.ArrayItem{ key: 'state', val: var_state }, rt.ArrayItem{ key: 'country', val: var_country }, rt.ArrayItem{ key: 'postal_code', val: var_postcode }])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema) format_fulfillment_options() rt.PhpVal {
	mut var_options := rt.new_array()
	mut var_packages := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping', []rt.PhpVal{}), 'get_packages', []rt.PhpVal{})
	{
		mut iter_1 := var_packages.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_package := item_1.val
			if !rt.is_true(var_package.array_get('rates')) {
				continue
			}
			{
				mut iter_2 := var_package.array_get('rates').iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_rate := item_2.val
					var_options.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_FulfillmentType.shipping() }, rt.ArrayItem{ key: 'id', val: rt.call_method(var_rate, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'title', val: rt.call_method(var_rate, 'get_label', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'subtitle', val: rt.new_null() }, rt.ArrayItem{ key: 'carrier', val: rt.call_method(var_rate, 'get_method_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'earliest_delivery_time', val: rt.new_null() }, rt.ArrayItem{ key: 'latest_delivery_time', val: rt.new_null() }, rt.ArrayItem{ key: 'subtotal', val: this.amount_to_cents(rt.call_method(var_rate, 'get_cost', []rt.PhpVal{})) }, rt.ArrayItem{ key: 'tax', val: this.amount_to_cents(rt.call_method(var_rate, 'get_shipping_tax', []rt.PhpVal{})) }, rt.ArrayItem{ key: 'total', val: this.amount_to_cents(rt.add(rt.call_method(var_rate, 'get_cost', []rt.PhpVal{}), rt.call_method(var_rate, 'get_shipping_tax', []rt.PhpVal{}))) }]))
				}
			}
		}
	}
	return var_options.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema) format_fulfillment_options_from_order(var_order rt.PhpVal) rt.PhpVal {
	mut var_options := rt.new_array()
	mut var_shipping_methods := rt.call_method(var_order, 'get_shipping_methods', []rt.PhpVal{})
	{
		mut iter_1 := var_shipping_methods.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			var_options.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_FulfillmentType.shipping() }, rt.ArrayItem{ key: 'id', val: (rt.call_method(var_item, 'get_method_id', []rt.PhpVal{})).str() + ':' + (rt.call_method(var_item, 'get_instance_id', []rt.PhpVal{})).str() }, rt.ArrayItem{ key: 'title', val: rt.call_method(var_item, 'get_name', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'subtitle', val: rt.new_null() }, rt.ArrayItem{ key: 'carrier', val: rt.call_method(var_item, 'get_method_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'earliest_delivery_time', val: rt.new_null() }, rt.ArrayItem{ key: 'latest_delivery_time', val: rt.new_null() }, rt.ArrayItem{ key: 'subtotal', val: this.amount_to_cents(rt.call_method(var_item, 'get_total', []rt.PhpVal{})) }, rt.ArrayItem{ key: 'tax', val: this.amount_to_cents(rt.call_method(var_item, 'get_total_tax', []rt.PhpVal{})) }, rt.ArrayItem{ key: 'total', val: this.amount_to_cents(rt.add(rt.call_method(var_item, 'get_total', []rt.PhpVal{}), rt.call_method(var_item, 'get_total_tax', []rt.PhpVal{}))) }]))
		}
	}
	return var_options.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema) get_selected_fulfillment_option_id() rt.PhpVal {
	mut var_chosen_methods := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_SessionKey.chosen_shipping_methods()])
	return if !(!rt.is_true(var_chosen_methods.array_get(0))) { var_chosen_methods.array_get(0) } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema) get_selected_fulfillment_option_id_from_order(var_order rt.PhpVal) rt.PhpVal {
	mut var_shipping_methods := rt.call_method(var_order, 'get_shipping_methods', []rt.PhpVal{})
	if !rt.is_true(var_shipping_methods) {
		return rt.new_null()
	}
	mut var_shipping_method := rt.call_function('reset', [var_shipping_methods.dup()])
	return rt.new_string((rt.call_method(var_shipping_method, 'get_method_id', []rt.PhpVal{})).str() + ':' + (rt.call_method(var_shipping_method, 'get_instance_id', []rt.PhpVal{})).str())
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema) format_totals(var_cart rt.PhpVal) rt.PhpVal {
	mut var_cart_mutated := var_cart
	mut var_totals := rt.new_array()
	mut var_items_base := rt.new_int(rt.new_int(0))
	{
		mut iter_1 := rt.call_method(var_cart_mutated, 'get_cart', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_cart_item := item_1.val
			mut var_product := var_cart_item.array_get('data')
			// unsupported expression: Expr_AssignOp_Plus
		}
	}
	var_totals.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_TotalType.items_base_amount() }, rt.ArrayItem{ key: 'display_text', val: rt.call_function('__', [, ]) }, rt.ArrayItem{ key: 'amount', val: this.amount_to_cents(.dup()) }]))
	mut var_discount := rt.call_method(, 'get_cart_discount_total', []rt.PhpVal{})
	.array_push()
	
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema) format_totals_from_order(var_order rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema) get_links() rt.PhpVal {
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_schemas_v1_agentic_checkoutsessionschema() &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema{
		PhpObjectBase: rt.PhpObjectBase{}
		title: rt.new_string('agentic_checkout_session')
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_schemas_v1_abstractschema() &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_agenticcheckoututils() &Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_properties' {
			return this.get_properties()
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_response(dispatch_arg_0)
		}
		'format_buyer' {
			return this.format_buyer()
		}
		'format_buyer_from_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.format_buyer_from_order(dispatch_arg_0)
		}
		'format_payment_provider' {
			return this.format_payment_provider()
		}
		'amount_to_cents' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.amount_to_cents(dispatch_arg_0)
		}
		'format_line_items_from_cart' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.format_line_items_from_cart(dispatch_arg_0)
		}
		'format_line_items_from_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.format_line_items_from_order(dispatch_arg_0)
		}
		'format_fulfillment_address' {
			return this.format_fulfillment_address()
		}
		'format_fulfillment_address_from_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.format_fulfillment_address_from_order(dispatch_arg_0)
		}
		'build_address_array' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			dispatch_arg_6 := if args.len > 6 { args[6] } else { rt.new_null() }
			dispatch_arg_7 := if args.len > 7 { args[7] } else { rt.new_null() }
			return this.build_address_array(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5, dispatch_arg_6, dispatch_arg_7)
		}
		'format_fulfillment_options' {
			return this.format_fulfillment_options()
		}
		'format_fulfillment_options_from_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.format_fulfillment_options_from_order(dispatch_arg_0)
		}
		'get_selected_fulfillment_option_id' {
			return this.get_selected_fulfillment_option_id()
		}
		'get_selected_fulfillment_option_id_from_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_selected_fulfillment_option_id_from_order(dispatch_arg_0)
		}
		'format_totals' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.format_totals(dispatch_arg_0)
		}
		'format_totals_from_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.format_totals_from_order(dispatch_arg_0)
		}
		'get_links' {
			return this.get_links()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'title' { return this.title }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'title' { this.title = val; return true }
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


fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_storeapi_schemas_v1_agentic_checkoutsessionschema_php() {
	// unsupported statement: Stmt_Declare
}
