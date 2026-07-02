import rt

struct Class_Akismet_REST_API {
	rt.PhpObjectBase
}

fn Class_Akismet_REST_API.init() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('register_rest_route'),
	])))))
	{
		return false
	}
	rt.call_function('register_rest_route', [rt.new_string('akismet/v1'),
		rt.new_string('/key'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'Akismet_REST_API' },
					rt.ArrayItem{ key: none, val: 'privileged_permission_callback' },
				]) },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'Akismet_REST_API' },
					rt.ArrayItem{ key: none, val: 'get_key' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'Akismet_REST_API' },
					rt.ArrayItem{ key: none, val: 'privileged_permission_callback' },
				]) },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'Akismet_REST_API' },
					rt.ArrayItem{ key: none, val: 'set_key' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'key', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: true },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'Akismet_REST_API' },
							rt.ArrayItem{ key: none, val: 'sanitize_key' },
						]) },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('A 12-character Akismet API key. Available at akismet.com/account'),
							rt.new_string('akismet'),
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'Akismet_REST_API' },
					rt.ArrayItem{ key: none, val: 'privileged_permission_callback' },
				]) },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'Akismet_REST_API' },
					rt.ArrayItem{ key: none, val: 'delete_key' },
				]) },
			]) },
		])])
	rt.call_function('register_rest_route', [rt.new_string('akismet/v1'),
		rt.new_string('/settings/'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'Akismet_REST_API' },
					rt.ArrayItem{ key: none, val: 'privileged_permission_callback' },
				]) },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'Akismet_REST_API' },
					rt.ArrayItem{ key: none, val: 'get_settings' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'Akismet_REST_API' },
					rt.ArrayItem{ key: none, val: 'privileged_permission_callback' },
				]) },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'Akismet_REST_API' },
					rt.ArrayItem{ key: none, val: 'set_boolean_settings' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'akismet_strictness', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'type', val: 'boolean' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('If true, Akismet will automatically discard the worst spam automatically rather than putting it in the spam folder.'),
							rt.new_string('akismet'),
						]) },
					]) },
					rt.ArrayItem{ key: 'akismet_show_user_comments_approved', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'type', val: 'boolean' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('If true, show the number of approved comments beside each comment author in the comments list page.'),
							rt.new_string('akismet'),
						]) },
					]) },
					rt.ArrayItem{ key: 'akismet_enable_mcp_access', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'type', val: 'boolean' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('If true, allow MCP clients to access Akismet data and functionality.'),
							rt.new_string('akismet'),
						]) },
					]) },
				]) },
			]) },
		])])
	rt.call_function('register_rest_route', [rt.new_string('akismet/v1'),
		rt.new_string('/stats'),
		rt.create_array([
			rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
			rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'Akismet_REST_API' },
				rt.ArrayItem{ key: none, val: 'privileged_permission_callback' },
			]) },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'Akismet_REST_API' },
				rt.ArrayItem{ key: none, val: 'get_stats' },
			]) },
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'interval', val: rt.create_array([
					rt.ArrayItem{ key: 'required', val: false },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'Akismet_REST_API' },
						rt.ArrayItem{ key: none, val: 'sanitize_interval' },
					]) },
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('The time period for which to retrieve stats. Options: 60-days, 6-months, all'),
						rt.new_string('akismet'),
					]) },
					rt.ArrayItem{ key: 'default', val: 'all' },
				]) },
			]) },
		])])
	rt.call_function('register_rest_route', [rt.new_string('akismet/v1'),
		rt.new_string('/stats/(?P<interval>[\\w+])'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'interval', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('The time period for which to retrieve stats. Options: 60-days, 6-months, all'),
						rt.new_string('akismet'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'Akismet_REST_API' },
					rt.ArrayItem{ key: none, val: 'privileged_permission_callback' },
				]) },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'Akismet_REST_API' },
					rt.ArrayItem{ key: none, val: 'get_stats' },
				]) },
			]) },
		])])
	rt.call_function('register_rest_route', [rt.new_string('akismet/v1'),
		rt.new_string('/alert'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'Akismet_REST_API' },
					rt.ArrayItem{ key: none, val: 'remote_call_permission_callback' },
				]) },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'Akismet_REST_API' },
					rt.ArrayItem{ key: none, val: 'get_alert' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'key', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'Akismet_REST_API' },
							rt.ArrayItem{ key: none, val: 'sanitize_key' },
						]) },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('A 12-character Akismet API key. Available at akismet.com/account'),
							rt.new_string('akismet'),
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'Akismet_REST_API' },
					rt.ArrayItem{ key: none, val: 'remote_call_permission_callback' },
				]) },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'Akismet_REST_API' },
					rt.ArrayItem{ key: none, val: 'set_alert' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'key', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'Akismet_REST_API' },
							rt.ArrayItem{ key: none, val: 'sanitize_key' },
						]) },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('A 12-character Akismet API key. Available at akismet.com/account'),
							rt.new_string('akismet'),
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'Akismet_REST_API' },
					rt.ArrayItem{ key: none, val: 'remote_call_permission_callback' },
				]) },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'Akismet_REST_API' },
					rt.ArrayItem{ key: none, val: 'delete_alert' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'key', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'Akismet_REST_API' },
							rt.ArrayItem{ key: none, val: 'sanitize_key' },
						]) },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('A 12-character Akismet API key. Available at akismet.com/account'),
							rt.new_string('akismet'),
						]) },
					]) },
				]) },
			]) },
		])])
	rt.call_function('register_rest_route', [rt.new_string('akismet/v1'),
		rt.new_string('/webhook'),
		rt.create_array([
			rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'Akismet_REST_API' },
				rt.ArrayItem{ key: none, val: 'receive_webhook' },
			]) },
			rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'Akismet_REST_API' },
				rt.ArrayItem{ key: none, val: 'remote_call_permission_callback' },
			]) },
		])])
	return false
}

