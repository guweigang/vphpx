import rt

struct Class_WC_Helper_Compat {
	rt.PhpObjectBase
}

fn Class_WC_Helper_Compat.load() {
	rt.call_function('add_action', [rt.new_string('woocommerce_helper_loaded'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'helper_loaded' }])])
}

fn Class_WC_Helper_Compat.helper_loaded() {
	mut var_GLOBALS := rt.new_null()
	rt.call_function('remove_action', [rt.new_string('admin_notices'),
		rt.new_string('woothemes_updater_notice')])
	rt.call_function('add_action', [rt.new_string('admin_menu'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'admin_menu' }])])
	if !rt.is_true(var_GLOBALS.array_get(rt.new_string('woothemes_updater'))) {
		return
	}
	Class_WC_Helper_Compat.remove_actions()
	Class_WC_Helper_Compat.migrate_connection()
	Class_WC_Helper_Compat.deactivate_plugin()
}

fn Class_WC_Helper_Compat.remove_actions() {
	mut var_GLOBALS := rt.new_null()
	rt.call_function('remove_action', [rt.new_string('network_admin_notices'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.get_property(var_GLOBALS.array_get(rt.new_string('woothemes_updater')),
				'admin') },
			rt.ArrayItem{ key: none, val: 'maybe_display_activation_notice' },
		])])
	rt.call_function('remove_action', [rt.new_string('admin_notices'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.get_property(var_GLOBALS.array_get(rt.new_string('woothemes_updater')),
				'admin') },
			rt.ArrayItem{ key: none, val: 'maybe_display_activation_notice' },
		])])
	rt.call_function('remove_action', [rt.new_string('network_admin_menu'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.get_property(var_GLOBALS.array_get(rt.new_string('woothemes_updater')),
				'admin') },
			rt.ArrayItem{ key: none, val: 'register_settings_screen' },
		])])
	rt.call_function('remove_action', [rt.new_string('admin_menu'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.get_property(var_GLOBALS.array_get(rt.new_string('woothemes_updater')),
				'admin') },
			rt.ArrayItem{ key: none, val: 'register_settings_screen' },
		])])
}

fn Class_WC_Helper_Compat.migrate_connection() {
	mut iife_temp_0 := Class_WC_Helper_Options{}
	mut iife_result_0 := iife_temp_0.get(rt.new_string('did-migrate'))
	if rt.is_true(iife_result_0) {
		return
	}
	mut iife_temp_1 := Class_WC_Helper_Options{}
	mut iife_result_1 := iife_temp_1.get(rt.new_string('auth'))
	mut var_auth := iife_result_1
	if !(!rt.is_true(var_auth)) {
		return
	}
	mut iife_temp_2 := Class_WC_Helper{}
	mut iife_result_2 := iife_temp_2.log(rt.new_string('Attempting oauth/migrate'))
	mut iife_temp_3 := Class_WC_Helper_Options{}
	mut iife_result_3 := iife_temp_3.update(rt.new_string('did-migrate'), rt.new_bool(true))
	mut var_master_key := rt.call_function('get_option', [
		rt.new_string('woothemes_helper_master_key'),
	])
	if !rt.is_true(var_master_key) {
		mut iife_temp_4 := Class_WC_Helper{}
		mut iife_result_4 := iife_temp_4.log(rt.new_string('Master key not found, aborting'))
		return
	}
	mut iife_temp_5 := Class_WC_Helper_API{}
	mut iife_result_5 := iife_temp_5.post(rt.new_string('oauth/migrate'), rt.create_array([
		rt.ArrayItem{ key: 'body', val: rt.create_array([
			rt.ArrayItem{ key: 'home_url', val: rt.call_function('home_url', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'master_key', val: var_master_key },
		]) },
	]))
	mut var_request := iife_result_5
	if rt.is_true(rt.call_function('is_wp_error', [var_request.clone()]))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('wp_remote_retrieve_response_code', [var_request.clone()]), rt.new_int(200))))) {
		mut iife_temp_6 := Class_WC_Helper{}
		mut iife_result_6 :=
			iife_temp_6.log(rt.new_string('Call to oauth/migrate returned a non-200 response code'))
		return
	}
	mut var_request_token := rt.call_function('json_decode', [
		rt.call_function('wp_remote_retrieve_body', [var_request.clone()]),
	])
	if !rt.is_true(var_request_token) {
		mut iife_temp_7 := Class_WC_Helper{}
		mut iife_result_7 :=
			iife_temp_7.log(rt.new_string('Call to oauth/migrate returned an empty token'))
		return
	}
	mut iife_temp_8 := Class_WC_Helper_API{}
	mut iife_result_8 := iife_temp_8.post(rt.new_string('oauth/access_token'), rt.create_array([
		rt.ArrayItem{ key: 'body', val: rt.create_array([
			rt.ArrayItem{ key: 'request_token', val: var_request_token },
			rt.ArrayItem{ key: 'home_url', val: rt.call_function('home_url', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'migrate', val: true },
		]) },
	]))
	var_request = iife_result_8
	if rt.is_true(rt.call_function('is_wp_error', [var_request.clone()]))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('wp_remote_retrieve_response_code', [var_request.clone()]), rt.new_int(200))))) {
		mut iife_temp_9 := Class_WC_Helper{}
		mut iife_result_9 :=
			iife_temp_9.log(rt.new_string('Call to oauth/access_token returned a non-200 response code'))
		return
	}
	mut var_access_token := rt.call_function('json_decode', [
		rt.call_function('wp_remote_retrieve_body', [var_request.clone()]),
		rt.new_bool(true),
	])
	if !rt.is_true(var_access_token) {
		mut iife_temp_10 := Class_WC_Helper{}
		mut iife_result_10 :=
			iife_temp_10.log(rt.new_string('Call to oauth/access_token returned an invalid token'))
		return
	}
	mut iife_temp_11 := Class_WC_Helper_Options{}
	mut iife_result_11 := iife_temp_11.update(rt.new_string('auth'), rt.create_array([
		rt.ArrayItem{
			key: 'access_token'
			val: var_access_token.array_get(rt.new_string('access_token'))
		},
		rt.ArrayItem{
			key: 'access_token_secret'
			val: var_access_token.array_get(rt.new_string('access_token_secret'))
		},
		rt.ArrayItem{ key: 'site_id', val: var_access_token.array_get(rt.new_string('site_id')) },
		rt.ArrayItem{ key: 'user_id', val: rt.new_null() },
		rt.ArrayItem{ key: 'updated', val: rt.call_function('time', []rt.PhpVal{}) },
	]))
	mut iife_temp_12 := Class_WC_Helper{}
	mut iife_result_12 := iife_temp_12._flush_authentication_cache()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_12)))) {
		mut iife_temp_13 := Class_WC_Helper{}
		mut iife_result_13 :=
			iife_temp_13.log(rt.new_string('Could not obtain connected user info in migrate_connection'))
		mut iife_temp_14 := Class_WC_Helper_Options{}
		mut iife_result_14 := iife_temp_14.update(rt.new_string('auth'), rt.new_array())
		return
	}
}

