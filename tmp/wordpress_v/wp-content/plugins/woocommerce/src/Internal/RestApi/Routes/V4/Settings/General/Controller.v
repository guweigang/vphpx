import rt

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Controller {
	rt.PhpObjectBase
pub mut:
		rest_base rt.PhpVal = rt.new_string('settings/general')
		settings_general_instance rt.PhpVal = rt.new_null()
		schema rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Controller) init(mut var_schema Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema)  {
	this.schema = var_schema.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Controller) get_settings_general_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(this.settings_general_instance.is_null())) {
		this.settings_general_instance = create_wc_settings_general()
	}
	return this.settings_general_instance
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this), 'namespace'), '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_schema' }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [rt.new_string('settings'), rt.new_string('read')]))))) {
		return (create_wp_error(rt.new_string('rest_forbidden'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to access general settings.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [rt.new_string('settings'), rt.new_string('edit')]))))) {
		return (create_wp_error(rt.new_string('rest_forbidden'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit general settings.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_settings := this.get_all_settings()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Exception') {
		mut var_e := var_e_1.dup()
		return create_wp_error(rt.new_string('woocommerce_rest_general_settings_error'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	mut var_response := this.get_item_response(var_settings.dup(), mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	return rt.call_function('rest_ensure_response', [var_response.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_params := rt.call_method(var_request, 'get_json_params', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_params.dup().is_array()))))) || !rt.is_true(var_params))) {
		return create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('__', [rt.new_string('Invalid or empty request body.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_values_to_update := rt.new_array()
	if rt.is_true(rt.new_bool(var_params.array_isset(rt.new_string('values')) && rt.is_true(rt.new_bool(var_params.array_get('values').is_array())))) {
		var_values_to_update = var_params.array_get('values')
	} else {
		var_values_to_update = var_params.dup()
	}
	if var_values_to_update.array_isset(rt.new_string('woocommerce_share_key_display')) {
		var_values_to_update.array_unset(rt.new_string('woocommerce_share_key_display'))
	}
	mut var_settings := this.get_all_settings()
	mut var_settings_by_id := rt.call_function('array_column', [var_settings.dup(), rt.new_null(), rt.new_string('id')])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_def := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_type := if !(var_def.array_get('type')).is_null() { var_def.array_get('type') } else { rt.new_string('') }
	return rt.new_bool(var_def.array_isset(rt.new_string('id')) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_type.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'title' }, rt.ArrayItem{ key: none, val: 'sectionend' }]), rt.new_bool(true)]))))))
	}
	var_settings_by_id = rt.call_function('array_filter', [var_settings_by_id.dup(), rt.new_closure(closure_1_fn)])
	mut var_valid_setting_ids := rt.func_array_keys(var_settings_by_id.dup())
	mut var_validated_settings := rt.new_array()
	{
		mut iter_1 := var_values_to_update.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_setting_value := item_1.val
			mut var_setting_id := item_1.key
			var_setting_id = rt.call_function('sanitize_text_field', [var_setting_id.dup()])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_setting_id.dup(), var_valid_setting_ids.dup(), rt.new_bool(true)]))))) {
				continue
			}
			mut var_setting_definition := var_settings_by_id.array_get(var_setting_id)
			mut var_setting_type := if !(var_setting_definition.array_get('type')).is_null() { var_setting_definition.array_get('type') } else { rt.new_string('text') }
			mut var_sanitized_value := this.sanitize_setting_value(var_setting_type.dup(), var_setting_value.dup())
			mut var_validation_result := rt.new_bool(this.validate_setting_value(var_setting_id.dup(), var_sanitized_value.dup()))
			if rt.is_true(rt.call_function('is_wp_error', [var_validation_result.dup()])) {
				return var_validation_result.dup()
			}
			var_validated_settings.array_set(var_setting_id, var_sanitized_value.dup())
		}
	}
	mut var_updated_settings := rt.new_array()
	{
		mut iter_1 := var_validated_settings.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_setting_id := item_1.key
			mut var_update_result := rt.call_function('update_option', [var_setting_id.dup(), var_value.dup()])
			if rt.is_true(var_update_result) {
				var_updated_settings.array_push(var_setting_id.dup())
			}
		}
	}
	if !(!rt.is_true(var_updated_settings)) {
		rt.call_function('do_action', [rt.new_string('woocommerce_settings_updated'), var_updated_settings.dup(), this.rest_base])
	}
	var_settings = this.get_all_settings()
	mut var_response := this.get_item_response(var_settings.dup(), mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	return rt.call_function('rest_ensure_response', [var_response.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Controller) validate_setting_value(var_setting_id rt.PhpVal, var_value rt.PhpVal) bool {
	mut var_setting_id_mutated := var_setting_id
	mut var_value_mutated := var_value
	mut switch_val_1 := var_setting_id_mutated
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_price_num_decimals'))) {
		mut var_int := rt.call_function('filter_var', [var_value_mutated.dup(), rt.get_constant('FILTER_VALIDATE_INT')])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), var_int)) || rt.is_true(rt.less(var_int, rt.new_int(0))))) || rt.is_true(rt.greater(var_int, rt.new_int(10))))) {
			return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('__', [rt.new_string('Number of decimals must be between 0 and 10.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_default_country'))) {
		if !(this.validate_country_or_state_code(var_value_mutated.dup())) {
			return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('__', [rt.new_string('Invalid country/state format.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_allowed_countries'))) {
		mut var_valid_options := rt.create_array([rt.ArrayItem{ key: none, val: 'all' }, rt.ArrayItem{ key: none, val: 'all_except' }, rt.ArrayItem{ key: none, val: 'specific' }])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_value_mutated.dup(), var_valid_options.dup(), rt.new_bool(true)]))))) {
			return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('__', [rt.new_string('Invalid selling location option.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_ship_to_countries'))) {
		var_valid_options = rt.create_array([rt.ArrayItem{ key: none, val: '' }, rt.ArrayItem{ key: none, val: 'all' }, rt.ArrayItem{ key: none, val: 'specific' }, rt.ArrayItem{ key: none, val: 'disabled' }])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_value_mutated.dup(), var_valid_options.dup(), rt.new_bool(true)]))))) {
			return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('__', [rt.new_string('Invalid shipping location option.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_specific_allowed_countries'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_specific_ship_to_countries'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_array()))))) {
			return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('__', [rt.new_string('Expected an array of country codes.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
		}
		{
			mut iter_1 := var_value_mutated.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_code := item_1.val
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_code.dup().is_string()))))) || !(this.validate_country_or_state_code(var_code.dup())))) {
					return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('__', [rt.new_string('Invalid country code in list.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
				}
			}
		}
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Controller) sanitize_setting_value(var_setting_type rt.PhpVal, var_value rt.PhpVal)  {
	mut var_setting_type_mutated := var_setting_type
	mut var_value_mutated := var_value
	mut var_type_map := rt.create_array([rt.ArrayItem{ key: 'single_select_country', val: 'select' }, rt.ArrayItem{ key: 'multi_select_countries', val: 'multiselect' }])
	var_setting_type_mutated = if !(var_type_map.array_get(var_setting_type_mutated)).is_null() { var_type_map.array_get(var_setting_type_mutated) } else { var_setting_type_mutated }
	mut switch_val_2 := var_setting_type_mutated
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('text'))) {
		return rt.call_function('sanitize_text_field', [var_value_mutated.dup()])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('number'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_long() || var_value_mutated.dup().is_double()))))) {
			return rt.new_int(0)
		}
		return if !(rt.call_function('filter_var', [var_value_mutated.dup(), rt.get_constant('FILTER_VALIDATE_INT'), rt.get_constant('FILTER_NULL_ON_FAILURE')])).is_null() { rt.call_function('filter_var', [var_value_mutated.dup(), rt.get_constant('FILTER_VALIDATE_INT'), rt.get_constant('FILTER_NULL_ON_FAILURE')]) } else { rt.new_float(var_value_mutated.dup().to_f64()) }
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('checkbox'))) {
		if rt.is_true(rt.new_bool(var_value_mutated.dup().is_array())) {
			var_value_mutated = rt.new_bool(rt.new_bool(!(!rt.is_true(var_value_mutated))))
			// unsupported statement: Stmt_Nop
		}
		return rt.call_function('wc_bool_to_string', [var_value_mutated.dup()])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('select'))) {
		return rt.call_function('sanitize_text_field', [var_value_mutated.dup()])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('multiselect'))) {
		if rt.is_true(rt.new_bool(var_value_mutated.dup().is_array())) {
			return rt.call_function('array_map', [rt.new_string('sanitize_text_field'), var_value_mutated.dup()])
		}
		if rt.is_true(rt.new_bool(var_value_mutated.dup().is_string())) {
			return rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('sanitize_text_field', [var_value_mutated.dup()]) }])
		}
		if rt.is_true(rt.call_function('is_scalar', [var_value_mutated.dup()])) {
			return rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('sanitize_text_field', [// unsupported expression: Expr_Cast_String]) }])
		}
		return rt.new_array()
	} else {
		return rt.call_function('sanitize_text_field', [var_value_mutated.dup()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Controller) get_all_settings() rt.PhpVal {
	mut var_settings_instance := this.get_settings_general_instance()
	mut var_sections := rt.call_method(var_settings_instance, 'get_sections', []rt.PhpVal{})
	mut var_settings := rt.new_array()
	{
		mut iter_1 := rt.func_array_keys(var_sections.dup()).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_section := item_1.val
			mut var_section_settings := rt.call_method(var_settings_instance, 'get_settings_for_section', [var_section.dup()])
			var_settings = rt.call_function('array_merge', [var_settings.dup(), var_section_settings.dup()])
		}
	}
	return var_settings.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Controller) validate_country_or_state_code(var_country_or_state rt.PhpVal) bool {
	mut var_country := rt.new_null()
	mut var_state := rt.new_null()
	// unsupported assign target: Expr_List
	if rt.is_true(rt.identical(rt.new_string(''), var_country)) {
		return false
	}
	mut var_country_codes := rt.func_array_keys(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_countries', []rt.PhpVal{}))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_country.dup(), var_country_codes.dup(), rt.new_bool(true)]))))) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_string(''), var_state)) {
		return true
	}
	mut var_states_for_country := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_states', [var_country.dup()])
	if !rt.is_true(var_states_for_country) {
		return false
	}
	return (rt.new_bool(var_states_for_country.array_isset(var_state))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Controller) get_schema() rt.PhpVal {
	return rt.call_method(this.schema, 'get_item_schema', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Controller) get_item_schema() rt.PhpVal {
	return this.get_schema()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Controller) get_item_response(var_item rt.PhpVal, mut var_request Class_WP_REST_Request) rt.PhpVal {
	return rt.call_method(, 'get_item_response', [.dup(), ])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Controller) get_endpoint_args_for_item_schema(var_method rt.PhpVal) rt.PhpVal {
	return 
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController {
	rt.PhpObjectBase
}

struct Class_WC_Settings_General {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_settings_general_controller() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Controller {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		rest_base: rt.new_string('settings/general')
		settings_general_instance: rt.new_null()
		schema: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_abstractcontroller() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_settings_general() &Class_WC_Settings_General {
	mut obj := &Class_WC_Settings_General{
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

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Schema_GeneralSettingsSchema](if args.len > 0 { args[0] } else { rt.new_null() })
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_settings_general_instance' {
			return this.get_settings_general_instance()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_item_permissions_check(dispatch_arg_0))
		}
		'update_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.update_item_permissions_check(dispatch_arg_0))
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'validate_setting_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.validate_setting_value(dispatch_arg_0, dispatch_arg_1))
		}
		'sanitize_setting_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.sanitize_setting_value(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_all_settings' {
			return this.get_all_settings()
		}
		'validate_country_or_state_code' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_country_or_state_code(dispatch_arg_0))
		}
		'get_schema' {
			return this.get_schema()
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.get_item_response(dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_endpoint_args_for_item_schema' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_endpoint_args_for_item_schema(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		'settings_general_instance' { return this.settings_general_instance }
		'schema' { return this.schema }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_base' { this.rest_base = val; return true }
		'settings_general_instance' { this.settings_general_instance = val; return true }
		'schema' { this.schema = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Settings_General) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Settings_General) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Settings_General) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_restapi_routes_v4_settings_general_controller_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
