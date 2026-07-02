import rt

struct Class_Plugin_Upgrader {
	rt.PhpObjectBase
pub mut:
	result          rt.PhpVal = rt.new_null()
	bulk            bool
	new_plugin_data rt.PhpVal = rt.new_array()
}

fn (mut this Class_Plugin_Upgrader) upgrade_strings() {
	rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('up_to_date', rt.call_function('__', [
		rt.new_string('The plugin is at the latest version.'),
	]))
	rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('no_package', rt.call_function('__', [
		rt.new_string('Update package not available.'),
	]))
	rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('downloading_package', rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Downloading update from %s&#8230;')]),
		rt.new_string('<span class="code pre">%s</span>'),
	]))
	rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('unpack_package', rt.call_function('__', [
		rt.new_string('Unpacking the update&#8230;'),
	]))
	rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('remove_old', rt.call_function('__', [
		rt.new_string('Removing the old version of the plugin&#8230;'),
	]))
	rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('remove_old_failed', rt.call_function('__', [
		rt.new_string('Could not remove the old plugin.'),
	]))
	rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_failed', rt.call_function('__', [
		rt.new_string('Plugin update failed.'),
	]))
	rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_success', rt.call_function('__', [
		rt.new_string('Plugin updated successfully.'),
	]))
	rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_bulk_success', rt.call_function('__', [
		rt.new_string('Plugins updated successfully.'),
	]))
}

fn (mut this Class_Plugin_Upgrader) install_strings() {
	rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('no_package', rt.call_function('__', [
		rt.new_string('Installation package not available.'),
	]))
	rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('downloading_package', rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('Downloading installation package from %s&#8230;'),
		]),
		rt.new_string('<span class="code pre">%s</span>'),
	]))
	rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('unpack_package', rt.call_function('__', [
		rt.new_string('Unpacking the package&#8230;'),
	]))
	rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('installing_package', rt.call_function('__', [
		rt.new_string('Installing the plugin&#8230;'),
	]))
	rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('remove_old', rt.call_function('__', [
		rt.new_string('Removing the current plugin&#8230;'),
	]))
	rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('remove_old_failed', rt.call_function('__', [
		rt.new_string('Could not remove the current plugin.'),
	]))
	rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('no_files', rt.call_function('__', [
		rt.new_string('The plugin contains no files.'),
	]))
	rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_failed', rt.call_function('__', [
		rt.new_string('Plugin installation failed.'),
	]))
	rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_success', rt.call_function('__', [
		rt.new_string('Plugin installed successfully.'),
	]))
	rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_success_specific', rt.call_function('__', [
		rt.new_string('Successfully installed the plugin <strong>%1$s %2$s</strong>.'),
	]))
	if !(!rt.is_true(rt.get_property(rt.get_property(rt.new_object('Plugin_Upgrader', [
		'WP_Upgrader',
	], &this), 'skin'), 'overwrite'))) {
		if rt.is_true(rt.identical(rt.new_string('update-plugin'), rt.get_property(rt.get_property(rt.new_object('Plugin_Upgrader', [
			'WP_Upgrader',
		], &this), 'skin'), 'overwrite')))
		{
			rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('installing_package', rt.call_function('__', [
				rt.new_string('Updating the plugin&#8230;'),
			]))
			rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_failed', rt.call_function('__', [
				rt.new_string('Plugin update failed.'),
			]))
			rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_success', rt.call_function('__', [
				rt.new_string('Plugin updated successfully.'),
			]))
		}
		if rt.is_true(rt.identical(rt.new_string('downgrade-plugin'), rt.get_property(rt.get_property(rt.new_object('Plugin_Upgrader', [
			'WP_Upgrader',
		], &this), 'skin'), 'overwrite')))
		{
			rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('installing_package', rt.call_function('__', [
				rt.new_string('Downgrading the plugin&#8230;'),
			]))
			rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_failed', rt.call_function('__', [
				rt.new_string('Plugin downgrade failed.'),
			]))
			rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_success', rt.call_function('__', [
				rt.new_string('Plugin downgraded successfully.'),
			]))
		}
	}
}

