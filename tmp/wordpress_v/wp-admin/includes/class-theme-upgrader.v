import rt

struct Class_Theme_Upgrader {
	rt.PhpObjectBase
pub mut:
		result rt.PhpVal = rt.new_null()
		bulk bool
		new_theme_data rt.PhpVal = rt.new_array()
}

fn (mut this Class_Theme_Upgrader) upgrade_strings()  {
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('up_to_date', rt.call_function('__', [rt.new_string('The theme is at the latest version.')]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('no_package', rt.call_function('__', [rt.new_string('Update package not available.')]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('downloading_package', rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Downloading update from %s&#8230;')]), rt.new_string('<span class="code pre">%s</span>')]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('unpack_package', rt.call_function('__', [rt.new_string('Unpacking the update&#8230;')]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('remove_old', rt.call_function('__', [rt.new_string('Removing the old version of the theme&#8230;')]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('remove_old_failed', rt.call_function('__', [rt.new_string('Could not remove the old theme.')]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_failed', rt.call_function('__', [rt.new_string('Theme update failed.')]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_success', rt.call_function('__', [rt.new_string('Theme updated successfully.')]))
}

fn (mut this Class_Theme_Upgrader) install_strings()  {
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('no_package', rt.call_function('__', [rt.new_string('Installation package not available.')]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('downloading_package', rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Downloading installation package from %s&#8230;')]), rt.new_string('<span class="code pre">%s</span>')]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('unpack_package', rt.call_function('__', [rt.new_string('Unpacking the package&#8230;')]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('installing_package', rt.call_function('__', [rt.new_string('Installing the theme&#8230;')]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('remove_old', rt.call_function('__', [rt.new_string('Removing the old version of the theme&#8230;')]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('remove_old_failed', rt.call_function('__', [rt.new_string('Could not remove the old theme.')]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('no_files', rt.call_function('__', [rt.new_string('The theme contains no files.')]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_failed', rt.call_function('__', [rt.new_string('Theme installation failed.')]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_success', rt.call_function('__', [rt.new_string('Theme installed successfully.')]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_success_specific', rt.call_function('__', [rt.new_string('Successfully installed the theme <strong>%1$s %2$s</strong>.')]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('parent_theme_search', rt.call_function('__', [rt.new_string('This theme requires a parent theme. Checking if it is installed&#8230;')]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('parent_theme_prepare_install', rt.call_function('__', [rt.new_string('Preparing to install <strong>%1$s %2$s</strong>&#8230;')]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('parent_theme_currently_installed', rt.call_function('__', [rt.new_string('The parent theme, <strong>%1$s %2$s</strong>, is currently installed.')]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('parent_theme_install_success', rt.call_function('__', [rt.new_string('Successfully installed the parent theme, <strong>%1$s %2$s</strong>.')]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('parent_theme_not_found', rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<strong>The parent theme could not be found.</strong> You will need to install the parent theme, %s, before you can use this child theme.')]), rt.new_string('<strong>%s</strong>')]))
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('current_theme_has_errors', rt.call_function('__', [rt.new_string('The active theme has the following error: "%s".')]))
	if !(!rt.is_true(rt.get_property(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'skin'), 'overwrite'))) {
		if rt.is_true(rt.identical(rt.new_string('update-theme'), rt.get_property(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'skin'), 'overwrite'))) {
			rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('installing_package', rt.call_function('__', [rt.new_string('Updating the theme&#8230;')]))
			rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_failed', rt.call_function('__', [rt.new_string('Theme update failed.')]))
			rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_success', rt.call_function('__', [rt.new_string('Theme updated successfully.')]))
		}
		if rt.is_true(rt.identical(rt.new_string('downgrade-theme'), rt.get_property(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'skin'), 'overwrite'))) {
			rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('installing_package', rt.call_function('__', [rt.new_string('Downgrading the theme&#8230;')]))
			rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_failed', rt.call_function('__', [rt.new_string('Theme downgrade failed.')]))
			rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_success', rt.call_function('__', [rt.new_string('Theme downgraded successfully.')]))
		}
	}
}

fn (mut this Class_Theme_Upgrader) check_parent_theme_filter(var_install_result rt.PhpVal, var_hook_extra rt.PhpVal, var_child_result rt.PhpVal) rt.PhpVal {
	mut var_theme_info := rt.new_bool(this.theme_info(rt.new_null()))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_theme_info, 'parent', []rt.PhpVal{}))))) {
		return var_install_result.dup()
	}
	rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'skin'), 'feedback', [rt.new_string('parent_theme_search')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_method(var_theme_info, 'parent', []rt.PhpVal{}), 'errors', []rt.PhpVal{}))))) {
		rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'skin'), 'feedback', [rt.new_string('parent_theme_currently_installed'), rt.call_method(rt.call_method(var_theme_info, 'parent', []rt.PhpVal{}), 'display', [rt.new_string('Name')]), rt.call_method(rt.call_method(var_theme_info, 'parent', []rt.PhpVal{}), 'display', [rt.new_string('Version')])])
		return var_install_result.dup()
	}
	mut var_api := rt.call_function('themes_api', [rt.new_string('theme_information'), rt.create_array([rt.ArrayItem{ key: 'slug', val: rt.call_method(var_theme_info, 'get', [rt.new_string('Template')]) }, rt.ArrayItem{ key: 'fields', val: rt.create_array([rt.ArrayItem{ key: 'sections', val: false }, rt.ArrayItem{ key: 'tags', val: false }]) }])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_api)))) || rt.is_true(rt.call_function('is_wp_error', [var_api.dup()])))) {
		rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'skin'), 'feedback', [rt.new_string('parent_theme_not_found'), rt.call_method(var_theme_info, 'get', [rt.new_string('Template')])])
		rt.call_function('add_filter', [rt.new_string('install_theme_complete_actions'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this) }, rt.ArrayItem{ key: none, val: 'hide_activate_preview_actions' }])])
		return var_install_result.dup()
	}
	mut var_child_api := rt.get_property(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'skin'), 'api')
	mut var_child_success_message := rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_get('process_success')
	rt.set_property(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'skin'), 'api', var_api.dup())
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_success_specific', rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_get('parent_theme_install_success'))
	rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'skin'), 'feedback', [rt.new_string('parent_theme_prepare_install'), rt.get_property(var_api, 'name'), rt.get_property(var_api, 'version')])
	rt.call_function('add_filter', [rt.new_string('install_theme_complete_actions'), rt.new_string('__return_false'), rt.new_int(999)])
	mut var_parent_result := this.run(rt.create_array([rt.ArrayItem{ key: 'package', val: rt.get_property(var_api, 'download_link') }, rt.ArrayItem{ key: 'destination', val: rt.call_function('get_theme_root', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'clear_destination', val: false }, rt.ArrayItem{ key: 'clear_working', val: true }]))
	if rt.is_true(rt.call_function('is_wp_error', [var_parent_result.dup()])) {
		rt.call_function('add_filter', [rt.new_string('install_theme_complete_actions'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this) }, rt.ArrayItem{ key: none, val: 'hide_activate_preview_actions' }])])
	}
	rt.call_function('remove_filter', [rt.new_string('install_theme_complete_actions'), rt.new_string('__return_false'), rt.new_int(999)])
	this.result = var_child_result.dup()
	rt.set_property(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'skin'), 'api', var_child_api.dup())
	rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_success', var_child_success_message.dup())
	return var_install_result.dup()
}

