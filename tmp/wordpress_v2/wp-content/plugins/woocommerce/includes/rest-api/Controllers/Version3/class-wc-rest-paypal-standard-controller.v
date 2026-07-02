import rt

struct Class_WC_REST_Paypal_Standard_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v3')
	rest_base rt.PhpVal = rt.new_string('paypal-standard')
}

fn (mut this Class_WC_REST_Paypal_Standard_Controller) register_routes() {
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/update-shipping'),
		rt.create_array([
			rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Paypal_Standard_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'process_shipping_callback' },
			]) },
			rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Paypal_Standard_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'validate_shipping_callback_request' },
			]) },
		])])
}

fn (mut this Class_WC_REST_Paypal_Standard_Controller) validate_shipping_callback_request(mut var_request Class_WP_REST_Request) bool {
	mut var_purchase_units := var_request.get_param(rt.new_string('purchase_units'))
	if !rt.is_true(var_purchase_units)
		|| !rt.is_true(var_purchase_units.array_get(rt.new_int(0)).array_get(rt.new_string('custom_id'))) {
		return false
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
	mut iife_result_0 :=
		iife_temp_0.get_wc_order_from_paypal_custom_id(var_purchase_units.array_get(rt.new_int(0)).array_get(rt.new_string('custom_id')))
	mut var_order := iife_result_0
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'meta_exists', [
		Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_shipping_callback_token(),
	])))))
	{
		return true
	}
	mut var_token := var_request.get_param(rt.new_string('token'))
	if !rt.is_true(var_token) {
		return false
	}
	mut var_shipping_callback_token := rt.call_method(var_order, 'get_meta', [
		Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_shipping_callback_token(),
		rt.new_bool(true),
	])
	if !rt.is_true(var_shipping_callback_token)
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('hash_equals', [var_token.clone(), var_shipping_callback_token.clone()]))))) {
		return false
	}
	return true
}

