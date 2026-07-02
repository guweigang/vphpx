import rt
import crypto.md5

struct Class_WP_Automatic_Updater {
	rt.PhpObjectBase
pub mut:
	update_results rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Automatic_Updater) is_disabled() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_file_mod_allowed', [
		rt.new_string('automatic_updater'),
	])))))
	{
		return true
	}
	if rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})) {
		return true
	}
	mut var_disabled := rt.new_bool(
		rt.is_true(rt.call_function('defined', [rt.new_string('AUTOMATIC_UPDATER_DISABLED')]))
		&& rt.is_true(rt.get_constant('AUTOMATIC_UPDATER_DISABLED')))
	return (rt.call_function('apply_filters', [
		rt.new_string('automatic_updater_disabled'),
		var_disabled.clone(),
	])).to_bool()
}

fn (mut this Class_WP_Automatic_Updater) is_allowed_dir(var_dir rt.PhpVal) bool {
	mut var_dir_mutated := var_dir
	if rt.is_true(rt.new_bool(var_dir_mutated.clone().is_string())) {
		var_dir_mutated = rt.new_string(var_dir_mutated.clone().to_string().trim_space())
	}
	if !(var_dir_mutated.clone().is_string())
		|| rt.is_true(rt.identical(rt.new_string(''), var_dir_mutated)) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The "%s" argument must be a non-empty string.'),
				]),
				rt.new_string('$dir'),
			]),
			rt.new_string('6.2.0')])
		return false
	}
	mut var_open_basedir := rt.call_function('ini_get', [rt.new_string('open_basedir')])
	if !rt.is_true(var_open_basedir) {
		return true
	}
	mut var_open_basedir_list := rt.call_function('explode', [
		rt.get_constant('PATH_SEPARATOR'),
		var_open_basedir.clone(),
	])
	mut iter_1 := var_open_basedir_list.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_basedir := item_1.val
		if rt.is_true(rt.new_bool('' != var_basedir.clone().to_string().trim_space()))
			&& rt.is_true(rt.call_function('str_starts_with', [var_dir_mutated.clone(), var_basedir.clone()])) {
			return true
		}
	}
	return false
}

fn (mut this Class_WP_Automatic_Updater) is_vcs_checkout(var_context rt.PhpVal) rt.PhpVal {
	mut var_context_mutated := var_context
	mut var_context_dirs := [
		rt.call_function('untrailingslashit', [var_context_mutated.clone()]),
	]
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_constant('ABSPATH'),
		var_context_mutated))))
	{
		var_context_dirs << rt.call_function('untrailingslashit', [
			rt.get_constant('ABSPATH'),
		])
	}
	mut var_vcs_dirs := ['.svn', '.git', '.hg', '.bzr']
	mut var_check_dirs := rt.new_array()
	for var_context_dir in var_context_dirs {
		var_context_dir = rt.call_function('dirname', [var_context_dir.clone()])
		for {
			var_check_dirs.array_push(var_context_dir.clone())
			if rt.is_true(rt.identical(rt.call_function('dirname', [
				var_context_dir.clone()]), var_context_dir))
			{
				break
			}
			if !(rt.is_true(var_context_dir)) {
				break
			}
		}
	}
	var_check_dirs = rt.call_function('array_unique', [var_check_dirs.clone()])
	mut var_checkout := rt.new_bool(false)
	for var_vcs_dir in var_vcs_dirs {
		mut iter_2 := var_check_dirs.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_check_dir := item_2.val
			if !(this.is_allowed_dir(var_check_dir.clone())) {
				continue
			}
			var_checkout = rt.call_function('is_dir', [
				rt.new_string(var_check_dir.clone().to_string().trim_right(' \t\n\r') +
					'/${var_vcs_dir}'),
			])
			if rt.is_true(var_checkout) {
				break
			}
		}
	}
	return rt.call_function('apply_filters', [
		rt.new_string('automatic_updates_is_vcs_checkout'),
		var_checkout.clone(),
		var_context_mutated.clone(),
	])
}

fn (mut this Class_WP_Automatic_Updater) should_update(var_type rt.PhpVal, var_item rt.PhpVal, var_context rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_item_mutated := var_item
	mut var_context_mutated := var_context
	mut var_skin := create_automatic_upgrader_skin()
	if this.is_disabled() {
		return false
	}
	mut var_allow_relaxed_file_ownership := rt.new_bool(false)
	if rt.is_true(rt.identical(rt.new_string('core'), var_type))
		&& !(rt.get_property(var_item_mutated, 'new_files')).is_null()
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_item_mutated, 'new_files'))))) {
		var_allow_relaxed_file_ownership = rt.new_bool(true)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_skin.request_filesystem_credentials(rt.new_bool(false), var_context_mutated.clone(), var_allow_relaxed_file_ownership.clone())))))
		|| rt.is_true(this.is_vcs_checkout(var_context_mutated.clone())) {
		if rt.is_true(rt.identical(rt.new_string('core'), var_type)) {
			this.send_core_update_notification_email(var_item_mutated.clone())
		}
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('core'), var_type)) {
		mut iife_temp_0 := Class_Core_Upgrader{}
		mut iife_result_0 := iife_temp_0.should_update_to_version(rt.get_property(var_item_mutated,
			'current'))
		mut var_update := iife_result_0
	} else if rt.is_true(rt.identical(rt.new_string('plugin'), var_type))
		|| rt.is_true(rt.identical(rt.new_string('theme'), var_type)) {
		var_update = rt.new_bool(!(!rt.is_true(rt.get_property(var_item_mutated, 'autoupdate'))))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_update))))
			&& rt.is_true(rt.call_function('wp_is_auto_update_enabled_for_type', [var_type.clone()])) {
			mut var_auto_updates := rt.cast_array(rt.call_function('get_site_option', [
				rt.new_string('auto_update_${var_type.to_string()}s'),
				rt.new_array(),
			]))
			var_update = rt.call_function('in_array', [
				rt.get_property(var_item_mutated,
					'{"nodeType":"Expr_Variable","line":228,"name":"type"}'),
				var_auto_updates.clone(),
				rt.new_bool(true),
			])
		}
	} else {
		var_update = rt.new_bool(!(!rt.is_true(rt.get_property(var_item_mutated, 'autoupdate'))))
	}
	if !(!rt.is_true(rt.get_property(var_item_mutated, 'disable_autoupdate'))) {
		var_update = rt.new_bool(false)
	}
	var_update = rt.call_function('apply_filters', [
		rt.new_string('auto_update_${var_type.to_string()}'),
		var_update.clone(),
		var_item_mutated.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_update)))) {
		if rt.is_true(rt.identical(rt.new_string('core'), var_type)) {
			this.send_core_update_notification_email(var_item_mutated.clone())
		}
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('core'), var_type)) {
		mut var_php_compat := rt.call_function('version_compare', [
			rt.get_constant('PHP_VERSION'),
			rt.get_property(var_item_mutated, 'php_version'),
			rt.new_string('>='),
		])
		if rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/db.php')]))
			&& !rt.is_true(rt.get_property(var_wpdb, 'is_mysql')) {
			mut var_mysql_compat := rt.new_bool(true)
		} else {
			var_mysql_compat = rt.call_function('version_compare', [
				rt.call_method(var_wpdb, 'db_version', []rt.PhpVal{}),
				rt.get_property(var_item_mutated, 'mysql_version'),
				rt.new_string('>='),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_php_compat))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(var_mysql_compat)))) {
			return false
		}
	}
	if rt.is_true(rt.call_function('in_array', [var_type.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'plugin' },
			rt.ArrayItem{ key: none, val: 'theme' }]),
		rt.new_bool(true)]))
	{
		if !(!rt.is_true(rt.get_property(var_item_mutated, 'requires_php')))
			&& rt.is_true(rt.call_function('version_compare', [rt.get_constant('PHP_VERSION'), rt.get_property(var_item_mutated, 'requires_php'), rt.new_string('<')])) {
			return false
		}
	}
	return true
}

fn (mut this Class_WP_Automatic_Updater) send_core_update_notification_email(var_item rt.PhpVal) bool {
	mut var_item_mutated := var_item
	mut var_notified := rt.call_function('get_site_option', [
		rt.new_string('auto_core_update_notified'),
	])
	if rt.is_true(var_notified)
		&& rt.is_true(rt.identical(rt.call_function('get_site_option', [rt.new_string('admin_email')]), var_notified.array_get(rt.new_string('email'))))
		&& rt.is_true(rt.identical(var_notified.array_get(rt.new_string('version')), rt.get_property(var_item_mutated, 'current'))) {
		return false
	}
	mut var_notify := rt.new_bool(!(!rt.is_true(rt.get_property(var_item_mutated, 'notify_email'))))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('send_core_update_notification_email'),
		var_notify.clone(),
		var_item_mutated.clone(),
	])))))
	{
		return false
	}
	this.send_email(rt.new_string('manual'), var_item_mutated.clone(), rt.new_null())
	return true
}

