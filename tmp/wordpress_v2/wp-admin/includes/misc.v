import rt
import crypto.md5

fn got_mod_rewrite() rt.PhpVal {
	mut var_got_rewrite := rt.new_null()
	var_got_rewrite = rt.call_function('apache_mod_loaded', [
		rt.new_string('mod_rewrite'),
		rt.new_bool(true),
	])
	return rt.call_function('apply_filters', [rt.new_string('got_rewrite'),
		var_got_rewrite.clone()])
}

fn got_url_rewrite() rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	mut var_got_url_rewrite := false
	var_got_url_rewrite = rt.is_true(got_mod_rewrite())
		|| rt.is_true(var_GLOBALS.array_get(rt.new_string('is_nginx')))
		|| rt.is_true(var_GLOBALS.array_get(rt.new_string('is_caddy')))
		|| rt.is_true(rt.call_function('iis7_supports_permalinks', []rt.PhpVal{}))
	return rt.call_function('apply_filters', [rt.new_string('got_url_rewrite'),
		rt.new_bool(var_got_url_rewrite).clone()])
}

fn extract_from_markers(var_filename rt.PhpVal, var_marker rt.PhpVal) rt.PhpVal {
	mut var_result := []rt.PhpVal{}
	mut var_markerdata := rt.new_null()
	mut var_state := false
	mut var_markerline := rt.new_null()
	var_result = []rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		var_filename.clone()])))))
	{
		return var_result.clone()
	}
	var_markerdata = rt.call_function('explode', [rt.new_string('\n'),
		rt.call_function('implode', [rt.new_string(''), rt.call_function('file', [
			var_filename.clone(),
		])])])
	var_state = false
	mut iter_1 := var_markerdata.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_markerline_shadow := item_1.val
		if rt.is_true(rt.call_function('str_contains', [var_markerline_shadow.clone(),
			rt.new_string('# END ' + var_marker.str())]))
		{
			var_state = false
		}
		if var_state {
			if rt.is_true(rt.call_function('str_starts_with', [
				var_markerline_shadow.clone(), rt.new_string('#')]))
			{
				continue
			}
			var_result << var_markerline_shadow.clone()
		}
		if rt.is_true(rt.call_function('str_contains', [var_markerline_shadow.clone(),
			rt.new_string('# BEGIN ' + var_marker.str())]))
		{
			var_state = true
		}
	}
	return var_result.clone()
}

fn insert_with_markers(var_filename rt.PhpVal, marker string, var_insertion_arg rt.PhpVal) bool {
	mut var_marker := marker
	mut var_insertion := var_insertion_arg
	mut var_perms := rt.new_null()
	mut var_switched_locale := rt.new_null()
	mut var_instructions := rt.new_null()
	mut var_text := rt.new_null()
	mut var_line := rt.new_null()
	mut var_start_marker := ''
	mut var_end_marker := ''
	mut var_fp := rt.new_null()
	mut var_lines := []rt.PhpVal{}
	mut var_pre_lines := []rt.PhpVal{}
	mut var_post_lines := []rt.PhpVal{}
	mut var_existing_lines := []rt.PhpVal{}
	mut var_found_marker := false
	mut var_found_end_marker := false
	mut var_new_file_data := rt.new_null()
	mut var_bytes := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		var_filename.clone()])))))
	{
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_writable', [
			rt.call_function('dirname', [var_filename.clone()]),
		])))))
		{
			return false
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('touch', [
			var_filename.clone()])))))
		{
			return false
		}
		var_perms = rt.call_function('fileperms', [var_filename.clone()])
		if rt.is_true(var_perms) {
			rt.call_function('chmod', [var_filename.clone(), rt.bitwise_or(var_perms,
				rt.new_int(420))])
		}
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_writable', [
		var_filename.clone(),
	])))))
	{
		return false
	}
	if !(var_insertion.clone().is_array()) {
		var_insertion = rt.call_function('explode', [rt.new_string('\n'),
			var_insertion.clone()])
	}
	var_switched_locale = rt.call_function('switch_to_locale', [
		rt.call_function('get_locale', []rt.PhpVal{}),
	])
	var_instructions = rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('The directives (lines) between "BEGIN %1$s" and "END %1$s" are\ndynamically generated, and should only be modified via WordPress filters.\nAny changes to the directives between these markers will be overwritten.'),
		]),
		rt.new_string(marker),
	])
	var_instructions = rt.call_function('explode', [rt.new_string('\n'),
		var_instructions.clone()])
	mut iter_2 := var_instructions.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_text_shadow := item_2.val
		mut var_line_shadow := item_2.key
		var_instructions.array_set(var_line_shadow, '# ' + var_text_shadow.str())
	}
	var_instructions = rt.call_function('apply_filters', [
		rt.new_string('insert_with_markers_inline_instructions'),
		var_instructions.clone(),
		rt.new_string(marker),
	])
	if rt.is_true(var_switched_locale) {
		rt.call_function('restore_previous_locale', []rt.PhpVal{})
	}
	var_insertion = rt.call_function('array_merge', [var_instructions.clone(),
		var_insertion.clone()])
	var_start_marker = '# BEGIN ${var_marker}'
	var_end_marker = '# END ${var_marker}'
	var_fp = rt.call_function('fopen', [var_filename.clone(),
		rt.new_string('r+')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_fp)))) {
		return false
	}
	rt.call_function('flock', [var_fp.clone(), rt.get_constant('LOCK_EX')])
	var_lines = []rt.PhpVal{}
	for rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('feof', [
		var_fp.clone()]))))) {
		var_lines << rt.call_function('fgets', [var_fp.clone()]).to_string().trim_right(' \t\n\r')
	}
	var_pre_lines = []rt.PhpVal{}
	var_post_lines = []rt.PhpVal{}
	var_existing_lines = []rt.PhpVal{}
	var_found_marker = false
	var_found_end_marker = false
	for var_line_shadow in var_lines {
		if !var_found_marker
			&& rt.is_true(rt.call_function('str_contains', [rt.new_string(var_line_shadow.str()).clone(), rt.new_string(var_start_marker.str()).clone()])) {
			var_found_marker = true
			continue
		} else if !var_found_end_marker
			&& rt.is_true(rt.call_function('str_contains', [rt.new_string(var_line_shadow.str()).clone(), rt.new_string(var_end_marker.str()).clone()])) {
			var_found_end_marker = true
			continue
		}
		if !var_found_marker {
			var_pre_lines << rt.new_string(var_line_shadow.str()).clone()
		} else if var_found_end_marker {
			var_post_lines << rt.new_string(var_line_shadow.str()).clone()
		} else {
			var_existing_lines << rt.new_string(var_line_shadow.str()).clone()
		}
	}
	if rt.is_true(rt.identical(var_existing_lines, var_insertion)) {
		rt.call_function('flock', [var_fp.clone(), rt.get_constant('LOCK_UN')])
		rt.call_function('fclose', [var_fp.clone()])
		return true
	}
	var_new_file_data = rt.call_function('implode', [rt.new_string('\n'),
		rt.call_function('array_merge', [rt.create_array_from_list(var_pre_lines),
			rt.create_array([rt.ArrayItem{ key: none, val: var_start_marker }]),
			var_insertion.clone(), rt.create_array([rt.ArrayItem{ key: none, val: var_end_marker }]),
			rt.create_array_from_list(var_post_lines)])])
	rt.call_function('fseek', [var_fp.clone(), rt.new_int(0)])
	var_bytes = rt.call_function('fwrite', [var_fp.clone(), var_new_file_data.clone()])
	if rt.is_true(var_bytes) {
		rt.call_function('ftruncate', [var_fp.clone(), rt.call_function('ftell', [
			var_fp.clone(),
		])])
	}
	rt.call_function('fflush', [var_fp.clone()])
	rt.call_function('flock', [var_fp.clone(), rt.get_constant('LOCK_UN')])
	rt.call_function('fclose', [var_fp.clone()])
	return var_bytes.to_bool()
}

