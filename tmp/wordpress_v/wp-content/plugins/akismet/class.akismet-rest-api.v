import rt

struct Class_Akismet_REST_API {
	rt.PhpObjectBase
}

fn Class_Akismet_REST_API.init() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('register_rest_route')]))))) {
		return false
	}
	rt.call_function('register_rest_route', [rt.new_string('akismet/v1'), rt.new_string('/key'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_REST_API' }, rt.ArrayItem{ key: none, val: 'privileged_permission_callback' }]) }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_REST_API' }, rt.ArrayItem{ key: none, val: 'get_key' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_REST_API' }, rt.ArrayItem{ key: none, val: 'privileged_permission_callback' }]) }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_REST_API' }, rt.ArrayItem{ key: none, val: 'set_key' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'key', val: rt.create_array([rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_REST_API' }, rt.ArrayItem{ key: none, val: 'sanitize_key' }]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('A 12-character Akismet API key. Available at akismet.com/account'), rt.new_string('akismet')]) }]) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_REST_API' }, rt.ArrayItem{ key: none, val: 'privileged_permission_callback' }]) }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_REST_API' }, rt.ArrayItem{ key: none, val: 'delete_key' }]) }]) }])])
	rt.call_function('register_rest_route', [rt.new_string('akismet/v1'), rt.new_string('/settings/'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_REST_API' }, rt.ArrayItem{ key: none, val: 'privileged_permission_callback' }]) }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_REST_API' }, rt.ArrayItem{ key: none, val: 'get_settings' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_REST_API' }, rt.ArrayItem{ key: none, val: 'privileged_permission_callback' }]) }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_REST_API' }, rt.ArrayItem{ key: none, val: 'set_boolean_settings' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'akismet_strictness', val: rt.create_array([rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('If true, Akismet will automatically discard the worst spam automatically rather than putting it in the spam folder.'), rt.new_string('akismet')]) }]) }, rt.ArrayItem{ key: 'akismet_show_user_comments_approved', val: rt.create_array([rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('If true, show the number of approved comments beside each comment author in the comments list page.'), rt.new_string('akismet')]) }]) }, rt.ArrayItem{ key: 'akismet_enable_mcp_access', val: rt.create_array([rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('If true, allow MCP clients to access Akismet data and functionality.'), rt.new_string('akismet')]) }]) }]) }]) }])])
	rt.call_function('register_rest_route', [rt.new_string('akismet/v1'), rt.new_string('/stats'), rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_REST_API' }, rt.ArrayItem{ key: none, val: 'privileged_permission_callback' }]) }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_REST_API' }, rt.ArrayItem{ key: none, val: 'get_stats' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'interval', val: rt.create_array([rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_REST_API' }, rt.ArrayItem{ key: none, val: 'sanitize_interval' }]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The time period for which to retrieve stats. Options: 60-days, 6-months, all'), rt.new_string('akismet')]) }, rt.ArrayItem{ key: 'default', val: 'all' }]) }]) }])])
	rt.call_function('register_rest_route', [rt.new_string('akismet/v1'), rt.new_string('/stats/(?P<interval>[\\w+])'), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'interval', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The time period for which to retrieve stats. Options: 60-days, 6-months, all'), rt.new_string('akismet')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_REST_API' }, rt.ArrayItem{ key: none, val: 'privileged_permission_callback' }]) }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_REST_API' }, rt.ArrayItem{ key: none, val: 'get_stats' }]) }]) }])])
	rt.call_function('register_rest_route', [rt.new_string('akismet/v1'), rt.new_string('/alert'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_REST_API' }, rt.ArrayItem{ key: none, val: 'remote_call_permission_callback' }]) }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_REST_API' }, rt.ArrayItem{ key: none, val: 'get_alert' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'key', val: rt.create_array([rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_REST_API' }, rt.ArrayItem{ key: none, val: 'sanitize_key' }]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('A 12-character Akismet API key. Available at akismet.com/account'), rt.new_string('akismet')]) }]) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_REST_API' }, rt.ArrayItem{ key: none, val: 'remote_call_permission_callback' }]) }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_REST_API' }, rt.ArrayItem{ key: none, val: 'set_alert' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'key', val: rt.create_array([rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_REST_API' }, rt.ArrayItem{ key: none, val: 'sanitize_key' }]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('A 12-character Akismet API key. Available at akismet.com/account'), rt.new_string('akismet')]) }]) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_REST_API' }, rt.ArrayItem{ key: none, val: 'remote_call_permission_callback' }]) }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_REST_API' }, rt.ArrayItem{ key: none, val: 'delete_alert' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'key', val: rt.create_array([rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_REST_API' }, rt.ArrayItem{ key: none, val: 'sanitize_key' }]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('A 12-character Akismet API key. Available at akismet.com/account'), rt.new_string('akismet')]) }]) }]) }]) }])])
	rt.call_function('register_rest_route', [rt.new_string('akismet/v1'), rt.new_string('/webhook'), rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_REST_API' }, rt.ArrayItem{ key: none, val: 'receive_webhook' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_REST_API' }, rt.ArrayItem{ key: none, val: 'remote_call_permission_callback' }]) }])])
	return false
}

