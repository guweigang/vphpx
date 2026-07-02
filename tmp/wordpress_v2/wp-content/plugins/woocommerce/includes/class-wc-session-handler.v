import rt

struct Class_WC_Session_Handler {
	rt.PhpObjectBase
pub mut:
	_cookie             rt.PhpVal = rt.new_string('')
	_session_expiring   rt.PhpVal = rt.new_int(0)
	_session_expiration rt.PhpVal = rt.new_int(0)
	_has_cookie         bool
	_table              rt.PhpVal = rt.new_string('')
}

fn (mut this Class_WC_Session_Handler) construct() {
	mut var_GLOBALS := rt.new_null()
	this._cookie = (rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cookie'),
		rt.new_string('wp_woocommerce_session_' + (rt.get_constant('COOKIEHASH')).str()),
	])).str()
	this._table = (rt.get_property(var_GLOBALS.array_get(rt.new_string('wpdb')), 'prefix')).str() +
		'woocommerce_sessions'
	this.set_session_expiration()
}

fn (mut this Class_WC_Session_Handler) init() {
	this.init_hooks()
	this.init_session()
}

fn (mut this Class_WC_Session_Handler) init_hooks() {
	rt.call_function('add_action', [rt.new_string('woocommerce_set_cart_cookies'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Session_Handler', [
				'WC_Session',
			], &this) },
			rt.ArrayItem{ key: none, val: 'set_customer_session_cookie' },
		]),
		rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('wp'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Session_Handler', [
				'WC_Session',
			], &this) },
			rt.ArrayItem{ key: none, val: 'maybe_set_customer_session_cookie' },
		]),
		rt.new_int(99)])
	rt.call_function('add_action', [rt.new_string('template_redirect'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Session_Handler', [
				'WC_Session',
			], &this) },
			rt.ArrayItem{ key: none, val: 'destroy_session_if_empty' },
		]),
		rt.new_int(999)])
	rt.call_function('add_action', [rt.new_string('shutdown'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Session_Handler', [
				'WC_Session',
			], &this) },
			rt.ArrayItem{ key: none, val: 'save_data' },
		]),
		rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('wp_logout'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Session_Handler', [
				'WC_Session',
			], &this) },
			rt.ArrayItem{ key: none, val: 'destroy_session' },
		])])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
		rt.call_function('add_filter', [rt.new_string('nonce_user_logged_out'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Session_Handler', [
					'WC_Session',
				], &this) },
				rt.ArrayItem{ key: none, val: 'maybe_update_nonce_user_logged_out' },
			]),
			rt.new_int(10), rt.new_int(2)])
	}
}

fn (mut this Class_WC_Session_Handler) init_session() {
	if !(this.init_session_from_request()) {
		this.init_session_cookie()
	}
}

fn (mut this Class_WC_Session_Handler) init_session_from_request() bool {
	mut var_session_token := if if !(rt.get_superglobal('_GET').array_get(rt.new_string('session'))).is_null() {
		rt.get_superglobal('_GET').array_get(rt.new_string('session'))
	} else {
		rt.new_string('')
	}.is_string()
	{ rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [if !(rt.get_superglobal('_GET').array_get(rt.new_string('session'))).is_null() {
				rt.get_superglobal('_GET').array_get(rt.new_string('session'))
			} else {
				rt.new_string('')
			}]),
		])
	 } else { rt.new_string('')
	 }
	mut iife_temp_0 := Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils{}
	mut iife_result_0 := iife_temp_0.validate_cart_token(var_session_token.clone())
	if !rt.is_true(var_session_token) || rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		return false
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils{}
	mut iife_result_1 := iife_temp_1.get_cart_token_payload(var_session_token.clone())
	mut var_payload := iife_result_1
	if !(this.is_customer_guest(var_payload.array_get(rt.new_string('user_id'))))
		|| !(this.session_exists(var_payload.array_get(rt.new_string('user_id')))) {
		return false
	}
	mut var_cookie := this.get_session_cookie()
	if rt.is_true(var_cookie) {
		if rt.is_true(rt.identical(var_cookie.array_get(rt.new_int(0)),
			var_payload.array_get(rt.new_string('user_id'))))
		{
			return false
		}
		mut var_cookie_session_data := rt.cast_array(this.get_session(var_cookie.array_get(rt.new_int(0)),
			(rt.new_array()).to_bool()))
		if var_cookie_session_data.array_isset(rt.new_string('previous_customer_id'))
			&& rt.is_true(rt.identical(var_cookie_session_data.array_get(rt.new_string('previous_customer_id')), var_payload.array_get(rt.new_string('user_id')))) {
			return false
		}
	}
	this.dispatch_set_prop('_customer_id', this.generate_customer_id())
	this.set_customer_session_cookie(rt.new_bool(true))
	this.clone_session_data((var_payload.array_get(rt.new_string('user_id'))).str())
	return true
}