fn save_mod_rewrite_rules() rt.PhpVal {
	mut var_wp_rewrite := rt.new_null()
	mut var_home_path := rt.new_null()
	mut var_htaccess_file := rt.new_null()
	mut var_rules := rt.new_null()
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		return rt.new_null()
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
	var_home_path = rt.call_function('get_home_path', []rt.PhpVal{})
	var_htaccess_file = rt.new_string(var_home_path.str() + '.htaccess')
	if (rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_htaccess_file.clone()])))))
		&& rt.is_true(rt.call_function('is_writable', [var_home_path.clone()]))
		&& rt.is_true(rt.call_method(var_wp_rewrite, 'using_mod_rewrite_permalinks', []rt.PhpVal{})))
		|| rt.is_true(rt.call_function('is_writable', [var_htaccess_file.clone()])) {
		if rt.is_true(got_mod_rewrite()) {
			var_rules = rt.call_function('explode', [rt.new_string('\n'),
				rt.call_method(var_wp_rewrite, 'mod_rewrite_rules', []rt.PhpVal{})])
			return rt.new_bool(insert_with_markers(var_htaccess_file.clone(), 'WordPress',
				var_rules.clone()))
		}
	}
	return rt.new_bool(false)
}

fn iis7_save_url_rewrite_rules() rt.PhpVal {
	mut var_wp_rewrite := rt.new_null()
	mut var_home_path := rt.new_null()
	mut var_web_config_file := rt.new_null()
	mut var_rule := rt.new_null()
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		return rt.new_null()
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
	var_home_path = rt.call_function('get_home_path', []rt.PhpVal{})
	var_web_config_file = rt.new_string(var_home_path.str() + 'web.config')
	if rt.is_true(rt.call_function('iis7_supports_permalinks', []rt.PhpVal{}))&& (rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_web_config_file.clone()])))))
		&& rt.is_true(rt.call_function('win_is_writable', [var_home_path.clone()]))
		&& rt.is_true(rt.call_method(var_wp_rewrite, 'using_mod_rewrite_permalinks', []rt.PhpVal{})))
		|| rt.is_true(rt.call_function('win_is_writable', [var_web_config_file.clone()])) {
		var_rule = rt.call_method(var_wp_rewrite, 'iis7_url_rewrite_rules', [
			rt.new_bool(false),
		])
		if !(!rt.is_true(var_rule)) {
			return rt.new_bool(iis7_add_rewrite_rule(var_web_config_file.clone(), var_rule.clone()))
		} else {
			return rt.new_bool(iis7_delete_rewrite_rule(var_web_config_file.clone()))
		}
	}
	return rt.new_bool(false)
}

fn update_recently_edited(var_file rt.PhpVal) {
	mut var_oldfiles := rt.new_null()
	var_oldfiles = rt.cast_array(rt.call_function('get_option', [
		rt.new_string('recently_edited'),
	]))
	if rt.is_true(var_oldfiles) {
		var_oldfiles = rt.call_function('array_reverse', [var_oldfiles.clone()])
		var_oldfiles.array_push(var_file.clone())
		var_oldfiles = rt.call_function('array_reverse', [var_oldfiles.clone()])
		var_oldfiles = rt.call_function('array_unique', [var_oldfiles.clone()])
		if 5 < var_oldfiles.clone().array_count() {
			rt.call_function('array_pop', [var_oldfiles.clone()])
		}
	} else {
		var_oldfiles.array_push(var_file.clone())
	}
	rt.call_function('update_option', [rt.new_string('recently_edited'),
		var_oldfiles.clone()])
}

fn wp_make_theme_file_tree(var_allowed_files rt.PhpVal) rt.PhpVal {
	mut var_tree_list := rt.new_null()
	mut var_absolute_filename := rt.new_null()
	mut var_file_name := rt.new_null()
	mut var_list := rt.new_null()
	mut var_dir := rt.new_null()
	mut var_last_dir := rt.new_null()
	var_tree_list = []rt.PhpVal{}
	mut iter_3 := var_allowed_files.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_absolute_filename_shadow := item_3.val
		mut var_file_name_shadow := item_3.key
		var_list = rt.call_function('explode', [rt.new_string('/'),
			var_file_name_shadow.clone()])
		var_last_dir = var_tree_list
		mut iter_4 := var_list.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_dir_shadow := item_4.val
			var_last_dir = var_last_dir.array_get(var_dir_shadow)
		}
		var_last_dir = var_file_name_shadow
	}
	return var_tree_list.clone()
}

fn wp_print_theme_file_tree(var_tree rt.PhpVal, level i64, size i64, index i64) {
	mut var_level := level
	mut var_size := size
	mut var_index := index
	mut var_relative_file := rt.new_null()
	mut var_stylesheet := rt.new_null()
	mut var_theme_file := rt.new_null()
	mut var_label := rt.new_null()
	mut var_filename := rt.new_null()
	mut var_url := rt.new_null()
	mut var_file_description := rt.new_null()
	if rt.is_true(rt.new_bool(var_tree.clone().is_array())) {
		var_index = 0
		var_size = var_tree.clone().array_count()
		mut iter_5 := var_tree.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_theme_file_shadow := item_5.val
			mut var_label_shadow := item_5.key
			var_index += 1
			if !(var_theme_file_shadow.clone().is_array()) {
				wp_print_theme_file_tree(var_theme_file_shadow.clone(), level, var_index, var_size)
				continue
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.new_int(level)]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.new_int(var_size)]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.new_int(var_index)]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_label_shadow.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('folder')])
			// unsupported statement: Stmt_InlineHTML
			wp_print_theme_file_tree(var_theme_file_shadow.clone(), level + 1, var_index, var_size)
			// unsupported statement: Stmt_InlineHTML
		}
	} else {
		var_filename = var_tree
		var_url = rt.call_function('add_query_arg', [
			rt.create_array([
				rt.ArrayItem{ key: 'file', val: rt.call_function('rawurlencode', [
					var_tree.clone(),
				]) },
				rt.ArrayItem{ key: 'theme', val: rt.call_function('rawurlencode', [
					var_stylesheet.clone(),
				]) },
			]),
			rt.call_function('self_admin_url', [
				rt.new_string('theme-editor.php'),
			]),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.new_string((if rt.is_true(rt.identical(var_relative_file, var_filename)) {
				'current-file'
			} else {
				''
			}).str()),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.new_string((if rt.is_true(rt.identical(var_relative_file, var_filename)) {
				'0'
			} else {
				'-1'
			}).str()),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_url.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.new_int(level)]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.new_int(var_size)]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.new_int(var_index)]))
		// unsupported statement: Stmt_InlineHTML
		var_file_description = rt.call_function('esc_html', [
			rt.call_function('get_file_description', [var_filename.clone()]),
		])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_file_description, var_filename))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('wp_basename', [var_filename.clone()]), var_file_description)))) {
			var_file_description = rt.concat(var_file_description, rt.new_string(
				'<br /><span class="nonessential">(' +
				(rt.call_function('esc_html', [var_filename.clone()])).str() + ')</span>'))
		}
		if rt.is_true(rt.identical(var_relative_file, var_filename)) {
			print('<span class="notice notice-info">' + var_file_description.str() + '</span>')
		} else {
			rt.echo_val(var_file_description)
		}
		// unsupported statement: Stmt_InlineHTML
	}
}