fn (mut this Class_Plugin_Upgrader) install(var_package rt.PhpVal, var_args rt.PhpVal) bool {
	mut var_defaults := {
		'clear_update_cache': true
		'overwrite_package':  false
	}
	mut var_parsed_args := rt.call_function('wp_parse_args', [
		var_args.clone(), rt.create_array_from_native_map(var_defaults)])
	this.init()
	this.install_strings()
	rt.call_function('add_filter', [rt.new_string('upgrader_source_selection'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Plugin_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'check_package' },
		])])
	if rt.is_true(var_parsed_args.array_get(rt.new_string('clear_update_cache'))) {
		rt.call_function('add_action', [rt.new_string('upgrader_process_complete'),
			rt.new_string('wp_clean_plugins_cache'), rt.new_int(9),
			rt.new_int(0)])
	}
	this.run(rt.create_array([rt.ArrayItem{ key: 'package', val: var_package },
		rt.ArrayItem{ key: 'destination', val: rt.get_constant('WP_PLUGIN_DIR') },
		rt.ArrayItem{
			key: 'clear_destination'
			val: var_parsed_args.array_get(rt.new_string('overwrite_package'))
		}, rt.ArrayItem{ key: 'clear_working', val: true }, rt.ArrayItem{ key: 'hook_extra', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'plugin' },
			rt.ArrayItem{ key: 'action', val: 'install' },
		]) }]))
	rt.call_function('remove_action', [rt.new_string('upgrader_process_complete'),
		rt.new_string('wp_clean_plugins_cache'), rt.new_int(9)])
	rt.call_function('remove_filter', [rt.new_string('upgrader_source_selection'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Plugin_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'check_package' },
		])])
	if rt.is_true(rt.new_bool(!(rt.is_true(this.result))))
		|| rt.is_true(rt.call_function('is_wp_error', [this.result])) {
		return (this.result).to_bool()
	}
	rt.call_function('wp_clean_plugins_cache', [
		var_parsed_args.array_get(rt.new_string('clear_update_cache')),
	])
	if rt.is_true(var_parsed_args.array_get(rt.new_string('overwrite_package'))) {
		rt.call_function('do_action', [rt.new_string('upgrader_overwrote_package'),
			var_package.clone(), this.new_plugin_data, rt.new_string('plugin')])
	}
	return true
}

