import rt

struct Class_Automattic_WooCommerce_Internal_Utilities_PluginInstaller {
	rt.PhpObjectBase
pub mut:
		installing_plugin bool
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_PluginInstaller) register()  {
	rt.call_function('add_action', [rt.new_string('after_plugin_row'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Utilities_PluginInstaller', ['RegisterHooksInterface'], &this) }, rt.ArrayItem{ key: none, val: 'handle_plugin_list_rows' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('upgrader_process_complete'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Utilities_PluginInstaller', ['RegisterHooksInterface'], &this) }, rt.ArrayItem{ key: none, val: 'handle_upgrader_process_complete' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_PluginInstaller) install_plugin(plugin_url string, mut var_metadata Class_Automattic_WooCommerce_Internal_Utilities_array) rt.PhpVal {
	this.installing_plugin = true
	mut var_plugins_being_installed := rt.call_function('get_site_option', [rt.new_string('woocommerce_autoinstalling_plugins'), rt.new_array()])
	if rt.is_true(rt.call_function('in_array', [rt.new_string(plugin_url), var_plugins_being_installed.dup(), rt.new_bool(true)])) {
		return rt.create_array([rt.ArrayItem{ key: 'already_installing', val: true }])
	}
	var_plugins_being_installed.array_push(plugin_url)
	rt.call_function('update_site_option', [rt.new_string('woocommerce_autoinstalling_plugins'), var_plugins_being_installed.dup()])
	return this.install_plugin_core(plugin_url, mut var_metadata)
	unsafe { goto finally_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()

finally_label_1:
	var_plugins_being_installed = rt.call_function('array_diff', [var_plugins_being_installed.dup(), rt.create_array([rt.ArrayItem{ key: none, val: plugin_url }])])
	if !rt.is_true(var_plugins_being_installed) {
		rt.call_function('delete_site_option', [rt.new_string('woocommerce_autoinstalling_plugins')])
	} else {
		rt.call_function('update_site_option', [rt.new_string('woocommerce_autoinstalling_plugins'), var_plugins_being_installed.dup()])
	}
	this.installing_plugin = false
	if rt.has_exception() { return rt.new_null() }

end_label_1:
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_PluginInstaller) install_plugin_core(plugin_url string, mut var_metadata Class_Automattic_WooCommerce_Internal_Utilities_array) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Utilities_StringUtil{}; return temp.starts_with(arg_0, arg_1, arg_2) }(rt.new_string(plugin_url), rt.new_string('https://downloads.wordpress.org/'), rt.new_bool(false)))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Utilities_InvalidArgumentException', []string{}, create_automattic_woocommerce_internal_utilities_invalidargumentexception(rt.new_string('Only installs from the WordPress.org plugins directory (plugin URL starting with \'https://downloads.wordpress.org/\') are allowed.'))))
	}
	mut var_installed_by := if !(var_metadata.array_get('installed_by')).is_null() { var_metadata.array_get('installed_by') } else { rt.new_string('WooCommerce') }
	if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strcasecmp', [rt.new_string('WooCommerce'), var_installed_by.dup()]))) {
		mut var_calling_file := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Utilities_StringUtil{}; return temp.normalize_local_path_slashes(arg_0) }(if !(rt.call_function('debug_backtrace', []rt.PhpVal{}).array_get(1).array_get('file')).is_null() { rt.call_function('debug_backtrace', []rt.PhpVal{}).array_get(1).array_get('file') } else { rt.new_string('') })
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Utilities_StringUtil{}; return temp.starts_with(arg_0, arg_1) }(var_calling_file.dup(), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Utilities_StringUtil{}; return temp.normalize_local_path_slashes(arg_0) }(rt.new_string((rt.get_constant('WC_ABSPATH')).str() + 'includes/'))))))) && rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Utilities_StringUtil{}; return temp.starts_with(arg_0, arg_1) }(var_calling_file.dup(), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Utilities_StringUtil{}; return temp.normalize_local_path_slashes(arg_0) }(rt.new_string((rt.get_constant('WC_ABSPATH')).str() + 'src/'))))))))) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Utilities_InvalidArgumentException', []string{}, create_automattic_woocommerce_internal_utilities_invalidargumentexception(rt.new_string('If the value of \'installed_by\' is \'WooCommerce\', the caller of the method must be a WooCommerce core class or function.'))))
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [Class_Automattic_WooCommerce_Internal_Utilities_Automatic_Upgrader_Skin.class()]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-upgrader-skin.php', '2')
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-automatic-upgrader-skin.php', '2')
	}
	mut var_skin := create_automattic_woocommerce_internal_utilities_automatic_upgrader_skin()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [Class_Automattic_WooCommerce_Internal_Utilities_Plugin_Upgrader.class()]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-upgrader.php', '2')
	}
	mut var_upgrader := create_automattic_woocommerce_internal_utilities_plugin_upgrader(var_skin.dup())
	mut var_install_ok := var_upgrader.install(rt.new_string(plugin_url))
	mut var_result := rt.create_array([rt.ArrayItem{ key: 'messages', val: var_skin.get_upgrade_messages() }])
	if rt.is_true(var_install_ok) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('get_plugins')]))))) {
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
		}
		mut var_plugin_name := var_upgrader.plugin_info()
		mut var_plugin_version := rt.call_function('get_plugins', []rt.PhpVal{}).array_get(var_plugin_name).array_get('Version')
		var_result.array_set('plugin_name', var_plugin_name.dup())
		mut var_plugin_data := rt.create_array([rt.ArrayItem{ key: 'version', val: var_plugin_version }, rt.ArrayItem{ key: 'date', val: rt.call_function('current_time', [rt.new_string('mysql')]) }])
		if !(!rt.is_true(var_metadata)) {
			var_plugin_data.array_set('metadata', var_metadata.dup())
		}
		mut var_auto_installed_plugins := rt.call_function('get_site_option', [rt.new_string('woocommerce_autoinstalled_plugins'), rt.new_array()])
		var_auto_installed_plugins.array_set(var_plugin_name, var_plugin_data.dup())
		rt.call_function('update_site_option', [rt.new_string('woocommerce_autoinstalled_plugins'), var_auto_installed_plugins.dup()])
		mut var_auto_installed_plugins_history := rt.call_function('get_site_option', [rt.new_string('woocommerce_history_of_autoinstalled_plugins'), rt.new_array()])
		if !(var_auto_installed_plugins_history.array_isset(var_plugin_name)) {
			var_auto_installed_plugins_history.array_set(var_plugin_name, var_plugin_data.dup())
			rt.call_function('update_site_option', [rt.new_string('woocommerce_history_of_autoinstalled_plugins'), var_auto_installed_plugins_history.dup()])
		}
		closure_1_fn := fn [var_plugin_name, var_plugin_version, var_installed_by, var_plugin_url, var_plugin_data] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_log_context := rt.create_array([rt.ArrayItem{ key: 'source', val: 'plugin_auto_installs' }, rt.ArrayItem{ key: 'recorded_data', val: var_plugin_data }])
	rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'info', [rt.new_string("Plugin ${var_plugin_name.to_string()} v${var_plugin_version.to_string()} installed by ${var_installed_by.to_string()}, source: ${var_plugin_url}"), var_log_context.dup()])
	return rt.new_null()
	}
		mut var_post_install := rt.new_closure(closure_1_fn)
	} else {
		mut var_messages := var_skin.get_upgrade_messages()
		closure_2_fn := fn [var_plugin_url, var_installed_by, var_messages] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_log_context := rt.create_array([rt.ArrayItem{ key: 'source', val: 'plugin_auto_installs' }, rt.ArrayItem{ key: 'installer_messages', val: var_messages }])
	rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.new_string("${var_installed_by.to_string()} failed to install plugin from source: ${var_plugin_url}"), var_log_context.dup()])
	return rt.new_null()
	}
		var_post_install = rt.new_closure(closure_2_fn)
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		rt.call_function('switch_to_blog', [rt.call_function('get_main_site_id', []rt.PhpVal{})])
		if rt.is_true(Class_Automattic_WooCommerce_Internal_Utilities_PluginInstaller.woocommerce_is_active_in_current_site()) {
			rt.call_callable(var_post_install, []rt.PhpVal{})
			rt.call_function('restore_current_blog', []rt.PhpVal{})
		} else {
			rt.call_function('restore_current_blog', []rt.PhpVal{})
			rt.call_callable(var_post_install, []rt.PhpVal{})
		}
	} else {
		rt.call_callable(var_post_install, []rt.PhpVal{})
	}
	var_result.array_set('install_ok', if !(var_install_ok).is_null() { var_install_ok } else { rt.new_bool(false) })
	return var_result.dup()
}

