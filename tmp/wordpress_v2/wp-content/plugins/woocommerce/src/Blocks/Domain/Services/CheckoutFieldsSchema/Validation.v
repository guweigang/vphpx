import rt

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_blocks_domain_services_checkoutfieldsschema_validation() {
	rt.init_static_prop('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation',
		'meta_schema_json', rt.new_string(''))
}

fn Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation.get_field_schema_with_context(var_field_id rt.PhpVal, var_field_schema rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_primary_key := rt.new_string('checkout')
	mut var_secondary_key := rt.new_string('additional_fields')
	mut switch_val_1 := var_context
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('billing_address')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('shipping_address'))) {
		var_primary_key = rt.new_string('customer')
		var_secondary_key = var_context
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('contact'))) {
		var_primary_key = rt.new_string('customer')
		var_secondary_key = rt.new_string('additional_fields')
	}
	return rt.create_array([
		rt.ArrayItem{ key: var_primary_key, val: rt.create_array([
			rt.ArrayItem{ key: 'properties', val: rt.create_array([
				rt.ArrayItem{ key: var_secondary_key, val: rt.create_array([
					rt.ArrayItem{ key: 'properties', val: rt.create_array([
						rt.ArrayItem{ key: var_field_id, val: var_field_schema },
					]) },
				]) },
			]) },
		]) },
	])
}

fn Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation.schema_is_unwrapped(var_schema rt.PhpVal) bool {
	return var_schema.array_isset(rt.new_string('cart'))
		|| var_schema.array_isset(rt.new_string('checkout'))
		|| var_schema.array_isset(rt.new_string('customer'))
}

fn Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation.validate_document_object(mut var_document_object Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_DocumentObject, var_rules rt.PhpVal) bool {
	mut var_rules_mutated := var_rules
	if rt.is_true(Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation.schema_is_unwrapped(var_rules_mutated.clone())) {
		var_rules_mutated = rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-07/schema#' },
			rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{ key: 'properties', val: var_rules_mutated },
		])
	} else {
		if !(var_rules_mutated.array_isset(rt.new_string('$schema'))) {
			var_rules_mutated.array_set('$schema', 'http://json-schema.org/draft-07/schema#')
		}
		if !(var_rules_mutated.array_isset(rt.new_string('type'))) {
			var_rules_mutated.array_set('type', 'object')
		}
	}
	mut var_validator :=
		create_automattic_woocommerce_blocks_domain_services_checkoutfieldsschema_validator()
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut iife_temp_0 :=
		Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Helper{}
	mut iife_result_0 := iife_temp_0.tojson(var_document_object.get_data())
	mut iife_temp_1 :=
		Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Helper{}
	mut iife_result_1 := iife_temp_1.tojson(var_rules_mutated.clone())
	mut var_result := var_validator.validate(iife_result_0, iife_result_1)
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_result, 'hasError', []rt.PhpVal{}))))) {
		return true
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1,
		'Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Exception')
	{
		mut var_e := var_e_1.clone()
		return (create_wp_error(rt.new_string('woocommerce_rest_checkout_validation_failed'), rt.call_function('__', [
			rt.new_string('Validation failed.'),
			rt.new_string('woocommerce'),
		]))).to_bool()
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	return (create_wp_error(rt.new_string('woocommerce_rest_checkout_invalid_field'), rt.call_function('__', [
		rt.new_string('Invalid field.'),
		rt.new_string('woocommerce'),
	]))).to_bool()
}

fn Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation.has_field_schema(var_fields rt.PhpVal) rt.PhpVal {
	mut var_return := rt.new_bool(false)
	mut iter_1 := var_fields.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_field := item_1.val
		if  ((!(!rt.is_true(var_field.array_get(rt.new_string('validation'))))
			&& var_field.array_get(rt.new_string('validation')).is_array())
			|| (!(!rt.is_true(var_field.array_get(rt.new_string('required'))))
			&& var_field.array_get(rt.new_string('required')).is_array()))
			|| (!(!rt.is_true(var_field.array_get(rt.new_string('hidden'))))
			&& var_field.array_get(rt.new_string('hidden')).is_array()) {
			var_return = rt.new_bool(true)
			break
		}
	}
	return var_return.clone()
}

fn Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation.is_valid_schema(var_rules rt.PhpVal) bool {
	mut var_rules_mutated := var_rules
	if !(var_rules_mutated.clone().is_array()) {
		return (create_wp_error(rt.new_string('woocommerce_rest_checkout_invalid_field_schema'),
			rt.new_string('Rules must be defined as an array.'))).to_bool()
	}
	if !rt.is_true(var_rules_mutated) {
		return true
	}
	if rt.is_true(Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation.schema_is_unwrapped(var_rules_mutated.clone())) {
		var_rules_mutated = rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{ key: 'properties', val: var_rules_mutated }])
	}
	if !rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation',
		'meta_schema_json')) {
		rt.set_static_prop('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation',
			'meta_schema_json', rt.call_function('file_get_contents', [
			rt.new_string(@DIR + '/json-schema-draft-07.json'),
		]))
	}
	mut var_validator :=
		create_automattic_woocommerce_blocks_domain_services_checkoutfieldsschema_validator()
	mut iife_temp_2 :=
		Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Helper{}
	mut iife_result_2 := iife_temp_2.tojson(rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-07/schema#' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'test', val: var_rules_mutated },
		]) },
		rt.ArrayItem{ key: 'required', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'test' },
		]) },
	]))
	mut var_result := var_validator.validate(iife_result_2, rt.get_static_prop('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation',
		'meta_schema_json'))
	if rt.is_true(rt.call_method(var_result, 'hasError', []rt.PhpVal{})) {
		return (create_wp_error(rt.new_string('woocommerce_rest_checkout_invalid_field_schema'), rt.call_function('esc_html', [
			rt.new_string((rt.call_method(var_result, 'error', []rt.PhpVal{})).str()),
		]))).to_bool()
	}
	return true
}

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validator {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Helper {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_domain_services_checkoutfieldsschema_validation(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_domain_services_checkoutfieldsschema_validator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validator {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_domain_services_checkoutfieldsschema_helper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Helper {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_field_schema_with_context' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation.get_field_schema_with_context(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'schema_is_unwrapped' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation.schema_is_unwrapped(dispatch_arg_0))
		}
		'validate_document_object' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_DocumentObject](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation.validate_document_object(mut dispatch_arg_0,
				dispatch_arg_1))
		}
		'has_field_schema' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation.has_field_schema(dispatch_arg_0)
		}
		'is_valid_schema' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation.is_valid_schema(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	// unsupported statement: Stmt_GroupUse
}