fn (mut this Class_WC_Session_Handler) init_session_cookie() {
	mut var_cookie := this.get_session_cookie()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_cookie)))) {
		this.dispatch_set_prop('_customer_id', this.generate_customer_id())
		this.dispatch_set_prop('_data', this.get_session_data())
		return
	}
	this.dispatch_set_prop('_customer_id', var_cookie.array_get(rt.new_int(0)))
	this._session_expiration = rt.new_int((var_cookie.array_get(rt.new_int(1))).to_i64())
	this._session_expiring = rt.new_int((var_cookie.array_get(rt.new_int(2))).to_i64())
	this._has_cookie = true
	this.restore_session_data()
	if !(this.is_session_cookie_valid()) {
		this.destroy_session()
	}
	if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical((rt.call_function('get_current_user_id', []rt.PhpVal{})).str(), this.get_customer_id())))) {
		this.migrate_guest_session_to_user_session()
	}
	if rt.is_true(this.is_session_expiring()) {
		this.set_session_expiration()
		this.update_session_timestamp(this.get_customer_id(), this._session_expiration)
	}
}

fn (mut this Class_WC_Session_Handler) clone_session_data(clone_from_customer_id string) {
	mut var_session_data := rt.cast_array(this.get_session(rt.new_string(clone_from_customer_id),
		(rt.new_array()).to_bool()))
	var_session_data.array_set('previous_customer_id', clone_from_customer_id)
	var_session_data = rt.call_function('array_diff_key', [var_session_data.clone(),
		rt.create_array([rt.ArrayItem{ key: 'customer', val: true }])])
	this.dispatch_set_prop('_data', var_session_data.clone())
	this.dispatch_set_prop('_dirty', rt.new_bool(true))
	this.save_data('')
}

fn (mut this Class_WC_Session_Handler) migrate_guest_session_to_user_session() {
	mut var_guest_session_id := rt.get_property(rt.new_object('WC_Session_Handler', [
		'WC_Session',
	], &this), '_customer_id')
	mut var_user_session_id :=
		rt.new_string((rt.call_function('get_current_user_id', []rt.PhpVal{})).str())
	this.dispatch_set_prop('_data', this.get_session(var_guest_session_id.clone(),
		(rt.new_array()).to_bool()))
	this.dispatch_set_prop('_dirty', rt.new_bool(true))
	this.dispatch_set_prop('_customer_id', var_user_session_id.clone())
	this.save_data(var_guest_session_id.str())
	rt.call_function('do_action', [rt.new_string('woocommerce_guest_session_to_user_id'),
		var_guest_session_id.clone(), var_user_session_id.clone()])
	this.set_session_expiration()
	this.update_session_timestamp(this.get_customer_id(), this._session_expiration)
	this.set_customer_session_cookie(rt.new_bool(true))
}

fn (mut this Class_WC_Session_Handler) restore_session_data() {
	mut var_session_data := this.get_session_data()
	this.dispatch_set_prop('_data', rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_restored_session_data'),
		var_session_data.clone(),
	])))
}

