import rt

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema.identifier() string {
	return ''
}

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema.view_edit_embed_context() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'view' },
		rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }])
}

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema.view_edit_context() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'view' },
		rt.ArrayItem{ key: none, val: 'edit' }])
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema) get_item_schema() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{
			key: 'title'
			val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_static.identifier()
		},
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: this.get_item_schema_properties() },
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema) get_item_response(var_item rt.PhpVal, mut var_request Class_WP_REST_Request, mut var_include_fields Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_array) {
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema) get_item_schema_properties() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema) get_writable_item_schema_properties() rt.PhpVal {
	return rt.call_function('array_filter', [this.get_item_schema_properties(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'filter_writable_props' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema) filter_writable_props(mut var_schema Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_array) bool {
	return (rt.new_bool(!rt.is_true(var_schema.array_get(rt.new_string('readonly'))))).to_bool()
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_abstractschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
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
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			this.get_item_response(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'get_item_schema_properties' {
			return this.get_item_schema_properties()
		}
		'get_writable_item_schema_properties' {
			return this.get_writable_item_schema_properties()
		}
		'filter_writable_props' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.filter_writable_props(mut dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
