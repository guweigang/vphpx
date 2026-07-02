import rt

pub fn Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.billing_fields_prefix() string {
	return '_wc_billing/'
}
pub fn Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.shipping_fields_prefix() string {
	return '_wc_shipping/'
}
pub fn Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.additional_fields_prefix() string {
	return '_wc_additional/'
}
pub fn Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.other_fields_prefix() string {
	return '_wc_other/'
}
struct Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields {
	rt.PhpObjectBase
pub mut:
		additional_fields rt.PhpVal = rt.new_array()
		fields_locations rt.PhpVal = rt.new_null()
		supported_field_types rt.PhpVal = rt.new_array()
		groups rt.PhpVal = rt.new_array()
		asset_data_registry rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) construct(mut var_asset_data_registry Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) {
	this.asset_data_registry = var_asset_data_registry
	this.fields_locations = rt.create_array([rt.ArrayItem{ key: 'address', val: rt.call_function('array_merge', [rt.call_function('array_diff_key', [this.get_core_fields_keys(), rt.create_array([rt.ArrayItem{ key: none, val: 'email' }])])]) }, rt.ArrayItem{ key: 'contact', val: rt.create_array([rt.ArrayItem{ key: none, val: 'email' }]) }, rt.ArrayItem{ key: 'order', val: rt.new_array() }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) init() {
	rt.call_function('add_filter', [rt.new_string('woocommerce_get_country_locale_default'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'update_default_locale_with_fields' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_blocks_checkout_enqueue_data'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_fields_data' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_blocks_cart_enqueue_data'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_fields_data' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_customer_allowed_session_meta_keys'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_session_meta_keys' }])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) add_fields_data() {
	rt.call_method(this.asset_data_registry, 'add', [rt.new_string('defaultFields'), rt.call_function('array_merge', [this.get_core_fields(), this.get_additional_fields()])])
	rt.call_method(this.asset_data_registry, 'add', [rt.new_string('addressFieldsLocations'), this.fields_locations])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) add_session_meta_keys(var_keys rt.PhpVal) rt.PhpVal {
	mut var_meta_keys := rt.new_array()
	mut iter_1 := this.get_additional_fields().iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_field := item_1.val
		mut var_field_key := item_1.key
		if rt.is_true(rt.identical(rt.new_string('address'), var_field.array_get(rt.new_string('location')))) {
			var_meta_keys.array_push((Class_Automattic_WooCommerce_Blocks_Domain_Services_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.billing_fields_prefix()).str() + (var_field_key).str())
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			var_meta_keys.array_push((Class_Automattic_WooCommerce_Blocks_Domain_Services_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.shipping_fields_prefix()).str() + (var_field_key).str())
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		} else {
			var_meta_keys.array_push((Class_Automattic_WooCommerce_Blocks_Domain_Services_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.other_fields_prefix()).str() + (var_field_key).str())
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Blocks_Domain_Services_Throwable') {
		mut var_e := var_e_1.clone()
		rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('Error adding session meta keys for checkout fields. %s'), rt.call_function('esc_attr', [rt.call_method(var_e, 'getMessage', []rt.PhpVal{})])]), rt.get_constant('E_USER_WARNING')])
		return var_keys.clone()
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.call_function('array_merge', [var_keys.clone(), var_meta_keys.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) default_sanitize_callback(var_value rt.PhpVal, var_field rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_field_mutated := var_field
	return var_value_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) default_validate_callback(var_value rt.PhpVal, var_field rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_field_mutated := var_field
	if rt.is_true(rt.identical(rt.new_bool(true), var_field_mutated.array_get(rt.new_string('required')))) && !rt.is_true(var_value_mutated) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_required_checkout_field'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The field %s is required.'), rt.new_string('woocommerce')]), var_field_mutated.array_get(rt.new_string('id'))])))
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) register_checkout_field(var_options rt.PhpVal) {
	mut var_options_mutated := var_options
	if rt.is_true(rt.identical(rt.new_bool(false), this.validate_options(var_options_mutated.clone()))) {
		return
	}
	mut var_field_data := rt.call_function('wp_parse_args', [var_options_mutated.clone(), rt.create_array([rt.ArrayItem{ key: 'id', val: '' }, rt.ArrayItem{ key: 'label', val: '' }, rt.ArrayItem{ key: 'optionalLabel', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s (optional)'), rt.new_string('woocommerce')]), var_options_mutated.array_get(rt.new_string('label'))]) }, rt.ArrayItem{ key: 'location', val: '' }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'hidden', val: false }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'attributes', val: rt.new_array() }, rt.ArrayItem{ key: 'show_in_order_confirmation', val: true }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'default_sanitize_callback' }]) }, rt.ArrayItem{ key: 'validate_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'default_validate_callback' }]) }, rt.ArrayItem{ key: 'validation', val: rt.new_array() }])])
	var_field_data.array_set('attributes', this.register_field_attributes(var_field_data.array_get(rt.new_string('id')), var_field_data.array_get(rt.new_string('attributes'))))
	var_field_data = this.process_field_options(var_field_data.clone(), var_options_mutated.clone())
	if rt.is_true(rt.identical(rt.new_bool(false), var_field_data)) {
		return
	}
	this.additional_fields.array_set(var_field_data.array_get(rt.new_string('id')), var_field_data.clone())
	this.fields_locations.array_get_mut(var_field_data.array_get(rt.new_string('location'))).array_push(var_field_data.array_get(rt.new_string('id')))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) is_required_field(var_field rt.PhpVal, var_document_object rt.PhpVal) bool {
	mut var_field_mutated := var_field
	if rt.is_true(rt.new_bool(var_field_mutated.clone().is_string())) {
	var_field_mutated = if !(this.additional_fields.array_get(var_field_mutated)).is_null() { this.additional_fields.array_get(var_field_mutated) } else { rt.new_array() }
	}
	if !rt.is_true(var_field_mutated) {
		return false
	}
	if rt.is_true(var_document_object) {
		if this.is_hidden_field(var_field_mutated.clone(), var_document_object.clone()) {
			return false
		}
		if this.contains_valid_rules(var_field_mutated.array_get(rt.new_string('required'))) {
			mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_Domain_Services_Validation{}
			mut iife_result_0 := iife_temp_0.validate_document_object(var_document_object.clone(), var_field_mutated.array_get(rt.new_string('required')))
			return (rt.identical(rt.new_bool(true), iife_result_0)).to_bool()
		}
	}
	return (rt.identical(rt.new_bool(true), var_field_mutated.array_get(rt.new_string('required')))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) is_hidden_field(var_field rt.PhpVal, var_document_object rt.PhpVal) bool {
	mut var_field_mutated := var_field
	if rt.is_true(rt.new_bool(var_field_mutated.clone().is_string())) {
	var_field_mutated = if !(this.additional_fields.array_get(var_field_mutated)).is_null() { this.additional_fields.array_get(var_field_mutated) } else { rt.new_array() }
	}
	if rt.is_true(var_document_object) && this.contains_valid_rules(var_field_mutated.array_get(rt.new_string('hidden'))) {
		mut iife_temp_1 := Class_Automattic_WooCommerce_Blocks_Domain_Services_Validation{}
		mut iife_result_1 := iife_temp_1.validate_document_object(var_document_object.clone(), var_field_mutated.array_get(rt.new_string('hidden')))
		return (rt.identical(rt.new_bool(true), iife_result_1)).to_bool()
	}
	return false
	return false
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) is_conditional_field(var_field rt.PhpVal) bool {
	mut var_field_mutated := var_field
	if rt.is_true(rt.new_bool(var_field_mutated.clone().is_string())) {
	var_field_mutated = if !(this.additional_fields.array_get(var_field_mutated)).is_null() { this.additional_fields.array_get(var_field_mutated) } else { rt.new_array() }
	}
	return this.contains_valid_rules(var_field_mutated.array_get(rt.new_string('required'))) || this.contains_valid_rules(var_field_mutated.array_get(rt.new_string('hidden')))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) is_valid_field(var_field rt.PhpVal, var_document_object rt.PhpVal) bool {
	mut var_field_mutated := var_field
	if rt.is_true(var_document_object) && this.contains_valid_rules(var_field_mutated.array_get(rt.new_string('validation'))) {
		mut iife_temp_2 := Class_Automattic_WooCommerce_Blocks_Domain_Services_Validation{}
		mut iife_result_2 := iife_temp_2.get_field_schema_with_context(var_field_mutated.array_get(rt.new_string('id')), var_field_mutated.array_get(rt.new_string('validation')), rt.call_method(var_document_object, 'get_context', []rt.PhpVal{}))
		mut var_field_schema := iife_result_2
		mut iife_temp_3 := Class_Automattic_WooCommerce_Blocks_Domain_Services_Validation{}
		mut iife_result_3 := iife_temp_3.validate_document_object(var_document_object.clone(), var_field_schema.clone())
		return (iife_result_3).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) contains_valid_rules(var_property rt.PhpVal) bool {
	return var_property.clone().is_array() && !(!rt.is_true(var_property))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_validate_callback(var_field rt.PhpVal, var_document_object rt.PhpVal) rt.PhpVal {
	mut var_field_mutated := var_field
	if rt.is_true(rt.new_bool(var_field_mutated.clone().is_string())) {
	var_field_mutated = if !(this.additional_fields.array_get(var_field_mutated)).is_null() { this.additional_fields.array_get(var_field_mutated) } else { rt.new_array() }
	}
	if rt.is_true(var_document_object) && this.contains_valid_rules(var_field_mutated.array_get(rt.new_string('validation'))) {
		closure_5_fn := fn [var_document_object] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_field_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_field := if args.len > 1 { args[1].clone() } else { rt.new_null() }
			mut var_errors := create_wp_error()
			if rt.is_true(rt.new_bool(!(rt.is_true(var_field_mutated)))) {
				return rt.new_bool(true)
			}
			mut var_validate_result := rt.new_bool(this.is_valid_field(var_field_mutated.clone(), var_document_object.clone()))
			if rt.is_true(rt.call_function('is_wp_error', [var_validate_result.clone()])) {
				mut var_error_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Please provide a valid %s'), rt.new_string('woocommerce')]), var_field_mutated.array_get(rt.new_string('label'))])
				mut var_error_code := rt.new_string('woocommerce_invalid_checkout_field')
				var_errors.add(var_error_code.clone(), var_error_message.clone())
			}
			return if rt.is_true(var_errors.has_errors()) { var_errors } else { rt.new_bool(true) }
			}
		return rt.new_closure(closure_5_fn)
	}
	return if !(var_field_mutated.array_get(rt.new_string('validate_callback'))).is_null() { var_field_mutated.array_get(rt.new_string('validate_callback')) } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) deregister_checkout_field(var_field_id rt.PhpVal) {
	if !rt.is_true(this.additional_fields.array_get(var_field_id)) {
		return
	}
	mut var_location := rt.new_string(this.get_field_location(var_field_id.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_location)))) {
		return
	}
	this.fields_locations.array_set(var_location, rt.call_function('array_diff', [this.fields_locations.array_get(var_location), rt.create_array([rt.ArrayItem{ key: none, val: var_field_id }])]))
	this.additional_fields.array_unset(var_field_id)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) validate_options(var_options rt.PhpVal) bool {
	mut var_options_mutated := var_options
	if !rt.is_true(var_options_mutated.array_get(rt.new_string('id'))) {
		rt.call_function('_doing_it_wrong', [rt.new_string('woocommerce_register_additional_checkout_field'), rt.new_string('A checkout field cannot be registered without an id.'), rt.new_string('8.6.0')])
		return false
	}
	if rt.call_function('explode', [rt.new_string('/'), var_options_mutated.array_get(rt.new_string('id'))]).array_count() < 2 {
		mut var_message := rt.call_function('sprintf', [rt.new_string('Unable to register field with id: "%s". %s'), var_options_mutated.array_get(rt.new_string('id')), rt.new_string('A checkout field id must consist of namespace/name.')])
		rt.call_function('_doing_it_wrong', [rt.new_string('woocommerce_register_additional_checkout_field'), rt.call_function('esc_html', [var_message.clone()]), rt.new_string('8.6.0')])
		return false
	}
	if !rt.is_true(var_options_mutated.array_get(rt.new_string('label'))) {
		var_message = rt.call_function('sprintf', [rt.new_string('Unable to register field with id: "%s". %s'), var_options_mutated.array_get(rt.new_string('id')), rt.new_string('The field label is required.')])
		rt.call_function('_doing_it_wrong', [rt.new_string('woocommerce_register_additional_checkout_field'), rt.call_function('esc_html', [var_message.clone()]), rt.new_string('8.6.0')])
		return false
	}
	if !rt.is_true(var_options_mutated.array_get(rt.new_string('location'))) {
		var_message = rt.call_function('sprintf', [rt.new_string('Unable to register field with id: "%s". %s'), var_options_mutated.array_get(rt.new_string('id')), rt.new_string('The field location is required.')])
		rt.call_function('_doing_it_wrong', [rt.new_string('woocommerce_register_additional_checkout_field'), rt.call_function('esc_html', [var_message.clone()]), rt.new_string('8.6.0')])
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('additional'), var_options_mutated.array_get(rt.new_string('location')))) {
		rt.call_function('wc_deprecated_argument', [rt.new_string('location'), rt.new_string('8.9.0'), rt.new_string('The "additional" location is deprecated. Use "order" instead.')])
		var_options_mutated.array_set('location', 'order')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_options_mutated.array_get(rt.new_string('location')), rt.func_array_keys(this.fields_locations), rt.new_bool(true)]))))) {
		var_message = rt.call_function('sprintf', [rt.new_string('Unable to register field with id: "%s". %s'), var_options_mutated.array_get(rt.new_string('id')), rt.new_string('The field location is invalid.')])
		rt.call_function('_doing_it_wrong', [rt.new_string('woocommerce_register_additional_checkout_field'), rt.call_function('esc_html', [var_message.clone()]), rt.new_string('8.6.0')])
		return false
	}
	mut var_location := var_options_mutated.array_get(rt.new_string('location'))
	mut var_id := var_options_mutated.array_get(rt.new_string('id'))
	if !(!rt.is_true(this.additional_fields.array_get(var_id))) || rt.is_true(rt.call_function('in_array', [var_id.clone(), this.fields_locations.array_get(var_location), rt.new_bool(true)])) {
		var_message = rt.call_function('sprintf', [rt.new_string('Unable to register field with id: "%s". %s'), var_id.clone(), rt.new_string('The field is already registered.')])
		rt.call_function('_doing_it_wrong', [rt.new_string('woocommerce_register_additional_checkout_field'), rt.call_function('esc_html', [var_message.clone()]), rt.new_string('8.6.0')])
		return false
	}
	if !(!rt.is_true(var_options_mutated.array_get(rt.new_string('type')))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_options_mutated.array_get(rt.new_string('type')), this.supported_field_types, rt.new_bool(true)]))))) {
			var_message = rt.call_function('sprintf', [rt.new_string('Unable to register field with id: "%s". Registering a field with type "%s" is not supported. The supported types are: %s.'), var_id.clone(), var_options_mutated.array_get(rt.new_string('type')), rt.call_function('implode', [rt.new_string(', '), this.supported_field_types])])
			rt.call_function('_doing_it_wrong', [rt.new_string('woocommerce_register_additional_checkout_field'), rt.call_function('esc_html', [var_message.clone()]), rt.new_string('8.6.0')])
			return false
		}
	}
	if !(!rt.is_true(var_options_mutated.array_get(rt.new_string('sanitize_callback')))) && !(rt.call_function('is_callable', [var_options_mutated.array_get(rt.new_string('sanitize_callback'))])) {
		var_message = rt.call_function('sprintf', [rt.new_string('Unable to register field with id: "%s". %s'), var_id.clone(), rt.new_string('The sanitize_callback must be a valid callback.')])
		rt.call_function('_doing_it_wrong', [rt.new_string('woocommerce_register_additional_checkout_field'), rt.call_function('esc_html', [var_message.clone()]), rt.new_string('8.6.0')])
		return false
	}
	if !(!rt.is_true(var_options_mutated.array_get(rt.new_string('validate_callback')))) && !(rt.call_function('is_callable', [var_options_mutated.array_get(rt.new_string('validate_callback'))])) {
		var_message = rt.call_function('sprintf', [rt.new_string('Unable to register field with id: "%s". %s'), var_id.clone(), rt.new_string('The validate_callback must be a valid callback.')])
		rt.call_function('_doing_it_wrong', [rt.new_string('woocommerce_register_additional_checkout_field'), rt.call_function('esc_html', [var_message.clone()]), rt.new_string('8.6.0')])
		return false
	}
	if !(!rt.is_true(var_options_mutated.array_get(rt.new_string('hidden')))) && rt.is_true(rt.identical(rt.new_bool(true), var_options_mutated.array_get(rt.new_string('hidden')))) {
		var_message = rt.call_function('sprintf', [rt.new_string('Registering a field with hidden set to true is not supported. The field "%s" will be registered as visible.'), var_id.clone()])
		rt.call_function('_doing_it_wrong', [rt.new_string('woocommerce_register_additional_checkout_field'), rt.call_function('esc_html', [var_message.clone()]), rt.new_string('8.6.0')])
	}
	mut var_rule_fields := rt.create_array([rt.ArrayItem{ key: none, val: 'required' }, rt.ArrayItem{ key: none, val: 'hidden' }, rt.ArrayItem{ key: none, val: 'validation' }])
	mut var_allow_bool := rt.create_array([rt.ArrayItem{ key: none, val: 'required' }, rt.ArrayItem{ key: none, val: 'hidden' }])
	mut iter_2 := var_rule_fields.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_rule_field := item_2.val
		if !(!rt.is_true(var_options_mutated.array_get(var_rule_field))) {
			if rt.is_true(rt.call_function('in_array', [var_rule_field.clone(), var_allow_bool.clone(), rt.new_bool(true)])) && var_options_mutated.array_get(var_rule_field).is_bool() {
				continue
			}
			mut iife_temp_5 := Class_Automattic_WooCommerce_Blocks_Domain_Services_Validation{}
			mut iife_result_5 := iife_temp_5.is_valid_schema(var_options_mutated.array_get(var_rule_field))
			mut var_valid := iife_result_5
			if rt.is_true(rt.call_function('is_wp_error', [var_valid.clone()])) {
				var_message = rt.call_function('sprintf', [rt.new_string('Unable to register field with id: "%s". %s'), var_options_mutated.array_get(rt.new_string('id')), rt.new_string((var_rule_field).str() + ': ' + (rt.call_method(var_valid, 'get_error_message', []rt.PhpVal{})).str())])
				rt.call_function('_doing_it_wrong', [rt.new_string('woocommerce_register_additional_checkout_field'), rt.call_function('esc_html', [var_message.clone()]), rt.new_string('8.6.0')])
				return false
			}
		}
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) process_field_options(var_field_data rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_field_data_mutated := var_field_data
	mut var_options_mutated := var_options
	if rt.is_true(rt.identical(rt.new_string('checkbox'), var_field_data_mutated.array_get(rt.new_string('type')))) {
	var_field_data_mutated = this.process_checkbox_field(var_field_data_mutated.clone(), var_options_mutated.clone())
	} else if rt.is_true(rt.identical(rt.new_string('select'), var_field_data_mutated.array_get(rt.new_string('type')))) {
	var_field_data_mutated = rt.new_bool(this.process_select_field(var_field_data_mutated.clone(), var_options_mutated.clone()))
	}
	return var_field_data_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) process_select_field(var_field_data rt.PhpVal, var_options rt.PhpVal) bool {
	mut var_field_data_mutated := var_field_data
	mut var_options_mutated := var_options
	mut var_id := var_options_mutated.array_get(rt.new_string('id'))
	if !rt.is_true(var_options_mutated.array_get(rt.new_string('options'))) || !(var_options_mutated.array_get(rt.new_string('options')).is_array()) {
		mut var_message := rt.call_function('sprintf', [rt.new_string('Unable to register field with id: "%s". %s'), var_id.clone(), rt.new_string('Fields of type "select" must have an array of "options".')])
		rt.call_function('_doing_it_wrong', [rt.new_string('woocommerce_register_additional_checkout_field'), rt.call_function('esc_html', [var_message.clone()]), rt.new_string('8.6.0')])
		return false
	}
	mut var_cleaned_options := rt.new_array()
	mut var_added_values := rt.new_array()
	mut iter_3 := var_options_mutated.array_get(rt.new_string('options')).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_option := item_3.val
		if !(var_option.array_isset(rt.new_string('value'))) || !(var_option.array_isset(rt.new_string('label'))) {
			var_message = rt.call_function('sprintf', [rt.new_string('Unable to register field with id: "%s". %s'), var_id.clone(), rt.new_string('Fields of type "select" must have an array of "options" and each option must contain a "value" and "label" member.')])
			rt.call_function('_doing_it_wrong', [rt.new_string('woocommerce_register_additional_checkout_field'), rt.call_function('esc_html', [var_message.clone()]), rt.new_string('8.6.0')])
			return false
		}
		mut var_sanitized_value := rt.call_function('sanitize_text_field', [var_option.array_get(rt.new_string('value'))])
		mut var_sanitized_label := rt.call_function('sanitize_text_field', [var_option.array_get(rt.new_string('label'))])
		if rt.is_true(rt.call_function('in_array', [var_sanitized_value.clone(), var_added_values.clone(), rt.new_bool(true)])) {
			var_message = rt.call_function('sprintf', [rt.new_string('Duplicate key found when registering field with id: "%s". The value in each option of "select" fields must be unique. Duplicate value "%s" found. The duplicate key will be removed.'), var_id.clone(), var_sanitized_value.clone()])
			rt.call_function('_doing_it_wrong', [rt.new_string('woocommerce_register_additional_checkout_field'), rt.call_function('esc_html', [var_message.clone()]), rt.new_string('8.6.0')])
			continue
		}
		var_added_values.array_push(var_sanitized_value.clone())
		var_cleaned_options.array_push(rt.create_array([rt.ArrayItem{ key: 'value', val: var_sanitized_value }, rt.ArrayItem{ key: 'label', val: var_sanitized_label }]))
	}
	var_field_data_mutated.array_set('options', var_cleaned_options.clone())
	if var_field_data_mutated.array_isset(rt.new_string('placeholder')) {
		var_field_data_mutated.array_set('placeholder', rt.call_function('sanitize_text_field', [var_field_data_mutated.array_get(rt.new_string('placeholder'))]))
	}
	return (var_field_data_mutated).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) process_checkbox_field(var_field_data rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_field_data_mutated := var_field_data
	mut var_options_mutated := var_options
	mut var_id := var_options_mutated.array_get(rt.new_string('id'))
	var_field_data_mutated.array_set('required', if !(var_options_mutated.array_get(rt.new_string('required'))).is_null() { var_options_mutated.array_get(rt.new_string('required')) } else { rt.new_bool(false) })
	if rt.is_true(rt.identical(rt.new_bool(false), var_field_data_mutated.array_get(rt.new_string('required')))) && !(!rt.is_true(var_options_mutated.array_get(rt.new_string('error_message')))) {
		mut var_message := rt.call_function('sprintf', [rt.new_string('Passing an error message to a non-required checkbox "%s" will have no effect. The error message has been removed from the field.'), var_id.clone()])
		rt.call_function('_doing_it_wrong', [rt.new_string('woocommerce_register_additional_checkout_field'), rt.call_function('esc_html', [var_message.clone()]), rt.new_string('9.8.0')])
		var_field_data_mutated.array_unset(rt.new_string('error_message'))
	}
	if var_options_mutated.array_isset(rt.new_string('error_message')) && !(var_options_mutated.array_get(rt.new_string('error_message')).is_string()) {
		var_message = rt.call_function('sprintf', [rt.new_string('The error_message property for field with id: "%s" must be a string, you passed %s. A default message will be shown.'), var_id.clone(), rt.call_function('gettype', [var_options_mutated.array_get(rt.new_string('error_message'))])])
		rt.call_function('_doing_it_wrong', [rt.new_string('woocommerce_register_additional_checkout_field'), rt.call_function('esc_html', [var_message.clone()]), rt.new_string('9.8.0')])
		var_field_data_mutated.array_unset(rt.new_string('error_message'))
	}
	if var_field_data_mutated.array_isset(rt.new_string('error_message')) {
		var_field_data_mutated.array_set('errorMessage', var_field_data_mutated.array_get(rt.new_string('error_message')))
		var_field_data_mutated.array_unset(rt.new_string('error_message'))
	}
	return var_field_data_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) register_field_attributes(var_id rt.PhpVal, var_attributes rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
	if !rt.is_true(var_attributes) {
		return rt.new_array()
	}
	if !(var_attributes.clone().is_array()) || 0 == var_attributes.clone().array_count() {
		mut var_message := rt.call_function('sprintf', [rt.new_string('An invalid attributes value was supplied when registering field with id: "%s". %s'), var_id_mutated.clone(), rt.new_string('Attributes must be a non-empty array.')])
		rt.call_function('_doing_it_wrong', [rt.new_string('woocommerce_register_additional_checkout_field'), rt.call_function('esc_html', [var_message.clone()]), rt.new_string('8.6.0')])
		return rt.new_array()
	}
	mut var_allowed_attributes := rt.create_array([rt.ArrayItem{ key: none, val: 'maxLength' }, rt.ArrayItem{ key: none, val: 'readOnly' }, rt.ArrayItem{ key: none, val: 'pattern' }, rt.ArrayItem{ key: none, val: 'autocomplete' }, rt.ArrayItem{ key: none, val: 'autocapitalize' }, rt.ArrayItem{ key: none, val: 'title' }])
	closure_7_fn := fn [var_allowed_attributes] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var__ := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_key := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return rt.new_bool(rt.is_true(rt.call_function('in_array', [var_key.clone(), var_allowed_attributes.clone(), rt.new_bool(true)])) || rt.is_true(rt.identical(rt.call_function('strpos', [var_key.clone(), rt.new_string('aria-')]), rt.new_int(0))) || rt.is_true(rt.identical(rt.call_function('strpos', [var_key.clone(), rt.new_string('data-')]), rt.new_int(0))))
		}
	mut var_valid_attributes := rt.call_function('array_filter', [var_attributes.clone(), rt.new_closure(closure_7_fn), rt.get_constant('ARRAY_FILTER_USE_BOTH')])
	if rt.is_true(rt.new_bool(var_attributes.clone().array_count() != var_valid_attributes.clone().array_count())) {
		mut var_invalid_attributes := rt.func_array_keys(rt.call_function('array_diff_key', [var_attributes.clone(), var_valid_attributes.clone()]))
		var_message = rt.call_function('sprintf', [rt.new_string('Invalid attribute found when registering field with id: "%s". Attributes: %s are not allowed.'), var_id_mutated.clone(), rt.call_function('implode', [rt.new_string(', '), var_invalid_attributes.clone()])])
		rt.call_function('_doing_it_wrong', [rt.new_string('woocommerce_register_additional_checkout_field'), rt.call_function('esc_html', [var_message.clone()]), rt.new_string('8.6.0')])
	}
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('esc_attr', [var_value.clone()])
		}
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('esc_attr', [var_value.clone()])
		}
	return rt.call_function('array_map', [rt.new_closure(closure_8_fn), var_valid_attributes.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_core_fields_keys() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'email' }, rt.ArrayItem{ key: none, val: 'country' }, rt.ArrayItem{ key: none, val: 'first_name' }, rt.ArrayItem{ key: none, val: 'last_name' }, rt.ArrayItem{ key: none, val: 'company' }, rt.ArrayItem{ key: none, val: 'address_1' }, rt.ArrayItem{ key: none, val: 'address_2' }, rt.ArrayItem{ key: none, val: 'city' }, rt.ArrayItem{ key: none, val: 'state' }, rt.ArrayItem{ key: none, val: 'postcode' }, rt.ArrayItem{ key: none, val: 'phone' }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_core_fields() rt.PhpVal {
	mut iife_temp_9 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_9 := iife_temp_9.get_company_field_visibility()
	mut iife_temp_10 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_10 := iife_temp_10.get_company_field_visibility()
	mut iife_temp_11 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_11 := iife_temp_11.get_address_2_field_visibility()
	mut iife_temp_12 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_12 := iife_temp_12.get_address_2_field_visibility()
	mut iife_temp_13 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_13 := iife_temp_13.get_phone_field_visibility()
	mut iife_temp_14 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_14 := iife_temp_14.get_phone_field_visibility()
	return rt.create_array([rt.ArrayItem{ key: 'email', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Email address'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'optionalLabel', val: rt.call_function('__', [rt.new_string('Email address (optional)'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'hidden', val: false }, rt.ArrayItem{ key: 'autocomplete', val: 'email' }, rt.ArrayItem{ key: 'autocapitalize', val: 'none' }, rt.ArrayItem{ key: 'type', val: 'email' }, rt.ArrayItem{ key: 'index', val: 0 }]) }, rt.ArrayItem{ key: 'country', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Country/Region'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'optionalLabel', val: rt.call_function('__', [rt.new_string('Country/Region (optional)'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'hidden', val: false }, rt.ArrayItem{ key: 'autocomplete', val: 'country' }, rt.ArrayItem{ key: 'index', val: 1 }]) }, rt.ArrayItem{ key: 'first_name', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('First name'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'optionalLabel', val: rt.call_function('__', [rt.new_string('First name (optional)'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'hidden', val: false }, rt.ArrayItem{ key: 'autocomplete', val: 'given-name' }, rt.ArrayItem{ key: 'autocapitalize', val: 'sentences' }, rt.ArrayItem{ key: 'index', val: 10 }]) }, rt.ArrayItem{ key: 'last_name', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Last name'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'optionalLabel', val: rt.call_function('__', [rt.new_string('Last name (optional)'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'hidden', val: false }, rt.ArrayItem{ key: 'autocomplete', val: 'family-name' }, rt.ArrayItem{ key: 'autocapitalize', val: 'sentences' }, rt.ArrayItem{ key: 'index', val: 20 }]) }, rt.ArrayItem{ key: 'company', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Company'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'optionalLabel', val: rt.call_function('__', [rt.new_string('Company (optional)'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'required', val: rt.identical(rt.new_string('required'), iife_result_9) }, rt.ArrayItem{ key: 'hidden', val: rt.identical(rt.new_string('hidden'), iife_result_10) }, rt.ArrayItem{ key: 'autocomplete', val: 'organization' }, rt.ArrayItem{ key: 'autocapitalize', val: 'sentences' }, rt.ArrayItem{ key: 'index', val: 30 }]) }, rt.ArrayItem{ key: 'address_1', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Address'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'optionalLabel', val: rt.call_function('__', [rt.new_string('Address (optional)'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'hidden', val: false }, rt.ArrayItem{ key: 'autocomplete', val: 'address-line1' }, rt.ArrayItem{ key: 'autocapitalize', val: 'sentences' }, rt.ArrayItem{ key: 'index', val: 40 }]) }, rt.ArrayItem{ key: 'address_2', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Apartment, suite, etc.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'optionalLabel', val: rt.call_function('__', [rt.new_string('Apartment, suite, etc. (optional)'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'required', val: rt.identical(rt.new_string('required'), iife_result_11) }, rt.ArrayItem{ key: 'hidden', val: rt.identical(rt.new_string('hidden'), iife_result_12) }, rt.ArrayItem{ key: 'autocomplete', val: 'address-line2' }, rt.ArrayItem{ key: 'autocapitalize', val: 'sentences' }, rt.ArrayItem{ key: 'index', val: 50 }]) }, rt.ArrayItem{ key: 'city', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('City'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'optionalLabel', val: rt.call_function('__', [rt.new_string('City (optional)'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'hidden', val: false }, rt.ArrayItem{ key: 'autocomplete', val: 'address-level2' }, rt.ArrayItem{ key: 'autocapitalize', val: 'sentences' }, rt.ArrayItem{ key: 'index', val: 70 }]) }, rt.ArrayItem{ key: 'state', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('State/County'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'optionalLabel', val: rt.call_function('__', [rt.new_string('State/County (optional)'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'hidden', val: false }, rt.ArrayItem{ key: 'autocomplete', val: 'address-level1' }, rt.ArrayItem{ key: 'autocapitalize', val: 'sentences' }, rt.ArrayItem{ key: 'index', val: 80 }]) }, rt.ArrayItem{ key: 'postcode', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Postal code'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'optionalLabel', val: rt.call_function('__', [rt.new_string('Postal code (optional)'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'hidden', val: false }, rt.ArrayItem{ key: 'autocomplete', val: 'postal-code' }, rt.ArrayItem{ key: 'autocapitalize', val: 'characters' }, rt.ArrayItem{ key: 'index', val: 90 }]) }, rt.ArrayItem{ key: 'phone', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Phone'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'optionalLabel', val: rt.call_function('__', [rt.new_string('Phone (optional)'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'required', val: rt.identical(rt.new_string('required'), iife_result_13) }, rt.ArrayItem{ key: 'hidden', val: rt.identical(rt.new_string('hidden'), iife_result_14) }, rt.ArrayItem{ key: 'type', val: 'tel' }, rt.ArrayItem{ key: 'autocomplete', val: 'tel' }, rt.ArrayItem{ key: 'autocapitalize', val: 'characters' }, rt.ArrayItem{ key: 'index', val: 100 }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_additional_fields() rt.PhpVal {
	return this.additional_fields
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_field_location(var_field_key rt.PhpVal) string {
	if !(this.is_field(var_field_key.clone())) {
		return ''
	}
	mut iter_4 := this.fields_locations.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_fields := item_4.val
		mut var_location := item_4.key
		if rt.is_true(rt.call_function('in_array', [var_field_key.clone(), var_fields.clone(), rt.new_bool(true)])) {
			return (var_location).str()
		}
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) sanitize_field(var_field_key rt.PhpVal, var_field_value rt.PhpVal) rt.PhpVal {
	mut var_field_value_mutated := var_field_value
	mut var_field := if !(this.additional_fields.array_get(var_field_key)).is_null() { this.additional_fields.array_get(var_field_key) } else { rt.new_null() }
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(var_field) {
		var_field_value_mutated = rt.call_function('call_user_func', [var_field.array_get(rt.new_string('sanitize_callback')), var_field_value_mutated.clone(), var_field.clone()])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	var_field_value_mutated = rt.call_function('apply_filters_deprecated', [rt.new_string('__experimental_woocommerce_blocks_sanitize_additional_field'), rt.create_array([rt.ArrayItem{ key: none, val: var_field_value_mutated }, rt.ArrayItem{ key: none, val: var_field_key }]), rt.new_string('8.7.0'), rt.new_string('woocommerce_sanitize_additional_field'), rt.new_string('This action has been graduated, use woocommerce_sanitize_additional_field instead.')])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_sanitize_additional_field'), var_field_value_mutated.clone(), var_field_key.clone()])
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Blocks_Domain_Services_Throwable') {
		mut var_e := var_e_2.clone()
		rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('Field sanitization for %s encountered an error. %s'), rt.call_function('esc_html', [var_field_key.clone()]), rt.call_function('esc_html', [rt.call_method(var_e, 'getMessage', []rt.PhpVal{})])]), rt.get_constant('E_USER_WARNING')])
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return var_field_value_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) validate_field(var_field rt.PhpVal, var_field_value rt.PhpVal) rt.PhpVal {
	mut var_field_mutated := var_field
	mut var_field_value_mutated := var_field_value
	mut var_errors := create_wp_error()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_field_mutated)))) {
		return mut var_errors
	}
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	if !(!rt.is_true(var_field_mutated.array_get(rt.new_string('validate_callback')))) && rt.call_function('is_callable', [var_field_mutated.array_get(rt.new_string('validate_callback'))]) {
		mut var_validate_callback_result := rt.call_function('call_user_func', [var_field_mutated.array_get(rt.new_string('validate_callback')), var_field_value_mutated.clone(), var_field_mutated.clone()])
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		if rt.is_true(rt.call_function('is_wp_error', [var_validate_callback_result.clone()])) {
			var_errors.merge_from(var_validate_callback_result.clone())
			if rt.has_exception() { unsafe { goto catch_label_3 } }
		} else if rt.is_true(rt.identical(rt.new_bool(false), var_validate_callback_result)) {
			mut var_error_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Please provide a valid %s'), rt.new_string('woocommerce')]), var_field_mutated.array_get(rt.new_string('label'))])
			if rt.has_exception() { unsafe { goto catch_label_3 } }
			var_errors.add(rt.new_string('woocommerce_invalid_checkout_field'), var_error_message.clone())
			if rt.has_exception() { unsafe { goto catch_label_3 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_3 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	rt.call_function('wc_do_deprecated_action', [rt.new_string('__experimental_woocommerce_blocks_validate_additional_field'), rt.create_array([rt.ArrayItem{ key: none, val: var_errors }, rt.ArrayItem{ key: none, val: var_field_mutated.array_get(rt.new_string('id')) }, rt.ArrayItem{ key: none, val: var_field_value_mutated }]), rt.new_string('8.7.0'), rt.new_string('woocommerce_validate_additional_field'), rt.new_string('This action has been graduated, use woocommerce_validate_additional_field instead.')])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	rt.call_function('do_action', [rt.new_string('woocommerce_validate_additional_field'), var_errors, var_field_mutated.array_get(rt.new_string('id')), var_field_value_mutated.clone()])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Automattic_WooCommerce_Blocks_Domain_Services_Throwable') {
		mut var_e := var_e_3.clone()
		rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('Field validation for %s encountered an error. %s'), rt.call_function('esc_html', [var_field_mutated.array_get(rt.new_string('id'))]), rt.call_function('esc_html', [rt.call_method(var_e, 'getMessage', []rt.PhpVal{})])]), rt.get_constant('E_USER_WARNING')])
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	return mut var_errors
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) update_default_locale_with_fields(var_locale rt.PhpVal) rt.PhpVal {
	mut var_locale_mutated := var_locale
	mut iter_5 := this.get_fields_for_location(rt.new_string('address')).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_field := item_5.val
		mut var_field_key := item_5.key
		if !rt.is_true(var_locale_mutated.array_get(var_field_key)) {
			if this.is_conditional_field(var_field_key.clone()) {
				var_field.array_set('required', false)
			}
			var_locale_mutated.array_set(var_field_key, var_field.clone())
		}
	}
	return var_locale_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_address_fields_keys() rt.PhpVal {
	return this.fields_locations.array_get(rt.new_string('address'))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_contact_fields_keys() rt.PhpVal {
	return this.fields_locations.array_get(rt.new_string('contact'))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_additional_fields_keys() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD), rt.new_string('8.9.0'), rt.new_string('get_order_fields_keys')])
	return this.get_order_fields_keys()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_order_fields_keys() rt.PhpVal {
	return this.fields_locations.array_get(rt.new_string('order'))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_fields_for_location(var_location rt.PhpVal) rt.PhpVal {
	mut var_location_mutated := var_location
	var_location_mutated = this.prepare_location_name(var_location_mutated.clone())
	if rt.is_true(rt.call_function('in_array', [var_location_mutated.clone(), rt.func_array_keys(this.fields_locations), rt.new_bool(true)])) {
		mut var_order_fields_keys := this.fields_locations.array_get(var_location_mutated)
		closure_16_fn := fn [var_order_fields_keys] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_key := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.call_function('in_array', [var_key.clone(), var_order_fields_keys.clone(), rt.new_bool(true)])
			}
		return rt.call_function('array_filter', [this.get_additional_fields(), rt.new_closure(closure_16_fn), rt.get_constant('ARRAY_FILTER_USE_KEY')])
	}
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_contextual_fields_for_location(var_location rt.PhpVal, var_document_object rt.PhpVal) rt.PhpVal {
	mut var_location_mutated := var_location
	mut var_location_fields := this.get_fields_for_location(var_location_mutated.clone())
	mut var_fields := rt.new_array()
	mut iter_6 := var_location_fields.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_field := item_6.val
		mut var_key := item_6.key
		if this.is_hidden_field(var_key.clone(), var_document_object.clone()) {
			continue
		}
		var_field.array_set('required', this.is_required_field(var_field.clone(), var_document_object.clone()))
		var_field.array_set('validate_callback', this.get_validate_callback(var_field.clone(), var_document_object.clone()))
		var_fields.array_set(var_key, var_field.clone())
	}
	return var_fields.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) validate_fields_for_location(var_fields rt.PhpVal, var_location rt.PhpVal, group string) rt.PhpVal {
	mut var_fields_mutated := var_fields
	mut var_location_mutated := var_location
	mut group_mutated := group
	mut var_errors := create_wp_error()
	var_location_mutated = this.prepare_location_name(var_location_mutated.clone())
	group_mutated = (this.prepare_group_name(rt.new_string(group_mutated))).str()
	rt.call_function('wc_do_deprecated_action', [rt.new_string('__experimental_woocommerce_blocks_validate_location_' + (var_location_mutated).str() + '_fields'), rt.create_array([rt.ArrayItem{ key: none, val: var_errors }, rt.ArrayItem{ key: none, val: var_fields_mutated }, rt.ArrayItem{ key: none, val: group_mutated }]), rt.new_string('8.9.0'), rt.new_string('woocommerce_blocks_validate_location_' + (var_location_mutated).str() + '_fields'), rt.new_string('This action has been graduated, use woocommerce_blocks_validate_location_' + (var_location_mutated).str() + '_fields instead.')])
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	rt.call_function('do_action', [rt.new_string('woocommerce_blocks_validate_location_' + (var_location_mutated).str() + '_fields'), var_errors, var_fields_mutated.clone(), rt.new_string(group_mutated).clone()])
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	unsafe { goto end_label_4 }

catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'Automattic_WooCommerce_Blocks_Domain_Services_Throwable') {
		mut var_e := var_e_4.clone()
		rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('The action %s encountered an error. The field location %s may not have any custom validation applied to it. %s'), rt.call_function('esc_html', [rt.new_string('woocommerce_blocks_validate_' + (var_location_mutated).str() + '_fields')]), rt.call_function('esc_html', [var_location_mutated.clone()]), rt.call_function('esc_html', [rt.call_method(var_e, 'getMessage', []rt.PhpVal{})])]), rt.get_constant('E_USER_WARNING')])
		unsafe { goto end_label_4 }
	}
	else {
		rt.throw_exception(var_e_4)
		unsafe { goto end_label_4 }
	}