fn wp_make_plugin_file_tree(var_plugin_editable_files rt.PhpVal) rt.PhpVal {
	mut var_tree_list := rt.new_null()
	mut var_plugin_file := rt.new_null()
	mut var_list := rt.new_null()
	mut var_dir := rt.new_null()
	mut var_last_dir := rt.new_null()
	var_tree_list = []rt.PhpVal{}
	mut iter_6 := var_plugin_editable_files.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_plugin_file_shadow := item_6.val
		var_list = rt.call_function('explode', [rt.new_string('/'),
			rt.call_function('preg_replace', [rt.new_string('#^.+?/#'),
				rt.new_string(''), var_plugin_file_shadow.clone()])])
		var_last_dir = var_tree_list
		mut iter_7 := var_list.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_dir_shadow := item_7.val
			var_last_dir = var_last_dir.array_get(var_dir_shadow)
		}
		var_last_dir = var_plugin_file_shadow
	}
	return var_tree_list.clone()
}

fn wp_print_plugin_file_tree(var_tree rt.PhpVal, label string, level i64, size i64, index i64) {
	mut var_label := label
	mut var_level := level
	mut var_size := size
	mut var_index := index
	mut var_file := rt.new_null()
	mut var_plugin := rt.new_null()
	mut var_plugin_file := rt.new_null()
	mut var_url := rt.new_null()
	if rt.is_true(rt.new_bool(var_tree.clone().is_array())) {
		var_index = 0
		var_size = var_tree.clone().array_count()
		mut iter_8 := var_tree.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_plugin_file_shadow := item_8.val
			mut var_label_shadow := item_8.key
			var_index += 1
			if !(var_plugin_file_shadow.clone().is_array()) {
				wp_print_plugin_file_tree(var_plugin_file_shadow.clone(), var_label_shadow, level,
					var_index, var_size)
				continue
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.new_int(level)]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.new_int(var_size)]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.new_int(var_index)]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				rt.new_string(var_label_shadow.str()),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('folder')])
			// unsupported statement: Stmt_InlineHTML
			wp_print_plugin_file_tree(var_plugin_file_shadow.clone(), '', level + 1, var_index,
				var_size)
			// unsupported statement: Stmt_InlineHTML
		}
	} else {
		var_url = rt.call_function('add_query_arg', [
			rt.create_array([
				rt.ArrayItem{ key: 'file', val: rt.call_function('rawurlencode', [
					var_tree.clone(),
				]) },
				rt.ArrayItem{ key: 'plugin', val: rt.call_function('rawurlencode', [
					var_plugin.clone(),
				]) },
			]),
			rt.call_function('self_admin_url', [
				rt.new_string('plugin-editor.php'),
			]),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.new_string((if rt.is_true(rt.identical(var_file, var_tree)) {
				'current-file'
			} else {
				''
			}).str()),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.new_string((if rt.is_true(rt.identical(var_file, var_tree)) { '0' } else { '-1' }).str()),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_url.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.new_int(level)]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.new_int(var_size)]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.new_int(var_index)]))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.identical(var_file, var_tree)) {
			print('<span class="notice notice-info">' +
				(rt.call_function('esc_html', [rt.new_string(var_label.str())])).str() + '</span>')
		} else {
			rt.echo_val(rt.call_function('esc_html', [rt.new_string(var_label.str())]))
		}
		// unsupported statement: Stmt_InlineHTML
	}
}

fn update_home_siteurl(var_old_value rt.PhpVal, var_value rt.PhpVal) {
	if rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})) {
		return
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('ms_is_switched', []rt.PhpVal{})) {
		rt.call_function('delete_option', [rt.new_string('rewrite_rules')])
	} else {
		rt.call_function('flush_rewrite_rules', []rt.PhpVal{})
	}
}

fn wp_reset_vars(var_vars rt.PhpVal) {
	mut var_GLOBALS := rt.new_null()
	mut var_var := rt.new_null()
	mut iter_9 := var_vars.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_var_shadow := item_9.val
		if !rt.is_true(rt.get_superglobal('_POST').array_get(var_var_shadow)) {
			if !rt.is_true(rt.get_superglobal('_GET').array_get(var_var_shadow)) {
				var_GLOBALS.array_set(var_var_shadow, '')
			} else {
				var_GLOBALS.array_set(var_var_shadow,
					rt.get_superglobal('_GET').array_get(var_var_shadow))
			}
		} else {
			var_GLOBALS.array_set(var_var_shadow,
				rt.get_superglobal('_POST').array_get(var_var_shadow))
		}
	}
}

fn show_message(var_message_arg rt.PhpVal) {
	mut var_message := var_message_arg
	if rt.is_true(rt.call_function('is_wp_error', [var_message.clone()])) {
		if rt.is_true(rt.call_method(var_message, 'get_error_data', []rt.PhpVal{}))
			&& rt.call_method(var_message, 'get_error_data', []rt.PhpVal{}).is_string() {
			var_message = rt.new_string(
				(rt.call_method(var_message, 'get_error_message', []rt.PhpVal{})).str() + ': ' +
				(rt.call_method(var_message, 'get_error_data', []rt.PhpVal{})).str())
		} else {
			var_message = rt.call_method(var_message, 'get_error_message', []rt.PhpVal{})
		}
	}
	print('<p>${var_message.to_string()}</p>\n')
	rt.call_function('wp_ob_end_flush_all', []rt.PhpVal{})
	rt.call_function('flush', []rt.PhpVal{})
}

