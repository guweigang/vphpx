import rt

struct Class_WC_REST_Authentication {
	rt.PhpObjectBase
pub mut:
	error       rt.PhpVal = rt.new_null()
	user        rt.PhpVal = rt.new_null()
	auth_method string
}

fn Class_WC_REST_Authentication.instance() rt.PhpVal {
	mut var_instance := rt.new_null()
	if !(!var_instance.is_null()) {
		var_instance = create_wc_rest_authentication()
	}
	return mut var_instance
}

fn (mut this Class_WC_REST_Authentication) construct() {
	rt.call_function('add_filter', [rt.new_string('determine_current_user'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Authentication', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'authenticate' },
		]),
		rt.new_int(15)])
	rt.call_function('add_filter', [rt.new_string('rest_authentication_errors'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Authentication', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'authentication_fallback' },
		])])
	rt.call_function('add_filter', [rt.new_string('rest_authentication_errors'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Authentication', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'check_authentication_error' },
		]),
		rt.new_int(15)])
	rt.call_function('add_filter', [rt.new_string('rest_post_dispatch'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Authentication', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'send_unauthorized_headers' },
		]),
		rt.new_int(50)])
	rt.call_function('add_filter', [rt.new_string('rest_pre_dispatch'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Authentication', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'check_user_permissions' },
		]),
		rt.new_int(10), rt.new_int(3)])
}

fn (mut this Class_WC_REST_Authentication) is_request_to_rest_api() bool {
	if !rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))) {
		return false
	}
	mut var_rest_prefix := rt.call_function('trailingslashit', [
		rt.call_function('rest_get_url_prefix', []rt.PhpVal{}),
	])
	mut var_request_uri := rt.call_function('esc_url_raw', [
		rt.call_function('wp_unslash',
			[rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))]),
	])
	mut var_woocommerce := rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [
		var_request_uri.clone(),
		rt.new_string(var_rest_prefix.str() + 'wc/'),
	]))))
	mut var_third_party := rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [
		var_request_uri.clone(),
		rt.new_string(var_rest_prefix.str() + 'wc-'),
	]))))
	return (rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_is_request_to_rest_api'),
		rt.new_bool(rt.is_true(var_woocommerce) || rt.is_true(var_third_party)),
	])).to_bool()
}

fn (mut this Class_WC_REST_Authentication) authenticate(var_user_id rt.PhpVal) rt.PhpVal {
	mut var_user_id_mutated := var_user_id
	if !(!rt.is_true(var_user_id_mutated)) || !(this.is_request_to_rest_api()) {
		return var_user_id_mutated.clone()
	}
	if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) {
		var_user_id_mutated = rt.new_bool(this.perform_basic_authentication())
	}
	if rt.is_true(var_user_id_mutated) {
		return var_user_id_mutated.clone()
	}
	return rt.new_bool(this.perform_oauth_authentication())
}

fn (mut this Class_WC_REST_Authentication) authentication_fallback(var_error rt.PhpVal) bool {
	if !(!rt.is_true(var_error)) {
		return var_error.to_bool()
	}
	if !rt.is_true(this.error) && this.auth_method == '' && !rt.is_true(this.user)
		&& rt.is_true(rt.identical(rt.new_int(0), rt.call_function('get_current_user_id', []rt.PhpVal{}))) {
		mut var_user_id := this.authenticate(rt.new_bool(false))
		if rt.is_true(var_user_id) {
			rt.call_function('wp_set_current_user', [var_user_id.clone()])
			return true
		}
	}
	return var_error.to_bool()
}

fn (mut this Class_WC_REST_Authentication) check_authentication_error(var_error rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_error)) {
		return var_error.clone()
	}
	return this.get_error()
}

fn (mut this Class_WC_REST_Authentication) set_error(var_error rt.PhpVal) {
	this.user = rt.new_null()
	this.error = var_error.clone()
}

fn (mut this Class_WC_REST_Authentication) get_error() rt.PhpVal {
	return this.error
}

