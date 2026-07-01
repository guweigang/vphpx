import rt
import crypto.md5

struct Class_WP_Community_Events {
	rt.PhpObjectBase
pub mut:
		user_id rt.PhpVal = rt.new_int(0)
		user_location rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_WP_Community_Events) construct(var_user_id rt.PhpVal, user_location bool)  {
	this.user_id = rt.call_function('absint', [var_user_id.dup()])
	this.user_location = rt.new_bool(user_location).dup()
}

fn (mut this Class_WP_Community_Events) get_events(location_search string, timezone string) rt.PhpVal {
	mut var_wp_version := rt.new_null()
	mut var_cached_events := this.get_cached_events()
	if rt.is_true(rt.new_bool(!(var_location_search.len > 0 && var_location_search != '0') && rt.is_true(var_cached_events))) {
		return var_cached_events.dup()
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/version.php', '3')
	mut var_api_url := rt.new_string(rt.new_string('http://api.wordpress.org/events/1.0/'))
	mut var_request_args := this.get_request_args(location_search, timezone)
	var_request_args.array_set('user-agent', 'WordPress/' + (var_wp_version).str() + '; ' + (rt.call_function('home_url', [rt.new_string('/')])).str())
	if rt.is_true(rt.call_function('wp_http_supports', [rt.create_array([rt.ArrayItem{ key: none, val: 'ssl' }])])) {
		var_api_url = rt.call_function('set_url_scheme', [var_api_url.dup(), rt.new_string('https')])
	}
	mut var_response := rt.call_function('wp_remote_get', [var_api_url.dup(), var_request_args.dup()])
	mut var_response_code := rt.call_function('wp_remote_retrieve_response_code', [var_response.dup()])
	mut var_response_body := rt.call_function('json_decode', [rt.call_function('wp_remote_retrieve_body', [var_response.dup()]), rt.new_bool(true)])
	mut var_response_error := rt.new_null()
	if rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) {
		var_response_error = var_response.dup()
	} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_response_error = create_wp_error(rt.new_string('api-error'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Invalid API response code (%d).')]), var_response_code.dup()]))
	} else if !(var_response_body.array_isset(rt.new_string('location')) && var_response_body.array_isset(rt.new_string('events'))) {
		var_response_error = create_wp_error(rt.new_string('api-invalid-response'), if !(var_response_body.array_get('error')).is_null() { var_response_body.array_get('error') } else { rt.call_function('__', [rt.new_string('Unknown API error.')]) })
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_response_error.dup()])) {
		return var_response_error.dup()
	} else {
		mut var_expiration := rt.new_bool(rt.new_bool(false))
		if var_response_body.array_isset(rt.new_string('ttl')) {
			var_expiration = var_response_body.array_get('ttl')
			var_response_body.array_unset(rt.new_string('ttl'))
		}
		if !(!rt.is_true(var_response_body.array_get('location').array_get('ip'))) {
			var_response_body.array_get_mut('location').array_set('ip', var_request_args.array_get('body').array_get('ip'))
		}
		if this.coordinates_match(var_request_args.array_get('body'), var_response_body.array_get('location')) && !rt.is_true(var_response_body.array_get('location').array_get('description')) {
			var_response_body.array_get_mut('location').array_set('description', this.user_location.array_get('description'))
		}
		this.cache_events(var_response_body.dup(), (var_expiration).to_bool())
		var_response_body.array_set('events', this.trim_events(mut rt.cast_object_ptr[Class_array](var_response_body.array_get('events'))))
		return var_response_body.dup()
	}
	return rt.new_null()
}

fn (mut this Class_WP_Community_Events) get_request_args(search string, timezone string) rt.PhpVal {
	mut var_args := { 'number': rt.new_int(5), 'ip': Class_WP_Community_Events.get_unsafe_client_ip() }
	if search == '' && this.user_location.array_isset(rt.new_string('latitude')) && this.user_location.array_isset(rt.new_string('longitude')) {
		var_args['latitude'] = this.user_location.array_get('latitude')
		var_args['longitude'] = this.user_location.array_get('longitude')
	} else {
		var_args['locale'] = rt.call_function('get_user_locale', [this.user_id])
		if var_timezone.len > 0 && var_timezone != '0' {
			var_args['timezone'] = rt.new_string(timezone).dup()
		}
		if var_search.len > 0 && var_search != '0' {
			var_args['location'] = rt.new_string(search).dup()
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'body', val: var_args }])
}

fn Class_WP_Community_Events.get_unsafe_client_ip() bool {
	mut var_client_ip := rt.new_bool(rt.new_bool(false))
	mut var_address_headers := ['HTTP_CLIENT_IP', 'HTTP_X_FORWARDED_FOR', 'HTTP_X_FORWARDED', 'HTTP_X_CLUSTER_CLIENT_IP', 'HTTP_FORWARDED_FOR', 'HTTP_FORWARDED', 'REMOTE_ADDR']
	for var_header in var_address_headers {
		if rt.is_true(rt.new_bool(rt.get_superglobal('_SERVER').dup().array_isset(rt.new_string(header)))) {
			mut var_address_chain := rt.call_function('explode', [rt.new_string(','), rt.get_superglobal('_SERVER').array_get(header)])
			var_client_ip = rt.new_string(rt.new_string(var_address_chain.array_get(0).to_string().trim_space()))
			break
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_client_ip)))) {
		return false
	}
	mut var_anon_ip := rt.call_function('wp_privacy_anonymize_ip', [var_client_ip.dup(), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('0.0.0.0'), var_anon_ip)) || rt.is_true(rt.identical(rt.new_string('::'), var_anon_ip)))) {
		return false
	}
	return (var_anon_ip).to_bool()
}