fn (mut this Class_WC_Session_Handler) is_session_cookie_valid() bool {
	if rt.is_true(rt.greater(rt.call_function('time', []rt.PhpVal{}), this._session_expiration)) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})))))
		&& !(this.is_customer_guest(this.get_customer_id())) {
		return false
	}
	if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))
		&& !(this.is_customer_guest(this.get_customer_id()))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical((rt.call_function('get_current_user_id', []rt.PhpVal{})).str(), this.get_customer_id())))) {
		return false
	}
	return true
}

fn (mut this Class_WC_Session_Handler) maybe_set_customer_session_cookie() {
	if rt.is_true(rt.call_function('is_wc_endpoint_url', [rt.new_string('order-pay')])) {
		this.set_customer_session_cookie(rt.new_bool(true))
	}
}

fn (mut this Class_WC_Session_Handler) hash(message string) rt.PhpVal {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_fast_hash')])) {
		return rt.call_function('wp_fast_hash', [rt.new_string(message)])
	}
	return rt.call_function('hash_hmac', [rt.new_string('md5'),
		rt.new_string(message), rt.call_function('wp_hash', [rt.new_string(message)])])
}

fn (mut this Class_WC_Session_Handler) verify_hash(message string, hash string) rt.PhpVal {
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_verify_fast_hash'),
	]))
	{
		return rt.call_function('wp_verify_fast_hash', [rt.new_string(message),
			rt.new_string(hash)])
	}
	return rt.call_function('hash_equals', [
		rt.call_function('hash_hmac', [rt.new_string('md5'), rt.new_string(message),
			rt.call_function('wp_hash', [rt.new_string(message)])]),
		rt.new_string(hash),
	])
}

fn (mut this Class_WC_Session_Handler) set_customer_session_cookie(var_set rt.PhpVal) {
	if rt.is_true(var_set) {
		mut var_cookie_hash := this.hash(
			(this.get_customer_id()).str() + '|' + (this._session_expiration).str())
		mut var_cookie_value := rt.new_string((this.get_customer_id()).str() + '|' +
			(this._session_expiration).str() + '|' + (this._session_expiring).str() + '|' +
			var_cookie_hash.str())
		if !(rt.get_superglobal('_COOKIE').array_isset(this._cookie))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_superglobal('_COOKIE').array_get(this._cookie), var_cookie_value)))) {
			rt.call_function('wc_setcookie', [this._cookie, var_cookie_value.clone(),
				this._session_expiration, rt.new_bool(this.use_secure_cookie()),
				rt.new_bool(true)])
		}
		this._has_cookie = true
	}
}

fn (mut this Class_WC_Session_Handler) use_secure_cookie() bool {
	return (rt.call_function('apply_filters', [
		rt.new_string('wc_session_use_secure_cookie'),
		rt.new_bool(rt.is_true(rt.call_function('wc_site_is_https', []rt.PhpVal{}))
			&& rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{}))),
	])).to_bool()
}

fn (mut this Class_WC_Session_Handler) has_session() bool {
	return rt.get_superglobal('_COOKIE').array_isset(this._cookie) || this._has_cookie
		|| rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))
}

fn (mut this Class_WC_Session_Handler) is_session_expiring() rt.PhpVal {
	return rt.greater(rt.call_function('time', []rt.PhpVal{}), this._session_expiring)
}

