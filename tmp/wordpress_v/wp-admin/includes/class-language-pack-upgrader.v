import rt

struct Class_Language_Pack_Upgrader {
	rt.PhpObjectBase
pub mut:
		result rt.PhpVal = rt.new_null()
		bulk rt.PhpVal = rt.new_bool(true)
}

fn Class_Language_Pack_Upgrader.async_upgrade(upgrader bool)  {
	if rt.is_true(rt.new_bool(var_upgrader && rt.is_true(rt.new_bool(rt.instance_of(rt.new_bool(upgrader), 'Language_Pack_Upgrader'))))) {
		return rt.new_null()
	}
	mut var_language_updates := rt.call_function('wp_get_translation_updates', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_language_updates)))) {
		return rt.new_null()
	}
	mut var_check_vcs := create_wp_automatic_updater()
	if rt.is_true(var_check_vcs.is_vcs_checkout(rt.get_constant('WP_CONTENT_DIR'))) {
		return rt.new_null()
	}
	{
		mut iter_1 := var_language_updates.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_language_update := item_1.val
			mut var_key := item_1.key
			mut var_update := rt.new_bool(rt.new_bool(!(!rt.is_true(rt.get_property(var_language_update, 'autoupdate')))))
			var_update = rt.call_function('apply_filters', [rt.new_string('async_update_translation'), var_update.dup(), var_language_update.dup()])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_update)))) {
				var_language_updates.array_unset(var_key)
			}
		}
	}
	if !rt.is_true(var_language_updates) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(var_upgrader && rt.is_true(rt.new_bool(rt.instance_of(rt.get_property(rt.new_bool(upgrader), 'skin'), 'Automatic_Upgrader_Skin'))))) {
		mut var_skin := rt.get_property(rt.new_bool(upgrader), 'skin')
	} else {
		var_skin = create_language_pack_upgrader_skin(rt.create_array([rt.ArrayItem{ key: 'skip_header_footer', val: true }]))
	}
	mut var_lp_upgrader := create_language_pack_upgrader(var_skin.dup())
	var_lp_upgrader.bulk_upgrade(var_language_updates.dup(), rt.new_null())
}

fn (mut this Class_Language_Pack_Upgrader) upgrade_strings()  {
	rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('starting_upgrade', rt.call_function('__', [rt.new_string('Some of your translations need updating. Sit tight for a few more seconds while they are updated as well.')]))
	rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('up_to_date', rt.call_function('__', [rt.new_string('Your translations are all up to date.')]))
	rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('no_package', rt.call_function('__', [rt.new_string('Update package not available.')]))
	rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('downloading_package', rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Downloading translation from %s&#8230;')]), rt.new_string('<span class="code pre">%s</span>')]))
	rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('unpack_package', rt.call_function('__', [rt.new_string('Unpacking the update&#8230;')]))
	rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_failed', rt.call_function('__', [rt.new_string('Translation update failed.')]))
	rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_success', rt.call_function('__', [rt.new_string('Translation updated successfully.')]))
	rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('remove_old', rt.call_function('__', [rt.new_string('Removing the old version of the translation&#8230;')]))
	rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('remove_old_failed', rt.call_function('__', [rt.new_string('Could not remove the old translation.')]))
}

fn (mut this Class_Language_Pack_Upgrader) upgrade(update bool, var_args rt.PhpVal) rt.PhpVal {
	mut update_mutated := update
	if rt.is_true(rt.new_bool(update_mutated)) {
		update_mutated = (rt.create_array([rt.ArrayItem{ key: none, val: update_mutated }])).to_bool()
	}
	mut var_results := this.bulk_upgrade(rt.new_bool(update_mutated), var_args.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_results.dup().is_array()))))) {
		return var_results.dup()
	}
	return var_results.array_get(0)
}

