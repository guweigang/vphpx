import rt

fn got_mod_rewrite() rt.PhpVal {
	mut var_got_rewrite := rt.call_function('apache_mod_loaded', [rt.new_string('mod_rewrite'), rt.new_bool(true)])
	return rt.call_function('apply_filters', [rt.new_string('got_rewrite'), var_got_rewrite.dup()])
}

fn got_url_rewrite() rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	mut var_got_url_rewrite := rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(got_mod_rewrite()) || rt.is_true(var_GLOBALS.array_get('is_nginx')))) || rt.is_true(var_GLOBALS.array_get('is_caddy')))) || rt.is_true(rt.call_function('iis7_supports_permalinks', []rt.PhpVal{}))
	return rt.call_function('apply_filters', [rt.new_string('got_url_rewrite'), rt.new_bool(var_got_url_rewrite).dup()])
}

fn extract_from_markers(var_filename rt.PhpVal, var_marker rt.PhpVal) rt.PhpVal {
	mut var_result := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_filename.dup()]))))) {
		return var_result.dup()
	}
	mut var_markerdata := rt.call_function('explode', [rt.new_string('\n'), rt.call_function('implode', [rt.new_string(''), rt.call_function('file', [var_filename.dup()])])])
	mut var_state := false
	{
		mut iter_1 := var_markerdata.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_markerline := item_1.val
			if rt.is_true(rt.call_function('str_contains', [var_markerline.dup(), '# END ' + (var_marker).str()])) {
				var_state = false
			}
			if var_state {
				if rt.is_true(rt.call_function('str_starts_with', [var_markerline.dup(), rt.new_string('#')])) {
					continue
				}
				var_result << var_markerline.dup()
			}
			if rt.is_true(rt.call_function('str_contains', [var_markerline.dup(), '# BEGIN ' + (var_marker).str()])) {
				var_state = true
			}
		}
	}
	return var_result.dup()
}

fn insert_with_markers(var_filename rt.PhpVal, marker string, var_insertion rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_filename.dup()]))))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_writable', [rt.call_function('dirname', [var_filename.dup()])]))))) {
			return false
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('touch', [var_filename.dup()]))))) {
			return false
		}
		mut var_perms := rt.call_function('fileperms', [var_filename.dup()])
		if rt.is_true(var_perms) {
			rt.call_function('chmod', [var_filename.dup(), rt.bitwise_or(var_perms, rt.new_int(420))])
		}
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_writable', [var_filename.dup()]))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_insertion.dup().is_array()))))) {
		var_insertion = rt.call_function('explode', [rt.new_string('\n'), var_insertion.dup()])
	}
	mut var_switched_locale := rt.call_function('switch_to_locale', [rt.call_function('get_locale', []rt.PhpVal{})])
	mut var_instructions := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The directives (lines) between "BEGIN %1$s" and "END %1$s" are\ndynamically generated, and should only be modified via WordPress filters.\nAny changes to the directives between these markers will be overwritten.')]), rt.new_string(marker)])
	var_instructions = rt.call_function('explode', [rt.new_string('\n'), var_instructions.dup()])
	{
		mut iter_1 := var_instructions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_text := item_1.val
			mut var_line := item_1.key
			var_instructions.array_set(var_line, '# ' + (var_text).str())
		}
	}
	var_instructions = rt.call_function('apply_filters', [rt.new_string('insert_with_markers_inline_instructions'), var_instructions.dup(), rt.new_string(marker)])
	if rt.is_true(var_switched_locale) {
		rt.call_function('restore_previous_locale', []rt.PhpVal{})
	}
	var_insertion = rt.call_function('array_merge', [var_instructions.dup(), var_insertion.dup()])
	mut var_start_marker := "# BEGIN ${var_marker}"
	mut var_end_marker := "# END ${var_marker}"
	mut var_fp := rt.call_function('fopen', [var_filename.dup(), rt.new_string('r+')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_fp)))) {
		return false
	}
	rt.call_function('flock', [var_fp.dup(), rt.get_constant('LOCK_EX')])
	mut var_lines := []rt.PhpVal{}
	for rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('feof', [var_fp.dup()]))))) {
		var_lines << rt.call_function('fgets', [var_fp.dup()]).to_string().trim_right(' \t\n\r')
	}
	mut var_pre_lines := []rt.PhpVal{}
	mut var_post_lines := []rt.PhpVal{}
	mut var_existing_lines := []rt.PhpVal{}
	mut var_found_marker := false
	mut var_found_end_marker := false
	for var_line in var_lines {
		if rt.is_true(rt.new_bool(!(var_found_marker) && rt.is_true(rt.call_function('str_contains', [rt.new_string(line), rt.new_string(var_start_marker).dup()])))) {
			var_found_marker = true
			continue
		} else if rt.is_true(rt.new_bool(!(var_found_end_marker) && rt.is_true(rt.call_function('str_contains', [rt.new_string(line), rt.new_string(var_end_marker).dup()])))) {
			var_found_end_marker = true
			continue
		}
		if !(var_found_marker) {
			var_pre_lines << rt.new_string(line).dup()
		} else if var_found_end_marker {
			var_post_lines << rt.new_string(line).dup()
		} else {
			var_existing_lines << rt.new_string(line).dup()
		}
	}
	if rt.is_true(rt.identical(var_existing_lines, var_insertion)) {
		rt.call_function('flock', [var_fp.dup(), rt.get_constant('LOCK_UN')])
		rt.call_function('fclose', [var_fp.dup()])
		return true
	}
	mut var_new_file_data := rt.call_function('implode', [rt.new_string('\n'), rt.call_function('array_merge', [var_pre_lines.dup(), rt.create_array([rt.ArrayItem{ key: none, val: var_start_marker }]), var_insertion.dup(), rt.create_array([rt.ArrayItem{ key: none, val: var_end_marker }]), var_post_lines.dup()])])
	rt.call_function('fseek', [var_fp.dup(), rt.new_int(0)])
	mut var_bytes := rt.call_function('fwrite', [var_fp.dup(), var_new_file_data.dup()])
	if rt.is_true(var_bytes) {
		rt.call_function('ftruncate', [var_fp.dup(), rt.call_function('ftell', [var_fp.dup()])])
	}
	rt.call_function('fflush', [var_fp.dup()])
	rt.call_function('flock', [var_fp.dup(), rt.get_constant('LOCK_UN')])
	rt.call_function('fclose', [var_fp.dup()])
	return (// unsupported expression: Expr_Cast_Bool).to_bool()
}

