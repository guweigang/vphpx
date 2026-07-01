import rt

struct Class_Automattic_WooCommerce_Blocks_Payments_Integrations_AbstractPaymentMethodType {
	rt.PhpObjectBase
pub mut:
	name     rt.PhpVal = rt.new_string('')
	settings rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_AbstractPaymentMethodType) get_setting(var_name rt.PhpVal, default string) rt.PhpVal {
	return if this.settings.array_isset(var_name) {
		this.settings.array_get(var_name)
	} else {
		rt.new_string(default)
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_AbstractPaymentMethodType) get_name() rt.PhpVal {
	return this.name
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_AbstractPaymentMethodType) is_active() bool {
	return true
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_AbstractPaymentMethodType) get_payment_method_script_handles() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_AbstractPaymentMethodType) get_payment_method_script_handles_for_admin() rt.PhpVal {
	return this.get_payment_method_script_handles()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_AbstractPaymentMethodType) get_supported_features() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'products' }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_AbstractPaymentMethodType) get_payment_method_data() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_AbstractPaymentMethodType) get_script_handles() rt.PhpVal {
	return this.get_payment_method_script_handles()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_AbstractPaymentMethodType) get_editor_script_handles() rt.PhpVal {
	return this.get_payment_method_script_handles_for_admin()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_AbstractPaymentMethodType) get_script_data() rt.PhpVal {
	return this.get_payment_method_data()
}

fn create_automattic_woocommerce_blocks_payments_integrations_abstractpaymentmethodtype() &Class_Automattic_WooCommerce_Blocks_Payments_Integrations_AbstractPaymentMethodType {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Payments_Integrations_AbstractPaymentMethodType{
		PhpObjectBase: rt.PhpObjectBase{}
		name:          rt.new_string('')
		settings:      rt.new_array()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_AbstractPaymentMethodType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_setting' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_setting(dispatch_arg_0, dispatch_arg_1)
		}
		'get_name' {
			return this.get_name()
		}
		'is_active' {
			return rt.new_bool(this.is_active())
		}
		'get_payment_method_script_handles' {
			return this.get_payment_method_script_handles()
		}
		'get_payment_method_script_handles_for_admin' {
			return this.get_payment_method_script_handles_for_admin()
		}
		'get_supported_features' {
			return this.get_supported_features()
		}
		'get_payment_method_data' {
			return this.get_payment_method_data()
		}
		'get_script_handles' {
			return this.get_script_handles()
		}
		'get_editor_script_handles' {
			return this.get_editor_script_handles()
		}
		'get_script_data' {
			return this.get_script_data()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Payments_Integrations_AbstractPaymentMethodType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'settings' { return this.settings }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_AbstractPaymentMethodType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' {
			this.name = val
			return true
		}
		'settings' {
			this.settings = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_payments_integrations_abstractpaymentmethodtype_php() {
}
