import rt

pub fn Class_WC_WCCOM_Site_Installation_Manager.steps() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'get_product_info' }, rt.ArrayItem{ key: none, val: 'download_product' }, rt.ArrayItem{ key: none, val: 'unpack_product' }, rt.ArrayItem{ key: none, val: 'move_product' }, rt.ArrayItem{ key: none, val: 'activate_product' }])
}
struct Class_WC_WCCOM_Site_Installation_Manager {
	rt.PhpObjectBase
pub mut:
		product_id i64
		idempotency_key string
}

fn (mut this Class_WC_WCCOM_Site_Installation_Manager) construct(product_id i64, idempotency_key string)  {
	this.product_id = product_id
	this.idempotency_key = idempotency_key
}

fn (mut this Class_WC_WCCOM_Site_Installation_Manager) get_installation_status() rt.PhpVal {
	mut var_state := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_WCCOM_Site_Installation_State_Storage{}; return temp.get_state(arg_0) }(rt.new_int(this.product_id))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_state)))) {
		rt.throw_exception(rt.new_object('WC_REST_WCCOM_Site_Installer_Error', []string{}, create_wc_rest_wccom_site_installer_error(rt.call_function('esc_html', [Class_WC_REST_WCCOM_Site_Installer_Error_Codes.no_initiated_installation_found()]))))
	}
	return var_state.dup()
}

fn (mut this Class_WC_WCCOM_Site_Installation_Manager) run_installation(run_until_step string) bool {
	mut var_state := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_WCCOM_Site_Installation_State_Storage{}; return temp.get_state(arg_0) }(rt.new_int(this.product_id))
	if rt.is_true(rt.new_bool(rt.is_true(var_state) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.throw_exception(rt.new_object('WC_REST_WCCOM_Site_Installer_Error', []string{}, create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.idempotency_key_mismatch())))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_state)))) {
		var_state = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_WCCOM_Site_Installation_State{}; return temp.initiate_new(arg_0, arg_1) }(rt.new_int(this.product_id), rt.new_string(this.idempotency_key))
	}
	this.can_run_installation(rt.new_string(run_until_step), var_state.dup())
	mut var_next_step := rt.new_string(this.get_next_step(var_state.dup()))
	mut var_installation_steps := this.get_installation_steps((var_next_step).str(), run_until_step)
	closure_1_fn := fn [var_state] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_step_name := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	this.run_step(var_step_name.dup(), var_state.dup())
	return rt.new_null()
	}
	rt.call_function('array_walk', [var_installation_steps.dup(), rt.new_closure(closure_1_fn)])
	return true
}

fn (mut this Class_WC_WCCOM_Site_Installation_Manager) reset_installation() bool {
	mut var_state := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_WCCOM_Site_Installation_State_Storage{}; return temp.get_state(arg_0) }(rt.new_int(this.product_id))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_state)))) {
		rt.throw_exception(rt.new_object('WC_REST_WCCOM_Site_Installer_Error', []string{}, create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.no_initiated_installation_found())))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('WC_REST_WCCOM_Site_Installer_Error', []string{}, create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.idempotency_key_mismatch())))
	}
	mut var_result := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_WCCOM_Site_Installation_State_Storage{}; return temp.delete_state(arg_0) }(var_state.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		rt.throw_exception(rt.new_object('WC_REST_WCCOM_Site_Installer_Error', []string{}, create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.failed_to_reset_installation_state())))
	}
	return true
}

