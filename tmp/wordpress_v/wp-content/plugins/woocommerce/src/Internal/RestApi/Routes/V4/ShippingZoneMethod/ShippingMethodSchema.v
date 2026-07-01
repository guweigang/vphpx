import rt

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_ShippingMethodSchema.identifier() string {
	return 'shipping_method'
}
struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_ShippingMethodSchema {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_ShippingMethodSchema) get_item_schema_properties() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'instance_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shipping method instance ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'zone_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shipping zone ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'required', val: true }]) }, rt.ArrayItem{ key: 'enabled', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether the shipping method is enabled.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'required', val: true }]) }, rt.ArrayItem{ key: 'order', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shipping method sort order.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }]) }, rt.ArrayItem{ key: 'method_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shipping method ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'required', val: true }]) }, rt.ArrayItem{ key: 'settings', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shipping method settings including title and configuration.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shipping method title.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'required', val: true }]) }]) }, rt.ArrayItem{ key: 'additionalProperties', val: true }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_ShippingMethodSchema) get_item_response(var_method rt.PhpVal, mut var_request Class_WP_REST_Request, mut var_include_fields Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_array) rt.PhpVal {
	if var_request.array_isset(rt.new_string('zone_id')) {
		mut var_zone_id := // unsupported expression: Expr_Cast_Int
	} else {
		mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('shipping-zone'))
		var_zone_id = rt.call_method(var_data_store, 'get_zone_id_by_instance_id', [rt.get_property(var_method, 'instance_id')])
	}
	return rt.create_array([rt.ArrayItem{ key: 'instance_id', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'zone_id', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'enabled', val: rt.call_function('wc_string_to_bool', [rt.get_property(var_method, 'enabled')]) }, rt.ArrayItem{ key: 'order', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'method_id', val: rt.get_property(var_method, 'id') }, rt.ArrayItem{ key: 'settings', val: this.get_method_settings(var_method.dup()) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_ShippingMethodSchema) get_method_settings(var_method rt.PhpVal) rt.PhpVal {
	mut var_settings := rt.new_array()
	var_settings.array_set('title', rt.call_method(var_method, 'get_title', []rt.PhpVal{}))
	mut var_common_fields := rt.create_array([rt.ArrayItem{ key: none, val: 'cost' }, rt.ArrayItem{ key: none, val: 'min_amount' }, rt.ArrayItem{ key: none, val: 'requires' }, rt.ArrayItem{ key: none, val: 'class_cost' }, rt.ArrayItem{ key: none, val: 'no_class_cost' }, rt.ArrayItem{ key: none, val: 'tax_status' }])
	{
		mut iter_1 := var_common_fields.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			if !(rt.get_property(var_method, '{"nodeType":"Expr_Variable","line":126,"name":"field"}')).is_null() {
				var_settings.array_set(var_field, rt.get_property(var_method, '{"nodeType":"Expr_Variable","line":127,"name":"field"}'))
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.get_property(var_method, 'instance_settings')).is_null() && rt.is_true(rt.new_bool(rt.get_property(var_method, 'instance_settings').is_array())))) {
		var_settings = rt.call_function('array_merge', [var_settings.dup(), rt.get_property(var_method, 'instance_settings')])
	}
	return var_settings.dup()
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_shippingzonemethod_shippingmethodschema() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_ShippingMethodSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_ShippingMethodSchema{
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

fn create_automattic_woocommerce_internal_restapi_routes_v4_shippingzonemethod_wc_data_store() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_ShippingMethodSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_item_schema_properties' {
			return this.get_item_schema_properties()
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.get_item_response(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'get_method_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_method_settings(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_ShippingMethodSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_ShippingMethodSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_restapi_routes_v4_shippingzonemethod_shippingmethodschema_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
