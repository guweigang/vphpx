import rt

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller.invalid_zone_id() string {
	return 'invalid_zone_id'
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller {
	rt.PhpObjectBase
pub mut:
	rest_base             rt.PhpVal = rt.new_string('shipping-zones')
	item_schema           rt.PhpVal = rt.new_null()
	shipping_zone_service rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller) init(mut var_zone_schema Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_ShippingZoneSchema, mut var_shipping_zone_service Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_ShippingZoneService) {
	this.item_schema = var_zone_schema
	this.shipping_zone_service = var_shipping_zone_service
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller) get_schema() rt.PhpVal {
	return rt.call_method(this.item_schema, 'get_item_schema', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller', [
			'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
		], &this), 'namespace'),
		rt.new_string('/' + (this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'check_permissions' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'check_permissions' },
				]) },
				rt.ArrayItem{
					key: 'args'
					val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable())
				},
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller', [
					'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller', [
			'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
		], &this), 'namespace'),
		rt.new_string('/' + (this.rest_base).str() + '/(?P<id>[\\d]+)'),
		rt.create_array([
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller', [
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
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'check_permissions' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller', [
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
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller', [
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

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_zone_id := rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64())
	mut iife_temp_0 := Class_WC_Shipping_Zones{}
	mut iife_result_0 := iife_temp_0.get_zone_by(rt.new_string('zone_id'), var_zone_id.clone())
	mut var_zone := iife_result_0
	if rt.is_true(rt.new_bool(!(rt.is_true(var_zone)))) {
		return this.get_route_error_response(rt.new_string(
			(this.get_error_prefix()).str() + 'invalid_id'), rt.call_function('__', [
			rt.new_string('Invalid resource ID.'),
			rt.new_string('woocommerce'),
		]), Class_WP_Http.not_found())
	}
	return rt.call_function('rest_ensure_response', [
		this.prepare_item_for_response(var_zone.clone(), var_request.clone()),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_zones := rt.call_method(this.shipping_zone_service, 'get_sorted_shipping_zones',
		[]rt.PhpVal{})
	mut var_items := rt.new_array()
	mut iter_1 := var_zones.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_zone_data := item_1.val
		mut var_zone_id := var_zone_data.array_get(rt.new_string('zone_id'))
		mut iife_temp_1 := Class_WC_Shipping_Zones{}
		mut iife_result_1 := iife_temp_1.get_zone(var_zone_id.clone())
		mut var_zone := iife_result_1
		var_items.array_push(this.prepare_response_for_collection(this.prepare_item_for_response(var_zone.clone(),
			var_request.clone())))
	}
	return rt.call_function('rest_ensure_response', [var_items.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller) get_item_response(var_zone rt.PhpVal, mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_zone_mutated := var_zone
	return rt.call_method(this.item_schema, 'get_item_response', [
		var_zone_mutated.clone(), var_request,
		this.get_fields_for_response(rt.new_object('WP_REST_Request',
			[]string{}, var_request))])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller) check_permissions(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_shipping_enabled', []rt.PhpVal{}))))) {
		return (this.get_route_error_response(rt.new_string(
			(this.get_error_prefix()).str() + 'disabled'), rt.call_function('__', [
			rt.new_string('Shipping is disabled.'),
			rt.new_string('woocommerce'),
		]), Class_WP_Http.service_unavailable())).to_bool()
	}
	mut var_method := rt.call_method(var_request, 'get_method', []rt.PhpVal{})
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

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_zone := rt.call_method(this.shipping_zone_service, 'create_shipping_zone', [
		rt.call_method(var_request, 'get_params', []rt.PhpVal{}),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_zone.clone()])) {
		return var_zone.clone()
	}
	if rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_zone, 'get_id', []rt.PhpVal{}))) {
		return this.get_route_error_response(rt.new_string(
			(this.get_error_prefix()).str() + 'cannot_create'), rt.call_function('__', [
			rt.new_string('Resource cannot be created. Check for validation errors or server logs for details.'),
			rt.new_string('woocommerce'),
		]), Class_WP_Http.internal_server_error())
	}
	mut var_response := rt.call_function('rest_ensure_response', [
		this.prepare_item_for_response(var_zone.clone(), var_request.clone()),
	])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'),
				rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller', [
					'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
				], &this), 'namespace'),
				this.rest_base, rt.call_method(var_zone, 'get_id', []rt.PhpVal{})]),
		])])
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_zone_id := rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64())
	mut var_zone := this.validate_zone(var_zone_id.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_zone.clone()])) {
		return var_zone.clone()
	}
	mut var_response := rt.call_function('rest_ensure_response', [
		this.prepare_item_for_response(var_zone.clone(), var_request.clone()),
	])
	mut iife_temp_2 := Class_WC_Shipping_Zones{}
	mut iife_result_2 := iife_temp_2.delete_zone(var_zone_id.clone())
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller) get_route_error_by_code(error_code string) rt.PhpVal {
	mut var_custom_errors := rt.create_array([
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller.invalid_zone_id()
			val: rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('Invalid shipping zone ID.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'status', val: Class_WP_Http.not_found() },
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

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller) validate_zone(var_zone_id rt.PhpVal) rt.PhpVal {
	mut var_zone_id_mutated := var_zone_id
	mut iife_temp_3 := Class_WC_Shipping_Zones{}
	mut iife_result_3 := iife_temp_3.get_zone(var_zone_id_mutated.clone())
	mut var_zone := iife_result_3
	if rt.is_true(rt.new_bool(!(rt.is_true(var_zone))))|| (rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_zone, 'get_id', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_zone, 'get_zone_name', []rt.PhpVal{})))))) {
		return this.get_route_error_by_code((Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller.invalid_zone_id()).str())
	}
	return var_zone.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_zone_id := rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64())
	mut var_zone := this.validate_zone(var_zone_id.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_zone.clone()])) {
		return var_zone.clone()
	}
	mut var_result := rt.call_method(this.shipping_zone_service, 'update_shipping_zone', [
		var_zone.clone(),
		rt.call_method(var_request, 'get_params', []rt.PhpVal{}),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		return var_result.clone()
	}
	return rt.call_function('rest_ensure_response', [
		this.prepare_item_for_response(var_result.clone(), var_request.clone()),
	])
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController {
	rt.PhpObjectBase
}

struct Class_WC_Shipping_Zones {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_shippingzones_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller{
		PhpObjectBase:         rt.PhpObjectBase{}
		rest_base:             rt.new_string('shipping-zones')
		item_schema:           rt.new_null()
		shipping_zone_service: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_abstractcontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController{
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

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_ShippingZoneSchema](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_ShippingZoneService](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
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
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
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
		'check_permissions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_permissions(dispatch_arg_0))
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'delete_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item(dispatch_arg_0)
		}
		'get_route_error_by_code' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_route_error_by_code(dispatch_arg_0)
		}
		'validate_zone' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.validate_zone(dispatch_arg_0)
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		'item_schema' { return this.item_schema }
		'shipping_zone_service' { return this.shipping_zone_service }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_base' {
			this.rest_base = val
			return true
		}
		'item_schema' {
			this.item_schema = val
			return true
		}
		'shipping_zone_service' {
			this.shipping_zone_service = val
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
