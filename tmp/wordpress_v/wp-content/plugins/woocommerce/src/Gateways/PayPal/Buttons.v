import rt

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Buttons.client_id_option() string {
	return 'woocommerce_paypal_client_id'
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_Buttons {
	rt.PhpObjectBase
pub mut:
	gateway rt.PhpVal = rt.new_null()
	enabled bool
	request rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Buttons) construct(mut var_gateway Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal) {
	this.gateway = var_gateway.dup()
	this.request = create_automattic_woocommerce_gateways_paypal_request(this.gateway)
	this.enabled = rt.is_true(rt.call_method(this.gateway, 'should_use_orders_v2', []rt.PhpVal{}))
		&& rt.is_true(rt.identical(rt.new_string('yes'), rt.call_method(this.gateway, 'get_option', [rt.new_string('paypal_buttons'), rt.new_string('yes')])))
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Buttons) get_options() rt.PhpVal {
	mut var_common_options := this.get_common_options()
	mut var_options := rt.create_array([
		rt.ArrayItem{ key: 'partner-attribution-id', val: 'Woo_Cart_CoreUpgrade' },
		rt.ArrayItem{ key: 'page-type', val: this.get_page_type() },
	])
	return rt.call_function('array_merge', [var_common_options.dup(),
		var_options.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Buttons) get_common_options() rt.PhpVal {
	mut var_intent := rt.new_string(if rt.is_true(rt.identical(rt.call_method(this.gateway, 'get_option', [
		rt.new_string('paymentaction'),
	]), rt.new_string('authorization')))
	{ rt.new_string('authorize') } else { rt.new_string('capture') })
	return rt.create_array([rt.ArrayItem{ key: 'client-id', val: this.get_client_id() },
		rt.ArrayItem{ key: 'components', val: 'buttons,funding-eligibility,messages' },
		rt.ArrayItem{ key: 'disable-funding', val: 'card,applepay' },
		rt.ArrayItem{ key: 'enable-funding', val: 'venmo,paylater' },
		rt.ArrayItem{ key: 'currency', val: rt.call_function('get_woocommerce_currency',
			[]rt.PhpVal{}) }, rt.ArrayItem{ key: 'intent', val: var_intent },
		rt.ArrayItem{ key: 'merchant-id', val: rt.get_property(this.gateway, 'email') }])
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Buttons) get_client_id() string {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.gateway, 'should_use_orders_v2',
		[]rt.PhpVal{})))))
	{
		return (rt.new_null()).str()
	}
	mut var_option_key := rt.new_string(
		(Class_Automattic_WooCommerce_Gateways_PayPal_Automattic_WooCommerce_Gateways_PayPal_Buttons.client_id_option()).str() + if rt.is_true(rt.get_property(this.gateway, 'testmode')) { '_sandbox' } else { '_live' })
	mut var_client_id := rt.call_function('get_option', [var_option_key.dup(),
		rt.new_null()])
	if !rt.is_true(var_client_id) {
		var_client_id = rt.call_method(this.request, 'fetch_paypal_client_id', []rt.PhpVal{})
		if !rt.is_true(var_client_id) {
			return (rt.new_null()).str()
		}
		rt.call_function('update_option', [var_option_key.dup(),
			var_client_id.dup()])
	}
	return var_client_id.str()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Buttons) get_page_type() string {
	mut var_page_type := rt.new_string(rt.new_string('checkout'))
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_cart', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('has_block', [rt.new_string('woocommerce/cart')]))))
	{
		var_page_type = rt.new_string(rt.new_string('cart'))
	} else if rt.is_true(rt.call_function('is_product', []rt.PhpVal{})) {
		var_page_type = rt.new_string(rt.new_string('product-details'))
	}
	return var_page_type.str()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Buttons) is_enabled() bool {
	return this.enabled
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Buttons) get_current_page_for_app_switch() string {
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Proxies_LegacyProxy.class()]), 'call_function', [rt.new_string('is_checkout')]))
		|| rt.is_true(rt.call_function('is_cart', []rt.PhpVal{}))))
		|| rt.is_true(rt.call_function('is_product', []rt.PhpVal{}))))
	{
		return (rt.call_function('get_permalink', [
			rt.call_function('get_the_ID', []rt.PhpVal{}),
		])).str()
	}
	return ''
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_Request {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_gateways_paypal_buttons(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Gateways_PayPal_Buttons {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_Buttons{
		PhpObjectBase: rt.PhpObjectBase{}
		gateway:       rt.new_null()
		enabled:       false
		request:       rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_gateways_paypal_request() &Class_Automattic_WooCommerce_Gateways_PayPal_Request {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Buttons) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_options' {
			return this.get_options()
		}
		'get_common_options' {
			return this.get_common_options()
		}
		'get_client_id' {
			return rt.new_string(this.get_client_id())
		}
		'get_page_type' {
			return rt.new_string(this.get_page_type())
		}
		'is_enabled' {
			return rt.new_bool(this.is_enabled())
		}
		'get_current_page_for_app_switch' {
			return rt.new_string(this.get_current_page_for_app_switch())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Gateways_PayPal_Buttons) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'gateway' { return this.gateway }
		'enabled' { return rt.new_bool(this.enabled) }
		'request' { return this.request }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Buttons) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'gateway' {
			this.gateway = val
			return true
		}
		'enabled' {
			this.enabled = val.to_bool()
			return true
		}
		'request' {
			this.request = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

pub fn init_wp_content_plugins_woocommerce_src_gateways_paypal_buttons_php() {
	// unsupported statement: Stmt_Declare
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
}
