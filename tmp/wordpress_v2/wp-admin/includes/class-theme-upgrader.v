import rt

struct Class_Theme_Upgrader {
	rt.PhpObjectBase
pub mut:
	result         rt.PhpVal = rt.new_null()
	bulk           bool
	new_theme_data rt.PhpVal = rt.new_array()
}

fn (mut this Class_Theme_Upgrader) upgrade_strings() {
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('up_to_date', rt.call_function('__', [
		rt.new_string('The theme is at the latest version.'),
	]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('no_package', rt.call_function('__', [
		rt.new_string('Update package not available.'),
	]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('downloading_package', rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Downloading update from %s&#8230;')]),
		rt.new_string('<span class="code pre">%s</span>'),
	]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('unpack_package', rt.call_function('__', [
		rt.new_string('Unpacking the update&#8230;'),
	]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('remove_old', rt.call_function('__', [
		rt.new_string('Removing the old version of the theme&#8230;'),
	]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('remove_old_failed', rt.call_function('__', [
		rt.new_string('Could not remove the old theme.'),
	]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_failed', rt.call_function('__', [
		rt.new_string('Theme update failed.'),
	]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_success', rt.call_function('__', [
		rt.new_string('Theme updated successfully.'),
	]))
}

fn (mut this Class_Theme_Upgrader) install_strings() {
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('no_package', rt.call_function('__', [
		rt.new_string('Installation package not available.'),
	]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('downloading_package', rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('Downloading installation package from %s&#8230;'),
		]),
		rt.new_string('<span class="code pre">%s</span>'),
	]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('unpack_package', rt.call_function('__', [
		rt.new_string('Unpacking the package&#8230;'),
	]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('installing_package', rt.call_function('__', [
		rt.new_string('Installing the theme&#8230;'),
	]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('remove_old', rt.call_function('__', [
		rt.new_string('Removing the old version of the theme&#8230;'),
	]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('remove_old_failed', rt.call_function('__', [
		rt.new_string('Could not remove the old theme.'),
	]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('no_files', rt.call_function('__', [
		rt.new_string('The theme contains no files.'),
	]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_failed', rt.call_function('__', [
		rt.new_string('Theme installation failed.'),
	]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_success', rt.call_function('__', [
		rt.new_string('Theme installed successfully.'),
	]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_success_specific', rt.call_function('__', [
		rt.new_string('Successfully installed the theme <strong>%1$s %2$s</strong>.'),
	]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('parent_theme_search', rt.call_function('__', [
		rt.new_string('This theme requires a parent theme. Checking if it is installed&#8230;'),
	]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('parent_theme_prepare_install', rt.call_function('__', [
		rt.new_string('Preparing to install <strong>%1$s %2$s</strong>&#8230;'),
	]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('parent_theme_currently_installed', rt.call_function('__', [
		rt.new_string('The parent theme, <strong>%1$s %2$s</strong>, is currently installed.'),
	]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('parent_theme_install_success', rt.call_function('__', [
		rt.new_string('Successfully installed the parent theme, <strong>%1$s %2$s</strong>.'),
	]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('parent_theme_not_found', rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('<strong>The parent theme could not be found.</strong> You will need to install the parent theme, %s, before you can use this child theme.'),
		]),
		rt.new_string('<strong>%s</strong>'),
	]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('current_theme_has_errors', rt.call_function('__', [
		rt.new_string('The active theme has the following error: "%s".'),
	]))
	if !(!rt.is_true(rt.get_property(rt.get_property(rt.new_object('Theme_Upgrader', [
		'WP_Upgrader',
	], &this), 'skin'), 'overwrite'))) {
		if rt.is_true(rt.identical(rt.new_string('update-theme'), rt.get_property(rt.get_property(rt.new_object('Theme_Upgrader', [
			'WP_Upgrader',
		], &this), 'skin'), 'overwrite')))
		{
			rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('installing_package', rt.call_function('__', [
				rt.new_string('Updating the theme&#8230;'),
			]))
			rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_failed', rt.call_function('__', [
				rt.new_string('Theme update failed.'),
			]))
			rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_success', rt.call_function('__', [
				rt.new_string('Theme updated successfully.'),
			]))
		}
		if rt.is_true(rt.identical(rt.new_string('downgrade-theme'), rt.get_property(rt.get_property(rt.new_object('Theme_Upgrader', [
			'WP_Upgrader',
		], &this), 'skin'), 'overwrite')))
		{
			rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('installing_package', rt.call_function('__', [
				rt.new_string('Downgrading the theme&#8230;'),
			]))
			rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_failed', rt.call_function('__', [
				rt.new_string('Theme downgrade failed.'),
			]))
			rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_success', rt.call_function('__', [
				rt.new_string('Theme downgraded successfully.'),
			]))
		}
	}
}

fn (mut this Class_Theme_Upgrader) check_parent_theme_filter(var_install_result rt.PhpVal, var_hook_extra rt.PhpVal, var_child_result rt.PhpVal) rt.PhpVal {
	mut var_theme_info := rt.new_bool(this.theme_info(rt.new_null()))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_theme_info, 'parent', []rt.PhpVal{}))))) {
		return var_install_result.clone()
	}
	rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'skin'),
		'feedback', [rt.new_string('parent_theme_search')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_method(var_theme_info, 'parent',
		[]rt.PhpVal{}), 'errors', []rt.PhpVal{})))))
	{
		rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this),
			'skin'), 'feedback', [rt.new_string('parent_theme_currently_installed'),
			rt.call_method(rt.call_method(var_theme_info, 'parent', []rt.PhpVal{}), 'display', [
				rt.new_string('Name'),
			]),
			rt.call_method(rt.call_method(var_theme_info, 'parent', []rt.PhpVal{}), 'display', [
				rt.new_string('Version'),
			])])
		return var_install_result.clone()
	}
	mut var_api := rt.call_function('themes_api', [rt.new_string('theme_information'),
		rt.create_array([
			rt.ArrayItem{ key: 'slug', val: rt.call_method(var_theme_info, 'get', [
				rt.new_string('Template'),
			]) },
			rt.ArrayItem{ key: 'fields', val: rt.create_array([
				rt.ArrayItem{ key: 'sections', val: false },
				rt.ArrayItem{ key: 'tags', val: false },
			]) },
		])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_api))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_api.clone()])) {
		rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this),
			'skin'), 'feedback', [rt.new_string('parent_theme_not_found'),
			rt.call_method(var_theme_info, 'get', [rt.new_string('Template')])])
		rt.call_function('add_filter', [rt.new_string('install_theme_complete_actions'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', [
					'WP_Upgrader',
				], &this) },
				rt.ArrayItem{ key: none, val: 'hide_activate_preview_actions' },
			])])
		return var_install_result.clone()
	}
	mut var_child_api := rt.get_property(rt.get_property(rt.new_object('Theme_Upgrader', [
		'WP_Upgrader',
	], &this), 'skin'), 'api')
	mut var_child_success_message := rt.get_property(rt.new_object('Theme_Upgrader', [
		'WP_Upgrader',
	], &this), 'strings').array_get(rt.new_string('process_success'))
	rt.set_property(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'skin'),
		'api', var_api.clone())
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_success_specific', rt.get_property(rt.new_object('Theme_Upgrader', [
		'WP_Upgrader',
	], &this), 'strings').array_get(rt.new_string('parent_theme_install_success')))
	rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'skin'),
		'feedback', [rt.new_string('parent_theme_prepare_install'),
		rt.get_property(var_api, 'name'), rt.get_property(var_api, 'version')])
	rt.call_function('add_filter', [rt.new_string('install_theme_complete_actions'),
		rt.new_string('__return_false'), rt.new_int(999)])
	mut var_parent_result := this.run(rt.create_array([
		rt.ArrayItem{ key: 'package', val: rt.get_property(var_api, 'download_link') },
		rt.ArrayItem{ key: 'destination', val: rt.call_function('get_theme_root', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'clear_destination', val: false },
		rt.ArrayItem{ key: 'clear_working', val: true },
	]))
	if rt.is_true(rt.call_function('is_wp_error', [var_parent_result.clone()])) {
		rt.call_function('add_filter', [rt.new_string('install_theme_complete_actions'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', [
					'WP_Upgrader',
				], &this) },
				rt.ArrayItem{ key: none, val: 'hide_activate_preview_actions' },
			])])
	}
	rt.call_function('remove_filter', [rt.new_string('install_theme_complete_actions'),
		rt.new_string('__return_false'), rt.new_int(999)])
	this.result = var_child_result.clone()
	rt.set_property(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'skin'),
		'api', var_child_api.clone())
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_success',
		var_child_success_message.clone())
	return var_install_result.clone()
}

