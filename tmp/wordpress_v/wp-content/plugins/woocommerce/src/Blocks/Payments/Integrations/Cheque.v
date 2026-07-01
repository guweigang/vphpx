import rt

struct Class_Automattic_WooCommerce_Blocks_Payments_Integrations_Cheque {
	rt.PhpObjectBase
pub mut:
	name      rt.PhpVal = rt.new_null()
	asset_api rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_Cheque) construct(mut var_asset_api Class_Automattic_WooCommerce_Blocks_Assets_Api) {
	this.asset_api = var_asset_api.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_Cheque) initialize() {
	this.dispatch_set_prop('settings', rt.call_function('get_option', [
		rt.new_string('woocommerce_cheque_settings'),
		rt.new_array(),
	]))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_Cheque) is_active() rt.PhpVal {
	return rt.call_function('filter_var', [
		this.get_setting(rt.new_string('enabled'), rt.new_bool(false)),
		rt.get_constant('FILTER_VALIDATE_BOOLEAN'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_Cheque) get_payment_method_script_handles() rt.PhpVal {
	rt.call_method(this.asset_api, 'register_script', [
		rt.new_string('wc-payment-method-cheque'),
		rt.new_string('assets/client/blocks/wc-payment-method-cheque.js'),
	])
	return rt.create_array([rt.ArrayItem{ key: none, val: 'wc-payment-method-cheque' }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_Cheque) get_payment_method_data() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'title', val: this.get_setting(rt.new_string('title')) },
		rt.ArrayItem{ key: 'description', val: this.get_setting(rt.new_string('description')) },
		rt.ArrayItem{ key: 'supports', val: this.get_supported_features() },
	])
}

struct Class_Automattic_WooCommerce_Blocks_Payments_Integrations_AbstractPaymentMethodType {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_payments_integrations_cheque(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Payments_Integrations_Cheque {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Payments_Integrations_Cheque{
		PhpObjectBase: rt.PhpObjectBase{}
		name:          rt.new_null()
		asset_api:     rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_blocks_payments_integrations_abstractpaymentmethodtype() &Class_Automattic_WooCommerce_Blocks_Payments_Integrations_AbstractPaymentMethodType {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Payments_Integrations_AbstractPaymentMethodType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_Cheque) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Assets_Api](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'is_active' {
			return this.is_active()
		}
		'get_payment_method_script_handles' {
			return this.get_payment_method_script_handles()
		}
		'get_payment_method_data' {
			return this.get_payment_method_data()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Payments_Integrations_Cheque) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'asset_api' { return this.asset_api }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_Cheque) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' {
			this.name = val
			return true
		}
		'asset_api' {
			this.asset_api = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_AbstractPaymentMethodType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Payments_Integrations_AbstractPaymentMethodType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_AbstractPaymentMethodType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_payments_integrations_cheque_php() {
}