fn (mut this Class_Language_Pack_Upgrader) bulk_upgrade(var_language_updates rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_wp_filesystem := rt.new_null()
	mut var_language_updates_mutated := var_language_updates
	// unsupported statement: Stmt_Global
	mut var_defaults := { 'clear_update_cache': true }
	mut var_parsed_args := rt.call_function('wp_parse_args', [var_args.dup(), var_defaults.dup()])
	this.init()
	this.upgrade_strings()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_language_updates_mutated)))) {
		var_language_updates_mutated = rt.call_function('wp_get_translation_updates', []rt.PhpVal{})
	}
	if !rt.is_true(var_language_updates_mutated) {
		rt.call_method(rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'skin'), 'header', []rt.PhpVal{})
		rt.call_method(rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'skin'), 'set_result', [rt.new_bool(true)])
		rt.call_method(rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'skin'), 'feedback', [rt.new_string('up_to_date')])
		rt.call_method(rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'skin'), 'bulk_footer', []rt.PhpVal{})
		rt.call_method(rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'skin'), 'footer', []rt.PhpVal{})
		return rt.new_bool(true)
	}
	if rt.is_true(rt.identical(rt.new_string('upgrader_process_complete'), rt.call_function('current_filter', []rt.PhpVal{}))) {
		rt.call_method(rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'skin'), 'feedback', [rt.new_string('starting_upgrade')])
	}
	rt.call_function('remove_all_filters', [rt.new_string('upgrader_pre_install')])
	rt.call_function('remove_all_filters', [rt.new_string('upgrader_clear_destination')])
	rt.call_function('remove_all_filters', [rt.new_string('upgrader_post_install')])
	rt.call_function('remove_all_filters', [rt.new_string('upgrader_source_selection')])
	rt.call_function('add_filter', [rt.new_string('upgrader_source_selection'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this) }, rt.ArrayItem{ key: none, val: 'check_package' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_method(rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'skin'), 'header', []rt.PhpVal{})
	mut var_res := this.fs_connect(rt.create_array([rt.ArrayItem{ key: none, val: rt.get_constant('WP_CONTENT_DIR') }, rt.ArrayItem{ key: none, val: rt.get_constant('WP_LANG_DIR') }]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_res)))) {
		rt.call_method(rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'skin'), 'footer', []rt.PhpVal{})
		return rt.new_bool(false)
	}
	mut var_results := rt.new_array()
	this.dispatch_set_prop('update_count', rt.new_int(var_language_updates_mutated.dup().array_count()))
	this.dispatch_set_prop('update_current', rt.new_int(0))
	mut var_remote_destination := rt.call_method(var_wp_filesystem, 'find_folder', [rt.get_constant('WP_LANG_DIR')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'exists', [var_remote_destination.dup()]))))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'mkdir', [var_remote_destination.dup(), rt.get_constant('FS_CHMOD_DIR')]))))) {
			return create_wp_error(rt.new_string('mkdir_failed_lang_dir'), rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'strings').array_get('mkdir_failed'), var_remote_destination.dup())
		}
	}
	mut var_language_updates_results := rt.new_array()
	{
		mut iter_1 := var_language_updates_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_language_update := item_1.val
			rt.set_property(rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'skin'), 'language_update', var_language_update.dup())
			mut var_destination := rt.get_constant('WP_LANG_DIR')
			if rt.is_true(rt.identical(rt.new_string('plugin'), rt.get_property(var_language_update, 'type'))) {
				// unsupported expression: Expr_AssignOp_Concat
			} else if rt.is_true(rt.identical(rt.new_string('theme'), rt.get_property(var_language_update, 'type'))) {
				// unsupported expression: Expr_AssignOp_Concat
			}
			rt.pre_inc(rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'update_current'))
			mut var_options := { 'package': rt.get_property(var_language_update, 'package'), 'destination': var_destination, 'clear_destination': rt.new_bool(true), 'abort_if_destination_exists': rt.new_bool(false), 'clear_working': rt.new_bool(true), 'is_multi': rt.new_bool(true), 'hook_extra': { 'language_update_type': rt.get_property(var_language_update, 'type'), 'language_update': var_language_update } }
			mut var_result := this.run(var_options.dup())
			var_results.array_push(this.result)
			if rt.is_true(rt.identical(rt.new_bool(false), var_result)) {
				break
			}
			var_language_updates_results << rt.create_array([rt.ArrayItem{ key: 'language', val: rt.get_property(var_language_update, 'language') }, rt.ArrayItem{ key: 'type', val: rt.get_property(var_language_update, 'type') }, rt.ArrayItem{ key: 'slug', val: if !(rt.get_property(var_language_update, 'slug')).is_null() { rt.get_property(var_language_update, 'slug') } else { rt.new_string('default') } }, rt.ArrayItem{ key: 'version', val: rt.get_property(var_language_update, 'version') }])
		}
	}
	rt.call_function('remove_action', [rt.new_string('upgrader_process_complete'), rt.create_array([rt.ArrayItem{ key: none, val: 'Language_Pack_Upgrader' }, rt.ArrayItem{ key: none, val: 'async_upgrade' }]), rt.new_int(20)])
	rt.call_function('remove_action', [rt.new_string('upgrader_process_complete'), rt.new_string('wp_version_check')])
	rt.call_function('remove_action', [rt.new_string('upgrader_process_complete'), rt.new_string('wp_update_plugins')])
	rt.call_function('remove_action', [rt.new_string('upgrader_process_complete'), rt.new_string('wp_update_themes')])
	rt.call_function('do_action', [rt.new_string('upgrader_process_complete'), rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), rt.create_array([rt.ArrayItem{ key: 'action', val: 'update' }, rt.ArrayItem{ key: 'type', val: 'translation' }, rt.ArrayItem{ key: 'bulk', val: true }, rt.ArrayItem{ key: 'translations', val: var_language_updates_results }])])
	rt.call_function('add_action', [rt.new_string('upgrader_process_complete'), rt.create_array([rt.ArrayItem{ key: none, val: 'Language_Pack_Upgrader' }, rt.ArrayItem{ key: none, val: 'async_upgrade' }]), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('upgrader_process_complete'), rt.new_string('wp_version_check'), rt.new_int(10), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('upgrader_process_complete'), rt.new_string('wp_update_plugins'), rt.new_int(10), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('upgrader_process_complete'), rt.new_string('wp_update_themes'), rt.new_int(10), rt.new_int(0)])
	rt.call_method(rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'skin'), 'bulk_footer', []rt.PhpVal{})
	rt.call_method(rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'skin'), 'footer', []rt.PhpVal{})
	rt.call_function('remove_filter', [rt.new_string('upgrader_source_selection'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this) }, rt.ArrayItem{ key: none, val: 'check_package' }])])
	if rt.is_true(var_parsed_args.array_get('clear_update_cache')) {
		rt.call_function('wp_clean_update_cache', []rt.PhpVal{})
	}
	return var_results.dup()
}