fn (mut this Class_WC_WCCOM_Site_Installation_Manager) can_run_installation(var_run_until_step rt.PhpVal, var_state rt.PhpVal)  {
	mut var_state_mutated := var_state
	if rt.is_true(rt.identical(rt.call_method(var_state_mutated, 'get_last_step_status', []rt.PhpVal{}), Class_WC_WCCOM_Site_Installation_State.step_status_in_progress())) {
		rt.throw_exception(rt.new_object('WC_REST_WCCOM_Site_Installer_Error', []string{}, create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.installation_already_running())))
	}
	if rt.is_true(rt.identical(rt.call_method(var_state_mutated, 'get_last_step_status', []rt.PhpVal{}), Class_WC_WCCOM_Site_Installation_State.step_status_failed())) {
		rt.throw_exception(rt.new_object('WC_REST_WCCOM_Site_Installer_Error', []string{}, create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.installation_failed())))
	}
	if rt.is_true(rt.identical(rt.call_method(var_state_mutated, 'get_last_step_name', []rt.PhpVal{}), Class_WC_WCCOM_Site_Installation_Manager.steps().array_get(Class_WC_WCCOM_Site_Installation_Manager.steps().array_count() - 1))) {
		rt.throw_exception(rt.new_object('WC_REST_WCCOM_Site_Installer_Error', []string{}, create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.all_installation_steps_run())))
	}
	if rt.is_true(rt.greater_equal(rt.call_function('array_search', [rt.call_method(var_state_mutated, 'get_last_step_name', []rt.PhpVal{}), Class_WC_WCCOM_Site_Installation_Manager.steps(), rt.new_bool(true)]), rt.call_function('array_search', [var_run_until_step.dup(), Class_WC_WCCOM_Site_Installation_Manager.steps(), rt.new_bool(true)]))) {
		rt.throw_exception(rt.new_object('WC_REST_WCCOM_Site_Installer_Error', []string{}, create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.requested_step_already_run())))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_writable', [rt.get_constant('WP_CONTENT_DIR')]))))) {
		rt.throw_exception(rt.new_object('WC_REST_WCCOM_Site_Installer_Error', []string{}, create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.filesystem_requirements_not_met())))
	}
}

fn (mut this Class_WC_WCCOM_Site_Installation_Manager) get_next_step(var_state rt.PhpVal) string {
	mut var_state_mutated := var_state
	mut var_last_executed_step := rt.call_method(var_state_mutated, 'get_last_step_name', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_last_executed_step)))) {
		return (Class_WC_WCCOM_Site_Installation_Manager.steps().array_get(0)).str()
	}
	mut var_last_executed_step_index := rt.call_function('array_search', [var_last_executed_step.dup(), Class_WC_WCCOM_Site_Installation_Manager.steps(), rt.new_bool(true)])
	return (Class_WC_WCCOM_Site_Installation_Manager.steps().array_get(rt.add(var_last_executed_step_index, rt.new_int(1)))).str()
}

fn (mut this Class_WC_WCCOM_Site_Installation_Manager) get_installation_steps(start_step string, end_step string) rt.PhpVal {
	mut var_start_step_offset := rt.call_function('array_search', [rt.new_string(start_step), Class_WC_WCCOM_Site_Installation_Manager.steps(), rt.new_bool(true)])
	mut var_end_step_index := rt.call_function('array_search', [rt.new_string(end_step), Class_WC_WCCOM_Site_Installation_Manager.steps(), rt.new_bool(true)])
	mut var_length := rt.add(rt.sub(var_end_step_index, var_start_step_offset), rt.new_int(1))
	return rt.call_function('array_slice', [Class_WC_WCCOM_Site_Installation_Manager.steps(), var_start_step_offset.dup(), var_length.dup()])
}

fn (mut this Class_WC_WCCOM_Site_Installation_Manager) run_step(var_step_name rt.PhpVal, var_state rt.PhpVal)  {
	mut var_state_mutated := var_state
	rt.call_method(var_state_mutated, 'initiate_step', [var_step_name.dup()])
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_WCCOM_Site_Installation_State_Storage{}; return temp.save_state(arg_0) }(var_state_mutated.dup())
	mut var_class_name := rt.new_string(rt.new_string("WC_WCCOM_Site_Installation_Step_${var_step_name.to_string()}"))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_current_step := rt.create_object_dynamically(var_class_name, [var_state_mutated.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_current_step, 'run', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'WC_REST_WCCOM_Site_Installer_Error') {
		mut var_exception := var_e_1.dup()
		rt.call_method(var_state_mutated, 'capture_failure', [var_step_name.dup(), rt.call_method(var_exception, 'get_error_code', []rt.PhpVal{})])
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_WCCOM_Site_Installation_State_Storage{}; return temp.save_state(arg_0) }(var_state_mutated.dup())
		rt.throw_exception(var_exception)
		unsafe { goto end_label_1 }
	}
	else if rt.instance_of(var_e_1, 'Throwable') {
		mut var_error := var_e_1.dup()
		rt.call_method(var_state_mutated, 'capture_failure', [var_step_name.dup(), Class_WC_REST_WCCOM_Site_Installer_Error_Codes.unexpected_error()])
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_WCCOM_Site_Installation_State_Storage{}; return temp.save_state(arg_0) }(var_state_mutated.dup())
		rt.throw_exception(rt.new_object('WC_REST_WCCOM_Site_Installer_Error', []string{}, create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.unexpected_error(), rt.call_method(var_error, 'getMessage', []rt.PhpVal{}))))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	rt.call_method(var_state_mutated, 'complete_step', [var_step_name.dup()])
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_WCCOM_Site_Installation_State_Storage{}; return temp.save_state(arg_0) }(var_state_mutated.dup())
}