fn (mut this Class_WP_Community_Events) coordinates_match(var_a rt.PhpVal, var_b rt.PhpVal) bool {
	if !(var_a.array_isset(rt.new_string('latitude')) && var_a.array_isset(rt.new_string('longitude')) && var_b.array_isset(rt.new_string('latitude')) && var_b.array_isset(rt.new_string('longitude'))) {
		return false
	}
	return rt.is_true(rt.identical(var_a.array_get('latitude'), var_b.array_get('latitude'))) && rt.is_true(rt.identical(var_a.array_get('longitude'), var_b.array_get('longitude')))
}

fn (mut this Class_WP_Community_Events) get_events_transient_key(var_location rt.PhpVal) rt.PhpVal {
	mut var_key := rt.new_bool(rt.new_bool(false))
	if var_location.array_isset(rt.new_string('ip')) {
		var_key = rt.new_string('community-events-' + md5.hexhash(var_location.array_get('ip').to_string()))
	} else if var_location.array_isset(rt.new_string('latitude')) && var_location.array_isset(rt.new_string('longitude')) {
		var_key = rt.new_string('community-events-' + md5.hexhash((var_location.array_get('latitude')).str() + (var_location.array_get('longitude')).str()))
	}
	return var_key.dup()
}

fn (mut this Class_WP_Community_Events) cache_events(var_events rt.PhpVal, expiration bool) rt.PhpVal {
	mut expiration_mutated := expiration
	mut var_set := rt.new_bool(rt.new_bool(false))
	mut var_transient_key := this.get_events_transient_key(var_events.array_get('location'))
	mut var_cache_expiration := if rt.is_true(rt.new_bool(expiration_mutated)) { rt.call_function('absint', [rt.new_bool(expiration_mutated).dup()]) } else { rt.mul(rt.get_constant('HOUR_IN_SECONDS'), rt.new_int(12)) }
	if rt.is_true(var_transient_key) {
		var_set = rt.call_function('set_site_transient', [var_transient_key.dup(), var_events.dup(), var_cache_expiration.dup()])
	}
	return var_set.dup()
}

fn (mut this Class_WP_Community_Events) get_cached_events() rt.PhpVal {
	mut var_transient_key := this.get_events_transient_key(this.user_location)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_transient_key)))) {
		return rt.new_bool(false)
	}
	mut var_cached_response := rt.call_function('get_site_transient', [var_transient_key.dup()])
	if var_cached_response.array_isset(rt.new_string('events')) {
		var_cached_response.array_set('events', this.trim_events(mut rt.cast_object_ptr[Class_array](var_cached_response.array_get('events'))))
	}
	return var_cached_response.dup()
}

fn (mut this Class_WP_Community_Events) format_event_data_time(var_response_body rt.PhpVal) rt.PhpVal {
	mut var_response_body_mutated := var_response_body
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('5.5.2')])
	if var_response_body_mutated.array_isset(rt.new_string('events')) {
		{
			mut iter_1 := var_response_body_mutated.array_get('events').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_event := item_1.val
				mut var_key := item_1.key
				mut var_timestamp := rt.call_function('strtotime', [var_event.array_get('date')])
				mut var_formatted_date := rt.call_function('date_i18n', [rt.call_function('__', [rt.new_string('l, M j, Y')]), var_timestamp.dup()])
				mut var_formatted_time := rt.call_function('date_i18n', [rt.call_function('get_option', [rt.new_string('time_format')]), var_timestamp.dup()])
				if var_event.array_isset(rt.new_string('end_date')) {
					mut var_end_timestamp := rt.call_function('strtotime', [var_event.array_get('end_date')])
					mut var_formatted_end_date := rt.call_function('date_i18n', [rt.call_function('__', [rt.new_string('l, M j, Y')]), var_end_timestamp.dup()])
					if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
						mut var_start_month := rt.call_function('date_i18n', [rt.call_function('_x', [rt.new_string('F'), rt.new_string('upcoming events month format')]), var_timestamp.dup()])
						mut var_end_month := rt.call_function('date_i18n', [rt.call_function('_x', [rt.new_string('F'), rt.new_string('upcoming events month format')]), var_end_timestamp.dup()])
						if rt.is_true(rt.identical(var_start_month, var_end_month)) {
							var_formatted_date = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s %2$d–%3$d, %4$d')]), var_start_month.dup(), rt.call_function('date_i18n', [rt.call_function('_x', [rt.new_string('j'), rt.new_string('upcoming events day format')]), var_timestamp.dup()]), rt.call_function('date_i18n', [rt.call_function('_x', [rt.new_string('j'), rt.new_string('upcoming events day format')]), var_end_timestamp.dup()]), rt.call_function('date_i18n', [rt.call_function('_x', [rt.new_string('Y'), rt.new_string('upcoming events year format')]), var_timestamp.dup()])])
						} else {
							var_formatted_date = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s %2$d – %3$s %4$d, %5$d')]), var_start_month.dup(), rt.call_function('date_i18n', [rt.call_function('_x', [rt.new_string('j'), rt.new_string('upcoming events day format')]), var_timestamp.dup()]), var_end_month.dup(), rt.call_function('date_i18n', [rt.call_function('_x', [rt.new_string('j'), rt.new_string('upcoming events day format')]), var_end_timestamp.dup()]), rt.call_function('date_i18n', [rt.call_function('_x', [rt.new_string('Y'), rt.new_string('upcoming events year format')]), var_timestamp.dup()])])
						}
						var_formatted_date = rt.call_function('wp_maybe_decline_date', [var_formatted_date.dup(), rt.new_string('F j, Y')])
					}
				}
				var_response_body_mutated.array_get_mut('events').array_get_mut(var_key).array_set('formatted_date', var_formatted_date.dup())
				var_response_body_mutated.array_get_mut('events').array_get_mut(var_key).array_set('formatted_time', var_formatted_time.dup())
			}
		}
	}
	return var_response_body_mutated.dup()
}