fn (mut this Class_Plugin_Upgrader) upgrade(var_plugin rt.PhpVal, var_args rt.PhpVal) bool {
	mut var_plugin_mutated := var_plugin
	mut var_defaults := {
		'clear_update_cache': true
	}
	mut var_parsed_args := rt.call_function('wp_parse_args', [
		var_args.clone(), rt.create_array_from_native_map(var_defaults)])
	this.init()
	this.upgrade_strings()
	mut var_current := rt.call_function('get_site_transient', [
		rt.new_string('update_plugins'),
	])
	if !(rt.get_property(var_current, 'response').array_isset(var_plugin_mutated)) {
		rt.call_method(rt.get_property(rt.new_object('Plugin_Upgrader', [
			'WP_Upgrader',
		], &this), 'skin'), 'before', []rt.PhpVal{})
		rt.call_method(rt.get_property(rt.new_object('Plugin_Upgrader', [
			'WP_Upgrader',
		], &this), 'skin'), 'set_result', [rt.new_bool(false)])
		rt.call_method(rt.get_property(rt.new_object('Plugin_Upgrader', [
			'WP_Upgrader',
		], &this), 'skin'), 'error', [rt.new_string('up_to_date')])
		rt.call_method(rt.get_property(rt.new_object('Plugin_Upgrader', [
			'WP_Upgrader',
		], &this), 'skin'), 'after', []rt.PhpVal{})
		return false
	}
	mut var_upgrade_data := rt.get_property(var_current, 'response').array_get(var_plugin_mutated)
	rt.call_function('add_filter', [rt.new_string('upgrader_pre_install'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Plugin_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'deactivate_plugin_before_upgrade' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('upgrader_pre_install'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Plugin_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'active_before' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('upgrader_clear_destination'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Plugin_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'delete_old_plugin' },
		]),
		rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_filter', [rt.new_string('upgrader_post_install'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Plugin_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'active_after' },
		]),
		rt.new_int(10), rt.new_int(2)])
	if rt.is_true(var_parsed_args.array_get(rt.new_string('clear_update_cache'))) {
		rt.call_function('add_action', [rt.new_string('upgrader_process_complete'),
			rt.new_string('wp_clean_plugins_cache'), rt.new_int(9),
			rt.new_int(0)])
	}
	this.run(rt.create_array([
		rt.ArrayItem{ key: 'package', val: rt.get_property(var_upgrade_data, 'package') },
		rt.ArrayItem{ key: 'destination', val: rt.get_constant('WP_PLUGIN_DIR') },
		rt.ArrayItem{ key: 'clear_destination', val: true },
		rt.ArrayItem{ key: 'clear_working', val: true },
		rt.ArrayItem{ key: 'hook_extra', val: rt.create_array([
			rt.ArrayItem{ key: 'plugin', val: var_plugin_mutated },
			rt.ArrayItem{ key: 'type', val: 'plugin' },
			rt.ArrayItem{ key: 'action', val: 'update' },
			rt.ArrayItem{ key: 'temp_backup', val: rt.create_array([
				rt.ArrayItem{ key: 'slug', val: rt.call_function('dirname', [
					var_plugin_mutated.clone()]) },
				rt.ArrayItem{ key: 'src', val: rt.get_constant('WP_PLUGIN_DIR') },
				rt.ArrayItem{ key: 'dir', val: 'plugins' },
			]) },
		]) },
	]))
	rt.call_function('remove_action', [rt.new_string('upgrader_process_complete'),
		rt.new_string('wp_clean_plugins_cache'), rt.new_int(9)])
	rt.call_function('remove_filter', [rt.new_string('upgrader_pre_install'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Plugin_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'deactivate_plugin_before_upgrade' },
		])])
	rt.call_function('remove_filter', [rt.new_string('upgrader_pre_install'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Plugin_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'active_before' },
		])])
	rt.call_function('remove_filter', [rt.new_string('upgrader_clear_destination'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Plugin_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'delete_old_plugin' },
		])])
	rt.call_function('remove_filter', [rt.new_string('upgrader_post_install'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Plugin_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'active_after' },
		])])
	if rt.is_true(rt.new_bool(!(rt.is_true(this.result))))
		|| rt.is_true(rt.call_function('is_wp_error', [this.result])) {
		return (this.result).to_bool()
	}
	rt.call_function('wp_clean_plugins_cache', [
		var_parsed_args.array_get(rt.new_string('clear_update_cache')),
	])
	mut var_past_failure_emails := rt.call_function('get_option', [
		rt.new_string('auto_plugin_theme_update_emails'),
		rt.new_array(),
	])
	if var_past_failure_emails.array_isset(var_plugin_mutated) {
		var_past_failure_emails.array_unset(var_plugin_mutated)
		rt.call_function('update_option', [
			rt.new_string('auto_plugin_theme_update_emails'),
			var_past_failure_emails.clone(),
		])
	}
	return true
}

