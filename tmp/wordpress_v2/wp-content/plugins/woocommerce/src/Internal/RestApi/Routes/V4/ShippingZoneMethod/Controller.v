import rt

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller.invalid_zone_id() string {
	return 'invalid_zone_id'
}

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller.invalid_method_type() string {
	return 'invalid_method_type'
}

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller.zone_mismatch() string {
	return 'zone_mismatch'
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller {
	rt.PhpObjectBase
pub mut:
	rest_base               rt.PhpVal = rt.new_string('shipping-zone-method')
	method_schema           rt.PhpVal = rt.new_null()
	shipping_method_service rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller) init(mut var_method_schema Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_ShippingMethodSchema, mut var_shipping_method_service Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_ShippingZoneMethodService) {
	this.method_schema = var_method_schema
	this.shipping_method_service = var_shipping_method_service
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller', [
			'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
		], &this), 'namespace'),
		rt.new_string('/' + (this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller', [
					'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
				], &this) },
				rt.ArrayItem{ key: none, val: 'create_item' },
			]) },
			rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller', [
					'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
				], &this) },
				rt.ArrayItem{ key: none, val: 'check_permissions' },
			]) },
			rt.ArrayItem{
				key: 'args'
				val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable())
			},
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller', [
			'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
		], &this), 'namespace'),
		rt.new_string('/' + (this.rest_base).str() + '/(?P<id>[\\d]+)'),
		rt.create_array([
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller', [
					'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique identifier for the resource.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'check_permissions' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'check_permissions' },
				]) },
				rt.ArrayItem{
					key: 'args'
					val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable())
				},
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'check_permissions' },
				]) },
				rt.ArrayItem{
					key: 'args'
					val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.deletable())
				},
			]) },
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller) check_permissions(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_shipping_enabled', []rt.PhpVal{}))))) {
		return (create_wp_error(rt.new_string('rest_shipping_disabled'), rt.call_function('__', [
			rt.new_string('Shipping is disabled.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: Class_WP_Http.service_unavailable() },
		]))).to_bool()
	}
	mut var_method := rt.call_method(var_request_mutated, 'get_method', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_string('GET'), var_method)) {
		mut var_context := rt.new_string('read')
	} else if rt.is_true(rt.identical(rt.new_string('DELETE'), var_method)) {
		var_context = rt.new_string('delete')
	} else {
		var_context = rt.new_string('edit')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [
		rt.new_string('settings'),
		var_context.clone(),
	])))))
	{
		return (this.get_authentication_error_by_method(var_method.clone())).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_instance_id := rt.new_int((var_request_mutated.array_get(rt.new_string('id'))).to_i64())
	mut iife_temp_0 := Class_WC_Shipping_Zones{}
	mut iife_result_0 := iife_temp_0.get_shipping_method(var_instance_id.clone())
	mut var_method := iife_result_0
	if rt.is_true(rt.new_bool(!(rt.is_true(var_method)))) {
		return this.get_route_error_by_code((Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller.invalid_id()).str())
	}
	return rt.call_function('rest_ensure_response', [
		this.prepare_item_for_response(var_method.clone(), var_request_mutated.clone()),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_zone := this.validate_zone(var_request_mutated.array_get(rt.new_string('zone_id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_zone.clone()])) {
		return var_zone.clone()
	}
	mut var_method_validation :=
		rt.new_bool(this.validate_method_type(var_request_mutated.array_get(rt.new_string('method_id'))))
	if rt.is_true(rt.call_function('is_wp_error', [var_method_validation.clone()])) {
		return var_method_validation.clone()
	}
	mut var_instance_id := rt.call_method(var_zone, 'add_shipping_method', [
		var_request_mutated.array_get(rt.new_string('method_id')),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_instance_id)))) {
		return this.get_route_error_by_code((Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller.cannot_create()).str())
	}
	mut iife_temp_1 := Class_WC_Shipping_Zones{}
	mut iife_result_1 := iife_temp_1.get_shipping_method(var_instance_id.clone())
	mut var_method := iife_result_1
	if rt.is_true(rt.new_bool(!(rt.is_true(var_method)))) {
		return this.get_route_error_by_code((Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller.cannot_create()).str())
	}
	mut var_result := rt.call_method(this.shipping_method_service, 'update_shipping_zone_method', [
		var_method.clone(),
		var_instance_id.clone(),
		rt.call_method(var_request_mutated, 'get_params', []rt.PhpVal{}),
		rt.call_method(var_zone, 'get_id', []rt.PhpVal{}),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		rt.call_method(var_zone, 'delete_shipping_method', [var_instance_id.clone()])
		return var_result.clone()
	}
	var_request_mutated.array_set('zone_id', rt.call_method(var_zone, 'get_id', []rt.PhpVal{}))
	mut var_response := this.prepare_item_for_response(var_method.clone(),
		var_request_mutated.clone())
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_instance_id := rt.new_int((var_request_mutated.array_get(rt.new_string('id'))).to_i64())
	mut iife_temp_2 := Class_WC_Shipping_Zones{}
	mut iife_result_2 := iife_temp_2.get_shipping_method(var_instance_id.clone())
	mut var_method := iife_result_2
	if rt.is_true(rt.new_bool(!(rt.is_true(var_method)))) {
		return this.get_route_error_by_code((Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller.invalid_id()).str())
	}
	mut var_zone := this.validate_zone_by_method_instance(var_instance_id.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_zone.clone()])) {
		return var_zone.clone()
	}
	if var_request_mutated.array_isset(rt.new_string('enabled'))
		|| var_request_mutated.array_isset(rt.new_string('settings'))
		|| var_request_mutated.array_isset(rt.new_string('order')) {
		mut var_result := rt.call_method(this.shipping_method_service,
			'update_shipping_zone_method', [var_method.clone(),
			var_instance_id.clone(), rt.call_method(var_request_mutated, 'get_params', []rt.PhpVal{}),
			rt.call_method(var_zone, 'get_id', []rt.PhpVal{})])
		if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
			return var_result.clone()
		}
	}
	var_request_mutated.array_set('zone_id', rt.call_method(var_zone, 'get_id', []rt.PhpVal{}))
	return this.prepare_item_for_response(var_method.clone(), var_request_mutated.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_instance_id := rt.new_int((var_request_mutated.array_get(rt.new_string('id'))).to_i64())
	mut iife_temp_3 := Class_WC_Shipping_Zones{}
	mut iife_result_3 := iife_temp_3.get_shipping_method(var_instance_id.clone())
	mut var_method := iife_result_3
	if rt.is_true(rt.new_bool(!(rt.is_true(var_method)))) {
		return this.get_route_error_by_code((Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller.invalid_id()).str())
	}
	mut var_zone := this.validate_zone_by_method_instance(var_instance_id.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_zone.clone()])) {
		return var_zone.clone()
	}
	rt.call_method(var_request_mutated, 'set_param', [rt.new_string('context'),
		rt.new_string('view')])
	var_request_mutated.array_set('zone_id', rt.call_method(var_zone, 'get_id', []rt.PhpVal{}))
	mut var_response := this.prepare_item_for_response(var_method.clone(),
		var_request_mutated.clone())
	mut var_result := rt.call_method(var_zone, 'delete_shipping_method', [
		var_instance_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return this.get_route_error_by_code((Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller.invalid_id()).str())
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_rest_delete_shipping_zone_method'),
		var_method.clone(),
		var_zone.clone(),
		var_response.clone(),
		var_request_mutated.clone(),
	])
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller) get_schema() rt.PhpVal {
	return rt.call_method(this.method_schema, 'get_item_schema', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller) get_item_response(var_zone rt.PhpVal, mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_zone_mutated := var_zone
	mut var_request_mutated := var_request
	return rt.call_method(this.method_schema, 'get_item_response', [
		var_zone_mutated.clone(), var_request_mutated,
		this.get_fields_for_response(rt.new_object('WP_REST_Request',
			[]string{}, var_request_mutated))])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller) get_route_error_by_code(error_code string) rt.PhpVal {
	mut var_custom_errors := rt.create_array([
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller.invalid_zone_id()
			val: rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('Invalid shipping zone ID.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'status', val: Class_WP_Http.not_found() },
			])
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller.invalid_method_type()
			val: rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('Invalid shipping method type.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'status', val: Class_WP_Http.bad_request() },
			])
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller.zone_mismatch()
			val: rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('Shipping method does not belong to the specified zone.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'status', val: Class_WP_Http.bad_request() },
			])
		},
	])
	if var_custom_errors.array_isset(rt.new_string(error_code)) {
		return this.get_route_error_response(rt.new_string(
			(this.get_error_prefix()).str() + error_code),
			var_custom_errors.array_get(rt.new_string(error_code)).array_get(rt.new_string('message')),
			var_custom_errors.array_get(rt.new_string(error_code)).array_get(rt.new_string('status')))
	}
	return this.Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController.get_route_error_by_code(rt.new_string(error_code))
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller) validate_zone(var_zone_id rt.PhpVal) rt.PhpVal {
	mut iife_temp_4 := Class_WC_Shipping_Zones{}
	mut iife_result_4 := iife_temp_4.get_zone(var_zone_id.clone())
	mut var_zone := iife_result_4
	if rt.is_true(rt.new_bool(!(rt.is_true(var_zone))))|| (rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_zone, 'get_id', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_zone, 'get_zone_name', []rt.PhpVal{})))))) {
		return this.get_route_error_by_code((Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller.invalid_zone_id()).str())
	}
	return var_zone.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller) validate_method_type(var_method_id rt.PhpVal) bool {
	mut var_available_methods := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
		'shipping', []rt.PhpVal{}), 'get_shipping_methods', []rt.PhpVal{})
	if !(var_available_methods.array_isset(var_method_id)) {
		return (this.get_route_error_by_code((Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller.invalid_method_type()).str())).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller) validate_zone_by_method_instance(var_instance_id rt.PhpVal) rt.PhpVal {
	mut var_instance_id_mutated := var_instance_id
	mut iife_temp_5 := Class_WC_Shipping_Zones{}
	mut iife_result_5 := iife_temp_5.get_zone_by(rt.new_string('instance_id'),
		var_instance_id_mutated.clone())
	mut var_zone := iife_result_5
	if rt.is_true(rt.new_bool(!(rt.is_true(var_zone)))) {
		return this.get_route_error_by_code((Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller.invalid_id()).str())
	}
	return var_zone.clone()
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WC_Shipping_Zones {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_shippingzonemethod_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller{
		PhpObjectBase:           rt.PhpObjectBase{}
		rest_base:               rt.new_string('shipping-zone-method')
		method_schema:           rt.new_null()
		shipping_method_service: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_abstractcontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController{
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

fn create_wc_shipping_zones(_args ...rt.PhpVal) &Class_WC_Shipping_Zones {
	mut obj := &Class_WC_Shipping_Zones{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_ShippingMethodSchema](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_ShippingZoneMethodService](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'check_permissions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_permissions(dispatch_arg_0))
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'delete_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item(dispatch_arg_0)
		}
		'get_schema' {
			return this.get_schema()
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
		'get_route_error_by_code' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_route_error_by_code(dispatch_arg_0)
		}
		'validate_zone' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.validate_zone(dispatch_arg_0)
		}
		'validate_method_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_method_type(dispatch_arg_0))
		}
		'validate_zone_by_method_instance' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.validate_zone_by_method_instance(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		'method_schema' { return this.method_schema }
		'shipping_method_service' { return this.shipping_method_service }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_base' {
			this.rest_base = val
			return true
		}
		'method_schema' {
			this.method_schema = val
			return true
		}
		'shipping_method_service' {
			this.shipping_method_service = val
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

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Shipping_Zones) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shipping_Zones) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping_Zones) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
