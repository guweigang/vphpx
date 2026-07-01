import rt

pub fn Class_WC_WCCOM_Site_Installation_State.step_status_in_progress() string {
	return 'in-progress'
}
pub fn Class_WC_WCCOM_Site_Installation_State.step_status_failed() string {
	return 'failed'
}
pub fn Class_WC_WCCOM_Site_Installation_State.step_status_completed() string {
	return 'completed'
}
struct Class_WC_WCCOM_Site_Installation_State {
	rt.PhpObjectBase
pub mut:
		product_id rt.PhpVal = rt.new_null()
		idempotency_key rt.PhpVal = rt.new_null()
		last_step_name rt.PhpVal = rt.new_null()
		last_step_status rt.PhpVal = rt.new_null()
		last_step_error rt.PhpVal = rt.new_null()
		product_type rt.PhpVal = rt.new_null()
		product_name rt.PhpVal = rt.new_null()
		download_url rt.PhpVal = rt.new_null()
		download_path rt.PhpVal = rt.new_null()
		unpacked_path rt.PhpVal = rt.new_null()
		installed_path rt.PhpVal = rt.new_null()
		already_installed_plugin_info rt.PhpVal = rt.new_null()
		started_date rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_WCCOM_Site_Installation_State) construct(var_product_id rt.PhpVal)  {
	this.product_id = var_product_id.dup()
}

fn Class_WC_WCCOM_Site_Installation_State.initiate_existing(var_product_id rt.PhpVal, var_idempotency_key rt.PhpVal, var_last_step_name rt.PhpVal, var_last_step_status rt.PhpVal, var_last_step_error rt.PhpVal, var_started_date rt.PhpVal) rt.PhpVal {
	mut var_instance := create_self(var_product_id.dup())
	rt.set_property(var_instance, 'idempotency_key', var_idempotency_key.dup())
	rt.set_property(var_instance, 'last_step_name', var_last_step_name.dup())
	rt.set_property(var_instance, 'last_step_status', var_last_step_status.dup())
	rt.set_property(var_instance, 'last_step_error', var_last_step_error.dup())
	rt.set_property(var_instance, 'started_date', var_started_date.dup())
	return mut var_instance
}

fn Class_WC_WCCOM_Site_Installation_State.initiate_new(var_product_id rt.PhpVal, var_idempotency_key rt.PhpVal) rt.PhpVal {
	mut var_instance := create_self(var_product_id.dup())
	rt.set_property(var_instance, 'idempotency_key', var_idempotency_key.dup())
	rt.set_property(var_instance, 'started_date', rt.call_function('time', []rt.PhpVal{}))
	return mut var_instance
}

fn (mut this Class_WC_WCCOM_Site_Installation_State) get_product_id() rt.PhpVal {
	return this.product_id
}

fn (mut this Class_WC_WCCOM_Site_Installation_State) get_idempotency_key() rt.PhpVal {
	return this.idempotency_key
}

fn (mut this Class_WC_WCCOM_Site_Installation_State) get_last_step_name() rt.PhpVal {
	return this.last_step_name
}

fn (mut this Class_WC_WCCOM_Site_Installation_State) get_last_step_status() rt.PhpVal {
	return this.last_step_status
}

fn (mut this Class_WC_WCCOM_Site_Installation_State) get_last_step_error() rt.PhpVal {
	return this.last_step_error
}

fn (mut this Class_WC_WCCOM_Site_Installation_State) initiate_step(var_step_name rt.PhpVal)  {
	this.last_step_name = var_step_name.dup()
	this.last_step_status = Class_WC_WCCOM_Site_Installation_State.step_status_in_progress()
}

fn (mut this Class_WC_WCCOM_Site_Installation_State) complete_step(var_step_name rt.PhpVal)  {
	this.last_step_name = var_step_name.dup()
	this.last_step_status = Class_WC_WCCOM_Site_Installation_State.step_status_completed()
}

fn (mut this Class_WC_WCCOM_Site_Installation_State) capture_failure(var_step_name rt.PhpVal, var_error_code rt.PhpVal)  {
	this.last_step_name = var_step_name.dup()
	this.last_step_error = var_error_code.dup()
	this.last_step_status = Class_WC_WCCOM_Site_Installation_State.step_status_failed()
}

fn (mut this Class_WC_WCCOM_Site_Installation_State) get_product_type() rt.PhpVal {
	return this.product_type
}

fn (mut this Class_WC_WCCOM_Site_Installation_State) set_product_type(var_product_type rt.PhpVal)  {
	this.product_type = var_product_type.dup()
}

fn (mut this Class_WC_WCCOM_Site_Installation_State) get_product_name() rt.PhpVal {
	return this.product_name
}

fn (mut this Class_WC_WCCOM_Site_Installation_State) set_product_name(var_product_name rt.PhpVal)  {
	this.product_name = var_product_name.dup()
}

fn (mut this Class_WC_WCCOM_Site_Installation_State) get_download_url() rt.PhpVal {
	return this.download_url
}

fn (mut this Class_WC_WCCOM_Site_Installation_State) set_download_url(var_download_url rt.PhpVal)  {
	this.download_url = var_download_url.dup()
}

fn (mut this Class_WC_WCCOM_Site_Installation_State) get_download_path() rt.PhpVal {
	return this.download_path
}

fn (mut this Class_WC_WCCOM_Site_Installation_State) set_download_path(var_download_path rt.PhpVal)  {
	this.download_path = var_download_path.dup()
}

fn (mut this Class_WC_WCCOM_Site_Installation_State) get_unpacked_path() rt.PhpVal {
	return this.unpacked_path
}