fn (mut this Class_Plugin_Upgrader) bulk_upgrade(var_plugins rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_wp_version := rt.call_function('wp_get_wp_version', []rt.PhpVal{})
	mut var_defaults := {
		'clear_update_cache': true
	}
	mut var_parsed_args := rt.call_function('wp_parse_args', [
		var_args.clone(), rt.create_array_from_native_map(var_defaults)])
	this.init()
	this.bulk = true
	this.upgrade_strings()
	mut var_current := rt.call_function('get_site_transient', [
		rt.new_string('update_plugins'),
	])
	rt.call_function('add_filter', [rt.new_string('upgrader_clear_destination'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Plugin_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'delete_old_plugin' },
		]),
		rt.new_int(10), rt.new_int(4)])
	rt.call_method(rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this), 'skin'),
		'header', []rt.PhpVal{})
	mut var_connected := this.fs_connect(rt.create_array([
		rt.ArrayItem{ key: none, val: rt.get_constant('WP_CONTENT_DIR') },
		rt.ArrayItem{ key: none, val: rt.get_constant('WP_PLUGIN_DIR') },
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_connected)))) {
		rt.call_method(rt.get_property(rt.new_object('Plugin_Upgrader', [
			'WP_Upgrader',
		], &this), 'skin'), 'footer', []rt.PhpVal{})
		return rt.new_bool(false)
	}
	rt.call_method(rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this), 'skin'),
		'bulk_header', []rt.PhpVal{})
	mut var_maintenance := rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& !(!rt.is_true(var_plugins)))
	mut iter_1 := var_plugins.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_plugin := item_1.val
		var_maintenance = rt.new_bool(rt.is_true(var_maintenance)
			|| rt.is_true(rt.call_function('is_plugin_active', [var_plugin.clone()]))
			&& rt.get_property(var_current, 'response').array_isset(var_plugin))
	}
	if rt.is_true(var_maintenance) {
		this.maintenance_mode(rt.new_bool(true))
	}
	mut var_results := rt.new_array()
	this.dispatch_set_prop('update_count', rt.new_int(var_plugins.clone().array_count()))
	this.dispatch_set_prop('update_current', rt.new_int(0))
	mut iter_2 := var_plugins.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_plugin := item_2.val
		rt.pre_inc(rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this),
			'update_current'))
		rt.set_property(rt.get_property(rt.new_object('Plugin_Upgrader', [
			'WP_Upgrader',
		], &this), 'skin'), 'plugin_info', rt.call_function('get_plugin_data', [
			rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + var_plugin.str()),
			rt.new_bool(false),
			rt.new_bool(true),
		]))
		if !(rt.get_property(var_current, 'response').array_isset(var_plugin)) {
			rt.call_method(rt.get_property(rt.new_object('Plugin_Upgrader', [
				'WP_Upgrader',
			], &this), 'skin'), 'set_result', [rt.new_string('up_to_date')])
			rt.call_method(rt.get_property(rt.new_object('Plugin_Upgrader', [
				'WP_Upgrader',
			], &this), 'skin'), 'before', []rt.PhpVal{})
			rt.call_method(rt.get_property(rt.new_object('Plugin_Upgrader', [
				'WP_Upgrader',
			], &this), 'skin'), 'feedback', [rt.new_string('up_to_date')])
			rt.call_method(rt.get_property(rt.new_object('Plugin_Upgrader', [
				'WP_Upgrader',
			], &this), 'skin'), 'after', []rt.PhpVal{})
			var_results.array_set(var_plugin, true)
			continue
		}
		mut var_upgrade_data := rt.get_property(var_current, 'response').array_get(var_plugin)
		rt.set_property(rt.get_property(rt.new_object('Plugin_Upgrader', [
			'WP_Upgrader',
		], &this), 'skin'), 'plugin_active', rt.call_function('is_plugin_active', [
			var_plugin.clone(),
		]))
		if !(rt.get_property(var_upgrade_data, 'requires')).is_null()
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_version_compatible', [rt.get_property(var_upgrade_data, 'requires')]))))) {
			mut var_result := create_wp_error(rt.new_string('incompatible_wp_required_version'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Your WordPress version is %1$s, however the new plugin version requires %2$s.'),
				]),
				var_wp_version.clone(),
				rt.get_property(var_upgrade_data, 'requires'),
			]))
			rt.call_method(rt.get_property(rt.new_object('Plugin_Upgrader', [
				'WP_Upgrader',
			], &this), 'skin'), 'before', [var_result.clone()])
			rt.call_method(rt.get_property(rt.new_object('Plugin_Upgrader', [
				'WP_Upgrader',
			], &this), 'skin'), 'error', [var_result.clone()])
			rt.call_method(rt.get_property(rt.new_object('Plugin_Upgrader', [
				'WP_Upgrader',
			], &this), 'skin'), 'after', []rt.PhpVal{})
		} else if !(rt.get_property(var_upgrade_data, 'requires_php')).is_null()
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_php_version_compatible', [rt.get_property(var_upgrade_data, 'requires_php')]))))) {
			var_result = create_wp_error(rt.new_string('incompatible_php_required_version'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The PHP version on your server is %1$s, however the new plugin version requires %2$s.'),
				]),
				rt.get_constant('PHP_VERSION'),
				rt.get_property(var_upgrade_data, 'requires_php'),
			]))
			rt.call_method(rt.get_property(rt.new_object('Plugin_Upgrader', [
				'WP_Upgrader',
			], &this), 'skin'), 'before', [var_result.clone()])
			rt.call_method(rt.get_property(rt.new_object('Plugin_Upgrader', [
				'WP_Upgrader',
			], &this), 'skin'), 'error', [var_result.clone()])
			rt.call_method(rt.get_property(rt.new_object('Plugin_Upgrader', [
				'WP_Upgrader',
			], &this), 'skin'), 'after', []rt.PhpVal{})
		} else {
			rt.call_function('add_filter', [rt.new_string('upgrader_source_selection'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Plugin_Upgrader', [
						'WP_Upgrader',
					], &this) },
					rt.ArrayItem{ key: none, val: 'check_package' },
				])])
			var_result = this.run(rt.create_array([
				rt.ArrayItem{ key: 'package', val: rt.get_property(var_upgrade_data, 'package') },
				rt.ArrayItem{ key: 'destination', val: rt.get_constant('WP_PLUGIN_DIR') },
				rt.ArrayItem{ key: 'clear_destination', val: true },
				rt.ArrayItem{ key: 'clear_working', val: true },
				rt.ArrayItem{ key: 'is_multi', val: true },
				rt.ArrayItem{ key: 'hook_extra', val: rt.create_array([
					rt.ArrayItem{ key: 'plugin', val: var_plugin },
					rt.ArrayItem{ key: 'temp_backup', val: rt.create_array([
						rt.ArrayItem{ key: 'slug', val: rt.call_function('dirname', [
							var_plugin.clone(),
						]) },
						rt.ArrayItem{ key: 'src', val: rt.get_constant('WP_PLUGIN_DIR') },
						rt.ArrayItem{ key: 'dir', val: 'plugins' },
					]) },
				]) },
			]))
			rt.call_function('remove_filter', [
				rt.new_string('upgrader_source_selection'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Plugin_Upgrader', [
						'WP_Upgrader',
					], &this) },
					rt.ArrayItem{ key: none, val: 'check_package' },
				]),
			])
		}
		var_results.array_set(var_plugin, var_result.clone())
		if rt.is_true(rt.identical(rt.new_bool(false), var_result)) {
			break
		}
	}
	this.maintenance_mode(rt.new_bool(false))
	rt.call_function('wp_clean_plugins_cache', [
		var_parsed_args.array_get(rt.new_string('clear_update_cache')),
	])
	rt.call_function('do_action', [rt.new_string('upgrader_process_complete'),
		rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this),
		rt.create_array([rt.ArrayItem{ key: 'action', val: 'update' },
			rt.ArrayItem{ key: 'type', val: 'plugin' }, rt.ArrayItem{ key: 'bulk', val: true },
			rt.ArrayItem{ key: 'plugins', val: var_plugins }])])
	rt.call_method(rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this), 'skin'),
		'bulk_footer', []rt.PhpVal{})
	rt.call_method(rt.get_property(rt.new_object('Plugin_Upgrader', ['WP_Upgrader'], &this), 'skin'),
		'footer', []rt.PhpVal{})
	rt.call_function('remove_filter', [rt.new_string('upgrader_clear_destination'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Plugin_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'delete_old_plugin' },
		])])
	mut var_past_failure_emails := rt.call_function('get_option', [
		rt.new_string('auto_plugin_theme_update_emails'),
		rt.new_array(),
	])
	mut iter_3 := var_results.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_result := item_3.val
		mut var_plugin := item_3.key
		if rt.is_true(rt.new_bool(!(rt.is_true(var_result))))
			|| rt.is_true(rt.call_function('is_wp_error', [var_result.clone()]))
			|| !(var_past_failure_emails.array_isset(var_plugin)) {
			continue
		}
		var_past_failure_emails.array_unset(var_plugin)
	}
	rt.call_function('update_option', [rt.new_string('auto_plugin_theme_update_emails'),
		var_past_failure_emails.clone()])
	return var_results.clone()
}

