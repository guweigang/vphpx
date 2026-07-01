import rt

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Controller {
	rt.PhpObjectBase
pub mut:
		rest_base rt.PhpVal = rt.new_string('settings/payment-gateways')
		post_type rt.PhpVal = rt.new_string('payment_gateways')
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Controller) get_schema() rt.PhpVal {
	mut var_schema := create_automattic_woocommerce_internal_restapi_routes_v4_settings_paymentgateways_schema_paymentgatewaysettingsschema()
	return rt.call_method(var_schema, 'get_item_schema', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this), 'namespace'), '/' + (this.rest_base).str() + '/(?P<id>[\\w-]+)', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'enabled', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Gateway enabled status.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'required', val: false }]) }, rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Gateway title.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: false }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Gateway description.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: false }]) }, rt.ArrayItem{ key: 'order', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Gateway sort order.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'required', val: false }]) }, rt.ArrayItem{ key: 'values', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Flat key-value mapping of all setting field values.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'required', val: false }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'pattern', val: '^[\\w-]+$' }]) }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_id := var_request.array_get('id')
	mut var_payment_gateways := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways'), 'payment_gateways', []rt.PhpVal{})
	if !(var_payment_gateways.array_isset(var_id)) {
		return create_wp_error(rt.new_string('woocommerce_rest_payment_gateway_invalid_id'), rt.call_function('__', [rt.new_string('Invalid payment gateway ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_gateway := var_payment_gateways.array_get(var_id)
	mut var_schema := this.get_schema_for_gateway((var_id).str())
	mut var_data := rt.call_method(var_schema, 'get_item_response', [var_gateway.dup(), var_request.dup()])
	return rt.call_function('rest_ensure_response', [var_data.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [this.post_type, rt.new_string('read')]))))) {
		return (this.get_authentication_error_by_method(rt.call_method(var_request, 'get_method', []rt.PhpVal{}))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [rt.new_string('payment_gateways'), rt.new_string('edit')]))))) {
		return (this.get_authentication_error_by_method(rt.call_method(var_request, 'get_method', []rt.PhpVal{}))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Controller) get_payment_gateway(var_id rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
	mut var_payment_gateways := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways'), 'payment_gateways', []rt.PhpVal{})
	return if !(var_payment_gateways.array_get(var_id_mutated)).is_null() { var_payment_gateways.array_get(var_id_mutated) } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Controller) get_schema_for_gateway(gateway_id string)  {
	mut switch_val_1 := rt.new_string(gateway_id)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('bacs'))) {
		return create_automattic_woocommerce_internal_restapi_routes_v4_settings_paymentgateways_schema_bacsgatewaysettingsschema()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('cheque'))) {
		return create_automattic_woocommerce_internal_restapi_routes_v4_settings_paymentgateways_schema_chequegatewaysettingsschema()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('cod'))) {
		return create_automattic_woocommerce_internal_restapi_routes_v4_settings_paymentgateways_schema_codgatewaysettingsschema()
	} else {
		return create_automattic_woocommerce_internal_restapi_routes_v4_settings_paymentgateways_schema_paymentgatewaysettingsschema()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_id := var_request.array_get('id')
	mut var_gateway := this.get_payment_gateway(var_id.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_gateway)))) {
		return create_wp_error(rt.new_string('woocommerce_rest_payment_gateway_invalid_id'), rt.call_function('__', [rt.new_string('Invalid payment gateway ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_schema := this.get_schema_for_gateway((var_id).str())
	mut var_params := rt.call_method(var_request, 'get_params', []rt.PhpVal{})
	mut var_values_to_update := if !(var_params.array_get('values')).is_null() { var_params.array_get('values') } else { rt.new_array() }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_values_to_update.dup().is_array()))))) {
		var_values_to_update = rt.new_array()
	}
	rt.call_method(var_gateway, 'init_form_fields', []rt.PhpVal{})
	mut var_enabled := if !(var_params.array_get('enabled')).is_null() { var_params.array_get('enabled') } else { if !(var_values_to_update.array_get('enabled')).is_null() { var_values_to_update.array_get('enabled') } else { rt.new_null() } }
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.set_property(var_gateway, 'enabled', rt.call_function('wc_bool_to_string', [var_enabled.dup()]))
		rt.get_property(var_gateway, 'settings').array_set('enabled', rt.get_property(var_gateway, 'enabled'))
		var_values_to_update.array_unset(rt.new_string('enabled'))
	}
	mut var_title := if !(var_params.array_get('title')).is_null() { var_params.array_get('title') } else { if !(var_values_to_update.array_get('title')).is_null() { var_values_to_update.array_get('title') } else { rt.new_null() } }
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.set_property(var_gateway, 'title', rt.call_function('sanitize_text_field', [var_title.dup()]))
		rt.get_property(var_gateway, 'settings').array_set('title', rt.get_property(var_gateway, 'title'))
		var_values_to_update.array_unset(rt.new_string('title'))
	}
	mut var_description := if !(var_params.array_get('description')).is_null() { var_params.array_get('description') } else { if !(var_values_to_update.array_get('description')).is_null() { var_values_to_update.array_get('description') } else { rt.new_null() } }
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.set_property(var_gateway, 'description', rt.call_function('wp_kses_post', [var_description.dup()]))
		rt.get_property(var_gateway, 'settings').array_set('description', rt.get_property(var_gateway, 'description'))
		var_values_to_update.array_unset(rt.new_string('description'))
	}
	mut var_order_to_update := rt.new_null()
	mut var_order_value := if !(var_params.array_get('order')).is_null() { var_params.array_get('order') } else { if !(var_values_to_update.array_get('order')).is_null() { var_values_to_update.array_get('order') } else { rt.new_null() } }
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_order_to_update = rt.call_function('absint', [var_order_value.dup()])
		var_values_to_update.array_unset(rt.new_string('order'))
	}
	mut var_standard_values := rt.new_array()
	mut var_special_values := rt.new_array()
	{
		mut iter_1 := var_values_to_update.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.call_method(var_schema, 'is_special_field', [var_key.dup()])) {
				var_special_values.array_set(var_key, var_value.dup())
			} else if rt.get_property(var_gateway, 'form_fields').array_isset(var_key) {
				var_standard_values.array_set(var_key, var_value.dup())
			}
			// unsupported statement: Stmt_Nop
		}
	}
	mut var_validated_settings := rt.call_method(var_schema, 'validate_and_sanitize_settings', [var_gateway.dup(), var_standard_values.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_validated_settings.dup()])) {
		return var_validated_settings.dup()
	}
	mut var_validated_special := rt.call_method(var_schema, 'validate_and_sanitize_special_fields', [var_gateway.dup(), var_special_values.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_validated_special.dup()])) {
		return var_validated_special.dup()
	}
	{
		mut iter_1 := var_validated_settings.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			rt.get_property(var_gateway, 'settings').array_set(var_key, var_value.dup())
		}
	}
	rt.call_function('update_option', [rt.call_method(var_gateway, 'get_option_key', []rt.PhpVal{}), rt.get_property(var_gateway, 'settings')])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_gateway_order := rt.cast_array(rt.call_function('get_option', [rt.new_string('woocommerce_gateway_order'), rt.new_array()]))
		var_gateway_order.array_set(var_id, var_order_to_update.dup())
		rt.call_function('update_option', [rt.new_string('woocommerce_gateway_order'), var_gateway_order.dup()])
	}
	rt.call_method(var_schema, 'update_special_fields', [var_gateway.dup(), var_validated_special.dup()])
	mut var_data := rt.call_method(var_schema, 'get_item_response', [var_gateway.dup(), var_request.dup()])
	return rt.call_function('rest_ensure_response', [var_data.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Controller) get_item_response(var_item rt.PhpVal, mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_schema := this.get_schema_for_gateway((rt.get_property(var_item, 'id')).str())
	return rt.call_method(var_schema, 'get_item_response', [var_item.dup(), var_request])
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_PaymentGatewaySettingsSchema {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_BacsGatewaySettingsSchema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_ChequeGatewaySettingsSchema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_CodGatewaySettingsSchema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_settings_paymentgateways_controller() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Controller {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		rest_base: rt.new_string('settings/payment-gateways')
		post_type: rt.new_string('payment_gateways')
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_abstractcontroller() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_settings_paymentgateways_schema_paymentgatewaysettingsschema() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_PaymentGatewaySettingsSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_PaymentGatewaySettingsSchema{
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

fn create_automattic_woocommerce_internal_restapi_routes_v4_settings_paymentgateways_schema_bacsgatewaysettingsschema() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_BacsGatewaySettingsSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_BacsGatewaySettingsSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_settings_paymentgateways_schema_chequegatewaysettingsschema() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_ChequeGatewaySettingsSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_ChequeGatewaySettingsSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_settings_paymentgateways_schema_codgatewaysettingsschema() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_CodGatewaySettingsSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_CodGatewaySettingsSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_schema' {
			return this.get_schema()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'update_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.update_item_permissions_check(dispatch_arg_0))
		}
		'get_payment_gateway' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_payment_gateway(dispatch_arg_0)
		}
		'get_schema_for_gateway' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.get_schema_for_gateway(dispatch_arg_0)
			return rt.new_null()
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.get_item_response(dispatch_arg_0, mut dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		'post_type' { return this.post_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_base' { this.rest_base = val; return true }
		'post_type' { this.post_type = val; return true }
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


fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_PaymentGatewaySettingsSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_PaymentGatewaySettingsSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_PaymentGatewaySettingsSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_BacsGatewaySettingsSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_BacsGatewaySettingsSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_BacsGatewaySettingsSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_ChequeGatewaySettingsSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_ChequeGatewaySettingsSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_ChequeGatewaySettingsSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_CodGatewaySettingsSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_CodGatewaySettingsSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_CodGatewaySettingsSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_restapi_routes_v4_settings_paymentgateways_controller_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
