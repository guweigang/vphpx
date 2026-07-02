import rt

struct Class_Language_Pack_Upgrader {
	rt.PhpObjectBase
pub mut:
	result rt.PhpVal = rt.new_null()
	bulk   rt.PhpVal = rt.new_bool(true)
}

fn Class_Language_Pack_Upgrader.async_upgrade(upgrader bool) {
	if var_upgrader
		&& rt.is_true(rt.new_bool(rt.instance_of(rt.new_bool(upgrader), 'Language_Pack_Upgrader'))) {
		return
	}
	mut var_language_updates := rt.call_function('wp_get_translation_updates', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_language_updates)))) {
		return
	}
	mut var_check_vcs := create_wp_automatic_updater()
	if rt.is_true(var_check_vcs.is_vcs_checkout(rt.get_constant('WP_CONTENT_DIR'))) {
		return
	}
	mut iter_1 := var_language_updates.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_language_update := item_1.val
		mut var_key := item_1.key
		mut var_update := rt.new_bool(!(!rt.is_true(rt.get_property(var_language_update,
			'autoupdate'))))
		var_update = rt.call_function('apply_filters', [
			rt.new_string('async_update_translation'),
			var_update.clone(),
			var_language_update.clone(),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_update)))) {
			var_language_updates.array_unset(var_key)
		}
	}
	if !rt.is_true(var_language_updates) {
		return
	}
	if var_upgrader
		&& rt.is_true(rt.new_bool(rt.instance_of(rt.get_property(rt.new_bool(upgrader), 'skin'), 'Automatic_Upgrader_Skin'))) {
		mut var_skin := rt.get_property(rt.new_bool(upgrader), 'skin')
	} else {
		var_skin = create_language_pack_upgrader_skin(rt.create_array([
			rt.ArrayItem{ key: 'skip_header_footer', val: true },
		]))
	}
	mut var_lp_upgrader := create_language_pack_upgrader(var_skin.clone())
	var_lp_upgrader.bulk_upgrade(var_language_updates.clone(), rt.new_null())
}

fn (mut this Class_Language_Pack_Upgrader) upgrade_strings() {
	rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('starting_upgrade', rt.call_function('__', [
		rt.new_string('Some of your translations need updating. Sit tight for a few more seconds while they are updated as well.'),
	]))
	rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('up_to_date', rt.call_function('__', [
		rt.new_string('Your translations are all up to date.'),
	]))
	rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('no_package', rt.call_function('__', [
		rt.new_string('Update package not available.'),
	]))
	rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('downloading_package', rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Downloading translation from %s&#8230;')]),
		rt.new_string('<span class="code pre">%s</span>'),
	]))
	rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('unpack_package', rt.call_function('__', [
		rt.new_string('Unpacking the update&#8230;'),
	]))
	rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_failed', rt.call_function('__', [
		rt.new_string('Translation update failed.'),
	]))
	rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('process_success', rt.call_function('__', [
		rt.new_string('Translation updated successfully.'),
	]))
	rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('remove_old', rt.call_function('__', [
		rt.new_string('Removing the old version of the translation&#8230;'),
	]))
	rt.get_property(rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this), 'strings').array_set('remove_old_failed', rt.call_function('__', [
		rt.new_string('Could not remove the old translation.'),
	]))
}

fn (mut this Class_Language_Pack_Upgrader) upgrade(update bool, var_args rt.PhpVal) rt.PhpVal {
	mut update_mutated := update
	if rt.is_true(rt.new_bool(update_mutated)) {
		update_mutated = (rt.create_array([
			rt.ArrayItem{ key: none, val: update_mutated },
		])).to_bool()
	}
	mut var_results := this.bulk_upgrade(rt.new_bool(update_mutated), var_args.clone())
	if !(var_results.clone().is_array()) {
		return var_results.clone()
	}
	return var_results.array_get(rt.new_int(0))
}