fn (mut this Class_WC_Session_Handler) set_session_expiration() {
	mut var_default_expiring_seconds := rt.get_constant('DAY_IN_SECONDS')
	mut var_default_expiration_seconds := if rt.is_true(rt.call_function('is_user_logged_in',
		[]rt.PhpVal{}))
	{
		rt.get_constant('WEEK_IN_SECONDS')
	} else {
		rt.mul(rt.new_int(2), rt.get_constant('DAY_IN_SECONDS'))
	}
	mut var_max_expiration_seconds := rt.get_constant('MONTH_IN_SECONDS')
	mut var_max_expiring_seconds := rt.sub(var_max_expiration_seconds,
		rt.get_constant('DAY_IN_SECONDS'))
	mut var_session_limit_exceeded := rt.new_bool(false)
	mut var_expiring_seconds := if rt.is_true(rt.new_int(rt.call_function('apply_filters', [
		rt.new_string('wc_session_expiring'),
		var_default_expiring_seconds.clone(),
	]).to_i64()))
	{ rt.new_int(rt.call_function('apply_filters', [rt.new_string('wc_session_expiring'),
			var_default_expiring_seconds.clone()]).to_i64()) } else { var_default_expiring_seconds }
	if rt.is_true(rt.greater(var_expiring_seconds, var_max_expiring_seconds)) {
		var_session_limit_exceeded = rt.new_bool(true)
	}
	mut var_expiration_seconds := if rt.is_true(rt.new_int(rt.call_function('apply_filters', [
		rt.new_string('wc_session_expiration'),
		var_default_expiration_seconds.clone(),
	]).to_i64()))
	{ rt.new_int(rt.call_function('apply_filters', [
			rt.new_string('wc_session_expiration'),
			var_default_expiration_seconds.clone(),
		]).to_i64()) } else { var_default_expiration_seconds }
	if rt.is_true(rt.greater(var_expiration_seconds, var_max_expiration_seconds)) {
		var_session_limit_exceeded = rt.new_bool(true)
	}
	if rt.is_true(var_session_limit_exceeded) {
		mut var_transient_key := rt.new_string('wc_session_handler_warning')
		if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('get_transient', [
			var_transient_key.clone(),
		])))
		{
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [
				rt.call_function('sprintf', [
					rt.new_string('Keeping sessions for longer than %d days can cause performance issues and larger session tables. Monitor usage and adjust lifetimes via the wc_session_expiring and wc_session_expiration filters as needed.'),
					rt.div(var_max_expiration_seconds, rt.get_constant('DAY_IN_SECONDS')),
				]),
				rt.create_array([
					rt.ArrayItem{ key: 'source', val: 'wc_session_handler' },
				]),
			])
			rt.call_function('set_transient', [var_transient_key.clone(),
				rt.new_bool(true), var_max_expiration_seconds.clone()])
		}
	}
	if rt.is_true(rt.greater(var_expiring_seconds, var_expiration_seconds)) {
		var_expiring_seconds = rt.new_float(var_expiration_seconds * 0.9)
	}
	this._session_expiring = rt.add(rt.call_function('time', []rt.PhpVal{}), var_expiring_seconds)
	this._session_expiration = rt.add(rt.call_function('time', []rt.PhpVal{}),
		var_expiration_seconds)
}

fn (mut this Class_WC_Session_Handler) generate_customer_id() rt.PhpVal {
	return if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) { (rt.call_function('get_current_user_id', []rt.PhpVal{})).str() } else { rt.call_function('wc_rand_hash', [
			rt.new_string('t_'),
			rt.new_int(30),
		]) }
}

fn (mut this Class_WC_Session_Handler) is_customer_guest(var_customer_id rt.PhpVal) bool {
	mut var_customer_id_mutated := var_customer_id
	return !rt.is_true(var_customer_id_mutated)
		|| rt.is_true(rt.identical(rt.new_string('t_'), rt.call_function('substr', [var_customer_id_mutated.clone(), rt.new_int(0), rt.new_int(2)])))
}

fn (mut this Class_WC_Session_Handler) get_customer_unique_id() rt.PhpVal {
	mut var_customer_id := rt.new_string('')
	if this.has_session() && rt.is_true(this.get_customer_id()) {
		var_customer_id = this.get_customer_id()
	} else if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
		var_customer_id =
			rt.new_string((rt.call_function('get_current_user_id', []rt.PhpVal{})).str())
	}
	return var_customer_id.clone()
}