fn Class_Akismet_REST_API.get_key(var_request rt.PhpVal) rt.PhpVal {
	return rt.call_function('rest_ensure_response', [fn () rt.PhpVal { mut temp := Class_Akismet{}; return temp.get_api_key() }()])
}

fn Class_Akismet_REST_API.set_key(var_request rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('defined', [rt.new_string('WPCOM_API_KEY')])) {
		return rt.call_function('rest_ensure_response', [create_wp_error(rt.new_string('hardcoded_key'), rt.call_function('__', [rt.new_string('This site\'s API key is hardcoded and cannot be changed via the API.'), rt.new_string('akismet')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 409 }]))])
	}
	mut var_new_api_key := rt.call_method(var_request, 'get_param', [rt.new_string('key')])
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Akismet_REST_API.key_is_valid(var_new_api_key.dup()))))) {
		return rt.call_function('rest_ensure_response', [create_wp_error(rt.new_string('invalid_key'), rt.call_function('__', [rt.new_string('The value provided is not a valid and registered API key.'), rt.new_string('akismet')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))])
	}
	rt.call_function('update_option', [rt.new_string('wordpress_api_key'), var_new_api_key.dup()])
	return Class_Akismet_REST_API.get_key()
}

fn Class_Akismet_REST_API.delete_key(var_request rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('defined', [rt.new_string('WPCOM_API_KEY')])) {
		return rt.call_function('rest_ensure_response', [create_wp_error(rt.new_string('hardcoded_key'), rt.call_function('__', [rt.new_string('This site\'s API key is hardcoded and cannot be deleted.'), rt.new_string('akismet')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 409 }]))])
	}
	rt.call_function('delete_option', [rt.new_string('wordpress_api_key')])
	return rt.call_function('rest_ensure_response', [rt.new_bool(true)])
}

fn Class_Akismet_REST_API.get_settings(var_request rt.PhpVal) rt.PhpVal {
	return rt.call_function('rest_ensure_response', [rt.create_array([rt.ArrayItem{ key: 'akismet_strictness', val: rt.identical(rt.call_function('get_option', [rt.new_string('akismet_strictness'), rt.new_string('1')]), rt.new_string('1')) }, rt.ArrayItem{ key: 'akismet_show_user_comments_approved', val: rt.identical(rt.call_function('get_option', [rt.new_string('akismet_show_user_comments_approved'), rt.new_string('1')]), rt.new_string('1')) }, rt.ArrayItem{ key: 'akismet_enable_mcp_access', val: rt.identical(rt.call_function('get_option', [rt.new_string('akismet_enable_mcp_access'), rt.new_string('0')]), rt.new_string('1')) }])])
}

