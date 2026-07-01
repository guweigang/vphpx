import rt

struct Class_WC_Session_Handler {
	rt.PhpObjectBase
pub mut:
		_cookie rt.PhpVal = rt.new_string('')
		_session_expiring rt.PhpVal = rt.new_int(0)
		_session_expiration rt.PhpVal = rt.new_int(0)
		_has_cookie bool
		_table rt.PhpVal = rt.new_string('')
}

fn (mut this Class_WC_Session_Handler) construct()  {
	mut var_GLOBALS := rt.new_null()
	this._cookie = // unsupported expression: Expr_Cast_String
	this._table = (rt.get_property(var_GLOBALS.array_get('wpdb'), 'prefix')).str() + 'woocommerce_sessions'
	this.set_session_expiration()
}

fn (mut this Class_WC_Session_Handler) init()  {
	this.init_hooks()
	this.init_session()
}

fn (mut this Class_WC_Session_Handler) init_hooks()  {
	rt.call_function('add_action', [rt.new_string('woocommerce_set_cart_cookies'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Session_Handler', ['WC_Session'], &this) }, rt.ArrayItem{ key: none, val: 'set_customer_session_cookie' }]), rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('wp'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Session_Handler', ['WC_Session'], &this) }, rt.ArrayItem{ key: none, val: 'maybe_set_customer_session_cookie' }]), rt.new_int(99)])
	rt.call_function('add_action', [rt.new_string('template_redirect'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Session_Handler', ['WC_Session'], &this) }, rt.ArrayItem{ key: none, val: 'destroy_session_if_empty' }]), rt.new_int(999)])
	rt.call_function('add_action', [rt.new_string('shutdown'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Session_Handler', ['WC_Session'], &this) }, rt.ArrayItem{ key: none, val: 'save_data' }]), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('wp_logout'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Session_Handler', ['WC_Session'], &this) }, rt.ArrayItem{ key: none, val: 'destroy_session' }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
		rt.call_function('add_filter', [rt.new_string('nonce_user_logged_out'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Session_Handler', ['WC_Session'], &this) }, rt.ArrayItem{ key: none, val: 'maybe_update_nonce_user_logged_out' }]), rt.new_int(10), rt.new_int(2)])
	}
}

fn (mut this Class_WC_Session_Handler) init_session()  {
	if !(this.init_session_from_request()) {
		this.init_session_cookie()
	}
}

fn (mut this Class_WC_Session_Handler) init_session_from_request() bool {
	mut var_session_token := if rt.is_true(rt.new_bool(if !(rt.get_superglobal('_GET').array_get('session')).is_null() { rt.get_superglobal('_GET').array_get('session') } else { rt.new_string('') }.is_string())) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_GET').array_get('session')).is_null() { rt.get_superglobal('_GET').array_get('session') } else { rt.new_string('') }])]) } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(!rt.is_true(var_session_token) || rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils{}; return temp.validate_cart_token(arg_0) }(var_session_token.dup()))))))) {
		return false
	}
	mut var_payload := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils{}; return temp.get_cart_token_payload(arg_0) }(var_session_token.dup())
	if !(this.is_customer_guest(var_payload.array_get('user_id'))) || !(this.session_exists(var_payload.array_get('user_id'))) {
		return false
	}
	mut var_cookie := this.get_session_cookie()
	if rt.is_true(var_cookie) {
		if rt.is_true(rt.identical(var_cookie.array_get(0), var_payload.array_get('user_id'))) {
			return false
		}
		mut var_cookie_session_data := rt.cast_array(this.get_session(var_cookie.array_get(0), (rt.new_array()).to_bool()))
		if rt.is_true(rt.new_bool(var_cookie_session_data.array_isset(rt.new_string('previous_customer_id')) && rt.is_true(rt.identical(var_cookie_session_data.array_get('previous_customer_id'), var_payload.array_get('user_id'))))) {
			return false
		}
	}
	this.dispatch_set_prop('_customer_id', this.generate_customer_id())
	this.set_customer_session_cookie(rt.new_bool(true))
	this.clone_session_data((var_payload.array_get('user_id')).str())
	return true
}

fn (mut this Class_WC_Session_Handler) init_session_cookie()  {
	mut var_cookie := this.get_session_cookie()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_cookie)))) {
		this.dispatch_set_prop('_customer_id', this.generate_customer_id())
		this.dispatch_set_prop('_data', this.get_session_data())
		return rt.new_null()
	}
	this.dispatch_set_prop('_customer_id', var_cookie.array_get(0))
	this._session_expiration = // unsupported expression: Expr_Cast_Int
	this._session_expiring = // unsupported expression: Expr_Cast_Int
	this._has_cookie = true
	this.restore_session_data()
	if !(this.is_session_cookie_valid()) {
		this.destroy_session()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		this.migrate_guest_session_to_user_session()
	}
	if rt.is_true(this.is_session_expiring()) {
		this.set_session_expiration()
		this.update_session_timestamp(this.get_customer_id(), this._session_expiration)
	}
}

