import rt

fn get_file_description(var_file rt.PhpVal) string {
	mut var_wp_file_descriptions := rt.new_null()
	mut var_allowed_files := rt.new_null()
	mut var_name := []rt.PhpVal{}
	// unsupported statement: Stmt_Global
	mut var_dirname := rt.call_function('pathinfo', [var_file.dup(), rt.get_constant('PATHINFO_DIRNAME')])
	mut var_file_path := var_allowed_files.array_get(var_file)
	if rt.is_true(rt.new_bool(var_wp_file_descriptions.array_isset(rt.call_function('basename', [var_file.dup()])) && rt.is_true(rt.identical(rt.new_string('.'), var_dirname)))) {
		return (var_wp_file_descriptions.array_get(rt.call_function('basename', [var_file.dup()]))).str()
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('file_exists', [var_file_path.dup()])) && rt.is_true(rt.call_function('is_file', [var_file_path.dup()])))) {
		mut var_template_data := rt.call_function('implode', [rt.new_string(''), rt.call_function('file', [var_file_path.dup()])])
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('|Template Name:(.*)$|mi'), var_template_data.dup(), var_name.dup()])) {
			return (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s Page Template')]), rt.call_function('_cleanup_header_comment', [var_name.array_get(1)])])).str()
		}
	}
	return rt.call_function('basename', [var_file.dup()]).to_string().trim_space()
}

fn get_home_path() rt.PhpVal {
	mut var_home := rt.call_function('set_url_scheme', [rt.call_function('get_option', [rt.new_string('home')]), rt.new_string('http')])
	mut var_siteurl := rt.call_function('set_url_scheme', [rt.call_function('get_option', [rt.new_string('siteurl')]), rt.new_string('http')])
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_home)) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		mut var_wp_path_rel_to_home := rt.call_function('str_ireplace', [var_home.dup(), rt.new_string(''), var_siteurl.dup()])
		mut var_pos := rt.call_function('strripos', [rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('/'), rt.get_superglobal('_SERVER').array_get('SCRIPT_FILENAME')]), rt.call_function('trailingslashit', [var_wp_path_rel_to_home.dup()])])
		mut var_home_path := rt.call_function('substr', [rt.get_superglobal('_SERVER').array_get('SCRIPT_FILENAME'), rt.new_int(0), var_pos.dup()])
		var_home_path = rt.call_function('trailingslashit', [var_home_path.dup()])
	} else {
		var_home_path = rt.get_constant('ABSPATH')
	}
	return rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('/'), var_home_path.dup()])
}

fn list_files(folder string, levels i64, var_exclusions rt.PhpVal, include_hidden bool) bool {
	if folder == '' {
		return false
	}
	folder = (rt.call_function('trailingslashit', [rt.new_string(folder)])).str()
	if !(var_levels != 0) {
		return false
	}
	mut var_files := rt.new_array()
	mut var_dir := rt.call_function('opendir', [rt.new_string(folder)])
	if rt.is_true(var_dir) {
		for rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			if rt.is_true(rt.call_function('in_array', [var_file.dup(), rt.create_array([rt.ArrayItem{ key: none, val: '.' }, rt.ArrayItem{ key: none, val: '..' }]), rt.new_bool(true)])) {
				continue
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(var_include_hidden) && rt.is_true(rt.identical(rt.new_string('.'), var_file.array_get(0))))) || rt.is_true(rt.call_function('in_array', [var_file.dup(), var_exclusions.dup(), rt.new_bool(true)])))) {
				continue
			}
			if rt.is_true(rt.call_function('is_dir', [folder + (var_file).str()])) {
				mut var_files2 := rt.new_bool(rt.new_bool(list_files(folder + (var_file).str(), levels - 1, rt.new_array(), include_hidden)))
				if rt.is_true(var_files2) {
					var_files = rt.call_function('array_merge', [var_files.dup(), var_files2.dup()])
				} else {
					var_files.array_push(folder + (var_file).str() + '/')
				}
			} else {
				var_files.array_push(folder + (var_file).str())
			}
		}
		rt.call_function('closedir', [var_dir.dup()])
	}
	return (var_files).to_bool()
}

