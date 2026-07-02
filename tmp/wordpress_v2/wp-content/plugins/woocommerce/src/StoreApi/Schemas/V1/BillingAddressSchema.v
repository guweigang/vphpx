import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Schemas_V1_BillingAddressSchema.identifier() string {
	return 'billing-address'
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_BillingAddressSchema {
	rt.PhpObjectBase
pub mut:
	title rt.PhpVal = rt.new_string('billing_address')
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_BillingAddressSchema) get_properties() rt.PhpVal {
	mut var_properties :=
		this.Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractAddressSchema.get_properties()
	return rt.call_function('array_merge', [var_properties.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'email', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Email'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'required', val: true },
			]) },
		])])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_BillingAddressSchema) sanitize_callback(var_address rt.PhpVal, var_request rt.PhpVal, var_param rt.PhpVal) rt.PhpVal {
	mut var_address_mutated := var_address
	var_address_mutated = this.Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractAddressSchema.sanitize_callback(var_address_mutated.clone(),
		var_request.clone(), var_param.clone())
	if var_address_mutated.array_isset(rt.new_string('email')) {
		var_address_mutated.array_set('email', rt.call_function('sanitize_email', [
			rt.call_function('wp_unslash', [var_address_mutated.array_get(rt.new_string('email'))]),
		]))
	}
	return var_address_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_BillingAddressSchema) validate_callback(var_address rt.PhpVal, var_request rt.PhpVal, var_param rt.PhpVal) rt.PhpVal {
	mut var_address_mutated := var_address
	mut var_errors := this.Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractAddressSchema.validate_callback(var_address_mutated.clone(),
		var_request.clone(), var_param.clone())
	var_address_mutated = rt.cast_array(var_address_mutated)
	var_errors = if rt.is_true(rt.call_function('is_wp_error', [
		var_errors.clone()]))
	{ var_errors } else { create_automattic_woocommerce_storeapi_schemas_v1_wp_error() }
	if !(!rt.is_true(var_address_mutated.array_get(rt.new_string('email'))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [var_address_mutated.array_get(rt.new_string('email'))]))))) {
		rt.call_method(var_errors, 'add', [rt.new_string('invalid_email'),
			rt.call_function('__', [
				rt.new_string('The provided email address is not valid'),
				rt.new_string('woocommerce'),
			])])
	}
	return if rt.is_true(rt.call_method(var_errors, 'has_errors', [
		var_errors.clone()]))
	{ var_errors } else { rt.new_bool(true) }
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_BillingAddressSchema) get_item_response(var_address rt.PhpVal) rt.PhpVal {
	mut var_address_mutated := var_address
	mut var_validation_util := create_automattic_woocommerce_storeapi_utilities_validationutils()
	if rt.is_true(rt.new_bool(rt.instance_of(var_address_mutated, 'Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Customer')))
		|| rt.is_true(rt.new_bool(rt.instance_of(var_address_mutated, 'Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Order'))) {
		mut var_billing_country := rt.call_method(var_address_mutated, 'get_billing_country',
			[]rt.PhpVal{})
		mut var_billing_state := rt.call_method(var_address_mutated, 'get_billing_state',
			[]rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(var_validation_util.validate_state(var_billing_state.clone(),
			var_billing_country.clone())))))
		{
			var_billing_state = rt.new_string('')
		}
		mut var_additional_address_fields := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_BillingAddressSchema', [
			'Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractAddressSchema',
		], &this), 'additional_fields_controller'), 'get_all_fields_from_object', [
			var_address_mutated.clone(),
			rt.new_string('billing'),
		])
		mut var_address_object := rt.call_function('array_merge', [
			rt.create_array([
				rt.ArrayItem{ key: 'first_name', val: rt.call_method(var_address_mutated,
					'get_billing_first_name', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'last_name', val: rt.call_method(var_address_mutated,
					'get_billing_last_name', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'company', val: rt.call_method(var_address_mutated,
					'get_billing_company', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'address_1', val: rt.call_method(var_address_mutated,
					'get_billing_address_1', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'address_2', val: rt.call_method(var_address_mutated,
					'get_billing_address_2', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'city', val: rt.call_method(var_address_mutated,
					'get_billing_city', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'state', val: var_billing_state },
				rt.ArrayItem{ key: 'postcode', val: rt.call_method(var_address_mutated,
					'get_billing_postcode', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'country', val: var_billing_country },
				rt.ArrayItem{ key: 'email', val: rt.call_method(var_address_mutated,
					'get_billing_email', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'phone', val: rt.call_method(var_address_mutated,
					'get_billing_phone', []rt.PhpVal{}) },
			]),
			var_additional_address_fields.clone(),
		])
		mut iter_1 := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_BillingAddressSchema', [
			'Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractAddressSchema',
		], &this), 'additional_fields_controller'), 'get_address_fields_keys', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			if var_address_object.array_isset(var_field) {
				continue
			}
			var_address_object.array_set(var_field, '')
		}
		mut iter_2 := var_address_object.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_value := item_2.val
			mut var_key := item_2.key
			if this.get_properties().array_get(var_key).array_isset(rt.new_string('type'))
				&& rt.is_true(rt.identical(rt.new_string('boolean'), this.get_properties().array_get(var_key).array_get(rt.new_string('type')))) {
				var_address_object.array_set(var_key, var_value.to_bool())
			} else {
				var_address_object.array_set(var_key, this.prepare_html_response(var_value.clone()))
			}
		}
		return var_address_object.clone()
	}
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
		[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('invalid_object_type'), rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('%1$s requires an instance of %2$s or %3$s for the address'),
			rt.new_string('woocommerce'),
		]),
		rt.new_string('BillingAddressSchema::get_item_response'),
		rt.new_string('WC_Customer'),
		rt.new_string('WC_Order'),
	]), rt.new_int(500))))
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractAddressSchema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_ValidationUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_schemas_v1_billingaddressschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_BillingAddressSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_BillingAddressSchema{
		PhpObjectBase: rt.PhpObjectBase{}
		title:         rt.new_string('billing_address')
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_schemas_v1_abstractaddressschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractAddressSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractAddressSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_schemas_v1_wp_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_validationutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_ValidationUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_ValidationUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_exceptions_routeexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_BillingAddressSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_properties' {
			return this.get_properties()
		}
		'sanitize_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.sanitize_callback(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'validate_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.validate_callback(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_response(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_BillingAddressSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'title' { return this.title }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_BillingAddressSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'title' {
			this.title = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
