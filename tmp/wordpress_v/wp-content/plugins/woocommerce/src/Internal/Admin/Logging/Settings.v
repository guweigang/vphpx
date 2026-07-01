import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings.defaults() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'logging_enabled', val: true }, rt.ArrayItem{ key: 'default_handler', val: Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2.class() }, rt.ArrayItem{ key: 'retention_period_days', val: 30 }, rt.ArrayItem{ key: 'level_threshold', val: 'none' }])
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings.prefix() string {
	return 'woocommerce_logs_'
}
struct Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings) construct()  {
	rt.call_function('add_action', [rt.new_string('wc_logs_load_tab'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Logging_Settings', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'save_settings' }])])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings.get_log_directory(create_dir bool) string {
	if rt.is_true(rt.identical(rt.new_bool(true), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_LOG_DIR_CUSTOM')))) {
		mut var_dir := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_LOG_DIR'))
	} else {
		mut var_upload_dir := rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Proxies_LegacyProxy.class()]), 'call_function', [rt.new_string('wp_upload_dir'), rt.new_null(), rt.new_bool(create_dir)])
		var_dir = rt.call_function('apply_filters', [rt.new_string('woocommerce_log_directory'), (var_upload_dir.array_get('basedir')).str() + '/wc-logs/'])
	}
	var_dir = rt.call_function('trailingslashit', [var_dir.dup()])
	if rt.is_true(rt.identical(rt.new_bool(true), rt.new_bool(create_dir))) {
		mut var_realpath := rt.call_function('realpath', [var_dir.dup()])
		if rt.is_true(rt.identical(rt.new_bool(false), var_realpath)) {
			mut var_result := rt.call_function('wp_mkdir_p', [var_dir.dup()])
			if rt.is_true(rt.identical(rt.new_bool(true), var_result)) {
				mut var_filesystem := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil{}; return temp.get_wp_filesystem() }()
				if rt.has_exception() { unsafe { goto catch_label_1 } }
				rt.call_method(var_filesystem, 'put_contents', [(var_dir).str() + '.htaccess', rt.new_string('deny from all')])
				if rt.has_exception() { unsafe { goto catch_label_1 } }
				rt.call_method(var_filesystem, 'put_contents', [(var_dir).str() + 'index.html', rt.new_string('')])
				if rt.has_exception() { unsafe { goto catch_label_1 } }
				unsafe { goto end_label_1 }

catch_label_1:
				mut var_e_1 := rt.get_and_clear_exception()
				if rt.instance_of(var_e_1, 'Exception') {
					mut var_exception := var_e_1.dup()
					// unsupported statement: Stmt_Nop
					unsafe { goto end_label_1 }
				}
				else {
					rt.throw_exception(var_e_1)
					unsafe { goto end_label_1 }
				}

end_label_1:
			}
		}
	}
	return (var_dir).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings) get_settings_definitions() rt.PhpVal {
	mut var_settings := rt.create_array([rt.ArrayItem{ key: 'start', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Logs settings'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: (Class_Automattic_WooCommerce_Internal_Admin_Logging_Automattic_WooCommerce_Internal_Admin_Logging_Settings.prefix()).str() + 'settings' }, rt.ArrayItem{ key: 'type', val: 'title' }]) }, rt.ArrayItem{ key: 'logging_enabled', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Logger'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Enable logging'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: (Class_Automattic_WooCommerce_Internal_Admin_Logging_Automattic_WooCommerce_Internal_Admin_Logging_Settings.prefix()).str() + 'logging_enabled' }, rt.ArrayItem{ key: 'type', val: 'checkbox' }, rt.ArrayItem{ key: 'value', val: if this.logging_is_enabled() { 'yes' } else { 'no' } }, rt.ArrayItem{ key: 'default', val: if rt.is_true(Class_Automattic_WooCommerce_Internal_Admin_Logging_Automattic_WooCommerce_Internal_Admin_Logging_Settings.defaults().array_get('logging_enabled')) { 'yes' } else { 'no' } }, rt.ArrayItem{ key: 'autoload', val: false }]) }, rt.ArrayItem{ key: 'default_handler', val: rt.new_array() }, rt.ArrayItem{ key: 'retention_period_days', val: rt.new_array() }, rt.ArrayItem{ key: 'level_threshold', val: rt.new_array() }, rt.ArrayItem{ key: 'end', val: rt.create_array([rt.ArrayItem{ key: 'id', val: (Class_Automattic_WooCommerce_Internal_Admin_Logging_Automattic_WooCommerce_Internal_Admin_Logging_Settings.prefix()).str() + 'settings' }, rt.ArrayItem{ key: 'type', val: 'sectionend' }]) }])
	if rt.is_true(rt.identical(rt.new_bool(true), this.logging_is_enabled())) {
		var_settings.array_set('default_handler', this.get_default_handler_setting_definition())
		var_settings.array_set('retention_period_days', this.get_retention_period_days_setting_definition())
		var_settings.array_set('level_threshold', this.get_level_threshold_setting_definition())
		mut var_default_handler := rt.new_string(this.get_default_handler())
		if rt.is_true(rt.call_function('in_array', [var_default_handler.dup(), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2.class() }, rt.ArrayItem{ key: none, val: Class_WC_Log_Handler_File.class() }]), rt.new_bool(true)])) {
			// unsupported expression: Expr_AssignOp_Plus
		} else if rt.is_true(rt.identical(Class_WC_Log_Handler_DB.class(), var_default_handler)) {
			// unsupported expression: Expr_AssignOp_Plus
		}
	}
	return var_settings.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings) get_default_handler_setting_definition() rt.PhpVal {
	mut var_handler_options := rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2.class(), val: rt.call_function('__', [rt.new_string('File system (default)'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_WC_Log_Handler_DB.class(), val: rt.call_function('__', [rt.new_string('Database (not recommended on live sites)'), rt.new_string('woocommerce')]) }])
	var_handler_options = rt.call_function('apply_filters', [rt.new_string('woocommerce_logger_handler_options'), var_handler_options.dup()])
	mut var_current_value := rt.new_string(this.get_default_handler())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_handler_options.dup().array_isset(var_current_value.dup())))))) {
		var_handler_options.array_set(var_current_value, var_current_value.dup())
	}
	mut var_desc := rt.new_array()
	var_desc.array_push(rt.call_function('__', [rt.new_string('Note that if this setting is changed, any log entries that have already been recorded will remain stored in their current location, but will not migrate.'), rt.new_string('woocommerce')]))
	mut var_hardcoded := rt.new_bool(rt.new_bool(!(rt.is_true(rt.new_bool(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_LOG_HANDLER')).is_null())))))
	if rt.is_true(var_hardcoded) {
		var_desc.array_push(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('This setting cannot be changed here because it is defined in the %s constant.'), rt.new_string('woocommerce')]), rt.new_string('<code>WC_LOG_HANDLER</code>')]))
	}
	return rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Log storage'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [rt.new_string('This determines where log entries are saved.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: (Class_Automattic_WooCommerce_Internal_Admin_Logging_Automattic_WooCommerce_Internal_Admin_Logging_Settings.prefix()).str() + 'default_handler' }, rt.ArrayItem{ key: 'type', val: 'radio' }, rt.ArrayItem{ key: 'value', val: var_current_value }, rt.ArrayItem{ key: 'default', val: Class_Automattic_WooCommerce_Internal_Admin_Logging_Automattic_WooCommerce_Internal_Admin_Logging_Settings.defaults().array_get('default_handler') }, rt.ArrayItem{ key: 'autoload', val: false }, rt.ArrayItem{ key: 'options', val: var_handler_options }, rt.ArrayItem{ key: 'disabled', val: if rt.is_true(var_hardcoded) { rt.func_array_keys(var_handler_options.dup()) } else { rt.new_array() } }, rt.ArrayItem{ key: 'desc', val: rt.call_function('implode', [rt.new_string('<br><br>'), var_desc.dup()]) }, rt.ArrayItem{ key: 'desc_at_end', val: true }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings) get_retention_period_days_setting_definition() rt.PhpVal {
	mut var_custom_attributes := rt.create_array([rt.ArrayItem{ key: 'min', val: 1 }, rt.ArrayItem{ key: 'step', val: 1 }])
	mut var_desc := rt.new_array()
	mut var_hardcoded := rt.call_function('has_filter', [rt.new_string('woocommerce_logger_days_to_retain_logs')])
	if rt.is_true(var_hardcoded) {
		var_custom_attributes.array_set('disabled', 'true')
		var_desc.array_push(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('This setting cannot be changed here because it is being set by a filter on the %s hook.'), rt.new_string('woocommerce')]), rt.new_string('<code>woocommerce_logger_days_to_retain_logs</code>')]))
	}
	mut var_file_delete_has_filter := rt.new_bool(rt.new_bool(rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2.class(), this.get_default_handler())) && rt.is_true(rt.call_function('has_filter', [rt.new_string('woocommerce_logger_delete_expired_file')]))))
	if rt.is_true(var_file_delete_has_filter) {
		var_desc.array_push(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The %s hook has a filter set, so some log files may have different retention settings.'), rt.new_string('woocommerce')]), rt.new_string('<code>woocommerce_logger_delete_expired_file</code>')]))
	}
	return rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Retention period'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [rt.new_string('This sets how many days log entries will be kept before being auto-deleted.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: (Class_Automattic_WooCommerce_Internal_Admin_Logging_Automattic_WooCommerce_Internal_Admin_Logging_Settings.prefix()).str() + 'retention_period_days' }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'value', val: this.get_retention_period() }, rt.ArrayItem{ key: 'default', val: Class_Automattic_WooCommerce_Internal_Admin_Logging_Automattic_WooCommerce_Internal_Admin_Logging_Settings.defaults().array_get('retention_period_days') }, rt.ArrayItem{ key: 'autoload', val: false }, rt.ArrayItem{ key: 'custom_attributes', val: var_custom_attributes }, rt.ArrayItem{ key: 'css', val: 'width:70px;' }, rt.ArrayItem{ key: 'row_class', val: 'logs-retention-period-days' }, rt.ArrayItem{ key: 'suffix', val: rt.call_function('sprintf', [rt.new_string(' %s'), rt.call_function('__', [rt.new_string('days'), rt.new_string('woocommerce')])]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('implode', [rt.new_string('<br><br>'), var_desc.dup()]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings) get_level_threshold_setting_definition() rt.PhpVal {
	mut var_hardcoded := rt.new_bool(rt.new_bool(!(rt.is_true(rt.new_bool(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_LOG_THRESHOLD')).is_null())))))
	mut var_desc := rt.new_string(rt.new_string(''))
	if rt.is_true(var_hardcoded) {
		var_desc = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('This setting cannot be changed here because it is defined in the %1$s constant, probably in your %2$s file.'), rt.new_string('woocommerce')]), rt.new_string('<code>WC_LOG_THRESHOLD</code>'), rt.new_string('<b>wp-config.php</b>')])
	}
	mut var_labels := fn () rt.PhpVal { mut temp := Class_WC_Log_Levels{}; return temp.get_all_level_labels() }()
	var_labels.array_set('none', rt.call_function('__', [rt.new_string('None'), rt.new_string('woocommerce')]))
	mut var_custom_attributes := rt.new_array()
	if rt.is_true(var_hardcoded) {
		var_custom_attributes.array_set('disabled', 'true')
	}
	return rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Level threshold'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [rt.new_string('This sets the minimum severity level of logs that will be stored. Lower severity levels will be ignored. "None" means all logs will be stored.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: (Class_Automattic_WooCommerce_Internal_Admin_Logging_Automattic_WooCommerce_Internal_Admin_Logging_Settings.prefix()).str() + 'level_threshold' }, rt.ArrayItem{ key: 'type', val: 'select' }, rt.ArrayItem{ key: 'value', val: this.get_level_threshold() }, rt.ArrayItem{ key: 'default', val: Class_Automattic_WooCommerce_Internal_Admin_Logging_Automattic_WooCommerce_Internal_Admin_Logging_Settings.defaults().array_get('level_threshold') }, rt.ArrayItem{ key: 'autoload', val: false }, rt.ArrayItem{ key: 'options', val: var_labels }, rt.ArrayItem{ key: 'custom_attributes', val: var_custom_attributes }, rt.ArrayItem{ key: 'css', val: 'width:auto;' }, rt.ArrayItem{ key: 'desc', val: var_desc }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings) get_filesystem_settings_definitions() rt.PhpVal {
	mut var_location_info := rt.new_array()
	mut var_directory := Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings.get_log_directory()
	mut var_status_info := rt.new_array()
	mut var_filesystem := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil{}; return temp.get_wp_filesystem() }()
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.new_bool(rt.instance_of(var_filesystem, 'WP_Filesystem_Direct'))) {
		var_status_info.array_push(rt.call_function('__', [rt.new_string('✅ Ready'), rt.new_string('woocommerce')]))
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	} else {
		var_status_info.array_push(rt.call_function('__', [rt.new_string('⚠️ The file system is not configured for direct writes. This could cause problems for the logger.'), rt.new_string('woocommerce')]))
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		var_status_info.array_push(rt.call_function('__', [rt.new_string('You may want to switch to the database for log storage.'), rt.new_string('woocommerce')]))
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_exception := var_e_2.dup()
		var_status_info.array_push(rt.call_function('__', [rt.new_string('⚠️ The file system connection could not be initialized.'), rt.new_string('woocommerce')]))
		var_status_info.array_push(rt.call_function('__', [rt.new_string('You may want to switch to the database for log storage.'), rt.new_string('woocommerce')]))
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	var_location_info.array_push(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Log files are stored in this directory: %s'), rt.new_string('woocommerce')]), rt.call_function('sprintf', [rt.new_string('<code>%s</code>'), rt.call_function('esc_html', [var_directory.dup()])])]))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_writable', [var_directory.dup()]))))) {
		var_location_info.array_push(rt.call_function('__', [rt.new_string('⚠️ This directory does not appear to be writable.'), rt.new_string('woocommerce')]))
	}
	var_location_info.array_push(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Directory size: %s'), rt.new_string('woocommerce')]), rt.call_function('size_format', [rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController.class()]), 'get_log_directory_size', []rt.PhpVal{})])]))
	return rt.create_array([rt.ArrayItem{ key: 'file_start', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('File system settings'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: (Class_Automattic_WooCommerce_Internal_Admin_Logging_Automattic_WooCommerce_Internal_Admin_Logging_Settings.prefix()).str() + 'settings' }, rt.ArrayItem{ key: 'type', val: 'title' }]) }, rt.ArrayItem{ key: 'file_status', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Status'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'info' }, rt.ArrayItem{ key: 'text', val: rt.call_function('implode', [rt.new_string('\n\n'), var_status_info.dup()]) }]) }, rt.ArrayItem{ key: 'log_directory', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Location'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'info' }, rt.ArrayItem{ key: 'text', val: rt.call_function('implode', [rt.new_string('\n\n'), var_location_info.dup()]) }]) }, rt.ArrayItem{ key: 'entry_format', val: rt.new_array() }, rt.ArrayItem{ key: 'file_end', val: rt.create_array([rt.ArrayItem{ key: 'id', val: (Class_Automattic_WooCommerce_Internal_Admin_Logging_Automattic_WooCommerce_Internal_Admin_Logging_Settings.prefix()).str() + 'settings' }, rt.ArrayItem{ key: 'type', val: 'sectionend' }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings) get_database_settings_definitions() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_table := rt.new_string(rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('woocommerce_log')))
	mut var_location_info := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Log entries are stored in this database table: %s'), rt.new_string('woocommerce')]), rt.new_string("<code>${var_table.to_string()}</code>")])
	return rt.create_array([rt.ArrayItem{ key: 'file_start', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Database settings'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: (Class_Automattic_WooCommerce_Internal_Admin_Logging_Automattic_WooCommerce_Internal_Admin_Logging_Settings.prefix()).str() + 'settings' }, rt.ArrayItem{ key: 'type', val: 'title' }]) }, rt.ArrayItem{ key: 'database_table', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Location'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'info' }, rt.ArrayItem{ key: 'text', val: var_location_info }]) }, rt.ArrayItem{ key: 'file_end', val: rt.create_array([rt.ArrayItem{ key: 'id', val: (Class_Automattic_WooCommerce_Internal_Admin_Logging_Automattic_WooCommerce_Internal_Admin_Logging_Settings.prefix()).str() + 'settings' }, rt.ArrayItem{ key: 'type', val: 'sectionend' }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings) save_settings(view string)  {
	mut var_is_saving := rt.new_bool(rt.new_bool(rt.is_true(rt.identical(rt.new_string('settings'), rt.new_string(view))) && rt.get_superglobal('_POST').array_isset(rt.new_string('save_settings'))))
	if rt.is_true(var_is_saving) {
		rt.call_function('check_admin_referer', [(Class_Automattic_WooCommerce_Internal_Admin_Logging_Automattic_WooCommerce_Internal_Admin_Logging_Settings.prefix()).str() + 'settings'])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
			rt.call_function('wp_die', [rt.call_function('esc_html__', [rt.new_string('You do not have permission to manage logging settings.'), rt.new_string('woocommerce')])])
		}
		mut var_settings := this.get_settings_definitions()
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Admin_Settings{}; return temp.save_fields(arg_0) }(var_settings.dup())
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings) render_form()  {
	mut var_settings := this.get_settings_definitions()
	// unsupported statement: Stmt_InlineHTML
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Admin_Settings{}; return temp.output_fields(arg_0) }(var_settings.dup())
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('wc_logs_settings_form_fields'), this.logging_is_enabled()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [(Class_Automattic_WooCommerce_Internal_Admin_Logging_Automattic_WooCommerce_Internal_Admin_Logging_Settings.prefix()).str() + 'settings'])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [rt.call_function('__', [rt.new_string('Save changes'), rt.new_string('woocommerce')]), rt.new_string('primary'), rt.new_string('save_settings')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings) logging_is_enabled() bool {
	mut var_key := rt.new_string((Class_Automattic_WooCommerce_Internal_Admin_Logging_Automattic_WooCommerce_Internal_Admin_Logging_Settings.prefix()).str() + 'logging_enabled')
	mut var_enabled := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Admin_Settings{}; return temp.get_option(arg_0, arg_1) }(var_key.dup(), Class_Automattic_WooCommerce_Internal_Admin_Logging_Automattic_WooCommerce_Internal_Admin_Logging_Settings.defaults().array_get('logging_enabled'))
	var_enabled = rt.call_function('filter_var', [var_enabled.dup(), rt.get_constant('FILTER_VALIDATE_BOOLEAN'), rt.get_constant('FILTER_NULL_ON_FAILURE')])
	if rt.is_true(rt.new_bool(var_enabled.dup().is_null())) {
		var_enabled = Class_Automattic_WooCommerce_Internal_Admin_Logging_Automattic_WooCommerce_Internal_Admin_Logging_Settings.defaults().array_get('logging_enabled')
	}
	return (var_enabled).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings) get_default_handler() string {
	mut var_key := rt.new_string(().str() + )
	mut var_handler := 
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	return ().str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings) get_retention_period() i64 {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings) get_level_threshold() string {
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil {
	rt.PhpObjectBase
}

struct Class_WC_Log_Levels {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Settings {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_logging_settings() &Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_filesystemutil() &Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil{
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

fn create_wc_admin_settings() &Class_WC_Admin_Settings {
	mut obj := &Class_WC_Admin_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_log_directory' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return rt.new_string(Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings.get_log_directory(dispatch_arg_0))
		}
		'get_settings_definitions' {
			return this.get_settings_definitions()
		}
		'get_default_handler_setting_definition' {
			return this.get_default_handler_setting_definition()
		}
		'get_retention_period_days_setting_definition' {
			return this.get_retention_period_days_setting_definition()
		}
		'get_level_threshold_setting_definition' {
			return this.get_level_threshold_setting_definition()
		}
		'get_filesystem_settings_definitions' {
			return this.get_filesystem_settings_definitions()
		}
		'get_database_settings_definitions' {
			return this.get_database_settings_definitions()
		}
		'save_settings' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.save_settings(dispatch_arg_0)
			return rt.new_null()
		}
		'render_form' {
			this.render_form()
			return rt.new_null()
		}
		'logging_is_enabled' {
			return rt.new_bool(this.logging_is_enabled())
		}
		'get_default_handler' {
			return rt.new_string(this.get_default_handler())
		}
		'get_retention_period' {
			return rt.new_int(this.get_retention_period())
		}
		'get_level_threshold' {
			return rt.new_string(this.get_level_threshold())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Admin_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_logging_settings_php() {
	// unsupported statement: Stmt_Declare
}
