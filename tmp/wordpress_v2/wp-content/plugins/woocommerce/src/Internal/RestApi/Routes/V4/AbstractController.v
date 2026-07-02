import rt

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController.invalid_id() string {
	return 'invalid_id'
}

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController.resource_exists() string {
	return 'resource_exists'
}

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController.cannot_create() string {
	return 'cannot_create'
}

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController.cannot_delete() string {
	return 'cannot_delete'
}

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController.cannot_update() string {
	return 'cannot_update'
}

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController.cannot_trash() string {
	return 'cannot_trash'
}

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController.trash_not_supported() string {
	return 'trash_not_supported'
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v4')
	rest_base rt.PhpVal = rt.new_string('')
	schema    rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) get_schema() {
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) get_query_schema() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) get_endpoint_args() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) get_collection_params() rt.PhpVal {
	mut var_params := this.get_query_schema()
	var_params.array_set('context', this.get_context_param(rt.create_array([
		rt.ArrayItem{ key: 'default', val: 'view' },
	])))
	return rt.call_function('apply_filters', [
		rt.new_string(this.get_hook_prefix() + 'collection_params'),
		var_params.clone(),
		rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController', [
			'WP_REST_Controller',
		], &this),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), this.schema)) {
		this.schema = rt.call_function('apply_filters', [
			rt.new_string(this.get_hook_prefix() + 'item_schema'),
			this.add_additional_fields_schema(this.get_schema()),
		])
	}
	return this.schema
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) get_item_response(var_item rt.PhpVal, mut var_request Class_WP_REST_Request) {
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) prepare_links(var_item rt.PhpVal, mut var_request Class_WP_REST_Request, mut var_response Class_WP_REST_Response) rt.PhpVal {
	mut var_response_mutated := var_response
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_response_data := this.get_item_response(var_item.clone(), mut
		rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	var_response_data = this.add_additional_fields_to_object(var_response_data.clone(),
		var_request.clone())
	var_response_data = this.filter_response_by_context(var_response_data.clone(), if !(var_request.array_get(rt.new_string('context'))).is_null() {
		var_request.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	})
	mut var_response := rt.call_function('rest_ensure_response', [
		var_response_data.clone()])
	rt.call_method(var_response, 'add_links', [
		this.prepare_links(var_item.clone(), mut
			rt.cast_object_ptr[Class_WP_REST_Request](var_request), mut
			rt.cast_object_ptr[Class_WP_REST_Response](var_response)),
	])
	return rt.call_function('rest_ensure_response', [
		rt.call_function('apply_filters', [
			rt.new_string(this.get_hook_prefix() + 'item_response'),
			var_response.clone(),
			var_item.clone(),
			var_request.clone(),
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) get_hook_prefix() string {
	return 'woocommerce_rest_api_v4_' +
		(rt.call_function('str_replace', [rt.new_string('-'), rt.new_string('_'), this.rest_base])).str() +
		'_'
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) get_error_prefix() string {
	return 'woocommerce_rest_api_v4_' +
		(rt.call_function('str_replace', [rt.new_string('-'), rt.new_string('_'), this.rest_base])).str() +
		'_'
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) get_route_error_response(error_code string, error_message string, http_status_code i64, mut var_additional_data Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_array) rt.PhpVal {
	mut error_code_mutated := error_code
	mut error_message_mutated := error_message
	if error_code_mutated == '' {
		error_code_mutated = 'invalid_request'
	}
	if error_message_mutated == '' {
		error_message_mutated = (rt.call_function('__', [
			rt.new_string('An error occurred while processing your request.'),
			rt.new_string('woocommerce'),
		])).str()
	}
	return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string(error_code_mutated).clone(),
		rt.new_string(error_message_mutated).clone(), rt.call_function('array_merge', [
		var_additional_data,
		rt.create_array([rt.ArrayItem{ key: 'status', val: http_status_code }]),
	])))
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) get_route_error_response_from_object(mut var_error_object Class_WP_Error, http_status_code i64, mut var_additional_data Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_array) rt.PhpVal {
	if !(true) {
		return this.get_route_error_response('invalid_error_object', (rt.call_function('__', [
			rt.new_string('Invalid error object provided.'),
			rt.new_string('woocommerce'),
		])).str(), http_status_code, mut var_additional_data)
	}
	var_error_object.add_data(rt.call_function('array_merge', [var_additional_data,
		rt.create_array([rt.ArrayItem{ key: 'status', val: http_status_code }])]))
	return rt.new_object('WP_Error', []string{}, var_error_object)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) get_authentication_error_by_method(method string) bool {
	mut var_errors := rt.create_array([
		rt.ArrayItem{ key: 'GET', val: rt.create_array([
			rt.ArrayItem{ key: 'code', val: this.get_error_prefix() + 'cannot_view' },
			rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
				rt.new_string('Sorry, you cannot view resources.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'POST', val: rt.create_array([
			rt.ArrayItem{ key: 'code', val: this.get_error_prefix() + 'cannot_create' },
			rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
				rt.new_string('Sorry, you cannot create resources.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'PUT', val: rt.create_array([
			rt.ArrayItem{ key: 'code', val: this.get_error_prefix() + 'cannot_update' },
			rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
				rt.new_string('Sorry, you cannot update resources.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'PATCH', val: rt.create_array([
			rt.ArrayItem{ key: 'code', val: this.get_error_prefix() + 'cannot_update' },
			rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
				rt.new_string('Sorry, you cannot update resources.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'DELETE', val: rt.create_array([
			rt.ArrayItem{ key: 'code', val: this.get_error_prefix() + 'cannot_delete' },
			rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
				rt.new_string('Sorry, you cannot delete resources.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
	])
	if !(var_errors.array_isset(rt.new_string(method))) {
		return false
	}
	return (create_wp_error(var_errors.array_get(rt.new_string(method)).array_get(rt.new_string('code')),
		var_errors.array_get(rt.new_string(method)).array_get(rt.new_string('message')), rt.create_array([
		rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
			[]rt.PhpVal{}) },
	]))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) get_route_error_by_code(error_code string) rt.PhpVal {
	mut error_code_mutated := error_code
	mut var_error_messages := rt.create_array([
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController.invalid_id()
			val: rt.call_function('__', [rt.new_string('Invalid ID.'),
				rt.new_string('woocommerce')])
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController.resource_exists()
			val: rt.call_function('__', [rt.new_string('Resource already exists.'),
				rt.new_string('woocommerce')])
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController.cannot_create()
			val: rt.call_function('__', [rt.new_string('Cannot create resource.'),
				rt.new_string('woocommerce')])
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController.cannot_delete()
			val: rt.call_function('__', [rt.new_string('Cannot delete resource.'),
				rt.new_string('woocommerce')])
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController.cannot_update()
			val: rt.call_function('__', [rt.new_string('Cannot update resource.'),
				rt.new_string('woocommerce')])
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController.cannot_trash()
			val: rt.call_function('__', [rt.new_string('Cannot trash resource.'),
				rt.new_string('woocommerce')])
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController.trash_not_supported()
			val: rt.call_function('__', [rt.new_string('Trash not supported.'),
				rt.new_string('woocommerce')])
		},
	])
	mut var_http_status_codes := rt.create_array([
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController.invalid_id()
			val: Class_WP_Http.not_found()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController.resource_exists()
			val: Class_WP_Http.bad_request()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController.cannot_create()
			val: Class_WP_Http.internal_server_error()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController.cannot_delete()
			val: Class_WP_Http.internal_server_error()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController.cannot_update()
			val: Class_WP_Http.internal_server_error()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController.cannot_trash()
			val: Class_WP_Http.gone()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController.trash_not_supported()
			val: Class_WP_Http.not_implemented()
		},
	])
	return this.get_route_error_response(this.get_error_prefix() + error_code_mutated, (if !(var_error_messages.array_get(rt.new_string(error_code_mutated))).is_null() { var_error_messages.array_get(rt.new_string(error_code_mutated)) } else { rt.call_function('__', [
			rt.new_string('An error occurred while processing your request.'),
			rt.new_string('woocommerce'),
		]) }).str(), (if !(var_http_status_codes.array_get(rt.new_string(error_code_mutated))).is_null() {
		var_http_status_codes.array_get(rt.new_string(error_code_mutated))
	} else {
		Class_WP_Http.bad_request()
	}).to_i64(), rt.new_null())
}

struct Class_WP_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_abstractcontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v4')
		rest_base:     rt.new_string('')
		schema:        rt.new_null()
	}
	return obj
}

fn create_wp_rest_controller(_args ...rt.PhpVal) &Class_WP_REST_Controller {
	mut obj := &Class_WP_REST_Controller{
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

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_schema' {
			this.get_schema()
			return rt.new_null()
		}
		'get_query_schema' {
			return this.get_query_schema()
		}
		'get_endpoint_args' {
			return this.get_endpoint_args()
		}
		'get_collection_params' {
			return this.get_collection_params()
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
			this.get_item_response(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WP_REST_Response](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return this.prepare_links(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_hook_prefix' {
			return rt.new_string(this.get_hook_prefix())
		}
		'get_error_prefix' {
			return rt.new_string(this.get_error_prefix())
		}
		'get_route_error_response' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_array](if args.len > 3 {
				args[3]
			} else {
				rt.new_null()
			})
			return this.get_route_error_response(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut
				dispatch_arg_3)
		}
		'get_route_error_response_from_object' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Error](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return this.get_route_error_response_from_object(mut dispatch_arg_0, dispatch_arg_1, mut
				dispatch_arg_2)
		}
		'get_authentication_error_by_method' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.get_authentication_error_by_method(dispatch_arg_0))
		}
		'get_route_error_by_code' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_route_error_by_code(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		'schema' { return this.schema }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		'rest_base' {
			this.rest_base = val
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

fn (mut this Class_WP_REST_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