fn (mut this Class_WC_Session_Handler) get_session_cookie() rt.PhpVal {
	mut var_customer_id := rt.new_null()
	mut var_session_expiration := rt.new_null()
	mut var_session_expiring := rt.new_null()
	mut var_cookie_hash := rt.new_null()
	mut var_cookie_value := if rt.get_superglobal('_COOKIE').array_isset(this._cookie) { rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [
				rt.new_string((rt.get_superglobal('_COOKIE').array_get(this._cookie)).str()),
			]),
		]) } else { rt.new_string('') }
	if !rt.is_true(var_cookie_value) {
		return rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
		var_cookie_value.clone(),
		rt.new_string('||'),
	]), rt.new_bool(false)))))
	{
		mut var_parsed_cookie := rt.call_function('explode', [
			rt.new_string('||'), var_cookie_value.clone()])
	} else {
		var_parsed_cookie = rt.call_function('explode', [rt.new_string('|'),
			var_cookie_value.clone()])
	}
	if rt.is_true(rt.new_bool(var_parsed_cookie.clone().array_count() != 4)) {
		return rt.new_bool(false)
	}
	mut list_tmp_1 := var_parsed_cookie
	var_customer_id = list_tmp_1.array_get(0)
	var_session_expiration = list_tmp_1.array_get(1)
	var_session_expiring = list_tmp_1.array_get(2)
	var_cookie_hash = list_tmp_1.array_get(3)
	if !rt.is_true(var_customer_id) {
		return rt.new_bool(false)
	}
	mut var_verify_hash := this.verify_hash(var_customer_id.str() + '|' +
		var_session_expiration.str(), var_cookie_hash.str())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_verify_hash)))) {
		return rt.new_bool(false)
	}
	return rt.create_array([rt.ArrayItem{ key: none, val: var_customer_id },
		rt.ArrayItem{ key: none, val: var_session_expiration },
		rt.ArrayItem{ key: none, val: var_session_expiring },
		rt.ArrayItem{ key: none, val: var_cookie_hash }])
}

fn (mut this Class_WC_Session_Handler) get_session_data() rt.PhpVal {
	return if this.has_session() {
		rt.cast_array(this.get_session(this.get_customer_id(), (rt.new_array()).to_bool()))
	} else {
		rt.new_array()
	}
}

fn (mut this Class_WC_Session_Handler) get_cache_prefix() rt.PhpVal {
	mut iife_temp_2 := Class_WC_Cache_Helper{}
	mut iife_result_2 := iife_temp_2.get_cache_prefix(rt.get_constant('WC_SESSION_CACHE_GROUP'))
	return iife_result_2
}

fn (mut this Class_WC_Session_Handler) save_data(old_session_key string) {
	mut var_wpdb := rt.new_null()
	if rt.get_property(rt.new_object('WC_Session_Handler', ['WC_Session'], &this), '_dirty')
		&& this.has_session() {
		rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.new_string('INSERT INTO %i (`session_key`, `session_value`, `session_expiry`) VALUES (%s, %s, %d)\n \t\t\t\t\tON DUPLICATE KEY UPDATE `session_value` = VALUES(`session_value`), `session_expiry` = VALUES(`session_expiry`)'),
				this._table,
				this.get_customer_id(),
				rt.call_function('maybe_serialize', [
					rt.get_property(rt.new_object('WC_Session_Handler', ['WC_Session'], &this),
						'_data'),
				]),
				this._session_expiration,
			]),
		])
		rt.call_function('wp_cache_set', [
			rt.new_string((this.get_cache_prefix()).str() + (this.get_customer_id()).str()),
			rt.get_property(rt.new_object('WC_Session_Handler', ['WC_Session'], &this), '_data'),
			rt.get_constant('WC_SESSION_CACHE_GROUP'),
			rt.sub(this._session_expiration, rt.call_function('time', []rt.PhpVal{})),
		])
		this.dispatch_set_prop('_dirty', rt.new_bool(false))
		if !(old_session_key == '')
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.get_customer_id(), rt.new_string(old_session_key)))))
			&& !(rt.call_function('get_user_by', [rt.new_string('id'), rt.new_string(old_session_key)]).is_object()) {
			this.delete_session(rt.new_string(old_session_key))
		}
	}
}

