import rt

pub fn Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger.log_endpoint() string {
	return 'https://public-api.wordpress.com/rest/v1.1/logstash'
}
pub fn Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger.rate_limit_id() string {
	return 'woocommerce_remote_logging'
}
pub fn Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger.rate_limit_delay() i64 {
	return 60
}
pub fn Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger.wc_new_version_transient() string {
	return 'woocommerce_new_version'
}
struct Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) handle(var_timestamp rt.PhpVal, var_level rt.PhpVal, var_message rt.PhpVal, var_context rt.PhpVal) bool {
	if !(this.should_handle(var_level.dup(), var_message.dup(), var_context.dup())) {
		return false
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return this.log(var_level.dup(), var_message.dup(), var_context.dup())
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_Logging_Throwable') {
		mut var_e := var_e_1.dup()
		rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.wc_get_logger() }(), 'error', ['Failed to handle the log: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.create_array([rt.ArrayItem{ key: 'source', val: 'remote-logging' }])])
		return false
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) get_formatted_log(var_level rt.PhpVal, var_message rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_log_data := rt.create_array([rt.ArrayItem{ key: 'feature', val: 'woocommerce_core' }, rt.ArrayItem{ key: 'severity', val: var_level }, rt.ArrayItem{ key: 'message', val: this.sanitize(var_message.dup()) }, rt.ArrayItem{ key: 'host', val: if !(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.wp_parse_url(arg_0, arg_1) }(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.home_url() }(), rt.get_constant('PHP_URL_HOST'))).is_null() { fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.wp_parse_url(arg_0, arg_1) }(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.home_url() }(), rt.get_constant('PHP_URL_HOST')) } else { rt.new_string('Unable to retrieve host') } }, rt.ArrayItem{ key: 'tags', val: rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce' }, rt.ArrayItem{ key: none, val: 'php' }]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'wc_version', val: this.get_wc_version() }, rt.ArrayItem{ key: 'php_version', val: rt.call_function('phpversion', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'wp_version', val: if !(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.get_bloginfo(arg_0) }(rt.new_string('version'))).is_null() { fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.get_bloginfo(arg_0) }(rt.new_string('version')) } else { rt.new_string('Unable to retrieve wp version') } }, rt.ArrayItem{ key: 'request_uri', val: this.sanitize_request_uri(rt.call_function('filter_input', [rt.get_constant('INPUT_SERVER'), rt.new_string('REQUEST_URI'), rt.get_constant('FILTER_SANITIZE_URL')])) }, rt.ArrayItem{ key: 'store_id', val: if !(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.get_option(arg_0, arg_1) }(Class_Automattic_WooCommerce_Internal_Logging_WC_Install.store_id_option(), rt.new_null())).is_null() { fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.get_option(arg_0, arg_1) }(Class_Automattic_WooCommerce_Internal_Logging_WC_Install.store_id_option(), rt.new_null()) } else { rt.new_string('Unable to retrieve store id') } }]) }])
	mut var_blog_id := if rt.is_true(rt.call_function('class_exists', [rt.new_string('Jetpack_Options')])) { fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Jetpack_Options{}; return temp.get_option(arg_0) }(rt.new_string('id')) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_blog_id)) && rt.is_true(rt.new_bool(var_blog_id.dup().is_long())))) {
		var_log_data.array_set('blog_id', var_blog_id.dup())
	}
	if var_context.array_isset(rt.new_string('backtrace')) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_context.array_get('backtrace').is_array())) || rt.is_true(rt.new_bool(var_context.array_get('backtrace').is_string())))) {
			var_log_data.array_set('trace', this.sanitize_trace(var_context.array_get('backtrace')))
		} else if rt.is_true(rt.identical(rt.new_bool(true), var_context.array_get('backtrace'))) {
			var_log_data.array_set('trace', this.sanitize_trace(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger{}; return temp.get_backtrace() }()))
		}
		var_context.array_unset(rt.new_string('backtrace'))
	}
	if rt.is_true(rt.new_bool(var_context.array_isset(rt.new_string('tags')) && rt.is_true(rt.new_bool(var_context.array_get('tags').is_array())))) {
		var_log_data.array_set('tags', rt.call_function('array_merge', [var_log_data.array_get('tags'), var_context.array_get('tags')]))
		var_context.array_unset(rt.new_string('tags'))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_context.array_get('error').array_isset(rt.new_string('file')) && rt.is_true(rt.new_bool(var_context.array_get('error').array_get('file').is_string())))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_log_data.array_set('file', this.normalize_paths((var_context.array_get('error').array_get('file')).str()))
		var_context.array_get('error').array_unset(rt.new_string('file'))
	}
	mut var_extra_attrs := if !(var_context.array_get('extra')).is_null() { var_context.array_get('extra') } else { rt.new_array() }
	var_context.array_unset(rt.new_string('extra'))
	var_context.array_unset(rt.new_string('remote-logging'))
	var_log_data.array_set('extra', rt.call_function('array_merge', [var_extra_attrs.dup(), var_context.dup()]))
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_remote_logger_formatted_log_data'), var_log_data.dup(), var_level.dup(), var_message.dup(), var_context.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) is_remote_logging_allowed() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('remote_logging')))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_WC_Site_Tracking{}; return temp.is_tracking_enabled() }())))) {
		return false
	}
	if !(this.should_current_version_be_logged()) {
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) should_handle(var_level rt.PhpVal, var_message rt.PhpVal, var_context rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(var_context.array_isset(rt.new_string('remote-logging'))) || rt.is_true(rt.identical(rt.new_bool(false), var_context.array_get('remote-logging'))))) {
		return false
	}
	if !(this.is_remote_logging_allowed()) {
		return false
	}
	if this.is_third_party_error((// unsupported expression: Expr_Cast_String).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Logging_array](rt.cast_array(var_context))) {
		return false
	}
	if rt.is_true(rt.greater_equal(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Log_Levels{}; return temp.get_level_severity(arg_0) }(var_level.dup()), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Log_Levels{}; return temp.get_level_severity(arg_0) }(Class_WC_Log_Levels.critical()))) {
		mut var_mc_stats := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_McStats.class()])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		rt.call_method(var_mc_stats, 'add', [rt.new_string('error'), rt.new_string('critical-errors')])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		rt.call_method(var_mc_stats, 'do_server_side_stats', []rt.PhpVal{})
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		unsafe { goto end_label_2 }