fn (mut this Class_WC_REST_Paypal_Standard_Controller) process_shipping_callback(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_paypal_order_id := var_request.get_param(rt.new_string('id'))
	mut var_shipping_address := var_request.get_param(rt.new_string('shipping_address'))
	mut var_shipping_option := var_request.get_param(rt.new_string('shipping_option'))
	mut var_purchase_units := var_request.get_param(rt.new_string('purchase_units'))
	if !rt.is_true(var_paypal_order_id) || !rt.is_true(var_shipping_address)
		|| !rt.is_true(var_purchase_units) {
		mut var_response := this.get_update_shipping_error_response('')
		return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(var_response.clone(),
			rt.new_int(422)))
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
	mut iife_result_1 := iife_temp_1.get_wc_order_from_paypal_custom_id(if !(var_purchase_units.array_get(rt.new_int(0)).array_get(rt.new_string('custom_id'))).is_null() {
		var_purchase_units.array_get(rt.new_int(0)).array_get(rt.new_string('custom_id'))
	} else {
		rt.new_string('{}')
	})
	mut var_order := iife_result_1
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		mut var_custom_id := if var_purchase_units.array_get(rt.new_int(0)).array_isset(rt.new_string('custom_id')) {
			var_purchase_units.array_get(rt.new_int(0)).array_get(rt.new_string('custom_id'))
		} else {
			rt.new_string('{}')
		}
		mut iife_temp_2 := Class_WC_Gateway_Paypal{}
		mut iife_result_2 := iife_temp_2.log(rt.new_string(
			'Unable to determine WooCommerce order from PayPal custom ID: ' + var_custom_id.str()))
		var_response = this.get_update_shipping_error_response('')
		return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(var_response.clone(),
			rt.new_int(422)))
	}
	mut var_paypal_order_id_from_order_meta := rt.call_method(var_order, 'get_meta', [
		rt.new_string('_paypal_order_id'),
		rt.new_bool(true),
	])
	if !rt.is_true(var_paypal_order_id_from_order_meta)
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_paypal_order_id, var_paypal_order_id_from_order_meta)))) {
		mut iife_temp_3 := Class_WC_Gateway_Paypal{}
		mut iife_result_3 := iife_temp_3.log(rt.new_string('PayPal order ID mismatch. Order ID: ' +
			(rt.call_method(var_order, 'get_id', []rt.PhpVal{})).str() +
			'. PayPal order ID (request): ' + var_paypal_order_id.str() +
			'. PayPal order ID (order meta): ' + var_paypal_order_id_from_order_meta.str()))
		var_response = this.get_update_shipping_error_response('')
		return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(var_response.clone(),
			rt.new_int(422)))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.call_method(var_order, 'get_status', []rt.PhpVal{}),
		rt.create_array([
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_OrderStatus.checkout_draft()
			},
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.pending() },
		]),
		rt.new_bool(true),
	])))))
	{
		mut iife_temp_4 := Class_WC_Gateway_Paypal{}
		mut iife_result_4 := iife_temp_4.log(rt.new_string(
			'Order is not in a valid state for shipping updates. Order ID: ' +
			(rt.call_method(var_order, 'get_id', []rt.PhpVal{})).str() + '. Order status: ' +
			(rt.call_method(var_order, 'get_status', []rt.PhpVal{})).str()))
		var_response = this.get_update_shipping_error_response('')
		return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(var_response.clone(),
			rt.new_int(422)))
	}
	mut var_transaction_id := rt.call_method(var_order, 'get_transaction_id', []rt.PhpVal{})
	if !(!rt.is_true(var_transaction_id)) {
		mut iife_temp_5 := Class_WC_Gateway_Paypal{}
		mut iife_result_5 := iife_temp_5.log(rt.new_string(
			'Order already has a transaction ID, cannot update shipping. Order ID: ' +
			(rt.call_method(var_order, 'get_id', []rt.PhpVal{})).str() + '. Transaction ID: ' +
			var_transaction_id.str()))
		var_response = this.get_update_shipping_error_response('')
		return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(var_response.clone(),
			rt.new_int(422)))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'session')))))
	{
		rt.set_property(rt.call_function('WC', []rt.PhpVal{}), 'session',
			create_wc_session_handler())
	}
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'init',
		[]rt.PhpVal{})
	this.update_order_shipping_address(var_order.clone(), var_shipping_address.clone())
	this.rebuild_cart_from_order(var_order.clone())
	mut var_updated_shipping_options := this.get_updated_shipping_options(var_order.clone(),
		var_shipping_option.clone())
	if !rt.is_true(var_updated_shipping_options) {
		mut iife_temp_6 := Class_WC_Gateway_Paypal{}
		mut iife_result_6 := iife_temp_6.log(rt.new_string(
			'No shipping options found for address. Order ID: ' +
			(rt.call_method(var_order, 'get_id', []rt.PhpVal{})).str() + '. Address: ' +
			(rt.call_function('wp_json_encode', [var_shipping_address.clone()])).str()))
		var_response = this.get_update_shipping_error_response('')
		return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(var_response.clone(),
			rt.new_int(422)))
	}
	if !(!rt.is_true(var_shipping_option)) {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [
			rt.new_string('chosen_shipping_methods'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: var_shipping_option.array_get(rt.new_string('id')) },
			]),
		])
	}
	this.recompute_fees(var_order.clone())
	mut iife_temp_7 := Class_WC_Gateway_Paypal{}
	mut iife_result_7 := iife_temp_7.get_instance()
	mut var_paypal_request := create_automattic_woocommerce_gateways_paypal_request(iife_result_7)
	mut var_updated_amount :=
		var_paypal_request.get_paypal_order_purchase_unit_amount(var_order.clone())
	var_response = rt.create_array([rt.ArrayItem{ key: 'id', val: var_paypal_order_id },
		rt.ArrayItem{ key: 'purchase_units', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'reference_id'
					val: if var_purchase_units.array_get(rt.new_int(0)).array_isset(rt.new_string('reference_id')) {
						var_purchase_units.array_get(rt.new_int(0)).array_get(rt.new_string('reference_id'))
					} else {
						rt.new_string('')
					}
				},
				rt.ArrayItem{ key: 'amount', val: var_updated_amount },
				rt.ArrayItem{ key: 'shipping_options', val: var_updated_shipping_options },
			]) },
		]) }])
	return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(var_response.clone(),
		rt.new_int(200)))
}

