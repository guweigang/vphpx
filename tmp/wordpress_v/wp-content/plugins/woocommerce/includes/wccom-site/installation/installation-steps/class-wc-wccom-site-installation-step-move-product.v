import rt

struct Class_WC_WCCOM_Site_Installation_Step_Move_Product {
	rt.PhpObjectBase
pub mut:
		state rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_WCCOM_Site_Installation_Step_Move_Product) construct(var_state rt.PhpVal)  {
	this.state = var_state.dup()
}

fn (mut this Class_WC_WCCOM_Site_Installation_Step_Move_Product) run() rt.PhpVal {
	mut var_upgrader := fn () rt.PhpVal { mut temp := Class_WC_WCCOM_Site_Installer{}; return temp.get_wp_upgrader() }()
	mut var_destination := if rt.is_true(rt.identical(rt.new_string('plugin'), rt.call_method(this.state, 'get_product_type', []rt.PhpVal{}))) { rt.get_constant('WP_PLUGIN_DIR') } else { rt.call_function('get_theme_root', []rt.PhpVal{}) }
	mut var_package := { 'source': rt.call_method(this.state, 'get_unpacked_path', []rt.PhpVal{}), 'destination': var_destination, 'clear_working': rt.new_bool(true), 'hook_extra': { 'type': rt.call_method(this.state, 'get_product_type', []rt.PhpVal{}), 'action': rt.new_string('install') } }
	mut var_result := rt.call_method(var_upgrader, 'install_package', [var_package.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) && rt.is_true(rt.new_bool(rt.get_property(var_result, 'errors').array_isset(rt.new_string('folder_exists')))))) {
		mut var_existing_folder_path := rt.get_property(var_result, 'error_data').array_get('folder_exists')
		mut var_plugin_info := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_WCCOM_Site_Installer{}; return temp.get_plugin_info(arg_0) }(var_existing_folder_path.dup())
		rt.call_method(this.state, 'set_installed_path', [var_existing_folder_path.dup()])
		rt.call_method(this.state, 'set_already_installed_plugin_info', [var_plugin_info.dup()])
		this.maybe_connect_theme()
		return this.state
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
		rt.throw_exception(rt.new_object('WC_REST_WCCOM_Site_Installer_Error', []string{}, create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.installation_failed(), rt.call_function('esc_html', [rt.call_method(var_result, 'get_error_message', []rt.PhpVal{})]))))
		// unsupported statement: Stmt_Nop
	}
	rt.call_method(this.state, 'set_installed_path', [var_result.array_get('destination')])
	this.maybe_connect_theme()
	return this.state
}

fn (mut this Class_WC_WCCOM_Site_Installation_Step_Move_Product) maybe_connect_theme()  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.connect_theme(arg_0) }(rt.call_method(this.state, 'get_product_id', []rt.PhpVal{}))
}

struct Class_WC_WCCOM_Site_Installer {
	rt.PhpObjectBase
}

struct Class_WC_REST_WCCOM_Site_Installer_Error {
	rt.PhpObjectBase
}

struct Class_WC_Helper {
	rt.PhpObjectBase
}

fn create_wc_wccom_site_installation_step_move_product(arg_0 rt.PhpVal) &Class_WC_WCCOM_Site_Installation_Step_Move_Product {
	mut obj := &Class_WC_WCCOM_Site_Installation_Step_Move_Product{
		PhpObjectBase: rt.PhpObjectBase{}
		state: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wc_wccom_site_installer() &Class_WC_WCCOM_Site_Installer {
	mut obj := &Class_WC_WCCOM_Site_Installer{
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

fn (mut this Class_WC_WCCOM_Site_Installation_Step_Move_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'run' {
			return this.run()
		}
		'maybe_connect_theme' {
			this.maybe_connect_theme()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_WCCOM_Site_Installation_Step_Move_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'state' { return this.state }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_WCCOM_Site_Installation_Step_Move_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'state' { this.state = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_WCCOM_Site_Installer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_WCCOM_Site_Installer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_WCCOM_Site_Installer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_wccom_site_installation_installation_steps_class_wc_wccom_site_installation_step_move_product_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
