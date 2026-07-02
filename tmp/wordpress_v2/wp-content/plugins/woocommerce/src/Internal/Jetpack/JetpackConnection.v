import rt

struct Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_internal_jetpack_jetpackconnection() {
	rt.init_static_prop('Automattic_WooCommerce_Internal_Jetpack_JetpackConnection', 'manager',
		rt.new_null())
}

fn Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection.get_manager() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.get_static_prop('Automattic_WooCommerce_Internal_Jetpack_JetpackConnection',
		'manager'), 'Automattic_Jetpack_Connection_Manager'))))))
	{
		rt.set_static_prop('Automattic_WooCommerce_Internal_Jetpack_JetpackConnection', 'manager', rt.new_object('Automattic_Jetpack_Connection_Manager',
			[]string{}, create_automattic_jetpack_connection_manager(rt.new_string('woocommerce'))))
	}
	return rt.get_static_prop('Automattic_WooCommerce_Internal_Jetpack_JetpackConnection',
		'manager')
}

fn Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection.get_authorization_url(var_redirect_url rt.PhpVal, from string) rt.PhpVal {
	mut var_manager := Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection.get_manager()
	mut var_errors := create_wp_error()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_manager, 'is_connected',
		[]rt.PhpVal{})))))
	{
		mut var_result := rt.call_method(var_manager, 'try_registration', []rt.PhpVal{})
		if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
			var_errors.add(rt.call_method(var_result, 'get_error_code', []rt.PhpVal{}), rt.call_method(var_result,
				'get_error_message', []rt.PhpVal{}))
		}
	}
	mut var_calypso_env := if
		rt.is_true(rt.call_function('defined', [rt.new_string('WOOCOMMERCE_CALYPSO_ENVIRONMENT')]))
		&& rt.is_true(rt.call_function('in_array', [rt.get_constant('WOOCOMMERCE_CALYPSO_ENVIRONMENT'), rt.create_array([rt.ArrayItem{
		key: none
		val: 'development'
	}, rt.ArrayItem{ key: none, val: 'wpcalypso' }, rt.ArrayItem{ key: none, val: 'horizon' }, rt.ArrayItem{
		key: none
		val: 'stage'
	}]), rt.new_bool(true)])) {
		rt.get_constant('WOOCOMMERCE_CALYPSO_ENVIRONMENT')
	} else {
		rt.new_string('production')
	}
	mut var_authorization_url := rt.call_method(var_manager, 'get_authorization_url', [
		rt.new_null(),
		var_redirect_url.clone(),
	])
	var_authorization_url = rt.call_function('add_query_arg', [
		rt.new_string('locale'),
		Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection.get_wpcom_locale(),
		var_authorization_url.clone()])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_0 := iife_temp_0.is_enabled(rt.new_string('use-wp-horizon'))
	if rt.is_true(iife_result_0) {
		var_calypso_env = rt.new_string('horizon')
	}
	mut var_color_scheme := rt.call_function('get_user_option', [
		rt.new_string('admin_color'),
		rt.call_function('get_current_user_id', []rt.PhpVal{}),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_color_scheme)))) {
		var_color_scheme = rt.new_string('fresh')
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'success', val: !(rt.is_true(var_errors.has_errors())) },
		rt.ArrayItem{ key: 'errors', val: var_errors.get_error_messages() },
		rt.ArrayItem{ key: 'color_scheme', val: var_color_scheme },
		rt.ArrayItem{ key: 'url', val: rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'from', val: from },
				rt.ArrayItem{ key: 'calypso_env', val: var_calypso_env }]),
			var_authorization_url.clone(),
		]) },
	])
}

fn Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection.get_wpcom_locale() rt.PhpVal {
	mut var_locale_to_lang := rt.create_array([rt.ArrayItem{ key: 'bre', val: 'br' },
		rt.ArrayItem{ key: 'de_AT', val: 'de-at' }, rt.ArrayItem{ key: 'de_CH', val: 'de-ch' },
		rt.ArrayItem{ key: 'de', val: 'de_formal' }, rt.ArrayItem{ key: 'el', val: 'el-po' },
		rt.ArrayItem{ key: 'en_GB', val: 'en-gb' }, rt.ArrayItem{ key: 'es_CL', val: 'es-cl' },
		rt.ArrayItem{ key: 'es_MX', val: 'es-mx' }, rt.ArrayItem{ key: 'fr_BE', val: 'fr-be' },
		rt.ArrayItem{ key: 'fr_CA', val: 'fr-ca' }, rt.ArrayItem{ key: 'nl_BE', val: 'nl-be' },
		rt.ArrayItem{ key: 'nl', val: 'nl_formal' }, rt.ArrayItem{ key: 'pt_BR', val: 'pt-br' },
		rt.ArrayItem{ key: 'sr', val: 'sr_latin' }, rt.ArrayItem{ key: 'zh_CN', val: 'zh-cn' },
		rt.ArrayItem{ key: 'zh_HK', val: 'zh-hk' }, rt.ArrayItem{ key: 'zh_SG', val: 'zh-sg' },
		rt.ArrayItem{ key: 'zh_TW', val: 'zh-tw' }])
	mut var_system_locale := rt.call_function('get_locale', []rt.PhpVal{})
	if var_locale_to_lang.array_isset(var_system_locale) {
		return var_locale_to_lang.array_get(var_system_locale)
	}
	return rt.call_function('explode', [rt.new_string('_'), var_system_locale.clone()]).array_get(rt.new_int(0))
}

struct Class_Automattic_Jetpack_Connection_Manager {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_jetpack_jetpackconnection(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection {
	mut obj := &Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_connection_manager(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Connection_Manager {
	mut obj := &Class_Automattic_Jetpack_Connection_Manager{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_manager' {
			return Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection.get_manager()
		}
		'get_authorization_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection.get_authorization_url(dispatch_arg_0,
				dispatch_arg_1)
		}
		'get_wpcom_locale' {
			return Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection.get_wpcom_locale()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_Jetpack_Connection_Manager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Connection_Manager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Connection_Manager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