fn (mut this Class_Language_Pack_Upgrader) bulk_upgrade(var_language_updates rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_wp_filesystem := rt.new_null()
	mut var_language_updates_mutated := var_language_updates
	mut var_defaults := {
		'clear_update_cache': true
	}
	mut var_parsed_args := rt.call_function('wp_parse_args', [
		var_args.clone(), rt.create_array_from_native_map(var_defaults)])
	this.init()
	this.upgrade_strings()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_language_updates_mutated)))) {
		var_language_updates_mutated = rt.call_function('wp_get_translation_updates', []rt.PhpVal{})
	}
	if !rt.is_true(var_language_updates_mutated) {
		rt.call_method(rt.get_property(rt.new_object('Language_Pack_Upgrader', [
			'WP_Upgrader',
		], &this), 'skin'), 'header', []rt.PhpVal{})
		rt.call_method(rt.get_property(rt.new_object('Language_Pack_Upgrader', [
			'WP_Upgrader',
		], &this), 'skin'), 'set_result', [rt.new_bool(true)])
		rt.call_method(rt.get_property(rt.new_object('Language_Pack_Upgrader', [
			'WP_Upgrader',
		], &this), 'skin'), 'feedback', [rt.new_string('up_to_date')])
		rt.call_method(rt.get_property(rt.new_object('Language_Pack_Upgrader', [
			'WP_Upgrader',
		], &this), 'skin'), 'bulk_footer', []rt.PhpVal{})
		rt.call_method(rt.get_property(rt.new_object('Language_Pack_Upgrader', [
			'WP_Upgrader',
		], &this), 'skin'), 'footer', []rt.PhpVal{})
		return rt.new_bool(true)
	}
	if rt.is_true(rt.identical(rt.new_string('upgrader_process_complete'), rt.call_function('current_filter',
		[]rt.PhpVal{})))
	{
		rt.call_method(rt.get_property(rt.new_object('Language_Pack_Upgrader', [
			'WP_Upgrader',
		], &this), 'skin'), 'feedback', [rt.new_string('starting_upgrade')])
	}
	rt.call_function('remove_all_filters', [rt.new_string('upgrader_pre_install')])
	rt.call_function('remove_all_filters', [rt.new_string('upgrader_clear_destination')])
	rt.call_function('remove_all_filters', [rt.new_string('upgrader_post_install')])
	rt.call_function('remove_all_filters', [rt.new_string('upgrader_source_selection')])
	rt.call_function('add_filter', [rt.new_string('upgrader_source_selection'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Language_Pack_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'check_package' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_method(rt.get_property(rt.new_object('Language_Pack_Upgrader', [
		'WP_Upgrader',
	], &this), 'skin'), 'header', []rt.PhpVal{})
	mut var_res := this.fs_connect(rt.create_array([
		rt.ArrayItem{ key: none, val: rt.get_constant('WP_CONTENT_DIR') },
		rt.ArrayItem{ key: none, val: rt.get_constant('WP_LANG_DIR') },
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_res)))) {
		rt.call_method(rt.get_property(rt.new_object('Language_Pack_Upgrader', [
			'WP_Upgrader',
		], &this), 'skin'), 'footer', []rt.PhpVal{})
		return rt.new_bool(false)
	}
	mut var_results := rt.new_array()
	this.dispatch_set_prop('update_count',
		rt.new_int(var_language_updates_mutated.clone().array_count()))
	this.dispatch_set_prop('update_current', rt.new_int(0))
	mut var_remote_destination := rt.call_method(var_wp_filesystem, 'find_folder', [
		rt.get_constant('WP_LANG_DIR'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'exists', [
		var_remote_destination.clone(),
	])))))
	{
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'mkdir', [
			var_remote_destination.clone(),
			rt.get_constant('FS_CHMOD_DIR'),
		])))))
		{
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('mkdir_failed_lang_dir'), rt.get_property(rt.new_object('Language_Pack_Upgrader', [
				'WP_Upgrader',
			], &this), 'strings').array_get(rt.new_string('mkdir_failed')),
				var_remote_destination.clone()))
		}
	}
	mut var_language_updates_results := rt.new_array()
	mut iter_2 := var_language_updates_mutated.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_language_update := item_2.val
		rt.set_property(rt.get_property(rt.new_object('Language_Pack_Upgrader', [
			'WP_Upgrader',
		], &this), 'skin'), 'language_update', var_language_update.clone())
		mut var_destination := rt.get_constant('WP_LANG_DIR')
		if rt.is_true(rt.identical(rt.new_string('plugin'), rt.get_property(var_language_update,
			'type')))
		{
			var_destination = rt.concat(var_destination, rt.new_string('/plugins'))
		} else if rt.is_true(rt.identical(rt.new_string('theme'), rt.get_property(var_language_update,
			'type')))
		{
			var_destination = rt.concat(var_destination, rt.new_string('/themes'))
		}
		rt.pre_inc(rt.get_property(rt.new_object('Language_Pack_Upgrader', [
			'WP_Upgrader',
		], &this), 'update_current'))
		mut var_options := {
			'package':                     rt.get_property(var_language_update, 'package')
			'destination':                 var_destination
			'clear_destination':           rt.new_bool(true)
			'abort_if_destination_exists': rt.new_bool(false)
			'clear_working':               rt.new_bool(true)
			'is_multi':                    rt.new_bool(true)
			'hook_extra':                  {
				'language_update_type': rt.get_property(var_language_update, 'type')
				'language_update':      var_language_update
			}
		}
		mut var_result := this.run(var_options.clone())
		var_results.array_push(this.result)
		if rt.is_true(rt.identical(rt.new_bool(false), var_result)) {
			break
		}
		var_language_updates_results << rt.create_array([
			rt.ArrayItem{ key: 'language', val: rt.get_property(var_language_update, 'language') },
			rt.ArrayItem{ key: 'type', val: rt.get_property(var_language_update, 'type') },
			rt.ArrayItem{
				key: 'slug'
				val: if !(rt.get_property(var_language_update, 'slug')).is_null() {
					rt.get_property(var_language_update, 'slug')
				} else {
					rt.new_string('default')
				}
			},
			rt.ArrayItem{ key: 'version', val: rt.get_property(var_language_update, 'version') },
		])
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
	rt.call_function('do_action', [rt.new_string('upgrader_process_complete'),
		rt.new_object('Language_Pack_Upgrader', ['WP_Upgrader'], &this),
		rt.create_array([rt.ArrayItem{ key: 'action', val: 'update' },
			rt.ArrayItem{ key: 'type', val: 'translation' }, rt.ArrayItem{ key: 'bulk', val: true },
			rt.ArrayItem{ key: 'translations', val: var_language_updates_results }])])
	rt.call_function('add_action', [rt.new_string('upgrader_process_complete'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'Language_Pack_Upgrader' },
			rt.ArrayItem{ key: none, val: 'async_upgrade' }]),
		rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('upgrader_process_complete'),
		rt.new_string('wp_version_check'), rt.new_int(10), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('upgrader_process_complete'),
		rt.new_string('wp_update_plugins'), rt.new_int(10), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('upgrader_process_complete'),
		rt.new_string('wp_update_themes'), rt.new_int(10), rt.new_int(0)])
	rt.call_method(rt.get_property(rt.new_object('Language_Pack_Upgrader', [
		'WP_Upgrader',
	], &this), 'skin'), 'bulk_footer', []rt.PhpVal{})
	rt.call_method(rt.get_property(rt.new_object('Language_Pack_Upgrader', [
		'WP_Upgrader',
	], &this), 'skin'), 'footer', []rt.PhpVal{})
	rt.call_function('remove_filter', [rt.new_string('upgrader_source_selection'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Language_Pack_Upgrader', [
				'WP_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'check_package' },
		])])
	if rt.is_true(var_parsed_args.array_get(rt.new_string('clear_update_cache'))) {
		rt.call_function('wp_clean_update_cache', []rt.PhpVal{})
	}
	return var_results.clone()
}

