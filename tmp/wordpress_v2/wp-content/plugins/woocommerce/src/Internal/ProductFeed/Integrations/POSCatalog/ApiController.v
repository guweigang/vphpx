import rt

pub fn Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_ApiController.route_namespace() string {
	return 'wc/pos/v1/catalog'
}

struct Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_ApiController {
	rt.PhpObjectBase
pub mut:
	container rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_ApiController) init(mut var_container Class_Automattic_WooCommerce_Container) {
	this.container = var_container
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_ApiController) register_routes() {
	rt.call_function('register_rest_route', [
		Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_ApiController.route_namespace(),
		rt.new_string('/create'),
		rt.create_array([rt.ArrayItem{ key: 'methods', val: 'POST' },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_ApiController',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'generate_feed' },
			]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_ApiController',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'is_authorized' },
			]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'force', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
					rt.ArrayItem{
						key: 'description'
						val: 'Force regeneration of the feed. NOOP if generation is in progress.'
					},
				]) },
				rt.ArrayItem{ key: '_product_fields', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'description'
						val: 'Comma-separated list of fields to include for non-variable products.'
					},
					rt.ArrayItem{ key: 'required', val: false },
				]) },
				rt.ArrayItem{ key: '_variation_fields', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'description'
						val: 'Comma-separated list of fields to include for variations.'
					},
					rt.ArrayItem{ key: 'required', val: false },
				]) },
			]) }]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_ApiController) is_authorized() bool {
	return rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))
		|| rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_options')]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_ApiController) generate_feed(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_generator := rt.call_method(this.container, 'get', [
		Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator.class(),
	])
	mut var_params := rt.new_array()
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(),
		var_request.array_get(rt.new_string('_product_fields'))))))
	{
		var_params.array_set('_product_fields',
			var_request.array_get(rt.new_string('_product_fields')))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(),
		var_request.array_get(rt.new_string('_variation_fields'))))))
	{
		var_params.array_set('_variation_fields',
			var_request.array_get(rt.new_string('_variation_fields')))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_response := if rt.is_true(var_request.get_param(rt.new_string('force'))) { rt.call_method(var_generator, 'force_regeneration', [
			var_params.clone(),
		]) } else { rt.call_method(var_generator, 'get_status', [
			var_params.clone()]) }
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if var_response.array_isset(rt.new_string('scheduled_at')) {
		var_response.array_set('scheduled_at', rt.call_function('wc_rest_prepare_date_response', [
			var_response.array_get(rt.new_string('scheduled_at')),
		]))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if var_response.array_isset(rt.new_string('completed_at')) {
		var_response.array_set('completed_at', rt.call_function('wc_rest_prepare_date_response', [
			var_response.array_get(rt.new_string('completed_at')),
		]))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if var_response.array_isset(rt.new_string('action_id')) {
		var_response.array_unset(rt.new_string('action_id'))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if var_response.array_isset(rt.new_string('path')) {
		var_response.array_unset(rt.new_string('path'))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1,
		'Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_Exception')
	{
		mut var_e := var_e_1.clone()
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [
			rt.new_string('Feed generation failed'),
			rt.create_array([
				rt.ArrayItem{ key: 'error', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) },
			]),
		])
		return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(rt.create_array([
			rt.ArrayItem{ key: 'success', val: false },
			rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
				rt.new_string('An error occurred while generating the feed.'),
				rt.new_string('woocommerce'),
			]) },
		]), rt.new_int(500)))
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
	return rt.new_object('WP_REST_Response', []string{},
		create_wp_rest_response(var_response.clone()))
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_productfeed_integrations_poscatalog_apicontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_ApiController {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_ApiController{
		PhpObjectBase: rt.PhpObjectBase{}
		container:     rt.new_null()
	}
	return obj
}

fn create_wp_rest_response(_args ...rt.PhpVal) &Class_WP_REST_Response {
	mut obj := &Class_WP_REST_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_ApiController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Container](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'is_authorized' {
			return rt.new_bool(this.is_authorized())
		}
		'generate_feed' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.generate_feed(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_ApiController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'container' { return this.container }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_ApiController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'container' {
			this.container = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