fn wp_get_plugin_file_editable_extensions(var_plugin rt.PhpVal) rt.PhpVal {
	mut var_default_types := ['bash', 'conf', 'css', 'diff', 'htm', 'html', 'http', 'inc', 'include', 'js', 'mjs', 'json', 'jsx', 'less', 'md', 'patch', 'php', 'php3', 'php4', 'php5', 'php7', 'phps', 'phtml', 'sass', 'scss', 'sh', 'sql', 'svg', 'text', 'txt', 'xml', 'yaml', 'yml']
	mut var_file_types := rt.cast_array(rt.call_function('apply_filters', [rt.new_string('editable_extensions'), var_default_types.dup(), var_plugin.dup()]))
	return var_file_types.dup()
}

fn wp_get_theme_file_editable_extensions(var_theme rt.PhpVal) rt.PhpVal {
	mut var_default_types := ['bash', 'conf', 'css', 'diff', 'htm', 'html', 'http', 'inc', 'include', 'js', 'mjs', 'json', 'jsx', 'less', 'md', 'patch', 'php', 'php3', 'php4', 'php5', 'php7', 'phps', 'phtml', 'sass', 'scss', 'sh', 'sql', 'svg', 'text', 'txt', 'xml', 'yaml', 'yml']
	mut var_file_types := rt.call_function('apply_filters', [rt.new_string('wp_theme_editor_filetypes'), var_default_types.dup(), var_theme.dup()])
	return rt.call_function('array_unique', [rt.call_function('array_merge', [var_file_types.dup(), var_default_types.dup()])])
}

fn wp_print_file_editor_templates() {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('__', [rt.new_string('Your PHP code changes were not applied due to an error on line %1$s of file %2$s. Please fix and try saving again.')]), rt.new_string('{{ data.line }}'), rt.new_string('{{ data.file }}')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('__', [rt.new_string('You need to make this file writable before you can save your changes. See <a href="%s">Changing File Permissions</a> for more information.')]), rt.call_function('__', [rt.new_string('https://developer.wordpress.org/advanced-administration/server/file-permissions/')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Update anyway, even though it might break your site?')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Dismiss')])
	// unsupported statement: Stmt_InlineHTML
}