fn (mut this Class_Plugin_Upgrader) check_package(var_source rt.PhpVal) rt.PhpVal {
	mut var_wp_filesystem := rt.new_null()
	mut var_wp_version := rt.call_function('wp_get_wp_version', []rt.PhpVal{})
	this.new_plugin_data = rt.new_array()
	if rt.is_true(rt.call_function('is_wp_error', [var_source.clone()])) {
		return var_source.clone()
	}
	mut var_working_directory := rt.call_function('str_replace', [
		rt.call_method(var_wp_filesystem, 'wp_content_dir', []rt.PhpVal{}),
		rt.call_function('trailingslashit', [rt.get_constant('WP_CONTENT_DIR')]),
		var_source.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [
		var_working_directory.clone()])))))
	{
		return var_source.clone()
	}
	mut var_files := rt.call_function('glob', [
		rt.new_string(var_working_directory.str() + '*.php'),
	])
	if rt.is_true(var_files) {
		mut iter_4 := var_files.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_file := item_4.val
			mut var_new_plugin_data := rt.call_function('get_plugin_data', [
				var_file.clone(), rt.new_bool(false), rt.new_bool(false)])
			if !(!rt.is_true(var_new_plugin_data.array_get(rt.new_string('Name')))) {
				this.new_plugin_data = var_new_plugin_data.clone()
				break
			}
		}
	}
	if !rt.is_true(this.new_plugin_data) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('incompatible_archive_no_plugins'), rt.get_property(rt.new_object('Plugin_Upgrader', [
			'WP_Upgrader',
		], &this), 'strings').array_get(rt.new_string('incompatible_archive')), rt.call_function('__', [
			rt.new_string('No valid plugins were found.'),
		])))
	}
	mut var_requires_php := if !(var_new_plugin_data.array_get(rt.new_string('RequiresPHP'))).is_null() {
		var_new_plugin_data.array_get(rt.new_string('RequiresPHP'))
	} else {
		rt.new_null()
	}
	mut var_requires_wp := if !(var_new_plugin_data.array_get(rt.new_string('RequiresWP'))).is_null() {
		var_new_plugin_data.array_get(rt.new_string('RequiresWP'))
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_php_version_compatible', [
		var_requires_php.clone(),
	])))))
	{
		mut var_error := rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The PHP version on your server is %1$s, however the uploaded plugin requires %2$s.'),
			]),
			rt.get_constant('PHP_VERSION'),
			var_requires_php.clone(),
		])
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('incompatible_php_required_version'), rt.get_property(rt.new_object('Plugin_Upgrader', [
			'WP_Upgrader',
		], &this), 'strings').array_get(rt.new_string('incompatible_archive')), var_error.clone()))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_version_compatible', [
		var_requires_wp.clone(),
	])))))
	{
		var_error = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Your WordPress version is %1$s, however the uploaded plugin requires %2$s.'),
			]),
			var_wp_version.clone(),
			var_requires_wp.clone(),
		])
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('incompatible_wp_required_version'), rt.get_property(rt.new_object('Plugin_Upgrader', [
			'WP_Upgrader',
		], &this), 'strings').array_get(rt.new_string('incompatible_archive')), var_error.clone()))
	}
	return var_source.clone()
}