fn (mut this Class_WP_Automatic_Updater) update(var_type rt.PhpVal, var_item rt.PhpVal) bool {
	mut var_item_mutated := var_item
	mut var_skin := create_automatic_upgrader_skin()
	mut switch_val_1 := var_type
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('core'))) {
		rt.call_function('add_filter', [rt.new_string('update_feedback'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_skin },
				rt.ArrayItem{ key: none, val: 'feedback' }])])
		mut var_upgrader := create_core_upgrader(var_skin)
		mut var_context := rt.get_constant('ABSPATH')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('plugin'))) {
		var_upgrader = create_plugin_upgrader(var_skin)
		var_context = rt.get_constant('WP_PLUGIN_DIR')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('theme'))) {
		var_upgrader = create_theme_upgrader(var_skin)
		var_context = rt.call_function('get_theme_root', [
			rt.get_property(var_item_mutated, 'theme'),
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('translation'))) {
		var_upgrader = create_language_pack_upgrader(var_skin)
		var_context = rt.get_constant('WP_CONTENT_DIR')
	}
	if !(this.should_update(var_type.clone(), var_item_mutated.clone(), var_context.clone())) {
		return false
	}
	rt.call_function('do_action', [rt.new_string('pre_auto_update'),
		var_type.clone(), var_item_mutated.clone(), var_context.clone()])
	mut var_upgrader_item := var_item_mutated.clone()
	mut switch_val_2 := var_type
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('core'))) {
		var_skin.feedback(rt.call_function('__', [
			rt.new_string('Updating to WordPress %s'),
		]), rt.get_property(var_item_mutated, 'version'))
		mut var_item_name := rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('WordPress %s')]),
			rt.get_property(var_item_mutated, 'version'),
		])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('theme'))) {
		var_upgrader_item = rt.get_property(var_item_mutated, 'theme')
		mut var_theme := rt.call_function('wp_get_theme', [var_upgrader_item.clone()])
		var_item_name = rt.call_method(var_theme, 'get', [rt.new_string('Name')])
		rt.set_property(var_item_mutated, 'current_version', rt.call_method(var_theme, 'get', [
			rt.new_string('Version'),
		]))
		if !rt.is_true(rt.get_property(var_item_mutated, 'current_version')) {
			rt.set_property(var_item_mutated, 'current_version', rt.new_bool(false))
		}
		var_skin.feedback(rt.call_function('__', [rt.new_string('Updating theme: %s')]),
			var_item_name.clone())
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('plugin'))) {
		var_upgrader_item = rt.get_property(var_item_mutated, 'plugin')
		mut var_plugin_data := rt.call_function('get_plugin_data', [
			rt.new_string(var_context.str() + '/' + var_upgrader_item.str()),
		])
		var_item_name = var_plugin_data.array_get(rt.new_string('Name'))
		rt.set_property(var_item_mutated, 'current_version',
			var_plugin_data.array_get(rt.new_string('Version')))
		if !rt.is_true(rt.get_property(var_item_mutated, 'current_version')) {
			rt.set_property(var_item_mutated, 'current_version', rt.new_bool(false))
		}
		var_skin.feedback(rt.call_function('__', [rt.new_string('Updating plugin: %s')]),
			var_item_name.clone())
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('translation'))) {
		mut var_language_item_name := rt.call_method(var_upgrader, 'get_name_for_update', [
			var_item_mutated.clone(),
		])
		var_item_name = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Translations for %s')]),
			var_language_item_name.clone(),
		])
		var_skin.feedback(rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Updating translations for %1$s (%2$s)&#8230;'),
			]),
			var_language_item_name.clone(),
			rt.get_property(var_item_mutated, 'language'),
		]))
	}
	mut var_allow_relaxed_file_ownership := rt.new_bool(false)
	if rt.is_true(rt.identical(rt.new_string('core'), var_type))
		&& !(rt.get_property(var_item_mutated, 'new_files')).is_null()
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_item_mutated, 'new_files'))))) {
		var_allow_relaxed_file_ownership = rt.new_bool(true)
	}
	mut var_is_debug := rt.new_bool(rt.is_true(rt.get_constant('WP_DEBUG'))
		&& rt.is_true(rt.get_constant('WP_DEBUG_LOG')))
	if rt.is_true(rt.identical(rt.new_string('plugin'), var_type)) {
		mut var_was_active := rt.call_function('is_plugin_active', [
			var_upgrader_item.clone()])
		if rt.is_true(var_is_debug) {
			rt.call_function('error_log', [
				rt.new_string('    Upgrading plugin ' +
					(rt.call_function('var_export', [rt.get_property(var_item_mutated, 'slug'), rt.new_bool(true)])).str() +
					'...'),
			])
		}
	}
	if rt.is_true(rt.identical(rt.new_string('theme'), var_type)) && rt.is_true(var_is_debug) {
		rt.call_function('error_log', [
			rt.new_string('    Upgrading theme ' +
				(rt.call_function('var_export', [rt.get_property(var_item_mutated, 'theme'), rt.new_bool(true)])).str() +
				'...'),
		])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('translation'), var_type)))) {
		rt.call_method(var_upgrader, 'maintenance_mode', [rt.new_bool(true)])
	}
	mut var_upgrade_result := rt.call_method(var_upgrader, 'upgrade', [
		var_upgrader_item.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'clear_update_cache', val: false },
			rt.ArrayItem{ key: 'pre_check_md5', val: false },
			rt.ArrayItem{ key: 'attempt_rollback', val: true },
			rt.ArrayItem{ key: 'allow_relaxed_file_ownership', val: var_allow_relaxed_file_ownership },
		])])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('translation'), var_type)))) {
		rt.call_method(var_upgrader, 'maintenance_mode', [rt.new_bool(true)])
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_upgrade_result)) {
		var_upgrade_result = create_wp_error(rt.new_string('fs_unavailable'), rt.call_function('__', [
			rt.new_string('Could not access filesystem.'),
		]))
	}
	if rt.is_true(rt.identical(rt.new_string('core'), var_type)) {
		if rt.is_true(rt.call_function('is_wp_error', [var_upgrade_result.clone()]))
			&& rt.is_true(rt.identical(rt.new_string('up_to_date'), rt.call_method(var_upgrade_result, 'get_error_code', []rt.PhpVal{})))
			|| rt.is_true(rt.identical(rt.new_string('locked'), rt.call_method(var_upgrade_result, 'get_error_code', []rt.PhpVal{}))) {
			rt.call_method(var_upgrader, 'maintenance_mode', [
				rt.new_bool(false)])
			return false
		}
		if rt.is_true(rt.call_function('is_wp_error', [var_upgrade_result.clone()])) {
			rt.call_method(var_upgrade_result, 'add', [
				rt.new_string('installation_failed'),
				rt.call_function('__', [rt.new_string('Installation failed.')]),
			])
			var_skin.error(var_upgrade_result.clone())
		} else {
			var_skin.feedback(rt.call_function('__', [
				rt.new_string('WordPress updated successfully.'),
			]))
		}
	}
	var_is_debug = rt.new_bool(rt.is_true(rt.get_constant('WP_DEBUG'))
		&& rt.is_true(rt.get_constant('WP_DEBUG_LOG')))
	if rt.is_true(rt.identical(rt.new_string('theme'), var_type)) && rt.is_true(var_is_debug) {
		rt.call_function('error_log', [
			rt.new_string('    Theme ' +
				(rt.call_function('var_export', [rt.get_property(var_item_mutated, 'theme'), rt.new_bool(true)])).str() +
				' has been upgraded.'),
		])
	}
	if rt.is_true(rt.identical(rt.new_string('plugin'), var_type)) {
		if rt.is_true(var_is_debug) {
			rt.call_function('error_log', [
				rt.new_string('    Plugin ' +
					(rt.call_function('var_export', [rt.get_property(var_item_mutated, 'slug'), rt.new_bool(true)])).str() +
					' has been upgraded.'),
			])
			if rt.is_true(rt.call_function('is_plugin_inactive', [
				var_upgrader_item.clone()]))
			{
				rt.call_function('error_log', [
					rt.new_string('    ' +
						(rt.call_function('var_export', [var_upgrader_item.clone(), rt.new_bool(true)])).str() +
						' is inactive and will not be checked for fatal errors.'),
				])
			}
		}
		if rt.is_true(var_was_active)
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_upgrade_result.clone()]))))) {
			if rt.is_true(rt.call_function('function_exists', [
				rt.new_string('set_time_limit'),
			]))
			{
				rt.call_function('set_time_limit', [
					rt.mul(rt.new_int(10), rt.get_constant('MINUTE_IN_SECONDS')),
				])
			}
			rt.call_function('sleep', [rt.new_int(2)])
			if this.has_fatal_error() {
				var_upgrade_result = create_wp_error()
				mut var_temp_backup := [
					[rt.new_string('plugins'), rt.get_property(var_item_mutated, 'slug'),
						rt.get_constant('WP_PLUGIN_DIR')],
				]
				mut var_backup_restored := rt.call_method(var_upgrader, 'restore_temp_backup', [
					rt.create_array_from_list(var_temp_backup),
				])
				if rt.is_true(rt.call_function('is_wp_error', [
					var_backup_restored.clone()]))
				{
					rt.call_method(var_upgrade_result, 'add', [
						rt.new_string('plugin_update_fatal_error_rollback_failed'),
						rt.call_function('sprintf', [
							rt.call_function('__', [
								rt.new_string("The update for '%s' contained a fatal error. The previously installed version could not be restored."),
							]),
							rt.get_property(var_item_mutated, 'slug'),
						]),
					])
					rt.call_method(var_upgrade_result, 'merge_from', [
						var_backup_restored.clone()])
				} else {
					rt.call_method(var_upgrade_result, 'add', [
						rt.new_string('plugin_update_fatal_error_rollback_successful'),
						rt.call_function('sprintf', [
							rt.call_function('__', [
								rt.new_string("The update for '%s' contained a fatal error. The previously installed version has been restored."),
							]),
							rt.get_property(var_item_mutated, 'slug'),
						]),
					])
					mut var_backup_deleted := rt.call_method(var_upgrader, 'delete_temp_backup', [
						rt.create_array_from_list(var_temp_backup),
					])
					if rt.is_true(rt.call_function('is_wp_error', [
						var_backup_deleted.clone()]))
					{
						rt.call_method(var_upgrade_result, 'merge_from', [
							var_backup_deleted.clone()])
					}
				}
				if rt.is_true(var_is_debug) {
					rt.call_function('error_log', [
						rt.new_string('    ' +(rt.call_function('implode', [rt.new_string('\n'), rt.call_method(var_upgrade_result, 'get_error_messages', []rt.PhpVal{})])).str()),
					])
				}
			} else if rt.is_true(var_is_debug) {
				rt.call_function('error_log', [
					rt.new_string('    The update for ' +
						(rt.call_function('var_export', [rt.get_property(var_item_mutated, 'slug'), rt.new_bool(true)])).str() +
						' has no fatal errors.'),
				])
			}
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('translation'), var_type)))) {
		rt.call_method(var_upgrader, 'maintenance_mode', [rt.new_bool(false)])
	}
	this.update_results.array_get_mut(var_type).array_push(rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'item', val: var_item_mutated },
		rt.ArrayItem{ key: 'result', val: var_upgrade_result },
		rt.ArrayItem{ key: 'name', val: var_item_name },
		rt.ArrayItem{ key: 'messages', val: var_skin.get_upgrade_messages() },
	])))
	return var_upgrade_result.to_bool()
}