fn wp_edit_theme_plugin_file(var_args rt.PhpVal) bool {
	mut var_matches := []rt.PhpVal{}
	if !rt.is_true(var_args.array_get('file')) {
		return (create_wp_error(rt.new_string('missing_file'))).to_bool()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (create_wp_error(rt.new_string('bad_file'))).to_bool()
	}
	if !(var_args.array_isset(rt.new_string('newcontent'))) {
		return (create_wp_error(rt.new_string('missing_content'))).to_bool()
	}
	if !(var_args.array_isset(rt.new_string('nonce'))) {
		return (create_wp_error(rt.new_string('missing_nonce'))).to_bool()
	}
	mut var_file := var_args.array_get('file')
	mut var_content := var_args.array_get('newcontent')
	mut var_plugin := rt.new_null()
	mut var_theme := rt.new_null()
	mut var_real_file := rt.new_null()
	if !(!rt.is_true(var_args.array_get('plugin'))) {
		var_plugin = var_args.array_get('plugin')
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_plugins')]))))) {
			return (create_wp_error(rt.new_string('unauthorized'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit plugins for this site.')]))).to_bool()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [var_args.array_get('nonce'), 'edit-plugin_' + (var_file).str()]))))) {
			return (create_wp_error(rt.new_string('nonce_failure'))).to_bool()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.call_function('get_plugins', []rt.PhpVal{}).array_isset(var_plugin.dup())))))) {
			return (create_wp_error(rt.new_string('invalid_plugin'))).to_bool()
		}
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			return (create_wp_error(rt.new_string('bad_plugin_file_path'), rt.call_function('__', [rt.new_string('Sorry, that file cannot be edited.')]))).to_bool()
		}
		mut var_editable_extensions := wp_get_plugin_file_editable_extensions(var_plugin.dup())
		var_real_file = rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + (var_file).str())
		mut var_is_active := rt.call_function('in_array', [var_plugin.dup(), rt.cast_array(rt.call_function('get_option', [rt.new_string('active_plugins'), rt.new_array()])), rt.new_bool(true)])
	} else if !(!rt.is_true(var_args.array_get('theme'))) {
		mut var_stylesheet := var_args.array_get('theme')
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			return (create_wp_error(rt.new_string('bad_theme_path'))).to_bool()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_themes')]))))) {
			return (create_wp_error(rt.new_string('unauthorized'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit templates for this site.')]))).to_bool()
		}
		var_theme = rt.call_function('wp_get_theme', [var_stylesheet.dup()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_theme, 'exists', []rt.PhpVal{}))))) {
			return (create_wp_error(rt.new_string('non_existent_theme'), rt.call_function('__', [rt.new_string('The requested theme does not exist.')]))).to_bool()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [var_args.array_get('nonce'), 'edit-theme_' + (var_stylesheet).str() + '_' + (var_file).str()]))))) {
			return (create_wp_error(rt.new_string('nonce_failure'))).to_bool()
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_theme, 'errors', []rt.PhpVal{})) && rt.is_true(rt.identical(rt.new_string('theme_no_stylesheet'), rt.call_method(rt.call_method(var_theme, 'errors', []rt.PhpVal{}), 'get_error_code', []rt.PhpVal{}))))) {
			return (create_wp_error(rt.new_string('theme_no_stylesheet'), (rt.call_function('__', [rt.new_string('The requested theme does not exist.')])).str() + ' ' + (rt.call_method(rt.call_method(var_theme, 'errors', []rt.PhpVal{}), 'get_error_message', []rt.PhpVal{})).str())).to_bool()
		}
		var_editable_extensions = wp_get_theme_file_editable_extensions(var_theme.dup())
		mut var_allowed_files := rt.new_array()
		{
			mut iter_1 := var_editable_extensions.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_type := item_1.val
				mut switch_val_1 := var_type
				if rt.is_true(rt.equal(switch_val_1, rt.new_string('php'))) {
					var_allowed_files = rt.call_function('array_merge', [var_allowed_files.dup(), rt.call_method(var_theme, 'get_files', [rt.new_string('php'), // unsupported expression: Expr_UnaryMinus])])
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('css'))) {
					mut var_style_files := rt.call_method(var_theme, 'get_files', [rt.new_string('css'), // unsupported expression: Expr_UnaryMinus])
					var_allowed_files.array_set('style.css', var_style_files.array_get('style.css'))
					var_allowed_files = rt.call_function('array_merge', [var_allowed_files.dup(), var_style_files.dup()])
				} else {
					var_allowed_files = rt.call_function('array_merge', [var_allowed_files.dup(), rt.call_method(var_theme, 'get_files', [var_type.dup(), // unsupported expression: Expr_UnaryMinus])])
				}
			}
		}
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			return (create_wp_error(rt.new_string('disallowed_theme_file'), rt.call_function('__', [rt.new_string('Sorry, that file cannot be edited.')]))).to_bool()
		}
		var_real_file = rt.new_string((rt.call_method(var_theme, 'get_stylesheet_directory', []rt.PhpVal{})).str() + '/' + (var_file).str())
		var_is_active = rt.new_bool(rt.new_bool(rt.is_true(rt.identical(rt.call_function('get_stylesheet', []rt.PhpVal{}), var_stylesheet)) || rt.is_true(rt.identical(rt.call_function('get_template', []rt.PhpVal{}), var_stylesheet))))
	} else {
		return (create_wp_error(rt.new_string('missing_theme_or_plugin'))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_file', [var_real_file.dup()]))))) {
		return (create_wp_error(rt.new_string('file_does_not_exist'), rt.call_function('__', [rt.new_string('File does not exist! Please double check the name and try again.')]))).to_bool()
	}
	mut var_extension := rt.new_null()
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/\\.([^.]+)$/'), var_real_file.dup(), var_matches.dup()])) {
		var_extension = rt.new_string(rt.new_string(var_matches.array_get(1).to_string().to_lower()))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_extension.dup(), var_editable_extensions.dup(), rt.new_bool(true)]))))) {
			return (create_wp_error(rt.new_string('illegal_file_type'), rt.call_function('__', [rt.new_string('Files of this type are not editable.')]))).to_bool()
		}
	}
	mut var_previous_content := rt.call_function('file_get_contents', [var_real_file.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_writable', [var_real_file.dup()]))))) {
		return (create_wp_error(rt.new_string('file_not_writable'))).to_bool()
	}
	mut var_f := rt.call_function('fopen', [var_real_file.dup(), rt.new_string('w+')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_f)) {
		return (create_wp_error(rt.new_string('file_not_writable'))).to_bool()
	}
	mut var_written := rt.call_function('fwrite', [.dup(), .dup()])
	rt.call_function('fclose', [.dup()])
	if rt.is_true() {
	}
	
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
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


fn init_registry() {
	rt.register_func('get_file_description', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(get_file_description(arg_0))
	})
	rt.register_func('get_home_path', fn(args []rt.PhpVal) rt.PhpVal {
		return get_home_path()
	})
	rt.register_func('list_files', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
		return rt.new_bool(list_files(arg_0, arg_1, arg_2, arg_3))
	})
	rt.register_func('wp_get_plugin_file_editable_extensions', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_get_plugin_file_editable_extensions(arg_0)
	})
	rt.register_func('wp_get_theme_file_editable_extensions', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_get_theme_file_editable_extensions(arg_0)
	})
	rt.register_func('wp_print_file_editor_templates', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_print_file_editor_templates()
	})
	rt.register_func('wp_edit_theme_plugin_file', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(wp_edit_theme_plugin_file(arg_0))
	})
	rt.register_func('wp_tempnam', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return wp_tempnam(arg_0, arg_1)
	})
	rt.register_func('validate_file_to_edit', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return validate_file_to_edit(arg_0, arg_1)
	})
	rt.register_func('_wp_handle_upload', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		return _wp_handle_upload(arg_0, arg_1, arg_2, arg_3)
	})
	rt.register_func('wp_handle_upload_error', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wp_handle_upload_error(arg_0, arg_1)
	})
	rt.register_func('wp_handle_upload', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return wp_handle_upload(arg_0, arg_1, arg_2)
	})
	rt.register_func('wp_handle_sideload', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return wp_handle_sideload(arg_0, arg_1, arg_2)
	})
	rt.register_func('download_url', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		return download_url(arg_0, arg_1, arg_2)
	})
	rt.register_func('verify_file_md5', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(verify_file_md5(arg_0, arg_1))
	})
	rt.register_func('verify_file_signature', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		return rt.new_bool(verify_file_signature(arg_0, arg_1, arg_2))
	})
	rt.register_func('wp_trusted_keys', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_trusted_keys()
	})
	rt.register_func('wp_zip_file_is_valid', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(wp_zip_file_is_valid(arg_0))
	})
	rt.register_func('unzip_file', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return unzip_file(arg_0, arg_1)
	})
	rt.register_func('_unzip_file_ziparchive', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return _unzip_file_ziparchive(arg_0, arg_1, arg_2)
	})
	rt.register_func('_unzip_file_pclzip', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return _unzip_file_pclzip(arg_0, arg_1, arg_2)
	})
	rt.register_func('copy_dir', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rt.new_bool(copy_dir(arg_0, arg_1, arg_2))
	})
	rt.register_func('move_dir', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		return rt.new_bool(move_dir(arg_0, arg_1, arg_2))
	})
	rt.register_func('WP_Filesystem', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		return WP_Filesystem(arg_0, arg_1, arg_2)
	})
	rt.register_func('get_filesystem_method', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		return get_filesystem_method(arg_0, arg_1, arg_2)
	})
	rt.register_func('request_filesystem_credentials', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
		arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).to_bool()
		return rt.new_bool(request_filesystem_credentials(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5))
	})
	rt.register_func('wp_print_request_filesystem_credentials_modal', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_print_request_filesystem_credentials_modal()
	})
	rt.register_func('wp_opcache_invalidate', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		return rt.new_bool(wp_opcache_invalidate(arg_0, arg_1))
	})
	rt.register_func('wp_opcache_invalidate_directory', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_opcache_invalidate_directory(arg_0)
	})
	rt.register_class_factory('WP_Error', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_error()
		return rt.new_object('WP_Error', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_admin_includes_file_php() {
	mut var_wp_file_descriptions := rt.create_array([rt.ArrayItem{ key: 'functions.php', val: rt.call_function('__', [rt.new_string('Theme Functions')]) }, rt.ArrayItem{ key: 'header.php', val: rt.call_function('__', [rt.new_string('Theme Header')]) }, rt.ArrayItem{ key: 'footer.php', val: rt.call_function('__', [rt.new_string('Theme Footer')]) }, rt.ArrayItem{ key: 'sidebar.php', val: rt.call_function('__', [rt.new_string('Sidebar')]) }, rt.ArrayItem{ key: 'comments.php', val: rt.call_function('__', [rt.new_string('Comments')]) }, rt.ArrayItem{ key: 'searchform.php', val: rt.call_function('__', [rt.new_string('Search Form')]) }, rt.ArrayItem{ key: '404.php', val: rt.call_function('__', [rt.new_string('404 Template')]) }, rt.ArrayItem{ key: 'link.php', val: rt.call_function('__', [rt.new_string('Links Template')]) }, rt.ArrayItem{ key: 'theme.json', val: rt.call_function('__', [rt.new_string('Theme Styles & Block Settings')]) }, rt.ArrayItem{ key: 'index.php', val: rt.call_function('__', [rt.new_string('Main Index Template')]) }, rt.ArrayItem{ key: 'archive.php', val: rt.call_function('__', [rt.new_string('Archives')]) }, rt.ArrayItem{ key: 'author.php', val: rt.call_function('__', [rt.new_string('Author Template')]) }, rt.ArrayItem{ key: 'taxonomy.php', val: rt.call_function('__', [rt.new_string('Taxonomy Template')]) }, rt.ArrayItem{ key: 'category.php', val: rt.call_function('__', [rt.new_string('Category Template')]) }, rt.ArrayItem{ key: 'tag.php', val: rt.call_function('__', [rt.new_string('Tag Template')]) }, rt.ArrayItem{ key: 'home.php', val: rt.call_function('__', [rt.new_string('Posts Page')]) }, rt.ArrayItem{ key: 'search.php', val: rt.call_function('__', [rt.new_string('Search Results')]) }, rt.ArrayItem{ key: 'date.php', val: rt.call_function('__', [rt.new_string('Date Template')]) }, rt.ArrayItem{ key: 'singular.php', val: rt.call_function('__', [rt.new_string('Singular Template')]) }, rt.ArrayItem{ key: 'single.php', val: rt.call_function('__', [rt.new_string('Single Post')]) }, rt.ArrayItem{ key: 'page.php', val: rt.call_function('__', [rt.new_string('Single Page')]) }, rt.ArrayItem{ key: 'front-page.php', val: rt.call_function('__', [rt.new_string('Homepage')]) }, rt.ArrayItem{ key: 'privacy-policy.php', val: rt.call_function('__', [rt.new_string('Privacy Policy Page')]) }, rt.ArrayItem{ key: 'attachment.php', val: rt.call_function('__', [rt.new_string('Attachment Template')]) }, rt.ArrayItem{ key: 'image.php', val: rt.call_function('__', [rt.new_string('Image Attachment Template')]) }, rt.ArrayItem{ key: 'video.php', val: rt.call_function('__', [rt.new_string('Video Attachment Template')]) }, rt.ArrayItem{ key: 'audio.php', val: rt.call_function('__', [rt.new_string('Audio Attachment Template')]) }, rt.ArrayItem{ key: 'application.php', val: rt.call_function('__', [rt.new_string('Application Attachment Template')]) }, rt.ArrayItem{ key: 'embed.php', val: rt.call_function('__', [rt.new_string('Embed Template')]) }, rt.ArrayItem{ key: 'embed-404.php', val: rt.call_function('__', [rt.new_string('Embed 404 Template')]) }, rt.ArrayItem{ key: 'embed-content.php', val: rt.call_function('__', [rt.new_string('Embed Content Template')]) }, rt.ArrayItem{ key: 'header-embed.php', val: rt.call_function('__', [rt.new_string('Embed Header Template')]) }, rt.ArrayItem{ key: 'footer-embed.php', val: rt.call_function('__', [rt.new_string('Embed Footer Template')]) }, rt.ArrayItem{ key: 'style.css', val: rt.call_function('__', [rt.new_string('Stylesheet')]) }, rt.ArrayItem{ key: 'editor-style.css', val: rt.call_function('__', [rt.new_string('Visual Editor Stylesheet')]) }, rt.ArrayItem{ key: 'editor-style-rtl.css', val: rt.call_function('__', [rt.new_string('Visual Editor RTL Stylesheet')]) }, rt.ArrayItem{ key: 'rtl.css', val: rt.call_function('__', [rt.new_string('RTL Stylesheet')]) }, rt.ArrayItem{ key: 'my-hacks.php', val: rt.call_function('__', [rt.new_string('my-hacks.php (legacy hacks support)')]) }, rt.ArrayItem{ key: '.htaccess', val: rt.call_function('__', [rt.new_string('.htaccess (for rewrite rules )')]) }, rt.ArrayItem{ key: 'wp-layout.css', val: rt.call_function('__', [rt.new_string('Stylesheet')]) }, rt.ArrayItem{ key: 'wp-comments.php', val: rt.call_function('__', [rt.new_string('Comments Template')]) }, rt.ArrayItem{ key: 'wp-comments-popup.php', val: rt.call_function('__', [rt.new_string('Popup Comments Template')]) }, rt.ArrayItem{ key: 'comments-popup.php', val: rt.call_function('__', [rt.new_string('Popup Comments')]) }])
}
