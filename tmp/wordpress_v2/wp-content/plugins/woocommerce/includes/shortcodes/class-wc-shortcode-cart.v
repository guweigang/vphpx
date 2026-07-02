import rt

struct Class_WC_Shortcode_Cart {
	rt.PhpObjectBase
}

fn Class_WC_Shortcode_Cart.calculate_shipping() {
	rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping', []rt.PhpVal{}),
		'reset_shipping', []rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_address := rt.new_array()
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_address.array_set('country', if rt.get_superglobal('_POST').array_isset(rt.new_string('calc_shipping_country')) { rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('calc_shipping_country')),
			]),
		]) } else { rt.new_string('') })
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_address.array_set('state', if rt.get_superglobal('_POST').array_isset(rt.new_string('calc_shipping_state')) { rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('calc_shipping_state')),
			]),
		]) } else { rt.new_string('') })
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_address.array_set('postcode', if rt.get_superglobal('_POST').array_isset(rt.new_string('calc_shipping_postcode')) { rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('calc_shipping_postcode')),
			]),
		]) } else { rt.new_string('') })
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_address.array_set('city', if rt.get_superglobal('_POST').array_isset(rt.new_string('calc_shipping_city')) { rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('calc_shipping_city')),
			]),
		]) } else { rt.new_string('') })
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(var_address.array_get(rt.new_string('postcode'))) {
		var_address.array_set('postcode', rt.call_function('wc_format_postcode', [
			var_address.array_get(rt.new_string('postcode')),
			var_address.array_get(rt.new_string('country')),
		]))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_address = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cart_calculate_shipping_address'),
		var_address.clone(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut iife_temp_0 := Class_WC_Validation{}
	mut iife_result_0 := iife_temp_0.is_postcode(var_address.array_get(rt.new_string('postcode')),
		var_address.array_get(rt.new_string('country')))
	if rt.is_true(var_address.array_get(rt.new_string('postcode')))
		&& rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
			rt.new_string('Please enter a valid postcode / ZIP.'),
			rt.new_string('woocommerce'),
		]))))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(var_address.array_get(rt.new_string('country'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC',
			[]rt.PhpVal{}), 'customer'), 'get_billing_first_name', []rt.PhpVal{})))))
		{
			rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'),
				'set_billing_location', [var_address.array_get(rt.new_string('country')),
				var_address.array_get(rt.new_string('state')),
				var_address.array_get(rt.new_string('postcode')),
				var_address.array_get(rt.new_string('city'))])
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'),
			'set_shipping_location', [var_address.array_get(rt.new_string('country')),
			var_address.array_get(rt.new_string('state')), var_address.array_get(rt.new_string('postcode')),
			var_address.array_get(rt.new_string('city'))])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	} else {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'),
			'set_billing_address_to_base', []rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'),
			'set_shipping_address_to_base', []rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'),
		'set_calculated_shipping', [rt.new_bool(true)])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'), 'save',
		[]rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_function('wc_add_notice', [
		rt.call_function('__', [rt.new_string('Shipping costs updated.'),
			rt.new_string('woocommerce')]),
		rt.new_string('notice'),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_calculated_shipping')])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		if !(!rt.is_true(var_e)) {
			rt.call_function('wc_add_notice', [
				rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
				rt.new_string('error'),
			])
		}
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
}

fn Class_WC_Shortcode_Cart.output(var_atts rt.PhpVal) {
	mut var_atts_mutated := var_atts
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_output_cart_shortcode_content'),
		rt.new_bool(true),
	])))))
	{
		return
	}
	rt.call_function('wc_maybe_define_constant', [rt.new_string('WOOCOMMERCE_CART'),
		rt.new_bool(true)])
	var_atts_mutated = rt.call_function('shortcode_atts', [rt.new_array(),
		var_atts_mutated.clone(), rt.new_string('woocommerce_cart')])
	mut var_nonce_value := rt.call_function('wc_get_var', [
		rt.get_superglobal('_REQUEST').array_get(rt.new_string('woocommerce-shipping-calculator-nonce')),
		rt.call_function('wc_get_var', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wpnonce')),
			rt.new_string('')]),
	])
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('calc_shipping'))))
		&& rt.is_true(rt.call_function('wp_verify_nonce', [var_nonce_value.clone(), rt.new_string('woocommerce-shipping-calculator')]))
		|| rt.is_true(rt.call_function('wp_verify_nonce', [var_nonce_value.clone(), rt.new_string('woocommerce-cart')])) {
		Class_WC_Shortcode_Cart.calculate_shipping()
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
			'calculate_totals', []rt.PhpVal{})
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_check_cart_items')])
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
		'calculate_totals', []rt.PhpVal{})
	if rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
		'is_empty', []rt.PhpVal{}))
	{
		rt.call_function('wc_get_template', [rt.new_string('cart/cart-empty.php')])
	} else {
		rt.call_function('wc_get_template', [rt.new_string('cart/cart.php')])
	}
}

struct Class_WC_Validation {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
	message string
	code    i64
	file    string
	line    i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

fn create_wc_shortcode_cart(_args ...rt.PhpVal) &Class_WC_Shortcode_Cart {
	mut obj := &Class_WC_Shortcode_Cart{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_validation(_args ...rt.PhpVal) &Class_WC_Validation {
	mut obj := &Class_WC_Validation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_WC_Shortcode_Cart) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'calculate_shipping' {
			Class_WC_Shortcode_Cart.calculate_shipping()
			return rt.new_null()
		}
		'output' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Shortcode_Cart.output(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Shortcode_Cart) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shortcode_Cart) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Validation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Validation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Validation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