fn (mut this Class_WP_Automatic_Updater) run() {
	if this.is_disabled() {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_main_network', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_main_site', []rt.PhpVal{}))))) {
		return
	}
	mut iife_temp_1 := Class_WP_Upgrader{}
	mut iife_result_1 := iife_temp_1.create_lock(rt.new_string('auto_updater'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_1)))) {
		return
	}
	mut var_is_debug := rt.new_bool(rt.is_true(rt.get_constant('WP_DEBUG'))
		&& rt.is_true(rt.get_constant('WP_DEBUG_LOG')))
	if rt.is_true(var_is_debug) {
		rt.call_function('error_log', [rt.new_string('Automatic updates starting...')])
	}
	rt.call_function('remove_action', [rt.new_string('upgrader_process_complete'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'Language_Pack_Upgrader' },
			rt.ArrayItem{ key: none, val: 'async_upgrade' }]),
		rt.new_int(20)])
	rt.call_function('remove_action', [rt.new_string('upgrader_process_complete'),
		rt.new_string('wp_version_check')])
	rt.call_function('remove_action', [rt.new_string('upgrader_process_complete'),
		rt.new_string('wp_update_plugins')])
	rt.call_function('remove_action', [rt.new_string('upgrader_process_complete'),
		rt.new_string('wp_update_themes')])
	rt.call_function('wp_update_plugins', []rt.PhpVal{})
	mut var_plugin_updates := rt.call_function('get_site_transient', [
		rt.new_string('update_plugins'),
	])
	if rt.is_true(var_plugin_updates)
		&& !(!rt.is_true(rt.get_property(var_plugin_updates, 'response'))) {
		if rt.is_true(var_is_debug) {
			rt.call_function('error_log', [
				rt.new_string('  Automatic plugin updates starting...'),
			])
		}
		mut iter_3 := rt.get_property(var_plugin_updates, 'response').iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_plugin := item_3.val
			this.update(rt.new_string('plugin'), var_plugin.clone())
		}
		rt.call_function('wp_clean_plugins_cache', []rt.PhpVal{})
		if rt.is_true(var_is_debug) {
			rt.call_function('error_log', [
				rt.new_string('  Automatic plugin updates complete.'),
			])
		}
	}
	rt.call_function('wp_update_themes', []rt.PhpVal{})
	mut var_theme_updates := rt.call_function('get_site_transient', [
		rt.new_string('update_themes'),
	])
	if rt.is_true(var_theme_updates)
		&& !(!rt.is_true(rt.get_property(var_theme_updates, 'response'))) {
		if rt.is_true(var_is_debug) {
			rt.call_function('error_log', [
				rt.new_string('  Automatic theme updates starting...'),
			])
		}
		mut iter_4 := rt.get_property(var_theme_updates, 'response').iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_theme := item_4.val
			this.update(rt.new_string('theme'), rt.new_object('stdClass', []string{},
				rt.array_to_object(var_theme)))
		}
		rt.call_function('wp_clean_themes_cache', []rt.PhpVal{})
		if rt.is_true(var_is_debug) {
			rt.call_function('error_log', [
				rt.new_string('  Automatic theme updates complete.'),
			])
		}
	}
	if rt.is_true(var_is_debug) {
		rt.call_function('error_log', [rt.new_string('Automatic updates complete.')])
	}
	rt.call_function('wp_version_check', []rt.PhpVal{})
	mut var_core_update := rt.call_function('find_core_auto_update', []rt.PhpVal{})
	if rt.is_true(var_core_update) {
		this.update(rt.new_string('core'), var_core_update.clone())
	}
	mut var_theme_stats := rt.new_array()
	if this.update_results.array_isset(rt.new_string('theme')) {
		mut iter_5 := this.update_results.array_get(rt.new_string('theme')).iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_upgrade := item_5.val
			var_theme_stats.array_set(rt.get_property(rt.get_property(var_upgrade, 'item'), 'theme'), rt.identical(rt.new_bool(true), rt.get_property(var_upgrade,
				'result')))
		}
	}
	rt.call_function('wp_update_themes', [var_theme_stats.clone()])
	mut var_plugin_stats := rt.new_array()
	if this.update_results.array_isset(rt.new_string('plugin')) {
		mut iter_6 := this.update_results.array_get(rt.new_string('plugin')).iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_upgrade := item_6.val
			var_plugin_stats.array_set(rt.get_property(rt.get_property(var_upgrade, 'item'),
				'plugin'), rt.identical(rt.new_bool(true), rt.get_property(var_upgrade, 'result')))
		}
	}
	rt.call_function('wp_update_plugins', [var_plugin_stats.clone()])
	mut var_language_updates := rt.call_function('wp_get_translation_updates', []rt.PhpVal{})
	if rt.is_true(var_language_updates) {
		mut iter_7 := var_language_updates.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_update := item_7.val
			this.update(rt.new_string('translation'), var_update.clone())
		}
		rt.call_function('wp_clean_update_cache', []rt.PhpVal{})
		rt.call_function('wp_version_check', []rt.PhpVal{})
		rt.call_function('wp_update_themes', []rt.PhpVal{})
		rt.call_function('wp_update_plugins', []rt.PhpVal{})
	}
	if !(!rt.is_true(this.update_results)) {
		mut var_development_version := rt.call_function('str_contains', [
			rt.call_function('wp_get_wp_version', []rt.PhpVal{}),
			rt.new_string('-'),
		])
		if rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('automatic_updates_send_debug_email'),
			var_development_version.clone(),
		]))
		{
			this.send_debug_email()
		}
		if !(!rt.is_true(this.update_results.array_get(rt.new_string('core')))) {
			this.after_core_update(this.update_results.array_get(rt.new_string('core')).array_get(rt.new_int(0)))
		} else if !(!rt.is_true(this.update_results.array_get(rt.new_string('plugin'))))
			|| !(!rt.is_true(this.update_results.array_get(rt.new_string('theme')))) {
			this.after_plugin_theme_update(this.update_results)
		}
		rt.call_function('do_action',
			[rt.new_string('automatic_updates_complete'), this.update_results])
	}
	mut iife_temp_2 := Class_WP_Upgrader{}
	mut iife_result_2 := iife_temp_2.release_lock(rt.new_string('auto_updater'))
}

