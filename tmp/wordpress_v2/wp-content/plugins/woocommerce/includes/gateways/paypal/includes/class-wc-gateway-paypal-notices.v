import rt

struct Class_WC_Gateway_Paypal_Notices {
	rt.PhpObjectBase
pub mut:
	notices rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Gateway_Paypal_Notices) construct() {
	this.notices = create_automattic_woocommerce_gateways_paypal_notices()
}

fn (mut this Class_WC_Gateway_Paypal_Notices) add_paypal_notices() {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('10.5.0'),
		rt.new_string('Automattic\\WooCommerce\\Gateways\\PayPal\\Notices::add_paypal_notices()')])
	rt.call_method(this.notices, 'add_paypal_notices', []rt.PhpVal{})
}

fn (mut this Class_WC_Gateway_Paypal_Notices) add_paypal_notices_on_payments_settings_page() {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('10.5.0'),
		rt.new_string('Automattic\\WooCommerce\\Gateways\\PayPal\\Notices::add_paypal_notices_on_payments_settings_page()')])
	rt.call_method(this.notices, 'add_paypal_notices_on_payments_settings_page', []rt.PhpVal{})
}

fn (mut this Class_WC_Gateway_Paypal_Notices) add_paypal_migration_notice_on_payments_settings_page() {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('10.4.0'),
		rt.new_string('WC_Gateway_Paypal_Notices::add_paypal_notices_on_payments_settings_page')])
	this.add_paypal_notices_on_payments_settings_page()
}

fn (mut this Class_WC_Gateway_Paypal_Notices) add_paypal_migration_notice() {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('10.5.0'),
		rt.new_string('Automattic\\WooCommerce\\Gateways\\PayPal\\Notices::add_paypal_migration_notice()')])
	rt.call_method(this.notices, 'add_paypal_migration_notice', []rt.PhpVal{})
}

fn Class_WC_Gateway_Paypal_Notices.paypal_migration_notice_dismissed() bool {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('10.4.0'), rt.new_string('WC_Gateway_Paypal_Notices::is_notice_dismissed')])
	return (rt.call_function('get_user_meta', [
		rt.call_function('get_current_user_id', []rt.PhpVal{}),
		rt.new_string('dismissed_paypal_migration_completed_notice'),
		rt.new_bool(true),
	])).to_bool()
}

fn Class_WC_Gateway_Paypal_Notices.set_account_restriction_flag() {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('10.5.0'),
		rt.new_string('Automattic\\WooCommerce\\Gateways\\PayPal\\Notices::set_account_restriction_flag()')])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Gateways_PayPal_Notices{}
	mut iife_result_0 := iife_temp_0.set_account_restriction_flag()
}

fn Class_WC_Gateway_Paypal_Notices.clear_account_restriction_flag() {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('10.5.0'),
		rt.new_string('Automattic\\WooCommerce\\Gateways\\PayPal\\Notices::clear_account_restriction_flag()')])
	mut iife_temp_1 := Class_Automattic_WooCommerce_Gateways_PayPal_Notices{}
	mut iife_result_1 := iife_temp_1.clear_account_restriction_flag()
}

fn Class_WC_Gateway_Paypal_Notices.manage_account_restriction_flag_for_notice(var_http_code rt.PhpVal, mut var_response_data Class_array, mut var_order Class_WC_Order) {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('10.5.0'),
		rt.new_string('Automattic\\WooCommerce\\Gateways\\PayPal\\Notices::manage_account_restriction_flag_for_notice()')])
	mut iife_temp_2 := Class_Automattic_WooCommerce_Gateways_PayPal_Notices{}
	mut iife_result_2 := iife_temp_2.manage_account_restriction_flag_for_notice(var_http_code.clone(), rt.new_object('array',
		[]string{}, var_response_data), rt.new_object('WC_Order', []string{}, var_order))
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_Notices {
	rt.PhpObjectBase
}

fn create_wc_gateway_paypal_notices() &Class_WC_Gateway_Paypal_Notices {
	mut obj := &Class_WC_Gateway_Paypal_Notices{
		PhpObjectBase: rt.PhpObjectBase{}
		notices:       rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_gateways_paypal_notices(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Gateways_PayPal_Notices {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_Notices{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Gateway_Paypal_Notices) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'add_paypal_notices' {
			this.add_paypal_notices()
			return rt.new_null()
		}
		'add_paypal_notices_on_payments_settings_page' {
			this.add_paypal_notices_on_payments_settings_page()
			return rt.new_null()
		}
		'add_paypal_migration_notice_on_payments_settings_page' {
			this.add_paypal_migration_notice_on_payments_settings_page()
			return rt.new_null()
		}
		'add_paypal_migration_notice' {
			this.add_paypal_migration_notice()
			return rt.new_null()
		}
		'paypal_migration_notice_dismissed' {
			return rt.new_bool(Class_WC_Gateway_Paypal_Notices.paypal_migration_notice_dismissed())
		}
		'set_account_restriction_flag' {
			Class_WC_Gateway_Paypal_Notices.set_account_restriction_flag()
			return rt.new_null()
		}
		'clear_account_restriction_flag' {
			Class_WC_Gateway_Paypal_Notices.clear_account_restriction_flag()
			return rt.new_null()
		}
		'manage_account_restriction_flag_for_notice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WC_Order](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			Class_WC_Gateway_Paypal_Notices.manage_account_restriction_flag_for_notice(dispatch_arg_0, mut
				dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Gateway_Paypal_Notices) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'notices' { return this.notices }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Gateway_Paypal_Notices) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'notices' {
			this.notices = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Notices) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Gateways_PayPal_Notices) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Notices) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	rt.include_file(@DIR + '/class-wc-gateway-paypal-helper.php', '4')
}
