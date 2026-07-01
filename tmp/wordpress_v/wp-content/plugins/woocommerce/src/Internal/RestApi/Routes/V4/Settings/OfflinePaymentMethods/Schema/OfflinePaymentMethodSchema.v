import rt

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_OfflinePaymentMethodSchema.identifier() string {
	return 'offline_payment_method'
}
struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_OfflinePaymentMethodSchema {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_OfflinePaymentMethodSchema) get_item_schema_properties() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the settings group.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_OfflinePaymentMethodSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Title of the settings group.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_OfflinePaymentMethodSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Description of the settings group.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_OfflinePaymentMethodSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'values', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Current enabled state for all payment methods.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_OfflinePaymentMethodSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'additionalProperties', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }]) }]) }, rt.ArrayItem{ key: 'groups', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Grouped settings for offline payment methods.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_OfflinePaymentMethodSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'payment_methods', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Available offline payment methods.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_OfflinePaymentMethodSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'additionalProperties', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the payment method.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_OfflinePaymentMethodSchema.view_edit_context() }]) }, rt.ArrayItem{ key: '_order', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Sort order for the payment method.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_OfflinePaymentMethodSchema.view_edit_context() }]) }, rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Title of the payment method.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_OfflinePaymentMethodSchema.view_edit_context() }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Description of the payment method.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_OfflinePaymentMethodSchema.view_edit_context() }]) }, rt.ArrayItem{ key: 'icon', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Icon URL for the payment method.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'uri' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_OfflinePaymentMethodSchema.view_edit_context() }]) }, rt.ArrayItem{ key: 'state', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Current state configuration of the payment method.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_OfflinePaymentMethodSchema.view_edit_context() }, rt.ArrayItem{ key: 'additionalProperties', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }]) }]) }, rt.ArrayItem{ key: 'management', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Management options for the payment method.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_OfflinePaymentMethodSchema.view_edit_context() }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: '_links', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Management links for the payment method.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_OfflinePaymentMethodSchema.view_edit_context() }, rt.ArrayItem{ key: 'additionalProperties', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('URL for the management link.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'uri' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_OfflinePaymentMethodSchema.view_edit_context() }]) }]) }, rt.ArrayItem{ key: 'additionalProperties', val: false }]) }]) }]) }, rt.ArrayItem{ key: 'additionalProperties', val: false }]) }]) }]) }]) }]) }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_OfflinePaymentMethodSchema) get_item_response(var_item rt.PhpVal, mut var_request Class_WP_REST_Request, mut var_include_fields Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_array) rt.PhpVal {
	mut var_response := rt.cast_array(var_item)
	if !(!rt.is_true(var_include_fields)) {
		var_response = rt.call_function('array_intersect_key', [var_response.dup(), rt.call_function('array_flip', [var_include_fields])])
	}
	return var_response.dup()
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_settings_offlinepaymentmethods_schema_offlinepaymentmethodschema() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_OfflinePaymentMethodSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_OfflinePaymentMethodSchema{
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

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_OfflinePaymentMethodSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_item_schema_properties' {
			return this.get_item_schema_properties()
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.get_item_response(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_OfflinePaymentMethodSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Schema_OfflinePaymentMethodSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_restapi_routes_v4_settings_offlinepaymentmethods_schema_offlinepaymentmethodschema_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