fn Class_Akismet_REST_API.set_boolean_settings(var_request rt.PhpVal) rt.PhpVal {
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'akismet_strictness' }, rt.ArrayItem{ key: none, val: 'akismet_show_user_comments_approved' }, rt.ArrayItem{ key: none, val: 'akismet_enable_mcp_access' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_setting_key := item_1.val
			mut var_setting_value := rt.call_method(var_request, 'get_param', [var_setting_key.dup()])
			if rt.is_true(rt.new_bool(var_setting_value.dup().is_null())) {
				continue
			}
			var_setting_value = Class_Akismet_REST_API.parse_boolean(var_setting_value.dup())
			rt.call_function('update_option', [var_setting_key.dup(), if rt.is_true(var_setting_value) { rt.new_string('1') } else { rt.new_string('0') }])
		}
	}
	return Class_Akismet_REST_API.get_settings()
}

fn Class_Akismet_REST_API.parse_boolean(var_value rt.PhpVal)  {
	mut switch_val_1 := var_value
	if rt.is_true(rt.equal(switch_val_1, rt.new_bool(true))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('true'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('1'))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(1))) {
		return rt.new_bool(true)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(false))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('false'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('0'))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(0))) {
		return rt.new_bool(false)
	} else {
		return // unsupported expression: Expr_Cast_Bool
	}
}

fn Class_Akismet_REST_API.get_stats(var_request rt.PhpVal) rt.PhpVal {
	mut var_api_key := fn () rt.PhpVal { mut temp := Class_Akismet{}; return temp.get_api_key() }()
	mut var_interval := rt.call_method(var_request, 'get_param', [rt.new_string('interval')])
	mut var_stat_totals := rt.new_array()
	mut var_request_args := rt.create_array([rt.ArrayItem{ key: 'blog', val: rt.call_function('get_option', [rt.new_string('home')]) }, rt.ArrayItem{ key: 'key', val: var_api_key }, rt.ArrayItem{ key: 'from', val: var_interval }])
	var_request_args = rt.call_function('apply_filters', [rt.new_string('akismet_request_args'), var_request_args.dup(), rt.new_string('get-stats')])
	mut var_response := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Akismet{}; return temp.http_post(arg_0, arg_1) }(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Akismet{}; return temp.build_query(arg_0) }(var_request_args.dup()), rt.new_string('get-stats'))
	if !(!rt.is_true(var_response.array_get(1))) {
		var_stat_totals.array_set(var_interval, rt.call_function('json_decode', [var_response.array_get(1)]))
	}
	return rt.call_function('rest_ensure_response', [var_stat_totals.dup()])
}

fn Class_Akismet_REST_API.get_alert(var_request rt.PhpVal) rt.PhpVal {
	return rt.call_function('rest_ensure_response', [rt.create_array([rt.ArrayItem{ key: 'code', val: rt.call_function('get_option', [rt.new_string('akismet_alert_code')]) }, rt.ArrayItem{ key: 'message', val: rt.call_function('get_option', [rt.new_string('akismet_alert_msg')]) }])])
}

fn Class_Akismet_REST_API.set_alert(var_request rt.PhpVal) rt.PhpVal {
	rt.call_function('delete_option', [rt.new_string('akismet_alert_code')])
	rt.call_function('delete_option', [rt.new_string('akismet_alert_msg')])
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Akismet{}; return temp.verify_key(arg_0) }(fn () rt.PhpVal { mut temp := Class_Akismet{}; return temp.get_api_key() }())
	return Class_Akismet_REST_API.get_alert(var_request.dup())
}

fn Class_Akismet_REST_API.delete_alert(var_request rt.PhpVal) rt.PhpVal {
	rt.call_function('delete_option', [rt.new_string('akismet_alert_code')])
	rt.call_function('delete_option', [rt.new_string('akismet_alert_msg')])
	return Class_Akismet_REST_API.get_alert(var_request.dup())
}

fn Class_Akismet_REST_API.key_is_valid(var_key rt.PhpVal) bool {
	mut var_request_args := rt.create_array([rt.ArrayItem{ key: 'key', val: var_key }, rt.ArrayItem{ key: 'blog', val: rt.call_function('get_option', [rt.new_string('home')]) }])
	var_request_args = rt.call_function('apply_filters', [rt.new_string('akismet_request_args'), var_request_args.dup(), rt.new_string('verify-key')])
	mut var_response := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Akismet{}; return temp.http_post(arg_0, arg_1) }(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Akismet{}; return temp.build_query(arg_0) }(var_request_args.dup()), rt.new_string('verify-key'))
	if rt.is_true(rt.equal(var_response.array_get(1), rt.new_string('valid'))) {
		return true
	}
	return false
}