fn wp_doc_link_parse(var_content rt.PhpVal) rt.PhpVal {
	mut var_tokens := rt.new_null()
	mut var_count := i64(0)
	mut var_functions := rt.new_null()
	mut var_ignore_functions := rt.new_null()
	mut var_t := i64(0)
	mut var_output := []rt.PhpVal{}
	mut var_function := rt.new_null()
	if !(var_content.clone().is_string()) || !rt.is_true(var_content) {
		return []rt.PhpVal{}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('token_get_all'),
	])))))
	{
		return []rt.PhpVal{}
	}
	var_tokens = rt.call_function('token_get_all', [var_content.clone()])
	var_count = var_tokens.clone().array_count()
	var_functions = []rt.PhpVal{}
	var_ignore_functions = []rt.PhpVal{}
	var_t = 0
	for {
		if !(var_t < var_count - 2) { break
		 }
		if !(var_tokens.array_get(rt.new_int(var_t)).is_array()) {
			continue
		}
		if rt.is_true(rt.identical(rt.get_constant('T_STRING'), var_tokens.array_get(rt.new_int(var_t)).array_get(rt.new_int(0))))
			&& rt.is_true(rt.identical(rt.new_string('('), var_tokens.array_get(rt.new_int(var_t + 1))))
			|| rt.is_true(rt.identical(rt.new_string('('), var_tokens.array_get(rt.new_int(var_t + 2)))) {
			if (var_tokens.array_get(rt.new_int(var_t - 2)).array_isset(rt.new_int(1))
				&& rt.is_true(rt.call_function('in_array', [var_tokens.array_get(rt.new_int(var_t - 2)).array_get(rt.new_int(1)), rt.create_array([rt.ArrayItem{
				key: none
				val: 'function'
			}, rt.ArrayItem{ key: none, val: 'class' }]), rt.new_bool(true)])))
				|| (var_tokens.array_get(rt.new_int(var_t - 2)).array_isset(rt.new_int(0))
				&& rt.is_true(rt.identical(rt.get_constant('T_OBJECT_OPERATOR'), var_tokens.array_get(rt.new_int(var_t - 1)).array_get(rt.new_int(0))))) {
				var_ignore_functions.array_push(var_tokens.array_get(rt.new_int(var_t)).array_get(rt.new_int(1)))
			}
			var_functions.array_push(var_tokens.array_get(rt.new_int(var_t)).array_get(rt.new_int(1)))
		}
		var_t += 1
	}
	var_functions = rt.call_function('array_unique', [var_functions.clone()])
	rt.call_function('sort', [var_functions.clone()])
	var_ignore_functions = rt.call_function('apply_filters', [
		rt.new_string('documentation_ignore_functions'),
		var_ignore_functions.clone(),
	])
	var_ignore_functions = rt.call_function('array_unique', [
		var_ignore_functions.clone()])
	var_output = []rt.PhpVal{}
	mut iter_10 := var_functions.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_function_shadow := item_10.val
		if rt.is_true(rt.call_function('in_array', [var_function_shadow.clone(),
			var_ignore_functions.clone(), rt.new_bool(true)]))
		{
			continue
		}
		var_output << var_function_shadow.clone()
	}
	return var_output.clone()
}

fn set_screen_options() {
	mut var_user := rt.new_null()
	mut var_option := rt.new_null()
	mut var_value := rt.new_null()
	mut var_map_option := rt.new_null()
	mut var_type := rt.new_null()
	mut var_screen_option := rt.new_null()
	mut var_url := rt.new_null()
	if !(rt.get_superglobal('_POST').array_isset(rt.new_string('wp_screen_options')))
		|| !(rt.get_superglobal('_POST').array_get(rt.new_string('wp_screen_options')).is_array()) {
		return
	}
	rt.call_function('check_admin_referer', [rt.new_string('screen-options-nonce'),
		rt.new_string('screenoptionnonce')])
	var_user = rt.call_function('wp_get_current_user', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return
	}
	var_option =
		rt.get_superglobal('_POST').array_get(rt.new_string('wp_screen_options')).array_get(rt.new_string('option'))
	var_value =
		rt.get_superglobal('_POST').array_get(rt.new_string('wp_screen_options')).array_get(rt.new_string('value'))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('sanitize_key', [
		var_option.clone(),
	]), var_option))))
	{
		return
	}
	var_map_option = var_option.clone()
	var_type = rt.call_function('str_replace', [rt.new_string('edit_'),
		rt.new_string(''), var_map_option.clone()])
	var_type = rt.call_function('str_replace', [rt.new_string('_per_page'),
		rt.new_string(''), var_type.clone()])
	if rt.is_true(rt.call_function('in_array', [var_type.clone(),
		rt.call_function('get_taxonomies', []rt.PhpVal{}), rt.new_bool(true)]))
	{
		var_map_option = rt.new_string('edit_tags_per_page')
	} else if rt.is_true(rt.call_function('in_array', [var_type.clone(),
		rt.call_function('get_post_types', []rt.PhpVal{}), rt.new_bool(true)]))
	{
		var_map_option = rt.new_string('edit_per_page')
	} else {
		var_option = rt.call_function('str_replace', [rt.new_string('-'),
			rt.new_string('_'), var_option.clone()])
	}
	mut switch_val_1 := var_map_option
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit_per_page')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('users_per_page')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('edit_comments_per_page')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('upload_per_page')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('edit_tags_per_page')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('plugins_per_page')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('export_personal_data_requests_per_page')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('remove_personal_data_requests_per_page')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('sites_network_per_page')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('users_network_per_page')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('site_users_network_per_page')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('plugins_network_per_page')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('themes_network_per_page')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('site_themes_network_per_page'))) {
		var_value = rt.new_int(var_value.to_i64())
		if rt.is_true(rt.less(var_value, rt.new_int(1)))
			|| rt.is_true(rt.greater(var_value, rt.new_int(999))) {
			return
		}
	} else {
		var_screen_option = rt.new_bool(false)
		if rt.is_true(rt.call_function('str_ends_with', [var_option.clone(), rt.new_string('_page')]))
			|| rt.is_true(rt.identical(rt.new_string('layout_columns'), var_option)) {
			var_screen_option = rt.call_function('apply_filters', [
				rt.new_string('set-screen-option'),
				var_screen_option.clone(),
				var_option.clone(),
				var_value.clone(),
			])
		}
		var_value = rt.call_function('apply_filters', [
			rt.new_string('set_screen_option_${var_option.to_string()}'),
			var_screen_option.clone(),
			var_option.clone(),
			var_value.clone(),
		])
		if rt.is_true(rt.identical(rt.new_bool(false), var_value)) {
			return
		}
	}
	rt.call_function('update_user_meta', [rt.get_property(var_user, 'ID'),
		var_option.clone(), var_value.clone()])
	var_url = rt.call_function('remove_query_arg', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'pagenum' },
			rt.ArrayItem{ key: none, val: 'apage' }, rt.ArrayItem{ key: none, val: 'paged' }]),
		rt.call_function('wp_get_referer', []rt.PhpVal{}),
	])
	if rt.get_superglobal('_POST').array_isset(rt.new_string('mode')) {
		var_url = rt.call_function('add_query_arg', [
			rt.create_array([
				rt.ArrayItem{
					key: 'mode'
					val: rt.get_superglobal('_POST').array_get(rt.new_string('mode'))
				},
			]),
			var_url.clone(),
		])
	}
	rt.call_function('wp_safe_redirect', [var_url.clone()])
	exit(0)
}

fn iis7_rewrite_rule_exists(var_filename rt.PhpVal) bool {
	mut var_doc := rt.new_null()
	mut var_xpath := rt.new_null()
	mut var_rules := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		var_filename.clone()])))))
	{
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('DOMDocument'),
		rt.new_bool(false),
	])))))
	{
		return false
	}
	var_doc = create_domdocument()
	if rt.is_true(rt.identical(var_doc.load(var_filename.clone()), rt.new_bool(false))) {
		return false
	}
	var_xpath = create_domxpath(var_doc)
	var_rules =
		var_xpath.query(rt.new_string("/configuration/system.webServer/rewrite/rules/rule[starts-with(@name,'wordpress')] | /configuration/system.webServer/rewrite/rules/rule[starts-with(@name,'WordPress')]"))
	if rt.is_true(rt.identical(rt.new_int(0), rt.get_property(var_rules, 'length'))) {
		return false
	}
	return true
}