fn Class_Akismet_REST_API.get_key(var_request rt.PhpVal) rt.PhpVal {
	mut iife_temp_0 := Class_Akismet{}
	mut iife_result_0 := iife_temp_0.get_api_key()
	mut iife_temp_1 := Class_Akismet{}
	mut iife_result_1 := iife_temp_1.get_api_key()
	return rt.call_function('rest_ensure_response', [iife_result_0])
}

fn Class_Akismet_REST_API.set_key(var_request rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('defined', [rt.new_string('WPCOM_API_KEY')])) {
		return rt.call_function('rest_ensure_response', [
			create_wp_error(rt.new_string('hardcoded_key'), rt.call_function('__', [
				rt.new_string("This site's API key is hardcoded and cannot be changed via the API."),
				rt.new_string('akismet'),
			]), rt.create_array([
				rt.ArrayItem{ key: 'status', val: 409 },
			])),
		])
	}
	mut var_new_api_key := rt.call_method(var_request, 'get_param', [
		rt.new_string('key'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Akismet_REST_API.key_is_valid(var_new_api_key.clone()))))) {
		return rt.call_function('rest_ensure_response', [
			create_wp_error(rt.new_string('invalid_key'), rt.call_function('__', [
				rt.new_string('The value provided is not a valid and registered API key.'),
				rt.new_string('akismet'),
			]), rt.create_array([
				rt.ArrayItem{ key: 'status', val: 400 },
			])),
		])
	}
	rt.call_function('update_option', [rt.new_string('wordpress_api_key'),
		var_new_api_key.clone()])
	return Class_Akismet_REST_API.get_key()
}

fn Class_Akismet_REST_API.delete_key(var_request rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('defined', [rt.new_string('WPCOM_API_KEY')])) {
		return rt.call_function('rest_ensure_response', [
			create_wp_error(rt.new_string('hardcoded_key'), rt.call_function('__', [
				rt.new_string("This site's API key is hardcoded and cannot be deleted."),
				rt.new_string('akismet'),
			]), rt.create_array([
				rt.ArrayItem{ key: 'status', val: 409 },
			])),
		])
	}
	rt.call_function('delete_option', [rt.new_string('wordpress_api_key')])
	return rt.call_function('rest_ensure_response', [rt.new_bool(true)])
}

