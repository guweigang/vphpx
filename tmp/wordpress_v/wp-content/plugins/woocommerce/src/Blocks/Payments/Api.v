import rt

struct Class_Automattic_WooCommerce_Blocks_Payments_Api {
	rt.PhpObjectBase
pub mut:
	payment_method_registry rt.PhpVal = rt.new_null()
	asset_registry          rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Api) construct(mut var_payment_method_registry Class_Automattic_WooCommerce_Blocks_Payments_PaymentMethodRegistry, mut var_asset_registry Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) {
	this.payment_method_registry = var_payment_method_registry.dup()
	this.asset_registry = var_asset_registry.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Api) init() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([rt.ArrayItem{ key: none, val: this.payment_method_registry },
			rt.ArrayItem{ key: none, val: 'initialize' }]),
		rt.new_int(5)])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_blocks_register_script_dependencies'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Payments_Api',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_payment_method_script_dependencies' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_blocks_checkout_enqueue_data'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Payments_Api',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_payment_method_script_data' },
		]),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_blocks_cart_enqueue_data'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Payments_Api',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_payment_method_script_data' },
		]),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_blocks_payment_method_type_registration'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Payments_Api',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'register_payment_method_integrations' },
		]),
	])
	rt.call_function('add_action', [rt.new_string('wp_print_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Payments_Api',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'verify_payment_methods_dependencies' },
		]),
		rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Api) add_payment_method_script_dependencies(var_dependencies rt.PhpVal, var_handle rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_handle.dup(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'wc-checkout-block' },
			rt.ArrayItem{ key: none, val: 'wc-checkout-block-frontend' },
			rt.ArrayItem{ key: none, val: 'wc-cart-block' },
			rt.ArrayItem{ key: none, val: 'wc-cart-block-frontend' },
		]),
		rt.new_bool(true)])))))
	{
		return var_dependencies.dup()
	}
	return rt.call_function('array_merge', [var_dependencies.dup(),
		rt.call_method(this.payment_method_registry,
			'get_all_active_payment_method_script_dependencies', []rt.PhpVal{})])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Api) is_payment_gateway_enabled(var_gateway rt.PhpVal) rt.PhpVal {
	return rt.call_function('filter_var', [rt.get_property(var_gateway, 'enabled'),
		rt.get_constant('FILTER_VALIDATE_BOOLEAN')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Api) add_payment_method_script_data() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.asset_registry, 'exists', [
		rt.new_string('paymentMethodSortOrder'),
	])))))
	{
		mut var_payment_gateways := rt.call_method(rt.get_property(rt.call_function('WC',
			[]rt.PhpVal{}), 'payment_gateways'), 'payment_gateways', []rt.PhpVal{})
		mut var_enabled_gateways := rt.call_function('array_filter', [
			var_payment_gateways.dup(),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Payments_Api',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'is_payment_gateway_enabled' },
			])])
		rt.call_method(this.asset_registry, 'add', [
			rt.new_string('paymentMethodSortOrder'),
			rt.func_array_keys(var_enabled_gateways.dup()),
		])
	}
	mut var_script_data := rt.call_method(this.payment_method_registry,
		'get_all_registered_script_data', []rt.PhpVal{})
	{
		mut iter_1 := var_script_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_asset_data_value := item_1.val
			mut var_asset_data_key := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.asset_registry, 'exists', [
				var_asset_data_key.dup(),
			])))))
			{
				rt.call_method(this.asset_registry, 'add', [var_asset_data_key.dup(),
					var_asset_data_value.dup()])
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Api) register_payment_method_integrations(mut var_payment_method_registry Class_Automattic_WooCommerce_Blocks_Payments_PaymentMethodRegistry) {
	var_payment_method_registry.register(rt.call_method(fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Package{}
		return temp.container()
	}(), 'get', [
		Class_Automattic_WooCommerce_Blocks_Payments_Integrations_Cheque.class(),
	]))
	var_payment_method_registry.register(rt.call_method(fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Package{}
		return temp.container()
	}(), 'get', [
		Class_Automattic_WooCommerce_Blocks_Payments_Integrations_PayPal.class(),
	]))
	var_payment_method_registry.register(rt.call_method(fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Package{}
		return temp.container()
	}(), 'get', [
		Class_Automattic_WooCommerce_Blocks_Payments_Integrations_BankTransfer.class(),
	]))
	var_payment_method_registry.register(rt.call_method(fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Package{}
		return temp.container()
	}(), 'get', [
		Class_Automattic_WooCommerce_Blocks_Payments_Integrations_CashOnDelivery.class(),
	]))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Api) verify_payment_methods_dependencies() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_script_is', [
		rt.new_string('wc-blocks'),
		rt.new_string('registered'),
	])))))
	{
		return rt.new_null()
	}
	mut var_wp_scripts := rt.call_function('wp_scripts', []rt.PhpVal{})
	mut var_payment_method_scripts := rt.call_method(this.payment_method_registry,
		'get_all_active_payment_method_script_dependencies', []rt.PhpVal{})
	{
		mut iter_1 := var_payment_method_scripts.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_payment_method_script := item_1.val
			if rt.is_true(rt.new_bool(
				rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_wp_scripts, 'registered').array_isset(var_payment_method_script.dup()))))))
				|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('property_exists', [rt.get_property(var_wp_scripts, 'registered').array_get(var_payment_method_script), rt.new_string('deps')])))))))
			{
				continue
			}
			mut var_deps := rt.get_property(rt.get_property(var_wp_scripts, 'registered').array_get(var_payment_method_script),
				'deps')
			{
				mut iter_2 := var_deps.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_dep := item_2.val
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_script_is', [
						var_dep.dup(),
						rt.new_string('registered'),
					])))))
					{
						mut var_error_handle := rt.new_string(var_dep.str() + '-dependency-error')
						mut var_error_message := rt.call_function('sprintf', [
							rt.new_string("Payment gateway with handle '%1$s' has been deactivated in Cart and Checkout blocks because its dependency '%2$s' is not registered. Read the docs about registering assets for payment methods: https://github.com/woocommerce/woocommerce-blocks/blob/060f63c04f0f34f645200b5d4da9212125c49177/docs/third-party-developers/extensibility/checkout-payment-methods/payment-method-integration.md#registering-assets"),
							rt.call_function('esc_html', [var_payment_method_script.dup()]),
							rt.call_function('esc_html', [var_dep.dup()]),
						])
						rt.call_function('error_log', [var_error_message.dup()])
						rt.call_function('wp_register_script', [
							var_error_handle.dup(), rt.new_string('')])
						rt.call_function('wp_enqueue_script', [
							var_error_handle.dup()])
						rt.call_function('wp_add_inline_script', [
							var_error_handle.dup(),
							rt.call_function('sprintf', [
								rt.new_string('console.error( "%s" );'),
								var_error_message.dup(),
							])])
						mut var_cart_checkout_scripts := rt.create_array([
							rt.ArrayItem{ key: none, val: 'wc-cart-block' },
							rt.ArrayItem{ key: none, val: 'wc-cart-block-frontend' },
							rt.ArrayItem{ key: none, val: 'wc-checkout-block' },
							rt.ArrayItem{ key: none, val: 'wc-checkout-block-frontend' },
						])
						{
							mut iter_3 := var_cart_checkout_scripts.iterator()
							for {
								item_3 := iter_3.next() or { break }
								mut var_script_handle := item_3.val
								if rt.is_true(rt.new_bool(
									rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_wp_scripts, 'registered').array_isset(var_script_handle.dup()))))))
									|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('property_exists', [rt.get_property(var_wp_scripts, 'registered').array_get(var_script_handle), rt.new_string('deps')])))))))
								{
									continue
								}
								rt.set_property(rt.get_property(var_wp_scripts, 'registered').array_get(var_script_handle),
									'deps', rt.call_function('array_diff', [
									rt.get_property(rt.get_property(var_wp_scripts, 'registered').array_get(var_script_handle),
										'deps'),
									rt.create_array([
										rt.ArrayItem{ key: none, val: var_payment_method_script },
									]),
								]))
							}
						}
					}
				}
			}
		}
	}
}

