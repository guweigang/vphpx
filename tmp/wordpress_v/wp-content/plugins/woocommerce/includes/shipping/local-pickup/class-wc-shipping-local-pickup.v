import rt

struct Class_WC_Shipping_Local_Pickup {
	rt.PhpObjectBase
pub mut:
		cost rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Shipping_Local_Pickup) construct(instance_id i64)  {
	this.dispatch_set_prop('id', rt.new_string('local_pickup'))
	this.dispatch_set_prop('instance_id', rt.call_function('absint', [rt.new_int(instance_id)]))
	this.dispatch_set_prop('method_title', rt.call_function('__', [rt.new_string('Local pickup'), rt.new_string('woocommerce')]))
	this.dispatch_set_prop('method_description', rt.call_function('__', [rt.new_string('Allow customers to pick up orders themselves. By default, when using local pickup store base taxes will apply regardless of customer address.'), rt.new_string('woocommerce')]))
	this.dispatch_set_prop('supports', rt.create_array([rt.ArrayItem{ key: none, val: 'shipping-zones' }, rt.ArrayItem{ key: none, val: 'instance-settings' }, rt.ArrayItem{ key: none, val: 'instance-settings-modal' }]))
	this.init()
}

fn (mut this Class_WC_Shipping_Local_Pickup) init()  {
	this.init_form_fields()
	this.init_settings()
	this.dispatch_set_prop('title', this.get_option(rt.new_string('title')))
	this.dispatch_set_prop('tax_status', this.get_option(rt.new_string('tax_status')))
	this.cost = this.get_option(rt.new_string('cost'))
	rt.call_function('add_action', ['woocommerce_update_options_shipping_' + rt.get_property(rt.new_object('WC_Shipping_Local_Pickup', ['WC_Shipping_Method'], &this), 'id'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Shipping_Local_Pickup', ['WC_Shipping_Method'], &this) }, rt.ArrayItem{ key: none, val: 'process_admin_options' }])])
}

fn (mut this Class_WC_Shipping_Local_Pickup) calculate_shipping(var_package rt.PhpVal)  {
	this.add_rate(rt.create_array([rt.ArrayItem{ key: 'label', val: rt.get_property(rt.new_object('WC_Shipping_Local_Pickup', ['WC_Shipping_Method'], &this), 'title') }, rt.ArrayItem{ key: 'package', val: var_package }, rt.ArrayItem{ key: 'cost', val: this.cost }]))
}

fn (mut this Class_WC_Shipping_Local_Pickup) sanitize_cost(var_value rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_NumberUtil{}; return temp.sanitize_cost_in_current_locale(arg_0) }(var_value.dup())
}

fn (mut this Class_WC_Shipping_Local_Pickup) init_form_fields()  {
	this.dispatch_set_prop('instance_form_fields', rt.create_array([rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Name'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Your customers will see the name of this shipping method during checkout.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'default', val: rt.call_function('__', [rt.new_string('Local pickup'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [rt.new_string('e.g. Local pickup'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc_tip', val: true }]) }, rt.ArrayItem{ key: 'tax_status', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Tax status'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'select' }, rt.ArrayItem{ key: 'class', val: 'wc-enhanced-select' }, rt.ArrayItem{ key: 'default', val: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable() }, rt.ArrayItem{ key: 'options', val: rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable(), val: rt.call_function('__', [rt.new_string('Taxable'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.none(), val: rt.call_function('_x', [rt.new_string('None'), rt.new_string('Tax status'), rt.new_string('woocommerce')]) }]) }]) }, rt.ArrayItem{ key: 'cost', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Cost'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'class', val: 'wc-shipping-modal-price' }, rt.ArrayItem{ key: 'placeholder', val: rt.call_function('wc_format_localized_price', [rt.new_int(0)]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Optional cost for local pickup.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'default', val: '' }, rt.ArrayItem{ key: 'desc_tip', val: true }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Shipping_Local_Pickup', ['WC_Shipping_Method'], &this) }, rt.ArrayItem{ key: none, val: 'sanitize_cost' }]) }]) }]))
}

struct Class_WC_Shipping_Method {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

fn create_wc_shipping_local_pickup(instance_id i64) &Class_WC_Shipping_Local_Pickup {
	mut obj := &Class_WC_Shipping_Local_Pickup{
		PhpObjectBase: rt.PhpObjectBase{}
		cost: rt.new_null()
	}
	obj.construct(instance_id)
	return obj
}

fn create_wc_shipping_method() &Class_WC_Shipping_Method {
	mut obj := &Class_WC_Shipping_Method{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_numberutil() &Class_Automattic_WooCommerce_Utilities_NumberUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_NumberUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Shipping_Local_Pickup) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'calculate_shipping' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.calculate_shipping(dispatch_arg_0)
			return rt.new_null()
		}
		'sanitize_cost' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sanitize_cost(dispatch_arg_0)
		}
		'init_form_fields' {
			this.init_form_fields()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Shipping_Local_Pickup) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cost' { return this.cost }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Shipping_Local_Pickup) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cost' { this.cost = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Shipping_Method) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shipping_Method) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping_Method) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_shipping_local_pickup_class_wc_shipping_local_pickup_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