fn (mut this Class_WC_REST_Authentication) perform_basic_authentication() bool {
	this.auth_method = 'basic_auth'
	mut var_consumer_key := rt.new_string('')
	mut var_consumer_secret := rt.new_string('')
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('consumer_key'))))
		&& !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('consumer_secret')))) {
		var_consumer_key = rt.get_superglobal('_GET').array_get(rt.new_string('consumer_key'))
		var_consumer_secret = rt.get_superglobal('_GET').array_get(rt.new_string('consumer_secret'))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_consumer_key))))
		&& !(!rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_AUTH_USER'))))
		&& !(!rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_AUTH_PW')))) {
		var_consumer_key = rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_AUTH_USER'))
		var_consumer_secret = rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_AUTH_PW'))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_consumer_key))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_consumer_secret)))) {
		return false
	}
	this.user = this.get_user_data_by_consumer_key(var_consumer_key.clone())
	if !rt.is_true(this.user) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('hash_equals', [
		rt.get_property(this.user, 'consumer_secret'),
		var_consumer_secret.clone(),
	])))))
	{
		this.set_error(create_wp_error(rt.new_string('woocommerce_rest_authentication_error'), rt.call_function('__', [
			rt.new_string('Consumer secret is invalid.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 401 }])))
		return false
	}
	return (rt.get_property(this.user, 'user_id')).to_bool()
}

fn (mut this Class_WC_REST_Authentication) parse_header(var_header rt.PhpVal) rt.PhpVal {
	mut var_matches := []rt.PhpVal{}
	mut var_header_mutated := var_header
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('OAuth '), rt.call_function('substr', [
		var_header_mutated.clone(),
		rt.new_int(0),
		rt.new_int(6),
	])))))
	{
		return rt.new_array()
	}
	mut var_params := rt.new_array()
	if rt.is_true(rt.call_function('preg_match_all', [
		rt.new_string('/(oauth_[a-z_-]*)=(:?"([^"]*)"|([^,]*))/'),
		var_header_mutated.clone(),
		rt.create_array_from_list(var_matches),
	]))
	{
		mut iter_1 := var_matches.array_get(rt.new_int(1)).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_h := item_1.val
			mut var_i := item_1.key
			var_params.array_set(var_h, rt.call_function('urldecode', [if !rt.is_true(var_matches.array_get(rt.new_int(3)).array_get(var_i)) {
				var_matches.array_get(rt.new_int(4)).array_get(var_i)
			} else {
				var_matches.array_get(rt.new_int(3)).array_get(var_i)
			}]))
		}
		if var_params.array_isset(rt.new_string('realm')) {
			var_params.array_unset(rt.new_string('realm'))
		}
	}
	return var_params.clone()
}

fn (mut this Class_WC_REST_Authentication) get_authorization_header() string {
	if !(!rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_AUTHORIZATION')))) {
		return (rt.call_function('wp_unslash', [
			rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_AUTHORIZATION')),
		])).str()
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('getallheaders')])) {
		mut var_headers := rt.call_function('getallheaders', []rt.PhpVal{})
		mut iter_2 := var_headers.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_value := item_2.val
			mut var_key := item_2.key
			if rt.is_true(rt.identical(rt.new_string('authorization'),
				rt.new_string(var_key.clone().to_string().to_lower())))
			{
				return var_value.str()
			}
		}
	}
	return ''
}

fn (mut this Class_WC_REST_Authentication) get_oauth_parameters() rt.PhpVal {
	mut var_params := rt.call_function('array_merge', [rt.get_superglobal('_GET').clone(),
		rt.get_superglobal('_POST').clone()])
	var_params = rt.call_function('wp_unslash', [var_params.clone()])
	mut var_header := rt.new_string(this.get_authorization_header())
	if !(!rt.is_true(var_header)) {
		var_header = rt.new_string(var_header.clone().to_string().trim_space())
		mut var_header_params := this.parse_header(var_header.clone())
		if !(!rt.is_true(var_header_params)) {
			var_params = rt.call_function('array_merge', [var_params.clone(),
				var_header_params.clone()])
		}
	}
	mut var_param_names := ['oauth_consumer_key', 'oauth_timestamp', 'oauth_nonce', 'oauth_signature',
		'oauth_signature_method']
	mut var_errors := rt.new_array()
	mut var_have_one := rt.new_bool(false)
	for var_param_name in var_param_names {
		if !rt.is_true(var_params.array_get(rt.new_string(param_name))) {
			var_errors << rt.new_string(param_name)
		} else {
			var_have_one = rt.new_bool(true)
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_have_one)))) {
		return rt.new_array()
	}
	if !(!rt.is_true(var_errors)) {
		mut var_message := rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('Missing OAuth parameter %s'),
				rt.new_string('Missing OAuth parameters %s'),
				rt.new_int(var_errors.len), rt.new_string('woocommerce')]),
			rt.call_function('implode', [rt.new_string(', '),
				rt.create_array_from_list(var_errors)]),
		])
		this.set_error(create_wp_error(rt.new_string('woocommerce_rest_authentication_missing_parameter'),
			var_message.clone(), rt.create_array([
			rt.ArrayItem{ key: 'status', val: 401 },
		])))
		return rt.new_array()
	}
	return var_params.clone()
}

