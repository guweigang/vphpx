import rt
import crypto.md5

struct Class_WP_Community_Events {
	rt.PhpObjectBase
pub mut:
	user_id       rt.PhpVal = rt.new_int(0)
	user_location rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_WP_Community_Events) construct(var_user_id rt.PhpVal, user_location bool) {
	this.user_id = rt.call_function('absint', [var_user_id.clone()])
	this.user_location = rt.new_bool(user_location)
}

fn (mut this Class_WP_Community_Events) get_events(location_search string, timezone string) rt.PhpVal {
	mut var_wp_version := rt.new_null()
	mut var_cached_events := this.get_cached_events()
	if !(var_location_search.len > 0 && var_location_search != '0') && rt.is_true(var_cached_events) {
		return var_cached_events.clone()
	}
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/version.php', '3')
	mut var_api_url := rt.new_string('http://api.wordpress.org/events/1.0/')
	mut var_request_args := this.get_request_args(location_search, timezone)
	var_request_args.array_set('user-agent', 'WordPress/' + var_wp_version.str() + '; ' +
		(rt.call_function('home_url', [rt.new_string('/')])).str())
	if rt.is_true(rt.call_function('wp_http_supports', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'ssl' }]),
	]))
	{
		var_api_url = rt.call_function('set_url_scheme', [var_api_url.clone(),
			rt.new_string('https')])
	}
	mut var_response := rt.call_function('wp_remote_get', [var_api_url.clone(),
		var_request_args.clone()])
	mut var_response_code := rt.call_function('wp_remote_retrieve_response_code', [
		var_response.clone(),
	])
	mut var_response_body := rt.call_function('json_decode', [
		rt.call_function('wp_remote_retrieve_body', [var_response.clone()]),
		rt.new_bool(true),
	])
	mut var_response_error := rt.new_null()
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		var_response_error = var_response.clone()
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), var_response_code)))) {
		var_response_error = create_wp_error(rt.new_string('api-error'), rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Invalid API response code (%d).')]),
			var_response_code.clone(),
		]))
	} else if !(var_response_body.array_isset(rt.new_string('location'))
		&& var_response_body.array_isset(rt.new_string('events'))) {
		var_response_error = create_wp_error(rt.new_string('api-invalid-response'), if !(var_response_body.array_get(rt.new_string('error'))).is_null() { var_response_body.array_get(rt.new_string('error')) } else { rt.call_function('__', [
				rt.new_string('Unknown API error.'),
			]) })
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_response_error.clone()])) {
		return var_response_error.clone()
	} else {
		mut var_expiration := rt.new_bool(false)
		if var_response_body.array_isset(rt.new_string('ttl')) {
			var_expiration = var_response_body.array_get(rt.new_string('ttl'))
			var_response_body.array_unset(rt.new_string('ttl'))
		}
		if !(!rt.is_true(var_response_body.array_get(rt.new_string('location')).array_get(rt.new_string('ip')))) {
			var_response_body.array_get_mut('location').array_set('ip',
				var_request_args.array_get(rt.new_string('body')).array_get(rt.new_string('ip')))
		}
		if this.coordinates_match(var_request_args.array_get(rt.new_string('body')), var_response_body.array_get(rt.new_string('location')))
			&& !rt.is_true(var_response_body.array_get(rt.new_string('location')).array_get(rt.new_string('description'))) {
			var_response_body.array_get_mut('location').array_set('description',
				this.user_location.array_get(rt.new_string('description')))
		}
		this.cache_events(var_response_body.clone(), var_expiration.to_bool())
		var_response_body.array_set('events',
			this.trim_events(mut rt.cast_object_ptr[Class_array](var_response_body.array_get(rt.new_string('events')))))
		return var_response_body.clone()
	}
	return rt.new_null()
}