fn (mut this Class_WP_Automatic_Updater) after_core_update(var_update_result rt.PhpVal) {
	mut var_wp_version := rt.call_function('wp_get_wp_version', []rt.PhpVal{})
	mut var_core_update := rt.get_property(var_update_result, 'item')
	mut var_result := rt.get_property(var_update_result, 'result')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
		var_result.clone()])))))
	{
		this.send_email(rt.new_string('success'), var_core_update.clone(), rt.new_null())
		return
	}
	mut var_error_code := rt.call_method(var_result, 'get_error_code', []rt.PhpVal{})
	mut var_critical := rt.new_bool(false)
	if rt.is_true(rt.identical(rt.new_string('disk_full'), var_error_code))
		|| rt.is_true(rt.call_function('str_contains', [var_error_code.clone(), rt.new_string('__copy_dir')])) {
		var_critical = rt.new_bool(true)
	} else if rt.is_true(rt.identical(rt.new_string('rollback_was_required'), var_error_code))
		&& rt.is_true(rt.call_function('is_wp_error', [rt.get_property(rt.call_method(var_result, 'get_error_data', []rt.PhpVal{}), 'rollback')])) {
		var_critical = rt.new_bool(true)
		mut var_rollback_result := rt.get_property(rt.call_method(var_result, 'get_error_data',
			[]rt.PhpVal{}), 'rollback')
	} else if rt.is_true(rt.call_function('str_contains', [var_error_code.clone(),
		rt.new_string('do_rollback')]))
	{
		var_critical = rt.new_bool(true)
	}
	if rt.is_true(var_critical) {
		mut var_critical_data := {
			'attempted':  rt.get_property(var_core_update, 'current')
			'current':    var_wp_version
			'error_code': var_error_code
			'error_data': rt.call_method(var_result, 'get_error_data', []rt.PhpVal{})
			'timestamp':  rt.call_function('time', []rt.PhpVal{})
			'critical':   rt.new_bool(true)
		}
		if !var_rollback_result.is_null() {
			var_critical_data['rollback_code'] = rt.call_method(var_rollback_result,
				'get_error_code', []rt.PhpVal{})
			var_critical_data['rollback_data'] = rt.call_method(var_rollback_result,
				'get_error_data', []rt.PhpVal{})
		}
		rt.call_function('update_site_option', [rt.new_string('auto_core_update_failed'),
			rt.create_array_from_native_map(var_critical_data)])
		this.send_email(rt.new_string('critical'), var_core_update.clone(), var_result.clone())
		return
	}
	mut var_send := rt.new_bool(true)
	mut var_transient_failures := ['incompatible_archive', 'download_failed', 'insane_distro',
		'locked']
	if rt.is_true(rt.call_function('in_array', [var_error_code.clone(), rt.create_array_from_list(var_transient_failures), rt.new_bool(true)]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_site_option', [rt.new_string('auto_core_update_failed')]))))) {
		rt.call_function('wp_schedule_single_event', [
			rt.add(rt.call_function('time', []rt.PhpVal{}), rt.get_constant('HOUR_IN_SECONDS')),
			rt.new_string('wp_maybe_auto_update'),
		])
		var_send = rt.new_bool(false)
	}
	mut var_notified := rt.call_function('get_site_option', [
		rt.new_string('auto_core_update_notified'),
	])
	if rt.is_true(var_notified)
		&& rt.is_true(rt.identical(rt.new_string('fail'), var_notified.array_get(rt.new_string('type'))))
		&& rt.is_true(rt.identical(rt.call_function('get_site_option', [rt.new_string('admin_email')]), var_notified.array_get(rt.new_string('email'))))
		&& rt.is_true(rt.identical(var_notified.array_get(rt.new_string('version')), rt.get_property(var_core_update, 'current'))) {
		var_send = rt.new_bool(false)
	}
	rt.call_function('update_site_option', [rt.new_string('auto_core_update_failed'),
		rt.create_array([
			rt.ArrayItem{ key: 'attempted', val: rt.get_property(var_core_update, 'current') },
			rt.ArrayItem{ key: 'current', val: var_wp_version },
			rt.ArrayItem{ key: 'error_code', val: var_error_code },
			rt.ArrayItem{ key: 'error_data', val: rt.call_method(var_result, 'get_error_data',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'timestamp', val: rt.call_function('time', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'retry', val: rt.call_function('in_array', [
				var_error_code.clone(), rt.create_array_from_list(var_transient_failures),
				rt.new_bool(true)]) },
		])])
	if rt.is_true(var_send) {
		this.send_email(rt.new_string('fail'), var_core_update.clone(), var_result.clone())
	}
}

fn (mut this Class_WP_Automatic_Updater) send_email(var_type rt.PhpVal, var_core_update rt.PhpVal, var_result rt.PhpVal) {
	mut var_about_version := rt.new_null()
	mut var_core_update_mutated := var_core_update
	mut var_result_mutated := var_result
	rt.call_function('update_site_option', [rt.new_string('auto_core_update_notified'),
		rt.create_array([rt.ArrayItem{ key: 'type', val: var_type },
			rt.ArrayItem{ key: 'email', val: rt.call_function('get_site_option', [
				rt.new_string('admin_email'),
			]) }, rt.ArrayItem{ key: 'version', val: rt.get_property(var_core_update_mutated,
				'current') }, rt.ArrayItem{ key: 'timestamp', val: rt.call_function('time',
				[]rt.PhpVal{}) }])])
	mut var_next_user_core_update := rt.call_function('get_preferred_from_update_core',
		[]rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_next_user_core_update)))) {
		var_next_user_core_update = var_core_update_mutated.clone()
	}
	if rt.is_true(rt.identical(rt.new_string('upgrade'), rt.get_property(var_next_user_core_update, 'response')))
		&& rt.is_true(rt.call_function('version_compare', [rt.get_property(var_next_user_core_update, 'version'), rt.get_property(var_core_update_mutated, 'version'), rt.new_string('>')])) {
		mut var_newer_version_available := rt.new_bool(true)
	} else {
		var_newer_version_available = rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('manual'), var_type))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('auto_core_update_send_email'), rt.new_bool(true), var_type.clone(), var_core_update_mutated.clone(), var_result_mutated.clone()]))))) {
		return
	}
	mut var_admin_user := rt.call_function('get_user_by', [rt.new_string('email'),
		rt.call_function('get_site_option', [rt.new_string('admin_email')])])
	if rt.is_true(var_admin_user) {
		mut var_switched_locale := rt.call_function('switch_to_user_locale', [
			rt.get_property(var_admin_user, 'ID'),
		])
	} else {
		var_switched_locale = rt.call_function('switch_to_locale', [
			rt.call_function('get_locale', []rt.PhpVal{}),
		])
	}
	mut switch_val_3 := var_type
	if rt.is_true(rt.equal(switch_val_3, rt.new_string('success'))) {
		mut var_subject := rt.call_function('__', [
			rt.new_string('[%1$s] Your site has updated to WordPress %2$s'),
		])
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('fail')))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_string('manual'))) {
		var_subject = rt.call_function('__', [
			rt.new_string('[%1$s] WordPress %2$s is available. Please update!'),
		])
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('critical'))) {
		var_subject = rt.call_function('__', [
			rt.new_string('[%1$s] URGENT: Your site may be down due to a failed update'),
		])
	} else {
		return
	}
	mut var_version := if rt.is_true(rt.identical(rt.new_string('success'), var_type)) {
		rt.get_property(var_core_update_mutated, 'current')
	} else {
		rt.get_property(var_next_user_core_update, 'current')
	}
	var_subject = rt.call_function('sprintf', [var_subject.clone(),
		rt.call_function('wp_specialchars_decode', [
			rt.call_function('get_option', [rt.new_string('blogname')]),
			rt.get_constant('ENT_QUOTES'),
		]),
		var_version.clone()])
	mut var_body := rt.new_string('')
	mut switch_val_4 := var_type
	if rt.is_true(rt.equal(switch_val_4, rt.new_string('success'))) {
		var_body = rt.concat(var_body, rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Howdy! Your site at %1$s has been updated automatically to WordPress %2$s.'),
			]),
			rt.call_function('home_url', []rt.PhpVal{}),
			rt.get_property(var_core_update_mutated, 'current'),
		]))
		var_body = rt.concat(var_body, rt.new_string('\n\n'))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_newer_version_available)))) {
			var_body = rt.concat(var_body, rt.new_string(
				(rt.call_function('__', [rt.new_string('No further action is needed on your part.')])).str() +
				' '))
		}
		mut list_tmp_1 := rt.call_function('explode', [rt.new_string('-'),
			rt.get_property(var_core_update_mutated, 'current'),
			rt.new_int(2)])
		var_about_version = list_tmp_1.array_get(0)
		var_body = rt.concat(var_body, rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('For more on version %s, see the About WordPress screen:'),
			]),
			var_about_version.clone(),
		]))
		var_body = rt.concat(var_body, rt.new_string('\n' +
			(rt.call_function('admin_url', [rt.new_string('about.php')])).str()))
		if rt.is_true(var_newer_version_available) {
			var_body = rt.concat(var_body, rt.new_string('\n\n' +
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('WordPress %s is also now available.')]), rt.get_property(var_next_user_core_update, 'current')])).str() +
				' '))
			var_body = rt.concat(var_body, rt.call_function('__', [
				rt.new_string('Updating is easy and only takes a few moments:'),
			]))
			var_body = rt.concat(var_body, rt.new_string('\n' +
				(rt.call_function('network_admin_url', [rt.new_string('update-core.php')])).str()))
		}
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('fail')))
		|| rt.is_true(rt.equal(switch_val_4, rt.new_string('manual'))) {
		var_body = rt.concat(var_body, rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Please update your site at %1$s to WordPress %2$s.'),
			]),
			rt.call_function('home_url', []rt.PhpVal{}),
			rt.get_property(var_next_user_core_update, 'current'),
		]))
		var_body = rt.concat(var_body, rt.new_string('\n\n'))
		if rt.is_true(rt.identical(rt.new_string('fail'), var_type))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_newer_version_available)))) {
			var_body = rt.concat(var_body, rt.new_string(
				(rt.call_function('__', [rt.new_string('An attempt was made, but your site could not be updated automatically.')])).str() +
				' '))
		}
		var_body = rt.concat(var_body, rt.call_function('__', [
			rt.new_string('Updating is easy and only takes a few moments:'),
		]))
		var_body = rt.concat(var_body, rt.new_string('\n' +
			(rt.call_function('network_admin_url', [rt.new_string('update-core.php')])).str()))
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('critical'))) {
		if rt.is_true(var_newer_version_available) {
			var_body = rt.concat(var_body, rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Your site at %1$s experienced a critical failure while trying to update WordPress to version %2$s.'),
				]),
				rt.call_function('home_url', []rt.PhpVal{}),
				rt.get_property(var_core_update_mutated, 'current'),
			]))
		} else {
			var_body = rt.concat(var_body, rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Your site at %1$s experienced a critical failure while trying to update to the latest version of WordPress, %2$s.'),
				]),
				rt.call_function('home_url', []rt.PhpVal{}),
				rt.get_property(var_core_update_mutated, 'current'),
			]))
		}
		var_body = rt.concat(var_body,
			rt.new_string('\n\n' +(rt.call_function('__', [rt.new_string("This means your site may be offline or broken. Don't panic; this can be fixed.")])).str()))
		var_body = rt.concat(var_body,
			rt.new_string('\n\n' +(rt.call_function('__', [rt.new_string("Please check out your site now. It's possible that everything is working. If it says you need to update, you should do so:")])).str()))
		var_body = rt.concat(var_body, rt.new_string('\n' +
			(rt.call_function('network_admin_url', [rt.new_string('update-core.php')])).str()))
	}
	mut var_critical_support := rt.new_bool(
		rt.is_true(rt.identical(rt.new_string('critical'), var_type))
		&& !(!rt.is_true(rt.get_property(var_core_update_mutated, 'support_email'))))
	if rt.is_true(var_critical_support) {
		var_body = rt.concat(var_body,
			rt.new_string('\n\n' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The WordPress team is willing to help you. Forward this email to %s and the team will work with you to make sure your site is working.')]), rt.get_property(var_core_update_mutated, 'support_email')])).str()))
	} else {
		var_body = rt.concat(var_body,
			rt.new_string('\n\n' +(rt.call_function('__', [rt.new_string('If you experience any issues or need support, the volunteers in the WordPress.org support forums may be able to help.')])).str()))
		var_body = rt.concat(var_body, rt.new_string('\n' +
			(rt.call_function('__', [rt.new_string('https://wordpress.org/support/forums/')])).str()))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('success'), var_type))))
		|| rt.is_true(var_newer_version_available) {
		var_body = rt.concat(var_body,
			rt.new_string('\n\n' +(rt.call_function('__', [rt.new_string('Keeping your site updated is important for security. It also makes the internet a safer place for you and your readers.')])).str()))
	}
	if rt.is_true(var_critical_support) {
		var_body = rt.concat(var_body,
			rt.new_string(' ' +(rt.call_function('__', [rt.new_string("Reach out to WordPress Core developers to ensure you'll never have this problem again.")])).str()))
	}
	if rt.is_true(rt.identical(rt.new_string('success'), var_type))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_newer_version_available))))
		&& rt.is_true(rt.call_function('get_plugin_updates', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('get_theme_updates', []rt.PhpVal{})) {
		var_body = rt.concat(var_body,
			rt.new_string('\n\n' +(rt.call_function('__', [rt.new_string('You also have some plugins or themes with updates available. Update them now:')])).str()))
		var_body = rt.concat(var_body, rt.new_string('\n' +
			(rt.call_function('network_admin_url', []rt.PhpVal{})).str()))
	}
	var_body = rt.concat(var_body, rt.new_string('\n\n' +
		(rt.call_function('__', [rt.new_string('The WordPress Team')])).str() + '\n'))
	if rt.is_true(rt.identical(rt.new_string('critical'), var_type))
		&& rt.is_true(rt.call_function('is_wp_error', [var_result_mutated.clone()])) {
		var_body = rt.concat(var_body, rt.new_string('\n***\n\n'))
		var_body = rt.concat(var_body, rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Your site was running version %s.')]),
			rt.call_function('get_bloginfo', [rt.new_string('version')]),
		]))
		var_body = rt.concat(var_body,
			rt.new_string(' ' +(rt.call_function('__', [rt.new_string('Some data that describes the error your site encountered has been put together.')])).str()))
		var_body = rt.concat(var_body,
			rt.new_string(' ' +(rt.call_function('__', [rt.new_string('Your hosting company, support forum volunteers, or a friendly developer may be able to use this information to help you:')])).str()))
		if rt.is_true(rt.identical(rt.new_string('rollback_was_required'), rt.call_method(var_result_mutated,
			'get_error_code', []rt.PhpVal{})))
		{
			mut var_errors := [var_result_mutated,
				rt.get_property(rt.call_method(var_result_mutated, 'get_error_data', []rt.PhpVal{}),
					'update'),
				rt.get_property(rt.call_method(var_result_mutated, 'get_error_data', []rt.PhpVal{}),
					'rollback')]
		} else {
			var_errors = [var_result_mutated]
		}
		for var_error in var_errors {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
				var_error.clone(),
			])))))
			{
				continue
			}
			mut var_error_code := rt.call_method(var_error, 'get_error_code', []rt.PhpVal{})
			var_body = rt.concat(var_body,
				rt.new_string('\n\n' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Error code: %s')]), var_error_code.clone()])).str()))
			if rt.is_true(rt.identical(rt.new_string('rollback_was_required'), var_error_code)) {
				continue
			}
			if rt.is_true(rt.call_method(var_error, 'get_error_message', []rt.PhpVal{})) {
				var_body = rt.concat(var_body, rt.new_string('\n' +
					(rt.call_method(var_error, 'get_error_message', []rt.PhpVal{})).str()))
			}
			mut var_error_data := rt.call_method(var_error, 'get_error_data', []rt.PhpVal{})
			if rt.is_true(var_error_data) {
				var_body = rt.concat(var_body,
					rt.new_string('\n' +(rt.call_function('implode', [rt.new_string(', '), rt.cast_array(var_error_data)])).str()))
			}
		}
		var_body = rt.concat(var_body, rt.new_string('\n'))
	}
	mut var_to := rt.call_function('get_site_option', [rt.new_string('admin_email')])
	mut var_headers := rt.new_string('')
	mut var_email := rt.call_function('compact', [rt.new_string('to'),
		rt.new_string('subject'), rt.new_string('body'), rt.new_string('headers')])
	var_email = rt.call_function('apply_filters', [
		rt.new_string('auto_core_update_email'),
		var_email.clone(),
		var_type.clone(),
		var_core_update_mutated.clone(),
		var_result_mutated.clone(),
	])
	rt.call_function('wp_mail', [var_email.array_get(rt.new_string('to')),
		rt.call_function('wp_specialchars_decode', [
			var_email.array_get(rt.new_string('subject')),
		]),
		var_email.array_get(rt.new_string('body')), var_email.array_get(rt.new_string('headers'))])
	if rt.is_true(var_switched_locale) {
		rt.call_function('restore_previous_locale', []rt.PhpVal{})
	}
}