fn Class_Akismet_REST_API.get_settings(var_request rt.PhpVal) rt.PhpVal {
	return rt.call_function('rest_ensure_response', [
		rt.create_array([
			rt.ArrayItem{ key: 'akismet_strictness', val: rt.identical(rt.call_function('get_option', [
				rt.new_string('akismet_strictness'),
				rt.new_string('1'),
			]), rt.new_string('1')) },
			rt.ArrayItem{ key: 'akismet_show_user_comments_approved', val: rt.identical(rt.call_function('get_option', [
				rt.new_string('akismet_show_user_comments_approved'),
				rt.new_string('1'),
			]), rt.new_string('1')) },
			rt.ArrayItem{ key: 'akismet_enable_mcp_access', val: rt.identical(rt.call_function('get_option', [
				rt.new_string('akismet_enable_mcp_access'),
				rt.new_string('0'),
			]), rt.new_string('1')) },
		]),
	])
}

fn Class_Akismet_REST_API.set_boolean_settings(var_request rt.PhpVal) rt.PhpVal {
	mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'akismet_strictness' },
		rt.ArrayItem{ key: none, val: 'akismet_show_user_comments_approved' },
		rt.ArrayItem{ key: none, val: 'akismet_enable_mcp_access' }]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_setting_key := item_1.val
		mut var_setting_value := rt.call_method(var_request, 'get_param', [
			var_setting_key.clone()])
		if rt.is_true(rt.new_bool(var_setting_value.clone().is_null())) {
			continue
		}
		var_setting_value = Class_Akismet_REST_API.parse_boolean(var_setting_value.clone())
		rt.call_function('update_option', [var_setting_key.clone(),
			rt.new_string((if rt.is_true(var_setting_value) { '1' } else { '0' }).str())])
	}
	return Class_Akismet_REST_API.get_settings()
}

fn Class_Akismet_REST_API.parse_boolean(var_value rt.PhpVal) bool {
	mut switch_val_1 := var_value
	if rt.is_true(rt.equal(switch_val_1, rt.new_bool(true)))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('true')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('1')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_int(1))) {
		return true
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(false)))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('false')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('0')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_int(0))) {
		return false
	} else {
		return var_value.to_bool()
	}
	return false
}

fn Class_Akismet_REST_API.get_stats(var_request rt.PhpVal) rt.PhpVal {
	mut iife_temp_2 := Class_Akismet{}
	mut iife_result_2 := iife_temp_2.get_api_key()
	mut var_api_key := iife_result_2
	mut var_interval := rt.call_method(var_request, 'get_param', [
		rt.new_string('interval'),
	])
	mut var_stat_totals := rt.new_array()
	mut var_request_args := rt.create_array([
		rt.ArrayItem{ key: 'blog', val: rt.call_function('get_option', [
			rt.new_string('home'),
		]) },
		rt.ArrayItem{ key: 'key', val: var_api_key },
		rt.ArrayItem{ key: 'from', val: var_interval },
	])
	var_request_args = rt.call_function('apply_filters', [
		rt.new_string('akismet_request_args'),
		var_request_args.clone(),
		rt.new_string('get-stats'),
	])
	mut iife_temp_3 := Class_Akismet{}
	mut iife_result_3 := iife_temp_3.build_query(var_request_args.clone())
	mut iife_temp_4 := Class_Akismet{}
	mut iife_result_4 := iife_temp_4.http_post(iife_result_3, rt.new_string('get-stats'))
	mut var_response := iife_result_4
	if !(!rt.is_true(var_response.array_get(rt.new_int(1)))) {
		var_stat_totals.array_set(var_interval, rt.call_function('json_decode', [
			var_response.array_get(rt.new_int(1)),
		]))
	}
	return rt.call_function('rest_ensure_response', [var_stat_totals.clone()])
}

fn Class_Akismet_REST_API.get_alert(var_request rt.PhpVal) rt.PhpVal {
	return rt.call_function('rest_ensure_response', [
		rt.create_array([
			rt.ArrayItem{ key: 'code', val: rt.call_function('get_option', [
				rt.new_string('akismet_alert_code'),
			]) },
			rt.ArrayItem{ key: 'message', val: rt.call_function('get_option', [
				rt.new_string('akismet_alert_msg'),
			]) },
		]),
	])
}