fn (mut this Class_WC_REST_Authentication) perform_oauth_authentication() bool {
	this.auth_method = 'oauth1'
	mut var_params := this.get_oauth_parameters()
	if !rt.is_true(var_params) {
		return false
	}
	this.user =
		this.get_user_data_by_consumer_key(var_params.array_get(rt.new_string('oauth_consumer_key')))
	if !rt.is_true(this.user) {
		this.set_error(create_wp_error(rt.new_string('woocommerce_rest_authentication_error'), rt.call_function('__', [
			rt.new_string('Consumer key is invalid.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 401 }])))
		return false
	}
	mut var_signature := rt.new_bool(this.check_oauth_signature(this.user, var_params.clone()))
	if rt.is_true(rt.call_function('is_wp_error', [var_signature.clone()])) {
		this.set_error(var_signature.clone())
		return false
	}
	mut var_timestamp_and_nonce := rt.new_bool(this.check_oauth_timestamp_and_nonce(this.user,
		var_params.array_get(rt.new_string('oauth_timestamp')),
		var_params.array_get(rt.new_string('oauth_nonce'))))
	if rt.is_true(rt.call_function('is_wp_error', [var_timestamp_and_nonce.clone()])) {
		this.set_error(var_timestamp_and_nonce.clone())
		return false
	}
	return (rt.get_property(this.user, 'user_id')).to_bool()
}

fn (mut this Class_WC_REST_Authentication) check_oauth_signature(var_user rt.PhpVal, var_params rt.PhpVal) bool {
	mut var_user_mutated := var_user
	mut var_params_mutated := var_params
	mut var_http_method := rt.new_string((if rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_METHOD')) {
		rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_METHOD')).to_string().to_upper()
	} else {
		''
	}).str())
	mut var_request_path := if rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_URI')) { rt.call_function('wp_parse_url', [
			rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
			rt.get_constant('PHP_URL_PATH'),
		]) } else { rt.new_string('') }
	mut var_wp_base := rt.call_function('get_home_url', [rt.new_null(),
		rt.new_string('/'), rt.new_string('relative')])
	if rt.is_true(rt.identical(rt.call_function('substr', [var_request_path.clone(),
		rt.new_int(0), rt.new_int(var_wp_base.clone().to_string().len)]), var_wp_base))
	{
		var_request_path = rt.call_function('substr', [var_request_path.clone(),
			rt.new_int(var_wp_base.clone().to_string().len)])
	}
	mut var_base_request_uri := rt.call_function('rawurlencode', [
		rt.call_function('get_home_url', [rt.new_null(), var_request_path.clone(),
			rt.new_string((if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) {
				'https'
			} else {
				'http'
			}).str())]),
	])
	mut var_consumer_signature := rt.call_function('rawurldecode', [
		rt.call_function('str_replace', [rt.new_string(' '), rt.new_string('+'),
			var_params_mutated.array_get(rt.new_string('oauth_signature'))]),
	])
	var_params_mutated.array_unset(rt.new_string('oauth_signature'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('uksort', [
		var_params_mutated.clone(), rt.new_string('strcmp')])))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_authentication_error'), rt.call_function('__', [
			rt.new_string('Invalid signature - failed to sort parameters.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 401 }]))).to_bool()
	}
	var_params_mutated = this.normalize_parameters(var_params_mutated.clone())
	mut var_query_string := rt.call_function('implode', [rt.new_string('%26'),
		this.join_with_equals_sign(var_params_mutated.clone(), rt.new_null(), '')])
	mut var_string_to_sign := rt.new_string(var_http_method.str() + '&' +
		var_base_request_uri.str() + '&' + var_query_string.str())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('HMAC-SHA1'), var_params_mutated.array_get(rt.new_string('oauth_signature_method'))))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('HMAC-SHA256'), var_params_mutated.array_get(rt.new_string('oauth_signature_method')))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_authentication_error'), rt.call_function('__', [
			rt.new_string('Invalid signature - signature method is invalid.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 401 }]))).to_bool()
	}
	mut var_hash_algorithm := rt.new_string(rt.call_function('str_replace', [
		rt.new_string('HMAC-'),
		rt.new_string(''),
		var_params_mutated.array_get(rt.new_string('oauth_signature_method')),
	]).to_string().to_lower())
	mut var_secret := rt.new_string((rt.get_property(var_user_mutated, 'consumer_secret')).str() +
		'&')
	mut var_signature := rt.call_function('base64_encode', [
		rt.call_function('hash_hmac', [var_hash_algorithm.clone(),
			var_string_to_sign.clone(), var_secret.clone(), rt.new_bool(true)]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('hash_equals', [
		var_signature.clone(), var_consumer_signature.clone()])))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_authentication_error'), rt.call_function('__', [
			rt.new_string('Invalid signature - provided signature does not match.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 401 }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Authentication) join_with_equals_sign(var_params rt.PhpVal, var_query_params rt.PhpVal, key string) rt.PhpVal {
	mut var_params_mutated := var_params
	mut var_query_params_mutated := var_query_params
	mut iter_3 := var_params_mutated.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_param_value := item_3.val
		mut var_param_key := item_3.key
		if var_key.len > 0 && var_key != '0' {
			var_param_key = rt.new_string(key + '%5B' + var_param_key.str() + '%5D')
		}
		if rt.is_true(rt.new_bool(var_param_value.clone().is_array())) {
			var_query_params_mutated = this.join_with_equals_sign(var_param_value.clone(),
				var_query_params_mutated.clone(), var_param_key.str())
		} else {
			mut var_string := rt.new_string(var_param_key.str() + '=' + var_param_value.str())
			var_query_params_mutated.array_push(rt.call_function('wc_rest_urlencode_rfc3986', [
				var_string.clone(),
			]))
		}
	}
	return var_query_params_mutated.clone()
}

