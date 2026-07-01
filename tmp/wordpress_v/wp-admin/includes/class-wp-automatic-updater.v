import rt

struct Class_WP_Automatic_Updater {
	rt.PhpObjectBase
pub mut:
		update_results rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Automatic_Updater) is_disabled() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_file_mod_allowed', [rt.new_string('automatic_updater')]))))) {
		return true
	}
	if rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})) {
		return true
	}
	mut var_disabled := rt.new_bool(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('AUTOMATIC_UPDATER_DISABLED')])) && rt.is_true(rt.get_constant('AUTOMATIC_UPDATER_DISABLED'))))
	return (rt.call_function('apply_filters', [rt.new_string('automatic_updater_disabled'), var_disabled.dup()])).to_bool()
}

fn (mut this Class_WP_Automatic_Updater) is_allowed_dir(var_dir rt.PhpVal) bool {
	mut var_dir_mutated := var_dir
	if rt.is_true(rt.new_bool(var_dir_mutated.dup().is_string())) {
		var_dir_mutated = rt.new_string(rt.new_string(var_dir_mutated.dup().to_string().trim_space()))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_dir_mutated.dup().is_string()))))) || rt.is_true(rt.identical(rt.new_string(''), var_dir_mutated)))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The "%s" argument must be a non-empty string.')]), rt.new_string('$dir')]), rt.new_string('6.2.0')])
		return false
	}
	mut var_open_basedir := rt.call_function('ini_get', [rt.new_string('open_basedir')])
	if !rt.is_true(var_open_basedir) {
		return true
	}
	mut var_open_basedir_list := rt.call_function('explode', [rt.get_constant('PATH_SEPARATOR'), var_open_basedir.dup()])
	{
		mut iter_1 := var_open_basedir_list.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_basedir := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.call_function('str_starts_with', [var_dir_mutated.dup(), var_basedir.dup()])))) {
				return true
			}
		}
	}
	return false
}

fn (mut this Class_WP_Automatic_Updater) is_vcs_checkout(var_context rt.PhpVal) rt.PhpVal {
	mut var_context_mutated := var_context
	mut var_context_dirs := [rt.call_function('untrailingslashit', [var_context_mutated.dup()])]
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_context_dirs << rt.call_function('untrailingslashit', [rt.get_constant('ABSPATH')])
	}
	mut var_vcs_dirs := ['.svn', '.git', '.hg', '.bzr']
	mut var_check_dirs := rt.new_array()
	for var_context_dir in var_context_dirs {
		for {
			var_check_dirs.array_push(var_context_dir.dup())
			if rt.is_true(rt.identical(rt.call_function('dirname', [var_context_dir.dup()]), var_context_dir)) {
				break
			}
			// unsupported statement: Stmt_Nop
			if !(rt.is_true(var_context_dir = rt.call_function('dirname', [var_context_dir.dup()]))) {
				break
			}
		}
	}
	var_check_dirs = rt.call_function('array_unique', [var_check_dirs.dup()])
	mut var_checkout := rt.new_bool(rt.new_bool(false))
	for var_vcs_dir in var_vcs_dirs {
		{
			mut iter_1 := var_check_dirs.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_check_dir := item_1.val
				if !(this.is_allowed_dir(var_check_dir.dup())) {
					continue
				}
				var_checkout = rt.call_function('is_dir', [var_check_dir.dup().to_string().trim_right(' \t\n\r') + "/${var_vcs_dir}"])
				if rt.is_true(var_checkout) {
					break
				}
			}
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('automatic_updates_is_vcs_checkout'), var_checkout.dup(), var_context_mutated.dup()])
}