fn (mut this Class_WC_REST_Paypal_Standard_Controller) rebuild_cart_from_order(var_order rt.PhpVal) {
	mut var_order_mutated := var_order
	rt.call_function('wc_load_cart', []rt.PhpVal{})
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'empty_cart',
		[]rt.PhpVal{})
	mut iter_1 := rt.call_method(var_order_mutated, 'get_items', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_item := item_1.val
		mut var_product_id := rt.call_method(var_item, 'get_product_id', []rt.PhpVal{})
		mut var_product := rt.call_method(var_item, 'get_product', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
			continue
		}
		if rt.is_true(rt.call_method(var_product, 'is_type', [
			rt.new_string('variation')]))
		{
			mut var_variation_id := rt.call_method(var_item, 'get_variation_id', []rt.PhpVal{})
			rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
				'add_to_cart', [var_product_id.clone(),
				rt.call_method(var_item, 'get_quantity', []rt.PhpVal{}),
				var_variation_id.clone()])
			continue
		}
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
			'add_to_cart', [var_product_id.clone(),
			rt.call_method(var_item, 'get_quantity', []rt.PhpVal{})])
	}
	if rt.is_true(rt.call_function('method_exists', [var_order_mutated.clone(),
		rt.new_string('get_coupon_codes')]))
	{
		mut iter_2 := rt.cast_array(rt.call_method(var_order_mutated, 'get_coupon_codes',
			[]rt.PhpVal{})).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_code := item_2.val
			if rt.is_true(var_code) {
				rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
					'apply_coupon', [var_code.clone()])
			}
		}
	}
	mut var_order_shipping_rate_id :=
		rt.new_string(this.get_order_shipping_rate_id(var_order_mutated.clone()))
	if !(!rt.is_true(var_order_shipping_rate_id)) {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [
			rt.new_string('chosen_shipping_methods'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_order_shipping_rate_id }]),
		])
	}
}

fn (mut this Class_WC_REST_Paypal_Standard_Controller) recompute_fees(var_order rt.PhpVal) {
	mut var_order_mutated := var_order
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
		'calculate_fees', []rt.PhpVal{})
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
		'calculate_shipping', []rt.PhpVal{})
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
		'calculate_totals', []rt.PhpVal{})
	rt.call_method(var_order_mutated, 'remove_order_items', []rt.PhpVal{})
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'checkout'),
		'set_data_from_cart', [var_order_mutated.clone()])
	rt.call_method(var_order_mutated, 'save', []rt.PhpVal{})
}

fn (mut this Class_WC_REST_Paypal_Standard_Controller) update_order_shipping_address(var_order rt.PhpVal, var_shipping_address rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_shipping_address_mutated := var_shipping_address
	mut var_country := if !(var_shipping_address_mutated.array_get(rt.new_string('country_code'))).is_null() {
		var_shipping_address_mutated.array_get(rt.new_string('country_code'))
	} else {
		rt.new_string('')
	}
	mut var_postcode := if !(var_shipping_address_mutated.array_get(rt.new_string('postal_code'))).is_null() {
		var_shipping_address_mutated.array_get(rt.new_string('postal_code'))
	} else {
		rt.new_string('')
	}
	mut var_state := if !(var_shipping_address_mutated.array_get(rt.new_string('admin_area_1'))).is_null() {
		var_shipping_address_mutated.array_get(rt.new_string('admin_area_1'))
	} else {
		rt.new_string('')
	}
	mut var_city := if !(var_shipping_address_mutated.array_get(rt.new_string('admin_area_2'))).is_null() {
		var_shipping_address_mutated.array_get(rt.new_string('admin_area_2'))
	} else {
		rt.new_string('')
	}
	rt.call_method(var_order_mutated, 'set_shipping_country', [
		var_country.clone()])
	rt.call_method(var_order_mutated, 'set_shipping_postcode', [
		var_postcode.clone()])
	rt.call_method(var_order_mutated, 'set_shipping_state', [
		var_state.clone()])
	rt.call_method(var_order_mutated, 'set_shipping_city', [var_city.clone()])
	rt.call_method(var_order_mutated, 'set_shipping_address_1', [
		rt.new_string('')])
	rt.call_method(var_order_mutated, 'set_shipping_address_2', [
		rt.new_string('')])
	rt.call_method(var_order_mutated, 'save', []rt.PhpVal{})
	mut var_customer := create_wc_customer()
	var_customer.set_location(var_country.clone(), var_state.clone(), var_postcode.clone(),
		var_city.clone())
	var_customer.set_shipping_location(var_country.clone(), var_state.clone(),
		var_postcode.clone(), var_city.clone())
	var_customer.set_calculated_shipping(rt.new_bool(true))
	rt.set_property(rt.call_function('WC', []rt.PhpVal{}), 'customer', var_customer)
}

