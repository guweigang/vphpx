import rt

struct Class_WC_WCCOM_Site_Installation_Step_Get_Product_Info {
	rt.PhpObjectBase
pub mut:
		state rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_WCCOM_Site_Installation_Step_Get_Product_Info) construct(var_state rt.PhpVal)  {
	this.state = var_state.dup()
}

fn (mut this Class_WC_WCCOM_Site_Installation_Step_Get_Product_Info) run() rt.PhpVal {
	mut var_product_id := rt.call_method(this.state, 'get_product_id', []rt.PhpVal{})
	mut var_request := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper_API{}; return temp.get(arg_0, arg_1) }(rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'product_id', val: var_product_id }]), rt.new_string('info')]), rt.create_array([rt.ArrayItem{ key: 'authenticated', val: true }]))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('WC_REST_WCCOM_Site_Installer_Error', []string{}, create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.failed_getting_product_info())))
	}
	mut var_result := rt.call_function('json_decode', [rt.call_function('wp_remote_retrieve_body', [var_request.dup()]), rt.new_bool(true)])
	if !(var_result.array_isset(rt.new_string('_product_type')) && var_result.array_isset(rt.new_string('name'))) {
		rt.throw_exception(rt.new_object('WC_REST_WCCOM_Site_Installer_Error', []string{}, create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.invalid_product_info_response())))
	}
	if !(!rt.is_true(var_result.array_get('_wporg_product'))) {
		mut var_download_url := this.get_wporg_download_url(var_result.dup())
	} else {
		var_download_url = this.get_wccom_download_url(var_product_id.dup())
	}
	rt.call_method(this.state, 'set_product_type', [var_result.array_get('_product_type')])
	rt.call_method(this.state, 'set_product_name', [var_result.array_get('name')])
	rt.call_method(this.state, 'set_download_url', [var_download_url.dup()])
	return this.state
}

fn (mut this Class_WC_WCCOM_Site_Installation_Step_Get_Product_Info) get_wporg_download_url(var_data rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_data.array_get('_wporg_product')) {
		return rt.new_null()
	}
	if !rt.is_true(var_data.array_get('download_link')) {
		rt.throw_exception(rt.new_object('WC_REST_WCCOM_Site_Installer_Error', []string{}, create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.wporg_product_missing_download_link())))
	}
	return var_data.array_get('download_link')
}

fn (mut this Class_WC_WCCOM_Site_Installation_Step_Get_Product_Info) get_wccom_download_url(var_product_id rt.PhpVal) rt.PhpVal {
	mut var_product_id_mutated := var_product_id
	fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp._flush_subscriptions_cache() }()
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.has_product_subscription(arg_0) }(var_product_id_mutated.dup()))))) {
		rt.throw_exception(rt.new_object('WC_REST_WCCOM_Site_Installer_Error', []string{}, create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.wccom_product_missing_subscription())))
	}
	fn () rt.PhpVal { mut temp := Class_WC_Helper_Updater{}; return temp.flush_updates_cache() }()
	mut var_updates := fn () rt.PhpVal { mut temp := Class_WC_Helper_Updater{}; return temp.get_update_data() }()
	if !rt.is_true(var_updates.array_get(var_product_id_mutated).array_get('package')) {
		rt.throw_exception(rt.new_object('WC_REST_WCCOM_Site_Installer_Error', []string{}, create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.wccom_product_missing_package())))
	}
	return var_updates.array_get(var_product_id_mutated).array_get('package')
}

struct Class_WC_Helper_API {
	rt.PhpObjectBase
}

struct Class_WC_REST_WCCOM_Site_Installer_Error {
	rt.PhpObjectBase
}

struct Class_WC_Helper {
	rt.PhpObjectBase
}

struct Class_WC_Helper_Updater {
	rt.PhpObjectBase
}

fn create_wc_wccom_site_installation_step_get_product_info(arg_0 rt.PhpVal) &Class_WC_WCCOM_Site_Installation_Step_Get_Product_Info {
	mut obj := &Class_WC_WCCOM_Site_Installation_Step_Get_Product_Info{
		PhpObjectBase: rt.PhpObjectBase{}
		state: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wc_helper_api() &Class_WC_Helper_API {
	mut obj := &Class_WC_Helper_API{
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

fn create_wc_helper() &Class_WC_Helper {
	mut obj := &Class_WC_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper_updater() &Class_WC_Helper_Updater {
	mut obj := &Class_WC_Helper_Updater{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_WCCOM_Site_Installation_Step_Get_Product_Info) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'run' {
			return this.run()
		}
		'get_wporg_download_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_wporg_download_url(dispatch_arg_0)
		}
		'get_wccom_download_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_wccom_download_url(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_WCCOM_Site_Installation_Step_Get_Product_Info) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'state' { return this.state }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_WCCOM_Site_Installation_Step_Get_Product_Info) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'state' { this.state = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Helper_API) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper_API) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_API) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Helper_Updater) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper_Updater) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_Updater) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_wccom_site_installation_installation_steps_class_wc_wccom_site_installation_step_get_product_info_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