fn (mut this Class_WP_Automatic_Updater) after_plugin_theme_update(var_update_results rt.PhpVal) {
	mut var_successful_updates := rt.new_array()
	mut var_failed_updates := rt.new_array()
	if !(!rt.is_true(var_update_results.array_get(rt.new_string('plugin')))) {
		mut var_notifications_enabled := rt.call_function('apply_filters', [
			rt.new_string('auto_plugin_update_send_email'),
			rt.new_bool(true),
			var_update_results.array_get(rt.new_string('plugin')),
		])
		if rt.is_true(var_notifications_enabled) {
			mut iter_8 := var_update_results.array_get(rt.new_string('plugin')).iterator()
			for {
				item_8 := iter_8.next() or { break }
				mut var_update_result := item_8.val
				if rt.is_true(rt.identical(rt.new_bool(true), rt.get_property(var_update_result,
					'result')))
				{
					var_successful_updates.array_get_mut('plugin').array_push(var_update_result.clone())
				} else {
					var_failed_updates.array_get_mut('plugin').array_push(var_update_result.clone())
				}
			}
		}
	}
	if !(!rt.is_true(var_update_results.array_get(rt.new_string('theme')))) {
		var_notifications_enabled = rt.call_function('apply_filters', [
			rt.new_string('auto_theme_update_send_email'),
			rt.new_bool(true),
			var_update_results.array_get(rt.new_string('theme')),
		])
		if rt.is_true(var_notifications_enabled) {
			mut iter_9 := var_update_results.array_get(rt.new_string('theme')).iterator()
			for {
				item_9 := iter_9.next() or { break }
				mut var_update_result := item_9.val
				if rt.is_true(rt.identical(rt.new_bool(true), rt.get_property(var_update_result,
					'result')))
				{
					var_successful_updates.array_get_mut('theme').array_push(var_update_result.clone())
				} else {
					var_failed_updates.array_get_mut('theme').array_push(var_update_result.clone())
				}
			}
		}
	}
	if !rt.is_true(var_successful_updates) && !rt.is_true(var_failed_updates) {
		return
	}
	if !rt.is_true(var_failed_updates) {
		this.send_plugin_theme_email(rt.new_string('success'), var_successful_updates.clone(),
			var_failed_updates.clone())
	} else if !rt.is_true(var_successful_updates) {
		this.send_plugin_theme_email(rt.new_string('fail'), var_successful_updates.clone(),
			var_failed_updates.clone())
	} else {
		this.send_plugin_theme_email(rt.new_string('mixed'), var_successful_updates.clone(),
			var_failed_updates.clone())
	}
}