fn (mut this Class_Theme_Upgrader) hide_activate_preview_actions(var_actions rt.PhpVal) rt.PhpVal {
	var_actions.array_unset(rt.new_string('activate'))
	var_actions.array_unset(rt.new_string('preview'))
	return var_actions.clone()
}

fn (mut this Class_Theme_Upgrader) install(var_package rt.PhpVal, var_args rt.PhpVal) bool {
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
			rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'check_package' },
		])])
	rt.call_function('add_filter', [rt.new_string('upgrader_post_install'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'check_parent_theme_filter' },
		]),
		rt.new_int(10), rt.new_int(3)])
	if rt.is_true(var_parsed_args.array_get(rt.new_string('clear_update_cache'))) {
		rt.call_function('add_action', [rt.new_string('upgrader_process_complete'),
			rt.new_string('wp_clean_themes_cache'), rt.new_int(9),
			rt.new_int(0)])
	}
	this.run(rt.create_array([rt.ArrayItem{ key: 'package', val: var_package },
		rt.ArrayItem{ key: 'destination', val: rt.call_function('get_theme_root', []rt.PhpVal{}) },
		rt.ArrayItem{
			key: 'clear_destination'
			val: var_parsed_args.array_get(rt.new_string('overwrite_package'))
		}, rt.ArrayItem{ key: 'clear_working', val: true }, rt.ArrayItem{ key: 'hook_extra', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'theme' },
			rt.ArrayItem{ key: 'action', val: 'install' },
		]) }]))
	rt.call_function('remove_action', [rt.new_string('upgrader_process_complete'),
		rt.new_string('wp_clean_themes_cache'), rt.new_int(9)])
	rt.call_function('remove_filter', [rt.new_string('upgrader_source_selection'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'check_package' },
		])])
	rt.call_function('remove_filter', [rt.new_string('upgrader_post_install'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'check_parent_theme_filter' },
		])])
	if rt.is_true(rt.new_bool(!(rt.is_true(this.result))))
		|| rt.is_true(rt.call_function('is_wp_error', [this.result])) {
		return (this.result).to_bool()
	}
	rt.call_function('wp_clean_themes_cache', [
		var_parsed_args.array_get(rt.new_string('clear_update_cache')),
	])
	if rt.is_true(var_parsed_args.array_get(rt.new_string('overwrite_package'))) {
		rt.call_function('do_action', [rt.new_string('upgrader_overwrote_package'),
			var_package.clone(), this.new_theme_data, rt.new_string('theme')])
	}
	return true
}

