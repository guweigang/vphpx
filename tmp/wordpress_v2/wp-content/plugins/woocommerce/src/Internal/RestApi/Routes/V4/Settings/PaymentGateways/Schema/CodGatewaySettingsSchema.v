import rt

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_CodGatewaySettingsSchema {
	rt.PhpObjectBase
pub mut:
	shipping_method_options rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_CodGatewaySettingsSchema) get_custom_groups_for_gateway(mut var_gateway Class_WC_Payment_Gateway) rt.PhpVal {
	mut var_core_field_overrides := rt.create_array([
		rt.ArrayItem{ key: 'enabled', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Enable/Disable'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Enable Cash on delivery at checkout'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'title', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Checkout label'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Shown to customers on the payment methods list at checkout.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'description', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Checkout instructions'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Shown below the checkout label.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'order', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Order'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'number' },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Determines the display order of payment gateways during checkout.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'instructions', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Order confirmation instructions'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Shown on the order confirmation page and in order emails.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'enable_for_methods', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Available for shipping methods'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'multiselect' },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Choose which shipping methods support Cash on delivery.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'options', val: this.load_shipping_method_options() },
		]) },
		rt.ArrayItem{ key: 'enable_for_virtual', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Accept for virtual orders'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Accept COD if the order is virtual'),
				rt.new_string('woocommerce'),
			]) },
		]) },
	])
	mut var_fields := this.build_fields_from_form_fields(rt.new_object('WC_Payment_Gateway',
		[]string{}, var_gateway), var_core_field_overrides.clone())
	mut var_group := rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
			rt.new_string('Cash on delivery settings'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Manage how Cash on delivery appears at checkout and in order emails.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'order', val: 1 },
		rt.ArrayItem{ key: 'fields', val: var_fields },
	])
	return rt.create_array([rt.ArrayItem{ key: 'settings', val: var_group }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_CodGatewaySettingsSchema) load_shipping_method_options() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), this.shipping_method_options)))) {
		return this.shipping_method_options
	}
	mut iife_temp_0 := Class_WC_Data_Store{}
	mut iife_result_0 := iife_temp_0.load(rt.new_string('shipping-zone'))
	mut var_data_store := iife_result_0
	mut var_raw_zones := rt.call_method(var_data_store, 'get_zones', []rt.PhpVal{})
	mut var_zones := rt.new_array()
	mut iter_1 := var_raw_zones.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_raw_zone := item_1.val
		var_zones.array_push(create_wc_shipping_zone(var_raw_zone.clone()))
	}
	var_zones.array_push(create_wc_shipping_zone(rt.new_int(0)))
	mut var_options := rt.new_array()
	mut iter_2 := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping',
		[]rt.PhpVal{}), 'load_shipping_methods', []rt.PhpVal{}).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_method := item_2.val
		var_options.array_set(rt.call_method(var_method, 'get_method_title', []rt.PhpVal{}),
			rt.new_array())
		var_options.array_get_mut(rt.call_method(var_method, 'get_method_title', []rt.PhpVal{})).array_set(rt.get_property(var_method,
			'id'), rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Any &quot;%1$s&quot; method'),
				rt.new_string('woocommerce')]),
			rt.call_method(var_method, 'get_method_title', []rt.PhpVal{}),
		]))
		mut iter_3 := var_zones.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_zone := item_3.val
			mut var_shipping_method_instances := rt.call_method(var_zone, 'get_shipping_methods',
				[]rt.PhpVal{})
			mut iter_4 := var_shipping_method_instances.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_shipping_method_instance := item_4.val
				mut var_shipping_method_instance_id := item_4.key
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_shipping_method_instance,
					'id'), rt.get_property(var_method, 'id')))))
				{
					continue
				}
				mut var_option_id := rt.call_method(var_shipping_method_instance, 'get_rate_id',
					[]rt.PhpVal{})
				mut var_option_instance_title := rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('%1$s (#%2$s)'),
						rt.new_string('woocommerce')]),
					rt.call_method(var_shipping_method_instance, 'get_title', []rt.PhpVal{}),
					var_shipping_method_instance_id.clone(),
				])
				mut var_option_title := rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('%1$s &ndash; %2$s'),
						rt.new_string('woocommerce')]),
					if rt.is_true(rt.call_method(var_zone, 'get_id', []rt.PhpVal{})) { rt.call_method(var_zone, 'get_zone_name', []rt.PhpVal{}) } else { rt.call_function('__', [
							rt.new_string('Other locations'),
							rt.new_string('woocommerce')]) },
					var_option_instance_title.clone(),
				])
				var_options.array_get_mut(rt.call_method(var_method, 'get_method_title',
					[]rt.PhpVal{})).array_set(var_option_id, var_option_title.clone())
			}
		}
	}
	this.shipping_method_options = var_options.clone()
	return var_options.clone()
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_WC_Shipping_Zone {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_settings_paymentgateways_schema_codgatewaysettingsschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_CodGatewaySettingsSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_CodGatewaySettingsSchema{
		PhpObjectBase:           rt.PhpObjectBase{}
		shipping_method_options: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_settings_paymentgateways_schema_abstractpaymentgatewaysettingsschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store(_args ...rt.PhpVal) &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shipping_zone(_args ...rt.PhpVal) &Class_WC_Shipping_Zone {
	mut obj := &Class_WC_Shipping_Zone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_CodGatewaySettingsSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_custom_groups_for_gateway' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_custom_groups_for_gateway(mut dispatch_arg_0)
		}
		'load_shipping_method_options' {
			return this.load_shipping_method_options()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_CodGatewaySettingsSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'shipping_method_options' { return this.shipping_method_options }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_CodGatewaySettingsSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'shipping_method_options' {
			this.shipping_method_options = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Shipping_Zone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shipping_Zone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping_Zone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