fn (mut this Class_WC_REST_Authentication) normalize_parameters(var_parameters rt.PhpVal) rt.PhpVal {
	mut var_parameters_mutated := var_parameters
	mut var_keys := rt.call_function('wc_rest_urlencode_rfc3986', [
		rt.func_array_keys(var_parameters_mutated.clone()),
	])
	mut var_values := rt.call_function('wc_rest_urlencode_rfc3986', [
		rt.call_function('array_values', [var_parameters_mutated.clone()]),
	])
	var_parameters_mutated = rt.call_function('array_combine', [
		var_keys.clone(), var_values.clone()])
	return var_parameters_mutated.clone()
}

fn (mut this Class_WC_REST_Authentication) check_oauth_timestamp_and_nonce(var_user rt.PhpVal, var_timestamp rt.PhpVal, var_nonce rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_user_mutated := var_user
	mut var_valid_window := rt.new_int(15 * 60)
	if rt.is_true(rt.less(var_timestamp, rt.sub(rt.call_function('time', []rt.PhpVal{}), var_valid_window)))
		|| rt.is_true(rt.greater(var_timestamp, rt.add(rt.call_function('time', []rt.PhpVal{}), var_valid_window))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_authentication_error'), rt.call_function('__', [
			rt.new_string('Invalid timestamp.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 401 }]))).to_bool()
	}
	mut var_used_nonces := rt.call_function('maybe_unserialize', [
		rt.get_property(var_user_mutated, 'nonces'),
	])
	if !rt.is_true(var_used_nonces) {
		var_used_nonces = rt.new_array()
	}
	if rt.is_true(rt.call_function('in_array', [var_nonce.clone(),
		var_used_nonces.clone(), rt.new_bool(true)]))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_authentication_error'), rt.call_function('__', [
			rt.new_string('Invalid nonce - nonce has already been used.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 401 }]))).to_bool()
	}
	var_used_nonces.array_set(var_timestamp, var_nonce.clone())
	mut iter_4 := var_used_nonces.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_nonce_shadow := item_4.val
		mut var_nonce_timestamp := item_4.key
		if rt.is_true(rt.less(var_nonce_timestamp, rt.sub(rt.call_function('time', []rt.PhpVal{}),
			var_valid_window)))
		{
			var_used_nonces.array_unset(var_nonce_timestamp)
		}
	}
	var_used_nonces = rt.call_function('maybe_serialize', [var_used_nonces.clone()])
	rt.call_method(var_wpdb, 'update', [
		rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_api_keys'),
		rt.create_array([rt.ArrayItem{ key: 'nonces', val: var_used_nonces }]),
		rt.create_array([rt.ArrayItem{ key: 'key_id', val: rt.get_property(var_user_mutated,
			'key_id') }]),
		rt.create_array([rt.ArrayItem{ key: none, val: '%s' }]),
		rt.create_array([rt.ArrayItem{ key: none, val: '%d' }]),
	])
	return true
}