fn iis7_delete_rewrite_rule(var_filename rt.PhpVal) bool {
	mut var_doc := rt.new_null()
	mut var_xpath := rt.new_null()
	mut var_rules := rt.new_null()
	mut var_child := rt.new_null()
	mut var_parent := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		var_filename.clone()])))))
	{
		return true
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('DOMDocument'),
		rt.new_bool(false),
	])))))
	{
		return false
	}
	var_doc = create_domdocument()
	rt.set_property(var_doc, 'preserveWhiteSpace', rt.new_bool(false))
	if rt.is_true(rt.identical(var_doc.load(var_filename.clone()), rt.new_bool(false))) {
		return false
	}
	var_xpath = create_domxpath(var_doc)
	var_rules =
		var_xpath.query(rt.new_string("/configuration/system.webServer/rewrite/rules/rule[starts-with(@name,'wordpress')] | /configuration/system.webServer/rewrite/rules/rule[starts-with(@name,'WordPress')]"))
	if rt.is_true(rt.greater(rt.get_property(var_rules, 'length'), rt.new_int(0))) {
		var_child = rt.call_method(var_rules, 'item', [rt.new_int(0)])
		var_parent = rt.get_property(var_child, 'parentNode')
		rt.call_method(var_parent, 'removeChild', [var_child.clone()])
		rt.set_property(var_doc, 'formatOutput', rt.new_bool(true))
		savedomdocument(var_doc, var_filename.clone())
	}
	return true
}

fn iis7_add_rewrite_rule(var_filename rt.PhpVal, var_rewrite_rule rt.PhpVal) bool {
	mut var_fp := rt.new_null()
	mut var_doc := rt.new_null()
	mut var_xpath := rt.new_null()
	mut var_wordpress_rules := rt.new_null()
	mut var_xml_nodes := rt.new_null()
	mut var_rules_node := rt.new_null()
	mut var_rewrite_node := rt.new_null()
	mut var_system_web_server_node := rt.new_null()
	mut var_config_node := rt.new_null()
	mut var_rule_fragment := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('DOMDocument'),
		rt.new_bool(false),
	])))))
	{
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		var_filename.clone()])))))
	{
		var_fp = rt.call_function('fopen', [var_filename.clone(),
			rt.new_string('w')])
		rt.call_function('fwrite', [var_fp.clone(), rt.new_string('<configuration/>')])
		rt.call_function('fclose', [var_fp.clone()])
	}
	var_doc = create_domdocument()
	rt.set_property(var_doc, 'preserveWhiteSpace', rt.new_bool(false))
	if rt.is_true(rt.identical(var_doc.load(var_filename.clone()), rt.new_bool(false))) {
		return false
	}
	var_xpath = create_domxpath(var_doc)
	var_wordpress_rules =
		var_xpath.query(rt.new_string("/configuration/system.webServer/rewrite/rules/rule[starts-with(@name,'wordpress')] | /configuration/system.webServer/rewrite/rules/rule[starts-with(@name,'WordPress')]"))
	if rt.is_true(rt.greater(rt.get_property(var_wordpress_rules, 'length'), rt.new_int(0))) {
		return true
	}
	var_xml_nodes = var_xpath.query(rt.new_string('/configuration/system.webServer/rewrite/rules'))
	if rt.is_true(rt.greater(rt.get_property(var_xml_nodes, 'length'), rt.new_int(0))) {
		var_rules_node = rt.call_method(var_xml_nodes, 'item', [
			rt.new_int(0)])
	} else {
		var_rules_node = var_doc.createelement(rt.new_string('rules'))
		var_xml_nodes = var_xpath.query(rt.new_string('/configuration/system.webServer/rewrite'))
		if rt.is_true(rt.greater(rt.get_property(var_xml_nodes, 'length'), rt.new_int(0))) {
			var_rewrite_node = rt.call_method(var_xml_nodes, 'item', [
				rt.new_int(0)])
			rt.call_method(var_rewrite_node, 'appendChild', [
				var_rules_node.clone()])
		} else {
			var_rewrite_node = var_doc.createelement(rt.new_string('rewrite'))
			rt.call_method(var_rewrite_node, 'appendChild', [
				var_rules_node.clone()])
			var_xml_nodes = var_xpath.query(rt.new_string('/configuration/system.webServer'))
			if rt.is_true(rt.greater(rt.get_property(var_xml_nodes, 'length'), rt.new_int(0))) {
				var_system_web_server_node = rt.call_method(var_xml_nodes, 'item', [
					rt.new_int(0),
				])
				rt.call_method(var_system_web_server_node, 'appendChild', [
					var_rewrite_node.clone()])
			} else {
				var_system_web_server_node =
					var_doc.createelement(rt.new_string('system.webServer'))
				rt.call_method(var_system_web_server_node, 'appendChild', [
					var_rewrite_node.clone()])
				var_xml_nodes = var_xpath.query(rt.new_string('/configuration'))
				if rt.is_true(rt.greater(rt.get_property(var_xml_nodes, 'length'), rt.new_int(0))) {
					var_config_node = rt.call_method(var_xml_nodes, 'item', [
						rt.new_int(0),
					])
					rt.call_method(var_config_node, 'appendChild', [
						var_system_web_server_node.clone()])
				} else {
					var_config_node = var_doc.createelement(rt.new_string('configuration'))
					var_doc.appendchild(var_config_node.clone())
					rt.call_method(var_config_node, 'appendChild', [
						var_system_web_server_node.clone()])
				}
			}
		}
	}
	var_rule_fragment = var_doc.createdocumentfragment()
	rt.call_method(var_rule_fragment, 'appendXML', [var_rewrite_rule.clone()])
	rt.call_method(var_rules_node, 'appendChild', [var_rule_fragment.clone()])
	rt.set_property(var_doc, 'encoding', rt.new_string('UTF-8'))
	rt.set_property(var_doc, 'formatOutput', rt.new_bool(true))
	savedomdocument(var_doc, var_filename.clone())
	return true
}

fn savedomdocument(var_doc rt.PhpVal, var_filename rt.PhpVal) {
	mut var_config := rt.new_null()
	mut var_fp := rt.new_null()
	var_config = var_doc.savexml()
	var_config = rt.call_function('preg_replace', [rt.new_string('/([^\r])\n/'),
		rt.new_string('$1\r\n'), var_config.clone()])
	var_fp = rt.call_function('fopen', [var_filename.clone(),
		rt.new_string('w')])
	rt.call_function('fwrite', [var_fp.clone(), var_config.clone()])
	rt.call_function('fclose', [var_fp.clone()])
}