fn Class_Akismet_REST_API.set_alert(var_request rt.PhpVal) rt.PhpVal {
	rt.call_function('delete_option', [rt.new_string('akismet_alert_code')])
	rt.call_function('delete_option', [rt.new_string('akismet_alert_msg')])
	mut iife_temp_5 := Class_Akismet{}
	mut iife_result_5 := iife_temp_5.get_api_key()
	mut iife_temp_6 := Class_Akismet{}
	mut iife_result_6 := iife_temp_6.verify_key(iife_result_5)
	return Class_Akismet_REST_API.get_alert(var_request.clone())
}

fn Class_Akismet_REST_API.delete_alert(var_request rt.PhpVal) rt.PhpVal {
	rt.call_function('delete_option', [rt.new_string('akismet_alert_code')])
	rt.call_function('delete_option', [rt.new_string('akismet_alert_msg')])
	return Class_Akismet_REST_API.get_alert(var_request.clone())
}

fn Class_Akismet_REST_API.key_is_valid(var_key rt.PhpVal) bool {
	mut var_request_args := rt.create_array([rt.ArrayItem{ key: 'key', val: var_key },
		rt.ArrayItem{ key: 'blog', val: rt.call_function('get_option', [
			rt.new_string('home'),
		]) }])
	var_request_args = rt.call_function('apply_filters', [
		rt.new_string('akismet_request_args'),
		var_request_args.clone(),
		rt.new_string('verify-key'),
	])
	mut iife_temp_7 := Class_Akismet{}
	mut iife_result_7 := iife_temp_7.build_query(var_request_args.clone())
	mut iife_temp_8 := Class_Akismet{}
	mut iife_result_8 := iife_temp_8.http_post(iife_result_7, rt.new_string('verify-key'))
	mut var_response := iife_result_8
	if rt.is_true(rt.equal(var_response.array_get(rt.new_int(1)), rt.new_string('valid'))) {
		return true
	}
	return false
}

fn Class_Akismet_REST_API.privileged_permission_callback() rt.PhpVal {
	return rt.call_function('current_user_can', [rt.new_string('manage_options')])
}

fn Class_Akismet_REST_API.remote_call_permission_callback(var_request rt.PhpVal) bool {
	mut iife_temp_9 := Class_Akismet{}
	mut iife_result_9 := iife_temp_9.get_api_key()
	mut var_local_key := iife_result_9
	return rt.is_true(var_local_key)
		&& rt.is_true(rt.identical(rt.new_string(if !(rt.call_method(var_request, 'get_param', [rt.new_string('key')])).is_null() { rt.call_method(var_request, 'get_param', [rt.new_string('key')]) } else { rt.new_string('') }.to_string().to_lower()), rt.new_string(var_local_key.clone().to_string().to_lower())))
}

fn Class_Akismet_REST_API.sanitize_interval(var_interval rt.PhpVal, var_request rt.PhpVal, var_param rt.PhpVal) rt.PhpVal {
	mut var_interval_mutated := var_interval
	var_interval_mutated = rt.new_string(var_interval_mutated.clone().to_string().trim_space())
	mut var_valid_intervals := ['60-days', '6-months', 'all']
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_interval_mutated.clone(), rt.create_array_from_list(var_valid_intervals)])))))
	{
		var_interval_mutated = rt.new_string('all')
	}
	return var_interval_mutated.clone()
}

fn Class_Akismet_REST_API.sanitize_key(var_key rt.PhpVal, var_request rt.PhpVal, var_param rt.PhpVal) string {
	return var_key.clone().to_string().trim_space()
}

