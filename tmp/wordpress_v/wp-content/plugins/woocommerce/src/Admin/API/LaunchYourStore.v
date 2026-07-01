import rt

struct Class_Automattic_WooCommerce_Admin_API_LaunchYourStore {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc-admin')
		rest_base rt.PhpVal = rt.new_string('launch-your-store')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_LaunchYourStore) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/initialize-coming-soon', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: 'POST' }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_LaunchYourStore', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'initialize_coming_soon' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_LaunchYourStore', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'must_be_shop_manager_or_admin' }]) }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/update-survey-status', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: 'POST' }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_LaunchYourStore', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'update_survey_status' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_LaunchYourStore', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'must_be_shop_manager_or_admin' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'status', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'yes' }, rt.ArrayItem{ key: none, val: 'no' }]) }]) }]) }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/survey-completed', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: 'GET' }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_LaunchYourStore', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'has_survey_completed' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_LaunchYourStore', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'must_be_shop_manager_or_admin' }]) }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/woopayments/test-orders/count', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: 'GET' }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_LaunchYourStore', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_woopay_test_orders_count' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_LaunchYourStore', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'must_be_shop_manager_or_admin' }]) }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/woopayments/test-orders', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: 'DELETE' }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_LaunchYourStore', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'delete_woopay_test_orders' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_LaunchYourStore', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'must_be_shop_manager_or_admin' }]) }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_LaunchYourStore) must_be_shop_manager_or_admin() bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('administrator')]))))))) {
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_LaunchYourStore) initialize_coming_soon() bool {
	mut var_current_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_current_user_id)))) {
		return false
	}
	mut var_coming_soon := rt.new_string(rt.new_string('yes'))
	mut var_store_pages_only := rt.new_string(if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_WCAdminHelper{}; return temp.is_site_fresh() }()) { rt.new_string('no') } else { rt.new_string('yes') })
	mut var_private_link := rt.new_string(rt.new_string('no'))
	mut var_share_key := rt.call_function('wp_generate_password', [rt.new_int(32), rt.new_bool(false)])
	rt.call_function('update_option', [rt.new_string('woocommerce_coming_soon'), var_coming_soon.dup()])
	rt.call_function('update_option', [rt.new_string('woocommerce_store_pages_only'), var_store_pages_only.dup()])
	rt.call_function('add_option', [rt.new_string('woocommerce_private_link'), var_private_link.dup()])
	rt.call_function('add_option', [rt.new_string('woocommerce_share_key'), var_share_key.dup()])
	rt.call_function('wc_admin_record_tracks_event', [rt.new_string('launch_your_store_initialize_coming_soon'), rt.create_array([rt.ArrayItem{ key: 'coming_soon', val: var_coming_soon }, rt.ArrayItem{ key: 'store_pages_only', val: var_store_pages_only }, rt.ArrayItem{ key: 'private_link', val: var_private_link }])])
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_LaunchYourStore) get_woopay_test_orders_count() rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_count := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return create_automattic_woocommerce_admin_api_wp_rest_response(rt.create_array([rt.ArrayItem{ key: 'count', val: var_count }]))
	}
	mut var_return := rt.new_closure(closure_1_fn)
	mut var_orders := rt.call_function('wc_get_orders', [rt.create_array([rt.ArrayItem{ key: 'meta_key', val: '_wcpay_mode' }, rt.ArrayItem{ key: 'meta_value', val: 'test' }, rt.ArrayItem{ key: 'return', val: 'ids' }])])
	return rt.call_callable(var_return, [rt.new_int(var_orders.dup().array_count())])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_LaunchYourStore) delete_woopay_test_orders() rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_status := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return create_automattic_woocommerce_admin_api_wp_rest_response(rt.new_null(), var_status.dup())
	}
	mut var_return := rt.new_closure(closure_2_fn)
	mut var_orders := rt.call_function('wc_get_orders', [rt.create_array([rt.ArrayItem{ key: 'meta_key', val: '_wcpay_mode' }, rt.ArrayItem{ key: 'meta_value', val: 'test' }])])
	{
		mut iter_1 := var_orders.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_order := item_1.val
			rt.call_method(var_order, 'delete', []rt.PhpVal{})
		}
	}
	return rt.call_callable(var_return, []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_LaunchYourStore) update_survey_status(mut var_request Class_Automattic_WooCommerce_Admin_API_WP_REST_Request) rt.PhpVal {
	rt.call_function('update_option', [rt.new_string('woocommerce_admin_launch_your_store_survey_completed'), var_request.get_param(rt.new_string('status'))])
	return create_automattic_woocommerce_admin_api_wp_rest_response()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_LaunchYourStore) has_survey_completed() rt.PhpVal {
	return create_automattic_woocommerce_admin_api_wp_rest_response(rt.call_function('get_option', [rt.new_string('woocommerce_admin_launch_your_store_survey_completed'), rt.new_string('no')]))
}

struct Class_Automattic_WooCommerce_Admin_WCAdminHelper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_WP_REST_Response {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_launchyourstore() &Class_Automattic_WooCommerce_Admin_API_LaunchYourStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_LaunchYourStore{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc-admin')
		rest_base: rt.new_string('launch-your-store')
	}
	return obj
}

fn create_automattic_woocommerce_admin_wcadminhelper() &Class_Automattic_WooCommerce_Admin_WCAdminHelper {
	mut obj := &Class_Automattic_WooCommerce_Admin_WCAdminHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wp_rest_response() &Class_Automattic_WooCommerce_Admin_API_WP_REST_Response {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WP_REST_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_LaunchYourStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'must_be_shop_manager_or_admin' {
			return rt.new_bool(this.must_be_shop_manager_or_admin())
		}
		'initialize_coming_soon' {
			return rt.new_bool(this.initialize_coming_soon())
		}
		'get_woopay_test_orders_count' {
			return this.get_woopay_test_orders_count()
		}
		'delete_woopay_test_orders' {
			return this.delete_woopay_test_orders()
		}
		'update_survey_status' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_API_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.update_survey_status(mut dispatch_arg_0)
		}
		'has_survey_completed' {
			return this.has_survey_completed()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_LaunchYourStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_LaunchYourStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_WCAdminHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_WCAdminHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_WCAdminHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_admin_api_launchyourstore_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
