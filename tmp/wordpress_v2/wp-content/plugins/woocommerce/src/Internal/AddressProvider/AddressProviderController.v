import rt

struct Class_Automattic_WooCommerce_Internal_AddressProvider_AddressProviderController {
	rt.PhpObjectBase
pub mut:
	providers                 rt.PhpVal = rt.new_array()
	preferred_provider_option rt.PhpVal = rt.new_string('')
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AddressProviderController) construct() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_AddressProvider_AddressProviderController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'init' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AddressProviderController) init() {
	this.preferred_provider_option = rt.call_function('get_option', [
		rt.new_string('woocommerce_address_autocomplete_provider'),
		rt.new_string(''),
	])
	this.providers = this.get_registered_providers()
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AddressProviderController) get_providers() rt.PhpVal {
	return this.providers
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AddressProviderController) get_registered_providers() rt.PhpVal {
	mut var_provider_items := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_address_providers'),
		rt.new_array(),
	])
	if !rt.is_true(var_provider_items) && var_provider_items.clone().is_array() {
		return rt.new_array()
	}
	mut var_logger := rt.call_function('wc_get_logger', []rt.PhpVal{})
	if !(var_provider_items.clone().is_array()) {
		rt.call_method(var_logger, 'error', [
			rt.new_string('Invalid return value for woocommerce_address_providers, expected an array of class names or instances.'),
			rt.create_array([
				rt.ArrayItem{ key: 'context', val: 'address_provider_service' },
			]),
		])
		return rt.new_array()
	}
	mut var_providers := rt.new_array()
	mut var_seen_ids := rt.new_array()
	mut iter_1 := var_provider_items.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_provider_item := item_1.val
		if var_provider_item.clone().is_string()
			&& rt.is_true(rt.call_function('class_exists', [var_provider_item.clone()])) {
			var_provider_item = rt.create_object_dynamically(var_provider_item, []rt.PhpVal{})
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [
			var_provider_item.clone(), Class_WC_Address_Provider.class()])))))
		{
			rt.call_method(var_logger, 'error', [
				rt.call_function('sprintf', [
					rt.new_string('Invalid address provider item "%s", expected a string class name or WC_Address_Provider instance.'),
					if var_provider_item.clone().is_object() { rt.call_function('get_class', [
							var_provider_item.clone(),
						]) } else { rt.call_function('gettype', [
							var_provider_item.clone(),
						]) },
				]),
				rt.create_array([
					rt.ArrayItem{ key: 'context', val: 'address_provider_service' },
				]),
			])
			continue
		}
		if !rt.is_true(rt.get_property(var_provider_item, 'id'))
			|| !rt.is_true(rt.get_property(var_provider_item, 'name')) {
			rt.call_method(var_logger, 'error', [
				rt.new_string(
					'Invalid address provider instance, id or name property is missing or empty: ' +
					(rt.call_function('get_class', [var_provider_item.clone()])).str()),
				rt.create_array([
					rt.ArrayItem{ key: 'context', val: 'address_provider_service' },
				]),
			])
			continue
		}
		if var_seen_ids.array_isset(rt.get_property(var_provider_item, 'id')) {
			rt.call_method(var_logger, 'error', [
				rt.call_function('sprintf', [
					rt.new_string('Duplicate provider ID found. ID "%s" is used by both %s and %s.'),
					rt.get_property(var_provider_item, 'id'),
					var_seen_ids.array_get(rt.get_property(var_provider_item, 'id')),
					rt.call_function('get_class', [var_provider_item.clone()]),
				]),
				rt.create_array([
					rt.ArrayItem{ key: 'context', val: 'address_provider_service' },
				]),
			])
			continue
		}
		var_seen_ids.array_set(rt.get_property(var_provider_item, 'id'), rt.call_function('get_class', [
			var_provider_item.clone(),
		]))
		var_providers.array_push(var_provider_item.clone())
	}
	if !(!rt.is_true(this.preferred_provider_option)) && !(!rt.is_true(var_providers)) {
		mut iter_2 := var_providers.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_provider := item_2.val
			mut var_key := item_2.key
			if rt.is_true(rt.identical(rt.get_property(var_provider, 'id'),
				this.preferred_provider_option))
			{
				mut var_preferred_provider := var_provider
				var_providers.array_unset(var_key)
				rt.call_function('array_unshift', [var_providers.clone(),
					var_preferred_provider.clone()])
				break
			}
		}
	}
	return var_providers.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AddressProviderController) is_provider_available(provider_id string) bool {
	mut iter_3 := this.providers.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_provider := item_3.val
		if rt.is_true(rt.identical(rt.get_property(var_provider, 'id'), rt.new_string(provider_id))) {
			return true
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AddressProviderController) get_preferred_provider() string {
	if this.is_provider_available((this.preferred_provider_option).str()) {
		return (this.preferred_provider_option).str()
	}
	return (if !(rt.get_property(this.providers.array_get(rt.new_int(0)), 'id')).is_null() {
		rt.get_property(this.providers.array_get(rt.new_int(0)), 'id')
	} else {
		rt.new_string('')
	}).str()
}

fn create_automattic_woocommerce_internal_addressprovider_addressprovidercontroller() &Class_Automattic_WooCommerce_Internal_AddressProvider_AddressProviderController {
	mut obj := &Class_Automattic_WooCommerce_Internal_AddressProvider_AddressProviderController{
		PhpObjectBase:             rt.PhpObjectBase{}
		providers:                 rt.new_array()
		preferred_provider_option: rt.new_string('')
	}
	obj.construct()
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AddressProviderController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'get_providers' {
			return this.get_providers()
		}
		'get_registered_providers' {
			return this.get_registered_providers()
		}
		'is_provider_available' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_provider_available(dispatch_arg_0))
		}
		'get_preferred_provider' {
			return rt.new_string(this.get_preferred_provider())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_AddressProvider_AddressProviderController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'providers' { return this.providers }
		'preferred_provider_option' { return this.preferred_provider_option }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AddressProviderController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'providers' {
			this.providers = val
			return true
		}
		'preferred_provider_option' {
			this.preferred_provider_option = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Internal_AddressProvider_AddressProviderController', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_addressprovider_addressprovidercontroller()
		return rt.new_object('Automattic_WooCommerce_Internal_AddressProvider_AddressProviderController',
			[]string{}, obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}
}