fn (mut this Class_WP_Automatic_Updater) send_plugin_theme_email(var_type rt.PhpVal, var_successful_updates rt.PhpVal, var_failed_updates rt.PhpVal) {
	mut var_successful_updates_mutated := var_successful_updates
	mut var_failed_updates_mutated := var_failed_updates
	if !rt.is_true(var_successful_updates_mutated) && !rt.is_true(var_failed_updates_mutated) {
		return
	}
	mut var_unique_failures := rt.new_bool(false)
	mut var_past_failure_emails := rt.call_function('get_option', [
		rt.new_string('auto_plugin_theme_update_emails'),
		rt.new_array(),
	])
	if rt.is_true(rt.identical(rt.new_string('fail'), var_type)) {
		mut iter_10 := var_failed_updates_mutated.iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_failures := item_10.val
			mut var_update_type := item_10.key
			mut iter_11 := var_failures.iterator()
			for {
				item_11 := iter_11.next() or { break }
				mut var_failed_update := item_11.val
				if !(var_past_failure_emails.array_isset(rt.get_property(rt.get_property(var_failed_update,
					'item'), '{"nodeType":"Expr_Variable","line":1252,"name":"update_type"}'))) {
					var_unique_failures = rt.new_bool(true)
					continue
				}
				if rt.is_true(rt.call_function('version_compare', [
					var_past_failure_emails.array_get(rt.get_property(rt.get_property(var_failed_update,
						'item'), '{"nodeType":"Expr_Variable","line":1258,"name":"update_type"}')),
					rt.get_property(rt.get_property(var_failed_update, 'item'), 'new_version'),
					rt.new_string('<'),
				]))
				{
					var_unique_failures = rt.new_bool(true)
				}
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_unique_failures)))) {
			return
		}
	}
	mut var_admin_user := rt.call_function('get_user_by', [rt.new_string('email'),
		rt.call_function('get_site_option', [rt.new_string('admin_email')])])
	if rt.is_true(var_admin_user) {
		mut var_switched_locale := rt.call_function('switch_to_user_locale', [
			rt.get_property(var_admin_user, 'ID'),
		])
	} else {
		var_switched_locale = rt.call_function('switch_to_locale', [
			rt.call_function('get_locale', []rt.PhpVal{}),
		])
	}
	mut var_body := rt.new_array()
	mut var_successful_plugins :=
		rt.new_bool(!(!rt.is_true(var_successful_updates_mutated.array_get(rt.new_string('plugin')))))
	mut var_successful_themes :=
		rt.new_bool(!(!rt.is_true(var_successful_updates_mutated.array_get(rt.new_string('theme')))))
	mut var_failed_plugins :=
		rt.new_bool(!(!rt.is_true(var_failed_updates_mutated.array_get(rt.new_string('plugin')))))
	mut var_failed_themes :=
		rt.new_bool(!(!rt.is_true(var_failed_updates_mutated.array_get(rt.new_string('theme')))))
	mut switch_val_5 := var_type
	if rt.is_true(rt.equal(switch_val_5, rt.new_string('success'))) {
		if rt.is_true(var_successful_plugins) && rt.is_true(var_successful_themes) {
			mut var_subject := rt.call_function('__', [
				rt.new_string('[%s] Some plugins and themes have automatically updated'),
			])
			var_body.array_push(rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Howdy! Some plugins and themes have automatically updated to their latest versions on your site at %s. No further action is needed on your part.'),
				]),
				rt.call_function('home_url', []rt.PhpVal{}),
			]))
		} else if rt.is_true(var_successful_plugins) {
			var_subject = rt.call_function('__', [
				rt.new_string('[%s] Some plugins were automatically updated'),
			])
			var_body.array_push(rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Howdy! Some plugins have automatically updated to their latest versions on your site at %s. No further action is needed on your part.'),
				]),
				rt.call_function('home_url', []rt.PhpVal{}),
			]))
		} else {
			var_subject = rt.call_function('__', [
				rt.new_string('[%s] Some themes were automatically updated'),
			])
			var_body.array_push(rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Howdy! Some themes have automatically updated to their latest versions on your site at %s. No further action is needed on your part.'),
				]),
				rt.call_function('home_url', []rt.PhpVal{}),
			]))
		}
	} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('fail')))
		|| rt.is_true(rt.equal(switch_val_5, rt.new_string('mixed'))) {
		if rt.is_true(var_failed_plugins) && rt.is_true(var_failed_themes) {
			var_subject = rt.call_function('__', [
				rt.new_string('[%s] Some plugins and themes have failed to update'),
			])
			var_body.array_push(rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Howdy! Plugins and themes failed to update on your site at %s.'),
				]),
				rt.call_function('home_url', []rt.PhpVal{}),
			]))
		} else if rt.is_true(var_failed_plugins) {
			var_subject = rt.call_function('__', [
				rt.new_string('[%s] Some plugins have failed to update'),
			])
			var_body.array_push(rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Howdy! Plugins failed to update on your site at %s.'),
				]),
				rt.call_function('home_url', []rt.PhpVal{}),
			]))
		} else {
			var_subject = rt.call_function('__', [
				rt.new_string('[%s] Some themes have failed to update'),
			])
			var_body.array_push(rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Howdy! Themes failed to update on your site at %s.'),
				]),
				rt.call_function('home_url', []rt.PhpVal{}),
			]))
		}
	}
	if rt.is_true(rt.call_function('in_array', [var_type.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'fail' },
			rt.ArrayItem{ key: none, val: 'mixed' }]),
		rt.new_bool(true)]))
	{
		var_body.array_push('\n')
		var_body.array_push(rt.call_function('__', [
			rt.new_string('Please check your site now. It’s possible that everything is working. If there are updates available, you should update.'),
		]))
		var_body.array_push('\n')
		if !(!rt.is_true(var_failed_updates_mutated.array_get(rt.new_string('plugin')))) {
			var_body.array_push(rt.call_function('__', [
				rt.new_string('The following plugins failed to update. If there was a fatal error in the update, the previously installed version has been restored.'),
			]))
			mut iter_12 := var_failed_updates_mutated.array_get(rt.new_string('plugin')).iterator()
			for {
				item_12 := iter_12.next() or { break }
				mut var_item := item_12.val
				mut var_body_message := rt.new_string('')
				mut var_item_url := rt.new_string('')
				if !(!rt.is_true(rt.get_property(rt.get_property(var_item, 'item'), 'url'))) {
					var_item_url =
						rt.new_string(' : ' +(rt.call_function('esc_url', [rt.get_property(rt.get_property(var_item, 'item'), 'url')])).str())
				}
				if rt.is_true(rt.get_property(rt.get_property(var_item, 'item'), 'current_version')) {
					var_body_message = rt.concat(var_body_message, rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('- %1$s (from version %2$s to %3$s)%4$s'),
						]),
						rt.call_function('html_entity_decode', [
							rt.get_property(var_item, 'name'),
						]),
						rt.get_property(rt.get_property(var_item, 'item'), 'current_version'),
						rt.get_property(rt.get_property(var_item, 'item'), 'new_version'),
						var_item_url.clone(),
					]))
				} else {
					var_body_message = rt.concat(var_body_message, rt.call_function('sprintf', [
						rt.call_function('__', [rt.new_string('- %1$s version %2$s%3$s')]),
						rt.call_function('html_entity_decode', [
							rt.get_property(var_item, 'name')]),
						rt.get_property(rt.get_property(var_item, 'item'), 'new_version'),
						var_item_url.clone(),
					]))
				}
				var_body.array_push(var_body_message.clone())
				var_past_failure_emails.array_set(rt.get_property(rt.get_property(var_item, 'item'),
					'plugin'), rt.get_property(rt.get_property(var_item, 'item'), 'new_version'))
			}
			var_body.array_push('\n')
		}
		if !(!rt.is_true(var_failed_updates_mutated.array_get(rt.new_string('theme')))) {
			var_body.array_push(rt.call_function('__', [
				rt.new_string('These themes failed to update:'),
			]))
			mut iter_13 := var_failed_updates_mutated.array_get(rt.new_string('theme')).iterator()
			for {
				item_13 := iter_13.next() or { break }
				mut var_item := item_13.val
				if rt.is_true(rt.get_property(rt.get_property(var_item, 'item'), 'current_version')) {
					var_body.array_push(rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('- %1$s (from version %2$s to %3$s)'),
						]),
						rt.call_function('html_entity_decode', [
							rt.get_property(var_item, 'name'),
						]),
						rt.get_property(rt.get_property(var_item, 'item'), 'current_version'),
						rt.get_property(rt.get_property(var_item, 'item'), 'new_version'),
					]))
				} else {
					var_body.array_push(rt.call_function('sprintf', [
						rt.call_function('__', [rt.new_string('- %1$s version %2$s')]),
						rt.call_function('html_entity_decode', [
							rt.get_property(var_item, 'name')]),
						rt.get_property(rt.get_property(var_item, 'item'), 'new_version'),
					]))
				}
				var_past_failure_emails.array_set(rt.get_property(rt.get_property(var_item, 'item'),
					'theme'), rt.get_property(rt.get_property(var_item, 'item'), 'new_version'))
			}
			var_body.array_push('\n')
		}
	}
	if rt.is_true(rt.call_function('in_array', [var_type.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'success' },
			rt.ArrayItem{ key: none, val: 'mixed' }]),
		rt.new_bool(true)]))
	{
		var_body.array_push('\n')
		if !(!rt.is_true(var_successful_updates_mutated.array_get(rt.new_string('plugin')))) {
			var_body.array_push(rt.call_function('__', [
				rt.new_string('These plugins are now up to date:'),
			]))
			mut iter_14 :=
				var_successful_updates_mutated.array_get(rt.new_string('plugin')).iterator()
			for {
				item_14 := iter_14.next() or { break }
				mut var_item := item_14.val
				mut var_body_message := rt.new_string('')
				mut var_item_url := rt.new_string('')
				if !(!rt.is_true(rt.get_property(rt.get_property(var_item, 'item'), 'url'))) {
					var_item_url =
						rt.new_string(' : ' +(rt.call_function('esc_url', [rt.get_property(rt.get_property(var_item, 'item'), 'url')])).str())
				}
				if rt.is_true(rt.get_property(rt.get_property(var_item, 'item'), 'current_version')) {
					var_body_message = rt.concat(var_body_message, rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('- %1$s (from version %2$s to %3$s)%4$s'),
						]),
						rt.call_function('html_entity_decode', [
							rt.get_property(var_item, 'name'),
						]),
						rt.get_property(rt.get_property(var_item, 'item'), 'current_version'),
						rt.get_property(rt.get_property(var_item, 'item'), 'new_version'),
						var_item_url.clone(),
					]))
				} else {
					var_body_message = rt.concat(var_body_message, rt.call_function('sprintf', [
						rt.call_function('__', [rt.new_string('- %1$s version %2$s%3$s')]),
						rt.call_function('html_entity_decode', [
							rt.get_property(var_item, 'name')]),
						rt.get_property(rt.get_property(var_item, 'item'), 'new_version'),
						var_item_url.clone(),
					]))
				}
				var_body.array_push(var_body_message.clone())
				var_past_failure_emails.array_unset(rt.get_property(rt.get_property(var_item,
					'item'), 'plugin'))
			}
			var_body.array_push('\n')
		}
		if !(!rt.is_true(var_successful_updates_mutated.array_get(rt.new_string('theme')))) {
			var_body.array_push(rt.call_function('__', [
				rt.new_string('These themes are now up to date:'),
			]))
			mut iter_15 :=
				var_successful_updates_mutated.array_get(rt.new_string('theme')).iterator()
			for {
				item_15 := iter_15.next() or { break }
				mut var_item := item_15.val
				if rt.is_true(rt.get_property(rt.get_property(var_item, 'item'), 'current_version')) {
					var_body.array_push(rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('- %1$s (from version %2$s to %3$s)'),
						]),
						rt.call_function('html_entity_decode', [
							rt.get_property(var_item, 'name'),
						]),
						rt.get_property(rt.get_property(var_item, 'item'), 'current_version'),
						rt.get_property(rt.get_property(var_item, 'item'), 'new_version'),
					]))
				} else {
					var_body.array_push(rt.call_function('sprintf', [
						rt.call_function('__', [rt.new_string('- %1$s version %2$s')]),
						rt.call_function('html_entity_decode', [
							rt.get_property(var_item, 'name')]),
						rt.get_property(rt.get_property(var_item, 'item'), 'new_version'),
					]))
				}
				var_past_failure_emails.array_unset(rt.get_property(rt.get_property(var_item,
					'item'), 'theme'))
			}
			var_body.array_push('\n')
		}
	}
	if rt.is_true(var_failed_plugins) {
		var_body.array_push(rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('To manage plugins on your site, visit the Plugins page: %s'),
			]),
			rt.call_function('admin_url', [
				rt.new_string('plugins.php'),
			]),
		]))
		var_body.array_push('\n')
	}
	if rt.is_true(var_failed_themes) {
		var_body.array_push(rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('To manage themes on your site, visit the Themes page: %s'),
			]),
			rt.call_function('admin_url', [
				rt.new_string('themes.php'),
			]),
		]))
		var_body.array_push('\n')
	}
	var_body.array_push(rt.call_function('__', [
		rt.new_string('If you experience any issues or need support, the volunteers in the WordPress.org support forums may be able to help.'),
	]))
	var_body.array_push(rt.call_function('__', [
		rt.new_string('https://wordpress.org/support/forums/'),
	]))
	var_body.array_push('\n' + (rt.call_function('__', [rt.new_string('The WordPress Team')])).str())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.call_function('get_option', [
		rt.new_string('blogname'),
	])))))
	{
		mut var_site_title := rt.call_function('wp_specialchars_decode', [
			rt.call_function('get_option', [rt.new_string('blogname')]),
			rt.get_constant('ENT_QUOTES'),
		])
	} else {
		var_site_title = rt.call_function('parse_url', [
			rt.call_function('home_url', []rt.PhpVal{}),
			rt.get_constant('PHP_URL_HOST'),
		])
	}
	var_body = rt.call_function('implode', [rt.new_string('\n'),
		var_body.clone()])
	mut var_to := rt.call_function('get_site_option', [rt.new_string('admin_email')])
	var_subject = rt.call_function('sprintf', [var_subject.clone(),
		var_site_title.clone()])
	mut var_headers := rt.new_string('')
	mut var_email := rt.call_function('compact', [rt.new_string('to'),
		rt.new_string('subject'), rt.new_string('body'), rt.new_string('headers')])
	var_email = rt.call_function('apply_filters', [
		rt.new_string('auto_plugin_theme_update_email'),
		var_email.clone(),
		var_type.clone(),
		var_successful_updates_mutated.clone(),
		var_failed_updates_mutated.clone(),
	])
	mut var_result := rt.call_function('wp_mail', [var_email.array_get(rt.new_string('to')),
		rt.call_function('wp_specialchars_decode', [
			var_email.array_get(rt.new_string('subject')),
		]),
		var_email.array_get(rt.new_string('body')), var_email.array_get(rt.new_string('headers'))])
	if rt.is_true(var_result) {
		rt.call_function('update_option', [
			rt.new_string('auto_plugin_theme_update_emails'),
			var_past_failure_emails.clone(),
		])
	}
	if rt.is_true(var_switched_locale) {
		rt.call_function('restore_previous_locale', []rt.PhpVal{})
	}
}