fn Class_Akismet_REST_API.privileged_permission_callback() rt.PhpVal {
	return rt.call_function('current_user_can', [rt.new_string('manage_options')])
}

fn Class_Akismet_REST_API.remote_call_permission_callback(var_request rt.PhpVal) bool {
	mut var_local_key := fn () rt.PhpVal { mut temp := Class_Akismet{}; return temp.get_api_key() }()
	return rt.is_true(var_local_key) && rt.is_true(rt.identical(rt.new_string(if !(rt.call_method(var_request, 'get_param', [rt.new_string('key')])).is_null() { rt.call_method(var_request, 'get_param', [rt.new_string('key')]) } else { rt.new_string('') }.to_string().to_lower()), rt.new_string(var_local_key.dup().to_string().to_lower())))
}

fn Class_Akismet_REST_API.sanitize_interval(var_interval rt.PhpVal, var_request rt.PhpVal, var_param rt.PhpVal) rt.PhpVal {
	mut var_interval_mutated := var_interval
	var_interval_mutated = rt.new_string(rt.new_string(var_interval_mutated.dup().to_string().trim_space()))
	mut var_valid_intervals := ['60-days', '6-months', 'all']
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_interval_mutated.dup(), var_valid_intervals.dup()]))))) {
		var_interval_mutated = rt.new_string(rt.new_string('all'))
	}
	return var_interval_mutated.dup()
}

fn Class_Akismet_REST_API.sanitize_key(var_key rt.PhpVal, var_request rt.PhpVal, var_param rt.PhpVal) string {
	return var_key.dup().to_string().trim_space()
}