fn (mut this Class_Theme_Upgrader) upgrade(var_theme rt.PhpVal, var_args rt.PhpVal) bool {
	mut var_theme_mutated := var_theme
	mut var_defaults := {
		'clear_update_cache': true
	}
	mut var_parsed_args := rt.call_function('wp_parse_args', [
		var_args.clone(), rt.create_array_from_native_map(var_defaults)])
	this.init()
	this.upgrade_strings()
	mut var_current := rt.call_function('get_site_transient', [
		rt.new_string('update_themes'),
	])
	if !(rt.get_property(var_current, 'response').array_isset(var_theme_mutated)) {
		rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this),
			'skin'), 'before', []rt.PhpVal{})
		rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this),
			'skin'), 'set_result', [rt.new_bool(false)])
		rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this),
			'skin'), 'error', [rt.new_string('up_to_date')])
		rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this),
			'skin'), 'after', []rt.PhpVal{})
		return false
	}
	mut var_upgrade_data := rt.get_property(var_current, 'response').array_get(var_theme_mutated)
	rt.call_function('add_filter', [rt.new_string('upgrader_pre_install'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'current_before' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('upgrader_post_install'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'current_after' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('upgrader_clear_destination'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'delete_old_theme' },
		]),
		rt.new_int(10), rt.new_int(4)])
	if rt.is_true(var_parsed_args.array_get(rt.new_string('clear_update_cache'))) {
		rt.call_function('add_action', [rt.new_string('upgrader_process_complete'),
			rt.new_string('wp_clean_themes_cache'), rt.new_int(9),
			rt.new_int(0)])
	}
	this.run(rt.create_array([
		rt.ArrayItem{ key: 'package', val: var_upgrade_data.array_get(rt.new_string('package')) },
		rt.ArrayItem{ key: 'destination', val: rt.call_function('get_theme_root', [
			var_theme_mutated.clone(),
		]) },
		rt.ArrayItem{ key: 'clear_destination', val: true },
		rt.ArrayItem{ key: 'clear_working', val: true },
		rt.ArrayItem{ key: 'hook_extra', val: rt.create_array([
			rt.ArrayItem{ key: 'theme', val: var_theme_mutated },
			rt.ArrayItem{ key: 'type', val: 'theme' },
			rt.ArrayItem{ key: 'action', val: 'update' },
			rt.ArrayItem{ key: 'temp_backup', val: rt.create_array([
				rt.ArrayItem{ key: 'slug', val: var_theme_mutated },
				rt.ArrayItem{ key: 'src', val: rt.call_function('get_theme_root', [
					var_theme_mutated.clone(),
				]) },
				rt.ArrayItem{ key: 'dir', val: 'themes' },
			]) },
		]) },
	]))
	rt.call_function('remove_action', [rt.new_string('upgrader_process_complete'),
		rt.new_string('wp_clean_themes_cache'), rt.new_int(9)])
	rt.call_function('remove_filter', [rt.new_string('upgrader_pre_install'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'current_before' },
		])])
	rt.call_function('remove_filter', [rt.new_string('upgrader_post_install'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'current_after' },
		])])
	rt.call_function('remove_filter', [rt.new_string('upgrader_clear_destination'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'delete_old_theme' },
		])])
	if rt.is_true(rt.new_bool(!(rt.is_true(this.result))))
		|| rt.is_true(rt.call_function('is_wp_error', [this.result])) {
		return (this.result).to_bool()
	}
	rt.call_function('wp_clean_themes_cache', [
		var_parsed_args.array_get(rt.new_string('clear_update_cache')),
	])
	mut var_past_failure_emails := rt.call_function('get_option', [
		rt.new_string('auto_plugin_theme_update_emails'),
		rt.new_array(),
	])
	if var_past_failure_emails.array_isset(var_theme_mutated) {
		var_past_failure_emails.array_unset(var_theme_mutated)
		rt.call_function('update_option', [
			rt.new_string('auto_plugin_theme_update_emails'),
			var_past_failure_emails.clone(),
		])
	}
	return true
}