fn Class_Akismet_REST_API.receive_webhook(var_request rt.PhpVal) rt.PhpVal {
	mut iife_temp_10 := Class_Akismet{}
	mut iife_result_10 := iife_temp_10.log(rt.create_array([
		rt.ArrayItem{ key: none, val: 'Webhook request received' },
		rt.ArrayItem{ key: none, val: rt.call_method(var_request, 'get_body', []rt.PhpVal{}) },
	]))
	mut var_response := rt.create_array([
		rt.ArrayItem{ key: 'comments', val: rt.new_array() },
	])
	mut var_endpoint := rt.call_method(var_request, 'get_param', [
		rt.new_string('endpoint'),
	])
	mut switch_val_2 := var_endpoint
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('comment-check'))) {
		mut var_webhook_comments := rt.call_method(var_request, 'get_param', [
			rt.new_string('comments'),
		])
		if !(var_webhook_comments.clone().is_array()) {
			return rt.call_function('rest_ensure_response', [
				create_wp_error(rt.new_string('malformed_request'), rt.call_function('__', [
					rt.new_string("The 'comments' parameter must be an array."),
					rt.new_string('akismet'),
				]), rt.create_array([
					rt.ArrayItem{ key: 'status', val: 400 },
				])),
			])
		}
		mut iter_2 := var_webhook_comments.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_webhook_comment := item_2.val
			mut var_guid := var_webhook_comment.array_get(rt.new_string('guid'))
			if rt.is_true(rt.new_bool(!(rt.is_true(var_guid)))) {
				continue
			}
			mut var_queryable_fields := rt.create_array([
				rt.ArrayItem{ key: 'comment_post_ID', val: 'post_id' },
				rt.ArrayItem{ key: 'comment_parent', val: 'parent' },
				rt.ArrayItem{ key: 'comment_author_email', val: 'author_email' },
			])
			mut var_query_args := rt.new_array()
			var_query_args.array_set('status', 'any')
			var_query_args.array_set('meta_key', 'akismet_guid')
			var_query_args.array_set('meta_value', var_guid.clone())
			mut iter_3 := var_queryable_fields.iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_wp_comment_query_field := item_3.val
				mut var_queryable_field := item_3.key
				if var_webhook_comment.array_isset(var_queryable_field) {
					var_query_args.array_set(var_wp_comment_query_field,
						var_webhook_comment.array_get(var_queryable_field))
				}
			}
			mut var_comments_query := create_wp_comment_query(var_query_args.clone())
			mut var_comments := rt.get_property(var_comments_query, 'comments')
			if rt.is_true(rt.new_bool(!(rt.is_true(var_comments)))) {
				mut iife_temp_11 := Class_Akismet{}
				mut iife_result_11 :=
					iife_temp_11.log(rt.new_string('Webhook failed: no matching comment found.'))
				var_response.array_get_mut('comments').array_set(var_guid, rt.create_array([
					rt.ArrayItem{ key: 'status', val: 'error' },
					rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
						rt.new_string('Could not find matching comment.'),
						rt.new_string('akismet'),
					]) },
				]))
				continue
			}
			if var_comments.clone().array_count() > 1 {
				mut iife_temp_12 := Class_Akismet{}
				mut iife_result_12 := iife_temp_12.log(rt.new_string('Webhook failed: multiple matching comments found.'),
					var_comments.clone())
				var_response.array_get_mut('comments').array_set(var_guid, rt.create_array([
					rt.ArrayItem{ key: 'status', val: 'error' },
					rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
						rt.new_string('Multiple comments matched request.'),
						rt.new_string('akismet'),
					]) },
				]))
				continue
			} else {
				mut iife_temp_13 := Class_Akismet{}
				mut iife_result_13 := iife_temp_13.log(rt.new_string('Found matching comment.'),
					var_comments.clone())
				mut var_comment := var_comments.array_get(rt.new_int(0))
				mut var_current_status := rt.call_function('wp_get_comment_status', [
					var_comment.clone(),
				])
				mut var_result := var_webhook_comment.array_get(rt.new_string('result'))
				if rt.is_true(rt.equal(rt.new_string('true'), var_result)) {
					mut iife_temp_14 := Class_Akismet{}
					mut iife_result_14 := iife_temp_14.log(rt.new_string('Comment should be spam'))
					if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.new_string('spam'),
						var_current_status))))
					{
						mut iife_temp_15 := Class_Akismet{}
						mut iife_result_15 := iife_temp_15.last_comment_status_change_came_from_akismet(rt.get_property(var_comment,
							'comment_ID'))
						if rt.is_true(iife_result_15) {
							mut iife_temp_16 := Class_Akismet{}
							mut iife_result_16 :=
								iife_temp_16.log(rt.new_string('Comment is not spam; marking as spam.'))
							rt.call_function('wp_spam_comment', [
								var_comment.clone()])
							mut iife_temp_17 := Class_Akismet{}
							mut iife_result_17 := iife_temp_17.update_comment_history(rt.get_property(var_comment,
								'comment_ID'), rt.new_string(''), rt.new_string('webhook-spam'))
						} else {
							mut iife_temp_18 := Class_Akismet{}
							mut iife_result_18 :=
								iife_temp_18.log(rt.new_string('Comment is not spam, but it has already been manually handled by some other process.'))
							mut iife_temp_19 := Class_Akismet{}
							mut iife_result_19 := iife_temp_19.update_comment_history(rt.get_property(var_comment,
								'comment_ID'), rt.new_string(''),
								rt.new_string('webhook-spam-noaction'))
						}
					}
				} else if rt.is_true(rt.equal(rt.new_string('false'), var_result)) {
					mut iife_temp_20 := Class_Akismet{}
					mut iife_result_20 := iife_temp_20.log(rt.new_string('Comment should be ham'))
					if rt.is_true(rt.equal(rt.new_string('spam'), var_current_status)) {
						mut iife_temp_21 := Class_Akismet{}
						mut iife_result_21 := iife_temp_21.log(rt.new_string('Comment is spam.'))
						mut iife_temp_22 := Class_Akismet{}
						mut iife_result_22 := iife_temp_22.last_comment_status_change_came_from_akismet(rt.get_property(var_comment,
							'comment_ID'))
						if rt.is_true(iife_result_22) {
							mut iife_temp_23 := Class_Akismet{}
							mut iife_result_23 :=
								iife_temp_23.log(rt.new_string('Akismet marked it as spam; unspamming.'))
							rt.call_function('wp_unspam_comment', [
								var_comment.clone()])
							mut iife_temp_24 := Class_akismet{}
							mut iife_result_24 := iife_temp_24.update_comment_history(rt.get_property(var_comment,
								'comment_ID'), rt.new_string(''), rt.new_string('webhook-ham'))
						} else {
							mut iife_temp_25 := Class_Akismet{}
							mut iife_result_25 :=
								iife_temp_25.log(rt.new_string('Comment is not spam, but it has already been manually handled by some other process.'))
							mut iife_temp_26 := Class_Akismet{}
							mut iife_result_26 := iife_temp_26.update_comment_history(rt.get_property(var_comment,
								'comment_ID'), rt.new_string(''),
								rt.new_string('webhook-ham-noaction'))
						}
					} else {
						if rt.is_true(rt.equal(rt.new_string('unapproved'), var_current_status)) {
							mut iife_temp_27 := Class_Akismet{}
							mut iife_result_27 :=
								iife_temp_27.log(rt.new_string('Comment is pending.'))
							mut iife_temp_28 := Class_Akismet{}
							mut iife_result_28 := iife_temp_28.last_comment_status_change_came_from_akismet(rt.get_property(var_comment,
								'comment_ID'))
							if rt.is_true(iife_result_28) {
								mut iife_temp_29 := Class_Akismet{}
								mut iife_result_29 :=
									iife_temp_29.log(rt.new_string('Akismet marked it as Pending; approving.'))
								if rt.is_true(rt.call_function('check_comment', [
									rt.get_property(var_comment, 'comment_author'),
									rt.get_property(var_comment, 'comment_author_email'),
									rt.get_property(var_comment, 'comment_author_url'),
									rt.get_property(var_comment, 'comment_content'),
									rt.get_property(var_comment, 'comment_author_IP'),
									rt.get_property(var_comment, 'comment_agent'),
									rt.get_property(var_comment, 'comment_type'),
								]))
								{
									rt.call_function('wp_set_comment_status', [
										rt.get_property(var_comment, 'comment_ID'),
										rt.new_int(1),
									])
								}
								mut iife_temp_30 := Class_akismet{}
								mut iife_result_30 := iife_temp_30.update_comment_history(rt.get_property(var_comment,
									'comment_ID'), rt.new_string(''), rt.new_string('webhook-ham'))
							} else {
								mut iife_temp_31 := Class_Akismet{}
								mut iife_result_31 :=
									iife_temp_31.log(rt.new_string('Comment is not spam, but it has already been manually handled by some other process.'))
								mut iife_temp_32 := Class_Akismet{}
								mut iife_result_32 := iife_temp_32.update_comment_history(rt.get_property(var_comment,
									'comment_ID'), rt.new_string(''),
									rt.new_string('webhook-ham-noaction'))
							}
						}
					}
					mut var_moderation_email_was_delayed := rt.call_function('get_comment_meta', [
						rt.get_property(var_comment, 'comment_ID'),
						rt.new_string('akismet_delayed_moderation_email'),
						rt.new_bool(true),
					])
					if rt.is_true(var_moderation_email_was_delayed) {
						mut iife_temp_33 := Class_Akismet{}
						mut iife_result_33 := iife_temp_33.log(rt.new_string(
							'Moderation email was delayed for comment #' +
							(rt.get_property(var_comment, 'comment_ID')).str() + '; sending now.'))
						rt.call_function('delete_comment_meta', [
							rt.get_property(var_comment, 'comment_ID'),
							rt.new_string('akismet_delayed_moderation_email'),
						])
						rt.call_function('wp_new_comment_notify_moderator', [
							rt.get_property(var_comment, 'comment_ID'),
						])
						rt.call_function('wp_new_comment_notify_postauthor', [
							rt.get_property(var_comment, 'comment_ID'),
						])
					}
					rt.call_function('delete_comment_meta', [
						rt.get_property(var_comment, 'comment_ID'),
						rt.new_string('akismet_delay_moderation_email'),
					])
				}
				var_response.array_get_mut('comments').array_set(var_guid, rt.create_array([
					rt.ArrayItem{ key: 'status', val: 'success' },
				]))
			}
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('submit-ham')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('submit-spam'))) {
	} else {
	}
	rt.call_function('do_action', [rt.new_string('akismet_webhook_received'),
		var_request.clone()])
	mut iife_temp_34 := Class_Akismet{}
	mut iife_result_34 := iife_temp_34.log(rt.new_string('Done processing webhook.'))
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

