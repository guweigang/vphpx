import rt

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend {
	rt.PhpObjectBase
pub mut:
	checkout_fields_controller rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend) construct(mut var_checkout_fields_controller Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) {
	this.checkout_fields_controller = var_checkout_fields_controller
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend) init() {
	rt.call_function('add_action', [
		rt.new_string('woocommerce_order_details_after_customer_address'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'render_order_address_fields' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_order_details_after_customer_details'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'render_order_other_fields' },
		]),
		rt.new_int(10),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_my_account_after_my_address'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'render_address_fields' },
		]),
		rt.new_int(10),
		rt.new_int(1),
	])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_edit_account_form_fields'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'edit_account_form_fields' },
		]),
		rt.new_int(10),
		rt.new_int(1),
	])
	rt.call_function('add_action', [rt.new_string('woocommerce_save_account_details'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'save_account_form_fields' },
		]),
		rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_address_to_edit'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'edit_address_fields' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_customer_save_address'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'save_address_fields' },
		]),
		rt.new_int(10), rt.new_int(4)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend) render_additional_fields(var_fields rt.PhpVal) string {
	mut var_fields_mutated := var_fields
	return if !(!rt.is_true(var_fields_mutated)) {
		'<dl class="wc-block-components-additional-fields-list">' +
			(rt.call_function('implode', [rt.new_string(''), rt.call_function('array_map', [rt.create_array([rt.ArrayItem{
			key: none
			val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend', []string{}, &this)
		}, rt.ArrayItem{ key: none, val: 'render_additional_field' }]), var_fields_mutated.clone()])])).str() +
			'</dl>'
	} else {
		''
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend) render_additional_field(var_field rt.PhpVal) rt.PhpVal {
	return rt.call_function('sprintf', [rt.new_string('<dt>%1$s</dt><dd>%2$s</dd>'),
		rt.call_function('esc_html', [var_field.array_get(rt.new_string('label'))]),
		rt.call_function('esc_html', [var_field.array_get(rt.new_string('value'))])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend) render_order_address_fields(var_address_type rt.PhpVal, var_order rt.PhpVal) {
	print(this.render_additional_fields(rt.call_method(this.checkout_fields_controller,
		'get_order_additional_fields_with_values', [var_order.clone(),
		rt.new_string('address'), var_address_type.clone(), rt.new_string('view')])))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend) render_order_other_fields(var_order rt.PhpVal) {
	mut var_fields := rt.call_function('array_merge', [
		rt.call_method(this.checkout_fields_controller, 'get_order_additional_fields_with_values', [
			var_order.clone(),
			rt.new_string('contact'),
			rt.new_string('other'),
			rt.new_string('view'),
		]),
		rt.call_method(this.checkout_fields_controller, 'get_order_additional_fields_with_values', [
			var_order.clone(),
			rt.new_string('order'),
			rt.new_string('other'),
			rt.new_string('view'),
		]),
	])
	mut var_context := rt.create_array([
		rt.ArrayItem{ key: 'caller', val: 'CheckoutFieldsFrontend::render_order_other_fields' },
		rt.ArrayItem{ key: 'order', val: var_order },
	])
	var_fields = rt.call_method(this.checkout_fields_controller,
		'filter_fields_for_order_confirmation', [var_fields.clone(),
		var_context.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_fields)))) {
		return
	}
	print('<section class="wc-block-order-confirmation-additional-fields-wrapper">')
	print('<h2>' +
		(rt.call_function('esc_html__', [rt.new_string('Additional information'), rt.new_string('woocommerce')])).str() +
		'</h2>')
	print(this.render_additional_fields(var_fields.clone()))
	print('</section>')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend) render_address_fields(var_address_type rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_address_type.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'billing' },
			rt.ArrayItem{ key: none, val: 'shipping' },
		]),
		rt.new_bool(true)])))))
	{
		return
	}
	mut var_customer := create_wc_customer(rt.call_function('get_current_user_id', []rt.PhpVal{}))
	mut var_document_object :=
		create_automattic_woocommerce_blocks_domain_services_checkoutfieldsschema_documentobject()
	var_document_object.set_customer(var_customer.clone())
	var_document_object.set_context(rt.new_string(var_address_type.str() + '_address'))
	mut var_fields := rt.call_method(this.checkout_fields_controller,
		'get_contextual_fields_for_location', [rt.new_string('address'), var_document_object])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_fields))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_customer)))) {
		return
	}
	mut iter_1 := var_fields.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_field := item_1.val
		mut var_key := item_1.key
		mut var_value := rt.call_method(this.checkout_fields_controller,
			'format_additional_field_value', [
			rt.call_method(this.checkout_fields_controller, 'get_field_from_object', [
				var_key.clone(),
				var_customer.clone(),
				var_address_type.clone(),
			]),
			var_field.clone(),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_value)))) {
			continue
		}
		rt.call_function('printf', [rt.new_string('<br><strong>%s</strong>: %s'),
			rt.call_function('wp_kses_post', [var_field.array_get(rt.new_string('label'))]),
			rt.call_function('wp_kses_post', [var_value.clone()])])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend) edit_account_form_fields() {
	mut var_customer := create_wc_customer(rt.call_function('get_current_user_id', []rt.PhpVal{}))
	mut var_document_object :=
		create_automattic_woocommerce_blocks_domain_services_checkoutfieldsschema_documentobject()
	var_document_object.set_customer(var_customer.clone())
	var_document_object.set_context(rt.new_string('contact'))
	mut var_fields := rt.call_method(this.checkout_fields_controller,
		'get_contextual_fields_for_location', [rt.new_string('contact'), var_document_object])
	mut iter_2 := var_fields.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_field := item_2.val
		mut var_key := item_2.key
		mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields{}
		mut iife_result_0 := iife_temp_0.get_group_key(rt.new_string('other'))
		mut var_field_key := rt.new_string(iife_result_0.str() + var_key.str())
		mut var_form_field := var_field
		var_form_field.array_set('id', var_field_key.clone())
		var_form_field.array_set('value', rt.call_method(this.checkout_fields_controller,
			'get_field_from_object', [var_key.clone(), var_customer.clone(),
			rt.new_string('contact')]))
		if rt.is_true(rt.identical(rt.new_string('select'),
			var_field.array_get(rt.new_string('type'))))
		{
			var_form_field.array_set('options', rt.call_function('array_column', [
				var_field.array_get(rt.new_string('options')),
				rt.new_string('label'),
				rt.new_string('value'),
			]))
		}
		if rt.is_true(rt.identical(rt.new_string('checkbox'),
			var_field.array_get(rt.new_string('type'))))
		{
			var_form_field.array_set('checked_value', '1')
			var_form_field.array_set('unchecked_value', '0')
		}
		rt.call_function('woocommerce_form_field', [var_field_key.clone(),
			var_form_field.clone(),
			rt.call_function('wc_get_post_data_by_key', [
				var_key.clone(),
				var_form_field.array_get(rt.new_string('value')),
			])])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend) edit_address_fields(var_address rt.PhpVal, var_address_type rt.PhpVal) rt.PhpVal {
	mut var_address_mutated := var_address
	mut var_customer := create_wc_customer(rt.call_function('get_current_user_id', []rt.PhpVal{}))
	mut var_document_object :=
		create_automattic_woocommerce_blocks_domain_services_checkoutfieldsschema_documentobject()
	var_document_object.set_customer(var_customer.clone())
	var_document_object.set_context(rt.new_string(var_address_type.str() + '_address'))
	mut var_fields := rt.call_method(this.checkout_fields_controller,
		'get_contextual_fields_for_location', [rt.new_string('address'), var_document_object])
	mut iter_3 := var_fields.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_field := item_3.val
		mut var_key := item_3.key
		mut iife_temp_1 := Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields{}
		mut iife_result_1 := iife_temp_1.get_group_key(var_address_type.clone())
		mut var_field_key := rt.new_string(iife_result_1.str() + var_key.str())
		var_address_mutated.array_set(var_field_key, var_field.clone())
		var_address_mutated.array_get_mut(var_field_key).array_set('value', rt.call_method(this.checkout_fields_controller,
			'get_field_from_object', [var_key.clone(), var_customer.clone(),
			var_address_type.clone()]))
		if rt.is_true(rt.identical(rt.new_string('select'),
			var_field.array_get(rt.new_string('type'))))
		{
			var_address_mutated.array_get_mut(var_field_key).array_set('options', rt.call_function('array_column', [
				var_field.array_get(rt.new_string('options')),
				rt.new_string('label'),
				rt.new_string('value'),
			]))
			if !(!rt.is_true(var_address_mutated.array_get(var_field_key).array_get(rt.new_string('placeholder'))))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_address_mutated.array_get(var_field_key).array_get(rt.new_string('options')).array_isset(rt.new_string(''))))))) {
				var_address_mutated.array_get_mut(var_field_key).array_set('options', rt.add(rt.create_array([
					rt.ArrayItem{
						key: ''
						val: var_address_mutated.array_get(var_field_key).array_get(rt.new_string('placeholder'))
					},
				]),
					var_address_mutated.array_get(var_field_key).array_get(rt.new_string('options'))))
			}
		}
		if rt.is_true(rt.identical(rt.new_string('checkbox'),
			var_field.array_get(rt.new_string('type'))))
		{
			var_address_mutated.array_get_mut(var_field_key).array_set('checked_value', '1')
			var_address_mutated.array_get_mut(var_field_key).array_set('unchecked_value', '0')
		}
	}
	return var_address_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend) save_account_form_fields(var_user_id rt.PhpVal) {
	mut var_customer := create_wc_customer(var_user_id.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_result := this.update_additional_fields_for_customer(var_customer.clone(),
		rt.new_string('contact'), rt.new_string('other'))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		mut iter_4 := rt.call_method(var_result, 'get_error_messages', []rt.PhpVal{}).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_error_message := item_4.val
			rt.call_function('wc_add_notice', [var_error_message.clone(),
				rt.new_string('error')])
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_method(var_customer, 'save', []rt.PhpVal{})
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
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Blocks_Domain_Services_Exception') {
		mut var_e := var_e_1.clone()
		rt.call_function('wc_add_notice', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('An error occurred while saving account details: %s'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_html', [
					rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
				]),
			]),
			rt.new_string('error'),
		])
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
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend) save_address_fields(var_user_id rt.PhpVal, var_address_type rt.PhpVal, var_address rt.PhpVal, var_customer rt.PhpVal) {
	mut var_address_mutated := var_address
	mut var_customer_mutated := var_customer
	var_customer_mutated = if !var_customer_mutated.is_null() {
		var_customer_mutated
	} else {
		create_wc_customer(var_user_id.clone())
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	mut var_result := this.update_additional_fields_for_customer(var_customer_mutated.clone(),
		rt.new_string('address'), var_address_type.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		mut iter_5 := rt.call_method(var_result, 'get_error_messages', []rt.PhpVal{}).iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_error_message := item_5.val
			rt.call_function('wc_add_notice', [var_error_message.clone(),
				rt.new_string('error')])
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	rt.call_method(var_customer_mutated, 'save', []rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Blocks_Domain_Services_Exception') {
		mut var_e := var_e_2.clone()
		rt.call_function('wc_add_notice', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('An error occurred while saving address details: %s'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_html', [
					rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
				]),
			]),
			rt.new_string('error'),
		])
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
	}

	end_label_2:
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend) get_posted_additional_field_values(var_location rt.PhpVal, var_group rt.PhpVal, sanitize bool) rt.PhpVal {
	mut var_additional_fields := rt.call_method(this.checkout_fields_controller,
		'get_fields_for_location', [var_location.clone()])
	mut var_field_values := rt.new_array()
	mut iter_6 := var_additional_fields.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_field_data := item_6.val
		mut var_field_key := item_6.key
		mut iife_temp_2 := Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields{}
		mut iife_result_2 := iife_temp_2.get_group_key(var_group.clone())
		mut var_post_key := rt.new_string(iife_result_2.str() + var_field_key.str())
		var_field_values.array_set(var_field_key, rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [if !(rt.get_superglobal('_POST').array_get(var_post_key)).is_null() {
				rt.get_superglobal('_POST').array_get(var_post_key)
			} else {
				rt.new_string('')
			}]),
		]))
		if var_sanitize {
			var_field_values.array_set(var_field_key, rt.call_method(this.checkout_fields_controller,
				'sanitize_field',
				[var_field_key.clone(), var_field_values.array_get(var_field_key)]))
		}
	}
	return var_field_values.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend) update_additional_fields_for_customer(var_customer rt.PhpVal, var_location rt.PhpVal, var_group rt.PhpVal) rt.PhpVal {
	mut var_customer_mutated := var_customer
	mut var_field_values := this.get_posted_additional_field_values(var_location.clone(),
		var_group.clone(), false)
	mut var_sanitized_field_values := this.get_posted_additional_field_values(var_location.clone(),
		var_group.clone(), false)
	mut var_document_object := create_automattic_woocommerce_blocks_domain_services_checkoutfieldsschema_documentobject(rt.create_array([
		rt.ArrayItem{ key: 'customer', val: rt.create_array([
			rt.ArrayItem{
				key: if rt.is_true(rt.identical(rt.new_string('address'), var_location)) {
					var_group.str() + '_address'
				} else {
					'additional_fields'
				}
				val: var_sanitized_field_values
			},
		]) },
	]))
	var_document_object.set_customer(var_customer_mutated.clone())
	var_document_object.set_context(if rt.is_true(rt.identical(rt.new_string('address'),
		var_location))
	{
		var_group.str() + '_address'
	} else {
		var_location
	})
	mut var_fields := rt.call_method(this.checkout_fields_controller,
		'get_contextual_fields_for_location', [var_location.clone(), var_document_object])
	mut var_persist_fields := rt.new_array()
	mut var_errors := create_automattic_woocommerce_blocks_domain_services_wp_error()
	mut iter_7 := var_fields.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_field := item_7.val
		mut var_field_key := item_7.key
		mut var_field_value := var_field_values.array_get(var_field_key)
		if !rt.is_true(var_field_value) {
			if rt.is_true(rt.identical(rt.new_bool(true),
				var_field.array_get(rt.new_string('required'))))
			{
				var_errors.add(rt.new_string('required_field'), rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('%s is required'),
						rt.new_string('woocommerce')]),
					rt.new_string('<strong>' +
						(var_field.array_get(rt.new_string('label'))).str() + '</strong>'),
				]))
				continue
			}
			var_persist_fields.array_set(var_field_key, '')
			continue
		}
		mut var_sanitized_field_value := var_sanitized_field_values.array_get(var_field_key)
		mut var_valid_check := rt.call_method(this.checkout_fields_controller, 'validate_field', [
			var_field.clone(),
			var_sanitized_field_value.clone(),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_valid_check.clone()]))
			&& rt.is_true(rt.call_method(var_valid_check, 'has_errors', []rt.PhpVal{})) {
			var_errors.add(rt.call_method(var_valid_check, 'get_error_code', []rt.PhpVal{}), rt.call_method(var_valid_check,
				'get_error_message', []rt.PhpVal{}))
			continue
		}
		var_persist_fields.array_set(var_field_key, var_sanitized_field_value.clone())
	}
	mut var_location_validation := rt.call_method(this.checkout_fields_controller,
		'validate_fields_for_location', [var_sanitized_field_values.clone(),
		var_location.clone(), var_group.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_location_validation.clone()]))
		&& rt.is_true(rt.call_method(var_location_validation, 'has_errors', []rt.PhpVal{})) {
		var_errors.merge_from(var_location_validation.clone())
		return mut var_errors
	}
	mut iter_8 := var_persist_fields.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_field_value := item_8.val
		mut var_field_key := item_8.key
		rt.call_method(this.checkout_fields_controller, 'persist_field_for_customer', [
			var_field_key.clone(),
			var_field_value.clone(),
			var_customer_mutated.clone(),
			var_group.clone(),
		])
	}
	return mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Domain_Services_WP_Error](if rt.is_true(var_errors.has_errors()) {
		var_errors
	} else {
		rt.new_bool(true)
	})
}