fn (mut this Class_WC_WCCOM_Site_Installation_State) set_unpacked_path(var_unpacked_path rt.PhpVal)  {
	this.unpacked_path = var_unpacked_path.dup()
}

fn (mut this Class_WC_WCCOM_Site_Installation_State) get_installed_path() rt.PhpVal {
	return this.installed_path
}

fn (mut this Class_WC_WCCOM_Site_Installation_State) set_installed_path(var_installed_path rt.PhpVal)  {
	this.installed_path = var_installed_path.dup()
}

fn (mut this Class_WC_WCCOM_Site_Installation_State) get_already_installed_plugin_info() rt.PhpVal {
	return this.already_installed_plugin_info
}

fn (mut this Class_WC_WCCOM_Site_Installation_State) set_already_installed_plugin_info(var_plugin_info rt.PhpVal)  {
	this.already_installed_plugin_info = var_plugin_info.dup()
}

fn (mut this Class_WC_WCCOM_Site_Installation_State) get_started_date() rt.PhpVal {
	return this.started_date
}

struct Class_self {
	rt.PhpObjectBase
}

fn create_wc_wccom_site_installation_state(arg_0 rt.PhpVal) &Class_WC_WCCOM_Site_Installation_State {
	mut obj := &Class_WC_WCCOM_Site_Installation_State{
		PhpObjectBase: rt.PhpObjectBase{}
		product_id: rt.new_null()
		idempotency_key: rt.new_null()
		last_step_name: rt.new_null()
		last_step_status: rt.new_null()
		last_step_error: rt.new_null()
		product_type: rt.new_null()
		product_name: rt.new_null()
		download_url: rt.new_null()
		download_path: rt.new_null()
		unpacked_path: rt.new_null()
		installed_path: rt.new_null()
		already_installed_plugin_info: rt.new_null()
		started_date: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_self() &Class_self {
	mut obj := &Class_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_WCCOM_Site_Installation_State) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'initiate_existing' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			return Class_WC_WCCOM_Site_Installation_State.initiate_existing(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5)
		}
		'initiate_new' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_WCCOM_Site_Installation_State.initiate_new(dispatch_arg_0, dispatch_arg_1)
		}
		'get_product_id' {
			return this.get_product_id()
		}
		'get_idempotency_key' {
			return this.get_idempotency_key()
		}
		'get_last_step_name' {
			return this.get_last_step_name()
		}
		'get_last_step_status' {
			return this.get_last_step_status()
		}
		'get_last_step_error' {
			return this.get_last_step_error()
		}
		'initiate_step' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.initiate_step(dispatch_arg_0)
			return rt.new_null()
		}
		'complete_step' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.complete_step(dispatch_arg_0)
			return rt.new_null()
		}
		'capture_failure' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.capture_failure(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_product_type' {
			return this.get_product_type()
		}
		'set_product_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_product_type(dispatch_arg_0)
			return rt.new_null()
		}
		'get_product_name' {
			return this.get_product_name()
		}
		'set_product_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_product_name(dispatch_arg_0)
			return rt.new_null()
		}
		'get_download_url' {
			return this.get_download_url()
		}
		'set_download_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_download_url(dispatch_arg_0)
			return rt.new_null()
		}
		'get_download_path' {
			return this.get_download_path()
		}
		'set_download_path' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_download_path(dispatch_arg_0)
			return rt.new_null()
		}
		'get_unpacked_path' {
			return this.get_unpacked_path()
		}
		'set_unpacked_path' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_unpacked_path(dispatch_arg_0)
			return rt.new_null()
		}
		'get_installed_path' {
			return this.get_installed_path()
		}
		'set_installed_path' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_installed_path(dispatch_arg_0)
			return rt.new_null()
		}
		'get_already_installed_plugin_info' {
			return this.get_already_installed_plugin_info()
		}
		'set_already_installed_plugin_info' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_already_installed_plugin_info(dispatch_arg_0)
			return rt.new_null()
		}
		'get_started_date' {
			return this.get_started_date()
		}
		else { return none }
	}
}

fn (this &Class_WC_WCCOM_Site_Installation_State) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'product_id' { return this.product_id }
		'idempotency_key' { return this.idempotency_key }
		'last_step_name' { return this.last_step_name }
		'last_step_status' { return this.last_step_status }
		'last_step_error' { return this.last_step_error }
		'product_type' { return this.product_type }
		'product_name' { return this.product_name }
		'download_url' { return this.download_url }
		'download_path' { return this.download_path }
		'unpacked_path' { return this.unpacked_path }
		'installed_path' { return this.installed_path }
		'already_installed_plugin_info' { return this.already_installed_plugin_info }
		'started_date' { return this.started_date }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_WCCOM_Site_Installation_State) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'product_id' { this.product_id = val; return true }
		'idempotency_key' { this.idempotency_key = val; return true }
		'last_step_name' { this.last_step_name = val; return true }
		'last_step_status' { this.last_step_status = val; return true }
		'last_step_error' { this.last_step_error = val; return true }
		'product_type' { this.product_type = val; return true }
		'product_name' { this.product_name = val; return true }
		'download_url' { this.download_url = val; return true }
		'download_path' { this.download_path = val; return true }
		'unpacked_path' { this.unpacked_path = val; return true }
		'installed_path' { this.installed_path = val; return true }
		'already_installed_plugin_info' { this.already_installed_plugin_info = val; return true }
		'started_date' { this.started_date = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_wccom_site_installation_class_wc_wccom_site_installation_state_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