fn (mut this Class_Theme_Upgrader) bulk_upgrade(var_themes rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
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
		rt.new_string('update_themes'),
	])
	rt.call_function('add_filter', [rt.new_string('upgrader_pre_install'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'current_before' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('upgrader_post_install'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'current_after' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('upgrader_clear_destination'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'delete_old_theme' },
		]),
		rt.new_int(10), rt.new_int(4)])
	rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'skin'),
		'header', []rt.PhpVal{})
	mut var_connected := this.fs_connect(rt.create_array([
		rt.ArrayItem{ key: none, val: rt.get_constant('WP_CONTENT_DIR') },
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_connected)))) {
		rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this),
			'skin'), 'footer', []rt.PhpVal{})
		return rt.new_bool(false)
	}
	rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'skin'),
		'bulk_header', []rt.PhpVal{})
	mut var_maintenance := rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& !(!rt.is_true(var_themes)))
	mut iter_1 := var_themes.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_theme := item_1.val
		var_maintenance = rt.new_bool(rt.is_true(var_maintenance)
			|| rt.is_true(rt.identical(rt.call_function('get_stylesheet', []rt.PhpVal{}), var_theme))
			|| rt.is_true(rt.identical(rt.call_function('get_template', []rt.PhpVal{}), var_theme)))
	}
	if rt.is_true(var_maintenance) {
		this.maintenance_mode(rt.new_bool(true))
	}
	mut var_results := rt.new_array()
	this.dispatch_set_prop('update_count', rt.new_int(var_themes.clone().array_count()))
	this.dispatch_set_prop('update_current', rt.new_int(0))
	mut iter_2 := var_themes.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_theme := item_2.val
		rt.pre_inc(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this),
			'update_current'))
		rt.set_property(rt.get_property(rt.new_object('Theme_Upgrader', [
			'WP_Upgrader',
		], &this), 'skin'), 'theme_info', this.theme_info(var_theme.clone()))
		if !(rt.get_property(var_current, 'response').array_isset(var_theme)) {
			rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', [
				'WP_Upgrader',
			], &this), 'skin'), 'set_result', [rt.new_bool(true)])
			rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', [
				'WP_Upgrader',
			], &this), 'skin'), 'before', []rt.PhpVal{})
			rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', [
				'WP_Upgrader',
			], &this), 'skin'), 'feedback', [rt.new_string('up_to_date')])
			rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', [
				'WP_Upgrader',
			], &this), 'skin'), 'after', []rt.PhpVal{})
			var_results.array_set(var_theme, true)
			continue
		}
		mut var_upgrade_data := rt.get_property(var_current, 'response').array_get(var_theme)
		if var_upgrade_data.array_isset(rt.new_string('requires'))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_version_compatible', [var_upgrade_data.array_get(rt.new_string('requires'))]))))) {
			mut var_result := create_wp_error(rt.new_string('incompatible_wp_required_version'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Your WordPress version is %1$s, however the new theme version requires %2$s.'),
				]),
				var_wp_version.clone(),
				var_upgrade_data.array_get(rt.new_string('requires')),
			]))
			rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', [
				'WP_Upgrader',
			], &this), 'skin'), 'before', [var_result.clone()])
			rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', [
				'WP_Upgrader',
			], &this), 'skin'), 'error', [var_result.clone()])
			rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', [
				'WP_Upgrader',
			], &this), 'skin'), 'after', []rt.PhpVal{})
		} else if var_upgrade_data.array_isset(rt.new_string('requires_php'))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_php_version_compatible', [var_upgrade_data.array_get(rt.new_string('requires_php'))]))))) {
			var_result = create_wp_error(rt.new_string('incompatible_php_required_version'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The PHP version on your server is %1$s, however the new theme version requires %2$s.'),
				]),
				rt.get_constant('PHP_VERSION'),
				var_upgrade_data.array_get(rt.new_string('requires_php')),
			]))
			rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', [
				'WP_Upgrader',
			], &this), 'skin'), 'before', [var_result.clone()])
			rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', [
				'WP_Upgrader',
			], &this), 'skin'), 'error', [var_result.clone()])
			rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', [
				'WP_Upgrader',
			], &this), 'skin'), 'after', []rt.PhpVal{})
		} else {
			rt.call_function('add_filter', [rt.new_string('upgrader_source_selection'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', [
						'WP_Upgrader',
					], &this) },
					rt.ArrayItem{ key: none, val: 'check_package' },
				])])
			var_result = this.run(rt.create_array([
				rt.ArrayItem{
					key: 'package'
					val: var_upgrade_data.array_get(rt.new_string('package'))
				},
				rt.ArrayItem{ key: 'destination', val: rt.call_function('get_theme_root', [
					var_theme.clone(),
				]) },
				rt.ArrayItem{ key: 'clear_destination', val: true },
				rt.ArrayItem{ key: 'clear_working', val: true },
				rt.ArrayItem{ key: 'is_multi', val: true },
				rt.ArrayItem{ key: 'hook_extra', val: rt.create_array([
					rt.ArrayItem{ key: 'theme', val: var_theme },
					rt.ArrayItem{ key: 'temp_backup', val: rt.create_array([
						rt.ArrayItem{ key: 'slug', val: var_theme },
						rt.ArrayItem{ key: 'src', val: rt.call_function('get_theme_root', [
							var_theme.clone(),
						]) },
						rt.ArrayItem{ key: 'dir', val: 'themes' },
					]) },
				]) },
			]))
			rt.call_function('remove_filter', [
				rt.new_string('upgrader_source_selection'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', [
						'WP_Upgrader',
					], &this) },
					rt.ArrayItem{ key: none, val: 'check_package' },
				]),
			])
		}
		var_results.array_set(var_theme, var_result.clone())
		if rt.is_true(rt.identical(rt.new_bool(false), var_result)) {
			break
		}
	}
	this.maintenance_mode(rt.new_bool(false))
	rt.call_function('wp_clean_themes_cache', [
		var_parsed_args.array_get(rt.new_string('clear_update_cache')),
	])
	rt.call_function('do_action', [rt.new_string('upgrader_process_complete'),
		rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this),
		rt.create_array([rt.ArrayItem{ key: 'action', val: 'update' },
			rt.ArrayItem{ key: 'type', val: 'theme' }, rt.ArrayItem{ key: 'bulk', val: true },
			rt.ArrayItem{ key: 'themes', val: var_themes }])])
	rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'skin'),
		'bulk_footer', []rt.PhpVal{})
	rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'skin'),
		'footer', []rt.PhpVal{})
	rt.call_function('remove_filter', [rt.new_string('upgrader_pre_install'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'current_before' },
		])])
	rt.call_function('remove_filter', [rt.new_string('upgrader_post_install'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'current_after' },
		])])
	rt.call_function('remove_filter', [rt.new_string('upgrader_clear_destination'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'delete_old_theme' },
		])])
	mut var_past_failure_emails := rt.call_function('get_option', [
		rt.new_string('auto_plugin_theme_update_emails'),
		rt.new_array(),
	])
	mut iter_3 := var_results.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_result := item_3.val
		mut var_theme := item_3.key
		if rt.is_true(rt.new_bool(!(rt.is_true(var_result))))
			|| rt.is_true(rt.call_function('is_wp_error', [var_result.clone()]))
			|| !(var_past_failure_emails.array_isset(var_theme)) {
			continue
		}
		var_past_failure_emails.array_unset(var_theme)
	}
	rt.call_function('update_option', [rt.new_string('auto_plugin_theme_update_emails'),
		var_past_failure_emails.clone()])
	return var_results.clone()
}

