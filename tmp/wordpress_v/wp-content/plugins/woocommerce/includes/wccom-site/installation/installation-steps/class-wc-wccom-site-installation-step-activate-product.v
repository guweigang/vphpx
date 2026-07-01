import rt

struct Class_WC_WCCOM_Site_Installation_Step_Activate_Product {
	rt.PhpObjectBase
pub mut:
		state rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_WCCOM_Site_Installation_Step_Activate_Product) construct(var_state rt.PhpVal)  {
	this.state = var_state.dup()
}

fn (mut this Class_WC_WCCOM_Site_Installation_Step_Activate_Product) run() rt.PhpVal {
	mut var_product_id := rt.call_method(this.state, 'get_product_id', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_string('plugin'), rt.call_method(this.state, 'get_product_type', []rt.PhpVal{}))) {
		this.activate_plugin(var_product_id.dup())
	} else {
		this.activate_theme(var_product_id.dup())
	}
	return this.state
}

fn (mut this Class_WC_WCCOM_Site_Installation_Step_Activate_Product) activate_plugin(var_product_id rt.PhpVal)  {
	mut var_product_id_mutated := var_product_id
	rt.call_function('wp_clean_plugins_cache', []rt.PhpVal{})
	mut var_filename := rt.new_bool(rt.new_bool(false))
	mut var_dir_name := rt.new_bool(this.get_wporg_product_dir_name())
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_filename = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_WCCOM_Site_Installer{}; return temp.get_wporg_plugin_main_file(arg_0) }(var_dir_name.dup())
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_filename)) {
		mut var_plugins := rt.call_function('wp_list_filter', [fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_local_woo_plugins() }(), rt.create_array([rt.ArrayItem{ key: '_product_id', val: var_product_id_mutated }])])
		var_filename = if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_plugins.dup().is_array())) && !(!rt.is_true(var_plugins)))) { rt.call_function('key', [var_plugins.dup()]) } else { rt.new_string('') }
	}
	if !rt.is_true(var_filename) && !(!rt.is_true(rt.call_method(this.state, 'get_installed_path', []rt.PhpVal{}))) {
		var_filename = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_WCCOM_Site_Installer{}; return temp.get_wporg_plugin_main_file(arg_0) }(rt.call_function('basename', [rt.call_method(this.state, 'get_installed_path', []rt.PhpVal{})]))
	}
	if !rt.is_true(var_filename) {
		rt.throw_exception(rt.new_object('WC_REST_WCCOM_Site_Installer_Error', []string{}, create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.unknown_filename())))
	}
	if rt.is_true(rt.call_function('is_plugin_active', [var_filename.dup()])) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.activated_plugin(arg_0) }(var_filename.dup())
	}
	mut var_result := rt.call_function('activate_plugin', [var_filename.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
		rt.throw_exception(rt.new_object('WC_REST_WCCOM_Site_Installer_Error', []string{}, create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.plugin_activation_error(), rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}))))
	}
}

fn (mut this Class_WC_WCCOM_Site_Installation_Step_Activate_Product) activate_theme(var_product_id rt.PhpVal)  {
	mut var_product_id_mutated := var_product_id
	rt.call_function('wp_clean_themes_cache', []rt.PhpVal{})
	mut var_theme_slug := rt.new_bool(rt.new_bool(false))
	mut var_dir_name := rt.new_bool(this.get_wporg_product_dir_name())
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_theme_slug = rt.call_function('basename', [var_dir_name.dup()])
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_theme_slug)) {
		mut var_themes := rt.call_function('wp_list_filter', [fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_local_woo_themes() }(), rt.create_array([rt.ArrayItem{ key: '_product_id', val: var_product_id_mutated }])])
		var_theme_slug = if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_themes.dup().is_array())) && !(!rt.is_true(var_themes)))) { rt.call_function('dirname', [rt.call_function('key', [var_themes.dup()])]) } else { rt.new_string('') }
	}
	if !rt.is_true(var_theme_slug) && !(!rt.is_true(rt.call_method(this.state, 'get_installed_path', []rt.PhpVal{}))) {
		var_theme_slug = rt.call_function('basename', [rt.call_method(this.state, 'get_installed_path', []rt.PhpVal{})])
	}
	if !rt.is_true(var_theme_slug) {
		rt.throw_exception(rt.new_object('WC_REST_WCCOM_Site_Installer_Error', []string{}, create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.unknown_filename())))
	}
	rt.call_function('switch_theme', [var_theme_slug.dup()])
}

fn (mut this Class_WC_WCCOM_Site_Installation_Step_Activate_Product) get_wporg_product_dir_name() bool {
	if !rt.is_true(rt.call_method(this.state, 'get_installed_path', []rt.PhpVal{})) {
		return false
	}
	mut var_download_url := rt.call_method(this.state, 'get_download_url', []rt.PhpVal{})
	mut var_parsed_url := rt.call_function('wp_parse_url', [var_download_url.dup()])
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_parsed_url.array_get('host'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return false
	}
	return (rt.call_function('basename', [rt.call_method(this.state, 'get_installed_path', []rt.PhpVal{})])).to_bool()
}

struct Class_WC_WCCOM_Site_Installer {
	rt.PhpObjectBase
}

struct Class_WC_Helper {
	rt.PhpObjectBase
}

struct Class_WC_REST_WCCOM_Site_Installer_Error {
	rt.PhpObjectBase
}

fn create_wc_wccom_site_installation_step_activate_product(arg_0 rt.PhpVal) &Class_WC_WCCOM_Site_Installation_Step_Activate_Product {
	mut obj := &Class_WC_WCCOM_Site_Installation_Step_Activate_Product{
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

fn create_wc_helper() &Class_WC_Helper {
	mut obj := &Class_WC_Helper{
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

fn (mut this Class_WC_WCCOM_Site_Installation_Step_Activate_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'run' {
			return this.run()
		}
		'activate_plugin' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.activate_plugin(dispatch_arg_0)
			return rt.new_null()
		}
		'activate_theme' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.activate_theme(dispatch_arg_0)
			return rt.new_null()
		}
		'get_wporg_product_dir_name' {
			return rt.new_bool(this.get_wporg_product_dir_name())
		}
		else { return none }
	}
}

fn (this &Class_WC_WCCOM_Site_Installation_Step_Activate_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'state' { return this.state }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_WCCOM_Site_Installation_Step_Activate_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_wccom_site_installation_installation_steps_class_wc_wccom_site_installation_step_activate_product_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
