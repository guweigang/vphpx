import rt

pub fn Class_WC_REST_WCCOM_Site_Connection_Controller.connection_data_found() string {
	return 'connection_data_found'
}

pub fn Class_WC_REST_WCCOM_Site_Connection_Controller.connection_valid() string {
	return 'connection_valid'
}

struct Class_WC_REST_WCCOM_Site_Connection_Controller {
	rt.PhpObjectBase
pub mut:
	rest_base rt.PhpVal = rt.new_string('connection')
}

fn (mut this Class_WC_REST_WCCOM_Site_Connection_Controller) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WC_REST_WCCOM_Site_Connection_Controller', [
			'WC_REST_WCCOM_Site_Controller',
		], &this), 'namespace'),
		rt.new_string('/' + (this.rest_base).str() + '/disconnect'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_WCCOM_Site_Connection_Controller', [
						'WC_REST_WCCOM_Site_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'handle_disconnect_request' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_WCCOM_Site_Connection_Controller', [
						'WC_REST_WCCOM_Site_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'check_permission' },
				]) },
			]) },
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WC_REST_WCCOM_Site_Connection_Controller', [
			'WC_REST_WCCOM_Site_Controller',
		], &this), 'namespace'),
		rt.new_string('/' + (this.rest_base).str() + '/status'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_WCCOM_Site_Connection_Controller', [
						'WC_REST_WCCOM_Site_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'handle_status_request' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_WCCOM_Site_Connection_Controller', [
						'WC_REST_WCCOM_Site_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'check_permission' },
				]) },
			]) },
		]),
	])
}

fn (mut this Class_WC_REST_WCCOM_Site_Connection_Controller) user_has_permission(var_user rt.PhpVal) bool {
	return
		rt.is_true(rt.call_function('user_can', [var_user.clone(), rt.new_string('install_plugins')]))
		&& rt.is_true(rt.call_function('user_can', [var_user.clone(), rt.new_string('activate_plugins')]))
}

fn (mut this Class_WC_REST_WCCOM_Site_Connection_Controller) handle_disconnect_request(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_hash := var_request.array_get(rt.new_string('hash'))
	mut iife_temp_0 := Class_WC_Helper{}
	mut iife_result_0 := iife_temp_0.verify_request_hash(var_request_hash.clone())
	if !rt.is_true(var_request_hash) || rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		return this.get_response(rt.new_array(), rt.new_int(403))
	}
	mut iife_temp_1 := Class_WC_Helper{}
	mut iife_result_1 := iife_temp_1.is_site_connected()
	if rt.is_true(iife_result_1) {
		mut iife_temp_2 := Class_WC_Helper{}
		mut iife_result_2 := iife_temp_2.disconnect()
	}
	return this.get_response(rt.create_array([rt.ArrayItem{ key: 'status', val: true }]))
}

fn (mut this Class_WC_REST_WCCOM_Site_Connection_Controller) handle_status_request() rt.PhpVal {
	mut iife_temp_3 := Class_WC_Helper_Options{}
	mut iife_result_3 := iife_temp_3.get(rt.new_string('auth'))
	mut var_auth := iife_result_3
	if !rt.is_true(var_auth.array_get(rt.new_string('access_token')))
		|| !rt.is_true(var_auth.array_get(rt.new_string('access_token_secret'))) {
		return this.get_response(rt.create_array([
			rt.ArrayItem{
				key: Class_WC_REST_WCCOM_Site_Connection_Controller.connection_data_found()
				val: false
			},
			rt.ArrayItem{
				key: Class_WC_REST_WCCOM_Site_Connection_Controller.connection_valid()
				val: false
			},
		]))
	}
	mut iife_temp_4 := Class_WC_Helper{}
	mut iife_result_4 := iife_temp_4.fetch_helper_connection_info()
	mut var_connection_data := iife_result_4
	if rt.is_true(rt.new_bool(rt.instance_of(var_connection_data, 'WP_Error'))) {
		return var_connection_data.clone()
	}
	if rt.is_true(rt.identical(rt.new_null(), var_connection_data)) {
		return this.get_response(rt.create_array([
			rt.ArrayItem{
				key: Class_WC_REST_WCCOM_Site_Connection_Controller.connection_data_found()
				val: true
			},
			rt.ArrayItem{
				key: Class_WC_REST_WCCOM_Site_Connection_Controller.connection_valid()
				val: false
			},
		]))
	}
	return this.get_response(rt.call_function('array_merge', [
		rt.create_array([
			rt.ArrayItem{
				key: Class_WC_REST_WCCOM_Site_Connection_Controller.connection_data_found()
				val: true
			},
			rt.ArrayItem{
				key: Class_WC_REST_WCCOM_Site_Connection_Controller.connection_valid()
				val: true
			},
		]),
		var_connection_data.clone(),
	]))
}

struct Class_WC_REST_WCCOM_Site_Controller {
	rt.PhpObjectBase
}

struct Class_WC_Helper {
	rt.PhpObjectBase
}

struct Class_WC_Helper_Options {
	rt.PhpObjectBase
}

fn create_wc_rest_wccom_site_connection_controller(_args ...rt.PhpVal) &Class_WC_REST_WCCOM_Site_Connection_Controller {
	mut obj := &Class_WC_REST_WCCOM_Site_Connection_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		rest_base:     rt.new_string('connection')
	}
	return obj
}

fn create_wc_rest_wccom_site_controller(_args ...rt.PhpVal) &Class_WC_REST_WCCOM_Site_Controller {
	mut obj := &Class_WC_REST_WCCOM_Site_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper(_args ...rt.PhpVal) &Class_WC_Helper {
	mut obj := &Class_WC_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper_options(_args ...rt.PhpVal) &Class_WC_Helper_Options {
	mut obj := &Class_WC_Helper_Options{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_WCCOM_Site_Connection_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'user_has_permission' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.user_has_permission(dispatch_arg_0))
		}
		'handle_disconnect_request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.handle_disconnect_request(dispatch_arg_0)
		}
		'handle_status_request' {
			return this.handle_status_request()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_REST_WCCOM_Site_Connection_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_WCCOM_Site_Connection_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Helper_Options) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper_Options) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_Options) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