fn (mut this Class_WP_Automatic_Updater) should_update(var_type rt.PhpVal, var_item rt.PhpVal, var_context rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_item_mutated := var_item
	mut var_context_mutated := var_context
	mut var_skin := create_automatic_upgrader_skin()
	if this.is_disabled() {
		return false
	}
	mut var_allow_relaxed_file_ownership := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('core'), var_type)) && !(rt.get_property(var_item_mutated, 'new_files')).is_null())) && rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_item_mutated, 'new_files'))))))) {
		var_allow_relaxed_file_ownership = rt.new_bool(rt.new_bool(true))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_skin.request_filesystem_credentials(rt.new_bool(false), var_context_mutated.dup(), var_allow_relaxed_file_ownership.dup()))))) || rt.is_true(this.is_vcs_checkout(var_context_mutated.dup())))) {
		if rt.is_true(rt.identical(rt.new_string('core'), var_type)) {
			this.send_core_update_notification_email(var_item_mutated.dup())
		}
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('core'), var_type)) {
		mut var_update := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Core_Upgrader{}; return temp.should_update_to_version(arg_0) }(rt.get_property(var_item_mutated, 'current'))
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('plugin'), var_type)) || rt.is_true(rt.identical(rt.new_string('theme'), var_type)))) {
		var_update = rt.new_bool(rt.new_bool(!(!rt.is_true(rt.get_property(var_item_mutated, 'autoupdate')))))
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_update)))) && rt.is_true(rt.call_function('wp_is_auto_update_enabled_for_type', [var_type.dup()])))) {
			mut var_auto_updates := rt.cast_array(rt.call_function('get_site_option', [rt.new_string("auto_update_${var_type.to_string()}s"), rt.new_array()]))
			var_update = rt.call_function('in_array', [rt.get_property(var_item_mutated, '{"nodeType":"Expr_Variable","line":228,"name":"type"}'), var_auto_updates.dup(), rt.new_bool(true)])
		}
	} else {
		var_update = rt.new_bool(rt.new_bool(!(!rt.is_true(rt.get_property(var_item_mutated, 'autoupdate')))))
	}
	if !(!rt.is_true(rt.get_property(var_item_mutated, 'disable_autoupdate'))) {
		var_update = rt.new_bool(rt.new_bool(false))
	}
	var_update = rt.call_function('apply_filters', [rt.new_string("auto_update_${var_type.to_string()}"), var_update.dup(), var_item_mutated.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_update)))) {
		if rt.is_true(rt.identical(rt.new_string('core'), var_type)) {
			this.send_core_update_notification_email(var_item_mutated.dup())
		}
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('core'), var_type)) {
		// unsupported statement: Stmt_Global
		mut var_php_compat := rt.call_function('version_compare', [rt.get_constant('PHP_VERSION'), rt.get_property(var_item_mutated, 'php_version'), rt.new_string('>=')])
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('file_exists', [(rt.get_constant('WP_CONTENT_DIR')).str() + '/db.php'])) && !rt.is_true(rt.get_property(var_wpdb, 'is_mysql')))) {
			mut var_mysql_compat := rt.new_bool(rt.new_bool(true))
		} else {
			var_mysql_compat = rt.call_function('version_compare', [rt.call_method(var_wpdb, 'db_version', []rt.PhpVal{}), rt.get_property(var_item_mutated, 'mysql_version'), rt.new_string('>=')])
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_php_compat)))) || rt.is_true(rt.new_bool(!(rt.is_true(var_mysql_compat)))))) {
			return false
		}
	}
	if rt.is_true(rt.call_function('in_array', [var_type.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'plugin' }, rt.ArrayItem{ key: none, val: 'theme' }]), rt.new_bool(true)])) {
		if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_property(var_item_mutated, 'requires_php'))) && rt.is_true(rt.call_function('version_compare', [rt.get_constant('PHP_VERSION'), rt.get_property(var_item_mutated, 'requires_php'), rt.new_string('<')])))) {
			return false
		}
	}
	return true
}

fn (mut this Class_WP_Automatic_Updater) send_core_update_notification_email(var_item rt.PhpVal) bool {
	mut var_item_mutated := var_item
	mut var_notified := rt.call_function('get_site_option', [rt.new_string('auto_core_update_notified')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_notified) && rt.is_true(rt.identical(rt.call_function('get_site_option', [rt.new_string('admin_email')]), var_notified.array_get('email'))))) && rt.is_true(rt.identical(var_notified.array_get('version'), rt.get_property(var_item_mutated, 'current'))))) {
		return false
	}
	mut var_notify := rt.new_bool(rt.new_bool(!(!rt.is_true(rt.get_property(var_item_mutated, 'notify_email')))))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('send_core_update_notification_email'), var_notify.dup(), var_item_mutated.dup()]))))) {
		return false
	}
	this.send_email(rt.new_string('manual'), var_item_mutated.dup(), rt.new_null())
	return true
}