fn (mut this Class_WP_Automatic_Updater) send_debug_email() {
	mut var_admin_user := rt.call_function('get_user_by', [rt.new_string('email'),
		rt.call_function('get_site_option', [rt.new_string('admin_email')])])
	if rt.is_true(var_admin_user) {
		mut var_switched_locale := rt.call_function('switch_to_user_locale', [
			rt.get_property(var_admin_user, 'ID'),
		])
	} else {
		var_switched_locale = rt.call_function('switch_to_locale', [
			rt.call_function('get_locale', []rt.PhpVal{}),
		])
	}
	mut var_body := rt.new_array()
	mut var_failures := rt.new_int(0)
	var_body.array_push(rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('WordPress site: %s')]),
		rt.call_function('network_home_url', [rt.new_string('/')]),
	]))
	if this.update_results.array_isset(rt.new_string('core')) {
		mut var_result :=
			this.update_results.array_get(rt.new_string('core')).array_get(rt.new_int(0))
		if rt.is_true(rt.get_property(var_result, 'result'))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [rt.get_property(var_result, 'result')]))))) {
			var_body.array_push(rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('SUCCESS: WordPress was successfully updated to %s'),
				]),
				rt.get_property(var_result, 'name'),
			]))
		} else {
			var_body.array_push(rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('FAILED: WordPress failed to update to %s'),
				]),
				rt.get_property(var_result, 'name'),
			]))
			rt.pre_inc(var_failures)
		}
		var_body.array_push('')
	}
	mut iter_16 := rt.create_array([rt.ArrayItem{ key: none, val: 'plugin' },
		rt.ArrayItem{ key: none, val: 'theme' }, rt.ArrayItem{ key: none, val: 'translation' }]).iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_type := item_16.val
		if !(this.update_results.array_isset(var_type)) {
			continue
		}
		mut var_success_items := rt.call_function('wp_list_filter', [
			this.update_results.array_get(var_type),
			rt.create_array([rt.ArrayItem{ key: 'result', val: true }]),
		])
		if rt.is_true(var_success_items) {
			mut var_messages := rt.create_array([
				rt.ArrayItem{ key: 'plugin', val: rt.call_function('__', [
					rt.new_string('The following plugins were successfully updated:'),
				]) },
				rt.ArrayItem{ key: 'theme', val: rt.call_function('__', [
					rt.new_string('The following themes were successfully updated:'),
				]) },
				rt.ArrayItem{ key: 'translation', val: rt.call_function('__', [
					rt.new_string('The following translations were successfully updated:'),
				]) },
			])
			var_body.array_push(var_messages.array_get(var_type))
			mut iter_17 := rt.call_function('wp_list_pluck', [
				var_success_items.clone(), rt.new_string('name')]).iterator()
			for {
				item_17 := iter_17.next() or { break }
				mut var_name := item_17.val
				var_body.array_push(' * ' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('SUCCESS: %s')]), var_name.clone()])).str())
			}
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_success_items,
			this.update_results.array_get(var_type)))))
		{
			var_messages = rt.create_array([
				rt.ArrayItem{ key: 'plugin', val: rt.call_function('__', [
					rt.new_string('The following plugins failed to update:'),
				]) },
				rt.ArrayItem{ key: 'theme', val: rt.call_function('__', [
					rt.new_string('The following themes failed to update:'),
				]) },
				rt.ArrayItem{ key: 'translation', val: rt.call_function('__', [
					rt.new_string('The following translations failed to update:'),
				]) },
			])
			var_body.array_push(var_messages.array_get(var_type))
			mut iter_18 := this.update_results.array_get(var_type).iterator()
			for {
				item_18 := iter_18.next() or { break }
				mut var_item := item_18.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_item, 'result')))))
					|| rt.is_true(rt.call_function('is_wp_error', [rt.get_property(var_item, 'result')])) {
					var_body.array_push(' * ' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('FAILED: %s')]), rt.get_property(var_item, 'name')])).str())
					rt.pre_inc(var_failures)
				}
			}
		}
		var_body.array_push('')
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.call_function('get_bloginfo', [
		rt.new_string('name'),
	])))))
	{
		mut var_site_title := rt.call_function('wp_specialchars_decode', [
			rt.call_function('get_bloginfo', [rt.new_string('name')]),
			rt.get_constant('ENT_QUOTES'),
		])
	} else {
		var_site_title = rt.call_function('parse_url', [
			rt.call_function('home_url', []rt.PhpVal{}),
			rt.get_constant('PHP_URL_HOST'),
		])
	}
	if rt.is_true(var_failures) {
		var_body.array_push(rt.call_function('__', [
			rt.new_string("BETA TESTING?\n=============\n\nThis debugging email is sent when you are using a development version of WordPress.\n\nIf you think these failures might be due to a bug in WordPress, could you report it?\n * Open a thread in the support forums: https://wordpress.org/support/forum/alphabeta\n * Or, if you're comfortable writing a bug report: https://core.trac.wordpress.org/\n\nThanks! -- The WordPress Team"),
		]).to_string().trim_space())
		var_body.array_push('')
		mut var_subject := rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('[%s] Background Update Failed')]),
			var_site_title.clone(),
		])
	} else {
		var_subject = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('[%s] Background Update Finished')]),
			var_site_title.clone(),
		])
	}
	var_body.array_push(rt.call_function('__', [rt.new_string('UPDATE LOG\n==========')]).to_string().trim_space())
	var_body.array_push('')
	mut iter_19 := rt.create_array([rt.ArrayItem{ key: none, val: 'core' },
		rt.ArrayItem{ key: none, val: 'plugin' }, rt.ArrayItem{ key: none, val: 'theme' },
		rt.ArrayItem{ key: none, val: 'translation' }]).iterator()
	for {
		item_19 := iter_19.next() or { break }
		mut var_type := item_19.val
		if !(this.update_results.array_isset(var_type)) {
			continue
		}
		mut iter_20 := this.update_results.array_get(var_type).iterator()
		for {
			item_20 := iter_20.next() or { break }
			mut var_update := item_20.val
			var_body.array_push(rt.get_property(var_update, 'name'))
			var_body.array_push(rt.call_function('str_repeat', [
				rt.new_string('-'), rt.new_int(rt.get_property(var_update, 'name').to_string().len)]))
			mut iter_21 := rt.get_property(var_update, 'messages').iterator()
			for {
				item_21 := iter_21.next() or { break }
				mut var_message := item_21.val
				var_body.array_push('  ' +(rt.call_function('html_entity_decode', [rt.call_function('str_replace', [rt.new_string('&#8230;'), rt.new_string('...'), var_message.clone()])])).str())
			}
			if rt.is_true(rt.call_function('is_wp_error', [
				rt.get_property(var_update, 'result'),
			]))
			{
				mut var_results := rt.create_array([
					rt.ArrayItem{ key: 'update', val: rt.get_property(var_update, 'result') },
				])
				if rt.is_true(rt.identical(rt.new_string('rollback_was_required'), rt.call_method(rt.get_property(var_update,
					'result'), 'get_error_code', []rt.PhpVal{})))
				{
					var_results = rt.cast_array(rt.call_method(rt.get_property(var_update, 'result'),
						'get_error_data', []rt.PhpVal{}))
				}
				mut iter_22 := var_results.iterator()
				for {
					item_22 := iter_22.next() or { break }
					mut var_result_shadow := item_22.val
					mut var_result_type := item_22.key
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
						var_result_shadow.clone(),
					])))))
					{
						continue
					}
					if rt.is_true(rt.identical(rt.new_string('rollback'), var_result_type)) {
						var_body.array_push('  ' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Rollback Error: [%1$s] %2$s')]), rt.call_method(var_result_shadow, 'get_error_code', []rt.PhpVal{}), rt.call_method(var_result_shadow, 'get_error_message', []rt.PhpVal{})])).str())
					} else {
						var_body.array_push('  ' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Error: [%1$s] %2$s')]), rt.call_method(var_result_shadow, 'get_error_code', []rt.PhpVal{}), rt.call_method(var_result_shadow, 'get_error_message', []rt.PhpVal{})])).str())
					}
					if rt.is_true(rt.call_method(var_result_shadow, 'get_error_data', []rt.PhpVal{})) {
						var_body.array_push('         ' +(rt.call_function('implode', [rt.new_string(', '), rt.cast_array(rt.call_method(var_result_shadow, 'get_error_data', []rt.PhpVal{}))])).str())
					}
				}
			}
			var_body.array_push('')
		}
	}
	mut var_email := rt.create_array([
		rt.ArrayItem{ key: 'to', val: rt.call_function('get_site_option', [
			rt.new_string('admin_email'),
		]) },
		rt.ArrayItem{ key: 'subject', val: var_subject },
		rt.ArrayItem{ key: 'body', val: rt.call_function('implode', [
			rt.new_string('\n'),
			var_body.clone(),
		]) },
		rt.ArrayItem{ key: 'headers', val: '' },
	])
	var_email = rt.call_function('apply_filters', [
		rt.new_string('automatic_updates_debug_email'),
		var_email.clone(),
		var_failures.clone(),
		this.update_results,
	])
	rt.call_function('wp_mail', [var_email.array_get(rt.new_string('to')),
		rt.call_function('wp_specialchars_decode', [
			var_email.array_get(rt.new_string('subject')),
		]),
		var_email.array_get(rt.new_string('body')), var_email.array_get(rt.new_string('headers'))])
	if rt.is_true(var_switched_locale) {
		rt.call_function('restore_previous_locale', []rt.PhpVal{})
	}
}

