import rt

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractAddressSchema {
	rt.PhpObjectBase
pub mut:
	additional_fields_controller rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractAddressSchema) construct(mut var_extend Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema, mut var_controller Class_Automattic_WooCommerce_StoreApi_SchemaController) {
	this.Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema.construct(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema',
		[]string{}, var_extend), rt.new_object('Automattic_WooCommerce_StoreApi_SchemaController',
		[]string{}, var_controller))
	mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_Package{}
	mut iife_result_0 := iife_temp_0.container()
	this.additional_fields_controller = rt.call_method(iife_result_0, 'get', [
		Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.class(),
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractAddressSchema) get_properties() rt.PhpVal {
	return rt.call_function('array_merge', [
		rt.create_array([
			rt.ArrayItem{ key: 'first_name', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('First name'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'required', val: true },
			]) },
			rt.ArrayItem{ key: 'last_name', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Last name'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'required', val: true },
			]) },
			rt.ArrayItem{ key: 'company', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Company'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'required', val: true },
			]) },
			rt.ArrayItem{ key: 'address_1', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Address'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'required', val: true },
			]) },
			rt.ArrayItem{ key: 'address_2', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Apartment, suite, etc.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'required', val: true },
			]) },
			rt.ArrayItem{ key: 'city', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('City'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'required', val: true },
			]) },
			rt.ArrayItem{ key: 'state', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('State/County code, or name of the state, county, province, or district.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'required', val: true },
			]) },
			rt.ArrayItem{ key: 'postcode', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Postal code'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'required', val: true },
			]) },
			rt.ArrayItem{ key: 'country', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Country/Region code in ISO 3166-1 alpha-2 format.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'required', val: true },
			]) },
			rt.ArrayItem{ key: 'phone', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Phone'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'required', val: true },
			]) },
		]),
		this.get_additional_address_fields_schema(),
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractAddressSchema) sanitize_callback(var_address rt.PhpVal, var_request rt.PhpVal, var_param rt.PhpVal) rt.PhpVal {
	mut var_address_mutated := var_address
	mut var_validation_util := create_automattic_woocommerce_storeapi_utilities_validationutils()
	mut var_sanitization_util :=
		create_automattic_woocommerce_storeapi_utilities_sanitizationutils()
	var_address_mutated = rt.cast_array(var_address_mutated)
	mut var_schema := this.get_properties()
	var_address_mutated = rt.call_function('array_intersect_key', [
		var_address_mutated.clone(), var_schema.clone()])
	closure_2_fn := fn [var_address, var_validation_util, var_schema] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_carry := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_key := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut switch_val_1 := var_key
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('country'))) {
			var_carry.array_set(var_key, rt.call_function('wc_strtoupper', [
				rt.call_function('sanitize_text_field', [
					rt.call_function('wp_unslash', [var_address_mutated.array_get(var_key)]),
				]),
			]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('state'))) {
			var_carry.array_set(var_key, var_validation_util.format_state(rt.call_function('sanitize_text_field', [
				rt.call_function('wp_unslash', [var_address_mutated.array_get(var_key)]),
			]), var_address_mutated.array_get(rt.new_string('country'))))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('postcode'))) {
			var_carry.array_set(var_key, if rt.is_true(var_address_mutated.array_get(rt.new_string('postcode'))) { rt.call_function('wc_format_postcode', [
					rt.call_function('sanitize_text_field', [
						rt.call_function('wp_unslash', [
							var_address_mutated.array_get(rt.new_string('postcode')),
						]),
					]),
					var_address_mutated.array_get(rt.new_string('country')),
				]) } else { rt.new_string('') })
		} else {
			var_carry.array_set(var_key, rt.call_function('rest_sanitize_value_from_schema', [
				rt.call_function('wp_unslash', [var_address_mutated.array_get(var_key)]),
				var_schema.array_get(var_key),
				var_key.clone(),
			]))
		}
		if rt.is_true(rt.call_method(this.additional_fields_controller, 'is_field', [
			var_key.clone(),
		]))
		{
			var_carry.array_set(var_key, rt.call_method(this.additional_fields_controller,
				'sanitize_field', [var_key.clone(), var_carry.array_get(var_key)]))
		}
		return var_carry.clone()
	}
	var_address_mutated = rt.call_function('array_reduce', [
		rt.func_array_keys(var_address_mutated.clone()),
		rt.new_closure(closure_2_fn),
		rt.new_array(),
	])
	return var_sanitization_util.wp_kses_array(var_address_mutated.clone())
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractAddressSchema) validate_callback(var_address rt.PhpVal, var_request rt.PhpVal, var_param rt.PhpVal) rt.PhpVal {
	mut var_address_mutated := var_address
	mut var_errors := create_automattic_woocommerce_storeapi_schemas_v1_wp_error()
	var_address_mutated = rt.cast_array(var_address_mutated)
	mut var_validation_util := create_automattic_woocommerce_storeapi_utilities_validationutils()
	mut var_schema := this.get_properties()
	var_address_mutated = rt.call_function('array_intersect_key', [
		var_address_mutated.clone(), var_schema.clone()])
	mut iter_1 := var_address_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_key := item_1.key
		if !rt.is_true(var_schema.array_get(var_key))
			|| !rt.is_true(var_address_mutated.array_get(var_key)) {
			continue
		}
		if rt.is_true(rt.call_function('is_wp_error', [
			rt.call_function('rest_validate_value_from_schema', [
				var_value.clone(), var_schema.array_get(var_key),
				var_key.clone()]),
		]))
		{
			var_errors.add(rt.new_string('invalid_' + var_key.str()), rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Invalid %s provided.'),
					rt.new_string('woocommerce')]),
				var_key.clone(),
			]))
		}
	}
	if rt.is_true(var_errors.has_errors()) {
		return mut var_errors
	}
	var_address_mutated = this.sanitize_callback(var_address_mutated.clone(), var_request.clone(),
		var_param.clone())
	if !(!rt.is_true(var_address_mutated.array_get(rt.new_string('country'))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_address_mutated.array_get(rt.new_string('country')), rt.func_array_keys(rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'countries'), 'get_countries', []rt.PhpVal{})), rt.new_bool(true)]))))) {
		var_errors.add(rt.new_string('invalid_country'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Invalid country code provided. Must be one of: %s'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('implode', [
				rt.new_string(', '),
				rt.func_array_keys(rt.call_method(rt.get_property(rt.call_function('wc',
					[]rt.PhpVal{}), 'countries'), 'get_countries', []rt.PhpVal{})),
			]),
		]))
		return mut var_errors
	}
	if !(!rt.is_true(var_address_mutated.array_get(rt.new_string('state'))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_validation_util.validate_state(var_address_mutated.array_get(rt.new_string('state')), var_address_mutated.array_get(rt.new_string('country'))))))) {
		var_errors.add(rt.new_string('invalid_state'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The provided state (%1$s) is not valid. Must be one of: %2$s'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				var_address_mutated.array_get(rt.new_string('state')),
			]),
			rt.call_function('implode', [
				rt.new_string(', '),
				rt.func_array_keys(var_validation_util.get_states_for_country(var_address_mutated.array_get(rt.new_string('country')))),
			]),
		]))
	}
	mut iife_temp_2 := Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Validation{}
	mut iife_result_2 := iife_temp_2.is_postcode(var_address_mutated.array_get(rt.new_string('postcode')),
		var_address_mutated.array_get(rt.new_string('country')))
	if !(!rt.is_true(var_address_mutated.array_get(rt.new_string('postcode'))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(iife_result_2)))) {
		var_errors.add(rt.new_string('invalid_postcode'), rt.call_function('__', [
			rt.new_string('The provided postcode / ZIP is not valid'),
			rt.new_string('woocommerce'),
		]))
	}
	if !(!rt.is_true(var_address_mutated.array_get(rt.new_string('phone')))) {
		var_address_mutated.array_set('phone', rt.call_function('wc_remove_non_displayable_chars', [
			var_address_mutated.array_get(rt.new_string('phone')),
		]))
		mut iife_temp_3 := Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Validation{}
		mut iife_result_3 :=
			iife_temp_3.is_phone(var_address_mutated.array_get(rt.new_string('phone')))
		if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_3)))) {
			var_errors.add(rt.new_string('invalid_phone'), rt.call_function('__', [
				rt.new_string('The provided phone number is not valid'),
				rt.new_string('woocommerce'),
			]))
		}
	}
	mut var_additional_keys := rt.func_array_keys(this.get_additional_address_fields_schema())
	mut iter_2 := rt.func_array_keys(var_address_mutated.clone()).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_key := item_2.val
		if rt.is_true(rt.identical(rt.new_string('email'), var_key)) {
			continue
		}
		if !rt.is_true(var_schema.array_get(var_key))
			|| !rt.is_true(var_address_mutated.array_get(var_key)) {
			continue
		}
		mut var_field_schema := var_schema.array_get(var_key)
		mut var_field_value := if var_address_mutated.array_isset(var_key) {
			var_address_mutated.array_get(var_key)
		} else {
			rt.new_null()
		}
		mut var_result := rt.call_function('rest_validate_value_from_schema', [
			var_field_value.clone(),
			var_field_schema.clone(),
			var_key.clone(),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()]))
			&& rt.is_true(rt.call_method(var_result, 'has_errors', []rt.PhpVal{})) {
			var_errors.merge_from(var_result.clone())
		}
	}
	return mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WP_Error](if rt.is_true(var_errors.has_errors(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_WP_Error',
		[]string{}, var_errors)))
	{
		var_errors
	} else {
		rt.new_bool(true)
	})
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractAddressSchema) get_additional_address_fields_schema() rt.PhpVal {
	mut var_additional_fields_keys := rt.call_method(this.additional_fields_controller,
		'get_address_fields_keys', []rt.PhpVal{})
	mut var_fields := rt.call_method(this.additional_fields_controller, 'get_additional_fields',
		[]rt.PhpVal{})
	closure_5_fn := fn [var_additional_fields_keys] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_key := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('in_array', [var_key.clone(),
			var_additional_fields_keys.clone(), rt.new_bool(true)])
	}
	mut var_address_fields := rt.call_function('array_filter', [
		var_fields.clone(), rt.new_closure(closure_5_fn), rt.get_constant('ARRAY_FILTER_USE_KEY')])
	mut var_schema := rt.new_array()
	mut iter_3 := var_address_fields.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_field := item_3.val
		mut var_key := item_3.key
		mut var_field_schema := rt.create_array([
			rt.ArrayItem{ key: 'description', val: var_field.array_get(rt.new_string('label')) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{
				key: 'required'
				val: if rt.is_true(rt.call_method(this.additional_fields_controller,
					'is_conditional_field', [
					var_field.clone(),
				]))
				{
					rt.new_bool(false)
				} else {
					rt.identical(rt.new_bool(true), var_field.array_get(rt.new_string('required')))
				}
			},
		])
		if rt.is_true(rt.identical(rt.new_string('select'),
			var_field.array_get(rt.new_string('type'))))
		{
			closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_option := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return var_option.array_get(rt.new_string('value'))
			}
			closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_option := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return var_option.array_get(rt.new_string('value'))
			}
			var_field_schema.array_set('enum', rt.call_function('array_map', [
				rt.new_closure(closure_6_fn),
				var_field.array_get(rt.new_string('options')),
			]))
		}
		if rt.is_true(rt.identical(rt.new_string('checkbox'),
			var_field.array_get(rt.new_string('type'))))
		{
			var_field_schema.array_set('type', 'boolean')
		}
		var_schema.array_set(var_key, var_field_schema.clone())
	}
	return var_schema.clone()
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Package {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_ValidationUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_SanitizationUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Validation {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_schemas_v1_abstractaddressschema(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractAddressSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractAddressSchema{
		PhpObjectBase:                rt.PhpObjectBase{}
		additional_fields_controller: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_automattic_woocommerce_storeapi_schemas_v1_abstractschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_package(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Package {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Package{
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

fn create_automattic_woocommerce_storeapi_utilities_sanitizationutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_SanitizationUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_SanitizationUtils{
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

fn create_automattic_woocommerce_storeapi_schemas_v1_wc_validation(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Validation {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Validation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractAddressSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_SchemaController](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
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
		'get_additional_address_fields_schema' {
			return this.get_additional_address_fields_schema()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractAddressSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'additional_fields_controller' { return this.additional_fields_controller }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractAddressSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'additional_fields_controller' {
			this.additional_fields_controller = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Package) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_SanitizationUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_SanitizationUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_SanitizationUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Validation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Validation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Validation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
