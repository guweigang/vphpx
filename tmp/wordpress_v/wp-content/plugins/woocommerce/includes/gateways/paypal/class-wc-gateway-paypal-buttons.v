import rt

struct Class_WC_Gateway_Paypal_Buttons {
	rt.PhpObjectBase
pub mut:
	buttons rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Gateway_Paypal_Buttons) construct(mut var_gateway Class_WC_Gateway_Paypal) {
	this.buttons = create_automattic_woocommerce_gateways_paypal_buttons(var_gateway.dup())
}

fn (mut this Class_WC_Gateway_Paypal_Buttons) get_options() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('10.5.0'),
		rt.new_string('Use Automattic\\WooCommerce\\Gateways\\PayPal\\Buttons::get_options() instead.')])
	return rt.call_method(this.buttons, 'get_options', []rt.PhpVal{})
}

fn (mut this Class_WC_Gateway_Paypal_Buttons) get_common_options() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('10.5.0'),
		rt.new_string('Use Automattic\\WooCommerce\\Gateways\\PayPal\\Buttons::get_common_options() instead.')])
	return rt.call_method(this.buttons, 'get_common_options', []rt.PhpVal{})
}

fn (mut this Class_WC_Gateway_Paypal_Buttons) get_client_id() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('10.5.0'),
		rt.new_string('Use Automattic\\WooCommerce\\Gateways\\PayPal\\Buttons::get_client_id() instead.')])
	return rt.call_method(this.buttons, 'get_client_id', []rt.PhpVal{})
}

fn (mut this Class_WC_Gateway_Paypal_Buttons) get_page_type() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('10.5.0'),
		rt.new_string('Use Automattic\\WooCommerce\\Gateways\\PayPal\\Buttons::get_page_type() instead.')])
	return rt.call_method(this.buttons, 'get_page_type', []rt.PhpVal{})
}

fn (mut this Class_WC_Gateway_Paypal_Buttons) is_enabled() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('10.5.0'),
		rt.new_string('Use Automattic\\WooCommerce\\Gateways\\PayPal\\Buttons::is_enabled() instead.')])
	return rt.call_method(this.buttons, 'is_enabled', []rt.PhpVal{})
}

fn (mut this Class_WC_Gateway_Paypal_Buttons) get_current_page_for_app_switch() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('10.5.0'),
		rt.new_string('Use Automattic\\WooCommerce\\Gateways\\PayPal\\Buttons::get_current_page_for_app_switch() instead.')])
	return rt.call_method(this.buttons, 'get_current_page_for_app_switch', []rt.PhpVal{})
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_Buttons {
	rt.PhpObjectBase
}

fn create_wc_gateway_paypal_buttons(arg_0 rt.PhpVal) &Class_WC_Gateway_Paypal_Buttons {
	mut obj := &Class_WC_Gateway_Paypal_Buttons{
		PhpObjectBase: rt.PhpObjectBase{}
		buttons:       rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_gateways_paypal_buttons() &Class_Automattic_WooCommerce_Gateways_PayPal_Buttons {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_Buttons{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Gateway_Paypal_Buttons) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Gateway_Paypal](if args.len > 0 {
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
			return this.get_client_id()
		}
		'get_page_type' {
			return this.get_page_type()
		}
		'is_enabled' {
			return this.is_enabled()
		}
		'get_current_page_for_app_switch' {
			return this.get_current_page_for_app_switch()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Gateway_Paypal_Buttons) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'buttons' { return this.buttons }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Gateway_Paypal_Buttons) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'buttons' {
			this.buttons = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Buttons) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Gateways_PayPal_Buttons) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Buttons) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_includes_gateways_paypal_class_wc_gateway_paypal_buttons_php() {
	// unsupported statement: Stmt_Declare
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Gateway_Paypal_Request'),
	])))))
	{
		rt.include_file(@DIR + '/includes/class-wc-gateway-paypal-request.php', '4')
	}
}