fn (mut this Class_Language_Pack_Upgrader) check_package(var_source rt.PhpVal, var_remote_source rt.PhpVal) rt.PhpVal {
	mut var_wp_filesystem := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.call_function('is_wp_error', [var_source.dup()])) {
		return var_source.dup()
	}
	mut var_files := rt.call_method(var_wp_filesystem, 'dirlist', [var_remote_source.dup()])
	mut var_po := rt.new_bool(rt.new_bool(false))
	mut var_mo := rt.new_bool(rt.new_bool(false))
	mut var_php := rt.new_bool(rt.new_bool(false))
	{
		mut iter_1 := rt.cast_array(var_files).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_filedata := item_1.val
			mut var_file := item_1.key
			if rt.is_true(rt.call_function('str_ends_with', [var_file.dup(), rt.new_string('.po')])) {
				var_po = rt.new_bool(rt.new_bool(true))
			} else if rt.is_true(rt.call_function('str_ends_with', [var_file.dup(), rt.new_string('.mo')])) {
				var_mo = rt.new_bool(rt.new_bool(true))
			} else if rt.is_true(rt.call_function('str_ends_with', [var_file.dup(), rt.new_string('.l10n.php')])) {
				var_php = rt.new_bool(rt.new_bool(true))
			}
		}
	}
	if rt.is_true(var_php) {
		return var_source.dup()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_mo)))) || rt.is_true(rt.new_bool(!(rt.is_true(var_po)))))) {
		return create_wp_error(rt.new_string('incompatible_archive_pomo'), rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'strings').array_get('incompatible_archive'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The language pack is missing either the %1$s, %2$s, or %3$s files.')]), rt.new_string('<code>.po</code>'), rt.new_string('<code>.mo</code>'), rt.new_string('<code>.l10n.php</code>')]))
	}
	return var_source.dup()
}

fn (mut this Class_Language_Pack_Upgrader) get_name_for_update(var_update rt.PhpVal) string {
	mut var_update_mutated := var_update
	mut switch_val_1 := rt.get_property(var_update_mutated, 'type')
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('core'))) {
		return 'WordPress'
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('theme'))) {
		mut var_theme := rt.call_function('wp_get_theme', [rt.get_property(, 'slug')])
		if rt.is_true(rt.call_method(var_theme, 'exists', []rt.PhpVal{})) {
			return (rt.call_method(, 'get', [])).str()
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('plugin'))) {
		mut var_plugin_data := 
		
	}
}

fn (mut this Class_Language_Pack_Upgrader) clear_destination(var_remote_destination rt.PhpVal) bool {
	mut var_wp_filesystem := rt.new_null()
	mut var_remote_destination_mutated := var_remote_destination
}

struct Class_WP_Upgrader {
	rt.PhpObjectBase
}

struct Class_WP_Automatic_Updater {
	rt.PhpObjectBase
}

struct Class_Language_Pack_Upgrader_Skin {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_language_pack_upgrader() &Class_Language_Pack_Upgrader {
	mut obj := &Class_Language_Pack_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
		result: rt.new_null()
		bulk: rt.new_bool(true)
	}
	return obj
}

fn create_wp_upgrader() &Class_WP_Upgrader {
	mut obj := &Class_WP_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_automatic_updater() &Class_WP_Automatic_Updater {
	mut obj := &Class_WP_Automatic_Updater{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_language_pack_upgrader_skin() &Class_Language_Pack_Upgrader_Skin {
	mut obj := &Class_Language_Pack_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Language_Pack_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'async_upgrade' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			Class_Language_Pack_Upgrader.async_upgrade(dispatch_arg_0)
			return rt.new_null()
		}
		'upgrade_strings' {
			this.upgrade_strings()
			return rt.new_null()
		}
		'upgrade' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.upgrade(dispatch_arg_0, dispatch_arg_1)
		}
		'bulk_upgrade' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.bulk_upgrade(dispatch_arg_0, dispatch_arg_1)
		}
		'check_package' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.check_package(dispatch_arg_0, dispatch_arg_1)
		}
		'get_name_for_update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_name_for_update(dispatch_arg_0))
		}
		'clear_destination' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.clear_destination(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Language_Pack_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'result' { return this.result }
		'bulk' { return this.bulk }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Language_Pack_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'result' { this.result = val; return true }
		'bulk' { this.bulk = val; return true }
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


fn (mut this Class_WP_Automatic_Updater) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Automatic_Updater) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Automatic_Updater) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Language_Pack_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Language_Pack_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Language_Pack_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_admin_includes_class_language_pack_upgrader_php() {
}