fn (mut this Class_WC_REST_Paypal_Standard_Controller) get_updated_shipping_options(var_order rt.PhpVal, var_selected_shipping_option rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
		'calculate_shipping', []rt.PhpVal{})
	mut var_packages := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
		'shipping', []rt.PhpVal{}), 'get_packages', []rt.PhpVal{})
	mut var_order_shipping_rate_id :=
		rt.new_string(this.get_order_shipping_rate_id(var_order_mutated.clone()))
	mut var_has_selected_shipping_option := rt.new_bool(false)
	mut var_options := []rt.PhpVal{}
	mut iter_3 := var_packages.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_package := item_3.val
		mut var_rates := if !(var_package.array_get(rt.new_string('rates'))).is_null() {
			var_package.array_get(rt.new_string('rates'))
		} else {
			[]rt.PhpVal{}
		}
		mut iter_4 := var_rates.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_rate := item_4.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_rate,
				'WC_Shipping_Rate'))))))
			{
				continue
			}
			mut var_shipping_option_id := rt.call_method(var_rate, 'get_id', []rt.PhpVal{})
			if var_selected_shipping_option.array_isset(rt.new_string('id')) {
				mut var_is_selected := rt.identical(var_shipping_option_id,
					var_selected_shipping_option.array_get(rt.new_string('id')))
			} else {
				var_is_selected = rt.identical(var_shipping_option_id, var_order_shipping_rate_id)
			}
			if rt.is_true(var_is_selected) {
				var_has_selected_shipping_option = rt.new_bool(true)
			}
			var_options << rt.create_array([
				rt.ArrayItem{ key: 'id', val: var_shipping_option_id },
				rt.ArrayItem{ key: 'type', val: 'SHIPPING' },
				rt.ArrayItem{ key: 'amount', val: rt.create_array([
					rt.ArrayItem{ key: 'currency_code', val: rt.call_method(var_order_mutated,
						'get_currency', []rt.PhpVal{}) },
					rt.ArrayItem{ key: 'value', val: rt.call_function('wc_format_decimal', [
						rt.new_float((rt.call_method(var_rate, 'get_cost', []rt.PhpVal{})).to_f64()),
						rt.call_function('wc_get_price_decimals', []rt.PhpVal{}),
					]) },
				]) },
				rt.ArrayItem{ key: 'label', val: rt.call_method(var_rate, 'get_label',
					[]rt.PhpVal{}) },
				rt.ArrayItem{ key: 'selected', val: var_is_selected },
			])
		}
	}
	if !(!rt.is_true(var_options))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_has_selected_shipping_option)))) {
		var_options.array_get_mut(0).array_set('selected', true)
	}
	return var_options.clone()
}