fn (mut this Class_Plugin_Upgrader) plugin_info() rt.PhpVal {
	if !(this.result.is_array()) {
		return rt.new_bool(false)
	}
	if !rt.is_true(this.result.array_get(rt.new_string('destination_name'))) {
		return rt.new_bool(false)
	}
	mut var_plugin := rt.call_function('get_plugins', [
		rt.new_string('/' + (this.result.array_get(rt.new_string('destination_name'))).str()),
	])
	if !rt.is_true(var_plugin) {
		return rt.new_bool(false)
	}
	mut var_plugin_files := rt.func_array_keys(var_plugin.clone())
	return rt.new_string((this.result.array_get(rt.new_string('destination_name'))).str() + '/' +
		(var_plugin_files.array_get(rt.new_int(0))).str())
}

fn (mut this Class_Plugin_Upgrader) deactivate_plugin_before_upgrade(var_response rt.PhpVal, var_plugin rt.PhpVal) rt.PhpVal {
	mut var_plugin_mutated := var_plugin
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		return var_response.clone()
	}
	if rt.is_true(rt.call_function('wp_doing_cron', []rt.PhpVal{})) {
		return var_response.clone()
	}
	var_plugin_mutated = if !(var_plugin_mutated.array_get(rt.new_string('plugin'))).is_null() {
		var_plugin_mutated.array_get(rt.new_string('plugin'))
	} else {
		rt.new_string('')
	}
	if !rt.is_true(var_plugin_mutated) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('bad_request'), rt.get_property(rt.new_object('Plugin_Upgrader', [
			'WP_Upgrader',
		], &this), 'strings').array_get(rt.new_string('bad_request'))))
	}
	if rt.is_true(rt.call_function('is_plugin_active', [var_plugin_mutated.clone()])) {
		rt.call_function('deactivate_plugins', [var_plugin_mutated.clone(),
			rt.new_bool(true)])
	}
	return var_response.clone()
}

