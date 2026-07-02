import rt

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Controller {
	rt.PhpObjectBase
pub mut:
	rest_base                rt.PhpVal = rt.new_string('settings/email')
	settings_emails_instance rt.PhpVal = rt.new_null()
	schema                   rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Controller) init(mut var_schema Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Schema_EmailSettingsSchema) {
	this.schema = var_schema
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Controller) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Controller', [
			'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
		], &this), 'namespace'),
		rt.new_string('/' + (this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item_permissions_check' },
				]) },
				rt.ArrayItem{
					key: 'args'
					val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable())
				},
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Controller', [
					'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_item_schema' },
			]) },
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Controller) get_settings_emails_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(this.settings_emails_instance.is_null())) {
		this.settings_emails_instance = create_wc_settings_emails()
	}
	return this.settings_emails_instance
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Controller) get_all_settings() rt.PhpVal {
	mut var_settings_instance := this.get_settings_emails_instance()
	mut var_sections := rt.call_method(var_settings_instance, 'get_sections', []rt.PhpVal{})
	mut var_settings := rt.new_array()
	mut iter_1 := rt.func_array_keys(var_sections.clone()).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_section := item_1.val
		mut var_section_settings := rt.call_method(var_settings_instance,
			'get_settings_for_section', [var_section.clone()])
		var_settings = rt.call_function('array_merge', [var_settings.clone(),
			var_section_settings.clone()])
	}
	return var_settings.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [
		rt.new_string('settings'),
		rt.new_string('read'),
	])))))
	{
		return (create_wp_error(rt.new_string('rest_forbidden'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to access email settings.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [
		rt.new_string('settings'),
		rt.new_string('edit'),
	])))))
	{
		return (create_wp_error(rt.new_string('rest_forbidden'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit email settings.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_settings := this.get_all_settings()
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
		'Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Exception')
	{
		mut var_e := var_e_1.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_email_settings_error'), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: 500 },
		])))
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
	mut var_response := this.get_item_response(var_settings.clone(), mut
		rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_params := rt.call_method(var_request, 'get_json_params', []rt.PhpVal{})
	if !(var_params.clone().is_array()) || !rt.is_true(var_params) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('__', [
			rt.new_string('Invalid or empty request body.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	mut var_values_to_update := rt.new_array()
	if var_params.array_isset(rt.new_string('values'))
		&& var_params.array_get(rt.new_string('values')).is_array() {
		var_values_to_update = var_params.array_get(rt.new_string('values'))
	} else {
		var_values_to_update = var_params.clone()
	}
	mut var_settings := this.get_all_settings()
	mut var_settings_by_id := rt.call_function('array_column', [
		var_settings.clone(), rt.new_null(), rt.new_string('id')])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_def := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_type := if !(var_def.array_get(rt.new_string('type'))).is_null() {
			var_def.array_get(rt.new_string('type'))
		} else {
			rt.new_string('')
		}
		return rt.new_bool(var_def.array_isset(rt.new_string('id'))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_type.clone(), Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Schema_EmailSettingsSchema.non_editable_types(), rt.new_bool(true)]))))))
	}
	var_settings_by_id = rt.call_function('array_filter', [var_settings_by_id.clone(),
		rt.new_closure(closure_1_fn)])
	mut var_valid_setting_ids := rt.func_array_keys(var_settings_by_id.clone())
	mut var_validated_settings := rt.new_array()
	mut var_reply_to_enabled := rt.call_function('get_option', [
		rt.new_string('woocommerce_email_reply_to_enabled'),
		rt.new_string('no'),
	])
	if var_values_to_update.array_isset(rt.new_string('woocommerce_email_reply_to_enabled')) {
		var_reply_to_enabled = rt.call_function('wc_bool_to_string', [
			var_values_to_update.array_get(rt.new_string('woocommerce_email_reply_to_enabled')),
		])
	}
	var_values_to_update = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_emails_api_settings_schema_validate_and_sanitize_settings'),
		var_values_to_update.clone(),
		var_settings_by_id.clone(),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_values_to_update.clone()])) {
		return var_values_to_update.clone()
	}
	if !(var_values_to_update.clone().is_array()) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_invalid_filter_result'), rt.call_function('__', [
			rt.new_string('Invalid result from filter.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])))
	}
	mut iter_2 := var_values_to_update.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_setting_value := item_2.val
		mut var_setting_id := item_2.key
		var_setting_id = rt.call_function('sanitize_text_field', [
			var_setting_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_setting_id.clone(), var_valid_setting_ids.clone(),
			rt.new_bool(true)])))))
		{
			continue
		}
		mut var_setting_definition := var_settings_by_id.array_get(var_setting_id)
		mut var_setting_type := if !(var_setting_definition.array_get(rt.new_string('type'))).is_null() {
			var_setting_definition.array_get(rt.new_string('type'))
		} else {
			rt.new_string('text')
		}
		mut var_sanitized_value := rt.new_int(this.sanitize_setting_value(var_setting_type.clone(),
			var_setting_value.clone()))
		mut var_validation_result := rt.new_bool(this.validate_setting_value(var_setting_id.clone(),
			var_sanitized_value.clone(), var_reply_to_enabled.clone()))
		if rt.is_true(rt.call_function('is_wp_error', [var_validation_result.clone()])) {
			return var_validation_result.clone()
		}
		var_validated_settings.array_set(var_setting_id, var_sanitized_value.clone())
	}
	mut var_updated_settings := rt.new_array()
	mut iter_3 := var_validated_settings.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_value := item_3.val
		mut var_setting_id := item_3.key
		mut var_update_result := rt.call_function('update_option', [
			var_setting_id.clone(), var_value.clone()])
		if rt.is_true(var_update_result) {
			var_updated_settings.array_push(var_setting_id.clone())
		}
	}
	if !(!rt.is_true(var_updated_settings)) {
		rt.call_function('do_action', [rt.new_string('woocommerce_settings_updated'),
			var_updated_settings.clone(), this.rest_base])
	}
	var_settings = this.get_all_settings()
	mut var_response := this.get_item_response(var_settings.clone(), mut
		rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Controller) validate_setting_value(var_setting_id rt.PhpVal, var_value rt.PhpVal, var_reply_to_enabled rt.PhpVal) bool {
	mut var_setting_id_mutated := var_setting_id
	mut var_value_mutated := var_value
	mut var_reply_to_enabled_mutated := var_reply_to_enabled
	mut var_check_reply_to := rt.identical(rt.new_string('yes'), var_reply_to_enabled_mutated)
	mut switch_val_1 := var_setting_id_mutated
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_email_from_name'))) {
		if !rt.is_true(var_value_mutated) || !(var_value_mutated.clone().is_string()) {
			return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('__', [
				rt.new_string('Email sender name cannot be empty.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_email_from_address'))) {
		if !rt.is_true(var_value_mutated)
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [var_value_mutated.clone()]))))) {
			return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('__', [
				rt.new_string('Please enter a valid email address.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_email_reply_to_enabled'))) {
		if rt.is_true(rt.new_bool(var_value_mutated.clone().is_string())) {
			var_value_mutated = rt.call_function('filter_var', [
				var_value_mutated.clone(), rt.get_constant('FILTER_VALIDATE_BOOLEAN'),
				rt.get_constant('FILTER_NULL_ON_FAILURE')])
		}
		if !(var_value_mutated.clone().is_bool())
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_value_mutated)))) {
			return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('__', [
				rt.new_string('Reply-to enabled must be a boolean value.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_email_reply_to_name'))) {
		if rt.is_true(var_check_reply_to) && !rt.is_true(var_value_mutated)
			|| !(var_value_mutated.clone().is_string()) {
			return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('__', [
				rt.new_string('Reply-to name cannot be empty when reply-to is enabled.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_email_reply_to_address'))) {
		if rt.is_true(var_check_reply_to) && !rt.is_true(var_value_mutated)
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [var_value_mutated.clone()]))))) {
			return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('__', [
				rt.new_string('Please enter a valid reply-to email address.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
		}
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Controller) sanitize_setting_value(var_setting_type rt.PhpVal, var_value rt.PhpVal) i64 {
	mut var_setting_type_mutated := var_setting_type
	mut var_value_mutated := var_value
	mut switch_val_2 := var_setting_type_mutated
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('text')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('select')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('color'))) {
		return (rt.call_function('sanitize_text_field', [var_value_mutated.clone()])).to_i64()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('email'))) {
		return (rt.call_function('sanitize_email', [var_value_mutated.clone()])).to_i64()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('checkbox'))) {
		if rt.is_true(rt.new_bool(var_value_mutated.clone().is_array())) {
			var_value_mutated = rt.new_bool(!(!rt.is_true(var_value_mutated)))
		}
		return (rt.call_function('wc_bool_to_string', [var_value_mutated.clone()])).to_i64()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('number'))) {
		if !(var_value_mutated.clone().is_long() || var_value_mutated.clone().is_double()) {
			return 0
		}
		return (if !(rt.call_function('filter_var', [var_value_mutated.clone(),
			rt.get_constant('FILTER_VALIDATE_INT'), rt.get_constant('FILTER_NULL_ON_FAILURE')])).is_null() {
			rt.call_function('filter_var', [var_value_mutated.clone(),
				rt.get_constant('FILTER_VALIDATE_INT'), rt.get_constant('FILTER_NULL_ON_FAILURE')])
		} else {
			rt.new_float(var_value_mutated.clone().to_f64())
		}).to_i64()
	} else {
		return (rt.call_function('sanitize_text_field', [var_value_mutated.clone()])).to_i64()
	}
	return i64(0)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Controller) get_schema() rt.PhpVal {
	return rt.call_method(this.schema, 'get_item_schema', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Controller) get_item_schema() rt.PhpVal {
	return this.get_schema()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Controller) get_item_response(var_item rt.PhpVal, mut var_request Class_WP_REST_Request) rt.PhpVal {
	return rt.call_method(this.schema, 'get_item_response', [
		var_item.clone(), var_request])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Controller) get_endpoint_args_for_item_schema(var_method rt.PhpVal) rt.PhpVal {
	return rt.call_function('rest_get_endpoint_args_for_schema', [
		this.get_item_schema(), var_method.clone()])
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController {
	rt.PhpObjectBase
}

struct Class_WC_Settings_Emails {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_settings_email_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Controller {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Controller{
		PhpObjectBase:            rt.PhpObjectBase{}
		rest_base:                rt.new_string('settings/email')
		settings_emails_instance: rt.new_null()
		schema:                   rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_abstractcontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_settings_emails(_args ...rt.PhpVal) &Class_WC_Settings_Emails {
	mut obj := &Class_WC_Settings_Emails{
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

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Schema_EmailSettingsSchema](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_settings_emails_instance' {
			return this.get_settings_emails_instance()
		}
		'get_all_settings' {
			return this.get_all_settings()
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
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.validate_setting_value(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2))
		}
		'sanitize_setting_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(this.sanitize_setting_value(dispatch_arg_0, dispatch_arg_1))
		}
		'get_schema' {
			return this.get_schema()
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.get_item_response(dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_endpoint_args_for_item_schema' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_endpoint_args_for_item_schema(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		'settings_emails_instance' { return this.settings_emails_instance }
		'schema' { return this.schema }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_base' {
			this.rest_base = val
			return true
		}
		'settings_emails_instance' {
			this.settings_emails_instance = val
			return true
		}
		'schema' {
			this.schema = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_WC_Settings_Emails) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Settings_Emails) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Settings_Emails) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
