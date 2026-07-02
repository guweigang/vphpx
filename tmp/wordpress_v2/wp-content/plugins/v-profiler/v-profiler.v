import rt

fn v_debug(var_var rt.PhpVal, label string) {
	mut var_label := label
	mut iife_temp_3 := Class_VHttpd_WordPress_Profiler{}
	mut iife_result_3 := iife_temp_3.log(var_var.clone(), rt.new_string(label),
		rt.new_string('debug'))
}

fn v_log(message string, label string) {
	mut var_message := message
	mut var_label := label
	mut iife_temp_4 := Class_VHttpd_WordPress_Profiler{}
	mut iife_result_4 := iife_temp_4.log(rt.new_string(message), rt.new_string(label),
		rt.new_string('info'))
}

fn v_profiler_activate_plugin() {
	mut iife_temp_12 := Class_VHttpd_WordPress_ProfilerEnv{}
	mut iife_result_12 := iife_temp_12.activate()
}

fn v_profiler_deactivate_plugin() {
	mut iife_temp_13 := Class_VHttpd_WordPress_ProfilerEnv{}
	mut iife_result_13 := iife_temp_13.deactivate()
}

struct Class_VHttpd_WordPress_Profiler {
	rt.PhpObjectBase
}

struct Class_VHttpd_WordPress_ProfilerEnv {
	rt.PhpObjectBase
}