fn admin_color_scheme_picker(var_user_id rt.PhpVal) {
	mut var__wp_admin_css_colors := rt.new_null()
	mut var_current_color := rt.new_null()
	mut var_color_info := rt.new_null()
	mut var_color := rt.new_null()
	mut var_html_color := rt.new_null()
	rt.call_function('ksort', [var__wp_admin_css_colors.clone()])
	if var__wp_admin_css_colors.array_isset(rt.new_string('modern')) {
		var__wp_admin_css_colors = rt.call_function('array_filter', [
			rt.call_function('array_merge', [
				rt.create_array([rt.ArrayItem{ key: 'modern', val: '' },
					rt.ArrayItem{ key: 'fresh', val: '' }, rt.ArrayItem{ key: 'light', val: '' }]),
				var__wp_admin_css_colors.clone(),
			]),
		])
	}
	var_current_color = rt.call_function('get_user_option', [
		rt.new_string('admin_color'),
		var_user_id.clone(),
	])
	if !rt.is_true(var_current_color) || !(var__wp_admin_css_colors.array_isset(var_current_color)) {
		var_current_color = rt.new_string('modern')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Administration Color Scheme')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('save-color-scheme'),
		rt.new_string('color-nonce'), rt.new_bool(false)])
	mut iter_11 := var__wp_admin_css_colors.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_color_info_shadow := item_11.val
		mut var_color_shadow := item_11.key
		// unsupported statement: Stmt_InlineHTML
		print(if rt.is_true(rt.identical(var_color_shadow, var_current_color)) {
			'selected'
		} else {
			''
		})
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_color_shadow.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_color_shadow.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [var_color_shadow.clone(),
			var_current_color.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.get_property(var_color_info_shadow, 'url'),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.call_function('wp_json_encode', [
				rt.create_array([
					rt.ArrayItem{ key: 'icons', val: rt.get_property(var_color_info_shadow,
						'icon_colors') },
				]),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_color_shadow.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			rt.get_property(var_color_info_shadow, 'name'),
		]))
		// unsupported statement: Stmt_InlineHTML
		mut iter_12 := rt.get_property(var_color_info_shadow, 'colors').iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_html_color_shadow := item_12.val
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_html_color_shadow.clone()]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn wp_color_scheme_settings() {
	mut var__wp_admin_css_colors := rt.new_null()
	mut var_color_scheme := rt.new_null()
	mut var_icon_colors := rt.new_null()
	var_color_scheme = rt.call_function('get_user_option', [rt.new_string('admin_color')])
	if !rt.is_true(var__wp_admin_css_colors.array_get(var_color_scheme)) {
		var_color_scheme = rt.new_string('modern')
	}
	if !(!rt.is_true(rt.get_property(var__wp_admin_css_colors.array_get(var_color_scheme),
		'icon_colors'))) {
		var_icon_colors = rt.get_property(var__wp_admin_css_colors.array_get(var_color_scheme),
			'icon_colors')
	} else if !(!rt.is_true(rt.get_property(var__wp_admin_css_colors.array_get(rt.new_string('modern')),
		'icon_colors'))) {
		var_icon_colors = rt.get_property(var__wp_admin_css_colors.array_get(rt.new_string('modern')),
			'icon_colors')
	} else {
		var_icon_colors = rt.create_array([rt.ArrayItem{ key: 'base', val: '#a7aaad' },
			rt.ArrayItem{ key: 'focus', val: '#72aee6' }, rt.ArrayItem{ key: 'current', val: '#fff' }])
	}
	print('<script>var _wpColorScheme = ' +
		(rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{
		key: 'icons'
		val: var_icon_colors
	}]), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])).str() +
		';</script>\n')
}

fn wp_admin_viewport_meta() {
	mut var_viewport_meta := rt.new_null()
	var_viewport_meta = rt.call_function('apply_filters', [
		rt.new_string('admin_viewport_meta'),
		rt.new_string('width=device-width,initial-scale=1.0'),
	])
	if !rt.is_true(var_viewport_meta) {
		return
	}
	print('<meta name="viewport" content="' +
		(rt.call_function('esc_attr', [var_viewport_meta.clone()])).str() + '">')
}

fn _customizer_mobile_viewport_meta(var_viewport_meta rt.PhpVal) string {
	return var_viewport_meta.clone().to_string().trim_space() +
		',minimum-scale=0.5,maximum-scale=1.2'
}

fn wp_check_locked_posts(var_response rt.PhpVal, var_data rt.PhpVal, var_screen_id rt.PhpVal) rt.PhpVal {
	mut var_checked := rt.new_null()
	mut var_key := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_user_id := rt.new_null()
	mut var_user := rt.new_null()
	mut var_send := map[string]rt.PhpVal{}
	var_checked = []rt.PhpVal{}
	if rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_data).array_isset(rt.new_string('wp-check-locked-posts'))))
		&& var_data.array_get(rt.new_string('wp-check-locked-posts')).is_array() {
		mut iter_13 := var_data.array_get(rt.new_string('wp-check-locked-posts')).iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_key_shadow := item_13.val
			var_post_id = rt.call_function('absint', [
				rt.call_function('substr', [var_key_shadow.clone(),
					rt.new_int(5)]),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
				continue
			}
			var_user_id = rt.call_function('wp_check_post_lock', [
				var_post_id.clone()])
			if rt.is_true(var_user_id) {
				var_user = rt.call_function('get_userdata', [
					var_user_id.clone()])
				if rt.is_true(var_user)
					&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), var_post_id.clone()])) {
					var_send = {
						'name': rt.get_property(var_user, 'display_name')
						'text': rt.call_function('sprintf', [
							rt.call_function('__', [
								rt.new_string('%s is currently editing'),
							]),
							rt.get_property(var_user, 'display_name'),
						])
					}
					if rt.is_true(rt.call_function('get_option', [
						rt.new_string('show_avatars'),
					]))
					{
						var_send['avatar_src'] = rt.call_function('get_avatar_url', [
							rt.get_property(var_user, 'ID'),
							rt.create_array([rt.ArrayItem{ key: 'size', val: 18 }]),
						])
						var_send['avatar_src_2x'] = rt.call_function('get_avatar_url', [
							rt.get_property(var_user, 'ID'),
							rt.create_array([rt.ArrayItem{ key: 'size', val: 36 }]),
						])
					}
					var_checked.array_set(var_key_shadow, var_send.clone())
				}
			}
		}
	}
	if !(!rt.is_true(var_checked)) {
		var_response.array_set('wp-check-locked-posts', var_checked.clone())
	}
	return var_response.clone()
}