fn (mut this Class_WP_Automatic_Updater) has_fatal_error() bool {
	mut var_upgrading := rt.new_null()
	mut var_maintenance_file := rt.new_string((rt.get_constant('ABSPATH')).str() + '.maintenance')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		var_maintenance_file.clone()])))))
	{
		return false
	}
	rt.include_file(var_maintenance_file.to_string(), '3')
	if !(var_upgrading.clone().is_long()) {
		return false
	}
	mut var_scrape_key := rt.new_string(md5.hexhash(var_upgrading.clone().to_string()))
	mut var_scrape_nonce := rt.new_string(var_upgrading.str())
	mut var_transient := rt.new_string('scrape_key_' + var_scrape_key.str())
	rt.call_function('set_transient', [var_transient.clone(),
		var_scrape_nonce.clone(), rt.new_int(30)])
	mut var_cookies := rt.call_function('wp_unslash', [rt.get_superglobal('_COOKIE').clone()])
	mut var_scrape_params := {
		'wp_scrape_key':   var_scrape_key
		'wp_scrape_nonce': var_scrape_nonce
	}
	mut var_headers := rt.create_array([
		rt.ArrayItem{ key: 'Cache-Control', val: 'no-cache' },
	])
	mut var_sslverify := rt.call_function('apply_filters', [
		rt.new_string('https_local_ssl_verify'),
		rt.new_bool(false),
	])
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('PHP_AUTH_USER'))
		&& rt.get_superglobal('_SERVER').array_isset(rt.new_string('PHP_AUTH_PW')) {
		var_headers.array_set('Authorization', 'Basic ' +
			(rt.call_function('base64_encode', [rt.new_string((rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_AUTH_USER'))])).str() +
			':' +(rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_AUTH_PW'))])).str())])).str())
	}
	mut var_timeout := rt.new_int(50)
	mut var_is_debug := rt.new_bool(rt.is_true(rt.get_constant('WP_DEBUG'))
		&& rt.is_true(rt.get_constant('WP_DEBUG_LOG')))
	if rt.is_true(var_is_debug) {
		rt.call_function('error_log', [rt.new_string('    Scraping home page...')])
	}
	mut var_needle_start :=
		rt.new_string('###### wp_scraping_result_start:${var_scrape_key.to_string()} ######')
	mut var_needle_end :=
		rt.new_string('###### wp_scraping_result_end:${var_scrape_key.to_string()} ######')
	mut var_url := rt.call_function('add_query_arg', [
		rt.create_array_from_native_map(var_scrape_params),
		rt.call_function('home_url', [rt.new_string('/')]),
	])
	mut var_response := rt.call_function('wp_remote_get', [var_url.clone(),
		rt.call_function('compact', [rt.new_string('cookies'),
			rt.new_string('headers'), rt.new_string('timeout'),
			rt.new_string('sslverify')])])
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		if rt.is_true(var_is_debug) {
			rt.call_function('error_log', [
				rt.new_string('Loopback request failed: ' +
					(rt.call_method(var_response, 'get_error_message', []rt.PhpVal{})).str()),
			])
		}
		return true
	}
	if rt.is_true(var_is_debug) {
		rt.call_function('error_log', [
			rt.call_function('var_export', [
				rt.call_function('substr', [var_response.array_get(rt.new_string('body')),
					rt.call_function('strpos', [var_response.array_get(rt.new_string('body')),
						rt.new_string('###### wp_scraping_result_start:')])]),
				rt.new_bool(true),
			]),
		])
	}
	mut var_body := rt.call_function('wp_remote_retrieve_body', [
		var_response.clone()])
	mut var_scrape_result_position := rt.call_function('strpos', [
		var_body.clone(), var_needle_start.clone()])
	mut var_result := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false),
		var_scrape_result_position))))
	{
		mut var_error_output := rt.call_function('substr', [var_body.clone(),
			rt.add(var_scrape_result_position, rt.new_int(var_needle_start.clone().to_string().len))])
		var_error_output = rt.call_function('substr', [var_error_output.clone(),
			rt.new_int(0),
			rt.call_function('strpos', [var_error_output.clone(),
				var_needle_end.clone()])])
		var_result = rt.call_function('json_decode', [
			rt.new_string(var_error_output.clone().to_string().trim_space()),
			rt.new_bool(true),
		])
	}
	rt.call_function('delete_transient', [var_transient.clone()])
	return (rt.new_bool(var_result.array_isset(rt.new_string('type')))).to_bool()
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

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Upgrader {
	rt.PhpObjectBase
}

fn create_wp_automatic_updater(_args ...rt.PhpVal) &Class_WP_Automatic_Updater {
	mut obj := &Class_WP_Automatic_Updater{
		PhpObjectBase:  rt.PhpObjectBase{}
		update_results: rt.new_array()
	}
	return obj
}

fn create_automatic_upgrader_skin(_args ...rt.PhpVal) &Class_Automatic_Upgrader_Skin {
	mut obj := &Class_Automatic_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_core_upgrader(_args ...rt.PhpVal) &Class_Core_Upgrader {
	mut obj := &Class_Core_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_plugin_upgrader(_args ...rt.PhpVal) &Class_Plugin_Upgrader {
	mut obj := &Class_Plugin_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_theme_upgrader(_args ...rt.PhpVal) &Class_Theme_Upgrader {
	mut obj := &Class_Theme_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_language_pack_upgrader(_args ...rt.PhpVal) &Class_Language_Pack_Upgrader {
	mut obj := &Class_Language_Pack_Upgrader{
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

fn create_wp_upgrader(_args ...rt.PhpVal) &Class_WP_Upgrader {
	mut obj := &Class_WP_Upgrader{
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
		else {
			return none
		}
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
		'update_results' {
			this.update_results = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