fn (mut this Class_WC_Session_Handler) clone_session_data(clone_from_customer_id string)  {
	mut var_session_data := rt.cast_array(this.get_session(rt.new_string(clone_from_customer_id), (rt.new_array()).to_bool()))
	var_session_data.array_set('previous_customer_id', clone_from_customer_id)
	var_session_data = rt.call_function('array_diff_key', [var_session_data.dup(), rt.create_array([rt.ArrayItem{ key: 'customer', val: true }])])
	this.dispatch_set_prop('_data', var_session_data.dup())
	this.dispatch_set_prop('_dirty', rt.new_bool(true))
	this.save_data('')
}

fn (mut this Class_WC_Session_Handler) migrate_guest_session_to_user_session()  {
	mut var_guest_session_id := rt.get_property(rt.new_object('WC_Session_Handler', ['WC_Session'], &this), '_customer_id')
	mut var_user_session_id := // unsupported expression: Expr_Cast_String
	this.dispatch_set_prop('_data', this.get_session(var_guest_session_id.dup(), (rt.new_array()).to_bool()))
	this.dispatch_set_prop('_dirty', rt.new_bool(true))
	this.dispatch_set_prop('_customer_id', var_user_session_id.dup())
	this.save_data((var_guest_session_id).str())
	rt.call_function('do_action', [rt.new_string('woocommerce_guest_session_to_user_id'), var_guest_session_id.dup(), var_user_session_id.dup()])
	this.set_session_expiration()
	this.update_session_timestamp(this.get_customer_id(), this._session_expiration)
	this.set_customer_session_cookie(rt.new_bool(true))
}

fn (mut this Class_WC_Session_Handler) restore_session_data()  {
	mut var_session_data := this.get_session_data()
	this.dispatch_set_prop('_data', rt.cast_array(rt.call_function('apply_filters', [rt.new_string('woocommerce_restored_session_data'), var_session_data.dup()])))
}

fn (mut this Class_WC_Session_Handler) is_session_cookie_valid() bool {
	if rt.is_true(rt.greater(rt.call_function('time', []rt.PhpVal{}), this._session_expiration)) {
		return false
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) && !(this.is_customer_guest(this.get_customer_id())))) {
		return false
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) && !(this.is_customer_guest(this.get_customer_id())))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return false
	}
	return true
}

fn (mut this Class_WC_Session_Handler) maybe_set_customer_session_cookie()  {
	if rt.is_true(rt.call_function('is_wc_endpoint_url', [rt.new_string('order-pay')])) {
		this.set_customer_session_cookie(rt.new_bool(true))
	}
}

fn (mut this Class_WC_Session_Handler) hash(message string) rt.PhpVal {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_fast_hash')])) {
		return rt.call_function('wp_fast_hash', [rt.new_string(message)])
	}
	return rt.call_function('hash_hmac', [rt.new_string('md5'), rt.new_string(message), rt.call_function('wp_hash', [rt.new_string(message)])])
}

fn (mut this Class_WC_Session_Handler) verify_hash(message string, hash string) rt.PhpVal {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_verify_fast_hash')])) {
		return rt.call_function('wp_verify_fast_hash', [rt.new_string(message), rt.new_string(hash)])
	}
	return rt.call_function('hash_equals', [rt.call_function('hash_hmac', [rt.new_string('md5'), rt.new_string(message), rt.call_function('wp_hash', [rt.new_string(message)])]), rt.new_string(hash)])
}