fn (mut this Class_Language_Pack_Upgrader) check_package(var_source rt.PhpVal, var_remote_source rt.PhpVal) rt.PhpVal {
	mut var_wp_filesystem := rt.new_null()
	if rt.is_true(rt.call_function('is_wp_error', [var_source.clone()])) {
		return var_source.clone()
	}
	mut var_files := rt.call_method(var_wp_filesystem, 'dirlist', [
		var_remote_source.clone()])
	mut var_po := rt.new_bool(false)
	mut var_mo := rt.new_bool(false)
	mut var_php := rt.new_bool(false)
	mut iter_3 := rt.cast_array(var_files).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_filedata := item_3.val
		mut var_file := item_3.key
		if rt.is_true(rt.call_function('str_ends_with', [var_file.clone(),
			rt.new_string('.po')]))
		{
			var_po = rt.new_bool(true)
		} else if rt.is_true(rt.call_function('str_ends_with', [
			var_file.clone(), rt.new_string('.mo')]))
		{
			var_mo = rt.new_bool(true)
		} else if rt.is_true(rt.call_function('str_ends_with', [
			var_file.clone(), rt.new_string('.l10n.php')]))
		{
			var_php = rt.new_bool(true)
		}
	}
	if rt.is_true(var_php) {
		return var_source.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_mo))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_po)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('incompatible_archive_pomo'), rt.get_property(rt.new_object('Language_Pack_Upgrader', [
			'WP_Upgrader',
		], &this), 'strings').array_get(rt.new_string('incompatible_archive')), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The language pack is missing either the %1$s, %2$s, or %3$s files.'),
			]),
			rt.new_string('<code>.po</code>'),
			rt.new_string('<code>.mo</code>'),
			rt.new_string('<code>.l10n.php</code>'),
		])))
	}
	return var_source.clone()
}

