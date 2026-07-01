import rt

struct Class_WC_REST_WCCOM_Site_Installer_Controller {
	rt.PhpObjectBase
pub mut:
		rest_base rt.PhpVal = rt.new_string('installer')
}

fn (mut this Class_WC_REST_WCCOM_Site_Installer_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WC_REST_WCCOM_Site_Installer_Controller', ['WC_REST_WCCOM_Site_Controller'], &this), 'namespace'), '/' + (this.rest_base).str() + '/(?P<product_id>\\d+)/state', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_WCCOM_Site_Installer_Controller', ['WC_REST_WCCOM_Site_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_product_install_state' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_WCCOM_Site_Installer_Controller', ['WC_REST_WCCOM_Site_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'check_permission' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'product_id', val: rt.create_array([rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WC_REST_WCCOM_Site_Installer_Controller', ['WC_REST_WCCOM_Site_Controller'], &this), 'namespace'), '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_WCCOM_Site_Installer_Controller', ['WC_REST_WCCOM_Site_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'install' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_WCCOM_Site_Installer_Controller', ['WC_REST_WCCOM_Site_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'check_permission' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'product-id', val: rt.create_array([rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'run-until-step', val: rt.create_array([rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: Class_WC_WCCOM_Site_Installation_Manager.steps() }]) }, rt.ArrayItem{ key: 'idempotency-key', val: rt.create_array([rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WC_REST_WCCOM_Site_Installer_Controller', ['WC_REST_WCCOM_Site_Controller'], &this), 'namespace'), '/' + (this.rest_base).str() + '/reset', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_WCCOM_Site_Installer_Controller', ['WC_REST_WCCOM_Site_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'reset_install' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_WCCOM_Site_Installer_Controller', ['WC_REST_WCCOM_Site_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'check_permission' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'product-id', val: rt.create_array([rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'idempotency-key', val: rt.create_array([rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }])])
}

fn (mut this Class_WC_REST_WCCOM_Site_Installer_Controller) user_has_permission(var_user rt.PhpVal) bool {
	return rt.is_true(rt.call_function('user_can', [var_user.dup(), rt.new_string('install_plugins')])) && rt.is_true(rt.call_function('user_can', [var_user.dup(), rt.new_string('install_themes')]))
}

fn (mut this Class_WC_REST_WCCOM_Site_Installer_Controller) get_product_install_state(var_request rt.PhpVal) rt.PhpVal {
	mut var_product_id := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.less_equal(var_product_id, rt.new_int(0))) {
		return rt.call_function('rest_ensure_response', [create_wp_error(rt.new_string('missing_param'), rt.new_string('The product_id parameter is required.'), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))])
	}
	mut var_installation_manager := create_wc_wccom_site_installation_manager(var_product_id.dup())
	mut var_state := var_installation_manager.get_installation_status()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return this.success_response(var_product_id.dup(), mut rt.cast_object_ptr[Class_?WC_WCCOM_Site_Installation_State](var_state))
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'WC_REST_WCCOM_Site_Installer_Error') {
		mut var_exception := var_e_1.dup()
		return this.failure_response(var_product_id.dup(), var_exception.dup())
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.new_null()
}

fn (mut this Class_WC_REST_WCCOM_Site_Installer_Controller) install(var_request rt.PhpVal) rt.PhpVal {
	mut var_product_id := var_request.array_get('product-id')
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_run_until_step := var_request.array_get('run-until-step')
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_idempotency_key := var_request.array_get('idempotency-key')
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_installation_manager := create_wc_wccom_site_installation_manager(var_product_id.dup(), var_idempotency_key.dup())
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	var_installation_manager.run_installation(var_run_until_step.dup())
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_response := this.success_response(var_product_id.dup(), rt.new_null())
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'WC_REST_WCCOM_Site_Installer_Error') {
		mut var_exception := var_e_2.dup()
		var_response = this.failure_response(var_product_id.dup(), var_exception.dup())
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return var_response.dup()
}

fn (mut this Class_WC_REST_WCCOM_Site_Installer_Controller) reset_install(var_request rt.PhpVal) rt.PhpVal {
	mut var_product_id := var_request.array_get('product-id')
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	mut var_idempotency_key := var_request.array_get('idempotency-key')
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	mut var_installation_manager := create_wc_wccom_site_installation_manager(var_product_id.dup(), var_idempotency_key.dup())
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	var_installation_manager.reset_installation()
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	mut var_response := this.success_response(var_product_id.dup(), rt.new_null())
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'WC_REST_WCCOM_Site_Installer_Error') {
		mut var_exception := var_e_3.dup()
		var_response = this.failure_response(var_product_id.dup(), var_exception.dup())
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	return var_response.dup()
}

fn (mut this Class_WC_REST_WCCOM_Site_Installer_Controller) success_response(var_product_id rt.PhpVal, mut var_state Class_?WC_WCCOM_Site_Installation_State) rt.PhpVal {
	mut var_product_id_mutated := var_product_id
	mut var_state_mutated := var_state
	var_state_mutated = if !(var_state_mutated).is_null() { var_state_mutated } else { fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_WCCOM_Site_Installation_State_Storage{}; return temp.get_state(arg_0) }(var_product_id_mutated.dup()) }
	mut var_response := rt.call_function('rest_ensure_response', [rt.create_array([rt.ArrayItem{ key: 'success', val: true }, rt.ArrayItem{ key: 'state', val: if rt.is_true(var_state_mutated) { this.map_state_to_response(rt.new_object('?WC_WCCOM_Site_Installation_State', []string{}, var_state_mutated)) } else { rt.new_null() } }])])
	rt.call_method(var_response, 'set_status', [rt.new_int(200)])
	return var_response.dup()
}

fn (mut this Class_WC_REST_WCCOM_Site_Installer_Controller) failure_response(var_product_id rt.PhpVal, var_exception rt.PhpVal) rt.PhpVal {
	mut var_product_id_mutated := var_product_id
	mut var_state := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_WCCOM_Site_Installation_State_Storage{}; return temp.get_state(arg_0) }(var_product_id_mutated.dup())
	mut var_response := rt.call_function('rest_ensure_response', [rt.create_array([rt.ArrayItem{ key: 'success', val: false }, rt.ArrayItem{ key: 'error_code', val: rt.call_method(var_exception, 'get_error_code', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'error_message', val: rt.call_method(var_exception, 'get_error_message', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'state', val: if rt.is_true(var_state) { this.map_state_to_response(var_state.dup()) } else { rt.new_null() } }])])
	rt.call_method(var_response, 'set_status', [rt.call_method(var_exception, 'get_http_code', []rt.PhpVal{})])
	return var_response.dup()
}

fn (mut this Class_WC_REST_WCCOM_Site_Installer_Controller) map_state_to_response(var_state rt.PhpVal) rt.PhpVal {
	mut var_state_mutated := var_state
	return rt.create_array([rt.ArrayItem{ key: 'product_id', val: rt.call_method(var_state_mutated, 'get_product_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'idempotency_key', val: rt.call_method(var_state_mutated, 'get_idempotency_key', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'last_step_name', val: rt.call_method(var_state_mutated, 'get_last_step_name', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'last_step_status', val: rt.call_method(var_state_mutated, 'get_last_step_status', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'last_step_error', val: rt.call_method(var_state_mutated, 'get_last_step_error', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'product_type', val: rt.call_method(var_state_mutated, 'get_product_type', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'product_name', val: rt.call_method(var_state_mutated, 'get_product_name', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'already_installed_plugin_info', val: rt.call_method(var_state_mutated, 'get_already_installed_plugin_info', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'started_seconds_ago', val: rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.call_method(var_state_mutated, 'get_started_date', []rt.PhpVal{})) }])
}

struct Class_WC_REST_WCCOM_Site_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WC_WCCOM_Site_Installation_Manager {
	rt.PhpObjectBase
}

struct Class_WC_WCCOM_Site_Installation_State_Storage {
	rt.PhpObjectBase
}

fn create_wc_rest_wccom_site_installer_controller() &Class_WC_REST_WCCOM_Site_Installer_Controller {
	mut obj := &Class_WC_REST_WCCOM_Site_Installer_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		rest_base: rt.new_string('installer')
	}
	return obj
}

fn create_wc_rest_wccom_site_controller() &Class_WC_REST_WCCOM_Site_Controller {
	mut obj := &Class_WC_REST_WCCOM_Site_Controller{
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

fn create_wc_wccom_site_installation_manager() &Class_WC_WCCOM_Site_Installation_Manager {
	mut obj := &Class_WC_WCCOM_Site_Installation_Manager{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_wccom_site_installation_state_storage() &Class_WC_WCCOM_Site_Installation_State_Storage {
	mut obj := &Class_WC_WCCOM_Site_Installation_State_Storage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_WCCOM_Site_Installer_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'user_has_permission' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.user_has_permission(dispatch_arg_0))
		}
		'get_product_install_state' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_product_install_state(dispatch_arg_0)
		}
		'install' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.install(dispatch_arg_0)
		}
		'reset_install' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.reset_install(dispatch_arg_0)
		}
		'success_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?WC_WCCOM_Site_Installation_State](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.success_response(dispatch_arg_0, mut dispatch_arg_1)
		}
		'failure_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.failure_response(dispatch_arg_0, dispatch_arg_1)
		}
		'map_state_to_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.map_state_to_response(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_WCCOM_Site_Installer_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_WCCOM_Site_Installer_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_base' { this.rest_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_WCCOM_Site_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_WCCOM_Site_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_WCCOM_Site_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_WCCOM_Site_Installation_Manager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_WCCOM_Site_Installation_Manager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_WCCOM_Site_Installation_Manager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_WCCOM_Site_Installation_State_Storage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_WCCOM_Site_Installation_State_Storage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_WCCOM_Site_Installation_State_Storage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_wccom_site_rest_api_endpoints_class_wc_rest_wccom_site_installer_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