struct Class_Automattic_WooCommerce_Blocks_Package {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_payments_api(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Payments_Api {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Payments_Api{
		PhpObjectBase:           rt.PhpObjectBase{}
		payment_method_registry: rt.new_null()
		asset_registry:          rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_automattic_woocommerce_blocks_package() &Class_Automattic_WooCommerce_Blocks_Package {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Package{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Api) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Payments_PaymentMethodRegistry](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'add_payment_method_script_dependencies' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_payment_method_script_dependencies(dispatch_arg_0, dispatch_arg_1)
		}
		'is_payment_gateway_enabled' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_payment_gateway_enabled(dispatch_arg_0)
		}
		'add_payment_method_script_data' {
			this.add_payment_method_script_data()
			return rt.new_null()
		}
		'register_payment_method_integrations' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Payments_PaymentMethodRegistry](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.register_payment_method_integrations(mut dispatch_arg_0)
			return rt.new_null()
		}
		'verify_payment_methods_dependencies' {
			this.verify_payment_methods_dependencies()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Payments_Api) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'payment_method_registry' { return this.payment_method_registry }
		'asset_registry' { return this.asset_registry }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Api) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'payment_method_registry' {
			this.payment_method_registry = val
			return true
		}
		'asset_registry' {
			this.asset_registry = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_payments_api_php() {
}