fn (mut this Class_WP_Community_Events) get_request_args(search string, timezone string) rt.PhpVal {
	mut var_args := {
		'number': rt.new_int(5)
		'ip':     Class_WP_Community_Events.get_unsafe_client_ip()
	}
	if search == '' && this.user_location.array_isset(rt.new_string('latitude'))
		&& this.user_location.array_isset(rt.new_string('longitude')) {
		var_args['latitude'] = this.user_location.array_get(rt.new_string('latitude'))
		var_args['longitude'] = this.user_location.array_get(rt.new_string('longitude'))
	} else {
		var_args['locale'] = rt.call_function('get_user_locale', [this.user_id])
		if var_timezone.len > 0 && var_timezone != '0' {
			var_args['timezone'] = rt.new_string(timezone)
		}
		if var_search.len > 0 && var_search != '0' {
			var_args['location'] = rt.new_string(search)
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'body', val: var_args }])
}

fn Class_WP_Community_Events.get_unsafe_client_ip() bool {
	mut var_client_ip := rt.new_bool(false)
	mut var_address_headers := ['HTTP_CLIENT_IP', 'HTTP_X_FORWARDED_FOR', 'HTTP_X_FORWARDED',
		'HTTP_X_CLUSTER_CLIENT_IP', 'HTTP_FORWARDED_FOR', 'HTTP_FORWARDED', 'REMOTE_ADDR']
	for var_header in var_address_headers {
		if rt.is_true(rt.new_bool(rt.get_superglobal('_SERVER').clone().array_isset(rt.new_string(header)))) {
			mut var_address_chain := rt.call_function('explode', [
				rt.new_string(','), rt.get_superglobal('_SERVER').array_get(rt.new_string(header))])
			var_client_ip =
				rt.new_string(var_address_chain.array_get(rt.new_int(0)).to_string().trim_space())
			break
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_client_ip)))) {
		return false
	}
	mut var_anon_ip := rt.call_function('wp_privacy_anonymize_ip', [
		var_client_ip.clone(), rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_string('0.0.0.0'), var_anon_ip))
		|| rt.is_true(rt.identical(rt.new_string('::'), var_anon_ip)) {
		return false
	}
	return var_anon_ip.to_bool()
}

fn (mut this Class_WP_Community_Events) coordinates_match(var_a rt.PhpVal, var_b rt.PhpVal) bool {
	if !(var_a.array_isset(rt.new_string('latitude'))
		&& var_a.array_isset(rt.new_string('longitude'))
		&& var_b.array_isset(rt.new_string('latitude'))
		&& var_b.array_isset(rt.new_string('longitude'))) {
		return false
	}
	return
		rt.is_true(rt.identical(var_a.array_get(rt.new_string('latitude')), var_b.array_get(rt.new_string('latitude'))))
		&& rt.is_true(rt.identical(var_a.array_get(rt.new_string('longitude')), var_b.array_get(rt.new_string('longitude'))))
}

fn (mut this Class_WP_Community_Events) get_events_transient_key(var_location rt.PhpVal) rt.PhpVal {
	mut var_key := rt.new_bool(false)
	if var_location.array_isset(rt.new_string('ip')) {
		var_key = rt.new_string('community-events-' +
			md5.hexhash(var_location.array_get(rt.new_string('ip')).to_string()))
	} else if var_location.array_isset(rt.new_string('latitude'))
		&& var_location.array_isset(rt.new_string('longitude')) {
		var_key = rt.new_string('community-events-' +
			md5.hexhash((var_location.array_get(rt.new_string('latitude'))).str() +
			(var_location.array_get(rt.new_string('longitude'))).str()))
	}
	return var_key.clone()
}

fn (mut this Class_WP_Community_Events) cache_events(var_events rt.PhpVal, expiration bool) rt.PhpVal {
	mut expiration_mutated := expiration
	mut var_set := rt.new_bool(false)
	mut var_transient_key :=
		this.get_events_transient_key(var_events.array_get(rt.new_string('location')))
	mut var_cache_expiration := if rt.is_true(rt.new_bool(expiration_mutated)) { rt.call_function('absint', [
			rt.new_bool(expiration_mutated).clone(),
		]) } else { rt.mul(rt.get_constant('HOUR_IN_SECONDS'), rt.new_int(12)) }
	if rt.is_true(var_transient_key) {
		var_set = rt.call_function('set_site_transient', [var_transient_key.clone(),
			var_events.clone(), var_cache_expiration.clone()])
	}
	return var_set.clone()
}