catch_label_2:
		mut var_e_2 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Internal_Logging_Throwable') {
			mut var_e := var_e_2.dup()
			rt.call_function('error_log', ['Warning: Failed to record fatal error stats: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()])
			// unsupported statement: Stmt_Nop
			unsafe { goto end_label_2 }
		}
		else {
			rt.throw_exception(var_e_2)
			unsafe { goto end_label_2 }
		}

end_label_2:
	}
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Rate_Limiter{}; return temp.retried_too_soon(arg_0) }(Class_Automattic_WooCommerce_Internal_Logging_Automattic_WooCommerce_Internal_Logging_RemoteLogger.rate_limit_id())) {
		rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.wc_get_logger() }(), 'warning', [rt.new_string('Remote logging throttled.'), rt.create_array([rt.ArrayItem{ key: 'source', val: 'remote-logging' }])])
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) log(var_level rt.PhpVal, var_message rt.PhpVal, var_context rt.PhpVal) bool {
	mut var_log_data := this.get_formatted_log(var_level.dup(), var_message.dup(), var_context.dup())
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_log_data.dup().is_array()))))) || !rt.is_true(var_log_data.array_get('message')))) || !rt.is_true(var_log_data.array_get('feature')))) {
		return false
	}
	mut var_body := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.wp_json_encode(arg_0) }(rt.create_array([rt.ArrayItem{ key: 'params', val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.wp_json_encode(arg_0) }(var_log_data.dup()) }]))
	if rt.is_true(rt.new_bool(var_body.dup().is_null())) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Logging_Error', []string{}, create_automattic_woocommerce_internal_logging_error(rt.new_string('Remote Logger encountered error while attempting to JSON encode $log_data'))))
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Rate_Limiter{}; return temp.set_rate_limit(arg_0, arg_1) }(Class_Automattic_WooCommerce_Internal_Logging_Automattic_WooCommerce_Internal_Logging_RemoteLogger.rate_limit_id(), Class_Automattic_WooCommerce_Internal_Logging_Automattic_WooCommerce_Internal_Logging_RemoteLogger.rate_limit_delay())
	if rt.is_true(this.is_dev_or_local_environment()) {
		return false
	}
	mut var_response := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.wp_safe_remote_post(arg_0, arg_1) }(Class_Automattic_WooCommerce_Internal_Logging_Automattic_WooCommerce_Internal_Logging_RemoteLogger.log_endpoint(), rt.create_array([rt.ArrayItem{ key: 'body', val: var_body }, rt.ArrayItem{ key: 'timeout', val: 3 }, rt.ArrayItem{ key: 'headers', val: rt.create_array([rt.ArrayItem{ key: 'Content-Type', val: 'application/json' }]) }, rt.ArrayItem{ key: 'blocking', val: false }]))
	if rt.is_true(rt.new_bool(var_response.dup().is_null())) {
		rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.wc_get_logger() }(), 'error', [rt.new_string('Failed to call wp_safe_remote_post while sending the log to the remote logging service.'), rt.create_array([rt.ArrayItem{ key: 'source', val: 'remote-logging' }])])
		return false
	}
	mut var_is_api_call_error := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.is_wp_error(arg_0) }(var_response.dup())
	if rt.is_true(var_is_api_call_error) {
		rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.wc_get_logger() }(), 'error', ['Failed to send the log to the remote logging service: ' + (rt.call_method(var_response, 'get_error_message', []rt.PhpVal{})).str(), rt.create_array([rt.ArrayItem{ key: 'source', val: 'remote-logging' }])])
		return false
	} else if rt.is_true(rt.new_bool(var_is_api_call_error.dup().is_null())) {
		rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.wc_get_logger() }(), 'error', [rt.new_string('Failed to parse the response after sending log to the remote logging service. '), rt.create_array([rt.ArrayItem{ key: 'source', val: 'remote-logging' }])])
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) should_current_version_be_logged() bool {
	mut var_new_version := if !(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.get_site_transient(arg_0) }(Class_Automattic_WooCommerce_Internal_Logging_Automattic_WooCommerce_Internal_Logging_RemoteLogger.wc_new_version_transient())).is_null() { fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.get_site_transient(arg_0) }(Class_Automattic_WooCommerce_Internal_Logging_Automattic_WooCommerce_Internal_Logging_RemoteLogger.wc_new_version_transient()) } else { rt.new_string('') }
	if rt.is_true(rt.identical(rt.new_bool(false), var_new_version)) {
		var_new_version = this.fetch_new_woocommerce_version()
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.set_site_transient(arg_0, arg_1, arg_2) }(Class_Automattic_WooCommerce_Internal_Logging_Automattic_WooCommerce_Internal_Logging_RemoteLogger.wc_new_version_transient(), var_new_version.dup(), rt.get_constant('WEEK_IN_SECONDS'))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_new_version.dup().is_string()))))) || rt.is_true(rt.identical(rt.new_string(''), var_new_version)))) {
		return true
	}
	return (rt.call_function('version_compare', [this.get_wc_version(), var_new_version.dup(), rt.new_string('>=')])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) get_wc_version() rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('class_exists', [rt.new_string('\\Automattic\\Jetpack\\Constants')])) && rt.is_true(rt.call_function('method_exists', [rt.new_string('\\Automattic\\Jetpack\\Constants'), rt.new_string('get_constant')])))) {
		mut var_wc_version := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_VERSION'))
		if rt.is_true(var_wc_version) {
			return var_wc_version.dup()
		}
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('WC_VERSION')])) {
		return rt.get_constant('WC_VERSION')
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('WC')])) {
		return rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version')
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) is_third_party_error(message string, mut var_context Class_Automattic_WooCommerce_Internal_Logging_array) bool {
	if rt.is_true(rt.new_bool(!(var_context.array_isset(rt.new_string('source'))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return false
	}
	mut var_wc_plugin_dir := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_StringUtil{}; return temp.normalize_local_path_slashes(arg_0) }(rt.get_constant('WC_ABSPATH'))
	if rt.is_true(rt.call_function('str_contains', [rt.new_string(message), var_wc_plugin_dir.dup()])) {
		return false
	}
	if rt.is_true(rt.new_bool(var_context.array_isset(rt.new_string('backtrace')) && rt.is_true(rt.new_bool(var_context.array_get('backtrace').is_array())))) {
		mut var_wp_includes_dir := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_StringUtil{}; return temp.normalize_local_path_slashes(arg_0) }(rt.new_string((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str()))
		mut var_wp_admin_dir := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_StringUtil{}; return temp.normalize_local_path_slashes(arg_0) }(rt.new_string((rt.get_constant('ABSPATH')).str() + 'wp-admin'))
		mut var_relevant_frame := rt.new_null()
		{
			mut iter_1 := var_context.array_get('backtrace').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_frame := item_1.val
				if rt.is_true(rt.new_bool(!rt.is_true(var_frame) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_frame.dup().is_string()))))))) {
					continue
				}
				if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
					continue
				}
				var_relevant_frame = var_frame
				break
			}
		}
		if rt.is_true(rt.new_bool(rt.is_true(var_relevant_frame) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			return false
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('apply_filters')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/plugin.php', '4')
	}
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_remote_logging_is_third_party_error'), rt.new_bool(true), rt.new_string(message), var_context])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) fetch_new_woocommerce_version() rt.PhpVal {
	mut var_plugin_updates := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.get_plugin_updates() }()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_plugin_updates.dup().is_array()))))) || !(var_plugin_updates.array_isset(rt.get_constant('WC_PLUGIN_BASENAME'))))) {
		return rt.new_null()
	}
	mut var_wc_plugin_update := var_plugin_updates.array_get(rt.get_constant('WC_PLUGIN_BASENAME'))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_wc_plugin_update)))) || !(!(rt.get_property(rt.get_property(var_wc_plugin_update, 'update'), 'new_version')).is_null()))) {
		return rt.new_null()
	}
	mut var_new_version := rt.get_property(rt.get_property(var_wc_plugin_update, 'update'), 'new_version')
	return if rt.is_true(rt.new_bool(var_new_version.dup().is_string())) { var_new_version } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) sanitize(var_content rt.PhpVal) rt.PhpVal {
	mut var_content_mutated := var_content
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_content_mutated.dup().is_string()))))) {
		return var_content_mutated.dup()
	}
	mut var_sanitized := rt.new_string(this.normalize_paths((var_content_mutated).str()))
	var_sanitized = this.redact_user_data(var_sanitized.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('apply_filters')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/plugin.php', '4')
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_remote_logger_sanitized_content'), var_sanitized.dup(), var_content_mutated.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) normalize_paths(content string) string {
	mut content_mutated := content
	mut var_plugin_path := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_StringUtil{}; return temp.normalize_local_path_slashes(arg_0) }(rt.call_function('trailingslashit', []))
	mut var_wp_path := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_StringUtil{}; return temp.normalize_local_path_slashes(arg_0) }()
	return (rt.call_function('str_replace', [, , .dup()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) sanitize_trace(var_trace rt.PhpVal) string {
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) redact_user_data(var_content rt.PhpVal) rt.PhpVal {
	mut var_content_mutated := var_content
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) is_dev_or_local_environment() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) sanitize_request_uri(var_request_uri rt.PhpVal) rt.PhpVal {
	mut var_query_params := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) build_url(var_parsed_url rt.PhpVal) string {
	mut var_parsed_url_mutated := var_parsed_url
}

struct Class_Automattic_WooCommerce_Internal_Logging_WC_Log_Handler {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy {
	rt.PhpObjectBase
}

struct Class_Jetpack_Options {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

struct Class_WC_Site_Tracking {
	rt.PhpObjectBase
}

struct Class_WC_Log_Levels {
	rt.PhpObjectBase
}

struct Class_WC_Rate_Limiter {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Logging_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Logging_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_StringUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_logging_remotelogger() &Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger {
	mut obj := &Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_logging_wc_log_handler() &Class_Automattic_WooCommerce_Internal_Logging_WC_Log_Handler {
	mut obj := &Class_Automattic_WooCommerce_Internal_Logging_WC_Log_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_logging_safeglobalfunctionproxy() &Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy {
	mut obj := &Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_jetpack_options() &Class_Jetpack_Options {
	mut obj := &Class_Jetpack_Options{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil() &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_site_tracking() &Class_WC_Site_Tracking {
	mut obj := &Class_WC_Site_Tracking{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_log_levels() &Class_WC_Log_Levels {
	mut obj := &Class_WC_Log_Levels{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_rate_limiter() &Class_WC_Rate_Limiter {
	mut obj := &Class_WC_Rate_Limiter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_logging_error() &Class_Automattic_WooCommerce_Internal_Logging_Error {
	mut obj := &Class_Automattic_WooCommerce_Internal_Logging_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_logging_automattic_jetpack_constants() &Class_Automattic_WooCommerce_Internal_Logging_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_WooCommerce_Internal_Logging_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_stringutil() &Class_Automattic_WooCommerce_Utilities_StringUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_StringUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'handle' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_bool(this.handle(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'get_formatted_log' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_formatted_log(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'is_remote_logging_allowed' {
			return rt.new_bool(this.is_remote_logging_allowed())
		}
		'should_handle' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.should_handle(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'log' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.log(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'should_current_version_be_logged' {
			return rt.new_bool(this.should_current_version_be_logged())
		}
		'get_wc_version' {
			return this.get_wc_version()
		}
		'is_third_party_error' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Logging_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(this.is_third_party_error(dispatch_arg_0, mut dispatch_arg_1))
		}
		'fetch_new_woocommerce_version' {
			return this.fetch_new_woocommerce_version()
		}
		'sanitize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sanitize(dispatch_arg_0)
		}
		'normalize_paths' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.normalize_paths(dispatch_arg_0))
		}
		'sanitize_trace' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.sanitize_trace(dispatch_arg_0))
		}
		'redact_user_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.redact_user_data(dispatch_arg_0)
		}
		'is_dev_or_local_environment' {
			return this.is_dev_or_local_environment()
		}
		'sanitize_request_uri' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sanitize_request_uri(dispatch_arg_0)
		}
		'build_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.build_url(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Logging_WC_Log_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Logging_WC_Log_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_WC_Log_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Jetpack_Options) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Jetpack_Options) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Jetpack_Options) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Site_Tracking) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Site_Tracking) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Site_Tracking) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Log_Levels) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Log_Levels) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Log_Levels) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Rate_Limiter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Rate_Limiter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Rate_Limiter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Logging_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Logging_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Logging_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Logging_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_logging_remotelogger_php() {
	// unsupported statement: Stmt_Declare
}
