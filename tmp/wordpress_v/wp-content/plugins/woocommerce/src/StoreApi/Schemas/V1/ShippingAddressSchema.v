import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ShippingAddressSchema.identifier() string {
	return 'shipping-address'
}
struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ShippingAddressSchema {
	rt.PhpObjectBase
pub mut:
		title rt.PhpVal = rt.new_string('shipping_address')
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ShippingAddressSchema) get_item_response(var_address rt.PhpVal) rt.PhpVal {
	mut var_validation_util := create_automattic_woocommerce_storeapi_utilities_validationutils()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_address, 'Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Customer'))) || rt.is_true(rt.new_bool(rt.instance_of(var_address, 'Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Order'))))) {
		mut var_shipping_country := rt.call_method(var_address, 'get_shipping_country', []rt.PhpVal{})
		mut var_shipping_state := rt.call_method(var_address, 'get_shipping_state', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(var_validation_util.validate_state(var_shipping_state.dup(), var_shipping_country.dup()))))) {
			var_shipping_state = rt.new_string(rt.new_string(''))
		}
		mut var_additional_address_fields := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_ShippingAddressSchema', ['Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractAddressSchema'], &this), 'additional_fields_controller'), 'get_all_fields_from_object', [var_address.dup(), rt.new_string('shipping')])
		mut var_address_object := rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'first_name', val: rt.call_method(var_address, 'get_shipping_first_name', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'last_name', val: rt.call_method(var_address, 'get_shipping_last_name', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'company', val: rt.call_method(var_address, 'get_shipping_company', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'address_1', val: rt.call_method(var_address, 'get_shipping_address_1', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'address_2', val: rt.call_method(var_address, 'get_shipping_address_2', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'city', val: rt.call_method(var_address, 'get_shipping_city', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'state', val: var_shipping_state }, rt.ArrayItem{ key: 'postcode', val: rt.call_method(var_address, 'get_shipping_postcode', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'country', val: var_shipping_country }, rt.ArrayItem{ key: 'phone', val: rt.call_method(var_address, 'get_shipping_phone', []rt.PhpVal{}) }]), var_additional_address_fields.dup()])
		{
			mut iter_1 := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_ShippingAddressSchema', ['Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractAddressSchema'], &this), 'additional_fields_controller'), 'get_address_fields_keys', []rt.PhpVal{}).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_field := item_1.val
				if var_address_object.array_isset(var_field) {
					continue
				}
				var_address_object.array_set(var_field, '')
			}
		}
		{
			mut iter_1 := var_address_object.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_key := item_1.key
				if rt.is_true(rt.new_bool(this.get_properties().array_get(var_key).array_isset(rt.new_string('type')) && rt.is_true(rt.identical(rt.new_string('boolean'), this.get_properties().array_get(var_key).array_get('type'))))) {
					var_address_object.array_set(var_key, // unsupported expression: Expr_Cast_Bool)
				} else {
					var_address_object.array_set(var_key, this.prepare_html_response(var_value.dup()))
				}
			}
		}
		return var_address_object.dup()
	}
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException', []string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('invalid_object_type'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s requires an instance of %2$s or %3$s for the address'), rt.new_string('woocommerce')]), rt.new_string('ShippingAddressSchema::get_item_response'), rt.new_string('WC_Customer'), rt.new_string('WC_Order')]), rt.new_int(500))))
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractAddressSchema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_ValidationUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_schemas_v1_shippingaddressschema() &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ShippingAddressSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ShippingAddressSchema{
		PhpObjectBase: rt.PhpObjectBase{}
		title: rt.new_string('shipping_address')
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_schemas_v1_abstractaddressschema() &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractAddressSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractAddressSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_validationutils() &Class_Automattic_WooCommerce_StoreApi_Utilities_ValidationUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_ValidationUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_exceptions_routeexception() &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ShippingAddressSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_response(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ShippingAddressSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'title' { return this.title }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ShippingAddressSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'title' { this.title = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractAddressSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractAddressSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractAddressSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ValidationUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_ValidationUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ValidationUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_storeapi_schemas_v1_shippingaddressschema_php() {
}