end_label_4:
	return mut var_errors
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) validate_field_for_location(var_key rt.PhpVal, var_value rt.PhpVal, var_location rt.PhpVal) bool {
	mut var_key_mutated := var_key
	mut var_value_mutated := var_value
	mut var_location_mutated := var_location
	var_location_mutated = this.prepare_location_name(var_location_mutated.clone())
	if !(this.is_field(var_key_mutated.clone())) {
		return (create_wp_error(rt.new_string('woocommerce_invalid_checkout_field'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The field %s is invalid.'), rt.new_string('woocommerce')]), var_key_mutated.clone()]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_key_mutated.clone(), this.fields_locations.array_get(var_location_mutated), rt.new_bool(true)]))))) {
		return (create_wp_error(rt.new_string('woocommerce_invalid_checkout_field_location'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The field %1$s is invalid for the location %2$s.'), rt.new_string('woocommerce')]), var_key_mutated.clone(), var_location_mutated.clone()]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_fields_for_group(group string) rt.PhpVal {
	mut group_mutated := group
	group_mutated = (this.prepare_group_name(rt.new_string(group_mutated))).str()
	if rt.is_true(rt.identical(rt.new_string('shipping'), rt.new_string(group_mutated))) || rt.is_true(rt.identical(rt.new_string('billing'), rt.new_string(group_mutated))) {
		return this.get_fields_for_location(rt.new_string('address'))
	}
	return rt.call_function('array_merge', [this.get_fields_for_location(rt.new_string('contact')), this.get_fields_for_location(rt.new_string('order'))])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) is_field(var_key rt.PhpVal) bool {
	mut var_key_mutated := var_key
	return this.additional_fields.array_isset(var_key_mutated.clone())
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) is_customer_field(var_key rt.PhpVal) rt.PhpVal {
	mut var_key_mutated := var_key
	return rt.call_function('in_array', [var_key_mutated.clone(), rt.call_function('array_intersect', [rt.call_function('array_merge', [this.get_address_fields_keys(), this.get_contact_fields_keys()]), rt.func_array_keys(this.additional_fields)]), rt.new_bool(true)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) persist_field_for_order(key string, var_value rt.PhpVal, mut var_order Class_WC_Order, group string, set_customer bool) {
	mut key_mutated := key
	mut var_value_mutated := var_value
	mut group_mutated := group
	group_mutated = (this.prepare_group_name(rt.new_string(group_mutated))).str()
	this.set_array_meta(key_mutated, var_value_mutated.clone(), mut var_order, group_mutated)
	if var_set_customer && rt.is_true(var_order.get_customer_id()) {
		mut var_customer := create_wc_customer(var_order.get_customer_id())
		this.persist_field_for_customer(key_mutated, var_value_mutated.clone(), mut var_customer, group_mutated)
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) persist_field_for_customer(key string, var_value rt.PhpVal, mut var_customer Class_WC_Customer, group string) {
	mut key_mutated := key
	mut var_value_mutated := var_value
	mut var_customer_mutated := var_customer
	mut group_mutated := group
	group_mutated = (this.prepare_group_name(rt.new_string(group_mutated))).str()
	this.set_array_meta(key_mutated, var_value_mutated.clone(), mut var_customer_mutated, group_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) set_array_meta(key string, var_value rt.PhpVal, mut var_wc_object Class_WC_Data, group string) {
	mut key_mutated := key
	mut var_value_mutated := var_value
	mut group_mutated := group
	mut var_meta_key := rt.new_string((Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.get_group_key(rt.new_string(group_mutated))).str() + key_mutated)
	rt.call_function('do_action', [rt.new_string('woocommerce_set_additional_field_value'), rt.new_string(key_mutated).clone(), var_value_mutated.clone(), rt.new_string(group_mutated).clone(), var_wc_object])
	if rt.is_true(rt.new_bool(var_value_mutated.clone().is_bool())) {
	var_value_mutated = rt.new_string((if rt.is_true(var_value_mutated) { '1' } else { '0' }).str())
	}
	var_wc_object.update_meta_data(var_meta_key.clone(), var_value_mutated.clone())
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_field_from_object(key string, mut var_wc_object Class_WC_Data, group string) string {
	mut key_mutated := key
	mut group_mutated := group
	group_mutated = (this.prepare_group_name(rt.new_string(group_mutated))).str()
	mut var_meta_key := rt.new_string((Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.get_group_key(rt.new_string(group_mutated))).str() + key_mutated)
	mut var_value := var_wc_object.get_meta(var_meta_key.clone(), rt.new_bool(true))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_value)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('0'), var_value)))) {
	var_value = rt.call_function('apply_filters', [rt.new_string("woocommerce_get_default_value_for_${var_key.to_string()}"), rt.new_null(), rt.new_string(group_mutated).clone(), var_wc_object])
	}
	if this.is_field(rt.new_string(key_mutated)) && rt.is_true(rt.identical(rt.new_string('checkbox'), this.additional_fields.array_get(rt.new_string(key_mutated)).array_get(rt.new_string('type')))) {
		return (rt.identical(rt.new_string('1'), var_value)).str()
	}
	if rt.is_true(rt.identical(rt.new_null(), var_value)) {
		return ''
	}
	return (var_value).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_all_fields_from_object(mut var_wc_object Class_WC_Data, group string, all bool) rt.PhpVal {
	mut group_mutated := group
	mut var_meta_data := rt.new_array()
	group_mutated = (this.prepare_group_name(rt.new_string(group_mutated))).str()
	mut var_prefix := Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.get_group_key(rt.new_string(group_mutated))
	if true {
		mut var_meta := var_wc_object.get_meta_data()
		mut iter_7 := var_meta.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_meta_data_object := item_7.val
			if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [rt.get_property(var_meta_data_object, 'key'), var_prefix.clone()]))) {
				mut var_key := rt.call_function('str_replace', [var_prefix.clone(), rt.new_string(''), rt.get_property(var_meta_data_object, 'key')])
				if var_all || this.is_field(var_key.clone()) {
					var_meta_data.array_set(var_key, rt.get_property(var_meta_data_object, 'value'))
				}
			}
		}
	}
	mut var_missing_fields := rt.call_function('array_diff', [rt.func_array_keys(this.get_fields_for_group(group_mutated)), rt.func_array_keys(var_meta_data.clone())])
	mut iter_8 := var_missing_fields.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_missing_field := item_8.val
		mut var_value := rt.call_function('apply_filters', [rt.new_string("woocommerce_get_default_value_for_${var_missing_field.to_string()}"), rt.new_null(), rt.new_string(group_mutated).clone(), var_wc_object])
		if !(var_value).is_null() {
			var_meta_data.array_set(var_missing_field, var_value.clone())
		}
	}
	return var_meta_data.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) sync_customer_additional_fields_with_order(mut var_order Class_WC_Order, mut var_customer Class_WC_Customer) {
	mut var_customer_mutated := var_customer
	mut iter_9 := this.groups.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_group := item_9.val
		mut var_order_additional_fields := this.get_all_fields_from_object(mut var_order, (var_group).str(), true)
		mut iter_10 := var_order_additional_fields.iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_value := item_10.val
			mut var_key := item_10.key
			if rt.is_true(this.is_customer_field(var_key.clone())) {
				this.persist_field_for_customer((var_key).str(), var_value.clone(), mut var_customer_mutated, (var_group).str())
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) sync_order_additional_fields_with_customer(mut var_order Class_WC_Order, mut var_customer Class_WC_Customer) {
	mut var_customer_mutated := var_customer
	mut iter_11 := this.groups.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_group := item_11.val
		mut var_customer_additional_fields := this.get_all_fields_from_object(mut var_customer_mutated, (var_group).str(), true)
		mut iter_12 := var_customer_additional_fields.iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_value := item_12.val
			mut var_key := item_12.key
			if this.is_field(var_key.clone()) {
				this.persist_field_for_order((var_key).str(), var_value.clone(), mut var_order, (var_group).str(), false)
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) filter_fields_for_location(mut var_fields Class_Automattic_WooCommerce_Blocks_Domain_Services_array, location string) rt.PhpVal {
	mut var_fields_mutated := var_fields
	mut location_mutated := location
	location_mutated = (this.prepare_location_name(rt.new_string(location_mutated))).str()
	closure_17_fn := fn [var_location] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_key := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(this.get_field_location(var_key.clone()), rt.new_string(location_mutated))
		}
	return rt.call_function('array_filter', [var_fields_mutated, rt.new_closure(closure_17_fn), rt.get_constant('ARRAY_FILTER_USE_KEY')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) filter_fields_for_order_confirmation(var_fields rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_fields_mutated := var_fields
	closure_18_fn := fn [var_fields, var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_field := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('apply_filters', [rt.new_string('woocommerce_filter_fields_for_order_confirmation'), rt.new_bool(!(!rt.is_true(var_field.array_get(rt.new_string('show_in_order_confirmation'))))), var_field.clone(), var_fields_mutated.clone(), var_context.clone(), rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields', []string{}, &this)])
		}
	return rt.call_function('array_filter', [var_fields_mutated.clone(), rt.new_closure(closure_18_fn)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_order_additional_fields_with_values(mut var_order Class_WC_Order, location string, group string, context string) rt.PhpVal {
	mut location_mutated := location
	mut group_mutated := group
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('store-api'), var_order.get_created_via())))) {
		return rt.new_array()
	}
	location_mutated = (this.prepare_location_name(rt.new_string(location_mutated))).str()
	group_mutated = (this.prepare_group_name(rt.new_string(group_mutated))).str()
	mut var_fields := this.get_fields_for_location(rt.new_string(location_mutated))
	mut var_fields_with_values := rt.new_array()
	mut iter_13 := var_fields.iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_field := item_13.val
		mut var_field_key := item_13.key
		mut var_value := rt.new_string(this.get_field_from_object((var_field_key).str(), mut var_order, group_mutated))
		if rt.is_true(rt.identical(rt.new_string(''), var_value)) || rt.is_true(rt.identical(rt.new_null(), var_value)) {
			continue
		}
		if rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context))) {
		var_value = this.format_additional_field_value(var_value.clone(), var_field.clone())
		}
		var_field.array_set('value', var_value.clone())
		var_fields_with_values.array_set(var_field_key, var_field.clone())
	}
	return var_fields_with_values.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) format_additional_field_value(var_value rt.PhpVal, var_field rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_field_mutated := var_field
	if rt.is_true(rt.identical(rt.new_string('checkbox'), var_field_mutated.array_get(rt.new_string('type')))) {
	var_value_mutated = if rt.is_true(var_value_mutated) { rt.call_function('__', [rt.new_string('Yes'), rt.new_string('woocommerce')]) } else { rt.call_function('__', [rt.new_string('No'), rt.new_string('woocommerce')]) }
	}
	if rt.is_true(rt.identical(rt.new_string('select'), var_field_mutated.array_get(rt.new_string('type')))) {
	mut var_options := rt.call_function('array_column', [var_field_mutated.array_get(rt.new_string('options')), rt.new_string('label'), rt.new_string('value')])
	var_value_mutated = if var_options.array_isset(var_value_mutated) { var_options.array_get(var_value_mutated) } else { var_value_mutated }
	}
	return var_value_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) prepare_group_name(var_group rt.PhpVal) rt.PhpVal {
	mut var_group_mutated := var_group
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_group_mutated.clone(), this.groups, rt.new_bool(true)]))))) {
	var_group_mutated = rt.new_string('other')
	}
	return var_group_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) prepare_location_name(var_location rt.PhpVal) rt.PhpVal {
	mut var_location_mutated := var_location
	if rt.is_true(rt.identical(rt.new_string('additional'), var_location_mutated)) {
	var_location_mutated = rt.new_string('order')
	}
	return var_location_mutated.clone()
}