fn (mut this Class_Theme_Upgrader) check_package(var_source rt.PhpVal) rt.PhpVal {
	mut var_wp_filesystem := rt.new_null()
	mut var_wp_version := rt.call_function('wp_get_wp_version', []rt.PhpVal{})
	this.new_theme_data = rt.new_array()
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
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		rt.new_string(var_working_directory.str() + 'style.css'),
	])))))
	{
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('incompatible_archive_theme_no_style'), rt.get_property(rt.new_object('Theme_Upgrader', [
			'WP_Upgrader',
		], &this), 'strings').array_get(rt.new_string('incompatible_archive')), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The theme is missing the %s stylesheet.'),
			]),
			rt.new_string('<code>style.css</code>'),
		])))
	}
	mut var_new_theme_data := rt.call_function('get_file_data', [
		rt.new_string(var_working_directory.str() + 'style.css'),
		rt.create_array([rt.ArrayItem{ key: 'Name', val: 'Theme Name' },
			rt.ArrayItem{ key: 'Version', val: 'Version' }, rt.ArrayItem{
				key: 'Author'
				val: 'Author'
			}, rt.ArrayItem{ key: 'Template', val: 'Template' },
			rt.ArrayItem{ key: 'RequiresWP', val: 'Requires at least' },
			rt.ArrayItem{ key: 'RequiresPHP', val: 'Requires PHP' }]),
	])
	if !rt.is_true(var_new_theme_data.array_get(rt.new_string('Name'))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('incompatible_archive_theme_no_name'), rt.get_property(rt.new_object('Theme_Upgrader', [
			'WP_Upgrader',
		], &this), 'strings').array_get(rt.new_string('incompatible_archive')), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The %s stylesheet does not contain a valid theme header.'),
			]),
			rt.new_string('<code>style.css</code>'),
		])))
	}
	if !rt.is_true(var_new_theme_data.array_get(rt.new_string('Template')))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [rt.new_string(var_working_directory.str() + 'index.php')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [rt.new_string(var_working_directory.str() + 'templates/index.html')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [rt.new_string(var_working_directory.str() + 'block-templates/index.html')]))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('incompatible_archive_theme_no_index'), rt.get_property(rt.new_object('Theme_Upgrader', [
			'WP_Upgrader',
		], &this), 'strings').array_get(rt.new_string('incompatible_archive')), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Template is missing. Standalone themes need to have a %1$s or %2$s template file. <a href="%3$s">Child themes</a> need to have a %4$s header in the %5$s stylesheet.'),
			]),
			rt.new_string('<code>templates/index.html</code>'),
			rt.new_string('<code>index.php</code>'),
			rt.call_function('__', [
				rt.new_string('https://developer.wordpress.org/themes/advanced-topics/child-themes/'),
			]),
			rt.new_string('<code>Template</code>'),
			rt.new_string('<code>style.css</code>'),
		])))
	}
	mut var_requires_php := if !(var_new_theme_data.array_get(rt.new_string('RequiresPHP'))).is_null() {
		var_new_theme_data.array_get(rt.new_string('RequiresPHP'))
	} else {
		rt.new_null()
	}
	mut var_requires_wp := if !(var_new_theme_data.array_get(rt.new_string('RequiresWP'))).is_null() {
		var_new_theme_data.array_get(rt.new_string('RequiresWP'))
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_php_version_compatible', [
		var_requires_php.clone(),
	])))))
	{
		mut var_error := rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The PHP version on your server is %1$s, however the uploaded theme requires %2$s.'),
			]),
			rt.get_constant('PHP_VERSION'),
			var_requires_php.clone(),
		])
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('incompatible_php_required_version'), rt.get_property(rt.new_object('Theme_Upgrader', [
			'WP_Upgrader',
		], &this), 'strings').array_get(rt.new_string('incompatible_archive')), var_error.clone()))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_version_compatible', [
		var_requires_wp.clone(),
	])))))
	{
		var_error = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Your WordPress version is %1$s, however the uploaded theme requires %2$s.'),
			]),
			var_wp_version.clone(),
			var_requires_wp.clone(),
		])
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('incompatible_wp_required_version'), rt.get_property(rt.new_object('Theme_Upgrader', [
			'WP_Upgrader',
		], &this), 'strings').array_get(rt.new_string('incompatible_archive')), var_error.clone()))
	}
	this.new_theme_data = var_new_theme_data.clone()
	return var_source.clone()
}

