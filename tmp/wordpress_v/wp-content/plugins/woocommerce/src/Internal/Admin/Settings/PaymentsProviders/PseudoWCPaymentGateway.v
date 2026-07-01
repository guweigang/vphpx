import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PseudoWCPaymentGateway {
	rt.PhpObjectBase
pub mut:
	id                          string
	title                       rt.PhpVal = rt.new_string('')
	description                 rt.PhpVal = rt.new_string('')
	method_title                rt.PhpVal = rt.new_string('')
	method_description          rt.PhpVal = rt.new_string('')
	plugin_slug                 rt.PhpVal = rt.new_string('generic-plugin-slug')
	plugin_file                 rt.PhpVal = rt.new_string('generic-plugin-slug/generic-plugin-file')
	recommended_payment_methods rt.PhpVal = rt.new_array()
	needs_setup                 rt.PhpVal = rt.new_bool(false)
	test_mode                   rt.PhpVal = rt.new_bool(false)
	dev_mode                    rt.PhpVal = rt.new_bool(false)
	account_connected           rt.PhpVal = rt.new_bool(false)
	onboarding_started          rt.PhpVal = rt.new_bool(false)
	onboarding_completed        rt.PhpVal = rt.new_bool(false)
	test_mode_onboarding        rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PseudoWCPaymentGateway) construct(id string, mut var_props Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_array) {
	this.id = id
	{
		mut iter_1 := var_props.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_prop := item_1.key
			this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":135,"name":"prop"}',
				var_value.dup())
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PseudoWCPaymentGateway) needs_setup() rt.PhpVal {
	return this.needs_setup
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PseudoWCPaymentGateway) get_settings_url() string {
	if !(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PseudoWCPaymentGateway', [
		'Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WC_Payment_Gateway',
	], &this), 'settings_url')).is_null() {
		return (rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PseudoWCPaymentGateway', [
			'Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WC_Payment_Gateway',
		], &this), 'settings_url')).str()
	}
	return (rt.call_function('admin_url', [
		'admin.php?page=wc-settings&tab=checkout&section=' + this.id.to_lower(),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PseudoWCPaymentGateway) get_connection_url() string {
	if !(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PseudoWCPaymentGateway', [
		'Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WC_Payment_Gateway',
	], &this), 'connection_url')).is_null() {
		return (rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PseudoWCPaymentGateway', [
			'Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WC_Payment_Gateway',
		], &this), 'connection_url')).str()
	}
	return this.get_settings_url()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PseudoWCPaymentGateway) get_recommended_payment_methods(country_code string) rt.PhpVal {
	return this.recommended_payment_methods
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PseudoWCPaymentGateway) is_test_mode() bool {
	return (this.test_mode).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PseudoWCPaymentGateway) is_dev_mode() bool {
	return (this.dev_mode).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PseudoWCPaymentGateway) is_account_connected() bool {
	return (this.account_connected).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PseudoWCPaymentGateway) is_onboarding_started() bool {
	return (this.onboarding_started).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PseudoWCPaymentGateway) is_onboarding_completed() bool {
	return (this.onboarding_completed).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PseudoWCPaymentGateway) is_test_mode_onboarding() bool {
	return (this.test_mode_onboarding).to_bool()
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WC_Payment_Gateway {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_settings_paymentsproviders_pseudowcpaymentgateway(id string, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PseudoWCPaymentGateway {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PseudoWCPaymentGateway{
		PhpObjectBase:               rt.PhpObjectBase{}
		id:                          ''
		title:                       rt.new_string('')
		description:                 rt.new_string('')
		method_title:                rt.new_string('')
		method_description:          rt.new_string('')
		plugin_slug:                 rt.new_string('generic-plugin-slug')
		plugin_file:                 rt.new_string('generic-plugin-slug/generic-plugin-file')
		recommended_payment_methods: rt.new_array()
		needs_setup:                 rt.new_bool(false)
		test_mode:                   rt.new_bool(false)
		dev_mode:                    rt.new_bool(false)
		account_connected:           rt.new_bool(false)
		onboarding_started:          rt.new_bool(false)
		onboarding_completed:        rt.new_bool(false)
		test_mode_onboarding:        rt.new_bool(false)
	}
	obj.construct(id, arg_1)
	return obj
}

fn create_automattic_woocommerce_internal_admin_settings_paymentsproviders_wc_payment_gateway() &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WC_Payment_Gateway {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WC_Payment_Gateway{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PseudoWCPaymentGateway) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.construct(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'needs_setup' {
			return this.needs_setup()
		}
		'get_settings_url' {
			return rt.new_string(this.get_settings_url())
		}
		'get_connection_url' {
			return rt.new_string(this.get_connection_url())
		}
		'get_recommended_payment_methods' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_recommended_payment_methods(dispatch_arg_0)
		}
		'is_test_mode' {
			return rt.new_bool(this.is_test_mode())
		}
		'is_dev_mode' {
			return rt.new_bool(this.is_dev_mode())
		}
		'is_account_connected' {
			return rt.new_bool(this.is_account_connected())
		}
		'is_onboarding_started' {
			return rt.new_bool(this.is_onboarding_started())
		}
		'is_onboarding_completed' {
			return rt.new_bool(this.is_onboarding_completed())
		}
		'is_test_mode_onboarding' {
			return rt.new_bool(this.is_test_mode_onboarding())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PseudoWCPaymentGateway) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return rt.new_string(this.id) }
		'title' { return this.title }
		'description' { return this.description }
		'method_title' { return this.method_title }
		'method_description' { return this.method_description }
		'plugin_slug' { return this.plugin_slug }
		'plugin_file' { return this.plugin_file }
		'recommended_payment_methods' { return this.recommended_payment_methods }
		'needs_setup' { return this.needs_setup }
		'test_mode' { return this.test_mode }
		'dev_mode' { return this.dev_mode }
		'account_connected' { return this.account_connected }
		'onboarding_started' { return this.onboarding_started }
		'onboarding_completed' { return this.onboarding_completed }
		'test_mode_onboarding' { return this.test_mode_onboarding }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PseudoWCPaymentGateway) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' {
			this.id = val.str()
			return true
		}
		'title' {
			this.title = val
			return true
		}
		'description' {
			this.description = val
			return true
		}
		'method_title' {
			this.method_title = val
			return true
		}
		'method_description' {
			this.method_description = val
			return true
		}
		'plugin_slug' {
			this.plugin_slug = val
			return true
		}
		'plugin_file' {
			this.plugin_file = val
			return true
		}
		'recommended_payment_methods' {
			this.recommended_payment_methods = val
			return true
		}
		'needs_setup' {
			this.needs_setup = val
			return true
		}
		'test_mode' {
			this.test_mode = val
			return true
		}
		'dev_mode' {
			this.dev_mode = val
			return true
		}
		'account_connected' {
			this.account_connected = val
			return true
		}
		'onboarding_started' {
			this.onboarding_started = val
			return true
		}
		'onboarding_completed' {
			this.onboarding_completed = val
			return true
		}
		'test_mode_onboarding' {
			this.test_mode_onboarding = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WC_Payment_Gateway) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WC_Payment_Gateway) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WC_Payment_Gateway) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_admin_settings_paymentsproviders_pseudowcpaymentgateway_php() {
	// unsupported statement: Stmt_Declare
}