fn (mut this Class_WC_REST_Paypal_Standard_Controller) get_order_shipping_rate_id(var_order rt.PhpVal) string {
	mut var_order_mutated := var_order
	mut var_order_shipping_item := if !(rt.call_function('current', [
		rt.call_method(var_order_mutated, 'get_items', [rt.new_string('shipping')]),
	])).is_null() { rt.call_function('current', [
			rt.call_method(var_order_mutated, 'get_items', [rt.new_string('shipping')]),
		]) } else { rt.new_null() }
	if rt.is_true(var_order_shipping_item) {
		mut var_method_id := rt.call_method(var_order_shipping_item, 'get_method_id', []rt.PhpVal{})
		mut var_instance_id := rt.call_method(var_order_shipping_item, 'get_instance_id',
			[]rt.PhpVal{})
		mut var_rate_id := if rt.is_true(rt.identical(rt.new_string(''), var_instance_id))
			|| rt.is_true(rt.identical(rt.new_null(), var_instance_id)) {
			var_method_id
		} else {
			rt.new_string('${var_method_id.to_string()}:${var_instance_id.to_string()}')
		}
		return var_rate_id.str()
	}
	return ''
}

fn (mut this Class_WC_REST_Paypal_Standard_Controller) get_update_shipping_error_response(issue string) rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'name', val: 'UNPROCESSABLE_ENTITY' },
		rt.ArrayItem{ key: 'details', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'issue', val: issue },
			]) },
		]) }])
}

struct Class_WC_REST_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_Helper {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

struct Class_WC_Gateway_Paypal {
	rt.PhpObjectBase
}

struct Class_WC_Session_Handler {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_Request {
	rt.PhpObjectBase
}

struct Class_WC_Customer {
	rt.PhpObjectBase
}

fn create_wc_rest_paypal_standard_controller(_args ...rt.PhpVal) &Class_WC_REST_Paypal_Standard_Controller {
	mut obj := &Class_WC_REST_Paypal_Standard_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v3')
		rest_base:     rt.new_string('paypal-standard')
	}
	return obj
}

fn create_wc_rest_controller(_args ...rt.PhpVal) &Class_WC_REST_Controller {
	mut obj := &Class_WC_REST_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_gateways_paypal_helper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Gateways_PayPal_Helper {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_response(_args ...rt.PhpVal) &Class_WP_REST_Response {
	mut obj := &Class_WP_REST_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_gateway_paypal(_args ...rt.PhpVal) &Class_WC_Gateway_Paypal {
	mut obj := &Class_WC_Gateway_Paypal{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_session_handler(_args ...rt.PhpVal) &Class_WC_Session_Handler {
	mut obj := &Class_WC_Session_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_gateways_paypal_request(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Gateways_PayPal_Request {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_customer(_args ...rt.PhpVal) &Class_WC_Customer {
	mut obj := &Class_WC_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Paypal_Standard_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'validate_shipping_callback_request' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.validate_shipping_callback_request(mut dispatch_arg_0))
		}
		'process_shipping_callback' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.process_shipping_callback(mut dispatch_arg_0)
		}
		'rebuild_cart_from_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.rebuild_cart_from_order(dispatch_arg_0)
			return rt.new_null()
		}
		'recompute_fees' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.recompute_fees(dispatch_arg_0)
			return rt.new_null()
		}
		'update_order_shipping_address' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.update_order_shipping_address(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_updated_shipping_options' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_updated_shipping_options(dispatch_arg_0, dispatch_arg_1)
		}
		'get_order_shipping_rate_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_order_shipping_rate_id(dispatch_arg_0))
		}
		'get_update_shipping_error_response' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_update_shipping_error_response(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_REST_Paypal_Standard_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Paypal_Standard_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		'rest_base' {
			this.rest_base = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_REST_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Gateways_PayPal_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Gateway_Paypal) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Gateway_Paypal) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Gateway_Paypal) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Session_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Session_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Session_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Gateways_PayPal_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Customer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Customer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Customer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Gateway_Paypal'),
	])))))
	{
		rt.include_file(
			(rt.get_constant('WC_ABSPATH')).str() + 'includes/gateways/paypal/class-wc-gateway-paypal.php',
			'4')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Gateway_Paypal_Request'),
	])))))
	{
		rt.include_file(
			(rt.get_constant('WC_ABSPATH')).str() + 'includes/gateways/paypal/includes/class-wc-gateway-paypal-request.php',
			'4')
	}
}