fn (mut this Class_Theme_Upgrader) current_before(var_response rt.PhpVal, var_theme rt.PhpVal) rt.PhpVal {
	mut var_theme_mutated := var_theme
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		return var_response.clone()
	}
	var_theme_mutated = if !(var_theme_mutated.array_get(rt.new_string('theme'))).is_null() {
		var_theme_mutated.array_get(rt.new_string('theme'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_stylesheet',
		[]rt.PhpVal{}), var_theme_mutated))))
	{
		return var_response.clone()
	}
	if !(this.bulk) {
		this.maintenance_mode(rt.new_bool(true))
	}
	return var_response.clone()
}

fn (mut this Class_Theme_Upgrader) current_after(var_response rt.PhpVal, var_theme rt.PhpVal) rt.PhpVal {
	mut var_theme_mutated := var_theme
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		return var_response.clone()
	}
	var_theme_mutated = if !(var_theme_mutated.array_get(rt.new_string('theme'))).is_null() {
		var_theme_mutated.array_get(rt.new_string('theme'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_stylesheet',
		[]rt.PhpVal{}), var_theme_mutated))))
	{
		return var_response.clone()
	}
	if rt.is_true(rt.identical(rt.call_function('get_stylesheet', []rt.PhpVal{}), var_theme_mutated))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_theme_mutated, this.result.array_get(rt.new_string('destination_name')))))) {
		rt.call_function('wp_clean_themes_cache', []rt.PhpVal{})
		mut var_stylesheet := this.result.array_get(rt.new_string('destination_name'))
		rt.call_function('switch_theme', [var_stylesheet.clone()])
	}
	if !(this.bulk) {
		this.maintenance_mode(rt.new_bool(false))
	}
	return var_response.clone()
}

