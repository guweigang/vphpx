import rt

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema.identifier() string {
	return 'emails_settings'
}
pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema.fields_supporting_personalization_tags() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'subject' }, rt.ArrayItem{ key: none, val: 'preheader' }, rt.ArrayItem{ key: none, val: 'subject_full' }, rt.ArrayItem{ key: none, val: 'subject_partial' }])
}
struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema {
	rt.PhpObjectBase
pub mut:
		personalization_tags_registry rt.PhpVal = rt.new_null()
		cached_prefixes rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema) init()  {
	this.personalization_tags_registry = rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container{}; return temp.container() }(), 'get', [Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry.class()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema) get_item_schema_properties() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Email template ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Email title.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Email description.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'post_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Template post ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'integer' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'link', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Link to template editor.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'uri' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'email_group', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Email group identifier.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'email_group_title', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Email group title.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'is_customer_email', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether this is a customer email.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'is_manual', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether this is sent only manually.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'values', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Flat key-value mapping of all setting field values.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema.view_edit_context() }, rt.ArrayItem{ key: 'additionalProperties', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Setting field value.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'number' }, rt.ArrayItem{ key: none, val: 'array' }, rt.ArrayItem{ key: none, val: 'boolean' }]) }]) }]) }, rt.ArrayItem{ key: 'groups', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Collection of setting groups.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema.view_edit_context() }, rt.ArrayItem{ key: 'additionalProperties', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Settings group.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Group title.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema.view_edit_context() }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Group description.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema.view_edit_context() }]) }, rt.ArrayItem{ key: 'order', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Display order for the group.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'fields', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Settings fields.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema.view_edit_context() }, rt.ArrayItem{ key: 'items', val: this.get_field_schema() }]) }]) }]) }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema) get_field_schema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Setting field ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema.view_edit_context() }]) }, rt.ArrayItem{ key: 'label', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Setting field label.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema.view_edit_context() }]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Setting field type.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'text' }, rt.ArrayItem{ key: none, val: 'email' }, rt.ArrayItem{ key: none, val: 'number' }, rt.ArrayItem{ key: none, val: 'select' }, rt.ArrayItem{ key: none, val: 'multiselect' }, rt.ArrayItem{ key: none, val: 'checkbox' }, rt.ArrayItem{ key: none, val: 'textarea' }, rt.ArrayItem{ key: none, val: 'color' }, rt.ArrayItem{ key: none, val: 'password' }]) }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema.view_edit_context() }]) }, rt.ArrayItem{ key: 'desc', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Description for the setting field.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema.view_edit_context() }]) }, rt.ArrayItem{ key: 'options', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Available options for select/multiselect fields.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema.view_edit_context() }]) }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema) get_item_response(var_email rt.PhpVal, mut var_request Class_WP_REST_Request, mut var_include_fields Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_array) rt.PhpVal {
	mut var_email_mutated := var_email
	mut var_email_post_manager := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager{}; return temp.get_instance() }()
	mut var_post_id := rt.call_method(var_email_post_manager, 'get_email_template_post_id', [if !(rt.get_property(var_email_mutated, 'id')).is_null() { rt.get_property(var_email_mutated, 'id') } else { rt.new_string('') }])
	var_post_id = if rt.is_true(var_post_id) { // unsupported expression: Expr_Cast_Int } else { rt.new_null() }
	mut var_link := rt.new_string(rt.new_string(''))
	if rt.is_true(var_post_id) {
		mut var_permalink := rt.call_function('get_permalink', [var_post_id.dup()])
		var_link = if rt.is_true(rt.new_bool(var_permalink.dup().is_string())) { var_permalink } else { rt.new_string('') }
	}
	rt.call_method(var_email_mutated, 'init_form_fields', []rt.PhpVal{})
	mut var_response := rt.create_array([rt.ArrayItem{ key: 'id', val: if !(rt.get_property(var_email_mutated, 'id')).is_null() { rt.get_property(var_email_mutated, 'id') } else { rt.new_string('') } }, rt.ArrayItem{ key: 'title', val: if !(rt.get_property(var_email_mutated, 'title')).is_null() { rt.get_property(var_email_mutated, 'title') } else { rt.new_string('') } }, rt.ArrayItem{ key: 'description', val: if !(rt.get_property(var_email_mutated, 'description')).is_null() { rt.get_property(var_email_mutated, 'description') } else { rt.new_string('') } }, rt.ArrayItem{ key: 'post_id', val: var_post_id }, rt.ArrayItem{ key: 'link', val: var_link }, rt.ArrayItem{ key: 'email_group', val: if !(rt.get_property(var_email_mutated, 'email_group')).is_null() { rt.get_property(var_email_mutated, 'email_group') } else { rt.new_string('') } }, rt.ArrayItem{ key: 'email_group_title', val: if rt.is_true(rt.call_function('method_exists', [var_email_mutated.dup(), rt.new_string('get_email_group_title')])) { rt.call_method(var_email_mutated, 'get_email_group_title', []rt.PhpVal{}) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'is_customer_email', val: if rt.is_true(rt.call_function('method_exists', [var_email_mutated.dup(), rt.new_string('is_customer_email')])) { rt.call_method(var_email_mutated, 'is_customer_email', []rt.PhpVal{}) } else { rt.new_bool(false) } }, rt.ArrayItem{ key: 'is_manual', val: if rt.is_true(rt.call_function('method_exists', [var_email_mutated.dup(), rt.new_string('is_manual')])) { rt.call_method(var_email_mutated, 'is_manual', []rt.PhpVal{}) } else { rt.new_bool(false) } }, rt.ArrayItem{ key: 'values', val: this.get_values(mut rt.cast_object_ptr[Class_WC_Email](var_email_mutated)) }, rt.ArrayItem{ key: 'groups', val: this.get_groups(mut rt.cast_object_ptr[Class_WC_Email](var_email_mutated)) }])
	if !(!rt.is_true(var_include_fields)) {
		var_response = rt.call_function('array_intersect_key', [var_response.dup(), rt.call_function('array_flip', [var_include_fields])])
	}
	return var_response.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema) get_values(mut var_email Class_WC_Email) rt.PhpVal {
	mut var_email_mutated := var_email
	mut var_values := rt.new_array()
	mut var_form_fields := rt.call_method(var_email_mutated, 'get_form_fields', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_form_fields.dup().is_array()))))) {
		return var_values.dup()
	}
	rt.set_property(var_email_mutated, 'object', create_automattic_woocommerce_internal_restapi_routes_v4_settings_emails_schema_wc_order())
	{
		mut iter_1 := var_form_fields.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			mut var_id := item_1.key
			mut var_field_type := if !(var_field.array_get('type')).is_null() { var_field.array_get('type') } else { rt.new_string('text') }
			if rt.is_true(rt.call_function('in_array', [var_field_type.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'title' }, rt.ArrayItem{ key: none, val: 'sectionend' }]), rt.new_bool(true)])) {
				continue
			}
			mut var_default := this.get_field_default_value(mut var_email_mutated, (var_id).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_array](var_field))
			mut var_value := rt.call_method(var_email_mutated, 'get_option', [var_id.dup(), var_default.dup()])
			if rt.is_true(rt.call_function('in_array', [var_id.dup(), Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema.fields_supporting_personalization_tags(), rt.new_bool(true)])) {
				var_value = this.unwrap_woocommerce_tags(var_value.dup())
			}
			if rt.is_true(rt.identical(rt.new_string('checkbox'), var_field_type)) {
				var_value = rt.identical(rt.new_string('yes'), var_value)
			}
			var_values.array_set(var_id, var_value.dup())
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('customer_refunded_order'), rt.get_property(var_email_mutated, 'id'))) && rt.is_true(rt.identical(rt.new_string('subject_full'), var_id)))) {
				if !(var_values.array_isset(rt.new_string('subject'))) {
					var_values.array_set('subject', var_value.dup())
				}
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('customer_partially_refunded_order'), rt.get_property(var_email_mutated, 'id'))) && rt.is_true(rt.identical(rt.new_string('subject_partial'), var_id)))) {
				if !(var_values.array_isset(rt.new_string('subject'))) {
					var_values.array_set('subject', var_value.dup())
				}
			}
		}
	}
	return var_values.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema) get_field_default_value(mut var_email Class_WC_Email, id string, mut var_field Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_array)  {
	mut var_email_mutated := var_email
	mut var_field_mutated := var_field
	mut switch_val_1 := rt.new_string(id)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('enabled'))) {
		return if rt.is_true(rt.call_function('method_exists', [var_email_mutated.dup(), rt.new_string('is_enabled')])) { rt.call_method(var_email_mutated, 'is_enabled', []rt.PhpVal{}) } else { rt.new_bool(false) }
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('recipient'))) {
		return if rt.is_true(rt.call_function('method_exists', [var_email_mutated.dup(), rt.new_string('get_recipient')])) { rt.call_method(var_email_mutated, 'get_recipient', []rt.PhpVal{}) } else { rt.new_string('') }
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('subject'))) {
		return if rt.is_true(rt.call_function('method_exists', [var_email_mutated.dup(), rt.new_string('get_subject')])) { rt.call_method(var_email_mutated, 'get_subject', []rt.PhpVal{}) } else { rt.new_string('') }
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('heading'))) {
		return if rt.is_true(rt.call_function('method_exists', [var_email_mutated.dup(), rt.new_string('get_heading')])) { rt.call_method(var_email_mutated, 'get_heading', []rt.PhpVal{}) } else { rt.new_string('') }
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('preheader'))) {
		return if rt.is_true(rt.call_function('method_exists', [var_email_mutated.dup(), rt.new_string('get_preheader')])) { rt.call_method(var_email_mutated, 'get_preheader', []rt.PhpVal{}) } else { rt.new_string('') }
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('additional_content'))) {
		return if rt.is_true(rt.call_function('method_exists', [var_email_mutated.dup(), rt.new_string('get_additional_content')])) { rt.call_method(var_email_mutated, 'get_additional_content', []rt.PhpVal{}) } else { rt.new_string('') }
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('cc'))) {
		return if !(rt.get_property(var_email_mutated, 'cc')).is_null() { rt.get_property(var_email_mutated, 'cc') } else { rt.new_string('') }
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('bcc'))) {
		return if !(rt.get_property(var_email_mutated, 'bcc')).is_null() { rt.get_property(var_email_mutated, 'bcc') } else { rt.new_string('') }
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('email_type'))) {
		return if !(rt.get_property(var_email_mutated, 'email_type')).is_null() { rt.get_property(var_email_mutated, 'email_type') } else { rt.new_string('') }
	} else {
		return if !(var_field_mutated.array_get('default')).is_null() { var_field_mutated.array_get('default') } else { if !(var_field_mutated.array_get('placeholder')).is_null() { var_field_mutated.array_get('placeholder') } else { rt.new_string('') } }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema) unwrap_woocommerce_tags(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_string()))))) {
		return var_value_mutated.dup()
	}
	mut var_prefixes := this.get_personalization_tag_prefixes()
	if !rt.is_true(var_prefixes) {
		return var_value_mutated.dup()
	}
	mut var_escaped_prefixes := rt.call_function('array_map', [rt.new_string('preg_quote'), var_prefixes.dup()])
	mut var_prefixes_pattern := rt.call_function('implode', [rt.new_string('|'), var_escaped_prefixes.dup()])
	mut var_unwrapped_value := rt.call_function('preg_replace', ['/<!--(\\[(?:' + (var_prefixes_pattern).str() + ')\\/[^\\]]+\\])-->/i', rt.new_string('$1'), var_value_mutated.dup()])
	return var_unwrapped_value.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema) wrap_woocommerce_tags(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_string()))))) {
		return var_value_mutated.dup()
	}
	mut var_prefixes := this.get_personalization_tag_prefixes()
	if !rt.is_true(var_prefixes) {
		return var_value_mutated.dup()
	}
	mut var_escaped_prefixes := rt.call_function('array_map', [rt.new_string('preg_quote'), var_prefixes.dup()])
	mut var_prefixes_pattern := rt.call_function('implode', [rt.new_string('|'), var_escaped_prefixes.dup()])
	return rt.call_function('preg_replace', ['/(?<!<!--)(\\[(?:' + (var_prefixes_pattern).str() + ')\\/[^\\]]+\\])(?!-->)/i', rt.new_string('<!--$1-->'), var_value_mutated.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema) get_groups(mut var_email Class_WC_Email) rt.PhpVal {
	mut var_email_mutated := var_email
	mut var_group := rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Email Settings'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: '' }, rt.ArrayItem{ key: 'order', val: 1 }, rt.ArrayItem{ key: 'fields', val: rt.new_array() }])
	mut var_form_fields := rt.call_method(var_email_mutated, 'get_form_fields', []rt.PhpVal{})
	{
		mut iter_1 := var_form_fields.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			mut var_id := item_1.key
			mut var_field_type := if !(var_field.array_get('type')).is_null() { var_field.array_get('type') } else { rt.new_string('text') }
			if rt.is_true(rt.call_function('in_array', [var_field_type.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'title' }, rt.ArrayItem{ key: none, val: 'sectionend' }]), rt.new_bool(true)])) {
				continue
			}
			mut var_field_schema := rt.create_array([rt.ArrayItem{ key: 'id', val: var_id }, rt.ArrayItem{ key: 'label', val: if !(var_field.array_get('title')).is_null() { var_field.array_get('title') } else { var_id } }, rt.ArrayItem{ key: 'type', val: var_field_type }, rt.ArrayItem{ key: 'desc', val: if !(var_field.array_get('description')).is_null() { var_field.array_get('description') } else { rt.new_string('') } }])
			if rt.is_true(rt.new_bool(var_field.array_isset(rt.new_string('options')) && rt.is_true(rt.new_bool(var_field.array_get('options').is_array())))) {
				var_field_schema.array_set('options', var_field.array_get('options'))
			}
			var_group.array_get_mut('fields').array_push(var_field_schema.dup())
		}
	}
	if !rt.is_true(var_group.array_get('fields')) {
		return rt.new_array()
	}
	return rt.create_array([rt.ArrayItem{ key: 'settings', val: var_group }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema) validate_and_sanitize_settings(mut var_email Class_WC_Email, mut var_values Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_array) rt.PhpVal {
	mut var_email_mutated := var_email
	mut var_values_mutated := var_values
	rt.call_method(var_email_mutated, 'init_form_fields', []rt.PhpVal{})
	mut var_validated := rt.new_array()
	{
		mut iter_1 := var_values_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_field_id := item_1.key
			if !(rt.get_property(var_email_mutated, 'form_fields').array_isset(var_field_id)) {
				continue
			}
			mut var_field := rt.get_property(var_email_mutated, 'form_fields').array_get(var_field_id)
			mut var_field_type := if !(var_field.array_get('type')).is_null() { var_field.array_get('type') } else { rt.new_string('text') }
			if rt.is_true(rt.call_function('in_array', [var_field_id.dup(), Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema.fields_supporting_personalization_tags(), rt.new_bool(true)])) {
				var_value = this.unwrap_woocommerce_tags(var_value.dup())
			}
			mut var_sanitized := this.sanitize_field_value((var_field_type).str(), var_value.dup())
			if rt.is_true(rt.call_function('in_array', [var_field_id.dup(), Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema.fields_supporting_personalization_tags(), rt.new_bool(true)])) {
				var_sanitized = this.wrap_woocommerce_tags(var_sanitized.dup())
			}
			mut var_validation := rt.new_bool(this.validate_field_value((var_field_id).str(), var_sanitized.dup(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_array](var_field)))
			if rt.is_true(rt.call_function('is_wp_error', [var_validation.dup()])) {
				return var_validation.dup()
			}
			var_validated.array_set(var_field_id, var_sanitized.dup())
		}
	}
	var_validated = rt.call_function('apply_filters', [rt.new_string('woocommerce_emails_settings_schema_validate_and_sanitize_settings'), var_validated.dup(), var_email_mutated.dup(), var_values_mutated.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_validated.dup()])) {
		return var_validated.dup()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_validated.dup().is_array()))))) {
		return create_wp_error(rt.new_string('rest_invalid_filter_result'), rt.call_function('__', [rt.new_string('Invalid result from filter.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
	}
	return var_validated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema) sanitize_field_value(type string, var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	mut switch_val_2 := rt.new_string(type)
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('checkbox'))) {
		if rt.is_true(rt.new_bool(var_value_mutated.dup().is_array())) {
			var_value_mutated = rt.new_bool(rt.new_bool(!(!rt.is_true(var_value_mutated))))
			// unsupported statement: Stmt_Nop
		}
		return rt.call_function('wc_bool_to_string', [var_value_mutated.dup()])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('email'))) {
		return rt.call_function('sanitize_email', [var_value_mutated.dup()])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('textarea'))) {
		return rt.call_function('sanitize_textarea_field', [var_value_mutated.dup()])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('number'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_long() || var_value_mutated.dup().is_double()))))) {
			return rt.new_int(0)
		}
		mut var_int_value := rt.call_function('filter_var', [var_value_mutated.dup(), rt.get_constant('FILTER_VALIDATE_INT'), rt.get_constant('FILTER_NULL_ON_FAILURE')])
		return if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_int_value } else { rt.new_float(.dup().to_f64()) }
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('multiselect'))) {
		if rt.is_true(rt.new_bool(.dup().is_array())) {
			return 
		}
		return 
	} else if rt.is_true(rt.equal(switch_val_2, )) {
	} else {
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema) validate_field_value(key string, var_value rt.PhpVal, mut var_field Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_array) bool {
	mut var_value_mutated := var_value
	mut var_field_mutated := var_field
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema) get_personalization_tag_prefixes() rt.PhpVal {
	mut var_matches := rt.new_null()
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_WC_Order {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_settings_emails_schema_emailssettingsschema() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema{
		PhpObjectBase: rt.PhpObjectBase{}
		personalization_tags_registry: rt.new_null()
		cached_prefixes: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_abstractschema() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_email_editor_container() &Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wctransactionalemailpostsmanager() &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_settings_emails_schema_wc_order() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_WC_Order {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_WC_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'get_item_schema_properties' {
			return this.get_item_schema_properties()
		}
		'get_field_schema' {
			return this.get_field_schema()
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.get_item_response(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'get_values' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Email](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_values(mut dispatch_arg_0)
		}
		'get_field_default_value' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Email](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_array](if args.len > 2 { args[2] } else { rt.new_null() })
			this.get_field_default_value(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'unwrap_woocommerce_tags' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.unwrap_woocommerce_tags(dispatch_arg_0)
		}
		'wrap_woocommerce_tags' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wrap_woocommerce_tags(dispatch_arg_0)
		}
		'get_groups' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Email](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_groups(mut dispatch_arg_0)
		}
		'validate_and_sanitize_settings' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Email](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_array](if args.len > 1 { args[1] } else { rt.new_null() })
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
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_bool(this.validate_field_value(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2))
		}
		'get_personalization_tag_prefixes' {
			return this.get_personalization_tag_prefixes()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'personalization_tags_registry' { return this.personalization_tags_registry }
		'cached_prefixes' { return this.cached_prefixes }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_EmailsSettingsSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'personalization_tags_registry' { this.personalization_tags_registry = val; return true }
		'cached_prefixes' { this.cached_prefixes = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_WC_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_WC_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Schema_WC_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_restapi_routes_v4_settings_emails_schema_emailssettingsschema_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