fn (mut this Class_WC_Session_Handler) destroy_session() {
	this.delete_session(this.get_customer_id())
	this.forget_session()
	this.set_session_expiration()
}

fn (mut this Class_WC_Session_Handler) forget_session() {
	rt.call_function('wc_setcookie', [this._cookie, rt.new_string(''),
		rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.get_constant('YEAR_IN_SECONDS')),
		rt.new_bool(this.use_secure_cookie()), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wc-cart-functions.php',
			'2')
		rt.call_function('wc_empty_cart', []rt.PhpVal{})
	}
	this.dispatch_set_prop('_data', rt.new_array())
	this.dispatch_set_prop('_dirty', rt.new_bool(false))
	this.dispatch_set_prop('_customer_id', this.generate_customer_id())
	this._has_cookie = false
}

fn (mut this Class_WC_Session_Handler) maybe_update_nonce_user_logged_out(var_uid rt.PhpVal, var_action rt.PhpVal) rt.PhpVal {
	mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_StringUtil{}
	mut iife_result_3 := iife_temp_3.starts_with(var_action.clone(), rt.new_string('woocommerce'))
	if var_action.clone().is_string() && rt.is_true(iife_result_3) {
		return if this.has_session() && rt.is_true(this.get_customer_id()) {
			this.get_customer_id()
		} else {
			var_uid
		}
	}
	return var_uid.clone()
}

fn (mut this Class_WC_Session_Handler) cleanup_sessions() {
	mut var_wpdb := rt.new_null()
	mut var_batch_size := rt.new_int(100)
	mut var_deleted_entries_total := rt.new_int(0)
	for {
		mut var_deleted_entries_count := rt.new_int((rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.new_string('DELETE FROM %i WHERE session_expiry < %d ORDER BY session_expiry LIMIT %d'),
				this._table,
				rt.call_function('time', []rt.PhpVal{}),
				var_batch_size.clone(),
			]),
		])).to_i64())
		var_deleted_entries_total = rt.add(var_deleted_entries_total, var_deleted_entries_count)
		rt.call_function('usleep', [
			rt.mul(rt.div(rt.new_int(10000), var_batch_size), var_deleted_entries_count),
		])
		if !(rt.is_true(rt.identical(var_deleted_entries_count, var_batch_size))) {
			break
		}
	}
	if rt.is_true(rt.greater(var_deleted_entries_total, rt.new_int(0)))
		&& rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Cache_Helper')])) {
		mut iife_temp_4 := Class_WC_Cache_Helper{}
		mut iife_result_4 :=
			iife_temp_4.invalidate_cache_group(rt.get_constant('WC_SESSION_CACHE_GROUP'))
	}
}

fn (mut this Class_WC_Session_Handler) get_session(var_customer_id rt.PhpVal, default_value bool) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_customer_id_mutated := var_customer_id
	mut iife_temp_5 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_5 := iife_temp_5.is_defined(rt.new_string('WP_SETUP_CONFIG'))
	if rt.is_true(iife_result_5) {
		return rt.new_bool(default_value)
	}
	mut var_value := rt.call_function('wp_cache_get', [
		rt.new_string((this.get_cache_prefix()).str() + var_customer_id_mutated.str()),
		rt.get_constant('WC_SESSION_CACHE_GROUP'),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_value)) {
		var_value = rt.call_method(var_wpdb, 'get_var', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.new_string('SELECT session_value FROM %i WHERE session_key = %s'),
				this._table,
				var_customer_id_mutated.clone(),
			]),
		])
		if rt.is_true(rt.new_bool(var_value.clone().is_null())) {
			var_value = rt.new_bool(default_value)
		}
		mut var_cache_duration := rt.sub(this._session_expiration, rt.call_function('time',
			[]rt.PhpVal{}))
		if rt.is_true(rt.less(rt.new_int(0), var_cache_duration)) {
			rt.call_function('wp_cache_add', [
				rt.new_string((this.get_cache_prefix()).str() + var_customer_id_mutated.str()),
				var_value.clone(),
				rt.get_constant('WC_SESSION_CACHE_GROUP'),
				var_cache_duration.clone(),
			])
		}
	}
	return rt.call_function('maybe_unserialize', [var_value.clone()])
}