fn (mut this Class_WP_Automatic_Updater) update(var_type rt.PhpVal, var_item rt.PhpVal) bool {
	mut var_item_mutated := var_item
	mut var_skin := create_automatic_upgrader_skin()
	mut switch_val_1 := var_type
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('core'))) {
		rt.call_function('add_filter', [rt.new_string('update_feedback'), rt.create_array([rt.ArrayItem{ key: none, val: var_skin }, rt.ArrayItem{ key: none, val: 'feedback' }])])
		mut var_upgrader := create_core_upgrader(var_skin.dup())
		mut var_context := rt.get_constant('ABSPATH')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('plugin'))) {
		var_upgrader = create_plugin_upgrader(var_skin.dup())
		var_context = rt.get_constant('WP_PLUGIN_DIR')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('theme'))) {
		var_upgrader = create_theme_upgrader(var_skin.dup())
		var_context = rt.call_function('get_theme_root', [rt.get_property(var_item_mutated, 'theme')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('translation'))) {
		var_upgrader = create_language_pack_upgrader(var_skin.dup())
		var_context = rt.get_constant('WP_CONTENT_DIR')
	}
	if !(this.should_update(var_type.dup(), var_item_mutated.dup(), var_context.dup())) {
		return false
	}
	rt.call_function('do_action', [rt.new_string('pre_auto_update'), var_type.dup(), var_item_mutated.dup(), var_context.dup()])
	mut var_upgrader_item := var_item_mutated.dup()
	mut switch_val_2 := var_type
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('core'))) {
		var_skin.feedback(rt.call_function('__', [rt.new_string('Updating to WordPress %s')]), rt.get_property(var_item_mutated, 'version'))
		mut var_item_name := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('WordPress %s')]), rt.get_property(var_item_mutated, 'version')])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('theme'))) {
		var_upgrader_item = rt.get_property(var_item_mutated, 'theme')
		mut var_theme := rt.call_function('wp_get_theme', [var_upgrader_item.dup()])
		var_item_name = rt.call_method(var_theme, 'get', [rt.new_string('Name')])
		rt.set_property(var_item_mutated, 'current_version', rt.call_method(var_theme, 'get', [rt.new_string('Version')]))
		if !rt.is_true(rt.get_property(var_item_mutated, 'current_version')) {
			rt.set_property(var_item_mutated, 'current_version', rt.new_bool(false))
		}
		var_skin.feedback(rt.call_function('__', [rt.new_string('Updating theme: %s')]), var_item_name.dup())
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('plugin'))) {
		var_upgrader_item = rt.get_property(var_item_mutated, 'plugin')
		mut var_plugin_data := rt.call_function('get_plugin_data', [(var_context).str() + '/' + (var_upgrader_item).str()])
		var_item_name = var_plugin_data.array_get('Name')
		rt.set_property(var_item_mutated, 'current_version', var_plugin_data.array_get('Version'))
		if !rt.is_true(rt.get_property(var_item_mutated, 'current_version')) {
			rt.set_property(var_item_mutated, 'current_version', rt.new_bool(false))
		}
		var_skin.feedback(rt.call_function('__', [rt.new_string('Updating plugin: %s')]), var_item_name.dup())
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('translation'))) {
		mut var_language_item_name := rt.call_method(var_upgrader, 'get_name_for_update', [var_item_mutated.dup()])
		var_item_name = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Translations for %s')]), var_language_item_name.dup()])
		var_skin.feedback(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Updating translations for %1$s (%2$s)&#8230;')]), var_language_item_name.dup(), rt.get_property(var_item_mutated, 'language')]))
	}
	mut var_allow_relaxed_file_ownership := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('core'), var_type)) && !(rt.get_property(var_item_mutated, 'new_files')).is_null())) && rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_item_mutated, 'new_files'))))))) {
		var_allow_relaxed_file_ownership = rt.new_bool(rt.new_bool(true))
	}
	mut var_is_debug := rt.new_bool(rt.new_bool(rt.is_true(rt.get_constant('WP_DEBUG')) && rt.is_true(rt.get_constant('WP_DEBUG_LOG'))))
	if rt.is_true(rt.identical(rt.new_string('plugin'), var_type)) {
		mut var_was_active := rt.call_function('is_plugin_active', [var_upgrader_item.dup()])
		if rt.is_true(var_is_debug) {
			rt.call_function('error_log', [ + ])
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('theme'), var_type)) && rt.is_true(var_is_debug))) {
		rt.call_function('error_log', [ + ])
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_method(, 'maintenance_mode', [])
	}
	mut var_upgrade_result := 
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	
}

