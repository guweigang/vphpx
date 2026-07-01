import rt

struct Class_Automattic_WooCommerce_Admin_API_AnalyticsImports {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc-analytics')
		rest_base rt.PhpVal = rt.new_string('imports')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_AnalyticsImports) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/status', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_AnalyticsImports', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_status' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_AnalyticsImports', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_AnalyticsImports', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_status_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/trigger', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_AnalyticsImports', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'trigger_import' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_AnalyticsImports', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_AnalyticsImports', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_trigger_schema' }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_AnalyticsImports) permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_access'), rt.call_function('__', [rt.new_string('Sorry, you cannot access analytics imports.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_AnalyticsImports) get_status(var_request rt.PhpVal) rt.PhpVal {
	mut var_is_scheduled_mode := this.is_scheduled_import_enabled()
	mut var_mode := rt.new_string(if rt.is_true(var_is_scheduled_mode) { rt.new_string('scheduled') } else { rt.new_string('immediate') })
	mut var_response := rt.create_array([rt.ArrayItem{ key: 'mode', val: var_mode }, rt.ArrayItem{ key: 'last_processed_date', val: rt.new_null() }, rt.ArrayItem{ key: 'next_scheduled', val: rt.new_null() }, rt.ArrayItem{ key: 'import_in_progress_or_due', val: rt.new_null() }])
	if rt.is_true(var_is_scheduled_mode) {
		mut var_last_processed_gmt := rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.last_processed_order_date_option(), rt.new_null()])
		var_response.array_set('last_processed_date', if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_last_processed_gmt.dup().is_string())) && rt.is_true(var_last_processed_gmt))) { rt.call_function('get_date_from_gmt', [var_last_processed_gmt.dup(), rt.new_string('Y-m-d H:i:s')]) } else { rt.new_null() })
		var_response.array_set('next_scheduled', this.get_next_scheduled_time())
		var_response.array_set('import_in_progress_or_due', this.is_import_in_progress_or_due())
	}
	return rt.call_function('rest_ensure_response', [var_response.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_AnalyticsImports) trigger_import(var_request rt.PhpVal) rt.PhpVal {
	mut var_is_scheduled_mode := this.is_scheduled_import_enabled()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_scheduled_mode)))) {
		return create_wp_error(rt.new_string('woocommerce_rest_analytics_import_immediate_mode'), rt.call_function('__', [rt.new_string('Manual import is not available in immediate mode. Imports happen automatically.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	if this.is_import_in_progress_or_due() {
		return create_wp_error(rt.new_string('woocommerce_rest_analytics_import_in_progress'), rt.call_function('__', [rt.new_string('A batch import is already in progress or scheduled to run soon. Please wait for it to complete before triggering a new import.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_action_hook := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler{}; return temp.get_action(arg_0) }(Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.process_pending_orders_batch_action())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_action_hook.dup().is_string()))))) {
		return create_wp_error(rt.new_string('woocommerce_rest_analytics_import_invalid_action'), rt.call_function('__', [rt.new_string('Invalid action hook for batch import.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
	}
	rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue', []rt.PhpVal{}), 'cancel_all', [var_action_hook.dup(), rt.new_array(), // unsupported expression: Expr_Cast_String])
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler{}; return temp.schedule_recurring_batch_processor() }()
	return rt.call_function('rest_ensure_response', [rt.create_array([rt.ArrayItem{ key: 'success', val: true }, rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('Batch import triggered successfully.'), rt.new_string('woocommerce')]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_AnalyticsImports) is_scheduled_import_enabled() rt.PhpVal {
	return rt.identical(rt.new_string('yes'), rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.scheduled_import_option(), Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.scheduled_import_option_default_value()]))
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_AnalyticsImports) get_next_scheduled_time() rt.PhpVal {
	mut var_action_hook := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler{}; return temp.get_action(arg_0) }(Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.process_pending_orders_batch_action())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_action_hook.dup().is_string()))))) {
		return rt.new_null()
	}
	mut var_next_time := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue', []rt.PhpVal{}), 'get_next', [var_action_hook.dup(), rt.new_array(), // unsupported expression: Expr_Cast_String])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_next_time)))) {
		return rt.new_null()
	}
	return rt.call_function('get_date_from_gmt', [rt.call_method(var_next_time, 'format', [rt.new_string('Y-m-d H:i:s')]), rt.new_string('Y-m-d H:i:s')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_AnalyticsImports) get_status_schema() rt.PhpVal {
	mut var_schema := rt.create_array([rt.ArrayItem{ key: '$schema', val: 'https://json-schema.org/draft-04/schema#' }, rt.ArrayItem{ key: 'title', val: 'analytics_import_status' }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'mode', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'scheduled' }, rt.ArrayItem{ key: none, val: 'immediate' }]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Current import mode.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'last_processed_date', val: rt.create_array([rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Last processed order date (null in immediate mode).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'next_scheduled', val: rt.create_array([rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Next scheduled import time (null in immediate mode).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'import_in_progress_or_due', val: rt.create_array([rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'boolean' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether a batch import is currently running or scheduled to run within the next minute (null in immediate mode).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }])
	return this.add_additional_fields_schema(var_schema.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_AnalyticsImports) get_trigger_schema() rt.PhpVal {
	mut var_schema := rt.create_array([rt.ArrayItem{ key: '$schema', val: 'https://json-schema.org/draft-04/schema#' }, rt.ArrayItem{ key: 'title', val: 'analytics_import_trigger' }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'success', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether the trigger was successful.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'message', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Result message.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }])
	return this.add_additional_fields_schema(var_schema.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_AnalyticsImports) is_import_in_progress_or_due() bool {
	mut var_hook := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler{}; return temp.get_action(arg_0) }(Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.process_pending_orders_batch_action())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_hook.dup().is_string()))))) {
		return false
	}
	mut var_in_progress_actions := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue', []rt.PhpVal{}), 'search', [rt.create_array([rt.ArrayItem{ key: 'hook', val: var_hook }, rt.ArrayItem{ key: 'status', val: 'in-progress' }, rt.ArrayItem{ key: 'per_page', val: 1 }]), rt.new_string('ids')])
	if !(!rt.is_true(var_in_progress_actions)) {
		return true
	}
	mut var_next_scheduled := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue', []rt.PhpVal{}), 'get_next', [var_hook.dup(), rt.new_array(), // unsupported expression: Expr_Cast_String])
	if rt.is_true(var_next_scheduled) {
		mut var_time_until_next := rt.sub(rt.call_method(var_next_scheduled, 'getTimestamp', []rt.PhpVal{}), rt.call_function('time', []rt.PhpVal{}))
		if rt.is_true(rt.less_equal(var_time_until_next, rt.get_constant('MINUTE_IN_SECONDS'))) {
			return true
		}
	}
	return false
}

struct Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_analyticsimports() &Class_Automattic_WooCommerce_Admin_API_AnalyticsImports {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_AnalyticsImports{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc-analytics')
		rest_base: rt.new_string('imports')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_rest_data_controller() &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller{
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

fn create_automattic_woocommerce_internal_admin_schedulers_ordersscheduler() &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_AnalyticsImports) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.permissions_check(dispatch_arg_0))
		}
		'get_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_status(dispatch_arg_0)
		}
		'trigger_import' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.trigger_import(dispatch_arg_0)
		}
		'is_scheduled_import_enabled' {
			return this.is_scheduled_import_enabled()
		}
		'get_next_scheduled_time' {
			return this.get_next_scheduled_time()
		}
		'get_status_schema' {
			return this.get_status_schema()
		}
		'get_trigger_schema' {
			return this.get_trigger_schema()
		}
		'is_import_in_progress_or_due' {
			return rt.new_bool(this.is_import_in_progress_or_due())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_AnalyticsImports) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_AnalyticsImports) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_analyticsimports_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