struct Class_Akismet {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Comment_Query {
	rt.PhpObjectBase
}

struct Class_akismet {
	rt.PhpObjectBase
}

fn create_akismet_rest_api(_args ...rt.PhpVal) &Class_Akismet_REST_API {
	mut obj := &Class_Akismet_REST_API{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_akismet(_args ...rt.PhpVal) &Class_Akismet {
	mut obj := &Class_Akismet{
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

fn create_wp_comment_query(_args ...rt.PhpVal) &Class_WP_Comment_Query {
	mut obj := &Class_WP_Comment_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_akismet(_args ...rt.PhpVal) &Class_akismet {
	mut obj := &Class_akismet{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Akismet_REST_API) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			return rt.new_bool(Class_Akismet_REST_API.init())
		}
		'get_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Akismet_REST_API.get_key(dispatch_arg_0)
		}
		'set_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Akismet_REST_API.set_key(dispatch_arg_0)
		}
		'delete_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Akismet_REST_API.delete_key(dispatch_arg_0)
		}
		'get_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Akismet_REST_API.get_settings(dispatch_arg_0)
		}
		'set_boolean_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Akismet_REST_API.set_boolean_settings(dispatch_arg_0)
		}
		'parse_boolean' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Akismet_REST_API.parse_boolean(dispatch_arg_0))
		}
		'get_stats' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Akismet_REST_API.get_stats(dispatch_arg_0)
		}
		'get_alert' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Akismet_REST_API.get_alert(dispatch_arg_0)
		}
		'set_alert' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Akismet_REST_API.set_alert(dispatch_arg_0)
		}
		'delete_alert' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Akismet_REST_API.delete_alert(dispatch_arg_0)
		}
		'key_is_valid' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Akismet_REST_API.key_is_valid(dispatch_arg_0))
		}
		'privileged_permission_callback' {
			return Class_Akismet_REST_API.privileged_permission_callback()
		}
		'remote_call_permission_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Akismet_REST_API.remote_call_permission_callback(dispatch_arg_0))
		}
		'sanitize_interval' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Akismet_REST_API.sanitize_interval(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'sanitize_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(Class_Akismet_REST_API.sanitize_key(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2))
		}
		'receive_webhook' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Akismet_REST_API.receive_webhook(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Akismet_REST_API) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet_REST_API) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Akismet) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Akismet) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_Comment_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Comment_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Comment_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_akismet) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_akismet) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_akismet) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
