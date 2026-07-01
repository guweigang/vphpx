import rt

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_FulfillmentSchema.identifier() string {
	return 'fulfillment'
}
struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_FulfillmentSchema {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_FulfillmentSchema) get_item_schema_properties() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the fulfillment.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_FulfillmentSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'entity_type', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The type of entity for which the fulfillment is created.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_FulfillmentSchema.view_edit_context() }]) }, rt.ArrayItem{ key: 'entity_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the entity.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_FulfillmentSchema.view_edit_context() }]) }, rt.ArrayItem{ key: 'status', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The status of the fulfillment.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: 'unfulfilled' }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_FulfillmentSchema.view_edit_context() }]) }, rt.ArrayItem{ key: 'is_fulfilled', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether the fulfillment is fulfilled.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_FulfillmentSchema.view_edit_context() }]) }, rt.ArrayItem{ key: 'date_updated', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the fulfillment was last updated.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_FulfillmentSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'required', val: true }]) }, rt.ArrayItem{ key: 'date_deleted', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the fulfillment was deleted.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'anyOf', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'null' }]) }]) }, rt.ArrayItem{ key: 'default', val: rt.new_null() }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_FulfillmentSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'required', val: true }]) }, rt.ArrayItem{ key: 'meta_data', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta data for the fulfillment.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The unique identifier for the meta data. Set `0` for new records.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_FulfillmentSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'key', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The key of the meta data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_FulfillmentSchema.view_edit_context() }]) }, rt.ArrayItem{ key: 'value', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The value of the meta data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'number' }, rt.ArrayItem{ key: none, val: 'boolean' }, rt.ArrayItem{ key: none, val: 'object' }, rt.ArrayItem{ key: none, val: 'array' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_FulfillmentSchema.view_edit_context() }]) }]) }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_FulfillmentSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_FulfillmentSchema) get_item_response(var_fulfillment rt.PhpVal, mut var_request Class_WP_REST_Request, mut var_include_fields Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_array) rt.PhpVal {
	mut var_date_deleted := rt.call_method(var_fulfillment, 'get_date_deleted', []rt.PhpVal{})
	return rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_fulfillment, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'entity_type', val: rt.call_method(var_fulfillment, 'get_entity_type', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'entity_id', val: // unsupported expression: Expr_Cast_String }, rt.ArrayItem{ key: 'status', val: rt.call_method(var_fulfillment, 'get_status', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'is_fulfilled', val: rt.call_method(var_fulfillment, 'get_is_fulfilled', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'date_updated', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_fulfillment, 'get_date_updated', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'date_deleted', val: if rt.is_true(var_date_deleted) { rt.call_function('wc_rest_prepare_date_response', [var_date_deleted.dup()]) } else { rt.new_null() } }, rt.ArrayItem{ key: 'meta_data', val: rt.call_method(var_fulfillment, 'get_meta_data', []rt.PhpVal{}) }])
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_fulfillments_schema_fulfillmentschema() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_FulfillmentSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_FulfillmentSchema{
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

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_FulfillmentSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_item_schema_properties' {
			return this.get_item_schema_properties()
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.get_item_response(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_FulfillmentSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Schema_FulfillmentSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_restapi_routes_v4_fulfillments_schema_fulfillmentschema_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