fn (mut this Class_WC_Session_Handler) delete_session(var_customer_id rt.PhpVal) {
	mut var_GLOBALS := rt.new_null()
	mut var_customer_id_mutated := var_customer_id
	if rt.is_true(rt.new_bool(!(rt.is_true(var_customer_id_mutated)))) {
		return
	}
	rt.call_method(var_GLOBALS.array_get(rt.new_string('wpdb')), 'delete', [this._table,
		rt.create_array([
			rt.ArrayItem{ key: 'session_key', val: var_customer_id_mutated },
		])])
	rt.call_function('wp_cache_delete', [
		rt.new_string((this.get_cache_prefix()).str() + var_customer_id_mutated.str()),
		rt.get_constant('WC_SESSION_CACHE_GROUP'),
	])
}

fn (mut this Class_WC_Session_Handler) update_session_timestamp(var_customer_id rt.PhpVal, var_timestamp rt.PhpVal) {
	mut var_GLOBALS := rt.new_null()
	mut var_customer_id_mutated := var_customer_id
	if rt.is_true(rt.new_bool(!(rt.is_true(var_customer_id_mutated)))) {
		return
	}
	rt.call_method(var_GLOBALS.array_get(rt.new_string('wpdb')), 'update', [this._table,
		rt.create_array([rt.ArrayItem{ key: 'session_expiry', val: var_timestamp }]),
		rt.create_array([rt.ArrayItem{ key: 'session_key', val: var_customer_id_mutated }]),
		rt.create_array([rt.ArrayItem{ key: none, val: '%d' }])])
}

fn (mut this Class_WC_Session_Handler) destroy_session_if_empty() {
	if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) || !(this._has_cookie) {
		return
	}
	if !(rt.get_superglobal('_COOKIE').array_isset(this._cookie)) {
		return
	}
	if !(!rt.is_true(rt.get_property(rt.new_object('WC_Session_Handler', [
		'WC_Session',
	], &this), '_data'))) {
		return
	}
	if rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart').is_object()
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'is_empty', []rt.PhpVal{}))))) {
		return
	}
	mut var_feature_controller := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_Features_FeaturesController.class(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_feature_controller,
		'feature_is_enabled', [rt.new_string('destroy-empty-sessions')])))))
	{
		return
	}
	this.destroy_session()
}

fn (mut this Class_WC_Session_Handler) session_exists(var_customer_id rt.PhpVal) bool {
	mut var_GLOBALS := rt.new_null()
	mut var_customer_id_mutated := var_customer_id
	return rt.is_true(var_customer_id_mutated)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.call_method(var_GLOBALS.array_get(rt.new_string('wpdb')), 'get_var', [rt.call_method(var_GLOBALS.array_get(rt.new_string('wpdb')), 'prepare', [rt.new_string('SELECT session_key FROM %i WHERE session_key = %s'), this._table, var_customer_id_mutated.clone()])])))))
}