fn (mut this Class_WP_Community_Events) trim_events(mut var_events Class_array) rt.PhpVal {
	mut var_future_events := rt.new_array()
	{
		mut iter_1 := var_events.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_event := item_1.val
			mut var_end_time := // unsupported expression: Expr_Cast_Int
			if rt.is_true(rt.less(rt.call_function('time', []rt.PhpVal{}), var_end_time)) {
				var_event.array_set('title', rt.call_function('html_entity_decode', [var_event.array_get('title'), rt.get_constant('ENT_QUOTES'), rt.new_string('UTF-8')]))
				var_future_events.dup().array_push(var_event.dup())
			}
		}
	}
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_wordcamp := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.identical(rt.new_string('wordcamp'), var_wordcamp.array_get('type'))
	}
	mut var_future_wordcamps := rt.call_function('array_filter', [var_future_events.dup(), rt.new_closure(closure_1_fn)])
	var_future_wordcamps = rt.call_function('array_values', [var_future_wordcamps.dup()])
	mut var_trimmed_events := rt.call_function('array_slice', [var_future_events.dup(), rt.new_int(0), rt.new_int(3)])
	mut var_trimmed_event_types := rt.call_function('wp_list_pluck', [var_trimmed_events.dup(), rt.new_string('type')])
	if rt.is_true(rt.new_bool(rt.is_true(var_future_wordcamps) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('wordcamp'), var_trimmed_event_types.dup(), rt.new_bool(true)]))))))) {
		rt.call_function('array_pop', [var_trimmed_events.dup()])
		var_trimmed_events.dup().array_push(var_future_wordcamps.array_get(0))
	}
	return var_trimmed_events.dup()
}

fn (mut this Class_WP_Community_Events) maybe_log_events_response(var_message rt.PhpVal, var_details rt.PhpVal)  {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('4.9.0')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('WP_DEBUG_LOG'))))) {
		return rt.new_null()
	}
	rt.call_function('error_log', [rt.call_function('sprintf', [rt.new_string('%s: %s. Details: %s'), rt.new_string(@METHOD), rt.new_string(var_message.dup().to_string().trim_space()), rt.call_function('wp_json_encode', [var_details.dup()])])])
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_community_events(user_location bool, arg_1 rt.PhpVal) &Class_WP_Community_Events {
	mut obj := &Class_WP_Community_Events{
		PhpObjectBase: rt.PhpObjectBase{}
		user_id: rt.new_int(0)
		user_location: rt.new_bool(false)
	}
	obj.construct(user_location, arg_1)
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Community_Events) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_events' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_events(dispatch_arg_0, dispatch_arg_1)
		}
		'get_request_args' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_request_args(dispatch_arg_0, dispatch_arg_1)
		}
		'get_unsafe_client_ip' {
			return rt.new_bool(Class_WP_Community_Events.get_unsafe_client_ip())
		}
		'coordinates_match' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.coordinates_match(dispatch_arg_0, dispatch_arg_1))
		}
		'get_events_transient_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_events_transient_key(dispatch_arg_0)
		}
		'cache_events' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.cache_events(dispatch_arg_0, dispatch_arg_1)
		}
		'get_cached_events' {
			return this.get_cached_events()
		}
		'format_event_data_time' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.format_event_data_time(dispatch_arg_0)
		}
		'trim_events' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.trim_events(mut dispatch_arg_0)
		}
		'maybe_log_events_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.maybe_log_events_response(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP_Community_Events) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'user_id' { return this.user_id }
		'user_location' { return this.user_location }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Community_Events) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'user_id' { this.user_id = val; return true }
		'user_location' { this.user_location = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_admin_includes_class_wp_community_events_php() {
}