fn (mut this Class_Plugin_Upgrader) active_before(var_response rt.PhpVal, var_plugin rt.PhpVal) rt.PhpVal {
	mut var_plugin_mutated := var_plugin
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		return var_response.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_doing_cron', []rt.PhpVal{}))))) {
		return var_response.clone()
	}
	var_plugin_mutated = if !(var_plugin_mutated.array_get(rt.new_string('plugin'))).is_null() {
		var_plugin_mutated.array_get(rt.new_string('plugin'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_plugin_active', [
		var_plugin_mutated.clone(),
	])))))
	{
		return var_response.clone()
	}
	if !(this.bulk) {
		this.maintenance_mode(rt.new_bool(true))
	}
	return var_response.clone()
}

fn (mut this Class_Plugin_Upgrader) active_after(var_response rt.PhpVal, var_plugin rt.PhpVal) rt.PhpVal {
	mut var_plugin_mutated := var_plugin
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		return var_response.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_doing_cron', []rt.PhpVal{}))))) {
		return var_response.clone()
	}
	var_plugin_mutated = if !(var_plugin_mutated.array_get(rt.new_string('plugin'))).is_null() {
		var_plugin_mutated.array_get(rt.new_string('plugin'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_plugin_active', [
		var_plugin_mutated.clone(),
	])))))
	{
		return var_response.clone()
	}
	if !(this.bulk) {
		this.maintenance_mode(rt.new_bool(false))
	}
	return var_response.clone()
}