fn create_vhttpd_wordpress_profiler(_args ...rt.PhpVal) &Class_VHttpd_WordPress_Profiler {
	mut obj := &Class_VHttpd_WordPress_Profiler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_vhttpd_wordpress_profilerenv(_args ...rt.PhpVal) &Class_VHttpd_WordPress_ProfilerEnv {
	mut obj := &Class_VHttpd_WordPress_ProfilerEnv{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_VHttpd_WordPress_Profiler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_VHttpd_WordPress_Profiler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_WordPress_Profiler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_VHttpd_WordPress_ProfilerEnv) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_VHttpd_WordPress_ProfilerEnv) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_WordPress_ProfilerEnv) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
	if rt.is_true(rt.call_function('version_compare', [rt.get_constant('PHP_VERSION'),
		rt.new_string('8.1.0'), rt.new_string('<')]))
	{
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			print('<div class="notice notice-error"><p>')
			print(
				'<strong>v-Profiler:</strong> This plugin requires PHP version 8.1.0 or higher. Your current PHP version is ' +
				(rt.call_function('esc_html', [rt.get_constant('PHP_VERSION')])).str() + '.')
			print('</p></div>')
			return rt.new_null()
		}
		rt.call_function('add_action', [rt.new_string('admin_notices'),
			rt.new_closure(closure_1_fn)])
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		Class_VHttpd_WordPress_Profiler.class(),
	])))))
	{
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_class := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_prefix := rt.new_string('VHttpd\\')
			if rt.is_true(rt.call_function('str_starts_with', [
				var_class.clone(), var_prefix.clone()]))
			{
				mut var_relative := rt.call_function('str_replace', [
					rt.new_string('\\'), rt.new_string('/'),
					rt.call_function('substr', [
						var_class.clone(),
						rt.new_int(var_prefix.clone().to_string().len),
					])])
				mut var_file := rt.new_string(@DIR + '/src/VHttpd/' + var_relative.str() + '.php')
				if rt.is_true(rt.call_function('is_file', [var_file.clone()])) {
					rt.include_file(var_file.to_string(), '4')
				}
			}
			return rt.new_null()
		}
		closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_class := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_prefix := rt.new_string('VHttpd\\')
			if rt.is_true(rt.call_function('str_starts_with', [
				var_class.clone(), var_prefix.clone()]))
			{
				mut var_relative := rt.call_function('str_replace', [
					rt.new_string('\\'), rt.new_string('/'),
					rt.call_function('substr', [
						var_class.clone(),
						rt.new_int(var_prefix.clone().to_string().len),
					])])
				mut var_file := rt.new_string(@DIR + '/src/VHttpd/' + var_relative.str() + '.php')
				if rt.is_true(rt.call_function('is_file', [var_file.clone()])) {
					rt.include_file(var_file.to_string(), '4')
				}
			}
			return rt.new_null()
		}
		rt.call_function('spl_autoload_register', [rt.new_closure(closure_2_fn)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('v_debug'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('v_log'),
	])))))
	{
	}
	mut iife_temp_5 := Class_VHttpd_WordPress_Profiler{}
	mut iife_result_5 := iife_temp_5.start()
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_userId := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_7 := Class_VHttpd_WordPress_Profiler{}
		mut iife_result_7 := iife_temp_7.start()
		return var_userId.clone()
	}
	rt.call_function('add_filter', [rt.new_string('determine_current_user'),
		rt.new_closure(closure_8_fn), rt.new_int(1)])
	closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_debug := rt.new_bool(
			rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG')]))
			&& rt.is_true(rt.get_constant('WP_DEBUG')))
		if rt.is_true(rt.call_function('defined', [rt.new_string('V_PROFILER_WIDGET_DISABLED')]))
			&& rt.is_true(rt.get_constant('V_PROFILER_WIDGET_DISABLED')) {
			mut iife_temp_9 := Class_VHttpd_WordPress_Profiler{}
			mut iife_result_9 := iife_temp_9.stopanddeactivate()
			return rt.new_null()
		}
		mut var_cookieName := rt.new_string('v_profiler_debug')
		mut var_cookieValue := rt.call_function('hash_hmac', [
			rt.new_string('sha256'), rt.new_string('v_profiler_auth_session'), if rt.is_true(rt.call_function('defined', [
				rt.new_string('SECURE_AUTH_KEY'),
			]))
			{ rt.get_constant('SECURE_AUTH_KEY') } else { rt.new_string('default_salt') }])
		if rt.get_superglobal('_GET').array_isset(rt.new_string('v_profiler_logout')) {
			mut var_cookiePath := if rt.is_true(rt.call_function('defined', [
				rt.new_string('COOKIEPATH'),
			]))
			{ rt.get_constant('COOKIEPATH') } else { rt.new_string('/') }
			mut var_cookieDomain := if rt.is_true(rt.call_function('defined', [
				rt.new_string('COOKIE_DOMAIN'),
			]))
			{ rt.get_constant('COOKIE_DOMAIN') } else { rt.new_string('') }
			mut var_isSecure := rt.call_function('is_ssl', []rt.PhpVal{})
			rt.call_function('setcookie', [var_cookieName.clone(),
				rt.new_string(''), rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.new_int(3600)),
				var_cookiePath.clone(), var_cookieDomain.clone(),
				var_isSecure.clone(), rt.new_bool(true)])
			rt.get_superglobal('_COOKIE').array_set(var_cookieName, '')
		}
		mut var_canManage := rt.call_function('current_user_can', [
			rt.new_string('manage_options'),
		])
		if rt.is_true(var_canManage) {
			var_cookiePath = if rt.is_true(rt.call_function('defined', [
				rt.new_string('COOKIEPATH'),
			]))
			{ rt.get_constant('COOKIEPATH') } else { rt.new_string('/') }
			var_cookieDomain = if rt.is_true(rt.call_function('defined', [
				rt.new_string('COOKIE_DOMAIN'),
			]))
			{ rt.get_constant('COOKIE_DOMAIN') } else { rt.new_string('') }
			var_isSecure = rt.call_function('is_ssl', []rt.PhpVal{})
			if !(rt.get_superglobal('_COOKIE').array_isset(var_cookieName))
				|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_superglobal('_COOKIE').array_get(var_cookieName), var_cookieValue)))) {
				rt.call_function('setcookie', [var_cookieName.clone(),
					var_cookieValue.clone(),
					rt.add(rt.call_function('time', []rt.PhpVal{}),
						3 * 24 * 3600),
					var_cookiePath.clone(), var_cookieDomain.clone(),
					var_isSecure.clone(), rt.new_bool(true)])
				rt.get_superglobal('_COOKIE').array_set(var_cookieName, var_cookieValue.clone())
			}
		}
		mut var_hasDebugCookie := rt.new_bool(false)
		if rt.get_superglobal('_COOKIE').array_isset(var_cookieName)
			&& rt.is_true(rt.identical(rt.get_superglobal('_COOKIE').array_get(var_cookieName), var_cookieValue)) {
			var_hasDebugCookie = rt.new_bool(true)
		}
		rt.call_function('error_log', [
			rt.call_function('sprintf', [
				rt.new_string('[v-Profiler] Auth Check: WP_DEBUG=%s, current_user_can(manage_options)=%s, has_debug_cookie=%s, request_uri=%s'),
				rt.new_string((if rt.is_true(var_debug) { 'true' } else { 'false' }).str()),
				rt.new_string((if rt.is_true(var_canManage) { 'true' } else { 'false' }).str()),
				rt.new_string((if rt.is_true(var_hasDebugCookie) { 'true' } else { 'false' }).str()),
				if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))).is_null() {
					rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))
				} else {
					rt.new_string('unknown')
				},
			]),
		])
		if rt.is_true(var_debug) && rt.is_true(var_canManage) || rt.is_true(var_hasDebugCookie) {
			mut iife_temp_10 := Class_VHttpd_WordPress_Profiler{}
			mut iife_result_10 := iife_temp_10.activate()
		} else {
			mut iife_temp_11 := Class_VHttpd_WordPress_Profiler{}
			mut iife_result_11 := iife_temp_11.stopanddeactivate()
		}
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('set_current_user'),
		rt.new_closure(closure_12_fn), rt.new_int(99)])
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		rt.include_file(@DIR + '/v-profiler/v-profiler-admin.php', '4')
	}
	rt.call_function('register_activation_hook', [rt.new_string(@FILE),
		rt.new_string('v_profiler_activate_plugin')])
	rt.call_function('register_deactivation_hook', [rt.new_string(@FILE),
		rt.new_string('v_profiler_deactivate_plugin')])
}