fn (mut this Class_Theme_Upgrader) hide_activate_preview_actions(var_actions rt.PhpVal) rt.PhpVal {
	var_actions.array_unset(rt.new_string('activate'))
	var_actions.array_unset(rt.new_string('preview'))
	return var_actions.dup()
}

fn (mut this Class_Theme_Upgrader) install(var_package rt.PhpVal, var_args rt.PhpVal) bool {
	mut var_defaults := { 'clear_update_cache': true, 'overwrite_package': false }
	mut var_parsed_args := rt.call_function('wp_parse_args', [var_args.dup(), var_defaults.dup()])
	this.init()
	this.install_strings()
	rt.call_function('add_filter', [rt.new_string('upgrader_source_selection'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this) }, rt.ArrayItem{ key: none, val: 'check_package' }])])
	rt.call_function('add_filter', [rt.new_string('upgrader_post_install'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this) }, rt.ArrayItem{ key: none, val: 'check_parent_theme_filter' }]), rt.new_int(10), rt.new_int(3)])
	if rt.is_true(var_parsed_args.array_get('clear_update_cache')) {
		rt.call_function('add_action', [rt.new_string('upgrader_process_complete'), rt.new_string('wp_clean_themes_cache'), rt.new_int(9), rt.new_int(0)])
	}
	this.run(rt.create_array([rt.ArrayItem{ key: 'package', val: var_package }, rt.ArrayItem{ key: 'destination', val: rt.call_function('get_theme_root', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'clear_destination', val: var_parsed_args.array_get('overwrite_package') }, rt.ArrayItem{ key: 'clear_working', val: true }, rt.ArrayItem{ key: 'hook_extra', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'theme' }, rt.ArrayItem{ key: 'action', val: 'install' }]) }]))
	rt.call_function('remove_action', [rt.new_string('upgrader_process_complete'), rt.new_string('wp_clean_themes_cache'), rt.new_int(9)])
	rt.call_function('remove_filter', [rt.new_string('upgrader_source_selection'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this) }, rt.ArrayItem{ key: none, val: 'check_package' }])])
	rt.call_function('remove_filter', [rt.new_string('upgrader_post_install'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this) }, rt.ArrayItem{ key: none, val: 'check_parent_theme_filter' }])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(this.result)))) || rt.is_true(rt.call_function('is_wp_error', [this.result])))) {
		return (this.result).to_bool()
	}
	rt.call_function('wp_clean_themes_cache', [var_parsed_args.array_get('clear_update_cache')])
	if rt.is_true(var_parsed_args.array_get('overwrite_package')) {
		rt.call_function('do_action', [rt.new_string('upgrader_overwrote_package'), var_package.dup(), this.new_theme_data, rt.new_string('theme')])
	}
	return true
}