fn (mut this Class_WC_Session_Handler) set_customer_session_cookie(var_set rt.PhpVal)  {
	if rt.is_true(var_set) {
		mut var_cookie_hash := this.hash((this.get_customer_id()).str() + '|' + (// unsupported expression: Expr_Cast_String).str())
		mut var_cookie_value := rt.new_string((this.get_customer_id()).str() + '|' + (// unsupported expression: Expr_Cast_String).str() + '|' + (// unsupported expression: Expr_Cast_String).str() + '|' + (var_cookie_hash).str())
		if rt.is_true(rt.new_bool(!(rt.get_superglobal('_COOKIE').array_isset(this._cookie)) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			rt.call_function('wc_setcookie', [this._cookie, var_cookie_value.dup(), this._session_expiration, this.use_secure_cookie(), rt.new_bool(true)])
		}
		this._has_cookie = true
	}
}

fn (mut this Class_WC_Session_Handler) use_secure_cookie() rt.PhpVal {
	return // unsupported expression: Expr_Cast_Bool
}

fn (mut this Class_WC_Session_Handler) has_session() bool {
	return rt.is_true(rt.new_bool(rt.get_superglobal('_COOKIE').array_isset(this._cookie) || rt.is_true(this._has_cookie))) || rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))
}

fn (mut this Class_WC_Session_Handler) is_session_expiring() rt.PhpVal {
	return rt.greater(rt.call_function('time', []rt.PhpVal{}), this._session_expiring)
}

fn (mut this Class_WC_Session_Handler) set_session_expiration()  {
	mut var_default_expiring_seconds := rt.get_constant('DAY_IN_SECONDS')
	mut var_default_expiration_seconds := if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) { rt.get_constant('WEEK_IN_SECONDS') } else { rt.mul(rt.new_int(2), rt.get_constant('DAY_IN_SECONDS')) }
	mut var_max_expiration_seconds := rt.get_constant('MONTH_IN_SECONDS')
	mut var_max_expiring_seconds := rt.sub(var_max_expiration_seconds, rt.get_constant('DAY_IN_SECONDS'))
	mut var_session_limit_exceeded := rt.new_bool(rt.new_bool(false))
	mut var_expiring_seconds := if rt.is_true(rt.new_int(rt.call_function('apply_filters', [rt.new_string('wc_session_expiring'), var_default_expiring_seconds.dup()]).to_i64())) { rt.new_int(rt.call_function('apply_filters', [rt.new_string('wc_session_expiring'), var_default_expiring_seconds.dup()]).to_i64()) } else { var_default_expiring_seconds }
	if rt.is_true(rt.greater(var_expiring_seconds, var_max_expiring_seconds)) {
		var_session_limit_exceeded = rt.new_bool(rt.new_bool(true))
	}
	mut var_expiration_seconds := if rt.is_true(rt.new_int(rt.call_function('apply_filters', [rt.new_string('wc_session_expiration'), var_default_expiration_seconds.dup()]).to_i64())) { rt.new_int(rt.call_function('apply_filters', [rt.new_string('wc_session_expiration'), var_default_expiration_seconds.dup()]).to_i64()) } else { var_default_expiration_seconds }
	if rt.is_true(rt.greater(var_expiration_seconds, var_max_expiration_seconds)) {
		var_session_limit_exceeded = rt.new_bool(rt.new_bool(true))
	}
	if rt.is_true(var_session_limit_exceeded) {
		mut var_transient_key := rt.new_string(rt.new_string('wc_session_handler_warning'))
		if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('get_transient', [var_transient_key.dup()]))) {
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [rt.call_function('sprintf', [rt.new_string('Keeping sessions for longer than %d days can cause performance issues and larger session tables. Monitor usage and adjust lifetimes via the wc_session_expiring and wc_session_expiration filters as needed.'), rt.div(var_max_expiration_seconds, rt.get_constant('DAY_IN_SECONDS'))]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc_session_handler' }])])
			rt.call_function('set_transient', [var_transient_key.dup(), rt.new_bool(true), var_max_expiration_seconds.dup()])
		}
	}
	if rt.is_true(rt.greater(var_expiring_seconds, var_expiration_seconds)) {
		var_expiring_seconds = rt.new_float(var_expiration_seconds * 0.9)
	}
	this._session_expiring = rt.add(rt.call_function('time', []rt.PhpVal{}), var_expiring_seconds)
	this._session_expiration = rt.add(rt.call_function('time', []rt.PhpVal{}), var_expiration_seconds)
}

fn (mut this Class_WC_Session_Handler) generate_customer_id() rt.PhpVal {
	return if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) { // unsupported expression: Expr_Cast_String } else { rt.call_function('wc_rand_hash', [rt.new_string('t_'), rt.new_int(30)]) }
}

fn (mut this Class_WC_Session_Handler) is_customer_guest(var_customer_id rt.PhpVal) bool {
	mut var_customer_id_mutated := var_customer_id
	return !rt.is_true(var_customer_id_mutated) || rt.is_true(rt.identical(rt.new_string('t_'), rt.call_function('substr', [var_customer_id_mutated.dup(), rt.new_int(0), rt.new_int(2)])))
}

fn (mut this Class_WC_Session_Handler) get_customer_unique_id() rt.PhpVal {
	mut var_customer_id := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(this.has_session() && rt.is_true(this.get_customer_id()))) {
		var_customer_id = this.get_customer_id()
	} else if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
		var_customer_id = 
	}
	return var_customer_id.dup()
}

