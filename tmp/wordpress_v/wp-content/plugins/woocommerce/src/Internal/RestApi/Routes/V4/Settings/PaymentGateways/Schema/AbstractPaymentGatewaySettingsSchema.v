import rt

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema.identifier() string {
	return 'payment_gateway_settings'
}
struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) get_item_schema_properties() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Payment gateway ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Payment gateway title on checkout.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema.view_edit_context() }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Payment gateway description on checkout.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema.view_edit_context() }]) }, rt.ArrayItem{ key: 'order', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Payment gateway sort order.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema.view_edit_context() }, rt.ArrayItem{ key: 'arg_options', val: rt.create_array([rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }]) }]) }, rt.ArrayItem{ key: 'enabled', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Payment gateway enabled status.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema.view_edit_context() }]) }, rt.ArrayItem{ key: 'method_title', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Payment gateway method title.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'method_description', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Payment gateway method description.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'method_supports', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Supported features for this payment gateway.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }, rt.ArrayItem{ key: 'values', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Flat key-value mapping of all setting field values.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'additionalProperties', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Setting field value.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'number' }, rt.ArrayItem{ key: none, val: 'array' }, rt.ArrayItem{ key: none, val: 'boolean' }]) }]) }]) }, rt.ArrayItem{ key: 'groups', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Collection of setting groups.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'additionalProperties', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Settings group.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Group title.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Group description.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'order', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Display order for the group.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'fields', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Settings fields.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: this.get_field_schema() }]) }]) }]) }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) get_field_schema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Setting field ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'label', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Setting field label.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Setting field type.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'text' }, rt.ArrayItem{ key: none, val: 'number' }, rt.ArrayItem{ key: none, val: 'select' }, rt.ArrayItem{ key: none, val: 'multiselect' }, rt.ArrayItem{ key: none, val: 'checkbox' }, rt.ArrayItem{ key: none, val: 'array' }]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'options', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Available options for select/multiselect fields.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'desc', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Description for the setting field.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) get_values(mut var_gateway Class_WC_Payment_Gateway) rt.PhpVal {
	mut var_values := rt.new_array()
	var_gateway.init_form_fields()
	{
		mut iter_1 := rt.get_property(var_gateway, 'form_fields').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			mut var_id := item_1.key
			mut var_field_type := if !(var_field.array_get('type')).is_null() { var_field.array_get('type') } else { rt.new_string('') }
			if rt.is_true(rt.call_function('in_array', [var_field_type.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'title' }, rt.ArrayItem{ key: none, val: 'sectionend' }]), rt.new_bool(true)])) {
				continue
			}
			var_values.array_set(var_id, if !(rt.get_property(var_gateway, 'settings').array_get(var_id)).is_null() { rt.get_property(var_gateway, 'settings').array_get(var_id) } else { if !(var_field.array_get('default')).is_null() { var_field.array_get('default') } else { rt.new_string('') } })
		}
	}
	mut var_special_fields := this.get_special_field_values(mut var_gateway)
	var_values = rt.call_function('array_merge', [var_values.dup(), var_special_fields.dup()])
	return var_values.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) get_special_field_values(mut var_gateway Class_WC_Payment_Gateway) rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) get_groups(mut var_gateway Class_WC_Payment_Gateway) rt.PhpVal {
	var_gateway.init_form_fields()
	mut var_custom_groups := this.get_custom_groups_for_gateway(mut var_gateway)
	if !(!rt.is_true(var_custom_groups)) {
		return var_custom_groups.dup()
	}
	return this.get_default_group(mut var_gateway)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) get_custom_groups_for_gateway(mut var_gateway Class_WC_Payment_Gateway) rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) get_default_group(mut var_gateway Class_WC_Payment_Gateway) rt.PhpVal {
	mut var_group := rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Settings'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: '' }, rt.ArrayItem{ key: 'order', val: 1 }, rt.ArrayItem{ key: 'fields', val: rt.new_array() }])
	var_group.array_get_mut('fields').array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: 'enabled' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Enable/Disable'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'checkbox' }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Enable this payment gateway'), rt.new_string('woocommerce')]) }]))
	var_group.array_get_mut('fields').array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: 'title' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Title'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('This controls the title which the user sees during checkout.'), rt.new_string('woocommerce')]) }]))
	var_group.array_get_mut('fields').array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: 'description' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Description'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('This controls the description which the user sees during checkout.'), rt.new_string('woocommerce')]) }]))
	var_group.array_get_mut('fields').array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: 'order' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Order'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Determines the display order of payment gateways during checkout.'), rt.new_string('woocommerce')]) }]))
	{
		mut iter_1 := rt.get_property(var_gateway, 'form_fields').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			mut var_id := item_1.key
			mut var_field_type := if !(var_field.array_get('type')).is_null() { var_field.array_get('type') } else { rt.new_string('') }
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [var_field_type.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'title' }, rt.ArrayItem{ key: none, val: 'sectionend' }]), rt.new_bool(true)])) || rt.is_true(rt.call_function('in_array', [var_id.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'enabled' }, rt.ArrayItem{ key: none, val: 'description' }, rt.ArrayItem{ key: none, val: 'title' }]), rt.new_bool(true)])))) || this.is_special_field((var_id).str()))) {
				continue
			}
			var_group.array_get_mut('fields').array_push(this.transform_field_to_schema((var_id).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_array](var_field), mut var_gateway))
		}
	}
	mut var_special_fields := this.get_special_field_schemas(mut var_gateway)
	var_group.array_set('fields', rt.call_function('array_merge', [var_group.array_get('fields'), var_special_fields.dup()]))
	if !rt.is_true(var_group.array_get('fields')) {
		return rt.new_array()
	}
	return rt.create_array([rt.ArrayItem{ key: 'settings', val: var_group }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) get_special_field_schemas(mut var_gateway Class_WC_Payment_Gateway) rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) transform_field_to_schema(id string, mut var_field Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_array, mut var_gateway Class_WC_Payment_Gateway) rt.PhpVal {
	mut var_field_mutated := var_field
	mut var_field_type := if !(var_field_mutated.array_get('type')).is_null() { var_field_mutated.array_get('type') } else { rt.new_string('text') }
	mut var_schema_field := rt.create_array([rt.ArrayItem{ key: 'id', val: id }, rt.ArrayItem{ key: 'label', val: if !(var_field_mutated.array_get('title')).is_null() { var_field_mutated.array_get('title') } else { if !(var_field_mutated.array_get('label')).is_null() { var_field_mutated.array_get('label') } else { rt.new_string('') } } }, rt.ArrayItem{ key: 'type', val: this.normalize_field_type((var_field_type).str()) }, rt.ArrayItem{ key: 'desc', val: if !(var_field_mutated.array_get('description')).is_null() { var_field_mutated.array_get('description') } else { rt.new_string('') } }])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('checkbox'), var_field_type)) && !rt.is_true(var_schema_field.array_get('desc')))) && !(!rt.is_true(var_field_mutated.array_get('label'))))) {
		var_schema_field.array_set('desc', var_field_mutated.array_get('label'))
	}
	if rt.is_true(rt.call_function('in_array', [var_schema_field.array_get('type'), rt.create_array([rt.ArrayItem{ key: none, val: 'select' }, rt.ArrayItem{ key: none, val: 'multiselect' }]), rt.new_bool(true)])) {
		if !(!rt.is_true(var_field_mutated.array_get('options'))) {
			var_schema_field.array_set('options', var_field_mutated.array_get('options'))
		} else {
			var_schema_field.array_set('options', this.get_field_options(id))
		}
	}
	return var_schema_field.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) get_field_options(field_id string) rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) build_fields_from_form_fields(mut var_gateway Class_WC_Payment_Gateway, mut var_core_field_overrides Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_array, mut var_skip_field_ids Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_array) rt.PhpVal {
	mut var_fields := rt.new_array()
	{
		mut iter_1 := var_core_field_overrides.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_override := item_1.val
			mut var_field_id := item_1.key
			if rt.is_true(rt.identical(rt.new_string('order'), var_field_id)) {
				var_fields.array_push(rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'id', val: var_field_id }]), var_override.dup()]))
				continue
			}
			if !(rt.get_property(var_gateway, 'form_fields').array_isset(var_field_id)) {
				continue
			}
			mut var_field := rt.get_property(var_gateway, 'form_fields').array_get(var_field_id)
			mut var_schema_field := rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'id', val: var_field_id }]), var_override.dup()])
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [if !(var_schema_field.array_get('type')).is_null() { var_schema_field.array_get('type') } else { rt.new_string('') }, rt.create_array([rt.ArrayItem{ key: none, val: 'select' }, rt.ArrayItem{ key: none, val: 'multiselect' }]), rt.new_bool(true)])) && !(var_schema_field.array_isset(rt.new_string('options'))))) {
				if !(!rt.is_true(var_field.array_get('options'))) {
					var_schema_field.array_set('options', var_field.array_get('options'))
				}
			}
			var_fields.array_push(var_schema_field.dup())
		}
	}
	{
		mut iter_1 := rt.get_property(var_gateway, 'form_fields').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			mut var_field_id := item_1.key
			mut var_field_type := if !(var_field.array_get('type')).is_null() { var_field.array_get('type') } else { rt.new_string('') }
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [var_field_type.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'title' }, rt.ArrayItem{ key: none, val: 'sectionend' }]), rt.new_bool(true)])) || var_core_field_overrides.array_isset(var_field_id))) || rt.is_true(rt.call_function('in_array', [var_field_id.dup(), var_skip_field_ids, rt.new_bool(true)])))) || this.is_special_field((var_field_id).str()))) {
				continue
			}
			var_fields.array_push(this.transform_field_to_schema((var_field_id).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_array](var_field), mut var_gateway))
		}
	}
	return var_fields.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) normalize_field_type(wc_type string) string {
	mut var_type_map := rt.create_array([rt.ArrayItem{ key: 'email', val: 'text' }, rt.ArrayItem{ key: 'password', val: 'text' }, rt.ArrayItem{ key: 'textarea', val: 'text' }, rt.ArrayItem{ key: 'safe_text', val: 'text' }, rt.ArrayItem{ key: 'color', val: 'text' }, rt.ArrayItem{ key: 'image_width', val: 'text' }, rt.ArrayItem{ key: 'radio', val: 'select' }])
	return (if !(var_type_map.array_get(wc_type)).is_null() { var_type_map.array_get(wc_type) } else { rt.new_string(wc_type) }).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) get_settings(mut var_gateway Class_WC_Payment_Gateway) rt.PhpVal {
	mut var_settings := rt.new_array()
	var_gateway.init_form_fields()
	{
		mut iter_1 := rt.get_property(var_gateway, 'form_fields').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			mut var_id := item_1.key
			if !rt.is_true(var_field.array_get('title')) || !rt.is_true(var_field.array_get('type')) {
				continue
			}
			if rt.is_true(rt.call_function('in_array', [var_id.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'enabled' }, rt.ArrayItem{ key: none, val: 'description' }]), rt.new_bool(true)])) {
				continue
			}
			mut var_data := rt.create_array([rt.ArrayItem{ key: 'id', val: var_id }, rt.ArrayItem{ key: 'label', val: if !rt.is_true(var_field.array_get('label')) { var_field.array_get('title') } else { var_field.array_get('label') } }, rt.ArrayItem{ key: 'description', val: if !rt.is_true(var_field.array_get('description')) { rt.new_string('') } else { var_field.array_get('description') } }, rt.ArrayItem{ key: 'type', val: var_field.array_get('type') }, rt.ArrayItem{ key: 'value', val: if !rt.is_true(rt.get_property(var_gateway, 'settings').array_get(var_id)) { rt.new_string('') } else { rt.get_property(var_gateway, 'settings').array_get(var_id) } }, rt.ArrayItem{ key: 'default', val: if !rt.is_true(var_field.array_get('default')) { rt.new_string('') } else { var_field.array_get('default') } }, rt.ArrayItem{ key: 'tip', val: if !rt.is_true(var_field.array_get('description')) { rt.new_string('') } else { var_field.array_get('description') } }, rt.ArrayItem{ key: 'placeholder', val: if !rt.is_true(var_field.array_get('placeholder')) { rt.new_string('') } else { var_field.array_get('placeholder') } }])
			if !(!rt.is_true(var_field.array_get('options'))) {
				var_data.array_set('options', var_field.array_get('options'))
			}
			var_settings.array_set(var_id, var_data.dup())
		}
	}
	return var_settings.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) get_item_response(var_gateway rt.PhpVal, mut var_request Class_WP_REST_Request, mut var_include_fields Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_array) rt.PhpVal {
	mut var_order := rt.cast_array(rt.call_function('get_option', [rt.new_string('woocommerce_gateway_order')]))
	return rt.create_array([rt.ArrayItem{ key: 'id', val: rt.get_property(var_gateway, 'id') }, rt.ArrayItem{ key: 'title', val: rt.get_property(var_gateway, 'title') }, rt.ArrayItem{ key: 'description', val: rt.get_property(var_gateway, 'description') }, rt.ArrayItem{ key: 'order', val: if !(var_order.array_get(rt.get_property(var_gateway, 'id'))).is_null() { var_order.array_get(rt.get_property(var_gateway, 'id')) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'enabled', val: rt.identical(rt.new_string('yes'), rt.get_property(var_gateway, 'enabled')) }, rt.ArrayItem{ key: 'method_title', val: rt.call_method(var_gateway, 'get_method_title', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'method_description', val: rt.call_method(var_gateway, 'get_method_description', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'method_supports', val: rt.get_property(var_gateway, 'supports') }, rt.ArrayItem{ key: 'values', val: this.get_values(mut rt.cast_object_ptr[Class_WC_Payment_Gateway](var_gateway)) }, rt.ArrayItem{ key: 'groups', val: this.get_groups(mut rt.cast_object_ptr[Class_WC_Payment_Gateway](var_gateway)) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) is_special_field(field_id string) bool {
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) validate_and_sanitize_settings(mut var_gateway Class_WC_Payment_Gateway, mut var_values Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_array) rt.PhpVal {
	mut var_values_mutated := var_values
	var_gateway.init_form_fields()
	mut var_validated := rt.new_array()
	{
		mut iter_1 := var_values_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if !(rt.get_property(var_gateway, 'form_fields').array_isset(var_key)) {
				continue
			}
			mut var_field := rt.get_property(var_gateway, 'form_fields').array_get(var_key)
			mut var_field_type := if !(var_field.array_get('type')).is_null() { var_field.array_get('type') } else { rt.new_string('text') }
			mut var_sanitized := this.sanitize_field_value((var_field_type).str(), var_value.dup())
			mut var_validation := rt.new_bool(this.validate_field_value((var_key).str(), var_sanitized.dup(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_array](var_field), mut var_gateway))
			if rt.is_true(rt.call_function('is_wp_error', [var_validation.dup()])) {
				return var_validation.dup()
			}
			var_validated.array_set(var_key, var_sanitized.dup())
		}
	}
	return var_validated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) sanitize_field_value(type string, var_value rt.PhpVal)  {
	mut switch_val_1 := rt.new_string(type)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('checkbox'))) {
		return rt.call_function('wc_bool_to_string', [var_value.dup()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('number'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.dup().is_long() || var_value.dup().is_double()))))) {
			return rt.new_string('')
		}
		mut var_int_value := rt.call_function('filter_var', [var_value.dup(), rt.get_constant('FILTER_VALIDATE_INT'), rt.get_constant('FILTER_NULL_ON_FAILURE')])
		return if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_int_value } else { rt.new_float(var_value.dup().to_f64()) }
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('multiselect'))) {
		if rt.is_true(rt.new_bool(var_value.dup().is_array())) {
			return rt.call_function('array_map', [rt.new_string('sanitize_text_field'), var_value.dup()])
		}
		return if rt.is_true(rt.new_bool(var_value.dup().is_string())) { rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('sanitize_text_field', [var_value.dup()]) }]) } else { rt.new_array() }
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('textarea'))) {
		return rt.call_function('sanitize_textarea_field', [var_value.dup()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('email'))) {
		return rt.call_function('sanitize_email', [var_value.dup()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('password'))) {
		return rt.new_string(if rt.is_true(rt.call_function('is_scalar', [var_value.dup()])) { // unsupported expression: Expr_Cast_String.to_string().trim_space() } else { '' })
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('color'))) {
		return rt.call_function('sanitize_text_field', [var_value.dup()])
	} else {
		return rt.call_function('sanitize_text_field', [var_value.dup()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) validate_field_value(key string, var_value rt.PhpVal, mut var_field Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_array, mut var_gateway Class_WC_Payment_Gateway) bool {
	mut var_field_mutated := var_field
	mut var_field_type := rt.new_string(this.normalize_field_type(().str()))
	if rt.is_true(rt.new_bool(rt.is_true() && !(!rt.is_true()))) {
		if rt.is_true() {
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true() && !(!rt.is_true()))) {
		if rt.is_true() {
		}
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) validate_and_sanitize_special_fields(mut var_gateway Class_WC_Payment_Gateway, mut var_values Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_array) rt.PhpVal {
	mut var_values_mutated := var_values
	return 
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) update_special_fields(mut var_gateway Class_WC_Payment_Gateway, mut var_values Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_array)  {
	mut var_values_mutated := var_values
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_settings_paymentgateways_schema_abstractpaymentgatewaysettingsschema() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_abstractschema() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_item_schema_properties' {
			return this.get_item_schema_properties()
		}
		'get_field_schema' {
			return this.get_field_schema()
		}
		'get_values' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_values(mut dispatch_arg_0)
		}
		'get_special_field_values' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_special_field_values(mut dispatch_arg_0)
		}
		'get_groups' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_groups(mut dispatch_arg_0)
		}
		'get_custom_groups_for_gateway' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_custom_groups_for_gateway(mut dispatch_arg_0)
		}
		'get_default_group' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_default_group(mut dispatch_arg_0)
		}
		'get_special_field_schemas' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_special_field_schemas(mut dispatch_arg_0)
		}
		'transform_field_to_schema' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.transform_field_to_schema(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'get_field_options' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_field_options(dispatch_arg_0)
		}
		'build_fields_from_form_fields' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.build_fields_from_form_fields(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'normalize_field_type' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.normalize_field_type(dispatch_arg_0))
		}
		'get_settings' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_settings(mut dispatch_arg_0)
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.get_item_response(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'is_special_field' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_special_field(dispatch_arg_0))
		}
		'validate_and_sanitize_settings' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.validate_and_sanitize_settings(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'sanitize_field_value' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.sanitize_field_value(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'validate_field_value' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_array](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 3 { args[3] } else { rt.new_null() })
			return rt.new_bool(this.validate_field_value(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3))
		}
		'validate_and_sanitize_special_fields' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.validate_and_sanitize_special_fields(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'update_special_fields' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.update_special_fields(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_restapi_routes_v4_settings_paymentgateways_schema_abstractpaymentgatewaysettingsschema_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
