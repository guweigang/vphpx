import rt

struct Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCPaymentGateways {
	rt.PhpObjectBase
pub mut:
	exclude_ids rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCPaymentGateways) export() rt.PhpVal {
	mut var_options := rt.new_array()
	this.maybe_hide_wcpay_gateways()
	mut iter_1 := this.get_wc_payment_gateways().iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_payment_gateway := item_1.val
		mut var_id := item_1.key
		if rt.is_true(rt.call_function('in_array',
			[var_id.clone(), this.exclude_ids, rt.new_bool(true)]))
		{
			continue
		}
		var_options.array_set('woocommerce_' + var_id.str() + '_settings', rt.get_property(var_payment_gateway,
			'settings'))
	}
	return rt.new_object('Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions', []string{},
		create_automattic_woocommerce_blueprint_steps_setsiteoptions(var_options.clone()))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCPaymentGateways) get_wc_payment_gateways() rt.PhpVal {
	return rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways'),
		'payment_gateways', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCPaymentGateways) get_step_name() string {
	return 'wcPaymentGateways'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCPaymentGateways) maybe_hide_wcpay_gateways() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Payments')])) {
		mut iife_temp_0 :=
			Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_WC_Payments{}
		mut iife_result_0 := iife_temp_0.hide_gateways_on_settings_page()
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCPaymentGateways) get_label() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Payments'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCPaymentGateways) get_description() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string('Includes all settings in WooCommerce | Settings | Payments.'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCPaymentGateways) check_step_capabilities() bool {
	return (rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')])).to_bool()
}

struct Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_WC_Payments {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_blueprint_exporters_exportwcpaymentgateways(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCPaymentGateways {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCPaymentGateways{
		PhpObjectBase: rt.PhpObjectBase{}
		exclude_ids:   rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_steps_setsiteoptions(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_blueprint_exporters_wc_payments(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_WC_Payments {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_WC_Payments{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCPaymentGateways) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'export' {
			return this.export()
		}
		'get_wc_payment_gateways' {
			return this.get_wc_payment_gateways()
		}
		'get_step_name' {
			return rt.new_string(this.get_step_name())
		}
		'maybe_hide_wcpay_gateways' {
			this.maybe_hide_wcpay_gateways()
			return rt.new_null()
		}
		'get_label' {
			return this.get_label()
		}
		'get_description' {
			return this.get_description()
		}
		'check_step_capabilities' {
			return rt.new_bool(this.check_step_capabilities())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCPaymentGateways) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'exclude_ids' { return this.exclude_ids }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCPaymentGateways) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'exclude_ids' {
			this.exclude_ids = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_WC_Payments) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_WC_Payments) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_WC_Payments) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