fn save_mod_rewrite_rules() rt.PhpVal {
	mut var_wp_rewrite := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		return rt.new_null()
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
	mut var_home_path := rt.call_function('get_home_path', []rt.PhpVal{})
	mut var_htaccess_file := rt.new_string((var_home_path).str() + '.htaccess')
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_htaccess_file.dup()]))))) && rt.is_true(rt.call_function('is_writable', [var_home_path.dup()])))) && rt.is_true(rt.call_method(var_wp_rewrite, 'using_mod_rewrite_permalinks', []rt.PhpVal{})))) || rt.is_true(rt.call_function('is_writable', [var_htaccess_file.dup()])))) {
		if rt.is_true(got_mod_rewrite()) {
			mut var_rules := rt.call_function('explode', [rt.new_string('\n'), rt.call_method(var_wp_rewrite, 'mod_rewrite_rules', []rt.PhpVal{})])
			return rt.new_bool(insert_with_markers(var_htaccess_file.dup(), 'WordPress', var_rules.dup()))
		}
	}
	return rt.new_bool(false)
}

fn iis7_save_url_rewrite_rules() rt.PhpVal {
	mut var_wp_rewrite := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		return rt.new_null()
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
	mut var_home_path := rt.call_function('get_home_path', []rt.PhpVal{})
	mut var_web_config_file := rt.new_string((var_home_path).str() + 'web.config')
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('iis7_supports_permalinks', []rt.PhpVal{})) && rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_web_config_file.dup()]))))) && rt.is_true(rt.call_function('win_is_writable', [var_home_path.dup()])))) && rt.is_true(rt.call_method(var_wp_rewrite, 'using_mod_rewrite_permalinks', []rt.PhpVal{})))) || rt.is_true(rt.call_function('win_is_writable', [var_web_config_file.dup()])))))) {
		mut var_rule := rt.call_method(var_wp_rewrite, 'iis7_url_rewrite_rules', [rt.new_bool(false)])
		if !(!rt.is_true(var_rule)) {
			return rt.new_bool(iis7_add_rewrite_rule(var_web_config_file.dup(), var_rule.dup()))
		} else {
			return rt.new_bool(iis7_delete_rewrite_rule(var_web_config_file.dup()))
		}
	}
	return rt.new_bool(false)
}

fn update_recently_edited(var_file rt.PhpVal) {
	mut var_oldfiles := rt.cast_array(rt.call_function('get_option', [rt.new_string('recently_edited')]))
	if rt.is_true(var_oldfiles) {
		var_oldfiles = rt.call_function('array_reverse', [var_oldfiles.dup()])
		var_oldfiles.array_push(var_file.dup())
		var_oldfiles = rt.call_function('array_reverse', [var_oldfiles.dup()])
		var_oldfiles = rt.call_function('array_unique', [var_oldfiles.dup()])
		if 5 < var_oldfiles.dup().array_count() {
			rt.call_function('array_pop', [var_oldfiles.dup()])
		}
	} else {
		var_oldfiles.array_push(var_file.dup())
	}
	rt.call_function('update_option', [rt.new_string('recently_edited'), var_oldfiles.dup()])
}

fn wp_make_theme_file_tree(var_allowed_files rt.PhpVal) rt.PhpVal {
	mut var_tree_list := []rt.PhpVal{}
	{
		mut iter_1 := var_allowed_files.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_absolute_filename := item_1.val
			mut var_file_name := item_1.key
			mut var_list := rt.call_function('explode', [rt.new_string('/'), var_file_name.dup()])
			// unsupported expression: Expr_AssignRef
			{
				mut iter_2 := var_list.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_dir := item_2.val
					// unsupported expression: Expr_AssignRef
				}
			}
			
		}
	}
}



pub fn init_wp_admin_includes_misc_php() {
}