fn Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.get_group_key(var_group_name rt.PhpVal) rt.PhpVal {
	mut var_group_name_mutated := var_group_name
	if rt.is_true(rt.identical(rt.new_string('additional'), var_group_name_mutated)) {
		rt.call_function('wc_deprecated_argument', [rt.new_string('group_name'), rt.new_string('8.9.0'), rt.new_string('The "additional" group is deprecated. Use "other" instead.')])
	var_group_name_mutated = rt.new_string('other')
	}
	if rt.is_true(rt.identical(rt.new_string('billing'), var_group_name_mutated)) {
		return Class_Automattic_WooCommerce_Blocks_Domain_Services_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.billing_fields_prefix()
	}
	if rt.is_true(rt.identical(rt.new_string('shipping'), var_group_name_mutated)) {
		return Class_Automattic_WooCommerce_Blocks_Domain_Services_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.shipping_fields_prefix()
	}
	return Class_Automattic_WooCommerce_Blocks_Domain_Services_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.other_fields_prefix()
}

fn Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.get_group_name(var_group_key rt.PhpVal) string {
	mut var_group_key_mutated := var_group_key
	if rt.is_true(rt.identical(rt.new_string('_wc_additional'), var_group_key_mutated)) {
		rt.call_function('wc_deprecated_argument', [rt.new_string('group_key'), rt.new_string('8.9.0'), rt.new_string('The "_wc_additional" group key is deprecated. Use "_wc_other" instead.')])
	var_group_key_mutated = rt.new_string('_wc_other')
	}
	if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [Class_Automattic_WooCommerce_Blocks_Domain_Services_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.billing_fields_prefix(), var_group_key_mutated.clone()]))) {
		return 'billing'
	}
	if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [Class_Automattic_WooCommerce_Blocks_Domain_Services_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.shipping_fields_prefix(), var_group_key_mutated.clone()]))) {
		return 'shipping'
	}
	return 'other'
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_Validation {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	rt.PhpObjectBase
}

