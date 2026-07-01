import rt

struct Class_Automattic_WooCommerce_StoreApi_SessionHandler {
	rt.PhpObjectBase
pub mut:
		token rt.PhpVal = rt.new_string('')
		table rt.PhpVal = rt.new_string('')
		session_expiration rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_SessionHandler) construct()  {
	mut var_GLOBALS := rt.new_null()
	this.token = rt.call_function('wc_clean', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_SERVER').array_get('HTTP_CART_TOKEN')).is_null() { rt.get_superglobal('_SERVER').array_get('HTTP_CART_TOKEN') } else { rt.new_string('') }])])
	this.table = (rt.get_property(var_GLOBALS.array_get('wpdb'), 'prefix')).str() + 'woocommerce_sessions'
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_SessionHandler) init()  {
	this.init_session_from_token()
	rt.call_function('add_action', [rt.new_string('shutdown'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_SessionHandler', ['WC_Session'], &this) }, rt.ArrayItem{ key: none, val: 'save_data' }]), rt.new_int(20)])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_SessionHandler) init_session_from_token()  {
	mut var_payload := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils{}; return temp.get_cart_token_payload(arg_0) }(this.token)
	this.dispatch_set_prop('_customer_id', var_payload.array_get('user_id'))
	this.session_expiration = var_payload.array_get('exp')
	this.dispatch_set_prop('_data', rt.cast_array(this.get_session(this.get_customer_id(), (rt.new_array()).to_bool())))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_SessionHandler) has_session() bool {
	return !(!rt.is_true(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_SessionHandler', ['WC_Session'], &this), '_customer_id')))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_SessionHandler) generate_customer_id() rt.PhpVal {
	return if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) { // unsupported expression: Expr_Cast_String } else { rt.call_function('wc_rand_hash', [rt.new_string('t_'), rt.new_int(30)]) }
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_SessionHandler) get_customer_unique_id() rt.PhpVal {
	if rt.is_true(rt.new_bool(this.has_session() && rt.is_true(this.get_customer_id()))) {
		return this.get_customer_id()
	}
	return if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) { // unsupported expression: Expr_Cast_String } else { rt.new_string('') }
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_SessionHandler) get_session_data() rt.PhpVal {
	return if this.has_session() { rt.cast_array(this.get_session(this.get_customer_id(), (rt.new_array()).to_bool())) } else { rt.new_array() }
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_SessionHandler) get_session(var_customer_id rt.PhpVal, default_value bool) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_defined(arg_0) }(rt.new_string('WP_SETUP_CONFIG'))) {
		return rt.new_bool(default_value)
	}
	mut var_value := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.new_string('SELECT session_value FROM %i WHERE session_key = %s'), this.table, var_customer_id.dup()])])
	if rt.is_true(rt.new_bool(var_value.dup().is_null())) {
		var_value = rt.new_bool(rt.new_bool(default_value))
	}
	return rt.call_function('maybe_unserialize', [var_value.dup()])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_SessionHandler) destroy_session()  {
	this.delete_session(this.get_customer_id())
	this.forget_session()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_SessionHandler) forget_session()  {
	this.dispatch_set_prop('_data', rt.new_array())
	this.dispatch_set_prop('_dirty', rt.new_bool(false))
	this.dispatch_set_prop('_customer_id', rt.new_null())
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_SessionHandler) delete_session(var_customer_id rt.PhpVal)  {
	mut var_GLOBALS := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_customer_id)))) {
		return rt.new_null()
	}
	rt.call_method(var_GLOBALS.array_get('wpdb'), 'delete', [this.table, rt.create_array([rt.ArrayItem{ key: 'session_key', val: var_customer_id }])])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_SessionHandler) save_data()  {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_SessionHandler', ['WC_Session'], &this), '_dirty')) {
		// unsupported statement: Stmt_Global
		rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.new_string('INSERT INTO %i (`session_key`, `session_value`, `session_expiry`) VALUES (%s, %s, %d) ON DUPLICATE KEY UPDATE `session_value` = VALUES(`session_value`), `session_expiry` = VALUES(`session_expiry`)'), this.table, this.get_customer_id(), rt.call_function('maybe_serialize', [rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_SessionHandler', ['WC_Session'], &this), '_data')]), this.session_expiration])])
		this.dispatch_set_prop('_dirty', rt.new_bool(false))
	}
}

struct Class_WC_Session {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_sessionhandler() &Class_Automattic_WooCommerce_StoreApi_SessionHandler {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_SessionHandler{
		PhpObjectBase: rt.PhpObjectBase{}
		token: rt.new_string('')
		table: rt.new_string('')
		session_expiration: rt.new_int(0)
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

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_SessionHandler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'init_session_from_token' {
			this.init_session_from_token()
			return rt.new_null()
		}
		'has_session' {
			return rt.new_bool(this.has_session())
		}
		'generate_customer_id' {
			return this.generate_customer_id()
		}
		'get_customer_unique_id' {
			return this.get_customer_unique_id()
		}
		'get_session_data' {
			return this.get_session_data()
		}
		'get_session' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_session(dispatch_arg_0, dispatch_arg_1)
		}
		'destroy_session' {
			this.destroy_session()
			return rt.new_null()
		}
		'forget_session' {
			this.forget_session()
			return rt.new_null()
		}
		'delete_session' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.delete_session(dispatch_arg_0)
			return rt.new_null()
		}
		'save_data' {
			this.save_data()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_SessionHandler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'token' { return this.token }
		'table' { return this.table }
		'session_expiration' { return this.session_expiration }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_SessionHandler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'token' { this.token = val; return true }
		'table' { this.table = val; return true }
		'session_expiration' { this.session_expiration = val; return true }
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


fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_storeapi_sessionhandler_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
