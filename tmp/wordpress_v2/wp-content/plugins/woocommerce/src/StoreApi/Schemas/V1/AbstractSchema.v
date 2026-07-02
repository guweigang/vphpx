import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema.extending_key() string {
	return 'extensions'
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema {
	rt.PhpObjectBase
pub mut:
	title      rt.PhpVal = rt.new_string('Schema')
	extend     rt.PhpVal = rt.new_null()
	controller rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) construct(mut var_extend Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema, mut var_controller Class_Automattic_WooCommerce_StoreApi_SchemaController) {
	this.extend = var_extend
	this.controller = var_controller
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) get_item_schema() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: this.title },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: this.get_properties() },
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) get_item_response(var_item rt.PhpVal) rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) get_properties() {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) remove_arg_options(var_properties rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_property := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !(var_property.clone().is_array()) {
			return var_property.clone()
		}
		if var_property.array_isset(rt.new_string('properties')) {
			var_property.array_set('properties',
				this.remove_arg_options(var_property.array_get(rt.new_string('properties'))))
		} else if var_property.array_get(rt.new_string('items')).array_isset(rt.new_string('properties')) {
			var_property.array_get_mut('items').array_set('properties',
				this.remove_arg_options(var_property.array_get(rt.new_string('items')).array_get(rt.new_string('properties'))))
		}
		var_property.array_unset(rt.new_string('arg_options'))
		return var_property.clone()
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_property := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !(var_property.clone().is_array()) {
			return var_property.clone()
		}
		if var_property.array_isset(rt.new_string('properties')) {
			var_property.array_set('properties',
				this.remove_arg_options(var_property.array_get(rt.new_string('properties'))))
		} else if var_property.array_get(rt.new_string('items')).array_isset(rt.new_string('properties')) {
			var_property.array_get_mut('items').array_set('properties',
				this.remove_arg_options(var_property.array_get(rt.new_string('items')).array_get(rt.new_string('properties'))))
		}
		var_property.array_unset(rt.new_string('arg_options'))
		return var_property.clone()
	}
	return rt.call_function('array_map', [rt.new_closure(closure_1_fn),
		rt.cast_array(var_properties)])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) get_public_item_schema() rt.PhpVal {
	mut var_schema := this.get_item_schema()
	if var_schema.array_isset(rt.new_string('properties')) {
		var_schema.array_set('properties',
			this.remove_arg_options(var_schema.array_get(rt.new_string('properties'))))
	}
	return var_schema.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) get_extended_data(var_endpoint rt.PhpVal, var_passed_args rt.PhpVal) rt.PhpVal {
	return rt.call_method(this.extend, 'get_endpoint_data', [
		var_endpoint.clone(), var_passed_args.clone()])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) get_recursive_schema_property_defaults(var_properties rt.PhpVal) rt.PhpVal {
	mut var_defaults := rt.new_array()
	mut iter_1 := var_properties.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_property_value := item_1.val
		mut var_property_key := item_1.key
		if var_property_value.array_get(rt.new_string('arg_options')).array_isset(rt.new_string('default')) {
			var_defaults.array_set(var_property_key,
				var_property_value.array_get(rt.new_string('arg_options')).array_get(rt.new_string('default')))
		} else if var_property_value.array_isset(rt.new_string('properties')) {
			var_defaults.array_set(var_property_key,
				this.get_recursive_schema_property_defaults(var_property_value.array_get(rt.new_string('properties'))))
		}
	}
	return var_defaults.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) get_recursive_validate_callback(var_properties rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn [var_properties] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_values := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_request := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_param := if args.len > 2 { args[2].clone() } else { rt.new_null() }
		mut iter_2 := var_properties.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_property_value := item_2.val
			mut var_property_key := item_2.key
			mut var_current_value := if var_values.array_isset(var_property_key) {
				var_values.array_get(var_property_key)
			} else {
				rt.new_null()
			}
			mut var_property_type := if var_property_value.array_get(rt.new_string('type')).is_array() { var_property_value.array_get(rt.new_string('type')) } else { rt.create_array([
					rt.ArrayItem{
						key: none
						val: var_property_value.array_get(rt.new_string('type'))
					},
				]) }
			if !rt.is_true(var_current_value)
				&& rt.is_true(rt.call_function('in_array', [rt.new_string('null'), var_property_type.clone(), rt.new_bool(true)])) {
				continue
			}
			if var_property_value.array_get(rt.new_string('arg_options')).array_isset(rt.new_string('validate_callback')) {
				mut var_callback :=
					var_property_value.array_get(rt.new_string('arg_options')).array_get(rt.new_string('validate_callback'))
				mut var_result := if rt.call_function('is_callable', [
					var_callback.clone()])
				{ rt.call_callable(var_callback, [var_current_value.clone(),
						var_request.clone(), var_param.clone()]) } else { rt.new_bool(false) }
			} else {
				var_result = rt.call_function('rest_validate_value_from_schema', [
					var_current_value.clone(),
					var_property_value.clone(),
					rt.new_string(var_param.str() + ' > ' + var_property_key.str()),
				])
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_result))))
				|| rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
				return var_result.clone()
			}
			if var_property_value.array_isset(rt.new_string('properties')) {
				mut var_validate_callback :=
					this.get_recursive_validate_callback(var_property_value.array_get(rt.new_string('properties')))
				var_result = rt.call_callable(var_validate_callback, [
					var_current_value.clone(), var_request.clone(),
					rt.new_string(var_param.str() + ' > ' + var_property_key.str())])
				if rt.is_true(rt.new_bool(!(rt.is_true(var_result))))
					|| rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
					return var_result.clone()
				}
			}
		}
		return rt.new_bool(true)
	}
	return rt.new_closure(closure_3_fn)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) get_recursive_sanitize_callback(var_properties rt.PhpVal) rt.PhpVal {
	closure_4_fn := fn [var_properties] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_values := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_request := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_param := if args.len > 2 { args[2].clone() } else { rt.new_null() }
		mut var_sanitized_values := rt.new_array()
		mut iter_3 := var_properties.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_property_value := item_3.val
			mut var_property_key := item_3.key
			mut var_current_value := if var_values.array_isset(var_property_key) {
				var_values.array_get(var_property_key)
			} else {
				rt.new_null()
			}
			if var_property_value.array_get(rt.new_string('arg_options')).array_isset(rt.new_string('sanitize_callback')) {
				mut var_callback :=
					var_property_value.array_get(rt.new_string('arg_options')).array_get(rt.new_string('sanitize_callback'))
				var_current_value = if rt.call_function('is_callable', [
					var_callback.clone()])
				{ rt.call_callable(var_callback, [var_current_value.clone(),
						var_request.clone(), var_param.clone()]) } else { var_current_value }
			} else {
				var_current_value = rt.call_function('rest_sanitize_value_from_schema', [
					var_current_value.clone(),
					var_property_value.clone(),
					rt.new_string(var_param.str() + ' > ' + var_property_key.str()),
				])
			}
			if rt.is_true(rt.call_function('is_wp_error', [var_current_value.clone()])) {
				return var_current_value.clone()
			}
			if var_property_value.array_isset(rt.new_string('properties')) {
				mut var_sanitize_callback :=
					this.get_recursive_sanitize_callback(var_property_value.array_get(rt.new_string('properties')))
				var_sanitized_values.array_set(var_property_key, rt.call_callable(var_sanitize_callback, [
					var_current_value.clone(),
					var_request.clone(),
					rt.new_string(var_param.str() + ' > ' + var_property_key.str()),
				]))
			} else {
				var_sanitized_values.array_set(var_property_key, var_current_value.clone())
			}
		}
		return var_sanitized_values.clone()
	}
	return rt.new_closure(closure_4_fn)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) get_extended_schema(var_endpoint rt.PhpVal, var_passed_args rt.PhpVal) rt.PhpVal {
	mut var_extended_schema := rt.call_method(this.extend, 'get_endpoint_schema', [
		var_endpoint.clone(),
		var_passed_args.clone(),
	])
	mut var_defaults := this.get_recursive_schema_property_defaults(var_extended_schema.clone())
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
			rt.ArrayItem{ key: none, val: 'embed' },
		]) }, rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_defaults },
			rt.ArrayItem{
				key: 'validate_callback'
				val: this.get_recursive_validate_callback(var_extended_schema.clone())
			},
			rt.ArrayItem{
				key: 'sanitize_callback'
				val: this.get_recursive_sanitize_callback(var_extended_schema.clone())
			},
		]) }, rt.ArrayItem{ key: 'properties', val: var_extended_schema }])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) get_item_responses_from_schema(mut var_schema Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema, var_items rt.PhpVal) rt.PhpVal {
	mut var_schema_mutated := var_schema
	mut var_items_mutated := var_items
	var_items_mutated = rt.call_function('array_filter', [var_items_mutated.clone()])
	if !rt.is_true(var_items_mutated) {
		return rt.new_array()
	}
	return rt.call_function('array_values', [
		rt.call_function('array_map', [
			rt.create_array([rt.ArrayItem{ key: none, val: var_schema_mutated },
				rt.ArrayItem{ key: none, val: 'get_item_response' }]),
			var_items_mutated.clone(),
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) get_endpoint_args_for_item_schema(var_method rt.PhpVal) rt.PhpVal {
	mut var_schema := this.get_item_schema()
	mut var_endpoint_args := rt.call_function('rest_get_endpoint_args_for_schema', [
		var_schema.clone(),
		var_method.clone(),
	])
	var_endpoint_args = this.remove_arg_options(var_endpoint_args.clone())
	return var_endpoint_args.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) force_schema_readonly(var_properties rt.PhpVal) rt.PhpVal {
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_property := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		var_property.array_set('readonly', true)
		if var_property.array_get(rt.new_string('items')).array_isset(rt.new_string('properties')) {
			var_property.array_get_mut('items').array_set('properties',
				this.force_schema_readonly(var_property.array_get(rt.new_string('items')).array_get(rt.new_string('properties'))))
		}
		return var_property.clone()
	}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_property := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		var_property.array_set('readonly', true)
		if var_property.array_get(rt.new_string('items')).array_isset(rt.new_string('properties')) {
			var_property.array_get_mut('items').array_set('properties',
				this.force_schema_readonly(var_property.array_get(rt.new_string('items')).array_get(rt.new_string('properties'))))
		}
		return var_property.clone()
	}
	return rt.call_function('array_map', [rt.new_closure(closure_5_fn),
		rt.cast_array(var_properties)])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) get_store_currency_properties() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'currency_code', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Currency code (in ISO format) for returned prices.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
				rt.ArrayItem{ key: none, val: 'embed' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'currency_symbol', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Currency symbol for the currency which can be used to format returned prices.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
				rt.ArrayItem{ key: none, val: 'embed' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'currency_minor_unit', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Currency minor unit (number of digits after the decimal separator) for returned prices.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
				rt.ArrayItem{ key: none, val: 'embed' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'currency_decimal_separator', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Decimal separator for the currency which can be used to format returned prices.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
				rt.ArrayItem{ key: none, val: 'embed' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'currency_thousand_separator', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Thousand separator for the currency which can be used to format returned prices.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
				rt.ArrayItem{ key: none, val: 'embed' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'currency_prefix', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Price prefix for the currency which can be used to format returned prices.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
				rt.ArrayItem{ key: none, val: 'embed' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'currency_suffix', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Price prefix for the currency which can be used to format returned prices.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
				rt.ArrayItem{ key: none, val: 'embed' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) prepare_currency_response(var_values rt.PhpVal) rt.PhpVal {
	return rt.call_method(rt.call_method(this.extend, 'get_formatter', [
		rt.new_string('currency'),
	]), 'format', [var_values.clone()])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) prepare_money_response(var_amount rt.PhpVal, decimals i64, var_rounding_mode rt.PhpVal) rt.PhpVal {
	return rt.call_method(rt.call_method(this.extend, 'get_formatter', [
		rt.new_string('money'),
	]), 'format', [var_amount.clone(),
		rt.create_array([rt.ArrayItem{ key: 'decimals', val: decimals },
			rt.ArrayItem{ key: 'rounding_mode', val: var_rounding_mode }])])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) prepare_html_response(var_response rt.PhpVal) rt.PhpVal {
	return rt.call_method(rt.call_method(this.extend, 'get_formatter', [
		rt.new_string('html'),
	]), 'format', [var_response.clone()])
}

fn create_automattic_woocommerce_storeapi_schemas_v1_abstractschema(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema{
		PhpObjectBase: rt.PhpObjectBase{}
		title:         rt.new_string('Schema')
		extend:        rt.new_null()
		controller:    rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_response(dispatch_arg_0)
		}
		'get_properties' {
			this.get_properties()
			return rt.new_null()
		}
		'remove_arg_options' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.remove_arg_options(dispatch_arg_0)
		}
		'get_public_item_schema' {
			return this.get_public_item_schema()
		}
		'get_extended_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_extended_data(dispatch_arg_0, dispatch_arg_1)
		}
		'get_recursive_schema_property_defaults' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_recursive_schema_property_defaults(dispatch_arg_0)
		}
		'get_recursive_validate_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_recursive_validate_callback(dispatch_arg_0)
		}
		'get_recursive_sanitize_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_recursive_sanitize_callback(dispatch_arg_0)
		}
		'get_extended_schema' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_extended_schema(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_responses_from_schema' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_item_responses_from_schema(mut dispatch_arg_0, dispatch_arg_1)
		}
		'get_endpoint_args_for_item_schema' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_endpoint_args_for_item_schema(dispatch_arg_0)
		}
		'force_schema_readonly' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.force_schema_readonly(dispatch_arg_0)
		}
		'get_store_currency_properties' {
			return this.get_store_currency_properties()
		}
		'prepare_currency_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_currency_response(dispatch_arg_0)
		}
		'prepare_money_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.prepare_money_response(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'prepare_html_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_html_response(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'title' { return this.title }
		'extend' { return this.extend }
		'controller' { return this.controller }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'title' {
			this.title = val
			return true
		}
		'extend' {
			this.extend = val
			return true
		}
		'controller' {
			this.controller = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}
}
