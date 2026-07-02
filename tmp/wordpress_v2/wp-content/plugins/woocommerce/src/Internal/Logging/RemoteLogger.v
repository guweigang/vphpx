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
	if !(this.should_handle(var_level.clone(), var_message.clone(), var_context.clone())) {
		return false
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	return this.log(var_level.clone(), var_message.clone(), var_context.clone())
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_Logging_Throwable') {
		mut var_e := var_e_1.clone()
		mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
		mut iife_result_0 := iife_temp_0.wc_get_logger()
		rt.call_method(iife_result_0, 'error', [
			rt.new_string('Failed to handle the log: ' +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			rt.create_array([rt.ArrayItem{ key: 'source', val: 'remote-logging' }]),
		])
		return false
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) get_formatted_log(var_level rt.PhpVal, var_message rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
	mut iife_result_1 := iife_temp_1.home_url()
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
	mut iife_result_2 := iife_temp_2.wp_parse_url(iife_result_1, rt.get_constant('PHP_URL_HOST'))
	mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
	mut iife_result_3 := iife_temp_3.get_bloginfo(rt.new_string('version'))
	mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
	mut iife_result_4 := iife_temp_4.get_option(Class_Automattic_WooCommerce_Internal_Logging_WC_Install.store_id_option(),
		rt.new_null())
	mut var_log_data := rt.create_array([
		rt.ArrayItem{ key: 'feature', val: 'woocommerce_core' },
		rt.ArrayItem{ key: 'severity', val: var_level },
		rt.ArrayItem{ key: 'message', val: this.sanitize(var_message.clone()) },
		rt.ArrayItem{
			key: 'host'
			val: if !iife_result_2.is_null() {
				iife_result_2
			} else {
				rt.new_string('Unable to retrieve host')
			}
		},
		rt.ArrayItem{ key: 'tags', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce' },
			rt.ArrayItem{ key: none, val: 'php' },
		]) },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'wc_version', val: this.get_wc_version() },
			rt.ArrayItem{ key: 'php_version', val: rt.call_function('phpversion', []rt.PhpVal{}) },
			rt.ArrayItem{
				key: 'wp_version'
				val: if !iife_result_3.is_null() {
					iife_result_3
				} else {
					rt.new_string('Unable to retrieve wp version')
				}
			},
			rt.ArrayItem{ key: 'request_uri', val: this.sanitize_request_uri(rt.call_function('filter_input', [
				rt.get_constant('INPUT_SERVER'),
				rt.new_string('REQUEST_URI'),
				rt.get_constant('FILTER_SANITIZE_URL'),
			])) },
			rt.ArrayItem{
				key: 'store_id'
				val: if !iife_result_4.is_null() {
					iife_result_4
				} else {
					rt.new_string('Unable to retrieve store id')
				}
			},
		]) },
	])
	mut iife_temp_5 := Class_Jetpack_Options{}
	mut iife_result_5 := iife_temp_5.get_option(rt.new_string('id'))
	mut var_blog_id := if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('Jetpack_Options'),
	]))
	{ iife_result_5 } else { rt.new_null() }
	if !(!rt.is_true(var_blog_id)) && var_blog_id.clone().is_long() {
		var_log_data.array_set('blog_id', var_blog_id.clone())
	}
	if var_context.array_isset(rt.new_string('backtrace')) {
		if var_context.array_get(rt.new_string('backtrace')).is_array()
			|| var_context.array_get(rt.new_string('backtrace')).is_string() {
			var_log_data.array_set('trace',
				this.sanitize_trace(var_context.array_get(rt.new_string('backtrace'))))
		} else if rt.is_true(rt.identical(rt.new_bool(true),
			var_context.array_get(rt.new_string('backtrace'))))
		{
			mut iife_temp_6 := Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger{}
			mut iife_result_6 := iife_temp_6.get_backtrace()
			var_log_data.array_set('trace', this.sanitize_trace(iife_result_6))
		}
		var_context.array_unset(rt.new_string('backtrace'))
	}
	if var_context.array_isset(rt.new_string('tags'))
		&& var_context.array_get(rt.new_string('tags')).is_array() {
		var_log_data.array_set('tags', rt.call_function('array_merge', [
			var_log_data.array_get(rt.new_string('tags')),
			var_context.array_get(rt.new_string('tags')),
		]))
		var_context.array_unset(rt.new_string('tags'))
	}
	if var_context.array_get(rt.new_string('error')).array_isset(rt.new_string('file'))
		&& var_context.array_get(rt.new_string('error')).array_get(rt.new_string('file')).is_string()
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_context.array_get(rt.new_string('error')).array_get(rt.new_string('file')))))) {
		var_log_data.array_set('file',
			this.normalize_paths((var_context.array_get(rt.new_string('error')).array_get(rt.new_string('file'))).str()))
		var_context.array_get(rt.new_string('error')).array_unset(rt.new_string('file'))
	}
	mut var_extra_attrs := if !(var_context.array_get(rt.new_string('extra'))).is_null() {
		var_context.array_get(rt.new_string('extra'))
	} else {
		rt.new_array()
	}
	var_context.array_unset(rt.new_string('extra'))
	var_context.array_unset(rt.new_string('remote-logging'))
	var_log_data.array_set('extra', rt.call_function('array_merge', [
		var_extra_attrs.clone(), var_context.clone()]))
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_remote_logger_formatted_log_data'),
		var_log_data.clone(),
		var_level.clone(),
		var_message.clone(),
		var_context.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) is_remote_logging_allowed() bool {
	mut iife_temp_7 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_7 := iife_temp_7.feature_is_enabled(rt.new_string('remote_logging'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_7)))) {
		return false
	}
	mut iife_temp_8 := Class_WC_Site_Tracking{}
	mut iife_result_8 := iife_temp_8.is_tracking_enabled()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_8)))) {
		return false
	}
	if !(this.should_current_version_be_logged()) {
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) should_handle(var_level rt.PhpVal, var_message rt.PhpVal, var_context rt.PhpVal) bool {
	if !(var_context.array_isset(rt.new_string('remote-logging')))
		|| rt.is_true(rt.identical(rt.new_bool(false), var_context.array_get(rt.new_string('remote-logging')))) {
		return false
	}
	if !(this.is_remote_logging_allowed()) {
		return false
	}
	if this.is_third_party_error(var_message.str(), mut
		rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Logging_array](rt.cast_array(var_context)))
	{
		return false
	}
	mut iife_temp_9 := Class_WC_Log_Levels{}
	mut iife_result_9 := iife_temp_9.get_level_severity(var_level.clone())
	mut iife_temp_10 := Class_WC_Log_Levels{}
	mut iife_result_10 := iife_temp_10.get_level_severity(Class_WC_Log_Levels.critical())
	if rt.is_true(rt.greater_equal(iife_result_9, iife_result_10)) {
		mut var_mc_stats := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
			'get', [Class_Automattic_WooCommerce_Internal_McStats.class()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		rt.call_method(var_mc_stats, 'add', [rt.new_string('error'),
			rt.new_string('critical-errors')])
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		rt.call_method(var_mc_stats, 'do_server_side_stats', []rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		unsafe {
			goto end_label_2
		}
		catch_label_2:
		mut var_e_2 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Internal_Logging_Throwable') {
			mut var_e := var_e_2.clone()
			rt.call_function('error_log', [
				rt.new_string('Warning: Failed to record fatal error stats: ' +
					(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			])
			unsafe {
				goto end_label_2
			}
		} else {
			rt.throw_exception(var_e_2)
			unsafe {
				goto end_label_2
			}
		}

		end_label_2:
	}
	mut iife_temp_11 := Class_WC_Rate_Limiter{}
	mut iife_result_11 :=
		iife_temp_11.retried_too_soon(Class_Automattic_WooCommerce_Internal_Logging_Automattic_WooCommerce_Internal_Logging_RemoteLogger.rate_limit_id())
	if rt.is_true(iife_result_11) {
		mut iife_temp_12 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
		mut iife_result_12 := iife_temp_12.wc_get_logger()
		rt.call_method(iife_result_12, 'warning', [
			rt.new_string('Remote logging throttled.'),
			rt.create_array([rt.ArrayItem{ key: 'source', val: 'remote-logging' }]),
		])
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) log(var_level rt.PhpVal, var_message rt.PhpVal, var_context rt.PhpVal) bool {
	mut var_log_data := this.get_formatted_log(var_level.clone(), var_message.clone(),
		var_context.clone())
	if !(var_log_data.clone().is_array())
		|| !rt.is_true(var_log_data.array_get(rt.new_string('message')))
		|| !rt.is_true(var_log_data.array_get(rt.new_string('feature'))) {
		return false
	}
	mut iife_temp_13 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
	mut iife_result_13 := iife_temp_13.wp_json_encode(var_log_data.clone())
	mut iife_temp_14 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
	mut iife_result_14 := iife_temp_14.wp_json_encode(rt.create_array([
		rt.ArrayItem{ key: 'params', val: iife_result_13 },
	]))
	mut var_body := iife_result_14
	if rt.is_true(rt.new_bool(var_body.clone().is_null())) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Logging_Error',
			[]string{},
			create_automattic_woocommerce_internal_logging_error(rt.new_string('Remote Logger encountered error while attempting to JSON encode $log_data'))))
	}
	mut iife_temp_15 := Class_WC_Rate_Limiter{}
	mut iife_result_15 := iife_temp_15.set_rate_limit(Class_Automattic_WooCommerce_Internal_Logging_Automattic_WooCommerce_Internal_Logging_RemoteLogger.rate_limit_id(),
		Class_Automattic_WooCommerce_Internal_Logging_Automattic_WooCommerce_Internal_Logging_RemoteLogger.rate_limit_delay())
	if rt.is_true(this.is_dev_or_local_environment()) {
		return false
	}
	mut iife_temp_16 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
	mut iife_result_16 := iife_temp_16.wp_safe_remote_post(Class_Automattic_WooCommerce_Internal_Logging_Automattic_WooCommerce_Internal_Logging_RemoteLogger.log_endpoint(), rt.create_array([
		rt.ArrayItem{ key: 'body', val: var_body },
		rt.ArrayItem{ key: 'timeout', val: 3 },
		rt.ArrayItem{ key: 'headers', val: rt.create_array([
			rt.ArrayItem{ key: 'Content-Type', val: 'application/json' },
		]) },
		rt.ArrayItem{ key: 'blocking', val: false },
	]))
	mut var_response := iife_result_16
	if rt.is_true(rt.new_bool(var_response.clone().is_null())) {
		mut iife_temp_17 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
		mut iife_result_17 := iife_temp_17.wc_get_logger()
		rt.call_method(iife_result_17, 'error', [
			rt.new_string('Failed to call wp_safe_remote_post while sending the log to the remote logging service.'),
			rt.create_array([rt.ArrayItem{ key: 'source', val: 'remote-logging' }]),
		])
		return false
	}
	mut iife_temp_18 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
	mut iife_result_18 := iife_temp_18.is_wp_error(var_response.clone())
	mut var_is_api_call_error := iife_result_18
	if rt.is_true(var_is_api_call_error) {
		mut iife_temp_19 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
		mut iife_result_19 := iife_temp_19.wc_get_logger()
		rt.call_method(iife_result_19, 'error', [
			rt.new_string('Failed to send the log to the remote logging service: ' +
				(rt.call_method(var_response, 'get_error_message', []rt.PhpVal{})).str()),
			rt.create_array([rt.ArrayItem{ key: 'source', val: 'remote-logging' }]),
		])
		return false
	} else if rt.is_true(rt.new_bool(var_is_api_call_error.clone().is_null())) {
		mut iife_temp_20 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
		mut iife_result_20 := iife_temp_20.wc_get_logger()
		rt.call_method(iife_result_20, 'error', [
			rt.new_string('Failed to parse the response after sending log to the remote logging service. '),
			rt.create_array([rt.ArrayItem{ key: 'source', val: 'remote-logging' }]),
		])
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) should_current_version_be_logged() bool {
	mut iife_temp_21 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
	mut iife_result_21 :=
		iife_temp_21.get_site_transient(Class_Automattic_WooCommerce_Internal_Logging_Automattic_WooCommerce_Internal_Logging_RemoteLogger.wc_new_version_transient())
	mut var_new_version := if !iife_result_21.is_null() { iife_result_21 } else { rt.new_string('') }
	if rt.is_true(rt.identical(rt.new_bool(false), var_new_version)) {
		var_new_version = this.fetch_new_woocommerce_version()
		mut iife_temp_22 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
		mut iife_result_22 := iife_temp_22.set_site_transient(Class_Automattic_WooCommerce_Internal_Logging_Automattic_WooCommerce_Internal_Logging_RemoteLogger.wc_new_version_transient(),
			var_new_version.clone(), rt.get_constant('WEEK_IN_SECONDS'))
	}
	if !(var_new_version.clone().is_string())
		|| rt.is_true(rt.identical(rt.new_string(''), var_new_version)) {
		return true
	}
	return (rt.call_function('version_compare', [this.get_wc_version(),
		var_new_version.clone(), rt.new_string('>=')])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) get_wc_version() rt.PhpVal {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('\\Automattic\\Jetpack\\Constants')]))
		&& rt.is_true(rt.call_function('method_exists', [rt.new_string('\\Automattic\\Jetpack\\Constants'), rt.new_string('get_constant')])) {
		mut iife_temp_23 :=
			Class_Automattic_WooCommerce_Internal_Logging_Automattic_Jetpack_Constants{}
		mut iife_result_23 := iife_temp_23.get_constant(rt.new_string('WC_VERSION'))
		mut var_wc_version := iife_result_23
		if rt.is_true(var_wc_version) {
			return var_wc_version.clone()
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
	if !(var_context.array_isset(rt.new_string('source')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('fatal-errors'), var_context.array_get(rt.new_string('source')))))) {
		return false
	}
	mut iife_temp_24 := Class_Automattic_WooCommerce_Utilities_StringUtil{}
	mut iife_result_24 := iife_temp_24.normalize_local_path_slashes(rt.get_constant('WC_ABSPATH'))
	mut var_wc_plugin_dir := iife_result_24
	if rt.is_true(rt.call_function('str_contains', [rt.new_string(message),
		var_wc_plugin_dir.clone()]))
	{
		return false
	}
	if var_context.array_isset(rt.new_string('backtrace'))
		&& var_context.array_get(rt.new_string('backtrace')).is_array() {
		mut iife_temp_25 := Class_Automattic_WooCommerce_Utilities_StringUtil{}
		mut iife_result_25 := iife_temp_25.normalize_local_path_slashes(rt.new_string(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str()))
		mut var_wp_includes_dir := iife_result_25
		mut iife_temp_26 := Class_Automattic_WooCommerce_Utilities_StringUtil{}
		mut iife_result_26 := iife_temp_26.normalize_local_path_slashes(rt.new_string(
			(rt.get_constant('ABSPATH')).str() + 'wp-admin'))
		mut var_wp_admin_dir := iife_result_26
		mut var_relevant_frame := rt.new_null()
		mut iter_1 := var_context.array_get(rt.new_string('backtrace')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_frame := item_1.val
			if !rt.is_true(var_frame) || !(var_frame.clone().is_string()) {
				continue
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [var_frame.clone(), var_wp_includes_dir.clone()]), rt.new_bool(false)))))
				|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [var_frame.clone(), var_wp_admin_dir.clone()]), rt.new_bool(false))))) {
				continue
			}
			var_relevant_frame = var_frame
			break
		}
		if rt.is_true(var_relevant_frame)
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [var_relevant_frame.clone(), var_wc_plugin_dir.clone()]), rt.new_bool(false))))) {
			return false
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('apply_filters'),
	])))))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/plugin.php',
			'4')
	}
	return (rt.call_function('apply_filters', [
		rt.new_string('woocommerce_remote_logging_is_third_party_error'),
		rt.new_bool(true),
		rt.new_string(message),
		var_context,
	])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) fetch_new_woocommerce_version() rt.PhpVal {
	mut iife_temp_27 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
	mut iife_result_27 := iife_temp_27.get_plugin_updates()
	mut var_plugin_updates := iife_result_27
	if !(var_plugin_updates.clone().is_array())
		|| !(var_plugin_updates.array_isset(rt.get_constant('WC_PLUGIN_BASENAME'))) {
		return rt.new_null()
	}
	mut var_wc_plugin_update := var_plugin_updates.array_get(rt.get_constant('WC_PLUGIN_BASENAME'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wc_plugin_update))))
		|| !(!(rt.get_property(rt.get_property(var_wc_plugin_update, 'update'), 'new_version')).is_null()) {
		return rt.new_null()
	}
	mut var_new_version := rt.get_property(rt.get_property(var_wc_plugin_update, 'update'),
		'new_version')
	return if var_new_version.clone().is_string() { var_new_version } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) sanitize(var_content rt.PhpVal) rt.PhpVal {
	mut var_content_mutated := var_content
	if !(var_content_mutated.clone().is_string()) {
		return var_content_mutated.clone()
	}
	mut var_sanitized := rt.new_string(this.normalize_paths(var_content_mutated.str()))
	var_sanitized = this.redact_user_data(var_sanitized.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('apply_filters'),
	])))))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/plugin.php',
			'4')
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_remote_logger_sanitized_content'),
		var_sanitized.clone(),
		var_content_mutated.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) normalize_paths(content string) string {
	mut content_mutated := content
	mut iife_temp_28 := Class_Automattic_WooCommerce_Utilities_StringUtil{}
	mut iife_result_28 := iife_temp_28.normalize_local_path_slashes(rt.call_function('trailingslashit', [
		rt.call_function('dirname', [rt.get_constant('WC_ABSPATH')]),
	]))
	mut var_plugin_path := iife_result_28
	mut iife_temp_29 := Class_Automattic_WooCommerce_Utilities_StringUtil{}
	mut iife_result_29 := iife_temp_29.normalize_local_path_slashes(rt.call_function('trailingslashit', [
		rt.get_constant('ABSPATH'),
	]))
	mut var_wp_path := iife_result_29
	return (rt.call_function('str_replace', [
		rt.create_array([rt.ArrayItem{ key: none, val: var_plugin_path },
			rt.ArrayItem{ key: none, val: var_wp_path }]),
		rt.create_array([rt.ArrayItem{ key: none, val: './' },
			rt.ArrayItem{ key: none, val: './' }]),
		rt.new_string(content_mutated).clone(),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) sanitize_trace(var_trace rt.PhpVal) string {
	if rt.is_true(rt.new_bool(var_trace.clone().is_string())) {
		return (this.sanitize(var_trace.clone())).str()
	}
	if !(var_trace.clone().is_array()) {
		return ''
	}
	closure_31_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_trace_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if var_trace_item.clone().is_array() && var_trace_item.array_isset(rt.new_string('file')) {
			var_trace_item.array_set('file',
				this.sanitize(var_trace_item.array_get(rt.new_string('file'))))
			return var_trace_item.str()
		}
		return (this.sanitize(var_trace_item.clone())).str()
	}
	closure_32_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_trace_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if var_trace_item.clone().is_array() && var_trace_item.array_isset(rt.new_string('file')) {
			var_trace_item.array_set('file',
				this.sanitize(var_trace_item.array_get(rt.new_string('file'))))
			return var_trace_item.str()
		}
		return (this.sanitize(var_trace_item.clone())).str()
	}
	mut var_sanitized_trace := rt.call_function('array_map', [
		rt.new_closure(closure_31_fn),
		var_trace.clone(),
	])
	mut var_is_array_by_file :=
		rt.new_bool(var_sanitized_trace.array_get(rt.new_int(0)).array_isset(rt.new_string('file')))
	if rt.is_true(var_is_array_by_file) {
		mut iife_temp_32 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
		mut iife_result_32 := iife_temp_32.wc_print_r(var_sanitized_trace.clone(),
			rt.new_bool(true))
		return iife_result_32.str()
	}
	return (rt.call_function('implode', [rt.new_string('\n'),
		var_sanitized_trace.clone()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) redact_user_data(var_content rt.PhpVal) rt.PhpVal {
	mut var_content_mutated := var_content
	var_content_mutated = rt.call_function('preg_replace', [
		rt.new_string('/[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}/'),
		rt.new_string('[redacted_email]'),
		var_content_mutated.clone(),
	])
	var_content_mutated = rt.call_function('preg_replace', [
		rt.new_string('/\\b(?:\\d{1,3}\\.){3}\\d{1,3}\\b/'),
		rt.new_string('[redacted_ip]'),
		var_content_mutated.clone(),
	])
	var_content_mutated = rt.call_function('preg_replace', [
		rt.new_string('/(\\d{4}[- ]?){3}\\d{4}/'),
		rt.new_string('[redacted_credit_card]'),
		var_content_mutated.clone(),
	])
	mut var_api_patterns := rt.create_array([
		rt.ArrayItem{ key: none, val: '/\\b[A-Za-z0-9]{32,40}\\b/' },
		rt.ArrayItem{ key: none, val: '/\\b[0-9a-f]{32}\\b/i' },
		rt.ArrayItem{ key: none, val: '/\\b(?:[A-Z0-9]{4}-){3,7}[A-Z0-9]{4}\\b/i' },
		rt.ArrayItem{ key: none, val: '/\\bsk_[A-Za-z0-9]{24,}\\b/i' },
	])
	mut iter_2 := var_api_patterns.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_pattern := item_2.val
		var_content_mutated = rt.call_function('preg_replace', [
			var_pattern.clone(), rt.new_string('[redacted_api_key]'),
			var_content_mutated.clone()])
	}
	var_content_mutated = rt.call_function('preg_replace', [
		rt.new_string('/(?:(?:\\+?\\d{1,3}[-\\s]?)?\\(?\\d{3}\\)?[-\\s]?\\d{3}[-\\s]?\\d{4}|\\b\\d{10,11}\\b)/'),
		rt.new_string('[redacted_phone]'),
		var_content_mutated.clone(),
	])
	return var_content_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) is_dev_or_local_environment() rt.PhpVal {
	mut iife_temp_33 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
	mut iife_result_33 := iife_temp_33.wp_get_environment_type()
	mut iife_temp_34 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
	mut iife_result_34 := iife_temp_34.wp_get_environment_type()
	return rt.call_function('in_array', [if !iife_result_33.is_null() {
		iife_result_33
	} else {
		rt.new_string('production')
	},
		rt.create_array([rt.ArrayItem{ key: none, val: 'development' },
			rt.ArrayItem{ key: none, val: 'local' }]),
		rt.new_bool(true)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) sanitize_request_uri(var_request_uri rt.PhpVal) rt.PhpVal {
	mut var_query_params := rt.new_null()
	mut var_default_whitelist := rt.create_array([rt.ArrayItem{ key: none, val: 'path' },
		rt.ArrayItem{ key: none, val: 'page' }, rt.ArrayItem{ key: none, val: 'step' },
		rt.ArrayItem{ key: none, val: 'task' }, rt.ArrayItem{ key: none, val: 'tab' },
		rt.ArrayItem{ key: none, val: 'section' }, rt.ArrayItem{ key: none, val: 'status' },
		rt.ArrayItem{ key: none, val: 'post_type' }, rt.ArrayItem{ key: none, val: 'taxonomy' },
		rt.ArrayItem{ key: none, val: 'action' }])
	mut var_whitelist := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_remote_logger_request_uri_whitelist'),
		var_default_whitelist.clone(),
	])
	mut iife_temp_35 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
	mut iife_result_35 := iife_temp_35.wp_parse_url(var_request_uri.clone())
	mut var_parsed_url := iife_result_35
	if !(var_parsed_url.clone().is_array()) || !(var_parsed_url.array_isset(rt.new_string('query'))) {
		return var_request_uri.clone()
	}
	rt.call_function('parse_str', [var_parsed_url.array_get(rt.new_string('query')),
		var_query_params.clone()])
	mut iter_3 := var_query_params.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_value := item_3.val
		mut var_key := item_3.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_key.clone(), var_whitelist.clone(), rt.new_bool(true)])))))
		{
			var_value = rt.new_string('xxxxxx')
		}
	}
	var_parsed_url.array_set('query', rt.call_function('http_build_query', [
		var_query_params.clone()]))
	return rt.new_string(this.build_url(var_parsed_url.clone()))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger) build_url(var_parsed_url rt.PhpVal) string {
	mut var_parsed_url_mutated := var_parsed_url
	mut var_path := if !(var_parsed_url_mutated.array_get(rt.new_string('path'))).is_null() {
		var_parsed_url_mutated.array_get(rt.new_string('path'))
	} else {
		rt.new_string('')
	}
	mut var_query := rt.new_string((if var_parsed_url_mutated.array_isset(rt.new_string('query')) {
		rt.concat(rt.new_string('?'), var_parsed_url_mutated.array_get(rt.new_string('query')))
	} else {
		''
	}).str())
	mut var_fragment := rt.new_string((if var_parsed_url_mutated.array_isset(rt.new_string('fragment')) {
		rt.concat(rt.new_string('#'), var_parsed_url_mutated.array_get(rt.new_string('fragment')))
	} else {
		''
	}).str())
	return '${var_path.to_string()}${var_query.to_string()}${var_fragment.to_string()}'
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

fn create_automattic_woocommerce_internal_logging_remotelogger(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger {
	mut obj := &Class_Automattic_WooCommerce_Internal_Logging_RemoteLogger{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_logging_wc_log_handler(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Logging_WC_Log_Handler {
	mut obj := &Class_Automattic_WooCommerce_Internal_Logging_WC_Log_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_logging_safeglobalfunctionproxy(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy {
	mut obj := &Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_jetpack_options(_args ...rt.PhpVal) &Class_Jetpack_Options {
	mut obj := &Class_Jetpack_Options{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_site_tracking(_args ...rt.PhpVal) &Class_WC_Site_Tracking {
	mut obj := &Class_WC_Site_Tracking{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_log_levels(_args ...rt.PhpVal) &Class_WC_Log_Levels {
	mut obj := &Class_WC_Log_Levels{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_rate_limiter(_args ...rt.PhpVal) &Class_WC_Rate_Limiter {
	mut obj := &Class_WC_Rate_Limiter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_logging_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Logging_Error {
	mut obj := &Class_Automattic_WooCommerce_Internal_Logging_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_logging_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Logging_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_WooCommerce_Internal_Logging_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_stringutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_StringUtil {
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
			return rt.new_bool(this.handle(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3))
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
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Logging_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
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
		else {
			return none
		}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
