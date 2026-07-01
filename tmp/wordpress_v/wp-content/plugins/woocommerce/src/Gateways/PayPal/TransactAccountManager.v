import rt

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager.wpcom_proxy_endpoint_api_version() i64 {
	return 2
}
pub fn Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager.transact_provider_type() string {
	return 'paypal_standard'
}
pub fn Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager.transact_merchant_account_cache_key_live() string {
	return 'woocommerce_paypal_transact_merchant_account_live'
}
pub fn Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager.transact_merchant_account_cache_key_test() string {
	return 'woocommerce_paypal_transact_merchant_account_test'
}
pub fn Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager.transact_provider_account_cache_key_live() string {
	return 'woocommerce_paypal_transact_provider_account_live'
}
pub fn Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager.transact_provider_account_cache_key_test() string {
	return 'woocommerce_paypal_transact_provider_account_test'
}
pub fn Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager.transact_account_cache_expiry() i64 {
	return 60 * 60 * 24
}
struct Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager {
	rt.PhpObjectBase
pub mut:
		gateway rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager) construct(mut var_gateway Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal)  {
	this.gateway = var_gateway.dup()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager) do_onboarding()  {
	if !rt.is_true(rt.get_property(this.gateway, 'email')) {
		return rt.new_null()
	}
	mut var_jetpack_connection_manager := rt.call_method(this.gateway, 'get_jetpack_connection_manager', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_jetpack_connection_manager)))) {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}; return temp.log(arg_0, arg_1) }(rt.new_string('Jetpack connection manager not found.'), rt.new_string('error'))
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_jetpack_connection_manager, 'is_connected', []rt.PhpVal{}))))) {
		mut var_result := rt.call_method(var_jetpack_connection_manager, 'try_registration', []rt.PhpVal{})
		if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}; return temp.log(arg_0, arg_1) }(rt.new_string('Jetpack registration failed: ' + (rt.call_method(var_result, 'get_error_message', []rt.PhpVal{})).str()), rt.new_string('error'))
			return rt.new_null()
		}
	}
	mut var_merchant_account_data := this.get_transact_account_data('merchant')
	if !rt.is_true(var_merchant_account_data) {
		mut var_merchant_account := this.create_merchant_account()
		if !rt.is_true(var_merchant_account) {
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}; return temp.log(arg_0, arg_1) }(rt.new_string('Transact merchant onboarding failed.'), rt.new_string('error'))
			return rt.new_null()
		}
		this.update_transact_account_cache(this.get_cache_key('merchant'), var_merchant_account.dup())
	}
	mut var_provider_account_data := this.get_transact_account_data('provider')
	if !rt.is_true(var_provider_account_data) {
		mut var_provider_account := rt.new_bool(this.create_provider_account())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_provider_account)))) {
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}; return temp.log(arg_0, arg_1) }(rt.new_string('Transact provider onboarding failed.'), rt.new_string('error'))
			return rt.new_null()
		}
		this.update_transact_account_cache(this.get_cache_key('provider'), var_provider_account.dup())
	}
	rt.call_method(this.gateway, 'set_transact_onboarding_complete', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager) get_transact_account_data(account_type string) rt.PhpVal {
	mut var_cache_key := rt.new_string(this.get_cache_key(account_type))
	mut var_transact_account := this.get_transact_account_from_cache((var_cache_key).str())
	if !rt.is_true(var_transact_account) {
		var_transact_account = if rt.is_true(rt.identical(rt.new_string('merchant'), rt.new_string(account_type))) { this.fetch_merchant_account() } else { this.fetch_provider_account() }
		if !rt.is_true(var_transact_account) {
			return rt.new_null()
		}
		this.update_transact_account_cache((var_cache_key).str(), var_transact_account.dup())
	}
	return var_transact_account.dup()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager) get_cache_key(account_type string) string {
	if rt.is_true(rt.identical(rt.new_string('merchant'), rt.new_string(account_type))) {
		return (if rt.is_true(rt.get_property(this.gateway, 'testmode')) { Class_Automattic_WooCommerce_Gateways_PayPal_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager.transact_merchant_account_cache_key_test() } else { Class_Automattic_WooCommerce_Gateways_PayPal_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager.transact_merchant_account_cache_key_live() }).str()
	}
	if rt.is_true(rt.identical(rt.new_string('provider'), rt.new_string(account_type))) {
		return (if rt.is_true(rt.get_property(this.gateway, 'testmode')) { Class_Automattic_WooCommerce_Gateways_PayPal_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager.transact_provider_account_cache_key_test() } else { Class_Automattic_WooCommerce_Gateways_PayPal_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager.transact_provider_account_cache_key_live() }).str()
	}
	return (rt.new_null()).str()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager) fetch_merchant_account() rt.PhpVal {
	mut var_site_id := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_Jetpack_Options{}; return temp.get_option(arg_0) }(rt.new_string('id'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_site_id)))) {
		return rt.new_null()
	}
	mut var_request_body := rt.create_array([rt.ArrayItem{ key: 'test_mode', val: rt.get_property(this.gateway, 'testmode') }])
	mut var_response := this.send_transact_api_request('GET', (rt.call_function('sprintf', [rt.new_string('/sites/%d/transact/account'), var_site_id.dup()])).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](var_request_body))
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	mut var_response_data := rt.call_function('json_decode', [rt.call_function('wp_remote_retrieve_body', [var_response.dup()]), rt.new_bool(true)])
	if !rt.is_true(var_response_data.array_get('public_id')) {
		return rt.new_null()
	}
	return rt.create_array([rt.ArrayItem{ key: 'public_id', val: var_response_data.array_get('public_id') }])
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager) fetch_provider_account() bool {
	mut var_site_id := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_Jetpack_Options{}; return temp.get_option(arg_0) }(rt.new_string('id'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_site_id)))) {
		return false
	}
	mut var_request_body := rt.create_array([rt.ArrayItem{ key: 'test_mode', val: rt.get_property(this.gateway, 'testmode') }, rt.ArrayItem{ key: 'provider_type', val: Class_Automattic_WooCommerce_Gateways_PayPal_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager.transact_provider_type() }])
	mut var_response := this.send_transact_api_request('GET', (rt.call_function('sprintf', [rt.new_string('/sites/%d/transact/account/%s'), var_site_id.dup(), Class_Automattic_WooCommerce_Gateways_PayPal_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager.transact_provider_type()])).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](var_request_body))
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager) create_merchant_account() rt.PhpVal {
	mut var_site_id := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_Jetpack_Options{}; return temp.get_option(arg_0) }(rt.new_string('id'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_site_id)))) {
		return rt.new_null()
	}
	mut var_request_body := rt.create_array([rt.ArrayItem{ key: 'test_mode', val: rt.get_property(this.gateway, 'testmode') }])
	mut var_response := this.send_transact_api_request('POST', (rt.call_function('sprintf', [rt.new_string('/sites/%d/transact/account'), var_site_id.dup()])).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](var_request_body))
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	mut var_response_data := rt.call_function('json_decode', [rt.call_function('wp_remote_retrieve_body', [var_response.dup()]), rt.new_bool(true)])
	if !rt.is_true(var_response_data.array_get('public_id')) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}; return temp.log(arg_0) }(rt.new_string('Transact merchant account creation failed. Response body: ' + (rt.call_function('wc_print_r', [var_response_data.dup(), rt.new_bool(true)])).str()))
		return rt.new_null()
	}
	return rt.create_array([rt.ArrayItem{ key: 'public_id', val: var_response_data.array_get('public_id') }])
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager) create_provider_account() bool {
	mut var_site_id := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_Jetpack_Options{}; return temp.get_option(arg_0) }(rt.new_string('id'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_site_id)))) {
		return false
	}
	mut var_request_body := rt.create_array([rt.ArrayItem{ key: 'test_mode', val: rt.get_property(this.gateway, 'testmode') }, rt.ArrayItem{ key: 'provider_type', val: Class_Automattic_WooCommerce_Gateways_PayPal_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager.transact_provider_type() }])
	mut var_response := this.send_transact_api_request('POST', (rt.call_function('sprintf', [rt.new_string('/sites/%d/transact/account/%s/onboard'), var_site_id.dup(), Class_Automattic_WooCommerce_Gateways_PayPal_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager.transact_provider_type()])).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](var_request_body))
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager) update_transact_account_cache(cache_key string, var_account_data rt.PhpVal)  {
	mut cache_key_mutated := cache_key
	mut var_expires := rt.add(rt.call_function('time', []rt.PhpVal{}), Class_Automattic_WooCommerce_Gateways_PayPal_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager.transact_account_cache_expiry())
	rt.call_function('update_option', [rt.new_string(cache_key_mutated).dup(), rt.create_array([rt.ArrayItem{ key: 'account', val: var_account_data }, rt.ArrayItem{ key: 'expiry', val: var_expires }])])
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager) get_transact_account_from_cache(cache_key string) rt.PhpVal {
	mut cache_key_mutated := cache_key
	mut var_transact_account := rt.call_function('get_option', [rt.new_string(cache_key_mutated).dup(), rt.new_null()])
	if rt.is_true(rt.new_bool(!rt.is_true(var_transact_account) || rt.is_true(rt.new_bool(var_transact_account.array_isset(rt.new_string('expiry')) && rt.is_true(rt.less(var_transact_account.array_get('expiry'), rt.call_function('time', []rt.PhpVal{}))))))) {
		return rt.new_null()
	}
	return if !(var_transact_account.array_get('account')).is_null() { var_transact_account.array_get('account') } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager) send_transact_api_request(method string, endpoint string, mut var_request_body Class_Automattic_WooCommerce_Gateways_PayPal_array) rt.PhpVal {
	mut var_request_body_mutated := var_request_body
	if rt.is_true(rt.identical(rt.new_string('GET'), rt.new_string(method))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_response := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Connection_Client{}; return temp.wpcom_json_api_request_as_blog(arg_0, arg_1, arg_2, arg_3, arg_4) }(rt.new_string(endpoint), // unsupported expression: Expr_Cast_String, rt.create_array([rt.ArrayItem{ key: 'headers', val: rt.create_array([rt.ArrayItem{ key: 'Content-Type', val: 'application/json' }]) }, rt.ArrayItem{ key: 'method', val: method }, rt.ArrayItem{ key: 'timeout', val: Class_Automattic_WooCommerce_Gateways_PayPal_Constants.wpcom_proxy_request_timeout() }]), if rt.is_true(rt.identical(rt.new_string('GET'), rt.new_string(method))) { rt.new_null() } else { rt.call_function('wp_json_encode', [var_request_body_mutated.dup()]) }, rt.new_string('wpcom'))
	return var_response.dup()
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_Jetpack_Options {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Connection_Client {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_gateways_paypal_transactaccountmanager(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager{
		PhpObjectBase: rt.PhpObjectBase{}
		gateway: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_gateways_paypal_wc_gateway_paypal() &Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_gateways_paypal_jetpack_options() &Class_Automattic_WooCommerce_Gateways_PayPal_Jetpack_Options {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_Jetpack_Options{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_connection_client() &Class_Automattic_Jetpack_Connection_Client {
	mut obj := &Class_Automattic_Jetpack_Connection_Client{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'do_onboarding' {
			this.do_onboarding()
			return rt.new_null()
		}
		'get_transact_account_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_transact_account_data(dispatch_arg_0)
		}
		'get_cache_key' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_cache_key(dispatch_arg_0))
		}
		'fetch_merchant_account' {
			return this.fetch_merchant_account()
		}
		'fetch_provider_account' {
			return rt.new_bool(this.fetch_provider_account())
		}
		'create_merchant_account' {
			return this.create_merchant_account()
		}
		'create_provider_account' {
			return rt.new_bool(this.create_provider_account())
		}
		'update_transact_account_cache' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.update_transact_account_cache(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_transact_account_from_cache' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_transact_account_from_cache(dispatch_arg_0)
		}
		'send_transact_api_request' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.send_transact_api_request(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'gateway' { return this.gateway }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'gateway' { this.gateway = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Jetpack_Options) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Gateways_PayPal_Jetpack_Options) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Jetpack_Options) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_Jetpack_Connection_Client) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Connection_Client) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Connection_Client) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_gateways_paypal_transactaccountmanager_php() {
	// unsupported statement: Stmt_Declare
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