fn Class_Automattic_WooCommerce_Internal_Utilities_PluginInstaller.woocommerce_is_active_in_current_site() bool {
	mut var_plugin := rt.new_null()
	mut var_active_valid_plugins := rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Utilities_PluginUtil.class()]), 'get_all_active_valid_plugins', []rt.PhpVal{})
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_plugin := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.identical(rt.call_function('substr_compare', [var_plugin.dup(), rt.new_string('/woocommerce.php'), // unsupported expression: Expr_UnaryMinus]), rt.new_int(0))
	}
	return !(!rt.is_true(rt.call_function('array_filter', [var_active_valid_plugins.dup(), rt.new_closure(closure_3_fn)])))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_PluginInstaller) handle_plugin_list_rows(var_plugin_file rt.PhpVal, var_plugin_data rt.PhpVal)  {
	mut var_wp_list_table := rt.new_null()
	mut var_plugin_data_mutated := var_plugin_data
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(var_wp_list_table.dup().is_null())) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_show_autoinstalled_plugin_notices'), rt.new_string('__return_true')]))))) {
		return rt.new_null()
	}
	mut var_auto_installed_plugins_info := rt.call_function('get_site_option', [rt.new_string('woocommerce_autoinstalled_plugins'), rt.new_array()])
	mut var_current_plugin_info := if !(var_auto_installed_plugins_info.array_get(var_plugin_file)).is_null() { var_auto_installed_plugins_info.array_get(var_plugin_file) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_current_plugin_info.dup().is_null())) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	mut var_installed_by := if !(var_current_plugin_info.array_get('metadata').array_get('installed_by')).is_null() { var_current_plugin_info.array_get('metadata').array_get('installed_by') } else { rt.new_string('WooCommerce') }
	mut var_info_link := if !(var_current_plugin_info.array_get('metadata').array_get('info_link')).is_null() { var_current_plugin_info.array_get('metadata').array_get('info_link') } else { rt.new_null() }
	if rt.is_true(var_info_link) {
		mut var_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Plugin installed by %1$s on %2$s. <a target="_blank" href="%3$s">More information</a>'), rt.new_string('woocommerce')]), var_installed_by.dup(), var_current_plugin_info.array_get('date'), var_info_link.dup()])
	} else {
		var_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Plugin installed by %1$s on %2$s.'), rt.new_string('woocommerce')]), var_installed_by.dup(), var_current_plugin_info.array_get('date')])
	}
	mut var_columns_count := rt.call_method(var_wp_list_table, 'get_column_count', []rt.PhpVal{})
	mut var_is_active := rt.call_function('is_plugin_active', [var_plugin_file.dup()])
	mut var_is_active_class := rt.new_string(if rt.is_true(var_is_active) { rt.new_string('active') } else { rt.new_string('inactive') })
	mut var_is_active_td_style := rt.new_string(if rt.is_true(var_is_active) { rt.new_string('style=\'border-left: 4px solid #72aee6;\'') } else { rt.new_string('') })
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_is_active_class)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_plugin_file)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_columns_count)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_is_active_td_style)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_message)
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_PluginInstaller) handle_upgrader_process_complete(mut var_upgrader Class_Automattic_WooCommerce_Internal_Utilities_WP_Upgrader, mut var_hook_extra Class_Automattic_WooCommerce_Internal_Utilities_array)  {
	mut var_upgrader_mutated := var_upgrader
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(this.installing_plugin) || !(true))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	mut var_auto_installed_plugins := rt.call_function('get_site_option', [rt.new_string('woocommerce_autoinstalled_plugins')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_auto_installed_plugins)))) {
		return rt.new_null()
	}
	if rt.is_true(if !(var_hook_extra.array_get('bulk')).is_null() { var_hook_extra.array_get('bulk') } else { rt.new_bool(false) }) {
		mut var_updated_plugin_names := if !(var_hook_extra.array_get('plugins')).is_null() { var_hook_extra.array_get('plugins') } else { rt.new_array() }
	} else {
		var_updated_plugin_names = rt.create_array([rt.ArrayItem{ key: none, val: var_upgrader_mutated.plugin_info() }])
	}
	mut var_auto_installed_plugin_names := rt.func_array_keys(var_auto_installed_plugins.dup())
	mut var_updated_auto_installed_plugin_names := rt.call_function('array_intersect', [var_auto_installed_plugin_names.dup(), var_updated_plugin_names.dup()])
	if !rt.is_true(var_updated_auto_installed_plugin_names) {
		return rt.new_null()
	}
	mut var_new_auto_installed_plugins := rt.call_function('array_diff_key', [var_auto_installed_plugins.dup(), rt.call_function('array_flip', [var_updated_auto_installed_plugin_names.dup()])])
	if !rt.is_true(var_new_auto_installed_plugins) {
		rt.call_function('delete_site_option', [rt.new_string('woocommerce_autoinstalled_plugins')])
	} else {
		rt.call_function('update_site_option', [rt.new_string('woocommerce_autoinstalled_plugins'), var_new_auto_installed_plugins.dup()])
	}
}

