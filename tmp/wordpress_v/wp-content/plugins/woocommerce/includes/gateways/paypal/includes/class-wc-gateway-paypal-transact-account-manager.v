import rt

struct Class_WC_Gateway_Paypal_Transact_Account_Manager {
	rt.PhpObjectBase
pub mut:
	transact_account_manager rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Gateway_Paypal_Transact_Account_Manager) construct(mut var_gateway Class_WC_Gateway_Paypal) {
	this.transact_account_manager =
		create_automattic_woocommerce_gateways_paypal_transactaccountmanager(var_gateway.dup())
}

fn (mut this Class_WC_Gateway_Paypal_Transact_Account_Manager) do_onboarding() {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('10.5.0'), 
			(Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager.class()).str() + '::do_onboarding()'])
	rt.call_method(this.transact_account_manager, 'do_onboarding', []rt.PhpVal{})
}

fn (mut this Class_WC_Gateway_Paypal_Transact_Account_Manager) get_transact_account_data(var_account_type rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('10.5.0'), 
			(Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager.class()).str() + '::get_transact_account_data()'])
	return rt.call_method(this.transact_account_manager, 'get_transact_account_data', [
		var_account_type.dup(),
	])
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager {
	rt.PhpObjectBase
}

fn create_wc_gateway_paypal_transact_account_manager(arg_0 rt.PhpVal) &Class_WC_Gateway_Paypal_Transact_Account_Manager {
	mut obj := &Class_WC_Gateway_Paypal_Transact_Account_Manager{
		PhpObjectBase:            rt.PhpObjectBase{}
		transact_account_manager: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_gateways_paypal_transactaccountmanager() &Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Gateway_Paypal_Transact_Account_Manager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'do_onboarding' {
			this.do_onboarding()
			return rt.new_null()
		}
		'get_transact_account_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_transact_account_data(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Gateway_Paypal_Transact_Account_Manager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'transact_account_manager' { return this.transact_account_manager }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Gateway_Paypal_Transact_Account_Manager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'transact_account_manager' {
			this.transact_account_manager = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_includes_gateways_paypal_includes_class_wc_gateway_paypal_transact_account_manager_php() {
	// unsupported statement: Stmt_Declare
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
}