fn Class_WC_Helper_Compat.deactivate_plugin() {
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '2')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('deactivate_plugins'),
	])))))
	{
		return
	}
	if rt.is_true(rt.call_function('is_plugin_active', [
		rt.new_string('woothemes-updater/woothemes-updater.php'),
	]))
	{
		rt.call_function('deactivate_plugins', [
			rt.new_string('woothemes-updater/woothemes-updater.php'),
		])
		rt.call_function('add_action', [rt.new_string('pre_current_active_plugins'),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'plugin_deactivation_notice' }])])
	}
}

fn Class_WC_Helper_Compat.plugin_deactivation_notice() {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('The WooCommerce Helper plugin is no longer needed. <a href="%s">Manage subscriptions</a> from the extensions tab instead.'),
			rt.new_string('woocommerce'),
		]),
		rt.call_function('esc_url', [
			rt.call_function('admin_url', [
				rt.new_string('admin.php?page=wc-addons&section=helper'),
			]),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
}

fn Class_WC_Helper_Compat.admin_menu() {
	mut var_master_key := rt.call_function('get_option', [
		rt.new_string('woothemes_helper_master_key'),
	])
	if !rt.is_true(var_master_key) {
		return
	}
	mut iife_temp_15 := Class_WC_Helper_Options{}
	mut iife_result_15 := iife_temp_15.get(rt.new_string('auth'))
	mut var_auth := iife_result_15
	if !(!rt.is_true(var_auth.array_get(rt.new_string('user_id')))) {
		return
	}
	rt.call_function('add_dashboard_page', [
		rt.call_function('__', [rt.new_string('WooCommerce Helper'),
			rt.new_string('woocommerce')]),
		rt.call_function('__', [rt.new_string('WooCommerce Helper'),
			rt.new_string('woocommerce')]),
		rt.new_string('manage_options'),
		rt.new_string('woothemes-helper'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'render_compat_menu' }]),
	])
}

fn Class_WC_Helper_Compat.render_compat_menu() {
	mut var_helper_url := rt.call_function('add_query_arg', [
		rt.create_array([rt.ArrayItem{ key: 'page', val: 'wc-addons' },
			rt.ArrayItem{ key: 'section', val: 'helper' }]),
		rt.call_function('admin_url', [rt.new_string('admin.php')]),
	])
	mut iife_temp_16 := Class_WC_Helper{}
	mut iife_result_16 := iife_temp_16.get_view_filename(rt.new_string('html-helper-compat.php'))
	rt.include_file(iife_result_16.to_string(), '1')
}

struct Class_WC_Helper_Options {
	rt.PhpObjectBase
}

struct Class_WC_Helper {
	rt.PhpObjectBase
}

struct Class_WC_Helper_API {
	rt.PhpObjectBase
}

fn create_wc_helper_compat(_args ...rt.PhpVal) &Class_WC_Helper_Compat {
	mut obj := &Class_WC_Helper_Compat{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper_options(_args ...rt.PhpVal) &Class_WC_Helper_Options {
	mut obj := &Class_WC_Helper_Options{
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

fn create_wc_helper_api(_args ...rt.PhpVal) &Class_WC_Helper_API {
	mut obj := &Class_WC_Helper_API{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Helper_Compat) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'load' {
			Class_WC_Helper_Compat.load()
			return rt.new_null()
		}
		'helper_loaded' {
			Class_WC_Helper_Compat.helper_loaded()
			return rt.new_null()
		}
		'remove_actions' {
			Class_WC_Helper_Compat.remove_actions()
			return rt.new_null()
		}
		'migrate_connection' {
			Class_WC_Helper_Compat.migrate_connection()
			return rt.new_null()
		}
		'deactivate_plugin' {
			Class_WC_Helper_Compat.deactivate_plugin()
			return rt.new_null()
		}
		'plugin_deactivation_notice' {
			Class_WC_Helper_Compat.plugin_deactivation_notice()
			return rt.new_null()
		}
		'admin_menu' {
			Class_WC_Helper_Compat.admin_menu()
			return rt.new_null()
		}
		'render_compat_menu' {
			Class_WC_Helper_Compat.render_compat_menu()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Helper_Compat) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_Compat) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Helper_Options) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper_Options) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_Options) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Helper_API) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper_API) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_API) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	Class_WC_Helper_Compat.load()
}