fn (mut this Class_WP_Community_Events) get_cached_events() rt.PhpVal {
	mut var_transient_key := this.get_events_transient_key(this.user_location)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_transient_key)))) {
		return rt.new_bool(false)
	}
	mut var_cached_response := rt.call_function('get_site_transient', [
		var_transient_key.clone()])
	if var_cached_response.array_isset(rt.new_string('events')) {
		var_cached_response.array_set('events',
			this.trim_events(mut rt.cast_object_ptr[Class_array](var_cached_response.array_get(rt.new_string('events')))))
	}
	return var_cached_response.clone()
}

fn (mut this Class_WP_Community_Events) format_event_data_time(var_response_body rt.PhpVal) rt.PhpVal {
	mut var_response_body_mutated := var_response_body
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('5.5.2')])
	if var_response_body_mutated.array_isset(rt.new_string('events')) {
		mut iter_1 := var_response_body_mutated.array_get(rt.new_string('events')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_event := item_1.val
			mut var_key := item_1.key
			mut var_timestamp := rt.call_function('strtotime', [
				var_event.array_get(rt.new_string('date')),
			])
			mut var_formatted_date := rt.call_function('date_i18n', [
				rt.call_function('__', [rt.new_string('l, M j, Y')]),
				var_timestamp.clone(),
			])
			mut var_formatted_time := rt.call_function('date_i18n', [
				rt.call_function('get_option', [rt.new_string('time_format')]),
				var_timestamp.clone(),
			])
			if var_event.array_isset(rt.new_string('end_date')) {
				mut var_end_timestamp := rt.call_function('strtotime', [
					var_event.array_get(rt.new_string('end_date')),
				])
				mut var_formatted_end_date := rt.call_function('date_i18n', [
					rt.call_function('__', [rt.new_string('l, M j, Y')]),
					var_end_timestamp.clone(),
				])
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('meetup'), var_event.array_get(rt.new_string('type'))))))
					&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_formatted_end_date, var_formatted_date)))) {
					mut var_start_month := rt.call_function('date_i18n', [
						rt.call_function('_x', [rt.new_string('F'),
							rt.new_string('upcoming events month format')]),
						var_timestamp.clone(),
					])
					mut var_end_month := rt.call_function('date_i18n', [
						rt.call_function('_x', [rt.new_string('F'),
							rt.new_string('upcoming events month format')]),
						var_end_timestamp.clone(),
					])
					if rt.is_true(rt.identical(var_start_month, var_end_month)) {
						var_formatted_date = rt.call_function('sprintf', [
							rt.call_function('__', [
								rt.new_string('%1$s %2$d–%3$d, %4$d'),
							]),
							var_start_month.clone(),
							rt.call_function('date_i18n', [
								rt.call_function('_x', [rt.new_string('j'),
									rt.new_string('upcoming events day format')]),
								var_timestamp.clone(),
							]),
							rt.call_function('date_i18n', [
								rt.call_function('_x', [rt.new_string('j'),
									rt.new_string('upcoming events day format')]),
								var_end_timestamp.clone(),
							]),
							rt.call_function('date_i18n', [
								rt.call_function('_x', [rt.new_string('Y'),
									rt.new_string('upcoming events year format')]),
								var_timestamp.clone(),
							]),
						])
					} else {
						var_formatted_date = rt.call_function('sprintf', [
							rt.call_function('__', [
								rt.new_string('%1$s %2$d – %3$s %4$d, %5$d'),
							]),
							var_start_month.clone(),
							rt.call_function('date_i18n', [
								rt.call_function('_x', [rt.new_string('j'),
									rt.new_string('upcoming events day format')]),
								var_timestamp.clone(),
							]),
							var_end_month.clone(),
							rt.call_function('date_i18n', [
								rt.call_function('_x', [rt.new_string('j'),
									rt.new_string('upcoming events day format')]),
								var_end_timestamp.clone(),
							]),
							rt.call_function('date_i18n', [
								rt.call_function('_x', [rt.new_string('Y'),
									rt.new_string('upcoming events year format')]),
								var_timestamp.clone(),
							]),
						])
					}
					var_formatted_date = rt.call_function('wp_maybe_decline_date', [
						var_formatted_date.clone(),
						rt.new_string('F j, Y'),
					])
				}
			}
			var_response_body_mutated.array_get_mut('events').array_get_mut(var_key).array_set('formatted_date',
				var_formatted_date.clone())
			var_response_body_mutated.array_get_mut('events').array_get_mut(var_key).array_set('formatted_time',
				var_formatted_time.clone())
		}
	}
	return var_response_body_mutated.clone()
}