fn (mut this Class_Language_Pack_Upgrader) get_name_for_update(var_update rt.PhpVal) string {
	mut var_update_mutated := var_update
	mut switch_val_1 := rt.get_property(var_update_mutated, 'type')
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('core'))) {
		return 'WordPress'
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('theme'))) {
		mut var_theme := rt.call_function('wp_get_theme', [
			rt.get_property(var_update_mutated, 'slug'),
		])
		if rt.is_true(rt.call_method(var_theme, 'exists', []rt.PhpVal{})) {
			return (rt.call_method(var_theme, 'get', [rt.new_string('Name')])).str()
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('plugin'))) {
		mut var_plugin_data := rt.call_function('get_plugins', [
			rt.new_string('/' + (rt.get_property(var_update_mutated, 'slug')).str()),
		])
		var_plugin_data = rt.call_function('reset', [var_plugin_data.clone()])
		if rt.is_true(var_plugin_data) {
			return (var_plugin_data.array_get(rt.new_string('Name'))).str()
		}
	}
	return ''
}

fn (mut this Class_Language_Pack_Upgrader) clear_destination(var_remote_destination rt.PhpVal) bool {
	mut var_wp_filesystem := rt.new_null()
	mut var_remote_destination_mutated := var_remote_destination
	mut var_language_update := rt.get_property(rt.get_property(rt.new_object('Language_Pack_Upgrader', [
		'WP_Upgrader',
	], &this), 'skin'), 'language_update')
	mut var_language_directory := rt.new_string((rt.get_constant('WP_LANG_DIR')).str() + '/')
	if rt.is_true(rt.identical(rt.new_string('core'), rt.get_property(var_language_update, 'type'))) {
		mut var_files := rt.create_array([
			rt.ArrayItem{ key: none, val: var_remote_destination_mutated.str() +
				(rt.get_property(var_language_update, 'language')).str() + '.po' },
			rt.ArrayItem{ key: none, val: var_remote_destination_mutated.str() +
				(rt.get_property(var_language_update, 'language')).str() + '.mo' },
			rt.ArrayItem{ key: none, val: var_remote_destination_mutated.str() +
				(rt.get_property(var_language_update, 'language')).str() + '.l10n.php' },
			rt.ArrayItem{ key: none, val: var_remote_destination_mutated.str() + 'admin-' +
				(rt.get_property(var_language_update, 'language')).str() + '.po' },
			rt.ArrayItem{ key: none, val: var_remote_destination_mutated.str() + 'admin-' +
				(rt.get_property(var_language_update, 'language')).str() + '.mo' },
			rt.ArrayItem{ key: none, val: var_remote_destination_mutated.str() + 'admin-' +
				(rt.get_property(var_language_update, 'language')).str() + '.l10n.php' },
			rt.ArrayItem{ key: none, val: var_remote_destination_mutated.str() + 'admin-network-' +
				(rt.get_property(var_language_update, 'language')).str() + '.po' },
			rt.ArrayItem{ key: none, val: var_remote_destination_mutated.str() + 'admin-network-' +
				(rt.get_property(var_language_update, 'language')).str() + '.mo' },
			rt.ArrayItem{ key: none, val: var_remote_destination_mutated.str() + 'admin-network-' +
				(rt.get_property(var_language_update, 'language')).str() + '.l10n.php' },
			rt.ArrayItem{ key: none, val: var_remote_destination_mutated.str() +
				'continents-cities-' + (rt.get_property(var_language_update, 'language')).str() +
				'.po' },
			rt.ArrayItem{ key: none, val: var_remote_destination_mutated.str() +
				'continents-cities-' + (rt.get_property(var_language_update, 'language')).str() +
				'.mo' },
			rt.ArrayItem{ key: none, val: var_remote_destination_mutated.str() +
				'continents-cities-' + (rt.get_property(var_language_update, 'language')).str() +
				'.l10n.php' },
		])
		mut var_json_translation_files := rt.call_function('glob', [
			rt.new_string(var_language_directory.str() +
				(rt.get_property(var_language_update, 'language')).str() + '-*.json'),
		])
		if rt.is_true(var_json_translation_files) {
			mut iter_4 := var_json_translation_files.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_json_translation_file := item_4.val
				var_files.array_push(rt.call_function('str_replace', [
					var_language_directory.clone(), var_remote_destination_mutated.clone(),
					var_json_translation_file.clone()]))
			}
		}
	} else {
		var_files = rt.create_array([
			rt.ArrayItem{ key: none, val: var_remote_destination_mutated.str() +
				(rt.get_property(var_language_update, 'slug')).str() + '-' +
				(rt.get_property(var_language_update, 'language')).str() + '.po' },
			rt.ArrayItem{ key: none, val: var_remote_destination_mutated.str() +
				(rt.get_property(var_language_update, 'slug')).str() + '-' +
				(rt.get_property(var_language_update, 'language')).str() + '.mo' },
			rt.ArrayItem{ key: none, val: var_remote_destination_mutated.str() +
				(rt.get_property(var_language_update, 'slug')).str() + '-' +
				(rt.get_property(var_language_update, 'language')).str() + '.l10n.php' },
		])
		var_language_directory = rt.new_string(var_language_directory.str() +
			(rt.get_property(var_language_update, 'type')).str() + 's/')
		var_json_translation_files = rt.call_function('glob', [
			rt.new_string(var_language_directory.str() +
				(rt.get_property(var_language_update, 'slug')).str() + '-' +
				(rt.get_property(var_language_update, 'language')).str() + '-*.json'),
		])
		if rt.is_true(var_json_translation_files) {
			mut iter_5 := var_json_translation_files.iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_json_translation_file := item_5.val
				var_files.array_push(rt.call_function('str_replace', [
					var_language_directory.clone(), var_remote_destination_mutated.clone(),
					var_json_translation_file.clone()]))
			}
		}
	}
	var_files = rt.call_function('array_filter', [var_files.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: var_wp_filesystem },
			rt.ArrayItem{ key: none, val: 'exists' }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_files)))) {
		return true
	}
	mut var_unwritable_files := rt.new_array()
	mut iter_6 := var_files.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_file := item_6.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'is_writable', [
			var_file.clone(),
		])))))
		{
			rt.call_method(var_wp_filesystem, 'chmod', [var_file.clone(),
				rt.get_constant('FS_CHMOD_FILE')])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'is_writable', [
				var_file.clone(),
			])))))
			{
				var_unwritable_files << var_file.clone()
			}
		}
	}
	if !(!rt.is_true(var_unwritable_files)) {
		return (create_wp_error(rt.new_string('files_not_writable'), rt.get_property(rt.new_object('Language_Pack_Upgrader', [
			'WP_Upgrader',
		], &this), 'strings').array_get(rt.new_string('files_not_writable')), rt.call_function('implode', [
			rt.new_string(', '),
			rt.create_array_from_list(var_unwritable_files),
		]))).to_bool()
	}
	mut iter_7 := var_files.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_file := item_7.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'delete', [
			var_file.clone(),
		])))))
		{
			return (create_wp_error(rt.new_string('remove_old_failed'), rt.get_property(rt.new_object('Language_Pack_Upgrader', [
				'WP_Upgrader',
			], &this), 'strings').array_get(rt.new_string('remove_old_failed')))).to_bool()
		}
	}
	return true
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

fn create_language_pack_upgrader(_args ...rt.PhpVal) &Class_Language_Pack_Upgrader {
	mut obj := &Class_Language_Pack_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
		result:        rt.new_null()
		bulk:          rt.new_bool(true)
	}
	return obj
}

fn create_wp_upgrader(_args ...rt.PhpVal) &Class_WP_Upgrader {
	mut obj := &Class_WP_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_automatic_updater(_args ...rt.PhpVal) &Class_WP_Automatic_Updater {
	mut obj := &Class_WP_Automatic_Updater{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_language_pack_upgrader_skin(_args ...rt.PhpVal) &Class_Language_Pack_Upgrader_Skin {
	mut obj := &Class_Language_Pack_Upgrader_Skin{
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
		else {
			return none
		}
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
		'result' {
			this.result = val
			return true
		}
		'bulk' {
			this.bulk = val
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

fn main() {
	defer {
		rt.shutdown()
	}
}