struct Class_WC_Customer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_DocumentObject {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_domain_services_checkoutfieldsfrontend(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend{
		PhpObjectBase:              rt.PhpObjectBase{}
		checkout_fields_controller: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wc_customer(_args ...rt.PhpVal) &Class_WC_Customer {
	mut obj := &Class_WC_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_domain_services_checkoutfieldsschema_documentobject(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_DocumentObject {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_DocumentObject{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_domain_services_checkoutfields(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_domain_services_wp_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Services_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'render_additional_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.render_additional_fields(dispatch_arg_0))
		}
		'render_additional_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.render_additional_field(dispatch_arg_0)
		}
		'render_order_address_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.render_order_address_fields(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'render_order_other_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.render_order_other_fields(dispatch_arg_0)
			return rt.new_null()
		}
		'render_address_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.render_address_fields(dispatch_arg_0)
			return rt.new_null()
		}
		'edit_account_form_fields' {
			this.edit_account_form_fields()
			return rt.new_null()
		}
		'edit_address_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.edit_address_fields(dispatch_arg_0, dispatch_arg_1)
		}
		'save_account_form_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.save_account_form_fields(dispatch_arg_0)
			return rt.new_null()
		}
		'save_address_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.save_address_fields(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'get_posted_additional_field_values' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.get_posted_additional_field_values(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'update_additional_fields_for_customer' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.update_additional_fields_for_customer(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'checkout_fields_controller' { return this.checkout_fields_controller }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsFrontend) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'checkout_fields_controller' {
			this.checkout_fields_controller = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_DocumentObject) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_DocumentObject) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_DocumentObject) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