struct Class_WC_WCCOM_Site_Installation_State_Storage {
	rt.PhpObjectBase
}

struct Class_WC_REST_WCCOM_Site_Installer_Error {
	rt.PhpObjectBase
}

struct Class_WC_WCCOM_Site_Installation_State {
	rt.PhpObjectBase
}

fn create_wc_wccom_site_installation_manager(product_id i64, idempotency_key string) &Class_WC_WCCOM_Site_Installation_Manager {
	mut obj := &Class_WC_WCCOM_Site_Installation_Manager{
		PhpObjectBase: rt.PhpObjectBase{}
		product_id: i64(0)
		idempotency_key: ''
	}
	obj.construct(product_id, idempotency_key)
	return obj
}

fn create_wc_wccom_site_installation_state_storage() &Class_WC_WCCOM_Site_Installation_State_Storage {
	mut obj := &Class_WC_WCCOM_Site_Installation_State_Storage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_rest_wccom_site_installer_error() &Class_WC_REST_WCCOM_Site_Installer_Error {
	mut obj := &Class_WC_REST_WCCOM_Site_Installer_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_wccom_site_installation_state() &Class_WC_WCCOM_Site_Installation_State {
	mut obj := &Class_WC_WCCOM_Site_Installation_State{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_WCCOM_Site_Installation_Manager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_installation_status' {
			return this.get_installation_status()
		}
		'run_installation' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.run_installation(dispatch_arg_0))
		}
		'reset_installation' {
			return rt.new_bool(this.reset_installation())
		}
		'can_run_installation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.can_run_installation(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_next_step' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_next_step(dispatch_arg_0))
		}
		'get_installation_steps' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_installation_steps(dispatch_arg_0, dispatch_arg_1)
		}
		'run_step' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.run_step(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_WCCOM_Site_Installation_Manager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'product_id' { return rt.new_int(this.product_id) }
		'idempotency_key' { return rt.new_string(this.idempotency_key) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_WCCOM_Site_Installation_Manager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'product_id' { this.product_id = (val).to_i64(); return true }
		'idempotency_key' { this.idempotency_key = (val).str(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_WC_REST_WCCOM_Site_Installer_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_WCCOM_Site_Installer_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_WCCOM_Site_Installer_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_WCCOM_Site_Installation_State) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_WCCOM_Site_Installation_State) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_WCCOM_Site_Installation_State) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('WC_WCCOM_Site_Installation_Manager', fn(args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
		c_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		obj := create_wc_wccom_site_installation_manager(c_arg_0, c_arg_1)
		return rt.new_object('WC_WCCOM_Site_Installation_Manager', []string{}, obj)
	})
	rt.register_class_factory('WC_WCCOM_Site_Installation_State_Storage', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_wccom_site_installation_state_storage()
		return rt.new_object('WC_WCCOM_Site_Installation_State_Storage', []string{}, obj)
	})
	rt.register_class_factory('WC_REST_WCCOM_Site_Installer_Error', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_rest_wccom_site_installer_error()
		return rt.new_object('WC_REST_WCCOM_Site_Installer_Error', []string{}, obj)
	})
	rt.register_class_factory('WC_WCCOM_Site_Installation_State', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_wccom_site_installation_state()
		return rt.new_object('WC_WCCOM_Site_Installation_State', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_wccom_site_installation_class_wc_wccom_site_installation_manager_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
