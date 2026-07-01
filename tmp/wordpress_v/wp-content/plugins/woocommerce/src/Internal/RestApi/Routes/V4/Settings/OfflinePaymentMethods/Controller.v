import rt

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Controller {
	rt.PhpObjectBase
pub mut:
		rest_base rt.PhpVal = rt.new_string('settings/payments/offline-methods')
		payments rt.PhpVal = rt.new_null()
		item_schema rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Controller) init(mut var_payments Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments, mut var_schema Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_OfflinePaymentMethodSchema)  {
	this.payments = var_payments.dup()
	this.item_schema = var_schema.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Controller) register_routes()  {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_function('sanitize_text_field', [var_value.dup()])
	}
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this), 'namespace'), '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.call_function('array_merge', [this.get_collection_params(), rt.create_array([rt.ArrayItem{ key: 'location', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Country code to retrieve offline payment methods for.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.new_closure(closure_1_fn) }]) }])]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [rt.new_string('payment_gateways'), rt.new_string('read')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_read'), rt.call_function('__', [rt.new_string('Sorry, you cannot list resources.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_offline_methods := this.get_offline_payment_methods_data(var_request.dup())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Exception') {
		mut var_e := var_e_1.dup()
		return create_wp_error(rt.new_string('woocommerce_rest_offline_payment_methods_error'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	if rt.is_true(rt.call_function('is_wp_error', [var_offline_methods.dup()])) {
		return var_offline_methods.dup()
	}
	mut var_response_data := rt.create_array([rt.ArrayItem{ key: 'id', val: 'payments/offline-methods' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Offline Payment Methods'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Manage offline payment methods available for your store.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'values', val: rt.new_array() }, rt.ArrayItem{ key: 'groups', val: rt.create_array([rt.ArrayItem{ key: 'payment_methods', val: rt.new_array() }]) }])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_offline_methods.dup().is_array()))))) {
		return create_wp_error(rt.new_string('woocommerce_rest_invalid_data'), rt.call_function('__', [rt.new_string('Invalid payment methods data received.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
	}
	{
		mut iter_1 := var_offline_methods.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_method := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_method.dup().is_array()))))) {
				continue
			}
			mut var_method_id := if !(var_method.array_get('id')).is_null() { var_method.array_get('id') } else { rt.new_string('') }
			if rt.is_true(rt.new_bool(!rt.is_true(var_method_id) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_method_id.dup().is_string()))))))) {
				continue
			}
			mut var_enabled_state := rt.new_bool(rt.new_bool(false))
			if rt.is_true(rt.new_bool(var_method.array_isset(rt.new_string('state')) && rt.is_true(rt.new_bool(var_method.array_get('state').is_array())))) {
				var_enabled_state = if !(var_method.array_get('state').array_get('enabled')).is_null() { var_method.array_get('state').array_get('enabled') } else { rt.new_bool(false) }
			}
			if rt.is_true(rt.new_bool(var_enabled_state.dup().is_array())) {
				var_enabled_state = if !(var_enabled_state.array_get('value')).is_null() { var_enabled_state.array_get('value') } else { rt.new_bool(false) }
			}
			if rt.is_true(rt.new_bool(var_enabled_state.dup().is_string())) {
				var_enabled_state = rt.call_function('wc_string_to_bool', [var_enabled_state.dup()])
			} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_enabled_state.dup().is_bool()))))) {
				var_enabled_state = // unsupported expression: Expr_Cast_Bool
			}
			var_response_data.array_get_mut('values').array_set(var_method_id, var_enabled_state.dup())
			var_response_data.array_get_mut('groups').array_get_mut('payment_methods').array_set(var_method_id, rt.create_array([rt.ArrayItem{ key: 'id', val: var_method_id }, rt.ArrayItem{ key: '_order', val: if var_method.array_isset(rt.new_string('_order')) { rt.call_function('absint', [var_method.array_get('_order')]) } else { rt.new_int(0) } }, rt.ArrayItem{ key: 'title', val: rt.call_function('sanitize_text_field', [if !(var_method.array_get('title')).is_null() { var_method.array_get('title') } else { rt.new_string('') }]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('wp_kses_post', [if !(var_method.array_get('description')).is_null() { var_method.array_get('description') } else { rt.new_string('') }]) }, rt.ArrayItem{ key: 'icon', val: rt.call_function('esc_url_raw', [if !(var_method.array_get('icon')).is_null() { var_method.array_get('icon') } else { rt.new_string('') }]) }, rt.ArrayItem{ key: 'state', val: rt.call_function('array_map', [rt.new_string('rest_sanitize_boolean'), rt.call_function('wp_parse_args', [if rt.is_true(rt.new_bool(if !(var_method.array_get('state')).is_null() { var_method.array_get('state') } else { rt.new_null() }.is_array())) { var_method.array_get('state') } else { rt.new_array() }, rt.create_array([rt.ArrayItem{ key: 'enabled', val: false }, rt.ArrayItem{ key: 'account_connected', val: false }, rt.ArrayItem{ key: 'needs_setup', val: false }, rt.ArrayItem{ key: 'test_mode', val: false }, rt.ArrayItem{ key: 'dev_mode', val: false }])])]) }, rt.ArrayItem{ key: 'management', val: this.sanitize_management_field(if !(var_method.array_get('management')).is_null() { var_method.array_get('management') } else { rt.new_array() }) }]))
		}
	}
	return rt.call_function('rest_ensure_response', [var_response_data.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Controller) get_offline_payment_methods_data(var_request rt.PhpVal) rt.PhpVal {
	mut var_provider := rt.new_null()
	mut var_location := rt.call_function('sanitize_text_field', [rt.call_method(var_request, 'get_param', [rt.new_string('location')])])
	if !rt.is_true(var_location) {
		var_location = rt.call_method(this.payments, 'get_country', []rt.PhpVal{})
	}
	mut var_providers := rt.call_method(this.payments, 'get_payment_providers', [var_location.dup()])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Exception') {
		mut var_e := var_e_2.dup()
		return create_wp_error(rt.new_string('woocommerce_rest_payment_providers_error'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	if rt.is_true(rt.call_function('is_wp_error', [var_providers.dup()])) {
		return var_providers.dup()
	}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_provider := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(var_provider.array_isset(rt.new_string('_type')) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.type_offline_pm(), var_provider.array_get('_type'))))
	}
	mut var_provider := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(var_provider.array_isset(rt.new_string('_type')) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.type_offline_pm(), var_provider.array_get('_type'))))
	}
	mut var_offline_payment_providers := rt.call_function('array_values', [rt.call_function('array_filter', [var_providers.dup(), rt.new_closure(closure_2_fn)])])
	return var_offline_payment_providers.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Controller) get_schema() rt.PhpVal {
	return rt.call_method(this.item_schema, 'get_item_schema', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Controller) get_item_response(var_item rt.PhpVal, mut var_request Class_WP_REST_Request) rt.PhpVal {
	return rt.call_method(this.item_schema, 'get_item_response', [var_item.dup(), var_request])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Controller) sanitize_management_field(var_management rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_management.dup().is_array()))))) {
		return rt.create_array([rt.ArrayItem{ key: '_links', val: rt.new_array() }])
	}
	mut var_sanitized := rt.create_array([rt.ArrayItem{ key: '_links', val: rt.new_array() }])
	if rt.is_true(rt.new_bool(var_management.array_isset(rt.new_string('_links')) && rt.is_true(rt.new_bool(var_management.array_get('_links').is_array())))) {
		{
			mut iter_1 := var_management.array_get('_links').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_link := item_1.val
				mut var_key := item_1.key
				mut var_sanitized_key := rt.call_function('sanitize_key', [var_key.dup()])
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_link.dup().is_array())) && var_link.array_isset(rt.new_string('href')))) {
					var_sanitized.array_get_mut('_links').array_set(var_sanitized_key, rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('esc_url_raw', [var_link.array_get('href')]) }]))
				} else if rt.is_true(rt.new_bool(var_link.dup().is_string())) {
					var_sanitized.array_get_mut('_links').array_set(var_sanitized_key, rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('esc_url_raw', [var_link.dup()]) }]))
				}
			}
		}
	}
	return var_sanitized.dup()
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_settings_offlinepaymentmethods_controller() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Controller {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		rest_base: rt.new_string('settings/payments/offline-methods')
		payments: rt.new_null()
		item_schema: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_abstractcontroller() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController{
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

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_OfflinePaymentMethodSchema](if args.len > 1 { args[1] } else { rt.new_null() })
			this.init(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_offline_payment_methods_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_offline_payment_methods_data(dispatch_arg_0)
		}
		'get_schema' {
			return this.get_schema()
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.get_item_response(dispatch_arg_0, mut dispatch_arg_1)
		}
		'sanitize_management_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sanitize_management_field(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		'payments' { return this.payments }
		'item_schema' { return this.item_schema }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_base' { this.rest_base = val; return true }
		'payments' { this.payments = val; return true }
		'item_schema' { this.item_schema = val; return true }
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


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_restapi_routes_v4_settings_offlinepaymentmethods_controller_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