fn wp_refresh_post_lock(var_response rt.PhpVal, var_data rt.PhpVal, var_screen_id rt.PhpVal) rt.PhpVal {
	mut var_received := rt.new_null()
	mut var_send := map[string]rt.PhpVal{}
	mut var_post_id := rt.new_null()
	mut var_user_id := rt.new_null()
	mut var_user := rt.new_null()
	mut var_error := map[string]rt.PhpVal{}
	mut var_new_lock := rt.new_null()
	if rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_data).array_isset(rt.new_string('wp-refresh-post-lock')))) {
		var_received = var_data.array_get(rt.new_string('wp-refresh-post-lock'))
		var_send = []rt.PhpVal{}
		var_post_id = rt.call_function('absint', [var_received.array_get(rt.new_string('post_id'))])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
			return var_response.clone()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_post'),
			var_post_id.clone(),
		])))))
		{
			return var_response.clone()
		}
		var_user_id = rt.call_function('wp_check_post_lock', [
			var_post_id.clone()])
		var_user = rt.call_function('get_userdata', [var_user_id.clone()])
		if rt.is_true(var_user) {
			var_error = {
				'name': rt.get_property(var_user, 'display_name')
				'text': rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('%s has taken over and is currently editing.'),
					]),
					rt.get_property(var_user, 'display_name'),
				])
			}
			if rt.is_true(rt.call_function('get_option', [rt.new_string('show_avatars')])) {
				var_error['avatar_src'] = rt.call_function('get_avatar_url', [
					rt.get_property(var_user, 'ID'),
					rt.create_array([rt.ArrayItem{ key: 'size', val: 64 }]),
				])
				var_error['avatar_src_2x'] = rt.call_function('get_avatar_url', [
					rt.get_property(var_user, 'ID'),
					rt.create_array([rt.ArrayItem{ key: 'size', val: 128 }]),
				])
			}
			var_send['lock_error'] = var_error.clone()
		} else {
			var_new_lock = rt.call_function('wp_set_post_lock', [
				var_post_id.clone()])
			if rt.is_true(var_new_lock) {
				var_send['new_lock'] = rt.call_function('implode', [
					rt.new_string(':'), var_new_lock.clone()])
			}
		}
		var_response.array_set('wp-refresh-post-lock', var_send.clone())
	}
	return var_response.clone()
}

fn wp_refresh_post_nonces(var_response rt.PhpVal, var_data rt.PhpVal, var_screen_id rt.PhpVal) rt.PhpVal {
	mut var_received := rt.new_null()
	mut var_post_id := rt.new_null()
	if rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_data).array_isset(rt.new_string('wp-refresh-post-nonces')))) {
		var_received = var_data.array_get(rt.new_string('wp-refresh-post-nonces'))
		var_response.array_set('wp-refresh-post-nonces', rt.create_array([
			rt.ArrayItem{ key: 'check', val: 1 },
		]))
		var_post_id = rt.call_function('absint', [var_received.array_get(rt.new_string('post_id'))])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
			return var_response.clone()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_post'),
			var_post_id.clone(),
		])))))
		{
			return var_response.clone()
		}
		var_response.array_set('wp-refresh-post-nonces', rt.create_array([
			rt.ArrayItem{ key: 'replace', val: rt.create_array([
				rt.ArrayItem{ key: 'getpermalinknonce', val: rt.call_function('wp_create_nonce', [
					rt.new_string('getpermalink'),
				]) },
				rt.ArrayItem{ key: 'samplepermalinknonce', val: rt.call_function('wp_create_nonce', [
					rt.new_string('samplepermalink'),
				]) },
				rt.ArrayItem{ key: 'closedpostboxesnonce', val: rt.call_function('wp_create_nonce', [
					rt.new_string('closedpostboxes'),
				]) },
				rt.ArrayItem{ key: '_ajax_linking_nonce', val: rt.call_function('wp_create_nonce', [
					rt.new_string('internal-linking'),
				]) },
				rt.ArrayItem{ key: '_wpnonce', val: rt.call_function('wp_create_nonce', [
					rt.new_string('update-post_' + var_post_id.str()),
				]) },
			]) },
		]))
	}
	return var_response.clone()
}

fn wp_refresh_metabox_loader_nonces(var_response rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_received := rt.new_null()
	mut var_post_id := rt.new_null()
	if !rt.is_true(var_data.array_get(rt.new_string('wp-refresh-metabox-loader-nonces'))) {
		return var_response.clone()
	}
	var_received = var_data.array_get(rt.new_string('wp-refresh-metabox-loader-nonces'))
	var_post_id = rt.new_int((var_received.array_get(rt.new_string('post_id'))).to_i64())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
		return var_response.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		var_post_id.clone(),
	])))))
	{
		return var_response.clone()
	}
	var_response.array_set('wp-refresh-metabox-loader-nonces', rt.create_array([
		rt.ArrayItem{ key: 'replace', val: rt.create_array([
			rt.ArrayItem{ key: 'metabox_loader_nonce', val: rt.call_function('wp_create_nonce', [
				rt.new_string('meta-box-loader'),
			]) },
			rt.ArrayItem{ key: '_wpnonce', val: rt.call_function('wp_create_nonce', [
				rt.new_string('update-post_' + var_post_id.str()),
			]) },
		]) },
	]))
	return var_response.clone()
}

fn wp_refresh_heartbeat_nonces(var_response rt.PhpVal) rt.PhpVal {
	var_response.array_set('rest_nonce', rt.call_function('wp_create_nonce', [
		rt.new_string('wp_rest'),
	]))
	var_response.array_set('heartbeat_nonce', rt.call_function('wp_create_nonce', [
		rt.new_string('heartbeat-nonce'),
	]))
	return var_response.clone()
}

fn wp_heartbeat_set_suspension(var_settings rt.PhpVal) rt.PhpVal {
	mut var_pagenow := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('post.php'), var_pagenow))
		|| rt.is_true(rt.identical(rt.new_string('post-new.php'), var_pagenow)) {
		var_settings['suspension'] = 'disable'
	}
	return var_settings.clone()
}

fn heartbeat_autosave(var_response rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_saved := rt.new_null()
	mut var_draft_saved_date_format := rt.new_null()
	if !(!rt.is_true(var_data.array_get(rt.new_string('wp_autosave')))) {
		var_saved = rt.call_function('wp_autosave', [
			var_data.array_get(rt.new_string('wp_autosave')),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_saved.clone()])) {
			var_response.array_set('wp_autosave', rt.create_array([
				rt.ArrayItem{ key: 'success', val: false },
				rt.ArrayItem{ key: 'message', val: rt.call_method(var_saved, 'get_error_message',
					[]rt.PhpVal{}) },
			]))
		} else if !rt.is_true(var_saved) {
			var_response.array_set('wp_autosave', rt.create_array([
				rt.ArrayItem{ key: 'success', val: false },
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('Error while saving.'),
				]) },
			]))
		} else {
			var_draft_saved_date_format = rt.call_function('__', [
				rt.new_string('g:i:s a'),
			])
			var_response.array_set('wp_autosave', rt.create_array([
				rt.ArrayItem{ key: 'success', val: true },
				rt.ArrayItem{ key: 'message', val: rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('Draft saved at %s.')]),
					rt.call_function('date_i18n', [var_draft_saved_date_format.clone()]),
				]) },
			]))
		}
	}
	return var_response.clone()
}

fn wp_admin_canonical_url() {
	mut var_removable_query_args := rt.new_null()
	mut var_current_url := rt.new_null()
	mut var_filtered_url := rt.new_null()
	var_removable_query_args = rt.call_function('wp_removable_query_args', []rt.PhpVal{})
	if !rt.is_true(var_removable_query_args) {
		return
	}
	var_current_url = rt.call_function('set_url_scheme', [
		rt.new_string('http://' +
			(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_HOST'))).str() +
			(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))).str()),
	])
	var_filtered_url = rt.call_function('remove_query_arg', [
		var_removable_query_args.clone(), var_current_url.clone()])
	var_filtered_url = rt.call_function('apply_filters', [
		rt.new_string('wp_admin_canonical_url'),
		var_filtered_url.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_filtered_url.clone()]))
	// unsupported statement: Stmt_InlineHTML
}

fn wp_page_reload_on_back_button_js() {
	// unsupported statement: Stmt_InlineHTML
}