fn (mut this Class_WP_Automatic_Updater) run()  {
}

fn (mut this Class_WP_Automatic_Updater) after_core_update(var_update_result rt.PhpVal)  {
}

fn (mut this Class_WP_Automatic_Updater) send_email(var_type rt.PhpVal, var_core_update rt.PhpVal, var_result rt.PhpVal)  {
	mut var_about_version := rt.new_null()
	mut var_core_update_mutated := var_core_update
	mut var_result_mutated := var_result
}

fn (mut this Class_WP_Automatic_Updater) after_plugin_theme_update(var_update_results rt.PhpVal)  {
}

fn (mut this Class_WP_Automatic_Updater) send_plugin_theme_email(var_type rt.PhpVal, var_successful_updates rt.PhpVal, var_failed_updates rt.PhpVal)  {
	mut var_successful_updates_mutated := var_successful_updates
	mut var_failed_updates_mutated := var_failed_updates
}

fn (mut this Class_WP_Automatic_Updater) send_debug_email()  {
}

fn (mut this Class_WP_Automatic_Updater) has_fatal_error() bool {
	mut var_upgrading := rt.new_null()
}

struct Class_Automatic_Upgrader_Skin {
	rt.PhpObjectBase
}

struct Class_Core_Upgrader {
	rt.PhpObjectBase
}

struct Class_Plugin_Upgrader {
	rt.PhpObjectBase
}

struct Class_Theme_Upgrader {
	rt.PhpObjectBase
}

struct Class_Language_Pack_Upgrader {
	rt.PhpObjectBase
}

fn create_wp_automatic_updater() &Class_WP_Automatic_Updater {
	mut obj := &Class_WP_Automatic_Updater{
		PhpObjectBase: rt.PhpObjectBase{}
		update_results: rt.new_array()
	}
	return obj
}

fn create_automatic_upgrader_skin() &Class_Automatic_Upgrader_Skin {
	mut obj := &Class_Automatic_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_core_upgrader() &Class_Core_Upgrader {
	mut obj := &Class_Core_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_plugin_upgrader() &Class_Plugin_Upgrader {
	mut obj := &Class_Plugin_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_theme_upgrader() &Class_Theme_Upgrader {
	mut obj := &Class_Theme_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_language_pack_upgrader() &Class_Language_Pack_Upgrader {
	mut obj := &Class_Language_Pack_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Automatic_Updater) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_disabled' {
			return rt.new_bool(this.is_disabled())
		}
		'is_allowed_dir' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_allowed_dir(dispatch_arg_0))
		}
		'is_vcs_checkout' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_vcs_checkout(dispatch_arg_0)
		}
		'should_update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.should_update(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'send_core_update_notification_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.send_core_update_notification_email(dispatch_arg_0))
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.update(dispatch_arg_0, dispatch_arg_1))
		}
		'run' {
			this.run()
			return rt.new_null()
		}
		'after_core_update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.after_core_update(dispatch_arg_0)
			return rt.new_null()
		}
		'send_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.send_email(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'after_plugin_theme_update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.after_plugin_theme_update(dispatch_arg_0)
			return rt.new_null()
		}
		'send_plugin_theme_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.send_plugin_theme_email(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'send_debug_email' {
			this.send_debug_email()
			return rt.new_null()
		}
		'has_fatal_error' {
			return rt.new_bool(this.has_fatal_error())
		}
		else { return none }
	}
}

fn (this &Class_WP_Automatic_Updater) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'update_results' { return this.update_results }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Automatic_Updater) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'update_results' { this.update_results = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automatic_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automatic_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automatic_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Core_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Core_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Core_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Plugin_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Plugin_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Plugin_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Theme_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Theme_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Theme_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Language_Pack_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Language_Pack_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Language_Pack_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_admin_includes_class_wp_automatic_updater_php() {
}
