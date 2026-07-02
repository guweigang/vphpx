import rt

struct Class_WP_REST_Site_Health_Controller {
	rt.PhpObjectBase
pub mut:
	site_health rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_REST_Site_Health_Controller) construct(var_site_health rt.PhpVal) {
	this.dispatch_set_prop('namespace', rt.new_string('wp-site-health/v1'))
	this.dispatch_set_prop('rest_base', rt.new_string('tests'))
	this.site_health = var_site_health.clone()
}

fn (mut this Class_WP_REST_Site_Health_Controller) register_routes() {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
	}
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Site_Health_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.call_function('sprintf', [
			rt.new_string('/%s/%s'),
			rt.get_property(rt.new_object('WP_REST_Site_Health_Controller', [
				'WP_REST_Controller',
			], &this), 'rest_base'),
			rt.new_string('background-updates'),
		]),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: 'GET' },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Site_Health_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'test_background_updates' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_1_fn) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Site_Health_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
	}
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Site_Health_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.call_function('sprintf', [
			rt.new_string('/%s/%s'),
			rt.get_property(rt.new_object('WP_REST_Site_Health_Controller', [
				'WP_REST_Controller',
			], &this), 'rest_base'),
			rt.new_string('loopback-requests'),
		]),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: 'GET' },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Site_Health_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'test_loopback_requests' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_2_fn) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Site_Health_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
	}
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Site_Health_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.call_function('sprintf', [
			rt.new_string('/%s/%s'),
			rt.get_property(rt.new_object('WP_REST_Site_Health_Controller', [
				'WP_REST_Controller',
			], &this), 'rest_base'),
			rt.new_string('https-status'),
		]),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: 'GET' },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Site_Health_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'test_https_status' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_3_fn) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Site_Health_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
	}
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Site_Health_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.call_function('sprintf', [
			rt.new_string('/%s/%s'),
			rt.get_property(rt.new_object('WP_REST_Site_Health_Controller', [
				'WP_REST_Controller',
			], &this), 'rest_base'),
			rt.new_string('dotorg-communication'),
		]),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: 'GET' },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Site_Health_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'test_dotorg_communication' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_4_fn) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Site_Health_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
	}
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Site_Health_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.call_function('sprintf', [
			rt.new_string('/%s/%s'),
			rt.get_property(rt.new_object('WP_REST_Site_Health_Controller', [
				'WP_REST_Controller',
			], &this), 'rest_base'),
			rt.new_string('authorization-header'),
		]),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: 'GET' },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Site_Health_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'test_authorization_header' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_5_fn) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Site_Health_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
	}
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Site_Health_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.call_function('sprintf', [
			rt.new_string('/%s'),
			rt.new_string('directory-sizes'),
		]),
		rt.create_array([
			rt.ArrayItem{ key: 'methods', val: 'GET' },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Site_Health_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_directory_sizes' },
			]) },
			rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_6_fn) },
		]),
	])
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
	}
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Site_Health_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.call_function('sprintf', [
			rt.new_string('/%s/%s'),
			rt.get_property(rt.new_object('WP_REST_Site_Health_Controller', [
				'WP_REST_Controller',
			], &this), 'rest_base'),
			rt.new_string('page-cache'),
		]),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: 'GET' },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Site_Health_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'test_page_cache' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_7_fn) },
			]) },
		]),
	])
}

fn (mut this Class_WP_REST_Site_Health_Controller) validate_request_permission(var_check rt.PhpVal) rt.PhpVal {
	mut var_default_capability := rt.new_string('view_site_health_checks')
	mut var_capability := rt.call_function('apply_filters', [
		rt.new_string('site_health_test_rest_capability_${var_check.to_string()}'),
		var_default_capability.clone(),
		var_check.clone(),
	])
	return rt.call_function('current_user_can', [var_capability.clone()])
}

fn (mut this Class_WP_REST_Site_Health_Controller) test_background_updates() rt.PhpVal {
	this.load_admin_textdomain()
	return rt.call_method(this.site_health, 'get_test_background_updates', []rt.PhpVal{})
}

fn (mut this Class_WP_REST_Site_Health_Controller) test_dotorg_communication() rt.PhpVal {
	this.load_admin_textdomain()
	return rt.call_method(this.site_health, 'get_test_dotorg_communication', []rt.PhpVal{})
}

fn (mut this Class_WP_REST_Site_Health_Controller) test_loopback_requests() rt.PhpVal {
	this.load_admin_textdomain()
	return rt.call_method(this.site_health, 'get_test_loopback_requests', []rt.PhpVal{})
}

fn (mut this Class_WP_REST_Site_Health_Controller) test_https_status() rt.PhpVal {
	this.load_admin_textdomain()
	return rt.call_method(this.site_health, 'get_test_https_status', []rt.PhpVal{})
}

fn (mut this Class_WP_REST_Site_Health_Controller) test_authorization_header() rt.PhpVal {
	this.load_admin_textdomain()
	return rt.call_method(this.site_health, 'get_test_authorization_header', []rt.PhpVal{})
}

fn (mut this Class_WP_REST_Site_Health_Controller) test_page_cache() rt.PhpVal {
	this.load_admin_textdomain()
	return rt.call_method(this.site_health, 'get_test_page_cache', []rt.PhpVal{})
}

