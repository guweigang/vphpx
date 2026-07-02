import rt

struct Class_WC_WCCOM_Site_Installation_Step_Activate_Product {
	rt.PhpObjectBase
pub mut:
	state rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_WCCOM_Site_Installation_Step_Activate_Product) construct(var_state rt.PhpVal) {
	this.state = var_state.clone()
}

fn (mut this Class_WC_WCCOM_Site_Installation_Step_Activate_Product) run() rt.PhpVal {
	mut var_product_id := rt.call_method(this.state, 'get_product_id', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_string('plugin'), rt.call_method(this.state,
		'get_product_type', []rt.PhpVal{})))
	{
		this.activate_plugin(var_product_id.clone())
	} else {
		this.activate_theme(var_product_id.clone())
	}
	return this.state
}

fn (mut this Class_WC_WCCOM_Site_Installation_Step_Activate_Product) activate_plugin(var_product_id rt.PhpVal) {
	mut var_product_id_mutated := var_product_id
	rt.call_function('wp_clean_plugins_cache', []rt.PhpVal{})
	mut var_filename := rt.new_bool(false)
	mut var_dir_name := rt.new_bool(this.get_wporg_product_dir_name())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_dir_name)))) {
		mut iife_temp_0 := Class_WC_WCCOM_Site_Installer{}
		mut iife_result_0 := iife_temp_0.get_wporg_plugin_main_file(var_dir_name.clone())
		var_filename = iife_result_0
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_filename)) {
		mut iife_temp_1 := Class_WC_Helper{}
		mut iife_result_1 := iife_temp_1.get_local_woo_plugins()
		mut iife_temp_2 := Class_WC_Helper{}
		mut iife_result_2 := iife_temp_2.get_local_woo_plugins()
		mut var_plugins := rt.call_function('wp_list_filter', [iife_result_1,
			rt.create_array([
				rt.ArrayItem{ key: '_product_id', val: var_product_id_mutated },
			])])
		var_filename = if var_plugins.clone().is_array() && !(!rt.is_true(var_plugins)) { rt.call_function('key', [
				var_plugins.clone(),
			]) } else { rt.new_string('') }
	}
	if !rt.is_true(var_filename)
		&& !(!rt.is_true(rt.call_method(this.state, 'get_installed_path', []rt.PhpVal{}))) {
		mut iife_temp_3 := Class_WC_WCCOM_Site_Installer{}
		mut iife_result_3 := iife_temp_3.get_wporg_plugin_main_file(rt.call_function('basename', [
			rt.call_method(this.state, 'get_installed_path', []rt.PhpVal{}),
		]))
		var_filename = iife_result_3
	}
	if !rt.is_true(var_filename) {
		rt.throw_exception(rt.new_object('WC_REST_WCCOM_Site_Installer_Error', []string{},
			create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.unknown_filename())))
	}
	if rt.is_true(rt.call_function('is_plugin_active', [var_filename.clone()])) {
		mut iife_temp_4 := Class_WC_Helper{}
		mut iife_result_4 := iife_temp_4.activated_plugin(var_filename.clone())
	}
	mut var_result := rt.call_function('activate_plugin', [var_filename.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		rt.throw_exception(rt.new_object('WC_REST_WCCOM_Site_Installer_Error', []string{}, create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.plugin_activation_error(), rt.call_method(var_result,
			'get_error_message', []rt.PhpVal{}))))
	}
}

fn (mut this Class_WC_WCCOM_Site_Installation_Step_Activate_Product) activate_theme(var_product_id rt.PhpVal) {
	mut var_product_id_mutated := var_product_id
	rt.call_function('wp_clean_themes_cache', []rt.PhpVal{})
	mut var_theme_slug := rt.new_bool(false)
	mut var_dir_name := rt.new_bool(this.get_wporg_product_dir_name())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_dir_name)))) {
		var_theme_slug = rt.call_function('basename', [var_dir_name.clone()])
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_theme_slug)) {
		mut iife_temp_5 := Class_WC_Helper{}
		mut iife_result_5 := iife_temp_5.get_local_woo_themes()
		mut iife_temp_6 := Class_WC_Helper{}
		mut iife_result_6 := iife_temp_6.get_local_woo_themes()
		mut var_themes := rt.call_function('wp_list_filter', [iife_result_5,
			rt.create_array([
				rt.ArrayItem{ key: '_product_id', val: var_product_id_mutated },
			])])
		var_theme_slug = if var_themes.clone().is_array() && !(!rt.is_true(var_themes)) { rt.call_function('dirname', [
				rt.call_function('key', [var_themes.clone()]),
			]) } else { rt.new_string('') }
	}
	if !rt.is_true(var_theme_slug)
		&& !(!rt.is_true(rt.call_method(this.state, 'get_installed_path', []rt.PhpVal{}))) {
		var_theme_slug = rt.call_function('basename', [
			rt.call_method(this.state, 'get_installed_path', []rt.PhpVal{}),
		])
	}
	if !rt.is_true(var_theme_slug) {
		rt.throw_exception(rt.new_object('WC_REST_WCCOM_Site_Installer_Error', []string{},
			create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.unknown_filename())))
	}
	rt.call_function('switch_theme', [var_theme_slug.clone()])
}

fn (mut this Class_WC_WCCOM_Site_Installation_Step_Activate_Product) get_wporg_product_dir_name() bool {
	if !rt.is_true(rt.call_method(this.state, 'get_installed_path', []rt.PhpVal{})) {
		return false
	}
	mut var_download_url := rt.call_method(this.state, 'get_download_url', []rt.PhpVal{})
	mut var_parsed_url := rt.call_function('wp_parse_url', [var_download_url.clone()])
	if !(!rt.is_true(var_parsed_url.array_get(rt.new_string('host'))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('downloads.wordpress.org'), var_parsed_url.array_get(rt.new_string('host')))))) {
		return false
	}
	return (rt.call_function('basename', [
		rt.call_method(this.state, 'get_installed_path', []rt.PhpVal{}),
	])).to_bool()
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
		state:         rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wc_wccom_site_installer(_args ...rt.PhpVal) &Class_WC_WCCOM_Site_Installer {
	mut obj := &Class_WC_WCCOM_Site_Installer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper(_args ...rt.PhpVal) &Class_WC_Helper {
	mut obj := &Class_WC_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_rest_wccom_site_installer_error(_args ...rt.PhpVal) &Class_WC_REST_WCCOM_Site_Installer_Error {
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
		else {
			return none
		}
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
		'state' {
			this.state = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