fn Class_Akismet_REST_API.receive_webhook(var_request rt.PhpVal) rt.PhpVal {
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Akismet{}; return temp.log(arg_0) }(rt.create_array([rt.ArrayItem{ key: none, val: 'Webhook request received' }, rt.ArrayItem{ key: none, val: rt.call_method(var_request, 'get_body', []rt.PhpVal{}) }]))
	mut var_response := rt.create_array([rt.ArrayItem{ key: 'comments', val: rt.new_array() }])
	mut var_endpoint := rt.call_method(var_request, 'get_param', [rt.new_string('endpoint')])
	mut switch_val_2 := var_endpoint
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('comment-check'))) {
		mut var_webhook_comments := rt.call_method(var_request, 'get_param', [rt.new_string('comments')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_webhook_comments.dup().is_array()))))) {
			return rt.call_function('rest_ensure_response', [create_wp_error(rt.new_string('malformed_request'), rt.call_function('__', [rt.new_string('The \'comments\' parameter must be an array.'), rt.new_string('akismet')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))])
		}
		{
			mut iter_1 := var_webhook_comments.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_webhook_comment := item_1.val
				mut var_guid := var_webhook_comment.array_get('guid')
				if rt.is_true(rt.new_bool(!(rt.is_true(var_guid)))) {
					continue
				}
				mut var_queryable_fields := rt.create_array([rt.ArrayItem{ key: 'comment_post_ID', val: 'post_id' }, rt.ArrayItem{ key: 'comment_parent', val: 'parent' }, rt.ArrayItem{ key: 'comment_author_email', val: 'author_email' }])
				mut var_query_args := rt.new_array()
				var_query_args.array_set('status', 'any')
				var_query_args.array_set('meta_key', 'akismet_guid')
				var_query_args.array_set('meta_value', var_guid.dup())
				{
					mut iter_2 := var_queryable_fields.iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_wp_comment_query_field := item_2.val
						mut var_queryable_field := item_2.key
						if var_webhook_comment.array_isset(var_queryable_field) {
							var_query_args.array_set(var_wp_comment_query_field, var_webhook_comment.array_get(var_queryable_field))
						}
					}
				}
				mut var_comments_query := create_wp_comment_query(var_query_args.dup())
				mut var_comments := rt.get_property(var_comments_query, 'comments')
				if rt.is_true(rt.new_bool(!(rt.is_true(var_comments)))) {
					fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Akismet{}; return temp.log(arg_0) }(rt.new_string('Webhook failed: no matching comment found.'))
					var_response.array_get_mut('comments').array_set(var_guid, rt.create_array([rt.ArrayItem{ key: 'status', val: 'error' }, rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('Could not find matching comment.'), rt.new_string('akismet')]) }]))
					continue
				}
				if var_comments.dup().array_count() > 1 {
					fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Akismet{}; return temp.log(arg_0, arg_1) }(rt.new_string('Webhook failed: multiple matching comments found.'), var_comments.dup())
					var_response.array_get_mut('comments').array_set(var_guid, rt.create_array([rt.ArrayItem{ key: 'status', val: 'error' }, rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('Multiple comments matched request.'), rt.new_string('akismet')]) }]))
					continue
				} else {
					fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Akismet{}; return temp.log(arg_0, arg_1) }(rt.new_string('Found matching comment.'), var_comments.dup())
					mut var_comment := var_comments.array_get(0)
					mut var_current_status := rt.call_function('wp_get_comment_status', [var_comment.dup()])
					mut var_result := var_webhook_comment.array_get('result')
					if rt.is_true(rt.equal(rt.new_string('true'), var_result)) {
						fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Akismet{}; return temp.log(arg_0) }(rt.new_string('Comment should be spam'))
						if rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
							if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Akismet{}; return temp.last_comment_status_change_came_from_akismet(arg_0) }(rt.get_property(var_comment, 'comment_ID'))) {
								fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Akismet{}; return temp.log(arg_0) }(rt.new_string('Comment is not spam; marking as spam.'))
								rt.call_function('wp_spam_comment', [var_comment.dup()])
								fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Akismet{}; return temp.update_comment_history(arg_0, arg_1, arg_2) }(rt.get_property(var_comment, 'comment_ID'), rt.new_string(''), rt.new_string('webhook-spam'))
							} else {
								fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Akismet{}; return temp.log(arg_0) }(rt.new_string('Comment is not spam, but it has already been manually handled by some other process.'))
								fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Akismet{}; return temp.update_comment_history(arg_0, arg_1, arg_2) }(rt.get_property(var_comment, 'comment_ID'), rt.new_string(''), rt.new_string('webhook-spam-noaction'))
							}
						}
					} else if rt.is_true(rt.equal(rt.new_string('false'), var_result)) {
						fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Akismet{}; return temp.log(arg_0) }(rt.new_string('Comment should be ham'))
						if rt.is_true(rt.equal(rt.new_string('spam'), var_current_status)) {
							fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Akismet{}; return temp.log(arg_0) }(rt.new_string('Comment is spam.'))
							if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Akismet{}; return temp.last_comment_status_change_came_from_akismet(arg_0) }(rt.get_property(var_comment, 'comment_ID'))) {
								fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Akismet{}; return temp.log(arg_0) }(rt.new_string('Akismet marked it as spam; unspamming.'))
								rt.call_function('wp_unspam_comment', [.dup()])
								
							} else {
							}
						} else {
							if rt.is_true() {
							}
						}
						mut var_moderation_email_was_delayed := 
						if rt.is_true() {
						}
						
					}
					
				}
			}
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('submit-ham'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('submit-spam'))) {
	} else {
	}
	
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

fn create_akismet_rest_api() &Class_Akismet_REST_API {
	mut obj := &Class_Akismet_REST_API{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_akismet() &Class_Akismet {
	mut obj := &Class_Akismet{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_comment_query() &Class_WP_Comment_Query {
	mut obj := &Class_WP_Comment_Query{
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
			Class_Akismet_REST_API.parse_boolean(dispatch_arg_0)
			return rt.new_null()
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
			return Class_Akismet_REST_API.sanitize_interval(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'sanitize_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(Class_Akismet_REST_API.sanitize_key(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'receive_webhook' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Akismet_REST_API.receive_webhook(dispatch_arg_0)
		}
		else { return none }
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




pub fn init_wp_content_plugins_akismet_class_akismet_rest_api_php() {
}