fn (mut this Class_WC_Session_Handler) get_session_cookie() rt.PhpVal {
	mut var_customer_id := rt.new_null()
	mut var_session_expiration := rt.new_null()
	mut var_session_expiring := rt.new_null()
	mut var_cookie_hash := rt.new_null()
	
}

fn (mut this Class_WC_Session_Handler) get_session_data() rt.PhpVal {
}

fn (mut this Class_WC_Session_Handler) get_cache_prefix() rt.PhpVal {
}

fn (mut this Class_WC_Session_Handler) save_data(old_session_key string)  {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_Session_Handler) destroy_session()  {
}

fn (mut this Class_WC_Session_Handler) forget_session()  {
}

fn (mut this Class_WC_Session_Handler) maybe_update_nonce_user_logged_out(var_uid rt.PhpVal, var_action rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Session_Handler) cleanup_sessions()  {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_Session_Handler) get_session(var_customer_id rt.PhpVal, default_value bool) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_customer_id_mutated := var_customer_id
}

fn (mut this Class_WC_Session_Handler) delete_session(var_customer_id rt.PhpVal)  {
	mut var_GLOBALS := rt.new_null()
	mut var_customer_id_mutated := var_customer_id
}

fn (mut this Class_WC_Session_Handler) update_session_timestamp(var_customer_id rt.PhpVal, var_timestamp rt.PhpVal)  {
	mut var_GLOBALS := rt.new_null()
	mut var_customer_id_mutated := var_customer_id
}

fn (mut this Class_WC_Session_Handler) destroy_session_if_empty()  {
}

fn (mut this Class_WC_Session_Handler) session_exists(var_customer_id rt.PhpVal) bool {
	mut var_GLOBALS := rt.new_null()
	mut var_customer_id_mutated := var_customer_id
}

struct Class_WC_Session {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils {
	rt.PhpObjectBase
}

fn create_wc_session_handler() &Class_WC_Session_Handler {
	mut obj := &Class_WC_Session_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
		_cookie: rt.new_string('')
		_session_expiring: rt.new_int(0)
		_session_expiration: rt.new_int(0)
		_has_cookie: false
		_table: rt.new_string('')
	}
	obj.construct()
	return obj
}

fn create_wc_session() &Class_WC_Session {
	mut obj := &Class_WC_Session{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_carttokenutils() &Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils{
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
			return this.use_secure_cookie()
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
		else { return none }
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
		'_cookie' { this._cookie = val; return true }
		'_session_expiring' { this._session_expiring = val; return true }
		'_session_expiration' { this._session_expiration = val; return true }
		'_has_cookie' { this._has_cookie = (val).to_bool(); return true }
		'_table' { this._table = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_session_handler_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