fn (mut this Class_Theme_Upgrader) delete_old_theme(var_removed rt.PhpVal, var_local_destination rt.PhpVal, var_remote_destination rt.PhpVal, var_theme rt.PhpVal) bool {
	mut var_wp_filesystem := rt.new_null()
	mut var_theme_mutated := var_theme
	if rt.is_true(rt.call_function('is_wp_error', [var_removed.clone()])) {
		return var_removed.to_bool()
	}
	if !(var_theme_mutated.array_isset(rt.new_string('theme'))) {
		return var_removed.to_bool()
	}
	var_theme_mutated = var_theme_mutated.array_get(rt.new_string('theme'))
	mut var_themes_dir := rt.call_function('trailingslashit', [
		rt.call_method(var_wp_filesystem, 'wp_themes_dir', [var_theme_mutated.clone()]),
	])
	if rt.is_true(rt.call_method(var_wp_filesystem, 'exists', [
		rt.new_string(var_themes_dir.str() + var_theme_mutated.str()),
	]))
	{
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'delete', [
			rt.new_string(var_themes_dir.str() + var_theme_mutated.str()),
			rt.new_bool(true),
		])))))
		{
			return false
		}
	}
	return true
}

fn (mut this Class_Theme_Upgrader) theme_info(var_theme rt.PhpVal) bool {
	mut var_theme_mutated := var_theme
	if !rt.is_true(var_theme_mutated) {
		if !(!rt.is_true(this.result.array_get(rt.new_string('destination_name')))) {
			var_theme_mutated = this.result.array_get(rt.new_string('destination_name'))
		} else {
			return false
		}
	}
	var_theme_mutated = rt.call_function('wp_get_theme', [var_theme_mutated.clone()])
	rt.call_method(var_theme_mutated, 'cache_delete', []rt.PhpVal{})
	return var_theme_mutated.to_bool()
}

