import rt

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema.identifier() string {
	return 'general_settings'
}
struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema) get_item_schema_properties() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the settings group.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Settings title.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Settings description.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'values', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Flat key-value mapping of all setting field values.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema.view_edit_context() }, rt.ArrayItem{ key: 'additionalProperties', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Setting field value.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'number' }, rt.ArrayItem{ key: none, val: 'array' }, rt.ArrayItem{ key: none, val: 'boolean' }]) }]) }]) }, rt.ArrayItem{ key: 'groups', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Collection of setting groups.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema.view_edit_context() }, rt.ArrayItem{ key: 'additionalProperties', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Settings group.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Group title.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema.view_edit_context() }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Group description.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema.view_edit_context() }]) }, rt.ArrayItem{ key: 'order', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Display order for the group.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'fields', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Settings fields.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema.view_edit_context() }, rt.ArrayItem{ key: 'items', val: this.get_field_schema() }]) }]) }]) }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema) get_field_schema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Setting field ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema.view_edit_context() }]) }, rt.ArrayItem{ key: 'label', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Setting field label.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema.view_edit_context() }]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Setting field type.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'text' }, rt.ArrayItem{ key: none, val: 'number' }, rt.ArrayItem{ key: none, val: 'select' }, rt.ArrayItem{ key: none, val: 'multiselect' }, rt.ArrayItem{ key: none, val: 'checkbox' }]) }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema.view_edit_context() }]) }, rt.ArrayItem{ key: 'options', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Available options for select/multiselect fields.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema.view_edit_context() }]) }, rt.ArrayItem{ key: 'desc', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Description for the setting field.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema.view_edit_context() }]) }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema) get_item_response(var_item rt.PhpVal, mut var_request Class_WP_REST_Request, mut var_include_fields Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_array) rt.PhpVal {
	mut var_raw_settings := var_item
	mut var_groups := rt.new_array()
	mut var_values := rt.new_array()
	mut var_current_group := rt.new_null()
	mut var_current_group_id := rt.new_null()
	{
		mut iter_1 := var_raw_settings.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_setting := item_1.val
			mut var_setting_type := if !(var_setting.array_get('type')).is_null() { var_setting.array_get('type') } else { rt.new_string('') }
			if rt.is_true(rt.identical(rt.new_string('title'), var_setting_type)) {
				var_current_group_id = if !(var_setting.array_get('id')).is_null() { var_setting.array_get('id') } else { rt.new_string('') }
				var_current_group = rt.create_array([rt.ArrayItem{ key: 'title', val: if !(var_setting.array_get('title')).is_null() { var_setting.array_get('title') } else { rt.new_string('') } }, rt.ArrayItem{ key: 'description', val: if !(var_setting.array_get('desc')).is_null() { var_setting.array_get('desc') } else { rt.new_string('') } }, rt.ArrayItem{ key: 'order', val: if var_setting.array_isset(rt.new_string('order')) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(999) } }, rt.ArrayItem{ key: 'fields', val: rt.new_array() }])
				continue
			}
			if rt.is_true(rt.identical(rt.new_string('sectionend'), var_setting_type)) {
				if rt.is_true(rt.new_bool(rt.is_true(var_current_group) && rt.is_true(var_current_group_id))) {
					var_groups.array_set(var_current_group_id, var_current_group.dup())
				}
				var_current_group = rt.new_null()
				var_current_group_id = rt.new_null()
				continue
			}
			if rt.is_true(rt.call_function('in_array', [var_setting_type.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'title' }, rt.ArrayItem{ key: none, val: 'sectionend' }]), rt.new_bool(true)])) {
				continue
			}
			if rt.is_true(rt.new_bool(var_setting.array_isset(rt.new_string('id')) && rt.is_true(var_current_group))) {
				mut var_field := this.transform_setting_to_field(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_array](var_setting))
				if rt.is_true(var_field) {
					var_current_group.array_get_mut('fields').array_push(var_field.dup())
					mut var_raw_value := rt.call_function('get_option', [var_field.array_get('id'), if !(var_setting.array_get('default')).is_null() { var_setting.array_get('default') } else { rt.new_string('') }])
					var_values.array_set(var_field.array_get('id'), this.validate_field_value(var_raw_value.dup(), (var_field.array_get('type')).str()))
				}
			}
		}
	}
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_a := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_b := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	mut var_a_order := if !(var_a.array_get('order')).is_null() { var_a.array_get('order') } else { rt.new_int(999) }
	mut var_b_order := if !(var_b.array_get('order')).is_null() { var_b.array_get('order') } else { rt.new_int(999) }
	return rt.sub(var_a_order, var_b_order)
	}
	rt.call_function('uasort', [var_groups.dup(), rt.new_closure(closure_1_fn)])
	mut var_response := rt.create_array([rt.ArrayItem{ key: 'id', val: 'general' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('General'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Set your store\'s address, visibility, currency, language, and timezone.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'values', val: var_values }, rt.ArrayItem{ key: 'groups', val: var_groups }])
	if !(!rt.is_true(var_include_fields)) {
		var_response = rt.call_function('array_intersect_key', [var_response.dup(), rt.call_function('array_flip', [var_include_fields])])
	}
	return var_response.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema) transform_setting_to_field(mut var_setting Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_array) rt.PhpVal {
	mut var_setting_id := if !(var_setting.array_get('id')).is_null() { var_setting.array_get('id') } else { rt.new_string('') }
	mut var_setting_type := if !(var_setting.array_get('type')).is_null() { var_setting.array_get('type') } else { rt.new_string('text') }
	mut var_field := rt.create_array([rt.ArrayItem{ key: 'id', val: var_setting_id }, rt.ArrayItem{ key: 'label', val: if !(var_setting.array_get('title')).is_null() { var_setting.array_get('title') } else { var_setting_id } }, rt.ArrayItem{ key: 'type', val: this.normalize_field_type((var_setting_type).str()) }, rt.ArrayItem{ key: 'desc', val: if !(var_setting.array_get('desc')).is_null() { var_setting.array_get('desc') } else { rt.new_string('') } }])
	if rt.is_true(rt.new_bool(var_setting.array_isset(rt.new_string('options')) && rt.is_true(rt.new_bool(var_setting.array_get('options').is_array())))) {
		var_field.array_set('options', var_setting.array_get('options'))
	} else {
		var_field.array_set('options', this.get_field_options((var_setting_id).str()))
	}
	return var_field.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema) get_field_options(field_id string) rt.PhpVal {
	mut switch_val_1 := rt.new_string(field_id)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_currency'))) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('get_woocommerce_currencies')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('get_woocommerce_currency_symbol')]))))))) {
			return rt.new_array()
		}
		mut var_currencies := rt.call_function('get_woocommerce_currencies', []rt.PhpVal{})
		mut var_options := rt.new_array()
		{
			mut iter_1 := var_currencies.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_name := item_1.val
				mut var_code := item_1.key
				mut var_label := rt.call_function('wp_specialchars_decode', [// unsupported expression: Expr_Cast_String])
				mut var_symbol := rt.call_function('wp_specialchars_decode', [// unsupported expression: Expr_Cast_String])
				var_options.array_set(var_code, (var_label).str() + ' (' + (var_symbol).str() + ') — ' + (var_code).str())
			}
		}
		return var_options.dup()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_default_country'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_specific_allowed_countries'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_specific_ship_to_countries'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('WC')]))))) {
			return rt.new_array()
		}
		mut var_countries := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_countries', []rt.PhpVal{})
		mut var_states := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_states', []rt.PhpVal{})
		var_options = rt.new_array()
		{
			mut iter_1 := var_countries.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_country_name := item_1.val
				mut var_country_code := item_1.key
				mut var_country_states := if !(var_states.array_get(var_country_code)).is_null() { var_states.array_get(var_country_code) } else { rt.new_array() }
				if !rt.is_true(var_country_states) {
					var_options.array_set(var_country_code, var_country_name.dup())
				} else {
					{
						mut iter_2 := var_country_states.iterator()
						for {
							item_2 := iter_2.next() or { break }
							mut var_state_name := item_2.val
							mut var_state_code := item_2.key
							var_options.array_set((var_country_code).str() + ':' + (var_state_code).str(), (var_country_name).str() + ' — ' + (var_state_name).str())
						}
					}
				}
			}
		}
		return var_options.dup()
	}
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema) normalize_field_type(wc_type string) string {
	mut var_type_map := rt.create_array([rt.ArrayItem{ key: 'single_select_country', val: 'select' }, rt.ArrayItem{ key: 'multi_select_countries', val: 'multiselect' }])
	return (if !(var_type_map.array_get(wc_type)).is_null() { var_type_map.array_get(wc_type) } else { rt.new_string(wc_type) }).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema) validate_field_value(var_value rt.PhpVal, type string)  {
	mut switch_val_2 := rt.new_string(type)
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('number'))) {
		return if rt.is_true(rt.new_bool(var_value.dup().is_long() || var_value.dup().is_double())) { // unsupported expression: Expr_Cast_Double } else { rt.new_int(0) }
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('checkbox'))) {
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_string_to_bool')])) {
			return rt.call_function('wc_string_to_bool', [var_value.dup()])
		}
		if rt.is_true(rt.new_bool(var_value.dup().is_bool())) {
			return var_value.dup()
		}
		return rt.call_function('filter_var', [var_value.dup(), rt.get_constant('FILTER_VALIDATE_BOOLEAN')])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('multiselect'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.dup().is_array()))))) {
			return rt.new_array()
		}
		return rt.call_function('array_map', [rt.new_string('sanitize_text_field'), var_value.dup()])
	} else {
		return if rt.is_true(rt.new_bool(var_value.dup().is_string())) { var_value } else { // unsupported expression: Expr_Cast_String }
	}
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_settings_general_schema_generalsettingsschema() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema{
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

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_item_schema_properties' {
			return this.get_item_schema_properties()
		}
		'get_field_schema' {
			return this.get_field_schema()
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.get_item_response(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'transform_setting_to_field' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.transform_setting_to_field(mut dispatch_arg_0)
		}
		'get_field_options' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_field_options(dispatch_arg_0)
		}
		'normalize_field_type' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.normalize_field_type(dispatch_arg_0))
		}
		'validate_field_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.validate_field_value(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_restapi_routes_v4_settings_general_schema_generalsettingsschema_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