fn (mut this Class_Theme_Upgrader) upgrade(var_theme rt.PhpVal, var_args rt.PhpVal) bool {
	mut var_theme_mutated := var_theme
	mut var_defaults := { 'clear_update_cache': true }
	mut var_parsed_args := rt.call_function('wp_parse_args', [var_args.dup(), var_defaults.dup()])
	this.init()
	this.upgrade_strings()
	mut var_current := rt.call_function('get_site_transient', [rt.new_string('update_themes')])
	if !(rt.get_property(var_current, 'response').array_isset(var_theme_mutated)) {
		rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'skin'), 'before', []rt.PhpVal{})
		rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'skin'), 'set_result', [rt.new_bool(false)])
		rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'skin'), 'error', [rt.new_string('up_to_date')])
		rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this), 'skin'), 'after', []rt.PhpVal{})
		return false
	}
	mut var_upgrade_data := rt.get_property(var_current, 'response').array_get(var_theme_mutated)
	rt.call_function('add_filter', [rt.new_string('upgrader_pre_install'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this) }, rt.ArrayItem{ key: none, val: 'current_before' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('upgrader_post_install'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this) }, rt.ArrayItem{ key: none, val: 'current_after' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('upgrader_clear_destination'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this) }, rt.ArrayItem{ key: none, val: 'delete_old_theme' }]), rt.new_int(10), rt.new_int(4)])
	if rt.is_true(var_parsed_args.array_get('clear_update_cache')) {
		rt.call_function('add_action', [rt.new_string('upgrader_process_complete'), rt.new_string('wp_clean_themes_cache'), rt.new_int(9), rt.new_int(0)])
	}
	this.run(rt.create_array([rt.ArrayItem{ key: 'package', val: var_upgrade_data.array_get('package') }, rt.ArrayItem{ key: 'destination', val: rt.call_function('get_theme_root', [var_theme_mutated.dup()]) }, rt.ArrayItem{ key: 'clear_destination', val: true }, rt.ArrayItem{ key: 'clear_working', val: true }, rt.ArrayItem{ key: 'hook_extra', val: rt.create_array([rt.ArrayItem{ key: 'theme', val: var_theme_mutated }, rt.ArrayItem{ key: 'type', val: 'theme' }, rt.ArrayItem{ key: 'action', val: 'update' }, rt.ArrayItem{ key: 'temp_backup', val: rt.create_array([rt.ArrayItem{ key: 'slug', val: var_theme_mutated }, rt.ArrayItem{ key: 'src', val: rt.call_function('get_theme_root', [var_theme_mutated.dup()]) }, rt.ArrayItem{ key: 'dir', val: 'themes' }]) }]) }]))
	rt.call_function('remove_action', [rt.new_string('upgrader_process_complete'), rt.new_string('wp_clean_themes_cache'), rt.new_int(9)])
	rt.call_function('remove_filter', [rt.new_string('upgrader_pre_install'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this) }, rt.ArrayItem{ key: none, val: 'current_before' }])])
	rt.call_function('remove_filter', [rt.new_string('upgrader_post_install'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this) }, rt.ArrayItem{ key: none, val: 'current_after' }])])
	rt.call_function('remove_filter', [rt.new_string('upgrader_clear_destination'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Theme_Upgrader', ['WP_Upgrader'], &this) }, rt.ArrayItem{ key: none, val: 'delete_old_theme' }])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(this.result)))) || rt.is_true(rt.call_function('is_wp_error', [this.result])))) {
		return (this.result).to_bool()
	}
	rt.call_function('wp_clean_themes_cache', [var_parsed_args.array_get('clear_update_cache')])
	mut var_past_failure_emails := rt.call_function('get_option', [rt.new_string('auto_plugin_theme_update_emails'), rt.new_array()])
	if var_past_failure_emails.array_isset(var_theme_mutated) {
		var_past_failure_emails.array_unset(var_theme_mutated)
		rt.call_function('update_option', [rt.new_string('auto_plugin_theme_update_emails'), var_past_failure_emails.dup()])
	}
	return true
}

fn (mut this Class_Theme_Upgrader) bulk_upgrade(var_themes rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_wp_version := rt.call_function('wp_get_wp_version', []rt.PhpVal{})
	mut var_defaults := { :  }
	mut var_parsed_args := 
	
}

fn (mut this Class_Theme_Upgrader) check_package(var_source rt.PhpVal) rt.PhpVal {
	mut var_wp_filesystem := rt.new_null()
}

fn (mut this Class_Theme_Upgrader) current_before(var_response rt.PhpVal, var_theme rt.PhpVal) rt.PhpVal {
	mut var_theme_mutated := var_theme
}

fn (mut this Class_Theme_Upgrader) current_after(var_response rt.PhpVal, var_theme rt.PhpVal) rt.PhpVal {
	mut var_theme_mutated := var_theme
}

fn (mut this Class_Theme_Upgrader) delete_old_theme(var_removed rt.PhpVal, var_local_destination rt.PhpVal, var_remote_destination rt.PhpVal, var_theme rt.PhpVal) bool {
	mut var_wp_filesystem := rt.new_null()
	mut var_theme_mutated := var_theme
}

fn (mut this Class_Theme_Upgrader) theme_info(var_theme rt.PhpVal) bool {
	mut var_theme_mutated := var_theme
}

struct Class_WP_Upgrader {
	rt.PhpObjectBase
}

fn create_theme_upgrader() &Class_Theme_Upgrader {
	mut obj := &Class_Theme_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
		result: rt.new_null()
		bulk: false
		new_theme_data: rt.new_array()
	}
	return obj
}

fn create_wp_upgrader() &Class_WP_Upgrader {
	mut obj := &Class_WP_Upgrader{
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
			return rt.new_bool(this.delete_old_theme(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'theme_info' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.theme_info(dispatch_arg_0))
		}
		else { return none }
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
		'result' { this.result = val; return true }
		'bulk' { this.bulk = (val).to_bool(); return true }
		'new_theme_data' { this.new_theme_data = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_admin_includes_class_theme_upgrader_php() {
}