fn (mut this Class_WC_REST_Authentication) get_user_data_by_consumer_key(var_consumer_key rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_consumer_key_mutated := var_consumer_key
	var_consumer_key_mutated = rt.call_function('wc_api_hash', [
		rt.call_function('sanitize_text_field', [var_consumer_key_mutated.clone()]),
	])
	mut var_user := rt.call_method(var_wpdb, 'get_row', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT key_id, user_id, permissions, consumer_key, consumer_secret, nonces\n\t\t\tFROM '), rt.get_property(var_wpdb,
				'prefix')),
				rt.new_string('woocommerce_api_keys\n\t\t\tWHERE consumer_key = %s\n\t\t')),
			var_consumer_key_mutated.clone(),
		]),
	])
	return var_user.clone()
}

fn (mut this Class_WC_REST_Authentication) check_permissions(var_method rt.PhpVal) bool {
	mut var_permissions := rt.get_property(this.user, 'permissions')
	mut switch_val_1 := var_method
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('HEAD')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('GET'))) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('read'), var_permissions))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('read_write'), var_permissions)))) {
			return (create_wp_error(rt.new_string('woocommerce_rest_authentication_error'), rt.call_function('__', [
				rt.new_string('The API key provided does not have read permissions.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 401 }]))).to_bool()
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('POST')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('PUT')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('PATCH')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('DELETE'))) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('write'), var_permissions))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('read_write'), var_permissions)))) {
			return (create_wp_error(rt.new_string('woocommerce_rest_authentication_error'), rt.call_function('__', [
				rt.new_string('The API key provided does not have write permissions.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 401 }]))).to_bool()
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('OPTIONS'))) {
		return true
	} else {
		return (create_wp_error(rt.new_string('woocommerce_rest_authentication_error'), rt.call_function('__', [
			rt.new_string('Unknown request method.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 401 }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Authentication) update_last_access(var_request rt.PhpVal) {
	mut var_wp := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_do_not_record := rt.new_bool(true)
	if rt.is_true(rt.call_function('is_a', [var_wp.clone(), Class_WP.class()]))
		&& rt.is_true(rt.call_function('is_a', [var_request.clone(), Class_WP_REST_Request.class()])) {
		mut var_actual_http_request :=
			rt.new_string(rt.get_property(var_wp, 'request').to_string().trim_space())
		mut var_api_request_in_progress := rt.new_string(rt.call_method(var_request, 'get_route',
			[]rt.PhpVal{}).to_string().trim_space())
		mut var_rest_prefix := rt.call_function('trailingslashit', [
			rt.call_function('rest_get_url_prefix', []rt.PhpVal{}),
		])
		if rt.is_true(rt.call_function('str_starts_with', [var_actual_http_request.clone(),
			var_rest_prefix.clone()]))
		{
			var_actual_http_request = rt.call_function('substr', [
				var_actual_http_request.clone(), rt.new_int(var_rest_prefix.clone().to_string().len)])
		}
		var_do_not_record = rt.new_bool(!rt.is_true(rt.identical(var_actual_http_request,
			var_api_request_in_progress)))
	}
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_disable_rest_api_access_log'),
		var_do_not_record.clone(),
		rt.get_property(this.user, 'key_id'),
		rt.get_property(this.user, 'user_id'),
	]))
	{
		return
	}
	rt.call_method(var_wpdb, 'update', [
		rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_api_keys'),
		rt.create_array([
			rt.ArrayItem{ key: 'last_access', val: rt.call_function('current_time', [
				rt.new_string('mysql'),
			]) },
		]),
		rt.create_array([
			rt.ArrayItem{ key: 'key_id', val: rt.get_property(this.user, 'key_id') },
		]),
		rt.create_array([
			rt.ArrayItem{ key: none, val: '%s' },
		]),
		rt.create_array([
			rt.ArrayItem{ key: none, val: '%d' },
		]),
	])
}

fn (mut this Class_WC_REST_Authentication) send_unauthorized_headers(var_response rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('is_wp_error', [this.get_error()]))
		&& rt.is_true(rt.identical(rt.new_string('basic_auth'), this.auth_method)) {
		mut var_auth_message := rt.call_function('__', [
			rt.new_string('WooCommerce API. Use a consumer key in the username field and a consumer secret in the password field.'),
			rt.new_string('woocommerce'),
		])
		rt.call_method(var_response, 'header', [rt.new_string('WWW-Authenticate'),
			rt.new_string('Basic realm="' + var_auth_message.str() + '"'),
			rt.new_bool(true)])
	}
	return var_response.clone()
}

fn (mut this Class_WC_REST_Authentication) check_user_permissions(var_result rt.PhpVal, var_server rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	if rt.is_true(this.user) {
		mut var_allowed := rt.new_bool(this.check_permissions(rt.call_method(var_request,
			'get_method', []rt.PhpVal{})))
		if rt.is_true(rt.call_function('is_wp_error', [var_allowed.clone()])) {
			return var_allowed.clone()
		}
		this.update_last_access(var_request.clone())
	}
	return var_result.clone()
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_rest_authentication() &Class_WC_REST_Authentication {
	mut obj := &Class_WC_REST_Authentication{
		PhpObjectBase: rt.PhpObjectBase{}
		error:         rt.new_null()
		user:          rt.new_null()
		auth_method:   ''
	}
	obj.construct()
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Authentication) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'instance' {
			return Class_WC_REST_Authentication.instance()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'is_request_to_rest_api' {
			return rt.new_bool(this.is_request_to_rest_api())
		}
		'authenticate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.authenticate(dispatch_arg_0)
		}
		'authentication_fallback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.authentication_fallback(dispatch_arg_0))
		}
		'check_authentication_error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.check_authentication_error(dispatch_arg_0)
		}
		'set_error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_error(dispatch_arg_0)
			return rt.new_null()
		}
		'get_error' {
			return this.get_error()
		}
		'perform_basic_authentication' {
			return rt.new_bool(this.perform_basic_authentication())
		}
		'parse_header' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_header(dispatch_arg_0)
		}
		'get_authorization_header' {
			return rt.new_string(this.get_authorization_header())
		}
		'get_oauth_parameters' {
			return this.get_oauth_parameters()
		}
		'perform_oauth_authentication' {
			return rt.new_bool(this.perform_oauth_authentication())
		}
		'check_oauth_signature' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.check_oauth_signature(dispatch_arg_0, dispatch_arg_1))
		}
		'join_with_equals_sign' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.join_with_equals_sign(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'normalize_parameters' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.normalize_parameters(dispatch_arg_0)
		}
		'check_oauth_timestamp_and_nonce' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.check_oauth_timestamp_and_nonce(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2))
		}
		'get_user_data_by_consumer_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_user_data_by_consumer_key(dispatch_arg_0)
		}
		'check_permissions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_permissions(dispatch_arg_0))
		}
		'update_last_access' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update_last_access(dispatch_arg_0)
			return rt.new_null()
		}
		'send_unauthorized_headers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.send_unauthorized_headers(dispatch_arg_0)
		}
		'check_user_permissions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.check_user_permissions(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_REST_Authentication) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'error' { return this.error }
		'user' { return this.user }
		'auth_method' { return rt.new_string(this.auth_method) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Authentication) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'error' {
			this.error = val
			return true
		}
		'user' {
			this.user = val
			return true
		}
		'auth_method' {
			this.auth_method = val.str()
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

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	Class_WC_REST_Authentication.instance()
}