fn (mut this Class_Plugin_Upgrader) delete_old_plugin(var_removed rt.PhpVal, var_local_destination rt.PhpVal, var_remote_destination rt.PhpVal, var_plugin rt.PhpVal) bool {
	mut var_wp_filesystem := rt.new_null()
	mut var_plugin_mutated := var_plugin
	if rt.is_true(rt.call_function('is_wp_error', [var_removed.clone()])) {
		return var_removed.to_bool()
	}
	var_plugin_mutated = if !(var_plugin_mutated.array_get(rt.new_string('plugin'))).is_null() {
		var_plugin_mutated.array_get(rt.new_string('plugin'))
	} else {
		rt.new_string('')
	}
	if !rt.is_true(var_plugin_mutated) {
		return (create_wp_error(rt.new_string('bad_request'), rt.get_property(rt.new_object('Plugin_Upgrader', [
			'WP_Upgrader',
		], &this), 'strings').array_get(rt.new_string('bad_request')))).to_bool()
	}
	mut var_plugins_dir := rt.call_method(var_wp_filesystem, 'wp_plugins_dir', []rt.PhpVal{})
	mut var_this_plugin_dir := rt.call_function('trailingslashit', [
		rt.call_function('dirname', [
			rt.new_string(var_plugins_dir.str() + var_plugin_mutated.str()),
		]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'exists', [
		var_this_plugin_dir.clone(),
	])))))
	{
		return var_removed.to_bool()
	}
	if rt.is_true(rt.call_function('strpos', [var_plugin_mutated.clone(), rt.new_string('/')]))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_this_plugin_dir, var_plugins_dir)))) {
		mut var_deleted := rt.call_method(var_wp_filesystem, 'delete', [
			var_this_plugin_dir.clone(), rt.new_bool(true)])
	} else {
		var_deleted = rt.call_method(var_wp_filesystem, 'delete', [
			rt.new_string(var_plugins_dir.str() + var_plugin_mutated.str()),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_deleted)))) {
		return (create_wp_error(rt.new_string('remove_old_failed'), rt.get_property(rt.new_object('Plugin_Upgrader', [
			'WP_Upgrader',
		], &this), 'strings').array_get(rt.new_string('remove_old_failed')))).to_bool()
	}
	return true
}

struct Class_WP_Upgrader {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_plugin_upgrader(_args ...rt.PhpVal) &Class_Plugin_Upgrader {
	mut obj := &Class_Plugin_Upgrader{
		PhpObjectBase:   rt.PhpObjectBase{}
		result:          rt.new_null()
		bulk:            false
		new_plugin_data: rt.new_array()
	}
	return obj
}

fn create_wp_upgrader(_args ...rt.PhpVal) &Class_WP_Upgrader {
	mut obj := &Class_WP_Upgrader{
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

fn (mut this Class_Plugin_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'upgrade_strings' {
			this.upgrade_strings()
			return rt.new_null()
		}
		'install_strings' {
			this.install_strings()
			return rt.new_null()
		}
		'install' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.install(dispatch_arg_0, dispatch_arg_1))
		}
		'upgrade' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.upgrade(dispatch_arg_0, dispatch_arg_1))
		}
		'bulk_upgrade' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.bulk_upgrade(dispatch_arg_0, dispatch_arg_1)
		}
		'check_package' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.check_package(dispatch_arg_0)
		}
		'plugin_info' {
			return this.plugin_info()
		}
		'deactivate_plugin_before_upgrade' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.deactivate_plugin_before_upgrade(dispatch_arg_0, dispatch_arg_1)
		}
		'active_before' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.active_before(dispatch_arg_0, dispatch_arg_1)
		}
		'active_after' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.active_after(dispatch_arg_0, dispatch_arg_1)
		}
		'delete_old_plugin' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_bool(this.delete_old_plugin(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Plugin_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'result' { return this.result }
		'bulk' { return rt.new_bool(this.bulk) }
		'new_plugin_data' { return this.new_plugin_data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Plugin_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'result' {
			this.result = val
			return true
		}
		'bulk' {
			this.bulk = val.to_bool()
			return true
		}
		'new_plugin_data' {
			this.new_plugin_data = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