struct Class_WP_Upgrader {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_theme_upgrader(_args ...rt.PhpVal) &Class_Theme_Upgrader {
	mut obj := &Class_Theme_Upgrader{
		PhpObjectBase:  rt.PhpObjectBase{}
		result:         rt.new_null()
		bulk:           false
		new_theme_data: rt.new_array()
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

fn (mut this Class_Theme_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'upgrade_strings' {
			this.upgrade_strings()
			return rt.new_null()
		}
		'install_strings' {
			this.install_strings()
			return rt.new_null()
		}
		'check_parent_theme_filter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.check_parent_theme_filter(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'hide_activate_preview_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.hide_activate_preview_actions(dispatch_arg_0)
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
		'current_before' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.current_before(dispatch_arg_0, dispatch_arg_1)
		}
		'current_after' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.current_after(dispatch_arg_0, dispatch_arg_1)
		}
		'delete_old_theme' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_bool(this.delete_old_theme(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3))
		}
		'theme_info' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.theme_info(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Theme_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'result' { return this.result }
		'bulk' { return rt.new_bool(this.bulk) }
		'new_theme_data' { return this.new_theme_data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Theme_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'result' {
			this.result = val
			return true
		}
		'bulk' {
			this.bulk = val.to_bool()
			return true
		}
		'new_theme_data' {
			this.new_theme_data = val
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
