import rt

struct Class_WC_REST_Telemetry_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc-telemetry')
	rest_base rt.PhpVal = rt.new_string('tracker')
}

fn (mut this Class_WC_REST_Telemetry_Controller) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' +
		(this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Telemetry_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'record_usage_data' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Telemetry_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'telemetry_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Telemetry_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
}

fn (mut this Class_WC_REST_Telemetry_Controller) telemetry_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [
			rt.new_string('Sorry, you post telemetry data.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Telemetry_Controller) record_usage_data(var_request rt.PhpVal) {
	mut var_new := this.get_usage_data(var_request.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_new))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_new.array_get(rt.new_string('platform')))))) {
		return
	}
	mut var_data := rt.call_function('get_option', [
		rt.new_string('woocommerce_mobile_app_usage'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_data)))) {
		var_data = rt.new_array()
	}
	mut var_platform := var_new.array_get(rt.new_string('platform'))
	if var_data.array_isset(var_platform) {
		mut var_existing_usage := var_data.array_get(var_platform)
		if var_new.array_isset(rt.new_string('installation_date'))
			&& !(var_existing_usage.array_isset(rt.new_string('installation_date'))) {
			var_data.array_get_mut(var_platform).array_set('installation_date',
				var_new.array_get(rt.new_string('installation_date')))
		}
		if rt.is_true(rt.call_function('version_compare', [
			var_new.array_get(rt.new_string('version')),
			var_existing_usage.array_get(rt.new_string('version')),
			rt.new_string('>='),
		]))
		{
			var_data.array_get_mut(var_platform).array_set('version',
				var_new.array_get(rt.new_string('version')))
			var_data.array_get_mut(var_platform).array_set('last_used',
				var_new.array_get(rt.new_string('last_used')))
		}
	} else {
		var_new.array_set('first_used', var_new.array_get(rt.new_string('last_used')))
		var_data.array_set(var_platform, var_new.clone())
	}
	rt.call_function('update_option', [rt.new_string('woocommerce_mobile_app_usage'),
		var_data.clone()])
}

fn (mut this Class_WC_REST_Telemetry_Controller) get_usage_data(var_request rt.PhpVal) rt.PhpVal {
	mut var_platform := rt.new_string(rt.call_method(var_request, 'get_param', [
		rt.new_string('platform'),
	]).to_string().to_lower())
	mut switch_val_1 := var_platform
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('ios')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('android'))) {
	} else {
		return rt.new_null()
	}
	mut var_version := rt.call_method(var_request, 'get_param', [
		rt.new_string('version'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_version)))) {
		return rt.new_null()
	}
	mut var_installation_date := rt.call_method(var_request, 'get_param', [
		rt.new_string('installation_date'),
	])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_value)))
	}
	return rt.call_function('array_filter', [
		rt.create_array([
			rt.ArrayItem{ key: 'platform', val: rt.call_function('sanitize_text_field', [
				var_platform.clone(),
			]) },
			rt.ArrayItem{ key: 'version', val: rt.call_function('sanitize_text_field', [
				var_version.clone(),
			]) },
			rt.ArrayItem{ key: 'last_used', val: rt.call_function('gmdate', [
				rt.new_string('c'),
			]) },
			rt.ArrayItem{
				key: 'installation_date'
				val: if !var_installation_date.is_null() { rt.call_function('get_gmt_from_date', [
						var_installation_date.clone(),
						rt.new_string('c'),
					]) } else { rt.new_null() }
			},
		]),
		rt.new_closure(closure_1_fn),
	])
}

fn (mut this Class_WC_REST_Telemetry_Controller) get_collection_params() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'platform', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Platform to track.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
			rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		]) },
		rt.ArrayItem{ key: 'version', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Platform version to track.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
			rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		]) },
		rt.ArrayItem{ key: 'installation_date', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Installation date of the WooCommerce mobile app.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'required', val: false },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'format', val: 'date-time' },
			rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		]) },
	])
}

struct Class_WC_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_rest_telemetry_controller(_args ...rt.PhpVal) &Class_WC_REST_Telemetry_Controller {
	mut obj := &Class_WC_REST_Telemetry_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc-telemetry')
		rest_base:     rt.new_string('tracker')
	}
	return obj
}

fn create_wc_rest_controller(_args ...rt.PhpVal) &Class_WC_REST_Controller {
	mut obj := &Class_WC_REST_Controller{
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

fn (mut this Class_WC_REST_Telemetry_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'telemetry_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.telemetry_permissions_check(dispatch_arg_0))
		}
		'record_usage_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.record_usage_data(dispatch_arg_0)
			return rt.new_null()
		}
		'get_usage_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_usage_data(dispatch_arg_0)
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_REST_Telemetry_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Telemetry_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		'rest_base' {
			this.rest_base = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_REST_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