struct Class_WC_Session {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_StringUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_wc_session_handler() &Class_WC_Session_Handler {
	mut obj := &Class_WC_Session_Handler{
		PhpObjectBase:       rt.PhpObjectBase{}
		_cookie:             rt.new_string('')
		_session_expiring:   rt.new_int(0)
		_session_expiration: rt.new_int(0)
		_has_cookie:         false
		_table:              rt.new_string('')
	}
	obj.construct()
	return obj
}

fn create_wc_session(_args ...rt.PhpVal) &Class_WC_Session {
	mut obj := &Class_WC_Session{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_carttokenutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cache_helper(_args ...rt.PhpVal) &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_stringutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_StringUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_StringUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Session_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'init_hooks' {
			this.init_hooks()
			return rt.new_null()
		}
		'init_session' {
			this.init_session()
			return rt.new_null()
		}
		'init_session_from_request' {
			return rt.new_bool(this.init_session_from_request())
		}
		'init_session_cookie' {
			this.init_session_cookie()
			return rt.new_null()
		}
		'clone_session_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.clone_session_data(dispatch_arg_0)
			return rt.new_null()
		}
		'migrate_guest_session_to_user_session' {
			this.migrate_guest_session_to_user_session()
			return rt.new_null()
		}
		'restore_session_data' {
			this.restore_session_data()
			return rt.new_null()
		}
		'is_session_cookie_valid' {
			return rt.new_bool(this.is_session_cookie_valid())
		}
		'maybe_set_customer_session_cookie' {
			this.maybe_set_customer_session_cookie()
			return rt.new_null()
		}
		'hash' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.hash(dispatch_arg_0)
		}
		'verify_hash' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.verify_hash(dispatch_arg_0, dispatch_arg_1)
		}
		'set_customer_session_cookie' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_customer_session_cookie(dispatch_arg_0)
			return rt.new_null()
		}
		'use_secure_cookie' {
			return rt.new_bool(this.use_secure_cookie())
		}
		'has_session' {
			return rt.new_bool(this.has_session())
		}
		'is_session_expiring' {
			return this.is_session_expiring()
		}
		'set_session_expiration' {
			this.set_session_expiration()
			return rt.new_null()
		}
		'generate_customer_id' {
			return this.generate_customer_id()
		}
		'is_customer_guest' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_customer_guest(dispatch_arg_0))
		}
		'get_customer_unique_id' {
			return this.get_customer_unique_id()
		}
		'get_session_cookie' {
			return this.get_session_cookie()
		}
		'get_session_data' {
			return this.get_session_data()
		}
		'get_cache_prefix' {
			return this.get_cache_prefix()
		}
		'save_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.save_data(dispatch_arg_0)
			return rt.new_null()
		}
		'destroy_session' {
			this.destroy_session()
			return rt.new_null()
		}
		'forget_session' {
			this.forget_session()
			return rt.new_null()
		}
		'maybe_update_nonce_user_logged_out' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.maybe_update_nonce_user_logged_out(dispatch_arg_0, dispatch_arg_1)
		}
		'cleanup_sessions' {
			this.cleanup_sessions()
			return rt.new_null()
		}
		'get_session' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_session(dispatch_arg_0, dispatch_arg_1)
		}
		'delete_session' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.delete_session(dispatch_arg_0)
			return rt.new_null()
		}
		'update_session_timestamp' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.update_session_timestamp(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'destroy_session_if_empty' {
			this.destroy_session_if_empty()
			return rt.new_null()
		}
		'session_exists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.session_exists(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Session_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'_cookie' { return this._cookie }
		'_session_expiring' { return this._session_expiring }
		'_session_expiration' { return this._session_expiration }
		'_has_cookie' { return rt.new_bool(this._has_cookie) }
		'_table' { return this._table }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Session_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'_cookie' {
			this._cookie = val
			return true
		}
		'_session_expiring' {
			this._session_expiring = val
			return true
		}
		'_session_expiration' {
			this._session_expiration = val
			return true
		}
		'_has_cookie' {
			this._has_cookie = val.to_bool()
			return true
		}
		'_table' {
			this._table = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Session) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Session) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Session) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