struct Class_Automattic_WooCommerce_Internal_Utilities_StringUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Utilities_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Utilities_Automatic_Upgrader_Skin {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Utilities_Plugin_Upgrader {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_utilities_plugininstaller() &Class_Automattic_WooCommerce_Internal_Utilities_PluginInstaller {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_PluginInstaller{
		PhpObjectBase: rt.PhpObjectBase{}
		installing_plugin: false
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_stringutil() &Class_Automattic_WooCommerce_Internal_Utilities_StringUtil {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_StringUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_invalidargumentexception() &Class_Automattic_WooCommerce_Internal_Utilities_InvalidArgumentException {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_automatic_upgrader_skin() &Class_Automattic_WooCommerce_Internal_Utilities_Automatic_Upgrader_Skin {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_Automatic_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_plugin_upgrader() &Class_Automattic_WooCommerce_Internal_Utilities_Plugin_Upgrader {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_Plugin_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_PluginInstaller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			this.register()
			return rt.new_null()
		}
		'install_plugin' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.install_plugin(dispatch_arg_0, mut dispatch_arg_1)
		}
		'install_plugin_core' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.install_plugin_core(dispatch_arg_0, mut dispatch_arg_1)
		}
		'woocommerce_is_active_in_current_site' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Utilities_PluginInstaller.woocommerce_is_active_in_current_site())
		}
		'handle_plugin_list_rows' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.handle_plugin_list_rows(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'handle_upgrader_process_complete' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_WP_Upgrader](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.handle_upgrader_process_complete(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_PluginInstaller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'installing_plugin' { return rt.new_bool(this.installing_plugin) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_PluginInstaller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'installing_plugin' { this.installing_plugin = (val).to_bool(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_StringUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_StringUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_StringUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Automatic_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_Automatic_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Automatic_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Plugin_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_Plugin_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Plugin_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_internal_utilities_plugininstaller_php() {
	// unsupported statement: Stmt_GroupUse
}