fn update_option_new_admin_email(var_old_value rt.PhpVal, var_value rt.PhpVal) {
	mut var_hash := ''
	mut var_new_admin_email := map[string]rt.PhpVal{}
	mut var_switched_locale := rt.new_null()
	mut var_email_text := rt.new_null()
	mut var_content := rt.new_null()
	mut var_current_user := rt.new_null()
	mut var_site_title := rt.new_null()
	mut var_subject := rt.new_null()
	if rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('admin_email')]), var_value))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [var_value.clone()]))))) {
		return
	}
	var_hash = md5.hexhash(var_value.str() + (rt.call_function('time', []rt.PhpVal{})).str() +
		(rt.call_function('wp_rand', []rt.PhpVal{})).str())
	var_new_admin_email = {
		'hash':     rt.new_string(var_hash.str())
		'newemail': var_value
	}
	rt.call_function('update_option', [rt.new_string('adminhash'),
		rt.create_array_from_native_map(var_new_admin_email),
		rt.new_bool(false)])
	var_switched_locale = rt.call_function('switch_to_user_locale', [
		rt.call_function('get_current_user_id', []rt.PhpVal{}),
	])
	var_email_text = rt.call_function('__', [
		rt.new_string('Howdy,\n\nA site administrator (###USERNAME###) recently requested to have the\nadministration email address changed on this site:\n###SITEURL###\n\nTo confirm this change, please click on the following link:\n###ADMIN_URL###\n\nYou can safely ignore and delete this email if you do not want to\ntake this action.\n\nThis email has been sent to ###EMAIL###\n\nRegards,\nAll at ###SITENAME###\n###SITEURL###'),
	])
	var_content = rt.call_function('apply_filters', [
		rt.new_string('new_admin_email_content'),
		var_email_text.clone(),
		rt.create_array_from_native_map(var_new_admin_email),
	])
	var_current_user = rt.call_function('wp_get_current_user', []rt.PhpVal{})
	var_content = rt.call_function('str_replace', [rt.new_string('###USERNAME###'),
		rt.get_property(var_current_user, 'user_login'), var_content.clone()])
	var_content = rt.call_function('str_replace', [rt.new_string('###ADMIN_URL###'),
		rt.call_function('esc_url', [
			rt.call_function('self_admin_url', [
				rt.new_string('options.php?adminhash=' + var_hash),
			]),
		]),
		var_content.clone()])
	var_content = rt.call_function('str_replace', [rt.new_string('###EMAIL###'),
		var_value.clone(), var_content.clone()])
	var_content = rt.call_function('str_replace', [rt.new_string('###SITENAME###'),
		rt.call_function('wp_specialchars_decode', [
			rt.call_function('get_option', [rt.new_string('blogname')]),
			rt.get_constant('ENT_QUOTES'),
		]),
		var_content.clone()])
	var_content = rt.call_function('str_replace', [rt.new_string('###SITEURL###'),
		rt.call_function('home_url', []rt.PhpVal{}), var_content.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.call_function('get_option', [
		rt.new_string('blogname'),
	])))))
	{
		var_site_title = rt.call_function('wp_specialchars_decode', [
			rt.call_function('get_option', [rt.new_string('blogname')]),
			rt.get_constant('ENT_QUOTES'),
		])
	} else {
		var_site_title = rt.call_function('parse_url', [
			rt.call_function('home_url', []rt.PhpVal{}),
			rt.get_constant('PHP_URL_HOST'),
		])
	}
	var_subject = rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('[%s] New Admin Email Address')]),
		var_site_title.clone(),
	])
	var_subject = rt.call_function('apply_filters', [
		rt.new_string('new_admin_email_subject'),
		var_subject.clone(),
	])
	rt.call_function('wp_mail', [var_value.clone(), var_subject.clone(),
		var_content.clone()])
	if rt.is_true(var_switched_locale) {
		rt.call_function('restore_previous_locale', []rt.PhpVal{})
	}
}

fn _wp_privacy_settings_filter_draft_page_titles(var_title_arg rt.PhpVal, var_page rt.PhpVal) rt.PhpVal {
	mut var_title := var_title_arg
	if rt.is_true(rt.identical(rt.new_string('draft'), rt.get_property(var_page, 'post_status')))
		&& rt.is_true(rt.identical(rt.new_string('privacy'), rt.get_property(rt.call_function('get_current_screen', []rt.PhpVal{}), 'id'))) {
		var_title = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s (Draft)')]),
			var_title.clone(),
		])
	}
	return var_title.clone()
}

fn wp_check_php_version() bool {
	mut var_version := rt.new_null()
	mut var_key := ''
	mut var_response := rt.new_null()
	mut var_url := rt.new_null()
	var_version = rt.get_constant('PHP_VERSION')
	var_key = md5.hexhash(var_version.clone().to_string())
	var_response = rt.call_function('get_site_transient', [
		rt.new_string('php_check_' + var_key),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_response)) {
		var_url = rt.new_string('http://api.wordpress.org/core/serve-happy/1.0/')
		if rt.is_true(rt.call_function('wp_http_supports', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'ssl' }]),
		]))
		{
			var_url = rt.call_function('set_url_scheme', [var_url.clone(),
				rt.new_string('https')])
		}
		var_url = rt.call_function('add_query_arg', [rt.new_string('php_version'),
			var_version.clone(), var_url.clone()])
		var_response = rt.call_function('wp_remote_get', [var_url.clone()])
		if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()]))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), rt.call_function('wp_remote_retrieve_response_code', [var_response.clone()]))))) {
			return false
		}
		var_response = rt.call_function('json_decode', [
			rt.call_function('wp_remote_retrieve_body', [var_response.clone()]),
			rt.new_bool(true),
		])
		if !(var_response.clone().is_array()) {
			return false
		}
		rt.call_function('set_site_transient', [rt.new_string('php_check_' + var_key),
			var_response.clone(), rt.get_constant('WEEK_IN_SECONDS')])
	}
	if var_response.array_isset(rt.new_string('is_acceptable'))
		&& rt.is_true(var_response.array_get(rt.new_string('is_acceptable'))) {
		var_response.array_set('is_acceptable', (rt.call_function('apply_filters', [
			rt.new_string('wp_is_php_version_acceptable'),
			rt.new_bool(true),
			var_version.clone(),
		])).to_bool())
	}
	var_response.array_set('is_lower_than_future_minimum', false)
	if rt.is_true(rt.call_function('version_compare', [var_version.clone(),
		rt.new_string('8.0'), rt.new_string('<')]))
	{
		var_response.array_set('is_lower_than_future_minimum', true)
		var_response.array_set('is_acceptable', false)
	}
	return var_response.to_bool()
}

struct Class_DOMDocument {
	rt.PhpObjectBase
}

struct Class_DOMXPath {
	rt.PhpObjectBase
}

fn create_domdocument(_args ...rt.PhpVal) &Class_DOMDocument {
	mut obj := &Class_DOMDocument{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_domxpath(_args ...rt.PhpVal) &Class_DOMXPath {
	mut obj := &Class_DOMXPath{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_DOMDocument) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DOMDocument) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DOMDocument) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_DOMXPath) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DOMXPath) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DOMXPath) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
