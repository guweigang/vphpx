import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Import_Controller {
	rt.PhpObjectBase
pub mut:
		rest_base rt.PhpVal = rt.new_string('reports/import')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Import_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Import_Controller', ['Automattic_WooCommerce_Admin_API_Reports_Import_Automattic_WooCommerce_Admin_API_Reports_Controller'], &this), 'namespace'), '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_Reports_Import_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Import_Controller', ['Automattic_WooCommerce_Admin_API_Reports_Import_Automattic_WooCommerce_Admin_API_Reports_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'import_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Import_Controller', ['Automattic_WooCommerce_Admin_API_Reports_Import_Automattic_WooCommerce_Admin_API_Reports_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'import_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_import_collection_params() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Import_Controller', ['Automattic_WooCommerce_Admin_API_Reports_Import_Automattic_WooCommerce_Admin_API_Reports_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_import_public_schema' }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Import_Controller', ['Automattic_WooCommerce_Admin_API_Reports_Import_Automattic_WooCommerce_Admin_API_Reports_Controller'], &this), 'namespace'), '/' + (this.rest_base).str() + '/cancel', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_Reports_Import_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Import_Controller', ['Automattic_WooCommerce_Admin_API_Reports_Import_Automattic_WooCommerce_Admin_API_Reports_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'cancel_import' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Import_Controller', ['Automattic_WooCommerce_Admin_API_Reports_Import_Automattic_WooCommerce_Admin_API_Reports_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'import_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Import_Controller', ['Automattic_WooCommerce_Admin_API_Reports_Import_Automattic_WooCommerce_Admin_API_Reports_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_import_public_schema' }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Import_Controller', ['Automattic_WooCommerce_Admin_API_Reports_Import_Automattic_WooCommerce_Admin_API_Reports_Controller'], &this), 'namespace'), '/' + (this.rest_base).str() + '/delete', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_Reports_Import_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Import_Controller', ['Automattic_WooCommerce_Admin_API_Reports_Import_Automattic_WooCommerce_Admin_API_Reports_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_imported_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Import_Controller', ['Automattic_WooCommerce_Admin_API_Reports_Import_Automattic_WooCommerce_Admin_API_Reports_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'import_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Import_Controller', ['Automattic_WooCommerce_Admin_API_Reports_Import_Automattic_WooCommerce_Admin_API_Reports_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_import_public_schema' }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Import_Controller', ['Automattic_WooCommerce_Admin_API_Reports_Import_Automattic_WooCommerce_Admin_API_Reports_Controller'], &this), 'namespace'), '/' + (this.rest_base).str() + '/status', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_Reports_Import_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Import_Controller', ['Automattic_WooCommerce_Admin_API_Reports_Import_Automattic_WooCommerce_Admin_API_Reports_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_import_status' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Import_Controller', ['Automattic_WooCommerce_Admin_API_Reports_Import_Automattic_WooCommerce_Admin_API_Reports_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'import_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Import_Controller', ['Automattic_WooCommerce_Admin_API_Reports_Import_Automattic_WooCommerce_Admin_API_Reports_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_import_public_schema' }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Import_Controller', ['Automattic_WooCommerce_Admin_API_Reports_Import_Automattic_WooCommerce_Admin_API_Reports_Controller'], &this), 'namespace'), '/' + (this.rest_base).str() + '/totals', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_Reports_Import_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Import_Controller', ['Automattic_WooCommerce_Admin_API_Reports_Import_Automattic_WooCommerce_Admin_API_Reports_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_import_totals' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Import_Controller', ['Automattic_WooCommerce_Admin_API_Reports_Import_Automattic_WooCommerce_Admin_API_Reports_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'import_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_import_collection_params() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Import_Controller', ['Automattic_WooCommerce_Admin_API_Reports_Import_Automattic_WooCommerce_Admin_API_Reports_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_import_public_schema' }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Import_Controller) import_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [rt.new_string('settings'), rt.new_string('edit')]))))) {
		return (create_automattic_woocommerce_admin_api_reports_import_wp_error(rt.new_string('woocommerce_rest_cannot_edit'), rt.call_function('__', [rt.new_string('Sorry, you cannot edit this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Import_Controller) import_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_query_args := this.prepare_objects_query(var_request.dup())
	mut var_import := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_ReportsSync{}; return temp.regenerate_report_data(arg_0, arg_1) }(var_query_args.array_get('days'), var_query_args.array_get('skip_existing'))
	if rt.is_true(rt.call_function('is_wp_error', [var_import.dup()])) {
		mut var_result := rt.create_array([rt.ArrayItem{ key: 'status', val: 'error' }, rt.ArrayItem{ key: 'message', val: rt.call_method(var_import, 'get_error_message', []rt.PhpVal{}) }])
	} else {
		var_result = rt.create_array([rt.ArrayItem{ key: 'status', val: 'success' }, rt.ArrayItem{ key: 'message', val: var_import }])
	}
	mut var_response := this.prepare_item_for_response(var_result.dup(), var_request.dup())
	mut var_data := this.prepare_response_for_collection(var_response.dup())
	return rt.call_function('rest_ensure_response', [var_data.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Import_Controller) prepare_objects_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_args := rt.new_array()
	var_args.array_set('skip_existing', var_request.array_get('skip_existing'))
	var_args.array_set('days', var_request.array_get('days'))
	return var_args.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Import_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_data := this.add_additional_fields_to_object(var_item.dup(), var_request.dup())
	var_data = this.filter_response_by_context(var_data.dup(), rt.new_string('view'))
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_prepare_reports_import'), var_response.dup(), var_item.dup(), var_request.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Import_Controller) get_import_collection_params() rt.PhpVal {
	mut var_params := rt.new_array()
	var_params.array_set('days', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Number of days to import.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'minimum', val: 0 }]))
	var_params.array_set('skip_existing', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Skip importing existing order data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wc_string_to_bool' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	return var_params.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Import_Controller) get_import_public_schema() rt.PhpVal {
	mut var_schema := rt.create_array([rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' }, rt.ArrayItem{ key: 'title', val: 'report_import' }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'status', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Regeneration status.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'message', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Regenerate data message.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }])
	return this.add_additional_fields_schema(var_schema.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Import_Controller) cancel_import(var_request rt.PhpVal) rt.PhpVal {
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_ReportsSync{}; return temp.clear_queued_actions() }()
	mut var_result := rt.create_array([rt.ArrayItem{ key: 'status', val: 'success' }, rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('All pending and in-progress import actions have been cancelled.'), rt.new_string('woocommerce')]) }])
	mut var_response := this.prepare_item_for_response(var_result.dup(), var_request.dup())
	mut var_data := this.prepare_response_for_collection(var_response.dup())
	return rt.call_function('rest_ensure_response', [var_data.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Import_Controller) delete_imported_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_delete := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_ReportsSync{}; return temp.delete_report_data() }()
	if rt.is_true(rt.call_function('is_wp_error', [var_delete.dup()])) {
		mut var_result := rt.create_array([rt.ArrayItem{ key: 'status', val: 'error' }, rt.ArrayItem{ key: 'message', val: rt.call_method(var_delete, 'get_error_message', []rt.PhpVal{}) }])
	} else {
		var_result = rt.create_array([rt.ArrayItem{ key: 'status', val: 'success' }, rt.ArrayItem{ key: 'message', val: var_delete }])
	}
	mut var_response := this.prepare_item_for_response(var_result.dup(), var_request.dup())
	mut var_data := this.prepare_response_for_collection(var_response.dup())
	return rt.call_function('rest_ensure_response', [var_data.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Import_Controller) get_import_status(var_request rt.PhpVal) rt.PhpVal {
	mut var_result := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_ReportsSync{}; return temp.get_import_stats() }()
	mut var_response := this.prepare_item_for_response(var_result.dup(), var_request.dup())
	mut var_data := this.prepare_response_for_collection(var_response.dup())
	return rt.call_function('rest_ensure_response', [var_data.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Import_Controller) get_import_totals(var_request rt.PhpVal) rt.PhpVal {
	mut var_query_args := this.prepare_objects_query(var_request.dup())
	mut var_totals := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_ReportsSync{}; return temp.get_import_totals(arg_0, arg_1) }(var_query_args.array_get('days'), var_query_args.array_get('skip_existing'))
	mut var_response := this.prepare_item_for_response(var_totals.dup(), var_request.dup())
	mut var_data := this.prepare_response_for_collection(var_response.dup())
	return rt.call_function('rest_ensure_response', [var_data.dup()])
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Import_Automattic_WooCommerce_Admin_API_Reports_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Import_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_ReportsSync {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_import_controller() &Class_Automattic_WooCommerce_Admin_API_Reports_Import_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Import_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		rest_base: rt.new_string('reports/import')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_import_automattic_woocommerce_admin_api_reports_controller() &Class_Automattic_WooCommerce_Admin_API_Reports_Import_Automattic_WooCommerce_Admin_API_Reports_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Import_Automattic_WooCommerce_Admin_API_Reports_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_import_wp_error() &Class_Automattic_WooCommerce_Admin_API_Reports_Import_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Import_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_reportssync() &Class_Automattic_WooCommerce_Admin_ReportsSync {
	mut obj := &Class_Automattic_WooCommerce_Admin_ReportsSync{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Import_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'import_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.import_permissions_check(dispatch_arg_0))
		}
		'import_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.import_items(dispatch_arg_0)
		}
		'prepare_objects_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_objects_query(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_import_collection_params' {
			return this.get_import_collection_params()
		}
		'get_import_public_schema' {
			return this.get_import_public_schema()
		}
		'cancel_import' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.cancel_import(dispatch_arg_0)
		}
		'delete_imported_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_imported_items(dispatch_arg_0)
		}
		'get_import_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_import_status(dispatch_arg_0)
		}
		'get_import_totals' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_import_totals(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Import_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Import_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_base' { this.rest_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Import_Automattic_WooCommerce_Admin_API_Reports_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Import_Automattic_WooCommerce_Admin_API_Reports_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Import_Automattic_WooCommerce_Admin_API_Reports_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Import_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Import_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Import_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_ReportsSync) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_ReportsSync) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportsSync) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_reports_import_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