fn (mut this Class_WP_Community_Events) trim_events(mut var_events Class_array) rt.PhpVal {
	mut var_future_events := rt.new_array()
	mut iter_2 := var_events.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_event := item_2.val
		mut var_end_time :=
			rt.new_int((var_event.array_get(rt.new_string('end_unix_timestamp'))).to_i64())
		if rt.is_true(rt.less(rt.call_function('time', []rt.PhpVal{}), var_end_time)) {
			var_event.array_set('title', rt.call_function('html_entity_decode', [
				var_event.array_get(rt.new_string('title')),
				rt.get_constant('ENT_QUOTES'),
				rt.new_string('UTF-8'),
			]))
			var_future_events.clone().array_push(var_event.clone())
		}
	}
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_wordcamp := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(rt.new_string('wordcamp'),
			var_wordcamp.array_get(rt.new_string('type')))
	}
	mut var_future_wordcamps := rt.call_function('array_filter', [
		var_future_events.clone(), rt.new_closure(closure_1_fn)])
	var_future_wordcamps = rt.call_function('array_values', [
		var_future_wordcamps.clone()])
	mut var_trimmed_events := rt.call_function('array_slice', [
		var_future_events.clone(), rt.new_int(0), rt.new_int(3)])
	mut var_trimmed_event_types := rt.call_function('wp_list_pluck', [
		var_trimmed_events.clone(), rt.new_string('type')])
	if rt.is_true(var_future_wordcamps)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('wordcamp'), var_trimmed_event_types.clone(), rt.new_bool(true)]))))) {
		rt.call_function('array_pop', [var_trimmed_events.clone()])
		var_trimmed_events.clone().array_push(var_future_wordcamps.array_get(rt.new_int(0)))
	}
	return var_trimmed_events.clone()
}

fn (mut this Class_WP_Community_Events) maybe_log_events_response(var_message rt.PhpVal, var_details rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('4.9.0')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('WP_DEBUG_LOG'))))) {
		return
	}
	rt.call_function('error_log', [
		rt.call_function('sprintf', [rt.new_string('%s: %s. Details: %s'),
			rt.new_string(@METHOD), rt.new_string(var_message.clone().to_string().trim_space()),
			rt.call_function('wp_json_encode', [var_details.clone()])]),
	])
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_community_events(user_location bool, arg_1 rt.PhpVal) &Class_WP_Community_Events {
	mut obj := &Class_WP_Community_Events{
		PhpObjectBase: rt.PhpObjectBase{}
		user_id:       rt.new_int(0)
		user_location: rt.new_bool(false)
	}
	obj.construct(user_location, arg_1)
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.trim_events(mut dispatch_arg_0)
		}
		'maybe_log_events_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.maybe_log_events_response(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
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
		'user_id' {
			this.user_id = val
			return true
		}
		'user_location' {
			this.user_location = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