fn (mut this Class_WP_REST_Site_Health_Controller) get_directory_sizes() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WP_Debug_Data'),
	])))))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-debug-data.php', '4')
	}
	this.load_admin_textdomain()
	mut iife_temp_7 := Class_WP_Debug_Data{}
	mut iife_result_7 := iife_temp_7.get_sizes()
	mut var_sizes_data := iife_result_7
	mut var_all_sizes := rt.create_array([rt.ArrayItem{ key: 'raw', val: 0 }])
	mut iter_1 := var_sizes_data.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_name := item_1.key
		var_name = rt.call_function('sanitize_text_field', [var_name.clone()])
		mut var_data := map[string]rt.PhpVal{}
		if var_value.array_isset(rt.new_string('size')) {
			if rt.is_true(rt.new_bool(var_value.array_get(rt.new_string('size')).is_string())) {
				var_data['size'] = rt.call_function('sanitize_text_field', [
					var_value.array_get(rt.new_string('size')),
				])
			} else {
				var_data['size'] = rt.new_int((var_value.array_get(rt.new_string('size'))).to_i64())
			}
		}
		if var_value.array_isset(rt.new_string('debug')) {
			if rt.is_true(rt.new_bool(var_value.array_get(rt.new_string('debug')).is_string())) {
				var_data['debug'] = rt.call_function('sanitize_text_field', [
					var_value.array_get(rt.new_string('debug')),
				])
			} else {
				var_data['debug'] =
					rt.new_int((var_value.array_get(rt.new_string('debug'))).to_i64())
			}
		}
		if !(!rt.is_true(var_value.array_get(rt.new_string('raw')))) {
			var_data['raw'] = rt.new_int((var_value.array_get(rt.new_string('raw'))).to_i64())
		}
		var_all_sizes.array_set(var_name, var_data.clone())
	}
	if var_all_sizes.array_get(rt.new_string('total_size')).array_isset(rt.new_string('debug'))
		&& rt.is_true(rt.identical(rt.new_string('not available'), var_all_sizes.array_get(rt.new_string('total_size')).array_get(rt.new_string('debug')))) {
		return create_wp_error(rt.new_string('not_available'), rt.call_function('__', [
			rt.new_string('Directory sizes could not be returned.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
	}
	return var_all_sizes.clone()
}

fn (mut this Class_WP_REST_Site_Health_Controller) load_admin_textdomain() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		mut var_locale := rt.call_function('determine_locale', []rt.PhpVal{})
		rt.call_function('load_textdomain', [rt.new_string('default'),
			rt.new_string(
				(rt.get_constant('WP_LANG_DIR')).str() + '/admin-${var_locale.to_string()}.mo'),
			var_locale.clone()])
	}
}

fn (mut this Class_WP_REST_Site_Health_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Site_Health_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
	{
		return rt.get_property(rt.new_object('WP_REST_Site_Health_Controller', [
			'WP_REST_Controller',
		], &this), 'schema')
	}
	this.dispatch_set_prop('schema', rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'wp-site-health-test' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'test', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The name of the test being run.'),
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'label', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('A label describing the test.'),
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'status', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The status of the test.'),
				]) },
				rt.ArrayItem{ key: 'enum', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'good' },
					rt.ArrayItem{ key: none, val: 'recommended' },
					rt.ArrayItem{ key: none, val: 'critical' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'badge', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The category this test is grouped in.'),
				]) },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'label', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'color', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'enum', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'blue' },
							rt.ArrayItem{ key: none, val: 'orange' },
							rt.ArrayItem{ key: none, val: 'red' },
							rt.ArrayItem{ key: none, val: 'green' },
							rt.ArrayItem{ key: none, val: 'purple' },
							rt.ArrayItem{ key: none, val: 'gray' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'description', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('A more descriptive explanation of what the test looks for, and why it is important for the user.'),
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'actions', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('HTML containing an action to direct the user to where they can resolve the issue.'),
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
		]) },
	]))
	return rt.get_property(rt.new_object('WP_REST_Site_Health_Controller', [
		'WP_REST_Controller',
	], &this), 'schema')
}

struct Class_WP_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Debug_Data {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_rest_site_health_controller(arg_0 rt.PhpVal) &Class_WP_REST_Site_Health_Controller {
	mut obj := &Class_WP_REST_Site_Health_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		site_health:   rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_rest_controller(_args ...rt.PhpVal) &Class_WP_REST_Controller {
	mut obj := &Class_WP_REST_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_debug_data(_args ...rt.PhpVal) &Class_WP_Debug_Data {
	mut obj := &Class_WP_Debug_Data{
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

fn (mut this Class_WP_REST_Site_Health_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'validate_request_permission' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.validate_request_permission(dispatch_arg_0)
		}
		'test_background_updates' {
			return this.test_background_updates()
		}
		'test_dotorg_communication' {
			return this.test_dotorg_communication()
		}
		'test_loopback_requests' {
			return this.test_loopback_requests()
		}
		'test_https_status' {
			return this.test_https_status()
		}
		'test_authorization_header' {
			return this.test_authorization_header()
		}
		'test_page_cache' {
			return this.test_page_cache()
		}
		'get_directory_sizes' {
			return this.get_directory_sizes()
		}
		'load_admin_textdomain' {
			this.load_admin_textdomain()
			return rt.new_null()
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_REST_Site_Health_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'site_health' { return this.site_health }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Site_Health_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'site_health' {
			this.site_health = val
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

fn (mut this Class_WP_Debug_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Debug_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Debug_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
}
