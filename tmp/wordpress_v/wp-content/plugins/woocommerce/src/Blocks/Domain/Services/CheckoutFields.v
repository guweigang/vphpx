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

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) construct(mut var_asset_data_registry Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry)  {
	this.asset_data_registry = var_asset_data_registry.dup()
	this.fields_locations = rt.create_array([rt.ArrayItem{ key: 'address', val: rt.call_function('array_merge', [rt.call_function('array_diff_key', [this.get_core_fields_keys(), rt.create_array([rt.ArrayItem{ key: none, val: 'email' }])])]) }, rt.ArrayItem{ key: 'contact', val: rt.create_array([rt.ArrayItem{ key: none, val: 'email' }]) }, rt.ArrayItem{ key: 'order', val: rt.new_array() }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) init()  {
	rt.call_function('add_filter', [rt.new_string('woocommerce_get_country_locale_default'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'update_default_locale_with_fields' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_blocks_checkout_enqueue_data'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_fields_data' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_blocks_cart_enqueue_data'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_fields_data' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_customer_allowed_session_meta_keys'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_session_meta_keys' }])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) add_fields_data()  {
	rt.call_method(this.asset_data_registry, 'add', [rt.new_string('defaultFields'), rt.call_function('array_merge', [this.get_core_fields(), this.get_additional_fields()])])
	rt.call_method(this.asset_data_registry, 'add', [rt.new_string('addressFieldsLocations'), this.fields_locations])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) add_session_meta_keys(var_keys rt.PhpVal) rt.PhpVal {
	mut var_meta_keys := rt.new_array()
	{
		mut iter_1 := this.get_additional_fields().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			mut var_field_key := item_1.key
			if rt.is_true(rt.identical(rt.new_string('address'), var_field.array_get('location'))) {
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
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Blocks_Domain_Services_Throwable') {
		mut var_e := var_e_1.dup()
		rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('Error adding session meta keys for checkout fields. %s'), rt.call_function('esc_attr', [rt.call_method(var_e, 'getMessage', []rt.PhpVal{})])]), rt.get_constant('E_USER_WARNING')])
		return var_keys.dup()
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.call_function('array_merge', [var_keys.dup(), var_meta_keys.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) default_sanitize_callback(var_value rt.PhpVal, var_field rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_field_mutated := var_field
	return var_value_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) default_validate_callback(var_value rt.PhpVal, var_field rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_field_mutated := var_field
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(true), var_field_mutated.array_get('required'))) && !rt.is_true(var_value_mutated))) {
		return create_wp_error(rt.new_string('woocommerce_required_checkout_field'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The field %s is required.'), rt.new_string('woocommerce')]), var_field_mutated.array_get('id')]))
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) register_checkout_field(var_options rt.PhpVal)  {
	mut var_options_mutated := var_options
	if rt.is_true(rt.identical(rt.new_bool(false), this.validate_options(var_options_mutated.dup()))) {
		return rt.new_null()
	}
	mut var_field_data := rt.call_function('wp_parse_args', [var_options_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'id', val: '' }, rt.ArrayItem{ key: 'label', val: '' }, rt.ArrayItem{ key: 'optionalLabel', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s (optional)'), rt.new_string('woocommerce')]), var_options_mutated.array_get('label')]) }, rt.ArrayItem{ key: 'location', val: '' }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'hidden', val: false }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'attributes', val: rt.new_array() }, rt.ArrayItem{ key: 'show_in_order_confirmation', val: true }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'default_sanitize_callback' }]) }, rt.ArrayItem{ key: 'validate_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'default_validate_callback' }]) }, rt.ArrayItem{ key: 'validation', val: rt.new_array() }])])
	var_field_data.array_set('attributes', this.register_field_attributes(var_field_data.array_get('id'), var_field_data.array_get('attributes')))
	var_field_data = this.process_field_options(var_field_data.dup(), var_options_mutated.dup())
	if rt.is_true(rt.identical(rt.new_bool(false), var_field_data)) {
		return rt.new_null()
	}
	this.additional_fields.array_set(var_field_data.array_get('id'), var_field_data.dup())
	this.fields_locations.array_get_mut(var_field_data.array_get('location')).array_push(var_field_data.array_get('id'))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) is_required_field(var_field rt.PhpVal, var_document_object rt.PhpVal) bool {
	mut var_field_mutated := var_field
	if rt.is_true(rt.new_bool(var_field_mutated.dup().is_string())) {
		var_field_mutated = if !(this.additional_fields.array_get(var_field_mutated)).is_null() { this.additional_fields.array_get(var_field_mutated) } else { rt.new_array() }
	}
	if !rt.is_true(var_field_mutated) {
		return false
	}
	if rt.is_true(var_document_object) {
		if this.is_hidden_field(var_field_mutated.dup(), var_document_object.dup()) {
			return false
		}
		if this.contains_valid_rules(var_field_mutated.array_get('required')) {
			return (rt.identical(rt.new_bool(true), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Domain_Services_Validation{}; return temp.validate_document_object(arg_0, arg_1) }(var_document_object.dup(), var_field_mutated.array_get('required')))).to_bool()
		}
	}
	return (rt.identical(rt.new_bool(true), var_field_mutated.array_get('required'))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) is_hidden_field(var_field rt.PhpVal, var_document_object rt.PhpVal) bool {
	mut var_field_mutated := var_field
	if rt.is_true(rt.new_bool(var_field_mutated.dup().is_string())) {
		var_field_mutated = if !(this.additional_fields.array_get(var_field_mutated)).is_null() { this.additional_fields.array_get(var_field_mutated) } else { rt.new_array() }
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_document_object) && this.contains_valid_rules(var_field_mutated.array_get('hidden')))) {
		return (rt.identical(rt.new_bool(true), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Domain_Services_Validation{}; return temp.validate_document_object(arg_0, arg_1) }(var_document_object.dup(), var_field_mutated.array_get('hidden')))).to_bool()
	}
	return false
	// unsupported statement: Stmt_Nop
	return false
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) is_conditional_field(var_field rt.PhpVal) bool {
	mut var_field_mutated := var_field
	if rt.is_true(rt.new_bool(var_field_mutated.dup().is_string())) {
		var_field_mutated = if !(this.additional_fields.array_get(var_field_mutated)).is_null() { this.additional_fields.array_get(var_field_mutated) } else { rt.new_array() }
	}
	return this.contains_valid_rules(var_field_mutated.array_get('required')) || this.contains_valid_rules(var_field_mutated.array_get('hidden'))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) is_valid_field(var_field rt.PhpVal, var_document_object rt.PhpVal) bool {
	mut var_field_mutated := var_field
	if rt.is_true(rt.new_bool(rt.is_true(var_document_object) && this.contains_valid_rules(var_field_mutated.array_get('validation')))) {
		mut var_field_schema := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Domain_Services_Validation{}; return temp.get_field_schema_with_context(arg_0, arg_1, arg_2) }(var_field_mutated.array_get('id'), var_field_mutated.array_get('validation'), rt.call_method(var_document_object, 'get_context', []rt.PhpVal{}))
		return (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Domain_Services_Validation{}; return temp.validate_document_object(arg_0, arg_1) }(var_document_object.dup(), var_field_schema.dup())).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) contains_valid_rules(var_property rt.PhpVal) bool {
	return rt.is_true(rt.new_bool(var_property.dup().is_array())) && !(!rt.is_true(var_property))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_validate_callback(var_field rt.PhpVal, var_document_object rt.PhpVal) rt.PhpVal {
	mut var_field_mutated := var_field
	if rt.is_true(rt.new_bool(var_field_mutated.dup().is_string())) {
		var_field_mutated = if !(this.additional_fields.array_get(var_field_mutated)).is_null() { this.additional_fields.array_get(var_field_mutated) } else { rt.new_array() }
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_document_object) && this.contains_valid_rules(var_field_mutated.array_get('validation')))) {
		closure_1_fn := fn [var_document_object] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_field_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_field := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	mut var_errors := create_wp_error()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_field_mutated)))) {
		return rt.new_bool(true)
	}
	mut var_validate_result := rt.new_bool(this.is_valid_field(var_field_mutated.dup(), var_document_object.dup()))
	if rt.is_true(rt.call_function('is_wp_error', [var_validate_result.dup()])) {
		mut var_error_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Please provide a valid %s'), rt.new_string('woocommerce')]), var_field_mutated.array_get('label')])
		mut var_error_code := rt.new_string(rt.new_string('woocommerce_invalid_checkout_field'))
		var_errors.add(var_error_code.dup(), var_error_message.dup())
	}
	return if rt.is_true(var_errors.has_errors()) { var_errors } else { rt.new_bool(true) }
	}
		return rt.new_closure(closure_1_fn)
	}
	return if !(var_field_mutated.array_get('validate_callback')).is_null() { var_field_mutated.array_get('validate_callback') } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) deregister_checkout_field(var_field_id rt.PhpVal)  {
	if !rt.is_true(this.additional_fields.array_get(var_field_id)) {
		return rt.new_null()
	}
	mut var_location := rt.new_string(this.get_field_location(var_field_id.dup()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_location)))) {
		return rt.new_null()
	}
	this.fields_locations.array_set(var_location, rt.call_function('array_diff', [this.fields_locations.array_get(var_location), rt.create_array([rt.ArrayItem{ key: none, val: var_field_id }])]))
	this.additional_fields.array_unset(var_field_id)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) validate_options(var_options rt.PhpVal) bool {
	mut var_options_mutated := var_options
	if !rt.is_true(var_options_mutated.array_get('id')) {
		rt.call_function('_doing_it_wrong', [rt.new_string('woocommerce_register_additional_checkout_field'), rt.new_string('A checkout field cannot be registered without an id.'), rt.new_string('8.6.0')])
		return false
	}
	if rt.call_function('explode', [rt.new_string('/'), var_options_mutated.array_get('id')]).array_count() < 2 {
		mut var_message := rt.call_function('sprintf', [rt.new_string('Unable to register field with id: "%s". %s'), var_options_mutated.array_get('id'), rt.new_string('A checkout field id must consist of namespace/name.')])
		rt.call_function('_doing_it_wrong', [rt.new_string('woocommerce_register_additional_checkout_field'), rt.call_function('esc_html', [var_message.dup()]), rt.new_string('8.6.0')])
		return false
	}
	if !rt.is_true(var_options_mutated.array_get('label')) {
		var_message = rt.call_function('sprintf', [rt.new_string('Unable to register field with id: "%s". %s'), var_options_mutated.array_get('id'), rt.new_string('The field label is required.')])
		rt.call_function('_doing_it_wrong', [rt.new_string('woocommerce_register_additional_checkout_field'), rt.call_function('esc_html', [var_message.dup()]), rt.new_string('8.6.0')])
		return false
	}
	if !rt.is_true(var_options_mutated.array_get('location')) {
		var_message = rt.call_function('sprintf', [rt.new_string('Unable to register field with id: "%s". %s'), var_options_mutated.array_get('id'), rt.new_string('The field location is required.')])
		rt.call_function('_doing_it_wrong', [rt.new_string('woocommerce_register_additional_checkout_field'), rt.call_function('esc_html', [var_message.dup()]), rt.new_string('8.6.0')])
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('additional'), var_options_mutated.array_get('location'))) {
		rt.call_function('wc_deprecated_argument', [rt.new_string('location'), rt.new_string('8.9.0'), rt.new_string('The "additional" location is deprecated. Use "order" instead.')])
		var_options_mutated.array_set('location', 'order')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_options_mutated.array_get('location'), rt.func_array_keys(this.fields_locations), rt.new_bool(true)]))))) {
		var_message = rt.call_function('sprintf', [rt.new_string('Unable to register field with id: "%s". %s'), var_options_mutated.array_get('id'), rt.new_string('The field location is invalid.')])
		rt.call_function('_doing_it_wrong', [rt.new_string('woocommerce_register_additional_checkout_field'), rt.call_function('esc_html', [var_message.dup()]), rt.new_string('8.6.0')])
		return false
	}
	mut var_location := var_options_mutated.array_get('location')
	mut var_id := var_options_mutated.array_get('id')
	if rt.is_true(rt.new_bool(!(!rt.is_true(this.additional_fields.array_get(var_id))) || rt.is_true(rt.call_function('in_array', [var_id.dup(), this.fields_locations.array_get(var_location), rt.new_bool(true)])))) {
		var_message = rt.call_function('sprintf', [rt.new_string('Unable to register field with id: "%s". %s'), var_id.dup(), rt.new_string('The field is already registered.')])
		rt.call_function('_doing_it_wrong', [rt.new_string('woocommerce_register_additional_checkout_field'), rt.call_function('esc_html', [var_message.dup()]), rt.new_string('8.6.0')])
		return false
	}
	if !(!rt.is_true(var_options_mutated.array_get('type'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_options_mutated.array_get('type'), this.supported_field_types, rt.new_bool(true)]))))) {
			var_message = rt.call_function('sprintf', [rt.new_string('Unable to register field with id: "%s". Registering a field with type "%s" is not supported. The supported types are: %s.'), var_id.dup(), var_options_mutated.array_get('type'), rt.call_function('implode', [rt.new_string(', '), this.supported_field_types])])
			rt.call_function('_doing_it_wrong', [rt.new_string('woocommerce_register_additional_checkout_field'), rt.call_function('esc_html', [var_message.dup()]), rt.new_string('8.6.0')])
			return false
		}
	}
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_options_mutated.array_get('sanitize_callback'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [var_options_mutated.array_get('sanitize_callback')]))))))) {
		var_message = rt.call_function('sprintf', [rt.new_string('Unable to register field with id: "%s". %s'), var_id.dup(), rt.new_string('The sanitize_callback must be a valid callback.')])
		rt.call_function('_doing_it_wrong', [rt.new_string('woocommerce_register_additional_checkout_field'), rt.call_function('esc_html', [var_message.dup()]), rt.new_string('8.6.0')])
		return false
	}
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_options_mutated.array_get('validate_callback'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [var_options_mutated.array_get('validate_callback')]))))))) {
		var_message = rt.call_function('sprintf', [rt.new_string('Unable to register field with id: "%s". %s'), var_id.dup(), rt.new_string('The validate_callback must be a valid callback.')])
		rt.call_function('_doing_it_wrong', [rt.new_string('woocommerce_register_additional_checkout_field'), rt.call_function('esc_html', [var_message.dup()]), rt.new_string('8.6.0')])
		return false
	}
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_options_mutated.array_get('hidden'))) && rt.is_true(rt.identical(rt.new_bool(true), .array_get())))) {
		var_message = rt.call_function('sprintf', [, .dup()])
		rt.call_function('_doing_it_wrong', [, , ])
		// unsupported statement: Stmt_Nop
	}
	
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) process_field_options(var_field_data rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_field_data_mutated := var_field_data
	mut var_options_mutated := var_options
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) process_select_field(var_field_data rt.PhpVal, var_options rt.PhpVal) bool {
	mut var_field_data_mutated := var_field_data
	mut var_options_mutated := var_options
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) process_checkbox_field(var_field_data rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_field_data_mutated := var_field_data
	mut var_options_mutated := var_options
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) register_field_attributes(var_id rt.PhpVal, var_attributes rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_core_fields_keys() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_core_fields() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_additional_fields() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_field_location(var_field_key rt.PhpVal) string {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) sanitize_field(var_field_key rt.PhpVal, var_field_value rt.PhpVal) rt.PhpVal {
	mut var_field_value_mutated := var_field_value
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) validate_field(var_field rt.PhpVal, var_field_value rt.PhpVal) rt.PhpVal {
	mut var_field_mutated := var_field
	mut var_field_value_mutated := var_field_value
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) update_default_locale_with_fields(var_locale rt.PhpVal) rt.PhpVal {
	mut var_locale_mutated := var_locale
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_address_fields_keys() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_contact_fields_keys() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_additional_fields_keys() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_order_fields_keys() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_fields_for_location(var_location rt.PhpVal) rt.PhpVal {
	mut var_location_mutated := var_location
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_contextual_fields_for_location(var_location rt.PhpVal, var_document_object rt.PhpVal) rt.PhpVal {
	mut var_location_mutated := var_location
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) validate_fields_for_location(var_fields rt.PhpVal, var_location rt.PhpVal, group string) rt.PhpVal {
	mut var_fields_mutated := var_fields
	mut var_location_mutated := var_location
	mut group_mutated := group
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) validate_field_for_location(var_key rt.PhpVal, var_value rt.PhpVal, var_location rt.PhpVal) bool {
	mut var_key_mutated := var_key
	mut var_value_mutated := var_value
	mut var_location_mutated := var_location
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_fields_for_group(group string) rt.PhpVal {
	mut group_mutated := group
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) is_field(var_key rt.PhpVal) bool {
	mut var_key_mutated := var_key
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) is_customer_field(var_key rt.PhpVal) rt.PhpVal {
	mut var_key_mutated := var_key
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) persist_field_for_order(key string, var_value rt.PhpVal, mut var_order Class_WC_Order, group string, set_customer bool)  {
	mut key_mutated := key
	mut var_value_mutated := var_value
	mut group_mutated := group
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) persist_field_for_customer(key string, var_value rt.PhpVal, mut var_customer Class_WC_Customer, group string)  {
	mut key_mutated := key
	mut var_value_mutated := var_value
	mut var_customer_mutated := var_customer
	mut group_mutated := group
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) set_array_meta(key string, var_value rt.PhpVal, mut var_wc_object Class_WC_Data, group string)  {
	mut key_mutated := key
	mut var_value_mutated := var_value
	mut group_mutated := group
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_field_from_object(key string, mut var_wc_object Class_WC_Data, group string) string {
	mut key_mutated := key
	mut group_mutated := group
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_all_fields_from_object(mut var_wc_object Class_WC_Data, group string, all bool) rt.PhpVal {
	mut group_mutated := group
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) sync_customer_additional_fields_with_order(mut var_order Class_WC_Order, mut var_customer Class_WC_Customer)  {
	mut var_customer_mutated := var_customer
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) sync_order_additional_fields_with_customer(mut var_order Class_WC_Order, mut var_customer Class_WC_Customer)  {
	mut var_customer_mutated := var_customer
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) filter_fields_for_location(mut var_fields Class_Automattic_WooCommerce_Blocks_Domain_Services_array, location string) rt.PhpVal {
	mut var_fields_mutated := var_fields
	mut location_mutated := location
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) filter_fields_for_order_confirmation(var_fields rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_fields_mutated := var_fields
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) get_order_additional_fields_with_values(mut var_order Class_WC_Order, location string, group string, context string) rt.PhpVal {
	mut location_mutated := location
	mut group_mutated := group
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) format_additional_field_value(var_value rt.PhpVal, var_field rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_field_mutated := var_field
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) prepare_group_name(var_group rt.PhpVal) rt.PhpVal {
	mut var_group_mutated := var_group
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) prepare_location_name(var_location rt.PhpVal) rt.PhpVal {
	mut var_location_mutated := var_location
}

fn Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.get_group_key(var_group_name rt.PhpVal) rt.PhpVal {
	mut var_group_name_mutated := var_group_name
}

fn Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.get_group_name(var_group_key rt.PhpVal) string {
	mut var_group_key_mutated := var_group_key
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_Validation {
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

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_domain_services_validation() &Class_Automattic_WooCommerce_Blocks_Domain_Services_Validation {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_Validation{
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




pub fn init_wp_content_plugins_woocommerce_src_blocks_domain_services_checkoutfields_php() {
	// unsupported statement: Stmt_Declare
	// unsupported statement: Stmt_GroupUse
}