struct Class_WC_Customer {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_domain_services_checkoutfields(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields{
		PhpObjectBase: rt.PhpObjectBase{}
		additional_fields: rt.new_array()
		fields_locations: rt.new_null()
		supported_field_types: rt.new_array()
		groups: rt.new_array()
		asset_data_registry: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_domain_services_validation(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Services_Validation {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_Validation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_cartcheckoututils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_customer(_args ...rt.PhpVal) &Class_WC_Customer {
	mut obj := &Class_WC_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'add_fields_data' {
			this.add_fields_data()
			return rt.new_null()
		}
		'add_session_meta_keys' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_session_meta_keys(dispatch_arg_0)
		}
		'default_sanitize_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.default_sanitize_callback(dispatch_arg_0, dispatch_arg_1)
		}
		'default_validate_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.default_validate_callback(dispatch_arg_0, dispatch_arg_1)
		}
		'register_checkout_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.register_checkout_field(dispatch_arg_0)
			return rt.new_null()
		}
		'is_required_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.is_required_field(dispatch_arg_0, dispatch_arg_1))
		}
		'is_hidden_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.is_hidden_field(dispatch_arg_0, dispatch_arg_1))
		}
		'is_conditional_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_conditional_field(dispatch_arg_0))
		}
		'is_valid_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.is_valid_field(dispatch_arg_0, dispatch_arg_1))
		}
		'contains_valid_rules' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.contains_valid_rules(dispatch_arg_0))
		}
		'get_validate_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_validate_callback(dispatch_arg_0, dispatch_arg_1)
		}
		'deregister_checkout_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.deregister_checkout_field(dispatch_arg_0)
			return rt.new_null()
		}
		'validate_options' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_options(dispatch_arg_0))
		}
		'process_field_options' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.process_field_options(dispatch_arg_0, dispatch_arg_1)
		}
		'process_select_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.process_select_field(dispatch_arg_0, dispatch_arg_1))
		}
		'process_checkbox_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.process_checkbox_field(dispatch_arg_0, dispatch_arg_1)
		}
		'register_field_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.register_field_attributes(dispatch_arg_0, dispatch_arg_1)
		}
		'get_core_fields_keys' {
			return this.get_core_fields_keys()
		}
		'get_core_fields' {
			return this.get_core_fields()
		}
		'get_additional_fields' {
			return this.get_additional_fields()
		}
		'get_field_location' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_field_location(dispatch_arg_0))
		}
		'sanitize_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.sanitize_field(dispatch_arg_0, dispatch_arg_1)
		}
		'validate_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.validate_field(dispatch_arg_0, dispatch_arg_1)
		}
		'update_default_locale_with_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_default_locale_with_fields(dispatch_arg_0)
		}
		'get_address_fields_keys' {
			return this.get_address_fields_keys()
		}
		'get_contact_fields_keys' {
			return this.get_contact_fields_keys()
		}
		'get_additional_fields_keys' {
			return this.get_additional_fields_keys()
		}
		'get_order_fields_keys' {
			return this.get_order_fields_keys()
		}
		'get_fields_for_location' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_fields_for_location(dispatch_arg_0)
		}
		'get_contextual_fields_for_location' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_contextual_fields_for_location(dispatch_arg_0, dispatch_arg_1)
		}
		'validate_fields_for_location' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.validate_fields_for_location(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'validate_field_for_location' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.validate_field_for_location(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_fields_for_group' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_fields_for_group(dispatch_arg_0)
		}
		'is_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_field(dispatch_arg_0))
		}
		'is_customer_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_customer_field(dispatch_arg_0)
		}
		'persist_field_for_order' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WC_Order](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
			this.persist_field_for_order(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
			return rt.new_null()
		}
		'persist_field_for_customer' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WC_Customer](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			this.persist_field_for_customer(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'set_array_meta' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WC_Data](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			this.set_array_meta(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'get_field_from_object' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Data](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_string(this.get_field_from_object(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2))
		}
		'get_all_fields_from_object' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Data](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.get_all_fields_from_object(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'sync_customer_additional_fields_with_order' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Customer](if args.len > 1 { args[1] } else { rt.new_null() })
			this.sync_customer_additional_fields_with_order(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'sync_order_additional_fields_with_customer' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Customer](if args.len > 1 { args[1] } else { rt.new_null() })
			this.sync_order_additional_fields_with_customer(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'filter_fields_for_location' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Domain_Services_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.filter_fields_for_location(mut dispatch_arg_0, dispatch_arg_1)
		}
		'filter_fields_for_order_confirmation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.filter_fields_for_order_confirmation(dispatch_arg_0, dispatch_arg_1)
		}
		'get_order_additional_fields_with_values' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return this.get_order_additional_fields_with_values(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'format_additional_field_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.format_additional_field_value(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_group_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_group_name(dispatch_arg_0)
		}
		'prepare_location_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_location_name(dispatch_arg_0)
		}
		'get_group_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.get_group_key(dispatch_arg_0)
		}
		'get_group_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.get_group_name(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'additional_fields' { return this.additional_fields }
		'fields_locations' { return this.fields_locations }
		'supported_field_types' { return this.supported_field_types }
		'groups' { return this.groups }
		'asset_data_registry' { return this.asset_data_registry }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'additional_fields' { this.additional_fields = val; return true }
		'fields_locations' { this.fields_locations = val; return true }
		'supported_field_types' { this.supported_field_types = val; return true }
		'groups' { this.groups = val; return true }
		'asset_data_registry' { this.asset_data_registry = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_Validation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_Validation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_Validation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Customer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Customer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Customer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	// unsupported statement: Stmt_GroupUse
}
