import rt

struct Class_Automattic_WooCommerce_Admin_PluginsInstaller {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Admin_PluginsInstaller.init() {
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'possibly_install_activate_plugins' }])])
}

fn Class_Automattic_WooCommerce_Admin_PluginsInstaller.possibly_install_activate_plugins() {
	if !(rt.get_superglobal('_GET').array_isset(rt.new_string('plugin_action')))
		|| !(rt.get_superglobal('_GET').array_isset(rt.new_string('plugins')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_plugins')])))))
		|| !(rt.get_superglobal('_GET').array_isset(rt.new_string('nonce'))) {
		return
	}
	mut var_nonce := rt.call_function('sanitize_text_field', [
		rt.call_function('wp_unslash',
			[rt.get_superglobal('_GET').array_get(rt.new_string('nonce'))]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [
		var_nonce.clone(),
		rt.new_string('install-plugin'),
	])))))
	{
		rt.call_function('wp_nonce_ays', [rt.new_string('install-plugin')])
	}
	mut var_plugins := rt.call_function('sanitize_text_field', [
		rt.call_function('wp_unslash',
			[rt.get_superglobal('_GET').array_get(rt.new_string('plugins'))]),
	])
	mut var_plugin_action := rt.call_function('sanitize_text_field', [
		rt.call_function('wp_unslash',
			[rt.get_superglobal('_GET').array_get(rt.new_string('plugin_action'))]),
	])
	mut var_plugins_api := create_automattic_woocommerce_admin_api_plugins()
	mut var_install_result := rt.new_null()
	mut var_activate_result := rt.new_null()
	mut switch_val_1 := var_plugin_action
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('install'))) {
		var_install_result = var_plugins_api.install_plugins(rt.create_array([
			rt.ArrayItem{ key: 'plugins', val: var_plugins },
		]))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('activate'))) {
		var_activate_result = var_plugins_api.activate_plugins(rt.create_array([
			rt.ArrayItem{ key: 'plugins', val: var_plugins },
		]))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('install-activate'))) {
		var_install_result = var_plugins_api.install_plugins(rt.create_array([
			rt.ArrayItem{ key: 'plugins', val: var_plugins },
		]))
		var_activate_result = var_plugins_api.activate_plugins(rt.create_array([
			rt.ArrayItem{ key: 'plugins', val: rt.call_function('implode', [
				rt.new_string(','),
				var_install_result.array_get(rt.new_string('data')).array_get(rt.new_string('installed')),
			]) },
		]))
	}
	Class_Automattic_WooCommerce_Admin_PluginsInstaller.cache_results(var_plugins.clone(),
		var_install_result.clone(), var_activate_result.clone())
	Class_Automattic_WooCommerce_Admin_PluginsInstaller.redirect_to_referer()
}

fn Class_Automattic_WooCommerce_Admin_PluginsInstaller.cache_results(var_plugins rt.PhpVal, var_install_result rt.PhpVal, var_activate_result rt.PhpVal) {
	mut var_plugins_mutated := var_plugins
	mut var_install_result_mutated := var_install_result
	mut var_activate_result_mutated := var_activate_result
	if rt.is_true(rt.new_bool(!(rt.is_true(var_install_result_mutated))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_activate_result_mutated)))) {
		return
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_install_result_mutated.clone()]))
		|| rt.is_true(rt.call_function('is_wp_error', [var_activate_result_mutated.clone()])) {
		mut var_message := if rt.is_true(var_activate_result_mutated) {
			rt.call_method(var_activate_result_mutated, 'get_error_message', []rt.PhpVal{})
		} else {
			rt.call_method(var_install_result_mutated, 'get_error_message', []rt.PhpVal{})
		}
	} else {
		var_message = if rt.is_true(var_activate_result_mutated) {
			var_activate_result_mutated.array_get(rt.new_string('message'))
		} else {
			var_install_result_mutated.array_get(rt.new_string('message'))
		}
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_TransientNotices{}
	mut iife_result_0 := iife_temp_0.add(rt.create_array([
		rt.ArrayItem{ key: 'user_id', val: rt.call_function('get_current_user_id', []rt.PhpVal{}) },
		rt.ArrayItem{
			key: 'id'
			val: 'plugin-installer-' +(rt.call_function('str_replace', [rt.new_string(','), rt.new_string('-'), var_plugins_mutated.clone()])).str()
		},
		rt.ArrayItem{ key: 'status', val: 'success' },
		rt.ArrayItem{ key: 'content', val: var_message },
	]))
}

fn Class_Automattic_WooCommerce_Admin_PluginsInstaller.redirect_to_referer() {
	mut var_referer := rt.call_function('wp_get_referer', []rt.PhpVal{})
	if rt.is_true(var_referer)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_referer.clone(), rt.call_function('wp_login_url', []rt.PhpVal{})]))))) {
		rt.call_function('wp_safe_redirect', [var_referer.clone()])
		exit(0)
	}
	if !(rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_URI'))) {
		return
	}
	mut var_url := rt.call_function('remove_query_arg', [rt.new_string('plugin_action'),
		rt.call_function('wp_unslash',
			[rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))])])
	var_url = rt.call_function('remove_query_arg', [rt.new_string('plugins'),
		var_url.clone()])
	rt.call_function('wp_safe_redirect', [var_url.clone()])
	exit(0)
}

struct Class_Automattic_WooCommerce_Admin_API_Plugins {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_TransientNotices {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_pluginsinstaller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_PluginsInstaller {
	mut obj := &Class_Automattic_WooCommerce_Admin_PluginsInstaller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_plugins(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Plugins {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Plugins{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_transientnotices(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_TransientNotices {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_TransientNotices{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsInstaller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_Automattic_WooCommerce_Admin_PluginsInstaller.init()
			return rt.new_null()
		}
		'possibly_install_activate_plugins' {
			Class_Automattic_WooCommerce_Admin_PluginsInstaller.possibly_install_activate_plugins()
			return rt.new_null()
		}
		'cache_results' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_PluginsInstaller.cache_results(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'redirect_to_referer' {
			Class_Automattic_WooCommerce_Admin_PluginsInstaller.redirect_to_referer()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_PluginsInstaller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsInstaller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Plugins) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_TransientNotices) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_TransientNotices) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_TransientNotices) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
