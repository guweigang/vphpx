import rt

struct Class_Automattic_WooCommerce_Internal_RestApiControllerBase {
	rt.PhpObjectBase
pub mut:
	route_namespace rt.PhpVal = rt.new_string('wc/v3')
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApiControllerBase) register() {
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_rest_api_get_rest_namespaces'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApiControllerBase', [
				'RegisterHooksInterface',
			], &this) },
			rt.ArrayItem{ key: none, val: 'handle_woocommerce_rest_api_get_rest_namespaces' },
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApiControllerBase) handle_woocommerce_rest_api_get_rest_namespaces(mut var_namespaces Class_Automattic_WooCommerce_Internal_array) rt.PhpVal {
	var_namespaces.array_get_mut('wc/v3').array_set(this.get_rest_api_namespace(),
		Class_Automattic_WooCommerce_Internal_static.class())
	return rt.new_object('Automattic_WooCommerce_Internal_array', []string{}, var_namespaces)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApiControllerBase) get_rest_api_namespace() string {
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApiControllerBase) register_routes() {
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApiControllerBase) run(mut var_request Class_WP_REST_Request, method_name string) rt.PhpVal {
	return rt.call_function('rest_ensure_response', [
		rt.call_method(rt.new_object('Automattic_WooCommerce_Internal_RestApiControllerBase', [
			'RegisterHooksInterface',
		], &this), method_name, [
			var_request,
		]),
	])
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'InvalidArgumentException') {
		mut var_ex := var_e_1.clone()
		mut var_message := rt.call_method(var_ex, 'getMessage', []rt.PhpVal{})
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_invalid_argument'), if rt.is_true(var_message) { var_message } else { rt.call_function('__', [
				rt.new_string('Internal server error'),
				rt.new_string('woocommerce'),
			]) }, rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
		unsafe {
			goto end_label_1
		}
	} else if rt.instance_of(var_e_1, 'Exception') {
		var_ex = var_e_1.clone()
		mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_StringUtil{}
		mut iife_result_0 :=
			iife_temp_0.class_name_without_namespace(Class_Automattic_WooCommerce_Internal_static.class())
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [
			rt.new_string(iife_result_0.str() +
				rt.concat(rt.concat(rt.concat(rt.new_string(': when executing method '), rt.new_string(method_name)), rt.new_string(': ')), rt.call_method(var_ex, 'getMessage', []rt.PhpVal{}))),
		])
		return this.internal_wp_error(mut rt.cast_object_ptr[Class_Exception](var_ex))
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
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApiControllerBase) internal_wp_error(mut var_exception Class_Exception) rt.PhpVal {
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])
	if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_woocommerce'),
	]))
	{
		var_data.array_set('exception_class', rt.call_function('get_class', [
			var_exception,
		]))
		var_data.array_set('exception_message', var_exception.getmessage())
		var_data.array_set('exception_trace', rt.cast_array(var_exception.gettrace()))
	}
	var_data.array_set('exception_message', var_exception.getmessage())
	return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_internal_error'), rt.call_function('__', [
		rt.new_string('Internal server error'),
		rt.new_string('woocommerce'),
	]), var_data.clone()))
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApiControllerBase) get_authentication_error_by_method(method string) rt.PhpVal {
	mut var_errors := rt.create_array([
		rt.ArrayItem{ key: 'GET', val: rt.create_array([
			rt.ArrayItem{ key: 'code', val: 'woocommerce_rest_cannot_view' },
			rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
				rt.new_string('Sorry, you cannot view resources.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'POST', val: rt.create_array([
			rt.ArrayItem{ key: 'code', val: 'woocommerce_rest_cannot_create' },
			rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
				rt.new_string('Sorry, you cannot create resources.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'DELETE', val: rt.create_array([
			rt.ArrayItem{ key: 'code', val: 'woocommerce_rest_cannot_delete' },
			rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
				rt.new_string('Sorry, you cannot delete resources.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
	])
	return if !(var_errors.array_get(rt.new_string(method))).is_null() {
		var_errors.array_get(rt.new_string(method))
	} else {
		rt.new_null()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApiControllerBase) check_permission(mut var_request Class_WP_REST_Request, required_capability_name string, var_extra_args rt.PhpVal) bool {
	if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string(required_capability_name),
		var_extra_args.clone(),
	]))
	{
		return true
	}
	mut var_error_information :=
		this.get_authentication_error_by_method((var_request.get_method()).str())
	if rt.is_true(rt.new_bool(var_error_information.clone().is_null())) {
		return false
	}
	return (create_wp_error(var_error_information.array_get(rt.new_string('code')),
		var_error_information.array_get(rt.new_string('message')), rt.create_array([
		rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
			[]rt.PhpVal{}) },
	]))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApiControllerBase) get_base_schema() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'order receipts' },
		rt.ArrayItem{ key: 'type', val: 'object' },
	])
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_StringUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapicontrollerbase(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApiControllerBase {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApiControllerBase{
		PhpObjectBase:   rt.PhpObjectBase{}
		route_namespace: rt.new_string('wc/v3')
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_stringutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_StringUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_StringUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApiControllerBase) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			this.register()
			return rt.new_null()
		}
		'handle_woocommerce_rest_api_get_rest_namespaces' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.handle_woocommerce_rest_api_get_rest_namespaces(mut dispatch_arg_0)
		}
		'get_rest_api_namespace' {
			return rt.new_string(this.get_rest_api_namespace())
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'run' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.run(mut dispatch_arg_0, dispatch_arg_1)
		}
		'internal_wp_error' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Exception](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.internal_wp_error(mut dispatch_arg_0)
		}
		'get_authentication_error_by_method' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_authentication_error_by_method(dispatch_arg_0)
		}
		'check_permission' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.check_permission(mut dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2))
		}
		'get_base_schema' {
			return this.get_base_schema()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApiControllerBase) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'route_namespace' { return this.route_namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApiControllerBase) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'route_namespace' {
			this.route_namespace = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}
}
