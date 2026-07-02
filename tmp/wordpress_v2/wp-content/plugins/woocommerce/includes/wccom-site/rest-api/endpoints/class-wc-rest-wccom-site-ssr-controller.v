import rt

struct Class_WC_REST_WCCOM_Site_SSR_Controller {
	rt.PhpObjectBase
pub mut:
	rest_base rt.PhpVal = rt.new_string('ssr')
}

fn (mut this Class_WC_REST_WCCOM_Site_SSR_Controller) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WC_REST_WCCOM_Site_SSR_Controller', [
			'WC_REST_WCCOM_Site_Controller',
		], &this), 'namespace'),
		rt.new_string('/' + (this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_WCCOM_Site_SSR_Controller', [
						'WC_REST_WCCOM_Site_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'handle_ssr_request' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_WCCOM_Site_SSR_Controller', [
						'WC_REST_WCCOM_Site_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'check_permission' },
				]) },
			]) },
		]),
	])
}

fn (mut this Class_WC_REST_WCCOM_Site_SSR_Controller) user_has_permission(var_user rt.PhpVal) bool {
	return (rt.call_function('user_can', [var_user.clone(), rt.new_string('manage_woocommerce')])).to_bool()
}

fn (mut this Class_WC_REST_WCCOM_Site_SSR_Controller) handle_ssr_request(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_ssr_controller := create_wc_rest_system_status_controller()
	mut var_data := var_ssr_controller.get_items(var_request_mutated.clone())
	var_data = rt.call_method(var_data, 'get_data', []rt.PhpVal{})
	mut iife_temp_0 := Class_WC_Helper_API{}
	mut iife_result_0 := iife_temp_0.post(rt.new_string('ssr'), rt.create_array([
		rt.ArrayItem{ key: 'body', val: rt.call_function('wp_json_encode', [
			rt.create_array([rt.ArrayItem{ key: 'data', val: var_data }]),
		]) },
		rt.ArrayItem{ key: 'authenticated', val: true },
	]))
	var_request_mutated = iife_result_0
	mut var_response_code := rt.call_function('wp_remote_retrieve_response_code', [
		var_request_mutated.clone(),
	])
	if rt.is_true(rt.identical(rt.new_int(201), var_response_code)) {
		mut var_response := rt.call_function('rest_ensure_response', [
			rt.create_array([rt.ArrayItem{ key: 'success', val: true },
				rt.ArrayItem{ key: 'message', val: 'SSR data submitted successfully' }]),
		])
	} else {
		var_response = rt.call_function('rest_ensure_response', [
			rt.create_array([rt.ArrayItem{ key: 'success', val: false },
				rt.ArrayItem{ key: 'error_code', val: 'failed_submitting_ssr' },
				rt.ArrayItem{
					key: 'error_message'
					val: 'Submitting SSR data failed with response code: ${var_response_code.to_string()}'
				}]),
		])
	}
	return var_response.clone()
}

struct Class_WC_REST_WCCOM_Site_Controller {
	rt.PhpObjectBase
}

struct Class_WC_REST_System_Status_Controller {
	rt.PhpObjectBase
}

struct Class_WC_Helper_API {
	rt.PhpObjectBase
}

fn create_wc_rest_wccom_site_ssr_controller(_args ...rt.PhpVal) &Class_WC_REST_WCCOM_Site_SSR_Controller {
	mut obj := &Class_WC_REST_WCCOM_Site_SSR_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		rest_base:     rt.new_string('ssr')
	}
	return obj
}

fn create_wc_rest_wccom_site_controller(_args ...rt.PhpVal) &Class_WC_REST_WCCOM_Site_Controller {
	mut obj := &Class_WC_REST_WCCOM_Site_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_rest_system_status_controller(_args ...rt.PhpVal) &Class_WC_REST_System_Status_Controller {
	mut obj := &Class_WC_REST_System_Status_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper_api(_args ...rt.PhpVal) &Class_WC_Helper_API {
	mut obj := &Class_WC_Helper_API{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_WCCOM_Site_SSR_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'user_has_permission' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.user_has_permission(dispatch_arg_0))
		}
		'handle_ssr_request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.handle_ssr_request(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_REST_WCCOM_Site_SSR_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_WCCOM_Site_SSR_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_base' {
			this.rest_base = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_REST_WCCOM_Site_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_WCCOM_Site_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_WCCOM_Site_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_REST_System_Status_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_System_Status_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_System_Status_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Helper_API) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper_API) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_API) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
